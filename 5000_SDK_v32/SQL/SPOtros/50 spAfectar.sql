/* SP AFECTAR    */
SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF 

/**************** spValidarFueraLinea ****************/
if exists (select * from sysobjects where id = object_id('dbo.spValidarFueraLinea') and type = 'P') drop procedure dbo.spValidarFueraLinea
GO
CREATE PROCEDURE spValidarFueraLinea
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
  IF @Modulo NOT IN ('VTAS', 'COMS', 'INV')
    SELECT @Ok = 11
    
  RETURN
END
GO

/**************** spAfectarFueraLinea ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAfectarFueraLinea') and type = 'P') drop procedure dbo.spAfectarFueraLinea
GO
CREATE PROCEDURE spAfectarFueraLinea
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
  DECLARE
    @Sucursal	int,
    @Estatus	varchar(15),
    @FueraLinea	bit

  SELECT @FueraLinea = ISNULL(FueraLinea, 0) FROM Version    
  IF @MovID IS NULL AND @Ok IS NULL
  BEGIN
    EXEC spMovInfo @ID, @Modulo, @Sucursal = @Sucursal OUTPUT, @Estatus = @Estatus OUTPUT
    IF @Accion = 'CANCELAR' AND @Estatus <> 'FUERALINEA' SELECT @Ok = 13

    IF @Ok IS NULL
      EXEC spConsecutivo 'Fuera Linea', @Sucursal, @MovID OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    IF @Ok IS NULL
    BEGIN
      IF @Accion = 'AFECTAR' 
        SELECT @Estatus = 'FUERALINEA' 
      ELSE 
        SELECT @Estatus = 'CANCELADO'
      EXEC spAsignarSucursalEstatusEncabezado @ID, @Modulo, @Sucursal, @Estatus, @MovID      
    END
  END
  IF @FueraLinea = 0 AND @Ok IS NULL
    SELECT @Ok = 12
  RETURN
END
GO

/**************** spFechaRegistroCFD ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFechaRegistroCFD') and type = 'P') drop procedure dbo.spFechaRegistroCFD
GO
CREATE PROCEDURE spFechaRegistroCFD
                   @Modulo			varchar(5),
                   @Id				int,
                   @Accion			varchar(20),
                   @FechaRegistro	datetime OUTPUT
--//WITH ENCRYPTION
AS BEGIN
DECLARE
  @Sql					nvarchar(max),
  @Parametros			nvarchar(max),
  @Tabla				varchar(20),
  @Empresa				varchar(5),
  @FechaMov				datetime,
  @FechaHoy				datetime,
  @MesMov				int,
  @MesActual			int,
  @CancelarFactura		varchar(20),
  @CancelarFacturaFecha varchar(20)


  SET @Tabla = dbo.fnMovTabla(@Modulo)

  SET @Parametros = '@Empresa varchar(20) OUTPUT'
  SET @SQL = 'SELECT @Empresa = Empresa FROM ' + @Tabla + ' WHERE ID = ' + CONVERT(varchar, @id)
  EXEC sp_executesql @Sql, @Parametros, @Empresa = @Empresa OUTPUT
    
  SELECT @CancelarFactura = CancelarFactura, @CancelarFacturaFecha = CancelarFacturaFecha FROM EmpresaCfg WHERE Empresa = @Empresa
  SELECT @FechaMov = @FechaRegistro, @FechaHoy = GETDATE()
    
  --EXEC spExtraerFecha @FechaMov OUTPUT
  --EXEC spExtraerFecha @FechaHoy OUTPUT
    
  SELECT @MesMov = MONTH(@FechaMov)
  SELECT @MesActual = MONTH(@FechaHoy)

  IF @Accion = 'CANCELAR'
  BEGIN
    SELECT @FechaRegistro = @FechaHoy 
    IF @Modulo = 'VTAS' AND @CancelarFactura <> 'No' 
    BEGIN
      IF @CancelarFactura = 'Cambio Mes'
      BEGIN
        IF @MesMov <> @MesActual 
          SELECT @FechaRegistro = @FechaHoy          	
      END ELSE
      IF @CancelarFactura = 'Cambio Dia'
      BEGIN
        IF @FechaMov <> @FechaHoy
          SELECT @FechaRegistro = @FechaHoy 
      END
    END
  END

END
GO


/**************** spAfectarValidarLic ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAfectarValidarLic') and type = 'P') drop procedure dbo.spAfectarValidarLic
GO
CREATE PROCEDURE spAfectarValidarLic
                   @Modulo		char(5),
                   @ID                  int,
                   @Accion		char(20),
                   @Base		char(20),
                   @GenerarMov		char(20),
                   @Usuario		char(10),
                   @SincroFinal		bit,
                   @EnSilencio	        bit,
                   @Ok               	int 		OUTPUT,
                   @OkRef            	varchar(255) 	OUTPUT,
                   @FechaRegistro	datetime
--//WITH ENCRYPTION
AS BEGIN
DECLARE 
  @DocumentoXML		xml,
  @iDatos			int,
  @Documento		varchar(max),
  @LimitarMovTipo	bit,
  @MaxIDLic			int,
  @IDLic			int,
  @ClavePermitida	varchar(20),
  @ModuloClavePermitida varchar(20),
  @MovTipo			varchar(20),
  @MovTipoGenerar	varchar(20),
  @Licenciamiento   varchar(50)

SELECT @Licenciamiento = Licenciamiento FROM Usuario WHERE Usuario = @Usuario

  SELECT @Documento = LicenciamientoXML FROM  master.dbo.IntelisisMKLic WHERE Licenciamiento = @Licenciamiento

  IF CHARINDEX('<LimitarMovTipo>S</LimitarMovTipo>',@Documento,1) > 0
    SELECT @LimitarMovTipo = 1

  IF @LimitarMovTipo != 1
    RETURN

  IF @LimitarMovTipo = 1
  BEGIN
    CREATE TABLE #LicClavePermitida (ID int identity(1,1), Clave varchar(20) COLLATE DATABASE_DEFAULT NULL)
    CREATE TABLE #ClavePermitida (Clave varchar(20) COLLATE DATABASE_DEFAULT NULL)

    EXEC spMovInfo @ID, @Modulo, @MovTipo = @MovTipo OUTPUT
    EXEC spMovInfo NULL, @Modulo, @Mov = @GenerarMov, @MovTipo = @MovTipoGenerar OUTPUT

    SELECT @DocumentoXML = CONVERT(XML,REPLACE(REPLACE(@Documento,'encoding="UTF-8"','encoding="Windows-1252"'),'?<?xml','<?xml'))

    EXEC sp_xml_preparedocument @iDatos OUTPUT, @DocumentoXML
      INSERT INTO #LicClavePermitida (Clave)
      SELECT  Clave FROM OPENXML (@iDatos, 'Intelisis/MovTipo/MovTipoDet',1) WITH (Clave  varchar(20))
    EXEC sp_xml_removedocument @iDatos  

    SELECT @MaxIDLic = MAX(ID) FROM #LicClavePermitida
    SELECT @IDLic = 1, @ClavePermitida = NULL
    WHILE @IDLic <= @MaxIDLic
    BEGIN
      SELECT @IDLic = ID, @ClavePermitida = Clave FROM #LicClavePermitida WHERE ID = @IDlic

      IF CHARINDEX('*',@ClavePErmitida) > 1
      BEGIN
        SELECT @ModuloClavePermitida = REPLACE(@ClavePermitida,'.*','')
        INSERT INTO #ClavePermitida (Clave) SELECT Clave FROM MovTipo WHERE Modulo = @ModuloClavePermitida
      END
      ELSE 
        INSERT INTO #ClavePermitida (Clave) SELECT @ClavePermitida

      SELECT @IDLic = @IDLic+1, @ClavePermitida = NULL
    END

    IF @MovTipo IS NOT NULL AND @MovTipo NOT IN (SELECT Clave FROM #ClavePermitida)
    SELECT @Ok = 10065, @OkREf = 'Su licenciamiento no tiene acceso a este movimiento. '+@MovTipo

    IF @Ok IS NULL AND @MovTipoGenerar IS NOT NULL AND @MovTipoGenerar NOT IN (SELECT Clave FROM #ClavePermitida)
    SELECT @Ok = 10065, @OkREf = 'Su licenciamiento no tiene acceso a este movimiento. '+@MovTipoGenerar
  END

  RETURN
END
GO


/**************** spAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAfectar') and type = 'P') drop procedure dbo.spAfectar
GO
CREATE PROCEDURE spAfectar
		   @Modulo			char(5),
           @ID              int,
           @Accion			char(20) 	= NULL,  -- "Afectar", "Generar", "Verificar", "Cancelar", "Reservar", "DesReservar", "Asignar", "DesAsignar", "DesAfectar", "Consecutivo", "Autorizar", "Refacturar"
		   @Base			char(20) 	= NULL,  -- "Todo", "Pendiente", "Seleccion", "Reservado", "Ordenado"
           @GenerarMov		char(20) 	= NULL,  -- Movimiento a Generar
		   @Usuario			char(10) 	= NULL,  -- Usuario que Afecta el Movimiento
		   @SincroFinal		bit	 		= 0,	  
           @EnSilencio	    bit      	= 0,
 		   @Ok              int	 		= NULL OUTPUT,
   		   @OkRef           varchar(255)	= NULL OUTPUT,
		   @FechaRegistro	datetime	= NULL,
		   @Conexion		bit			= 0,
		   @Estacion		int			= NULL,
		   @FueraLinea		bit			= 0
--//WITH ENCRYPTION
AS BEGIN
  SET nocount ON
  DECLARE
    @Mov		char(20),	-- Movimiento que se genera
    @MovID		varchar(20),	-- Consecutivo que se genera
    @IDGenerar		int,		-- ID del movimiento "GenerarMov"
    @ContID		int,		-- ID de la Poliza Generada
    @OkDesc           	varchar(255),	-- Descripcion del mensaje
    @OkTipo           	varchar(50),    -- Tipo de mensaje Error, Informacion, Precaucion, Advertencia, Confirmacion, Configuracion Erronea, etc.
    @VolverAfectar	int,		-- Esto se usa por ejemplo en Facturas pendientes cuando estan totalmente reservadas, para que las concluya o para volver a afectar un pedido para asignar el pendiente
    @Empresa		char(5),
    @Sucursal		int,
    @OID		int,
    @OMov		char(20),
    @OMovID		varchar(20),
    @Notificacion			bit, --MEJORA5066
    
    -- 7052
    @SPID				int,
    --REQ25300
    @ContabilidadParalela	bit,
    @CONTP					bit,
    @CPCentralizadora		bit

  --REQ25300
  SELECT @ContabilidadParalela = ISNULL(ContabilidadParalela, 0) FROM Version    

  SELECT @SPID = @@SPID

  EXEC spAfectacionUsuario @SPID, @Usuario

  -- Inicializar Variables
  SELECT @Modulo	= NULLIF(RTRIM(UPPER(@Modulo)), ''),
         @Accion	= NULLIF(RTRIM(UPPER(@Accion)), ''),
	 @Base		= NULLIF(RTRIM(UPPER(@Base)), ''),
         @GenerarMov	= NULLIF(RTRIM(@GenerarMov), ''),

	 @Mov		= NULL,
	 @MovID		= NULL,
	 @IDGenerar	= NULL,

	 @Ok     	= NULL,
  	 @OkRef  	= NULL,
  	 @OkDesc 	= NULL,
  	 @OkTipo 	= NULL,
         @VolverAfectar = 0
  
  SELECT @Empresa = Empresa, @Sucursal = Sucursal FROM Inv WHERE ID = @ID
  
  -- Analizar Parametro Accion
  IF @Accion IS NULL SELECT @Accion = 'AFECTAR' 
  IF @Accion NOT IN ('AFECTAR', 'GENERAR', 'VERIFICAR', 'CANCELAR', 'RESERVAR', 'RESERVARPARCIAL', 'DESRESERVAR', 'ASIGNAR', 'DESASIGNAR', 'DESAFECTAR', 'CONSECUTIVO', 'AUTORIZAR', 'REFACTURAR')
    SELECT @Ok = 60030, @OkRef = 'Acciones Validas (Afectar, Generar, Verificar, Cancelar, Reservar, DesReservar, Asignar, DesAsignar, DesAfectar, Consecutivo, Autorizar, Refacturar)' 

  -- Analizar Parametro Base
  IF @Base IS NULL SELECT @Base = 'TODO' 
  IF @Base NOT IN ('TODO', 'PENDIENTE', 'SELECCION', 'RESERVADO', 'ORDENADO', 'CONCLUIDO', 'DISPONIBLE'/*, 'ENPROCESO', 'SIGUIENTEPASO'*/)
    SELECT @Ok = 60030, @OkRef = 'Base (Todo, Pendiente, Seleccion, Reservado, Ordenado, Concluido, Disponible)'
  
  -- Analizar Parametro GenerarMov
  IF @Accion NOT IN ('AFECTAR','VERIFICAR','GENERAR','AUTORIZAR') OR @GenerarMov = '0' SELECT @GenerarMov = NULL

  -- Leer Fecha del Servidor 
  IF @FechaRegistro IS NULL --OR @Accion <> 'GENERAR'
  BEGIN
    SELECT @FechaRegistro = Fecha FROM CFD WHERE Modulo = @Modulo AND ModuloID = @ID
    IF @FechaRegistro IS NOT NULL
       EXEC spFechaRegistroCFD @Modulo, @ID, @Accion, @FechaRegistro OUTPUT
    ELSE
      SELECT @FechaRegistro = GETDATE()  
  END

  IF @Accion = 'GENERAR' 
    IF NOT EXISTS(SELECT * FROM MovTipo WHERE Modulo = @Modulo AND Mov = @GenerarMov)
      SELECT @Ok = 70130, @OkRef = @GenerarMov

  --IF @Ok IS NULL
  --  EXEC spAfectarValidarLic @Modulo, @ID, @Accion, @Base, @GenerarMov, @Usuario, @SincroFinal, @EnSilencio, @Ok OUTPUT, @OkRef OUTPUT, @FechaRegistro

  IF @Ok IS NULL
    EXEC xpAntesAfectar @Modulo, @ID, @Accion, @Base, @GenerarMov, @Usuario, @SincroFinal, @EnSilencio, @Ok OUTPUT, @OkRef OUTPUT, @FechaRegistro

 IF @Ok IS NULL AND (SELECT IntelMESInterfase FROM EmpresaCfg WHERE Empresa = @Empresa) = 1
	EXEC xpMESAntesAfectar @Modulo, @ID, @Accion, @Base, @GenerarMov, @Usuario, @SincroFinal, @EnSilencio, @Ok OUTPUT, @OkRef OUTPUT, @FechaRegistro

  IF @Ok IS NULL
    EXEC xpInterfacesAntesAfectar @Modulo, @ID, @Accion, @Base, @GenerarMov, @Usuario, @SincroFinal, @EnSilencio, @Ok OUTPUT, @OkRef OUTPUT, @FechaRegistro

  IF @Ok IS NULL AND @Accion IN ('AFECTAR', 'VERIFICAR')
    EXEC xpMovValidar @Modulo, @ID, @Accion, @Base, @GenerarMov, @Usuario, @SincroFinal, @EnSilencio, @Ok OUTPUT, @OkRef OUTPUT, @FechaRegistro

  IF @Accion IN ('AFECTAR', 'CANCELAR') AND @Ok IS NULL AND @FueraLinea = 1
  BEGIN
    EXEC spValidarFueraLinea @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                             @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                             @Ok OUTPUT, @OkRef OUTPUT
    IF @Ok IS NULL
      EXEC spAfectarFueraLinea @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                               @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                               @Ok OUTPUT, @OkRef OUTPUT
  END ELSE
  IF @Accion = 'REFACTURAR' AND @Ok IS NULL
  BEGIN
    EXEC spInvRefacturar @ID, @Usuario, @FechaRegistro, @Ok OUTPUT, @OkRef OUTPUT, @IDGenerar OUTPUT
    IF @Ok IS NULL SELECT @Ok = 80030
  END ELSE
  IF @Modulo = 'CONT' AND @Ok IS NULL
    EXEC spCont @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                @Ok OUTPUT, @OkRef OUTPUT
  ELSE
  IF @Modulo IN ('VTAS', 'PROD', 'COMS', 'INV') AND @Ok IS NULL
  BEGIN
    EXEC spInv @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, NULL,
               @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, @ContID OUTPUT,
			   @Ok OUTPUT, @OkRef OUTPUT, @VolverAfectar OUTPUT, @Estacion = @Estacion -- REQ12336
    IF @VolverAfectar = 1 
      EXEC spInv @ID, @Modulo, 'AFECTAR', 'TODO', @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, NULL,
                 @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, @ContID OUTPUT,
                 @Ok OUTPUT, @OkRef OUTPUT, @VolverAfectar OUTPUT, @Estacion = @Estacion -- REQ12336
    ELSE IF @VolverAfectar = 2 
      EXEC spInv @ID, @Modulo, 'ASIGNAR', 'PENDIENTE', @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, NULL,
                 @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, @ContID OUTPUT,
                 @Ok OUTPUT, @OkRef OUTPUT, @VolverAfectar OUTPUT, @Estacion = @Estacion -- REQ12336
    ELSE IF @VolverAfectar = 3 AND @Modulo = 'INV'
    BEGIN
      
      SELECT @OID = @ID, @OMov = @Mov, @OMovID = @MovID, @Ok = NULL, @OkRef = NULL
      EXEC spInv @IDGenerar, @Modulo, @Accion, 'TODO', @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 'TRANSITO',
                 @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, @ContID OUTPUT,
                 @Ok OUTPUT, @OkRef OUTPUT, @VolverAfectar OUTPUT, @Estacion = @Estacion -- REQ12336

      EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @OID, @OMov, @OMovID, @Modulo, @IDGenerar, @Mov, @MovID, @Ok OUTPUT 
    END ELSE
    IF @VolverAfectar = 4 AND @Modulo = 'VTAS'
      EXEC spCancelarFacturaReservarPedido @ID, @Usuario, @FechaRegistro, @Ok OUTPUT, @OkRef OUTPUT    
    ELSE IF @VolverAfectar = 5
      EXEC spInv @ID, @Modulo, 'RESERVAR', 'PENDIENTE', @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, NULL,
                 @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, @ContID OUTPUT,
                 @Ok OUTPUT, @OkRef OUTPUT, @VolverAfectar OUTPUT, @Estacion = @Estacion -- REQ12336

  END ELSE
  IF @Modulo IN ('CXC', 'CXP', 'AGENT') AND @Ok IS NULL
    EXEC spCx @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
              @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
              @Ok OUTPUT, @OkRef OUTPUT, @EstacionTrabajo = @Estacion -- REQ12336
  ELSE
  IF @Modulo = 'DIN' AND @Ok IS NULL
    EXEC spDinero @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                  @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                  @Ok OUTPUT, @OkRef OUTPUT, @EstacionTrabajo = @Estacion -- REQ12336
  ELSE 
  IF @Modulo = 'GAS' AND @Ok IS NULL
    EXEC spGasto @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                 @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                 @Ok OUTPUT, @OkRef OUTPUT
  ELSE 
  IF @Modulo = 'EMB' AND @Ok IS NULL
    EXEC spEmbarque @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                    @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                    @Ok OUTPUT, @OkRef OUTPUT
  ELSE 
  IF @Modulo = 'NOM' AND @Ok IS NULL
    EXEC spNomina @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                  @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                  @Ok OUTPUT, @OkRef OUTPUT
  ELSE  
  IF @Modulo = 'RH' AND @Ok IS NULL
    EXEC spRH @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
              @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
              @Ok OUTPUT, @OkRef OUTPUT
  ELSE  
  IF @Modulo = 'ASIS' AND @Ok IS NULL
    EXEC spAsiste @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                  @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                  @Ok OUTPUT, @OkRef OUTPUT
  ELSE
  IF @Modulo = 'AF' AND @Ok IS NULL
    EXEC spActivoFijo @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                      @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                      @Ok OUTPUT, @OkRef OUTPUT
  ELSE
  IF @Modulo = 'ST' AND @Ok IS NULL
    EXEC spSoporte @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                   @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                   @Ok OUTPUT, @OkRef OUTPUT
  ELSE  
  IF @Modulo = 'PC' AND @Ok IS NULL
    EXEC spPC @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
              @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
              @Ok OUTPUT, @OkRef OUTPUT
  ELSE  
  IF @Modulo = 'OFER' AND @Ok IS NULL
    EXEC spOferta @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                  @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                  @Ok OUTPUT, @OkRef OUTPUT
  ELSE  
  IF @Modulo = 'VALE' AND @Ok IS NULL
    EXEC spVale @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                @Ok OUTPUT, @OkRef OUTPUT
  ELSE 
  IF @Modulo = 'CR' AND @Ok IS NULL
    EXEC spCR @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
              @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
              @Ok OUTPUT, @OkRef OUTPUT
  ELSE 
  IF @Modulo = 'CAM' AND @Ok IS NULL
    EXEC spCambio @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                  @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                  @Ok OUTPUT, @OkRef OUTPUT
  ELSE 
  IF @Modulo = 'CAP' AND @Ok IS NULL
    EXEC spCapital @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                   @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                   @Ok OUTPUT, @OkRef OUTPUT
  ELSE
  IF @Modulo = 'INC' AND @Ok IS NULL
    EXEC spIncidencia @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                      @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                      @Ok OUTPUT, @OkRef OUTPUT
  ELSE
  IF @Modulo = 'CONC' AND @Ok IS NULL
    EXEC spConciliacion @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                        @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                        @Ok OUTPUT, @OkRef OUTPUT
  ELSE
  IF @Modulo = 'PPTO' AND @Ok IS NULL
    EXEC spPresup @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                  @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                  @Ok OUTPUT, @OkRef OUTPUT
  ELSE
  IF @Modulo = 'CREDI' AND @Ok IS NULL
    EXEC spCredito @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                   @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                   @Ok OUTPUT, @OkRef OUTPUT
  ELSE 
  IF @Modulo = 'TMA' AND @Ok IS NULL -- TASK2429
    EXEC spTMA @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
               @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
               @Ok OUTPUT, @OkRef OUTPUT
  ELSE
  IF @Modulo = 'RSS' AND @Ok IS NULL
    EXEC spRSS @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
               @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
               @Ok OUTPUT, @OkRef OUTPUT
  ELSE
  IF @Modulo = 'CMP' AND @Ok IS NULL
    EXEC spCampana @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                  @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                  @Ok OUTPUT, @OkRef OUTPUT
  ELSE
  IF @Modulo = 'FIS' AND @Ok IS NULL
    EXEC spFiscal @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                  @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                  @Ok OUTPUT, @OkRef OUTPUT
  ELSE
  --REQ16092
  IF @Modulo = 'OPORT' AND @Ok IS NULL	
    EXEC spOportunidad @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
			   @Ok OUTPUT, @OkRef OUTPUT
  ELSE
  IF @Modulo = 'CORTE' AND @Ok IS NULL
    EXEC spCorte @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, @Estacion, 
                  @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT 
  ELSE
  IF @Modulo = 'FRM' AND @Ok IS NULL
    EXEC spFormaExtra @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                      @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                      @Ok OUTPUT, @OkRef OUTPUT
  ELSE
  IF @Modulo = 'CAPT' AND @Ok IS NULL
    EXEC spCaptura @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                   @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                   @Ok OUTPUT, @OkRef OUTPUT
  ELSE
  IF @Modulo = 'GES' AND @Ok IS NULL
    EXEC spGestion @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                   @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                   @Ok OUTPUT, @OkRef OUTPUT
  ELSE
  IF @Modulo = 'CP' AND @Ok IS NULL
    EXEC spCP @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
              @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
              @Ok OUTPUT, @OkRef OUTPUT              
  ELSE
  IF @Modulo = 'PCP' AND @Ok IS NULL
    EXEC spPCP @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                         @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                         @Ok OUTPUT, @OkRef OUTPUT
  ELSE  
  IF @Modulo = 'PROY' AND @Ok IS NULL
    EXEC spProyecto @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                    @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                    @Ok OUTPUT, @OkRef OUTPUT, @Estacion = @Estacion
  /*ELSE
  IF @Modulo = 'ACT' AND @Ok IS NULL
    EXEC spAct @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
               @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
               @Ok OUTPUT, @OkRef OUTPUT*/
  /*ELSE
  IF @Modulo = 'MEX01' AND @Ok IS NULL
    EXEC spModuloExtra01 @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                         @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                         @Ok OUTPUT, @OkRef OUTPUT*/
  /*ELSE
  IF @Modulo = 'MEX02' AND @Ok IS NULL
    EXEC spModuloExtra02 @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                         @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                         @Ok OUTPUT, @OkRef OUTPUT*/
  /*ELSE
  IF @Modulo = 'MEX03' AND @Ok IS NULL
    EXEC spModuloExtra03 @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                         @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                         @Ok OUTPUT, @OkRef OUTPUT*/
  /*ELSE
  IF @Modulo = 'MEX04' AND @Ok IS NULL
    EXEC spModuloExtra04 @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                         @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                         @Ok OUTPUT, @OkRef OUTPUT*/
  /*ELSE
  IF @Modulo = 'MEX05' AND @Ok IS NULL
    EXEC spModuloExtra05 @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                         @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                         @Ok OUTPUT, @OkRef OUTPUT*/
  /*ELSE
  IF @Modulo = 'MEX06' AND @Ok IS NULL
    EXEC spModuloExtra06 @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                         @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                         @Ok OUTPUT, @OkRef OUTPUT*/
  /*ELSE
  IF @Modulo = 'MEX07' AND @Ok IS NULL
    EXEC spModuloExtra07 @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                         @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                         @Ok OUTPUT, @OkRef OUTPUT*/
  /*ELSE
  IF @Modulo = 'MEX08' AND @Ok IS NULL
    EXEC spModuloExtra08 @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                         @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                         @Ok OUTPUT, @OkRef OUTPUT*/
  /*ELSE
  IF @Modulo = 'MEX09' AND @Ok IS NULL
    EXEC spModuloExtra09 @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                         @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                         @Ok OUTPUT, @OkRef OUTPUT*/
  ELSE
  IF @Modulo = 'PREV' AND @Ok IS NULL
    EXEC spPrevencionLD @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                         @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                         @Ok OUTPUT, @OkRef OUTPUT
   ELSE
  IF @Modulo = 'ORG' AND @Ok IS NULL
    EXEC spOrganiza @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                         @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                         @Ok OUTPUT, @OkRef OUTPUT
  ELSE
  IF @Modulo = 'RE' AND @Ok IS NULL
    EXEC spRecluta @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                   @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                   @Ok OUTPUT, @OkRef OUTPUT
  ELSE
  IF @Modulo = 'ISL' AND @Ok IS NULL
    EXEC spISL @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                    @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                    @Ok OUTPUT, @OkRef OUTPUT
  ELSE
  IF @Modulo = 'PACTO' AND @Ok IS NULL																																						
    EXEC spContrato @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal,	
                    @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, @Estacion,																		
                    @Ok OUTPUT, @OkRef OUTPUT																																				                    
  ELSE
  IF @Modulo = 'SAUX' AND @Ok IS NULL
    EXEC spSAUX @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
                @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                @Ok OUTPUT, @OkRef OUTPUT
  --BUG25014
  --ELSE
  --IF @Modulo = 'CONTP' AND @Ok IS NULL
  --  EXEC spContParalela @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
  --                      @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
  --                      @Ok OUTPUT, @OkRef OUTPUT
  ELSE
    IF @Ok IS NULL
      EXEC xpAfectarOtrosModulos @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
				 @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
				 @Ok OUTPUT, @OkRef OUTPUT, @Estacion = @Estacion
				 
  IF @Ok <> 80030 SELECT @IDGenerar = NULL

  INSERT AfectarBitacora (Modulo,  ModuloID, Accion,  Base,  GenerarMov,  Usuario,  FechaRegistro,  Ok, OkRef)
                  VALUES (@Modulo, @ID,      @Accion, @Base, @GenerarMov, @Usuario, @FechaRegistro, @Ok, @OkRef)

  /*IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
    EXEC vic_spDespuesAfectar @Modulo, @ID, @Accion, @Base, @GenerarMov, @Usuario, @SincroFinal, @EnSilencio, @Ok OUTPUT, @OkRef OUTPUT, @FechaRegistro*/

  IF ((NULLIF(@Ok,0) IS NULL) OR (@Ok BETWEEN 80030 AND 81000)) AND @Accion NOT IN ('GENERAR')--MEJORA5066 
  BEGIN
    SELECT @Empresa = Empresa FROM Mov WHERE Modulo = @Modulo AND ID = @ID
    SELECT @Notificacion = ISNULL(Notificacion,0) FROM EmpresaGral WHERE Empresa = @Empresa
    IF @Notificacion = 1
    BEGIN
      EXEC spNotificacion @ID, @Modulo, @Ok OUTPUT, @OkRef OUTPUT
    END
  END
      
  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
    EXEC xpDespuesAfectar @Modulo, @ID, @Accion, @Base, @GenerarMov, @Usuario, @SincroFinal, @EnSilencio, @Ok OUTPUT, @OkRef OUTPUT, @FechaRegistro

  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
    EXEC xpInterfacesDespuesAfectar @Modulo, @ID, @Accion, @Base, @GenerarMov, @Usuario, @SincroFinal, @EnSilencio, @Ok OUTPUT, @OkRef OUTPUT, @FechaRegistro

  --REQ25300
  --IF ((NULLIF(@Ok,0) IS NULL) OR (@Ok BETWEEN 80030 AND 81000)) AND @Accion IN ('AFECTAR', 'CANCELAR', 'AUTORIZAR')
  --BEGIN
  --  SELECT @Empresa = Empresa, @ContID = ContID FROM Mov WHERE Modulo = @Modulo AND ID = @ID
    
  --  SELECT @CONTP = ISNULL(ContabilidadParalela, 0) FROM EmpresaGral WHERE Empresa = @Empresa
    
  --  SELECT @CPCentralizadora = ISNULL(CPCentralizadora, 0) FROM Version

  --  IF @ContabilidadParalela = 1 AND @CONTP = 1 AND @CPCentralizadora = 0
  --  BEGIN
  --    EXEC spContParalelaEnviarEnLinea @Empresa, @Sucursal, @ContID, @Accion, @Usuario, @FechaRegistro, @Mov, @MovID, @Estacion, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT    
  --  END
  --END

  IF @EnSilencio = 0
  BEGIN
    IF @Ok IS NULL 
      SELECT @OkRef = NULL
    ELSE
      -- Leer el Mensaje
      SELECT @OkDesc = Descripcion, 
             @OkTipo = Tipo
        FROM MensajeLista
       WHERE Mensaje = @Ok  
  
    -- Mostrar el Estatus de la Afectacion
    SELECT @Ok, @OkDesc, @OkTipo, @OkRef, @IDGenerar
  END

  RETURN ISNULL(@IDGenerar, 0)
