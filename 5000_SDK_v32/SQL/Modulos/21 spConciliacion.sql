/* Configuracion MS SQL Server */
SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

/********* Conciliacion ***********/
-- select * from conciliacion
-- select * from listaid
-- spConciliacionListaAceptar 1, 0, 101
-- DELETE ConciliacionD

/*************** spConciliacionInsertarMensajeLayout ****************/
if exists (select * from sysobjects where id = object_id('dbo.spConciliacionInsertarMensajeLayout') and type = 'P') drop procedure dbo.spConciliacionInsertarMensajeLayout
GO
CREATE PROCEDURE spConciliacionInsertarMensajeLayout
            @Institucion	varchar(20),
			@Layout			varchar(20)
--//WITH ENCRYPTION
AS BEGIN  
  DECLARE
    @Empresa		varchar(5)

  IF EXISTS(SELECT * FROM MensajeLayout WHERE Layout = @Layout)
  BEGIN
    DELETE MensajeInstitucion WHERE Institucion = @Institucion
    INSERT MensajeInstitucion
           (Institucion, Mensaje, Descripcion, ConciliarMismaFecha, TipoMovimiento, NaturalezaMovimiento)
    SELECT @Institucion, Mensaje, Descripcion, ConciliarMismaFecha, TipoMovimiento, NaturalezaMovimiento
      FROM MensajeLayout
     WHERE Layout = @Layout
  END
  RETURN
END
GO

/**************** spConciliacionInsertarInstitucionFinConcepto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spConciliacionInsertarInstitucionFinConcepto') and type = 'P') drop procedure dbo.spConciliacionInsertarInstitucionFinConcepto
GO
CREATE PROCEDURE spConciliacionInsertarInstitucionFinConcepto
            @Institucion	varchar(20),
			@Layout			varchar(20)
--//WITH ENCRYPTION
AS BEGIN  
  DECLARE
    @Empresa		varchar(5),
    @Ok				int,
    @OkRef			varchar(255)

  IF EXISTS(SELECT * FROM MensajeInstitucion WHERE Institucion = @Institucion)
  BEGIN
    BEGIN TRY
      BEGIN TRANSACTION 
        DELETE InstitucionFinConcepto WHERE Institucion = @Institucion
        INSERT InstitucionFinConcepto
               (Institucion, ConceptoBanco, TipoMovimiento)
        SELECT @Institucion, Descripcion,   TipoMovimiento
          FROM MensajeInstitucion
         WHERE Institucion = @Institucion
         GROUP BY Descripcion, TipoMovimiento
      COMMIT TRANSACTION 
    END TRY
    BEGIN CATCH
      SELECT @Ok = ERROR_NUMBER(), @OkRef = ERROR_MESSAGE()
      ROLLBACK TRANSACTION
    END CATCH      
  END
  
  IF @Ok IS NOT NULL
    SELECT @OkRef
  ELSE
    SELECT null
  
  RETURN
END
GO


/**************** spConciliacionPendientesEmpresaAceptar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spConciliacionPendientesEmpresaAceptar') and type = 'P') drop procedure dbo.spConciliacionPendientesEmpresaAceptar
GO
CREATE PROCEDURE spConciliacionPendientesEmpresaAceptar
			@ID		int
--//WITH ENCRYPTION
AS BEGIN  
  DECLARE
    @Empresa		varchar(5),
    @Mensaje		varchar(10),
    @Institucion	varchar(20),
    @Mov		varchar(20),
    @MovID		varchar(20),
    @Concepto		varchar(50), 
    @Referencia		varchar(50)

  SELECT @Empresa = e.Empresa, @Institucion = cta.Institucion
    FROM Conciliacion e
    JOIN CtaDinero cta ON cta.CtaDinero = e.CtaDinero
   WHERE e.ID = @ID

  DECLARE crConciliacionD CURSOR LOCAL FOR 
   SELECT Concepto, Referencia
     FROM ConciliacionD
    WHERE ID = @ID AND Seccion = 2
  OPEN crConciliacionD
  FETCH NEXT FROM crConciliacionD INTO @Concepto, @Referencia
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spReferenciaEnMovMovID @Referencia, @Mov OUTPUT, @MovID OUTPUT     
      SELECT @Mensaje = NULL
      SELECT @Mensaje = Mensaje
        FROM MensajeInstitucion
       WHERE Institucion = @Institucion AND Descripcion = @Concepto

      UPDATE Dinero
         SET InstitucionMensaje = @Mensaje 
       WHERE Empresa = @Empresa AND Conciliado = 0 AND Mov = @Mov AND MovID = @MovID AND Estatus IN ('PENDIENTE', 'CONCLUIDO', 'CONCILIADO')
    END
    FETCH NEXT FROM crConciliacionD INTO @Concepto, @Referencia
  END
  CLOSE crConciliacionD
  DEALLOCATE crConciliacionD
  RETURN
END
GO

/**************** spConciliacionListaAceptar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spConciliacionListaAceptar') and type = 'P') drop procedure dbo.spConciliacionListaAceptar
GO
CREATE PROCEDURE spConciliacionListaAceptar
			@ID			int,
			@Sucursal	int,
    		@Estacion	int
--//WITH ENCRYPTION
AS BEGIN
/*  DECLARE
    @SaldoAnterior	money,
    @Cargos		money,
    @Abonos		money*/

  DECLARE @CtaDinero	varchar(10)

  SELECT @CtaDinero = CtaDinero FROM Conciliacion WHERE ID = @ID

  INSERT ConciliacionD (
         ID,  Sucursal,  Fecha,   Referencia,        Cargo,   Abono,   Manual)
  SELECT @ID, @Sucursal, a.Fecha, a.Mov+' '+a.MovID, a.Abono, a.Cargo, a.ID
    FROM Auxiliar a 
    JOIN Dinero d ON d.ID = a.ModuloID AND d.Estatus IN ('PENDIENTE', 'CONCLUIDO', 'CONCILIADO')
    JOIN ListaID l ON l.Estacion = @Estacion AND l.ID = a.ModuloID
   WHERE a.Rama = 'DIN' AND a.Modulo = 'DIN' AND l.ID NOT IN (SELECT DISTINCT Manual FROM ConciliacionD WHERE ID = @ID)
     AND a.Cuenta = @CtaDinero
  
  /*SELECT @Cargos = SUM(Cargo), @Abonos = SUM(Abono)
    FROM ConciliacionD
   WHERE ID = @ID

  SELECT @SaldoAnterior = SUM(s.SaldoConciliado)
    FROM Conciliacion c
    JOIN DineroSaldo s ON s.CtaDinero = c.CtaDinero AND s.Empresa = c.Empresa
   WHERE c.ID = @ID

  UPDATE Conciliacion SET SaldoAnterior = ISNULL(SaldoAnterior, @SaldoAnterior), Cargos = @Cargos, Abonos = @Abonos WHERE ID = @ID*/
  RETURN
END
GO

/**************** spConciliacionUltima ****************/
if exists (select * from sysobjects where id = object_id('dbo.spConciliacionUltima') and type = 'P') drop procedure dbo.spConciliacionUltima
GO
CREATE PROCEDURE spConciliacionUltima
			@Empresa		varchar(5),
			@CtaDinero		varchar(10),
			@UltimaConciliacion	datetime	OUTPUT,
			@UltimaConciliacionID	int		OUTPUT
--//WITH ENCRYPTION
AS BEGIN 
  SELECT @UltimaConciliacion = NULL, @UltimaConciliacionID = NULL
  SELECT @UltimaConciliacion = MAX(FechaA)
    FROM Conciliacion
   WHERE CtaDinero = @CtaDinero AND Estatus = 'CONCLUIDO' AND Empresa = @Empresa

  IF @UltimaConciliacion IS NOT NULL
    SELECT @UltimaConciliacionID = MAX(ID)
      FROM Conciliacion
     WHERE CtaDinero = @CtaDinero AND Estatus = 'CONCLUIDO' AND Empresa = @Empresa AND FechaA = @UltimaConciliacion
  RETURN
END
GO

/**************** spConciliacionBuscarReferencia ****************/
if exists (select * from sysobjects where id = object_id('dbo.spConciliacionBuscarReferencia') and type = 'P') drop procedure dbo.spConciliacionBuscarReferencia
GO
CREATE PROCEDURE spConciliacionBuscarReferencia
			@Empresa		varchar(5),
			@Fecha			datetime,
			@Referencia		varchar(50),
			@TipoMovimiento		varchar(50)	= NULL	OUTPUT,
			@CxModulo		varchar(5)	= NULL	OUTPUT,
			@CxID			int		= NULL	OUTPUT,
			@IVAFiscal		float		= NULL	OUTPUT
--//WITH ENCRYPTION
AS BEGIN 
  SELECT @CxID = NULL, @IVAFiscal = NULL
  IF @CxModulo IN (NULL, 'CXC') 
  BEGIN
    SELECT @CxID = MIN(c.ID)
      FROM Cxc c
      JOIN MovTipo mt ON mt.Modulo = 'CXC' AND mt.Mov = c.Mov AND mt.Clave IN ('CXC.F', 'CXC.CA', 'CXC.CAP', 'CXC.CAD', 'CXC.D', 'CXC.DM')
     WHERE c.Empresa = @Empresa AND c.Estatus = 'PENDIENTE' AND c.FechaEmision<=@Fecha AND c.Referencia = @Referencia
    IF @CxID IS NOT NULL SELECT @CxModulo = 'CXC', @TipoMovimiento = 'Cuenta por Cobrar', @IVAFiscal = IVAFiscal FROM Cxc WHERE ID = @CxID
  END
  IF @CxModulo = 'CXP' OR (@CxModulo IS NULL AND @CxID IS NULL)
  BEGIN
    SELECT @CxID = MIN(c.ID)
      FROM Cxp c
      JOIN MovTipo mt ON mt.Modulo = 'CXP' AND mt.Mov = c.Mov AND mt.Clave IN ('CXP.F', 'CXP.CA', 'CXP.CAP', 'CXP.CAD', 'CXP.D', 'CXP.DM')
     WHERE c.Empresa = @Empresa AND c.Estatus = 'PENDIENTE' AND c.FechaEmision<=@Fecha AND c.Referencia = @Referencia
    IF @CxID IS NOT NULL SELECT @CxModulo = 'CXP', @TipoMovimiento = 'Cuenta por Pagar',  @IVAFiscal = IVAFiscal FROM Cxp WHERE ID = @CxID
  END
  RETURN
END
GO


