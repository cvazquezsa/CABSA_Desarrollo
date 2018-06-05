SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF
SET ANSI_WARNINGS OFF
GO


/*************************** LDI *****************************/
---- Registros de Prueba
--  -- Empresa
--IF NOT EXISTS(SELECT * FROM  Empresa WHERE Empresa = 'DEMO' AND)
--  INSERT  LDIEmpresa (Empresa, EmpresaLDI) 
--                VALUES ('DEMO',  '1') 
         
--  -- Sucursal
--IF NOT EXISTS(SELECT * FROM  LDISucursal WHERE Empresa = 'DEMO' AND Sucursal = 0)
--  INSERT  LDISucursal (Empresa, Sucursal, SucursalLDI) 
--                 VALUES ('DEMO',  '0',	    '31') 

                 

--De Monedero
IF NOT EXISTS(SELECT * FROM  LDIServicio WHERE Servicio = 'MON ALTA NUEVO')
  INSERT  LDIServicio (Servicio,        DireccionIP,     Puerto, TrxType, TrxSubType, EntryMode, GeneraVoucher, AnchoVoucher, Tipo)
		 VALUES ('MON ALTA NUEVO', '200.94.104.94', '9899', '261',  0,          NULL,      'N',           NULL,         0)                       

IF NOT EXISTS(SELECT * FROM  LDIServicio WHERE Servicio = 'MON CONSULTA')
  INSERT  LDIServicio (Servicio,            DireccionIP,     Puerto,  TrxType, TrxSubType, EntryMode, GeneraVoucher, AnchoVoucher, Tipo)
		 VALUES ('MON CONSULTA', '200.94.104.94',      '9899', '265',    0,          NULL,      'S',           NULL,         0)  
		 
IF NOT EXISTS(SELECT * FROM LDIServicio WHERE Servicio = 'MON ALTA MODIFICA')
  INSERT LDIServicio (Servicio,            DireccionIP,     Puerto, TrxType, TrxSubType, EntryMode, GeneraVoucher, AnchoVoucher, Tipo)
		 VALUES ('MON ALTA MODIFICA', '200.94.104.94', '9899', '261',   1,          NULL,      'N',           NULL,         0)                       

IF NOT EXISTS(SELECT * FROM LDIServicio WHERE Servicio = 'MON ALTA REEMPLAZO')
  INSERT LDIServicio (Servicio,            DireccionIP,     Puerto,  TrxType, TrxSubType, EntryMode, GeneraVoucher, AnchoVoucher, Tipo)
		 VALUES ('MON ALTA REEMPLAZO', '200.94.104.94', '9899', '261',   2,          NULL,      'N',           NULL,         0)                       
		                      

IF NOT EXISTS(SELECT * FROM  LDIServicio WHERE Servicio = 'MON CARGO')
  INSERT  LDIServicio (Servicio,    DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo, ServicioInverso, POSForma)
		 VALUES ('MON CARGO', '200.94.104.94', '9899', '263',    NULL,          NULL,      'N',           NULL,         0,  'MON ABONO',      'POSCobroMonedero')                       

IF NOT EXISTS(SELECT * FROM  LDIServicio WHERE Servicio = 'MON ABONO')
  INSERT  LDIServicio (Servicio,    DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo, ServicioInverso, POSForma)
		 VALUES ('MON ABONO', '200.94.104.94', '9899', '262',    NULL,          NULL,      'N',           NULL,         0,  'MON CARGO',      'POSCobroMonedero')                       		 


--De Recarga de Telefonos
IF NOT EXISTS(SELECT * FROM  LDIServicio WHERE Servicio = 'TELCEL')
  INSERT  LDIServicio (Servicio, DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo, POSForma)
		 VALUES ('TELCEL', '200.94.104.94', '9899',  '96',    NULL,          NULL,      'N',           NULL,         0,  'POSNoTelefono')                       		 

IF NOT EXISTS(SELECT * FROM  LDIServicio WHERE Servicio = 'IUSACELL')
  INSERT  LDIServicio (Servicio,   DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo, POSForma)
		 VALUES ('IUSACELL', '200.94.104.94', '9899',  '51',    NULL,          NULL,      'N',           NULL,         0,  'POSNoTelefono')

IF NOT EXISTS(SELECT * FROM  LDIServicio WHERE Servicio = 'UNEFON')
  INSERT  LDIServicio (Servicio,   DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo, POSForma)
		 VALUES ('UNEFON', '200.94.104.94', '9899',   '51',     '1',          NULL,      'N',           NULL,         0,  'POSNoTelefono')

IF NOT EXISTS(SELECT * FROM  LDIServicio WHERE Servicio = 'MOVISTAR')
  INSERT  LDIServicio (Servicio,   DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo, POSForma)
		 VALUES ('MOVISTAR', '200.94.104.94', '9899',   '71',   NULL,          NULL,      'N',           NULL,         0,  'POSNoTelefono')

IF NOT EXISTS(SELECT * FROM  LDIServicio WHERE Servicio = 'NEXTEL')
  INSERT  LDIServicio (Servicio,   DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo, POSForma)
		 VALUES ('NEXTEL', '200.94.104.94', '9899',   '611',    1,          NULL,      'N',           NULL,         0,  'POSNoTelefono')
		 
		 
IF NOT EXISTS(SELECT * FROM  LDIServicio WHERE Servicio = 'TELMEX')
  INSERT  LDIServicio (Servicio,   DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo, POSForma)
		 VALUES ('TELMEX', '200.94.104.94', '9899',   '611',    150,          NULL,      'N',           NULL,         0,   'POSLDIServicios')	
		 
IF NOT EXISTS(SELECT * FROM  LDIServicio WHERE Servicio = 'CFE')
  INSERT  LDIServicio (Servicio,   DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo, POSForma)
		 VALUES ('CFE', '200.94.104.94', '9899',   '611',    100,          NULL,      'N',           NULL,         0, 'POSLDIServicios')		 	 

IF NOT EXISTS(SELECT * FROM  LDIServicio WHERE Servicio = 'SKY')
  INSERT  LDIServicio (Servicio,   DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo, POSForma)
		 VALUES ('SKY', '200.94.104.94', '9899',   '611',    250,          NULL,      'N',           NULL,         0,'POSLDIServicios')			 
IF NOT EXISTS(SELECT * FROM  LDIServicio WHERE Servicio = 'INFONAVIT')
  INSERT  LDIServicio (Servicio,   DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo, POSForma)
		 VALUES ('INFONAVIT', '200.94.104.94', '9899',   '611',    1700,          NULL,      'N',           NULL,         0, 'POSLDIServicios')			 
IF NOT EXISTS(SELECT * FROM  LDIServicio WHERE Servicio = 'MEGACABLE')
  INSERT  LDIServicio (Servicio,   DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo,POSForma)
		 VALUES ('MEGACABLE', '200.94.104.94', '9899',   '611',    300,          NULL,      'N',           NULL,         0, 'POSLDIServicios')			 
		 
IF NOT EXISTS(SELECT * FROM  LDIServicio WHERE Servicio = 'GAS NAT DE MEXICO')
  INSERT  LDIServicio (Servicio,   DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo, POSForma)
		 VALUES ('GAS NAT DE MEXICO', '200.94.104.94', '9899',   '611',    1750,          NULL,      'N',           NULL,         0, 'POSLDIServicios')			 
IF NOT EXISTS(SELECT * FROM  LDIServicio WHERE Servicio = 'CABLEMAS')
  INSERT  LDIServicio (Servicio,   DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo, POSForma)
		 VALUES ('CABLEMAS', '200.94.104.94', '9899',   '611',    800,          NULL,      'N',           NULL,         0, 'POSLDIServicios')
		 
IF NOT EXISTS(SELECT * FROM LDIServicio WHERE Servicio = 'TDCLDI')
  INSERT LDIServicio (Servicio,      DireccionIP,       Puerto, TrxType, TrxSubType, EntryMode, GeneraVoucher, AnchoVoucher, Tipo,  POSForma)
              VALUES ('TDCLDI', '192.168.148.128', '3000', '401',   NULL,       NULL,      'S',           NULL,         0,     'POSLDIPinPad')  		 		 		 
IF  EXISTS(SELECT * FROM LDIServicio WHERE Servicio = 'SANTANDERPP')     
  DELETE LDIServicio WHERE Servicio = 'SANTANDERPP'
GO         
              
              
IF NOT EXISTS(SELECT * FROM LDIServicio WHERE Servicio = 'EDOCTAMES')
  INSERT LDIServicio (Servicio,     DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo)
		 VALUES ('EDOCTAMES', '200.94.104.94', '9899',   '267',    0,             NULL,      'N',           NULL,         0)	
		 
IF NOT EXISTS(SELECT * FROM LDIServicio WHERE Servicio = 'EDOCTAPERIODO')
  INSERT LDIServicio (Servicio,     DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo)
		 VALUES ('EDOCTAPERIODO', '200.94.104.94', '9899',   '267',    1,             NULL,      'N',           NULL,         0)		 	 		 
		 		 


