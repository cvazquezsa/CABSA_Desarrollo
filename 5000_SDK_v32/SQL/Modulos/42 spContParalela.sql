SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF 
GO

/******************************* spContParalelaXMLPlantillaI *************************************************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('spContParalelaXMLPlantillaI') AND TYPE = 'P')	DROP PROCEDURE spContParalelaXMLPlantillaI
GO
CREATE PROC spContParalelaXMLPlantillaI
--//WITH ENCRYPTION
AS
BEGIN
  INSERT ContParalelaXMLPlantilla(Modulo)
  SELECT Modulo
    FROM Modulo
   WHERE Modulo NOT IN(SELECT Modulo FROM ContParalelaXMLPlantilla)
  RETURN
END
GO

/******************************* spContParalelaMovDatoI *************************************************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('spContParalelaMovDatoI') AND TYPE = 'P')	DROP PROCEDURE spContParalelaMovDatoI
GO
CREATE PROC spContParalelaMovDatoI
			@Modulo			varchar(5),
			@ModuloID		int
--//WITH ENCRYPTION
AS
BEGIN
  IF NOT EXISTS(SELECT ID FROM ContParalelaMovDato WHERE Modulo = @Modulo AND ModuloID = @ModuloID)
  BEGIN
    IF @Modulo = 'COMS'
      INSERT INTO ContParalelaMovDato(
			    Modulo,  ModuloID, Fecha,                              Moneda, TipoCambio)
		SELECT @Modulo, @ModuloID, ISNULL(FechaEntrega, FechaEmision), Moneda, TipoCambio
		  FROM Compra 
		 WHERE ID = @ModuloID
    IF @Modulo = 'GAS'
      INSERT INTO ContParalelaMovDato(
			    Modulo,  ModuloID, Fecha,        Moneda, TipoCambio)
		SELECT @Modulo, @ModuloID, FechaEmision, Moneda, TipoCambio
		  FROM Gasto 
		 WHERE ID = @ModuloID
    IF @Modulo = 'VTAS'
      INSERT INTO ContParalelaMovDato(
			    Modulo,  ModuloID, Fecha,                              Moneda, TipoCambio)
		SELECT @Modulo, @ModuloID, ISNULL(FechaEntrega, FechaEmision), Moneda, TipoCambio
		  FROM Venta
		 WHERE ID = @ModuloID		 
  END
  RETURN
END
GO

/******************************* spContParalelaAsignaCuenta *************************************************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('spContParalelaAsignaCuenta') AND TYPE = 'P')	DROP PROCEDURE spContParalelaAsignaCuenta
GO
CREATE PROC spContParalelaAsignaCuenta
			@ID				int,
			@CuentaD		varchar(20),
			@CuentaA		varchar(20),
			@CuentaAsignada	varchar(40),
			@Ok				int			 = NULL OUTPUT,    
			@OkRef			varchar(255) = NULL OUTPUT				 
--//WITH ENCRYPTION
AS BEGIN
-- SET nocount ON
  DECLARE @Cuenta		varchar(20),
		  @Rama			varchar(20),
		  @Tipo			varchar(15),
		  @NoRamas		int		
	
  SELECT @NoRamas = COUNT(DISTINCT Rama) 
	FROM ContParalelaCta
   WHERE Cuenta >= @CuentaD 
	 AND Cuenta <= @CuentaA
	 AND Estatus = 'ALTA'
	 AND ID = @ID

  IF @Ok IS NULL AND NOT EXISTS(SELECT * FROM ContParalelaCta WHERE ID = @ID AND Cuenta = @CuentaD)
    SELECT @Ok = 1, @OkRef = 'Cuenta Incorrecta. '  + ISNULL(@CuentaD, '')

  IF @Ok IS NULL AND NOT EXISTS(SELECT * FROM ContParalelaCta WHERE ID = @ID AND Cuenta = @CuentaA)
    SELECT @Ok = 1, @OkRef = 'Cuenta Incorrecta. '  + ISNULL(@CuentaA, '')
    	   
  IF @Ok IS NULL AND @NoRamas > 1
    SELECT @Ok = 1, @OkRef = 'Las cuentas deben pertenecer a la misma Rama.'
      
  IF @Ok IS NULL AND @NoRamas <= 1
  BEGIN
    UPDATE ContParalelaCta 
       SET CuentaAsignada = @CuentaAsignada
     WHERE Cuenta >= @CuentaD 
       AND Cuenta <= @CuentaA
       AND Estatus = 'ALTA'
       AND ID = @ID

    SELECT @Ok = 8080, @OkRef = 'Proceso concluído con éxito'
  END
  
  SELECT @OkRef
END
GO

/**************** fnContParalelaCtaFiltro ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnContParalelaCtaFiltro') DROP FUNCTION fnContParalelaCtaFiltro
GO
CREATE FUNCTION fnContParalelaCtaFiltro(
				@Tipo		varchar(15)
)
RETURNS varchar(100)
AS
BEGIN
  DECLARE @Valor	varchar(100)
  
  IF @Tipo = 'Todas'
    SELECT @Valor = '(1=1)'
  ELSE IF @Tipo = 'Asignadas'
    SELECT @Valor = '(NULLIF(RTRIM(ContParalelaCta.CuentaAsignada), '''') IS NOT NULL)'
  ELSE IF @Tipo = 'SinAsignar'
    SELECT @Valor = '(NULLIF(RTRIM(ContParalelaCta.CuentaAsignada), '''') IS NULL)'   

  RETURN @Valor
END
GO

/**************** spContParalelaVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContParalelaVerificar') and type = 'P') drop procedure dbo.spContParalelaVerificar
GO
CREATE PROCEDURE spContParalelaVerificar
    		@ID               	int,
		    @Accion				char(20),
    		@Empresa          	char(5),
		    @Usuario			char(10),
    		@Modulo	      		char(5),
    		@Mov              	char(20),
	        @MovID				varchar(20),
    		@MovTipo	      	char(20),
		    @FechaEmision		datetime,
		    @Estatus			char(15),
		    @EstatusNuevo		char(15),

		    @CuentaD			varchar(20),
		    @CuentaA			varchar(20),
		    @BaseDatos			varchar(255), 
		    @EmpresaOrigen		varchar(5), 
		    @CPBaseLocal		bit, 
		    @CPBaseDatos		varchar(255), 
		    @CPURL				varchar(255), 
		    @CPCentralizadora	bit, 
		    @CPUsuario			varchar(10),
			@CPContrasena		varchar(32),
    
		    @ISReferencia		varchar(100),  
			@OrigenTipo			varchar(5),
			@Origen				varchar(20),
			@OrigenID			varchar(20),
			@IDEmpresa			int,
			@GeneraEjercicio	int,
			@GeneraPeriodo		int,
			@GeneraFechaD		datetime,
			@GeneraFechaA		datetime,
			@GeneraEmpresaOrigen int,
			@GeneraMov			varchar(20),
			@GeneraMovID		varchar(20),
			@GeneraContMov		varchar(20),
			@GeneraContMovID	varchar(20),
			@GeneraContID		int,
    
		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,
    		@Ok               	int          OUTPUT,
    		@OkRef            	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @CPPaquete			varchar(20),
		  @DiasPaquete			int,
		  @CfgMaximoDiasPaquete	int,
		  @Debe					float,
		  @Haber				float,
		  @DeEjercicio			int,
		  @AEjercicio			int,
		  @DePeriodo			int,
		  @APeriodo				int

  SELECT @CfgMaximoDiasPaquete = ISNULL(CONTPMaximoDiasPaquete, 1) FROM EmpresaCfg2 WHERE Empresa = @Empresa
  
  SELECT @CPPaquete = CPPaquete FROM EmpresaCfgMovContParalela WHERE Empresa = @Empresa
  
  IF @CPCentralizadora = 0
  BEGIN
    IF @Ok IS NULL AND @CPBaseLocal = 1 AND @CPBaseDatos IS NULL
      SELECT @Ok = 10700
    IF @Ok IS NULL AND @CPBaseLocal = 0 AND @CPURL IS NULL
      SELECT @Ok = 10701
    IF @Ok IS NULL AND @MovTipo = 'CONTP.RECIBIRCUENTA'
      SELECT @Ok = 10702
    IF @Ok IS NULL AND @MovTipo IN('CONTP.GENERADORPAQ') AND @GeneraEjercicio IS NULL
      SELECT @Ok = 10050
    IF @Ok IS NULL AND @MovTipo IN('CONTP.GENERADORPAQ') AND @GeneraPeriodo IS NULL
      SELECT @Ok = 10051
    IF @Ok IS NULL AND @MovTipo = 'CONTP.PAQUETE' AND (@GeneraFechaD IS NULL OR @GeneraFechaA IS NULL)
      SELECT @Ok = 55245
    IF @Ok IS NULL AND @MovTipo = 'CONTP.RECIBIRPAQUETE'
      SELECT @Ok = 10706
    IF @Ok IS NULL AND @MovTipo = 'CONTP.TRANSFORMACION'
      SELECT @Ok = 10708
    IF @Ok IS NULL AND @MovTipo = 'CONTP.CIERRE'
      SELECT @Ok = 10710

    IF @Ok IS NULL AND @MovTipo = 'CONTP.PAQUETE'
    BEGIN
      SELECT @DiasPaquete = DATEDIFF(D, @GeneraFechaD, @GeneraFechaA)
      
      IF @DiasPaquete > @CfgMaximoDiasPaquete
        SELECT @Ok = 10707, @OkRef = RTRIM(@Mov)+' '+RTRIM(@MovID)
    END
  END
  
  IF @CPCentralizadora = 1
  BEGIN
    IF @Ok IS NULL AND @MovTipo = 'CONTP.ENVIARCUENTAS'
      SELECT @Ok = 10703
    IF @Ok IS NULL AND @MovTipo IN('CONTP.GENERADORPAQ', 'CONTP.PAQUETE')
      SELECT @Ok = 10705, @OkRef = @Mov            
    IF @Ok IS NULL AND @MovTipo = 'CONTP.RECIBIRCUENTA' AND @OrigenTipo IS NULL AND @Origen IS NULL AND @OrigenID IS NULL AND @Conexion = 0
      SELECT @Ok = 46020, @OkRef = @Mov
    IF @Ok IS NULL AND @MovTipo IN('CONTP.TRANSFORMACION', 'CONTP.CIERRE') AND @GeneraEjercicio IS NULL
      SELECT @Ok = 10050
    IF @Ok IS NULL AND @MovTipo IN('CONTP.TRANSFORMACION') AND @GeneraEmpresaOrigen IS NULL
      SELECT @Ok = 10711
    IF @Ok IS NULL AND @MovTipo IN('CONTP.TRANSFORMACION', 'CONTP.CIERRE') AND @GeneraPeriodo IS NULL
      SELECT @Ok = 10051
    IF @Ok IS NULL AND @MovTipo IN('CONTP.POLIZA')
    BEGIN
      SELECT @Debe = SUM(Debe), @Haber = SUM(Haber) FROM ContParalelaD WHERE ID = @ID
      
      IF @Debe <> @Haber
        SELECT @Ok = 50010
    END
    
    IF @Ok IS NULL AND @MovTipo IN('CONTP.RECIBIRPAQUETE')
    BEGIN
      SELECT DISTINCT @IDEmpresa IDEmpresa, YEAR(ContFechaEmision) Ejercicio, MONTH(ContFechaEmision) Periodo
        INTO #PeriodoCerrado
        FROM ContParalelaD 
       WHERE ID = @ID
    
      IF EXISTS(SELECT * FROM ContParalelaPeriodoCierre c JOIN #PeriodoCerrado e ON c.IDEmpresa = e.IDEmpresa AND c.Ejercicio = e.Ejercicio AND c.Periodo = e.Periodo)
        SELECT @Ok = 60110        
    END

    IF @Ok IS NULL AND @MovTipo IN('CONTP.TRANSFORMACION', 'CONTP.POLIZA')
    BEGIN
      IF EXISTS(SELECT * FROM ContParalelaPeriodoCierre WHERE IDEmpresa = ISNULL(@GeneraEmpresaOrigen, IDEmpresa) AND Ejercicio = @GeneraEjercicio AND Periodo = @GeneraPeriodo)
        SELECT @Ok = 60110
    END
    
    IF @Ok IS NULL AND @MovTipo IN('CONTP.POLIZA') AND @OrigenTipo IS NULL      
        SELECT @Ok = 10709
  END
  
  IF @Accion = 'CANCELAR'
  BEGIN
    IF @MovTipo IN('CONTP.ENVIARCUENTAS', 'CONTP.RECIBIRCUENTA', 'CONTP.RECIBIRPAQUETE')
      SELECT @Ok = 60050, @OkRef = RTRIM(@Mov)+' '+RTRIM(@MovID)

    IF @MovTipo IN('CONTP.PAQUETE') AND @Estatus = 'CONCLUIDO'
      SELECT @Ok = 60050, @OkRef = RTRIM(@Mov)+' '+RTRIM(@MovID)    

    -- Checar que se haya capturado el movimiento en este modulo
    IF @Conexion = 0 
      IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo)
	SELECT @Ok = 60070
	
    IF @MovTipo = 'CONTP.GENERADORPAQ' AND EXISTS(SELECT ID FROM ContParalela WHERE Mov = @CPPaquete AND OrigenTipo = 'CONTP' AND Origen = @Mov AND OrigenID = @MovID AND Estatus = 'CONCLUIDO')
      SELECT @Ok = 60060, @OkRef = RTRIM(@Mov)+' '+RTRIM(@MovID)
  END
  RETURN
END
GO

/**************** spContParalelaXMLLeerResultado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContParalelaXMLLeerResultado') and type = 'P') drop procedure dbo.spContParalelaXMLLeerResultado
GO             
CREATE PROC spContParalelaXMLLeerResultado 
			@ID					int, 
			@Empresa			varchar(5), 
			@Mov				varchar(20), 
			@MovID				varchar(20), 
			@MovTipo			varchar(20), 
			@BaseDatos			varchar(255), 
			@EmpresaOrigen		varchar(5), 
			@CuentaD			varchar(20), 
			@CuentaA			varchar(20), 
			@CPBaseLocal		bit,
			@CPBaseDatos		varchar(255),
			@CPURL				varchar(255),
			@CPCentralizadora	bit,
			@CPUsuario			varchar(10),
			@CPContrasena		varchar(32),
			@Resultado			varchar(max),
			@ISReferencia		varchar(100),
			@IDEmpresa			int,
			@Ok					int				OUTPUT,
			@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @iSolicitud		int,
		  @Referencia		varchar(50)

  IF NULLIF(RTRIM(@Resultado), '') IS NULL OR(@Resultado = '<?xml version="1.0" encoding="windows-1252" ?>')
  BEGIN
    SELECT @Ok = 4
    RETURN
  END

  BEGIN TRY

    EXEC sp_xml_preparedocument @iSolicitud OUTPUT, @Resultado

    SELECT @Ok = NULLIF(Ok, 0), @OkRef = NULLIF(OkRef, '')
      FROM OPENXML (@iSolicitud, '/Intelisis',1) 
      WITH (Ok			int, 
		    OkRef		varchar(255),
		    Mov			varchar(20),
		    MovID		varchar(20)
		    )   
  
    SELECT @Referencia = ISNULL(RTRIM(Mov), '')+' '+ISNULL(RTRIM(MovID), '')
      FROM OPENXML (@iSolicitud, '/Intelisis/Resultado/ContParalela',1) 
      WITH (Mov		varchar(20),
		    MovID	varchar(20)
		    ) 

    IF @Ok IS NULL
    BEGIN
      UPDATE ContParalelaXML SET Resultado = @Resultado WHERE ID = @ID

      IF @MovTipo = 'CONTP.ENVIARCUENTAS'
      BEGIN      
        SELECT Cuenta, CtaEstatus
          INTO #Cuentas
          FROM OPENXML (@iSolicitud, '/Intelisis/Resultado/ContParalelaD',1) 
          WITH (Cuenta			varchar(20), 
		        CtaEstatus		varchar(50))

        UPDATE ContParalelaD
           SET CtaEstatus = #Cuentas.CtaEstatus
          FROM ContParalelaD
          JOIN #Cuentas ON ContParalelaD.Cuenta = #Cuentas.Cuenta
         WHERE ContParalelaD.ID = @ID
      END

      IF @MovTipo = 'CONTP.PAQUETE'
      BEGIN      
        SELECT ContID, ContMov, ContMovID, ContFechaEmision, ContOrigenTipo, ContOrigen, ContOrigenID, PolizaEstatus
          INTO #Polizas
          FROM OPENXML (@iSolicitud, '/Intelisis/Resultado/ContParalelaD',1) 
          WITH (ContID				int,
			    ContMov				varchar(20),
			    ContMovID			varchar(20),
			    ContFechaEmision	datetime,
			    ContOrigenTipo		varchar(5),
			    ContOrigen			varchar(5),
			    ContOrigenID		varchar(5),	  
			    PolizaEstatus		varchar(50)	
			    )

        UPDATE ContParalelaD
           SET PolizaEstatus = #Polizas.PolizaEstatus
          FROM ContParalelaD
          JOIN #Polizas ON ContParalelaD.ContID = #Polizas.ContID
         WHERE ContParalelaD.ID = @ID
      END
    END
  
    EXEC sp_xml_removedocument @iSolicitud

  END TRY
  BEGIN CATCH
    SELECT @Ok = 1, @OkRef = dbo.fnOkRefSQL(ERROR_NUMBER(), ERROR_MESSAGE())    
    RETURN
  END CATCH
    
  RETURN
END
GO

/**************** spContParalelaXMLSolicitudLocal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContParalelaXMLSolicitudLocal') and type = 'P') drop procedure dbo.spContParalelaXMLSolicitudLocal
GO             
CREATE PROC spContParalelaXMLSolicitudLocal 
			@ID					int, 
			@Empresa			varchar(5), 
			@Mov				varchar(20), 
			@MovID				varchar(20), 
			@MovTipo			varchar(20), 
			@BaseDatos			varchar(255), 
			@EmpresaOrigen		varchar(5), 
			@CuentaD			varchar(20), 
			@CuentaA			varchar(20), 
			@CPBaseLocal		bit,
			@CPBaseDatos		varchar(255),
			@CPURL				varchar(255),
			@CPCentralizadora	bit,
			@CPUsuario			varchar(10),
			@CPContrasena		varchar(32),
			@XML				varchar(max),
			@ISReferencia		varchar(100),
			@IDEmpresa			int,
			@Resultado			varchar(max)	OUTPUT,
			@Ok					int				OUTPUT,
			@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @SQL			nvarchar(max),
		  @Parametros	nvarchar(max)
  
  SELECT @Parametros = '@Usuario			varchar(10),
						@Contrasena			varchar(32),
						@XML				varchar(max),
						@Resultado			varchar(max)	OUTPUT,
						@Ok					int				OUTPUT,
						@OkRef				varchar(255)	OUTPUT'
  
  SELECT @SQL = 'EXEC ' + ISNULL(@CPBaseDatos, '') + '.dbo.spIntelisisService @Usuario, @Contrasena, @XML, @Procesar = 1, @EliminarProcesado = 0, @Resultado = @Resultado OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT'

  EXEC sp_executesql @SQL, @Parametros, @Usuario = @CPUsuario, @Contrasena = @CPContrasena, @XML = @XML, @Resultado = @Resultado OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef	OUTPUT

  RETURN
END
GO

/**************** spContParalelaXMLSolicitudRemota ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContParalelaXMLSolicitudRemota') and type = 'P') drop procedure dbo.spContParalelaXMLSolicitudRemota
GO             
CREATE PROC spContParalelaXMLSolicitudRemota 
			@ID					int, 
			@Empresa			varchar(5), 
			@Mov				varchar(20), 
			@MovID				varchar(20), 
			@MovTipo			varchar(20), 
			@BaseDatos			varchar(255), 
			@EmpresaOrigen		varchar(5), 
			@CuentaD			varchar(20), 
			@CuentaA			varchar(20), 
			@CPBaseLocal		bit,
			@CPBaseDatos		varchar(255),
			@CPURL				varchar(255),
			@CPCentralizadora	bit,
			@CPUsuario			varchar(10),
			@CPContrasena		varchar(32),
			@XML				varchar(max),
			@ISReferencia		varchar(100),
			@IDEmpresa			int,
			@Resultado			varchar(max)	OUTPUT,
			@Ok					int				OUTPUT,
			@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  EXEC spPeticionXML @CPURL, @XML, @Resultado OUTPUT
  
  RETURN
END
GO

/**************** spContParalelaXMLSolicitud ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContParalelaXMLSolicitud') and type = 'P') drop procedure dbo.spContParalelaXMLSolicitud
GO             
CREATE PROC spContParalelaXMLSolicitud 
			@ID					int, 
			@Empresa			varchar(5), 
			@Mov				varchar(20), 
			@MovID				varchar(20), 
			@MovTipo			varchar(20), 
			@BaseDatos			varchar(255), 
			@EmpresaOrigen		varchar(5), 
			@CuentaD			varchar(20), 
			@CuentaA			varchar(20), 
			@CPBaseLocal		bit,
			@CPBaseDatos		varchar(255),
			@CPURL				varchar(255),
			@CPCentralizadora	bit,
			@CPUsuario			varchar(10),
			@CPContrasena		varchar(32),
			@XML				varchar(max),
			@ISReferencia		varchar(100),
			@IDEmpresa			int,
			@Resultado			varchar(max)	OUTPUT,
			@Ok					int				OUTPUT,
			@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  IF @CPBaseLocal = 1
    EXEC spContParalelaXMLSolicitudLocal @ID, @Empresa, @Mov, @MovID, @MovTipo, @BaseDatos, @EmpresaOrigen, @CuentaD, @CuentaA, @CPBaseLocal, @CPBaseDatos, @CPURL, @CPCentralizadora, @CPUsuario, @CPContrasena, @XML, @ISReferencia, @IDEmpresa, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT    
  ELSE IF @CPBaseLocal = 0
    EXEC spContParalelaXMLSolicitudRemota @ID, @Empresa, @Mov, @MovID, @MovTipo, @BaseDatos, @EmpresaOrigen, @CuentaD, @CuentaA, @CPBaseLocal, @CPBaseDatos, @CPURL, @CPCentralizadora, @CPUsuario, @CPContrasena, @XML, @ISReferencia, @IDEmpresa, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT    

  IF CHARINDEX('<?xml version="1.0" encoding="windows-1252" ?>', @Resultado) = 0
    SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252" ?>' + @Resultado 
    
  RETURN
END
GO

/**************** spContParalelaXMLErrorGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContParalelaXMLErrorGenerar') and type = 'P') drop procedure dbo.spContParalelaXMLErrorGenerar
GO             
CREATE PROC spContParalelaXMLErrorGenerar 
			@ID					int, 
			@Empresa			varchar(5), 
			@Mov				varchar(20), 
			@MovID				varchar(20), 
			@MovTipo			varchar(20), 
			@BaseDatos			varchar(255), 
			@EmpresaOrigen		varchar(5), 
			@CuentaD			varchar(20), 
			@CuentaA			varchar(20), 
			@CPBaseLocal		bit,
			@CPBaseDatos		varchar(255),
			@CPURL				varchar(255),
			@CPCentralizadora	bit,
			@CPUsuario			varchar(10),
			@CPContrasena		varchar(32),
			@ISReferencia		varchar(100),			
			@XML				varchar(max)	OUTPUT,
			@Ok					int				OUTPUT,
			@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Detalle		varchar(max),
		  @SubLlave		varchar(10)
  
  DELETE ContParalelaXML WHERE ID = @ID
  
  SELECT @BaseDatos = DB_NAME()
  
  SELECT @SubLlave = 'Resultado'

  SELECT @XML = '<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="' + ISNULL(@ISReferencia, '') + '" SubReferencia="" Version="01" Ok="' + ISNULL(CONVERT(varchar(max), @Ok), '') + '" OkRef="' + ISNULL(@OkRef, '') +'" >
                   <' + @SubLlave + '>
                     <ContParalela Usuario ="' + ISNULL(@CPUsuario, '') + '" Mov ="' + ISNULL(@Mov, '') + '" MovID = "' + ISNULL(@MovID, '') + '" BaseDatos="' + ISNULL(@BaseDatos, '') + '" Empresa="' + ISNULL(@Empresa, '') + '" CuentaD="' + ISNULL(@CuentaD, '') + '" CuentaA="' + ISNULL(@CuentaA, '') + '" CPBaseLocal="' + ISNULL(CONVERT(varchar(max), @CPBaseLocal), '') + '" CPBaseDatos="' + ISNULL(@CPBaseDatos, '') + '" CPURL="' + ISNULL(@CPURL, '') + '" CPCentralizadora="' + ISNULL(CONVERT(varchar(max), @CPCentralizadora), '') + '" />'

  SELECT @XML = @XML + '  </' + @SubLlave + '>
                        </Intelisis>'

  INSERT ContParalelaXML(ID, XML) SELECT @ID, @XML

  RETURN
END
GO

/**************** spContParalelaPaqueteXMLGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContParalelaPaqueteXMLGenerar') and type = 'P') drop procedure dbo.spContParalelaPaqueteXMLGenerar
GO             
CREATE PROC spContParalelaPaqueteXMLGenerar 
			@ID					int, 
			@Empresa			varchar(5), 
			@Mov				varchar(20), 
			@MovID				varchar(20), 
			@MovTipo			varchar(20), 
			@BaseDatos			varchar(255), 
			@EmpresaOrigen		varchar(5), 
			@CuentaD			varchar(20), 
			@CuentaA			varchar(20), 
			@Nivel				varchar(20), 
			@CPBaseLocal		bit,
			@CPBaseDatos		varchar(255),
			@CPURL				varchar(255),
			@CPCentralizadora	bit,
			@CPUsuario			varchar(10),
			@CPContrasena		varchar(32),
			@ISReferencia		varchar(100),			
			@IDEmpresa			int,
			--REQ25300
			@CONTEsCancelacion	bit, 
			@Detalle			varchar(max)	OUTPUT,
			@Ok					int				OUTPUT,
			@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @OrigenTipo		varchar(5),
		  @OrigenTipoAnt	varchar(5),
		  @SQL				nvarchar(max),
		  @Consulta			nvarchar(max),
		  @WHERE			nvarchar(max),
		  @FOR				nvarchar(max),
		  @XML				nvarchar(max),
		  @Parametros		nvarchar(max)

  SELECT @Detalle = ''
  
  SELECT @WHERE = '       WHERE ContParalelaD.ID = @ID AND ISNULL(Cont.OrigenTipo, '''') = ISNULL(@OrigenTipo, '''')'
  SELECT @FOR = '         FOR XML AUTO '
  
  SELECT @Parametros = '@XML			varchar(max) OUTPUT,
						@ID				int,
						@OrigenTipo		varchar(5)'
  
  SELECT @OrigenTipoAnt = MAX(OrigenTipo) + '.'
    FROM ContParalelaD
    JOIN Cont ON ContParalelaD.ContID = Cont.ID
   WHERE ContParalelaD.ID = @ID
   
  WHILE(1=1)
  BEGIN
    SELECT @OrigenTipo = MAX(ISNULL(OrigenTipo, ''))
      FROM ContParalelaD
      JOIN Cont ON ContParalelaD.ContID = Cont.ID
     WHERE ContParalelaD.ID = @ID
       AND ISNULL(OrigenTipo, '') < @OrigenTipoAnt

    IF @OrigenTipo IS NULL BREAK
    
    SELECT @OrigenTipoAnt = @OrigenTipo, @SQL = '', @Consulta = '', @XML = ''
    
    SELECT @Consulta = Consulta FROM ContParalelaXMLPlantilla WHERE Modulo = @OrigenTipo

    IF @CONTEsCancelacion = 1
    BEGIN
      SELECT @Consulta = REPLACE(@Consulta, 'ContD.Debe',  '-1*ContD.Debe  ''Debe''')
      SELECT @Consulta = REPLACE(@Consulta, 'ContD.Haber', '-1*ContD.Haber ''Haber''')      
    END
    
    SELECT @SQL = 'SELECT @XML = (' + CHAR(13) + @Consulta + CHAR(13) + @WHERE + CHAR(13) + @FOR + ')'

    BEGIN TRY
      EXEC sp_executesql @SQL, @Parametros, @XML = @XML OUTPUT, @ID = @ID, @OrigenTipo = @OrigenTipo

      SELECT @Detalle = @Detalle + ISNULL(@XML, '')      
    END TRY
    BEGIN CATCH
      SELECT @Ok = 1, @OkRef = dbo.fnOkRefSQL(ERROR_NUMBER(), ERROR_MESSAGE())    
      RETURN
    END CATCH
  END
  
  RETURN
END
GO

/**************** spContParalelaXMLGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContParalelaXMLGenerar') and type = 'P') drop procedure dbo.spContParalelaXMLGenerar
GO             
CREATE PROC spContParalelaXMLGenerar 
			@ID					int, 
			@Empresa			varchar(5), 
			@Mov				varchar(20), 
			@MovID				varchar(20), 
			@MovTipo			varchar(20), 
			@BaseDatos			varchar(255), 
			@EmpresaOrigen		varchar(5), 
			@CuentaD			varchar(20), 
			@CuentaA			varchar(20), 
			@Nivel				varchar(20), 
			@CPBaseLocal		bit,
			@CPBaseDatos		varchar(255),
			@CPURL				varchar(255),
			@CPCentralizadora	bit,
			@CPUsuario			varchar(10),
			@CPContrasena		varchar(32),
			@ISReferencia		varchar(100),			
			@IDEmpresa			int,
			@CONTEsCancelacion	bit,
			@XML				varchar(max)	OUTPUT,
			@Ok					int				OUTPUT,
			@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Detalle		varchar(max),
		  @SubLlave		varchar(10)
  
  DELETE ContParalelaXML WHERE ID = @ID
  
  SELECT @BaseDatos = DB_NAME()
  
  SELECT @SubLlave = CASE @MovTipo
					   WHEN 'CONTP.ENVIARCUENTAS' THEN 'Solicitud'
					   WHEN 'CONTP.RECIBIRCUENTA' THEN 'Resultado'
					   WHEN 'CONTP.PAQUETE' THEN 'Solicitud'
					   WHEN 'CONTP.RECIBIRPAQUETE' THEN 'Resultado'
					   ELSE 'Solicitud'
                     END

  IF @MovTipo IN('CONTP.ENVIARCUENTAS', 'CONTP.RECIBIRCUENTA')
    SELECT @Detalle = (SELECT Cuenta, Rama, Descripcion, Tipo, Categoria, Grupo, Familia, EsAcreedora, EsAcumulativa, Estatus, TieneMovimientos, CtaEstatus 
                         FROM ContParalelaD     
                        WHERE ID = @ID
                          FOR XML AUTO)

  IF @MovTipo IN('CONTP.RECIBIRPAQUETE')
    SELECT @Detalle = (SELECT ContID, ContMov, ContMovID, ContFechaEmision, ContOrigenTipo, ContOrigen, ContOrigenID, PolizaEstatus
                         FROM ContParalelaD
                        WHERE ID = @ID
                          FOR XML AUTO)

  IF @MovTipo IN('CONTP.PAQUETE')
    EXEC spContParalelaPaqueteXMLGenerar @ID, @Empresa, @Mov, @MovID, @MovTipo, @BaseDatos, @EmpresaOrigen, @CuentaD, @CuentaA, @Nivel, @CPBaseLocal, @CPBaseDatos, @CPURL, @CPCentralizadora, @CPUsuario, @CPContrasena, @ISReferencia, @IDEmpresa, /*REQ25300*/ @CONTEsCancelacion, @Detalle OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
                          
  SELECT @XML = '<?xml version="1.0" encoding="windows-1252" ?>'
  SELECT @XML = @XML + '<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="' + ISNULL(@ISReferencia, '') + '" SubReferencia="" Version="01" Ok="' + ISNULL(CONVERT(varchar(max), @Ok), '') + '" OkRef="' + ISNULL(@OkRef, '') +'" Usuario ="' + ISNULL(@CPUsuario, '') + '" Contrasena ="' + ISNULL(@CPContrasena, '') + '">
                   <' + @SubLlave + '>
                     <ContParalela Usuario ="' + ISNULL(@CPUsuario, '') + '" Mov ="' + ISNULL(@Mov, '') + '" MovID = "' + ISNULL(@MovID, '') + '" BaseDatos="' + ISNULL(@BaseDatos, '') + '" Empresa="' + ISNULL(@Empresa, '') + '" CuentaD="' + ISNULL(@CuentaD, '') + '" CuentaA="' + ISNULL(@CuentaA, '') + '" CPBaseLocal="' + ISNULL(CONVERT(varchar(max), @CPBaseLocal), '') + '" CPBaseDatos="' + ISNULL(@CPBaseDatos, '') + '" CPURL="' + ISNULL(@CPURL, '') + '" CPCentralizadora="' + ISNULL(CONVERT(varchar(max), @CPCentralizadora), '') + '" Nivel="' + ISNULL(@Nivel, '')+'" CONTEsCancelacion="'	+CONVERT(varchar(max), @CONTEsCancelacion) + '" />'

  SELECT @XML = @XML + ISNULL(@Detalle, '')

  SELECT @XML = @XML + '  </' + @SubLlave + '>
                        </Intelisis>'

  INSERT ContParalelaXML(ID, XML) SELECT @ID, @XML

  RETURN
