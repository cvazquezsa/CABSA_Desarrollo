/**************************************************************************************************/
/************************** EN INTELISIS PARA ACCESAR AL MODULO CENTRAL ***************************/
/**************************************************************************************************/

/************** spMCResultadoOk *************/
if exists (select * from sysobjects where id = object_id('dbo.spMCResultadoOk') and type = 'P') drop procedure dbo.spMCResultadoOk
GO
CREATE PROCEDURE spMCResultadoOk
			@Resultado	nvarchar(max),
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @iResultado		int,
    @ResultadoTipo	varchar(20),
    @ResultadoOk	int,
    @ResultadoOkRef	varchar(255)

  EXEC sp_xml_preparedocument @iResultado OUTPUT, @Resultado
  SELECT @ResultadoTipo = UPPER(Tipo), @ResultadoOk = Ok, @ResultadoOkRef = OkRef
    FROM OPENXML (@iResultado, '/Intelisis/Resultado', 1) 
    WITH (Tipo varchar(20), Ok int, OkRef varchar(255))

  IF UPPER(@ResultadoTipo) <> 'OK' 
  BEGIN
    SELECT @OkRef = ISNULL(@ResultadoOkRef, '') + ' ('+CONVERT(varchar, @ResultadoOk)+')' 
    SELECT @Ok = CASE @ResultadoTipo
                   WHEN 'ERROR' THEN 18010
                   WHEN 'ERROR-SQL' THEN 18020
                   WHEN 'ERROR-CLR' THEN 18021
                   WHEN 'INFORMACION' THEN 18030
                   WHEN 'CONFIGURACION' THEN 18040
                   WHEN 'PRECAUCION' THEN 18050
                 END
  EXEC sp_xml_removedocument @iResultado
  END
END
GO

/************** spMCResultadoXMLOk *************/
if exists (select * from sysobjects where id = object_id('dbo.spMCResultadoXMLOk') and type = 'P') drop procedure dbo.spMCResultadoXMLOk
GO
CREATE PROCEDURE spMCResultadoXMLOk
			@Resultado	xml,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @iResultado		int,
    @ResultadoTipo	varchar(20),
    @ResultadoOk	int,
    @ResultadoOkRef	varchar(255)

  EXEC sp_xml_preparedocument @iResultado OUTPUT, @Resultado
  SELECT @ResultadoTipo = UPPER(Tipo), @ResultadoOk = Ok, @ResultadoOkRef = OkRef
    FROM OPENXML (@iResultado, '/Intelisis/Resultado', 1) 
    WITH (Tipo varchar(20), Ok int, OkRef varchar(255))

  IF UPPER(@ResultadoTipo) <> 'OK' 
  BEGIN
    SELECT @OkRef = ISNULL(@ResultadoOkRef, '') + ' ('+CONVERT(varchar, @ResultadoOk)+')' 
    SELECT @Ok = CASE @ResultadoTipo
                   WHEN 'ERROR' THEN 18010
                   WHEN 'ERROR-SQL' THEN 18020
                   WHEN 'ERROR-CLR' THEN 18021
                   WHEN 'INFORMACION' THEN 18030
                   WHEN 'CONFIGURACION' THEN 18040
                   WHEN 'PRECAUCION' THEN 18050
                 END
  EXEC sp_xml_removedocument @iResultado
  END
END
GO


/************** spModuloCentral *************/
if exists (select * from sysobjects where id = object_id('dbo.spModuloCentral') and type = 'P') drop procedure dbo.spModuloCentral
GO
CREATE PROCEDURE spModuloCentral
			@Accion		varchar(50),
			@Datos		nvarchar(max), 
			@Resultado	nvarchar(max)	OUTPUT,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT,
			@ProcesarCola	bit = 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE	
    @ModuloCentral		bit,
    @ModuloCentralURL		varchar(255),
    @Desconectar		varchar(20),
    @Reconectar			varchar(20),
    @EstaDesconectado		bit,
    @FechaDesconexion		datetime,
    @ReconexionFrecuencia	int,
    @ReconexionUltimoIntento	datetime,
    @Cache			varchar(20),
    @Cola			varchar(20),
    @EnFrecuencia		bit,
    @Llave			varchar(900),
    @Replica			bit

  SELECT @Resultado = NULL, @Cache = NULL
  SELECT @ModuloCentral = ISNULL(ModuloCentral, 0), 
         @ModuloCentralURL = ModuloCentralURL,
	 @Desconectar = UPPER(Desconectar),
	 @Reconectar = UPPER(Reconectar),
	 @EstaDesconectado = ISNULL(EstaDesconectado, 0),
	 @FechaDesconexion = FechaDesconexion,
	 @ReconexionFrecuencia = NULLIF(ReconexionFrecuencia, 0),
	 @ReconexionUltimoIntento = ReconexionUltimoIntento,
         @Replica = ISNULL(Replica, 0)
    FROM Version
  IF @ModuloCentral = 0 RETURN

  SELECT @Cache = UPPER(Cache),
         @Cola  = UPPER(Cola) 
    FROM CfgModuloCentralAccion 
   WHERE Accion = @Accion
  IF @EstaDesconectado = 1 AND @ProcesarCola = 1 RETURN

  SELECT @EnFrecuencia = 0
  -- checar frecuencia
  IF @ReconexionFrecuencia IS NOT NULL AND DATEDIFF(minute, @ReconexionUltimoIntento, GETDATE())>=@ReconexionFrecuencia
    SELECT @EnFrecuencia = 1

  SELECT @Llave = RIGHT(@Datos, 900)
  IF @ProcesarCola = 0
  BEGIN
    IF @Cache = 'POR OMISION'
    BEGIN  
      SELECT TOP 1 @Resultado = Resultado
        FROM mcCache
       WHERE Llave = @Llave AND Accion = @Accion AND Datos = @Datos
       ORDER BY UltimoCambio DESC

      IF @Resultado IS NOT NULL 
        RETURN
    END ELSE
    IF @Cola = 'POR OMISION'
    BEGIN
      INSERT mcColaSalida (
              Accion,  Datos,  Estatus,       EstatusFecha)
      VALUES (@Accion, @Datos, 'SINPROCESAR', GETDATE())
      RETURN
    END
  END

  IF @EstaDesconectado = 0 OR (@Reconectar = 'AUTOMATICO' AND @EnFrecuencia = 1)
  BEGIN
    BEGIN TRY
      EXEC clrModuloCentral @ModuloCentralURL, @Datos, @Resultado OUTPUT
      EXEC spMCResultadoOk @Resultado, @Ok OUTPUT, @OkRef OUTPUT  
      IF @Ok IS NULL
      BEGIN
        IF @Cache IN ('POR OMISION', 'DESCONECTADO')
        BEGIN
          UPDATE mcCache
             SET Llave = @Llave, UltimoCambio = GETDATE(), Accion = @Accion, Datos = @Datos, Resultado = @Resultado
           WHERE Llave = @Llave AND Accion = @Accion AND Datos = @Datos
          IF @@ROWCOUNT = 0
            INSERT mcCache (
                    Llave,  UltimoCambio, Accion,  Datos,  Resultado)
            VALUES (@Llave, GETDATE(),    @Accion, @Datos, @Resultado)
        END

        IF @EstaDesconectado = 1 AND @Reconectar  = 'AUTOMATICO' 
          UPDATE Version SET @EstaDesconectado = EstaDesconectado = 0, FechaDesconexion = NULL, ReconexionUltimoIntento = NULL
      END
    END TRY
    BEGIN CATCH
      IF (@EstaDesconectado = 0 AND @Desconectar = 'AUTOMATICO') OR 
         (@EstaDesconectado = 1 AND @Reconectar  = 'AUTOMATICO')
        UPDATE Version SET @EstaDesconectado = EstaDesconectado = 1, FechaDesconexion = CASE WHEN @EstaDesconectado = 0 THEN GETDATE() ELSE FechaDesconexion END, ReconexionUltimoIntento = GETDATE()
      ELSE
        SELECT @Ok = 1, @OkRef = dbo.fnOkRefSQL(ERROR_NUMBER(), ERROR_MESSAGE())
    END CATCH
  END

  IF @Ok IS NULL AND @ProcesarCola = 0
  BEGIN
    IF @EstaDesconectado = 0
    BEGIN
      EXEC spMCProcesarCola @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      IF @Ok IS NULL AND @Replica = 1
        EXEC spMCProcesarReplica @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    END ELSE BEGIN
      IF @Cache = 'DESCONECTADO'
        SELECT TOP 1 @Resultado = Resultado
          FROM mcCache
         WHERE Llave = @Llave AND Accion = @Accion AND Datos = @Datos
       ORDER BY UltimoCambio DESC
      ELSE 
      IF @Cola = 'DESCONECTADO'
        INSERT mcColaSalida (
                Accion,  Datos,  Estatus,       EstatusFecha)
        VALUES (@Accion, @Datos, 'SINPROCESAR', GETDATE())
      ELSE
        SELECT @Ok = 2, @OkRef = 'Esta Desconectado'
    END
  END

  RETURN
