/********** spEcuadorCedulaDigitoVerificador ************/
IF EXISTS(SELECT * FROM sysobjects  WHERE name = 'spEcuadorCedulaDigitoVerificador' and type = 'P')   DROP PROCEDURE spEcuadorCedulaDigitoVerificador
GO
CREATE PROCEDURE spEcuadorCedulaDigitoVerificador
                                   @RUC            varchar(20), 
                                   @Digito         char(2) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
	  @Coeficiente varchar(20),
	  @Largo       int,
	  @Ciclo       int,
	  @Modulo      int,
	  @Total       int,
	  @Valor       int,
	  @Residuo     int
	  
  SELECT @Digito = '0'
  IF SUBSTRING(@RUC, 3,1) IN('5','4','3','2','1','0')
  BEGIN	
    SELECT @Largo = 10, @Coeficiente='212121212', @Modulo =10        	
  END ELSE
    SELECT @Digito=NULL
	
  IF @Digito <> NULL	
  BEGIN
    SELECT @Ciclo = 1, @Total = 0
    WHILE @Ciclo < @Largo 
    BEGIN
      SELECT @Valor = CONVERT(int,SUBSTRING(@Ruc,@Ciclo,1)) * CONVERT(int, SUBSTRING(@Coeficiente,@Ciclo,1))
      SELECT @Total =@Total  +   CASE WHEN @Valor  > 9	 AND @Modulo	= 10 THEN ((@Valor % 10) + (@Valor / 10)) ELSE @Valor END
      SELECT @Ciclo=@Ciclo+1
    END
    SELECT @Residuo =	 (@Total % @Modulo)
    
    IF @Residuo = 0 -- si el residui es 0 el digito es 0
      SELECT @Digito = 0
    ELSE 
      SELECT @Digito = CONVERT(varchar,(@Modulo -  @Residuo))
	    
    IF @Digito = substring(@ruc,@largo,1) SELECT @Digito = 1 ELSE  SELECT @Digito=NULL
  END
END
GO

/********** spEcuadorRucDigitoVerificador ************/
IF EXISTS(SELECT * FROM sysobjects  WHERE name = 'spEcuadorRucDigitoVerificador' and type = 'P')   DROP PROCEDURE spEcuadorRucDigitoVerificador
GO
CREATE PROCEDURE spEcuadorRucDigitoVerificador
                                   @RUC            varchar(20), 
                                   @Digito         char(2) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
	  @Coeficiente varchar(20),
	  @Largo       int,
	  @Ciclo       int,
	  @Modulo      int,
	  @Total       int,
	  @Valor       int,
	  @Residuo     int
	  
  SELECT @Digito = '0'
  IF SUBSTRING(@RUC, 3,1) ='9'
  BEGIN
    SELECT @Largo = 10, @Coeficiente = '432765432', @Modulo=11        	
  END ELSE
  IF SUBSTRING(@RUC, 3,1) ='6'
  BEGIN
    SELECT @Largo = 9, @Coeficiente='32765432', @Modulo = 11        	
  END ELSE
  IF SUBSTRING(@RUC, 3,1) IN('5','4','3','2','1','0')
  BEGIN	
    SELECT @Largo = 10, @Coeficiente='212121212', @Modulo =10        	
  END ELSE
    SELECT @Digito=NULL
	
  IF @Digito <> NULL	
  BEGIN
    SELECT @Ciclo = 1, @Total = 0
    WHILE @Ciclo < @Largo 
    BEGIN
      SELECT @Valor = CONVERT(int,SUBSTRING(@Ruc,@Ciclo,1)) * CONVERT(int, SUBSTRING(@Coeficiente,@Ciclo,1))
      SELECT @Total =@Total  +   CASE WHEN @Valor  > 9	 AND @Modulo	= 10 THEN ((@Valor % 10) + (@Valor / 10)) ELSE @Valor END
      SELECT @Ciclo=@Ciclo+1
    END
    SELECT @Residuo =	 (@Total % @Modulo)
    
    IF @Residuo = 0 -- si el residui es 0 el digito es 0
      SELECT @Digito = 0
    ELSE 
      SELECT @Digito = CONVERT(varchar,(@Modulo -  @Residuo))
	    
    IF @Digito = substring(@ruc,@largo,1) SELECT @Digito = 1 ELSE  SELECT @Digito=NULL
  END
