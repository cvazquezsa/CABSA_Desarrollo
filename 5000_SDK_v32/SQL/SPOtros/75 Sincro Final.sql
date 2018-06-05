-- SincroFinalModulo 'VTAS', 61000021

/* spSincroLogEnviarRespaldo */ 
if exists (select * from sysobjects where id = object_id('dbo.spSincroLogEnviarRespaldo') and type = 'P') drop procedure dbo.spSincroLogEnviarRespaldo
GO
CREATE PROCEDURE spSincroLogEnviarRespaldo
			@Sucursal	int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @UltConsecutivo	int
  SELECT @UltConsecutivo = NULL

  SELECT @UltConsecutivo = MAX(Consecutivo) 
    FROM SincroLog 
   WHERE Sucursal = 0 AND Origen = 0 AND Accion = 'ENVIAR'

  IF @UltConsecutivo IS NOT NULL
  BEGIN
    IF NOT EXISTS(SELECT * FROM SincroLog WHERE Sucursal = @Sucursal AND Accion = 'RECIBIR' AND Origen = 0 AND Consecutivo = @UltConsecutivo)
      INSERT SincroLog (Sucursal,   Accion,   Origen, Consecutivo) 
                VALUES (@Sucursal, 'RECIBIR', 0,      @UltConsecutivo)
  END
END
GO


