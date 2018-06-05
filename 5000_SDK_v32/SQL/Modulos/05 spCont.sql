/* SP CONTABILIDAD   */

-- CONT.P  = Poliza
-- CONT.C  = Poliza de Cierre
-- CONT.PR = Presupuesto

/**************** spContRegCancelar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContRegCancelar') and type = 'P') drop procedure dbo.spContRegCancelar
GO
CREATE PROCEDURE spContRegCancelar
    		    @ID		int,

    		    @Ok		int          OUTPUT,
    		    @OkRef	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  INSERT ContReg (
         ID, Empresa, Sucursal, Modulo, ModuloID, ModuloRenglon, ModuloRenglonSub, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  Haber)
  SELECT ID, Empresa, Sucursal, Modulo, ModuloID, ModuloRenglon, ModuloRenglonSub, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, -Debe, -Haber
    FROM ContReg
   WHERE ID = @ID
  RETURN
END
GO

/**************** spContMovReg ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContMovReg') and type = 'P') drop procedure dbo.spContMovReg
GO
CREATE PROCEDURE spContMovReg
    		    @ID		int,

    		    @Ok		int          OUTPUT,
    		    @OkRef	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Modulo		char(5), 
    @ModuloID		int,
    @UltModulo		char(5), 
    @UltModuloID	int,
    @ModuloRenglon	float, 
    @ModuloRenglonSub	int

  SELECT @UltModulo = NULL, @UltModuloID = NULL
  DECLARE crContReg CURSOR FOR 
   SELECT Modulo, ModuloID, ModuloRenglon, ISNULL(ModuloRenglonSub, 0)
     FROM ContReg
    WHERE ID = @ID AND Modulo IS NOT NULL AND ModuloID IS NOT NULL --AND ModuloRenglon IS NOT NULL

  OPEN crContReg
  FETCH NEXT FROM crContReg INTO @Modulo, @ModuloID, @ModuloRenglon, @ModuloRenglonSub
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @Modulo <> @UltModulo OR @ModuloID <> @UltModuloID
      BEGIN
        EXEC spMovReg  @Modulo, @ModuloID
        SELECT @UltModulo = @Modulo, @UltModuloID = @ModuloID
      END
      IF @ModuloRenglon IS NOT NULL
        EXEC spMovDReg @Modulo, @ModuloID, @ModuloRenglon, @ModuloRenglonSub
    END
    FETCH NEXT FROM crContReg INTO @Modulo, @ModuloID, @ModuloRenglon, @ModuloRenglonSub
  END  -- While
  CLOSE crContReg
  DEALLOCATE crContReg


  RETURN
END
GO

/**************** spContSocio ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContSocio') and type = 'P') drop procedure dbo.spContSocio
GO
CREATE PROCEDURE spContSocio
    		    @ID		int,
		    @Empresa	char(5),

    		    @Ok		int          OUTPUT,
    		    @OkRef	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  IF (SELECT ISNULL(ContSocios, 0) FROM EmpresaGral WHERE Empresa = @Empresa) = 1
  BEGIN
    DELETE ContSocio WHERE ID = @ID
    INSERT ContSocio (ID, Socio, Participacion)
    SELECT @ID, Socio, Participacion
      FROM EmpresaSocio
     WHERE Empresa = @Empresa

    IF (SELECT SUM(Participacion) FROM ContSocio WHERE ID = @ID) <> 100.0 SELECT @Ok = 50180
  END
  RETURN
END
GO

/**************** spContVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContVerificar') and type = 'P') drop procedure dbo.spContVerificar
GO
CREATE PROCEDURE spContVerificar
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
                    @ContMoneda			char(10),
		    @Estatus			char(15),
		    @AfectarPresupuesto		varchar(30),	

		    @FechaContable		datetime,
		    @CfgVerificarIVA		bit,
		    @CfgCentrosCostos		bit,
                    @CfgToleraciaRedondeo	float,
		    @CfgRegistro		bit,

		    @Ejercicio			int,
		    @Periodo			int,
		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,

    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Presupuesto		bit,
    @Renglon			float,
    @RenglonSub			int,
    @UltRenglon			float,
    @UltRenglonSub		int,
    @Cuantos			int,
    @Cuenta			char(20),
    @SubCuenta			varchar(50),
    @Debe			money,
    @Debe2			money,
    @Haber			money,
    @Haber2			money,
    @UltDebe			money,
    @UltDebe2			money,
    @UltHaber			money,
    @UltHaber2			money,
    @EsAcumulativa		bit,
    @CentrosCostos		bit,
    @CentroCostosRequerido	bit,
    @IVATipo			char(20),
    @IVAPorcentaje		float,
    @SumaIVA			money,
    @SumaCausanIVA		money,
    @SumaDebe 			money,
    @SumaDebe2 			money,
    @SumaDebeReg		money,
    @SumaHaber  		money,
    @SumaHaber2  		money,
    @SumaHaberReg  		money,
    @Dif			money,
    @Dif2			money,
    @RedondeoMonetarios		int,
    @ContactoTipo		varchar(20),
    @Contacto			varchar(10),
    @CfgCuentaCuadre		varchar(20),
    @CfgToleranciaCuadre	float,
    @CentrosCostos2		bit,
    @SubCuenta2			varchar(50),
    @CentroCostosRequerido2	bit,
    @CentrosCostos3		bit,
    @SubCuenta3			varchar(50),
    @CentroCostosRequerido3	bit,
	@Campo				varchar(20),
	@Origen				varchar(20),
	@OrigenID			varchar(20),
	@OrigenTipo			varchar(20),
	@ContXAfectar		bit,
    @CentroCostosOmision	varchar(20)

  SELECT @RedondeoMonetarios = dbo.fnRedondeoMonetarios()
--  IF @MovMoneda <> @ContMoneda OR @MovTipoCambio <> 1.0 SELECT @Ok = 30040

  SELECT @ContXAfectar = ContXAfectar FROM EmpresaGral WHERE Empresa = @Empresa

  SELECT @CfgCuentaCuadre    = NULLIF(RTRIM(ContCuentaCuadre), ''),
         @CfgToleranciaCuadre= ISNULL(ContToleranciaCuadre, 0.0)
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  IF @Accion IN ('CANCELAR', 'DESAFECTAR')
  BEGIN
    -- Checar que se haya capturado el movimiento en este modulo
    IF @Conexion = 0 
      IF (EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo) OR
         (SELECT ISNULL(NULLIF(RTRIM(OrigenTipo), ''), @Modulo) FROM Cont WHERE ID = @ID) <> @Modulo) AND
         (SELECT ContPermitirCancelacionOrigen FROM EmpresaCfg WHERE Empresa = @Empresa) = 0
        IF @Accion = 'CANCELAR'   SELECT @Ok = 60070 ELSE 
        IF @Accion = 'DESAFECTAR' SELECT @Ok = 60075
  END
  
  IF @Accion = 'AFECTAR' AND @Estatus = 'SINAFECTAR' AND @MovTipo = 'CONT.P' AND @Modulo = 'CONT' AND @ContXAfectar = 0
  BEGIN
    SELECT @Origen = Origen,@OrigenID = OrigenID, @OrigenTipo = OrigenTipo FROM Cont WHERE ID = @ID
    
    --REQ25300
    IF (SELECT SUM(Debe) FROM ContD WHERE ID = @ID) < 0 AND (SELECT SUM(Haber) FROM ContD WHERE ID = @ID) < 0 AND @OrigenTipo != 'CTRL/E' AND @OrigenTipo != 'CONTP'
    BEGIN
      IF NOT EXISTS(SELECT SUM(d.Debe),SUM(d.Haber) 
                FROM Cont c 
                   JOIN ContD d ON c.ID = d.ID
               WHERE c.Origen = @Origen
                 AND c.OrigenID = @OrigenID
                 AND c.OrigenTipo = @OrigenTipo
                 AND c.Estatus = 'CONCLUIDO'
                 AND c.ID <> @ID 
              HAVING SUM(d.Debe) > 0 AND SUM(d.Haber) > 0)
         SELECT @Ok = 10065, @OkRef = 'El Movimiento: '+RTRIM(@Origen)+' '+RTRIM(@OrigenID)+' No tiene una Poliza en Estatus Concluido'
    END
  END
  
  /** JH 08.08.2006 **/  
  IF @MovTipo = 'CONT.PR' AND @AfectarPresupuesto <> 'ASIGNAR' AND @Ok IS NULL 
    SELECT @Ok = 50120

  IF @Ok IS NULL
  BEGIN  
    SELECT @ContactoTipo = NULLIF(RTRIM(ContactoTipo), ''),
           @Contacto = NULLIF(RTRIM(Contacto), '')
      FROM Cont
     WHERE ID = @ID

    SELECT @SumaDebe      = 0.0,
           @SumaDebe2     = 0.0,
	   @SumaHaber     = 0.0,
	   @SumaHaber2    = 0.0,
           @SumaIVA       = 0.0,
           @SumaCausanIVA = 0.0,
           @Cuantos	  = 0

    DECLARE crContVerificar CURSOR
       FOR SELECT ContD.Renglon, ContD.RenglonSub, NULLIF(RTRIM(ContD.Cuenta), ''), NULLIF(RTRIM(ContD.SubCuenta), ''), ISNULL(ContD.Debe, 0.0), ISNULL(ContD.Haber, 0.0), ISNULL(ContD.Debe2, 0.0), ISNULL(ContD.Haber2, 0.0), ContD.Presupuesto, Cta.EsAcumulativa, Cta.CentrosCostos, Cta.CentroCostosRequerido, NULLIF(RTRIM(ContD.SubCuenta2),''), NULLIF(RTRIM(ContD.SubCuenta3),''), ISNULL(ContD.Debe, 0.0), ISNULL(ContD.Haber, 0.0), ISNULL(ContD.Debe2, 0.0), ISNULL(ContD.Haber2, 0.0), ContD.Presupuesto, Cta.EsAcumulativa, Cta.CentrosCostos, Cta.CentroCostosRequerido, Cta.CentroCostos2, Cta.CentroCostosRequerido2, Cta.CentroCostos3, Cta.CentroCostosRequerido3, ContD.Campo
             FROM ContD, Cta
            WHERE ID = @ID 
              AND Cta.Cuenta = ContD.Cuenta

    OPEN crContVerificar
    FETCH NEXT FROM crContVerificar INTO @Renglon, @RenglonSub, @Cuenta, @SubCuenta, @Debe, @Haber, @Debe2, @Haber2, @Presupuesto, @EsAcumulativa, @CentrosCostos, @CentroCostosRequerido, @SubCuenta2, @SubCuenta3, @Debe, @Haber, @Debe2, @Haber2, @Presupuesto, @EsAcumulativa, @CentrosCostos, @CentroCostosRequerido, @CentrosCostos2, @CentroCostosRequerido2, @CentrosCostos3, @CentroCostosRequerido3, @Campo
    IF @@ERROR <> 0 SELECT @Ok = 1
    IF @@FETCH_STATUS = -1 SELECT @Ok = 60010

    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
      BEGIN
        IF ISNULL(@Debe,0.0) = 0.0 AND ISNULL(@Haber,0.0) = 0.0
		  SELECT @Ok = 40080, @OkRef = 'La Cuenta '+RTRIM(@Cuenta)+' tiene valor 0 en Debe y Haber'

        IF @Presupuesto IS NULL SELECT @Ok = 40190
        SELECT @Cuantos = @Cuantos + 1
        IF @Presupuesto = 0
        BEGIN
          IF @Cuenta IS NULL SELECT @OK = 40030
          IF @Debe  <> ROUND(@Debe, @RedondeoMonetarios)  OR @Haber  <> ROUND(@Haber, @RedondeoMonetarios) OR 
             @Debe2 <> ROUND(@Debe2, @RedondeoMonetarios) OR @Haber2 <> ROUND(@Haber2, @RedondeoMonetarios)  
          BEGIN
            SELECT @Debe  = ROUND(@Debe, @RedondeoMonetarios),  @Haber  = ROUND(@Haber, @RedondeoMonetarios),
                   @Debe2 = ROUND(@Debe2, @RedondeoMonetarios), @Haber2 = ROUND(@Haber2, @RedondeoMonetarios)
            UPDATE ContD 
               SET Debe  = NULLIF(@Debe, 0.0),  Haber  = NULLIF(@Haber, 0.0),
                   Debe2 = NULLIF(@Debe2, 0.0), Haber2 = NULLIF(@Haber2, 0.0)
             WHERE CURRENT OF crContVerificar
          END
          --IF @Debe<>0.0 AND @Haber<>0.0 SELECT @Ok = 50020  						-- Poliza con Errores
          IF @EsAcumulativa = 1 SELECT @Ok = 50060, @OkRef = 'Cuenta: '+RTRIM(@Cuenta)

          IF @CfgCentrosCostos = 1 AND @CentrosCostos = 1
          BEGIN
            IF @SubCuenta IS NULL 
            BEGIN
              IF @CentroCostosRequerido = 1 SELECT @Ok = 50030						-- Falta Indicar el Centro de Costos 
            END ELSE
            BEGIN
              IF NOT EXISTS(SELECT * FROM CtaSub WHERE Cuenta = @Cuenta AND SubCuenta = @SubCuenta)
              BEGIN
                IF EXISTS(SELECT * FROM CtaSub cs, CentroCostos cc WHERE cs.Cuenta = @Cuenta AND cs.SubCuenta=cc.CentroCostos)
                  SELECT @Ok = 50080									-- El Centro de Costos no Corresponde
                ELSE 
                  IF NOT EXISTS(SELECT * FROM CentroCostos WHERE CentroCostos = @SubCuenta AND EsAcumulativo = 0)
                    SELECT @Ok = 50080									-- El Centro de Costos no Corresponde
              END
            END            
          END ELSE 
            IF @SubCuenta IS NOT NULL SELECT @Ok = 50080							-- El Centro de Costos no Corresponde

	  --Centros Costos 2
          IF @CfgCentrosCostos = 1 AND @CentrosCostos2 = 1 --AND @Campo IN ('TOTAL IMPUESTO 1', 'TOTAL IMPUESTO 2', 'TOTAL IMPUESTO 3', 'TOTAL RETENCION 1', 'TOTAL RETENCION 2', 'TOTAL RETENCION 3', 'SUBTOTAL ARRASTRE', 'TOTAL ARRASTRE', 'TOTAL BRUTO ARRASTRE', 'DESCUENTO ARRASTRE')
          BEGIN
            IF @SubCuenta2 IS NULL 
            BEGIN
              IF @CentroCostosRequerido2 = 1 SELECT @Ok = 50030						-- Falta Indicar el Centro de Costos 
            END ELSE
            BEGIN
              IF NOT EXISTS(SELECT * FROM CtaSub2 WHERE Cuenta = @Cuenta AND SubCuenta2 = @SubCuenta2)
              BEGIN
                IF EXISTS(SELECT * FROM CtaSub2 cs, CentroCostos2 cc WHERE cs.Cuenta = @Cuenta AND cs.SubCuenta2=cc.CentroCostos2)
                  SELECT @Ok = 50080									-- El Centro de Costos no Corresponde
                ELSE 
                  IF NOT EXISTS(SELECT * FROM CentroCostos2 WHERE CentroCostos2 = @SubCuenta2 AND EsAcumulativo = 0)
                    SELECT @Ok = 50080									-- El Centro de Costos no Corresponde
              END
            END            
          END ELSE 
            IF @SubCuenta2 IS NOT NULL SELECT @Ok = 50080							-- El Centro de Costos no Corresponde

	  --Centros Costos 3
          IF @CfgCentrosCostos = 1 AND @CentrosCostos3 = 1  --AND @Campo IN ('TOTAL IMPUESTO 1', 'TOTAL IMPUESTO 2', 'TOTAL IMPUESTO 3', 'TOTAL RETENCION 1', 'TOTAL RETENCION 2', 'TOTAL RETENCION 3', 'SUBTOTAL ARRASTRE', 'TOTAL ARRASTRE', 'TOTAL BRUTO ARRASTRE', 'DESCUENTO ARRASTRE')
          BEGIN
            IF @SubCuenta3 IS NULL 
            BEGIN
              IF @CentroCostosRequerido3 = 1 SELECT @Ok = 50030						-- Falta Indicar el Centro de Costos 
            END ELSE
            BEGIN
              IF NOT EXISTS(SELECT * FROM CtaSub3 WHERE Cuenta = @Cuenta AND SubCuenta3 = @SubCuenta3)
              BEGIN
                IF EXISTS(SELECT * FROM CtaSub3 cs, CentroCostos3 cc WHERE cs.Cuenta = @Cuenta AND cs.SubCuenta3=cc.CentroCostos3)
                  SELECT @Ok = 50080									-- El Centro de Costos no Corresponde
                ELSE 
                  IF NOT EXISTS(SELECT * FROM CentroCostos3 WHERE CentroCostos3 = @SubCuenta3 AND EsAcumulativo = 0)
                    SELECT @Ok = 50080									-- El Centro de Costos no Corresponde
              END
            END            
          END ELSE 
            IF @SubCuenta3 IS NOT NULL SELECT @Ok = 50080							-- El Centro de Costos no Corresponde

          IF @CfgVerificarIVA = 1
          BEGIN
  	    -- Checar IVA
            SELECT @IVATipo = NULLIF(RTRIM(UPPER(Tipo)), ''), @IVAPorcentaje = ISNULL(Porcentaje, 0.0)
              FROM CtaIVA
             WHERE Cuenta = @Cuenta
            IF @IVATipo IS NOT NULL
              IF @IVATipo='IVA' 
                SELECT @SumaIVA = @SumaIVA + (@Debe - @Haber)
    	      ELSE
  	        SELECT @SumaCausanIVA = @SumaCausanIVA + ((@Debe - @Haber) * (@IVAPorcentaje / 100))
          END

  	  SELECT @UltRenglon = @Renglon, @UltRenglonSub = @RenglonSub, 
                 @UltDebe  = @Debe,  @UltHaber  = @Haber,
                 @UltDebe2 = @Debe2, @UltHaber2 = @Haber2

  	  -- Totalizar
          SELECT @SumaDebe   = @SumaDebe   + @Debe, 
                 @SumaHaber  = @SumaHaber  + @Haber,
		 @SumaDebe2  = @SumaDebe2  + @Debe2,
                 @SumaHaber2 = @SumaHaber2 + @Haber2
          IF @Ok IS NOT NULL AND @OkRef IS NULL 
            SELECT @OkRef = 'Cuenta: '+RTRIM(@Cuenta)
        END
      END
      FETCH NEXT FROM crContVerificar INTO @Renglon, @RenglonSub, @Cuenta, @SubCuenta, @Debe, @Haber, @Debe2, @Haber2, @Presupuesto, @EsAcumulativa, @CentrosCostos, @CentroCostosRequerido, @SubCuenta2, @SubCuenta3, @Debe, @Haber, @Debe2, @Haber2, @Presupuesto, @EsAcumulativa, @CentrosCostos, @CentroCostosRequerido, @CentrosCostos2, @CentroCostosRequerido2, @CentrosCostos3, @CentroCostosRequerido3, @Campo
      IF @@ERROR <> 0 SELECT @Ok = 1
    END  -- While
    CLOSE crContVerificar
    DEALLOCATE crContVerificar
    IF @Accion <> 'DESAFECTAR' 
    BEGIN
      SELECT @Dif = @SumaDebe-@SumaHaber
      IF @SumaDebe <> @SumaHaber AND @Ok IS NULL SELECT @Ok = 50010, @OkRef = 'Diferencia '+CONVERT(varchar, @Dif)     -- La poliza no Cuadra
      IF @Ok = 50010 AND ABS(@Dif) < @CfgToleraciaRedondeo
      BEGIN
        IF @UltDebe>0.0 
          SELECT @UltDebe = @UltDebe - @Dif, @SumaDebe = @SumaDebe - @Dif
        ELSE SELECT @UltHaber = @UltHaber + @Dif, @SumaHaber = @SumaHaber + @Dif
        IF @SumaDebe = @SumaHaber 
        BEGIN
	  UPDATE ContD SET Debe = NULLIF(@UltDebe, 0.0), Haber = NULLIF(@UltHaber, 0.0) WHERE ID = @ID AND Renglon = @UltRenglon AND RenglonSub = @UltRenglonSub
          SELECT @Ok = NULL
        END
      END ELSE
      IF @Ok = 50010 AND ABS(@Dif) <= @CfgToleranciaCuadre AND @CfgCuentaCuadre IS NOT NULL
      BEGIN
        IF @Dif > 0.0
        BEGIN
           INSERT ContD (
                  ID, Renglon,          Cuenta,           Haber, Sucursal,  SucursalContable) 
           SELECT @ID, @Renglon+2048.0, @CfgCuentaCuadre, @Dif,  @Sucursal, @Sucursal
           IF @CfgRegistro = 1 AND @MovTipo IN ('CONT.P', 'CONT.C') 
             INSERT ContReg (
                    ID,  Cuenta,           Haber, Sucursal,  Empresa) 
             SELECT @ID, @CfgCuentaCuadre, @Dif,  @Sucursal, @Empresa
        END ELSE
        BEGIN
           INSERT ContD (
                  ID, Renglon,          Cuenta,           Debe,   Sucursal,  SucursalContable) 
           SELECT @ID, @Renglon+2048.0, @CfgCuentaCuadre, -@Dif,  @Sucursal, @Sucursal
           IF @CfgRegistro = 1 AND @MovTipo IN ('CONT.P', 'CONT.C') 
             INSERT ContReg (
                    ID,  Cuenta,           Debe,  Sucursal,  Empresa) 
             SELECT @ID, @CfgCuentaCuadre, -@Dif, @Sucursal, @Empresa
        END

