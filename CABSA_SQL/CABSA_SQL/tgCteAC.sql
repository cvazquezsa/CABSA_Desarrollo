ALTER TRIGGER tgCteAC ON Cte
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
DECLARE 
    @RFCNuevo  varchar(20),
    @RegistroDup varchar(50),
    @ClaveNueva   varchar(10),
    @ClienteDup   varchar(10),
    @Mensaje   varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN

  SELECT @RFCNuevo = RFC, @ClaveNueva = Cliente FROM Inserted


  IF UPDATE(Nombre) OR UPDATE(NombreCorto) OR UPDATE(Direccion) OR UPDATE(Delegacion) OR UPDATE(Colonia) OR UPDATE(Poblacion) OR
     UPDATE(Estado) OR UPDATE(Pais) OR UPDATE(Zona) OR UPDATE(CodigoPostal) OR UPDATE(RFC) OR UPDATE(CURP) OR UPDATE(IEPS) OR UPDATE(PITEX) OR UPDATE(Tipo) OR
     UPDATE(Situacion) OR UPDATE(Credito) OR UPDATE(ZonaImpuesto) OR UPDATE(Descuento) OR UPDATE(Agente) OR UPDATE(AgenteServicio) OR UPDATE(EnviarA) OR UPDATE(Proyecto) OR
     UPDATE(FormaEnvio) OR UPDATE(Condicion) OR UPDATE(Ruta) OR UPDATE(ListaPrecios) OR UPDATE(ListaPreciosEsp) OR 
     UPDATE(DefMoneda) OR UPDATE(NivelAcceso) OR UPDATE(Estatus) 
  INSERT CteHist (Cliente, Fecha,  Nombre, NombreCorto, Direccion, Delegacion, Colonia,
                  Poblacion, Estado, Pais, Zona, CodigoPostal, RFC, CURP, IEPS, PITEX, Tipo, Situacion, Credito, ZonaImpuesto, Descuento, Agente, AgenteServicio,
                  EnviarA, Proyecto, FormaEnvio, Condicion, Ruta, ListaPrecios, ListaPreciosEsp, DefMoneda, NivelAcceso, Estatus, Usuario)
           SELECT Cliente, GETDATE(), Nombre, NombreCorto, Direccion, Delegacion, Colonia,
                  Poblacion, Estado, Pais, Zona, CodigoPostal, RFC, CURP, IEPS, PITEX, Tipo, Situacion, Credito, ZonaImpuesto, Descuento, Agente, AgenteServicio,
                  EnviarA, Proyecto, FormaEnvio, Condicion, Ruta, ListaPrecios, ListaPreciosEsp, DefMoneda, NivelAcceso, Estatus, Usuario
             FROM Inserted


-- Valida RFC Duplicados
  SELECT @ClienteDup = NULL
  IF NULLIF(@RFCNuevo, '') IS NOT NULL 
		AND @RFCNuevo NOT IN (SELECT Valor FROM RFCValidos WHERE Tipo='RFC')
		--('XAXX010101000', 'XEXX010101000','CAB9709029E1', 'LMA020930RJ5', 'MEAU640129RR3', 'MEMU950315FC4', 'BHD1002044F3', 'SNT440216TUA', 'ACB7609076M2', 'FAS8610203V5', 'PBF031104K27', 'DCO940630FM4')	
 --JGD 06Junio2011 Ticket 4857
  BEGIN
    SELECT @ClienteDup = MIN(Cliente) FROM CTE WHERE RFC = @RFCNuevo AND Cliente <> @ClaveNueva 
    IF @ClienteDup IS NOT NULL SELECT @RegistroDup = 'RFC - ' + @RFCNuevo
  END

  IF @ClienteDup IS NOT NULL 
  BEGIN
    SELECT @Mensaje = 'Error al Actualizar a "'+RTRIM(@ClaveNueva)+'", la clave del "'+@RegistroDup+'", ya Existe en la Persona "'+LTRIM(RTRIM(@ClienteDup))+ '".' 
    RAISERROR (@Mensaje,16,-1) 
  END

END
GO


