/*  5-01-2004 Regresa los datos de acuerdo a lo requerido */
SET QUOTED_IDENTIFIER OFF
GO
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[spSB]'))
DROP PROCEDURE [dbo].[spSB]
GO
CREATE PROCEDURE spSB
		@Id		INT
--//WITH ENCRYPTION
AS

DECLARE @Proceso	VARCHAR(20),
	@Dimension	VARCHAR(50),
	@NDimension	VARCHAR(20),
	@Tipo		VARCHAR(20),
	@CId		VARCHAR(4),
	@Cadena		VARCHAR(1000),
	@Campos		VARCHAR(1000),
	@Groupby	VARCHAR(1000),
	@FiltroActual	VARCHAR(1000),
	@FiltroAnterior	VARCHAR(1000),
	@FiltroPresupuesto VARCHAR(500),
	@Tabla		VARCHAR(20),
	@Titulo		VARCHAR(20),
	@Catalogo	VARCHAR(20),
	@LlaveCatalogo	VARCHAR(50),
	@LlaveDimension VARCHAR(50),
	@Join		VARCHAR(200),
	@Dato		VARCHAR(20),
	@Orden		INT,
	@UsarDescripcion BIT

SELECT @Proceso 	= Proceso, 
	@Dimension 	= Dimension , 
	@NDimension 	= 'N' + Dimension , 
	@Tipo 		= Tipo, 
	@FiltroActual 	= CASE WHEN FiltroActual IS NULL THEN '' ELSE ' AND ' +  FiltroActual END,
	@FiltroAnterior = CASE WHEN FiltroAnterior IS NULL THEN '' ELSE ' AND ' +  FiltroAnterior END,
	@FiltroPresupuesto = CASE WHEN FiltroPresupuesto IS NULL THEN '' ELSE ' AND ' +  FiltroPresupuesto END,
	@Orden 		= Orden
FROM SBTrabajo 
WHERE Id =  @Id

SET @CId = RTRIM(CONVERT(CHAR(4),@ID))

DELETE FROM SBTotales WHERE ID_Proceso = @ID

SELECT @Tabla = Tabla + '.',
	@Titulo = NombreCampo,
	@Catalogo = Catalogo + '.',
	@UsarDescripcion = UsarDescripcion,
	@LlaveCatalogo = LlaveCatalogo,
	@LlaveDimension = LlaveDimension
FROM SBProcesoDimension 
WHERE Proceso=@Proceso 
	AND Dimension = @Dimension

SET @Join = ''

IF @Catalogo IS NULL
BEGIN
	SET @Dato = @Dimension
	SET @Catalogo = @Tabla
	SET @LlaveDimension = @Dimension
END
ELSE
BEGIN
	SET @Dato = @Titulo
	SET @Join = 'LEFT OUTER JOIN ' + SUBSTRING(@Catalogo,1,LEN(@Catalogo)-1) + ' ON ' + @Tabla + ISNULL(@LlaveDimension,@Dimension) + ' = ' + @Catalogo  + ISNULL(@LlaveCatalogo,@Dimension)
	IF @LlaveCatalogo IS NULL	
		SET @LlaveDimension = @Dimension
	ELSE
		SET @LlaveDimension = @Titulo

END

SET @Campos = 'SELECT ' +  @CId + ',' + @Tabla + @LlaveDimension + ',' + @Catalogo +  @Dato + ',' 
SET @Groupby = @Tabla + @LlaveDimension + ',' + @Catalogo +  @Dato

--- Proceso de Ventas
IF @Proceso = 'Ventas'
BEGIN
	IF @Tipo = 'Importe'
		SET @Cadena = 'SUM(SB_VTAS.Importe ) '		
	ELSE IF @Tipo = 'Cantidad'
		SET @Cadena = 'SUM(SB_VTAS.CantidadNeta) '
	ELSE
		SET @Cadena = 'CASE WHEN SUM(SB_VTAS.Importe ) > 0 ' 
			 +         ' THEN (SUM(SB_VTAS.Importe - SB_VTAS.CostoTotal) / SUM(SB_VTAS.Importe)) * 100 ' 
			 + 	   ' ELSE 0 END  '

		
	EXEC  ('INSERT SBTotales (Id_Proceso, Llave, Nombre, Presupuesto) ' 
		 + @Campos
		 + @Cadena	 
		 + 'FROM  SB_VTAS  '
		 + @Join
		 + " WHERE  SB_VTAS.Estatus = 'CONCLUIDO' AND SB_VTAS.Mov = 'Presupuesto' " 
		 + @FiltroPresupuesto
		 + ' GROUP BY '
		 + @Groupby)

	EXEC ('INSERT SBTotales (Id_Proceso, Llave,  Nombre, Actual) ' 
		 + @Campos
		 + @Cadena	 
		 + 'FROM  SB_VTAS  '
		 + @Join
		 + " WHERE  SB_VTAS.Estatus = 'CONCLUIDO' " 
		 + @FiltroActual
		 + ' GROUP BY '
		 + @Groupby)
	
	IF @FiltroAnterior IS NOT NULL
		EXEC  ('INSERT SBTotales (Id_Proceso, Llave, Nombre, Anterior) ' 
			 + @Campos
			 + @Cadena	 
			 + 'FROM  SB_VTAS '
			 + @Join
			 + " WHERE  SB_VTAS.Estatus = 'CONCLUIDO' " 
			 + @FiltroAnterior
			 + ' GROUP BY '
			  + @Groupby)