--JGD 25Abril2011 Ticket 2684
        SELECT @CentrosCostos = Cta.CentrosCostos,@CentroCostosRequerido = Cta.CentroCostosRequerido, @CentroCostosOmision = Cta.CentroCostosOmision
          FROM ContD, Cta
         WHERE ID = @ID AND ContD.Cuenta = @CfgCuentaCuadre
           AND Cta.Cuenta = ContD.Cuenta

        IF @CentrosCostos = 1 AND @CentroCostosRequerido = 1
          UPDATE ContD
             SET SubCuenta = @CentroCostosOmision
           WHERE ID = @ID AND ContD.Cuenta = @CfgCuentaCuadre
--Fin JGD 25Abril2011 Ticket 2684

        SELECT @Ok = NULL, @Dif = 0.0, @Cuantos = @Cuantos + 1
      END
      
      IF @Ok IS NULL
      BEGIN
        SELECT @Dif2 = @SumaDebe2-@SumaHaber2
        IF @SumaDebe2 <> @SumaHaber2 AND @Ok IS NULL SELECT @Ok = 50010, @OkRef = 'Diferencia Moneda Paralelo '+CONVERT(varchar, @Dif2)     -- La poliza no Cuadra
        IF @Ok = 50010 AND ABS(@Dif2) < @CfgToleraciaRedondeo
        BEGIN
          IF @UltDebe2>0.0 
            SELECT @UltDebe2 = @UltDebe2 - @Dif2, @SumaDebe2 = @SumaDebe2 - @Dif2
          ELSE SELECT @UltHaber2 = @UltHaber2 + @Dif2, @SumaHaber2 = @SumaHaber2 + @Dif2
          IF @SumaDebe2 = @SumaHaber2
          BEGIN
	    UPDATE ContD SET Debe2 = NULLIF(@UltDebe2, 0.0), Haber2 = NULLIF(@UltHaber2, 0.0) WHERE ID = @ID AND Renglon = @UltRenglon AND RenglonSub = @UltRenglonSub
            SELECT @Ok = NULL
          END
        END
      END
    END

    /** JH 08.08.2006 **/
    -- Se movio esta rutina al final para que verifique sobre las sumas redondeadas, si persiste el problema vamos a tener que ajustar la ultima linea de ContReg de igual forma como se hace en ContD
    IF @CfgRegistro = 1 AND @MovTipo IN ('CONT.P', 'CONT.C') AND @Ok IS NULL
    BEGIN
      IF EXISTS(SELECT * FROM ContReg WHERE ID = @ID)
      BEGIN
        SELECT @SumaDebeReg = SUM(Debe), @SumaHaberReg = SUM(Haber) FROM ContReg WHERE ID = @ID
        SELECT @Dif = ISNULL(@SumaDebe, 0.0)-ISNULL(@SumaDebeReg, 0.0)
        IF @Dif <> 0.0 SELECT @Ok = 50015
        IF @Ok = 50015 AND ABS(@Dif) < @CfgToleraciaRedondeo --AND @Accion = 'CANCELAR' 
          SELECT @Ok = NULL

        SELECT @Dif = ISNULL(@SumaHaber, 0.0)-ISNULL(@SumaHaberReg, 0.0)
        IF @Dif <> 0.0 SELECT @Ok = 50015
        IF @Ok = 50015 AND ABS(@Dif) < @CfgToleraciaRedondeo --AND @Accion = 'CANCELAR' 
          SELECT @Ok = NULL
      END
    END

    IF @Ok IS NULL AND @Cuantos <> (SELECT COUNT(*) FROM ContD WHERE ID = @ID) SELECT @Ok = 50070          -- Alguna de las Cuentas no Existe
    IF @Ok IS NULL AND ROUND(@SumaIVA, 0)<>ROUND(@SumaCausanIVA, 0) SELECT @Ok = 50040	     		   -- Poliza con Error de IVA
    IF @Ok IS NOT NULL RETURN 
  END
  IF @Ok IS NULL
    EXEC xpContVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
			 @ContMoneda, @Estatus, @FechaContable, @CfgVerificarIVA, @CfgCentrosCostos, @CfgToleraciaRedondeo, 
                         @Ejercicio, @Periodo, @Conexion, @SincroFinal, @Sucursal, @Ok OUTPUT, @OkRef OUTPUT
  RETURN
END
GO

