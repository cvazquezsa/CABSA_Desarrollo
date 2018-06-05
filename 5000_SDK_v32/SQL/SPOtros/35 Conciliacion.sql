
/**************** spConcliarBanamex ****************/
if exists (select * from sysobjects where id = object_id('dbo.spConcliarBanamex') and type = 'P') drop procedure dbo.spConcliarBanamex
GO             
CREATE PROCEDURE spConcliarBanamex
		     @Sucursal		int,
		     @Estacion		int,
		     @Usuario		char(10)
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
    @ClaveArchivo	char(20),
    @ID			int,
    @Institucion	char(20),
    @ModuloID		int,
    @AuxiliarID		int,
    @MovID		varchar(20),
    @p			int,
    @Conciliado		bit,
    @Tipo		char(1),
    @CtaNombre		char(40),
    @CtaSucursal	char(4),
    @CtaNumero		char(16),
    @UltEmpresa		char(5),
    @Empresa		char(5),
    @Moneda		char(10),
    @MovCodigo		char(2),
    @MovSucursal	char(4),
    @MovReferencia1	char(10),
    @MovReferencia2	char(20),
    @MovImporte		money,
    @MovSubCodigo	char(2),
    @SucursalBancaria	int,
    @CtaDinero		char(10),
    @CtaDineroDestino	char(10),
    @Ok			int,
    @OkRef		varchar(255),
    @OkDesc           	varchar(255),
    @OkTipo           	varchar(50), 
    @Resultado		varchar(255),
    @FechaArchivo	datetime,
    @FechaRegistro 	datetime,
    @Clave 			varchar(100),
    @Observaciones		varchar(100),
    @Mov			char(20),
    --@Estatus			char(15),    
    @ConciliarPorSucursales	bit,
    @DineroSucursal		int,
    @RegistrosConciliados	int,
    @RegistrosPendientes	int,
    @Hoy			datetime,
    @ConcliarNivelCheque	bit

  SELECT @Institucion = 'BANAMEX',
         @FechaRegistro = GETDATE(), 
         @CtaNumero = NULL, @CtaNombre = NULL, @CtaSucursal = NULL, 
         @Ok = NULL, @OkRef = NULL, @Resultado = NULL, @UltEmpresa = NULL,
         @RegistrosConciliados = 0, @RegistrosPendientes = 0

  SELECT @ConcliarNivelCheque = ISNULL(ConcliarNivelCheque, 0) FROM InstitucionFin WHERE Institucion = @Institucion

  SELECT @Hoy = @FechaRegistro
  EXEC spExtraerFecha @Hoy OUTPUT

  CREATE TABLE #Conciliar(
	ID			int		IDENTITY(1,1)	NOT NULL,

	Tipo			char(1)		COLLATE Database_Default NULL,
        CtaDinero		char(10)	COLLATE Database_Default NULL,
        CtaDineroDestino	char(10)	COLLATE Database_Default NULL,
	Empresa			char(5)		COLLATE Database_Default NULL,
	Moneda			char(10)	COLLATE Database_Default NULL,
	AuxiliarID		int		NULL,    
        MovImporte		money		NULL,    
	MovCodigo		char(2)		COLLATE Database_Default NULL,
	MovSucursal		char(4)		COLLATE Database_Default NULL,
	MovReferencia1		char(10)	COLLATE Database_Default NULL,
	MovReferencia2		char(10)	COLLATE Database_Default NULL

	CONSTRAINT priTempConciliar PRIMARY KEY CLUSTERED (ID)
  )
    
  DECLARE crListaSt CURSOR FOR
    SELECT RTRIM(LTRIM(Clave)) FROM ListaSt WHERE Estacion = @Estacion

  OPEN crListaSt
  FETCH NEXT FROM crListaSt INTO @ClaveArchivo
  SELECT @FechaArchivo = CONVERT(datetime, RTRIM(SUBSTRING(@ClaveArchivo, 1, 2)) + '/' + RTRIM(SUBSTRING(@ClaveArchivo, 3, 2)) + '/' + RTRIM(SUBSTRING(@ClaveArchivo, 5, 2)), 3)
  IF @@ERROR <> 0 SELECT @Ok = 71060