END
GO

/**************** spContParalelaCtaObtener ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContParalelaCtaObtener') and type = 'P') drop procedure dbo.spContParalelaCtaObtener
GO             
CREATE PROC spContParalelaCtaObtener 
			@ID			int, 
			@CuentaD	varchar(20), 
			@CuentaA	varchar(20), 
			@Nivel		varchar(10), 
			@Ok			int				OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DELETE ContParalelaD WHERE ID = @ID
  
  CREATE TABLE #Cta(
    RID					int				IDENTITY,
    Cuenta				varchar(20)		COLLATE DATABASE_DEFAULT NULL, 
    Rama				varchar(20)		COLLATE DATABASE_DEFAULT NULL, 
    Descripcion			varchar(100)	COLLATE DATABASE_DEFAULT NULL, 
    Tipo				varchar(15)		COLLATE DATABASE_DEFAULT NULL, 
    Categoria			varchar(50)		COLLATE DATABASE_DEFAULT NULL, 
    Grupo				varchar(50)		COLLATE DATABASE_DEFAULT NULL, 
    Familia				varchar(50)		COLLATE DATABASE_DEFAULT NULL, 
    EsAcreedora			bit				NULL, 
    EsAcumulativa		bit				NULL,
    Estatus				varchar(15)		COLLATE DATABASE_DEFAULT NULL, 
    TieneMovimientos	bit				NULL
    )
    
  IF @Nivel = 'AUXILIAR'
    INSERT INTO #Cta(
           Cuenta, Rama, Descripcion, Tipo, Categoria, Grupo, Familia, EsAcreedora, EsAcumulativa, Estatus, TieneMovimientos)
    SELECT Cuenta, Rama, Descripcion, Tipo, Categoria, Grupo, Familia, EsAcreedora, EsAcumulativa, Estatus, TieneMovimientos
      FROM Cta 
     WHERE Cuenta BETWEEN ISNULL(NULLIF(RTRIM(@CuentaD), ''), Cuenta) AND ISNULL(NULLIF(RTRIM(@CuentaA), ''), Cuenta)
       AND Tipo IN ('MAYOR', 'SUBCUENTA', 'AUXILIAR')
    UNION ALL
    SELECT Cuenta, Rama, Descripcion, Tipo, Categoria, Grupo, Familia, EsAcreedora, EsAcumulativa, Estatus, TieneMovimientos
      FROM Cta 
     WHERE Tipo IN ('ESTRUCTURA')   
  ELSE IF @Nivel = 'SUBCUENTA'
    INSERT INTO #Cta(
           Cuenta, Rama, Descripcion, Tipo, Categoria, Grupo, Familia, EsAcreedora, EsAcumulativa, Estatus, TieneMovimientos)  
    SELECT Cuenta, Rama, Descripcion, Tipo, Categoria, Grupo, Familia, EsAcreedora, EsAcumulativa, Estatus, TieneMovimientos
      FROM Cta 
     WHERE Cuenta BETWEEN ISNULL(NULLIF(RTRIM(@CuentaD), ''), Cuenta) AND ISNULL(NULLIF(RTRIM(@CuentaA), ''), Cuenta)
       AND Tipo IN ('MAYOR', 'SUBCUENTA')
    UNION ALL
    SELECT Cuenta, Rama, Descripcion, Tipo, Categoria, Grupo, Familia, EsAcreedora, EsAcumulativa, Estatus, TieneMovimientos
      FROM Cta 
     WHERE Tipo IN ('ESTRUCTURA')          
  ELSE IF @Nivel = 'MAYOR'
    INSERT INTO #Cta(
           Cuenta, Rama, Descripcion, Tipo, Categoria, Grupo, Familia, EsAcreedora, EsAcumulativa, Estatus, TieneMovimientos)  
    SELECT Cuenta, Rama, Descripcion, Tipo, Categoria, Grupo, Familia, EsAcreedora, EsAcumulativa, Estatus, TieneMovimientos
      FROM Cta 
     WHERE Cuenta BETWEEN ISNULL(NULLIF(RTRIM(@CuentaD), ''), Cuenta) AND ISNULL(NULLIF(RTRIM(@CuentaA), ''), Cuenta)
       AND Tipo IN ('MAYOR')
    UNION ALL
    SELECT Cuenta, Rama, Descripcion, Tipo, Categoria, Grupo, Familia, EsAcreedora, EsAcumulativa, Estatus, TieneMovimientos
      FROM Cta 
     WHERE Tipo IN ('ESTRUCTURA')          

  INSERT INTO ContParalelaD(
			ID, Renglon,  Cuenta, Rama, Descripcion, Tipo, Categoria, Grupo, Familia, EsAcreedora, EsAcumulativa, Estatus, TieneMovimientos)
	SELECT @ID, RID*2048, Cuenta, Rama, Descripcion, Tipo, Categoria, Grupo, Familia, EsAcreedora, EsAcumulativa, Estatus, TieneMovimientos
	  FROM #Cta

  RETURN
END
GO

/**************** spContParalelaCtaRecibir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContParalelaCtaRecibir') and type = 'P') drop procedure dbo.spContParalelaCtaRecibir
GO             
CREATE PROCEDURE spContParalelaCtaRecibir
			@ID					int, 
			@Empresa			varchar(5), 
			@Mov				varchar(20), 
			@MovID				varchar(20), 
			@BaseDatos			varchar(255), 
			@EmpresaOrigen		varchar(5), 
			@IDEmpresa			int,
			@Ok					int			 OUTPUT, 
			@OkRef				varchar(255) OUTPUT        
--//WITH ENCRYPTION
AS
BEGIN  
  BEGIN TRY
    UPDATE ContParalelaD 
       SET CtaEstatus = 'Actualizada'
      FROM ContParalelaD
      JOIN ContParalelaCta ON ContParalelaD.Cuenta = ContParalelaCta.Cuenta AND ContParalelaCta.Empresa = @Empresa AND ContParalelaCta.ID = @IDEmpresa
     WHERE ContParalelaD.ID = @ID

     UPDATE ContParalelaCta
       SET Rama				= ContParalelaD.Rama,
		   Descripcion		= ContParalelaD.Descripcion,
		   Tipo				= ContParalelaD.Tipo,
		   Categoria		= ContParalelaD.Categoria,
		   Familia			= ContParalelaD.Familia,
		   Grupo			= ContParalelaD.Grupo,
		   EsAcreedora		= ContParalelaD.EsAcreedora,
		   EsAcumulativa	= ContParalelaD.EsAcumulativa,
		   TieneMovimientos	= ContParalelaD.TieneMovimientos,
		   Estatus			= ContParalelaD.Estatus
      FROM ContParalelaD
      JOIN ContParalelaCta ON ContParalelaD.Cuenta = ContParalelaCta.Cuenta AND ContParalelaCta.Empresa = @Empresa AND ContParalelaCta.ID = @IDEmpresa
     WHERE ContParalelaD.ID = @ID  

    UPDATE ContParalelaD 
       SET CtaEstatus = 'Registrada'
      FROM ContParalelaD
     WHERE Cuenta NOT IN(SELECT Cuenta FROM ContParalelaCta WHERE Empresa = @Empresa AND ID = @IDEmpresa)
       AND ID = @ID

    INSERT INTO ContParalelaCta(
		    ID,         Empresa, Cuenta, Rama, Descripcion, Tipo, Categoria, Familia, Grupo, EsAcreedora, EsAcumulativa, TieneMovimientos, Estatus, Alta)
    SELECT @IDEmpresa, @Empresa, Cuenta, Rama, Descripcion, Tipo, Categoria, Familia, Grupo, EsAcreedora, EsAcumulativa, TieneMovimientos, Estatus, GETDATE()
      FROM ContParalelaD
     WHERE Cuenta NOT IN(SELECT Cuenta FROM ContParalelaCta WHERE Empresa = @Empresa AND ID = @IDEmpresa)
       AND ID = @ID
  END TRY
  BEGIN CATCH
    SELECT @Ok = 1, @OkRef = dbo.fnOkRefSQL(ERROR_NUMBER(), ERROR_MESSAGE())    
    RETURN  
  END CATCH   
  RETURN
END
GO

/**************** spContParalelaPolizaObtener ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContParalelaPolizaObtener') and type = 'P') drop procedure dbo.spContParalelaPolizaObtener
GO             
CREATE PROC spContParalelaPolizaObtener 
			@ID					int, 
			
			@Accion				varchar(20),
			@Sucursal			int,
			@Usuario			varchar(10), 
			@Empresa			varchar(5), 
			@Mov				varchar(20), 
			@MovID				varchar(20), 
			@MovTipo			varchar(20), 
			@BaseDatos			varchar(255), 
			@EmpresaOrigen		varchar(5), 
			@CuentaD			varchar(20), 
			@CuentaA			varchar(20), 
			@Nivel				varchar(20), 
			@CPBaseLocal		bit,
			@CPBaseDatos		varchar(255),
			@CPURL				varchar(255),
			@CPCentralizadora	bit,
			@CPUsuario			varchar(10),
			@CPContrasena		varchar(32),
			@ISReferencia		varchar(100),			
			@IDEmpresa			int,
			@GeneraEjercicio	int, 
			@GeneraPeriodo		int, 
			@GeneraFechaD		datetime, 
			@GeneraFechaA		datetime, 
			@GeneraMov			varchar(20),
			@GeneraMovID		varchar(20),
			@GeneraContMov		varchar(20),
			@GeneraContMovID	varchar(20),
			--REQ25300
			@CONTEsCancelacion	bit, 
			@GeneraContID		int				OUTPUT,
			@XML				varchar(max)	OUTPUT,
			@Ok					int				OUTPUT,
			@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN      
  CREATE TABLE #Mov(
    RID					int IDENTITY, 
    Fecha				datetime,
    ContID				int,
    ContMov				varchar(20),
    ContMovID			varchar(20),
	ContFechaEmision	datetime,
	ContOrigenTipo		varchar(5)		NULL,
	ContOrigen			varchar(20)		NULL,
	ContOrigenID		varchar(20)		NULL
  )
  
  DELETE ContParalelaD WHERE ID = @ID

  INSERT INTO #Mov(
			Fecha,        ContID, ContMov, ContMovID, ContFechaEmision, ContOrigenTipo, ContOrigen, ContOrigenID) 
     SELECT FechaEmision, ID,     Mov,     MovID,     FechaEmision,     OrigenTipo,	  Origen,     OrigenID
       FROM Cont
      WHERE Empresa = @Empresa 
        AND FechaEmision BETWEEN @GeneraFechaD AND @GeneraFechaA
        AND Estatus = CASE @CONTEsCancelacion WHEN 0 THEN 'CONCLUIDO' ELSE 'CANCELADO' END
        AND Mov   = ISNULL(@GeneraContMov, Mov)
        AND MovID = ISNULL(@GeneraContMovID, MovID)

    INSERT INTO ContParalelaD(
				ID,  Renglon,  ContID, ContMov, ContMovID, ContFechaEmision, ContOrigenTipo, ContOrigen, ContOrigenID)
		 SELECT @ID, RID*2048, ContID, ContMov, ContMovID, ContFechaEmision, ContOrigenTipo, ContOrigen, ContOrigenID
  		   FROM #Mov

  IF @GeneraContMov IS NOT NULL AND @GeneraContMovID IS NOT NULL
  BEGIN
    SELECT @GeneraContID = ContID FROM #Mov
    
    UPDATE ContParalela SET GeneraContID = @GeneraContID WHERE ID = @ID
  END
  
  RETURN
END
GO

/**************** spContParalelaPaqueteGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContParalelaPaqueteGenerar') and type = 'P') drop procedure dbo.spContParalelaPaqueteGenerar
GO             
CREATE PROC spContParalelaPaqueteGenerar 
			@ID					int, 
			
			@Accion				varchar(20),
			@Sucursal			int,
			@Usuario			varchar(10), 
			@Empresa			varchar(5), 
			@Mov				varchar(20), 
			@MovID				varchar(20), 
			@MovTipo			varchar(20), 
			@BaseDatos			varchar(255), 
			@EmpresaOrigen		varchar(5), 
			@CuentaD			varchar(20), 
			@CuentaA			varchar(20), 
			@Nivel				varchar(20), 
			@CPBaseLocal		bit,
			@CPBaseDatos		varchar(255),
			@CPURL				varchar(255),
			@CPCentralizadora	bit,
			@CPUsuario			varchar(10),
			@CPContrasena		varchar(32),
			@ISReferencia		varchar(100),			
			@IDEmpresa			int,
			@GeneraEjercicio	int, 
			@GeneraPeriodo		int, 
			@GeneraFechaD		datetime, 
			@GeneraFechaA		datetime, 
			@XML				varchar(max)	OUTPUT,
			@Ok					int				OUTPUT,
			@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Fecha				datetime,
		  @FechaAnt				datetime,
		  @GenerarMov			varchar(20),
		  @FechaTrabajo			datetime,
		  @GeneraID				int,
		  @CONTPConcluirPaquete	bit,
		  @IDCancela			int,
		  @IDCancelaAnt			int
  
  SELECT @FechaTrabajo = GETDATE()
  
  EXEC spExtraerFecha @FechaTrabajo OUTPUT
  
  SELECT @GenerarMov = CPPaquete FROM EmpresaCfgMovContParalela WHERE Empresa = @Empresa
  
  SELECT @CONTPConcluirPaquete = ISNULL(CONTPConcluirPaquete, 0) FROM EmpresaCfg2 WHERE Empresa = @Empresa  
    
  IF @Accion = 'AFECTAR'
  BEGIN
    CREATE TABLE #Mov(
      RID				int IDENTITY, 
      Fecha				datetime
    )
  
    CREATE INDEX Fecha ON #Mov(Fecha)  
  
    INSERT INTO #Mov(
			  Fecha) 
       SELECT FechaEmision
         FROM Cont 
        WHERE Empresa = @Empresa 
          AND Ejercicio = @GeneraEjercicio 
          AND Periodo = @GeneraPeriodo 
          AND Estatus = 'CONCLUIDO'

    SELECT @FechaAnt = ''
    WHILE(1=1)
    BEGIN
      SELECT @Fecha = MIN(Fecha)
        FROM #Mov
       WHERE Fecha > @FechaAnt
    
      IF @Fecha IS NULL BREAK
    
      SELECT @FechaAnt = @Fecha, @GeneraID = NULL
    
      EXEC @GeneraID = spMovCopiar @Sucursal, 'CONTP', @ID, @Usuario, @FechaTrabajo, 1, 1, NULL, NULL, @GenerarMov, NULL, NULL, NULL, 1, 1
    
      UPDATE ContParalela 
         SET Estatus = 'SINAFECTAR',
             GeneraFechaD = @Fecha, 
             GeneraFechaA = @Fecha,
             OrigenTipo = 'CONTP',
             Origen = @Mov,
             OrigenID = @MovID
       WHERE ID = @GeneraID
    
      EXEC spAfectar 'CONTP', @GeneraID, 'AFECTAR', @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      
      IF @Ok IS NULL AND @CONTPConcluirPaquete = 1
        EXEC spAfectar 'CONTP', @GeneraID, 'AFECTAR', @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

      IF @Ok IS NOT NULL RETURN
    END
  END
  ELSE IF @Accion = 'CANCELAR'
  BEGIN
    SELECT @IDCancelaAnt = 0
    WHILE(1=1)
    BEGIN
      SELECT @IDCancela = MIN(ID)
        FROM ContParalela 
       WHERE Mov = @GenerarMov 
         AND OrigenTipo = 'CONTP' 
         AND Origen = @Mov 
         AND OrigenID = @MovID
         AND Estatus = 'PENDIENTE'
         AND ID > @IDCancelaAnt

      IF @IDCancela IS NULL BREAK
      
      SELECT @IDCancelaAnt = @IDCancela
      
      EXEC spAfectar 'CONTP', @IDCancela, 'CANCELAR', @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    END
  END
  RETURN
END
GO

/**************** spContParalelaPaqueteRecibir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContParalelaPaqueteRecibir') and type = 'P') drop procedure dbo.spContParalelaPaqueteRecibir
GO             
CREATE PROCEDURE spContParalelaPaqueteRecibir
			@ID					int, 
			@Empresa			varchar(5), 
			@Mov				varchar(20), 
			@MovID				varchar(20), 
			@BaseDatos			varchar(255), 
			@EmpresaOrigen		varchar(5), 
			@IDEmpresa			int,
			--REQ25300
			@CONTEsCancelacion	bit, 
			@Ok					int			 OUTPUT, 
			@OkRef				varchar(255) OUTPUT   
--//WITH ENCRYPTION     
AS
BEGIN
  BEGIN TRY
    UPDATE #Cont
       SET Transformada = 1
      FROM #Cont
      JOIN ContParalelaPoliza ON ContParalelaPoliza.ID = #Cont.ID AND ContParalelaPoliza.IDEmpresa = @IDEmpresa AND #Cont.Estatus = ContParalelaPoliza.Estatus
     WHERE ContParalelaPoliza.CPPolizaID IS NOT NULL

    DELETE ContParalelaPoliza 
      FROM ContParalelaPoliza
      JOIN #Cont ON ContParalelaPoliza.ID = #Cont.ID AND ContParalelaPoliza.IDEmpresa = @IDEmpresa AND #Cont.Estatus = ContParalelaPoliza.Estatus
     WHERE CPPolizaID IS NULL

    DELETE ContParalelaPolizaD
      FROM ContParalelaPolizaD
      JOIN ContParalelaPoliza ON ContParalelaPolizaD.IDEmpresa = ContParalelaPoliza.IDEmpresa AND ContParalelaPolizaD.ID = ContParalelaPoliza.ID
      JOIN #ContD ON ContParalelaPolizaD.ID = #ContD.ID AND ContParalelaPolizaD.IDEmpresa = @IDEmpresa
      JOIN #Cont  ON #ContD.ID = #Cont.ID AND #Cont.Transformada = 0 AND #Cont.Estatus = ContParalelaPoliza.Estatus

    DELETE ContParalelaPolizaOrigen
      FROM ContParalelaPolizaOrigen
      JOIN #Origen ON ContParalelaPolizaOrigen.ID = #Origen.ContID AND ContParalelaPolizaOrigen.IDEmpresa = @IDEmpresa    
      JOIN #Cont   ON #Origen.ContID = #Cont.ID AND #Cont.Transformada = 0

    INSERT INTO ContParalelaPoliza(
			  IDEmpresa, ID, Empresa, Mov, MovID, FechaEmision, FechaContable, Concepto, Proyecto, UEN, Contacto, ContactoTipo, Moneda, TipoCambio, Usuario, Referencia, Estatus, OrigenTipo, Origen, OrigenID, Ejercicio, Periodo, Sucursal, Importe, RecepcionFecha, RecepcionMoneda, RecepcionTipoCambio, OrigenMoneda, OrigenTipoCambio,  CONTEsCancelacion)
	  SELECT @IDEmpresa, ID, Empresa, Mov, MovID, FechaEmision, FechaContable, Concepto, Proyecto, UEN, Contacto, ContactoTipo, Moneda, TipoCambio, Usuario, Referencia, Estatus, OrigenTipo, Origen, OrigenID, Ejercicio, Periodo, Sucursal, Importe, RecepcionFecha, RecepcionMoneda, RecepcionTipoCambio, OrigenMoneda, OrigenTipoCambio, @CONTEsCancelacion
  	    FROM #Cont
       WHERE Transformada = 0
     
    INSERT INTO ContParalelaPolizaD(
			  IDEmpresa, ID,        Renglon,        RenglonSub,        Cuenta,        Debe,        Haber,         CONTEsCancelacion)
	  SELECT @IDEmpresa, #ContD.ID, #ContD.Renglon, #ContD.RenglonSub, #ContD.Cuenta, #ContD.Debe, #ContD.Haber, @CONTEsCancelacion
  	    FROM #ContD
  	    JOIN #Cont  ON #ContD.ID = #Cont.ID AND #Cont.Transformada = 0

    INSERT INTO ContParalelaPolizaOrigen(
			  IDEmpresa, ID,             IDOrigen,   Mov,         MovID,         FechaEmision,         Concepto,         Proyecto,         UEN,         Moneda,         TipoCambio,         Usuario,         Referencia,         Estatus,         ContactoTipo,         Contacto,         Almacen,         Condicion,         Vencimiento,         Importe,         Impuestos,         Ejercicio,         Periodo,         MovTipo,         SubMovTipo,         Modulo)
	  SELECT @IDEmpresa, #Origen.ContID, #Origen.ID, #Origen.Mov, #Origen.MovID, #Origen.FechaEmision, #Origen.Concepto, #Origen.Proyecto, #Origen.UEN, #Origen.Moneda, #Origen.TipoCambio, #Origen.Usuario, #Origen.Referencia, #Origen.Estatus, #Origen.ContactoTipo, #Origen.Contacto, #Origen.Almacen, #Origen.Condicion, #Origen.Vencimiento, #Origen.Importe, #Origen.Impuestos, #Origen.Ejercicio, #Origen.Periodo, #Origen.MovTipo, #Origen.SubMovTipo, #Origen.Modulo
	    FROM #Origen
	    JOIN #Cont   ON #Origen.ContID = #Cont.ID AND #Cont.Transformada = 0
       
    UPDATE ContParalelaPolizaContacto
       SET Nombre				= #Contacto.Nombre,
           Direccion			= #Contacto.Direccion,
           DireccionNumero		= #Contacto.DireccionNumero,
           DireccionNumeroInt	= #Contacto.DireccionNumeroInt,
           EntreCalles			= #Contacto.EntreCalles,
           Delegacion			= #Contacto.Delegacion,
           Colonia				= #Contacto.Colonia,
           Poblacion			= #Contacto.Poblacion,
           Estado				= #Contacto.Estado,
           Pais					= #Contacto.Pais,
           CodigoPostal			= #Contacto.CodigoPostal,
           RFC					= #Contacto.RFC,
           CURP					= #Contacto.CURP,
           Categoria			= #Contacto.Categoria,
           Grupo				= #Contacto.Grupo,
           Familia				= #Contacto.Familia
      FROM ContParalelaPolizaContacto
      JOIN #Contacto ON ContParalelaPolizaContacto.ContactoTipo = #Contacto.ContactoTipo AND ContParalelaPolizaContacto.Contacto = #Contacto.Contacto AND ContParalelaPolizaContacto.IDEmpresa = @IDEmpresa

    INSERT INTO ContParalelaPolizaContacto(
			  IDEmpresa, ContactoTipo, Contacto, Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, RFC, CURP, Categoria, Grupo, Familia)  
	  SELECT @IDEmpresa, ContactoTipo, Contacto, Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, RFC, CURP, Categoria, Grupo, Familia
  	    FROM #Contacto
	   WHERE Contacto NOT IN(SELECT Contacto FROM ContParalelaPolizaContacto WHERE IDEmpresa = @IDEmpresa AND ContactoTipo = #Contacto.ContactoTipo)

    UPDATE ContParalelaD 
       SET PolizaEstatus = 'Registrada'
      FROM ContParalelaD
      JOIN ContParalelaPoliza ON ContParalelaD.ContID = ContParalelaPoliza.ID AND ContParalelaPoliza.IDEmpresa = @IDEmpresa
     WHERE ContParalelaD.ID = @ID
       AND ContParalelaPoliza.CPPolizaID IS NULL

    UPDATE ContParalelaD 
       SET PolizaEstatus = 'Transformada'
      FROM ContParalelaD
      JOIN ContParalelaPoliza ON ContParalelaD.ContID = ContParalelaPoliza.ID AND ContParalelaPoliza.IDEmpresa = @IDEmpresa
     WHERE ContParalelaD.ID = @ID
       AND ContParalelaPoliza.CPPolizaID IS NOT NULL       

    UPDATE ContParalelaD 
       SET PolizaEstatus = 'No Registrada'     
     WHERE ContParalelaD.ID = @ID
       AND PolizaEstatus IS NULL

  END TRY
  BEGIN CATCH
    SELECT @Ok = 1, @OkRef = dbo.fnOkRefSQL(ERROR_NUMBER(), ERROR_MESSAGE())    
    RETURN
  END CATCH
  
  RETURN
END
GO

/**************** spContParalelaPolizaConstruir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContParalelaPolizaConstruir') and type = 'P') drop procedure dbo.spContParalelaPolizaConstruir
GO
CREATE PROC spContParalelaPolizaConstruir
			@ID					int,
			@Sucursal			int,
			@Usuario			varchar(10), 
			@Empresa			varchar(5), 			
			@Mov				varchar(20),
			@MovID				varchar(20),
			@IDEmpresaAux		int, 
			@IDAux				int, 
			@GenerarMov			varchar(20),
			@FechaTrabajo		datetime,
			@BaseDatosRemota	varchar(255),
		    @EmpresaRemota		varchar(255),
		    @CONTEsCancelacion	bit,
			@CPPolizaID			int				OUTPUT, 
			@Ok					int				OUTPUT, 
			@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @OrigenTipoCambio		float,
		  @RecepcionTipoCambio	float,
		  @OrigenMov			varchar(20),
		  @OrigenMovID			varchar(20),
		  @FechaEmision			datetime,
		  @GeneraEjercicio		int,
		  @GeneraPeriodo		int
  
  SELECT @OrigenTipoCambio		= ISNULL(NULLIF(OrigenTipoCambio, 0), TipoCambio),
         @RecepcionTipoCambio	= ISNULL(NULLIF(RecepcionTipoCambio, 0), ISNULL(NULLIF(OrigenTipoCambio, 0), TipoCambio)),
         @OrigenMov = Mov,
         @OrigenMovID = MovID,
         @FechaEmision = FechaEmision,
         @GeneraEjercicio = YEAR(FechaEmision),
         @GeneraPeriodo = MONTH(FechaEmision)
    FROM ContParalelaPoliza
   WHERE ID = @IDAux 
     AND IDEmpresa = @IDEmpresaAux
  
  CREATE TABLE #PolizaD(
    RID						int			IDENTITY, 
    Cuenta					varchar(20), 
    CuentaAsignada			varchar(20) NULL,
    TransformarNegativo		bit			NULL,
    Debe					float		NULL, 
    Haber					float		NULL
    )
  
  INSERT INTO #PolizaD(
			Cuenta,  Debe,                                          Haber)
     SELECT Cuenta, (Debe/@OrigenTipoCambio)*@RecepcionTipoCambio, (Haber/@OrigenTipoCambio)*@RecepcionTipoCambio
       FROM ContParalelaPolizaD
      WHERE IDEmpresa = @IDEmpresaAux
        AND ID = @IDAux
        AND ISNULL(CONTEsCancelacion, 0) = ISNULL(@CONTEsCancelacion, 0)
  
  UPDATE #PolizaD
     SET CuentaAsignada			= Cta.CuentaAsignada,
         TransformarNegativo	= ISNULL(Cta.TransformarNegativo, 0)
    FROM #PolizaD
    JOIN ContParalelaCta Cta ON #PolizaD.Cuenta = Cta.Cuenta
   WHERE Cta.ID = @IDEmpresaAux

  UPDATE #PolizaD
     SET Debe = Haber * -1,
         Haber = Debe * -1
   WHERE TransformarNegativo = 1

  DELETE #PolizaD WHERE CuentaAsignada IS NULL
  
  EXEC @CPPolizaID = spMovCopiar @Sucursal, 'CONTP', @ID, @Usuario, @FechaTrabajo, 1, 1, NULL, NULL, @GenerarMov, NULL, NULL, NULL, 1, 1 

  UPDATE ContParalela 
     SET Estatus = 'CONFIRMAR',
         OrigenTipo = 'CONTP',
         Origen = @Mov,
         OrigenID = @MovID,
         BaseDatosOrigen = @BaseDatosRemota, 
		 EmpresaOrigen = @EmpresaRemota,
		 Referencia = RTRIM(ISNULL(@OrigenMov, ''))+' '+RTRIM(ISNULL(@OrigenMovID, '')),
		 IDEmpresa = @IDEmpresaAux,
		 IDAux = @IDAux,
		 GeneraEjercicio = @GeneraEjercicio,
		 GeneraPeriodo = @GeneraPeriodo,
		 GeneraFechaD = @FechaEmision,
		 GeneraFechaA = @FechaEmision
   WHERE ID = @CPPolizaID
  
  INSERT INTO ContParalelaD(
			 ID,         Renglon,  Cuenta,         Debe, Haber)
     SELECT @CPPolizaID, RID*2048, CuentaAsignada, Debe, Haber
       FROM #PolizaD
  RETURN
END
GO

/**************** spContParalelaPolizaGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContParalelaPolizaGenerar') and type = 'P') drop procedure dbo.spContParalelaPolizaGenerar
GO
CREATE PROC spContParalelaPolizaGenerar 
			@ID						int, 
			
			@Accion					varchar(20),
			@Sucursal				int,
			@Usuario				varchar(10), 
			@Empresa				varchar(5), 
			@Mov					varchar(20), 
			@MovID					varchar(20), 
			@MovTipo				varchar(20), 
			@BaseDatos				varchar(255), 
			@EmpresaOrigen			varchar(5), 
			@CuentaD				varchar(20), 
			@CuentaA				varchar(20), 
			@Nivel					varchar(20), 
			@CPBaseLocal			bit,
			@CPBaseDatos			varchar(255),
			@CPURL					varchar(255),
			@CPCentralizadora		bit,
			@CPUsuario				varchar(10),
			@CPContrasena			varchar(32),
			@ISReferencia			varchar(100),			
			@IDEmpresa				int,
			@GeneraEjercicio		int, 
			@GeneraPeriodo			int, 
			@GeneraFechaD			datetime, 
			@GeneraFechaA			datetime, 
			@GeneraEmpresaOrigen	int,
			@GeneraMov				varchar(20),
			@GeneraMovID			varchar(20),
			@GeneraContMov			varchar(20),
			@GeneraContMovID		varchar(20),		
			@CONTEsCancelacion		bit,	
			@XML					varchar(max)	OUTPUT,
			@Ok						int				OUTPUT,
			@OkRef					varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @GenerarMov			varchar(20),
		  @FechaTrabajo			datetime,
		  @GeneraID				int,
		  @CONTPConcluirPolizas	bit,
		  @IDCancela			int,
		  @IDCancelaAnt			int,
		  @IDEmpresaAux			int,
		  @IDEmpresaAuxAnt		int,
		  @IDAux				int,
		  @IDAuxAnt				int,
		  @CPPolizaID			int,
		  @BaseDatosRemota		varchar(255),
		  @EmpresaRemota		varchar(255),
		  @CONTPEnLinea			bit
  
  SELECT @FechaTrabajo = GETDATE()
  
  EXEC spExtraerFecha @FechaTrabajo OUTPUT
  
  SELECT @GenerarMov = CPPoliza FROM EmpresaCfgMovContParalela WHERE Empresa = @Empresa
  
  SELECT @CONTPConcluirPolizas = ISNULL(CONTPConcluirPolizas, 0), @CONTPEnLinea = ISNULL(CONTPEnLinea, 0) FROM EmpresaCfg2 WHERE Empresa = @Empresa  
    
  IF @Accion = 'AFECTAR'
  BEGIN
    SELECT @IDEmpresaAuxAnt = 0
    WHILE(1=1)
    BEGIN
      SELECT @IDEmpresaAux = MIN(ID)
        FROM ContParalelaEmpresa
       WHERE Empresa = @Empresa
         AND ID = ISNULL(@GeneraEmpresaOrigen, ID)
         AND ID > @IDEmpresaAuxAnt

      IF @IDEmpresaAux IS NULL BREAK
      
      SELECT @IDEmpresaAuxAnt = @IDEmpresaAux
      
      SELECT @BaseDatosRemota = NULL,  @EmpresaRemota = NULL
      
      SELECT @BaseDatosRemota = BaseDatosRemota,  @EmpresaRemota = EmpresaRemota FROM ContParalelaEmpresa WHERE ID = @IDEmpresaAux
      
      SELECT @IDAuxAnt = 0
      WHILE(1=1)
      BEGIN
        SELECT @IDAux = MIN(ID)
          FROM ContParalelaPoliza
         WHERE IDEmpresa = @IDEmpresaAux
           AND ID > @IDAuxAnt
           AND CPPolizaID IS NULL
           AND Mov   = ISNULL(@GeneraMov, Mov)
           AND MovID = ISNULL(@GeneraMovID, MovID)           
           AND Estatus = CASE @CONTEsCancelacion WHEN 1 THEN 'CANCELADO' ELSE 'CONCLUIDO' END

        IF @IDAux IS NULL BREAK
        
        SELECT @IDAuxAnt = @IDAux
        
        SELECT @CPPolizaID = NULL
        
        EXEC spContParalelaPolizaConstruir @ID, @Sucursal, @Usuario, @Empresa, @Mov, @MovID, @IDEmpresaAux, @IDAux, @GenerarMov, @FechaTrabajo, @BaseDatosRemota, @EmpresaRemota, /*REQ25300*/ @CONTEsCancelacion, @CPPolizaID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        
        IF @CONTPConcluirPolizas = 1 OR (@CONTPEnLinea = 1)
          EXEC spAfectar 'CONTP', @CPPolizaID, 'AFECTAR', @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      END
    END
  END
  ELSE IF @Accion = 'CANCELAR'
  BEGIN
    DELETE ContParalelaD 
     WHERE ID IN(SELECT ID FROM ContParalela WHERE Mov = @GenerarMov AND OrigenTipo = 'CONTP' AND Origen = @Mov AND OrigenID = @MovID AND Estatus = 'CONFIRMAR')     
     
    DELETE ContParalela WHERE Mov = @GenerarMov AND OrigenTipo = 'CONTP' AND Origen = @Mov AND OrigenID = @MovID AND Estatus = 'CONFIRMAR'
    
    SELECT @IDCancelaAnt = 0
    WHILE(1=1)
    BEGIN
      SELECT @IDCancela = MIN(ID)
        FROM ContParalela 
       WHERE Mov = @GenerarMov 
         AND OrigenTipo = 'CONTP' 
         AND Origen = @Mov 
         AND OrigenID = @MovID
         AND Estatus = 'CONCLUIDO'
         AND ID > @IDCancelaAnt

      IF @IDCancela IS NULL BREAK
      
      SELECT @IDCancelaAnt = @IDCancela
      
      EXEC spAfectar 'CONTP', @IDCancela, 'CANCELAR', @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    END
  END
  RETURN
