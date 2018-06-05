--REQ13163
/**************** fnTCNivelCfgPinPad ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTCNivelCfgPinPad') DROP FUNCTION fnTCNivelCfgPinPad
GO
CREATE FUNCTION dbo.fnTCNivelCfgPinPad(		
			@Empresa	varchar(5)
) 
RETURNS varchar(10) 
AS
BEGIN
  RETURN(SELECT NivelCfgPinPad FROM TCCfg WHERE Empresa = @Empresa)
END
GO

--REQ13163
/**************** fnTCPinPad ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTCPinPad') DROP FUNCTION fnTCPinPad
GO
CREATE FUNCTION fnTCPinPad(
		@Empresa		varchar(5),
		@Sucursal		int,
		@Usuario		varchar(10),
		@Campo			varchar(15)
		)
RETURNS varchar(20)
AS
BEGIN
  DECLARE @NivelCfgPinPad	varchar(10),
		  @TerminalEquiv	varchar(20),
		  @Pinpad			varchar(3),
		  @Puerto			varchar(5),
		  @Valor			varchar(20)

  SELECT @NivelCfgPinPad = dbo.fnTCNivelCfgPinPad(@Empresa)  

  IF @NivelCfgPinPad = 'Agente'
    SELECT @Pinpad = PinPad, @TerminalEquiv = TerminalEquiv, @Puerto = Puerto FROM TCTerminalCfg JOIN Usuario ON TCTerminalCfg.Agente = Usuario.DefAgente WHERE Empresa = @Empresa AND Usuario = @Usuario
  ELSE IF @NivelCfgPinPad =  'Sucursal'
    SELECT @Pinpad = PinPad, @TerminalEquiv = TerminalEquiv, @Puerto = Puerto FROM TCTerminalCfg WHERE Empresa = @Empresa AND Sucursal = @Sucursal
  ELSE IF @NivelCfgPinPad = 'Caja'
    SELECT @Pinpad = PinPad, @TerminalEquiv = TerminalEquiv, @Puerto = Puerto FROM TCTerminalCfg JOIN Usuario ON TCTerminalCfg.CtaDinero = Usuario.DefCtaDinero WHERE Empresa = @Empresa AND Usuario = @Usuario

  IF @Campo = 'Pinpad'
    SELECT @Valor = @PinPad
  ELSE IF @Campo = 'Puerto'
    SELECT @Valor = @Puerto
  ELSE IF @Campo = 'TerminalEquiv'
    SELECT @Valor = @TerminalEquiv
    
  RETURN @Valor
END
GO

--REQ13163
/**************** fnTCNivelCfg ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTCNivelCfg' AND type = 'FN') DROP FUNCTION fnTCNivelCfg
GO
CREATE FUNCTION fnTCNivelCfg(
		@Empresa		varchar(5)
		)
RETURNS varchar(20)
AS
BEGIN
  DECLARE @NivelCfg		varchar(20)
  
  SELECT @NivelCfg = NivelCfg FROM TCCfg WHERE Empresa = @Empresa
  
  RETURN(ISNULL(@NivelCfg, 'Empresa'))
END
GO

--REQ13163
/**************** fnTCProcesadorTransCfg ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTCProcesadorTransCfg' AND type = 'FN') DROP FUNCTION fnTCProcesadorTransCfg
GO
CREATE FUNCTION fnTCProcesadorTransCfg(
		@Empresa		varchar(5),
		@Sucursal		int
		)
RETURNS varchar(20)
AS
BEGIN
  DECLARE @ProcesadorTrans		varchar(20)
  
  IF dbo.fnTCNivelCfg(@Empresa) = 'Empresa'
    SELECT @ProcesadorTrans = ProcesadorTrans FROM TCCfg WHERE Empresa = @Empresa
  ELSE IF dbo.fnTCNivelCfg(@Empresa) = 'Sucursal'
    SELECT @ProcesadorTrans = ProcesadorTrans FROM TCSucursalCfg WHERE Empresa = @Empresa AND Sucursal = @Sucursal

  RETURN(@ProcesadorTrans)
END
GO

--REQ13163
/**************** fnTCTerminalEquivCfg ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTCTerminalEquivCfg' AND type = 'FN') DROP FUNCTION fnTCTerminalEquivCfg
GO
CREATE FUNCTION fnTCTerminalEquivCfg(
		@Empresa		varchar(5),
		@Sucursal		int
		)
RETURNS varchar(20)
AS
BEGIN
  DECLARE @TerminalEquiv		bit
  
  SELECT @TerminalEquiv = ISNULL(TerminalEquiv, 0)
    FROM TCProcesadorTrans
   WHERE ProcesadorTrans = dbo.fnTCProcesadorTransCfg(@Empresa, @Sucursal)

  RETURN(@TerminalEquiv)
END
GO

--REQ13163
/**************** fnTCInstitucionAdquirienteCfg ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTCInstitucionAdquirienteCfg' AND type = 'FN') DROP FUNCTION fnTCInstitucionAdquirienteCfg
GO
CREATE FUNCTION fnTCInstitucionAdquirienteCfg(
		@Empresa		varchar(5),
		@Sucursal		int
		)
RETURNS varchar(20)
AS
BEGIN
  DECLARE @InstitucionAdquiriente	varchar(20)
  
  IF dbo.fnTCNivelCfg(@Empresa) = 'Empresa'
    SELECT @InstitucionAdquiriente = InstitucionAdquiriente FROM TCCfg WHERE Empresa = @Empresa
  ELSE IF dbo.fnTCNivelCfg(@Empresa) = 'Sucursal'
    SELECT @InstitucionAdquiriente = InstitucionAdquiriente FROM TCSucursalCfg WHERE Empresa = @Empresa AND Sucursal = @Sucursal

  RETURN(@InstitucionAdquiriente)
END
GO

--REQ13163
/**************** fnTCInstitucionAdquirienteAMEXCfg ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTCInstitucionAdquirienteAMEXCfg' AND type = 'FN') DROP FUNCTION fnTCInstitucionAdquirienteAMEXCfg
GO
CREATE FUNCTION fnTCInstitucionAdquirienteAMEXCfg(
		@Empresa		varchar(5),
		@Sucursal		int
		)
RETURNS varchar(20)
AS
BEGIN
  DECLARE @InstitucionAdquirienteAMEX	varchar(20)
  
  IF dbo.fnTCNivelCfg(@Empresa) = 'Empresa'
    SELECT @InstitucionAdquirienteAMEX = InstitucionAdquirienteAMEX FROM TCCfg WHERE Empresa = @Empresa
  ELSE IF dbo.fnTCNivelCfg(@Empresa) = 'Sucursal'
    SELECT @InstitucionAdquirienteAMEX = InstitucionAdquirienteAMEX FROM TCSucursalCfg WHERE Empresa = @Empresa AND Sucursal = @Sucursal

  RETURN(@InstitucionAdquirienteAMEX)
END
GO

--REQ13163
/***************** spTCModoOperacion *****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spTCModoOperacion' AND Type = 'P') DROP PROCEDURE spTCModoOperacion
GO
CREATE PROC spTCModoOperacion
			@Empresa		varchar(5),
			@Sucursal		int
--//WITH ENCRYPTION
AS
BEGIN
  IF dbo.fnTCProcesadorTransCfg(@Empresa, @Sucursal) = 'BANORTE'
    SELECT 'Prueba Aprobada'
    UNION
    SELECT 'Prueba Declinada'
    UNION
    SELECT 'Prueba Aleatoria'
    UNION
    SELECT 'Produccion'    
END
GO

--REQ13163
-- EXEC spTCObtenerDatosTransaccion 'VTAS', 378, 'American Express'
/***************** spTCObtenerDatosTransaccion *****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spTCObtenerDatosTransaccion' AND Type = 'P') DROP PROCEDURE spTCObtenerDatosTransaccion
GO
CREATE PROC spTCObtenerDatosTransaccion
			@Modulo			varchar(5),
			@ModuloID		int,
			@FormaPago		varchar(50),
			@Importe		float,
			@Accion			varchar(20),
			@CancelaRID		int,
			@Sucursal		int, 
			@Estacion		int,	
			@Campo			varchar(50), 
			@Referencia		varchar(50),
			@XMLTransaccion	varchar(max)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @TCTipoPlan		varchar(2),
		  @TCNoMeses		int,
		  @TCDiferirMeses	int,
		  @OrderID			varchar(255)
		  
  IF @Accion = 'VOID'
  BEGIN
    SELECT @TCTipoPlan		= CASE TCTipoPlan
                                  WHEN 'Normal'			   THEN ''
                                  WHEN 'Con Intereses'	   THEN '05'
                                  WHEN 'Diferimiento Inicial'THEN '07'
                                  WHEN 'Sin Intereses'	   THEN '03'
                                END,
		   @TCNoMeses	    = TCNoMeses,
		   @TCDiferirMeses	= TCDiferirMeses,
		   @OrderID			= IDOrden
      FROM TCTransaccion
     WHERE RID = @CancelaRID
  END
  ELSE
  BEGIN
    SELECT @TCTipoPlan		= CASE TCTipoPlan
                                  WHEN 'Normal'			   THEN ''
                                  WHEN 'Con Intereses'	   THEN '05'
                                  WHEN 'Diferimiento Inicial'THEN '07'
                                  WHEN 'Sin Intereses'	   THEN '03'
                                END,
		   @TCNoMeses	    = CASE TCTipoPlan 
		                          WHEN 'Normal'				THEN 0
		                          WHEN 'Diferimiento Inicial' THEN 0
		                          WHEN 'Con Intereses'		THEN ISNULL(TCNoMeses, 0)
		                          WHEN 'Sin Intereses'		THEN ISNULL(TCNoMeses, 0)
		                        END,
		   @TCDiferirMeses	= CASE TCTipoPlan
		                          WHEN 'Normal'				THEN 0
		                          WHEN 'Diferimiento Inicial' THEN ISNULL(TCDiferirMeses, 0)
		                          WHEN 'Con Intereses'		THEN 0
		                          WHEN 'Sin Intereses'		THEN 0
		                      END,
		   @OrderID			= NULL
      FROM FormaPago
     WHERE FormaPago = @FormaPago

    IF @Accion = 'Credit'
      SELECT @OrderID = @Referencia     
  END

  IF @Modulo = 'VTAS'
    SELECT @XMLTransaccion = (SELECT MonCodigoInternacional.CodigoNumerico 'Moneda',
		                             @TCTipoPlan 'TipoPlan',
		                             @TCNoMeses 'NoMeses',
		                             @TCDiferirMeses 'DiferirMeses',
		                             @Modulo 'Modulo',
		                             @ModuloID 'ModuloID',
		                             @FormaPago 'FormaPago',
		                             @Importe 'Importe',
		                             @Accion 'Accion',
		                             @CancelaRID 'CancelaRID',
		                             @OrderID 'OrderID',
		                             @Sucursal 'Sucursal', 
									 @Estacion'Estacion',
									 @Campo 'Campo'
                                FROM Venta 
                                JOIN Mon ON Venta.Moneda = Mon.Moneda
                                LEFT OUTER JOIN MonCodigoInternacional ON Mon.Moneda = MonCodigoInternacional.Moneda
                               WHERE ID = @ModuloID
                                 FOR XML RAW('Transaccion')
                                 )
END
GO

--REQ13163
-- EXEC spTCCfg 'DEMO', 0, 1
/***************** spTCCfg *****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spTCCfg' AND Type = 'P') DROP PROCEDURE spTCCfg
GO
CREATE PROC spTCCfg
			@Empresa		varchar(5),
			@Sucursal		int,
			@Estacion		int,
			@Usuario		varchar(10),
			@XMLCfg			varchar(max) OUTPUT
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE @PinPad	varchar(3)
  
  SELECT @PinPad = dbo.fnTCPinPad(@Empresa, @Sucursal, @Usuario, 'Pinpad')
  
  SELECT @XMLCfg = (SELECT TCCfg.Empresa,
                           Empresa.Nombre 'NombreEmpresa',
                           dbo.fnTCProcesadorTransCfg(@Empresa, @Sucursal) 'ProcesadorTrans',
                           dbo.fnTCInstitucionAdquirienteCfg(@Empresa, @Sucursal) 'InstitucionAdquiriente',
                           dbo.fnTCInstitucionAdquirienteAMEXCfg(@Empresa, @Sucursal) 'InstitucionAdquirienteAMEX',
                           ConexionExplicita,
                           @PinPad 'Pinpad',
                           dbo.fnTCPinPad(@Empresa, @Sucursal, @Usuario, 'Puerto') 'Puerto',
                           TCPinPad.Velocidad,
                           TCPinPad.Paridad,
                           TCPinPad.BitsParada,
                           TCPinPad.BitsDatos,
                           CASE ModoOperacion
                             WHEN 'Produccion'	   THEN 'P'
                             WHEN 'Prueba Aleatoria' THEN 'R'
                             WHEN 'Prueba Aprobada'  THEN 'Y'
                             WHEN 'Prueba Declinada' THEN 'N'                                                                                 
                           END 'ModoOperacion',
                           TCSucursalCfg.Usuario,
                           TCSucursalCfg.Contrasena,
                           Afiliacion,
                           dbo.fnTCPinPad(@Empresa, @Sucursal, @Usuario, 'TerminalEquiv') 'TerminalEquivalente'
                      FROM TCCfg
                      JOIN Empresa ON TCCfg.Empresa = Empresa.Empresa
                      LEFT OUTER JOIN TCSucursalCfg ON TCCfg.Empresa = TCSucursalCfg.Empresa AND TCSucursalCfg.Sucursal = @Sucursal
                      LEFT OUTER JOIN TCPinPad ON TCPinPad.Pinpad = @PinPad
                     WHERE TCCfg.Empresa = @Empresa
                       FOR XML RAW('Cfg')
                     )
END
GO

--REQ13163
/**************** fnTCVentaCobroActivarPinPad ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTCVentaCobroActivarPinPad' AND type = 'FN') DROP FUNCTION fnTCVentaCobroActivarPinPad
GO
CREATE FUNCTION fnTCVentaCobroActivarPinPad(
				@ModuloID		int,
				@FormaCobro1	varchar(50),
				@FormaCobro2	varchar(50),
				@FormaCobro3	varchar(50),
				@FormaCobro4	varchar(50),
				@FormaCobro5	varchar(50),
				@TCProcesado1	bit,
				@TCProcesado2	bit,
				@TCProcesado3	bit,
				@TCProcesado4	bit,
				@TCProcesado5	bit
				)
RETURNS bit
AS
BEGIN
  DECLARE @Valor			bit

  IF (@FormaCobro1 IS NOT NULL AND (SELECT ISNULL(TCActivarInterfaz, 0) FROM FormaPago WHERE FormaPago = @FormaCobro1) = 1 AND ISNULL(@TCProcesado1, 0) = 0) OR
     (@FormaCobro2 IS NOT NULL AND (SELECT ISNULL(TCActivarInterfaz, 0) FROM FormaPago WHERE FormaPago = @FormaCobro2) = 1 AND ISNULL(@TCProcesado2, 0) = 0) OR
     (@FormaCobro3 IS NOT NULL AND (SELECT ISNULL(TCActivarInterfaz, 0) FROM FormaPago WHERE FormaPago = @FormaCobro3) = 1 AND ISNULL(@TCProcesado3, 0) = 0) OR
     (@FormaCobro4 IS NOT NULL AND (SELECT ISNULL(TCActivarInterfaz, 0) FROM FormaPago WHERE FormaPago = @FormaCobro4) = 1 AND ISNULL(@TCProcesado4, 0) = 0) OR
     (@FormaCobro5 IS NOT NULL AND (SELECT ISNULL(TCActivarInterfaz, 0) FROM FormaPago WHERE FormaPago = @FormaCobro5) = 1 AND ISNULL(@TCProcesado5, 0) = 0)
    SELECT @Valor = 1
  ELSE
    SELECT @Valor = 0

  RETURN @Valor
END
GO

--REQ13163
/***************** spTCObtenerFormasPago *****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spTCObtenerFormasPago' AND Type = 'P') DROP PROCEDURE spTCObtenerFormasPago
GO
CREATE PROC spTCObtenerFormasPago
			@Empresa		varchar(5),
			@Modulo			varchar(5),
			@ID				int,
			@Sucursal		int,
			@Estacion		int,
			@Accion			varchar(20), 
			@RID			int,
			@FormaPago		varchar(50)		= NULL OUTPUT, 
			@Importe		float			= NULL OUTPUT, 
			@Campo			varchar(50)		= NULL OUTPUT,
			@IDOrden		varchar(255)	= NULL OUTPUT,
			@Ok				int				= NULL OUTPUT,
			@OkRef			varchar(255)	= NULL OUTPUT,
			@XMLTransaccion	varchar(max)	= NULL OUTPUT,
			@Referencia		varchar(50)		= NULL OUTPUT,
			@EnSilencio		bit				= 1
--//WITH ENCRYPTION
AS
BEGIN
  CREATE TABLE #Pendientes(
    RID				int	IDENTITY,
    Campo			varchar(50),
    FormaPago		varchar(50)	NULL,
    Referencia		varchar(50)	NULL,
    TCProcesado		bit			NULL,
    Importe			float		NULL
    )
    
  IF @Accion = 'VOID'
  BEGIN
    SELECT @FormaPago = FormaPago, @Importe = Importe, @Campo = Campo, @IDOrden = IDOrden FROM TCTransaccion WHERE RID = @RID
  END
  ELSE
  BEGIN
    INSERT INTO #Pendientes(Campo, FormaPago, Importe, TCProcesado, Referencia) SELECT 'FormaCobro1', FormaCobro1, Importe1, TCProcesado1, Referencia1 FROM VentaCobro JOIN FormaPago ON FormaCobro1 = FormaPago WHERE ID = @ID AND ISNULL(TCActivarInterfaz, 0) = 1
    INSERT INTO #Pendientes(Campo, FormaPago, Importe, TCProcesado, Referencia) SELECT 'FormaCobro2', FormaCobro2, Importe2, TCProcesado2, Referencia2 FROM VentaCobro JOIN FormaPago ON FormaCobro2 = FormaPago WHERE ID = @ID AND ISNULL(TCActivarInterfaz, 0) = 1
    INSERT INTO #Pendientes(Campo, FormaPago, Importe, TCProcesado, Referencia) SELECT 'FormaCobro3', FormaCobro3, Importe3, TCProcesado3, Referencia3 FROM VentaCobro JOIN FormaPago ON FormaCobro3 = FormaPago WHERE ID = @ID AND ISNULL(TCActivarInterfaz, 0) = 1        
    INSERT INTO #Pendientes(Campo, FormaPago, Importe, TCProcesado, Referencia) SELECT 'FormaCobro4', FormaCobro4, Importe4, TCProcesado4, Referencia4 FROM VentaCobro JOIN FormaPago ON FormaCobro4 = FormaPago WHERE ID = @ID AND ISNULL(TCActivarInterfaz, 0) = 1
    INSERT INTO #Pendientes(Campo, FormaPago, Importe, TCProcesado, Referencia) SELECT 'FormaCobro5', FormaCobro5, Importe5, TCProcesado5, Referencia5 FROM VentaCobro JOIN FormaPago ON FormaCobro5 = FormaPago WHERE ID = @ID AND ISNULL(TCActivarInterfaz, 0) = 1

    SELECT @FormaPago	= FormaPago,
		   @Importe		= Importe,
		   @Campo		= Campo,
		   @Referencia	= Referencia
     FROM #Pendientes WHERE RID = (SELECT MIN(RID) FROM #Pendientes WHERE ISNULL(TCProcesado, 0) = 0)
  END
  
  IF @EnSilencio = 1
  BEGIN
    IF @FormaPago IS NULL
      SELECT @Ok = 60010

    IF @FormaPago IS NOT NULL AND ISNULL(@Importe, 0) = 0
      SELECT @Ok = 30100, @OkRef = @FormaPago
  END
  ELSE
    SELECT @FormaPago, @Importe, @Referencia, @Campo
END
GO

--REQ13163
/***************** spTCEjecutarAplicacion *****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spTCEjecutarAplicacion' AND Type = 'P') DROP PROCEDURE spTCEjecutarAplicacion
GO

--BUG19945
/***************** spTCShellAplicacion *****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spTCShellAplicacion' AND Type = 'P') DROP PROCEDURE spTCShellAplicacion
GO
CREATE PROC spTCShellAplicacion
			@Ubicacion		varchar(255), 
			@UbicacionXML	varchar(255), 
			@ArchivoCfg		varchar(255),
			@Shell			varchar(8000)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  --DECLARE @Shell	varchar(8000)
  
  SELECT @Shell = @Ubicacion + ' "' + ISNULL(CONVERT(varchar(255), @UbicacionXML), '') + '" "' + ISNULL(CONVERT(varchar(255), @ArchivoCfg), '') + '"'
  
  --EXEC xp_cmdshell @Shell, no_output
END
GO

--REQ13163
/**************** fnTCBanorteFecha ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTCBanorteFecha' AND type = 'FN') DROP FUNCTION fnTCBanorteFecha
GO
CREATE FUNCTION fnTCBanorteFecha(
		@Texto	varchar(30)
		)
RETURNS datetime
AS
BEGIN
  DECLARE @Dia		int,
		  @Mes		int,
		  @Ano		int,
		  @Hora		int,
		  @Minuto	int,
		  @Segundo	int,
		  @Fecha	datetime

  SELECT @Fecha = ''

  SELECT @Dia = SUBSTRING(@Texto, 9, 2),
	     @Mes = CASE SUBSTRING(@Texto, 5, 3)
	              WHEN 'Jan' THEN 1
	              WHEN 'Feb' THEN 2
	              WHEN 'Mar' THEN 3
	              WHEN 'Apr' THEN 4
	              WHEN 'May' THEN 5
	              WHEN 'Jun' THEN 6
	              WHEN 'Jul' THEN 7
	              WHEN 'Aug' THEN 8
	              WHEN 'Sep' THEN 9
	              WHEN 'Oct' THEN 10
	              WHEN 'Nov' THEN 11
	              WHEN 'Dec' THEN 12
	            END,
	     @Ano = SUBSTRING(@Texto, 25, 4),
	     @Hora = SUBSTRING(@Texto, 12, 2),
	     @Minuto = SUBSTRING(@Texto, 15, 2),
	     @Segundo = SUBSTRING(@Texto, 18, 2)

  SELECT @Fecha = DATEADD(ss, @Segundo, DATEADD(hh, @Hora, DATEADD(mi, @Minuto, DATEADD(YEAR, @Ano - 1900, DATEADD(m, @Mes - 1, DATEADD(DD, @Dia - 1, @Fecha))))))

  RETURN @Fecha
END
GO

--REQ13163
/***************** spTCValidarTransaccion *****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spTCValidarTransaccion' AND Type = 'P') DROP PROCEDURE spTCValidarTransaccion
GO
CREATE PROC spTCValidarTransaccion 
			@Estacion			int,
			@Modulo				varchar(5),
			@ID					int, 
			@FormaPago			varchar(50),
			@Importe			float, 
			@Campo				varchar(50),
			@ProcesadorTrans	varchar(15),
			@Accion				varchar(20), 
			@CxcID				int,
			@CodigoAutorizacion	varchar(255) OUTPUT,
			@Ok					int			 OUTPUT, 
			@OkRef				varchar(255) OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @CodigoError			varchar(255),
          @Texto				varchar(255)

  SELECT @CodigoError = TCHashTableTransaccion.Valor FROM TCHashTableTransaccion JOIN TCHashTableDefinicion ON TCHashTableTransaccion.Columna = TCHashTableDefinicion.Columna WHERE Estacion = @Estacion AND ProcesadorTrans = @ProcesadorTrans AND TCHashTableDefinicion.Campo = 'Codigo Error'
  SELECT @Texto = TCHashTableTransaccion.Valor FROM TCHashTableTransaccion JOIN TCHashTableDefinicion ON TCHashTableTransaccion.Columna = TCHashTableDefinicion.Columna WHERE Estacion = @Estacion AND ProcesadorTrans = @ProcesadorTrans AND TCHashTableDefinicion.Campo = 'Texto'
  SELECT @CodigoAutorizacion = TCHashTableTransaccion.Valor FROM TCHashTableTransaccion JOIN TCHashTableDefinicion ON TCHashTableTransaccion.Columna = TCHashTableDefinicion.Columna WHERE Estacion = @Estacion AND ProcesadorTrans = @ProcesadorTrans AND TCHashTableDefinicion.Campo = 'Codigo Autorizacion'

  IF @ProcesadorTrans = 'BANORTE' AND ISNULL(@CodigoError, '') <> '1'
    SELECT @Ok = 7, @OkRef = @FormaPago + ' - ' + @Texto 

  IF @Ok IS NULL
    UPDATE Cxc SET TarjetaBancariaAutorizacion = @CodigoAutorizacion WHERE ID = @CxcID

  RETURN
END
GO

--REQ13163
/***************** spTCRegistrarTransaccion *****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spTCRegistrarTransaccion' AND Type = 'P') DROP PROCEDURE spTCRegistrarTransaccion
GO
CREATE PROC spTCRegistrarTransaccion 
			@Estacion			int,
			@Modulo				varchar(5),
			@ID					int, 
			@FormaPago			varchar(50),
			@Importe			float, 
			@Campo				varchar(50),
			@ProcesadorTrans	varchar(15),
			@Accion				varchar(20), 
			@CxcID				int,
			@RID				int			 OUTPUT, 
			@CodigoAutorizacion	varchar(255) OUTPUT,
			@Ok					int			 OUTPUT, 
			@OkRef				varchar(255) OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @ARQC					varchar(255),
		  @BancoEmisor			varchar(255),
		  @CodigoError			varchar(255),
		  @CodigoProcesador		varchar(255),
		  @E1					varchar(255),
		  @E2					varchar(255),
		  @E3					varchar(255),
		  @Estatus				varchar(255),
		  @FechaExpiracion		varchar(5),
		  @FechaFin				datetime,
		  @FechaInicio			datetime,
		  @IDOrden				varchar(255),
		  @MensajeError			varchar(255),
		  @MensajeProcesador	varchar(255),
		  @NumeroTarjeta		varchar(255),
		  @SeveridadError		varchar(255),
		  @Tarjetahabiente		varchar(255),
		  @Texto				varchar(255),
		  @TipoOperacion		varchar(255),
		  @TipoTarjeta			varchar(255),
		  @TipoTransaccion		varchar(255),
		  @Total				float,
		  @Track1				varchar(255),
		  @Track2				varchar(255),
		  
		  @TCTipoPlan			varchar(20),
		  @TCNoMeses			int,
		  @TCDiferirMeses		int

  SELECT @TCTipoPlan = TCTipoPlan,
		 @TCNoMeses		 = CASE TCTipoPlan 
		                     WHEN 'Normal'				THEN 0
		                     WHEN 'Diferimiento Inicial' THEN 0
		                     WHEN 'Con Intereses'		THEN ISNULL(TCNoMeses, 0)
		                     WHEN 'Sin Intereses'		THEN ISNULL(TCNoMeses, 0)
		                   END,
		 @TCDiferirMeses = CASE TCTipoPlan
		                     WHEN 'Normal'				THEN 0
		                     WHEN 'Diferimiento Inicial' THEN ISNULL(TCDiferirMeses, 0)
		                     WHEN 'Con Intereses'		THEN 0
		                     WHEN 'Sin Intereses'		THEN 0
		                   END
    FROM FormaPago
   WHERE FormaPago = @FormaPago
   
  SELECT @ARQC = TCHashTableTransaccion.Valor FROM TCHashTableTransaccion JOIN TCHashTableDefinicion ON TCHashTableTransaccion.Columna = TCHashTableDefinicion.Columna WHERE Estacion = @Estacion AND ProcesadorTrans = @ProcesadorTrans AND TCHashTableDefinicion.Campo = 'ARQC'
  SELECT @BancoEmisor = TCHashTableTransaccion.Valor FROM TCHashTableTransaccion JOIN TCHashTableDefinicion ON TCHashTableTransaccion.Columna = TCHashTableDefinicion.Columna WHERE Estacion = @Estacion AND ProcesadorTrans = @ProcesadorTrans AND TCHashTableDefinicion.Campo = 'Banco Emisor'
  SELECT @CodigoAutorizacion = TCHashTableTransaccion.Valor FROM TCHashTableTransaccion JOIN TCHashTableDefinicion ON TCHashTableTransaccion.Columna = TCHashTableDefinicion.Columna WHERE Estacion = @Estacion AND ProcesadorTrans = @ProcesadorTrans AND TCHashTableDefinicion.Campo = 'Codigo Autorizacion'
  SELECT @CodigoError = TCHashTableTransaccion.Valor FROM TCHashTableTransaccion JOIN TCHashTableDefinicion ON TCHashTableTransaccion.Columna = TCHashTableDefinicion.Columna WHERE Estacion = @Estacion AND ProcesadorTrans = @ProcesadorTrans AND TCHashTableDefinicion.Campo = 'Codigo Error'
  SELECT @CodigoProcesador = TCHashTableTransaccion.Valor FROM TCHashTableTransaccion JOIN TCHashTableDefinicion ON TCHashTableTransaccion.Columna = TCHashTableDefinicion.Columna WHERE Estacion = @Estacion AND ProcesadorTrans = @ProcesadorTrans AND TCHashTableDefinicion.Campo = 'Codigo Procesador'
  SELECT @E1 = TCHashTableTransaccion.Valor FROM TCHashTableTransaccion JOIN TCHashTableDefinicion ON TCHashTableTransaccion.Columna = TCHashTableDefinicion.Columna WHERE Estacion = @Estacion AND ProcesadorTrans = @ProcesadorTrans AND TCHashTableDefinicion.Campo = 'E1'
  SELECT @E2 = TCHashTableTransaccion.Valor FROM TCHashTableTransaccion JOIN TCHashTableDefinicion ON TCHashTableTransaccion.Columna = TCHashTableDefinicion.Columna WHERE Estacion = @Estacion AND ProcesadorTrans = @ProcesadorTrans AND TCHashTableDefinicion.Campo = 'E2'
  SELECT @E3 = TCHashTableTransaccion.Valor FROM TCHashTableTransaccion JOIN TCHashTableDefinicion ON TCHashTableTransaccion.Columna = TCHashTableDefinicion.Columna WHERE Estacion = @Estacion AND ProcesadorTrans = @ProcesadorTrans AND TCHashTableDefinicion.Campo = 'E3'
  SELECT @Estatus = TCHashTableTransaccion.Valor FROM TCHashTableTransaccion JOIN TCHashTableDefinicion ON TCHashTableTransaccion.Columna = TCHashTableDefinicion.Columna WHERE Estacion = @Estacion AND ProcesadorTrans = @ProcesadorTrans AND TCHashTableDefinicion.Campo = 'Estatus'
  SELECT @IDOrden = TCHashTableTransaccion.Valor FROM TCHashTableTransaccion JOIN TCHashTableDefinicion ON TCHashTableTransaccion.Columna = TCHashTableDefinicion.Columna WHERE Estacion = @Estacion AND ProcesadorTrans = @ProcesadorTrans AND TCHashTableDefinicion.Campo = 'ID Orden'
  SELECT @MensajeError = TCHashTableTransaccion.Valor FROM TCHashTableTransaccion JOIN TCHashTableDefinicion ON TCHashTableTransaccion.Columna = TCHashTableDefinicion.Columna WHERE Estacion = @Estacion AND ProcesadorTrans = @ProcesadorTrans AND TCHashTableDefinicion.Campo = 'Mensaje Error'
  SELECT @MensajeProcesador = TCHashTableTransaccion.Valor FROM TCHashTableTransaccion JOIN TCHashTableDefinicion ON TCHashTableTransaccion.Columna = TCHashTableDefinicion.Columna WHERE Estacion = @Estacion AND ProcesadorTrans = @ProcesadorTrans AND TCHashTableDefinicion.Campo = 'Mensaje Procesador'
  SELECT @NumeroTarjeta = TCHashTableTransaccion.Valor FROM TCHashTableTransaccion JOIN TCHashTableDefinicion ON TCHashTableTransaccion.Columna = TCHashTableDefinicion.Columna WHERE Estacion = @Estacion AND ProcesadorTrans = @ProcesadorTrans AND TCHashTableDefinicion.Campo = 'Numero Tarjeta'
  SELECT @SeveridadError = TCHashTableTransaccion.Valor FROM TCHashTableTransaccion JOIN TCHashTableDefinicion ON TCHashTableTransaccion.Columna = TCHashTableDefinicion.Columna WHERE Estacion = @Estacion AND ProcesadorTrans = @ProcesadorTrans AND TCHashTableDefinicion.Campo = 'Severidad Error'
  SELECT @Tarjetahabiente = TCHashTableTransaccion.Valor FROM TCHashTableTransaccion JOIN TCHashTableDefinicion ON TCHashTableTransaccion.Columna = TCHashTableDefinicion.Columna WHERE Estacion = @Estacion AND ProcesadorTrans = @ProcesadorTrans AND TCHashTableDefinicion.Campo = 'Tarjetahabiente'
  SELECT @Texto = TCHashTableTransaccion.Valor FROM TCHashTableTransaccion JOIN TCHashTableDefinicion ON TCHashTableTransaccion.Columna = TCHashTableDefinicion.Columna WHERE Estacion = @Estacion AND ProcesadorTrans = @ProcesadorTrans AND TCHashTableDefinicion.Campo = 'Texto'
  SELECT @TipoOperacion = TCHashTableTransaccion.Valor FROM TCHashTableTransaccion JOIN TCHashTableDefinicion ON TCHashTableTransaccion.Columna = TCHashTableDefinicion.Columna WHERE Estacion = @Estacion AND ProcesadorTrans = @ProcesadorTrans AND TCHashTableDefinicion.Campo = 'Tipo Operacion'
  SELECT @TipoTarjeta = TCHashTableTransaccion.Valor FROM TCHashTableTransaccion JOIN TCHashTableDefinicion ON TCHashTableTransaccion.Columna = TCHashTableDefinicion.Columna WHERE Estacion = @Estacion AND ProcesadorTrans = @ProcesadorTrans AND TCHashTableDefinicion.Campo = 'Tipo Tarjeta'
  SELECT @TipoTransaccion = TCHashTableTransaccion.Valor FROM TCHashTableTransaccion JOIN TCHashTableDefinicion ON TCHashTableTransaccion.Columna = TCHashTableDefinicion.Columna WHERE Estacion = @Estacion AND ProcesadorTrans = @ProcesadorTrans AND TCHashTableDefinicion.Campo = 'Tipo Transaccion'
  SELECT @Total = TCHashTableTransaccion.Valor FROM TCHashTableTransaccion JOIN TCHashTableDefinicion ON TCHashTableTransaccion.Columna = TCHashTableDefinicion.Columna WHERE Estacion = @Estacion AND ProcesadorTrans = @ProcesadorTrans AND TCHashTableDefinicion.Campo = 'Total'
  SELECT @Track1 = TCHashTableTransaccion.Valor FROM TCHashTableTransaccion JOIN TCHashTableDefinicion ON TCHashTableTransaccion.Columna = TCHashTableDefinicion.Columna WHERE Estacion = @Estacion AND ProcesadorTrans = @ProcesadorTrans AND TCHashTableDefinicion.Campo = 'Track1'
  SELECT @Track2 = TCHashTableTransaccion.Valor FROM TCHashTableTransaccion JOIN TCHashTableDefinicion ON TCHashTableTransaccion.Columna = TCHashTableDefinicion.Columna WHERE Estacion = @Estacion AND ProcesadorTrans = @ProcesadorTrans AND TCHashTableDefinicion.Campo = 'Track2'

  IF @ProcesadorTrans = 'BANORTE' 
  BEGIN
    SELECT @FechaFin = dbo.fnTCBanorteFecha(TCHashTableTransaccion.Valor) FROM TCHashTableTransaccion JOIN TCHashTableDefinicion ON TCHashTableTransaccion.Columna = TCHashTableDefinicion.Columna WHERE Estacion = @Estacion AND ProcesadorTrans = @ProcesadorTrans AND TCHashTableDefinicion.Campo = 'Fecha Fin'
    SELECT @FechaInicio = dbo.fnTCBanorteFecha(TCHashTableTransaccion.Valor) FROM TCHashTableTransaccion JOIN TCHashTableDefinicion ON TCHashTableTransaccion.Columna = TCHashTableDefinicion.Columna WHERE Estacion = @Estacion AND ProcesadorTrans = @ProcesadorTrans AND TCHashTableDefinicion.Campo = 'Fecha Inicio'
    SELECT @FechaExpiracion = SUBSTRING(TCHashTableTransaccion.Valor, 1, 2) + '/' + SUBSTRING(TCHashTableTransaccion.Valor, 3, 2) FROM TCHashTableTransaccion JOIN TCHashTableDefinicion ON TCHashTableTransaccion.Columna = TCHashTableDefinicion.Columna WHERE Estacion = @Estacion AND ProcesadorTrans = @ProcesadorTrans AND TCHashTableDefinicion.Campo = 'Fecha Expiracion'
  END

  INSERT INTO TCTransaccion(
			Modulo,  Accion,  ModuloID,  FormaPago,  Campo,  Importe,  ARQC,  BancoEmisor,  CodigoAutorizacion,  CodigoError,  CodigoProcesador,  E1,  E2,  E3,  Estatus,  FechaExpiracion,  FechaFin,  FechaInicio,  IDOrden,  MensajeError,  MensajeProcesador,  NumeroTarjeta,  SeveridadError,  Tarjetahabiente,  Texto,  TipoOperacion,  TipoTarjeta,  TipoTransaccion,  Total,  Track1,  Track2,  Ok,  OkRef,  TCTipoPlan,  TCNoMeses,  TCDiferirMeses,  CxcID)
	SELECT @Modulo, @Accion, @ID,       @FormaPago, @Campo, @Importe, @ARQC, @BancoEmisor, @CodigoAutorizacion, @CodigoError, @CodigoProcesador, @E1, @E2, @E3, @Estatus, @FechaExpiracion, @FechaFin, @FechaInicio, @IDOrden, @MensajeError, @MensajeProcesador, @NumeroTarjeta, @SeveridadError, @Tarjetahabiente, @Texto, @TipoOperacion, @TipoTarjeta, @TipoTransaccion, @Total, @Track1, @Track2, @Ok, @OkRef, @TCTipoPlan, @TCNoMeses, @TCDiferirMeses, @CxcID

  SELECT @RID = @@IDENTITY
END
GO

--REQ13163
/***************** spTCHashTableTransaccionEliminar *****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spTCHashTableTransaccionEliminar' AND Type = 'P') DROP PROCEDURE spTCHashTableTransaccionEliminar
GO
CREATE PROC spTCHashTableTransaccionEliminar
			@Estacion			int
--//WITH ENCRYPTION
AS
BEGIN
  DELETE TCHashTableTransaccion WHERE Estacion = @Estacion
END
GO

--REQ13163
/***************** spTCActualizarVentaCobro *****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spTCActualizarVentaCobro' AND Type = 'P') DROP PROCEDURE spTCActualizarVentaCobro
GO
CREATE PROC spTCActualizarVentaCobro 
			@Modulo					varchar(5), 
			@ID						int, 
			@RID					int, 
			@CodigoAutorizacion		varchar(255), 
			@FormaPago				varchar(50),
			@Importe				float, 
			@Campo					varchar(50),
			@Accion					varchar(20),
			@Ok						int				OUTPUT,
			@OkRef					varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Estatus		varchar(15)
  
  SELECT @Estatus = Estatus FROM Venta WHERE ID = @ID
  
  IF @Accion = 'VOID'
  BEGIN
    IF @Estatus <> 'CONCLUIDO'
    BEGIN
      IF @Campo = 'FormaCobro1'
        UPDATE VentaCobro SET Referencia1 = '', TCProcesado1 = 0 WHERE ID = @ID
      ELSE IF @Campo = 'FormaCobro2'
        UPDATE VentaCobro SET Referencia2 = '', TCProcesado2 = 0 WHERE ID = @ID  
      ELSE IF @Campo = 'FormaCobro3'
        UPDATE VentaCobro SET Referencia3 = '', TCProcesado3 = 0 WHERE ID = @ID  
      ELSE IF @Campo = 'FormaCobro4'
        UPDATE VentaCobro SET Referencia4 = '', TCProcesado4 = 0 WHERE ID = @ID  
      ELSE IF @Campo = 'FormaCobro5'
        UPDATE VentaCobro SET Referencia5 = '', TCProcesado5 = 0 WHERE ID = @ID  
    END
    ELSE IF @Estatus = 'CONCLUIDO'
    BEGIN
      IF @Campo = 'FormaCobro1'
        UPDATE VentaCobro SET TCProcesado1 = 0 WHERE ID = @ID
      ELSE IF @Campo = 'FormaCobro2'
        UPDATE VentaCobro SET TCProcesado2 = 0 WHERE ID = @ID  
      ELSE IF @Campo = 'FormaCobro3'
        UPDATE VentaCobro SET TCProcesado3 = 0 WHERE ID = @ID  
      ELSE IF @Campo = 'FormaCobro4'
        UPDATE VentaCobro SET TCProcesado4 = 0 WHERE ID = @ID  
      ELSE IF @Campo = 'FormaCobro5'
        UPDATE VentaCobro SET TCProcesado5 = 0 WHERE ID = @ID      
    END
  END
  ELSE
  BEGIN
    IF @Campo = 'FormaCobro1'
      UPDATE VentaCobro SET Referencia1 = @CodigoAutorizacion, TCProcesado1 = 1 WHERE ID = @ID
    ELSE IF @Campo = 'FormaCobro2'
      UPDATE VentaCobro SET Referencia2 = @CodigoAutorizacion, TCProcesado2 = 1 WHERE ID = @ID  
    ELSE IF @Campo = 'FormaCobro3'
      UPDATE VentaCobro SET Referencia3 = @CodigoAutorizacion, TCProcesado3 = 1 WHERE ID = @ID  
    ELSE IF @Campo = 'FormaCobro4'
      UPDATE VentaCobro SET Referencia4 = @CodigoAutorizacion, TCProcesado4 = 1 WHERE ID = @ID  
    ELSE IF @Campo = 'FormaCobro5'
      UPDATE VentaCobro SET Referencia5 = @CodigoAutorizacion, TCProcesado5 = 1 WHERE ID = @ID  
  END
END
GO

--REQ13163
/***************** spTCGenerarAfectarCxc *****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spTCGenerarAfectarCxc' AND Type = 'P') DROP PROCEDURE spTCGenerarAfectarCxc
GO
CREATE PROC spTCGenerarAfectarCxc 
			@Empresa			varchar(5),
			@Modulo				varchar(5),
			@ID					int, 
			@CodigoAutorizacion	varchar(255),
			@FormaPago			varchar(50),
			@Importe			float, 
			@Accion				varchar(20),
			@CancelaRID			int, 
			@Usuario			varchar(10),
			@CxcID				int				OUTPUT, 
			@Ok					int				OUTPUT, 
			@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @CxMov						varchar(20),
		  @FechaEmision					datetime,
          @Estatus						varchar(15),
          @VentaLiquidaIntegralCxc		bit,
          --BUG19945
          @CxEstatus					varchar(15)

  SELECT @Estatus = Estatus FROM Venta WHERE ID = @ID		  
		    
  IF @Accion IN('Auth', 'Credit')
  BEGIN
    SELECT @FechaEmision = GETDATE()
    
    EXEC spExtraerFecha @FechaEmision OUTPUT
    
    IF @Accion = 'Auth'
      SELECT @CxMov = CxcMovAnticipo FROM TCCfg WHERE Empresa = @Empresa
    ELSE IF @Accion = 'Credit'
    BEGIN
      SELECT @VentaLiquidaIntegralCxc = ISNULL(VentaLiquidaIntegralCxc, 0) FROM EmpresaCfg WHERE Empresa = @Empresa

      IF @VentaLiquidaIntegralCxc = 1
        SELECT @CxMov = CxcMovDevolucion FROM TCCfg WHERE Empresa = @Empresa
      ELSE 
        SELECT @CxMov = CxcMovAnticipo FROM TCCfg WHERE Empresa = @Empresa
    END
    
    INSERT INTO Cxc(
			  Empresa, Cliente,   ClienteEnviarA, Agente,    Mov,    TarjetaBancariaAutorizacion,  Importe, Impuestos, Proyecto,   Moneda,    FechaEmision, TipoCambio,    Usuario, Estatus,      ClienteMoneda, ClienteTipoCambio,             CtaDinero,       Vencimiento,   FormaCobro, Sucursal)
      SELECT @Empresa, v.Cliente, v.EnviarA,      v.Agente, @CxMov, @CodigoAutorizacion,          @Importe, 0,         v.Proyecto, v.Moneda, @FechaEmision, v.TipoCambio, @Usuario, 'SINAFECTAR', c.DefMoneda,   dbo.fnTipoCambio(c.DefMoneda), u.DefCtaDinero, @FechaEmision, @FormaPago,  v.Sucursal
        FROM Venta v
        JOIN Cte c ON v.Cliente = c.Cliente
        JOIN Usuario u ON u.Usuario = @Usuario
       WHERE v.ID = @ID
        
    SELECT @CxcID = @@IDENTITY
    
    IF @CxcID IS NOT NULL
    BEGIN
      EXEC spAfectar 'CXC', @CxcID, 'AFECTAR', @Usuario = @Usuario, @Conexion = 1, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      
      IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
        UPDATE VentaCobro SET TCDelEfectivo = ISNULL(TCDelEfectivo, 0) + ISNULL(@Importe, 0) WHERE ID = @ID
    END
  END
  ELSE IF @Accion = 'Void'
  BEGIN
    SELECT @CxcID = CxcID FROM TCTransaccion WHERE RID = @CancelaRID

    --BUG19945
    SELECT @CxEstatus = Estatus FROM Cxc WHERE ID = @CxcID 
    
    IF @CxcID IS NOT NULL
    BEGIN
      --BUG19945
      IF @CxEstatus IN('PENDIENTE', 'CONCLUIDO')
        EXEC spAfectar 'CXC', @CxcID, 'CANCELAR', @Usuario = @Usuario, @Conexion = 1, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

      IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      BEGIN
        IF @Estatus <> 'CONCLUIDO' 
          UPDATE VentaCobro SET TCDelEfectivo = ISNULL(TCDelEfectivo, 0) - ISNULL(@Importe, 0) WHERE ID = @ID      
      END
    END    
  END
  
  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
    SELECT @Ok = NULL, @OkRef = NULL
END
GO

--REQ13163
/***************** spTCLeerXML *****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spTCLeerXML' AND Type = 'P') DROP PROCEDURE spTCLeerXML
GO
CREATE PROC spTCLeerXML 
			@Empresa			varchar(5), 
			@Sucursal			int, 
			@Estacion			int, 
			@Modulo				varchar(5), 
			@ID					int, 
			@Accion				varchar(20), 
			@CancelaRID			int, 
			@FormaPago			varchar(50),
		    @Importe			float,
			@Campo				varchar(50), 
			@IDOrden			varchar(255), 
			@RutaArchivosXML	varchar(255),
			@Ok					int				OUTPUT, 
			@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @XML				varchar(max),
		  @ManejadorObjeto	int,
		  @IDArchivo		int,
		  @Archivo			varchar(255),
		  @iDatos			int

  SELECT @Archivo = dbo.fnDirectorioEliminarDiagonalFinal(ISNULL(@RutaArchivosXML, '')) + '\Procesamiento' + CONVERT(varchar(max), @Estacion) + '.xml'

  EXEC spLeerArchivo @Archivo, @Archivo = @XML OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT    

  EXEC sp_xml_preparedocument @iDatos OUTPUT, @XML

  INSERT INTO TCHashTableTransaccion(
		  Estacion,  Modulo,  ModuloID,  FormaPago,  Importe, Columna, Valor)
  SELECT @Estacion, @Modulo, @ID,       @FormaPago, @Importe, Columna, Valor
    FROM OPENXML (@iDatos, '/IntelisisTC/Procesamiento', 3)
    WITH (Columna varchar(50), Valor varchar(255))

  EXEC sp_xml_removedocument @iDatos 
END
GO

--REQ13163
/***************** spTCGenerarXML *****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spTCGenerarXML' AND Type = 'P') DROP PROCEDURE spTCGenerarXML
GO
CREATE PROC spTCGenerarXML 
			@Empresa			varchar(5), 
			@Sucursal			int, 
			@Estacion			int, 
			@Modulo				varchar(5), 
			@ID					int, 
			@Accion				varchar(20), 
			@CancelaRID			int, 
			@FormaPago			varchar(50),
		    @Importe			float,
			@Campo				varchar(50), 
			@IDOrden			varchar(255), 
			@RutaArchivosXML	varchar(255),
			@Referencia			varchar(50),
			@Usuario			varchar(10),
			@Ok					int				OUTPUT, 
			@OkRef				varchar(255)	OUTPUT,
			@ArchivoCfg			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @XML				varchar(max),
		  @XMLCfg			varchar(max),
		  @XMLTransaccion	varchar(max),
		  @ManejadorObjeto	int,
		  @IDArchivo		int

  SELECT @ManejadorObjeto = NULL, @IDArchivo = NULL, @ArchivoCfg = dbo.fnDirectorioEliminarDiagonalFinal(ISNULL(@RutaArchivosXML, '')) + '\Peticion' + CONVERT(varchar(max), @Estacion) + '.xml'
  
  EXEC spTCCfg @Empresa, @Sucursal, @Estacion, @Usuario, @XMLCfg OUTPUT
  
  EXEC spTCObtenerDatosTransaccion @Modulo, @ID, @FormaPago, @Importe, @Accion, @CancelaRID, @Sucursal, @Estacion, @Campo, @Referencia, @XMLTransaccion OUTPUT

  SELECT @XML = '<IntelisisTC>' + @XMLCfg + @XMLTransaccion + '</IntelisisTC>'

  IF @Ok IS NULL
    EXEC spCrearRuta @RutaArchivosXML, @Ok OUTPUT, @OkRef OUTPUT    
    
  IF @Ok IS NULL
    EXEC spCrearArchivo @ArchivoCfg, @ManejadorObjeto OUTPUT, @IDArchivo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT    
  
  IF @Ok IS NULL  
    EXEC spInsertaEnArchivo @IDArchivo, @XML, @Ok OUTPUT, @OkRef OUTPUT  
    
  IF @Ok IS NULL
    EXEC spCerrarArchivo @IDArchivo, @ManejadorObjeto, @Ok OUTPUT, @OkRef OUTPUT  
END
GO

--BUG16817
/***************** spTCVerificarPinPad *****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spTCVerificarPinPad' AND Type = 'P') DROP PROCEDURE spTCVerificarPinPad
GO
CREATE PROC spTCVerificarPinPad
			@Empresa	varchar(5),
			@Modulo		varchar(5),
			@ID			int,
			@Sucursal	int,
			@Estacion	int,
			@Accion		varchar(20),
			@Usuario	varchar(10),
			@CancelaRID	int				= NULL,
			@Ok			int				= NULL OUTPUT,
			@OkRef		varchar(255)	= NULL OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @MonedaCodigoNumerico varchar(10),
		  @Moneda				varchar(10),
          --BUG19945
		  @CxcID				int,
		  @DinEstatus			varchar(15),
		  @DinMov				varchar(20),
		  @DinMovID				varchar(20),	
		  @Clave                varchar(20) --BUG20668
  
  IF @Modulo='VTAS'
  BEGIN
	--BUG19759
    EXEC spAfectar 'VTAS', @ID, 'VERIFICAR', @EnSilencio=1, @Ok=@Ok Output, @OkRef=@OkRef Output
    
    IF @Ok = 8 SELECT @Ok = NULL, @OkRef = NULL --BUG19759
    
	IF @Ok IS NULL
	BEGIN
	  SELECT @MonedaCodigoNumerico=CAST(MonCodigoInternacional.CodigoNumerico as varchar(10)), 
	  		 @Moneda=Venta.Moneda
		FROM Venta
		JOIN Mon ON Venta.Moneda = Mon.Moneda
		LEFT OUTER JOIN MonCodigoInternacional ON Mon.Moneda = MonCodigoInternacional.Moneda
		WHERE Venta.Empresa=@Empresa 
		AND Venta.ID = @ID 
		AND Venta.Sucursal=@Sucursal 
  
	  IF @MonedaCodigoNumerico IS NULL OR @MonedaCodigoNumerico='' OR @MonedaCodigoNumerico='0'
	  BEGIN
		SELECT @Ok = 35065, @OkRef = @Moneda			
	  END
	
	  --BUG19945
	  IF @Ok IS NULL
	  BEGIN
		SELECT @CxcID = CxcID FROM TCTransaccion WHERE RID = @CancelaRID
	 	 
		SELECT @DinEstatus = d.Estatus,
			@DinMov		= d.Mov, 
			@DinMovID   = d.MovID,
			@Clave      = m.Clave --BUG20668
		FROM Cxc o
		JOIN Dinero d ON d.OrigenTipo = 'CXC' AND d.Origen = o.Mov AND d.OrigenID = o.MovID AND d.Empresa = o.Empresa
		JOIN MovTipo m ON m.Modulo='DIN' AND m.Mov=d.Mov  --BUG20668
		WHERE o.ID = @CxcID
	 
		IF @DinEstatus = 'CONCLUIDO' and @Clave in ('DIN.SD','DIN.SCH') --BUG20668
		SELECT @Ok = 60060, @OkRef = RTRIM(@DinMov) + ' '+@DinMovID
	  END
	END

   END
END
GO

-- EXEC spTCAfectarPinPad 'DEMO', 'VTAS', 40, 0, '1', 'Auth', 'DEMO'
--REQ13163
/***************** spTCAfectarPinPad *****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spTCAfectarPinPad' AND Type = 'P') DROP PROCEDURE spTCAfectarPinPad
GO
CREATE PROC spTCAfectarPinPad
			@Empresa	varchar(5),
			@Modulo		varchar(5),
			@ID			int,
			@Sucursal	int,
			@Estacion	int,
			@Accion		varchar(20),
			@Usuario	varchar(10),
			@CancelaRID	int				= NULL,
			@Ok			int				= NULL OUTPUT,
			@OkRef		varchar(255)	= NULL OUTPUT,
            --BUG19945
			@Generar	bit				= 0
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @RutaArchivosXML		varchar(255),
		  @Ubicacion			varchar(255),
		  @FormaPago			varchar(50),
		  @Importe				float,
		  @Campo				varchar(50),
		  @OkDesc				varchar(255),
		  @OkTipo				varchar(50),
		  @RID					int,
		  @ProcesadorTrans		varchar(15),
		  @CodigoAutorizacion	varchar(255),
		  @IDOrden				varchar(255),
		  @CxcID				int,
		  @ArchivoCfg			varchar(255),
		  @ArchivoProceso		varchar(255),
		  @Referencia			varchar(50),
		  @MonedaCodigoNumerico varchar(5),
		  @Moneda				varchar(5),
          --BUG19945
		  @Shell				varchar(max)

  --BUG16817 --BUG19945
  EXEC spTCVerificarPinPad @Empresa, @Modulo, @ID, @Sucursal, @Estacion, @Accion, @Usuario, @CancelaRID, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
 		    
  SELECT @Ubicacion			= ISNULL(Ubicacion, ''),
		 @RutaArchivosXML	= ISNULL(RutaArchivosXML, ''),
		 @ProcesadorTrans = dbo.fnTCProcesadorTransCfg(@Empresa, @Sucursal)
    FROM TCCfg
   WHERE Empresa = @Empresa
  
  --BUG19945
  SELECT @ArchivoProceso = dbo.fnDirectorioEliminarDiagonalFinal(ISNULL(@RutaArchivosXML, '')) + '\Procesamiento' + CONVERT(varchar(max), @Estacion) + '.xml'
 
  DELETE TCEstacionTransaccion WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND Estacion = @Estacion
  
  BEGIN TRANSACTION

  --BUG19945
  IF @Ok IS NULL
    EXEC spTCObtenerFormasPago @Empresa, @Modulo, @ID, @Sucursal, @Estacion, @Accion, @CancelaRID, @FormaPago OUTPUT, @Importe OUTPUT, @Campo OUTPUT, @IDOrden OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @Referencia = @Referencia OUTPUT
  	  
  IF @Generar = 1
  BEGIN
    --IF @Accion = 'Void' AND @Ok IS NULL
    --  EXEC spTCGenerarAfectarCxc @Empresa, @Modulo, @ID, @CodigoAutorizacion, @FormaPago, @Importe, @Accion, @CancelaRID, @Usuario, @CxcID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        
    --BUG19945
    IF @Ok IS NULL
      EXEC spEliminarArchivo @ArchivoCfg, @Ok OUTPUT, @OkRef OUTPUT    

    --BUG19945
    IF @Ok IS NULL
      EXEC spEliminarArchivo @ArchivoProceso, @Ok OUTPUT, @OkRef OUTPUT          

    IF @Ok IS NULL
      EXEC spTCHashTableTransaccionEliminar @Estacion

    IF @Ok IS NULL  
      EXEC spTCGenerarXML @Empresa, @Sucursal, @Estacion, @Modulo, @ID, @Accion, @CancelaRID, @FormaPago, @Importe, @Campo, @IDOrden, @RutaArchivosXML, @Referencia, @Usuario, @Ok OUTPUT, @OkRef OUTPUT, @ArchivoCfg OUTPUT

    --BUG19945
    IF @Ok IS NULL
      EXEC spTCShellAplicacion @Ubicacion, @RutaArchivosXML, @ArchivoCfg, @Shell OUTPUT
  END
  ELSE IF @Generar = 0
  BEGIN
    IF @Ok IS NULL
      EXEC spTCLeerXML @Empresa, @Sucursal, @Estacion, @Modulo, @ID, @Accion, @CancelaRID, @FormaPago, @Importe, @Campo, @IDOrden, @RutaArchivosXML, @Ok OUTPUT, @OkRef OUTPUT

    IF @Ok IS NULL
      EXEC spTCValidarTransaccion @Estacion, @Modulo, @ID, @FormaPago, @Importe, @Campo, @ProcesadorTrans, @Accion, @CxcID, @CodigoAutorizacion OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  
    IF @Ok IS NULL
      EXEC spTCGenerarAfectarCxc @Empresa, @Modulo, @ID, @CodigoAutorizacion, @FormaPago, @Importe, @Accion, @CancelaRID, @Usuario, @CxcID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

    IF @Ok IS NULL
      EXEC spTCActualizarVentaCobro @Modulo, @ID, @RID, @CodigoAutorizacion, @FormaPago, @Importe, @Campo, @Accion, @Ok OUTPUT, @OkRef OUTPUT

    IF @Ok IS NULL
      EXEC spTCRegistrarTransaccion @Estacion, @Modulo, @ID, @FormaPago, @Importe, @Campo, @ProcesadorTrans, @Accion, @CxcID, @RID OUTPUT, @CodigoAutorizacion OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

    INSERT INTO TCEstacionTransaccion(Empresa, Sucursal, Estacion, RID) VALUES(@Empresa, @Sucursal, @Estacion, @RID)
  END
  
  IF @Ok IS NULL
    COMMIT TRANSACTION
  ELSE
    ROLLBACK TRANSACTION
  
  SELECT @OkDesc = Descripcion, 
         @OkTipo = Tipo
    FROM MensajeLista
   WHERE Mensaje = @Ok  
  
  --BUG19945
  IF @Generar = 1
  BEGIN
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      SELECT @Shell
    ELSE
      SELECT 'Error<BR><BR>' + ISNULL(@OkDesc, '') + '<BR><BR>' + ISNULL(@OkRef, '')
  END
  ELSE IF @Generar = 0
    -- Mostrar el Estatus de la Afectacion
    SELECT @Ok, @OkDesc, @OkTipo, @OkRef, @RID
  
  RETURN ISNULL(@RID, 0)
END
GO

--REQ13163
/***************** spTCHashTableTransaccion *****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spTCHashTableTransaccion' AND Type = 'P') DROP PROCEDURE spTCHashTableTransaccion
GO
CREATE PROC spTCHashTableTransaccion
			@Estacion			int,
			@Modulo				varchar(5),
			@ModuloID			int,
			@FormaPago			varchar(50),
			@Importe			float,
			@Columna			varchar(255) = NULL,
			@Valor				varchar(255) = NULL
--//WITH ENCRYPTION
AS
BEGIN
  INSERT INTO TCHashTableTransaccion(
			Estacion,  Modulo,  ModuloID,  FormaPago,  Importe,  Columna,  Valor)
	SELECT @Estacion, @Modulo, @ModuloID, @FormaPago, @Importe, @Columna, @Valor
END
GO

--REQ13163
/**************** TCVentaCobroAdministrar ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'TCVentaCobroAdministrar' AND type = 'TF') DROP FUNCTION TCVentaCobroAdministrar
GO
CREATE FUNCTION TCVentaCobroAdministrar (@Modulo char(5), @ModuloID int)
RETURNS @Resultado
  TABLE (RID int, Modulo varchar(5), ModuloID int, FormaPago varchar(50), Campo varchar(50), Importe float, Estatus varchar(20), ARQC varchar(255), BancoEmisor varchar(255), 
		 CodigoAutorizacion varchar(255), CodigoError varchar(255), CodigoProcesador varchar(255), E1 varchar(255), E2 varchar(255), E3 varchar(255), EstatusProceso varchar(255), 
		 FechaExpiracion varchar(5), FechaFin datetime, FechaInicio datetime, IDOrden varchar(255), MensajeError varchar(255), MensajeProcesador varchar(255), NumeroTarjeta varchar(4), 
		 SeveridadError varchar(255), Tarjetahabiente varchar(255), Texto varchar(255), TipoOperacion varchar(255), TipoTarjeta varchar(255), TipoTransaccion varchar(255), 
		 Total float, Track1 varchar(255), Track2 varchar(255), Ok int, OkRef varchar(255), TCTipoPlan varchar(20), TCNoMeses int, TCDiferirMeses int, MovEstatus varchar(15), Icono int)
		 
--//WITH ENCRYPTION
AS BEGIN
  INSERT INTO @Resultado(
			RID, Modulo, ModuloID, FormaPago, Campo,                                        Importe, ARQC, BancoEmisor, CodigoAutorizacion, CodigoError, CodigoProcesador, E1, E2, E3, EstatusProceso, FechaExpiracion, FechaFin, FechaInicio, IDOrden, MensajeError, MensajeProcesador, NumeroTarjeta,           SeveridadError, Tarjetahabiente, Texto, TipoOperacion, TipoTarjeta, TipoTransaccion, Total, Track1, Track2, Ok, OkRef, TCTipoPlan, TCNoMeses, TCDiferirMeses, Estatus,                                                                                                        Icono)
	 SELECT RID, Modulo, ModuloID, FormaPago, REPLACE(Campo, 'FormaCobro', 'Forma Cobro '), Importe, ARQC, BancoEmisor, CodigoAutorizacion, CodigoError, CodigoProcesador, E1, E2, E3, Estatus,        FechaExpiracion, FechaFin, FechaInicio, IDOrden, MensajeError, MensajeProcesador, RIGHT(NumeroTarjeta, 4), SeveridadError, Tarjetahabiente, Texto, TipoOperacion, TipoTarjeta, TipoTransaccion, Total, Track1, Track2, Ok, OkRef, TCTipoPlan, TCNoMeses, TCDiferirMeses, CASE Accion WHEN 'Auth' THEN 'Autorizacion' WHEN 'Void' THEN 'Cancelacion' WHEN 'Credit' THEN 'Devolucion' END, CASE Accion WHEN 'Auth' THEN 339 WHEN 'Void' THEN 416 WHEN 'Credit' THEN 339 END
	   FROM TCTransaccion
	  WHERE Ok IS NULL
	    AND Modulo = @Modulo
	    AND ModuloID = @ModuloID

  UPDATE r
     SET MovEstatus = v.Estatus
    FROM @Resultado r
    JOIN Venta v ON r.Modulo = 'VTAS' AND r.ModuloID = v.ID

  RETURN
END
GO

/***************** spTCDevolucion *****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spTCDevolucion' AND Type = 'P') DROP PROCEDURE spTCDevolucion
GO
CREATE PROC spTCDevolucion
			@Empresa		varchar(5),
			@Sucursal		int,
			@Estacion		int,
			@FormaPago		varchar(50),
			@Modulo			varchar(5),
			@ModuloID		int
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Cliente		varchar(10)
  
  DELETE TCDevolucion WHERE Estacion = @Estacion
  DELETE TCEstacionTransaccion WHERE Estacion = @Estacion
  
  IF @Modulo = 'VTAS'
  BEGIN
    SELECT @Cliente = Cliente FROM Venta WHERE ID = @ModuloID
  
    INSERT INTO TCDevolucion(
		     Estacion, IDTransaccion, Modulo,   ModuloID,   IDOrden)
     SELECT @Estacion, t.RID,         t.Modulo, t.ModuloID, t.IDOrden
       FROM TCTransaccion t
       JOIN Venta v ON t.ModuloID = v.ID AND t.Modulo = 'VTAS'
      WHERE v.Cliente = @Cliente
        AND t.Ok IS NULL
        AND t.Accion = 'Auth'
        AND v.Empresa = @Empresa
        AND t.FormaPago = @FormaPago
  END
  
  DELETE TCDevolucion
    FROM TCDevolucion
    JOIN TCTransaccion ON TCDevolucion.IDOrden = TCTransaccion.IDOrden
   WHERE TCTransaccion.Accion = 'Void'
     AND Ok IS NULL
     
  RETURN
END
GO

/***************** spTCAfectarDevolucion *****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spTCAfectarDevolucion' AND Type = 'P') DROP PROCEDURE spTCAfectarDevolucion
GO
CREATE PROC spTCAfectarDevolucion
			@Empresa		varchar(5),
			@Sucursal		int,
			@Estacion		int,
			@FormaPago		varchar(50),
			@Modulo			varchar(5),
			@ModuloID		int,
			@Usuario		varchar(10),
			@Importe		float,
			@IDOrden		varchar(255),
			@Campo			varchar(50),
			@Ok				int				= NULL OUTPUT,
			@OkRef			varchar(255)	= NULL OUTPUT,
			@Generar	    bit				= 0
--//WITH ENCRYPTION
AS
BEGIN
  IF @Campo = 'FormaCobro1'
    UPDATE VentaCobro SET Importe1 = @Importe, Referencia1 = @IDOrden WHERE ID = @ModuloID
  ELSE IF @Campo = 'FormaCobro2'
    UPDATE VentaCobro SET Importe2 = @Importe, Referencia2 = @IDOrden WHERE ID = @ModuloID
  ELSE IF @Campo = 'FormaCobro3'
    UPDATE VentaCobro SET Importe3 = @Importe, Referencia3 = @IDOrden WHERE ID = @ModuloID
  ELSE IF @Campo = 'FormaCobro4'
    UPDATE VentaCobro SET Importe4 = @Importe, Referencia4 = @IDOrden WHERE ID = @ModuloID
  ELSE IF @Campo = 'FormaCobro5'
    UPDATE VentaCobro SET Importe5 = @Importe, Referencia5 = @IDOrden WHERE ID = @ModuloID

  EXEC spTCAfectarPinPad @Empresa, @Modulo, @ModuloID, @Sucursal, @Estacion, 'Credit', @Usuario, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @Generar = @Generar

  RETURN
END
GO