END
GO


/************** spMCProcesarCola *************/
if exists (select * from sysobjects where id = object_id('dbo.spMCProcesarCola') and type = 'P') drop procedure dbo.spMCProcesarCola
GO
CREATE PROCEDURE spMCProcesarCola
			@EnSilencio	bit		= 0,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Accion			varchar(50),
    @Datos			nvarchar(max),
    @Resultado			nvarchar(max),
    @ConservarColaProcesada	int,
    @TamanoLoteProcesarCola	int

  SELECT @ConservarColaProcesada = ConservarColaProcesada, 
         @TamanoLoteProcesarCola = TamanoLoteProcesarCola 
    FROM Version

  IF @TamanoLoteProcesarCola IS NULL
    DECLARE crProcesarCola CURSOR LOCAL FOR
     SELECT Accion, Datos
       FROM mcColaSalida
      WHERE Estatus = 'SINPROCESAR'
      ORDER BY EstatusFecha
  ELSE
    DECLARE crProcesarCola CURSOR LOCAL FOR
     SELECT TOP (@TamanoLoteProcesarCola) Accion, Datos
       FROM mcColaSalida
      WHERE Estatus = 'SINPROCESAR'
      ORDER BY EstatusFecha

  OPEN crProcesarCola
  FETCH NEXT FROM crProcesarCola INTO @Accion, @Datos
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      BEGIN TRY
        BEGIN TRANSACTION trProcesarCola

        UPDATE mcColaSalida SET Estatus = 'ENPROCESO', EstatusFecha = GETDATE() WHERE CURRENT OF crProcesarCola
        EXEC spModuloCentral @Accion, @Datos, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @ProcesarCola = 1
        UPDATE mcColaSalida SET Resultado = @Resultado, Estatus = 'PROCESADO', EstatusFecha = GETDATE(), Ok = @Ok, OkRef = @OkRef WHERE CURRENT OF crProcesarCola

        COMMIT TRANSACTION trProcesarCola
      END TRY 
      BEGIN CATCH
        ROLLBACK TRANSACTION trProcesarCola
        SELECT @Ok = 1, @OkRef = dbo.fnOkRefSQL(ERROR_NUMBER(), ERROR_MESSAGE())
      END CATCH
    END
    FETCH NEXT FROM crProcesarCola INTO @Accion, @Datos
  END
  CLOSE crProcesarCola
  DEALLOCATE crProcesarCola

  IF @Ok IS NULL
    DELETE mcColaSalida
     WHERE Estatus = 'PROCESADO' AND DATEDIFF(hour, EstatusFecha, GETDATE()) > ISNULL(@ConservarColaProcesada, 0)

  IF @EnSilencio = 0
    EXEC spOk_RAISERROR @Ok, @OkRef
  RETURN
END
GO