END
GO

-- spAfectarLoteLista 100, 'DEMO', 'VTAS', 'GENERAR', 'TODO', 'Factura', 'DEMO', 'Cliente'
-- spAfectarLoteLista 100, 'DEMO', 'VTAS', 'GENERAR', 'PENDIENTE', 'Venta Perdida', 'DEMO', 'Cliente'
-- select * from listaid
/**************** spAfectarLoteLista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAfectarLoteLista') and type = 'P') drop procedure dbo.spAfectarLoteLista
GO
CREATE PROCEDURE spAfectarLoteLista
		   @Estacion		int,
		   @Empresa		char(5),
		   @Modulo		char(5),
                   @Accion		char(20),
		   @Base		char(20),
                   @GenerarMov		char(20),
		   @Usuario		char(10),
		   @FacturarLote	varchar(20) 	= 'Movimiento',
		   @Conexion		bit		= 0
--//WITH ENCRYPTION
AS BEGIN
DECLARE 
  @Elimino		int,
  @ID			int,
  @IDGenerar		int,
  @Ok			int,
  @OkRef		varchar(255),
  @Mensaje		varchar(255),
  @MovTipo		varchar(20),
  @GenerarMovTipo	varchar(20),
  @Continuar		bit,
  @Sucursal		int,
  @Cliente		char(10),
  @Condicion		varchar(50),
  @Vencimiento		datetime,
  @DescuentoGlobal	float,
  @Renglon		float,
  @CFD			bit

  SELECT @GenerarMovTipo = Clave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @GenerarMov
  DELETE ListaIDOk WHERE Estacion = @Estacion

  IF @FacturarLote = 'Cliente'
  BEGIN
    DECLARE crListaCte CURSOR FOR
     SELECT mt.Clave, v.Sucursal, v.Cliente, v.Condicion, v.Vencimiento, v.DescuentoGlobal, MIN(l.ID)
       FROM ListaID l, Venta v, MovTipo mt
      WHERE l.Estacion = @Estacion AND v.ID = l.ID AND v.Empresa = @Empresa AND mt.Modulo = @Modulo AND mt.Mov = v.Mov
      GROUP BY mt.Clave, v.Sucursal, v.Cliente, v.Condicion, v.Vencimiento, v.DescuentoGlobal
      ORDER BY mt.Clave, v.Sucursal, v.Cliente, v.Condicion, v.Vencimiento, v.DescuentoGlobal
    OPEN crListaCte
    FETCH NEXT FROM crListaCte INTO @MovTipo, @Sucursal, @Cliente, @Condicion, @Vencimiento, @DescuentoGlobal, @ID
    WHILE @@FETCH_STATUS <> -1 
      BEGIN
      IF @@FETCH_STATUS <> -2
      BEGIN
        SELECT @Continuar = 1
        IF @GenerarMovTipo = 'VTAS.F'
		BEGIN
          IF (SELECT mt.Clave FROM Venta v, MovTipo mt WHERE v.ID = @ID AND mt.Modulo = 'VTAS' AND mt.Mov = v.Mov) NOT IN ('VTAS.P', 'VTAS.S', 'VTAS.VCR') 
            SELECT @Continuar = 0

          EXEC spMovTipoCFD @Empresa, @Modulo, @GenerarMov, @CFD OUTPUT
		  IF @CFD= 1
  			WAITFOR DELAY '00:00:01'
		END

        IF @Continuar = 1
        BEGIN
          SELECT @IDGenerar = NULL
          EXEC @IDGenerar = spAfectar @Modulo, @ID, @Accion, @Base, @GenerarMov, @Usuario, 0, 1, @Ok OUTPUT, @OkRef OUTPUT
          IF @Ok = 80030 
          BEGIN
            SELECT @Renglon = ISNULL(MAX(Renglon), 0) FROM VentaD WHERE ID = @IDGenerar
            SELECT * INTO #VentaDetalleLote FROM cVentaD WHERE ID IN (SELECT l.ID FROM ListaID l, Venta v WHERE l.Estacion = @Estacion AND v.ID <> @ID AND v.ID = l.ID AND v.Empresa = @Empresa AND v.Sucursal = @Sucursal AND v.Cliente = @Cliente AND v.Condicion = @Condicion AND v.Vencimiento = @Vencimiento AND v.DescuentoGlobal = @DescuentoGlobal)
            IF EXISTS(SELECT * FROM #VentaDetalleLote)
            BEGIN
              UPDATE #VentaDetalleLote SET @Renglon = Renglon = @Renglon + 2048.0, Aplica = v.Mov, AplicaID = v.MovID FROM #VentaDetalleLote d, Venta v WHERE v.ID = d.ID
              IF @MovTipo = 'VTAS.VCR' 
                UPDATE #VentaDetalleLote SET Almacen = v.AlmacenDestino FROM #VentaDetalleLote d, Venta v WHERE v.ID = d.ID
              IF @Base = 'TODO'      UPDATE #VentaDetalleLote SET ID = @IDGenerar, CantidadPendiente = NULL, CantidadCancelada = NULL, CantidadReservada = NULL, CantidadOrdenada = NULL, CantidadA = NULL, UltimoReservadoCantidad = NULL, UltimoReservadoFecha = NULL ELSE
              IF @Base = 'SELECCION' UPDATE #VentaDetalleLote SET ID = @IDGenerar, Cantidad = CantidadA, CantidadInventario = CantidadA * CantidadInventario / Cantidad, CantidadPendiente = NULL, CantidadCancelada = NULL, CantidadReservada = NULL, CantidadOrdenada = NULL, CantidadA = NULL, UltimoReservadoCantidad = NULL, UltimoReservadoFecha = NULL ELSE
              IF @Base = 'PENDIENTE' UPDATE #VentaDetalleLote SET ID = @IDGenerar, Cantidad = NULLIF(ISNULL(CantidadPendiente,0.0) + ISNULL(CantidadReservada, 0.0), 0.0), CantidadInventario = (NULLIF(ISNULL(CantidadPendiente,0.0) + ISNULL(CantidadReservada, 0.0), 0.0)) * CantidadInventario / Cantidad, CantidadPendiente = NULL, CantidadReservada = NULL, CantidadCancelada = NULL, CantidadOrdenada = NULL, CantidadA = NULL, UltimoReservadoCantidad = NULL, UltimoReservadoFecha = NULL ELSE
              IF @Base = 'RESERVADO' UPDATE #VentaDetalleLote SET ID = @IDGenerar, Cantidad = CantidadReservada, CantidadInventario = CantidadReservada * CantidadInventario / Cantidad, CantidadPendiente = NULL, CantidadCancelada = NULL, CantidadReservada = NULL, CantidadOrdenada = NULL, CantidadA = NULL, UltimoReservadoCantidad = NULL, UltimoReservadoFecha = NULL 
              IF @@ERROR <> 0 SELECT @Ok = 1
              UPDATE #VentaDetalleLote SET Sucursal = @Sucursal, SucursalOrigen = @Sucursal, SustitutoArticulo = NULL, SustitutoSubCuenta = NULL
              IF @@ERROR <> 0 SELECT @Ok = 1
              DELETE #VentaDetalleLote WHERE Cantidad IS NULL OR Cantidad = 0.0
              IF @@ERROR <> 0 SELECT @Ok = 1
              INSERT INTO cVentaD SELECT * FROM #VentaDetalleLote
              IF @@ERROR <> 0 SELECT @Ok = 1
            END
            DROP TABLE #VentaDetalleLote
            IF @@ERROR <> 0 SELECT @Ok = 1

            IF @Ok IN (NULL, 80030)
              EXEC spAfectar @Modulo, @IDGenerar, 'AFECTAR', 'TODO', NULL, @Usuario, @Conexion, 1, @Ok OUTPUT, @OkRef OUTPUT
            SELECT @Elimino = 0

            IF @Ok NOT IN (NULL, 80030)
              EXEC @Elimino = spEliminarMov @Modulo, @IDGenerar
            IF @Elimino = 0 SELECT @ID = @IDGenerar
          END
          INSERT ListaIDOK (Estacion, ID, Empresa, Modulo, Ok, OkRef) VALUES (@Estacion, @ID, @Empresa, @Modulo, @Ok, @OkRef)
        END    
      END
      FETCH NEXT FROM crListaCte INTO @MovTipo, @Sucursal, @Cliente, @Condicion, @Vencimiento, @DescuentoGlobal, @ID
    END
    CLOSE crListaCte
    DEALLOCATE crListaCte
  END ELSE
  BEGIN
    DECLARE crLista CURSOR FOR
     SELECT ID
       FROM ListaID
      WHERE Estacion = @Estacion 
      ORDER BY IDInterno
    OPEN crLista
    FETCH NEXT FROM crLista INTO @ID
    WHILE @@FETCH_STATUS <> -1 
      BEGIN
      IF @@FETCH_STATUS <> -2
      BEGIN
        SELECT @Continuar = 1
        IF @GenerarMovTipo = 'VTAS.F'
		BEGIN
          IF (SELECT mt.Clave FROM Venta v, MovTipo mt WHERE v.ID = @ID AND mt.Modulo = 'VTAS' AND mt.Mov = v.Mov) NOT IN ('VTAS.P', 'VTAS.S', 'VTAS.VCR') 
            SELECT @Continuar = 0

          EXEC spMovTipoCFD @Empresa, @Modulo, @GenerarMov, @CFD OUTPUT
		  IF @CFD= 1
  			WAITFOR DELAY '00:00:01'
		END

        IF @Continuar = 1
        BEGIN
          SELECT @IDGenerar = NULL
          EXEC @IDGenerar = spAfectar @Modulo, @ID, @Accion, @Base, @GenerarMov, @Usuario, @Conexion, 1, @Ok OUTPUT, @OkRef OUTPUT
          IF @Ok = 80030 
          BEGIN
            EXEC spAfectar @Modulo, @IDGenerar, 'AFECTAR', 'TODO', NULL, @Usuario, @Conexion, 1, @Ok OUTPUT, @OkRef OUTPUT
            SELECT @Elimino = 0
            IF @Ok NOT IN (NULL, 80030)
              EXEC @Elimino = spEliminarMov @Modulo, @IDGenerar
            IF @Elimino = 0 SELECT @ID = @IDGenerar
          END
          INSERT ListaIDOK (Estacion, ID, Empresa, Modulo, Ok, OkRef) VALUES (@Estacion, @ID, @Empresa, @Modulo, @Ok, @OkRef)
        END
      END
      FETCH NEXT FROM crLista INTO @ID
    END
    CLOSE crLista
    DEALLOCATE crLista
  END

  IF @Ok IN (NULL, 80030)
    SELECT @Mensaje = 'Proceso Concluido'
  ELSE
    SELECT @Mensaje = Descripcion+' '+RTRIM(@OkRef) 
      FROM MensajeLista
     WHERE Mensaje = @Ok  

  SELECT @Mensaje
  RETURN
END
GO


GO
PRINT '******************* SP AFECTAR ******************'