GO
 
 
/**************** fnLDISeparaCadena ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnLDISeparaCadena') DROP FUNCTION fnLDISeparaCadena
GO
CREATE FUNCTION fnLDISeparaCadena 
	(
	@Expresion				varchar(max)
	)
RETURNS @Tabla TABLE (Parametro varchar(max), Valor varchar(max),Cadena varchar(max))
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			varchar(max),
    @Longitud			bigint,
    @Contador			bigint,
    @Caracter			char(1),
    @Estado			int,
    @EstadoAnterior		int,
    @Variable			varchar(max),
    @Valor			varchar(max),
    @Tipo			varchar(50),
    @Posicion                   int,
    @IDOpcion                   int,
    @Cadena                     varchar(max),
    @Lcadena                    int,
    @PosicionCaracter           int
    
  SET @Resultado = ''
  SELECT @Expresion = REPLACE(REPLACE(@Expresion,'{',''),'}','')  
  IF NULLIF(@Expresion,'') IS NULL RETURN 

  SET @Longitud = LEN(@Expresion)
  SET @Contador = 1
  SET @Estado = 0
  SET @Variable = ''
  
  
  WHILE @Contador <= @Longitud 
  BEGIN
    SET @EstadoAnterior = @Estado
    SET @Caracter = SUBSTRING(@Expresion,@Contador,1)
    IF @Estado = 0 AND @Caracter =';'   SET @Estado =1
    IF @Estado = 0 AND @Contador = @Longitud SET @Estado =3

    IF @Estado IN( 0,3) 
    SELECT @Variable = @Variable + @Caracter
    
    IF  @Estado IN( 1,3)
    BEGIN

      INSERT @Tabla(Cadena )
      SELECT       @Variable

      SET @Estado = 0
      SELECT @Variable = ''
    END     
    SET @Contador = @Contador + 1
  END 
    UPDATE @Tabla SET Parametro = SUBSTRING(Cadena,1,CHARINDEX(':',Cadena)-1)
     
    UPDATE @Tabla SET Valor = REPLACE(Cadena,Parametro+':','')
     
  RETURN 
END
GO

/**************** fnLDIFecha ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnLDIFecha') DROP FUNCTION fnLDIFecha
GO
CREATE FUNCTION dbo.fnLDIFecha
(@Cadena varchar(20))
 RETURNS varchar(20)
--//WITH ENCRYPTION

AS BEGIN
DECLARE 
  @FechaHora varchar(32), @Fecha char(8), @Hora char(6)

  SELECT @Fecha = SUBSTRING(@Cadena,1,8),       @Hora = SUBSTRING(@Cadena,9,6)
  SELECT @FechaHora = CONVERT(varchar, CONVERT(datetime, @Fecha), 111)+ ' ' + SUBSTRING(@Hora, 1, 2)+ ':' + SUBSTRING(@Hora, 3, 2)+ ':' + SUBSTRING(@Hora, 5, 2)


 RETURN @FechaHora
 END
go

/**************** fnLDIVentaExiste ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnLDIVentaExiste') DROP FUNCTION fnLDIVentaExiste
GO
CREATE FUNCTION dbo.fnLDIVentaExiste
( @ID int, @Modulo varchar(10))
 RETURNS bit
--//WITH ENCRYPTION

AS BEGIN
DECLARE 
@Resultado bit

  SET @Resultado =0
  IF EXISTS(SELECT *   FROM  LDIMovLog WHERE Modulo = @Modulo AND  IDModulo = @ID)
    SET @Resultado = 1

 RETURN @Resultado
 END
go

/************************ spLDIAnalizaCadena *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spLDIAnalizaCadena') AND type = 'P') DROP PROCEDURE dbo.spLDIAnalizaCadena
GO             
CREATE PROCEDURE spLDIAnalizaCadena
	     @Cadena		nvarchar(2048),
	     @NumeroCampo	varchar(10),
	     @Valor		nvarchar(2048) OUTPUT
--//WITH ENCRYPTION	     
AS BEGIN
  DECLARE @CaracterInicial	int,
	  @CaracterFinal	int,
	  @Separador		varchar(1),
	  @CadenaTruncada	nvarchar(2048)
  	 
  SELECT @NumeroCampo = @NumeroCampo + ':',
	 @Separador = ';'
  
  SELECT @Cadena = REPLACE(@Cadena, '}', '')	  
  
  SELECT @CaracterInicial = CHARINDEX(@NumeroCampo, @Cadena) + LEN(@NumeroCampo)
  IF @CaracterInicial < 0 SELECT @CaracterInicial = 2048
  
  SELECT @CadenaTruncada = SUBSTRING(@Cadena, @CaracterInicial, 2048)
  SELECT @CaracterFinal = CHARINDEX(@Separador, @CadenaTruncada) -  LEN(@Separador)
  
  IF @CaracterFinal < 0 SELECT @CaracterFinal = 2048
  SELECT @CadenaTruncada = SUBSTRING(@CadenaTruncada, 1, ISNULL(@CaracterFinal, 1))
 
  SELECT @Valor = @CadenaTruncada
END
GO

	     
/************************ spLDIGeneraCadena *****************************/
--Jimmy
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spLDIGeneraCadena') AND type = 'P') DROP PROCEDURE dbo.spLDIGeneraCadena
GO             
CREATE PROCEDURE spLDIGeneraCadena
	     @Servicio			varchar(20),
	     @ID			varchar(36),
	     @NoTarjeta			varchar(36),
	     @NoTarjetaReemplazo	varchar(36),
	     @Cadena			nvarchar(2048) OUTPUT,
	     @Importe			float = NULL,
	     @NoTelefono		varchar(10) = NULL,
	     @Modulo			varchar(5),
	     @Ok			int	OUTPUT,
	     @OkRef			varchar(255) OUTPUT,
	     @Cuenta                    varchar(255) = NULL,
	     @Referencia                varchar(255) = NULL,
	     @EsCancelacion             bit = 0,
	     @EsConsulta                bit = 0,
	     @Empresa                   varchar(5) = NULL,
	     @Sucursal                  int = NULL,
	     @Mes                       varchar(2) = NULL,
	     @Ano                       varchar(4) = NULL,
	     @FechaD                    datetime = NULL,
	     @FechaA                    datetime = NULL	
--//WITH ENCRYPTION	     
AS BEGIN
  DECLARE @Separador		        varchar(1),
	  @CadenaRespuesta	        nvarchar(max),
	  @MensajeError		        nvarchar(MAX),
	  @ReferenciaLDI                varchar(255),
	  @CuentaLDI                    varchar(255),	  
	  @NoTarjetaLDI		        varchar(45),
	  @NoTarjetaReemplazoLDI	varchar(45),
	  @NoTelefonoLDI	        varchar(45),
	  @EmpresaLDI		        varchar(20),
	  @SucursalLDI		        varchar(20),
	  @Caja			        varchar(20),
	  @CajaLDI		        varchar(30),
	  @FechaEmision			datetime,
	  @FechaEmisionLDI		varchar(16),
	  @FechaEmisionEjercicio	varchar(4),
	  @FechaEmisionPeriodo		varchar(2),
	  @FechaEmisionDia		varchar(2),
	  @FechaEmisionHora		varchar(2),
	  @FechaEmisionMinuto		varchar(2),
	  @FechaEmisionSegundo		varchar(2),
	  @Cliente			varchar(20),
	  @ClienteLDI			varchar(20),
	  @MovID			varchar(20),
	  @MovIDLDI			varchar(30),
	  @ImporteLDI			varchar(30),
	  @ServicioLDI			varchar(30),
	  @TrxType			varchar(10),
	  @TrxTypeLDI			varchar(20),
	  @TrxSubType			varchar(10),
	  @TrxSubTypeLDI		varchar(20),
	  @EntryMode			varchar(10),
	  @EntryModeLDI			varchar(20),
	  @GeneraVoucher		varchar(10),
	  @GeneraVoucherLDI		varchar(20),
	  @AnchoVoucher			int,
	  @AnchoVoucherLDI		varchar(20),
	  @Tipo				varchar(20),
	  @TipoLDI			varchar(30),
	  @TransaccionesManuales	varchar(50),
	  @Consulta                     varchar(50),
	  @ConceptoMonedero             varchar(50),
	  @PuntosLDI                    varchar(50),
	  @TrxID                        int,
	  @TrxIDLDI                     varchar(50),
	  @AutCode                      varchar(50),
	  @AutCodeLDI                   varchar(50),
	  @LDIMes                       varchar(50),
	  @LDIAno                       varchar(50),
	  @LDIFechaD                    varchar(50),
	  @LDIFechaA                    varchar(50),
	  @Consecutivo                  varchar(50),
	  @NotasLDI                     varchar(50)
	  
  --Campos comunes en cualquier transaccion
  /* Siempre el separador de campos será ; y el string se abrira con {	   */
  SELECT @Separador = ';',
		 @Cadena = '{'

  /* Aqui jala los campos del movimiento */
  IF @Modulo = 'POS'
  BEGIN
    SELECT @Empresa = pl.Empresa,
 	   @Sucursal = pl.Sucursal,
	   @Caja = ISNULL(NULLIF(CONVERT(varchar,c.ClaveLDI),''),'1'),
	   @FechaEmision = GETDATE(),
	   @MovID ='a'+ pl.MovID,
	   @Cliente = pl.Cliente
      FROM POSL pl LEFT JOIN CtaDinero c ON pl.CtaDinero = c.CtaDinero
     WHERE pl.ID = @ID
   END  
  IF @Modulo = 'VTAS'
  BEGIN
    SELECT @Empresa = v.Empresa,
 	   @Sucursal = v.Sucursal,
	   @Caja = '1',
	   @FechaEmision = GETDATE(),
	   @MovID = v.MovID,
	   @Cliente = v.Cliente
      FROM Venta v LEFT JOIN CtaDinero c ON v.CtaDinero = c.CtaDinero
     WHERE v.ID = @ID
   END   

   IF @Modulo = 'VALE'
   BEGIN
     SELECT @Empresa = n.Empresa,
 	    @Sucursal = n.Sucursal,
	    @Caja = '1',
	    @FechaEmision = GETDATE(),
	    @MovID = n.MovID ,
	    @Cliente = ISNULL(Cliente,''),
	    @Consecutivo = n.Mov+' '+n.MovID
       FROM Vale n
      WHERE n.ID = @ID  

   END       
   
  IF @Modulo = 'PV'
  BEGIN
    SELECT @Caja = '1', @FechaEmision = GETDATE(),@Cliente =''

  END    