/************** spMCProcesarReplica *************/
if exists (select * from sysobjects where id = object_id('dbo.spMCProcesarReplica') and type = 'P') drop procedure dbo.spMCProcesarReplica
GO
CREATE PROCEDURE spMCProcesarReplica
			@EnSilencio	bit		= 0,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Tema			varchar(50),
    @Llave			varchar(255),
    @Tabla			varchar(100),
    @Campo			varchar(100),
    @Campo2			varchar(100),
    @Valor2			varchar(100),
    @Campo3			varchar(100),
    @Valor3			varchar(100),
    @Campo4			varchar(100),
    @Valor4			varchar(100),
    @Campo5			varchar(100),
    @Valor5			varchar(100),
    @WHERE			varchar(8000),
    @ConservarReplicaProcesada	int,
    @TamanoLoteProcesarReplica	int

  SELECT @ConservarReplicaProcesada = ConservarReplicaProcesada, 
         @TamanoLoteProcesarReplica = TamanoLoteProcesarReplica
    FROM Version

  DECLARE crProcesarReplica CURSOR LOCAL FOR
   SELECT cfg.Tema
     FROM CfgModuloCentralReplica cfg
    WHERE NULLIF(cfg.Frecuencia, 0) IS NOT NULL AND DATEDIFF(minute, cfg.UltimaReplica, GETDATE())>=cfg.Frecuencia AND cfg.Estatus = 'ACTIVO'
  OPEN crProcesarReplica
  FETCH NEXT FROM crProcesarReplica INTO @Tema
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @TamanoLoteProcesarReplica IS NULL
        DECLARE crProcesarTabla CURSOR LOCAL FOR
         SELECT r.Llave, cfg.Tabla, cfg.Campo, NULLIF(RTRIM(cfg.Campo2), ''), cfg.Valor2, NULLIF(RTRIM(cfg.Campo3), ''), cfg.Valor3, NULLIF(RTRIM(cfg.Campo4), ''), cfg.Valor4, NULLIF(RTRIM(cfg.Campo5), ''), cfg.Valor5
           FROM mcReplicaSalida r
           JOIN CfgModuloCentralReplicaTabla cfg ON cfg.Tema = r.Tema
          WHERE r.Tema = @Tema AND r.Estatus = 'SINPROCESAR'
      ELSE
        DECLARE crProcesarTabla CURSOR LOCAL FOR
         SELECT TOP (@TamanoLoteProcesarReplica) r.Llave, cfg.Tabla, cfg.Campo, NULLIF(RTRIM(cfg.Campo2), ''), cfg.Valor2, NULLIF(RTRIM(cfg.Campo3), ''), cfg.Valor3, NULLIF(RTRIM(cfg.Campo4), ''), cfg.Valor4, NULLIF(RTRIM(cfg.Campo5), ''), cfg.Valor5
           FROM mcReplicaSalida r
           JOIN CfgModuloCentralReplicaTabla cfg ON cfg.Tema = r.Tema
          WHERE r.Tema = @Tema AND r.Estatus = 'SINPROCESAR'

      OPEN crProcesarTabla
      FETCH NEXT FROM crProcesarTabla INTO @Llave, @Tabla, @Campo, @Campo2, @Valor2, @Campo3, @Valor3, @Campo4, @Valor4, @Campo5, @Valor5
      WHILE @@FETCH_STATUS <> -1 
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          SELECT @WHERE = @Campo+'="'+@Llave+'"'
          IF @Campo2 IS NOT NULL SELECT @WHERE = @WHERE + ' AND '+@Campo2+'='+@Valor2
          IF @Campo3 IS NOT NULL SELECT @WHERE = @WHERE + ' AND '+@Campo3+'='+@Valor3
          IF @Campo4 IS NOT NULL SELECT @WHERE = @WHERE + ' AND '+@Campo4+'='+@Valor4
          IF @Campo5 IS NOT NULL SELECT @WHERE = @WHERE + ' AND '+@Campo5+'='+@Valor5
          BEGIN TRY
            BEGIN TRANSACTION trProcesarReplica

            UPDATE mcReplicaSalida SET Estatus = 'ENPROCESO', EstatusFecha = GETDATE() WHERE CURRENT OF crProcesarTabla
            EXEC spMCAlmacenarDatos @Tabla, @Llave, @WHERE, @EnSilencio = @EnSilencio OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
            UPDATE mcReplicaSalida SET Estatus = 'PROCESADO', EstatusFecha = GETDATE(), Ok = @Ok, OkRef = @OkRef WHERE CURRENT OF crProcesarTabla
            UPDATE CfgModuloCentralReplica SET UltimaReplica = GETDATE() WHERE CURRENT OF crProcesarReplica

            COMMIT TRANSACTION trProcesarReplica
          END TRY 
          BEGIN CATCH
            ROLLBACK TRANSACTION trProcesarReplica
            SELECT @Ok = 1, @OkRef = dbo.fnOkRefSQL(ERROR_NUMBER(), ERROR_MESSAGE())
          END CATCH
        END
        FETCH NEXT FROM crProcesarTabla INTO @Llave, @Tabla, @Campo, @Campo2, @Valor2, @Campo3, @Valor3, @Campo4, @Valor4, @Campo5, @Valor5
      END
      CLOSE crProcesarTabla
      DEALLOCATE crProcesarTabla
    END
    FETCH NEXT FROM crProcesarReplica INTO @Tema
  END
  CLOSE crProcesarReplica
  DEALLOCATE crProcesarReplica

  IF @Ok IS NULL
    DELETE mcReplicaSalida
     WHERE Estatus = 'PROCESADO' AND DATEDIFF(hour, EstatusFecha, GETDATE()) > ISNULL(@ConservarReplicaProcesada, 0)

  IF @EnSilencio = 0
    EXEC spOk_RAISERROR @Ok, @OkRef
  RETURN
END
GO

/************** spMCMovDatos *************/
if exists (select * from sysobjects where id = object_id('dbo.spMCMovDatos') and type = 'P') drop procedure dbo.spMCMovDatos
GO
CREATE PROCEDURE spMCMovDatos
			@Modulo			varchar(5), 
			@ModuloID		int, 			
			@DatosMov		nvarchar(max)	OUTPUT,
			@DatosImpuestos		nvarchar(max)	OUTPUT,
			@DatosPresupuesto	nvarchar(max)	OUTPUT,
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  IF @Modulo = 'VTAS' 
    SELECT @DatosMov = (SELECT * FROM Venta JOIN VentaD ON VentaD.ID = Venta.ID WHERE Venta.ID = @ModuloID FOR XML AUTO)

  SELECT @DatosImpuestos   = (SELECT * FROM MovImpuesto    WHERE Modulo = @Modulo AND ModuloID = @ModuloID FOR XML AUTO)
  SELECT @DatosPresupuesto = (SELECT * FROM MovPresupuesto WHERE Modulo = @Modulo AND ModuloID = @ModuloID FOR XML AUTO)
END
GO
-- cont

-- spMCMov 'DEMO', 0, 'VTAS', 35, 'SINAFECTAR', 'CONCLUIDO', 'DEMO', '1/1/2007', '1/1/2007', 'Factura', '13', 'VTAS.F', NULL, NULL, NULL
/************** spMCMov *************/
if exists (select * from sysobjects where id = object_id('dbo.spMCMov') and type = 'P') drop procedure dbo.spMCMov
GO
CREATE PROCEDURE spMCMov
                   @Empresa		varchar(5),
		   @Sucursal		int,
		   @Modulo		varchar(5), 
		   @ModuloID		int, 			
		   @Estatus		varchar(15), 
                   @EstatusNuevo	varchar(15),
		   @Usuario		varchar(10),
		   @FechaEmision	datetime, 	
		   @FechaRegistro	datetime,
		   @Mov			varchar(20),
		   @MovID		varchar(20),
		   @MovTipo		varchar(20),
		   @IDGenerar		int,
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE	
    @Moneda2		varchar(10),
    @TipoCambio2	float,
    @Datos		nvarchar(max),
    @DatosMov		nvarchar(max),
    @DatosImpuestos	nvarchar(max),
    @DatosPresupuesto	nvarchar(max),
    @Resultado		nvarchar(max)

  SELECT @TipoCambio2 = NULL
  SELECT @Moneda2 = ContMoneda2 FROM EmpresaCfg WHERE Empresa = @Empresa
  IF @Moneda2 <> '(No)'
    SELECT @TipoCambio2 = TipoCambio FROM Mon WHERE Moneda = @Moneda2

  EXEC spMCMovDatos @Modulo, @ModuloID, @DatosMov OUTPUT, @DatosImpuestos OUTPUT, @DatosPresupuesto OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  IF @Ok IN (NULL, 80030)
  BEGIN
    SELECT @Datos = '<Intelisis'+dbo.fnXMLBase()+dbo.fnXML('Accion', 'Movimiento')+'>'+
			'<Movimiento'+
			dbo.fnXML('Empresa', @Empresa)+
			dbo.fnXMLInt('Sucursal', @Sucursal)+
			dbo.fnXML('Usuario', @Usuario)+
			dbo.fnXML('Posicion', NULL)+
			dbo.fnXML('Modulo', @Modulo)+
			dbo.fnXMLInt('ModuloID', @ModuloID)+
			dbo.fnXML('Mov', @Mov)+
			dbo.fnXML('MovID', @MovID)+
			dbo.fnXML('MovTipo', @MovTipo)+
			dbo.fnXML('Estatus', @Estatus)+
			dbo.fnXMLDateTime('FechaEmision', @FechaEmision)+
			dbo.fnXMLFloat('TipoCambio2', @TipoCambio2)+
			'>'+
			dbo.fnXMLTrim(ISNULL(@DatosMov, ''))+
                        ISNULL(@DatosImpuestos, '')+
                        ISNULL(@DatosPresupuesto, '')+
			'</Movimiento>'+
		     '</Intelisis>'
    EXEC spModuloCentral 'Movimiento', @Datos, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  END
  RETURN