END
GO


/********** spEcuadorValidaMascara ************/
IF EXISTS (SELECT name FROM sysobjects  WHERE name = 'spEcuadorValidaMascara' and type = 'P') DROP PROCEDURE spEcuadorValidaMascara
GO
CREATE PROCEDURE spEcuadorValidaMascara
			@TipoRegistro	varchar(20),
			@Registro       varchar(50),
			@EnSilencio	bit	= 0,
			@Valido		bit 	= 1	OUTPUT  -- 1= esta bien  0= esta mal

--//WITH ENCRYPTION
AS BEGIN

  DECLARE
    @Mascara	varchar(50),
    @LargoReg	int,
    @LargoMasc	int,
    @Contador	int,
    @TipoMasc	char(1),
    @Codigo	int,
    @TipoID	varchar(20),
    @Digito	varchar(2)

  SET @Registro = NULLIF(RTRIM(@Registro),'')

  SELECT @Mascara = UPPER(Mascara), @TipoID = TipoID FROM TipoRegistro WHERE RTRIM(TipoRegistro) = RTRIM(@TipoRegistro)
  SELECT @Contador = 1
  SELECT @Valido = 1
 

  SELECT @LargoReg=LEN(ISNULL(RTRIM(@Registro), ''))
  SELECT @LargoMasc=LEN(ISNULL(RTRIM(@Mascara), ''))

  IF @LargoReg > @LargoMasc
    SELECT @Valido = 0

  IF @Valido = 1
  BEGIN    
    WHILE @Contador <= @LargoReg AND @Valido = 1
    BEGIN
      SELECT @TipoMasc = SUBSTRING(@Mascara, @Contador, 1)
      SELECT @Codigo = ASCII(SUBSTRING(UPPER(@Registro), @Contador, 1))

      IF @TipoMasc = 'A'
      BEGIN
        IF (NOT (@Codigo BETWEEN 65 AND 90)) AND (NOT (@Codigo BETWEEN 48 AND 57)) AND (@Codigo <> 209) SET @Valido = 0
      END ELSE 
      IF @TipoMasc = '9'
      BEGIN
        IF (NOT (@Codigo BETWEEN 48 AND 57)) SET @Valido = 0
      END ELSE
      IF @TipoMasc NOT IN ('A','9')
      BEGIN
        IF @Codigo <> ASCII(@TipoMasc) SET @Valido = 0
      END
      SET @Contador = @Contador + 1
    END
  END

  EXEC xpEcuadorValidaMascara @TipoRegistro, @Registro, @EnSilencio, @Valido OUTPUT

  IF (@LargoReg <> @LargoMasc) AND (@Valido = 1) SELECT @Valido = 0

  IF @Valido = 1 AND @TipoID = 'RUC' 
  BEGIN
    EXEC spEcuadorRUCDigitoVerificador @Registro, @Digito OUTPUT
    IF @Digito IS NULL SET @Valido = 0
  END

  IF @Valido = 1 AND @TipoID = 'Cedula' 
  BEGIN
    EXEC spEcuadorCedulaDigitoVerificador @Registro, @Digito OUTPUT
    IF @Digito IS NULL SET @Valido = 0
  END

  IF @EnSilencio = 0
    SELECT @Valido
END
GO