/**************** fnDistribuirPresupuesto ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnDistribuirPresupuesto' AND type = 'TF') DROP FUNCTION fnDistribuirPresupuesto
GO
CREATE FUNCTION fnDistribuirPresupuesto (@Empresa char(5), @Sucursal int, @UEN int, @Rama char(5), @Moneda char(10), @Tipo varchar(50), @Cuenta varchar(20), @SubCuenta varchar(50), @Ejercicio int, @PeriodoD int, @AfectarPresupuesto varchar(30), @EsPositivo bit, @ImporteTotal money)
RETURNS @Resultado TABLE (Periodo int, Importe money)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Periodo		int,
    @Presupuesto	money, 
    @Reservado		money, 
    @Comprometido	money, 
    @Devengado		money, 
    @Ejercido		money, 
    @Disponible		money,
    @Monto		money,
    @Saldo		money,
    @Importe		money,
    @PresupuestoOtrosPeriodos	bit

  SELECT @Saldo = @ImporteTotal
  SELECT @PresupuestoOtrosPeriodos = PresupuestoOtrosPeriodos FROM Cta WHERE Cuenta = @Cuenta

  IF @PresupuestoOtrosPeriodos = 1
    DECLARE crPresupuesto CURSOR FOR
    SELECT Periodo, Presupuesto, Reservado, Comprometido, Devengado, Ejercido, ISNULL(Presupuesto, 0.0)-ISNULL(Reservado, 0.0)-ISNULL(Comprometido, 0.0)-ISNULL(Devengado, 0.0)-ISNULL(Ejercido, 0.0)
      FROM Presupuesto
      WHERE Empresa   = @Empresa 
        AND Rama      = @Rama 
        AND Moneda    = @Moneda 
        AND Tipo      = @Tipo
        AND Cuenta    = @Cuenta 
        AND SubCuenta = @SubCuenta
        AND UEN       = @UEN
        AND Ejercicio = @Ejercicio
      ORDER BY Periodo
  ELSE
    DECLARE crPresupuesto CURSOR FOR
    SELECT Periodo, Presupuesto, Reservado, Comprometido, Devengado, Ejercido, ISNULL(Presupuesto, 0.0)-ISNULL(Reservado, 0.0)-ISNULL(Comprometido, 0.0)-ISNULL(Devengado, 0.0)-ISNULL(Ejercido, 0.0)
      FROM Presupuesto
      WHERE Empresa   = @Empresa 
        AND Rama      = @Rama 
        AND Moneda    = @Moneda 
        AND Tipo      = @Tipo
        AND Cuenta    = @Cuenta 
        AND SubCuenta = @SubCuenta
        AND UEN       = @UEN
        AND Ejercicio = @Ejercicio
        AND Periodo   = @PeriodoD
      ORDER BY Periodo

  OPEN crPresupuesto
  FETCH NEXT FROM crPresupuesto INTO @Periodo, @Presupuesto, @Reservado, @Comprometido, @Devengado, @Ejercido, @Disponible
  WHILE @@FETCH_STATUS <> -1 AND @Saldo <> 0.0
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @AfectarPresupuesto = 'ASIGNAR'
        SELECT @Monto = @Disponible
      ELSE
      IF @AfectarPresupuesto = 'RESERVAR'
      BEGIN
        IF @EsPositivo = 1
          SELECT @Monto = @Disponible
        ELSE
          SELECT @Monto = @Reservado
      END ELSE
      IF @AfectarPresupuesto = 'COMPROMETER DIRECTO'
      BEGIN
        IF @EsPositivo = 1
          SELECT @Monto = @Disponible
        ELSE
          SELECT @Monto = @Comprometido
      END ELSE
      IF @AfectarPresupuesto = 'COMPROMETER RESERVADO'
      BEGIN
        IF @EsPositivo = 1
          SELECT @Monto = @Reservado
        ELSE
          SELECT @Monto = @Comprometido
      END ELSE
      IF @AfectarPresupuesto = 'DEVENGAR DIRECTO'
      BEGIN
        IF @EsPositivo = 1
          SELECT @Monto = @Disponible
        ELSE
          SELECT @Monto = @Devengado
      END ELSE
      IF @AfectarPresupuesto = 'DEVENGAR RESERVADO'
      BEGIN
        IF @EsPositivo = 1
          SELECT @Monto = @Reservado
        ELSE
          SELECT @Monto = @Devengado
      END ELSE
      IF @AfectarPresupuesto = 'DEVENGAR COMPROMETIDO'
      BEGIN
        IF @EsPositivo = 1
          SELECT @Monto = @Comprometido
        ELSE
          SELECT @Monto = @Devengado
      END ELSE
      IF @AfectarPresupuesto = 'EJERCER DIRECTO'
      BEGIN
        IF @EsPositivo = 1
          SELECT @Monto = @Disponible
        ELSE
          SELECT @Monto = @Ejercido
      END ELSE
      IF @AfectarPresupuesto = 'EJERCER RESERVADO'
      BEGIN
        IF @EsPositivo = 1
          SELECT @Monto = @Reservado
        ELSE
          SELECT @Monto = @Ejercido
      END ELSE
      IF @AfectarPresupuesto = 'EJERCER COMPROMETIDO'
      BEGIN
        IF @EsPositivo = 1
          SELECT @Monto = @Comprometido
        ELSE
          SELECT @Monto = @Ejercido
      END ELSE
      IF @AfectarPresupuesto = 'EJERCER DEVENGADO'
      BEGIN
        IF @EsPositivo = 1
          SELECT @Monto = @Devengado
        ELSE
          SELECT @Monto = @Ejercido
      END

      IF @Saldo > @Monto SELECT @Importe = @Monto ELSE SELECT @Importe = @Saldo
      IF @Importe <> 0.0
      BEGIN
        UPDATE @Resultado SET Importe = ISNULL(Importe, 0.0) + @Importe WHERE Periodo = @Periodo
        IF @@ROWCOUNT = 0
          INSERT @Resultado (Periodo, Importe) VALUES (@Periodo, @Importe)
        SELECT @Saldo = @Saldo - @Importe
      END
    END
    FETCH NEXT FROM crPresupuesto INTO @Periodo, @Presupuesto, @Reservado, @Comprometido, @Devengado, @Ejercido, @Disponible
  END  -- While
  CLOSE crPresupuesto
  DEALLOCATE crPresupuesto

  IF @Saldo <> 0.0 AND ISNULL(@PeriodoD, 0) > 0 
  BEGIN
    UPDATE @Resultado SET Importe = ISNULL(Importe, 0.0) + @Saldo WHERE Periodo = @PeriodoD
    IF @@ROWCOUNT = 0
      INSERT @Resultado (Periodo, Importe) VALUES (@PeriodoD, @Saldo)
  END
  RETURN
END
GO

/**************** spContExplotarPresupuesto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContExplotarPresupuesto') and type = 'P') drop procedure dbo.spContExplotarPresupuesto
GO             
CREATE PROCEDURE spContExplotarPresupuesto
    		   @ID                		int,
		   @Empresa			char(5),
		   @Sucursal			int,
                   @SucursalOrigen		int,
		   @SucursalContable		int,                 
		   @UEN				int,
                   @Moneda			char(10),
		   @FechaContable		datetime,
		   @Ejercicio			int,
		   @TipoPresupuesto		varchar(50),
		   @AfectarPresupuesto		varchar(30),

       		   @Ok                		int          OUTPUT,
    		   @OkRef             		varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Renglon	float,
    @Cuenta	varchar(20), 
    @SubCuenta	varchar(50),
    @SubCuenta2	varchar(50),
    @SubCuenta3	varchar(50),
    @Concepto	varchar(50),
    @Debe	money,
    @Haber	money,
    @Positivo	money,
    @Negativo	money,
    @PeriodoD	int

 DECLARE crContDPresupuesto CURSOR FOR 
  SELECT Renglon, NULLIF(RTRIM(Cuenta), ''), NULLIF(RTRIM(d.SubCuenta), ''), Concepto, ISNULL(Debe, 0.0), ISNULL(Haber, 0.0), NULLIF(Periodo, 0), NULLIF(RTRIM(d.SubCuenta2), ''), NULLIF(RTRIM(d.SubCuenta3), ''), SucursalContable -- BUG6900
    FROM ContD d
   WHERE ID = @ID AND Presupuesto = 1 AND RenglonSub = 0
  OPEN crContDPresupuesto
  FETCH NEXT FROM crContDPresupuesto INTO @Renglon, @Cuenta, @SubCuenta, @Concepto, @Debe, @Haber, @PeriodoD, @SubCuenta2, @SubCuenta3, @SucursalContable -- BUG6900
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    SELECT @Positivo = 0.0, @Negativo = 0.0
    IF @Debe  > 0.0 SELECT @Positivo = @Debe   ELSE
    IF @Debe  < 0.0 SELECT @Negativo = -@Debe  ELSE
    IF @Haber < 0.0 SELECT @Positivo = -@Haber ELSE
    IF @Haber > 0.0 SELECT @Negativo = @Haber

    IF @@FETCH_STATUS <> -2 AND @Cuenta IS NOT NULL AND (@Positivo>0.0 OR @Negativo>0.0) AND @Ok IS NULL
    BEGIN
      DELETE ContD WHERE CURRENT OF crContDPresupuesto
      IF @Positivo > 0.0
        INSERT ContD (
               ID,  Renglon,  RenglonSub, Cuenta,  SubCuenta,  SubCuenta2,  SubCuenta3, Concepto,  Debe,    Empresa,  Ejercicio,  Periodo, FechaContable,  Sucursal,  Presupuesto, SucursalContable,  SucursalOrigen)
        SELECT @ID, @Renglon, Periodo,    @Cuenta, @SubCuenta, @SubCuenta2, @SubCuenta3, @Concepto, Importe, @Empresa, @Ejercicio, Periodo, @FechaContable, @Sucursal, 1,           @SucursalContable, @SucursalOrigen
         FROM dbo.fnDistribuirPresupuesto (@Empresa, @SucursalContable, @UEN, 'CONT', @Moneda, @TipoPresupuesto, @Cuenta, @SubCuenta, @Ejercicio, @PeriodoD, @AfectarPresupuesto, 1, @Positivo)

      IF @Negativo > 0.0
        INSERT ContD (
               ID,  Renglon,  RenglonSub, Cuenta,  SubCuenta,  SubCuenta2,  SubCuenta3, Concepto,  Haber,   Empresa,  Ejercicio,  Periodo, FechaContable,  Sucursal,  Presupuesto, SucursalContable,  SucursalOrigen)
        SELECT @ID, @Renglon, Periodo,    @Cuenta, @SubCuenta, @SubCuenta2, @SubCuenta3, @Concepto, Importe, @Empresa, @Ejercicio, Periodo, @FechaContable, @Sucursal, 1,           @SucursalContable, @SucursalOrigen
         FROM dbo.fnDistribuirPresupuesto (@Empresa, @SucursalContable, @UEN, 'CONT', @Moneda, @TipoPresupuesto, @Cuenta, @SubCuenta, @Ejercicio, @PeriodoD, @AfectarPresupuesto, 0, @Negativo)
    END
    FETCH NEXT FROM crContDPresupuesto INTO @Renglon, @Cuenta, @SubCuenta, @Concepto, @Debe, @Haber, @PeriodoD, @SubCuenta2, @SubCuenta3, @SucursalContable -- BUG6900
  END  -- While
  CLOSE crContDPresupuesto
  DEALLOCATE crContDPresupuesto

--select * from contd where id = @id
  RETURN
END
GO

/**************** spContCopiar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContCopiar') and type = 'P') drop procedure dbo.spContCopiar
GO
CREATE PROCEDURE spContCopiar
                   @ID			int,
		   @Empresa		char(5),
		   @Usuario		char(10),
		   @Mov			char(20),
		   @Referencia		varchar(50),
		   @Voltear		bit,
		   @CopiarID		int	OUTPUT,
		   @EmpresaControladora	bit 	= 0,
		   @OrigenTipo		varchar(10)	= NULL,
                   @Origen		varchar(20)	= NULL,
		   @OrigenID		varchar(20)	= NULL,
		   @OrigenEmpresa	varchar(5)	= NULL,
		   @FactorIntegracion	float		= NULL
--//WITH ENCRYPTION
AS BEGIN
  INSERT Cont (
         Empresa,  Usuario,  Mov,  Referencia,  Estatus,      UltimoCambio, Sucursal, SucursalOrigen, SucursalDestino, FechaEmision, FechaContable, Concepto, Proyecto, UEN, Intercompania, Moneda, TipoCambio, Observaciones, OrigenEmpresa,  OrigenTipo,  Origen,  OrigenID,  FactorIntegracion)
  SELECT @Empresa, @Usuario, @Mov, @Referencia, 'SINAFECTAR', UltimoCambio, Sucursal, SucursalOrigen, SucursalDestino, FechaEmision, FechaContable, Concepto, Proyecto, UEN, Intercompania, Moneda, TipoCambio, Observaciones, @OrigenEmpresa, @OrigenTipo, @Origen, @OrigenID, @FactorIntegracion
    FROM Cont
   WHERE ID = @ID
  SELECT @CopiarID = SCOPE_IDENTITY()

  IF @Voltear = 0
  BEGIN
    INSERT ContD (
           ID,        Empresa,  Renglon, RenglonSub, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Campo, Concepto, Articulo, DepartamentoDetallista, ContactoEspecifico, Debe,			   Debe2,		     Haber,		       Haber2,			  SucursalContable, Sucursal, Presupuesto, Ejercicio, Periodo, FechaContable)
    SELECT @CopiarID, @Empresa, Renglon, RenglonSub, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Campo, Concepto, Articulo, DepartamentoDetallista, ContactoEspecifico, Debe*@FactorIntegracion, Debe2*@FactorIntegracion, Haber*@FactorIntegracion, Haber2*@FactorIntegracion, SucursalContable, Sucursal, Presupuesto, Ejercicio, Periodo, FechaContable
      FROM ContD
     WHERE ID = @ID

    INSERT ContReg (
           ID,        Empresa,  Sucursal, Modulo, ModuloID, ModuloRenglon, ModuloRenglonSub, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, Debe,			   Haber,		     ContactoEspecifico)
    SELECT @CopiarID, @Empresa, Sucursal, Modulo, ModuloID, ModuloRenglon, ModuloRenglonSub, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, Debe*@FactorIntegracion, Haber*@FactorIntegracion, ContactoEspecifico
      FROM ContReg
     WHERE ID = @ID
  END ELSE
  BEGIN
    INSERT ContD (
           ID,        Empresa,  Renglon, RenglonSub, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Campo, Concepto, Articulo, DepartamentoDetallista, ContactoEspecifico, Debe,			    Debe2,		       Haber,			 Haber2,		   SucursalContable, Sucursal, Presupuesto, Ejercicio, Periodo, FechaContable)
    SELECT @CopiarID, @Empresa, Renglon, RenglonSub, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Campo, Concepto, Articulo, DepartamentoDetallista, ContactoEspecifico, Haber*@FactorIntegracion, Haber2*@FactorIntegracion, Debe*@FactorIntegracion,  Debe2*@FactorIntegracion, SucursalContable, Sucursal, Presupuesto, Ejercicio, Periodo, FechaContable
      FROM ContD
     WHERE ID = @ID

    INSERT ContReg (
           ID,        Empresa,  Sucursal, Modulo, ModuloID, ModuloRenglon, ModuloRenglonSub, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, Debe,			    Haber,		     ContactoEspecifico)
    SELECT @CopiarID, @Empresa, Sucursal, Modulo, ModuloID, ModuloRenglon, ModuloRenglonSub, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, Haber*@FactorIntegracion, Debe*@FactorIntegracion, ContactoEspecifico
      FROM ContReg
     WHERE ID = @ID
  END

  IF @EmpresaControladora = 1
    INSERT ContSocio (ID, Socio, Participacion)
    SELECT @CopiarID, Socio, Participacion
      FROM ContSocio
     WHERE ID = @ID
  
  RETURN
END
GO

/**************** spContConsolidar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContConsolidar') and type = 'P') drop procedure dbo.spContConsolidar
GO
CREATE PROCEDURE spContConsolidar
			@OrigenEmpresa		varchar(5),
			@OrigenReferencia	varchar(50),
    			@Empresa		varchar(5),

			@ID			int,
    			@Modulo			char(5),
			@Accion			char(20),
			@Base			char(20),
			@FechaRegistro		datetime,
			@GenerarMov		char(20), 
			@Usuario		varchar(10),

    			@Conexion		bit,
			@SincroFinal		bit,
    			@Mov	      		varchar(20),
    			@MovID			varchar(20),
			@Ejercicio		int,
			@Periodo		int,
			@Intercompania		bit,
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CopiarID		int, 
    @CopiarMov		varchar(20),
    @Controladora      	varchar(5),
    @FactorIntegracion	float

  SELECT @Controladora = NULLIF(RTRIM(Controladora), ''), @FactorIntegracion = ISNULL(FactorIntegracion, 1.0) FROM Empresa WHERE Empresa = @Empresa
  IF @Controladora IS NOT NULL AND @Empresa <> @Controladora
  BEGIN
    SELECT @CopiarID = NULL, @CopiarMov = @Mov
    IF @Accion = 'AFECTAR'
      EXEC spContCopiar @ID, @Controladora, @Usuario, @CopiarMov, @OrigenReferencia, 0, @CopiarID OUTPUT, @EmpresaControladora = 1, @OrigenTipo = 'CTRL/E', @OrigenID = @ID, @OrigenEmpresa = @OrigenEmpresa, @FactorIntegracion = @FactorIntegracion
    ELSE BEGIN
      SELECT @CopiarID = ID FROM Cont WHERE Empresa = @Controladora AND Mov = @CopiarMov AND Referencia = @OrigenReferencia AND Estatus = 'CONCLUIDO' AND OrigenTipo = 'CTRL/E' AND OrigenID = CONVERT(varchar(10), @ID)
      IF @CopiarID IS NULL
        SELECT @CopiarID = MIN(ID) FROM Cont WHERE Empresa = @Controladora AND Mov = @CopiarMov AND Referencia = @OrigenReferencia AND Estatus = 'CONCLUIDO' AND Ejercicio = @Ejercicio AND Periodo = @Periodo 
    END

    IF @CopiarID IS NOT NULL
      EXEC spCont @CopiarID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, @Mov, @MovID, NULL, @Ok OUTPUT, @OkRef OUTPUT, @EmpresaControladora = 1

    IF @Intercompania = 1 AND @Ok IS NULL 
    BEGIN
      SELECT @CopiarID = NULL
      SELECT @CopiarMov = ContEliminacion FROM EmpresaCfgMov WHERE Empresa = @Empresa
      IF @Accion = 'AFECTAR'
        EXEC spContCopiar @ID, @Controladora, @Usuario, @CopiarMov, @OrigenReferencia, 1, @CopiarID OUTPUT, @EmpresaControladora = 1, @OrigenTipo = 'INTER/E', @OrigenID = @ID, @OrigenEmpresa = @OrigenEmpresa, @FactorIntegracion = @FactorIntegracion
      ELSE BEGIN
        SELECT @CopiarID = ID FROM Cont WHERE Empresa = @Controladora AND Mov = @CopiarMov AND Referencia = @OrigenReferencia AND Estatus = 'CONCLUIDO' AND OrigenTipo = 'INTER/E' AND OrigenID = CONVERT(varchar(10), @ID)
        IF @CopiarID IS NULL
          SELECT @CopiarID = MIN(ID) FROM Cont WHERE Empresa = @Controladora AND Mov = @CopiarMov AND Referencia = @OrigenReferencia AND Estatus = 'CONCLUIDO' AND Ejercicio = @Ejercicio AND Periodo = @Periodo 
      END
      IF @CopiarID IS NOT NULL
        EXEC spCont @CopiarID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, @Mov, @MovID, NULL, @Ok OUTPUT, @OkRef OUTPUT, @EmpresaControladora = 1
    END

    IF @Ok IS NULL AND (SELECT ISNULL(ConsolidacionEmpresas, 0) FROM EmpresaGral WHERE Empresa = @Controladora) = 1
      EXEC spContConsolidar @OrigenEmpresa, @OrigenReferencia, @Controladora, @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, @Mov, @MovID, @Ejercicio, @Periodo, @Intercompania, @Ok OUTPUT, @OkRef OUTPUT
  END
  RETURN
END
GO

-- select * from Presupuesto
/**************** spContAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContAfectar') and type = 'P') drop procedure dbo.spContAfectar
GO             
CREATE PROCEDURE spContAfectar
    		   @ID                		int,

		   @Accion			char(20),
    		   @Empresa	      		char(5),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20)         OUTPUT,
    		   @MovTipo     		char(20),
    		   @MovMoneda	      		char(10),
    		   @MovTipoCambio	      	float,

    		   @FechaEmision      		datetime,
		   @FechaContable		datetime,
    		   @Concepto	      		varchar(50),
    	 	   @Proyecto	      		varchar(50),
    		   @Usuario	      		char(10),
    		   @Autorizacion      		char(10),
    		   @Referencia	      		varchar(50),
    		   @UEN		      		int,		 		   
    		   @Observaciones     		varchar(255),
		   @AfectarPresupuesto		varchar(30),
    		   @Estatus           		char(15),
 	    	   @EstatusNuevo	      	char(15),
    		   @FechaRegistro     		datetime,
    		   @Ejercicio	      		int,
    		   @Periodo	      		int,

		   @ContMoneda			char(10), 
		   @ContTipoCambio		float, 
       		   @CtaContabilidad		char(20),
		   @CtaOrden			char(20),

		   @Conexion			bit,
		   @SincroFinal			bit,
                   @Sucursal			int,
                   @SucursalDestino		int,
                   @SucursalOrigen		int,

                   @CfgMoneda2Auto		bit,
		   @CfgMultiSucursal		bit,
		   @CfgRegistro			bit,
		   @OrigenTipo			char(10),
		   @Origen			char(20),
		   @OrigenID			varchar(20),

		   @GenerarID			int	     OUTPUT,

       		   @Ok                		int          OUTPUT,
    		   @OkRef             		varchar(255) OUTPUT,
		   @AfectarMoneda2		bit = 0,
		   @Base				char(20),	-- BUG13491
		   @GenerarMov			char(20),  	-- BUG13491
		   @CfgConsolidacion	bit,		-- BUG13491
		   @OrigenEmpresa		varchar(5),	-- BUG13491
		   @Intercompania		bit			-- BUG13491
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Ciclo		int,
    @Presupuesto	bit,
    @PeriodoD		int,
    @PeriodoPresupuesto int,
    @Cuenta		char(20), 
    @UltCuenta		char(20),
    @SubCuenta 		varchar(50),
    @UltSubCuenta 	varchar(50),
    @SubCuenta2 	varchar(50),
    @UltSubCuenta2 	varchar(50),
    @SubCuenta3 	varchar(50),
    @UltSubCuenta3 	varchar(50),
    @Debe		money, 
    @SumaDebe		money,
    @Haber		money,
    @Neto		money,
    @TipoPresupuesto	varchar(50),
    @ImportePresupuesto	money,
    @ImporteReservar	money,
    @ImporteComprometer	money,
    @ImporteDevengar	money,
    @ImporteEjercer	money,
    @EsCargo		bit,
    @TieneMovimientos	bit,
    @SinAuxiliares	bit,
    @FechaConclusion	datetime,
    @FechaCancelacion	datetime,
    @SucursalPrincipal	int,
    @IDOrigen		int,
    @MonedaOrigen	char(10),
    @SucursalContable	int,
    @SucursalSincro	int,
    @Renglon		float,
    @RenglonSub		int,
	@ContX			bit,
    @ContXAfectar	bit,
	@EstatusCuenta  varchar(10)

  SELECT @ContX = ISNULL(ContX, 0),
         @ContXAfectar = ContXAfectar
    FROM EmpresaGral
   WHERE Empresa = @Empresa

  SELECT @TipoPresupuesto = NULL,
         @SumaDebe	  = 0.0

  IF @AfectarMoneda2 = 0
  BEGIN    
    -- Asignar el Consecutivo al Movimiento
    SELECT @SucursalPrincipal = Sucursal FROM Version
    EXEC spMovConsecutivo @SucursalPrincipal, @SucursalPrincipal, @SucursalPrincipal, @Empresa, @Usuario, @Modulo, @Ejercicio, @Periodo, @ID, @Mov, NULL, @Estatus, @Concepto, @Accion, @Conexion, @SincroFinal, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

    IF @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') AND @Accion <> 'CANCELAR' AND @Ok IS NULL
      EXEC spMovChecarConsecutivo	@Empresa, @Modulo, @Mov, @MovID, NULL, @Ejercicio, @Periodo, @Ok OUTPUT, @OkRef OUTPUT

    IF @Accion IN ('CONSECUTIVO', 'SINCRO') AND @Ok IS NULL
    BEGIN
      SELECT @SucursalSincro = ISNULL(@SucursalDestino, @Sucursal)
      IF @Accion = 'SINCRO' EXEC spAsignarSucursalEstatus @ID, @Modulo, @SucursalSincro, @Accion
      SELECT @Ok = 80060, @OkRef = @MovID
      RETURN
    END
  END

  IF @OK IS NOT NULL RETURN 

  IF @Conexion = 0 
    BEGIN TRANSACTION

    IF @AfectarMoneda2 = 0
    BEGIN
      -- Poner el Estatus del Movimiento en "AFECTANDO"
      EXEC spMovEstatus @Modulo, 'AFECTANDO', @ID, 0, NULL, 0, @Ok OUTPUT

      -- Actualizar Sucursal Detalle
      IF @Accion = 'AFECTAR' AND @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
      BEGIN
        IF @CfgMultiSucursal = 0 
        BEGIN
          UPDATE ContD   SET SucursalContable = @Sucursal WHERE ID = @ID AND SucursalContable <> @Sucursal
          UPDATE ContReg SET Sucursal         = @Sucursal WHERE ID = @ID AND Sucursal <> @Sucursal
        END ELSE
        BEGIN
          UPDATE ContD   SET SucursalContable = @Sucursal WHERE ID = @ID AND SucursalContable IS NULL
          UPDATE ContReg SET Sucursal         = @Sucursal WHERE ID = @ID AND Sucursal IS NULL
        END
        IF (SELECT Sincro FROM Version) = 1
	--UPDATE ContD SET Sucursal = @Sucursal, SincroC = 1 WHERE ID = @ID AND (Sucursal <> @Sucursal OR SincroC <> 1)
          EXEC sp_executesql N'UPDATE ContD SET Sucursal = @Sucursal, SincroC = 1 WHERE ID = @ID AND (Sucursal <> @Sucursal OR SincroC <> 1)', N'@Sucursal int, @ID int', @Sucursal, @ID
      END 

      IF @Accion NOT IN ('CANCELAR', 'DESAFECTAR') 
        -- Registrar el Movimiento en "Mov"
        EXEC spRegistrarMovimiento @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @Ejercicio, @Periodo, @FechaRegistro, @FechaEmision,
                        	   @Concepto, @Proyecto, @MovMoneda, @MovTipoCambio,
                       	           @Usuario, @Autorizacion, @Referencia, @UEN, @Observaciones,
			           0, NULL, NULL, NULL,
				   @Ok OUTPUT
    END 
    IF @AfectarMoneda2 = 1 AND @CfgMoneda2Auto = 1
      EXEC xpContMoneda2Update @ID, @ContMoneda, @ContTipoCambio, @Ok OUTPUT, @OkRef OUTPUT

    IF @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') OR @Accion <> 'AFECTAR'
    BEGIN    
      IF @Accion = 'AFECTAR' 
      BEGIN
        IF @MovTipo = 'CONT.PR' 
          UPDATE ContD 
             SET Presupuesto = 1,
                 Empresa = @Empresa, 
                 Ejercicio = ISNULL(Ejercicio, @Ejercicio), 
                 Periodo = ISNULL(Periodo, @Periodo), 
                 FechaContable = @FechaContable
           WHERE ID = @ID
        ELSE 
          UPDATE ContD 
             SET Empresa = @Empresa, 
                 Ejercicio = ISNULL(Ejercicio, @Ejercicio), 
                 Periodo = ISNULL(Periodo, @Periodo), 
                 FechaContable = @FechaContable
           WHERE ID = @ID --AND Presupuesto = 0
      END

      IF (@MovTipo = 'CONT.PR' OR @AfectarPresupuesto <> 'NO') AND @Accion = 'AFECTAR' 
        EXEC spContExplotarPresupuesto @ID, @Empresa, @Sucursal, @SucursalOrigen, @SucursalContable, @UEN, @ContMoneda, @FechaContable, @Ejercicio, @TipoPresupuesto, @AfectarPresupuesto, @Ok OUTPUT, @OkRef OUTPUT

      EXEC xpContAfectarDetalleAntes @ID, @Accion, @Empresa, @Sucursal, @SucursalOrigen, @SucursalContable, @Usuario, @FechaContable, @FechaRegistro, @Ok OUTPUT, @OkRef OUTPUT
      DECLARE crContDetalle CURSOR
         FOR SELECT ISNULL(d.SucursalContable, @Sucursal), NULLIF(RTRIM(d.Cuenta), ''), NULLIF(RTRIM(d.SubCuenta), ''), NULLIF(RTRIM(d.SubCuenta2), ''), NULLIF(RTRIM(d.SubCuenta3), ''), ISNULL(CASE WHEN @AfectarMoneda2 = 1 THEN d.Debe2 ELSE d.Debe END, 0.0), ISNULL(CASE WHEN @AfectarMoneda2 = 1 THEN d.Haber2 ELSE d.Haber END, 0.0), NULLIF(d.Periodo, 0), d.Presupuesto, d.Renglon, d.RenglonSub
               FROM ContD d
               JOIN Cta ON Cta.Cuenta = d.Cuenta
              WHERE d.ID = @ID                
      OPEN crContDetalle
      FETCH NEXT FROM crContDetalle INTO @SucursalContable, @Cuenta, @SubCuenta, @SubCuenta2, @SubCuenta3, @Debe, @Haber, @PeriodoD, @Presupuesto, @Renglon, @RenglonSub
      IF @@ERROR <> 0 SELECT @Ok = 1

      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @Cuenta IS NOT NULL AND (@Debe<>0.0 OR @Haber<>0.0) AND @Ok IS NULL
        BEGIN
          IF @SucursalContable IS NULL SELECT @Ok = 10200
          SELECT @Neto     = @Debe - @Haber,
                 @SumaDebe = @SumaDebe + @Debe 
          IF @MovTipo = 'CONT.PR' OR (@Presupuesto = 1 AND @AfectarPresupuesto <> 'NO')
          BEGIN
            SELECT @ImportePresupuesto = NULL, @ImporteReservar = NULL, @ImporteEjercer = NULL
            SELECT @AfectarPresupuesto = ISNULL(NULLIF(RTRIM(@AfectarPresupuesto), ''), 'ASIGNAR')
/*
No
Asignar
Reservar
Comprometer Directo
Comprometer Reservado
Devengar Directo
Devengar Reservado
Devengar Comprometido
Ejercer Directo
Ejercer Reservado
Ejercer Comprometido
Ejercer Devengado
*/

            /*IF @MovTipo = 'CONT.PR' 
            BEGIN
              IF @PeriodoD IS NULL
              BEGIN
                SELECT @PeriodoD = @Periodo
                UPDATE ContD SET Periodo = @PeriodoD WHERE CURRENT OF crContDetalle
              END
              SELECT @ImportePresupuesto = @Neto, @PeriodoPresupuesto = @PeriodoD
            END ELSE 
            BEGIN*/
              SELECT @PeriodoPresupuesto = @PeriodoD
              IF @AfectarPresupuesto = 'ASIGNAR'               SELECT @ImportePresupuesto = @Neto ELSE
              IF @AfectarPresupuesto = 'RESERVAR'              SELECT @ImporteReservar    = @Neto ELSE
              IF @AfectarPresupuesto = 'COMPROMETER DIRECTO'   SELECT @ImporteComprometer = @Neto ELSE
              IF @AfectarPresupuesto = 'COMPROMETER RESERVADO' SELECT @ImporteComprometer = @Neto, @ImporteReservar    = -@Neto ELSE
              IF @AfectarPresupuesto = 'DEVENGAR DIRECTO'      SELECT @ImporteDevengar    = @Neto ELSE
              IF @AfectarPresupuesto = 'DEVENGAR RESERVADO'    SELECT @ImporteDevengar    = @Neto, @ImporteReservar    = -@Neto ELSE
              IF @AfectarPresupuesto = 'DEVENGAR COMPROMETIDO' SELECT @ImporteDevengar    = @Neto, @ImporteComprometer = -@Neto ELSE
              IF @AfectarPresupuesto = 'EJERCER DIRECTO'       SELECT @ImporteEjercer     = @Neto ELSE
              IF @AfectarPresupuesto = 'EJERCER RESERVADO'     SELECT @ImporteEjercer     = @Neto, @ImporteReservar    = -@Neto ELSE
              IF @AfectarPresupuesto = 'EJERCER COMPROMETIDO'  SELECT @ImporteEjercer     = @Neto, @ImporteComprometer = -@Neto ELSE
              IF @AfectarPresupuesto = 'EJERCER DEVENGADO'     SELECT @ImporteEjercer     = @Neto, @ImporteDevengar    = -@Neto

              IF @AfectarPresupuesto LIKE 'EJERCER%' AND @PeriodoPresupuesto > @Periodo 
                SELECT @Ok = 50170, @OkRef = 'Importe '+CONVERT(varchar, @Neto)+' / Periodo '+CONVERT(varchar, @PeriodoPresupuesto)
            /*END*/