/* Determina los Datos del Servicio */
  SELECT @TrxType = pls.TrxType,
	 @TrxSubType = pls.TrxSubType,
	 @EntryMode = pls.EntryMode,
	 @GeneraVoucher = pls.GeneraVoucher, 
	 @AnchoVoucher = pls.AnchoVoucher,
	 @Tipo = pls.Tipo
    FROM LDIServicio pls
   WHERE pls.Servicio = @Servicio


  /* Determina el numero de Originador (Sucursal) asignado por LDI */
  SELECT @SucursalLDI = '1:' + SucursalLDI
    FROM Sucursal 
   WHERE Sucursal = @Sucursal
   
  SELECT @FechaEmision = GETDATE()   
     
  /* Determina el numero de Nodo (Caja) asignado por LDI y el No Ticket (MovID) del movimiento*/
  SELECT @CajaLDI = '2:' + @Caja     
  
    /*Fecha y Hora de Emision(El formato debe ser AAAAMMDDHHMMSS)*/
  SELECT @FechaEmisionEjercicio = CONVERT(varchar(4), YEAR(@FechaEmision)),
         @FechaEmisionPeriodo = RIGHT('00' + CONVERT(varchar(2), MONTH(@FechaEmision)),2),
         @FechaEmisionDia = RIGHT('00' + CONVERT(varchar(2), DAY(@FechaEmision)),2),
         @FechaEmisionHora = RIGHT('00' + CONVERT(varchar(2), DatePart(hh, @FechaEmision)),2),
         @FechaEmisionMinuto = RIGHT('00' + CONVERT(varchar(2), DatePart(mi, @FechaEmision)),2),
         @FechaEmisionSegundo = RIGHT('00' + CONVERT(varchar(2), DatePart(ss, @FechaEmision)),2)
  
  SELECT @FechaEmisionLDI = '3:' + @FechaEmisionEjercicio + @FechaEmisionPeriodo + @FechaEmisionDia + @FechaEmisionHora + @FechaEmisionMinuto + @FechaEmisionSegundo      

  /* Determina el numero de empresa asignado por LDI */
  SELECT @EmpresaLDI = '161:' + EmpresaLDI
    FROM Empresa 
   WHERE Empresa = @Empresa
  
  
    /* Type, SubType y Tipo*/
  SELECT @TrxTypeLDI = '7:' + @TrxType,
         @MovIDLDI = '19:' + ISNULL(@MovID, 1),
	 @TrxSubTypeLDI = '56:'+ @TrxSubType,
	 @TipoLDI = '36:' + @Tipo

  /* Importe, va sin centavos*/
  IF @Servicio IN ('MON ABONO','MON CARGO','TDCLDI')
    SELECT @ImporteLDI = '45:' + CONVERT(varchar, ROUND(@Importe, 2))
  ELSE  
    SELECT @ImporteLDI = '45:' + CONVERT(varchar, ROUND(@Importe, 2)  * 100)
    
  IF @Servicio IN ('MON ABONO','MON CARGO')    
  BEGIN
    SELECT @ConceptoMonedero = '174:'+CASE WHEN @Servicio = 'MON ABONO' THEN '1' ELSE '2' END,
           @PuntosLDI ='266:'+ CONVERT(varchar, ROUND(0.0, 2)) ,
           @NotasLDI ='239:'+@Consecutivo 
  END
  
  /* Si se debe generar voucher */
  SELECT @GeneraVoucherLDI ='163:'+@GeneraVoucher ,
   @NoTelefonoLDI = '82:' + ISNULL(@NoTelefono,'000000')

  
  /* Cliente para el alta del monedero*/
  IF @Servicio IN ('MON ABONO', 'MON ALTA MODIFICA', 'MON ALTA NUEVO','MON ALTA REEMPLAZO','MON CARGO','MON CONSULTA')
  BEGIN
    SELECT @ClienteLDI = '41:' + @Cliente,
           @NoTarjetaLDI = '35:' + @NoTarjeta,
	   @NoTarjetaReemplazoLDI = '265:' + @NoTarjetaReemplazo
  END 


  /*Cuenta para pago servicios*/
    SELECT @CuentaLDI = '42:'+@Cuenta  
  
  /*Referencia para pago servicios*/
    SELECT @ReferenciaLDI = '57:'+ISNULL(@Referencia,'')
 

  IF @EsConsulta = 1
    SELECT @Consulta = '86:C'
			  
  IF @Servicio IN('EDOCTAMES')
  BEGIN
    SELECT @LDIMes = '254:'+@Mes,@LDIAno = '255:'+@Ano,
    @NoTarjetaLDI = '35:' + @NoTarjeta

  END
  IF @Servicio IN('EDOCTAPERIODO')
  BEGIN

    SELECT @LDIFechaD= '83:'+dbo.fnDateTimeFmt(@FechaD,'AAAAMMDD'), @LDIFechaA = '84:'+dbo.fnDateTimeFmt(@FechaA,'AAAAMMDD'),
    @NoTarjetaLDI = '35:' + @NoTarjeta
    
  END  
  
  /* Type, SubType y Tipo*/
  SELECT @TrxTypeLDI = '7:' + @TrxType,
	 @TrxSubTypeLDI = '56:'+ @TrxSubType,
	 @TipoLDI = '36:' + @Tipo
	 
  IF @EsCancelacion = 1 
  BEGIN
    IF @TrxTypeLDI = '251'
      SELECT @TrxTypeLDI = '7:' + '253'
      
    IF @TrxTypeLDI = '241'
      SELECT @TrxTypeLDI = '7:' + '243'     
      
    IF @TrxTypeLDI = '611'
      SELECT @TrxTypeLDI = '7:' + '613'          

          

    SELECT TOP 1 @TrxID = IDTransaccion,  @AutCode = CodigoAutorizacion
      FROM LDIMovLog WHERE IDModulo = @ID AND Modulo = @Modulo AND Servicio = @Servicio AND CodigoRespuesta = 0 AND Importe = @Importe
      
    SELECT @TrxIDLDI = '74:' + CONVERT(varchar,@TrxID), @AutCodeLDI = '50:' + CONVERT(varchar,@AutCode)
  END   
  --IF @Servicio = 'TDCLDI'
  --BEGIN
  --END 
  
  /*Concatena la Cadena */
  SELECT @Cadena = @Cadena + CASE WHEN @EmpresaLDI IS NOT NULL THEN ISNULL(@EmpresaLDI, '') ELSE '' END
			   + ISNULL(@Separador + @SucursalLDI, '')
			   + ISNULL(@Separador + @CajaLDI, '')
			   + ISNULL(@Separador + @TrxTypeLDI, '')		
			   + CASE WHEN @TrxSubType IS NOT NULL THEN ISNULL(@Separador + @TrxSubTypeLDI, '') ELSE '' END
			   + ISNULL(@Separador + @CuentaLDI, '')		
			   + ISNULL(@Separador + @ReferenciaLDI, '')		
			   + ISNULL(@Separador + @TipoLDI, '')		
			   + CASE WHEN @NoTarjeta IS NOT NULL THEN ISNULL(@Separador + @NoTarjetaLDI, '') ELSE '' END
			   + CASE WHEN @NoTarjetaReemplazo IS NOT NULL THEN ISNULL(@Separador + @NoTarjetaReemplazoLDI, '') ELSE '' END
			   + ISNULL(@Separador + @ConceptoMonedero, '')	
			   + ISNULL(@Separador + @PuntosLDI, '')
			   + ISNULL(@Separador + @NotasLDI, '')
			   + ISNULL(@Separador + @NoTelefonoLDI, '')		
			   + ISNULL(@Separador + @FechaEmisionLDI, '')
			   + ISNULL(@Separador + @MovIDLDI, '')			   
			   + ISNULL(@Separador + @ClienteLDI, '')			   
			   + ISNULL(@Separador + @ImporteLDI, '')
			   + ISNULL(@Separador + @GeneraVoucherLDI, '')
			   + ISNULL(@Separador + @Consulta, '')
			   + ISNULL(@Separador + @TrxIDLDI, '')	  
			   + ISNULL(@Separador + @AutCodeLDI, '')
			   + ISNULL(@Separador + @LDIMes, '')	  
			   + ISNULL(@Separador + @LDIAno, '')	  
			   + ISNULL(@Separador + @LDIFechaD, '')	  
			   + ISNULL(@Separador + @LDIFechaA, '')	  
			   + ISNULL(@Separador + @TransaccionesManuales, '') 
			   + '}'
		   		
END
GO



/************************ spLDI *****************************/

IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spLDI') AND type = 'P') DROP PROCEDURE dbo.spLDI
GO             
CREATE PROCEDURE spLDI
	     @Servicio			varchar(20),
	     @ID			varchar(36),
	     @NoTarjeta			varchar(36),
	     @Empresa                   varchar(5),
	     @Usuario                   varchar(10),
	     @Sucursal                  int,
	     @NoTarjetaReemplazo	varchar(36) = NULL,
	     @Importe			float = NULL,
	     @EnSilencio		bit = 0,
	     @NoTelefono		varchar(10) = NULL,
	     @Ok			int = NULL	OUTPUT,
	     @OkRef			varchar(255) = NULL OUTPUT,	     
	     @Modulo			varchar(5) = NULL,
	     @Cuenta                    varchar(255) = NULL,
	     @Referencia                varchar(255) = NULL,
	     @RIDCobro                  int = NULL,
	     @ADO                       bit = 0,
	     @EsCancelacion             bit = 0,
	     @EsConsulta                bit = 0,
	     @Mes                       varchar(2) = NULL,
	     @Ano                       varchar(4) = NULL,
	     @FechaD                    datetime = NULL,
	     @FechaA                    datetime = NULL,
	     @Accion                    varchar(20) = NULL,
	     @Estatus                   varchar(20) = NULL,
	     @Estacion                  int = NULL,
	     @EstacionFija              int = NULL	     



--//WITH ENCRYPTION	     

AS BEGIN

  DECLARE @Cadena			nvarchar(2048),
	  @CadenaRespuesta		nvarchar(2048),
	  @MensajeError			nvarchar(2048),
  	  @DireccionIP			varchar(15),
	  @Puerto			varchar(10),
	  @TiempoEspera			nvarchar(4),
	  @Cliente			varchar(10),
	  @ImporteOUT			varchar(20),	  