/************** spEcuadorAutorizacion *************/
if exists (select * from sysobjects where id = object_id('dbo.spEcuadorAutorizacion') and type = 'P') drop procedure dbo.spEcuadorAutorizacion
GO
CREATE PROCEDURE spEcuadorAutorizacion
		   @Sucursal		int,
                   @Empresa     	char(5),
                   @Modulo		char(5),
		   @ID			int,
		   @Accion		varchar(20),
		   @EstatusNuevo	varchar(20),
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT
WITH ENCRYPTION
AS BEGIN
  DECLARE @EcuadorMostrarAnexo		varchar(20),
	  @Mov				varchar(20),
	  @MovID			varchar(20),
	  @FechaRegistro		datetime,
	  @AutorizacionSRI		varchar(50),
	  @Serie			varchar(10),
	  @Consecutivo			bigint,
	  @Articulo			varchar(50),
	  @EsEcuador			bit,
	  @TipoRegistro			varchar(20),
	  @Renglon			float,
	  @RenglonSub			int,
	  @SQL				nvarchar(MAX),
	  @Tabla			varchar(50),
          @LongitudSecuencialSRI	int,
          @Secuencial			varchar(16),
	  @Establecimiento		varchar(20),
	  @PuntoEmision			varchar(50),
	  @SecuencialSRI		varchar(50),
	  @VigenteA			datetime,
	  @SustentoComprobante		varchar(20),
	  @TipoComprobante		varchar(20)		


  SELECT @EsEcuador = EsEcuador, @LongitudSecuencialSRI = LongitudSecuencialSRI FROM Empresa WHERE Empresa = @Empresa

  IF @Modulo = 'COMS' SELECT @Mov = RTRIM(c.Mov), @MovID = RTRIM(c.MovID), @FechaRegistro = c.FechaRegistro, @AutorizacionSRI = c.AutorizacionSRI, @TipoRegistro = p.TipoRegistro FROM Compra c JOIN Prov p ON p.Proveedor = c.Proveedor WHERE ID = @ID ELSE
  IF @Modulo = 'VTAS' SELECT @Mov = RTRIM(v.Mov), @MovID = RTRIM(v.MovID), @FechaRegistro = v.FechaRegistro, @AutorizacionSRI = v.AutorizacionSRI, @TipoRegistro = c.TipoRegistro FROM Venta v JOIN Cte c ON c.Cliente = v.Cliente WHERE ID = @ID ELSE
  IF @Modulo = 'GAS'  SELECT @Mov = RTRIM(g.Mov), @MovID = RTRIM(g.MovID), @FechaRegistro = g.FechaRegistro, @AutorizacionSRI = g.AutorizacionSRI, @TipoRegistro = p.TipoRegistro FROM Gasto g JOIN Prov p ON p.Proveedor = g.Acreedor WHERE ID = @ID

  EXEC spMovIDEnSerieConsecutivo @MovID, @Serie OUTPUT, @Consecutivo OUTPUT

  SELECT @EcuadorMostrarAnexo = RTRIM(EcuadorMostrarAnexo) FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov
  
  IF @EcuadorMostrarAnexo IN ('Detalle','Encabezado') AND @Accion = 'AFECTAR' AND @EsEcuador = 1
  BEGIN
    IF @EcuadorMostrarAnexo = 'Encabezado'  
    BEGIN
      IF @Modulo = 'VTAS'
      BEGIN
        SELECT @Establecimiento = NULLIF(Establecimiento,''),
               @PuntoEmision = NULLIF(PuntoEmision,''),
               @SecuencialSRI = NULLIF(SecuencialSRI,''),
               @AutorizacionSRI = NULLIF(AutorizacionSRI,''),
               @VigenteA = VigenteA
          FROM Venta
         WHERE ID = @ID

         --IF @SecuencialSRI IN (NULL,'') SELECT @ok = 25482 ELSE
         IF @Establecimiento IS NULL AND @Ok IS NULL SELECT @Ok = 25480 ELSE
         IF @PuntoEmision IS NULL AND @Ok IS NULL SELECT @Ok = 25481 ELSE
         IF @AutorizacionSRI IS NULL AND @Ok IS NULL SELECT @ok = 25483 ELSE
         IF @VigenteA IS NULL AND @Ok IS NULL SELECT @ok = 25484
         IF @OK IS NOT NULL RETURN
      END ELSE
      IF @Modulo IN ('COMS')
      BEGIN
        SELECT @SustentoComprobante = NULLIF(SustentoComprobante,''),
               @TipoComprobante = NULLIF(TipoComprobante,''),
               @Establecimiento = NULLIF(Establecimiento,''),
               @PuntoEmision = NULLIF(PuntoEmision,'')
          FROM Compra
         WHERE ID = @ID

          IF @SustentoComprobante IS NULL AND @Ok IS NULL SELECT @Ok = 25485 ELSE
          IF @TipoComprobante IS NULL AND @Ok IS NULL SELECT @Ok = 25486 ELSE
          IF @Establecimiento IS NULL AND @Ok IS NULL SELECT @Ok = 25480 ELSE
          IF @PuntoEmision IS NULL AND @Ok IS NULL SELECT @Ok = 25481

      END ELSE
      BEGIN
        IF @Modulo IN ('GAS')
        BEGIN
          SELECT @SustentoComprobante = NULLIF(SustentoComprobante,''),
                 @TipoComprobante = NULLIF(TipoComprobante,''),
                 @Establecimiento = NULLIF(Establecimiento,''),
                 @PuntoEmision = NULLIF(PuntoEmision,'')
            FROM Gasto
           WHERE ID = @ID

          IF @SustentoComprobante IS NULL AND @Ok IS NULL SELECT @Ok = 25485 ELSE
          IF @TipoComprobante IS NULL AND @Ok IS NULL SELECT @Ok = 25486 ELSE
          IF @Establecimiento IS NULL AND @Ok IS NULL SELECT @Ok = 25480 ELSE
          IF @PuntoEmision IS NULL AND @Ok IS NULL SELECT @Ok = 25481
        END
      END


      IF @Modulo = 'VTAS' AND @Ok IS NULL SET @Tabla = 'Venta'  ELSE
      IF @Modulo = 'COMS' AND @Ok IS NULL SET @Tabla = 'Compra' ELSE
      IF @Modulo = 'GAS'  AND @Ok IS NULL SET @Tabla = 'Gasto'

      SELECT @Modulo = ConsecutivoModulo FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov

      IF @Modulo = 'VTAS' AND NOT EXISTS(SELECT TOP 1 * FROM EcuadorAutorizacion WHERE Modulo = @Modulo AND Mov = @Mov AND Empresa = @Empresa AND ISNULL(Sucursal,@Sucursal) = @Sucursal AND RTRIM(ISNULL(Serie,'')) = RTRIM(ISNULL(@Serie,'')) AND @Consecutivo BETWEEN ISNULL(FolioD,@Consecutivo) AND ISNULL(FolioA,@Consecutivo) AND Vigencia >= @FechaRegistro AND Autorizacion = @AutorizacionSRI ORDER BY Vigencia DESC) SELECT @Ok = 31010, @OkRef = 'Error en la Aprobación del Anexo Transaccional.'
      IF @OK IS NULL
      BEGIN
        IF @Modulo = 'VTAS'
        BEGIN
          SELECT @LongitudSecuencialSRI = LongitudSecuencialSRI FROM Empresa WHERE Empresa = @Empresa
	  EXEC spLlenarCeros @MovID, @LongitudSecuencialSRI, @Secuencial OUTPUT
        END
      END


      SET @SQL = 'UPDATE ' + RTRIM(@Tabla) + ' SET TipoIdentificacion  = ' + CHAR(39) + ISNULL(RTRIM(@TipoRegistro),'') + CHAR(39) + ', SecuencialSRI = ' + CHAR(39) + ISNULL(RTRIM(@Secuencial),'') + CHAR(39) + ' WHERE ID = ' + RTRIM(CONVERT(varchar,@ID))

      IF @Ok IS NULL
      BEGIN
        EXEC sp_ExecuteSql @SQL
        IF @@ERROR <> 0 SET @Ok = 1
      END

    END ELSE
    BEGIN

      IF @Modulo = 'VTAS' DECLARE crDetalle CURSOR FOR SELECT AutorizacionSRI, Articulo, Renglon, RenglonSub FROM VentaD  WHERE ID = @ID ELSE
      IF @Modulo = 'COMS' DECLARE crDetalle CURSOR FOR SELECT AutorizacionSRI, Articulo, Renglon, RenglonSub FROM CompraD WHERE ID = @ID ELSE
      IF @Modulo = 'GAS'  DECLARE crDetalle CURSOR FOR SELECT AutorizacionSRI, Concepto, Renglon, CONVERT(int,NULL) FROM GastoD  WHERE ID = @ID 

      SELECT @Modulo = ConsecutivoModulo FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov

      IF @Modulo = 'VTAS' AND @Ok IS NULL SET @Tabla = 'VentaD'  ELSE
      IF @Modulo = 'COMS' AND @Ok IS NULL SET @Tabla = 'CompraD' ELSE
      IF @Modulo = 'GAS'  AND @Ok IS NULL SET @Tabla = 'GastoD'


      OPEN crDetalle
      FETCH NEXT FROM crDetalle INTO @AutorizacionSRI, @Articulo, @Renglon, @RenglonSub
      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
      BEGIN

        IF @Modulo = 'VTAS'
        BEGIN
          SELECT @Establecimiento = Establecimiento,
                 @PuntoEmision = PuntoEmision,
                 @SecuencialSRI = SecuencialSRI,
                 @AutorizacionSRI = AutorizacionSRI,
                 @VigenteA = VigenteA
            FROM VentaD
           WHERE ID = @ID
             AND Renglon = @Renglon
             AND RenglonSub = @RenglonSub

           IF @Establecimiento IN (NULL,'') SELECT @ok = 25480 ELSE
           IF @PuntoEmision IN (NULL,'') SELECT @ok = 25481 ELSE
           --IF @SecuencialSRI IN (NULL,'') SELECT @ok = 25482 ELSE
           IF @AutorizacionSRI IN (NULL,'') SELECT @ok = 25483 ELSE
           IF @VigenteA IN (NULL,'')SELECT @ok = 25484
           IF @OK IS NOT NULL RETURN
        END

        IF @Modulo = 'VTAS'
        BEGIN
          SELECT @Establecimiento = Establecimiento,
                 @PuntoEmision = PuntoEmision,
                 @SecuencialSRI = SecuencialSRI,
                 @AutorizacionSRI = AutorizacionSRI,
                 @VigenteA = VigenteA
            FROM VentaD
           WHERE ID = @ID
             AND Renglon = @Renglon
             AND RenglonSub = @RenglonSub

           --IF @SecuencialSRI IN (NULL,'') SELECT @ok = 25482 ELSE
           IF @Establecimiento IN (NULL,'') AND @Ok IS NULL SELECT @Ok = 25480 ELSE
           IF @PuntoEmision IN (NULL,'') AND @Ok IS NULL SELECT @Ok = 25481 ELSE
           IF @AutorizacionSRI IN (NULL,'') AND @Ok IS NULL SELECT @ok = 25483 ELSE
           IF @VigenteA IN (NULL,'') AND @Ok IS NULL SELECT @ok = 25484
           IF @OK IS NOT NULL RETURN
        END ELSE
        IF @Modulo IN ('COMS')
        BEGIN
          SELECT @SustentoComprobante = SustentoComprobante,
                 @TipoComprobante = TipoComprobante,
                 @Establecimiento = Establecimiento,
                 @PuntoEmision = PuntoEmision
            FROM CompraD
           WHERE ID = @ID
             AND Renglon = @Renglon
  
          IF @SustentoComprobante IN (NULL,'') AND @Ok IS NULL SELECT @Ok = 25485 ELSE
          IF @TipoComprobante IN (NULL,'') AND @Ok IS NULL SELECT @Ok = 25486 ELSE
          IF @Establecimiento IN (NULL,'') AND @Ok IS NULL SELECT @Ok = 25480 ELSE
          IF @PuntoEmision IN (NULL,'') AND @Ok IS NULL SELECT @Ok = 25481
  
        END ELSE
        BEGIN
          SELECT @SustentoComprobante = SustentoComprobante,
                 @TipoComprobante = TipoComprobante,
                 @Establecimiento = Establecimiento,
                 @PuntoEmision = PuntoEmision
            FROM GastoD
           WHERE ID = @ID
             AND Renglon = @Renglon

          IF @SustentoComprobante IN (NULL,'') AND @Ok IS NULL SELECT @Ok = 25485 ELSE
          IF @TipoComprobante IN (NULL,'') AND @Ok IS NULL SELECT @Ok = 25486 ELSE
          IF @Establecimiento IN (NULL,'') AND @Ok IS NULL SELECT @Ok = 25480 ELSE
          IF @PuntoEmision IN (NULL,'') AND @Ok IS NULL SELECT @Ok = 25481
        END

        IF @Modulo = 'VTAS' AND NOT EXISTS(SELECT TOP 1 * FROM EcuadorAutorizacion WHERE Modulo = @Modulo AND Mov = @Mov AND Empresa = @Empresa AND ISNULL(Sucursal,@Sucursal) = @Sucursal AND RTRIM(ISNULL(Serie,'')) = RTRIM(ISNULL(@Serie,'')) AND @Consecutivo BETWEEN ISNULL(FolioD,@Consecutivo) AND ISNULL(FolioA,@Consecutivo) AND Vigencia >= @FechaRegistro AND Autorizacion = @AutorizacionSRI ORDER BY Vigencia DESC) SELECT @Ok = 31010, @OkRef = 'Error en la Aprobación del Anexo Transaccional. (' +  RTRIM(@Articulo) + ')'

        IF @OK IS NULL
        BEGIN
          IF @Modulo = 'VTAS'
          BEGIN
            SELECT @LongitudSecuencialSRI = LongitudSecuencialSRI FROM Empresa WHERE Empresa = @Empresa
	    EXEC spLlenarCeros @MovID, @LongitudSecuencialSRI, @Secuencial OUTPUT
          END
        END


        SET @SQL = 'UPDATE ' + RTRIM(@Tabla) + ' SET TipoIdentificacion  = ' + CHAR(39) + ISNULL(RTRIM(@TipoRegistro),'') + CHAR(39) + ', SecuencialSRI = ' + CHAR(39) + ISNULL(RTRIM(@Secuencial),'') + CHAR(39) + ' WHERE ID = ' + RTRIM(CONVERT(varchar,@ID))+ ' AND Renglon = ' + RTRIM(CONVERT(varchar,@Renglon)) + ' AND RenglonSub = ' + RTRIM(CONVERT(varchar,@RenglonSub))
        IF @Ok IS NULL
        BEGIN
          EXEC sp_ExecuteSql @SQL
          IF @@ERROR <> 0 SET @Ok = 1
        END

        FETCH NEXT FROM crDetalle INTO @AutorizacionSRI, @Articulo, @Renglon, @RenglonSub
      END
      CLOSE crDetalle
      DEALLOCATE crDetalle
    END
  END
  