END

--- Proceso de cxp
IF @Proceso = 'CXP'
BEGIN
	IF @Tipo = 'Importe'
		SET @Cadena = 'SUM(SB_CXP.Importe ) '		
		
	EXEC  ('INSERT SBTotales (Id_Proceso, Llave, Nombre, Presupuesto) ' 
		 + @Campos
		 + @Cadena	 
		 + 'FROM  SB_CXP  '
		 + @Join
		 + " WHERE  SB_CXP.Estatus = 'CONCLUIDO' AND SB_CXP.Mov = 'Presupuesto' " 
		 + @FiltroPresupuesto
		 + ' GROUP BY '
		 + @Groupby)

	EXEC ('INSERT SBTotales (Id_Proceso, Llave,  Nombre, Actual) ' 
		 + @Campos
		 + @Cadena	 
		 + 'FROM  SB_CXP  '
		 + @Join
		 + " WHERE  SB_CXP.Estatus = 'CONCLUIDO' " 
		 + @FiltroActual
		 + ' GROUP BY '
		 + @Groupby)
	
	IF @FiltroAnterior IS NOT NULL
		EXEC  ('INSERT SBTotales (Id_Proceso, Llave, Nombre, Anterior) ' 
			 + @Campos
			 + @Cadena	 
			 + 'FROM  SB_CXP '
			 + @Join
			 + " WHERE  SB_CXP.Estatus = 'CONCLUIDO' " 
			 + @FiltroAnterior
			 + ' GROUP BY '
			 + @Groupby)
END

--- Proceso de Atencion de clientes
IF @Proceso = 'Soporte'
BEGIN
	IF @Tipo = 'Cantidad'
		SET @Cadena = 'SUM(SB_STCTE.Cantidad) '		


	EXEC  ('INSERT SBTotales (Id_Proceso, Llave, Nombre, Presupuesto) ' 
		 + @Campos
		 + @Cadena	 
		 + 'FROM  SB_STCTE  '
		 + @Join
		 + " WHERE  SB_STCTE.Estatus = 'CONCLUIDO' AND SB_STCTE.Mov = 'Presupuesto' " 
		 + @FiltroPresupuesto
		 + ' GROUP BY '
		 + @Groupby)

	EXEC ('INSERT SBTotales (Id_Proceso, Llave,  Nombre, Actual) ' 
		 + @Campos
		 + @Cadena	 
		 + 'FROM  SB_STCTE  '
		 + @Join
		 + " WHERE  SB_STCTE.Estatus = 'CONCLUIDO' " 
		 + @FiltroActual
		 + ' GROUP BY '
		 + @Groupby)
	
	IF @FiltroAnterior IS NOT NULL
		EXEC  ('INSERT SBTotales (Id_Proceso, Llave, Nombre, Anterior) ' 
			 + @Campos
			 + @Cadena	 
			 + 'FROM  SB_STCTE '
			 + @Join
			 + " WHERE  SB_STCTE.Estatus = 'CONCLUIDO' " 
			 + @FiltroAnterior
			 + ' GROUP BY '
			 + @Groupby)
END