/**************** spInstitucionFinBuscarConceptoBanco ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInstitucionFinBuscarConceptoBanco') and type = 'P') drop procedure dbo.spInstitucionFinBuscarConceptoBanco
GO
CREATE PROCEDURE spInstitucionFinBuscarConceptoBanco
			@Institucion	varchar(20),
			@Concepto	varchar(50),
			@Resultado	varchar(50)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @ConceptoBanco	varchar(50),	    
    @p			int
  SELECT @Resultado	= NULL
  DECLARE crInstitucionFinConcepto CURSOR LOCAL FOR 
  SELECT ConceptoBanco
    FROM InstitucionFinConcepto 
   WHERE Institucion = @Institucion AND (ConceptoBanco LIKE '%<RB>' OR ConceptoBanco LIKE '%*')
  OPEN crInstitucionFinConcepto
  FETCH NEXT FROM crInstitucionFinConcepto INTO @ConceptoBanco
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 AND @Resultado IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @p = 0
      SELECT @p = CHARINDEX('*', @ConceptoBanco)
      IF @p = 0 SELECT @p = CHARINDEX('<RB>', @ConceptoBanco)

      IF @p > 0 AND SUBSTRING(@Concepto, 1, @p-1) = SUBSTRING(@ConceptoBanco, 1, @p-1)
        SELECT @Resultado = @ConceptoBanco
    END
    FETCH NEXT FROM crInstitucionFinConcepto INTO @ConceptoBanco
  END
  CLOSE crInstitucionFinConcepto
  DEALLOCATE crInstitucionFinConcepto
  RETURN
END
GO

/**************** spInstitucionFinConcepto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInstitucionFinConcepto') and type = 'P') drop procedure dbo.spInstitucionFinConcepto
GO
CREATE PROCEDURE spInstitucionFinConcepto
			@Institucion			varchar(20),
			@Concepto			varchar(50),
			@TipoMovimiento			varchar(20)	= NULL OUTPUT,
			@ConceptoGasto			varchar(50)	= NULL OUTPUT, 
			@Acreedor			varchar(10)	= NULL OUTPUT, 
			@ObligacionFiscal		varchar(50)	= NULL OUTPUT,
			@ObligacionFiscal2		varchar(50)	= NULL OUTPUT,
			@Tasa				float		= NULL OUTPUT,
			@TipoImporte			varchar(20)	= NULL OUTPUT,
			@PermiteAbonoNoIdentificado	bit		= NULL OUTPUT,
			@ReferenciaBancaria		varchar(50)	= NULL OUTPUT,
			@PermiteCargoNoIdentificado bit		= NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @ConceptoBanco	varchar(50),
    @p			int

  SELECT @TipoMovimiento = TipoMovimiento, 
         @ConceptoGasto = ConceptoGasto, 
         @Acreedor = NULLIF(RTRIM(Acreedor), ''), 
         @ObligacionFiscal = NULLIF(RTRIM(ObligacionFiscal), ''), 
         @ObligacionFiscal2 = NULLIF(RTRIM(ObligacionFiscal2), ''), 
         @Tasa = Tasa,
         @TipoImporte = TipoImporte,
         @PermiteAbonoNoIdentificado = ISNULL(PermiteAbonoNoIdentificado, 0),
         @PermiteCargoNoIdentificado = ISNULL(PermiteCargoNoIdentificado, 0)
    FROM InstitucionFinConcepto 
   WHERE Institucion = @Institucion AND ConceptoBanco = @Concepto
  IF @@ROWCOUNT = 0
  BEGIN
    EXEC spInstitucionFinBuscarConceptoBanco @Institucion, @Concepto, @ConceptoBanco OUTPUT
    IF @ConceptoBanco IS NOT NULL
    BEGIN
      SELECT @TipoMovimiento = TipoMovimiento, 
             @ConceptoGasto = ConceptoGasto, 
             @Acreedor = NULLIF(RTRIM(Acreedor), ''), 
             @ObligacionFiscal = NULLIF(RTRIM(ObligacionFiscal), ''), 
             @ObligacionFiscal2 = NULLIF(RTRIM(ObligacionFiscal2), ''), 
             @Tasa = Tasa,
             @TipoImporte = TipoImporte,
             @PermiteAbonoNoIdentificado = ISNULL(PermiteAbonoNoIdentificado, 0),
             @PermiteCargoNoIdentificado = ISNULL(PermiteCargoNoIdentificado, 0)
        FROM InstitucionFinConcepto 
       WHERE Institucion = @Institucion AND ConceptoBanco = @ConceptoBanco
      SELECT @p = CHARINDEX('<RB>', @ConceptoBanco)
      IF @p > 0
        SELECT @ReferenciaBancaria = SUBSTRING(@Concepto, @p, LEN(@Concepto))
    END
  END   
  RETURN
END
GO

-- select * from conciliacion
-- spConciliacionCalc 211
/**************** spConciliacionCalc ****************/
if exists (select * from sysobjects where id = object_id('dbo.spConciliacionCalc') and type = 'P') drop procedure dbo.spConciliacionCalc
GO
CREATE PROCEDURE spConciliacionCalc
    		    @ID               		int
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Empresa			char(5),
    @Sucursal			int,
    @MovTipo			varchar(20),
    @Fecha			datetime,
    @FechaD			datetime,
    @FechaA			datetime,
    @Concepto			varchar(50),
    @Referencia			varchar(50),
    @Cargo			money,
    @Abono			money,
    @TipoMovimiento		varchar(50),
    @CtaDinero			varchar(10),
    @Cuenta			varchar(20),
    @Institucion		varchar(20),
    @Auxiliar			int,
    @AuxiliarFecha		datetime,
    @ContID			int,
    @ContD			int,
    @CfgTolerancia		int, 
    @CfgGastosAuto		bit, 
    @CfgConceptoFijo		varchar(50),  
    @CfgDiasCargos		int,
    @CfgDiasAbonos		int,
    @CfgImportesLejanos		bit,
    @Modulo			char(5),
    @ModuloID			int,
    @Manual			int,
    @InstitucionConcepto	varchar(50),
    @InstitucionAcreedor	varchar(10),
    @ConceptoGasto		varchar(50),
    @CtaDineroAcreedor		varchar(10),
    @Acreedor			varchar(10),
    @ObligacionFiscal		varchar(50),
    @ObligacionFiscal2		varchar(50),
    @Tasa			float,
    @TipoImporte		varchar(20),
    @UltimaConciliacion		datetime,
    @UltimaConciliacionID	int,
    @CfgNoSugerirImportesDup	bit,
    @CfgSugerirDespuesPeriodo	bit,
    @Cont			bit,
    @ConteoBanco		int,
    @ConteoEmpresa		int,
    @ReferenciaBancaria		varchar(50),
    @RID                int
 
  DECLARE @ConciliaD TABLE(
          ORDEN         int IDENTITY (1,1),
          RID           int NULL,
          Fecha         datetime NULL,
          Concepto      varchar(50)NULL,
          Referencia    varchar(50)NULL,
          Abono         money NULL,
          Cargo         money NULL,
          Manual        int NULL)
          
  SELECT @Empresa = e.Empresa, @Sucursal = e.Sucursal, @MovTipo = mt.Clave, @CtaDinero = e.CtaDinero, @Institucion = cta.Institucion, @Cuenta = NULLIF(RTRIM(cta.Cuenta), ''), @CtaDineroAcreedor = NULLIF(RTRIM(cta.Acreedor), ''),
         @FechaD = e.FechaD, @FechaA = e.FechaA
    FROM Conciliacion e
    JOIN CtaDinero cta ON cta.CtaDinero = e.CtaDinero
    JOIN MovTipo mt ON mt.Modulo = 'CONC' AND mt.Mov = e.Mov
   WHERE e.ID = @ID

  SELECT @CfgTolerancia   = ISNULL(ConcToleranciaDec, 2),
         @CfgGastosAuto   = ISNULL(ConcGastosAuto, 0),
	 @CfgConceptoFijo = NULLIF(RTRIM(ConcGastosAutoConceptoFijo), ''),
         @CfgDiasCargos   = NULLIF(ConcDiasCargos, 0),
         @CfgDiasAbonos   = NULLIF(ConcDiasAbonos, 0),
         @CfgImportesLejanos = ISNULL(ConcImportesLejanos, 0),
         @CfgNoSugerirImportesDup = ISNULL(ConcNoSugerirImportesDup, 0),
         @CfgSugerirDespuesPeriodo = ISNULL(ConcSugerirDespuesPeriodo, 0)
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  -- Arrastrar Conciliaciones Pendientes (Banco) 
  IF NOT EXISTS(SELECT * FROM ConciliacionD WHERE ID = @ID AND Seccion = 1)
  BEGIN
    EXEC spConciliacionUltima @Empresa, @CtaDinero, @UltimaConciliacion OUTPUT, @UltimaConciliacionID OUTPUT
    IF @UltimaConciliacionID IS NOT NULL
      INSERT ConciliacionD (
             ID,  Sucursal,  Fecha, Concepto, Referencia, Cargo, Abono, Observaciones, Seccion)
      SELECT @ID, @Sucursal, Fecha, Concepto, Referencia, Cargo, Abono, Observaciones, 1
        FROM ConciliacionD
       WHERE ID = @UltimaConciliacionID AND Seccion IN (0, 1) AND Auxiliar IS NULL
  END

  UPDATE ConciliacionD 
     SET TipoMovimiento = NULL, Auxiliar = NULL, ContD = NULL, ConceptoGasto = NULL, Acreedor = NULL, ObligacionFiscal = NULL, ObligacionFiscal2 = NULL, Tasa = NULL, TipoImporte = NULL
   WHERE ID = @ID

   INSERT @ConciliaD(RID, Fecha, Concepto, Referencia, Abono, Cargo, Manual)
   SELECT RID, Fecha, Concepto, NULLIF(RTRIM(Referencia), ''), ROUND(ISNULL(Abono, 0.0), @CfgTolerancia), ROUND(ISNULL(Cargo, 0.0), @CfgTolerancia), NULLIF(Manual, 0)
     FROM ConciliacionD
    WHERE ID = @ID
    ORDER BY Referencia DESC

  DECLARE crConciliacionD CURSOR LOCAL READ_ONLY FAST_FORWARD FOR 
   SELECT RID, Fecha, Concepto, NULLIF(RTRIM(Referencia), ''), ROUND(ISNULL(Abono, 0.0), @CfgTolerancia), ROUND(ISNULL(Cargo, 0.0), @CfgTolerancia), NULLIF(Manual, 0)
     FROM @ConciliaD
  OPEN crConciliacionD
  FETCH NEXT FROM crConciliacionD INTO @RID, @Fecha, @Concepto, @Referencia, @Cargo, @Abono, @Manual
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @TipoMovimiento = NULL, @Auxiliar = NULL, @ContD = NULL, @ConceptoGasto = NULL, @Acreedor = NULL

      IF @TipoMovimiento IS NULL AND @Auxiliar IS NULL AND @Referencia IS NOT NULL
        EXEC spConciliacionBuscarReferencia @Empresa, @Fecha, @Referencia, @TipoMovimiento = @TipoMovimiento OUTPUT
      IF @TipoMovimiento IS NULL 
        EXEC spInstitucionFinConcepto @Institucion, @Concepto, @TipoMovimiento = @TipoMovimiento OUTPUT, @ConceptoGasto = @InstitucionConcepto OUTPUT, @Acreedor = @InstitucionAcreedor OUTPUT, @ObligacionFiscal = @ObligacionFiscal OUTPUT, @ObligacionFiscal2 = @ObligacionFiscal2 OUTPUT, @Tasa = @Tasa OUTPUT, @TipoImporte = @TipoImporte OUTPUT, @ReferenciaBancaria = @ReferenciaBancaria OUTPUT

      IF @CfgGastosAuto = 1 AND @TipoMovimiento IS NULL 
      BEGIN
        SELECT @TipoMovimiento = 'Gasto'
        SELECT @ConceptoGasto = ISNULL(@CfgConceptoFijo, @Concepto)
      END

      IF @Manual IS NOT NULL
      BEGIN
        IF @TipoMovimiento IS NULL SELECT @TipoMovimiento = 'Tesoreria'
        SELECT @Auxiliar = a.ID
          FROM Auxiliar a
          JOIN Dinero d ON d.ID = a.ModuloID AND d.Estatus IN ('PENDIENTE', 'CONCLUIDO', 'CONCILIADO')
         WHERE a.Empresa = @Empresa 
           AND a.Rama = 'DIN' AND a.Modulo = 'DIN'
           AND a.Cuenta = @CtaDinero 
           AND a.Conciliado = 0 
           AND ROUND(ISNULL(a.Cargo, 0.0), @CfgTolerancia) = @Cargo 
           AND ROUND(ISNULL(a.Abono, 0.0), @CfgTolerancia) = @Abono
           AND a.ID = @Manual
      END

      IF @TipoMovimiento = 'Tesoreria' AND @Manual IS NULL
      BEGIN
        IF @ReferenciaBancaria IS NOT NULL
          SELECT @Auxiliar = MIN(a.ID) 
            FROM Auxiliar a
            JOIN Dinero d ON d.ID = a.ModuloID AND d.Estatus IN ('PENDIENTE', 'CONCLUIDO', 'CONCILIADO')
            JOIN Cte c ON c.Cliente = d.Contacto AND d.ContactoTipo = 'Cliente'
           WHERE a.Empresa = @Empresa 
             AND a.Rama = 'DIN' AND a.Modulo = 'DIN'
             AND a.Cuenta = @CtaDinero 
             AND a.Conciliado = 0 
             AND (@CfgSugerirDespuesPeriodo = 1 OR a.Fecha <= @FechaA)
             AND ROUND(ISNULL(a.Cargo, 0.0), @CfgTolerancia) = @Cargo 
             AND ROUND(ISNULL(a.Abono, 0.0), @CfgTolerancia) = @Abono
             AND a.ID NOT IN (SELECT Auxiliar FROM ConciliacionD WHERE ID = @ID AND Auxiliar IS NOT NULL) 
             AND c.ReferenciaBancaria = @ReferenciaBancaria
        IF @Auxiliar IS NULL AND @Referencia IS NOT NULL
          SELECT @Auxiliar = MIN(a.ID) 
            FROM Auxiliar a
            JOIN Dinero d ON d.ID = a.ModuloID AND d.Estatus IN ('PENDIENTE', 'CONCLUIDO', 'CONCILIADO')
           WHERE a.Empresa = @Empresa 
             AND a.Rama = 'DIN' AND a.Modulo = 'DIN'
             AND a.Cuenta = @CtaDinero 
             AND a.Conciliado = 0 
             AND (@CfgSugerirDespuesPeriodo = 1 OR a.Fecha <= @FechaA)
             AND ROUND(ISNULL(a.Cargo, 0.0), @CfgTolerancia) = @Cargo 
             AND ROUND(ISNULL(a.Abono, 0.0), @CfgTolerancia) = @Abono
             AND a.ID NOT IN (SELECT Auxiliar FROM ConciliacionD WHERE ID = @ID AND Auxiliar IS NOT NULL) 
             AND (a.MovID = @Referencia OR d.Referencia = @Referencia)

        -- Buscar por Importe
        IF @Auxiliar IS NULL 
        BEGIN
          SELECT @Cont = 1
          IF @CfgNoSugerirImportesDup = 1
          BEGIN
            SELECT @ConteoBanco = COUNT(*) 
              FROM ConciliacionD
             WHERE ID = @ID 
               AND ROUND(ISNULL(Cargo, 0.0), @CfgTolerancia) = @Abono
               AND ROUND(ISNULL(Abono, 0.0), @CfgTolerancia) = @Cargo 

            SELECT @ConteoEmpresa = COUNT(*)
              FROM Auxiliar a
              JOIN Dinero d ON d.ID = a.ModuloID AND d.Estatus IN ('PENDIENTE', 'CONCLUIDO', 'CONCILIADO')
             WHERE a.Empresa = @Empresa 
               AND a.Rama = 'DIN' AND a.Modulo = 'DIN'
               AND a.Cuenta = @CtaDinero 
               AND a.Conciliado = 0 
               AND (@CfgSugerirDespuesPeriodo = 1 OR a.Fecha <= @FechaA)
               AND ROUND(ISNULL(a.Cargo, 0.0), @CfgTolerancia) = @Cargo 
               AND ROUND(ISNULL(a.Abono, 0.0), @CfgTolerancia) = @Abono
               AND a.ID NOT IN (SELECT Auxiliar FROM ConciliacionD WHERE ID = @ID AND Auxiliar IS NOT NULL) 
               --AND MovID = @Referencia
            IF @ConteoBanco > 1 OR @ConteoEmpresa > 1 SELECT @Cont = 0
          END
          IF @Cont = 1 AND @TipoMovimiento = 'Tesoreria' 
          BEGIN
            -- Buscar Depositos Cercanos 
            IF @Auxiliar IS NULL AND @CfgDiasAbonos IS NOT NULL AND @Cargo <> 0.0
            BEGIN
              SELECT @AuxiliarFecha = NULL
              SELECT @AuxiliarFecha = MIN(a.Fecha) 
                FROM Auxiliar a
                JOIN Dinero d ON d.ID = a.ModuloID AND d.Estatus IN ('PENDIENTE', 'CONCLUIDO', 'CONCILIADO')
               WHERE a.Empresa = @Empresa 
                 AND a.Rama = 'DIN' AND a.Modulo = 'DIN'
                 AND a.Cuenta = @CtaDinero 
                 AND a.Conciliado = 0 
                 AND (@CfgSugerirDespuesPeriodo = 1 OR a.Fecha <= @FechaA)
                 AND ROUND(ISNULL(a.Cargo, 0.0), @CfgTolerancia) = @Cargo 
                 AND a.ID NOT IN (SELECT Auxiliar FROM ConciliacionD WHERE ID = @ID AND Auxiliar IS NOT NULL) 
                 AND a.Fecha BETWEEN @Fecha AND DATEADD(day, @CfgDiasAbonos, @Fecha)
              IF @AuxiliarFecha IS NOT NULL
                SELECT @Auxiliar = MIN(a.ID) 
                  FROM Auxiliar a
                  JOIN Dinero d ON d.ID = a.ModuloID AND d.Estatus IN ('PENDIENTE', 'CONCLUIDO', 'CONCILIADO')
                 WHERE a.Empresa = @Empresa 
                   AND a.Rama = 'DIN' AND a.Modulo = 'DIN'
                   AND a.Cuenta = @CtaDinero 
                   AND a.Conciliado = 0 
                   AND (@CfgSugerirDespuesPeriodo = 1 OR a.Fecha <= @FechaA)
                   AND ROUND(ISNULL(a.Cargo, 0.0), @CfgTolerancia) = @Cargo 
                   AND a.ID NOT IN (SELECT Auxiliar FROM ConciliacionD WHERE ID = @ID AND Auxiliar IS NOT NULL) 
                   AND a.Fecha = @AuxiliarFecha
            END

            -- Buscar Cheques Cercanos 
            IF @Auxiliar IS NULL AND @CfgDiasCargos IS NOT NULL AND @Abono <> 0.0
            BEGIN
              SELECT @AuxiliarFecha = NULL
              SELECT @AuxiliarFecha = MIN(a.Fecha) 
                FROM Auxiliar a
                JOIN Dinero d ON d.ID = a.ModuloID AND d.Estatus IN ('PENDIENTE', 'CONCLUIDO', 'CONCILIADO')
               WHERE a.Empresa = @Empresa 
                 AND a.Rama = 'DIN' AND a.Modulo = 'DIN'
                 AND a.Cuenta = @CtaDinero 
                 AND a.Conciliado = 0 
                 AND (@CfgSugerirDespuesPeriodo = 1 OR a.Fecha <= @FechaA)
                 AND ROUND(ISNULL(a.Abono, 0.0), @CfgTolerancia) = @Abono
                 AND a.ID NOT IN (SELECT Auxiliar FROM ConciliacionD WHERE ID = @ID AND Auxiliar IS NOT NULL) 
                 AND a.Fecha BETWEEN DATEADD(day, -@CfgDiasCargos, @Fecha) AND @Fecha
              IF @AuxiliarFecha IS NOT NULL
                SELECT @Auxiliar = MIN(a.ID) 
                  FROM Auxiliar a
                  JOIN Dinero d ON d.ID = a.ModuloID AND d.Estatus IN ('PENDIENTE', 'CONCLUIDO', 'CONCILIADO')
                 WHERE a.Empresa = @Empresa 
                   AND a.Rama = 'DIN' AND a.Modulo = 'DIN'
                   AND a.Cuenta = @CtaDinero 
                   AND a.Conciliado = 0 
                   AND (@CfgSugerirDespuesPeriodo = 1 OR a.Fecha <= @FechaA)
                   AND ROUND(ISNULL(a.Abono, 0.0), @CfgTolerancia) = @Abono
                   AND a.ID NOT IN (SELECT Auxiliar FROM ConciliacionD WHERE ID = @ID AND Auxiliar IS NOT NULL) 
                   AND a.Fecha = @AuxiliarFecha
            END
          END
          IF @Cont = 1 AND @CfgImportesLejanos = 1 AND @Auxiliar IS NULL 
            SELECT @Auxiliar = MIN(a.ID) 
              FROM Auxiliar a
              JOIN Dinero d ON d.ID = a.ModuloID AND d.Estatus IN ('PENDIENTE', 'CONCLUIDO', 'CONCILIADO')
             WHERE a.Empresa = @Empresa 
               AND a.Rama = 'DIN' AND a.Modulo = 'DIN'
               AND a.Cuenta = @CtaDinero 
               AND a.Conciliado = 0 
               AND (@CfgSugerirDespuesPeriodo = 1 OR a.Fecha <= @FechaA)
               AND ROUND(ISNULL(a.Cargo, 0.0), @CfgTolerancia) = @Cargo 
               AND ROUND(ISNULL(a.Abono, 0.0), @CfgTolerancia) = @Abono
               AND a.ID NOT IN (SELECT Auxiliar FROM ConciliacionD WHERE ID = @ID AND Auxiliar IS NOT NULL) 
               --AND MovID = @Referencia
        END
      END

      IF @TipoMovimiento = 'Tesoreria' AND @Auxiliar IS NOT NULL AND @MovTipo = 'CONC.BC' AND @Cuenta IS NOT NULL 
      BEGIN
        SELECT @Modulo = NULL, @ModuloID = NULL, @ContID = NULL
        SELECT @Modulo = Modulo, @ModuloID = ModuloID FROM Auxiliar WHERE ID = @Auxiliar

        IF @Modulo = 'DIN' SELECT @ContID = ContID FROM Dinero WHERE ID = @ModuloID
        IF @ContID IS NOT NULL
          SELECT @ContD = MIN(RID) 
            FROM ContD 
           WHERE ID = @ContID 
             AND Cuenta = @Cuenta 
             AND Conciliado = 0 
             AND ROUND(ISNULL(Debe, 0.0),  @CfgTolerancia) = @Cargo
             AND ROUND(ISNULL(Haber, 0.0), @CfgTolerancia) = @Abono
      END
      IF @TipoMovimiento IN ('Gasto', 'Gasto IVA')
        SELECT @Acreedor = ISNULL(@InstitucionAcreedor, @CtaDineroAcreedor), @ConceptoGasto = ISNULL(@ConceptoGasto, ISNULL(@InstitucionConcepto, @Concepto))

      /*IF @TipoMovimiento = 'Tesoreria' SELECT @ObligacionFiscal = NULL, @Tasa = NULL*/

      -- si no encontro el concepto, por omision es de tesoreria
      IF @TipoMovimiento IS NULL SELECT @TipoMovimiento = 'Tesoreria'
      UPDATE ConciliacionD 
         SET TipoMovimiento = @TipoMovimiento, Auxiliar = @Auxiliar, ContD = @ContD, ConceptoGasto = @ConceptoGasto, Acreedor = @Acreedor, ObligacionFiscal = @ObligacionFiscal, ObligacionFiscal2 = @ObligacionFiscal2, Tasa = @Tasa, TipoImporte = @TipoImporte
       WHERE ID = @ID AND RID = @RID
    END
    FETCH NEXT FROM crConciliacionD INTO @RID, @Fecha, @Concepto, @Referencia, @Cargo, @Abono, @Manual
  END
  CLOSE crConciliacionD
  DEALLOCATE crConciliacionD

  RETURN
END
GO



