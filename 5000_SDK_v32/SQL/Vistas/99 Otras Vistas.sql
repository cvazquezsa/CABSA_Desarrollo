SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

-- spVentaTFiltroAyuda 'DEMO', 'Empresa'
-- select * from ventatcalc where fechaemision='Ago 28 2007 12:00AM'
/**************** spVentaTFiltroAyuda ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVentaTFiltroAyuda') and type = 'P') drop procedure dbo.spVentaTFiltroAyuda
GO
CREATE PROCEDURE spVentaTFiltroAyuda
			@Empresa	varchar(5),
			@Campo		varchar(50)
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @SQL	varchar(1000)
  SELECT @Campo = NULLIF(NULLIF(RTRIM(@Campo), ''), '0')
  IF @Campo IS NOT NULL
  BEGIN
    SELECT @SQL = 'SELECT DISTINCT CONVERT(varchar(255), '+@Campo+') FROM VentaTCalc WHERE Empresa='+dbo.fnComillas(@Empresa)+' ORDER BY CONVERT(varchar(255), '+@Campo+')'
    EXEC(@SQL)
  END ELSE
    SELECT NULL
  RETURN
END
GO

-- select * from VentaTFiltro
-- select cliente, * from VentaTCalc
-- spVentaTFiltro 101, 'DEMO'
-- select * from ListaFiltro
/**************** spVentaTFiltro ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVentaTFiltro') and type = 'P') drop procedure dbo.spVentaTFiltro
GO
CREATE PROCEDURE spVentaTFiltro
			@Estacion	int,
			@Empresa	varchar(5)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @UltCampo		varchar(50),
    @Campo		varchar(50),
    @Condicion		varchar(20),
    @Valor		varchar(100),
    @op			varchar(20),
    @SQL		varchar(max),
    @WHERE		varchar(max),
    @TieneEmpresa	bit,
    @TieneEstatus	bit

  SELECT @TieneEmpresa = 0, @TieneEstatus = 0
  DELETE ListaFiltro WHERE Estacion = @Estacion 

  SELECT @WHERE = '', @UltCampo = ''
  DECLARE crVentaTFiltro CURSOR LOCAL FOR 
   SELECT Campo, UPPER(Condicion), Valor
     FROM VentaTFiltro
    WHERE Estacion = @Estacion
    ORDER BY Campo
  OPEN crVentaTFiltro
  FETCH NEXT FROM crVentaTFiltro INTO @Campo, @Condicion, @Valor
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF UPPER(@Campo) = 'EMPRESA' SELECT @TieneEmpresa = 1
      IF UPPER(@Campo) = 'ESTATUS' SELECT @TieneEstatus = 1
      IF @UltCampo = @Campo 
      BEGIN
       IF @WHERE <> '' SELECT @WHERE = @WHERE + ' OR '
      END ELSE      
      BEGIN
        IF @WHERE <> '' SELECT @WHERE = @WHERE + ') AND '
        SELECT @WHERE = @WHERE + '('
      END
      SELECT @op = CASE @Condicion 
                   WHEN 'DIFERENTE'     THEN '<>'
                   WHEN 'MAYOR'         THEN '>'
                   WHEN 'MAYOR O IGUAL' THEN '>='
                   WHEN 'MENOR'         THEN '<'
                   WHEN 'MENOR O IGUAL' THEN '<='
                   WHEN 'PARECIDO'      THEN 'LIKE'
                   ELSE '=' END   
              
      IF @Condicion = 'PARECIDO' SELECT @Valor = REPLACE(@Valor, '*', '%')
      SELECT @WHERE = @WHERE + @Campo+' '+@op+' '+dbo.fnComillas(@Valor)
      SELECT @UltCampo = @Campo 
    END
    FETCH NEXT FROM crVentaTFiltro INTO @Campo, @Condicion, @Valor
  END  -- While
  CLOSE crVentaTFiltro
  DEALLOCATE crVentaTFiltro
  SELECT @SQL = 'INSERT ListaFiltro (Estacion, Clave) SELECT DISTINCT '+CONVERT(varchar, @Estacion)+', Cliente FROM VentaTCalc WHERE 1=1'
  IF @TieneEmpresa = 0
    SELECT @SQL = @SQL + ' AND Empresa = '+dbo.fnComillas(@Empresa)
  IF @TieneEstatus = 0
    SELECT @SQL = @SQL + ' AND Estatus = '+dbo.fnComillas('CONCLUIDO')
  IF @WHERE <> ''
    SELECT @SQL = @SQL + ' AND '+@WHERE+')'
  EXEC(@SQL)

  RETURN
END
GO

-- select dbo.fnComillas('DEMO')


-- spProspectoFiltroAyuda 'DEMO', 'Categoria'
/**************** spProspectoFiltroAyuda ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProspectoFiltroAyuda') and type = 'P') drop procedure dbo.spProspectoFiltroAyuda
GO
CREATE PROCEDURE spProspectoFiltroAyuda
			@Empresa	varchar(5),
			@Campo		varchar(50)
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @SQL	varchar(1000)
  SELECT @Campo = NULLIF(NULLIF(RTRIM(@Campo), ''), '0')
  IF @Campo IS NOT NULL
  BEGIN
    IF SUBSTRING(@Campo, 1, 1)='(' AND SUBSTRING(@Campo, LEN(@Campo), 1)=')'
      SELECT @SQL = 'SELECT DISTINCT Valor FROM FormaExtraValor WHERE Aplica="Prospecto" AND Eliminado=0 AND Campo="'+SUBSTRING(@Campo, 2, LEN(@Campo)-2)+'" ORDER BY Valor'
    ELSE
    SELECT @SQL = 'SELECT DISTINCT CONVERT(varchar(255), '+@Campo+') FROM Prospecto ORDER BY CONVERT(varchar(255), '+@Campo+')'
    EXEC(@SQL)
  END ELSE
    SELECT NULL
  RETURN
END
GO



-- spProspectoFiltro 101, 'DEMO'
/**************** spProspectoFiltro ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProspectoFiltro') and type = 'P') drop procedure dbo.spProspectoFiltro
GO
CREATE PROCEDURE spProspectoFiltro
			@Estacion	int,
			@Empresa	varchar(5)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @UltCampo		varchar(50),
    @Campo		varchar(50),
    @Condicion		varchar(20),
    @Valor		varchar(100),
    @op			varchar(20),
    @SQL		varchar(max),
    @WHERE		varchar(max),
    @TieneEstatus	bit

  SELECT @TieneEstatus = 0
  DELETE ListaFiltro WHERE Estacion = @Estacion 

  SELECT @WHERE = '', @UltCampo = ''
  DECLARE crProspectoFiltro CURSOR LOCAL FOR 
   SELECT Campo, UPPER(Condicion), Valor
     FROM ProspectoFiltro
    WHERE Estacion = @Estacion AND NOT (SUBSTRING(Campo, 1, 1)='(' AND SUBSTRING(Campo, LEN(Campo), 1)=')')
    ORDER BY Campo
  OPEN crProspectoFiltro
  FETCH NEXT FROM crProspectoFiltro INTO @Campo, @Condicion, @Valor
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF UPPER(@Campo) = 'ESTATUS' SELECT @TieneEstatus = 1
      IF @UltCampo = @Campo 
      BEGIN
       IF @WHERE <> '' SELECT @WHERE = @WHERE + ' OR '
      END ELSE      
      BEGIN
        IF @WHERE <> '' SELECT @WHERE = @WHERE + ') AND '
        SELECT @WHERE = @WHERE + '('
      END
      SELECT @op = CASE @Condicion 
                   WHEN 'DIFERENTE'     THEN '<>'
                   WHEN 'MAYOR'         THEN '>'
                   WHEN 'MAYOR O IGUAL' THEN '>='
                   WHEN 'MENOR'         THEN '<'
                   WHEN 'MENOR O IGUAL' THEN '<='
                   WHEN 'PARECIDO'      THEN 'LIKE'
                   ELSE '=' END   
              
      IF @Condicion = 'PARECIDO' SELECT @Valor = REPLACE(@Valor, '*', '%')
      SELECT @WHERE = @WHERE + @Campo+' '+@op+' '+dbo.fnComillas(@Valor)
      SELECT @UltCampo = @Campo 
    END
    FETCH NEXT FROM crProspectoFiltro INTO @Campo, @Condicion, @Valor
  END  -- While
  CLOSE crProspectoFiltro
  DEALLOCATE crProspectoFiltro

  SELECT @SQL = 'INSERT ListaSt (Estacion, Clave) SELECT DISTINCT '+CONVERT(varchar, @Estacion)+', Prospecto FROM Prospecto WHERE 1=1'
  IF @TieneEstatus = 0
    SELECT @SQL = @SQL + ' AND Estatus = '+dbo.fnComillas('ALTA')
  IF @WHERE <> ''
    SELECT @SQL = @SQL + ' AND '+@WHERE+')'
  EXEC(@SQL)

  SELECT @WHERE = '', @UltCampo = ''
  DECLARE crProspectoFiltroCaracteristicas CURSOR LOCAL FOR 
   SELECT SUBSTRING(Campo, 2, LEN(Campo)-2), UPPER(Condicion), Valor
     FROM ProspectoFiltro
    WHERE Estacion = @Estacion AND (SUBSTRING(Campo, 1, 1)='(' AND SUBSTRING(Campo, LEN(Campo), 1)=')')
    ORDER BY Campo
  OPEN crProspectoFiltroCaracteristicas
  FETCH NEXT FROM crProspectoFiltroCaracteristicas INTO @Campo, @Condicion, @Valor
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF UPPER(@Campo) = 'ESTATUS' SELECT @TieneEstatus = 1
      IF @UltCampo = @Campo 
      BEGIN
       IF @WHERE <> '' SELECT @WHERE = @WHERE + ' OR '
      END ELSE      
      BEGIN
        IF @WHERE <> '' SELECT @WHERE = @WHERE + ') AND '
        SELECT @WHERE = @WHERE + '('
      END
      SELECT @op = CASE @Condicion 
                   WHEN 'DIFERENTE'     THEN '<>'
                   WHEN 'MAYOR'         THEN '>'
                   WHEN 'MAYOR O IGUAL' THEN '>='
                   WHEN 'MENOR'         THEN '<'
                   WHEN 'MENOR O IGUAL' THEN '<='
                   WHEN 'PARECIDO'      THEN 'LIKE'
                   ELSE '=' END   
              
      IF @Condicion = 'PARECIDO' SELECT @Valor = REPLACE(@Valor, '*', '%')
      SELECT @WHERE = @WHERE + 'Campo = '+dbo.fnComillas(@Campo)+' AND Valor '+@op+' '+dbo.fnComillas(@Valor)
      SELECT @UltCampo = @Campo 
    END
    FETCH NEXT FROM crProspectoFiltroCaracteristicas INTO @Campo, @Condicion, @Valor
  END  -- While
  CLOSE crProspectoFiltroCaracteristicas
  DEALLOCATE crProspectoFiltroCaracteristicas

  SELECT @SQL = 'INSERT ListaFiltro (Estacion, Clave) SELECT DISTINCT '+CONVERT(varchar, @Estacion)+', Clave FROM ListaSt'
  IF @WHERE <> ''
  BEGIN
    SELECT @SQL = @SQL + ' JOIN FormaExtraValor ON Aplica="Prospecto" AND AplicaClave=Clave AND Eliminado=0'
    SELECT @SQL = @SQL + ' WHERE ListaSt.Estacion='+CONVERT(varchar, @Estacion)+' AND '+@WHERE+')'
  END ELSE
    SELECT @SQL = @SQL + ' WHERE ListaSt.Estacion='+CONVERT(varchar, @Estacion)
  EXEC(@SQL)
  RETURN
END
GO

-- select dbo.fnComillas('DEMO')

/***********************    Funcion Forma de Pago Sucursal Cliente    ****************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFPagoSucCte') DROP FUNCTION fnFPagoSucCte
GO
CREATE FUNCTION fnFPagoSucCte 
(
	@Empresa	varchar(5),
	@Cte		varchar(10),
	@Sucursal	int
)
RETURNS @FormaPago TABLE(Orden		int identity(1,1),
						Cliente		varchar(5),
						Sucursal	int NULL,
						FormaPago	varchar(50) NULL,
						Cuenta		varchar(20) NULL,
						Tipo		varchar(20)
						)
--//WITH ENCRYPTION
AS
BEGIN
	
	INSERT INTO @FormaPago(Cliente, Sucursal, FormaPago, Cuenta, Tipo) 	
	                SELECT Cliente, ID, FormaPago, Cuenta, 'Sucursales del Cliente'
	                  FROM CteEnviarA
	                 WHERE Cliente = @Cte
	                   AND ID = ISNULL(@Sucursal, ID)
	              ORDER BY ID
	
	INSERT INTO @FormaPago(Cliente, Sucursal, FormaPago, Cuenta, Tipo)
					SELECT Cliente, NULL, InfoFormaPago, Cta, 'Datos CFD Cliente' 
					  FROM CteCFD
					 WHERE Cliente = @Cte
	
	INSERT INTO @FormaPago(Cliente, Sucursal, FormaPago, Cuenta, Tipo)
					SELECT A.Cliente, NULL, B.FormaPago, B.CuentaPago, 'Datos Nivel Empresa'
					  FROM CteEmpresaCFD A
					  JOIN CteCFDFormaPago B
					    ON A.Empresa = B.Empresa
					   AND A.Cliente = B.Cliente
					 WHERE A.Empresa = @Empresa
					   AND A.Cliente = @Cte
	
	INSERT INTO @FormaPago(Cliente, Sucursal, FormaPago, Cuenta, Tipo)
					SELECT A.Cliente, NULL, A.InfoPago, B.CuentaPago, 'Información del Pago'
					  FROM CteCFDInfoPago A
					  JOIN CteCFDInfoPagoD B
					    ON A.Cliente = B.Cliente
					   AND A.InfoPago = B.InfoPago
					 WHERE A.Cliente = @Cte	

	RETURN					 
	
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.vwIntelisisServiceFactoryMonitor') and sysstat & 0xf = 2) 
DROP VIEW dbo.vwIntelisisServiceFactoryMonitor
GO
CREATE VIEW dbo.vwIntelisisServiceFactoryMonitor
AS
SELECT top 200 F.ID, F.Sistema, F.Contenido, F.Referencia, F.SubReferencia,
		F.[Version], F.Usuario, F.Solicitud, I.Resultado, F.Estatus, F.FechaEstatus, 
		F.Ok, F.OkRef, F.RID, F.Modulo, F.ModuloID   
  FROM IntelisisServiceFactory F JOIN IntelisisService I 
		on F.RID = I.ID AND F.Referencia NOT IN ('Intelisis.INV.InsertarMov.INV_SOL', 'Intelisis.Art.ActCosto')
 WHERE F.Estatus <> 'PROCESADO' OR ISNULL(F.ModuloID, 0) = 0
 ORDER BY ID DESC
GO

ALTER TABLE IntelisisServiceFactory ALTER COLUMN ModuloID varchar(50) NULL
GO