END
GO

-- spMCAlmacenarDatos 'Cte', 'C1', 'Cliente="C1"', @EnSilencio = 1, @Empresa = 'DEMO', @Sucursal = 0, @Usuario = 'DEMO'
/************** spMCAlmacenarDatos *************/
if exists (select * from sysobjects where id = object_id('dbo.spMCAlmacenarDatos') and type = 'P') drop procedure dbo.spMCAlmacenarDatos
GO
CREATE PROCEDURE spMCAlmacenarDatos
			@Tabla		varchar(100),
			@Llave		varchar(255),
			@WHERE		varchar(255),
			@Historico	varchar(20)	= NULL,			-- No/Diferencial/Completo
			@Empresa	varchar(5)	= NULL,
			@Sucursal	int		= NULL,
			@Usuario	varchar(10)	= NULL,
			@Posicion	varchar(20)	= NULL,
			@FechaTrabajo	datetime	= NULL,
			@EnSilencio	bit		= 0,
			@Ok		int		= NULL	OUTPUT,
			@OkRef		varchar(255)	= NULL	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE	
    @Datos		nvarchar(max),
    @SQL		nvarchar(max),
    @Resultado		nvarchar(max),
    @AccesoID		int

  SELECT @SQL = CONVERT(nvarchar(max), 'SELECT @Datos = CONVERT(nvarchar(max), (SELECT * FROM ' + @Tabla + ' WHERE ' + @WHERE +' FOR XML AUTO))')
  EXEC sp_executesql @SQL, N'@Datos nvarchar(max) OUTPUT', @Datos = @Datos OUTPUT

  IF @Empresa IS NULL
  BEGIN
    SELECT @AccesoID = MAX(ID) FROM Acceso WHERE SPID = @@SPID
    SELECT @Empresa = Empresa, @Sucursal = Sucursal, @Usuario = Usuario, @FechaTrabajo = FechaTrabajo -- Falta Posicion
      FROM Acceso
     WHERE ID = @AccesoID
  END

  SELECT @Datos = '<Intelisis'+dbo.fnXMLBase()+dbo.fnXML('Accion', 'AlmacenarDatos')+'>'+
			'<Datos'+
			dbo.fnXML('Empresa', @Empresa)+
			dbo.fnXMLInt('Sucursal', @Sucursal)+
			dbo.fnXML('Usuario', @Usuario) + 
			dbo.fnXML('Posicion', @Posicion) + 
			dbo.fnXMLDateTime('FechaTrabajo', @FechaTrabajo)+
			dbo.fnXML('Tabla', @Tabla) + 
  			dbo.fnXML('Llave' , @Llave)+ 
  			dbo.fnXML('Historico' , @Historico)+ 
                        '>' +
			dbo.fnXMLTrim(@Datos)+
			'</Datos>'+
		    '</Intelisis>'
  EXEC spModuloCentral 'AlmacenarDatos', @Datos, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  IF @EnSilencio = 0
    EXEC spOk_RAISERROR @Ok, @OkRef
END
GO

/*
select * from cte
delete cte

DELETE Cte
  FROM Cte
  JOIN OPENXML(@iDatos, '/Intelisis/Resultado/mcAlmDato/Datos/Intelisis/Datos/Cte') WITH Cte x ON x.Cliente = Cte.Cliente

INSERT Cte
SELECT *
  FROM OPENXML(@iDatos, '/Intelisis/Resultado/mcAlmDato/Datos/Intelisis/Datos/Cte') WITH Cte
*/
-- spMCActualizarDatos 'Cte',  @todo = 1, @EnSilencio = 1
/************** spMCActualizarDatos *************/
if exists (select * from sysobjects where id = object_id('dbo.spMCActualizarDatos') and type = 'P') drop procedure dbo.spMCActualizarDatos
GO
CREATE PROCEDURE spMCActualizarDatos
			@Tabla		varchar(100),
			@Todo		bit		= 0,
			@EnSilencio	bit		= 0,
			@Ok		int		= NULL	OUTPUT,
			@OkRef		varchar(255)	= NULL	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE	
    @Datos		nvarchar(max), 
    @Resultado		nvarchar(max),
    @iResultado		int,
    @SQL		nvarchar(max),
    @Llave		varchar(max),
    @GID		uniqueidentifier,
    @TieneIdentity	bit