/**************** spConciliacionVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spConciliacionVerificar') and type = 'P') drop procedure dbo.spConciliacionVerificar
GO
CREATE PROCEDURE spConciliacionVerificar
    		    @ID               		int,
		    @Accion			char(20),
    		    @Empresa          		char(5),
		    @Usuario			char(10),
    		    @Modulo	      		char(5),
    		    @Mov              		char(20),
	            @MovID			varchar(20),
    		    @MovTipo	      		char(20),
		    @MovMoneda			char(10),
		    @MovTipoCambio		float,
		    @FechaEmision		datetime,
		    @Estatus			char(15),
		    @EstatusNuevo		char(15),

		    @CtaDinero			varchar(10),
		    @Institucion		varchar(20),
                    @Cuenta			varchar(20),
		    @FechaD			datetime,
		    @FechaA			datetime,

		    /*@SaldoAnterior		money,
		    @Cargos			money,
                    @Abonos			money,
		    @SaldoFinal			money,*/

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,
		    @CfgTolerancia		int,	
		    @CfgRepetirFecha		bit,	
		    @CfgTraslaparFecha		bit,
    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @RID			int,
    @UltRID			int,
    @Seccion			int,
    @UltimaConciliacion		datetime,
    @UltimaConciliacionID	int,
    @Fecha			datetime,
    @Concepto			varchar(50), 
    @Referencia			varchar(50), 
    @Cargo			money, 
    @Abono			money, 
    @Importe			money,
    @Manual			int, 
    @TipoMovimiento		varchar(20), 
    @UltTipoMovimiento		varchar(20), 
    @Auxiliar 			int,
    @ContD			int,
    @ConceptoGasto		varchar(50), 
    @PermiteAbonoNoIdentificado	bit,
    @CfgIVAIntegrado		bit,
    @Acreedor			varchar(10),
    @DetalleImporte		money,
    @AuxiliarImporte		money,
    @PermiteCargoNoIdentificado bit/*,
    @SumaCargos		money,
    @SumaAbonos		money*/

  IF @Accion = 'CANCELAR'
  BEGIN
    -- Checar que se haya capturado el movimiento en este modulo
    IF @Conexion = 0 
      IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo)
	SELECT @Ok = 60070
  END ELSE
  BEGIN
    IF @CfgRepetirFecha = 0
      IF EXISTS(SELECT * FROM Conciliacion WHERE Empresa = @Empresa AND CtaDinero = @CtaDinero AND Estatus = 'CONCLUIDO' AND (FechaD BETWEEN @FechaD AND @FechaA OR FechaA BETWEEN @FechaD AND @FechaA))
        SELECT @Ok = 51090

    IF @CfgTraslaparFecha = 0 AND @Ok IS NULL
    BEGIN
      EXEC spConciliacionUltima @Empresa, @CtaDinero, @UltimaConciliacion OUTPUT, @UltimaConciliacionID OUTPUT
      IF DATEDIFF(day, @UltimaConciliacion, @FechaD) <> 1 SELECT @Ok = 51095
    END

    /*IF @Ok IS NULL
    BEGIN
      SELECT @SumaCargos = SUM(Cargo), @SumaAbonos = SUM(Abono)
        FROM ConciliacionD
       WHERE ID = @ID

      IF ROUND(@SumaCargos, 2) <> ROUND(@Cargos, 2) OR ROUND(@SumaAbonos, 2) <> ROUND(@Abonos, 2)
        SELECT @Ok = 51020      
    END*/

    IF @Ok IS NULL
    BEGIN
      IF @CtaDinero IS NULL SELECT @Ok = 40030 ELSE
      IF @MovMoneda <> (SELECT Moneda FROM CtaDinero WHERE CtaDinero = @CtaDinero) SELECT @Ok = 30080 ELSE
      /*IF ROUND(@SaldoAnterior, 2) <> (SELECT ROUND(SaldoConciliado, 2) FROM DineroSaldo WHERE Empresa = @Empresa AND Moneda = @MovMoneda AND CtaDinero = @CtaDinero)
        SELECT @Ok = 51080*/

      IF @MovTipo = 'CONC.BC'
      BEGIN
        IF @Cuenta IS NULL SELECT @Ok = 51035 /*ELSE
        IF ROUND(@SaldoAnterior, 2) <> (SELECT ROUND(SaldoConciliado, 2) FROM CtaSaldo WHERE Empresa = @Empresa AND Moneda = @MovMoneda AND Cuenta = @Cuenta)
          SELECT @Ok = 51085*/
      END

    END
    IF @Ok IS NULL
    BEGIN
      SELECT @CfgIVAIntegrado = ISNULL(ConcliarIVAIntegrado, 0)
        FROM InstitucionFin
       WHERE Institucion = @Institucion

      DECLARE crConciliacionD CURSOR LOCAL FOR 
       SELECT Seccion, Fecha, Concepto, NULLIF(RTRIM(Referencia), ''), ISNULL(Cargo, 0.0), ISNULL(Abono, 0.0), NULLIF(Manual, 0), NULLIF(RTRIM(TipoMovimiento), ''), Auxiliar, ContD, NULLIF(RTRIM(ConceptoGasto), ''), NULLIF(RTRIM(Acreedor), '')
         FROM ConciliacionD
        WHERE ID = @ID
      OPEN crConciliacionD
      FETCH NEXT FROM crConciliacionD INTO @Seccion, @Fecha, @Concepto, @Referencia, @Cargo, @Abono, @Manual, @TipoMovimiento, @Auxiliar, @ContD, @ConceptoGasto, @Acreedor
      WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          SELECT @Importe = ROUND(@Cargo - @Abono, @CfgTolerancia)

          IF @Seccion = 0 AND @Fecha NOT BETWEEN @FechaD AND @FechaA SELECT @Ok = 51010
          IF @TipoMovimiento = 'Gasto' AND @Acreedor      IS NULL SELECT @Ok = 51030 ELSE
          IF @TipoMovimiento = 'Gasto' AND @ConceptoGasto IS NULL SELECT @Ok = 51040 ELSE
          IF @TipoMovimiento = 'Gasto IVA'
          BEGIN
            IF @CfgIVAIntegrado = 0 AND @ConceptoGasto IS NULL SELECT @Ok = 51040 ELSE
            IF @CfgIVAIntegrado = 1 AND (@UltTipoMovimiento <> 'Gasto' OR @RID - 1 <> @UltRID) SELECT @Ok = 51160 
          END ELSE
          --IF @TipoMovimiento IS NULL SELECT @Ok = 51050 ELSE
          IF @TipoMovimiento = 'Tesoreria' AND @Auxiliar IS NULL 
          BEGIN
            EXEC spInstitucionFinConcepto @Institucion, @Concepto, @PermiteAbonoNoIdentificado = @PermiteAbonoNoIdentificado OUTPUT, @PermiteCargoNoIdentificado = @PermiteCargoNoIdentificado OUTPUT
            IF @Abono > 0.0 AND @PermiteAbonoNoIdentificado = 1
              SELECT @Ok = @Ok
            IF @Cargo > 0.0 AND @PermiteCargoNoIdentificado = 1
              SELECT @Ok = @Ok
            --ELSE SELECT @Ok = 51060 
          END ELSE
          IF @TipoMovimiento = 'Tesoreria' AND @MovTipo = 'CONC.BC' AND @ContD IS NULL SELECT @Ok = 51070 ELSE
          IF @Auxiliar IS NOT NULL IF @Importe <> ROUND((SELECT ISNULL(Abono, 0.0)-ISNULL(Cargo, 0.0) FROM Auxiliar WHERE ID = @Auxiliar), @CfgTolerancia)
            SELECT @Ok = 51120
          IF @ContD IS NOT NULL IF @Importe <> ROUND((SELECT ISNULL(Haber, 0.0)-ISNULL(Debe, 0.0) FROM ContD WHERE RID = @ContD), @CfgTolerancia)
            SELECT @Ok = 51130
        END
        IF @Ok IS NOT NULL AND @OkRef IS NULL 
          SELECT @OkRef = dbo.fnDateTimeToDDMMMAA(@Fecha)+' - '+@Concepto+' '+@Referencia+' '+CONVERT(varchar, @Importe)

        SELECT @UltRID = @RID, @UltTipoMovimiento = @TipoMovimiento
        FETCH NEXT FROM crConciliacionD INTO @Seccion, @Fecha, @Concepto, @Referencia, @Cargo, @Abono, @Manual, @TipoMovimiento, @Auxiliar, @ContD, @ConceptoGasto, @Acreedor
      END
      CLOSE crConciliacionD
      DEALLOCATE crConciliacionD
    END
  END
  IF @Ok IS NULL
  BEGIN
    SELECT @DetalleImporte = 0.0, @AuxiliarImporte = 0.0
    SELECT @DetalleImporte = SUM(ISNULL(d.Abono, 0.0)-ISNULL(d.Cargo, 0.0))
      FROM ConciliacionCompensacion c
      JOIN ConciliacionD d ON d.ID = c.ID AND d.RID = c.ConciliacionD
     WHERE c.ID = @ID
     
    SELECT @AuxiliarImporte = SUM(ISNULL(a.Cargo, 0.0)-ISNULL(a.Abono, 0.0))
      FROM ConciliacionCompensacion c
      JOIN Auxiliar a ON a.ID = c.Manual 
     WHERE c.ID = @ID

    IF ROUND(@DetalleImporte, 0) <> ROUND(@AuxiliarImporte, 0) SELECT @Ok = 25500, @OkRef = 'Compensacion Manual'
  END

  RETURN
END
GO

/**************** spConciliacionBuscarAux  ****************/
if exists (select * from sysobjects where id = object_id('dbo.spConciliacionBuscarAux') and type = 'P') drop procedure dbo.spConciliacionBuscarAux
GO             
CREATE PROCEDURE spConciliacionBuscarAux
			@Empresa		char(5),
			@MovTipo		varchar(20),
    			@DineroID		int,
    			@CtaDinero		varchar(10),
    			@Cuenta			varchar(20),
			@Cargo			money,
			@Abono			money,
			@Auxiliar 		int		OUTPUT, 
			@ContD 			int		OUTPUT, 

		   	@CfgTolerancia		int,			     
			@Ok 			int		OUTPUT, 
			@OkRef 			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @DineroMov		varchar(20),
    @DineroMovID	varchar(20),
    @ContID		int

  IF @Ok IS NOT NULL RETURN
  SELECT @Auxiliar = NULL, @ContD = NULL, @Cargo = NULLIF(@Cargo, 0.0), @Abono = NULLIF(@Abono, 0.0)
  SELECT @DineroMov = Mov, @DineroMovID = MovID, @ContID = ContID FROM Dinero WHERE ID = @DineroID

  IF @Cargo IS NOT NULL
    SELECT @Auxiliar = MIN(ID) 
      FROM Auxiliar 
     WHERE Empresa = @Empresa AND Rama = 'DIN' AND Mov = @DineroMov AND MovID = @DineroMovID AND Modulo = 'DIN' AND ModuloID = @DineroID AND Cuenta = @CtaDinero AND ROUND(Cargo, @CfgTolerancia) = ROUND(@Cargo, @CfgTolerancia)
  ELSE
  IF @Abono IS NOT NULL
    SELECT @Auxiliar = MIN(ID) 
      FROM Auxiliar 
     WHERE Empresa = @Empresa AND Rama = 'DIN' AND Mov = @DineroMov AND MovID = @DineroMovID AND Modulo = 'DIN' AND ModuloID = @DineroID AND Cuenta = @CtaDinero AND ROUND(Abono, @CfgTolerancia) = ROUND(@Abono, @CfgTolerancia)

  IF @MovTipo = 'CONC.BC'
    IF (SELECT Estatus FROM Cont WHERE ID = @ContID) = 'CONCLUIDO'
    BEGIN
      IF @Cargo IS NOT NULL
        SELECT @ContD = MIN(RID) 
          FROM ContD 
         WHERE ID = @ContID 
           AND Cuenta = @Cuenta 
           AND Conciliado = 0 
           AND ROUND(ISNULL(Debe, 0.0),  @CfgTolerancia) = ROUND(@Cargo, @CfgTolerancia)
      ELSE
      IF @Abono IS NOT NULL
        SELECT @ContD = MIN(RID) 
          FROM ContD 
         WHERE ID = @ContID 
           AND Cuenta = @Cuenta 
           AND Conciliado = 0 
           AND ROUND(ISNULL(Haber, 0.0),  @CfgTolerancia) = ROUND(@Abono, @CfgTolerancia)
    END

  IF @Auxiliar IS NULL SELECT @Ok = 51140 ELSE
  IF @MovTipo = 'CONC.BC' AND @ContD IS NULL SELECT @Ok = 51150

  RETURN
END
GO

/**************** spConciliacionDepositoAnticipado  ****************/
if exists (select * from sysobjects where id = object_id('dbo.spConciliacionDepositoAnticipado') and type = 'P') drop procedure dbo.spConciliacionDepositoAnticipado 
GO             
CREATE PROCEDURE spConciliacionDepositoAnticipado 
			@Empresa		char(5), 
			@Sucursal		int,			
			@ID			int, 
			@Mov			varchar(20),
			@MovID			varchar(20),
			@MovTipo		varchar(20),
			@CtaDinero		varchar(10), 
			@Institucion		varchar(20), 
			@Cuenta			varchar(20), 
			@Fecha			datetime, 
			@Concepto		varchar(50), 
			@Referencia		varchar(50), 
			@Observaciones		varchar(100), 
			@Importe		money, 
			@Auxiliar 		int		OUTPUT, 
			@ContD 			int		OUTPUT, 

		   	@CfgTolerancia		int,		
--DSG		   		  
		  @Usuario     varchar(10),
--DSG		  		   		     
			@Ok 			int		OUTPUT, 
			@OkRef 			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ConDesglose	bit,
    @FormaPago		varchar(50),
    @DineroID		int,
    @DineroMov		varchar(20),
    @DineroMovID	varchar(20)

  SELECT @DineroMov = BancoDepositoAnticipado
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa
 
  SELECT @ConDesglose = DineroDesgloseObligatorio,
         @FormaPago   = FormaPagoEfectivo
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  INSERT Dinero (
          OrigenTipo, Origen, OrigenID, Sucursal,  SucursalOrigen, SucursalDestino,  Empresa,  Mov,        FechaEmision,  Moneda, TipoCambio, Usuario,  Estatus,      CtaDinero,  Importe,  Concepto,  Referencia,  Observaciones,  ConDesglose,  FormaPago,  UEN, Proyecto)
  SELECT  'CONC',     @Mov,   @MovID,   @Sucursal, SucursalOrigen, SucursalDestino,  Empresa,  @DineroMov, @Fecha,        Moneda, TipoCambio, Usuario,  'SINAFECTAR', CtaDinero,  @Importe, @Concepto, @Referencia, @Observaciones, @ConDesglose, @FormaPago, UEN, Proyecto
    FROM Conciliacion
   WHERE ID = @ID
  SELECT @DineroID = SCOPE_IDENTITY()
  INSERT DineroD (Sucursal,  ID,        Renglon, Importe,  FormaPago) 
          VALUES (@Sucursal, @DineroID, 2048,    @Importe, @FormaPago) 
--DSG 
-- Se agrego el Usuraio al Afectar
  EXEC spAfectar 'DIN', @DineroID, @EnSilencio = 1, @Conexion = 1, @Usuario = @Usuario, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
--DSG

  IF @Ok IS NULL
  BEGIN
    SELECT @DineroMovID = MovID FROM Dinero WHERE ID = @DineroID
    EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, 'CONC', @ID, @Mov, @MovID, 'DIN', @DineroID, @DineroMov, @DineroMovID, @Ok OUTPUT
    EXEC spConciliacionBuscarAux @Empresa, @MovTipo, @DineroID, @CtaDinero, @Cuenta, @Importe, NULL, @Auxiliar OUTPUT, @ContD OUTPUT, @CfgTolerancia, @Ok OUTPUT, @OkRef OUTPUT
  END
  RETURN
END
GO

/**************** spConciliacionCargoNoIdentificado  ****************/
if exists (select * from sysobjects where id = object_id('dbo.spConciliacionCargoNoIdentificado') and type = 'P') drop procedure dbo.spConciliacionCargoNoIdentificado 
GO             
CREATE PROCEDURE spConciliacionCargoNoIdentificado 
			@Empresa		char(5), 
			@Sucursal		int,			
			@ID			int, 
			@Mov			varchar(20),
			@MovID			varchar(20),
			@MovTipo		varchar(20),
			@CtaDinero		varchar(10), 
			@Institucion		varchar(20), 
			@Cuenta			varchar(20), 
			@Fecha			datetime, 
			@Concepto		varchar(50), 
			@Referencia		varchar(50), 
			@Observaciones		varchar(100), 
			@Importe		money, 
			@Auxiliar 		int		OUTPUT, 
			@ContD 			int		OUTPUT, 

		   	@CfgTolerancia		int,		
--DSG		   		  
		  @Usuario     varchar(10),
--DSG		  
			@Ok 			int		OUTPUT, 
			@OkRef 			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ConDesglose	bit,
    @FormaPago		varchar(50),
    @DineroID		int,
    @DineroMov		varchar(20),
    @DineroMovID	varchar(20)

  SELECT @DineroMov = BancoCargoNoIdentificado
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa
 
  SELECT @ConDesglose = DineroDesgloseObligatorio,
         @FormaPago   = FormaPagoEfectivo
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  INSERT Dinero (
          OrigenTipo, Origen, OrigenID, Sucursal,  SucursalOrigen, SucursalDestino,  Empresa,  Mov,        FechaEmision,  Moneda, TipoCambio, Usuario,  Estatus,      CtaDinero,  Importe,  Concepto,  Referencia,  Observaciones,  ConDesglose,  FormaPago,  UEN, Proyecto)
  SELECT  'CONC',     @Mov,   @MovID,   @Sucursal, SucursalOrigen, SucursalDestino,  Empresa,  @DineroMov, @Fecha,        Moneda, TipoCambio, Usuario,  'SINAFECTAR', CtaDinero,  @Importe, @Concepto, @Referencia, @Observaciones, @ConDesglose, @FormaPago, UEN, Proyecto
	    FROM Conciliacion
   WHERE ID = @ID
  SELECT @DineroID = SCOPE_IDENTITY()
  INSERT DineroD (Sucursal,  ID,        Renglon, Importe,  FormaPago) 
          VALUES (@Sucursal, @DineroID, 2048,    @Importe, @FormaPago) 

--DSG 
-- Se agrego el Usuraio al Afectar
  EXEC spAfectar 'DIN', @DineroID, @EnSilencio = 1, @Conexion = 1, @Usuario = @Usuario, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
--DSG
  
  IF @Ok IS NULL
  BEGIN
    SELECT @DineroMovID = MovID FROM Dinero WHERE ID = @DineroID
    EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, 'CONC', @ID, @Mov, @MovID, 'DIN', @DineroID, @DineroMov, @DineroMovID, @Ok OUTPUT
    EXEC spConciliacionBuscarAux @Empresa, @MovTipo, @DineroID, @CtaDinero, @Cuenta, NULL, @Importe, @Auxiliar OUTPUT, @ContD OUTPUT, @CfgTolerancia, @Ok OUTPUT, @OkRef OUTPUT
  END
  RETURN
END
GO