ALTER TRIGGER tgCteBC ON Cte
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE   
    @ClaveNueva  	varchar(10),
    @ClaveAnterior	varchar(10),
    @TipoNuevo		varchar(15),
    @TipoAnterior	varchar(15),
    @NombreNuevo	varchar(100),
    @NombreAnterior	varchar(100),
    @RFCNuevo		varchar(20),
    @RFCAnterior	varchar(20),
    @CURPNuevo		varchar(30),
    @CURPAnterior	varchar(30),
    @Mensaje 		varchar(255),
    @RutaA		varchar(100),
    @RutaN		varchar(100),
    @NombreA	      	varchar(100),
    @NombreN	      	varchar(100),
    @DireccionA 	varchar(100),
    @DireccionN 	varchar(100),
    @EntreCallesA	varchar(100),
    @EntreCallesN	varchar(100),
    @PlanoA		varchar(100),
    @PlanoN		varchar(100),
    @ObservacionesA	varchar(100),
    @ObservacionesN	varchar(100),
    @ColoniaA 		varchar(100),
    @ColoniaN 		varchar(100),
    @PoblacionA		varchar(100),
    @PoblacionN		varchar(100),
    @EstadoA 		varchar(100),
    @EstadoN 		varchar(100),
    @PaisA 		varchar(100),
    @PaisN 		varchar(100),
    @CodigoPostalA 	varchar(100),
    @CodigoPostalN 	varchar(100),
    @TelefonosA		varchar(100),
    @TelefonosN		varchar(100),
    @Contacto1A		varchar(100),
    @Contacto1N		varchar(100),
    @Contacto2A		varchar(100),
    @Contacto2N		varchar(100),
    @Extencion1A 	varchar(100),
    @Extencion1N 	varchar(100),
    @Extencion2A 	varchar(100),
    @Extencion2N 	varchar(100),
    @ClienteDup  	varchar(10),
    @RegistroDup	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ClaveNueva = Cliente, @TipoNuevo = Tipo, @NombreNuevo = Nombre, @RFCNuevo = RFC, @CURPNuevo = CURP, 
         @RutaN = Ruta, @NombreN = Nombre, @DireccionN = Direccion, @EntreCallesN = EntreCalles, @PlanoN = Plano, @ObservacionesN = Observaciones,
         @ColoniaN = Colonia, @PoblacionN = Poblacion, @EstadoN = Estado, @PaisN = Pais, @CodigoPostalN = CodigoPostal, @TelefonosN = Telefonos,
         @Contacto1N = Contacto1, @Contacto2N = Contacto2, @Extencion1N = Extencion1, @Extencion2N = Extencion2
    FROM Inserted
  SELECT @ClaveAnterior = Cliente, @TipoAnterior = Tipo, @NombreAnterior = Nombre, @RFCAnterior = RFC, @CURPAnterior = CURP ,
         @RutaA = Ruta, @NombreA = Nombre, @DireccionA = Direccion, @EntreCallesA = EntreCalles, @PlanoA = Plano, @ObservacionesA = Observaciones,
         @ColoniaA = Colonia, @PoblacionA = Poblacion, @EstadoA = Estado, @PaisA = Pais, @CodigoPostalA = CodigoPostal, @TelefonosA = Telefonos,
         @Contacto1A = Contacto1, @Contacto2A = Contacto2, @Extencion1A = Extencion1, @Extencion2A = Extencion2
    FROM Deleted

