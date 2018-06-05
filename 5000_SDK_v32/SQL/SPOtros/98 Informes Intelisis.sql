SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF

/**************** fnEvitarDivisionCero ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnEvitarDivisionCero') DROP FUNCTION fnEvitarDivisionCero
GO
CREATE FUNCTION fnEvitarDivisionCero 
	(
	@Divisor				float
	)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN

  SELECT @Divisor = NULLIF(@Divisor,0)    

  RETURN (@Divisor)
END
GO

/**************** fnTipoCambio ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTipoCambio') DROP FUNCTION fnTipoCambio
GO
CREATE FUNCTION fnTipoCambio 
	(
	@Moneda				varchar(10)
	)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @TipoCambio	float

  SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda
  
  RETURN (@TipoCambio)
END
GO

/**************** fnImporteAMonedaContable ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnImporteAMonedaContable') DROP FUNCTION fnImporteAMonedaContable
GO
CREATE FUNCTION fnImporteAMonedaContable 
	(
	@Importe				float,
	@ImporteTipoCambio		float,
	@MonedaDestino			varchar(10)
	)
	
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ImporteDestino				float,
    @TipoCambioDestino			float
    
  SET @ImporteDestino = NULL
  
  SET @TipoCambioDestino = dbo.fnTipoCambio(@MonedaDestino)  
  IF @TipoCambioDestino IS NOT NULL
    SET @ImporteDestino = (@Importe*@ImporteTipoCambio)/dbo.fnEvitarDivisionCero(@TipoCambioDestino)
  
  RETURN (@ImporteDestino)
END
GO
/**************** spContactoDireccion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContactoDireccion') and type = 'P') drop procedure dbo.spContactoDireccion
GO
CREATE PROCEDURE spContactoDireccion
    @Estacion					int,
	@ContactoTipo				varchar(20), 
	@ContactoDesde				varchar(10),
	@ContactoHasta				varchar(10),
	@IncluirNombre				bit,		
	@IncluirContacto			bit,	
	@IncluirRFC					bit,
	@IncluirTelefono			bit
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON 
  DECLARE    
    @Direccion						varchar(100),
    @DireccionNumero				varchar(20),
    @DireccionNumeroInt				varchar(20),
    @EntreCalles					varchar(100),
    @Colonia						varchar(100),
    @Delegacion						varchar(100),    
    @Poblacion						varchar(100),
    @Estado							varchar(30),
    @Pais							varchar(30),
    @CodigoPostal					varchar(15),
    @RFC							varchar(15),
    @Telefonos						varchar(100),  
    @Espacio						char(1),
    @Coma							char(1),
    @Contador						int,
    @ContactoCursor					varchar(10),
    @ContactoRegistro				varchar(50),
    @Nombre							varchar(255)


  DELETE ContactoDireccion WHERE Estacion = @Estacion
  SELECT @Espacio = ' ', @Coma = ',', @ContactoDesde = NULLIF(@ContactoDesde,''), @ContactoHasta = NULLIF(@ContactoHasta,'')
  
  IF @ContactoTipo = 'Cliente'   DECLARE crContacto CURSOR FAST_FORWARD FOR SELECT Cliente,   NULLIF(RTRIM(Nombre),''),                                                                                         NULLIF(ISNULL(RTRIM(Contacto1),RTRIM(Contacto2)),''),   NULLIF(RTRIM(Direccion),''), NULLIF(RTRIM(DireccionNumero),''), NULLIF(RTRIM(DireccionNumeroInt),''), NULLIF(RTRIM(EntreCalles),''), NULLIF(RTRIM(Delegacion),''), NULLIF(RTRIM(Colonia),''), NULLIF(RTRIM(Poblacion),''), NULLIF(RTRIM(Estado),''), NULLIF(RTRIM(Pais),''), NULLIF(RTRIM(CodigoPostal),''), NULLIF(RTRIM(RFC),''),      NULLIF(RTRIM(Telefonos),'') FROM Cte      WHERE Cliente   BETWEEN  ISNULL(@ContactoDesde,Cliente)   AND ISNULL(@ContactoHasta,Cliente)   ELSE
  IF @ContactoTipo = 'Proveedor' DECLARE crContacto CURSOR FAST_FORWARD FOR SELECT Proveedor, NULLIF(RTRIM(Nombre),''),                                                                                         NULLIF(ISNULL(RTRIM(Contacto1),RTRIM(Contacto2)),''), NULLIF(RTRIM(Direccion),''), NULLIF(RTRIM(DireccionNumero),''), NULLIF(RTRIM(DireccionNumeroInt),''),   NULLIF(RTRIM(EntreCalles),''), NULLIF(RTRIM(Delegacion),''), NULLIF(RTRIM(Colonia),''), NULLIF(RTRIM(Poblacion),''), NULLIF(RTRIM(Estado),''), NULLIF(RTRIM(Pais),''), NULLIF(RTRIM(CodigoPostal),''), NULLIF(RTRIM(RFC),''),      NULLIF(RTRIM(Telefonos),'') FROM Prov     WHERE Proveedor BETWEEN  ISNULL(@ContactoDesde,Proveedor) AND ISNULL(@ContactoHasta,Proveedor) ELSE
  IF @ContactoTipo = 'Personal'  DECLARE crContacto CURSOR FAST_FORWARD FOR SELECT Personal,  NULLIF(LTRIM(RTRIM(ISNULL(Nombre,'') + ' ' + ISNULL(ApellidoPaterno,'') + ' ' + ISNULL(ApellidoMaterno,''))),''), NULL,                                                 NULLIF(RTRIM(Direccion),''), NULLIF(RTRIM(DireccionNumero),''), NULLIF(RTRIM(DireccionNumeroInt),''),   NULLIF(RTRIM(EntreCalles),''), NULLIF(RTRIM(Delegacion),''), NULLIF(RTRIM(Colonia),''), NULLIF(RTRIM(Poblacion),''), NULLIF(RTRIM(Estado),''), NULLIF(RTRIM(Pais),''), NULLIF(RTRIM(CodigoPostal),''), NULLIF(RTRIM(Registro),''), NULLIF(RTRIM(Telefono),'')  FROM Personal WHERE Personal  BETWEEN  ISNULL(@ContactoDesde,Personal)  AND ISNULL(@ContactoHasta,Personal)  ELSE
  IF @ContactoTipo = 'Empresa'   DECLARE crContacto CURSOR FAST_FORWARD FOR SELECT Empresa,   NULLIF(RTRIM(Nombre),''),																						   NULL,                                                 NULLIF(RTRIM(Direccion),''), NULLIF(RTRIM(DireccionNumero),''), NULLIF(RTRIM(DireccionNumeroInt),''),   NULL,							NULLIF(RTRIM(Delegacion),''), NULLIF(RTRIM(Colonia),''), NULLIF(RTRIM(Poblacion),''), NULLIF(RTRIM(Estado),''), NULLIF(RTRIM(Pais),''), NULLIF(RTRIM(CodigoPostal),''), NULLIF(RTRIM(RFC),''),      NULLIF(RTRIM(TelefonoS),'')  FROM Empresa  WHERE Empresa   BETWEEN  ISNULL(@ContactoDesde,Empresa)   AND ISNULL(@ContactoHasta,Empresa)
  IF @ContactoTipo = 'Sucursal'  DECLARE crContacto CURSOR FAST_FORWARD FOR SELECT Sucursal,   NULLIF(RTRIM(Nombre),''), NULL,NULLIF(RTRIM(Direccion),''), NULL, NULL,   NULL,NULL, NULLIF(RTRIM(Colonia),''), NULLIF(RTRIM(Poblacion),''), NULLIF(RTRIM(Estado),''), NULLIF(RTRIM(Pais),''), NULLIF(RTRIM(CodigoPostal),''), NULLIF(RTRIM(RFC),''),      NULLIF(RTRIM(Telefonos),'')  FROM Sucursal  WHERE Sucursal   BETWEEN  ISNULL(@ContactoDesde,Sucursal)   AND ISNULL(@ContactoHasta,Sucursal)
  OPEN crContacto
  FETCH NEXT FROM crContacto INTO @ContactoCursor, @Nombre, @ContactoRegistro, @Direccion, @DireccionNumero, @DireccionNumeroInt, @EntreCalles, @Colonia, @Delegacion, @Poblacion, @Estado, @Pais, @CodigoPostal, @RFC, @Telefonos      
  WHILE @@FETCH_STATUS = 0
  BEGIN
    SET @Contador = 0
    IF @Nombre IS NOT NULL AND @IncluirNombre = 1
    BEGIN
      SET @Contador = @Contador + 1
      INSERT ContactoDireccion (Estacion,  ID,        ContactoTipo,  Contacto,        Direccion)
                        SELECT  @Estacion, @Contador, @ContactoTipo, @ContactoCursor, ISNULL(@Nombre,'')
    END     
    IF @ContactoRegistro IS NOT NULL AND @IncluirContacto = 1
    BEGIN
      SET @Contador = @Contador + 1
      INSERT ContactoDireccion (Estacion,  ID,        ContactoTipo,  Contacto,        Direccion)
                        SELECT  @Estacion, @Contador, @ContactoTipo, @ContactoCursor, ISNULL(@ContactoRegistro,'')
    END     
    
    IF @Direccion IS NOT NULL OR @DireccionNumero IS NOT NULL OR @DireccionNumeroInt IS NOT NULL
    BEGIN
      SET @Contador = @Contador + 1
      INSERT ContactoDireccion (Estacion,  ID,        ContactoTipo,  Contacto,        Direccion)
                        SELECT  @Estacion, @Contador, @ContactoTipo, @ContactoCursor, ISNULL(@Direccion,'') + @Espacio + ISNULL(@DireccionNumero,'') + @Espacio + ISNULL(@DireccionNumeroInt,'')                        
    END     

    IF @EntreCalles IS NOT NULL
    BEGIN
      SET @Contador = @Contador + 1    
      INSERT ContactoDireccion (Estacion,  ID,        ContactoTipo,  Contacto,        Direccion)
                        SELECT  @Estacion, @Contador, @ContactoTipo, @ContactoCursor, ISNULL(@EntreCalles,'')
    END     

    IF @Colonia IS NOT NULL OR @Delegacion IS NOT NULL
    BEGIN
      SET @Contador = @Contador + 1        
      INSERT ContactoDireccion (Estacion,  ID,        ContactoTipo,  Contacto,        Direccion)
                        SELECT  @Estacion, @Contador, @ContactoTipo, @ContactoCursor, ISNULL(@Colonia,'') + CASE WHEN @Colonia + @Delegacion IS NOT NULL THEN @Coma + @Espacio ELSE '' END + ISNULL(@Delegacion,'') 
    END  

    IF @Poblacion IS NOT NULL OR @Estado IS NOT NULL
    BEGIN
      SET @Contador = @Contador + 1        
      INSERT ContactoDireccion (Estacion,  ID,        ContactoTipo,  Contacto,        Direccion)
                        SELECT  @Estacion, @Contador, @ContactoTipo, @ContactoCursor, ISNULL(@Poblacion,'') + CASE WHEN @Poblacion + @Estado IS NOT NULL THEN @Coma + @Espacio ELSE '' END + ISNULL(@Estado,'') 
    END  

    IF @Pais IS NOT NULL OR @CodigoPostal IS NOT NULL
    BEGIN
      SET @Contador = @Contador + 1        
      INSERT ContactoDireccion (Estacion,  ID,        ContactoTipo,  Contacto,        Direccion)
                        SELECT  @Estacion, @Contador, @ContactoTipo, @ContactoCursor, ISNULL(@Pais,'') + CASE WHEN @Pais + @CodigoPostal IS NOT NULL  THEN @Coma + @Espacio ELSE '' END + ISNULL(@CodigoPostal,'') 
    END  

    IF @RFC IS NOT NULL AND @IncluirRFC = 1
    BEGIN
      SET @Contador = @Contador + 1        
      INSERT ContactoDireccion (Estacion,  ID,        ContactoTipo,  Contacto,        Direccion)
                        SELECT  @Estacion, @Contador, @ContactoTipo, @ContactoCursor, ISNULL(@RFC,'')
    END  

    IF @Telefonos IS NOT NULL AND @IncluirTelefono = 1
    BEGIN
      SET @Contador = @Contador + 1        
      INSERT ContactoDireccion (Estacion,  ID,        ContactoTipo,  Contacto,        Direccion)
                        SELECT  @Estacion, @Contador, @ContactoTipo, @ContactoCursor, ISNULL(@Telefonos,'')
    END  

    FETCH NEXT FROM crContacto INTO @ContactoCursor, @Nombre, @ContactoRegistro, @Direccion, @DireccionNumero, @DireccionNumeroInt, @EntreCalles, @Colonia, @Delegacion, @Poblacion, @Estado, @Pais, @CodigoPostal, @RFC, @Telefonos        

  END
  CLOSE crContacto
  DEALLOCATE crContacto
  
--  SELECT ID, ContactoTipo, Contacto, Direccion FROM ContactoDireccion WHERE Estacion = @Estacion
END
GO
--EXEC spContactoDireccion 1,'Cliente',NULL,NULL,1,1,1,1

/**************** spContactoDireccionHorizontal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContactoDireccionHorizontal') and type = 'P') drop procedure dbo.spContactoDireccionHorizontal
GO
CREATE PROCEDURE spContactoDireccionHorizontal
    @Estacion					int,
	@ContactoTipo				varchar(20), 
	@ContactoDesde				varchar(10),
	@ContactoHasta				varchar(10),
	@IncluirNombre				bit,		
	@IncluirContacto			bit,	
	@IncluirRFC					bit,
	@IncluirTelefono			bit
--//WITH ENCRYPTION
AS BEGIN 
  SET NOCOUNT ON
  DECLARE
    @ContactoCursor				varchar(10),
    @ContactoTipoCursor			varchar(20),
    @DireccionCursor			varchar(255),
    @ID							int,
    @ContactoCursor2				varchar(10)
    
  
  DELETE ContactoDireccionHorizontal WHERE Estacion = @Estacion  
  SET @ContactoDesde = NULLIF(NULLIF(NULLIF(@ContactoDesde,''),'(Todos)'),'(Todas)')
  SET @ContactoHasta = NULLIF(NULLIF(NULLIF(@ContactoHasta,''),'(Todos)'),'(Todas)')

  EXEC spContactoDireccion @Estacion, @ContactoTipo, @ContactoDesde, @ContactoHasta, @IncluirNombre, @IncluirContacto, @IncluirRFC, @IncluirTelefono

  INSERT ContactoDireccionHorizontal (Estacion, ContactoTipo, Contacto,   Direccion1) 
                              SELECT  Estacion, ContactoTipo, d.Contacto, d.Direccion
                                FROM  ContactoDireccion d
                               WHERE  d.ID = 1
                                 AND  Estacion = @Estacion

  UPDATE ContactoDireccionHorizontal SET Direccion2 = d.Direccion 
    FROM ContactoDireccionHorizontal r JOIN ContactoDireccion d 
      ON d.ContactoTipo = r.ContactoTipo AND d.Contacto = r.Contacto
   WHERE d.ID = 2 

  UPDATE ContactoDireccionHorizontal SET Direccion3 = d.Direccion 
    FROM ContactoDireccionHorizontal r JOIN ContactoDireccion d 
      ON d.ContactoTipo = r.ContactoTipo AND d.Contacto = r.Contacto
   WHERE d.ID = 3 

  UPDATE ContactoDireccionHorizontal SET Direccion4 = d.Direccion 
    FROM ContactoDireccionHorizontal r JOIN ContactoDireccion d 
      ON d.ContactoTipo = r.ContactoTipo AND d.Contacto = r.Contacto
   WHERE d.ID = 4 

  UPDATE ContactoDireccionHorizontal SET Direccion5 = d.Direccion 
    FROM ContactoDireccionHorizontal r JOIN ContactoDireccion d 
      ON d.ContactoTipo = r.ContactoTipo AND d.Contacto = r.Contacto
   WHERE d.ID = 5 

  UPDATE ContactoDireccionHorizontal SET Direccion6 = d.Direccion 
    FROM ContactoDireccionHorizontal r JOIN ContactoDireccion d 
      ON d.ContactoTipo = r.ContactoTipo AND d.Contacto = r.Contacto
   WHERE d.ID = 6

  UPDATE ContactoDireccionHorizontal SET Direccion7 = d.Direccion 
    FROM ContactoDireccionHorizontal r JOIN ContactoDireccion d 
      ON d.ContactoTipo = r.ContactoTipo AND d.Contacto = r.Contacto
   WHERE d.ID = 7

  UPDATE ContactoDireccionHorizontal SET Direccion8 = d.Direccion 
    FROM ContactoDireccionHorizontal r JOIN ContactoDireccion d 
      ON d.ContactoTipo = r.ContactoTipo AND d.Contacto = r.Contacto
   WHERE d.ID = 8

--  SELECT * FROM ContactoDireccionHorizontal
END
GO
--EXEC spContactoDireccionHorizontal 1, 'Cliente', NULL, NULL, 1, 1, 1, 0

/*************** spInformeGenerarEstadoCuenta ****************/					
if exists (select * from sysobjects where id = object_id('dbo.spInformeGenerarEstadoCuenta') and type = 'P') drop procedure dbo.spInformeGenerarEstadoCuenta
GO
CREATE PROCEDURE spInformeGenerarEstadoCuenta
		    @Estacion			int,
		    @Empresa			varchar(5),
		    @Modulo				varchar(5),
		    @FechaD				datetime,
		    @Cuenta				char(10),
		    @Sucursal			int,
		    @EstatusEspecifico	varchar(15) = NULL,
            @GraficarTipo		varchar(30)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Graficar			int,
    @Moneda				varchar(30),
    @SaldoDescripcion	varchar(50),
    @SaldoImporte		float,
    @Dividir			int
    
  EXEC spExtraerFecha @FechaD OUTPUT
  IF @Cuenta = '0' SELECT @Cuenta = NULL
  IF @Sucursal = -1 SELECT @Sucursal = NULL
  SELECT @EstatusEspecifico = NULLIF(RTRIM(@EstatusEspecifico), '')
  IF @EstatusEspecifico = '0' SELECT @EstatusEspecifico = NULL

  DELETE EstadoCuenta WHERE Estacion = @Estacion AND Modulo = @Modulo
  IF @Modulo = 'CXC' 
  BEGIN

    --Efectivo
    INSERT EstadoCuenta (Empresa,  Estacion,  Modulo,  Cuenta,    Grafica,   SaldoDescripcion, SaldoImporte,                            Moneda) 
                 SELECT  @Empresa, @Estacion, @Modulo, c.Cliente, 1,         'Saldo a Favor',       ISNULL(SUM(0.0-ISNULL(c.Efectivo,0.0)),0.0), c.Moneda
                   FROM CxcCuentaCorriente c JOIN Cte
                     ON Cte.Cliente = c.Cliente
                  WHERE c.Empresa = @Empresa 
                    AND c.Cliente = ISNULL(@Cuenta, c.Cliente)
                    --AND ISNULL(Cte.SucursalEmpresa, -1) = ISNULL(ISNULL(@Sucursal, Cte.SucursalEmpresa), -1)
                  GROUP BY c.Cliente, c.Moneda

    --Consumos
    INSERT EstadoCuenta (Empresa,  Estacion,  Modulo,  Cuenta,    Grafica,   SaldoDescripcion, SaldoImporte,                            Moneda) 
                 SELECT  @Empresa, @Estacion, @Modulo, c.Cliente, 1,         'Consumos Pendientes',       ISNULL(SUM(ISNULL(c.Consumos,0.0)),0.0), c.Moneda
                   FROM CxcCuentaCorriente c JOIN Cte
                     ON Cte.Cliente = c.Cliente
                  WHERE c.Empresa = @Empresa 
                    AND c.Cliente = ISNULL(@Cuenta, c.Cliente)
                    --AND ISNULL(Cte.SucursalEmpresa, -1) = ISNULL(ISNULL(@Sucursal, Cte.SucursalEmpresa), -1)
                  GROUP BY c.Cliente, c.Moneda

    --Vales
    INSERT EstadoCuenta (Empresa,  Estacion,  Modulo,  Cuenta,    Grafica,   SaldoDescripcion, SaldoImporte,                         Moneda) 
                 SELECT  @Empresa, @Estacion, @Modulo, c.Cliente, 1,         'Vales en Circulación',          ISNULL(SUM(ISNULL(c.Vales,0.0)),0.0), c.Moneda
                   FROM CxcCuentaCorriente c JOIN Cte
                     ON Cte.Cliente = c.Cliente
                  WHERE c.Empresa = @Empresa 
                    AND c.Cliente = ISNULL(@Cuenta, c.Cliente)
                    --AND ISNULL(Cte.SucursalEmpresa, -1) = ISNULL(ISNULL(@Sucursal, Cte.SucursalEmpresa), -1)
                  GROUP BY c.Cliente, c.Moneda

    --Redondeo
    INSERT EstadoCuenta (Empresa,  Estacion,  Modulo,  Cuenta,    Grafica,   SaldoDescripcion, SaldoImporte,                            Moneda) 
                 SELECT  @Empresa, @Estacion, @Modulo, c.Cliente, 1,         'Redondeo',       ISNULL(SUM(ISNULL(c.Redondeo,0.0)),0.0), c.Moneda
                   FROM CxcCuentaCorriente c JOIN Cte
                     ON Cte.Cliente = c.Cliente
                  WHERE c.Empresa = @Empresa 
                    AND c.Cliente = ISNULL(@Cuenta, c.Cliente)
                    --AND ISNULL(Cte.SucursalEmpresa, -1) = ISNULL(ISNULL(@Sucursal, Cte.SucursalEmpresa), -1)
                  GROUP BY c.Cliente, c.Moneda

    --Documentos
    INSERT EstadoCuenta (Empresa,  Estacion,  Modulo,  Cuenta,   Grafica, SaldoDescripcion, SaldoImporte,                                             Moneda) 
                  SELECT @Empresa, @Estacion, @Modulo, a.Cuenta, 1,       c.Mov,            ISNULL(SUM(ISNULL(a.Cargo,0.0)-ISNULL(a.Abono,0.0)),0.0), a.Moneda
      FROM Auxiliar a, Cxc c, Cxc ca, MovTipo mt, Cte
     WHERE a.Empresa  = @Empresa AND a.Rama = @Modulo
       AND a.Aplica   = ca.Mov
       AND a.AplicaID = ca.MovID
       AND a.ModuloID = c.ID AND a.Modulo = 'CXC'
       AND c.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
       AND c.Empresa  = a.Empresa
       AND a.Cuenta = ISNULL(@Cuenta, a.Cuenta)
       AND c.Cliente = cte.Cliente
       --AND ISNULL(a.Sucursal, -1) = ISNULL(ISNULL(@Sucursal, a.Sucursal), -1)
       AND ca.Empresa = c.Empresa
       AND ca.Mov = mt.Mov AND mt.Clave IN ('CXC.A', 'CXC.AR', 'CXC.F', 'CXC.FAC', 'CXC.FA', 'CXC.D', 'CXC.DM', 'CXC.DA', 'CXC.DP', 'CXC.NC', 'CXC.DAC', 'CXC.NCD','CXC.NCF', 'CXC.DV', 'CXC.NCP', 'CXC.CA', 'CXC.CAD', 'CXC.CAP','CXC.CD', 'CXC.RM', 'CXC.IM', 'CXC.SD', 'CXC.SCH') 
	   --OR (mt.Clave IN ('CXC.SD', 'CXC.SCH') AND ca.Estatus = 'PENDIENTE')
       AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaD))
       AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END
     GROUP BY a.Cuenta, a.Moneda, c.Mov  

    INSERT EstadoCuenta (Empresa, Estacion, Modulo, Cuenta, Moneda, AuxiliarID, ModuloID) 
    SELECT @Empresa, @Estacion, @Modulo, a.Cuenta, a.Moneda, a.ID, a.ModuloID
      FROM Auxiliar a, Cxc c, Cxc ca, MovTipo mt, Cte
     WHERE a.Empresa  = @Empresa AND a.Rama = @Modulo
       AND a.Aplica   = ca.Mov
       AND a.AplicaID = ca.MovID
       AND a.ModuloID = c.ID AND a.Modulo = 'CXC'
       AND c.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
       AND c.Empresa  = a.Empresa
--       AND c.Cliente = ISNULL(@Cuenta, c.Cliente)
       AND a.Cuenta = ISNULL(@Cuenta, a.Cuenta)
       AND c.Cliente = cte.Cliente
       --AND ISNULL(a.Sucursal, -1) = ISNULL(ISNULL(@Sucursal, a.Sucursal), -1)
       AND ca.Empresa = c.Empresa
       AND ca.Mov = mt.Mov AND mt.Clave IN ('CXC.A', 'CXC.AR', 'CXC.F', 'CXC.FAC', 'CXC.FA', 'CXC.D', 'CXC.DM', 'CXC.DA', 'CXC.DP', 'CXC.NC', 'CXC.DAC', 'CXC.NCD','CXC.NCF', 'CXC.DV', 'CXC.NCP', 'CXC.CA', 'CXC.CAD', 'CXC.CAP','CXC.CD', 'CXC.RM', 'CXC.IM', 'CXC.SD', 'CXC.SCH') 
	   --OR (mt.Clave IN ('CXC.SD', 'CXC.SCH') AND ca.Estatus = 'PENDIENTE')
       AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaD))
       AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END       
     ORDER BY a.Moneda, a.Cuenta, a.Aplica, a.AplicaID, a.ID

    INSERT EstadoCuenta (Empresa, Estacion, Modulo, Cuenta, Moneda, AuxiliarID, ModuloID) 
    SELECT @Empresa, @Estacion, @Modulo, a.Cuenta, a.Moneda, a.ID, a.ModuloID
      FROM Auxiliar a, Dinero c, Dinero ca, MovTipo mt, Cte
     WHERE a.Empresa  = @Empresa AND a.Rama = @Modulo
       AND a.Aplica   = ca.Mov
       AND a.AplicaID = ca.MovID
       AND a.ModuloID = c.ID AND a.Modulo = 'DIN'
       AND c.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
       AND c.Empresa  = a.Empresa
       AND a.Cuenta = ISNULL(@Cuenta, a.Cuenta)
       AND a.Cuenta = cte.Cliente
       --AND ISNULL(cte.SucursalEmpresa, -1) = ISNULL(ISNULL(@Sucursal, cte.SucursalEmpresa), -1)
       AND ca.Empresa = c.Empresa
       AND ca.Mov = mt.Mov AND mt.Clave IN ('DIN.SD','DIN.D','DIN.CH','DIN.SCH') 
       AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaD))
       AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END
     ORDER BY a.Moneda, a.Cuenta, a.Aplica, a.AplicaID, a.ID          
  END ELSE
  IF @Modulo = 'CXP'
  BEGIN

    --Efectivo
    INSERT EstadoCuenta (Empresa,  Estacion,  Modulo,  Cuenta,    Grafica, SaldoDescripcion, SaldoImporte,                          Moneda) 
                 SELECT  @Empresa, @Estacion, @Modulo, Proveedor, 1,       'Saldo a Favor',       ISNULL(SUM(ISNULL(Efectivo,0.0)),0.0), Moneda
                   FROM CxpCuentaCorriente
                  WHERE Empresa = @Empresa 
                    AND Proveedor = ISNULL(@Cuenta, Proveedor)
                  GROUP BY Proveedor, Moneda

    --Vales
    INSERT EstadoCuenta (Empresa,  Estacion,  Modulo,  Cuenta,    Grafica, SaldoDescripcion, SaldoImporte, Moneda) 
                 SELECT  @Empresa, @Estacion, @Modulo, Proveedor, 1,       'Vales en Circulación',          ISNULL(SUM(ISNULL(Vales,0.0)),0.0),   Moneda
                   FROM CxpCuentaCorriente
                  WHERE Empresa = @Empresa 
                    AND Proveedor = ISNULL(@Cuenta, Proveedor)
                  GROUP BY Proveedor, Moneda

    --Redondeo
    INSERT EstadoCuenta (Empresa,  Estacion,  Modulo,  Cuenta,    Grafica, SaldoDescripcion, SaldoImporte,  Moneda) 
                 SELECT  @Empresa, @Estacion, @Modulo, Proveedor, 1,       'Redondeo',       ISNULL(SUM(ISNULL(Redondeo,0.0)),0.0), Moneda
                   FROM CxpCuentaCorriente
                  WHERE Empresa = @Empresa 
                    AND Proveedor = ISNULL(@Cuenta, Proveedor)
                  GROUP BY Proveedor, Moneda

    INSERT EstadoCuenta (Empresa,  Estacion,  Modulo,  Cuenta,   Grafica, SaldoDescripcion, SaldoImporte,                                             Moneda) 
                  SELECT @Empresa, @Estacion, @Modulo, a.Cuenta, 1,       c.Mov,            ISNULL(SUM(ISNULL(a.Cargo,0.0)-ISNULL(a.Abono,0.0)),0.0), a.Moneda
      FROM Auxiliar a, Cxp c, Cxp ca, MovTipo mt
     WHERE a.Empresa  = @Empresa AND Rama = @Modulo
       AND a.Aplica   = ca.Mov
       AND a.AplicaID = ca.MovID
       AND a.ModuloID = c.ID AND a.Modulo = 'CXP'
       AND c.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
       AND c.Empresa  = a.Empresa
       AND ca.Empresa = c.Empresa
       AND ca.Proveedor = CASE WHEN @Cuenta IS NULL THEN ca.Proveedor ELSE @Cuenta END
       AND ca.Mov = mt.Mov AND mt.Clave IN ('CXP.A', 'CXP.F', 'CXP.D', 'CXP.DM', 'CXP.PAG', 'CXP.DA', 'CXP.DP', 'CXP.NC', 'CXP.DAC', 'CXP.NCD','CXP.NCF', 'CXP.NCP', 'CXP.CA', 'CXP.CAD', 'CXP.CAP','CXP.CD', 'CXP.FAC', 'CXP.SD', 'CXP.SCH') 
	   --OR (mt.Clave IN ('CXP.SD', 'CXP.SCH') AND ca.Estatus = 'PENDIENTE')
       AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaD))
       AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END
     GROUP BY a.Cuenta, a.Moneda, c.Mov         

    INSERT EstadoCuenta (Empresa, Estacion, Modulo, Cuenta, Moneda, AuxiliarID, ModuloID) 
    SELECT @Empresa, @Estacion, @Modulo, a.Cuenta, a.Moneda, a.ID, a.ModuloID
      FROM Auxiliar a, Cxp c, Cxp ca, MovTipo mt
     WHERE a.Empresa  = @Empresa AND Rama = @Modulo
       AND a.Aplica   = ca.Mov
       AND a.AplicaID = ca.MovID
       AND a.ModuloID = c.ID AND a.Modulo = 'CXP'
       AND c.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
       AND c.Empresa  = a.Empresa
       AND ca.Empresa = c.Empresa
       AND ca.Proveedor = CASE WHEN @Cuenta IS NULL THEN ca.Proveedor ELSE @Cuenta END
       AND ca.Mov = mt.Mov AND mt.Clave IN ('CXP.A', 'CXP.F', 'CXP.D', 'CXP.DM', 'CXP.PAG', 'CXP.DA', 'CXP.DP', 'CXP.NC', 'CXP.DAC', 'CXP.NCD','CXP.NCF', 'CXP.NCP', 'CXP.CA', 'CXP.CAD', 'CXP.CAP','CXP.CD', 'CXP.FAC', 'CXP.SD', 'CXP.SCH') 
	   --OR (mt.Clave IN ('CXP.SD', 'CXP.SCH') AND ca.Estatus = 'PENDIENTE')
       AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaD))
       AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END
     ORDER BY a.Moneda, a.Cuenta, a.Aplica, a.AplicaID, a.ID

    INSERT EstadoCuenta (Empresa, Estacion, Modulo, Cuenta, Moneda, AuxiliarID, ModuloID) 
    SELECT @Empresa, @Estacion, @Modulo, a.Cuenta, a.Moneda, a.ID, a.ModuloID
      FROM Auxiliar a, Dinero c, Dinero ca, MovTipo mt, Prov
     WHERE a.Empresa  = @Empresa AND a.Rama = @Modulo
       AND a.Aplica   = ca.Mov
       AND a.AplicaID = ca.MovID
       AND a.ModuloID = c.ID AND a.Modulo = 'DIN'
       AND c.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
       AND c.Empresa  = a.Empresa
       AND a.Cuenta = ISNULL(@Cuenta, a.Cuenta)
       AND a.Cuenta = Prov.Proveedor
       --AND ISNULL(cte.SucursalEmpresa, -1) = ISNULL(ISNULL(@Sucursal, cte.SucursalEmpresa), -1)
       AND ca.Empresa = c.Empresa
       AND ca.Mov = mt.Mov AND mt.Clave IN ('DIN.SD','DIN.D','DIN.CH','DIN.SCH') 
       AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaD))
       AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END
     ORDER BY a.Moneda, a.Cuenta, a.Aplica, a.AplicaID, a.ID     
   END


   DECLARE crTotales CURSOR FAST_FORWARD FOR
   SELECT Moneda, Cuenta, SaldoDescripcion, SaldoImporte
     FROM EstadoCuenta
    WHERE Estacion = @Estacion
      AND Grafica = 1
      AND SaldoDescripcion IN('Saldo a Favor', 'Vales en Circulación', 'Redondeo', 'Consumos Pendientes')
      AND SaldoImporte > 0
    GROUP BY Moneda, Cuenta, SaldoDescripcion, SaldoImporte

   OPEN crTotales
   FETCH NEXT FROM crTotales INTO @Moneda, @Cuenta, @SaldoDescripcion, @SaldoImporte
   WHILE @@FETCH_STATUS = 0
   BEGIN

      SELECT @Dividir = COUNT(*) FROM EstadoCuenta WHERE Estacion = @Estacion AND Grafica = 0 AND Cuenta = @Cuenta AND Moneda = @Moneda
      SELECT @SaldoImporte = @SaldoImporte / dbo.fnEvitarDivisionCero(@Dividir)
      
      IF @SaldoDescripcion = 'Saldo a Favor'
      BEGIN
        UPDATE EstadoCuenta 
           SET Efectivo = @SaldoImporte
         WHERE Estacion = @Estacion
           AND Grafica = 0
           AND Cuenta = @Cuenta
           AND Moneda = @Moneda
        IF @@ROWCOUNT = 0
          INSERT EstadoCuenta (Empresa, Estacion, Modulo, Cuenta, Moneda, AuxiliarID, ModuloID, Efectivo, SaldoDescripcion) 
          SELECT @Empresa, @Estacion, @Modulo, @Cuenta, @Moneda, '', '', @SaldoImporte, @SaldoDescripcion
      END
      ELSE
      IF @SaldoDescripcion = 'Vales en Circulación'
      BEGIN
        UPDATE EstadoCuenta 
           SET Vales = @SaldoImporte
         WHERE Estacion = @Estacion
           AND Grafica = 0
           AND Cuenta = @Cuenta
           AND Moneda = @Moneda
        IF @@ROWCOUNT = 0
          INSERT EstadoCuenta (Empresa, Estacion, Modulo, Cuenta, Moneda, AuxiliarID, ModuloID, Vales, SaldoDescripcion) 
          SELECT @Empresa, @Estacion, @Modulo, @Cuenta, @Moneda, '', '', @SaldoImporte, @SaldoDescripcion
      END
      ELSE
      IF @SaldoDescripcion = 'Redondeo'
      BEGIN
        UPDATE EstadoCuenta 
           SET Redondeo = @SaldoImporte
         WHERE Estacion = @Estacion
           AND Grafica = 0
           AND Cuenta = @Cuenta
           AND Moneda = @Moneda
        IF @@ROWCOUNT = 0
          INSERT EstadoCuenta (Empresa, Estacion, Modulo, Cuenta, Moneda, AuxiliarID, ModuloID, Redondeo, SaldoDescripcion) 
          SELECT @Empresa, @Estacion, @Modulo, @Cuenta, @Moneda, '', '', @SaldoImporte, @SaldoDescripcion
      END
      ELSE
      IF @SaldoDescripcion = 'Consumos Pendientes'
      BEGIN
        UPDATE EstadoCuenta 
           SET Consumos = @SaldoImporte
         WHERE Estacion = @Estacion
           AND Grafica = 0
           AND Cuenta = @Cuenta
           AND Moneda = @Moneda
        IF @@ROWCOUNT = 0
          INSERT EstadoCuenta (Empresa, Estacion, Modulo, Cuenta, Moneda, AuxiliarID, ModuloID, Consumos, SaldoDescripcion) 
          SELECT @Empresa, @Estacion, @Modulo, @Cuenta, @Moneda, '', '', @SaldoImporte, @SaldoDescripcion
      END
    FETCH NEXT FROM crTotales INTO @Moneda, @Cuenta, @SaldoDescripcion, @SaldoImporte
  END
  CLOSE crTotales
  DEALLOCATE crTotales

        UPDATE EstadoCuenta 
           SET Efectivo = 0.00,
               Vales = 0.00,
               Redondeo = 0.00,
               Consumos = 0.00
         WHERE Estacion = @Estacion
           AND Grafica = 1
   
   DECLARE crGraficar CURSOR FAST_FORWARD FOR
   SELECT Moneda, Cuenta
     FROM EstadoCuenta
    WHERE Estacion = @Estacion
      AND Grafica = 1
    GROUP BY Moneda, Cuenta

   OPEN crGraficar
   FETCH NEXT FROM crGraficar INTO @Moneda, @Cuenta
   WHILE @@FETCH_STATUS = 0
   BEGIN
  
     SELECT @Graficar = NULL
     SELECT @Graficar = ISNULL(COUNT(DISTINCT SaldoDescripcion),0)
       FROM EstadoCuenta
      WHERE Estacion = @Estacion
        AND Modulo = @Modulo
        AND Grafica = 1
        AND Moneda = @Moneda
        AND Cuenta = @Cuenta

--SELECT @Graficar, @GraficarTipo, @Moneda, @Cuenta

     IF @GraficarTipo = 'Mas Sobresalientes' AND @Graficar > 5
       DELETE EstadoCuenta 
        WHERE SaldoDescripcion NOT IN(
       SELECT  TOP 5 SaldoDescripcion
         FROM
         (
         SELECT
             'SaldoDescripcion'  = SaldoDescripcion,
             'SaldoImporte'      = SUM(SaldoImporte)
     
           FROM EstadoCuenta
          WHERE Estacion = @Estacion
            AND Modulo = @Modulo
            AND Grafica = 1
            AND Moneda = @Moneda
            AND Cuenta = @Cuenta
           GROUP BY Moneda, SaldoDescripcion
         ) AS x
        GROUP BY x.SaldoDescripcion
        ORDER BY SUM(ISNULL(x.SaldoImporte,0.00))DESC)
          AND Estacion = @Estacion
          AND Modulo = @Modulo
          AND Grafica = 1
          AND Moneda = @Moneda
          AND Cuenta = @Cuenta

     IF @GraficarTipo = 'Menos Sobresalientes' AND @Graficar > 5
       DELETE EstadoCuenta 
        WHERE SaldoDescripcion NOT IN(
       SELECT  TOP 5 SaldoDescripcion
         FROM
         (
         SELECT
             'SaldoDescripcion'  = SaldoDescripcion,
             'SaldoImporte'      = SUM(SaldoImporte)
     
           FROM EstadoCuenta
          WHERE Estacion = @Estacion
            AND Modulo = @Modulo
            AND Grafica = 1
            AND Moneda = @Moneda
            AND Cuenta = @Cuenta
           GROUP BY Moneda, SaldoDescripcion
         ) AS x
        GROUP BY x.SaldoDescripcion
        ORDER BY SUM(ISNULL(x.SaldoImporte,0.00))ASC)
          AND Estacion = @Estacion
          AND Modulo = @Modulo
          AND Grafica = 1
          AND Moneda = @Moneda
          AND Cuenta = @Cuenta

    FETCH NEXT FROM crGraficar INTO @Moneda, @Cuenta
  END
  CLOSE crGraficar
  DEALLOCATE crGraficar

END
GO

/******************************* spInformeCXCEstadoCuenta *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spInformeCXCEstadoCuenta') and type = 'P') drop procedure dbo.spInformeCXCEstadoCuenta
GO             
CREATE PROCEDURE spInformeCXCEstadoCuenta
		@EstacionTrabajo		int

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa				varchar(5),
    @Modulo					varchar(5),
    @FechaD					datetime,
    @Cuenta					varchar(10),
    @Sucursal				int,
    @Moneda					varchar(10),
    @EstatusEspecifico		varchar(15),
    @Etiqueta				bit,
    @GraficarTipo			varchar(30),
    @VerGraficaDetalle		bit

  SELECT
    @Empresa           =          InfoEmpresa,
    @Modulo            =          LTRIM(RTRIM(InfoModulo)),
    @FechaD            =          InfoFechaD,
    @Cuenta            =          NULLIF(NULLIF(InfoCliente,'(Todos)'),''),
    @Sucursal          =          ISNULL(InfoSucursal,-1),
    --BUG14906
    @EstatusEspecifico = CASE 
                           WHEN InfoEstatusEspecifico = 'Pendientes' THEN 'PENDIENTE'
                           WHEN InfoEstatusEspecifico = 'Concluidos' THEN 'CONCLUIDO'
                           ELSE NULL
                         END,
    @Moneda            = CASE WHEN InfoMoneda IN('(Todas)','') THEN NULL ELSE InfoMoneda END,
    @Etiqueta		   = ISNULL(InfoEtiqueta,0),
    @GraficarTipo	   = ISNULL(InformeGraficarTipo,  '(Todos)'),
    @VerGraficaDetalle = ISNULL(VerGraficaDetalle,0)
    FROM RepParam
   WHERE Estacion = @EstacionTrabajo 
   
  EXEC spInformeGenerarEstadoCuenta @EstacionTrabajo, @Empresa, @Modulo, @FechaD, @Cuenta, @Sucursal, @EstatusEspecifico, @GraficarTipo
  
  SELECT
    Empresa.Nombre EmpresaNombre,
    EstadoCuenta.ID,
    EstadoCuenta.Estacion,
    EstadoCuenta.AuxiliarID,
    EstadoCuenta.ModuloID,
    LTRIM(RTRIM(EstadoCuenta.Modulo)) Modulo,
    EstadoCuenta.Cuenta,
    EstadoCuenta.Moneda,
    EstadoCuenta.Efectivo,
    EstadoCuenta.Consumos,
    EstadoCuenta.Vales,
    EstadoCuenta.Redondeo,
    EstadoCuenta.ClienteEnviarA,
    EstadoCuenta.Grafica,
    EstadoCuenta.SaldoDescripcion,
    EstadoCuenta.SaldoImporte,
    Auxiliar.ID,
    Auxiliar.Empresa,
    Auxiliar.Rama,
    Auxiliar.Cuenta,
    Auxiliar.SubCuenta,
    Auxiliar.Ejercicio,
    Auxiliar.Periodo,
    Auxiliar.Fecha,
    Auxiliar.Grupo,
    Auxiliar.Modulo,
    Auxiliar.ModuloID,
    Auxiliar.Mov,
    Auxiliar.MovID,
    Auxiliar.Cargo,
    Auxiliar.Abono,
    Auxiliar.Aplica,
    Auxiliar.AplicaID,
    Auxiliar.Acumulado,
    Auxiliar.Conciliado,
    Auxiliar.EsCancelacion,
    Auxiliar.Moneda,
    Auxiliar.TipoCambio,
    Auxiliar.FechaConciliacion,
    Auxiliar.Sucursal,
    Cte.Cliente,
    Cte.Nombre,
    Cte.NombreCorto,
    Cte.Numero,
    Cte.Tipo,
    Cte.Direccion,
    Cte.EntreCalles,
    Cte.Plano,
    Cte.Observaciones,
    Cte.Colonia,
    Cte.CodigoPostal,
    Cte.Poblacion,
    Cte.Estado,
    Cte.Pais,
    Cte.Zona,
    Cte.RFC,
    Cte.Telefonos,
    Cte.Fax,
    Cte.PedirTono,
    Cte.Contacto1,
    Cte.Contacto2,
    Cte.eMail1,
    Cte.eMail2,
    Cte.DirInternet,
    Cte.Categoria,
    Cte.Familia,
    Cte.Credito,
    Cte.Grupo,
    Cte.DiaRevision1,
    Cte.DiaRevision2,
    Cte.HorarioRevision,
    Cte.DiaPago1,
    Cte.DiaPago2,
    Cte.HorarioPago,
    Cte.ZonaImpuesto,
    Cte.PedidosParciales,
    Cte.Clase,
    Cte.Estatus,
    Cte.UltimoCambio,
    Cte.Alta,
    Cte.Conciliar,
    Cte.Descuento,
    Cte.Proyecto,
    Cte.Agente,
    Cte.AgenteServicio,
    Cte.EnviarA,
    Cte.FormaEnvio,
    Cte.Condicion,
    Cte.Ruta,
    Cte.ListaPrecios,
    Cte.DefMoneda,
    Cte.VtasConsignacion,
    Cte.AlmacenVtasConsignacion,
    Cte.Mensaje,
    Cte.Extencion1,
    Cte.Extencion2,
    Cte.CURP,
    @Etiqueta as Etiqueta,
    @VerGraficaDetalle as VerGraficaDetalle,
	@FechaD as FechaDesde,
	GETDATE() as FechaHasta,
	EmpresaCfg.ContMoneda,
    Auxiliar.Cargo * Auxiliar.TipoCambio CargoMC,
    Auxiliar.Abono * Auxiliar.TipoCambio AbonoMC,
    Mon.TipoCambio TipoCambioMon,
    EstadoCuenta.Efectivo * Mon.TipoCambio EfectivoMC,
    EstadoCuenta.Consumos * Mon.TipoCambio ConsumosMC,
    EstadoCuenta.Vales * Mon.TipoCambio ValesMC,
    EstadoCuenta.Redondeo * Mon.TipoCambio RedondeoMC
  FROM EstadoCuenta
  LEFT OUTER JOIN Auxiliar ON EstadoCuenta.AuxiliarID=Auxiliar.ID
  JOIN Cte ON EstadoCuenta.Cuenta=Cte.Cliente
  JOIN Empresa ON Empresa.Empresa = EstadoCuenta.Empresa
  JOIN EmpresaCfg ON EmpresaCfg.Empresa = Empresa.Empresa
  JOIN Mon on Mon.Moneda = EstadoCuenta.Moneda
 WHERE EstadoCuenta.Estacion= @EstacionTrabajo 
   AND EstadoCuenta.Modulo = 'CXC'
   AND EstadoCuenta.Moneda = ISNULL(@Moneda,EstadoCuenta.Moneda) 

END
GO

--update repparam set InfoCliente = NULL, InfoSucursal = null, InfoModulo = 'CXC', InfoMoneda = '(Todas)' WHERE Estacion = 1
--select * from repparam
--exec spInformeCxcEstadoCuenta 1

/******************************* spInformeCXPEstadoCuenta *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spInformeCXPEstadoCuenta') and type = 'P') drop procedure dbo.spInformeCXPEstadoCuenta
GO             
CREATE PROCEDURE spInformeCXPEstadoCuenta
		@EstacionTrabajo		int

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa				varchar(5),
    @Modulo					varchar(5),
    @FechaD					datetime,
    @Cuenta					varchar(10),
    @Sucursal				int,
    @Moneda					varchar(10),
    @EstatusEspecifico		varchar(15),
    @Etiqueta				bit,
    @GraficarTipo			varchar(30),
    @VerGraficaDetalle		bit
      
  SELECT
    @Empresa           =          InfoEmpresa,
    @Modulo            =          LTRIM(RTRIM(InfoModulo)),
    @FechaD            =          InfoFechaD,
    @Cuenta            =          NULLIF(NULLIF(InfoProveedor,'(Todos)'),''),
    @Sucursal          =          ISNULL(InfoSucursal,-1),
    --BUG14906
    @EstatusEspecifico = CASE 
                           WHEN InfoEstatusEspecifico = 'Pendientes' THEN 'PENDIENTE'
                           WHEN InfoEstatusEspecifico = 'Concluidos' THEN 'CONCLUIDO'
                           ELSE NULL
                         END,
    @Moneda            = CASE WHEN InfoMoneda = '(Todas)' THEN NULL ELSE InfoMoneda END,
    @Etiqueta		   = ISNULL(InfoEtiqueta,0),
    @GraficarTipo	   = ISNULL(InformeGraficarTipo,  '(Todos)'),
    @VerGraficaDetalle = ISNULL(VerGraficaDetalle,0)
    FROM RepParam
   WHERE Estacion = @EstacionTrabajo 

  EXEC spInformeGenerarEstadoCuenta @EstacionTrabajo, @Empresa, @Modulo, @FechaD, @Cuenta, @Sucursal, @EstatusEspecifico, @GraficarTipo

  SELECT
    Empresa.Nombre EmpresaNombre,
    EstadoCuenta.ID,
    EstadoCuenta.Estacion,
    EstadoCuenta.AuxiliarID,
    EstadoCuenta.ModuloID,
    LTRIM(RTRIM(EstadoCuenta.Modulo)) Modulo,
    EstadoCuenta.Cuenta,
    EstadoCuenta.Moneda,
    EstadoCuenta.Efectivo,
    EstadoCuenta.Consumos,
    EstadoCuenta.Vales,
    EstadoCuenta.Redondeo,
    EstadoCuenta.ClienteEnviarA,
    EstadoCuenta.Grafica,
    EstadoCuenta.SaldoDescripcion,
    EstadoCuenta.SaldoImporte,
    Auxiliar.ID,
    Auxiliar.Empresa,
    Auxiliar.Rama,
    Auxiliar.Cuenta,
    Auxiliar.SubCuenta,
    Auxiliar.Ejercicio,
    Auxiliar.Periodo,
    Auxiliar.Fecha,
    Auxiliar.Grupo,
    Auxiliar.Modulo,
    Auxiliar.ModuloID,
    Auxiliar.Mov,
    Auxiliar.MovID,
    Auxiliar.Cargo,
    Auxiliar.Abono,
    Auxiliar.Aplica,
    Auxiliar.AplicaID,
    Auxiliar.Acumulado,
    Auxiliar.Conciliado,
    Auxiliar.EsCancelacion,
    Auxiliar.Moneda,
    Auxiliar.TipoCambio,
    Auxiliar.FechaConciliacion,
    Auxiliar.Sucursal,
    Prov.Proveedor,
    Prov.Nombre,
    Prov.NombreCorto,
    Prov.Tipo,
    Prov.Direccion,
    Prov.EntreCalles,
    Prov.Plano,
    Prov.Observaciones,
    Prov.Colonia,
    Prov.CodigoPostal,
    Prov.Poblacion,
    Prov.Estado,
    Prov.Pais,
    Prov.Zona,
    Prov.RFC,
    Prov.Telefonos,
    Prov.Fax,
    Prov.PedirTono,
    Prov.Contacto1,
    Prov.Contacto2,
    Prov.eMail1,
    Prov.eMail2,
    Prov.DirInternet,
    Prov.Categoria,
    Prov.Familia,
    Prov.DiaRevision1,
    Prov.DiaRevision2,
    Prov.HorarioRevision,
    Prov.DiaPago1,
    Prov.DiaPago2,
    Prov.HorarioPago,
    Prov.ZonaImpuesto,
    Prov.Clase,
    Prov.Estatus,
    Prov.UltimoCambio,
    Prov.Alta,
    Prov.Conciliar,
    Prov.Descuento,
    Prov.Proyecto,
    Prov.Agente,
    Prov.FormaEnvio,
    Prov.Condicion,
    Prov.Ruta,
    Prov.DefMoneda,
    Prov.Mensaje,
    Prov.Extencion1,
    Prov.Extencion2,
    Prov.CURP,
    @Etiqueta as Etiqueta,
    @VerGraficaDetalle as VerGraficaDetalle,
	@FechaD as FechaDesde,
	GETDATE() as FechaHasta,
	EmpresaCfg.ContMoneda,
    Auxiliar.Cargo * Auxiliar.TipoCambio CargoMC,
    Auxiliar.Abono * Auxiliar.TipoCambio AbonoMC,
    Mon.TipoCambio TipoCambioMon,
    EstadoCuenta.Efectivo * Mon.TipoCambio EfectivoMC,
    EstadoCuenta.Consumos * Mon.TipoCambio ConsumosMC,
    EstadoCuenta.Vales * Mon.TipoCambio ValesMC,
    EstadoCuenta.Redondeo * Mon.TipoCambio RedondeoMC    
  FROM EstadoCuenta
  LEFT OUTER JOIN Auxiliar ON EstadoCuenta.AuxiliarID=Auxiliar.ID
  JOIN Prov ON EstadoCuenta.Cuenta=Prov.Proveedor
  JOIN Empresa ON Empresa.Empresa = EstadoCuenta.Empresa
  JOIN EmpresaCfg ON EmpresaCfg.Empresa = Empresa.Empresa
  JOIN Mon on Mon.Moneda = EstadoCuenta.Moneda
 WHERE EstadoCuenta.Estacion= @EstacionTrabajo 
   AND EstadoCuenta.Modulo = 'CXP'
   AND EstadoCuenta.Moneda = ISNULL(@Moneda,EstadoCuenta.Moneda) 

END
GO
/*
Direccion
CodigoPostal
Colonia
Poblacionn
Estado
Pais
RFC
*/

--exec spInformeCxpEstadoCuenta 1

/******************************* spInformeCXCAntiguedadSaldos *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spInformeCXCAntiguedadSaldos') and type = 'P') drop procedure dbo.spInformeCXCAntiguedadSaldos
GO             
CREATE PROCEDURE spInformeCXCAntiguedadSaldos
		(
		@EstacionTrabajo		int
		)
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE
    @Empresa				varchar(5),
    @ClienteD				varchar(10),
    @ClienteA				varchar(10),    
    @Moneda					varchar(10),
    @Hoy					datetime,
    @De01A15D				datetime,    
    @De01A15A				datetime,
    @De16A30D				datetime,    
    @De16A30A				datetime,
    @De31A60D				datetime,
    @De31A60A				datetime,
    @De61A90D				datetime,
    @De61A90A				datetime,
    @MasDe90				datetime,
    @Etiqueta				bit,
    @VerGraficaDetalle		bit,
    @InfoDesglosar			varchar(20)
      
  DECLARE @Datos TABLE
  (
   Estacion					int,
   Empresa					varchar(5) COLLATE DATABASE_DEFAULT NULL,
   EmpresaNombre			varchar(100) COLLATE DATABASE_DEFAULT NULL,
   Cliente					varchar(10) COLLATE DATABASE_DEFAULT NULL,
   ClienteNombre			varchar(100) COLLATE DATABASE_DEFAULT NULL,   
   Moneda					varchar(10) COLLATE DATABASE_DEFAULT NULL,
   MonedaContable			varchar(10) COLLATE DATABASE_DEFAULT NULL,   
   --BUG 16453
   Mov						varchar(21) COLLATE DATABASE_DEFAULT NULL,
   MovID					varchar(20) COLLATE DATABASE_DEFAULT NULL,
   Referencia				varchar(50) COLLATE DATABASE_DEFAULT NULL,   
   FechaEmision				datetime,
   Vencimiento				datetime,
   DiasMoratorios			int,
   AlCorriente				float,
   De01A15					float,  
   De16A30					float,     
   De31A60					float,        
   De61A90					float,           
   MasDe90					float,
   AlCorrienteMC			float,
   De01A15MC				float,  
   De16A30MC				float,     
   De31A60MC				float,        
   De61A90MC				float,           
   MasDe90MC				float,   
   GraficaArgumento			varchar(100) COLLATE DATABASE_DEFAULT NULL,   
   GraficaValor				float NULL,		
   Grafica					int NULL DEFAULT 0,
   InfoDesglosar			varchar(20) 
  )    

  DECLARE @Grafica TABLE
  (
   Estacion					int NULL,
   Empresa					varchar(5) COLLATE DATABASE_DEFAULT NULL,
   EmpresaNombre			varchar(100) COLLATE DATABASE_DEFAULT NULL,
   Cliente					varchar(10) COLLATE DATABASE_DEFAULT NULL,
   ClienteNombre			varchar(100) COLLATE DATABASE_DEFAULT NULL,   
   Moneda					varchar(10) COLLATE DATABASE_DEFAULT NULL,
   MonedaContable			varchar(10) COLLATE DATABASE_DEFAULT NULL,   
   Mov						varchar(20) COLLATE DATABASE_DEFAULT NULL,
   MovID					varchar(20) COLLATE DATABASE_DEFAULT NULL,
   Referencia				varchar(50) COLLATE DATABASE_DEFAULT NULL,   
   FechaEmision				datetime,
   Vencimiento				datetime,
   DiasMoratorios			int,
   AlCorriente				float,
   De01A15					float,  
   De16A30					float,     
   De31A60					float,        
   De61A90					float,           
   MasDe90					float,
   AlCorrienteMC			float,
   De01A15MC				float,  
   De16A30MC				float,     
   De31A60MC				float,        
   De61A90MC				float,           
   MasDe90MC				float,   
   GraficaArgumento			varchar(100) COLLATE DATABASE_DEFAULT NULL,   
   GraficaValor				float NULL,		   
   Grafica					int NULL DEFAULT 0
  )    
      
  SET @Hoy = GETDATE()    
  EXEC spExtraerFecha @Hoy OUTPUT    
    
  SET @De01A15D = DATEADD(day,-15,@Hoy)  
  SET @De01A15A = DATEADD(day,-1,@Hoy)
  
  SET @De16A30D = DATEADD(day,-30,@Hoy)  
  SET @De16A30A = DATEADD(day,-16,@Hoy)

  SET @De31A60D = DATEADD(day,-60,@Hoy)  
  SET @De31A60A = DATEADD(day,-31,@Hoy)
  
  SET @De61A90D = DATEADD(day,-90,@Hoy)  
  SET @De61A90A = DATEADD(day,-61,@Hoy)

  SET @MasDe90 = DATEADD(day,-91,@Hoy)  
  
  SELECT
    @Empresa           =    InfoEmpresa,
    @ClienteD          =    NULLIF(InfoClienteD,''),
    @ClienteA          =    NULLIF(InfoClienteA,''),
    @Moneda            =	CASE WHEN InfoMoneda IN( '(Todas)', '') THEN NULL ELSE InfoMoneda END,
    @Etiqueta		   =	ISNULL(InfoEtiqueta,0),
    @VerGraficaDetalle = ISNULL(VerGraficaDetalle,0),   
    @InfoDesglosar     =    ISNULL(InfoDesglosar,'No')
    FROM RepParam
   WHERE Estacion = @EstacionTrabajo 


  INSERT @Datos (Estacion, Empresa, EmpresaNombre, Cliente, ClienteNombre, Moneda, MonedaContable, Mov, MovID, Referencia, FechaEmision, Vencimiento, DiasMoratorios, AlCorriente, De01A15, De16A30, De31A60, De61A90, MasDe90, AlCorrienteMC, De01A15MC, De16A30MC, De31A60MC, De61A90MC, MasDe90MC, Grafica, InfoDesglosar)			
  SELECT
    @EstacionTrabajo,
    Empresa.Empresa,
    Empresa.Nombre, 
    CxcInfo.Cliente,
    Cte.Nombre,
    CxcInfo.Moneda,
    EmpresaCfg.ContMoneda,
    CxcInfo.Mov,
    CxcInfo.MovID,
    CxcInfo.Referencia,
    CxcInfo.FechaEmision,
    CxcInfo.Vencimiento,
--    CxcInfo.DiasMoratorios,
    ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN DATEDIFF(DAY, CxcInfo.Vencimiento, @Hoy) END,0),
--    CASE WHEN CxcInfo.Vencimiento >= @Hoy THEN CxcInfo.Saldo ELSE NULL END,
    CASE WHEN ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN DATEDIFF(DAY, CxcInfo.Vencimiento, @Hoy) END,0) <= 0 THEN CxcInfo.Saldo ELSE NULL END,
    CASE WHEN CxcInfo.Vencimiento BETWEEN @De01A15D AND @De01A15A AND ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN CxcInfo.DiasMoratorios END,0) > 0 THEN CxcInfo.Saldo ELSE NULL END,    
    CASE WHEN CxcInfo.Vencimiento BETWEEN @De16A30D AND @De16A30A AND ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN CxcInfo.DiasMoratorios END,0) > 0 THEN CxcInfo.Saldo ELSE NULL END,        
    CASE WHEN CxcInfo.Vencimiento BETWEEN @De31A60D AND @De31A60A AND ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN CxcInfo.DiasMoratorios END,0) > 0 THEN CxcInfo.Saldo ELSE NULL END,            
    CASE WHEN CxcInfo.Vencimiento BETWEEN @De61A90D AND @De61A90A AND ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN CxcInfo.DiasMoratorios END,0) > 0 THEN CxcInfo.Saldo ELSE NULL END,                
    CASE WHEN CxcInfo.Vencimiento <= @MasDe90 AND ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN CxcInfo.DiasMoratorios END,0) > 0 THEN CxcInfo.Saldo ELSE NULL END,

--    CASE WHEN CxcInfo.Vencimiento >= @Hoy THEN dbo.fnImporteAMonedaContable(CxcInfo.Saldo,Cxc.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,
    CASE WHEN ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN DATEDIFF(DAY, CxcInfo.Vencimiento, @Hoy) END,0) <= 0 THEN dbo.fnImporteAMonedaContable(CxcInfo.Saldo,Cxc.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,
    CASE WHEN CxcInfo.Vencimiento BETWEEN @De01A15D AND @De01A15A AND ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN CxcInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxcInfo.Saldo,Cxc.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,    
    CASE WHEN CxcInfo.Vencimiento BETWEEN @De16A30D AND @De16A30A AND ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN CxcInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxcInfo.Saldo,Cxc.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,        
    CASE WHEN CxcInfo.Vencimiento BETWEEN @De31A60D AND @De31A60A AND ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN CxcInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxcInfo.Saldo,Cxc.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,            
    CASE WHEN CxcInfo.Vencimiento BETWEEN @De61A90D AND @De61A90A AND ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN CxcInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxcInfo.Saldo,Cxc.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,                
    CASE WHEN CxcInfo.Vencimiento <= @MasDe90 AND ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN CxcInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxcInfo.Saldo,Cxc.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,
    0, @InfoDesglosar
    FROM CxcInfo JOIN Cte 
      ON CxcInfo.Cliente = Cte.Cliente LEFT OUTER JOIN Cxc
      ON Cxc.Empresa = CxcInfo.Empresa AND Cxc.Mov = CxcInfo.Mov AND Cxc.MovID = CxcInfo.MovID LEFT OUTER JOIN Empresa
      ON Empresa.Empresa = CxcInfo.Empresa JOIN EmpresaCfg
      ON EmpresaCfg.Empresa = Empresa.Empresa
   WHERE CxcInfo.Empresa = @Empresa 
     AND CxcInfo.Cliente BETWEEN @ClienteD AND @ClienteA
     AND CxcInfo.Moneda = ISNULL(@Moneda, CxcInfo.Moneda)
   ORDER BY CxcInfo.Cliente, CxcInfo.Moneda, CxcInfo.Mov, CxcInfo.Vencimiento DESC 

  --Graficas de Clientes Al Corriente
  INSERT @Grafica (Estacion, Empresa, EmpresaNombre, Cliente, ClienteNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica)			
  SELECT
    @EstacionTrabajo,
    Empresa.Empresa,
    Empresa.Nombre, 
    CxcInfo.Cliente,
    Cte.Nombre,
    EmpresaCfg.ContMoneda,
    'Al Corriente',
--    SUM(ISNULL(CASE WHEN CxcInfo.Vencimiento >= @Hoy THEN dbo.fnImporteAMonedaContable(CxcInfo.Saldo,Cxc.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,0.0)),
    SUM(ISNULL(CASE WHEN ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN DATEDIFF(DAY, CxcInfo.Vencimiento, @Hoy) END,0) <= 0 THEN dbo.fnImporteAMonedaContable(CxcInfo.Saldo,Cxc.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,0.00)),
    1
    FROM CxcInfo JOIN Cte 
      ON CxcInfo.Cliente = Cte.Cliente JOIN Cxc
      ON Cxc.Empresa = CxcInfo.Empresa AND Cxc.Mov = CxcInfo.Mov AND Cxc.MovID = CxcInfo.MovID JOIN Empresa
      ON Empresa.Empresa = CxcInfo.Empresa JOIN EmpresaCfg
      ON EmpresaCfg.Empresa = Empresa.Empresa
   WHERE CxcInfo.Empresa = @Empresa 
     AND CxcInfo.Cliente BETWEEN @ClienteD AND @ClienteA
     AND CxcInfo.Moneda = ISNULL(@Moneda, CxcInfo.Moneda)
   GROUP BY Empresa.Empresa, Empresa.Nombre, CxcInfo.Cliente, Cte.Nombre, EmpresaCfg.ContMoneda   

  --Graficas de Clientes de 1 a 15
  INSERT @Grafica (Estacion, Empresa, EmpresaNombre, Cliente, ClienteNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica)			
  SELECT
    @EstacionTrabajo,
    Empresa.Empresa,
    Empresa.Nombre, 
    CxcInfo.Cliente,
    Cte.Nombre,
    EmpresaCfg.ContMoneda,
    'de 1 a 15 días',
    SUM(ISNULL(CASE WHEN CxcInfo.Vencimiento BETWEEN @De01A15D AND @De01A15A AND ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN CxcInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxcInfo.Saldo,Cxc.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,0.0)),    
    1
    FROM CxcInfo JOIN Cte 
      ON CxcInfo.Cliente = Cte.Cliente JOIN Cxc
      ON Cxc.Empresa = CxcInfo.Empresa AND Cxc.Mov = CxcInfo.Mov AND Cxc.MovID = CxcInfo.MovID JOIN Empresa
      ON Empresa.Empresa = CxcInfo.Empresa JOIN EmpresaCfg
      ON EmpresaCfg.Empresa = Empresa.Empresa
   WHERE CxcInfo.Empresa = @Empresa 
     AND CxcInfo.Cliente BETWEEN @ClienteD AND @ClienteA
     AND CxcInfo.Moneda = ISNULL(@Moneda, CxcInfo.Moneda)
   GROUP BY Empresa.Empresa, Empresa.Nombre, CxcInfo.Cliente, Cte.Nombre, EmpresaCfg.ContMoneda   

  --Graficas de Clientes de 16 a 30
  INSERT @Grafica (Estacion, Empresa, EmpresaNombre, Cliente, ClienteNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica)			
  SELECT
    @EstacionTrabajo,
    Empresa.Empresa,
    Empresa.Nombre, 
    CxcInfo.Cliente,
    Cte.Nombre,
    EmpresaCfg.ContMoneda,
    'de 16 a 30 días',
    SUM(ISNULL(CASE WHEN CxcInfo.Vencimiento BETWEEN @De16A30D AND @De16A30A AND ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN CxcInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxcInfo.Saldo,Cxc.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,0.0)),        
    1
    FROM CxcInfo JOIN Cte 
      ON CxcInfo.Cliente = Cte.Cliente JOIN Cxc
      ON Cxc.Empresa = CxcInfo.Empresa AND Cxc.Mov = CxcInfo.Mov AND Cxc.MovID = CxcInfo.MovID JOIN Empresa
      ON Empresa.Empresa = CxcInfo.Empresa JOIN EmpresaCfg
      ON EmpresaCfg.Empresa = Empresa.Empresa
   WHERE CxcInfo.Empresa = @Empresa 
     AND CxcInfo.Cliente BETWEEN @ClienteD AND @ClienteA
     AND CxcInfo.Moneda = ISNULL(@Moneda, CxcInfo.Moneda)
   GROUP BY Empresa.Empresa, Empresa.Nombre, CxcInfo.Cliente, Cte.Nombre, EmpresaCfg.ContMoneda   

  --Graficas de Clientes de 31 a 60
  INSERT @Grafica (Estacion, Empresa, EmpresaNombre, Cliente, ClienteNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica)			
  SELECT
    @EstacionTrabajo,
    Empresa.Empresa,
    Empresa.Nombre, 
    CxcInfo.Cliente,
    Cte.Nombre,
    EmpresaCfg.ContMoneda,
    'de 31 a 60 días',
    SUM(ISNULL(CASE WHEN CxcInfo.Vencimiento BETWEEN @De31A60D AND @De31A60A AND ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN CxcInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxcInfo.Saldo,Cxc.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,0.0)),            
    1
    FROM CxcInfo JOIN Cte 
      ON CxcInfo.Cliente = Cte.Cliente JOIN Cxc
      ON Cxc.Empresa = CxcInfo.Empresa AND Cxc.Mov = CxcInfo.Mov AND Cxc.MovID = CxcInfo.MovID JOIN Empresa
      ON Empresa.Empresa = CxcInfo.Empresa JOIN EmpresaCfg
      ON EmpresaCfg.Empresa = Empresa.Empresa
   WHERE CxcInfo.Empresa = @Empresa 
     AND CxcInfo.Cliente BETWEEN @ClienteD AND @ClienteA
     AND CxcInfo.Moneda = ISNULL(@Moneda, CxcInfo.Moneda)
   GROUP BY Empresa.Empresa, Empresa.Nombre, CxcInfo.Cliente, Cte.Nombre, EmpresaCfg.ContMoneda   

  --Graficas de Clientes de 61 a 90
  INSERT @Grafica (Estacion, Empresa, EmpresaNombre, Cliente, ClienteNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica)			
  SELECT
    @EstacionTrabajo,
    Empresa.Empresa,
    Empresa.Nombre, 
    CxcInfo.Cliente,
    Cte.Nombre,
    EmpresaCfg.ContMoneda,
    'de 61 a 90 días',
    SUM(ISNULL(CASE WHEN CxcInfo.Vencimiento BETWEEN @De61A90D AND @De61A90A AND ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN CxcInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxcInfo.Saldo,Cxc.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,0.0)),                
    1
    FROM CxcInfo JOIN Cte 
      ON CxcInfo.Cliente = Cte.Cliente JOIN Cxc
      ON Cxc.Empresa = CxcInfo.Empresa AND Cxc.Mov = CxcInfo.Mov AND Cxc.MovID = CxcInfo.MovID JOIN Empresa
      ON Empresa.Empresa = CxcInfo.Empresa JOIN EmpresaCfg
      ON EmpresaCfg.Empresa = Empresa.Empresa
   WHERE CxcInfo.Empresa = @Empresa 
     AND CxcInfo.Cliente BETWEEN @ClienteD AND @ClienteA
     AND CxcInfo.Moneda = ISNULL(@Moneda, CxcInfo.Moneda)
   GROUP BY Empresa.Empresa, Empresa.Nombre, CxcInfo.Cliente, Cte.Nombre, EmpresaCfg.ContMoneda   

  --Graficas de Clientes de 61 a 90
  INSERT @Grafica (Estacion, Empresa, EmpresaNombre, Cliente, ClienteNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica)			
  SELECT
    @EstacionTrabajo,
    Empresa.Empresa,
    Empresa.Nombre, 
    CxcInfo.Cliente,
    Cte.Nombre,
    EmpresaCfg.ContMoneda,
    'más de 90 días',
    SUM(ISNULL(CASE WHEN CxcInfo.Vencimiento <= @MasDe90 AND ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN CxcInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxcInfo.Saldo,Cxc.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,0.0)),
    1
    FROM CxcInfo JOIN Cte 
      ON CxcInfo.Cliente = Cte.Cliente JOIN Cxc
      ON Cxc.Empresa = CxcInfo.Empresa AND Cxc.Mov = CxcInfo.Mov AND Cxc.MovID = CxcInfo.MovID JOIN Empresa
      ON Empresa.Empresa = CxcInfo.Empresa JOIN EmpresaCfg
      ON EmpresaCfg.Empresa = Empresa.Empresa
   WHERE CxcInfo.Empresa = @Empresa 
     AND CxcInfo.Cliente BETWEEN @ClienteD AND @ClienteA
     AND CxcInfo.Moneda = ISNULL(@Moneda, CxcInfo.Moneda)
   GROUP BY Empresa.Empresa, Empresa.Nombre, CxcInfo.Cliente, Cte.Nombre, EmpresaCfg.ContMoneda   

  INSERT @Datos (Estacion, Empresa, EmpresaNombre, Cliente, ClienteNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica,InfoDesglosar)			   
         SELECT  Estacion, Empresa, EmpresaNombre, Cliente, ClienteNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica,@InfoDesglosar 
           FROM @Grafica
          WHERE Grafica = 1
          
  --Grafica Total Al Corriente
  INSERT @Grafica (Estacion, Empresa, EmpresaNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica)			
  SELECT
    @EstacionTrabajo,
    Empresa.Empresa,
    Empresa.Nombre, 
    EmpresaCfg.ContMoneda,
    'Al Corriente',
--    SUM(ISNULL(CASE WHEN CxcInfo.Vencimiento >= @Hoy THEN dbo.fnImporteAMonedaContable(CxcInfo.Saldo,Cxc.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,0.0)),
    SUM(ISNULL(CASE WHEN ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN DATEDIFF(DAY, CxcInfo.Vencimiento, @Hoy) END,0) <= 0 THEN dbo.fnImporteAMonedaContable(CxcInfo.Saldo,Cxc.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,0.00)),
    2
    FROM CxcInfo JOIN Cte 
      ON CxcInfo.Cliente = Cte.Cliente JOIN Cxc
      ON Cxc.Empresa = CxcInfo.Empresa AND Cxc.Mov = CxcInfo.Mov AND Cxc.MovID = CxcInfo.MovID JOIN Empresa
      ON Empresa.Empresa = CxcInfo.Empresa JOIN EmpresaCfg
      ON EmpresaCfg.Empresa = Empresa.Empresa
   WHERE CxcInfo.Empresa = @Empresa 
     AND CxcInfo.Cliente BETWEEN @ClienteD AND @ClienteA
     AND CxcInfo.Moneda = ISNULL(@Moneda, CxcInfo.Moneda)
   GROUP BY Empresa.Empresa, Empresa.Nombre, EmpresaCfg.ContMoneda   

  --Grafica Total de 1 a 15
  INSERT @Grafica (Estacion, Empresa, EmpresaNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica)			
  SELECT
    @EstacionTrabajo,
    Empresa.Empresa,
    Empresa.Nombre, 
    EmpresaCfg.ContMoneda,
    'de 1 a 15 días',
    SUM(ISNULL(CASE WHEN CxcInfo.Vencimiento BETWEEN @De01A15D AND @De01A15A AND ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN CxcInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxcInfo.Saldo,Cxc.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,0.0)),    
    2
    FROM CxcInfo JOIN Cte 
      ON CxcInfo.Cliente = Cte.Cliente JOIN Cxc
      ON Cxc.Empresa = CxcInfo.Empresa AND Cxc.Mov = CxcInfo.Mov AND Cxc.MovID = CxcInfo.MovID JOIN Empresa
      ON Empresa.Empresa = CxcInfo.Empresa JOIN EmpresaCfg
      ON EmpresaCfg.Empresa = Empresa.Empresa
   WHERE CxcInfo.Empresa = @Empresa 
     AND CxcInfo.Cliente BETWEEN @ClienteD AND @ClienteA
     AND CxcInfo.Moneda = ISNULL(@Moneda, CxcInfo.Moneda)
   GROUP BY Empresa.Empresa, Empresa.Nombre, EmpresaCfg.ContMoneda   

  --Grafica Total de 16 a 30
  INSERT @Grafica (Estacion, Empresa, EmpresaNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica)			
  SELECT
    @EstacionTrabajo,
    Empresa.Empresa,
    Empresa.Nombre, 
    EmpresaCfg.ContMoneda,
    'de 16 a 30 días',
    SUM(ISNULL(CASE WHEN CxcInfo.Vencimiento BETWEEN @De16A30D AND @De16A30A AND ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN CxcInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxcInfo.Saldo,Cxc.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,0.0)),        
    2
    FROM CxcInfo JOIN Cte 
      ON CxcInfo.Cliente = Cte.Cliente JOIN Cxc
      ON Cxc.Empresa = CxcInfo.Empresa AND Cxc.Mov = CxcInfo.Mov AND Cxc.MovID = CxcInfo.MovID JOIN Empresa
      ON Empresa.Empresa = CxcInfo.Empresa JOIN EmpresaCfg
      ON EmpresaCfg.Empresa = Empresa.Empresa
   WHERE CxcInfo.Empresa = @Empresa 
     AND CxcInfo.Cliente BETWEEN @ClienteD AND @ClienteA
     AND CxcInfo.Moneda = ISNULL(@Moneda, CxcInfo.Moneda)
   GROUP BY Empresa.Empresa, Empresa.Nombre, EmpresaCfg.ContMoneda   

  --Grafica Total de 31 a 60
  INSERT @Grafica (Estacion, Empresa, EmpresaNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica)			
  SELECT
    @EstacionTrabajo,
    Empresa.Empresa,
    Empresa.Nombre, 
    EmpresaCfg.ContMoneda,
    'de 31 a 60 días',
    SUM(ISNULL(CASE WHEN CxcInfo.Vencimiento BETWEEN @De31A60D AND @De31A60A AND ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN CxcInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxcInfo.Saldo,Cxc.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,0.0)),            
    2
    FROM CxcInfo JOIN Cte 
      ON CxcInfo.Cliente = Cte.Cliente JOIN Cxc
      ON Cxc.Empresa = CxcInfo.Empresa AND Cxc.Mov = CxcInfo.Mov AND Cxc.MovID = CxcInfo.MovID JOIN Empresa
      ON Empresa.Empresa = CxcInfo.Empresa JOIN EmpresaCfg
      ON EmpresaCfg.Empresa = Empresa.Empresa
   WHERE CxcInfo.Empresa = @Empresa 
     AND CxcInfo.Cliente BETWEEN @ClienteD AND @ClienteA
     AND CxcInfo.Moneda = ISNULL(@Moneda, CxcInfo.Moneda)
   GROUP BY Empresa.Empresa, Empresa.Nombre, EmpresaCfg.ContMoneda   

  --Grafica Total de 61 a 90
  INSERT @Grafica (Estacion, Empresa, EmpresaNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica)			
  SELECT
    @EstacionTrabajo,
    Empresa.Empresa,
    Empresa.Nombre, 
    EmpresaCfg.ContMoneda,
    'de 61 a 90 días',
    SUM(ISNULL(CASE WHEN CxcInfo.Vencimiento BETWEEN @De61A90D AND @De61A90A AND ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN CxcInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxcInfo.Saldo,Cxc.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,0.0)),                
    2
    FROM CxcInfo JOIN Cte 
      ON CxcInfo.Cliente = Cte.Cliente JOIN Cxc
      ON Cxc.Empresa = CxcInfo.Empresa AND Cxc.Mov = CxcInfo.Mov AND Cxc.MovID = CxcInfo.MovID JOIN Empresa
      ON Empresa.Empresa = CxcInfo.Empresa JOIN EmpresaCfg
      ON EmpresaCfg.Empresa = Empresa.Empresa
   WHERE CxcInfo.Empresa = @Empresa 
     AND CxcInfo.Cliente BETWEEN @ClienteD AND @ClienteA
     AND CxcInfo.Moneda = ISNULL(@Moneda, CxcInfo.Moneda)
   GROUP BY Empresa.Empresa, Empresa.Nombre, EmpresaCfg.ContMoneda   

  --Grafica Total mas de 90 días
  INSERT @Grafica (Estacion, Empresa, EmpresaNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica)			
  SELECT
    @EstacionTrabajo,
    Empresa.Empresa,
    Empresa.Nombre, 
    EmpresaCfg.ContMoneda,
    'más de 90 días',
    SUM(ISNULL(CASE WHEN CxcInfo.Vencimiento <= @MasDe90 AND ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN CxcInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxcInfo.Saldo,Cxc.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,0.0)),
    2
    FROM CxcInfo JOIN Cte 
      ON CxcInfo.Cliente = Cte.Cliente JOIN Cxc
      ON Cxc.Empresa = CxcInfo.Empresa AND Cxc.Mov = CxcInfo.Mov AND Cxc.MovID = CxcInfo.MovID JOIN Empresa
      ON Empresa.Empresa = CxcInfo.Empresa JOIN EmpresaCfg
      ON EmpresaCfg.Empresa = Empresa.Empresa
   WHERE CxcInfo.Empresa = @Empresa 
     AND CxcInfo.Cliente BETWEEN @ClienteD AND @ClienteA
     AND CxcInfo.Moneda = ISNULL(@Moneda, CxcInfo.Moneda)
   GROUP BY Empresa.Empresa, Empresa.Nombre, EmpresaCfg.ContMoneda   

  INSERT @Datos (Estacion, Empresa, EmpresaNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica,InfoDesglosar)			   
         SELECT  Estacion, Empresa, EmpresaNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica,@InfoDesglosar
           FROM @Grafica
          WHERE Grafica = 2        

  SELECT *, @Etiqueta as Etiqueta, @VerGraficaDetalle as VerGraficaDetalle FROM @Datos ORDER BY Grafica  
END   
GO
--EXEC spInformeCXCAntiguedadSaldos 1

/******************************* spInformeCXPAntiguedadSaldos *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spInformeCXPAntiguedadSaldos') and type = 'P') drop procedure dbo.spInformeCXPAntiguedadSaldos
GO             
CREATE PROCEDURE spInformeCXPAntiguedadSaldos
		(
		@EstacionTrabajo		int
		)
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE
    @Empresa				varchar(5),
    @ProveedorD				varchar(10),
    @ProveedorA				varchar(10),    
    @Moneda					varchar(10),
    @Hoy					datetime,
    @De01A15D				datetime,    
    @De01A15A				datetime,
    @De16A30D				datetime,    
    @De16A30A				datetime,
    @De31A60D				datetime,
    @De31A60A				datetime,
    @De61A90D				datetime,
    @De61A90A				datetime,
    @MasDe90				datetime,
    @Etiqueta				bit,
    @VerGraficaDetalle		bit,
    @InfoDesglosar			varchar(20)
      
  DECLARE @Datos TABLE
  (
   Estacion					int,
   Empresa					varchar(5) COLLATE DATABASE_DEFAULT NULL,
   EmpresaNombre			varchar(100) COLLATE DATABASE_DEFAULT NULL,
   Proveedor				varchar(10) COLLATE DATABASE_DEFAULT NULL,
   ProveedorNombre			varchar(100) COLLATE DATABASE_DEFAULT NULL,   
   Moneda					varchar(10) COLLATE DATABASE_DEFAULT NULL,
   MonedaContable			varchar(10) COLLATE DATABASE_DEFAULT NULL,   
   Mov						varchar(20) COLLATE DATABASE_DEFAULT NULL,
   MovID					varchar(20) COLLATE DATABASE_DEFAULT NULL,
   Referencia				varchar(50) COLLATE DATABASE_DEFAULT NULL,   
   FechaEmision				datetime,
   Vencimiento				datetime,
   DiasMoratorios			int,
   AlCorriente				float,
   De01A15					float,  
   De16A30					float,     
   De31A60					float,        
   De61A90					float,           
   MasDe90					float,
   AlCorrienteMC			float,
   De01A15MC				float,  
   De16A30MC				float,     
   De31A60MC				float,        
   De61A90MC				float,           
   MasDe90MC				float,   
   GraficaArgumento			varchar(100) COLLATE DATABASE_DEFAULT NULL,   
   GraficaValor				float NULL,		
   Grafica					int NULL DEFAULT 0,
   InfoDesglosar			varchar(20)
  )    

  DECLARE @Grafica TABLE
  (
   Estacion					int NULL,
   Empresa					varchar(5) COLLATE DATABASE_DEFAULT NULL,
   EmpresaNombre			varchar(100) COLLATE DATABASE_DEFAULT NULL,
   Proveedor				varchar(10) COLLATE DATABASE_DEFAULT NULL,
   ProveedorNombre			varchar(100) COLLATE DATABASE_DEFAULT NULL,   
   Moneda					varchar(10) COLLATE DATABASE_DEFAULT NULL,
   MonedaContable			varchar(10) COLLATE DATABASE_DEFAULT NULL,   
   Mov						varchar(20) COLLATE DATABASE_DEFAULT NULL,
   MovID					varchar(20) COLLATE DATABASE_DEFAULT NULL,
   Referencia				varchar(50) COLLATE DATABASE_DEFAULT NULL,   
   FechaEmision				datetime,
   Vencimiento				datetime,
   DiasMoratorios			int,
   AlCorriente				float,
   De01A15					float,  
   De16A30					float,     
   De31A60					float,        
   De61A90					float,           
   MasDe90					float,
   AlCorrienteMC			float,
   De01A15MC				float,  
   De16A30MC				float,     
   De31A60MC				float,        
   De61A90MC				float,           
   MasDe90MC				float,   
   GraficaArgumento			varchar(100) COLLATE DATABASE_DEFAULT NULL,   
   GraficaValor				float NULL,		   
   Grafica					int NULL DEFAULT 0
  )    
      
  SET @Hoy = GETDATE()    
  EXEC spExtraerFecha @Hoy OUTPUT    
    
  SET @De01A15D = DATEADD(day,-15,@Hoy)  
  SET @De01A15A = DATEADD(day,-1,@Hoy)
  
  SET @De16A30D = DATEADD(day,-30,@Hoy)  
  SET @De16A30A = DATEADD(day,-16,@Hoy)

  SET @De31A60D = DATEADD(day,-60,@Hoy)  
  SET @De31A60A = DATEADD(day,-31,@Hoy)
  
  SET @De61A90D = DATEADD(day,-90,@Hoy)  
  SET @De61A90A = DATEADD(day,-61,@Hoy)

  SET @MasDe90 = DATEADD(day,-91,@Hoy)  
  
  SELECT
    @Empresa           =    InfoEmpresa,
    @ProveedorD        =    NULLIF(InfoProveedorD,''),
    @ProveedorA        =    NULLIF(InfoProveedorA,''),
    @Moneda            =	CASE WHEN InfoMoneda IN('(Todas)', '') THEN NULL ELSE InfoMoneda END,
    @Etiqueta		   =	ISNULL(InfoEtiqueta,0),
    @VerGraficaDetalle = ISNULL(VerGraficaDetalle,0),   
    @InfoDesglosar     =    ISNULL(InfoDesglosar,'No')
    FROM RepParam
   WHERE Estacion = @EstacionTrabajo 

  INSERT @Datos (Estacion, Empresa, EmpresaNombre, Proveedor, ProveedorNombre, Moneda, MonedaContable, Mov, MovID, Referencia, FechaEmision, Vencimiento, DiasMoratorios, AlCorriente, De01A15, De16A30, De31A60, De61A90, MasDe90, AlCorrienteMC, De01A15MC, De16A30MC, De31A60MC, De61A90MC, MasDe90MC, Grafica,InfoDesglosar)			
  SELECT
    @EstacionTrabajo,
    Empresa.Empresa,
    Empresa.Nombre, 
    CxpInfo.Proveedor,
    Prov.Nombre,
    CxpInfo.Moneda,
    EmpresaCfg.ContMoneda,
    CxpInfo.Mov,
    CxpInfo.MovID,
    CxpInfo.Referencia,
    CxpInfo.FechaEmision,
    CxpInfo.Vencimiento,
--    CxpInfo.DiasMoratorios,
    ISNULL(CASE WHEN CxpInfo.Saldo > 0.00 THEN DATEDIFF(DAY, CxpInfo.Vencimiento, @Hoy) END,0),
--    CASE WHEN CxpInfo.Vencimiento >= @Hoy THEN CxpInfo.Saldo ELSE NULL END,
    CASE WHEN ISNULL(CASE WHEN CxpInfo.Saldo > 0.00 THEN DATEDIFF(DAY, CxpInfo.Vencimiento, @Hoy) END,0) <= 0 THEN CxpInfo.Saldo ELSE NULL END,
    CASE WHEN CxpInfo.Vencimiento BETWEEN @De01A15D AND @De01A15A AND ISNULL(CASE WHEN CxpInfo.Saldo > 0.00 THEN CxpInfo.DiasMoratorios END,0) > 0 THEN CxpInfo.Saldo ELSE NULL END,    
    CASE WHEN CxpInfo.Vencimiento BETWEEN @De16A30D AND @De16A30A AND ISNULL(CASE WHEN CxpInfo.Saldo > 0.00 THEN CxpInfo.DiasMoratorios END,0) > 0 THEN CxpInfo.Saldo ELSE NULL END,        
    CASE WHEN CxpInfo.Vencimiento BETWEEN @De31A60D AND @De31A60A AND ISNULL(CASE WHEN CxpInfo.Saldo > 0.00 THEN CxpInfo.DiasMoratorios END,0) > 0 THEN CxpInfo.Saldo ELSE NULL END,            
    CASE WHEN CxpInfo.Vencimiento BETWEEN @De61A90D AND @De61A90A AND ISNULL(CASE WHEN CxpInfo.Saldo > 0.00 THEN CxpInfo.DiasMoratorios END,0) > 0 THEN CxpInfo.Saldo ELSE NULL END,                
    CASE WHEN CxpInfo.Vencimiento <= @MasDe90 AND ISNULL(CASE WHEN CxpInfo.Saldo > 0.00 THEN CxpInfo.DiasMoratorios END,0) > 0 THEN CxpInfo.Saldo ELSE NULL END,

--    CASE WHEN CxpInfo.Vencimiento >= @Hoy THEN dbo.fnImporteAMonedaContable(CxpInfo.Saldo,Cxp.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,
    CASE WHEN ISNULL(CASE WHEN CxpInfo.Saldo > 0.00 THEN DATEDIFF(DAY, CxpInfo.Vencimiento, @Hoy) END,0) <= 0 THEN dbo.fnImporteAMonedaContable(CxpInfo.Saldo,Cxp.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,
    CASE WHEN CxpInfo.Vencimiento BETWEEN @De01A15D AND @De01A15A AND ISNULL(CASE WHEN CxpInfo.Saldo > 0.00 THEN CxpInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxpInfo.Saldo,Cxp.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,    
    CASE WHEN CxpInfo.Vencimiento BETWEEN @De16A30D AND @De16A30A AND ISNULL(CASE WHEN CxpInfo.Saldo > 0.00 THEN CxpInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxpInfo.Saldo,Cxp.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,        
    CASE WHEN CxpInfo.Vencimiento BETWEEN @De31A60D AND @De31A60A AND ISNULL(CASE WHEN CxpInfo.Saldo > 0.00 THEN CxpInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxpInfo.Saldo,Cxp.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,            
    CASE WHEN CxpInfo.Vencimiento BETWEEN @De61A90D AND @De61A90A AND ISNULL(CASE WHEN CxpInfo.Saldo > 0.00 THEN CxpInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxpInfo.Saldo,Cxp.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,                
    CASE WHEN CxpInfo.Vencimiento <= @MasDe90 AND ISNULL(CASE WHEN CxpInfo.Saldo > 0.00 THEN CxpInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxpInfo.Saldo,Cxp.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,
    0, @InfoDesglosar
    FROM CxpInfo JOIN Prov 
      ON CxpInfo.Proveedor = Prov.Proveedor LEFT OUTER JOIN Cxp
      ON Cxp.Empresa = CxpInfo.Empresa AND Cxp.Mov = CxpInfo.Mov AND Cxp.MovID = CxpInfo.MovID JOIN Empresa
      ON Empresa.Empresa = CxpInfo.Empresa JOIN EmpresaCfg
      ON EmpresaCfg.Empresa = Empresa.Empresa
   WHERE CxpInfo.Empresa = @Empresa 
     AND CxpInfo.Proveedor BETWEEN @ProveedorD AND @ProveedorA
     AND CxpInfo.Moneda = ISNULL(@Moneda, CxpInfo.Moneda)
   ORDER BY CxpInfo.Proveedor, CxpInfo.Moneda, CxpInfo.Mov, CxpInfo.Vencimiento DESC 

  --Graficas de Proveedors Al Corriente
  INSERT @Grafica (Estacion, Empresa, EmpresaNombre, Proveedor, ProveedorNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica)			
  SELECT
    @EstacionTrabajo,
    Empresa.Empresa,
    Empresa.Nombre, 
    CxpInfo.Proveedor,
    Prov.Nombre,
    EmpresaCfg.ContMoneda,
    'Al Corriente',
--    SUM(ISNULL(CASE WHEN CxpInfo.Vencimiento >= @Hoy THEN dbo.fnImporteAMonedaContable(CxpInfo.Saldo,Cxp.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,0.0)),
    SUM(ISNULL(CASE WHEN ISNULL(CASE WHEN CxpInfo.Saldo > 0.00 THEN DATEDIFF(DAY, CxpInfo.Vencimiento, @Hoy) END,0) <= 0 THEN dbo.fnImporteAMonedaContable(CxpInfo.Saldo,Cxp.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,0.00)),
    1
    FROM CxpInfo JOIN Prov 
      ON CxpInfo.Proveedor = Prov.Proveedor JOIN Cxp
      ON Cxp.Empresa = CxpInfo.Empresa AND Cxp.Mov = CxpInfo.Mov AND Cxp.MovID = CxpInfo.MovID JOIN Empresa
      ON Empresa.Empresa = CxpInfo.Empresa JOIN EmpresaCfg
      ON EmpresaCfg.Empresa = Empresa.Empresa
   WHERE CxpInfo.Empresa = @Empresa 
     AND CxpInfo.Proveedor BETWEEN @ProveedorD AND @ProveedorA
     AND CxpInfo.Moneda = ISNULL(@Moneda, CxpInfo.Moneda)
   GROUP BY Empresa.Empresa, Empresa.Nombre, CxpInfo.Proveedor, Prov.Nombre, EmpresaCfg.ContMoneda   

  --Graficas de Proveedors de 1 a 15
  INSERT @Grafica (Estacion, Empresa, EmpresaNombre, Proveedor, ProveedorNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica)			
  SELECT
    @EstacionTrabajo,
    Empresa.Empresa,
    Empresa.Nombre, 
    CxpInfo.Proveedor,
    Prov.Nombre,
    EmpresaCfg.ContMoneda,
    'de 1 a 15 días',
    SUM(ISNULL(CASE WHEN CxpInfo.Vencimiento BETWEEN @De01A15D AND @De01A15A AND ISNULL(CASE WHEN CxpInfo.Saldo > 0.00 THEN CxpInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxpInfo.Saldo,Cxp.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,0.0)),    
    1
    FROM CxpInfo JOIN Prov 
      ON CxpInfo.Proveedor = Prov.Proveedor LEFT OUTER JOIN Cxp
      ON Cxp.Empresa = CxpInfo.Empresa AND Cxp.Mov = CxpInfo.Mov AND Cxp.MovID = CxpInfo.MovID LEFT OUTER JOIN Empresa
      ON Empresa.Empresa = CxpInfo.Empresa JOIN EmpresaCfg
      ON EmpresaCfg.Empresa = Empresa.Empresa
   WHERE CxpInfo.Empresa = @Empresa 
     AND CxpInfo.Proveedor BETWEEN @ProveedorD AND @ProveedorA
     AND CxpInfo.Moneda = ISNULL(@Moneda, CxpInfo.Moneda)
   GROUP BY Empresa.Empresa, Empresa.Nombre, CxpInfo.Proveedor, Prov.Nombre, EmpresaCfg.ContMoneda   

  --Graficas de Proveedors de 16 a 30
  INSERT @Grafica (Estacion, Empresa, EmpresaNombre, Proveedor, ProveedorNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica)			
  SELECT
    @EstacionTrabajo,
    Empresa.Empresa,
    Empresa.Nombre, 
    CxpInfo.Proveedor,
    Prov.Nombre,
    EmpresaCfg.ContMoneda,
    'de 16 a 30 días',
    SUM(ISNULL(CASE WHEN CxpInfo.Vencimiento BETWEEN @De16A30D AND @De16A30A AND ISNULL(CASE WHEN CxpInfo.Saldo > 0.00 THEN CxpInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxpInfo.Saldo,Cxp.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,0.0)),        
    1
    FROM CxpInfo JOIN Prov 
      ON CxpInfo.Proveedor = Prov.Proveedor JOIN Cxp
      ON Cxp.Empresa = CxpInfo.Empresa AND Cxp.Mov = CxpInfo.Mov AND Cxp.MovID = CxpInfo.MovID JOIN Empresa
      ON Empresa.Empresa = CxpInfo.Empresa JOIN EmpresaCfg
      ON EmpresaCfg.Empresa = Empresa.Empresa
   WHERE CxpInfo.Empresa = @Empresa 
     AND CxpInfo.Proveedor BETWEEN @ProveedorD AND @ProveedorA
     AND CxpInfo.Moneda = ISNULL(@Moneda, CxpInfo.Moneda)
   GROUP BY Empresa.Empresa, Empresa.Nombre, CxpInfo.Proveedor, Prov.Nombre, EmpresaCfg.ContMoneda   

  --Graficas de Proveedors de 31 a 60
  INSERT @Grafica (Estacion, Empresa, EmpresaNombre, Proveedor, ProveedorNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica)			
  SELECT
    @EstacionTrabajo,
    Empresa.Empresa,
    Empresa.Nombre, 
    CxpInfo.Proveedor,
    Prov.Nombre,
    EmpresaCfg.ContMoneda,
    'de 31 a 60 días',
    SUM(ISNULL(CASE WHEN CxpInfo.Vencimiento BETWEEN @De31A60D AND @De31A60A AND ISNULL(CASE WHEN CxpInfo.Saldo > 0.00 THEN CxpInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxpInfo.Saldo,Cxp.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,0.0)),            
    1
    FROM CxpInfo JOIN Prov 
      ON CxpInfo.Proveedor = Prov.Proveedor JOIN Cxp
      ON Cxp.Empresa = CxpInfo.Empresa AND Cxp.Mov = CxpInfo.Mov AND Cxp.MovID = CxpInfo.MovID JOIN Empresa
      ON Empresa.Empresa = CxpInfo.Empresa JOIN EmpresaCfg
      ON EmpresaCfg.Empresa = Empresa.Empresa
   WHERE CxpInfo.Empresa = @Empresa 
     AND CxpInfo.Proveedor BETWEEN @ProveedorD AND @ProveedorA
     AND CxpInfo.Moneda = ISNULL(@Moneda, CxpInfo.Moneda)
   GROUP BY Empresa.Empresa, Empresa.Nombre, CxpInfo.Proveedor, Prov.Nombre, EmpresaCfg.ContMoneda   

  --Graficas de Proveedors de 61 a 90
  INSERT @Grafica (Estacion, Empresa, EmpresaNombre, Proveedor, ProveedorNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica)			
  SELECT
    @EstacionTrabajo,
    Empresa.Empresa,
    Empresa.Nombre, 
    CxpInfo.Proveedor,
    Prov.Nombre,
    EmpresaCfg.ContMoneda,
    'de 61 a 90 días',
    SUM(ISNULL(CASE WHEN CxpInfo.Vencimiento BETWEEN @De61A90D AND @De61A90A AND ISNULL(CASE WHEN CxpInfo.Saldo > 0.00 THEN CxpInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxpInfo.Saldo,Cxp.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,0.0)),                
    1
    FROM CxpInfo JOIN Prov 
      ON CxpInfo.Proveedor = Prov.Proveedor JOIN Cxp
      ON Cxp.Empresa = CxpInfo.Empresa AND Cxp.Mov = CxpInfo.Mov AND Cxp.MovID = CxpInfo.MovID JOIN Empresa
      ON Empresa.Empresa = CxpInfo.Empresa JOIN EmpresaCfg
      ON EmpresaCfg.Empresa = Empresa.Empresa
   WHERE CxpInfo.Empresa = @Empresa 
     AND CxpInfo.Proveedor BETWEEN @ProveedorD AND @ProveedorA
     AND CxpInfo.Moneda = ISNULL(@Moneda, CxpInfo.Moneda)
   GROUP BY Empresa.Empresa, Empresa.Nombre, CxpInfo.Proveedor, Prov.Nombre, EmpresaCfg.ContMoneda   

  --Graficas de Proveedors de 61 a 90
  INSERT @Grafica (Estacion, Empresa, EmpresaNombre, Proveedor, ProveedorNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica)			
  SELECT
    @EstacionTrabajo,
    Empresa.Empresa,
    Empresa.Nombre, 
    CxpInfo.Proveedor,
    Prov.Nombre,
    EmpresaCfg.ContMoneda,
    'más de 90 días',
    SUM(ISNULL(CASE WHEN CxpInfo.Vencimiento <= @MasDe90 AND ISNULL(CASE WHEN CxpInfo.Saldo > 0.00 THEN CxpInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxpInfo.Saldo,Cxp.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,0.0)),
    1
    FROM CxpInfo JOIN Prov 
      ON CxpInfo.Proveedor = Prov.Proveedor JOIN Cxp
      ON Cxp.Empresa = CxpInfo.Empresa AND Cxp.Mov = CxpInfo.Mov AND Cxp.MovID = CxpInfo.MovID JOIN Empresa
      ON Empresa.Empresa = CxpInfo.Empresa JOIN EmpresaCfg
      ON EmpresaCfg.Empresa = Empresa.Empresa
   WHERE CxpInfo.Empresa = @Empresa 
     AND CxpInfo.Proveedor BETWEEN @ProveedorD AND @ProveedorA
     AND CxpInfo.Moneda = ISNULL(@Moneda, CxpInfo.Moneda)
   GROUP BY Empresa.Empresa, Empresa.Nombre, CxpInfo.Proveedor, Prov.Nombre, EmpresaCfg.ContMoneda   

  INSERT @Datos (Estacion, Empresa, EmpresaNombre, Proveedor, ProveedorNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica, InfoDesglosar)			   
         SELECT  Estacion, Empresa, EmpresaNombre, Proveedor, ProveedorNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica, @InfoDesglosar 
           FROM @Grafica
          WHERE Grafica = 1
          
  --Grafica Total Al Corriente
  INSERT @Grafica (Estacion, Empresa, EmpresaNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica)			
  SELECT
    @EstacionTrabajo,
    Empresa.Empresa,
    Empresa.Nombre, 
    EmpresaCfg.ContMoneda,
    'Al Corriente',
--    SUM(ISNULL(CASE WHEN CxpInfo.Vencimiento >= @Hoy THEN dbo.fnImporteAMonedaContable(CxpInfo.Saldo,Cxp.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,0.0)),
    SUM(ISNULL(CASE WHEN ISNULL(CASE WHEN CxpInfo.Saldo > 0.00 THEN DATEDIFF(DAY, CxpInfo.Vencimiento, @Hoy) END,0) <= 0 THEN dbo.fnImporteAMonedaContable(CxpInfo.Saldo,Cxp.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,0.00)),
    2
    FROM CxpInfo JOIN Prov 
      ON CxpInfo.Proveedor = Prov.Proveedor JOIN Cxp
      ON Cxp.Empresa = CxpInfo.Empresa AND Cxp.Mov = CxpInfo.Mov AND Cxp.MovID = CxpInfo.MovID JOIN Empresa
      ON Empresa.Empresa = CxpInfo.Empresa JOIN EmpresaCfg
      ON EmpresaCfg.Empresa = Empresa.Empresa
   WHERE CxpInfo.Empresa = @Empresa 
     AND CxpInfo.Proveedor BETWEEN @ProveedorD AND @ProveedorA
     AND CxpInfo.Moneda = ISNULL(@Moneda, CxpInfo.Moneda)
   GROUP BY Empresa.Empresa, Empresa.Nombre, EmpresaCfg.ContMoneda   

  --Grafica Total de 1 a 15
  INSERT @Grafica (Estacion, Empresa, EmpresaNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica)			
  SELECT
    @EstacionTrabajo,
    Empresa.Empresa,
    Empresa.Nombre, 
    EmpresaCfg.ContMoneda,
    'de 1 a 15 días',
    SUM(ISNULL(CASE WHEN CxpInfo.Vencimiento BETWEEN @De01A15D AND @De01A15A AND ISNULL(CASE WHEN CxpInfo.Saldo > 0.00 THEN CxpInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxpInfo.Saldo,Cxp.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,0.0)),    
    2
    FROM CxpInfo JOIN Prov 
      ON CxpInfo.Proveedor = Prov.Proveedor JOIN Cxp
      ON Cxp.Empresa = CxpInfo.Empresa AND Cxp.Mov = CxpInfo.Mov AND Cxp.MovID = CxpInfo.MovID JOIN Empresa
      ON Empresa.Empresa = CxpInfo.Empresa JOIN EmpresaCfg
      ON EmpresaCfg.Empresa = Empresa.Empresa
   WHERE CxpInfo.Empresa = @Empresa 
     AND CxpInfo.Proveedor BETWEEN @ProveedorD AND @ProveedorA
     AND CxpInfo.Moneda = ISNULL(@Moneda, CxpInfo.Moneda)
   GROUP BY Empresa.Empresa, Empresa.Nombre, EmpresaCfg.ContMoneda   

  --Grafica Total de 16 a 30
  INSERT @Grafica (Estacion, Empresa, EmpresaNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica)			
  SELECT
    @EstacionTrabajo,
    Empresa.Empresa,
    Empresa.Nombre, 
    EmpresaCfg.ContMoneda,
    'de 16 a 30 días',
    SUM(ISNULL(CASE WHEN CxpInfo.Vencimiento BETWEEN @De16A30D AND @De16A30A AND ISNULL(CASE WHEN CxpInfo.Saldo > 0.00 THEN CxpInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxpInfo.Saldo,Cxp.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,0.0)),        
    2
    FROM CxpInfo JOIN Prov 
      ON CxpInfo.Proveedor = Prov.Proveedor JOIN Cxp
      ON Cxp.Empresa = CxpInfo.Empresa AND Cxp.Mov = CxpInfo.Mov AND Cxp.MovID = CxpInfo.MovID JOIN Empresa
      ON Empresa.Empresa = CxpInfo.Empresa JOIN EmpresaCfg
      ON EmpresaCfg.Empresa = Empresa.Empresa
   WHERE CxpInfo.Empresa = @Empresa 
     AND CxpInfo.Proveedor BETWEEN @ProveedorD AND @ProveedorA
     AND CxpInfo.Moneda = ISNULL(@Moneda, CxpInfo.Moneda)
   GROUP BY Empresa.Empresa, Empresa.Nombre, EmpresaCfg.ContMoneda   

  --Grafica Total de 31 a 60
  INSERT @Grafica (Estacion, Empresa, EmpresaNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica)			
  SELECT
    @EstacionTrabajo,
    Empresa.Empresa,
    Empresa.Nombre, 
    EmpresaCfg.ContMoneda,
    'de 31 a 60 días',
    SUM(ISNULL(CASE WHEN CxpInfo.Vencimiento BETWEEN @De31A60D AND @De31A60A AND ISNULL(CASE WHEN CxpInfo.Saldo > 0.00 THEN CxpInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxpInfo.Saldo,Cxp.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,0.0)),            
    2
    FROM CxpInfo JOIN Prov 
      ON CxpInfo.Proveedor = Prov.Proveedor JOIN Cxp
      ON Cxp.Empresa = CxpInfo.Empresa AND Cxp.Mov = CxpInfo.Mov AND Cxp.MovID = CxpInfo.MovID JOIN Empresa
      ON Empresa.Empresa = CxpInfo.Empresa JOIN EmpresaCfg
      ON EmpresaCfg.Empresa = Empresa.Empresa
   WHERE CxpInfo.Empresa = @Empresa 
     AND CxpInfo.Proveedor BETWEEN @ProveedorD AND @ProveedorA
     AND CxpInfo.Moneda = ISNULL(@Moneda, CxpInfo.Moneda)
   GROUP BY Empresa.Empresa, Empresa.Nombre, EmpresaCfg.ContMoneda   

  --Grafica Total de 61 a 90
  INSERT @Grafica (Estacion, Empresa, EmpresaNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica)			
  SELECT
    @EstacionTrabajo,
    Empresa.Empresa,
    Empresa.Nombre, 
    EmpresaCfg.ContMoneda,
    'de 61 a 90 días',
    SUM(ISNULL(CASE WHEN CxpInfo.Vencimiento BETWEEN @De61A90D AND @De61A90A AND ISNULL(CASE WHEN CxpInfo.Saldo > 0.00 THEN CxpInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxpInfo.Saldo,Cxp.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,0.0)),                
    2
    FROM CxpInfo JOIN Prov 
      ON CxpInfo.Proveedor = Prov.Proveedor JOIN Cxp
      ON Cxp.Empresa = CxpInfo.Empresa AND Cxp.Mov = CxpInfo.Mov AND Cxp.MovID = CxpInfo.MovID JOIN Empresa
      ON Empresa.Empresa = CxpInfo.Empresa JOIN EmpresaCfg
      ON EmpresaCfg.Empresa = Empresa.Empresa
   WHERE CxpInfo.Empresa = @Empresa 
     AND CxpInfo.Proveedor BETWEEN @ProveedorD AND @ProveedorA
     AND CxpInfo.Moneda = ISNULL(@Moneda, CxpInfo.Moneda)
   GROUP BY Empresa.Empresa, Empresa.Nombre, EmpresaCfg.ContMoneda   

  --Grafica Total mas de 90 días
  INSERT @Grafica (Estacion, Empresa, EmpresaNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica)			
  SELECT
    @EstacionTrabajo,
    Empresa.Empresa,
    Empresa.Nombre, 
    EmpresaCfg.ContMoneda,
    'más de 90 días',
    SUM(ISNULL(CASE WHEN CxpInfo.Vencimiento <= @MasDe90 AND ISNULL(CASE WHEN CxpInfo.Saldo > 0.00 THEN CxpInfo.DiasMoratorios END,0) > 0 THEN dbo.fnImporteAMonedaContable(CxpInfo.Saldo,Cxp.TipoCambio,EmpresaCfg.ContMoneda) ELSE NULL END,0.0)),
    2
    FROM CxpInfo JOIN Prov 
      ON CxpInfo.Proveedor = Prov.Proveedor JOIN Cxp
      ON Cxp.Empresa = CxpInfo.Empresa AND Cxp.Mov = CxpInfo.Mov AND Cxp.MovID = CxpInfo.MovID JOIN Empresa
      ON Empresa.Empresa = CxpInfo.Empresa JOIN EmpresaCfg
      ON EmpresaCfg.Empresa = Empresa.Empresa
   WHERE CxpInfo.Empresa = @Empresa 
     AND CxpInfo.Proveedor BETWEEN @ProveedorD AND @ProveedorA
     AND CxpInfo.Moneda = ISNULL(@Moneda, CxpInfo.Moneda)
   GROUP BY Empresa.Empresa, Empresa.Nombre, EmpresaCfg.ContMoneda   

  INSERT @Datos (Estacion, Empresa, EmpresaNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica, InfoDesglosar)			   
         SELECT  Estacion, Empresa, EmpresaNombre, MonedaContable, GraficaArgumento, GraficaValor, Grafica, @InfoDesglosar
           FROM @Grafica
          WHERE Grafica = 2        

  SELECT *, @Etiqueta as Etiqueta, @VerGraficaDetalle as VerGraficaDetalle FROM @Datos ORDER BY Grafica  
END   
GO

--EXEC spInformeCxpAntiguedadSaldos 1
--update repparam set InfoProveedorD = 'FONACOT', InfoProveedorA = 'TDF', InfoSucursal = null, InfoModulo = 'CXP', InfoMoneda = '(Todas)' WHERE Estacion = 1
--SELECT * FROM PROV


/******************************* spInformeCompraArtCat *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spInformeCompraArtCat') and type = 'P') drop procedure dbo.spInformeCompraArtCat
GO             
CREATE PROCEDURE spInformeCompraArtCat
		@EstacionTrabajo		int

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
	@FechaD					datetime,
	@FechaA					datetime,
	@Reporte				varchar(30),
	@Empresa				char(5),
	@Verdadero				bit,
	@Falso					bit,
	@Clave1					varchar(20),
	@Clave2					varchar(20),
	@Clave3					varchar(20),
	@Clave4					varchar(20),
	@Clave5					varchar(20),
	@Clave6					varchar(20),
	@Moneda					varchar(20),
	@ImporteTotal			money,
	@ImporteTotalMC			money,
    @Categoria				varchar(20),
    @FechaGrafica			varchar(50),
    @Periodo				int,
    @Ejercicio				int,
    @Titulo					varchar(100),
	@EmpresaNombre			varchar(100),
	@Graficar				int,
	@Grafica2				bit,
	@GraficarFecha			int,
	@GraficarTipo			varchar(30),
    @Etiqueta				bit,
    @GraficarCantidad		int,
    @VerGraficaDetalle		bit
    

  DECLARE @InformeCompraArtCat TABLE
  (
	Estacion			int 	    	NOT	NULL,
    IDInforme			int 	    	NOT NULL  IDENTITY(1,1),
	Empresa				char(5)				NULL,
	Moneda  			char(10)   			NULL, 
	Moneda2  			char(10)   			NULL, 
	Categoria  			varchar(50) 		NULL, 
	Importe				money				NULL,
	DescuentosTotales	money				NULL,
	SubTotal			money				NULL,
	Impuestos			money				NULL,
	ImporteTotal		money				NULL,	
	ImporteTotalMC		money				NULL,
	SaldoDescripcion	varchar(50)			NULL,
    SaldoImporte		money				NULL DEFAULT 0.0,
    SaldoDescripcionMC	varchar(50)			NULL,
    SaldoImporteMC		money				NULL DEFAULT 0.0,
	Grafica1 			bit					NULL DEFAULT 0,
	Grafica2 			bit					NULL DEFAULT 0,
	Reporte				varchar(100)		NULL,
	Total				bit					NULL DEFAULT 0,
	ContMoneda			char(10)			NULL,
	FechaGrafica		varchar(100)		NULL,
	FechaDesde			datetime			NULL,
    FechaHasta			datetime			NULL,
    Titulo				varchar(100)		NULL,
	EmpresaNombre		varchar(100)		NULL,
	Periodo				int					NULL,
	Ejercicio			int					NULL,
	Etiqueta			bit					NULL  DEFAULT 0
  )    

	

  SELECT @Verdadero = 1, @Falso = 0
  SELECT 
  	  @FechaD  = InfoFechaD,
	  @FechaA  = InfoFechaA,
	  @Reporte = InfoRepCompras,
	  @Empresa = InfoEmpresa,
	  @Titulo = RepTitulo,
	  @GraficarFecha = ISNULL(InformeGraficarFecha,12),
	  @GraficarTipo = ISNULL(InformeGraficarTipo,  '(Todos)'),
	  @Etiqueta = ISNULL(InfoEtiqueta, @Falso),
	  @GraficarCantidad = ISNULL(InformeGraficarCantidad, 5),
    @VerGraficaDetalle = ISNULL(VerGraficaDetalle,0)
    FROM RepParam 
   WHERE Estacion = @EstacionTrabajo

  SELECT @EmpresaNombre = (SELECT Nombre FROM Empresa WHERE Empresa = @Empresa)

  IF @Reporte IN ('Entradas')
    SELECT
      @Clave1 = 'COMS.F',
      @Clave2 = 'COMS.FL',
      @Clave3 = 'COMS.EG',
      @Clave4 = 'COMS.EI',
      @Clave5 = 'COMS.F',
      @Clave6 = 'COMS.FL'

  IF @Reporte IN ('Devoluciones')
    SELECT
      @Clave1 = 'COMS.D',
      @Clave2 = 'COMS.B',
      @Clave3 = 'COMS.D',
      @Clave4 = 'COMS.B',
      @Clave5 = 'COMS.D',
      @Clave6 = 'COMS.B'
    
  IF @Reporte IN ('Entradas y Devoluciones')
    SELECT
      @Clave1 = 'COMS.F',
      @Clave2 = 'COMS.FL',
      @Clave3 = 'COMS.EG',
      @Clave4 = 'COMS.EI',
      @Clave5 = 'COMS.D',
      @Clave6 = 'COMS.B'

  INSERT INTO @InformeCompraArtCat(Estacion, Empresa, Moneda, Categoria, Importe, DescuentosTotales, SubTotal, Impuestos, ImporteTotal, ImporteTotalMC, ContMoneda)
  SELECT Estacion, Empresa, Moneda, Categoria, SUM(ISNULL(Importe,0.00)) as Importe, SUM(ISNULL(DescuentosTotales,0.00)) as DescuentosTotales, SUM(ISNULL(SubTotal,0.00)) as SubTotal, SUM(ISNULL(Impuestos,0.00)) as Impuestos, SUM(ISNULL(ImporteTotal,0.00)) as ImporteTotal, SUM(ISNULL(ImporteTotalMC,0.00)) as ImporteTotalMC, ContMoneda
    FROM
    (
    SELECT
        'Estacion'			= @EstacionTrabajo,
        'Empresa'           = c.Empresa,
        'Moneda'            = c.Moneda,
        'Categoria'         = CASE WHEN ISNULL(a.Categoria,'') = '' THEN '(Sin Categoría)' ELSE a.Categoria END,
        'Importe'           = SUM(c.Importe*mt.Factor),
        'DescuentosTotales' = SUM(c.DescuentosTotales*mt.Factor),
        'SubTotal'          = SUM(c.SubTotal*mt.Factor), 
        'Impuestos'         = SUM(c.Impuestos*mt.Factor),
        'ImporteTotal'      = SUM(c.ImporteTotal*mt.Factor),
        'ImporteTotalMC'    = (SUM(c.ImporteTotal*mt.Factor)) * dbo.fnTipoCambio(c.Moneda),
        'ContMoneda'		= e.ContMoneda
     
      FROM Art a
      JOIN CompraTCalc c ON a.Articulo = c.Articulo  
      JOIN MovTipo mt ON  c.Mov = mt.Mov AND mt.Modulo = 'COMS'
      JOIN EmpresaCfg e ON e.Empresa = c.Empresa
     WHERE c.Estatus = 'CONCLUIDO'
       AND c.Empresa = @Empresa
       AND c.FechaEmision BETWEEN @FechaD AND @FechaA
       AND mt.Clave in(@Clave1, @Clave2, @Clave3, @Clave4, @Clave5, @Clave6)
     GROUP BY c.Moneda, a.Categoria, c.Empresa, dbo.fnTipoCambio(c.Moneda), e.ContMoneda
    ) AS x
   GROUP BY Moneda, Categoria, Estacion, Empresa, ContMoneda
  

  INSERT INTO @InformeCompraArtCat(Estacion, Moneda2, Categoria,	Grafica1,   Grafica2, SaldoDescripcion,  SaldoImporte,		             Reporte,  FechaGrafica, Ejercicio, Periodo)
  SELECT                          Estacion, Moneda2, Categoria, @Verdadero, @Falso,   Categoria,         SUM(ISNULL(ImporteTotal,0.00)), @Reporte, Fecha, Ejercicio, Periodo
    FROM
    (
    SELECT
        'Estacion'			= @EstacionTrabajo,
	    'Moneda2'           = c.Moneda,
        'Categoria'         = CASE WHEN ISNULL(a.Categoria,'') = '' THEN '(Sin Categoría)' ELSE a.Categoria END,
        'ImporteTotal'      = SUM(c.ImporteTotal*mt.Factor),
        'Fecha'				= dbo.fnMesNumeroNombre(DATEPART(MONTH,c.FechaEmision)) + ' ' + CONVERT(varchar,DATEPART(YEAR,c.FechaEmision)),
        'Ejercicio'			= DATEPART(YEAR,c.FechaEmision),
        'Periodo'			= DATEPART(MONTH,c.FechaEmision)
     
      FROM Art a
      JOIN CompraTCalc c ON a.Articulo = c.Articulo  
      JOIN MovTipo mt ON  c.Mov = mt.Mov AND mt.Modulo = 'COMS'
      JOIN EmpresaCfg e ON e.Empresa = c.Empresa
     WHERE c.Estatus = 'CONCLUIDO'
       AND c.Empresa = @Empresa
       AND c.FechaEmision BETWEEN @FechaD AND @FechaA
       AND mt.Clave in(@Clave1, @Clave2, @Clave3, @Clave4, @Clave5, @Clave6)
      GROUP BY c.Moneda,  a.Categoria, DATEPART(YEAR,c.FechaEmision), DATEPART(MONTH,c.FechaEmision), c.Empresa, dbo.fnTipoCambio(c.Moneda), e.ContMoneda, dbo.fnMesNumeroNombre(DATEPART(MONTH,c.FechaEmision)) + ' ' + CONVERT(varchar,DATEPART(YEAR,c.FechaEmision))
    ) AS x
   GROUP BY x.Estacion, x.Moneda2, x.Categoria, x.Ejercicio, x.Periodo, x.Fecha
   ORDER BY x.Estacion, x.Moneda2, x.Categoria, x.Ejercicio, x.Periodo, x.Fecha
  
  INSERT INTO @InformeCompraArtCat(Estacion, ContMoneda, Moneda2, Categoria,	Grafica1,   Grafica2,   SaldoDescripcionMC, SaldoImporteMC,		             Reporte,  FechaGrafica, Ejercicio, Periodo)
  SELECT                          Estacion, ContMoneda, Moneda2, Categoria, @Verdadero, @Verdadero, Categoria,          SUM(ISNULL(ImporteTotalMC,0.00)),  @Reporte, Fecha, Ejercicio, Periodo
    FROM
    (
    SELECT
        'Estacion'			= @EstacionTrabajo,
        'ContMoneda'		= e.ContMoneda,
	    'Moneda2'           = e.ContMoneda,
        'Categoria'         = CASE WHEN ISNULL(a.Categoria,'') = '' THEN '(Sin Categoría)' ELSE a.Categoria END,
        'ImporteTotalMC'    = (SUM(c.ImporteTotal*mt.Factor)) * dbo.fnTipoCambio(c.Moneda),
        'Fecha'				= dbo.fnMesNumeroNombre(DATEPART(MONTH,c.FechaEmision)) + ' ' + CONVERT(varchar,DATEPART(YEAR,c.FechaEmision)),
        'Ejercicio'			= DATEPART(YEAR,c.FechaEmision),
        'Periodo'			= DATEPART(MONTH,c.FechaEmision)
     
      FROM Art a
      JOIN CompraTCalc c ON a.Articulo = c.Articulo  
      JOIN MovTipo mt ON  c.Mov = mt.Mov AND mt.Modulo = 'COMS'
      JOIN EmpresaCfg e ON e.Empresa = c.Empresa
     WHERE c.Estatus = 'CONCLUIDO'
       AND c.Empresa = @Empresa
       AND c.FechaEmision BETWEEN @FechaD AND @FechaA
       AND mt.Clave in(@Clave1, @Clave2, @Clave3, @Clave4, @Clave5, @Clave6)
      GROUP BY c.Moneda,  a.Categoria, DATEPART(YEAR,c.FechaEmision), DATEPART(MONTH,c.FechaEmision), c.Empresa, dbo.fnTipoCambio(c.Moneda), e.ContMoneda, dbo.fnMesNumeroNombre(DATEPART(MONTH,c.FechaEmision)) + ' ' + CONVERT(varchar,DATEPART(YEAR,c.FechaEmision))
    ) AS x
   GROUP BY x.Estacion, x.Moneda2, x.Categoria, x.Ejercicio, x.Periodo, x.Fecha, x.ContMoneda
   ORDER BY x.Estacion, x.Moneda2, x.Categoria, x.Ejercicio, x.Periodo, x.Fecha, x.ContMoneda


  DECLARE crGraficar CURSOR FAST_FORWARD FOR
   SELECT Moneda2, Grafica2
     FROM @InformeCompraArtCat
    WHERE Estacion = @EstacionTrabajo
      AND Grafica1 = 1
    GROUP BY Moneda2, Grafica2

  OPEN crGraficar
  FETCH NEXT FROM crGraficar INTO @Moneda, @Grafica2
  WHILE @@FETCH_STATUS = 0
  BEGIN
  
    SELECT @Graficar = NULL
    SELECT @Graficar = COUNT(DISTINCT FechaGrafica)
      FROM @InformeCompraArtCat 
     WHERE Estacion = @EstacionTrabajo
       AND Grafica1 = 1
       AND Grafica2 = @Grafica2
       AND Moneda2 = @Moneda

    IF @Graficar > @GraficarFecha
      DELETE @InformeCompraArtCat 
       WHERE FechaGrafica IN(
             SELECT TOP (@Graficar - @GraficarFecha) FechaGrafica
               FROM @InformeCompraArtCat 
              WHERE Estacion = @EstacionTrabajo
                AND Grafica1 = 1
                AND Grafica2 = @Grafica2
                AND Moneda2 = @Moneda
              GROUP BY Ejercicio, Periodo, FechaGrafica
              ORDER BY Ejercicio DESC, Periodo DESC, FechaGrafica DESC)
         AND Estacion = @EstacionTrabajo
         AND Grafica1 = 1
         AND Grafica2 = @Grafica2
         AND Moneda2 = @Moneda

    SELECT @Graficar = NULL
    SELECT @Graficar = ISNULL(COUNT(DISTINCT Categoria),0)
      FROM @InformeCompraArtCat
     WHERE Estacion = @EstacionTrabajo
       AND Grafica1 = 0
       AND @Moneda = CASE WHEN @Grafica2 = 0 THEN Moneda ELSE ContMoneda END
       
    IF @GraficarTipo = 'Mas Sobresalientes' AND @Graficar > @GraficarCantidad
      DELETE @InformeCompraArtCat 
       WHERE Categoria NOT IN(
      SELECT  TOP (@GraficarCantidad) Categoria
        FROM
        (
        SELECT
            'Categoria'         = Categoria,
            'SaldoImporte'      = SUM(SaldoImporte)+ SUM(SaldoImporteMC)
     
          FROM @InformeCompraArtCat
         WHERE Estacion = @EstacionTrabajo
           AND Grafica1 = 1
           AND Grafica2 = @Grafica2
           AND Moneda2 = @Moneda
          GROUP BY Moneda,  Categoria
        ) AS x
       GROUP BY x.Categoria
       ORDER BY SUM(ISNULL(x.SaldoImporte,0.00))DESC)
         AND Estacion = @EstacionTrabajo
         AND Grafica1 = 1
         AND Grafica2 = @Grafica2
         AND @Moneda = CASE WHEN @Grafica2 = 0 THEN Moneda2 ELSE ContMoneda END

    IF @GraficarTipo = 'Menos Sobresalientes' AND @Graficar > @GraficarCantidad
      DELETE @InformeCompraArtCat 
       WHERE Categoria NOT IN(
      SELECT  TOP (@GraficarCantidad) Categoria
        FROM
        (
        SELECT
            'Categoria'         = Categoria,
            'SaldoImporte'      = SUM(SaldoImporte)+ SUM(SaldoImporteMC)
     
          FROM @InformeCompraArtCat
         WHERE Estacion = @EstacionTrabajo
           AND Grafica1 = 1
           AND Grafica2 = @Grafica2
           AND @Moneda = CASE WHEN @Grafica2 = 0 THEN Moneda2 ELSE ContMoneda END
          GROUP BY Moneda,  Categoria
        ) AS x
       GROUP BY x.Categoria
       ORDER BY SUM(ISNULL(x.SaldoImporte,0.00))ASC)
         AND Estacion = @EstacionTrabajo
         AND Grafica1 = 1
         AND Grafica2 = @Grafica2
         AND Moneda2 = @Moneda
           
    FETCH NEXT FROM crGraficar INTO @Moneda, @Grafica2
  END
  CLOSE crGraficar
  DEALLOCATE crGraficar

   
  UPDATE @InformeCompraArtCat SET FechaDesde = @FechaD, FechaHasta = @FechaA, Titulo = @Titulo, EmpresaNombre = @EmpresaNombre, Etiqueta = @Etiqueta, Reporte = @Reporte WHERE Estacion = @EstacionTrabajo
  
  SELECT * , @VerGraficaDetalle as VerGraficaDetalle FROM @InformeCompraArtCat WHERE Estacion = @EstacionTrabajo ORDER BY IDInforme
  
END
GO
--USE TRANSMARES
--EXEC spInformeCompraArtCat 1


/******************************* spInformeCompraNeta *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spInformeCompraNeta') and type = 'P') drop procedure dbo.spInformeCompraNeta
GO             
CREATE PROCEDURE spInformeCompraNeta
		@EstacionTrabajo		int

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
	@FechaD					datetime,
	@FechaA					datetime,
	@Reporte				varchar(30),
	@Empresa				char(5),
	@Verdadero				bit,
	@Falso					bit,
	@Clave1					varchar(20),
	@Clave2					varchar(20),
	@Clave3					varchar(20),
	@Clave4					varchar(20),
	@Clave5					varchar(20),
	@Clave6					varchar(20),
	@Moneda					varchar(20),
	@FechaEmision			datetime,
	@ImporteTotal			money,
	@ImporteTotalMC			money,
	@FechaGrafica			varchar(100),
	@Titulo					varchar(100),
	@EmpresaNombre			varchar(100),
	@Graficar				int,
	@Grafica2				bit,
	@GraficarFecha			int,
    @Etiqueta				bit,
    @VerGraficaDetalle		bit


  DECLARE @InformeCompraNeta TABLE
  (
	Estacion			int 	    	NOT	NULL,
    IDInforme			int 	    	NOT NULL  IDENTITY(1,1),
    ID					int 	    		NULL,
	Empresa				char(5)				NULL,
	Mov 				char(20)			NULL,
	MovID				char(20)       		NULL,
	Moneda  			char(10)   			NULL, 
	TipoCambio			float				NULL,	
	Concepto 			varchar(50) 		NULL,
	Referencia 			varchar(50) 		NULL,
	Proyecto  			varchar(50)   		NULL,	
	FechaEmision 		datetime    		NULL,
	FechaRequerida		datetime    		NULL,	
	Prioridad			char(10)			NULL,
	Estatus 			char(15)   			NULL,
	Situacion			varchar(50)			NULL,
	SituacionFecha		datetime    		NULL,	
	Proveedor 			char(10)   			NULL,
	Almacen				char(10)   			NULL,
	Agente 				char(10)   			NULL,
	FormaEnvio 			varchar(50)   		NULL,
	Condicion 			varchar(50)   		NULL,
	Vencimiento			datetime    		NULL,
	Usuario 			char(10)   			NULL,
	Observaciones 		varchar(100) 		NULL,	
	DescuentoGlobal		float				NULL,
	Importe				money				NULL,
	DescuentoLineal		float				NULL,
	DescuentosTotales	money				NULL,	
	SubTotal			money				NULL,
	Impuestos			money				NULL,
	ImporteTotal		money				NULL,
	Peso				float				NULL,
	Volumen				float				NULL,	
	ProveedorNombre		varchar(100)		NULL,
	Total				bit					NULL DEFAULT 0,
	ContMoneda			char(10)			NULL,
	ImporteTotalMC		money				NULL,
	FechaGrafica		varchar(100)		NULL,
	Grafica1 			bit					NULL DEFAULT 0.0,
	Grafica2 			bit					NULL DEFAULT 0.0,
	Reporte				varchar(100)		NULL,
	SaldoDescripcion	varchar(50)			NULL,
    SaldoImporte		money				NULL DEFAULT 0.0,
    Movimiento			varchar(50)			NULL,
    SaldoDescripcionMC	varchar(50)			NULL,
    SaldoImporteMC		money				NULL DEFAULT 0.0,
    FechaDesde			datetime			NULL,
    FechaHasta			datetime			NULL,
    Titulo				varchar(100)		NULL,
	EmpresaNombre		varchar(100)		NULL,
	Periodo				int					NULL,
	Ejercicio			int					NULL,
	Etiqueta			bit					NULL  DEFAULT 0
  )    

  SELECT @Verdadero = 1, @Falso = 0
  SELECT 
  	  @FechaD  = InfoFechaD,
	  @FechaA  = InfoFechaA,
	  @Reporte = InfoRepCompras,
	  @Empresa = InfoEmpresa,
	  @Titulo = RepTitulo,
	  @GraficarFecha = ISNULL(InformeGraficarFecha,12),
	  @Etiqueta = ISNULL(InfoEtiqueta, @Falso),
    @VerGraficaDetalle = ISNULL(VerGraficaDetalle,0)
    FROM RepParam 
   WHERE Estacion = @EstacionTrabajo

  SELECT @EmpresaNombre = (SELECT Nombre FROM Empresa WHERE Empresa = @Empresa)

  IF @Reporte IN ('Entradas')
    SELECT
      @Clave1 = 'COMS.F',
      @Clave2 = 'COMS.FL',
      @Clave3 = 'COMS.EG',
      @Clave4 = 'COMS.EI',
      @Clave5 = 'COMS.F',
      @Clave6 = 'COMS.FL'

  IF @Reporte IN ('Devoluciones')
    SELECT
      @Clave1 = 'COMS.D',
      @Clave2 = 'COMS.B',
      @Clave3 = 'COMS.D',
      @Clave4 = 'COMS.B',
      @Clave5 = 'COMS.D',
      @Clave6 = 'COMS.B'
    
  IF @Reporte IN ('Entradas y Devoluciones')
    SELECT
      @Clave1 = 'COMS.F',
      @Clave2 = 'COMS.FL',
      @Clave3 = 'COMS.EG',
      @Clave4 = 'COMS.EI',
      @Clave5 = 'COMS.D',
      @Clave6 = 'COMS.B'


  INSERT INTO @InformeCompraNeta
  SELECT
    'Estacion'			= @EstacionTrabajo,
    c.ID,
    c.Empresa,
    c.Mov,
    c.MovID,
    UPPER(c.Moneda),
    c.TipoCambio,
    c.Concepto,
    c.Referencia,
    c.Proyecto,
    c.FechaEmision,
    c.FechaRequerida,
    c.Prioridad,
    c.Estatus,
    c.Situacion,
    c.SituacionFecha,
    c.Proveedor,
    c.Almacen,
    c.Agente,
    c.FormaEnvio,
    c.Condicion,
    c.Vencimiento,
    c.Usuario,
    c.Observaciones,
    c.DescuentoGlobal,
    'Importe'           = c.Importe*mt.Factor,
    'DescuentoLineal'   = c.DescuentoLineal*mt.Factor,
    'DescuentosTotales' = c.DescuentosTotales*mt.Factor,
    'SubTotal'          = c.SubTotal*mt.Factor,
    'Impuestos'         = c.Impuestos*mt.Factor,
    'ImporteTotal'      = c.ImporteTotal*mt.Factor,
    'Peso'              = c.Peso*mt.Factor,
    'Volumen'           = c.Volumen*mt.Factor,
    'ProveedorNombre'   = Prov.Nombre,
    'Total'				= @Falso,
    'ContMoneda'		= UPPER(e.ContMoneda),
    'ImporteTotalMC'    = CASE WHEN e.ContMoneda = c.Moneda THEN (c.ImporteTotal*mt.Factor) ELSE (c.ImporteTotal*mt.Factor) * dbo.fnTipoCambio(c.Moneda) END,    
    'FechaGrafica'		= NULL,
    'Grafica1'			= @Falso,
    'Grafica2'			= @Falso,
    'Reporte'			= @Reporte,
    'SaldoDescripcion'  = NULL,
    'SaldoImporte'		= NULL,
    'Movimiento'		= c.Mov + ' ' + c.MovID,
    'SaldoDescripcionMC'= NULL,
    'SaldoImporteMC'	= NULL,
    'FechaDesde'		= @FechaD,
    'FechaHasta'		= @FechaA,
    'Titulo'			= @Titulo,
    'EmpresaNombre'		= @EmpresaNombre,
    'Ejercicio'			= NULL,
    'Periodo'			= NULL,
    'Etiqueta'			= @Etiqueta
    
    FROM CompraCalc c
    JOIN Prov ON c.Proveedor=Prov.Proveedor
    JOIN MovTipo mt ON c.Mov = mt.Mov AND mt.Modulo = 'COMS'
    JOIN EmpresaCfg e ON e.Empresa = c.Empresa
   WHERE c.Estatus = 'CONCLUIDO'
     AND c.Empresa = @Empresa
     AND c.FechaEmision BETWEEN @FechaD AND @FechaA
     AND mt.Clave in(@Clave1, @Clave2, @Clave3, @Clave4, @Clave5, @Clave6)

  INSERT INTO @InformeCompraNeta (Estacion, Moneda, FechaEmision, Importe, DescuentoLineal, DescuentosTotales, SubTotal, Impuestos, ImporteTotal, Peso, Volumen, Total, ContMoneda, Grafica1, Grafica2, Reporte, FechaDesde, FechaHasta)
  SELECT
    'Estacion'			= @EstacionTrabajo,  
    'Moneda'			= 'Total',
    'FechaEmision'		= (SELECT MAX(FechaEmision) + 1 FROM VENTA),
    'Importe'           = SUM(CASE WHEN e.ContMoneda = c.Moneda THEN (c.Importe*mt.Factor) ELSE (c.Importe*mt.Factor) * dbo.fnTipoCambio(c.Moneda) END),
    'DescuentoLineal'   = SUM(CASE WHEN e.ContMoneda = c.Moneda THEN (c.DescuentoLineal*mt.Factor) ELSE (c.DescuentoLineal*mt.Factor) * dbo.fnTipoCambio(c.Moneda) END),
    'DescuentosTotales' = SUM(CASE WHEN e.ContMoneda = c.Moneda THEN (c.DescuentosTotales*mt.Factor) ELSE (c.DescuentosTotales*mt.Factor) * dbo.fnTipoCambio(c.Moneda) END),
    'SubTotal'          = SUM(CASE WHEN e.ContMoneda = c.Moneda THEN (c.SubTotal*mt.Factor) ELSE (c.SubTotal*mt.Factor) * dbo.fnTipoCambio(c.Moneda) END),
    'Impuestos'         = SUM(CASE WHEN e.ContMoneda = c.Moneda THEN (c.Impuestos*mt.Factor) ELSE (c.Impuestos*mt.Factor) * dbo.fnTipoCambio(c.Moneda) END),
    'ImporteTotal'      = SUM(CASE WHEN e.ContMoneda = c.Moneda THEN (c.ImporteTotal*mt.Factor) ELSE (c.ImporteTotal*mt.Factor) * dbo.fnTipoCambio(c.Moneda) END),
    'Peso'              = SUM(CASE WHEN e.ContMoneda = c.Moneda THEN (c.Peso*mt.Factor) ELSE (c.Peso*mt.Factor) * dbo.fnTipoCambio(c.Moneda) END),
    'Volumen'           = SUM(CASE WHEN e.ContMoneda = c.Moneda THEN (c.Volumen*mt.Factor) ELSE (c.Volumen*mt.Factor) * dbo.fnTipoCambio(c.Moneda) END),
    'Total'				= @Verdadero,
    'ContMoneda'        = UPPER(RTRIM(LTRIM(e.ContMoneda))),
    'Grafica1'			= @Falso,
    'Grafica2'			= @Falso,
    'Reporte'			= @Reporte,
    'FechaDesde'		= @FechaD,
    'FechaHasta'		= @FechaA
    
    FROM CompraCalc c
    JOIN Prov ON c.Proveedor=Prov.Proveedor
    JOIN MovTipo mt ON c.Mov = mt.Mov AND mt.Modulo = 'COMS'
    JOIN EmpresaCfg e ON e.Empresa = c.Empresa
   WHERE c.Estatus = 'CONCLUIDO'
     AND c.Empresa = @Empresa
     AND c.FechaEmision BETWEEN @FechaD AND @FechaA
     AND mt.Clave in(@Clave1, @Clave2, @Clave3, @Clave4, @Clave5, @Clave6)
   GROUP BY e.ContMoneda

  DECLARE crGrafica CURSOR FAST_FORWARD FOR
   SELECT Moneda, (SELECT MAX(FechaEmision) + 2 FROM Compra), SUM(ImporteTotal), dbo.fnMesNumeroNombre(DATEPART(MONTH,FechaEmision)) + ' ' + CONVERT(varchar,DATEPART(YEAR,FechaEmision))
     FROM @InformeCompraNeta
    WHERE Estacion = @EstacionTrabajo
      AND Grafica1 = 0
      AND Total = 0
      AND FechaGrafica IS NULL
    GROUP BY DATEPART(MONTH,FechaEmision), DATEPART(YEAR,FechaEmision), Moneda

  OPEN crGrafica
  FETCH NEXT FROM crGrafica INTO @Moneda, @FechaEmision, @ImporteTotal, @FechaGrafica
  WHILE @@FETCH_STATUS = 0 --AND @Ok IS NULL
  BEGIN

    INSERT INTO @InformeCompraNeta(Estacion,         Moneda,  FechaEmision,  FechaGrafica,  Grafica1,   SaldoDescripcion,  SaldoImporte)
      SELECT                    @EstacionTrabajo, @Moneda, @FechaEmision, @FechaGrafica, @Verdadero, 'ImporteTotal',    @ImporteTotal
    
    FETCH NEXT FROM crGrafica INTO @Moneda, @FechaEmision, @ImporteTotal, @FechaGrafica
  END
  CLOSE crGrafica
  DEALLOCATE crGrafica


  DECLARE crGrafica1 CURSOR FAST_FORWARD FOR
   SELECT RTRIM(LTRIM(ContMoneda)), (SELECT MAX(FechaEmision) + 3 FROM Compra), SUM(ImporteTotalMC), dbo.fnMesNumeroNombre(DATEPART(MONTH, FechaEmision)) + ' ' + CONVERT(varchar,DATEPART(YEAR, FechaEmision)) 
     FROM @InformeCompraNeta
    WHERE Estacion = @EstacionTrabajo
      AND Grafica1 = 0
      AND Total = 0
      AND FechaGrafica IS NULL
    GROUP BY DATEPART(MONTH, FechaEmision), DATEPART(YEAR, FechaEmision), ContMoneda

  OPEN crGrafica1
  FETCH NEXT FROM crGrafica1 INTO @Moneda, @FechaEmision, @ImporteTotalMC, @FechaGrafica
   WHILE @@FETCH_STATUS = 0 --AND @Ok IS NULL
   BEGIN
  
     INSERT INTO @InformeCompraNeta(Estacion,         Moneda,  FechaEmision,  FechaGrafica, Grafica1,   Grafica2,   SaldoDescripcionMC,  SaldoImporteMC)
       SELECT                    @EstacionTrabajo, @Moneda, @FechaEmision, @FechaGrafica, @Verdadero, @Verdadero, 'Importe Total MC',  @ImporteTotalMC

     FETCH NEXT FROM crGrafica1 INTO @Moneda, @FechaEmision, @ImporteTotalMC, @FechaGrafica
   END
   CLOSE crGrafica1
   DEALLOCATE crGrafica1

  DECLARE crGraficar CURSOR FAST_FORWARD FOR
   SELECT Moneda, Grafica2
     FROM @InformeCompraNeta
    WHERE Estacion = @EstacionTrabajo
      AND Grafica1 = 1
    GROUP BY Moneda, Grafica2

  OPEN crGraficar
  FETCH NEXT FROM crGraficar INTO @Moneda, @Grafica2
  WHILE @@FETCH_STATUS = 0
  BEGIN
  
    SELECT @Graficar = NULL
    SELECT @Graficar = COUNT(DISTINCT FechaGrafica)
      FROM @InformeCompraNeta 
     WHERE Estacion = @EstacionTrabajo
       AND Grafica1 = 1
       AND Grafica2 = @Grafica2
       AND Moneda = @Moneda

    IF @Graficar > @GraficarFecha
      DELETE @InformeCompraNeta 
       WHERE FechaGrafica IN(
             SELECT TOP (@Graficar - @GraficarFecha) FechaGrafica
               FROM @InformeCompraNeta 
              WHERE Estacion = @EstacionTrabajo
                AND Grafica1 = 1
                AND Grafica2 = @Grafica2
                AND Moneda = @Moneda
              GROUP BY Ejercicio, Periodo, FechaGrafica
              ORDER BY Ejercicio DESC, Periodo DESC, FechaGrafica DESC)
         AND Estacion = @EstacionTrabajo
         AND Grafica1 = 1
         AND Grafica2 = @Grafica2
         AND Moneda = @Moneda
           
    FETCH NEXT FROM crGraficar INTO @Moneda, @Grafica2
  END
  CLOSE crGraficar
  DEALLOCATE crGraficar

   
  UPDATE @InformeCompraNeta SET FechaDesde = @FechaD, FechaHasta = @FechaA, Titulo = @Titulo, EmpresaNombre = @EmpresaNombre, Etiqueta = @Etiqueta, Reporte = @Reporte WHERE Estacion = @EstacionTrabajo
  
  SELECT * , @VerGraficaDetalle as VerGraficaDetalle FROM @InformeCompraNeta WHERE Estacion = @EstacionTrabajo ORDER BY IDInforme
  
END
GO
--EXEC spInformeCompraNeta 1


/******************************* spInformeCompraProvCat *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spInformeCompraProvCat') and type = 'P') drop procedure dbo.spInformeCompraProvCat
GO             
CREATE PROCEDURE spInformeCompraProvCat
		@EstacionTrabajo		int

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
	@FechaD					datetime,
	@FechaA					datetime,
	@Reporte				varchar(30),
	@Empresa				char(5),
	@Verdadero				bit,
	@Falso					bit,
	@Clave1					varchar(20),
	@Clave2					varchar(20),
	@Clave3					varchar(20),
	@Clave4					varchar(20),
	@Clave5					varchar(20),
	@Clave6					varchar(20),
	@Moneda					varchar(20),
	@ImporteTotal			money,
	@ImporteTotalMC			money,
    @Categoria				varchar(20),
    @FechaGrafica			varchar(50),
    @Periodo				int,
    @Ejercicio				int,
    @Titulo					varchar(100),
	@EmpresaNombre			varchar(100),
	@Graficar				int,
	@Grafica2				bit,
	@GraficarFecha			int,
	@GraficarTipo			varchar(30),
	@Etiqueta				bit,
	@GraficarCantidad		int,
    @VerGraficaDetalle		bit
	    

  DECLARE @InformeCompraProvCat TABLE
  (
	Estacion			int 	    	NOT	NULL,
    IDInforme			int 	    	NOT NULL  IDENTITY(1,1),
	Empresa				char(5)				NULL,
	Moneda  			char(10)   			NULL, 
	Moneda2  			char(10)   			NULL, 
	Categoria  			varchar(50) 		NULL, 
	Importe				money				NULL,
	DescuentosTotales	money				NULL,
	SubTotal			money				NULL,
	Impuestos			money				NULL,
	ImporteTotal		money				NULL,	
	ImporteTotalMC		money				NULL,
	SaldoDescripcion	varchar(50)			NULL,
    SaldoImporte		money				NULL DEFAULT 0.0,
    SaldoDescripcionMC	varchar(50)			NULL,
    SaldoImporteMC		money				NULL DEFAULT 0.0,
	Grafica1 			bit					NULL DEFAULT 0,
	Grafica2 			bit					NULL DEFAULT 0,
	Reporte				varchar(100)		NULL,
	Total				bit					NULL DEFAULT 0,
	ContMoneda			char(10)			NULL,
	FechaGrafica		varchar(100)		NULL,
	FechaDesde			datetime			NULL,
    FechaHasta			datetime			NULL,
    Titulo				varchar(100)		NULL,
	EmpresaNombre		varchar(100)		NULL,
	Periodo				int					NULL,
	Ejercicio			int					NULL,
	Etiqueta			bit					NULL  DEFAULT 0
  )    

  
  SELECT @Verdadero = 1, @Falso = 0
  SELECT 
  	  @FechaD  = InfoFechaD,
	  @FechaA  = InfoFechaA,
	  @Reporte = InfoRepCompras,
	  @Empresa = InfoEmpresa,
	  @Titulo = RepTitulo,
	  @GraficarFecha = ISNULL(InformeGraficarFecha,12),
	  @GraficarTipo = ISNULL(InformeGraficarTipo,  '(Todos)'),
	  @Etiqueta = ISNULL(InfoEtiqueta, @Falso),
	  @GraficarCantidad = ISNULL(InformeGraficarCantidad, 5),
    @VerGraficaDetalle = ISNULL(VerGraficaDetalle,0)
    FROM RepParam 
   WHERE Estacion = @EstacionTrabajo

  SELECT @EmpresaNombre = (SELECT Nombre FROM Empresa WHERE Empresa = @Empresa)
  
  IF @Reporte IN ('Entradas')
    SELECT
      @Clave1 = 'COMS.F',
      @Clave2 = 'COMS.FL',
      @Clave3 = 'COMS.EG',
      @Clave4 = 'COMS.EI',
      @Clave5 = 'COMS.F',
      @Clave6 = 'COMS.FL'

  IF @Reporte IN ('Devoluciones')
    SELECT
      @Clave1 = 'COMS.D',
      @Clave2 = 'COMS.B',
      @Clave3 = 'COMS.D',
      @Clave4 = 'COMS.B',
      @Clave5 = 'COMS.D',
      @Clave6 = 'COMS.B'
    
  IF @Reporte IN ('Entradas y Devoluciones')
    SELECT
      @Clave1 = 'COMS.F',
      @Clave2 = 'COMS.FL',
      @Clave3 = 'COMS.EG',
      @Clave4 = 'COMS.EI',
      @Clave5 = 'COMS.D',
      @Clave6 = 'COMS.B'


  INSERT INTO @InformeCompraProvCat (Estacion, Empresa, Moneda, Categoria, Importe, DescuentosTotales, SubTotal, Impuestos, ImporteTotal, ImporteTotalMC, ContMoneda)
  SELECT Estacion, Empresa, Moneda, Categoria, SUM(ISNULL(Importe,0.00)) as Importe, SUM(ISNULL(DescuentosTotales,0.00)) as DescuentosTotales, SUM(ISNULL(SubTotal,0.00)) as SubTotal, SUM(ISNULL(Impuestos,0.00)) as Impuestos, SUM(ISNULL(ImporteTotal,0.00)) as ImporteTotal, SUM(ISNULL(ImporteTotalMC,0.00)) as ImporteTotalMC, ContMoneda
    FROM
    (
    SELECT
        'Estacion'			= @EstacionTrabajo,
        'Empresa'           = c.Empresa,
        'Moneda'            = c.Moneda,
        'Categoria'         = CASE WHEN ISNULL(p.Categoria,'(Sin Categoría)') = '' THEN '(Sin Categoría)' ELSE ISNULL(p.Categoria,'(Sin Categoría)') END,
        'Importe'           = SUM(c.Importe*mt.Factor),
        'DescuentosTotales' = SUM(c.DescuentosTotales*mt.Factor),
        'SubTotal'          = SUM(c.SubTotal*mt.Factor), 
        'Impuestos'         = SUM(c.Impuestos*mt.Factor),
        'ImporteTotal'      = SUM(c.ImporteTotal*mt.Factor),
        'ImporteTotalMC'    = (SUM(c.ImporteTotal*mt.Factor)) * dbo.fnTipoCambio(c.Moneda),
        'ContMoneda'		= e.ContMoneda
               
      FROM CompraCalc c
      JOIN Prov p ON p.Proveedor = c.Proveedor
      JOIN MovTipo mt ON c.Mov = mt.Mov AND mt.Modulo = 'COMS'
      JOIN EmpresaCfg e ON e.Empresa = c.Empresa
     WHERE c.Estatus = 'CONCLUIDO'
       AND c.Empresa = @Empresa
       AND c.FechaEmision BETWEEN @FechaD AND @FechaA
       AND mt.Clave in(@Clave1, @Clave2, @Clave3, @Clave4, @Clave5, @Clave6)
     GROUP BY c.Moneda, ISNULL(p.Categoria,'(Sin Categoría)'), dbo.fnTipoCambio(c.Moneda), e.ContMoneda, c.Empresa
    ) AS x
   GROUP BY Moneda, Categoria, Estacion, Empresa, ContMoneda
   
  INSERT INTO @InformeCompraProvCat(Estacion, Moneda2, Categoria, Grafica1,   Grafica2, SaldoDescripcion,  SaldoImporte,		              Reporte,  FechaGrafica, Ejercicio, Periodo)
  SELECT                           Estacion, Moneda2, Categoria, @Verdadero, @Falso,   Categoria,         SUM(ISNULL(ImporteTotal,0.00)), @Reporte, Fecha, Ejercicio, Periodo
    FROM
    (
    SELECT
        'Estacion'			= @EstacionTrabajo,
	    'Moneda2'           = c.Moneda,
        'Categoria'         = CASE WHEN ISNULL(p.Categoria,'') = '' THEN '(Sin Categoría)' ELSE p.Categoria END,
        'ImporteTotal'      = SUM(c.ImporteTotal*mt.Factor),
        'Fecha'				= dbo.fnMesNumeroNombre(DATEPART(MONTH,c.FechaEmision)) + ' ' + CONVERT(varchar,DATEPART(YEAR,c.FechaEmision)),
        'Ejercicio'			= DATEPART(YEAR,c.FechaEmision),
        'Periodo'			= DATEPART(MONTH,c.FechaEmision)
     
      FROM CompraCalc c
      JOIN Prov p ON p.Proveedor = c.Proveedor
      JOIN MovTipo mt ON c.Mov = mt.Mov AND mt.Modulo = 'COMS'
      JOIN EmpresaCfg e ON e.Empresa = c.Empresa
     WHERE c.Estatus = 'CONCLUIDO'
       AND c.Empresa = @Empresa
       AND c.FechaEmision BETWEEN @FechaD AND @FechaA
       AND mt.Clave in(@Clave1, @Clave2, @Clave3, @Clave4, @Clave5, @Clave6)
      GROUP BY c.Moneda,  p.Categoria, DATEPART(YEAR,c.FechaEmision), DATEPART(MONTH,c.FechaEmision), c.Empresa, dbo.fnTipoCambio(c.Moneda), e.ContMoneda, dbo.fnMesNumeroNombre(DATEPART(MONTH,c.FechaEmision)) + ' ' + CONVERT(varchar,DATEPART(YEAR,c.FechaEmision))
    ) AS x
   GROUP BY x.Estacion, x.Moneda2, x.Categoria, x.Ejercicio, x.Periodo, x.Fecha
   ORDER BY x.Estacion, x.Moneda2, x.Categoria, x.Ejercicio, x.Periodo, x.Fecha

  INSERT INTO @InformeCompraProvCat(Estacion, ContMoneda, Moneda2, Categoria, Grafica1,   Grafica2,   SaldoDescripcionMC,  SaldoImporteMC,		          Reporte,  FechaGrafica, Ejercicio, Periodo)
  SELECT                           Estacion, ContMoneda, Moneda2, Categoria, @Verdadero, @Verdadero, Categoria,         SUM(ISNULL(ImporteTotalMC,0.00)), @Reporte, Fecha, Ejercicio, Periodo
    FROM
    (
    SELECT
        'Estacion'			= @EstacionTrabajo,
        'ContMoneda'		= e.ContMoneda,
	    'Moneda2'           = e.ContMoneda,
        'Categoria'         = CASE WHEN ISNULL(p.Categoria,'') = '' THEN '(Sin Categoría)' ELSE p.Categoria END,
        'ImporteTotalMC'    = (SUM(c.ImporteTotal*mt.Factor)) * dbo.fnTipoCambio(c.Moneda),
        'Fecha'				= dbo.fnMesNumeroNombre(DATEPART(MONTH,c.FechaEmision)) + ' ' + CONVERT(varchar,DATEPART(YEAR,c.FechaEmision)),
        'Ejercicio'			= DATEPART(YEAR,c.FechaEmision),
        'Periodo'			= DATEPART(MONTH,c.FechaEmision)
     
      FROM CompraCalc c
      JOIN Prov p ON p.Proveedor = c.Proveedor
      JOIN MovTipo mt ON c.Mov = mt.Mov AND mt.Modulo = 'COMS'
      JOIN EmpresaCfg e ON e.Empresa = c.Empresa
     WHERE c.Estatus = 'CONCLUIDO'
       AND c.Empresa = @Empresa
       AND c.FechaEmision BETWEEN @FechaD AND @FechaA
       AND mt.Clave in(@Clave1, @Clave2, @Clave3, @Clave4, @Clave5, @Clave6)
      GROUP BY c.Moneda,  p.Categoria, DATEPART(YEAR,c.FechaEmision), DATEPART(MONTH,c.FechaEmision), c.Empresa, dbo.fnTipoCambio(c.Moneda), e.ContMoneda, dbo.fnMesNumeroNombre(DATEPART(MONTH,c.FechaEmision)) + ' ' + CONVERT(varchar,DATEPART(YEAR,c.FechaEmision))
    ) AS x
   GROUP BY x.Estacion, x.Moneda2, x.Categoria, x.Ejercicio, x.Periodo, x.Fecha, x.ContMoneda
   ORDER BY x.Estacion, x.Moneda2, x.Categoria, x.Ejercicio, x.Periodo, x.Fecha, x.ContMoneda


  DECLARE crGraficar CURSOR FAST_FORWARD FOR
   SELECT Moneda2, Grafica2
     FROM @InformeCompraProvCat
    WHERE Estacion = @EstacionTrabajo
      AND Grafica1 = 1
    GROUP BY Moneda2, Grafica2

  OPEN crGraficar
  FETCH NEXT FROM crGraficar INTO @Moneda, @Grafica2
  WHILE @@FETCH_STATUS = 0
  BEGIN
  
    SELECT @Graficar = NULL
    SELECT @Graficar = COUNT(DISTINCT FechaGrafica)
      FROM @InformeCompraProvCat 
     WHERE Estacion = @EstacionTrabajo
       AND Grafica1 = 1
       AND Grafica2 = @Grafica2
       AND Moneda2 = @Moneda

    IF @Graficar > @GraficarFecha
      DELETE @InformeCompraProvCat 
       WHERE FechaGrafica IN(
             SELECT TOP (@Graficar - @GraficarFecha) FechaGrafica
               FROM @InformeCompraProvCat 
              WHERE Estacion = @EstacionTrabajo
                AND Grafica1 = 1
                AND Grafica2 = @Grafica2
                AND Moneda2 = @Moneda
              GROUP BY Ejercicio, Periodo, FechaGrafica
              ORDER BY Ejercicio DESC, Periodo DESC, FechaGrafica DESC)
         AND Estacion = @EstacionTrabajo
         AND Grafica1 = 1
         AND Grafica2 = @Grafica2
         AND Moneda2 = @Moneda

    SELECT @Graficar = NULL
    SELECT @Graficar = ISNULL(COUNT(DISTINCT Categoria),0)
      FROM @InformeCompraProvCat
     WHERE Estacion = @EstacionTrabajo
       AND Grafica1 = 0
       AND @Moneda = CASE WHEN @Grafica2 = 0 THEN Moneda ELSE ContMoneda END
       
    IF @GraficarTipo = 'Mas Sobresalientes' AND @Graficar > @GraficarCantidad
      DELETE @InformeCompraProvCat 
       WHERE Categoria NOT IN(
      SELECT  TOP (@GraficarCantidad) Categoria
        FROM
        (
        SELECT
            'Categoria'         = Categoria,
            'SaldoImporte'      = SUM(SaldoImporte)+ SUM(SaldoImporteMC)
     
          FROM @InformeCompraProvCat
         WHERE Estacion = @EstacionTrabajo
           AND Grafica1 = 1
           AND Grafica2 = @Grafica2
           AND Moneda2 = @Moneda
          GROUP BY Moneda,  Categoria
        ) AS x
       GROUP BY x.Categoria
       ORDER BY SUM(ISNULL(x.SaldoImporte,0.00))DESC)
         AND Estacion = @EstacionTrabajo
         AND Grafica1 = 1
         AND Grafica2 = @Grafica2
         AND @Moneda = CASE WHEN @Grafica2 = 0 THEN Moneda2 ELSE ContMoneda END

    IF @GraficarTipo = 'Menos Sobresalientes' AND @Graficar > @GraficarCantidad
      DELETE @InformeCompraProvCat 
       WHERE Categoria NOT IN(
      SELECT  TOP (@GraficarCantidad) Categoria
        FROM
        (
        SELECT
            'Categoria'         = Categoria,
            'SaldoImporte'      = SUM(SaldoImporte)+ SUM(SaldoImporteMC)
     
          FROM @InformeCompraProvCat
         WHERE Estacion = @EstacionTrabajo
           AND Grafica1 = 1
           AND Grafica2 = @Grafica2
           AND @Moneda = CASE WHEN @Grafica2 = 0 THEN Moneda2 ELSE ContMoneda END
          GROUP BY Moneda,  Categoria
        ) AS x
       GROUP BY x.Categoria
       ORDER BY SUM(ISNULL(x.SaldoImporte,0.00))ASC)
         AND Estacion = @EstacionTrabajo
         AND Grafica1 = 1
         AND Grafica2 = @Grafica2
         AND Moneda2 = @Moneda
           
    FETCH NEXT FROM crGraficar INTO @Moneda, @Grafica2
  END
  CLOSE crGraficar
  DEALLOCATE crGraficar

   
  UPDATE @InformeCompraProvCat SET FechaDesde = @FechaD, FechaHasta = @FechaA, Titulo = @Titulo, EmpresaNombre = @EmpresaNombre, Etiqueta = @Etiqueta, Reporte = @Reporte WHERE Estacion = @EstacionTrabajo
  
  SELECT * , @VerGraficaDetalle as VerGraficaDetalle FROM @InformeCompraProvCat WHERE Estacion = @EstacionTrabajo ORDER BY IDInforme
  
END
GO
--EXEC spInformeCompraProvCat 1

/******************************* spInformeVentaArtCat *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spInformeVentaArtCat') and type = 'P') drop procedure dbo.spInformeVentaArtCat
GO             
CREATE PROCEDURE spInformeVentaArtCat
		@EstacionTrabajo		int

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
	@FechaD					datetime,
	@FechaA					datetime,
	@Reporte				varchar(30),
	@Empresa				char(5),
	@Verdadero				bit,
	@Falso					bit,
	@Clave1					varchar(20),
	@Clave2					varchar(20),
	@Clave3					varchar(20),
	@Clave4					varchar(20),
	@Clave5					varchar(20),
	@Clave6					varchar(20),
	@Clave7					varchar(20),
	@Clave8					varchar(20),
	@Moneda					varchar(20),
	@CostoTotal				money,
	@ImporteTotal			money,
    @Utilidad				money,
	@CostoTotalMC			money,
	@ImporteTotalMC			money,
    @UtilidadMC				money,
    @Categoria				varchar(20),
    @FechaGrafica			varchar(50),
    @Periodo				int,
    @Ejercicio				int,
	@Titulo					varchar(100),
	@EmpresaNombre			varchar(100),
	@Graficar				int,
	@Grafica2				bit,
	@GraficarFecha			int,
	@GraficarTipo			varchar(30),
    @Etiqueta				bit,
    @GraficarCantidad		int,
    @VerGraficaDetalle      bit
    	

  DECLARE @InformeVentaArtCat TABLE
  (
	Estacion			int 	    	NOT	NULL,
    IDInforme			int 	    	NOT NULL  IDENTITY(1,1),
	Empresa				char(5)				NULL,
	Moneda  			char(10)   			NULL, 
	Moneda2  			char(10)   			NULL, 
	Categoria  			varchar(50) 		NULL, 
	CostoTotal			money				NULL,
	PrecioTotal			money				NULL,
	Importe				money				NULL,
	DescuentosTotales	money				NULL,
	SubTotal			money				NULL,
	Impuestos			money				NULL,
	ImporteTotal		money				NULL,	
	Utilidad			money				NULL,
	CostoTotalMC		money				NULL,
	ImporteTotalMC		money				NULL,
	UtilidadMC			money				NULL,
	SaldoDescripcion	varchar(50)			NULL,
    SaldoImporte		money				NULL DEFAULT 0.0,
    SaldoDescripcionMC	varchar(50)			NULL,
    SaldoImporteMC		money				NULL DEFAULT 0.0,
	Grafica1 			bit					NULL DEFAULT 0.0,
	Grafica2 			bit					NULL DEFAULT 0.0,
	Reporte				varchar(100)		NULL,
	Total				bit					NULL DEFAULT 0,
	ContMoneda			char(10)			NULL,
	FechaGrafica		varchar(100)		NULL,
	FechaDesde			datetime			NULL,
    FechaHasta			datetime			NULL,
    Titulo				varchar(100)		NULL,
	EmpresaNombre		varchar(100)		NULL,
	Periodo				int					NULL,
	Ejercicio			int					NULL,
	Etiqueta			bit					NULL  DEFAULT 0
  )    
 
 
  SELECT @Verdadero = 1, @Falso = 0
  SELECT 
  	  @FechaD  = InfoFechaD,
	  @FechaA  = InfoFechaA,
	  @Reporte = InfoRepVentas,
	  @Empresa = InfoEmpresa,
	  @Titulo = RepTitulo,
	  @GraficarFecha = ISNULL(InformeGraficarFecha,12),
	  @GraficarTipo = ISNULL(InformeGraficarTipo,  '(Todos)'),
	  @Etiqueta = ISNULL(InfoEtiqueta, @Falso),
	  @GraficarCantidad = ISNULL(InformeGraficarCantidad, 5),
    @VerGraficaDetalle = ISNULL(VerGraficaDetalle,0)
    FROM RepParam 
   WHERE Estacion = @EstacionTrabajo

  SELECT @EmpresaNombre = (SELECT Nombre FROM Empresa WHERE Empresa = @Empresa)

--select @FechaD, @FechaA, @Reporte, @Empresa

  IF @Reporte IN ('Ventas')
    SELECT
      @Clave1 = 'VTAS.F',
      @Clave2 = 'VTAS.FAR',
      @Clave3 = 'VTAS.FB',
      @Clave4 = 'VTAS.FM',
      @Clave5 = 'VTAS.F',
      @Clave6 = 'VTAS.FAR',
      @Clave7 = 'VTAS.FB'

  IF @Reporte IN ('Devoluciones')
    SELECT
      @Clave1 = 'VTAS.D',
      @Clave2 = 'VTAS.DF',
      @Clave3 = 'VTAS.B',
      @Clave4 = 'VTAS.D',
      @Clave5 = 'VTAS.DF',
      @Clave6 = 'VTAS.B',
      @Clave7 = 'VTAS.D'
  
  IF @Reporte IN ('Ventas y Devoluciones')
    SELECT
      @Clave1 = 'VTAS.F',
      @Clave2 = 'VTAS.FAR',
      @Clave3 = 'VTAS.FB',
      @Clave4 = 'VTAS.FM',
      @Clave5 = 'VTAS.D',
      @Clave6 = 'VTAS.DF',
      @Clave7 = 'VTAS.B'

  INSERT INTO @InformeVentaArtCat(Estacion, Empresa, Moneda, Categoria, CostoTotal, PrecioTotal, Importe, DescuentosTotales, SubTotal, Impuestos, ImporteTotal, Utilidad, CostoTotalMC, ImporteTotalMC, UtilidadMC, ContMoneda)
  SELECT Estacion, Empresa, Moneda, Categoria, SUM(ISNULL(CostoTotal,0.00)) as CostoTotal, SUM(ISNULL(PrecioTotal,0.00)) as PrecioTotal, SUM(ISNULL(Importe,0.00)) as Importe, SUM(ISNULL(DescuentosTotales,0.00)) as DescuentosTotales, SUM(ISNULL(SubTotal,0.00)) as SubTotal, SUM(ISNULL(Impuestos,0.00)) as Impuestos, SUM(ISNULL(ImporteTotal,0.00)) as ImporteTotal, SUM(ISNULL(Utilidad,0.00)) as Utilidad, SUM(ISNULL(CostoTotalMC,0.00)) as CostoTotalMC, SUM(ISNULL(ImporteTotalMC,0.00)) as ImporteTotalMC, SUM(ISNULL(UtilidadMC,0.00)) as UtilidadMC, ContMoneda
    FROM
    (
    SELECT
        'Estacion'			= @EstacionTrabajo,
        'Empresa'           = v.Empresa,
		'Moneda'            = v.Moneda,
        'Categoria'         = CASE WHEN ISNULL(a.Categoria,'(Sin Categoría)') = '' THEN '(Sin Categoría)' ELSE ISNULL(a.Categoria,'(Sin Categoría)') END,
        'CostoTotal'        = SUM(v.CostoTotal*mt.Factor),
        'PrecioTotal'       = SUM(v.PrecioTotal*mt.Factor),
        'Importe'           = SUM(v.Importe*mt.Factor),
        'DescuentosTotales' = SUM(v.DescuentosTotales*mt.Factor),
        'SubTotal'          = SUM(v.SubTotal*mt.Factor), 
        'Impuestos'         = SUM(v.Impuestos*mt.Factor),
        'ImporteTotal'      = SUM(v.ImporteTotal*mt.Factor),
        'Utilidad'		    = SUM(v.SubTotal*mt.Factor) - SUM(v.CostoTotal*mt.Factor),       
        'CostoTotalMC'      = (SUM(v.CostoTotal*mt.Factor)) * dbo.fnTipoCambio(v.Moneda),
        'ImporteTotalMC'    = (SUM(v.ImporteTotal*mt.Factor)) * dbo.fnTipoCambio(v.Moneda),
        'UtilidadMC'		= (SUM(v.SubTotal*mt.Factor) - SUM(v.CostoTotal*mt.Factor)) * dbo.fnTipoCambio(v.Moneda),
        'ContMoneda'		= e.ContMoneda
       
      FROM VentaTCalc v
      JOIN Art a ON v.Articulo = a.Articulo 
      JOIN MovTipo mt ON v.Mov = mt.Mov AND mt.Modulo = 'VTAS' 
      JOIN EmpresaCfg e ON e.Empresa = v.Empresa
     WHERE v.Estatus = 'CONCLUIDO'
       AND v.Empresa = @Empresa
       AND v.FechaEmision BETWEEN @FechaD AND @FechaA
       AND mt.Clave in(@Clave1, @Clave2, @Clave3, @Clave4, @Clave5, @Clave6, @Clave7)
      GROUP BY v.Moneda, a.Categoria, v.Empresa, dbo.fnTipoCambio(v.Moneda), e.ContMoneda
    ) AS x
   GROUP BY Moneda, Categoria, Estacion, Empresa, ContMoneda


  INSERT INTO @InformeVentaArtCat (Estacion, Moneda2, Categoria,	Grafica1,   Grafica2, SaldoDescripcion,  SaldoImporte,		             Reporte,  FechaGrafica, Ejercicio, Periodo)
  SELECT                          Estacion, Moneda2, Categoria, @Verdadero, @Falso,   Categoria,         SUM(ISNULL(ImporteTotal,0.00)), @Reporte, Fecha, Ejercicio, Periodo
    FROM
    (
    SELECT
        'Estacion'			= @EstacionTrabajo,
	    'Moneda2'           = v.Moneda,
        'Categoria'         = CASE WHEN ISNULL(a.Categoria,'') = '' THEN '(Sin Categoría)' ELSE SUBSTRING(a.Categoria,1, 30) END,
        'ImporteTotal'      = SUM(v.ImporteTotal*mt.Factor),
        'Fecha'				= dbo.fnMesNumeroNombre(DATEPART(MONTH,v.FechaEmision)) + ' ' + CONVERT(varchar,DATEPART(YEAR,v.FechaEmision)),
        'Ejercicio'			= DATEPART(YEAR,v.FechaEmision),
        'Periodo'			= DATEPART(MONTH,v.FechaEmision)
     
      FROM VentaTCalc v
      JOIN Art a ON v.Articulo = a.Articulo 
      JOIN MovTipo mt ON v.Mov = mt.Mov AND mt.Modulo = 'VTAS' 
      JOIN EmpresaCfg e ON e.Empresa = v.Empresa
     WHERE v.Estatus = 'CONCLUIDO'
       AND v.Empresa = @Empresa
       AND v.FechaEmision BETWEEN @FechaD AND @FechaA
       AND mt.Clave in(@Clave1, @Clave2, @Clave3, @Clave4, @Clave5, @Clave6, @Clave7)
      GROUP BY v.Moneda,  a.Categoria, DATEPART(YEAR,v.FechaEmision), DATEPART(MONTH,v.FechaEmision), v.Empresa, dbo.fnTipoCambio(v.Moneda), e.ContMoneda, dbo.fnMesNumeroNombre(DATEPART(MONTH,v.FechaEmision)) + ' ' + CONVERT(varchar,DATEPART(YEAR,v.FechaEmision))
    ) AS x
   GROUP BY x.Estacion, x.Moneda2, x.Categoria, x.Ejercicio, x.Periodo, x.Fecha
   ORDER BY x.Estacion, x.Moneda2, x.Categoria, x.Ejercicio, x.Periodo, x.Fecha

  INSERT INTO @InformeVentaArtCat (Estacion, ContMoneda, Moneda2, Categoria,	Grafica1,   Grafica2,   SaldoDescripcionMC, SaldoImporteMC,		             Reporte,  FechaGrafica, Ejercicio, Periodo)
  SELECT                          Estacion, ContMoneda, Moneda2, Categoria, @Verdadero, @Verdadero, Categoria,          SUM(ISNULL(ImporteTotalMC,0.00)),  @Reporte, Fecha, Ejercicio, Periodo
    FROM
    (
    SELECT
        'Estacion'			= @EstacionTrabajo,
        'ContMoneda'		= e.ContMoneda,        
	    'Moneda2'           = e.ContMoneda,
        'Categoria'         = CASE WHEN ISNULL(a.Categoria,'') = '' THEN '(Sin Categoría)' ELSE SUBSTRING(a.Categoria, 1, 30) END,
        'ImporteTotalMC'    = (SUM(v.ImporteTotal*mt.Factor)) * dbo.fnTipoCambio(v.Moneda),
        'Fecha'				= dbo.fnMesNumeroNombre(DATEPART(MONTH,v.FechaEmision)) + ' ' + CONVERT(varchar,DATEPART(YEAR,v.FechaEmision)),
        'Ejercicio'			= DATEPART(YEAR,v.FechaEmision),
        'Periodo'			= DATEPART(MONTH,v.FechaEmision)
     
      FROM VentaTCalc v
      JOIN Art a ON v.Articulo = a.Articulo 
      JOIN MovTipo mt ON v.Mov = mt.Mov AND mt.Modulo = 'VTAS' 
      JOIN EmpresaCfg e ON e.Empresa = v.Empresa
     WHERE v.Estatus = 'CONCLUIDO'
       AND v.Empresa = @Empresa
       AND v.FechaEmision BETWEEN @FechaD AND @FechaA
       AND mt.Clave in(@Clave1, @Clave2, @Clave3, @Clave4, @Clave5, @Clave6, @Clave7)
      GROUP BY v.Moneda,  a.Categoria, DATEPART(YEAR,v.FechaEmision), DATEPART(MONTH,v.FechaEmision), v.Empresa, dbo.fnTipoCambio(v.Moneda), e.ContMoneda, dbo.fnMesNumeroNombre(DATEPART(MONTH,v.FechaEmision)) + ' ' + CONVERT(varchar,DATEPART(YEAR,v.FechaEmision))
    ) AS x
   GROUP BY x.Estacion, x.Moneda2, x.Categoria, x.Ejercicio, x.Periodo, x.Fecha, x.ContMoneda
   ORDER BY x.Estacion, x.Moneda2, x.Categoria, x.Ejercicio, x.Periodo, x.Fecha, x.ContMoneda

  
  DECLARE crGraficar CURSOR FAST_FORWARD FOR
   SELECT Moneda2, Grafica2
     FROM @InformeVentaArtCat
    WHERE Estacion = @EstacionTrabajo
      AND Grafica1 = 1
    GROUP BY Moneda2, Grafica2

  OPEN crGraficar
  FETCH NEXT FROM crGraficar INTO @Moneda, @Grafica2
  WHILE @@FETCH_STATUS = 0
  BEGIN
  
    SELECT @Graficar = NULL
    SELECT @Graficar = COUNT(DISTINCT FechaGrafica)
      FROM @InformeVentaArtCat 
     WHERE Estacion = @EstacionTrabajo
       AND Grafica1 = 1
       AND Grafica2 = @Grafica2
       AND Moneda2 = @Moneda

    IF @Graficar > @GraficarFecha
      DELETE @InformeVentaArtCat 
       WHERE FechaGrafica IN(
             SELECT TOP (@Graficar - @GraficarFecha) FechaGrafica
               FROM @InformeVentaArtCat 
              WHERE Estacion = @EstacionTrabajo
                AND Grafica1 = 1
                AND Grafica2 = @Grafica2
                AND Moneda2 = @Moneda
              GROUP BY Ejercicio, Periodo, FechaGrafica
              ORDER BY Ejercicio DESC, Periodo DESC, FechaGrafica DESC)
         AND Estacion = @EstacionTrabajo
         AND Grafica1 = 1
         AND Grafica2 = @Grafica2
         AND Moneda2 = @Moneda

    SELECT @Graficar = NULL
    SELECT @Graficar = ISNULL(COUNT(DISTINCT Categoria),0)
      FROM @InformeVentaArtCat
     WHERE Estacion = @EstacionTrabajo
       AND Grafica1 = 0
       AND @Moneda = CASE WHEN @Grafica2 = 0 THEN Moneda ELSE ContMoneda END
       
    IF @GraficarTipo = 'Mas Sobresalientes' AND @Graficar > @GraficarCantidad
      DELETE @InformeVentaArtCat 
       WHERE Categoria NOT IN(
      SELECT  TOP (@GraficarCantidad) Categoria
        FROM
        (
        SELECT
            'Categoria'         = Categoria,
            'SaldoImporte'      = SUM(SaldoImporte)+ SUM(SaldoImporteMC)
     
          FROM @InformeVentaArtCat
         WHERE Estacion = @EstacionTrabajo
           AND Grafica1 = 1
           AND Grafica2 = @Grafica2
           AND Moneda2 = @Moneda
          GROUP BY Moneda,  Categoria
        ) AS x
       GROUP BY x.Categoria
       ORDER BY SUM(ISNULL(x.SaldoImporte,0.00))DESC)
         AND Estacion = @EstacionTrabajo
         AND Grafica1 = 1
         AND Grafica2 = @Grafica2
         AND @Moneda = CASE WHEN @Grafica2 = 0 THEN Moneda2 ELSE ContMoneda END

    IF @GraficarTipo = 'Menos Sobresalientes' AND @Graficar > @GraficarCantidad
      DELETE @InformeVentaArtCat 
       WHERE Categoria NOT IN(
      SELECT  TOP (@GraficarCantidad) Categoria
        FROM
        (
        SELECT
            'Categoria'         = Categoria,
            'SaldoImporte'      = SUM(SaldoImporte)+ SUM(SaldoImporteMC)
     
          FROM @InformeVentaArtCat
         WHERE Estacion = @EstacionTrabajo
           AND Grafica1 = 1
           AND Grafica2 = @Grafica2
           AND @Moneda = CASE WHEN @Grafica2 = 0 THEN Moneda2 ELSE ContMoneda END
          GROUP BY Moneda,  Categoria
        ) AS x
       GROUP BY x.Categoria
       ORDER BY SUM(ISNULL(x.SaldoImporte,0.00))ASC)
         AND Estacion = @EstacionTrabajo
         AND Grafica1 = 1
         AND Grafica2 = @Grafica2
         AND Moneda2 = @Moneda
           
    FETCH NEXT FROM crGraficar INTO @Moneda, @Grafica2
  END
  CLOSE crGraficar
  DEALLOCATE crGraficar

   
  UPDATE @InformeVentaArtCat SET FechaDesde = @FechaD, FechaHasta = @FechaA, Titulo = @Titulo, EmpresaNombre = @EmpresaNombre, Etiqueta = @Etiqueta, Reporte = @Reporte WHERE Estacion = @EstacionTrabajo
  
  SELECT * , @VerGraficaDetalle as VerGraficaDetalle FROM @InformeVentaArtCat WHERE Estacion = @EstacionTrabajo ORDER BY IDInforme
  
END
GO
--EXEC spInformeVentaArtCat 1


/******************************* spInformeVentaCteCat *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spInformeVentaCteCat') and type = 'P') drop procedure dbo.spInformeVentaCteCat
GO             
CREATE PROCEDURE spInformeVentaCteCat
		@EstacionTrabajo		int

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
	@FechaD					datetime,
	@FechaA					datetime,
	@Reporte				varchar(30),
	@Empresa				char(5),
	@Verdadero				bit,
	@Falso					bit,
	@Clave1					varchar(20),
	@Clave2					varchar(20),
	@Clave3					varchar(20),
	@Clave4					varchar(20),
	@Clave5					varchar(20),
	@Clave6					varchar(20),
	@Clave7					varchar(20),
	@Clave8					varchar(20),
	@Moneda					varchar(20),
	@CostoTotal				money,
	@ImporteTotal			money,
    @Utilidad				money,
	@CostoTotalMC			money,
	@ImporteTotalMC			money,
    @UtilidadMC				money,
    @Categoria				varchar(20),
    @FechaGrafica			varchar(50),
    @Periodo				int,
    @Ejercicio				int,
    @Titulo					varchar(100),
	@EmpresaNombre			varchar(100),
	@Graficar				int,
	@Grafica2				bit,
	@GraficarFecha			int,
	@GraficarTipo			varchar(30),
	@Etiqueta				bit,
	@GraficarCantidad		int,
    @VerGraficaDetalle		bit

    
  DECLARE @InformeVentaCteCat TABLE
  (
	Estacion			int 	    	NOT	NULL,
    IDInforme			int 	    	NOT NULL  IDENTITY(1,1),
	Empresa				char(5)				NULL,
	Moneda  			char(10)   			NULL, 
	Moneda2  			char(10)   			NULL, 
	Categoria  			varchar(50) 		NULL, 
	CostoTotal			money				NULL,
	PrecioTotal			money				NULL,
	Importe				money				NULL,
	DescuentosTotales	money				NULL,
	SubTotal			money				NULL,
	Impuestos			money				NULL,
	ImporteTotal		money				NULL,	
	Utilidad			money				NULL,
	CostoTotalMC		money				NULL,
	ImporteTotalMC		money				NULL,
	UtilidadMC			money				NULL,
	SaldoDescripcion	varchar(50)			NULL,
    SaldoImporte		money				NULL DEFAULT 0.0,
    SaldoDescripcionMC	varchar(50)			NULL,
    SaldoImporteMC		money				NULL DEFAULT 0.0,
	Grafica1 			bit					NULL DEFAULT 0,
	Grafica2 			bit					NULL DEFAULT 0,
	Reporte				varchar(100)		NULL,
	Total				bit					NULL DEFAULT 0,
	ContMoneda			char(10)			NULL,
	FechaGrafica		varchar(100)		NULL,
	FechaDesde			datetime			NULL,
    FechaHasta			datetime			NULL,
    Titulo				varchar(100)		NULL,
	EmpresaNombre		varchar(100)		NULL,    
	Periodo				int					NULL,
	Ejercicio			int					NULL,
	Etiqueta			bit					NULL  DEFAULT 0
  )    
	
  
  SELECT @Verdadero = 1, @Falso = 0
  SELECT 
  	  @FechaD  = InfoFechaD,
	  @FechaA  = InfoFechaA,
	  @Reporte = InfoRepVentas,
	  @Empresa = InfoEmpresa,
	  @Titulo = RepTitulo,
	  @GraficarFecha = ISNULL(InformeGraficarFecha,12),
	  @GraficarTipo = ISNULL(InformeGraficarTipo,  '(Todos)'),
	  @Etiqueta = ISNULL(InfoEtiqueta, @Falso),
	  @GraficarCantidad = ISNULL(InformeGraficarCantidad, 5),
    @VerGraficaDetalle = ISNULL(VerGraficaDetalle,0)
    FROM RepParam 
   WHERE Estacion = @EstacionTrabajo

  SELECT @EmpresaNombre = (SELECT Nombre FROM Empresa WHERE Empresa = @Empresa)

--select @FechaD, @FechaA, @Reporte, @Empresa

  IF @Reporte IN ('Ventas')
    SELECT
      @Clave1 = 'VTAS.F',
      @Clave2 = 'VTAS.FAR',
      @Clave3 = 'VTAS.FB',
      @Clave4 = 'VTAS.FM',
      @Clave5 = 'VTAS.F',
      @Clave6 = 'VTAS.FAR',
      @Clave7 = 'VTAS.FB'

  IF @Reporte IN ('Devoluciones')
    SELECT
      @Clave1 = 'VTAS.D',
      @Clave2 = 'VTAS.DF',
      @Clave3 = 'VTAS.B',
      @Clave4 = 'VTAS.D',
      @Clave5 = 'VTAS.DF',
      @Clave6 = 'VTAS.B',
      @Clave7 = 'VTAS.D'
  
  IF @Reporte IN ('Ventas y Devoluciones')
    SELECT
      @Clave1 = 'VTAS.F',
      @Clave2 = 'VTAS.FAR',
      @Clave3 = 'VTAS.FB',
      @Clave4 = 'VTAS.FM',
      @Clave5 = 'VTAS.D',
      @Clave6 = 'VTAS.DF',
      @Clave7 = 'VTAS.B'


  INSERT INTO @InformeVentaCteCat(Estacion, Empresa, Moneda, Categoria, CostoTotal, PrecioTotal, Importe, DescuentosTotales, SubTotal, Impuestos, ImporteTotal, Utilidad, CostoTotalMC, ImporteTotalMC, UtilidadMC, ContMoneda)
  SELECT Estacion, Empresa, Moneda, Categoria, SUM(ISNULL(CostoTotal,0.00)) as CostoTotal, SUM(ISNULL(PrecioTotal,0.00)) as PrecioTotal, SUM(ISNULL(Importe,0.00)) as Importe, SUM(ISNULL(DescuentosTotales,0.00)) as DescuentosTotales, SUM(ISNULL(SubTotal,0.00)) as SubTotal, SUM(ISNULL(Impuestos,0.00)) as Impuestos, SUM(ISNULL(ImporteTotal,0.00)) as ImporteTotal, SUM(ISNULL(Utilidad,0.00)) as Utilidad, SUM(ISNULL(CostoTotalMC,0.00)) as CostoTotalMC, SUM(ISNULL(ImporteTotalMC,0.00)) as ImporteTotalMC, SUM(ISNULL(UtilidadMC,0.00)) as UtilidadMC, ContMoneda
    FROM
    (
    SELECT
        'Estacion'			= @EstacionTrabajo,
        'Empresa'           = v.Empresa,
		'Moneda'            = v.Moneda,
		'Categoria'         = CASE WHEN ISNULL(c.Categoria,'(Sin Categoría)') = '' THEN '(Sin Categoría)' ELSE ISNULL(c.Categoria,'(Sin Categoría)') END,
		'CostoTotal'        = SUM(v.CostoTotal*mt.Factor),
		'PrecioTotal'       = SUM(v.PrecioTotal*mt.Factor),
		'Importe'           = SUM(v.Importe*mt.Factor),
		'DescuentosTotales' = SUM(v.DescuentosTotales*mt.Factor),
		'SubTotal'          = SUM(v.SubTotal*mt.Factor), 
		'Impuestos'         = SUM(v.Impuestos*mt.Factor),
		'ImporteTotal'      = SUM(v.ImporteTotal*mt.Factor),
        'Utilidad'		    = SUM(v.SubTotal*mt.Factor) - SUM(v.CostoTotal*mt.Factor),       
        'CostoTotalMC'      = (SUM(v.CostoTotal*mt.Factor)) * dbo.fnTipoCambio(v.Moneda),
        'ImporteTotalMC'    = (SUM(v.ImporteTotal*mt.Factor)) * dbo.fnTipoCambio(v.Moneda),
        'UtilidadMC'		= (SUM(v.SubTotal*mt.Factor) - SUM(v.CostoTotal*mt.Factor)) * dbo.fnTipoCambio(v.Moneda),
        'ContMoneda'		= e.ContMoneda
       
      FROM VentaCalc v
      JOIN Cte c ON v.Cliente = c.Cliente 
      JOIN MovTipo mt ON v.Mov = mt.Mov AND mt.Modulo = 'VTAS' 
      JOIN EmpresaCfg e ON e.Empresa = v.Empresa
     WHERE v.Estatus = 'CONCLUIDO'
       AND v.Empresa = @Empresa
       AND v.FechaEmision BETWEEN @FechaD AND @FechaA
       AND mt.Clave in(@Clave1, @Clave2, @Clave3, @Clave4, @Clave5, @Clave6, @Clave7)
     GROUP BY v.Moneda, ISNULL(c.Categoria,'(Sin Categoría)'), dbo.fnTipoCambio(v.Moneda), e.ContMoneda, v.Empresa
    ) AS x
   GROUP BY Moneda, Categoria, Estacion, Empresa, ContMoneda



  INSERT INTO @InformeVentaCteCat  (Estacion, Moneda2, Categoria, Grafica1,   Grafica2, SaldoDescripcion,  SaldoImporte,		              Reporte,  FechaGrafica, Ejercicio, Periodo)
  SELECT                           Estacion, Moneda2, Categoria, @Verdadero, @Falso,   Categoria,         SUM(ISNULL(ImporteTotal,0.00)), @Reporte, Fecha, Ejercicio, Periodo
    FROM
    (
    SELECT
        'Estacion'			= @EstacionTrabajo,
	    'Moneda2'           = v.Moneda,
        'Categoria'         = CASE WHEN ISNULL(c.Categoria,'') = '' THEN '(Sin Categoría)' ELSE c.Categoria END,
        'ImporteTotal'      = SUM(v.ImporteTotal*mt.Factor),
        'Fecha'				= dbo.fnMesNumeroNombre(DATEPART(MONTH,v.FechaEmision)) + ' ' + CONVERT(varchar,DATEPART(YEAR,v.FechaEmision)),
        'Ejercicio'			= DATEPART(YEAR,v.FechaEmision),
        'Periodo'			= DATEPART(MONTH,v.FechaEmision)
     
      FROM VentaCalc v
      JOIN Cte c ON v.Cliente = c.Cliente 
      JOIN MovTipo mt ON v.Mov = mt.Mov AND mt.Modulo = 'VTAS' 
      JOIN EmpresaCfg e ON e.Empresa = v.Empresa
     WHERE v.Estatus = 'CONCLUIDO'
       AND v.Empresa = @Empresa
       AND v.FechaEmision BETWEEN @FechaD AND @FechaA
       AND mt.Clave in(@Clave1, @Clave2, @Clave3, @Clave4, @Clave5, @Clave6, @Clave7)
      GROUP BY v.Moneda,  c.Categoria, DATEPART(YEAR,v.FechaEmision), DATEPART(MONTH,v.FechaEmision), v.Empresa, dbo.fnTipoCambio(v.Moneda), e.ContMoneda, dbo.fnMesNumeroNombre(DATEPART(MONTH,v.FechaEmision)) + ' ' + CONVERT(varchar,DATEPART(YEAR,v.FechaEmision))
    ) AS x
   GROUP BY x.Estacion, x.Moneda2, x.Categoria, x.Ejercicio, x.Periodo, x.Fecha
   ORDER BY x.Estacion, x.Moneda2, x.Categoria, x.Ejercicio, x.Periodo, x.Fecha

  INSERT INTO @InformeVentaCteCat  (Estacion, ContMoneda, Moneda2, Categoria, Grafica1,   Grafica2,   SaldoDescripcionMC,  SaldoImporteMC,		          Reporte,  FechaGrafica, Ejercicio, Periodo)
  SELECT                           Estacion, ContMoneda, Moneda2, Categoria, @Verdadero, @Verdadero, Categoria,         SUM(ISNULL(ImporteTotalMC,0.00)), @Reporte, Fecha, Ejercicio, Periodo
    FROM
    (
    SELECT
        'Estacion'			= @EstacionTrabajo,
        'ContMoneda'		= e.ContMoneda,
	    'Moneda2'           = e.ContMoneda,
        'Categoria'         = CASE WHEN ISNULL(c.Categoria,'') = '' THEN '(Sin Categoría)' ELSE c.Categoria END,
        'ImporteTotalMC'    = (SUM(v.ImporteTotal*mt.Factor)) * dbo.fnTipoCambio(v.Moneda),
        'Fecha'				= dbo.fnMesNumeroNombre(DATEPART(MONTH,v.FechaEmision)) + ' ' + CONVERT(varchar,DATEPART(YEAR,v.FechaEmision)),
        'Ejercicio'			= DATEPART(YEAR,v.FechaEmision),
        'Periodo'			= DATEPART(MONTH,v.FechaEmision)
     
      FROM VentaCalc v
      JOIN Cte c ON v.Cliente = c.Cliente 
      JOIN MovTipo mt ON v.Mov = mt.Mov AND mt.Modulo = 'VTAS' 
      JOIN EmpresaCfg e ON e.Empresa = v.Empresa
     WHERE v.Estatus = 'CONCLUIDO'
       AND v.Empresa = @Empresa
       AND v.FechaEmision BETWEEN @FechaD AND @FechaA
       AND mt.Clave in(@Clave1, @Clave2, @Clave3, @Clave4, @Clave5, @Clave6, @Clave7)
      GROUP BY v.Moneda,  c.Categoria, DATEPART(YEAR,v.FechaEmision), DATEPART(MONTH,v.FechaEmision), v.Empresa, dbo.fnTipoCambio(v.Moneda), e.ContMoneda, dbo.fnMesNumeroNombre(DATEPART(MONTH,v.FechaEmision)) + ' ' + CONVERT(varchar,DATEPART(YEAR,v.FechaEmision))
    ) AS x
   GROUP BY x.Estacion, x.Moneda2, x.Categoria, x.Ejercicio, x.Periodo, x.Fecha, x.ContMoneda
   ORDER BY x.Estacion, x.Moneda2, x.Categoria, x.Ejercicio, x.Periodo, x.Fecha, x.ContMoneda


  DECLARE crGraficar CURSOR FAST_FORWARD FOR
   SELECT Moneda2, Grafica2
     FROM @InformeVentaCteCat
    WHERE Estacion = @EstacionTrabajo
      AND Grafica1 = 1
    GROUP BY Moneda2, Grafica2

  OPEN crGraficar
  FETCH NEXT FROM crGraficar INTO @Moneda, @Grafica2
  WHILE @@FETCH_STATUS = 0
  BEGIN
  
    SELECT @Graficar = NULL
    SELECT @Graficar = COUNT(DISTINCT FechaGrafica)
      FROM @InformeVentaCteCat 
     WHERE Estacion = @EstacionTrabajo
       AND Grafica1 = 1
       AND Grafica2 = @Grafica2
       AND Moneda2 = @Moneda

    IF @Graficar > @GraficarFecha
      DELETE @InformeVentaCteCat 
       WHERE FechaGrafica IN(
             SELECT TOP (@Graficar - @GraficarFecha) FechaGrafica
               FROM @InformeVentaCteCat 
              WHERE Estacion = @EstacionTrabajo
                AND Grafica1 = 1
                AND Grafica2 = @Grafica2
                AND Moneda2 = @Moneda
              GROUP BY Ejercicio, Periodo, FechaGrafica
              ORDER BY Ejercicio DESC, Periodo DESC, FechaGrafica DESC)
         AND Estacion = @EstacionTrabajo
         AND Grafica1 = 1
         AND Grafica2 = @Grafica2
         AND Moneda2 = @Moneda

    SELECT @Graficar = NULL
    SELECT @Graficar = ISNULL(COUNT(DISTINCT Categoria),0)
      FROM @InformeVentaCteCat
     WHERE Estacion = @EstacionTrabajo
       AND Grafica1 = 0
       AND @Moneda = CASE WHEN @Grafica2 = 0 THEN Moneda ELSE ContMoneda END
       
    IF @GraficarTipo = 'Mas Sobresalientes' AND @Graficar > @GraficarCantidad
      DELETE @InformeVentaCteCat 
       WHERE Categoria NOT IN(
      SELECT  TOP (@GraficarCantidad) Categoria
        FROM
        (
        SELECT
            'Categoria'         = Categoria,
            'SaldoImporte'      = SUM(SaldoImporte)+ SUM(SaldoImporteMC)
     
          FROM @InformeVentaCteCat
         WHERE Estacion = @EstacionTrabajo
           AND Grafica1 = 1
           AND Grafica2 = @Grafica2
           AND Moneda2 = @Moneda
          GROUP BY Moneda,  Categoria
        ) AS x
       GROUP BY x.Categoria
       ORDER BY SUM(ISNULL(x.SaldoImporte,0.00))DESC)
         AND Estacion = @EstacionTrabajo
         AND Grafica1 = 1
         AND Grafica2 = @Grafica2
         AND @Moneda = CASE WHEN @Grafica2 = 0 THEN Moneda2 ELSE ContMoneda END

    IF @GraficarTipo = 'Menos Sobresalientes' AND @Graficar > @GraficarCantidad
      DELETE @InformeVentaCteCat 
       WHERE Categoria NOT IN(
      SELECT  TOP (@GraficarCantidad) Categoria
        FROM
        (
        SELECT
            'Categoria'         = Categoria,
            'SaldoImporte'      = SUM(SaldoImporte)+ SUM(SaldoImporteMC)
     
          FROM @InformeVentaCteCat
         WHERE Estacion = @EstacionTrabajo
           AND Grafica1 = 1
           AND Grafica2 = @Grafica2
           AND @Moneda = CASE WHEN @Grafica2 = 0 THEN Moneda2 ELSE ContMoneda END
          GROUP BY Moneda,  Categoria
        ) AS x
       GROUP BY x.Categoria
       ORDER BY SUM(ISNULL(x.SaldoImporte,0.00))ASC)
         AND Estacion = @EstacionTrabajo
         AND Grafica1 = 1
         AND Grafica2 = @Grafica2
         AND Moneda2 = @Moneda
           
    FETCH NEXT FROM crGraficar INTO @Moneda, @Grafica2
  END
  CLOSE crGraficar
  DEALLOCATE crGraficar

   
  UPDATE @InformeVentaCteCat SET FechaDesde = @FechaD, FechaHasta = @FechaA, Titulo = @Titulo, EmpresaNombre = @EmpresaNombre, Etiqueta = @Etiqueta, Reporte = @Reporte WHERE Estacion = @EstacionTrabajo
  
  SELECT * , @VerGraficaDetalle as VerGraficaDetalle FROM @InformeVentaCteCat WHERE Estacion = @EstacionTrabajo ORDER BY IDInforme
  
END
GO
--EXEC spInformeVentaCteCat 1


/******************************* spInformeVentaNeta *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spInformeVentaNeta') and type = 'P') drop procedure dbo.spInformeVentaNeta
GO             
CREATE PROCEDURE spInformeVentaNeta
		@EstacionTrabajo		int

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
	@FechaD					datetime,
	@FechaA					datetime,
	@Reporte				varchar(30),
	@Empresa				char(5),
	@Verdadero				bit,
	@Falso					bit,
	@Clave1					varchar(20),
	@Clave2					varchar(20),
	@Clave3					varchar(20),
	@Clave4					varchar(20),
	@Clave5					varchar(20),
	@Clave6					varchar(20),
	@Clave7					varchar(20),
	@Clave8					varchar(20),
	@Moneda					varchar(20),
	@FechaEmision			datetime,
	@CostoTotal				money,
	@ImporteTotal			money,
	@Utilidad				money,
	@ImporteTotalMC			money,
	@FechaGrafica			varchar(100),
	@Titulo					varchar(100),
	@EmpresaNombre			varchar(100),
	@Graficar				int,
	@Grafica2				bit,
	@GraficarFecha			int,
	@Etiqueta				bit,
    @VerGraficaDetalle		bit


  DECLARE @InformeVentaNeta TABLE
  (
	Estacion			int 	    	NOT	NULL,
    IDInforme			int 	    	NOT NULL  IDENTITY(1,1),
    ID					int 	    		NULL,
	Empresa				char(5)				NULL,
	Mov 				char(20)			NULL,
	MovID				char(20)       		NULL,
	Moneda  			char(10)   			NULL, 
	TipoCambio			float				NULL,	
	FechaEmision 		datetime    		NULL,	
	Concepto			varchar(50)			NULL,
	Referencia 			varchar(50) 		NULL,
	Proyecto  			varchar(50)   		NULL,
	FechaRequerida		datetime    		NULL,
	Prioridad			char(10)			NULL,
	Estatus 			char(15)   			NULL,
	Situacion			varchar(50)			NULL,
	SituacionFecha		datetime    		NULL,	
	Cliente 			char(10)   			NULL,
	EnviarA				int	   				NULL,
	Almacen				char(10)   			NULL,
	Agente 				char(10)   			NULL,
	FormaEnvio 			varchar(50)   		NULL,
	Condicion 			varchar(50)   		NULL,
	Vencimiento			datetime    		NULL,
	Usuario 			char(10)   			NULL,
	Observaciones 		varchar(100) 		NULL,	
	DescuentoGlobal		float 	    		NULL,
	CostoTotal			money				NULL,
	PrecioTotal			money				NULL,
	Importe				money				NULL,
	DescuentoLineal		float				NULL,
	DescuentosTotales	money				NULL,
	SubTotal			money				NULL,
	Impuestos			money				NULL,
	ImporteTotal		money				NULL,
	Peso				float				NULL,
	Volumen				float				NULL,	
	ClienteNombre		varchar(100)		NULL,
	Utilidad			money				NULL,
	Total				bit					NULL DEFAULT 0,
	ContMoneda			char(10)			NULL,
	ImporteTotalMC		money				NULL,
	CostoTotalMC		money				NULL,
	UtilidadMC			money				NULL,
	FechaGrafica		varchar(100)		NULL,
	Grafica1 			bit					NULL DEFAULT 0,
	Grafica2 			bit					NULL DEFAULT 0,
	Reporte				varchar(100)		NULL,
	SaldoDescripcion	varchar(50)			NULL,
    SaldoImporte		money				NULL DEFAULT 0.0,
    Movimiento			varchar(50)			NULL,
    SaldoDescripcionMC	varchar(50)			NULL,
    SaldoImporteMC		money				NULL DEFAULT 0.0,
    FechaDesde			datetime			NULL,
    FechaHasta			datetime			NULL,
    Titulo				varchar(100)		NULL,
	EmpresaNombre		varchar(100)		NULL,
	Periodo				int					NULL,
	Ejercicio			int					NULL,	
	Etiqueta			bit					NULL  DEFAULT 0
  )    


  SELECT @Verdadero = 1, @Falso = 0
  SELECT 
  	  @FechaD  = InfoFechaD,
	  @FechaA  = InfoFechaA,
	  @Reporte = InfoRepVentas,
	  @Empresa = InfoEmpresa,
	  @Titulo = RepTitulo,
	  @GraficarFecha = ISNULL(InformeGraficarFecha,12),
	  @Etiqueta = ISNULL(InfoEtiqueta, @Falso),
    @VerGraficaDetalle = ISNULL(VerGraficaDetalle,0)
    FROM RepParam 
   WHERE Estacion = @EstacionTrabajo

  SELECT @EmpresaNombre = (SELECT Nombre FROM Empresa WHERE Empresa = @Empresa)
--select @FechaD, @FechaA, @Reporte, @Empresa

  IF @Reporte IN ('Ventas')
    SELECT
      @Clave1 = 'VTAS.F',
      @Clave2 = 'VTAS.FAR',
      @Clave3 = 'VTAS.FB',
      @Clave4 = 'VTAS.FM',
      @Clave5 = 'VTAS.F',
      @Clave6 = 'VTAS.FAR',
      @Clave7 = 'VTAS.FB'

  IF @Reporte IN ('Devoluciones')
    SELECT
      @Clave1 = 'VTAS.D',
      @Clave2 = 'VTAS.DF',
      @Clave3 = 'VTAS.B',
      @Clave4 = 'VTAS.D',
      @Clave5 = 'VTAS.DF',
      @Clave6 = 'VTAS.B',
      @Clave7 = 'VTAS.D'
  
  IF @Reporte IN ('Ventas y Devoluciones')
    SELECT
      @Clave1 = 'VTAS.F',
      @Clave2 = 'VTAS.FAR',
      @Clave3 = 'VTAS.FB',
      @Clave4 = 'VTAS.FM',
      @Clave5 = 'VTAS.D',
      @Clave6 = 'VTAS.DF',
      @Clave7 = 'VTAS.B'


  INSERT INTO @InformeVentaNeta
  SELECT
    'Estacion'			= @EstacionTrabajo,
    v.ID,
    v.Empresa,
    v.Mov,
    v.MovID,
    UPPER(v.Moneda),
    v.TipoCambio,
    v.FechaEmision,
    v.Concepto,
    v.Referencia,
    v.Proyecto,
    v.FechaRequerida,
    v.Prioridad,
    v.Estatus,
    v.Situacion,
    v.SituacionFecha,
    v.Cliente,
    v.EnviarA,
    v.Almacen,
    v.Agente,
    v.FormaEnvio,
    v.Condicion,
    v.Vencimiento,
    v.Usuario,
    v.Observaciones,
    v.DescuentoGlobal,
    'CostoTotal'        = v.CostoTotal*mt.Factor,
    'PrecioTotal'       = v.PrecioTotal*mt.Factor,
    'Importe'           = v.Importe*mt.Factor,
    'DescuentoLineal'   = v.DescuentoLineal*mt.Factor,
    'DescuentosTotales' = v.DescuentosTotales*mt.Factor,
    'SubTotal'          = v.SubTotal*mt.Factor,
    'Impuestos'         = v.Impuestos*mt.Factor,
    'ImporteTotal'      = v.ImporteTotal*mt.Factor,
    'Peso'              = v.Peso*mt.Factor,
    'Volumen'           = v.Volumen*mt.Factor,
    'ClienteNombre'     = Cte.Nombre,
    'Utilidad'			= ((v.SubTotal*mt.Factor) - (v.CostoTotal*mt.Factor)),
    'Total'				= @Falso,
    'ContMoneda'		= UPPER(e.ContMoneda),
    'ImporteTotalMC'    = CASE WHEN e.ContMoneda = v.Moneda THEN (v.ImporteTotal*mt.Factor) ELSE (v.ImporteTotal*mt.Factor) * dbo.fnTipoCambio(v.Moneda) END,
    'CostoTotalMC'		= CASE WHEN e.ContMoneda = v.Moneda THEN (v.CostoTotal*mt.Factor) ELSE (v.CostoTotal*mt.Factor) * dbo.fnTipoCambio(v.Moneda) END,
    'UtilidadlMC'		= CASE WHEN e.ContMoneda = v.Moneda THEN ((v.SubTotal*mt.Factor) - (v.CostoTotal*mt.Factor)) ELSE ((v.SubTotal*mt.Factor) - (v.CostoTotal*mt.Factor)) * dbo.fnTipoCambio(v.Moneda) END,
    'FechaGrafica'		= NULL,
    'Grafica1'			= @Falso,
    'Grafica2'			= @Falso,
    'Reporte'			= @Reporte,
    'SaldoDescripcion'  = NULL,
    'SaldoImporte'		= NULL,
    'Movimiento'		= v.Mov + ' ' + v.MovID,
    'SaldoDescripcionMC'= NULL,
    'SaldoImporteMC'	= NULL,
    'FechaDesde'		= @FechaD,
    'FechaHasta'		= @FechaA,
    'Titulo'			= @Titulo,
    'EmpresaNombre'		= @EmpresaNombre,
    'Ejercicio'			= NULL,
    'Periodo'			= NULL,
    'Etiqueta'			= @Etiqueta

    FROM VentaCalc v
    JOIN Cte ON v.Cliente = Cte.Cliente
    JOIN MovTipo mt ON v.Mov = mt.Mov AND mt.Modulo = 'VTAS'
    JOIN EmpresaCfg e ON e.Empresa = v.Empresa
   WHERE v.Estatus = 'CONCLUIDO'
     AND v.Empresa = @Empresa
     AND v.FechaEmision BETWEEN @FechaD AND @FechaA
     AND mt.Clave in(@Clave1, @Clave2, @Clave3, @Clave4, @Clave5, @Clave6, @Clave7)
     
  INSERT INTO @InformeVentaNeta (Estacion, Moneda, FechaEmision, CostoTotal, PrecioTotal, Importe, DescuentoLineal, DescuentosTotales, SubTotal, Impuestos, ImporteTotal, Peso, Volumen, Utilidad, Total, ContMoneda, Grafica1, Grafica2, Reporte, FechaDesde, FechaHasta, CostoTotalMC, ImporteTotalMC, UtilidadMC)
  SELECT
    'Estacion'			= @EstacionTrabajo,  
    'Moneda'			= 'Total',
    'FechaEmision'		= (SELECT MAX(FechaEmision) + 1 FROM VENTA),
    'CostoTotal'        = SUM(CASE WHEN e.ContMoneda = v.Moneda THEN (v.CostoTotal*mt.Factor) ELSE (v.CostoTotal*mt.Factor) * dbo.fnTipoCambio(v.Moneda) END),
    'PrecioTotal'       = SUM(CASE WHEN e.ContMoneda = v.Moneda THEN (v.PrecioTotal*mt.Factor) ELSE (v.PrecioTotal*mt.Factor) * dbo.fnTipoCambio(v.Moneda) END),
    'Importe'           = SUM(CASE WHEN e.ContMoneda = v.Moneda THEN (v.Importe*mt.Factor) ELSE (v.Importe*mt.Factor) * dbo.fnTipoCambio(v.Moneda) END),
    'DescuentoLineal'   = SUM(CASE WHEN e.ContMoneda = v.Moneda THEN (v.DescuentoLineal*mt.Factor) ELSE (v.DescuentoLineal*mt.Factor) * dbo.fnTipoCambio(v.Moneda) END),
    'DescuentosTotales' = SUM(CASE WHEN e.ContMoneda = v.Moneda THEN (v.DescuentosTotales*mt.Factor) ELSE (v.DescuentosTotales*mt.Factor) * dbo.fnTipoCambio(v.Moneda) END),
    'SubTotal'          = SUM(CASE WHEN e.ContMoneda = v.Moneda THEN (v.SubTotal*mt.Factor) ELSE (v.SubTotal*mt.Factor) * dbo.fnTipoCambio(v.Moneda) END),
    'Impuestos'         = SUM(CASE WHEN e.ContMoneda = v.Moneda THEN (v.Impuestos*mt.Factor) ELSE (v.Impuestos*mt.Factor) * dbo.fnTipoCambio(v.Moneda) END),
    'ImporteTotal'      = SUM(CASE WHEN e.ContMoneda = v.Moneda THEN (v.ImporteTotal*mt.Factor) ELSE (v.ImporteTotal*mt.Factor) * dbo.fnTipoCambio(v.Moneda) END),
    'Peso'              = SUM(CASE WHEN e.ContMoneda = v.Moneda THEN (v.Peso*mt.Factor) ELSE (v.Peso*mt.Factor) * dbo.fnTipoCambio(v.Moneda) END),
    'Volumen'           = SUM(CASE WHEN e.ContMoneda = v.Moneda THEN (v.Volumen*mt.Factor) ELSE (v.Volumen*mt.Factor) * dbo.fnTipoCambio(v.Moneda) END),
    'Utilidad'			= SUM(CASE WHEN e.ContMoneda = v.Moneda THEN((v.SubTotal*mt.Factor) - (v.CostoTotal*mt.Factor)) ELSE ((v.SubTotal*mt.Factor) - (v.CostoTotal*mt.Factor)) * dbo.fnTipoCambio(v.Moneda) END),
    'Total'				= @Verdadero,
    'ContMoneda'        = UPPER(RTRIM(LTRIM(e.ContMoneda))),
    'Grafica1'			= @Falso,
    'Grafica2'			= @Falso,
    'Reporte'			= @Reporte,
    'FechaDesde'		= @FechaD,
    'FechaHasta'		= @FechaA,
    'CostoTotalMC'      = SUM(CASE WHEN e.ContMoneda = v.Moneda THEN (v.CostoTotal*mt.Factor) ELSE (v.CostoTotal*mt.Factor) * dbo.fnTipoCambio(v.Moneda) END),
    'ImporteTotalMC'    = SUM(CASE WHEN e.ContMoneda = v.Moneda THEN (v.ImporteTotal*mt.Factor) ELSE (v.ImporteTotal*mt.Factor) * dbo.fnTipoCambio(v.Moneda) END),
    'UtilidadMC'		= SUM(CASE WHEN e.ContMoneda = v.Moneda THEN((v.SubTotal*mt.Factor) - (v.CostoTotal*mt.Factor)) ELSE ((v.SubTotal*mt.Factor) - (v.CostoTotal*mt.Factor)) * dbo.fnTipoCambio(v.Moneda) END)
    
    FROM VentaCalc v
    JOIN Cte ON v.Cliente=Cte.Cliente
    JOIN MovTipo mt ON v.Mov = mt.Mov AND mt.Modulo = 'VTAS'
    JOIN EmpresaCfg e ON e.Empresa = v.Empresa
   WHERE v.Estatus = 'CONCLUIDO'
     AND v.Empresa = @Empresa
     AND v.FechaEmision BETWEEN @FechaD AND @FechaA
     AND mt.Clave in(@Clave1, @Clave2, @Clave3, @Clave4, @Clave5, @Clave6, @Clave7)     
   GROUP BY e.ContMoneda
   
  DECLARE crGrafica CURSOR FAST_FORWARD FOR
   SELECT UPPER(v.Moneda), (SELECT MAX(FechaEmision) + 2 FROM VENTA), SUM(v.CostoTotal*mt.Factor), SUM(v.ImporteTotal*mt.Factor), SUM(((v.ImporteTotal*mt.Factor) - (v.CostoTotal*mt.Factor))), dbo.fnMesNumeroNombre(DATEPART(MONTH,v.FechaEmision)) + ' ' + CONVERT(varchar,DATEPART(YEAR,v.FechaEmision)) 
     FROM VentaCalc v
     JOIN Cte ON v.Cliente=Cte.Cliente
     JOIN MovTipo mt ON v.Mov = mt.Mov AND mt.Modulo = 'VTAS'
     JOIN EmpresaCfg e ON e.Empresa = v.Empresa
    WHERE v.Estatus = 'CONCLUIDO'
      AND v.Empresa = @Empresa
      AND v.FechaEmision BETWEEN @FechaD AND @FechaA
      AND mt.Clave in(@Clave1, @Clave2, @Clave3, @Clave4, @Clave5, @Clave6, @Clave7)
    GROUP BY DATEPART(MONTH,v.FechaEmision), DATEPART(YEAR,v.FechaEmision), UPPER(v.Moneda)

  OPEN crGrafica
  FETCH NEXT FROM crGrafica INTO @Moneda, @FechaEmision, @CostoTotal, @ImporteTotal, @Utilidad, @FechaGrafica
  WHILE @@FETCH_STATUS = 0 --AND @Ok IS NULL
  BEGIN

    INSERT INTO @InformeVentaNeta(Estacion,         Moneda,  FechaEmision,  FechaGrafica,  Grafica1,   SaldoDescripcion,  SaldoImporte)
      SELECT                    @EstacionTrabajo, @Moneda, @FechaEmision, @FechaGrafica, @Verdadero, 'CostoTotal',      @CostoTotal
    INSERT INTO @InformeVentaNeta(Estacion,         Moneda,  FechaEmision,  FechaGrafica,  Grafica1,   SaldoDescripcion,  SaldoImporte)
      SELECT                    @EstacionTrabajo, @Moneda, @FechaEmision, @FechaGrafica, @Verdadero, 'ImporteTotal',    @ImporteTotal
    INSERT INTO @InformeVentaNeta(Estacion,         Moneda,  FechaEmision,  FechaGrafica,  Grafica1,   SaldoDescripcion,  SaldoImporte)
      SELECT                    @EstacionTrabajo, @Moneda, @FechaEmision, @FechaGrafica, @Verdadero, 'Utilidad',        @Utilidad
    
    FETCH NEXT FROM crGrafica INTO @Moneda, @FechaEmision, @CostoTotal, @ImporteTotal, @Utilidad, @FechaGrafica
  END
  CLOSE crGrafica
  DEALLOCATE crGrafica


  DECLARE crGrafica1 CURSOR FAST_FORWARD FOR
   SELECT UPPER(RTRIM(LTRIM(e.ContMoneda))), (SELECT MAX(FechaEmision) + 2 FROM VENTA), SUM(CASE WHEN e.ContMoneda = v.Moneda THEN (v.CostoTotal*mt.Factor) ELSE (v.CostoTotal*mt.Factor) * dbo.fnTipoCambio(v.Moneda) END), SUM(CASE WHEN e.ContMoneda = v.Moneda THEN (v.ImporteTotal*mt.Factor) ELSE (v.ImporteTotal*mt.Factor) * dbo.fnTipoCambio(v.Moneda) END) - SUM(CASE WHEN e.ContMoneda = v.Moneda THEN (v.CostoTotal*mt.Factor) ELSE (v.CostoTotal*mt.Factor) * dbo.fnTipoCambio(v.Moneda) END), SUM(CASE WHEN e.ContMoneda = v.Moneda THEN (v.ImporteTotal*mt.Factor) ELSE (v.ImporteTotal*mt.Factor) * dbo.fnTipoCambio(v.Moneda) END), dbo.fnMesNumeroNombre(DATEPART(MONTH,v.FechaEmision)) + ' ' + CONVERT(varchar,DATEPART(YEAR,v.FechaEmision))
     FROM VentaCalc v
     JOIN Cte ON v.Cliente=Cte.Cliente
     JOIN MovTipo mt ON v.Mov = mt.Mov AND mt.Modulo = 'VTAS'
     JOIN EmpresaCfg e ON e.Empresa = v.Empresa
    WHERE v.Estatus = 'CONCLUIDO'
      AND v.Empresa = @Empresa
      AND v.FechaEmision BETWEEN @FechaD AND @FechaA
      AND mt.Clave in(@Clave1, @Clave2, @Clave3, @Clave4, @Clave5, @Clave6, @Clave7)
    GROUP BY DATEPART(MONTH,v.FechaEmision), DATEPART(YEAR,v.FechaEmision), UPPER(RTRIM(LTRIM(e.ContMoneda)))

  OPEN crGrafica1
  FETCH NEXT FROM crGrafica1 INTO @Moneda, @FechaEmision, @CostoTotal, @Utilidad, @ImporteTotalMC, @FechaGrafica
   WHILE @@FETCH_STATUS = 0 --AND @Ok IS NULL
   BEGIN
  
     INSERT INTO @InformeVentaNeta(Estacion,         Moneda,  FechaEmision,  FechaGrafica, Grafica1,   Grafica2,   SaldoDescripcionMC,  SaldoImporteMC)
       SELECT                    @EstacionTrabajo, @Moneda, @FechaEmision, @FechaGrafica, @Verdadero, @Verdadero, 'Costo Total MC',    @CostoTotal
     INSERT INTO @InformeVentaNeta(Estacion,         Moneda,  FechaEmision,  FechaGrafica, Grafica1,   Grafica2,   SaldoDescripcionMC,  SaldoImporteMC)
       SELECT                    @EstacionTrabajo, @Moneda, @FechaEmision, @FechaGrafica, @Verdadero, @Verdadero, 'Importe Total MC',  @ImporteTotalMC
     INSERT INTO @InformeVentaNeta(Estacion,         Moneda,  FechaEmision,  FechaGrafica, Grafica1,   Grafica2,   SaldoDescripcionMC,  SaldoImporteMC)
       SELECT                    @EstacionTrabajo, @Moneda, @FechaEmision, @FechaGrafica, @Verdadero, @Verdadero, 'Utilidad MC',       @Utilidad

     FETCH NEXT FROM crGrafica1 INTO @Moneda, @FechaEmision, @CostoTotal, @Utilidad, @ImporteTotalMC, @FechaGrafica
   END
   CLOSE crGrafica1
   DEALLOCATE crGrafica1

  DECLARE crGraficar CURSOR FAST_FORWARD FOR
   SELECT Moneda, Grafica2
     FROM @InformeVentaNeta
    WHERE Estacion = @EstacionTrabajo
      AND Grafica1 = 1
    GROUP BY Moneda, Grafica2

  OPEN crGraficar
  FETCH NEXT FROM crGraficar INTO @Moneda, @Grafica2
  WHILE @@FETCH_STATUS = 0
  BEGIN
  
    SELECT @Graficar = NULL
    SELECT @Graficar = COUNT(DISTINCT FechaGrafica)
      FROM @InformeVentaNeta 
     WHERE Estacion = @EstacionTrabajo
       AND Grafica1 = 1
       AND Grafica2 = @Grafica2
       AND Moneda = @Moneda

    IF @Graficar > @GraficarFecha
      DELETE @InformeVentaNeta 
       WHERE FechaGrafica IN(
             SELECT TOP (@Graficar - @GraficarFecha) FechaGrafica
               FROM @InformeVentaNeta 
              WHERE Estacion = @EstacionTrabajo
                AND Grafica1 = 1
                AND Grafica2 = @Grafica2
                AND Moneda = @Moneda
              GROUP BY Ejercicio, Periodo, FechaGrafica
              ORDER BY Ejercicio DESC, Periodo DESC, FechaGrafica DESC)
         AND Estacion = @EstacionTrabajo
         AND Grafica1 = 1
         AND Grafica2 = @Grafica2
         AND Moneda = @Moneda
           
    FETCH NEXT FROM crGraficar INTO @Moneda, @Grafica2
  END
  CLOSE crGraficar
  DEALLOCATE crGraficar

   
  UPDATE @InformeVentaNeta SET FechaDesde = @FechaD, FechaHasta = @FechaA, Titulo = @Titulo, EmpresaNombre = @EmpresaNombre, Etiqueta = @Etiqueta, Reporte = @Reporte WHERE Estacion = @EstacionTrabajo
  
  SELECT * , @VerGraficaDetalle as VerGraficaDetalle FROM @InformeVentaNeta WHERE Estacion = @EstacionTrabajo ORDER BY IDInforme
  
END
GO
--EXEC spInformeVentaNeta 1


/******************************* spInformeVentaTrimestral *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spInformeVentaTrimestral') and type = 'P') drop procedure dbo.spInformeVentaTrimestral
GO             
CREATE PROCEDURE spInformeVentaTrimestral
		@EstacionTrabajo		int

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
	@Empresa				char(5),
	@Moneda					char(10),
	@Periodo				int,
	@PeriodoD				int,
	@PeriodoA				int,
	@Ejercicio				int,
	@Opcion					int,
	@Folio					int,
	@ArtCat					varchar(50),
	@ArtGrupo				varchar(50),
	@ArtFam					varchar(50),
	@Fabricante				varchar(50),
	@Verdadero				bit,
	@Falso					bit,
	@CostoTotal				money,
	@ImporteTotal			money,
    @Utilidad				money,
	@CostoTotalMC			money,
	@ImporteTotalMC			money,
    @UtilidadMC				money,
    @Categoria				varchar(20),
    @FechaGrafica			varchar(50),
    @Grupo					varchar(50),
    @Familia				varchar(50),
    @Mes1					float,
    @Mes2					float,
    @Mes3					float,
    @Titulo					varchar(100),
	@EmpresaNombre			varchar(100),
	@Graficar				int,
	@Grafica2				bit,
	@Grafica3				bit,
	@Grafica4				bit,
	@GraficarTipo			varchar(30),
	@Etiqueta				bit,
	@GraficarCantidad		int,
    @VerGraficaDetalle		bit


  DECLARE @InformeVentaTrimestral TABLE
  (
	Estacion			int 	    	NOT	NULL,
    IDInforme			int 	    	NOT NULL  IDENTITY(1,1),
	Empresa				char(5)				NULL,
	Moneda  			char(10)   			NULL, 
    Articulo			varchar(50)			NULL,
    Descripcion1		varchar(100) 		NULL,
    Categoria			varchar(50)			NULL,
    Grupo				varchar(50)			NULL,
    Familia				varchar(50)			NULL,
    Fabricante			varchar(50)			NULL,
    Mes1				float				NULL,
    Cantidad1			float				NULL,
    Mes2				float				NULL,
    Cantidad2			float				NULL,
    Mes3				float				NULL,
    Cantidad3			float				NULL,
    MonedaCosto			varchar(50)			NULL,
    UltimoCosto			float				NULL,
    CostoPromedio		float				NULL,
    Disponible			float				NULL,
	SaldoDescripcion	varchar(50)			NULL,
    SaldoImporte		float				NULL DEFAULT 0.0,
	Grafica1 			bit					NULL DEFAULT 0,
	Grafica2 			bit					NULL DEFAULT 0,
	Grafica3 			bit					NULL DEFAULT 0,
	Grafica4 			bit					NULL DEFAULT 0,
	Reporte				varchar(100)		NULL,
	Total				bit					NULL DEFAULT 0,
	FechaGrafica		varchar(100)		NULL,
    Periodo				varchar(20)			NULL,
    Ejercicio			int					NULL,
    PeriodoD			varchar(20)			NULL,
    Opcion				int					NULL,
    PeriodoA			varchar(20)			NULL,
    Folio				int					NULL,
    Categoria2			varchar(50)			NULL,
    Titulo				varchar(100)		NULL,
	EmpresaNombre		varchar(100)		NULL,
	Etiqueta			bit					NULL  DEFAULT 0
  )    

  
  SELECT @Verdadero = 1, @Falso = 0

  SELECT 
	  @Empresa	 = InfoEmpresa,
	  @Moneda	 = InfoMoneda,
	  @Periodo	 = ISNULL(InfoPeriodoD,0),
	  @Ejercicio = InfoEjercicio,	  
	  @ArtCat	 = InfoArtCat,
	  @ArtGrupo	 = InfoArtGrupo,
	  @ArtFam	 = InfoArtFam,
	  @Fabricante= InfoFabricante,
	  @Titulo = RepTitulo,
	  @GraficarTipo = ISNULL(InformeGraficarTipo,  '(Todos)'),
	  @Etiqueta = ISNULL(InfoEtiqueta, @Falso),
	  @GraficarCantidad = ISNULL(InformeGraficarCantidad, 5),
    @VerGraficaDetalle = ISNULL(VerGraficaDetalle,0)
    FROM RepParam 
   WHERE Estacion = @EstacionTrabajo

  SELECT @EmpresaNombre = (SELECT Nombre FROM Empresa WHERE Empresa = @Empresa)

  IF @Periodo <=10 
    SELECT @PeriodoD = @Periodo + 1, 
           @PeriodoA = @Periodo + 2,
           @Opcion	 = @Ejercicio,
           @Folio	 = @Ejercicio

  IF @Periodo =11 
    SELECT @PeriodoD = @Periodo + 1, 
           @PeriodoA = 1,
           @Opcion	 = @Ejercicio,
           @Folio	 = @Ejercicio + 1
           
  IF @Periodo =12 
    SELECT @PeriodoD = 1, 
           @PeriodoA = 2,
           @Opcion	 = @Ejercicio + 1,
           @Folio	 = @Ejercicio + 1

  IF @ArtCat	 IN('(Todas)', '') SELECT @ArtCat	  = NULL
  IF @ArtGrupo   IN('(Todas)', '') SELECT @ArtGrupo   = NULL
  IF @ArtFam	 IN('(Todas)', '') SELECT @ArtFam	  = NULL
  IF @Fabricante IN('(Todas)', '') SELECT @Fabricante = NULL
  
--select @Empresa, @Moneda, @Periodo, @PeriodoD, @PeriodoA, @Ejercicio, @Opcion, @Folio, @ArtCat, @ArtGrupo, @ArtFam, @Fabricante

  INSERT INTO @InformeVentaTrimestral (Estacion, Empresa, Moneda, Articulo,Descripcion1, Categoria, Grupo, Familia, Fabricante, Mes1, Cantidad1, Mes2, Cantidad2, Mes3, Cantidad3, MonedaCosto, UltimoCosto, CostoPromedio, Disponible, Periodo, Ejercicio, PeriodoD, Opcion, PeriodoA, Folio)
  SELECT Estacion, Empresa, Moneda, Articulo,Descripcion1, Categoria, Grupo, Familia, Fabricante, Mes1, Cantidad1, Mes2, Cantidad2, Mes3, Cantidad3, MonedaCosto, UltimoCosto, CostoPromedio, Disponible, Periodo, Ejercicio, PeriodoD, Opcion, PeriodoA, Folio
    FROM
    (
  SELECT 'Estacion'		= @EstacionTrabajo,
         'Empresa'		= aen.Empresa,
         'Moneda'		= @Moneda,
         a.Articulo,
         a.Descripcion1, 
         'Categoria'	= CASE WHEN RTRIM(LTRIM(a.Categoria)) = '' THEN '(Sin Categoría)' ELSE ISNULL(a.Categoria, '(Sin Categoría)') END,
         'Grupo'		= CASE WHEN RTRIM(LTRIM(a.Grupo)) = '' THEN '(Sin Grupo)' ELSE ISNULL(a.Grupo, '(Sin Grupo)') END,
         'Familia'		= CASE WHEN RTRIM(LTRIM(a.Familia)) = '' THEN '(Sin Familia)' ELSE ISNULL(a.Familia, '(Sin Familia)') END,
         'Fabricante'	= CASE WHEN RTRIM(LTRIM(a.Fabricante)) = '' THEN '(Sin Fabricante)' ELSE ISNULL(a.Fabricante, '(Sin Fabricante)') END,
         'Mes1'			= (SELECT SUM(ISNULL(v.ImporteNeto,0.00))  FROM VentaArt v Where v.Articulo = a.Articulo AND v.Empresa=@Empresa AND v.Moneda = @Moneda AND v.Periodo = @Periodo  AND v.Ejercicio = @Ejercicio), 
         'Cantidad1'	= (SELECT SUM(ISNULL(v.CantidadNeta,0.00)) FROM VentaArt v Where v.Articulo = a.Articulo AND v.Empresa=@Empresa AND v.Moneda = @Moneda AND v.Periodo = @Periodo  AND v.Ejercicio = @Ejercicio), 
         'Mes2'			= (SELECT SUM(ISNULL(v.ImporteNeto,0.00))  FROM VentaArt v Where v.Articulo = a.Articulo AND v.Empresa=@Empresa AND v.Moneda = @Moneda AND v.Periodo = @PeriodoD AND v.Ejercicio = @Opcion), 
         'Cantidad2'	= (SELECT SUM(ISNULL(v.CantidadNeta,0.00)) FROM VentaArt v Where v.Articulo = a.Articulo AND v.Empresa=@Empresa AND v.Moneda = @Moneda AND v.Periodo = @PeriodoD AND v.Ejercicio = @Opcion), 
         'Mes3'			= (SELECT SUM(ISNULL(v.ImporteNeto,0.00))  FROM VentaArt v Where v.Articulo = a.Articulo AND v.Empresa=@Empresa AND v.Moneda = @Moneda AND v.Periodo = @PeriodoA AND v.Ejercicio = @Folio),
         'Cantidad3'	= (SELECT SUM(ISNULL(v.CantidadNeta,0.00)) FROM VentaArt v Where v.Articulo = a.Articulo AND v.Empresa=@Empresa AND v.Moneda = @Moneda AND v.Periodo = @PeriodoA AND v.Ejercicio = @Folio),
         'MonedaCosto'	= ISNULL(a.MonedaCosto,0.00),
         'UltimoCosto'	= ISNULL(ac.UltimoCosto,0.00),
         'CostoPromedio'= ISNULL(ac.CostoPromedio,0.00),
         'Disponible'	= SUM(ISNULL(aen.Disponible,0.00)),
         'Periodo'		= dbo.fnMesNumeroNombre(@Periodo),
         'Ejercicio'	= @Ejercicio,
		 'PeriodoD'		= dbo.fnMesNumeroNombre(@PeriodoD),
		 'Opcion'		= @Opcion,
		 'PeriodoA'		= dbo.fnMesNumeroNombre(@PeriodoA),
		 'Folio'		= @Folio

     FROM Art a
     LEFT OUTER JOIN Artcosto ac ON a.Articulo = ac.Articulo AND ac.Empresa  = @Empresa
     LEFT OUTER JOIN ArtDisponible aen ON a.Articulo = aen.Articulo AND aen.Empresa = @Empresa
    WHERE ISNULL(a.Categoria,'') = ISNULL(@ArtCat, ISNULL(a.Categoria,''))
      AND ISNULL(a.Grupo,'') = ISNULL(@ArtGrupo, ISNULL(a.Grupo,''))
      AND ISNULL(a.Familia,'') = ISNULL(@ArtFam, ISNULL(a.Familia,''))
      AND ISNULL(a.Fabricante,'') = ISNULL(@Fabricante, ISNULL(a.Fabricante,''))
      AND aen.Empresa = @Empresa
    GROUP BY a.articulo, 
             a.MonedaCosto, 
             a.Descripcion1, 
             ac.UltimoCosto, 
             ac.CostoPromedio,       
             a.Categoria,
             a.Grupo,
             a.Familia,
             a.Fabricante,
             aen.Empresa
    
    ) AS x
    ORDER BY x.Categoria, x.Fabricante, x.Grupo, x.Familia
      
 
  DECLARE crCategoria CURSOR FAST_FORWARD FOR
  SELECT ISNULL(Categoria, '(Sin Categoría)')
    FROM @InformeVentaTrimestral 
   WHERE Estacion = @EstacionTrabajo
   GROUP BY Categoria

  OPEN crCategoria
  FETCH NEXT FROM crCategoria INTO @Categoria
  WHILE @@FETCH_STATUS = 0 --AND @Ok IS NULL
  BEGIN
    
    INSERT INTO @InformeVentaTrimestral(Estacion, Moneda,  Categoria2,  Grafica1,   Grafica2, Grafica3, Grafica4, SaldoDescripcion,						SaldoImporte,           FechaGrafica)
    SELECT       			   @EstacionTrabajo, @Moneda, @Categoria, @Verdadero, @Falso,   @Falso,   @Falso,   ISNULL(Fabricante, '(Sin Fabricante)'), SUM(ISNULL(Mes1,0.00)), dbo.fnMesNumeroNombre(@Periodo) + ' ' + CONVERT(varchar,@Ejercicio)
      FROM @InformeVentaTrimestral 
     WHERE Categoria  = @Categoria     
     GROUP BY Fabricante
     ORDER BY SUM(ISNULL(Mes1,0.00))
     
    INSERT INTO @InformeVentaTrimestral(Estacion, Moneda,  Categoria2,  Grafica1,   Grafica2, Grafica3, Grafica4, SaldoDescripcion,						SaldoImporte,           FechaGrafica)
    SELECT       			   @EstacionTrabajo, @Moneda, @Categoria, @Verdadero, @Falso,   @Falso,   @Falso,   ISNULL(Fabricante, '(Sin Fabricante)'), SUM(ISNULL(Mes2,0.00)), dbo.fnMesNumeroNombre(@PeriodoD) + ' ' + CONVERT(varchar,@Opcion)
      FROM @InformeVentaTrimestral 
     WHERE Categoria  = @Categoria     
     GROUP BY Fabricante
     ORDER BY SUM(ISNULL(Mes2,0.00))

    INSERT INTO @InformeVentaTrimestral(Estacion, Moneda,  Categoria2,  Grafica1,   Grafica2, Grafica3, Grafica4, SaldoDescripcion,						SaldoImporte,           FechaGrafica)
    SELECT       			   @EstacionTrabajo, @Moneda, @Categoria, @Verdadero, @Falso,   @Falso,   @Falso,   ISNULL(Fabricante, '(Sin Fabricante)'), SUM(ISNULL(Mes3,0.00)), dbo.fnMesNumeroNombre(@PeriodoA) + ' ' + CONVERT(varchar,@Folio)
      FROM @InformeVentaTrimestral 
     WHERE Categoria  = @Categoria     
     GROUP BY Fabricante
     ORDER BY SUM(ISNULL(Mes3,0.00))

    INSERT INTO @InformeVentaTrimestral(Estacion, Moneda,  Categoria2,  Grafica1,   Grafica2,   Grafica3, Grafica4, SaldoDescripcion,				SaldoImporte,          FechaGrafica)
    SELECT       			   @EstacionTrabajo, @Moneda, @Categoria, @Verdadero, @Verdadero, @Falso,   @Falso,   ISNULL(Grupo, '(Sin Grupo)'), SUM(ISNULL(Mes1,0.00)), dbo.fnMesNumeroNombre(@Periodo) + ' ' + CONVERT(varchar,@Ejercicio)
      FROM @InformeVentaTrimestral 
     WHERE Categoria  = @Categoria
     GROUP BY Grupo
     ORDER BY SUM(ISNULL(Mes1,0.00))

    INSERT INTO @InformeVentaTrimestral(Estacion, Moneda,  Categoria2,  Grafica1,   Grafica2,   Grafica3, Grafica4, SaldoDescripcion,				SaldoImporte,           FechaGrafica)
    SELECT       			   @EstacionTrabajo, @Moneda, @Categoria, @Verdadero, @Verdadero, @Falso,   @Falso,   ISNULL(Grupo, '(Sin Grupo)'), SUM(ISNULL(Mes2,0.00)), dbo.fnMesNumeroNombre(@PeriodoD) + ' ' + CONVERT(varchar,@Opcion)
      FROM @InformeVentaTrimestral 
     WHERE Categoria  = @Categoria
     GROUP BY Grupo
     ORDER BY SUM(ISNULL(Mes2,0.00))

    INSERT INTO @InformeVentaTrimestral(Estacion, Moneda,  Categoria2,  Grafica1,   Grafica2,   Grafica3, Grafica4, SaldoDescripcion,				SaldoImporte,           FechaGrafica)
    SELECT       			   @EstacionTrabajo, @Moneda, @Categoria, @Verdadero, @Verdadero, @Falso,   @Falso,   ISNULL(Grupo, '(Sin Grupo)'), SUM(ISNULL(Mes3,0.00)), dbo.fnMesNumeroNombre(@PeriodoA) + ' ' + CONVERT(varchar,@Folio)
      FROM @InformeVentaTrimestral 
     WHERE Categoria  = @Categoria
     GROUP BY Grupo
     ORDER BY SUM(ISNULL(Mes3,0.00))

    INSERT INTO @InformeVentaTrimestral(Estacion, Moneda,  Categoria2,  Grafica1,   Grafica2,   Grafica3,   Grafica4, SaldoDescripcion,				  SaldoImporte,           FechaGrafica)
    SELECT       			   @EstacionTrabajo, @Moneda, @Categoria, @Verdadero, @Verdadero, @Verdadero, @Falso,   ISNULL(Familia, '(Sin Familia)'), SUM(ISNULL(Mes1,0.00)), dbo.fnMesNumeroNombre(@Periodo) + ' ' + CONVERT(varchar,@Ejercicio)
      FROM @InformeVentaTrimestral 
     WHERE Categoria  = @Categoria
     GROUP BY Familia
     ORDER BY SUM(ISNULL(Mes1,0.00))

    INSERT INTO @InformeVentaTrimestral(Estacion, Moneda,  Categoria2,  Grafica1,   Grafica2,   Grafica3,   Grafica4, SaldoDescripcion,				  SaldoImporte,           FechaGrafica)
    SELECT       			   @EstacionTrabajo, @Moneda, @Categoria, @Verdadero, @Verdadero, @Verdadero, @Falso,   ISNULL(Familia, '(Sin Familia)'), SUM(ISNULL(Mes2,0.00)), dbo.fnMesNumeroNombre(@PeriodoD) + ' ' + CONVERT(varchar,@Opcion)
      FROM @InformeVentaTrimestral 
     WHERE Categoria  = @Categoria
     GROUP BY Familia
     ORDER BY SUM(ISNULL(Mes2,0.00))

    INSERT INTO @InformeVentaTrimestral(Estacion, Moneda,  Categoria2,  Grafica1,   Grafica2,   Grafica3,   Grafica4, SaldoDescripcion,				  SaldoImporte,           FechaGrafica)
    SELECT       			   @EstacionTrabajo, @Moneda, @Categoria, @Verdadero, @Verdadero, @Verdadero, @Falso,   ISNULL(Familia, '(Sin Familia)'), SUM(ISNULL(Mes3,0.00)), dbo.fnMesNumeroNombre(@PeriodoA) + ' ' + CONVERT(varchar,@Folio)
      FROM @InformeVentaTrimestral 
     WHERE Categoria  = @Categoria
     GROUP BY Familia
     ORDER BY SUM(ISNULL(Mes3,0.00))

    INSERT INTO @InformeVentaTrimestral(Estacion, Moneda,  Categoria2,  Grafica1,   Grafica2,   Grafica3,   Grafica4,  SaldoDescripcion,				  SaldoImporte,           FechaGrafica)
    SELECT       			   @EstacionTrabajo, @Moneda, @Categoria, @Verdadero, @Verdadero, @Verdadero, @Verdadero, ISNULL(Categoria, '(Sin Categoria)'), SUM(ISNULL(Mes1,0.00)), dbo.fnMesNumeroNombre(@Periodo) + ' ' + CONVERT(varchar,@Ejercicio)
      FROM @InformeVentaTrimestral 
     WHERE Categoria  = @Categoria
     GROUP BY Categoria
     ORDER BY SUM(ISNULL(Mes1,0.00))

    INSERT INTO @InformeVentaTrimestral(Estacion, Moneda,  Categoria2,  Grafica1,   Grafica2,   Grafica3,   Grafica4,  SaldoDescripcion,				  SaldoImporte,           FechaGrafica)
    SELECT       			   @EstacionTrabajo, @Moneda, @Categoria, @Verdadero, @Verdadero, @Verdadero, @Verdadero, ISNULL(Categoria, '(Sin Categoria)'), SUM(ISNULL(Mes2,0.00)), dbo.fnMesNumeroNombre(@PeriodoD) + ' ' + CONVERT(varchar,@Opcion)
      FROM @InformeVentaTrimestral 
     WHERE Categoria  = @Categoria
     GROUP BY Categoria
     ORDER BY SUM(ISNULL(Mes2,0.00))

    INSERT INTO @InformeVentaTrimestral(Estacion, Moneda,  Categoria2,  Grafica1,   Grafica2,   Grafica3,   Grafica4,  SaldoDescripcion,				  SaldoImporte,           FechaGrafica)
    SELECT       			   @EstacionTrabajo, @Moneda, @Categoria, @Verdadero, @Verdadero, @Verdadero, @Verdadero, ISNULL(Categoria, '(Sin Categoria)'), SUM(ISNULL(Mes3,0.00)), dbo.fnMesNumeroNombre(@PeriodoA) + ' ' + CONVERT(varchar,@Folio)
      FROM @InformeVentaTrimestral 
     WHERE Categoria  = @Categoria
     GROUP BY Categoria
     ORDER BY SUM(ISNULL(Mes3,0.00))

    FETCH NEXT FROM crCategoria INTO @Categoria
  END
  CLOSE crCategoria
  DEALLOCATE crCategoria



  DECLARE crGraficar CURSOR FAST_FORWARD FOR
   SELECT Moneda, Categoria2, Grafica2, Grafica3
     FROM @InformeVentaTrimestral
    WHERE Estacion = @EstacionTrabajo
      AND Grafica1 = 1
    GROUP BY Moneda, Categoria2, Grafica2, Grafica3

  OPEN crGraficar
  FETCH NEXT FROM crGraficar INTO @Moneda, @Categoria, @Grafica2, @Grafica3
  WHILE @@FETCH_STATUS = 0
  BEGIN

    SELECT @Graficar = NULL
    SELECT @Graficar = ISNULL(COUNT(DISTINCT SaldoDescripcion),0)
      FROM @InformeVentaTrimestral
     WHERE Estacion = @EstacionTrabajo
       AND Grafica1 = 1
       AND Grafica2 = @Grafica2
       AND Grafica3 = @Grafica3
       AND @Moneda = Moneda
       AND Categoria2 = @Categoria

--  IF @Graficar > 1
--  select @Moneda, @Categoria, @Grafica2, @Grafica3, @Graficar, @GraficarTipo

         
    IF @GraficarTipo = 'Mas Sobresalientes' AND @Graficar > @GraficarCantidad
      DELETE @InformeVentaTrimestral 
       WHERE SaldoDescripcion NOT IN(
      SELECT  TOP (@GraficarCantidad) SaldoDescripcion
        FROM
        (
        SELECT
            'SaldoDescripcion'  = SaldoDescripcion,
            'SaldoImporte'      = SUM(SaldoImporte)
     
          FROM @InformeVentaTrimestral
         WHERE Estacion = @EstacionTrabajo
           AND Grafica1 = 1
           AND Grafica2 = @Grafica2
           AND Grafica3 = @Grafica3
           AND Grafica4 = 0
           AND @Moneda = Moneda
           AND Categoria2 = @Categoria
          GROUP BY Moneda,  SaldoDescripcion
        ) AS x
       GROUP BY x.SaldoDescripcion
       ORDER BY SUM(ISNULL(x.SaldoImporte,0.00))DESC)
         AND Estacion = @EstacionTrabajo
         AND Grafica1 = 1
         AND Grafica2 = @Grafica2
         AND Grafica3 = @Grafica3
         AND Grafica4 = 0
         AND @Moneda = Moneda
         AND Categoria2 = @Categoria

    IF @GraficarTipo = 'Menos Sobresalientes' AND @Graficar > @GraficarCantidad
      DELETE @InformeVentaTrimestral 
       WHERE SaldoDescripcion NOT IN(
      SELECT  TOP (@GraficarCantidad) SaldoDescripcion
        FROM
        (
        SELECT
            'SaldoDescripcion'  = SaldoDescripcion,
            'SaldoImporte'      = SUM(SaldoImporte)
     
          FROM @InformeVentaTrimestral
         WHERE Estacion = @EstacionTrabajo
           AND Grafica1 = 1
           AND Grafica2 = @Grafica2
           AND Grafica3 = @Grafica3
           AND Grafica4 = 0
           AND @Moneda = Moneda
           AND Categoria2 = @Categoria
          GROUP BY Moneda,  SaldoDescripcion
        ) AS x
       GROUP BY x.SaldoDescripcion
       ORDER BY SUM(ISNULL(x.SaldoImporte,0.00))ASC)
         AND Estacion = @EstacionTrabajo
         AND Grafica1 = 1
         AND Grafica2 = @Grafica2
         AND Grafica3 = @Grafica3
         AND Grafica4 = 0
         AND @Moneda = Moneda
         AND Categoria2 = @Categoria
           
    FETCH NEXT FROM crGraficar INTO @Moneda, @Categoria, @Grafica2, @Grafica3--, @Grafica4
  END
  CLOSE crGraficar
  DEALLOCATE crGraficar

  SELECT @Graficar = NULL
  SELECT @Graficar = ISNULL(COUNT(DISTINCT SaldoDescripcion),0)
    FROM @InformeVentaTrimestral
   WHERE Estacion = @EstacionTrabajo
     AND Grafica1 = 1
     AND Grafica2 = 1
     AND Grafica3 = 1
     AND Grafica4 = 1
         
  IF @GraficarTipo = 'Mas Sobresalientes' AND @Graficar > @GraficarCantidad
    DELETE @InformeVentaTrimestral 
     WHERE SaldoDescripcion NOT IN(
    SELECT  TOP (@GraficarCantidad) SaldoDescripcion
      FROM
      (
      SELECT
          'SaldoDescripcion'  = SaldoDescripcion,
          'SaldoImporte'      = SUM(SaldoImporte)
    
        FROM @InformeVentaTrimestral
       WHERE Estacion = @EstacionTrabajo
         AND Grafica1 = 1
         AND Grafica2 = 1
		 AND Grafica3 = 1
		 AND Grafica4 = 1
        GROUP BY SaldoDescripcion
      ) AS x
     GROUP BY x.SaldoDescripcion
     ORDER BY SUM(ISNULL(x.SaldoImporte,0.00))DESC)
       AND Estacion = @EstacionTrabajo
	   AND Grafica1 = 1
       AND Grafica2 = 1
       AND Grafica3 = 1
       AND Grafica4 = 1

  IF @GraficarTipo = 'Menos Sobresalientes' AND @Graficar > @GraficarCantidad
    DELETE @InformeVentaTrimestral 
     WHERE SaldoDescripcion NOT IN(
    SELECT  TOP (@GraficarCantidad) SaldoDescripcion
      FROM
      (
      SELECT
          'SaldoDescripcion'  = SaldoDescripcion,
          'SaldoImporte'      = SUM(SaldoImporte)
   
        FROM @InformeVentaTrimestral
       WHERE Estacion = @EstacionTrabajo
         AND Grafica1 = 1
         AND Grafica2 = 1
         AND Grafica3 = 1
         AND Grafica4 = 1
        GROUP BY SaldoDescripcion
      ) AS x
     GROUP BY x.SaldoDescripcion
     ORDER BY SUM(ISNULL(x.SaldoImporte,0.00))ASC)
       AND Estacion = @EstacionTrabajo
       AND Grafica1 = 1
       AND Grafica2 = 1
       AND Grafica3 = 1
       AND Grafica4 = 1

  UPDATE @InformeVentaTrimestral SET Titulo = @Titulo, EmpresaNombre = @EmpresaNombre, Etiqueta = @Etiqueta WHERE Estacion = @EstacionTrabajo
  
  SELECT * , @VerGraficaDetalle as VerGraficaDetalle FROM @InformeVentaTrimestral WHERE Estacion = @EstacionTrabajo ORDER BY IDInforme   
  
END
GO
--EXEC spInformeVentaTrimestral 1
--UPDATE RepParam SET InfoEmpresa = '1', InfoMoneda = 'Pesos', InfoPeriodoD = 6, InfoEjercicio = 2010, InfoArtCat = NULL, InfoArtGrupo = NULL, InfoArtFam = NULL, InfoFabricante = NULL -- FCR


/**************** spVerContBalanzaMayorPorMes ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerContBalanzaMayorPorMes') and type = 'P') drop procedure dbo.spVerContBalanzaMayorPorMes
go
CREATE PROCEDURE spVerContBalanzaMayorPorMes
	@Empresa		varchar(5),
	@Ejercicio		int,
	@PeriodoD		int,
	@PeriodoA		int,
	@ConMovs		varchar(20) = 'NO',
	@CuentaD		varchar(20) = NULL,
	@CuentaA		varchar(20) = NULL,
	@CentroCostos		varchar(20) = NULL,
	@Categoria		varchar(50) = NULL,
	@Grupo			varchar(50) = NULL,
	@Familia		varchar(50) = NULL,
	@Sucursal		int 	    = NULL,
        @Moneda			varchar(10) = NULL,
	@Controladora		varchar(5)  = NULL,
	@UEN			int	    = NULL,
	@Proyecto		varchar(50) = NULL,
	@CentroCostos2		varchar(50) = NULL,
	@CentroCostos3		varchar(50) = NULL
--//WITH ENCRYPTION
AS BEGIN
DECLARE
  @Rama   		varchar(5),
  @CuentaRangoD		varchar(20),
  @CuentaRangoA		varchar(20),
  @Tipos  		varchar(100),
  @Inicio 		money

SELECT @Rama = 'CONT'

SELECT @CuentaRangoD = NULLIF(RTRIM(@CuentaD), '0'), @CuentaRangoA = NULLIF(RTRIM(@CuentaA), '0')
IF @CuentaRangoD IS NULL SELECT @CuentaRangoD = MIN(Cuenta) FROM Cta
IF @CuentaRangoA IS NULL SELECT @CuentaRangoA = MAX(Cuenta) FROM Cta
IF UPPER(@CentroCostos)  IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos = NULL
IF UPPER(@Categoria)     IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Categoria = NULL
IF UPPER(@Grupo) 	 IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Grupo = NULL
IF UPPER(@Familia) 	 IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Familia = NULL
IF UPPER(@Proyecto)  	 IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Proyecto = NULL
IF UPPER(@CentroCostos2) IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos2 = NULL
IF UPPER(@CentroCostos3) IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos3 = NULL

IF @UEN = 0 SELECT @UEN = NULL
IF @Sucursal <0 SELECT @Sucursal = NULL

SELECT @Moneda = NULLIF(NULLIF(RTRIM(@Moneda), ''), '0')
IF @Moneda IS NULL SELECT @Moneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa

CREATE TABLE #VerContBalanza(
	Cuenta		varchar(20)	COLLATE Database_Default NULL,
	Descripcion	varchar(100)	COLLATE Database_Default NULL,
	Tipo		varchar(15)	COLLATE Database_Default NULL,
	Categoria	varchar(50)	COLLATE Database_Default NULL,
	Grupo		varchar(50)	COLLATE Database_Default NULL,
	Familia		varchar(50)	COLLATE Database_Default NULL,
	EsAcumulativa	bit		NULL,
	EsAcreedora	bit		NULL,
	Inicio		money		NULL,
	Cargos		money		NULL,
	Abonos		money		NULL,
	Periodo		int			NULL)
  
  
  IF @ConMovs='NO'
  BEGIN
    INSERT #VerContBalanza (Cuenta, Descripcion, Tipo, Categoria, Grupo, Familia, EsAcumulativa, EsAcreedora, Inicio, Cargos, Abonos, Periodo)
    SELECT aa.Cuenta,
           aa.Descripcion,
           aa.Tipo,
           aa.Categoria,
           aa.Grupo,
           aa.Familia,
           "EsAcumulativa" = Convert(varchar,aa.EsAcumulativa),
           "EsAcreedora" = Convert(varchar,aa.EsAcreedora),
           "Inicio" = ( 
                       SELECT SUM(a2.Cargos)-SUM(a2.Abonos)
                         FROM Cta ab
                         LEFT OUTER JOIN Acum a2 ON ab.Cuenta = a2.Cuenta
                          AND a2.Empresa = @Empresa
                          AND a2.Rama = @Rama
                          AND a2.Ejercicio = @Ejercicio
                          AND a2.Periodo BETWEEN 0 AND @PeriodoD-1
                          AND a2.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
                          AND ISNULL(a2.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a2.Sucursal), 0)
                          AND ISNULL(a2.UEN, 0) = ISNULL(ISNULL(@UEN, a2.UEN), 0)
                          AND ISNULL(a2.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a2.Proyecto), '')
                          AND ISNULL(a2.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a2.SubCuenta), '')
                          AND ISNULL(a2.SubCuenta2, '') = ISNULL(ISNULL(@CentroCostos2, a2.SubCuenta2), '')
                          AND ISNULL(a2.SubCuenta3, '') = ISNULL(ISNULL(@CentroCostos3, a2.SubCuenta3), '')
                          AND a2.Moneda = @Moneda
                        WHERE UPPER(ab.Tipo) = 'Mayor'
                          AND aa.Cuenta = ab.Cuenta
                       ),
           "Cargos" = Sum(Acum.Cargos),
           "Abonos" = Sum(Acum.Abonos),
           Acum.Periodo
      FROM Cta aa
      LEFT OUTER JOIN Acum ON aa.Cuenta = Acum.Cuenta
       AND Acum.Empresa = @Empresa
       AND Acum.Rama = @Rama
       AND Acum.Ejercicio = @Ejercicio
       AND Acum.Periodo BETWEEN @PeriodoD AND @PeriodoA
       AND ISNULL(Acum.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, Acum.Sucursal), 0)
       AND ISNULL(Acum.UEN, 0) = ISNULL(ISNULL(@UEN, Acum.UEN), 0)
       AND ISNULL(Acum.Proyecto, '') = ISNULL(ISNULL(@Proyecto, Acum.Proyecto), '')
       AND ISNULL(Acum.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, Acum.SubCuenta), '')
       AND ISNULL(Acum.SubCuenta2, '') = ISNULL(ISNULL(@CentroCostos2, Acum.SubCuenta2), '')
       AND ISNULL(Acum.SubCuenta3, '') = ISNULL(ISNULL(@CentroCostos3, Acum.SubCuenta3), '')
       AND Acum.Moneda = @Moneda
     WHERE UPPER(aa.Tipo) = 'Mayor'
       AND aa.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
     GROUP BY aa.Cuenta, aa.Descripcion, aa.Tipo, aa.Categoria, aa.Grupo, aa.Familia, Convert(varchar,aa.EsAcumulativa), Convert(varchar,aa.EsAcreedora), Acum.Periodo
     ORDER BY aa.Cuenta, aa.Descripcion, aa.Tipo, aa.Categoria, aa.Grupo, aa.Familia, Convert(varchar,aa.EsAcumulativa), Convert(varchar,aa.EsAcreedora), Acum.Periodo
  END 

  ELSE
  BEGIN
    INSERT #VerContBalanza (Cuenta, Descripcion, Tipo, Categoria, Grupo, Familia, EsAcumulativa, EsAcreedora, Inicio, Cargos, Abonos, Periodo)
    SELECT aa.Cuenta,
           aa.Descripcion,
           aa.Tipo,
           aa.Categoria,
           aa.Grupo,
           aa.Familia,
           "EsAcumulativa" = Convert(varchar,aa.EsAcumulativa),
           "EsAcreedora" = Convert(varchar,aa.EsAcreedora),
           "Inicio" = (
                       SELECT SUM(a2.Cargos)-SUM(a2.Abonos)
                         FROM Cta ab
                         LEFT OUTER JOIN Acum a2 ON ab.Cuenta = a2.Cuenta 
                          AND a2.Empresa = @Empresa
                          AND a2.Rama = @Rama
                          AND a2.Ejercicio = @Ejercicio
                          AND a2.Periodo BETWEEN 0 AND @PeriodoD-1
                          AND a2.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
                          AND ISNULL(a2.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a2.Sucursal), 0)
                          AND ISNULL(a2.UEN, 0) = ISNULL(ISNULL(@UEN, a2.UEN), 0)
                          AND ISNULL(a2.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a2.Proyecto), '')
                          AND ISNULL(a2.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a2.SubCuenta), '')
                          AND ISNULL(a2.SubCuenta2, '') = ISNULL(ISNULL(@CentroCostos2, a2.SubCuenta2), '')
                          AND ISNULL(a2.SubCuenta3, '') = ISNULL(ISNULL(@CentroCostos3, a2.SubCuenta3), '')
                          AND a2.Moneda = @Moneda
                        WHERE UPPER(ab.Tipo) = 'Mayor'
                          AND aa.Cuenta = ab.Cuenta
                      ),
           "Cargos" = Sum(Acum.Cargos),
           "Abonos" = Sum(Acum.Abonos),
           Acum.Periodo
      FROM Cta aa
      LEFT OUTER JOIN Acum ON aa.Cuenta = Acum.Cuenta 
       AND Acum.Empresa = @Empresa
       AND Acum.Rama = @Rama
       AND Acum.Ejercicio = @Ejercicio
       AND Acum.Periodo BETWEEN @PeriodoD AND @PeriodoA
       AND ISNULL(Acum.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, Acum.Sucursal), 0)
       AND ISNULL(Acum.UEN, 0) = ISNULL(ISNULL(@UEN, Acum.UEN), 0)
       AND ISNULL(Acum.Proyecto, '') = ISNULL(ISNULL(@Proyecto, Acum.Proyecto), '')
       AND ISNULL(Acum.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, Acum.SubCuenta), '')
       AND ISNULL(Acum.SubCuenta2, '') = ISNULL(ISNULL(@CentroCostos2, Acum.SubCuenta2), '')
       AND ISNULL(Acum.SubCuenta3, '') = ISNULL(ISNULL(@CentroCostos3, Acum.SubCuenta3), '')
       AND Acum.Moneda = @Moneda
     WHERE UPPER(aa.Tipo) = 'Mayor'
       AND aa.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
     GROUP BY aa.Cuenta, aa.Descripcion, aa.Tipo, aa.Categoria, aa.Grupo, aa.Familia, Convert(varchar,aa.EsAcumulativa), Convert(varchar,aa.EsAcreedora), Acum.Periodo
    HAVING ( Sum(ISNULL(Acum.Cargos,0.0))<>0.0 OR Sum(ISNULL(Acum.Abonos,0.0))<>0.0 OR
   (SELECT SUM(ISNULL(a2.Cargos,0.0))-SUM(ISNULL(a2.Abonos,0.0)) FROM Cta ab LEFT OUTER JOIN Acum a2 ON ab.Cuenta = a2.Cuenta AND a2.Empresa = @Empresa AND a2.Rama = @Rama AND a2.Ejercicio = @Ejercicio AND a2.Periodo BETWEEN 0 AND @PeriodoD-1 AND a2.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA WHERE UPPER(ab.Tipo) = 'Mayor' AND aa.Cuenta = ab.Cuenta) <> 0.0)
     ORDER BY aa.Cuenta, aa.Descripcion, aa.Tipo, aa.Categoria, aa.Grupo, aa.Familia, Convert(varchar,aa.EsAcumulativa), Convert(varchar,aa.EsAcreedora), Acum.Periodo
  
  END

  SELECT Cuenta,
         Descripcion,
         Tipo,
         EsAcumulativa,
         EsAcreedora,
         Inicio,
         Cargos,
         Abonos,
         ISNULL(Periodo, 0) Periodo,
         ISNULL(Inicio,0.00) + ISNULL(Abonos,0.00) - ISNULL(Cargos,0.00) Final
    FROM #VerContBalanza
   WHERE ISNULL(Categoria, '') = ISNULL(ISNULL(@Categoria, Categoria) , '')
     AND ISNULL(Grupo, '')     = ISNULL(ISNULL(@Grupo, Grupo) , '')
     AND ISNULL(Familia, '')   = ISNULL(ISNULL(@Familia, Familia) , '')
   ORDER BY Cuenta, Periodo
   
END
GO
--EXEC spVerContBalanzaMayorPorMes 'E-007', 2009, 1, 3, 'NO', '1.01.01', '7.03.05', '(Todos)', '(Todos)', '(Todos)', '(Todos)', -1, 'Quetzales', 'NULL', NULL, '(Todos)', '(Todos)', '(Todos)'


/******************************* spInformeContBalanza *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spInformeContBalanza') and type = 'P') drop procedure dbo.spInformeContBalanza
GO             
CREATE PROCEDURE spInformeContBalanza
		@EstacionTrabajo		int

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
	@Empresa		varchar	(5),
	@Ejercicio		int,
	@PeriodoD		int,
	@PeriodoA		int,
	@ConMovs		varchar	(20),
	@Tipo			varchar	(20),
	@CuentaD		varchar	(20),
	@CuentaA		varchar	(20),
	@CentroCostos	varchar	(20),
	@Cuenta		varchar	(50),
	@Grupo			varchar	(50),
	@Familia		varchar	(50),
	@Sucursal		int,
	@Moneda			varchar	(10),
	@Controladora	varchar	(5),
	@UEN			int,
	@Proyecto		varchar	(50),
	@CentroCostos2	varchar	(50),
	@CentroCostos3	varchar	(50),
	@EmpresaNombre	varchar	(100),
	@Titulo			varchar	(100),
	@Reporte		varchar	(100),
	@Direccion2		varchar	(100),
	@Direccion3		varchar	(100),
	@Direccion4		varchar	(100),
	@Graficar				int,
	@GraficarFecha			int,
	@GraficarTipo			varchar(30),
	@Etiqueta				bit,
	@GraficarCantidad		int,
	@Verdadero				bit,
	@Falso					bit,
	@Inicio					float,
	@Cargos					float,
	@Abonos					float,
	@Final					float,
    @VerGraficaDetalle		bit
	
  SELECT @Verdadero = 1, @Falso = 0
  SELECT
    @Empresa		=	InfoEmpresa,
	@Ejercicio		=	InfoEjercicio,
	@PeriodoD		=	InfoPeriodoD,
	@PeriodoA		=	InfoPeriodoA,
	@ConMovs		=	InfoConMovs,
	@Tipo			=	InfoCtaNivel,
	@CuentaD		=	InfoCtaD,
	@CuentaA		=	InfoCtaA,
	@CentroCostos	=	InfoCentroCostos,
	@Cuenta			=	InfoCtaCat,
	@Grupo			=	InfoCtaGrupo,
	@Familia		=	InfoCtaFam,
	@Sucursal		=	InfoSucursal,
	@Moneda			=	InfoMoneda,
	@Controladora	=	NULL,
	@UEN			=	InfoUEN,
	@Proyecto		=	InfoProyecto,
	@CentroCostos2	=	InfoCentroCostos2,
	@CentroCostos3	=	InfoCentroCostos3,
	@Titulo			=	RepTitulo,
	@GraficarTipo	=	ISNULL(InformeGraficarTipo,  '(Todos)'),
	@Etiqueta		=	ISNULL(InfoEtiqueta, @Falso),
	@GraficarCantidad = ISNULL(InformeGraficarCantidad, 5),
    @VerGraficaDetalle = ISNULL(VerGraficaDetalle,0)
	
    FROM RepParam
   WHERE Estacion = @EstacionTrabajo 

  SELECT @EmpresaNombre = Nombre FROM Empresa WHERE Empresa = @Empresa
  
  SELECT @Reporte = 'Ejercicio ' + CONVERT(varchar,@Ejercicio) + ' de ' + dbo.fnMesNumeroNombre(@PeriodoD) + ' a ' + dbo.fnMesNumeroNombre(@PeriodoA) + ' En Moneda ' + @Moneda

  EXEC spContactoDireccionHorizontal @EstacionTrabajo, 'Empresa', @Empresa, @Empresa, 1, 1, 1, 1
  
  SELECT @Direccion2 = Direccion2,
         @Direccion3 = Direccion3,
         @Direccion4 = Direccion4 
    FROM ContactoDireccionHorizontal
   WHERE Estacion = @EstacionTrabajo

--SELECT @Empresa, @Ejercicio, @PeriodoD, @PeriodoA, @ConMovs, @Tipo, @CuentaD, @CuentaA, @CentroCostos, @Cuenta, @Grupo, @Familia, @Sucursal, @Moneda, @Controladora, @UEN, @Proyecto, @CentroCostos2, @CentroCostos3

  DECLARE @Datos TABLE
  (
   Estacion					int,
   Empresa					varchar(5) COLLATE DATABASE_DEFAULT NULL,
   EmpresaNombre			varchar(100) COLLATE DATABASE_DEFAULT NULL,
   Cuenta					varchar(20) COLLATE DATABASE_DEFAULT NULL,
   CuentaNombre				varchar(100) COLLATE DATABASE_DEFAULT NULL,   
   Tipo						varchar(20) COLLATE DATABASE_DEFAULT NULL,   
   Inicio					float NULL,
   Cargos					float NULL,
   Abonos					float NULL,
   Periodo					int NULL,
   Final					float NULL,
   GraficaArgumento			varchar(100) COLLATE DATABASE_DEFAULT NULL,   
   GraficaValor				float NULL,
   Grafica					int NULL DEFAULT 0,
   Titulo					varchar(100) NULL,
   Reporte					varchar(100) NULL,
   Direccion2				varchar(100) NULL,
   Direccion3				varchar(100) NULL,
   Direccion4				varchar(100) NULL,
   Total					bit DEFAULT 0 NULL

  )    

  DECLARE @DatosTotal TABLE
  (
   
   Inicio					float NULL,
   Cargos					float NULL,
   Abonos					float NULL
   
  )    

  DECLARE @ContBalanza TABLE
  (
   Cuenta				varchar(20) COLLATE DATABASE_DEFAULT NULL,
   Descripcion			varchar(100) COLLATE DATABASE_DEFAULT NULL,
   Tipo					varchar(20) COLLATE DATABASE_DEFAULT NULL,
   EsAcumulativa		bit,
   EsAcreedora			bit,
   Inicio				float NULL,
   Cargos				float NULL,
   Abonos				float NULL
  )    

  DECLARE @ContBalanzaMayorPorMes TABLE
  (
   Cuenta				varchar(20) COLLATE DATABASE_DEFAULT NULL,
   Descripcion			varchar(100) COLLATE DATABASE_DEFAULT NULL,
   Tipo					varchar(20) COLLATE DATABASE_DEFAULT NULL,
   EsAcumulativa		bit,
   EsAcreedora			bit,
   Inicio				float NULL,
   Cargos				float NULL,
   Abonos				float NULL,
   Periodo				int NULL,
   Final				float NULL
  )    


  INSERT INTO @ContBalanza
  EXEC spVerContBalanza @Empresa, @Ejercicio, @PeriodoD, @PeriodoA, @ConMovs, @Tipo, @CuentaD, @CuentaA, @CentroCostos, @Cuenta, @Grupo, @Familia, @Sucursal, @Moneda, @Controladora, @UEN, @Proyecto, @CentroCostos2, @CentroCostos3

  INSERT INTO @ContBalanzaMayorPorMes
  EXEC spVerContBalanzaMayorPorMes @Empresa, @Ejercicio, @PeriodoD, @PeriodoA, @ConMovs, @CuentaD, @CuentaA, @CentroCostos, @Cuenta, @Grupo, @Familia, @Sucursal, @Moneda, @Controladora, @UEN, @Proyecto, @CentroCostos2, @CentroCostos3
  
  INSERT INTO @Datos(Estacion,  Empresa, EmpresaNombre,  Cuenta, CuentaNombre, Tipo, Inicio, Cargos, Abonos, Final,															  Titulo,  Reporte,  Direccion2,  Direccion3,  Direccion4)
    SELECT	 @EstacionTrabajo, @Empresa, @EmpresaNombre, Cuenta, Descripcion,  Tipo, Inicio, Cargos, Abonos, ISNULL(Inicio,0.00) + ISNULL(Cargos,0.00) - ISNULL(Abonos,0.00), @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4
      FROM @ContBalanza
  
  INSERT INTO @Datos(Estacion,  Empresa, EmpresaNombre,  Cuenta, CuentaNombre,				   Tipo, Periodo, GraficaArgumento,                                   GraficaValor,																													Grafica, Titulo, Reporte,  Direccion2,  Direccion3,  Direccion4)
    SELECT   @EstacionTrabajo, @Empresa, @EmpresaNombre, Cuenta, SUBSTRING(Descripcion,1,25),  Tipo, Periodo, ISNULL(dbo.fnMesNumeroNombre(Periodo), 'Inicial') , CASE WHEN ISNULL(dbo.fnMesNumeroNombre(Periodo), 'Inicial') = 'Inicial' THEN ISNULL(Inicio,0.00) ELSE ISNULL(Final,0.00) END, 1,		@Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4
      FROM @ContBalanzaMayorPorMes 
   
  INSERT INTO @Datos(Estacion,        Empresa,  EmpresaNombre,   Cuenta, CuentaNombre,				   Tipo, Periodo, GraficaArgumento, GraficaValor,	  Grafica, Titulo,  Reporte,  Direccion2,  Direccion3,  Direccion4)
    SELECT DISTINCT @EstacionTrabajo, @Empresa, @EmpresaNombre,  Cuenta, SUBSTRING(CuentaNombre,1,25), Tipo, 0,		  'Inicial',        ISNULL(Inicio,0), 1,	   @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4
      FROM @Datos 
     WHERE Periodo IN (NULL)
       AND Cuenta IN (
    SELECT DISTINCT Cuenta
      FROM @Datos 
     WHERE Periodo NOT IN (0, NULL))

  DELETE @Datos WHERE Cuenta IN(SELECT Cuenta FROM @Datos WHERE Grafica = 1  GROUP BY Cuenta HAVING COUNT(Periodo) = 1) AND Grafica = 1

  SELECT @Graficar = NULL
  SELECT @Graficar = ISNULL(COUNT(DISTINCT Cuenta),0)
    FROM @Datos
   WHERE Estacion = @EstacionTrabajo
     AND Grafica = 1
       
  IF @GraficarTipo = 'Mas Sobresalientes' AND @Graficar > @GraficarCantidad
    DELETE @Datos 
     WHERE Cuenta NOT IN(
    SELECT  TOP (@GraficarCantidad) Cuenta
      FROM
      (
      SELECT
          'Cuenta'         = Cuenta,
          'GraficaValor'   = SUM(ISNULL(GraficaValor,0.00))
     
        FROM @Datos
       WHERE Estacion = @EstacionTrabajo
         AND Grafica = 1
        GROUP BY Cuenta
      ) AS x
     GROUP BY x.Cuenta
     ORDER BY SUM(ISNULL(x.GraficaValor,0.00))DESC)
       AND Estacion = @EstacionTrabajo
       AND Grafica = 1

  IF @GraficarTipo = 'Menos Sobresalientes' AND @Graficar > @GraficarCantidad
    DELETE @Datos 
     WHERE Cuenta NOT IN(
    SELECT  TOP (@GraficarCantidad) Cuenta
      FROM
      (
      SELECT
          'Cuenta'         = Cuenta,
          'GraficaValor'   = SUM(ISNULL(GraficaValor,0.00))
     
        FROM @Datos
       WHERE Estacion = @EstacionTrabajo
         AND Grafica = 1
        GROUP BY Cuenta
      ) AS x
     GROUP BY x.Cuenta
     ORDER BY SUM(ISNULL(x.GraficaValor,0.00))ASC)
       AND Estacion = @EstacionTrabajo
       AND Grafica = 1	   

  --BUG 16215
  INSERT INTO @DatosTotal (Inicio, Cargos, Abonos)
  Exec spVerContBalanzaTotal  @Empresa, @Ejercicio, @PeriodoD, @PeriodoA, @CuentaD, @CuentaA, @CentroCostos, @Cuenta, @Grupo, @Familia, @Sucursal, @Moneda, @Controladora, @UEN, @Proyecto, @CentroCostos2, @CentroCostos3

  /**
  SELECT @Inicio = SUM(ISNULL(Inicio,0.00)), @Cargos = SUM(ISNULL(Cargos,0.00)), @Abonos =SUM(ISNULL(Abonos,0.00)) 
    FROM @Datos 
   WHERE Grafica = 0
     AND Tipo = @Tipo
  **/

  --BUG 16215
  SELECT @Inicio = ISNULL(Inicio,0.00), @Cargos = ISNULL(Cargos,0.00), @Abonos =ISNULL(Abonos,0.00)
    FROM @DatosTotal
   
  SELECT @Final = @Inicio + @Cargos - @Abonos         
  
  INSERT INTO @Datos(   Estacion,  Empresa, EmpresaNombre,    Inicio,  Cargos,  Abonos,       Final, Titulo,  Reporte,  Direccion2,  Direccion3,  Direccion4,  Total)
  SELECT TOP 1  @EstacionTrabajo, @Empresa, @EmpresaNombre,  @Inicio, @Cargos, @Abonos,      @Final, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4,      1
  FROM @ContBalanza
    
  --BUG 16215
  DELETE @Datos WHERE Cuenta IS NULL AND Total=0   
  
  SELECT *, @Etiqueta as Etiqueta, @VerGraficaDetalle as VerGraficaDetalle FROM @Datos ORDER BY Grafica, Total, Cuenta, Periodo
  
END
GO
--EXEC spInformeContBalanza 2
--EXEC spVerContBalanza 'E-007', 2009, 1, 3, 'NO', 'Mayor', '1.01.01', '7.03.05', '(Todos)', '(Todos)', '(Todos)', '(Todos)', -1, 'Quetzales', 'NULL', NULL, '(Todos)', '(Todos)', '(Todos)'


/******************************* spInformeContResultados *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spInformeContResultados') and type = 'P') drop procedure dbo.spInformeContResultados
GO             
CREATE PROCEDURE spInformeContResultados
		@EstacionTrabajo		int

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  	@Empresa			varchar	(5),
    @Clase				varchar	(30),
    @ClaseAnt			varchar	(30),
    @Contador			int,
    @Orden				int,
    @SaldoAl			float,
    @Saldo				float,
    @ID					int,
	@EmpresaNombre		varchar	(100),
	@Titulo				varchar	(100),
	@Reporte			varchar	(100),
	@Direccion2			varchar	(100),
	@Direccion3			varchar	(100),
	@Direccion4			varchar	(100),
	@Ejercicio			int,
	@PeriodoD			int,
	@PeriodoA			int,
	@ConMovs			varchar	(50),
	@Desglosar			varchar	(50),
	@ContMoneda			varchar	(50),
	@CentroCostos		varchar	(50),
	@CentroCostos2		varchar	(50),
	@CentroCostos3		varchar	(50),
	@AlCentroCostos		varchar	(50),
	@AlCentroCostos2	varchar	(50),
	@AlCentroCostos3	varchar	(50),
	@Proyecto			varchar	(50),
	@UEN				varchar	(50),
	@Sucursal			int,
	@Agrupador			varchar	(50),
	@Grupo				varchar	(50),
	@Etiqueta			bit,
	@Verdadero			bit,
	@Falso				bit,
    @VerGraficaDetalle		bit


  SELECT @Verdadero = 1, @Falso = 0
  SELECT
    @Empresa			=	InfoEmpresa,
	@Ejercicio			=	InfoEjercicio,
	@PeriodoD			=	InfoPeriodoD,
	@PeriodoA			=	InfoPeriodoA,
	@ConMovs			=	InfoConMovs,
	@Desglosar			=	InfoDesglosar,
	@ContMoneda			=	InfoContMoneda,
	@CentroCostos		=	InfoCentroCostos,
	@CentroCostos2		=	InfoCentroCostos2,
	@CentroCostos3		=	InfoCentroCostos3,
	@AlCentroCostos		=	InfoAlCentroCostos,
	@AlCentroCostos2	=	InfoAlCentroCostos2,
	@AlCentroCostos3	=	InfoAlCentroCostos3,
	@Proyecto			=	InfoProyecto,
	@UEN				=	InfoUEN,
	@Sucursal			=	InfoSucursal,
	@Agrupador			=	InfoAgrupadoCC,
	@Grupo				=	InfoGrupoLista,
	@Titulo				=	InfoTituloContRes,
	@Etiqueta			= ISNULL(InfoEtiqueta, @Falso),
    @VerGraficaDetalle = ISNULL(VerGraficaDetalle,0)
	
    FROM RepParam
   WHERE Estacion = @EstacionTrabajo 

  SELECT @EmpresaNombre = Nombre FROM Empresa WHERE Empresa = @Empresa

  EXEC spContactoDireccionHorizontal @EstacionTrabajo, 'Empresa', @Empresa, @Empresa, 1, 1, 1, 1
  
  SELECT @Direccion2 = Direccion2,
         @Direccion3 = Direccion3,
         @Direccion4 = Direccion4 
    FROM ContactoDireccionHorizontal
   WHERE Estacion = @EstacionTrabajo

  SELECT @Reporte = 'Ejercicio ' + CONVERT(varchar,@Ejercicio) + ' de ' + dbo.fnMesNumeroNombre(@PeriodoD) + ' a ' + dbo.fnMesNumeroNombre(@PeriodoA) + ' En Moneda ' + ISNULL(@ContMoneda,'')  
  
  DECLARE @VerContResultados TABLE
  (
     Orden				int		NOT NULL,
     ID					int			NULL,

     Clase				varchar(30)	COLLATE Database_Default NULL,
     SubClase			varchar(20)	COLLATE Database_Default NULL,

     Rama				varchar(20)	COLLATE Database_Default NULL, 
     RamaDesc			varchar(100)COLLATE Database_Default NULL,
     RamaEsAcreedora	bit		NOT NULL DEFAULT 0,

     Cuenta				varchar(20)	COLLATE Database_Default NULL,
     Descripcion		varchar(100)COLLATE Database_Default NULL,
     EsAcreedora		bit		NOT NULL DEFAULT 0,

     SubCuenta			varchar(20)	COLLATE Database_Default NULL,
     CentroCostos		varchar(100)COLLATE Database_Default NULL,

     Saldo				money		NULL,
     Ingresos			money		NULL,
     Porcentaje			float		NULL,

     SaldoAl			money		NULL,
     IngresosAl			money		NULL,
     PorcentajeAl		float		NULL,

	 Grupo				varchar(50)	NULL,
     SubGrupo			varchar(50)	NULL,
     SubSubGrupo		varchar(50)	NULL

  )


  DECLARE @ContResultados TABLE
  (
     Orden				int		NOT NULL,
     ID					int			NULL,

     Clase				varchar(30)	COLLATE Database_Default NULL,
     SubClase			varchar(20)	COLLATE Database_Default NULL,

     Rama				varchar(20)	COLLATE Database_Default NULL, 
     RamaDesc			varchar(100)COLLATE Database_Default NULL,
     RamaEsAcreedora	bit		NOT NULL DEFAULT 0,

     Cuenta				varchar(20)	COLLATE Database_Default NULL,
     Descripcion		varchar(100)COLLATE Database_Default NULL,
     EsAcreedora		bit		NOT NULL DEFAULT 0,

     SubCuenta			varchar(20)	COLLATE Database_Default NULL,
     CentroCostos		varchar(100)COLLATE Database_Default NULL,

     Saldo				money		NULL,
     Ingresos			money		NULL,
     Porcentaje			float		NULL,

     SaldoAl			money		NULL,
     IngresosAl			money		NULL,
     PorcentajeAl		float		NULL,

	 Grupo				varchar(50)	NULL,
     SubGrupo			varchar(50)	NULL,
     SubSubGrupo		varchar(50)	NULL,
     
	 Desglosar			varchar(5)	NULL,
     Orden1				int			NULL,

	 GraficaArgumento	varchar(100) COLLATE DATABASE_DEFAULT NULL,   
     GraficaValor		float		NULL,
     Grafica1			int			NULL DEFAULT 0,
     Grafica2			int			NULL DEFAULT 0,
     Titulo				varchar(100)NULL,
     Reporte			varchar(100)NULL,
     Direccion2			varchar(100)NULL,
     Direccion3			varchar(100)NULL,
     Direccion4			varchar(100)NULL,
     GraficaSerie		varchar(100) COLLATE DATABASE_DEFAULT NULL,
     EmpresaNombre		varchar(100) COLLATE DATABASE_DEFAULT NULL,
     PeriodoA			varchar(100) COLLATE DATABASE_DEFAULT NULL

  )


  DECLARE @Totales TABLE
  (
     Orden				int		    NULL,
     ID					int			NULL,

     Clase				varchar(30)	COLLATE Database_Default NULL,
     SubClase			varchar(20)	COLLATE Database_Default NULL,

     Rama				varchar(20)	COLLATE Database_Default NULL, 
     RamaDesc			varchar(100)COLLATE Database_Default NULL,
     RamaEsAcreedora	bit		NOT NULL DEFAULT 0,

     Cuenta				varchar(20)	COLLATE Database_Default NULL,
     Descripcion		varchar(100)COLLATE Database_Default NULL,
     EsAcreedora		bit		NOT NULL DEFAULT 0,

     SubCuenta			varchar(20)	COLLATE Database_Default NULL,
     CentroCostos		varchar(100)COLLATE Database_Default NULL,

     Saldo				money		NULL,
     Ingresos			money		NULL,
     Porcentaje			float		NULL,

     SaldoAl			money		NULL,
     IngresosAl			money		NULL,
     PorcentajeAl		float		NULL,

	 Grupo				varchar(50)	NULL,
     SubGrupo			varchar(50)	NULL,
     SubSubGrupo		varchar(50)	NULL,
     
	 Desglosar			varchar(5)	NULL,
     Orden1				int			NULL

  )

  INSERT INTO @VerContResultados
  EXEC spVerContResultados @Empresa, @Ejercicio, @PeriodoD, @PeriodoA, @ConMovs, @CentroCostos, @Sucursal, @Agrupador, @ContMoneda, @Grupo, 'NULL'
 
  
  INSERT INTO @ContResultados
  SELECT *, @Desglosar, NULL, NULL, NULL, 0, 0, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, NULL, @EmpresaNombre, dbo.fnMesNumeroNombre(@PeriodoA) FROM @VerContResultados
  
  SELECT @Contador = 0
  DECLARE crOrden CURSOR FAST_FORWARD FOR
   SELECT DISTINCT Clase, Orden
     FROM @VerContResultados
    ORDER BY Orden, Clase

  OPEN crOrden
  FETCH NEXT FROM crOrden INTO @Clase, @Orden
  WHILE @@FETCH_STATUS = 0-- AND @Ok IS NULL
  BEGIN
  
    IF EXISTS(SELECT * FROM @ContResultados WHERE Clase = @Clase AND Orden1 IS NULL) 
    BEGIN
      SELECT @Contador = @Contador + 1
      UPDATE @ContResultados SET Orden1 = @Contador WHERE Clase = @Clase
    END
             
    FETCH NEXT FROM crOrden INTO @Clase, @Orden
  END
  CLOSE crOrden
  DEALLOCATE crOrden
  


  SELECT @SaldoAl = 0.00, @Saldo = 0.00, @ClaseAnt = ''
  DECLARE crOrden CURSOR FAST_FORWARD FOR
   SELECT ID, Clase
     FROM @ContResultados 
    GROUP BY ID, Clase, Orden
    ORDER BY ID

  OPEN crOrden
  FETCH NEXT FROM crOrden INTO @ID, @Clase
  WHILE @@FETCH_STATUS = 0-- AND @Ok IS NULL
  BEGIN
    IF @ClaseAnt = '' SELECT @ClaseAnt = @Clase
    
    IF @ClaseAnt <> @Clase
    BEGIN
      INSERT INTO @ContResultados(GraficaArgumento, GraficaValor, Grafica1, Grafica2, Orden, GraficaSerie, Titulo, Reporte, Direccion2, Direccion3, Direccion4, EmpresaNombre, Desglosar, PeriodoA)
        SELECT @ClaseAnt, @SaldoAl, 1, 0, 999999999, dbo.fnMesNumeroNombre(@PeriodoA), @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @EmpresaNombre, @Desglosar, dbo.fnMesNumeroNombre(@PeriodoA)
      INSERT INTO @ContResultados(GraficaArgumento, GraficaValor, Grafica1, Grafica2, Orden, GraficaSerie, Titulo, Reporte, Direccion2, Direccion3, Direccion4, EmpresaNombre, Desglosar, PeriodoA)
        SELECT @ClaseAnt, @Saldo, 1, 1, 999999999, 'Acumulado', @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @EmpresaNombre, @Desglosar, dbo.fnMesNumeroNombre(@PeriodoA)

--SELECT @ClaseAnt, @Saldo, @SaldoAl
    END
   
    SELECT @SaldoAl = @SaldoAl -ISNULL(SaldoAl,0.00), @Saldo = @Saldo -ISNULL(Saldo,0.00)
      FROM @ContResultados
     WHERE ID = @ID

    SELECT @ClaseAnt = @Clase


    FETCH NEXT FROM crOrden INTO @ID, @Clase
  END

  
  INSERT INTO @ContResultados(GraficaArgumento, GraficaValor, Grafica1, Grafica2, Orden, GraficaSerie, Titulo, Reporte, Direccion2, Direccion3, Direccion4, EmpresaNombre, Desglosar, PeriodoA)
    SELECT @ClaseAnt, @SaldoAl, 1, 0, 999999999, dbo.fnMesNumeroNombre(@PeriodoA), @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @EmpresaNombre, @Desglosar, dbo.fnMesNumeroNombre(@PeriodoA)
  INSERT INTO @ContResultados(GraficaArgumento, GraficaValor, Grafica1, Grafica2, Orden, GraficaSerie, Titulo, Reporte, Direccion2, Direccion3, Direccion4, EmpresaNombre, Desglosar, PeriodoA)
    SELECT @ClaseAnt, @Saldo, 1, 1, 999999999, 'Acumulado', @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @EmpresaNombre, @Desglosar, dbo.fnMesNumeroNombre(@PeriodoA)

  CLOSE crOrden
  DEALLOCATE crOrden
  
  UPDATE @ContResultados 
     SET Saldo = 0.00
   WHERE Saldo IS NULL

  UPDATE @ContResultados 
     SET Ingresos = 0.00
   WHERE Ingresos IS NULL

  UPDATE @ContResultados 
     SET Porcentaje = 0.00
   WHERE Porcentaje IS NULL
  
  UPDATE @ContResultados 
     SET SaldoAl = 0.00
   WHERE SaldoAl IS NULL

  UPDATE @ContResultados 
     SET IngresosAl = 0.00
   WHERE IngresosAl IS NULL

  UPDATE @ContResultados 
     SET PorcentajeAl = 0.00
   WHERE PorcentajeAl IS NULL
    
  SELECT *, @Etiqueta as Etiqueta, @VerGraficaDetalle as VerGraficaDetalle FROM @ContResultados
  
END
GO
--EXEC spInformeContResultados 1
--GO


/******************************* spInformeContResultadosAnuales *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spInformeContResultadosAnuales') and type = 'P') drop procedure dbo.spInformeContResultadosAnuales
GO             
CREATE PROCEDURE spInformeContResultadosAnuales
		@EstacionTrabajo		int

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa		char(5),
    @Clase			varchar	(30),
    @ClaseAnt		varchar	(30),
    @Contador		int,
    @Orden			int,
    @Saldo			float,
    @ID				int,
    @Ejercicio1		int,
    @Saldo1			float,
    @Ejercicio2		int,
    @Saldo2			float,
    @Ejercicio3		int,
    @Saldo3			float,
    @Ejercicio4		int,
    @Saldo4			float,
    @Ejercicio5		int,
    @Saldo5			float,
	@EmpresaNombre	varchar	(100),
	@Titulo			varchar	(100),
	@Reporte		varchar	(100),
	@Direccion2		varchar	(100),
	@Direccion3		varchar	(100),
	@Direccion4		varchar	(100),

	@EjercicioD			int,
	@EjercicioA			int,
	@PeriodoA			int,
	@ConMovs			varchar	(50),
	@Desglosar			varchar	(50),
	@ReporteInf			varchar	(50),
	@ContMoneda			varchar	(50),
	@CentroCostos		varchar	(50),
	@CentroCostos2		varchar	(50),
	@CentroCostos3		varchar	(50),
	@Proyecto			varchar	(50),
	@UEN				varchar	(50),
	@Sucursal			int,
	@Agrupador			varchar	(50),
	@Grupo				varchar	(50),
	@Etiqueta			bit,
	@Verdadero			bit,
	@Falso				bit,
    @VerGraficaDetalle		bit


  SELECT @Verdadero = 1, @Falso = 0
  SELECT
    @Empresa			=	InfoEmpresa,
	@EjercicioD			=	InfoEjercicioD,
	@EjercicioA			=	InfoEjercicioA,	
	@PeriodoA			=	InfoPeriodoA,
	@ConMovs			=	InfoConMovs,
	@Desglosar			=	InfoDesglosar,
	@ReporteInf			=	InfoContResAnual,
	@ContMoneda			=	InfoContMoneda,
	@CentroCostos		=	InfoCentroCostos,
	@CentroCostos2		=	InfoCentroCostos2,
	@CentroCostos3		=	InfoCentroCostos3,
	@Proyecto			=	InfoProyecto,
	@UEN				=	InfoUEN,
	@Sucursal			=	InfoSucursal,
	@Agrupador			=	InfoAgrupadoCC,
	@Grupo				=	InfoGrupoLista,
	@Titulo				=	InfoTituloContResAnual,
	@Etiqueta			=	ISNULL(InfoEtiqueta, @Falso),
    @VerGraficaDetalle = ISNULL(VerGraficaDetalle,0)
	
    FROM RepParam
   WHERE Estacion = @EstacionTrabajo 

  SELECT @EmpresaNombre = Nombre FROM Empresa WHERE Empresa = @Empresa

  EXEC spContactoDireccionHorizontal @EstacionTrabajo, 'Empresa', @Empresa, @Empresa, 1, 1, 1, 1
  
  SELECT @Direccion2 = Direccion2,
         @Direccion3 = Direccion3,
         @Direccion4 = Direccion4 
    FROM ContactoDireccionHorizontal
   WHERE Estacion = @EstacionTrabajo    

  SELECT @Reporte = 'Del Ejercicio ' + CONVERT(varchar,@EjercicioD) + ' Al  ' + CONVERT(varchar,@EjercicioA) + ' En Moneda ' + ISNULL(@ContMoneda,'')


  DECLARE @VerContResultadosAnuales TABLE
  (
     Orden				int			NULL,
     ID					int			NULL,

     Clase				char(30)	COLLATE Database_Default NULL,
     SubClase			char(20)	COLLATE Database_Default NULL,

     Rama				char(20)	COLLATE Database_Default NULL, 
     RamaDesc			varchar(100)COLLATE Database_Default NULL,
     RamaEsAcreedora	bit		NOT NULL DEFAULT 0,

     Cuenta				char(20)	COLLATE Database_Default NULL,
     Descripcion		varchar(100)COLLATE Database_Default NULL,
     EsAcreedora		bit		NOT NULL DEFAULT 0,

     SubCuenta			varchar(50)	COLLATE Database_Default NULL,
     CentroCostos		varchar(100)COLLATE Database_Default NULL,

     Ejercicio1			int			NULL,
     Saldo1				money		NULL,
     Ingresos1			money		NULL,
     Porcentaje1		float		NULL,

     Ejercicio2			int			NULL,
     Saldo2				money		NULL,
     Ingresos2			money		NULL,
     Porcentaje2		float		NULL,

     Ejercicio3			int			NULL,
     Saldo3				money		NULL,
     Ingresos3			money		NULL,
     Porcentaje3		float		NULL,

     Ejercicio4			int			NULL,
     Saldo4				money		NULL,
     Ingresos4			money		NULL,
     Porcentaje4		float		NULL,

     Ejercicio5			int			NULL,
     Saldo5				money		NULL,
     Ingresos5			money		NULL,
     Porcentaje5		float		NULL,

	 Grupo				varchar(50)	NULL,
     SubGrupo			varchar(50)	NULL,
     SubSubGrupo		varchar(50)	NULL

  )


  DECLARE @ContResultadosAnuales TABLE
  (
     Orden				int			NULL,
     ID					int			NULL,

     Clase				char(30)	COLLATE Database_Default NULL,
     SubClase			char(20)	COLLATE Database_Default NULL,

     Rama				char(20)	COLLATE Database_Default NULL, 
     RamaDesc			varchar(100)COLLATE Database_Default NULL,
     RamaEsAcreedora	bit		NOT NULL DEFAULT 0,

     Cuenta				char(20)	COLLATE Database_Default NULL,
     Descripcion		varchar(100)COLLATE Database_Default NULL,
     EsAcreedora		bit		NOT NULL DEFAULT 0,

     SubCuenta			varchar(50)	COLLATE Database_Default NULL,
     CentroCostos		varchar(100)COLLATE Database_Default NULL,

     Ejercicio1			int			NULL,
     Saldo1				money		NULL,
     Ingresos1			money		NULL,
     Porcentaje1		float		NULL,

     Ejercicio2			int			NULL,
     Saldo2				money		NULL,
     Ingresos2			money		NULL,
     Porcentaje2		float		NULL,

     Ejercicio3			int			NULL,
     Saldo3				money		NULL,
     Ingresos3			money		NULL,
     Porcentaje3		float		NULL,

     Ejercicio4			int			NULL,
     Saldo4				money		NULL,
     Ingresos4			money		NULL,
     Porcentaje4		float		NULL,

     Ejercicio5			int			NULL,
     Saldo5				money		NULL,
     Ingresos5			money		NULL,
     Porcentaje5		float		NULL,

	 Grupo				varchar(50)	NULL,
     SubGrupo			varchar(50)	NULL,
     SubSubGrupo		varchar(50)	NULL,
     
	 Desglosar			varchar(5)	NULL,
     Orden1				int			NULL,

	 GraficaArgumento	varchar(100) COLLATE DATABASE_DEFAULT NULL,   
     GraficaValor		float		NULL,
     Grafica1			int			NULL DEFAULT 0,
     Grafica2			int			NULL DEFAULT 0,
     Titulo				varchar(100)NULL,
     Reporte			varchar(100)NULL,
     Direccion2			varchar(100)NULL,
     Direccion3			varchar(100)NULL,
     Direccion4			varchar(100)NULL,
     GraficaSerie		varchar(100) COLLATE DATABASE_DEFAULT NULL

  )


  SET ARITHABORT OFF
  SET ANSI_WARNINGS OFF  
  SET ARITHIGNORE ON

  INSERT INTO @VerContResultadosAnuales
  EXEC spVerContResultadosAnuales @Empresa, @EjercicioD, @EjercicioA, @PeriodoA, @ReporteInf, @ConMovs, @CentroCostos, @Sucursal, @Agrupador, @ContMoneda, @Grupo, @UEN, @Proyecto, @CentroCostos2, @CentroCostos3
  
  SET ARITHABORT ON
  SET ANSI_WARNINGS ON  
  SET ARITHIGNORE ON
  
  INSERT INTO @ContResultadosAnuales
  SELECT *, @Desglosar, NULL, NULL, NULL, 0, 0, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, NULL FROM @VerContResultadosAnuales
  
  SELECT @Contador = 0
  DECLARE crOrden CURSOR FAST_FORWARD FOR
   SELECT DISTINCT Clase, Orden
     FROM @VerContResultadosAnuales
    ORDER BY Orden, Clase

  OPEN crOrden
  FETCH NEXT FROM crOrden INTO @Clase, @Orden
  WHILE @@FETCH_STATUS = 0-- AND @Ok IS NULL
  BEGIN
  
    IF EXISTS(SELECT * FROM @ContResultadosAnuales WHERE Clase = @Clase AND Orden1 IS NULL) 
    BEGIN
      SELECT @Contador = @Contador + 1
      UPDATE @ContResultadosAnuales SET Orden1 = @Contador WHERE Clase = @Clase
    END
             
    FETCH NEXT FROM crOrden INTO @Clase, @Orden
  END
  CLOSE crOrden
  DEALLOCATE crOrden
  


  SELECT @Saldo1 = 0.00, @Saldo2 = 0.00, @Saldo3 = 0.00, @Saldo4 = 0.00, @Saldo5 = 0.00, @ClaseAnt = ''
  DECLARE crOrden CURSOR FAST_FORWARD FOR
   SELECT ID, Clase, Ejercicio1, Ejercicio2, Ejercicio3, Ejercicio4, Ejercicio5
     FROM @ContResultadosAnuales 
    GROUP BY ID, Clase, Orden, Ejercicio1, Ejercicio2, Ejercicio3, Ejercicio4, Ejercicio5
    ORDER BY ID, Ejercicio1, Ejercicio2, Ejercicio3, Ejercicio4, Ejercicio5

  OPEN crOrden
  FETCH NEXT FROM crOrden INTO @ID, @Clase, @Ejercicio1, @Ejercicio2, @Ejercicio3, @Ejercicio4, @Ejercicio5
  WHILE @@FETCH_STATUS = 0-- AND @Ok IS NULL
  BEGIN
    IF @ClaseAnt = '' SELECT @ClaseAnt = @Clase
    
    IF @ClaseAnt <> @Clase
    BEGIN
      INSERT INTO @ContResultadosAnuales(GraficaArgumento, GraficaValor, GraficaSerie,  Grafica1, Grafica2, Orden, Orden1, Titulo, Reporte, Direccion2, Direccion3, Direccion4, Desglosar)
        SELECT @ClaseAnt, @Saldo1, @Ejercicio1, 1, 0, 999999999, 999999999, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @Desglosar

      INSERT INTO @ContResultadosAnuales(GraficaArgumento, GraficaValor, GraficaSerie,  Grafica1, Grafica2, Orden, Orden1, Titulo, Reporte, Direccion2, Direccion3, Direccion4, Desglosar)
        SELECT @ClaseAnt, @Saldo2, @Ejercicio2, 1, 0, 999999999, 999999999, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @Desglosar

      INSERT INTO @ContResultadosAnuales(GraficaArgumento, GraficaValor, GraficaSerie,  Grafica1, Grafica2, Orden, Orden1, Titulo, Reporte, Direccion2, Direccion3, Direccion4, Desglosar)
        SELECT @ClaseAnt, @Saldo3, @Ejercicio3, 1, 0, 999999999, 999999999, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @Desglosar

      INSERT INTO @ContResultadosAnuales(GraficaArgumento, GraficaValor, GraficaSerie,  Grafica1, Grafica2, Orden, Orden1, Titulo, Reporte, Direccion2, Direccion3, Direccion4, Desglosar)
        SELECT @ClaseAnt, @Saldo4, @Ejercicio4, 1, 0, 999999999, 999999999, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @Desglosar

      INSERT INTO @ContResultadosAnuales(GraficaArgumento, GraficaValor, GraficaSerie,  Grafica1, Grafica2, Orden, Orden1, Titulo, Reporte, Direccion2, Direccion3, Direccion4, Desglosar)
        SELECT @ClaseAnt, @Saldo5, @Ejercicio5, 1, 0, 999999999, 999999999, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @Desglosar
    END
   
    SELECT @Saldo1 = @Saldo1 - ISNULL(Saldo1,0.00),
           @Saldo2 = @Saldo2 - ISNULL(Saldo2,0.00),
           @Saldo3 = @Saldo3 - ISNULL(Saldo3,0.00),
           @Saldo4 = @Saldo4 - ISNULL(Saldo4,0.00),
           @Saldo5 = @Saldo5 - ISNULL(Saldo5,0.00)
      FROM @ContResultadosAnuales
     WHERE ID = @ID

    SELECT @ClaseAnt = @Clase
    
    FETCH NEXT FROM crOrden INTO @ID, @Clase, @Ejercicio1, @Ejercicio2, @Ejercicio3, @Ejercicio4, @Ejercicio5
  END

  INSERT INTO @ContResultadosAnuales(GraficaArgumento, GraficaValor, GraficaSerie,  Grafica1, Grafica2, Orden, Orden1, Titulo, Reporte, Direccion2, Direccion3, Direccion4, Desglosar)
    SELECT @ClaseAnt, @Saldo1, @Ejercicio1, 1, 0, 999999999, 999999999, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @Desglosar

  INSERT INTO @ContResultadosAnuales(GraficaArgumento, GraficaValor, GraficaSerie,  Grafica1, Grafica2, Orden, Orden1, Titulo, Reporte, Direccion2, Direccion3, Direccion4, Desglosar)
    SELECT @ClaseAnt, @Saldo2, @Ejercicio2, 1, 0, 999999999, 999999999, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @Desglosar

  INSERT INTO @ContResultadosAnuales(GraficaArgumento, GraficaValor, GraficaSerie,  Grafica1, Grafica2, Orden, Orden1, Titulo, Reporte, Direccion2, Direccion3, Direccion4, Desglosar)
    SELECT @ClaseAnt, @Saldo3, @Ejercicio3, 1, 0, 999999999, 999999999, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @Desglosar

  INSERT INTO @ContResultadosAnuales(GraficaArgumento, GraficaValor, GraficaSerie,  Grafica1, Grafica2, Orden, Orden1, Titulo, Reporte, Direccion2, Direccion3, Direccion4, Desglosar)
    SELECT @ClaseAnt, @Saldo4, @Ejercicio4, 1, 0, 999999999, 999999999, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @Desglosar

  INSERT INTO @ContResultadosAnuales(GraficaArgumento, GraficaValor, GraficaSerie,  Grafica1, Grafica2, Orden, Orden1, Titulo, Reporte, Direccion2, Direccion3, Direccion4, Desglosar)
    SELECT @ClaseAnt, @Saldo5, @Ejercicio5, 1, 0, 999999999, 999999999, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @Desglosar

  CLOSE crOrden
  DEALLOCATE crOrden
  
    UPDATE @ContResultadosAnuales 
     SET Saldo1 = 0.00
   WHERE Saldo1 IS NULL

  UPDATE @ContResultadosAnuales 
     SET Porcentaje1 = 0.00
   WHERE Porcentaje1 IS NULL

    UPDATE @ContResultadosAnuales 
     SET Saldo2 = 0.00
   WHERE Saldo2 IS NULL

  UPDATE @ContResultadosAnuales 
     SET Porcentaje2 = 0.00
   WHERE Porcentaje2 IS NULL

    UPDATE @ContResultadosAnuales 
     SET Saldo3 = 0.00
   WHERE Saldo3 IS NULL

  UPDATE @ContResultadosAnuales 
     SET Porcentaje3 = 0.00
   WHERE Porcentaje3 IS NULL

    UPDATE @ContResultadosAnuales 
     SET Saldo4 = 0.00
   WHERE Saldo4 IS NULL

  UPDATE @ContResultadosAnuales 
     SET Porcentaje4 = 0.00
   WHERE Porcentaje4 IS NULL

    UPDATE @ContResultadosAnuales 
     SET Saldo5 = 0.00
   WHERE Saldo5 IS NULL

  UPDATE @ContResultadosAnuales 
     SET Porcentaje5 = 0.00
   WHERE Porcentaje5 IS NULL

  
  SELECT *, @Etiqueta as Etiqueta, @VerGraficaDetalle as VerGraficaDetalle FROM @ContResultadosAnuales

END
GO

--EXEC spInformeContResultadosAnuales 1
--go



/******************************* spInformemis_spUtilidadAgentes *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spInformemis_spUtilidadAgentes') and type = 'P') drop procedure dbo.spInformemis_spUtilidadAgentes
GO             
CREATE PROCEDURE spInformemis_spUtilidadAgentes
		@EstacionTrabajo		int

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  	@Empresa			varchar	(5),
    @Agente				varchar	(30),
    @Nombre				varchar	(100),
    @Contador			int,
    @Orden				int,
    @Utilidad			float,
    @Venta				float,
    @Costo				float,
	@EmpresaNombre		varchar	(100),
	@Titulo				varchar	(100),
	@Reporte			varchar	(200),
	@Direccion2			varchar	(100),
	@Direccion3			varchar	(100),
	@Direccion4			varchar	(100),
	@Desglosar			varchar	(50),
	@FechaD				datetime,
	@FechaA				datetime,
	@AgenteD			varchar	(30),
	@AgenteA			varchar	(30),
	@ContMoneda			varchar	(30),
	@Graficar			int,
	@GraficarFecha		int,
	@GraficarTipo		varchar(30),
	@Etiqueta			bit,
	@GraficarCantidad	int,
	@Verdadero			bit,
	@Falso				bit,
    @VerGraficaDetalle		bit


  SELECT @Verdadero = 1, @Falso = 0
  SELECT
    @Empresa		=	InfoEmpresa,
	@FechaD			=	InfoFechaD,
	@FechaA			=	InfoFechaA,
	@AgenteD		=	InfoAgenteD,
	@AgenteA		=	InfoAgenteA,
	@Desglosar		=	InfoDesglosar,
	@Titulo			=	RepTitulo,
	@GraficarTipo	= ISNULL(InformeGraficarTipo,  '(Todos)'),
	@Etiqueta		= ISNULL(InfoEtiqueta, @Falso),
	@GraficarCantidad = ISNULL(InformeGraficarCantidad, 5),
    @VerGraficaDetalle = ISNULL(VerGraficaDetalle,0)
	
    FROM RepParam
   WHERE Estacion = @EstacionTrabajo 


  SELECT @ContMoneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa
  
  SELECT @EmpresaNombre = Nombre FROM Empresa WHERE Empresa = @Empresa

  EXEC spContactoDireccionHorizontal @EstacionTrabajo, 'Empresa', @Empresa, @Empresa, 1, 1, 1, 1
  
  SELECT @Direccion2 = Direccion2,
         @Direccion3 = Direccion3,
         @Direccion4 = Direccion4 
    FROM ContactoDireccionHorizontal
   WHERE Estacion = @EstacionTrabajo    

  SELECT @Reporte = 'Del Agente  ' + @AgenteD + '  Al Agente  ' + @AgenteA + '  En ' + ISNULL(@ContMoneda,'')  
  
  DECLARE @Vermis_spUtilidadAgentes TABLE
  (
     Agente		char(10)	COLLATE Database_Default NULL,
     Nombre		varchar(100)	COLLATE Database_Default NULL,
     Mov		char(20)	COLLATE Database_Default NULL,
     MovID		varchar(20)	COLLATE Database_Default NULL,
     DescuentoGlobal	float(8)	NULL,
     CantidadNeta 	float(8)	NULL,
     ImporteBruto	money		NULL,
     ImporteNeto	money		NULL,
     CostoNeto		money		NULL,
     ComisionNeta	money		NULL,
     Utilidad		money		NULL,
     UtilidadPor	float(8)	NULL,
     DescuentoGlobalD	float(8)	NULL,
     CantidadNetaD 	float(8)	NULL,
     ImporteBrutoD	money		NULL,
     ImporteNetoD	money		NULL,
     CostoNetoD		money		NULL,
     ComisionNetaD	money		NULL,
     UtilidadD		money		NULL,
     UtilidadPorD	float(8)	NULL
  )

  


  DECLARE @mis_spUtilidadAgentes TABLE
  (
     Agente		char(10)	COLLATE Database_Default NULL,
     Nombre		varchar(100)	COLLATE Database_Default NULL,
     Mov		char(20)	COLLATE Database_Default NULL,
     MovID		varchar(20)	COLLATE Database_Default NULL,
     DescuentoGlobal	float(8)	NULL,
     CantidadNeta 	float(8)	NULL,
     ImporteBruto	money		NULL,
     ImporteNeto	money		NULL,
     CostoNeto		money		NULL,
     ComisionNeta	money		NULL,
     Utilidad		money		NULL,
     UtilidadPor	float(8)	NULL,
     DescuentoGlobalD	float(8)	NULL,
     CantidadNetaD 	float(8)	NULL,
     ImporteBrutoD	money		NULL,
     ImporteNetoD	money		NULL,
     CostoNetoD		money		NULL,
     ComisionNetaD	money		NULL,
     UtilidadD		money		NULL,
     UtilidadPorD	float(8)	NULL,
     
     Porcentaje		float		NULL,
     PorcentajeD	float		NULL,
	 Desglosar			varchar(5)	NULL,
	 Desglosar2			varchar(5)	NULL,
     FechaD				datetime	NULL,
     FechaA				datetime	NULL,
     Orden1				int			NULL,
     

	 GraficaArgumento	varchar(100) COLLATE DATABASE_DEFAULT NULL,   
     GraficaValor		float		NULL,
     Grafica1			int			NULL DEFAULT 0,
     Grafica2			int			NULL DEFAULT 0,
     Titulo				varchar(100)NULL,
     Reporte			varchar(200)NULL,
     Direccion2			varchar(100)NULL,
     Direccion3			varchar(100)NULL,
     Direccion4			varchar(100)NULL,
     GraficaSerie		varchar(100) COLLATE DATABASE_DEFAULT NULL,
     EmpresaNombre		varchar(100) COLLATE DATABASE_DEFAULT NULL

  )



--'TMS', '01', 'Z', '01/03/1900', '31/03/2011', @Desglosar--TRANSMARES

  INSERT INTO @Vermis_spUtilidadAgentes
  EXEC mis_spUtilidadAgentes @Empresa, @AgenteD, @AgenteA, @FechaD, @FechaA, @Desglosar
 
  
  INSERT INTO @mis_spUtilidadAgentes
  SELECT *, NULL, NULL, @Desglosar, @Desglosar, @FechaD, @FechaA, NULL, NULL, NULL, 0, 0, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, NULL, @EmpresaNombre FROM @Vermis_spUtilidadAgentes

  
  SELECT @Contador = 0
  DECLARE crOrden CURSOR FAST_FORWARD FOR
   SELECT Agente
     FROM @mis_spUtilidadAgentes
    ORDER BY Utilidad DESC, Agente, UtilidadD DESC

  OPEN crOrden
  FETCH NEXT FROM crOrden INTO @Agente
  WHILE @@FETCH_STATUS = 0-- AND @Ok IS NULL
  BEGIN
  
    IF EXISTS(SELECT * FROM @mis_spUtilidadAgentes WHERE Agente = @Agente AND Orden1 IS NULL) 
    BEGIN
      SELECT @Contador = @Contador + 1
      UPDATE @mis_spUtilidadAgentes SET Orden1 = @Contador WHERE Agente = @Agente
    END

    FETCH NEXT FROM crOrden INTO @Agente
  END
  CLOSE crOrden
  DEALLOCATE crOrden


  SELECT @Utilidad = 0.00
  DECLARE crGrafica CURSOR FAST_FORWARD FOR
   SELECT Agente, Orden1, CASE WHEN @Desglosar = 'No' THEN SUM(Utilidad) ELSE SUM(UtilidadD) END, SUBSTRING(Nombre, 1, 30), CASE WHEN @Desglosar = 'No' THEN SUM(ImporteNeto) ELSE SUM(ImporteNetoD) END,CASE WHEN @Desglosar = 'No' THEN SUM(CostoNeto) ELSE SUM(CostoNetoD) END
     FROM @mis_spUtilidadAgentes 
    GROUP BY Agente, Nombre, Orden1
    ORDER BY Orden1, Agente

  OPEN crGrafica
  FETCH NEXT FROM crGrafica INTO @Agente, @Orden, @Utilidad, @Nombre, @Venta, @Costo
  WHILE @@FETCH_STATUS = 0-- AND @Ok IS NULL
  BEGIN
    
    INSERT INTO @mis_spUtilidadAgentes(GraficaArgumento, GraficaValor, Grafica1, Grafica2, Orden1, GraficaSerie, Titulo, Reporte, Direccion2, Direccion3, Direccion4, EmpresaNombre, Desglosar, Desglosar2, FechaD, FechaA)
      SELECT 'Costo', @Costo, 1, 0, 0, @Nombre, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @EmpresaNombre, '', @Desglosar, @FechaD, @FechaA

    INSERT INTO @mis_spUtilidadAgentes(GraficaArgumento, GraficaValor, Grafica1, Grafica2, Orden1, GraficaSerie, Titulo, Reporte, Direccion2, Direccion3, Direccion4, EmpresaNombre, Desglosar, Desglosar2, FechaD, FechaA)
      SELECT 'Importe Venta', @Venta, 1, 0, 0, @Nombre, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @EmpresaNombre, '', @Desglosar, @FechaD, @FechaA

    INSERT INTO @mis_spUtilidadAgentes(GraficaArgumento, GraficaValor, Grafica1, Grafica2, Orden1, GraficaSerie, Titulo, Reporte, Direccion2, Direccion3, Direccion4, EmpresaNombre, Desglosar, Desglosar2, FechaD, FechaA)
      SELECT 'Utilidad', @Utilidad, 1, 0, 0, @Nombre, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @EmpresaNombre, '', @Desglosar, @FechaD, @FechaA
    
    FETCH NEXT FROM crGrafica INTO @Agente, @Orden, @Utilidad, @Nombre, @Venta, @Costo
  END
  
  CLOSE crGrafica
  DEALLOCATE crGrafica

  SELECT @Graficar = NULL
  SELECT @Graficar = ISNULL(COUNT(DISTINCT GraficaSerie),0)
    FROM @mis_spUtilidadAgentes
   WHERE Grafica1 = 1
       
  IF @GraficarTipo = 'Mas Sobresalientes' AND @Graficar > @GraficarCantidad
    DELETE @mis_spUtilidadAgentes 
     WHERE GraficaSerie NOT IN(
    SELECT  TOP (@GraficarCantidad) GraficaSerie
      FROM
      (
      SELECT
          'GraficaSerie'   = GraficaSerie,
          'GraficaValor'   = SUM(ISNULL(GraficaValor,0.00))
     
        FROM @mis_spUtilidadAgentes
       WHERE Grafica1 = 1
        GROUP BY GraficaSerie
      ) AS x
     GROUP BY x.GraficaSerie
     ORDER BY SUM(ISNULL(x.GraficaValor,0.00))DESC)
       AND Grafica1 = 1

  IF @GraficarTipo = 'Menos Sobresalientes' AND @Graficar > @GraficarCantidad
    DELETE @mis_spUtilidadAgentes 
     WHERE GraficaSerie NOT IN(
    SELECT  TOP (@GraficarCantidad) GraficaSerie
      FROM
      (
      SELECT
          'GraficaSerie'   = GraficaSerie,
          'GraficaValor'   = SUM(ISNULL(GraficaValor,0.00))
     
        FROM @mis_spUtilidadAgentes
       WHERE Grafica1 = 1
        GROUP BY GraficaSerie
      ) AS x
     GROUP BY x.GraficaSerie
     ORDER BY SUM(ISNULL(x.GraficaValor,0.00))ASC)
       AND Grafica1 = 1

  
  SELECT *, @Etiqueta as Etiqueta, @VerGraficaDetalle as VerGraficaDetalle FROM @mis_spUtilidadAgentes
END
GO

--EXEC spInformemis_spUtilidadAgentes 1
--go


/******************************* spInformemis_spUtilidadAlmacen *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spInformemis_spUtilidadAlmacen') and type = 'P') drop procedure dbo.spInformemis_spUtilidadAlmacen
GO             
CREATE PROCEDURE spInformemis_spUtilidadAlmacen
		@EstacionTrabajo		int

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  	@Empresa			varchar	(5),
    @Almacen				varchar	(30),
    @Nombre				varchar	(100),
    @Contador			int,
    @Orden				int,
	@EmpresaNombre		varchar	(100),
	@Titulo				varchar	(100),
	@Reporte			varchar	(200),
	@Direccion2			varchar	(100),
	@Direccion3			varchar	(100),
	@Direccion4			varchar	(100),
	@Desglosar			varchar	(50),
	@FechaD				datetime,
	@FechaA				datetime,
	@AlmacenD			varchar	(30),
	@AlmacenA			varchar	(30),
	@ContMoneda			varchar	(30),
	@Venta				float,
	@Costo				float,
	@Utilidad			float,
	@Graficar			int,
	@GraficarFecha		int,
	@GraficarTipo		varchar(30),
	@Etiqueta			bit,
	@GraficarCantidad	int,
	@Verdadero			bit,
	@Falso				bit,
    @VerGraficaDetalle		bit


  SELECT @Verdadero = 1, @Falso = 0
  SELECT
    @Empresa		=	InfoEmpresa,
	@FechaD			=	InfoFechaD,
	@FechaA			=	InfoFechaA,
	@Almacen		=	CASE WHEN InfoAlmacen IN ('(Todos)', '') THEN 'NULL' ELSE ISNULL(InfoAlmacen,'NULL') END,
	@Desglosar		=	InfoDesglosar,
	@Titulo			=	RepTitulo,
	@GraficarTipo	= ISNULL(InformeGraficarTipo,  '(Todos)'),
	@Etiqueta		= ISNULL(InfoEtiqueta, @Falso),
	@GraficarCantidad = ISNULL(InformeGraficarCantidad, 5),
    @VerGraficaDetalle = ISNULL(VerGraficaDetalle,0)
	
    FROM RepParam
   WHERE Estacion = @EstacionTrabajo
     
    
  SELECT @ContMoneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa
  
  SELECT @EmpresaNombre = Nombre FROM Empresa WHERE Empresa = @Empresa

  EXEC spContactoDireccionHorizontal @EstacionTrabajo, 'Empresa', @Empresa, @Empresa, 1, 1, 1, 1
  
  SELECT @Direccion2 = Direccion2,
         @Direccion3 = Direccion3,
         @Direccion4 = Direccion4 
    FROM ContactoDireccionHorizontal
   WHERE Estacion = @EstacionTrabajo    

  SELECT @Reporte = 'Del Almacen  ' + @AlmacenD + '  Al Almacen  ' + @AlmacenA + '  En ' + ISNULL(@ContMoneda,'')  
  
  DECLARE @Vermis_spUtilidadAlmacen TABLE
  (
     Almacen		char(10)	COLLATE Database_Default NULL,
     Mov		char(20)	COLLATE Database_Default NULL,
     MovID		varchar(20)	COLLATE Database_Default NULL,
     DescuentoGlobal	float(8)	NULL,
     CantidadNeta 	float(8)	NULL,
     ImporteBruto	money		NULL,
     ImporteNeto	money		NULL,
     CostoNeto		money		NULL,
     ComisionNeta	money		NULL,
     Utilidad		money		NULL,
     UtilidadPor	float(8)	NULL,
     DescuentoGlobalD	float(8)	NULL,
     CantidadNetaD 	float(8)	NULL,
     ImporteBrutoD	money		NULL,
     ImporteNetoD	money		NULL,
     CostoNetoD		money		NULL,
     ComisionNetaD	money		NULL,
     UtilidadD		money		NULL,
     UtilidadPorD	float(8)	NULL
  )

  


  DECLARE @mis_spUtilidadAlmacen TABLE
  (
     Almacen		char(10)	COLLATE Database_Default NULL,
     Mov		char(20)	COLLATE Database_Default NULL,
     MovID		varchar(20)	COLLATE Database_Default NULL,
     DescuentoGlobal	float(8)	NULL,
     CantidadNeta 	float(8)	NULL,
     ImporteBruto	money		NULL,
     ImporteNeto	money		NULL,
     CostoNeto		money		NULL,
     ComisionNeta	money		NULL,
     Utilidad		money		NULL,
     UtilidadPor	float(8)	NULL,
     DescuentoGlobalD	float(8)	NULL,
     CantidadNetaD 	float(8)	NULL,
     ImporteBrutoD	money		NULL,
     ImporteNetoD	money		NULL,
     CostoNetoD		money		NULL,
     ComisionNetaD	money		NULL,
     UtilidadD		money		NULL,
     UtilidadPorD	float(8)	NULL,

	 Desglosar			varchar(5)	NULL,
	 Desglosar2			varchar(5)	NULL,
     FechaD				datetime	NULL,
     FechaA				datetime	NULL,
     Orden1				int			NULL,
     

	 GraficaArgumento	varchar(100) COLLATE DATABASE_DEFAULT NULL,   
     GraficaValor		float		NULL,
     Grafica1			int			NULL DEFAULT 0,
     Grafica2			int			NULL DEFAULT 0,
     Titulo				varchar(100)NULL,
     Reporte			varchar(200)NULL,
     Direccion2			varchar(100)NULL,
     Direccion3			varchar(100)NULL,
     Direccion4			varchar(100)NULL,
     GraficaSerie		varchar(100) COLLATE DATABASE_DEFAULT NULL,
     EmpresaNombre		varchar(100) COLLATE DATABASE_DEFAULT NULL,
     Nombre				varchar(100) COLLATE DATABASE_DEFAULT NULL

  )

--EXEC mis_spUtilidadAlmacen  'TMS', '01/03/2000', '31/03/2011', 'NULL', 'No'--TRANSMARES
--select @Empresa, @FechaD2, @FechaA2, @Almacen, @Desglosar

  INSERT INTO @Vermis_spUtilidadAlmacen
  EXEC mis_spUtilidadAlmacen @Empresa, @FechaD, @FechaA, @Almacen, @Desglosar
 
  
  INSERT INTO @mis_spUtilidadAlmacen
  SELECT *, @Desglosar, @Desglosar, @FechaD, @FechaA, NULL, NULL, NULL, 0, 0, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, NULL, @EmpresaNombre, NULL FROM @Vermis_spUtilidadAlmacen


  SELECT @Contador = 0
  DECLARE crOrden CURSOR FAST_FORWARD FOR
   SELECT Almacen
     FROM @mis_spUtilidadAlmacen
    ORDER BY Utilidad DESC, Almacen, UtilidadD DESC

  OPEN crOrden
  FETCH NEXT FROM crOrden INTO @Almacen
  WHILE @@FETCH_STATUS = 0-- AND @Ok IS NULL
  BEGIN
  
    IF EXISTS(SELECT * FROM @mis_spUtilidadAlmacen WHERE Almacen = @Almacen AND Orden1 IS NULL) 
    BEGIN
      SELECT @Nombre = Nombre FROM Alm WHERE Almacen = @Almacen
      SELECT @Contador = @Contador + 1
      UPDATE @mis_spUtilidadAlmacen SET Orden1 = @Contador, Nombre = @Nombre WHERE Almacen = @Almacen
    END

    FETCH NEXT FROM crOrden INTO @Almacen
  END
  CLOSE crOrden
  DEALLOCATE crOrden


  SELECT @Utilidad = 0.00, @Venta  = 0.00, @Costo  = 0.00
  DECLARE crGrafica CURSOR FAST_FORWARD FOR
   SELECT Almacen, Orden1, CASE WHEN @Desglosar = 'No' THEN SUM(Utilidad) ELSE SUM(UtilidadD) END, SUBSTRING(Nombre, 1, 30), CASE WHEN @Desglosar = 'No' THEN SUM(ImporteNeto) ELSE SUM(ImporteNetoD) END,CASE WHEN @Desglosar = 'No' THEN SUM(CostoNeto) ELSE SUM(CostoNetoD) END
     FROM @mis_spUtilidadAlmacen 
    GROUP BY Almacen, Nombre, Orden1
    ORDER BY Orden1, Almacen

  OPEN crGrafica
  FETCH NEXT FROM crGrafica INTO @Almacen, @Orden, @Utilidad, @Nombre, @Venta, @Costo
  WHILE @@FETCH_STATUS = 0-- AND @Ok IS NULL
  BEGIN

    INSERT INTO @mis_spUtilidadAlmacen(GraficaArgumento, GraficaValor, Grafica1, Grafica2, Orden1, GraficaSerie, Titulo, Reporte, Direccion2, Direccion3, Direccion4, EmpresaNombre, Desglosar, Desglosar2, FechaD, FechaA)
      SELECT 'Costo', @Costo, 1, 0, 0, @Nombre, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @EmpresaNombre, '', @Desglosar, @FechaD, @FechaA
    
    INSERT INTO @mis_spUtilidadAlmacen(GraficaArgumento, GraficaValor, Grafica1, Grafica2, Orden1, GraficaSerie, Titulo, Reporte, Direccion2, Direccion3, Direccion4, EmpresaNombre, Desglosar, Desglosar2, FechaD, FechaA)
      SELECT 'Importe Venta', @Venta, 1, 0, 0, @Nombre, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @EmpresaNombre, '', @Desglosar, @FechaD, @FechaA

    INSERT INTO @mis_spUtilidadAlmacen(GraficaArgumento, GraficaValor, Grafica1, Grafica2, Orden1, GraficaSerie, Titulo, Reporte, Direccion2, Direccion3, Direccion4, EmpresaNombre, Desglosar, Desglosar2, FechaD, FechaA)
      SELECT 'Utilidad', @Utilidad, 1, 0, 0, @Nombre, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @EmpresaNombre, '', @Desglosar, @FechaD, @FechaA
    
    FETCH NEXT FROM crGrafica INTO @Almacen, @Orden, @Utilidad, @Nombre, @Venta, @Costo
  END
  
  CLOSE crGrafica
  DEALLOCATE crGrafica
  

  SELECT @Graficar = NULL
  SELECT @Graficar = ISNULL(COUNT(DISTINCT GraficaSerie),0)
    FROM @mis_spUtilidadAlmacen
   WHERE Grafica1 = 1
       
  IF @GraficarTipo = 'Mas Sobresalientes' AND @Graficar > @GraficarCantidad
    DELETE @mis_spUtilidadAlmacen 
     WHERE GraficaSerie NOT IN(
    SELECT  TOP (@GraficarCantidad) GraficaSerie
      FROM
      (
      SELECT
          'GraficaSerie'   = GraficaSerie,
          'GraficaValor'   = SUM(ISNULL(GraficaValor,0.00))
     
        FROM @mis_spUtilidadAlmacen
       WHERE Grafica1 = 1
        GROUP BY GraficaSerie
      ) AS x
     GROUP BY x.GraficaSerie
     ORDER BY SUM(ISNULL(x.GraficaValor,0.00))DESC)
       AND Grafica1 = 1

  IF @GraficarTipo = 'Menos Sobresalientes' AND @Graficar > @GraficarCantidad
    DELETE @mis_spUtilidadAlmacen 
     WHERE GraficaSerie NOT IN(
    SELECT  TOP (@GraficarCantidad) GraficaSerie
      FROM
      (
      SELECT
          'GraficaSerie'   = GraficaSerie,
          'GraficaValor'   = SUM(ISNULL(GraficaValor,0.00))
     
        FROM @mis_spUtilidadAlmacen
       WHERE Grafica1 = 1
        GROUP BY GraficaSerie
      ) AS x
     GROUP BY x.GraficaSerie
     ORDER BY SUM(ISNULL(x.GraficaValor,0.00))ASC)
       AND Grafica1 = 1


  SELECT *, @Etiqueta as Etiqueta, @VerGraficaDetalle as VerGraficaDetalle FROM @mis_spUtilidadAlmacen
END
GO

--EXEC spInformemis_spUtilidadAlmacen 1
--go


/******************************* spInformemis_spUtilidadArticulo *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spInformemis_spUtilidadArticulo') and type = 'P') drop procedure dbo.spInformemis_spUtilidadArticulo
GO             
CREATE PROCEDURE spInformemis_spUtilidadArticulo
		@EstacionTrabajo		int

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  	@Empresa			varchar	(5),
    @Articulo				varchar	(30),
    @Nombre				varchar	(100),
    @Contador			int,
    @Orden				int,
	@EmpresaNombre		varchar	(100),
	@Titulo				varchar	(100),
	@Reporte			varchar	(200),
	@Direccion2			varchar	(100),
	@Direccion3			varchar	(100),
	@Direccion4			varchar	(100),
	@Desglosar			varchar	(50),
	@FechaD				datetime,
	@FechaA				datetime,
	@ArticuloD			varchar	(30),
	@ArticuloA			varchar	(30),
	@ArtCat				varchar	(50),
	@ArtFam				varchar	(50),
	@ArtGrupo			varchar	(50),
	@ArtLinea			varchar	(50),
	@Fabricante			varchar	(50),	
	@ContMoneda			varchar	(30),
	@Venta				float,
	@Costo				float,
	@Utilidad			float,
	@Graficar			int,
	@GraficarFecha		int,
	@GraficarTipo		varchar(30),
	@Etiqueta			bit,
	@GraficarCantidad	int,
	@Verdadero			bit,
	@Falso				bit,
    @VerGraficaDetalle		bit


  SELECT @Verdadero = 1, @Falso = 0
  SELECT
    @Empresa		=	InfoEmpresa,
	@FechaD			=	InfoFechaD,
	@FechaA			=	InfoFechaA,
	@ArticuloD		=	InfoArticuloD,
	@ArticuloA		=	InfoArticuloA,
	@ArtCat			=	CASE WHEN InfoArtCat IN ('(Todos)', '(Todas)', '') THEN 'NULL' ELSE ISNULL(InfoArtCat,'NULL') END,
	@ArtFam			=	CASE WHEN InfoArtFam IN ('(Todos)', '(Todas)', '') THEN 'NULL' ELSE ISNULL(InfoArtFam,'NULL') END,
	@ArtGrupo		=	CASE WHEN InfoArtGrupo IN ('(Todos)', '(Todas)', '') THEN 'NULL' ELSE ISNULL(InfoArtGrupo,'NULL') END,
	@ArtLinea		=	CASE WHEN InfoArtLinea IN ('(Todos)', '(Todas)', '') THEN 'NULL' ELSE ISNULL(InfoArtLinea,'NULL') END,
	@Fabricante		=	CASE WHEN InfoFabricante IN ('(Todos)', '(Todas)', '') THEN 'NULL' ELSE ISNULL(InfoFabricante,'NULL') END,
	@Desglosar		=	InfoDesglosar,
	@Titulo			=	RepTitulo,
	@GraficarTipo	= ISNULL(InformeGraficarTipo,  '(Todos)'),
	@Etiqueta		= ISNULL(InfoEtiqueta, @Falso),
	@GraficarCantidad = ISNULL(InformeGraficarCantidad, 5),
    @VerGraficaDetalle = ISNULL(VerGraficaDetalle,0)
	
    FROM RepParam
   WHERE Estacion = @EstacionTrabajo
     
    
  SELECT @ContMoneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa
  
  SELECT @EmpresaNombre = Nombre FROM Empresa WHERE Empresa = @Empresa

  EXEC spContactoDireccionHorizontal @EstacionTrabajo, 'Empresa', @Empresa, @Empresa, 1, 1, 1, 1
  
  SELECT @Direccion2 = Direccion2,
         @Direccion3 = Direccion3,
         @Direccion4 = Direccion4 
    FROM ContactoDireccionHorizontal
   WHERE Estacion = @EstacionTrabajo    

  SELECT @Reporte = 'Del Articulo  ' + @ArticuloD + '  Al Articulo  ' + @ArticuloA + '  En ' + ISNULL(@ContMoneda,'')  
  
  DECLARE @Vermis_spUtilidadArticulo TABLE
  (
     Articulo		char(20)	COLLATE Database_Default NULL,
     Descripcion1	varchar(100)	COLLATE Database_Default NULL,
     Mov		char(20)	COLLATE Database_Default NULL,
     MovID		varchar(20)	COLLATE Database_Default NULL,
     DescuentoGlobal	float(8)	NULL,
     CantidadNeta 	float(8)	NULL,
     ImporteBruto	money		NULL,
     ImporteNeto	money		NULL,
     CostoNeto		money		NULL,
     ComisionNeta	money		NULL,
     Utilidad		money		NULL,
     UtilidadPor	float(8)	NULL,
     DescuentoGlobalD	float(8)	NULL,
     CantidadNetaD 	float(8)	NULL,
     ImporteBrutoD	money		NULL,
     ImporteNetoD	money		NULL,
     CostoNetoD		money		NULL,
     ComisionNetaD	money		NULL,
     UtilidadD		money		NULL,
     UtilidadPorD	float(8)	NULL
  )

  


  DECLARE @mis_spUtilidadArticulo TABLE
  (
     Articulo		char(20)	COLLATE Database_Default NULL,
     Descripcion1	varchar(100)	COLLATE Database_Default NULL,
     Mov		char(20)	COLLATE Database_Default NULL,
     MovID		varchar(20)	COLLATE Database_Default NULL,
     DescuentoGlobal	float(8)	NULL,
     CantidadNeta 	float(8)	NULL,
     ImporteBruto	money		NULL,
     ImporteNeto	money		NULL,
     CostoNeto		money		NULL,
     ComisionNeta	money		NULL,
     Utilidad		money		NULL,
     UtilidadPor	float(8)	NULL,
     DescuentoGlobalD	float(8)	NULL,
     CantidadNetaD 	float(8)	NULL,
     ImporteBrutoD	money		NULL,
     ImporteNetoD	money		NULL,
     CostoNetoD		money		NULL,
     ComisionNetaD	money		NULL,
     UtilidadD		money		NULL,
     UtilidadPorD	float(8)	NULL,

	 Desglosar			varchar(5)	NULL,
	 Desglosar2			varchar(5)	NULL,
     FechaD				datetime	NULL,
     FechaA				datetime	NULL,
     Orden1				int			NULL,
     

	 GraficaArgumento	varchar(100) COLLATE DATABASE_DEFAULT NULL,   
     GraficaValor		float		NULL,
     Grafica1			int			NULL DEFAULT 0,
     Grafica2			int			NULL DEFAULT 0,
     Titulo				varchar(100)NULL,
     Reporte			varchar(200)NULL,
     Direccion2			varchar(100)NULL,
     Direccion3			varchar(100)NULL,
     Direccion4			varchar(100)NULL,
     GraficaSerie		varchar(100) COLLATE DATABASE_DEFAULT NULL,
     EmpresaNombre		varchar(100) COLLATE DATABASE_DEFAULT NULL,
     Nombre				varchar(100) COLLATE DATABASE_DEFAULT NULL

  )


--  SELECT @Empresa, @ArticuloD, @ArticuloA, @ArtCat, @ArtFam, @ArtGrupo, @ArtLinea, @Fabricante, @FechaD, @FechaA, @Desglosar
-- select 'TMS', '0001', 'RMIL1', 'NULL', 'NULL', 'NULL', 'NULL', 'NULL', '01/03/2000', '31/03/2011', 'No'
  INSERT INTO @Vermis_spUtilidadArticulo
  EXEC mis_spUtilidadArticulos  @Empresa, @ArticuloD, @ArticuloA, @ArtCat, @ArtFam, @ArtGrupo, @ArtLinea, @Fabricante, @FechaD, @FechaA, @Desglosar
 
  
  INSERT INTO @mis_spUtilidadArticulo
  SELECT *, @Desglosar, @Desglosar, @FechaD, @FechaA, NULL, NULL, NULL, 0, 0, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, NULL, @EmpresaNombre, NULL FROM @Vermis_spUtilidadArticulo


  SELECT @Contador = 0
  DECLARE crOrden CURSOR FAST_FORWARD FOR
   SELECT Articulo
     FROM @mis_spUtilidadArticulo
    ORDER BY Utilidad DESC, Articulo, UtilidadD DESC

  OPEN crOrden
  FETCH NEXT FROM crOrden INTO @Articulo
  WHILE @@FETCH_STATUS = 0-- AND @Ok IS NULL
  BEGIN
  
    IF EXISTS(SELECT * FROM @mis_spUtilidadArticulo WHERE Articulo = @Articulo AND Orden1 IS NULL) 
    BEGIN
      SELECT @Nombre = Descripcion1 FROM Art WHERE Articulo = @Articulo
      SELECT @Contador = @Contador + 1
      UPDATE @mis_spUtilidadArticulo SET Orden1 = @Contador, Nombre = @Nombre WHERE Articulo = @Articulo
    END

    FETCH NEXT FROM crOrden INTO @Articulo
  END
  CLOSE crOrden
  DEALLOCATE crOrden


  SELECT @Utilidad = 0.00, @Venta  = 0.00, @Costo  = 0.00
  DECLARE crGrafica CURSOR FAST_FORWARD FOR
   SELECT Articulo, Orden1, CASE WHEN @Desglosar = 'No' THEN SUM(Utilidad) ELSE SUM(UtilidadD) END, SUBSTRING(Nombre, 1, 30), CASE WHEN @Desglosar = 'No' THEN SUM(ImporteNeto) ELSE SUM(ImporteNetoD) END,CASE WHEN @Desglosar = 'No' THEN SUM(CostoNeto) ELSE SUM(CostoNetoD) END
     FROM @mis_spUtilidadArticulo 
    GROUP BY Articulo, Nombre, Orden1
    ORDER BY Orden1, Articulo

  OPEN crGrafica
  FETCH NEXT FROM crGrafica INTO @Articulo, @Orden, @Utilidad, @Nombre, @Venta, @Costo
  WHILE @@FETCH_STATUS = 0-- AND @Ok IS NULL
  BEGIN

    INSERT INTO @mis_spUtilidadArticulo(GraficaArgumento, GraficaValor, Grafica1, Grafica2, Orden1, GraficaSerie, Titulo, Reporte, Direccion2, Direccion3, Direccion4, EmpresaNombre, Desglosar, Desglosar2, FechaD, FechaA)
      SELECT 'Costo', @Costo, 1, 0, 0, @Nombre, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @EmpresaNombre, '', @Desglosar, @FechaD, @FechaA
    
    INSERT INTO @mis_spUtilidadArticulo(GraficaArgumento, GraficaValor, Grafica1, Grafica2, Orden1, GraficaSerie, Titulo, Reporte, Direccion2, Direccion3, Direccion4, EmpresaNombre, Desglosar, Desglosar2, FechaD, FechaA)
      SELECT 'Importe Venta', @Venta, 1, 0, 0, @Nombre, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @EmpresaNombre, '', @Desglosar, @FechaD, @FechaA

    INSERT INTO @mis_spUtilidadArticulo(GraficaArgumento, GraficaValor, Grafica1, Grafica2, Orden1, GraficaSerie, Titulo, Reporte, Direccion2, Direccion3, Direccion4, EmpresaNombre, Desglosar, Desglosar2, FechaD, FechaA)
      SELECT 'Utilidad', @Utilidad, 1, 0, 0, @Nombre, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @EmpresaNombre, '', @Desglosar, @FechaD, @FechaA
    
    FETCH NEXT FROM crGrafica INTO @Articulo, @Orden, @Utilidad, @Nombre, @Venta, @Costo
  END
  
  CLOSE crGrafica
  DEALLOCATE crGrafica
  

  SELECT @Graficar = NULL
  SELECT @Graficar = ISNULL(COUNT(DISTINCT GraficaSerie),0)
    FROM @mis_spUtilidadArticulo
   WHERE Grafica1 = 1
       
  IF @GraficarTipo = 'Mas Sobresalientes' AND @Graficar > @GraficarCantidad
    DELETE @mis_spUtilidadArticulo 
     WHERE GraficaSerie NOT IN(
    SELECT  TOP (@GraficarCantidad) GraficaSerie
      FROM
      (
      SELECT
          'GraficaSerie'   = GraficaSerie,
          'GraficaValor'   = SUM(ISNULL(GraficaValor,0.00))
     
        FROM @mis_spUtilidadArticulo
       WHERE Grafica1 = 1
        GROUP BY GraficaSerie
      ) AS x
     GROUP BY x.GraficaSerie
     ORDER BY SUM(ISNULL(x.GraficaValor,0.00))DESC)
       AND Grafica1 = 1

  IF @GraficarTipo = 'Menos Sobresalientes' AND @Graficar > @GraficarCantidad
    DELETE @mis_spUtilidadArticulo 
     WHERE GraficaSerie NOT IN(
    SELECT  TOP (@GraficarCantidad) GraficaSerie
      FROM
      (
      SELECT
          'GraficaSerie'   = GraficaSerie,
          'GraficaValor'   = SUM(ISNULL(GraficaValor,0.00))
     
        FROM @mis_spUtilidadArticulo
       WHERE Grafica1 = 1
        GROUP BY GraficaSerie
      ) AS x
     GROUP BY x.GraficaSerie
     ORDER BY SUM(ISNULL(x.GraficaValor,0.00))ASC)
       AND Grafica1 = 1


  SELECT *, @Etiqueta as Etiqueta, @VerGraficaDetalle as VerGraficaDetalle FROM @mis_spUtilidadArticulo
END
GO

--EXEC spInformemis_spUtilidadArticulo 1
--go


/******************************* spInformemis_spUtilidadClientes *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spInformemis_spUtilidadClientes') and type = 'P') drop procedure dbo.spInformemis_spUtilidadClientes
GO             
CREATE PROCEDURE spInformemis_spUtilidadClientes
		@EstacionTrabajo		int

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  	@Empresa			varchar	(5),
    @Cliente			varchar	(30),
    @Nombre				varchar	(100),
    @Contador			int,
    @Orden				int,
	@EmpresaNombre		varchar	(100),
	@Titulo				varchar	(100),
	@Reporte			varchar	(200),
	@Direccion2			varchar	(100),
	@Direccion3			varchar	(100),
	@Direccion4			varchar	(100),
	@Desglosar			varchar	(50),
	@FechaD				datetime,
	@FechaA				datetime,
	@ClienteD			varchar	(30),
	@ClienteA			varchar	(30),
	@CteCat				varchar	(50),
	@CteFam				varchar	(50),
	@CteGrupo			varchar	(50),
	@ContMoneda			varchar	(30),
	@Venta				float,
	@Costo				float,
	@Utilidad			float,
	@Graficar			int,
	@GraficarFecha		int,
	@GraficarTipo		varchar(30),
	@Etiqueta			bit,
	@GraficarCantidad	int,
	@Verdadero			bit,
	@Falso				bit,
    @VerGraficaDetalle		bit


  SELECT @Verdadero = 1, @Falso = 0
  SELECT
    @Empresa		=	InfoEmpresa,
	@FechaD			=	InfoFechaD,
	@FechaA			=	InfoFechaA,
	@ClienteD		=	InfoClienteD,
	@ClienteA		=	InfoClienteA,
	@CteCat			=	CASE WHEN InfoCteCat IN ('(Todos)', '(Todas)', '') THEN 'NULL' ELSE ISNULL(InfoCteCat,'NULL') END,
	@CteFam			=	CASE WHEN InfoCteFam IN ('(Todos)', '(Todas)', '') THEN 'NULL' ELSE ISNULL(InfoCteFam,'NULL') END,
	@CteGrupo		=	CASE WHEN InfoCteGrupo IN ('(Todos)', '(Todas)', '') THEN 'NULL' ELSE ISNULL(InfoCteGrupo,'NULL') END,
	@Desglosar		=	InfoDesglosar,
	@Titulo			=	RepTitulo,
	@GraficarTipo	= ISNULL(InformeGraficarTipo,  '(Todos)'),
	@Etiqueta		= ISNULL(InfoEtiqueta, @Falso),
	@GraficarCantidad = ISNULL(InformeGraficarCantidad, 5),
    @VerGraficaDetalle = ISNULL(VerGraficaDetalle,0)
	
    FROM RepParam
   WHERE Estacion = @EstacionTrabajo
     
    
  SELECT @ContMoneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa
  
  SELECT @EmpresaNombre = Nombre FROM Empresa WHERE Empresa = @Empresa

  EXEC spContactoDireccionHorizontal @EstacionTrabajo, 'Empresa', @Empresa, @Empresa, 1, 1, 1, 1
  
  SELECT @Direccion2 = Direccion2,
         @Direccion3 = Direccion3,
         @Direccion4 = Direccion4 
    FROM ContactoDireccionHorizontal
   WHERE Estacion = @EstacionTrabajo    

  SELECT @Reporte = 'Del Clientes  ' + @ClienteD + '  Al Clientes  ' + @ClienteA + '  En ' + ISNULL(@ContMoneda,'')  
  
  DECLARE @Vermis_spUtilidadClientes TABLE
  (
     Cliente		char(20)	COLLATE Database_Default NULL,
     Nombre		varchar(100)	COLLATE Database_Default NULL,
     Mov		char(20)	COLLATE Database_Default NULL,
     MovID		varchar(20)	COLLATE Database_Default NULL,
     DescuentoGlobal	float(8)	NULL,
     CantidadNeta 	float(8)	NULL,
     ImporteBruto	money		NULL,
     ImporteNeto	money		NULL,
     CostoNeto		money		NULL,
     ComisionNeta	money		NULL,
     Utilidad		money		NULL,
     UtilidadPor	float(8)	NULL,
     DescuentoGlobalD	float(8)	NULL,
     CantidadNetaD 	float(8)	NULL,
     ImporteBrutoD	money		NULL,
     ImporteNetoD	money		NULL,
     CostoNetoD		money		NULL,
     ComisionNetaD	money		NULL,
     UtilidadD		money		NULL,
     UtilidadPorD	float(8)	NULL
  )

  


  DECLARE @mis_spUtilidadClientes TABLE
  (
     Cliente		char(20)	COLLATE Database_Default NULL,
     Nombre		varchar(100)	COLLATE Database_Default NULL,
     Mov		char(20)	COLLATE Database_Default NULL,
     MovID		varchar(20)	COLLATE Database_Default NULL,
     DescuentoGlobal	float(8)	NULL,
     CantidadNeta 	float(8)	NULL,
     ImporteBruto	money		NULL,
     ImporteNeto	money		NULL,
     CostoNeto		money		NULL,
     ComisionNeta	money		NULL,
     Utilidad		money		NULL,
     UtilidadPor	float(8)	NULL,
     DescuentoGlobalD	float(8)	NULL,
     CantidadNetaD 	float(8)	NULL,
     ImporteBrutoD	money		NULL,
     ImporteNetoD	money		NULL,
     CostoNetoD		money		NULL,
     ComisionNetaD	money		NULL,
     UtilidadD		money		NULL,
     UtilidadPorD	float(8)	NULL,

	 Desglosar			varchar(5)	NULL,
	 Desglosar2			varchar(5)	NULL,
     FechaD				datetime	NULL,
     FechaA				datetime	NULL,
     Orden1				int			NULL,
     

	 GraficaArgumento	varchar(100) COLLATE DATABASE_DEFAULT NULL,   
     GraficaValor		float		NULL,
     Grafica1			int			NULL DEFAULT 0,
     Grafica2			int			NULL DEFAULT 0,
     Titulo				varchar(100)NULL,
     Reporte			varchar(200)NULL,
     Direccion2			varchar(100)NULL,
     Direccion3			varchar(100)NULL,
     Direccion4			varchar(100)NULL,
     GraficaSerie		varchar(100) COLLATE DATABASE_DEFAULT NULL,
     EmpresaNombre		varchar(100) COLLATE DATABASE_DEFAULT NULL
--     Nombre				varchar(100) COLLATE DATABASE_DEFAULT NULL

  )


--  SELECT @Empresa, @ClienteD, @ClienteA, @CteCat, @CteFam, @CteGrupo, @FechaD, @FechaA, @Desglosar
-- select 'TMS', '(GENERAL)', '7590', 'NULL', 'NULL', 'NULL', '01/03/2000', '31/03/2011', 'No'
  INSERT INTO @Vermis_spUtilidadClientes
  EXEC mis_spUtilidadClientes @Empresa, @ClienteD, @ClienteA, @CteCat, @CteFam, @CteGrupo, @FechaD, @FechaA, @Desglosar
 
  
  INSERT INTO @mis_spUtilidadClientes
  SELECT *, @Desglosar, @Desglosar, @FechaD, @FechaA, NULL, NULL, NULL, 0, 0, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, NULL, @EmpresaNombre FROM @Vermis_spUtilidadClientes


  SELECT @Contador = 0
  DECLARE crOrden CURSOR FAST_FORWARD FOR
   SELECT Cliente
     FROM @mis_spUtilidadClientes
    ORDER BY Utilidad DESC, Cliente, UtilidadD DESC

  OPEN crOrden
  FETCH NEXT FROM crOrden INTO @Cliente
  WHILE @@FETCH_STATUS = 0-- AND @Ok IS NULL
  BEGIN
  
    IF EXISTS(SELECT * FROM @mis_spUtilidadClientes WHERE Cliente = @Cliente AND Orden1 IS NULL) 
    BEGIN
      SELECT @Nombre = Nombre FROM Cte WHERE Cliente = @Cliente
      SELECT @Contador = @Contador + 1
      UPDATE @mis_spUtilidadClientes SET Orden1 = @Contador, Nombre = @Nombre WHERE Cliente = @Cliente
    END

    FETCH NEXT FROM crOrden INTO @Cliente
  END
  CLOSE crOrden
  DEALLOCATE crOrden


  SELECT @Utilidad = 0.00, @Venta  = 0.00, @Costo  = 0.00
  DECLARE crGrafica CURSOR FAST_FORWARD FOR
   SELECT Cliente, Orden1, CASE WHEN @Desglosar = 'No' THEN SUM(Utilidad) ELSE SUM(UtilidadD) END, SUBSTRING(Nombre, 1, 30), CASE WHEN @Desglosar = 'No' THEN SUM(ImporteNeto) ELSE SUM(ImporteNetoD) END,CASE WHEN @Desglosar = 'No' THEN SUM(CostoNeto) ELSE SUM(CostoNetoD) END
     FROM @mis_spUtilidadClientes 
    GROUP BY Cliente, Nombre, Orden1
    ORDER BY Orden1, Cliente

  OPEN crGrafica
  FETCH NEXT FROM crGrafica INTO @Cliente, @Orden, @Utilidad, @Nombre, @Venta, @Costo
  WHILE @@FETCH_STATUS = 0-- AND @Ok IS NULL
  BEGIN

    INSERT INTO @mis_spUtilidadClientes(GraficaArgumento, GraficaValor, Grafica1, Grafica2, Orden1, GraficaSerie, Titulo, Reporte, Direccion2, Direccion3, Direccion4, EmpresaNombre, Desglosar, Desglosar2, FechaD, FechaA)
      SELECT 'Costo', @Costo, 1, 0, 0, @Nombre, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @EmpresaNombre, '', @Desglosar, @FechaD, @FechaA
    
    INSERT INTO @mis_spUtilidadClientes(GraficaArgumento, GraficaValor, Grafica1, Grafica2, Orden1, GraficaSerie, Titulo, Reporte, Direccion2, Direccion3, Direccion4, EmpresaNombre, Desglosar, Desglosar2, FechaD, FechaA)
      SELECT 'Importe Venta', @Venta, 1, 0, 0, @Nombre, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @EmpresaNombre, '', @Desglosar, @FechaD, @FechaA

    INSERT INTO @mis_spUtilidadClientes(GraficaArgumento, GraficaValor, Grafica1, Grafica2, Orden1, GraficaSerie, Titulo, Reporte, Direccion2, Direccion3, Direccion4, EmpresaNombre, Desglosar, Desglosar2, FechaD, FechaA)
      SELECT 'Utilidad', @Utilidad, 1, 0, 0, @Nombre, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @EmpresaNombre, '', @Desglosar, @FechaD, @FechaA
    
    FETCH NEXT FROM crGrafica INTO @Cliente, @Orden, @Utilidad, @Nombre, @Venta, @Costo
  END
  
  CLOSE crGrafica
  DEALLOCATE crGrafica
  

  SELECT @Graficar = NULL
  SELECT @Graficar = ISNULL(COUNT(DISTINCT GraficaSerie),0)
    FROM @mis_spUtilidadClientes
   WHERE Grafica1 = 1
       
  IF @GraficarTipo = 'Mas Sobresalientes' AND @Graficar > @GraficarCantidad
    DELETE @mis_spUtilidadClientes 
     WHERE GraficaSerie NOT IN(
    SELECT  TOP (@GraficarCantidad) GraficaSerie
      FROM
      (
      SELECT
          'GraficaSerie'   = GraficaSerie,
          'GraficaValor'   = SUM(ISNULL(GraficaValor,0.00))
     
        FROM @mis_spUtilidadClientes
       WHERE Grafica1 = 1
        GROUP BY GraficaSerie
      ) AS x
     GROUP BY x.GraficaSerie
     ORDER BY SUM(ISNULL(x.GraficaValor,0.00))DESC)
       AND Grafica1 = 1

  IF @GraficarTipo = 'Menos Sobresalientes' AND @Graficar > @GraficarCantidad
    DELETE @mis_spUtilidadClientes 
     WHERE GraficaSerie NOT IN(
    SELECT  TOP (@GraficarCantidad) GraficaSerie
      FROM
      (
      SELECT
          'GraficaSerie'   = GraficaSerie,
          'GraficaValor'   = SUM(ISNULL(GraficaValor,0.00))
     
        FROM @mis_spUtilidadClientes
       WHERE Grafica1 = 1
        GROUP BY GraficaSerie
      ) AS x
     GROUP BY x.GraficaSerie
     ORDER BY SUM(ISNULL(x.GraficaValor,0.00))ASC)
       AND Grafica1 = 1


  SELECT *, @Etiqueta as Etiqueta, @VerGraficaDetalle as VerGraficaDetalle FROM @mis_spUtilidadClientes
END
GO

--EXEC spInformemis_spUtilidadClientes 1
--go


/******************************* spInformemis_spUtilidadSucursales *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spInformemis_spUtilidadSucursales') and type = 'P') drop procedure dbo.spInformemis_spUtilidadSucursales
GO             
CREATE PROCEDURE spInformemis_spUtilidadSucursales
		@EstacionTrabajo		int

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  	@Empresa			varchar	(5),
    @Sucursal			int,
    @Nombre				varchar	(100),
    @Contador			int,
    @Orden				int,
	@EmpresaNombre		varchar	(100),
	@Titulo				varchar	(100),
	@Reporte			varchar	(200),
	@Direccion2			varchar	(100),
	@Direccion3			varchar	(100),
	@Direccion4			varchar	(100),
	@Desglosar			varchar	(50),
	@FechaD				datetime,
	@FechaA				datetime,
	@ContMoneda			varchar	(30),
	@Venta				float,
	@Costo				float,
	@Utilidad			float,
	@Graficar			int,
	@GraficarFecha		int,
	@GraficarTipo		varchar(30),
	@Etiqueta			bit,
	@GraficarCantidad	int,
	@Verdadero			bit,
	@Falso				bit,
    @VerGraficaDetalle		bit


  SELECT @Verdadero = 1, @Falso = 0
  SELECT
    @Empresa		=	InfoEmpresa,
	@FechaD			=	InfoFechaD,
	@FechaA			=	InfoFechaA,
	@Sucursal		=	InfoSucursal,
	@Desglosar		=	InfoDesglosar,
	@Titulo			=	RepTitulo,
	@GraficarTipo	= ISNULL(InformeGraficarTipo,  '(Todos)'),
	@Etiqueta		= ISNULL(InfoEtiqueta, @Falso),
	@GraficarCantidad = ISNULL(InformeGraficarCantidad, 5),
    @VerGraficaDetalle = ISNULL(VerGraficaDetalle,0)
	
    FROM RepParam
   WHERE Estacion = @EstacionTrabajo
     
    
  SELECT @ContMoneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa
  
  SELECT @EmpresaNombre = Nombre FROM Empresa WHERE Empresa = @Empresa

  EXEC spContactoDireccionHorizontal @EstacionTrabajo, 'Empresa', @Empresa, @Empresa, 1, 1, 1, 1
  
  SELECT @Direccion2 = Direccion2,
         @Direccion3 = Direccion3,
         @Direccion4 = Direccion4 
    FROM ContactoDireccionHorizontal
   WHERE Estacion = @EstacionTrabajo    

--  SELECT @Reporte = 'Del Sucursales  ' + @SucursalD + '  Al Sucursales  ' + @SucursalA + '  En ' + ISNULL(@ContMoneda,'')  
  
  DECLARE @Vermis_spUtilidadSucursales TABLE
  (
     Sucursal		int		NULL,
     Mov		char(20)	COLLATE Database_Default NULL,
     MovID		varchar(20)	COLLATE Database_Default NULL,
     DescuentoGlobal	float(8)	NULL,
     CantidadNeta 	float(8)	NULL,
     ImporteBruto	money		NULL,
     ImporteNeto	money		NULL,
     CostoNeto		money		NULL,
     ComisionNeta	money		NULL,
     Utilidad		money		NULL,
     UtilidadPor	float(8)	NULL,
     DescuentoGlobalD	float(8)	NULL,
     CantidadNetaD 	float(8)	NULL,
     ImporteBrutoD	money		NULL,
     ImporteNetoD	money		NULL,
     CostoNetoD		money		NULL,
     ComisionNetaD	money		NULL,
     UtilidadD		money		NULL,
     UtilidadPorD	float(8)	NULL
  )

  


  DECLARE @mis_spUtilidadSucursales TABLE
  (
     Sucursal		int		NULL,
     Mov		char(20)	COLLATE Database_Default NULL,
     MovID		varchar(20)	COLLATE Database_Default NULL,
     DescuentoGlobal	float(8)	NULL,
     CantidadNeta 	float(8)	NULL,
     ImporteBruto	money		NULL,
     ImporteNeto	money		NULL,
     CostoNeto		money		NULL,
     ComisionNeta	money		NULL,
     Utilidad		money		NULL,
     UtilidadPor	float(8)	NULL,
     DescuentoGlobalD	float(8)	NULL,
     CantidadNetaD 	float(8)	NULL,
     ImporteBrutoD	money		NULL,
     ImporteNetoD	money		NULL,
     CostoNetoD		money		NULL,
     ComisionNetaD	money		NULL,
     UtilidadD		money		NULL,
     UtilidadPorD	float(8)	NULL,

	 Desglosar			varchar(5)	NULL,
	 Desglosar2			varchar(5)	NULL,
     FechaD				datetime	NULL,
     FechaA				datetime	NULL,
     Orden1				int			NULL,
     

	 GraficaArgumento	varchar(100) COLLATE DATABASE_DEFAULT NULL,   
     GraficaValor		float		NULL,
     Grafica1			int			NULL DEFAULT 0,
     Grafica2			int			NULL DEFAULT 0,
     Titulo				varchar(100)NULL,
     Reporte			varchar(200)NULL,
     Direccion2			varchar(100)NULL,
     Direccion3			varchar(100)NULL,
     Direccion4			varchar(100)NULL,
     GraficaSerie		varchar(100) COLLATE DATABASE_DEFAULT NULL,
     EmpresaNombre		varchar(100) COLLATE DATABASE_DEFAULT NULL,
     Nombre				varchar(100) COLLATE DATABASE_DEFAULT NULL

  )

--select @Sucursal = NULL
--  SELECT @Empresa, @FechaD, @FechaA, @Sucursal, @Desglosar
-- select 'TMS', '01/03/2000', '31/03/2011', NULL, 'No'
  INSERT INTO @Vermis_spUtilidadSucursales
  EXEC mis_spUtilidadSucursal @Empresa, @FechaD, @FechaA, @Sucursal, @Desglosar
 
  
  INSERT INTO @mis_spUtilidadSucursales
  SELECT *, @Desglosar, @Desglosar, @FechaD, @FechaA, NULL, NULL, NULL, 0, 0, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, NULL, @EmpresaNombre, @Nombre FROM @Vermis_spUtilidadSucursales


  SELECT @Contador = 0
  DECLARE crOrden CURSOR FAST_FORWARD FOR
   SELECT Sucursal
     FROM @mis_spUtilidadSucursales
    ORDER BY Utilidad DESC, Sucursal, UtilidadD DESC

  OPEN crOrden
  FETCH NEXT FROM crOrden INTO @Sucursal
  WHILE @@FETCH_STATUS = 0-- AND @Ok IS NULL
  BEGIN
  
    IF EXISTS(SELECT * FROM @mis_spUtilidadSucursales WHERE Sucursal = @Sucursal AND Orden1 IS NULL) 
    BEGIN
      SELECT @Nombre = Nombre FROM Sucursal WHERE Sucursal = @Sucursal
      SELECT @Contador = @Contador + 1
      UPDATE @mis_spUtilidadSucursales SET Orden1 = @Contador, Nombre = @Nombre WHERE Sucursal = @Sucursal
    END

    FETCH NEXT FROM crOrden INTO @Sucursal
  END
  CLOSE crOrden
  DEALLOCATE crOrden


  SELECT @Utilidad = 0.00, @Venta  = 0.00, @Costo  = 0.00
  DECLARE crGrafica CURSOR FAST_FORWARD FOR
   SELECT Sucursal, Orden1, CASE WHEN @Desglosar = 'No' THEN SUM(Utilidad) ELSE SUM(UtilidadD) END, SUBSTRING(Nombre, 1, 30), CASE WHEN @Desglosar = 'No' THEN SUM(ImporteNeto) ELSE SUM(ImporteNetoD) END,CASE WHEN @Desglosar = 'No' THEN SUM(CostoNeto) ELSE SUM(CostoNetoD) END
     FROM @mis_spUtilidadSucursales 
    GROUP BY Sucursal, Nombre, Orden1
    ORDER BY Orden1, Sucursal

  OPEN crGrafica
  FETCH NEXT FROM crGrafica INTO @Sucursal, @Orden, @Utilidad, @Nombre, @Venta, @Costo
  WHILE @@FETCH_STATUS = 0-- AND @Ok IS NULL
  BEGIN

    INSERT INTO @mis_spUtilidadSucursales(GraficaArgumento, GraficaValor, Grafica1, Grafica2, Orden1, GraficaSerie, Titulo, Reporte, Direccion2, Direccion3, Direccion4, EmpresaNombre, Desglosar, Desglosar2, FechaD, FechaA)
      SELECT 'Costo', @Costo, 1, 0, 0, @Nombre, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @EmpresaNombre, '', @Desglosar, @FechaD, @FechaA
    
    INSERT INTO @mis_spUtilidadSucursales(GraficaArgumento, GraficaValor, Grafica1, Grafica2, Orden1, GraficaSerie, Titulo, Reporte, Direccion2, Direccion3, Direccion4, EmpresaNombre, Desglosar, Desglosar2, FechaD, FechaA)
      SELECT 'Importe Venta', @Venta, 1, 0, 0, @Nombre, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @EmpresaNombre, '', @Desglosar, @FechaD, @FechaA

    INSERT INTO @mis_spUtilidadSucursales(GraficaArgumento, GraficaValor, Grafica1, Grafica2, Orden1, GraficaSerie, Titulo, Reporte, Direccion2, Direccion3, Direccion4, EmpresaNombre, Desglosar, Desglosar2, FechaD, FechaA)
      SELECT 'Utilidad', @Utilidad, 1, 0, 0, @Nombre, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @EmpresaNombre, '', @Desglosar, @FechaD, @FechaA
    
    FETCH NEXT FROM crGrafica INTO @Sucursal, @Orden, @Utilidad, @Nombre, @Venta, @Costo
  END
  
  CLOSE crGrafica
  DEALLOCATE crGrafica
  

  SELECT @Graficar = NULL
  SELECT @Graficar = ISNULL(COUNT(DISTINCT GraficaSerie),0)
    FROM @mis_spUtilidadSucursales
   WHERE Grafica1 = 1
       
  IF @GraficarTipo = 'Mas Sobresalientes' AND @Graficar > @GraficarCantidad
    DELETE @mis_spUtilidadSucursales 
     WHERE GraficaSerie NOT IN(
    SELECT  TOP (@GraficarCantidad) GraficaSerie
      FROM
      (
      SELECT
          'GraficaSerie'   = GraficaSerie,
          'GraficaValor'   = SUM(ISNULL(GraficaValor,0.00))
     
        FROM @mis_spUtilidadSucursales
       WHERE Grafica1 = 1
        GROUP BY GraficaSerie
      ) AS x
     GROUP BY x.GraficaSerie
     ORDER BY SUM(ISNULL(x.GraficaValor,0.00))DESC)
       AND Grafica1 = 1

  IF @GraficarTipo = 'Menos Sobresalientes' AND @Graficar > @GraficarCantidad
    DELETE @mis_spUtilidadSucursales 
     WHERE GraficaSerie NOT IN(
    SELECT  TOP (@GraficarCantidad) GraficaSerie
      FROM
      (
      SELECT
          'GraficaSerie'   = GraficaSerie,
          'GraficaValor'   = SUM(ISNULL(GraficaValor,0.00))
     
        FROM @mis_spUtilidadSucursales
       WHERE Grafica1 = 1
        GROUP BY GraficaSerie
      ) AS x
     GROUP BY x.GraficaSerie
     ORDER BY SUM(ISNULL(x.GraficaValor,0.00))ASC)
       AND Grafica1 = 1


  SELECT *, @Etiqueta as Etiqueta, @VerGraficaDetalle as VerGraficaDetalle FROM @mis_spUtilidadSucursales
END
GO

--EXEC spInformemis_spUtilidadSucursales 1
--go


/******************************* spInformemis_spUtilidadUEN *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spInformemis_spUtilidadUEN') and type = 'P') drop procedure dbo.spInformemis_spUtilidadUEN
GO             
CREATE PROCEDURE spInformemis_spUtilidadUEN
		@EstacionTrabajo		int

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  	@Empresa			varchar	(5),
    @UEN				int,
    @Nombre				varchar	(100),
    @Contador			int,
    @Orden				int,
	@EmpresaNombre		varchar	(100),
	@Titulo				varchar	(100),
	@Reporte			varchar	(200),
	@Direccion2			varchar	(100),
	@Direccion3			varchar	(100),
	@Direccion4			varchar	(100),
	@Desglosar			varchar	(50),
	@FechaD				datetime,
	@FechaA				datetime,
	@ContMoneda			varchar	(30),
	@Venta				float,
	@Costo				float,
	@Utilidad			float,
	@Graficar			int,
	@GraficarFecha		int,
	@GraficarTipo		varchar(30),
	@Etiqueta			bit,
	@GraficarCantidad	int,
	@Verdadero			bit,
	@Falso				bit,
    @VerGraficaDetalle		bit


  SELECT @Verdadero = 1, @Falso = 0
  SELECT
    @Empresa		=	InfoEmpresa,
	@FechaD			=	InfoFechaD,
	@FechaA			=	InfoFechaA,
	@UEN			=	InfoUEN,
	@Desglosar		=	InfoDesglosar,
	@Titulo			=	RepTitulo,
	@GraficarTipo	= ISNULL(InformeGraficarTipo,  '(Todos)'),
	@Etiqueta		= ISNULL(InfoEtiqueta, @Falso),
	@GraficarCantidad = ISNULL(InformeGraficarCantidad, 5),
    @VerGraficaDetalle = ISNULL(VerGraficaDetalle,0),
    @VerGraficaDetalle = ISNULL(VerGraficaDetalle,0)
	
    FROM RepParam
   WHERE Estacion = @EstacionTrabajo
     
    
  SELECT @ContMoneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa
  
  SELECT @EmpresaNombre = Nombre FROM Empresa WHERE Empresa = @Empresa

  EXEC spContactoDireccionHorizontal @EstacionTrabajo, 'Empresa', @Empresa, @Empresa, 1, 1, 1, 1
  
  SELECT @Direccion2 = Direccion2,
         @Direccion3 = Direccion3,
         @Direccion4 = Direccion4 
    FROM ContactoDireccionHorizontal
   WHERE Estacion = @EstacionTrabajo

--  SELECT @Reporte = 'Del UEN  ' + @UEND + '  Al UEN  ' + @UENA + '  En ' + ISNULL(@ContMoneda,'')  
  
  DECLARE @Vermis_spUtilidadUEN TABLE
  (
     UEN		int		NULL,
     Mov		char(20)	COLLATE Database_Default NULL,
     MovID		varchar(20)	COLLATE Database_Default NULL,
     DescuentoGlobal	float(8)	NULL,
     CantidadNeta 	float(8)	NULL,
     ImporteBruto	money		NULL,
     ImporteNeto	money		NULL,
     CostoNeto		money		NULL,
     ComisionNeta	money		NULL,
     Utilidad		money		NULL,
     UtilidadPor	float(8)	NULL,
     DescuentoGlobalD	float(8)	NULL,
     CantidadNetaD 	float(8)	NULL,
     ImporteBrutoD	money		NULL,
     ImporteNetoD	money		NULL,
     CostoNetoD		money		NULL,
     ComisionNetaD	money		NULL,
     UtilidadD		money		NULL,
     UtilidadPorD	float(8)	NULL
  )

  


  DECLARE @mis_spUtilidadUEN TABLE
  (
     UEN		int		NULL,
     Mov		char(20)	COLLATE Database_Default NULL,
     MovID		varchar(20)	COLLATE Database_Default NULL,
     DescuentoGlobal	float(8)	NULL,
     CantidadNeta 	float(8)	NULL,
     ImporteBruto	money		NULL,
     ImporteNeto	money		NULL,
     CostoNeto		money		NULL,
     ComisionNeta	money		NULL,
     Utilidad		money		NULL,
     UtilidadPor	float(8)	NULL,
     DescuentoGlobalD	float(8)	NULL,
     CantidadNetaD 	float(8)	NULL,
     ImporteBrutoD	money		NULL,
     ImporteNetoD	money		NULL,
     CostoNetoD		money		NULL,
     ComisionNetaD	money		NULL,
     UtilidadD		money		NULL,
     UtilidadPorD	float(8)	NULL,

	 Desglosar			varchar(5)	NULL,
	 Desglosar2			varchar(5)	NULL,
     FechaD				datetime	NULL,
     FechaA				datetime	NULL,
     Orden1				int			NULL,
     

	 GraficaArgumento	varchar(100) COLLATE DATABASE_DEFAULT NULL,   
     GraficaValor		float		NULL,
     Grafica1			int			NULL DEFAULT 0,
     Grafica2			int			NULL DEFAULT 0,
     Titulo				varchar(100)NULL,
     Reporte			varchar(200)NULL,
     Direccion2			varchar(100)NULL,
     Direccion3			varchar(100)NULL,
     Direccion4			varchar(100)NULL,
     GraficaSerie		varchar(100) COLLATE DATABASE_DEFAULT NULL,
     EmpresaNombre		varchar(100) COLLATE DATABASE_DEFAULT NULL,
     Nombre				varchar(100) COLLATE DATABASE_DEFAULT NULL

  )

--select @UEN = NULL
--  SELECT @Empresa, @FechaD, @FechaA, @UEN, @Desglosar
-- select 'TMS', '01/03/2000', '31/03/2011', NULL, 'No'
  INSERT INTO @Vermis_spUtilidadUEN
  EXEC mis_spUtilidadUEN @Empresa, @FechaD, @FechaA, @UEN, @Desglosar
 
  
  INSERT INTO @mis_spUtilidadUEN
  SELECT *, @Desglosar, @Desglosar, @FechaD, @FechaA, NULL, NULL, NULL, 0, 0, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, NULL, @EmpresaNombre, @Nombre FROM @Vermis_spUtilidadUEN


  SELECT @Contador = 0
  DECLARE crOrden CURSOR FAST_FORWARD FOR
   SELECT UEN
     FROM @mis_spUtilidadUEN
    ORDER BY Utilidad DESC, UEN, UtilidadD DESC

  OPEN crOrden
  FETCH NEXT FROM crOrden INTO @UEN
  WHILE @@FETCH_STATUS = 0-- AND @Ok IS NULL
  BEGIN
  
    IF EXISTS(SELECT * FROM @mis_spUtilidadUEN WHERE UEN = @UEN AND Orden1 IS NULL) 
    BEGIN
      SELECT @Nombre = Nombre FROM UEN WHERE UEN = @UEN
      SELECT @Contador = @Contador + 1
      UPDATE @mis_spUtilidadUEN SET Orden1 = @Contador, Nombre = @Nombre WHERE UEN = @UEN
    END

    FETCH NEXT FROM crOrden INTO @UEN
  END
  CLOSE crOrden
  DEALLOCATE crOrden


  SELECT @Utilidad = 0.00, @Venta  = 0.00, @Costo  = 0.00
  DECLARE crGrafica CURSOR FAST_FORWARD FOR
   SELECT UEN, Orden1, CASE WHEN @Desglosar = 'No' THEN SUM(Utilidad) ELSE SUM(UtilidadD) END, SUBSTRING(Nombre, 1, 30), CASE WHEN @Desglosar = 'No' THEN SUM(ImporteNeto) ELSE SUM(ImporteNetoD) END,CASE WHEN @Desglosar = 'No' THEN SUM(CostoNeto) ELSE SUM(CostoNetoD) END
     FROM @mis_spUtilidadUEN 
    GROUP BY UEN, Nombre, Orden1
    ORDER BY Orden1, UEN

  OPEN crGrafica
  FETCH NEXT FROM crGrafica INTO @UEN, @Orden, @Utilidad, @Nombre, @Venta, @Costo
  WHILE @@FETCH_STATUS = 0-- AND @Ok IS NULL
  BEGIN
    
    INSERT INTO @mis_spUtilidadUEN(GraficaArgumento, GraficaValor, Grafica1, Grafica2, Orden1, GraficaSerie, Titulo, Reporte, Direccion2, Direccion3, Direccion4, EmpresaNombre, Desglosar, Desglosar2, FechaD, FechaA)
      SELECT 'Costo', @Costo, 1, 0, 0, @Nombre, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @EmpresaNombre, '', @Desglosar, @FechaD, @FechaA

    INSERT INTO @mis_spUtilidadUEN(GraficaArgumento, GraficaValor, Grafica1, Grafica2, Orden1, GraficaSerie, Titulo, Reporte, Direccion2, Direccion3, Direccion4, EmpresaNombre, Desglosar, Desglosar2, FechaD, FechaA)
      SELECT 'Importe Venta', @Venta, 1, 0, 0, @Nombre, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @EmpresaNombre, '', @Desglosar, @FechaD, @FechaA

    INSERT INTO @mis_spUtilidadUEN(GraficaArgumento, GraficaValor, Grafica1, Grafica2, Orden1, GraficaSerie, Titulo, Reporte, Direccion2, Direccion3, Direccion4, EmpresaNombre, Desglosar, Desglosar2, FechaD, FechaA)
      SELECT 'Utilidad', @Utilidad, 1, 0, 0, @Nombre, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @EmpresaNombre, '', @Desglosar, @FechaD, @FechaA
    
    FETCH NEXT FROM crGrafica INTO @UEN, @Orden, @Utilidad, @Nombre, @Venta, @Costo
  END
  
  CLOSE crGrafica
  DEALLOCATE crGrafica
  

  SELECT @Graficar = NULL
  SELECT @Graficar = ISNULL(COUNT(DISTINCT GraficaSerie),0)
    FROM @mis_spUtilidadUEN
   WHERE Grafica1 = 1
       
  IF @GraficarTipo = 'Mas Sobresalientes' AND @Graficar > @GraficarCantidad
    DELETE @mis_spUtilidadUEN 
     WHERE GraficaSerie NOT IN(
    SELECT  TOP (@GraficarCantidad) GraficaSerie
      FROM
      (
      SELECT
          'GraficaSerie'   = GraficaSerie,
          'GraficaValor'   = SUM(ISNULL(GraficaValor,0.00))
     
        FROM @mis_spUtilidadUEN
       WHERE Grafica1 = 1
        GROUP BY GraficaSerie
      ) AS x
     GROUP BY x.GraficaSerie
     ORDER BY SUM(ISNULL(x.GraficaValor,0.00))DESC)
       AND Grafica1 = 1

  IF @GraficarTipo = 'Menos Sobresalientes' AND @Graficar > @GraficarCantidad
    DELETE @mis_spUtilidadUEN 
     WHERE GraficaSerie NOT IN(
    SELECT  TOP (@GraficarCantidad) GraficaSerie
      FROM
      (
      SELECT
          'GraficaSerie'   = GraficaSerie,
          'GraficaValor'   = SUM(ISNULL(GraficaValor,0.00))
     
        FROM @mis_spUtilidadUEN
       WHERE Grafica1 = 1
        GROUP BY GraficaSerie
      ) AS x
     GROUP BY x.GraficaSerie
     ORDER BY SUM(ISNULL(x.GraficaValor,0.00))ASC)
       AND Grafica1 = 1


  SELECT *, @Etiqueta as Etiqueta FROM @mis_spUtilidadUEN
END
GO

--EXEC spInformemis_spUtilidadUEN 1
--go


/**************** fnInvCapaExistenciaPorFecha ****************/
IF EXISTS (SELECT name FROM SysObjects WHERE name = 'fnInvCapaExistenciaPorFecha' AND type IN ('TF','FN')) DROP FUNCTION fnInvCapaExistenciaPorFecha
GO
CREATE FUNCTION fnInvCapaExistenciaPorFecha (@ID int, @FechaA datetime)
RETURNS float
AS
BEGIN
  DECLARE @Existencia float

  SELECT @Existencia = ISNULL(SUM(ISNULL(CargoU,0)) - SUM(ISNULL(AbonoU,0)),0)
    FROM InvCapaAux
   WHERE ID = @ID
     AND Fecha < @FechaA
  
RETURN (@Existencia)
END
GO


/******************************* spInformeInvCapaPorFecha *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spInformeInvCapaPorFecha') and type = 'P') drop procedure dbo.spInformeInvCapaPorFecha
GO             
CREATE PROCEDURE spInformeInvCapaPorFecha
		@EstacionTrabajo		int

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  	@Empresa			varchar	(5),
    @Articulo			varchar	(20),
    @ArticuloD			varchar	(20),
    @ArticuloA			varchar	(20),
    @Nombre				varchar	(100),
	@CostoTotal			float,
	@Existencia			float,
    @Contador			int,
    @Orden				int,
	@EmpresaNombre		varchar	(100),
	@Titulo				varchar	(100),
	@Reporte			varchar	(200),
	@Direccion2			varchar	(100),
	@Direccion3			varchar	(100),
	@Direccion4			varchar	(100),
	@FechaD				datetime,
	@FechaA				datetime,
	@ContMoneda			varchar	(30),
	@Graficar			int,
	@GraficarFecha		int,
	@GraficarTipo		varchar(30),
	@Etiqueta			bit,
	@GraficarCantidad	int,
	@Verdadero			bit,
	@Falso				bit,
	@InvValuacionOtraMoneda varchar(10),
    @VerGraficaDetalle		bit


  SELECT @Verdadero = 1, @Falso = 0
  SELECT
    @Empresa		=	InfoEmpresa,
	@FechaD			=	InfoFechaD,
	@FechaA			=	InfoFechaA,
	@ArticuloD		=	InfoArticuloD,
	@ArticuloA		=	InfoArticuloA,
	@Titulo			=	RepTitulo,
	@GraficarTipo	=	ISNULL(InformeGraficarTipo,  '(Todos)'),
	@Etiqueta		=	ISNULL(InfoEtiqueta, @Falso),
	@GraficarCantidad = ISNULL(InformeGraficarCantidad, 5),
    @VerGraficaDetalle = ISNULL(VerGraficaDetalle,0)
	
    FROM RepParam
   WHERE Estacion = @EstacionTrabajo
     

  SELECT @ContMoneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa
  
  SELECT @EmpresaNombre = Nombre FROM Empresa WHERE Empresa = @Empresa

  EXEC spContactoDireccionHorizontal @EstacionTrabajo, 'Empresa', @Empresa, @Empresa, 1, 1, 1, 1
  
  SELECT @Direccion2 = Direccion2,
         @Direccion3 = Direccion3,
         @Direccion4 = Direccion4 
    FROM ContactoDireccionHorizontal
   WHERE Estacion = @EstacionTrabajo

--  SELECT @Reporte = 'Del UEN  ' + @UEND + '  Al UEN  ' + @UENA + '  En ' + ISNULL(@ContMoneda,'')  
  
--select @Empresa, @ArticuloD, @ArticuloA, @FechaD, @FechaA

  DECLARE @InvCapaPorFecha TABLE
  (
     Articulo			varchar(20)	COLLATE Database_Default NULL,
     Fecha				datetime	NULL,
	 Existencia 		float(8)	NULL,
	 Costo				float(8)	NULL,
     Movimiento			varchar(50)	COLLATE Database_Default NULL,
     Descripcion		varchar(255)COLLATE Database_Default NULL,
     CostoTotal			float(8)	NULL,

     FechaD				datetime	NULL,
     FechaA				datetime	NULL,
     Orden1				int			NULL,

	 GraficaArgumento	varchar(100) COLLATE DATABASE_DEFAULT NULL,   
     GraficaValor		float		NULL,
     Grafica1			int			NULL DEFAULT 0,
     Grafica2			int			NULL DEFAULT 0,
     Titulo				varchar(100)COLLATE DATABASE_DEFAULT NULL,
     Reporte			varchar(200)COLLATE DATABASE_DEFAULT NULL,
     Direccion2			varchar(100)COLLATE DATABASE_DEFAULT NULL,
     Direccion3			varchar(100)COLLATE DATABASE_DEFAULT NULL,
     Direccion4			varchar(100)COLLATE DATABASE_DEFAULT NULL,
     GraficaSerie		varchar(100)COLLATE DATABASE_DEFAULT NULL,
     EmpresaNombre		varchar(100)COLLATE DATABASE_DEFAULT NULL,
     Nombre				varchar(100)COLLATE DATABASE_DEFAULT NULL,
     
     InvValuacionOtraMoneda			varchar(10)COLLATE DATABASE_DEFAULT DEFAULT 'NO' NULL,
     OtraMonedaTipoCambio			float(8)	NULL,
     OtraMonedaCostoTotal			float(8)	NULL,
     Sistema			varchar(10)COLLATE DATABASE_DEFAULT NULL
     
  )

--select @UEN = NULL
  --SELECT @Empresa, @FechaD, @FechaA--, @UEN, @Desglosar
-- select 'TMS', '01/03/2000', '31/03/2011', NULL, 'No'
  
  SELECT @InvValuacionOtraMoneda = InvValuacionOtraMoneda FROM EmpresaCfg2 WHERE Empresa = @Empresa

  INSERT @InvCapaPorFecha (Articulo, Fecha, Existencia, Costo, Movimiento, Descripcion, CostoTotal, InvValuacionOtraMoneda, OtraMonedaTipoCambio, OtraMonedaCostoTotal, Sistema)
  SELECT InvCapa.Articulo,
 		 InvCapa.Fecha,
--		 InvCapa.Existencia,
		 dbo.fnInvCapaExistenciaPorFecha(InvCapa.ID, @FechaA) ExistenciaPorFecha,
		 InvCapa.Costo,
		 InvCapa.Mov + ' ' + ISNULL(InvCapa.MovID,''),
		 Art.Descripcion1,
--		 (InvCapa.Existencia*InvCapa.Costo) CostoTotal,
         (dbo.fnInvCapaExistenciaPorFecha(InvCapa.ID, @FechaA))*InvCapa.Costo CostoTotalPorFecha,
         ISNULL(NULLIF(@InvValuacionOtraMoneda,''),'NO'),
         ISNULL(InvCapa.OtraMonedaTipoCambio,1),
		 ((dbo.fnInvCapaExistenciaPorFecha(InvCapa.ID, @FechaA))*InvCapa.Costo) * ISNULL(InvCapa.OtraMonedaTipoCambio,1),
		 CASE WHEN InvCapa.Sistema = 'U' THEN 'UEPS' ELSE CASE WHEN InvCapa.Sistema = 'P' THEN 'PEPS' END END
    FROM InvCapa
    JOIN Art ON InvCapa.Articulo=Art.Articulo
   WHERE InvCapa.Empresa=@Empresa
     AND InvCapa.Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Fecha < @FechaA
   ORDER BY InvCapa.Articulo, InvCapa.Fecha 


  SELECT @Contador = 0
  DECLARE crOrden CURSOR FAST_FORWARD FOR
   SELECT Articulo
     FROM @InvCapaPorFecha
    ORDER BY Articulo

  OPEN crOrden
  FETCH NEXT FROM crOrden INTO @Articulo
  WHILE @@FETCH_STATUS = 0-- AND @Ok IS NULL
  BEGIN
  
    IF EXISTS(SELECT * FROM @InvCapaPorFecha WHERE Articulo = @Articulo AND Orden1 IS NULL) 
    BEGIN
      SELECT @Contador = @Contador + 1
      UPDATE @InvCapaPorFecha SET Orden1 = @Contador WHERE Articulo = @Articulo
    END

    FETCH NEXT FROM crOrden INTO @Articulo
  END
  CLOSE crOrden
  DEALLOCATE crOrden

  SELECT @CostoTotal  = 0.00, @Existencia = 0.00
  DECLARE crGrafica CURSOR FAST_FORWARD FOR
   SELECT Articulo, Orden1, SUM(ISNULL(CostoTotal,0.00)), Descripcion, SUM(ISNULL(Existencia,0.00))
     FROM @InvCapaPorFecha 
    GROUP BY Articulo, Descripcion, Orden1    
    HAVING SUM(ISNULL(Existencia,0.00)) <> 0
    ORDER BY Orden1, Articulo
    
  OPEN crGrafica
  FETCH NEXT FROM crGrafica INTO @Articulo, @Orden, @CostoTotal, @Nombre, @Existencia
  WHILE @@FETCH_STATUS = 0-- AND @Ok IS NULL
  BEGIN
    
    INSERT INTO @InvCapaPorFecha(GraficaArgumento, GraficaValor, Grafica1, Grafica2, Orden1, GraficaSerie, Titulo, Reporte, Direccion2, Direccion3, Direccion4, EmpresaNombre, FechaD, FechaA)
      SELECT 'CostoTotal', @CostoTotal, 1, 0, 0, @Nombre, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @EmpresaNombre, @FechaD, @FechaA

--    INSERT INTO @InvCapaPorFecha(GraficaArgumento, GraficaValor, Grafica1, Grafica2, Orden1, GraficaSerie, Titulo, Reporte, Direccion2, Direccion3, Direccion4, EmpresaNombre, FechaD, FechaA)
--      SELECT 'Existencia', @Existencia, 1, 0, 0, @Nombre, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @EmpresaNombre, @FechaD, @FechaA
    
    FETCH NEXT FROM crGrafica INTO @Articulo, @Orden, @CostoTotal, @Nombre, @Existencia
  END
  
  CLOSE crGrafica
  DEALLOCATE crGrafica


  SELECT @Graficar = NULL
  SELECT @Graficar = ISNULL(COUNT(DISTINCT GraficaSerie),0)
    FROM @InvCapaPorFecha
   WHERE Grafica1 = 1
       
  IF @GraficarTipo = 'Mas Sobresalientes' AND @Graficar > @GraficarCantidad
    DELETE @InvCapaPorFecha 
     WHERE GraficaSerie NOT IN(
    SELECT  TOP (@GraficarCantidad) GraficaSerie
      FROM
      (
      SELECT
          'GraficaSerie'   = GraficaSerie,
          'GraficaValor'   = SUM(ISNULL(GraficaValor,0.00))
     
        FROM @InvCapaPorFecha
       WHERE Grafica1 = 1
        GROUP BY GraficaSerie
      ) AS x
     GROUP BY x.GraficaSerie
     ORDER BY SUM(ISNULL(x.GraficaValor,0.00))DESC)
       AND Grafica1 = 1

  IF @GraficarTipo = 'Menos Sobresalientes' AND @Graficar > @GraficarCantidad
    DELETE @InvCapaPorFecha 
     WHERE GraficaSerie NOT IN(
    SELECT  TOP (@GraficarCantidad) GraficaSerie
      FROM
      (
      SELECT
          'GraficaSerie'   = GraficaSerie,
          'GraficaValor'   = SUM(ISNULL(GraficaValor,0.00))
     
        FROM @InvCapaPorFecha
       WHERE Grafica1 = 1
        GROUP BY GraficaSerie
      ) AS x
     GROUP BY x.GraficaSerie
     ORDER BY SUM(ISNULL(x.GraficaValor,0.00))ASC)
       AND Grafica1 = 1

  UPDATE @InvCapaPorFecha SET FechaA = @FechaA, FechaD = @FechaD, EmpresaNombre = @EmpresaNombre, Direccion2  = @Direccion2, Direccion3  = @Direccion3, Direccion4  = @Direccion4, Reporte = @Reporte, Titulo = @Titulo

  SELECT *, @Etiqueta as Etiqueta, @VerGraficaDetalle as VerGraficaDetalle FROM @InvCapaPorFecha

END
GO

--EXEC spInformeInvCapaPorFecha 1
--go

/**************** spCPInforme ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCPInforme') and type = 'P') drop procedure dbo.spCPInforme
GO             
CREATE PROCEDURE spCPInforme
		@Estacion		int


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @FechaD			datetime,
    @FechaA			datetime,
    @ClaveD			varchar(100),
    @ClaveA			varchar(100),
    @Proyecto		varchar(100),
    @Empresa		varchar(100),
    @Estatus		varchar(100),
    @Titulo			varchar(100),
    @VerGraficaDetalle		bit


  SELECT @FechaD = InfoFechaD,
		 @FechaA = InfoFechaA,
		 @ClaveD = ISNULL(InfoClavePresupuestalD,''),
		 @ClaveA = ISNULL(InfoClavePresupuestalA,''),
		 @Proyecto = InfoProyecto,
		 @Empresa = InfoEmpresa,
		 @Estatus = InfoEstatusEspecifico,
		 @Titulo = RepTitulo,
    @VerGraficaDetalle = ISNULL(VerGraficaDetalle,0)
    FROM RepParam 
   WHERE Estacion = @Estacion

  IF @Proyecto = '(Todos)'
    SELECT @Proyecto = NULL

  IF @ClaveD = ''
    SELECT @ClaveD = (SELECT MIN(ClavePresupuestal) FROM ClavePresupuestal)

  IF @ClaveA = ''
    SELECT @ClaveA = (SELECT MAX(ClavePresupuestal) FROM ClavePresupuestal)

  IF @Estatus = '(Todos)' SET @Estatus = NULL ELSE
  IF @Estatus = 'Pendientes' SET @Estatus = 'PENDIENTE' ELSE
  IF @Estatus = 'Concluidos' SET @Estatus = 'CONCLUIDO' 

  SELECT e.Empresa,
         e.Proyecto,
         d.ClavePresupuestal, 
         'Presupuesto' = ISNULL(SUM(d.Presupuesto*e.TipoCambio), 0.0),
         'Comprometido' = ISNULL(SUM(d.Comprometido*e.TipoCambio), 0.0),
         'Comprometido2' = ISNULL(SUM(d.Comprometido2*e.TipoCambio), 0.0),
         'Devengado' = ISNULL(SUM(d.Devengado*e.TipoCambio), 0.0),
         'Devengado2' = ISNULL(SUM(d.Devengado2*e.TipoCambio), 0.0),
         'Ejercido' = ISNULL(SUM(d.Ejercido*e.TipoCambio), 0.0),
         'EjercidoPagado' = ISNULL(SUM(d.EjercidoPagado), 0.0),
         'RemanenteDisponible' = ISNULL(SUM(d.RemanenteDisponible*e.TipoCambio), 0.0),
         'Anticipos' = ISNULL(SUM(d.Anticipos*e.TipoCambio), 0.0),
         'Sobrante' = ISNULL(SUM(d.Sobrante*e.TipoCambio), 0.0),
         'Disponible' = ISNULL(SUM(d.Disponible), 0.0),
         @FechaD FechaDesde,
         @FechaA FechaHasta,
         @ClaveD ClaveDesde,
         @ClaveA ClaveHasta,
         @Titulo Titulo,
         ISNULL(@Proyecto, '(Todos)') InfoProyecto,
         ISNULL(@Estatus, 'Pendientes, Concluidos') InfoEstatus,
         ISNULL(LTRIM(RTRIM(ISNULL(e.Origen, e.Mov))) + ' ' + LTRIM(RTRIM(ISNULL(e.OrigenID,e.MovID))) + ' - ' + LTRIM(RTRIM(SUBSTRING(CONVERT(varchar,e.FechaEmision),1,11))), '') Origen
    FROM CPD d
    JOIN CP e ON e.ID = d.ID AND e.Estatus = ISNULL(@Estatus, e.Estatus)
    JOIN MovTipo mt ON mt.Modulo = 'CP' AND mt.Mov = e.Mov AND mt.Clave IN ('CP.AS', 'CP.TA', 'CP.TR', 'CP.OP')
    LEFT OUTER JOIN Modulo m ON e.OrigenTipo = m.Modulo
   WHERE ClavePresupuestal BETWEEN @ClaveD AND @ClaveA --BUG15713         
         AND Proyecto = ISNULL(@Proyecto, Proyecto)
         AND e.Estatus IN('PENDIENTE', 'CONCLUIDO')
         AND e.Empresa = @Empresa         
   GROUP BY e.Empresa, e.Proyecto, d.ClavePresupuestal, ISNULL(LTRIM(RTRIM(ISNULL(e.Origen, e.Mov))) + ' ' + LTRIM(RTRIM(ISNULL(e.OrigenID,e.MovID))) + ' - ' + LTRIM(RTRIM(SUBSTRING(CONVERT(varchar,e.FechaEmision),1,11))), '')
       
END
GO
--exec spCPInforme 2
--GO

/**************** fnListaCorteMov ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnListaCorteMov' AND type = 'TF') DROP FUNCTION fnListaCorteMov
GO
CREATE FUNCTION fnListaCorteMov (@Caja varchar(20), @Cajero varchar(20), @Fecha datetime)
RETURNS @Resultado TABLE (Movimiento varchar(50))
--//WITH ENCRYPTION
AS BEGIN
  
  SELECT @Cajero = NULLIF(NULLIF(@Cajero, '(Todos)'), ''),
         @Fecha = dbo.fnFechaSinHora(@Fecha)
  INSERT @Resultado
  SELECT '(Todos)'
   UNION
  SELECT d.Mov + ' ' + d.MovID
    FROM Dinero d
    JOIN MovTipo mt
      ON d.Mov = mt.Mov
     AND mt.Modulo = 'DIN'
   WHERE mt.Clave = 'DIN.C'
     AND mt.SubClave IS NULL
     AND d.Estatus = 'CONCLUIDO'
     AND d.CtaDinero = @Caja
     AND ISNULL(d.Cajero,'') = ISNULL(@Cajero, ISNULL(d.Cajero,''))
     AND d.Importe > 0
     AND dbo.fnFechaSinHora(d.FechaEmision) = @Fecha
  RETURN 
END
GO

/**************** spCorteCajaInforme ***************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteCajaInforme') and type = 'P') drop procedure dbo.spCorteCajaInforme
GO
CREATE PROCEDURE spCorteCajaInforme (@Estacion int)
--//WITH ENCRYPTION
AS BEGIN

  DECLARE
    @FormaPago				varchar(50),
    @Importe				money,

    @Caja					varchar(20),
    @Cajero					varchar(20),
    @Fecha					datetime,
    @GraficaDescripcion		varchar(50),
	@Columna1				money,
	@Columna2				money,
	@Columna3				money,
	@Columna4				money,
	@Columna5				money,
	@Columna6				money,
	@Columna7				money,
	
	@Etiqueta				bit,
	@GraficarTipo			varchar(30),
	@Graficar				int,
	@GraficarCantidad		int,
	@CajeroNombre			varchar(100),
    @CajaNombre				varchar(100),
    @FechaSinHora			varchar(20),
    @Empresa				varchar(5),
    @EmpresaNombre			varchar(100),
    @Moneda					varchar(20),
    @ImporteMC				money,
    @ContMoneda				varchar(20),
    @TipoCambio				varchar(20),
    @FormaPago2				varchar(50),
    @TipoCambio2			varchar(20),
    @Corte					varchar(50),
    @IDCorte				int,
    @VerGraficaDetalle		bit


  SELECT @Caja = InfoCaja,
         @Cajero = NULLIF(NULLIF(InfoCajero, '(Todos)'), ''),
         @Fecha = dbo.fnFechaSinHora(InfoFechaDia),
         @Corte = NULLIF(NULLIF(InfoCorte, '(Todos)'), ''),
	     @GraficarTipo = ISNULL(InformeGraficarTipo,  '(Todos)'),
	     @Etiqueta = ISNULL(InfoEtiqueta, 0),
	     @GraficarCantidad = ISNULL(InformeGraficarCantidad, 5),
	     @Empresa = InfoEmpresa,
    @VerGraficaDetalle = ISNULL(VerGraficaDetalle,0)
    FROM RepParam
   WHERE Estacion = @Estacion

  SELECT @ContMoneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa
  
  IF @Corte IS NOT NULL
    SELECT @IDCorte = ID FROM Dinero WHERE Mov + ' ' + MovID = @Corte

  DECLARE @TablaFormaPago TABLE
    (
        Estacion	int		NOT NULL,        
		Mov			varchar(20) NULL,
		Clave		varchar(20) NULL,
		SubClave	varchar(20) NULL,
		FormaPago	varchar(50) NULL,
		Importe		money		NULL,
		Moneda		varchar(20) NULL,
		TipoCambio	varchar(20) NULL,
		ImporteMC	money		NULL
    )    

    
  DECLARE @Tabla TABLE
    (
        ID					int		IDENTITY,
        Estacion			int		 NOT NULL,
        
		TituloColumna1		varchar(100) NULL,
		TituloColumna2		varchar(100) NULL,
		TituloColumna3		varchar(100) NULL,
		TituloColumna4		varchar(100) NULL,
		TituloColumna5		varchar(100) NULL,
		TituloColumna6		varchar(100) NULL,
		TituloColumna7		varchar(100) NULL,
		TituloColumna8		varchar(100) NULL,
		TituloColumna9		varchar(100) NULL,
		TituloColumna10		varchar(100) NULL,
		TituloColumna11		varchar(100) NULL,
		Columna1			varchar(100) NULL,
		Columna2			varchar(100) NULL,
		Columna3			varchar(100) NULL,
		Columna4			varchar(100) NULL,
		Columna5			varchar(100) NULL,
		Columna6			varchar(100) NULL,
		Columna7			varchar(100) NULL,
		Columna8			varchar(100) NULL,
		Columna9			varchar(100) NULL,
		Columna10			varchar(100) NULL,
		Columna11			varchar(100) NULL,
		
		Tipo				int		 NOT NULL,
		
		Grafica				bit		DEFAULT 0,
		GraficaSerie		varchar(50)	 NULL,
        GraficaDescripcion	varchar(50)  NULL,
        GraficaImporte		money		 NULL,
        
        Titulo1				varchar(100) NULL,
        Titulo2				varchar(100) NULL,
        Titulo3				varchar(100) NULL,
        Titulo4				varchar(100) NULL,
        Titulo5				varchar(100) NULL,
        Titulo6				varchar(100) NULL,
        Titulo7				varchar(100) NULL,
        Moneda				varchar(20)	 NULL,
        MonedaMC			varchar(20)	 NULL,
        TipoCambio			varchar(20)	 NULL,
        TipoCambio2			varchar(20)	 NULL,
        Orden				int DEFAULT 0,
		Columna2MC			varchar(100) NULL,
		Columna3MC			varchar(100) NULL,
		Columna4MC			varchar(100) NULL,
		Columna5MC			varchar(100) NULL,
		Columna6MC			varchar(100) NULL,
		Columna7MC			varchar(100) NULL,
		Columna8MC			varchar(100) NULL,
		Columna9MC			varchar(100) NULL,
		Columna10MC			varchar(100) NULL,
		Columna11MC			varchar(100) NULL
        
    )	
    

  INSERT @TablaFormaPago
    SELECT 
      @Estacion Estacion,
      d.Mov,
      m.Clave,
      ISNULL(m.SubClave, ''),
      CASE d.ConDesglose WHEN 0 THEN ISNULL(d.FormaPago, '') ELSE ISNULL(dd.FormaPago, '') END FormaPago,
	  CASE d.ConDesglose WHEN 0 THEN SUM(d.Importe) ELSE SUM(dd.Importe) END Importe,
	  d.Moneda,
	  CONVERT(money,d.TipoCambio),
	  CASE d.ConDesglose WHEN 0 THEN SUM(d.Importe*d.TipoCambio) ELSE SUM(dd.Importe*d.TipoCambio) END Importe
      FROM Dinero d
      LEFT OUTER JOIN DineroD dd ON d.ID = dd.ID
      JOIN MovTipo m ON d.Mov = m.Mov AND m.Modulo = 'DIN'
     WHERE d.Estatus = 'CONCLUIDO' 
       AND (d.Corte > 0 OR d.CorteDestino > 0)
       AND m.Clave IN('DIN.A', 'DIN.AP', 'DIN.C', 'DIN.CP', 'DIN.F', 'DIN.I', 'DIN.E', 'DIN.TC')
	   AND CASE WHEN m.Clave IN('DIN.A','DIN.C', 'DIN.CP') THEN CASE WHEN m.SubClave IS NOT NULL THEN 1 ELSE 0 END ELSE 0 END = 0
       AND dbo.fnFechaSinHora(d.FechaRegistro) = @Fecha
       AND CASE m.Clave WHEN 'DIN.A' THEN d.CtaDineroDestino WHEN 'DIN.AP' THEN d.CtaDineroDestino WHEN 'DIN.TC' THEN @Caja ELSE d.CtaDinero END = @Caja
       AND ISNULL(d.Cajero,'') = ISNULL(@Cajero, ISNULL(d.Cajero,''))
       AND ISNULL(d.Corte,ISNULL(@IDCorte,0)) = ISNULL(@IDCorte, ISNULL(d.Corte,0))
     GROUP BY d.Mov, m.Clave, m.SubClave, d.ConDesglose, CASE d.ConDesglose WHEN 0 THEN ISNULL(d.FormaPago, '') ELSE ISNULL(dd.FormaPago, '') END, d.Moneda, d.TipoCambio, d.Corte

  
  INSERT @Tabla(Estacion, Columna1, Columna2, Columna3, Columna4, Columna5, Columna6, Columna7, Columna8, Columna9, Columna10, Tipo, Moneda, TipoCambio, Columna4MC, Columna5MC)
  SELECT		@Estacion,
				RTRIM(ISNULL(d.Origen, '')) + ' ' + RTRIM(ISNULL(d.OrigenID, '')),
				RTRIM(ISNULL(d.Mov, '')) + ' ' + RTRIM(ISNULL(d.MovID, '')),
				CONVERT(varchar,d.FechaRegistro, 120),
				CASE m.Clave 
				  WHEN 'DIN.A'	 THEN CASE WHEN d.ConDesglose = 0 THEN CONVERT(varchar,CONVERT(money,d.Importe),1) ELSE CONVERT(varchar,CONVERT(money,dd.Importe),1) END
				  WHEN 'DIN.AP'  THEN CASE WHEN d.ConDesglose = 0 THEN CONVERT(varchar,CONVERT(money,d.Importe),1) ELSE CONVERT(varchar,CONVERT(money,dd.Importe),1) END
				  WHEN 'DIN.I'   THEN CASE WHEN d.ConDesglose = 0 THEN CONVERT(varchar,CONVERT(money,d.Importe),1) ELSE CONVERT(varchar,CONVERT(money,dd.Importe),1) END
				  WHEN 'DIN.TC'  THEN CASE WHEN d.ConDesglose = 0 THEN CASE WHEN d.CtaDineroDestino = @Caja THEN CONVERT(varchar,CONVERT(money,d.Importe),1) ELSE CONVERT(varchar,CONVERT(money,dd.Importe),1) END END
				  ELSE NULL	 END Abono,
				CASE m.Clave 
				  WHEN 'DIN.CP'	 THEN CASE WHEN d.ConDesglose = 0 THEN CONVERT(varchar,CONVERT(money,d.Importe),1) ELSE CONVERT(varchar,CONVERT(money,dd.Importe),1) END
				  WHEN 'DIN.C'   THEN CASE WHEN d.ConDesglose = 0 THEN CONVERT(varchar,CONVERT(money,d.Importe),1) ELSE CONVERT(varchar,CONVERT(money,dd.Importe),1) END
				  WHEN 'DIN.F'   THEN CASE WHEN d.ConDesglose = 0 THEN CONVERT(varchar,CONVERT(money,d.Importe),1) ELSE CONVERT(varchar,CONVERT(money,dd.Importe),1) END
				  WHEN 'DIN.TC'  THEN CASE WHEN d.ConDesglose = 0 THEN CASE WHEN d.CtaDinero = @Caja THEN CONVERT(varchar,CONVERT(money,d.Importe),1) ELSE CONVERT(varchar,CONVERT(money,dd.Importe),1) END END
				  WHEN 'DIN.E'  THEN CASE WHEN d.ConDesglose = 0 THEN CONVERT(varchar,CONVERT(money,d.Importe),1) ELSE CONVERT(varchar,CONVERT(money,dd.Importe),1) END
				  ELSE NULL
				END Cargo,
				d.Referencia,
				CASE m.Clave 
				  WHEN 'DIN.A'	 THEN d.CtaDineroDestino
				  WHEN 'DIN.AP'  THEN d.CtaDineroDestino      
				  ELSE d.CtaDinero
				END Caja,
				CASE m.Clave 
				  WHEN 'DIN.A'	 THEN c.Descripcion
				  WHEN 'DIN.AP'  THEN c.Descripcion      
				  ELSE cd.Descripcion
				END CajaNombre,
				m.Clave,
				'',
				2,
				d.Moneda,
				CONVERT(money,d.TipoCambio),
				CASE m.Clave 
				  WHEN 'DIN.A'	 THEN CASE WHEN d.ConDesglose = 0 THEN CONVERT(varchar,CONVERT(money,d.Importe*d.TipoCambio),1) ELSE CONVERT(varchar,CONVERT(money,dd.Importe*d.TipoCambio),1) END
				  WHEN 'DIN.AP'  THEN CASE WHEN d.ConDesglose = 0 THEN CONVERT(varchar,CONVERT(money,d.Importe*d.TipoCambio),1) ELSE CONVERT(varchar,CONVERT(money,dd.Importe*d.TipoCambio),1) END
				  WHEN 'DIN.I'   THEN CASE WHEN d.ConDesglose = 0 THEN CONVERT(varchar,CONVERT(money,d.Importe*d.TipoCambio),1) ELSE CONVERT(varchar,CONVERT(money,dd.Importe*d.TipoCambio),1) END
				  ELSE NULL	 END AbonoMC,
				CASE m.Clave 
				  WHEN 'DIN.CP'	 THEN CASE WHEN d.ConDesglose = 0 THEN CONVERT(varchar,CONVERT(money,d.Importe*d.TipoCambio),1) ELSE CONVERT(varchar,CONVERT(money,dd.Importe*d.TipoCambio),1) END
				  WHEN 'DIN.C'   THEN CASE WHEN d.ConDesglose = 0 THEN CONVERT(varchar,CONVERT(money,d.Importe*d.TipoCambio),1) ELSE CONVERT(varchar,CONVERT(money,dd.Importe*d.TipoCambio),1) END
				  WHEN 'DIN.F'   THEN CASE WHEN d.ConDesglose = 0 THEN CONVERT(varchar,CONVERT(money,d.Importe*d.TipoCambio),1) ELSE CONVERT(varchar,CONVERT(money,dd.Importe*d.TipoCambio),1) END
				  WHEN 'DIN.TC'  THEN CASE WHEN d.ConDesglose = 0 THEN CONVERT(varchar,CONVERT(money,d.Importe*d.TipoCambio),1) ELSE CONVERT(varchar,CONVERT(money,dd.Importe*d.TipoCambio),1) END
				  WHEN 'DIN.E'  THEN CASE WHEN d.ConDesglose = 0 THEN CONVERT(varchar,CONVERT(money,d.Importe*d.TipoCambio),1) ELSE CONVERT(varchar,CONVERT(money,dd.Importe*d.TipoCambio),1) END
				  ELSE NULL
				END CargoMC
				
    FROM Dinero d
    LEFT OUTER JOIN DineroD dd ON d.ID = dd.ID
    JOIN MovTipo m ON d.Mov = m.Mov AND m.Modulo = 'DIN'
    LEFT OUTER JOIN Agente a ON d.Cajero = a.Agente
    LEFT OUTER JOIN CtaDinero c ON d.CtaDineroDestino = c.CtaDinero
    LEFT OUTER JOIN CtaDinero cd ON d.CtaDinero = cd.CtaDinero
   WHERE d.Estatus = 'CONCLUIDO' 
     AND (d.Corte > 0 OR d.CorteDestino > 0)
     AND m.Clave IN('DIN.A', 'DIN.AP', 'DIN.C', 'DIN.CP', 'DIN.F', 'DIN.I', 'DIN.E', 'DIN.TC')
	 AND CASE WHEN m.Clave IN('DIN.A','DIN.C', 'DIN.CP') THEN CASE WHEN m.SubClave IS NOT NULL THEN 1 ELSE 0 END ELSE 0 END = 0
     AND dbo.fnFechaSinHora(d.FechaRegistro) = @Fecha
     AND CASE m.Clave WHEN 'DIN.A' THEN d.CtaDineroDestino WHEN 'DIN.AP' THEN d.CtaDineroDestino WHEN 'DIN.TC' THEN @Caja ELSE d.CtaDinero END = @Caja
     AND ISNULL(d.Cajero,'') = ISNULL(@Cajero, ISNULL(d.Cajero,''))
     AND ISNULL(d.Corte,ISNULL(@IDCorte,0)) = ISNULL(@IDCorte, ISNULL(d.Corte,0))

  DECLARE crMoneda CURSOR FOR
   SELECT DISTINCT Moneda, TipoCambio
     FROM @Tabla
    WHERE Moneda IS NOT NULL

  OPEN crMoneda
  FETCH NEXT FROM crMoneda INTO @Moneda, @TipoCambio
  WHILE @@FETCH_STATUS = 0
  BEGIN
    SELECT @TipoCambio2 = @TipoCambio
    IF @TipoCambio NOT IN('1', '1.00')
      SELECT @TipoCambio = ' - T/C ' + @TipoCambio
    ELSE
      SELECT @TipoCambio = ''

    INSERT @Tabla(Estacion, TituloColumna1, TituloColumna2, TituloColumna3, TituloColumna4, TituloColumna5, TituloColumna6, TituloColumna7, TituloColumna8, TituloColumna9, TituloColumna10, TituloColumna11,  Tipo, Moneda)
    SELECT		@Estacion, 'Origen', 'Movimiento', 'Fecha Registro', 'Ingresos', 'Egresos', 'Referencia', '', '', 'Clave', 'Corte al Día', 'Detalle de movimientos', 1, NULL

    INSERT @Tabla(Estacion, TituloColumna1, TituloColumna2,     TituloColumna3, TituloColumna4, TituloColumna5,  TituloColumna6, TituloColumna7, TituloColumna8, TituloColumna9, TituloColumna10, TituloColumna11,             Tipo, Moneda)
    SELECT		@Estacion, 'Forma de Pago', 'Apertura/Aumento', 'Ingreso',      'Egreso',       'Corte Parcial', 'Corte',        'Faltante',     'Sobrante',     'Caja',         'Clave',         'Detalle por forma de pago', 3,    NULL

    INSERT @Tabla(Estacion, Columna1,	             Tipo, Moneda,                            TipoCambio,  TipoCambio2,  Orden)
    SELECT		 @Estacion, @TipoCambio,             4,   @Moneda,                            @TipoCambio, @TipoCambio2, 1
     UNION 
    SELECT		 @Estacion, FormaPago + @TipoCambio, 4,   ISNULL(NULLIF(Moneda,''), @Moneda), @TipoCambio, @TipoCambio2, 1
      FROM FormaPago
     WHERE ISNULL(NULLIF(Moneda,''), @Moneda) = @Moneda

    FETCH NEXT FROM crMoneda INTO @Moneda, @TipoCambio
  END
  CLOSE crMoneda
  DEALLOCATE crMoneda

  DECLARE crFormaPago CURSOR FOR
   SELECT Columna1, Moneda, TipoCambio, TipoCambio2
     FROM @Tabla
    WHERE Tipo = 4
    GROUP BY Columna1, Moneda, TipoCambio, TipoCambio2

  OPEN crFormaPago
  FETCH NEXT FROM crFormaPago INTO @FormaPago, @Moneda, @TipoCambio, @TipoCambio2
  WHILE @@FETCH_STATUS = 0
  BEGIN

    SELECT @FormaPago2 = @FormaPago
    IF @TipoCambio NOT IN('1', '1.00', '')
      SELECT @FormaPago = REPLACE(@FormaPago, @TipoCambio, '')

    SELECT @Importe = NULL, @ImporteMC = NULL
    SELECT @Importe = SUM(Importe),
           @ImporteMC = SUM(ImporteMC)
      FROM @TablaFormaPago
     WHERE Estacion = @Estacion
       AND Clave IN ('DIN.A', 'DIN.AP')
       AND FormaPago = @FormaPago
       AND Moneda = @Moneda
       AND TipoCambio = @TipoCambio2
     GROUP BY FormaPago

    IF @Importe IS NOT NULL
      UPDATE @Tabla
         SET Columna2 = CONVERT(varchar,CONVERT(money,ISNULL(@Importe, 0.00)),1),
             Columna2MC = CONVERT(varchar,CONVERT(money,ISNULL(@ImporteMC, 0.00)),1)
       WHERE Tipo = 4 
         AND Columna1 = @FormaPago2
         AND Moneda = @Moneda
         AND TipoCambio2 = @TipoCambio2

    SELECT @Importe = NULL, @ImporteMC = NULL
    SELECT @Importe= SUM(ISNULL(Importe, 0.00)),
           @ImporteMC = SUM(ISNULL(ImporteMC, 0.00))
      FROM @TablaFormaPago
     WHERE Estacion = @Estacion
       AND Clave ='DIN.I'
       AND SubClave <> 'DIN.S'
       AND FormaPago = @FormaPago
       AND Moneda = @Moneda
       AND TipoCambio = @TipoCambio2
     GROUP BY FormaPago

    IF NULLIF(@Importe, 0.00) IS NOT NULL
      UPDATE @Tabla
         SET Columna3 = CONVERT(varchar,CONVERT(money,ISNULL(@Importe, 0.00)),1),
             Columna3MC = CONVERT(varchar,CONVERT(money,ISNULL(@ImporteMC, 0.00)),1)         
       WHERE Tipo = 4 
         AND Columna1 = @FormaPago2
         AND Moneda = @Moneda
         AND TipoCambio2 = @TipoCambio2
     
    SELECT @Importe = NULL, @ImporteMC = NULL
    SELECT @Importe= SUM(ISNULL(Importe, 0.00)),
           @ImporteMC = SUM(ISNULL(ImporteMC, 0.00))
      FROM @TablaFormaPago
     WHERE Estacion = @Estacion
       AND Clave IN ('DIN.E', 'DIN.TC')
       AND FormaPago = @FormaPago
       AND Moneda = @Moneda
       AND TipoCambio = @TipoCambio2
     GROUP BY FormaPago    

    IF @Importe IS NOT NULL
      UPDATE @Tabla
         SET Columna4 = CONVERT(varchar,CONVERT(money,ISNULL(@Importe, 0.00)),1),
             Columna4MC = CONVERT(varchar,CONVERT(money,ISNULL(@ImporteMC, 0.00)),1)
       WHERE Tipo = 4 
         AND Columna1 = @FormaPago2
         AND Moneda = @Moneda
         AND TipoCambio2 = @TipoCambio2

    SELECT @Importe = NULL, @ImporteMC = NULL
    SELECT @Importe = SUM(Importe),
           @ImporteMC = SUM(ImporteMC)
      FROM @TablaFormaPago
     WHERE Estacion = @Estacion
       AND Clave IN ('DIN.CP')
       AND FormaPago = @FormaPago
       AND Moneda = @Moneda
       AND TipoCambio = @TipoCambio2
     GROUP BY FormaPago

    IF @Importe IS NOT NULL
      UPDATE @Tabla
         SET Columna5 = CONVERT(varchar,CONVERT(money,ISNULL(@Importe, 0.00)),1),
             Columna5MC = CONVERT(varchar,CONVERT(money,ISNULL(@ImporteMC, 0.00)),1)
       WHERE Tipo = 4 
         AND Columna1 = @FormaPago2
         AND Moneda = @Moneda
         AND TipoCambio2 = @TipoCambio2

    SELECT @Importe = NULL, @ImporteMC = NULL
    SELECT @Importe = SUM(Importe),
           @ImporteMC = SUM(ImporteMC)
      FROM @TablaFormaPago
     WHERE Estacion = @Estacion
       AND Clave IN ('DIN.C')
       AND FormaPago = @FormaPago
       AND Moneda = @Moneda
       AND TipoCambio = @TipoCambio2
     GROUP BY FormaPago

    IF @Importe IS NOT NULL
      UPDATE @Tabla
         SET Columna6 = CONVERT(varchar,CONVERT(money,ISNULL(@Importe, 0.00)),1),
             Columna6MC = CONVERT(varchar,CONVERT(money,ISNULL(@ImporteMC, 0.00)),1)
       WHERE Tipo = 4 
         AND Columna1 = @FormaPago2
         AND Moneda = @Moneda
         AND TipoCambio2 = @TipoCambio2

    SELECT @Importe = NULL, @ImporteMC = NULL
    SELECT @Importe = SUM(Importe),
           @ImporteMC = SUM(ImporteMC)
      FROM @TablaFormaPago
     WHERE Estacion = @Estacion
       AND Clave IN ('DIN.F')
       AND FormaPago = @FormaPago
       AND Moneda = @Moneda
       AND TipoCambio = @TipoCambio2
     GROUP BY FormaPago

    IF @Importe IS NOT NULL
      UPDATE @Tabla
         SET Columna7 = CONVERT(varchar,CONVERT(money,ISNULL(@Importe, 0.00)),1),
             Columna7MC = CONVERT(varchar,CONVERT(money,ISNULL(@ImporteMC, 0.00)),1)
       WHERE Tipo = 4 
         AND Columna1 = @FormaPago2
         AND Moneda = @Moneda
         AND TipoCambio2 = @TipoCambio2

    SELECT @Importe = NULL, @ImporteMC = NULL
    SELECT @Importe = SUM(Importe),
           @ImporteMC = SUM(ImporteMC)
      FROM @TablaFormaPago
     WHERE Estacion = @Estacion
       AND Clave = 'DIN.I'
       AND SubClave = 'DIN.S'
       AND FormaPago = @FormaPago
       AND Moneda = @Moneda
       AND TipoCambio = @TipoCambio2
     GROUP BY FormaPago

    IF @Importe IS NOT NULL
      UPDATE @Tabla
         SET Columna8 = CONVERT(varchar,CONVERT(money,ISNULL(@Importe, 0.00)),1),
             Columna8MC = CONVERT(varchar,CONVERT(money,ISNULL(@ImporteMC, 0.00)),1)
       WHERE Tipo = 4 
         AND Columna1 = @FormaPago2
         AND Moneda = @Moneda
         AND TipoCambio2 = @TipoCambio2
      
    FETCH NEXT FROM crFormaPago INTO @FormaPago, @Moneda, @TipoCambio, @TipoCambio2
  END
  CLOSE crFormaPago
  DEALLOCATE crFormaPago
  
  UPDATE @Tabla
     SET Columna11 = CONVERT(varchar,CONVERT(money,ISNULL(ISNULL(CONVERT(money,Columna2),0.0) + ISNULL(CONVERT(money,Columna3),0.0) - ISNULL(CONVERT(money,Columna4),0.0), 0.00)),1),
         Columna11MC = CONVERT(varchar,CONVERT(money,ISNULL(ISNULL(CONVERT(money,Columna2MC),0.0) + ISNULL(CONVERT(money,Columna3MC),0.0) - ISNULL(CONVERT(money,Columna4MC),0.0), 0.00)),1)
   WHERE Tipo = 4 

  DELETE @Tabla 
   WHERE Tipo = 4 
     AND(Columna1 IS NOT NULL AND Columna2 IS NULL AND Columna3 IS NULL AND Columna4 IS NULL AND Columna5 IS NULL
     AND Columna6 IS NULL AND Columna7 IS NULL AND  Columna8 IS NULL AND  Columna9 IS NULL AND  Columna10 IS NULL)

  INSERT @Tabla(Estacion, Columna1, Columna2, Columna3, Columna4, Columna5, Columna6, Columna7, Columna8, Columna9, Columna10, Tipo, Moneda)
  SELECT		
    @Estacion, 
    'Total',
    CONVERT(varchar,SUM(CONVERT(money,Columna2)),1),
    CONVERT(varchar,SUM(CONVERT(money,Columna3)),1),
    CONVERT(varchar,SUM(CONVERT(money,Columna4)),1),
    CONVERT(varchar,SUM(CONVERT(money,Columna5)),1),
    CONVERT(varchar,SUM(CONVERT(money,Columna6)),1),
    CONVERT(varchar,SUM(CONVERT(money,Columna7)),1),
    CONVERT(varchar,SUM(CONVERT(money,Columna8)),1),
    CONVERT(varchar,SUM(CONVERT(money,Columna9)),1),
    CONVERT(varchar,SUM(CONVERT(money,Columna10)),1),    
    6,
    @Moneda
    FROM @Tabla 
   WHERE Tipo = 4
  
  INSERT @Tabla(Estacion, Columna1, Columna2MC, Columna3MC, Columna4MC, Columna5MC, Columna6MC, Columna7MC, Columna8MC, Columna9MC, Columna10MC, Tipo, Moneda, MonedaMC, Orden)
  SELECT		
    @Estacion, 
    'Gran Total ' + @ContMoneda,
    CONVERT(varchar,SUM(CONVERT(money,Columna2MC)),1),
    CONVERT(varchar,SUM(CONVERT(money,Columna3MC)),1),
    CONVERT(varchar,SUM(CONVERT(money,Columna4MC)),1),
    CONVERT(varchar,SUM(CONVERT(money,Columna5MC)),1),
    CONVERT(varchar,SUM(CONVERT(money,Columna6MC)),1),
    CONVERT(varchar,SUM(CONVERT(money,Columna7MC)),1),
    CONVERT(varchar,SUM(CONVERT(money,Columna8MC)),1),
    CONVERT(varchar,SUM(CONVERT(money,Columna9MC)),1),
    CONVERT(varchar,SUM(CONVERT(money,Columna10MC)),1),    
    7,
    'ZZZZZ',
    @ContMoneda,
    2
    FROM @Tabla 
   WHERE Tipo = 4

  DECLARE crGrafica CURSOR FOR
   SELECT Columna1
     FROM @Tabla
    WHERE Tipo = 4
    
  OPEN crGrafica
  FETCH NEXT FROM crGrafica INTO @GraficaDescripcion
  WHILE @@FETCH_STATUS = 0
  BEGIN
  
    SELECT @Columna2 = Columna2MC, @Columna3 = Columna3MC, @Columna4 = Columna4MC, @Columna5 = Columna5MC, @Columna6 = Columna6MC, @Columna7 = Columna7MC
      FROM @Tabla 
     WHERE Tipo = 4
       AND Columna1 = @GraficaDescripcion

    IF @Columna2 IS NOT NULL
      INSERT @Tabla(Estacion, Tipo, Grafica, GraficaDescripcion,  GraficaSerie, GraficaImporte)
      SELECT		@Estacion, 6,   1,       @GraficaDescripcion, 'Apertura',   @Columna2
  
    IF @Columna3 IS NOT NULL
      INSERT @Tabla(Estacion, Tipo, Grafica, GraficaDescripcion,  GraficaSerie, GraficaImporte)
      SELECT		@Estacion, 6,   1,       @GraficaDescripcion, 'Ingreso',    @Columna3
  
    IF @Columna4 IS NOT NULL
      INSERT @Tabla(Estacion, Tipo, Grafica, GraficaDescripcion,  GraficaSerie,    GraficaImporte)
      SELECT		@Estacion, 6,   1,       @GraficaDescripcion, 'Corte Parcial', @Columna4
  
    IF @Columna5 IS NOT NULL
      INSERT @Tabla(Estacion, Tipo, Grafica, GraficaDescripcion,  GraficaSerie, GraficaImporte)
      SELECT		@Estacion, 6,   1,       @GraficaDescripcion, 'Corte',      @Columna5
  
    IF @Columna6 IS NOT NULL
      INSERT @Tabla(Estacion, Tipo, Grafica, GraficaDescripcion,  GraficaSerie, GraficaImporte)
      SELECT		@Estacion, 6,   1,       @GraficaDescripcion, 'Faltante',   @Columna6
  
    IF @Columna7 IS NOT NULL
      INSERT @Tabla(Estacion, Tipo, Grafica, GraficaDescripcion,  GraficaSerie, GraficaImporte)
      SELECT		@Estacion, 6,   1,       @GraficaDescripcion, 'Sobrante',   @Columna7
    
    FETCH NEXT FROM crGrafica INTO @GraficaDescripcion
  END
  CLOSE crGrafica
  DEALLOCATE crGrafica
    
--  SELECT * FROM @Tabla ORDER BY Tipo, Grafica
  SELECT @Graficar = COUNT(DISTINCT GraficaDescripcion)
    FROM @Tabla
   WHERE Estacion = @Estacion
     AND Grafica = 1

--  SELECT @GraficarTipo, @Graficar, @GraficarCantidad
  IF @GraficarTipo = 'Mas Sobresalientes' AND @Graficar > @GraficarCantidad
    DELETE @Tabla 
     WHERE Grafica = 1 
       AND GraficaDescripcion NOT IN(
           SELECT  TOP (@GraficarCantidad) GraficaDescripcion
           FROM(SELECT 'GraficaDescripcion'  = GraficaDescripcion, 'GraficaImporte'      = SUM(GraficaImporte)
                  FROM @Tabla
                 WHERE Estacion = @Estacion AND Grafica = 1
                 GROUP BY GraficaDescripcion) AS x       
     GROUP BY x.GraficaDescripcion
     ORDER BY SUM(ISNULL(x.GraficaImporte,0.00))DESC)

  IF @GraficarTipo = 'Menos Sobresalientes' AND @Graficar > @GraficarCantidad
    DELETE @Tabla 
     WHERE Grafica = 1 
       AND GraficaDescripcion NOT IN(
           SELECT  TOP (@GraficarCantidad) GraficaDescripcion
             FROM(SELECT 'GraficaDescripcion'  = GraficaDescripcion, 'GraficaImporte'      = SUM(GraficaImporte)
                    FROM @Tabla
                   WHERE Estacion = @Estacion AND Grafica = 1
             GROUP BY GraficaDescripcion) AS x       
     GROUP BY x.GraficaDescripcion
     ORDER BY SUM(ISNULL(x.GraficaImporte,0.00))ASC)


  SELECT @CajeroNombre = Nombre FROM Agente WHERE Agente = @Cajero
  SELECT @CajaNombre = MIN(Columna8) FROM @Tabla WHERE Tipo = 2
  SELECT @FechaSinHora = SUBSTRING(CONVERT(varchar, @Fecha, 6),1,12)
  SELECT @EmpresaNombre = Nombre FROM Empresa WHERE Empresa = @Empresa

  UPDATE @Tabla
     SET Columna7 = '',
         Columna8 = ''
    FROM @Tabla 
   WHERE Tipo = 2

  UPDATE @Tabla
     SET MonedaMC = '1'
   WHERE Moneda = (SELECT TOP 1 Moneda FROM @Tabla WHERE Moneda <> 'ZZZZZ' GROUP BY Moneda ORDER BY Moneda DESC)
   
  UPDATE @Tabla
  SET Titulo1 = @Caja,
      Titulo2 = ISNULL(@Cajero, '(Todos)'),
      Titulo3 = @CajaNombre,
      Titulo4 = @CajeroNombre,
      Titulo5 = @FechaSinHora,
--      Titulo6 = @Hora,
      Titulo7 = @EmpresaNombre

  UPDATE @Tabla 
     SET TituloColumna1 = 'Origen',
         TituloColumna2 = 'Movimiento',
         TituloColumna3 = 'Fecha Registro',
         TituloColumna4 = 'Ingresos',
         TituloColumna5 = 'Egresos',
         TituloColumna6 = 'Referencia',
         TituloColumna7 = '',
         TituloColumna8 = '',
         TituloColumna9 = 'Clave',
         TituloColumna10 = 'Corte al Día',
         TituloColumna11 = 'Detalle de movimientos'
   WHERE Tipo = 2

  UPDATE @Tabla 
     SET TituloColumna1 = 'Forma de Pago',
         TituloColumna2 = 'Apertura/Aumento',
         TituloColumna3 = 'Ingreso',
         TituloColumna4 = 'Egreso',
         TituloColumna5 = 'Corte Parcial',
         TituloColumna6 = 'Corte',
         TituloColumna7 = 'Faltante',
         TituloColumna8 = 'Sobrante',
         TituloColumna9 = 'Caja',
         TituloColumna10 = 'Clave',
         TituloColumna11 = 'Detalle por forma de pago'
   WHERE Tipo = 4

  SELECT *, @VerGraficaDetalle as VerGraficaDetalle FROM @Tabla ORDER BY Grafica, Tipo, Moneda
  
END
GO
--update RepParam set infocaja = 'CAJA1', Infocajero = 'CAJERO1', InfoFechaDia = '2011-18-07 14:43:25.560'
--update RepParam set infocaja = 'IZCAJAV', Infocajero = 'IPAREDESC', InfoFechaDia = '2010-03-11 00:00:00.000'
--update RepParam set infocaja = 'PUCAJAV', Infocajero = 'BHERRERAE', InfoFechaDia = '2010-02-12 00:00:00.000'
--EXEC spCorteCajaInforme 1

/******************************* spDineroAcum *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spDineroAcum') and type = 'P') drop procedure dbo.spDineroAcum
GO             
CREATE PROCEDURE spDineroAcum
		@EstacionTrabajo		int

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @Empresa					varchar(5),
  @CtaDineroD				varchar(10),
  @CtaDineroA				varchar(10),
  @Moneda					varchar(10),
  @Ejercicio				int,	
  @Titulo					varchar(100),
  @Usuario					varchar(10),
  @MonedaInicial			varchar(10),
  @CuentaInicial			varchar(10),
  @AcumMoneda				varchar(10),
  @AcumCuenta				varchar(10),
  @EjercicioCursor			int,
  @PeriodoCursor			int,
  @Cargos					float,
  @Abonos					float,
  @CargosAcumulados			float,
  @AbonosAcumulados			float,
  @SaldoFinalAcumulado		float,
  @CargosMC					float,
  @AbonosMC					float,
  @CargosAcumuladosMC		float,
  @AbonosAcumuladosMC		float,
  @SaldoFinalAcumuladoMC	float,
  @ID						int,
  @Descripcion				varchar(100),
  @Rama						varchar(10),
  @ContMoneda				varchar(10),
  @EmpresaNombre			varchar(100),
    @VerGraficaDetalle		bit

  SELECT
    @Empresa		=	InfoEmpresa,
    @CtaDineroD		=   ISNULL(InfoCtaDineroD,''),
    @CtaDineroA		=   ISNULL(InfoCtaDineroA,''),    
    @Moneda         =	CASE WHEN InfoMoneda IN( '(Todas)', '') THEN NULL ELSE InfoMoneda END,
	@Ejercicio		=   InfoEjercicio,
	@Titulo         =   InfoTitulo,
	@Usuario        =   InfoUsuario,
    @VerGraficaDetalle = ISNULL(VerGraficaDetalle,0)
    FROM RepParam
   WHERE Estacion = @EstacionTrabajo

  SELECT @EmpresaNombre = Nombre FROM Empresa WHERE Empresa = @Empresa
  
  DECLARE @Datos TABLE
  (
   Estacion					int NOT NULL,
   ID						int identity(1,1) NOT NULL,
   CtaDinero				varchar(10) COLLATE DATABASE_DEFAULT NULL,   
   Descripcion				varchar(100) COLLATE DATABASE_DEFAULT NULL,
   Tipo						varchar(20) COLLATE DATABASE_DEFAULT NULL,   
   Uso						varchar(20) COLLATE DATABASE_DEFAULT NULL, 
   NumeroCta				varchar(100) COLLATE DATABASE_DEFAULT NULL,        
   CuentaHabiente			varchar(100) COLLATE DATABASE_DEFAULT NULL,           
   Moneda					varchar(10) COLLATE DATABASE_DEFAULT NULL,
   Beneficiario				int NULL,
   Estatus					varchar(15) COLLATE DATABASE_DEFAULT NULL, 
   UltimoCambio				datetime NULL,
   Alta						datetime NULL,   
   Conciliar				bit NULL,
   Mensaje					varchar(50) COLLATE DATABASE_DEFAULT NULL,   
   Sucursal					int NULL,
   Empresa					varchar(5) COLLATE DATABASE_DEFAULT NULL, 
   Rama						varchar(5) COLLATE DATABASE_DEFAULT NULL,    
   Cuenta					varchar(20) COLLATE DATABASE_DEFAULT NULL,       
   SubCuenta				varchar(50) COLLATE DATABASE_DEFAULT NULL,       
   Grupo					varchar(10) COLLATE DATABASE_DEFAULT NULL,          
   Ejercicio				int NULL,
   Periodo					int NULL,
   PeriodoNombre			varchar(50) COLLATE DATABASE_DEFAULT NULL,          
   Cargos					float NULL,
   Abonos					float NULL,
   CargosMC					float NULL,
   AbonosMC					float NULL,   
   AcumUltimoCambio			datetime NULL,
   AcumMoneda				varchar(10) COLLATE DATABASE_DEFAULT NULL,
   SaldoFinal				float NULL,
   CargosAcumulados			float NULL,
   AbonosAcumulados			float NULL,
   SaldoFinalMC				float NULL,   
   CargosAcumuladosMC		float NULL,
   AbonosAcumuladosMC		float NULL,   
   ContMoneda				varchar(10) NULL,
   Grafica					int NULL DEFAULT 0,
   FiltroCtaDineroD			varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroCtaDineroA			varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroMoneda				varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroEjercicio			int NULL,
   EmpresaNombre			varchar(100) COLLATE DATABASE_DEFAULT NULL
  )    

  INSERT @Datos (Estacion, CtaDinero, Descripcion, Tipo, Uso, NumeroCta, CuentaHabiente, Moneda, Beneficiario, Estatus, UltimoCambio, Alta, Conciliar, Mensaje, Sucursal, Empresa, Rama, Cuenta, SubCuenta, Grupo, Ejercicio, Periodo, PeriodoNombre, Cargos, Abonos, CargosMC, AbonosMC, AcumUltimoCambio, AcumMoneda, ContMoneda, Grafica, FiltroCtaDineroD, FiltroCtaDineroA, FiltroMoneda, FiltroEjercicio, EmpresaNombre)
  SELECT
    @EstacionTrabajo,
    RTRIM(CtaDinero.CtaDinero),
    RTRIM(CtaDinero.Descripcion),
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    Acum.Empresa,
    Acum.Rama,
    Acum.Cuenta,
    NULL,
    NULL,
    @Ejercicio,
    0,
    RTRIM(dbo.fnIdiomaTraducir(@Usuario,'Saldo Inicial')),
    SUM(ISNULL(Acum.Cargos,0.0)),
    SUM(ISNULL(Acum.Abonos,0.0)),
    dbo.fnImporteAMonedaContable(SUM(ISNULL(Acum.Cargos,0.0)),ISNULL(Mon.TipoCambio,1.0),RTRIM(EmpresaCfg.ContMoneda)),    
    dbo.fnImporteAMonedaContable(SUM(ISNULL(Acum.Abonos,0.0)),ISNULL(Mon.TipoCambio,1.0),RTRIM(EmpresaCfg.ContMoneda)),        
    NULL,
    RTRIM(Acum.Moneda),
    RTRIM(EmpresaCfg.ContMoneda),
    1,
    ISNULL(@CtaDineroD,''),
    ISNULL(@CtaDineroA,''),
    ISNULL(@Moneda,'(Todas)'),
    @Ejercicio,
    @EmpresaNombre    
  FROM
    CtaDinero JOIN Acum 
    ON @Empresa =Acum.Empresa AND 'DIN'=Acum.Rama AND CtaDinero.CtaDinero=Acum.Cuenta JOIN Mon
    ON Mon.Moneda = Acum.Moneda JOIN EmpresaCfg
    ON Acum.Empresa = EmpresaCfg.Empresa
 WHERE Acum.Ejercicio < @Ejercicio
   AND Acum.Cuenta BETWEEN @CtaDineroD AND @CtaDineroA
   AND Acum.Moneda = ISNULL(@Moneda,Acum.Moneda)
 GROUP BY RTRIM(CtaDinero.CtaDinero), RTRIM(CtaDinero.Descripcion), Acum.Empresa, Acum.Rama, Acum.Cuenta, RTRIM(Acum.Moneda), Mon.TipoCambio, RTRIM(EmpresaCfg.ContMoneda)
   
  INSERT @Datos (Estacion, CtaDinero, Descripcion, Tipo, Uso, NumeroCta, CuentaHabiente, Moneda, Beneficiario, Estatus, UltimoCambio, Alta, Conciliar, Mensaje, Sucursal, Empresa, Rama, Cuenta, SubCuenta, Grupo, Ejercicio, Periodo, PeriodoNombre, Cargos, Abonos, CargosMC, AbonosMC, AcumUltimoCambio, AcumMoneda, ContMoneda, Grafica, FiltroCtaDineroD, FiltroCtaDineroA, FiltroMoneda, FiltroEjercicio, EmpresaNombre)
  SELECT
    @EstacionTrabajo,
    RTRIM(CtaDinero.CtaDinero),
    RTRIM(CtaDinero.Descripcion),
    CtaDinero.Tipo,
    CtaDinero.Uso,
    CtaDinero.NumeroCta,
    CtaDinero.CuentaHabiente,
    CtaDinero.Moneda,
    CtaDinero.Beneficiario,
    CtaDinero.Estatus,
    CtaDinero.UltimoCambio,
    CtaDinero.Alta,
    CtaDinero.Conciliar,
    CtaDinero.Mensaje,
    Acum.Sucursal,
    Acum.Empresa,
    Acum.Rama,
    Acum.Cuenta,
    Acum.SubCuenta,
    Acum.Grupo,
    Acum.Ejercicio,
    Acum.Periodo,
    dbo.fnPeriodoNombre(Acum.Periodo,@Usuario),
    Acum.Cargos,
    Acum.Abonos,
    dbo.fnImporteAMonedaContable(ISNULL(Acum.Cargos,0.0),ISNULL(Mon.TipoCambio,1.0),EmpresaCfg.ContMoneda),    
    dbo.fnImporteAMonedaContable(ISNULL(Acum.Abonos,0.0),ISNULL(Mon.TipoCambio,1.0),EmpresaCfg.ContMoneda),            
    Acum.UltimoCambio,
    RTRIM(Acum.Moneda),
    RTRIM(EmpresaCfg.ContMoneda),
    1,
    ISNULL(@CtaDineroD,''),
    ISNULL(@CtaDineroA,''),
    ISNULL(@Moneda,'(Todas)'),
    @Ejercicio,
    @EmpresaNombre        
  FROM
    CtaDinero JOIN Acum 
    ON @Empresa =Acum.Empresa AND 'DIN'=Acum.Rama AND CtaDinero.CtaDinero=Acum.Cuenta JOIN Mon
    ON Mon.Moneda = Acum.Moneda JOIN EmpresaCfg
    ON Acum.Empresa = EmpresaCfg.Empresa
 WHERE Acum.Ejercicio = @Ejercicio
   AND Acum.Cuenta BETWEEN @CtaDineroD AND @CtaDineroA
   AND Acum.Moneda = ISNULL(@Moneda,Acum.Moneda)

  DECLARE crDatos CURSOR FOR
   SELECT RTRIM(Cuenta), RTRIM(AcumMoneda), RTRIM(ContMoneda), RTRIM(Descripcion), Rama
     FROM @Datos
    GROUP BY Cuenta, AcumMoneda, ContMoneda, Descripcion, Rama 
    ORDER BY Cuenta, AcumMoneda, ContMoneda, Descripcion, Rama

  OPEN crDatos
  FETCH NEXT FROM crDatos INTO @AcumCuenta, @AcumMoneda, @ContMoneda, @Descripcion, @Rama
  WHILE @@FETCH_STATUS = 0
  BEGIN
    IF NOT EXISTS(SELECT 1 FROM @Datos WHERE Cuenta = @AcumCuenta AND AcumMoneda = @AcumMoneda AND ContMoneda = @ContMoneda AND PeriodoNombre = dbo.fnIdiomaTraducir(@Usuario,'Saldo Inicial'))
    BEGIN
      INSERT @Datos (Estacion,         CtaDinero,   Descripcion,  Empresa,  Rama,  Cuenta,      Ejercicio,  Periodo, PeriodoNombre,                                  Cargos, Abonos, CargosMC, AbonosMC, AcumMoneda,  ContMoneda,  Grafica, FiltroCtaDineroD,       FiltroCtaDineroA,       FiltroMoneda,              FiltroEjercicio, EmpresaNombre)
             VALUES (@EstacionTrabajo, @AcumCuenta, @Descripcion, @Empresa, @Rama, @AcumCuenta, @Ejercicio, 0,       dbo.fnIdiomaTraducir(@Usuario,'Saldo Inicial'), 0.0,    0.0,    0.0,      0.0,      @AcumMoneda, @ContMoneda, 1,       ISNULL(@CtaDineroD,''), ISNULL(@CtaDineroA,''), ISNULL(@Moneda,'(Todas)'), @Ejercicio,      @EmpresaNombre)                     
    END
    FETCH NEXT FROM crDatos INTO @AcumCuenta, @AcumMoneda, @ContMoneda, @Descripcion, @Rama
  END
  CLOSE crDatos
  DEALLOCATE crDatos

  SELECT @MonedaInicial = '', @CuentaInicial = '', @CargosAcumulados = 0.0, @AbonosAcumulados = 0.0, @SaldoFinalAcumuladoMC = 0.0, @CargosAcumuladosMC = 0.0, @AbonosAcumuladosMC = 0.0, @SaldoFinalAcumuladoMC = 0.0
  DECLARE crDineroAcum CURSOR FOR
   SELECT ID, AcumMoneda, Cuenta, Ejercicio, Periodo, ISNULL(Cargos,0.0), ISNULL(Abonos,0.0), ISNULL(CargosMC,0.0), ISNULL(AbonosMC,0.0)  
     FROM @Datos
    ORDER BY AcumMoneda, Cuenta, Ejercicio, Periodo 

  OPEN crDineroAcum
  FETCH NEXT FROM crDineroAcum INTO @ID, @AcumMoneda, @AcumCuenta, @EjercicioCursor, @PeriodoCursor, @Cargos, @Abonos, @CargosMC, @AbonosMC
  WHILE @@FETCH_STATUS = 0
  BEGIN
    IF @AcumMoneda <> @MonedaInicial OR @AcumCuenta <> @CuentaInicial
    BEGIN
      SET @CargosAcumulados = 0.0
      SET @AbonosAcumulados = 0.0
      SET @CargosAcumuladosMC = 0.0
      SET @AbonosAcumuladosMC = 0.0      
      SET @SaldoFinalAcumulado = 0.0
      SET @MonedaInicial = @AcumMoneda
      SET @CuentaInicial = @AcumCuenta
    END     

    UPDATE @Datos 
       SET 
       SaldoFinal = @SaldoFinalAcumulado + (@Cargos - @Abonos), 
       CargosAcumulados = @CargosAcumulados + @Cargos, 
       AbonosAcumulados = @AbonosAcumulados + @Abonos,
       SaldoFinalMC = @SaldoFinalAcumuladoMC + (@CargosMC - @AbonosMC), 
       CargosAcumuladosMC = @CargosAcumuladosMC + @CargosMC, 
       AbonosAcumuladosMC = @AbonosAcumuladosMC + @AbonosMC        
     WHERE ID = @ID

    SET @SaldoFinalAcumulado = @SaldoFinalAcumulado + (@Cargos - @Abonos)
    SET @CargosAcumulados = @CargosAcumulados + @Cargos
    SET @AbonosAcumulados = @AbonosAcumulados + @Abonos
    SET @SaldoFinalAcumuladoMC = @SaldoFinalAcumuladoMC + (@CargosMC - @AbonosMC)
    SET @CargosAcumuladosMC = @CargosAcumuladosMC + @CargosMC
    SET @AbonosAcumuladosMC = @AbonosAcumuladosMC + @AbonosMC

    FETCH NEXT FROM crDineroAcum INTO @ID, @AcumMoneda, @AcumCuenta, @EjercicioCursor, @PeriodoCursor, @Cargos, @Abonos, @CargosMC, @AbonosMC            
  END
  CLOSE crDineroAcum
  DEALLOCATE crDineroAcum

  INSERT @Datos (Estacion, CtaDinero, Descripcion, Tipo, Uso, NumeroCta, CuentaHabiente, Moneda, Beneficiario, Estatus, UltimoCambio, Alta, Conciliar, Mensaje, Sucursal, Empresa, Rama, Cuenta, SubCuenta, Grupo, Ejercicio, Periodo, PeriodoNombre, Cargos, Abonos, CargosMC, AbonosMC, AcumUltimoCambio, AcumMoneda, ContMoneda, Grafica)
  SELECT
    Estacion,
    CtaDinero,
    Descripcion,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    Empresa,
    Rama,
    Cuenta,
    NULL,
    NULL,
    Ejercicio,
    Periodo,
    PeriodoNombre,
    NULL,
    NULL,
    SUM(CargosMC),    
    SUM(AbonosMC),        
    NULL,
    AcumMoneda,
    ContMoneda,
    2
  FROM
    @Datos
 GROUP BY Estacion, CtaDinero, Descripcion, Empresa, Rama, Cuenta, Ejercicio, Periodo, PeriodoNombre, AcumMoneda, ContMoneda
 ORDER BY Periodo
  
  SELECT @MonedaInicial = '', @CuentaInicial = '', @SaldoFinalAcumuladoMC = 0.0, @CargosAcumuladosMC = 0.0, @AbonosAcumuladosMC = 0.0, @SaldoFinalAcumuladoMC = 0.0
  DECLARE crDineroAcum CURSOR FOR
   SELECT ID, AcumMoneda, Cuenta, Ejercicio, Periodo, ISNULL(CargosMC,0.0), ISNULL(AbonosMC,0.0)  
     FROM @Datos
    WHERE Grafica = 2 
    ORDER BY AcumMoneda, Cuenta, Ejercicio, Periodo 

  OPEN crDineroAcum
  FETCH NEXT FROM crDineroAcum INTO @ID, @AcumMoneda, @AcumCuenta, @EjercicioCursor, @PeriodoCursor, @CargosMC, @AbonosMC
  WHILE @@FETCH_STATUS = 0
  BEGIN
    IF @AcumMoneda <> @MonedaInicial OR @AcumCuenta <> @CuentaInicial
    BEGIN
      SET @CargosAcumuladosMC = 0.0
      SET @AbonosAcumuladosMC = 0.0      
      SET @SaldoFinalAcumuladoMC = 0.0
      SET @MonedaInicial = @AcumMoneda
      SET @CuentaInicial = @AcumCuenta
    END     

    UPDATE @Datos 
       SET 
       SaldoFinalMC = @SaldoFinalAcumuladoMC + (@CargosMC - @AbonosMC), 
       CargosAcumuladosMC = @CargosAcumuladosMC + @CargosMC, 
       AbonosAcumuladosMC = @AbonosAcumuladosMC + @AbonosMC
     WHERE ID = @ID

    SET @SaldoFinalAcumuladoMC = @SaldoFinalAcumuladoMC + (@CargosMC - @AbonosMC)
    SET @CargosAcumuladosMC = @CargosAcumuladosMC + @CargosMC
    SET @AbonosAcumuladosMC = @AbonosAcumuladosMC + @AbonosMC

    FETCH NEXT FROM crDineroAcum INTO @ID, @AcumMoneda, @AcumCuenta, @EjercicioCursor, @PeriodoCursor, @CargosMC, @AbonosMC
  END
  CLOSE crDineroAcum
  DEALLOCATE crDineroAcum

  SELECT AcumMoneda, CtaDinero, Descripcion, Ejercicio, Periodo, PeriodoNombre, Cargos, Abonos, SaldoFinal, CargosAcumulados, AbonosAcumulados, CargosMC, AbonosMC, SaldoFinalMC, CargosAcumuladosMC, AbonosAcumuladosMC, ContMoneda, Grafica, FiltroCtaDineroD, FiltroCtaDineroA, FiltroMoneda, FiltroEjercicio, EmpresaNombre, @VerGraficaDetalle as VerGraficaDetalle
    FROM @Datos
   ORDER BY Grafica, Moneda, CtaDinero, Periodo, Ejercicio
END
GO
-- select * from acum where rama = 'din'
--update repparam SET INFOctadineroa='CITY', infomoneda = '(Todas)'
--exec spdineroacum 1


/******************************* spRepParamActualizarTitulo *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spRepParamActualizarTitulo') and type = 'P') drop procedure dbo.spRepParamActualizarTitulo
GO             
CREATE PROCEDURE spRepParamActualizarTitulo
		@EstacionTrabajo		int,
		@Titulo					varchar(100)

--//WITH ENCRYPTION
AS BEGIN

  UPDATE RepParam SET InfoTitulo = @Titulo WHERE Estacion = @EstacionTrabajo

END
GO



/******************************* spDineroAux *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spDineroAux') and type = 'P') drop procedure dbo.spDineroAux
GO             
CREATE PROCEDURE spDineroAux
		@EstacionTrabajo		int

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @InfoEmpresa				varchar(5),
  @InfoCtaDineroD			varchar(10),
  @InfoCtaDineroA			varchar(10),
  @InfoFechaD				datetime,
  @InfoFechaA				datetime,  
  @InfoUso					varchar(20),
  @InfoMov					varchar(20),
  @InfoNivel				varchar(20),
  @InfoMoneda				varchar(10),
  @InfoTitulo				varchar(100),
  @InfoUsuario				varchar(10),
  @MonedaInicial			varchar(10),
  @CuentaInicial			varchar(10),
  @MovInicial				varchar(20),    
  @ID						int,
  @Moneda					varchar(10),
  @Cuenta					varchar(10),
  @Fecha					datetime,
  @Cargos					float,
  @Abonos					float,
  @CargosMC					float,
  @AbonosMC					float,
  @Saldo					float,
  @SaldoMC					float,
  @Mov						varchar(20),
  @MovTotalCargos			float,
  @MovTotalAbonos			float,
  @MovTotalCargosMC			float,
  @MovTotalAbonosMC			float,
  @ContMoneda				varchar(10),
  @InformeGraficarTipo		varchar(30),
  @InformeGraficarCantidad	int,
  @EmpresaNombre			varchar(100),
  @Positivo					integer,
    @VerGraficaDetalle		bit

  
    
  SELECT
    @InfoEmpresa		     =	 InfoEmpresa,
    @InfoCtaDineroD		     =   ISNULL(InfoCtaDineroD,''),
    @InfoCtaDineroA		     =   ISNULL(InfoCtaDineroA,''),
    @InfoFechaD			     =   dbo.fnFechaSinHora(InfoFechaD),    
    @InfoFechaA			     =   dbo.fnFechaSinHora(InfoFechaA),        
    @InfoUso			     =	 CASE WHEN InfoUso IN( '(Todos)', '') THEN NULL ELSE InfoUso END,    
    @InfoMov			     =	 CASE WHEN InfoMov IN( '(Todos)', '') THEN NULL ELSE InfoMov END,        
    @InfoNivel			     =   ISNULL(InfoNivel,'Desglosado'),
    @InfoMoneda			     =	 CASE WHEN InfoMoneda IN( '(Todas)', '') THEN NULL ELSE InfoMoneda END,
    @InfoTitulo			     =   ISNULL(InfoTitulo,dbo.fnIdiomaTraducir(@InfoUsuario,'Tesorería - Auxiliar Movimientos Desglosado')),
	@InfoUsuario		     =   InfoUsuario,
	@InformeGraficarTipo     =   ISNULL(InformeGraficarTipo,'(Todos)'),
	@InformeGraficarCantidad =   ISNULL(NULLIF(InformeGraficarCantidad,0),5),
    @VerGraficaDetalle = ISNULL(VerGraficaDetalle,0)
    FROM RepParam
   WHERE Estacion = @EstacionTrabajo

  SELECT @ContMoneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @InfoEmpresa
  SELECT @EmpresaNombre = Nombre FROM Empresa WHERE Empresa = @InfoEmpresa
    
  DECLARE @Datos TABLE
  (
   Estacion					int NOT NULL,
   ID						int identity(1,1) NOT NULL,
   CtaDinero				varchar(10) COLLATE DATABASE_DEFAULT NULL,   
   NumeroCta				varchar(100) COLLATE DATABASE_DEFAULT NULL,   
   Descripcion				varchar(100) COLLATE DATABASE_DEFAULT NULL,
   Tipo						varchar(20) COLLATE DATABASE_DEFAULT NULL,   
   Uso						varchar(20) COLLATE DATABASE_DEFAULT NULL, 
   Moneda					varchar(10) COLLATE DATABASE_DEFAULT NULL,
   TipoCambio				float NULL,
   Beneficiario				varchar(100) COLLATE DATABASE_DEFAULT NULL,
   Fecha					datetime NULL,
   Movimiento				varchar(50) COLLATE DATABASE_DEFAULT NULL,
   Cargos					float NULL,
   Abonos					float NULL,
   Saldo					float NULL,
   CargosMC					float NULL,
   AbonosMC					float NULL,   
   SaldoMC					float NULL,      
   EsCancelacion			bit NULL DEFAULT 0,
   Grafica					int NULL DEFAULT 0,
   GraficaArgumento			varchar(20) COLLATE DATABASE_DEFAULT NULL,
   GraficaValor1			float,
   GraficaValor2			float,
   GraficaValor3			float,
   GraficaValor4			float,   
   GraficaPositivo			integer NULL DEFAULT 0,
   Titulo					varchar(50) COLLATE DATABASE_DEFAULT NULL,
   ContMoneda				varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroEmpresa			varchar(100) COLLATE DATABASE_DEFAULT NULL,
   FiltroCtaDineroD			varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroCtaDineroA			varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroFechaD				datetime NULL,
   FiltroFechaA				datetime NULL,
   FiltroUso				varchar(20) COLLATE DATABASE_DEFAULT NULL,
   FiltroMov				varchar(20) COLLATE DATABASE_DEFAULT NULL,
   FiltroNivel				varchar(20) COLLATE DATABASE_DEFAULT NULL,
   FiltroMoneda				varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroGraficarTipo		varchar(30) COLLATE DATABASE_DEFAULT NULL,
   FiltroGraficarCantidad	int NULL
  )    


  DECLARE @DatosGrafica TABLE
  (
   Estacion					int NOT NULL,
   ID						int identity(1,1) NOT NULL,
   CtaDinero				varchar(10) COLLATE DATABASE_DEFAULT NULL,   
   NumeroCta				varchar(100) COLLATE DATABASE_DEFAULT NULL,   
   Descripcion				varchar(100) COLLATE DATABASE_DEFAULT NULL,
   Tipo						varchar(20) COLLATE DATABASE_DEFAULT NULL,   
   Uso						varchar(20) COLLATE DATABASE_DEFAULT NULL, 
   Moneda					varchar(10) COLLATE DATABASE_DEFAULT NULL,
   TipoCambio				float NULL,
   Beneficiario				varchar(100) COLLATE DATABASE_DEFAULT NULL,
   Fecha					datetime NULL,
   Movimiento				varchar(50) COLLATE DATABASE_DEFAULT NULL,
   Cargos					float NULL,
   Abonos					float NULL,
   Saldo					float NULL,
   CargosMC					float NULL,
   AbonosMC					float NULL,   
   SaldoMC					float NULL,      
   EsCancelacion			bit NULL DEFAULT 0,
   Grafica					int NULL DEFAULT 0,
   GraficaArgumento			varchar(20) COLLATE DATABASE_DEFAULT NULL,
   GraficaValor1			float,
   GraficaValor2			float,
   GraficaValor3			float,
   GraficaValor4			float,   
   Titulo					varchar(50) COLLATE DATABASE_DEFAULT NULL,
   ContMoneda				varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroEmpresa			varchar(100) COLLATE DATABASE_DEFAULT NULL,   
   FiltroCtaDineroD			varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroCtaDineroA			varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroFechaD				datetime NULL,
   FiltroFechaA				datetime NULL,
   FiltroUso				varchar(20) COLLATE DATABASE_DEFAULT NULL,
   FiltroMov				varchar(20) COLLATE DATABASE_DEFAULT NULL,
   FiltroNivel				varchar(20) COLLATE DATABASE_DEFAULT NULL,
   FiltroMoneda				varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroGraficarTipo		varchar(30) COLLATE DATABASE_DEFAULT NULL,
   FiltroGraficarCantidad	int NULL
  )    

  -- Saldo Anterior
  INSERT @Datos (Estacion, CtaDinero, NumeroCta, Descripcion, Tipo, Uso, Moneda, TipoCambio, Beneficiario, Fecha, Movimiento, Cargos, Abonos, Saldo, CargosMC, AbonosMC, SaldoMC, EsCancelacion, Grafica, Titulo, ContMoneda, FiltroEmpresa, FiltroCtaDineroD, FiltroCtaDineroA, FiltroFechaD, FiltroFechaA, FiltroUso, FiltroMov, FiltroNivel, FiltroMoneda, FiltroGraficarTipo, FiltroGraficarCantidad)
  SELECT
    @EstacionTrabajo,
    RTRIM(c.CtaDinero),
    RTRIM(c.NumeroCta),
    RTRIM(c.Descripcion),
    NULL,
    NULL,
    c.Moneda,
    NULL,
    NULL,
    DATEADD(day,-1,@InfoFechaD),
    dbo.fnIdiomaTraducir(@InfoUsuario,'Saldo Inicial'),
    SUM(ISNULL(a.Cargo,0.0)),    
    SUM(ISNULL(a.Abono,0.0)),        
    NULL,
    SUM(ISNULL(a.Cargo,0.0)*ISNULL(a.TipoCambio,0)),    
    SUM(ISNULL(a.Abono,0.0)*ISNULL(a.TipoCambio,0)),        
    NULL,
    0,
    0,
    @InfoTitulo,
    @ContMoneda,
    @EmpresaNombre,    
    @InfoCtaDineroD,	
    @InfoCtaDineroA,	
    @InfoFechaD,		
    @InfoFechaA,		
    ISNULL(@InfoUso,'(Todos)'),		
    ISNULL(@InfoMov,'(Todos)'),		
    @InfoNivel,		
    ISNULL(@InfoMoneda,'(Todas)'),		    
    ISNULL(@InformeGraficarTipo,'(Todos)'),		        
    @InformeGraficarCantidad
  FROM
    CtaDinero c LEFT OUTER JOIN Auxiliar a 
    ON a.Empresa = @InfoEmpresa AND a.Rama = 'DIN' AND c.CtaDinero = a.Cuenta AND a.Fecha < @InfoFechaD AND a.Mov = ISNULL(@InfoMov,a.Mov) AND a.Moneda = ISNULL(@InfoMoneda,a.Moneda) LEFT OUTER JOIN Dinero d
    ON d.ID = a.ModuloID
 WHERE c.CtaDinero BETWEEN @InfoCtaDineroD AND @InfoCtaDineroA
   AND ISNULL(c.Uso,'') = ISNULL(@InfoUso,ISNULL(c.Uso,''))
 GROUP BY RTRIM(c.CtaDinero), RTRIM(c.NumeroCta), RTRIM(c.Descripcion), c.Moneda

 DELETE FROM @Datos WHERE ISNULL(Cargos,0.0) = 0.0 AND ISNULL(Abonos,0.0) = 0.0
     
  -- Movimientos Actuales
  INSERT @Datos (Estacion, CtaDinero, NumeroCta, Descripcion, Tipo, Uso, Moneda, TipoCambio, Beneficiario, Fecha, Movimiento, Cargos, Abonos, Saldo, CargosMC, AbonosMC, SaldoMC, EsCancelacion, Grafica, Titulo, GraficaArgumento, ContMoneda, FiltroEmpresa, FiltroCtaDineroD, FiltroCtaDineroA, FiltroFechaD, FiltroFechaA, FiltroUso, FiltroMov, FiltroNivel, FiltroMoneda, FiltroGraficarTipo, FiltroGraficarCantidad)
  SELECT
    @EstacionTrabajo,
    RTRIM(c.CtaDinero),
    RTRIM(c.NumeroCta),    
    RTRIM(c.Descripcion),
    c.Tipo,
    c.Uso,
    a.Moneda,
    a.TipoCambio,
    d.BeneficiarioNombre,
    a.Fecha,
    RTRIM(RTRIM(ISNULL(a.Mov,'')) + ' ' + RTRIM(ISNULL(a.MovID,''))),
    ISNULL(a.Cargo,0.0),    
    ISNULL(a.Abono,0.0),        
    NULL,
    ISNULL(a.Cargo,0.0)*ISNULL(a.TipoCambio,0),    
    ISNULL(a.Abono,0.0)*ISNULL(a.TipoCambio,0),        
    NULL,
    ISNULL(a.EsCancelacion,0),
    0,
    @InfoTitulo,
    RTRIM(ISNULL(a.Mov,'')),
    @ContMoneda,
    @EmpresaNombre,
    @InfoCtaDineroD,	
    @InfoCtaDineroA,	
    @InfoFechaD,		
    @InfoFechaA,		
    ISNULL(@InfoUso,'(Todos)'),		
    ISNULL(@InfoMov,'(Todos)'),		
    @InfoNivel,		
    ISNULL(@InfoMoneda,'(Todas)'),
    ISNULL(@InformeGraficarTipo,'(Todos)'),		        
    @InformeGraficarCantidad    		        
  FROM
    CtaDinero c JOIN Auxiliar a 
    ON a.Rama = 'DIN' AND c.CtaDinero = a.Cuenta JOIN Dinero d
    ON d.ID = a.ModuloID
 WHERE a.Empresa = @InfoEmpresa
   AND a.Cuenta BETWEEN @InfoCtaDineroD AND @InfoCtaDineroA
   AND a.Fecha BETWEEN @InfoFechaD AND @InfoFechaA
   AND ISNULL(c.Uso,'') = ISNULL(@InfoUso,ISNULL(c.Uso,''))
   AND a.Mov = ISNULL(@InfoMov,a.Mov)
   AND a.Moneda = ISNULL(@InfoMoneda,a.Moneda)   

  SELECT @MonedaInicial = '', @CuentaInicial = '', @Saldo = 0.0, @SaldoMC = 0.0
  DECLARE crDineroAux CURSOR FOR
   SELECT ID, Moneda, CtaDinero, Fecha, ISNULL(Cargos,0.0), ISNULL(Abonos,0.0), ISNULL(CargosMC,0.0), ISNULL(AbonosMC,0.0)  
     FROM @Datos
    ORDER BY CtaDinero, Moneda, Fecha

  OPEN crDineroAux
  FETCH NEXT FROM crDineroAux INTO @ID, @Moneda, @Cuenta, @Fecha, @Cargos, @Abonos, @CargosMC, @AbonosMC
  WHILE @@FETCH_STATUS = 0
  BEGIN
    IF @Moneda <> @MonedaInicial OR @Cuenta <> @CuentaInicial
    BEGIN
      SET @Saldo = 0.0
      SET @SaldoMC = 0.0
      SET @MonedaInicial = @Moneda
      SET @CuentaInicial = @Cuenta
    END     

    UPDATE @Datos 
       SET 
       Saldo = @Saldo + (@Cargos - @Abonos), 
       SaldoMC = @SaldoMC + (@CargosMC - @AbonosMC)
     WHERE ID = @ID

    SET @Saldo = @Saldo + (@Cargos - @Abonos)
    SET @SaldoMC = @SaldoMC + (@CargosMC - @AbonosMC)
        
    FETCH NEXT FROM crDineroAux INTO @ID, @Moneda, @Cuenta, @Fecha, @Cargos, @Abonos, @CargosMC, @AbonosMC
  END
  CLOSE crDineroAux
  DEALLOCATE crDineroAux

  SET @MonedaInicial = ''
  SET @CuentaInicial = ''
  SET @MovInicial = ''
  SET @MovTotalCargos = 0.0
  SET @MovTotalAbonos = 0.0
  SET @MovTotalCargosMC = 0.0
  SET @MovTotalAbonosMC = 0.0

  DECLARE crDatos CURSOR STATIC FOR
   SELECT ID, Moneda, CtaDinero, GraficaArgumento, ISNULL(Cargos,0.0), ISNULL(Abonos,0.0), ISNULL(CargosMC,0.0), ISNULL(AbonosMC,0.0)  
     FROM @Datos
    WHERE ISNULL(Grafica,0) = 0
      AND GraficaArgumento IS NOT NULL       
    ORDER BY GraficaArgumento, CtaDinero, Moneda 

  OPEN crDatos
  FETCH NEXT FROM crDatos INTO @ID, @Moneda, @Cuenta, @Mov, @Cargos, @Abonos, @CargosMC, @AbonosMC
  WHILE @@FETCH_STATUS = 0
  BEGIN
    IF @Moneda <> @MonedaInicial OR @Cuenta <> @CuentaInicial OR @Mov <> @MovInicial
    BEGIN
      IF NULLIF(@MovInicial,'') IS NOT NULL OR NULLIF(@CuentaInicial,'') IS NOT NULL OR NULLIF(@MonedaInicial,'') IS NOT NULL
      BEGIN
        INSERT @DatosGrafica (Estacion,         Moneda,         CtaDinero,        Grafica, GraficaArgumento, GraficaValor1,   GraficaValor2,   GraficaValor3,     GraficaValor4,     ContMoneda)
                      VALUES (@EstacionTrabajo, @MonedaInicial, @CuentaInicial,   1,       @MovInicial,      @MovTotalCargos, @MovTotalAbonos, @MovTotalCargosMC, @MovTotalAbonosMC, @ContMoneda)
      END
      
      SET @MovTotalCargos = 0.0
      SET @MovTotalAbonos = 0.0
      SET @MovTotalCargosMC = 0.0
      SET @MovTotalAbonosMC = 0.0
    
      SET @MonedaInicial = @Moneda
      SET @CuentaInicial = @Cuenta
      SET @MovInicial = @Mov
    END     

    SET @MovTotalCargos = @MovTotalCargos + @Cargos
    SET @MovTotalAbonos = @MovTotalAbonos + @Abonos    
    SET @MovTotalCargosMC = @MovTotalCargosMC + @CargosMC
    SET @MovTotalAbonosMC = @MovTotalAbonosMC + @AbonosMC    
    
    FETCH NEXT FROM crDatos INTO @ID, @Moneda, @Cuenta, @Mov, @Cargos, @Abonos, @CargosMC, @AbonosMC
  END
  CLOSE crDatos
  DEALLOCATE crDatos

  IF NULLIF(@MovInicial,'') IS NOT NULL OR NULLIF(@CuentaInicial,'') IS NOT NULL OR NULLIF(@MonedaInicial,'') IS NOT NULL
  BEGIN
    INSERT @DatosGrafica (Estacion,         Moneda,         CtaDinero,        Grafica, GraficaArgumento, GraficaValor1,   GraficaValor2,   GraficaValor3,     GraficaValor4,     ContMoneda)
           VALUES        (@EstacionTrabajo, @MonedaInicial, @CuentaInicial,   1,       @MovInicial,      @MovTotalCargos, @MovTotalAbonos, @MovTotalCargosMC, @MovTotalAbonosMC, @ContMoneda)
  END

  DECLARE crDatosGrafica CURSOR STATIC FOR
   SELECT CtaDinero, Moneda, CASE WHEN ISNULL(GraficaValor1,0.0) > 0.0 AND ISNULL(GraficaValor2,0.0) = 0.0 THEN 1 ELSE 0 END      
     FROM @DatosGrafica
    WHERE ISNULL(Grafica,0) = 1
      AND NULLIF(CtaDinero,'') IS NOT NULL
    GROUP BY CtaDinero, Moneda, CASE WHEN ISNULL(GraficaValor1,0.0) > 0.0 AND ISNULL(GraficaValor2,0.0) = 0.0 THEN 1 ELSE 0 END       

  OPEN crDatosGrafica
  FETCH NEXT FROM crDatosGrafica INTO @Cuenta, @Moneda, @Positivo
  WHILE @@FETCH_STATUS = 0
  BEGIN
  
    IF @InformeGraficarTipo = '(Todos)'
    BEGIN
      INSERT @Datos (Estacion, Moneda, CtaDinero, Grafica, GraficaArgumento, GraficaValor1, GraficaValor2, GraficaValor3, GraficaValor4, ContMoneda, GraficaPositivo)
      SELECT 
        Estacion,
        Moneda,
        CtaDinero,
        1,
        GraficaArgumento, 
        ISNULL(GraficaValor1,0.0),
        ISNULL(GraficaValor2,0.0),
        ISNULL(GraficaValor3,0.0),
        ISNULL(GraficaValor4,0.0),      
        ContMoneda,
        @Positivo
        FROM @DatosGrafica
       WHERE Grafica = 1
         AND CtaDinero = @Cuenta
         AND Moneda = @Moneda
         AND CASE WHEN ISNULL(GraficaValor1,0.0) > 0.0 AND ISNULL(GraficaValor2,0.0) = 0.0 THEN 1 ELSE 0 END = @Positivo
    END ELSE
    IF @InformeGraficarTipo = 'Mas Sobresalientes'
    BEGIN
      INSERT @Datos (Estacion, Moneda, CtaDinero, Grafica, GraficaArgumento, GraficaValor1, GraficaValor2, GraficaValor3, GraficaValor4, ContMoneda, GraficaPositivo)
      SELECT TOP (@InformeGraficarCantidad)
        Estacion,
        Moneda,
        CtaDinero,
        1,
        GraficaArgumento, 
        ISNULL(GraficaValor1,0.0),
        ISNULL(GraficaValor2,0.0),
        ISNULL(GraficaValor3,0.0),
        ISNULL(GraficaValor4,0.0),      
        ContMoneda,
        @Positivo
        FROM @DatosGrafica
       WHERE Grafica = 1
         AND CtaDinero = @Cuenta
         AND Moneda = @Moneda       
         AND CASE WHEN ISNULL(GraficaValor1,0.0) > 0.0 AND ISNULL(GraficaValor2,0.0) = 0.0 THEN 1 ELSE 0 END = @Positivo
       ORDER BY (ISNULL(GraficaValor1,0.0) - ISNULL(GraficaValor2,0.0)) DESC      
    END ELSE
    IF @InformeGraficarTipo = 'Menos Sobresalientes'
    BEGIN
      INSERT @Datos (Estacion, Moneda, CtaDinero, Grafica, GraficaArgumento, GraficaValor1, GraficaValor2, GraficaValor3, GraficaValor4, ContMoneda, GraficaPositivo)
      SELECT TOP (@InformeGraficarCantidad)
        Estacion,
        Moneda,
        CtaDinero,
        1,
        GraficaArgumento, 
        ISNULL(GraficaValor1,0.0),
        ISNULL(GraficaValor2,0.0),
        ISNULL(GraficaValor3,0.0),
        ISNULL(GraficaValor4,0.0),      
        ContMoneda,
        @Positivo
        FROM @DatosGrafica
       WHERE Grafica = 1
         AND CtaDinero = @Cuenta
         AND Moneda = @Moneda       
         AND CASE WHEN ISNULL(GraficaValor1,0.0) > 0.0 AND ISNULL(GraficaValor2,0.0) = 0.0 THEN 1 ELSE 0 END = @Positivo         
       ORDER BY (ISNULL(GraficaValor1,0.0) - ISNULL(GraficaValor2,0.0)) ASC  
    END  

    FETCH NEXT FROM crDatosGrafica INTO @Cuenta, @Moneda, @Positivo
  END
  CLOSE crDatosGrafica
  DEALLOCATE crDatosGrafica

  INSERT @Datos (Estacion, Grafica, GraficaArgumento, GraficaValor3, GraficaValor4, ContMoneda, GraficaPositivo)
  SELECT 
    Estacion,
    2,
    GraficaArgumento, 
    SUM(ISNULL(GraficaValor3,0.0)),
    SUM(ISNULL(GraficaValor4,0.0)),
    ContMoneda,
    GraficaPositivo
    FROM @Datos
   WHERE Grafica = 1
   GROUP BY Estacion, GraficaArgumento, ContMoneda, GraficaPositivo         
  
  SELECT Estacion, ID, CtaDinero, NumeroCta, Descripcion, Tipo, Uso, Moneda, TipoCambio, Beneficiario, Fecha, Movimiento, Cargos, Abonos, Saldo, CargosMC, AbonosMC, SaldoMC, EsCancelacion, Grafica, GraficaArgumento, GraficaValor1, GraficaValor2, GraficaValor3, GraficaValor4, Titulo, ContMoneda, FiltroCtaDineroD, FiltroEmpresa, FiltroCtaDineroA, FiltroFechaD, FiltroFechaA, FiltroUso, FiltroMov, FiltroNivel, FiltroMoneda, FiltroGraficarTipo, FiltroGraficarCantidad, GraficaPositivo, @VerGraficaDetalle as VerGraficaDetalle
    FROM @Datos
   ORDER BY NumeroCta, Descripcion, CtaDinero, Fecha, Moneda, Grafica 
  
END
GO

/*
UPDATE REPPARAM
   SET
   InfoEmpresa = 'DEMO',
   InfoCtaDineroD = 'BANAMEX',
   InfoCtaDineroA = 'CITY',   
   InfoFechaD = '01/01/2011',   
   InfoFechaA = '30/11/2011',      
   InfoUso = '(Todos)',
   InfoMov = '(Todos)',   
   InfoNivel = 'Desglosado',
   InfoMoneda = '(Todas)',
   InfoTitulo = NULL,
   InformeGraficarTipo = 'Mas Sobresalientes',
   InformeGraficarCantidad = 3

exec spDineroAux 1
*/
   
/******************************* spDineroAuxConcentrado *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spDineroAuxConcentrado') and type = 'P') drop procedure dbo.spDineroAuxConcentrado
GO             
CREATE PROCEDURE spDineroAuxConcentrado
		@EstacionTrabajo		int

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @InfoEmpresa				varchar(5),
  @InfoCtaDineroD			varchar(10),
  @InfoCtaDineroA			varchar(10),
  @InfoFechaD				datetime,
  @InfoFechaA				datetime,  
  @InfoUso					varchar(20),
  @InfoMov					varchar(20),
  @InfoNivel				varchar(20),
  @InfoMoneda				varchar(10),
  @InfoTitulo				varchar(100),
  @InfoUsuario				varchar(10),
  @MonedaInicial			varchar(10),
  @CuentaInicial			varchar(10),
  @MovInicial				varchar(20),    
  @ID						int,
  @Moneda					varchar(10),
  @Cuenta					varchar(10),
  @Fecha					datetime,
  @SaldoInicial				float,
  @SaldoInicialMC			float,  
  @Cargos					float,
  @Abonos					float,
  @CargosMC					float,
  @AbonosMC					float,
  @Saldo					float,
  @SaldoMC					float,
  @Mov						varchar(20),
  @MovTotalCargos			float,
  @MovTotalAbonos			float,
  @MovTotalCargosMC			float,
  @MovTotalAbonosMC			float,
  @ContMoneda				varchar(10),
  @InformeGraficarTipo		varchar(30),
  @InformeGraficarCantidad	int,
  @EmpresaNombre			varchar(100),
    @VerGraficaDetalle		bit

  
    
  SELECT
    @InfoEmpresa		     =	 InfoEmpresa,
    @InfoCtaDineroD		     =   ISNULL(InfoCtaDineroD,''),
    @InfoCtaDineroA		     =   ISNULL(InfoCtaDineroA,''),
    @InfoFechaD			     =   dbo.fnFechaSinHora(InfoFechaD),    
    @InfoFechaA			     =   dbo.fnFechaSinHora(InfoFechaA),        
    @InfoUso			     =	 CASE WHEN InfoUso IN( '(Todos)', '') THEN NULL ELSE InfoUso END,    
    @InfoMov			     =	 CASE WHEN InfoMov IN( '(Todos)', '') THEN NULL ELSE InfoMov END,        
    @InfoNivel			     =   ISNULL(InfoNivel,'Desglosado'),
    @InfoMoneda			     =	 CASE WHEN InfoMoneda IN( '(Todas)', '') THEN NULL ELSE InfoMoneda END,
    @InfoTitulo			     =   ISNULL(InfoTitulo,dbo.fnIdiomaTraducir(@InfoUsuario,'Tesorería - Auxiliar Movimientos Desglosado')),
	@InfoUsuario		     =   InfoUsuario,
	@InformeGraficarTipo     =   ISNULL(InformeGraficarTipo,'(Todos)'),
	@InformeGraficarCantidad =   ISNULL(NULLIF(InformeGraficarCantidad,0),5),
    @VerGraficaDetalle = ISNULL(VerGraficaDetalle,0)
    FROM RepParam
   WHERE Estacion = @EstacionTrabajo

  SELECT @ContMoneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @InfoEmpresa
  SELECT @EmpresaNombre = Nombre FROM Empresa WHERE Empresa = @InfoEmpresa
    
  DECLARE @DatosDesglosados TABLE
  (
   Estacion					int NOT NULL,
   ID						int identity(1,1) NOT NULL,
   CtaDinero				varchar(10) COLLATE DATABASE_DEFAULT NULL,   
   NumeroCta				varchar(100) COLLATE DATABASE_DEFAULT NULL,   
   Descripcion				varchar(100) COLLATE DATABASE_DEFAULT NULL,
   Tipo						varchar(20) COLLATE DATABASE_DEFAULT NULL,   
   Uso						varchar(20) COLLATE DATABASE_DEFAULT NULL, 
   Moneda					varchar(10) COLLATE DATABASE_DEFAULT NULL,
   TipoCambio				float NULL,
   Beneficiario				varchar(100) COLLATE DATABASE_DEFAULT NULL,
   Fecha					datetime NULL,
   Movimiento				varchar(50) COLLATE DATABASE_DEFAULT NULL,
   SaldoInicial				float NULL,
   Cargos					float NULL,
   Abonos					float NULL,
   Saldo					float NULL,
   SaldoInicialMC			float NULL,
   CargosMC					float NULL,
   AbonosMC					float NULL,   
   SaldoMC					float NULL,      
   Grafica					int NULL DEFAULT 0,
   GraficaArgumento			varchar(20) COLLATE DATABASE_DEFAULT NULL,
   GraficaValor1			float,
   GraficaValor2			float,
   GraficaValor3			float,
   GraficaValor4			float,   
   Titulo					varchar(50) COLLATE DATABASE_DEFAULT NULL,
   ContMoneda				varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroEmpresa			varchar(100) COLLATE DATABASE_DEFAULT NULL,
   FiltroCtaDineroD			varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroCtaDineroA			varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroFechaD				datetime NULL,
   FiltroFechaA				datetime NULL,
   FiltroUso				varchar(20) COLLATE DATABASE_DEFAULT NULL,
   FiltroMov				varchar(20) COLLATE DATABASE_DEFAULT NULL,
   FiltroNivel				varchar(20) COLLATE DATABASE_DEFAULT NULL,
   FiltroMoneda				varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroGraficarTipo		varchar(30) COLLATE DATABASE_DEFAULT NULL,
   FiltroGraficarCantidad	int NULL
  )    

  DECLARE @Datos TABLE
  (
   Estacion					int NOT NULL,
   ID						int identity(1,1) NOT NULL,
   CtaDinero				varchar(10) COLLATE DATABASE_DEFAULT NULL,   
   NumeroCta				varchar(100) COLLATE DATABASE_DEFAULT NULL,   
   Descripcion				varchar(100) COLLATE DATABASE_DEFAULT NULL,
   Tipo						varchar(20) COLLATE DATABASE_DEFAULT NULL,   
   Uso						varchar(20) COLLATE DATABASE_DEFAULT NULL, 
   Moneda					varchar(10) COLLATE DATABASE_DEFAULT NULL,
   TipoCambio				float NULL,
   Beneficiario				varchar(100) COLLATE DATABASE_DEFAULT NULL,
   Fecha					datetime NULL,
   Movimiento				varchar(50) COLLATE DATABASE_DEFAULT NULL,
   SaldoInicial				float NULL,
   Cargos					float NULL,
   Abonos					float NULL,
   Saldo					float NULL,
   SaldoInicialMC			float NULL,
   CargosMC					float NULL,
   AbonosMC					float NULL,   
   SaldoMC					float NULL,      
   Grafica					int NULL DEFAULT 0,
   GraficaArgumento			varchar(20) COLLATE DATABASE_DEFAULT NULL,
   GraficaValor1			float,
   GraficaValor2			float,
   GraficaValor3			float,
   GraficaValor4			float,   
   Titulo					varchar(50) COLLATE DATABASE_DEFAULT NULL,
   ContMoneda				varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroEmpresa			varchar(100) COLLATE DATABASE_DEFAULT NULL,
   FiltroCtaDineroD			varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroCtaDineroA			varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroFechaD				datetime NULL,
   FiltroFechaA				datetime NULL,
   FiltroUso				varchar(20) COLLATE DATABASE_DEFAULT NULL,
   FiltroMov				varchar(20) COLLATE DATABASE_DEFAULT NULL,
   FiltroNivel				varchar(20) COLLATE DATABASE_DEFAULT NULL,
   FiltroMoneda				varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroGraficarTipo		varchar(30) COLLATE DATABASE_DEFAULT NULL,
   FiltroGraficarCantidad	int NULL
  )    

  -- Saldo Anterior
  INSERT @DatosDesglosados (Estacion, CtaDinero, NumeroCta, Descripcion, Tipo, Uso, Moneda, TipoCambio, Beneficiario, Fecha, Movimiento, SaldoInicial, Cargos, Abonos, Saldo, SaldoInicialMC, CargosMC, AbonosMC, SaldoMC, Grafica, Titulo, ContMoneda, FiltroEmpresa, FiltroCtaDineroD, FiltroCtaDineroA, FiltroFechaD, FiltroFechaA, FiltroUso, FiltroMov, FiltroNivel, FiltroMoneda, FiltroGraficarTipo, FiltroGraficarCantidad)
  SELECT
    @EstacionTrabajo,
    RTRIM(c.CtaDinero),
    RTRIM(c.NumeroCta),
    RTRIM(c.Descripcion),
    NULL,
    NULL,
    c.Moneda,
    NULL,
    NULL,
    DATEADD(day,-1,@InfoFechaD),
    dbo.fnIdiomaTraducir(@InfoUsuario,'Saldo Inicial'),
    SUM(ISNULL(a.Cargo,0.0) - ISNULL(a.Abono,0.0)),            
    0.0,    
    0.0,        
    NULL,
    SUM((ISNULL(a.Cargo,0.0)*ISNULL(a.TipoCambio,0)) - (ISNULL(a.Abono,0.0)*ISNULL(a.TipoCambio,0))),            
    0.0,    
    0.0,        
    NULL,
    0,
    @InfoTitulo,
    @ContMoneda,
    @EmpresaNombre,    
    @InfoCtaDineroD,	
    @InfoCtaDineroA,	
    @InfoFechaD,		
    @InfoFechaA,		
    ISNULL(@InfoUso,'(Todos)'),		
    ISNULL(@InfoMov,'(Todos)'),		
    @InfoNivel,		
    ISNULL(@InfoMoneda,'(Todas)'),		    
    ISNULL(@InformeGraficarTipo,'(Todos)'),		        
    @InformeGraficarCantidad
  FROM
    CtaDinero c LEFT OUTER JOIN Auxiliar a 
    ON a.Empresa = @InfoEmpresa AND a.Rama = 'DIN' AND c.CtaDinero = a.Cuenta AND a.Fecha < @InfoFechaD AND a.Mov = ISNULL(@InfoMov,a.Mov) AND a.Moneda = ISNULL(@InfoMoneda,a.Moneda) LEFT OUTER JOIN Dinero d
    ON d.ID = a.ModuloID
 WHERE c.CtaDinero BETWEEN @InfoCtaDineroD AND @InfoCtaDineroA
   AND ISNULL(c.Uso,'') = ISNULL(@InfoUso,ISNULL(c.Uso,''))
   AND c.Moneda = ISNULL(@InfoMoneda,c.Moneda)
 GROUP BY RTRIM(c.CtaDinero), RTRIM(c.NumeroCta), RTRIM(c.Descripcion), c.Moneda
    
  -- Movimientos Actuales
  INSERT @DatosDesglosados (Estacion, CtaDinero, NumeroCta, Descripcion, Tipo, Uso, Moneda, TipoCambio, Beneficiario, Fecha, Movimiento, Cargos, Abonos, Saldo, CargosMC, AbonosMC, SaldoMC, Grafica, Titulo, GraficaArgumento, ContMoneda, FiltroEmpresa, FiltroCtaDineroD, FiltroCtaDineroA, FiltroFechaD, FiltroFechaA, FiltroUso, FiltroMov, FiltroNivel, FiltroMoneda, FiltroGraficarTipo, FiltroGraficarCantidad)
  SELECT
    @EstacionTrabajo,
    RTRIM(c.CtaDinero),
    RTRIM(c.NumeroCta),    
    RTRIM(c.Descripcion),
    c.Tipo,
    c.Uso,
    a.Moneda,
    a.TipoCambio,
    d.BeneficiarioNombre,
    a.Fecha,
    RTRIM(RTRIM(ISNULL(a.Mov,'')) + ' ' + RTRIM(ISNULL(a.MovID,''))),
    ISNULL(a.Cargo,0.0),    
    ISNULL(a.Abono,0.0),        
    NULL,
    ISNULL(a.Cargo,0.0)*ISNULL(a.TipoCambio,0),    
    ISNULL(a.Abono,0.0)*ISNULL(a.TipoCambio,0),        
    NULL,
    0,
    @InfoTitulo,
    RTRIM(ISNULL(a.Mov,'')),
    @ContMoneda,
    @EmpresaNombre,
    @InfoCtaDineroD,	
    @InfoCtaDineroA,	
    @InfoFechaD,		
    @InfoFechaA,		
    ISNULL(@InfoUso,'(Todos)'),		
    ISNULL(@InfoMov,'(Todos)'),		
    @InfoNivel,		
    ISNULL(@InfoMoneda,'(Todas)'),
    ISNULL(@InformeGraficarTipo,'(Todos)'),		        
    @InformeGraficarCantidad    		        
  FROM
    CtaDinero c JOIN Auxiliar a 
    ON a.Rama = 'DIN' AND c.CtaDinero = a.Cuenta JOIN Dinero d
    ON d.ID = a.ModuloID
 WHERE a.Empresa = @InfoEmpresa
   AND a.Cuenta BETWEEN @InfoCtaDineroD AND @InfoCtaDineroA
   AND a.Fecha BETWEEN @InfoFechaD AND @InfoFechaA
   AND ISNULL(c.Uso,'') = ISNULL(@InfoUso,ISNULL(c.Uso,''))
   AND a.Mov = ISNULL(@InfoMov,a.Mov)
   AND a.Moneda = ISNULL(@InfoMoneda,a.Moneda)   

  INSERT @Datos (Estacion, CtaDinero, NumeroCta, Descripcion, Moneda, SaldoInicial, Cargos, Abonos, SaldoInicialMC, CargosMC, AbonosMC, Grafica, Titulo, GraficaArgumento, ContMoneda, FiltroEmpresa, FiltroCtaDineroD, FiltroCtaDineroA, FiltroFechaD, FiltroFechaA, FiltroUso, FiltroMov, FiltroNivel, FiltroMoneda, FiltroGraficarTipo, FiltroGraficarCantidad)
         SELECT
           @EstacionTrabajo, 
           CtaDinero, 
           NumeroCta,
           Descripcion,
           Moneda,
           SUM(ISNULL(SaldoInicial,0.0)),           
           SUM(ISNULL(Cargos,0.0)),
           SUM(ISNULL(Abonos,0.0)),           
           SUM(ISNULL(SaldoInicialMC,0.0)),                      
           SUM(ISNULL(CargosMC,0.0)),
           SUM(ISNULL(AbonosMC,0.0)),           
           0,            
           @InfoTitulo,
           RTRIM(ISNULL(CtaDinero,'')),
           @ContMoneda,
           @EmpresaNombre,
           @InfoCtaDineroD,	
           @InfoCtaDineroA,	
           @InfoFechaD,		
           @InfoFechaA,		
           ISNULL(@InfoUso,'(Todos)'),		
           ISNULL(@InfoMov,'(Todos)'),		
           @InfoNivel,		
           ISNULL(@InfoMoneda,'(Todas)'),
           ISNULL(@InformeGraficarTipo,'(Todos)'),		        
           @InformeGraficarCantidad    		        
           FROM @DatosDesglosados
           WHERE Moneda = ISNULL(@InfoMoneda,Moneda)
          GROUP BY CtaDinero, NumeroCta, Descripcion, Moneda
          
    
  UPDATE @Datos
     SET
     Saldo = ISNULL(SaldoInicial,0.0) + ISNULL(Cargos,0.0) - ISNULL(Abonos,0.0),        
     SaldoMC = ISNULL(SaldoInicialMC,0.0) + ISNULL(CargosMC,0.0) - ISNULL(AbonosMC,0.0)             
     
  IF @InformeGraficarTipo = '(Todos)'
  BEGIN
    INSERT @Datos (Estacion, Moneda, CtaDinero, Grafica, GraficaArgumento, GraficaValor1, GraficaValor2, GraficaValor3, GraficaValor4, ContMoneda, Titulo, FiltroEmpresa, FiltroCtaDineroD, FiltroCtaDineroA, FiltroFechaD, FiltroFechaA, FiltroUso, FiltroMov, FiltroNivel, FiltroMoneda, FiltroGraficarTipo, FiltroGraficarCantidad)
    SELECT 
      Estacion,
      Moneda,
      CtaDinero,
      2,
      CtaDinero, 
      ISNULL(SaldoInicialMC,0.0),
      ISNULL(CargosMC,0.0),
      ISNULL(AbonosMC,0.0),
      ISNULL(SaldoMC,0.0),      
      ContMoneda,
      @InfoTitulo,
      @EmpresaNombre,
      @InfoCtaDineroD,	
      @InfoCtaDineroA,	
      @InfoFechaD,		
      @InfoFechaA,		
      ISNULL(@InfoUso,'(Todos)'),		
      ISNULL(@InfoMov,'(Todos)'),		
      @InfoNivel,		
      ISNULL(@InfoMoneda,'(Todas)'),
      ISNULL(@InformeGraficarTipo,'(Todos)'),		        
      @InformeGraficarCantidad    		              
      FROM @Datos
     WHERE Grafica = 0
  END ELSE
  IF @InformeGraficarTipo = 'Mas Sobresalientes'
  BEGIN
    INSERT @Datos (Estacion, Moneda, CtaDinero, Grafica, GraficaArgumento, GraficaValor1, GraficaValor2, GraficaValor3, GraficaValor4, ContMoneda, Titulo, FiltroEmpresa, FiltroCtaDineroD, FiltroCtaDineroA, FiltroFechaD, FiltroFechaA, FiltroUso, FiltroMov, FiltroNivel, FiltroMoneda, FiltroGraficarTipo, FiltroGraficarCantidad)
    SELECT TOP (@InformeGraficarCantidad)
      Estacion,
      Moneda,
      CtaDinero,
      2,
      CtaDinero, 
      ISNULL(SaldoInicialMC,0.0),
      ISNULL(CargosMC,0.0),
      ISNULL(AbonosMC,0.0),
      ISNULL(SaldoMC,0.0),      
      ContMoneda,
      @InfoTitulo,
      @EmpresaNombre,
      @InfoCtaDineroD,	
      @InfoCtaDineroA,	
      @InfoFechaD,		
      @InfoFechaA,		
      ISNULL(@InfoUso,'(Todos)'),		
      ISNULL(@InfoMov,'(Todos)'),		
      @InfoNivel,		
      ISNULL(@InfoMoneda,'(Todas)'),
      ISNULL(@InformeGraficarTipo,'(Todos)'),		        
      @InformeGraficarCantidad    		                    
      FROM @Datos
     WHERE Grafica = 0
     ORDER BY ISNULL(SaldoMC,0.0) DESC
  END ELSE
  IF @InformeGraficarTipo = 'Menos Sobresalientes'
  BEGIN
    INSERT @Datos (Estacion, Moneda, CtaDinero, Grafica, GraficaArgumento, GraficaValor1, GraficaValor2, GraficaValor3, GraficaValor4, ContMoneda, Titulo, FiltroEmpresa, FiltroCtaDineroD, FiltroCtaDineroA, FiltroFechaD, FiltroFechaA, FiltroUso, FiltroMov, FiltroNivel, FiltroMoneda, FiltroGraficarTipo, FiltroGraficarCantidad)
    SELECT TOP (@InformeGraficarCantidad)
      Estacion,
      Moneda,
      CtaDinero,
      2,
      CtaDinero, 
      ISNULL(SaldoInicialMC,0.0),
      ISNULL(CargosMC,0.0),
      ISNULL(AbonosMC,0.0),
      ISNULL(SaldoMC,0.0),      
      ContMoneda,
      @InfoTitulo,
      @EmpresaNombre,
      @InfoCtaDineroD,	
      @InfoCtaDineroA,	
      @InfoFechaD,		
      @InfoFechaA,		
      ISNULL(@InfoUso,'(Todos)'),		
      ISNULL(@InfoMov,'(Todos)'),		
      @InfoNivel,		
      ISNULL(@InfoMoneda,'(Todas)'),
      ISNULL(@InformeGraficarTipo,'(Todos)'),		        
      @InformeGraficarCantidad    		                    
      FROM @Datos
     WHERE Grafica = 0
     ORDER BY ISNULL(SaldoMC,0.0) ASC  
  END  
  
  SELECT Estacion, ID, CtaDinero, NumeroCta, Descripcion, Moneda, SaldoInicial, Cargos, Abonos, Saldo, SaldoInicialMC, CargosMC, AbonosMC, SaldoMC, Grafica, GraficaArgumento, GraficaValor1, GraficaValor2, GraficaValor3, GraficaValor4, Titulo, ContMoneda, FiltroCtaDineroD, FiltroEmpresa, FiltroCtaDineroA, FiltroFechaD, FiltroFechaA, FiltroUso, FiltroMov, FiltroNivel, FiltroMoneda, FiltroGraficarTipo, FiltroGraficarCantidad, @VerGraficaDetalle as VerGraficaDetalle
    FROM @Datos
   ORDER BY CtaDinero, Moneda, Grafica 
  
END
GO

/*
UPDATE REPPARAM
   SET
   InfoEmpresa = 'DEMO',
   InfoCtaDineroD = 'BANAMEX',
   InfoCtaDineroA = 'CITY',   
   InfoFechaD = '01/01/2011',   
   InfoFechaA = '30/11/2011',      
   InfoUso = '(Todos)',
   InfoMov = '(Todos)',   
   InfoNivel = 'Concentrado',
   InfoMoneda = '(Todas)',
   InfoTitulo = NULL,
   InformeGraficarTipo = 'Menos Sobresalientes',
   InformeGraficarCantidad = 2

exec spDineroAuxConcentrado 1
*/

/******************************* spDineroAuxOrigen *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spDineroAuxOrigen') and type = 'P') drop procedure dbo.spDineroAuxOrigen
GO             
CREATE PROCEDURE spDineroAuxOrigen
		@EstacionTrabajo		int

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @InfoEmpresa				varchar(5),
  @InfoCtaDineroD			varchar(10),
  @InfoCtaDineroA			varchar(10),
  @InfoFechaD				datetime,
  @InfoFechaA				datetime,  
  @InfoUso					varchar(20),
  @InfoMov					varchar(20),
  @InfoNivel				varchar(20),
  @InfoMoneda				varchar(10),
  @InfoTitulo				varchar(100),
  @InfoUsuario				varchar(10),
  @MonedaInicial			varchar(10),
  @CuentaInicial			varchar(10),
  @MovInicial				varchar(20),    
  @ID						int,
  @Moneda					varchar(10),
  @Cuenta					varchar(10),
  @Fecha					datetime,
  @Cargos					float,
  @Abonos					float,
  @CargosMC					float,
  @AbonosMC					float,
  @Saldo					float,
  @SaldoMC					float,
  @Mov						varchar(20),
  @MovTotalCargos			float,
  @MovTotalAbonos			float,
  @MovTotalCargosMC			float,
  @MovTotalAbonosMC			float,
  @ContMoneda				varchar(10),
  @InformeGraficarTipo		varchar(30),
  @InformeGraficarCantidad	int,
  @EmpresaNombre			varchar(100),
  @Positivo					int,
    @VerGraficaDetalle		bit

  
    
  SELECT
    @InfoEmpresa		     =	 InfoEmpresa,
    @InfoCtaDineroD		     =   ISNULL(InfoCtaDineroD,''),
    @InfoCtaDineroA		     =   ISNULL(InfoCtaDineroA,''),
    @InfoFechaD			     =   dbo.fnFechaSinHora(InfoFechaD),    
    @InfoFechaA			     =   dbo.fnFechaSinHora(InfoFechaA),        
    @InfoUso			     =	 CASE WHEN InfoUso IN( '(Todos)', '') THEN NULL ELSE InfoUso END,    
    @InfoMov			     =	 CASE WHEN InfoMov IN( '(Todos)', '') THEN NULL ELSE InfoMov END,        
    @InfoNivel			     =   ISNULL(InfoNivel,'Desglosado'),
    @InfoMoneda			     =	 CASE WHEN InfoMoneda IN( '(Todas)', '') THEN NULL ELSE InfoMoneda END,
    @InfoTitulo			     =   ISNULL(InfoTitulo,dbo.fnIdiomaTraducir(@InfoUsuario,'Tesorería - Auxiliar Movimientos Desglosado')),
	@InfoUsuario		     =   InfoUsuario,
	@InformeGraficarTipo     =   ISNULL(InformeGraficarTipo,'(Todos)'),
	@InformeGraficarCantidad =   ISNULL(NULLIF(InformeGraficarCantidad,0),5),
    @VerGraficaDetalle = ISNULL(VerGraficaDetalle,0)
    FROM RepParam
   WHERE Estacion = @EstacionTrabajo

  SELECT @ContMoneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @InfoEmpresa
  SELECT @EmpresaNombre = Nombre FROM Empresa WHERE Empresa = @InfoEmpresa
    
  DECLARE @Datos TABLE
  (
   Estacion					int NOT NULL,
   ID						int identity(1,1) NOT NULL,
   CtaDinero				varchar(10) COLLATE DATABASE_DEFAULT NULL,   
   NumeroCta				varchar(100) COLLATE DATABASE_DEFAULT NULL,   
   Descripcion				varchar(100) COLLATE DATABASE_DEFAULT NULL,
   Tipo						varchar(20) COLLATE DATABASE_DEFAULT NULL,   
   Uso						varchar(20) COLLATE DATABASE_DEFAULT NULL, 
   Moneda					varchar(10) COLLATE DATABASE_DEFAULT NULL,
   TipoCambio				float NULL,
   Beneficiario				varchar(100) COLLATE DATABASE_DEFAULT NULL,
   Origen					varchar(255) NULL,
   Fecha					datetime NULL,
   Movimiento				varchar(50) COLLATE DATABASE_DEFAULT NULL,
   Cargos					float NULL,
   Abonos					float NULL,
   Saldo					float NULL,
   CargosMC					float NULL,
   AbonosMC					float NULL,   
   SaldoMC					float NULL,      
   EsCancelacion			bit NULL DEFAULT 0,
   Grafica					int NULL DEFAULT 0,
   GraficaArgumento			varchar(20) COLLATE DATABASE_DEFAULT NULL,
   GraficaValor1			float,
   GraficaValor2			float,
   GraficaValor3			float,
   GraficaValor4			float,  
   GraficaPositivo			int DEFAULT 0, 
   Titulo					varchar(50) COLLATE DATABASE_DEFAULT NULL,
   ContMoneda				varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroEmpresa			varchar(100) COLLATE DATABASE_DEFAULT NULL,
   FiltroCtaDineroD			varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroCtaDineroA			varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroFechaD				datetime NULL,
   FiltroFechaA				datetime NULL,
   FiltroUso				varchar(20) COLLATE DATABASE_DEFAULT NULL,
   FiltroMov				varchar(20) COLLATE DATABASE_DEFAULT NULL,
   FiltroNivel				varchar(20) COLLATE DATABASE_DEFAULT NULL,
   FiltroMoneda				varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroGraficarTipo		varchar(30) COLLATE DATABASE_DEFAULT NULL,
   FiltroGraficarCantidad	int NULL
  )    


  DECLARE @DatosGrafica TABLE
  (
   Estacion					int NOT NULL,
   ID						int identity(1,1) NOT NULL,
   CtaDinero				varchar(10) COLLATE DATABASE_DEFAULT NULL,   
   NumeroCta				varchar(100) COLLATE DATABASE_DEFAULT NULL,   
   Descripcion				varchar(100) COLLATE DATABASE_DEFAULT NULL,
   Tipo						varchar(20) COLLATE DATABASE_DEFAULT NULL,   
   Uso						varchar(20) COLLATE DATABASE_DEFAULT NULL, 
   Moneda					varchar(10) COLLATE DATABASE_DEFAULT NULL,
   TipoCambio				float NULL,
   Beneficiario				varchar(100) COLLATE DATABASE_DEFAULT NULL,
   Origen					varchar(255) NULL,   
   Fecha					datetime NULL,
   Movimiento				varchar(50) COLLATE DATABASE_DEFAULT NULL,
   Cargos					float NULL,
   Abonos					float NULL,
   Saldo					float NULL,
   CargosMC					float NULL,
   AbonosMC					float NULL,   
   SaldoMC					float NULL,      
   EsCancelacion			bit NULL DEFAULT 0,
   Grafica					int NULL DEFAULT 0,
   GraficaArgumento			varchar(20) COLLATE DATABASE_DEFAULT NULL,
   GraficaValor1			float,
   GraficaValor2			float,
   GraficaValor3			float,
   GraficaValor4			float,   
   Titulo					varchar(50) COLLATE DATABASE_DEFAULT NULL,
   ContMoneda				varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroEmpresa			varchar(100) COLLATE DATABASE_DEFAULT NULL,   
   FiltroCtaDineroD			varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroCtaDineroA			varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroFechaD				datetime NULL,
   FiltroFechaA				datetime NULL,
   FiltroUso				varchar(20) COLLATE DATABASE_DEFAULT NULL,
   FiltroMov				varchar(20) COLLATE DATABASE_DEFAULT NULL,
   FiltroNivel				varchar(20) COLLATE DATABASE_DEFAULT NULL,
   FiltroMoneda				varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroGraficarTipo		varchar(30) COLLATE DATABASE_DEFAULT NULL,
   FiltroGraficarCantidad	int NULL
  )    

  -- Saldo Anterior
  INSERT @Datos (Estacion, CtaDinero, NumeroCta, Descripcion, Tipo, Uso, Moneda, TipoCambio, Beneficiario, Origen, Fecha, Movimiento, Cargos, Abonos, Saldo, CargosMC, AbonosMC, SaldoMC, EsCancelacion, Grafica, Titulo, ContMoneda, FiltroEmpresa, FiltroCtaDineroD, FiltroCtaDineroA, FiltroFechaD, FiltroFechaA, FiltroUso, FiltroMov, FiltroNivel, FiltroMoneda, FiltroGraficarTipo, FiltroGraficarCantidad)
  SELECT
    @EstacionTrabajo,
    RTRIM(c.CtaDinero),
    RTRIM(c.NumeroCta),
    RTRIM(c.Descripcion),
    NULL,
    NULL,
    c.Moneda,
    NULL,
    NULL,
    '',
    DATEADD(day,-1,@InfoFechaD),
    dbo.fnIdiomaTraducir(@InfoUsuario,'Saldo Inicial'),
    SUM(ISNULL(a.Cargo,0.0)),    
    SUM(ISNULL(a.Abono,0.0)),        
    NULL,
    SUM(ISNULL(a.Cargo,0.0)*ISNULL(a.TipoCambio,0)),    
    SUM(ISNULL(a.Abono,0.0)*ISNULL(a.TipoCambio,0)),        
    NULL,
    0,
    0,
    @InfoTitulo,
    @ContMoneda,
    @EmpresaNombre,    
    @InfoCtaDineroD,	
    @InfoCtaDineroA,	
    @InfoFechaD,		
    @InfoFechaA,		
    ISNULL(@InfoUso,'(Todos)'),		
    ISNULL(@InfoMov,'(Todos)'),		
    @InfoNivel,		
    ISNULL(@InfoMoneda,'(Todas)'),		    
    ISNULL(@InformeGraficarTipo,'(Todos)'),		        
    @InformeGraficarCantidad
  FROM
    CtaDinero c LEFT OUTER JOIN Auxiliar a 
    ON a.Empresa = @InfoEmpresa AND a.Rama = 'DIN' AND c.CtaDinero = a.Cuenta AND a.Fecha < @InfoFechaD AND a.Mov = ISNULL(@InfoMov,a.Mov) AND a.Moneda = ISNULL(@InfoMoneda,a.Moneda) LEFT OUTER JOIN Dinero d
    ON d.ID = a.ModuloID 
 WHERE c.CtaDinero BETWEEN @InfoCtaDineroD AND @InfoCtaDineroA
   AND ISNULL(c.Uso,'') = ISNULL(@InfoUso,ISNULL(c.Uso,''))
   AND c.Moneda = ISNULL(@InfoMoneda,c.Moneda)
 GROUP BY RTRIM(c.CtaDinero), RTRIM(c.NumeroCta), RTRIM(c.Descripcion), c.Moneda
    
  -- Movimientos Actuales
  INSERT @Datos (Estacion, CtaDinero, NumeroCta, Descripcion, Tipo, Uso, Moneda, TipoCambio, Beneficiario, Origen, Fecha, Movimiento, Cargos, Abonos, Saldo, CargosMC, AbonosMC, SaldoMC, EsCancelacion, Grafica, Titulo, GraficaArgumento, ContMoneda, FiltroEmpresa, FiltroCtaDineroD, FiltroCtaDineroA, FiltroFechaD, FiltroFechaA, FiltroUso, FiltroMov, FiltroNivel, FiltroMoneda, FiltroGraficarTipo, FiltroGraficarCantidad)
  SELECT
    @EstacionTrabajo,
    RTRIM(c.CtaDinero),
    RTRIM(c.NumeroCta),    
    RTRIM(c.Descripcion),
    c.Tipo,
    c.Uso,
    a.Moneda,
    a.TipoCambio,
    d.BeneficiarioNombre,
    RTRIM(RTRIM(ISNULL(dd.Aplica,''))+' '+RTRIM(ISNULL(dd.AplicaID,''))+ CHAR(9) + CHAR(9) +CASE WHEN ISNULL(dd.Aplica,'') = '' THEN '' ELSE RTRIM(ISNULL(CONVERT(varchar,dd.Importe,1),'')) END + ' '+ RTRIM(ISNULL(d2.BeneficiarioNombre,''))),    
    a.Fecha,
    RTRIM(RTRIM(ISNULL(a.Mov,'')) + ' ' + RTRIM(ISNULL(a.MovID,''))),
    ISNULL(a.Cargo,0.0),    
    ISNULL(a.Abono,0.0),        
    NULL,
    ISNULL(a.Cargo,0.0)*ISNULL(a.TipoCambio,0),    
    ISNULL(a.Abono,0.0)*ISNULL(a.TipoCambio,0),        
    NULL,
    ISNULL(a.EsCancelacion,0),
    0,
    @InfoTitulo,
    RTRIM(ISNULL(a.Mov,'')),
    @ContMoneda,
    @EmpresaNombre,
    @InfoCtaDineroD,	
    @InfoCtaDineroA,	
    @InfoFechaD,		
    @InfoFechaA,		
    ISNULL(@InfoUso,'(Todos)'),		
    ISNULL(@InfoMov,'(Todos)'),		
    @InfoNivel,		
    ISNULL(@InfoMoneda,'(Todas)'),
    ISNULL(@InformeGraficarTipo,'(Todos)'),		        
    @InformeGraficarCantidad    		        
  FROM
    CtaDinero c JOIN Auxiliar a 
    ON a.Rama = 'DIN' AND c.CtaDinero = a.Cuenta JOIN Dinero d
    ON d.ID = a.ModuloID LEFT OUTER JOIN DineroD dd
    ON dd.ID = a.ModuloID LEFT OUTER JOIN Dinero d2
    ON d2.MovID = dd.AplicaID AND d2.Mov = dd.Aplica
 WHERE a.Empresa = @InfoEmpresa
   AND a.Cuenta BETWEEN @InfoCtaDineroD AND @InfoCtaDineroA
   AND a.Fecha BETWEEN @InfoFechaD AND @InfoFechaA
   AND ISNULL(c.Uso,'') = ISNULL(@InfoUso,ISNULL(c.Uso,''))
   AND a.Mov = ISNULL(@InfoMov,a.Mov)
   AND a.Moneda = ISNULL(@InfoMoneda,a.Moneda)   
   
  SELECT @MonedaInicial = '', @CuentaInicial = '', @Saldo = 0.0, @SaldoMC = 0.0
  DECLARE crDineroAux CURSOR FOR
   SELECT MIN(ID), Moneda, CtaDinero, Fecha, ISNULL(Cargos,0.0), ISNULL(Abonos,0.0), ISNULL(CargosMC,0.0), ISNULL(AbonosMC,0.0)  
     FROM @Datos
    GROUP BY CtaDinero, Moneda, Fecha, ISNULL(Cargos,0.0), ISNULL(Abonos,0.0), ISNULL(CargosMC,0.0), ISNULL(AbonosMC,0.0)       
    ORDER BY CtaDinero, Moneda, Fecha, MIN(ID) 

  OPEN crDineroAux
  FETCH NEXT FROM crDineroAux INTO @ID, @Moneda, @Cuenta, @Fecha, @Cargos, @Abonos, @CargosMC, @AbonosMC
  WHILE @@FETCH_STATUS = 0
  BEGIN
    IF @Moneda <> @MonedaInicial OR @Cuenta <> @CuentaInicial
    BEGIN
      SET @Saldo = 0.0
      SET @SaldoMC = 0.0
      SET @MonedaInicial = @Moneda
      SET @CuentaInicial = @Cuenta
    END     

    UPDATE @Datos 
       SET 
       Saldo = @Saldo + (@Cargos - @Abonos), 
       SaldoMC = @SaldoMC + (@CargosMC - @AbonosMC)
     WHERE ID = @ID

    SET @Saldo = @Saldo + (@Cargos - @Abonos)
    SET @SaldoMC = @SaldoMC + (@CargosMC - @AbonosMC)
        
    FETCH NEXT FROM crDineroAux INTO @ID, @Moneda, @Cuenta, @Fecha, @Cargos, @Abonos, @CargosMC, @AbonosMC
  END
  CLOSE crDineroAux
  DEALLOCATE crDineroAux

  SET @MonedaInicial = ''
  SET @CuentaInicial = ''
  SET @MovInicial = ''
  SET @MovTotalCargos = 0.0
  SET @MovTotalAbonos = 0.0
  SET @MovTotalCargosMC = 0.0
  SET @MovTotalAbonosMC = 0.0

  DECLARE crDatos CURSOR STATIC FOR
   SELECT MIN(ID), Moneda, CtaDinero, GraficaArgumento, ISNULL(Cargos,0.0), ISNULL(Abonos,0.0), ISNULL(CargosMC,0.0), ISNULL(AbonosMC,0.0)  
     FROM @Datos
    WHERE ISNULL(Grafica,0) = 0
      AND GraficaArgumento IS NOT NULL       
    GROUP BY GraficaArgumento, CtaDinero, Moneda, ISNULL(Cargos,0.0), ISNULL(Abonos,0.0), ISNULL(CargosMC,0.0), ISNULL(AbonosMC,0.0)  
    ORDER BY GraficaArgumento, CtaDinero, Moneda 

  OPEN crDatos
  FETCH NEXT FROM crDatos INTO @ID, @Moneda, @Cuenta, @Mov, @Cargos, @Abonos, @CargosMC, @AbonosMC
  WHILE @@FETCH_STATUS = 0
  BEGIN
    IF @Moneda <> @MonedaInicial OR @Cuenta <> @CuentaInicial OR @Mov <> @MovInicial
    BEGIN
      IF NULLIF(@MovInicial,'') IS NOT NULL OR NULLIF(@CuentaInicial,'') IS NOT NULL OR NULLIF(@MonedaInicial,'') IS NOT NULL
      BEGIN
        INSERT @DatosGrafica (Estacion,         Moneda,         CtaDinero,        Grafica, GraficaArgumento, GraficaValor1,   GraficaValor2,   GraficaValor3,     GraficaValor4,     ContMoneda)
                      VALUES (@EstacionTrabajo, @MonedaInicial, @CuentaInicial,   1,       @MovInicial,      @MovTotalCargos, @MovTotalAbonos, @MovTotalCargosMC, @MovTotalAbonosMC, @ContMoneda)
      END
      
      SET @MovTotalCargos = 0.0
      SET @MovTotalAbonos = 0.0
      SET @MovTotalCargosMC = 0.0
      SET @MovTotalAbonosMC = 0.0
    
      SET @MonedaInicial = @Moneda
      SET @CuentaInicial = @Cuenta
      SET @MovInicial = @Mov
    END     

    SET @MovTotalCargos = @MovTotalCargos + @Cargos
    SET @MovTotalAbonos = @MovTotalAbonos + @Abonos    
    SET @MovTotalCargosMC = @MovTotalCargosMC + @CargosMC
    SET @MovTotalAbonosMC = @MovTotalAbonosMC + @AbonosMC    
    
    FETCH NEXT FROM crDatos INTO @ID, @Moneda, @Cuenta, @Mov, @Cargos, @Abonos, @CargosMC, @AbonosMC
  END
  CLOSE crDatos
  DEALLOCATE crDatos

  IF NULLIF(@MovInicial,'') IS NOT NULL OR NULLIF(@CuentaInicial,'') IS NOT NULL OR NULLIF(@MonedaInicial,'') IS NOT NULL
  BEGIN
    INSERT @DatosGrafica (Estacion,         Moneda,         CtaDinero,        Grafica, GraficaArgumento, GraficaValor1,   GraficaValor2,   GraficaValor3,     GraficaValor4,     ContMoneda)
           VALUES        (@EstacionTrabajo, @MonedaInicial, @CuentaInicial,   1,       @MovInicial,      @MovTotalCargos, @MovTotalAbonos, @MovTotalCargosMC, @MovTotalAbonosMC, @ContMoneda)
  END

  DECLARE crDatosGrafica CURSOR STATIC FOR
   SELECT CtaDinero, Moneda, CASE WHEN ISNULL(GraficaValor1,0.0) > 0.0 AND ISNULL(GraficaValor2,0.0) = 0.0 THEN 1 ELSE 0 END
     FROM @DatosGrafica
    WHERE ISNULL(Grafica,0) = 1
      AND NULLIF(CtaDinero,'') IS NOT NULL
    GROUP BY CtaDinero, Moneda, CASE WHEN ISNULL(GraficaValor1,0.0) > 0.0 AND ISNULL(GraficaValor2,0.0) = 0.0 THEN 1 ELSE 0 END

  OPEN crDatosGrafica
  FETCH NEXT FROM crDatosGrafica INTO @Cuenta, @Moneda, @Positivo
  WHILE @@FETCH_STATUS = 0
  BEGIN
  
    IF @InformeGraficarTipo = '(Todos)'
    BEGIN
      INSERT @Datos (Estacion, Moneda, CtaDinero, Grafica, GraficaArgumento, GraficaValor1, GraficaValor2, GraficaValor3, GraficaValor4, ContMoneda, GraficaPositivo)
      SELECT 
        Estacion,
        Moneda,
        CtaDinero,
        1,
        GraficaArgumento, 
        ISNULL(GraficaValor1,0.0),
        ISNULL(GraficaValor2,0.0),
        ISNULL(GraficaValor3,0.0),
        ISNULL(GraficaValor4,0.0),      
        ContMoneda,
        @Positivo
        FROM @DatosGrafica
       WHERE Grafica = 1
         AND CtaDinero = @Cuenta
         AND Moneda = @Moneda
         AND CASE WHEN ISNULL(GraficaValor1,0.0) > 0.0 AND ISNULL(GraficaValor2,0.0) = 0.0 THEN 1 ELSE 0 END = @Positivo
    END ELSE
    IF @InformeGraficarTipo = 'Mas Sobresalientes'
    BEGIN
      INSERT @Datos (Estacion, Moneda, CtaDinero, Grafica, GraficaArgumento, GraficaValor1, GraficaValor2, GraficaValor3, GraficaValor4, ContMoneda, GraficaPositivo)
      SELECT TOP (@InformeGraficarCantidad)
        Estacion,
        Moneda,
        CtaDinero,
        1,
        GraficaArgumento, 
        ISNULL(GraficaValor1,0.0),
        ISNULL(GraficaValor2,0.0),
        ISNULL(GraficaValor3,0.0),
        ISNULL(GraficaValor4,0.0),      
        ContMoneda,
        @Positivo
        FROM @DatosGrafica
       WHERE Grafica = 1
         AND CtaDinero = @Cuenta
         AND Moneda = @Moneda       
         AND CASE WHEN ISNULL(GraficaValor1,0.0) > 0.0 AND ISNULL(GraficaValor2,0.0) = 0.0 THEN 1 ELSE 0 END = @Positivo         
       ORDER BY (ISNULL(GraficaValor1,0.0) - ISNULL(GraficaValor2,0.0)) DESC      
    END ELSE
    IF @InformeGraficarTipo = 'Menos Sobresalientes'
    BEGIN
      INSERT @Datos (Estacion, Moneda, CtaDinero, Grafica, GraficaArgumento, GraficaValor1, GraficaValor2, GraficaValor3, GraficaValor4, ContMoneda, GraficaPositivo)
      SELECT TOP (@InformeGraficarCantidad)
        Estacion,
        Moneda,
        CtaDinero,
        1,
        GraficaArgumento, 
        ISNULL(GraficaValor1,0.0),
        ISNULL(GraficaValor2,0.0),
        ISNULL(GraficaValor3,0.0),
        ISNULL(GraficaValor4,0.0),      
        ContMoneda,
        @Positivo
        FROM @DatosGrafica
       WHERE Grafica = 1
         AND CtaDinero = @Cuenta
         AND Moneda = @Moneda       
         AND CASE WHEN ISNULL(GraficaValor1,0.0) > 0.0 AND ISNULL(GraficaValor2,0.0) = 0.0 THEN 1 ELSE 0 END = @Positivo         
       ORDER BY (ISNULL(GraficaValor1,0.0) - ISNULL(GraficaValor2,0.0)) ASC  
    END  

    FETCH NEXT FROM crDatosGrafica INTO @Cuenta, @Moneda, @Positivo
  END
  CLOSE crDatosGrafica
  DEALLOCATE crDatosGrafica

  INSERT @Datos (Estacion, Grafica, GraficaArgumento, GraficaValor3, GraficaValor4, ContMoneda, GraficaPositivo)
  SELECT 
    Estacion,
    2,
    GraficaArgumento, 
    SUM(ISNULL(GraficaValor3,0.0)),
    SUM(ISNULL(GraficaValor4,0.0)),
    ContMoneda,
    GraficaPositivo
    FROM @Datos
   WHERE Grafica = 1
   GROUP BY Estacion, GraficaArgumento, ContMoneda, GraficaPositivo         
  
  SELECT Estacion, ID, CtaDinero, NumeroCta, Descripcion, Tipo, Uso, Moneda, TipoCambio, Beneficiario, Origen, Fecha, Movimiento, Cargos, Abonos, Saldo, CargosMC, AbonosMC, SaldoMC, EsCancelacion, Grafica, GraficaArgumento, GraficaValor1, GraficaValor2, GraficaValor3, GraficaValor4, Titulo, ContMoneda, FiltroCtaDineroD, FiltroEmpresa, FiltroCtaDineroA, FiltroFechaD, FiltroFechaA, FiltroUso, FiltroMov, FiltroNivel, FiltroMoneda, FiltroGraficarTipo, FiltroGraficarCantidad, GraficaPositivo, @VerGraficaDetalle as VerGraficaDetalle
    FROM @Datos
   ORDER BY NumeroCta, Descripcion, CtaDinero, Moneda, Fecha, Movimiento, Grafica 
  
END
GO

--select * from auxiliar where rama = 'din'
/*
UPDATE REPPARAM
   SET
   InfoEmpresa = 'DEMO',
   InfoCtaDineroD = 'BANAMEX',
   InfoCtaDineroA = 'CITY',   
   InfoFechaD = '01/01/2011',   
   InfoFechaA = '30/11/2011',      
   InfoUso = '(Todos)',
   InfoMov = '(Todos)',   
   InfoNivel = 'Desglosado',
   InfoMoneda = '(Todas)',
   InfoTitulo = NULL,
   InformeGraficarTipo = 'Mas Sobresalientes',
   InformeGraficarCantidad = 3

exec spDineroAuxOrigen 1
*/      