END
GO


/************** spEcuadorSugerirAutorizacion *************/
if exists (select * from sysobjects where id = object_id('dbo.spEcuadorSugerirAutorizacion') and type = 'P') drop procedure dbo.spEcuadorSugerirAutorizacion
GO
CREATE PROCEDURE spEcuadorSugerirAutorizacion
		   @Sucursal		int,
                   @Empresa     	char(5),
                   @Modulo		char(5),
		   @Mov			varchar(20),
		   @Campo		varchar(50),
		   @FechaEmision	datetime,
		   @Proveedor		varchar(10) = NULL
WITH ENCRYPTION
AS BEGIN
  DECLARE @EcuadorMostrarAnexo		varchar(20),
	  @AutorizacionSRI		varchar(50),
	  @PuntoEmision			varchar(50),
	  @Articulo			varchar(50),
	  @Resultado			varchar(50),
	  @VigenteA			datetime,
	  @EsEcuador			bit,
	  @TipoRegistro			varchar(20),
	  @Establecimiento		varchar(20)

  SELECT @EsEcuador = EsEcuador FROM Empresa WHERE Empresa = @Empresa
  SELECT @EcuadorMostrarAnexo = RTRIM(EcuadorMostrarAnexo) FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov
  
  IF @EcuadorMostrarAnexo IN ('Detalle','Encabezado') AND @EsEcuador = 1
  BEGIN
    IF @Modulo = 'VTAS' 
    BEGIN
      SELECT @Modulo = ConsecutivoModulo FROM MovTipo WHERE Mov = @Mov AND Modulo = @Modulo

      SELECT TOP 1
        @PuntoEmision = PuntoEmision,
        @AutorizacionSRI = Autorizacion,
  	@VigenteA = Vigencia,
	@Establecimiento = Establecimiento 
        FROM EcuadorAutorizacion
       WHERE Modulo = @Modulo
         AND Mov = @Mov
         AND ISNULL(Sucursal,@Sucursal) = @Sucursal
         AND Vigencia >= @FechaEmision
       ORDER BY Vigencia DESC

      IF @Campo = 'PuntoEmision'    SET @Resultado = @PuntoEmision    ELSE
      IF @Campo = 'AutorizacionSRI' SET @Resultado = @AutorizacionSRI ELSE
      IF @Campo = 'Establecimiento' SET @Resultado = @Establecimiento ELSE
      IF @Campo = 'VigenteA'        SET @Resultado = CONVERT(varchar,@VigenteA)

    END ELSE
    IF @Modulo IN ('COMS')
    BEGIN
      SELECT 
        @AutorizacionSRI = AutorizacionSRI,
        @VigenteA = VigenciaSRI,
	@TipoRegistro = TipoRegistro
        FROM Prov 
       WHERE Proveedor = @Proveedor      

      IF @Campo = 'AutorizacionSRI'    SET @Resultado = @AutorizacionSRI ELSE
      IF @Campo = 'VigenteA'           SET @Resultado = CONVERT(varchar,@VigenteA) ELSE
      IF @Campo = 'TipoIdentificacion' SET @Resultado = @TipoRegistro

    END ELSE
    IF @Modulo IN ('GAS')
    BEGIN
      SELECT 
        @AutorizacionSRI = AutorizacionSRI,
        @VigenteA = VigenciaSRI,
	@TipoRegistro = TipoRegistro
        FROM Prov
       WHERE Proveedor = @Proveedor      

      IF @Campo = 'AutorizacionSRI'    SET @Resultado = @AutorizacionSRI ELSE
      IF @Campo = 'VigenteA'           SET @Resultado = CONVERT(varchar,@VigenteA) ELSE
      IF @Campo = 'TipoIdentificacion' SET @Resultado = @TipoRegistro

    END
  END
  SELECT @Resultado