/* spSincroFinalModulo */ 
if exists (select * from sysobjects where id = object_id('dbo.spSincroFinalModulo') and type = 'P') drop procedure dbo.spSincroFinalModulo
GO
CREATE PROCEDURE spSincroFinalModulo
			@Modulo		char(5),
                        @ID		int 		= NULL,
			@Ok		int 		= NULL	OUTPUT,
			@OkRef		varchar(255) 	= NULL  OUTPUT
			
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @Brincar	bit,
    @EnLinea	bit,
    @Sucursal	int,
    @Estatus	char(15),
    @Usuario	char(10),
    @SincroSSB	bit,
    @SincroIS	bit
    
  SELECT @SincroSSB = ISNULL(SincroSSB,0), @SincroIS = ISNULL(SincroIS,0) FROM Version
  
  IF @SincroSSB = 0 AND @SincroIS = 0 RETURN

  IF @Modulo = 'CONT'  DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Cont         WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'CI'    DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM CI           WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'AF'    DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM ActivoFijo   WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'ST'    DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Soporte      WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'VTAS'  DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Venta        WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'PROD'  DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Prod         WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'COMS'  DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Compra       WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'INV'   DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Inv          WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'CXC'   DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Cxc          WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'CXP'   DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Cxp          WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'AGENT' DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Agent        WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'GAS'   DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Gasto        WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'DIN'   DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Dinero       WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'EMB'   DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Embarque     WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'NOM'   DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Nomina       WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'RH'    DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM RH           WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'ASIS'  DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Asiste       WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'PC'    DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM PC           WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'OFER'  DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Oferta       WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'VALE'  DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Vale         WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'CR'    DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM CR           WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'CAP'   DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Capital      WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'INC'   DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Incidencia   WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'CONC'  DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Conciliacion WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'PPTO'  DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Presup       WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'CREDI' DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Credito      WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'TMA'   DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM TMA          WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  --IF @Modulo = 'ACT'   DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Act           WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  --IF @Modulo = 'MEX01' DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM ModuloExtra01 WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  --IF @Modulo = 'MEX02' DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM ModuloExtra02 WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  --IF @Modulo = 'MEX03' DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM ModuloExtra03 WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  --IF @Modulo = 'MEX04' DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM ModuloExtra04 WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  --IF @Modulo = 'MEX05' DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM ModuloExtra05 WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  --IF @Modulo = 'MEX06' DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM ModuloExtra06 WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  --IF @Modulo = 'MEX07' DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM ModuloExtra07 WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  --IF @Modulo = 'MEX08' DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM ModuloExtra08 WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  --IF @Modulo = 'MEX09' DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM ModuloExtra09 WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'ORG'   DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Organiza     WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'RE'    DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Recluta	   WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'ISL'   DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM ISL	       WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'RSS'   DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM RSS          WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'CMP'   DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Campana      WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'FIS'   DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Fiscal       WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  --REQ25014
  IF @Modulo = 'CONTP' DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM ContParalela WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE  
  --REQ16092
  IF @Modulo = 'OPORT' DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Oportunidad  WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE  
  IF @Modulo = 'CORTE' DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Corte        WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE  
  IF @Modulo = 'FRM'   DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM FormaExtra   WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'CAPT'  DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Captura      WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'GES'   DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Gestion      WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'CP'    DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM CP           WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'PCP'   DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM PCP          WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE  
  IF @Modulo = 'CAM'   DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Cambio       WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'PACTO' DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM Contrato     WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' ELSE
  IF @Modulo = 'SAUX'  DECLARE crSincroMov CURSOR LOCAL FOR SELECT ID, Sucursal, Usuario FROM SAUX         WHERE ID = CASE WHEN @ID IS NULL THEN ID ELSE @ID END AND Estatus = 'SINCRO' 
  ELSE RETURN

  OPEN crSincroMov
  FETCH NEXT FROM crSincroMov INTO @ID, @Sucursal, @Usuario
  WHILE @@fetch_status <> -1
  BEGIN
    IF @@fetch_status <> -2
    BEGIN
      IF @Modulo = 'CONT'
      BEGIN
        SELECT @Brincar = 0
        IF (SELECT Sucursal FROM Version) = 0
          SELECT @Estatus = 'SINAFECTAR' 
        ELSE
          SELECT @Brincar = 1
      END ELSE
      BEGIN
        SELECT @Brincar = 0
        EXEC spSucursalEnLinea @Sucursal, @EnLinea OUTPUT
        IF @EnLinea = 1
          SELECT @Estatus = 'SINAFECTAR' 
        ELSE 
          IF (SELECT Sucursal FROM Version) = 0 SELECT @Estatus = 'SINCRO' ELSE SELECT @Brincar = 1
      END
      IF @Brincar = 0
      BEGIN
        IF @SincroIS = 1 EXEC spSetInformacionContexto 'SINCROIS', 1                      
        IF @Modulo = 'CONT'  UPDATE Cont         SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'CI'    UPDATE CI           SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'AF'    UPDATE ActivoFijo   SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'ST'    UPDATE Soporte      SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'VTAS'  UPDATE Venta        SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'PROD'  UPDATE Prod         SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'COMS'  UPDATE Compra       SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'INV'   UPDATE Inv          SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'CXC'   UPDATE Cxc          SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'CXP'   UPDATE Cxp          SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'AGENT' UPDATE Agent        SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'GAS'   UPDATE Gasto        SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'DIN'   UPDATE Dinero       SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'EMB'   UPDATE Embarque     SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'NOM'   UPDATE Nomina       SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'RH'    UPDATE RH           SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'ASIS'  UPDATE Asiste       SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'PC'    UPDATE PC           SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'OFER'  UPDATE Oferta       SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'VALE'  UPDATE Vale         SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'CR'    UPDATE CR           SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'CAP'   UPDATE Capital      SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'INC'   UPDATE Incidencia   SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'CONC'  UPDATE Conciliacion SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'PPTO'  UPDATE Presup       SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'CREDI' UPDATE Credito      SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'TMA'   UPDATE TMA          SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        --IF @Modulo = 'ACT'   UPDATE Act           SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        --IF @Modulo = 'MEX01' UPDATE ModuloExtra01 SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        --IF @Modulo = 'MEX02' UPDATE ModuloExtra02 SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        --IF @Modulo = 'MEX03' UPDATE ModuloExtra03 SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        --IF @Modulo = 'MEX04' UPDATE ModuloExtra04 SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        --IF @Modulo = 'MEX05' UPDATE ModuloExtra05 SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        --IF @Modulo = 'MEX06' UPDATE ModuloExtra06 SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        --IF @Modulo = 'MEX07' UPDATE ModuloExtra07 SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        --IF @Modulo = 'MEX08' UPDATE ModuloExtra08 SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        --IF @Modulo = 'MEX09' UPDATE ModuloExtra09 SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'ORG'   UPDATE Organiza     SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'RE'    UPDATE Recluta	 SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'ISL'   UPDATE ISL		 SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'RSS'   UPDATE RSS          SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'CMP'   UPDATE Campana      SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'FIS'   UPDATE Fiscal       SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        --REQ25014
        IF @Modulo = 'CONTP' UPDATE ContParalela SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE        
        --REQ16092
		IF @Modulo = 'OPORT' UPDATE Oportunidad  SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE		
        IF @Modulo = 'CORTE' UPDATE Corte        SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE        
        IF @Modulo = 'FRM'   UPDATE FormaExtra   SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'CAPT'  UPDATE Captura      SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'GES'   UPDATE Gestion      SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'CP'    UPDATE CP	         SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'PCP'   UPDATE PCP	         SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE        
        IF @Modulo = 'CAM'   UPDATE Cambio       SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'PACTO' UPDATE Contrato     SET Estatus = @Estatus WHERE CURRENT OF crSincroMov ELSE
        IF @Modulo = 'SAUX'  UPDATE SAUX         SET Estatus = @Estatus WHERE CURRENT OF crSincroMov 
        IF @SincroIS = 1 EXEC spSetInformacionContexto 'SINCROIS', 0                      
        IF @Estatus = 'SINAFECTAR'
        BEGIN
          EXEC spSincroMovRegistro @Modulo, @ID
          EXEC spAfectar @Modulo, @ID, 'AFECTAR', 'TODO', NULL, @Usuario, 1, 1, @Ok OUTPUT, @OkRef OUTPUT
        END ELSE 
          EXEC spAsignarSucursalEstatusRelacionadas @ID, @Modulo, @Sucursal
      END
    END
    FETCH NEXT FROM crSincroMov INTO @ID, @Sucursal, @Usuario
  END
  CLOSE crSincroMov
  DEALLOCATE crSincroMov
END
go

-- spSincroFinal 'CONT'
/* Sincro Final */ 
if exists (select * from sysobjects where id = object_id('dbo.spSincroFinal') and type = 'P') drop procedure dbo.spSincroFinal
GO
CREATE PROCEDURE spSincroFinal
			@Modulo	char(5) = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @SincroSSB			bit,
    @SincroIS			bit
    
  SELECT @SincroSSB = ISNULL(SincroSSB,0), @SincroIS = ISNULL(SincroIS,0) FROM Version
    
  IF @SincroSSB = 0 AND @SincroIS = 0 RETURN

  DECLARE crModulo CURSOR LOCAL FOR 
   SELECT Modulo 
     FROM Modulo
    WHERE Modulo = CASE WHEN @Modulo IS NULL THEN Modulo ELSE @Modulo END
  OPEN crModulo
  FETCH NEXT FROM crModulo INTO @Modulo
  WHILE @@fetch_status <> -1
  BEGIN
    IF @@fetch_status <> -2
    BEGIN
      EXEC spSincroFinalModulo @Modulo 
    END
    FETCH NEXT FROM crModulo INTO @Modulo
  END
  CLOSE crModulo
  DEALLOCATE crModulo

  EXEC xpSincroFinal
END
go