/*
Si la tabla tiene identity hay que checar que este apagado y sino mandar error
*/
  SELECT @TieneIdentity = OBJECTPROPERTY(OBJECT_ID(@Tabla), 'TableHasIdentity')
  IF @TieneIdentity = 1 SELECT @Ok = 18060


  SELECT @Datos = '<Intelisis'+dbo.fnXMLBase()+dbo.fnXML('Accion', 'ActualizarDatos')+'>'+
			'<ActualizarDatos'+dbo.fnXML('Tabla', @Tabla)+dbo.fnXMLBit('Todo', @Todo)+'/>'+
		  '</Intelisis>'
  IF @Ok IS NULL
    EXEC spModuloCentral 'ActualizarDatos', @Datos, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  IF @Ok IS NULL
  BEGIN
    BEGIN TRY
      BEGIN TRANSACTION trActualizarDatos
      EXEC sp_xml_preparedocument @iResultado OUTPUT, @Resultado

      SELECT @GID = GID
        FROM OPENXML (@iResultado, '/Intelisis/Resultado', 1) 
        WITH (GID uniqueidentifier)

      EXEC spTableLlavePrimariaOD @Tabla, 'x', @Tabla, @Llave OUTPUT

      SELECT @SQL = N'DELETE '+@Tabla+' FROM '+@Tabla+' JOIN OPENXML(@iResultado, ''/Intelisis/Resultado/mcAlmDato/Datos/Intelisis/Datos/'+@Tabla+''') WITH '+@Tabla+' x ON '+@Llave 
      EXEC sp_executesql @SQL, N'@iResultado int', @iResultado = @iResultado

      SELECT @SQL = N'INSERT '+@Tabla+' SELECT * FROM OPENXML(@iResultado, ''/Intelisis/Resultado/mcAlmDato/Datos/Intelisis/Datos/'+@Tabla+''') WITH '+@Tabla
      EXEC sp_executesql @SQL, N'@iResultado int', @iResultado = @iResultado

      EXEC sp_xml_removedocument @iResultado

      COMMIT TRANSACTION trActualizarDatos
    END TRY
    BEGIN CATCH
      ROLLBACK TRANSACTION trActualizarDatos
      SELECT @Ok = 1, @OkRef = dbo.fnOkRefSQL(ERROR_NUMBER(), ERROR_MESSAGE())
      SELECT @Datos = '<Intelisis'+dbo.fnXMLBase()+dbo.fnXML('Accion', 'ActualizarDatos')+'>'+
			'<ActualizarDatos'+dbo.fnXML('Tabla', @Tabla)+dbo.fnXMLBit('EliminarID', 1)+dbo.fnXMLGID('GID', @GID)+'/>'+
		      '</Intelisis>'
      EXEC spModuloCentral 'ActualizarDatos', @Datos, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    END CATCH
  END
  IF @EnSilencio = 0
    EXEC spOk_RAISERROR @Ok, @OkRef
END
GO


/*
declare
  @Resultado xml,
  @OkRef varchar(255),
  @Ok	int

exec spMCConsulta 'select * from mcMayor for xml auto', @Resultado output, @Ok output, @OkRef output
select @Resultado, @Ok, @OkRef
*/

/************** spMCConsulta *************/
if exists (select * from sysobjects where id = object_id('dbo.spMCConsulta') and type = 'P') drop procedure dbo.spMCConsulta
GO
CREATE PROCEDURE spMCConsulta
			@SQL		nvarchar(max),
			@ResultadoXML	xml		OUTPUT,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE	
    @Datos		nvarchar(max), 
    @Resultado		nvarchar(max)

  SELECT @Datos = '<Intelisis'+dbo.fnXMLBase()+dbo.fnXML('Accion', 'Consulta')+'>'+
			'<Consulta>'+dbo.fnXMLValor(@SQL)+'</Consulta>'+
		  '</Intelisis>'
  EXEC spModuloCentral 'Consulta', @Datos, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  SELECT @ResultadoXML = CONVERT(xml, @Resultado)

  RETURN
END
GO

-- delete mccfgmayor
-- select * from mccfgmayor
-- spMCTablaGet 'mcCfgMayor', 'Mayor > ''20'''
/************** spMCTablaGet *************/
if exists (select * from sysobjects where id = object_id('dbo.spMCTablaGet') and type = 'P') drop procedure dbo.spMCTablaGet
GO
CREATE PROCEDURE spMCTablaGet
			@Tabla		varchar(100),
			@Filtro		varchar(max)    = NULL,
			@EnSilencio	bit		= 0,
			@Ok		int		= NULL	OUTPUT,
			@OkRef		varchar(255)	= NULL	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE	
    @Ruta		varchar(255),
    @SQL		nvarchar(max),
    @ResultadoXML	xml,
    @iResultado		int

  SELECT @Filtro = NULLIF(RTRIM(@Filtro), '')
  IF @Filtro IS NULL
    SELECT @SQL = N'SELECT * FROM '+@Tabla+' FOR XML AUTO'
  ELSE
    SELECT @SQL = N'SELECT * FROM '+@Tabla+' WHERE '+@Filtro+' FOR XML AUTO'

  EXEC spMCConsulta @SQL, @ResultadoXML OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  EXEC spMCResultadoXMLOk @ResultadoXML, @Ok OUTPUT, @OkRef OUTPUT  
  IF @Ok IS NULL
  BEGIN
    BEGIN TRY
      BEGIN TRANSACTION trTablaGet

      EXEC sp_xml_preparedocument @iResultado OUTPUT, @ResultadoXML

      IF @Filtro IS NULL
        SELECT @SQL = N'TRUNCATE TABLE '+@Tabla
      ELSE
        SELECT @SQL = N'DELETE '+@Tabla+' WHERE '+@Filtro
      EXEC sp_executesql @SQL

      SELECT @SQL = N'INSERT INTO '+@Tabla+N' SELECT * FROM OPENXML (@iResultado, @Ruta) WITH '+@Tabla,
             @Ruta = '/Intelisis/Resultado/'+@Tabla
      EXEC sp_executesql @SQL, N'@iResultado int, @Ruta varchar(100)', @iResultado = @iResultado, @Ruta = @Ruta
      EXEC sp_xml_removedocument @iResultado

      COMMIT TRANSACTION trTablaGet
    END TRY
    BEGIN CATCH
      ROLLBACK TRANSACTION trTablaGet
      SELECT @Ok = 1, @OkRef = dbo.fnOkRefSQL(ERROR_NUMBER(), ERROR_MESSAGE())
    END CATCH
  END
  IF @EnSilencio = 0
    EXEC spOk_RAISERROR @Ok, @OkRef
  RETURN
END
GO

-- select * from mccfgmayor
--delete mccfgmayor
-- select * from mcCfgmayorDato
--delete mcCfgmayorDato
-- spMCTablaPost 'mcCfgMayor', 'Mayor > ''20'''
-- spMCTablaPost 'mcModuloMovPoliza' 
/************** spMCTablaPost *************/
if exists (select * from sysobjects where id = object_id('dbo.spMCTablaPost') and type = 'P') drop procedure dbo.spMCTablaPost
GO
CREATE PROCEDURE spMCTablaPost
			@Tabla		varchar(100),
			@Filtro		varchar(max)    = NULL,
			@EnSilencio	bit		= 0,
			@Ok		int		= NULL	OUTPUT,
			@OkRef		varchar(255)	= NULL	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE	
    @Datos		nvarchar(max),
    @Resultado		nvarchar(max),
    @SQL		nvarchar(max)

  SELECT @Filtro = NULLIF(RTRIM(@Filtro), '')
  IF @Filtro IS NULL
    SELECT @SQL = 'SELECT @Datos = CONVERT(nvarchar(max), ISNULL((SELECT * FROM '+@Tabla+' FOR XML AUTO), ""))'
  ELSE
    SELECT @SQL = 'SELECT @Datos = CONVERT(nvarchar(max), ISNULL((SELECT * FROM '+@Tabla+' WHERE '+@Filtro+' FOR XML AUTO), ""))'
  EXEC sp_executesql @SQL, N'@Datos nvarchar(max) OUTPUT', @Datos = @Datos OUTPUT

  SELECT @Datos = '<Intelisis'+dbo.fnXMLBase()+dbo.fnXML('Accion', 'ReemplazarDatos')+'>'+
			'<ReemplazarDatos'+dbo.fnXML('Tabla', @Tabla)+dbo.fnXML('Filtro', @Filtro)+'>'+
			@Datos+
			'</ReemplazarDatos>'+
  		    '</Intelisis>'

  EXEC spModuloCentral 'ReemplazarDatos', @Datos, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  IF @EnSilencio = 0
    EXEC spOk_RAISERROR @Ok, @OkRef
  RETURN