END
GO

/********** spTipoComprobanteCerrarDia ************/
IF EXISTS (SELECT name FROM sysobjects  WHERE name = 'spTipoComprobanteCerrarDia' and type = 'P') DROP PROCEDURE spTipoComprobanteCerrarDia
GO
CREATE PROCEDURE spTipoComprobanteCerrarDia
		(
                   @Fecha	 datetime,
                   @Ok		 int	      = NULL OUTPUT,
                   @OkRef	 varchar(255) = NULL OUTPUT
		)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @TipoComprobante	varchar(10),
  @Concepto		varchar(50), 
  @Referencia		varchar(50)

  --Elimina la hora de la fecha
  EXEC spExtraerFecha @Fecha OUTPUT
  

  UPDATE TipoComprobante SET
         Concepto     = tcd.Concepto, 
         Referencia   = tcd.Referencia,
	 VigenciaD    = tcd.VigenciaD
    FROM TipoComprobante tc JOIN TipoComprobanteD tcd 
      ON tc.TipoComprobante = tcd.TipoComprobante
   WHERE tcd.VigenciaD <= @Fecha
     AND ISNULL(tcd.TieneMovimientos,0) = 0
     AND tcd.VigenciaD = (SELECT MAX(TipoComprobanteD.VigenciaD) FROM TipoComprobanteD WHERE TipoComprobante = tc.TipoComprobante AND TipoComprobanteD.VigenciaD <= @Fecha)
    IF @@ERROR <> 0 SET @Ok = 1