/**************** spConciliacionAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spConciliacionAfectar') and type = 'P') drop procedure dbo.spConciliacionAfectar
GO 
CREATE PROCEDURE spConciliacionAfectar
    		   @ID                		int,

		   @Accion			char(20),
    		   @Empresa	      		char(5),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20)	OUTPUT,
    		   @MovTipo     		char(20),
		   @MovMoneda			char(10),
		   @MovTipoCambio		float,
    		   @FechaEmision      		datetime,
    		   @FechaAfectacion      	datetime,
    		   @FechaConclusion		datetime,

    	 	   @Proyecto	      		varchar(50),
    		   @Usuario	      		char(10),
    		   @Autorizacion      		char(10),
    		   @DocFuente	      		int,
    		   @Observaciones     		varchar(255),
    		   @Concepto     		varchar(50),
		   @Referencia			varchar(50),
    		   @Estatus           		char(15),
 	    	   @EstatusNuevo	      	char(15),
    		   @FechaRegistro     		datetime,
    		   @Ejercicio	      		int,
    		   @Periodo	      		int,
		   @MovUsuario			char(10),

		   @CtaDinero			varchar(10),
		   @Institucion			varchar(20),
                   @Cuenta			varchar(20),
		   @FechaD			datetime,
		   @FechaA			datetime,

		   /*@SaldoAnterior		money,
		   @Cargos			money,
                   @Abonos			money,
		   @SaldoFinal			money,*/

		   @Conexion			bit,
                   @SincroFinal			bit,
                   @Sucursal			int,
                   @SucursalDestino		int,
                   @SucursalOrigen		int,

		   @CfgTolerancia		int,	
                   @CfgRepetirFecha		bit,
                   @CfgTraslaparFecha		bit,
		   @CfgContX			bit,
		   @CfgContXGenerar		char(20),
		   @GenerarPoliza		bit,

		   @Generar			bit,
    		   @GenerarMov			char(20),
	           @GenerarAfectado		bit,
		   @IDGenerar			int	     	OUTPUT,	
    		   @GenerarMovID	  	varchar(20)	OUTPUT,

       		   @Ok                		int          OUTPUT,
    		   @OkRef             		varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @RID			int,
    @Especial			varchar(50),
    @SubEspecial		varchar(50),
    @Fecha			datetime,
    @TieneSubConceptos		bit,
    @NominaSubConcepto		varchar(10),
    @FechaCancelacion		datetime,
    @GenerarMovTipo		char(20),
    @GenerarPeriodo		int,
    @GenerarEjercicio		int,
    @Cargo			money, 
    @Abono			money, 
    @DineroCargo		money, 
    @DineroAbono		money, 
    @Importe			money, 
    @Manual			int, 
    @TipoMovimiento		varchar(20), 
    @Auxiliar			int, 
    @ContD			int, 
    @ConceptoGasto		varchar(50), 
    @Acreedor			varchar(10),
    @Saldo			money,
    @CargoBancarioMov		varchar(20),
    @CargoBancarioIVAMov	varchar(20),
    @AbonoBancarioMov		varchar(20),
    @AbonoBancarioIVAMov	varchar(20),
    @GastoID			int,
    @GastoMov			varchar(20),
    @GastoMovID			varchar(20),
    @GastoImporte		money,
    @GastoImpuestos		money,
    @Clase			varchar(50), 
    @SubClase 			varchar(50), 
    @PorcentajeDeducible	float,
    @DefFormaPago		varchar(50),
    @DineroID			int,
    @PPTO			bit,
    @SaldoLibros		money,
    @SaldoConciliado		money,
    @CxModulo			varchar(5),
    @CxID			int,
    @MovCobro			varchar(20),
    @MovPago			varchar(20),
    @IVAFiscal			float,
    @GenerarCxID		int,
    @GenerarCxMov		varchar(20),
    @GenerarCxMovID		varchar(20),
    @GenerarCxImporteTotal	float,
    @GenerarCxImpuestos		float,
    @FormaPagoEfectivo		varchar(50),
    @PermiteAbonoNoIdentificado	bit,
    @CfgIVAIntegrado		bit,
    @PermiteCargoNoIdentificado bit

  SELECT @PPTO = PPTO FROM EmpresaGral WHERE Empresa = @Empresa
  SELECT @FormaPagoEfectivo = FormaPagoEfectivo
    FROM EmpresaCfg
   WHERE Empresa = @Empresa
  SELECT @MovCobro = CxcCobro,
         @MovPago = CxpPago
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  SELECT @CfgIVAIntegrado = ISNULL(ConcliarIVAIntegrado, 0)
    FROM InstitucionFin
   WHERE Institucion = @Institucion

  CREATE TABLE #MovImpuesto (
      Impuesto1		float		NULL,
      Impuesto2		float		NULL,
      Impuesto3		float		NULL,
      Importe1		money		NULL,
      Importe2		money		NULL,
      Importe3		money		NULL,
      SubTotal		money		NULL,
      TipoImpuesto1	varchar(10)	COLLATE Database_Default NULL,
      TipoImpuesto2	varchar(10)	COLLATE Database_Default NULL,
      TipoImpuesto3	varchar(10)	COLLATE Database_Default NULL,
      TipoRetencion1	varchar(10)	COLLATE Database_Default NULL,
      TipoRetencion2	varchar(10)	COLLATE Database_Default NULL,
      TipoRetencion3	varchar(10)	COLLATE Database_Default NULL,
      LoteFijo		varchar(20)	COLLATE Database_Default NULL,
      OrigenModulo	varchar(5)	COLLATE Database_Default NULL,
      OrigenModuloID	int		NULL,
      OrigenConcepto	varchar(50)	COLLATE Database_Default NULL,
      OrigenDeducible	float		NULL	DEFAULT 100, 	
      OrigenFecha	datetime	NULL,
      Retencion1	float		NULL,
      Retencion2	float		NULL,
      Retencion3	float		NULL,
      Excento1		bit		NULL	DEFAULT 0,
      Excento2		bit		NULL	DEFAULT 0,
      Excento3		bit		NULL	DEFAULT 0,
      ContUso		varchar(20)	COLLATE Database_Default NULL,
      ContUso2		varchar(20)	COLLATE Database_Default NULL,
      ContUso3		varchar(20)	COLLATE Database_Default NULL,
      ClavePresupuestal	varchar(30)	COLLATE Database_Default NULL,
      DescuentoGlobal			float		NULL,
      AplicaModulo              varchar(20) NULL,
      AplicaID                  int NULL,
   )

  IF @PPTO = 1
    CREATE TABLE #MovPresupuesto (
	Importe			money		NULL,
        CuentaPresupuesto	varchar(20)	COLLATE Database_Default NULL)

  SELECT @DefFormaPago = FormaPagoEfectivo 
    FROM EmpresaCfg 
   WHERE Empresa = @Empresa
  SELECT @CargoBancarioMov    = GastoCargoBancario,
         @CargoBancarioIVAMov = GastoCargoBancarioIVA,
         @AbonoBancarioMov    = GastoAbonoBancario,
         @AbonoBancarioIVAMov = GastoAbonoBancarioIVA
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  -- Asignar el Consecutivo al Movimiento
  EXEC spMovConsecutivo @Sucursal, @SucursalOrigen, @SucursalDestino, @Empresa, @Usuario, @Modulo, @Ejercicio, @Periodo, @ID, @Mov, NULL, @Estatus, @Concepto, @Accion, @Conexion, @SincroFinal, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  IF @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') AND @Accion <> 'CANCELAR' AND @Ok IS NULL
    EXEC spMovChecarConsecutivo	@Empresa, @Modulo, @Mov, @MovID, NULL, @Ejercicio, @Periodo, @Ok OUTPUT, @OkRef OUTPUT

  IF @Accion IN ('CONSECUTIVO', 'SINCRO') AND @Ok IS NULL
  BEGIN
    IF @Accion = 'SINCRO' EXEC spAsignarSucursalEstatus @ID, @Modulo, @SucursalDestino, @Accion
    SELECT @Ok = 80060, @OkRef = @MovID
    RETURN
  END

  IF @OK IS NOT NULL RETURN 

  -- Generar Mov Nuevo
  IF @Accion = 'GENERAR' AND @Ok IS NULL
  BEGIN
    EXEC spMovGenerar @Sucursal, @Empresa, @Modulo, @Ejercicio, @Periodo, @Usuario, @FechaRegistro, 'SINAFECTAR', 
		      NULL, NULL, 
                      @Mov, @MovID, 0,
		      @GenerarMov, NULL, @GenerarMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    -- Leer MovTipo, Periodo y Ejercicio	
    EXEC spMovTipo @Modulo, @GenerarMov, @FechaAfectacion, @Empresa, NULL, NULL, @GenerarMovTipo OUTPUT, @GenerarPeriodo OUTPUT, @GenerarEjercicio OUTPUT, @Ok OUTPUT
    IF @Ok IS NULL SELECT @Ok = 80030
    RETURN
  END


  IF @Conexion = 0 
    BEGIN TRANSACTION

    -- Poner el Estatus del Movimiento en "AFECTANDO"
    EXEC spMovEstatus @Modulo, 'AFECTANDO', @ID, @Generar, @IDGenerar, @GenerarAfectado, @Ok OUTPUT

    IF @Accion <> 'CANCELAR' 
      -- Registrar el Movimiento en "Mov"
      EXEC spRegistrarMovimiento @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @Ejercicio, @Periodo, @FechaRegistro, @FechaEmision,
                       	         NULL, @Proyecto, @MovMoneda, @MovTipoCambio,
                       	         @Usuario, @Autorizacion, NULL, @DocFuente, @Observaciones,
			         @Generar, @GenerarMov, @GenerarMovID, @IDGenerar,
				 @Ok OUTPUT

    IF @Accion IN ('AFECTAR', 'CANCELAR')
    BEGIN
      -- Conciliar Movimientos (Dinero y Contabilidad)
      -- Generar Gastos

      DECLARE crConciliacionD CURSOR LOCAL READ_ONLY FAST_FORWARD FOR 
       SELECT RID, Fecha, Concepto, NULLIF(RTRIM(Referencia), ''), NULLIF(RTRIM(Observaciones), ''), ISNULL(Cargo, 0.0), ISNULL(Abono, 0.0), NULLIF(Manual, 0), NULLIF(RTRIM(TipoMovimiento), ''), Auxiliar, ContD, NULLIF(RTRIM(ConceptoGasto), ''), NULLIF(RTRIM(Acreedor), '')
         FROM ConciliacionD
        WHERE ID = @ID AND Seccion IN (0, 1)
      OPEN crConciliacionD
      FETCH NEXT FROM crConciliacionD INTO @RID, @Fecha, @Concepto, @Referencia, @Observaciones, @Cargo, @Abono, @Manual, @TipoMovimiento, @Auxiliar, @ContD, @ConceptoGasto, @Acreedor
      WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 AND @Ok IS NULL
      BEGIN
        SELECT @Importe = @Cargo - @Abono
        IF @@FETCH_STATUS <> -2 AND @Importe <> 0.0
        BEGIN
          IF @Auxiliar IS NULL AND @Accion = 'AFECTAR'
          BEGIN
            EXEC spInstitucionFinConcepto @Institucion, @Concepto, @PermiteAbonoNoIdentificado = @PermiteAbonoNoIdentificado OUTPUT, @PermiteCargoNoIdentificado = @PermiteCargoNoIdentificado OUTPUT
            IF @PermiteAbonoNoIdentificado = 1 AND @PermiteCargoNoIdentificado = 1
                SELECT @Ok = 51135
            ELSE  
            BEGIN 	
                IF @TipoMovimiento = 'Tesoreria' AND @Abono > 0.0 AND @PermiteAbonoNoIdentificado = 1
                BEGIN
--DSG Se agrega el usuario al SP spConciliacionDepositoAnticipado             
                  EXEC spConciliacionDepositoAnticipado @Empresa, @Sucursal, @ID, @Mov, @MovID, @MovTipo, @CtaDinero, @Institucion, @Cuenta, @Fecha, @Concepto, @Referencia, @Observaciones, @Abono, @Auxiliar OUTPUT, @ContD OUTPUT, @CfgTolerancia, @Usuario, @Ok OUTPUT, @OkRef OUTPUT
                  UPDATE ConciliacionD SET Auxiliar = @Auxiliar, ContD = @ContD WHERE ID = @ID AND RID = @RID
                END
                /*DSG Crear Un Cargo No Identificado*/
                IF @TipoMovimiento = 'Tesoreria' AND @Cargo > 0.0 AND @PermiteCargoNoIdentificado = 1
                BEGIN            	
--DSG Se agrega el usuario al SP spConciliacionCargoNoIdentificado                                
                  EXEC spConciliacionCargoNoIdentificado @Empresa, @Sucursal, @ID, @Mov, @MovID, @MovTipo, @CtaDinero, @Institucion, @Cuenta, @Fecha, @Concepto, @Referencia, @Observaciones, @Cargo, @Auxiliar OUTPUT, @ContD OUTPUT, @CfgTolerancia, @Usuario, @Ok OUTPUT, @OkRef OUTPUT
                  UPDATE ConciliacionD SET Auxiliar = @Auxiliar, ContD = @ContD WHERE ID = @ID AND RID = @RID
                END 
            END                  
            IF @TipoMovimiento = 'Gasto' OR (@TipoMovimiento = 'Gasto IVA' AND @CfgIVAIntegrado = 0)
            BEGIN
              SELECT @PorcentajeDeducible = 100.0, @GastoImporte = 0.0, @GastoImpuestos = 0.0
              SELECT @Clase = Clase, @SubClase = SubClase, @PorcentajeDeducible = PorcentajeDeducible FROM Concepto WHERE Modulo = 'GAS' AND Concepto = @ConceptoGasto

              IF @TipoMovimiento = 'Gasto IVA' AND @CfgIVAIntegrado = 0
              BEGIN
                IF @Importe > 0.0 
                  SELECT @GastoMov = @CargoBancarioIVAMov, @GastoImporte = @Importe 
                ELSE 
                 SELECT @GastoMov = @AbonoBancarioIVAMov, @GastoImporte = -@Importe
              END ELSE
              BEGIN
                IF @Importe > 0.0 
                  SELECT @GastoMov = @CargoBancarioMov, @GastoImporte = @Importe 
                ELSE 
                 SELECT @GastoMov = @AbonoBancarioMov, @GastoImporte = -@Importe

                IF @CfgIVAIntegrado = 1
                  SELECT @GastoImpuestos = ISNULL(CASE WHEN @Cargo > 0.0 THEN Cargo ELSE Abono END, 0.0)
                    FROM ConciliacionD 
                   WHERE ID = @ID AND RID = @RID + 1 AND TipoMovimiento = 'Gasto IVA'
              END

              INSERT Gasto (Sucursal,  Empresa,  Mov,       FechaEmision,  Moneda,     TipoCambio,     Usuario,  FormaPago,     Estatus,      UltimoCambio, Acreedor,  CtaDinero,  Clase,  SubClase,  OrigenTipo, Origen, OrigenID, Prioridad)
                    VALUES (@Sucursal, @Empresa, @GastoMov, @Fecha,        @MovMoneda, @MovTipoCambio, @Usuario, @DefFormaPago, 'SINAFECTAR', GETDATE(),    @Acreedor, @CtaDinero, @Clase, @SubClase, @Modulo,    @Mov,   @MovID,   'Normal')
              SELECT @GastoID = SCOPE_IDENTITY()
              INSERT GastoD (ID,       Renglon,  Concepto,       Fecha,  Referencia,  Cantidad,  Precio,        Importe,       Impuestos,       Sucursal,  PorcentajeDeducible)
                     VALUES (@GastoID, 2048.0,   @ConceptoGasto, @Fecha, @Referencia, 1,         @GastoImporte, @GastoImporte, @GastoImpuestos, @Sucursal, @PorcentajeDeducible)

              EXEC spGasto @GastoID, 'GAS', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @GastoMov, @GastoMovID OUTPUT, NULL, @Ok OUTPUT, @OkRef OUTPUT
              IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
              EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'GAS', @GastoID, @GastoMov, @GastoMovID, @Ok OUTPUT

              IF @Ok IS NULL
              BEGIN
                IF @GastoImpuestos <> 0.0
                BEGIN
                  SELECT @DineroID = NULL
                  SELECT @DineroID = MIN(ID) FROM Dinero WHERE Empresa = @Empresa AND OrigenTipo = 'GAS' AND Origen = @GastoMov AND OrigenID = @GastoMovID AND Estatus IN ('CONCLUIDO', 'CONCILIADO') AND ROUND(Importe, 2) = ROUND(@GastoImpuestos, 2) AND FechaEmision = @Fecha
                  IF @Importe > 0.0 
                    SELECT @DineroCargo = @GastoImpuestos, @DineroAbono = NULL 
                  ELSE
                    SELECT @DineroCargo = NULL, @DineroAbono = @GastoImpuestos
                  EXEC spConciliacionBuscarAux @Empresa, @MovTipo, @DineroID, @CtaDinero, @Cuenta, @DineroAbono, @DineroCargo, @Auxiliar OUTPUT, @ContD OUTPUT, @CfgTolerancia, @Ok OUTPUT, @OkRef OUTPUT
                  UPDATE ConciliacionD SET Auxiliar = @Auxiliar, ContD = @ContD WHERE ID = @ID AND RID = @RID + 1
                END

                SELECT @DineroID = NULL
                SELECT @DineroID = MIN(ID) FROM Dinero WHERE Empresa = @Empresa AND OrigenTipo = 'GAS' AND Origen = @GastoMov AND OrigenID = @GastoMovID AND Estatus IN ('CONCLUIDO', 'CONCILIADO') AND ROUND(Importe, 2) = ROUND(@GastoImporte, 2) AND FechaEmision = @Fecha
                  IF @Importe > 0.0 
                    SELECT @DineroCargo = @GastoImporte, @DineroAbono = NULL 
                  ELSE
                    SELECT @DineroCargo = NULL, @DineroAbono = @GastoImporte
                EXEC spConciliacionBuscarAux @Empresa, @MovTipo, @DineroID, @CtaDinero, @Cuenta, @DineroAbono, @DineroCargo, @Auxiliar OUTPUT, @ContD OUTPUT, @CfgTolerancia, @Ok OUTPUT, @OkRef OUTPUT
                UPDATE ConciliacionD SET Auxiliar = @Auxiliar, ContD = @ContD WHERE ID = @ID AND RID = @RID
             END
            END ELSE
            IF @TipoMovimiento IN ('Cuenta por Cobrar', 'Cuenta por Pagar')
            BEGIN