END
GO

/************** spMCValidarCarga *************/
if exists (select * from sysobjects where id = object_id('dbo.spMCValidarCarga') and type = 'P') drop procedure dbo.spMCValidarCarga
GO
CREATE PROCEDURE spMCValidarCarga
			@GID		uniqueidentifier,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SumaDebe	money,
    @SumaHaber	money

  SELECT @SumaDebe = SUM(Debe),
         @SumaHaber = SUM(Haber)
    FROM mcCargaReg
   WHERE GID = @GID

  IF @SumaDebe <> @SumaHaber
    SELECT @Ok = Mensaje,@OkRef = Descripcion 
      FROM MensajeLista
     WHERE Mensaje = 50010
  RETURN
END
GO

/************** spMCActualizarCatalogosCarga *************/
if exists (select * from sysobjects where id = object_id('dbo.spMCActualizarCatalogosCarga') and type = 'P') drop procedure dbo.spMCActualizarCatalogosCarga
GO
CREATE PROCEDURE spMCActualizarCatalogosCarga
			@GID		uniqueidentifier,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Base		varchar(5),
    @Campo		varchar(50),
    @Valor		varchar(50),
    @Nombre		varchar(100),
    @Descripcion	varchar(255),
    @Descripcion2	varchar(255),
    @Categoria		varchar(50),
    @Grupo		varchar(50),
    @Familia		varchar(50),
    @Linea		varchar(50),
    @Marca		varchar(50),
    @Direccion		varchar(100),
    @Delegacion		varchar(100),
    @Colonia		varchar(100),
    @Poblacion		varchar(100),
    @Estado		varchar(30),
    @Pais		varchar(30),
    @Zona		varchar(30),
    @CodigoPostal	varchar(15),
    @GLN		varchar(50),
    @Telefonos		varchar(100),
    @Fax		varchar(50),
    @Contacto		varchar(50),
    @Contacto2		varchar(50),
    @Extencion		varchar(10),
    @Extencion2		varchar(10),
    @eMail		varchar(50),
    @eMail2		varchar(50),
    @Movil		varchar(50),
    @Movil2		varchar(50),
    @RFC		varchar(20),
    @CURP		varchar(20),
    @Estatus		varchar(15)

  IF @Ok IS NOT NULL RETURN
  SELECT @Base = Base FROM VERSION
  BEGIN TRY
    BEGIN TRANSACTION trCargaProp

    DECLARE crCargaProp CURSOR LOCAL FOR
     SELECT Campo, Valor, Nombre, Descripcion, Descripcion2, Categoria, Grupo, Familia, Linea, Marca, Direccion, Delegacion, Colonia, Poblacion, Estado, Pais, Zona, CodigoPostal, GLN, Telefonos, Fax, Contacto, Contacto2, Extencion, Extencion2, eMail, eMail2, Movil, Movil2, RFC, CURP, Estatus
       FROM mcCargaProp
    OPEN crCargaProp
    FETCH NEXT FROM crCargaProp INTO @Campo, @Valor, @Nombre, @Descripcion, @Descripcion2, @Categoria, @Grupo, @Familia, @Linea, @Marca, @Direccion, @Delegacion, @Colonia, @Poblacion, @Estado, @Pais, @Zona, @CodigoPostal, @GLN, @Telefonos, @Fax, @Contacto, @Contacto2, @Extencion, @Extencion2, @eMail, @eMail2, @Movil, @Movil2, @RFC, @CURP, @Estatus
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        UPDATE mcProp
           SET Nombre = @Nombre, Descripcion = @Descripcion, Descripcion2 = @Descripcion2, Categoria = @Categoria, Grupo = @Grupo, Familia = @Familia, Linea = @Linea, Marca = @Marca, Direccion = @Direccion, Delegacion = @Delegacion, Colonia = @Colonia, Poblacion = @Poblacion, Estado = @Estado, Pais = @Pais, Zona = @Zona, CodigoPostal = @CodigoPostal, GLN = @GLN, Telefonos = @Telefonos, Fax = @Fax, Contacto = @Contacto, Contacto2 = @Contacto2, Extencion = @Extencion, Extencion2 = @Extencion2, eMail = @eMail, eMail2 = @eMail2, Movil = @Movil, Movil2 = @Movil2, RFC = @RFC, CURP = @CURP
         WHERE Base = @Base AND Campo = @Campo AND Valor = @Valor
        IF @@ROWCOUNT = 0
          INSERT mcProp (
                  Base,  FechaCentral,  Campo,  Valor,  Nombre,  Descripcion,  Descripcion2,  Categoria,  Grupo,  Familia,  Linea,  Marca,  Direccion,  Delegacion,  Colonia,  Poblacion,  Estado,  Pais,  Zona,  CodigoPostal,  GLN,  Telefonos,  Fax,  Contacto,  Contacto2,  Extencion,  Extencion2,  eMail,  eMail2,  Movil,  Movil2,  RFC,  CURP, Estatus)
          VALUES (@Base, getdate(), @Campo, @Valor, @Nombre, @Descripcion, @Descripcion2, @Categoria, @Grupo, @Familia, @Linea, @Marca, @Direccion, @Delegacion, @Colonia, @Poblacion, @Estado, @Pais, @Zona, @CodigoPostal, @GLN, @Telefonos, @Fax, @Contacto, @Contacto2, @Extencion, @Extencion2, @eMail, @eMail2, @Movil, @Movil2, @RFC, @CURP, @Estatus)
        IF @Campo = 'Cliente' 
        BEGIN
          UPDATE Cte
             SET Nombre = @Nombre, Categoria = @Categoria, Grupo = @Grupo, Familia = @Familia, Direccion = @Direccion, Delegacion = @Delegacion, Colonia = @Colonia, Poblacion = @Poblacion, Estado = @Estado, Pais = @Pais, Zona = @Zona, CodigoPostal = @CodigoPostal, GLN = @GLN, Telefonos = @Telefonos, Fax = @Fax, Contacto1 = @Contacto, Contacto2 = @Contacto2, Extencion1 = @Extencion, Extencion2 = @Extencion2, eMail1 = @eMail, eMail2 = @eMail2, RFC = @RFC, CURP = @CURP,  Estatus = @Estatus
           WHERE Cliente = @Valor
          IF @@ROWCOUNT = 0
            INSERT Cte (
                    Cliente, Nombre,  Categoria,  Grupo,  Familia,  Direccion,  Delegacion,  Colonia,  Poblacion,  Estado,  Pais,  Zona,  CodigoPostal,  GLN,  Telefonos,  Fax,  Contacto1, Contacto2,  Extencion1, Extencion2,  eMail1, eMail2,  RFC,  CURP, Estatus)
            VALUES (@Valor,  @Nombre, @Categoria, @Grupo, @Familia, @Direccion, @Delegacion, @Colonia, @Poblacion, @Estado, @Pais, @Zona, @CodigoPostal, @GLN, @Telefonos, @Fax, @Contacto, @Contacto2, @Extencion, @Extencion2, @eMail, @eMail2, @RFC, @CURP, @Estatus)
        END ELSE
        IF @Campo = 'Proveedor'
        BEGIN
          UPDATE Prov
             SET Nombre = @Nombre, Categoria = @Categoria, Familia = @Familia, Direccion = @Direccion, Delegacion = @Delegacion, Colonia = @Colonia, Poblacion = @Poblacion, Estado = @Estado, Pais = @Pais, Zona = @Zona, CodigoPostal = @CodigoPostal, Telefonos = @Telefonos, Fax = @Fax, Contacto1 = @Contacto, Contacto2 = @Contacto2, Extencion1 = @Extencion, Extencion2 = @Extencion2, eMail1 = @eMail, eMail2 = @eMail2, RFC = @RFC, CURP = @CURP,  Estatus = @Estatus
           WHERE Proveedor = @Valor
          IF @@ROWCOUNT = 0
            INSERT Prov (
                    Proveedor, Nombre,  Categoria,  Familia,  Direccion,  Delegacion,  Colonia,  Poblacion,  Estado,  Pais,  Zona,  CodigoPostal,  Telefonos,  Fax,  Contacto1,  Extencion1,  eMail1,  Contacto2,  Extencion2,  eMail2,  RFC,  CURP, Estatus)
            VALUES (@Valor,    @Nombre, @Categoria, @Familia, @Direccion, @Delegacion, @Colonia, @Poblacion, @Estado, @Pais, @Zona, @CodigoPostal, @Telefonos, @Fax, @Contacto, @Extencion, @eMail, @Contacto2, @Extencion2, @eMail2, @RFC, @CURP, @Estatus)
        END ELSE
        IF @Campo = 'Personal'
        BEGIN
          UPDATE Personal
             SET Nombre = @Nombre, Categoria = @Categoria, Grupo = @Grupo,  Direccion = @Direccion, Delegacion = @Delegacion, Colonia = @Colonia, Poblacion = @Poblacion, Estado = @Estado, Pais = @Pais, CodigoPostal = @CodigoPostal, eMail = @eMail, Registro2 = @RFC, Registro = @CURP,  Estatus = @Estatus
           WHERE Personal = @Valor
          IF @@ROWCOUNT = 0
            INSERT Personal (
                    Personal, Nombre,  Categoria, Grupo,   Direccion,  Delegacion,  Colonia,  Poblacion,  Estado,  Pais,  CodigoPostal,  eMail,  Registro2, Registro, Estatus)
            VALUES (@Valor,   @Nombre, @Categoria, @Grupo, @Direccion, @Delegacion, @Colonia, @Poblacion, @Estado, @Pais, @CodigoPostal, @eMail, @RFC,      @CURP, @Estatus)
        END ELSE
        IF @Campo = 'Agente'
        BEGIN
          UPDATE Agente
             SET Nombre = @Nombre, Categoria = @Categoria, Grupo = @Grupo, Familia = @Familia, Direccion = @Direccion, Colonia = @Colonia, Poblacion =  @Poblacion, Estado = @Estado, Pais = @Pais, Zona = @Zona, CodigoPostal = @CodigoPostal, Telefonos=@Telefonos, Extencion=@Extencion,  RFC=@RFC, CURP=@CURP,  Estatus = @Estatus
           WHERE Agente = @Valor
          IF @@ROWCOUNT = 0
            INSERT Agente (
                    Agente,  Nombre,  Categoria,  Grupo,  Familia,  Direccion,  Colonia,  Poblacion,  Estado,  Pais,  Zona,  CodigoPostal,  Telefonos,  Extencion,  eMail,  RFC,  CURP, Estatus)
            VALUES (@Valor,  @Nombre, @Categoria, @Grupo, @Familia, @Direccion, @Colonia, @Poblacion, @Estado, @Pais, @Zona, @CodigoPostal, @Telefonos, @Extencion, @eMail, @RFC, @CURP, @Estatus)
        END ELSE
        IF @Campo = 'Empresa'
        BEGIN
          UPDATE Empresa
             SET Nombre = @Nombre, Grupo = @Grupo, Direccion = @Direccion, Delegacion = @Delegacion, Colonia = @Colonia, Poblacion = @Poblacion, Estado = @Estado, Pais = @Pais, Zona = @Zona, CodigoPostal = @CodigoPostal, GLN = @GLN, Telefonos = @Telefonos, Fax = @Fax, RFC = @RFC,  Estatus = @Estatus
           WHERE Empresa = @Valor
          IF @@ROWCOUNT = 0
            INSERT Empresa (
                    Empresa,  Nombre, Grupo,  Direccion,  Delegacion,  Colonia,  Poblacion,  Estado,  Pais,  Zona,  CodigoPostal,  GLN,  Telefonos,  Fax,  RFC, Estatus)
            VALUES (@Valor,  @Nombre, @Grupo, @Direccion, @Delegacion, @Colonia, @Poblacion, @Estado, @Pais, @Zona, @CodigoPostal, @GLN, @Telefonos, @Fax, @RFC, @Estatus)
        END ELSE
        IF @Campo = 'Sucursal'
        BEGIN
          UPDATE Sucursal
             SET Nombre = @Nombre, Categoria = @Categoria, Grupo = @Grupo, Direccion = @Direccion, Delegacion = @Delegacion, Colonia = @Colonia, Poblacion = @Poblacion, Estado = @Estado, Pais = @Pais, CodigoPostal = @CodigoPostal, GLN = @GLN, Telefonos = @Telefonos, Fax = @Fax, RFC = @RFC,  Estatus = @Estatus
           WHERE Sucursal = @Valor
          IF @@ROWCOUNT = 0
            INSERT Sucursal (
                    Sucursal,Nombre,  Categoria,  Grupo,  Direccion,  Delegacion,  Colonia,  Poblacion,  Estado,  Pais,  CodigoPostal,  GLN,  Telefonos,  Fax,  RFC, Estatus)
            VALUES (@Valor,  @Nombre, @Categoria, @Grupo, @Direccion, @Delegacion, @Colonia, @Poblacion, @Estado, @Pais, @CodigoPostal, @GLN, @Telefonos, @Fax, @RFC, @Estatus )
        END ELSE
        IF @Campo = 'Articulo'
        BEGIN
          UPDATE Art
             SET Descripcion1 = @Nombre, Descripcion2 = @Descripcion2, Categoria= @Categoria, Grupo = @Grupo, Familia = @Familia, Linea = @Linea, Direccion = @Direccion, Delegacion = @Delegacion, Colonia = @Colonia, Poblacion = @Poblacion, Estado = @Estado, Pais = @Pais, CodigoPostal = @CodigoPostal,  Estatus = @Estatus
           WHERE Articulo = @Valor
          IF @@ROWCOUNT = 0
            INSERT Art (
                    Articulo, Descripcion1, Descripcion2,  Categoria,  Grupo,  Familia,  Linea,  Direccion,  Delegacion,  Colonia,  Poblacion,  Estado,  Pais,  CodigoPostal, Estatus, Impuesto1, MonedaCosto, MonedaPrecio)
            VALUES (@Valor,   @Nombre, @Descripcion2, @Categoria, @Grupo, @Familia, @Linea, @Direccion, @Delegacion, @Colonia, @Poblacion, @Estado, @Pais, @CodigoPostal, @Estatus, 0, 'Pesos', 'Pesos')
        END ELSE
        IF @Campo = 'Almacen'
        BEGIN
          UPDATE Alm
             SET Nombre = @Nombre, Categoria = @Categoria, Grupo = @Grupo, Direccion = @Direccion, Delegacion = @Delegacion, Colonia = @Colonia, Poblacion = @Poblacion, Estado = @Estado, Pais = @Pais, Zona = @Zona, CodigoPostal = @CodigoPostal, Telefonos = @Telefonos,  Estatus = @Estatus
           WHERE Almacen = @Valor
          IF @@ROWCOUNT = 0
            INSERT Alm (
                    Almacen, Nombre, Categoria, Grupo, Direccion, Delegacion, Colonia, Poblacion, Estado, Pais, Zona, CodigoPostal, Telefonos, Estatus)
            VALUES (@Valor, @Nombre, @Categoria, @Grupo, @Direccion, @Delegacion, @Colonia, @Poblacion, @Estado, @Pais, @Zona, @CodigoPostal, @Telefonos, @Estatus)
        END
      END
      FETCH NEXT FROM crCargaProp INTO @Campo, @Valor, @Nombre, @Descripcion, @Descripcion2, @Categoria, @Grupo, @Familia, @Linea, @Marca, @Direccion, @Delegacion, @Colonia, @Poblacion, @Estado, @Pais, @Zona, @CodigoPostal, @GLN, @Telefonos, @Fax, @Contacto, @Contacto2, @Extencion, @Extencion2, @eMail, @eMail2, @Movil, @Movil2, @RFC, @CURP, @Estatus
    END
    CLOSE crCargaProp
    DEALLOCATE crCargaProp

    COMMIT TRANSACTION trCargaProp
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION trCargaProp
    SELECT @Ok = 1, @OkRef = dbo.fnOkRefSQL(ERROR_NUMBER(), ERROR_MESSAGE())
  END CATCH

  RETURN