--select @AfectarPresupuesto, @ImporteReservar, @ImportePresupuesto

            IF @Ok IS NULL
            BEGIN
              EXEC spPresupuesto @SucursalContable, @Empresa, @ContMoneda, 'CONT', @TipoPresupuesto, @Cuenta, @SubCuenta, @SubCuenta2, @SubCuenta3, @UEN, @ImportePresupuesto, @ImporteReservar, @ImporteComprometer, @ImporteDevengar, @ImporteEjercer, @Ejercicio, @PeriodoPresupuesto, @Accion, @Ok OUTPUT, @OkRef OUTPUT
              EXEC xpOk_50160 @Origen, @OrigenTipo, @Cuenta, @Ok OUTPUT
            END
          END ELSE
          BEGIN
            SELECT @SinAuxiliares = 0, @Ciclo = 0
	    -- Afectar la Cuenta
            WHILE @Cuenta IS NOT NULL AND @Ok IS NULL
            BEGIN
              SELECT @Ciclo = @Ciclo + 1
              IF @Ciclo > 50 SELECT @Ok = 44200

              IF @Debe <> 0.0
              BEGIN
               IF @Accion IN ('CANCELAR','DESAFECTAR') SELECT @EsCargo = 0 ELSE SELECT @EsCargo = 1
                 EXEC spSaldo @SucursalContable, @Accion, @Empresa, @Usuario, 'CONT', @ContMoneda, @ContTipoCambio, @Cuenta, @SubCuenta, NULL, NULL,
                              @Modulo, @ID, @Mov, @MovID, @EsCargo, @Debe, NULL, NULL,
                              @FechaContable, @Ejercicio, @Periodo, @Mov, @MovID, @SinAuxiliares, 0, 0,
                              @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub,
                              @SubCuenta2 = @SubCuenta2, @SubCuenta3 = @SubCuenta3, @Proyecto = @Proyecto, @UEN = @UEN
              END
              IF @Haber <> 0.0
              BEGIN
               IF @Accion IN ('CANCELAR','DESAFECTAR') SELECT @EsCargo = 1 ELSE SELECT @EsCargo = 0
                EXEC spSaldo @SucursalContable, @Accion, @Empresa, @Usuario, 'CONT', @ContMoneda, @ContTipoCambio, @Cuenta, @SubCuenta, NULL, NULL,
                             @Modulo, @ID, @Mov, @MovID, @EsCargo, @Haber, NULL, NULL,
                             @FechaContable, @Ejercicio, @Periodo, @Mov, @MovID, @SinAuxiliares, 0, 0,
                             @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub,
                             @SubCuenta2 = @SubCuenta2, @SubCuenta3 = @SubCuenta3, @Proyecto = @Proyecto, @UEN = @UEN
              END
              SELECT @UltCuenta = @Cuenta
              SELECT @Cuenta = NULLIF(RTRIM(Rama), ''), @TieneMovimientos = TieneMovimientos, @EstatusCuenta = Estatus  FROM Cta WHERE Cuenta = @Cuenta
              IF @@ERROR <> 0 SELECT @Ok = 1
				
			  IF @EstatusCuenta in ('BLOQUEADO','BAJA')
	             SELECT @Ok = 50070

              IF @TieneMovimientos = 0 
              BEGIN
                IF (SELECT TieneMovimientos FROM Cta WHERE Cuenta = @UltCuenta) = 0
                  UPDATE Cta SET TieneMovimientos = 1 WHERE Cuenta = @UltCuenta
              END

  	      SELECT @SinAuxiliares = 1
              IF UPPER(@Cuenta) IN (@CtaContabilidad, @CtaOrden) SELECT @Cuenta = NULL

            END