END
GO

/********** spSustentoComprobanteCerrarDia ************/
IF EXISTS (SELECT name FROM sysobjects  WHERE name = 'spSustentoComprobanteCerrarDia' and type = 'P') DROP PROCEDURE spSustentoComprobanteCerrarDia
GO
CREATE PROCEDURE spSustentoComprobanteCerrarDia
		(
                   @Fecha	 datetime,
                   @Ok		 int	      = NULL OUTPUT,
                   @OkRef	 varchar(255) = NULL OUTPUT
		)
WITH ENCRYPTION
AS BEGIN
  DECLARE
  @SustentoComprobante	varchar(10),
  @Concepto		varchar(50), 
  @Referencia		varchar(50)

  --Elimina la hora de la fecha
  EXEC spExtraerFecha @Fecha OUTPUT
  

  UPDATE SustentoComprobante SET
         Concepto     = scd.Concepto, 
         Referencia   = scd.Referencia,
	 VigenciaD    = scd.VigenciaD
    FROM SustentoComprobante sc JOIN SustentoComprobanteD scd 
      ON sc.SustentoComprobante = scd.SustentoComprobante
   WHERE scd.VigenciaD <= @Fecha
     AND ISNULL(scd.TieneMovimientos,0) = 0
     AND scd.VigenciaD = (SELECT MAX(SustentoComprobanteD.VigenciaD) FROM SustentoComprobanteD WHERE SustentoComprobante = sc.SustentoComprobante AND SustentoComprobanteD.VigenciaD <= @Fecha)
    IF @@ERROR <> 0 SET @Ok = 1