--- proceso de Compras
IF @Proceso = 'Compras'
BEGIN
IF @Tipo = 'Importe'
		SET @Cadena = 'SUM(SB_COMS.ImporteTotal ) '		
	ELSE IF @Tipo = 'Cantidad'
		SET @Cadena = 'SUM(SB_VTAS.CantidadNeta) '

		
	EXEC  ('INSERT SBTotales (Id_Proceso, Llave, Nombre, Presupuesto) ' 
		 + @Campos
		 + @Cadena	 
		 + 'FROM  SB_COMS  '
		 + @Join
		 + " WHERE  SB_COMS.Estatus = 'CONCLUIDO' AND SB_COMS.Mov = 'Presupuesto' " 
		 + @FiltroPresupuesto
		 + ' GROUP BY '
		 + @Groupby)

	EXEC ('INSERT SBTotales (Id_Proceso, Llave,  Nombre, Actual) ' 
		 + @Campos
		 + @Cadena	 
		 + 'FROM  SB_COMS  '
		 + @Join
		 + " WHERE  SB_COMS.Estatus = 'CONCLUIDO' " 
		 + @FiltroActual
		 + ' GROUP BY '
		 + @Groupby)
	
	IF @FiltroAnterior IS NOT NULL
		EXEC  ('INSERT SBTotales (Id_Proceso, Llave, Nombre, Anterior) ' 
			 + @Campos
			 + @Cadena	 
			 + 'FROM  SB_COMS '
			 + @Join
			 + " WHERE  SB_COMS.Estatus = 'CONCLUIDO' " 
			 + @FiltroAnterior
			 + ' GROUP BY '
			 + @Groupby)
END


--- Proceso de Gastos
IF @Proceso = 'Gastos'
BEGIN
	IF @Tipo = 'Importe'
		SET @Cadena = 'SUM(SB_GAS.ImporteTotal) '		
	ELSE IF @Tipo = 'Cantidad'
		SET @Cadena = 'SUM(SB_GAS.Cantidad ) '

	EXEC  ('INSERT SBTotales (Id_Proceso, Llave, Nombre, Presupuesto) ' 
		 + @Campos
		 + @Cadena	 
		 + 'FROM  SB_GAS  '
		 + @JOIN 
		 + " WHERE  SB_GAS.Mov = 'Presupuesto' AND SB_GAS.Estatus = 'CONCLUIDO' " 
		 + @FiltroPresupuesto
		 + ' GROUP BY '
		 + @Groupby)

	EXEC ('INSERT SBTotales (Id_Proceso, Llave, Nombre,  Actual) ' 
		 + @Campos
		 + @Cadena	 
		 + 'FROM  SB_GAS  '
		 + @JOIN 
		 + " WHERE  SB_GAS.Estatus = 'CONCLUIDO' " 
		 + @FiltroActual
		 + ' GROUP BY '
		 + @Groupby)
	
	IF @FiltroAnterior IS NOT NULL
		EXEC ('INSERT SBTotales (Id_Proceso, Llave,  Nombre,  Anterior) ' 
			 + @Campos
			 + @Cadena	 
			 + 'FROM  SB_GAS  '
			 + @Join
			 + " WHERE  SB_GAS.Estatus = 'CONCLUIDO' " 
			 + @FiltroAnterior
			 + ' GROUP BY '
			 + @Groupby)
END

--- Proceso de CXC
IF @Proceso = 'CXC'
BEGIN
	IF @Tipo = 'Importe'
		SET @Cadena = 'SUM(SB_CXC.SaldoEnPesos) '		

	EXEC  ('INSERT SBTotales (Id_Proceso, Llave, Nombre, Presupuesto) ' 
		 + @Campos
		 + @Cadena	 
		 + 'FROM  SB_CXC  '
		 + @JOIN 
		 + " WHERE  SB_CXC.Mov = 'Presupuesto' AND SB_CXC.Estatus = 'PENDIENTE' " 
		 + @FiltroActual
		 + ' GROUP BY '
		 + @Groupby)

	EXEC ('INSERT SBTotales (Id_Proceso, Llave, Nombre,  Actual) ' 
		 + @Campos
		 + @Cadena	 
		 + 'FROM  SB_CXC '
		 + @JOIN 
		 + " WHERE  SB_CXC.Estatus = 'PENDIENTE' " 
		 + @FiltroActual
		 + ' GROUP BY '
		 + @Groupby)
	
	IF @FiltroAnterior IS NOT NULL
		EXEC ('INSERT SBTotales (Id_Proceso, Llave,  Nombre,  Anterior) ' 
			 + @Campos
			 + @Cadena	 
			 + 'FROM  SB_CXC  '
			 + @Join
			 + " WHERE  SB_CXC.Estatus = 'PENDIENTE' " 
			 + @FiltroAnterior
			 + ' GROUP BY '
			 + @Groupby)
END