-- Afectar el Centro de Costos
            WHILE @SubCuenta IS NOT NULL AND @Ok IS NULL
            BEGIN
              IF @Debe <> 0.0
              BEGIN
               IF @Accion IN ('CANCELAR','DESAFECTAR') SELECT @EsCargo = 0 ELSE SELECT @EsCargo = 1
                 EXEC spSaldo @SucursalContable, @Accion, @Empresa, @Usuario, 'CC', @ContMoneda, @ContTipoCambio, @SubCuenta, NULL, NULL, NULL,
                              @Modulo, @ID, @Mov, @MovID, @EsCargo, @Debe, NULL, NULL,
                              @FechaContable, @Ejercicio, @Periodo, @Mov, @MovID, @SinAuxiliares, 0, 0,
                              @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub,
                              @Proyecto = @Proyecto, @UEN = @UEN
              END
              IF @Haber <> 0.0
              BEGIN
               IF @Accion IN ('CANCELAR','DESAFECTAR') SELECT @EsCargo = 1 ELSE SELECT @EsCargo = 0
                EXEC spSaldo @SucursalContable, @Accion, @Empresa, @Usuario, 'CC', @ContMoneda, @ContTipoCambio, @SubCuenta, NULL, NULL, NULL,
                             @Modulo, @ID, @Mov, @MovID, @EsCargo, @Haber, NULL, NULL,
                             @FechaContable, @Ejercicio, @Periodo, @Mov, @MovID, @SinAuxiliares, 0, 0,
                             @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub,
                             @Proyecto = @Proyecto, @UEN = @UEN
              END
              SELECT @UltSubCuenta = @SubCuenta
              SELECT @SubCuenta = NULLIF(RTRIM(Rama), ''), @TieneMovimientos = TieneMovimientos FROM CentroCostos WHERE CentroCostos = @SubCuenta
              IF @@ERROR <> 0 SELECT @Ok = 1

              IF @TieneMovimientos = 0 
              BEGIN
                IF (SELECT TieneMovimientos FROM CentroCostos WHERE CentroCostos = @UltSubCuenta) = 0
                  UPDATE CentroCostos SET TieneMovimientos = 1 WHERE CentroCostos = @UltSubCuenta
              END
            END

--Centro de costos 2
            WHILE @SubCuenta2 IS NOT NULL AND @Ok IS NULL
            BEGIN
              IF @Debe <> 0.0
              BEGIN
               IF @Accion IN ('CANCELAR','DESAFECTAR') SELECT @EsCargo = 0 ELSE SELECT @EsCargo = 1
                 EXEC spSaldo @SucursalContable, @Accion, @Empresa, @Usuario, 'CC2', @ContMoneda, @ContTipoCambio, @SubCuenta2, NULL, NULL, NULL,
                              @Modulo, @ID, @Mov, @MovID, @EsCargo, @Debe, NULL, NULL,
                              @FechaContable, @Ejercicio, @Periodo, @Mov, @MovID, @SinAuxiliares, 0, 0,
                              @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub,
                              @Proyecto = @Proyecto, @UEN = @UEN
              END
              IF @Haber <> 0.0
              BEGIN
               IF @Accion IN ('CANCELAR','DESAFECTAR') SELECT @EsCargo = 1 ELSE SELECT @EsCargo = 0
                EXEC spSaldo @SucursalContable, @Accion, @Empresa, @Usuario, 'CC2', @ContMoneda, @ContTipoCambio, @SubCuenta2, NULL, NULL, NULL,
                             @Modulo, @ID, @Mov, @MovID, @EsCargo, @Haber, NULL, NULL,
                             @FechaContable, @Ejercicio, @Periodo, @Mov, @MovID, @SinAuxiliares, 0, 0,
                             @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub,
                             @Proyecto = @Proyecto, @UEN = @UEN
              END
              SELECT @UltSubCuenta2 = @SubCuenta2
              SELECT @SubCuenta2 = NULLIF(RTRIM(Rama), ''), @TieneMovimientos = TieneMovimientos FROM CentroCostos2 WHERE CentroCostos2 = @SubCuenta2
              IF @@ERROR <> 0 SELECT @Ok = 1

              IF @TieneMovimientos = 0
              BEGIN
                IF (SELECT TieneMovimientos FROM CentroCostos2 WHERE CentroCostos2 = @UltSubCuenta2) = 0
                  UPDATE CentroCostos2 SET TieneMovimientos = 1 WHERE CentroCostos2 = @UltSubCuenta2
              END
            END

--centro de costos 3

          -- Afectar el Centro de Costos 3
            WHILE @SubCuenta3 IS NOT NULL AND @Ok IS NULL
            BEGIN
              IF @Debe <> 0.0
              BEGIN
               IF @Accion IN ('CANCELAR','DESAFECTAR') SELECT @EsCargo = 0 ELSE SELECT @EsCargo = 1
                 EXEC spSaldo @SucursalContable, @Accion, @Empresa, @Usuario, 'CC3', @ContMoneda, @ContTipoCambio, @SubCuenta3, NULL, NULL, NULL,
                              @Modulo, @ID, @Mov, @MovID, @EsCargo, @Debe, NULL, NULL,
                              @FechaContable, @Ejercicio, @Periodo, @Mov, @MovID, @SinAuxiliares, 0, 0,
                              @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub,
                              @Proyecto = @Proyecto, @UEN = @UEN
              END
              IF @Haber <> 0.0
              BEGIN
               IF @Accion IN ('CANCELAR','DESAFECTAR') SELECT @EsCargo = 1 ELSE SELECT @EsCargo = 0
                EXEC spSaldo @SucursalContable, @Accion, @Empresa, @Usuario, 'CC3', @ContMoneda, @ContTipoCambio, @SubCuenta3, NULL, NULL, NULL,
                             @Modulo, @ID, @Mov, @MovID, @EsCargo, @Haber, NULL, NULL,
                             @FechaContable, @Ejercicio, @Periodo, @Mov, @MovID, @SinAuxiliares, 0, 0,
                             @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub,
                             @Proyecto = @Proyecto, @UEN = @UEN
              END
              SELECT @UltSubCuenta3 = @SubCuenta3
              SELECT @SubCuenta3 = NULLIF(RTRIM(Rama), ''), @TieneMovimientos = TieneMovimientos FROM CentroCostos3 WHERE CentroCostos3 = @SubCuenta3
              IF @@ERROR <> 0 SELECT @Ok = 1
 
              IF @TieneMovimientos = 0
              BEGIN
                IF (SELECT TieneMovimientos FROM CentroCostos3 WHERE CentroCostos3 = @UltSubCuenta3) = 0
                  UPDATE CentroCostos3 SET TieneMovimientos = 1 WHERE CentroCostos3 = @UltSubCuenta3
              END
            END
--fin centro de costos 3


          END
        END
        IF @Ok IS NOT NULL AND @OkRef IS NULL
        BEGIN
          SELECT @OkRef = 'Cuenta: '+@Cuenta
          IF @SubCuenta IS NOT NULL SELECT @OkRef = @OkRef+ ' ('+@SubCuenta+')'
        END
        FETCH NEXT FROM crContDetalle INTO @SucursalContable, @Cuenta, @SubCuenta, @SubCuenta2, @SubCuenta3, @Debe, @Haber, @PeriodoD, @Presupuesto, @Renglon, @RenglonSub
        IF @@ERROR <> 0 SELECT @Ok = 1
      END  -- While
      CLOSE crContDetalle
      DEALLOCATE crContDetalle
    END

    IF @CfgRegistro = 1 
    BEGIN
      IF @Accion = 'DESAFECTAR'
        DELETE ContReg WHERE ID = @ID
      ELSE IF @Accion = 'CANCELAR'
        EXEC spContRegCancelar @ID, @Ok OUTPUT, @OkRef OUTPUT
      ELSE BEGIN
        IF @EstatusNuevo = 'CONCLUIDO' AND @MovTipo IN ('CONT.P', 'CONT.C')
        BEGIN
          IF @OrigenTipo IS NULL 
          BEGIN
            EXEC spMovReg @Modulo, @ID
            IF NOT EXISTS(SELECT * FROM ContReg WHERE ID = @ID)
              INSERT ContReg (
                     ID,  Empresa,  Sucursal,         Modulo,  ModuloID, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  Haber)
              SELECT @ID, @Empresa, SucursalContable, @Modulo, @ID,      Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  Haber
                FROM ContD
               WHERE ID = @ID
          END ELSE
            EXEC spContMovReg @ID, @Ok OUTPUT, @OkRef OUTPUT
        END
      END
    END

    IF @AfectarMoneda2 = 0
    BEGIN
      IF @Ok IS NULL
      BEGIN
        IF @EstatusNuevo = 'CANCELADO' SELECT @FechaCancelacion = @FechaRegistro ELSE SELECT @FechaCancelacion = NULL
        IF @EstatusNuevo = 'CONCLUIDO' SELECT @FechaConclusion  = @FechaEmision ELSE IF @EstatusNuevo <> 'CANCELADO' SELECT @FechaConclusion  = NULL
        EXEC spValidarTareas @Empresa, @Modulo, @ID, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
        UPDATE Cont 
           SET FechaConclusion  = @FechaConclusion, 
               FechaCancelacion = @FechaCancelacion,
               FechaContable    = @FechaContable,
               FechaEmision     = @FechaEmision,
               UltimoCambio     = /*CASE WHEN UltimoCambio IS NULL THEN */@FechaRegistro /*ELSE UltimoCambio END*/,
               Ejercicio        = @Ejercicio,
               Periodo          = @Periodo,
               Estatus          = @EstatusNuevo,
   	       Situacion 	= CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END,
               Concepto	        = @Concepto,
               Importe		= @SumaDebe
         WHERE ID = @ID 
        IF @@ERROR <> 0 SELECT @Ok = 1
      END

      SELECT @IDOrigen = NULL
      IF @Ok IS NULL
        EXEC spLigarMovCont @Accion, @Empresa, @OrigenTipo, @Origen, @OrigenID, @ID, @Mov, @MovID, @IDOrigen OUTPUT

      IF @OrigenTipo IS NOT NULL AND @Ok IS NULL
      BEGIN
        IF @IDOrigen IS NULL
          EXEC spMovEnMaxID @OrigenTipo, @Empresa, @Origen, @OrigenID, @IDOrigen OUTPUT, @Ok
        IF @IDOrigen IS NOT NULL
          EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @OrigenTipo, @IDOrigen, @Origen, @OrigenID, 'CONT', @ID, @Mov, @MovID, @Ok OUTPUT
      END

      -- Agregar a Estatus Log
      IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
        EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, NULL, @Ok OUTPUT, @OkRef OUTPUT

      -- Cancelar el Flujo
      IF @Accion = 'CANCELAR' AND @EstatusNuevo = 'CANCELADO' AND @Ok IS NULL
        EXEC spCancelarFlujo @Empresa, @Modulo, @ID, @Ok OUTPUT
    END

--select @Accion, @Empresa, @OrigenTipo, @Origen, @OrigenID, @ID, @Mov, @MovID
--select * from contd where id = @id
-- breakpoint
--if @ok is null select @ok = 1

--select * from saldo where rama = 'cont'

  -- BUG13491
  IF @CfgConsolidacion = 1 AND @OrigenEmpresa IS NULL AND @Accion IN ('AFECTAR', 'CANCELAR', 'DESAFECTAR') AND @Ok IS NULL 
  BEGIN
    SELECT @Referencia = RTRIM(@Mov)+' '+RTRIM(@MovID)+' ('+RTRIM(@Empresa)+')'
    EXEC spContConsolidar @Empresa, @Referencia, @Empresa, @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, 1, @SincroFinal, @Mov, @MovID, @Ejercicio, @Periodo, @Intercompania, @Ok OUTPUT, @OkRef OUTPUT
  END

  IF @Conexion = 0 
    IF @Ok IS NULL OR @Ok = 80030
      COMMIT TRANSACTION
    ELSE
      ROLLBACK TRANSACTION
 
  IF @Conexion = 1 AND @ContX = 1 AND @ContXAfectar = 1
    EXEC spOk_RAISERROR @Ok, @OkRef
    
  RETURN
END
GO