--Variables de la Respuesta
	  @OkLDI	                varchar(255),
	  @OkRefLDI	                varchar(500),
	  @Mensaje	                varchar(255),
	  @Voucher	                varchar(MAX),
	  @Voucher2	                varchar(MAX),
	  @Banco	                varchar(255),
	  @IDLDI                        int,
	  @MonedaMonedero               varchar(10),
	  @Moneda                       varchar(10),
	  @TipoCambio                   float,
	  @MonederoTipoCambio           float

	  
  --Monedero
  IF (SELECT ISNULL(VentaMonederoA,0) FROM EmpresaCfg2 WHERE Empresa = @Empresa) = 1 --AND @Servicio LIKE 'MON %'
	RETURN

  IF @Accion = 'CANCELAR'
    SELECT @Ok = 60050	 
    
  IF @Modulo = 'POS'	 
    IF NOT EXISTS (SELECT * FROM POSL WHERE ID = @ID)	  
      SELECT @Ok = 14055  

  IF @Modulo = 'NOM'	
    IF NOT EXISTS (SELECT * FROM Nomina WHERE ID = @ID)	  
      SELECT @Ok = 14055      

  IF @Modulo = 'VTAS'	
    IF NOT EXISTS (SELECT * FROM Venta WHERE ID = @ID)	  
      SELECT @Ok = 14055      

  DELETE LDIIDTemp WHERE Estacion = @@SPID
/* Tiempo Espera, es el tiempo maximo que la DLL local, espera respuesta del servidor de LDI, en caso de no recibirla en ese tiempo, responderá cadena con error */
  SELECT @TiempoEspera = '45'
  /* Determina la direccion a donde se enviara */
  SELECT @DireccionIP = pls.DireccionIP,
	 @Puerto = pls.Puerto
    FROM LDIServicio pls
   WHERE pls.Servicio = @Servicio
  
  IF @Servicio ='TDCLDI' AND NULLIF(@EstacionFija,0) IS NOT NULL
    SELECT @DireccionIP = DireccionIP, @Puerto = Puerto
      FROM LDIServicioEstacion 
     WHERE EstacionFija = @EstacionFija  

  IF @Ok IS NULL
    EXEC spLDIGeneraCadena @Servicio, @ID, @NoTarjeta, @NoTarjetaReemplazo, @Cadena OUTPUT, @Importe, @NoTelefono, @Modulo, @Ok OUTPUT, @OkRef OUTPUT, @Cuenta, @Referencia, @EsCancelacion, @EsConsulta, @Empresa, @Sucursal, @Mes, @Ano, @FechaD, @FechaA