END
GO

/**************** spContParalelaPolizaContabilizar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContParalelaPolizaContabilizar') and type = 'P') drop procedure dbo.spContParalelaPolizaContabilizar
GO
CREATE PROC spContParalelaPolizaContabilizar 
			@ID						int, 

			@Accion					varchar(20),
			@Sucursal				int,
			@Usuario				varchar(10), 
			@Empresa				varchar(5), 
			@Mov					varchar(20), 
			@MovID					varchar(20), 
			@FechaEmision			datetime,
			@Referencia				varchar(50),
			@MovTipo				varchar(20), 
			@BaseDatos				varchar(255), 
			@EmpresaOrigen			varchar(5), 
			@CuentaD				varchar(20), 
			@CuentaA				varchar(20), 
			@Nivel					varchar(20), 
			@CPBaseLocal			bit,
			@CPBaseDatos			varchar(255),
			@CPURL					varchar(255),
			@CPCentralizadora		bit,
			@CPUsuario				varchar(10),
			@CPContrasena			varchar(32),
			@ISReferencia			varchar(100),			
			@IDEmpresa				int,
			@GeneraEjercicio		int, 
			@GeneraPeriodo			int, 
			@GeneraFechaD			datetime, 
			@GeneraFechaA			datetime, 
			@GeneraEmpresaOrigen	int,
			@XML					varchar(max)	OUTPUT,
			@Ok						int				OUTPUT,
			@OkRef					varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Moneda			varchar(10),
		  @TipoCambio		float,
		  @GeneraMov		varchar(20),
		  @ContID			int,
		  @IDAux			int,
		  @ContMov			varchar(20),
		  @FechaRegistro	datetime

  SELECT @FechaRegistro = GETDATE()  
   
  SELECT @IDAux = IDAux FROM ContParalela WHERE ID = @ID 
  
  SELECT @ContMov = Mov FROM ContParalelaPoliza WHERE IDEmpresa = @IDEmpresa AND ID = @IDAux

  SELECT @GeneraMov = Mov FROM MovTipo WHERE Modulo = 'CONT' AND Mov = @ContMov
  
  IF @GeneraMov IS NULL
    SELECT @GeneraMov = Mov FROM ContParalelaMovPoliza WHERE IDEmpresa = @IDEmpresa AND MovOrigen = @ContMov

  IF @GeneraMov IS NULL
  BEGIN
    SELECT @Ok = 30170, @OkRef = @ContMov
    RETURN
  END
  
  IF @Accion = 'AFECTAR'
  BEGIN
    SELECT @Moneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa  
    SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda
  
    INSERT INTO Cont(
			  Empresa,  Mov,        FechaEmision,  FechaContable,  Moneda,  TipoCambio,  Usuario,  Referencia, Estatus,      OrigenTipo,  Origen,  OrigenID,  Sucursal)
	  SELECT @Empresa, @GeneraMov, @FechaEmision, @FechaEmision,  @Moneda, @TipoCambio, @Usuario, @Referencia, 'SINAFECTAR', 'CONTP',    @Mov,    @MovID,    @Sucursal
  
    SELECT @ContID = SCOPE_IDENTITY()
  
    INSERT INTO ContD(
			  ID,     Renglon, RenglonSub, Cuenta, Debe, Haber)
	  SELECT @ContID, Renglon, 0,          Cuenta, Debe, Haber
  	    FROM ContParalelaD
	   WHERE ID = @ID
    
    IF @ContID IS NOT NULL
      EXEC spAfectar 'CONT', @ContID, 'AFECTAR', @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    
    IF @Ok IS NULL
      UPDATE ContParalelaPoliza SET CPPolizaID = @ID WHERE IDEmpresa = @IDEmpresa AND ID = @IDAux
  END
  ELSE
  BEGIN
    SELECT @ContID = ID 
      FROM Cont 
     WHERE Empresa = @Empresa 
       AND Mov = @GeneraMov
       AND OrigenTipo = 'CONTP'
       AND Origen = @Mov
       AND OrigenID = @MovID 
       AND Estatus = 'CONCLUIDO'

    IF @ContID IS NOT NULL
      EXEC spAfectar 'CONT', @ContID, 'CANCELAR', @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

    IF @Ok IS NULL
      UPDATE ContParalelaPoliza SET CPPolizaID = NULL WHERE IDEmpresa = @IDEmpresa AND ID = @IDAux      
  END
  RETURN
END
GO

/**************** spContParalelaCierrePeriodo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContParalelaCierrePeriodo') and type = 'P') drop procedure dbo.spContParalelaCierrePeriodo
GO
CREATE PROC spContParalelaCierrePeriodo 
			@ID						int, 

			@Accion					varchar(20),
			@Sucursal				int,
			@Usuario				varchar(10), 
			@Empresa				varchar(5), 
			@Mov					varchar(20), 
			@MovID					varchar(20), 
			@FechaEmision			datetime,
			@Referencia				varchar(50),
			@MovTipo				varchar(20), 
			@BaseDatos				varchar(255), 
			@EmpresaOrigen			varchar(5), 
			@CuentaD				varchar(20), 
			@CuentaA				varchar(20), 
			@Nivel					varchar(20), 
			@CPBaseLocal			bit,
			@CPBaseDatos			varchar(255),
			@CPURL					varchar(255),
			@CPCentralizadora		bit,
			@CPUsuario				varchar(10),
			@CPContrasena			varchar(32),
			@ISReferencia			varchar(100),			
			@IDEmpresa				int,
			@GeneraEjercicio		int, 
			@GeneraPeriodo			int, 
			@GeneraFechaD			datetime, 
			@GeneraFechaA			datetime, 
			@GeneraEmpresaOrigen	int,
			@XML					varchar(max)	OUTPUT,
			@Ok						int				OUTPUT,
			@OkRef					varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @IDEmpresaAux			int,
		  @IDEmpresaAuxAnt		int

  SELECT @IDEmpresaAuxAnt = 0
  WHILE(1=1)
  BEGIN
    SELECT @IDEmpresaAux = MIN(ID)
      FROM ContParalelaEmpresa
     WHERE Empresa = @Empresa
       AND ID = ISNULL(@GeneraEmpresaOrigen, ID)
       AND ID > @IDEmpresaAuxAnt

    IF @IDEmpresaAux IS NULL BREAK
      
    SELECT @IDEmpresaAuxAnt = @IDEmpresaAux
      
    IF @Accion = 'AFECTAR'
    BEGIN
      IF NOT EXISTS(SELECT * FROM ContParalelaPeriodoCierre WHERE IDEmpresa = @IDEmpresaAux AND Ejercicio = @GeneraEjercicio AND Periodo = @GeneraPeriodo)
        INSERT INTO ContParalelaPeriodoCierre(IDEmpresa, Ejercicio, Periodo) SELECT @IDEmpresaAux, @GeneraEjercicio, @GeneraPeriodo
    END
    ELSE IF @Accion = 'CANCELAR'
      DELETE ContParalelaPeriodoCierre WHERE IDEmpresa = @IDEmpresaAux AND Ejercicio = @GeneraEjercicio AND Periodo = @GeneraPeriodo
  END   
  RETURN
END
GO

/**************** spContParalelaPaqueteContabilizar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContParalelaPaqueteContabilizar') and type = 'P') drop procedure dbo.spContParalelaPaqueteContabilizar
GO
CREATE PROCEDURE spContParalelaPaqueteContabilizar
			@ID					int, 
			@Empresa			varchar(5), 
			@Mov				varchar(20), 
			@MovID				varchar(20), 
			@BaseDatos			varchar(255), 
			@EmpresaOrigen		varchar(5), 
			@IDEmpresa			int,
			--REQ25300
			@CONTEsCancelacion	bit, 
			@Usuario			varchar(10),
			@Ok					int			 OUTPUT, 
			@OkRef				varchar(255) OUTPUT
--//WITH ENCRYPTION        
AS
BEGIN
  DECLARE @CONTPEnLinea		bit,
		  @MovGenera		varchar(20),
		  @FechaEmision		datetime,
		  @CONTPID			int

  SELECT @FechaEmision = GETDATE()
  
  EXEC spExtraerFecha @FechaEmision OUTPUT

  SELECT @CONTPEnLinea = ISNULL(CONTPEnLinea, 0) FROM EmpresaCfg2 WHERE Empresa = @Empresa
  
  IF @CONTPEnLinea = 0 RETURN
  
  IF(SELECT COUNT(*) FROM ContParalelaD WHERE ID = @ID) > 1 RETURN

  SELECT @MovGenera = CPTransformacion FROM EmpresaCfgMovContParalela WHERE Empresa = @Empresa
  
  INSERT INTO ContParalela(
		   Empresa,               Mov,        FechaEmision, Proyecto,              UEN,               Usuario, Estatus,      OrigenTipo, Origen,           OrigenID,            BaseDatosOrigen,  EmpresaOrigen, Sucursal,              GeneraEjercicio,              GeneraPeriodo,              GeneraFechaD,                    GeneraFechaA,                    GeneraMov,              GeneraMovID,              GeneraContID,         GeneraEmpresaOrigen,           CONTEsCancelacion)
	SELECT ContParalela.Empresa, @MovGenera, @FechaEmision, ContParalela.Proyecto, ContParalela.UEN, @Usuario, 'SINAFECTAR', 'CONTP',    ContParalela.Mov, ContParalela.MovID, @BaseDatos,       @EmpresaOrigen, ContParalela.Sucursal, ContParalelaPoliza.Ejercicio, ContParalelaPoliza.Periodo, ContParalelaPoliza.FechaEmision, ContParalelaPoliza.FechaEmision, ContParalelaPoliza.Mov, ContParalelaPoliza.MovID, ContParalelaD.ContID, ContParalelaPoliza.IDEmpresa, @CONTEsCancelacion
      FROM ContParalela
      JOIN ContParalelaD ON ContParalela.ID = ContParalelaD.ID
      JOIN ContParalelaPoliza ON ContParalela.IDEmpresa = ContParalelaPoliza.IDEmpresa AND ContParalelaD.ContID = ContParalelaPoliza.ID
     WHERE ContParalela.ID = @ID
       AND ISNULL(ContParalelaPoliza.CONTEsCancelacion, 0) = ISNULL(@CONTEsCancelacion, 0)

  SELECT @CONTPID = SCOPE_IDENTITY()

  IF @Ok IS NULL AND @CONTPID IS NOT NULL
  BEGIN
    EXEC spAfectar 'CONTP', @CONTPID, 'AFECTAR', @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

    IF @Ok IS NULL
      EXEC spAfectar 'CONTP', @CONTPID, 'AFECTAR', @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
  END

--SELECT * FROM ContParalela WHERE ID = @CONTPID   
--SELECT * FROM ContParalelaD WHERE ID = @ID

  RETURN
END
GO

/**************** spContParalelaAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContParalelaAfectar') and type = 'P') drop procedure dbo.spContParalelaAfectar
GO             
CREATE PROCEDURE spContParalelaAfectar
			@ID                		int,

			@Accion					char(20),
			@Empresa	      		char(5),
			@Modulo	      			char(5),
			@Mov	  	      		char(20),
			@MovID             		varchar(20)	OUTPUT,
			@MovTipo     			char(20),
			@FechaEmision      		datetime,
			@FechaAfectacion		datetime,
			@FechaConclusion		datetime,

			@Proyecto	      		varchar(50),
			@Usuario	      		char(10),
			@Autorizacion      		char(10),
			@DocFuente	      		int,
			@Observaciones     		varchar(255),
			@Concepto     			varchar(50),
			@Referencia				varchar(50),

			@Estatus           		char(15),
			@EstatusNuevo			char(15),
			@FechaRegistro     		datetime,
			@Ejercicio	      		int,
			@Periodo	      		int,
			@MovUsuario				char(10),

		    @CuentaD				varchar(20),
		    @CuentaA				varchar(20),
		    @Nivel					varchar(10),
		    @BaseDatos				varchar(255), 
		    @EmpresaOrigen			varchar(5), 
		    @CPBaseLocal			bit, 
		    @CPBaseDatos			varchar(255), 
		    @CPURL					varchar(255), 
		    @CPCentralizadora		bit,   
		    @CPUsuario				varchar(10),
			@CPContrasena			varchar(32),
			@ISReferencia			varchar(100),
			
			@Conexion				bit,
			@SincroFinal			bit,
			@Sucursal				int,
			@SucursalDestino		int,
			@SucursalOrigen			int,

			@CfgContX				bit,
			@CfgContXGenerar		char(20),
			@GenerarPoliza			bit,
			@IDEmpresa				int,
			--REQ25300
			@CONTEsCancelacion		bit,
			
			@GeneraEjercicio		int,
			@GeneraPeriodo			int,
			@GeneraFechaD			datetime,
			@GeneraFechaA			datetime,
			@GeneraEmpresaOrigen	int,
			@OrigenTipo				varchar(5),
			@Origen					varchar(20),
			@OrigenID				varchar(20),
			@IDOrigen				int,
			@GeneraMov				varchar(20),
			@GeneraMovID			varchar(20),
			@GeneraContMov			varchar(20),
			@GeneraContMovID		varchar(20),
			@GeneraContID			int,
    
			@Generar				bit,
			@GenerarMov				char(20),
			@GenerarAfectado		bit,
			@IDGenerar				int	     		OUTPUT,	
			@GenerarMovID	  		varchar(20)		OUTPUT,

			@Ok                		int				OUTPUT,
			@OkRef             		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE @FechaCancelacion		datetime,
		  @GenerarMovTipo		varchar(20),
		  @GenerarEjercicio		int,
		  @GenerarPeriodo		int,
		  @XML					varchar(max),
		  @Resultado			varchar(max)

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

    RETURN
  END

  IF @Conexion = 0 
    BEGIN TRANSACTION

    -- Poner el Estatus del Movimiento en "AFECTANDO"
    EXEC spMovEstatus @Modulo, 'AFECTANDO', @ID, @Generar, @IDGenerar, @GenerarAfectado, @Ok OUTPUT

    IF @Accion <> 'CANCELAR' 
      -- Registrar el Movimiento en "Mov"
      EXEC spRegistrarMovimiento @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @Ejercicio, @Periodo, @FechaRegistro, @FechaEmision,
                       	         NULL, @Proyecto, NULL, NULL,
                       	         @Usuario, @Autorizacion, NULL, @DocFuente, @Observaciones,
			         @Generar, @GenerarMov, @GenerarMovID, @IDGenerar,
				 @Ok OUTPUT

    IF @Accion IN ('AFECTAR', 'CANCELAR')
    BEGIN   
      IF @Ok IS NULL AND @Accion = 'AFECTAR' AND @MovTipo IN('CONTP.ENVIARCUENTAS')
      BEGIN
        EXEC spContParalelaCtaObtener @ID, @CuentaD, @CuentaA, @Nivel, @Ok OUTPUT, @OkRef OUTPUT      
        
        IF @Ok IS NULL
          EXEC spContParalelaXMLGenerar @ID, @Empresa, @Mov, @MovID, @MovTipo, @BaseDatos, @EmpresaOrigen, @CuentaD, @CuentaA, @Nivel, @CPBaseLocal, @CPBaseDatos, @CPURL, @CPCentralizadora, @CPUsuario, @CPContrasena, @ISReferencia, @IDEmpresa, /*REQ25300*/ @CONTEsCancelacion, @XML OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

        IF @Ok IS NULL AND @CPCentralizadora = 0
          EXEC spContParalelaXMLSolicitud @ID, @Empresa, @Mov, @MovID, @MovTipo, @BaseDatos, @EmpresaOrigen, @CuentaD, @CuentaA, @CPBaseLocal, @CPBaseDatos, @CPURL, @CPCentralizadora, @CPUsuario, @CPContrasena, @XML, @ISReferencia, @IDEmpresa, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

        IF @Ok IS NULL AND @CPCentralizadora = 0
          EXEC spContParalelaXMLLeerResultado @ID, @Empresa, @Mov, @MovID, @MovTipo, @BaseDatos, @EmpresaOrigen, @CuentaD, @CuentaA, @CPBaseLocal, @CPBaseDatos, @CPURL, @CPCentralizadora, @CPUsuario, @CPContrasena, @Resultado, @ISReferencia, @IDEmpresa, @Ok OUTPUT, @OkRef OUTPUT
      END
      
      IF @Ok IS NULL AND @CPCentralizadora = 1 AND @Accion = 'AFECTAR' AND @MovTipo = 'CONTP.RECIBIRCUENTA'
      BEGIN
        EXEC spContParalelaCtaRecibir @ID, @Empresa, @Mov, @MovID, @BaseDatos, @EmpresaOrigen, @IDEmpresa, @Ok OUTPUT, @OkRef OUTPUT        

        IF @Ok IS NULL
          EXEC spContParalelaXMLGenerar @ID, @Empresa, @Mov, @MovID, @MovTipo, @BaseDatos, @EmpresaOrigen, @CuentaD, @CuentaA, @Nivel, @CPBaseLocal, @CPBaseDatos, @CPURL, @CPCentralizadora, @CPUsuario, @CPContrasena, @ISReferencia, @IDEmpresa, /*REQ25300*/ @CONTEsCancelacion, @XML OUTPUT, @Ok OUTPUT, @OkRef OUTPUT        
      END

      IF @Ok IS NULL AND @EstatusNuevo IN('CONCLUIDO', 'CANCELADO') AND @MovTipo = 'CONTP.GENERADORPAQ'
      BEGIN
        EXEC spContParalelaPaqueteGenerar @ID, @Accion, @Sucursal, @Usuario, @Empresa, @Mov, @MovID, @MovTipo, @BaseDatos, @EmpresaOrigen, @CuentaD, @CuentaA, @Nivel, @CPBaseLocal, @CPBaseDatos, @CPURL, @CPCentralizadora, @CPUsuario, @CPContrasena, @ISReferencia, @IDEmpresa, @GeneraEjercicio, @GeneraPeriodo, @GeneraFechaD, @GeneraFechaA, @XML OUTPUT, @Ok OUTPUT, @OkRef OUTPUT        
      END

      IF @Ok IS NULL AND @EstatusNuevo IN('CONCLUIDO') AND @MovTipo = 'CONTP.PAQUETE'
      BEGIN
        IF @Ok IS NULL
          EXEC spContParalelaPolizaObtener @ID, @Accion, @Sucursal, @Usuario, @Empresa, @Mov, @MovID, @MovTipo, @BaseDatos, @EmpresaOrigen, @CuentaD, @CuentaA, @Nivel, @CPBaseLocal, @CPBaseDatos, @CPURL, @CPCentralizadora, @CPUsuario, @CPContrasena, @ISReferencia, @IDEmpresa, @GeneraEjercicio, @GeneraPeriodo, @GeneraFechaD, @GeneraFechaA, @GeneraMov, @GeneraMovID, @GeneraContMov, @GeneraContMovID, /*REQ25300*/ @CONTEsCancelacion, @GeneraContID OUTPUT, @XML OUTPUT, @Ok OUTPUT, @OkRef OUTPUT        

        IF @Ok IS NULL
          EXEC spContParalelaXMLGenerar @ID, @Empresa, @Mov, @MovID, @MovTipo, @BaseDatos, @EmpresaOrigen, @CuentaD, @CuentaA, @Nivel, @CPBaseLocal, @CPBaseDatos, @CPURL, @CPCentralizadora, @CPUsuario, @CPContrasena, @ISReferencia, @IDEmpresa, /*REQ25300*/ @CONTEsCancelacion, @XML OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

        IF @Ok IS NULL AND @CPCentralizadora = 0
          EXEC spContParalelaXMLSolicitud @ID, @Empresa, @Mov, @MovID, @MovTipo, @BaseDatos, @EmpresaOrigen, @CuentaD, @CuentaA, @CPBaseLocal, @CPBaseDatos, @CPURL, @CPCentralizadora, @CPUsuario, @CPContrasena, @XML, @ISReferencia, @IDEmpresa, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

        IF @Ok IS NULL AND @CPCentralizadora = 0
          EXEC spContParalelaXMLLeerResultado @ID, @Empresa, @Mov, @MovID, @MovTipo, @BaseDatos, @EmpresaOrigen, @CuentaD, @CuentaA, @CPBaseLocal, @CPBaseDatos, @CPURL, @CPCentralizadora, @CPUsuario, @CPContrasena, @Resultado, @ISReferencia, @IDEmpresa, @Ok OUTPUT, @OkRef OUTPUT
      END

      IF @Ok IS NULL AND @CPCentralizadora = 1 AND @EstatusNuevo IN('CONCLUIDO') AND @MovTipo = 'CONTP.RECIBIRPAQUETE'
      BEGIN
        EXEC spContParalelaPaqueteRecibir @ID, @Empresa, @Mov, @MovID, @BaseDatos, @EmpresaOrigen, @IDEmpresa, /*REQ25300*/ @CONTEsCancelacion, @Ok OUTPUT, @OkRef OUTPUT
        
        IF @Ok IS NULL
          EXEC spContParalelaPaqueteContabilizar @ID, @Empresa, @Mov, @MovID, @BaseDatos, @EmpresaOrigen, @IDEmpresa, /*REQ25300*/ @CONTEsCancelacion, @Usuario, @Ok OUTPUT, @OkRef OUTPUT
        
        IF @Ok IS NULL
          EXEC spContParalelaXMLGenerar @ID, @Empresa, @Mov, @MovID, @MovTipo, @BaseDatos, @EmpresaOrigen, @CuentaD, @CuentaA, @Nivel, @CPBaseLocal, @CPBaseDatos, @CPURL, @CPCentralizadora, @CPUsuario, @CPContrasena, @ISReferencia, @IDEmpresa, /*REQ25300*/ @CONTEsCancelacion, @XML OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      END

      IF @Ok IS NULL AND @CPCentralizadora = 1 AND @EstatusNuevo IN('CONCLUIDO', 'CANCELADO') AND @MovTipo = 'CONTP.TRANSFORMACION'
      BEGIN      
        EXEC spContParalelaPolizaGenerar @ID, @Accion, @Sucursal, @Usuario, @Empresa, @Mov, @MovID, @MovTipo, @BaseDatos, @EmpresaOrigen, @CuentaD, @CuentaA, @Nivel, @CPBaseLocal, @CPBaseDatos, @CPURL, @CPCentralizadora, @CPUsuario, @CPContrasena, @ISReferencia, @IDEmpresa, @GeneraEjercicio, @GeneraPeriodo, @GeneraFechaD, @GeneraFechaA, @GeneraEmpresaOrigen, @GeneraMov, @GeneraMovID, @GeneraContMov, @GeneraContMovID, /*REQ25300*/ @CONTEsCancelacion, @XML OUTPUT, @Ok OUTPUT, @OkRef OUTPUT        
      END

      IF @Ok IS NULL AND @CPCentralizadora = 1 AND @EstatusNuevo IN('CONCLUIDO', 'CANCELADO') AND @MovTipo = 'CONTP.POLIZA'
      BEGIN      
        EXEC spContParalelaPolizaContabilizar @ID, @Accion, @Sucursal, @Usuario, @Empresa, @Mov, @MovID, @FechaEmision, @Referencia, @MovTipo, @BaseDatos, @EmpresaOrigen, @CuentaD, @CuentaA, @Nivel, @CPBaseLocal, @CPBaseDatos, @CPURL, @CPCentralizadora, @CPUsuario, @CPContrasena, @ISReferencia, @IDEmpresa, @GeneraEjercicio, @GeneraPeriodo, @GeneraFechaD, @GeneraFechaA, @GeneraEmpresaOrigen, @XML OUTPUT, @Ok OUTPUT, @OkRef OUTPUT        
      END

      IF @Ok IS NULL AND @CPCentralizadora = 1 AND @EstatusNuevo IN('CONCLUIDO', 'CANCELADO') AND @MovTipo = 'CONTP.CIERRE'
      BEGIN      
        EXEC spContParalelaCierrePeriodo @ID, @Accion, @Sucursal, @Usuario, @Empresa, @Mov, @MovID, @FechaEmision, @Referencia, @MovTipo, @BaseDatos, @EmpresaOrigen, @CuentaD, @CuentaA, @Nivel, @CPBaseLocal, @CPBaseDatos, @CPURL, @CPCentralizadora, @CPUsuario, @CPContrasena, @ISReferencia, @IDEmpresa, @GeneraEjercicio, @GeneraPeriodo, @GeneraFechaD, @GeneraFechaA, @GeneraEmpresaOrigen, @XML OUTPUT, @Ok OUTPUT, @OkRef OUTPUT        
      END      
      
      IF @Ok IS NULL AND @CPCentralizadora = 1 
        UPDATE ContParalelaEmpresa SET TieneMovimientos = 1 WHERE ID = @IDEmpresa
      
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
        
        UPDATE ContParalela
           SET FechaConclusion  = @FechaConclusion, 
               FechaCancelacion = @FechaCancelacion, 
               UltimoCambio     = CASE WHEN UltimoCambio IS NULL THEN @FechaRegistro ELSE UltimoCambio END,
	           Estatus          = @EstatusNuevo,
               Situacion 	    = CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END,
               GenerarPoliza    = @GenerarPoliza
         WHERE ID = @ID 
        IF @@ERROR <> 0 SELECT @Ok = 1
      END
    END

    -- Agregar a Estatus Log
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT

    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
    BEGIN
      EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @OrigenTipo, @IDOrigen, @Origen, @OrigenID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
    END
    -- Cancelar el Flujo
    IF @Accion = 'CANCELAR' AND @EstatusNuevo = 'CANCELADO' AND @Ok IS NULL
      EXEC spCancelarFlujo @Empresa, @Modulo, @ID, @Ok OUTPUT, 1

  IF @Conexion = 0
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      COMMIT TRANSACTION
    ELSE
      BEGIN
        DECLARE @PolizaDescuadrada TABLE (Cuenta varchar(20) NULL, SubCuenta varchar(50) NULL, Concepto varchar(50) NULL, Debe money NULL, Haber money NULL, SucursalContable int NULL)
        IF EXISTS(SELECT * FROM PolizaDescuadrada WHERE Modulo = @Modulo AND ID = @ID)
        INSERT @PolizaDescuadrada (Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable) SELECT Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable FROM PolizaDescuadrada WHERE Modulo = @Modulo AND ID = @ID 
        ROLLBACK TRANSACTION
        DELETE PolizaDescuadrada WHERE Modulo = @Modulo AND ID = @ID
        INSERT PolizaDescuadrada (Modulo, ID, Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable) SELECT @Modulo, @ID, Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable FROM @PolizaDescuadrada
      END
    
  RETURN