END
GO

-- spMCProcesarCarga
/************** spMCProcesarCarga *************/
if exists (select * from sysobjects where id = object_id('dbo.spMCProcesarCarga') and type = 'P') drop procedure dbo.spMCProcesarCarga
GO
CREATE PROCEDURE spMCProcesarCarga
			@RID		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE	
    @GID		uniqueidentifier,
    @Datos		nvarchar(max),
    @Resultado		nvarchar(max),
    @Ok			int,
    @OkRef		varchar(255),
    @Mensaje		varchar(255)

  SELECT @Ok = NULL, @OkRef = NULL

  SELECT @GID = GID FROM mcCarga WHERE RID = @RID
  EXEC spMCValidarCarga @GID, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
    EXEC spMCActualizarCatalogosCarga @GID, @Ok OUTPUT, @OkRef OUTPUT
  IF @Ok IS NULL
    EXEC spMCTablaPost 'mcCarga', @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
  IF @Ok IS NULL
    EXEC spMCTablaPost 'mcCargaReg', @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
  IF @Ok IS NULL
    EXEC spMCTablaPost 'mcCargaProp', @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

  IF @Ok IS NULL
  BEGIN
    SELECT @Datos = '<Intelisis'+dbo.fnXMLBase()+dbo.fnXML('Accion', 'ProcesarCarga')+dbo.fnXMLGID('GID', @GID)+'/>'
    EXEC spModuloCentral 'ProcesarCarga', @Datos, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  END
  IF @Ok IS NULL
  BEGIN
    BEGIN TRANSACTION trProcesarCarga

    UPDATE mcCarga 
       SET Estatus = 'CONCLUIDO'
     WHERE GID = @GID

    COMMIT TRANSACTION trProcesarCarga
  END

  IF @Ok IS NULL 
    SELECT @Mensaje = 'Proceso Concluido con Exito.'
  ELSE
    SELECT @Mensaje = Descripcion+' '+RTRIM(ISNULL(@OkRef, '')) FROM MensajeLista WHERE Mensaje = @Ok

  SELECT @Mensaje
  RETURN