--  IF EXISTS (SELECT * FROM ConciliacionLog WHERE Tipo = @Institucion AND Clave = @ClaveArchivo AND Estatus = 'CONCLUIDO') SELECT @Ok = 71070

  IF @Ok IS NULL
   DELETE Dinero WHERE FechaEmision = @FechaArchivo AND Estatus = 'BORRADOR' AND InstitucionMensaje IS NOT NULL

  FETCH NEXT FROM crListaSt INTO @Clave
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @MovID = NULL
      SELECT @Tipo = SUBSTRING(@Clave, 1, 1)
      IF @Tipo IN ('N', 'A', 'C')
      BEGIN
        IF @Tipo = 'N' 
        BEGIN
          SELECT @CtaNombre = NULL, @CtaSucursal = NULL, @CtaNumero = NULL
	  SELECT @CtaNombre   = RTRIM(SUBSTRING(@Clave,  2, 40)), 
                 @CtaSucursal = RTRIM(SUBSTRING(@Clave, 42,  4)), 
	         @CtaNumero   = RTRIM(SUBSTRING(@Clave, 46, 16))
        END ELSE
        BEGIN
          SELECT @MovCodigo = NULL, @MovSucursal = NULL, @MovReferencia1 = NULL, @MovReferencia2 = NULL, @MovImporte = NULL, @MovSubCodigo = NULL
          SELECT @MovCodigo      = RTRIM(SUBSTRING(@Clave,  2,  2)),
                 @MovSucursal    = RTRIM(SUBSTRING(@Clave,  4,  4)),
                 @MovReferencia1 = RTRIM(SUBSTRING(@Clave,  8, 10)),
		 @MovReferencia2 = RTRIM(SUBSTRING(@Clave, 18, 20)),
                 @MovImporte     = CONVERT(money, RTRIM(SUBSTRING(@Clave, 38, 17))) / 100,
		 @MovSubCodigo   = RTRIM(SUBSTRING(@Clave, 55,  2))
           EXEC spQuitarCerosIzq @MovReferencia1 OUTPUT

           IF @ConcliarNivelCheque = 1 AND @Tipo = 'C' AND dbo.fnEsNumerico(@MovReferencia1) = 1 
           BEGIN
             IF ISNULL(CONVERT(int, RTRIM(@MovReferencia1)), 0) NOT IN (0, 40000)
               SELECT @MovID = RTRIM(@MovReferencia1)
           END
           SELECT @SucursalBancaria = CONVERT(int, @MovSucursal)
         END
         IF @CtaNumero IS NULL OR @CtaNombre IS NULL OR @CtaSucursal IS NULL SELECT @Ok = 71060
         IF @Tipo IN ('A', 'C') AND @Ok IS NULL
         BEGIN
           IF @MovCodigo IS NULL OR @MovSucursal IS NULL OR @MovImporte IS NULL SELECT @Ok = 71060

           SELECT @CtaDinero = NULL, @Empresa = NULL
           SELECT @CtaDinero = CtaDinero, @Empresa = Empresa, @Moneda = Moneda 
             FROM CtaDinero 
            WHERE Institucion = @Institucion AND UPPER(NumeroCta) = UPPER(@CtaNumero)
           IF @CtaDinero = NULL AND dbo.fnEsNumerico(@CtaNumero) = 1
           BEGIN
             SELECT @CtaNumero = RTRIM(LTRIM(CONVERT(char, CONVERT(money, @CtaNumero))))
             SELECT @p = CHARINDEX('.', @CtaNumero)
             IF @p > 0 SELECT @CtaNumero = RTRIM(LTRIM(SUBSTRING(@CtaNumero, 1, @p-1)))
             SELECT @CtaDinero = CtaDinero, @Empresa = Empresa, @Moneda = Moneda 
               FROM CtaDinero 
              WHERE Institucion = @Institucion AND UPPER(NumeroCta) = UPPER(@CtaNumero)
           END

           IF @CtaDinero IS NOT NULL 
           BEGIN
    	     IF @Empresa IS NULL SELECT @Ok = 40160             
             IF @Ok IS NOT NULL CONTINUE 

             IF @Empresa <> @UltEmpresa
             BEGIN
               SELECT @ConciliarPorSucursales = ISNULL(DineroConciliarPorSucursales, 0)
                 FROM EmpresaCfg
                WHERE Empresa = @Empresa

               SELECT @UltEmpresa = @Empresa
             END

	     SELECT @AuxiliarID = NULL

             IF EXISTS(SELECT * FROM MensajeInstitucion WHERE Institucion = @Institucion AND Mensaje = @MovCodigo AND ConciliarMismaFecha = 1)
             BEGIN
               IF @Tipo = 'A' 
                 SELECT @AuxiliarID = MIN(ID)
                   FROM Auxiliar a
                  WHERE a.Empresa = @Empresa AND a.Modulo = 'DIN' AND a.Cuenta = @CtaDinero AND ROUND(a.Cargo, 2) = @MovImporte 
                    AND a.Conciliado = 0 AND a.EsCancelacion = 0
                    AND a.ID NOT IN (SELECT AuxiliarID FROM #Conciliar)
                    AND a.Fecha = @FechaArchivo  
                    AND (@ConciliarPorSucursales = 0 OR (@SucursalBancaria IN (SELECT sb.Numero FROM SucursalBanco sb WHERE sb.Sucursal = a.Sucursal AND sb.Institucion = @Institucion)))
               ELSE
                 SELECT @AuxiliarID = MIN(ID)
                   FROM Auxiliar a
                  WHERE a.Empresa = @Empresa AND a.Modulo = 'DIN' AND a.Cuenta = @CtaDinero AND ROUND(a.Abono, 2) = @MovImporte AND a.MovID = ISNULL(@MovID, a.MovID)
                    AND a.Conciliado = 0 AND a.EsCancelacion = 0
                    AND a.ID NOT IN (SELECT AuxiliarID FROM #Conciliar)
                    AND a.Fecha = @FechaArchivo
                    AND (@ConciliarPorSucursales = 0 OR (@SucursalBancaria IN (SELECT sb.Numero FROM SucursalBanco sb WHERE sb.Sucursal = a.Sucursal AND sb.Institucion = @Institucion)))
             END ELSE
             BEGIN
               IF @Tipo = 'A' 
                 SELECT @AuxiliarID = MIN(ID)
                   FROM Auxiliar a
                  WHERE a.Empresa = @Empresa AND a.Modulo = 'DIN' AND a.Cuenta = @CtaDinero AND ROUND(a.Cargo, 2) = @MovImporte
                    AND a.Conciliado = 0 AND a.EsCancelacion = 0
                    AND a.ID NOT IN (SELECT AuxiliarID FROM #Conciliar)
                    AND (@ConciliarPorSucursales = 0 OR (@SucursalBancaria IN (SELECT sb.Numero FROM SucursalBanco sb WHERE sb.Sucursal = a.Sucursal AND sb.Institucion = @Institucion)))
               ELSE BEGIN
                 SELECT @AuxiliarID = MIN(ID)
                   FROM Auxiliar a
                  WHERE a.Empresa = @Empresa AND a.Modulo = 'DIN' AND a.Cuenta = @CtaDinero AND ROUND(a.Abono, 2) = @MovImporte AND a.MovID = ISNULL(@MovID, a.MovID)
                    AND a.Conciliado = 0 AND a.EsCancelacion = 0
                    AND a.ID NOT IN (SELECT AuxiliarID FROM #Conciliar)
                    AND (@ConciliarPorSucursales = 0 OR (@SucursalBancaria IN (SELECT sb.Numero FROM SucursalBanco sb WHERE sb.Sucursal = a.Sucursal AND sb.Institucion = @Institucion)))
               END
             END
             INSERT #Conciliar (Tipo,  CtaDinero,  Empresa,  Moneda,  AuxiliarID,  MovImporte,  MovCodigo,  MovSucursal,  MovReferencia1,  MovReferencia2)
                        VALUES (@Tipo, @CtaDinero, @Empresa, @Moneda, @AuxiliarID, @MovImporte, @MovCodigo, @MovSucursal, @MovReferencia1, @MovReferencia2)
           END
         END
      END
    END
    FETCH NEXT FROM crListaSt INTO @Clave
  END  -- While	
  CLOSE crListaSt
  DEALLOCATE crListaSt

  BEGIN TRANSACTION
    /*SELECT @Estatus = 'PENDIENTE'
    IF EXISTS(SELECT * FROM #Conciliar WHERE AuxiliarID IS NULL)
    BEGIN*/
      -- Transferencias
      DECLARE crTrans CURSOR FOR
        SELECT Tipo, CtaDinero, Empresa, Moneda, MovImporte
          FROM #Conciliar
         WHERE AuxiliarID IS NULL AND MovCodigo = '71' AND Tipo = 'A'
         ORDER BY Tipo
      OPEN crTrans
      FETCH NEXT FROM crTrans INTO @Tipo, @CtaDinero, @Empresa, @Moneda, @MovImporte
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN        
          SELECT @ID = NULL, @AuxiliarID = NULL

          SELECT @ID = ID, @AuxiliarID = AuxiliarID 
            FROM #Conciliar 
           WHERE CtaDinero <> @CtaDinero AND MovCodigo = '51' AND Tipo = 'C' AND Empresa = @Empresa AND Moneda = @Moneda AND MovImporte = @MovImporte
             AND AuxiliarID IS NULL
          IF @@ROWCOUNT = 0
            SELECT @ID = ID, @AuxiliarID = AuxiliarID 
              FROM #Conciliar 
             WHERE CtaDinero <> @CtaDinero AND MovCodigo = '51' AND Tipo = 'C' AND Empresa = @Empresa AND Moneda = @Moneda AND MovImporte = @MovImporte
               AND AuxiliarID IS NOT NULL

          IF @AuxiliarID IS NULL
            UPDATE #Conciliar 
               SET CtaDineroDestino = @CtaDinero, Tipo = 'T'
             WHERE ID = @ID

          IF @ID IS NOT NULL
            DELETE #Conciliar WHERE CURRENT OF crTrans
        END
        FETCH NEXT FROM crTrans INTO @Tipo, @CtaDinero, @Empresa, @Moneda, @MovImporte
      END  -- While	
      CLOSE crTrans
      DEALLOCATE crTrans

      DECLARE crConciliar CURSOR FOR
        SELECT Tipo, CtaDinero, CtaDineroDestino, Empresa, Moneda, MovImporte, MovCodigo, MovSucursal, MovReferencia1, MovReferencia2
          FROM #Conciliar
         WHERE AuxiliarID IS NULL 
      OPEN crConciliar
      FETCH NEXT FROM crConciliar INTO @Tipo, @CtaDinero, @CtaDineroDestino, @Empresa, @Moneda, @MovImporte, @MovCodigo, @MovSucursal, @MovReferencia1, @MovReferencia2
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          SELECT @Mov = CASE WHEN @Tipo = 'C' THEN BancoCargoBancario 
                             WHEN @Tipo = 'T' THEN BancoTransferencia
                             ELSE BancoAbonoBancario END
            FROM EmpresaCfgMov
           WHERE Empresa = @Empresa

          SELECT @Observaciones =  RTRIM(Mensaje)+' - '+RTRIM(Descripcion)
            FROM MensajeInstitucion
           WHERE Institucion = Institucion AND Mensaje = @MovCodigo

          SELECT @DineroSucursal = NULL
          IF @ConciliarPorSucursales = 1
            SELECT @DineroSucursal = MIN(Sucursal) FROM SucursalBanco WHERE Institucion = @Institucion AND Numero = @MovSucursal

          IF NOT EXISTS(SELECT * FROM Dinero WHERE Sucursal = ISNULL(@DineroSucursal, Sucursal) AND Empresa = @Empresa AND Mov = @Mov AND CtaDinero = @CtaDinero AND ISNULL(CtaDineroDestino, '') = ISNULL(@CtaDineroDestino, '') AND ISNULL(Importe, 0)+ISNULL(Impuestos,0) = @MovImporte AND Estatus IN ('BORRADOR', 'PENDIENTE', 'CONCLUIDO') AND FechaConciliacion = @Hoy)
          BEGIN
            INSERT Dinero (Sucursal,                          Empresa,  Mov,  FechaEmision,  Moneda,  TipoCambio,  Usuario,  Observaciones,      Estatus,    CtaDinero,  CtaDineroDestino,  Importe,     ConDesglose, InstitucionMensaje, InstitucionSucursal, InstitucionReferencia1, InstitucionReferencia2, FechaConciliacion, AutoConciliar)
                   SELECT ISNULL(@DineroSucursal, @Sucursal), @Empresa, @Mov, @FechaArchivo,  @Moneda, Mon.TipoCambio, @Usuario, @Observaciones, 'BORRADOR', @CtaDinero, @CtaDineroDestino, @MovImporte, 0,           @MovCodigo,         @MovSucursal,        @MovReferencia1,        @MovReferencia2,        @Hoy,     1
                     FROM Mon
                    WHERE Mon.Moneda = @Moneda
          END ELSE
           DELETE #Conciliar WHERE CURRENT OF crConciliar
        END
        FETCH NEXT FROM crConciliar INTO @Tipo, @CtaDinero, @CtaDineroDestino, @Empresa, @Moneda, @MovImporte, @MovCodigo, @MovSucursal, @MovReferencia1, @MovReferencia2
      END  -- While	
      CLOSE crConciliar
      DEALLOCATE crConciliar

    /*END ELSE
    BEGIN*/
      DECLARE crConciliar CURSOR FOR
        SELECT a.ModuloID, c.AuxiliarID, c.MovCodigo, c.MovSucursal, c.MovReferencia1, c.MovReferencia2
          FROM #Conciliar c, Auxiliar a
         WHERE AuxiliarID IS NOT NULL AND c.AuxiliarID = a.ID
      OPEN crConciliar
      FETCH NEXT FROM crConciliar INTO @ModuloID, @AuxiliarID, @MovCodigo, @MovSucursal, @MovReferencia1, @MovReferencia2
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          /*SELECT @Estatus = 'CONCLUIDO'*/
	  UPDATE Auxiliar SET Conciliado = 1, FechaConciliacion = @Hoy WHERE ID = @AuxiliarID
          UPDATE Dinero 
             SET InstitucionMensaje     = @MovCodigo,
		 InstitucionSucursal    = @MovSucursal,
		 InstitucionReferencia1 = @MovReferencia1,
		 InstitucionReferencia2 = @MovReferencia2,
                 FechaConciliacion      = @Hoy
           WHERE ID = @ModuloID
        END
        FETCH NEXT FROM crConciliar INTO @ModuloID, @AuxiliarID, @MovCodigo, @MovSucursal, @MovReferencia1, @MovReferencia2
      END  -- While	
      CLOSE crConciliar
      DEALLOCATE crConciliar
    /*END*/

  IF @Ok IS NULL
  BEGIN
    /*IF EXISTS(SELECT * FROM #Conciliar WHERE AuxiliarID IS NULL)
      SELECT @Estatus = 'PENDIENTE'
    ELSE
      SELECT @Estatus = 'CONCLUIDO'
    UPDATE ConciliacionLog SET Estatus = @Estatus, Fecha = @FechaRegistro WHERE Tipo = @Institucion AND Clave = @ClaveArchivo
    IF @@ROWCOUNT = 0
      INSERT ConciliacionLog (Tipo, Clave, Estatus, Fecha) VALUES (@Institucion, @ClaveArchivo, @Estatus, @FechaRegistro)*/
    COMMIT TRANSACTION
  END ELSE
    ROLLBACK TRANSACTION

  IF @Ok IS NULL 
  BEGIN
    SELECT @RegistrosConciliados = COUNT(*) FROM #Conciliar WHERE AuxiliarID IS NOT NULL
    SELECT @RegistrosPendientes = COUNT(*) FROM #Conciliar WHERE AuxiliarID IS NULL
    IF @RegistrosPendientes > 0 
      SELECT @Resultado = 'Faltan '+RTRIM(CONVERT(char, @RegistrosPendientes))+' Movimientos en Borrador'
    ELSE
      SELECT @Resultado = 'Proceso Concluido'

    IF @RegistrosConciliados > 0 
      SELECT @Resultado = @Resultado+', se Conciliaron '+RTRIM(CONVERT(char, @RegistrosConciliados))+' Registros.'
  END ELSE
    SELECT @Resultado = Descripcion FROM MensajeLista WHERE Mensaje = @Ok  
  
  SELECT @Resultado
  RETURN 
END
GO
-- select * from listast where estacion = 1
-- exec spConcliarBanamex 0, 1, 'DEMO'


/**************** spConcliarBital ****************/
if exists (select * from sysobjects where id = object_id('dbo.spConcliarBital') and type = 'P') drop procedure dbo.spConcliarBital
GO             
CREATE PROCEDURE spConcliarBital
		     @Sucursal		int,
		     @Estacion		int,
		     @Usuario		char(10)
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
    @Institucion	char(20),
    @Empresa		char(5),
    @Clave 		varchar(255),
    @Ok			int,
    @OkRef		varchar(255),
    @Conteo		int,
    @Resultado		varchar(255),
    @CtaDinero		char(10),
    @CtaNumero		char(10),
    @UltCtaNumero	char(10),
    @Fecha		datetime,
    @AMD		char(8),
    @HMS		char(6),
    @FechaEmision	datetime,
    @FechaBanco		datetime,
    @SucursalBancaria	int,
    @Monto		money,
    @TipoOperacion	char(2),
    @ClaveTransaccion	int,    
    @NumeroCheque	int,
    @FolioMovimiento	int,
    @Operador		char(5),
    @AuxiliarID		int,
    @ModuloID		int,
    @Moneda		char(10),
    @Mov		char(20),
    @MovCargoBancario	char(20),
    @MovAbonoBancario	char(20),
    @MovCodigo		varchar(10),
    @MovSucursal	varchar(10),
    @MovReferencia1	varchar(50),
    @MovReferencia2	varchar(50),
    @Observaciones	varchar(100),
    @Conciliar			bit,
    @ConciliarPorSucursales	bit,
    @DineroSucursal		int,
    @Hoy			datetime

  SELECT @Institucion = 'BITAL',
         @UltCtaNumero = NULL,
         @Conteo = 0,
         @ConciliarPorSucursales = 0

  SELECT @Hoy = GETDATE()
  EXEC spExtraerFecha @Hoy OUTPUT

  DECLARE crListaSt CURSOR FOR
    SELECT RTRIM(LTRIM(Clave)) FROM ListaSt WHERE Estacion = @Estacion

  OPEN crListaSt
  FETCH NEXT FROM crListaSt INTO @Clave
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @CtaNumero 	= SUBSTRING(@Clave,  1, 10),
             @AMD		= SUBSTRING(@Clave, 11,  8),
             @HMS		= SUBSTRING(@Clave, 19,  6),
             @SucursalBancaria	= CONVERT(int, SUBSTRING(@Clave, 25,  5)),
	     @Monto		= CONVERT(money, SUBSTRING(@Clave, 30, 13))/100,
	     @TipoOperacion	= SUBSTRING(@Clave, 43, 2),
             @ClaveTransaccion  = NULLIF(CONVERT(int, SUBSTRING(@Clave, 45,  5)), 0),
	     @NumeroCheque	= NULLIF(CONVERT(int, SUBSTRING(@Clave, 50, 11)), 0),
	     @FolioMovimiento	= NULLIF(CONVERT(int, SUBSTRING(@Clave, 61,  5)), 0),
	     @Operador		= SUBSTRING(@Clave, 66, 5),
	     @Observaciones	= SUBSTRING(@Clave, 71, 40)

      EXEC spAMDToDateTime @AMD, @FechaEmision OUTPUT
      EXEC spAMDHMSToDateTime @AMD, @HMS, @FechaBanco OUTPUT
      SELECT @MovCodigo      = CONVERT(varchar, @ClaveTransaccion),
	     @MovSucursal    = CONVERT(varchar, @SucursalBancaria),
    	     @MovReferencia1 = CONVERT(varchar, @NumeroCheque),
       	     @MovReferencia2 = CONVERT(varchar, @FolioMovimiento)

      IF @CtaNumero <> @UltCtaNumero
      BEGIN
        SELECT @UltCtaNumero = @CtaNumero
        SELECT @CtaDinero = CtaDinero, @Empresa = Empresa, @Moneda = Moneda 
          FROM CtaDinero 
         WHERE Institucion = @Institucion AND UPPER(NumeroCta) = UPPER(@CtaNumero)

        SELECT @MovCargoBancario = BancoCargoBancario,
               @MovAbonoBancario = BancoAbonoBancario
          FROM EmpresaCfgMov
         WHERE Empresa = @Empresa

        SELECT @ConciliarPorSucursales = ISNULL(DineroConciliarPorSucursales, 0)
          FROM EmpresaCfg
         WHERE Empresa = @Empresa
      END

      SELECT @AuxiliarID = NULL, @Conciliar = 0
      IF @TipoOperacion = 'CR'
      BEGIN
        SELECT @Mov = @MovAbonoBancario
        SELECT @AuxiliarID = MIN(a.ID)
          FROM Auxiliar a
         WHERE a.Empresa = @Empresa AND a.Modulo = 'DIN' AND a.Cuenta = @CtaDinero AND ROUND(a.Cargo, 2) = @Monto
           AND a.Conciliado = 0 AND a.EsCancelacion = 0
           AND a.Fecha = @FechaEmision
           AND (@ConciliarPorSucursales = 0 OR (@SucursalBancaria IN (SELECT sb.Numero FROM SucursalBanco sb WHERE sb.Sucursal = a.Sucursal AND sb.Institucion = @Institucion)))
        IF @AuxiliarID IS NULL
          SELECT @AuxiliarID = MIN(a.ID)
            FROM Auxiliar a
           WHERE a.Empresa = @Empresa AND a.Modulo = 'DIN' AND a.Cuenta = @CtaDinero AND ROUND(a.Cargo, 2) = @Monto
             AND a.Conciliado = 1 AND a.EsCancelacion = 0 AND a.FechaConciliacion = @Hoy
             AND a.Fecha = @FechaEmision
             AND (@ConciliarPorSucursales = 0 OR (@SucursalBancaria IN (SELECT sb.Numero FROM SucursalBanco sb WHERE sb.Sucursal = a.Sucursal AND sb.Institucion = @Institucion)))
        ELSE 
          SELECT @Conciliar = 1
      END ELSE
      BEGIN
        SELECT @Mov = @MovCargoBancario
        SELECT @AuxiliarID = MIN(a.ID)
          FROM Auxiliar a
         WHERE a.Empresa = @Empresa AND a.Modulo = 'DIN' AND a.Cuenta = @CtaDinero AND ROUND(a.Abono, 2) = @Monto
           AND a.Conciliado = 0 AND a.EsCancelacion = 0    
           AND a.Fecha = @FechaEmision
           AND (@ConciliarPorSucursales = 0 OR (@SucursalBancaria IN (SELECT sb.Numero FROM SucursalBanco sb WHERE sb.Sucursal = a.Sucursal AND sb.Institucion = @Institucion)))
      IF @AuxiliarID IS NULL
          SELECT @AuxiliarID = MIN(a.ID)
            FROM Auxiliar a
           WHERE a.Empresa = @Empresa AND a.Modulo = 'DIN' AND a.Cuenta = @CtaDinero AND ROUND(a.Abono, 2) = @Monto
             AND a.Conciliado = 1 AND a.EsCancelacion = 0 AND a.FechaConciliacion = @Hoy
             AND a.Fecha = @FechaEmision
             AND (@ConciliarPorSucursales = 0 OR (@SucursalBancaria IN (SELECT sb.Numero FROM SucursalBanco sb WHERE sb.Sucursal = a.Sucursal AND sb.Institucion = @Institucion)))
        ELSE 
          SELECT @Conciliar = 1
      END

      IF @Conciliar = 1
      BEGIN
        UPDATE Auxiliar SET Conciliado = 1, FechaConciliacion = @Hoy, @ModuloID = ModuloID WHERE ID = @AuxiliarID
        UPDATE Dinero 
           SET InstitucionMensaje     = @MovCodigo,
	       InstitucionSucursal    = @MovSucursal,
       	       InstitucionReferencia1 = @MovReferencia1,
       	       InstitucionReferencia2 = @MovReferencia2
         WHERE ID = @ModuloID
        SELECT @Conteo = @Conteo +1
      END ELSE
      BEGIN
        SELECT @DineroSucursal = NULL
        IF @ConciliarPorSucursales = 1
          SELECT @DineroSucursal = MIN(Sucursal) FROM SucursalBanco WHERE Institucion = @Institucion AND Numero = @MovSucursal

        IF @AuxiliarID IS NULL AND NOT EXISTS(SELECT * FROM Dinero WHERE Sucursal = ISNULL(@DineroSucursal, Sucursal) AND Empresa = @Empresa AND Mov = @Mov AND CtaDinero = @CtaDinero AND ISNULL(Importe, 0)+ISNULL(Impuestos,0) = @Monto AND Estatus = 'BORRADOR' AND FechaConciliacion = @Hoy)
          INSERT Dinero (Sucursal,                          Empresa,  Mov,  FechaEmision,  Moneda,  TipoCambio,     Usuario,  Observaciones,   Estatus,   CtaDinero,  Importe, ConDesglose, InstitucionMensaje, InstitucionSucursal, InstitucionReferencia1, InstitucionReferencia2, FechaConciliacion, AutoConciliar)
                 SELECT ISNULL(@DineroSucursal, @Sucursal), @Empresa, @Mov, @FechaEmision, @Moneda, Mon.TipoCambio, @Usuario, @Observaciones, 'BORRADOR', @CtaDinero, @Monto,  0,           @MovCodigo,         @MovSucursal,        @MovReferencia1,        @MovReferencia2,        @Hoy,       1
                   FROM Mon
                  WHERE Mon.Moneda = @Moneda
      END
    END
    FETCH NEXT FROM crListaSt INTO @Clave
  END  -- While	
  CLOSE crListaSt
  DEALLOCATE crListaSt
  

  IF @Ok IS NULL 
  BEGIN
    SELECT @Resultado = 'Proceso Concluido, Se Conciliaron '+RTRIM(CONVERT(char, @Conteo))+' Registros.'
  END ELSE
    SELECT @Resultado = Descripcion FROM MensajeLista WHERE Mensaje = @Ok  
  
  SELECT @Resultado
  RETURN 
END
GO

-- select * from listast where estacion = 100
-- exec spConcliarBital 0, 100, 'DEMO'
-- select fechaconciliacion from dinero

-- Nmbre: spConciliarBancomer
-- Ver. 1.0		Para conciliar las operaciones con el banco Bancomer
IF exists(SELECT * FROM sysobjects WHERE NAME='spConciliarBancomer' and type='P')
	DROP PROCEDURE spConciliarBancomer
GO

CREATE PROCEDURE spConciliarBancomer
	@Sucursal		int,
	@Estacion		int,
	@Usuario		char(10)
--//WITH ENCRYPTION
AS
BEGIN
DECLARE 
	@NoCuenta	char(10),
	@Fecha		smalldatetime,
	@RefBanco	char(6),
	@Concepto	char(30),
	@TipoMov	char(1),
	@Importe	decimal(10,2),
	@Moneda		char(3),
	@Filler		char(9),
	@RefMov		char(30),
	@Filler2	char(7),
	@FechaInicial	smalldatetime,
	@Filler3	char(22),
	@Blancos1	char(12),
	@ContratoCash	char(3),
	@Blancos2	char(3),
	@Hoy 		smalldatetime,
	@Institucion	varchar(20),
	@NoUltCuenta	varchar(16),
	@RegsConc	smallint,
	@RegsNoConc 	smallint,
	@ConcPorSuc 	bit,
	@ContinuaProc	bit,
	@RegClave	varchar(255),
	@Resultado	varchar(150),
	@AuxiliarID	int,
	@CtaDinero 	char(18),
	@Empresa	char(5),
	@MonEmp 	char(10),
	@MovCargoBancario	char(20),
	@MovAbonoBancario	char(20),
	@BancoCargoBancarioIVA	char(20),
	@BancoCheque		char(20),
	@DineroSucursal		int,
	@ModuloID		int

--Inicializa valores para usar en todo el proceso
set nocount on
SELECT @Institucion = 'BANCOMER', @RegsConc = 0, @RegsNoConc = 0, @ConcPorSuc = 0,
       @ContinuaProc = 1, @NoCuenta = NULL, @NoUltCuenta = ''
EXEC spExtraerFecha @Hoy OUTPUT

--Inicio de la transaccion
BEGIN TRANSACTION
DECLARE crListaSt CURSOR FOR
SELECT RTRIM(LTRIM(Clave)) FROM ListaSt WHERE Estacion = @Estacion
OPEN crListaSt
FETCH NEXT FROM crListaSt INTO @RegClave
WHILE @@FETCH_STATUS = 0
BEGIN
	--select @RegClave
	--Divide el registro leido y carga los valores de sus respectivos campos
	SELECT 	@NoCuenta	= LTRIM(RTRIM(SUBSTRING(@RegClave, 9, 10))),
 	       	@Fecha		= CONVERT(smalldatetime, SUBSTRING(@RegClave, 19, 10),102),
		@RefBanco	= SUBSTRING(@RegClave, 29, 6),
		@Concepto	= SUBSTRING(@RegClave, 35, 30),
		@TipoMov	= SUBSTRING(@RegClave, 65, 1),
		@Importe	= CONVERT(decimal(10,2), SUBSTRING(@RegClave, 66, 16)),
		@Moneda		= SUBSTRING(@RegClave, 82, 3),
		@Filler		= SUBSTRING(@RegClave, 85, 9),
		@RefMov		= SUBSTRING(@RegClave, 94, 30),
		@Filler2	= SUBSTRING(@RegClave, 124, 7),
		@FechaInicial	= CONVERT(smalldatetime, SUBSTRING(@RegClave, 131, 10)),
		@Blancos1	= SUBSTRING(@RegClave, 141, 12),
		@ContratoCash	= SUBSTRING(@RegClave, 153, 3),
		@Blancos2	= SUBSTRING(@RegClave, 156, 3),
		@Filler3	= SUBSTRING(@RegClave, 159, 4)
		
	--select @NoCuenta , @Fecha, @RefBanco, @Concepto, @TipoMov, @Importe, @Moneda, @Filler, @RefMov, @Filler2, @FechaInicial, @Blancos1, @ContratoCash, @Blancos2, @Filler3
	IF @@ERROR <> 0
	BEGIN
		SELECT @resultado = 'Los datos del archivo seleccionado no tienen el formato prestablecido, favor de verificar' 
		SELECT @ContinuaProc = 0 
		BREAK
	END

	--Checa y recupera los datos referentes a la cuenta
	IF @NoCuenta <> @NoUltCuenta
	BEGIN
		SELECT 	@CtaDinero = CtaDinero,	@Empresa = Empresa, @MonEmp = Moneda
		  FROM CtaDinero
		 WHERE Institucion = @Institucion AND UPPER(NumeroCta) = UPPER(@NoCuenta)

		SELECT @MovCargoBancario 	  = BancoCargoBancario,	
			   @MovAbonoBancario	  = BancoAbonoBancario, 
			   @BancoCargoBancarioIVA = BancoCargoBancarioIVA, 
			   @BancoCheque		  = BancoCheque
		  FROM EmpresaCfgMov
		 WHERE Empresa = @Empresa
		--SELECT 'uno', @MovCargoBancario, @MovAbonoBancario, @BancoCargoBancarioIVA, @BancoCheque
		SELECT @NoUltCuenta = @NoCuenta
	END

	SELECT @AuxiliarID = NULL
	IF @TipoMov = '0'
		SELECT @AuxiliarID = MIN(a.ID)
		  FROM Auxiliar a
		 WHERE a.Empresa = @Empresa AND a.Modulo = 'DIN' AND a.Cuenta = @CtaDinero AND ROUND(a.Cargo, 2) = @Importe
		   AND a.Conciliado = 0 AND a.EsCancelacion = 0 AND a.Fecha = CONVERT(smalldatetime, @Fecha, 102) 
		   AND @ConcPorSuc = 0 

	ELSE IF @TipoMov = '1'
		SELECT @AuxiliarID = MIN(a.ID)
		  FROM Auxiliar a
		 WHERE a.Empresa = @Empresa AND a.Modulo = 'DIN' AND a.Cuenta = @CtaDinero AND ROUND(a.Abono, 2) = @Importe
		   AND a.Conciliado = 0 AND a.EsCancelacion = 0 AND a.Fecha = CONVERT(smalldatetime, @Fecha, 102) 
		   AND @ConcPorSuc = 0 

	--Si existe el registro, lo Actualiza como conciliado, en caso contrario, inserta el registro en La tabla dinero como 'BORRADOR'
	IF @AuxiliarID IS NOT NULL
	BEGIN
		UPDATE Auxiliar 
		   SET Conciliado = 1, FechaConciliacion = CONVERT(smalldatetime,getdate(),102) , @ModuloID = ModuloID  
		 WHERE ID = @AuxiliarID
			
		UPDATE Dinero
    	   SET InstitucionSucursal    = null,
			   InstitucionReferencia1 = @RefBanco,
			   InstitucionReferencia2 = @RefMov
		 WHERE ID = @ModuloID
		SELECT @RegsConc = @RegsConc + 1
	END
	ELSE
	BEGIN
		if @TipoMov in ('0','1')
			SELECT @RegsNoConc = @RegsNoConc + 1

	END
	FETCH NEXT FROM crListaSt INTO @RegClave
END
CLOSE crListaSt
DEALLOCATE crListaSt

IF @ContinuaProc = 1
BEGIN
	COMMIT TRANSACTION
	SELECT @Resultado='El proceso termino correctamente, se conciliaron ' + CONVERT(varchar,@RegsConc) + ' registros ' --y ' + CONVERT(varchar,@RegsNoConc)+ ' quedaron pendientes'
END
ELSE
	ROLLBACK TRANSACTION
SELECT @Resultado
set nocount off
RETURN
END
GO

-- spConciliarBancomer 0, 120, 'a'


-- Nmbre: spConciliarSantander
-- Ver. 1.0		Para conciliar las operaciones con el banco Santander-Serfin

IF exists(SELECT * FROM sysobjects WHERE NAME='spConciliarSantander' and type='P')
	DROP PROCEDURE spConciliarSantander
GO

CREATE PROCEDURE spConciliarSantander
	@Sucursal		int,
	@Estacion		int,
	@Usuario		char(10)
--//WITH ENCRYPTION
AS
BEGIN

DECLARE @NoCuenta					varchar(16),
		@NoUltCuenta				varchar(16),
		@Fecha						smalldatetime,
		@SucursalBco				varchar(4),
		@Descripcion				varchar(40),
		@Tipo						char(5),
		@Importe					decimal(12,2),
		@Referencia					varchar(8),
		@Concepto					varchar(40),
		@RegClave					varchar(255),
		@Institucion				varchar(20),
		@Hoy 						smalldatetime,
		@CtaDinero 					char(10),
		@Empresa					char(5),
		@Moneda 					char(10),
		@MovCargoBancario			char(20),
		@MovAbonoBancario			char(20),
		@BancoCargoBancarioIVA		char(20),
		@BancoCheque				char(20),
		@ConcPorSucs				bit,
		@RegsConc					smallint,
		@RegsNoConc 				smallint,
		@Resultado					varchar(150),
		@ImpTotDiferencias			decimal(8,4),
		@ImpOper					decimal(12,4),
		@ImpDiferencia				decimal(8,4),
		@AuxiliarID					int,
		@ModuloID					int,
		@ConciliarPorSucursales 	bit,
		@DineroSucursal				int,
		@Resultados					varchar(100),
		@FormaPago					varchar(50),
		@ContinuaProc				bit,
		@Mov						char(20)
		
SELECT @Institucion = 'SANTANDER', @Hoy = GETDATE(), @ConcPorSucs = 0, @NoUltCuenta = NULL, @ImpDiferencia = 0,
       @RegsConc = 0, @RegsNoConc = 0, @ConciliarPorSucursales = 0, @ImpTotDiferencias = 0, @ContinuaProc = 1
EXEC spExtraerFecha @Hoy OUTPUT
SELECT @NoCuenta = NULL, @NoUltCuenta = ''

BEGIN TRANSACTION
DECLARE crListaSt CURSOR FOR
SELECT RTRIM(LTRIM(Clave)) FROM ListaSt WHERE Estacion = @Estacion
OPEN crListaSt
FETCH NEXT FROM crListaSt INTO @RegClave
WHILE @@FETCH_STATUS = 0
BEGIN
	--Divide el registro leido y carga los valores de sus respectivos campos
	SELECT @NoCuenta    = LTRIM(RTRIM(SUBSTRING(@RegClave, 1, 16))), 
 	       @Fecha 		= CONVERT(smalldatetime, SUBSTRING(@RegClave, 21, 4) + '-' + SUBSTRING(@RegClave, 19, 2) + '-' + SUBSTRING(@RegClave, 17, 2), 102),
	           @SucursalBco = SUBSTRING(@RegClave, 29, 4), @Descripcion = SUBSTRING(@RegClave, 33, 40), 
		   @Tipo 		= CASE SUBSTRING(@RegClave, 73, 1) WHEN '+' THEN 'Cargo' WHEN '-' THEN 'Abono' ELSE NULL END,
		   @Importe 	= CONVERT(decimal, SUBSTRING(@RegClave, 74, 14))/100,
		   @Referencia 	= SUBSTRING(@RegClave, 102, 8),
		   @Concepto 	= SUBSTRING(@RegClave, 110, 40)

	IF @@ERROR <> 0
	BEGIN
		SELECT @resultado = 'Los datos del archivo seleccionado no tienen el formato prestablecido, favor de verificar' 
		SELECT @ContinuaProc = 0 
		BREAK
	END

	--Checa y recupera los datos referentes a la cuenta
	IF @NoCuenta <> @NoUltCuenta
	BEGIN
		SELECT @CtaDinero = CtaDinero, @Empresa = Empresa, @Moneda = Moneda
		  FROM CtaDinero
		 WHERE Institucion = @Institucion AND UPPER(NumeroCta) = UPPER(@NoCuenta)

		SELECT @MovCargoBancario 	  = BancoCargoBancario,	
			   @MovAbonoBancario	  = BancoAbonoBancario, 
			   @BancoCargoBancarioIVA = BancoCargoBancarioIVA, 
			   @BancoCheque			  = BancoCheque
		  FROM EmpresaCfgMov
		 WHERE Empresa = @Empresa

		SELECT @ConcPorSucs = ISNULL(DineroConciliarPorSucursales, 0)
	          FROM EmpresaCfg
		 WHERE Empresa = @Empresa
				
		SELECT @NoUltCuenta = @NoCuenta
	END

		-- busca el registro en la bd para conciliarlo
	SELECT @AuxiliarID = NULL
	SELECT @Mov = RTRIM(LTRIM(Mov)), @FormaPago = FormaPago 
	  FROM CfgMovConciliar 
	 WHERE Institucion = @Institucion 
	   AND RTRIM(LTRIM(MovEquivalente)) = RTRIM(LTRIM(@Descripcion)) AND estatus = 'A'

	IF @mov NOT IN (@MovCargoBancario, @BancoCargoBancarioIVA) 
	BEGIN
		IF @mov = @BancoCheque
		BEGIN
			IF @Tipo = 'Abono'
 				SELECT @AuxiliarID = MIN(a.ID)
				  FROM Auxiliar a
				 WHERE a.Empresa = @Empresa AND a.Modulo = 'DIN' AND a.Cuenta = @CtaDinero AND ROUND(a.Abono, 2) = @Importe
				   AND a.Conciliado = 0 AND a.EsCancelacion = 0 
				   AND (@ConciliarPorSucursales = 0 OR (@SucursalBco IN (SELECT sb.Numero FROM SucursalBanco sb WHERE sb.Sucursal = a.Sucursal AND sb.Institucion = @Institucion)))

			IF @Tipo = 'Cargo'
				SELECT @AuxiliarID = MIN(a.ID)
				  FROM Auxiliar a
				 WHERE a.Empresa = @Empresa AND a.Modulo = 'DIN' AND a.Cuenta = @CtaDinero AND ROUND(a.Cargo, 2) = @Importe
				   AND a.Conciliado = 0 AND a.EsCancelacion = 0 
				   AND (@ConciliarPorSucursales = 0 OR (@SucursalBco IN (SELECT sb.Numero FROM SucursalBanco sb WHERE sb.Sucursal = a.Sucursal AND sb.Institucion = @Institucion)))
		END
		ELSE
		BEGIN
			IF @Tipo = 'Abono'
				SELECT @AuxiliarID = Min(a.ID)
				  FROM Auxiliar a
				 WHERE a.Empresa = @Empresa AND a.Modulo = 'DIN' AND a.Cuenta = @CtaDinero AND ROUND(a.Abono, 2) = @Importe
				   AND a.Conciliado = 0 AND a.EsCancelacion = 0 AND a.Fecha = CONVERT(smalldatetime, @Fecha, 102) 
				   AND (@ConciliarPorSucursales = 0 OR (@SucursalBco IN (SELECT sb.Numero FROM SucursalBanco sb WHERE sb.Sucursal = a.Sucursal AND sb.Institucion = @Institucion)))

			IF @Tipo = 'Cargo'
				SELECT @AuxiliarID = Min(a.ID)
				  FROM Auxiliar a
				 WHERE a.Empresa = @Empresa AND a.Modulo = 'DIN' AND a.Cuenta = @CtaDinero AND ROUND(a.Cargo, 2) = @Importe
				   AND a.Conciliado = 0 AND a.EsCancelacion = 0 AND a.Fecha = CONVERT(smalldatetime, @Fecha, 102) 
				   AND (@ConciliarPorSucursales = 0 OR (@SucursalBco IN (SELECT sb.Numero FROM SucursalBanco sb WHERE sb.Sucursal = a.Sucursal AND sb.Institucion = @Institucion)))
		END

		IF @Tipo is NULL
		BEGIN
			CONTINUE
		END
	END
		
	IF @Mov IN (@MovCargoBancario, @BancoCargoBancarioIVA) 
	BEGIN
		IF @Tipo = 'Abono'
		BEGIN
			SELECT @AuxiliarID = Min(a.ID)
			  FROM Auxiliar a
			 WHERE a.Empresa = @Empresa AND a.Modulo = 'DIN' AND a.Cuenta = @CtaDinero AND a.Abono BETWEEN (@Importe - 0.02) AND (@Importe + 0.02)
			   AND a.Conciliado = 0 AND a.EsCancelacion = 0 AND a.Fecha = CONVERT(smalldatetime, @Fecha, 102) 
			   AND (@ConciliarPorSucursales = 0 OR (@SucursalBco IN (SELECT sb.Numero FROM SucursalBanco sb WHERE sb.Sucursal = a.Sucursal AND sb.Institucion = @Institucion)))
			SELECT @ImpOper = Abono FROM Auxiliar WHERE id = @AuxiliarID
		END
		IF @Tipo = 'Cargo'
		BEGIN
			SELECT @AuxiliarID = Min(a.ID)
			  FROM Auxiliar a
			 WHERE a.Empresa = @Empresa AND a.Modulo = 'DIN' AND a.Cuenta = @CtaDinero AND a.Cargo BETWEEN (@Importe - 0.02) AND (@Importe + 0.02)
			   AND a.Conciliado = 0 AND a.EsCancelacion = 0 AND a.Fecha = CONVERT(smalldatetime,@Fecha,102) 
			   AND (@ConciliarPorSucursales = 0 OR (@SucursalBco IN (SELECT sb.Numero FROM SucursalBanco sb WHERE sb.Sucursal = a.Sucursal AND sb.Institucion = @Institucion)))
			SELECT @ImpOper = Cargo FROM Auxiliar WHERE id = @AuxiliarID
		END
		IF @Tipo IS NULL
		BEGIN
			CONTINUE
		END
		IF 	@AuxiliarID IS NOT NULL AND @ImpOper <> @Importe
		BEGIN
			SELECT @ImpDiferencia = @Importe - @ImpOper
			SELECT @ImpTotDiferencias = @ImpTotDiferencias + @ImpDiferencia
		END
	END

	--Si existe el registro, lo Actualiza como conciliado, en caso contrario, inserta el registro en La tabla dinero como 'BORRADOR'
	IF @AuxiliarID IS NOT NULL
	BEGIN
		UPDATE Auxiliar 
		   SET Conciliado = 1, FechaConciliacion = @Hoy, @ModuloID = ModuloID  
		 WHERE ID = @AuxiliarID
			
		UPDATE Dinero
	    	   SET InstitucionSucursal    = @SucursalBco,
			InstitucionReferencia1 = @Referencia,
			InstitucionReferencia2 = @Concepto
		 WHERE ID = @ModuloID
		SELECT @RegsConc = @RegsConc + 1
	END
	ELSE
	BEGIN
		SELECT @DineroSucursal = NULL
		IF @ConciliarPorSucursales = 1
			SELECT @DineroSucursal = Min (Sucursal) 
			  FROM SucursalBanco 
			 WHERE Institucion = @Institucion AND Numero = @SucursalBco

		IF NOT EXISTS(SELECT * FROM Dinero WHERE Sucursal = ISNULL(@DineroSucursal, Sucursal) AND Empresa = @Empresa AND Mov = @Mov AND CtaDinero = @CtaDinero AND ISNULL(Importe, 0)+ISNULL(Impuestos,0) = @Importe AND Estatus = 'SINAFECTAR' AND FechaConciliacion = convert(smalldatetime,@Hoy,102))
		BEGIN
			INSERT Dinero (Sucursal, Empresa, Mov, FechaEmision, Moneda, TipoCambio, Usuario, Observaciones, Estatus, CtaDinero, Importe, ConDesglose, FormaPago, InstitucionMensaje, InstitucionSucursal, InstitucionReferencia1, InstitucionReferencia2, FechaConciliacion, AutoConciliar)
			SELECT ISNULL(@DineroSucursal, @Sucursal), @Empresa, @Mov, @Fecha, @Moneda, Mon.TipoCambio, @Usuario, @Descripcion, 'SINAFECTAR', @CtaDinero, @Importe, 0, @FormaPago, @Referencia , @SucursalBco, @Referencia, @Concepto, @Hoy, 1
   			  FROM Mon
			 WHERE Mon.Moneda = @Moneda
			SELECT @RegsNoConc = @RegsNoConc + 1
		END
	END
	FETCH NEXT FROM crListaSt INTO @RegClave
END
CLOSE crListaSt
DEALLOCATE crListaSt
	
--Finalmente inserta, si lo hay, el registro con las diferencias acumuladas por el concepto de cargos bancarios e iva.
IF @ContinuaProc = 1
BEGIN
	IF @ImpTotDiferencias > 0
		INSERT Dinero (Sucursal, Empresa, Mov, FechaEmision, Moneda, TipoCambio, Usuario, Observaciones, Estatus, CtaDinero, Importe, ConDesglose, InstitucionMensaje, InstitucionSucursal, InstitucionReferencia1, InstitucionReferencia2, FechaConciliacion, AutoConciliar)
		SELECT ISNULL(@DineroSucursal, @Sucursal), @Empresa, @MovAbonoBancario, @Fecha, @Moneda, Mon.TipoCambio, @Usuario, @Descripcion, 'SINAFECTAR', @CtaDinero, @ImpTotDiferencias, 0, @Referencia , @SucursalBco, @Referencia, @Concepto, @Hoy, 1
		  FROM Mon
		 WHERE Mon.Moneda = @Moneda

	IF @ImpTotDiferencias < 0
		INSERT Dinero (Sucursal, Empresa, Mov, FechaEmision, Moneda, TipoCambio, Usuario, Observaciones, Estatus, CtaDinero, Importe, ConDesglose, InstitucionMensaje, InstitucionSucursal, InstitucionReferencia1, InstitucionReferencia2, FechaConciliacion, AutoConciliar)
		SELECT ISNULL(@DineroSucursal, @Sucursal), @Empresa, @MovCargoBancario, @Fecha, @Moneda, Mon.TipoCambio, @Usuario, @Descripcion, 'SINAFECTAR', @CtaDinero, -1*(@ImpTotDiferencias), 0, @Referencia , @SucursalBco, @Referencia, @Concepto, @Hoy, 1
		  FROM Mon
		 WHERE Mon.Moneda = @Moneda
	COMMIT TRANSACTION
	SELECT @Resultado='El proceso termino correctamente, se conciliaron ' + CONVERT(varchar,@RegsConc)+ ' registros y ' + CONVERT(varchar,@RegsNoConc)+ ' se generaron sin afectar'
END
ELSE
	ROLLBACK TRANSACTION
SELECT @Resultado
RETURN
END
GO