END
GO

/********** spTipoRegistroCerrarDia ************/
IF EXISTS (SELECT name FROM sysobjects  WHERE name = 'spTipoRegistroCerrarDia' and type = 'P') DROP PROCEDURE spTipoRegistroCerrarDia
GO
CREATE PROCEDURE spTipoRegistroCerrarDia
		(
                   @Fecha	 datetime,
                   @Ok		 int	      = NULL OUTPUT,
                   @OkRef	 varchar(255) = NULL OUTPUT
		)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @TipoRegistro		varchar(10),
  @Concepto		varchar(50), 
  @Referencia		varchar(50)

  --Elimina la hora de la fecha
  EXEC spExtraerFecha @Fecha OUTPUT
  

  UPDATE TipoRegistro SET
         Concepto     = trd.Concepto, 
         Referencia   = trd.Referencia,
         VigenciaD    = trd.VigenciaD
    FROM TipoRegistro tr JOIN TipoRegistroD trd 
      ON tr.TipoRegistro = trd.TipoRegistro
   WHERE trd.VigenciaD <= @Fecha
     AND ISNULL(trd.TieneMovimientos,0) = 0
     AND trd.VigenciaD = (SELECT MAX(TipoRegistroD.VigenciaD) FROM TipoRegistroD WHERE TipoRegistro = tr.TipoRegistro AND TipoRegistroD.VigenciaD <= @Fecha)
    IF @@ERROR <> 0 SET @Ok = 1

END
GO