--Aqui se envia la transaccion a LDI
  IF @OK IS NULL
    EXEC usp_EnviarMensaje @Cadena, @DireccionIP, @Puerto, @TiempoEspera, @CadenaRespuesta OUTPUT, @MensajeError OUTPUT
  --SELECT @CadenaRespuesta, @MensajeError
  IF NULLIF(@CadenaRespuesta,'') IS NULL
    SELECT @Ok = 2, @OkRef ='El Proveedor No envio Ninguna Respuesta'
  /* Determina si fue exitosa o hubo error */
  EXEC spLDIAnalizaCadena @CadenaRespuesta, '14', @OkLDI OUTPUT
  /* Si @MensajeError Es diferente de NULL, significa que hubo error de conexion */
  IF @MensajeError IS NOT NULL
    SELECT @Ok = 2, @OkRef = @MensajeError
  /* Determina el voucher */
  EXEC spLDIAnalizaCadena @CadenaRespuesta, '163', @Voucher OUTPUT
  EXEC spLDIAnalizaCadena @CadenaRespuesta, '27', @Banco OUTPUT
  --IF @Voucher IS NOT NULL OR @Banco IS NOT NULL
  --BEGIN
  --  INSERT POSLRefBancaria (ID, Voucher, Banco)
  --  VALUES                (@ID, @Voucher, @Banco)
  --  SELECT @Voucher2 = REPLACE(@Voucher,'^',':')
  --  IF NOT EXISTS (SELECT * FROM POSLDIVentaID WHERE ID = @ID)
  --  INSERT POSLDIVentaID(ID,Referencia2)
  --  SELECT              @ID,@Voucher2
  --  IF EXISTS (SELECT * FROM POSLDIVentaID WHERE ID = @ID)
  --  UPDATE POSLDIVentaID SET Referencia2= @Voucher2 WHERE ID = @ID
  --END

  /* Si @OKLDI es diferente de 0, es que hubo error de LDI o de los proveedores de servicio*/  
  IF @Ok IS NULL AND @OkLDI <> 0
  BEGIN
    EXEC spLDIAnalizaCadena @CadenaRespuesta, '16', @OkRefLDI OUTPUT
    SELECT @Ok = 2, @OkRef = 'El Proveedor de transacción mandó el mensaje ' + @OkRefLDI
  END
  IF @Ok IS NULL
  BEGIN
    /* Inserta el dato del monedero solo cuando se dio de alta*/
    IF @Servicio = 'MON ALTA NUEVO'
    BEGIN
      EXEC spLDIAnalizaCadena @Cadena, '41', @Cliente OUTPUT
      IF @Modulo = 'POS'
      BEGIN
        EXEC spPOSAltaMonedero @ID, @Usuario, @Empresa ,@Sucursal, @Cliente, @NoTarjeta, @Ok OUTPUT
        INSERT POSLDIMonedero (Monedero,   Cliente)
        VALUES (@NoTarjeta, @Cliente)
      END	  	

      IF @Ok IS NULL
        SELECT @Mensaje = 'Monedero Registrado Exitosamente'   		     
    END	 
    IF @Servicio = 'MON CONSULTA'AND @Modulo = 'POS'
    BEGIN
      DELETE POSLDISaldoMonederoTemp WHERE Estacion = @@SPID
      SELECT @MonedaMonedero = Moneda, @Cliente = Cliente FROM POSValeSerie WHERE Serie = @NoTarjeta
      SELECT @Moneda = Moneda, @TipoCambio = TipoCambio FROM POSLTipoCambioRef WHERE EsPrincipal = 1 AND Sucursal = @Sucursal
      SELECT @MonederoTipoCambio = TipoCambio FROM POSLTipoCambioRef WHERE Sucursal = @Sucursal AND Moneda = @MonedaMonedero
      EXEC spLDIAnalizaCadena @CadenaRespuesta, '45', @Importe OUTPUT
         SELECT @Mensaje = 'El Saldo del Monedero es de :<BR>' + dbo.fnFormatoMoneda(@Importe,@Empresa)+' '+@MonedaMonedero+'<BR>'+
                          CASE WHEN @Moneda <> @MonedaMonedero THEN dbo.fnFormatoMoneda(dbo.fnImporteMonTarjeta(@Importe, ISNULL(NULLIF(@MonedaMonedero,''),'Pesos'), ISNULL(@MonederoTipoCambio,1), ISNULL(NULLIF(@Moneda,''),'Pesos'), ISNULL(@TipoCambio,1), @Sucursal ),@Empresa)+' '+@Moneda ELSE '' END+
                          '<BR> Desea Imprimir El Saldo?'
    
      IF @Ok IS NULL                          
        INSERT POSLDISaldoMonederoTemp(Estacion, Monedero,  Cliente, MonedaMonedero,  TipoCambio,          Importe,  MonedaSucursal, ImporteMonedaSuc)
        SELECT                         @@SPID,   @NoTarjeta,@Cliente,   @MonedaMonedero, @MonederoTipoCambio, @Importe,  @Moneda,dbo.fnImporteMonTarjeta(@Importe, ISNULL(NULLIF(@MonedaMonedero,''),'Pesos'), ISNULL(@MonederoTipoCambio,1), ISNULL(NULLIF(@Moneda,''),'Pesos'), ISNULL(@TipoCambio,1), @Sucursal )
        --INSERT POSLDISaldoMonederoTemp(Estacion, Monedero,  Cliente, MonedaMonedero,  TipoCambio,     Importe, ImporteMonedaSuc, MonedaSucursal)
        --SELECT                         @@SPID,   @NoTarjeta,@Cliente,   @Moneda, @MonederoTipoCambio, dbo.fnImporteMonTarjeta(@Importe, ISNULL(NULLIF(@MonedaMonedero,''),'Pesos'), ISNULL(@MonederoTipoCambio,1), ISNULL(NULLIF(@Moneda,''),'Pesos'), ISNULL(@TipoCambio,1), @Sucursal ), @TipoCambio  ,@Moneda

    END	     
    IF @Servicio = 'MON CONSULTA' AND @Modulo <> 'POS'
    BEGIN
      EXEC spLDIAnalizaCadena @CadenaRespuesta, '45', @Importe OUTPUT
      SELECT @Mensaje = 'El Saldo del Monedero es de ' + dbo.fnFormatoMoneda(@Importe,@Empresa)
    END	     
    /* Inserta el dato del monedero solo cuando se hizo una modificacion*/
    IF @Servicio = 'MON ALTA MODIFICA'
    BEGIN
      UPDATE POSLDIMonedero SET Monedero = @NoTarjetaReemplazo
       WHERE Monedero = @NoTarjeta
    END
    --IF @Servicio IN ('IUSACELL', 'MOVISTAR', 'NEXTEL', 'TELCEL', 'UNEFON')
    --BEGIN
    --  SELECT @Mensaje = 'Recarga Exitosa'
    --  IF NOT EXISTS (SELECT * FROM POSLDIVentaID WHERE ID = @ID
    --  INSERT POSLDIVentaID (ID,Referencia1
    --  SELECT               @ID,@
    --  IF EXISTS (SELECT * FROM POSLDIVentaID WHERE ID = @ID
    --  UPDATE POSLDIVentaID SET Referencia1= @NoTelefono WHERE ID = @
    --END  
  END
  IF @CadenaRespuesta IS NOT NULL
  BEGIN
    INSERT LDIMovLog(IDModulo, Servicio,  Modulo,  Cadena,  CadenaRespuesta,  Importe,  RIDCobro,  Fecha, TipoTransaccion, TipoSubservicio,CodigoRespuesta, DescripcionRespuesta, OrigenRespuesta, InfoAdicional, IDTransaccion,CodigoAutorizacion,Comprobante, TotalRegistros, ListaMontos, ListaReferencias, ListaFechas, ListaConceptos, ListaMovimientos   )
    SELECT           @ID,      @Servicio, @Modulo, @Cadena, @CadenaRespuesta, @Importe, @RIDCobro, *
      FROM(SELECT Parametro,Valor FROM dbo.fnLDISeparaCadena (@CadenaRespuesta)) tabla
     PIVOT( MAX(Valor)
       FOR [Parametro] IN ([[3], [7], [56], [14], [16], [13], [27],  [8], [50],  [163], [111],[45],[51],[149],[174],[239])) p
    SELECT @IDLDI = SCOPE_IDENTITY()
    UPDATE LDIMovLog SET   Comprobante = REPLACE(REPLACE(REPLACE(Comprobante,'^',':'),'@dd',':'),CHAR(10),'<BR>') ,Fecha = dbo.fnLDIFecha(Fecha) 
     WHERE  ID = @IDLDI
    INSERT LDIIDTemp(ID,Estacion, Modulo) SELECT @IDLDI, @@SPID ,@Modulo
    IF @Servicio IN('EDOCTAMES','EDOCTAPERIODO')
    BEGIN
    --EXEC spPOSLDIValidarTarjeta  'MON CONSULTA',@ID, @NoTarjeta,@Empresa,@Usuario,@Sucursal,@Importe OUTPUT, @Ok OUTPUT, @OkRef  OUTPUT, @OKRefLDI OUTPUT 
      EXEC spPOSReporteEdoCtaLDI @IDLDI, @Importe
    END  
  END  
  ELSE
    INSERT LDIMovLog(IDModulo, Servicio,  Modulo,  Cadena,  CadenaRespuesta,                          Importe,   RIDCobro,  Fecha,   DescripcionRespuesta, OrigenRespuesta, InfoAdicional, IDTransaccion,CodigoAutorizacion,Comprobante   )
    SELECT           @ID,      @Servicio, @Modulo, @Cadena, '27:'+@OkRef+'16:'+CONVERT(varchar,@Ok),  @Importe, @RIDCobro,  GETDATE(),'','','','','',''
  IF @EnSilencio = 0
    SELECT @Ok, @OkRef, @Mensaje, @CadenaRespuesta, @Cadena
  IF @ADO = 1
  BEGIN
  IF EXISTS(SELECT * FROM POSLDIRespuestaTemp WHERE ID = @ID)
    DELETE POSLDIRespuestaTemp WHERE ID = @ID
    INSERT POSLDIRespuestaTemp(ID,  Ok,  OkRef,  Mensaje,  CadenaRespuesta,  Cadena, IDLog)   
    SELECT                     @ID, @Ok, @OkRef, @Mensaje, @CadenaRespuesta, @Cadena, @IDLDI 
  END                
END
GO


  
  
/************************ spLDIValidarTarjeta *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spLDIValidarTarjeta') AND type = 'P') DROP PROCEDURE dbo.spLDIValidarTarjeta
GO             
CREATE PROCEDURE spLDIValidarTarjeta
	     @Servicio			varchar(20),
	     @ID			varchar(36),
	     @NoTarjeta			varchar(36),
	     @Empresa                   varchar(5),
	     @Usuario                   varchar(10),
	     @Sucursal                  int,
	     @Importe			float = NULL OUTPUT,
	     @Ok			int = NULL	OUTPUT,
	     @OkRef			varchar(255) = NULL OUTPUT,
	     @OkRefLDI	                varchar(500) = NULL OUTPUT,
	     @Mostrar                   bit = 0,
	     @Modulo                    varchar(5) = 'POS'
--//WITH ENCRYPTION	     
	     
AS BEGIN
  DECLARE @Cadena			nvarchar(2048),
	  @CadenaRespuesta		nvarchar(2048),
	  @MensajeError			nvarchar(2048),
  	  @DireccionIP			varchar(15),
	  @Puerto			varchar(10),
	  @TiempoEspera			nvarchar(4),
	  @Cliente			varchar(10),
	  @ImporteOUT			varchar(20),
	  
--Variables de la Respuesta
	  @OkLDI	varchar(255),
	  @Mensaje	varchar(255),
	  @Voucher				varchar(MAX),
	  @Voucher2				varchar(MAX),
	  @Banco			varchar(255)
      
  /* Tiempo Espera, es el tiempo maximo que la DLL local, espera respuesta del servidor de LDI, en caso de no recibirla en ese tiempo, responderá cadena con error */
  SELECT @TiempoEspera = '45'
  
  /* Determina la direccion a donde se enviara */
  SELECT @DireccionIP = pls.DireccionIP,
	 @Puerto = pls.Puerto
    FROM LDIServicio pls
   WHERE pls.Servicio = @Servicio
   
  IF @Ok IS NULL
	  
    
    EXEC spLDIGeneraCadena @Servicio, @ID, @NoTarjeta, NULL, @Cadena OUTPUT, @Importe, NULL, @Modulo, @Ok OUTPUT, @OkRef OUTPUT, NULL, NULL,0,0, @Empresa, @Sucursal

--Aqui se envia la transaccion a LDI
  EXEC usp_EnviarMensaje @Cadena, @DireccionIP, @Puerto, @TiempoEspera, @CadenaRespuesta OUTPUT, @MensajeError OUTPUT
  --SELECT @CadenaRespuesta, @MensajeError

  /* Determina si fue exitosa o hubo error */
  EXEC spLDIAnalizaCadena @CadenaRespuesta, '14', @OkLDI OUTPUT

  /* Si @MensajeError Es diferente de NULL, significa que hubo error de conexion */
  IF @MensajeError IS NOT NULL
    SELECT @Ok = 2, @OkRef = @MensajeError
  
  /* Determina el voucher */
  EXEC spLDIAnalizaCadena @CadenaRespuesta, '163', @Voucher OUTPUT
  EXEC spLDIAnalizaCadena @CadenaRespuesta, '27', @Banco OUTPUT
  
  IF @Voucher IS NOT NULL OR @Banco IS NOT NULL AND @Modulo = 'POS'
  BEGIN
    INSERT POSLRefBancaria (ID, Voucher, Banco)
    VALUES                (@ID, @Voucher, @Banco)
    
    SELECT @Voucher2 = REPLACE(@Voucher,'^',':')
    IF NOT EXISTS (SELECT * FROM POSLDIVentaID WHERE ID = @ID)AND @Modulo = 'POS'
    INSERT POSLDIVentaID(ID,Referencia2)
    SELECT              @ID,@Voucher2
    IF EXISTS (SELECT * FROM POSLDIVentaID WHERE ID = @ID)
    UPDATE POSLDIVentaID SET Referencia2= @Voucher2 WHERE ID = @ID
  END

  /* Si @OKLDI es diferente de 0, es que hubo error de LDI o de los proveedores de servicio*/  
  IF @Ok IS NULL AND @OkLDI <> 0
  BEGIN
    EXEC spLDIAnalizaCadena @CadenaRespuesta, '16', @OkRefLDI OUTPUT
    SELECT @Ok = 2, @OkRef = 'El Proveedor de transacción mandó el mensaje ' + @OkRefLDI
  END

  IF @Ok IS NULL
  BEGIN
    /* Inserta el dato del monedero solo cuando se dio de alta*/
  
    IF @Servicio = 'MON CONSULTA'
    BEGIN
      EXEC spLDIAnalizaCadena @CadenaRespuesta, '45', @Importe OUTPUT
      
      SELECT @Importe = ISNULL(@Importe,0.0) 
    END	     
    
  END  
  IF @Ok IS NULL AND @Mostrar = 1 
  SELECT @Importe
  IF @Ok IS NOT NULL AND @Mostrar = 1
  SELECT @OkRefLDI 
END
GO  

/**************** spLDIGenerarLOG   ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLDIGenerarLOG') and type = 'P') drop procedure dbo.spLDIGenerarLOG
GO
CREATE PROCEDURE spLDIGenerarLOG
		@Empresa		char(5),
		@Modulo			char(10),
		@ID			int,
		@Servicio               varchar(20),
		@Cadena                 varchar(8000), 
		@CadenaRespuesta        varchar(8000), 
		@Importe                float,		
		@Ok 			int 		OUTPUT,
		@OkRef 			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE 
  @IDLDI     int


    INSERT LDIMovLog(IDModulo, Servicio,  Modulo,  Cadena,  CadenaRespuesta,  Importe,  RIDCobro,  Fecha, TipoTransaccion, TipoSubservicio,CodigoRespuesta, DescripcionRespuesta, OrigenRespuesta, InfoAdicional, IDTransaccion,CodigoAutorizacion,Comprobante   )
    SELECT           @ID,      @Servicio, @Modulo, @Cadena, @CadenaRespuesta, @Importe, NULL, *
      FROM(SELECT Parametro,Valor FROM dbo.fnLDISeparaCadena (@CadenaRespuesta)) tabla
     PIVOT( MAX(Valor)
       FOR [Parametro] IN ([[3], [7], [56], [14], [16], [13], [27],  [8], [50],  [163])) p
       
     SELECT @IDLDI = SCOPE_IDENTITY()
     
     UPDATE LDIMovLog SET   Comprobante = REPLACE(REPLACE(REPLACE(Comprobante,'^',':'),'@dd',':'),CHAR(10),'<BR>') ,Fecha = dbo.fnLDIFecha(Fecha) 
      WHERE  ID = @IDLDI
 

  RETURN
END
GO   

/**************** spLDIVentaGenerarActivacionVale ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLDIVentaGenerarActivacionVale') and type = 'P') drop procedure dbo.spLDIVentaGenerarActivacionVale
GO
CREATE PROCEDURE spLDIVentaGenerarActivacionVale
		@Empresa		char(5),
		@Modulo			char(10),
		@ID			int,
		@Mov			char(20),
		@MovID			varchar(20),
		@MovTipo		char(20),
		@Accion			char(20),
		@FechaEmision		datetime,
		@Ejercicio		int,
		@Periodo		int,
		@Usuario		char(10),
		@Sucursal		int,
		@MovMoneda		char(10),
		@MovTipoCambio		float,
		@Ok 			int 		OUTPUT,
		@OkRef 			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE 
  @IDVale         int,
  @MovGenerar     varchar(20),
  @Cliente        varchar(10),
  @Articulo       varchar(20),
  @Monedero       varchar(50),
  @TipoMonedero   varchar(50),
  @RenglonID      int,
  @ArtTipo        varchar(50),
  @EsEntrada      bit,
  @EsSalida       bit,
  @Almacen	  varchar(10),
  @AlmacenTipo	  varchar(15),
  @OkVale         int,
  @OkRefVale      varchar(255),
  @CadenaRespuesta varchar(8000),
  @Cadena         varchar(8000),
  @ValeMovID      varchar(20)
  
  SET @EsEntrada = 0
  SET @EsSalida = 0
  
  IF @Accion = 'CANCELAR'
    SELECT @EsEntrada = 1
  ELSE 
    SELECT @EsSalida= 1 
    
  SELECT TOP 1 @MovGenerar = Mov FROM MovTipo WHERE Clave = 'VALE.ACTMLDI' AND Modulo = 'VALE'
    
  
    
  SELECT @AlmacenTipo = Tipo FROM Alm WHERE Almacen = @Almacen    
  
  SELECT @Articulo = ISNULL(d.Almacen,v.Almacen), @Cliente = v.Cliente, @Articulo =d.Articulo, @RenglonID = d.RenglonID, @ArtTipo = a.Tipo 
    FROM Venta v JOIN VentaD d  ON v.ID = d.ID JOIN Art a ON a.Articulo = d.Articulo WHERE d.ID = @ID AND ISNULL(a.LDI,0) = 1
  
  SELECT TOP 1 @Monedero = NULLIF(RTRIM(SerieLote), '')
    FROM SerieLoteMov
   WHERE Empresa   = @Empresa
     AND Modulo    = @Modulo
     AND ID        = @ID
     AND Articulo  = @Articulo
     
   SELECT  @TipoMonedero = Tipo FROM ValeSerie WHERE Serie = @Monedero
   
   IF @Ok IS NULL
   BEGIN
     INSERT Vale(Empresa, Mov,          FechaEmision, Moneda,     TipoCambio,     Usuario,  Estatus,      Sucursal,  Tipo,          Precio, Importe,  Cantidad,  Articulo,   Almacen,   OrigenTipo, Origen, OrigenID, Cliente)
     SELECT      @Empresa,@MovGenerar, @FechaEmision, @MovMoneda, @MovTipoCambio, @Usuario, 'SINAFECTAR', @Sucursal, @TipoMonedero, 0.0,     0.0,     1,         @Articulo,  @Almacen,  @Modulo,    @Mov,   @MovID , @Cliente  
     
     SELECT @IDVale = SCOPE_IDENTITY()
     
     INSERT ValeD(ID,      Serie,      Sucursal, SucursalOrigen,Importe)
     SELECT       @IDVale, @Monedero, @Sucursal, @Sucursal,     NULL

     IF @Modulo = 'VTAS' AND Exists(SELECT * FROM ValeSerie WHERE Serie = @Monedero AND Articulo = @Articulo)
       EXEC spValeSerieTarjeta @Empresa, @ID, @RenglonID, @MovTipo, @Accion, @Almacen, @AlmacenTipo, @Articulo, @ArtTipo, @Monedero, @EsEntrada, @EsSalida, @FechaEmision, @Ok OUTPUT, @OkRef OUTPUT
       
     IF @OK IS NULL
       EXEC spAfectar 'VALE', @IDVale, 'AFECTAR', 'Todo', NULL, @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
       IF @Ok IS NULL
       SELECT @ValeMovID = MovID FROM Vale WHERE ID = @IDVale
       EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'VALE', @IDVale, @MovGenerar, @ValeMovID, @Ok OUTPUT
     END      
   IF @Ok IS NULL AND (SELECT Estatus FROM Vale WHERE ID = @IDVale)='PENDIENTE'
   BEGIN
     SAVE TRANSACTION Vale
   
     EXEC spAfectar 'VALE', @IDVale, 'AFECTAR', 'Todo', NULL, @Usuario, @EnSilencio = 1, @Conexion =1, @Ok = @OkVale OUTPUT, @OkRef = @OkRefVale OUTPUT 
     
     IF @OkVale IS NOT NULL
     BEGIN
       SELECT TOP 1 @Cadena = Cadena ,@CadenaRespuesta = CadenaRespuesta FROM LDIMovLog WHERE IDModulo = @IDVale AND Modulo = 'VALE' ORDER BY ID DESC
       ROLLBACK TRANSACTION Vale
       EXEC spLDIGenerarLOG  @Empresa, 'VALE', @IDVale, 'MON ALTA NUEVO', @Cadena, @CadenaRespuesta, NULL, @Ok  OUTPUT, @OkRef  OUTPUT
     END
     ELSE
       SELECT @Ok = @OkVale, @OKRef = @OkRefVale
   END   
  RETURN
END
GO



--EXEC spLDIVentaGenerarActivacionVale @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Accion, @FechaEmision, @Ejercicio, @Periodo, @Usuario, @Sucursal, @MovMoneda, @MovTipoCambio, @Ok OUTPUT, @OkRef OUTPUT

/**************** spLDIValeActivarMonedero ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLDIValeActivarMonedero') and type = 'P') drop procedure dbo.spLDIValeActivarMonedero
GO
CREATE PROCEDURE spLDIValeActivarMonedero
		@Empresa		char(5),
		@Modulo			char(10),
		@ID			int,
		@Mov			char(20),
		@MovID			varchar(20),
		@MovTipo		char(20),
		@Accion			char(20),
		@FechaEmision		datetime,
		@Ejercicio		int,
		@Periodo		int,
		@Usuario		char(10),
		@Sucursal		int,
		@MovMoneda		char(10),
		@MovTipoCambio		float,
		@Ok 			int 		OUTPUT,
		@OkRef 			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE 
    @Servicio           varchar(20),
    @Articulo           varchar(20),
    @Monedero           varchar(50),
    @Importe            float
    
    
  
  
  SELECT @Articulo = Articulo FROM Vale WHERE ID = @ID   
  SELECT TOP 1 @Monedero = Serie FROM ValeD WHERE ID = @ID 
  SELECT @Servicio = LDIServicio FROM Art WHERE Articulo = @Articulo 
  
  IF NULLIF(@Servicio,'') IS NOT NULL AND NULLIF(@Monedero,'') IS NOT NULL 
  BEGIN
  
    EXEC spLDI 'MON CONSULTA', @ID, @Monedero, @Empresa, @Usuario, @Sucursal, NULL, NULL, 1, NULL, @Ok OUTPUT, @OkRef OUTPUT, @Modulo, @Cuenta = NULL, @Referencia = NULL, @RIDCobro = NULL, @ADO = 0
    
    IF @OKRef like '%Tarjeta no registrada%'  
    BEGIN 
      SELECT @Ok = NULL,@OkRef = NULL
      EXEC spLDI @Servicio, @ID, @Monedero, @Empresa, @Usuario, @Sucursal, NULL, @Importe, 1, NULL, @Ok OUTPUT, @OkRef OUTPUT, @Modulo, @Cuenta = NULL, @Referencia = NULL, @RIDCobro = NULL, @ADO = 0
    END  
  END 

  RETURN
END
GO


--EXEC spLDIValeActivarMonedero @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Accion, @FechaEmision, @Ejercicio, @Periodo, @Usuario, @Sucursal, @MovMoneda, @MovTipoCambio, @Ok OUTPUT, @OkRef OUTPUT
/**************** spLDIVentaGenerarAbonoVale ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLDIVentaGenerarAbonoVale') and type = 'P') drop procedure dbo.spLDIVentaGenerarAbonoVale
GO
CREATE PROCEDURE spLDIVentaGenerarAbonoVale
		@Empresa		char(5),
		@Modulo			char(10),
		@ID			int,
		@Mov			char(20),
		@MovID			varchar(20),
		@MovTipo		char(20),
		@Accion			char(20),
		@FechaEmision		datetime,
		@Ejercicio		int,
		@Periodo		int,
		@Usuario		char(10),
		@Sucursal		int,
		@MovMoneda		char(10),
		@MovTipoCambio		float,
		@Importe                float,
		@Ok 			int 		OUTPUT,
		@OkRef 			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE 
  @IDVale         int,
  @MovGenerar     varchar(20),
  @Cliente        varchar(10),
  @Articulo       varchar(20),
  @Monedero       varchar(50),
  @TipoMonedero   varchar(50),
  @RenglonID      int,
  @ArtTipo        varchar(50),
  @Almacen	  varchar(10),
  @AlmacenTipo	  varchar(15),
  @ValeMovID      varchar(20),
  @OkVale 	  int ,
  @OkRefVale 	  varchar(255),
  @CadenaRespuesta varchar(8000),
  @Cadena         varchar(8000)
  
   
  SELECT TOP 1 @MovGenerar = Mov FROM MovTipo WHERE Clave = 'VALE.AMLDI' AND Modulo = 'VALE'
   
  SELECT @Cliente = v.Cliente
    FROM Venta v  WHERE v.ID = @ID   
    
  SELECT @AlmacenTipo = Tipo FROM Alm WHERE Almacen = @Almacen    
  
  SELECT TOP 1 @Monedero = Serie FROM TarjetaSeriemov  WHERE Empresa = @Empresa AND Modulo = 'VTAS' AND ID = @ID 
     
  SELECT  @TipoMonedero = Tipo FROM ValeSerie WHERE Serie = @Monedero
   IF @Accion = 'AFECTAR'
   BEGIN
     IF @Ok IS NULL 
     BEGIN

       INSERT Vale(Empresa, Mov,          FechaEmision, Moneda,     TipoCambio,     Usuario,  Estatus,      Sucursal,  Tipo,          Precio, Importe,  Cantidad,  Articulo,   Almacen,   OrigenTipo, Origen, OrigenID, Cliente)
       SELECT      @Empresa,@MovGenerar, @FechaEmision, @MovMoneda, @MovTipoCambio, @Usuario, 'SINAFECTAR', @Sucursal, @TipoMonedero, @Importe,     @Importe,     1,    NULL,       NULL,      @Modulo,    @Mov,   @MovID , @Cliente  
       
       SELECT @IDVale = SCOPE_IDENTITY()
   
       INSERT ValeD(ID,      Serie,      Sucursal, SucursalOrigen,Importe)
       SELECT       @IDVale, @Monedero, @Sucursal, @Sucursal,     @Importe
 
       IF @OK IS NULL
         EXEC spAfectar 'VALE', @IDVale, 'AFECTAR', 'Todo', NULL, @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

       IF @Ok IS NULL
       SELECT @ValeMovID = MovID FROM Vale WHERE ID = @IDVale
       EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'VALE', @IDVale, @MovGenerar, @ValeMovID, @Ok OUTPUT
     END      

     IF @Ok IS NULL AND (SELECT Estatus FROM Vale WHERE ID = @IDVale)='PENDIENTE'
     BEGIN
       SAVE TRANSACTION Vale
   
       EXEC spAfectar 'VALE', @IDVale, 'AFECTAR', 'Todo', NULL, @Usuario, @EnSilencio = 1, @Conexion =1, @Ok = @OkVale OUTPUT, @OkRef = @OkRefVale OUTPUT 
       
       IF @OkVale IS NOT NULL
       BEGIN
         SELECT TOP 1 @Cadena = Cadena ,@CadenaRespuesta = CadenaRespuesta FROM LDIMovLog WHERE IDModulo = @IDVale AND Modulo = 'VALE' ORDER BY ID DESC
         ROLLBACK TRANSACTION Vale
         EXEC spLDIGenerarLOG  @Empresa, 'VALE', @IDVale, 'MON ABONO', @Cadena, @CadenaRespuesta, @Importe, @Ok  OUTPUT, @OkRef  OUTPUT
       END
       ELSE
         SELECT @Ok = @OkVale, @OKRef = @OkRefVale
     END     

   END  
   IF @Accion = 'CANCELAR' AND @Ok IS NULL
   BEGIN
     SELECT @IDVale = ID FROM Vale WHERE Origen = @Mov AND OrigenID = @MovID AND OrigenTipo = 'VTAS' AND @Empresa = @Empresa
     EXEC spAfectar 'VALE', @IDVale, 'CANCELAR', 'Todo', NULL, @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT 
   END     

  RETURN
END
GO


/**************** spLDIValeGenerarAbonoMonedero ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLDIValeGenerarAbonoMonedero') and type = 'P') drop procedure dbo.spLDIValeGenerarAbonoMonedero
GO
CREATE PROCEDURE spLDIValeGenerarAbonoMonedero
		@Empresa		char(5),
		@Modulo			char(10),
		@ID			int,
		@Mov			char(20),
		@MovID			varchar(20),
		@MovTipo		char(20),
		@Accion			char(20),
		@FechaEmision		datetime,
		@Ejercicio		int,
		@Periodo		int,
		@Usuario		char(10),
		@Sucursal		int,
		@MovMoneda		char(10),
		@MovTipoCambio		float,
		@Ok 			int 		OUTPUT,
		@OkRef 			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE 
    @Servicio           varchar(20),
    @ServicioInverso    varchar(20),
    @ServicioInversoInverso    varchar(20),
    @Articulo           varchar(20),
    @Monedero           varchar(50),
    @Importe            float
    
    
  
  
  SELECT @Articulo = Articulo FROM Vale WHERE ID = @ID   
  SELECT TOP 1 @Monedero = Serie, @Importe = Importe FROM ValeD WHERE ID = @ID 
  SELECT @Servicio = 'MON ABONO' 
  SELECT @ServicioInverso = ServicioInverso FROM LDIServicio WHERE Servicio = @Servicio
  SELECT @ServicioInversoInverso = ServicioInverso FROM LDIServicio WHERE Servicio = @ServicioInverso
  
  IF @Importe <0.0
    SELECT @Servicio = @ServicioInverso
  
  IF @Accion = 'CANCELAR'  
    SELECT @Servicio = @ServicioInverso
    
  IF @Accion = 'CANCELAR'  AND  @Importe <0.0
    SELECT @Servicio = @ServicioInversoInverso    
  
  SELECT @Importe = ABS(@Importe)
  IF NULLIF(@Servicio,'') IS NOT NULL AND NULLIF(@Monedero,'') IS NOT NULL  AND @Importe > 0.0 AND @Accion <> 'CANCELAR'
    EXEC spLDI @Servicio, @ID, @Monedero, @Empresa, @Usuario, @Sucursal, NULL, @Importe, 1, NULL, @Ok OUTPUT, @OkRef OUTPUT, @Modulo, @Cuenta = NULL, @Referencia = NULL, @RIDCobro = NULL, @ADO = 0
      

  RETURN
END
GO


--EXEC spLDIValeGenerarAbonoMonedero @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Accion, @FechaEmision, @Ejercicio, @Periodo, @Usuario, @Sucursal, @MovMoneda, @MovTipoCambio, @Ok OUTPUT, @OkRef OUTPUT

/**************** spLDIVentaGenerarRecargaTel ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLDIVentaGenerarRecargaTel') and type = 'P') drop procedure dbo.spLDIVentaGenerarRecargaTel
GO
CREATE PROCEDURE spLDIVentaGenerarRecargaTel
		@Empresa		char(5),
		@Modulo			char(10),
		@ID			int,
		@Mov			char(20),
		@MovID			varchar(20),
		@MovTipo		char(20),
		@Accion			char(20),
		@FechaEmision		datetime,
		@Ejercicio		int,
		@Periodo		int,
		@Usuario		char(10),
		@Sucursal		int,
		@MovMoneda		char(10),
		@MovTipoCambio		float,
		@Ok 			int 		OUTPUT,
		@OkRef 			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE 
    @Servicio           varchar(20),
    @ServicioInverso    varchar(20),
    @Articulo           varchar(20),
    @Monedero           varchar(50),
    @Importe            float,
    @Telefono           varchar(10)
    
    
  
  
  SELECT TOP 1 @Articulo = Articulo, @Importe = ISNULL(Precio,0.0), @Telefono = RecargaTelefono  FROM VentaD WHERE ID = @ID   

  SELECT @Servicio = LDIServicio  FROM Art WHERE Articulo = @Articulo
   
  SELECT @Importe = ABS(@Importe)
  IF NULLIF(@Servicio,'') IS NOT NULL  AND @Importe > 0.0
    EXEC spLDI @Servicio, @ID, @Monedero, @Empresa, @Usuario, @Sucursal, NULL, @Importe, 1, @Telefono, @Ok OUTPUT, @OkRef OUTPUT, @Modulo, @Cuenta = NULL, @Referencia = NULL, @RIDCobro = NULL, @ADO = 0
      

  RETURN
END
GO

--EXEC spLDIVentaGenerarRecargaTel @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Accion, @FechaEmision, @Ejercicio, @Periodo, @Usuario, @Sucursal, @MovMoneda, @MovTipoCambio, @Ok OUTPUT, @OkRef OUTPUT


/**************** spLDIVentaGenerarPagoServicio ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLDIVentaGenerarPagoServicio') and type = 'P') drop procedure dbo.spLDIVentaGenerarPagoServicio
GO
CREATE PROCEDURE spLDIVentaGenerarPagoServicio
		@Empresa		char(5),
		@Modulo			char(10),
		@ID			int,
		@Mov			char(20),
		@MovID			varchar(20),
		@MovTipo		char(20),
		@Accion			char(20),
		@FechaEmision		datetime,
		@Ejercicio		int,
		@Periodo		int,
		@Usuario		char(10),
		@Sucursal		int,
		@MovMoneda		char(10),
		@MovTipoCambio		float,
		@Ok 			int 		OUTPUT,
		@OkRef 			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE 
    @Servicio           varchar(20),
    @ServicioInverso    varchar(20),
    @Articulo           varchar(20),
    @Monedero           varchar(50),
    @Importe            float,
    @LDICuenta          varchar(50),
    @LDIReferencia      varchar(50)
    
    
  
  
  SELECT TOP 1 @Articulo = Articulo, @Importe = ISNULL(Precio,0.0), @LDICuenta = LDICuenta, @LDIReferencia = LDIReferencia  FROM VentaD WHERE ID = @ID   

  SELECT @Servicio = LDIServicio  FROM Art WHERE Articulo = @Articulo
   
  SELECT @Importe = ABS(@Importe)
  IF NULLIF(@Servicio,'') IS NOT NULL  AND @Importe > 0.0
    EXEC spLDI @Servicio, @ID, @Monedero, @Empresa, @Usuario, @Sucursal, NULL, @Importe, 1, NULL, @Ok OUTPUT, @OkRef OUTPUT, @Modulo, @Cuenta = @LDICuenta, @Referencia = @LDIReferencia, @RIDCobro = NULL, @ADO = 0
      

  RETURN
END
GO
/**************** spLDIValeGenerarCargoMonedero ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLDIValeGenerarCargoMonedero') and type = 'P') drop procedure dbo.spLDIValeGenerarCargoMonedero
GO
CREATE PROCEDURE spLDIValeGenerarCargoMonedero
		@Empresa		char(5),
		@Modulo			char(10),
		@ID			int,
		@Mov			char(20),
		@MovID			varchar(20),
		@MovTipo		char(20),
		@Accion			char(20),
		@Usuario		char(10),
		@Sucursal		int,
		@MovMoneda		char(10),
		@MovTipoCambio		float,
		@Ok 			int 		OUTPUT,
		@OkRef 			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE 
    @Servicio           varchar(20),
    @ServicioInverso    varchar(20),
    @Articulo           varchar(20),
    @Serie              varchar(50),
    @Importe            float,
    @FormaCobroTarjetas varchar(50)
    
  
  SELECT @FormaCobroTarjetas = CxcFormaCobroTarjetas FROM EmpresaCfg WHERE Empresa = @Empresa
  SELECT @Servicio = LDIServicio FROM FormaPago WHERE FormaPago = @FormaCobroTarjetas AND LDI = 1
  SELECT @ServicioInverso = ServicioInverso FROM LDIServicio WHERE Servicio = @Servicio
  
  IF @Accion = 'CANCELAR' 
    SELECT @Servicio = @ServicioInverso


  DECLARE crValeSerie CURSOR FOR
   SELECT d.Serie, ABS(d.Importe)
     FROM ValeD d 
    WHERE ID = @ID
  
  OPEN crValeSerie
  FETCH NEXT FROM crValeSerie INTO @Serie, @Importe
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN 

    IF NULLIF(@Servicio,'') IS NOT NULL AND NULLIF(@Serie,'') IS NOT NULL  AND @Importe > 0.0
      EXEC spLDI @Servicio, @ID, @Serie, @Empresa, @Usuario, @Sucursal, NULL, @Importe, 1, NULL, @Ok OUTPUT, @OkRef OUTPUT, @Modulo, @Cuenta = NULL, @Referencia = NULL, @RIDCobro = NULL, @ADO = 0
     

    
    FETCH NEXT FROM crValeSerie INTO @Serie, @Importe
  END 
  CLOSE crValeSerie
  DEALLOCATE crValeSerie  

  RETURN
END
GO

--EXEC spLDIValeGenerarCargoMonedero @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Accion, @FechaEmision, @Ejercicio, @Periodo, @Usuario, @Sucursal, @MovMoneda, @MovTipoCambio, @Ok OUTPUT, @OkRef OUTPUT

/**************** spLDIPagoTarjetaCredito ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLDIPagoTarjetaCredito') and type = 'P') drop procedure dbo.spLDIPagoTarjetaCredito
GO             
CREATE PROCEDURE spLDIPagoTarjetaCredito
                   @ID        		int,
                   @Empresa             varchar(5),
                   @Sucursal            int,
		   @Modulo		varchar(5),
		   @Usuario             varchar(10),
		   @FormaCobro1         varchar(50),          
		   @FormaCobro2         varchar(50),          
		   @FormaCobro3         varchar(50),          
		   @FormaCobro4         varchar(50),          
		   @FormaCobro5         varchar(50),          
		   @FormaCobroTarjetas  varchar(50),
		   @Importe1            float,
		   @Importe2            float,
		   @Importe3            float,
		   @Importe4            float,
		   @Importe5            float,
		   @Referencia1         varchar(50),
		   @Referencia2         varchar(50),
		   @Referencia3         varchar(50),
		   @Referencia4         varchar(50),
		   @Referencia5         varchar(50),
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT,
		   @Accion              varchar(20),
		   @Estatus             varchar(20),
		   @Estacion            int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
   @LDIServicio         varchar(20),
   @EstacionFija        int
   
   SELECT @EstacionFija = EstacionFija FROM LDIEstacionTemp WHERE Estacion = @Estacion
   
   
   IF EXISTS(SELECT * FROM FormaPago WHERE FormaPago = @FormaCobro1 AND ISNULL(LDI,0) = 1 AND FormaPago NOT IN(@FormaCobroTarjetas) AND NULLIF(LDIServicio,'') IS NOT NULL) AND @Ok IS NULL
   BEGIN
     SELECT @LDIServicio = LDIServicio FROM FormaPago WHERE FormaPago = @FormaCobro1   AND ISNULL(LDI,0) = 1
     EXEC spLDI @LDIServicio, @ID, NULL, @Empresa, @Usuario, @Sucursal, NULL, @Importe1, 1, NULL, @Ok OUTPUT, @OkRef OUTPUT, @Modulo, @Cuenta = NULL, @Referencia = @Referencia1 , @RIDCobro = NULL, @ADO = 0, @Accion = @Accion, @Estatus = @Estatus, @Estacion = @Estacion, @EstacionFija = @EstacionFija
   END  
   
   IF EXISTS(SELECT * FROM FormaPago WHERE FormaPago = @FormaCobro2 AND ISNULL(LDI,0) = 1 AND FormaPago NOT IN(@FormaCobroTarjetas)AND NULLIF(LDIServicio,'') IS NOT NULL)  AND @Ok IS NULL
   BEGIN
     SELECT @LDIServicio = LDIServicio FROM FormaPago WHERE FormaPago = @FormaCobro2  AND ISNULL(LDI,0) = 1
     EXEC spLDI @LDIServicio, @ID, NULL, @Empresa, @Usuario, @Sucursal, NULL, @Importe2, 1, NULL, @Ok OUTPUT, @OkRef OUTPUT, @Modulo, @Cuenta = NULL, @Referencia = @Referencia2 , @RIDCobro = NULL, @ADO = 0, @Accion = @Accion, @Estatus = @Estatus, @Estacion = @Estacion, @EstacionFija = @EstacionFija
   END     
   IF EXISTS(SELECT * FROM FormaPago WHERE FormaPago = @FormaCobro3 AND ISNULL(LDI,0) = 1 AND FormaPago NOT IN(@FormaCobroTarjetas)AND NULLIF(LDIServicio,'') IS NOT NULL)  AND @Ok IS NULL
   BEGIN
     SELECT @LDIServicio = LDIServicio FROM FormaPago WHERE FormaPago = @FormaCobro3  AND ISNULL(LDI,0) = 1
     EXEC spLDI @LDIServicio, @ID, NULL, @Empresa, @Usuario, @Sucursal, NULL, @Importe3, 1, NULL, @Ok OUTPUT, @OkRef OUTPUT, @Modulo, @Cuenta = NULL, @Referencia = @Referencia3, @RIDCobro = NULL, @ADO = 0, @Accion = @Accion, @Estatus = @Estatus, @Estacion = @Estacion, @EstacionFija = @EstacionFija
   END       
   IF EXISTS(SELECT * FROM FormaPago WHERE FormaPago = @FormaCobro4 AND ISNULL(LDI,0) = 1 AND FormaPago NOT IN(@FormaCobroTarjetas)AND NULLIF(LDIServicio,'') IS NOT NULL)  AND @Ok IS NULL
   BEGIN
     SELECT @LDIServicio = LDIServicio FROM FormaPago WHERE FormaPago = @FormaCobro4  AND ISNULL(LDI,0) = 1
     EXEC spLDI @LDIServicio, @ID, NULL, @Empresa, @Usuario, @Sucursal, NULL, @Importe4, 1, NULL, @Ok OUTPUT, @OkRef OUTPUT, @Modulo, @Cuenta = NULL, @Referencia = @Referencia4, @RIDCobro = NULL, @ADO = 0, @Accion = @Accion, @Estatus = @Estatus, @Estacion = @Estacion, @EstacionFija = @EstacionFija
   END     
   IF EXISTS(SELECT * FROM FormaPago WHERE FormaPago = @FormaCobro5 AND ISNULL(LDI,0) = 1 AND FormaPago NOT IN(@FormaCobroTarjetas)AND NULLIF(LDIServicio,'') IS NOT NULL)  AND @Ok IS NULL
   BEGIN
     SELECT @LDIServicio = LDIServicio FROM FormaPago WHERE FormaPago = @FormaCobro5  AND ISNULL(LDI,0) = 1
     EXEC spLDI @LDIServicio, @ID, NULL, @Empresa, @Usuario, @Sucursal, NULL, @Importe5, 1, NULL, @Ok OUTPUT, @OkRef OUTPUT, @Modulo, @Cuenta = NULL, @Referencia = @Referencia5, @RIDCobro = NULL, @ADO = 0, @Accion = @Accion, @Estatus = @Estatus, @Estacion = @Estacion, @EstacionFija = @EstacionFija
   END       
  
  RETURN
END
GO


/************************ spLDITicket  *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spLDITicket') AND type = 'P') DROP PROCEDURE dbo.spLDITicket
GO             
CREATE PROCEDURE spLDITicket

  @ID	                int,
  @Estacion             int

            
--//WITH ENCRYPTION             
AS BEGIN
  DECLARE @Comprobante     varchar(max),
          @IDLog           int,
          @Resultado       bit
          
  SELECT @Resultado = 0        
          
  IF (EXISTS(SELECT * FROM VentaCobro v  JOIN FormaPago f ON v.FormaCobro1 = f.FormaPago WHERE v.ID  = @ID AND ISNULL(LDI,0) = 1) OR 
     EXISTS(SELECT * FROM VentaCobro v  JOIN FormaPago f ON v.FormaCobro2 = f.FormaPago WHERE v.ID  = @ID AND ISNULL(LDI,0) = 1) OR 
     EXISTS(SELECT * FROM VentaCobro v  JOIN FormaPago f ON v.FormaCobro3 = f.FormaPago WHERE v.ID  = @ID AND ISNULL(LDI,0) = 1) OR 
     EXISTS(SELECT * FROM VentaCobro v  JOIN FormaPago f ON v.FormaCobro4 = f.FormaPago WHERE v.ID  = @ID AND ISNULL(LDI,0) = 1) OR 
     EXISTS(SELECT * FROM VentaCobro v  JOIN FormaPago f ON v.FormaCobro5 = f.FormaPago WHERE v.ID  = @ID AND ISNULL(LDI,0) = 1) )
    IF EXISTS(SELECT * FROM  LDIMovLog WHERE Modulo = 'VTAS' AND IDModulo = @ID AND DescripcionRespuesta LIKE '%Aprobada%')
    BEGIN
      SELECT TOP 1 @Comprobante = Comprobante FROM LDIMovLog WHERE Modulo = 'VTAS' AND IDModulo = @ID AND DescripcionRespuesta LIKE '%Aprobada%'
      DELETE POSLDITicket WHERE Estacion = @Estacion
      INSERT  POSLDITicket(Estacion, RID, Campo)
      SELECT               @Estacion, @ID, Campo
        FROM dbo.fnPOSGenerarTicket(@Comprobante,'<BR>')
        
      SELECT @Resultado = 1  
    
    END          

  SELECT @Resultado

  

END
GO 

/************************ spLDIInsertarEstacionTemp *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spLDIInsertarEstacionTemp') AND type = 'P') DROP PROCEDURE dbo.spLDIInsertarEstacionTemp
GO             
CREATE PROCEDURE spLDIInsertarEstacionTemp

  @Estacion             int,
  @EstacionFija         int

            
--//WITH ENCRYPTION             
AS BEGIN
  DELETE LDIEstacionTemp WHERE Estacion = @Estacion
  
  INSERT LDIEstacionTemp(Estacion, EstacionFija)
  SELECT                 @Estacion, NULLIF(@EstacionFija,0)
  
END
GO 
