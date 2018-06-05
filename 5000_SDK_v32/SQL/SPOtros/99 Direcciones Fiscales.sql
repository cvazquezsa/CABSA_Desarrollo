SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

/*******************************************************************************************/
/*                          Direcciones Fiscales                                           */
/*******************************************************************************************/

/**************** spCteDireccionFiscalActualizar ****************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spCteDireccionFiscalActualizar') AND type = 'P') DROP PROCEDURE dbo.spCteDireccionFiscalActualizar
GO 
CREATE PROC spCteDireccionFiscalActualizar
--//WITH ENCRYPTION
AS BEGIN
 INSERT INTO CteDireccionFiscal(Cliente, Icono, Mapeado)
   SELECT c.Cliente, 435, 0 
     FROM Cte c LEFT JOIN CteDireccionFiscal cd ON c.Cliente = cd.Cliente
	WHERE cd.Cliente IS NULL


 INSERT INTO CteEnviarADireccionFiscal(Cliente, ID, Icono, Mapeado)
   SELECT c.Cliente, c.ID, 435, 0 
     FROM CteEnviarA c LEFT JOIN CteEnviarADireccionFiscal cd ON c.Cliente = cd.Cliente AND c.ID = cd.ID
	WHERE cd.Cliente IS NULL

RETURN
END
GO


/**************** spEmpresaDireccionFiscalActualizar ****************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spEmpresaDireccionFiscalActualizar') AND type = 'P') DROP PROCEDURE dbo.spEmpresaDireccionFiscalActualizar
GO 
CREATE PROC spEmpresaDireccionFiscalActualizar
--//WITH ENCRYPTION
AS BEGIN
 INSERT INTO EmpresaDireccionFiscal(Empresa, Icono, Mapeado)
   SELECT e.Empresa, 435, 0 
     FROM Empresa e LEFT JOIN EmpresaDireccionFiscal ed ON e.Empresa = ed.Empresa
	WHERE ed.Empresa IS NULL

RETURN
END
GO


/**************** spProvDireccionFiscalActualizar ****************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spProvDireccionFiscalActualizar') AND type = 'P') DROP PROCEDURE dbo.spProvDireccionFiscalActualizar
GO 
CREATE PROC spProvDireccionFiscalActualizar
--//WITH ENCRYPTION
AS BEGIN
 INSERT INTO ProvDireccionFiscal(Proveedor, Icono, Mapeado)
   SELECT p.Proveedor, 435, 0 
     FROM Prov p LEFT JOIN ProvDireccionFiscal pd ON p.Proveedor = pd.Proveedor
	WHERE pd.Proveedor IS NULL

RETURN
END
GO


/**************** spPersonalDireccionFiscalActualizar ****************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spPersonalDireccionFiscalActualizar') AND type = 'P') DROP PROCEDURE dbo.spPersonalDireccionFiscalActualizar
GO 
CREATE PROC spPersonalDireccionFiscalActualizar
--//WITH ENCRYPTION
AS BEGIN
 INSERT INTO PersonalDireccionFiscal(Personal, Icono, Mapeado)
   SELECT p.Personal, 435, 0 
     FROM Personal p LEFT JOIN PersonalDireccionFiscal pd ON p.Personal = pd.Personal
	WHERE pd.Personal IS NULL

RETURN
END
GO


/**************** spSucursalDireccionFiscalActualizar ****************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spSucursalDireccionFiscalActualizar') AND type = 'P') DROP PROCEDURE dbo. spSucursalDireccionFiscalActualizar
GO 
CREATE PROC spSucursalDireccionFiscalActualizar
--//WITH ENCRYPTION
AS BEGIN
 INSERT INTO SucursalDireccionFiscal(Sucursal, Icono, Mapeado)
   SELECT s.Sucursal, 435, 0 
     FROM Sucursal s LEFT JOIN SucursalDireccionFiscal sd ON s.Sucursal = sd.Sucursal
	WHERE sd.Sucursal IS NULL

RETURN
END
GO

/**************** spCteDireccionFiscalMapear ****************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spCteDireccionFiscalMapear') AND type = 'P') DROP PROCEDURE dbo.spCteDireccionFiscalMapear
GO 
CREATE PROC spCteDireccionFiscalMapear
	@Estacion    int
	--//WITH ENCRYPTION
AS 
BEGIN
	DECLARE 
		@Cliente			varchar(10),
		@ID					int,
		@ClaveCP			varchar(5),
		@ClavePais			varchar(3),
		@ClaveEstado		varchar(3),
		@ClaveMunicipio		varchar(3),
		@ClaveLocalidad		varchar(2),
		@ClaveColonia		varchar(4),
		@DescPais			varchar(255),
		@DescEstado			varchar(255),
		@DescMunicipio		varchar(255),
		@DescLocalidad		varchar(255),
		@DescColonia		varchar(255),
		@CodigoPostal		varchar(15)

	SELECT @Cliente = MIN(Clave) FROM ListaSt WHERE Estacion = @Estacion
	WHILE @Cliente IS NOT NULL
		BEGIN
			SELECT @CodigoPostal = NULL, @ClaveCP = NULL, @ClavePais = NULL, @ClaveEstado = NULL, @ClaveMunicipio = NULL, @ClaveLocalidad = NULL, @ClaveColonia = NULL,
				   @DescPais = NULL, @DescEstado = NULL, @DescMunicipio = NULL, @DescLocalidad = NULL, @DescColonia = NULL
			SELECT @CodigoPostal = CodigoPostal FROM Cte WHERE Cliente = @Cliente

	--- Verificar que exista el Código Postal; las colonias y códigos postales no son 1 a 1
	IF ISNULL(@CodigoPostal,'') <> '' AND ((SELECT COUNT(1) FROM SATDireccionFiscal WHERE ClaveCP = @CodigoPostal) >= 1)
	BEGIN 
		SELECT @ClaveCP = ClaveCP, @ClavePais = ClavePais, @DescPais = SATPaisDescripcion,
			   @ClaveEstado = ClaveEstado, @DescEstado = SATEstadoDescripcion, @ClaveMunicipio = ClaveMunicipio,
			   @DescMunicipio =  SATMunicipioDescripcion, @ClaveLocalidad = ClaveLocalidad,  @DescLocalidad = SATLocalidadDescripcion,
			   @ClaveColonia = ClaveColonia, @DescColonia = SATColoniaDescripcion
		  FROM SATDireccionFiscal
		 WHERE ClaveCP = @CodigoPostal

	-- Actualizar Direccion del Cliente
		IF ISNULL(@ClaveCP,'') <> '' AND ISNULL(@ClavePais,'') <> '' AND ISNULL(@ClaveEstado,'') <> '' AND ISNULL(@ClaveMunicipio,'') <> '' 
		   AND ISNULL(@ClaveColonia,'') <> '' -- AND ISNULL(@ClaveLocalidad,'') <> ''
		BEGIN
			UPDATE CteDireccionFiscal SET Mapeado = 1, Icono = 434, ClaveCP = @ClaveCP, ClavePais = @ClavePais, ClaveEstado = @ClaveEstado,
				   ClaveMunicipio = @ClaveMunicipio, ClaveLocalidad = @ClaveLocalidad, ClaveColonia = @ClaveColonia 
			 WHERE Cliente = @Cliente AND ISNULL(Mapeado,0) = 0
			
			UPDATE Cte SET Delegacion = @DescMunicipio, Colonia = @DescColonia, CodigoPostal = @ClaveCP, 
				   Poblacion = @DescLocalidad, Estado = @DescEstado, Pais = @DescPais WHERE Cliente = @Cliente
		END
	END

	-- Actualizar Sucursal del Cliente
	SELECT @ID = MIN(ID) FROM CteEnviarA WHERE Cliente = @Cliente
	WHILE @ID IS NOT NULL
		BEGIN
			SELECT @CodigoPostal = NULL, @ClaveCP = NULL, @ClavePais = NULL, @ClaveEstado = NULL, @ClaveMunicipio = NULL, @ClaveLocalidad = NULL, @ClaveColonia = NULL,
				   @DescPais = NULL, @DescEstado = NULL, @DescMunicipio = NULL, @DescLocalidad = NULL, @DescColonia = NULL  
			SELECT @CodigoPostal = CodigoPostal 
			  FROM CteEnviarA
			 WHERE Cliente = @Cliente AND ID = @ID

			--- Verificar que exista el Código Postal; las colonias y códigos postales no son 1 a 1
			IF ISNULL(@CodigoPostal,'') <> '' AND ((SELECT COUNT(1) FROM SATDireccionFiscal WHERE ClaveCP = @CodigoPostal) >= 1)
				BEGIN 
					SELECT @ClaveCP = ClaveCP, @ClavePais = ClavePais, @DescPais = SATPaisDescripcion,
						   @ClaveEstado = ClaveEstado, @DescEstado = SATEstadoDescripcion, @ClaveMunicipio = ClaveMunicipio, 
						   @DescMunicipio =  SATMunicipioDescripcion, @ClaveLocalidad = ClaveLocalidad,  @DescLocalidad = SATLocalidadDescripcion,
						   @ClaveColonia = ClaveColonia, @DescColonia = SATColoniaDescripcion
					  FROM SATDireccionFiscal
					 WHERE ClaveCP = @CodigoPostal

			-- Actualizar Direccion del Cliente
			IF ISNULL(@ClaveCP,'') <> '' AND ISNULL(@ClavePais,'') <> '' AND ISNULL(@ClaveEstado,'') <> '' AND ISNULL(@ClaveMunicipio,'') <> '' 
			   AND ISNULL(@ClaveColonia,'') <> '' -- AND ISNULL(@ClaveLocalidad,'') <> ''
				BEGIN
					UPDATE CteEnviarADireccionFiscal SET Mapeado = 1, Icono = 434, ClaveCP = @ClaveCP, ClavePais = @ClavePais, ClaveEstado = @ClaveEstado,
						   ClaveMunicipio = @ClaveMunicipio, ClaveLocalidad = @ClaveLocalidad, ClaveColonia = @ClaveColonia 
					 WHERE Cliente = @Cliente AND ID = @ID AND ISNULL(Mapeado,0) = 0

					UPDATE CteEnviarA SET Delegacion = @DescMunicipio, Colonia = @DescColonia, CodigoPostal = @ClaveCP, 
						   Poblacion = @DescLocalidad, Estado = @DescEstado, Pais = @DescPais WHERE Cliente = @Cliente AND ID = @ID
				END
		END
			--- Verificar que exista el Código Postal y solo tenga una Colonia
			SELECT @ID = MIN(ID) FROM CteEnviarA WHERE Cliente = @Cliente AND ID > @ID
		END

  SELECT @Cliente = MIN(Clave) FROM ListaSt WHERE Estacion = @Estacion AND Clave > @Cliente
 END

RETURN
END
GO

/**************** spCteEnviarADireccionFiscalMapear ****************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spCteEnviarADireccionFiscalMapear') AND type = 'P') DROP PROCEDURE dbo.spCteEnviarADireccionFiscalMapear
GO 
CREATE PROC spCteEnviarADireccionFiscalMapear
 @Estacion    int,
 @Cliente     varchar(10)
--//WITH ENCRYPTION
AS BEGIN
DECLARE 
 @ID             int,
 @ClaveCP        varchar(5),
 @ClavePais      varchar(3),
 @ClaveEstado    varchar(3),
 @ClaveMunicipio varchar(3),
 @ClaveLocalidad varchar(2),
 @ClaveColonia   varchar(4),

 @DescPais       varchar(255),
 @DescEstado     varchar(255),
 @DescMunicipio  varchar(255),
 @DescLocalidad  varchar(255),
 @DescColonia    varchar(255),

 @CodigoPostal   varchar(15)

 SELECT @ID = MIN(Clave) FROM ListaSt WHERE Estacion = @Estacion
 WHILE @ID IS NOT NULL
 BEGIN
  SELECT @CodigoPostal = NULL, @ClaveCP = NULL, @ClavePais = NULL, @ClaveEstado = NULL, @ClaveMunicipio = NULL, @ClaveLocalidad = NULL, @ClaveColonia = NULL,
         @DescPais = NULL, @DescEstado = NULL, @DescMunicipio = NULL, @DescLocalidad = NULL, @DescColonia = NULL      
  SELECT @CodigoPostal = CodigoPostal FROM CteEnviarA WHERE Cliente = @Cliente AND ID = @ID
  
  --- Verificar que exista el Código Postal y solo tenga una Colonia
  IF ISNULL(@CodigoPostal,'') <> '' AND ((SELECT COUNT(1) FROM SATDireccionFiscal WHERE ClaveCP = @CodigoPostal) = 1)
  BEGIN 
   SELECT @ClaveCP = ClaveCP, @ClavePais = ClavePais, @DescPais = SATPaisDescripcion,
	  @ClaveEstado = ClaveEstado, @DescEstado = SATEstadoDescripcion, @ClaveMunicipio = ClaveMunicipio, 
	  @DescMunicipio =  SATMunicipioDescripcion, @ClaveLocalidad = ClaveLocalidad,  @DescLocalidad = SATLocalidadDescripcion,
	  @ClaveColonia = ClaveColonia, @DescColonia = SATColoniaDescripcion
	 FROM SATDireccionFiscal WHERE ClaveCP = @CodigoPostal

   -- Actualizar Direccion del Cliente
   IF ISNULL(@ClaveCP,'') <> '' AND ISNULL(@ClavePais,'') <> '' AND ISNULL(@ClaveEstado,'') <> '' AND ISNULL(@ClaveMunicipio,'') <> '' 
	  AND ISNULL(@ClaveColonia,'') <> '' -- AND ISNULL(@ClaveLocalidad,'') <> ''
   BEGIN
	  UPDATE CteEnviarADireccionFiscal SET Mapeado = 1, Icono = 434, ClaveCP = @ClaveCP, ClavePais = @ClavePais, ClaveEstado = @ClaveEstado,
	         ClaveMunicipio = @ClaveMunicipio, ClaveLocalidad = @ClaveLocalidad, ClaveColonia = @ClaveColonia 
	   WHERE Cliente = @Cliente AND ID = @ID AND ISNULL(Mapeado,0) = 0

	  UPDATE CteEnviarA SET Delegacion = @DescMunicipio, Colonia = @DescColonia, CodigoPostal = @ClaveCP, 
	         Poblacion = @DescLocalidad, Estado = @DescEstado, Pais = @DescPais WHERE Cliente = @Cliente AND ID = @ID
   END
  END

  SELECT @ID = MIN(Clave) FROM ListaSt WHERE Estacion = @Estacion AND Clave > @ID
 END

RETURN
END
GO


/**************** spEmpresaDireccionFiscalMapear ****************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spEmpresaDireccionFiscalMapear') AND type = 'P') DROP PROCEDURE dbo.spEmpresaDireccionFiscalMapear
GO 
CREATE PROC spEmpresaDireccionFiscalMapear
 @Estacion    int
--//WITH ENCRYPTION
AS BEGIN
DECLARE 
 @Empresa        varchar(5),
 @ID             int,
 @ClaveCP        varchar(5),
 @ClavePais      varchar(3),
 @ClaveEstado    varchar(3),
 @ClaveMunicipio varchar(3),
 @ClaveLocalidad varchar(2),
 @ClaveColonia   varchar(4),

 @DescPais       varchar(255),
 @DescEstado     varchar(255),
 @DescMunicipio  varchar(255),
 @DescLocalidad  varchar(255),
 @DescColonia    varchar(255),

 @CodigoPostal   varchar(15)

 SELECT @Empresa = MIN(Clave) FROM ListaSt WHERE Estacion = @Estacion
 WHILE @Empresa IS NOT NULL
 BEGIN
  SELECT @CodigoPostal = NULL, @ClaveCP = NULL, @ClavePais = NULL, @ClaveEstado = NULL, @ClaveMunicipio = NULL, @ClaveLocalidad = NULL, @ClaveColonia = NULL,
         @DescPais = NULL, @DescEstado = NULL, @DescMunicipio = NULL, @DescLocalidad = NULL, @DescColonia = NULL
  SELECT @CodigoPostal = CodigoPostal FROM Empresa WHERE Empresa = @Empresa

  --- Verificar que exista el Código Postal y solo tenga una Colonia
  IF ISNULL(@CodigoPostal,'') <> '' AND ((SELECT COUNT(1) FROM SATDireccionFiscal WHERE ClaveCP = @CodigoPostal) = 1)
   BEGIN 
    SELECT @ClaveCP = ClaveCP, @ClavePais = ClavePais, @DescPais = SATPaisDescripcion,
	  @ClaveEstado = ClaveEstado, @DescEstado = SATEstadoDescripcion, @ClaveMunicipio = ClaveMunicipio, 
	  @DescMunicipio =  SATMunicipioDescripcion, @ClaveLocalidad = ClaveLocalidad,  @DescLocalidad = SATLocalidadDescripcion,
	  @ClaveColonia = ClaveColonia, @DescColonia = SATColoniaDescripcion
	  FROM SATDireccionFiscal WHERE ClaveCP = @CodigoPostal

    -- Actualizar Direccion del Cliente
	IF ISNULL(@ClaveCP,'') <> '' AND ISNULL(@ClavePais,'') <> '' AND ISNULL(@ClaveEstado,'') <> '' AND ISNULL(@ClaveMunicipio,'') <> '' 
	   AND ISNULL(@ClaveColonia,'') <> '' -- AND ISNULL(@ClaveLocalidad,'') <> ''
	BEGIN
	 UPDATE EmpresaDireccionFiscal SET Mapeado = 1, Icono = 434, ClaveCP = @ClaveCP, ClavePais = @ClavePais, ClaveEstado = @ClaveEstado,
	        ClaveMunicipio = @ClaveMunicipio, ClaveLocalidad = @ClaveLocalidad, ClaveColonia = @ClaveColonia 
	  WHERE Empresa = @Empresa AND ISNULL(Mapeado,0) = 0

     UPDATE Empresa SET Delegacion = @DescMunicipio, Colonia = @DescColonia, CodigoPostal = @ClaveCP, 
	         Poblacion = @DescLocalidad, Estado = @DescEstado, Pais = @DescPais WHERE Empresa = @Empresa
	END

   END

  SELECT @Empresa = MIN(Clave) FROM ListaSt WHERE Estacion = @Estacion AND Clave > @Empresa
 END

RETURN
END
GO



/**************** spPersonalDireccionFiscalMapear ****************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spPersonalDireccionFiscalMapear') AND type = 'P') DROP PROCEDURE dbo.spPersonalDireccionFiscalMapear
GO 
CREATE PROC spPersonalDireccionFiscalMapear
 @Estacion    int
--//WITH ENCRYPTION
AS BEGIN
DECLARE 
 @Personal       varchar(10),
 @ID             int,
 @ClaveCP        varchar(5),
 @ClavePais      varchar(3),
 @ClaveEstado    varchar(3),
 @ClaveMunicipio varchar(3),
 @ClaveLocalidad varchar(2),
 @ClaveColonia   varchar(4),

 @DescPais       varchar(255),
 @DescEstado     varchar(255),
 @DescMunicipio  varchar(255),
 @DescLocalidad  varchar(255),
 @DescColonia    varchar(255),

 @CodigoPostal   varchar(15)

 SELECT @Personal = MIN(Clave) FROM ListaSt WHERE Estacion = @Estacion
 WHILE @Personal IS NOT NULL
 BEGIN
  SELECT @CodigoPostal = NULL, @ClaveCP = NULL, @ClavePais = NULL, @ClaveEstado = NULL, @ClaveMunicipio = NULL, @ClaveLocalidad = NULL, @ClaveColonia = NULL,
         @DescPais = NULL, @DescEstado = NULL, @DescMunicipio = NULL, @DescLocalidad = NULL, @DescColonia = NULL
  SELECT @CodigoPostal = CodigoPostal FROM Personal WHERE Personal = @Personal

  --- Verificar que exista el Código Postal y solo tenga una Colonia
  IF ISNULL(@CodigoPostal,'') <> '' AND ((SELECT COUNT(1) FROM SATDireccionFiscal WHERE ClaveCP = @CodigoPostal) = 1)
   BEGIN 
    SELECT @ClaveCP = ClaveCP, @ClavePais = ClavePais, @DescPais = SATPaisDescripcion,
	  @ClaveEstado = ClaveEstado, @DescEstado = SATEstadoDescripcion, @ClaveMunicipio = ClaveMunicipio, 
	  @DescMunicipio =  SATMunicipioDescripcion, @ClaveLocalidad = ClaveLocalidad,  @DescLocalidad = SATLocalidadDescripcion,
	  @ClaveColonia = ClaveColonia, @DescColonia = SATColoniaDescripcion
	  FROM SATDireccionFiscal WHERE ClaveCP = @CodigoPostal

    -- Actualizar Direccion del Cliente
	IF ISNULL(@ClaveCP,'') <> '' AND ISNULL(@ClavePais,'') <> '' AND ISNULL(@ClaveEstado,'') <> '' AND ISNULL(@ClaveMunicipio,'') <> '' 
	   AND ISNULL(@ClaveColonia,'') <> '' -- AND ISNULL(@ClaveLocalidad,'') <> '' 
	BEGIN
	 UPDATE PersonalDireccionFiscal SET Mapeado = 1, Icono = 434, ClaveCP = @ClaveCP, ClavePais = @ClavePais, ClaveEstado = @ClaveEstado,
	        ClaveMunicipio = @ClaveMunicipio, ClaveLocalidad = @ClaveLocalidad, ClaveColonia = @ClaveColonia 
	  WHERE Personal = @Personal AND ISNULL(Mapeado,0) = 0

     UPDATE Personal SET Delegacion = @DescMunicipio, Colonia = @DescColonia, CodigoPostal = @ClaveCP, 
	         Poblacion = @DescLocalidad, Estado = @DescEstado, Pais = @DescPais WHERE Personal = @Personal

	END
   END

  SELECT @Personal = MIN(Clave) FROM ListaSt WHERE Estacion = @Estacion AND Clave > @Personal
 END

RETURN
END
GO



/**************** spProvDireccionFiscalMapear ****************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spProvDireccionFiscalMapear') AND type = 'P') DROP PROCEDURE dbo.spProvDireccionFiscalMapear
GO 
CREATE PROC spProvDireccionFiscalMapear
 @Estacion    int
--//WITH ENCRYPTION
AS BEGIN
DECLARE 
 @Proveedor      varchar(10),
 @ID             int,
 @ClaveCP        varchar(5),
 @ClavePais      varchar(3),
 @ClaveEstado    varchar(3),
 @ClaveMunicipio varchar(3),
 @ClaveLocalidad varchar(2),
 @ClaveColonia   varchar(4),

 @DescPais       varchar(255),
 @DescEstado     varchar(255),
 @DescMunicipio  varchar(255),
 @DescLocalidad  varchar(255),
 @DescColonia    varchar(255),

 @CodigoPostal   varchar(15)

 SELECT @Proveedor = MIN(Clave) FROM ListaSt WHERE Estacion = @Estacion
 WHILE @Proveedor IS NOT NULL
 BEGIN
  SELECT @CodigoPostal = NULL, @ClaveCP = NULL, @ClavePais = NULL, @ClaveEstado = NULL, @ClaveMunicipio = NULL, @ClaveLocalidad = NULL, @ClaveColonia = NULL,
         @DescPais = NULL, @DescEstado = NULL, @DescMunicipio = NULL, @DescLocalidad = NULL, @DescColonia = NULL
  SELECT @CodigoPostal = CodigoPostal FROM Prov WHERE Proveedor = @Proveedor

  --- Verificar que exista el Código Postal y solo tenga una Colonia
  IF ISNULL(@CodigoPostal,'') <> '' AND ((SELECT COUNT(1) FROM SATDireccionFiscal WHERE ClaveCP = @CodigoPostal) = 1)
   BEGIN 
    SELECT @ClaveCP = ClaveCP, @ClavePais = ClavePais, @DescPais = SATPaisDescripcion,
	  @ClaveEstado = ClaveEstado, @DescEstado = SATEstadoDescripcion, @ClaveMunicipio = ClaveMunicipio, 
	  @DescMunicipio =  SATMunicipioDescripcion, @ClaveLocalidad = ClaveLocalidad,  @DescLocalidad = SATLocalidadDescripcion,
	  @ClaveColonia = ClaveColonia, @DescColonia = SATColoniaDescripcion
	  FROM SATDireccionFiscal WHERE ClaveCP = @CodigoPostal

    -- Actualizar Direccion del Cliente
	IF ISNULL(@ClaveCP,'') <> '' AND ISNULL(@ClavePais,'') <> '' AND ISNULL(@ClaveEstado,'') <> '' AND ISNULL(@ClaveMunicipio,'') <> '' 
	   AND ISNULL(@ClaveColonia,'') <> '' -- AND ISNULL(@ClaveLocalidad,'') <> '' 
	BEGIN
	 UPDATE ProvDireccionFiscal SET Mapeado = 1, Icono = 434, ClaveCP = @ClaveCP, ClavePais = @ClavePais, ClaveEstado = @ClaveEstado,
	        ClaveMunicipio = @ClaveMunicipio, ClaveLocalidad = @ClaveLocalidad, ClaveColonia = @ClaveColonia 
	  WHERE Proveedor = @Proveedor AND ISNULL(Mapeado,0) = 0

     UPDATE Prov SET Delegacion = @DescMunicipio, Colonia = @DescColonia, CodigoPostal = @ClaveCP, 
	         Poblacion = @DescLocalidad, Estado = @DescEstado, Pais = @DescPais WHERE Proveedor = @Proveedor
	END
   END

  SELECT @Proveedor = MIN(Clave) FROM ListaSt WHERE Estacion = @Estacion AND Clave > @Proveedor
 END

RETURN
END
GO



/**************** spSucursalDireccionFiscalMapear ****************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spSucursalDireccionFiscalMapear') AND type = 'P') DROP PROCEDURE dbo.spSucursalDireccionFiscalMapear
GO 
CREATE PROC spSucursalDireccionFiscalMapear
 @Estacion    int
--//WITH ENCRYPTION
AS BEGIN
DECLARE 
 @Sucursal       int,
 @ID             int,
 @ClaveCP        varchar(5),
 @ClavePais      varchar(3),
 @ClaveEstado    varchar(3),
 @ClaveMunicipio varchar(3),
 @ClaveLocalidad varchar(2),
 @ClaveColonia   varchar(4),

 @DescPais       varchar(255),
 @DescEstado     varchar(255),
 @DescMunicipio  varchar(255),
 @DescLocalidad  varchar(255),
 @DescColonia    varchar(255),

 @CodigoPostal   varchar(15)

 SELECT @Sucursal = MIN(Clave) FROM ListaSt WHERE Estacion = @Estacion
 WHILE @Sucursal IS NOT NULL
 BEGIN
  SELECT @CodigoPostal = NULL, @ClaveCP = NULL, @ClavePais = NULL, @ClaveEstado = NULL, @ClaveMunicipio = NULL, @ClaveLocalidad = NULL, @ClaveColonia = NULL,
         @DescPais = NULL, @DescEstado = NULL, @DescMunicipio = NULL, @DescLocalidad = NULL, @DescColonia = NULL
  SELECT @CodigoPostal = CodigoPostal FROM Sucursal WHERE Sucursal = @Sucursal

  --- Verificar que exista el Código Postal y solo tenga una Colonia
  IF ISNULL(@CodigoPostal,'') <> '' AND ((SELECT COUNT(1) FROM SATDireccionFiscal WHERE ClaveCP = @CodigoPostal) = 1)
   BEGIN 
    SELECT @ClaveCP = ClaveCP, @ClavePais = ClavePais, @DescPais = SATPaisDescripcion,
	  @ClaveEstado = ClaveEstado, @DescEstado = SATEstadoDescripcion, @ClaveMunicipio = ClaveMunicipio, 
	  @DescMunicipio =  SATMunicipioDescripcion, @ClaveLocalidad = ClaveLocalidad,  @DescLocalidad = SATLocalidadDescripcion,
	  @ClaveColonia = ClaveColonia, @DescColonia = SATColoniaDescripcion
	  FROM SATDireccionFiscal WHERE ClaveCP = @CodigoPostal

    -- Actualizar Direccion del Cliente
	IF ISNULL(@ClaveCP,'') <> '' AND ISNULL(@ClavePais,'') <> '' AND ISNULL(@ClaveEstado,'') <> '' AND ISNULL(@ClaveMunicipio,'') <> '' 
	   AND ISNULL(@ClaveColonia,'') <> '' -- AND ISNULL(@ClaveLocalidad,'') <> ''
	BEGIN
	 UPDATE SucursalDireccionFiscal SET Mapeado = 1, Icono = 434, ClaveCP = @ClaveCP, ClavePais = @ClavePais, ClaveEstado = @ClaveEstado,
	        ClaveMunicipio = @ClaveMunicipio, ClaveLocalidad = @ClaveLocalidad, ClaveColonia = @ClaveColonia 
	  WHERE Sucursal = @Sucursal AND ISNULL(Mapeado,0) = 0

     UPDATE Sucursal SET Delegacion = @DescMunicipio, Colonia = @DescColonia, CodigoPostal = @ClaveCP, 
	         Poblacion = @DescLocalidad, Estado = @DescEstado, Pais = @DescPais WHERE Sucursal = @Sucursal
	END
   END

  SELECT @Sucursal = MIN(Clave) FROM ListaSt WHERE Estacion = @Estacion AND Clave > @Sucursal
 END

RETURN
END
GO