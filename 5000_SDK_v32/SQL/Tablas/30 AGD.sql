
/*******************************************************************************************/
/*                          Almacenadora General Deposito (AGD)             	           */
/*******************************************************************************************/

-- drop table agdCfg
/****** agdCfg ******/
if not exists(select * from SysTabla where SysTabla = 'agdCfg')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('agdCfg','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.agdCfg') and type = 'U') 
  CREATE TABLE dbo.agdCfg (
	PatenteAlmacenFiscal	varchar(10)	NOT NULL	DEFAULT 1401,

	PatenteAlmacenadora	varchar(10)	NULL,	

	CONSTRAINT pk_agdCfg PRIMARY KEY CLUSTERED (PatenteAlmacenFiscal)
)
GO
IF NOT EXISTS(SELECT * FROM agdCfg)
  INSERT agdCfg (PatenteAlmacenFiscal) VALUES ('1401')
GO

/****** agdArchivoLog ******/
if not exists(select * from SysTabla where SysTabla = 'agdArchivoLog')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('agdArchivoLog','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.agdArchivoLog') and type = 'U') 
  CREATE TABLE dbo.agdArchivoLog (
	ID			int 		NOT NULL,

	Nombre			varchar(255)	NULL,
	Fecha			datetime	NULL,
	Ok			int		NULL,
	OkRef			varchar(255)	NULL,

	CONSTRAINT pk_agdArchivoLog PRIMARY KEY CLUSTERED (ID)
)
GO


--drop table agdCartaCupo
--select * from agdCartaCupo