/**************** spCont ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCont') and type = 'P') drop procedure dbo.spCont
GO
CREATE PROCEDURE spCont
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
		   @GenerarID			int		OUTPUT,

		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT,
		   @EmpresaControladora		bit 	= 0,
		   @ContAuto			bit 	= 0,
		   @ModuloInicial       char(5) = NULL
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @CopiarID			int,
    @CopiarMov			varchar(20),
    @Sucursal			int,
    @SucursalDestino		int,
    @SucursalOrigen		int,
    @EnLinea			bit,
    @PuedeEditar		bit,
    @Empresa	      		char(5),
    @MovUsuario			char(10),
    @MovTipo   			char(20),
    @FechaEmision     		datetime,
    @FechaContable		datetime,
    @Concepto	      		varchar(50),
    @Proyecto	      		varchar(50),
    @MovMoneda	      		char(10),
    @MovTipoCambio	   	float,
    @Autorizacion     		char(10),
    @Referencia	      		varchar(50),
    @UEN	      		int,
    @Observaciones    		varchar(255),
    @Estatus          		char(15),
    @Ejercicio	      		int,
    @Periodo	      		int,
    @OrigenTipo			char(10),
    @Origen			char(20),
    @OrigenID			varchar(20),
    @Moneda2			varchar(10),
    @TipoCambio2		float,
    @Intercompania		bit,
    @SucursalPrincipal		int,
    @AfectarPresupuesto		varchar(30),
    @OrigenEmpresa		varchar(5),

    @ContMoneda		        char(10),
    @ContMoneda2	        char(10),
    @CfgMoneda2Auto		bit,
    @ContTipoCambio		float,
    @CfgVerificarIVA		bit,
    @CfgToleraciaRedondeo	float,
    @CfgCentrosCostos		bit,
    @CfgMultiSucursal		bit,
    @CfgConsolidacion		bit,
    @CfgRegistro		bit,
    @CfgContabilizarMesesFuturos bit,
    @CtaContabilidad		char(20),
    @CtaOrden			char(20),
    @ContX 			bit, 
    @ContXAfectar 		bit,

    @EstatusNuevo	      	char(15)/*,
    @Verificar			bit*/

  IF @Accion = 'CANCELAR'   SELECT @EstatusNuevo = 'CANCELADO' ELSE 
  IF @Accion = 'DESAFECTAR' SELECT @EstatusNuevo = 'SINAFECTAR' ELSE 

  SELECT @EstatusNuevo = 'CONCLUIDO'

  EXEC xpContAntes @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, @Mov, @MovID, @GenerarID, @Ok OUTPUT, @OkRef OUTPUT

  -- Leer Datos Generales del Movimiento
  SELECT @Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, @Empresa = Empresa, @MovID = MovID, @Mov = Mov, @FechaEmision = FechaEmision, @FechaContable = FechaContable, @Concepto = Concepto, @Proyecto = Proyecto,
         @MovUsuario = Usuario, @MovMoneda = Moneda, @MovTipoCambio = TipoCambio, @Autorizacion = Autorizacion, @Referencia = Referencia,
         @UEN = UEN, @Observaciones = Observaciones, @Estatus = UPPER(Estatus), @OrigenTipo = NULLIF(RTRIM(OrigenTipo), ''), @Origen = Origen, @OrigenID = OrigenID,
         @Moneda2 = Moneda2, @TipoCambio2 = TipoCambio2, @Intercompania = ISNULL(Intercompania, 0), @AfectarPresupuesto = ISNULL(NULLIF(RTRIM(UPPER(AfectarPresupuesto)), ''), 'NO'), @OrigenEmpresa = NULLIF(RTRIM(OrigenEmpresa), '')
    FROM Cont
   WHERE ID = @ID
  IF @@ERROR <> 0 SELECT @Ok = 1
  
  SELECT @CfgConsolidacion = ISNULL(ConsolidacionEmpresas, 0),
         @CfgContabilizarMesesFuturos = ISNULL(ContabilizarMesesFuturos, 0),
         @CfgRegistro = ISNULL(Registro, 0),
         @ContX = ISNULL(ContX, 0),
         @ContXAfectar = ContXAfectar
    FROM EmpresaGral
   WHERE Empresa = @Empresa
  IF @@ERROR <> 0 SELECT @Ok = 1

  SELECT @ContMoneda          = NULLIF(RTRIM(ContMoneda), ''),
         @ContMoneda2         = NULLIF(RTRIM(ContMoneda2), ''),
         @CfgMoneda2Auto      = ISNULL(ContMoneda2Auto, 0),
         @CtaContabilidad     = NULLIF(RTRIM(CtaContabilidad), ''),
         @CtaOrden            = NULLIF(RTRIM(CtaOrden), ''), 
         @CfgVerificarIVA	  = ContVerificarIVA,
         @CfgCentrosCostos    = ContCentrosCostos,
         @CfgMultiSucursal    = ISNULL(ContMultiSucursal, 0),
         @CfgToleraciaRedondeo= ISNULL(ContToleraciaRedondeo, 0.0)
    FROM EmpresaCfg
   WHERE Empresa = @Empresa
  IF @@ERROR <> 0 SELECT @Ok = 1      

  IF @ContX = 1 AND @ContXAfectar = 1 AND @@TRANCOUNT > 1
    SELECT @Conexion = 1

  SELECT @ContTipoCambio = 1.0

  EXEC spExtraerFecha @FechaEmision OUTPUT
  EXEC spExtraerFecha @FechaContable OUTPUT

  IF NULLIF(RTRIM(@Usuario), '') IS NULL SELECT @Usuario = @MovUsuario
  -- Leer MovTipo, Periodo y Ejercicio	
  EXEC spMovTipo @Modulo, @Mov, @FechaContable, @Empresa, @Estatus, @Concepto OUTPUT, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT
  IF @MovTipo = 'CONT.C' SELECT @Periodo = 13
  EXEC spMovOk @SincroFinal, @ID, @Estatus, @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @FechaContable, @FechaRegistro, @Ejercicio, @Periodo, @Proyecto, @Ok OUTPUT, @OkRef OUTPUT

  EXEC xpOk_60110 @Empresa, @Usuario, @Accion, @Modulo, @ID, @ModuloInicial, @Ok OUTPUT, @OkRef OUTPUT

--  IF @Accion = 'DESAFECTAR' AND @CfgRegistro = 1 SELECT @Ok = 60202
  IF @Ok IS NULL
  BEGIN
    IF @Accion = 'AFECTAR'
    BEGIN
      SELECT @SucursalPrincipal = ISNULL(Sucursal, 0) FROM Version
      IF @SucursalPrincipal > 0 
        IF (SELECT ISNULL(EnLinea, 0) FROM Sucursal WHERE Sucursal = @SucursalPrincipal) = 0
          SELECT @Accion = 'SINCRO'
    END

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
        EXEC spContVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, 
	  		     @MovMoneda, @MovTipoCambio, @ContMoneda, @Estatus, @AfectarPresupuesto,
			     @FechaContable, @CfgVerificarIVA, @CfgCentrosCostos, @CfgToleraciaRedondeo, @CfgRegistro,
                             @Ejercicio, @Periodo, @Conexion, @SincroFinal, @Sucursal,
			     @Ok OUTPUT, @OkRef OUTPUT
        IF @Ok IS NULL
        BEGIN
          SELECT @Estatus = 'SINAFECTAR'/*, @Verificar = 0*/
          EXEC spAsignarSucursalEstatus @ID, @Modulo, @Sucursal, @Estatus
        END
      END
    END
  END

  IF (@Accion NOT IN ('CANCELAR','DESAFECTAR') AND @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')) OR 
     (@Accion IN ('CANCELAR','DESAFECTAR')     AND @Estatus = 'CONCLUIDO') 
  BEGIN
    -- Verificar antes de Afectar
    IF @MovTipo IN ('CONT.P', 'CONT.C') AND /*(@Conexion = 0 OR @Accion IN ('CANCELAR', 'DESAFECTAR')) AND */@Accion NOT IN ('GENERAR', 'CONSECUTIVO'/*, 'SINCRO'*/) AND @Ok IS NULL
    BEGIN
      EXEC spContVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, 
			   @MovMoneda, @MovTipoCambio, @ContMoneda, @Estatus, @AfectarPresupuesto,
			   @FechaContable, @CfgVerificarIVA, @CfgCentrosCostos, @CfgToleraciaRedondeo, @CfgRegistro,
                           @Ejercicio, @Periodo, @Conexion, @SincroFinal, @Sucursal,
			   @Ok OUTPUT, @OkRef OUTPUT

      -- Quitar los mensajes cuando la afectarcion es normal 
      IF @Ok BETWEEN 80000 AND 89999 AND @Accion IN ('AFECTAR', 'GENERAR', 'CANCELAR', 'DESAFECTAR') SELECT @Ok = NULL ELSE

      -- Si Verifico y todo estubo bien
      IF @Accion = 'VERIFICAR' AND @Ok IS NULL
      BEGIN
        SELECT @Ok = 80000
        EXEC xpOk_80000 @Empresa, @Usuario, @Accion, @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
      END
    END

    IF @CfgContabilizarMesesFuturos = 0 AND @Accion = 'AFECTAR' AND @Ok IS NULL
    BEGIN
      IF (MONTH(@FechaContable) > MONTH(@FechaRegistro) AND YEAR(@FechaContable) >= YEAR(@FechaRegistro)) OR 
         (MONTH(@FechaContable) = MONTH(@FechaRegistro) AND YEAR(@FechaContable) > YEAR(@FechaRegistro))
      BEGIN
        UPDATE Cont SET Estatus = 'BORRADOR' WHERE ID = @ID AND Estatus <> 'BORRADOR'
        SELECT @Accion = 'VERIFICAR'
      END
    END
    
    IF @Accion IN ('AFECTAR', 'CANCELAR', 'DESAFECTAR','CONSECUTIVO','SINCRO') AND @Ok IS NULL
    BEGIN
      IF @MovTipo IN ('CONT.P', 'CONT.C') AND @EmpresaControladora = 0
        EXEC spContSocio @ID, @Empresa, @Ok OUTPUT, @OkRef OUTPUT

      IF @Ok IS NULL
        EXEC spContAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda, @MovTipoCambio, 
                           @FechaEmision, @FechaContable, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @UEN, @Observaciones, @AfectarPresupuesto,
                           @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, 
	  		   @ContMoneda, @ContTipoCambio, @CtaContabilidad, @CtaOrden,
	            	   @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, 
                           @CfgMoneda2Auto, @CfgMultiSucursal, @CfgRegistro,
                           @OrigenTipo, @Origen, @OrigenID,
                           @GenerarID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT,
                           @Base = @Base, @GenerarMov = @GenerarMov, @CfgConsolidacion = @CfgConsolidacion, @OrigenEmpresa = @OrigenEmpresa, @Intercompania = @Intercompania -- BUG13491

      IF ISNULL(@ContMoneda2, '(No)') <> '(No)' AND @Ok IS NULL AND @Accion <> 'CONSECUTIVO'
      BEGIN
        IF @Accion = 'AFECTAR'
        BEGIN
          SELECT @TipoCambio2 = NULL
          SELECT @Moneda2 = Moneda, @TipoCambio2 = TipoCambio FROM Mon WHERE Moneda = @ContMoneda2
	  EXEC xpContMoneda2 @ID, @Moneda2 OUTPUT, @TipoCambio2 OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        END

        IF @TipoCambio2 IS NOT NULL
        BEGIN
          EXEC spContAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda, @MovTipoCambio, 
                             @FechaEmision, @FechaContable, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @UEN, @Observaciones, @AfectarPresupuesto,
                             @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, 
		  	                 @Moneda2, @TipoCambio2, @CtaContabilidad, @CtaOrden,
	             	         @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, 
                             @CfgMoneda2Auto, @CfgMultiSucursal, @CfgRegistro,
                             @OrigenTipo, @Origen, @OrigenID,
                             @GenerarID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT,
			                 @AfectarMoneda2 = 1,
                             @Base = @Base, @GenerarMov = @GenerarMov, @CfgConsolidacion = @CfgConsolidacion, @OrigenEmpresa = @OrigenEmpresa, @Intercompania = @Intercompania -- BUG13491			     
          IF @Ok IS NULL AND @Accion = 'AFECTAR'
            UPDATE Cont SET Moneda2 = @Moneda2, TipoCambio2 = @TipoCambio2 WHERE ID = @ID
        END
      END
    END

  END ELSE 
  IF @Ok IN (NULL, 80030, 80060)
  BEGIN
    IF @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') AND @Accion = 'CANCELAR' EXEC spMovCancelarSinAfectar @Modulo, @ID, @Ok OUTPUT ELSE
    IF @Estatus = 'AFECTANDO' SELECT @Ok = 80020 ELSE
    IF @Estatus = 'CONCLUIDO' SELECT @Ok = 80010
    ELSE SELECT @Ok = 60040
  END


  IF @Accion = 'SINCRO' AND @Ok = 80060 
  BEGIN
    SELECT @Ok = NULL, @OkRef = NULL
    /*EXEC spSucursalEnLinea @SucursalDestino, @EnLinea OUTPUT
    IF @EnLinea = 1 EXEC spSincroFinalModulo @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT*/
  END

  -- Si hay Mensaje pero no tiene referencia
  IF @Ok IS NOT NULL AND @OkRef IS NULL 
    SELECT @OkRef = 'Movimiento: '+RTRIM(@Mov)+' '+RTRIM(@MovID), @GenerarID = NULL

  -- Para que no se genere poliza si hay error y se este utilizando ContReg

  --BUG15925  
  IF @Conexion = 0 AND @ContX = 1 /*AND @CfgRegistro = 1*/ AND @Ok IS NOT NULL AND @ContAuto = 0 AND @Ok <> 50010 
    IF EXISTS (SELECT ID FROM ContX WHERE Mov = @Origen AND Modulo = @OrigenTipo AND Empresa IN(@Empresa, NULL, '', '(Todas)'))-- AND EnLinea = 0) 
      EXEC spOk_RAISERROR @Ok, @OkRef
      
  -- BUG13491
  -- Se movio a spContAfectar para que quede dentro de la misma transaccion
  --IF @CfgConsolidacion = 1 AND @OrigenEmpresa IS NULL AND @Accion IN ('AFECTAR', 'CANCELAR', 'DESAFECTAR') AND @Ok IS NULL 
  --BEGIN
  --  SELECT @Referencia = RTRIM(@Mov)+' '+RTRIM(@MovID)+' ('+RTRIM(@Empresa)+')'
  --  EXEC spContConsolidar @Empresa, @Referencia, @Empresa, @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, @Mov, @MovID, @Ejercicio, @Periodo, @Intercompania, @Ok OUTPUT, @OkRef OUTPUT
  --END
  RETURN
END
GO