--DSG Se limpia la variable  @CxModulo          
              SELECT @CxModulo = NULL
              EXEC spConciliacionBuscarReferencia @Empresa, @Fecha, @Referencia, @TipoMovimiento, @CxModulo OUTPUT, @CxID OUTPUT, @IVAFiscal OUTPUT
              IF @CxID IS NOT NULL
              BEGIN
                IF @CxModulo = 'CXC' 
                  SELECT @GenerarCxMov = @MovCobro, @GenerarCxImporteTotal =  @Abono
                ELSE 
                  SELECT @GenerarCxMov = @MovPago, @GenerarCxImporteTotal =  @Cargo 
                EXEC @GenerarCxID = spAfectar @CxModulo, @CxID, 'GENERAR', 'Todo', @GenerarCxMov, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

                SELECT @GenerarCxImpuestos = @GenerarCxImporteTotal * @IVAFiscal
                IF @CxModulo = 'CXC'
                BEGIN
                  UPDATE Cxc SET CtaDinero = @CtaDinero, FormaCobro = @FormaPagoEfectivo, Importe = @GenerarCxImporteTotal - ISNULL(@GenerarCxImpuestos, 0.0), Impuestos = @GenerarCxImpuestos WHERE ID = @GenerarCxID
                  UPDATE CxcD SET Importe = @GenerarCxImporteTotal WHERE ID = @GenerarCxID
                END ELSE
                BEGIN
                  UPDATE Cxp SET CtaDinero = @CtaDinero, FormaPago  = @FormaPagoEfectivo, Importe = @GenerarCxImporteTotal - ISNULL(@GenerarCxImpuestos, 0.0), Impuestos = @GenerarCxImpuestos WHERE ID = @GenerarCxID
                  UPDATE CxpD SET Importe = @GenerarCxImporteTotal WHERE ID = @GenerarCxID
                END
                EXEC spAfectar @CxModulo, @GenerarCxID, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
                IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
                IF @CxModulo = 'CXC'
                  SELECT @GenerarCxMovID = MovID FROM Cxc WHERE ID = @GenerarCxID
                ELSE
                  SELECT @GenerarCxMovID = MovID FROM Cxp WHERE ID = @GenerarCxID
                EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @CxModulo, @GenerarCxID, @GenerarCxMov, @GenerarCxMovID, @Ok OUTPUT
                IF @Ok IS NULL
                BEGIN
                  SELECT @DineroID = NULL
                  SELECT @DineroID = MIN(ID) FROM Dinero WHERE Empresa = @Empresa AND OrigenTipo = @CxModulo AND Origen = @GenerarCxMov AND OrigenID = @GenerarCxMovID AND Estatus IN ('CONCLUIDO', 'CONCILIADO')
                  IF @DineroID IS NULL 
                    SELECT @Ok = 51170, @OkRef = @FormaPagoEfectivo
                  ELSE BEGIN
                    EXEC spConciliacionBuscarAux @Empresa, @MovTipo, @DineroID, @CtaDinero, @Cuenta, @Abono, @Cargo, @Auxiliar OUTPUT, @ContD OUTPUT, @CfgTolerancia, @Ok OUTPUT, @OkRef OUTPUT
                    UPDATE ConciliacionD SET Auxiliar = @Auxiliar, ContD = @ContD WHERE ID = @ID AND RID = @RID
                  END
                END
              END
            END
          END

          /*IF @Auxiliar IS NULL 
            SELECT @Ok = 51060
          ELSE */
          IF @Auxiliar NOT IN (NULL, -1)
          BEGIN
            IF @Accion = 'AFECTAR'
            BEGIN
              IF EXISTS(SELECT * FROM ConciliacionCompensacion WHERE ID = @ID AND ConciliacionD = @RID)
                SELECT @Ok = 51180, @OkRef = 'Detalle'
              IF EXISTS(SELECT * FROM ConciliacionCompensacion WHERE ID = @ID AND Manual = @Auxiliar)
                SELECT @Ok = 51180, @OkRef = 'Auxiliar'
              INSERT #MovImpuesto (
                     OrigenModulo,    OrigenModuloID,    OrigenConcepto,    OrigenDeducible,		     OrigenFecha,    LoteFijo,    Retencion1,    Retencion2,    Retencion3,    Excento1,    Excento2,    Excento3,    Impuesto1,    Impuesto2,    Impuesto3,    Importe1,    Importe2,    Importe3,    TipoImpuesto1,    TipoImpuesto2,    TipoImpuesto3,    TipoRetencion1,    TipoRetencion2,    TipoRetencion3,    SubTotal,    ContUso,    ContUso2,    ContUso3,    ClavePresupuestal,    DescuentoGlobal, AplicaModulo, aplicaID)
              SELECT mi.OrigenModulo, mi.OrigenModuloID, mi.OrigenConcepto, ISNULL(mi.OrigenDeducible, 100), mi.OrigenFecha, mi.LoteFijo, mi.Retencion1, mi.Retencion2, mi.Retencion3, mi.Excento1, mi.Excento2, mi.Excento3, mi.Impuesto1, mi.Impuesto2, mi.Impuesto3, mi.Importe1, mi.Importe2, mi.Importe3, mi.TipoImpuesto1, mi.TipoImpuesto2, mi.TipoImpuesto3, mi.TipoRetencion1, mi.TipoRetencion2, mi.TipoRetencion3, mi.SubTotal, mi.ContUso, mi.ContUso2, mi.ContUso3, mi.ClavePresupuestal, mi.DescuentoGlobal,
                     CASE WHEN (mt.clave = 'DIN.CH' AND omt.Clave = 'CXC.CAP') OR (mt.clave = 'DIN.D' AND omt.Clave = 'CXP.CAP') THEN mi.Modulo ELSE NULL END,
                     CASE WHEN (mt.clave = 'DIN.CH' AND omt.Clave = 'CXC.CAP') OR (mt.clave = 'DIN.D' AND omt.Clave = 'CXP.CAP') THEN mi.ModuloID ELSE NULL END
                FROM MovImpuesto mi
                JOIN Auxiliar a ON a.ID = @Auxiliar
                JOIN MovTipo mt ON a.Modulo = mt.Modulo AND a.Mov = mt.Mov
                JOIN Mov om ON om.Empresa = @Empresa AND om.Modulo = mi.OrigenModulo AND om.ID = mi.OrigenModuloID
                JOIN MovTipo omt ON omt.Modulo = om.Modulo AND omt.Mov  = om.Mov
               WHERE mi.Modulo = a.Modulo AND mi.ModuloID = a.ModuloID

              IF @PPTO = 1
                INSERT #MovPresupuesto (
                       CuentaPresupuesto,    Importe)
                SELECT mp.CuentaPresupuesto, mp.Importe
                  FROM MovPresupuesto mp
                  JOIN Auxiliar a ON a.ID = @Auxiliar
                 WHERE mp.Modulo = a.Modulo AND mp.ModuloID = a.ModuloID

              UPDATE Auxiliar SET Conciliado = 1, FechaConciliacion = @Fecha WHERE ID = @Auxiliar AND Conciliado = 0
              IF @@ROWCOUNT = 0 SELECT @Ok = 51100
            END ELSE
            BEGIN
              UPDATE Auxiliar SET Conciliado = 0, FechaConciliacion = NULL   WHERE ID = @Auxiliar AND Conciliado = 1
              IF @@ROWCOUNT = 0 SELECT @Ok = 51100
            END
          END

          IF @MovTipo = 'CONC.BC'
          BEGIN
            IF @ContD IS NULL 
              SELECT @Ok = 51070
            ELSE BEGIN
              IF @Accion = 'AFECTAR'
                UPDATE ContD SET Conciliado = 1, FechaConciliacion = @Fecha WHERE RID = @ContD AND Conciliado = 0
              ELSE
                UPDATE ContD SET Conciliado = 0, FechaConciliacion = NULL   WHERE RID = @ContD AND Conciliado = 1
              IF @@ROWCOUNT = 0 SELECT @Ok = 51110
            END
          END
        END
        IF @Ok IS NOT NULL AND @OkRef IS NULL 
          SELECT @OkRef = dbo.fnDateTimeToDDMMMAA(@Fecha)+' - '+@Concepto+' '+@Referencia+' '+CONVERT(varchar, @Importe)

        FETCH NEXT FROM crConciliacionD INTO @RID, @Fecha, @Concepto, @Referencia, @Observaciones, @Cargo, @Abono, @Manual, @TipoMovimiento, @Auxiliar, @ContD, @ConceptoGasto, @Acreedor
      END
      CLOSE crConciliacionD
      DEALLOCATE crConciliacionD

      -- Compensacion Manual
      IF @Ok IS NULL AND EXISTS(SELECT * FROM ConciliacionCompensacion WHERE ID = @ID)
      BEGIN
      	-- Conciliar Auxiliares 
      	IF @Accion = 'AFECTAR'
      	BEGIN
          INSERT #MovImpuesto (
                 OrigenModulo,    OrigenModuloID,    OrigenConcepto,    OrigenDeducible,		 OrigenFecha,    LoteFijo,    Retencion1,    Retencion2,    Retencion3,    Excento1,    Excento2,    Excento3,    Impuesto1,    Impuesto2,    Impuesto3,    Importe1,    Importe2,    Importe3,    TipoImpuesto1,    TipoImpuesto2,    TipoImpuesto3,    TipoRetencion1,    TipoRetencion2,    TipoRetencion3,    SubTotal,    ContUso,    ContUso2,    ContUso3,    ClavePresupuestal,    DescuentoGlobal)
          SELECT mi.OrigenModulo, mi.OrigenModuloID, mi.OrigenConcepto, ISNULL(mi.OrigenDeducible, 100), mi.OrigenFecha, mi.LoteFijo, mi.Retencion1, mi.Retencion2, mi.Retencion3, mi.Excento1, mi.Excento2, mi.Excento3, mi.Impuesto1, mi.Impuesto2, mi.Impuesto3, mi.Importe1, mi.Importe2, mi.Importe3, mi.TipoImpuesto1, mi.TipoImpuesto2, mi.TipoImpuesto3, mi.TipoRetencion1, mi.TipoRetencion2, mi.TipoRetencion3, mi.SubTotal, mi.ContUso, mi.ContUso2, mi.ContUso3, mi.ClavePresupuestal, mi.DescuentoGlobal
            FROM MovImpuesto mi
            JOIN Auxiliar a ON a.ID IN (SELECT Manual FROM ConciliacionCompensacion WHERE ID = @ID)
           WHERE mi.Modulo = a.Modulo AND mi.ModuloID = a.ModuloID

          IF @PPTO = 1
            INSERT #MovPresupuesto (
                   CuentaPresupuesto,    Importe)
            SELECT mp.CuentaPresupuesto, mp.Importe
              FROM MovPresupuesto mp
              JOIN Auxiliar a ON a.ID IN (SELECT Manual FROM ConciliacionCompensacion WHERE ID = @ID)
             WHERE mp.Modulo = a.Modulo AND mp.ModuloID = a.ModuloID

          UPDATE ConciliacionD
      	     SET Auxiliar = -1
      	  WHERE ID = @ID AND RID IN (SELECT ConciliacionD FROM ConciliacionCompensacion WHERE ID = @ID)    	
          UPDATE Auxiliar
       	     SET Conciliado = 1, FechaConciliacion = @Fecha
      	   WHERE ID IN (SELECT Manual FROM ConciliacionCompensacion WHERE ID = @ID) AND Conciliado = 0
      	END ELSE
          UPDATE Auxiliar
       	     SET Conciliado = 0, FechaConciliacion = NULL
      	   WHERE ID IN (SELECT Manual FROM ConciliacionCompensacion WHERE ID = @ID) AND Conciliado = 1
      END

      -- Copiar los Pendientes por Conciliar de la Empresa

      IF @Accion = 'AFECTAR'
      BEGIN
        DELETE ConciliacionD WHERE ID = @ID AND Seccion = 2
        CREATE TABLE #ConciliacionD (
			ModuloID	int		NULL,
			Fecha		datetime	NULL,
			Referencia	varchar(50)	COLLATE Database_Default NULL,
			Concepto	varchar(50)	COLLATE Database_Default NULL,
			Cargo		money		NULL,
			Abono		money		NULL)
        
        CREATE INDEX ModuloID ON #ConciliacionD (ModuloID)

        INSERT #ConciliacionD (
               ModuloID, Fecha, Referencia,                      Cargo,   Abono)
        SELECT ModuloID, Fecha, RTRIM(a.Mov)+' '+RTRIM(a.MovID), a.Abono, a.Cargo
          FROM Auxiliar a
         WHERE a.Empresa = @Empresa AND a.Modulo = 'DIN' AND a.Rama = 'DIN' AND a.Cuenta = @CtaDinero AND a.Fecha <= @FechaA AND a.Conciliado = 0
               AND a.ModuloID NOT IN (SELECT d.ID FROM Dinero d WHERE d.Empresa=@Empresa AND d.Estatus = 'CANCELADO' AND (d.CtaDinero=@CtaDinero OR d.CtaDineroDestino = @CtaDinero))   

        UPDATE #ConciliacionD
           SET Concepto = mi.Descripcion
          FROM #ConciliacionD a
          LEFT OUTER JOIN Dinero d ON d.ID = a.ModuloID AND d.Estatus IN ('PENDIENTE', 'CONCLUIDO', 'CONCILIADO')
          LEFT OUTER JOIN MensajeInstitucion mi ON mi.Institucion = @Institucion AND mi.Mensaje = d.InstitucionMensaje

        INSERT ConciliacionD (
               ID,  Sucursal,  Seccion, Fecha, Concepto, Referencia, Cargo, Abono)
        SELECT @ID, @Sucursal, 2,       Fecha, Concepto, Referencia, Cargo, Abono
          FROM #ConciliacionD
        DROP TABLE #ConciliacionD
      END

      -- Actualizar Movimiento
      IF @Ok IN (NULL, 80030)
      BEGIN
        IF @EstatusNuevo = 'CANCELADO' SELECT @FechaCancelacion = @FechaRegistro ELSE SELECT @FechaCancelacion = NULL
        IF @EstatusNuevo = 'CONCLUIDO' SELECT @FechaConclusion  = @FechaEmision  ELSE IF @EstatusNuevo <> 'CANCELADO' SELECT @FechaConclusion  = NULL
        IF @CfgContX = 1 AND @CfgContXGenerar <> 'NO'
        BEGIN
	  IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @EstatusNuevo <> 'CANCELADO' SELECT @GenerarPoliza = 1 ELSE
          IF @Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @EstatusNuevo =  'CANCELADO' IF @GenerarPoliza = 1 SELECT @GenerarPoliza = 0 ELSE SELECT @GenerarPoliza = 1
        END  

        EXEC spValidarTareas @Empresa, @Modulo, @ID, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
        UPDATE Conciliacion
           SET FechaConclusion  = @FechaConclusion, 
               FechaCancelacion = @FechaCancelacion, 
               UltimoCambio     = CASE WHEN UltimoCambio IS NULL THEN @FechaRegistro ELSE UltimoCambio END,
	       Estatus          = @EstatusNuevo,
               Situacion 	= CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END,
               GenerarPoliza    = @GenerarPoliza
         WHERE ID = @ID 
        IF @@ERROR <> 0 SELECT @Ok = 1

        IF @Accion = 'AFECTAR'
        BEGIN
          SELECT @SaldoLibros = NULL, @SaldoConciliado = NULL
          SELECT @SaldoLibros = SUM(ISNULL(a.Cargo, 0.0)-ISNULL(a.Abono, 0.0))
            FROM Auxiliar a
           WHERE a.Empresa = @Empresa AND a.Rama = 'DIN' AND a.Cuenta = @CtaDinero AND a.Fecha <= @FechaA 

          SELECT @SaldoConciliado = SUM(ISNULL(a.Cargo, 0.0)-ISNULL(a.Abono, 0.0))
            FROM Auxiliar a
           WHERE a.Empresa = @Empresa AND a.Rama = 'DIN' AND a.Cuenta = @CtaDinero AND a.Fecha <= @FechaA AND a.Conciliado = 1

          UPDATE Conciliacion 
             SET SaldoLibros = @SaldoLibros,
                 SaldoConciliado = @SaldoConciliado
           WHERE ID = @ID
        END
      END
    END

    IF @Accion = 'AFECTAR'
    BEGIN
      DELETE MovImpuesto WHERE Modulo = @Modulo AND ModuloID = @ID
      IF EXISTS(SELECT * FROM #MovImpuesto)
        INSERT MovImpuesto (
               Modulo,  ModuloID, OrigenModulo, OrigenModuloID, OrigenConcepto, OrigenDeducible,	      OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1,      Importe2,      Importe3,      SubTotal,      ContUso, ContUso2, ContUso3, ClavePresupuestal, DescuentoGlobal, AplicaModulo, AplicaID)
        SELECT @Modulo, @ID,      OrigenModulo, OrigenModuloID, OrigenConcepto, ISNULL(OrigenDeducible, 100), OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, SUM(Importe1), SUM(Importe2), SUM(Importe3), SUM(SubTotal), ContUso, ContUso2, ContUso3, ClavePresupuestal, DescuentoGlobal, AplicaModulo, AplicaID
          FROM #MovImpuesto
         GROUP BY OrigenModulo, OrigenModuloID, OrigenConcepto, ISNULL(OrigenDeducible, 100), OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, ContUso, ContUso2, ContUso3, ClavePresupuestal, DescuentoGlobal, AplicaModulo, AplicaID
         ORDER BY OrigenModulo, OrigenModuloID, OrigenConcepto, ISNULL(OrigenDeducible, 100), OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, ContUso, ContUso2, ContUso3, ClavePresupuestal, DescuentoGlobal, AplicaModulo, AplicaID
      IF @PPTO = 1
      BEGIN
        DELETE MovPresupuesto WHERE Modulo = @Modulo AND ModuloID = @ID
        IF EXISTS(SELECT * FROM #MovPresupuesto)
          INSERT MovPresupuesto (
                 Modulo,  ModuloID, CuentaPresupuesto, Importe)
          SELECT @Modulo, @ID,      CuentaPresupuesto, SUM(Importe)
            FROM #MovPresupuesto
           GROUP BY CuentaPresupuesto
           ORDER BY CuentaPresupuesto
      END
    END

    -- Agregar a Estatus Log
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT

    -- Cancelar el Flujo
    IF @Accion = 'CANCELAR' AND @EstatusNuevo = 'CANCELADO' AND @Ok IS NULL
      EXEC spCancelarFlujo @Empresa, @Modulo, @ID, @Ok OUTPUT, @CancelarHijos = 1,@Usuario=@Usuario

    /*IF @Accion = 'CANCELAR' 
      SELECT @Saldo = @SaldoAnterior 
    ELSE SELECT @Saldo = @SaldoFinal

    IF @Ok IS NULL
    BEGIN
      IF ROUND(@Saldo, 2) <> (SELECT ROUND(SaldoConciliado, 2) FROM DineroSaldo WHERE Empresa = @Empresa AND Moneda = @MovMoneda AND CtaDinero = @CtaDinero)
        SELECT @Ok = 51025

      IF @MovTipo = 'CONC.BC'
        IF ROUND(@Saldo, 2) <> (SELECT ROUND(SaldoConciliado, 2) FROM CtaSaldo WHERE Empresa = @Empresa AND Moneda = @MovMoneda AND Cuenta = @Cuenta)
          SELECT @Ok = 51026
    END*/

--select * from conciliaciond where id = @id  /* 51095 */
--if @Ok IS NULL SELECT @Ok = 1  -- breakpoint

  IF @Conexion = 0
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      COMMIT TRANSACTION
    ELSE
      BEGIN
        DECLARE @PolizaDescuadrada TABLE (Cuenta varchar(20) NULL, SubCuenta varchar(50) NULL, Concepto varchar(50) NULL, Debe money NULL, Haber money NULL, SucursalContable int NULL)
        IF EXISTS(SELECT * FROM PolizaDescuadrada WHERE Modulo = @Modulo AND ID = @ID)
        INSERT @PolizaDescuadrada (Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable) SELECT Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable FROM PolizaDescuadrada WHERE Modulo = @Modulo AND ID = @ID 
/*        DECLARE @PolizaDescuadradaSesion TABLE (Modulo varchar(5) NULL, ID int NULL, RID int NULL, Cuenta varchar(20) NULL, SubCuenta varchar(50) NULL, Concepto varchar(50) NULL, Debe money NULL, Haber money NULL, SucursalContable int NULL)
        INSERT @PolizaDescuadradaSesion (Modulo, ID, RID, Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable) SELECT Modulo, ID, RID, Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable FROM PolizaDescuadrada */
        ROLLBACK TRANSACTION
        DELETE PolizaDescuadrada WHERE Modulo = @Modulo AND ID = @ID
        INSERT PolizaDescuadrada (Modulo, ID, Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable) SELECT @Modulo, @ID, Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable FROM @PolizaDescuadrada

        /*TRUNCATE TABLE PolizaDescuadradaSesion
        INSERT PolizaDescuadradaSesion (Modulo, ID, RID, Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable) SELECT Modulo, ID, RID, Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable FROM @PolizaDescuadradaSesion*/
      END
   
  RETURN
END
GO

/**************** spConciliacion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spConciliacion') and type = 'P') drop procedure dbo.spConciliacion
GO
CREATE PROCEDURE spConciliacion
                   @ID                  	int,
    		   @Modulo	      		char(5),
		   @Accion			char(20),
		   @Base			char(20),
		   @FechaRegistro		datetime,
		   @GenerarMov			char(20),
		   @Usuario			char(10),
    		   @Conexion			bit,
		   @SincroFinal			bit,
    		   @Mov	      			char(20)	OUTPUT,
    		   @MovID            		varchar(20)	OUTPUT,
		   @IDGenerar			int		OUTPUT,

		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Generar		bit,
    @GenerarAfectado	bit,
    @Sucursal		int,
    @SucursalDestino	int,
    @SucursalOrigen	int,
    @EnLinea		bit,
    @PuedeEditar	bit,
    @Empresa	      	char(5),
    @MovTipo   		char(20),
    @MovMoneda		char(10),
    @MovTipoCambio	float,
    @FechaEmision     	datetime,
    @FechaAfectacion	datetime,
    @FechaConclusion	datetime,
    @Proyecto	      	varchar(50),
    @MovUsuario	      	char(10),
    @Autorizacion     	char(10),
    @DocFuente	      	int,
    @Concepto    	varchar(50),
    @Referencia 	varchar(50),
    @Observaciones    	varchar(255),
    @Estatus          	char(15),
    @EstatusNuevo	char(15),
    @Ejercicio	      	int,
    @Periodo	      	int,
    @CtaDinero		varchar(10),
    @Institucion	varchar(20),
    @Cuenta		varchar(20), 
    @FechaD		datetime,
    @FechaA		datetime,
    /*@SaldoAnterior	money,
    @Cargos		money,
    @Abonos		money,
    @SaldoFinal		money,*/
    @GenerarMovID	varchar(20),
    @GenerarPoliza	bit,
    @CfgTolerancia	int,
    @CfgRepetirFecha	bit,
    @CfgTraslaparFecha	bit,
    @CfgContX		bit,
    @CfgContXGenerar	char(20)/*,
    @Verificar		bit*/

  -- Inicializar Variables
  SELECT @Generar	   = 0,
	 @GenerarAfectado  = 0,
         @CfgContX         = 0,
         @CfgContXGenerar  = 'NO'/*,
	 @Verificar        = 1*/

  IF @Accion = 'CANCELAR' SELECT @EstatusNuevo = 'CANCELADO' ELSE SELECT @EstatusNuevo = 'CONCLUIDO'

  -- Leer Datos Generales del Movimiento
  SELECT @Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, @Empresa = Empresa, @MovID = MovID, @Mov = Mov, @FechaEmision = FechaEmision, @Proyecto = NULLIF(RTRIM(Proyecto), ''),
         @MovUsuario = Usuario, @Autorizacion = Autorizacion, 
         @MovMoneda = Moneda, @MovTipoCambio = TipoCambio,
         @DocFuente = DocFuente, @Observaciones = Observaciones, @Estatus = UPPER(Estatus), 
         @GenerarPoliza = GenerarPoliza, @FechaConclusion = FechaConclusion,
         @Concepto = Concepto, @Referencia = Referencia,
    	 @CtaDinero = CtaDinero, @FechaD = FechaD, @FechaA = FechaA/*, @SaldoAnterior = ISNULL(SaldoAnterior, 0.0), @Cargos = ISNULL(Cargos, 0.0), @Abonos = ISNULL(Abonos, 0.0)*/
    FROM Conciliacion
   WHERE ID = @ID
  IF @@ERROR <> 0 SELECT @Ok = 1
  /*SELECT @SaldoFinal = @SaldoAnterior - @Cargos + @Abonos*/

  SELECT @Cuenta = NULLIF(RTRIM(Cuenta), ''), @Institucion = Institucion FROM CtaDinero WHERE CtaDinero = @CtaDinero
  SELECT @CfgTolerancia   = ISNULL(ConcToleranciaDec, 2),
         @CfgRepetirFecha = ISNULL(ConcRepetirFecha, 0),
         @CfgTraslaparFecha = ISNULL(ConcTraslaparFecha, 0)
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  IF NULLIF(RTRIM(@Usuario), '') IS NULL SELECT @Usuario = @MovUsuario
  -- Leer MovTipo, Periodo y Ejercicio	
  -- IF @Accion IN ('AFECTAR', 'GENERAR') SELECT @FechaAfectacion = @FechaEmision ELSE SELECT @FechaAfectacion = @FechaRegistro
  EXEC spFechaAfectacion @Empresa, @Modulo, @ID, @Accion, @FechaEmision OUTPUT, @FechaRegistro, @FechaAfectacion OUTPUT
  EXEC spExtraerFecha @FechaAfectacion OUTPUT
  EXEC spMovTipo @Modulo, @Mov, @FechaAfectacion, @Empresa, NULL, NULL, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT
  EXEC spMovOk @SincroFinal, @ID, @Estatus, @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @FechaAfectacion, @FechaRegistro, @Ejercicio, @Periodo, @Proyecto, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
  BEGIN
    IF @SucursalDestino IS NOT NULL AND @SucursalDestino <> @Sucursal AND @Accion = 'AFECTAR'
    BEGIN
      EXEC spSucursalEnLinea @SucursalDestino, @EnLinea OUTPUT
      IF @EnLinea = 1 
      BEGIN
        EXEC spMovConsecutivo @Sucursal, @SucursalOrigen, @SucursalDestino, @Empresa, @Usuario, @Modulo, @Ejercicio, @Periodo, @ID, @Mov, NULL, @Estatus, @Concepto, @Accion, @Conexion, @SincroFinal, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        EXEC spAsignarSucursalEstatus @ID, @Modulo, @SucursalDestino, NULL
        SELECT @Sucursal = @SucursalDestino
      END ELSE
        SELECT @Accion = 'SINCRO'
    END

    IF @Estatus = 'SINCRO' AND @Accion = 'CANCELAR'
    BEGIN
      EXEC spPuedeEditarMovMatrizSucursal @Sucursal, @SucursalOrigen, @ID, @Modulo, @Empresa, @Usuario, @Mov, @Estatus, 1, @PuedeEditar OUTPUT
      IF @PuedeEditar = 0 
        SELECT @Ok = 60300 
      ELSE BEGIN
        SELECT @Estatus = 'SINAFECTAR'/*, @Verificar = 0*/
        EXEC spAsignarSucursalEstatus @ID, @Modulo, @Sucursal, @Estatus
      END
    END
  END

  IF (@Accion <> 'CANCELAR' AND @Estatus IN ('SINAFECTAR', 'PENDIENTE')) OR 
     (@Accion = 'CANCELAR'  AND @Estatus IN ('CONCLUIDO', 'PENDIENTE'))
  BEGIN
    SELECT @CfgContX = ContX
      FROM EmpresaGral
     WHERE Empresa = @Empresa
    IF @@ERROR <> 0 SELECT @Ok = 1

    IF @CfgContX = 1 
      SELECT @CfgContXGenerar = ContXGenerar
        FROM EmpresaCfgModulo
       WHERE Empresa = @Empresa
         AND Modulo  = @Modulo
    IF @@ERROR <> 0 SELECT @Ok = 1
  
    -- Verificar antes de Afectar
    IF (@Conexion = 0 OR @Accion = 'CANCELAR') AND @Accion NOT IN ('GENERAR', 'CONSECUTIVO'/*, 'SINCRO'*/) AND @Ok IS NULL
    BEGIN
      EXEC spConciliacionVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @Estatus, @EstatusNuevo, 
                                   @CtaDinero, @Institucion, @Cuenta, @FechaD, @FechaA, /*@SaldoAnterior, @Cargos, @Abonos, @SaldoFinal,*/
            	                   @Conexion, @SincroFinal, @Sucursal, @CfgTolerancia, @CfgRepetirFecha, @CfgTraslaparFecha, @Ok OUTPUT, @OkRef OUTPUT

      -- Quitar los mensajes cuando la afectarcion es normal 
      IF @Ok BETWEEN 80000 AND 89999 AND @Accion IN ('AFECTAR', 'CANCELAR') SELECT @Ok = NULL ELSE

      -- Si Verifico y todo estubo bien
      IF @Accion = 'VERIFICAR' AND @Ok IS NULL
      BEGIN
        SELECT @Ok = 80000
        EXEC xpOk_80000 @Empresa, @Usuario, @Accion, @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
      END
    END
   
    IF @Accion IN ('AFECTAR', 'GENERAR', 'CANCELAR','CONSECUTIVO','SINCRO') AND @Ok IS NULL
      EXEC spConciliacionAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaAfectacion, @FechaConclusion,
			       @Proyecto, @Usuario, @Autorizacion, @DocFuente, @Observaciones, @Concepto, @Referencia, 
                               @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario,
			       @CtaDinero, @Institucion, @Cuenta, @FechaD, @FechaA, /*@SaldoAnterior, @Cargos, @Abonos, @SaldoFinal,*/
		               @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @CfgTolerancia, @CfgRepetirFecha, @CfgTraslaparFecha, @CfgContX, @CfgContXGenerar, @GenerarPoliza,
                               @Generar, @GenerarMov, @GenerarAfectado, @IDGenerar OUTPUT, @GenerarMovID OUTPUT,
                               @Ok OUTPUT, @OkRef OUTPUT

  END ELSE 
  BEGIN
    IF @Estatus = 'SINAFECTAR' AND @Accion = 'CANCELAR' EXEC spMovCancelarSinAfectar @Modulo, @ID, @Ok OUTPUT ELSE
    IF @Estatus = 'AFECTANDO' SELECT @Ok = 80020 ELSE
    IF @Estatus = 'CONCLUIDO' SELECT @Ok = 80010
    ELSE SELECT @Ok = 60040, @OkRef = 'Estatus: '+@Estatus
  END

  IF @Accion = 'SINCRO' AND @Ok = 80060 
  BEGIN
    SELECT @Ok = NULL, @OkRef = NULL
    EXEC spSucursalEnLinea @SucursalDestino, @EnLinea OUTPUT
    IF @EnLinea = 1 EXEC spSincroFinalModulo @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
  END

  -- Si hay Mensaje pero no tiene referencia
  IF @Ok IS NOT NULL AND @OkRef IS NULL 

    -- Si se Genero un Movimiento, Desplegarlo
    IF @Ok = 80030
      SELECT @OkRef = 'Movimiento: '+RTRIM(@GenerarMov)+' '+LTRIM(Convert(Char, @GenerarMovID))

    -- Si hubo un error poner como referencia el Movimiento
    ELSE
      SELECT @OkRef = 'Movimiento: '+RTRIM(@Mov)+' '+LTRIM(Convert(Char, @MovID)), @IDGenerar = NULL

  RETURN
END
GO

/****************** spConciliacionBancomer *******************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spConciliacionBancomer' and Type = 'P')
	DROP PROCEDURE spConciliacionBancomer
GO

CREATE PROCEDURE spConciliacionBancomer
	@Institucion	varchar(20),
	@NumeroCta	varchar(100),
	@Estacion	Int		
--//WITH ENCRYPTION
AS
BEGIN
	DECLARE	@RegClave	varchar(255),
		@TipoMov	varchar(2),
		@Fecha		datetime,
		@Concepto	varchar(50),
		@Referencia 	varchar(50),
		@Cargo		money,
		@Abono		money,
		@Observaciones	varchar(100)

	DECLARE crListaSt CURSOR FOR

	/* AG 21/05/2007 se corrigio este select agregando el convert a @NumeroCta */
  SELECT RTRIM(LTRIM(Clave)) FROM ListaSt WHERE Estacion = @Estacion AND CONVERT(varchar(20), CONVERT(bigint,Substring(Clave, 9, 10))) = CONVERT(varchar(20), CONVERT(bigint, @NumeroCta)) 
	OPEN crListaSt
	FETCH NEXT FROM crListaSt INTO @RegClave
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT 	@TipoMov	= SUBSTRING(@RegClave, 65, 1),
			@Fecha 		= CONVERT(smalldatetime, SUBSTRING(@RegClave, 131, 10),102),
			@Concepto 	= SUBSTRING(@RegClave, 35, 30),
			@Referencia	= SUBSTRING(@RegClave, 29, 6),
			@Observaciones	= SUBSTRING(@RegClave, 94, 30)

		IF @TipoMov = '1'
			SELECT @Cargo = CONVERT(money,CONVERT(decimal(10,2), SUBSTRING(@RegClave, 66, 16))), @Abono = 0.0
		ELSE
			SELECT @Abono = CONVERT(money,CONVERT(decimal(10,2), SUBSTRING(@RegClave, 66, 16))), @Cargo = 0.0

		INSERT INTO #ConciliacionBanco Values(@Fecha, @Concepto, @Referencia, @Cargo, @Abono, @Observaciones)
		FETCH NEXT FROM crListaSt INTO @RegClave
	END
	CLOSE crListaSt
	DEALLOCATE crListaSt
END
GO


/****************** spConciliacionSantander *******************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spConciliacionSantander' and Type = 'P')
	DROP PROCEDURE spConciliacionSantander
GO

CREATE PROCEDURE spConciliacionSantander
	@Institucion	varchar(20),
	@NumeroCta	varchar(100),
	@Estacion	Int			
--//WITH ENCRYPTION
AS
BEGIN
	DECLARE	@RegClave	varchar(255),
		@TipoMov	varchar(2),
		@Fecha		datetime,
		@Concepto	varchar(50),
		@Referencia 	varchar(50),
		@Cargo		money,
		@Abono		money,
		@Observaciones	varchar(100)

	DECLARE crListaSt CURSOR FOR
	SELECT RTRIM(LTRIM(Clave)) FROM ListaSt WHERE Estacion = @Estacion AND RTRIM(Substring(Clave, 1, 16)) = @NumeroCta
	OPEN crListaSt
	FETCH NEXT FROM crListaSt INTO @RegClave
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT 	@TipoMov	= SUBSTRING(@RegClave, 73, 1),
			@Fecha 		= CONVERT(smalldatetime, SUBSTRING(@RegClave, 21, 4) + '-' + SUBSTRING(@RegClave, 19, 2) + '-' + SUBSTRING(@RegClave, 17, 2), 102),
			@Concepto 	= SUBSTRING(@RegClave, 33, 40),
			@Referencia	= SUBSTRING(@RegClave, 102, 8),
			@Observaciones	= SUBSTRING(@RegClave, 110, 40)

                IF dbo.fnEsNumerico(@Referencia) = 1 SELECT @Referencia = CONVERT(varchar, CONVERT(int, @Referencia))

		IF @TipoMov = '-'
			SELECT @Cargo = CONVERT(money,CONVERT(decimal(12,2), SUBSTRING(@RegClave, 74, 14)))/100, @Abono = 0.0
		ELSE
			SELECT @Abono = CONVERT(money,CONVERT(decimal(12,2), SUBSTRING(@RegClave, 74, 14)))/100, @Cargo = 0.0

		INSERT INTO #ConciliacionBanco Values(@Fecha, @Concepto, @Referencia, @Cargo, @Abono, @Observaciones)
		FETCH NEXT FROM crListaSt INTO @RegClave
	END
	CLOSE crListaSt
	DEALLOCATE crListaSt
END
GO


/****************** spConciliacionHSBC *******************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spConciliacionHSBC' and Type = 'P')
	DROP PROCEDURE spConciliacionHSBC
GO

CREATE PROCEDURE spConciliacionHSBC
	@Institucion			varchar(20),
	@NumeroCta			varchar(100),
	@Estacion			Int
--//WITH ENCRYPTION
AS
BEGIN
	DECLARE	@RegClave	varchar(255),
		@TipoMov	varchar(2),
		@Fecha		datetime,
		@Concepto	varchar(50),
		@Referencia 	varchar(50),
		@Cargo		money,
		@Abono		money,
		@Observaciones	varchar(100)

	DECLARE crListaSt CURSOR FOR
	SELECT RTRIM(LTRIM(Clave)) FROM ListaSt WHERE Estacion = @Estacion AND RTRIM(Substring(Clave, 1, 10)) = @NumeroCta
	OPEN crListaSt
	FETCH NEXT FROM crListaSt INTO @RegClave
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT 	@TipoMov	= SUBSTRING(@RegClave, 43, 2),
			@Fecha 		= CONVERT(smalldatetime, SUBSTRING(@RegClave, 11, 4) + '-' + SUBSTRING(@RegClave, 15, 2) + '-' + SUBSTRING(@RegClave, 17, 2), 102),
			@Observaciones	= RTRIM(LTRIM(SUBSTRING(@RegClave, 66, 40)))
		SELECT  @Referencia	= CASE 
					  WHEN CONVERT(bigint, SUBSTRING(@RegClave, 50, 16)) > 0 THEN CONVERT(varchar, CONVERT(bigint, SUBSTRING(@RegClave, 50, 16)))
					  ELSE NULL END
		SELECT 	@Concepto = Descripcion FROM MensajeInstitucion WHERE Mensaje = CONVERT(varchar,CONVERT(int,SUBSTRING(@RegClave, 45, 5))) and institucion = @Institucion
		IF @TipoMov = 'DR'
			SELECT @Cargo = CONVERT(money,CONVERT(decimal(11,2), SUBSTRING(@RegClave, 30, 13)))/100, @Abono = 0.0
		ELSE
			SELECT @Abono = CONVERT(money,CONVERT(decimal(11,2), SUBSTRING(@RegClave, 30, 13)))/100, @Cargo = 0.0

		INSERT INTO #ConciliacionBanco Values(@Fecha, @Concepto, @Referencia, @Cargo, @Abono, @Observaciones)
		FETCH NEXT FROM crListaSt INTO @RegClave
	END
	CLOSE crListaSt
	DEALLOCATE crListaSt
END
GO

/****************** spConciliacionBanregio *******************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spConciliacionBanregio' and Type = 'P')
	DROP PROCEDURE spConciliacionBanregio
GO

CREATE PROCEDURE spConciliacionBanregio
	@Institucion	varchar(20),
	@NumeroCta	varchar(100),
	@Estacion	Int
--//WITH ENCRYPTION
AS
BEGIN
	DECLARE	@RegClave	varchar(255),
		@TipoMov	varchar(2),
		@Fecha		datetime,
		@Concepto	varchar(50),
		@Referencia 	varchar(50),
		@Cargo		money,
		@Abono		money,
		@Observaciones	varchar(100)

	DECLARE crListaSt CURSOR FOR
	SELECT RTRIM(LTRIM(Clave)) FROM ListaSt WHERE Estacion = @Estacion AND RTRIM(Substring(Clave, 3, 10)) = @NumeroCta
	OPEN crListaSt
	FETCH NEXT FROM crListaSt INTO @RegClave
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT 	@TipoMov	= SUBSTRING(@RegClave, 15, 1),
			@Fecha 		= CONVERT(smalldatetime, SUBSTRING(@RegClave, 69, 4) + '-' + SUBSTRING(@RegClave, 73, 2) + '-' + SUBSTRING(@RegClave, 75, 2), 102),
			@Concepto 	= SUBSTRING(@RegClave, 16, 3),
			@Referencia	= SUBSTRING(@RegClave, 20, 35),
			@Observaciones	= ''

		IF @TipoMov = 'C'
			SELECT @Cargo = CONVERT(money,CONVERT(decimal(11,2), SUBSTRING(@RegClave, 55, 14))), @Abono = 0.0
		ELSE
			SELECT @Abono = CONVERT(money,CONVERT(decimal(11,2), SUBSTRING(@RegClave, 55, 14))), @Cargo = 0.0

		INSERT INTO #ConciliacionBanco Values(@Fecha, @Concepto, @Referencia, @Cargo, @Abono, @Observaciones)
		FETCH NEXT FROM crListaSt INTO @RegClave
	END
	CLOSE crListaSt
	DEALLOCATE crListaSt
END
GO


/****************** spConciliacionBanorte *******************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spConciliacionBanorte' and Type = 'P')
	DROP PROCEDURE spConciliacionBanorte
GO

CREATE PROCEDURE spConciliacionBanorte
	@Institucion	varchar(20),
	@NumeroCta	varchar(100),
	@Estacion	Int
--//WITH ENCRYPTION
AS
BEGIN
	DECLARE	@RegClave	varchar(255),
		@TipoMov	varchar(2),
		@Fecha		datetime,
		@Concepto	varchar(50),
		@Referencia 	varchar(50),
		@Cargo		money,
		@Abono		money,
		@Observaciones	varchar(100)

	IF NOT EXISTS(SELECT RTRIM(LTRIM(Clave)) FROM ListaSt WHERE Estacion = @Estacion AND 
				 RTRIM(Substring(Clave, 1, 2)) = '11' AND 
				 CONVERT(varchar(10),CONVERT(bigint,Substring(Clave, 26, 10))) = @NumeroCta)
		RETURN		

	DECLARE crListaSt CURSOR FOR
	SELECT RTRIM(LTRIM(Clave)) FROM ListaSt WHERE Estacion = @Estacion AND RTRIM(Substring(Clave, 1, 2)) IN ('22', '23')
	OPEN crListaSt
	FETCH NEXT FROM crListaSt INTO @RegClave
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF RTRIM(Substring(@RegClave, 1, 2)) = '22'
			BEGIN
				SELECT 	@TipoMov		= SUBSTRING(@RegClave, 28, 1),
						@Fecha 		= CONVERT(smalldatetime, '20' + SUBSTRING(@RegClave, 17, 2) + '-' + SUBSTRING(@RegClave, 19, 2) + '-' + SUBSTRING(@RegClave, 21, 2), 102),
						@Concepto 	= SUBSTRING(@RegClave, 23, 5),
						@Referencia	= SUBSTRING(@RegClave, 53, 28)
				IF @TipoMov = '1'
					SELECT @Cargo = CONVERT(money,CONVERT(decimal(12,2), SUBSTRING(@RegClave, 29, 14)))/100, @Abono = 0.0
				ELSE
					SELECT @Abono = CONVERT(money,CONVERT(decimal(12,2), SUBSTRING(@RegClave, 29, 14)))/100, @Cargo = 0.0
				FETCH NEXT FROM crListaSt INTO @RegClave
			END
		IF RTRIM(Substring(@RegClave, 1, 2)) = '23'
			SELECT 	@Observaciones = LTRIM(RTRIM(SUBSTRING(@RegClave, 5, 90)))

		INSERT INTO #ConciliacionBanco Values(@Fecha, @Concepto, @Referencia, @Cargo, @Abono, @Observaciones)
		FETCH NEXT FROM crListaSt INTO @RegClave
	END
	CLOSE crListaSt
	DEALLOCATE crListaSt
END
GO


/****************** spConciliacionBanorte2 *******************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spConciliacionBanorte2' and Type = 'P')
	DROP PROCEDURE spConciliacionBanorte2
GO

CREATE PROCEDURE spConciliacionBanorte2
	@Institucion	varchar(20),
	@NumeroCta	varchar(100),
	@Estacion	Int
--//WITH ENCRYPTION
AS
BEGIN
	DECLARE	@RegClave	    varchar(255),
	        @RegClave2	    varchar(255),
    		@TipoMov	    varchar(2),
	    	@Fecha		    datetime,
		    @Concepto	    varchar(50),
		    @Referencia     varchar(50),
		    @Cargo		    money,
		    @Abono		    money,
		    @Observaciones	varchar(100),
		    @Tamaño         int,
		    @Contador       int
		    
    SELECT  @Tamaño = 0,
            @Contador = 0		    
            
	DECLARE crListaSt CURSOR FOR
	SELECT RTRIM(LTRIM(Clave)) FROM ListaSt WHERE Estacion = @Estacion 
	OPEN crListaSt
	FETCH NEXT FROM crListaSt INTO @RegClave
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @RegClave2=@RegClave	
		SELECT  @Tamaño = 0,
                @Contador = 0		
	    SELECT  @Tamaño = LEN (@RegClave2)
	    
	    SELECT  @Fecha = SUBSTRING(@RegClave2, 12, 10),
	            @Referencia	= SUBSTRING(@RegClave2, 23, 10)	    
	    WHILE @Contador < 3
	    BEGIN
	    	SELECT @RegClave2 = RIGHT(@RegClave2, @Tamaño-(CHARINDEX('|', @RegClave2)))
	    	SELECT @Contador=@Contador+1
	    	SELECT @Tamaño = LEN (@RegClave2)	    	
	    END
        SELECT @Concepto=SUBSTRING(@RegClave2, 0, CHARINDEX('|', @RegClave2))
        SELECT @Contador=0
        	    
   	    WHILE @Contador < 3
	    BEGIN
	    	SELECT @RegClave2 = RIGHT(@RegClave2, @Tamaño-(CHARINDEX('|', @RegClave2)))
	    	SELECT @Contador=@Contador+1
	    	SELECT @Tamaño = LEN (@RegClave2)	    	
	    END	    
	    SELECT @Cargo= CONVERT (MONEY, SUBSTRING(@RegClave2, 0, CHARINDEX('|', @RegClave2)) )
        SELECT @Contador=0
         
   	    WHILE @Contador < 1
	    BEGIN
	    	SELECT @RegClave2 = RIGHT(@RegClave2, @Tamaño-(CHARINDEX('|', @RegClave2)))
	    	SELECT @Contador=@Contador+1
	    	SELECT @Tamaño = LEN (@RegClave2)	    	
	    END	    
	    SELECT @Abono= CONVERT (MONEY, SUBSTRING(@RegClave2, 0, CHARINDEX('|', @RegClave2)) )
	    SELECT @Contador=0
	    
   	    WHILE @Contador < 2
	    BEGIN
	    	SELECT @RegClave2 = RIGHT(@RegClave2, @Tamaño-(CHARINDEX('|', @RegClave2)))
	    	SELECT @Contador=@Contador+1
	    	SELECT @Tamaño = LEN (@RegClave2)	    	
	    END	    
	    SELECT @Observaciones= SUBSTRING(@RegClave2, 0, @Tamaño+1)   
		INSERT INTO #ConciliacionBanco Values(@Fecha, @Concepto, @Referencia, @Cargo, @Abono, @Observaciones)
		
		FETCH NEXT FROM crListaSt INTO @RegClave
	END
	CLOSE crListaSt
	DEALLOCATE crListaSt
END
GO

--spConciliacionImportar 100, 77
/****************** spConciliacionBanamex *******************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spConciliacionBanamex' and Type = 'P')
	DROP PROCEDURE spConciliacionBanamex
GO

CREATE PROCEDURE spConciliacionBanamex
	@Institucion	varchar(20),
	@NumeroCta	varchar(100),
	@Estacion	Int
--//WITH ENCRYPTION
AS
BEGIN
	DECLARE	@RegClave	varchar(255),
		@TipoMov	varchar(2),
		@Fecha		datetime,
		@Concepto	varchar(50),
		@Referencia 	varchar(50),
		@Cargo		money,
		@Abono		money,
		@Observaciones	varchar(100),
		@CtaRegistro varchar(20) 

    SET @CtaRegistro=NULL
	DECLARE crListaSt CURSOR FOR
	SELECT RTRIM(LTRIM(Clave)) FROM ListaSt WHERE Estacion = @Estacion
	OPEN crListaSt
	FETCH NEXT FROM crListaSt INTO @RegClave
	WHILE @@FETCH_STATUS = 0
	BEGIN
		--Saca primero la fecha de las operaciones de la seccion 1
		IF Len(@RegClave) = 6
                        SELECT  @Fecha  = CONVERT(smalldatetime, SUBSTRING(@RegClave, 1, 2) + '-' + SUBSTRING(@RegClave, 3, 2) + '-'+ '20' + + SUBSTRING(@RegClave, 5, 2), 103)

		--Si es la seccion 4, saca el número de la cuenta y la valida 
		--Antes
		/*IF Len(@RegClave) = 20 AND CONVERT(varchar(10),CONVERT(bigint,Substring(@RegClave, 5, 16))) <> @NumeroCta
			BEGIN
				CLOSE crListaSt
				DEALLOCATE crListaSt
				RETURN
			END*/
		IF Len(@RegClave) = 61 
			BEGIN
			    SET @CtaRegistro=CONVERT(bigint,Substring(@RegClave, 46, 16))
            END
		--Si es la seccion 8 saca los datos de la operacion (detalle)
		IF Len(@RegClave) = 56 AND @CtaRegistro=@NumeroCta
			BEGIN
				SELECT 	@TipoMov	= SUBSTRING(@RegClave, 1, 1),
					@Observaciones 	= SUBSTRING(@RegClave, 18, 20)
				SELECT  @Referencia	= CASE 
					  WHEN CONVERT(bigint, SUBSTRING(@RegClave, 8, 10)) > 0 THEN CONVERT(varchar, CONVERT(bigint, SUBSTRING(@RegClave, 8, 10)))
					  ELSE NULL END
                                SELECT  @Concepto = Descripcion FROM MensajeInstitucion WHERE RTRIM(Mensaje) = SUBSTRING(@RegClave, 2, 2)+SUBSTRING(@RegClave, 55, 2) and Institucion = @Institucion

				IF @TipoMov = 'C'
					SELECT @Cargo = CONVERT(money, CONVERT(decimal(12,2), SUBSTRING(@RegClave, 38, 17)))/100, @Abono = 0.0
				ELSE
					SELECT @Abono = CONVERT(money, CONVERT(decimal(12,2), SUBSTRING(@RegClave, 38, 17)))/100, @Cargo = 0.0

				INSERT INTO #ConciliacionBanco Values(@Fecha, @Concepto, @Referencia, @Cargo, @Abono, @Observaciones)
			END
		FETCH NEXT FROM crListaSt INTO @RegClave
	END
	CLOSE crListaSt
	DEALLOCATE crListaSt
END
GO

/****************** spConciliacionHSBC2 *******************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spConciliacionHSBC2' and Type = 'P')
	DROP PROCEDURE spConciliacionHSBC2
GO

CREATE PROCEDURE spConciliacionHSBC2
	@Institucion			varchar(20),
	@NumeroCta			varchar(100),
	@Estacion			Int
--//WITH ENCRYPTION
AS
BEGIN
	DECLARE	@RegClave	varchar(255),	
			@RegClave2	    varchar(255),
			@Concepto	    varchar(50),
			@Observaciones	varchar(100),
			@Tamaño         int,
			@Contador       int,
			@Cuenta			varchar(100),
			@Fecha		    datetime,
			@Hora		    varchar(50),
			@Sucursal	    int,
			@Cargo		    money,
			@Abono		    money,
			@Clave			varchar(10),
			@Cheque			int,
			@Referencia	    varchar(100),
			@Operador	    int,
			@Descripcion    varchar(100),
			@Saldo		    money,
			@Signo		    varchar(100),
			@Contador1      int		    

    SELECT  @Tamaño = 0,
            @Contador = 0		    
		
--if @Institucion is null set @Institucion = 'HSBC'
--if @NumeroCta is null set @NumeroCta = '4030764344'

	DECLARE crListaSt CURSOR FOR
	SELECT RTRIM(LTRIM(Clave)) FROM ListaSt WHERE Estacion = @Estacion AND dbo.fnQuitarCerosIzq((SUBSTRING(Clave, 0, CHARINDEX(CHAR(9), Clave)))) = @NumeroCta
	OPEN crListaSt
	FETCH NEXT FROM crListaSt INTO @RegClave
	WHILE @@FETCH_STATUS = 0
	BEGIN

      SELECT @Contador1 = CHARINDEX(CHAR(9), @RegClave) 
		
	  SELECT @RegClave2 = @RegClave	
	  SELECT @Tamaño = 0,
             @Contador = 0
	    
	  SELECT @Tamaño = LEN (@RegClave2)

      IF @Contador = 0 AND @Contador < @Contador1
      BEGIN
        SELECT @Cuenta = NULL
	    SELECT @Cuenta = SUBSTRING(@RegClave2, 0, CHARINDEX(CHAR(9), @RegClave2))
	    SELECT @RegClave2 = RIGHT(@RegClave2, @Tamaño-(CHARINDEX(CHAR(9), @RegClave2)))
	    SELECT @Contador = @Contador+1
	    SELECT @Tamaño = LEN (@RegClave2)
      END

      IF @Contador = 1 AND @Contador <= @Contador1
      BEGIN
        SELECT @Fecha = NULL
        SELECT @Fecha = CONVERT(smalldatetime, SUBSTRING(@RegClave2, 7, 4) + '-' + SUBSTRING(@RegClave2, 4, 2) + '-' + SUBSTRING(@RegClave2, 1, 2), 102)     
	    SELECT @RegClave2 = RIGHT(@RegClave2, @Tamaño-(CHARINDEX(CHAR(9), @RegClave2)))
	    SELECT @Contador = @Contador+1
	    SELECT @Tamaño = LEN (@RegClave2)
      END

      IF @Contador = 2 AND @Contador <= @Contador1
      BEGIN
        SELECT @Hora = NULL
	    SELECT @Hora = SUBSTRING(@RegClave2, 0, CHARINDEX(CHAR(9), @RegClave2))
	    SELECT @RegClave2 = RIGHT(@RegClave2, @Tamaño-(CHARINDEX(CHAR(9), @RegClave2)))
	    SELECT @Contador = @Contador+1
	    SELECT @Tamaño = LEN (@RegClave2)
      END

      IF @Contador = 3 AND @Contador <= @Contador1
      BEGIN
        SELECT @Sucursal = NULL
	    SELECT @Sucursal = CONVERT(int,SUBSTRING(@RegClave2, 0, CHARINDEX(CHAR(9), @RegClave2)))
	    SELECT @RegClave2 = RIGHT(@RegClave2, @Tamaño-(CHARINDEX(CHAR(9), @RegClave2)))
	    SELECT @Contador = @Contador+1
	    SELECT @Tamaño = LEN (@RegClave2)
      END

      IF @Contador = 4 AND @Contador <= @Contador1
      BEGIN
        SELECT @Cargo = NULL
	    SELECT @Cargo = CONVERT(money,CONVERT(decimal(11,2),SUBSTRING(@RegClave2, 0, CHARINDEX(CHAR(9), @RegClave2))))
	    SELECT @RegClave2 = RIGHT(@RegClave2, @Tamaño-(CHARINDEX(CHAR(9), @RegClave2)))
	    SELECT @Contador = @Contador+1
	    SELECT @Tamaño = LEN (@RegClave2)
      END

      IF @Contador = 5 AND @Contador <= @Contador1
      BEGIN
        SELECT @Abono = NULL
	    SELECT @Abono = CONVERT(money,CONVERT(decimal(11,2),SUBSTRING(@RegClave2, 0, CHARINDEX(CHAR(9), @RegClave2))))
	    SELECT @RegClave2 = RIGHT(@RegClave2, @Tamaño-(CHARINDEX(CHAR(9), @RegClave2)))
	    SELECT @Contador = @Contador+1
	    SELECT @Tamaño = LEN (@RegClave2)
      END

      IF @Contador = 6 AND @Contador <= @Contador1
      BEGIN
        SELECT @Clave = NULL
	    SELECT @Clave = SUBSTRING(@RegClave2, 0, CHARINDEX(CHAR(9), @RegClave2))
	    SELECT @RegClave2 = RIGHT(@RegClave2, @Tamaño-(CHARINDEX(CHAR(9), @RegClave2)))
	    SELECT @Contador = @Contador+1
	    SELECT @Tamaño = LEN (@RegClave2)
	    SELECT @Concepto = Descripcion FROM MensajeInstitucion WHERE Mensaje = @Clave and institucion = @Institucion
      END

      IF @Contador = 7 AND @Contador <= @Contador1
      BEGIN
        SELECT @Cheque = NULL
	    SELECT @Cheque = CONVERT(int,SUBSTRING(@RegClave2, 0, CHARINDEX(CHAR(9), @RegClave2)))
	    SELECT @RegClave2 = RIGHT(@RegClave2, @Tamaño-(CHARINDEX(CHAR(9), @RegClave2)))
	    SELECT @Contador = @Contador+1
	    SELECT @Tamaño = LEN (@RegClave2)
      END

      IF @Contador = 8 AND @Contador <= @Contador1
      BEGIN
        SELECT @Referencia = NULL
	    SELECT @Referencia = SUBSTRING(SUBSTRING(@RegClave2, 0, CHARINDEX(CHAR(9), @RegClave2)), 1, 6)
	    SELECT @RegClave2 = RIGHT(@RegClave2, @Tamaño-(CHARINDEX(CHAR(9), @RegClave2)))
	    SELECT @Contador = @Contador+1
	    SELECT @Tamaño = LEN (@RegClave2)
      END

      SELECT @Contador = @Contador+1

/*
      IF @Contador = 9 AND @Contador <= @Contador1
      BEGIN
        SELECT @Operador = NULL
	    SELECT @Operador = CONVERT(int,SUBSTRING(@RegClave2, 0, CHARINDEX(CHAR(9), @RegClave2)))
	    SELECT @RegClave2 = RIGHT(@RegClave2, @Tamaño-(CHARINDEX(CHAR(9), @RegClave2)))
	    SELECT @Contador = @Contador+1
	    SELECT @Tamaño = LEN (@RegClave2)
      END
*/
      IF @Contador = 10 AND @Contador <= @Contador1
      BEGIN
        SELECT @Descripcion = NULL
	    SELECT @Descripcion = SUBSTRING(@RegClave2, 0, CHARINDEX(CHAR(9), @RegClave2))
	    SELECT @RegClave2 = RIGHT(@RegClave2, @Tamaño-(CHARINDEX(CHAR(9), @RegClave2)))
	    SELECT @Contador = @Contador+1
	    SELECT @Tamaño = LEN (@RegClave2)
	    SELECT @Observaciones = @Descripcion
      END

      IF @Contador = 11 AND @Contador <= @Contador1
      BEGIN
        SELECT @Saldo = NULL
	    SELECT @Saldo = CONVERT(money,CONVERT(decimal(11,2),SUBSTRING(@RegClave2, 0, CHARINDEX(CHAR(9), @RegClave2))))
	    SELECT @RegClave2 = RIGHT(@RegClave2, @Tamaño-(CHARINDEX(CHAR(9), @RegClave2)))
	    SELECT @Contador = @Contador+1
	    SELECT @Tamaño = LEN (@RegClave2)
        SELECT @Signo = @RegClave2      
      END

      IF @Signo = 'DR'
	    SELECT @Cargo = @Cargo, @Abono = 0.0
	  ELSE
	    SELECT @Abono = @Abono, @Cargo = 0.0

--select @Cuenta, @Fecha, @Hora, @Sucursal, @Cargo, @Abono, @Clave, @Concepto, @Cheque, @Referencia, @Operador, @Descripcion, @Saldo, @Signo
--select @Fecha, @Concepto, @Referencia, @Cargo, @Abono, @Observaciones
		INSERT INTO #ConciliacionBanco Values(@Fecha, @Concepto, @Referencia, @Cargo, @Abono, @Observaciones)
		FETCH NEXT FROM crListaSt INTO @RegClave
	END
	CLOSE crListaSt
	DEALLOCATE crListaSt
END
GO

--spConciliacionImportar 1, 1
--spConciliacionHSBC2 null,null,1

/****************** spConciliacionScotiabank *******************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spConciliacionScotiabank' and Type = 'P')
	DROP PROCEDURE spConciliacionScotiabank
GO

CREATE PROCEDURE spConciliacionScotiabank
	@Institucion			varchar(20),
	@NumeroCta			varchar(100),
	@Estacion			Int
--//WITH ENCRYPTION
AS
BEGIN
	DECLARE	@RegClave	varchar(255),	
			@Concepto	    varchar(50),
			@Observaciones	varchar(100),
			@Cuenta			varchar(100),
			@Fecha		    datetime,
			@Cargo		    money,
			@Abono		    money,
			@Clave			varchar(10),
			@Referencia	    varchar(100),
			@Descripcion    varchar(100),			
			@Tipo			varchar(20)


	DECLARE crListaSt CURSOR FOR
	SELECT RTRIM(LTRIM(Clave)) FROM ListaSt WHERE Estacion = @Estacion AND SUBSTRING(Clave, 9, 10) = @NumeroCta
	OPEN crListaSt
	FETCH NEXT FROM crListaSt INTO @RegClave
	WHILE @@FETCH_STATUS = 0 AND SUBSTRING(@RegClave, 1, 1)=1
	BEGIN
	  SELECT @Cuenta = SUBSTRING(@RegClave, 9, 10)
      SELECT @Fecha = SUBSTRING(@RegClave, 19, 8)
	  SELECT @Clave = SUBSTRING(@RegClave, 27, 3)
	  SELECT @Concepto = Descripcion, @Tipo = NaturalezaMovimiento FROM MensajeInstitucion WHERE Mensaje = @Clave AND institucion = @Institucion	  
	  SELECT @Abono = CASE @Tipo WHEN 'ABONO' THEN CONVERT(money,SUBSTRING(@RegClave, 40, 13)) ELSE 0 END
	  SELECT @Cargo = CASE @Tipo WHEN 'CARGO' THEN CONVERT(money,SUBSTRING(@RegClave, 40, 13)) ELSE 0 END
	  SELECT @Referencia = SUBSTRING(@RegClave, 30, 10)
	  SELECT @Observaciones = CONVERT(varchar, dbo.fnQuitarCerosIzq(SUBSTRING(@RegClave, 30, 10)))

--select @Cuenta, @Fecha, @Hora, @Sucursal, @Cargo, @Abono, @Clave, @Concepto, @Cheque, @Referencia, @Operador, @Descripcion, @Saldo, @Signo
--select @Fecha, @Concepto, @Referencia, @Cargo, @Abono, @Observaciones
		INSERT INTO #ConciliacionBanco Values(@Fecha, @Concepto, @Referencia, @Cargo, @Abono, @Observaciones)
		FETCH NEXT FROM crListaSt INTO @RegClave
	END
	CLOSE crListaSt
	DEALLOCATE crListaSt
END
GO


/***************** spConciliacionImportar *******************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spConciliacionImportar' and Type = 'P')
	DROP PROCEDURE spConciliacionImportar
GO

CREATE PROCEDURE spConciliacionImportar
	@Estacion		Int,	
	@ID			int	
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE
    @Empresa		char(5),
    @CtaDinero		varchar(10),
    @Moneda		char(10),
    @NumeroCta		varchar(100),
    @Institucion	varchar(20),
    @Layout		varchar(20),
    /*@SaldoAnterior	money,
    @Cargos		money,
    @Abonos		money,*/
    @FechaD		datetime,
    @FechaA		datetime

  SELECT @Empresa = Empresa, @CtaDinero = CtaDinero FROM Conciliacion WHERE ID = @ID
  SELECT @Moneda = Moneda, @NumeroCta = NumeroCta, @Institucion = Institucion FROM CtaDinero WHERE CtaDinero = @CtaDinero
  SELECT @Layout = UPPER(Layout) FROM InstitucionFin WHERE Institucion = @Institucion

	CREATE TABLE #ConciliacionBanco(
		ID		int		NOT NULL IDENTITY (1,1)	PRIMARY KEY,
		Fecha		datetime	NULL,
		Concepto	varchar(50)	COLLATE Database_Default NULL,
		Referencia	varchar(50)	COLLATE Database_Default NULL,
		Cargo		money		NULL,
		Abono		money		NULL,
		Observaciones	varchar(100)	COLLATE Database_Default NULL
	)
	
	--Dependiendo de la institución financiera, se ejecutará un SP diferente.
	IF @Layout = 'BANCOMER'
		Exec spConciliacionBancomer @Institucion, @NumeroCta, @Estacion

	IF @Layout = 'SANTANDER'
		Exec spConciliacionSantander @Institucion, @NumeroCta, @Estacion

	IF @Layout = 'HSBC'
		Exec spConciliacionHSBC @Institucion, @NumeroCta, @Estacion

	IF @Layout = 'HSBC2'
		Exec spConciliacionHSBC2 @Institucion, @NumeroCta, @Estacion

	IF @Layout = 'BANREGIO'
		Exec spConciliacionBanregio @Institucion, @NumeroCta, @Estacion

	IF @Layout = 'BANORTE'
		Exec spConciliacionBanorte @Institucion, @NumeroCta, @Estacion

	IF @Layout = 'BANAMEX'
		Exec spConciliacionBanamex @Institucion, @NumeroCta, @Estacion

	IF @Layout = 'BANORTE2'
		Exec spConciliacionBanorte2 @Institucion, @NumeroCta, @Estacion

	IF @Layout = 'SCOTIABANK'
		Exec spConciliacionScotiabank @Institucion, @NumeroCta, @Estacion

  DELETE #ConciliacionBanco
   WHERE Concepto IN (SELECT ConceptoBanco FROM InstitucionFinConcepto WHERE Institucion = @Institucion AND TipoMovimiento = 'N/A')

  DELETE ConciliacionD WHERE ID = @ID
  INSERT ConciliacionD (
         ID,  Fecha, Concepto,                    Referencia,                    Cargo,              Abono,              Observaciones)
  SELECT @ID, Fecha, NULLIF(RTRIM(Concepto), ''), NULLIF(RTRIM(Referencia), ''), NULLIF(Cargo, 0.0), NULLIF(Abono, 0.0), NULLIF(RTRIM(Observaciones), '')
    FROM #ConciliacionBanco
   ORDER BY ID, Fecha


  SELECT @FechaD = MIN(Fecha), @FechaA = MAX(Fecha)--, @Cargos = SUM(Cargo), @Abonos = SUM(Abono)
    FROM ConciliacionD
   WHERE ID = @ID

  /*SELECT @SaldoAnterior = SaldoConciliado FROM DineroSaldo WHERE Empresa = @Empresa AND Moneda = @Moneda AND CtaDinero = @CtaDinero*/

  UPDATE Conciliacion 
     SET FechaD = @FechaD, FechaA = @FechaA/*, SaldoAnterior = @SaldoAnterior, Cargos = @Cargos, Abonos = @Abonos */
   WHERE ID = @ID

  SELECT 'Importacion Completada con Exito'
END
GO

/***************** spIVAConciliacion *******************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spIVAConciliacion' and Type = 'P')
	DROP PROCEDURE spIVAConciliacion
GO
CREATE PROCEDURE spIVAConciliacion        
@ID			AS INT,        
@Auxiliar	AS INT,        
@RID		AS INT,        
@Tipo		AS VARCHAR(20)        
--//WITH ENCRYPTION
AS        
BEGIN        
        
    SELECT Dinero.IvaFiscal * Dinero.Importe * Dinero.TipoCambio         
      FROM Dinero 
      JOIN Auxiliar ON Dinero.ID = Auxiliar.ModuloID        
       AND Auxiliar.ID = @Auxiliar        
       AND Auxiliar.Modulo = 'DIN'        
       AND Dinero.mov IN ('Deposito','Deposito Corte Caja','Deposito Electronico','Cheque','Cheque Anticipo','Cheque Electronico','Transf Anticipo')           
      JOIN ConciliacionD ON ConciliacionD.ID = @ID and RID = @RID        
       AND ConciliacionD.Seccion = 0         
       AND 1 = CASE WHEN @Tipo = 'Abono' AND ConciliacionD.Abono IS NOT NULL THEN 1 
                    WHEN @Tipo = 'Cargo' AND ConciliacionD.Cargo IS NOT NULL THEN 1 
                    ELSE 0 END
          
END 
GO
/***************** spIVAConciliacion2 *******************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spIVAConciliacion2' and Type = 'P')
	DROP PROCEDURE spIVAConciliacion2
GO
CREATE PROCEDURE spIVAConciliacion2          
@ID			AS INT,          
@Auxiliar	AS INT,          
@RID		AS INT,          
@Tipo		AS VARCHAR(20)
--//WITH ENCRYPTION
AS        
BEGIN       
          
    SELECT (Round(((Dinero.IvaFiscal * Dinero.Importe)/(Dinero.Importe-(Dinero.IvaFiscal * Dinero.Importe * Dinero.TipoCambio) ))*100,0))
      FROM Dinero 
      JOIN Auxiliar ON Dinero.ID = Auxiliar.ModuloID          
       AND Auxiliar.ID = @Auxiliar          
       AND Auxiliar.Modulo = 'DIN'          
       AND Dinero.mov IN ('Deposito','Deposito Corte Caja','Deposito Electronico','Cheque','Cheque Anticipo','Cheque Electronico','Transf Anticipo','Cheque Devolucion','Transf Devolucion')
      JOIN ConciliacionD on ConciliacionD.ID = @ID and RID = @RID          
       AND ConciliacionD.Seccion = 0           
       AND 1 = CASE WHEN @Tipo = 'Abono' AND ConciliacionD.Abono IS NOT NULL THEN 1 
                    WHEN @Tipo = 'Cargo' and ConciliacionD.Cargo IS NOT NULL THEN 1
                    ELSE 0 END
           
END
GO
/**************** spIVAConciliacion3 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIVAConciliacion3') and type = 'P') drop procedure dbo.spIVAConciliacion3
GO  

CREATE PROCEDURE spIVAConciliacion3        
@ID			AS INT,        
@Auxiliar	AS INT,        
@RID		AS INT,        
@Tipo		AS VARCHAR(20)        
--//WITH ENCRYPTION
AS        
BEGIN        
        
    SELECT Dinero.IvaFiscal * Dinero.Importe * Dinero.TipoCambio         
      FROM Dinero 
	    JOIN Auxiliar ON Dinero.ID = Auxiliar.ModuloID        
       AND Auxiliar.ID = @Auxiliar        
       AND Auxiliar.Modulo = 'DIN'        
       AND Dinero.mov IN ('Cheque Devolucion','Transf Devolucion')
      JOIN ConciliacionD ON ConciliacionD.ID = @ID AND RID = @RID        
       AND ConciliacionD.Seccion = 0         
       AND 1 = CASE WHEN @Tipo = 'Abono' AND ConciliacionD.Abono IS NOT NULL THEN 1
                    WHEN @Tipo = 'Cargo' AND ConciliacionD.Cargo IS NOT NULL THEN 1
					          ELSE 0 END
          
END 
GO
/**************** spIVAConciliacion4 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIVAConciliacion4') and type = 'P') drop procedure dbo.spIVAConciliacion4
GO  

CREATE PROCEDURE spIVAConciliacion4        
@ID			AS INT,        
@Auxiliar	AS INT,        
@RID		AS INT,        
@Tipo		AS VARCHAR(20)        
--//WITH ENCRYPTION
AS        
BEGIN        
        
    SELECT Dinero.IEPSFiscal * Dinero.Importe * Dinero.TipoCambio         
      FROM Dinero 
	    JOIN Auxiliar ON Dinero.ID = Auxiliar.ModuloID
       AND Auxiliar.ID = @Auxiliar        
       AND Auxiliar.Modulo = 'DIN'        
       AND Dinero.mov IN ('Deposito','Deposito Corte Caja','Deposito Electronico','Cheque','Cheque Anticipo','Cheque Electronico','Transf Anticipo')
      JOIN ConciliacionD ON ConciliacionD.ID = @ID AND RID = @RID        
       AND ConciliacionD.Seccion = 0         
       AND 1 = CASE WHEN @Tipo = 'Abono' AND ConciliacionD.Abono IS NOT NULL THEN 1
                    WHEN @Tipo = 'Cargo' AND ConciliacionD.Cargo IS NOT NULL THEN 1
                    ELSE 0 END

END 
GO
/**************** spIVAConciliacion5 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIVAConciliacion5') and type = 'P') drop procedure dbo.spIVAConciliacion5
GO  

CREATE PROCEDURE spIVAConciliacion5          
@ID			AS INT,          
@Auxiliar	AS INT,          
@RID		AS INT,          
@Tipo		AS VARCHAR(20)
--//WITH ENCRYPTION
AS        
BEGIN       
          
    SELECT (Round(((Dinero.IEPSFiscal * Dinero.Importe)/((Dinero.Importe-((Dinero.IEPSFiscal * Dinero.Importe)+(Dinero.IVAFiscal * Dinero.Importe)))*Dinero.TipoCambio))*100,0))
      FROM Dinero 
	    JOIN Auxiliar ON Dinero.ID = Auxiliar.ModuloID
       AND Auxiliar.ID = @Auxiliar          
       AND Auxiliar.Modulo = 'DIN'          
       AND Dinero.mov IN ('Deposito','Deposito Corte Caja','Deposito Electronico','Cheque','Cheque Anticipo','Cheque Electronico','Transf Anticipo','Cheque Devolucion','Transf Devolucion')             
      JOIN ConciliacionD on ConciliacionD.ID = @ID and RID = @RID          
       AND ConciliacionD.Seccion = 0           
       AND 1 = CASE WHEN @Tipo = 'Abono' AND ConciliacionD.Abono IS NOT NULL THEN 1
                    WHEN @Tipo = 'Cargo' AND ConciliacionD.Cargo IS NOT NULL THEN 1
                    ELSE 0 END

END
-- spConciliacionImportar 120, 10, '0443171736',  'Bancomer'
-- spConciliacionImportar 120, 10, '65501348214', 'Santander'
-- spConciliacionImportar 120, 10, '4020212957',  'HSBC'
-- spConciliacionImportar 120, 10, '3025040014',  'Banregio'
-- spConciliacionImportar 120, 10, '13657947',    'Banorte'
-- spConciliacionImportar 120, 10, '688524', 	  'Banamex'

-- delete ConciliacionD where Id = 10
-- Select * from ConciliacionD Id = 10

PRINT "******************* SP Conciliacion ******************"
GO
