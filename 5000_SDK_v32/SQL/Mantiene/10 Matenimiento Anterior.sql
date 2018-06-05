/************************ AutoFix *******************/

if exists (select * from sysobjects where id = object_id('dbo.tgUsuarioBC') and sysstat & 0xf = 8) drop trigger dbo.tgUsuarioBC
if exists (select * from sysobjects where id = object_id('dbo.tgUsuarioABC') and sysstat & 0xf = 8) drop trigger dbo.tgUsuarioABC
if exists (select * from sysobjects where id = object_id('dbo.tgUsuarioCfg2C') and sysstat & 0xf = 8) drop trigger dbo.tgUsuarioCfg2C

/*if exists (select * from sysobjects where id = object_id('dbo.spAutoFixReservado') and sysstat & 0xf = 4) drop procedure dbo.spAutoFixReservado
*/
GO
/*
CREATE PROCEDURE spAutoFixReservado
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @Version	int,
    @Ahora	datetime,
    @ID		int, 
    @Renglon	float, 
    @RenglonSub	int, 
    @Cuenta	char(20), 
    @SubCuenta	varchar(20), 
    @Grupo	char(10), 
    @Cantidad	float,
    @Importe	money
  SELECT @Version = Version FROM Version
  SELECT @Ahora = GETDATE()
  BEGIN TRANSACTION
    DECLARE axReservado CURSOR 
        FOR SELECT d.ID, d.Renglon, d.RenglonSub, d.Articulo, d.SubCuenta, e.Almacen,
                   "Diferencia" = ISNULL(d.Cantidad, 0.0) - ISNULL(d.CantidadCancelada, 0.0) - ISNULL(d.CantidadPendiente, 0.0) - ISNULL(d.CantidadReservada, 0.0) - ISNULL(d.CantidadOrdenada, 0.0)
              FROM VentaD d, Venta e
             WHERE e.ID = d.ID AND e.Estatus = 'PENDIENTE' AND (ISNULL(Cantidad, 0.0) - ISNULL(CantidadCancelada, 0.0) - ISNULL(CantidadPendiente, 0.0) - ISNULL(CantidadReservada, 0.0) - ISNULL(CantidadOrdenada, 0.0) <> 0)

    OPEN axReservado
    FETCH NEXT FROM axReservado INTO @ID, @Renglon, @RenglonSub, @Cuenta, @SubCuenta, @Grupo, @Cantidad
    WHILE @@FETCH_STATUS <> -1
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Cantidad <> 0.0
      BEGIN
        UPDATE VentaD SET CantidadReservada = CantidadReservada + @Cantidad WHERE CURRENT OF axReservado
        INSERT AutoFix (Version, Fecha,	Modulo,	ModuloID, Renglon, RenglonSub, Cuenta, SubCuenta, Grupo, Cantidad, Campo, Descripcion)
                VALUES (@Version, @Ahora, 'VTAS', @ID, @Renglon, @RenglonSub, @Cuenta, @SubCuenta, @Grupo, @Cantidad, 'CantidadReservada', 'VTAS.P Pendiente, Si se Afectaba Reservar/Pendiente NO se Actualizaba Bien la Cantidad Reservada')
      END
      FETCH NEXT FROM axReservado INTO @ID, @Renglon, @RenglonSub, @Cuenta, @SubCuenta, @Grupo, @Cantidad
    END
    CLOSE axReservado
    DEALLOCATE axReservado
  COMMIT TRANSACTION
END
*/
go

/*IF (SELECT Version FROM Version)<=230 
  EXEC spAutoFixReservado*/

if exists (select * from sysobjects where id = object_id('dbo.spAutoFixAnticiposD') and sysstat & 0xf = 4) drop procedure dbo.spAutoFixAnticiposD
GO
CREATE PROCEDURE spAutoFixAnticiposD 
			@Modulo char(5), 
			@ID	int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @Renglon	float

  SELECT @Renglon = NULL
  IF @Modulo = 'CXP'
    DECLARE axAD CURSOR FOR 
     SELECT Renglon FROM CxpD WHERE ID = @ID ORDER BY Renglon DESC
  ELSE
    DECLARE axAD CURSOR FOR 
     SELECT Renglon FROM CxcD WHERE ID = @ID ORDER BY Renglon DESC

  OPEN axAD
  FETCH NEXT FROM axAD INTO @Renglon
  CLOSE axAD
  DEALLOCATE axAD

  IF @Renglon IS NOT NULL
  BEGIN
    IF @Modulo = 'CXP' 
      DELETE CxpD WHERE ID = @ID AND Renglon <> @Renglon
    ELSE
      DELETE CxcD WHERE ID = @ID AND Renglon <> @Renglon
  END
END
GO

if exists (select * from sysobjects where id = object_id('dbo.spAutoFixAnticipos') and sysstat & 0xf = 4) drop procedure dbo.spAutoFixAnticipos
GO
CREATE PROCEDURE spAutoFixAnticipos 
			@Modulo char(5)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @ID	int

  BEGIN TRANSACTION
    IF @Modulo = 'CXP'
       SELECT e.ID
         INTO #axCxpA
         FROM cxp e, cxpd d, MovTipo mt
        WHERE e.id = d.id and e.mov = mt.mov and mt.modulo = 'CXP' and mt.Clave = 'CXP.A'
        GROUP BY e.ID, e.Mov, e.MovID, e.Importe
       HAVING round(e.Importe,0) <>round(sum(d.Importe), 0)
        ORDER BY e.ID, e.Mov, e.MovID, e.Importe
    ELSE
       SELECT e.ID
         INTO #axCxcA
         FROM cxc e, cxcd d, MovTipo mt
        WHERE e.id = d.id and e.mov = mt.mov and mt.modulo = 'CXC' and mt.Clave = 'CXC.A'
        GROUP BY e.ID, e.Mov, e.MovID, e.Importe
       HAVING round(e.Importe,0) <>round(sum(d.Importe), 0)
        ORDER BY e.ID, e.Mov, e.MovID, e.Importe

    IF @Modulo = 'CXP'
      DECLARE axA CURSOR FOR SELECT ID FROM #axCxpA
    ELSE
      DECLARE axA CURSOR FOR SELECT ID FROM #axCxcA
    OPEN axA
    FETCH NEXT FROM axA INTO @ID
    WHILE @@FETCH_STATUS <> -1
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        EXEC spAutoFixAnticiposD @Modulo, @ID
      END
      FETCH NEXT FROM axA INTO @ID
    END
    CLOSE axA
    DEALLOCATE axA
  COMMIT TRANSACTION
END
GO


/* QUITAR Y PONER EXTRAS */

/****** Cuentas Contables  ******/
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cta') and c.name = 'Tipo' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Cta ADD Tipo char(15) NULL")
  EXEC("UPDATE Cta SET Tipo = 'Estructura' WHERE Estructura = 1")
  EXEC("sp_rename 'Cta.Estructura', 'Logico4', 'COLUMN'")
  EXEC("UPDATE Cta SET Logico4 = 0")
END
IF EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cta') and c.name = 'Extra1' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename Cta, Temporal")
  EXEC("CREATE TABLE dbo.Cta(
	Cuenta	 		char(20) 	NOT NULL,
	Rama			char(20)	NULL,

	Descripcion		varchar(100)    NULL,
	Tipo			char(15)	NULL,
	Categoria 		varchar(50) 	NULL,
	Familia 		varchar(50) 	NULL,
	Grupo	 		varchar(50)	NULL,
	EsAcreedora		bit		NOT NULL	DEFAULT 0,
	EsAcumulativa		bit		NOT NULL	DEFAULT 0,
	TieneMovimientos	bit		NOT NULL	DEFAULT 0,
	Conciliar		bit		NOT NULL	DEFAULT 0,

	Directa			bit		NOT NULL	DEFAULT 0,
	CentrosCostos		bit		NOT NULL	DEFAULT 0,
	CentroCostosPresupuesto bit		NOT NULL	DEFAULT 0,
	CentroCostosOmision	varchar(20)	NULL,

	Estatus 		char(15) 	NOT NULL	DEFAULT 'NORMAL',
	UltimoCambio 		datetime  	NULL,
	Alta			datetime	NULL,
	Mensaje			varchar(50)	NULL,
	Logico1			bit		NOT NULL 	DEFAULT 0,
	Logico2			bit		NOT NULL 	DEFAULT 0,
	Logico3			bit		NOT NULL 	DEFAULT 0,
	Logico4			bit		NOT NULL	DEFAULT 0,

	CONSTRAINT pCta PRIMARY KEY  CLUSTERED (Cuenta)
  )")
  EXEC("CREATE INDEX Descripcion ON dbo.Cta (Descripcion)")
  EXEC("CREATE INDEX Categoria ON dbo.Cta (Categoria)")
  EXEC("CREATE INDEX Tipo ON dbo.Cta (Tipo)")
  EXEC("INSERT Cta SELECT Cuenta, Rama, Descripcion, Tipo, Categoria, Familia, Grupo, EsAcreedora, EsAcumulativa, TieneMovimientos,
	                  Conciliar,Directa,CentrosCostos,CentroCostosPresupuesto,CentroCostosOmision,Estatus,UltimoCambio,Alta,Mensaje,
	                  Logico1,Logico2,Logico3,Logico4 FROM Temporal")
  EXEC("DROP TABLE Temporal")
END
GO


/****** Cuentas Dinero  ******/
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CtaDinero') and c.name = 'Beneficiario' and o.sysstat & 0xf = 3)
  ALTER TABLE CtaDinero ADD Beneficiario int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CtaDinero') and c.name = 'Descripcion' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE CtaDinero ADD Descripcion	varchar(100) NULL
  EXEC("UPDATE CtaDinero SET Moneda = NULL WHERE Tipo = 'Caja'")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CtaDinero') and c.name = 'Uso' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE CtaDinero ADD Uso	char(20) NULL
  EXEC("UPDATE CtaDinero SET Uso = 'Operacion'")
END
IF EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CtaDinero') and c.name = 'Extra1' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename CtaDinero, Temporal")
  EXEC("CREATE TABLE dbo.CtaDinero(
	CtaDinero		char(10)  	NOT NULL,
	Descripcion		varchar(100)	NULL,
	Tipo			char(20)	NULL,

	Sucursal 		varchar(100)  	NULL,
	NumeroCta		varchar(100)    NULL,
	CuentaHabiente		varchar(100) 	NULL,
	Moneda 			char(10)  	NULL,

	Estatus 		char(15) 	NULL		DEFAULT 'NORMAL',
	UltimoCambio 		datetime  	NULL,
	Alta			datetime	NULL,
	Conciliar		bit		NOT NULL	DEFAULT 0,
	Mensaje			varchar(50)	NULL,
	UltimoCorte 		datetime  	NULL,
	Beneficiario		int		NULL,
	Uso			char(20)	NULL,	-- Operacion/Inversion

	Logico1			bit		NOT NULL 	DEFAULT 0,
	Logico2			bit		NOT NULL 	DEFAULT 0,
	Logico3			bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT pCtaDinero PRIMARY KEY  CLUSTERED (CtaDinero)
  )")
  EXEC("INSERT CtaDinero SELECT CtaDinero, Descripcion, Tipo, Sucursal, NumeroCta, CuentaHabiente,Moneda,
          	                Estatus, UltimoCambio, Alta, Conciliar, Mensaje, UltimoCorte, Beneficiario, Uso,	
                                Logico1, Logico2, Logico3 FROM Temporal")
  EXEC("DROP TABLE Temporal")
END
GO


/****** Agentes ******/
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Agente') and c.name = 'BeneficiarioNombre' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE Agente ADD BeneficiarioNombre varchar(100) NULL
  EXEC("UPDATE Agente SET BeneficiarioNombre=Nombre")
END
IF EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Agente') and c.name = 'Extra1' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename Agente, Temporal")
  EXEC("CREATE TABLE dbo.Agente(
	Agente	 		char(10)  	NOT NULL,

	Nombre 			varchar(100) 	NULL,
	Moneda			char(10) 	NULL,
	Telefonos 		varchar(100) 	NULL,
	Extencion		varchar(10) 	NULL,
        Categoria		varchar(50) 	NULL,
	Zona			varchar(30)     NULL,
        Grupo       		varchar(50) 	NULL,

	Estatus			char(15) 	NULL	DEFAULT 'NORMAL',
	UltimoCambio		datetime  	NULL,
	Clase			char(15)	NULL,
	Alta			datetime	NULL,
	Conciliar		bit		NOT NULL	DEFAULT 0,
	Mensaje			varchar(50)	NULL,
	BeneficiarioNombre	varchar(100)	NULL,

	Logico1			bit		NOT NULL 	DEFAULT 0,
	Logico2			bit		NOT NULL 	DEFAULT 0,
	Logico3			bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT pAgente PRIMARY KEY  CLUSTERED (Agente)
  )")
  EXEC("INSERT Agente SELECT Agente,Nombre,Moneda,Telefonos,Extencion,Categoria,Zona,Grupo,
    	                     Estatus,UltimoCambio,Clase,Alta,Conciliar,Mensaje,BeneficiarioNombre,
                             Logico1, Logico2, Logico3 FROM Temporal")
  EXEC("DROP TABLE Temporal")
END
GO


/****** Clientes  ******/
IF EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cte') and c.name = 'Extra1' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename Cte, Temporal")
  EXEC("CREATE TABLE dbo.Cte(
	Cliente 		char(10) 	NOT NULL,

	Nombre 			varchar(100)    NULL,
	NombreCorto		char(20)	NULL,
	Direccion 		varchar(100) 	NULL,
	Colonia 		varchar(30) 	NULL,
	Poblacion 		varchar(30) 	NULL,
	Estado 			varchar(30) 	NULL,
	Pais 			varchar(30)     NULL,
	Zona 			varchar(30) 	NULL,
	CodigoPostal 		varchar(15) 	NULL,
	RFC 			varchar(15)     NULL,
	Telefonos		varchar(100) 	NULL,
	Fax 			varchar(50) 	NULL,
	PedirTono		bit           	NOT NULL DEFAULT 0,
	Contacto1 		varchar(50) 	NULL,
	Contacto2 		varchar(50) 	NULL,
	Extencion1	        varchar(10)     NULL,
	Extencion2		varchar(10) 	NULL,
	eMail1			varchar(50)     NULL,
	eMail2			varchar(50) 	NULL,
	DirInternet		varchar(50) 	NULL,
	Categoria 		varchar(50) 	NULL,
	Familia 		varchar(50) 	NULL,
	Grupo	 		varchar(50)	NULL,
	Credito			varchar(50)	NULL,
	DiaRevision1 		varchar(10)  	NULL,
	DiaRevision2 		varchar(10)  	NULL,
	HorarioRevision		varchar(20) 	NULL,
	DiaPago1 		varchar(10)  	NULL,
	DiaPago2 		varchar(10)  	NULL,
	HorarioPago		varchar(20) 	NULL,
	ZonaImpuesto		varchar(30)  	NULL,    -- ExcentoIVA ??
	PedidosParciales	bit		NOT NULL DEFAULT 1,
	EsDeudor		bit		NOT NULL DEFAULT 0,

	Descuento 		varchar(30)  	NULL,
	Agente       		char(10)        NULL,
	EnviarA			int		NULL,
	Proyecto		varchar(50)	NULL,
	FormaEnvio		varchar(50)	NULL,
	Condicion		varchar(50)	NULL,
	Ruta			varchar(50)	NULL,

	VtasConsignacion	bit		NOT NULL DEFAULT 0,
	AlmacenVtasConsignacion	char(10)	NULL,

	Clase			char(15)	NULL,
	Estatus 		char(15) 	NULL	DEFAULT 'NORMAL',
	UltimoCambio 		datetime  	NULL,
	Alta			datetime	NULL,
	Conciliar		bit		NOT NULL	DEFAULT 0,
	Mensaje			varchar(50)	NULL,

	Logico1			bit		NOT NULL 	DEFAULT 0,
	Logico2			bit		NOT NULL 	DEFAULT 0,
	Logico3			bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT pCte PRIMARY KEY  CLUSTERED (Cliente)
  )")
  EXEC("CREATE INDEX Nombre ON dbo.Cte (Nombre)")
  EXEC("CREATE INDEX Categoria ON dbo.Cte (Categoria)")
  EXEC("INSERT Cte SELECT Cliente, Nombre,NombreCorto,Direccion,Colonia,Poblacion,Estado,Pais,Zona,CodigoPostal,
	RFC,Telefonos,Fax,PedirTono,Contacto1,Contacto2,Extencion1,Extencion2,eMail1,eMail2,DirInternet,
        Categoria,Familia,Grupo,Credito,DiaRevision1,DiaRevision2,HorarioRevision,DiaPago1,DiaPago2,HorarioPago,
	ZonaImpuesto,PedidosParciales,EsDeudor,
	Descuento,Agente,EnviarA,Proyecto,FormaEnvio,Condicion,Ruta,VtasConsignacion,AlmacenVtasConsignacion,
	Clase,Estatus,UltimoCambio,Alta,Conciliar,Mensaje,
	Logico1,Logico2,Logico3 FROM Temporal")
  EXEC("DROP TABLE Temporal")
END
GO

/****** Enviar a  ******/
IF EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CteEnviarA') and c.name = 'Extra1' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename CteEnviarA, Temporal")
  EXEC("CREATE TABLE dbo.CteEnviarA(
	Cliente 		char(10) 	NOT NULL,
	ID			int		NOT NULL DEFAULT 0,

	Nombre 			varchar(100) 	NULL,
	Direccion 		varchar(100) 	NULL,
	Colonia 		varchar(30) 	NULL,
	Poblacion 		varchar(30) 	NULL,
	Estado 			varchar(30) 	NULL,
	Pais 			varchar(30)     NULL,
	Zona 			varchar(30) 	NULL,
	CodigoPostal 		varchar(15) 	NULL,
	Telefonos		varchar(100) 	NULL,
	Fax 			varchar(50)     NULL,
	PedirTono		bit           	NOT NULL DEFAULT 0,
	Contacto1 		varchar(50) 	NULL,
	Contacto2 		varchar(50) 	NULL,
        Extencion1              varchar(10)     NULL,
        Extencion2              varchar(10)     NULL,
	eMail1			varchar(50) 	NULL,
	eMail2			varchar(50) 	NULL,
	FormaEnvio		varchar(50)	NULL,
	ZonaImpuesto		varchar(30)  	NULL,    -- ExcentoIVA ??

	Clase			char(15)	NULL,
	Estatus 		char(15) 	NULL	DEFAULT 'NORMAL',
	UltimoCambio 		datetime  	NULL,
	Alta			datetime	NULL,
	Mensaje			varchar(50)	NULL,

	Logico1			bit		NOT NULL 	DEFAULT 0,
	Logico2			bit		NOT NULL 	DEFAULT 0,
	Logico3			bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT pCteEnviarA PRIMARY KEY  CLUSTERED (Cliente,ID)
  )")
  EXEC("INSERT CteEnviarA SELECT Cliente,ID,Nombre,Direccion,Colonia,Poblacion,Estado,Pais,Zona,CodigoPostal,Telefonos,
                                 Fax,PedirTono,Contacto1,Contacto2,Extencion1,Extencion2,eMail1,eMail2,FormaEnvio,ZonaImpuesto,
				 Clase,Estatus,UltimoCambio,Alta,Mensaje,
                                 Logico1, Logico2, Logico3 FROM Temporal")
  EXEC("DROP TABLE Temporal")
END
GO


/*********** Almacenes ************/
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Alm') and c.name = 'Categoria' and o.sysstat & 0xf = 3)
  EXEC sp_rename 'Alm.Tipo', 'Categoria', 'COLUMN'
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Alm') and c.name = 'Exclusivo' and o.sysstat & 0xf = 3)
  ALTER TABLE Alm ADD Exclusivo varchar(20) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Alm') and c.name = 'Orden' and o.sysstat & 0xf = 3)
  ALTER TABLE Alm ADD Orden int NULL
IF EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Alm') and c.name = 'Extra1' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename Alm, Temporal")
  EXEC("CREATE TABLE dbo.Alm(
	Almacen 		char(10)  	NOT NULL,

	Nombre	 		varchar(100)  	NOT NULL,
	Direccion 		varchar(100) 	NULL,
	Colonia 		varchar(30)  	NULL,
	Poblacion 		varchar(30)  	NULL,
	Estado 			varchar(30)  	NULL,
	Pais			varchar(30)  	NULL,
	CodigoPostal 		varchar(15) 	NULL,
	Encargado 		varchar(50)  	NULL,
	Telefonos 		varchar(100)  	NULL,

	Grupo			varchar(50)	NULL,
	Categoria		varchar(50)	NULL,

	Exclusivo		varchar(20)	NULL,
	Orden			int		NULL,
	Estatus			char(15)  	NULL	DEFAULT 'NORMAL',
	UltimoCambio		datetime      	NULL,
	Alta			datetime	NULL,

	Logico1			bit		NOT NULL 	DEFAULT 0,
	Logico2			bit		NOT NULL 	DEFAULT 0,
	Logico3			bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT pAlm PRIMARY KEY CLUSTERED (Almacen)
  )")
  EXEC("INSERT Alm SELECT Almacen,Nombre,Direccion,Colonia,Poblacion,Estado,Pais,CodigoPostal,Encargado,Telefonos,
   	                  Grupo,Categoria,Exclusivo,Orden,Estatus,UltimoCambio,Alta,
                          Logico1, Logico2, Logico3 FROM Temporal")
  EXEC("DROP TABLE Temporal")
END
GO


/****** Articulos ******/
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'Precio2' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename Art, Temporal")
  EXEC("CREATE TABLE dbo.Art(
	Articulo 		char(20) 	NOT NULL,

	Descripcion1 		varchar(100) 	NULL,
	Descripcion2 		varchar(255) 	NULL,
	NombreCorto		char(20)	NULL,
        Grupo			varchar(50)	NULL,
	Categoria 		varchar(50) 	NULL,
	Familia 		varchar(50) 	NULL,
	Fabricante 		varchar(50)  	NULL,
	ClaveFabricante		varchar(50)	NULL,
	Impuesto1 		float	  	NOT NULL,
	Impuesto2 		float	  	NULL,
	Factor			varchar(50)  	NULL,
	Unidad  		varchar(50)  	NULL,
	TipoCosteo		varchar(10)  	NULL,
	Peso			float		NULL,
	Tara			float	    	NULL,
	Volumen			float		NULL,
	Tipo			varchar(20)	NOT NULL 	DEFAULT 'NORMAL',
	Accesorios		bit		NOT NULL 	DEFAULT 0,

	MonedaCosto 		char(10)  	NOT NULL,
	MonedaPrecio 		char(10)  	NOT NULL,
	MargenMinimo		money     	NULL,  
	PrecioLista		money     	NULL,
	PrecioAlterno		money		NULL,
        FactorAlterno		float		NULL,
	PrecioAnterior		money		NULL,
	Utilidad		varchar(50)	NULL,

	Clase			char(15)	NULL,
	Estatus 		char(15) 	NULL		DEFAULT 'SINCAMBIO',
	UltimoCambio 		datetime  	NULL,
	Alta			datetime	NULL,
	Conciliar		bit		NOT NULL	DEFAULT 0,
	Mensaje			varchar(50)	NULL,

	Precio2			money		NULL,
	Precio3			money		NULL,
	Precio4			money		NULL,
	Precio5			money		NULL,

	Logico1			bit		NOT NULL 	DEFAULT 0,
	Logico2			bit		NOT NULL 	DEFAULT 0,
	Logico3			bit		NOT NULL 	DEFAULT 0,
	Logico4			bit		NOT NULL 	DEFAULT 0,
	Logico5			bit		NOT NULL 	DEFAULT 0,
	Logico6			bit       	NOT NULL 	DEFAULT 0,

	CONSTRAINT prArt PRIMARY KEY CLUSTERED (Articulo)
  )")
  EXEC("CREATE INDEX Descripcion1 ON dbo.Art (Descripcion1)")
  EXEC("CREATE INDEX Categoria ON dbo.Art (Categoria)")
  EXEC("CREATE INDEX Fabricante ON dbo.Art (Fabricante)")
  EXEC("CREATE INDEX ClaveFabricante ON dbo.Art (ClaveFabricante)")
  EXEC("CREATE INDEX Estatus ON dbo.Art (Estatus)")
  EXEC("INSERT Art (Articulo,Descripcion1,Descripcion2,NombreCorto,Grupo,Categoria,Familia,Fabricante,ClaveFabricante,
	            Impuesto1,Impuesto2,Factor,Unidad,TipoCosteo,Peso,Tara,Volumen,Tipo,Accesorios,MonedaCosto,MonedaPrecio,MargenMinimo,
		    PrecioLista,PrecioAlterno,FactorAlterno,PrecioAnterior,Utilidad,Clase,Estatus,UltimoCambio,Alta,Conciliar,Mensaje)
             SELECT Articulo,Descripcion1,Descripcion2,NombreCorto,Grupo,Categoria,Familia,Fabricante,ClaveFabricante,
	            ISNULL(Impuesto1,0),Impuesto2,Factor,Unidad,TipoCosteo,Peso,Tara,Volumen,Tipo,Accesorios,MonedaCosto,MonedaPrecio,MargenMinimo,
		    PrecioLista,PrecioAlterno,FactorAlterno,PrecioAnterior,Utilidad,Clase,Estatus,UltimoCambio,Alta,Conciliar,Mensaje
               FROM Temporal")
  EXEC("DROP TABLE Temporal")
END
GO


/****** Proveedores  ******/
IF EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Prov') and c.name = 'Extra1' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename Prov, Temporal")
  EXEC("CREATE TABLE dbo.Prov(
	Proveedor 		char(10) 	NOT NULL,

	Nombre 			varchar(100)    NULL,
	NombreCorto		char(20)	NULL,
	Direccion 		varchar(100) 	NULL,
	Colonia 		varchar(30) 	NULL,
	Poblacion 		varchar(30) 	NULL,
	Estado 			varchar(30) 	NULL,
	Zona			varchar(30)	NULL,
	Pais 			varchar(30)     NULL,
	CodigoPostal 		varchar(15) 	NULL,
	Telefonos		varchar(100)	NULL,
	Fax 			varchar(50)     NULL,
	PedirTono		bit   		NOT NULL DEFAULT 0,
	DirInternet		varchar(50) 	NULL,
	Contacto1 		varchar(50) 	NULL,
	Contacto2 		varchar(50) 	NULL,
        Extencion1              varchar(10)     NULL,
        Extencion2              varchar(10)     NULL,
	eMail1			varchar(50) 	NULL,
	eMail2			varchar(50) 	NULL,
	RFC 			varchar(15)     NULL,
	Categoria 		varchar(50) 	NULL,
	Familia 		varchar(50) 	NULL,
	ZonaImpuesto		varchar(30)  	NULL,  -- ExcentoIVA ??
	FormaEnvio		varchar(50)	NULL,
	Descuento 		varchar(30)  	NULL,
	Comprador		varchar(50)     NULL,
	Proyecto		varchar(50)     NULL,
	Condicion		varchar(50)     NULL,
	Almacen			char(10)     	NULL,
	DiaRevision1 		varchar(10)  	NULL,
	DiaRevision2 		varchar(10)  	NULL,
	HorarioRevision		varchar(20) 	NULL,
	DiaPago1 		varchar(10)  	NULL,
	DiaPago2 		varchar(10)  	NULL,
	HorarioPago		varchar(20) 	NULL,
	Beneficiario		int		NULL,
	BeneficiarioNombre	varchar(100)	NULL,

	Clase			char(15)	NULL,
	Estatus 		char(15) 	NULL		DEFAULT 'NORMAL',
	UltimoCambio 		datetime  	NULL,
	Alta			datetime	NULL,
	Conciliar		bit		NOT NULL	DEFAULT 0,
	EsAcreedor		bit		NOT NULL	DEFAULT 0,
	Mensaje			varchar(50)	NULL,

	Logico1			bit		NOT NULL 	DEFAULT 0,
	Logico2			bit		NOT NULL 	DEFAULT 0,
	Logico3			bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT pProv PRIMARY KEY  CLUSTERED (Proveedor)
  )")
  EXEC("INSERT Prov SELECT Proveedor,Nombre,NombreCorto,Direccion,Colonia,Poblacion,Estado,Zona,Pais,CodigoPostal,Telefonos,
	                   Fax,PedirTono,DirInternet,Contacto1,Contacto2,Extencion1,Extencion2,eMail1,eMail2,RFC,Categoria,Familia,ZonaImpuesto,
                           FormaEnvio,Descuento,Comprador,Proyecto,Condicion,Almacen,DiaRevision1,DiaRevision2,HorarioRevision,DiaPago1,DiaPago2,HorarioPago,Beneficiario,BeneficiarioNombre,
	                   Clase,Estatus,UltimoCambio,Alta,Conciliar,EsAcreedor,Mensaje,
                           Logico1, Logico2, Logico3 FROM Temporal")
  EXEC("DROP TABLE Temporal")
END
GO

/****** Conceptos  ******/
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Concepto') and c.name = 'EsDeducible' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename Concepto, Temporal")
  EXEC("CREATE TABLE dbo.Concepto (
	Modulo			char(5)	     NOT NULL,
	Concepto 		varchar(50)  NOT NULL,
	EsDeducible		bit	     NOT NULL DEFAULT 1,
	Logico1			bit	     NOT NULL DEFAULT 0,
	Logico2			bit	     NOT NULL DEFAULT 0,
	Logico3			bit	     NOT NULL DEFAULT 0,
	
	Bloqueo			varchar(50)  NULL,
	Orden			int	     NULL,

	CONSTRAINT pConcepto PRIMARY KEY CLUSTERED (Modulo, Concepto)
  )")
  EXEC("INSERT Concepto SELECT Modulo, Concepto, 1, 0, 0, 0, Bloqueo, Orden FROM Temporal")
  EXEC("DROP TABLE Temporal")
END
go


/****** Usuarios  ******/
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'DefCliente' and o.sysstat & 0xf = 3)
  ALTER TABLE Usuario ADD DefCliente char(10) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'AgregarCteExpress' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE Usuario ADD AgregarCteExpress char(2) NULL DEFAULT 'No'
  EXEC("UPDATE Usuario SET AgregarCteExpress = DEFAULT")  
END
IF EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'Generar' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Usuario.Generar', 'AfectarOtrosMovs', 'COLUMN'")
  EXEC("UPDATE Usuario SET AfectarOtrosMovs = 0")
END
GO
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'CancelarOtrosMovs' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename Usuario, Temporal")
  EXEC("CREATE TABLE dbo.Usuario (
	Usuario 			char(10)  	NOT NULL,

	Nombre 				varchar(100) 	NULL,
	GrupoTrabajo			varchar(50)	NULL,
	Contrasena			char(10) 	NULL,
	Telefono 			varchar(100)  	NULL,
	Extencion 			varchar(10) 	NULL,

	DefAgente			char(10)	NULL,
	DefAlmacen			char(10)	NULL,
	DefCtaBanco			char(10)	NULL,
	DefCtaCaja			char(10)	NULL,
        DefMoneda			char(10)	NULL,
	DefProyecto			varchar(50)	NULL,
	DefCliente			char(10)	NULL,
	Afectar				bit		NOT NULL	DEFAULT 1,
	Cancelar			bit		NOT NULL	DEFAULT 1,
	Desafectar			bit		NOT NULL	DEFAULT 0,
	AfectarOtrosMovs		bit		NOT NULL	DEFAULT 0,
	CancelarOtrosMovs		bit		NOT NULL	DEFAULT 0,
	ConsultarOtrosMovs		bit		NOT NULL	DEFAULT 0,
	ModificarOtrosMovs		bit		NOT NULL	DEFAULT 0,
	ModificarVencimientos		bit		NOT NULL	DEFAULT 0,
	ModificarEntregas		bit		NOT NULL	DEFAULT 0,
	ModificarEnvios			bit		NOT NULL	DEFAULT 0,
	ModificarReferencias		bit		NOT NULL	DEFAULT 0,
	ModificarAlmacenEntregas 	char(2)		NULL		DEFAULT 'No',
	AgregarCteExpress	 	char(2)		NULL		DEFAULT 'No',
	Costos				char(20)	NULL		DEFAULT 'No',
	VerInfoDeudores			char(2)		NULL		DEFAULT 'No',
	VerInfoAcreedores		char(2)		NULL		DEFAULT	'No',

	Estatus				char(15) 	NULL	DEFAULT 'ACTIVO',
	UltimoCambio			datetime  	NULL,
	Alta				datetime	NULL,

	Logico1				bit		NOT NULL 	DEFAULT 0,
	Logico2				bit		NOT NULL 	DEFAULT 0,
	Logico3				bit		NOT NULL 	DEFAULT 0,
	Logico4				bit		NOT NULL	DEFAULT 0,
	Logico5				bit		NOT NULL	DEFAULT 0,
	Logico6				bit		NOT NULL 	DEFAULT 0,
	Logico7				bit		NOT NULL 	DEFAULT 0,
	Logico8				bit		NOT NULL 	DEFAULT 0,
	Logico9				bit		NOT NULL	DEFAULT 0,

	CONSTRAINT pUsuario PRIMARY KEY CLUSTERED (Usuario)
  )")
  EXEC("INSERT Usuario SELECT Usuario, Nombre, GrupoTrabajo, Contrasena, Telefono, Extencion,
                              DefAgente, DefAlmacen, DefCtaBanco, DefCtaCaja, DefMoneda, DefProyecto, DefCliente,
                              Afectar, Cancelar, Desafectar,
                              AfectarOtrosMovs, 0, ConsultarOtrosMovs, ModificarOtrosMovs, ModificarVencimientos, ModificarEntregas, ModificarEnvios, ModificarReferencias, ModificarAlmacenEntregas,
                              AgregarCteExpress, Costos, VerInfoDeudores, VerInfoAcreedores, Estatus, UltimoCambio, Alta,0,0,0,0,0,0,0,0,0 FROM Temporal")
  EXEC("DROP TABLE Temporal")
END
go

/* PONER EXTRAS   */

/* Contabilidad */
IF (SELECT Version FROM Version)<=209 AND NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cont') and c.name = 'Logico1' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename Cont, Temporal")
  EXEC("CREATE TABLE dbo.Cont (
	ID			int 	    	NOT NULL IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov 			char(20)        NOT NULL,
	MovID			int         	NULL,
	FechaEmision 		datetime    	NULL,
	FechaContable		datetime	NOT NULL,
	UltimoCambio 		datetime    	NULL,
	Concepto		varchar(50)	NULL,
	Proyecto		varchar(50)   	NULL,
	Moneda  		char(10)   	NOT NULL,
	TipoCambio		float		NULL,
	Usuario 		char(10)   	NULL,
	Autorizacion		char(10)	NULL,
	Referencia 		varchar(50) 	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Estatus 		char(15)   	NULL,
	Situacion		varchar(50)   	NULL,

	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		int		NULL,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,
	Logico9			bit		NOT NULL DEFAULT 0,

	CONSTRAINT pCont PRIMARY KEY CLUSTERED (ID)
  )")
  EXEC("CREATE INDEX Consecutivo   ON dbo.Cont (Empresa, MovID, Mov)")
  EXEC("CREATE INDEX FechaContable ON dbo.Cont (Empresa, FechaContable)")
  EXEC("CREATE INDEX Usuario       ON dbo.Cont (Empresa, Usuario)")
  EXEC("CREATE INDEX Situacion     ON dbo.Cont (Empresa, Estatus, Situacion)")
  EXEC("CREATE INDEX Concepto      ON dbo.Cont (Empresa, Concepto)")
  EXEC("CREATE INDEX Referencia    ON dbo.Cont (Empresa, Referencia)")
  SET IDENTITY_INSERT Cont ON
  EXEC("INSERT Cont (ID,Empresa,Mov,MovID,FechaEmision,FechaContable,UltimoCambio,Concepto,Proyecto,Moneda,TipoCambio,
       	             Usuario,Autorizacion,Referencia,DocFuente,Observaciones,Estatus,Situacion,OrigenTipo,Origen,OrigenID,
	             Ejercicio,Periodo,FechaRegistro,FechaConclusion,FechaCancelacion)
              SELECT ID,Empresa,Mov,MovID,FechaEmision,FechaContable,UltimoCambio,Concepto,Proyecto,Moneda,TipoCambio,
       	             Usuario,Autorizacion,Referencia,DocFuente,Observaciones,Estatus,Situacion,OrigenTipo,Origen,OrigenID,
	             Ejercicio,Periodo,FechaRegistro,FechaConclusion,FechaCancelacion 
                FROM Temporal")
  SET IDENTITY_INSERT Cont OFF
  EXEC("DROP TABLE Temporal")
END
GO

/* Inventarios */
IF (SELECT Version FROM Version)<=209 AND NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Inv') and c.name = 'Logico1' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename Inv, Temporal")
  EXEC("CREATE TABLE dbo.Inv (
	ID			int 	    	NOT NULL IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov 			char(20)        NOT NULL,
	MovID			int         	NULL,
	FechaEmision 		datetime    	NULL,
	UltimoCambio 		datetime    	NULL,
	Concepto		varchar(50)	NULL,
	Proyecto		varchar(50)   	NULL,
	Moneda  		char(10)   	NOT NULL,
	TipoCambio		float		NULL,
	Usuario 		char(10)   	NULL,
	Autorizacion		char(10)	NULL,
	Referencia 		varchar(50) 	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Estatus 		char(15)   	NULL,
	Situacion		varchar(50)	NULL,
	Directo			bit		NOT NULL DEFAULT 1,
	RenglonID		int		NULL,

	Almacen	        	char(10)   	NULL,
	AlmacenDestino  	char(10)   	NULL,
	AlmacenTransito		char(10)	NULL,
	Largo			bit	    	NOT NULL DEFAULT 0,
	Condicion		varchar(50)	NULL,
	Vencimiento		datetime	NULL,

	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		int		NULL,

	Poliza			varchar(20)     NULL,
	PolizaID		int		NULL,
	GenerarPoliza		bit	    	NOT NULL DEFAULT 0,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,
	Logico9			bit		NOT NULL DEFAULT 0,

	CONSTRAINT pInv PRIMARY KEY CLUSTERED (ID)
  )")
  EXEC("CREATE INDEX Consecutivo  ON dbo.Inv (Empresa, MovID, Mov)")
  EXEC("CREATE INDEX FechaEmision ON dbo.Inv (Empresa, FechaEmision)")
  EXEC("CREATE INDEX Usuario      ON dbo.Inv (Empresa, Usuario)")
  EXEC("CREATE INDEX Situacion    ON dbo.Inv (Empresa, Estatus, Situacion)")
  SET IDENTITY_INSERT Inv ON
  EXEC("INSERT Inv (ID,Empresa,Mov,MovID,FechaEmision,UltimoCambio,Concepto,Proyecto,Moneda,TipoCambio,
                    Usuario,Autorizacion,Referencia,DocFuente,Observaciones,Estatus,Situacion,Directo,RenglonID,
   	            Almacen,AlmacenDestino,AlmacenTransito,Largo,Condicion,Vencimiento,OrigenTipo,Origen,OrigenID,
	            Poliza,PolizaID,GenerarPoliza,Ejercicio,Periodo,FechaRegistro,FechaConclusion,FechaCancelacion)
             SELECT ID,Empresa,Mov,MovID,FechaEmision,UltimoCambio,Concepto,Proyecto,Moneda,TipoCambio,
                    Usuario,Autorizacion,Referencia,DocFuente,Observaciones,Estatus,Situacion,Directo,RenglonID,
   	            Almacen,AlmacenDestino,AlmacenTransito,Largo,Condicion,Vencimiento,OrigenTipo,Origen,OrigenID,
	            Poliza,PolizaID,GenerarPoliza,Ejercicio,Periodo,FechaRegistro,FechaConclusion,FechaCancelacion 
               FROM Temporal")
  SET IDENTITY_INSERT Inv OFF
  EXEC("DROP TABLE Temporal")
END
GO

/* Cxc */
IF (SELECT Version FROM Version)<=209
BEGIN
  IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxc') and c.name = 'AutoAjuste' and o.sysstat & 0xf = 3)
    ALTER TABLE Cxc ADD AutoAjuste money NULL
  IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxc') and c.name = 'Cambio' and o.sysstat & 0xf = 3)
    ALTER TABLE Cxc ADD Cambio money NULL
  IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxc') and c.name = 'DelEfectivo' and o.sysstat & 0xf = 3)
    ALTER TABLE Cxc ADD DelEfectivo money NULL
  IF EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxc') and c.name = 'FechaMoratorios' and o.sysstat & 0xf = 3)
  BEGIN
    EXEC("UPDATE CXC SET Condicion = '(Fecha)', Vencimiento = FechaMoratorios WHERE FechaMoratorios <> Vencimiento AND FechaMoratorios IS NOT NULL")
    EXEC("sp_rename 'Cxc.FechaMoratorios', 'FechaExtra1', 'COLUMN'")
  END
END
IF (SELECT Version FROM Version)<=209 AND NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxc') and c.name = 'Logico1' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename Cxc, Temporal")
  EXEC("CREATE TABLE dbo.Cxc (
	ID 			int         	NOT NULL IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov			char(20)        NOT NULL,
	MovID			int         	NULL,	 
	FechaEmision 		datetime    	NULL,	 
	UltimoCambio 		datetime    	NULL,
	Concepto		varchar(50)	NULL,
	Proyecto		varchar(50)   	NULL,
	Moneda  		char(10)   	NOT NULL,
	TipoCambio		float		NULL,
	Usuario 		char(10)   	NULL,
	Autorizacion		char(10)	NULL,
	Referencia 		varchar(50) 	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Estatus 		char(15)   	NULL,
	Situacion		varchar(50)	NULL,

	Cliente 		char(10)   	NOT NULL,	
	ClienteMoneda		char(10)	NULL,
	CtaDinero		char(10)        NULL,       
	Cobrador 		varchar(50)   	NULL,
	Condicion 		varchar(50)   	NULL,
	Vencimiento		datetime    	NULL,
	FormaCobro		varchar(50)	NULL,
	Importe   		money       	NULL,
	Impuestos	        money       	NULL,
	AplicaManual		bit		NOT NULL DEFAULT 0,
	ConDesglose		bit		NOT NULL DEFAULT 0,
	FormaCobro1 		varchar(50)   	NULL,
	FormaCobro2 		varchar(50)   	NULL,
	FormaCobro3 		varchar(50)   	NULL,
	FormaCobro4 		varchar(50)   	NULL,
	FormaCobro5 		varchar(50)   	NULL,
	Importe1		money		NULL,
	Importe2		money		NULL,
	Importe3		money		NULL,
	Importe4		money		NULL,
	Importe5		money		NULL,
	Referencia1		varchar(50)   	NULL,
	Referencia2		varchar(50)   	NULL,
	Referencia3		varchar(50)   	NULL,
	Referencia4		varchar(50)   	NULL,
	Referencia5		varchar(50)	NULL,
	Cambio			money		NULL,
	DelEfectivo		money		NULL,

	Agente			char(10)	NULL,           
	ComisionTotal		money		NULL,
	ComisionPendiente	money		NULL,

	MovAplica		char(20)	NULL,
	MovAplicaID		int		NULL,

	Saldo 		        money       	NULL,
	AutoAjuste		money		NULL,

	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		int		NULL,

	Poliza			varchar(20)     NULL,
	PolizaID		int		NULL,
	GenerarPoliza		bit	    	NOT NULL DEFAULT 0,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,
	FechaExtra1		datetime    	NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,
	Logico9			bit		NOT NULL DEFAULT 0,

	CONSTRAINT pCxc PRIMARY KEY CLUSTERED (ID)
  )")
  EXEC("CREATE INDEX Consecutivo  ON dbo.Cxc (Empresa, MovID, Mov)")
  EXEC("CREATE INDEX FechaEmision ON dbo.Cxc (Empresa, FechaEmision)")
  EXEC("CREATE INDEX Usuario      ON dbo.Cxc (Empresa, Usuario)")
  EXEC("CREATE INDEX Situacion    ON dbo.Cxc (Empresa, Estatus, Situacion)")
  EXEC("CREATE INDEX Cliente 	  ON dbo.Cxc (Empresa, Cliente)")
  EXEC("CREATE INDEX Referencia   ON dbo.Cxc (Empresa, Referencia)")
  SET IDENTITY_INSERT Cxc ON
  EXEC("INSERT Cxc (ID,Empresa,Mov,MovID,FechaEmision,UltimoCambio,Concepto,Proyecto,Moneda,TipoCambio,
      	            Usuario,Autorizacion,Referencia,DocFuente,Observaciones,Estatus,Situacion,
                    Cliente,ClienteMoneda,CtaDinero,Cobrador,Condicion,Vencimiento,FormaCobro,Importe,Impuestos,
	            AplicaManual,ConDesglose,FormaCobro1,FormaCobro2,FormaCobro3,FormaCobro4,FormaCobro5,
     	            Importe1,Importe2,Importe3,Importe4,Importe5,Referencia1,Referencia2,Referencia3,Referencia4,Referencia5,
	            Cambio,DelEfectivo,Agente,ComisionTotal,ComisionPendiente,MovAplica,MovAplicaID,Saldo,AutoAjuste,
	            OrigenTipo,Origen,OrigenID,Poliza,PolizaID,GenerarPoliza,Ejercicio,Periodo,
                    FechaRegistro,FechaConclusion,FechaCancelacion,FechaExtra1)
             SELECT ID,Empresa,Mov,MovID,FechaEmision,UltimoCambio,Concepto,Proyecto,Moneda,TipoCambio,
      	            Usuario,Autorizacion,Referencia,DocFuente,Observaciones,Estatus,Situacion,
                    Cliente,ClienteMoneda,CtaDinero,Cobrador,Condicion,Vencimiento,FormaCobro,Importe,Impuestos,
	            AplicaManual,ConDesglose,FormaCobro1,FormaCobro2,FormaCobro3,FormaCobro4,FormaCobro5,
     	            Importe1,Importe2,Importe3,Importe4,Importe5,Referencia1,Referencia2,Referencia3,Referencia4,Referencia5,
	            Cambio,DelEfectivo,Agente,ComisionTotal,ComisionPendiente,MovAplica,MovAplicaID,Saldo,AutoAjuste,
	            OrigenTipo,Origen,OrigenID,Poliza,PolizaID,GenerarPoliza,Ejercicio,Periodo,
                    FechaRegistro,FechaConclusion,FechaCancelacion,FechaExtra1 
               FROM Temporal")
  SET IDENTITY_INSERT Cxc OFF
  EXEC("DROP TABLE Temporal")
END
GO

/* Cxp */
IF (SELECT Version FROM Version)<=209
BEGIN
  IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxp') and c.name = 'AutoAjuste' and o.sysstat & 0xf = 3)
     ALTER TABLE Cxp ADD AutoAjuste money NULL
END
IF (SELECT Version FROM Version)<=209 AND NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxp') and c.name = 'Logico1' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename Cxp, Temporal")
  EXEC("CREATE TABLE dbo.Cxp (
	ID 			int         	NOT NULL IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov  			char(20)        NOT NULL,
	MovID			int         	NULL,	 
	FechaEmision 		datetime    	NULL,	 
	UltimoCambio 		datetime    	NULL,
	Concepto		varchar(50)	NULL,
	Proyecto  		varchar(50)   	NULL,
	Moneda 			char(10)   	NOT NULL,
	TipoCambio		float		NULL,
	Usuario 		char(10)   	NULL,
	Autorizacion		char(10)	NULL,
	Referencia 		varchar(50) 	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Estatus 		char(15)   	NULL,
	Situacion		varchar(50)	NULL,

	Proveedor  		char(10)   	NOT NULL,
        ProveedorMoneda		char(10)	NULL,
	CtaDinero		char(10)        NULL,       
	Condicion 		varchar(50)   	NULL,
	Vencimiento		datetime    	NULL,
	FormaPago		varchar(50)	NULL,
	Importe   		money       	NULL,
	Impuestos	        money       	NULL,
	AplicaManual		bit		NOT NULL DEFAULT 0,

	MovAplica		char(20)	NULL,
	MovAplicaID		int		NULL,

	Saldo 		        money       	NULL,
	AutoAjuste		money		NULL,

	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		int		NULL,

	Poliza			varchar(20)     NULL,
	PolizaID		int		NULL,
	GenerarPoliza		bit	    	NOT NULL DEFAULT 0,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,
	Logico9			bit		NOT NULL DEFAULT 0,

	CONSTRAINT pCxp PRIMARY KEY CLUSTERED (ID)
  )")
  EXEC("CREATE INDEX Consecutivo  ON dbo.Cxp (Empresa, MovID, Mov)")
  EXEC("CREATE INDEX FechaEmision ON dbo.Cxp (Empresa, FechaEmision)")
  EXEC("CREATE INDEX Usuario      ON dbo.Cxp (Empresa, Usuario)")
  EXEC("CREATE INDEX Situacion    ON dbo.Cxp (Empresa, Estatus, Situacion)")
  EXEC("CREATE INDEX Proveedor 	  ON dbo.Cxp (Empresa, Proveedor)")
  EXEC("CREATE INDEX Referencia   ON dbo.Cxp (Empresa, Referencia)")
  SET IDENTITY_INSERT Cxp ON
  EXEC("INSERT Cxp (ID,Empresa,Mov,MovID,FechaEmision,UltimoCambio,Concepto,Proyecto,Moneda,TipoCambio,
	            Usuario,Autorizacion,Referencia,DocFuente,Observaciones,Estatus,Situacion,
                    Proveedor,ProveedorMoneda,CtaDinero,Condicion,Vencimiento,FormaPago,Importe,Impuestos,AplicaManual,
     	            MovAplica,MovAplicaID,Saldo,AutoAjuste,OrigenTipo,Origen,OrigenID,Poliza,PolizaID,GenerarPoliza,
        	    Ejercicio,Periodo,FechaRegistro,FechaConclusion,FechaCancelacion)
             SELECT ID,Empresa,Mov,MovID,FechaEmision,UltimoCambio,Concepto,Proyecto,Moneda,TipoCambio,
	            Usuario,Autorizacion,Referencia,DocFuente,Observaciones,Estatus,Situacion,
                    Proveedor,ProveedorMoneda,CtaDinero,Condicion,Vencimiento,FormaPago,Importe,Impuestos,AplicaManual,
     	            MovAplica,MovAplicaID,Saldo,AutoAjuste,OrigenTipo,Origen,OrigenID,Poliza,PolizaID,GenerarPoliza,
        	    Ejercicio,Periodo,FechaRegistro,FechaConclusion,FechaCancelacion
               FROM Temporal")
  SET IDENTITY_INSERT Cxp OFF
  EXEC("DROP TABLE Temporal")
END
GO


/* Dinero */
if (SELECT Version FROM Version)<=209 AND not exists(select * from sysobjects where id = object_id('dbo.Dinero') and sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Banco',  'Dinero'")
  EXEC("sp_rename 'BancoD', 'DineroD'")
  EXEC("sp_rename 'BancoC', 'DineroC'")
END
if (SELECT Version FROM Version)<=213 
BEGIN
  EXEC("UPDATE Auxiliar SET Rama    = 'DIN' WHERE Rama    = 'BCOS'")
  EXEC("UPDATE Auxiliar SET Modulo  = 'DIN' WHERE Modulo  = 'BCOS'")
  EXEC("UPDATE Acum     SET Rama    = 'DIN' WHERE Rama    = 'BCOS'")
  EXEC("UPDATE Saldo    SET Rama    = 'DIN' WHERE Rama    = 'BCOS'")
  EXEC("UPDATE Mov      SET Modulo  = 'DIN' WHERE Modulo  = 'BCOS'")
  EXEC("UPDATE MovFlujo SET OModulo = 'DIN' WHERE OModulo = 'BCOS'")
  EXEC("UPDATE MovFlujo SET DModulo = 'DIN' WHERE DModulo = 'BCOS'")
END
IF (SELECT Version FROM Version)<=209 AND NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Dinero') and c.name = 'Logico1' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename Dinero, Temporal")
  EXEC("CREATE TABLE dbo.Dinero (
	ID 			int         	NOT NULL IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov 			char(20)        NOT NULL,
	MovID			int         	NULL,
	FechaEmision 		datetime    	NULL,
	UltimoCambio 		datetime    	NULL,
	Concepto		varchar(50)   	NULL,
	Proyecto		varchar(50)   	NULL,
	Moneda  		char(10)   	NOT NULL,
	TipoCambio		float		NULL,        
	Referencia 		varchar(50) 	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Usuario 		char(10)   	NULL,
	Autorizacion		char(10)	NULL,
	Estatus 		char(15)   	NULL,
	Situacion		varchar(50)	NULL,
	Directo			bit		NOT NULL DEFAULT 1,

	BeneficiarioNombre	varchar(100)   	NULL,	     
        Beneficiario		int		NULL,
	CtaDinero 		char(10)   	NULL,
	CtaDineroDestino	char(10)   	NULL,
	ConDesglose		bit		NOT NULL	DEFAULT 0,         

	Importe   		money       	NULL,
	Comisiones		money	    	NULL,
	Impuestos	        money       	NULL,
	Saldo			money		NULL,
	FechaProgramada		datetime	NULL,

	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		int		NULL,

	Poliza			varchar(20)     NULL,
	PolizaID		int		NULL,
	GenerarPoliza		bit	    	NOT NULL DEFAULT 0,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,
	Logico9			bit		NOT NULL DEFAULT 0,

	CONSTRAINT pDinero PRIMARY KEY CLUSTERED (ID)
  )")
  EXEC("CREATE INDEX Consecutivo  ON dbo.Dinero (Empresa, MovID, Mov)")
  EXEC("CREATE INDEX FechaEmision ON dbo.Dinero (Empresa, FechaEmision)")
  EXEC("CREATE INDEX Usuario      ON dbo.Dinero (Empresa, Usuario)")
  EXEC("CREATE INDEX Situacion    ON dbo.Dinero (Empresa, Estatus, Situacion)")
  EXEC("CREATE INDEX CtaDinero    ON dbo.Dinero (Empresa, CtaDinero)")
  SET IDENTITY_INSERT Dinero ON
  EXEC("INSERT Dinero (ID,Empresa,Mov,MovID,FechaEmision,UltimoCambio,Concepto,Proyecto,Moneda,TipoCambio,Referencia,DocFuente,Observaciones,
   	              Usuario,Autorizacion,Estatus,Situacion,Directo,BeneficiarioNombre,Beneficiario,CtaDinero,CtaDineroDestino,ConDesglose,
    	              Importe,Comisiones,Impuestos,Saldo,FechaProgramada,OrigenTipo,Origen,OrigenID,Poliza,PolizaID,GenerarPoliza,
	              Ejercicio,Periodo,FechaRegistro,FechaConclusion,FechaCancelacion)
               SELECT ID,Empresa,Mov,MovID,FechaEmision,UltimoCambio,Concepto,Proyecto,Moneda,TipoCambio,Referencia,DocFuente,Observaciones,
   	              Usuario,Autorizacion,Estatus,Situacion,Directo,BeneficiarioNombre,Beneficiario,CtaDinero,CtaDineroDestino,ConDesglose,
    	              Importe,Comisiones,Impuestos,Saldo,FechaProgramada,OrigenTipo,Origen,OrigenID,Poliza,PolizaID,GenerarPoliza,
	              Ejercicio,Periodo,FechaRegistro,FechaConclusion,FechaCancelacion 
                 FROM Temporal")
  SET IDENTITY_INSERT Dinero OFF
  EXEC("DROP TABLE Temporal")
END
GO


/* Venta */
IF (SELECT Version FROM Version)<=209 
BEGIN
  IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'Opcion' and o.sysstat & 0xf = 3)
    ALTER TABLE Venta ADD Opcion varchar(50) NULL
  IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'CtaDinero' and o.sysstat & 0xf = 3)
    ALTER TABLE Venta ADD CtaDinero char(10) NULL
  IF (SELECT Version FROM Version)<=200 AND EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'SubTotal' and o.sysstat & 0xf = 3)
    EXEC sp_rename 'Venta.SubTotal', 'Importe', 'COLUMN'
END

IF (SELECT Version FROM Version)<=209 AND NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'Logico1' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename Venta, Temporal")
  EXEC("CREATE TABLE dbo.Venta (
	ID			int 	    	NOT NULL  IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov 			char(20)        NOT NULL,
	MovID			int         	NULL,
	FechaEmision 		datetime    	NULL,
	UltimoCambio 		datetime    	NULL,
	Concepto		varchar(50)	NULL,
	Proyecto  		varchar(50)   	NULL,
	Moneda  		char(10)   	NOT NULL, 
	TipoCambio		float		NULL,
	Usuario 		char(10)   	NULL,
	Autorizacion		char(10)	NULL,
	Referencia 		varchar(50) 	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Estatus 		char(15)   	NULL,
	Situacion		varchar(50)	NULL,
	Directo			bit		NOT NULL DEFAULT 1,
	Prioridad		char(10)	NULL,
	RenglonID		int		NULL,

	Cliente 		char(10)   	NOT NULL,
	EnviarA			int	   	NULL,
	Almacen			char(10)   	NOT NULL,
	AlmacenDestino		char(10)	NULL,
	Agente 			char(10)   	NULL,
	FormaEnvio 		varchar(50)   	NULL,
	FechaEntrega		datetime    	NULL,
	FechaRequerida		datetime    	NULL,
	FechaProgramadaEnvio	datetime    	NULL,
	FechaOrdenCompra	datetime    	NULL,
	OrdenCompra		varchar(50) 	NULL,
	Condicion 		varchar(50)   	NULL,
	Vencimiento		datetime    	NULL,
	CtaDinero		char(10)	NULL,

	Descuento		varchar(30)   	NULL,
	DescuentoGlobal 	float 	    	NULL,
	Importe  		money	    	NULL,
	Impuestos		money       	NULL,
	Saldo 		        money       	NULL,
        DescuentoLineal		money		NULL,
	ComisionTotal		money		NULL,
	Opcion			varchar(50)	NULL,

	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		int		NULL,

	Poliza			varchar(20)     NULL,
	PolizaID		int		NULL,
	GenerarPoliza		bit	    	NOT NULL DEFAULT 0,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,
	Logico9			bit		NOT NULL DEFAULT 0,

	CONSTRAINT pVenta PRIMARY KEY CLUSTERED (ID)
  )")
  EXEC("CREATE INDEX Consecutivo  ON dbo.Venta (Empresa, MovID, Mov)")
  EXEC("CREATE INDEX FechaEmision ON dbo.Venta (Empresa, FechaEmision)")
  EXEC("CREATE INDEX Usuario      ON dbo.Venta (Empresa, Usuario)")
  EXEC("CREATE INDEX Situacion    ON dbo.Venta (Empresa, Estatus, Situacion)")
  EXEC("CREATE INDEX Cliente      ON dbo.Venta (Empresa, Cliente)")
  SET IDENTITY_INSERT Venta ON
  EXEC("INSERT Venta (ID,Empresa,Mov,MovID,FechaEmision,UltimoCambio,Concepto,Proyecto,Moneda,TipoCambio,
 	              Usuario,Autorizacion,Referencia,DocFuente,Observaciones,Estatus,Situacion,Directo,Prioridad,RenglonID,
	              Cliente,EnviarA,Almacen,AlmacenDestino,Agente,FormaEnvio,FechaEntrega,FechaRequerida,FechaProgramadaEnvio,
	              FechaOrdenCompra,OrdenCompra,Condicion,Vencimiento,CtaDinero,Descuento,DescuentoGlobal,Importe,Impuestos,
	              Saldo,DescuentoLineal,ComisionTotal,Opcion,OrigenTipo,Origen,OrigenID,Poliza,PolizaID,GenerarPoliza,
	              Ejercicio,Periodo,FechaRegistro,FechaConclusion,FechaCancelacion)
               SELECT ID,Empresa,Mov,MovID,FechaEmision,UltimoCambio,Concepto,Proyecto,Moneda,TipoCambio,
 	              Usuario,Autorizacion,Referencia,DocFuente,Observaciones,Estatus,Situacion,Directo,Prioridad,RenglonID,
	              Cliente,EnviarA,Almacen,AlmacenDestino,Agente,FormaEnvio,FechaEntrega,FechaRequerida,FechaProgramadaEnvio,
	              FechaOrdenCompra,OrdenCompra,Condicion,Vencimiento,CtaDinero,Descuento,DescuentoGlobal,Importe,Impuestos,
	              Saldo,DescuentoLineal,ComisionTotal,Opcion,OrigenTipo,Origen,OrigenID,Poliza,PolizaID,GenerarPoliza,
	              Ejercicio,Periodo,FechaRegistro,FechaConclusion,FechaCancelacion
                 FROM Temporal")
  SET IDENTITY_INSERT Venta OFF
  EXEC("DROP TABLE Temporal")
END
GO

/* Compra */
IF (SELECT Version FROM Version)<=209 
BEGIN
  IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Compra') and c.name = 'Opcion' and o.sysstat & 0xf = 3)
    ALTER TABLE Compra ADD Opcion varchar(50) NULL
  IF (SELECT Version FROM Version)<=200 AND EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Compra') and c.name = 'SubTotal' and o.sysstat & 0xf = 3)
    EXEC sp_rename 'Compra.SubTotal', 'Importe', 'COLUMN'
END

IF (SELECT Version FROM Version)<=209 AND NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Compra') and c.name = 'Logico1' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename Compra, Temporal")
  EXEC("CREATE TABLE dbo.Compra (
	ID			int 	    	NOT NULL  IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov 			char(20)        NOT NULL,
	MovID			int         	NULL,
	FechaEmision 		datetime    	NULL,
	UltimoCambio 		datetime    	NULL,
	Concepto		varchar(50)	NULL,
	Proyecto		varchar(50)   	NULL,
	Moneda  		char(10)   	NOT NULL,
	TipoCambio		float		NULL,
	Usuario 		char(10)   	NULL,
	Autorizacion		char(10)	NULL,
	Referencia 		varchar(50) 	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Estatus 		char(15)   	NULL,
	Situacion		varchar(50)	NULL,
	Directo			bit		NOT NULL DEFAULT 1,
	Prioridad		char(10)	NULL,
	RenglonID		int		NULL,

	Proveedor 		char(10)   	NULL,
	FormaEnvio 		varchar(50)   	NULL,
	FechaEntrega		datetime    	NULL,
	FechaRequerida		datetime    	NULL,
	Almacen  		char(10)   	NULL,
	Condicion  		varchar(50)   	NULL,
	Vencimiento		datetime    	NULL,
	Manejo			money		NULL,
	Fletes			money		NULL,
	ActivoFijo		bit		NOT NULL DEFAULT 0,
	Opcion			varchar(50)	NULL,

	Descuento		varchar(30)   	NULL,
	DescuentoGlobal 	float 	    	NULL,  
	Importe  		money	    	NULL,  
	Impuestos		money       	NULL,  
	Saldo 		        money       	NULL,
        DescuentoLineal		money		NULL,

	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		int		NULL,

	Poliza			varchar(20)     NULL,
	PolizaID		int		NULL,
	GenerarPoliza		bit	    	NOT NULL DEFAULT 0,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,
	Logico9			bit		NOT NULL DEFAULT 0,

	CONSTRAINT pCompra PRIMARY KEY CLUSTERED (ID)
  )")
  EXEC("CREATE INDEX Consecutivo  ON dbo.Compra (Empresa, MovID, Mov)")
  EXEC("CREATE INDEX FechaEmision ON dbo.Compra (Empresa, FechaEmision)")
  EXEC("CREATE INDEX Usuario      ON dbo.Compra (Empresa, Usuario)")
  EXEC("CREATE INDEX Situacion    ON dbo.Compra (Empresa, Estatus, Situacion)")
  EXEC("CREATE INDEX Proveedor 	  ON dbo.Compra (Empresa, Proveedor)")
  EXEC("CREATE INDEX Referencia   ON dbo.Compra (Empresa, Referencia)")
  SET IDENTITY_INSERT Compra ON
  EXEC("INSERT Compra (ID,Empresa,Mov,MovID,FechaEmision,UltimoCambio,Concepto,Proyecto,Moneda,TipoCambio,
	               Usuario,Autorizacion,Referencia,DocFuente,Observaciones,Estatus,Situacion,Directo,Prioridad,RenglonID,
	               Proveedor,FormaEnvio,FechaEntrega,FechaRequerida,Almacen,Condicion,Vencimiento,Manejo,Fletes,ActivoFijo,Opcion,
	               Descuento,DescuentoGlobal,Importe,Impuestos,Saldo,DescuentoLineal,OrigenTipo,Origen,OrigenID,Poliza,PolizaID,GenerarPoliza,
	               Ejercicio,Periodo,FechaRegistro,FechaConclusion,FechaCancelacion)
                SELECT ID,Empresa,Mov,MovID,FechaEmision,UltimoCambio,Concepto,Proyecto,Moneda,TipoCambio,
	               Usuario,Autorizacion,Referencia,DocFuente,Observaciones,Estatus,Situacion,Directo,Prioridad,RenglonID,
	               Proveedor,FormaEnvio,FechaEntrega,FechaRequerida,Almacen,Condicion,Vencimiento,Manejo,Fletes,ActivoFijo,Opcion,
	               Descuento,DescuentoGlobal,Importe,Impuestos,Saldo,DescuentoLineal,OrigenTipo,Origen,OrigenID,Poliza,PolizaID,GenerarPoliza,
	               Ejercicio,Periodo,FechaRegistro,FechaConclusion,FechaCancelacion 
                  FROM Temporal")
  SET IDENTITY_INSERT Compra OFF
  EXEC("DROP TABLE Temporal")
END
GO



/* Cambio */
IF (SELECT Version FROM Version)<=209 AND NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cambio') and c.name = 'Logico1' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename Cambio, Temporal")
  EXEC("CREATE TABLE dbo.Cambio (
	ID			int 	    	NOT NULL IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov 			char(20)        NOT NULL,
	MovID			int         	NULL,
	FechaEmision 		datetime    	NULL,
	UltimoCambio 		datetime    	NULL,
	Concepto		varchar(50)	NULL,
	Proyecto		varchar(50)   	NULL,
	Usuario 		char(10)   	NULL,
	Autorizacion		char(10)	NULL,
	Referencia 		varchar(50) 	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Estatus 		char(15)   	NULL,
	Situacion		varchar(50)	NULL,

	Cliente			char(10)	NOT NULL,
	Agente			char(10)	NULL,
	Condicion		varchar(50)	NOT NULL,
	Vencimiento		datetime	NULL,

	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		int		NULL,

	Poliza			varchar(20)     NULL,
	PolizaID		int		NULL,
	GenerarPoliza		bit	    	NOT NULL 	DEFAULT 0,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,
	Logico9			bit		NOT NULL DEFAULT 0,

	CONSTRAINT pCambio PRIMARY KEY CLUSTERED (ID)
  )")
  EXEC("CREATE INDEX Consecutivo  ON dbo.Cambio (Empresa, MovID, Mov)")
  EXEC("CREATE INDEX FechaEmision ON dbo.Cambio (Empresa, FechaEmision)")
  EXEC("CREATE INDEX Usuario      ON dbo.Cambio (Empresa, Usuario)")
  EXEC("CREATE INDEX Situacion    ON dbo.Cambio (Empresa, Estatus, Situacion)")
  EXEC("CREATE INDEX Cliente 	  ON dbo.Cambio (Empresa, Cliente)")
  SET IDENTITY_INSERT Cambio ON
  EXEC("INSERT Cambio (ID,Empresa,Mov,MovID,FechaEmision,UltimoCambio,Concepto,Proyecto,Usuario,Autorizacion,
	               Referencia,DocFuente,Observaciones,Estatus,Situacion,Cliente,Agente,Condicion,Vencimiento,
	               OrigenTipo,Origen,OrigenID,Poliza,PolizaID,GenerarPoliza,Ejercicio,Periodo,FechaRegistro,FechaConclusion,FechaCancelacion)
                SELECT ID,Empresa,Mov,MovID,FechaEmision,UltimoCambio,Concepto,Proyecto,Usuario,Autorizacion,
	               Referencia,DocFuente,Observaciones,Estatus,Situacion,Cliente,Agente,Condicion,Vencimiento,
	               OrigenTipo,Origen,OrigenID,Poliza,PolizaID,GenerarPoliza,Ejercicio,Periodo,FechaRegistro,FechaConclusion,FechaCancelacion 
                  FROM Temporal")
  SET IDENTITY_INSERT Cambio OFF
  EXEC("DROP TABLE Temporal")
END
GO

/* EmpresaCfg */
IF (SELECT Version FROM Version)<=209 
BEGIN
  IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'VentaSurtirDemas' and o.sysstat & 0xf = 3)
  BEGIN
    ALTER TABLE EmpresaCfg ADD VentaSurtirDemas char(20)	NULL DEFAULT 'No'
    EXEC("UPDATE EmpresaCfg SET VentaSurtirDemas = DEFAULT")  
  END
  IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CxcMoratoriosTasa' and o.sysstat & 0xf = 3)
    ALTER TABLE EmpresaCfg ADD CxcMoratoriosTasa float NULL
  IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CxcRefinanciamientoTasa' and o.sysstat & 0xf = 3)
    ALTER TABLE EmpresaCfg ADD CxcRefinanciamientoTasa float NULL
  IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CxcAutoAjuste' and o.sysstat & 0xf = 3)
  BEGIN
    ALTER TABLE EmpresaCfg ADD CxcAutoAjuste money NULL DEFAULT 1
    EXEC("UPDATE EmpresaCfg SET CxcAutoAjuste = DEFAULT")  
  END
  IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CxpAutoAjuste' and o.sysstat & 0xf = 3)
  BEGIN
    ALTER TABLE EmpresaCfg ADD CxpAutoAjuste money NULL DEFAULT 1
    EXEC("UPDATE EmpresaCfg SET CxpAutoAjuste = DEFAULT")  
  END
  IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'ContVerificarIVA' and o.sysstat & 0xf = 3)
  BEGIN
    ALTER TABLE EmpresaCfg ADD ContVerificarIVA char(3)	NULL DEFAULT 'No'
    EXEC("UPDATE EmpresaCfg SET ContVerificarIVA = DEFAULT")  
  END
  IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'ContCentrosCostos' and o.sysstat & 0xf = 3)
  BEGIN
    ALTER TABLE EmpresaCfg ADD ContCentrosCostos char(3)	NULL DEFAULT 'No'
    EXEC("UPDATE EmpresaCfg SET ContCentrosCostos = 'Si'")  
  END
  IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'VentaChecarCredito' and o.sysstat & 0xf = 3)
  BEGIN
    ALTER TABLE EmpresaCfg ADD VentaChecarCredito	char(20) NULL DEFAULT 'Pedido'
    EXEC("UPDATE EmpresaCfg SET VentaChecarCredito = DEFAULT")  
  END
  IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'eChequesPendientes' and o.sysstat & 0xf = 3)
  BEGIN
    ALTER TABLE EmpresaCfg ADD eChequesPendientes	char(20) NULL DEFAULT 'No'
    EXEC("UPDATE EmpresaCfg SET eChequesPendientes = DEFAULT")  
    EXEC("UPDATE EmpresaCfg SET ChequesPendientes = 'Si' WHERE ChequesPendientes = 'Siempre'")
  END
  IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'VentaBloquearMorosos' and o.sysstat & 0xf = 3)
  BEGIN
    ALTER TABLE EmpresaCfg ADD VentaBloquearMorosos char(20) NULL DEFAULT 'No'
    EXEC("UPDATE EmpresaCfg SET VentaBloquearMorosos = DEFAULT")  
  END
  IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CtaActivo' and o.sysstat & 0xf = 3)
    ALTER TABLE EmpresaCfg ADD CtaActivo char(20)	NULL DEFAULT 'B'
  IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CtaPasivo' and o.sysstat & 0xf = 3)
    ALTER TABLE EmpresaCfg ADD CtaPasivo char(20) NULL DEFAULT 'H'
  IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CtaCapital' and o.sysstat & 0xf = 3)
    ALTER TABLE EmpresaCfg ADD CtaCapital	char(20) NULL DEFAULT 'Q'
  IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CtaIngresos' and o.sysstat & 0xf = 3)
    ALTER TABLE EmpresaCfg ADD CtaIngresos char(20) NULL DEFAULT 'S'
  IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CtaCostoDirecto' and o.sysstat & 0xf = 3)
    ALTER TABLE EmpresaCfg ADD CtaCostoDirecto char(20) NULL DEFAULT 'T'
  IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CxcFormaCobroDA' and o.sysstat & 0xf = 3)
  BEGIN
    ALTER TABLE EmpresaCfg ADD CxcFormaCobroDA varchar(50) NULL DEFAULT 'Deposito Anticipado'
    EXEC("UPDATE EmpresaCfg SET CxcFormaCobroDA = DEFAULT")  
    IF NOT EXISTS(SELECT * FROM FormaPago WHERE FormaPago = 'Deposito Anticipado')
      INSERT FormaPago (FormaPago) VALUES ('Deposito Anticipado')
  END
  IF (SELECT Version FROM Version)<=206 AND EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'VentaLiquidaDirecto' and o.sysstat & 0xf = 3)
    EXEC sp_rename 'EmpresaCfg.VentaLiquidaDirecto', 'VentaLiquidaIntegral', 'COLUMN'
  IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'VentaPrecios' and o.sysstat & 0xf = 3)
  BEGIN
    ALTER TABLE EmpresaCfg ADD VentaPrecios int NULL DEFAULT 1
    EXEC("UPDATE EmpresaCfg SET VentaPrecios = DEFAULT")  
  END
END

IF (SELECT Version FROM Version)<=209 AND NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'Logico1' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename EmpresaCfg, Temporal")
  EXEC("CREATE TABLE dbo.EmpresaCfg (
	Empresa 			char(5)  	NOT NULL,

	FormaCosteo			char(20)	NULL 		DEFAULT 'Empresa',
	TipoCosteo			char(20)	NULL 		DEFAULT 'Promedio',
	ValidarMargenMinimo		char(20)	NULL		DEFAULT 'No',
	SeriesLotesMayoreo		bit		NOT NULL	DEFAULT 0,
	SeriesLotesAutoCampo		char(20)     	NULL 		DEFAULT 'Numero',
	SeriesLotesAutoOrden		char(20)     	NULL 		DEFAULT 'ASCENDENTE',
	PresentacionAutoOrden		char(20)     	NULL 		DEFAULT 'Unidades Primero',
        CB				bit		NOT NULL	DEFAULT 1,
	CBSubCodigos			bit		NOT NULL 	DEFAULT 0,
	CBSubCuentas			bit		NOT NULL 	DEFAULT 0,
	CxcAplicaAutoOrden		char(20)     	NULL 		DEFAULT 'Fecha Vencimiento',
	CxpAplicaAutoOrden		char(20)     	NULL 		DEFAULT 'Fecha Vencimiento',
	PedidosReservar			bit		NOT NULL 	DEFAULT 1,
	CompraConsignacion		char(20)	NULL 		DEFAULT 'No',
	CompraCostoSugerido		char(20)	NULL		DEFAULT 'Ultimo',
	CompraDescImporte		bit		NOT NULL	DEFAULT 0,
	VentaDescImporte		bit		NOT NULL	DEFAULT 0,
	VentaChecarCredito		char(20)	NULL	        DEFAULT 'Pedido',
	VentaBloquearMorosos		char(20)	NULL		DEFAULT 'No',
        VentaLiquidaIntegral   		bit		NOT NULL 	DEFAULT 1,
	BackOrders			bit		NOT NULL	DEFAULT 0,
	VentaSurtirDemas		bit		NOT NULL	DEFAULT 0,
	VentaPrecios			int		NULL		DEFAULT 1,
	CxcMoratoriosTasa		float		NULL,
	CxcRefinanciamientoTasa		float		NULL,
	CxcAutoAjuste			money		NULL		DEFAULT 1,
	CxcFormaCobroDA  		varchar(50)	NULL		DEFAULT 'Deposito Anticipado',
	CxpAutoAjuste			money		NULL		DEFAULT 1,
	ChequesPendientes		bit		NOT NULL	DEFAULT 0,
	eChequesPendientes		bit		NOT NULL	DEFAULT 0,
	CtaFormato			char(20)	NULL		DEFAULT '999-99-999;2',
	ContMoneda			char(20)	NULL		DEFAULT 'Pesos',
	ContVerificarPosicion		bit		NOT NULL	DEFAULT 1,
	ContEjercicioInicio		datetime	NULL,
	ContEjercicioFinal		datetime	NULL,
	ContVerificarIVA		bit		NOT NULL	DEFAULT 0,
	ContCentrosCostos		bit		NOT NULL	DEFAULT 0,
	CtaContabilidad			char(20)	NULL		DEFAULT 'A',
	CtaActivo			char(20)	NULL		DEFAULT 'B',
	CtaPasivo			char(20)	NULL		DEFAULT 'H',
	CtaCapital			char(20)	NULL		DEFAULT 'Q',
	CtaResultados			char(20)	NULL		DEFAULT 'R',
	CtaIngresos			char(20)	NULL		DEFAULT 'S',
	CtaCostoDirecto			char(20)	NULL		DEFAULT 'T',
	CtaOrden			char(20)	NULL		DEFAULT 'X',
	AutorizarRequisiciones		bit		NOT NULL	DEFAULT 0,

	Logico1				bit		NOT NULL 	DEFAULT 0,
	Logico2				bit		NOT NULL 	DEFAULT 0,
	Logico3				bit		NOT NULL 	DEFAULT 0,
	Logico4				bit		NOT NULL 	DEFAULT 0,
	Logico5				bit		NOT NULL 	DEFAULT 0,
	Logico6				bit		NOT NULL 	DEFAULT 0,
	Logico7				bit		NOT NULL 	DEFAULT 0,
	Logico8				bit		NOT NULL 	DEFAULT 0,
	Logico9				bit		NOT NULL 	DEFAULT 0,
	Logico10			bit		NOT NULL 	DEFAULT 0,
	Logico11			bit		NOT NULL 	DEFAULT 0,
	Logico12			bit		NOT NULL 	DEFAULT 0,
	Logico13			bit		NOT NULL 	DEFAULT 0,
	Logico14			bit		NOT NULL 	DEFAULT 0,
	Logico15			bit		NOT NULL 	DEFAULT 0,
	Logico16			bit		NOT NULL 	DEFAULT 0,
	Logico17			bit		NOT NULL 	DEFAULT 0,
	Logico18			bit		NOT NULL 	DEFAULT 0,
	Logico19			bit		NOT NULL 	DEFAULT 0,
	Logico20			bit		NOT NULL 	DEFAULT 0,
	Logico21			bit		NOT NULL 	DEFAULT 0,
	Logico22			bit		NOT NULL 	DEFAULT 0,
	Logico23			bit		NOT NULL 	DEFAULT 0,
	Logico24			bit		NOT NULL 	DEFAULT 0,
	Logico25			bit		NOT NULL 	DEFAULT 0,
	Logico26			bit		NOT NULL 	DEFAULT 0,
	Logico27			bit		NOT NULL 	DEFAULT 0,
	Logico28			bit		NOT NULL 	DEFAULT 0,
	Logico29			bit		NOT NULL 	DEFAULT 0,
	Logico30			bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT pEmpresaCfg PRIMARY KEY  CLUSTERED (Empresa)
  )")
  EXEC("INSERT EmpresaCfg (Empresa,FormaCosteo,TipoCosteo,ValidarMargenMinimo,SeriesLotesMayoreo,SeriesLotesAutoCampo,SeriesLotesAutoOrden,PresentacionAutoOrden,CB,CBSubCodigos,CBSubCuentas,CxcAplicaAutoOrden,
                           CxpAplicaAutoOrden,CompraConsignacion,CompraCostoSugerido,CompraDescImporte,VentaDescImporte,VentaChecarCredito,VentaBloquearMorosos,
                           BackOrders,VentaPrecios,CxcMoratoriosTasa,CxcRefinanciamientoTasa,CxcAutoAjuste,CxcFormaCobroDA,CxpAutoAjuste,CtaFormato,ContMoneda,ContVerificarPosicion,ContEjercicioInicio,ContEjercicioFinal,
                           CtaContabilidad,CtaActivo,CtaPasivo,CtaCapital,CtaResultados,CtaIngresos,CtaCostoDirecto,CtaOrden,AutorizarRequisiciones)
                    SELECT Empresa,FormaCosteo,TipoCosteo,ValidarMargenMinimo,SeriesLotesMayoreo,SeriesLotesAutoCampo,SeriesLotesAutoOrden,PresentacionAutoOrden,CB,CBSubCodigos,CBSubCuentas,CxcAplicaAutoOrden,
                           CxpAplicaAutoOrden,CompraConsignacion,CompraCostoSugerido,CompraDescImporte,VentaDescImporte,VentaChecarCredito,VentaBloquearMorosos,
                           BackOrders,VentaPrecios,CxcMoratoriosTasa,CxcRefinanciamientoTasa,CxcAutoAjuste,CxcFormaCobroDA,CxpAutoAjuste,CtaFormato,ContMoneda,ContVerificarPosicion,ContEjercicioInicio,ContEjercicioFinal,
                           CtaContabilidad,CtaActivo,CtaPasivo,CtaCapital,CtaResultados,CtaIngresos,CtaCostoDirecto,CtaOrden,AutorizarRequisiciones
                  FROM Temporal")
  EXEC("DROP TABLE Temporal")
END
GO


/* EmpresaGral */
IF (SELECT Version FROM Version)<=209 
BEGIN
  IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'DirectorioCodigo' and o.sysstat & 0xf = 3)
    ALTER TABLE EmpresaGral ADD DirectorioCodigo varchar(255) NULL
  IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'CteExpressDef' and o.sysstat & 0xf = 3)
  BEGIN
    ALTER TABLE EmpresaGral ADD CteExpressDef char(20) NULL DEFAULT '(CONSECUTIVO)'
    EXEC("UPDATE EmpresaGral SET CteExpressDef = DEFAULT")  
  END
  IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'CteExpressPrefijo' and o.sysstat & 0xf = 3)
  BEGIN
    ALTER TABLE EmpresaGral ADD CteExpressPrefijo char(5) NULL DEFAULT 'C'
    EXEC("UPDATE EmpresaGral SET CteExpressPrefijo = DEFAULT")  
  END
  IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'CteExpressDigitos' and o.sysstat & 0xf = 3)
  BEGIN
    ALTER TABLE EmpresaGral ADD CteExpressDigitos int NULL DEFAULT 3
    EXEC("UPDATE EmpresaGral SET CteExpressDigitos = DEFAULT")  
  END
  IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'CteExpressCategoria' and o.sysstat & 0xf = 3)
    ALTER TABLE EmpresaGral ADD CteExpressCategoria varchar(50) NULL
END

IF (SELECT Version FROM Version)<=209 AND NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'Logico1' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename EmpresaGral, Temporal")
  EXEC("CREATE TABLE dbo.EmpresaGral (
	Empresa 			char(5)  	NOT NULL,

	EmpresaDinero			char(5)		NULL		DEFAULT 'Misma',
	EmpresaCont			char(5)		NULL		DEFAULT 'Misma',
	DiasHabiles			char(20)	NULL		DEFAULT 'Lun-Vie',
	ClaveDesarrollo			char(20)	NULL,
	DirectorioCodigo		varchar(150)	NULL,

	AlmacenTransito			char(20)	NULL 		DEFAULT '(TRANSITO)',
	DefArtTipo			char(20)	NULL		DEFAULT 'Normal',
	DefImpuesto			float		NULL		DEFAULT 15.0,
	DefUnidad			char(20)	NULL		DEFAULT 'Piezas',
	DefCondicion			varchar(50)	NULL,
	TiposPresupuesto		bit		NOT NULL	DEFAULT 0,
	CteExpressDef			char(20)	NULL		DEFAULT '(CONSECUTIVO)',
	CteExpressPrefijo		char(5)		NULL		DEFAULT 'C',
	CteExpressDigitos		int		NULL		DEFAULT 3,
	CteExpressCategoria		varchar(50)	NULL,

	ContX       			bit		NOT NULL	DEFAULT 0,
	ContXAfectar   			bit		NOT NULL	DEFAULT 0,

	Logico1				bit		NOT NULL 	DEFAULT 0,
	Logico2				bit		NOT NULL 	DEFAULT 0,
	Logico3				bit		NOT NULL 	DEFAULT 0,
	Logico4				bit		NOT NULL 	DEFAULT 0,
	Logico5				bit		NOT NULL 	DEFAULT 0,
	Logico6				bit		NOT NULL 	DEFAULT 0,
	Logico7				bit		NOT NULL 	DEFAULT 0,
	Logico8				bit		NOT NULL 	DEFAULT 0,
	Logico9				bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT pEmpresaGral PRIMARY KEY  CLUSTERED (Empresa)
  )")
  EXEC("INSERT EmpresaGral (Empresa,EmpresaDinero,EmpresaCont,DiasHabiles,ClaveDesarrollo,DirectorioCodigo,
	                    AlmacenTransito,DefArtTipo,DefImpuesto,DefUnidad,DefCondicion,TiposPresupuesto,
      	                    CteExpressDef,CteExpressPrefijo,CteExpressDigitos,CteExpressCategoria,ContX,ContXAfectar)
                     SELECT Empresa,EmpresaDinero,EmpresaCont,DiasHabiles,ClaveDesarrollo,DirectorioCodigo,
	                    AlmacenTransito,DefArtTipo,DefImpuesto,DefUnidad,DefCondicion,TiposPresupuesto,
      	                    CteExpressDef,CteExpressPrefijo,CteExpressDigitos,CteExpressCategoria,ContX,ContXAfectar
                       FROM Temporal")
  EXEC("DROP TABLE Temporal")
END
GO


/* Usuario */
IF (SELECT Version FROM Version)<=209 AND NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'DefCtaDinero' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename Usuario, Temporal")
  EXEC("CREATE TABLE dbo.Usuario (
	Usuario 			char(10)  	NOT NULL,

	Nombre 				varchar(100) 	NULL,
	GrupoTrabajo			varchar(50)	NULL,
	Contrasena			char(10) 	NULL,
	Telefono 			varchar(100)  	NULL,
	Extencion 			varchar(10) 	NULL,

	DefAgente			char(10)	NULL,
	DefAlmacen			char(10)	NULL,
	DefCtaDinero			char(10)	NULL,
        DefMoneda			char(10)	NULL,
	DefProyecto			varchar(50)	NULL,
	DefCliente			char(10)	NULL,
	Afectar				bit		NOT NULL	DEFAULT 1,
	Cancelar			bit		NOT NULL	DEFAULT 1,
	Desafectar			bit		NOT NULL	DEFAULT 0,
	AfectarOtrosMovs		bit		NOT NULL	DEFAULT 0,
	CancelarOtrosMovs		bit		NOT NULL	DEFAULT 0,
	ConsultarOtrosMovs		bit		NOT NULL	DEFAULT 0,
	ModificarOtrosMovs		bit		NOT NULL	DEFAULT 0,
	ModificarVencimientos		bit		NOT NULL	DEFAULT 0,
	ModificarEntregas		bit		NOT NULL	DEFAULT 0,
	ModificarEnvios			bit		NOT NULL	DEFAULT 0,
	ModificarReferencias		bit		NOT NULL	DEFAULT 0,
	ModificarAlmacenEntregas 	bit		NOT NULL	DEFAULT 0,
	AgregarCteExpress	 	bit		NOT NULL	DEFAULT 0,
	Costos				bit		NOT NULL	DEFAULT 0,
	VerInfoDeudores			bit		NOT NULL	DEFAULT 0,
	VerInfoAcreedores		bit		NOT NULL	DEFAULT 0,
	BloquearEncabezadoVenta		bit		NOT NULL	DEFAULT 0,
	EnviarExcel			bit		NOT NULL	DEFAULT 1,
	ImprimirMovs			bit		NOT NULL	DEFAULT 1,
	PreliminarMovs			bit		NOT NULL	DEFAULT 1,

	Estatus				char(15) 	NULL	DEFAULT 'ACTIVO',
	UltimoCambio			datetime  	NULL,
	Alta				datetime	NULL,

	Logico1				bit		NOT NULL 	DEFAULT 0,
	Logico2				bit		NOT NULL 	DEFAULT 0,
	Logico3				bit		NOT NULL 	DEFAULT 0,
	Logico4				bit		NOT NULL	DEFAULT 0,
	Logico5				bit		NOT NULL	DEFAULT 0,
	Logico6				bit		NOT NULL 	DEFAULT 0,
	Logico7				bit		NOT NULL 	DEFAULT 0,
	Logico8				bit		NOT NULL 	DEFAULT 0,
	Logico9				bit		NOT NULL	DEFAULT 0,
	Logico10			bit		NOT NULL 	DEFAULT 0,
	Logico11			bit		NOT NULL 	DEFAULT 0,
	Logico12			bit		NOT NULL 	DEFAULT 0,
	Logico13			bit		NOT NULL 	DEFAULT 0,
	Logico14			bit		NOT NULL 	DEFAULT 0,
	Logico15			bit		NOT NULL 	DEFAULT 0,
	Logico16			bit		NOT NULL 	DEFAULT 0,
	Logico17			bit		NOT NULL 	DEFAULT 0,
	Logico18			bit		NOT NULL 	DEFAULT 0,
	Logico19			bit		NOT NULL 	DEFAULT 0,
	Logico20			bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT prUsuario PRIMARY KEY CLUSTERED (Usuario)
  )")
  EXEC("INSERT Usuario (Usuario,Nombre,GrupoTrabajo,Contrasena,Telefono,Extencion,
	                DefAgente,DefAlmacen,DefCtaDinero,DefMoneda,DefProyecto,DefCliente,
	                Afectar,Cancelar,Desafectar,AfectarOtrosMovs,CancelarOtrosMovs,ConsultarOtrosMovs,
	                ModificarOtrosMovs,ModificarVencimientos,ModificarEntregas,ModificarEnvios,ModificarReferencias,
	                Estatus,UltimoCambio,Alta)
                 SELECT Usuario,Nombre,GrupoTrabajo,Contrasena,Telefono,Extencion,
	                DefAgente,DefAlmacen,DefCtaBanco,DefMoneda,DefProyecto,DefCliente,
	                Afectar,Cancelar,Desafectar,AfectarOtrosMovs,CancelarOtrosMovs,ConsultarOtrosMovs,
	                ModificarOtrosMovs,ModificarVencimientos,ModificarEntregas,ModificarEnvios,ModificarReferencias,
	                Estatus,UltimoCambio,Alta
                   FROM Temporal")
  EXEC("DROP TABLE Temporal")
END
GO


/****** Politicas de Precios y Descuentos ******/
IF (SELECT Version FROM Version)<=210 AND NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Precio') and c.name = 'Logico1' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename Precio, Temporal")
  EXEC("CREATE TABLE dbo.Precio (
	ID			int       	NOT NULL  IDENTITY(1,1),

	Descripcion		varchar(50)	NULL,
	Estatus			char(15)	NULL,
	UltimoCambio		datetime	NULL,

	NivelArticulo		bit		NOT NULL DEFAULT 0,
	Articulo 		char(20) 	NULL,
	NivelSubCuenta		bit		NOT NULL DEFAULT 0,
	SubCuenta		varchar(20)	NULL,
	NivelArtGrupo		bit		NOT NULL DEFAULT 0,
	ArtGrupo  		varchar(50) 	NULL,
	NivelArtCat		bit		NOT NULL DEFAULT 0,
	ArtCat  		varchar(50) 	NULL,
	NivelArtFam		bit		NOT NULL DEFAULT 0,
	ArtFam  		varchar(50) 	NULL,
	NivelFabricante		bit		NOT NULL DEFAULT 0,
	Fabricante 		varchar(50) 	NULL,

	NivelCliente		bit		NOT NULL DEFAULT 0,
	Cliente 		char(10) 	NULL,
	NivelCteGrupo		bit		NOT NULL DEFAULT 0,
	CteGrupo  		varchar(50) 	NULL,
	NivelCteCat		bit		NOT NULL DEFAULT 0,
	CteCat  		varchar(50) 	NULL,
	NivelCteFam		bit		NOT NULL DEFAULT 0,
	CteFam  		varchar(50) 	NULL,
	NivelCteZona		bit		NOT NULL DEFAULT 0,
	CteZona  		varchar(50) 	NULL,

	NivelMoneda		bit		NOT NULL DEFAULT 0,
	Moneda			char(10)  	NULL,
	NivelCondicion		bit		NOT NULL DEFAULT 0,
	Condicion		varchar(50)  	NULL,
	NivelAlmacen		bit		NOT NULL DEFAULT 0,
	Almacen 		char(10)  	NULL,
	NivelProyecto		bit		NOT NULL DEFAULT 0,
	Proyecto 		varchar(50) 	NULL,
	NivelAgente		bit		NOT NULL DEFAULT 0,
	Agente			char(10)	NULL,
	NivelFormaEnvio		bit		NOT NULL DEFAULT 0,
	FormaEnvio		varchar(50)  	NULL,
	NivelMov		bit		NOT NULL DEFAULT 0,
	Mov			char(20)        NULL,
	NivelServicioTipo	bit		NOT NULL DEFAULT 0,
	ServicioTipo		varchar(50)	NULL,

	NivelEmpresa		bit		NOT NULL DEFAULT 0,
	Empresa			char(5)  	NULL,

	Tipo			char(23)	NULL,  
	Nivel			char(10)	NULL,  
	ListaPrecios		char(5)		NULL 	 DEFAULT 'Todas',

	ConVigencia		bit		NOT NULL DEFAULT 0,
        FechaD			datetime  	NULL,
	FechaA			datetime  	NULL,

	ArticuloObsequio	char(20)	NULL,
	CantidadObsequio	float		NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,

	CONSTRAINT pPrecio PRIMARY KEY CLUSTERED (ID)
  )")
  EXEC("CREATE INDEX Articulo ON dbo.Precio (Articulo)")
  EXEC("INSERT Precio (Descripcion,Estatus,UltimoCambio,NivelArticulo,Articulo,NivelSubCuenta,SubCuenta,NivelArtGrupo,ArtGrupo,
                       NivelArtCat,ArtCat,NivelArtFam,ArtFam,NivelFabricante,Fabricante,NivelCliente,Cliente,NivelCteGrupo,CteGrupo,
		       NivelCteCat,CteCat,NivelCteFam,CteFam,NivelCteZona,CteZona,NivelMoneda,Moneda,NivelCondicion,Condicion,
		       NivelAlmacen,Almacen,NivelProyecto,Proyecto,NivelAgente,Agente,NivelFormaEnvio,FormaEnvio,NivelMov,Mov,
		       NivelEmpresa,Empresa,Tipo,Nivel,ConVigencia,FechaD,FechaA,ArticuloObsequio,CantidadObsequio)
                SELECT Descripcion,Estatus,UltimoCambio,NivelArticulo,Articulo,NivelSubCuenta,SubCuenta,NivelArtGrupo,ArtGrupo,
                       NivelArtCat,ArtCat,NivelArtFam,ArtFam,NivelFabricante,Fabricante,NivelCliente,Cliente,NivelCteGrupo,CteGrupo,
		       NivelCteCat,CteCat,NivelCteFam,CteFam,NivelCteZona,CteZona,NivelMoneda,Moneda,NivelCondicion,Condicion,
		       NivelAlmacen,Almacen,NivelProyecto,Proyecto,NivelAgente,Agente,NivelFormaEnvio,FormaEnvio,NivelMov,Mov,
		       NivelEmpresa,Empresa,Tipo,Nivel,ConVigencia,FechaD,FechaA,ArticuloObsequio,CantidadObsequio
                   FROM Temporal")
  EXEC("DROP TABLE Temporal")
END
GO


/* CxcD */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CxcD') and c.name = 'Fecha' and o.sysstat & 0xf = 3)
  ALTER TABLE CxcD ADD Fecha datetime NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CxcD') and c.name = 'FechaAnterior' and o.sysstat & 0xf = 3)
  ALTER TABLE CxcD ADD FechaAnterior datetime NULL

IF (SELECT Version FROM Version)<=215 AND NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CxcD') and c.name = 'Logico1' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename CxcD, Temporal")
  EXEC("CREATE TABLE dbo.CxcD (
	ID 			int             NOT NULL,
 	Renglon			float	        NOT NULL,
	RenglonSub		int		NOT NULL   DEFAULT 0,

        Importe                 money           NULL,
	Aplica 			char(20)        NULL,
        AplicaID	        int             NULL,
	Fecha			datetime	NULL,
	FechaAnterior		datetime	NULL,

	AplicaProntoPago	bit		NOT NULL DEFAULT 0,
	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,

	CONSTRAINT pCxcD PRIMARY KEY CLUSTERED (ID,Renglon, RenglonSub)
  )")
  EXEC("INSERT CxcD (ID, Renglon, RenglonSub,Importe, Aplica, AplicaID, Fecha, FechaAnterior)
             SELECT ID, Renglon, RenglonSub,Importe, Aplica, AplicaID, Fecha, FechaAnterior
              FROM Temporal")
  EXEC("DROP TABLE Temporal")
END
GO



/* CxpD */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CxpD') and c.name = 'Fecha' and o.sysstat & 0xf = 3)
  ALTER TABLE CxpD ADD Fecha datetime NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CxpD') and c.name = 'FechaAnterior' and o.sysstat & 0xf = 3)
  ALTER TABLE CxpD ADD FechaAnterior datetime NULL
GO

IF (SELECT Version FROM Version)<=215 AND NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CxpD') and c.name = 'Logico1' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename CxpD, Temporal")
  EXEC("CREATE TABLE dbo.CxpD (
	ID 			int             NOT NULL,
 	Renglon			float	        NOT NULL,
	RenglonSub		int		NOT NULL   DEFAULT 0,

        Importe                 money           NULL,
	Aplica 			char(20)        NULL,
        AplicaID	        int             NULL,
	Fecha			datetime	NULL,
	FechaAnterior		datetime	NULL,

	AplicaProntoPago	bit		NOT NULL DEFAULT 0,
	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,

	CONSTRAINT pCxpD PRIMARY KEY CLUSTERED (ID,Renglon, RenglonSub)
  )")
  EXEC("INSERT CxpD (ID, Renglon, RenglonSub,Importe, Aplica, AplicaID, Fecha, FechaAnterior)
             SELECT ID, Renglon, RenglonSub,Importe, Aplica, AplicaID, Fecha, FechaAnterior
              FROM Temporal")
  EXEC("DROP TABLE Temporal")
END
GO

/* EmpresaConcepto */
IF (SELECT Version FROM Version)<=216 AND NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaConcepto') and c.name = 'Logico1' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename EmpresaConcepto, Temporal")
  EXEC("CREATE TABLE dbo.EmpresaConcepto (
	Empresa 			char(5)  	NOT NULL,
	Modulo				char(5)		NOT NULL,
	Mov				char(20)	NOT NULL,
	Concepto			varchar(50)	NULL,
	Requerido			bit		NOT NULL 	DEFAULT 0,
	UtilizarEste			bit		NOT NULL 	DEFAULT 0,

	Logico1				bit		NOT NULL 	DEFAULT 0,
	Logico2				bit		NOT NULL 	DEFAULT 0,
	Logico3				bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT pEmpresaConcepto PRIMARY KEY  CLUSTERED (Empresa, Modulo, Mov)
  )")
  EXEC("INSERT EmpresaConcepto (Empresa, Modulo, Mov, Concepto)
        SELECT Empresa, Modulo, Mov, Concepto
          FROM Temporal")
  EXEC("DROP TABLE Temporal")
END
GO

/* FormaEnvio */
IF (SELECT Version FROM Version)<=226 AND NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.FormaEnvio') and c.name = 'Embarcar' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename FormaEnvio, Temporal")
  EXEC("CREATE TABLE dbo.FormaEnvio (
	FormaEnvio 		varchar(50)  	NOT NULL,

	Direccion 		varchar(100)	NULL,
	Colonia 		varchar(50)  	NULL,
	CodigoPostal 		varchar(15) 	NULL,
	Poblacion 		varchar(50)  	NULL,
	Estado 			varchar(50)  	NULL,
	Pais			varchar(50)	NULL,
	Encargado 		varchar(50)  	NULL,
	Telefonos 		varchar(100)  	NULL,

	Volumen			float		NULL,
	Peso			float		NULL,

	UltimoCambio		datetime      	NULL,

	Embarcar		bit		NOT NULL DEFAULT 0,
	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,

	CONSTRAINT pFormaEnvio PRIMARY KEY CLUSTERED (FormaEnvio)
  )")
  EXEC("INSERT FormaEnvio (FormaEnvio, Direccion, Colonia, CodigoPostal, Poblacion, Estado,
		           Pais, Encargado, Telefonos, Volumen,	Peso, UltimoCambio)
        SELECT FormaEnvio, Direccion, Colonia, CodigoPostal, Poblacion, Estado,
		           Pais, Encargado, Telefonos, Volumen,	Peso, UltimoCambio
          FROM Temporal")
  EXEC("DROP TABLE Temporal")
END
GO


/* ContX */
IF (SELECT Version FROM Version)<=225 AND NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ContX') and c.name = 'ConceptoNull' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename ContX, Temporal")
  EXEC("CREATE TABLE dbo.ContX (
	ID			int		NOT NULL IDENTITY(1,1),

	Empresa			char(7)		NULL DEFAULT '(Todas)',
	Modulo			char(5)		NULL,
	Mov       		char(20)	NULL,
	Conceptos		varchar(255)	NULL,
	ContMov			varchar(255)	NULL,
	ContConcepto		varchar(255)	NULL,
	ContReferencia		varchar(255)	NULL,
	ContProyecto		varchar(255)	NULL,
	ContObservaciones	varchar(255) 	NULL,
	Condicion		varchar(255)	NULL,
	Comentarios		varchar(100)	NULL,
	Estatus			char(15)	NULL,

	ConceptoNull		bit		NOT NULL DEFAULT 0,
	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,

	CONSTRAINT pContX PRIMARY KEY CLUSTERED (ID)
  )")
  SET IDENTITY_INSERT ContX ON
  EXEC("INSERT ContX  (ID,Empresa,Modulo,Mov,Conceptos,ContMov,ContConcepto,ContReferencia,ContProyecto,ContObservaciones,Condicion,Comentarios,Estatus)
               SELECT ID,Empresa,Modulo,Mov,Conceptos,ContMov,ContConcepto,ContReferencia,ContProyecto,ContObservaciones,Condicion,Comentarios,Estatus
                FROM Temporal")
  SET IDENTITY_INSERT ContX OFF
  EXEC("DROP TABLE Temporal")
END
GO

/* ContratoTipo */
IF (SELECT Version FROM Version)<=226 AND NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ContratoTipo') and c.name = 'Modulo' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename ContratoTipo, Temporal")
  EXEC("CREATE TABLE dbo.ContratoTipo (	Modulo			char(5)		NOT NULL,
	Tipo			varchar(50) 	NOT NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,

	CONSTRAINT pContratoTipo PRIMARY KEY CLUSTERED (Modulo, Tipo)
  )")
  EXEC("INSERT ContratoTipo (Modulo, Tipo)
               SELECT 'SERV', Tipo
                FROM Temporal")
  EXEC("DROP TABLE Temporal")
END
GO

/* Monedas */
IF (SELECT Version FROM Version)<=227 AND NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Mon') and c.name = 'Logico1' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.tgMonAC') and sysstat & 0xf = 8) drop trigger dbo.tgMonAC")
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename Mon, Temporal")
  EXEC("CREATE TABLE dbo.Mon (
	Moneda	 		char(10)  	NOT NULL,
	Orden			int		NOT NULL,

	TipoCambio		float     	NULL,
	TipoCambioDolar		float     	NULL,
	Tolerancia		float     	NULL,
	UltimoCambio		datetime	NULL,
	Icono			int	  	NULL,
	CxcAjusteEfectivo	money		NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,

	CONSTRAINT pMon PRIMARY KEY CLUSTERED (Moneda)
  )")
  EXEC("INSERT Mon (Moneda, Orden, TipoCambio, TipoCambioDolar, Tolerancia, UltimoCambio, Icono, CxcAjusteEfectivo)
        SELECT Moneda, Orden, TipoCambio, TipoCambioDolar, Tolerancia, UltimoCambio, Icono, CxcAjusteEfectivo
          FROM Temporal")
  EXEC("DROP TABLE Temporal")
END
GO

/* ServicioTarea  */
IF (SELECT Version FROM Version)<=227 AND NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ServicioTarea ') and c.name = 'Logico1' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename ServicioTarea, Temporal")
  EXEC("CREATE TABLE dbo.ServicioTarea (
	ID		int		NOT NULL,
	RenglonID	int		NOT NULL  IDENTITY(1,1),
	Tarea		varchar(50)	NULL,
	Problema	varchar(255)	NULL,
	Solucion	varchar(255)	NULL,
	Estado		varchar(30)	NULL,
	Fecha		datetime	NULL,
	
	Logico1		bit		NOT NULL DEFAULT 0,
	Logico2		bit		NOT NULL DEFAULT 0,
	Logico3		bit		NOT NULL DEFAULT 0,

	CONSTRAINT pServicioTarea PRIMARY KEY CLUSTERED (ID, RenglonID)
  )")
  SET IDENTITY_INSERT ServicioTarea ON
  EXEC("INSERT ServicioTarea (ID, RenglonID, Tarea, Problema, Solucion, Estado, Fecha)
        SELECT ID, RenglonID, Tarea, Problema, Solucion, Estado, Fecha
          FROM Temporal")
  SET IDENTITY_INSERT ServicioTarea OFF
  EXEC("DROP TABLE Temporal")
  EXEC("CREATE INDEX Tarea ON dbo.ServicioTarea (Tarea)")
END
GO

/* EmpresaCfgMovImp */
IF (SELECT Version FROM Version)<=227 AND NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMovImp') and c.name = 'Estatus' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename EmpresaCfgMovImp, Temporal")
  EXEC("CREATE TABLE dbo.EmpresaCfgMovImp (
	Empresa 		char(5)  	NOT NULL,
	ID			int		NOT NULL IDENTITY (1,1),

	Modulo			char(5)		NOT NULL,
	Mov			char(20)	NOT NULL,
	Estatus			char(15)	NULL	DEFAULT '(Todos)',
	ReporteImpresora	varchar(50)	NULL,
	ReportePantalla		varchar(50)	NULL,

	CONSTRAINT pEmpresaCfgMovImp PRIMARY KEY CLUSTERED (Empresa, ID)
  )")
  EXEC("INSERT EmpresaCfgMovImp (Empresa, Modulo, Mov, ReporteImpresora, ReportePantalla)
        SELECT Empresa, Modulo, Mov, ReporteImpresora, ReportePantalla
          FROM Temporal")
  EXEC("DROP TABLE Temporal")
END
GO

/* MovTipo  */
IF (SELECT Version FROM Version)<=227 AND NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.MovTipo ') and c.name = 'Logico1' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename MovTipo, Temporal")
  EXEC("CREATE TABLE dbo.MovTipo (
	Modulo			char(5)      	NOT NULL,
	Mov 		        char(20)        NOT NULL,

        Orden			int		NULL,
	Clave			char(20)	NOT NULL,  
        ConsecutivoModulo       char(5)		NOT NULL,
        ConsecutivoMov	        char(20)	NOT NULL,
        Grupo			varchar(50)	NULL,
	Icono			int	   	NULL,
	ConsecutivoPorPeriodo	bit		NOT NULL DEFAULT 0,
	ConsecutivoPorEjercicio	bit		NOT NULL DEFAULT 0,
	ConsecutivoPorEmpresa   char(20)	NULL	 DEFAULT 'Si',  

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	
	CONSTRAINT pMovTipo PRIMARY KEY CLUSTERED (Modulo, Mov)

  )")
  EXEC("CREATE INDEX Clave ON dbo.MovTipo (Clave)")
  EXEC("CREATE PROCEDURE mpMovTipoRenombrar
    AS BEGIN
    DECLARE
      @Orden			int,
      @UltModulo		char(5),
      @Modulo			char(5),
      @Mov 			char(20),
      @Clave			char(20),
      @ConsecutivoModulo  	char(5),
      @ConsecutivoMov	     	char(20),
      @Grupo			varchar(50),
      @Icono			int,
      @ConsecutivoPorPeriodo	bit,
      @ConsecutivoPorEjercicio	bit,
      @ConsecutivoPorEmpresa   	char(20)

    SELECT @UltModulo = NULL
    DECLARE crMovTipo CURSOR 
        FOR SELECT Modulo, Mov, Clave, ConsecutivoModulo, ConsecutivoMov, Grupo, Icono, ConsecutivoPorPeriodo, ConsecutivoPorEjercicio, ConsecutivoPorEmpresa
              FROM Temporal
             ORDER BY Modulo, Orden
    OPEN crMovTipo
    FETCH NEXT FROM crMovTipo INTO @Modulo, @Mov, @Clave, @ConsecutivoModulo, @ConsecutivoMov, @Grupo, @Icono, @ConsecutivoPorPeriodo, @ConsecutivoPorEjercicio, @ConsecutivoPorEmpresa
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @Modulo <> @UltModulo SELECT @Orden = 0
        SELECT @UltModulo = @Modulo, @Orden = @Orden + 10
        INSERT MovTipo (Modulo,  Mov,  Orden,  Clave,  ConsecutivoModulo,  ConsecutivoMov,  Grupo,  Icono,  ConsecutivoPorPeriodo,  ConsecutivoPorEjercicio,  ConsecutivoPorEmpresa) 
                VALUES (@Modulo, @Mov, @Orden, @Clave, @ConsecutivoModulo, @ConsecutivoMov, @Grupo, @Icono, @ConsecutivoPorPeriodo, @ConsecutivoPorEjercicio, @ConsecutivoPorEmpresa)
      END
      FETCH NEXT FROM crMovTipo INTO @Modulo, @Mov, @Clave, @ConsecutivoModulo, @ConsecutivoMov, @Grupo, @Icono, @ConsecutivoPorPeriodo, @ConsecutivoPorEjercicio, @ConsecutivoPorEmpresa
    END 
    CLOSE crMovTipo
    DEALLOCATE crMovTipo
    RETURN
  END")
  EXEC("mpMovTipoRenombrar")
  EXEC("drop procedure dbo.mpMovTipoRenombrar")
  EXEC("DROP TABLE Temporal")
END
GO


/* NUEVAS Tablas y Renombrar */

/* ImagenCta */
if not exists (select * from sysobjects where id = object_id('dbo.ImagenCta') and sysstat & 0xf = 3) and
       exists (select * from sysobjects where id = object_id('dbo.Imagen') and sysstat & 0xf = 3) 
  EXEC("sp_rename 'Imagen', 'ImagenCta'")
GO

/* DiaFestivo */
if not exists (select * from sysobjects where id = object_id('dbo.DiaFestivo') and sysstat & 0xf = 3) 
  EXEC("sp_rename 'DiaFeriado', 'DiaFestivo'")
GO

if exists (select * from sysobjects where id = object_id('dbo.Embarque') and sysstat & 0xf = 3) and 
  not exists (select * from sysobjects where id = object_id('dbo.GuiaEmbarque') and sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Embarque', 'GuiaEmbarque'")
  EXEC("sp_rename 'dbo.priEmbarque', 'priGuiaEmbarque', 'object'")
END
GO
if exists (select * from sysobjects where id = object_id('dbo.EmbarqueD') and sysstat & 0xf = 3) and 
  not exists (select * from sysobjects where id = object_id('dbo.GuiaEmbarqueD') and sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmbarqueD', 'GuiaEmbarqueD'")
  EXEC("sp_rename 'dbo.priEmbarqueD', 'priGuiaEmbarqueD', 'object'")
END
GO

/* GuiaEmbarque */
if not exists (select * from sysobjects where id = object_id('dbo.GuiaEmbarque') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.GuiaEmbarque (
	Modulo			char(5)		NOT NULL,
	ID 			int         	NOT NULL,

	FechaEnvio		datetime    	NULL,
	Paquetes		int         	NULL,
	FormaEnvio 		varchar(50)   	NULL, 


	PersonaRecibio		varchar(50) 	NULL,
	FechaRecepcion		datetime    	NULL,


	CONSTRAINT priGuiaEmbarque PRIMARY KEY CLUSTERED (Modulo, ID)
  )")


/* GuiaEmbarqueD */
if not exists (select * from sysobjects where id = object_id('dbo.GuiaEmbarqueD') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.GuiaEmbarqueD (
	Modulo			char(5)		NOT NULL,
	ID 			int         	NOT NULL,
	Guia			varchar(50)	NOT NULL,

	CONSTRAINT priGuiaEmbarqueD PRIMARY KEY CLUSTERED (Modulo, ID, Guia)
  )")

/* Instrumentos */
IF (SELECT Version FROM Version)<=191 
BEGIN
  EXEC("drop table dbo.Instrumento")
  EXEC("CREATE TABLE dbo.Instrumento (
        Instrumento		char(10)	NOT NULL,

	Descripcion		varchar(50)	NULL,
	Moneda			char(10)	NOT NULL,
	Uso			char(20)	NULL,
	CtaDineroVenta 		char(10) 	NULL,
	CtaDineroCompra		char(10) 	NULL,
	FormaPagoVenta		varchar(50)	NULL,
	FormaPagoCompra		varchar(50)	NULL,
	RequiereBeneficiario	bit		NOT NULL DEFAULT 0,
	UnidadMinima		float		NULL	 DEFAULT 0.01,

	CONSTRAINT priInstrumento PRIMARY KEY  CLUSTERED (Instrumento)
  )")
END

/* CambioAcum */
if not exists (select * from sysobjects where id = object_id('dbo.CambioAcum') and sysstat & 0xf = 3) 
EXEC("CREATE TABLE dbo.CambioAcum (
   	Empresa		char(5)		NOT NULL,
   	Fecha		datetime	NOT NULL,
   	Moneda		char(10)	NOT NULL,

   	Inicio		money		NULL	DEFAULT 0.0,
   	VentaHoy	money		NULL,
   	VentaHoyMN	money		NULL,
   	Venta24		money		NULL,
   	Venta24MN	money		NULL,
   	Venta48		money		NULL,
   	Venta48MN	money		NULL,
   	CompraHoy	money		NULL,
   	CompraHoyMN	money		NULL,
   	Compra24	money		NULL,
   	Compra24MN	money		NULL,
   	Compra48	money		NULL,
   	Compra48MN	money		NULL,

   	Cerrado 	bit		NOT NULL DEFAULT 0,

	CONSTRAINT priCambioAcum PRIMARY KEY  CLUSTERED (Empresa, Fecha, Moneda)
 )")

/* ImpresionServer */
if not exists (select * from sysobjects where id = object_id('dbo.ServerImpresion') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ServerImpresion (
        ID			int		NOT NULL IDENTITY (1,1),
	EstacionTrabajo		int		NOT NULL,
	Empresa			char(5)         NOT NULL,
	Modulo			char(5)		NOT NULL,
	Mov 		        char(20) 	NOT NULL,
	Serie			varchar(20)	NULL,
	Reporte			varchar(50)	NULL,
	Impresora		varchar(100)	NULL,
	Copias			int		NULL,
	ReporteDisco		bit		NOT NULL DEFAULT 0,
	Archivo			varchar(100)	NULL,
	Tiempo			int		NULL  	 DEFAULT 60,
	ImprimirCancelados	bit		NOT NULL DEFAULT 1,
	Consecutivo 		int		NOT NULL DEFAULT 0,
	Activo			bit		NOT NULL DEFAULT 1,

	CONSTRAINT priServerImpresion PRIMARY KEY  CLUSTERED (ID)
  )")
GO

/* ContXCta */
if not exists (select * from sysobjects where id = object_id('dbo.ContXCta') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ContXCta (
	ID			int		NOT NULL IDENTITY(1,1),

	CuentaContable		char(20)	NULL,
	Cuenta			char(20)	NULL,
	TipoCuenta		char(20)	NULL, 

	CONSTRAINT priContXCta PRIMARY KEY CLUSTERED (ID)
  )")


/* Gastos */
if (SELECT Version FROM Version)<=204
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Gasto') and sysstat & 0xf = 3) DROP TABLE Gasto")
  EXEC("CREATE TABLE dbo.Gasto (

	ID 			int         	NOT NULL IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov			char(20)        NOT NULL,        
	MovID			int         	NULL,	     
	FechaEmision 		datetime    	NULL,	     
	UltimoCambio 		datetime    	NULL,
	Proyecto		varchar(50)   	NULL,
	Moneda  		char(10)   	NOT NULL,
	TipoCambio		float		NULL,
	Usuario 		char(10)   	NULL,
	Autorizacion		char(10)	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Estatus 		char(15)   	NULL,
	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,

	Periodicidad		varchar(20)	NULL,
	TieneRetencion		bit		NOT NULL	DEFAULT 0,

	Acreedor           	char(10)   	NULL,	
     	Clase			varchar(50)	NULL,  
    	SubClase		varchar(50)	NULL,  

	CtaDinero		char(10)        NULL,       
	FormaPago		varchar(50)	NULL,
	Condicion  		varchar(50)   	NULL,    -- Condicion de Pago
	Vencimiento		datetime    	NULL,
	Importe   		money       	NULL,  -- suma de Importe (Detalle)
	Retencion   		money       	NULL,  -- suma de Rentecion (Detalle)
	Impuestos		money       	NULL,  -- suma de Impuestos (Detalle)

	Saldo 		        money       	NULL,
	Anticipo	        money       	NULL,

	MovAplica		char(20)	NULL,
	MovAplicaID		int		NULL,
	Multiple		bit		NOT NULL DEFAULT 0,

	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		int		NULL,

	Poliza			varchar(20)     NULL,
	PolizaID		int		NULL,
	GenerarPoliza		bit	    	NOT NULL DEFAULT 0,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priGasto PRIMARY KEY CLUSTERED (ID)
  )")
  EXEC("CREATE INDEX Consecutivo   ON dbo.Gasto (Empresa, MovID, Mov)")
  EXEC("CREATE INDEX FechaEmision  ON dbo.Gasto (Empresa, FechaEmision)")
  EXEC("CREATE INDEX Usuario       ON dbo.Gasto (Empresa, Usuario)")
  EXEC("CREATE INDEX Situacion     ON dbo.Gasto (Empresa, Estatus, Situacion)")
  EXEC("CREATE INDEX Acreedor 	   ON dbo.Gasto (Empresa, Acreedor)")
  EXEC("CREATE INDEX Clase 	   ON dbo.Gasto (Empresa, Clase, Subclase)")
END
go


/* GastosD */
if (SELECT Version FROM Version)<=204
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.GastoD') and sysstat & 0xf = 3) DROP TABLE GastoD")
  EXEC("CREATE TABLE dbo.GastoD (

	ID 			int             NOT NULL,
 	Renglon			float	     	NOT NULL,
	RenglonSub		int		NOT NULL   DEFAULT 0,

	Concepto		varchar(50)	NULL,
	Fecha			datetime	NULL,
	Referencia 		varchar(50) 	NULL,
       	Importe                 money           NULL,
	Retencion		money		NULL,
	Impuestos		money           NULL,
	ContUso			varchar(20)	NULL,

	CONSTRAINT priGastoDesglose PRIMARY KEY CLUSTERED (ID,Renglon,RenglonSub)
  )")
END
GO

/* Consecutivos (Gastos) */
if not exists (select * from sysobjects where id = object_id('dbo.GastoC') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.GastoC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NOT NULL,
	Mov 		        char(20) 	NOT NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,

	CONSTRAINT priGastoC PRIMARY KEY  CLUSTERED (ID)
  )")

/* Clase  */
if not exists (select * from sysobjects where id = object_id('dbo.Clase') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.Clase (
	Modulo		char(5)	     	NOT NULL,
	Clase		varchar(50) 	NOT NULL,

	Orden		int		NULL,

	CONSTRAINT priClase PRIMARY KEY CLUSTERED (Modulo, Clase)
  )")

/* SubClase  */
if not exists (select * from sysobjects where id = object_id('dbo.SubClase') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.SubClase (
	Modulo		char(5)	     	NOT NULL,
	Clase		varchar(50) 	NOT NULL,
	SubClase	varchar(50) 	NOT NULL,

	Orden		int		NULL,

	CONSTRAINT priSubClase PRIMARY KEY CLUSTERED (Modulo, Clase, SubClase)
  )")


/* VentaCobro */
if not exists (select * from sysobjects where id = object_id('dbo.VentaCobro') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.VentaCobro (
	ID 			int         	NOT NULL,

	Importe1		money		NULL,
	Importe2		money		NULL,
	Importe3		money		NULL,
	Importe4		money		NULL,
	Importe5		money		NULL,

	FormaCobro1 		varchar(50)   	NULL,
	FormaCobro2 		varchar(50)   	NULL,
	FormaCobro3 		varchar(50)   	NULL,
	FormaCobro4 		varchar(50)   	NULL,
	FormaCobro5 		varchar(50)   	NULL,

	Referencia1		varchar(50)   	NULL,
	Referencia2		varchar(50)   	NULL,
	Referencia3		varchar(50)   	NULL,
	Referencia4		varchar(50)   	NULL,
	Referencia5		varchar(50)	NULL,

	Cambio			money		NULL,
	DelEfectivo		money		NULL,


	CONSTRAINT priVentaCobro PRIMARY KEY CLUSTERED (ID)
  )")
GO

/* VentaOrigen */
if not exists (select * from sysobjects where id = object_id('dbo.VentaOrigen') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.VentaOrigen (
	ID 			int         	NOT NULL,
	OrigenID		int		NOT NULL,

	CONSTRAINT priVentaOrigen PRIMARY KEY CLUSTERED (ID, OrigenID)
  )")
GO

/* ImpresoraModo */
if not exists (select * from sysobjects where id = object_id('dbo.ImpresoraModo') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ImpresoraModo (
	Modo			varchar(50)  	NOT NULL,
	Secuencia		varchar(100)  	NULL,

	CONSTRAINT priImpresoraModo PRIMARY KEY CLUSTERED (Modo)
  )")
GO


/* EmpresaCfgMovImp */
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgMovImp') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.EmpresaCfgMovImp (
	Empresa 		char(5)  	NOT NULL,
	Modulo			char(5)		NOT NULL,
	Mov			char(20)	NOT NULL,
	ReporteImpresora	varchar(50)	NULL,
	ReportePantalla		varchar(50)	NULL,

	CONSTRAINT priEmpresaCfgMovImp PRIMARY KEY CLUSTERED (Empresa, Modulo, Mov)
  )")
GO

/* EmpresaCfgMovGenera */
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgMovGenera') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.EmpresaCfgMovGenera (
	Empresa 	char(5)  	NOT NULL,
	Modulo		char(5)		NOT NULL,
	Mov		char(20)	NOT NULL,
	GeneraModulo	char(5)		NOT NULL,
	GeneraMov	char(20)	NOT NULL,

	CONSTRAINT priEmpresaCfgMovGenera PRIMARY KEY  CLUSTERED (Empresa, Modulo, Mov, GeneraModulo)
  )")
GO

/* ServicioTipo  */
if not exists (select * from sysobjects where id = object_id('dbo.ServicioTipo') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ServicioTipo (
	Tipo			varchar(50) 	NOT NULL ,

	CONSTRAINT priServicioTipo PRIMARY KEY CLUSTERED (Tipo)
  )")
GO


/* ContratoTipo */
if not exists (select * from sysobjects where id = object_id('dbo.ContratoTipo') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ContratoTipo (
	Tipo			varchar(50) 	NOT NULL ,

	CONSTRAINT priContratoTipo PRIMARY KEY CLUSTERED (Tipo)
  )")
GO
 
/* TareaEstado */
if not exists (select * from sysobjects where id = object_id('dbo.TareaEstado') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.TareaEstado (
	Orden		int	 	NOT NULL,
	Estado		varchar(30)	NOT NULL,
	NombrePlural	varchar(50)	NOT NULL,
	
	CONSTRAINT priTareaEstado PRIMARY KEY CLUSTERED (Orden, Estado)
  )")
GO

/* TareaDef */
if not exists (select * from sysobjects where id = object_id('dbo.TareaDef') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.TareaDef (
	Tarea 		varchar(50) 	NOT NULL,

	Categoria 	varchar(50) 	NULL,

	CONSTRAINT priTareaDef PRIMARY KEY CLUSTERED (Tarea)
  )")

/* TareaCat */
if not exists (select * from sysobjects where id = object_id('dbo.TareaCat') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.TareaCat (
	Categoria 		varchar(50) 	NOT NULL,

	CONSTRAINT priTareaCat PRIMARY KEY CLUSTERED (Categoria)
  )")

/* ServicioTarea */
IF (SELECT Version FROM Version)<=211 AND exists (select * from sysobjects where id = object_id('dbo.ServicioTarea') and sysstat & 0xf = 3) 
  Drop Table dbo.ServicioTarea

if not exists (select * from sysobjects where id = object_id('dbo.ServicioTarea') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ServicioTarea (
	ID		int		NOT NULL,
	RenglonID	int		NOT NULL  IDENTITY(1,1),
	Tarea		varchar(50)	NULL,
	Problema	varchar(150)	NULL,
	Solucion	varchar(150)	NULL,
	Estado		varchar(30)	NULL,
	Fecha		datetime	NULL,
	
	CONSTRAINT priServicioTarea PRIMARY KEY CLUSTERED (ID, RenglonID)
  )")
GO

/* CuentaTarea */
if not exists (select * from sysobjects where id = object_id('dbo.CuentaTarea') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.CuentaTarea (
	Rama		char(5)		NOT NULL,
	Cuenta 		char(20) 	NOT NULL,
	RenglonID	int		NOT NULL  IDENTITY(1,1),

	Tarea		varchar(100)	NULL,
	Asunto		varchar(255)	NULL,
	Estado		varchar(30)	NULL,
	Fecha		datetime	NULL,
	
	CONSTRAINT priCuentaTarea PRIMARY KEY CLUSTERED (Rama, Cuenta, RenglonID)
  )")
GO



/* Refacciones */
if not exists (select * from sysobjects where id = object_id('dbo.ArtRefaccion') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ArtRefaccion (
	Articulo 		char(20) 	NOT NULL,
	Refaccion		char(20) 	NOT NULL,
	Cantidad		int		NULL,

	CONSTRAINT priArtRefaccion PRIMARY KEY CLUSTERED (Articulo, Refaccion)
  )")
GO

/* Tiempos */
IF (SELECT Version FROM Version)<=213 and exists (select * from sysobjects where id = object_id('dbo.MovTiempo') and sysstat & 0xf = 3) 
  drop table dbo.MovTiempo
GO
if not exists (select * from sysobjects where id = object_id('dbo.MovTiempo') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.MovTiempo (
	Modulo			char(5)         NOT NULL,
	ID			int		NOT NULL,
	FechaComenzo		datetime	NOT NULL,
	FechaTermino		datetime	NULL,
	FechaInicio    		datetime	NULL,
	Estatus			char(15)	NULL,
	Situacion		varchar(50)	NULL,

	CONSTRAINT priMovTiempo PRIMARY KEY  CLUSTERED (Modulo, ID, FechaComenzo)
  )")
GO


/* Lista Situaciones */
if not exists (select * from sysobjects where id = object_id('dbo.MovSituacionL') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.MovSituacionL (
	Modulo			char(5)		NOT NULL,
	Mov			char(20)        NOT NULL,
	Estatus			char(15)	NOT NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priMovSituacionL PRIMARY KEY  CLUSTERED (Modulo, Mov, Estatus)
  )")
GO

/* Situaciones */
IF (SELECT Version FROM Version)<=213 and exists (select * from sysobjects where id = object_id('dbo.MovSituacion') and sysstat & 0xf = 3) 
  drop table dbo.MovSituacion
GO
if not exists (select * from sysobjects where id = object_id('dbo.MovSituacion') and sysstat & 0xf = 3)
  EXEC("CREATE TABLE dbo.MovSituacion (
	Modulo			char(5)		NOT NULL,
	Mov			char(20)        NOT NULL,
	Estatus			char(15)	NOT NULL,
	Orden			int		NOT NULL,
	Situacion		varchar(50)	NOT NULL,
	Flujo           	char(20)	NULL,
	Cuesta			bit		NOT NULL DEFAULT 0,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priMovSituacion PRIMARY KEY  CLUSTERED (Modulo, Mov, Estatus, Orden)
  )")
GO

/* Situaciones Flujo */
if not exists (select * from sysobjects where id = object_id('dbo.MovSituacionD') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.MovSituacionD (
	Modulo			char(5)		NOT NULL,
	Mov			char(20)        NOT NULL,
	Estatus			char(15)	NOT NULL,
	Situacion		varchar(50)	NOT NULL,
	Orden			int		NOT NULL,
	Flujo			varchar(50)	NOT NULL,

	CONSTRAINT priMovSituacionD PRIMARY KEY  CLUSTERED (Modulo, Mov, Estatus, Situacion, Orden)
  )")
GO

/* UsuariosAcceso */
if not exists (select * from sysobjects where id = object_id('dbo.UsuarioAcceso') and sysstat & 0xf = 3) 
BEGIN
  EXEC("CREATE TABLE dbo.UsuarioAcceso (
	Usuario 		char(10)  	NOT NULL,

	MenuPrincipal		text		NULL,
	MovsEdicion		text		NULL,
	MovsConsulta		text		NULL,
	MovsAutorizar		text		NULL,

	CONSTRAINT priUsuarioAcceso PRIMARY KEY CLUSTERED (Usuario)
  )")
  EXEC("INSERT INTO UsuarioAcceso (Usuario) SELECT Usuario FROM Usuario")
  EXEC("UPDATE UsuarioAcceso SET MenuPrincipal = 'Config.EmpresasUsuarios' WHERE USUARIO = 'DEMO'")
END
GO


/* Variables */
if not exists (select * from sysobjects where id = object_id('dbo.Variable') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.Variable (
	Variable		varchar(50)  	NOT NULL,
	Tipo			char(10)	NOT NULL,
	ValorInicial		varchar(50)  	NULL,
	Nombre			varchar(100)	NULL,
	Tamano			char(5)		NULL,
	AyudaEnCaptura		varchar(20)	NULL,
	Ayuda			varchar(100)	NULL,
	Mayusculas		bit		NOT NULL DEFAULT 0,
	ListaOpciones		text		NULL,
	OpcionPredefinida	varchar(30)	NULL,
	UnicamenteOpciones	bit		NOT NULL DEFAULT 0,
	Validar			bit		NOT NULL DEFAULT 0,
	Sistema			bit		NOT NULL DEFAULT 0,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priVariable PRIMARY KEY CLUSTERED (Variable)

  )")
GO

/* FechaTrabajo */
if not exists (select * from sysobjects where id = object_id('dbo.FechaTrabajo') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.FechaTrabajo (
	Empresa			char(5)         NOT NULL,
	FechaTrabajo		datetime	NULL,

	CONSTRAINT priFechaTrabajo PRIMARY KEY CLUSTERED (Empresa)
  )")
GO

/* ListaSt */
if not exists (select * from sysobjects where id = object_id('dbo.ListaSt') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ListaSt (
	Estacion	int  		NOT NULL,
	ID		int		NOT NULL IDENTITY (1,1),

	Clave		varchar(100)	NULL,

	CONSTRAINT priListaSt PRIMARY KEY CLUSTERED (Estacion, ID)

  )")
GO


/* DocAuto */
if not exists (select * from sysobjects where id = object_id('dbo.DocAuto') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.DocAuto (
	ID			int         	NOT NULL IDENTITY(1,1),
	Empresa			char(5)		NOT NULL,
	Modulo			char(5)		NOT NULL,
	Cuenta			char(10)	NOT NULL,
	Moneda			char(10)	NOT NULL,
	Mov			char(20)	NOT NULL,
	MovID			int		NOT NULL,
	ImporteDocumentar	money		NOT NULL,
	Intereses            	money		NULL,
	InteresesImpuestos     	money		NULL,
	InteresesConcepto	varchar(50)	NULL,
	NumeroDocumentos	int		NOT NULL,
	PrimerVencimiento	datetime	NOT NULL,
	Periodo			char(15)	NOT NULL,
	Concepto		varchar(50)	NULL,
	Observaciones		varchar(100)	NULL,
	Estatus			char(15)	NOT NULL,
	Usuario 		char(10)   	NULL,
	FechaEmision 		datetime    	NULL,	

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priDocAuto PRIMARY KEY CLUSTERED (ID)
  )")
GO

/* Imagenes de Movimientos */
if not exists (select * from sysobjects where id = object_id('dbo.ImagenMov') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ImagenMov (
	Rama 			char(5) 	NOT NULL,
	ID			int		NOT NULL,

	Imagen 			image 		NULL,

	CONSTRAINT priImagenMov PRIMARY KEY CLUSTERED (Rama, ID)
  )")
GO

/* ContXCtaConcepto */
if not exists (select * from sysobjects where id = object_id('dbo.ContXCtaConcepto') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ContXCtaConcepto (
	Modulo			char(5)		NOT NULL,
	Concepto		varchar(50)	NOT NULL,
	Cuenta        		char(20)	NULL,

	CONSTRAINT priContXCtaConcepto PRIMARY KEY CLUSTERED (Modulo, Concepto)
   )")
GO

/* ServicioAccesorios */
if not exists (select * from sysobjects where id = object_id('dbo.ServicioAccesorios') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ServicioAccesorios (
	ID		int		NOT NULL,
	RenglonID	int		NOT NULL  IDENTITY(1,1),

	Articulo	char(20)	NULL,
	Serie		varchar(20)	NULL,
	Observaciones	varchar(50)	NULL,
	
	CONSTRAINT priServicioAccesorios PRIMARY KEY CLUSTERED (ID, RenglonID)
  )")
GO

/* SysBase */
if not exists (select * from sysobjects where id = object_id('dbo.SysBase') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.SysBase (
	Objeto			char(50)	NOT NULL, 
	Datos			image		NULL,
	
	CONSTRAINT priSysBase PRIMARY KEY CLUSTERED (Objeto)

  )")
go

/* EmpresaCfgMovEsp */
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgMovEsp') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.EmpresaCfgMovEsp (
	Empresa 	char(5)  	NOT NULL,
	Asunto		char(5)		NOT NULL,
	Modulo		char(5)		NOT NULL,
	Mov		char(20)	NOT NULL,	

	CONSTRAINT priEmpresaCfgMovEsp PRIMARY KEY CLUSTERED (Empresa, Asunto, Modulo, Mov)
  )")
GO

/* Situaciones */
IF (SELECT Version FROM Version)<220
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.MovSituacion') and sysstat & 0xf = 3) drop table dbo.MovSituacion")
  EXEC("CREATE TABLE dbo.MovSituacion (
	ID			int		NOT NULL IDENTITY(1,1),

	Modulo			char(5)		NULL,
	Mov			char(20)        NULL,
	Tipo			varchar(50)	NULL,
	Estatus			char(15)	NULL,
	Orden			int		NULL,
	Situacion		varchar(50)	NULL,
	Flujo           	char(20)	NULL,  			
	Cuesta			bit		NOT NULL DEFAULT 0,
	PermiteAfectacion	bit		NOT NULL DEFAULT 0,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priMovSituacion PRIMARY KEY  CLUSTERED (ID)
  )")
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.MovSituacionD') and sysstat & 0xf = 3) drop table dbo.MovSituacionD")
  EXEC("CREATE TABLE dbo.MovSituacionD (
	ID			int		NOT NULL,
	Orden			int		NOT NULL,
	Flujo			varchar(50)	NOT NULL,

	CONSTRAINT priMovSituacionD PRIMARY KEY  CLUSTERED (ID, Orden)
  )")
END
GO


/* Vehiculos */
if not exists (select * from sysobjects where id = object_id('dbo.Vehiculo') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.Vehiculo (
	Vehiculo 	char(10)  	NOT NULL,

	Descripcion	varchar(100)	NULL,
	Placas		char(10)	NULL,

	Volumen		float		NULL,
	Peso		float		NULL,

	Agente 		char(10)  	NULL,
	Ruta		varchar(50)	NULL,
	Estatus		char(15)	NULL,

	Logico1		bit		NOT NULL 	DEFAULT 0,
	Logico2		bit		NOT NULL 	DEFAULT 0,
	Logico3		bit		NOT NULL 	DEFAULT 0,
	Logico4		bit		NOT NULL 	DEFAULT 0,
	Logico5		bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT priVehiculo PRIMARY KEY CLUSTERED (Vehiculo)
)")
GO


/* EmbarqueAcciones */
if not exists (select * from sysobjects where id = object_id('dbo.EmbarqueAccion') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.EmbarqueAccion (
	Accion	 	varchar(50)  	NOT NULL,

	Orden		int		NULL,	

	Logico1		bit		NOT NULL 	DEFAULT 0,
	Logico2		bit		NOT NULL 	DEFAULT 0,
	Logico3		bit		NOT NULL 	DEFAULT 0,
	Logico4		bit		NOT NULL 	DEFAULT 0,
	Logico5		bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT priEmbarqueAccion PRIMARY KEY CLUSTERED (Accion)
  )")
GO

/* EmbarqueEstado */
if not exists (select * from sysobjects where id = object_id('dbo.EmbarqueEstado') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.EmbarqueEstado (
	Estado	 	varchar(50)  	NOT NULL,
	Orden		int		NULL,
	Tipo		char(20)	NULL,

	Logico1		bit		NOT NULL 	DEFAULT 0,
	Logico2		bit		NOT NULL 	DEFAULT 0,
	Logico3		bit		NOT NULL 	DEFAULT 0,
	Logico4		bit		NOT NULL 	DEFAULT 0,
	Logico5		bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT priEmbarqueEstado PRIMARY KEY CLUSTERED (Estado)
  )")
GO

/****** EmbarqueMov ******/
if not exists (select * from sysobjects where id = object_id('dbo.EmbarqueMov') and sysstat & 0xf = 3) 
BEGIN
  EXEC("CREATE TABLE dbo.EmbarqueMov (
	ID			int         	NOT NULL IDENTITY(1,1),

	AsignadoID 		int             NULL,

	Accion			varchar(50)	NULL,
	Zona			varchar(30)	NULL,
	Ruta			varchar(50)	NULL,
	ZonaTipo		varchar(50)	NULL,
	OrdenEmbarque		int		NULL,
	Empresa			char(5)	        NULL,
	Modulo			char(5)		NULL,
	ModuloID		int		NULL,
	Mov			char(20)	NULL,
	MovID			int		NULL,
	FechaEmision		datetime	NULL,
	MovReferencia 		varchar(50) 	NULL,
	MovObservaciones 	varchar(100) 	NULL,
	MovEstatus		char(15)	NULL,
	Almacen			char(10)   	NULL,
	Cliente			char(10)	NULL,
	ClienteEnviarA		int	   	NULL,
	Proveedor		char(10)	NULL,
	AlmacenDestino		char(10)   	NULL,
	Peso			float		NULL,
	Volumen			float		NULL,
	Paquetes		int		NULL,
       	Importe                 money           NULL,
	Impuestos		money           NULL,
	Moneda  		char(10)   	NULL,
	TipoCambio		float		NULL,
	Condicion  		varchar(50)   	NULL,    
	Vencimiento		datetime    	NULL,

	Nombre			varchar(100) 	NULL,
	NombreEnvio		varchar(100) 	NULL,
	Direccion 		varchar(100) 	NULL,
	EntreCalles		varchar(100) 	NULL,
	Plano			varchar(15)     NULL,
	Observaciones		varchar(100)    NULL,
	Colonia 		varchar(30) 	NULL,
	Poblacion 		varchar(30) 	NULL,
	Estado 			varchar(30) 	NULL,
	Pais 			varchar(30)     NULL,
	CodigoPostal 		varchar(15) 	NULL,
	Telefonos		varchar(100) 	NULL,
	Contacto1 		varchar(50) 	NULL,
	Contacto2 		varchar(50) 	NULL,
        Extencion1              varchar(10)     NULL,
        Extencion2              varchar(10)     NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priEmbarqueMov PRIMARY KEY CLUSTERED (ID)
  )")
  EXEC("CREATE INDEX Asignado ON dbo.EmbarqueMov (AsignadoID)")
END
go

if not exists (select * from sysobjects where id = object_id('dbo.Embarque') and sysstat & 0xf = 3) 
BEGIN
  EXEC("CREATE TABLE dbo.Embarque (
	ID 			int         	NOT NULL IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov			char(20)        NOT NULL,        
	MovID			int         	NULL,	     
	FechaEmision 		datetime    	NULL,	     
	UltimoCambio 		datetime    	NULL,
	Proyecto		varchar(50)   	NULL,
	Usuario 		char(10)   	NULL,
	Autorizacion		char(10)	NULL,
	Concepto		varchar(50)	NULL,
	Referencia 		varchar(50) 	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Estatus 		char(15)   	NULL,
	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,

	Vehiculo 		char(10)  	NULL,
	Ruta			varchar(50)	NULL,
	Agente 			char(10)  	NULL,

	Volumen			float		NULL,
	Peso			float		NULL,
	Paquetes		int		NULL,

	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		int		NULL,

	Poliza			varchar(20)     NULL,
	PolizaID		int		NULL,
	GenerarPoliza		bit	    	NOT NULL DEFAULT 0,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,
	FechaSalida		datetime	NULL,  
	FechaRetorno		datetime	NULL,  

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,
	Logico9			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priEmbarque PRIMARY KEY CLUSTERED (ID)
  )")
  EXEC("CREATE INDEX Consecutivo   ON dbo.Embarque (Empresa, MovID, Mov)")
  EXEC("CREATE INDEX FechaEmision  ON dbo.Embarque (Empresa, FechaEmision)")
  EXEC("CREATE INDEX Usuario       ON dbo.Embarque (Empresa, Usuario)")
  EXEC("CREATE INDEX Situacion     ON dbo.Embarque (Empresa, Estatus, Situacion)")
  EXEC("CREATE INDEX Vehiculo	   ON dbo.Embarque (Empresa, Vehiculo)")
  EXEC("CREATE INDEX Ruta	   ON dbo.Embarque (Empresa, Ruta)")
  EXEC("CREATE INDEX Agente	   ON dbo.Embarque (Empresa, Agente)")
END
go



/****** EmbarqueD ******/
if not exists (select * from sysobjects where id = object_id('dbo.EmbarqueD') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.EmbarqueD (

	ID 			int             NOT NULL,
	Orden			int		NOT NULL,

	EmbarqueMov		int		NULL,
	Estado			varchar(50)	NULL,
	FechaHora    		datetime    	NULL,
	Persona			varchar(50)   	NULL, 
	PersonaID		varchar(50)   	NULL, 

	Forma      		varchar(50)	NULL,
	Importe			money		NULL,

	Referencia 		varchar(50) 	NULL,
	Observaciones 		varchar(100) 	NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priEmbarqueD PRIMARY KEY CLUSTERED (ID, Orden)
  )")
GO

/****** Embarques ******/
if not exists (select * from sysobjects where id = object_id('dbo.EmbarqueC') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.EmbarqueC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NOT NULL,
	Mov 		        char(20) 	NOT NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,

	CONSTRAINT priEmbarqueC PRIMARY KEY  CLUSTERED (ID)
  )")
GO


/****** Categorias de Activos Fijos ******/
IF (SELECT Version FROM Version)<=225
  if exists (select * from sysobjects where id = object_id('dbo.ActivoFCat') and sysstat & 0xf = 3) drop table dbo.ActivoFCat
GO
if not exists (select * from sysobjects where id = object_id('dbo.ActivoFCat') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ActivoFCat (
	Categoria 			varchar(50) 	NOT NULL ,

	VidaUtil			int		NULL,
	CategoriaMaestra 		varchar(50) 	NULL,
	MantenimientoPeriodicidad 	varchar(20)	NULL,
	Icono				int	  	NULL,

	CONSTRAINT priActivoFCat PRIMARY KEY CLUSTERED (Categoria)
  )")
GO


/****** Activos Fijos ******/
IF (SELECT Version FROM Version)<=225
  if exists (select * from sysobjects where id = object_id('dbo.ActivoF') and sysstat & 0xf = 3) drop table dbo.ActivoF
GO
if not exists (select * from sysobjects where id = object_id('dbo.ActivoF') and sysstat & 0xf = 3) 
BEGIN
  EXEC("CREATE TABLE dbo.ActivoF (
	ID				int		NOT NULL IDENTITY(1,1),

	Empresa				char(5)		NOT NULL,
	Articulo 			char(20)  	NOT NULL,
	Serie				char(20)	NULL,

	Moneda				char(10)   	NULL,
	Almacen 			char(10)   	NULL,
	Categoria 			varchar(50) 	NULL,
	Localizacion			varchar(50) 	NULL,
	UltimoCambio 			datetime  	NULL,
	AdquisicionValor		money		NULL,
	AdquisicionFecha		datetime	NULL,
	GarantiaVence			datetime	NULL,
	VidaUtil			int		NULL,
	Utilizacion			float		NULL,

	DepreciacionMeses		int		NULL,
	DepreciacionAcum		money		NULL,
	DepreciacionUltima		datetime	NULL,

	ValorRevaluado			money		NULL,
	RevaluacionUltima		datetime	NULL,

	Mantenimientos     		int  		NULL,
	MantenimientoUltimo		datetime	NULL,
	MantenimientoSiguiente		datetime	NULL,
	MantenimientoVence		datetime	NULL,
	MantenimientoAcum		money		NULL,
	MantenimientoHoras		float		NULL,
	MantenimientoPeriodicidad 	varchar(20)	NULL,

	Reparaciones			int		NULL,
	ReparacionAcum			money		NULL,
	ReparacionHoras			float		NULL,
	ReparacionUltima		datetime	NULL,
	
	SeguroVence			datetime	NULL,
	SeguroAcum			money		NULL,

	Observaciones			varchar(100)	NULL,

	Estatus				char(15)	NULL  DEFAULT 'ACTIVO',

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priActivoF PRIMARY KEY CLUSTERED (ID)
  )")
  EXEC("CREATE INDEX Articulo  ON dbo.ActivoF (Empresa, Articulo, Serie)")
  EXEC("CREATE INDEX Serie     ON dbo.ActivoF (Serie)")
  EXEC("CREATE INDEX Categoria ON dbo.ActivoF (Categoria)")
END
GO

IF (SELECT Version FROM Version)<=225
  if exists (select * from sysobjects where id = object_id('dbo.ActivoFijo') and sysstat & 0xf = 3) drop table dbo.ActivoFijo
GO
if not exists (select * from sysobjects where id = object_id('dbo.ActivoFijo') and sysstat & 0xf = 3) 
begin
  EXEC("CREATE TABLE dbo.ActivoFijo (
	ID 			int         	NOT NULL IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov			char(20)        NOT NULL,        
	MovID			int         	NULL,	     
	FechaEmision 		datetime    	NULL,	     
	UltimoCambio 		datetime    	NULL,
	Proyecto		varchar(50)   	NULL,
	Usuario 		char(10)   	NULL,
	Autorizacion		char(10)	NULL,
	Concepto		varchar(50)	NULL,
	Referencia 		varchar(50) 	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Estatus 		char(15)   	NULL,
	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,
	Moneda			char(10)	NULL,
	TipoCambio		float		NULL,

	Condicion		varchar(50)	NULL,
	Vencimiento		datetime	NULL,

	Proveedor		char(10)	NULL,
	Importe			money		NULL,
	Impuestos		money		NULL,

	FormaPago		varchar(50)	NULL,
	CtaDinero		char(10)        NULL,       

	Todo			bit		NOT NULL DEFAULT 0,
	Revaluar		bit		NOT NULL DEFAULT 0,
	ValorMercado		bit		NOT NULL DEFAULT 0,

	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		int		NULL,

	Poliza			varchar(20)     NULL,
	PolizaID		int		NULL,
	GenerarPoliza		bit	    	NOT NULL DEFAULT 0,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,
	Logico9			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priActivoFijo PRIMARY KEY CLUSTERED (ID)
  )")
  EXEC("CREATE INDEX Consecutivo   ON dbo.ActivoFijo (Empresa, MovID, Mov)")
  EXEC("CREATE INDEX FechaEmision  ON dbo.ActivoFijo (Empresa, FechaEmision)")
  EXEC("CREATE INDEX Usuario       ON dbo.ActivoFijo (Empresa, Usuario)")
  EXEC("CREATE INDEX Situacion     ON dbo.ActivoFijo (Empresa, Estatus, Situacion)")
end
go

/****** ActivoFijoD ******/
IF (SELECT Version FROM Version)<=225
  if exists (select * from sysobjects where id = object_id('dbo.ActivoFijoD') and sysstat & 0xf = 3) drop table dbo.ActivoFijoD
GO
if not exists (select * from sysobjects where id = object_id('dbo.ActivoFijoD') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ActivoFijoD (

	ID 				int       	NOT NULL,
 	Renglon				float	  	NOT NULL,
	RenglonSub			int		NOT NULL   DEFAULT 0,

	Articulo			char(20)	NULL,
	Serie				varchar(20)	NULL,
	Importe				money		NULL,
	Impuestos			money		NULL,
	Horas				float		NULL,
	MesesDepreciados		int		NULL,
	Depreciacion			money		NULL,
	DepreciacionPorcentaje		money		NULL,
	NuevoValor			money		NULL,
	Inflacion			float		NULL,
	ActualizacionCapital		money		NULL,
	ActualizacionGastos		money		NULL,
        ActualizacionDepreciacion	money		NULL,
	Observaciones			varchar(100)	NULL,

	ValorAnterior			money		NULL,
	DepreciacionAnterior		datetime	NULL,
	RevaluacionAnterior		datetime	NULL,
	ReparacionAnterior		datetime	NULL,
	MantenimientoAnterior		datetime	NULL,
	MantenimientoSiguienteAnterior	datetime	NULL,
	PolizaMantenimientoAnterior	datetime	NULL,
	PolizaSeguroAnterior		datetime	NULL,

	CONSTRAINT priActivoFijoD PRIMARY KEY CLUSTERED (ID, Renglon, RenglonSub)
  )")
GO

/****** ActivoFijoC ******/
IF (SELECT Version FROM Version)<=225
  if exists (select * from sysobjects where id = object_id('dbo.ActivoFijoC') and sysstat & 0xf = 3) drop table dbo.ActivoFijoC
GO
if not exists (select * from sysobjects where id = object_id('dbo.ActivoFijoC') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ActivoFijoC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NOT NULL,
	Mov 		        char(20) 	NOT NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,

	CONSTRAINT priActivoFijoC PRIMARY KEY  CLUSTERED (ID)
  )")
GO


/****** Centros de Costos  ******/
if not exists (select * from sysobjects where id = object_id('dbo.CentroCostos') and sysstat & 0xf = 3)
BEGIN
  EXEC("CREATE TABLE dbo.CentroCostos (
	CentroCostos		char(20) 	NOT NULL,
	Rama			char(20)	NULL,

	Descripcion		varchar(100)    NULL,
	EsAcumulativo		bit		NOT NULL DEFAULT 0,
	TieneMovimientos	bit		NOT NULL DEFAULT 0,
	Grupo			varchar(50) 	NULL,
	SubGrupo		varchar(50) 	NULL,

	CONSTRAINT priCentroCostos PRIMARY KEY  CLUSTERED (CentroCostos)
  )")
  IF exists (select * from sysobjects where id = object_id('dbo.Centro') and sysstat & 0xf = 3)
  BEGIN
    EXEC("INSERT CentroCostos (CentroCostos, Descripcion, Grupo, SubGrupo) 
                       SELECT CentroCostos, CentroCostos, Grupo, SubGrupo FROM Centro")
    EXEC("DROP TABLE Centro")
  END
END
GO

/****** ContUso  ******/
if not exists (select * from sysobjects where id = object_id('dbo.ContUso') and sysstat & 0xf = 3) 
BEGIN
  EXEC("CREATE TABLE dbo.ContUso (
	ContUso			varchar(20) 	NOT NULL,
	Descripcion		varchar(100)    NULL,

	Cuenta			char(20)	NULL,
	CentroCostos		varchar(20)	NULL,
	Grupo			varchar(50)	NULL,

	CONSTRAINT priContUso PRIMARY KEY  CLUSTERED (ContUso)
  )")
  EXEC("CREATE INDEX Descripcion ON dbo.ContUso (Descripcion)")
END
GO


/****** Gastos Aplica ******/
if not exists (select * from sysobjects where id = object_id('dbo.GastoAplica') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.GastoAplica (
	ID 			int             NOT NULL,
 	Renglon			float	        NOT NULL,
	RenglonSub		int		NOT NULL   DEFAULT 0,

	Aplica   	        char(20)        NULL,
        AplicaID	        int             NULL,
        Importe                 money           NULL,

	CONSTRAINT priGastoAplica PRIMARY KEY CLUSTERED (ID,Renglon,RenglonSub)
  )")
GO

/****** Localidad ******/
if not exists (select * from sysobjects where id = object_id('dbo.Localidad') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.Localidad (
	Localidad	varchar(50) 	NOT NULL,

	Direccion 	varchar(100) 	NULL,
	Colonia 	varchar(30)  	NULL,
	CodigoPostal 	varchar(15)  	NULL,
	Poblacion 	varchar(30)  	NULL,
	Estado 		varchar(30)  	NULL,
	Pais		varchar(30)     NULL,
	Telefonos 	varchar(50)  	NULL,
	Responsable	varchar(50)	NULL,
	eMail		varchar(50) 	NULL,

	CONSTRAINT priLocalidad PRIMARY KEY CLUSTERED (Localidad)
  )")
GO

/****** Unidad  ******/
if not exists (select * from sysobjects where id = object_id('dbo.Unidad') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.Unidad (
	Unidad 		varchar(50) 	NOT NULL,
	Factor		float		NULL	DEFAULT 1.0,

	CONSTRAINT priUnidad PRIMARY KEY CLUSTERED (Unidad)
  )")
GO


/****** Evaluacion  ******/
if not exists (select * from sysobjects where id = object_id('dbo.Evaluacion') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.Evaluacion (
	Evaluacion		varchar(50) 	NOT NULL,
	Tipo			char(20)	NULL,		-- Curso, Capacitacion, Induccion, etc.
	Descripcion		varchar(255)	NULL,
	Duracion		varchar(50)	NULL,

	CONSTRAINT priEvaluacion PRIMARY KEY CLUSTERED (Evaluacion)
  )")
GO

/****** TablaNum ******/
if not exists (select * from sysobjects where id = object_id('dbo.TablaNum') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.TablaNum (
	TablaNum varchar(50) 	NOT NULL,

	CONSTRAINT priTablaNum PRIMARY KEY CLUSTERED (TablaNum)
  )")
GO

/****** TablaNumD ******/
if not exists (select * from sysobjects where id = object_id('dbo.TablaNumD') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.TablaNumD (
	TablaNum	varchar(50) 	NOT NULL,
	Numero		money 		NOT NULL,
	Valor		money		NULL,

	CONSTRAINT priTablaNumD PRIMARY KEY CLUSTERED (TablaNum, Numero)
  )")
GO

/****** TablaImpuesto ******/
if not exists (select * from sysobjects where id = object_id('dbo.TablaImpuesto') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.TablaImpuesto (
	TablaImpuesto	varchar(50) 	NOT NULL,
	PeriodoTipo	char(20)	NOT NULL,  -- Semanal, Decenal, Catorcenal, Quincenal, Mensual, Anual

	CONSTRAINT priTablaImpuesto PRIMARY KEY CLUSTERED (TablaImpuesto, PeriodoTipo)
  )")
GO

/****** TablaImpuestoD ******/
if not exists (select * from sysobjects where id = object_id('dbo.TablaImpuestoD') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.TablaImpuestoD (
	TablaImpuesto	varchar(50) 	NOT NULL,
	PeriodoTipo	char(20)	NOT NULL,  -- Semanal, Decenal, Catorcenal, Quincenal, Mensual, Anual

	LimiteInferior	money		NOT NULL,
	LimiteSuperior	money		NOT NULL,
	Cuota		money		NULL,
	Porcentaje	money		NULL,

	CONSTRAINT priTablaImpuestoD PRIMARY KEY CLUSTERED (TablaImpuesto, PeriodoTipo, LimiteInferior)
  )")
GO

/****** PeriodoTipo ******/
if not exists (select * from sysobjects where id = object_id('dbo.PeriodoTipo') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.PeriodoTipo (
	PeriodoTipo	char(20) 	NOT NULL, -- Semanal, Decenal, Catorcenal, Quincenal, Mensual, Especial
	DiasPeriodo	float		NULL,
	DiasHabiles	float		NULL,
	UltimoDiaPagado	datetime	NULL,

	CONSTRAINT priPeriodoTipo PRIMARY KEY  CLUSTERED (PeriodoTipo)
  )")
GO

/****** PeriodoTipoD  ******/
if not exists (select * from sysobjects where id = object_id('dbo.PeriodoTipoD') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.PeriodoTipoD (
	PeriodoTipo	char(20) 	NOT NULL, 

	Ejercicio	int		NOT NULL,
	Periodo		int		NOT NULL,
	FechaInicio	datetime	NULL,
	FechaFinal	datetime	NULL,

	CONSTRAINT priPeriodoTipoD PRIMARY KEY  CLUSTERED (PeriodoTipo, Ejercicio, Periodo)
  )")
GO

/****** Jornada ******/
if not exists (select * from sysobjects where id = object_id('dbo.Jornada') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.Jornada (
	Jornada			varchar(20) 	NOT NULL,
	Tipo			char(20)	NULL 	 DEFAULT 'Sin Control',	-- Sin Control/Control Asistencias/por Horas

	Domingo			bit		NOT NULL DEFAULT 1,
	Lunes			bit		NOT NULL DEFAULT 0,
	Martes			bit		NOT NULL DEFAULT 0,
	Miercoles		bit		NOT NULL DEFAULT 0,
	Jueves			bit		NOT NULL DEFAULT 0,
	Viernes			bit		NOT NULL DEFAULT 0,
	Sabado			bit		NOT NULL DEFAULT 1,
	DescansoRompeRutina	bit		NOT NULL DEFAULT 1,

	DescansaFestivos	bit		NOT NULL DEFAULT 1,
	FestivoRompeRutina	bit		NOT NULL DEFAULT 0,

	HorasPromedio		float		NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priJornada PRIMARY KEY  CLUSTERED (Jornada)
  )")
GO

/****** JornadaD ******/
if not exists (select * from sysobjects where id = object_id('dbo.JornadaD') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.JornadaD (
	Jornada			varchar(20) 	NOT NULL,
	Dia			int		NOT NULL,
	Entrada			char(5)		NOT NULL,
	Salida			char(5)		NOT NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priJornadaD PRIMARY KEY  CLUSTERED (Jornada, Dia, Entrada)
  )")
GO

/****** JornadaTiempo ******/
if not exists (select * from sysobjects where id = object_id('dbo.JornadaTiempo') and sysstat & 0xf = 3) 
BEGIN
  EXEC("CREATE TABLE dbo.JornadaTiempo (
	Jornada		varchar(20) 	NOT NULL,
	Entrada		datetime	NOT NULL,
	Salida		datetime	NOT NULL,
	Fecha		datetime	NULL,

	CONSTRAINT priJornadaTiempo PRIMARY KEY  CLUSTERED (Jornada, Entrada)
  )")
  EXEC("CREATE INDEX Fecha ON dbo.JornadaTiempo (Fecha)")
END
go

/****** ZonaEconomica ******/
if not exists (select * from sysobjects where id = object_id('dbo.ZonaEconomica') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ZonaEconomica (
	Zona		varchar(30) 	NOT NULL,
	SueldoMinimo	money		NULL,

	CONSTRAINT priZonaEconomica PRIMARY KEY  CLUSTERED (Zona)
  )")
GO

/****** PersonalCat ******/
if not exists (select * from sysobjects where id = object_id('dbo.PersonalCat') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.PersonalCat (
	Categoria	varchar(50) 	NOT NULL,
	SueldoMaximo	money		NULL,
	SueldoMinimo	money		NULL,

	CONSTRAINT priPersonalCat PRIMARY KEY  CLUSTERED (Categoria)
  )")
GO

/****** Departamento ******/
if not exists (select * from sysobjects where id = object_id('dbo.Departamento') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.Departamento (
	Departamento	varchar(50) 	NOT NULL,

	Localidad	varchar(50) 	NULL,
	CtaDinero	char(10)	NULL,

	CONSTRAINT priDepartamento PRIMARY KEY CLUSTERED (Departamento)
  )")
GO

/****** Puesto ******/
if not exists (select * from sysobjects where id = object_id('dbo.Puesto') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.Puesto (
	Puesto		varchar(50) 	NOT NULL,

	CONSTRAINT priPuesto PRIMARY KEY  CLUSTERED (Puesto)
  )")
GO

/****** PersonalGrupo ******/
if not exists (select * from sysobjects where id = object_id('dbo.PersonalGrupo') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.PersonalGrupo (
	Grupo		varchar(50) 	NOT NULL,

	CONSTRAINT priPersonalGrupo PRIMARY KEY  CLUSTERED (Grupo)
  )")
GO

/****** PersonalValuacion ******/
if not exists (select * from sysobjects where id = object_id('dbo.PersonalValuacion') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.PersonalValuacion (
	Valuacion	varchar(50) 	NOT NULL,

	CONSTRAINT priPersonalValuacion PRIMARY KEY  CLUSTERED (Valuacion)
  )")
GO

/****** NivelAcademico ******/
if not exists (select * from sysobjects where id = object_id('dbo.NivelAcademico') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.NivelAcademico (
	NivelAcademico	varchar(50) 	NOT NULL,

	CONSTRAINT priNivelAcademico PRIMARY KEY  CLUSTERED (NivelAcademico)
  )")
GO

/****** Personal ******/
if not exists (select * from sysobjects where id = object_id('dbo.Personal') and sysstat & 0xf = 3) 
begin
  EXEC("CREATE TABLE dbo.Personal (
	Personal		char(10) 	NOT NULL,
	ApellidoPaterno		varchar(30)	NULL,
	ApellidoMaterno		varchar(30)	NULL,
	Nombre			varchar(30)	NULL,
	
	Tipo			char(20)	NULL, -- Empleado, Trabajador, Obrero, Accionista, Consejero, Funcionario
	Direccion 		varchar(100) 	NULL,
	Colonia 		varchar(30)  	NULL,
	Poblacion 		varchar(30)  	NULL,
	Estado 			varchar(30)  	NULL,
	Pais			varchar(30)     NULL,
	CodigoPostal 		varchar(15)  	NULL,
	Telefono 		varchar(50)  	NULL,
	eMail			varchar(50) 	NULL,
	ZonaEconomica		varchar(30)	NULL,

	Registro		varchar(30)	NULL,

	FormaPago		varchar(50)	NULL,
	CtaDinero		char(10)	NULL,
	Afore			char(10)	NULL,

	PersonalSucursal 	varchar(50)	NULL,
	PersonalCuenta		varchar(20)	NULL,

	FechaNacimiento		datetime	NULL,
	Nacionalidad		varchar(30)	NULL,
	Pasaporte		varchar(30)	NULL,
	Cartilla		varchar(30)	NULL,
	Permiso			varchar(30)	NULL,
	NivelAcademico		varchar(50)	NULL,
	Sexo			char(10)	NULL,
	EstadoCivil		varchar(20)	NULL,
	Hijos			int		NULL,
	Beneficiario		varchar(50)	NULL,
	Parentesco		varchar(20)	NULL,
	Valuacion		varchar(50)	NULL,

	ReportaA		char(10)	NULL,
	
	AspiraCategoria		varchar(50)	NULL,
	AspiraDepartamento	varchar(50)	NULL,
	AspiraGrupo		varchar(50)	NULL,
	AspiraPuesto		varchar(50)	NULL,

	Categoria		varchar(50)	NULL,
	Departamento		varchar(50)	NULL,
	Grupo			varchar(50)	NULL,
	Puesto			varchar(50)	NULL,
	TipoContrato		varchar(50)	NULL,
	PeriodoTipo		char(20)	NULL,
	Jornada			varchar(20)	NULL,
	TipoSueldo		varchar(10)	NULL,
	Moneda			char(10)	NULL,

	SueldoFijo		money		NULL,
	SueldoVariable		money		NULL,

	FechaAlta		datetime	NULL,
	FechaBaja		datetime	NULL,
	FechaAntiguedad		datetime	NULL,
	UltimaModificacion	datetime	NULL,
	UltimoPago		datetime	NULL,

	Estatus			char(15)	NULL,
	UltimoCambio		datetime	NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,
	Logico9			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priPersonal PRIMARY KEY CLUSTERED (Personal)
  )")
  EXEC("CREATE INDEX Nombre           	ON dbo.Personal (Nombre)")
  EXEC("CREATE INDEX ApellidoPaterno  	ON dbo.Personal (ApellidoPaterno)")
  EXEC("CREATE INDEX Categoria		ON dbo.Personal (Categoria)")
  EXEC("CREATE INDEX Departamento	ON dbo.Personal (Departamento)")
  EXEC("CREATE INDEX Grupo		ON dbo.Personal (Grupo)")
  EXEC("CREATE INDEX Puesto		ON dbo.Personal (Puesto)")
  EXEC("CREATE INDEX Registro		ON dbo.Personal (Registro)")
end
go

/****** PersonalTarjeta ******/
if not exists (select * from sysobjects where id = object_id('dbo.PersonalTarjeta') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.PersonalTarjeta (
	Tarjeta		char(10) 	NOT NULL,
	Personal	char(10)	NOT NULL,

	CONSTRAINT priPersonalTarjeta PRIMARY KEY  CLUSTERED (Tarjeta)
  )")
GO


/****** PersonalPropCat ******/
if not exists (select * from sysobjects where id = object_id('dbo.PersonalPropCat') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.PersonalPropCat (
	Categoria	varchar(50) 	NOT NULL,

	CONSTRAINT priPersonalPropCat PRIMARY KEY  CLUSTERED (Categoria)
  )")
GO

/****** PersonalProp ******/
if not exists (select * from sysobjects where id = object_id('dbo.PersonalProp') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.PersonalProp (
	Propiedad	varchar(50) 	NOT NULL,

	Orden		int		NULL,
	Categoria	varchar(50) 	NULL,
	NivelEmpresa	bit		NOT NULL DEFAULT 0,
	NivelCategoria	bit		NOT NULL DEFAULT 0,
	NivelPersonal	bit		NOT NULL DEFAULT 0,

	CONSTRAINT priPersonalProp PRIMARY KEY  CLUSTERED (Propiedad)
  )")
GO

/****** PersonalPropValor ******/
if not exists (select * from sysobjects where id = object_id('dbo.PersonalPropValor') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.PersonalPropValor (
	Rama		char(5)		NOT NULL,
	Cuenta		varchar(50)	NOT NULL,
	Propiedad	varchar(50) 	NOT NULL,

	Valor		varchar(50)	NULL,

	CONSTRAINT priPersonalPropValor PRIMARY KEY  CLUSTERED (Rama, Cuenta, Propiedad)
  )")
GO

/****** PersonalAsiste ******/
if not exists (select * from sysobjects where id = object_id('dbo.PersonalAsiste') and sysstat & 0xf = 3) 
begin
  EXEC("CREATE TABLE dbo.PersonalAsiste (
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
  )")
  EXEC("CREATE INDEX FechaEntrada ON dbo.PersonalAsiste (Empresa, Personal, Entrada)")
  EXEC("CREATE INDEX FechaSalida  ON dbo.PersonalAsiste (Empresa, Personal, Salida)")
end
go

/****** PersonalAsisteDifDia ******/
if not exists (select * from sysobjects where id = object_id('dbo.PersonalAsisteDifDia') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.PersonalAsisteDifDia (
	Empresa		char(5)		NOT NULL,
	Personal	char(10) 	NOT NULL,
	Fecha 		datetime	NOT NULL,
	ID		int		NOT NULL 	IDENTITY(1,1),

	Extra		int		NULL,
	Ausencia	int		NULL,
	Minutos		int		NULL,

	Permiso		varchar(20)	NULL,
	PermisoID	int		NULL,
	PermisoConcepto varchar(50)	NULL,

	CONSTRAINT priPersonalAsisteDifDia PRIMARY KEY  CLUSTERED (Empresa, Personal, Fecha, ID)
  )")
go

/****** PersonalAsisteDifMin ******/
if not exists (select * from sysobjects where id = object_id('dbo.PersonalAsisteDifMin') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.PersonalAsisteDifMin (
	Empresa		char(5)		NOT NULL,
	Personal	char(10) 	NOT NULL,
	Fecha 		datetime	NOT NULL,
	ID		int		NOT NULL 	IDENTITY(1,1),

	FechaHoraD	datetime	NOT NULL,
	FechaHoraA	datetime	NOT NULL,
	Extra		int		NULL,
	Ausencia	int		NULL,
	Registro	char(10)	NULL,           -- Entrada/Salida/Permiso

	Permiso		varchar(20)	NULL,
	PermisoID	int		NULL,
	PermisoConcepto varchar(50)	NULL,

	CONSTRAINT priPersonalAsisteDifMin PRIMARY KEY  CLUSTERED (Empresa, Personal, Fecha, ID)
  )")
go

/****** PersonalAsisteDif ******/
if not exists (select * from sysobjects where id = object_id('dbo.PersonalAsisteDif') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.PersonalAsisteDif (
	Empresa		char(5)		NOT NULL,
        Personal	char(10) 	NOT NULL,
	Fecha 		datetime	NOT NULL,
	ID		int		NOT NULL 	IDENTITY(1,1),

	Registro	char(10)	NULL,           -- Entrada/Salida/Permiso
	Cantidad	int		NULL,
	Tipo		varchar(20)	NULL,
	Concepto	varchar(50)	NULL,

	CONSTRAINT priPersonalAsisteDif PRIMARY KEY  CLUSTERED (Empresa, Personal, Fecha, ID)
  )")
go

/****** Nomina ******/
if not exists (select * from sysobjects where id = object_id('dbo.Nomina') and sysstat & 0xf = 3) 
begin
  EXEC("CREATE TABLE dbo.Nomina (
	ID			int 	    	NOT NULL IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov 			char(20)        NOT NULL,	
	MovID			int         	NULL,
	FechaEmision 		datetime    	NULL,
	UltimoCambio 		datetime    	NULL,
	Proyecto		varchar(50)   	NULL,
	Concepto		varchar(50)	NULL,
	Moneda  		char(10)   	NOT NULL,
	TipoCambio		float		NULL,
	Usuario 		char(10)   	NULL,
	Autorizacion		char(10)	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Estatus 		char(15)   	NULL,
	Situacion		varchar(50)   	NULL,
	SituacionFecha		datetime	NULL,

	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		int		NULL,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,

	Condicion		varchar(50)	NULL,
	PeriodoTipo		varchar(20)	NULL,
	FechaD			datetime	NULL,
	FechaA			datetime	NULL,

	Poliza			varchar(20)     NULL,
	PolizaID		int		NULL,
	GenerarPoliza		bit	    	NOT NULL DEFAULT 0,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,
	Logico9			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priNomina PRIMARY KEY CLUSTERED (ID)
  )")
  EXEC("CREATE INDEX Consecutivo   ON dbo.Nomina (Empresa, MovID, Mov)")
  EXEC("CREATE INDEX Usuario       ON dbo.Nomina (Empresa, Usuario)")
  EXEC("CREATE INDEX Situacion     ON dbo.Nomina (Empresa, Estatus, Situacion)")
end
go


/****** NominaD (Detalle) ******/
if not exists (select * from sysobjects where id = object_id('dbo.NominaD') and sysstat & 0xf = 3) 
begin
  EXEC("CREATE TABLE dbo.NominaD (
	ID 			int       	NOT NULL,
 	Renglon			float	  	NOT NULL,

	Modulo			char(5)		NULL 	DEFAULT 'NOM',
	Personal		char(10)	NULL,
	Cuenta			char(10)	NULL,
	Importe			money		NULL,
	Cantidad		money		NULL,
	Concepto		varchar(50)	NULL,
	Referencia 		varchar(50) 	NULL,
	FormaPago 		varchar(50) 	NULL,
	Porcentaje		money		NULL,
	Monto			money		NULL,
	FechaD			datetime	NULL,
	FechaA			datetime	NULL,
	Movimiento		varchar(20)	NULL,	-- Percepcion, Deduccion, Importe, Cheque, Cheque Electronico

	Saldo			money		NULL,
	CantidadPendiente	money		NULL,
	Activo			bit		NOT NULL DEFAULT 1,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priNominaD PRIMARY KEY CLUSTERED (ID, Renglon)
  )")
  EXEC("CREATE INDEX Personal ON dbo.NominaD (Personal)")
end


/****** NominaLog (Log Cancelacion) ******/
if not exists (select * from sysobjects where id = object_id('dbo.NominaLog') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.NominaLog (
	Personal		char(10)	NOT NULL,
	ID 			int       	NOT NULL,
	DID			int       	NOT NULL,
 	DRenglon		float	  	NOT NULL,

	Importe			money		NULL,
	Cantidad		money		NULL,
	Procesar		bit		NOT NULL DEFAULT 0,

	CONSTRAINT priNominaLog PRIMARY KEY CLUSTERED (Personal, ID, DID, DRenglon)
  )")
GO

/****** Consecutivos (Nomina) ******/
if not exists (select * from sysobjects where id = object_id('dbo.NominaC') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.NominaC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NOT NULL,
	Mov 		        char(20) 	NOT NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,

	CONSTRAINT priNominaC PRIMARY KEY  CLUSTERED (ID)
  )")
GO

/****** NomX ******/
if not exists (select * from sysobjects where id = object_id('dbo.NomX') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.NomX (
	ID			int		NOT NULL IDENTITY(1,1),

	Nombre			varchar(100)	NULL,
	Empresa			char(7)		NULL DEFAULT '(Todas)',
	Moneda			char(10)	NULL,
	NomMov			varchar(255)	NULL,
	NomConcepto		varchar(255)	NULL,
	NomProyecto		varchar(255)	NULL,
	NomObservaciones	varchar(255) 	NULL,
	Condicion		varchar(255)	NULL,
	Estatus			char(15)	NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priNomX PRIMARY KEY CLUSTERED (ID)
  )")
GO


/****** RH ******/
if not exists (select * from sysobjects where id = object_id('dbo.RH') and sysstat & 0xf = 3) 
begin
  EXEC("CREATE TABLE dbo.RH (
	ID			int 	    	NOT NULL IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov 			char(20)        NOT NULL,	-- Altas, Modificaciones, Bajas, Evaluaciones, Cursos, etc.
	MovID			int         	NULL,
	FechaEmision 		datetime    	NULL,
	UltimoCambio 		datetime    	NULL,
	Proyecto		varchar(50)   	NULL,
	Concepto		varchar(50)	NULL,
	Moneda  		char(10)   	NOT NULL,
	TipoCambio		float		NULL,
	Usuario 		char(10)   	NULL,
	Autorizacion		char(10)	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Referencia 		varchar(50) 	NULL,
	Estatus 		char(15)   	NULL,
	Situacion		varchar(50)   	NULL,
	SituacionFecha		datetime	NULL,

	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		int		NULL,

	Evaluacion		varchar(50)	NULL,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,

	Poliza			varchar(20)     NULL,
	PolizaID		int		NULL,
	GenerarPoliza		bit	    	NOT NULL DEFAULT 0,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,
	Logico9			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priRH PRIMARY KEY CLUSTERED (ID)
  )")
  EXEC("CREATE INDEX Consecutivo   ON dbo.RH (Empresa, MovID, Mov)")
  EXEC("CREATE INDEX Usuario       ON dbo.RH (Empresa, Usuario)")
  EXEC("CREATE INDEX Situacion     ON dbo.RH (Empresa, Estatus, Situacion)")
end
go


/****** RHD (Detalle) ******/
if not exists (select * from sysobjects where id = object_id('dbo.RHD') and sysstat & 0xf = 3) 
begin
  EXEC("CREATE TABLE dbo.RHD (
	ID 			int       	NOT NULL,
 	Renglon			float	  	NOT NULL,

	Personal		char(10)	NULL,
	SueldoFijo		money		NULL,
	SueldoVariable		money		NULL,
	TipoContrato		varchar(50)	NULL,
	PeriodoTipo		varchar(20)	NULL,
	Jornada			varchar(20)	NULL,
	TipoSueldo		varchar(10)	NULL,
	Categoria		varchar(50)	NULL,
	Departamento		varchar(50)	NULL,
	Puesto			varchar(50)	NULL,
	Grupo			varchar(50)	NULL,
	Observaciones		varchar(50)	NULL,
	FechaAlta		datetime	NULL,
	FechaAntiguedad		datetime	NULL,
	Calificacion		money		NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priRHD PRIMARY KEY CLUSTERED (ID, Renglon)
  )")
  EXEC("CREATE INDEX Personal ON dbo.RHD (Personal)")
end
GO

/****** Consecutivos (RH) ******/
if not exists (select * from sysobjects where id = object_id('dbo.RHC') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.RHC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NOT NULL,
	Mov 		        char(20) 	NOT NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,

	CONSTRAINT priRHC PRIMARY KEY  CLUSTERED (ID)
  )")
GO

/****** Plazas (RH) ******/
if not exists (select * from sysobjects where id = object_id('dbo.RHPlaza') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.RHPlaza (
	Empresa			char(5)         NOT NULL,
        Departamento		varchar(50)	NOT NULL,
        Puesto			varchar(50)	NOT NULL,
	Plazas			int		NULL,
	EnUso			int		NULL,

	CONSTRAINT priRHPlaza PRIMARY KEY  CLUSTERED (Departamento, Puesto)
  )")
GO

/****** Asiste ******/
if not exists (select * from sysobjects where id = object_id('dbo.Asiste') and sysstat & 0xf = 3) 
begin
  EXEC("CREATE TABLE dbo.Asiste (
	ID			int 	    	NOT NULL IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov 			char(20)        NOT NULL,	-- Autorizacion, Entradas, Salidas, Asistencias
	MovID			int         	NULL,
	FechaEmision 		datetime    	NULL,
	UltimoCambio 		datetime    	NULL,
	Proyecto		varchar(50)   	NULL,
	Moneda  		char(10)   	NULL,
	TipoCambio		float		NULL,
	Usuario 		char(10)   	NULL,
	Autorizacion		char(10)	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Referencia 		varchar(50) 	NULL,
	Estatus 		char(15)   	NULL,
	Tipo			char(20)	NULL,		--Ausencia/Extras
	Situacion		varchar(50)   	NULL,
	SituacionFecha		datetime	NULL,

	Localidad		varchar(50)   	NULL,
  	FechaD			datetime	NULL,
  	FechaA			datetime	NULL,

	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		int		NULL,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,

	Poliza			varchar(20)     NULL,
	PolizaID		int		NULL,
	GenerarPoliza		bit	    	NOT NULL DEFAULT 0,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,
	Logico9			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priAsiste PRIMARY KEY CLUSTERED (ID)
  )")
  EXEC("CREATE INDEX Consecutivo   ON dbo.Asiste (Empresa, MovID, Mov)")
  EXEC("CREATE INDEX Usuario       ON dbo.Asiste (Empresa, Usuario)")
  EXEC("CREATE INDEX Situacion     ON dbo.Asiste (Empresa, Estatus, Situacion)")
end
go

/****** AsisteD (Detalle) ******/
if not exists (select * from sysobjects where id = object_id('dbo.AsisteD') and sysstat & 0xf = 3) 
begin
  EXEC("CREATE TABLE dbo.AsisteD (
	ID 			int       	NOT NULL,
 	Renglon			float	  	NOT NULL,

	Personal		char(10)	NULL,
	Registro		char(10)	NULL,	
	HoraRegistro		char(5)		NULL,
	HoraD			char(5)		NULL,
	HoraA			char(5)		NULL,
	FechaD			datetime	NULL,
	FechaA			datetime	NULL,
	Concepto		varchar(50)	NULL,
	Fecha			datetime	NULL,
	Cantidad		int		NULL,
	Tipo			varchar(20)	NULL,  -- Dias Extras/Dias Ausencia/Minutos Extras/Minutos Ausencia
	Observaciones		varchar(50)	NULL,  
	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priAsisteD PRIMARY KEY CLUSTERED (ID, Renglon)
  )")
  EXEC("CREATE INDEX Personal ON dbo.AsisteD (Personal, Fecha)")
  EXEC("CREATE INDEX Fechas   ON dbo.AsisteD (FechaD, FechaA)")
end
GO

/****** Consecutivos (Asiste) ******/
if not exists (select * from sysobjects where id = object_id('dbo.AsisteC') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.AsisteC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NOT NULL,
	Mov 		        char(20) 	NOT NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,

	CONSTRAINT priAsisteC PRIMARY KEY  CLUSTERED (ID)
  )")
GO

/****** Articulos por Proveedor ******/
if not exists (select * from sysobjects where id = object_id('dbo.ArtProv') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ArtProv (
	Articulo 		char(20)   	NOT NULL,
	Proveedor 		char(10)  	NOT NULL,

	Clave	 		varchar(20)   	NULL,
	Unidad			varchar(50)	NULL,
        CostoAutorizado	        money       	NULL,
        UltimoCosto	        money       	NULL,
	CompraMinimaCantidad	float		NULL,
	CompraMinimaImporte	money		NULL,
	Multiplos		int		NULL		DEFAULT 1,
	DiasRespuesta		int         	NULL,  

	Logico1			bit		NOT NULL 	DEFAULT 0,
	Logico2			bit		NOT NULL 	DEFAULT 0,
	Logico3			bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT priArtProv PRIMARY KEY CLUSTERED (Articulo, Proveedor)
  )")
GO

/****** ArtExistenciaGlobal ******/
if not exists (select * from sysobjects where id = object_id('dbo.ArtExistenciaGlobal') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ArtExistenciaGlobal (
	Empresa			char(5)		NOT NULL,
	Articulo 		char(20) 	NOT NULL,
	Almacen			char(10)	NOT NULL,

	Existencia		float     	NULL,
	Disponible		float     	NULL,

	CONSTRAINT priArtExistenciaGlobal PRIMARY KEY CLUSTERED (Empresa, Articulo, Almacen)
  )")
GO

/****** ArtComision  ******/
if not exists (select * from sysobjects where id = object_id('dbo.ArtComision') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ArtComision (
	Comision	varchar(50) 	NOT NULL,
	Tipo		char(20)	NULL,
	Porcentaje	float		NULL,

	CONSTRAINT priArtComision PRIMARY KEY CLUSTERED (Comision)
  )")
GO

/****** ArtArancel  ******/
if not exists (select * from sysobjects where id = object_id('dbo.ArtArancel') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ArtArancel (
	Arancel		varchar(50) 	NOT NULL,
	Porcentaje	float		NULL,

	Logico1		bit		NOT NULL 	DEFAULT 0,
	Logico2		bit		NOT NULL 	DEFAULT 0,
	Logico3		bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT priArtArancel PRIMARY KEY CLUSTERED (Arancel)
  )")
GO


/*******************************************************************************************/
/*                             COMISIONES Y DESTAJOS                             	   */
/*******************************************************************************************/


/****** Agent (Ficha) ******/
if not exists (select * from sysobjects where id = object_id('dbo.Agent') and sysstat & 0xf = 3) 
BEGIN
  EXEC("CREATE TABLE dbo.Agent (
	ID 			int         	NOT NULL IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov  			char(20)        NOT NULL,
	MovID			int         	NULL,	 
	FechaEmision 		datetime    	NULL,	 
	UltimoCambio 		datetime    	NULL,
	Concepto		varchar(50)	NULL,
	Proyecto  		varchar(50)   	NULL,
	Moneda 			char(10)   	NOT NULL,
	TipoCambio		float		NULL,
	Usuario 		char(10)   	NULL,
	Autorizacion		char(10)	NULL,
	Referencia 		varchar(50) 	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Estatus 		char(15)   	NULL,
	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,

	Agente  		char(10)   	NOT NULL,
	CtaDinero		char(10)        NULL,       
	FormaPago		varchar(50)	NULL,
	Importe   		money       	NULL,
	Retencion   		money       	NULL,
	RetencionPorcentaje	money       	NULL,
	Impuestos		money       	NULL,
	ImpuestosPorcentaje	money       	NULL,

	Saldo 		        money       	NULL,
	AutoAjuste		money		NULL,

	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		int		NULL,

	Poliza			varchar(20)     NULL,
	PolizaID		int		NULL,
	GenerarPoliza		bit	    	NOT NULL DEFAULT 0,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,
	Logico9			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priAgent PRIMARY KEY CLUSTERED (ID)
  )")
  EXEC("CREATE INDEX Consecutivo  ON dbo.Agent (Empresa, MovID, Mov)")
  EXEC("CREATE INDEX FechaEmision ON dbo.Agent (Empresa, FechaEmision)")
  EXEC("CREATE INDEX Usuario      ON dbo.Agent (Empresa, Usuario)")
  EXEC("CREATE INDEX Situacion    ON dbo.Agent (Empresa, Estatus, Situacion)")
  EXEC("CREATE INDEX Agente 	  ON dbo.Agent (Empresa, Agente)")
  EXEC("CREATE INDEX Referencia   ON dbo.Agent (Empresa, Referencia)")
END
go


/****** Agent (Detalle) ******/
if not exists (select * from sysobjects where id = object_id('dbo.AgentD') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.AgentD (
	ID 			int             NOT NULL,
 	Renglon			float	        NOT NULL,
	RenglonSub		int		NOT NULL   DEFAULT 0,

        Importe                 money           NULL,
	Aplica   	        char(20)        NULL,
        AplicaID	        int             NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priAgentD PRIMARY KEY CLUSTERED (ID,Renglon,RenglonSub)

  )")
GO

/****** Agent ******/
if not exists (select * from sysobjects where id = object_id('dbo.AgentC') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.AgentC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NOT NULL,
	Mov 		        char(20) 	NOT NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,

	CONSTRAINT priAgentC PRIMARY KEY  CLUSTERED (ID)
  )")
GO

/****** Anexos Cuentas ******/
if not exists (select * from sysobjects where id = object_id('dbo.AnexoCta') and sysstat & 0xf = 3)
BEGIN
  EXEC("CREATE TABLE dbo.AnexoCta (
	Rama			char(5)		NOT NULL,
	Cuenta			char(20) 	NOT NULL,
	Nombre			char(20)	NOT NULL,
	Direccion		varchar(100)	NULL,
	Icono			int		NULL,
	Tipo			char(10)	NULL,  -- Comentario, Imagen, Archivo, Internet
	Orden			int		NULL,
	Comentario		text		NULL,

	CONSTRAINT priAnexoCta PRIMARY KEY CLUSTERED (Rama, Cuenta, Nombre)
  )")
  EXEC("INSERT AnexoCta (Rama, Cuenta, Tipo, Nombre, Comentario, Orden) SELECT Rama, Cuenta, 'Comentario', 'Comentario', Comentarios, 1 FROM NotaCta")
END
GO

/****** Anexos Movimientos ******/
if not exists (select * from sysobjects where id = object_id('dbo.AnexoMov') and sysstat & 0xf = 3) 
BEGIN
  EXEC("CREATE TABLE dbo.AnexoMov (
	Rama			char(5)		NOT NULL,
	ID			int 		NOT NULL,
	Nombre			char(20)	NOT NULL,
	Direccion		varchar(100)	NULL,
	Icono			int		NULL,
	Tipo			char(10)	NULL,  -- Comentario, Imagen, Archivo, Internet
	Orden			int		NULL,
	Comentario		text		NULL,

	CONSTRAINT priAnexoMov PRIMARY KEY CLUSTERED (Rama, ID, Nombre)
  )")
  EXEC("UPDATE NotaMov SET Rama = 'AGENT' WHERE Rama = 'COMI'")
  EXEC("INSERT AnexoMov (Rama, ID, Tipo, Nombre, Comentario, Orden) SELECT Rama, ID, 'Comentario', 'Comentario', Comentarios, 1 FROM NotaMov")
END
GO

/****** Anexos Movimientos (Detalle) ******/
if not exists (select * from sysobjects where id = object_id('dbo.AnexoMovD') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.AnexoMovD (
	Rama			char(5)		NOT NULL,
	ID			int 		NOT NULL,
	Cuenta			char(20) 	NOT NULL,
	Nombre			char(20)	NOT NULL,
	Direccion		varchar(100)	NULL,
	Icono			int		NULL,
	Tipo			char(10)	NULL,  -- Comentario, Imagen, Archivo, Internet
	Orden			int		NULL,
	Comentario		text		NULL,

	CONSTRAINT priAnexoMovD PRIMARY KEY CLUSTERED (Rama, ID, Cuenta, Nombre)
  )")
GO

/****** MovEstatusLog ******/
if not exists (select * from sysobjects where id = object_id('dbo.MovEstatusLog') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.MovEstatusLog (
	Modulo			char(5)		NOT NULL,
	ModuloID 		int       	NOT NULL,
        ID			int		NOT NULL IDENTITY (1,1),
	Usuario			char(10)	NOT NULL,
	Estatus			char(15)	NOT NULL,
	Fecha			datetime	NOT NULL,

	CONSTRAINT priMovEstatusLog PRIMARY KEY CLUSTERED (Modulo, ModuloID, ID)
  )")
GO

/****** MovUsuario ******/
if not exists (select * from sysobjects where id = object_id('dbo.MovUsuario') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.MovUsuario (
	Modulo			char(5)		NOT NULL,
	ID 			int       	NOT NULL,
 	Orden			int	  	NOT NULL,
	Usuario			char(10)	NOT NULL,

	CONSTRAINT priMovUsuario PRIMARY KEY CLUSTERED (Modulo, ID, Orden)
  )")
GO

/****** MovBitacora ******/
if not exists (select * from sysobjects where id = object_id('dbo.MovBitacora') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.MovBitacora (
	Modulo			char(5)		NOT NULL,
	ID 			int       	NOT NULL,
	Fecha			datetime	NOT NULL,
	Evento			varchar(255)	NULL,

	CONSTRAINT priMovBitacora PRIMARY KEY CLUSTERED (Modulo, ID, Fecha)
  )")
GO

/****** SoporteEstado  ******/
if not exists (select * from sysobjects where id = object_id('dbo.SoporteEstado') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.SoporteEstado (
	Orden		int	 	NOT NULL,
	Estado		varchar(30)	NOT NULL,
	NombrePlural	varchar(50)	NOT NULL,
	
	CONSTRAINT priSoporteEstado PRIMARY KEY CLUSTERED (Orden, Estado)
  )")
GO

/****** Soporte (Ficha) ******/
if not exists (select * from sysobjects where id = object_id('dbo.Soporte') and sysstat & 0xf = 3) 
BEGIN
  EXEC("CREATE TABLE dbo.Soporte (
	ID 			int         	NOT NULL IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov  			char(20)        NOT NULL,
	MovID			int         	NULL,	 
	FechaEmision 		datetime    	NULL,	 
	UltimoCambio 		datetime    	NULL,
	Concepto		varchar(50)	NULL,
	Proyecto  		varchar(50)   	NULL,
	Usuario 		char(10)   	NULL,
	Autorizacion		char(10)	NULL,
	Referencia 		varchar(50) 	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Estatus 		char(15)   	NULL,
	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,

	Cliente			char(10)	NULL,
	EnviarA			int	   	NULL,
	Agente  		char(10)   	NULL,
	Estado			varchar(30)	NULL,
	Contacto		varchar(50)	NULL,
	Telefono		varchar(30)	NULL,
	Extencion 		varchar(10) 	NULL,
	Fax			varchar(30)	NULL,
	eMail			varchar(30)	NULL,
	UsuarioResponsable	char(10)   	NOT NULL,
	FechaInicio		datetime	NULL,
	Vencimiento		datetime	NULL,
	TieneContrato		bit		NOT NULL DEFAULT 0,
	PuedeDevolver		bit		NOT NULL DEFAULT 0,
	Prioridad		char(10)	NULL	 DEFAULT 'Normal',	-- Normal, Alta, Baja
     	Clase			varchar(50)	NULL,  
    	Subclase		varchar(50)	NULL,  

	Titulo			varchar(100)	NULL,
	Problema		text		NULL,
	Solucion		text		NULL,
	Comentarios		text		NULL,
	TiempoTrabajado		varchar(20)	NULL, 

	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		int		NULL,

	Poliza			varchar(20)     NULL,
	PolizaID		int		NULL,
	GenerarPoliza		bit	    	NOT NULL DEFAULT 0,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,
	Logico9			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priSoporte PRIMARY KEY CLUSTERED (ID)
  )")
  EXEC("CREATE INDEX Consecutivo  ON dbo.Soporte (Empresa, MovID, Mov)")
  EXEC("CREATE INDEX FechaEmision ON dbo.Soporte (Empresa, FechaEmision)")
  EXEC("CREATE INDEX Usuario      ON dbo.Soporte (Empresa, Usuario)")
  EXEC("CREATE INDEX Situacion    ON dbo.Soporte (Empresa, Estatus, Situacion)")
  EXEC("CREATE INDEX Cliente 	  ON dbo.Soporte (Empresa, Cliente)")
  EXEC("CREATE INDEX Agente 	  ON dbo.Soporte (Empresa, Agente)")
  EXEC("CREATE INDEX Referencia   ON dbo.Soporte (Empresa, Referencia)")
  EXEC("CREATE INDEX Clase 	  ON dbo.Soporte (Empresa, Clase)")
END
go



/****** Consecutivos Soporte ******/
if not exists (select * from sysobjects where id = object_id('dbo.SoporteC') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.SoporteC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NOT NULL,
	Mov 		        char(20) 	NOT NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,

	CONSTRAINT priSoporteC PRIMARY KEY  CLUSTERED (ID)
  )")
GO


/****** AutoFix ******/
/*
if not exists (select * from sysobjects where id = object_id('dbo.AutoFix') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.AutoFix (
	Version			int		NOT NULL,
	Fecha			datetime	NOT NULL,
	ID 			int       	NOT NULL IDENTITY(1,1),

	Modulo			char(5)		NULL,
	ModuloID		int		NULL,
	Renglon			float		NULL,
	RenglonSub		int		NULL,
	Cuenta			char(20)	NULL,
	SubCuenta		varchar(20)	NULL,
	Grupo			char(10)	NULL,
	Cantidad		float		NULL,
	Importe			money		NULL,
	Campo			varchar(50)	NULL,
	Descripcion		varchar(100)	NULL,

	Logico1			bit		NOT NULL 	DEFAULT 0,
	Logico2			bit		NOT NULL 	DEFAULT 0,
	Logico3			bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT priAutoFix PRIMARY KEY CLUSTERED (Version, Fecha, ID)
  )")
*/
GO

/****** Sustitutos  ******/
if not exists (select * from sysobjects where id = object_id('dbo.ArtSustituto') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ArtSustituto (
	Articulo		char(20)	NOT NULL,
	Sustituto		char(20) 	NOT NULL,

	Orden			int		NULL,
	Comentarios		varchar(100)	NULL,

	CONSTRAINT priArtSustituto PRIMARY KEY CLUSTERED (Articulo, Sustituto)
  )")
GO

/****** ArtR ******/
if not exists (select * from sysobjects where id = object_id('dbo.ArtR') and sysstat & 0xf = 3)
BEGIN
  EXEC("CREATE TABLE dbo.ArtR (
	Empresa		 char(5)	NOT NULL,
	Articulo	 char(20)	NOT NULL,
	SubCuenta	 varchar(20)	NOT NULL  DEFAULT '',
	Almacen		 char(10)	NOT NULL,

	Localizacion	  varchar(50) 	NULL,
	Minimo 		  float 	NULL,
	Maximo 		  float 	NULL,
	PuntoOrden	  float 	NULL,
	PuntoOrdenOrdenar float 	NULL,

	UltimoCambio 	 datetime  	NULL,

	INV		 float		NULL,		-- Saldo Inventarios
	CSG		 float		NULL,		-- Saldo A Consignacion
	RESV		 float		NULL,		-- Saldo Reservados
	VMOS		 float		NULL,		-- Saldo Ventas de Mostrador
	GAR		 float		NULL,		-- Saldo En Garantia
	AF		 float		NULL,		-- Saldo Activos Fijos
	PZA		 float		NULL,		-- Saldo Piezas

	CantidadOrdenada float		NULL,
	CompraPendiente	 float		NULL,		
	VentaPendiente	 float		NULL,		
	VentaRemisionada float		NULL,
	InvPendiente	 float		NULL,		

	TieneMovimientos bit		NOT NULL 	DEFAULT 0,

	Logico1		 bit		NOT NULL 	DEFAULT 0,
	Logico2		 bit		NOT NULL 	DEFAULT 0,
	Logico3		 bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT priArtR PRIMARY KEY CLUSTERED (Empresa, Articulo, SubCuenta, Almacen)
  )")
END
GO


/****** TablaSt ******/
if not exists (select * from sysobjects where id = object_id('dbo.TablaSt') and sysstat & 0xf = 3) 
EXEC("CREATE TABLE dbo.TablaSt (
        TablaSt		varchar(50)	NOT NULL,
	CONSTRAINT priTablaSt PRIMARY KEY CLUSTERED (TablaSt)
)")
go

/****** TablaStD ******/
if not exists (select * from sysobjects where id = object_id('dbo.TablaStD') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.TablaStD (
        TablaSt			varchar(50)	NOT NULL,
	Nombre			varchar(50)	NOT NULL,
	Valor			varchar(50)	NULL,

	CONSTRAINT priTablaStD PRIMARY KEY CLUSTERED (TablaSt, Nombre)
  )")
go

/****** Compras con Gastos Diversos ******/
if not exists (select * from sysobjects where id = object_id('dbo.CompraGastoDiverso') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.CompraGastoDiverso (
	ID			int 	    	NOT NULL,
	Concepto		varchar(50)	NOT NULL,
	Acreedor		char(10)	NOT NULL,

	Importe			money		NULL,
	PorcentajeImpuestos	float		NULL,
	Moneda			char(10)	NULL,
	TipoCambio		float		NULL,
	Prorrateo		varchar(20)	NULL,
	FechaEmision		datetime	NULL,
	Condicion		varchar(50)	NULL,
	Vencimiento		datetime	NULL,

	CONSTRAINT priCompraGastoDiverso PRIMARY KEY CLUSTERED (ID, Concepto, Acreedor)
  )")
GO

/****** Causas ******/
if not exists (select * from sysobjects where id = object_id('dbo.Causa') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.Causa (
	Modulo			char(5)	     NOT NULL,
	Causa	 		varchar(50)  NOT NULL,
	Categoria		varchar(50)  NULL,
	Orden			int	     NULL,

	CONSTRAINT priCausa PRIMARY KEY CLUSTERED (Modulo, Causa)
  )")
GO


/****** VentaDLogPicos (Log Cancelacion) ******/
if not exists (select * from sysobjects where id = object_id('dbo.VentaDLogPicos') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.VentaDLogPicos (
	ID 			int       	NOT NULL,
 	Renglon			float	  	NOT NULL,
	RenglonSub		int		NOT NULL,

	CantidadCancelada	float		NULL,
	FechaCancelacion	datetime	NULL,

	CONSTRAINT priVentaDLogPicos PRIMARY KEY CLUSTERED (ID, Renglon, RenglonSub)
  )")
GO

/****** PeriodoEspecial ******/
if not exists (select * from sysobjects where id = object_id('dbo.PeriodoEspecial') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.PeriodoEspecial (
	Empresa		char(5)		NOT NULL,
	Modulo		char(5)		NOT NULL,
	Periodo		int		NOT NULL,
	Nombre		varchar(50)	NULL,

	CONSTRAINT priPeriodoEspecial PRIMARY KEY CLUSTERED (Empresa, Modulo, Periodo)
  )")
GO

/****** EjercicioEspecial ******/
if not exists (select * from sysobjects where id = object_id('dbo.EjercicioEspecial') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.EjercicioEspecial (
	Empresa		char(5)		NOT NULL,
	Modulo		char(5)		NOT NULL,
	FechaD		datetime	NOT NULL,
	FechaA		datetime	NOT NULL,
	Periodo		int		NOT NULL,
	Ejercicio	int		NOT NULL,

	CONSTRAINT priEjercicioEspecial PRIMARY KEY CLUSTERED (Empresa, Modulo, FechaD, FechaA)
  )")
GO


/****** ArtUnidad ******/
if not exists (select * from sysobjects where id = object_id('dbo.ArtUnidad') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ArtUnidad (
	Articulo		char(20)     NOT NULL,
	Unidad	 		varchar(50)  NOT NULL,
	Factor			float	     NULL,

	CONSTRAINT priArtUnidad PRIMARY KEY CLUSTERED (Articulo, Unidad)
  )")
GO

/****** Configuracion 2 de la Empresa ******/
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfg2') and sysstat & 0xf = 3) 
BEGIN
  EXEC("CREATE TABLE dbo.EmpresaCfg2 (
	Empresa 			char(5)  	NOT NULL,
	
	CxcPosfechados			bit		NOT NULL	DEFAULT 0,
	CxpPosfechados			bit		NOT NULL	DEFAULT 0,
	MultiUnidades			bit		NOT NULL	DEFAULT 0,
	VentaOpciones			bit		NOT NULL	DEFAULT 0,
	FacturaCobroIntegrado		bit		NOT NULL	DEFAULT 0,
	
	Logico1				bit		NOT NULL	DEFAULT 0,
	Logico2				bit		NOT NULL	DEFAULT 0,
	Logico3				bit		NOT NULL	DEFAULT 0,
	Logico4				bit		NOT NULL	DEFAULT 0,
	Logico5				bit		NOT NULL	DEFAULT 0,
	Logico6				bit		NOT NULL	DEFAULT 0,
	Logico7				bit		NOT NULL	DEFAULT 0,
	Logico8				bit		NOT NULL	DEFAULT 0,
	Logico9				bit		NOT NULL	DEFAULT 0,
	Logico10			bit		NOT NULL	DEFAULT 0,
	Logico11			bit		NOT NULL	DEFAULT 0,
	Logico12			bit		NOT NULL	DEFAULT 0,
	Logico13			bit		NOT NULL	DEFAULT 0,
	Logico14			bit		NOT NULL	DEFAULT 0,
	Logico15			bit		NOT NULL	DEFAULT 0,
	Logico16			bit		NOT NULL	DEFAULT 0,
	Logico17			bit		NOT NULL	DEFAULT 0,
	Logico18			bit		NOT NULL	DEFAULT 0,
	Logico19			bit		NOT NULL	DEFAULT 0,
	Logico20			bit		NOT NULL	DEFAULT 0,
	Logico21			bit		NOT NULL	DEFAULT 0,
	Logico22			bit		NOT NULL	DEFAULT 0,
	Logico23			bit		NOT NULL	DEFAULT 0,
	Logico24			bit		NOT NULL	DEFAULT 0,
	Logico25			bit		NOT NULL	DEFAULT 0,
	Logico26			bit		NOT NULL	DEFAULT 0,
	Logico27			bit		NOT NULL	DEFAULT 0,
	Logico28			bit		NOT NULL	DEFAULT 0,
	Logico29			bit		NOT NULL	DEFAULT 0,
	Logico30			bit		NOT NULL	DEFAULT 0,
	Logico31			bit		NOT NULL	DEFAULT 0,
	Logico32			bit		NOT NULL	DEFAULT 0,
	Logico33			bit		NOT NULL	DEFAULT 0,
	Logico34			bit		NOT NULL	DEFAULT 0,
	Logico35			bit		NOT NULL	DEFAULT 0,
	Logico36			bit		NOT NULL	DEFAULT 0,
	Logico37			bit		NOT NULL	DEFAULT 0,
	Logico38			bit		NOT NULL	DEFAULT 0,
	Logico39			bit		NOT NULL	DEFAULT 0,
	Logico40			bit		NOT NULL	DEFAULT 0,
	Logico41			bit		NOT NULL	DEFAULT 0,
	Logico42			bit		NOT NULL	DEFAULT 0,
	Logico43			bit		NOT NULL	DEFAULT 0,
	Logico44			bit		NOT NULL	DEFAULT 0,
	Logico45			bit		NOT NULL	DEFAULT 0,
	Logico46			bit		NOT NULL	DEFAULT 0,
	Logico47			bit		NOT NULL	DEFAULT 0,
	Logico48			bit		NOT NULL	DEFAULT 0,
	Logico49			bit		NOT NULL	DEFAULT 0,
	Logico50			bit		NOT NULL	DEFAULT 0,
	Logico51			bit		NOT NULL	DEFAULT 0,
	Logico52			bit		NOT NULL	DEFAULT 0,

	CONSTRAINT priEmpresaCfg2 PRIMARY KEY  CLUSTERED (Empresa)
  )")
  EXEC("INSERT EmpresaCfg2 (Empresa) SELECT Empresa FROM Empresa")
END
GO


/****** Configuracion2 del Usuario ******/
if not exists (select * from sysobjects where id = object_id('dbo.UsuarioCfg2') and sysstat & 0xf = 3) 
BEGIN
  EXEC("CREATE TABLE dbo.UsuarioCfg2 (
	Usuario 			char(10)  	NOT NULL,
	
	CxcMovExpress			bit		NOT NULL	DEFAULT 0,
	CxpMovExpress			bit		NOT NULL	DEFAULT 0,
	
	Logico1				bit		NOT NULL	DEFAULT 0,
	Logico2				bit		NOT NULL	DEFAULT 0,
	Logico3				bit		NOT NULL	DEFAULT 0,
	Logico4				bit		NOT NULL	DEFAULT 0,
	Logico5				bit		NOT NULL	DEFAULT 0,
	Logico6				bit		NOT NULL	DEFAULT 0,
	Logico7				bit		NOT NULL	DEFAULT 0,
	Logico8				bit		NOT NULL	DEFAULT 0,
	Logico9				bit		NOT NULL	DEFAULT 0,
	Logico10			bit		NOT NULL	DEFAULT 0,
	Logico11			bit		NOT NULL	DEFAULT 0,
	Logico12			bit		NOT NULL	DEFAULT 0,
	Logico13			bit		NOT NULL	DEFAULT 0,
	Logico14			bit		NOT NULL	DEFAULT 0,
	Logico15			bit		NOT NULL	DEFAULT 0,
	Logico16			bit		NOT NULL	DEFAULT 0,
	Logico17			bit		NOT NULL	DEFAULT 0,
	Logico18			bit		NOT NULL	DEFAULT 0,
	Logico19			bit		NOT NULL	DEFAULT 0,
	Logico20			bit		NOT NULL	DEFAULT 0,
	Logico21			bit		NOT NULL	DEFAULT 0,
	Logico22			bit		NOT NULL	DEFAULT 0,
	Logico23			bit		NOT NULL	DEFAULT 0,
	Logico24			bit		NOT NULL	DEFAULT 0,
	Logico25			bit		NOT NULL	DEFAULT 0,
	Logico26			bit		NOT NULL	DEFAULT 0,
	Logico27			bit		NOT NULL	DEFAULT 0,
	Logico28			bit		NOT NULL	DEFAULT 0,
	Logico29			bit		NOT NULL	DEFAULT 0,
	Logico30			bit		NOT NULL	DEFAULT 0,
	Logico31			bit		NOT NULL	DEFAULT 0,
	Logico32			bit		NOT NULL	DEFAULT 0,
	Logico33			bit		NOT NULL	DEFAULT 0,
	Logico34			bit		NOT NULL	DEFAULT 0,
	Logico35			bit		NOT NULL	DEFAULT 0,
	Logico36			bit		NOT NULL	DEFAULT 0,
	Logico37			bit		NOT NULL	DEFAULT 0,
	Logico38			bit		NOT NULL	DEFAULT 0,
	Logico39			bit		NOT NULL	DEFAULT 0,
	Logico40			bit		NOT NULL	DEFAULT 0,
	Logico41			bit		NOT NULL	DEFAULT 0,
	Logico42			bit		NOT NULL	DEFAULT 0,
	Logico43			bit		NOT NULL	DEFAULT 0,
	Logico44			bit		NOT NULL	DEFAULT 0,
	Logico45			bit		NOT NULL	DEFAULT 0,
	Logico46			bit		NOT NULL	DEFAULT 0,
	Logico47			bit		NOT NULL	DEFAULT 0,
	Logico48			bit		NOT NULL	DEFAULT 0,
	Logico49			bit		NOT NULL	DEFAULT 0,
	Logico50			bit		NOT NULL	DEFAULT 0,

	CONSTRAINT priUsuarioCfg2 PRIMARY KEY  CLUSTERED (Usuario)
  )")
  EXEC("INSERT UsuarioCfg2 (Usuario) SELECT Usuario FROM Usuario")
END
GO

/****** UnidadConversion ******/
if not exists (select * from sysobjects where id = object_id('dbo.UnidadConversion') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.UnidadConversion (
	Unidad 		varchar(50) 	NOT NULL,
	Conversion	varchar(50) 	NOT NULL,

	CONSTRAINT priUnidadConversion PRIMARY KEY CLUSTERED (Unidad, Conversion)
  )")
GO

/****** ArtColumna ******/
if not exists (select * from sysobjects where id = object_id('dbo.ArtColumna') and sysstat & 0xf = 3) 
BEGIN
  EXEC("CREATE TABLE dbo.ArtColumna (
	Columna			varchar(50) 	NOT NULL,

	CONSTRAINT priArtColumna PRIMARY KEY CLUSTERED (Columna)
  )")
  EXEC("INSERT ArtColumna (Columna) SELECT Talla FROM Talla")
END

/****** ArtRenglon ******/
if not exists (select * from sysobjects where id = object_id('dbo.ArtRenglon') and sysstat & 0xf = 3) 
BEGIN
  EXEC("CREATE TABLE dbo.ArtRenglon (
	Renglon			varchar(50) NOT NULL,
	Descripcion		varchar(100)	NULL,

	CONSTRAINT priArtRenglon PRIMARY KEY CLUSTERED (Renglon)
  )")
  EXEC("INSERT ArtRenglon (Renglon, Descripcion) SELECT Color, Nombre FROM Color")
END
GO

/****** CteRelacion  ******/
if not exists (select * from sysobjects where id = object_id('dbo.CteRelacion') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.CteRelacion (
	Cliente 	char(10) 	NOT NULL,
	Relacion	char(10) 	NOT NULL,	

	CONSTRAINT priCteRelacion PRIMARY KEY  CLUSTERED (Cliente, Relacion)
  )")
go

/****** ProvRelacion  ******/
if not exists (select * from sysobjects where id = object_id('dbo.ProvRelacion') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ProvRelacion (
	Proveedor 	char(10) 	NOT NULL,
	Relacion	char(10) 	NOT NULL,	

	CONSTRAINT priProvRelacion PRIMARY KEY  CLUSTERED (Proveedor, Relacion)
  )")
go

/****** Claves de Afectacion ******/
if not exists (select * from sysobjects where id = object_id('dbo.MovClave') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.MovClave (
	Modulo			char(5)      	NOT NULL,
	Clave			char(20)	NOT NULL,

	NombreOmision		varchar(100)	NULL,
	Descripcion		varchar(255)	NULL,

	CONSTRAINT priMovClave PRIMARY KEY CLUSTERED (Modulo, Clave)
  )")
GO

/****** Historico de Precios ******/
if not exists (select * from sysobjects where id = object_id('dbo.ArtPrecioHist') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ArtPrecioHist (
	Articulo		char(20)	NOT NULL,
	Numero			int		NOT NULL,
	Fecha                   datetime   	NOT NULL,

	PrecioAnterior		money		NULL,
	PrecioActual		money		NULL,

	CONSTRAINT priArtPrecioHist PRIMARY KEY CLUSTERED (Articulo, Numero, Fecha)
  )")
GO


/****** Categorias de Produccion  ******/
if not exists (select * from sysobjects where id = object_id('dbo.ArtCatProd') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ArtCatProd (
	Categoria 		varchar(50) 	NOT NULL ,

	CategoriaMaestra 	varchar(50) 	NULL,
	Icono			int	  	NULL,

	CONSTRAINT priArtCatProd PRIMARY KEY CLUSTERED (Categoria)
  )")
GO



/****** VIN ******/
if not exists (select * from sysobjects where id = object_id('dbo.VIN') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.VIN (
	VIN	 		char(20)   	NOT NULL,

	Articulo 		char(20)   	NULL,
	Motor			varchar(20)	NULL,
	Llave			varchar(20)	NULL,
	Aduana			varchar(20)	NULL,
	Pedimiento		varchar(20)	NULL,
	ClaveVehicular		varchar(20)	NULL,
	Fecha			datetime	NULL,
	Aseguradora		varchar(50)	NULL,
	Cliente			char(10)	NULL,
	TieneMovimientos	bit		NOT NULL 	DEFAULT 0,

	Logico1			bit		NOT NULL 	DEFAULT 0,
	Logico2			bit		NOT NULL 	DEFAULT 0,
	Logico3			bit		NOT NULL 	DEFAULT 0,
	Logico4			bit		NOT NULL 	DEFAULT 0,
	Logico5			bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT priVIN PRIMARY KEY CLUSTERED (VIN)
  )")
GO

/****** Aseguradora ******/
if not exists (select * from sysobjects where id = object_id('dbo.Aseguradora') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.Aseguradora (
	Aseguradora		varchar(50)   	NOT NULL,

	CONSTRAINT priAseguradora PRIMARY KEY CLUSTERED (Aseguradora)
  )")
GO

/****** Aduana ******/
if not exists (select * from sysobjects where id = object_id('dbo.Aduana') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.Aduana (
	Aduana			varchar(50) NOT NULL,

	CONSTRAINT priAduana PRIMARY KEY CLUSTERED (Aduana)
  )")
GO

/****** Tramite  ******/
if not exists (select * from sysobjects where id = object_id('dbo.Tramite') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.Tramite (
	Tramite		varchar(50)	NOT NULL,

	Acreedor	char(10)	NULL,
	Comision	money		NULL,

	CONSTRAINT priTramite PRIMARY KEY  CLUSTERED (Tramite)
  )")
GO

/****** VentaOtros ******/
if not exists (select * from sysobjects where id = object_id('dbo.VentaOtros') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.VentaOtros (
	ID 			int         	NOT NULL,
	
	Tapones			bit		NOT NULL DEFAULT 0,
	Tapetes			bit		NOT NULL DEFAULT 0,
	Espejos			bit		NOT NULL DEFAULT 0,
	FarosAlojeno		bit		NOT NULL DEFAULT 0,
	RadioCassette		bit		NOT NULL DEFAULT 0,
	Cenicero		bit		NOT NULL DEFAULT 0,

	Gasolina		int		NULL,

	RayonesGolpes		varchar(255)	NULL,
	ObjetosUnidad		varchar(255)	NULL,
	Observaciones		varchar(255)	NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,
	Logico9			bit		NOT NULL DEFAULT 0,
	Logico10		bit		NOT NULL DEFAULT 0,

	CONSTRAINT priVentaOtros PRIMARY KEY CLUSTERED (ID)
  )")
GO/****** CxcTramite ******/
if not exists (select * from sysobjects where id = object_id('dbo.CxcTramite') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.CxcTramite (
	ID 			int             NOT NULL,
	Tramite			varchar(50)	NOT NULL,

        Importe                 money           NULL,
	Observaciones 		varchar(100) 	NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priCxcTramite PRIMARY KEY CLUSTERED (ID, Tramite)

  )")
GO


/****** Conceptos Validados de la Empresa ******/
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaConceptoValidar') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.EmpresaConceptoValidar (
	Empresa 			char(5)  	NOT NULL,
	Modulo				char(5)		NOT NULL,
	Mov				char(20)	NOT NULL,
	Concepto			varchar(50)	NOT NULL,

	CONSTRAINT priEmpresaConceptoValidar PRIMARY KEY  CLUSTERED (Empresa, Modulo, Mov, Concepto)
  )")
GO


/****** Nacionalidad ******/
if not exists (select * from sysobjects where id = object_id('dbo.Nacionalidad') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.Nacionalidad (
	Nacionalidad 		varchar(30) 	NOT NULL,

	Orden			int		NULL,

	CONSTRAINT priNacionalidad PRIMARY KEY CLUSTERED (Nacionalidad)
  )")
GO

/****** Instrucciones  ******/
if not exists (select * from sysobjects where id = object_id('dbo.Instruccion') and sysstat & 0xf = 3) 
BEGIN
  EXEC("CREATE TABLE dbo.Instruccion (
	Modulo			char(5)	     	NOT NULL,
	Instruccion		varchar(50) 	NOT NULL ,

	CONSTRAINT priInstruccion PRIMARY KEY CLUSTERED (Modulo, Instruccion)
  )")
  EXEC("INSERT Instruccion (Modulo, Instruccion) SELECT Modulo, Opcion FROM Opcion")
  EXEC("drop table dbo.Opcion")
  EXEC("IF EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VentaD') and c.name = 'Opcion' and o.sysstat & 0xf = 3) EXEC sp_rename 'VentaD.Opcion', 'Instruccion', 'COLUMN'")
  EXEC("IF EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Compra') and c.name = 'Opcion' and o.sysstat & 0xf = 3) EXEC sp_rename 'Compra.Opcion', 'Instruccion', 'COLUMN'")
END
GO

/****** Situaciones x Usuario ******/
if not exists (select * from sysobjects where id = object_id('dbo.MovSituacionUsuario') and sysstat & 0xf = 3)
  EXEC("CREATE TABLE dbo.MovSituacionUsuario (
	ID		int		NOT NULL,
	Usuario		char(10)	NOT NULL,

	CONSTRAINT priMovSituacionUsuario PRIMARY KEY  CLUSTERED (ID, Usuario)
  )")
GO

/****** CteArtBloqueo  ******/
if not exists (select * from sysobjects where id = object_id('dbo.CteArtBloqueo') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.CteArtBloqueo (
	Cliente 	char(10) 	NOT NULL,
	Agrupador	varchar(20)	NOT NULL,  -- Categoria, Grupo, Familia, Fabricante
	Nombre		varchar(50) 	NOT NULL,  -- HP

	CONSTRAINT priCteArtBloqueo PRIMARY KEY  CLUSTERED (Cliente, Agrupador, Nombre)
  )")
go

/****** UsuarioAlm ******/
if not exists (select * from sysobjects where id = object_id('dbo.UsuarioAlm') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.UsuarioAlm (
	Usuario 	char(10)  	NOT NULL,
	Almacen		char(10)	NOT NULL,

	CONSTRAINT priUsuarioAlm PRIMARY KEY CLUSTERED (Usuario, Almacen)
  )")
GO



/****** Configuracion de la Empresa por Modulo (Cancelar Movimientos en Periodos Cerrados) ******/
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgCancelarMov') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.EmpresaCfgCancelarMov (
	Empresa 	char(5)  	NOT NULL,
	Modulo		char(5)		NOT NULL,
	Mov		char(20)	NOT NULL,

	CONSTRAINT priEmpresaCfgCancelarMov PRIMARY KEY  CLUSTERED (Empresa, Modulo, Mov)
  )")
GO

/****** Configuracion de Movimientos Relacionados ******/
if (SELECT Version FROM Version)<=311 AND exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgMovRel') and sysstat & 0xf = 3) 
 EXEC("drop table dbo.EmpresaCfgMovRel")
GO


/****** CtaBitacora ******/
if not exists (select * from sysobjects where id = object_id('dbo.CtaBitacora') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.CtaBitacora (
	Modulo			char(5)		NOT NULL,
	Cuenta			char(20)      	NOT NULL,
	Fecha			datetime	NOT NULL,

	Evento			varchar(255)	NULL,

	CONSTRAINT priCtaBitacora PRIMARY KEY CLUSTERED (Modulo, Cuenta, Fecha)
  )")
GO

/****** ArtMaterial ******/
if not exists (select * from sysobjects where id = object_id('dbo.ArtMaterial') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ArtMaterial (
	Articulo	char(20) 	NOT NULL,
 	OrdenID		int 	    	NOT NULL IDENTITY(1,1),

	SiOpcion	varchar(100)	NULL,
	Material	char(20)	NULL,
	SubCuenta	varchar(20)	NULL,
	Cantidad	float		NULL,
	Unidad		varchar(50)	NULL,
	Merma		float		NULL,		-- % 
	Desperdicio	float		NULL,
	CentroTipo	varchar(20)	NULL,
	CostoAcumulado	money		NULL,
	Orden		int		NULL,

	Logico1		bit		NOT NULL 	DEFAULT 0,
	Logico2		bit		NOT NULL 	DEFAULT 0,
	Logico3		bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT priArtMaterial PRIMARY KEY  CLUSTERED (Articulo, OrdenID)
  )")
GO

/* ArtMaterial */
IF (SELECT Version FROM Version)<=330 AND EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ArtMaterial') and c.name = 'Opcion' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename ArtMaterial, Temporal")
    EXEC("CREATE TABLE dbo.ArtMaterial (
	Articulo	char(20) 	NOT NULL,
 	OrdenID		int 	    	NOT NULL IDENTITY(1,1),

	SiOpcion	varchar(100)	NULL,
	Material	char(20)	NULL,
	SubCuenta	varchar(20)	NULL,
	Cantidad	float		NULL,
	Unidad		varchar(50)	NULL,
	Merma		float		NULL,		-- % 
	Desperdicio	float		NULL,
	CentroTipo	varchar(20)	NULL,
	CostoAcumulado	money		NULL,
	Orden		int		NULL,

	Logico1		bit		NOT NULL 	DEFAULT 0,
	Logico2		bit		NOT NULL 	DEFAULT 0,
	Logico3		bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT pArtMaterial PRIMARY KEY  CLUSTERED (Articulo, OrdenID)
  )")
  EXEC("INSERT ArtMaterial (Articulo, Material, Cantidad, Unidad, Merma, Desperdicio, CentroTipo, CostoAcumulado, Orden)
                     SELECT Articulo, Material, Cantidad, Unidad, Merma, Desperdicio, CentroTipo, CostoAcumulado, Orden
                       FROM Temporal")
  EXEC("DROP TABLE Temporal")
END
GO


/****** ArtOperacion ******/
if not exists (select * from sysobjects where id = object_id('dbo.ArtOperacion') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ArtOperacion (
	Operacion		varchar(100)	NOT NULL,

	CONSTRAINT priOperacion PRIMARY KEY  CLUSTERED (Operacion)
  )")
GO


/* ArtCostoHist */
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ArtCostoHist') and c.name = 'SubCuenta' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename ArtCostoHist, Temporal")
  EXEC("CREATE TABLE dbo.ArtCostoHist (
	Empresa			char(5)		NOT NULL,
	Articulo		char(20)	NOT NULL,
	Fecha                   datetime   	NOT NULL,

	UltimoCostoAnterior	money		NULL,
	UltimoCostoActual	money		NULL,

	CONSTRAINT pArtCostoHist PRIMARY KEY CLUSTERED (Empresa, Articulo, Fecha)
  )")
  EXEC("CREATE TABLE dbo.ArtSubCostoHist (
	Empresa			char(5)		NOT NULL,
	Articulo		char(20)	NOT NULL,
	SubCuenta		varchar(20)	NOT NULL 	DEFAULT '',
	Fecha                   datetime   	NOT NULL,

	UltimoCostoAnterior	money		NULL,
	UltimoCostoActual	money		NULL,

	CONSTRAINT priArtSubCostoHist PRIMARY KEY CLUSTERED (Empresa, Articulo, SubCuenta, Fecha)
  )")
  EXEC("INSERT ArtCostoHist (Empresa, Articulo, Fecha, UltimoCostoAnterior, UltimoCostoActual)
                     SELECT Empresa, Articulo, Fecha, UltimoCostoAnterior, UltimoCostoActual
                       FROM Temporal
                      WHERE SubCuenta = ''")
  EXEC("INSERT ArtSubCostoHist (Empresa, Articulo, SubCuenta, Fecha, UltimoCostoAnterior, UltimoCostoActual)
                     SELECT Empresa, Articulo, SubCuenta, Fecha, UltimoCostoAnterior, UltimoCostoActual
                       FROM Temporal
                      WHERE SubCuenta <> ''")
  EXEC("DROP TABLE Temporal")
END
GO

/****** Historico de Costos ******/
if not exists (select * from sysobjects where id = object_id('dbo.ArtCostoHist') and sysstat & 0xf = 3) 
EXEC("CREATE TABLE dbo.ArtCostoHist (
	Empresa			char(5)		NOT NULL,
	Articulo		char(20)	NOT NULL,
	Fecha                   datetime   	NOT NULL,

	UltimoCostoAnterior	money		NULL,
	UltimoCostoActual	money		NULL,

	CONSTRAINT priArtCostoHist PRIMARY KEY CLUSTERED (Empresa, Articulo, Fecha)
)")
GO


/****** Historico de Costos ******/
if not exists (select * from sysobjects where id = object_id('dbo.ArtSubCostoHist') and sysstat & 0xf = 3) 
EXEC("CREATE TABLE dbo.ArtSubCostoHist (
	Empresa			char(5)		NOT NULL,
	Articulo		char(20)	NOT NULL,
	SubCuenta		varchar(20)	NOT NULL 	DEFAULT '',
	Fecha                   datetime   	NOT NULL,

	UltimoCostoAnterior	money		NULL,
	UltimoCostoActual	money		NULL,

	CONSTRAINT priArtSubCostoHist PRIMARY KEY CLUSTERED (Empresa, Articulo, SubCuenta, Fecha)
)")
GO

IF (SELECT Version FROM Version)<=310 AND exists (select * from sysobjects where id = object_id('dbo.Estacion') and sysstat & 0xf = 3) 
  drop table dbo.Estacion
IF (SELECT Version FROM Version)<=311 AND exists (select * from sysobjects where id = object_id('dbo.Centro') and sysstat & 0xf = 3) 
  drop table dbo.Centro
IF (SELECT Version FROM Version)<=310 AND exists (select * from sysobjects where id = object_id('dbo.EstacionAgente') and sysstat & 0xf = 3) 
  drop table dbo.EstacionAgente
IF (SELECT Version FROM Version)<=310 AND exists (select * from sysobjects where id = object_id('dbo.EstacionAF') and sysstat & 0xf = 3) 
  drop table dbo.EstacionAF
IF (SELECT Version FROM Version)<=310 AND exists (select * from sysobjects where id = object_id('dbo.EstacionIndirectos') and sysstat & 0xf = 3) 
  drop table dbo.EstacionIndirectos
IF (SELECT Version FROM Version)<=311 AND exists (select * from sysobjects where id = object_id('dbo.CentroIndirectos') and sysstat & 0xf = 3) 
  drop table dbo.CentroIndirectos
IF (SELECT Version FROM Version)<=325 AND exists (select * from sysobjects where id = object_id('dbo.ArtEstructura') and sysstat & 0xf = 3)
  drop table dbo.ArtEstructura
GO

/****** CentroCat ******/
if not exists (select * from sysobjects where id = object_id('dbo.CentroCat') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.CentroCat (
	Categoria		varchar(50)	NOT NULL,

	CONSTRAINT priCentroCat PRIMARY KEY  CLUSTERED (Categoria)
  )")
GO

/****** CentroAgente ******/
if not exists (select * from sysobjects where id = object_id('dbo.CentroAgente') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.CentroAgente (
	Centro		char(10) 	NOT NULL,
 	OrdenID		int 	    	NOT NULL IDENTITY(1,1),

	Agente		char(10)	NULL,

	CONSTRAINT priCentroAgente PRIMARY KEY  CLUSTERED (Centro, OrdenID)
  )")
GO

/****** CentroAF ******/
if not exists (select * from sysobjects where id = object_id('dbo.CentroAF') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.CentroAF (
	Centro		char(10) 	NOT NULL,
 	OrdenID		int 	    	NOT NULL IDENTITY(1,1),

	ActivoFijo	char(20)	NULL,
	Serie		char(20)	NULL,

	CONSTRAINT priCentroAF PRIMARY KEY  CLUSTERED (Centro, OrdenID)
  )")
GO

/****** CentroIndirectos ******/
if not exists (select * from sysobjects where id = object_id('dbo.CentroIndirectos') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.CentroIndirectos (
	Centro		char(10) 	NOT NULL,
 	OrdenID		int 	    	NOT NULL IDENTITY(1,1),

	Concepto	varchar(50)	NULL,
	Tipo		char(10)	NULL,		-- Directo/Indirecto
	Costo		money		NULL,		-- Costo por Hora
	Moneda		char(10)	NULL,

	CONSTRAINT priCentroIndirectos PRIMARY KEY  CLUSTERED (Centro, OrdenID)
  )")
GO


/****** ListaPrecios ******/
if not exists (select * from sysobjects where id = object_id('dbo.ListaPrecios') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ListaPrecios (
	Lista		char(20)	NOT NULL,
	Moneda		char(10)	NOT NULL,
	PreciosNetos	bit		NOT NULL DEFAULT 0,

	CONSTRAINT priListaPrecios PRIMARY KEY CLUSTERED (Lista, Moneda)
  )")
GO

/****** ListaPreciosD ******/
if not exists (select * from sysobjects where id = object_id('dbo.ListaPreciosD') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ListaPreciosD (
	Lista		char(20)	NOT NULL,
	Moneda		char(10)	NOT NULL,
	ID		int 		NOT NULL IDENTITY(1,1),

	Articulo	char(20)	NOT NULL,
	SubCuenta	varchar(20)	NULL,

	Precio		money		NULL,

	CONSTRAINT priListaPreciosD PRIMARY KEY CLUSTERED (Lista, Moneda, ID)
  )")
GO

/****** CxcAplicaDif ******/
if not exists (select * from sysobjects where id = object_id('dbo.CxcAplicaDif') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.CxcAplicaDif (
	ID 			int         	NOT NULL,
	OrdenID 		int         	NOT NULL IDENTITY(1,1),

	Mov			char(20)        NULL,        
	Concepto		varchar(50)	NULL,
	Importe			money		NULL,

	Cliente			char(10)	NULL,
	ClienteEnviarA		int		NULL,

	CONSTRAINT priCxcAplicaDif PRIMARY KEY CLUSTERED (ID, OrdenID)
  )")
GO

/****** CxpAplicaDif ******/
if not exists (select * from sysobjects where id = object_id('dbo.CxpAplicaDif') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.CxpAplicaDif (
	ID 			int         	NOT NULL,
	OrdenID 		int         	NOT NULL IDENTITY(1,1),

	Mov			char(20)        NULL,        
	Concepto		varchar(50)	NULL,
	Importe			money		NULL,

	CONSTRAINT priCxpAplicaDif PRIMARY KEY CLUSTERED (ID, OrdenID)
  )")
GO

/****** Compras con Gastos Diversos (Multiple) ******/
if not exists (select * from sysobjects where id = object_id('dbo.CompraGastoDiversoD') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.CompraGastoDiversoD (
	ID			int 	    	NOT NULL,
	Concepto		varchar(50)	NOT NULL,
	Acreedor		char(10)	NOT NULL,
	ConceptoD		varchar(50)	NOT NULL,

	Importe			money		NULL,
	Impuestos		money		NULL,
	Referencia		varchar(50)	NULL,

	CONSTRAINT priCompraGastoDiversoD PRIMARY KEY CLUSTERED (ID, Concepto, Acreedor, ConceptoD)
  )")
GO

/****** AgenteCte ******/
if not exists (select * from sysobjects where id = object_id('dbo.AgenteCte') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.AgenteCte (
	Agente 		char(10) NOT NULL,
	Cliente		char(10) NOT NULL,

	Comision	float	 NULL,

	CONSTRAINT priAgenteCte PRIMARY KEY CLUSTERED (Agente, Cliente)
  )")
GO

/* Prod */
if (SELECT Version FROM Version)<=312 AND EXISTS(SELECT * FROM SysObjects WHERE Id = object_id('dbo.Prod') AND SysStat & 0xf = 3) drop table dbo.Prod
if (SELECT Version FROM Version)<=312 AND EXISTS(SELECT * FROM SysObjects WHERE Id = object_id('dbo.ProdD') AND SysStat & 0xf = 3) drop table dbo.ProdD
if (SELECT Version FROM Version)<=312 AND EXISTS(SELECT * FROM SysObjects WHERE Id = object_id('dbo.ProdC') AND SysStat & 0xf = 3) drop table dbo.ProdC
if (SELECT Version FROM Version)<=331 AND EXISTS(SELECT * FROM SysObjects WHERE Id = object_id('dbo.ProdExp') AND SysStat & 0xf = 3) drop table dbo.ProdExp
if (SELECT Version FROM Version)<=331 AND EXISTS(SELECT * FROM SysObjects WHERE Id = object_id('dbo.ProdCostoAdicional') AND SysStat & 0xf = 3) drop table dbo.ProdCostoAdicional
GO

/****** Produccion ******/
if not exists (select * from sysobjects where id = object_id('dbo.Prod') and sysstat & 0xf = 3) 
BEGIN
  EXEC("CREATE TABLE dbo.Prod (
	ID			int 	    	NOT NULL IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov 			char(20)        NOT NULL,
	MovID			int         	NULL,
	FechaEmision 		datetime    	NULL,
	UltimoCambio 		datetime    	NULL,
	Concepto		varchar(50)	NULL,
	Proyecto		varchar(50)   	NULL,
	Moneda  		char(10)   	NOT NULL,
	TipoCambio		float		NULL,
	Usuario 		char(10)   	NULL,
	Autorizacion		char(10)	NULL,
	Referencia 		varchar(50) 	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Estatus 		char(15)   	NULL,
	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,

	Directo			bit		NOT NULL DEFAULT 1,
	VerDestino		bit		NOT NULL DEFAULT 0,
	AutoReservar		bit		NOT NULL DEFAULT 0,
	CostoAdicional		bit		NOT NULL DEFAULT 0,
	RenglonID		int		NULL,

	Almacen	        	char(10)   	NULL,
	Prioridad		char(10)	NULL,
	FechaRequerida		datetime	NULL,	
	Peso			float		NULL,
	Volumen			float		NULL,
	Paquetes		int		NULL,

	OrigenTipo		varchar(10)	NULL,	-- Que Movimiento Origino este Movimiento (si aplica)
	Origen			varchar(20)	NULL,
	OrigenID		int		NULL,

	Poliza			varchar(20)     NULL,
	PolizaID		int		NULL,
	GenerarPoliza		bit	    	NOT NULL DEFAULT 0,
	ContID			int		NULL,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,
	Logico9			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priProd PRIMARY KEY CLUSTERED (ID)
  )")
  EXEC("CREATE INDEX Consecutivo  ON dbo.Prod (Mov, MovID, Empresa)")
  EXEC("CREATE INDEX FechaEmision ON dbo.Prod (FechaEmision, Empresa)")
  EXEC("CREATE INDEX Usuario      ON dbo.Prod (Usuario)")
  EXEC("CREATE INDEX Situacion    ON dbo.Prod (Estatus, Situacion, Empresa)")
  EXEC("CREATE INDEX Referencia   ON dbo.Prod (Referencia)")
  EXEC("CREATE INDEX ContID	  ON dbo.Prod (ContID)")
END
go

/****** Produccion (Detalle) ******/
if not exists (select * from sysobjects where id = object_id('dbo.ProdD') and sysstat & 0xf = 3) 
BEGIN
  EXEC("CREATE TABLE dbo.ProdD (
	ID 			int       	NOT NULL,
 	Renglon			float	  	NOT NULL,
	RenglonSub		int		NOT NULL   	DEFAULT 0,

	RenglonID		int		NULL,
	RenglonTipo		char(1)         NULL 		DEFAULT 'N',

	AutoGenerado		bit		NULL 		DEFAULT 0,
	Almacen			char(10)	NULL,
	Articulo	        char(20) 	NOT NULL,
	SubCuenta		varchar(20)	NULL,
        Cantidad                float     	NULL,
        Costo               	money     	NULL,

	ProdSerieLote		varchar(50)	NULL,

	CantidadPendiente	float	    	NULL,
	CantidadReservada	float	    	NULL,
	CantidadCancelada	float		NULL,
	CantidadOrdenada	float		NULL,
	CantidadA		float	    	NULL,
	Paquete			int		NULL,

	DestinoTipo		varchar(10)	NULL,
	Destino   	        varchar(20)     NULL,	-- Cual es el destino final (ej en una OP es el Pedido x) 
        DestinoID	        varchar(20)     NULL,
	Aplica   	        varchar(20)     NULL,	
        AplicaID	        int             NULL,

	Cliente			varchar(10)	NULL,	-- Cuando se maneja BackOrder's por Cliente
	Centro			varchar(10)	NULL,	-- Centro de la Ruta
	CentroDestino		varchar(10)	NULL,	

	Unidad			varchar(50)	NULL,
	Factor			float	    	NULL DEFAULT 1.0,
        CantidadInventario      float     	NULL,

	Ruta			varchar(20)	NULL,

	SustitutoArticulo       varchar(20)   	NULL,
	SustitutoSubCuenta	varchar(20)	NULL,

	FechaRequerida		datetime    	NULL,
	FechaEntrega		datetime	NULL,
	DescripcionExtra	varchar(100) 	NULL,

	UltimoReservadoCantidad	float		NULL,
	UltimoReservadoFecha	datetime	NULL,

	Logico1			bit		NOT NULL 	DEFAULT 0,
	Logico2			bit		NOT NULL 	DEFAULT 0,
	Logico3			bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT priProdD PRIMARY KEY CLUSTERED (ID,Renglon,RenglonSub)
  )")
  EXEC("CREATE INDEX Articulo ON dbo.ProdD (Articulo)")
  EXEC("CREATE INDEX ProdSerieLote ON dbo.ProdD (ProdSerieLote)")
END
GO


/****** Produccion ******/
if not exists (select * from sysobjects where id = object_id('dbo.ProdC') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ProdC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NOT NULL,
	Mov 		        char(20) 	NOT NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,

	CONSTRAINT priProdC PRIMARY KEY  CLUSTERED (ID)
  )")
GO


/****** ProdRutaCat ******/
if not exists (select * from sysobjects where id = object_id('dbo.ProdRutaCat') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ProdRutaCat (
	Categoria		varchar(50) 	NOT NULL,

	CONSTRAINT priProdRutaCat PRIMARY KEY  CLUSTERED (Categoria)
  )")
GO

/****** ProdRuta ******/
if not exists (select * from sysobjects where id = object_id('dbo.ProdRuta') and sysstat & 0xf = 3)
  EXEC("CREATE TABLE dbo.ProdRuta (
	Ruta			char(20) 	NOT NULL,
	Descripcion		varchar(100) 	NULL,
	Categoria		varchar(50) 	NULL,

	CONSTRAINT priProdRuta PRIMARY KEY  CLUSTERED (Ruta)
  )")
GO

/****** ProdRutaD ******/
if not exists (select * from sysobjects where id = object_id('dbo.ProdRutaD') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ProdRutaD (
	Ruta			char(20) 	NOT NULL,
 	OrdenID			int 	    	NOT NULL IDENTITY(1,1),

	Orden			int		NULL,
	Centro			char(10)	NULL,
	Operacion		varchar(100)	NULL,
	TiempoPreparacion	float		NULL,
	TiempoEjecucion		float		NULL,
	UnidadT			char(10)	NULL,
	Costo			money		NULL,
	Moneda			char(10)	NULL,

	Logico1			bit		NOT NULL 	DEFAULT 0,
	Logico2			bit		NOT NULL 	DEFAULT 0,
	Logico3			bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT priProdRutaD PRIMARY KEY  CLUSTERED (Ruta, OrdenID)
  )")
GO

if (SELECT Version FROM Version)<=321 AND exists (select * from sysobjects where id = object_id('dbo.ArtRuta') and sysstat & 0xf = 3) 
  drop table dbo.ArtRuta
if (SELECT Version FROM Version)<=321 AND exists (select * from sysobjects where id = object_id('dbo.ArtRutaAlterna') and sysstat & 0xf = 3) 
  drop table dbo.ArtRutaAlterna
GO

/****** CentroTipo ******/
if not exists (select * from sysobjects where id = object_id('dbo.CentroTipo') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.CentroTipo (
	Tipo		varchar(20)	NOT NULL,

	CONSTRAINT priCentroTipo PRIMARY KEY  CLUSTERED (Tipo)
  )")
GO


/****** Sugerir Costos por Categoria de Articulo ******/
if not exists (select * from sysobjects where id = object_id('dbo.SugerirCostoArtCat') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.SugerirCostoArtCat (
	Empresa			char(5)		NOT NULL,
	Categoria		char(20)	NOT NULL,
	Proveedor		char(10)	NOT NULL,
	Costo			money		NULL,

	CONSTRAINT priSugerirCostoArtCat PRIMARY KEY CLUSTERED (Empresa, Categoria, Proveedor)
  )")
GO


IF (SELECT Version FROM Version)<=315 AND exists (select * from sysobjects where id = object_id('dbo.PlanConcepto') and sysstat & 0xf = 3) 
  drop table dbo.PlanConcepto
IF (SELECT Version FROM Version)<=319 AND exists (select * from sysobjects where id = object_id('dbo.PlanEstructura') and sysstat & 0xf = 3) 
  drop table dbo.PlanEstructura
IF (SELECT Version FROM Version)<=316 AND exists (select * from sysobjects where id = object_id('dbo.Acronimo') and sysstat & 0xf = 3) 
  drop table dbo.Acronimo
IF (SELECT Version FROM Version)<=333 AND exists (select * from sysobjects where id = object_id('dbo.PlanArt') and sysstat & 0xf = 3) 
  drop table dbo.PlanArt
IF (SELECT Version FROM Version)<=324 AND exists (select * from sysobjects where id = object_id('dbo.PlanArtOP') and sysstat & 0xf = 3) 
  drop table dbo.PlanArtOP
GO

/****** Acronimo ******/
if not exists (select * from sysobjects where id = object_id('dbo.Acronimo') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.Acronimo (
	Acronimo	char(10)	NOT NULL, 
	Termino		varchar(100)	NULL,

	CONSTRAINT priAcronimo PRIMARY KEY CLUSTERED (Acronimo)
  )")
GO

/****** PlanEstructura ******/
if not exists (select * from sysobjects where id = object_id('dbo.PlanEstructura') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.PlanEstructura (
	TipoPlan	char(10)	NOT NULL,
	Orden 		int		NOT NULL,
	Acronimo	char(10)	NOT NULL,

	Visible		bit		NOT NULL	DEFAULT 0,

	CONSTRAINT priPlanEstructura PRIMARY KEY CLUSTERED (TipoPlan, Orden, Acronimo)
  )")
GO

/****** ProdRutaAlterna ******/
if not exists (select * from sysobjects where id = object_id('dbo.ProdRutaAlterna') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ProdRutaAlterna (
	Ruta		char(20) 	NOT NULL,
	RutaAlterna	char(20)	NOT NULL,

	Orden		int		NULL,

	CONSTRAINT priProdRutaAlterna PRIMARY KEY  CLUSTERED (Ruta, RutaAlterna)
  )")
GO


/****** PlanArt ******/
if not exists (select * from sysobjects where id = object_id('dbo.PlanArt') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.PlanArt (
	Empresa		char(5)		NOT NULL,
	Almacen		char(10)	NOT NULL,
	Articulo	char(20)	NOT NULL,
	SubCuenta	varchar(20)	NOT NULL	DEFAULT '',
	Acronimo	char(10)	NOT NULL,
	Periodo		int		NOT NULL,

	Cantidad	money		NULL,
	
	CONSTRAINT priPlanArt PRIMARY KEY CLUSTERED (Empresa, Articulo, SubCuenta, Almacen, Acronimo, Periodo)
  )")
GO

/****** PlanArtOP ******/
if not exists (select * from sysobjects where id = object_id('dbo.PlanArtOP') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.PlanArtOP (
	Empresa			char(5)		NOT NULL,
	Almacen			char(10)	NOT NULL,
	Articulo		char(20)	NOT NULL,
	SubCuenta		varchar(20)	NOT NULL	DEFAULT '',
        ID			int		IDENTITY(1,1)	NOT NULL,

	FechaLiberacionOriginal	datetime	NULL,
	FechaEntregaOriginal	datetime	NULL,
	CantidadOriginal	float		NULL,
	RutaOriginal		varchar(20)	NULL,

	FechaLiberacion		datetime	NULL,
	FechaEntrega		datetime	NULL,
	Cantidad		float		NULL,
	Ruta			varchar(20)	NULL,

	Unidad			varchar(50)	NULL,
	Proveedor		char(10)	NULL,
	Accion			varchar(20)	NULL,
	Estado			varchar(20)	NULL,  -- Pendiente, En Firme, Liberada
	
	CONSTRAINT priPlanArtOP PRIMARY KEY CLUSTERED (Empresa, Articulo, SubCuenta, Almacen, ID)
  )")
GO

/****** CentroTipo ******/
if not exists (select * from sysobjects where id = object_id('dbo.CentroTipo') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.CentroTipo (
	Tipo		varchar(20)	NOT NULL,

	CONSTRAINT priCentroTipo PRIMARY KEY  CLUSTERED (Tipo)
  )")
GO


if (SELECT Version FROM Version)<=325 AND exists (select * from sysobjects where id = object_id('dbo.CentroAgente') and sysstat & 0xf = 3) 
 DROP TABLE dbo.CentroAgente

if (SELECT Version FROM Version)<=325 AND exists (select * from sysobjects where id = object_id('dbo.CentroAF') and sysstat & 0xf = 3) 
 DROP TABLE dbo.CentroAF

if (SELECT Version FROM Version)<=325 AND exists (select * from sysobjects where id = object_id('dbo.CentroIndirectos') and sysstat & 0xf = 3) 
 DROP TABLE dbo.CentroIndirectos

if (SELECT Version FROM Version)<=325 AND exists (select * from sysobjects where id = object_id('dbo.CentroCat') and sysstat & 0xf = 3) 
 DROP TABLE dbo.CentroCat
if (SELECT Version FROM Version)<=328 AND exists (select * from sysobjects where id = object_id('dbo.CentroEstacion') and sysstat & 0xf = 3)
 DROP TABLE dbo.CentroEstacion
if (SELECT Version FROM Version)<=329 AND exists (select * from sysobjects where id = object_id('dbo.Centro') and sysstat & 0xf = 3) 
 DROP TABLE dbo.Centro
if (SELECT Version FROM Version)<=329 AND exists (select * from sysobjects where id = object_id('dbo.EstacionT') and sysstat & 0xf = 3) 
 DROP TABLE dbo.EstacionT
if (SELECT Version FROM Version)<=332 AND exists (select * from sysobjects where id = object_id('dbo.ProdSerieLote') and sysstat & 0xf = 3) 
 DROP TABLE dbo.ProdSerieLote
if (SELECT Version FROM Version)<=332 AND exists (select * from sysobjects where id = object_id('dbo.ProdSerieLoteCosto') and sysstat & 0xf = 3) 
 DROP TABLE dbo.ProdSerieLoteCosto
if (SELECT Version FROM Version)<=332 AND exists (select * from sysobjects where id = object_id('dbo.ArtSubOrdenar') and sysstat & 0xf = 3) 
 DROP TABLE dbo.ArtSubOrdenar
GO

/****** EstacionTCat ******/
if not exists (select * from sysobjects where id = object_id('dbo.EstacionTCat') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.EstacionTCat (
	Categoria		varchar(50) 	NOT NULL,

	CONSTRAINT priEstacionTCat PRIMARY KEY  CLUSTERED (Categoria)
  )")
GO

/****** EstacionT ******/
if not exists (select * from sysobjects where id = object_id('dbo.EstacionT') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.EstacionT (
	Estacion		char(10) 	NOT NULL,

	Centro			char(10) 	NULL,
	Categoria		varchar(50) 	NULL,

	Descripcion		varchar(100)	NULL,
	DiasSemana		int		NULL,
	TurnosDiarios		int		NULL,
	HorasTurno		float		NULL,
	Eficiencia		float		NULL		DEFAULT 100,
	Utilizacion		float		NULL		DEFAULT 100,
	DiasFestivos		bit		NOT NULL 	DEFAULT 0,
	CostoManoObra		money		NULL,
	CostoIndirectos		money		NULL,
	CostoMoneda		char(10)	NULL,

	Estatus			char(15) 	NOT NULL,


	CONSTRAINT priEstacionT PRIMARY KEY  CLUSTERED (Estacion)
  )")
GO

/****** Centro ******/
if not exists (select * from sysobjects where id = object_id('dbo.Centro') and sysstat & 0xf = 3) 
EXEC("CREATE TABLE dbo.Centro (
	Centro			char(10) 	NOT NULL,
	Tipo			varchar(20)	NULL,
	Descripcion		varchar(100)	NULL,

	Estatus			char(15) 	NOT NULL,
	Almacen			char(10)	NULL,
	Orden			int		NULL,
	Autorizar		bit		NOT NULL 	DEFAULT 0,
	Cxp			bit		NOT NULL 	DEFAULT 0,
	Proveedor		char(10)	NULL,
	Impuesto1		float		NULL,
	Condicion		varchar(50)	NULL,
	Concepto		varchar(50)	NULL,

	TiempoCola		float		NULL,
	TiempoEspera		float		NULL,

	DiasSemana		int		NULL,
	TurnosDiarios		int		NULL,
	HorasTurno		float		NULL,
	Eficiencia		float		NULL		DEFAULT 100,
	Utilizacion		float		NULL		DEFAULT 100,
	DiasFestivos		bit		NOT NULL 	DEFAULT 0,

	Logico1			bit		NOT NULL 	DEFAULT 0,
	Logico2			bit		NOT NULL 	DEFAULT 0,
	Logico3			bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT priCentro PRIMARY KEY  CLUSTERED (Centro)
  )")
GO

/****** ArtSubCostos ******/
if not exists (select * from sysobjects where id = object_id('dbo.ArtSubCosto') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ArtSubCosto (
	Empresa			char(5)		NOT NULL,
	Articulo 		char(20) 	NOT NULL,
	SubCuenta		varchar(20)	NOT NULL 	DEFAULT '',

	UltimoCosto		money     	NULL,
	CostoPromedio		money     	NULL,
	CostoEstandar		money	  	NULL,
	UltimoCostoSinGastos	money	  	NULL,

	CONSTRAINT priArtSubCosto PRIMARY KEY CLUSTERED (Empresa, Articulo, SubCuenta)
  )")
GO

/* ArtCosto */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ArtCosto') and c.name = 'UltimoCostoSinGastos' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE ArtCosto ADD UltimoCostoSinGastos money NULL")
END
GO

/* ArtCosto */
IF (SELECT Version FROM Version)<=327 AND EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ArtCosto') and c.name = 'SubCuenta' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("DELETE ArtSubCosto")
  EXEC("INSERT ArtSubCosto (Empresa, Articulo, SubCuenta, UltimoCosto, CostoPromedio, CostoEstandar, UltimoCostoSinGastos)
                     SELECT Empresa, Articulo, SubCuenta, UltimoCosto, CostoPromedio, CostoEstandar, UltimoCostoSinGastos
                       FROM ArtCosto")
  EXEC("DROP TABLE dbo.ArtCosto")
  EXEC("CREATE TABLE dbo.ArtCosto (
	Empresa			char(5)		NOT NULL,
	Articulo 		char(20) 	NOT NULL,

	UltimoCosto		money     	NULL,
	CostoPromedio		money     	NULL,
	CostoEstandar		money	  	NULL,
	UltimoCostoSinGastos	money	  	NULL,

	CONSTRAINT priArtCosto PRIMARY KEY CLUSTERED (Empresa, Articulo)
  )")
  EXEC("INSERT ArtCosto (Empresa, Articulo, UltimoCosto, UltimoCostoSinGastos, CostoPromedio, CostoEstandar)
        SELECT Empresa, Articulo, AVG(UltimoCosto), AVG(UltimoCosto), AVG(CostoPromedio), AVG(CostoEstandar)
          FROM ArtSubCosto
         GROUP BY Empresa, Articulo")
  EXEC("DELETE ArtSubCosto WHERE SubCuenta = ''")
END
GO

IF (SELECT Version FROM Version)<=1142
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.tgArtCostoBC') and sysstat & 0xf = 8) drop trigger dbo.tgArtCostoBC")
  EXEC("UPDATE ArtCosto SET UltimoCostoSinGastos = UltimoCosto WHERE UltimoCostoSinGastos IS NULL")
END
GO

/****** SysTabla ******/
if not exists (select * from sysobjects where id = object_id('dbo.SysTabla') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.SysTabla (
	SysTabla		varchar(50) 	NOT NULL,
	Descripcion		varchar(100)	NULL,
	Tipo			varchar(20)	NULL,		-- Cuenta, Maestro, Movimiento, N/A
	SincroNivel		varchar(20)	NULL,		-- No, Tabla, Registro
	SincroActivo		bit		NOT NULL	DEFAULT 0,
	SincroOrden		int		NULL,
	TRCL			bit		NOT NULL	DEFAULT 0,
	CampoID			varchar(50)	NULL,
	CampoEmpresa		varchar(50)	NULL,
	UltimoCambio		datetime	NULL,
	SincroID		timestamp	NULL,

	CONSTRAINT priSysTabla PRIMARY KEY CLUSTERED (SysTabla)
  )")
GO

/****** SysVista ******/
if not exists (select * from sysobjects where id = object_id('dbo.SysVista') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.SysVista (
	SysVista		varchar(50) 	NOT NULL,
	Descripcion		varchar(100)	NULL,
	TRCL			bit		NOT NULL	DEFAULT 0,

	CONSTRAINT priSysVista PRIMARY KEY CLUSTERED (SysVista)
  )")
GO



/****** Sincro ******/
if not exists (select * from sysobjects where id = object_id('dbo.Sincro') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.Sincro (
	ID		int  		NOT NULL IDENTITY(1,1),

	Fecha		datetime	NULL	DEFAULT GETDATE(),
	dbtsD		binary(8)	NULL,
	dbtsA		timestamp	NULL,

	CONSTRAINT priSincro PRIMARY KEY CLUSTERED (ID)
  )")
GO

/****** SincroExcepCampos ******/
if not exists (select * from sysobjects where id = object_id('dbo.SincroExcepCampos') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.SincroExcepCampos (
	SysTabla	varchar(50)	NOT NULL,
	Campo		varchar(50)	NOT NULL,

	CONSTRAINT priSincroExcepCampos PRIMARY KEY CLUSTERED (SysTabla, Campo)
  )")
GO

/* Opcion */
IF (SELECT Version FROM Version)<=330 AND exists (select * from sysobjects where id = object_id('dbo.Opcion') and sysstat & 0xf = 3) 
  DROP TABLE dbo.Opcion
GO

/****** Opcion ******/
if not exists (select * from sysobjects where id = object_id('dbo.Opcion') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.Opcion (
	Opcion		char(1) 	NOT NULL,

	Descripcion	varchar(100)	NULL,
	TieneDetalle	bit		NOT NULL DEFAULT 0,

	CONSTRAINT priOpcion PRIMARY KEY CLUSTERED (Opcion)
  )")
GO

/****** OpcionD ******/
if not exists (select * from sysobjects where id = object_id('dbo.OpcionD') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.OpcionD (
	Opcion		char(1) 	NOT NULL,
	Numero		int		NOT NULL,

	Nombre		varchar(100)	NULL,

	CONSTRAINT priOpcionD PRIMARY KEY CLUSTERED (Opcion, Numero)
  )")
GO

/****** OpcionLista ******/
if not exists (select * from sysobjects where id = object_id('dbo.OpcionLista') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.OpcionLista (
	Opcion		char(1) 	NOT NULL,
	Lista		varchar(50)	NOT NULL,

	CONSTRAINT priOpcionLista PRIMARY KEY CLUSTERED (Opcion, Lista)
  )")
GO

/****** OpcionListaD ******/
if not exists (select * from sysobjects where id = object_id('dbo.OpcionListaD') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.OpcionListaD (
	Opcion		char(1) 	NOT NULL,
	Lista		varchar(50)	NOT NULL,
	Numero		int		NOT NULL,

	CONSTRAINT priOpcionListaD PRIMARY KEY CLUSTERED (Opcion, Lista, Numero)
  )")
GO

/****** ArtOpcion  ******/
if not exists (select * from sysobjects where id = object_id('dbo.ArtOpcion') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ArtOpcion (
	Articulo 	char(20)   	NOT NULL,
	Opcion	 	char(1)  	NOT NULL,
	
	Orden		int		NULL,
	ListaEspecifica	varchar(50)	NULL,
	Requerido	bit		NOT NULL	DEFAULT 0,
	ValorOmision	int		NULL,
	Asistente	varchar(20)	NULL,

	CONSTRAINT priArtOpcion PRIMARY KEY CLUSTERED (Articulo, Opcion)
   )")
GO

/****** Plan10 ******/
if not exists (select * from sysobjects where id = object_id('dbo.Plan10') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.Plan10 (
	Periodo		int             NOT NULL,

	CONSTRAINT priPlan10 PRIMARY KEY CLUSTERED (Periodo)
  )")
GO

/****** Documentacion Ramas ******/
if not exists (select * from sysobjects where id = object_id('dbo.DocRama') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.DocRama (
	Rama		char(5)		NOT NULL,
	Documento	varchar(50) 	NOT NULL,

	Orden		int		NULL,

	CONSTRAINT priDocRama PRIMARY KEY CLUSTERED (Rama, Documento)
  )")
GO

/****** Documentacion Cuentas ******/
if not exists (select * from sysobjects where id = object_id('dbo.DocCta') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.DocCta (
	Rama		char(5)		NOT NULL,
	Cuenta		char(20) 	NOT NULL,
	Documento	varchar(50) 	NOT NULL,

	CONSTRAINT priDocCta PRIMARY KEY CLUSTERED (Rama, Cuenta, Documento)
  )")
GO



/****** ProdSerieLote ******/
if not exists (select * from sysobjects where id = object_id('dbo.ProdSerieLote') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ProdSerieLote (
	Empresa			char(5)		NOT NULL,
	ProdSerieLote		varchar(50)	NOT NULL,
	Articulo		char(20)	NOT NULL,
	SubCuenta		char(20)	NOT NULL DEFAULT '',

	CantidadOrdenada 	float		NULL,
	CantidadEntrada		float		NULL,
	CantidadMerma		float		NULL,
	CantidadDesperdicio	float		NULL,

	CONSTRAINT priProdSerieLote PRIMARY KEY  CLUSTERED (Empresa, ProdSerieLote, Articulo, SubCuenta)
  )")
GO

/****** ProdSerieLoteCosto ******/
if not exists (select * from sysobjects where id = object_id('dbo.ProdSerieLoteCosto') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ProdSerieLoteCosto (
	Empresa		char(5)		NOT NULL,
	ProdSerieLote	varchar(50)	NOT NULL,	
	Articulo	char(20)	NOT NULL,
	SubCuenta	char(20)	NOT NULL DEFAULT '',
	ID		int		NOT NULL 	IDENTITY(1,1),

	Modulo		char(5)		NULL,
	ModuloID	int		NULL,

	Cargo		money		NULL,
	Abono		money		NULL,
	Moneda		char(10)	NULL,

	Concepto	varchar(50)	NULL,		-- Material, Mano Obra, Indirectos, Comisiones

	CONSTRAINT priProdSerieLoteCosto PRIMARY KEY  CLUSTERED (Empresa, ProdSerieLote, Articulo, SubCuenta, ID)
  )")
GO

/****** ArtPlanEx ******/
if not exists (select * from sysobjects where id = object_id('dbo.ArtPlanEx') and sysstat & 0xf = 3) 
BEGIN
  EXEC("CREATE TABLE dbo.ArtPlanEx (
	Articulo		char(20)	NOT NULL,
	ID			int		IDENTITY(1,1) NOT NULL,

	SiOpcion		varchar(100)	NULL,
	SiAlmacen		char(10)	NULL,

	TiempoEntrega		int		NULL,
	TiempoEntregaUnidad	varchar(10) 	NULL,
	InvSeguridad		float		NULL,
	LoteOrdenar		varchar(30)	NULL,
	CantidadOrdenar		float		NULL,
	MultiplosOrdenar	float		NULL,

	ProdRuta		char(20)	NULL,
	AlmacenROP		char(10)	NULL,
	Proveedor		char(10)	NULL,

	CONSTRAINT priArtPlanEx PRIMARY KEY CLUSTERED (Articulo, ID)
  )")
--  EXEC("spSincroSemilla NULL, 'ArtPlanEx'")
END
GO


/****** PlanArtLeyenda ******/
if not exists (select * from sysobjects where id = object_id('dbo.PlanArtLeyenda') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.PlanArtLeyenda (
	Empresa		char(5)		NOT NULL,
	Almacen		char(10)	NOT NULL,
	Articulo	char(20)	NOT NULL,
	SubCuenta	varchar(20)	NOT NULL	DEFAULT '',

	Leyenda		varchar(100)	NULL,
	
	CONSTRAINT priPlanArtLeyenda PRIMARY KEY CLUSTERED (Empresa, Articulo, SubCuenta, Almacen)
  )")
GO


/****** PaisEstado ******/
if not exists (select * from sysobjects where id = object_id('dbo.PaisEstado') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.PaisEstado (
	Estado 			varchar(50) 	NOT NULL,
	ImpuestoNomina		float		NULL,
	CONSTRAINT priPaisEstado PRIMARY KEY  CLUSTERED (Estado)
  )")
GO

/****** EmpresaZona ******/
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaZona') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.EmpresaZona (
	Zona	varchar(50) 	NOT NULL,

	CONSTRAINT priEmpresaZona PRIMARY KEY  CLUSTERED (Zona)
  )")
GO

/****** Situaciones Cuentas ******/
if not exists (select * from sysobjects where id = object_id('dbo.CtaSituacion') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.CtaSituacion (
	Rama		char(5)		NOT NULL,
	Situacion	varchar(50)	NOT NULL,

	CONSTRAINT priCtaSituacion PRIMARY KEY  CLUSTERED (Rama, Situacion)
  )")
GO


/****** OpcionPrecio ******/
if not exists (select * from sysobjects where id = object_id('dbo.OpcionPrecio') and sysstat & 0xf = 3) 
BEGIN
  EXEC("CREATE TABLE dbo.OpcionPrecio (
	ID		int  		NOT NULL IDENTITY(1,1),

	Opcion		char(20) 	NULL,
	Articulo	char(20)	NULL,

	Precio		money		NULL,
	Moneda		char(10)	NULL,

	CONSTRAINT priOpcionPrecio PRIMARY KEY CLUSTERED (ID)
  )")
--  EXEC("spSincroSemilla NULL, 'OpcionPrecio'")
END
GO

/****** ArtServicio ******/
if not exists (select * from sysobjects where id = object_id('dbo.ArtServicio') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ArtServicio (
	Articulo 		char(20) 	NOT NULL,
	Servicio		char(20) 	NOT NULL,
	Cantidad		int		NULL,

	CONSTRAINT priArtServicio PRIMARY KEY CLUSTERED (Articulo, Servicio)
  )")
GO


/****** ArtConsumible ******/
if not exists (select * from sysobjects where id = object_id('dbo.ArtConsumible') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ArtConsumible (
	Articulo 		char(20) 	NOT NULL,
	Consumible		char(20) 	NOT NULL,
	Cantidad		int		NULL,

	CONSTRAINT priArtConsumible PRIMARY KEY CLUSTERED (Articulo, Consumible)
  )")
GO

/****** MensajeInstitucion  ******/
if not exists (select * from sysobjects where id = object_id('dbo.MensajeInstitucion') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.MensajeInstitucion (
	Institucion		char(20)	NOT NULL,
	Mensaje			char(10)	NOT NULL,
	Descripcion		varchar(255)	NULL

	CONSTRAINT priMensajeInstitucion PRIMARY KEY  CLUSTERED (Institucion, Mensaje)
  )")
GO


/****** Anuncio ******/
if not exists (select * from sysobjects where id = object_id('dbo.Anuncio') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.Anuncio (
	Anuncio 	varchar(50) 	NOT NULL,
        Archivo 	varchar(100) 	NULL,
        Proveedor 	char(10) 	NULL,
        FechaD 		datetime 	NULL,
        FechaA 		datetime 	NULL
	CONSTRAINT priAnuncio PRIMARY KEY CLUSTERED (Anuncio)
  )")
GO

/****** AnuncioD ******/
if not exists (select * from sysobjects where id = object_id('dbo.AnuncioD') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.AnuncioD (
	Anuncio 	varchar(50)	NOT NULL,
	Horario 	varchar(50)	NOT NULL,

	CONSTRAINT priAnuncioD PRIMARY KEY CLUSTERED (Anuncio, Horario)
  )")
GO

/****** AnuncioArt ******/
if not exists (select * from sysobjects where id = object_id('dbo.AnuncioArt') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.AnuncioArt (
	Anuncio 	varchar(50)	NOT NULL,
	Articulo	char(20)	NOT NULL,

	CONSTRAINT priAnuncioArt PRIMARY KEY CLUSTERED (Anuncio, Articulo)
  )")
GO

/****** AnuncioHorario ******/
if not exists (select * from sysobjects where id = object_id('dbo.AnuncioHorario') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.AnuncioHorario (
	Horario 	varchar(50)	NOT NULL,

	HoraD		char(5)		NOT NULL,  -- 0000
	HoraA		char(5)		NOT NULL,

	CONSTRAINT priAnuncioHorario PRIMARY KEY CLUSTERED (Horario)
  )")
GO

/****** NomXConcepto ******/
if not exists (select * from sysobjects where id = object_id('dbo.NomXConcepto') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.NomXConcepto (
	Concepto	varchar(50)	NOT NULL,

	Tipo		varchar(20)	NULL,		-- Percepcion, Deduccion, Estadistica, Cantidad
	Formula		varchar(255)	NULL,
	Acumula		varchar(255)	NULL,

	Modulo		varchar(20)	NULL,
	ModuloConcepto	varchar(50)	NULL,
	Acreedor	varchar(255)	NULL,
	Vencimiento	varchar(255)	NULL,

	Cuenta		varchar(255)	NULL,
	Beneficiario	varchar(255)	NULL,

	CONSTRAINT priNomXConcepto PRIMARY KEY CLUSTERED (Concepto)
  )")
GO

if (SELECT Version FROM Version)<=1067 AND exists (select * from sysobjects where id = object_id('dbo.NomXPersonal') and sysstat & 0xf = 3) 
  DROP TABLE dbo.NomXPersonal
if (SELECT Version FROM Version)<=1067 AND exists (select * from sysobjects where id = object_id('dbo.NomXCxp') and sysstat & 0xf = 3) 
  DROP TABLE dbo.NomXCxp
if (SELECT Version FROM Version)<=1067 AND exists (select * from sysobjects where id = object_id('dbo.NomXDin') and sysstat & 0xf = 3) 
  DROP TABLE dbo.NomXDin
if (SELECT Version FROM Version)<=1067 AND exists (select * from sysobjects where id = object_id('dbo.NomXFormula') and sysstat & 0xf = 3) 
  DROP TABLE dbo.NomXFormula
GO

/****** NomXPersonal ******/
if not exists (select * from sysobjects where id = object_id('dbo.NomXPersonal') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.NomXPersonal (
	ID			int		NOT NULL,
	Concepto		varchar(50)	NOT NULL,

	Orden			int		NULL,
	Condicion		varchar(255)	NULL,
	Referencia		varchar(255)	NULL,
	Cantidad		varchar(255)	NULL,
	Percepcion		varchar(255)	NULL,
	Deduccion		varchar(255)	NULL,
	Importe			varchar(255)	NULL,
	Acum			varchar(255)	NULL,
	Comentarios		varchar(100)	NULL,

	CONSTRAINT priNomXPersonal PRIMARY KEY CLUSTERED (ID, Concepto)
  )")
GO


/****** NomXCxp ******/
if not exists (select * from sysobjects where id = object_id('dbo.NomXCxp') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.NomXCxp (
	ID			int		NOT NULL,
	Concepto		varchar(50)	NOT NULL,

	Orden			int		NULL,
	Condicion		varchar(255)	NULL,
	Acreedor		varchar(255)	NULL,
	Importe			varchar(255)	NULL,
	Vencimiento		varchar(255)	NULL,
	Comentarios		varchar(100)	NULL,

	CONSTRAINT priNomXCxp PRIMARY KEY CLUSTERED (ID, Concepto)
  )")
GO

/****** NomXDin ******/
if not exists (select * from sysobjects where id = object_id('dbo.NomXDin') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.NomXDin (
	ID			int		NOT NULL,
	Concepto		varchar(50)	NOT NULL,

	Orden			int		NULL,
	Condicion		varchar(255)	NULL,
	Movimiento		varchar(255)	NULL,
	Cuenta			varchar(255)	NULL,
	Beneficiario		varchar(255)	NULL,
	Importe			varchar(255)	NULL,
	Comentarios		varchar(100)	NULL,

	CONSTRAINT priNomXDin PRIMARY KEY CLUSTERED (ID, Concepto)
  )")
GO

/****** NomXFormula ******/
if not exists (select * from sysobjects where id = object_id('dbo.NomXFormula') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.NomXFormula (
	ID			int		NOT NULL,
	Formula			varchar(50)	NOT NULL,

	Orden			int		NULL,
	Expresion		varchar(255)	NULL,
	Comentarios		varchar(100)	NULL,
	Tipo			varchar(20)	NULL,		-- Acumulador / Formula

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priNomXFormula PRIMARY KEY CLUSTERED (ID, Formula)
  )")
GO

/****** Codigos Barras ******/
if (SELECT Version FROM Version)<=1070 AND EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CB') and c.name = 'ID' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename CB, Temporal")
  EXEC("CREATE TABLE dbo.CB (
	Codigo        		char(20)	NOT NULL,

        TipoCuenta		varchar(20)	NULL,    -- Cliente, Articulo, Almacen, Agente, etc..
	Cuenta	 		varchar(20) 	NULL,
	SubCuenta		varchar(20)	NULL,
	Cantidad		float		NULL,
	Unidad			varchar(50)	NULL,
	Reglas			varchar(20)	NULL,

	CONSTRAINT pCB PRIMARY KEY CLUSTERED (Codigo)
  )")
  EXEC("INSERT CB (Codigo, TipoCuenta, Cuenta, SubCuenta, Cantidad, Reglas)
            SELECT Codigo, MAX(TipoCuenta), MAX(Cuenta), MAX(SubCuenta), MAX(Cantidad), MAX(Reglas)
              FROM Temporal
	     GROUP BY Codigo")
  EXEC("DROP TABLE Temporal")
  EXEC("CREATE INDEX Cuenta ON dbo.CB (Cuenta)")
END
go

/****** ExcelCat ******/
if not exists (select * from sysobjects where id = object_id('dbo.ExcelCat') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ExcelCat (
	Categoria	varchar(50)	NOT NULL,
	Posicion	char(5)		NULL,

	CONSTRAINT priExcelCat PRIMARY KEY CLUSTERED (Categoria)
  )")
GO

/****** Excel ******/
if not exists (select * from sysobjects where id = object_id('dbo.Excel') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.Excel (
	Plantilla		varchar(50)	NOT NULL,	-- Orden de compra de Carrefour
	Tipo			varchar(50)	NULL,	

	Categoria		varchar(50)	NULL,		-- bCentral
	RenglonesDetalle	int		NULL,		-- 4
	Direccion		varchar(10)	NULL,  -- Horizontal, Vertical
	StoredProcedure		varchar(50)	NULL,

	Cliente			char(10)	NULL,	-- VTAS/CXC
	EnviarA			int		NULL,	-- VTAS/CXC
	Almacen			char(10)	NULL,

	CONSTRAINT priExcel PRIMARY KEY CLUSTERED (Plantilla)
  )")
GO


/****** ExcelD ******/
if not exists (select * from sysobjects where id = object_id('dbo.ExcelD') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ExcelD (
	Plantilla	varchar(50)	NOT NULL,
	Campo		varchar(50)	NOT NULL,

	Tipo		varchar(20)	NULL,	-- Texto, Numerico, Monetario, Floante, Fecha
	Origen		varchar(20)	NULL,  -- Celda, Guia, Detalle, Matriz
	Posicion	char(5)		NULL,
	ColumnasOmitir	varchar(50)	NULL,

	Orden		int		NULL,
	CONSTRAINT priExcelD PRIMARY KEY CLUSTERED (Plantilla, Campo)
  )")
GO


/****** Configuracion de la Empresa por Modulo Excepciones para la Vaidacion de Fechas ******/
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgValidarFechasEx') and sysstat & 0xf = 3) 
  ExEC("CREATE TABLE dbo.EmpresaCfgValidarFechasEx (
	Empresa 	char(5)  	NOT NULL,
	Modulo		char(5)		NOT NULL,
	Mov		char(20)	NOT NULL,

	CONSTRAINT priEmpresaCfgValidarFechasEx PRIMARY KEY  CLUSTERED (Empresa, Modulo, Mov)
  )")
GO

/****** Lineas de Articulos  ******/
if not exists (select * from sysobjects where id = object_id('dbo.ArtLinea') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.ArtLinea (
	Linea	 		varchar(50) 	NOT NULL ,

	LineaMaestra 		varchar(50) 	NULL,
	Icono			int	  	NULL,

	CONSTRAINT priArtLinea PRIMARY KEY CLUSTERED (Linea)
  )")
GO


/****** NomXPersonalGrupo ******/
if not exists (select * from sysobjects where id = object_id('dbo.NomXPersonalGrupo') and sysstat & 0xf = 3) 
  EXEC("CREATE TABLE dbo.NomXPersonalGrupo (
	ID			int		NOT NULL,
	Concepto		varchar(50)	NOT NULL,
	Personal		char(10)	NOT NULL,

	CONSTRAINT priNomXPersonalGrupo PRIMARY KEY CLUSTERED (ID, Concepto, Personal)
  )")
GO


/****** EmpresaCfgAcceso ******/
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgAcceso') and sysstat & 0xf = 3) 
BEGIN
  EXEC("CREATE TABLE dbo.EmpresaCfgAcceso (
  Empresa 			char(5) 				NOT NULL,

  LogoEmpresa 			varchar(255) 				NULL,
  MostrarMensajes		bit 		DEFAULT 0 		NULL,
  MostrarLeyendaCumpleanos	bit 		DEFAULT 1 		NULL,
  NombreAnexoFotoEmpleado 	varchar(50) 	DEFAULT 'Foto'		NULL,
  LeyendaCumpleanos		varchar(50) 	DEFAULT '¡ Feliz Cumpleaños !'NULL,
  VerCodigo 			bit 		DEFAULT 1 		NULL,
  EstirarFoto 			bit 		DEFAULT 0 		NULL,
  ColorEstatusBaja		Int 		DEFAULT 255		NULL,
  ColorFuenteEstatusBaja	Int 		DEFAULT 65535		NULL,
  ColorEntrada			Int 		DEFAULT 12639424	NULL,
  ColorSalida			Int 		DEFAULT 8454143		NULL,
  ColorAlterno			Int 		DEFAULT 16776960	NULL,
  EtiquetaCodigo 		varchar(50) 	DEFAULT '&Código'	NULL,
  EtiquetaNombre 		varchar(50) 				NULL,
  EtiquetaCampoPrincipal	varchar(50) 				NULL,
  EtiquetaCampoSecundario	varchar(50) 				NULL,
  EtiquetaExtra1 		varchar(50) 				NULL,
  EtiquetaExtra2 		varchar(50) 				NULL,
  EtiquetaExtra3 		varchar(50) 				NULL,
  EtiquetaExtra4 		varchar(50) 				NULL,
  CampoPrincipal		varchar(50) 				NULL,
  CampoSecundario		varchar(50) 				NULL,
  CampoExtra1 			varchar(50) 				NULL,
  CampoExtra2 			varchar(50) 				NULL,
  CampoExtra3 			varchar(50) 				NULL,
  CampoExtra4 			varchar(50) 				NULL,

	CONSTRAINT priEmpresaCfgAcceso PRIMARY KEY CLUSTERED (Empresa)
  )")
  EXEC("INSERT EmpresaCfgAcceso (Empresa) SELECT Empresa FROM Empresa")
END
GO


/****** EmpresaCfgPV ******/
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgPV') and sysstat & 0xf = 3) 
BEGIN
  EXEC("CREATE TABLE dbo.EmpresaCfgPV (
  Empresa 			char(5) 	NOT NULL,

  LogoEmpresa 			varchar(255) 	NULL,
  Cliente 			char(10) 	NULL,
  Almacen 			char(10) 	NULL,
  Agente 			char(10) 	NULL,
  Moneda 			char(10) 	NULL,
  Proyecto 			varchar(50) 	NULL,
  Concepto 			varchar(50) 	NULL,
  MostrarImpuestos 		bit DEFAULT 0 	NULL,
  MostrarAnuncios 		bit DEFAULT 0 	NULL,
  MostrarFotoArticulo 		bit DEFAULT 0 	NULL,
  NombreAnexoFotoArticulo 	varchar(50) 	DEFAULT 'Foto'			NULL,
  VerCodigo 			bit DEFAULT 1 	NULL,
  TiraContinua 			bit DEFAULT 0 	NULL,
  EstirarFoto 			bit DEFAULT 0 	NULL,
  EtiquetaCodigo 		varchar(50) 	DEFAULT '&Código'		NULL,
  EtiquetaDescripcion 		varchar(50) 	NULL,
  EtiquetaPrecio 		varchar(50) 	DEFAULT 'Precio'		NULL,
  EtiquetaDescuento 		varchar(50) 	DEFAULT 'Descuento'		NULL,
  EtiquetaSubTotal 		varchar(50) 	DEFAULT 'Sub Total'		NULL,
  EtiquetaImpuestos 		varchar(50) 	DEFAULT	'Impuestos'		NULL,
  EtiquetaImporteTotal 		varchar(50) 	DEFAULT 'Importe Total'		NULL,
  EtiquetaImporteCobrado 	varchar(50) 	DEFAULT 'Importe Cobrado'	NULL,
  EtiquetaCambio 		varchar(50) 	DEFAULT 'Cambio'		NULL,
  EtiquetaImporte 		varchar(50) 	DEFAULT 'Importe'		NULL,
  EtiquetaFormaPago 		varchar(50) 	DEFAULT 'Forma de Pago'		NULL,
  EtiquetaReferencia 		varchar(50) 	DEFAULT 'Referencia'		NULL,
  EtiquetaExtra1 		varchar(50) 	NULL,
  EtiquetaExtra2 		varchar(50) 	NULL,
  EtiquetaExtra3 		varchar(50) 	NULL,
  EtiquetaExtra4 		varchar(50) 	NULL,
  CampoExtra1 			varchar(50) 	NULL,
  CampoExtra2 			varchar(50) 	NULL,
  CampoExtra3 			varchar(50) 	NULL,
  CampoExtra4 			varchar(50) 	NULL,
  AbrirCajon			bit DEFAULT 0 	NULL,
  CajonPuerto 			char(10) 	NULL,
  CajonCodigo 			varchar(50) 	NULL,

	CONSTRAINT priEmpresaCfgPV PRIMARY KEY CLUSTERED (Empresa)
  )")
  EXEC("INSERT EmpresaCfgPV (Empresa) SELECT Empresa FROM Empresa")
END
GO



/************************** NOTA IDENTITY's ***************************/
/*
 Al crear una nueva tabla con IDENTITY hay que agregar el siguiente comando

 spSincroSemilla NULL, 'TablaNueva'

*/

/**********************************************************************/


/* MANTENIMIENTO   */

/* Nota Si se renombra un campo que no sea Logico1 avisar en un archivo Leame.txt */

/*********************************** CONFIGURACION ***********************************/

/* SysBase */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.SysBase') and c.name = 'Fecha' and o.sysstat & 0xf = 3)
  ALTER TABLE SysBase ADD Fecha	datetime NULL
GO

/* Version */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Version') and c.name = 'ID' and o.sysstat & 0xf = 3)
  ALTER TABLE Version ADD ID int NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Version') and c.name = 'Sucursal' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Version ADD Sucursal int NOT NULL DEFAULT 0")
  EXEC("UPDATE Version SET Sucursal = DEFAULT")
END
GO	

/* Empresa */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Empresa') and c.name = 'UltimaCorrida' and o.sysstat & 0xf = 3)
  ALTER TABLE Empresa ADD UltimaCorrida	datetime NULL
GO
/* Usuario */
ALTER TABLE Usuario DISABLE TRIGGER ALL
GO
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'ModificarSituacion' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Usuario.Logico20', 'ModificarSituacion', 'COLUMN'")
  EXEC("UPDATE Usuario SET ModificarSituacion = 1")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'ModificarAgente' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Usuario.Logico19', 'ModificarAgente', 'COLUMN'")
  EXEC("UPDATE Usuario SET ModificarAgente = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'ModificarUsuario' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Usuario.Logico18', 'ModificarUsuario', 'COLUMN'")
  EXEC("UPDATE Usuario SET ModificarUsuario = 0")
END
IF (SELECT Version FROM Version)<=217  -- Corrige el problema del trigger char(5) en usuario accesso
BEGIN
  EXEC("DELETE UsuarioAcceso WHERE Usuario NOT IN (SELECT Usuario FROM Usuario)")
  EXEC("INSERT UsuarioAcceso (Usuario) SELECT Usuario FROM Usuario WHERE Usuario NOT IN (SELECT Usuario FROM UsuarioAcceso)")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'Reservar' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Usuario.Logico17', 'Reservar', 'COLUMN'")
  EXEC("UPDATE Usuario SET Reservar = 1")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'DesReservar' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Usuario.Logico16', 'DesReservar', 'COLUMN'")
  EXEC("UPDATE Usuario SET DesReservar = 1")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'Asignar' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Usuario.Logico15', 'Asignar', 'COLUMN'")
  EXEC("UPDATE Usuario SET Asignar = 1")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'DesAsignar' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Usuario.Logico14', 'DesAsignar', 'COLUMN'")
  EXEC("UPDATE Usuario SET DesAsignar = 1")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'AgregarArtExpress' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Usuario.Logico13', 'AgregarArtExpress', 'COLUMN'")
  EXEC("UPDATE Usuario SET AgregarArtExpress = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'ModificarAlmacenPedidos' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Usuario.Logico12', 'ModificarAlmacenPedidos', 'COLUMN'")
  EXEC("UPDATE Usuario SET ModificarAlmacenPedidos = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'DefLocalidad' and o.sysstat & 0xf = 3)
  ALTER TABLE Usuario ADD DefLocalidad varchar(50) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'BloquearCxcCtaDinero' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Usuario.Logico11', 'BloquearCxcCtaDinero', 'COLUMN'")
  EXEC("UPDATE Usuario SET BloquearCxcCtaDinero = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'BloquearCxpCtaDinero' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Usuario.Logico10', 'BloquearCxpCtaDinero', 'COLUMN'")
  EXEC("UPDATE Usuario SET BloquearCxpCtaDinero = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'VerComisionesPendientes' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Usuario.Logico9', 'VerComisionesPendientes', 'COLUMN'")
  EXEC("UPDATE Usuario SET VerComisionesPendientes = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'BloquearPrecios' and o.sysstat & 0xf = 3) AND
   not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'BloquearPreciosDesc' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Usuario.Logico8', 'BloquearPreciosDesc', 'COLUMN'")
  EXEC("UPDATE Usuario SET BloquearPreciosDesc = 0")
END
GO
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'BloquearCondiciones' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Usuario.Logico7', 'BloquearCondiciones', 'COLUMN'")
  EXEC("UPDATE Usuario SET BloquearCondiciones = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'BloquearAlmacen' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Usuario.Logico6', 'BloquearAlmacen', 'COLUMN'")
  EXEC("UPDATE Usuario SET BloquearAlmacen = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'BloquearMoneda' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Usuario.Logico5', 'BloquearMoneda', 'COLUMN'")
  EXEC("UPDATE Usuario SET BloquearMoneda = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'BloquearAgente' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Usuario.Logico4', 'BloquearAgente', 'COLUMN'")
  EXEC("UPDATE Usuario SET BloquearAgente = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'BloquearFechaEmision' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Usuario.Logico3', 'BloquearFechaEmision', 'COLUMN'")
  EXEC("UPDATE Usuario SET BloquearFechaEmision = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'BloquearProyecto' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Usuario.Logico2', 'BloquearProyecto', 'COLUMN'")
  EXEC("UPDATE Usuario SET BloquearProyecto = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'Oficina' and o.sysstat & 0xf = 3)
  ALTER TABLE Usuario ADD Oficina varchar(50) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'ModificarConceptos' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Usuario.Logico1', 'ModificarConceptos', 'COLUMN'")
  EXEC("UPDATE Usuario SET ModificarConceptos = 0")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'Configuracion' and o.sysstat & 0xf = 3)
  ALTER TABLE Usuario ADD Configuracion char(10) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'ContrasenaConfirmacion' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Usuario ADD ContrasenaConfirmacion char(10) NULL")
  EXEC("UPDATE Usuario SET ContrasenaConfirmacion = Contrasena")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'ContrasenaConfirmacion' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Usuario ADD ContrasenaConfirmacion char(10) NULL")
  EXEC("UPDATE Usuario SET ContrasenaConfirmacion = Contrasena")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'DefArtTipo' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Usuario ADD DefArtTipo char(20) NULL DEFAULT '(Empresa)'")
  EXEC("UPDATE Usuario SET DefArtTipo = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'DefUnidad' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Usuario ADD DefUnidad varchar(50) NULL DEFAULT '(Empresa)'")
  EXEC("UPDATE Usuario SET DefUnidad = DEFAULT")
END
GO
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'BloquearPrecios' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Usuario.BloquearPreciosDesc', 'BloquearPrecios', 'COLUMN'")
GO

IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'BloquearDescGlobal' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Usuario ADD BloquearDescGlobal bit NULL DEFAULT 0")
  EXEC("UPDATE Usuario SET BloquearDescGlobal = BloquearPrecios")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'BloquearDescLinea' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Usuario ADD BloquearDescLinea bit NULL DEFAULT 0")
  EXEC("UPDATE Usuario SET BloquearDescLinea = BloquearPrecios")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'ModificarFechaRequerida' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Usuario ADD ModificarFechaRequerida	bit NULL DEFAULT 0")
  EXEC("UPDATE Usuario SET ModificarFechaRequerida = DEFAULT")
END
GO
ALTER TABLE Usuario ENABLE TRIGGER ALL
GO

/* UsuarioCfg2 */
ALTER TABLE UsuarioCfg2 DISABLE TRIGGER ALL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.UsuarioCfg2') and c.name = 'ModificarClienteBackOrder' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'UsuarioCfg2.Logico50', 'ModificarClienteBackOrder', 'COLUMN'")
  EXEC("UPDATE UsuarioCfg2 SET ModificarClienteBackOrder = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.UsuarioCfg2') and c.name = 'CancelarLote' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'UsuarioCfg2.Logico49', 'CancelarLote', 'COLUMN'")
  EXEC("UPDATE UsuarioCfg2 SET CancelarLote = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.UsuarioCfg2') and c.name = 'AfectarLote' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'UsuarioCfg2.Logico48', 'AfectarLote', 'COLUMN'")
  EXEC("UPDATE UsuarioCfg2 SET AfectarLote = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.UsuarioCfg2') and c.name = 'BloquearMonedaArtCosto' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'UsuarioCfg2.Logico47', 'BloquearMonedaArtCosto', 'COLUMN'")
  EXEC("UPDATE UsuarioCfg2 SET BloquearMonedaArtCosto = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.UsuarioCfg2') and c.name = 'BloquearMonedaArtPrecio' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'UsuarioCfg2.Logico46', 'BloquearMonedaArtPrecio', 'COLUMN'")
  EXEC("UPDATE UsuarioCfg2 SET BloquearMonedaArtPrecio = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.UsuarioCfg2') and c.name = 'ModificarObservaciones' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'UsuarioCfg2.Logico45', 'ModificarObservaciones', 'COLUMN'")
  EXEC("UPDATE UsuarioCfg2 SET ModificarObservaciones = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.UsuarioCfg2') and c.name = 'ControlAlmacenes' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'UsuarioCfg2.Logico44', 'ControlAlmacenes', 'COLUMN'")
  EXEC("UPDATE UsuarioCfg2 SET ControlAlmacenes = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.UsuarioCfg2') and c.name = 'ModificarAnexosMovConcluidos' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'UsuarioCfg2.Logico43', 'ModificarAnexosMovConcluidos', 'COLUMN'")
  EXEC("UPDATE UsuarioCfg2 SET ModificarAnexosMovConcluidos = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.UsuarioCfg2') and c.name = 'ModificarProdCostosAd' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'UsuarioCfg2.Logico42', 'ModificarProdCostosAd', 'COLUMN'")
  EXEC("UPDATE UsuarioCfg2 SET ModificarProdCostosAd = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.UsuarioCfg2') and c.name = 'AutorizarProdAvances' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'UsuarioCfg2.Logico41', 'AutorizarProdAvances', 'COLUMN'")
  EXEC("UPDATE UsuarioCfg2 SET AutorizarProdAvances = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.UsuarioCfg2') and c.name = 'Digitalizar' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'UsuarioCfg2.Logico40', 'Digitalizar', 'COLUMN'")
  EXEC("UPDATE UsuarioCfg2 SET Digitalizar = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.UsuarioCfg2') and c.name = 'VentaSugerirDisponible' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'UsuarioCfg2.Logico39', 'VentaSugerirDisponible', 'COLUMN'")
  EXEC("UPDATE UsuarioCfg2 SET VentaSugerirDisponible = 0")
END
ALTER TABLE UsuarioCfg2 ENABLE TRIGGER ALL
GO

/* EmpresaCfg */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'VentaConfirmarServicios' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico30', 'VentaConfirmarServicios', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET VentaConfirmarServicios = 1")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'VentaConfirmarContratos' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico29', 'VentaConfirmarContratos', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET VentaConfirmarContratos = 1")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'InvPrestamosGarantias' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico28', 'InvPrestamosGarantias', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET InvPrestamosGarantias = 0")
END
IF (not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CompraSinCosto' and o.sysstat & 0xf = 3)) AND
   (EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'Logico27' and o.sysstat & 0xf = 3))
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico27', 'CompraSinCosto', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET CompraSinCosto = 0")
END
GO
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'VentaContratosImpuesto' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfg ADD VentaContratosImpuesto float NULL DEFAULT 15.0
  EXEC("UPDATE EmpresaCfg SET VentaContratosImpuesto = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'VentaContratosArticulo' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaCfg ADD VentaContratosArticulo char(20) NULL

IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'ContEjercicioInicio' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.ContEjercicioInicio', 'Fecha1', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET Fecha1 = NULL")  
END
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'ContEjercicioFinal' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.ContEjercicioFinal', 'Fecha2', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET Fecha2 = NULL")  
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'Partidas' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico26', 'Partidas', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET Partidas = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CBProcesarLote' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico25', 'CBProcesarLote', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET CBProcesarLote = 0")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'VentaDefCantidad' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaCfg ADD VentaDefCantidad float NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'InvEntradasSinCosto' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'EmpresaCfg.CompraSinCosto', 'InvEntradasSinCosto', 'COLUMN'")

IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CxcProntoPago' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico24', 'CxcProntoPago', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET CxcProntoPago = 0")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CxcProntoPagoConcepto' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaCfg ADD CxcProntoPagoConcepto varchar(50) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CxpProntoPagoConcepto' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaCfg ADD CxpProntoPagoConcepto varchar(50) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'ContTablaINPC' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfg ADD ContTablaINPC varchar(50) NULL DEFAULT 'INPC'
  EXEC("UPDATE EmpresaCfg SET ContTablaINPC = DEFAULT")  
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'SeriesImprimirMov' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico23', 'SeriesImprimirMov', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET SeriesImprimirMov = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'VentaServiciosRequiereTareas' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico22', 'VentaServiciosRequiereTareas', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET VentaServiciosRequiereTareas = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'InvPaquetes' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico21', 'InvPaquetes', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET InvPaquetes = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'VentaPaquetes' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico20', 'VentaPaquetes', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET VentaPaquetes = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'EmbarqueAfectarCobros' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico19', 'EmbarqueAfectarCobros', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET EmbarqueAfectarCobros = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'AFRevaluarDepreciacion' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico18', 'AFRevaluarDepreciacion', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET AFRevaluarDepreciacion = 1")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'AFAfectarDinero' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico17', 'AFAfectarDinero', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET AFAfectarDinero = 1")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'AFMantenimientoPendiente' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico16', 'AFMantenimientoPendiente', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET AFMantenimientoPendiente = 1")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CteFormato' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaCfg ADD CteFormato	char(20) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'ArtFormato' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaCfg ADD ArtFormato	char(20) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CentrosCostosFormato' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaCfg ADD CentrosCostosFormato char(20) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'ContUsoFormato' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaCfg ADD ContUsoFormato char(20) NULL

IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'ContCentrosCostosVerificarPos' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico15', 'ContCentrosCostosVerificarPos', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET ContCentrosCostosVerificarPos = 0")
END
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'AFRevaluarTabla' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'EmpresaCfg.AFRevaluarTabla', 'Texto1', 'COLUMN'")
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'Texto1' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaCfg ADD Texto1 varchar(50) NULL

IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'Logico14' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico14', 'ContUsoInv', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET ContUsoInv = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'ContUsoInv' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'EmpresaCfg.CentrosCostosInv', 'ContUsoInv', 'COLUMN'")

IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'Logico13' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico13', 'ContUsoCompras', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET ContUsoCompras = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'ContUsoCompras' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'EmpresaCfg.CentrosCostosCompras', 'ContUsoCompras', 'COLUMN'")

IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'Logico12' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico12', 'ContUsoGastos', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET ContUsoGastos = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'ContUsoGastos' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'EmpresaCfg.CentrosCostosGastos', 'ContUsoGastos', 'COLUMN'")

IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'ContUsoVentas' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico11', 'ContUsoVentas', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET ContUsoVentas = 0")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'NomOmision' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD NomOmision varchar(50) NULL DEFAULT 'Normal'")
  EXEC("UPDATE EmpresaCfg SET NomOmision = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'NomOmisionPeriodo' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD NomOmisionPeriodo varchar(20) NULL DEFAULT 'Quincenal'")
  EXEC("UPDATE EmpresaCfg SET NomOmisionPeriodo = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'NomBeneficiario' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaCfg ADD NomBeneficiario varchar(50) NULL 
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'VentaServiciosTareaOmision' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaCfg ADD VentaServiciosTareaOmision	varchar(50) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CompraVentaSinIVA' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico10', 'CompraVentaSinIVA', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET CompraVentaSinIVA = 1")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'SeriesImprimirProp' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico9', 'SeriesImprimirProp', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET SeriesImprimirProp = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CxcTopeEfectivoAuto' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfg ADD CxcTopeEfectivoAuto money NULL DEFAULT 50.0
  EXEC("UPDATE EmpresaCfg SET CxcTopeEfectivoAuto = DEFAULT")  
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CxpTopeEfectivoAuto' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfg ADD CxpTopeEfectivoAuto money NULL DEFAULT 50.0
  EXEC("UPDATE EmpresaCfg SET CxpTopeEfectivoAuto = DEFAULT")  
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CxcControlEfectivo' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico8', 'CxcControlEfectivo', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET CxcControlEfectivo = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CxpControlEfectivo' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico7', 'CxpControlEfectivo', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET CxpControlEfectivo = 0")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'AsisteToleraEntrada' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD AsisteToleraEntrada int NULL DEFAULT 5")
  EXEC("UPDATE EmpresaCfg SET AsisteToleraEntrada = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'AsisteToleraSalida' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD AsisteToleraSalida int NULL DEFAULT 1")
  EXEC("UPDATE EmpresaCfg SET AsisteToleraSalida = DEFAULT")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'VentaPreciosImpuestoIncluido' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico6', 'VentaPreciosImpuestoIncluido', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET VentaPreciosImpuestoIncluido = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'RHPlaza' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico5', 'RHPlaza', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET RHPlaza = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'VentaComisionesCobradas' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico4', 'VentaComisionesCobradas', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET VentaComisionesCobradas = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'FacturasPendientes' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico3', 'FacturasPendientes', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET FacturasPendientes = 0")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'InvSugererirCompra' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaCfg ADD InvSugererirCompra	char(20) NULL 
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CompraVerClaveProveedor' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico2', 'CompraVerClaveProveedor', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET CompraVerClaveProveedor = 0")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'VentaLimiteRenFacturas' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaCfg ADD VentaLimiteRenFacturas int	NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'FormaPagoCambio' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaCfg ADD FormaPagoCambio varchar(50) NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CambioTasa' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaCfg ADD CambioTasa float NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'NotasBorrador' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg.Logico1', 'NotasBorrador', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg SET NotasBorrador = 0")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'InvFisicoConteo' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD InvFisicoConteo int NULL DEFAULT 1")
  EXEC("UPDATE EmpresaCfg SET InvFisicoConteo = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'ValidarPrecios' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD ValidarPrecios char(20) NULL DEFAULT 'No'")
  EXEC("UPDATE EmpresaCfg SET ValidarPrecios = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CxcPlazo1' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD CxcPlazo1 int NULL DEFAULT 15")
  EXEC("UPDATE EmpresaCfg SET CxcPlazo1 = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CxcPlazo2' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD CxcPlazo2 int NULL DEFAULT 30")
  EXEC("UPDATE EmpresaCfg SET CxcPlazo2 = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CxcPlazo3' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD CxcPlazo3 int NULL DEFAULT 60")
  EXEC("UPDATE EmpresaCfg SET CxcPlazo3 = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CxcPlazo4' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD CxcPlazo4 int NULL DEFAULT 90")
  EXEC("UPDATE EmpresaCfg SET CxcPlazo4 = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'SugerirCostoDev' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD SugerirCostoDev char(20) NULL DEFAULT 'Promedio'")
  EXEC("UPDATE EmpresaCfg SET SugerirCostoDev = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'GastoAfecta' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD GastoAfecta char(20) NULL DEFAULT 'Dinero'")
  EXEC("UPDATE EmpresaCfg SET GastoAfecta = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'BackOrdersNivel' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD BackOrdersNivel char(20) NULL DEFAULT 'Cliente'")
  EXEC("UPDATE EmpresaCfg SET BackOrdersNivel = CASE WHEN BackOrders = 1 THEN 'Movimiento' ELSE 'Cliente' END")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'AlmacenDestinoEntregaGarantia' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaCfg ADD AlmacenDestinoEntregaGarantia char(10) NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CxpPlazo1' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD CxpPlazo1 int NULL DEFAULT 15")
  EXEC("UPDATE EmpresaCfg SET CxpPlazo1 = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CxpPlazo2' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD CxpPlazo2 int NULL DEFAULT 30")
  EXEC("UPDATE EmpresaCfg SET CxpPlazo2 = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CxpPlazo3' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD CxpPlazo3 int NULL DEFAULT 60")
  EXEC("UPDATE EmpresaCfg SET CxpPlazo3 = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CxpPlazo4' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD CxpPlazo4 int NULL DEFAULT 90")
  EXEC("UPDATE EmpresaCfg SET CxpPlazo4 = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'ToleranciaCosto' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD ToleranciaCosto money NULL DEFAULT 15.0")
  EXEC("UPDATE EmpresaCfg SET ToleranciaCosto = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'ToleranciaTipoCosto' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD ToleranciaTipoCosto char(20) NULL DEFAULT 'Promedio'")
  EXEC("UPDATE EmpresaCfg SET ToleranciaTipoCosto = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CosteoNivelSubCuenta' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD CosteoNivelSubCuenta bit NULL DEFAULT 0")
  EXEC("UPDATE EmpresaCfg SET CosteoNivelSubCuenta = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'PreciosNivelSubCuenta' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD PreciosNivelSubCuenta bit NULL DEFAULT 0")
  EXEC("UPDATE EmpresaCfg SET PreciosNivelSubCuenta = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'VentaListaPrecios' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD VentaListaPrecios char(20) NULL")
  EXEC("UPDATE EmpresaCfg SET VentaListaPrecios = '0'+LTRIM(CONVERT(char, VentaPrecios)) WHERE VentaPrecios NOT IN (NULL, 10)")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'EmbarqueModificarVencimiento' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD EmbarqueModificarVencimiento bit NULL DEFAULT 0")
  EXEC("UPDATE EmpresaCfg SET EmbarqueModificarVencimiento = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CosteoLotes' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD CosteoLotes bit NULL DEFAULT 0")
  EXEC("UPDATE EmpresaCfg SET CosteoLotes = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CosteoSeries' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD CosteoSeries bit NULL DEFAULT 0")
  EXEC("UPDATE EmpresaCfg SET CosteoSeries = DEFAULT")
END
GO
IF (SELECT Version FROM Version)<=312 
  UPDATE EmpresaCfg SET VentaListaPrecios = '0'+VentaListaPrecios WHERE VentaListaPrecios IN ('1','2','3','4','5','6','7','8','9')
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'ArtRevision' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD ArtRevision bit NULL DEFAULT 0")
  EXEC("UPDATE EmpresaCfg SET ArtRevision = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'CancelarOtroMesFactura' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD CancelarOtroMesFactura bit NULL DEFAULT 1")
  EXEC("UPDATE EmpresaCfg SET CancelarOtroMesFactura = 0")
END
GO

/* EmpresaCfg2 */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'CxcAnticiposFacturados' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico50', 'CxcAnticiposFacturados', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET CxcAnticiposFacturados = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'CxcAplicaManualDef' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico49', 'CxcAplicaManualDef', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET CxcAplicaManualDef = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'CxpAplicaManualDef' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico48', 'CxpAplicaManualDef', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET CxpAplicaManualDef = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'VentaDFechaRequerida' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico47', 'VentaDFechaRequerida', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET VentaDFechaRequerida = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'CompraRecibirDemas' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico46', 'CompraRecibirDemas', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET CompraRecibirDemas = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'Gasto2Retenciones' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico45', 'Gasto2Retenciones', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET Gasto2Retenciones = 0")
END
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'CompraMultiUnidades' and o.sysstat & 0xf = 3)
  EXEC sp_rename 'EmpresaCfg2.CompraMultiUnidades', 'Logico51', 'COLUMN'
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'VentaMultiUnidades' and o.sysstat & 0xf = 3)
  EXEC sp_rename 'EmpresaCfg2.VentaMultiUnidades', 'Logico52', 'COLUMN'
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'InvMultiUnidades' and o.sysstat & 0xf = 3)
  EXEC sp_rename 'EmpresaCfg2.InvMultiUnidades', 'MultiUnidades', 'COLUMN'
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'NivelFactorMultiUnidad' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg2 ADD NivelFactorMultiUnidad char(20) NULL DEFAULT 'Unidad'")
  EXEC("UPDATE EmpresaCfg2 SET NivelFactorMultiUnidad = DEFAULT")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'CompraFactorDinamico' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico44', 'CompraFactorDinamico', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET CompraFactorDinamico = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'VentaFactorDinamico' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico43', 'VentaFactorDinamico', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET VentaFactorDinamico = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'InvFactorDinamico' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico42', 'InvFactorDinamico', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET InvFactorDinamico = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'ProdFactorDinamico' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico41', 'ProdFactorDinamico', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET ProdFactorDinamico = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'CxcComisionCreditoDiverso' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico40', 'CxcComisionCreditoDiverso', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET CxcComisionCreditoDiverso = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'VentaDevConsecutivoIndep' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico39', 'VentaDevConsecutivoIndep', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET VentaDevConsecutivoIndep = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'CompraDevConsecutivoIndep' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico38', 'CompraDevConsecutivoIndep', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET CompraDevConsecutivoIndep = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'CompraBonifConsecutivoIndep' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico37', 'CompraBonifConsecutivoIndep', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET CompraBonifConsecutivoIndep = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'FacturasPendientesSerieLote' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico36', 'FacturasPendientesSerieLote', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET FacturasPendientesSerieLote = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'CxcMonedaCont' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico35', 'CxcMonedaCont', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET CxcMonedaCont = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'CxpMonedaCont' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico34', 'CxpMonedaCont', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET CxpMonedaCont = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'AgentMonedaCont' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico33', 'AgentMonedaCont', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET AgentMonedaCont = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'VentaAutoBloqueo' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico32', 'VentaAutoBloqueo', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET VentaAutoBloqueo = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'AutoAsignarBackOrders' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico31', 'AutoAsignarBackOrders', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET AutoAsignarBackOrders = 0")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'ProdAlmacenDef' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaCfg2 ADD ProdAlmacenDef char(10) NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'ProdAlmacenProcesoDef' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaCfg2 ADD ProdAlmacenProcesoDef char(10) NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'ProdTipoOpcionDef' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaCfg2 ADD ProdTipoOpcionDef char(20) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'InvMultiAlmacen' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico30', 'InvMultiAlmacen', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET InvMultiAlmacen = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'VentaMultiAlmacen' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico29', 'VentaMultiAlmacen', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET VentaMultiAlmacen = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'CxcTramites' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico28', 'CxcTramites', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET CxcTramites = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'VIN' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico27', 'VIN', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET VIN = 0")
END
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'ProdAsignarOtros' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'EmpresaCfg2.ProdAsignarOtros', 'Logico25', 'COLUMN'")
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'ProdAsignarDemas' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'EmpresaCfg2.ProdAsignarDemas', 'Logico24', 'COLUMN'")
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'VentaInstrucciones' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'EmpresaCfg2.VentaOpciones', 'VentaInstrucciones', 'COLUMN'")
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'VentaDevSinAntecedente' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico24', 'VentaDevSinAntecedente', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET VentaDevSinAntecedente = 0")
END
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'ProdAutoReservarAplica' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'EmpresaCfg2.ProdAutoReservarAplica', 'Logico53', 'COLUMN'")
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'ProdConsiderarInv' and o.sysstat & 0xf = 3) AND NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'Logico54' and o.sysstat & 0xf = 3) 
  EXEC("sp_rename 'EmpresaCfg2.ProdConsiderarInv', 'Logico54', 'COLUMN'")
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'ProdAutoReservar' and o.sysstat & 0xf = 3) 
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico23', 'ProdAutoReservar', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET ProdAutoReservar = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'GastoCantidades' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico22', 'GastoCantidades', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET GastoCantidades = 0")
END
if EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'ProdExplotarDestino' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'EmpresaCfg2.ProdExplotarDestino', 'ProdDesglosarDestinoCompra', 'COLUMN'")
GO
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'ProdDesglosarDestinoCompra' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico21', 'ProdDesglosarDestinoCompra', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET ProdDesglosarDestinoCompra = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'ProdDesglosarDestinoSolicitud' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico20', 'ProdDesglosarDestinoSolicitud', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET ProdDesglosarDestinoSolicitud = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'ProdDesglosarDestinoProducto' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico19', 'ProdDesglosarDestinoProducto', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET ProdDesglosarDestinoProducto = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'CxcAplicaDif' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico18', 'CxcAplicaDif', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET CxcAplicaDif = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'CxpAplicaDif' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico17', 'CxpAplicaDif', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET CxpAplicaDif = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'ValidarLotesCostoDif' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico16', 'ValidarLotesCostoDif', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET ValidarLotesCostoDif = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'ProdMermaIncluida' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico15', 'ProdMermaIncluida', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET ProdMermaIncluida = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'GastoCopiarImporte' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico14', 'GastoCopiarImporte', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET GastoCopiarImporte = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'GastoSolicitudAnticipoImpuesto' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico13', 'GastoSolicitudAnticipoImpuesto', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET GastoSolicitudAnticipoImpuesto = 0")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'ProdAutoLote' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaCfg2 ADD ProdAutoLote char(20) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'ProdDesglosarGrupoSolicitud' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico12', 'ProdDesglosarGrupoSolicitud', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET ProdDesglosarGrupoSolicitud = 0")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'ProdLoteOrdenar' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaCfg2 ADD ProdLoteOrdenar varchar(30) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'ProdDesperdicioIncluido' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico11', 'ProdDesperdicioIncluido', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET ProdDesperdicioIncluido = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'InvVerPuntoOrden' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico10', 'InvVerPuntoOrden', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET InvVerPuntoOrden = 0")
END
GO


/* EmpresaGral */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'AlmacenGarantias' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaGral ADD AlmacenGarantias char(20) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'DefServicioTipo' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaGral ADD DefServicioTipo varchar(50) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'EjercicioInicio' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaGral ADD EjercicioInicio datetime NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'EjercicioFinal' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaGral ADD EjercicioFinal datetime NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'ArtExpressDef' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaGral ADD ArtExpressDef char(20) NULL	DEFAULT '(CONSECUTIVO)'")
  EXEC("UPDATE EmpresaGral SET ArtExpressDef = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'ArtExpressPrefijo' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaGral ADD ArtExpressPrefijo char(5)	NULL DEFAULT 'A'")
  EXEC("UPDATE EmpresaGral SET ArtExpressPrefijo = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'ArtExpressDigitos' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaGral ADD ArtExpressDigitos int NULL DEFAULT 3")
  EXEC("UPDATE EmpresaGral SET ArtExpressDigitos = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'ArtExpressCategoria' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaGral ADD ArtExpressCategoria varchar(50) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'DefRetencion' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaGral ADD DefRetencion float NULL DEFAULT 10.0")
  EXEC("UPDATE EmpresaGral SET DefRetencion = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'Mensaje1' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaGral ADD Mensaje1 varchar(255) NULL DEFAULT 'Empresa.Nombre'")
  EXEC("UPDATE EmpresaGral SET Mensaje1 = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'Mensaje1Ancho' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaGral ADD Mensaje1Ancho int NULL DEFAULT 230")
  EXEC("UPDATE EmpresaGral SET Mensaje1Ancho = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'Mensaje2' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaGral ADD Mensaje2 varchar(255) NULL DEFAULT 'Usuario.Nombre'")
  EXEC("UPDATE EmpresaGral SET Mensaje2 = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'Mensaje2Ancho' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaGral ADD Mensaje2Ancho int NULL DEFAULT 180")
  EXEC("UPDATE EmpresaGral SET Mensaje2Ancho = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'Mensaje3' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaGral ADD Mensaje3 varchar(255) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'Mensaje3Ancho' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaGral ADD Mensaje3Ancho int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'Mensaje4' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaGral ADD Mensaje4 varchar(255) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'Mensaje4Ancho' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaGral ADD Mensaje4Ancho int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'MensajeAutoRefrescar' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaGral ADD MensajeAutoRefrescar int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'AccesoPaginas' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaGral.Logico9', 'AccesoPaginas', 'COLUMN'")
  EXEC("UPDATE EmpresaGral SET AccesoPaginas = 0")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'FormatoCantidades' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaGral ADD FormatoCantidades varchar(50) NULL DEFAULT '#,.##'")
  EXEC("UPDATE EmpresaGral SET FormatoCantidades = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'DecimalesCantidades' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaGral ADD DecimalesCantidades int NULL DEFAULT 0
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'ContXGenerarDinero' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaGral.Logico8', 'ContXGenerarDinero', 'COLUMN'")
  EXEC("UPDATE EmpresaGral SET ContXGenerarDinero = 0")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'DefCredito' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaGral ADD DefCredito varchar(50) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'FiltrarFechasMovPendientes' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaGral.Logico7', 'FiltrarFechasMovPendientes', 'COLUMN'")
  EXEC("UPDATE EmpresaGral SET FiltrarFechasMovPendientes = 1")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'Prod' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaGral.Logico6', 'Prod', 'COLUMN'")
  EXEC("UPDATE EmpresaGral SET Prod = 0")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'ConsecutivoSerial' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaGral.Logico5', 'ConsecutivoSerial', 'COLUMN'")
  EXEC("UPDATE EmpresaGral SET ConsecutivoSerial = 0")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'ConsecutivoDigitos' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaGral ADD ConsecutivoDigitos int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'ExpresionAlIniciar' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaGral ADD ExpresionAlIniciar varchar(255)	NULL
GO

/* EmpresaCfgMov */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'Gasto' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD Gasto char(20) NULL DEFAULT 'Gasto'
  EXEC("UPDATE EmpresaCfgMov SET Gasto = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'GastoSolicitud' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD GastoSolicitud char(20) NULL DEFAULT 'Solicitud'
  EXEC("UPDATE EmpresaCfgMov SET GastoSolicitud = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'GastoAnticipo' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD GastoAnticipo char(20) NULL DEFAULT 'Anticipo'
  EXEC("UPDATE EmpresaCfgMov SET GastoAnticipo = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'GastoDevolucionAnticipo' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD GastoDevolucionAnticipo char(20) NULL DEFAULT 'Devolucion Anticipo'
  EXEC("UPDATE EmpresaCfgMov SET GastoDevolucionAnticipo = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CxcAjusteEfectivo' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CxcAjusteEfectivo char(20) NULL	DEFAULT 'Ajuste Efectivo'
  EXEC("UPDATE EmpresaCfgMov SET CxcAjusteEfectivo = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'VentaFacturaNota' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD VentaFacturaNota char(20) NULL DEFAULT 'Factura'
  EXEC("UPDATE EmpresaCfgMov SET VentaFacturaNota = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'VentaSalidaGarantia' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD VentaSalidaGarantia char(20) NULL DEFAULT 'Salida Garantia'
  EXEC("UPDATE EmpresaCfgMov SET VentaSalidaGarantia = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CxcNCreditoProntoPago' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CxcNCreditoProntoPago char(20) NULL DEFAULT 'Nota Credito'
  EXEC("UPDATE EmpresaCfgMov SET CxcNCreditoProntoPago = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CxpNCreditoProntoPago' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CxpNCreditoProntoPago char(20) NULL DEFAULT 'Nota Credito'
  EXEC("UPDATE EmpresaCfgMov SET CxpNCreditoProntoPago = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CxcNCargo' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CxcNCargo char(20) NULL DEFAULT 'Nota Cargo'
  EXEC("UPDATE EmpresaCfgMov SET CxcNCargo = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CxcDocumento' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CxcDocumento char(20) NULL DEFAULT 'Documento'
  EXEC("UPDATE EmpresaCfgMov SET CxcDocumento = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CxpNCargo' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CxpNCargo char(20) NULL DEFAULT 'Nota Cargo'
  EXEC("UPDATE EmpresaCfgMov SET CxpNCargo = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CxpDocumento' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CxpDocumento char(20) NULL DEFAULT 'Documento'
  EXEC("UPDATE EmpresaCfgMov SET CxpDocumento = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'ContCierre' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD ContCierre char(20) NULL DEFAULT 'Cierre'
  EXEC("UPDATE EmpresaCfgMov SET ContCierre = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'VentaRemision' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD VentaRemision char(20) NULL DEFAULT 'Remision'
  EXEC("UPDATE EmpresaCfgMov SET VentaRemision = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'VentaDevRemision' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD VentaDevRemision char(20) NULL DEFAULT 'Devolucion Remision'
  EXEC("UPDATE EmpresaCfgMov SET VentaDevRemision = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'EmbarqueLiquidacion' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD EmbarqueLiquidacion char(20) NULL DEFAULT 'Liquidacion'
  EXEC("UPDATE EmpresaCfgMov SET EmbarqueLiquidacion = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'EmbarqueDesembarque' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD EmbarqueDesembarque char(20) NULL DEFAULT 'Desembarque'
  EXEC("UPDATE EmpresaCfgMov SET EmbarqueDesembarque = DEFAULT")  
END        
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CxpNomina' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CxpNomina char(20) NULL DEFAULT 'Pago Nomina'
  EXEC("UPDATE EmpresaCfgMov SET CxpNomina = DEFAULT")  
END        
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'VentaCotizacion' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD VentaCotizacion	char(20) NULL DEFAULT 'Cotizacion'
  EXEC("UPDATE EmpresaCfgMov SET VentaCotizacion = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CxcCargoDiverso' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CxcCargoDiverso	char(20) NULL DEFAULT 'Cargo Diverso'
  EXEC("UPDATE EmpresaCfgMov SET CxcCargoDiverso = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CxcCreditoDiverso' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CxcCreditoDiverso char(20) NULL DEFAULT 'Credito Diverso'
  EXEC("UPDATE EmpresaCfgMov SET CxcCreditoDiverso = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CxpCargoDiverso' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CxpCargoDiverso	char(20) NULL DEFAULT 'Cargo Diverso'
  EXEC("UPDATE EmpresaCfgMov SET CxpCargoDiverso = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CxpCreditoDiverso' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CxpCreditoDiverso char(20) NULL DEFAULT 'Credito Diverso'
  EXEC("UPDATE EmpresaCfgMov SET CxpCreditoDiverso = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'AsisteAsistencia' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD AsisteAsistencia char(20) NULL DEFAULT 'Asistencia'
  EXEC("UPDATE EmpresaCfgMov SET AsisteAsistencia = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'AsisteCorte' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD AsisteCorte char(20) NULL DEFAULT 'Corte'
  EXEC("UPDATE EmpresaCfgMov SET AsisteCorte = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'InvSalidaDiversa' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD InvSalidaDiversa char(20) NULL DEFAULT 'Salida Diversa'
  EXEC("UPDATE EmpresaCfgMov SET InvSalidaDiversa = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'InvPrestamo' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD InvPrestamo char(20) NULL DEFAULT 'Prestamo'
  EXEC("UPDATE EmpresaCfgMov SET InvPrestamo = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'InvTransferencia' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD InvTransferencia char(20) NULL DEFAULT 'Transferencia'
  EXEC("UPDATE EmpresaCfgMov SET InvTransferencia = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'InvTransferenciaConsig' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD InvTransferenciaConsig char(20) NULL DEFAULT 'Transferencia Consig'
  EXEC("UPDATE EmpresaCfgMov SET InvTransferenciaConsig = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CompraIntercambio' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CompraIntercambio char(20) NULL DEFAULT 'Intercambio Garantia'
  EXEC("UPDATE EmpresaCfgMov SET CompraIntercambio = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CompraDevGarantia' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CompraDevGarantia char(20) NULL DEFAULT 'Devolucion Garantia'
  EXEC("UPDATE EmpresaCfgMov SET CompraDevGarantia = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'AgentComision' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD AgentComision char(20) NULL DEFAULT 'Comision'
  EXEC("UPDATE EmpresaCfgMov SET AgentComision = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'AgentDestajo' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD AgentDestajo char(20) NULL DEFAULT 'Destajo'
  EXEC("UPDATE EmpresaCfgMov SET AgentDestajo = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'AgentDevolucion' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD AgentDevolucion	char(20) NULL DEFAULT 'Devolucion'
  EXEC("UPDATE EmpresaCfgMov SET AgentDevolucion = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'AgentPago' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD AgentPago char(20) NULL DEFAULT 'Pago'
  EXEC("UPDATE EmpresaCfgMov SET AgentPago = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'AgentPagoNomina' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD AgentPagoNomina	char(20) NULL DEFAULT 'Pago Nomina'
  EXEC("UPDATE EmpresaCfgMov SET AgentPagoNomina = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CompraEntradaGastos' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CompraEntradaGastos char(20) NULL DEFAULT 'Entrada con Gastos'
  EXEC("UPDATE EmpresaCfgMov SET CompraEntradaGastos = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CxpGastoDiverso' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CxpGastoDiverso	char(20) NULL DEFAULT 'Gasto Diverso'
  EXEC("UPDATE EmpresaCfgMov SET CxpGastoDiverso = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CxcCobroPosfechado' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CxcCobroPosfechado char(20) NULL DEFAULT 'Cobro Posfechado'
  EXEC("UPDATE EmpresaCfgMov SET CxcCobroPosfechado = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CxpPagoPosfechado' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CxpPagoPosfechado char(20) NULL DEFAULT 'Pago Posfechado'
  EXEC("UPDATE EmpresaCfgMov SET CxpPagoPosfechado = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CxcAplicacionCobro' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CxcAplicacionCobro char(20) NULL DEFAULT 'Aplicacion Cobro'
  EXEC("UPDATE EmpresaCfgMov SET CxcAplicacionCobro = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CxpAplicacionPago' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CxpAplicacionPago char(20) NULL DEFAULT 'Aplicacion Pago'
  EXEC("UPDATE EmpresaCfgMov SET CxpAplicacionPago = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'VentaEntregaGarantia' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD VentaEntregaGarantia char(20) NULL DEFAULT 'Entrega Garantia'
  EXEC("UPDATE EmpresaCfgMov SET VentaEntregaGarantia = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CxcDevolucionEfectivo' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CxcDevolucionEfectivo char(20) NULL DEFAULT 'Devolucion Efectivo'
  EXEC("UPDATE EmpresaCfgMov SET CxcDevolucionEfectivo = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CxcDevolucionCredito' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CxcDevolucionCredito char(20) NULL DEFAULT 'Devolucion Credito'
  EXEC("UPDATE EmpresaCfgMov SET CxcDevolucionCredito = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CxpDevolucionEfectivo' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CxpDevolucionEfectivo char(20) NULL DEFAULT 'Devolucion Efectivo'
  EXEC("UPDATE EmpresaCfgMov SET CxpDevolucionEfectivo = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CxpDevolucionCredito' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CxpDevolucionCredito char(20) NULL DEFAULT 'Devolucion Credito'
  EXEC("UPDATE EmpresaCfgMov SET CxpDevolucionCredito = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'VentaDevCxc' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD VentaDevCxc char(20) NULL DEFAULT 'Nota Credito'
  EXEC("UPDATE EmpresaCfgMov SET VentaDevCxc = CxcNCredito")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CompraDevCxp' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CompraDevCxp char(20) NULL DEFAULT 'Nota Credito'
  EXEC("UPDATE EmpresaCfgMov SET CompraDevCxp = CxpNCredito")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CompraBonificacionCxp' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CompraBonificacionCxp char(20) NULL DEFAULT 'Nota Credito'
  EXEC("UPDATE EmpresaCfgMov SET CompraBonificacionCxp = CxpNCredito")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CompraBonificacion' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CompraBonificacion char(20) NULL DEFAULT 'Bonificacion Compra'
  EXEC("UPDATE EmpresaCfgMov SET CompraBonificacion = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'ProdOrdenProduccion' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD ProdOrdenProduccion char(20) NULL DEFAULT 'Orden Produccion'
  EXEC("UPDATE EmpresaCfgMov SET ProdOrdenProduccion = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'ProdProceso' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD ProdProceso char(20) NULL DEFAULT 'Proceso'
  EXEC("UPDATE EmpresaCfgMov SET ProdProceso = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'ProdRequisicion' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD ProdRequisicion char(20) NULL DEFAULT 'Requisicion'
  EXEC("UPDATE EmpresaCfgMov SET ProdRequisicion = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'ProdOrdenTrabajo' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD ProdOrdenTrabajo char(20) NULL DEFAULT 'Orden Trabajo'
  EXEC("UPDATE EmpresaCfgMov SET ProdOrdenTrabajo = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'ProdAsignacion' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD ProdAsignacion char(20) NULL DEFAULT 'Asignacion'
  EXEC("UPDATE EmpresaCfgMov SET ProdAsignacion = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'ProdDevolucion' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD ProdDevolucion char(20) NULL DEFAULT 'Devolucion'
  EXEC("UPDATE EmpresaCfgMov SET ProdDevolucion = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'ProdEntradaProduccion' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD ProdEntradaProduccion char(20) NULL DEFAULT 'Entrada Produccion'
  EXEC("UPDATE EmpresaCfgMov SET ProdEntradaProduccion = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'ProdAvanceProduccion' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD ProdAvanceProduccion char(20) NULL DEFAULT 'Avance Produccion'
  EXEC("UPDATE EmpresaCfgMov SET ProdAvanceProduccion = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'ProdAvance' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD ProdAvance char(20) NULL DEFAULT 'Avance'
  EXEC("UPDATE EmpresaCfgMov SET ProdAvance = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'ProdSolicitud' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD ProdSolicitud char(20) NULL DEFAULT 'Solicitud'
  EXEC("UPDATE EmpresaCfgMov SET ProdSolicitud = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'ProdConsumo' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD ProdConsumo char(20) NULL DEFAULT 'Consumo'
  EXEC("UPDATE EmpresaCfgMov SET ProdConsumo = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'ProdSolicitudMaterial' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD ProdSolicitudMaterial char(20) NULL DEFAULT 'Solicitud Material'
  EXEC("UPDATE EmpresaCfgMov SET ProdSolicitudMaterial = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'ProdSalidaMaterial' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD ProdSalidaMaterial char(20) NULL DEFAULT 'Salida Material'
  EXEC("UPDATE EmpresaCfgMov SET ProdSalidaMaterial = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'ProdDevolucionMaterial' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD ProdDevolucionMaterial char(20) NULL DEFAULT 'Devolucion Material'
  EXEC("UPDATE EmpresaCfgMov SET ProdDevolucionMaterial = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'ProdAsignacionMaterial' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD ProdAsignacionMaterial char(20) NULL DEFAULT 'Asignacion Material.'
  EXEC("UPDATE EmpresaCfgMov SET ProdAsignacionMaterial = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'ProdConsumoMaterial' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD ProdConsumoMaterial char(20)	NULL DEFAULT 'Consumo Material'
  EXEC("UPDATE EmpresaCfgMov SET ProdConsumoMaterial = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'ProdRetroceso' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD ProdRetroceso char(20) NULL DEFAULT 'Retroceso'
  EXEC("UPDATE EmpresaCfgMov SET ProdRetroceso = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'ProdDevProduccion' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD ProdDevProduccion char(20) NULL	DEFAULT 'Dev. Produccion'
  EXEC("UPDATE EmpresaCfgMov SET ProdDevProduccion = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'ProdAvanceCxp' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD ProdAvanceCxp char(20)	NULL DEFAULT 'Entrada Maquila'
  EXEC("UPDATE EmpresaCfgMov SET ProdAvanceCxp = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'ProdRetrocesoCxp' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD ProdRetrocesoCxp char(20) NULL DEFAULT 'Devolucion Maquila'
  EXEC("UPDATE EmpresaCfgMov SET ProdRetrocesoCxp = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'EmbarqueCxp' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD EmbarqueCxp char(20) NULL DEFAULT 'Embarque'
  EXEC("UPDATE EmpresaCfgMov SET EmbarqueCxp = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'ProdPlanMaestro' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD ProdPlanMaestro	char(20) NULL DEFAULT 'Plan Maestro'
  EXEC("UPDATE EmpresaCfgMov SET ProdPlanMaestro = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'ProdRequisicionPlan' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD ProdRequisicionPlan char(20) NULL DEFAULT 'Requisicion Plan'
  EXEC("UPDATE EmpresaCfgMov SET ProdRequisicionPlan = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CompraRequisicionPlan' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CompraRequisicionPlan char(20) NULL DEFAULT 'Requisicion Plan'
  EXEC("UPDATE EmpresaCfgMov SET CompraRequisicionPlan = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'VentaCancelacionFactura' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD VentaCancelacionFactura	char(20) NULL DEFAULT 'Cancelacion Factura'
  EXEC("UPDATE EmpresaCfgMov SET VentaCancelacionFactura = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CxcCancelacionFactura' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CxcCancelacionFactura char(20) NULL DEFAULT 'Cancelacion Factura'
  EXEC("UPDATE EmpresaCfgMov SET CxcCancelacionFactura = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'CxpAjusteEfectivo' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CxpAjusteEfectivo char(20) NULL	 DEFAULT 'Ajuste Efectivo'
  EXEC("UPDATE EmpresaCfgMov SET CxpAjusteEfectivo = DEFAULT")  
END
GO

/* EmpresaCfgModulo */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgModulo') and c.name = 'Tiempos' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgModulo ADD Tiempos char(2) NULL DEFAULT 'No'
  EXEC("UPDATE EmpresaCfgModulo SET Tiempos = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgModulo') and c.name = 'ValidarFechas' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgModulo ADD ValidarFechas char(20) NULL DEFAULT 'No'
  EXEC("UPDATE EmpresaCfgModulo SET ValidarFechas = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgModulo') and c.name = 'PeriodosEspeciales' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE EmpresaCfgModulo ADD PeriodosEspeciales char(2) NULL DEFAULT 'No'
  EXEC("UPDATE EmpresaCfgModulo SET PeriodosEspeciales = DEFAULT")  
END
GO

/* EmpresaCfgMovEsp */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMovEsp') and c.name = 'Accion' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaCfgMovEsp ADD Accion varchar(50) NULL
GO

/*********************************** MAESTROS ***********************************/

/* Mon */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Mon') and c.name = 'TipoCambioDolar' and o.sysstat & 0xf = 3)
  ALTER TABLE Mon ADD TipoCambioDolar float NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Mon') and c.name = 'Tolerancia' and o.sysstat & 0xf = 3)
  ALTER TABLE Mon ADD Tolerancia float NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Mon') and c.name = 'CxcAjusteEfectivo' and o.sysstat & 0xf = 3)
  ALTER TABLE Mon ADD CxcAjusteEfectivo	money NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Mon') and c.name = 'CxpAjusteEfectivo' and o.sysstat & 0xf = 3)
  ALTER TABLE Mon ADD CxpAjusteEfectivo	money NULL
GO

/* Unidad */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Unidad') and c.name = 'Multiplo' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Unidad ADD Multiplo	float NULL DEFAULT 1.0")
  EXEC("UPDATE Unidad SET Multiplo = 1/NULLIF(Factor, 0)")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Unidad') and c.name = 'Decimales' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Unidad ADD Decimales int NULL DEFAULT 0")
  EXEC("UPDATE Unidad SET Decimales = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Unidad') and c.name = 'Orden' and o.sysstat & 0xf = 3)
  ALTER TABLE Unidad ADD Orden int NULL
GO


/* TiposCuentas */
if (SELECT Version FROM Version)<=211 
BEGIN
  EXEC("delete TipoCuenta")
  EXEC("insert into TipoCuenta (ClaveOrden,TipoCuenta) values ('A','Articulos')")
  EXEC("insert into TipoCuenta (ClaveOrden,TipoCuenta) values ('B','Clientes')")
  EXEC("insert into TipoCuenta (ClaveOrden,TipoCuenta) values ('C','Agentes')")
  EXEC("insert into TipoCuenta (ClaveOrden,TipoCuenta) values ('D','Almacenes')")
  EXEC("insert into TipoCuenta (ClaveOrden,TipoCuenta) values ('E','Proveedores')")
  EXEC("insert into TipoCuenta (ClaveOrden,TipoCuenta) values ('F','Cuentas Dinero')")
END
go

/* FormaPago */	
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.FormaPago') and c.name = 'MovAlCobrar' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'FormaPago.MovAlCobrar', 'MovIngresos', 'COLUMN'")
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.FormaPago') and c.name = 'MovAlPagar' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'FormaPago.MovAlPagar', 'MovEgresos', 'COLUMN'")
GO

/* Condicion */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Condicion') and c.name = 'TipoDiasProntoPago' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE Condicion ADD TipoDiasProntoPago char(10) NULL DEFAULT 'Habiles'
  EXEC("UPDATE Condicion SET TipoDiasProntoPago = DEFAULT")  
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Condicion') and c.name = 'DiasHabilesProntoPago' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE Condicion ADD DiasHabilesProntoPago char(10) NULL DEFAULT 'Lun-Vie'
  EXEC("UPDATE Condicion SET DiasHabilesProntoPago = DEFAULT")  
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Condicion') and c.name = 'ProntoPago' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Condicion.GenerarIntereses', 'ProntoPago', 'COLUMN'")
  EXEC("UPDATE Condicion SET ProntoPago = 0")  
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Condicion') and c.name = 'PorMeses' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Condicion.ChecarCredito', 'PorMeses', 'COLUMN'")
  EXEC("UPDATE Condicion SET PorMeses = 0")  
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Condicion') and c.name = 'Meses' and o.sysstat & 0xf = 3)
  ALTER TABLE Condicion ADD Meses int NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Condicion') and c.name = 'Orden' and o.sysstat & 0xf = 3)
  ALTER TABLE Condicion ADD Orden int NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Condicion') and c.name = 'DA' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE Condicion ADD DA bit NULL DEFAULT 0
  EXEC("UPDATE Condicion SET DA = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Condicion') and c.name = 'DANumeroDocumentos' and o.sysstat & 0xf = 3)
  ALTER TABLE Condicion ADD DANumeroDocumentos int NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Condicion') and c.name = 'DAInteres' and o.sysstat & 0xf = 3)
  ALTER TABLE Condicion ADD DAInteres float	NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Condicion') and c.name = 'DAInteresImpuesto' and o.sysstat & 0xf = 3)
  ALTER TABLE Condicion ADD DAInteresImpuesto float NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Condicion') and c.name = 'DAInteresConcepto' and o.sysstat & 0xf = 3)
  ALTER TABLE Condicion ADD DAInteresConcepto varchar(50) NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Condicion') and c.name = 'DAPeriodo' and o.sysstat & 0xf = 3)
  ALTER TABLE Condicion ADD DAPeriodo char(15) NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Condicion') and c.name = 'DAImpPrimerDoc' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE Condicion ADD DAImpPrimerDoc bit NULL DEFAULT 0
  EXEC("UPDATE Condicion SET DAImpPrimerDoc = DEFAULT")
END
GO

GO

/* FormaEnvio */
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.FormaEnvio') and c.name = 'Volumen' and o.sysstat & 0xf = 3)
  ALTER TABLE FormaEnvio ADD Volumen float NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.FormaEnvio') and c.name = 'Peso' and o.sysstat & 0xf = 3)
  ALTER TABLE FormaEnvio ADD Peso float NULL
GO


/* Zona */
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Zona') and c.name = 'Ruta' and o.sysstat & 0xf = 3)
  ALTER TABLE Zona ADD Ruta varchar(50) NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Zona') and c.name = 'Tipo' and o.sysstat & 0xf = 3)
  ALTER TABLE Zona ADD Tipo varchar(50)	NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Zona') and c.name = 'OrdenEmbarque' and o.sysstat & 0xf = 3)
  ALTER TABLE Zona ADD OrdenEmbarque int NULL
GO
	


/*********************************** CUENTAS ***********************************/

/* Prov */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Prov') and c.name = 'Rama' and o.sysstat & 0xf = 3)
  ALTER TABLE Prov ADD Rama char(10) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Prov') and c.name = 'Tipo' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE Prov ADD Tipo char(15) NULL DEFAULT 'Proveedor'
  EXEC("UPDATE Prov SET Tipo = 'Proveedor' WHERE EsAcreedor = 0")
  EXEC("UPDATE Prov SET Tipo = 'Acreedor'  WHERE EsAcreedor = 1")
  EXEC("sp_rename 'Prov.EsAcreedor', 'Logico4', 'COLUMN'")
  EXEC("UPDATE Prov SET Logico4 = 0")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Prov') and c.name = 'CtaDinero' and o.sysstat & 0xf = 3)
  ALTER TABLE Prov ADD CtaDinero char(10) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Prov') and c.name = 'ProntoPago' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Prov.Logico4', 'ProntoPago', 'COLUMN'")
  EXEC("UPDATE Prov SET ProntoPago = 0")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Prov') and c.name = 'DefMoneda' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Prov ADD DefMoneda char(10) NULL")
  EXEC("UPDATE Prov SET DefMoneda = (SELECT MAX(ContMoneda) FROM EmpresaCfg)")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Prov') and c.name = 'EntreCalles' and o.sysstat & 0xf = 3)
  ALTER TABLE Prov ADD EntreCalles varchar(100) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Prov') and c.name = 'Plano' and o.sysstat & 0xf = 3)
  ALTER TABLE Prov ADD Plano varchar(15) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Prov') and c.name = 'Observaciones' and o.sysstat & 0xf = 3)
  ALTER TABLE Prov ADD Observaciones varchar(100) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Prov') and c.name = 'Agente' and o.sysstat & 0xf = 3)
  ALTER TABLE Prov ADD Agente char(10) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Prov') and c.name = 'ProvCuenta' and o.sysstat & 0xf = 3)
  ALTER TABLE Prov ADD ProvCuenta varchar(20) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Prov') and c.name = 'ProvBancoSucursal' and o.sysstat & 0xf = 3)
  ALTER TABLE Prov ADD ProvBancoSucursal varchar(50) NULL
GO

/* Cte */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cte') and c.name = 'Rama' and o.sysstat & 0xf = 3)
  ALTER TABLE Cte ADD Rama char(10) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cte') and c.name = 'Tipo' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE Cte ADD Tipo char(15) NULL DEFAULT 'Cliente'
  EXEC("UPDATE Cte SET Tipo = 'Cliente' WHERE EsDeudor = 0")
  EXEC("UPDATE Cte SET Tipo = 'Deudor'  WHERE EsDeudor = 1")
  EXEC("sp_rename 'Cte.EsDeudor', 'Logico4', 'COLUMN'")
  EXEC("UPDATE Cte SET Logico4 = 0")
END
GO
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cte') and c.name = 'ListaPrecios' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Cte ADD ListaPrecios int NULL DEFAULT 1")
  EXEC("UPDATE Cte SET ListaPrecios = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cte') and c.name = 'DefMoneda' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Cte ADD DefMoneda char(10) NULL")
  EXEC("UPDATE Cte SET DefMoneda = (SELECT MAX(ContMoneda) FROM EmpresaCfg)")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cte') and c.name = 'EntreCalles' and o.sysstat & 0xf = 3)
  ALTER TABLE Cte ADD EntreCalles varchar(100) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cte') and c.name = 'Plano' and o.sysstat & 0xf = 3)
  ALTER TABLE Cte ADD Plano varchar(15) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cte') and c.name = 'Observaciones' and o.sysstat & 0xf = 3)
  ALTER TABLE Cte ADD Observaciones varchar(100) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cte') and c.name = 'AgenteServicio' and o.sysstat & 0xf = 3)
  ALTER TABLE Cte ADD AgenteServicio char(10) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cte') and c.name = 'Numero' and o.sysstat & 0xf = 3)
  ALTER TABLE Cte ADD Numero int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cte') and c.name = 'Registro2' and o.sysstat & 0xf = 3)
  ALTER TABLE Cte ADD Registro2 varchar(30) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cte') and c.name = 'CreditoEspecial' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Cte.Logico4', 'CreditoEspecial', 'COLUMN'")
  EXEC("UPDATE Cte SET CreditoEspecial = 0")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cte') and c.name = 'CreditoConLimite' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Cte.Logico3', 'CreditoConLimite', 'COLUMN'")
  EXEC("UPDATE Cte SET CreditoConLimite = 0")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cte') and c.name = 'CreditoConDias' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Cte.Logico2', 'CreditoConDias', 'COLUMN'")
  EXEC("UPDATE Cte SET CreditoConDias = 0")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cte') and c.name = 'CreditoConCondiciones' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Cte.Logico1', 'CreditoConCondiciones', 'COLUMN'")
  EXEC("UPDATE Cte SET CreditoConCondiciones = 0")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cte') and c.name = 'CreditoLimite' and o.sysstat & 0xf = 3)
  ALTER TABLE Cte ADD CreditoLimite money NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cte') and c.name = 'CreditoMoneda' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Cte ADD CreditoMoneda char(10) NULL")
  EXEC("UPDATE Cte SET CreditoMoneda = DefMoneda")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cte') and c.name = 'CreditoDias' and o.sysstat & 0xf = 3)
  ALTER TABLE Cte ADD CreditoDias int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cte') and c.name = 'CreditoCondiciones' and o.sysstat & 0xf = 3)
  ALTER TABLE Cte ADD CreditoCondiciones varchar(50) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cte') and c.name = 'Contrasena' and o.sysstat & 0xf = 3)
  ALTER TABLE Cte ADD Contrasena char(10) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cte') and c.name = 'ListaPreciosEsp' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Cte ADD ListaPreciosEsp varchar(20) NULL")
  EXEC("UPDATE Cte SET ListaPreciosEsp = CASE ListaPrecios WHEN 1 THEN '(Precio Lista)' ELSE '(Precio '+RTRIM(CONVERT(char, ListaPrecios))+')' END WHERE ISNULL(ListaPrecios, 0) > 0  AND NULLIF(RTRIM(ListaPreciosEsp), '') IS NULL")
END
GO

/* CteEnviarA */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CteEnviarA') and c.name = 'EntreCalles' and o.sysstat & 0xf = 3)
  ALTER TABLE CteEnviarA ADD EntreCalles varchar(100) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CteEnviarA') and c.name = 'Plano' and o.sysstat & 0xf = 3)
  ALTER TABLE CteEnviarA ADD Plano varchar(15) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CteEnviarA') and c.name = 'Observaciones' and o.sysstat & 0xf = 3)
  ALTER TABLE CteEnviarA ADD Observaciones varchar(100) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CteEnviarA') and c.name = 'Agente' and o.sysstat & 0xf = 3)
  ALTER TABLE CteEnviarA ADD Agente char(10) NULL
GO

/* Agente */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Agente') and c.name = 'CostoHora' and o.sysstat & 0xf = 3)
  ALTER TABLE Agente ADD CostoHora money NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Agente') and c.name = 'TipoComision' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Agente ADD TipoComision char(20) NULL")
  EXEC("UPDATE Agente SET TipoComision = '(sin Comision)'")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Agente') and c.name = 'Porcentaje' and o.sysstat & 0xf = 3)
  ALTER TABLE Agente ADD Porcentaje float NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Agente') and c.name = 'Nomina' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Agente.Logico3', 'Nomina', 'COLUMN'")
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Agente') and c.name = 'Personal' and o.sysstat & 0xf = 3)
  ALTER TABLE Agente ADD Personal char(10) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Agente') and c.name = 'NominaMov' and o.sysstat & 0xf = 3)
  ALTER TABLE Agente ADD NominaMov char(20) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Agente') and c.name = 'Direccion' and o.sysstat & 0xf = 3)
  ALTER TABLE Agente ADD Direccion varchar(100) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Agente') and c.name = 'Colonia' and o.sysstat & 0xf = 3)
  ALTER TABLE Agente ADD Colonia varchar(30) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Agente') and c.name = 'Poblacion' and o.sysstat & 0xf = 3)
  ALTER TABLE Agente ADD Poblacion varchar(30) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Agente') and c.name = 'Estado' and o.sysstat & 0xf = 3)
  ALTER TABLE Agente ADD Estado varchar(30) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Agente') and c.name = 'Pais' and o.sysstat & 0xf = 3)
  ALTER TABLE Agente ADD Pais varchar(30) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Agente') and c.name = 'CodigoPostal' and o.sysstat & 0xf = 3)
  ALTER TABLE Agente ADD CodigoPostal varchar(15) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Agente') and c.name = 'RFC' and o.sysstat & 0xf = 3)
  ALTER TABLE Agente ADD RFC varchar(20) NULL
GO

/* Art */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'Rama' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD Rama char(20) NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'Refacciones' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Art.Logico6', 'Refacciones', 'COLUMN'")
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'PrecioAlterno' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Art.PrecioAlterno', 'Monetario1', 'COLUMN'")
  EXEC("UPDATE Art SET Monetario1 = NULL")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'DescuentoCompra' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD DescuentoCompra float NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'CategoriaActivoFijo' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD CategoriaActivoFijo varchar(50) NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'Comision' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD Comision varchar(50) NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'Arancel' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD Arancel varchar(50) NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'ABC' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD ABC char(1) NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'Sustitutos' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Art.Logico5', 'Sustitutos', 'COLUMN'")
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'PrecioMinimo' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD PrecioMinimo money NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'UnidadCompra' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Art ADD UnidadCompra varchar(50) NULL")
  EXEC("UPDATE Art SET UnidadCompra = Unidad")
END
IF (SELECT Version FROM Version)<=237
BEGIN
  EXEC("ALTER TABLE Art DISABLE TRIGGER ALL")
  EXEC("UPDATE Art SET Tipo = 'Matriz' WHERE Tipo = 'Colores/Tallas'")
  EXEC("ALTER TABLE Art ENABLE TRIGGER ALL")
END
GO
IF EXISTS(select * from sysobjects o where o.id = object_id('dbo.ArtCT') AND o.sysstat & 0xf = 3)
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.tgArtBC') and sysstat & 0xf = 8) drop trigger dbo.tgArtBC")
  EXEC("sp_rename 'ArtCT.Color', 'Renglon', 'COLUMN'")
  EXEC("sp_rename 'ArtCT.Talla', 'Columna', 'COLUMN'")
  EXEC("sp_rename 'ArtCT', 'ArtMatriz'")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'Impuesto3' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD Impuesto3	money NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'Precio6' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD Precio6 money NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'Precio7' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD Precio7 money NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'Precio8' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD Precio8 money NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'Precio9' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD Precio9 money NULL
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'Monetario1' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Art.Monetario1', 'Precio10', 'COLUMN'")
  EXEC("UPDATE Art SET Precio10 = NULL")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'Precio10' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD Precio10 money NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'TieneCaducidad' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Art.Logico4', 'TieneCaducidad', 'COLUMN'")
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'Refrigeracion' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Art.Logico3', 'Refrigeracion', 'COLUMN'")
GO
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'SeProduce' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Art.Logico2', 'SeProduce', 'COLUMN'")
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'CategoriaProd' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD CategoriaProd varchar(50) NULL
/*IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'ProdEstacionTipo' and o.sysstat & 0xf = 3)
  EXEC("ALTER TABLE Art DROP COLUMN ProdEstacionTipo")*/
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'ProdCantidad' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Art ADD ProdCantidad float NULL DEFAULT 1.0")
  EXEC("UPDATE Art SET ProdCantidad = DEFAULT")
END
/*IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'ProdUnidad' and o.sysstat & 0xf = 3)
  ALTER TABLE Art DROP COLUMN ProdUnidad */
GO
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'ProdUsuario' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Art ADD ProdUsuario char(10) NULL DEFAULT '(Mismo)'")
  EXEC("UPDATE Art SET ProdUsuario = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'ProdPasoTotal' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Art ADD ProdPasoTotal int NULL DEFAULT 1")
  EXEC("UPDATE Art SET ProdPasoTotal = DEFAULT")
END
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'Logico1' and o.sysstat & 0xf = 3) AND NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'ProdConPasos' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Art.Logico1', 'ProdConPasos', 'COLUMN'")
  EXEC("UPDATE Art SET ProdConPasos = 0")
END
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'ProdConPasos' and o.sysstat & 0xf = 3) AND NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'ProdOpciones' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Art.ProdConPasos', 'ProdOpciones', 'COLUMN'")
GO
/*IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'ProdLinea' and o.sysstat & 0xf = 3)
  EXEC("ALTER TABLE Art DROP COLUMN ProdLinea")*/
GO
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'ProdMov' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Art ADD ProdMov varchar(20) NULL DEFAULT '(por omision)'")
  EXEC("UPDATE Art SET ProdMov = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'ProdMovGrupo' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD ProdMovGrupo varchar(50) NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'ProdEstacion' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD ProdEstacion char(10) NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'wMostrar' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Art ADD wMostrar bit NULL DEFAULT 1")
  EXEC("UPDATE Art SET wMostrar = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'TiempoEntrega' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD TiempoEntrega int	 NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'TiempoEntregaUnidad' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD TiempoEntregaUnidad varchar(10) NULL
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'ProdDesglosarDestino' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Art.ProdDesglosarDestino', 'ProdVerConcentracion', 'COLUMN'")
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'ProdMermaEspecial' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Art.ProdMermaEspecial', 'ProdVerConcentracion', 'COLUMN'")
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'ProdVerPotencias' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Art.ProdVerPotencias', 'ProdVerConcentracion', 'COLUMN'")
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'ProdVerFactores' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Art.ProdVerFactores', 'ProdVerConcentracion', 'COLUMN'")
GO
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'Merma' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD Merma float NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'Usuario' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD Usuario char(10) NULL
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'ProdTamanoLote' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Art.ProdTamanoLote', 'CantidadOrdenar', 'COLUMN'")
GO
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'CantidadOrdenar' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD CantidadOrdenar float NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'ProdRuta' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD ProdRuta char(20)	NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'SeCompra' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Art ADD SeCompra bit NULL DEFAULT 0")
  EXEC("UPDATE Art SET SeCompra = 1")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'SeVende' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Art ADD SeVende bit NULL DEFAULT 0")
  EXEC("UPDATE Art SET SeVende = 1")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'InvSeguridad' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD InvSeguridad float NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'LoteOrdenar' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Art ADD LoteOrdenar varchar(30) NULL")
  EXEC("UPDATE Art SET LoteOrdenar = 'Lote por Lote'")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'MultiplosOrdenar' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD MultiplosOrdenar float NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'Desperdicio' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD Desperdicio float NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'EsFormula' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Art ADD EsFormula bit NULL DEFAULT 0")
  EXEC("UPDATE Art SET EsFormula = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'ProdVerConcentracion' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Art ADD ProdVerConcentracion bit NULL DEFAULT 0")
  EXEC("UPDATE Art SET ProdVerConcentracion = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'ProdVerCostoAcumulado' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Art ADD ProdVerCostoAcumulado bit NULL DEFAULT 0")
  EXEC("UPDATE Art SET ProdVerCostoAcumulado = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'ProdVerMerma' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Art ADD ProdVerMerma bit NULL DEFAULT 0")
  EXEC("UPDATE Art SET ProdVerMerma = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'ProdVerDesperdicio' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Art ADD ProdVerDesperdicio bit NULL DEFAULT 0")
  EXEC("UPDATE Art SET ProdVerDesperdicio = DEFAULT")
END
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'RevisionUltima' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD RevisionUltima datetime NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'RevisionUsuario' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD RevisionUsuario varchar(10) NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'RevisionFrecuencia' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD RevisionFrecuencia int NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'RevisionFrecuenciaUnidad' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD RevisionFrecuenciaUnidad varchar(10) NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'RevisionSiguiente' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD RevisionSiguiente	datetime NULL
GO

-- ArtGrupo
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ArtGrupo') and c.name = 'Descripcion' and o.sysstat & 0xf = 3)
  ALTER TABLE ArtGrupo ADD Descripcion varchar(50) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ArtGrupo') and c.name = 'Descuento' and o.sysstat & 0xf = 3)
  ALTER TABLE ArtGrupo ADD Descuento money NULL
GO

-- ArtComision
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ArtComision') and c.name = 'Importe' and o.sysstat & 0xf = 3)
  ALTER TABLE ArtComision ADD Importe money NULL
GO

-- ArtUnidad
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ArtUnidad') and c.name = 'Peso' and o.sysstat & 0xf = 3)
  ALTER TABLE ArtUnidad ADD Peso float NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ArtUnidad') and c.name = 'Volumen' and o.sysstat & 0xf = 3)
  ALTER TABLE ArtUnidad ADD Volumen float NULL
GO


/* Alm */
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Alm') and c.name = 'Zona' and o.sysstat & 0xf = 3)
  ALTER TABLE Alm ADD Zona varchar(30)	NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Alm') and c.name = 'EntreCalles' and o.sysstat & 0xf = 3)
  ALTER TABLE Alm ADD EntreCalles varchar(100) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Alm') and c.name = 'Plano' and o.sysstat & 0xf = 3)
  ALTER TABLE Alm ADD Plano varchar(15) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Alm') and c.name = 'Observaciones' and o.sysstat & 0xf = 3)
  ALTER TABLE Alm ADD Observaciones varchar(100) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Alm') and c.name = 'Tipo' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Alm ADD Tipo char(15) NULL DEFAULT 'Normal'")
  EXEC("UPDATE Alm SET Tipo = DEFAULT")
END
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Alm') and c.name = 'Garantia' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("UPDATE Alm SET Tipo='Garantias' WHERE Garantia = 1")
  EXEC("sp_rename 'Alm.Garantia', 'Logico3', 'COLUMN'")
  EXEC("UPDATE Alm SET Logico3 = 0")
END
GO
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cta') and c.name = 'CentroCostosRequerido' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Cta.CentroCostosPresupuesto', 'CentroCostosRequerido', 'COLUMN'")
GO
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Alm') and c.name = 'FacturasPendientes' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Alm.Logico3', 'FacturasPendientes', 'COLUMN'") 
  EXEC("IF EXISTS (SELECT * FROM EmpresaCfg WHERE FacturasPendientes = 1) UPDATE Alm SET FacturasPendientes = 1")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Alm') and c.name = 'wMostrar' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Alm ADD wMostrar bit NULL DEFAULT 1")
  EXEC("UPDATE Alm SET wMostrar = DEFAULT")
END
GO


/*************************************** MOVIMIENTOS ***************************************/

/* Ventas */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'SituacionFecha' and o.sysstat & 0xf = 3)
  ALTER TABLE Venta ADD SituacionFecha datetime NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name  = 'ServicioTipo' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Venta.Opcion', 'ServicioTipo', 'COLUMN'")
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'ServicioArticulo' and o.sysstat & 0xf = 3)
  ALTER TABLE Venta ADD ServicioArticulo varchar(20) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'ServicioSerie' and o.sysstat & 0xf = 3)
  ALTER TABLE Venta ADD ServicioSerie varchar(20) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'ServicioContrato' and o.sysstat & 0xf = 3)
  ALTER TABLE Venta ADD ServicioContrato varchar(20) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'ServicioContratoID' and o.sysstat & 0xf = 3)
  ALTER TABLE Venta ADD ServicioContratoID int NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name  = 'ServicioGarantia' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Venta.Logico9', 'ServicioGarantia', 'COLUMN'")
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'ServicioContratoTipo' and o.sysstat & 0xf = 3)
  ALTER TABLE Venta ADD ServicioContratoTipo varchar(50) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'ServicioDescripcion' and o.sysstat & 0xf = 3)
  ALTER TABLE Venta ADD ServicioDescripcion varchar(100) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'ServicioFecha' and o.sysstat & 0xf = 3)
  ALTER TABLE Venta ADD ServicioFecha datetime	NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'Peso' and o.sysstat & 0xf = 3)
  ALTER TABLE Venta ADD Peso float NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'Volumen' and o.sysstat & 0xf = 3)
  ALTER TABLE Venta ADD Volumen	float NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'Paquetes' and o.sysstat & 0xf = 3)
  ALTER TABLE Venta ADD Paquetes int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'PrecioTotal' and o.sysstat & 0xf = 3)
  ALTER TABLE Venta ADD PrecioTotal money NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'CostoTotal' and o.sysstat & 0xf = 3)
  ALTER TABLE Venta ADD CostoTotal money NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'FechaOriginal' and o.sysstat & 0xf = 3)
  ALTER TABLE Venta ADD FechaOriginal datetime NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'Causa' and o.sysstat & 0xf = 3)
  ALTER TABLE Venta ADD Causa varchar(50) NULL
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name  = 'EnCantidadAlterna' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Venta.EnCantidadAlterna', 'Logico8', 'COLUMN'")
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name  = 'UsarFactor' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Venta.UsarFactor', 'Logico8', 'COLUMN'")
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'AnticiposFacturados' and o.sysstat & 0xf = 3)
  ALTER TABLE Venta ADD AnticiposFacturados money NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'Atencion' and o.sysstat & 0xf = 3)
  ALTER TABLE Venta ADD Atencion varchar(50) NULL
IF EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'Retenciones' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Venta.Retenciones', 'Retencion', 'COLUMN'")
GO
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'Retencion' and o.sysstat & 0xf = 3)
  ALTER TABLE Venta ADD Retencion money NULL
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name  = 'Extra' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Venta.Logico8', 'Extra', 'COLUMN'")
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'CancelacionID' and o.sysstat & 0xf = 3)
  ALTER TABLE Venta ADD CancelacionID int NULL
GO

/* VentaD */
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VentaD') and c.name  = 'CantidadAlterna' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'VentaD.CantidadAlterna', 'Flotante1', 'COLUMN'")
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VentaD') and c.name = 'CantidadOrdenada' and o.sysstat & 0xf = 3)
  ALTER TABLE VentaD ADD CantidadOrdenada float	NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VentaD') and c.name = 'Paquete' and o.sysstat & 0xf = 3)
  ALTER TABLE VentaD ADD Paquete int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VentaD') and c.name = 'ContUso' and o.sysstat & 0xf = 3)
  ALTER TABLE VentaD ADD ContUso varchar(20) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VentaD') and c.name = 'Comision' and o.sysstat & 0xf = 3)
  ALTER TABLE VentaD ADD Comision money NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VentaD') and c.name = 'Unidad' and o.sysstat & 0xf = 3)
  ALTER TABLE VentaD ADD Unidad varchar(50) NULL
GO
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VentaD') and c.name = 'Factor' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE VentaD ADD Factor float NULL DEFAULT 1.0")
  EXEC("UPDATE VentaD SET Factor = DEFAULT")
END
GO
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VentaD') and c.name = 'CantidadInventario' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE VentaD ADD CantidadInventario float NULL")
  EXEC("UPDATE VentaD SET CantidadInventario = Cantidad")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VentaD') and c.name = 'SustitutoArticulo' and o.sysstat & 0xf = 3)
  ALTER TABLE VentaD ADD SustitutoArticulo varchar(20) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VentaD') and c.name = 'SustitutoSubCuenta' and o.sysstat & 0xf = 3)
  ALTER TABLE VentaD ADD SustitutoSubCuenta varchar(20) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VentaD') and c.name = 'FechaRequerida' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE VentaD ADD FechaRequerida datetime NULL")
  EXEC("UPDATE VentaD SET FechaRequerida = Venta.FechaRequerida FROM Venta, VentaD WHERE Venta.ID = VentaD.ID")
END
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VentaD') and c.name  = 'Opcion' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'VentaD.Opcion', 'Instruccion', 'COLUMN'")
GO
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VentaD') and c.name = 'Instruccion' and o.sysstat & 0xf = 3)
  ALTER TABLE VentaD ADD Instruccion varchar(50) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VentaD') and c.name = 'Impuesto3' and o.sysstat & 0xf = 3)
  ALTER TABLE VentaD ADD Impuesto3 money NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VentaD') and c.name = 'UltimoReservadoCantidad' and o.sysstat & 0xf = 3)
  ALTER TABLE VentaD ADD UltimoReservadoCantidad float NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VentaD') and c.name = 'UltimoReservadoFecha' and o.sysstat & 0xf = 3)
  ALTER TABLE VentaD ADD UltimoReservadoFecha datetime NULL
GO

/* Compra */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Compra') and c.name = 'SituacionFecha' and o.sysstat & 0xf = 3)
  ALTER TABLE Compra ADD SituacionFecha datetime NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Compra') and c.name = 'Peso' and o.sysstat & 0xf = 3)
  ALTER TABLE Compra ADD Peso float NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Compra') and c.name = 'Volumen' and o.sysstat & 0xf = 3)
  ALTER TABLE Compra ADD Volumen float NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Compra') and c.name = 'Conciliado' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Compra.Logico9', 'Conciliado', 'COLUMN'")
  EXEC("UPDATE Compra SET Conciliado = 0")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Compra') and c.name = 'Agente' and o.sysstat & 0xf = 3)
  ALTER TABLE Compra ADD Agente char(10) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Compra') and c.name = 'Atencion' and o.sysstat & 0xf = 3)
  ALTER TABLE Compra ADD Atencion varchar(50) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Compra') and c.name = 'Causa' and o.sysstat & 0xf = 3)
  ALTER TABLE Compra ADD Causa varchar(50) NULL
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Compra') and c.name  = 'Opcion' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Compra.Opcion', 'Instruccion', 'COLUMN'")
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Compra') and c.name = 'VerDestino' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Compra.Logico8', 'VerDestino', 'COLUMN'")
  EXEC("UPDATE Compra SET VerDestino = 1 FROM Compra c, MovTipo mt WHERE mt.Modulo='COMS' AND mt.Mov = c.Mov AND mt.Clave ='COMS.O' AND c.Directo = 0")
END
IF EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Compra') and c.name = 'EnFirme' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Compra.EnFirme', 'Logico7', 'COLUMN'")
GO

/* CompraD */
IF EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CompraD') and c.name = 'CentroCostos' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'CompraD.CentroCostos', 'ContUso', 'COLUMN'")
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CompraD') and c.name = 'ContUso' and o.sysstat & 0xf = 3)
  ALTER TABLE CompraD ADD ContUso varchar(20) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CompraD') and c.name = 'ReferenciaExtra' and o.sysstat & 0xf = 3)
  ALTER TABLE CompraD ADD ReferenciaExtra varchar(50) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CompraD') and c.name = 'CostoInv' and o.sysstat & 0xf = 3)
  ALTER TABLE CompraD ADD CostoInv money NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CompraD') and c.name = 'Unidad' and o.sysstat & 0xf = 3)
 ALTER TABLE CompraD ADD Unidad varchar(50) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CompraD') and c.name = 'Factor' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE CompraD ADD Factor float NULL DEFAULT 1.0")
  EXEC("UPDATE CompraD SET Factor = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CompraD') and c.name = 'CantidadInventario' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE CompraD ADD CantidadInventario float NULL")
  EXEC("UPDATE CompraD SET CantidadInventario = Cantidad")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CompraD') and c.name = 'Cliente' and o.sysstat & 0xf = 3)
  ALTER TABLE CompraD ADD Cliente varchar(10) NULL
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CompraD') and c.name = 'OrigenTipo' and o.sysstat & 0xf = 3)
  EXEC sp_rename 'CompraD.OrigenTipo', 'DestinoTipo', 'COLUMN'
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CompraD') and c.name = 'Origen' and o.sysstat & 0xf = 3)
  EXEC sp_rename 'CompraD.Origen', 'Destino', 'COLUMN'
IF EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CompraD') and c.name = 'OrigenID' and o.sysstat & 0xf = 3)
  EXEC sp_rename 'CompraD.OrigenID', 'DestinoID', 'COLUMN'
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CompraD') and c.name = 'ServicioArticulo' and o.sysstat & 0xf = 3)
  ALTER TABLE CompraD ADD ServicioArticulo varchar(20) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CompraD') and c.name = 'ServicioSerie' and o.sysstat & 0xf = 3)
  ALTER TABLE CompraD ADD ServicioSerie	varchar(20) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CompraD') and c.name = 'Impuesto3' and o.sysstat & 0xf = 3)
  ALTER TABLE CompraD ADD Impuesto3 money NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CompraD') and c.name = 'FechaOrdenar' and o.sysstat & 0xf = 3)
  ALTER TABLE CompraD ADD FechaOrdenar datetime NULL
GO

/* Inv */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Inv') and c.name = 'SituacionFecha' and o.sysstat & 0xf = 3)
  ALTER TABLE Inv ADD SituacionFecha datetime NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Inv') and c.name = 'FormaEnvio' and o.sysstat & 0xf = 3)
  ALTER TABLE Inv ADD FormaEnvio varchar(50) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Inv') and c.name = 'Peso' and o.sysstat & 0xf = 3)
  ALTER TABLE Inv ADD Peso float NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Inv') and c.name = 'Volumen' and o.sysstat & 0xf = 3)
  ALTER TABLE Inv ADD Volumen float NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Inv') and c.name = 'Paquetes' and o.sysstat & 0xf = 3)
  ALTER TABLE Inv ADD Paquetes int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Inv') and c.name = 'FechaOrigen' and o.sysstat & 0xf = 3)
  ALTER TABLE Inv ADD FechaOrigen datetime NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Inv') and c.name = 'FechaRequerida' and o.sysstat & 0xf = 3)
  ALTER TABLE Inv ADD FechaRequerida datetime NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Inv') and c.name = 'Prioridad' and o.sysstat & 0xf = 3)
  ALTER TABLE Inv ADD Prioridad char(10) NULL
GO

/* InvD */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.InvD') and c.name = 'Paquete' and o.sysstat & 0xf = 3)
  ALTER TABLE InvD ADD Paquete int NULL
IF EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.InvD') and c.name = 'CentroCostos' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'InvD.CentroCostos', 'ContUso', 'COLUMN'")
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.InvD') and c.name = 'ContUso' and o.sysstat & 0xf = 3)
  ALTER TABLE InvD ADD ContUso varchar(20) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.InvD') and c.name = 'Unidad' and o.sysstat & 0xf = 3)
  ALTER TABLE InvD ADD Unidad varchar(50) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.InvD') and c.name = 'Factor' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE InvD ADD Factor float NULL DEFAULT 1.0")
  EXEC("UPDATE InvD SET Factor = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.InvD') and c.name = 'CantidadInventario' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE InvD ADD CantidadInventario float NULL")
  EXEC("UPDATE InvD SET CantidadInventario = Cantidad")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.InvD') and c.name = 'FechaRequerida' and o.sysstat & 0xf = 3)
  ALTER TABLE InvD ADD FechaRequerida datetime NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.InvD') and c.name = 'UltimoReservadoCantidad' and o.sysstat & 0xf = 3)
  ALTER TABLE InvD ADD UltimoReservadoCantidad float NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.InvD') and c.name = 'UltimoReservadoFecha' and o.sysstat & 0xf = 3)
  ALTER TABLE InvD ADD UltimoReservadoFecha datetime NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.InvD') and c.name = 'ProdSerieLote' and o.sysstat & 0xf = 3)
  ALTER TABLE InvD ADD ProdSerieLote varchar(20) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.InvD') and c.name = 'Merma' and o.sysstat & 0xf = 3)
  ALTER TABLE InvD ADD Merma float NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.InvD') and c.name = 'Desperdicio' and o.sysstat & 0xf = 3)
  ALTER TABLE InvD ADD Desperdicio float NULL
GO

/* Cxc */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxc') and c.name = 'SituacionFecha' and o.sysstat & 0xf = 3)
  ALTER TABLE Cxc ADD SituacionFecha datetime NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxc') and c.name = 'FechaProntoPago' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Cxc.FechaExtra1', 'FechaProntoPago', 'COLUMN'")
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxc') and c.name = 'DescuentoProntoPago' and o.sysstat & 0xf = 3)
  ALTER TABLE Cxc ADD DescuentoProntoPago float	NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxc') and c.name = 'Indirecto' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Cxc.Logico9', 'Indirecto', 'COLUMN'")
  EXEC("UPDATE Cxc SET Indirecto = 0")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxc') and c.name = 'ClienteTipoCambio' and o.sysstat & 0xf = 3)
  ALTER TABLE Cxc ADD ClienteTipoCambio float NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxc') and c.name = 'ClienteEnviarA' and o.sysstat & 0xf = 3)
  ALTER TABLE Cxc ADD ClienteEnviarA int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxc') and c.name = 'Dinero' and o.sysstat & 0xf = 3)
  ALTER TABLE Cxc ADD Dinero char(20) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxc') and c.name = 'DineroID' and o.sysstat & 0xf = 3)
  ALTER TABLE Cxc ADD DineroID int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxc') and c.name = 'DineroCtaDinero' and o.sysstat & 0xf = 3)
  ALTER TABLE Cxc ADD DineroCtaDinero char(10) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxc') and c.name = 'GenerarDinero' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Cxc.Logico8', 'GenerarDinero', 'COLUMN'")
  EXEC("UPDATE Cxc SET GenerarDinero = 0")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxc') and c.name = 'VIN' and o.sysstat & 0xf = 3)
  ALTER TABLE Cxc ADD VIN varchar(20) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxc') and c.name = 'ConTramites' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Cxc.Logico7', 'ConTramites', 'COLUMN'")
  EXEC("UPDATE Cxc SET ConTramites = 0")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxc') and c.name = 'Retencion' and o.sysstat & 0xf = 3)
  ALTER TABLE Cxc ADD Retencion money NULL
GO

/* CxcD */
/*IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CxcD') and c.name = 'ProntoPagoID' and o.sysstat & 0xf = 3)
  ALTER TABLE CxcD ADD ProntoPagoID int NULL*/
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CxcD') and c.name = 'Ligado' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'CxcD.Logico3', 'Ligado', 'COLUMN'")
  EXEC("UPDATE CxcD SET Ligado = 0")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CxcD') and c.name = 'Comision' and o.sysstat & 0xf = 3)
  ALTER TABLE CxcD ADD Comision	money NULL
GO

/* Cxp */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxp') and c.name = 'SituacionFecha' and o.sysstat & 0xf = 3)
  ALTER TABLE Cxp ADD SituacionFecha datetime NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxp') and c.name = 'FechaProntoPago' and o.sysstat & 0xf = 3)
  ALTER TABLE Cxp ADD FechaProntoPago datetime NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxp') and c.name = 'DescuentoProntoPago' and o.sysstat & 0xf = 3)
  ALTER TABLE Cxp ADD DescuentoProntoPago float	NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxp') and c.name = 'Indirecto' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Cxp.Logico9', 'Indirecto', 'COLUMN'")
  EXEC("UPDATE Cxp SET Indirecto = 0")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxp') and c.name = 'ProveedorTipoCambio' and o.sysstat & 0xf = 3)
  ALTER TABLE Cxp ADD ProveedorTipoCambio float NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxp') and c.name = 'Beneficiario' and o.sysstat & 0xf = 3)
  ALTER TABLE Cxp ADD Beneficiario int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxp') and c.name = 'Conciliado' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Cxp.Logico8', 'Conciliado', 'COLUMN'")
  EXEC("UPDATE Cxp SET Conciliado = 0")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxp') and c.name = 'Dinero' and o.sysstat & 0xf = 3)
  ALTER TABLE Cxp ADD Dinero char(20) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxp') and c.name = 'DineroID' and o.sysstat & 0xf = 3)
  ALTER TABLE Cxp ADD DineroID int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxp') and c.name = 'DineroCtaDinero' and o.sysstat & 0xf = 3)
  ALTER TABLE Cxp ADD DineroCtaDinero char(10) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxp') and c.name = 'GenerarDinero' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Cxp.Logico7', 'GenerarDinero', 'COLUMN'")
  EXEC("UPDATE Cxp SET GenerarDinero = 0")
END
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxp' AND sysindexes.name = 'VIN' AND sysobjects.id = sysindexes.id)
  DROP INDEX dbo.Cxp.VIN 
GO
/*IF EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxp') and c.name = 'VIN' and o.sysstat & 0xf = 3)
  EXEC("ALTER TABLE Cxp DROP COLUMN VIN")*/
GO

/* CxpD */
/*IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CxpD') and c.name = 'ProntoPagoID' and o.sysstat & 0xf = 3)
  ALTER TABLE CxpD ADD ProntoPagoID int NULL*/
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CxpD') and c.name = 'Ligado' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'CxpD.Logico3', 'Ligado', 'COLUMN'")
  EXEC("UPDATE CxpD SET Ligado = 0")
END
GO
/* Cont */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cont') and c.name = 'SituacionFecha' and o.sysstat & 0xf = 3)
  ALTER TABLE Cont ADD SituacionFecha datetime NULL

/* ContD */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ContD') and c.name = 'Empresa' and o.sysstat & 0xf = 3)
  ALTER TABLE ContD ADD Empresa char(5) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ContD') and c.name = 'Ejercicio' and o.sysstat & 0xf = 3)
  ALTER TABLE ContD ADD Ejercicio int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ContD') and c.name = 'Periodo' and o.sysstat & 0xf = 3)
  ALTER TABLE ContD ADD Periodo int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ContD') and c.name = 'FechaContable' and o.sysstat & 0xf = 3)
  ALTER TABLE ContD ADD FechaContable datetime NULL
IF (SELECT Version FROM Version)<=202
BEGIN
  EXEC("DROP INDEX ContD.Cuenta")
  EXEC("CREATE INDEX Cuenta ON dbo.ContD (Empresa, Cuenta, SubCuenta, Ejercicio, Periodo, FechaContable)")
  EXEC("UPDATE ContD SET ContD.Empresa = Cont.Empresa, ContD.Ejercicio = Cont.Ejercicio, ContD.Periodo = Cont.Periodo, ContD.FechaContable = Cont.FechaContable FROM Cont, ContD WHERE Cont.ID = ContD.ID AND Cont.Estatus <> 'SINAFECTAR'")
END
GO

/* ContX */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ContX') and c.name = 'Condicion' and o.sysstat & 0xf = 3)
  ALTER TABLE ContX ADD Condicion varchar(255)	NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ContX') and c.name = 'Comentarios' and o.sysstat & 0xf = 3)
  ALTER TABLE ContX ADD Comentarios varchar(100) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ContX') and c.name = 'Moneda' and o.sysstat & 0xf = 3)
  ALTER TABLE ContX ADD Moneda varchar(255) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ContX') and c.name = 'TipoCambio' and o.sysstat & 0xf = 3)
  ALTER TABLE ContX ADD TipoCambio varchar(255) NULL
GO

IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ContXD') and c.name = 'UnaVez' and o.sysstat & 0xf = 3)
  ALTER TABLE ContXD ADD UnaVez char(2) NULL
GO

/* ContXCta */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ContXCta') and c.name = 'SubCuenta' and o.sysstat & 0xf = 3)
  ALTER TABLE ContXCta ADD SubCuenta char(20) NULL
GO

/* Dinero */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Dinero') and c.name = 'SituacionFecha' and o.sysstat & 0xf = 3)
  ALTER TABLE Dinero ADD SituacionFecha datetime NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Dinero') and c.name = 'Corte' and o.sysstat & 0xf = 3)
  ALTER TABLE Dinero ADD Corte int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Dinero') and c.name = 'CorteDestino' and o.sysstat & 0xf = 3)
  ALTER TABLE Dinero ADD CorteDestino int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Dinero') and c.name = 'FormaPago' and o.sysstat & 0xf = 3)
  ALTER TABLE Dinero ADD FormaPago varchar(50) NULL
GO

/* Gasto */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Gasto') and c.name = 'SituacionFecha' and o.sysstat & 0xf = 3)
  ALTER TABLE Gasto ADD SituacionFecha datetime NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Gasto') and c.name = 'Multiple' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Gasto.Logico9', 'Multiple', 'COLUMN'")
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Gasto') and c.name = 'CXP' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Gasto.Logico8', 'CXP', 'COLUMN'")
  EXEC("UPDATE Gasto SET CXP = 0")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Gasto') and c.name = 'Dinero' and o.sysstat & 0xf = 3)
  ALTER TABLE Gasto ADD Dinero char(20) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Gasto') and c.name = 'DineroID' and o.sysstat & 0xf = 3)
  ALTER TABLE Gasto ADD DineroID int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Gasto') and c.name = 'DineroCtaDinero' and o.sysstat & 0xf = 3)
  ALTER TABLE Gasto ADD DineroCtaDinero char(10) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Gasto') and c.name = 'GenerarDinero' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'Gasto.Logico7', 'GenerarDinero', 'COLUMN'")
  EXEC("UPDATE Gasto SET GenerarDinero = 0")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Gasto') and c.name = 'FechaRequerida' and o.sysstat & 0xf = 3)
  ALTER TABLE Gasto ADD FechaRequerida datetime	NULL
GO

/* GastoD */
IF EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.GastoD') and c.name = 'CentroCostos' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'GastoD.CentroCostos', 'ContUso', 'COLUMN'")
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.GastoD') and c.name = 'ContUso' and o.sysstat & 0xf = 3)
  ALTER TABLE GastoD ADD ContUso varchar(20) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.GastoD') and c.name = 'Retencion2' and o.sysstat & 0xf = 3)
  ALTER TABLE GastoD ADD Retencion2 money NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.GastoD') and c.name = 'Cantidad' and o.sysstat & 0xf = 3)
  ALTER TABLE GastoD ADD Cantidad float	NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.GastoD') and c.name = 'Precio' and o.sysstat & 0xf = 3)
  ALTER TABLE GastoD ADD Precio	money NULL
GO

/* Precio */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Precio') and c.name = 'NivelContratoTipo' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Precio.Logico5', 'NivelContratoTipo', 'COLUMN'")
GO
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Precio') and c.name = 'ContratoTipo' and o.sysstat & 0xf = 3)
  ALTER TABLE Precio ADD ContratoTipo varchar(50) NULL
GO
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmbarqueD') and c.name = 'Paquetes' and o.sysstat & 0xf = 3)
  ALTER TABLE EmbarqueD ADD Paquetes int NULL
GO
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Precio') and c.name = 'NivelUnidadVenta' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Precio.Logico4', 'NivelUnidadVenta', 'COLUMN'")
GO
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Precio') and c.name = 'UnidadVenta' and o.sysstat & 0xf = 3)
  ALTER TABLE Precio ADD UnidadVenta varchar(50) NULL
GO
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Precio') and c.name = 'NivelArtABC' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Precio.Logico3', 'NivelArtABC', 'COLUMN'")
GO
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Precio') and c.name = 'ArtABC' and o.sysstat & 0xf = 3)
  ALTER TABLE Precio ADD ArtABC char(1) NULL
GO
/*************************************** CONTABILIDAD ***************************************/


/* Auxiliar */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Auxiliar') and c.name = 'ModuloID' and o.sysstat & 0xf = 3)
 ALTER TABLE Auxiliar ADD ModuloID int NULL
IF (SELECT Version FROM Version)<=203 
  UPDATE Auxiliar SET Fecha = convert(datetime, convert(char, Fecha, 101), 101)

/* AuxiliarR */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.AuxiliarR') and c.name = 'ModuloID' and o.sysstat & 0xf = 3)
  ALTER TABLE AuxiliarR ADD ModuloID int NULL
IF (SELECT Version FROM Version)<=203 
  UPDATE AuxiliarR SET Fecha = convert(datetime, convert(char, Fecha, 101), 101)
GO

/* AuxiliarU */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.AuxiliarU') and c.name = 'ModuloID' and o.sysstat & 0xf = 3)
  ALTER TABLE AuxiliarU ADD ModuloID int NULL
IF (SELECT Version FROM Version)<=203 
  UPDATE AuxiliarU SET Fecha = convert(datetime, convert(char, Fecha, 101), 101)
GO

/* AuxiliarRU */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.AuxiliarRU') and c.name = 'ModuloID' and o.sysstat & 0xf = 3)
  ALTER TABLE AuxiliarRU ADD ModuloID int NULL
IF (SELECT Version FROM Version)<=203 
  UPDATE AuxiliarRU SET Fecha = convert(datetime, convert(char, Fecha, 101), 101)
GO

/* MovSituacion */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.MovSituacion') and c.name = 'Icono' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE MovSituacion ADD Icono int NULL DEFAULT 0")
  EXEC("UPDATE MovSituacion SET Icono = 0")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.MovSituacion') and c.name = 'PermiteRetroceder' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'MovSituacion.Logico5', 'PermiteRetroceder', 'COLUMN'")
  EXEC("UPDATE MovSituacion SET PermiteRetroceder = 1")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.MovSituacion') and c.name = 'PermiteBrincar' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'MovSituacion.Logico4', 'PermiteBrincar', 'COLUMN'")
  EXEC("UPDATE MovSituacion SET PermiteBrincar = 1")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.MovSituacion') and c.name = 'ControlUsuarios' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'MovSituacion.Logico3', 'ControlUsuarios', 'COLUMN'")
  EXEC("UPDATE MovSituacion SET ControlUsuarios = 0")
END
GO


/* ServerImpresion */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ServerImpresion') and c.name = 'FormatoASCII' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'ServerImpresion.ReporteDisco', 'FormatoASCII', 'COLUMN'")
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ServerImpresion') and c.name = 'Puerto' and o.sysstat & 0xf = 3)
  ALTER TABLE ServerImpresion ADD Puerto char(10) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ServerImpresion') and c.name = 'MovEstatus' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE ServerImpresion ADD MovEstatus char(15) NULL")
  EXEC("UPDATE ServerImpresion SET MovEstatus = 'CONCLUIDO'")
END
GO

/* SerieLote */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.SerieLote') and c.name = 'UltimaEntrada' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE SerieLote ADD UltimaEntrada datetime NULL")
  EXEC("UPDATE SerieLote SET UltimaEntrada = (SELECT MIN(Mov.FechaEmision) FROM SerieLoteD, Mov WHERE SerieLoteD.Empresa=Mov.Empresa AND SerieLoteD.Modulo=Mov.Modulo AND SerieLoteD.ID=Mov.ID AND SerieLote.Empresa = SerieLoteD.Empresa AND SerieLote.Articulo = SerieLoteD.Articulo AND SerieLote.SubCuenta = SerieLoteD.SubCuenta AND SerieLote.SerieLote = SerieLoteD.SerieLote)")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.SerieLote') and c.name = 'UltimaSalida' and o.sysstat & 0xf = 3)
  ALTER TABLE SerieLote ADD UltimaSalida datetime NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.SerieLote') and c.name = 'ExistenciaActivoFijo' and o.sysstat & 0xf = 3)
  ALTER TABLE SerieLote ADD ExistenciaActivoFijo float NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.SerieLote') and c.name = 'Cliente' and o.sysstat & 0xf = 3)
  ALTER TABLE SerieLote ADD Cliente varchar(10) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.SerieLote') and c.name = 'Localizacion' and o.sysstat & 0xf = 3)
  ALTER TABLE SerieLote ADD Localizacion varchar(10) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.SerieLote') and c.name = 'CostoPromedio' and o.sysstat & 0xf = 3)
  ALTER TABLE SerieLote ADD CostoPromedio money NULL
GO

/* SerieLoteMov */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.SerieLoteMov') and c.name = 'Ubicacion' and o.sysstat & 0xf = 3)
  ALTER TABLE SerieLoteMov ADD Ubicacion int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.SerieLoteMov') and c.name = 'Cliente' and o.sysstat & 0xf = 3)
  ALTER TABLE SerieLoteMov ADD Cliente varchar(10) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.SerieLoteMov') and c.name = 'Localizacion' and o.sysstat & 0xf = 3)
  ALTER TABLE SerieLoteMov ADD Localizacion varchar(10) NULL
GO

/* Concepto */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Concepto') and c.name = 'ConSueldo' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Concepto.Logico3', 'ConSueldo', 'COLUMN'")
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Concepto') and c.name = 'Cuenta' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Concepto ADD Cuenta char(20) NULL")
  EXEC("UPDATE Concepto SET Cuenta = cx.Cuenta FROM Concepto c, ContXCtaConcepto cx WHERE c.Modulo = cx.Modulo AND c.Concepto = cx.Concepto")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Concepto') and c.name = 'Impuestos' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Concepto ADD Impuestos money NULL")
  EXEC("UPDATE Concepto SET Impuestos = 15.0 WHERE Modulo = 'GAS'")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Concepto') and c.name = 'Retencion' and o.sysstat & 0xf = 3)
  ALTER TABLE Concepto ADD Retencion money NULL
GO

/* Modulo */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Modulo') and c.name = 'Nombre' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Modulo ADD Nombre char(50) NULL")
  EXEC("delete Modulo")
  EXEC("insert Modulo (Modulo, Nombre) VALUES ('DIN',  'Dinero')")
  EXEC("insert Modulo (Modulo, Nombre) VALUES ('COMS', 'Compras')")
  EXEC("insert Modulo (Modulo, Nombre) VALUES ('CONT', 'Contabilidad')")
  EXEC("insert Modulo (Modulo, Nombre) VALUES ('CXC',  'Cuentas por Cobrar')")
  EXEC("insert Modulo (Modulo, Nombre) VALUES ('CXP',  'Cuentas por Pagar')")
  EXEC("insert Modulo (Modulo, Nombre) VALUES ('INV',  'Inventarios')")
  EXEC("insert Modulo (Modulo, Nombre) VALUES ('VTAS', 'Ventas')")
  EXEC("insert Modulo (Modulo, Nombre) VALUES ('GAS',  'Gastos')")
  EXEC("insert Modulo (Modulo, Nombre) VALUES ('EMB',  'Embarques')")
  EXEC("insert Modulo (Modulo, Nombre) VALUES ('AF',   'Activos Fijos')")
  EXEC("insert Modulo (Modulo, Nombre) VALUES ('NOM',  'Nomina')")
  EXEC("insert Modulo (Modulo, Nombre) VALUES ('RH',   'Recursos Humanos')")
  EXEC("insert Modulo (Modulo, Nombre) VALUES ('ASIS', 'Asistencias')")
  EXEC("insert Modulo (Modulo, Nombre) VALUES ('CAM',  'Cambios')")
END
GO

/* InvD */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.InvD') and c.name = 'CantidadReservada' and o.sysstat & 0xf = 3)
  ALTER TABLE InvD ADD CantidadReservada float NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.InvD') and c.name = 'CantidadCancelada' and o.sysstat & 0xf = 3)
  ALTER TABLE InvD ADD CantidadCancelada float NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.InvD') and c.name = 'CantidadOrdenada' and o.sysstat & 0xf = 3)
  ALTER TABLE InvD ADD CantidadOrdenada float NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.InvD') and c.name = 'ArticuloDestino' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE InvD ADD ArticuloDestino char(20) NULL")
  EXEC("UPDATE InvD SET ArticuloDestino = Aplica, Aplica = NULL FROM Inv, InvD, MovTipo WHERE Inv.ID = InvD.ID AND Inv.Mov = MovTipo.Mov AND MovTipo.Modulo = 'INV' AND MovTipo.Clave = 'INV.CP'")
END

/* Mon */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Mon') and c.name = 'Nombre' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Mon ADD Nombre varchar(50) NULL")
  EXEC("UPDATE Mon SET Nombre = Moneda")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Mon') and c.name = 'Interbancario' and o.sysstat & 0xf = 3)
  ALTER TABLE Mon ADD Interbancario float NULL
GO
/* Acceso */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Acceso') and c.name = 'EstacionTrabajo' and o.sysstat & 0xf = 3)
  ALTER TABLE Acceso ADD EstacionTrabajo int NULL
GO

/* UsuarioAcceso */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.UsuarioAcceso') and c.name = 'Reportes' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE Usuario DISABLE TRIGGER ALL
  ALTER TABLE UsuarioAcceso ADD Reportes text NULL
  ALTER TABLE Usuario ENABLE TRIGGER ALL
END
GO

/* ArtProv */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ArtProv') and c.name = 'UltimaCompra' and o.sysstat & 0xf = 3)
  ALTER TABLE ArtProv ADD UltimaCompra datetime NULL
GO

/* MovTipo */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.MovTipo') and c.name = 'Factor' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE MovTipo ADD Factor int NULL DEFAULT 1")
  EXEC("UPDATE MovTipo SET Factor = DEFAULT")
END
Go

/* ContID */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Mov') and c.name = 'ContID' and o.sysstat & 0xf = 3)
  ALTER TABLE Mov ADD ContID int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ActivoFijo') and c.name = 'ContID' and o.sysstat & 0xf = 3)
  ALTER TABLE ActivoFijo ADD ContID int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Agent') and c.name = 'ContID' and o.sysstat & 0xf = 3)
  ALTER TABLE Agent ADD ContID int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Asiste') and c.name = 'ContID' and o.sysstat & 0xf = 3)
  ALTER TABLE Asiste ADD ContID int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cambio') and c.name = 'ContID' and o.sysstat & 0xf = 3)
  ALTER TABLE Cambio ADD ContID int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Compra') and c.name = 'ContID' and o.sysstat & 0xf = 3)
  ALTER TABLE Compra ADD ContID int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxc') and c.name = 'ContID' and o.sysstat & 0xf = 3)
  ALTER TABLE Cxc ADD ContID int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxp') and c.name = 'ContID' and o.sysstat & 0xf = 3)
  ALTER TABLE Cxp ADD ContID int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Dinero') and c.name = 'ContID' and o.sysstat & 0xf = 3)
  ALTER TABLE Dinero ADD ContID int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Embarque') and c.name = 'ContID' and o.sysstat & 0xf = 3)
  ALTER TABLE Embarque ADD ContID int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Gasto') and c.name = 'ContID' and o.sysstat & 0xf = 3)
  ALTER TABLE Gasto ADD ContID int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Inv') and c.name = 'ContID' and o.sysstat & 0xf = 3)
  ALTER TABLE Inv ADD ContID int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Nomina') and c.name = 'ContID' and o.sysstat & 0xf = 3)
  ALTER TABLE Nomina ADD ContID int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.RH') and c.name = 'ContID' and o.sysstat & 0xf = 3)
  ALTER TABLE RH ADD ContID int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Soporte') and c.name = 'ContID' and o.sysstat & 0xf = 3)
  ALTER TABLE Soporte ADD ContID int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'ContID' and o.sysstat & 0xf = 3)
  ALTER TABLE Venta ADD ContID int NULL
GO

/* Embarque */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Embarque') and c.name = 'CtaDinero' and o.sysstat & 0xf = 3)
  ALTER TABLE Embarque ADD CtaDinero char(10) NULL
GO

/* Personal */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Personal') and c.name = 'Registro2' and o.sysstat & 0xf = 3)
  ALTER TABLE Personal ADD Registro2 varchar(30) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Personal') and c.name = 'Registro3' and o.sysstat & 0xf = 3)
  ALTER TABLE Personal ADD Registro3 varchar(30) NULL
GO

/* Soporte */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Soporte') and c.name = 'Importe' and o.sysstat & 0xf = 3)
  ALTER TABLE Soporte ADD Importe money	NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Soporte') and c.name = 'CondicionPago' and o.sysstat & 0xf = 3)
  ALTER TABLE Soporte ADD CondicionPago varchar(50) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Soporte') and c.name = 'CondicionEntrega' and o.sysstat & 0xf = 3)
  ALTER TABLE Soporte ADD CondicionEntrega varchar(50) NULL
GO

/* ArtPrecioHist */
IF EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ArtPrecioHist') and c.name = 'Precio' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'ArtPrecioHist.Precio', 'PrecioAnterior', 'COLUMN'")
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ArtPrecioHist') and c.name = 'PrecioActual' and o.sysstat & 0xf = 3)
  ALTER TABLE ArtPrecioHist ADD PrecioActual money NULL
GO


/* CuentaTarea */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CuentaTarea') and c.name = 'Vencimiento' and o.sysstat & 0xf = 3)
  ALTER TABLE CuentaTarea ADD Vencimiento datetime NULL
GO	

/* InvCapa */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.InvCapa') and c.name = 'SubCuenta' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE InvCapa ADD SubCuenta varchar(20) NULL DEFAULT ''")
  EXEC("UPDATE InvCapa SET SubCuenta = DEFAULT")
END
GO	

/* FechaTrabajo */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.FechaTrabajo') and c.name = 'DiasNaturales48Horas' and o.sysstat & 0xf = 3)
  ALTER TABLE FechaTrabajo ADD DiasNaturales48Horas int NULL
GO

/* DocAuto */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.DocAuto') and c.name = 'ImpPrimerDoc' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'DocAuto.Logico3', 'ImpPrimerDoc', 'COLUMN'")
GO


/* Vehiculo */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Vehiculo') and c.name = 'Cxp' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Vehiculo.Logico5', 'Cxp', 'COLUMN'")
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Vehiculo') and c.name = 'Proveedor' and o.sysstat & 0xf = 3)
  ALTER TABLE Vehiculo ADD Proveedor char(10) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Vehiculo') and c.name = 'Condicion' and o.sysstat & 0xf = 3)
  ALTER TABLE Vehiculo ADD Condicion varchar(50) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Vehiculo') and c.name = 'Concepto' and o.sysstat & 0xf = 3)
  ALTER TABLE Vehiculo ADD Concepto varchar(50) NULL
GO

/* Embarque */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Embarque') and c.name = 'Moneda' and o.sysstat & 0xf = 3)
  ALTER TABLE Embarque ADD Moneda char(10) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Embarque') and c.name = 'TipoCambio' and o.sysstat & 0xf = 3)
  ALTER TABLE Embarque ADD TipoCambio float NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Embarque') and c.name = 'Proveedor' and o.sysstat & 0xf = 3)
  ALTER TABLE Embarque ADD Proveedor char(10) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Embarque') and c.name = 'Importe' and o.sysstat & 0xf = 3)
  ALTER TABLE Embarque ADD Importe money NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Embarque') and c.name = 'Impuestos' and o.sysstat & 0xf = 3)
  ALTER TABLE Embarque ADD Impuestos money NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Embarque') and c.name = 'Condicion' and o.sysstat & 0xf = 3)
  ALTER TABLE Embarque ADD Condicion varchar(50) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Embarque') and c.name = 'Vencimiento' and o.sysstat & 0xf = 3)
  ALTER TABLE Embarque ADD Vencimiento datetime NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Embarque') and c.name = 'CxpReferencia' and o.sysstat & 0xf = 3)
  ALTER TABLE Embarque ADD CxpReferencia varchar(50) NULL
GO

/* CompraGastoDiverso */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CompraGastoDiverso') and c.name = 'Referencia' and o.sysstat & 0xf = 3)
  ALTER TABLE CompraGastoDiverso ADD Referencia varchar(50) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CompraGastoDiverso') and c.name = 'Impuestos' and o.sysstat & 0xf = 3)
  ALTER TABLE CompraGastoDiverso ADD Impuestos money NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CompraGastoDiverso') and c.name = 'Multiple' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE CompraGastoDiverso ADD Multiple bit NULL DEFAULT 0")
  EXEC("UPDATE CompraGastoDiverso SET Multiple = 0")
END
GO


/* CxcAplicaDif */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CxcAplicaDif') and c.name = 'Cliente' and o.sysstat & 0xf = 3)
  ALTER TABLE CxcAplicaDif ADD Cliente char(10) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CxcAplicaDif') and c.name = 'ClienteEnviarA' and o.sysstat & 0xf = 3)
  ALTER TABLE CxcAplicaDif ADD ClienteEnviarA int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CxcAplicaDif') and c.name = 'Referencia' and o.sysstat & 0xf = 3)
  ALTER TABLE CxcAplicaDif ADD Referencia varchar(50) NULL
GO

/* CxpAplicaDif */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CxpAplicaDif') and c.name = 'Referencia' and o.sysstat & 0xf = 3)
  ALTER TABLE CxpAplicaDif ADD Referencia varchar(50) NULL
GO

/* Prod */
/*IF EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Prod') and c.name = 'CentroD' and o.sysstat & 0xf = 3)
  ALTER TABLE Prod DROP COLUMN CentroD
IF EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Prod') and c.name = 'CentroA' and o.sysstat & 0xf = 3)
  ALTER TABLE Prod DROP COLUMN CentroA
*/
IF EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Prod') and c.name = 'EnFirme' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Prod.EnFirme', 'Logico9', 'COLUMN'")
GO

/* ProdD */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ProdD') and c.name = 'AutoGenerado' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE ProdD ADD AutoGenerado bit NULL DEFAULT 0")
  EXEC("UPDATE ProdD SET AutoGenerado = DEFAULT")
END
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ProdD') and c.name = 'DescripcionExtra' and o.sysstat & 0xf = 3)
  ALTER TABLE ProdD ADD DescripcionExtra varchar(100) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ProdD') and c.name = 'UltimoReservadoCantidad' and o.sysstat & 0xf = 3)
  ALTER TABLE ProdD ADD UltimoReservadoCantidad float NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ProdD') and c.name = 'UltimoReservadoFecha' and o.sysstat & 0xf = 3)
  ALTER TABLE ProdD ADD UltimoReservadoFecha datetime NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ProdD') and c.name = 'FechaEntrega' and o.sysstat & 0xf = 3)
  ALTER TABLE ProdD ADD FechaEntrega datetime NULL
IF EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ProdD') and c.name = 'OrdenID' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'ProdD.OrdenID', 'OPID', 'COLUMN'")
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ProdD') and c.name = 'Ruta' and o.sysstat & 0xf = 3)
  ALTER TABLE ProdD ADD Ruta varchar(20) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ProdD') and c.name = 'CentroDestino' and o.sysstat & 0xf = 3)
  ALTER TABLE ProdD ADD CentroDestino varchar(10) NULL
GO


/* Centro */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Centro') and c.name = 'Tipo' and o.sysstat & 0xf = 3)
  ALTER TABLE Centro ADD Tipo varchar(20) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Centro') and c.name = 'Almacen' and o.sysstat & 0xf = 3)
  ALTER TABLE Centro ADD Almacen char(10) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Centro') and c.name = 'TiempoCola' and o.sysstat & 0xf = 3)
  ALTER TABLE Centro ADD TiempoCola int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Centro') and c.name = 'TiempoColaUnidad' and o.sysstat & 0xf = 3)
  ALTER TABLE Centro ADD TiempoColaUnidad varchar(10) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Centro') and c.name = 'TiempoEspera' and o.sysstat & 0xf = 3)
  ALTER TABLE Centro ADD TiempoEspera int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Centro') and c.name = 'TiempoEsperaUnidad' and o.sysstat & 0xf = 3)
  ALTER TABLE Centro ADD TiempoEsperaUnidad varchar(10) NULL
GO


/* ArtProv */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ArtProv') and c.name = 'ProveedorOmision' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'ArtProv.Logico3', 'ProveedorOmision', 'COLUMN'")
GO


/* ArtMaterial */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ArtMaterial') and c.name = 'CostoAcumulado' and o.sysstat & 0xf = 3)
  ALTER TABLE ArtMaterial ADD CostoAcumulado money NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ArtMaterial') and c.name = 'Orden' and o.sysstat & 0xf = 3)
  ALTER TABLE ArtMaterial ADD Orden int	NULL
GO


/* ProdRutaD */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ProdRutaD') and c.name = 'TiempoFijo' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'ProdRutaD.TiempoPreparacion', 'TiempoFijo', 'COLUMN'")
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ProdRutaD') and c.name = 'TiempoVariable' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'ProdRutaD.TiempoEjecucion', 'TiempoVariable', 'COLUMN'")
GO


/* ArtCosto */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ArtCosto') and c.name = 'CostoReposicion' and o.sysstat & 0xf = 3)
  ALTER TABLE ArtCosto ADD CostoReposicion money NULL
GO

/* ArtSubCosto */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ArtSubCosto') and c.name = 'CostoReposicion' and o.sysstat & 0xf = 3)
  ALTER TABLE ArtSubCosto ADD CostoReposicion money NULL
GO


/* ArtR */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ArtR') and c.name = 'ProdPendiente' and o.sysstat & 0xf = 3)
  ALTER TABLE ArtR ADD ProdPendiente float NULL
/*IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ArtR') and c.name = 'InvSeguridad' and o.sysstat & 0xf = 3)
  ALTER TABLE ArtR ADD InvSeguridad float NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ArtR') and c.name = 'TiempoEntrega' and o.sysstat & 0xf = 3)
  ALTER TABLE ArtR ADD TiempoEntrega int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ArtR') and c.name = 'TiempoEntregaUnidad' and o.sysstat & 0xf = 3)
  ALTER TABLE ArtR ADD TiempoEntregaUnidad varchar(10) NULL*/
GO


/* Mantenimiento Cambios */

/* Cambio */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cambio') and c.name = 'SituacionFecha' and o.sysstat & 0xf = 3)
  ALTER TABLE Cambio ADD SituacionFecha datetime NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cambio') and c.name = 'Ruta' and o.sysstat & 0xf = 3)
  ALTER TABLE Cambio ADD Ruta varchar(50) NULL

/* CambioD */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CambioD') and c.name = 'GeneroModulo' and o.sysstat & 0xf = 3)
  ALTER TABLE CambioD ADD GeneroModulo char(5) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CambioD') and c.name = 'GeneroMov' and o.sysstat & 0xf = 3)
  ALTER TABLE CambioD ADD GeneroMov char(20) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CambioD') and c.name = 'GeneroMovID' and o.sysstat & 0xf = 3)
  ALTER TABLE CambioD ADD GeneroMovID int NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CambioD') and c.name = 'Observaciones' and o.sysstat & 0xf = 3)
  ALTER TABLE CambioD ADD Observaciones varchar(60) NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CambioD') and c.name = 'Cobertura' and o.sysstat & 0xf = 3)
  ALTER TABLE CambioD ADD Cobertura float NULL
GO

/* Instrumentos */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Instrumento') and c.name = 'FormulaCobertura' and o.sysstat & 0xf = 3)
  ALTER TABLE Instrumento ADD FormulaCobertura text NULL
GO

/* CambioAcum */
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CambioAcum') and c.name = 'OtrosIngresos' and o.sysstat & 0xf = 3)
  ALTER TABLE CambioAcum ADD OtrosIngresos money NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CambioAcum') and c.name = 'OtrosEgresos' and o.sysstat & 0xf = 3)
  ALTER TABLE CambioAcum ADD OtrosEgresos money NULL
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CambioAcum') and c.name = 'InicioMN' and o.sysstat & 0xf = 3)
  ALTER TABLE CambioAcum ADD InicioMN money NULL
GO

IF (SELECT Version FROM Version)<=202
BEGIN
/* Cambio */
  DROP INDEX dbo.Cambio.Mov 
  DROP INDEX dbo.Cambio.MovID 
  DROP INDEX dbo.Cambio.Consecuitvo 
  DROP INDEX dbo.Cambio.Usuario
  DROP INDEX dbo.Cambio.Situacion
  DROP INDEX dbo.Cambio.Cliente

  CREATE INDEX Consecutivo  ON dbo.Cambio (Empresa, MovID, Mov)
  CREATE INDEX FechaEmision ON dbo.Cambio (Empresa, FechaEmision)
  CREATE INDEX Usuario      ON dbo.Cambio (Empresa, Usuario)
  CREATE INDEX Situacion    ON dbo.Cambio (Empresa, Estatus, Situacion)
  CREATE INDEX Cliente 	    ON dbo.Cambio (Empresa, Cliente)
END
GO


/****** InstitucionFin  ******/
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.InstitucionFin') and c.name = 'Logico1' and o.sysstat & 0xf = 3) AND (SELECT Version FROM Version)<=221
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename InstitucionFin, Temporal")
  EXEC("CREATE TABLE dbo.InstitucionFin (
	Institucion		char(20) 	NOT NULL,
	Nombre			varchar(50)	NULL,
	Ciudad			varchar(40)	NULL,
	Estado			varchar(40)	NULL,
	Pais			char(3)		NULL,
	Aba			char(10)	NULL,
	Swift			char(15)	NULL,
	Chips			char(15)	NULL,
	Bofa			char(15)	NULL,
	Banxico			int		NULL,
	SwitchAbaOnline		bit		NOT NULL DEFAULT 0,
	SwitchActivo		bit		NOT NULL DEFAULT 0,
	Estatus			char(15)	NULL,
	UltimoCambio		datetime	NULL,

	Logico1			bit	     	NOT NULL DEFAULT 0,
	Logico2			bit	     	NOT NULL DEFAULT 0,
	Logico3			bit	     	NOT NULL DEFAULT 0,

	CONSTRAINT pInstitucionFin PRIMARY KEY  CLUSTERED (Institucion)
  )")
  EXEC("CREATE INDEX Nombre ON dbo.InstitucionFin (Nombre)")
  EXEC("CREATE INDEX Pais ON dbo.InstitucionFin (Pais)")
  EXEC("CREATE INDEX Estado ON dbo.InstitucionFin (Pais, Estado)")
  EXEC("CREATE INDEX Cuidad ON dbo.InstitucionFin (Pais, Estado, Ciudad)")

  EXEC("INSERT InstitucionFin (Institucion, Nombre, Ciudad, Estado, Pais, Aba, Swift, Chips, Bofa, Banxico,
	                       SwitchAbaOnline, SwitchActivo, Estatus, UltimoCambio)
                        SELECT Institucion, Nombre, Ciudad, Estado, Pais, Aba, Swift, Chips, Bofa, Banxico,
	                       SwitchAbaOnline, SwitchActivo, Estatus, UltimoCambio
                          FROM Temporal")
  EXEC("DROP TABLE Temporal")
END
go

/****** Beneficiario ******/
IF NOT EXISTS (select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Beneficiario') and c.name = 'InfoAd5' and o.sysstat & 0xf = 3) AND (SELECT Version FROM Version)<=221
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename Beneficiario, Temporal")
  EXEC("CREATE TABLE dbo.Beneficiario (
	Beneficiario		int 	    	NOT NULL IDENTITY(1,1),

	Cliente			char(10) 	NULL,
	Instrumento		char(10)	NULL,
	Nombre			varchar(100)	NULL,
	Info1			varchar(50)	NULL,
	Info2            	varchar(50)	NULL,
	Info3             	varchar(50)	NULL,
	Info4            	varchar(50)	NULL,
	InfoAd1			varchar(50)	NULL,
	InfoAd2			varchar(50)	NULL,
	InfoAd3			varchar(50)	NULL,
	InfoAd4			varchar(50)	NULL,
	InfoAd5			varchar(50)	NULL,
	InfoAd6			varchar(50)	NULL,
	InfoAd7			varchar(50)	NULL,
	InfoAd8			varchar(50)	NULL,
	Institucion		char(20)	NULL,
	InstitucionUsar		char(10)	NULL,
	Intermediario		char(20)	NULL,
	IntermediarioUsar	char(10)	NULL,
	Estatus			char(15)	NULL,

	CONSTRAINT pBeneficiarioenef PRIMARY KEY  CLUSTERED (Beneficiario)
       )")
  EXEC("CREATE INDEX Nombre ON dbo.Beneficiario (Nombre)")
  EXEC("CREATE INDEX Cliente ON dbo.Beneficiario (Cliente)")
  EXEC("CREATE INDEX Instrumento ON dbo.Beneficiario (Instrumento)")
  SET IDENTITY_INSERT Beneficiario ON
  EXEC("INSERT Beneficiario (Beneficiario, Cliente, Instrumento, Nombre, Info1, Info2, Info3, Info4, 
                             InfoAd1, InfoAd2, InfoAd3, InfoAd4, Institucion, InstitucionUsar, Intermediario, IntermediarioUsar, Estatus)
                      SELECT Beneficiario, Cliente, Instrumento, Nombre, Info1, Info2, Info3, Info4, 
                             InfoAd1, InfoAd2, InfoAd3, InfoAd4, Institucion, InstitucionUsar, Intermediario, IntermediarioUsar, Estatus
                        FROM Temporal")
  SET IDENTITY_INSERT Beneficiario OFF
  EXEC("DROP TABLE Temporal")
END
go


/*   MANTENIMIENTO 2 */

/* Art */
IF NOT EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'TipoOpcion' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Art DISABLE TRIGGER ALL")
  EXEC("ALTER TABLE Art ADD TipoOpcion varchar(20) NOT NULL DEFAULT 'No'")
  EXEC("UPDATE Art SET TipoOpcion = DEFAULT")
  EXEC("UPDATE Art SET TipoOpcion = 'Matriz', Tipo = 'Normal' WHERE Tipo = 'Matriz'")
  EXEC("UPDATE Art SET TipoOpcion = 'Matriz' WHERE Tipo = 'Partida'")
  EXEC("ALTER TABLE Art ENABLE TRIGGER ALL")
END
GO

/* EmpresaGral */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaGral') and c.name = 'VistaOpcionesOmision' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaGral.Logico4', 'VistaOpcionesOmision', 'COLUMN'")
  EXEC("UPDATE EmpresaGral SET VistaOpcionesOmision = 0")
END

/* EmpresaCfg2 */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'Mermas' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg2 ADD Mermas bit NULL DEFAULT 1")
  EXEC("UPDATE EmpresaCfg2 SET Mermas = DEFAULT")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'Desperdicios' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg2 ADD Desperdicios bit NULL DEFAULT 1")
  EXEC("UPDATE EmpresaCfg2 SET Desperdicios = DEFAULT")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'VentaMultiAgente' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico9', 'VentaMultiAgente', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET VentaMultiAgente = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'ProdAlmacenMP' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.ProdAlmacenDef', 'ProdAlmacenMP', 'COLUMN'")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'ProdAccionOrdenar' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaCfg2 ADD ProdAccionOrdenar varchar(50) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'ProdGenerarConsumo' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico8', 'ProdGenerarConsumo', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET ProdGenerarConsumo = 0")
END
GO


/* EmpresaCfgMov */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'BancoSolicitudDeposito' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfgMov ADD BancoSolicitudDeposito char(20) NULL DEFAULT 'Solicitud Deposito'")
  EXEC("UPDATE EmpresaCfgMov SET BancoSolicitudDeposito = DEFAULT")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'BancoSolicitudCheque' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfgMov ADD BancoSolicitudCheque char(20) NULL DEFAULT 'Solicitud Cheque'")
  EXEC("UPDATE EmpresaCfgMov SET BancoSolicitudCheque = DEFAULT")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'ProdOrdenTransferencia' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfgMov ADD ProdOrdenTransferencia char(20) NULL DEFAULT 'Orden Transferencia'")
  EXEC("UPDATE EmpresaCfgMov SET ProdOrdenTransferencia = DEFAULT")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'VentaPerdida' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfgMov ADD VentaPerdida char(20) NULL DEFAULT 'Venta Perdida'")
  EXEC("UPDATE EmpresaCfgMov SET VentaPerdida = DEFAULT")
END
GO

/* PlanArtOP */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.PlanArtOP') and c.name = 'LiberacionModulo' and o.sysstat & 0xf = 3)
  ALTER TABLE PlanArtOP ADD LiberacionModulo char(5) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.PlanArtOP') and c.name = 'LiberacionID' and o.sysstat & 0xf = 3)
  ALTER TABLE PlanArtOP ADD LiberacionID int NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.PlanArtOP') and c.name = 'LiberacionMov' and o.sysstat & 0xf = 3)
  ALTER TABLE PlanArtOP ADD LiberacionMov varchar(20) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.PlanArtOP') and c.name = 'LiberacionMovID' and o.sysstat & 0xf = 3)
  ALTER TABLE PlanArtOP ADD LiberacionMovID int NULL
GO


/* InvD */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.InvD') and c.name = 'Producto' and o.sysstat & 0xf = 3)
  ALTER TABLE InvD ADD Producto varchar(20) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.InvD') and c.name = 'SubProducto' and o.sysstat & 0xf = 3)
  ALTER TABLE InvD ADD SubProducto varchar(20) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.InvD') and c.name = 'Tipo' and o.sysstat & 0xf = 3)
  ALTER TABLE InvD ADD Tipo varchar(20)	NULL	-- Salida, Merma, Desperdicio, Devolucion
GO


/* ProdD */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ProdD') and c.name = 'Merma' and o.sysstat & 0xf = 3)
  ALTER TABLE ProdD ADD Merma float NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ProdD') and c.name = 'Desperdicio' and o.sysstat & 0xf = 3)
  ALTER TABLE ProdD ADD Desperdicio float NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ProdD') and c.name = 'Tipo' and o.sysstat & 0xf = 3)
  ALTER TABLE ProdD ADD Tipo varchar(20) NULL	-- Producto, Merma, Desperdicio, Sustituto
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ProdD') and c.name = 'Comision' and o.sysstat & 0xf = 3)
  ALTER TABLE ProdD ADD Comision money NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ProdD') and c.name = 'ManoObra' and o.sysstat & 0xf = 3)
  ALTER TABLE ProdD ADD ManoObra money NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ProdD') and c.name = 'Indirectos' and o.sysstat & 0xf = 3)
  ALTER TABLE ProdD ADD Indirectos money NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ProdD') and c.name = 'Tiempo' and o.sysstat & 0xf = 3)
  ALTER TABLE ProdD ADD Tiempo float NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ProdD') and c.name = 'TiempoUnidad' and o.sysstat & 0xf = 3)
  ALTER TABLE ProdD ADD TiempoUnidad varchar(10) NULL
GO

/* Opcion */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Opcion') and c.name = 'OrdenDetalle' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Opcion ADD OrdenDetalle varchar(20) NULL")
  EXEC("UPDATE Opcion SET OrdenDetalle = CASE TieneDetalle WHEN 1 THEN 'Alfabetico' ELSE 'No' END")
END
GO

/* Gasto */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Gasto') and c.name = 'AnexoModulo' and o.sysstat & 0xf = 3)
  ALTER TABLE Gasto ADD AnexoModulo char(5) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Gasto') and c.name = 'AnexoID' and o.sysstat & 0xf = 3)
  ALTER TABLE Gasto ADD AnexoID int NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Gasto') and c.name = 'ProdSerieLote' and o.sysstat & 0xf = 3)
  ALTER TABLE Gasto ADD ProdSerieLote varchar(20) NULL
GO


/* Centro */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Centro') and c.name = 'CostoManoObra' and o.sysstat & 0xf = 3)
  ALTER TABLE Centro ADD CostoManoObra money NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Centro') and c.name = 'CostoIndirectos' and o.sysstat & 0xf = 3)
  ALTER TABLE Centro ADD CostoIndirectos money NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Centro') and c.name = 'CostoMoneda' and o.sysstat & 0xf = 3)
  ALTER TABLE Centro ADD CostoMoneda char(10) NULL
GO

/* ProdserieLoteCosto */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ProdserieLoteCosto') and c.name = 'Concepto' and o.sysstat & 0xf = 3)
  ALTER TABLE ProdserieLoteCosto ADD Concepto varchar(50) NULL
GO

/* VentaD */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VentaD') and c.name = 'Agente' and o.sysstat & 0xf = 3)
  ALTER TABLE VentaD ADD Agente char(10) NULL
GO

/* Modulo */
IF (SELECT Version FROM Version)<=332
BEGIN
  UPDATE Modulo SET Nombre = 'Tesoreria' WHERE Modulo = 'DIN'
  UPDATE Modulo SET Nombre = 'Atencion Clientes' WHERE Modulo = 'ST'
END
GO


/* DocRama */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.DocRama') and c.name = 'Requerido' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE DocRama ADD Requerido bit NULL DEFAULT 0")
  EXEC("UPDATE DocRama SET Requerido = DEFAULT")
END
GO

/* VIN */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VIN') and c.name = 'Placas' and o.sysstat & 0xf = 3)
  ALTER TABLE VIN ADD Placas varchar(20) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VIN') and c.name = 'Poliza' and o.sysstat & 0xf = 3)
  ALTER TABLE VIN ADD Poliza varchar(20) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VIN') and c.name = 'PolizaTipo' and o.sysstat & 0xf = 3)
  ALTER TABLE VIN ADD PolizaTipo varchar(20) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VIN') and c.name = 'PolizaVencimiento' and o.sysstat & 0xf = 3)
  ALTER TABLE VIN ADD PolizaVencimiento	datetime NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VIN') and c.name = 'CodigoRadio' and o.sysstat & 0xf = 3)
  ALTER TABLE VIN ADD CodigoRadio varchar(20) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VIN') and c.name = 'CodigoTransmision' and o.sysstat & 0xf = 3)
  ALTER TABLE VIN ADD CodigoTransmision varchar(20) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VIN') and c.name = 'CodigoColor' and o.sysstat & 0xf = 3)
  ALTER TABLE VIN ADD CodigoColor varchar(20)	NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VIN') and c.name = 'CodigoLlanta1' and o.sysstat & 0xf = 3)
  ALTER TABLE VIN ADD CodigoLlanta1 varchar(20) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VIN') and c.name = 'CodigoLlanta2' and o.sysstat & 0xf = 3)
  ALTER TABLE VIN ADD CodigoLlanta2 varchar(20) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VIN') and c.name = 'CodigoLlanta3' and o.sysstat & 0xf = 3)
  ALTER TABLE VIN ADD CodigoLlanta3 varchar(20) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VIN') and c.name = 'CodigoLlanta4' and o.sysstat & 0xf = 3)
  ALTER TABLE VIN ADD CodigoLlanta4 varchar(20) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VIN') and c.name = 'CodigoLlanta5' and o.sysstat & 0xf = 3)
  ALTER TABLE VIN ADD CodigoLlanta5 varchar(20) NULL
GO

/* VentaOtros */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VentaOtros') and c.name = 'LlantaRefaccion' and o.sysstat & 0xf = 3)
  ALTER TABLE VentaOtros ADD LlantaRefaccion bit DEFAULT 0 WITH VALUES 
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VentaOtros') and c.name = 'Gato' and o.sysstat & 0xf = 3)
  ALTER TABLE VentaOtros ADD Gato bit DEFAULT 0 WITH VALUES 
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VentaOtros') and c.name = 'Encendedor' and o.sysstat & 0xf = 3)
  ALTER TABLE VentaOtros ADD Encendedor bit DEFAULT 0 WITH VALUES 
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VentaOtros') and c.name = 'Antena' and o.sysstat & 0xf = 3)
  ALTER TABLE VentaOtros ADD Antena bit DEFAULT 0 WITH VALUES 
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VentaOtros') and c.name = 'Herramienta' and o.sysstat & 0xf = 3)
  ALTER TABLE VentaOtros ADD Herramienta bit DEFAULT 0 WITH VALUES 
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VentaOtros') and c.name = 'Limpiadores' and o.sysstat & 0xf = 3)
  ALTER TABLE VentaOtros ADD Limpiadores bit DEFAULT 0 WITH VALUES 
GO

/* Venta */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'ServicioIdentificador' and o.sysstat & 0xf = 3)
  ALTER TABLE Venta ADD ServicioIdentificador varchar(20) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'AtencionTelefono' and o.sysstat & 0xf = 3)
  ALTER TABLE Venta ADD AtencionTelefono varchar(50) NULL
GO

/* ArtMaterial */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ArtMaterial') and c.name = 'Almacen' and o.sysstat & 0xf = 3)
  ALTER TABLE ArtMaterial ADD Almacen char(10) NULL
GO

/* Art */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'TiempoEntregaSeg' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD TiempoEntregaSeg int NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'TiempoEntregaSegUnidad' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD TiempoEntregaSegUnidad varchar(10) NULL
GO

/* ArtPlanEx */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ArtPlanEx') and c.name = 'TiempoEntregaSeg' and o.sysstat & 0xf = 3)
  ALTER TABLE ArtPlanEx ADD TiempoEntregaSeg int NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.ArtPlanEx') and c.name = 'TiempoEntregaSegUnidad' and o.sysstat & 0xf = 3)
  ALTER TABLE ArtPlanEx ADD TiempoEntregaSegUnidad varchar(10) NULL
GO


/* Personal */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Personal') and c.name = 'VencimientoContrato' and o.sysstat & 0xf = 3)
  ALTER TABLE Personal ADD VencimientoContrato	datetime NULL
GO

/* RHD */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.RHD') and c.name = 'VencimientoContrato' and o.sysstat & 0xf = 3)
  ALTER TABLE RHD ADD VencimientoContrato datetime NULL
GO

/* PersonalProp */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.PersonalProp') and c.name = 'porOmision' and o.sysstat & 0xf = 3)
  ALTER TABLE PersonalProp ADD porOmision varchar(50) NULL
GO

/* Empresa */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Empresa') and c.name = 'ClaveActividad' and o.sysstat & 0xf = 3)
  ALTER TABLE Empresa ADD ClaveActividad varchar(20) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Empresa') and c.name = 'Representante' and o.sysstat & 0xf = 3)
  ALTER TABLE Empresa ADD Representante varchar(100) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Empresa') and c.name = 'RepresentanteRFC' and o.sysstat & 0xf = 3)
  ALTER TABLE Empresa ADD RepresentanteRFC varchar(20) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Empresa') and c.name = 'RepresentanteCURP' and o.sysstat & 0xf = 3)
  ALTER TABLE Empresa ADD RepresentanteCURP varchar(20) NULL
GO

/*** 5 Feb 2001 ***/

/* Cte */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cte') and c.name = 'ChecarCredito' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Cte ADD ChecarCredito varchar(20) NULL DEFAULT '(Empresa)'")
  EXEC("UPDATE Cte SET ChecarCredito = DEFAULT")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cte') and c.name = 'BloquearMorosos' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Cte ADD BloquearMorosos varchar(20) NULL DEFAULT '(Empresa)'")
  EXEC("UPDATE Cte SET BloquearMorosos = DEFAULT")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cte') and c.name = 'ModificarVencimiento' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Cte ADD ModificarVencimiento varchar(10) NULL DEFAULT '(Empresa)'")
  EXEC("UPDATE Cte SET ModificarVencimiento = DEFAULT")
END
GO

/* Version */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Version') and c.name = 'Fecha' and o.sysstat & 0xf = 3)
  ALTER TABLE Version ADD Fecha	datetime NULL
GO

/* Venta */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'Mensaje' and o.sysstat & 0xf = 3)
  ALTER TABLE Venta ADD Mensaje	int NULL
GO

/* Usuario */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'Autorizar' and o.sysstat & 0xf = 3)
BEGIN
  ALTER TABLE Usuario DISABLE TRIGGER ALL
  ALTER TABLE Usuario ADD Autorizar bit NULL DEFAULT 0
  ALTER TABLE Usuario ENABLE TRIGGER ALL
END
GO


/*** 6 Feb 2001 ***/

/* Soporte */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Soporte') and c.name = 'Version' and o.sysstat & 0xf = 3)
  ALTER TABLE Soporte ADD Version float	NULL
GO


/*** 7 Feb 2001 ***/

/* Venta */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'ListaPreciosEsp' and o.sysstat & 0xf = 3)
  ALTER TABLE Venta ADD ListaPreciosEsp varchar(20) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'ZonaImpuesto' and o.sysstat & 0xf = 3)
  ALTER TABLE Venta ADD ZonaImpuesto varchar(30) NULL
GO

/* Usuario */
ALTER TABLE Usuario DISABLE TRIGGER ALL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'ModificarListaPrecios' and o.sysstat & 0xf = 3)
  ALTER TABLE Usuario ADD ModificarListaPrecios	bit NOT NULL DEFAULT 0
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'ModificarZonaImpuesto' and o.sysstat & 0xf = 3)
  ALTER TABLE Usuario ADD ModificarZonaImpuesto	bit NOT NULL DEFAULT 0
ALTER TABLE Usuario ENABLE TRIGGER ALL
GO

/* CteEnviarA */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CteEnviarA') and c.name = 'ListaPreciosEsp' and o.sysstat & 0xf = 3)
  ALTER TABLE CteEnviarA ADD ListaPreciosEsp varchar(20) NULL 
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CteEnviarA') and c.name = 'Proyecto' and o.sysstat & 0xf = 3)
  ALTER TABLE CteEnviarA ADD Proyecto varchar(50) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CteEnviarA') and c.name = 'Condicion' and o.sysstat & 0xf = 3)
  ALTER TABLE CteEnviarA ADD Condicion varchar(50) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CteEnviarA') and c.name = 'Descuento' and o.sysstat & 0xf = 3)
  ALTER TABLE CteEnviarA ADD Descuento varchar(30) NULL
GO

/* EmpresaCfgMov */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'GastoComprobante' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfgMov ADD GastoComprobante char(20) NULL DEFAULT 'Comprobante'")
  EXEC("UPDATE EmpresaCfgMov SET GastoComprobante = DEFAULT")
END
GO

/* Empresa */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Empresa') and c.name = 'Zona' and o.sysstat & 0xf = 3)
  ALTER TABLE Empresa ADD Zona varchar(50) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Empresa') and c.name = 'Sucursal' and o.sysstat & 0xf = 3)
  ALTER TABLE Empresa ADD Sucursal int NULL 
GO


/*** 8 Feb 2001 ***/

/* Art */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'Situacion' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD Situacion varchar(50) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'SituacionFecha' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD SituacionFecha datetime NULL
GO
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'EstatusPrecio' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD EstatusPrecio varchar(15) NULL DEFAULT 'SINCAMBIO'
GO
ALTER TABLE Art DISABLE TRIGGER ALL
UPDATE Art SET EstatusPrecio = Estatus, Estatus = 'ALTA' WHERE EstatusPrecio IS NULL
ALTER TABLE Art ENABLE TRIGGER ALL
GO

/* Cte */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cte') and c.name = 'Situacion' and o.sysstat & 0xf = 3)
  ALTER TABLE Cte ADD Situacion varchar(50) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cte') and c.name = 'SituacionFecha' and o.sysstat & 0xf = 3)
  ALTER TABLE Cte ADD SituacionFecha datetime NULL
GO

/* Prov */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Prov') and c.name = 'Situacion' and o.sysstat & 0xf = 3)
  ALTER TABLE Prov ADD Situacion varchar(50) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Prov') and c.name = 'SituacionFecha' and o.sysstat & 0xf = 3)
  ALTER TABLE Prov ADD SituacionFecha datetime NULL
GO


/*** 9 Feb 2001 ***/
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CteEnviarA') and c.name = 'ModificarVencimiento' and o.sysstat & 0xf = 3)
  ALTER TABLE CteEnviarA ADD ModificarVencimiento varchar(10) NULL
GO

IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'OpcionMatriz' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaCfg2 ADD OpcionMatriz bit NULL DEFAULT 0
GO

IF (SELECT Version FROM Version)<=1052
BEGIN
  EXEC("ALTER TABLE Art DISABLE TRIGGER ALL")
  EXEC("UPDATE Art SET TipoOpcion = 'Si' WHERE TipoOpcion = 'Multiples'")
  EXEC("ALTER TABLE Art ENABLE TRIGGER ALL")
END
GO


/*** 12 Feb 2001 ***/
IF (SELECT Version FROM Version)<=1052
  UPDATE MovTipo SET ConsecutivoPorEjercicio = 1 WHERE Modulo = 'NOM' AND Clave IN ('NOM.N', 'NOM.NE')
GO

/*** 13 Feb 2001 ***/
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'Servicios' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Art ADD Servicios bit NULL DEFAULT 0")
  EXEC("UPDATE Art SET Servicios = DEFAULT")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'Consumibles' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Art ADD Consumibles bit NULL DEFAULT 0")
  EXEC("UPDATE Art SET Consumibles = DEFAULT")
END
GO

/* Personal */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Personal') and c.name = 'Situacion' and o.sysstat & 0xf = 3)
  ALTER TABLE Personal ADD Situacion	varchar(50) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Personal') and c.name = 'SituacionFecha' and o.sysstat & 0xf = 3)
  ALTER TABLE Personal ADD SituacionFecha datetime NULL
GO

/* Embarque */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Embarque') and c.name = 'Gastos' and o.sysstat & 0xf = 3)
  ALTER TABLE Embarque ADD Gastos money	NULL
GO

if (SELECT Version FROM Version)<=1056 and not exists(select * from EmbarqueEstado where Estado = 'Transito' and Tipo = 'Pendiente')
  insert EmbarqueEstado (Estado, Tipo, Orden) values ('Transito',   'Pendiente', 	3)
GO

/*** 14 Feb 2001 ***/
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CteEnviarA') and c.name = 'Categoria' and o.sysstat & 0xf = 3)
  ALTER TABLE CteEnviarA ADD Categoria varchar(50) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CteEnviarA') and c.name = 'Grupo' and o.sysstat & 0xf = 3)
  ALTER TABLE CteEnviarA ADD Grupo varchar(50) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CteEnviarA') and c.name = 'Familia' and o.sysstat & 0xf = 3)
  ALTER TABLE CteEnviarA ADD Familia varchar(50) NULL
GO


/* Venta */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'FechaEntrega' and o.sysstat & 0xf = 3)
  ALTER TABLE Venta ADD FechaEntrega datetime NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'EmbarqueEstado' and o.sysstat & 0xf = 3)
  ALTER TABLE Venta ADD EmbarqueEstado varchar(50) NULL
GO

/* Inv */ 
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Inv') and c.name = 'FechaEntrega' and o.sysstat & 0xf = 3)
  ALTER TABLE Inv ADD FechaEntrega datetime NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Inv') and c.name = 'EmbarqueEstado' and o.sysstat & 0xf = 3)
  ALTER TABLE Inv ADD EmbarqueEstado varchar(50) NULL
GO

/* Compra */ 
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Compra') and c.name = 'FechaEntrega' and o.sysstat & 0xf = 3)
  ALTER TABLE Compra ADD FechaEntrega datetime NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Compra') and c.name = 'EmbarqueEstado' and o.sysstat & 0xf = 3)
  ALTER TABLE Compra ADD EmbarqueEstado varchar(50) NULL
GO

/* Cxc */ 
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxc') and c.name = 'FechaEntrega' and o.sysstat & 0xf = 3)
  ALTER TABLE Cxc ADD FechaEntrega datetime NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cxc') and c.name = 'EmbarqueEstado' and o.sysstat & 0xf = 3)
  ALTER TABLE Cxc ADD EmbarqueEstado varchar(50) NULL
GO

/* Dinero */ 
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Dinero') and c.name = 'FechaEntrega' and o.sysstat & 0xf = 3)
  ALTER TABLE Dinero ADD FechaEntrega datetime NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Dinero') and c.name = 'EmbarqueEstado' and o.sysstat & 0xf = 3)
  ALTER TABLE Dinero ADD EmbarqueEstado varchar(50) NULL
GO

/* EmpresaCfg */

IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'EmbarqueEstadoPendiente' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD EmbarqueEstadoPendiente varchar(50) NULL DEFAULT 'Pendiente'")
  EXEC("UPDATE EmpresaCfg SET EmbarqueEstadoPendiente = DEFAULT")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'EmbarqueEstadoTransito' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD EmbarqueEstadoTransito varchar(50) NULL DEFAULT 'Transito'")
  EXEC("UPDATE EmpresaCfg SET EmbarqueEstadoTransito = DEFAULT")
END
Go

/* Venta */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Venta') and c.name = 'Departamento' and o.sysstat & 0xf = 3)
  ALTER TABLE Venta ADD Departamento int NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VentaD') and c.name = 'Departamento' and o.sysstat & 0xf = 3)
  ALTER TABLE VentaD ADD Departamento int NULL
GO

IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'VentaMultiDepartamento' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico7', 'VentaMultiDepartamento', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET VentaMultiDepartamento = 0")
END
GO

/* 15 Feb 2001 */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg2') and c.name = 'VentaBonifConsecutivoIndep' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("sp_rename 'EmpresaCfg2.Logico6', 'VentaBonifConsecutivoIndep', 'COLUMN'")
  EXEC("UPDATE EmpresaCfg2 SET VentaBonifConsecutivoIndep = 0")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'AgentBonificacion' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfgMov ADD AgentBonificacion char(20) NULL DEFAULT 'Bonificacion'")
  EXEC("UPDATE EmpresaCfgMov SET AgentBonificacion = DEFAULT")
END
GO

/* CtaDinero */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CtaDinero') and c.name = 'Empresa' and o.sysstat & 0xf = 3)
  ALTER TABLE CtaDinero ADD Empresa char(5) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CtaDinero') and c.name = 'Institucion' and o.sysstat & 0xf = 3)
  ALTER TABLE CtaDinero ADD Institucion varchar(20) NULL
GO

/* Dinero */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Dinero') and c.name = 'InstitucionMensaje' and o.sysstat & 0xf = 3)
  ALTER TABLE Dinero ADD InstitucionMensaje varchar(10)	NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Dinero') and c.name = 'InstitucionSucursal' and o.sysstat & 0xf = 3)
  ALTER TABLE Dinero ADD InstitucionSucursal varchar(10) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Dinero') and c.name = 'InstitucionReferencia1' and o.sysstat & 0xf = 3)
  ALTER TABLE Dinero ADD InstitucionReferencia1 varchar(50) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Dinero') and c.name = 'InstitucionReferencia2' and o.sysstat & 0xf = 3)
  ALTER TABLE Dinero ADD InstitucionReferencia2 varchar(50) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Dinero') and c.name = 'AutoConciliar' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Dinero ADD AutoConciliar bit NULL DEFAULT 0")
  EXEC("UPDATE Dinero SET AutoConciliar = DEFAULT")
END
GO

IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'BancoCargoBancario' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfgMov ADD BancoCargoBancario char(20) NULL DEFAULT 'Cargo Bancario'")
  EXEC("UPDATE EmpresaCfgMov SET BancoCargoBancario = DEFAULT")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfgMov') and c.name = 'BancoAbonoBancario' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE EmpresaCfgMov ADD BancoAbonoBancario char(20) NULL DEFAULT 'Abono Bancario'")
  EXEC("UPDATE EmpresaCfgMov SET BancoAbonoBancario = DEFAULT")
END
GO


/* 16 Feb 2001 */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Personal') and c.name = 'EstaPresente' and o.sysstat & 0xf = 3)
  EXEC("sp_rename 'Personal.Logico9', 'EstaPresente', 'COLUMN'")
GO


/* 19 Feb 2001 */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Version') and c.name = 'ArtR' and o.sysstat & 0xf = 3)
  ALTER TABLE Version ADD ArtR datetime	NULL
GO


/* 20 Feb 2001 */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.NomXFormula') and c.name = 'Tipo' and o.sysstat & 0xf = 3)
  ALTER TABLE NomXFormula ADD Tipo varchar(20) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.NomXFormula') and c.name = 'Calculo' and o.sysstat & 0xf = 3)
  ALTER TABLE NomXFormula ADD Calculo varchar(20) NULL
GO

/* 21 Feb 2001 */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'UnidadCantidad' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD UnidadCantidad float NULL
GO

ALTER TABLE Usuario DISABLE TRIGGER ALL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'ConsultarOtrasEmpresas' and o.sysstat & 0xf = 3)
  ALTER TABLE Usuario ADD ConsultarOtrasEmpresas bit NULL DEFAULT 0
ALTER TABLE Usuario ENABLE TRIGGER ALL
GO

  
/* 22 Feb 2001 */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VIN') and c.name = 'Registro' and o.sysstat & 0xf = 3)
  ALTER TABLE VIN ADD Registro varchar(20) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VIN') and c.name = 'FechaCartaCredito' and o.sysstat & 0xf = 3)
  ALTER TABLE VIN ADD FechaCartaCredito datetime NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VIN') and c.name = 'FechaFactura' and o.sysstat & 0xf = 3)
  ALTER TABLE VIN ADD FechaFactura datetime NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VIN') and c.name = 'FechaUltimoServicio' and o.sysstat & 0xf = 3)
  ALTER TABLE VIN ADD FechaUltimoServicio datetime NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VIN') and c.name = 'PolizaImporte' and o.sysstat & 0xf = 3)
  ALTER TABLE VIN ADD PolizaImporte money NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VIN') and c.name = 'Costo' and o.sysstat & 0xf = 3)
  ALTER TABLE VIN ADD Costo money NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VIN') and c.name = 'CostoConGastos' and o.sysstat & 0xf = 3)
  ALTER TABLE VIN ADD CostoConGastos money NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.VIN') and c.name = 'Tasa' and o.sysstat & 0xf = 3)
  ALTER TABLE VIN ADD Tasa float NULL
GO


/* 26 Feb 2001 */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.EmpresaCfg') and c.name = 'NomISRSimplificado' and o.sysstat & 0xf = 3)
  ALTER TABLE EmpresaCfg ADD NomISRSimplificado bit NULL DEFAULT 0
GO


/* 27 Feb 2001 */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Proy') and c.name = 'Descripcion' and o.sysstat & 0xf = 3)
  ALTER TABLE Proy ADD Descripcion varchar(100) NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Proy') and c.name = 'Estatus' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Proy ADD Estatus char(15) NULL")
  EXEC("UPDATE Proy SET Estatus = 'ALTA'")
END
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Proy') and c.name = 'FechaInicio' and o.sysstat & 0xf = 3)
  ALTER TABLE Proy ADD FechaInicio datetime NULL
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Proy') and c.name = 'FechaFin' and o.sysstat & 0xf = 3)
  ALTER TABLE Proy ADD FechaFin	datetime NULL
GO
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Excel') and c.name = 'Mov' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Excel ADD Mov varchar(20) NULL")
  ExEC("UPDATE Excel SET Mov = 'Pedido'")
END
GO

/* 28 Feb 2001 */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Excel') and c.name = 'Moneda' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE Excel ADD Moneda char(10) NULL")
  ExEC("UPDATE Excel SET Moneda = 'Pesos'")
END
GO

/* 1 Mar 2001 */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'Linea' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD Linea varchar(50) NULL
GO

IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Art') and c.name = 'TipoCompra' and o.sysstat & 0xf = 3)
  ALTER TABLE Art ADD TipoCompra varchar(20) NULL
GO
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.UsuarioCfg2') and c.name = 'LimitarCompraLocal' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE UsuarioCfg2 DISABLE TRIGGER ALL")
  EXEC("sp_rename 'UsuarioCfg2.Logico38', 'LimitarCompraLocal', 'COLUMN'")
  EXEC("UPDATE UsuarioCfg2 SET LimitarCompraLocal = 0")
  EXEC("ALTER TABLE UsuarioCfg2 ENABLE TRIGGER ALL")
END
GO

IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.MovTipo') and c.name = 'Almacen' and o.sysstat & 0xf = 3)
  ALTER TABLE MovTipo ADD Almacen char(10) NULL
GO


ALTER TABLE Cte DISABLE TRIGGER ALL

/* ChecarCredito */
IF (SELECT Version FROM Version)<=1081
BEGIN
  EXEC("UPDATE EmpresaCfg SET VentaChecarCredito = 'Venta'  WHERE VentaChecarCredito IN ('Venta Consignacion', 'Remision', 'Factura')")
  EXEC("UPDATE Cte        SET ChecarCredito      = 'Venta'  WHERE ChecarCredito      IN ('Venta Consignacion', 'Remision', 'Factura')")
END
GO

IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CteCredito') and c.name = 'ConLimitePedidos' and o.sysstat & 0xf = 3)
  ALTER TABLE CteCredito ADD ConLimitePedidos bit NULL DEFAULT 0
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.CteCredito') and c.name = 'LimitePedidos' and o.sysstat & 0xf = 3)
  ALTER TABLE CteCredito ADD LimitePedidos money NULL
GO

IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cte') and c.name = 'CreditoConLimitePedidos' and o.sysstat & 0xf = 3)
  ALTER TABLE Cte ADD CreditoConLimitePedidos bit NULL DEFAULT 0
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Cte') and c.name = 'CreditoLimitePedidos' and o.sysstat & 0xf = 3)
  ALTER TABLE Cte ADD CreditoLimitePedidos money NULL
GO

ALTER TABLE Cte ENABLE TRIGGER ALL

/* 2 Mar 2001 */
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.NomXPersonal') and c.name = 'Aplica' and o.sysstat & 0xf = 3)
BEGIN
  EXEC("ALTER TABLE NomXPersonal ADD Aplica varchar(20) NULL")
  EXEC("UPDATE NomXPersonal SET Aplica = 'Todos'")
END
GO


/* 7 Mar 2001 */
IF (SELECT Version FROM Version)<=1088
  UPDATE Precio SET Estatus = 'ACTIVA' WHERE Estatus = 'ALTA'
GO


/* 12 Mar 2001 */
IF (SELECT Version FROM Version)<=1093
BEGIN
  UPDATE NomXPersonal SET Aplica = 'Lista' WHERE Aplica = 'Grupo'
  UPDATE NomXPersonal SET Aplica = 'Todos menos Lista' WHERE Aplica = 'Todos menos Grupo'
END
GO

/* Eliminar Tablas */


/****** Sys ******/
if (SELECT Version FROM Version)<=328 AND exists (select * from sysobjects where id = object_id('dbo.SysTablasReplicar') and sysstat & 0xf = 3) drop table dbo.SysTablasReplicar
if (SELECT Version FROM Version)<=328 AND exists (select * from sysobjects where id = object_id('dbo.SysVistasLocales') and sysstat & 0xf = 3) drop table dbo.SysVistasLocales
GO

/* Nota y NotaD */
if (SELECT Version FROM Version)<=239 AND exists (select * from sysobjects where id = object_id('dbo.Nota') and sysstat & 0xf = 3) drop table dbo.Nota
if (SELECT Version FROM Version)<=239 AND exists (select * from sysobjects where id = object_id('dbo.NotaD') and sysstat & 0xf = 3) drop table dbo.NotaD
go

/* ImpresionC */
if (SELECT Version FROM Version)<=190 AND EXISTS(SELECT * FROM SysObjects WHERE Id = object_id('dbo.ImpresionC') AND SysStat & 0xf = 3) 
  DROP TABLE dbo.ImpresionC

/* AlmTipo */
if (SELECT Version FROM Version)<=191 AND EXISTS(SELECT * FROM SysObjects WHERE Id = object_id('dbo.AlmTipo') AND SysStat & 0xf = 3) 
  DROP TABLE dbo.AlmTipo

/* VentaLiquida */
if (SELECT Version FROM Version)<=208 AND EXISTS(SELECT * FROM SysObjects WHERE Id = object_id('dbo.VentaLiquida') AND SysStat & 0xf = 3) 
  DROP TABLE dbo.VentaLiquida

/* Caja */
if (SELECT Version FROM Version)<=209 
BEGIN
  EXEC("IF exists (select * from SysObjects WHERE Id = object_id('dbo.Caja')    AND SysStat & 0xf = 3) DROP TABLE dbo.Caja")
  EXEC("IF exists (select * from SysObjects WHERE Id = object_id('dbo.CajaD')   AND SysStat & 0xf = 3) DROP TABLE dbo.CajaD")
  EXEC("IF exists (select * from SysObjects WHERE Id = object_id('dbo.CajaC')   AND SysStat & 0xf = 3) DROP TABLE dbo.CajaC")
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.tgCajaC') and sysstat & 0xf = 8) drop trigger dbo.tgCajaC")
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.tgCajaB') and sysstat & 0xf = 8) drop trigger dbo.tgCajaB")
END

/* Trabajo */
if (SELECT Version FROM Version)<=211 AND EXISTS(SELECT * FROM SysObjects WHERE Id = object_id('dbo.Trabajo') AND SysStat & 0xf = 3) 
  DROP TABLE dbo.Trabajo
  
/* TrabajoCat */
if (SELECT Version FROM Version)<=211 AND EXISTS(SELECT * FROM SysObjects WHERE Id = object_id('dbo.TrabajoCat') AND SysStat & 0xf = 3) 
  DROP TABLE dbo.TrabajoCat

/* ServicioTrabajo */
if (SELECT Version FROM Version)<=211 AND EXISTS(SELECT * FROM SysObjects WHERE Id = object_id('dbo.ServicioTrabajo') AND SysStat & 0xf = 3) 
  DROP TABLE dbo.ServicioTrabajo

/* ProvArt */
if (SELECT Version FROM Version)<=227 AND EXISTS(SELECT * FROM SysObjects WHERE Id = object_id('dbo.ProvArt') AND SysStat & 0xf = 3) 
  drop table dbo.ProvArt
GO

/* ArtEnsable */
if (SELECT Version FROM Version)<=232 AND EXISTS(SELECT * FROM SysObjects WHERE Id = object_id('dbo.ArtEnsable') AND SysStat & 0xf = 3) 
  drop table dbo.ArtEnsable
GO

if (SELECT Version FROM Version)<=1070 AND EXISTS(SELECT * FROM SysObjects WHERE Id = object_id('dbo.CxcTramite') AND SysStat & 0xf = 3) 
  drop table dbo.CxcTramite
GO

/* ACTUALIZAR REGISTROS OMISION */

IF (SELECT Version FROM Version)<=301
BEGIN
  UPDATE MovTipo SET Factor = -1 WHERE Clave IN ('VTAS.D', 'VTAS.DF', 'VTAS.B', 'COMS.D', 'COMS.B')
  UPDATE MovTipo SET Factor = -1 WHERE Clave IN ('CXC.NC', 'CXC.NCD', 'CXP.NC', 'CXP.NCD')
END
GO


IF (SELECT Version FROM Version)<=1054
BEGIN
  if exists (select * from sysobjects where id = object_id('dbo.tgUsuarioABC') and sysstat & 0xf = 8) drop trigger dbo.tgUsuarioABC
  if exists(select * from Usuario   	where estatus = 'ACTIVO')   UPDATE Usuario      SET Estatus = 'ALTA' WHERE Estatus = 'ACTIVO'
  if exists(select * from Usuario   	where estatus = 'INACTIVO') UPDATE Usuario      SET Estatus = 'BAJA' WHERE Estatus = 'INACTIVO'
  if exists(select * from empresa   	where estatus = 'NORMAL')   UPDATE Empresa 	SET Estatus = 'ALTA' WHERE Estatus = 'NORMAL'
  if exists(select * from Cta       	where estatus = 'NORMAL')   UPDATE Cta          SET Estatus = 'ALTA' WHERE Estatus = 'NORMAL'
  if exists(select * from CtaDinero 	where estatus = 'NORMAL')   UPDATE CtaDinero    SET Estatus = 'ALTA' WHERE Estatus = 'NORMAL'
  if exists(select * from Agente	where estatus = 'NORMAL')   UPDATE Agente       SET Estatus = 'ALTA' WHERE Estatus = 'NORMAL'
  if exists(select * from Cte	 	where estatus = 'NORMAL')   UPDATE Cte          SET Estatus = 'ALTA' WHERE Estatus = 'NORMAL'
  if exists(select * from CteEnviarA 	where estatus = 'NORMAL')   UPDATE CteEnviarA   SET Estatus = 'ALTA' WHERE Estatus = 'NORMAL'
  if exists(select * from Alm	 	where estatus = 'NORMAL')   UPDATE Alm          SET Estatus = 'ALTA' WHERE Estatus = 'NORMAL'
  if exists(select * from Art		where estatus = 'NORMAL')   UPDATE Art          SET Estatus = 'ALTA' WHERE Estatus = 'NORMAL'
  if exists(select * from Prov	 	where estatus = 'NORMAL')   UPDATE Prov         SET Estatus = 'ALTA' WHERE Estatus = 'NORMAL'
  if exists(select * from Beneficiario 	where estatus = 'NORMAL')   UPDATE Beneficiario SET Estatus = 'ALTA' WHERE Estatus = 'NORMAL'
  if exists(select * from EstacionT 	where estatus = 'NORMAL')   UPDATE EstacionT    SET Estatus = 'ALTA' WHERE Estatus = 'NORMAL'
  if exists(select * from Centro	where estatus = 'NORMAL')   UPDATE Centro       SET Estatus = 'ALTA' WHERE Estatus = 'NORMAL'
END

IF (SELECT Version FROM Version)<=242
  UPDATE Venta SET FechaEmision = DATEADD(ms, -DATEPART(ms, FechaEmision), DATEADD(ss, -DATEPART(ss, FechaEmision), DATEADD(mi, -DATEPART(mi, FechaEmision), DATEADD(hh, -DATEPART(hh, FechaEmision), FechaEmision)))) WHERE OrigenTipo = 'VMOS'
GO

IF (SELECT Version FROM Version)<=307
begin
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.tgArtBC') and sysstat & 0xf = 8) drop trigger dbo.tgArtBC")
  EXEC("UPDATE Art SET ProdMov = '(por omision)'")
end
GO