-- Valida RFC Duplicados
  SELECT @ClienteDup = NULL
  IF NULLIF (@RFCNuevo,'') IS NOT NULL AND @RFCNuevo NOT IN ('XAXX010101000', 'XEXX010101000') AND @RFCNuevo NOT IN (SELECT Valor FROM RFCValidos WHERE Tipo='RFC') --JGD 06Junio2011 Ticket 4857
  BEGIN
    SELECT @ClienteDup = MIN(Cliente) FROM CTE WHERE RFC = @RFCNuevo AND Cliente <> @ClaveNueva 
    IF @ClienteDup IS NOT NULL SELECT @RegistroDup = 'RFC - ' + @RFCNuevo
  END

  IF @ClienteDup IS NOT NULL 
  BEGIN
    SELECT @Mensaje = 'Error al Actualizar a "'+RTRIM(@ClaveNueva)+'", la clave del "'+@RegistroDup+'", ya Existe en la Persona "'+LTRIM(RTRIM(@ClienteDup))+ '".' 
    RAISERROR (@Mensaje,16,-1) 
  END

  /*IF @NombreNuevo <> @NombreAnterior OR @RFCNuevo <> @RFCAnterior OR @CURPNuevo <> @CURPAnterior*/

  IF ISNULL(@RutaA, '') <> ISNULL(@RutaN, '') OR ISNULL(@NombreA, '') <> ISNULL(@NombreN, '') OR ISNULL(@DireccionA, '') <> ISNULL(@DireccionN, '') OR ISNULL(@EntreCallesA, '') <> ISNULL(@EntreCallesN, '') OR ISNULL(@PlanoA, '') <> ISNULL(@PlanoN, '') OR
     ISNULL(@ObservacionesA, '') <> ISNULL(@ObservacionesN, '') OR ISNULL(@ColoniaA, '') <> ISNULL(@ColoniaN, '') OR ISNULL(@PoblacionA, '') <> ISNULL(@PoblacionN, '') OR  ISNULL(@EstadoA, '') <> ISNULL(@EstadoN, '') OR ISNULL(@PaisA, '') <> ISNULL(@PaisN, '') OR
     ISNULL(@CodigoPostalA, '') <> ISNULL(@CodigoPostalN, '') OR ISNULL(@TelefonosA, '') <> ISNULL(@TelefonosN, '') OR ISNULL(@Contacto1A, '') <> ISNULL(@Contacto1N, '') OR ISNULL(@Contacto2A, '') <> ISNULL(@Contacto2N, '') OR 
     ISNULL(@Extencion1A, '') <> ISNULL(@Extencion1N, '') OR ISNULL(@Extencion2A, '') <> ISNULL(@Extencion2N, '')
  UPDATE EmbarqueMov
    WITH (ROWLOCK) 
     SET Ruta		= i.Ruta,
	 Nombre	      	= i.Nombre, 
	 NombreEnvio  	= i.Nombre, 
	 Direccion 	= i.Direccion,
	 EntreCalles	= i.EntreCalles,
	 Plano		= i.Plano,
	 Observaciones	= i.Observaciones,
	 Colonia 	= i.Colonia,
	 Poblacion 	= i.Poblacion,
	 Estado 	= i.Estado,
	 Pais 		= i.Pais,
	 CodigoPostal 	= i.CodigoPostal,
	 Telefonos	= i.Telefonos,
	 Contacto1 	= i.Contacto1,
	 Contacto2 	= i.Contacto2,
         Extencion1 	= i.Extencion1,
         Extencion2 	= i.Extencion2
    FROM Inserted i, EmbarqueMov e
   WHERE e.Cliente = i.Cliente AND e.Cliente = @ClaveNueva AND NULLIF(e.ClienteEnviarA, 0) IS NULL AND e.Concluido = 0
  
  IF @ClaveNueva=@ClaveAnterior AND @TipoNuevo=@TipoAnterior RETURN

  IF @ClaveNueva IS NULL
  BEGIN
    IF EXISTS (SELECT * FROM Cte WHERE Rama = @ClaveAnterior)
    BEGIN
      SELECT @Mensaje = '"'+LTRIM(RTRIM(@ClaveAnterior))+ '" ' + Descripcion FROM MensajeLista WHERE Mensaje = 30165
      RAISERROR (@Mensaje,16,-1) 
    END ELSE
    BEGIN
      DELETE CteEnviarA  	  WHERE Cliente = @ClaveAnterior
      DELETE CteEnviarAOtrosDatos WHERE Cliente = @ClaveAnterior
      DELETE CteRep	  	  WHERE Cliente = @ClaveAnterior
      DELETE CteBonificacion  	  WHERE Cliente = @ClaveAnterior
      DELETE CteCto	  	  WHERE Cliente = @ClaveAnterior
      DELETE CteAcceso	 	  WHERE Cliente = @ClaveAnterior
      DELETE CteTel	 	  WHERE Cliente = @ClaveAnterior
      DELETE CteUEN	 	  WHERE Cliente = @ClaveAnterior
      DELETE CteOtrosDatos 	  WHERE Cliente = @ClaveAnterior
      DELETE CteCapacidadPago 	  WHERE Cliente = @ClaveAnterior
      DELETE Sentinel  		  WHERE Cliente = @ClaveAnterior
      DELETE CteCFD  		  WHERE Cliente = @ClaveAnterior
      DELETE CteEmpresaCFD	  WHERE Cliente = @ClaveAnterior
      DELETE CteDepto  		  WHERE Cliente = @ClaveAnterior
      DELETE CteEntregaMercancia  WHERE Cliente = @ClaveAnterior
      DELETE CteEstadoFinanciero  WHERE Cliente = @ClaveAnterior
      DELETE Prop        	  WHERE Cuenta  = @ClaveAnterior AND Rama='CXC'
      DELETE ListaD	 	  WHERE Cuenta  = @ClaveAnterior AND Rama='CXC'
      DELETE AnexoCta    	  WHERE Cuenta  = @ClaveAnterior AND Rama='CXC'
      DELETE CuentaTarea 	  WHERE Cuenta  = @ClaveAnterior AND Rama='CXC'
	  DELETE CtoCampoExtra    WHERE Tipo   = 'Cliente' AND Clave = @ClaveAnterior
	  DELETE FormaExtraValor  WHERE Aplica = 'Cliente' AND AplicaClave = @ClaveAnterior
	  DELETE FormaExtraD      WHERE Aplica = 'Cliente' AND AplicaClave = @ClaveAnterior
    END
  END ELSE
  IF @ClaveNueva <> @ClaveAnterior
  BEGIN
     IF (SELECT Sincro FROM Version) = 1
       EXEC sp_executesql N'UPDATE Cte SET Rama = @ClaveNueva, SincroC = SincroC WHERE Rama = @ClaveAnterior', N'@ClaveNueva varchar(20), @ClaveAnterior varchar(20)', @ClaveNueva = @ClaveNueva, @ClaveAnterior = @ClaveAnterior
     ELSE
       UPDATE Cte SET Rama = @ClaveNueva WHERE Rama = @ClaveAnterior

    UPDATE CteEnviarA  		SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE CteEnviarAOtrosDatos SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE CteRep  		SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE CteBonificacion  	SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE CteCto	  	SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE CteAcceso	  	SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE CteTel	  	SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE CteUEN	  	SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE CteOtrosDatos  	SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE CteCapacidadPago 	SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE Sentinel		SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE CteCFD		SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE CteEmpresaCFD	SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE CteDepto		SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE CteEntregaMercancia	SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE CteEstadoFinanciero	SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE Prop        		SET Cuenta  = @ClaveNueva WHERE Cuenta  = @ClaveAnterior AND Rama='CXC'
    UPDATE ListaD      		SET Cuenta  = @ClaveNueva WHERE Cuenta  = @ClaveAnterior AND Rama='CXC'
    UPDATE AnexoCta    		SET Cuenta  = @ClaveNueva WHERE Cuenta  = @ClaveAnterior AND Rama='CXC'
    UPDATE CuentaTarea 		SET Cuenta  = @ClaveNueva WHERE Cuenta  = @ClaveAnterior AND Rama='CXC'
	UPDATE CtoCampoExtra	SET Clave   = @ClaveNueva WHERE Clave   = @ClaveAnterior AND Tipo='Cliente'
	UPDATE FormaExtraValor	SET AplicaClave   = @ClaveNueva WHERE AplicaClave   = @ClaveAnterior AND Aplica='Cliente'
	UPDATE FormaExtraD	    SET AplicaClave   = @ClaveNueva WHERE AplicaClave   = @ClaveAnterior AND Aplica='Cliente'
  END
END
GO