/****** agdCartaCupo ******/
if not exists(select * from SysTabla where SysTabla = 'agdCartaCupo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('agdCartaCupo','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.agdCartaCupo') and type = 'U') 
BEGIN
  CREATE TABLE dbo.agdCartaCupo (
		ID			int IDENTITY(1,1)	NOT NULL,

		Estatus			varchar(15)		NULL,	-- BORRADOR, ALTA, CANCELADO
		Situacion		varchar(50)		NULL,	-- Normal, Cancelado, en Rectificacion, en Traslado, en Traspaso
		Usuario			varchar(10)		NULL,
		UltimoCambio		datetime		NULL,

		Folio			varchar(10)		NULL,
		FechaEmision		datetime		NULL,	-- Hoy
		FechaExpedicion		datetime		NULL,	-- Ahora
		TipoMovimiento		char(1)			NULL,	-- 1
		Pedimento		varchar(20)		NULL,
		AduanaDespacho		varchar(10)		NULL,
		AduanaCircunscripcion	varchar(10)		NULL,
		TipoDocumento		varchar(10)		NULL,	-- A4
		Cliente			varchar(10)		NULL,
		ClienteRFC		varchar(20)		NULL,
		AgenteAduanal		varchar(10)		NULL,	-- Proveedor
		AgenteAduanalRFC	varchar(20)		NULL,	
		AgenteAduanalCURP	varchar(20)		NULL,	
		DestinoMercancia	varchar(10)		NULL,	-- 09 = Nacional
		SF			varchar(5)		NULL,
		AG			varchar(5)		NULL,
		CC			varchar(5)		NULL,

		Observaciones		varchar(255)		NULL,

		AlmacenadoraOrigen	varchar(10)		NULL,
		AlmacenOrigen		varchar(10)		NULL,
		FolioOrigen		varchar(20)		NULL,

		EntradaReferencia	varchar(50)		NULL,
		EntradaFecha		datetime		NULL,
		SalidaReferencia	varchar(50)		NULL,
		SalidaFecha		datetime		NULL,

		CONSTRAINT pk_agdCartaCupo PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'agdCartaCupo'
END
GO

/****** agdCartaCupoArchivo ******/
if not exists(select * from SysTabla where SysTabla = 'agdCartaCupoArchivo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('agdCartaCupoArchivo','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.agdCartaCupoArchivo') and type = 'U') 
BEGIN
  CREATE TABLE dbo.agdCartaCupoArchivo (
		ID		int			NOT NULL,
		RID		int IDENTITY(1,1)	NOT NULL,

		TipoArchivo	varchar(20)		NULL,		-- Carta Cupo, Traspaso, Cancelacion, Rectificacion
		Nombre		varchar(100)		NULL,
		Fecha		datetime		NULL,
		Firma		varchar(20)		NULL,

  CONSTRAINT pk_agdCartaCupoArchivo PRIMARY KEY CLUSTERED (ID, RID)
  )
  EXEC spSincroSemilla 'agdCartaCupoArchivo'
END
GO


/****** agdCartaCupoD ******/
if not exists(select * from SysTabla where SysTabla = 'agdCartaCupoD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('agdCartaCupoD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.agdCartaCupoD') and type = 'U') 
BEGIN
  CREATE TABLE dbo.agdCartaCupoD (
		ID			int			NOT NULL,
		RID			int IDENTITY(1,1)	NOT NULL,

		Fraccion		varchar(20)		NULL,
		Secuencia		int			NULL,
		ValorEnDolares		money			NULL,
		Cantidad		float			NULL,
		UnidadMedidaTarifa	varchar(10)		NULL,


  CONSTRAINT pk_agdCartaCupoD PRIMARY KEY CLUSTERED (ID, RID)
  )
  EXEC spSincroSemilla 'agdCartaCupoD'
END
GO


/**************** sp_agdCartaCupoLeer ****************/
if exists (select * from sysobjects where id = object_id('dbo.sp_agdCartaCupoLeer') and type = 'P') drop procedure dbo.sp_agdCartaCupoLeer
GO
CREATE PROCEDURE sp_agdCartaCupoLeer
			@ArchivoID	int,
			@ArchivoNombre	varchar(255),
			@ArchivoTipo	char(1),
			@Hoy		datetime,
			@Ahora		datetime,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			int,
    @Tipo		varchar(50),
    @Datos		varchar(8000),
    @Valor		varchar(255),
    @Conteo		int,
    @EstatusInterfase	varchar(15),
    @TipoMovimiento	char(1),
    @Pedimento		varchar(20),
    @AduanaDespacho	varchar(10),
    @TipoDocumento	varchar(10),
    @Cliente		varchar(10),
    @ClienteRFC		varchar(20),
    @AgenteAduanal	varchar(10),
    @AgenteAduanalCURP	varchar(20),
    @AgenteAduanalRFC	varchar(20),
    @DestinoMercancia	varchar(10),
    @TipoCaso		varchar(5),
    @SF			varchar(5),
    @AG			varchar(5),
    @CC			varchar(5),
    @Fraccion		varchar(20),
    @Secuencia		int,
    @ValorEnDolares	money,
    @Cantidad		float,
    @UnidadInt		int,
    @UnidadMedidaTarifa	varchar(10),
    @ConsecutivoTipo	varchar(50),
    @Folio		varchar(10),
    @Firma		varchar(50)
    
  SELECT @Tipo = 'Carta Cupo', @EstatusInterfase = NULL, @Firma = NULL
  DECLARE crArchivoD CURSOR LOCAL FOR 
   SELECT Datos
     FROM ArchivoD
    WHERE ID = @ArchivoID
    ORDER BY RID

  OPEN crArchivoD
  FETCH NEXT FROM crArchivoD INTO @Datos
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' 
      IF @Valor = '500'
      BEGIN
        SELECT @EstatusInterfase = 'INICIO'
        EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' SELECT @TipoMovimiento = @Valor
        EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' SELECT @AgenteAduanal  = @Valor
        EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' SELECT @Pedimento      = @Valor
        EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' SELECT @AduanaDespacho = @Valor
        INSERT agdCartaCupo 
               (Estatus,    Situacion, TipoMovimiento,  AgenteAduanal,  Pedimento,  AduanaDespacho) 
        VALUES ('BORRADOR', 'Normal',  @TipoMovimiento, @AgenteAduanal, @Pedimento, @AduanaDespacho)
        SELECT @ID = SCOPE_IDENTITY()
      END ELSE
      IF @EstatusInterfase = 'INICIO'
      BEGIN
        IF @Valor = '501'
        BEGIN
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' 
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' 
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' 
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' 
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' SELECT @TipoDocumento = @Valor
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' 
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' 
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' SELECT @ClienteRFC = @Valor
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' SELECT @AgenteAduanalCURP = @Valor
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' SELECT @AgenteAduanalRFC = @Valor
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' 
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' 
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' 
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' 
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' 
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' 
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' 
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' 
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' 
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' SELECT @DestinoMercancia = @Valor
        END ELSE
        IF @Valor = '507'
        BEGIN
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' SELECT @TipoCaso = @Valor
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' 
          IF @TipoCaso = 'SF' SELECT @SF = @Valor ELSE
          IF @TipoCaso = 'AG' SELECT @AG = @Valor ELSE
          IF @TipoCaso = 'CC' SELECT @CC = @Valor
        END ELSE
        IF @Valor = '551'
        BEGIN
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' 
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' SELECT @Fraccion = @Valor
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' SELECT @Secuencia = CONVERT(int, @Valor)
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' 
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' 
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' 
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' 
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' 
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' SELECT @ValorEnDolares = CONVERT(money, @Valor)
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' 
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' 
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' SELECT @Cantidad = CONVERT(float, @Valor)
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' SELECT @UnidadInt = CONVERT(int, @Valor)
          EXEC spLlenarCeros @UnidadInt, 2, @UnidadMedidaTarifa OUTPUT
          INSERT agdCartaCupoD 
                 (ID,  Fraccion,  Secuencia,  ValorEnDolares,  Cantidad,  UnidadMedidaTarifa)
          VALUES (@ID, @Fraccion, @Secuencia, @ValorEnDolares, @Cantidad, @UnidadMedidaTarifa)
        END ELSE
        IF @Valor = '801'
        BEGIN
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' IF UPPER(@Valor) <> UPPER(@ArchivoNombre) SELECT @Ok = 16030
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' IF @Valor <> '1' SELECT @Ok = 16040
          EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, '|' IF CONVERT(int, @Valor) <> @Conteo SELECT @Ok = 16050
          SELECT @EstatusInterfase = 'FIN'
        END
      END
      SELECT @Conteo = @Conteo + 1
    END
    FETCH NEXT FROM crArchivoD INTO @Datos
  END
  CLOSE crArchivoD
  DEALLOCATE crArchivoD
  IF @EstatusInterfase <> 'FIN' AND @Ok IS NULL SELECT @Ok = 16020

  IF @Ok IS NULL
  BEGIN
    SELECT @Cliente = NULL, @AgenteAduanal = NULL
    SELECT @Cliente = Cliente FROM Cte WHERE RFC = @ClienteRFC
    IF @Cliente IS NULL SELECT @Ok = 16060, @OkRef = @ClienteRFC
    SELECT @AgenteAduanal = MIN(Proveedor) FROM Prov WHERE RFC = @AgenteAduanalRFC OR CURP = @AgenteAduanalCURP
    IF @AgenteAduanal IS NULL SELECT @Ok = 16070, @OkRef = @AgenteAduanalRFC
    IF (SELECT Almacen FROM Alm WHERE Almacen = @AG) <> @AG
      SELECT @Ok = 16080, @OkRef = @AG
  END

  IF @Ok IS NULL
  BEGIN
    SELECT @ConsecutivoTipo = @Tipo + ' ' + CONVERT(varchar, YEAR(@Hoy))
    IF NOT EXISTS(SELECT * FROM Consecutivo WHERE Tipo = @ConsecutivoTipo)
      INSERT Consecutivo (Tipo, Nivel, Prefijo, Consecutivo) VALUES (@ConsecutivoTipo, 'Global', NULL, 0)

    EXEC spConsecutivo @ConsecutivoTipo, 0, @Folio OUTPUT

    UPDATE agdCartaCupo 
       SET FechaEmision      = @Hoy,
	   FechaExpedicion   = @Ahora,
           Folio             = @Folio,
           TipoDocumento     = @TipoDocumento,
           Cliente	     = @Cliente,
           ClienteRFC        = @ClienteRFC,
	   AgenteAduanal     = @AgenteAduanal,
           AgenteAduanalCURP = @AgenteAduanalCURP,
           AgenteAduanalRFC  = @AgenteAduanalRFC,
           DestinoMercancia  = @DestinoMercancia,
           SF                = @SF,
           AG		     = @AG,
	   CC		     = @CC
     WHERE ID = @ID

    INSERT agdCartaCupoArchivo 
           (ID,  TipoArchivo, Nombre,         Fecha,  Firma)
    VALUES (@ID, @Tipo,       @ArchivoNombre, @Ahora, @Firma)
  END

  RETURN
END
GO

-- sp_agdArchivoLeer 0
/**************** sp_agdArchivoLeer ****************/
if exists (select * from sysobjects where id = object_id('dbo.sp_agdArchivoLeer') and type = 'P') drop procedure dbo.sp_agdArchivoLeer
GO
CREATE PROCEDURE sp_agdArchivoLeer
			@ArchivoID	int,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ArchivoNombre	varchar(255),
    @ArchivoTipo	char(1),
    @ArchivoPatente	char(4),
    @ArchivoConsecutivo	char(3),
    @Dia		char(3),
    @Hoy		datetime,
    @Ahora		datetime,
    @DiaDelAno		int

-- D3839579.198

  SELECT @Ahora = GETDATE()
  SELECT @Hoy = dbo.fnFechaSinHora(@Ahora)
  SELECT @DiaDelAno = dbo.fnDiaDelAno(@Hoy)

  SELECT @ArchivoNombre      = UPPER(Nombre) FROM Archivo WHERE ID = @ArchivoID
  SELECT @ArchivoTipo        = SUBSTRING(@ArchivoNombre,  1, 1),
         @ArchivoPatente     = SUBSTRING(@ArchivoNombre,  2, 4),
         @ArchivoConsecutivo = SUBSTRING(@ArchivoNombre,  6, 3),
         @Dia                = SUBSTRING(@ArchivoNombre, 10, 3)
  IF @Dia <> @DiaDelAno SELECT @Ok = 16010

  IF @Ok IS NULL
  BEGIN
    BEGIN TRANSACTION

    IF @ArchivoTipo IN ('D', 'P') 
      EXEC sp_agdCartaCupoLeer @ArchivoID, @ArchivoNombre, @ArchivoTipo, @Hoy, @Ahora, @Ok OUTPUT, @OkRef OUTPUT

    IF @Ok IS NULL
      COMMIT TRANSACTION
    ELSE
      ROLLBACK TRANSACTION
  END

  INSERT agdArchivoLog 
         (ID,         Nombre,         Fecha,  Ok,  OkRef)
  VALUES (@ArchivoID, @ArchivoNombre, @Ahora, @Ok, @OkRef)
  RETURN
END
GO

/**************** xpArchivoLeer ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpArchivoLeer') and type = 'P') drop procedure dbo.xpArchivoLeer
GO
CREATE PROCEDURE xpArchivoLeer
			@ID		int,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
AS BEGIN
  EXEC sp_agdArchivoLeer @ID, @Ok OUTPUT, @OkRef OUTPUT
  RETURN
END
GO



/**************** sp_agdCartaCupoEscribir ****************/
if exists (select * from sysobjects where id = object_id('dbo.sp_agdCartaCupoEscribir') and type = 'P') drop procedure dbo.sp_agdCartaCupoEscribir
GO
CREATE PROCEDURE sp_agdCartaCupoEscribir
			@ID			int,
			@TipoMovimiento		varchar(2)	--  A/AT/C/CT/CA/AI/CI/TL/XT/TP/XP/ID/XI
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ArchivoID			int,
    @ArchivoNombre		varchar(255),
    @Tipo			varchar(50),
    @ArchivoFolioInt		int,
    @ArchivoFolioSt		varchar(20),
    @PatenteAlmacenFiscal	varchar(10),
    @PatenteAlmacenadora	varchar(10),
    @Hoy			datetime,
    @Ahora			datetime,
    @DiaDelAno			int,
    @DiaDelAnoSt		varchar(3),
    @Prefijo			varchar(100),
    @Folio			varchar(10),
    @Cliente			varchar(10),
    @AgenteAduanal		varchar(10),
    @AgenteAduanalRFC		varchar(20),
    @AgenteAduanalCURP		varchar(20),
    @AduanaDespacho		varchar(10),
    @SF				varchar(5),
    @AG				varchar(5),
    @CC				varchar(5),
    @ValorEnDolares		money,
    @Conteo			int,
    @Ok				int,
    @OkRef			varchar(255)

  SELECT @Tipo = 'Carta Cupo', @Ok = NULL, @OkRef = NULL
  SELECT @Ahora = GETDATE()
  SELECT @Hoy = dbo.fnFechaSinHora(@Ahora)
  SELECT @DiaDelAno = dbo.fnDiaDelAno(@Hoy)

  IF NOT EXISTS(SELECT * FROM Consecutivo WHERE Tipo = @Tipo)
    INSERT Consecutivo (Tipo, Nivel, Prefijo, Consecutivo) VALUES (@Tipo, 'Global', NULL, 0)

  EXEC spConsecutivo @Tipo, 0, @ArchivoFolioSt OUTPUT
  IF LEN(@ArchivoFolioSt)>3
  BEGIN
    UPDATE Consecutivo SET Consecutivo = 0 WHERE Tipo = @Tipo
    EXEC spConsecutivo @Tipo, 0, @ArchivoFolioSt OUTPUT
  END
  SELECT @ArchivoFolioInt = CONVERT(int, @ArchivoFolioSt)
  EXEC spLlenarCeros @ArchivoFolioInt, 3, @ArchivoFolioSt OUTPUT
  EXEC spLlenarCeros @DiaDelAno, 3, @DiaDelAnoSt OUTPUT

  SELECT @PatenteAlmacenFiscal = MIN(PatenteAlmacenFiscal), @PatenteAlmacenadora = ISNULL(MIN(PatenteAlmacenadora), '') FROM agdCfg
  SELECT @ArchivoNombre = 'Q'+@PatenteAlmacenadora+@ArchivoFolioSt+'.'+@DiaDelAnoSt

  SELECT @Folio             = Folio, 
         @Cliente           = Cliente, 
         @AgenteAduanal     = ISNULL(AgenteAduanal, ''), 
         @AgenteAduanalRFC  = ISNULL(AgenteAduanalRFC, ''),
         @AgenteAduanalCURP = ISNULL(AgenteAduanalCURP, ''),
         @AduanaDespacho    = ISNULL(AduanaDespacho, ''),
         @SF		    = ISNULL(SF, ''),
         @AG		    = ISNULL(AG, ''),
         @CC		    = ISNULL(CC, '')
    FROM agdCartaCupo
   WHERE ID = @ID
  IF @Folio IS NULL SELECT @Ok = 16090, @OkRef = CONVERT(varchar, @ID)

  SELECT @ValorEnDolares = SUM(ValorEnDolares)
    FROM agdCartaCupoD
   WHERE ID = @ID

  SELECT @Prefijo = @PatenteAlmacenFiscal+'|'+@PatenteAlmacenadora+'|'+@Folio

  IF @Ok IS NULL
  BEGIN
    BEGIN TRANSACTION

    EXEC spArchivo @ArchivoNombre, NULL, @ArchivoID OUTPUT
    INSERT ArchivoD (ID, Datos) SELECT @ArchivoID, '611'+'|'+@Prefijo+'|'+@TipoMovimiento+'|'
    INSERT ArchivoD (ID, Datos) SELECT @ArchivoID, '612'+'|'+@Prefijo+'|1|'+ISNULL(RFC, '')+'|'+ISNULL(CURP, '')+'|'+ISNULL(Nombre, '')+'|'+@AgenteAduanal+'|'+@AgenteAduanalRFC+'|'+@AgenteAduanalCURP+'|'+CONVERT(varchar, @ValorEnDolares)+'|'  FROM Cte WHERE Cliente = @Cliente
    INSERT ArchivoD (ID, Datos) SELECT @ArchivoID, '613'+'|'+@Prefijo+'|1|'+@AduanaDespacho+'|'

    IF @TipoMovimiento = 'A' 
      INSERT ArchivoD (ID, Datos) SELECT @ArchivoID, '614'+'|'+@Prefijo+'|SDF|'+@SF+'|'

    INSERT ArchivoD (ID, Datos) SELECT @ArchivoID, '651'+'|'+@Prefijo+'|1|'+ISNULL(Fraccion,'')+'|'+ISNULL(CONVERT(varchar, Secuencia), '')+'|'+ISNULL(UnidadMedidaTarifa,'')+'|'+ISNULL(CONVERT(varchar, Cantidad), '')+'||' FROM agdCartaCupoD WHERE ID = @ID ORDER BY Secuencia

    SELECT @Conteo = COUNT(*) FROM ArchivoD WHERE ID = @ArchivoID
    INSERT ArchivoD (ID, Datos) SELECT @ArchivoID, '199'+'|1|'+CONVERT(varchar, @Conteo)+'|'

    UPDATE Archivo SET Accion = 'ESCRIBIR' WHERE ID = @ArchivoID

    IF @Ok IS NULL
      COMMIT TRANSACTION
    ELSE
      ROLLBACK TRANSACTION
  END

  INSERT agdArchivoLog 
         (ID,         Nombre,         Fecha,  Ok,  OkRef)
  VALUES (@ArchivoID, @ArchivoNombre, @Ahora, @Ok, @OkRef)

  RETURN
END
GO