END
GO

/**************** spContParalelaMovEnID ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContParalelaMovEnID') and type = 'P') drop procedure dbo.spContParalelaMovEnID
GO             
CREATE PROC spContParalelaMovEnID
			@Modulo		char(5), 
		    @Empresa	char(5), 
			@Mov		char(20),
			@MovID 		varchar(20), 
			@ID			int			OUTPUT,
		    @Moneda		char(10)	OUTPUT,
            @Ok			int 		OUTPUT
--//WITH ENCRYPTION
AS BEGIN 
  SELECT @ID = NULL
  IF @Modulo = 'CONT'  SELECT @ID = ID, @Moneda = Moneda FROM Cont         WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'VTAS'  SELECT @ID = ID, @Moneda = Moneda FROM Venta        WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'PROD'  SELECT @ID = ID, @Moneda = Moneda FROM Prod         WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'COMS'  SELECT @ID = ID, @Moneda = Moneda FROM Compra       WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'INV'   SELECT @ID = ID, @Moneda = Moneda FROM Inv          WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('CANCELADO') ELSE
  IF @Modulo = 'CXC'   SELECT @ID = ID, @Moneda = Moneda FROM Cxc          WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'CXP'   SELECT @ID = ID, @Moneda = Moneda FROM Cxp          WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'AGENT' SELECT @ID = ID, @Moneda = Moneda FROM Agent        WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'GAS'   SELECT @ID = ID, @Moneda = Moneda FROM Gasto        WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'DIN'   SELECT @ID = ID, @Moneda = Moneda FROM Dinero       WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'EMB'   SELECT @ID = ID 		   	 FROM Embarque     WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'NOM'   SELECT @ID = ID, @Moneda = Moneda FROM Nomina       WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'RH'    SELECT @ID = ID, @Moneda = Moneda FROM RH           WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'ASIS'  SELECT @ID = ID, @Moneda = Moneda FROM Asiste       WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('CANCELADO') ELSE
  IF @Modulo = 'AF'    SELECT @ID = ID, @Moneda = Moneda FROM ActivoFijo   WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'PC'    SELECT @ID = ID, @Moneda = Moneda FROM PC           WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'OFER'  SELECT @ID = ID, @Moneda = Moneda FROM Oferta       WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'VALE'  SELECT @ID = ID, @Moneda = Moneda FROM Vale         WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'CR'    SELECT @ID = ID, @Moneda = Moneda FROM CR           WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'ST'    SELECT @ID = ID 			 FROM Soporte      WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'CAP'   SELECT @ID = ID, @Moneda = Moneda FROM Capital      WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'INC'   SELECT @ID = ID, @Moneda = Moneda FROM Incidencia   WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'CONC'  SELECT @ID = ID, @Moneda = Moneda FROM Conciliacion WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'PPTO'  SELECT @ID = ID, @Moneda = Moneda FROM Presup       WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'CREDI' SELECT @ID = ID, @Moneda = Moneda FROM Credito      WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'TMA'   SELECT @ID = ID 			 FROM TMA          WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'RSS'   SELECT @ID = ID 			 FROM RSS          WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'CMP'   SELECT @ID = ID 			 FROM Campana      WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'FIS'   SELECT @ID = ID, @Moneda = Moneda FROM Fiscal   WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  --REQ25014
  IF @Modulo = 'CONTP' SELECT @ID = ID           FROM ContParalela   WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  --REQ16092
  IF @Modulo = 'OPORT' SELECT @ID = ID, @Moneda = Moneda FROM Oportunidad      WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE  
  IF @Modulo = 'CORTE' SELECT @ID = ID           FROM Corte       WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'FRM'   SELECT @ID = ID 			 FROM FormaExtra   WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'CAPT'  SELECT @ID = ID 			 FROM Captura      WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'GES'   SELECT @ID = ID 			 FROM Gestion      WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'CP'    SELECT @ID = ID, @Moneda = Moneda FROM CP           WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'PCP'   SELECT @ID = ID, @Moneda = Moneda FROM PCP          WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE  
  IF @Modulo = 'PROY'  SELECT @ID = ID, @Moneda = Moneda FROM Proyecto     WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
--IF @Modulo = 'ACT'   SELECT @ID = ID 			 FROM Act           WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
--IF @Modulo = 'MEX01' SELECT @ID = ID, @Moneda = Moneda FROM ModuloExtra01 WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
--IF @Modulo = 'MEX02' SELECT @ID = ID, @Moneda = Moneda FROM ModuloExtra02 WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
--IF @Modulo = 'MEX03' SELECT @ID = ID, @Moneda = Moneda FROM ModuloExtra03 WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
--IF @Modulo = 'MEX04' SELECT @ID = ID, @Moneda = Moneda FROM ModuloExtra04 WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
--IF @Modulo = 'MEX05' SELECT @ID = ID, @Moneda = Moneda FROM ModuloExtra05 WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
--IF @Modulo = 'MEX06' SELECT @ID = ID, @Moneda = Moneda FROM ModuloExtra06 WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
--IF @Modulo = 'MEX07' SELECT @ID = ID, @Moneda = Moneda FROM ModuloExtra07 WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
--IF @Modulo = 'MEX08' SELECT @ID = ID, @Moneda = Moneda FROM ModuloExtra08 WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
--IF @Modulo = 'MEX09' SELECT @ID = ID, @Moneda = Moneda FROM ModuloExtra09 WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'ORG'   SELECT @ID = ID, @Moneda = Moneda FROM Organiza     WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'RE'    SELECT @ID = ID, @Moneda = Moneda FROM Recluta      WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'ISL'   SELECT @ID = ID, @Moneda = Moneda FROM ISL          WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'CAM'   SELECT @ID = ID 			         FROM Cambio       WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'PACTO' SELECT @ID = ID, @Moneda = Moneda FROM Contrato     WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') ELSE
  IF @Modulo = 'SAUX'  SELECT @ID = ID                   FROM SAUX         WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'EMAIL') 
  IF @ID IS NULL SELECT @Ok = 60220
END
GO

/**************** spContParalela ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContParalela') and type = 'P') drop procedure dbo.spContParalela
GO
CREATE PROCEDURE spContParalela
				@ID             int,
				@Modulo	      	char(5),
				@Accion			char(20),
				@Base			char(20),
				@FechaRegistro	datetime,
				@GenerarMov		char(20),
				@Usuario		char(10),
				@Conexion		bit,
				@SincroFinal	bit,
				@Mov	      	char(20)	OUTPUT,
				@MovID          varchar(20)	OUTPUT,
				@IDGenerar		int			OUTPUT,

				@Ok				int			OUTPUT,
				@OkRef			varchar(255)OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Generar				bit,
    @GenerarAfectado		bit,
    @Sucursal				int,
    @SucursalDestino		int,
    @SucursalOrigen			int,
    @EnLinea				bit,
    @PuedeEditar			bit,
    @IDEmpresa				int,
    @Empresa	      		char(5),
    @MovTipo   				char(20),
    @FechaEmision     		datetime,
    @FechaAfectacion		datetime,
    @FechaConclusion		datetime,
    @Proyecto	      		varchar(50),
    @MovUsuario	      		char(10),
    @Autorizacion     		char(10),
    @DocFuente	      		int,
    @Concepto    			varchar(50),
    @Referencia 			varchar(50),
    @Observaciones    		varchar(255),
    @Estatus          		char(15),
    @EstatusNuevo			char(15),
    @Ejercicio	      		int,
    @Periodo	      		int,
    @GenerarMovID			varchar(20),
    @GenerarPoliza			bit,
    @CfgContX				bit,
    @CfgContXGenerar		char(20),
    @CuentaD				varchar(20),
    @CuentaA				varchar(20),
    @Nivel					varchar(10),
    @OrigenTipo				varchar(5),
    @Origen					varchar(20),
    @OrigenID				varchar(20),
    @IDOrigen				int,
    @MonedaOrigen			varchar(10),
    
    @BaseDatos				varchar(255), 
    @EmpresaOrigen			varchar(5), 
    
    @CPBaseLocal			bit, 
    @CPBaseDatos			varchar(255), 
    @CPURL					varchar(255), 
    @CPCentralizadora		bit,
    @CPUsuario				varchar(10),
    @CPContrasena			varchar(32),

    @ISReferencia			varchar(100),
    @GeneraEjercicio		int,
    @GeneraPeriodo			int,
    @GeneraFechaD			datetime,
    @GeneraFechaA			datetime,
    @GeneraEmpresaOrigen	int,

    @GeneraMov				varchar(20),
    @GeneraMovID			varchar(20),
    @GeneraContMov			varchar(20),
    @GeneraContMovID		varchar(20),
    @GeneraContID			int,
    
    --REQ25300
    @CONTEsCancelacion		bit
  
  SELECT @CPBaseLocal		= ISNULL(CPBaseLocal, 0),
		 @CPBaseDatos		= NULLIF(RTRIM(CPBaseDatos), ''), 
		 @CPURL				= NULLIF(RTRIM(CPURL), ''), 
		 @CPCentralizadora	= ISNULL(CPCentralizadora, 0),
		 @CPUsuario			= ISNULL(CPUsuario, 0),
		 @CPContrasena		= ISNULL(CPContrasena, 0)
    FROM Version
    
  -- Inicializar Variables
  SELECT @Generar	   = 0,
	 @GenerarAfectado  = 0,
         @CfgContX         = 0,
         @CfgContXGenerar  = 'NO'/*,
	 @Verificar        = 1*/

  IF @Accion = 'CANCELAR' SELECT @EstatusNuevo = 'CANCELADO' ELSE SELECT @EstatusNuevo = 'CONCLUIDO' 

  -- Leer Datos Generales del Movimiento
  SELECT @Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, @Empresa = Empresa, @MovID = MovID, @Mov = Mov, 
		 @FechaEmision = FechaEmision, @Proyecto = NULLIF(RTRIM(Proyecto), ''),@MovUsuario = Usuario, @Autorizacion = Autorizacion,
		 @DocFuente = DocFuente, @Observaciones = Observaciones, @Estatus = UPPER(Estatus), @GenerarPoliza = GenerarPoliza, 
		 @FechaConclusion = FechaConclusion,@Concepto = Concepto, @Referencia = Referencia, @CuentaD = NULLIF(RTRIM(CuentaD), ''), 
		 @CuentaA = NULLIF(RTRIM(CuentaA), ''), @Nivel = ISNULL(NULLIF(RTRIM(Nivel), ''), 'Auxiliar'), @OrigenTipo = OrigenTipo, @Origen = Origen, 
		 @OrigenID = OrigenID, @BaseDatos = BaseDatosOrigen, @EmpresaOrigen = EmpresaOrigen, @IDEmpresa = IDEmpresa, @GeneraEjercicio = NULLIF(GeneraEjercicio, 0), 
		 @GeneraPeriodo = NULLIF(GeneraPeriodo, 0), @GeneraFechaD = GeneraFechaD, @GeneraFechaA = GeneraFechaA, @GeneraEmpresaOrigen = GeneraEmpresaOrigen,
		 @GeneraMov = NULLIF(RTRIM(GeneraMov), ''), @GeneraMovID = NULLIF(RTRIM(GeneraMovID), ''), @GeneraContMov = NULLIF(RTRIM(GeneraContMov), ''), @GeneraContMovID = NULLIF(RTRIM(GeneraContMovID), ''),
		 @GeneraContID = ContID, /*REQ25300*/ @CONTEsCancelacion = ISNULL(CONTEsCancelacion, 0)
    FROM ContParalela
   WHERE ID = @ID
  IF @@ERROR <> 0 SELECT @Ok = 1

  IF @Origen IS NOT NULL AND @OrigenID IS NOT NULL
    EXEC spContParalelaMovEnID @OrigenTipo, @Empresa, @Origen, @OrigenID, @IDOrigen OUTPUT, @MonedaOrigen OUTPUT, @Ok OUTPUT
  ELSE
    SELECT @IDOrigen = NULL

  IF NULLIF(RTRIM(@Usuario), '') IS NULL SELECT @Usuario = @MovUsuario
  -- Leer MovTipo, Periodo y Ejercicio	
  -- IF @Accion IN ('AFECTAR', 'GENERAR') SELECT @FechaAfectacion = @FechaEmision ELSE SELECT @FechaAfectacion = @FechaRegistro
  EXEC spFechaAfectacion @Empresa, @Modulo, @ID, @Accion, @FechaEmision OUTPUT, @FechaRegistro, @FechaAfectacion OUTPUT
  EXEC spExtraerFecha @FechaAfectacion OUTPUT
  EXEC spMovTipo @Modulo, @Mov, @FechaAfectacion, @Empresa, NULL, NULL, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT
  EXEC spMovOk @SincroFinal, @ID, @Estatus, @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @FechaAfectacion, @FechaRegistro, @Ejercicio, @Periodo, @Proyecto, @Ok OUTPUT, @OkRef OUTPUT

  SELECT @ISReferencia = CASE @MovTipo
                           WHEN 'CONTP.ENVIARCUENTAS' THEN 'ContParalela.CentralizarCuentas'
                           WHEN 'CONTP.PAQUETE'       THEN 'ContParalela.PaqueteContable'
                           ELSE ''
                         END

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

  IF (@Accion <> 'CANCELAR' AND @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR', 'PENDIENTE')) OR 
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
  
    IF @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') AND @Accion <> 'CANCELAR'
    BEGIN
      IF @MovTipo IN('CONTP.GENERADORPAQ', 'CONTP.PAQUETE', 'CONTP.TRANSFORMACION') AND @Estatus = 'SINAFECTAR'
        SELECT @EstatusNuevo = 'PENDIENTE'
      ELSE 
        SELECT @EstatusNuevo = 'CONCLUIDO'
    END   

    -- Verificar antes de Afectar
    IF /*(@Conexion = 0 OR @Accion = 'CANCELAR') AND */@Accion NOT IN ('GENERAR', 'CONSECUTIVO'/*, 'SINCRO'*/) AND @Ok IS NULL
    BEGIN
      EXEC spContParalelaVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @FechaEmision, @Estatus, @EstatusNuevo, 
                             @CuentaD, @CuentaA, @BaseDatos, @EmpresaOrigen, @CPBaseLocal, @CPBaseDatos, @CPURL, @CPCentralizadora, @CPUsuario, @CPContrasena ,@ISReferencia,
                             @OrigenTipo, @Origen, @OrigenID, @IDEmpresa, @GeneraEjercicio, @GeneraPeriodo, @GeneraFechaD, @GeneraFechaA, @GeneraEmpresaOrigen,
                             @GeneraMov, @GeneraMovID, @GeneraContMov, @GeneraContMovID, @GeneraContID, 
          					 @Conexion, @SincroFinal, @Sucursal, @Ok OUTPUT, @OkRef OUTPUT

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
      EXEC spContParalelaAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @FechaEmision, @FechaAfectacion, @FechaConclusion,
			               @Proyecto, @Usuario, @Autorizacion, @DocFuente, @Observaciones, @Concepto, @Referencia, 
                           @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario,
                           @CuentaD, @CuentaA, @Nivel, @BaseDatos, @EmpresaOrigen, @CPBaseLocal, @CPBaseDatos, @CPURL, @CPCentralizadora, @CPUsuario, @CPContrasena, @ISReferencia,
		                   @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @CfgContX, @CfgContXGenerar, @GenerarPoliza, @IDEmpresa, /*REQ25300*/ @CONTEsCancelacion,
                           @GeneraEjercicio, @GeneraPeriodo, @GeneraFechaD, @GeneraFechaA, @GeneraEmpresaOrigen,
	                       @OrigenTipo, @Origen, @OrigenID, @IDOrigen, @GeneraMov, @GeneraMovID, @GeneraContMov, @GeneraContMovID, @GeneraContID, 
                           @Generar, @GenerarMov, @GenerarAfectado, @IDGenerar OUTPUT, @GenerarMovID OUTPUT,
                           @Ok OUTPUT, @OkRef OUTPUT

  END ELSE 
  BEGIN
    IF @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') AND @Accion = 'CANCELAR' EXEC spMovCancelarSinAfectar @Modulo, @ID, @Ok OUTPUT ELSE
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

--REQ25300
/************** spContParalelaEnviarEnLinea *************/
if exists (select * from sysobjects where id = object_id('dbo.spContParalelaEnviarEnLinea') and type = 'P') drop procedure dbo.spContParalelaEnviarEnLinea
GO
CREATE PROCEDURE spContParalelaEnviarEnLinea
           @Empresa			char(5),
		   @Sucursal		int,
		   @ID				int, 			
		   @Accion			varchar(20),
		   @Usuario			char(10),
		   @FechaRegistro	datetime,
		   @Mov				char(20),
		   @MovID			varchar(20),
		   @Estacion		int,
		   @Ok				int				OUTPUT,
		   @OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @CONTPEnLinea			bit,
		  @MovGenera			varchar(20),
		  @BaseDatosOrigen		varchar(255),
		  @CONTPID				int,
		  @CONTEsCancelacion	bit,
		  @CPCentralizadora		bit,
		  @FechaEmision			datetime
    
  SELECT @FechaEmision = GETDATE()
  
  EXEC spExtraerFecha @FechaEmision OUTPUT
  
  SELECT @CONTEsCancelacion = CASE @Accion WHEN 'CANCELAR' THEN 1 ELSE 0 END

  SELECT @CPCentralizadora = ISNULL(CPCentralizadora, 0) FROM Version

  SELECT @BaseDatosOrigen = DB_NAME()

  SELECT @MovGenera = CPPaquete FROM EmpresaCfgMovContParalela WHERE Empresa = @Empresa
  
  SELECT @CONTPEnLinea = ISNULL(CONTPEnLinea, 0) FROM EmpresaCfg2 WHERE Empresa = @Empresa
  
  IF @CONTPEnLinea = 0 OR (@CPCentralizadora = 1) RETURN
 
  INSERT INTO ContParalela(
		   Empresa,  Mov,        FechaEmision, Proyecto, UEN,  Usuario, Estatus,      OrigenTipo, Origen, OrigenID,  BaseDatosOrigen, EmpresaOrigen, Sucursal, GeneraEjercicio, GeneraPeriodo, GeneraFechaD, GeneraFechaA, GeneraContMov, GeneraContMovID, GeneraContID,  CONTEsCancelacion)
	SELECT Empresa, @MovGenera, @FechaEmision, Proyecto, UEN, @Usuario, 'SINAFECTAR', 'CONT',     Mov,    MovID,    @BaseDatosOrigen, Empresa,       Sucursal, Ejercicio,       Periodo,       FechaEmision, FechaEmision, Mov,           MovID,           ID,           @CONTEsCancelacion
      FROM Cont 
     WHERE ID = @ID

  SELECT @CONTPID = SCOPE_IDENTITY()
  
  IF @CONTPID IS NOT NULL
  BEGIN
    EXEC spAfectar 'CONTP', @CONTPID, 'AFECTAR', @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 0, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

    IF @Ok IS NULL
      EXEC spAfectar 'CONTP', @CONTPID, 'AFECTAR', @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 0, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
  END

  IF @Ok IS NOT NULL
  BEGIN
    IF ISNULL(@OkRef, '') = ''
      SELECT @OkRef = 'Contabilidad Paralela'
    ELSE
      SELECT @OkRef = 'Contabilidad Paralela - ' + @OkRef 
  END
  RETURN
END
GO

PRINT "******************* SP Contabilidad Paralela ******************"