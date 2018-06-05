SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF
SET ANSI_WARNINGS OFF
GO
/*************************     funcion fnDivideRenglon     *********************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('fnDivideRenglon')) 
	DROP FUNCTION fnDivideRenglon
GO
CREATE FUNCTION dbo.fnDivideRenglon
			   (@Cadena		varchar(max),
				@Cantidad	int) 
RETURNS VARCHAR(MAX) 
BEGIN 
  DECLARE
    @len         int,
	@cadenanueva varchar(max),
	@cadenaaux   varchar(max),
	@caracteres  int
    
    SET @len = LEN(@cadena)
    SET @cadenanueva =''
    SET @cadenaaux = ''
    SET @caracteres = @Cantidad
	WHILE (LEN(@cadena) > 0)
	BEGIN
		SET @cadenaaux = SUBSTRING(@cadena,0,@caracteres) + CHAR(10)+CHAR(13)
		SET @cadena= SUBSTRING(@cadena,@caracteres,LEN(@cadena))
		SET @len = LEN(@cadena)
	    
		SET @cadenanueva = @cadenanueva + @cadenaaux
		SET @cadenaaux = ''
	END
   
    RETURN @cadenanueva     
END
GO
/******************************* spMovCartaPorte *************************************************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('spMovCartaPorte') AND type = 'P') 
	DROP PROCEDURE spMovCartaPorte
GO

CREATE PROCEDURE spMovCartaPorte
(
	@Estacion		varchar(5),
	@Empresa		varchar(5),
	@Modulo			varchar(5),
	@FechaInicio	datetime,
	@FechaFin		datetime
)
--//WITH ENCRYPTION
AS
BEGIN
	DECLARE
		@Ruta		varchar(255),
		@Ok			int,
		@OkRef		varchar(255)
			
	IF @Modulo = 'VTAS'
		BEGIN
			DELETE FROM MovCartaPorteD WHERE Estacion = @Estacion AND Modulo = @Modulo
			DELETE FROM MovCartaPorte WHERE Estacion = @Estacion AND Modulo = @Modulo
			
			INSERT MovCartaPorte(Estacion, Modulo, ModuloID, Mov, MovID, Sucursal, 
								 Almacen, Cliente, Condicion, FormaPago, Moneda, NoCertificado,
								 NoCertificadoSAT, CadenaOriginal, UUID, EmbarqueID, Proveedor, Ruta, Observaciones,
								 FechaTimbrado) 
						  SELECT @Estacion, @Modulo, A.ID, A.Mov, A.MovID, A.Sucursal, 
								 A.Almacen, A.Cliente, A.Condicion, A.FormaPagoTipo, A.Moneda, B.NoCertificado,
								 B.NoCertificadoSAT, B.CadenaOriginal, B.UUID, E.ID, G.Proveedor,
								 REPLACE(									
									REPLACE(
										REPLACE(C.RutaCartaPorte,'<Empresa>','\'+@Empresa),
									'<Ejercicio>','\'+CAST(YEAR(A.FechaEmision) as varchar(4))),
								 '<Periodo>','\'+CAST(MONTH(A.FechaEmision) as varchar(2))),
								 ISNULL(E.Observaciones,''),
								 B.FechaTimbrado
							FROM Venta A
							JOIN CFD B ON B.ModuloID = A.ID
							JOIN MovTipo C ON C.Mov = A.Mov
							JOIN EmbarqueMov D ON D.ModuloID = A.ID
							JOIN Embarque E ON E.ID = D.AsignadoID
							JOIN Vehiculo F ON F.Vehiculo = E.Vehiculo
					   LEFT JOIN Prov G ON G.Proveedor = F.Proveedor
						   WHERE A.FechaEmision >= @FechaInicio
						     AND A.FechaEmision <= @FechaFin
						     AND A.Empresa = @Empresa
						     AND B.Modulo = @Modulo
						     AND C.Modulo = @Modulo
						     AND ISNULL(C.CartaPorte,0) = 1
						     AND A.Estatus = C.EstatusCartaPorte
						     AND B.UUID IS NOT NULL
			INSERT MovCartaPorteD(Estacion, Modulo, ModuloID, Renglon, RenglonSub, Articulo, Cantidad,
								  Unidad, Precio, Importe, Impuestos, Retenciones)
						   SELECT @Estacion, @Modulo, B.ID, B.Renglon, B.RenglonSub, B.Articulo, B.Cantidad,
								  B.Unidad, B.Precio, B.Cantidad*B.Precio, ISNULL(B.Impuesto1,0)+ISNULL(B.Impuesto1,0)+ISNULL(B.Impuesto1,0), ISNULL(B.Retencion1,0)+ISNULL(B.Retencion2,0)+ISNULL(B.Retencion3,0)
						     FROM MovCartaPorte A
						     JOIN VentaD B ON B.ID = A.ModuloID
						    WHERE A.Estacion = @Estacion
			
			
			DECLARE cRuta CURSOR FOR
			SELECT DISTINCT B.Ruta
			  FROM MovTipo A
			  JOIN MovCartaPorte B 
			    ON A.Modulo = B.Modulo 
			   AND A.Mov = B.Mov
			 WHERE B.Estacion = @Estacion
			
			OPEN cRuta
			FETCH NEXT FROM cRuta INTO @Ruta
			
			WHILE @@FETCH_STATUS = 0
			BEGIN 
				EXEC spCrearRuta @Ruta, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
				
				IF ISNULL(@Ok,0) = 0
				FETCH NEXT FROM cRuta INTO @Ruta
				ELSE
				BREAK
			END
			
			CLOSE cRuta
			DEALLOCATE cRuta
			
			IF ISNULL(@Ok,0) <> 0
				BEGIN
					DELETE FROM MovCartaPorteD WHERE Estacion = @Estacion AND Modulo = @Modulo
					DELETE FROM MovCartaPorte WHERE Estacion = @Estacion AND Modulo = @Modulo
					SELECT @OkRef
				END
		END

END
GO

/******************************* spRepCartaPorte *************************************************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('spRepCartaPorte') AND type = 'P') 
	DROP PROCEDURE spRepCartaPorte
GO
CREATE PROCEDURE spRepCartaPorte
(
	@Estacion		int,
	@Modulo			varchar(5),
	@Empresa		varchar(5),
	@ID				int
)
--//WITH ENCRYPTION
AS
BEGIN
	
	IF @Modulo = 'VTAS'
	BEGIN
			
		SELECT A.ModuloID, ISNULL(F.Direccion,'') AS Calle, ISNULL(F.DireccionNumero,'') AS NumeroExt, ISNULL(F.DireccionNumeroInt,'') AS NumeroInt, 
			   ISNULL(F.Delegacion,'') AS Delegacion, ISNULL(F.Colonia,'') AS Colonia, ISNULL(F.Poblacion,'') AS Poblacion, ISNULL(F.Estado,'') AS Estado,
			   ISNULL(F.CodigoPostal,'') AS CodigoPostal, ISNULL(F.RFC,'') AS RFC,dbo.fnDivideRenglon(A.CadenaOriginal,140) AS CadenaOriginal, A.NoCertificado,
			   A.NoCertificadoSAT, A.UUID, ISNULL(A.Condicion,'NA') AS Condicion, ISNULL(A.FormaPago,'') AS FormaPago, ISNULL(A.Moneda,'') AS Moneda,
			   ISNULL(D.Direccion,'') AS CalleCte, ISNULL(D.DireccionNumero,'') AS NumeroExtCte, ISNULL(D.DireccionNumeroInt,'') AS NumeroIntCte, ISNULL(D.Delegacion,'') AS DelegacionCte, 
			   ISNULL(D.Colonia,'') AS ColoniaCte, ISNULL(D.Poblacion,'') AS PoblacionCte, ISNULL(D.Estado,'') AS EstadoCte, ISNULL(D.CodigoPostal,'') AS CodigoPostalCte,
			   ISNULL(D.RFC,'') AS RFCCte, ISNULL(B.Importe,0) AS Importe, ISNULL(B.Impuestos,0) AS Impuestos, ISNULL(B.Retenciones,0) AS Retenciones,
			   ISNULL(E.Direccion,'') AS CalleAlm, ISNULL(E.Colonia, '') AS ColoniaAlm, ISNULL(E.Delegacion,'') AS DelegacionAlm, ISNULL(E.Poblacion, '') AS PoblacionAlm, 
			   ISNULL(E.Estado,'') AS EstadoAlm, ISNULL(G.Descripcion1,'')+' '+ISNULL(G.Descripcion2,'') AS ArtNombre, B.Cantidad, B.Unidad, 
			   B.Precio, H.Nombre AS NombreEmpresa, D.Nombre AS NombreCte, ISNULL(A.Observaciones,'') AS Observaciones,
			   II.Mov AS Embarque, I.Importe AS ImporteEmb, ISNULL(I.Impuestos,0) AS ImpuestosEmb, I.Peso, 
			   I.Volumen, I.Paquetes, 
			   CASE WHEN ISNULL(K.Proveedor,'') = '' THEN ISNULL(H.RFC,'') ELSE ISNULL(K.RFC,'') END AS RFCProv,
			   CASE WHEN ISNULL(K.Proveedor,'') = '' THEN ISNULL(H.Nombre,'') ELSE ISNULL(K.Nombre,'') END AS NombreProv,
			   CASE WHEN ISNULL(K.Proveedor,'') = '' THEN ISNULL(H.FiscalRegimen,'') ELSE ISNULL(L.Descripcion,'') END AS RegimenFiscalProv,
			   CASE WHEN ISNULL(K.Proveedor,'') = '' THEN ISNULL(F.Direccion,'') ELSE ISNULL(K.Direccion,'') END AS CalleProv,
			   CASE WHEN ISNULL(K.Proveedor,'') = '' THEN ISNULL(F.DireccionNumero,'') ELSE ISNULL(K.DireccionNumero,'') END AS NumeroExtProv,
			   CASE WHEN ISNULL(K.Proveedor,'') = '' THEN ISNULL(F.DireccionNumeroInt,'') ELSE ISNULL(K.DireccionNumeroInt,'') END AS NumeroIntProv,
			   CASE WHEN ISNULL(K.Proveedor,'') = '' THEN ISNULL(F.Colonia,'') ELSE ISNULL(K.Colonia,'') END AS ColoniaProv,
			   CASE WHEN ISNULL(K.Proveedor,'') = '' THEN ISNULL(F.Delegacion,'') ELSE ISNULL(K.Delegacion,'') END AS DelegacionProv,
			   CASE WHEN ISNULL(K.Proveedor,'') = '' THEN ISNULL(F.Poblacion,'') ELSE ISNULL(K.Poblacion,'') END AS PoblacionProv,
			   CASE WHEN ISNULL(K.Proveedor,'') = '' THEN ISNULL(F.Estado,'') ELSE ISNULL(K.Estado,'') END AS EstadoProv,
			   CASE WHEN ISNULL(K.Proveedor,'') = '' THEN ISNULL(F.CodigoPostal,'') ELSE ISNULL(K.CodigoPostal,'') END AS CodigoPostalProv,
			   A.FechaTimbrado, G.MaterialPeligroso, I.Vencimiento
		  FROM MovCartaPorte A
		  JOIN MovCartaPorteD B ON B.ModuloID = A.ModuloID AND B.Modulo = A.Modulo
		  JOIN ListaID C ON C.Estacion = A.Estacion AND C.ID = A.ModuloID
		  JOIN Cte D ON D.Cliente = A.Cliente
		  JOIN Alm E ON E.Almacen = A.Almacen
		  JOIN Sucursal F ON F.Sucursal = A.Sucursal
		  JOIN Art G ON G.Articulo = B.Articulo
		  JOIN Empresa H ON H.Empresa = @Empresa
		  JOIN EmbarqueMov I ON I.AsignadoID = A.EmbarqueID
		  JOIN Embarque II ON II.ID = I.AsignadoID
		  JOIN EmbarqueD J ON J.ID = I.AsignadoID
	 LEFT JOIN Prov K ON K.Proveedor = A.Proveedor
	 LEFT JOIN FiscalRegimen L ON L.FiscalRegimen = K.FiscalRegimen
		 WHERE C.Estacion = @Estacion
		   AND A.ModuloID = @ID
	END	   
END
GO

/******************************* spRepCartaPortePDF *************************************************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('spRepCartaPortePDF') AND type = 'P') 
	DROP PROCEDURE spRepCartaPortePDF
GO
CREATE PROCEDURE spRepCartaPortePDF
(
	@Modulo			varchar(5),
	@ID				int,
	@Sucursal		int,
	@Nombre			varchar(255),
	@Ruta			varchar(255)
)
--//WITH ENCRYPTION
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM AnexoMov WHERE Rama = @Modulo AND ID = @ID AND Nombre = @Nombre)
		INSERT AnexoMov(Rama, ID, Nombre, Direccion, Icono, Tipo, Orden, Comentario, Sucursal, CFD)
				 VALUES(@Modulo, @ID, @Nombre, @Ruta, 745, 'Archivo', 1, '', @Sucursal, 0)

END
GO