/**************** spContTraspasar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContTraspasar') and type = 'P') drop procedure dbo.spContTraspasar
GO
/*CREATE PROCEDURE spContTraspasar
		    @Empresa		char(10),
    		    @CuentaD		char(20),
    		    @CuentaA		char(20),
		    @SubCuentaD		char(50),
		    @SubCuentaA		char(50),
    		    @Mov               	char(20),
		    @Nivel		char(20) = 'CUENTA',
    		    @MovIDD           	varchar(20),
    		    @MovIDA           	varchar(20),
		    @FiltroEjercicio	int
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Ok               	int,		
    @OkRef            	varchar(255),	
    @OkDesc           	varchar(255),	
    @OkTipo           	varchar(50),
    @Modulo		char(5),
    @Conteo		int,
    @Cuenta		char(20),
    @UltCuenta		char(20),
    @SubCuenta		varchar(50),
    @Debe		money,
    @Haber		money,
    @Debe2		money,
    @Haber2		money,
    @ContMoneda		char(10),
    @ContTipoCambio	float,
    @Moneda2		char(10),
    @TipoCambio2	float,
    @CtaContabilidad	char(20),
    @CtaOrden		char(20),
    @Estatus		char(15),
    @Usuario	      	char(10),
    @MovTipo		char(20),
    @Ejercicio		int,
    @Periodo		int,
    @Sucursal		int,
    @ID			int,
    @MovID		varchar(20),
    @FechaRegistro	datetime,
    @FechaContable	datetime,
    @SinAuxiliares	bit,
    @Renglon		float,
    @RenglonSub		int
  
  SELECT @Ok = NULL, @Conteo = 0, @Modulo = 'CONT', @FechaRegistro = GETDATE()
  SELECT @CuentaD    = NULLIF(RTRIM(UPPER(@CuentaD)), ''),     @CuentaA    = NULLIF(RTRIM(UPPER(@CuentaA)), ''),
         @SubCuentaD = NULLIF(RTRIM(UPPER(@SubCuentaD)), '0'), @SubCuentaA = NULLIF(RTRIM(UPPER(@SubCuentaA)), '0'),
         @MovTipo    = NULLIF(RTRIM(@MovTipo), ''), @Nivel = ISNULL(UPPER(RTRIM(@Nivel)), 'CUENTA'),
         @Empresa = RTRIM(@Empresa)
  IF @@ERROR <> 0 SELECT @Ok = 1

  SELECT @ContMoneda      = RTRIM(ContMoneda),
         @CtaContabilidad = RTRIM(CtaContabilidad),
         @CtaOrden        = RTRIM(CtaOrden)
    FROM EmpresaCfg
   WHERE Empresa = @Empresa
  IF @@ERROR <> 0 SELECT @Ok = 1

  SELECT @ContTipoCambio = 1.0

  IF @Ok IS NULL
  BEGIN
    BEGIN TRANSACTION

      IF @Nivel = 'CUENTA'
        DECLARE crContTraspasar CURSOR
            FOR SELECT f.Sucursal, f.ID, f.MovID, f.FechaContable, f.Usuario, UPPER(f.Estatus), NULLIF(RTRIM(d.Cuenta), ''), NULLIF(RTRIM(d.SubCuenta), ''), ISNULL(d.Debe, 0.0), ISNULL(d.Haber, 0.0), NULLIF(RTRIM(f.Moneda2), ''), f.TipoCambio2, ISNULL(d.Debe2, 0.0), ISNULL(d.Haber2, 0.0), d.Renglon, d.RenglonSub
                  FROM ContD d, Cont f
                 WHERE d.ID = f.ID
                   AND f.Mov = @Mov
	           AND f.Empresa = @Empresa
  	           AND f.MovID BETWEEN @MovIDD AND @MovIDA
                   AND f.Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR', 'CONCLUIDO')
                   AND d.Cuenta = @CuentaD
                   AND f.Ejercicio = @FiltroEjercicio
      ELSE
        DECLARE crContTraspasar CURSOR
            FOR SELECT f.Sucursal, f.ID, f.MovID, f.FechaContable, f.Usuario, UPPER(f.Estatus), NULLIF(RTRIM(d.Cuenta), ''), NULLIF(RTRIM(d.SubCuenta), ''), ISNULL(d.Debe, 0.0), ISNULL(d.Haber, 0.0), NULLIF(RTRIM(f.Moneda2), ''), f.TipoCambio2, ISNULL(d.Debe2, 0.0), ISNULL(d.Haber2, 0.0), d.Renglon, d.RenglonSub
                  FROM ContD d, Cont f
                 WHERE d.ID = f.ID
                   AND f.Mov = @Mov
	           AND f.Empresa = @Empresa
  	           AND f.MovID BETWEEN @MovIDD AND @MovIDA
                   AND f.Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR', 'CONCLUIDO')
                   AND d.Cuenta = @CuentaD
                   AND d.SubCuenta = @SubCuentaD
                   AND f.Ejercicio = @FiltroEjercicio

      OPEN crContTraspasar
      FETCH NEXT FROM crContTraspasar INTO @Sucursal, @ID, @MovID, @FechaContable, @Usuario, @Estatus, @Cuenta, @SubCuenta, @Debe, @Haber, @Moneda2, @TipoCambio2, @Debe2, @Haber2, @Renglon, @RenglonSub
      IF @@ERROR <> 0 SELECT @Ok = 1
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @Cuenta IS NOT NULL AND @Ok IS NULL
        BEGIN

          -- Leer MovTipo, Periodo y Ejercicio	
          EXEC spMovTipo @Modulo, @Mov, @FechaContable, @Empresa, NULL, NULL, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT
          IF @MovTipo = 'CONT.C' SELECT @Periodo = 13
	  EXEC spMovOk 0, @ID, @Estatus, @Sucursal, 'AFECTAR', @Empresa, @Usuario, @Modulo, @Mov, @FechaContable, @FechaRegistro, @Ejercicio, @Periodo, NULL, @Ok OUTPUT, @OkRef OUTPUT

          IF @Estatus = 'CONCLUIDO'
          BEGIN
            -- Desafectar
            SELECT @SinAuxiliares = 0
            WHILE @Cuenta IS NOT NULL AND @Ok IS NULL
            BEGIN
              IF @Debe <> 0.0 
                EXEC spSaldo @Sucursal, 'DESAFECTAR', @Empresa, @Usuario, @Modulo, @ContMoneda, 1.0, @Cuenta, @SubCuenta, NULL, NULL,
                             @Modulo, @ID, @Mov, @MovID, 0, @Debe, NULL, NULL,
                             @FechaContable, @Ejercicio, @Periodo, @Mov, @MovID, @SinAuxiliares, 0, 0,
                             @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub
              IF @Haber <> 0.0
                EXEC spSaldo @Sucursal, 'DESAFECTAR', @Empresa, @Usuario, @Modulo, @ContMoneda, 1.0, @Cuenta, @SubCuenta, NULL, NULL,
                             @Modulo, @ID, @Mov, @MovID, 1, @Haber, NULL, NULL,
                             @FechaContable, @Ejercicio, @Periodo, @Mov, @MovID, @SinAuxiliares, 0, 0,
                             @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub

              IF @Moneda2 IS NOT NULL
              BEGIN
                IF @Debe2 <> 0.0 
                  EXEC spSaldo @Sucursal, 'DESAFECTAR', @Empresa, @Usuario, @Modulo, @Moneda2, @TipoCambio2, @Cuenta, @SubCuenta, NULL, NULL,
                               @Modulo, @ID, @Mov, @MovID, 0, @Debe2, NULL, NULL,
                               @FechaContable, @Ejercicio, @Periodo, @Mov, @MovID, @SinAuxiliares, 0, 0,
                               @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub
                IF @Haber2 <> 0.0
                  EXEC spSaldo @Sucursal, 'DESAFECTAR', @Empresa, @Usuario, @Modulo, @Moneda2, @TipoCambio2, @Cuenta, @SubCuenta, NULL, NULL,
                               @Modulo, @ID, @Mov, @MovID, 1, @Haber2, NULL, NULL,
                               @FechaContable, @Ejercicio, @Periodo, @Mov, @MovID, @SinAuxiliares, 0, 0,
                               @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub
              END

              SELECT @UltCuenta = @Cuenta
              SELECT @Cuenta = NULLIF(RTRIM(Rama), '') FROM Cta WHERE Cuenta = @Cuenta

	      SELECT @SinAuxiliares = 1
              IF UPPER(@Cuenta) IN (@CtaContabilidad, @CtaOrden) SELECT @Cuenta = NULL
            END

            -- Afectar
            SELECT @Cuenta = @CuentaA, @SubCuenta = @SubCuentaA
            SELECT @SinAuxiliares = 0
            WHILE @Cuenta IS NOT NULL AND @Ok IS NULL
            BEGIN
              IF @Debe <> 0.0 
                EXEC spSaldo @Sucursal, 'AFECTAR', @Empresa, @Usuario, @Modulo, @ContMoneda, 1.0, @Cuenta, @SubCuenta, NULL, NULL,
                             @Modulo, @ID, @Mov, @MovID, 1, @Debe, NULL, NULL,
                             @FechaContable, @Ejercicio, @Periodo, @Mov, @MovID, @SinAuxiliares, 0, 0,
                             @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub
              IF @Haber <> 0.0
                EXEC spSaldo @Sucursal, 'AFECTAR', @Empresa, @Usuario, @Modulo, @ContMoneda, 1.0, @Cuenta, @SubCuenta, NULL, NULL,
                             @Modulo, @ID, @Mov, @MovID, 0, @Haber, NULL, NULL,
                             @FechaContable, @Ejercicio, @Periodo, @Mov, @MovID, @SinAuxiliares, 0, 0,
                             @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub
              IF @Moneda2 IS NOT NULL
              BEGIN
                IF @Debe <> 0.0 
                  EXEC spSaldo @Sucursal, 'AFECTAR', @Empresa, @Usuario, @Modulo, @Moneda2, @TipoCambio2, @Cuenta, @SubCuenta, NULL, NULL,
                               @Modulo, @ID, @Mov, @MovID, 1, @Debe2, NULL, NULL,
                               @FechaContable, @Ejercicio, @Periodo, @Mov, @MovID, @SinAuxiliares, 0, 0,
                               @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub
                IF @Haber <> 0.0
                  EXEC spSaldo @Sucursal, 'AFECTAR', @Empresa, @Usuario, @Modulo, @Moneda2, @TipoCambio2, @Cuenta, @SubCuenta, NULL, NULL,
                               @Modulo, @ID, @Mov, @MovID, 0, @Haber2, NULL, NULL,
                               @FechaContable, @Ejercicio, @Periodo, @Mov, @MovID, @SinAuxiliares, 0, 0,
                               @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub
              END

              SELECT @UltCuenta = @Cuenta
              SELECT @Cuenta = NULLIF(RTRIM(Rama), '') FROM Cta WHERE Cuenta = @Cuenta

	      SELECT @SinAuxiliares = 1
              IF UPPER(@Cuenta) IN (@CtaContabilidad, @CtaOrden) SELECT @Cuenta = NULL
            END
          END

          SELECT @Conteo = @Conteo + 1
          IF @Nivel = 'CUENTA'
            UPDATE ContD SET Cuenta = @CuentaA WHERE CURRENT OF crContTraspasar
          ELSE
            UPDATE ContD SET Cuenta = @CuentaA, SubCuenta = @SubCuentaA WHERE CURRENT OF crContTraspasar
          IF @@ERROR <> 0 SELECT @Ok = 1
        END
        FETCH NEXT FROM crContTraspasar INTO @Sucursal, @ID, @MovID, @FechaContable, @Usuario, @Estatus, @Cuenta, @SubCuenta, @Debe, @Haber, @Moneda2, @TipoCambio2, @Debe2, @Haber2, @Renglon, @RenglonSub
        IF @@ERROR <> 0 SELECT @Ok = 1
      END  -- While
      CLOSE crContTraspasar
      DEALLOCATE crContTraspasar

    IF @Ok IS NULL
      COMMIT TRANSACTION
    ELSE 
    BEGIN
      ROLLBACK TRANSACTION
      SELECT @Conteo = 0
    END
  END

  IF @Ok IS NULL 
    SELECT @Ok = 80000, @OkRef = LTRIM(Convert(char, @conteo))+' Movimiento(s) traspasados.', @OkTipo = 'INFO', @OkDesc = 'Proceso Concluido'
  ELSE
    -- Leer el Mensaje
    SELECT @OkDesc = Descripcion, 
           @OkTipo = Tipo
      FROM MensajeLista
     WHERE Mensaje = @Ok  
  
  -- Mostrar el Estatus de la Afectacion
  SELECT @Ok, @OkDesc, @OkTipo, @OkRef, NULL

  RETURN
END*/
GO