END
GO

/************** spCfgModuloCentralReplica *************/
if exists (select * from sysobjects where id = object_id('dbo.spCfgModuloCentralReplica') and type = 'P') drop procedure dbo.spCfgModuloCentralReplica
GO
CREATE PROCEDURE spCfgModuloCentralReplica
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Replica	bit,
    @Tema	varchar(50),
    @Estatus	varchar(15),
    @Tabla	varchar(100),
    @SQL	varchar(1000)

  SELECT @Replica = ISNULL(Replica, 0) FROM Version

  DECLARE crTema CURSOR LOCAL FOR
   SELECT Tema, Estatus
     FROM CfgModuloCentralReplica
  OPEN crTema
  FETCH NEXT FROM crTema INTO @Tema, @Estatus
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      DECLARE crTabla CURSOR LOCAL FOR
       SELECT Tabla
         FROM CfgModuloCentralReplicaTabla
        WHERE Tema = @Tema
      OPEN crTabla
      FETCH NEXT FROM crTabla INTO @Tabla
      WHILE @@FETCH_STATUS <> -1 
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          IF @Replica = 1 AND @Estatus = 'ACTIVO' SELECT @SQL = 'ENABLE' ELSE SELECT @SQL = 'DISABLE' 
          SELECT @SQL = @SQL +' TRIGGER '+'dbo.tg'+@Tabla+'Replica'+@Tema+' ON '+@Tabla

          EXEC (@SQL)
        END
        FETCH NEXT FROM crTabla INTO @Tabla
      END
      CLOSE crTabla
      DEALLOCATE crTabla
    END
    FETCH NEXT FROM crTema INTO @Tema, @Estatus
  END
  CLOSE crTema
  DEALLOCATE crTema
END
GO

EXEC spCfgModuloCentralReplica
GO