--- Nomina
IF @Proceso = 'Nomina'
BEGIN
	IF @Tipo = 'Importe'
		SET @Cadena = 'SUM(SB_NOM.Importe) '		
	ELSE IF @Tipo = 'Cantidad'
		SET @Cadena = 'SUM(SB_NOM.Cantidad ) '

	
	EXEC  ('INSERT SBTotales (Id_Proceso, Llave, Nombre, Presupuesto) ' 
		 + @Campos
		 + @Cadena	 
		 + 'FROM  SB_NOM  '
		 + @JOIN 
		 + " WHERE  SB_NOM.Mov = 'Presupuesto' AND SB_NOM.Estatus = 'CONCLUIDO' " 
		 + @FiltroPresupuesto
		 + ' GROUP BY '
		 + @Groupby)

	EXEC ('INSERT SBTotales (Id_Proceso, Llave, Nombre,  Actual) ' 
		+ @Campos
		 + @Cadena	 
		 + 'FROM  SB_NOM  '
		 + @JOIN 
		 + " WHERE  SB_NOM.Estatus = 'CONCLUIDO' " 
		 + @FiltroActual
		 + ' GROUP BY '
		 + @Groupby)
	
	IF @FiltroAnterior IS NOT NULL
		EXEC ('INSERT SBTotales (Id_Proceso, Llave,  Nombre,  Anterior) ' 
		 	+ @Campos
			 + @Cadena	 
			 + 'FROM  SB_NOM  '
			 + @Join
			 + " WHERE  SB_NOM.Estatus = 'CONCLUIDO' " 
			 + @FiltroAnterior
			 + ' GROUP BY '
			 + @Groupby)
END



IF @orden = 0 OR @Orden IS NULL
	IF  @UsarDescripcion = 0
		SELECT	Llave Clave ,Nombre,Llave Dato,
			SUM(Actual) Actual,
			SUM(Anterior) Anterior,
			SUM(Presupuesto) Presupuesto
		FROM SBTotales
		WHERE Id_Proceso = @Id
		GROUP BY Llave,Nombre
		ORDER BY Llave
	ELSE
		SELECT	Llave Clave ,Nombre,Llave Dato,
			SUM(Actual) Actual,
			SUM(Anterior) Anterior,
			SUM(Presupuesto) Presupuesto
		FROM SBTotales
		WHERE Id_Proceso = @Id
		GROUP BY Llave,Nombre
		ORDER BY Nombre

IF @orden = 1 
	IF  @UsarDescripcion = 0
		SELECT	Llave Clave ,Nombre,Llave Dato,
			SUM(Actual) Actual,
			SUM(Anterior) Anterior,
			SUM(Presupuesto) Presupuesto
		FROM SBTotales
		WHERE Id_Proceso = @Id
		GROUP BY Llave,Nombre
		ORDER BY Llave DESC
	ELSE
		SELECT	Llave Clave ,Nombre,Llave Dato,
			SUM(Actual) Actual,
			SUM(Anterior) Anterior,
			SUM(Presupuesto) Presupuesto
		FROM SBTotales
		WHERE Id_Proceso = @Id
		GROUP BY Llave,Nombre
		ORDER BY Nombre DESC

IF @orden = 2 
	SELECT	Llave Clave ,Nombre,Llave Dato,
		SUM(Actual) Actual,
		SUM(Anterior) Anterior,
		SUM(Presupuesto) Presupuesto
	FROM SBTotales
	WHERE Id_Proceso = @Id
	GROUP BY Llave,Nombre
	ORDER BY Actual

IF @orden = 3 
	SELECT	Llave Clave ,Nombre,Llave Dato,
		SUM(Actual) Actual,
		SUM(Anterior) Anterior,
		SUM(Presupuesto) Presupuesto
	FROM SBTotales
	WHERE Id_Proceso = @Id
	GROUP BY Llave,Nombre
	ORDER BY Actual DESC

IF @orden = 4 
	SELECT	Llave Clave ,Nombre,Llave Dato,
		SUM(Actual) Actual,
		SUM(Anterior) Anterior,
		SUM(Presupuesto) Presupuesto
	FROM SBTotales
	WHERE Id_Proceso = @Id
	GROUP BY Llave,Nombre
	ORDER BY Anterior

IF @orden = 5 
	SELECT	Llave Clave ,Nombre,Llave Dato,
		SUM(Actual) Actual,
		SUM(Anterior) Anterior,
		SUM(Presupuesto) Presupuesto
	FROM SBTotales
	WHERE Id_Proceso = @Id
	GROUP BY Llave,Nombre
	ORDER BY Anterior DESC

	
IF @orden = 6 
	SELECT	Llave Clave ,Nombre,Llave Dato,
		SUM(Actual) Actual,
		SUM(Anterior) Anterior,
		SUM(Presupuesto) Presupuesto
	FROM SBTotales
	WHERE Id_Proceso = @Id
	GROUP BY Llave,Nombre
	ORDER BY Presupuesto

IF @orden = 7 
	SELECT	Llave Clave ,Nombre,Llave Dato,
		SUM(Actual) Actual,
		SUM(Anterior) Anterior,
		SUM(Presupuesto) Presupuesto
	FROM SBTotales
	WHERE Id_Proceso = @Id
	GROUP BY Llave,Nombre
	ORDER BY Presupuesto DESC


GO