/**************** spContInsertar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContInsertar') and type = 'P') drop procedure dbo.spContInsertar
GO             
/**************** spContInsertarD ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContInsertarD') and type = 'P') drop procedure dbo.spContInsertarD
GO             


/**************** spContRegAnterior ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContRegAnterior') and type = 'P') drop procedure dbo.spContRegAnterior
GO             
CREATE PROCEDURE spContRegAnterior
   			@Empresa char(5),
			@ContID	int = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ok   		int,
    @OkRef  		varchar(255),
    @ContMov  		varchar(20), 
    @ContMovID		varchar(20), 
    @ContMovTipo	varchar(20),
    @Ejercicio		int,
    @Periodo		int,
    @Modulo  		varchar(10), 
    @ID   		int,
    @Mov  		varchar(20), 
    @MovID  		varchar(20),
    @Conteo		int,
    @Contacto		varchar(10),
    @ContactoTipo	varchar(20)

 
  SELECT @Ok = NULL, @OkRef = NULL, @Conteo = 0
  DECLARE crCont CURSOR FOR 
   SELECT ID, Mov, MovID, Ejercicio, Periodo, OrigenTipo, Origen, NULLIF(RTRIM(OrigenID), ''), NULLIF(RTRIM(Contacto), ''), NULLIF(RTRIM(ContactoTipo), '')
     FROM Cont
    WHERE Empresa = @Empresa AND Estatus = 'CONCLUIDO' AND OrigenID IS NOT NULL AND ID = ISNULL(@ContID, ID)
  OPEN crCont
  FETCH NEXT FROM crCont INTO @ContID, @ContMov, @ContMovID, @Ejercicio, @Periodo, @Modulo, @Mov, @MovID, @Contacto, @ContactoTipo
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    SELECT @ContMovTipo = NULL
    SELECT @ContMovTipo = mt.Clave FROM MovTipo mt WHERE Modulo = 'CONT' AND Mov = @ContMov
    IF @@FETCH_STATUS <> -2 AND @ContMovTipo IN ('CONT.P', 'CONT.C') AND @Ok IS NULL
    BEGIN
      IF NOT EXISTS(SELECT * FROM ContReg WHERE ID = @ContID)
      BEGIN
        SELECT @ID = NULL
        SELECT @ID =  dbo.fnModuloIDContRegAnterior(@Empresa, @Modulo, @Mov, @MovID, @Ejercicio, @Periodo)
--select @id, @Empresa, @Modulo, @Mov, @MovID, @Ejercicio, @Periodo
        IF @ID IS NOT NULL 
        BEGIN 
          IF @Modulo = 'DIN' AND @Contacto IS NOT NULL AND @ContactoTipo IS NOT NULL
          BEGIN
            IF EXISTS(SELECT * FROM Dinero WHERE ID = @ID AND Contacto IS NULL AND ContactoTipo IS NULL)
              UPDATE Dinero SET Contacto = @Contacto, ContactoTipo = @ContactoTipo WHERE ID = @ID
          END
          EXEC spMovReg @Modulo, @ID

          INSERT ContReg (
                 ID, Empresa,  Sucursal,         Modulo,  ModuloID, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe, Haber)
          SELECT ID, @Empresa, SucursalContable, @Modulo, @ID,      Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe, Haber
            FROM ContD
           WHERE ID = @ContID
          SELECT @Conteo = @Conteo + 1
        END
      END
    END
    FETCH NEXT FROM crCont INTO @ContID, @ContMov, @ContMovID, @Ejercicio, @Periodo, @Modulo, @Mov, @MovID, @Contacto, @ContactoTipo
  END
  CLOSE crCont
  DEALLOCATE crCont
  SELECT CONVERT(varchar, @Conteo)+' Polizas Modificadas'

  RETURN
END
GO
-- spContRegAnterior 'INTEL', 90029

/**************** spContRegSinOrigen ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContRegSinOrigen') and type = 'P') drop procedure dbo.spContRegSinOrigen
GO             
CREATE PROCEDURE spContRegSinOrigen
   			@Empresa char(5),
			@ContID	int = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ok   		int,
    @OkRef  		varchar(255),
    @ContMov  		varchar(20), 
    @ContMovID		varchar(20), 
    @ContMovTipo	varchar(20),
    @Modulo  		varchar(10), 
    @ID   		int,
    @Mov  		varchar(20), 
    @MovID  		varchar(20),
    @Conteo		int
 
  SELECT @Ok = NULL, @OkRef = NULL, @Conteo = 0
  DECLARE crCont CURSOR FOR 
   SELECT ID, Mov, MovID
     FROM Cont
    WHERE Empresa = @Empresa AND Estatus = 'CONCLUIDO' AND NULLIF(RTRIM(OrigenID), '') IS NULL AND ID = ISNULL(@ContID, ID)
  OPEN crCont
  FETCH NEXT FROM crCont INTO @ContID, @ContMov, @ContMovID
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    SELECT @ContMovTipo = NULL
    SELECT @ContMovTipo = mt.Clave FROM MovTipo mt WHERE Modulo = 'CONT' AND Mov = @ContMov
    IF @@FETCH_STATUS <> -2 AND @ContMovTipo IN ('CONT.P', 'CONT.C') AND @Ok IS NULL
    BEGIN
      DELETE ContReg WHERE ID = @ContID
      DELETE MovReg  WHERE Modulo = 'CONT' AND ID = @ContID
      EXEC spMovReg 'CONT', @ContID
      INSERT ContReg (
             ID, Empresa,  Sucursal,         Modulo,  ModuloID, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe, Haber)
      SELECT ID, @Empresa, SucursalContable, 'CONT',  @ContID,  Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe, Haber
        FROM ContD
       WHERE ID = @ContID
      SELECT @Conteo = @Conteo + 1
    END
    FETCH NEXT FROM crCont INTO @ContID, @ContMov, @ContMovID
  END
  CLOSE crCont
  DEALLOCATE crCont
  SELECT CONVERT(varchar, @Conteo)+' Polizas Modificadas'

  RETURN
END
GO
-- spContRegSinOrigen 'INTEL', 2132




/**************** spContRegDif ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContRegDif') and type = 'P') drop procedure dbo.spContRegDif
GO             
CREATE PROCEDURE spContRegDif
			@Estacion	int,
   			@Empresa	char(5)
--//WITH ENCRYPTION
AS BEGIN
  create table #c (id int primary key, importe money null)
  create table #r (id int primary key, importe money null)

  DELETE FROM ContRegDif WHERE Estacion=@Estacion --BUG17936

  insert #c (id, importe)
  select c.id, sum(d.debe)
    from Cont c
    join contd d on d.id = c.id
    join MovTipo mt ON mt.Modulo = 'CONT' AND mt.Mov = c.Mov
  where c.estatus = 'CONCLUIDO' and c.empresa = @Empresa AND mt.Clave IN ('CONT.P', 'CONT.C')
  group by c.id

  insert #r (id, importe)
  select c.id, sum(debe)
    from Cont c
    join MovTipo mt ON mt.Modulo = 'CONT' AND mt.Mov = c.Mov
    join contreg r on r.id = c.id
   where c.estatus = 'CONCLUIDO' and c.empresa = @Empresa AND mt.Clave IN ('CONT.P', 'CONT.C')
  group by c.id

  insert ContRegDif (Estacion, ID, ContImporte, RegImporte)
  select @Estacion, c.id, c.importe, r.Importe
    from #c c
  left outer join #r r on r.id = c.id
  where isnull(c.importe, 0.0) <> isnull(r.importe, 0.0)
END
GO
-- spContRegDif 1, 'DEMO'
-- select * from contregdif


/**************** spPresupuestoCerrarDia ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPresupuestoCerrarDia') and type = 'P') drop procedure dbo.spPresupuestoCerrarDia
GO
CREATE PROCEDURE spPresupuestoCerrarDia
		    @Sucursal		int, 
                    @Empresa		varchar(5), 
                    @Usuario		varchar(10), 
                    @FechaTrabajo	datetime, 
    		    @Fecha		datetime,

    		    @Ok			int          OUTPUT,
    		    @OkRef		varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @EjercicioTrabajo	int,
    @PeriodoTrabajo	int,
    @Ejercicio  	int,
    @Periodo		int,
    @PresupuestoPeriodo	int,
    @Moneda		varchar(10), 
    @Cuenta		varchar(20), 
    @SubCuenta		varchar(20), 
    @UEN		int,
    @Importe		money,
    @ID			int,
    @Mov		varchar(20),
    @AfectarPresupuesto	varchar(30),
    @Renglon		float

  IF @Sucursal <> 0 RETURN

  SELECT @Moneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa
  SELECT @Mov = ContPresupuesto FROM EmpresaCfgMov WHERE Empresa = @Empresa
  EXEC spPeriodoEjercicio @Empresa, 'CONT', @FechaTrabajo, @PeriodoTrabajo OUTPUT, @EjercicioTrabajo OUTPUT, @Ok OUTPUT
  EXEC spPeriodoEjercicio @Empresa, 'CONT', @Fecha,        @Periodo OUTPUT,        @Ejercicio OUTPUT,        @Ok OUTPUT

  IF @EjercicioTrabajo <> @Ejercicio RETURN

  CREATE TABLE #Presupuesto (
	UEN 		int NULL, 
	Periodo 	int NULL, 
	Cuenta 		varchar(20) COLLATE Database_Default NULL, 
	SubCuenta 	varchar(20) COLLATE Database_Default NULL, 
	Reservado 	money NULL, 
	Comprometido 	money NULL, 
	Devengado 	money NULL, 
	Disponible 	money NULL)

   INSERT #Presupuesto (
          UEN, Cuenta, SubCuenta, Periodo, Reservado,      Comprometido,      Devengado,      Disponible)
   SELECT UEN, Cuenta, SubCuenta, Periodo, SUM(Reservado), SUM(Comprometido), SUM(Devengado), SUM(ISNULL(Presupuesto, 0.0)-ISNULL(Reservado, 0.0)-ISNULL(Comprometido, 0.0)-ISNULL(Devengado, 0.0))
     FROM Presupuesto
    WHERE Empresa = @Empresa AND Moneda = @Moneda AND UEN = @UEN AND Ejercicio = @EjercicioTrabajo AND Periodo < @Periodo
    GROUP BY UEN, Cuenta, SubCuenta, Periodo
    ORDER BY UEN, Cuenta, SubCuenta, Periodo

  /* Reservado */
  SELECT @AfectarPresupuesto = 'Reservar'
  DECLARE crUEN CURSOR LOCAL FOR 
   SELECT UEN
     FROM #Presupuesto
    WHERE NULLIF(Reservado, 0.0) IS NOT NULL
    GROUP BY UEN
    ORDER BY UEN
  OPEN crUEN
  FETCH NEXT FROM crUEN INTO @UEN
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      INSERT Cont (
              Empresa,  Usuario,  Mov,  Estatus,      Sucursal,  SucursalOrigen, FechaEmision,  FechaContable, UEN,  Moneda,  TipoCambio, AfectarPresupuesto)
      VALUES (@Empresa, @Usuario, @Mov, 'SINAFECTAR', @Sucursal, @Sucursal,      @FechaTrabajo, @FechaTrabajo, @UEN, @Moneda, 1.0,        @AfectarPresupuesto)
      SELECT @ID = SCOPE_IDENTITY()
      SELECT @Renglon = 0.0

      DECLARE crPresupuesto CURSOR LOCAL FOR 
       SELECT Cuenta, SubCuenta, Periodo, SUM(Reservado)
         FROM #Presupuesto
        GROUP BY Cuenta, SubCuenta, Periodo
        ORDER BY Cuenta, SubCuenta, Periodo
      OPEN crPresupuesto
      FETCH NEXT FROM crPresupuesto INTO @Cuenta, @SubCuenta, @PresupuestoPeriodo, @Importe
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND NULLIF(@Importe, 0.0) IS NOT NULL
        BEGIN
          SELECT @Renglon = @Renglon + 2048.0
          INSERT ContD (
                 ID,  Empresa,  Renglon,  RenglonSub, Sucursal,  Cuenta,  SubCuenta,  Haber,    Ejercicio,  Periodo,             SucursalContable)
          SELECT @ID, @Empresa, @Renglon, 0,          @Sucursal, @Cuenta, @SubCuenta, @Importe, @Ejercicio, @PresupuestoPeriodo, @Sucursal
          INSERT ContD (
                 ID,  Empresa,  Renglon,  RenglonSub, Sucursal,  Cuenta,  SubCuenta,  Debe,     Ejercicio,  Periodo,  SucursalContable)
          SELECT @ID, @Empresa, @Renglon, 0,          @Sucursal, @Cuenta, @SubCuenta, @Importe, @Ejercicio, @Periodo, @Sucursal
        END
        FETCH NEXT FROM crPresupuesto INTO @Cuenta, @SubCuenta, @PresupuestoPeriodo, @Importe
      END
      CLOSE crPresupuesto
      DEALLOCATE crPresupuesto
      IF EXISTS(SELECT * FROM ContD WHERE ID = @ID)
        EXEC spAfectar 'CONT', @ID, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    END
    FETCH NEXT FROM crUEN INTO @UEN
  END
  CLOSE crUEN
  DEALLOCATE crUEN

  /* Comprometido */
  SELECT @AfectarPresupuesto = 'Comprometer Directo'
  DECLARE crUEN CURSOR LOCAL FOR 
   SELECT UEN
     FROM #Presupuesto
    WHERE NULLIF(Comprometido, 0.0) IS NOT NULL
    GROUP BY UEN
    ORDER BY UEN
  OPEN crUEN
  FETCH NEXT FROM crUEN INTO @UEN
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      INSERT Cont (
              Empresa,  Usuario,  Mov,  Estatus,      Sucursal,  SucursalOrigen, FechaEmision,  FechaContable, UEN,  Moneda,  TipoCambio, AfectarPresupuesto)
      VALUES (@Empresa, @Usuario, @Mov, 'SINAFECTAR', @Sucursal, @Sucursal,      @FechaTrabajo, @FechaTrabajo, @UEN, @Moneda, 1.0,        @AfectarPresupuesto)
      SELECT @ID = SCOPE_IDENTITY()
      SELECT @Renglon = 0.0

      DECLARE crPresupuesto CURSOR LOCAL FOR 
       SELECT Cuenta, SubCuenta, Periodo, SUM(Comprometido)
         FROM #Presupuesto
        GROUP BY Cuenta, SubCuenta, Periodo
        ORDER BY Cuenta, SubCuenta, Periodo
      OPEN crPresupuesto
      FETCH NEXT FROM crPresupuesto INTO @Cuenta, @SubCuenta, @PresupuestoPeriodo, @Importe
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND NULLIF(@Importe, 0.0) IS NOT NULL
        BEGIN
          SELECT @Renglon = @Renglon + 2048.0
          INSERT ContD (
                 ID,  Empresa,  Renglon,  RenglonSub, Sucursal,  Cuenta,  SubCuenta,  Haber,    Ejercicio,  Periodo,             SucursalContable)
          SELECT @ID, @Empresa, @Renglon, 0,          @Sucursal, @Cuenta, @SubCuenta, @Importe, @Ejercicio, @PresupuestoPeriodo, @Sucursal
          INSERT ContD (
                 ID,  Empresa,  Renglon,  RenglonSub, Sucursal,  Cuenta,  SubCuenta,  Debe,     Ejercicio,  Periodo,  SucursalContable)
          SELECT @ID, @Empresa, @Renglon, 0,          @Sucursal, @Cuenta, @SubCuenta, @Importe, @Ejercicio, @Periodo, @Sucursal
        END
        FETCH NEXT FROM crPresupuesto INTO @Cuenta, @SubCuenta, @PresupuestoPeriodo, @Importe
      END
      CLOSE crPresupuesto
      DEALLOCATE crPresupuesto
      IF EXISTS(SELECT * FROM ContD WHERE ID = @ID)
        EXEC spAfectar 'CONT', @ID, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    END
    FETCH NEXT FROM crUEN INTO @UEN
  END
  CLOSE crUEN
  DEALLOCATE crUEN

  /* Devengado */
  SELECT @AfectarPresupuesto = 'Devengar Directo'
  DECLARE crUEN CURSOR LOCAL FOR 
   SELECT UEN
     FROM #Presupuesto
    WHERE NULLIF(Devengado, 0.0) IS NOT NULL
    GROUP BY UEN
    ORDER BY UEN
  OPEN crUEN
  FETCH NEXT FROM crUEN INTO @UEN
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      INSERT Cont (
              Empresa,  Usuario,  Mov,  Estatus,      Sucursal,  SucursalOrigen, FechaEmision,  FechaContable, UEN,  Moneda,  TipoCambio, AfectarPresupuesto)
      VALUES (@Empresa, @Usuario, @Mov, 'SINAFECTAR', @Sucursal, @Sucursal,      @FechaTrabajo, @FechaTrabajo, @UEN, @Moneda, 1.0,        @AfectarPresupuesto)
      SELECT @ID = SCOPE_IDENTITY()
      SELECT @Renglon = 0.0

      DECLARE crPresupuesto CURSOR LOCAL FOR 
       SELECT Cuenta, SubCuenta, Periodo, SUM(Devengado)
         FROM #Presupuesto
        GROUP BY Cuenta, SubCuenta, Periodo
        ORDER BY Cuenta, SubCuenta, Periodo
      OPEN crPresupuesto
      FETCH NEXT FROM crPresupuesto INTO @Cuenta, @SubCuenta, @PresupuestoPeriodo, @Importe
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND NULLIF(@Importe, 0.0) IS NOT NULL
        BEGIN
          SELECT @Renglon = @Renglon + 2048.0
          INSERT ContD (
                 ID,  Empresa,  Renglon,  RenglonSub, Sucursal,  Cuenta,  SubCuenta,  Haber,    Ejercicio,  Periodo,             SucursalContable)
          SELECT @ID, @Empresa, @Renglon, 0,          @Sucursal, @Cuenta, @SubCuenta, @Importe, @Ejercicio, @PresupuestoPeriodo, @Sucursal
          INSERT ContD (
                 ID,  Empresa,  Renglon,  RenglonSub, Sucursal,  Cuenta,  SubCuenta,  Debe,     Ejercicio,  Periodo,  SucursalContable)
          SELECT @ID, @Empresa, @Renglon, 0,          @Sucursal, @Cuenta, @SubCuenta, @Importe, @Ejercicio, @Periodo, @Sucursal
        END
        FETCH NEXT FROM crPresupuesto INTO @Cuenta, @SubCuenta, @PresupuestoPeriodo, @Importe
      END
      CLOSE crPresupuesto
      DEALLOCATE crPresupuesto
      IF EXISTS(SELECT * FROM ContD WHERE ID = @ID)
        EXEC spAfectar 'CONT', @ID, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    END
    FETCH NEXT FROM crUEN INTO @UEN
  END
  CLOSE crUEN
  DEALLOCATE crUEN

  /* Disponible */
  SELECT @AfectarPresupuesto = 'Asignar'
  DECLARE crUEN CURSOR LOCAL FOR 
   SELECT UEN
     FROM #Presupuesto
    WHERE NULLIF(Disponible, 0.0) IS NOT NULL
    GROUP BY UEN
    ORDER BY UEN
  OPEN crUEN
  FETCH NEXT FROM crUEN INTO @UEN
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      INSERT Cont (
              Empresa,  Usuario,  Mov,  Estatus,      Sucursal,  SucursalOrigen, FechaEmision,  FechaContable, UEN,  Moneda,  TipoCambio, AfectarPresupuesto)
      VALUES (@Empresa, @Usuario, @Mov, 'SINAFECTAR', @Sucursal, @Sucursal,      @FechaTrabajo, @FechaTrabajo, @UEN, @Moneda, 1.0,        @AfectarPresupuesto)
      SELECT @ID = SCOPE_IDENTITY()
      SELECT @Renglon = 0.0

      DECLARE crPresupuesto CURSOR LOCAL FOR 
       SELECT Cuenta, SubCuenta, Periodo, SUM(Disponible)
         FROM #Presupuesto
        GROUP BY Cuenta, SubCuenta, Periodo
        ORDER BY Cuenta, SubCuenta, Periodo
      OPEN crPresupuesto
      FETCH NEXT FROM crPresupuesto INTO @Cuenta, @SubCuenta, @PresupuestoPeriodo, @Importe
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND NULLIF(@Importe, 0.0) IS NOT NULL
        BEGIN
          SELECT @Renglon = @Renglon + 2048.0
          INSERT ContD (
                 ID,  Empresa,  Renglon,  RenglonSub, Sucursal,  Cuenta,  SubCuenta,  Haber,    Ejercicio,  Periodo,             SucursalContable)
          SELECT @ID, @Empresa, @Renglon, 0,          @Sucursal, @Cuenta, @SubCuenta, @Importe, @Ejercicio, @PresupuestoPeriodo, @Sucursal
          INSERT ContD (
                 ID,  Empresa,  Renglon,  RenglonSub, Sucursal,  Cuenta,  SubCuenta,  Debe,     Ejercicio,  Periodo,  SucursalContable)
          SELECT @ID, @Empresa, @Renglon, 0,          @Sucursal, @Cuenta, @SubCuenta, @Importe, @Ejercicio, @Periodo, @Sucursal
        END
        FETCH NEXT FROM crPresupuesto INTO @Cuenta, @SubCuenta, @PresupuestoPeriodo, @Importe
      END
      CLOSE crPresupuesto
      DEALLOCATE crPresupuesto
      IF EXISTS(SELECT * FROM ContD WHERE ID = @ID)
        EXEC spAfectar 'CONT', @ID, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    END
    FETCH NEXT FROM crUEN INTO @UEN
  END
  CLOSE crUEN
  DEALLOCATE crUEN

  RETURN
END
GO


PRINT "******************* SP CONTABILIDAD ******************"


