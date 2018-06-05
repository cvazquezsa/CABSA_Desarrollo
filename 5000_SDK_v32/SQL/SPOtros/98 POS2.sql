SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO


/*********** FN_MAVIRM0906CobxPol  ***********/
IF OBJECT_ID('FN_MAVIRM0906CobxPol ', 'FN') IS NOT NULL DROP FUNCTION FN_MAVIRM0906CobxPol  
GO
CREATE FUNCTION DBO.FN_MAVIRM0906CobxPol (
	@ID varchar (15)
)
RETURNS varchar(10)  
AS
BEGIN
	DECLARE 
	@COB		varchar(10),
	@DV			int,
	@DI			int,
	@DVEC		int,
	@DINAC		int,
	@SECC		varchar(50)

	SET @DV=(SELECT ISNULL(NUMERO,0) FROM TABLANUMD WITH (NOLOCK) WHERE  TABLANUM='CFG DV-DI POLITICA QUITA MORATORIOS')
	SET @DI=(SELECT ISNULL(VALOR,0) FROM TABLANUMD WITH (NOLOCK) WHERE  TABLANUM='CFG DV-DI POLITICA QUITA MORATORIOS')
	SET @SECC=(SELECT CTA.SECCIONCOBRANZAMAVI FROM CXC C,
           CTEENVIARA CTA WITH (NOLOCK) WHERE C.CLIENTEENVIARA=CTA.ID AND C.CLIENTE=CTA.CLIENTE
            AND C.ID=@ID)

	IF EXISTS(SELECT * FROM CXCMAVI WHERE ID=@ID) AND @SECC <>'INSTITUCIONES'
		BEGIN
			SET @DVEC=(SELECT ISNULL(DIASVENCACTMAVI,0) FROM CXCMAVI WITH (NOLOCK) WHERE ID=@ID)
            SET @DINAC=(SELECT ISNULL(DIASINACACTMAVI,0) FROM CXCMAVI WITH (NOLOCK) WHERE ID=@ID)
            SET @COB= CASE WHEN (@DVEC>=@DV OR @DINAC>=@DI)THEN 'SI' ELSE 'NO' END
		END
	ELSE
		SET @COB='NO' 

	RETURN @COB
END
GO

/*********** fnClaveAfectacionMAVI  ***********/
IF OBJECT_ID('fnClaveAfectacionMAVI ', 'FN') IS NOT NULL DROP FUNCTION fnClaveAfectacionMAVI  
GO
CREATE FUNCTION dbo.fnClaveAfectacionMAVI(
	@Mov		varchar(20), 
	@Modulo		varchar(5)
) 
RETURNS varchar(20)
AS 
BEGIN
	DECLARE 
	@Clave		varchar(20) 

	SET @Clave = NULL

	SELECT @Clave = Clave
	FROM MovTipo
	WHERE Modulo = @Modulo AND Mov = @Mov
	SELECT @Clave = RTRIM(@Clave)

	RETURN (@Clave)
END
GO

/***********  fnGeneraMoratorioMAVI  ***********/
IF OBJECT_ID('fnGeneraMoratorioMAVI ', 'FN') IS NOT NULL DROP FUNCTION fnGeneraMoratorioMAVI  
GO
CREATE FUNCTION dbo.fnGeneraMoratorioMAVI (
	@ID		int
)  
RETURNS char(1)  
AS 
BEGIN  
	DECLARE 
	@Mov						varchar(20),  
	@MovID						varchar(20),          
	@CanalVentas				int,  
    @GeneraMovMor				bit,  
	@Cliente					varchar(10),  
	@Concepto					varchar(50),  
	@GeneraClienteMor			bit,  
	@GeneraMoratorio			char(1),  
	@GeneraCanalMor				bit,  
	@Excepcion					char(1),  
	@SeccionCobranza			varchar(50),  
	@Vencimiento				datetime,  
	@FechaActual				datetime,  
	@MovPadre					varchar(20),  
	@CategoriaCanal				varchar(50),  
	@CalculoMoratorioMAVI		bit,  
	@MovPadre1					varchar(20),  
	@MovIDPadre					varchar(20),
	@InteresMoratoriosMAVI		money  
  
	SELECT @GeneraMoratorio = '0'  
	
	SELECT @FechaActual = GetDate()  
  
	-- OBTENER LA INF DEL DOCTO  
	SELECT 
		@Cliente = Cliente,  
        @Mov   = Mov,  
        @MovID = MovID,  
        @CanalVentas = ClienteEnviarA,    
        @Concepto = Concepto,  
        @Vencimiento = Vencimiento ,
        @InteresMoratoriosMAVI = InteresesMoratoriosMAVI 
	FROM CXC 
	WHERE ID = @ID      
  
	SELECT @CalculoMoratorioMAVI = ISNULL(CalculoMoratorioMAVI,0)  
    FROM Cte 
	WHERE Cliente = @Cliente  
  
	SELECT @MovPadre = ISNULL(Origen,@Mov) 
	FROM Cxc 
	WHERE ID = @ID  
  
	SELECT 
		@GeneraCanalMor = ISNULL(GeneraCargoxMoratorio,0),  
        @CategoriaCanal = Categoria  
    FROM VentasCanalMAVI 
	WHERE ID = @CanalVentas  
  
	IF @Mov = 'ENDOSO' 
		SELECT  @MovPadre = 'ENDOSO'  -- Aki me kede esto era para endosos  
	
	IF @Mov in ('Contra Recibo','Contra Recibo Inst')  
		BEGIN  
			SELECT @MovPadre1 = Origen, @MovIDPadre = OrigenID 
			FROM CXC 
			WHERE ID = @ID  
			
			SELECT @MovPadre = Origen 
			FROM CXC 
			WHERE Mov = @MovPadre1 AND MovID = @MovIDPadre  
		END   
  
	IF @FechaActual <= @Vencimiento  -- OR @InteresMoratoriosMAVI > 0
		BEGIN
			IF @InteresMoratoriosMAVI > 0
				SELECT @GeneraMoratorio = '1'  
			ELSE  
				SELECT @GeneraMoratorio = '0'  
		END  
	ELSE  
		BEGIN  
			-- 1) EVALUAR SI EL MOV GENERA MORATORIOS  
			SELECT @GeneraMovMor = ISNULL(CalculoMoratorioMAVI,0) 
			FROM MovTipo 
			WHERE Modulo ='CXC' AND Mov = @MovPadre      
      
			-- 2) SI NO ESTA EN LAS EXCEPCIONES PARA CALCULO DE MORATORIOS  
			IF @GeneraMovMor = 1  
				BEGIN  
					SELECT @GeneraMoratorio = '1'  
      
					IF EXISTS(SELECT * FROM CalculoMoratoriosExMAVI WHERE Mov = @Mov AND Concepto = @Concepto )  
						SELECT @GeneraMoratorio = '0'  
					ELSE  
						BEGIN  
							SELECT @GeneraMoratorio = '1' --SELECT @Excepcion = 1  
              
							-- 4) SI LA SECCION DE COBRANZA DEL CANAL DE VENTAS ES 'CREDITO MENUDEO' AÚN CUANDO EL CANAL DE VTAS NO GENERE MORATORIOS, SÍ GENERA  
							IF @GeneraCanalMor = 0  
								BEGIN  
									SELECT @SeccionCobranza = SeccionCobranzaMAVI 
									FROM CteEnviarA 
									WHERE Cliente = @Cliente AND ID = @CanalVentas  
						
									IF @SeccionCobranza = 'CREDITO MENUDEO' AND @CategoriaCanal = 'INSTITUCIONES' -- @GeneraMovMor = 1 SELECT @GeneraCanalMor = 1  
										SELECT @GeneraMoratorio = '1'   
									ELSE  
										SELECT @GeneraMoratorio = '0'  
								END  
							ELSE         
								SELECT @GeneraMoratorio = '1'  
						END  
				END  
		END   
	
	RETURN (@GeneraMoratorio)  
END
GO


/***********  fnIDDelMovimientoMAVI  ***********/
IF OBJECT_ID('fnIDDelMovimientoMAVI ', 'FN') IS NOT NULL DROP FUNCTION fnIDDelMovimientoMAVI  
GO
CREATE FUNCTION dbo.fnIDDelMovimientoMAVI(
	@Mov		varchar(20), 
	@MovID		varchar(20)
)  
RETURNS int  
AS   
BEGIN    
	DECLARE   
	@ID		int  
  
	SELECT @ID = 0  
  
	IF EXISTS(SELECT ID FROM Cxc WHERE Mov = @Mov AND MovID = @MovID AND Estatus IN('PENDIENTE','CONCLUIDO'))  
		SELECT @ID = ID 
		FROM Cxc 
		WHERE Mov = @Mov AND MovID = @MovID AND Estatus IN('PENDIENTE','CONCLUIDO')  
	ELSE  
		SELECT TOP 1 @ID = ID 
		FROM Cxc 
		WHERE Mov = @Mov AND MovID = @MovID AND Estatus = 'CANCELADO'         

	RETURN (@ID)    
END
GO

--*** AKI
/***********  fnIDOrigenCXCMovMAVI  ***********/
IF OBJECT_ID('fnIDOrigenCXCMovMAVI ', 'FN') IS NOT NULL DROP FUNCTION fnIDOrigenCXCMovMAVI  
GO
CREATE FUNCTION [dbo].[fnIDOrigenCXCMovMAVI] (
	@ID		INT
)
RETURNS INT
AS
BEGIN
	DECLARE 
	@Result INT,
	@Mov VARCHAR(20),
	@MovID VARCHAR(20),
	@Concepto VARCHAR(50),
	@Clave VARCHAR(20),
	@Origen VARCHAR(20),
	@OrigenID VARCHAR(20),
	@OID INT,
	@Ban TINYINT,
	@Excepc INT

	/*Iniciar la Bandera en 1 y la Excepcion. Tomar despues la clave de Afectacion del Movimiento. */
	SELECT @Ban = 1, @Excepc = 1, @Clave=CV.Clave, @Mov=C.Mov, @MovID=C.MovID
	FROM dbo.Cxc C
	INNER JOIN dbo.MovTipo CV ON C.Mov = CV.Mov
	WHERE C.ID=@ID AND Modulo='CXC'

	/*Validar si entrará en el ciclo del While para buscar los origenes del Movimiento*/
	IF @Clave IN ('CXC.D','CXC.CA')
	BEGIN
	/*Inicia el IF @Clave*/
		/* Mientras la Bandera este en 1 busca el Origen del Movimiento	*/
		WHILE @Ban = 1
		BEGIN
			/*	Buscar el Origen y El OrigenID del Movimiento	*/
			SELECT @Origen = Origen, @OrigenID = OrigenID
			FROM dbo.Cxc
			WHERE Mov = @Mov AND MovID = @MovID

			/*	Si el Origen es igual al mismo movimiento se sale del While	*/
			IF @Origen = @Mov AND @OrigenID = @MovID
				BREAK
			/*	Si el Movimiento no tiene Origen toma el Origen del Movimiento Mismo	*/
			IF @Origen IS NULL AND @OrigenID IS NULL
				SELECT @Origen=@Mov, @OrigenID=@MovID
			/*	Si el Movimiento no tiene OrigenID se le asigna un espacio vacio y activa la salida del while.	*/
			IF @OrigenID IS NULL
				SELECT @OrigenID='', @Ban=2

			/*	Si el Origen o el movimiento es una Nota de Cargo con concepto que comience por "CANC COBRO " entra al IF */
			IF (@Origen LIKE 'Nota Cargo%' OR @Mov LIKE 'Nota Cargo%') AND NOT @Mov = 'Documento'
			BEGIN
			/*<IF Notas Cargo>*/
				/*Obtener el Concepto de la Nota de Cargo */
				SET @Concepto = 
						CASE WHEN @Mov LIKE 'Nota Cargo%' THEN 
							(SELECT Concepto FROM CXC WHERE Mov=@Mov AND MovID=@MovId) 
						ELSE (SELECT C.Concepto
							  FROM MovFlujo MF
							  INNER JOIN dbo.Cxc C ON MF.OID=C.ID
							  WHERE DMov = @Mov AND DMovID = @MovId AND dmodulo='CXC') 
						END
				/*Si el Concepto comienza por "CANC COBRO " entra al if*/
				IF @Concepto LIKE 'CANC COBRO %'
				BEGIN
				/*<IF @Concepto>*/
					/*	Se intenta buscar el ID del movimiento si lo tiene en CXC o en MovFlujo.	*/
					SET @OID =	CASE WHEN @Mov LIKE 'Nota Cargo%' THEN 
							(SELECT id FROM CXC WHERE MOV=@Mov AND Movid=@MovId) 
						ELSE (SELECT OID FROM MovFlujo WHERE DMov = @Mov AND DMovID = @MovId AND dmodulo='CXC') 
						END
					--Si el ID del Movimiento no es Nulo Entra al IF
					IF @OID IS NOT NULL
					BEGIN
					/*<IF @OID>*/
						--Verificar que se haya guardado el campo extra correctamente.
						--MODIFCACION:		JAG		10-06-2010		SE AGREGO EL CASE DE VALIDACION DE MOV
						IF (SELECT CHARINDEX('_',Valor) FROM MovCampoExtra WHERE Modulo = 'CXC' AND ID=@OID AND CAMPOEXTRA = CASE @Mov WHEN 'Nota Cargo' THEN 'NC_FACTURA'
							WHEN 'Nota Cargo VIU' THEN 'NCV_FACTURA' 
							WHEN 'Nota Cargo MAYOREO' THEN 'NCM_FACTURA' END
							) <> 0
						BEGIN
							-- Se construye el Origen y el OrigenID a partir del campo extra
							-- MODIFCACION:		JAG		10-06-2010		SE AGREGO EL CASE DE VALIDACION DE MOV
							SELECT @Origen = LEFT(Valor,CHARINDEX('_',Valor)-1), @OrigenID = RIGHT(Valor,(LEN(Valor)-CHARINDEX('_',Valor)))
							FROM MovCampoExtra WHERE Modulo='CXC' AND ID=@OID AND CAMPOEXTRA = CASE @Mov WHEN 'Nota Cargo' THEN 'NC_FACTURA'
																										WHEN 'Nota Cargo VIU' THEN 'NCV_FACTURA' 
																										WHEN 'Nota Cargo MAYOREO' THEN 'NCM_FACTURA' END
						END
						/*Si no se guardo correctamente el campo extra se toma la nota de cargo como Origen*/
						ELSE
							SELECT @Origen = @Mov, @OrigenID=@MovID

						/*	Si tiene origen entra al if	*/
						IF @Origen IS NOT NULL
							SELECT @Mov=@Origen, @MovID=@OrigenID
						ELSE
						/*	Si no tiene origen toma el Mov como Origen y se sale del While*/
						BEGIN
							SELECT @Origen=@Mov, @OrigenID=@MovID
							BREAK
						END
						/*	Si el Origen de la Nota de Cargo es un Endoso se sale del While */
						IF @Origen='Endoso'
							BREAK
					/*</IF @OID>*/
					END
					ELSE
					/*	Si el @OID es nulo se toma el Mov como Origen y se pone la bandera en 2 para salir del While*/
					BEGIN
						SELECT @Origen=@Mov, @OrigenID=@MovID
						SET @Ban = 2
					END
				/*</IF @Concepto>*/
				END
			/*</IF Notas Cargo>*/
			END
			ELSE
			BEGIN
			/*<No Nota Cargo>*/
				/*	Si el Origen es igual al Movimiento se sale del While	*/
				IF @Origen = @Mov AND @OrigenID = @MovID
				BREAK

				/*	Excepcion para el caso de que no sean los movimientos de Refinanciamiento */
				IF @Mov <> 'Refinanciamiento'
				BEGIN
					SET @Mov = @Origen
					SET @MovID = @OrigenID
				END
				ELSE
				/*	Si es un Refinanciamiento toma el Origen como el mismo Refinanciamiento para que no tome la Solicitud y se sale.	*/
				BEGIN
					/*	Si el Origen y el Mov son el mismo se sale del While	*/
					SELECT @Origen=@Mov,@OrigenID=@MovID
					BREAK
				END
			/*</No Nota Cargo>*/
			END
			/*Excepcion para el While que evita que se cicle en algun momento.*/
			SET @Excepc = @Excepc + 1
			/* Si un solo movimiento se ciclo 100 veces se sale del while para evitar el ciclo infinito */
			IF @Excepc > 100 BREAK
		/*	FIN del While*/
		END
	/*Termina el IF @Clave*/
	END
	/*	Si no es la Clave de Afectacion de busqueda de origenes toma como Origen el Mismo Movimiento.*/
	ELSE
		SELECT @Origen=@Mov,@OrigenID=@MovID

/* Si la Opcion seleccionada en el parametro OP es Mov o MovID se regresa el campo seleccionado sino se concatenan con un - */
IF @MovID IS NULL OR @OrigenID IS NULL
	SELECT @Result = @ID
ELSE
	SELECT @Result = ID FROM dbo.Cxc WHERE Mov=@Origen AND MovID=@OrigenID

/*	Se retorna el valor obtenido por la función	*/
--SELECT @Result
RETURN @Result
-- FIN DE LA FUNCION
END
GO


/***********  fnIDPadreAplicaCobroCFD  ***********/
IF OBJECT_ID('fnIDPadreAplicaCobroCFD', 'FN') IS NOT NULL
  DROP FUNCTION fnIDPadreAplicaCobroCFD
GO
CREATE FUNCTION dbo.fnIDPadreAplicaCobroCFD (@ID int)    
RETURNS int    
AS BEGIN    
    
DECLARE    
--@id int,     
@Aplica varchar(20),     
@AplicaID varchar(20),     
@IDMovAplica int,     
@Padre varchar(45),     
@IDPadre int,  
@MovP varchar(20),  
@MovIDP varchar(20) ,
@Empresa char(5)   
    
--select @id=3992087    
    
SELECT TOP 1 @Aplica=Aplica, @AplicaID=AplicaID FROM CxCD WITH (NOLOCK) WHERE ID=@ID     
    
SELECT @IDMovAplica=ID,@Empresa = Empresa FROM Cxc WITH (NOLOCK) WHERE Mov=@Aplica AND MovID=@AplicaID     
    
IF ((SELECT Concepto FROM Cxc WITH (NOLOCK) WHERE ID=@IDMovAplica) IN ('MORATORIOS MAYOREO', 'MORATORIOS MENUDEO') )     
 SELECT @Padre=REPLACE(Valor, '_', ' '),@MovP =SUBSTRING(Valor,1,CHARINDEX('_',Valor) -1),
	@MovIDP=SUBSTRING(Valor,CHARINDEX('_',Valor)+1,255) FROM MovCampoExtra WITH (NOLOCK) WHERE ID=@IDMovAplica AND Modulo='CXC' AND CampoExtra IN ('NC_FACTURA', 'NCM_FACTURA', 'NCV_FACTURA')    
ELSE     
 SELECT @Padre=PadreMavi + ' ' + PadreIDMavi,@MovP = PadreMavi,@MovIDP = PadreIDMavi FROM Cxc WITH (NOLOCK) WHERE ID=@IDMovAplica    
  
SELECT @IDPadre=ID FROM Cxc WITH (NOLOCK) WHERE  MovID = @MovIDP AND Mov = @MovP AND Empresa = @Empresa--Mov +' ' + MovID=@Padre    
    
RETURN (@IDPadre)    
END
GO



/***********  fnInteresMoratorioMAVI  ***********/
IF OBJECT_ID('fnInteresMoratorioMAVI', 'FN') IS NOT NULL
  DROP FUNCTION fnInteresMoratorioMAVI
GO
CREATE FUNCTION dbo.fnInteresMoratorioMAVI
(                
                @ID	int  -- id del Docto
)
RETURNS float -- int
AS BEGIN
  DECLARE	@FactorIM				float, 
			@Empresa				char(5),
			@FechaActual			datetime,
			@FechaUltPagoInt		datetime,
			@PagosRealizados		money,
			@NumPagosRealizados		int,
			@Mov					varchar(20),
			@MovID					varchar(20),
			@SaldoVencido			money,
			@InteresesAcumulados	money,
			@InteresesOrdinarios	money,
			@Moratorio				float,
			@TasaDiaria				float,
			@Capital				money

  -- Obtener la inf del docto
  SELECT @Mov   = Mov,
         @MovID = MovID
  --       @IMAcum = 
    FROM CXC WHERE ID = @ID      
  
  SELECT @FactorIM = ISNULL(dbo.fnFactorIMMAVI(@ID),0)   
  SELECT @Empresa = Empresa,
         @SaldoVencido = ISNULL(Saldo,0),
         @InteresesOrdinarios = ISNULL(InteresesOrdinarios,0),
         @InteresesAcumulados = ISNULL(InteresesMoratoriosMAVI,0)
    FROM Cxc WHERE ID = @ID

  IF @Mov in ('Credilana','Prestamo Personal')
    SELECT @SaldoVencido =  @SaldoVencido - ISNULL(@InteresesOrdinarios,0)
  
  SELECT @TasaDiaria = (ISNULL(CxcMoratoriosTasa,0.0)/100) FROM EmpresaCfg WHERE Empresa = @Empresa
  -- Fórmula
  SELECT @Moratorio = (( @FactorIM * @TasaDiaria ) * @SaldoVencido) + @InteresesAcumulados
  
  RETURN (ROUND(@Moratorio,2))
END
GO



/***********  fnMaviObtieneMovSaldoMoratorios  ***********/
IF OBJECT_ID('fnMaviObtieneMovSaldoMoratorios', 'FN') IS NOT NULL
  DROP FUNCTION fnMaviObtieneMovSaldoMoratorios
GO
    CREATE FUNCTION dbo.fnMaviObtieneMovSaldoMoratorios
        (
          @Mov		varchar(20),
		  @Flujo	varchar(20),
		  @UEN		int
        )
      RETURNS varchar(20)
    AS
    BEGIN
        DECLARE @SaldoMov	varchar(20),
				@Hijo		int,
				@Cont		int,
				@ID			int

		IF NOT EXISTS (SELECT DISTINCT Mov FROM MaviMovimientosFlujo WHERE Mov = @Mov AND Flujo = @Flujo AND UEN = @UEN)
			BEGIN
				SELECT @SaldoMov = NULL
				RETURN @SaldoMov
			END
		SELECT @Cont = 1,@Hijo = 1
		SELECT @ID = ID,@Hijo = Hijo,@SaldoMov = Mov FROM MaviMovimientosFlujo WHERE Mov = @Mov AND Flujo = @Flujo AND UEN = @UEN

		WHILE (@Hijo = 1)
			BEGIN
				IF(SELECT Hijo FROM MaviMovimientosFlujo WHERE ID = @ID AND Flujo = @Flujo AND UEN = @UEN) = 0
					BEGIN
						SELECT @SaldoMov = Mov FROM MaviMovimientosFlujo WHERE ID = @ID  AND Flujo = @Flujo AND UEN = @UEN
						SELECT @Hijo = Hijo FROM MaviMovimientosFlujo WHERE ID = @ID  AND Flujo = @Flujo AND UEN = @UEN
					END
				ELSE IF (SELECT Hijo FROM MaviMovimientosFlujo WHERE Padre = @ID AND Flujo = @Flujo AND UEN = @UEN) = 0
					BEGIN
						SELECT @SaldoMov = Mov FROM MaviMovimientosFlujo WHERE Padre = @ID AND Flujo = @Flujo AND UEN = @UEN
						SELECT @Hijo = Hijo FROM MaviMovimientosFlujo WHERE Padre = @ID  AND Flujo = @Flujo AND UEN = @UEN
					END
				ELSE
					BEGIN
						SELECT @ID = ID FROM MaviMovimientosFlujo WHERE Padre = @ID AND Flujo = @Flujo AND UEN = @UEN
						SELECT @Hijo = Hijo FROM MaviMovimientosFlujo WHERE Padre = @ID AND Flujo = @Flujo AND UEN = @UEN
						IF @Hijo = 0
							SELECT @SaldoMov = Mov FROM MaviMovimientosFlujo WHERE Padre = @ID AND Flujo = @Flujo AND UEN = @UEN
					END
			END
		RETURN @SaldoMov
    END
GO


/***********  fnMayor12MesesMAVI  ***********/
IF OBJECT_ID('fnMayor12MesesMAVI', 'FN') IS NOT NULL
  DROP FUNCTION fnMayor12MesesMAVI
GO
CREATE FUNCTION dbo.fnMayor12MesesMAVI(@Condicion varchar(50)) 
RETURNS Int
AS 
BEGIN

DECLARE 
@NoMeses int,
@TipoCondicion varchar(20), 
@DANumeroDocumentos int,
@Meses int, 
@DiasVencimiento int
 
SET @NoMeses = 0
SET @DANumeroDocumentos = 0
SET @Meses = 0
SET @DiasVencimiento = 0

SELECT @TipoCondicion = TipoCondicion, @DANumeroDocumentos = DANumeroDocumentos, @Meses = Meses, @DiasVencimiento = @DiasVencimiento FROM Condicion WHERE Condicion = @Condicion

IF @TipoCondicion <> 'Contado'
  BEGIN
     SELECT @NoMeses = ISNULL(@DANumeroDocumentos, ISNULL(@Meses,(ISNULL(@DiasVencimiento,0)/30)))
  END
ELSE 
  SET @NoMeses = 0


RETURN (@NoMeses)

END
GO



/***********  fnSaldoPendienteMovPadreMAVI  ***********/
IF OBJECT_ID('fnSaldoPendienteMovPadreMAVI', 'FN') IS NOT NULL
  DROP FUNCTION fnSaldoPendienteMovPadreMAVI
GO
CREATE FUNCTION [dbo].[fnSaldoPendienteMovPadreMAVI](@ID int)  
RETURNS money  
AS   
BEGIN  
  
DECLARE   
@Saldo   money,  
@Mov   varchar(20),  
@MovID   varchar(20),  
@HayNotas int  
  
DECLARE  @DocPendtes TABLE(Saldo money,Mov varchar(20),MovID varchar(20))  
  
SELECT @Saldo = 0.0  
IF EXISTS(SELECT ID FROM Cxc WHERE ID = @ID AND Estatus IN('CONCLUIDO','PENDIENTE'))  -- Verificamos que el movimiento padre este concluido o pendiente  
  BEGIN   
    SELECT @Mov = Mov, @MovID = MovID FROM Cxc WHERE ID = @ID  
    IF ((SELECT Estatus FROM Cxc WHERE ID = @ID)='PENDIENTE')  
      SELECT @Saldo = ISNULL(Saldo,0.0) FROM Cxc WHERE ID = @ID    -- Si el estatus del movimiento padre es pendiente entonces tomamos su saldo ya que no genero documentos  
    ELSE  
    BEGIN  
   INSERT @DocPendtes(Saldo,Mov ,MovID)  
    SELECT Saldo,Mov, MovID FROM Cxc WHERE Origen = @Mov AND OrigenID = @MovID AND Estatus = 'PENDIENTE'   
       
      SELECT @HayNotas = ISNULL(count(mov),0) from Cxc Where PadreIDMAVI = @MovID and PadreMAVI= @Mov and Estatus='PENDIENTE' and Mov = 'Nota Cargo' and Concepto IN('CANC COBRO FACTURA','CANC COBRO CRED Y PP')  
      IF @HayNotas <> 0  
      BEGIN  
         INSERT @DocPendtes(Saldo,Mov ,MovID)  
         SELECT Saldo,Mov,MovID from Cxc Where PadreIDMAVI = @MovID and PadreMAVI= @Mov and Estatus='PENDIENTE' and Mov = 'Nota Cargo' and Concepto IN('CANC COBRO FACTURA','CANC COBRO CRED Y PP')  
      END  
     SELECT @Saldo = SUM(ISNULL(Saldo,0.0)) FROM @DocPendtes  
       
    END   
        
      
  END  
  
RETURN (@Saldo)  
END
GO



/***********  fnSaldoPMMAVI  ***********/
IF OBJECT_ID('fnSaldoPMMAVI', 'FN') IS NOT NULL
  DROP FUNCTION fnSaldoPMMAVI
GO
CREATE FUNCTION dbo.fnSaldoPMMAVI(@ID int)    
RETURNS float    
AS     
BEGIN    
  DECLARE @IDC              int,    
          @Padre            varchar(30),    
          @PadreID          varchar(30),             
          @SaldoCapital     float       
     
  SELECT  @SaldoCapital= 0.00    
     
  SELECT @Padre = PadreMAVI, @PadreID = PadreIDMAVI FROM CXC WHERE ID = @ID   
  SELECT @SaldoCapital = SUM(Saldo) FROM CXC WHERE PadreMAVI = @Padre and PadreIDMAVI = @PadreID AND Estatus = 'PENDIENTE'       
    
  RETURN (ISNULL(@SaldoCapital,0))    
END
GO



/***********  fnFactorIMMAVI  ***********/
IF OBJECT_ID('fnFactorIMMAVI', 'FN') IS NOT NULL
  DROP FUNCTION fnFactorIMMAVI
GO
CREATE FUNCTION dbo.fnFactorIMMAVI (@ID int)      
RETURNS float      
AS       
      BEGIN            
         DECLARE @FactorIM float      
           ,@Origen char(20)      
           ,@OrigenID char(20)      
           ,@Vencimiento datetime      
           ,@FechaActual datetime      
           ,@FechaDocOrig datetime      
           ,@FechaUltIntereses datetime      
           ,@FechaUltInteresesPeer datetime      
           ,@MontoVencido float      
           ,@RestaDiasNatural float      
           ,@IDCXCTemp int      
           ,@Mov char(20)      
           ,@MovID char(20)      
           ,@FechaVencTemp datetime      
           ,@FechaOriginalTemp datetime      
           ,@PagosRealizados float      
           ,@ProporcionPagos float      
           ,@FechaLimiteProp datetime      
           ,@DiasConProporcionIM float      
           ,@CxcAnterior int      
           ,@ImporteDocumento float      
           ,@DiasMesOrigen int      
           ,@DiasMesDestino int      
           ,@FechaDiasTotal datetime      
           ,@MesVencimiento int      
           ,@MovTipo char(20)      
           ,@Estatus varchar(15)          
           -----creadas x innova-tec          
           ,@d_dias datetime      
           ,@t_vmes int      
           ,@t_vaño int      
           ,@t_vdias int      
           ,@t_ldias int      
           ,@d_ldias datetime          
            
    ----  Inicializa Variables             
         SELECT   @FechaActual = GETDATE()      
                 ,@RestaDiasNatural = 0.00      
                 ,@MontoVencido = 0.00      
                 ,@PagosRealizados = 0      
                 ,@ImporteDocumento = 1      
                 ,@PagosRealizados = 0.00      
                 ,@ProporcionPagos = 0.00             
            
             
    -- Obtener la inf del docto            
         SELECT   @Mov = C.Mov      
                 ,@MovID = C.MovID      
                 ,@Origen = C.Origen      
                 ,@OrigenID = C.OrigenID      
                 ,@Vencimiento = ISNULL(C.Vencimiento,C.FechaEmision)      
                 ,@MovTipo = mt.Clave      
                 ,@ImporteDocumento = ISNULL(C.Importe,1) + ISNULL(C.Impuestos,      
                                                              0)      
                  - ISNULL(C.Retencion,0)      
                 ,    ----  Importe Total            
                  @FechaUltIntereses = ISNULL(C.FechaOriginal,C.Vencimiento)      
                 ,@FechaDocOrig = C.FechaEmision      
                 ,@Estatus = Estatus      
         FROM     CXC C WITH (NOLOCK)      
                 JOIN MovTipo mt On mt.Mov=C.Mov            
         WHERE    ID=@ID      
                  AND mt.Modulo='CXC'      
        -----innova-tec-------          
         SET @d_dias = dbo.fnFechaSinHora ( @Vencimiento )         
         --SET @d_dias = CONVERT(varchar(10),@d_dias,103)          
         SET @t_vdias = DATEDIFF(DD,@d_dias,      
                                 DATEADD(MM,1,@d_dias - DAY(@d_dias) + 1))          
        --------------------------------------------------------------------------------          
         SET @t_vmes = MONTH(@Vencimiento)          
         SET @t_vaño = YEAR(@Vencimiento)          
            
         IF @Estatus='PENDIENTE'       
            BEGIN            
      ---   Genera RestaDiasNAtural            
               SELECT   @RestaDiasNatural = DATEDIFF(dd,@FechaUltIntereses,      
                                                     @FechaActual)            
            
      ---   Verifica Pagos Realizados al Docuemnto             
            
               SELECT   @PagosRealizados = ISNULL(SUM(CxcD.Importe),0)      
               FROM     Cxcd WITH (NOLOCK)      
                       JOIN CXC WITH (NOLOCK) On cxcd.id=cxc.id      
               WHERE    CXC.Estatus='Concluido'      
                        AND Cxcd.Aplica=@Mov      
                        AND Cxcd.AplicaID=@MovID             
        --- notas de credito y cobros   ==      
            
      ---  Genera Proporcion             
               IF @FechaActual>=@FechaUltIntereses       
                  SELECT   @MontoVencido = @ImporteDocumento      
                           - @PagosRealizados            
               SELECT   @ProporcionPagos = ((@MontoVencido)      
                                            / @ImporteDocumento) * 100            
            
      ---- FechaLimiteProporcion             
               SELECT   @MesVencimiento = @t_vmes + 1            
               IF @MesVencimiento=13       
                  SELECT   @MesVencimiento = 1          
               SET @d_ldias = DATEADD(m,1,dbo.fnFechaSinHora (@Vencimiento))          
               --SET @d_ldias = CONVERT(varchar(10),@d_ldias,101)          
               SET @t_ldias = DATEDIFF(DD,@d_ldias,      
                                       DATEADD(MM,1,      
                                               @d_ldias - DAY(@d_ldias) + 1))          
                           
               SELECT   @DiasMesOrigen = @t_vdias           
               SELECT   @DiasMesDestino = @t_ldias          
                         
               /*dbo.fnDiasMes(@MesVencimiento, YEAR(@Vencimiento))  */          
               SELECT   @FechaDiasTotal = @Vencimiento + @DiasMesOrigen            
               IF DAY(@Vencimiento)<>DAY(@FechaDiasTotal)       
                  SELECT   @FechaDiasTotal = (@Vencimiento) + (@DiasMesDestino      
                                                              + (@DiasMesDestino      
                                                              - @DiasMesOrigen))                     
            
               SELECT   @FechaLimiteProp = @FechaDiasTotal             
                
      ---- Dias Con PRoporcion Para IM            
               IF @FechaUltIntereses>@FechaLimiteProp       
                  SELECT   @DiasConProporcionIM = 0             
               IF @FechaUltIntereses<=@FechaLimiteProp       
                  SELECT   @DiasConProporcionIM = DATEDIFF(dd,      
                                                           @FechaUltIntereses,      
                                                           @FechaLimiteProp)            
            
      ----------- Calculo de FactorIM              
      --------Select @DiasConProporcionIM=31, @RestaDiasNatural=15, @ProporcionPagos=100     -----   Prueba            
               IF @RestaDiasNatural<=@DiasConProporcionIM       
                  SELECT   @FactorIM = (@RestaDiasNatural * @ProporcionPagos      
                                        / 100)            
               IF @RestaDiasNatural>@DiasConProporcionIM       
                  SELECT   @FactorIM = ((@RestaDiasNatural      
                                         - @DiasConProporcionIM)      
                                        + (@DiasConProporcionIM      
                                           * @ProporcionPagos) / 100)            
            
              
               IF @FactorIM IS NULL       
                  SET @FactorIM = 0            
            END            
         RETURN (@FactorIM)            
      END
GO


/************************ SP_MAVIDM0043SugerirMonto *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.SP_MAVIDM0043SugerirMonto') AND type = 'P') DROP PROCEDURE dbo.SP_MAVIDM0043SugerirMonto
GO  
CREATE PROCEDURE [dbo].[SP_MAVIDM0043SugerirMonto] @IDFac INT, @ImporteTotal MONEY
--//WITH ENCRYPTION
AS BEGIN

DECLARE @Mov VARCHAR(20),@MovID VARCHAR(20)

SELECT @Mov = Mov, @MovId = MovId FROM CXC WITH(NOLOCK) WHERE ID = @IDFac

IF @Mov IN (SELECT DISTINCT Movimiento FROM MaviBonificacionMoV WITH(NOLOCK))
BEGIN
	IF EXISTS(SELECT NAME FROM TEMPDB.SYS.SYSOBJECTS WHERE ID=OBJECT_ID('Tempdb.dbo.#Bonificaciones') AND TYPE='U')          
		DROP TABLE #Bonificaciones  
	IF EXISTS(SELECT NAME FROM TEMPDB.SYS.SYSOBJECTS WHERE ID=OBJECT_ID('Tempdb.dbo.#MovsPendientes') AND TYPE='U')          
		DROP TABLE #MovsPendientes  

	CREATE TABLE #Bonificaciones(ID INT IDENTITY, Bonificacion VARCHAR(50),IDBonif INT,Porc FLOAT,Factor FLOAT,PlazoEjeFin FLOAT,Financiamiento FLOAT)
	CREATE TABLE #MovsPendientes(IDTbl INT IDENTITY(1,1),
		  ID INT NULL,      
		  Aplica  varchar(20) NULL,      
		  AplicaID  varchar(20) NULL,      
		  Vencimiento datetime NULL,      
		  Importe   MONEY NULL,      
		  Saldo   money NULL,      
		  Origen  varchar(20) NULL,      
		  OrigenId  varchar(20) NULL,
		  BonifPP MONEY NULL,
		  BonifCC MONEY NULL,
		  BonifAP MONEY NULL,
		  BonifNA MONEY NULL,
		  Moratorios MONEY NULL,
		  TotalPagar MONEY NULL,
		  TotalPP MONEY NULL,
		  CubrePP MONEY NULL
		  )


	DECLARE @LineaBonif VARCHAR(50),@IdCxC INT,@FechaEmision VARCHAR(30)
	,@Condicion VARCHAR(20),@Vencimiento VARCHAR(20),@DiasVenc INT, @SUC INT,@UEN INT
	,@DocumentoTotal INT,@Documento1de INT,@MaxDiasAtrazo FLOAT,@Referencia VARCHAR(50),@MesesAdelanto INT
	,@ImporteVenta FLOAT,@MesesExced INT ,@PlazoEjeFin INT ,@Factor FLOAT ,@Financiamiento FLOAT,@MontoBonif FLOAT,@PorcBon1 FLOAT,@DocPendiente INT

	SELECT @IdCxC=C.ID,@Condicion=C.Condicion,@Mov=C.Mov,@MovID=C.MovID,@FechaEmision=C.FechaEmision,@Vencimiento = C.Vencimiento,@DiasVenc = CM.MaxDiasVencidosMAVI,
	   @Suc=Case When (C.Comentarios like 'Saldos Iniciales%') OR (@Mov = 'Refinanciamiento') Then  c.SucursalOrigen else V.SucursalVenta end,@Uen = c.Uen   
	   ,@ImporteVenta=C.Importe+C.Impuestos
	 FROM dbo.Cxc C with(NOLOCK)
	 INNER JOIN dbo.CxcMavi CM with(NOLOCK) ON C.ID=CM.ID
	 LEFT JOIN dbo.Venta V with(NOLOCK)  ON   v.mov=c.mov and v.movid=c.movid 
	 WHERE c.Mov=@Mov AND c.MovID=@MovID

	SELECT TOP (1) 
		@DocumentoTotal=substring(Referencia,(patindex('%/%',Referencia))+1,(patindex('%)%',Referencia)) - (patindex('%/%',Referencia)) -1)
	FROM Cxc WITH(NOLOCK)
	WHERE PadreMavi = @Mov AND PadreIDMAVI = @MovID and Mov = 'Documento' 


	DECLARE @LineaCC AS TABLE (Linea VARCHAR(100))
	INSERT INTO @LineaCC (Linea)
		SELECT mbl.Linea
		 FROM MaviBonificacionConf mbc with(NOLOCK)
		 INNER JOIN MaviBonificacionMoV mbmv with(NOLOCK) ON mbc.Id = mbmv.IdBonificacion
		 INNER JOIN MaviBonificacionCondicion mbc2 with(NOLOCK) ON mbc2.IdBonificacion=mbc.ID
		 LEFT JOIN MaviBonificacionLinea mbl with(NOLOCK) ON ID=mbl.IdBonificacion
		 WHERE mbmv.Movimiento = @Mov
		 AND COndicion = @Condicion
		 AND mbc.Estatus ='CONCLUIDO'
		 AND @FechaEmision BETWEEN mbc.FechaIni AND mbc.FechaFin
		 AND mbc.NoPuedeAplicarSola = 0
		 AND Bonificacion = 'Bonificacion Contado Comercial'

			SELECT TOP 1 @LineaBonif = Linea
					  FROM BonifSIMAVI with(NOLOCK) WHERE IDCxc = @IdCxC AND Linea IN (SELECT Linea FROM @LineaCC WHERE ISNULL(Linea,'')<>'')
	        
			SELECT TOP 1 @LineaBonif = A.Linea FROM venta with(NOLOCK),ventad with(NOLOCK) 
			  LEFT OUTER JOIN Art a with(NOLOCK) ON a.Articulo = ventad.Articulo
			  WHERE venta.id = ventad.id 
			  AND venta.Mov=@Mov AND venta.MovID=@MovID
			  AND A.Linea IN (SELECT Linea FROM @LineaCC WHERE ISNULL(Linea,'')<>'')
	                                         
	SELECT TOP 1 @LineaBonif = ISNULL(@LineaBonif,Linea) FROM BonifSIMAVI with(NOLOCK) WHERE IDCxc=@IdCxC
	SELECT TOP 1 @LineaBonif = ISNULL(@LineaBonif,A.Linea) FROM venta with(NOLOCK),ventad with(NOLOCK)
			  LEFT OUTER JOIN Art a with(NOLOCK) ON a.Articulo = ventad.Articulo
			  WHERE venta.id = ventad.id 
			  AND venta.Mov=@Mov AND venta.MovID=@MovID

	INSERT INTO #Bonificaciones(Bonificacion ,IDBonif,Porc ,Factor ,PlazoEjeFin ,Financiamiento )
	SELECT DISTINCT t.Bonificacion,t.ID,
			   porce   = CASE WHEN t.Bonificacion = 'Bonificacion Adelanto en Pagos'  AND t.Linea = @LineaBonif THEN (SELECT PorcLin FROM MaviBonificacionLinea WHERE IdBonificacion=t.ID AND Linea=t.linea)
							  WHEN t.Bonificacion = 'Bonificacion No Atraso'  AND t.porce =0 AND t.Linea <> @LineaBonif THEN ll.PorcLin
							  WHEN t.Bonificacion = 'Bonificacion Adelanto en Pagos'  AND t.porce =0 AND t.Linea <> @LineaBonif THEN ll.PorcLin
							  WHEN t.Bonificacion = 'Bonificacion Contado Comercial'  AND t.Linea=@LineaBonif
									THEN (SELECT PorcLin FROM dbo.MaviBonificacionLinea WHERE IdBonificacion = t.ID AND Linea=t.Linea)
							  ELSE t.porce  END,
				t.Factor,t.plazoEjeFin,t.Financiamiento
	 FROM (
			SELECT mbc.Bonificacion,Mov=@Mov,MovId= @MovId,Condicion = @Condicion,mbc.Id,mbc.plazoEjeFin,mbc.Financiamiento, mbc.PorcBon1,
						Porce=  CASE WHEN mbc.PorcBon1 = 0 THEN isnull(mbc.Linea,0.00) ELSE mbc.PorcBon1 END 
						,Tod= case when mbc.VencimientoAntes=0 and mbc.VencimientoDesp=0 and mbc.DiasMenoresA=0 and mbc.DiasMayoresA=0 then 1 else 0 end
						,VAnt=case when mbc.VencimientoAntes=0 then 0 else case when Cast(Convert(varchar(8),GETDATE(),112) As Datetime)<= DateADD(mm,mbc.VencimientoAntes-1,@Vencimiento) then 1 else 0 end end        
						,Desp=case when mbc.VencimientoDesp=0 then 0 else case when Cast(Convert(varchar(8),GETDATE(),112) As Datetime) > DateADD(mm,mbc.VencimientoDesp-1,@Vencimiento) then 1 else 0 end end        
					   ,TopeDA=isnull(mbc.DiasAtrazo,0)
					   ,Dmenor=case when mbc.DiasMenoresA=0 then 0 else case when datediff(day,@Fechaemision,getdate())<=mbc.DiasMenoresA then 1 else 0 end end        
					   ,Dmayor=case when mbc.DiasMayoresA=0 then 0 else case when datediff(day,@Fechaemision,getdate())>=mbc.DiasMayoresA then 1 else 0 end end        ,
						mbc.Factor,mbl.Linea,DiasAtrazo=CASE WHEN mbc.Bonificacion = 'Bonificacion No Atraso' AND @DiasVenc<=mbc.DiasAtrazo AND mbc.DiasAtrazo<>0 THEN 1 
															 WHEN mbc.Bonificacion <> 'Bonificacion No Atraso' THEN 1 ELSE 0 END
			FROM MaviBonificacionConf mbc WITH(NOLOCK)
			INNER JOIN MaviBonificacionMoV mbmv WITH(NOLOCK) ON mbc.Id = mbmv.IdBonificacion
			INNER JOIN dbo.MaviBonificacionCondicion mbc2 WITH(NOLOCK) ON mbc2.IdBonificacion=mbc.ID
			LEFT JOIN dbo.MaviBonificacionLinea mbl WITH(NOLOCK) ON ID=mbl.IdBonificacion
			INNER JOIN  dbo.Sucursal s WITH(NOLOCK) ON  s.sucursal = @Suc
			INNER  JOIN dbo.MaviBonificacionSucursal MBS WITH (NOLOCK) on MBS.Sucursal=S.Tipo and mbc.id=MBS.IdBonificacion
			INNER JOIN  MaviBonificacionUEN mbu WITH (NOLOCK) on mbu.uen=@uen and mbc.id=mbu.IdBonificacion   
			WHERE mbmv.Movimiento = @Mov
			AND COndicion = @Condicion
			AND mbc.Estatus ='CONCLUIDO'
			AND @FechaEmision BETWEEN mbc.FechaIni AND mbc.FechaFin
	) t 
	LEFT JOIN dbo.MaviBonificacionLinea ll WITH(NOLOCK) ON t.ID=ll.IdBonificacion AND t.Linea=ll.Linea
	 WHERE (Tod=1 or VAnt=1 or Desp=1 or Dmenor=1 or Dmayor=1)
	 AND DiasAtrazo = 1
	 AND 1=(CASE WHEN ISNULL(@LineaBonif,'') IN (SELECT Linea FROM @LineaCC WHERE ISNULL(Linea,'')<>'') 
					AND t.Bonificacion = 'Bonificacion Contado Comercial' THEN 1 
			   WHEN NOT t.Bonificacion = 'Bonificacion Contado Comercial' THEN 1
			   WHEN ISNULL(@LineaBonif,'') NOT IN (SELECT Linea FROM @LineaCC WHERE ISNULL(Linea,'')<>'') 
					AND t.Bonificacion = 'Bonificacion Contado Comercial'
					AND ISNULL(t.Linea,'')='' THEN 1 
			   ELSE 0 END)
	 AND 1=(CASE WHEN ISNULL(@LineaBonif,'') IN (SELECT Linea FROM @LineaCC WHERE ISNULL(Linea,'')<>'') AND t.Bonificacion = 'Bonificacion Contado Comercial' 
																						  AND ISNULL(@LineaBonif,'')=ISNULL(t.Linea,'') THEN 1 
		   WHEN NOT t.Bonificacion = 'Bonificacion Contado Comercial' THEN 1
		   WHEN ISNULL(@LineaBonif,'') NOT IN (SELECT Linea FROM @LineaCC WHERE ISNULL(Linea,'')<>'') 
					AND t.Bonificacion = 'Bonificacion Contado Comercial'
					AND ISNULL(t.Linea,'')='' THEN 1
		   ELSE 0 END)


		INSERT INTO #MovsPendientes(ID ,Aplica, AplicaId, Vencimiento, Saldo, Importe, Origen, OrigenID)  
		SELECT C.ID, c.Mov, c.MovID,C.Vencimiento,c.Saldo,Importe = Importe+Impuestos, c.PadreMAVI, c.PadreIDMAVI 
		FROM Cxcpendiente C WITH(NOLOCK)
		JOIN MovTipo mt ON mt.Modulo = 'Cxc' AND mt.Mov = c.Mov             
		WHERE c.estatus = 'PENDIENTE' AND mt.Clave NOT IN ('CXC.SCH','CXC.SD','CXC.NC') 
		and PadreMAVI = @Mov AND PadreIDMAVI = @MovID  
		ORDER BY Vencimiento ASC        
	       

	DECLARE @Ini INT,@Fin INT,@Bonif VARCHAR(50)
	SELECT @Ini=MIN(ID),@Fin=MAX(ID) FROM #Bonificaciones

	WHILE @Ini<=@Fin
	BEGIN
		SELECT @Bonif = Bonificacion FROM #Bonificaciones WHERE ID=@Ini
		IF @Bonif = 'Bonificacion Pago Puntual'
		BEGIN
			SELECT @PorcBon1 = Porc/100 FROM #Bonificaciones WHERE ID=@Ini
			UPDATE #MovsPendientes SET BonifPP = ROUND((CASE WHEN Vencimiento>GETDATE() THEN Importe*@PorcBon1 ELSE 0.00 END),2)
		END
		IF @Bonif = 'Bonificacion Contado Comercial'
		BEGIN
		   SELECT @PlazoEjeFin = PlazoEjeFin,@Financiamiento=Financiamiento,@PorcBon1=Porc FROM #Bonificaciones WHERE ID=@Ini
		   SELECT @MesesExced = isnull(@DocumentoTotal,0) -  isnull(@PlazoEjeFin,0) 
		   SELECT @Factor = 1 + (@MesesExced * (isnull(@Financiamiento,0.00)/100))
		   SELECT @MontoBonif = (@PorcBon1/100) * (@ImporteVenta / @Factor)
		   SELECT @MontoBonif = @ImporteVenta - ((@ImporteVenta / @Factor)-@MontoBonif)
		   SELECT @MontoBonif=ISNULL(@MontoBonif,0)-Bonif FROM (
							SELECT CMov.Mov,CMov.MovID,Bonif=ISNULL(SUM(cd.Importe),0) FROM Cxc CMov WITH(NOLOCK)
							INNER JOIN Cxc Ccte WITH(NOLOCK) ON Ccte.Cliente=CMov.Cliente AND Ccte.Mov='Nota Credito' AND Ccte.Estatus='CONCLUIDO'
							INNER JOIN Cxc CBonif WITH(NOLOCK) ON Ccte.ID=CBonif.ID
							INNER JOIN CxcD cd WITH(NOLOCK) ON CBonif.ID = cd.ID
							INNER JOIN Cxc CPadre WITH(NOLOCK) ON CPadre.Mov=cd.Aplica AND CPadre.MovID=cd.AplicaID AND CPadre.PadreMAVI=CMov.Mov AND CPadre.PadreIDMAVI=CMov.MovID
							WHERE Ccte.Concepto = 'BONIF PAGO PUNTUAL' AND CMov.Mov=@Mov AND CMov.MovID=@MovId
							GROUP BY CMov.Mov,CMov.MovID
						)Resta
		   UPDATE #MovsPendientes SET BonifCC = ROUND(@MontoBonif/(SELECT COUNT(ID) FROM #MovsPendientes),2)
		END 
		IF @Bonif = 'Bonificacion Adelanto en Pagos'
		BEGIN
			SELECT @PorcBon1 = Porc FROM #Bonificaciones WHERE ID=@Ini
			SELECT @MesesAdelanto = CASE WHEN Vencimiento > GETDATE() 
															 THEN CASE WHEN DATEDIFF(DD,GETDATE(),Vencimiento) % 30.4 <> 0 
																			THEN CAST((DATEDIFF(DD,GETDATE(),Vencimiento) / 30.4 ) AS INT) + 1
																	   WHEN DATEDIFF(DD,Vencimiento,GETDATE())%30.4 = 0
																			THEN CAST((DATEDIFF(DD,GETDATE(),Vencimiento) / 30.4 ) AS INT)
																  END
														 ELSE 1 END
															FROM (
																SELECT 
																	N = ROW_NUMBER() OVER(PARTITION BY PadreMAVI,PadreIDMAVI ORDER BY Vencimiento DESC),
																	PadreMAVI,PadreIDMAVI,Vencimiento
																FROM Cxc WITH(NOLOCK)
																WHERE PadreMAVI = @Mov AND PadreIDMAVI = @MovID AND PadreMAVI <> Mov
															)x WHERE n=1 AND VENCIMIENTO>GETDATE()
						   IF @MesesAdelanto > @DocumentoTotal SELECT @MesesAdelanto = @DocumentoTotal
		   SELECT @PorcBon1 = @PorcBon1 * @MesesAdelanto
		   SELECT @ImporteVenta = (@ImporteVenta / @DocumentoTotal) * @MesesAdelanto
		   SELECT @ImporteVenta = @ImporteVenta / (SELECT COUNT(ID) FROM #MovsPendientes WHERE Vencimiento>GETDATE())
			SELECT @MontoBonif = (@PorcBon1/100) * @ImporteVenta 
			UPDATE #MovsPendientes SET BonifAP = (CASE WHEN Vencimiento>GETDATE() THEN ROUND(@MontoBonif,2) ELSE 0 END)
		END
		IF @Bonif = 'Bonificacion No Atraso' AND (SELECT COUNT(BonifAP) FROM #MovsPendientes WHERE BonifAP>0)>0
		BEGIN
			SELECT @ImporteVenta = Importe+Impuestos FROM dbo.Cxc WITH(NOLOCK) WHERE Mov=@Mov AND MovID=@MovID
			SELECT @PorcBon1 = Porc/100 FROM #Bonificaciones WHERE ID=@Ini
			SELECT @MontoBonif = @ImporteVenta * @PorcBon1
			UPDATE #MovsPendientes SET BonifNA = ROUND(@MontoBonif/(SELECT COUNT(ID) FROM #MovsPendientes),2)
		END	
		SET @Ini=@Ini+1	
	END
	UPDATE #MovsPendientes SET Moratorios = dbo.fnInteresMoratorioMAVI(ID)
	UPDATE #MovsPendientes SET BonifNA = ISNULL(BonifNA,0.00),BonifCC = ISNULL(BonifCC,0.00),BonifPP = ISNULL(BonifPP,0.00),BonifAP = ISNULL(BonifAP,0.00)

--AJUSTE DE BONIFICACIONES AL SALDO DE LOS DOCUMENTOS-----------------------------------------------------------------------------------------------------------------
IF EXISTS(SELECT ID FROM TEMPDB.SYS.SYSOBJECTS WHERE ID=OBJECT_ID('Tempdb.dbo.#NegociaMoratoriosMAVI') AND TYPE='U')          
	DROP TABLE #NegociaMoratoriosMAVI
CREATE TABLE #NegociaMoratoriosMAVI (Nro INT,ID INT,Mov VARCHAR(20),MovID VARCHAR(20),
									 ImporteAPagar MONEY,
									 BCC MONEY,BPP MONEY,BNA MONEY,BAP MONEY)
INSERT INTO #NegociaMoratoriosMAVI
        (Nro,ID,Mov,MovID,ImporteAPagar,BCC,BPP,BNA,BAP)
SELECT 
	IDTbl, ID, Aplica, AplicaID, Saldo, BonifCC, BonifPP, BonifNA, BonifAP
FROM #MovsPendientes

DECLARE @BonifTotal MONEY,@ImpDoc MONEY,
		@BAP MONEY,@BNA MONEY,@BPP MONEY,@BCC MONEY,
		@Porc FLOAT
SELECT @Ini=1,@Fin=MAX(Nro),@BonifTotal=0.00,@Porc=0,
	   @BAP=0.00,@BNA=0.00,@BCC=0.00
FROM #NegociaMoratoriosMAVI

WHILE @Ini<=@Fin
BEGIN
	SELECT @ImpDoc=ISNULL(ImporteAPagar,0.00) ,
		   @BAP=@BAP+BAP, @BNA=@BNA+BNA, @BCC=@BCC+BCC
	FROM #NegociaMoratoriosMAVI WHERE Nro=@Ini
	
	SET @BonifTotal = @BAP+@BNA+@BCC+@BPP
	IF @ImpDoc < @BonifTotal
	BEGIN
		UPDATE #NegociaMoratoriosMAVI SET BAP=@BAP, BNA=@BNA, BCC=@BCC
		WHERE Nro=@Ini
		
		SET @Porc = @BonifTotal-@ImpDoc
		SET @Porc = @Porc/@BonifTotal
		SELECT @BAP = ROUND(@BAP*@Porc,2),
			   @BNA = ROUND(@BNA*@Porc,2),
			   @BCC = ROUND(@BCC*@Porc,2)
		SELECT @BonifTotal = @BonifTotal - (@BAP+@BNA+@BCC)
		UPDATE #NegociaMoratoriosMAVI SET BAP=BAP-@BAP, BNA=BNA-@BNA, BCC=BCC-@BCC
		WHERE Nro=@Ini
	END
	ELSE IF @BonifTotal < @ImpDoc
			BEGIN
				UPDATE #NegociaMoratoriosMAVI SET BAP=@BAP, BNA=@BNA, BCC=@BCC
				WHERE Nro=@Ini
				SET @BonifTotal=0.00
				SET @Ini=@Fin
			END
	SET @Ini=@Ini+1
END

SELECT @Ini=1,@Fin=MAX(Nro),@BonifTotal=0.00,@Porc=0,@BPP=0.00
FROM #NegociaMoratoriosMAVI

WHILE @Ini<=@Fin
BEGIN
	SELECT @ImpDoc=ISNULL(ImporteAPagar,0.00) ,
		   @BPP=@BPP+BPP
	FROM #NegociaMoratoriosMAVI WHERE Nro=@Ini
	
	SET @BonifTotal = @BPP
	IF @ImpDoc < @BonifTotal
	BEGIN
		UPDATE #NegociaMoratoriosMAVI SET BPP=@BPP
		WHERE Nro=@Ini
		
		SET @Porc = @BonifTotal-@ImpDoc
		SET @Porc = @Porc/@BonifTotal
		SELECT @BPP = ROUND(@BPP*@Porc,2)
		SELECT @BonifTotal = @BonifTotal - (@BPP)
		UPDATE #NegociaMoratoriosMAVI SET BPP=BPP-@BPP
		WHERE Nro=@Ini
	END
	ELSE IF @BonifTotal < @ImpDoc
			BEGIN
				UPDATE #NegociaMoratoriosMAVI SET BPP=@BPP
				WHERE Nro=@Ini
				SET @BonifTotal=0.00
				SET @Ini=@Fin
			END
	SET @Ini=@Ini+1
END

UPDATE #MovsPendientes SET BonifCC = N2.BCC, BonifPP = N2.BPP, BonifNA = N2.BNA, BonifAP = N2.BAP
FROM #MovsPendientes N WITH(NOLOCK)
INNER JOIN #NegociaMoratoriosMAVI N2 ON N2.Mov=N.Aplica AND N2.MovID=N.AplicaID
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	IF (SELECT DBO.FN_MAVIRM0906CobxPol(@IDFac))='NO'
		UPDATE #MovsPendientes SET TotalPagar  = (Saldo-(BonifNA+BonifCC+BonifAP))+Moratorios,TotalPP = ROUND((Saldo-BonifPP)+Moratorios,2),CubrePP = ROUND((Saldo-BonifPP)+Moratorios,2)
	ELSE IF (SELECT DBO.FN_MAVIRM0906CobxPol(@IDFac))='SI'
		UPDATE #MovsPendientes SET TotalPagar  = (Saldo-(BonifNA+BonifCC+BonifAP)),TotalPP = ROUND((Saldo-BonifPP),2),CubrePP = ROUND((Saldo-BonifPP),2)
		
	SELECT @Ini=MIN(IDTbl)+1,@Fin=MAX(IDTbl) FROM #MovsPendientes
	WHILE @Ini<=@Fin
	BEGIN
		UPDATE #MovsPendientes SET CubrePP = CubrePP + (SELECT CubrePP FROM #MovsPendientes WHERE IDTbl=@Ini-1) WHERE IDTbl = @Ini
		SET @Ini=@Ini+1
	END

	IF @ImporteTotal >= (SELECT SUM(TotalPagar) FROM #MovsPendientes) 
		SELECT @ImporteTotal = SUM(Saldo) + SUM(Moratorios) FROM #MovsPendientes
	ELSE IF @ImporteTotal < (SELECT SUM(TotalPagar) FROM #MovsPendientes)
		SELECT @ImporteTotal = ISNULL(SUM(BonifPP),0) + @ImporteTotal FROM #MovsPendientes WHERE CubrePP <= @ImporteTotal



	SELECT @ImporteTotal
END
ELSE
	SELECT @ImporteTotal

	IF EXISTS(SELECT NAME FROM TEMPDB.SYS.SYSOBJECTS WHERE ID=OBJECT_ID('Tempdb.dbo.#Bonificaciones') AND TYPE='U')          
		DROP TABLE #Bonificaciones  
	IF EXISTS(SELECT NAME FROM TEMPDB.SYS.SYSOBJECTS WHERE ID=OBJECT_ID('Tempdb.dbo.#MovsPendientes') AND TYPE='U')          
		DROP TABLE #MovsPendientes  

END
GO



/************************ spActualizaDesglose *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spActualizaDesglose') AND type = 'P') DROP PROCEDURE dbo.spActualizaDesglose
GO
CREATE PROC [dbo].[spActualizaDesglose] 	
@ID int,
@Mov varchar(20), 
@MovID varchar(20),  
@Modulo varchar(5)
--//WITH ENCRYPTION
AS BEGIN 
DECLARE 
/*@ID int,
@Mov varchar(20), 
@MovID varchar(20),  
@Modulo varchar(5),*/

@Desglose	bit,
@Valor		varchar(200), 
@Origen		varchar(20), 
@OrigenID	varchar(20),
@CampoExtra varchar (200),  
@Referencia varchar(50),
@RefMov varchar(20),
@RefMovID varchar(20),
@IDFact int
/*select @ID=32146,
@Mov='Devolucion Venta', 
@MovID='cdma29', 
@Modulo='CxC'*/

 
 IF (@Modulo = 'VTAS' )
	BEGIN
		IF (@Mov IN('Factura','Factura VIU','Factura Mayoreo')) 
		BEGIN  
			SELECT @Desglose = FacDesgloseIVA FROM Venta  WITH (NOLOCK) WHERE Mov = @Mov AND MovID = @MovID
		 	UPDATE Cxc WITH (ROWLOCK) SET FacDesgloseIVA = @Desglose WHERE Mov = @Mov AND MovID = @MovID   --Factura creada en VTAS
        END 
        IF (@Mov LIKE('Devolucion%'))	
			BEGIN 
				SELECT @Origen=C.Mov, @OrigenID=C.MovID 
				FROM CxC C WHERE C.Mov IN ('Nota Credito', 'Nota Credito Mayoreo', 'Nota Credito VIU') 
			    AND C.Referencia = RTRIM(@Mov) + ' ' + RTRIM(@MovID) 
			   		SELECT 
						@RefMov = (SELECT CASE 
						WHEN Referencia LIKE('Factura Mayoreo_%') THEN 'Factura Mayoreo'
						WHEN Referencia LIKE('Factura VIU_%') THEN 'Factura VIU'
						WHEN Referencia LIKE('Factura_%') THEN 'Factura'    -- Para la nota de credito aplicada a cualquiera de estos documentos
				        END),
						@RefMovID = (SELECT CASE
						WHEN Referencia LIKE('Factura Mayoreo_%') THEN substring(Referencia,len('Factura Mayoreo_')+ 1,(len(Referencia)-len('Factura Mayoreo_')))
						WHEN Referencia LIKE('Factura VIU_%') THEN substring(Referencia,len('Factura VIU_')+ 1,(len(Referencia)-len('Factura VIU_')))
						WHEN Referencia LIKE('Factura_%') THEN substring(Referencia,len('Factura_')+ 1,(len(Referencia)-len('Factura_')))
						END)
						FROM Venta  WITH (NOLOCK) WHERE  Mov=@Mov AND MovID=@MovID
			    	  SELECT @Desglose = FacDesgloseIVA FROM venta  WITH (NOLOCK) WHERE Mov=@RefMov  and MovID=@RefMovID
                      UPDATE CxC WITH (ROWLOCK) SET FacDesgloseIVA= @Desglose WHERE Mov=@Origen AND MovID= @OrigenID 

			END
      END 

-- Cuentas por Cobrar

IF (@Modulo = 'CXC') 
	BEGIN 
	   	
       IF (@Mov IN ('Factura','Factura VIU','Factura Mayoreo') OR @Mov LIKE ('Devolucion%')) 
			SELECT @Mov=Mov, @MovID=MovID FROM Venta WHERE ID=@ID  
     	    ELSE
			SELECT @Mov=Mov, @MovID=MovID FROM CxC WHERE ID=@ID 
  
		IF (@Mov IN ('Factura','Factura VIU','Factura Mayoreo') ) 
		BEGIN
			SELECT @Desglose = FacDesgloseIVA FROM CxC WHERE Mov = @Mov AND MovID = @MovID   --Heredar en CXC al documento el desglose
			UPDATE CxC WITH (ROWLOCK) SET FacDesgloseIVA = @Desglose WHERE Origen=@Mov AND OrigenID=@MovID 
		END 

		IF (@Mov IN ('Nota Credito', 'Nota Credito Mayoreo', 'Nota Credito VIU'))
        BEGIN
          
			SELECT TOP 1 @Mov=Aplica, @Movid=AplicaID FROM CXCD WITH (NOLOCK) WHERE ID=@ID
			SELECT @Desglose = FacDesgloseIVA FROM CxC WITH (NOLOCK) WHERE MovID=@MovID AND Mov=@Mov -- Cuando se nace en CXC la nota de credito directo
      
        	UPDATE CxC WITH (ROWLOCK) SET FacDesgloseIVA= @Desglose WHERE ID=@ID 
        END


		IF (@Mov IN('Nota Cargo','Nota Cargo VIU','Nota Cargo Mayoreo')) 
			BEGIN
				SELECT @CampoExtra = Valor FROM MovCampoExtra WITH (NOLOCK) WHERE ID = @ID AND Modulo='CXC'
				IF @CampoExtra <> ''
					BEGIN
  						SELECT 
						@Mov = (SELECT CASE 
						WHEN Valor LIKE('Factura Mayoreo_%') THEN 'Factura Mayoreo'
						WHEN Valor LIKE('Factura VIU_%') THEN 'Factura VIU'
						WHEN Valor LIKE('Factura_%') THEN 'Factura'    -- Para la nota de credito aplicada a cualquiera de estos documentos
						WHEN Valor LIKE('Nota Cargo_%') THEN 'Nota Cargo'
						WHEN Valor LIKE('Nota Cargo Mayoreo_%') THEN 'Nota Cargo Mayoreo'
						WHEN Valor LIKE('Nota Cargo VIU_%') THEN 'Nota Cargo VIU'
						WHEN Valor LIKE('Endoso_%') THEN 'Endoso'
                END),
						@MovID = (SELECT CASE
						WHEN Valor LIKE('Factura Mayoreo_%') THEN substring(Valor,len('Factura Mayoreo_')+ 1,(len(Valor)-len('Factura Mayoreo_')))
						WHEN Valor LIKE('Factura VIU_%') THEN substring(Valor,len('Factura VIU_')+ 1,(len(Valor)-len('Factura VIU_')))
						WHEN Valor LIKE('Factura_%') THEN substring(Valor,len('Factura_')+ 1,(len(Valor)-len('Factura_')))
						WHEN Valor LIKE('Nota Cargo_%') THEN substring(Valor,len('Nota Cargo_')+ 1,(len(Valor)-len('Nota Cargo_')))
						WHEN Valor LIKE('Nota Cargo Mayoreo_%') THEN substring(Valor,len('Nota Cargo Mayoreo_')+ 1,(len(Valor)-len('Nota Cargo Mayoreo_')))
						WHEN Valor LIKE('Nota Cargo VIU_%') THEN substring(Valor,len('Nota Cargo VIU_')+ 1,(len(Valor)-len('Nota Cargo VIU_')))
						WHEN Valor LIKE('Endoso_%') THEN substring(Valor,len('Endoso_')+ 1,(len(Valor)-len('Endoso_')))
                        END)
						FROM MovCampoExtra WITH (NOLOCK) WHERE  ID = @ID AND Modulo='CXC' 
			    	    
                        SELECT @Desglose = FacDesgloseIVA FROM CxC WITH (NOLOCK) WHERE Mov = @Mov AND MovID = @MovID 
						UPDATE CxC WITH (ROWLOCK) SET FacDesgloseIVA = @Desglose WHERE ID=@ID 
					END 
		   END 

		IF (@Mov = ('Aplicacion')) 
		BEGIN 
			SELECT TOP 1 @Origen = MovAplica, @OrigenID = MovAplicaID FROM CxC WITH (NOLOCK) WHERE ID=@ID 
			  IF (@Origen LIKE ('Nota Credito%')) 
			BEGIN 
				SELECT TOP 1 @Mov=Aplica, @MovID=AplicaID FROM CxCD WHERE ID=@ID 
				SELECT @Desglose = FacDesgloseIVA FROM CxC WITH (NOLOCK) WHERE Mov = @Mov AND MovID = @MovID -- para heredar a la aplicacion en la nota de credito 
				UPDATE CxC WITH (ROWLOCK) SET FacDesgloseIVA= @Desglose WHERE ID=@ID
			END
		END 
	  
		IF (@Mov='Endoso')  -- si aplica a endoso o cuenta incobrable 
		BEGIN 
			SELECT @Mov=Aplica, @MovID=AplicaID FROM CxCD WHERE ID=@ID 
			SELECT @Desglose = FacDesgloseIVA FROM CxC WHERE Mov = @Mov AND MovID = @MovID 
			UPDATE CxC WITH (ROWLOCK) SET FacDesgloseIVA= @Desglose WHERE ID=@ID 
		END

		IF (@Mov='Cta Incobrable F')		
		BEGIN
			SELECT TOP 1 @Mov=Aplica, @MovID=AplicaID FROM CxCD WITH (NOLOCK) WHERE ID=@ID 
			SELECT @Desglose = FacDesgloseIVA FROM CxC WITH (NOLOCK) WHERE Mov = @Mov AND MovID = @MovID 
			UPDATE CxC WITH (ROWLOCK) SET FacDesgloseIVA= @Desglose WHERE ID=@ID 
		END 
       
       IF (@Mov IN ('Cobro','Cobro Instituciones'))
        BEGIN
         select @IDFact=dbo.fnIDPadreAplicaCobroCFD(@ID)
         SELECT @Desglose = FacDesgloseIVA FROM CxC WITH (NOLOCK) WHERE ID=@IDFact
         UPDATE CxC WITH (ROWLOCK) SET FacDesgloseIVA= @Desglose WHERE ID=@ID  
         
        END


	END -- modulo cxc

END  
GO


/************************ spActualizarProgramaRecuperacionMAVI *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spActualizarProgramaRecuperacionMAVI') AND type = 'P') DROP PROCEDURE dbo.spActualizarProgramaRecuperacionMAVI
GO
CREATE PROCEDURE spActualizarProgramaRecuperacionMAVI
@ID					int
--//WITH ENCRYPTION
AS BEGIN  
DECLARE
@Mov                varchar(20),
@MovID              varchar(20),
@Estatus            varchar(15),
@CxcMov             varchar(20),
@CxcMovID           varchar(20),
@CxcImporte         money,
@TotalDoctos        int,
@Cont               int,
@Vencimiento        datetime,
@CxcID              int,
@FechaEmision       datetime,
@EjercicioTmp       int,
@PeriodoTmp         int,
@PorcentajeCapital    float, 
@PorcentajeFinanciamiento float,
@CxcRenglon           float,
@Cobro                money,
@PagoFinanciamiento   money,
@Renglon              int,
@CxcOrigenMov         varchar(20),
@CxcOrigenMovID       varchar(20),
@CxcDescuentoRecargos    money,
@CxcOrigenMovTmp      varchar(20),
@CxcOrigenMovIDTmp    varchar(20),
@CxcOrigenMovTmp2      varchar(20),
@CxcOrigenMovIDTmp2    varchar(20),
@Condicion			   varchar(50), -- Variable agregada el 29-Sep-08 Arly Rubio Camacho Identificacion de la venta mayor a 12 meses 
@MovAplica			   varchar(20), -- Variable agregada el 29-Sep-08 Arly Rubio Camacho Identificacion de la venta mayor a 12 meses 
@MovAplicaID		   varchar(20),  -- Variable agregada el 29-Sep-08 Arly Rubio Camacho Identificacion de la venta mayor a 12 meses 
@OrigenTipo			   varchar(10),  -- Variable agregada el 29-Sep-08 Arly Rubio Camacho Identificacion de la venta mayor a 12 meses 
@EsCredilana		   bit, -- Variable agregada el 29-Sep-08 Arly Rubio Camacho Identificacion de la venta mayor a 12 meses 
@Mayor12Meses           bit, -- Variable agregada el 29-Sep-08 Arly Rubio Camacho Identificacion de la venta mayor a 12 meses 
@MovTipo			   varchar(20),
@NumMeses			   int,  -- Variable agregada el 29-Sep-08 Arly Rubio Camacho Identificacion de la venta mayor a 12 meses
@EsNC                  bit,  --Variable para manejar las NC en la recuperacion ARC(14-Oct-08)
@Recuperacion		   money,
@Creditos			   money,
@EsPuente			   bit,
@MovPuente			   varchar(20),
@MovIDPuente		   varchar(20),
@IDPuente			   int

SET @Mov = NULL
SET @MovID = NULL
SET @Estatus = NULL
SET @CxcMov = NULL
SET @CxcMovID = NULL
SET @CxcImporte = 0.0
SET @TotalDoctos = 0
SET @Cont = 0
SET @Vencimiento = NULL
SET @CxcID = 0
SET @FechaEmision = NULL
SET @EjercicioTmp = 0
SET @PeriodoTmp = 0
SET @PorcentajeCapital = 0.0 
SET @PorcentajeFinanciamiento = 0.0
SET @CxcRenglon = 0.0
SET @Cobro = 0.0 
SET @PagoFinanciamiento = 0.0 
SET @Renglon = 0
SET @CxcOrigenMov = NULL
SET @CxcOrigenMovID = NULL
SET @CxcDescuentoRecargos = 0.0 
SET @CxcOrigenMovTmp = NULL
SET @CxcOrigenMovIDTmp = NULL
SET @CxcOrigenMovTmp2 = NULL
SET @CxcOrigenMovIDTmp2 = NULL
SET @Condicion = NULL
SET @MovAplica = NULL
SET @MovAplicaID = NULL
SET @EsCredilana = 0
SET @Mayor12Meses = 0
SET @MovTipo = NULL
SET @NumMeses = 0
SET @EsNC = 0
SET @Recuperacion = 0.0
SET @Creditos = 0.0

SELECT @Mov = Mov, @MovID = MovID, @Estatus = Estatus, @FechaEmision = ISNULL(FechaEmision,0), @Vencimiento = ISNULL(Vencimiento,0), @Condicion = Condicion, @MovAplica = MovAplica, @MovAplicaID = MovAplicaID, @OrigenTipo = OrigenTipo FROM Cxc WHERE ID =  @ID /* Se agregaron las variables MovAPlica, MovAplicaID, COndicion, OrigenTipo para determinar el campo mayor12meses y escredilana (Arly Rubio Camacho) 02-10-08 */


/* Inicio llenar el campo Mayor12Meses y EsCredilanas en Movimientos Generados en Cxc */
SELECT @MovTipo = Clave FROM MovTipo WHERE Modulo = 'CXC' AND Mov = @Mov

IF @MovTipo IN('CXC.CA', 'CXC.D', 'CXC.DP', 'CXC.CD', 'CXC.CAP', 'CXC.FAC')
BEGIN
     IF @OrigenTipo <> 'VTAS' AND @Estatus IN('Concluido', 'Pendiente')
       BEGIN
          IF @MovTipo = 'CXC.FAC'
            BEGIN
              SELECT @Mayor12Meses = Mayor12Meses, @EsCredilana = EsCredilana FROM Cxc WHERE Mov = @MovAplica AND MovID = @MovAplicaID AND Estatus IN('Pendiente', 'Concluido')
              UPDATE Cxc SET Mayor12Meses = @Mayor12Meses, EsCredilana = @EsCredilana WHERE ID = @ID
            END
          ELSE
            BEGIN
               SELECT @Mayor12Meses = Mayor12Meses FROM Cxc WHERE ID = @ID
               IF @Mayor12Meses IS NULL OR @Mayor12Meses = ''
                 BEGIN
                    IF @Condicion <> '(Fecha)'  -- Inicio 29-Sep-08 Arly Rubio Linea para identificar la condicion de la venta
                      BEGIN
                         SELECT @NumMeses = dbo.fnMayor12MesesMAVI(@Condicion) -- Obtenemos el numero de meses de la condicion
	/**** MODIFICACION DE MAYOR12MESES DE MAYOR A MAYOR O IGUAL  *****/
                         IF @NumMeses >= 12 
                           BEGIN
                              SELECT @Mayor12Meses = 1
                              UPDATE Cxc SET Mayor12Meses = 1 WHERE ID = @ID
                           END
                         ELSE 
                           BEGIN
                              SELECT @Mayor12Meses = 0
                              UPDATE Cxc SET Mayor12Meses = 0 WHERE ID = @ID
                           END
                      END   
                    ELSE 
                      BEGIN
                         SELECT @NumMeses = DateDiff(d,ISNULL(@FechaEmision, GETDATE()),ISNULL(@Vencimiento, GETDATE())) 
                         SELECT @NumMeses = ISNULL(@NumMeses, 0)/30
	/**** MODIFICACION DE MAYOR12MESES DE MAYOR A MAYOR O IGUAL  *****/
                         IF @NumMeses >= 12  
                           BEGIN
                              SELECT @Mayor12Meses = 1
                              UPDATE Cxc SET Mayor12Meses = 1 WHERE ID = @ID
                           END 
                         ELSE 
                           BEGIN
                              SELECT @Mayor12Meses = 0
                              UPDATE Cxc SET Mayor12Meses = 0 WHERE ID = @ID
                           END
                      END  -- FIN 29-Sep-08 Arly Rubio Linea para identificar la condicion de la venta
         
                 END
               IF @Estatus = 'Concluido'
                 BEGIN
                    UPDATE Cxc SET Mayor12Meses = @Mayor12Meses, EsCredilana = @EsCredilana WHERE Mov = 'Documento' AND OrigenTipo = 'CXC' AND Origen = @Mov AND OrigenID = @MovID AND Estatus IN('PENDIENTE','CONCLUIDO')
                 END
            END 
       END
  END


IF @Mov IN('Cobro','Cancela Prestamo','Cancela Credilana','Aplicacion','Nota Credito','Cobro Instituciones') AND @Estatus = 'Concluido' 
  BEGIN
     IF @MovTipo = 'CXC.NC'
       SELECT @EsNC = 1
     ELSE
       BEGIN
         IF @MovTipo = 'CXC.ANC'
           BEGIN
             IF @MovAplica IN('Cancela Prestamo','Cancela Credilana','Nota Credito')
               SELECT @EsNC = 1
             ELSE
               SELECT @EsNC = 0
           END
         ELSE
           SELECT @EsNC = 0
       END 
     SELECT @PeriodoTmp = ISNULL(MONTH(@FechaEmision), 0)  -- Se saca el mes(periodo) en el que se esta realizando el cobro
     SELECT @EjercicioTmp = ISNULL(YEAR(@FechaEmision), 0) -- Se saca el año en el que se esta realizando el cobro
        
     SELECT @TotalDoctos = COUNT(*) FROM CxcD WHERE ID = @ID
     IF @TotalDoctos > 0
       BEGIN
          DECLARE DoctosACobrar CURSOR FOR SELECT C.Renglon, C.Importe, C.Aplica, C.AplicaID, C.DescuentoRecargos FROM CxcD C WHERE ID = @ID
          OPEN DoctosACobrar
          SET @Cont = 0
          WHILE @Cont < @TotalDoctos  
            BEGIN  -- Inicio While    
               FETCH NEXT FROM DoctosACobrar    
      INTO @CxcRenglon, @CxcImporte, @CxcMov, @CxcMovID, @CxcDescuentoRecargos     --Asigna a la variable el valor del campo en el registro actual		    
               SET @EsPuente = 0

               IF @CxcMov IN('Cta Incobrable NV', 'Contra Recibo Inst')
                 BEGIN --1A
                   IF @CxcMov = 'Cta Incobrable NV' AND @EsNC = 1
                     BEGIN --2A
                       SELECT @EsPuente = 1
                       SELECT @MovPuente = @CxcMov, @MovIDPuente = @CxcMovID
                       SELECT @IDPuente = ID FROM Cxc WHERE Mov = @CxcMov AND MovID = @CxcMovID AND Estatus IN('Pendiente', 'Concluido')
                       SELECT TOP 1 @CxcMov = Aplica, @CxcMovID = AplicaID FROM CxcD WHERE ID = @IDPuente
                     END --2A
                   ELSE
                     BEGIN --3A
                        IF @CxcMov = 'Contra Recibo Inst'
                          BEGIN
                            SELECT @EsPuente = 1
                            SELECT @MovPuente = @CxcMov, @MovIDPuente = @CxcMovID
                            SELECT @IDPuente = ID FROM Cxc WHERE Mov = @CxcMov AND MovID = @CxcMovID AND Estatus IN('Pendiente', 'Concluido')
                            SELECT TOP 1 @CxcMov = Aplica, @CxcMovID = AplicaID FROM CxcD WHERE ID = @IDPuente
                          END
                     END --3A
                 END --1A

			   IF @CxcMov IN('Credilana','Prestamo Personal') -- Inicio Si el movimiento incluido en el cobro es una credilana o un prestamo personal
                 BEGIN
                    SELECT @CxcID = ID FROM Cxc WHERE Mov = @CxcMov AND MovID = @CxcMovID
                    IF EXISTS(SELECT ID FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID)
                      BEGIN -- Inicio Si existe la credilana en la tabla de programacion de recuperacion
                         IF EXISTS(SELECT ID FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp) -- Si el cobro esta dentro de alguno de los periodos y ejercicio de la programacion de recuperacion
                           BEGIN
                              SELECT @Creditos = ISNULL(Creditos, 0.0), @Cobro = ISNULL(Cobros, 0.0), @PorcentajeFinanciamiento = ISNULL(PorcentajeFinanciamiento, 0.0), @Renglon = ISNULL(Renglon, 0) FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp
                              --IF @CxcDescuentoRecargos < 0.0
                                --SELECT @CxcImporte = (ISNULL(@CxcImporte, 0.0)+ISNULL(@CxcDescuentoRecargos, 0.0))
                              IF @EsNC = 1
                                SELECT @Creditos = (@Creditos + ISNULL(@CxcImporte, 0.0))
                              ELSE
							    SELECT @Cobro = (@Cobro + ISNULL(@CxcImporte, 0.0))
                              SELECT @Recuperacion = ISNULL(@Cobro, 0.0) -- + ISNULL(@Creditos, 0.0))  
                              SELECT @PagoFinanciamiento = @Recuperacion * @PorcentajeFinanciamiento
                              IF (@Recuperacion >= 0 AND @PagoFinanciamiento >= 0)
                                BEGIN
                                   IF @EsNC = 1
                                     BEGIN
                                        UPDATE  RecuperacionCredilanasPPMAVI SET Creditos = @Creditos, PagoFinanciamiento = @PagoFinanciamiento WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp
										DELETE RecuperacionCredilanasPPMAVID WHERE ID = @CxcID AND CobroID = @ID AND Renglon = @Renglon AND CxcMov = (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END) AND CxcMovID = (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END) -- Borra antes de insertar
                                        INSERT RecuperacionCredilanasPPMAVID (ID, CobroID, Renglon, CxcRenglon, CxcMov, CxcMovID, CxcImporte, CobroEmision, NCImporte, EsNC) VALUES (@CxcID, @ID, @Renglon, @CxcRenglon, (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END), (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END), 0.0, @FechaEmision, @CxcImporte, @EsNC)
                                     END
                                   ELSE
                                     BEGIN
                                        DELETE RecuperacionCredilanasPPMAVID WHERE ID = @CxcID AND CobroID = @ID AND Renglon = @Renglon AND CxcMov = (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END) AND CxcMovID = (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END) -- Borra antes de insertar
                                        UPDATE  RecuperacionCredilanasPPMAVI SET Cobros = @Cobro, PagoFinanciamiento = @PagoFinanciamiento WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp
										INSERT RecuperacionCredilanasPPMAVID (ID, CobroID, Renglon, CxcRenglon, CxcMov, CxcMovID, CxcImporte, CobroEmision, NCImporte, EsNC) VALUES (@CxcID, @ID, @Renglon, @CxcRenglon, (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END), (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END), @CxcImporte, @FechaEmision, 0.0, @EsNC)
                                     END
                                   EXEC sp_ActualizaProgaramaFinanciamientoMAVI @CxcID
                                END
                           END  -- Fin Si el cobro esta dentro de alguno de los periodos y ejercicio de la programacion de recuperacion
                         ELSE
                           BEGIN -- Inicio Si el cobro no esta dentro de ningun periodo y ejercicio pero si esta en la tabla de programacion de recuperacion
                              SELECT @PorcentajeFinanciamiento = ISNULL(PorcentajeFinanciamiento, 0.0), @PorcentajeCapital = ISNULL(PorcentajeCapital, 0.0) FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID
                              --IF @CxcDescuentoRecargos < 0.0 -- 10-Sep-08
                                --SELECT @CxcImporte = (ISNULL(@CxcImporte, 0.0)+ISNULL(@CxcDescuentoRecargos, 0.0))
							  SELECT @PagoFinanciamiento = (ISNULL(@CxcImporte, 0.0) * @PorcentajeFinanciamiento)
                              IF @EsNC = 1
                                BEGIN
                                   SELECT @PagoFinanciamiento = 0.0
								   INSERT RecuperacionCredilanasPPMAVI (ID, Periodo, Ejercicio, FechaEmision, Vencimiento, Exigible, Cobros, Anterior, ExigiblePagado, Adelantado, PorcentajeCapital, PorcentajeFinanciamiento, PagoFinanciamiento, Ordinario, Arrastre, Cobertura, Creditos) 
                                   VALUES (@CxcID, @PeriodoTmp, @EjercicioTmp, @FechaEmision, @FechaEmision, 0.0, 0.0, 0.0, 0.0, 0.0, @PorcentajeCapital, @PorcentajeFinanciamiento, @PagoFinanciamiento, 0, 0.0, 0.0, @CxcImporte) 
                                END
                              ELSE
                                BEGIN
								   INSERT RecuperacionCredilanasPPMAVI (ID, Periodo, Ejercicio, FechaEmision, Vencimiento, Exigible, Cobros, Anterior, ExigiblePagado, Adelantado, PorcentajeCapital, PorcentajeFinanciamiento, PagoFinanciamiento, Ordinario, Arrastre, Cobertura, Creditos) 
                                   VALUES (@CxcID, @PeriodoTmp, @EjercicioTmp, @FechaEmision, @FechaEmision, 0.0, @CxcImporte, 0.0, 0.0, 0.0, @PorcentajeCapital, @PorcentajeFinanciamiento, @PagoFinanciamiento, 0, 0.0, 0.0, 0.0) 
                                END
							  
							  SELECT @Renglon = ISNULL(Renglon, 0) FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp
                              DELETE RecuperacionCredilanasPPMAVID WHERE ID = @CxcID AND CobroID = @ID AND Renglon = @Renglon AND CxcMov = (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END) AND CxcMovID = (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END) -- Borra antes de insertar  
							  IF @EsNC = 1
                                BEGIN
                                   INSERT RecuperacionCredilanasPPMAVID (ID, CobroID, Renglon, CxcRenglon, CxcMov, CxcMovID, CxcImporte, CobroEmision, NCImporte, EsNC) 
                                   VALUES (@CxcID, @ID, @Renglon, @CxcRenglon, (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END), (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END), 0.0, @FechaEmision, @CxcImporte, @EsNC)
                                END
                              ELSE
                                BEGIN
                                   INSERT RecuperacionCredilanasPPMAVID (ID, CobroID, Renglon, CxcRenglon, CxcMov, CxcMovID, CxcImporte, CobroEmision, NCImporte, EsNC) 
                                   VALUES (@CxcID, @ID, @Renglon, @CxcRenglon, (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END), (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END), @CxcImporte, @FechaEmision, 0.0, @EsNC)
								END
                              EXEC sp_ActualizaProgaramaFinanciamientoMAVI @CxcID
                           END  -- Fin Si el cobro no esta dentro de ningun periodo y ejercicio pero si esta en la tabla de programacion de recuperacion
                      END  -- Fin Si existe la credilana en la tabla de programacion de recuperacion
                 END  --Fin Si el movimiento incluido en el cobro es una credilana o un prestamo personal
               ELSE
                 BEGIN -- Inicio Si el movimiento incluido en el cobro NO es una credilana o un prestamo personal

                    IF @CxcMov IN('Documento')
                      BEGIN
                         SELECT @CxcOrigenMov = Origen, @CxcOrigenMovID = OrigenID FROM Cxc WHERE Mov = @CxcMov AND MovID = @CxcMovID -- Obtenemos el movimiento que origino al documento
                         IF @CxcOrigenMov IN('Credilana','Prestamo Personal')
                           BEGIN --********************
                              SELECT @CxcID = ID FROM Cxc WHERE Mov = @CxcOrigenMov AND MovID = @CxcOrigenMovID -- Obtenemos el ID de la credilana o prestamo personal del cual viene el documento
                              IF EXISTS(SELECT ID FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID)
                                BEGIN -- Inicio Si existe la credilana o PP en la tabla de programacion de recuperacion
                                   IF EXISTS(SELECT ID FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp) -- Si el cobro esta dentro de alguno de los periodos y ejercicio de la programacion de recuperacion
                                     BEGIN
                                        SELECT @Cobro = ISNULL(Cobros, 0.0), @Creditos = ISNULL(Creditos, 0.0), @PorcentajeFinanciamiento = ISNULL(PorcentajeFinanciamiento, 0.0), @Renglon = ISNULL(Renglon, 0) FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp
                                        --IF @CxcDescuentoRecargos < 0
                                          --SELECT @CxcImporte = (ISNULL(@CxcImporte, 0.0)+ISNULL(@CxcDescuentoRecargos, 0.0))
                                        IF @EsNC = 1
                                          SELECT @Creditos = (@Creditos + ISNULL(@CxcImporte, 0.0))
                                        ELSE 
                                          SELECT @Cobro = (@Cobro + ISNULL(@CxcImporte, 0.0))
                                        SELECT @Recuperacion = ISNULL(@Cobro, 0.0) -- + ISNULL(@Creditos, 0.0)) 
                                        SELECT @PagoFinanciamiento = @Recuperacion * @PorcentajeFinanciamiento
                                      
                                        IF (@Recuperacion >= 0 AND @PagoFinanciamiento >= 0)
                                          BEGIN
											 IF @EsNC = 1
                                               BEGIN
												  UPDATE  RecuperacionCredilanasPPMAVI SET Creditos = @Creditos, PagoFinanciamiento = @PagoFinanciamiento WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp
                                                  DELETE RecuperacionCredilanasPPMAVID WHERE ID = @CxcID AND CobroID = @ID AND Renglon = @Renglon AND CxcMov = (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END) AND CxcMovID = (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END) -- Borra antes de insertar  
                                                  INSERT RecuperacionCredilanasPPMAVID (ID, CobroID, Renglon, CxcRenglon, CxcMov, CxcMovID, CxcImporte, CobroEmision, EsNC, NCImporte) VALUES (@CxcID, @ID, @Renglon, @CxcRenglon, (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END), (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END), 0.0, @FechaEmision, @EsNC, @CxcImporte)
											   END
                                             ELSE
											   BEGIN
												  UPDATE  RecuperacionCredilanasPPMAVI SET Cobros = @Cobro, PagoFinanciamiento = @PagoFinanciamiento WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp
												  DELETE RecuperacionCredilanasPPMAVID WHERE ID = @CxcID AND CobroID = @ID AND Renglon = @Renglon AND CxcMov = (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END) AND CxcMovID = (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END) -- Borra antes de insertar  
												  INSERT RecuperacionCredilanasPPMAVID (ID, CobroID, Renglon, CxcRenglon, CxcMov, CxcMovID, CxcImporte, CobroEmision, NCImporte, EsNC) VALUES (@CxcID, @ID, @Renglon, @CxcRenglon, (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END), (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END), @CxcImporte, @FechaEmision, 0.0, @EsNC)
                                               END
                                             EXEC sp_ActualizaProgaramaFinanciamientoMAVI @CxcID
                                          END
                                     END  -- Fin Si el cobro esta dentro de alguno de los periodos y ejercicio de la programacion de recuperacion
                                   ELSE
                                     BEGIN -- Inicio Si el cobro no esta dentro de ningun periodo y ejercicio pero si esta en la tabla de programacion de recuperacion
                                        SELECT @PorcentajeFinanciamiento = ISNULL(PorcentajeFinanciamiento, 0.0), @PorcentajeCapital = ISNULL(PorcentajeCapital, 0.0) FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID
                                        --IF @CxcDescuentoRecargos < 0
                                          --SELECT @CxcImporte = (ISNULL(@CxcImporte, 0.0)+ISNULL(@CxcDescuentoRecargos, 0.0))
									    SELECT @PagoFinanciamiento = (ISNULL(@CxcImporte, 0.0) * @PorcentajeFinanciamiento)
                                        IF @EsNC = 1
										  BEGIN
                                             SELECT @PagoFinanciamiento = 0.0
											 INSERT RecuperacionCredilanasPPMAVI (ID, Periodo, Ejercicio, FechaEmision, Vencimiento, Exigible, Cobros, Anterior, ExigiblePagado, Adelantado, PorcentajeCapital, PorcentajeFinanciamiento, PagoFinanciamiento, Ordinario, Arrastre, Cobertura, Creditos) 
									         VALUES (@CxcID, @PeriodoTmp, @EjercicioTmp, @FechaEmision, @FechaEmision, 0.0, 0.0, 0.0, 0.0, 0.0, @PorcentajeCapital, @PorcentajeFinanciamiento, @PagoFinanciamiento, 0, 0.0, 0.0, @CxcImporte) 
										  END
										ELSE
										  BEGIN
											 INSERT RecuperacionCredilanasPPMAVI (ID, Periodo, Ejercicio, FechaEmision, Vencimiento, Exigible, Cobros, Anterior, ExigiblePagado, Adelantado, PorcentajeCapital, PorcentajeFinanciamiento, PagoFinanciamiento, Ordinario, Arrastre, Cobertura, Creditos) 
									         VALUES (@CxcID, @PeriodoTmp, @EjercicioTmp, @FechaEmision, @FechaEmision, 0.0, @CxcImporte, 0.0, 0.0, 0.0, @PorcentajeCapital, @PorcentajeFinanciamiento, @PagoFinanciamiento, 0, 0.0, 0.0, 0.0) 
                                          END
                            
									    SELECT @Renglon = ISNULL(Renglon, 0) FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp
									    DELETE RecuperacionCredilanasPPMAVID WHERE ID = @CxcID AND CobroID = @ID AND Renglon = @Renglon AND CxcMov = (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END) AND CxcMovID = (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END) -- Borra antes de insertar  
                                        IF @EsNC = 1
                                          BEGIN
											 INSERT RecuperacionCredilanasPPMAVID (ID, CobroID, Renglon, CxcRenglon, CxcMov, CxcMovID, CxcImporte, CobroEmision, NCImporte, EsNC) 
									         VALUES (@CxcID, @ID, @Renglon, @CxcRenglon, (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END), (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END), 0.0, @FechaEmision, @CxcImporte, @EsNC)
										  END
										ELSE
										  BEGIN
                                             INSERT RecuperacionCredilanasPPMAVID (ID, CobroID, Renglon, CxcRenglon, CxcMov, CxcMovID, CxcImporte, CobroEmision, NCImporte, EsNC) 
									         VALUES (@CxcID, @ID, @Renglon, @CxcRenglon, (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END), (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END), @CxcImporte, @FechaEmision, 0.0, @EsNC)
										  END
									    
                                        EXEC sp_ActualizaProgaramaFinanciamientoMAVI @CxcID
								     END  -- Fin Si el cobro no esta dentro de ningun periodo y ejercicio pero si esta en la tabla de programacion de recuperacion
							    END  -- Fin Si existe la credilana en la tabla de programacion de recuperacion
                           END --Fin Si el movimiento incluido en el cobro es una credilana o un prestamo personal *************
                      END

                    IF @CxcMov = 'Endoso'
                      BEGIN
                         SELECT @CxcOrigenMov = MovAplica, @CxcOrigenMovID = MovAplicaID FROM Cxc WHERE Mov = @CxcMov AND MovID = @CxcMovID AND Estatus IN('PENDIENTE', 'CONCLUIDO')  
                         IF @CxcOrigenMov IN('Credilana','Prestamo Personal')  --Inicio si el endoso es de una Credilana o PP
                           BEGIN
                              SELECT @CxcID = ID FROM Cxc WHERE Mov = @CxcOrigenMov AND MovID = @CxcOrigenMovID AND Estatus IN('CONCLUIDO','PENDIENTE') --Obtenemos el ID de la credilana o PP
                              IF EXISTS(SELECT ID FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID)
                                BEGIN -- Inicio Si existe la credilana o PP en la tabla de programacion de recuperacion
                                   IF EXISTS(SELECT ID FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp) -- Si el cobro esta dentro de alguno de los periodos y ejercicio de la programacion de recuperacion
                                     BEGIN
                                        SELECT @Cobro = ISNULL(Cobros, 0.0), @Creditos = ISNULL(Creditos, 0.0), @PorcentajeFinanciamiento = ISNULL(PorcentajeFinanciamiento, 0.0), @Renglon = ISNULL(Renglon, 0) FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp
                                        --IF @CxcDescuentoRecargos < 0
                                          --SELECT @CxcImporte = (ISNULL(@CxcImporte, 0.0)+ISNULL(@CxcDescuentoRecargos, 0.0))
										IF @EsNC = 1
                                          SELECT @Creditos = (@Creditos + ISNULL(@CxcImporte, 0.0))
										ELSE
										  SELECT @Cobro = (@Cobro + ISNULL(@CxcImporte, 0.0))
										SELECT @Recuperacion = ISNULL(@Cobro, 0.0) -- + ISNULL(@Creditos, 0.0))
                                        SELECT @PagoFinanciamiento = @Recuperacion * @PorcentajeFinanciamiento
                                        IF (@Recuperacion >= 0 AND @PagoFinanciamiento >= 0)
                                          BEGIN
                                             IF @EsNC = 1
                                               BEGIN
												  UPDATE  RecuperacionCredilanasPPMAVI SET Creditos = @Creditos, PagoFinanciamiento = @PagoFinanciamiento WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp
                                                  DELETE RecuperacionCredilanasPPMAVID WHERE ID = @CxcID AND CobroID = @ID AND Renglon = @Renglon AND CxcMov = (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END) AND CxcMovID = (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END) -- Borra antes de insertar  
                                                  INSERT RecuperacionCredilanasPPMAVID (ID, CobroID, Renglon, CxcRenglon, CxcMov, CxcMovID, CxcImporte, CobroEmision, NCImporte, EsNC) VALUES (@CxcID, @ID, @Renglon, @CxcRenglon, (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END), (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END), 0.0, @FechaEmision, @CxcImporte, @EsNC)
											   END
                                             ELSE
                                               BEGIN
												  UPDATE  RecuperacionCredilanasPPMAVI SET Cobros = @Cobro, PagoFinanciamiento = @PagoFinanciamiento WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp
                                                  DELETE RecuperacionCredilanasPPMAVID WHERE ID = @CxcID AND CobroID = @ID AND Renglon = @Renglon AND CxcMov = (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END) AND CxcMovID = (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END) -- Borra antes de insertar  
                                                  INSERT RecuperacionCredilanasPPMAVID (ID, CobroID, Renglon, CxcRenglon, CxcMov, CxcMovID, CxcImporte, CobroEmision, NCImporte, EsNC) VALUES (@CxcID, @ID, @Renglon, @CxcRenglon, (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END), (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END), @CxcImporte, @FechaEmision, 0.0, @EsNC)
											   END
                                             EXEC sp_ActualizaProgaramaFinanciamientoMAVI @CxcID
                                          END
                                     END  -- Fin Si el cobro esta dentro de alguno de los periodos y ejercicio de la programacion de recuperacion
                                   ELSE
                                     BEGIN -- Inicio Si el cobro no esta dentro de ningun periodo y ejercicio pero si esta en la tabla de programacion de recuperacion
                                        SELECT @PorcentajeFinanciamiento = ISNULL(PorcentajeFinanciamiento, 0.0), @PorcentajeCapital = ISNULL(PorcentajeCapital, 0.0) FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID
                                        --IF @CxcDescuentoRecargos < 0
                                          --SELECT @CxcImporte = (ISNULL(@CxcImporte, 0.0)+ISNULL(@CxcDescuentoRecargos, 0.0))
									    SELECT @PagoFinanciamiento = (ISNULL(@CxcImporte, 0.0) * @PorcentajeFinanciamiento)
                                        IF @EsNC = 1
										  BEGIN
                                             SELECT @PagoFinanciamiento = 0.0
										     INSERT RecuperacionCredilanasPPMAVI (ID, Periodo, Ejercicio, FechaEmision, Vencimiento, Exigible, Cobros, Anterior, ExigiblePagado, Adelantado, PorcentajeCapital, PorcentajeFinanciamiento, PagoFinanciamiento, Ordinario, Arrastre, Cobertura, Creditos) 
									         VALUES (@CxcID, @PeriodoTmp, @EjercicioTmp, @FechaEmision, @FechaEmision, 0.0, 0.0, 0.0, 0.0, 0.0, @PorcentajeCapital, @PorcentajeFinanciamiento, @PagoFinanciamiento, 0, 0.0, 0.0, @CxcImporte) 
                            
									         SELECT @Renglon = ISNULL(Renglon, 0) FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp
									         DELETE RecuperacionCredilanasPPMAVID WHERE ID = @CxcID AND CobroID = @ID AND Renglon = @Renglon AND CxcMov = (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END) AND CxcMovID = (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END) -- Borra antes de insertar  
									         INSERT RecuperacionCredilanasPPMAVID (ID, CobroID, Renglon, CxcRenglon, CxcMov, CxcMovID, CxcImporte, CobroEmision, EsNC, NCImporte) 
									         VALUES (@CxcID, @ID, @Renglon, @CxcRenglon, (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END), (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END), 0.0, @FechaEmision, @EsNC, @CxcImporte)
										  END
										ELSE
										  BEGIN
											 INSERT RecuperacionCredilanasPPMAVI (ID, Periodo, Ejercicio, FechaEmision, Vencimiento, Exigible, Cobros, Anterior, ExigiblePagado, Adelantado, PorcentajeCapital, PorcentajeFinanciamiento, PagoFinanciamiento, Ordinario, Arrastre, Cobertura, Creditos) 
											 VALUES (@CxcID, @PeriodoTmp, @EjercicioTmp, @FechaEmision, @FechaEmision, 0.0, @CxcImporte, 0.0, 0.0, 0.0, @PorcentajeCapital, @PorcentajeFinanciamiento, @PagoFinanciamiento, 0, 0.0, 0.0, 0.0) 
                            
											 SELECT @Renglon = ISNULL(Renglon, 0) FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp
											 DELETE RecuperacionCredilanasPPMAVID WHERE ID = @CxcID AND CobroID = @ID AND Renglon = @Renglon AND CxcMov = (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END) AND CxcMovID = (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END) -- Borra antes de insertar  
											 INSERT RecuperacionCredilanasPPMAVID (ID, CobroID, Renglon, CxcRenglon, CxcMov, CxcMovID, CxcImporte, CobroEmision, EsNC, NCImporte) 
											 VALUES (@CxcID, @ID, @Renglon, @CxcRenglon, (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END), (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END), @CxcImporte, @FechaEmision, @EsNC, 0.0)
										  END
									    
                                        EXEC sp_ActualizaProgaramaFinanciamientoMAVI @CxcID
								     END  -- Fin Si el cobro no esta dentro de ningun periodo y ejercicio pero si esta en la tabla de programacion de recuperacion
							    END  -- Fin Si existe la credilana en la tabla de programacion de recuperacion
                           END --Fin si el endoso es de una Credilana o PP

                         IF @CxcOrigenMov = 'Documento'  --Inicio si el endoso es de un documento
                           BEGIN
                              --SELECT @CxcOrigenMovTmp = @CxcOrigenMov, @CxcOrigenMovIDTmp = @CxcOrigenMovID
                              SELECT @CxcOrigenMovTmp = Origen, @CxcOrigenMovIDTmp = OrigenID FROM Cxc WHERE Mov = @CxcOrigenMov AND MovID = @CxcOrigenMovID AND Estatus IN('CONCLUIDO','PENDIENTE') -- Obtenemos el movimiento que origino al documento
                              IF @CxcOrigenMovTmp IN('Credilana','Prestamo Personal')
                                BEGIN --********************
                                   SELECT @CxcID = ID FROM Cxc WHERE Mov = @CxcOrigenMovTmp AND MovID = @CxcOrigenMovIDTmp AND Estatus IN('PENDIENTE','CONCLUIDO') -- Obtenemos el ID de la credilana o prestamo personal del cual viene el documento
                                   IF EXISTS(SELECT ID FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID)
                                     BEGIN -- Inicio Si existe la credilana o PP en la tabla de programacion de recuperacion
                                        IF EXISTS(SELECT ID FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp) -- Si el cobro esta dentro de alguno de los periodos y ejercicio de la programacion de recuperacion
                                          BEGIN
                                 SELECT @Cobro = ISNULL(Cobros, 0.0), @Creditos = ISNULL(Creditos, 0.0), @PorcentajeFinanciamiento = ISNULL(PorcentajeFinanciamiento, 0.0), @Renglon = ISNULL(Renglon, 0) FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp
                                             --IF @CxcDescuentoRecargos < 0
                                               --SELECT @CxcImporte = (ISNULL(@CxcImporte, 0.0)+ISNULL(@CxcDescuentoRecargos, 0.0))
										     IF @EsNC = 1
                                               SELECT @Creditos = (@Creditos + ISNULL(@CxcImporte, 0.0))
											 ELSE
											   SELECT @Cobro = (@Cobro + ISNULL(@CxcImporte, 0.0))
											 SELECT @Recuperacion = ISNULL(@Cobro, 0.0) -- + ISNULL(@Creditos, 0.0))
                                             SELECT @PagoFinanciamiento = @Recuperacion * @PorcentajeFinanciamiento
                                             IF (@Recuperacion >= 0 AND @PagoFinanciamiento >= 0)
                                               BEGIN
												  IF @EsNC = 1
												    BEGIN
                                                       UPDATE  RecuperacionCredilanasPPMAVI SET Creditos = @Creditos, PagoFinanciamiento = @PagoFinanciamiento WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp
                                                       DELETE RecuperacionCredilanasPPMAVID WHERE ID = @CxcID AND CobroID = @ID AND Renglon = @Renglon AND CxcMov = (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END) AND CxcMovID = (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END) -- Borra antes de insertar  
                                                       INSERT RecuperacionCredilanasPPMAVID (ID, CobroID, Renglon, CxcRenglon, CxcMov, CxcMovID, CxcImporte, CobroEmision, NCImporte, EsNC) VALUES (@CxcID, @ID, @Renglon, @CxcRenglon, (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END), (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END), 0.0, @FechaEmision, @CxcImporte, @EsNC)
													END
												  ELSE
													BEGIN
													   UPDATE  RecuperacionCredilanasPPMAVI SET Cobros = @Cobro, PagoFinanciamiento = @PagoFinanciamiento WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp
                                                       DELETE RecuperacionCredilanasPPMAVID WHERE ID = @CxcID AND CobroID = @ID AND Renglon = @Renglon AND CxcMov = (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END) AND CxcMovID = (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END) -- Borra antes de insertar  
                                                       INSERT RecuperacionCredilanasPPMAVID (ID, CobroID, Renglon, CxcRenglon, CxcMov, CxcMovID, CxcImporte, CobroEmision, NCImporte, EsNC) VALUES (@CxcID, @ID, @Renglon, @CxcRenglon, (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END), (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END), @CxcImporte, @FechaEmision, 0.0, @EsNC)
													END
                                                  EXEC sp_ActualizaProgaramaFinanciamientoMAVI @CxcID
                                               END
                                          END  -- Fin Si el cobro esta dentro de alguno de los periodos y ejercicio de la programacion de recuperacion
                                        ELSE
                                          BEGIN -- Inicio Si el cobro no esta dentro de ningun periodo y ejercicio pero si esta en la tabla de programacion de recuperacion
                                             SELECT @PorcentajeFinanciamiento = ISNULL(PorcentajeFinanciamiento, 0.0), @PorcentajeCapital = ISNULL(PorcentajeCapital, 0.0) FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID
                                             --IF @CxcDescuentoRecargos < 0
                                               --SELECT @CxcImporte = (ISNULL(@CxcImporte, 0.0)+ISNULL(@CxcDescuentoRecargos, 0.0))
									         SELECT @PagoFinanciamiento = (ISNULL(@CxcImporte, 0.0) * @PorcentajeFinanciamiento)
                                             IF @EsNC = 1
											   BEGIN
                                                  SELECT @PagoFinanciamiento = 0.0
									              INSERT RecuperacionCredilanasPPMAVI (ID, Periodo, Ejercicio, FechaEmision, Vencimiento, Exigible, Cobros, Anterior, ExigiblePagado, Adelantado, PorcentajeCapital, PorcentajeFinanciamiento, PagoFinanciamiento, Ordinario, Arrastre, Cobertura, Creditos) 
									              VALUES (@CxcID, @PeriodoTmp, @EjercicioTmp, @FechaEmision, @FechaEmision, 0.0, 0.0, 0.0, 0.0, 0.0, @PorcentajeCapital, @PorcentajeFinanciamiento, @PagoFinanciamiento, 0, 0.0, 0.0, @CxcImporte) 
                            
									              SELECT @Renglon = ISNULL(Renglon, 0) FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp
									              DELETE RecuperacionCredilanasPPMAVID WHERE ID = @CxcID AND CobroID = @ID AND Renglon = @Renglon AND CxcMov = (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END) AND CxcMovID = (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END) -- Borra antes de insertar  
									              INSERT RecuperacionCredilanasPPMAVID (ID, CobroID, Renglon, CxcRenglon, CxcMov, CxcMovID, CxcImporte, CobroEmision, NCImporte, EsNC) 
									              VALUES (@CxcID, @ID, @Renglon, @CxcRenglon, (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END), (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END), 0.0, @FechaEmision, @CxcImporte, @EsNC)
											   END
											 ELSE
											   BEGIN
                                                  INSERT RecuperacionCredilanasPPMAVI (ID, Periodo, Ejercicio, FechaEmision, Vencimiento, Exigible, Cobros, Anterior, ExigiblePagado, Adelantado, PorcentajeCapital, PorcentajeFinanciamiento, PagoFinanciamiento, Ordinario, Arrastre, Cobertura, Creditos) 
									              VALUES (@CxcID, @PeriodoTmp, @EjercicioTmp, @FechaEmision, @FechaEmision, 0.0, @CxcImporte, 0.0, 0.0, 0.0, @PorcentajeCapital, @PorcentajeFinanciamiento, @PagoFinanciamiento, 0, 0.0, 0.0, 0.0) 
                            
									              SELECT @Renglon = ISNULL(Renglon, 0) FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp
									              DELETE RecuperacionCredilanasPPMAVID WHERE ID = @CxcID AND CobroID = @ID AND Renglon = @Renglon AND CxcMov = (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END) AND CxcMovID = (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END) -- Borra antes de insertar  
									              INSERT RecuperacionCredilanasPPMAVID (ID, CobroID, Renglon, CxcRenglon, CxcMov, CxcMovID, CxcImporte, CobroEmision, NCImporte, EsNC) 
									              VALUES (@CxcID, @ID, @Renglon, @CxcRenglon, (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END), (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END), @CxcImporte, @FechaEmision, 0.0, @EsNC)
											   END
                                             EXEC sp_ActualizaProgaramaFinanciamientoMAVI @CxcID
								          END  -- Fin Si el cobro no esta dentro de ningun periodo y ejercicio pero si esta en la tabla de programacion de recuperacion
							         END  -- Fin Si existe la credilana en la tabla de programacion de recuperacion
                                END --Fin Si el movimiento incluido en el cobro es una credilana o un prestamo personal *************
                           END --Fin si el endoso es de un documento

                         IF @CxcOrigenMov = 'Endoso'  --Inicio si el endoso es de un Endoso
                           BEGIN
                              SELECT @CxcOrigenMovTmp = MovAplica, @CxcOrigenMovIDTmp = MovAplicaID FROM Cxc WHERE Mov = @CxcOrigenMov AND MovID = @CxcOrigenMovID AND Estatus IN('CONCLUIDO','PENDIENTE') -- Obtenemos el movimiento que origino al documento



                              WHILE @CxcOrigenMovTmp = 'Endoso'  -- While para recorrer hasta que el movimiento que origino un endoso no sea un endoso
                                BEGIN
                                   SELECT @CxcOrigenMovTmp = MovAplica, @CxcOrigenMovIDTmp = MovAplicaID FROM Cxc WHERE Mov = @CxcOrigenMovTmp AND MovID = @CxcOrigenMovIDTmp AND Estatus IN('CONCLUIDO','PENDIENTE')
                                END
                              
							  IF @CxcOrigenMovTmp IN('Credilana','Prestamo Personal')  --Inicio si el endoso es de una Credilana o PP
                                BEGIN
                                   SELECT @CxcID = ID FROM Cxc WHERE Mov = @CxcOrigenMovTmp AND MovID = @CxcOrigenMovIDTmp AND Estatus IN('CONCLUIDO','PENDIENTE') --Obtenemos el ID de la credilana o PP 
                                   IF EXISTS(SELECT ID FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID)
                                     BEGIN -- Inicio Si existe la credilana o PP en la tabla de programacion de recuperacion
                                        IF EXISTS(SELECT ID FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp) -- Si el cobro esta dentro de alguno de los periodos y ejercicio de la programacion de recuperacion
                                          BEGIN
                                             SELECT @Cobro = ISNULL(Cobros, 0.0), @Creditos = ISNULL(Creditos, 0.0), @PorcentajeFinanciamiento = ISNULL(PorcentajeFinanciamiento, 0.0), @Renglon = ISNULL(Renglon, 0) FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp
                                             --IF @CxcDescuentoRecargos < 0
                                               --SELECT @CxcImporte = (ISNULL(@CxcImporte, 0.0)+ISNULL(@CxcDescuentoRecargos, 0.0))
											 IF @EsNC = 1
                                               SELECT @Creditos = (@Creditos + ISNULL(@CxcImporte, 0.0))
											 ELSE
											   SELECT @Cobro = (@Cobro + ISNULL(@CxcImporte, 0.0))
											 SELECT @Recuperacion = ISNULL(@Cobro, 0.0) -- + ISNULL(@Creditos, 0.0))
                                             SELECT @PagoFinanciamiento = @Recuperacion * @PorcentajeFinanciamiento
                                             IF (@Recuperacion >= 0 AND @PagoFinanciamiento >= 0)
                                               BEGIN
												  IF @EsNC = 1
													BEGIN
                                                       UPDATE  RecuperacionCredilanasPPMAVI SET Creditos = @Creditos, PagoFinanciamiento = @PagoFinanciamiento WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp
                                                       DELETE RecuperacionCredilanasPPMAVID WHERE ID = @CxcID AND CobroID = @ID AND Renglon = @Renglon AND CxcMov = (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END) AND CxcMovID = (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END) -- Borra antes de insertar  
                                                       INSERT RecuperacionCredilanasPPMAVID (ID, CobroID, Renglon, CxcRenglon, CxcMov, CxcMovID, CxcImporte, CobroEmision, NCImporte, EsNC) VALUES (@CxcID, @ID, @Renglon, @CxcRenglon, (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END), (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END), 0.0, @FechaEmision, @CxcImporte, @EsNC)
													END
										          ELSE
												    BEGIN
													   UPDATE  RecuperacionCredilanasPPMAVI SET Cobros = @Cobro, PagoFinanciamiento = @PagoFinanciamiento WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp
                                                       DELETE RecuperacionCredilanasPPMAVID WHERE ID = @CxcID AND CobroID = @ID AND Renglon = @Renglon AND CxcMov = (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END) AND CxcMovID = (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END) -- Borra antes de insertar  
                                                       INSERT RecuperacionCredilanasPPMAVID (ID, CobroID, Renglon, CxcRenglon, CxcMov, CxcMovID, CxcImporte, CobroEmision, NCImporte, EsNC) VALUES (@CxcID, @ID, @Renglon, @CxcRenglon, (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END), (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END), @CxcImporte, @FechaEmision, 0.0, @EsNC)
													END
                                                  EXEC sp_ActualizaProgaramaFinanciamientoMAVI @CxcID
                                               END
                                          END  -- Fin Si el cobro esta dentro de alguno de los periodos y ejercicio de la programacion de recuperacion
                                        ELSE
                                          BEGIN -- Inicio Si el cobro no esta dentro de ningun periodo y ejercicio pero si esta en la tabla de programacion de recuperacion
                                             SELECT @PorcentajeFinanciamiento = ISNULL(PorcentajeFinanciamiento, 0.0), @PorcentajeCapital = ISNULL(PorcentajeCapital, 0.0) FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID
                                             --IF @CxcDescuentoRecargos < 0
                                               --SELECT @CxcImporte = (ISNULL(@CxcImporte, 0.0)+ISNULL(@CxcDescuentoRecargos, 0.0))
									         SELECT @PagoFinanciamiento = (ISNULL(@CxcImporte, 0.0) * @PorcentajeFinanciamiento)
											 IF @EsNC = 1
											   BEGIN
                                                  SELECT @PagoFinanciamiento = 0.0
									              INSERT RecuperacionCredilanasPPMAVI (ID, Periodo, Ejercicio, FechaEmision, Vencimiento, Exigible, Cobros, Anterior, ExigiblePagado, Adelantado, PorcentajeCapital, PorcentajeFinanciamiento, PagoFinanciamiento, Ordinario, Arrastre, Cobertura, Creditos) 
									              VALUES (@CxcID, @PeriodoTmp, @EjercicioTmp, @FechaEmision, @FechaEmision, 0.0, 0.0, 0.0, 0.0, 0.0, @PorcentajeCapital, @PorcentajeFinanciamiento, @PagoFinanciamiento, 0, 0.0, 0.0, @CxcImporte) 
                            
									              SELECT @Renglon = ISNULL(Renglon, 0) FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp
									              DELETE RecuperacionCredilanasPPMAVID WHERE ID = @CxcID AND CobroID = @ID AND Renglon = @Renglon AND CxcMov = (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END) AND CxcMovID = (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END) -- Borra antes de insertar  
									              INSERT RecuperacionCredilanasPPMAVID (ID, CobroID, Renglon, CxcRenglon, CxcMov, CxcMovID, CxcImporte, CobroEmision, NCImporte, EsNC) 
									              VALUES (@CxcID, @ID, @Renglon, @CxcRenglon, (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END), (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END), 0.0, @FechaEmision, @CxcImporte, @EsNC)
											   END
											 ELSE
											   BEGIN
												  INSERT RecuperacionCredilanasPPMAVI (ID, Periodo, Ejercicio, FechaEmision, Vencimiento, Exigible, Cobros, Anterior, ExigiblePagado, Adelantado, PorcentajeCapital, PorcentajeFinanciamiento, PagoFinanciamiento, Ordinario, Arrastre, Cobertura, Creditos) 
									              VALUES (@CxcID, @PeriodoTmp, @EjercicioTmp, @FechaEmision, @FechaEmision, 0.0, @CxcImporte, 0.0, 0.0, 0.0, @PorcentajeCapital, @PorcentajeFinanciamiento, @PagoFinanciamiento, 0, 0.0, 0.0, 0.0) 
                            
									              SELECT @Renglon = ISNULL(Renglon, 0) FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp
									              DELETE RecuperacionCredilanasPPMAVID WHERE ID = @CxcID AND CobroID = @ID AND Renglon = @Renglon AND CxcMov = (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END) AND CxcMovID = (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END) -- Borra antes de insertar  
									              INSERT RecuperacionCredilanasPPMAVID (ID, CobroID, Renglon, CxcRenglon, CxcMov, CxcMovID, CxcImporte, CobroEmision, NCImporte, EsNC) 
									              VALUES (@CxcID, @ID, @Renglon, @CxcRenglon, (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END), (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END), @CxcImporte, @FechaEmision, 0.0, @EsNC)
											   END
                                             EXEC sp_ActualizaProgaramaFinanciamientoMAVI @CxcID
								          END  -- Fin Si el cobro no esta dentro de ningun periodo y ejercicio pero si esta en la tabla de programacion de recuperacion
							         END  -- Fin Si existe la credilana en la tabla de programacion de recuperacion
                                END  --Fin si el endoso es de una Credilana o PP

                              IF @CxcOrigenMovTmp = 'Documento'  --Inicio si el endoso es de un documento
                                BEGIN
                                   --SELECT @CxcOrigenMovTmp = @CxcOrigenMov, @CxcOrigenMovIDTmp = @CxcOrigenMovID
                                   SELECT @CxcOrigenMovTmp2 = Origen, @CxcOrigenMovIDTmp2 = OrigenID FROM Cxc WHERE Mov = @CxcOrigenMovTmp AND MovID = @CxcOrigenMovIDTmp AND Estatus IN('CONCLUIDO','PENDIENTE') -- Obtenemos el movimiento que origino al documento
                                   IF @CxcOrigenMovTmp2 IN('Credilana','Prestamo Personal')
                                     BEGIN --********************
                                        SELECT @CxcID = ID FROM Cxc WHERE Mov = @CxcOrigenMovTmp2 AND MovID = @CxcOrigenMovIDTmp2 AND Estatus IN('PENDIENTE','CONCLUIDO') -- Obtenemos el ID de la credilana o prestamo personal del cual viene el documento
                                        IF EXISTS(SELECT ID FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID)
                                          BEGIN -- Inicio Si existe la credilana o PP en la tabla de programacion de recuperacion
                                             IF EXISTS(SELECT ID FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp) -- Si el cobro esta dentro de alguno de los periodos y ejercicio de la programacion de recuperacion
                                               BEGIN
                                                  SELECT @Cobro = ISNULL(Cobros, 0.0), @Creditos = ISNULL(Creditos, 0.0), @PorcentajeFinanciamiento = ISNULL(PorcentajeFinanciamiento, 0.0), @Renglon = ISNULL(Renglon, 0) FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp
                                                  --IF @CxcDescuentoRecargos < 0
                                                    --SELECT @CxcImporte = (ISNULL(@CxcImporte, 0.0)+ISNULL(@CxcDescuentoRecargos, 0.0))
												  IF @EsNC = 1
                                                    SELECT @Creditos = (@Creditos + ISNULL(@CxcImporte, 0.0))
												  ELSE
													SELECT @Cobro = (@Cobro + ISNULL(@CxcImporte, 0.0))
                                                  SELECT @Recuperacion = ISNULL(@Cobro, 0.0) -- + ISNULL(@Creditos, 0.0))
                                                  SELECT @PagoFinanciamiento = @Recuperacion * @PorcentajeFinanciamiento
                                                  IF (@Recuperacion >= 0 AND @PagoFinanciamiento >= 0)
                                                    BEGIN
													   IF @EsNC = 1
													     BEGIN
															UPDATE  RecuperacionCredilanasPPMAVI SET Creditos = @Creditos, PagoFinanciamiento = @PagoFinanciamiento WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp
															DELETE RecuperacionCredilanasPPMAVID WHERE ID = @CxcID AND CobroID = @ID AND Renglon = @Renglon AND CxcMov = (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END) AND CxcMovID = (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END) -- Borra antes de insertar  
															INSERT RecuperacionCredilanasPPMAVID (ID, CobroID, Renglon, CxcRenglon, CxcMov, CxcMovID, CxcImporte, CobroEmision, NCImporte, EsNC) VALUES (@CxcID, @ID, @Renglon, @CxcRenglon, (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END), (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END), 0.0, @FechaEmision, @CxcImporte, @EsNC)
														 END  
													   ELSE
													     BEGIN
															UPDATE  RecuperacionCredilanasPPMAVI SET Cobros = @Cobro, PagoFinanciamiento = @PagoFinanciamiento WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp
															DELETE RecuperacionCredilanasPPMAVID WHERE ID = @CxcID AND CobroID = @ID AND Renglon = @Renglon AND CxcMov = (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END) AND CxcMovID = (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END) -- Borra antes de insertar  
															INSERT RecuperacionCredilanasPPMAVID (ID, CobroID, Renglon, CxcRenglon, CxcMov, CxcMovID, CxcImporte, CobroEmision, NCImporte, EsNC) VALUES (@CxcID, @ID, @Renglon, @CxcRenglon, (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END), (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END), @CxcImporte, @FechaEmision, 0.0, @EsNC)
													     END
                                                       EXEC sp_ActualizaProgaramaFinanciamientoMAVI @CxcID
                                                    END
                                               END  -- Fin Si el cobro esta dentro de alguno de los periodos y ejercicio de la programacion de recuperacion
                                             ELSE
                                               BEGIN -- Inicio Si el cobro no esta dentro de ningun periodo y ejercicio pero si esta en la tabla de programacion de recuperacion
                                                  SELECT @PorcentajeFinanciamiento = ISNULL(PorcentajeFinanciamiento, 0.0), @PorcentajeCapital = ISNULL(PorcentajeCapital, 0.0) FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID
                                                  --IF @CxcDescuentoRecargos < 0
                                                    --SELECT @CxcImporte = (ISNULL(@CxcImporte, 0.0)+ISNULL(@CxcDescuentoRecargos, 0.0))
									              SELECT @PagoFinanciamiento = (ISNULL(@CxcImporte, 0.0) * @PorcentajeFinanciamiento)
												  IF @EsNC = 1
													BEGIN
													   SELECT @PagoFinanciamiento = 0.0
													   INSERT RecuperacionCredilanasPPMAVI (ID, Periodo, Ejercicio, FechaEmision, Vencimiento, Exigible, Cobros, Anterior, ExigiblePagado, Adelantado, PorcentajeCapital, PorcentajeFinanciamiento, PagoFinanciamiento, Ordinario, Arrastre, Cobertura, Creditos) 
													   VALUES (@CxcID, @PeriodoTmp, @EjercicioTmp, @FechaEmision, @FechaEmision, 0.0, 0.0, 0.0, 0.0, 0.0, @PorcentajeCapital, @PorcentajeFinanciamiento, @PagoFinanciamiento, 0, 0.0, 0.0, @CxcImporte) 
                            
													   SELECT @Renglon = ISNULL(Renglon, 0) FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp
													   DELETE RecuperacionCredilanasPPMAVID WHERE ID = @CxcID AND CobroID = @ID AND Renglon = @Renglon AND CxcMov = (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END) AND CxcMovID = (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END)-- Borra antes de insertar  
													   INSERT RecuperacionCredilanasPPMAVID (ID, CobroID, Renglon, CxcRenglon, CxcMov, CxcMovID, CxcImporte, CobroEmision, NCImporte, EsNC) 
													   VALUES (@CxcID, @ID, @Renglon, @CxcRenglon, (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END), (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END), 0.0, @FechaEmision, @CxcImporte, @EsNC)
													END
												  ELSE
												    BEGIN
													   INSERT RecuperacionCredilanasPPMAVI (ID, Periodo, Ejercicio, FechaEmision, Vencimiento, Exigible, Cobros, Anterior, ExigiblePagado, Adelantado, PorcentajeCapital, PorcentajeFinanciamiento, PagoFinanciamiento, Ordinario, Arrastre, Cobertura, Creditos) 
													   VALUES (@CxcID, @PeriodoTmp, @EjercicioTmp, @FechaEmision, @FechaEmision, 0.0, @CxcImporte, 0.0, 0.0, 0.0, @PorcentajeCapital, @PorcentajeFinanciamiento, @PagoFinanciamiento, 0, 0.0, 0.0, 0.0) 
                            
													   SELECT @Renglon = ISNULL(Renglon, 0) FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID AND Periodo = @PeriodoTmp AND Ejercicio = @EjercicioTmp
													   DELETE RecuperacionCredilanasPPMAVID WHERE ID = @CxcID AND CobroID = @ID AND Renglon = @Renglon AND CxcMov = (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END) AND CxcMovID = (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END) -- Borra antes de insertar  
													   INSERT RecuperacionCredilanasPPMAVID (ID, CobroID, Renglon, CxcRenglon, CxcMov, CxcMovID, CxcImporte, CobroEmision, NCImporte, EsNC) 
													   VALUES (@CxcID, @ID, @Renglon, @CxcRenglon, (CASE @EsPuente WHEN 1 THEN @MovPuente ELSE @CxcMov END), (CASE @EsPuente WHEN 1 THEN @MovIDPuente ELSE @CxcMovID END), @CxcImporte, @FechaEmision, 0.0, @EsNC)

													END
                                                  EXEC sp_ActualizaProgaramaFinanciamientoMAVI @CxcID
								               END  -- Fin Si el cobro no esta dentro de ningun periodo y ejercicio pero si esta en la tabla de programacion de recuperacion
							              END  -- Fin Si existe la credilana en la tabla de programacion de recuperacion
                                     END --Fin Si el movimiento incluido en el cobro es una credilana o un prestamo personal *************
                                END --Fin si el endoso es de un documento

                              
                           END   --Fin si el endoso es de un Endoso

   
                      END --Fin Si el movimiento incluido en el cobro es un Endoso ************* 

                 END  -- Fin Si el movimiento incluido en el cobro NO es una credilana o un prestamo personal
               SET @Cont= @Cont + 1
			END  -- Fin While 
          CLOSE DoctosACobrar   
          DEALLOCATE DoctosACobrar
       END 
  END

RETURN

END
GO

/************************ spActualizaTiemposMAVI *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spActualizaTiemposMAVI') AND type = 'P') DROP PROCEDURE dbo.spActualizaTiemposMAVI
GO
CREATE PROCEDURE [dbo].[spActualizaTiemposMAVI]
					@Modulo		char(5),
					@ID         int,
					@Accion		char(20),
					@Usuario	char(10)
--//WITH ENCRYPTION
AS  BEGIN

	DECLARE
	@Origen	char(20),
	@OrigenID	char(20),
	@IDOrigen	int

	IF @Accion = 'CANCELAR'
		UPDATE MovTiempo Set Usuario = @Usuario WHERE Modulo = @Modulo AND ID = @ID AND Estatus = 'CANCELADO'

	IF @Accion = 'AFECTAR' AND @Modulo = 'VTAS'
	BEGIN
		Select @Origen = Venta.Origen , @OrigenID = Venta.OrigenID  From Venta Where Venta.ID=@ID
		Select @IDOrigen = v.ID From Venta v Where v.Mov = @Origen AND v.MovID = @OrigenID 
		UPDATE MovTiempo Set Usuario = @Usuario WHERE Modulo = @Modulo AND ID = @IDOrigen AND Estatus = 'CONCLUIDO'
	END

END
GO

/************************ spApoyoFactorIMMavi *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spApoyoFactorIMMavi') AND type = 'P') DROP PROCEDURE dbo.spApoyoFactorIMMavi
GO
CREATE PROCEDURE spApoyoFactorIMMavi
			@ID			int
--//WITH ENCRYPTION
AS BEGIN
	DECLARE @FechaOriginal	datetime,
			@FechaEmision	datetime
	  
  
	SELECT @FechaOriginal = FechaOriginal, @FechaEmision = FechaEmision FROM CXC where Id = @ID
  
	IF @FechaOriginal IS NULL
		UPDATE Cxc SET FechaOriginal = @FechaEmision where Id = @ID
  
 
RETURN

END
GO

/************************ spBonificacionDocRestantes *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spBonificacionDocRestantes') AND type = 'P') DROP PROCEDURE dbo.spBonificacionDocRestantes
GO
CREATE PROCEDURE [dbo].[spBonificacionDocRestantes]  
  @Bonificacion varchar(50),  
  @EnCascada    varchar(5),  
  @Origen       varchar(20),  
  @OrigenId     varchar(20),  
  @Idventa      int,  
  @lineaVta     varchar(50),  
  @Sucursal     int,  
  @TipoSucursal varchar(50),   
  @Estacion     int,  
  @Uen          int,  
  @Condicion    VarChar(50),  
  @ImporteVenta float,  
  @Tipo         VarChar(10),  
  @idCxc        int ,  
  @IdCoBro      int,  
  @MaxDiasAtrazo float,  
  @IdBonifica   int,   
  @StrBonifica  varchar(50),  
  @BaseParaAPlicar Float,   
  @Incluye      char(10),   
  @MontoBonifPapa float ,   
  @FechaEmisionBase  Datetime  
--//WITH ENCRYPTION  
AS   
BEGIN  
  DECLARE  
----- 1. Declara  
  @Empresa          VarChar(5),  
  @Mov              VarChar(20),  
  @MovId            VarChar(20),  
  @FechaEmision     Datetime,  
  @Concepto         VarChar(50),  
  @TipoCambio       float,  
  @ClienteEnviarA   int,  
  @Vencimiento      Datetime,  
  @Impuestos        float,  
  @Saldo            float,       
  @ImporteDocto     float,  
  @ImporteCasca     float,  
  @Referencia       varchar(50),  
  @Documento1de     Int,  
  @DocumentoTotal   Int,   
  @OrigenTipo       varchar(20),     
  @ExtraeD          Int,  
  @ExtraeA          Int,  
  @MovIdVenta       varchar(20),  
  @MovVenta         varchar(20),  
  @DiasMenoresA       Int,  
  @DiasMayoresA       Int,  
------   Factura AAA6 (12/13)  
  @Id                int,  
  @IdBonificacion    Int,  
  @Estatus           varchar(15),  
  @PorcBon1          float,  
  @PorcBon1Bas       float,  
  @MontoBonif        float,  
  @Financiamiento    float,  
  @FechaIni          datetime,  
  @FechaFin          datetime,  
  @PagoTotal         bit,  
  @ActVigencia       bit,  
  @CascadaCalc       bit,  
  @AplicaA           Char(30),  
  @PlazoEjeFin       int,   
  @VencimientoAntes  Int,  
  @VencimientoDesp   Int,  
  @DiasAtrazo        Int,  
  @Factor            float,  
  @MesesExced        int,  
  @Linea             Float,  
  @FechaCancelacion  datetime,  
  @FechaRegistro     datetime,  
  @Usuario           Varchar(10),  
  @Ok                int,   
  @OkRef             Varchar(50),  
  @Periodo           int,  
  @CharReferencia    Varchar(20),  
  @NoPuedeAplicarSola Bit,  
  @Ejercicio         Int,  
  @LineaCelulares    float,   
  @LineaCredilanas   float,   
  @ImporteVenta2   FLOAT,  
  @LineaMotos VARCHAR(25),
  @MesesAdelanto INT  
  
  
----- 2. Inicializanas   
      SELECT @Ok = null , @OkRef = '', @Ejercicio = year(getdate()), @Periodo = Month(getdate()), @Mov = '',@DiasMenoresA=0, @DiasMayoresA=0, @CharReferencia= 0 , @ImporteCasca=0.00  
      SELECT @ImporteVenta2 = 0.00  
      SELECT @Mov = Mov FROM CXC WHERE Id = @IdCxc  
  
----- 3. Carga Bonificacion   
  IF @Incluye = 'Incluye'  
    SELECT    
      @IdBonificacion = Id,@PorcBon1Bas = PorcBon1,@Financiamiento = Financiamiento,@FechaIni = FechaIni,  
      @FechaFin = FechaFin,@PagoTotal = PagoTotal,@AplicaA = AplicaA,@PlazoEjeFin = PlazoEjeFin,@VencimientoAntes = VencimientoAntes,  
      @VencimientoDesp = VencimientoDesp,@DiasAtrazo = DiasAtrazo,@DiasMenoresA = DiasMenoresA,@DiasMayoresA = DiasMayoresA,  
      @Factor = Factor,@Linea = Linea, @NoPuedeAplicarSola = isnull(NoPuedeAplicarSola,0)   
    FROM MaviBonificacionConf WITH(NOLOCK)
    JOIN MaviBonificacionMov bm WITH(NOLOCK) ON ID = bm.IDBonificacion  
    WHERE Bonificacion = @Bonificacion   
    AND Estatus = 'CONCLUIDO'      
    AND FechaIni <= @FechaEmisionBase  AND FechaFin >= @FechaEmisionBase  
    AND bm.Movimiento = @Mov   
  SELECT @Mov = ''      
  
  IF @Incluye <> 'Incluye'  
    SELECT    
      @IdBonificacion = Id,@PorcBon1bas = PorcBon1,@Financiamiento = Financiamiento,@FechaIni = FechaIni,  
      @FechaFin = FechaFin,@PagoTotal = PagoTotal,@AplicaA = AplicaA,@PlazoEjeFin = PlazoEjeFin,@VencimientoAntes = VencimientoAntes,  
      @VencimientoDesp = VencimientoDesp,@DiasAtrazo = DiasAtrazo,@DiasMenoresA = DiasMenoresA,@DiasMayoresA = DiasMayoresA,  
      @Factor = Factor,@Linea = Linea, @NoPuedeAplicarSola = isnull(NoPuedeAplicarSola,0)   
    FROM MaviBonificacionConf WITH(NOLOCK)
    WHERE Bonificacion = @Bonificacion   
    AND ID = @IdBonifica  
    AND Estatus = 'CONCLUIDO'      
 AND FechaIni <= @FechaEmisionBase  AND FechaFin >= @FechaEmisionBase  
  
  IF @Tipo = 'Total'  AND @NoPuedeAplicarSola = 0   
  Begin   
      DECLARE CrCxCPendientes CURSOR FOR   
      SELECT Id, Empresa,Mov,MovId, FechaEmision,Concepto,  
          ClienteEnviarA,Vencimiento,Importe, Impuestos,Saldo,Concepto,Referencia  
      FROM Cxc cp WITH(NOLOCK)  
      WHERE cp.PadreMAVI = @Origen AND cp.PadreIDMAVI = @OrigenId  
       AND NOT Referencia IS NULL AND cp.Estatus= 'PENDIENTE'  
       UNION   
      SELECT cp.Id, cp.Empresa,cp.Mov,cp.MovId, cp.FechaEmision,cp.Concepto,  
          cp.ClienteEnviarA,cp.Vencimiento,cp.Importe, cp.Impuestos,cp.Saldo,cp.Concepto,cp.Referencia  
      FROM CxcPendiente cp WITH(NOLOCK)
      JOIN NegociaMoratoriosMAVI nmm ON(cp.Mov = nmm.Mov AND cp.MovID = nmm.MovID)
      WHERE cp.PadreMAVI = @Origen AND cp.PadreIDMAVI = @OrigenId   
       AND cp.Estatus= 'PENDIENTE'  
       AND (nmm.Mov LIKE '%Nota Cargo%' OR nmm.Mov LIKE '%Contra Recibo%')  
       AND nmm.IDCobro=@IdCoBro  
  END    
  ELSE IF ISNULL(@Tipo,'')<>'Total' AND @NoPuedeAplicarSola = 0   
  BEGIN  
      DECLARE CrCxCPendientes CURSOR FOR   
      SELECT Id, Empresa,Mov,MovId, FechaEmision,Concepto,  
          ClienteEnviarA,Vencimiento,Importe, Impuestos,Saldo,Concepto,Referencia  
      FROM CxcPendiente cp WITH(NOLOCK)  
      WHERE cp.PadreMAVI = @Origen AND cp.PadreIDMAVI = @OrigenId  
       AND NOT Referencia IS NULL AND cp.Estatus= 'PENDIENTE'  
       UNION   
      SELECT cp.Id, cp.Empresa,cp.Mov,cp.MovId, cp.FechaEmision,cp.Concepto,  
          cp.ClienteEnviarA,cp.Vencimiento,cp.Importe, cp.Impuestos,cp.Saldo,cp.Concepto,cp.Referencia  
      FROM CxcPendiente cp WITH(NOLOCK)
      JOIN NegociaMoratoriosMAVI nmm WITH(NOLOCK) ON(cp.Mov = nmm.Mov AND cp.MovID = nmm.MovID )
      WHERE cp.PadreMAVI = @Origen AND cp.PadreIDMAVI = @OrigenId   
       AND cp.Estatus= 'PENDIENTE'  
       AND (nmm.Mov LIKE '%Nota Cargo%' OR nmm.Mov LIKE '%Contra Recibo%')  
       AND nmm.IDCobro=@IdCoBro  
  END    
   
  
  IF @NoPuedeAplicarSola = 1    
  BEGIN  
      DECLARE CrCxCPendientes CURSOR FOR   
      SELECT TOP(1)Id, Empresa,Mov,MovId, FechaEmision,Concepto,  
          ClienteEnviarA,Vencimiento,Importe, Impuestos,Saldo,Concepto,Referencia  
      FROM CxcPendiente cp WITH(NOLOCK)  
      WHERE cp.PadreMAVI = @Origen AND cp.PadreIDMAVI = @OrigenId  
       AND NOT Referencia IS NULL AND cp.Estatus= 'PENDIENTE'        
  END   
  
  IF @IDBonificacion is not null   
  BEGIN  
    OPEN CrCxCPendientes  
    FETCH NEXT FROM CrCxCPendientes INTO @IdCxC, @Empresa,@Mov,@MovId, @FechaEmision,@Concepto,  
          @ClienteEnviarA,@Vencimiento,@ImporteDocto, @Impuestos,@Saldo,@Concepto,@Referencia  
    WHILE @@FETCH_STATUS = 0  
    BEGIN  
        --- suma total + Impuestos  
        SELECT @ImporteDocto = @ImporteDocto + isnull(@Impuestos,0.00), @PorcBon1 = @PorcBon1Bas, @Ok = NULL, @OkRef = ''  
  
       IF @Mov LIKE '%Nota Cargo%'   
       BEGIN   
          IF NOT @Concepto in ('CANC COBRO CRED Y PP', 'CANC COBRO FACTURA','CANC COBRO SEG AUTO','CANC COBRO SEG VIDA', 'CANC COBRO FACTURA VIU','CANC COBRO MAYOREO')  
            SELECT @Ok=1, @OkRef = 'La Nota No Pertenece a un Concepto para Bonificaci¢n'   
       END  
  
        IF patindex('%/%',@Referencia) > 0    
        BEGIN  
          SELECT @ExtraeD = patindex('%(%',@Referencia), @ExtraeA = patindex('%/%',@Referencia)  
          SELECT @Documento1de = substring(@Referencia,@ExtraeD+1,@ExtraeA - @ExtraeD -1)      
          SELECT @ExtraeD = patindex('%/%',@Referencia), @ExtraeA = patindex('%)%',@Referencia)  
          SELECT @DocumentoTotal = substring(@Referencia,@ExtraeD+1,@ExtraeA - @ExtraeD -1)  
        END  
  
          IF @VencimientoAntes <> 0 AND (NOT @Mov like '%Nota Cargo%' OR NOT @Mov like '%Contra%')  
      BEGIN  
 SET @CharReferencia = rtrim(@VencimientoAntes) + '/' + rtrim(@DocumentoTotal)  
            IF NOT EXISTS(SELECT ID FROM CxcPendiente WITH(NOLOCK)  
                          WHERE PadreMAVI = @Origen AND PadreIDMAVI = @OrigenId  
             AND Estatus = 'PENDIENTE' AND referencia LIKE '%' + @CharReferencia + '%')  
                SELECT @Ok=1, @OkRef = 'Excede el N£mero M¡nimo del Pago a jalar'   
          END          
  
          IF @VencimientoDesp <= @Documento1de AND @VencimientoDesp <> 0  AND (NOT @Mov like '%Nota Cargo%' OR NOT @Mov like '%Contra%')  
          BEGIN    
           SET @CharReferencia = rtrim(@Documento1de) + '/' + rtrim(@DocumentoTotal)    
            IF NOT EXISTS(SELECT ID FROM CxcPendiente WITH(NOLOCK)    
                          WHERE PadreMAVI = @Origen AND PadreIDMAVI = @OrigenID  
                AND Estatus = 'PENDIENTE' AND referencia LIKE '%' + @CharReferencia + '%')     
                SELECT @Ok=1, @OkRef = 'Excede el Numero Maximo del Pago a jalar'     
          END  
                    -- 5.2 Dias Atrazo  
          IF @DiasAtrazo <> 0 AND @Mov <> 'Nota Cargo'  
          BEGIN  
            IF @MaxDiasAtrazo > @DiasAtrazo SELECT @Ok=1, @OkRef = 'Excede el n£mero de dias de atraso permitidos '     
          END  
            
          ---- 5.3  
          IF @DiasMenoresA <> 0 AND @Bonificacion NOT LIKE '%Contado Comercial%'  
          BEGIN  
           IF @DiasMenoresA < DATEDIFF(DAY, @FechaEmision, getdate() )  
              SELECT @Ok=1, @OkRef = 'Excede d¡as menores'  + CONVERT (char(30),@DiasMenoresA)  
          END  
          -- 5.3 Dias de Mayores  
          IF @DiasMayoresA <> 0 AND @Bonificacion NOT LIKE '%Contado Comercial%'  
          BEGIN  
         IF @DiasMayoresA > DATEDIFF(DAY, @FechaEmision, getdate() )  
                 SELECT @Ok=1, @OkRef = 'Excede d¡as mayores'  + CONVERT (char(30),@DiasMayoresA)  
          END  
  
          ---- 5.4   Validacion para VencimientoDespues, traida desde spBonificacionesCalculaTabla GRB 24/07/10   
          IF @VencimientoDesp <> 0  
          BEGIN      
            SET @CharReferencia = '(' +  rtrim(@VencimientoDesp) + '/' + rtrim(@DocumentoTotal)      
                            
              IF dbo.fnFechaSinHora(GETDATE())  <=  dbo.fnFechaSinHora((Select c.Vencimiento FROM Cxc c WITH(NOLOCK) WHERE c.Origen = @Origen AND c.OrigenID = @OrigenId AND c.Referencia LIKE '%' + @CharReferencia + '%'))    
                SELECT @Ok=1, @OkRef = 'No cumple con el límite de pago posterior2'      
              
          END  
  
            IF @PorcBon1 = 0 AND @Linea <> 0 SELECT @PorcBon1 = @Linea  
            IF @Linea < (SELECT isnull(PorcLin,0.00) FROM MaviBonificacionLinea WITH(NOLOCK) WHERE IdBonificacion=@id AND Linea = @LineaVta)   
                  SELECT @Linea = (SELECT isnull(PorcLin,0.00) FROM MaviBonificacionLinea WITH(NOLOCK) WHERE IdBonificacion=@id AND Linea = @LineaVta)                           
                    
            SELECT @LineaCredilanas=isnull(PorcLin,0.00) FROM MaviBonificacionLinea mbl WITH(NOLOCK) WHERE Linea LIKE '%Credilana%' AND IdBonificacion = @IdBonificacion  
            SELECT @LineaCelulares=isnull(PorcLin,0.00) FROM MaviBonificacionLinea mbl WITH(NOLOCK) WHERE Linea LIKE '%Celular%' AND IdBonificacion = @IdBonificacion  
            --Je.deltoro  
            SELECT @LineaMotos=isnull(PorcLin,0.00) FROM MaviBonificacionLinea mbl WITH(NOLOCK) WHERE Linea LIKE '%MOTOCICLETA%' AND IdBonificacion = @IdBonificacion  
                    
            --- 6.2 Canal Ventas  
            IF EXISTS(SELECT IdBonificacion FROM MaviBonificacionCanalVta BonCan WITH(NOLOCK) WHERE BonCan.IdBonificacion=@IdBonificacion)  
            BEGIN              
              IF NOT EXISTS(SELECT IdBonificacion FROM MaviBonificacionCanalVta BonCan WITH(NOLOCK) WHERE CONVERT(varchar(10),BonCan.CanalVenta)=@ClienteEnviarA AND BonCan.IdBonificacion=@IdBonificacion)  
                 SELECT @Ok=1, @OkRef = 'Venta de Canal No Configurada Para esta Bonificaci¢n'               
            END       
          --- 6.3 UEN's  
            IF EXISTS(SELECT IdBonificacion FROM MaviBonificacionUEN mbu WITH(NOLOCK) WHERE mbu.idBonificacion=@IdBonificacion)  
            BEGIN    
              IF NOT @UEN is NULL AND NOT EXISTS(SELECT IdBonificacion FROM MaviBonificacionUEN mbu WITH(NOLOCK) WHERE mbu.UEN = @UEN AND mbu.idBonificacion=@IdBonificacion)  
                 SELECT @Ok=1, @OkRef = 'UEN No Configurada Para este Caso'   
            END  
          --- 6.4 Condicion  
            IF EXISTS(SELECT IdBonificacion FROM MaviBonificacionCondicion WITH(NOLOCK) WHERE IdBonificacion=@IdBonificacion)  
          BEGIN                          
              IF NOT EXISTS(SELECT IdBonificacion FROM MaviBonificacionCondicion WITH(NOLOCK) WHERE COndicion=@Condicion AND IdBonificacion=@IdBonificacion)  
                 SELECT @Ok=1, @OkRef = 'Condicion No Configurada Para esta Bonificaci¢n'   
            END       
          --- 6.5 Bonif Exclu  
  
            IF EXISTS(SELECT IdBonificacion FROM MaviBonificacionExcluye Exc WITH(NOLOCK) WHERE BonificacionNo=@Bonificacion)  
            BEGIN                          
                
              IF EXISTS(SELECT BonTest.IdBonificacion FROM MaviBonificacionTest BonTest WITH(NOLOCK) JOIN MaviBonificacionExcluye Exc WITH(NOLOCK) ON(Bontest.IdBonificacion = Exc.IdBonificacion)   
                WHERE Exc.BonificacionNo=@Bonificacion AND Bontest.OkRef = ''  AND BonTest.MontoBonif > 0   
                AND idcobro = @IdCoBro AND Origen=@Origen AND OrigenId=@OrigenId)   
                SELECT @Ok=1, @OkRef = 'Excluye esta Bonificacion Una anterior  Detalle'   
    
                
            END                  
          --- 6.6 Sucursal  
            IF EXISTS(SELECT IdBonificacion FROM MaviBonificacionSucursal Exc WITH(NOLOCK) WHERE IdBonificacion=@IdBonificacion)  
            BEGIN                          
              IF NOT @TipoSucursal IS NULL AND NOT EXISTS(SELECT IdBonificacion FROM MaviBonificacionSucursal WITH(NOLOCK) WHERE Sucursal=@TipoSucursal AND idBonificacion=@IdBonificacion)  
                 SELECT @Ok=1, @OkRef = 'Bonificaci¢n No Configurada Para este tipo de Sucursal'                
            END       
  
          IF NOT EXISTS(SELECT IdBonificacion FROM MaviBonificacionTest WITH(NOLOCK) WHERE idBonificacion=rtrim(@IdBonificacion) AND Docto = @IdCxC AND Estacion = @Estacion AND MontoBonif = @MontoBonif)  
          BEGIN  
  
                    IF @AplicaA = 'Importe de Factura'    
                      BEGIN   
                       IF @Linea <> 0 SELECT @PorcBon1=@Linea  
                       IF @LineaCelulares <> 0  AND @Bonificacion NOT LIKE '%Contado%'  AND @Bonificacion NOT LIKE '%Atraso%'  SELECT @PorcBon1=@LineaCelulares  
                       IF @LineaCredilanas <> 0  AND @Bonificacion NOT LIKE '%Contado%'  AND @Bonificacion NOT LIKE '%Atraso%'  SELECT @PorcBon1=@LineaCredilanas  
                       --Je.deltoro  
                       --IF @LineaMotos <> 0 AND @Bonificacion LIKE '%Contado Comercial%' SELECT @PorcBon1=@LineaMotos   
                         
                       IF @EnCascada = 'Si' SELECT @ImporteVenta2 = @ImporteVenta - @MontoBonifPapa  
					   IF @EnCascada <> 'Si' SELECT @ImporteVenta2 = @ImporteVenta  
                       SELECT @MontoBonif = (@PorcBon1/100) * @ImporteVenta2 ------ Importe Sobre el Plaxo Eje  
  
                      END   
                    IF @Bonificacion LIKE '%Adelanto%' AND @Tipo = 'Total'
                      BEGIN   
                       IF @Linea <> 0 SELECT @PorcBon1=@Linea  
                       IF @LineaCelulares <> 0  AND @lineaVta LIKE '%CELULAR%' SELECT @PorcBon1=@LineaCelulares  
					   IF @LineaCredilanas <> 0  AND @lineaVta LIKE '%CREDILA%' SELECT @PorcBon1=@LineaCredilanas  
					   --Je.deltoro  
					   IF @Bonificacion LIKE '%Contado%' SELECT @PorcBon1=@LineaMotos                 
					   IF @EnCascada = 'Si' SELECT @ImporteVenta2 = @ImporteVenta - @MontoBonifPapa  
					   IF @EnCascada <> 'Si' SELECT @ImporteVenta2 = @ImporteVenta
					   SELECT @MesesAdelanto = CASE WHEN Vencimiento > GETDATE() 
														 THEN CASE WHEN DATEDIFF(DD,GETDATE(),Vencimiento) % 30.4 <> 0 
																		THEN CAST((DATEDIFF(DD,GETDATE(),Vencimiento) / 30.4 ) AS INT) + 1
																   WHEN DATEDIFF(DD,Vencimiento,GETDATE())%30.4 = 0
																		THEN CAST((DATEDIFF(DD,GETDATE(),Vencimiento) / 30.4 ) AS INT)
															  END
													 ELSE 1 END
														FROM (
															SELECT 
																N = ROW_NUMBER() OVER(PARTITION BY PadreMAVI,PadreIDMAVI ORDER BY Vencimiento DESC),
																PadreMAVI,PadreIDMAVI,Vencimiento
															FROM Cxc WITH(NOLOCK)
															WHERE PadreMAVI = @Origen AND PadreIDMAVI = @OrigenId AND PadreMAVI <> Mov
														)x WHERE n=1 AND VENCIMIENTO>GETDATE()
					   IF @MesesAdelanto > @DocumentoTotal SELECT @MesesAdelanto = @DocumentoTotal
					   SELECT @PorcBon1 = @PorcBon1 * @MesesAdelanto
					   SELECT @ImporteVenta2 = (@ImporteVenta2 / @DocumentoTotal) * @MesesAdelanto
   					   SELECT @ImporteVenta2 = @ImporteVenta2 / (SELECT COUNT(ID) FROM (
												  SELECT Id, Empresa,Mov,MovId, FechaEmision,Concepto,  
													  ClienteEnviarA,Vencimiento,Importe, Impuestos,Saldo,Referencia  
												  FROM Cxc cp WITH(NOLOCK)
												  WHERE cp.PadreMAVI = @Origen AND cp.PadreIDMAVI = @OrigenId  
												   AND NOT Referencia IS NULL AND cp.Estatus= 'PENDIENTE'  
												   UNION   
												  SELECT cp.Id, cp.Empresa,cp.Mov,cp.MovId, cp.FechaEmision,cp.Concepto,  
													  cp.ClienteEnviarA,cp.Vencimiento,cp.Importe, cp.Impuestos,cp.Saldo,cp.Referencia  
												  FROM CxcPendiente cp WITH(NOLOCK)
												  JOIN NegociaMoratoriosMAVI nmm WITH(NOLOCK) ON(cp.Mov = nmm.Mov AND cp.MovID = nmm.MovID)
												  WHERE cp.PadreMAVI = @Origen AND cp.PadreIDMAVI = @OrigenId   
												   AND cp.Estatus= 'PENDIENTE'  
												   AND (nmm.Mov LIKE '%Nota Cargo%' OR nmm.Mov LIKE '%Contra Recibo%')  
												   AND nmm.IDCobro=@IdCoBro)x )
                      END   
                    IF @AplicaA <> 'Importe de Factura' AND @Bonificacion<>'Bonificacion Pago Puntual' 
						SELECT @MontoBonif = (@PorcBon1/100) * @ImporteVenta2  
					IF @AplicaA <> 'Importe de Factura' AND @Bonificacion='Bonificacion Pago Puntual' 
						SELECT @MontoBonif = (@PorcBon1/100) * @ImporteDocto  
                     
            IF NOT @Ok is NULL SELECT @MontoBonif = 0.00,@PorcBon1 = 0.00    ---- Pone en Ceros los que no aplica  
  
            IF @Bonificacion LIKE '%Puntual%' AND (dbo.fnFechaSinHora(GETDATE()) > (dbo.fnFechaSinHora(@Vencimiento)))  
            BEGIN   
               SELECT @Ok = 1 , @OkRef = 'Excede el vencimiento', @MontoBonif = 0.00 , @PorcBon1 = 0.00                       
  
            END     
  
  
   IF @Bonificacion LIKE '%Adelanto%' AND dbo.fnFechaSinHora(GETDATE()) >= dbo.fnFechaSinHora(@Vencimiento) ----pto 33 pzamudio   
    SELECT @MontoBonif = 0.00 , @PorcBon1 = 0.00, @Ok = 1 , @OkRef = 'Por el Vencimiento del Docto'                      
   
  
   IF @Bonificacion LIKE '%Adelanto%' AND @Tipo<>'Total' SELECT @MontoBonif = 0.00 , @PorcBon1 = 0.00 , @Ok = 1 , @OkRef = 'Adelanto Aplica a puro Total'                          
   IF @Bonificacion LIKE '%Atraso%' AND @Tipo<>'Total' SELECT @MontoBonif = 0.00 , @PorcBon1 = 0.00        
   IF @Bonificacion LIKE '%Atraso%' AND @Tipo<>'Total' SELECT @BaseParaAPlicar = @BaseParaAPlicar - @MontoBonifPapa  
   IF @Bonificacion LIKE '%Atraso%' SELECT @BaseParaAPlicar = @ImporteVenta2  
   IF @Bonificacion LIKE '%Puntual%' SELECT @BaseParaAPlicar = @ImporteDocto      
             
            INSERT MaviBonificacionTest (idBonificacion, IdCoBro, Docto,Bonificacion,    Estacion, Documento1de,DocumentoTotal,Mov, MovId,Origen,OrigenId,ImporteVenta,ImporteDocto, MontoBonif, TipoSucursal,LineaVta,IdVenta,UEN,Condicion,PorcBon1,  
                                          Financiamiento, Ok,OkRef,Factor,Sucursal1, PlazoEjeFin,FechaEmision,Vencimiento, LineaCelulares, LineaCredilanas,DiasMenoresA,DiasMayoresA,BaseParaAPlicar)  
                                  VALUES(@IdBonificacion,@IdCoBro, @IdCxC,isnull(@Bonificacion,''),@Estacion, isnull(@Documento1de,0),isnull(@DocumentoTotal,0),isnull(@Mov,''),isnull(@MovId,''), isnull(@Origen,''),isnull(@OrigenId,''),  
                                  round(isnull(@ImporteVenta,0.00),2), round(isnull(@ImporteDocto,0.00),2), round(isnull(@MontoBonif,0.00),2), isnull(@TipoSucursal,''),isnull(@LineaVta,''),isnull(@IdVenta,0),isnull(@UEN,0),isnull(@Condicion,''),  
                                  isnull(@PorcBon1,0.00), isnull(@Financiamiento,0.00), isnull(@Ok,0),isnull(@OkRef,''),isnull(@factor,0.00),@Sucursal,@PlazoEjeFin,@FechaEmision,@Vencimiento, isnull(@LineaCelulares,0.00), isnull(@LineaCredilanas,0.00),  



                                  @DiasMenoresA,@DiasMayoresA,round(isnull(@BaseParaAPlicar,0.00),2))  
             
          END         
    FETCH NEXT FROM CrCxCPendientes INTO @IdCxC, @Empresa,@Mov,@MovId, @FechaEmision,@Concepto,  
          @ClienteEnviarA,@Vencimiento,@ImporteDocto, @Impuestos,@Saldo,@Concepto,@Referencia  
    END  
    CLOSE CrCxCPendientes  
    DEALLOCATE CrCxCPendientes        
  END   
END
GO

/************************ spBonificacionesCalculaTabla *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spBonificacionesCalculaTabla') AND type = 'P') DROP PROCEDURE dbo.spBonificacionesCalculaTabla
GO
CREATE PROCEDURE [dbo].[spBonificacionesCalculaTabla]  @IdCxC    Int,
  @Estacion int = 1,
  @Tipo     char(10),
  @IdCobro  int 
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE
----- 1. Declara
  @Empresa          VarChar(5),
  @Mov              VarChar(20),
  @MovId            VarChar(20),
  @FechaEmision     Datetime,
  @Concepto         VarChar(50),
  @UEN              int,
  @TipoCambio       float,
  @ClienteEnviarA   int,
  @Condicion        VarChar(50),
  @Vencimiento      Datetime,
  @ImporteVenta     float,
  @ImporteDocto     float,
  @ImporteCasca     float,
  @Impuestos        float,
  @Saldo            float,     
  @Referencia       varchar(50),
  @Documento1de     Int,
  @DocumentoTotal   Int, 
  @OrigenTipo       varchar(20),   
  @Origen           varchar(20),   
  @OrigenId         varchar(20),
  @Sucursal         int,
  @TipoSucursal     varchar(50),
  @ExtraeD          Int,
  @ExtraeA          Int,
  @IdVenta          int, 
  @MovIdVenta       varchar(20),
  @MovVenta         varchar(20),
  @LineaVta         varchar(50),
  @MaxDiasAtrazo    float,
  @DiasMenoresA       Int,
  @DiasMayoresA       Int,
------  	Factura AAA6 (12/13)
  @Id                int,
  @Bonificacion      varchar(50),
  @Estatus           varchar(15),
  @PorcBon1          float,
  @MontoBonif        Float, 
  @Financiamiento    float,
  @FechaIni          datetime,
  @FechaFin          datetime,
  @PagoTotal         bit,
  @ActVigencia       bit,
  @CascadaCalc       bit,
  @AplicaA           Char(30),
  @PlazoEjeFin       int, 
  @VAlBonif          Float,
  @VencimientoAntes  Int,
  @VencimientoDesp   Int,
  @DiasAtrazo        Int,
  @Factor            float,
  @MesesExced        int,
  @Linea             Float,
  @FechaCancelacion  datetime,
  @FechaRegistro     datetime,
  @Usuario           Varchar(10),
  @Ok                int, 
  @OkRef             Varchar(50),
  @Periodo           int,
  @CharReferencia    Varchar(20),
  @Ejercicio         Int,
  @BonificHijo       Varchar(50),
  @BonificHijoCascad Varchar(5),
  @Refinan           Varchar(5),
  @LineaCelulares    Float,
  @DiasVencimiento   int,
  @LineaCredilanas   Float,
  @BaseParaAplicar   Float
  ,@PadreMavi            varchar(20)  
  ,@PadreMaviID          varchar(20),
  @EsOrigenNulo		 int -- Variable bandera para identificar cuando Origen es Nulo, lo que indica saldo inicial GRB 24/07/10  
  ,@LineaMotos Float
  ,@LineaBonif VARCHAR(25)
----- 2. Inicializa
      SELECT @OkRef = '', @Ejercicio = year(getdate()), @Periodo = Month(getdate()), @MaxDiasAtrazo = 0.00, @Mov = '',@DiasMenoresA=0, @DiasMayoresA=0
      SELECT @CharReferencia= 0 , @ImporteVenta = 0.00, @ImporteDocto = 0.00, @MesesExced=0, @ImporteCasca = 0.00, @BaseParaAplicar = 0.00,@EsOrigenNulo=0
      IF @IdCobro = NULL SELECT @IdCobro= 0

----- 3. CargaCxC
-- Insertamos codigo para obtener MaxDiasVencidosMAVI de CXCMAVI GRB 23/07/10
  SELECT @Empresa=c.Empresa,@Mov=c.Mov,@MovId=c.MovId, @FechaEmision=c.FechaEmision,@Concepto=c.Concepto,@UEN=c.UEN,
    @TipoCambio=c.TipoCambio,@ClienteEnviarA=c.ClienteEnviarA,@Condicion=c.Condicion,@Vencimiento=c.Vencimiento,@ImporteDocto=c.Importe+c.Impuestos,
    @Impuestos=c.Impuestos,@Saldo=c.Saldo,@Vencimiento=c.Vencimiento,@Concepto=c.Concepto,@Referencia=isnull(c.ReferenciaMAvi,c.Referencia),
    @OrigenTipo=c.OrigenTipo,@Origen=c.Origen, @OrigenId=c.OrigenId,@Sucursal=c.SucursalOrigen,@MaxDiasAtrazo=isnull(cm.MaxDiasVencidosMAVI,0.00)
      ,@PadreMavi = c.PadreMAVI, @PadreMaviID = c.PadreIDMAVI
	FROM CXC c WITH(NOLOCK)
	LEFT JOIN CXCMAVI cm WITH(NOLOCK) on cm.id=c.id
	WHERE c.Id = @IdCxC

  IF @origen is null 
  begin 

-- Insertamos codigo para obtener MaxDiasVencidosMAVI de CXCMAVI GRB 23/07/10  	
      SELECT @Empresa=c.Empresa,@Mov=c.Mov,@MovId=c.MovId, @FechaEmision=c.FechaEmision,@Concepto=c.Concepto,@UEN=c.UEN,
        @TipoCambio=c.TipoCambio,@ClienteEnviarA=c.ClienteEnviarA,@Condicion=c.Condicion,@Vencimiento=c.Vencimiento,@ImporteDocto=c.Importe+c.Impuestos,
        @Impuestos=c.Impuestos,@Saldo=c.Saldo,@Vencimiento=c.Vencimiento,@Concepto=c.Concepto,@Referencia=isnull(c.ReferenciaMAvi,c.Referencia),
        @OrigenTipo=c.OrigenTipo,@Origen=c.Origen, @OrigenId=c.OrigenId,@Sucursal=c.SucursalOrigen,@MaxDiasAtrazo=isnull(cm.MaxDiasVencidosMAVI,0.00)
      FROM CXC c WITH(NOLOCK)
      LEFT JOIN CXCMAVI cm WITH(NOLOCK) on cm.id=c.id 
      WHERE c.Mov = @Mov AND c.Movid = @MovId
	
      Select @Origen = @Mov , @OrigenId = @MovId
      -- Indicamos que Origen es NULO GRB 24/07/10
      Select @EsOrigenNulo=1 

      SELECT top(1)@LineaVta = Linea, @ImporteVenta = PrecioToTal, @Sucursal = SucursalVenta
        FROM BonifSIMAVI WITH(NOLOCK) WHERE IDCxc = @idcxc
  end 
  
  DELETE MaviBonificacionTest WHERE Origen= @PadreMavi AND OrigenId = @PadreMaviID 
  
  --Se agrego el order by para regresar siempre el valor correcto. GRB 24/07/10
  IF @Referencia IS NULL OR rtrim(@Referencia)= '' OR NOT @Referencia LIKE '%/%'
  Begin 
--*** Se agrego orden para tomar el docto mas chico. JR 14-Nov-2011. ***
	 SELECT TOP (1) @Referencia=Referencia FROM Cxc WITH(NOLOCK) WHERE PadreMavi = @Mov AND PadreIDMAVI = @MovID and Mov = 'Documento' ORDER BY MovID  
   End
  IF patindex('%/%',@Referencia) > 0  
  BEGIN
    SELECT @ExtraeD = patindex('%(%',@Referencia), @ExtraeA = patindex('%/%',@Referencia)
	SELECT @Documento1de = substring(@Referencia,@ExtraeD+1,@ExtraeA - @ExtraeD -1) 
    SELECT @ExtraeD = patindex('%/%',@Referencia), @ExtraeA = patindex('%)%',@Referencia)
    SELECT @DocumentoTotal = substring(@Referencia,@ExtraeD+1,@ExtraeA - @ExtraeD -1)
  END
  
    --- Grales del documento
    ---LineadeVenta
      EXEC spMAviBuscaCxCVentaBonif @MovID,@Mov, @MovIdVenta output , @MovVenta output, @IdVenta output 
      
      ----  Saldos 
     if @importeventa is null 
      SELECT top(1)@LineaVta = Linea, @ImporteVenta = PrecioToTal, @Sucursal = SucursalVenta
        FROM BonifSIMAVI WITH(NOLOCK) WHERE IDCxc = @IdVenta

      IF @Mov LIKE '%Refinan%' SELECT @Refinan='Ok'
      
      IF @Refinan is NULL OR @LineaVta Is null 
      BEGIN 
        SELECT @LineaVta = isnull(A.Linea,'') FROM venta WITH(NOLOCK),ventad WITH(NOLOCK) 
          LEFT OUTER JOIN Art a WITH(NOLOCK) ON a.Articulo = ventad.Articulo
          WHERE venta.id = ventad.id 
          AND venta.id = @IdVenta 

        --- Importe de Venta y Sucursal
        IF @ImporteVenta IS NULL  or @ImporteVenta =0
          SELECT @ImporteVenta = PrecioToTal FROM Venta WITH(NOLOCK) WHERE Id = @IdVenta  
      END ELSE
      BEGIN  
      	 SELECT @Sucursal=39, @LineaVta = ''                         ---  Ventas Refinanciamiento I GArcia 29  Junio
      	 SELECT @ImporteVenta = Importe FROM Cxc WITH(NOLOCK) WHERE id = @IdVenta
      END

      ---Sucursal Tipo
        SELECT @TipoSucursal=SucursalTipo.Tipo FROM Sucursal WITH(NOLOCK), SucursalTipo WITH(NOLOCK) WHERE Sucursal.Tipo = SucursalTipo.Tipo 
          AND Sucursal.Sucursal=@Sucursal
     
----- 4. CargaBonificaciones Vigentes
--===========================================================================================================================================
      IF @Tipo = 'Total' 
      BEGIN 
          DECLARE CrBonifAplicar CURSOR FOR 
			  SELECT  mbc.Id,  mbc.Bonificacion,mbc.PorcBon1,mbc.Financiamiento, mbc.FechaIni,mbc.FechaFin,mbc.PagoTotal,mbc.ActVigencia
					 ,mbc.AplicaA,mbc.PlazoEjeFin,VencimientoAntes=isnull(mbc.VencimientoAntes,0),VencimientoDesp=isnull(mbc.VencimientoDesp,0)
					 ,DiasAtrazo=isnull(mbc.DiasAtrazo,0),DiasMenoresA=isnull(mbc.DiasMenoresA,0),DiasMayoresA=isnull(mbc.DiasMayoresA,0),
					  mbc.Factor,Linea=isnull(mbc.Linea,0.00),mbc.FechaCancelacion,mbc.FechaRegistro,mbc.Usuario,mbl.Linea 
			  FROM MaviBonificacionConf mbc WITH(NOLOCK)
			  INNER JOIN MaviBonificacionMoV mbmv WITH(NOLOCK) ON mbc.Id = mbmv.IdBonificacion
			  INNER JOIN dbo.MaviBonificacionCondicion mbc2 WITH(NOLOCK) ON mbc2.IdBonificacion=mbc.ID
			  LEFT JOIN dbo.MaviBonificacionLinea mbl WITH(NOLOCK) ON mbl.IdBonificacion=mbc.ID
			  WHERE mbmv.Movimiento = @Mov
			  AND COndicion = @Condicion
			  AND mbc.Estatus = 'CONCLUIDO'    ----- Quitar en Produccion
			  AND @FechaEmision BETWEEN mbc.FechaIni AND mbc.FechaFin
			  AND mbc.NoPuedeAplicarSola = 0
			  ORDER BY mbc.Orden DESC
			  
--===========================================================================================================================================
      END    
      ELSE
      BEGIN   
          DECLARE CrBonifAplicar CURSOR FOR 
          SELECT  mbc.Id,  mbc.Bonificacion,mbc.PorcBon1,mbc.Financiamiento, mbc.FechaIni,mbc.FechaFin,mbc.PagoTotal,mbc.ActVigencia,mbc.AplicaA,mbc.PlazoEjeFin,
                  isnull(mbc.VencimientoAntes,0), isnull(mbc.VencimientoDesp,0),
                  isnull(mbc.DiasAtrazo,0),isnull(mbc.DiasMenoresA,0),isnull(mbc.DiasMayoresA,0),
				  mbc.Factor,isnull(mbc.Linea,0.00),mbc.FechaCancelacion,mbc.FechaRegistro,mbc.Usuario,NULL
          FROM MaviBonificacionConf mbc WITH(NOLOCK)
          INNER JOIN MaviBonificacionMoV mbmv WITH(NOLOCK) ON mbc.Id = mbmv.IdBonificacion
          INNER JOIN dbo.MaviBonificacionCondicion mbc2 WITH(NOLOCK) ON mbc2.IdBonificacion=mbc.ID
          WHERE mbmv.Movimiento = @Mov
          AND COndicion = @Condicion
          AND mbc.Estatus = 'CONCLUIDO'    ----- Quitar en Produccion
          AND @FechaEmision BETWEEN mbc.FechaIni AND mbc.FechaFin
          AND mbc.NoPuedeAplicarSola = 0 
          AND NOT mbc.Bonificacion LIKE '%Contado Comercial%'
          ORDER BY mbc.Orden Desc
      END
    OPEN CrBonifAplicar
    FETCH NEXT FROM CrBonifAplicar INTO @Id, @Bonificacion,@PorcBon1,@Financiamiento,@FechaIni,@FechaFin,@PagoTotal,@ActVigencia,@AplicaA,@PlazoEjeFin, 
     @VencimientoAntes, @VencimientoDesp,@DiasAtrazo, @DiasMenoresA, @DiasMayoresA,
     @Factor,@Linea,@FechaCancelacion,@FechaRegistro,@Usuario,@LineaBonif
    WHILE @@FETCH_STATUS = 0
    BEGIN
    	    SELECT @Ok = NULL, @OkRef = NULL
------------------------------------------------------------------------------------------------------------------------------------------------------------
    	  DECLARE @LineaVentaBonif VARCHAR(50)
    	  
    	  SELECT TOP 1 @LineaVentaBonif = ISNULL(Linea,@LineaVta)
			FROM BonifSIMAVI WHERE IDCxc = @IdVenta AND Linea IN (SELECT mbl.Linea
							FROM MaviBonificacionConf mbc WITH(NOLOCK)
							INNER JOIN MaviBonificacionMoV mbmv WITH(NOLOCK) ON mbc.Id = mbmv.IdBonificacion
							INNER JOIN MaviBonificacionCondicion mbc2 WITH(NOLOCK) ON mbc2.IdBonificacion=mbc.ID
							LEFT JOIN MaviBonificacionLinea mbl WITH(NOLOCK) ON ID=mbl.IdBonificacion
							WHERE mbmv.Movimiento = @Mov
							AND COndicion = @Condicion
							AND mbc.Estatus = 'CONCLUIDO'
							AND @FechaEmision BETWEEN mbc.FechaIni AND mbc.FechaFin
							AND mbc.NoPuedeAplicarSola = 0
							AND Bonificacion LIKE '%Contado Comercial%')
    	  
    	  SELECT @LineaVentaBonif = ISNULL(A.Linea,@LineaVta) FROM venta,ventad 
          LEFT OUTER JOIN Art a ON a.Articulo = ventad.Articulo
          WHERE venta.id = ventad.id 
          AND venta.id = @IdVenta 
          AND A.Linea IN (SELECT mbl.Linea
							FROM MaviBonificacionConf mbc WITH(NOLOCK)
							INNER JOIN MaviBonificacionMoV mbmv WITH(NOLOCK) ON mbc.Id = mbmv.IdBonificacion
							INNER JOIN MaviBonificacionCondicion mbc2 WITH(NOLOCK) ON mbc2.IdBonificacion=mbc.ID
							LEFT JOIN MaviBonificacionLinea mbl WITH(NOLOCK) ON ID=mbl.IdBonificacion
							WHERE mbmv.Movimiento = @Mov
							AND COndicion = @Condicion
							AND mbc.Estatus = 'CONCLUIDO'
							AND @FechaEmision BETWEEN mbc.FechaIni AND mbc.FechaFin
							AND mbc.NoPuedeAplicarSola = 0
							AND Bonificacion LIKE '%Contado Comercial%')
    	  SELECT @LineaVentaBonif = ISNULL(@LineaVentaBonif,@LineaVta)
    	  SELECT @LineaVta=@LineaVentaBonif
    	  
    	  IF @LineaVentaBonif IN (SELECT mbl.Linea
							FROM MaviBonificacionConf mbc WITH(NOLOCK)
							INNER JOIN MaviBonificacionMoV mbmv WITH(NOLOCK) ON mbc.Id = mbmv.IdBonificacion
							INNER JOIN MaviBonificacionCondicion mbc2 WITH(NOLOCK) ON mbc2.IdBonificacion=mbc.ID
							LEFT JOIN MaviBonificacionLinea mbl WITH(NOLOCK) ON ID=mbl.IdBonificacion
							WHERE mbmv.Movimiento = @Mov
							AND COndicion = @Condicion
							AND mbc.Estatus = 'CONCLUIDO'
							AND @FechaEmision BETWEEN mbc.FechaIni AND mbc.FechaFin
							AND mbc.NoPuedeAplicarSola = 0
							AND Bonificacion LIKE '%Contado Comercial%') AND @Bonificacion LIKE '%Contado Comercial%'
			BEGIN
				IF ISNULL(@LineaBonif,'')<>'' AND ISNULL(@LineaVentaBonif,'')<>'' AND @Bonificacion LIKE '%Contado Comercial%'
    			BEGIN
    				IF @LineaBonif = @LineaVentaBonif
    					SELECT @Ok = NULL, @OkRef = NULL
    			END
    			ELSE SELECT @Ok = 1, @OkRef = 'No cumple con el parametro linea para esta bonificacion'
			END
    	  ELSE IF ISNULL(@LineaBonif,'')='' AND ISNULL(@LineaVentaBonif,'')<>'' AND @Bonificacion LIKE '%Contado Comercial%' 
    		BEGIN
    			IF EXISTS(SELECT Bonificacion FROM dbo.MaviBonificacionTest WITH(NOLOCK) WHERE Bonificacion=@Bonificacion AND Ok=0 AND IdCobro=@IdCobro)
    				SELECT @Ok = 1, @OkRef = 'No cumple con el parametro de la linea para esta bonificacion'
    			ELSE
    				SELECT @Ok = NULL, @OkRef = NULL
    		END
    		ELSE IF @Bonificacion LIKE '%Contado Comercial%' 
    			SELECT @Ok = 1, @OkRef = 'No cumple con el parametro de la linea para esta bonificacion'

		  SELECT @LineaBonif=''
		  
		  IF @Bonificacion LIKE '%Adelanto%' AND @LineaVta<>@LineaBonif AND @Tipo = 'Total'
			 AND EXISTS (SELECT * FROM MaviBonificacionTest WITH(NOLOCK) WHERE IdCobro=@IdCobro AND Ok=0 AND Bonificacion=@Bonificacion)
				SELECT @Ok = 1, @OkRef = 'No cumple con el parametro de la linea para esta bonificacion'
				
------------------------------------------------------------------------------------------------------------------------------------------------------------
		  IF @Tipo = 'Total' AND @Bonificacion NOT LIKE '%Adelanto%' 
			 AND EXISTS (SELECT IdBonificacion FROM MaviBonificacionExcluye WITH(NOLOCK) WHERE BonificacionNo=@Bonificacion 
					        AND IdBonificacion IN (
					        SELECT ID FROM (
								SELECT mbc.ID
										,Ok=CASE WHEN @EsOrigenNulo = 0 
											THEN
												CASE WHEN dbo.fnFechaSinHora(GETDATE()) >= dbo.fnFechaSinHora((Select c.Vencimiento+1 FROM Cxc c WHERE c.Origen = @Origen AND c.OrigenID = @OrigenId AND c.Referencia LIKE '%' + '(' + rtrim(mbc.VencimientoAntes) + '/' + rtrim(@DocumentoTotal) + '%'))
													 THEN 1 ELSE 0 END
											ELSE 
												CASE WHEN dbo.fnFechaSinHora(GETDATE()) > dbo.fnFechaSinHora(ISNULL((Select c.Vencimiento FROM Cxc c WITH(NOLOCK) WHERE c.Origen = @Origen AND c.OrigenID = @OrigenId 
																								AND c.Referencia LIKE '%' + '(' + rtrim(mbc.VencimientoAntes) + '/' + rtrim(@DocumentoTotal) + '%'), 
																							(CASE WHEN mbc.VencimientoAntes=1 THEN @Vencimiento 
																								 WHEN mbc.VencimientoAntes>1 THEN  DATEADD(mm, (mbc.VencimientoAntes - @Documento1de), (SELECT Vencimiento FROM CxC WITH(NOLOCK) WHERE Origen=@Origen AND OrigenID=@OrigenId AND Referencia=@Referencia) ) END ) )   ) 
												 THEN 1 ELSE 0 END
										END,
										DiasAtrazo=CASE WHEN @MaxDiasAtrazo > mbc.DiasAtrazo AND mbc.DiasAtrazo <> 0 THEN 1 ELSE 0 END,
										DiasMenoresA=CASE WHEN @Condicion LIKE '%PP%' AND mbc.DiasMenoresA <> 0 THEN 
															CASE WHEN mbc.DiasMenoresA < datediff(day,@FechaEmision,getdate()) THEN 1 ELSE 0 END
														  WHEN @Condicion LIKE '%DIF%' AND mbc.DiasMenoresA <> 0 THEN
															CASE WHEN mbc.DiasMenoresA < DATEDIFF(DAY, @FechaEmision, getdate()) THEN 1 ELSE 0 END
													 ELSE 0 END,
										DiasMayoresA=CASE WHEN @Condicion LIKE '%PP%' AND mbc.DiasMayoresA <> 0 THEN
															CASE WHEN mbc.DiasMayoresA >= datediff(dd,@FechaEmision,@Vencimiento) THEN 1 ELSE 0 END
														  WHEN @Condicion LIKE '%DIF%' AND mbc.DiasMayoresA <> 0 THEN
															CASE WHEN mbc.DiasMayoresA <= DATEDIFF(DAY, @FechaEmision, getdate()) THEN 1 ELSE 0 END
													 ELSE 0 END
								FROM MaviBonificacionConf mbc WITH(NOLOCK)
									INNER JOIN MaviBonificacionMoV mbmv WITH(NOLOCK) ON mbc.Id = mbmv.IdBonificacion
									INNER JOIN MaviBonificacionCondicion mbc2 WITH(NOLOCK) ON mbc2.IdBonificacion=mbc.ID
									LEFT JOIN MaviBonificacionLinea mbl WITH(NOLOCK) ON ID=mbl.IdBonificacion
								WHERE mbmv.Movimiento = @Mov
									AND COndicion = @Condicion
									AND mbc.Estatus = 'CONCLUIDO'
									AND @FechaEmision BETWEEN mbc.FechaIni AND mbc.FechaFin
									AND mbc.NoPuedeAplicarSola = 0
									AND Bonificacion = 'Bonificacion Contado Comercial'
							)Cont WHERE Ok = 0 AND DiasAtrazo = 0 AND DiasMenoresA = 0 AND DiasMayoresA = 0 ) ) 
					SELECT @Ok = 1, @OkRef = 'Se excluye esta bonificacion por otra'

------------------------------------------------------------------------------------------------------------------------------------------------------------
    			
          IF @VencimientoAntes <> 0 AND @Bonificacion not LIKE '%Adelanto%' AND @Tipo = 'Total'
          BEGIN   
            SET @CharReferencia = '(' + rtrim(@VencimientoAntes) + '/' + rtrim(@DocumentoTotal)
            IF @EsOrigenNulo=0
            Begin                                 
				IF dbo.fnFechaSinHora(GETDATE())  >=  dbo.fnFechaSinHora((Select c.Vencimiento+1 FROM Cxc c WITH(NOLOCK) WHERE c.Origen = @Origen AND c.OrigenID = @OrigenId AND c.Referencia LIKE '%' + @CharReferencia + '%'))  
					SELECT @Ok=1, @OkRef = 'No cumple con el límite de pago posterior1'
			END		
			ELSE
			Begin
				-- **** Modificacion de validacion para que considere el vencimiento antes del no. docto establecido en la config. JR 14-Nov-2011 ****
				IF ( dbo.fnFechaSinHora(getdate()) > dbo.fnFechaSinHora(ISNULL((Select c.Vencimiento FROM Cxc c WITH(NOLOCK) WHERE c.Origen = @Origen AND c.OrigenID = @OrigenId 
																					AND c.Referencia LIKE '%' + @CharReferencia + '%'), 
																				(CASE WHEN @VencimientoAntes=1 THEN @Vencimiento 
																					 WHEN @VencimientoAntes>1 THEN  DATEADD(mm, (@VencimientoAntes - @Documento1de), (SELECT Vencimiento FROM CxC WITH(NOLOCK) WHERE Origen=@Origen AND OrigenID=@OrigenId AND Referencia=@Referencia) ) END ) )   ) ) 
					SELECT @Ok=1, @OkRef = 'No cumple con el límite de pago posterior1'    
            END
            
          END  
          IF @VencimientoAntes <> 0 AND @Bonificacion LIKE '%Adelanto%' AND @Tipo = 'Total'
          BEGIN    
            SET @CharReferencia = '(' + rtrim(@VencimientoAntes) + '/' + rtrim(@DocumentoTotal)                 
            IF dbo.fnFechaSinHora(GETDATE())  >=  dbo.fnFechaSinHora((Select c.Vencimiento + 1 FROM Cxc c WHERE c.Origen = @Origen AND c.OrigenID = @OrigenId AND c.Referencia LIKE '%' + @CharReferencia + '%'))  
                SELECT @Ok=1, @OkRef = 'No cumple con el límite de pago posterior1'    
            
          END  

          -- **** Nueva validacion para que genere bonificacion x adelanto si ha pasado el no. de docto especificado en vencimientodesp en la config. JR 14-Nov-2011 ****
          IF @VencimientoDesp <> 0 AND @Bonificacion LIKE '%Adelanto%' AND @Tipo = 'Total'
          BEGIN    
            SET @CharReferencia = '(' + rtrim(@VencimientoDesp) + '/' + rtrim(@DocumentoTotal)                 
            IF (dbo.fnFechaSinHora(GETDATE()) <=  
				dbo.fnFechaSinHora(ISNULL((Select c.Vencimiento FROM Cxc c WITH(NOLOCK) WHERE c.Origen = @Origen AND c.OrigenID = @OrigenId 
												AND c.Referencia LIKE '%' + @CharReferencia + '%'), 
											(CASE WHEN @VencimientoDesp=1 THEN @Vencimiento 
												 WHEN @VencimientoDesp>1 THEN  DATEADD(mm, (@VencimientoDesp - @Documento1de), (SELECT Vencimiento FROM CxC WITH(NOLOCK) WHERE Origen=@Origen AND OrigenID=@OrigenId AND Referencia=@Referencia) ) END ) )   ) ) 
                SELECT @Ok=1, @OkRef = 'No cumple con el límite de pago posterior1'    
            
          END  

          -- 5.2 Dias Atrazo  
          IF @DiasAtrazo <> 0 AND @Bonificacion LIKE '%Contado Comercial%'
          BEGIN
            IF @MaxDiasAtrazo > @DiasAtrazo SELECT @Ok=1, @OkRef = 'Excede el número de dias de atraso permitidos ' 	 
          END

           ---5.3 Dias de ADelanto   --- Pronto Pago 
          IF @DiasMenoresA <> 0 AND @Bonificacion LIKE '%Contado Comercial%' AND @Condicion LIKE '%PP%'
          BEGIN
          -- Modificamos validacion para opcion PP
			IF @DiasMenoresA < datediff(day,@FechaEmision,getdate()) SELECT @Ok=1, @OkRef = 'Excede días menores' 

          END
          -- 5.3 Dias de Mayores
          IF @DiasMayoresA <> 0 AND @Bonificacion LIKE '%Contado Comercial%' AND @Condicion LIKE '%PP%'
          BEGIN
            IF @DiasMayoresA >= datediff(dd,@FechaEmision,@Vencimiento) SELECT @Ok=1, @OkRef = 'Excede dias mayores' 
          END

           ----5.3 Dias de ADelanto   --- Pronto Pago 
          IF @DiasMenoresA <> 0 AND @Bonificacion LIKE '%Contado Comercial%' AND @Condicion LIKE '%DIF%'
          BEGIN
				IF @DiasMenoresA < DATEDIFF(DAY, @FechaEmision, getdate() )
          	      SELECT @Ok=1, @OkRef = 'Excede días menores'  + CONVERT (char(30),@DiasMenoresA)				
          END
           ----5.3 Dias de Mayores
          IF @DiasMayoresA <> 0 AND @Bonificacion LIKE '%Contado Comercial%' AND @Condicion LIKE '%DIF%'
          BEGIN
          	IF getdate() >= (@FechaEmision + @DiasMayoresA)
          	      SELECT @Ok=1, @OkRef = 'Excede días mayores'  + CONVERT (char(30),@DiasMayoresA)
          END

          -- 5.3 Dias de ADelanto

                    ------   Test5
          --- 6.1 Lineas Art
           IF @PorcBon1 = 0 AND @Linea <> 0 SELECT @PorcBon1 = @Linea
            IF @Linea < (SELECT isnull(PorcLin,0.00) FROM MaviBonificacionLinea WITH(NOLOCK) WHERE IdBonificacion=@id AND Linea = @LineaVta) 
                SELECT @Linea = (SELECT isnull(PorcLin,0.00) FROM MaviBonificacionLinea WITH(NOLOCK) WHERE IdBonificacion=@id AND Linea = @LineaVta) 

            SELECT @LineaCelulares=isnull(PorcLin,0.00) FROM MaviBonificacionLinea mbl WITH(NOLOCK) WHERE Linea LIKE '%Credilana%' AND IdBonificacion = @Id
            SELECT @LineaCredilanas=isnull(PorcLin,0.00) FROM MaviBonificacionLinea mbl WITH(NOLOCK) WHERE Linea LIKE '%Celular%' AND IdBonificacion = @Id
            --Je.deltoro--
            SELECT @LineaMotos=isnull(PorcLin,0.00) FROM MaviBonificacionLinea mbl WITH(NOLOCK)
            INNER JOIN MaviBonificacionCondicion Mbc WITH(NOLOCK) ON Mbc.IdBonificacion=mbl.IdBonificacion
			WHERE Mbc.COndicion=@Condicion AND @Bonificacion LIKE '%Contado Comercial%'
				  AND Mbl.IdBonificacion = @Id AND Linea=@LineaBonif
            
          --- 6.2 Canal Ventas
            IF EXISTS(SELECT IdBonificacion FROM MaviBonificacionCanalVta BonCan WITH(NOLOCK) WHERE BonCan.IdBonificacion=@id)
            BEGIN  
              IF NOT EXISTS(SELECT IdBonificacion FROM MaviBonificacionCanalVta BonCan WITH(NOLOCK) WHERE CONVERT(varchar(10),BonCan.CanalVenta)=@ClienteEnviarA AND BonCan.IdBonificacion=@id)
                 SELECT @Ok=1, @OkRef = 'Venta de Canal No Configurada Para esta Bonificación'             
            END 
          --- 6.3 UEN's
            IF EXISTS(SELECT IdBonificacion FROM MaviBonificacionUEN mbu WITH(NOLOCK) WHERE mbu.idBonificacion=@Id)
            BEGIN  
              IF NOT @UEN is NULL AND NOT EXISTS(SELECT IdBonificacion FROM MaviBonificacionUEN mbu WITH(NOLOCK) WHERE mbu.UEN = @UEN AND mbu.idBonificacion=@Id)
                 SELECT @Ok=1, @OkRef = 'UEN No Configurada Para este Caso' 
            END
          --- 6.4 Condicion
            IF EXISTS(SELECT IdBonificacion FROM MaviBonificacionCondicion WITH(NOLOCK) WHERE IdBonificacion=@Id)
            BEGIN              
              IF NOT EXISTS(SELECT IdBonificacion FROM MaviBonificacionCondicion WITH(NOLOCK) WHERE COndicion=@Condicion AND IdBonificacion=@Id)
                 SELECT @Ok=1, @OkRef = 'Condicion No Configurada Para esta Bonificación' 
            END
          --- 6.5 Bonif Exclu
            IF EXISTS(SELECT IdBonificacion FROM MaviBonificacionExcluye Exc WITH(NOLOCK) WHERE BonificacionNo=@Bonificacion)
            BEGIN              
              IF EXISTS(SELECT BonTest.IdBonificacion FROM MaviBonificacionTest BonTest WITH(NOLOCK), MaviBonificacionExcluye Exc WITH(NOLOCK)
                WHERE Bontest.IdBonificacion = Exc.IdBonificacion
                AND Bontest.OkRef = '' AND Exc.BonificacionNo=@Bonificacion AND BonTest.IdCobro = @IdCobro
				AND BonTest.MontoBonif > 0 AND BonTest.Origen = @Mov AND BonTest.OrigenId = @MovId  
				) 
                SELECT @Ok=1, @OkRef = 'Excluye esta Bonificacion Una anterior ' 
            END
          --- 6.6 Sucursal

            IF NOT @TipoSucursal IS NULL AND NOT EXISTS(SELECT IdBonificacion FROM MaviBonificacionSucursal WITH(NOLOCK) WHERE Sucursal=rtrim(@TipoSucursal) AND idBonificacion=rtrim(@Id))
                             SELECT @Ok=1, @OkRef = 'Bonificación No Configurada Para este tipo de Sucursal' 
           
              IF NOT EXISTS(SELECT IdBonificacion FROM MaviBonificacionTest WITH(NOLOCK) WHERE idBonificacion=rtrim(@Id) AND Docto = @IdCxC )
              BEGIN 
              ----  Calcula Valor 
                    
                    SELECT @MesesExced = isnull(@DocumentoTotal,0) -  isnull(@PlazoEjeFin,0) 
                    SELECT @Factor = 1 + (@MesesExced * (isnull(@Financiamiento,0.00)/100))
                    SELECT @BaseParaAplicar = isnull(@ImporteVenta / @Factor,0.00)

                    IF @AplicaA = 'Importe de Factura'  
                      BEGIN 
         	IF @Linea <> 0 SELECT @PorcBon1=@Linea
                      	IF @LineaCelulares <> 0  AND @Bonificacion NOT LIKE '%Contado%'  AND @Bonificacion NOT LIKE '%Atraso%'  SELECT @PorcBon1=isnull(@LineaCelulares,0.00)
                      	IF @LineaCredilanas <> 0 AND @Bonificacion NOT LIKE '%Contado%' AND @Bonificacion NOT LIKE '%Atraso%'  SELECT @PorcBon1=isnull(@LineaCredilanas,0.00)
                      	--Je.deltoro
                      	IF @Bonificacion LIKE '%Contado%' SELECT @PorcBon1=ISNULL(@LineaMotos,@PorcBon1)
                      	SELECT @MontoBonif = (@PorcBon1/100) * (@ImporteVenta / @Factor) ------ Importe Sobre el Plaxo Eje
                      END 
                    IF @AplicaA <> 'Importe de Factura' SELECT @MontoBonif = (@PorcBon1/100) * @ImporteDocto


               	    ------  Cambio del 29 de Sept ContadoComercial
                IF @Bonificacion LIKE '%Contado Comercial%' AND @Ok IS NULL
                BEGIN
                	SELECT @MontoBonif = @ImporteVenta - ((@ImporteVenta / @Factor)-@MontoBonif)
                END

                IF NOT @Ok is NULL SELECT @MontoBonif = 0.00,@PorcBon1 = 0.00    ---- Pone en Ceros los que no aplica
                IF @Bonificacion LIKE '%Adelanto%' AND dbo.fnFechaSinHora(GETDATE()) = dbo.fnFechaSinHora(@Vencimiento) SELECT @MontoBonif = 0.00 , @PorcBon1 = 0.00

------------------------------------------------------------------------------------------------------------------------------------------------------------
				IF @Bonificacion LIKE '%Contado Comercial%' AND @Ok IS NULL
					SELECT @MontoBonif=ISNULL(@MontoBonif,0)-Bonif FROM (
						SELECT CMov.Mov,CMov.MovID,Bonif=ISNULL(SUM(cd.Importe),0) FROM Cxc CMov WITH(NOLOCK)
						INNER JOIN Cxc Ccte WITH(NOLOCK) ON Ccte.Cliente=CMov.Cliente AND Ccte.Mov='Nota Credito' AND Ccte.Estatus='CONCLUIDO'
						INNER JOIN Cxc CBonif WITH(NOLOCK) ON Ccte.ID=CBonif.ID
						INNER JOIN CxcD cd WITH(NOLOCK) ON CBonif.ID = cd.ID
						INNER JOIN Cxc CPadre WITH(NOLOCK) ON CPadre.Mov=cd.Aplica AND CPadre.MovID=cd.AplicaID AND CPadre.PadreMAVI=CMov.Mov AND CPadre.PadreIDMAVI=CMov.MovID
						WHERE Ccte.Concepto LIKE '%PAGO PUNTUAL%' AND CMov.Mov=@Mov AND CMov.MovID=@MovId
						GROUP BY CMov.Mov,CMov.MovID
					)Resta
------------------------------------------------------------------------------------------------------------------------------------------------------------

                IF @Bonificacion LIKE '%Contado Comercial%'
                BEGIN   
                INSERT MaviBonificacionTest (idBonificacion,IdCoBro,Docto, Bonificacion,    Estacion, Documento1de,DocumentoTotal,Mov, 
                        MovId, Origen,OrigenId, ImporteDocto,ImporteVenta, MontoBonif, TipoSucursal,LineaVta,IdVenta,UEN,Condicion,PorcBon1,Financiamiento, Ok,OkRef, Factor,Sucursal1,PlazoEjeFin, FechaEmision, Vencimiento, LineaCelulares, LineaCredilanas,DiasMenoresA,DiasMayoresA,BaseParaAplicar)
                                    VALUES(@Id ,@IdCobro,@IdCxC,isnull(@Bonificacion,''), @Estacion, isnull(@Documento1de,0),isnull(@DocumentoTotal,0),isnull(@Mov,''),
                                    isnull(@MovId,''),isnull(@Origen,''),isnull(@OrigenId,''), round(isnull(@ImporteDocto,0.00),2), round(isnull(@ImporteVenta,0.00),2), 
                                    round(isnull(@MontoBonif,0.00),2) , isnull(@TipoSucursal,''),isnull(@LineaVta,''),isnull(@IdVenta,0),isnull(@UEN,0),isnull(@Condicion,''),isnull(@PorcBon1,0.00), isnull(@Financiamiento,0.00), isnull(@Ok,0),isnull(@OkRef,''),isnull(@Factor,0.00),@Sucursal,@PlazoEjeFin,@FechaEmision,@Vencimiento, isnull(@LineaCelulares,0.00), isnull(@LineaCredilanas,0.0),@DiasMenoresA,@DiasMayoresA,round(isnull(@BaseParaAplicar,0.00),2))
                END                                    
              END                                  
            
			IF (@Ok is NULL AND EXISTS(SELECT IdBonificacion FROM MaviBonificacionIncluye Exc WITH(NOLOCK) WHERE Exc.IdBonificacion=@Id) 
			AND EXISTS (Select Movimiento from MaviBonificacionMoV WITH(NOLOCK) WHERE Movimiento =  @Mov AND IdBonificacion in 
			(Select id from MaviBonificacionConf where Bonificacion like '%Atraso%' ))) OR
			(@Ok is NULL AND @Tipo = 'Total' AND NOT @Bonificacion LIKE '%Contado Comercial%') OR
			(@Ok is NULL AND @Tipo = 'Total' AND NOT @Bonificacion LIKE '%Adelanto%') OR
			(@Ok is NULL AND @Tipo <> 'Total' AND NOT @Bonificacion LIKE '%Contado Comercial%') 
			BEGIN
			IF (@Ok is NULL AND EXISTS(SELECT IdBonificacion FROM MaviBonificacionIncluye Exc WITH(NOLOCK) WHERE Exc.IdBonificacion=@Id)
			AND EXISTS (Select Movimiento from MaviBonificacionMoV WITH(NOLOCK) WHERE Movimiento =  @Mov AND IdBonificacion in 
			(Select id from MaviBonificacionConf where Bonificacion like '%Atraso%' ))) 
---
              	  BEGIN 
          
                   DECLARE crVerificaDetalle CURSOR FOR 
                    SELECT BonificacionNo,EnCascada
                      FROM MaviBonificacionIncluye WHERE IdBonificacion = @Id
                      Order BY Orden 
                    OPEN crVerificaDetalle
                    FETCH NEXT FROM crVerificaDetalle INTO @BonificHijo, @BonificHijoCascad
                    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
                    BEGIN
                      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
                      BEGIN
                      	 IF rtrim(@BonificHijo) like '%Atraso%' AND @Bonificacion LIKE  '%Adelanto%'   SELECT @BaseParaAPlicar = @ImporteVenta
                      	 IF rtrim(@BonificHijo) like '%Atraso%' AND @Bonificacion LIKE  '%Comercial%'   SELECT @BaseParaAPlicar = @ImporteVenta * (@PorcBon1/100)

                         EXEC spBonificacionDocRestantes @BonificHijo,@BonificHijoCascad, @PadreMavi, @PadreMaviID ,@Idventa , @lineaVta,  
                              @Sucursal , @TipoSucursal, @Estacion ,@Uen,@Condicion, @ImporteVenta, @Tipo, @IdCxC, @IdCobro,@MaxDiasAtrazo, @Id,@Bonificacion,@BaseParaAPlicar, 'Incluye', @MontoBonif, @FechaEmision
                      END
                      FETCH NEXT FROM crVerificaDetalle INTO @BonificHijo, @BonificHijoCascad
                    END
                    CLOSE crVerificaDetalle
                    DEALLOCATE crVerificaDetalle	 
         
              	  END

              	  ------  Recorrido de los pendientes
              	  IF (@Ok is NULL AND @Tipo = 'Total' AND NOT @Bonificacion LIKE '%Contado Comercial%') OR
              	     (@Ok is NULL AND @Tipo <> 'Total' AND NOT @Bonificacion LIKE '%Contado Comercial%') 
              	  BEGIN             	               	  	    

			             EXEC spBonificacionDocRestantes @Bonificacion,'No', @PadreMavi, @PadreMaviId ,@Idventa , @lineaVta,
                              @Sucursal , @TipoSucursal, @Estacion ,@Uen,@Condicion, @ImporteVenta, @Tipo, @IdCxC,@IdCobro, @MaxDiasAtrazo, @Id, @Bonificacion, @BaseParaAPlicar, '', @MontoBonif, @FechaEmision
              	  END
              	  -------------------------Pasar aqui comprobando 
              	  
              	  ----  Fin recorrido
              END 
         
    FETCH NEXT FROM CrBonifAplicar INTO @Id, @Bonificacion,@PorcBon1,@Financiamiento,@FechaIni,@FechaFin,@PagoTotal,@ActVigencia,@AplicaA,@PlazoEjeFin, 
     @VencimientoAntes, @VencimientoDesp,@DiasAtrazo, @DiasMenoresA, @DiasMayoresA,
     @Factor,@Linea,@FechaCancelacion,@FechaRegistro,@Usuario,@LineaBonif
    END
    CLOSE CrBonifAplicar
    DEALLOCATE CrBonifAplicar
END
GO


/************************ spBonifMonto *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spBonifMonto') AND type = 'P') DROP PROCEDURE dbo.spBonifMonto
GO
CREATE PROCEDURE [dbo].[spBonifMonto]  
 @IdCobro   Int    
--//WITH ENCRYPTION   
AS BEGIN  -- 1  
  DECLARE  
   @IdCxC             Int,  
   @Clave           char(20),  
   @Origen            varchar(20),  
   @OrigenId          varchar(20),  
   @Docto             int,   
   @Bonificacion      Varchar(50),  
   @IdBonificacion    int,  
   @Monto             Float,  
   @PorcBon1          Float,  
   @PagoPuntual       Money,   
   @AdelantoPagos     Money,   
   @NoAtraso          Money,  
   @ParteContComercial Money,   
   @ContadoComercial  Money,  
   @PagoPuntualId       Int,   
   @AdelantoPagosId     int,   
   @NoAtrasoId          Int,   
   @ContadoComercialId  Int,  
   @NvoPorc           float,   
   @MovNvo            varchar(20),  
   @MovIdNvo          varchar(20),  
   @Ok            Int,  
   @Tictac            int,  
   @Tipo              Varchar(20),  
   @Mov               Varchar(20),
   @MovId             Varchar(20),
   @NoMdeNoAtraso     int,  
   @AdelantoDocto     int,  
   @MontoBonMov       float,  
   @CuentaMov         float,  
   @BaseCalculo       float,
   @LineaVenta        VARCHAR(50),
   @CuentaMovBase		FLOAT,
   @DocumentoTotal		INT,
   @MesesAdelanto		INT 
     
  SELECT @ParteContComercial = 0.00  , @CuentaMov= 0.00,@BaseCalculo = 0.00   
  -----  Borra PRobables Datos viejos almacenados - a Fuerza Bruta !!  
  DELETE MaviBonificacionTest WHERE IdCobro = @IdCobro  
  
  DECLARE CrNegociaBonif CURSOR FAST_FORWARD FOR   
    SELECT Distinct(Origen), OrigenId  
      FROM NegociaMoratoriosMAVI WITH(NOLOCK) WHERE IDCobro = @IDCobro   
                  
   OPEN CrNegociaBonif  
   FETCH NEXT FROM CrNegociaBonif INTO @Origen, @OrigenId  
   WHILE @@FETCH_STATUS = 0  
   BEGIN  -- 2  
  
    SELECT TOP(1) @mov = Mov, @MovId= MovID, @Tipo = ISNULL(TipoPago,'NA'), @Origen =Origen, @OrigenId = OrigenId    
      FROM NegociaMoratoriosMAVI WITH(NOLOCK) WHERE IDCobro = @IDCobro  AND Mov = @Mov  
     ORDER BY ID desc -- Ojo Revisar el orden 170609 01:33 am  

 --- va por todos  
 IF EXISTS(SELECT ID FROM NegociaMoratoriosMAVI WITH(NOLOCK) WHERE IDCobro = @IDCobro  And TipoPago IN ('T', 'Total') AND Origen= @Origen)  
  SELECT @Tipo = 'T'     
    
     IF @Tipo = 'T' SELECT @Tipo = 'Total'  
     SELECT @Clave = Clave FROM Movtipo WITH(NOLOCK) WHERE Mov = @Mov AND Modulo = 'CXC'  
    IF @Origen IS NULL OR @Origen = ''   
		SELECT  @Origen = PadreMAVI, @OrigenId = PadreIDMAVI FROM Cxc WITH(NOLOCK)
		WHERE Mov = @Mov AND MovId = @Movid       
    
    SELECT @IdCxC = id FROM Cxc WITH(NOLOCK) WHERE Mov = @Origen AND MovId = @OrigenId  
	
    EXEC spBonificacionesCalculaTabla @IdCxC, 1, @Tipo , @IdCobro  

    -- Revisa el Resultado del calulo de Bonificaciones  
     IF EXISTS (SELECT IdCobro FROM MaviBonificacionTest mbt WITH(NOLOCK) WHERE mbt.Origen = @Origen AND mbt.OrigenId = @OrigenId)  
    BEGIN  -- 4  
         DECLARE CrCxCBonif CURSOR FAST_FORWARD FOR   
          SELECT Docto,Bonificacion, montoBonif, Mov, Movid, IdBonificacion,PorcBon1   
            FROM MaviBonificacionTest WITH(NOLOCK)
           WHERE Origen = @Origen AND OrigenID = @OrigenId  
				AND IDCobro = @IDCobro -- yani  
				AND MontoBonif > 0   
      ORDER BY IdBonificacion  
  
         OPEN CrCxCBonif  
         FETCH NEXT FROM CrCxCBonif INTO @Docto, @Bonificacion,@Monto, @MovNvo, @MovIdNvo, @IdBonificacion, @PorcBon1  
         WHILE @@FETCH_STATUS = 0  
         BEGIN  -- 5  
        
           SELECT @PagoPuntual = 0.00, @AdelantoPagos = 0.00 , @NoAtraso = 0.00 , @ContadoComercial = 0.00   
           SELECT @PagoPuntualId = Null, @AdelantoPagosId = Null, @NoAtrasoId = Null, @ContadoComercialId = Null   
				
           IF @Bonificacion LIKE '%Pago Puntual%' SELECT @PagoPuntual = Round(@Monto,2), @PagoPuntualId = @IdBonificacion  
           IF @Bonificacion LIKE '%Adelanto%' SELECT @AdelantoPagos = Round(@Monto,2), @AdelantoPagosId = @IdBonificacion  
           IF @Bonificacion LIKE '%Atraso%' SELECT @NoAtraso = Round(@Monto,2), @NoAtrasoId = @IdBonificacion  
           IF @Bonificacion LIKE '%Contado Comercial%' SELECT @ContadoComercial = Round(@Monto,2), @ContadoComercialId = @IdBonificacion  
  
            IF EXISTS(SELECT ID FROM NegociaMoratoriosMAVI WITH(NOLOCK) WHERE Mov = @MovNvo AND Movid = @MovIdNvo AND idCobro = @IdCobro AND Origen = @Origen  
            AND ImporteReal=ImporteAPagar AND NOT @Bonificacion LIKE '%Comercial%' AND NOT @Bonificacion LIKE '%Atraso%' 
            AND NOT @Bonificacion LIKE '%Adelanto%' AND NOT @Bonificacion LIKE '%Puntual%' )  
              BEGIN      
               ------ Si esta Actualizas     
                 UPDATE NegociaMoratoriosMAVI SET Bonificacion = round(isnull(Bonificacion,0.00),2) + Round(@Monto,2),   
                     PagoPuntual=round(isnull(@PagoPuntual,0.00),2),AdelantoPagos=round(isnull(@AdelantoPagos,0.00),2),  
                     IdPagoPuntual=@PagoPuntualId,IdAdelantoPagos=@AdelantoPagosId  
                  WHERE Mov = @MovNvo AND MovID = @MovIdNvo  
                    AND IdCobro = @IdCobro AND Origen = @Origen AND Origenid = @OrigenId  
               END  

              ELSE IF @Bonificacion LIKE '%Comercial%' OR @Bonificacion LIKE '%Atraso%' OR  @Bonificacion LIKE '%Adelanto%'  OR  @Bonificacion LIKE '%Puntual%' ----***  
              BEGIN                

                IF @Bonificacion LIKE '%PUNTUAL%' AND EXISTS(SELECT ID FROM NegociaMoratoriosMAVI WITH(NOLOCK) WHERE Mov = @MovNvo AND Movid = @MovIdNvo AND idCobro = @IdCobro AND Origen = @Origen  
												  AND ImporteReal=ImporteAPagar) 
                Begin  
                	----pzamudio calculo de la base 27-May-2010
                  SELECT @DocumentoTotal = DocumentoTotal
                  FROM MaviBonificacionTest WITH(NOLOCK)
                  WHERE Origen = @Origen AND OrigenID = @OrigenId AND IDCobro = @idCobro 
                  AND Bonificacion LIKE '%Puntual%' AND MontoBonif > 0 AND  IdBonificacion = @IdBonificacion   

                  IF @DocumentoTotal IS NOT NULL OR @DocumentoTotal <> 0
                  BEGIN
	                SELECT @BaseCalculo = isnull(sum(isnull(C.Importe,0.00) + isnull(C.Impuestos,0.00) ),0.00) 
                    FROM Cxc c WITH(NOLOCK) WHERE c.mov = @Origen AND c.MovID = @OrigenID  

					SELECT @BaseCalculo = @BaseCalculo / @DocumentoTotal
                	                  
                    UPDATE MaviBonificacionTest SET BaseParaAplicar = round(isnull(@BaseCalculo,0.00),2)  
                    WHERE IdBonificacion = @IdBonificacion  
                    AND Origen=@Origen AND OrigenId=@OrigenId 
					AND IdCobro = @IdCobro AND Bonificacion LIKE '%Puntual%' 	                   
                  END 

                 UPDATE NegociaMoratoriosMAVI SET Bonificacion = round(isnull(Bonificacion,0.00),2) + Round(@Monto,2),   
                     PagoPuntual=round(isnull(@PagoPuntual,0.00),2),AdelantoPagos=round(isnull(@AdelantoPagos,0.00),2),  
                     IdPagoPuntual=@PagoPuntualId,IdAdelantoPagos=@AdelantoPagosId  
                  WHERE Mov = @MovNvo AND MovID = @MovIdNvo  
                    AND IdCobro = @IdCobro AND Origen = @Origen AND Origenid = @OrigenId  
                     
                END                  
                IF @Bonificacion LIKE '%Comercial%'  
                Begin   
                    SELECT @ParteContComercial = @ContadoComercial  / isnull((SELECT count(IdCobro) FROM NegociaMoratoriosMAVI WITH(NOLOCK) WHERE Origen=@Origen AND OrigenId=@OrigenId AND IDCobro = @IdCobro),1.00)  
                    UPDATE NegociaMoratoriosMAVI SET Bonificacion = round(isnull(Bonificacion,0.00),2) + Round(@ParteContComercial,2),   
                           ContadoComercial=round(isnull(@ParteContComercial,0.00),2),  IdContadoComercial=@ContadoComercialId             
                        WHERE IdCobro = @IdCobro AND Origen = @Origen AND OrigenId = @OrigenId    
                END   
                IF @Bonificacion LIKE '%Atraso%'  
                BEGIN  
                   SELECT @NoMdeNoAtraso = count(IdCobro) FROM NegociaMoratoriosMAVI WITH(NOLOCK) WHERE Origen=@Origen AND OrigenId=@OrigenId AND IDCobro = @IdCobro AND ImporteReal = ImporteAPagar
                    SELECT @ParteContComercial = @NoAtraso / isnull(@NoMdeNoAtraso,1)
                UPDATE NegociaMoratoriosMAVI SET Bonificacion = round(isnull(Bonificacion,0.00),2) + Round(@ParteContComercial,2), NoAtraso=round(isnull(@ParteContComercial,0.00),2),  
                           IdNoAtraso=@NoAtrasoId                             
                        WHERE IdCobro = @IdCobro AND Origen = @Origen AND OrigenId = @OrigenId   
                            AND ImporteReal = ImporteAPagar  
                END   
                  SELECT @Tictac = 1                    
              END ELSE  
              ------ Si no Esta Quitas el Monto de la Bonificacion de test  
              BEGIN  
               UPDATE MaviBonificacionTest SET MontoBonif = 0.00  
                  WHERE Mov = @MovNvo AND MovID = @MovIdNvo  
                  AND IdCobro = @IdCobro        
                  AND Origen = @Origen AND OrigenId = @OrigenId  
              End  
               
           FETCH NEXT FROM CrCxCBonif INTO @Docto, @Bonificacion,@Monto, @MovNvo, @MovIdNvo, @IdBonificacion, @PorcBon1  
         END  -- 5  
         CLOSE CrCxCBonif  
         DEALLOCATE CrCxCBonif        
    END  -- 4   
   --------------------   ADELANTO EN PAGOS=   
    IF EXISTS (SELECT IdBonificacion FROM MaviBonificacionTest mbt WITH(NOLOCK) WHERE mbt.Origen = @Origen AND mbt.OrigenId = @OrigenId AND Bonificacion LIKE '%Adelanto%'  
               AND mbt.MontoBonif > 0 AND mbt.Vencimiento > getdate())   
       BEGIN    
			---cuenta los docuemnto existentes   
			SELECT @MovNvo='', @MovIdNvo=''  

			SELECT @LineaVenta = LineaVta, @PorcBon1=PorcBon1,@AdelantoPagosId=IdBonificacion
			FROM MaviBonificacionTest WITH(NOLOCK)
			WHERE Origen = @Origen AND OrigenId = @OrigenId AND Bonificacion LIKE '%Adelanto%'  
			AND MontoBonif > 0

			----- pzamudio punto 32
			CREATE TABLE #Base(
			IDMov       INT         NOT NULL,
			Mov         VARCHAR(20) COLLATE Database_Default NOT NULL  ,
			Movid       VARCHAR (20) COLLATE Database_Default NOT NULL,
			Estatus     VARCHAR (15) COLLATE Database_Default  NULL,
			Concepto 	  VARCHAR(50) COLLATE Database_Default  NULL, 
			Vencimiento DATETIME  NULL,  
			PadreMAvi   VARCHAR(20) COLLATE Database_Default NOT NULL,
			PadreIDMAvi VARCHAR (20) COLLATE Database_Default NOT NULL,
			Saldo       MONEY NULL,
			Conteo      INT NULL, 
			Dense		  INT NULL 	   	
			)
			INSERT INTO #Base (IDMov, Mov, Movid, Estatus, Concepto, Vencimiento, PadreMAvi, PadreIDMAvi, Saldo, Conteo, Dense)    	
				SELECT  C.ID, C.mov, C.movid, C.estatus, C.concepto, C.vencimiento, C.PadreMAVI, C.PadreIDMAVI, Saldo,0 ,0 
				FROM Cxc c WITH(NOLOCK) 
				WHERE c.mov+c.MovID IN ( 
						SELECT mbt.mov+mbt.movid
						FROM MaviBonificacionTest mbt WITH(NOLOCK) 
						WHERE mbt.Origen = @Origen AND mbt.OrigenId = @OrigenId AND Bonificacion LIKE '%Adelanto%'  
						AND mbt.MontoBonif > 0 AND mbt.Vencimiento > getdate() 
				) 
				AND PadreMavi = @Origen AND PadreIDMavi = @OrigenId 


			SELECT @CuentaMov =count( DISTINCT Vencimiento),@CuentaMovBase =count( DISTINCT Vencimiento)
			FROM #Base 

			INSERT INTO #Base (IDMov, Mov, Movid, Estatus, Concepto, Vencimiento, PadreMAvi, PadreIDMAvi, Saldo, Conteo, Dense)    	
				SELECT  C.ID, C.mov, C.movid, C.estatus, C.concepto, C.vencimiento, C.PadreMAVI, C.PadreIDMAVI, isnull(sum(isnull(C.Importe,0.00) + isnull(C.Impuestos,0.00) ),0.00) 
				, ROW_NUMBER()  OVER (PARTITION BY c.Vencimiento ORDER BY c.Mov, c.MovID )
				, DENSE_RANK()  OVER ( ORDER BY c.Vencimiento )
				FROM cxc C WITH(NOLOCK)  -------Aqui Adelanto  
				WHERE C.PadreMAvi = @Origen AND C.PadreIDMavi=@OrigenId  
				AND c.Estatus = 'CONCLUIDO'  
				AND isnull(C.InteresesMoratoriosMAVI,0.00) = 0.00  
				AND c.Vencimiento > getdate()            
				AND C.Mov IN ('Documento')
				AND c.Vencimiento NOT IN (SELECT DISTINCT b.Vencimiento FROM #Base b ) 
				GROUP BY C.vencimiento, C.PadreMAVI, C.PadreIDMAVI, C.ID, C.mov, C.movid,  C.estatus, C.concepto 
				ORDER BY C.Vencimiento

			IF EXISTS (SELECT 1 FROM #Base b)
			BEGIN
				SELECT @CuentaMovBase =@CuentaMovBase + isnull(count(b.IDMov),0)        
				FROM #Base b
				WHERE Conteo > 0 AND Dense > 0 
			END
			DROP TABLE #Base

			IF @PorcBon1 < 99 SELECT @NvoPorc = isnull(@PorcBon1,1.00)*isnull((@CuentaMovBase),1.00)  --pzamudio pto 7
			IF @PorcBon1 > 99 SELECT @NvoPorc =isnull(@CuentaMovBase,1)  --pzamudio pto 7

			----- Fin   

			SELECT TOP 1 @DocumentoTotal = DocumentoTotal
			FROM MaviBonificacionTest WITH(NOLOCK)
			WHERE Origen = @Origen AND OrigenID = @OrigenId AND IDCobro = @idCobro 
			AND Bonificacion LIKE '%Adelanto%' AND MontoBonif > 0 

			SELECT @BaseCalculo = isnull(sum(isnull(C.Importe,0.00) + isnull(C.Impuestos,0.00) ),0.00) 
			FROM Cxc c WITH(NOLOCK) 
			WHERE c.mov = @Origen AND c.MovID = @OrigenID
			SELECT @MesesAdelanto = CASE WHEN Vencimiento > GETDATE() 
										 THEN CASE WHEN DATEDIFF(DD,GETDATE(),Vencimiento) % 30.4 <> 0 
														THEN CAST((DATEDIFF(DD,GETDATE(),Vencimiento) / 30.4 ) AS INT) + 1
												   WHEN DATEDIFF(DD,Vencimiento,GETDATE())%30.4 = 0
														THEN CAST((DATEDIFF(DD,GETDATE(),Vencimiento) / 30.4 ) AS INT)
											  END
									 ELSE 1 END
			FROM (
					SELECT 
						N = ROW_NUMBER() OVER(PARTITION BY PadreMAVI,PadreIDMAVI ORDER BY Vencimiento DESC),
						PadreMAVI,PadreIDMAVI,Vencimiento
					FROM Cxc WITH(NOLOCK)
					WHERE PadreMAVI = @Origen AND PadreIDMAVI = @OrigenId AND PadreMAVI <> Mov
			)x 
			WHERE n=1 AND VENCIMIENTO>GETDATE()
			IF @MesesAdelanto > @DocumentoTotal SELECT @MesesAdelanto = @DocumentoTotal
			SELECT @ParteContComercial = (((@BaseCalculo / @DocumentoTotal) * @MesesAdelanto) * (@PorcBon1 / 100)) / @CuentaMov
			SELECT @BaseCalculo = (@BaseCalculo / @DocumentoTotal) * @MesesAdelanto

			DECLARE crVerificaAdelanto CURSOR FAST_FORWARD FOR   
				SELECT mbt.Docto, mbt.Mov, mbt.MovId, IdBonificacion , PorcBon1   
				FROM MaviBonificacionTest mbt WITH(NOLOCK) 
				WHERE mbt.Origen = @Origen AND mbt.OrigenId = @OrigenId AND Bonificacion LIKE '%Adelanto%'  
				AND mbt.MontoBonif > 0 AND mbt.Vencimiento > getdate()           
				AND IDCobro=@IdCobro  
			OPEN crVerificaAdelanto  
			FETCH NEXT FROM crVerificaAdelanto INTO @AdelantoDocto, @MovNvo, @MovIdNvo ,@IdBonificacion, @PorcBon1  
			WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL  
			BEGIN  
				IF @@FETCH_STATUS <> -2 AND @Ok IS NULL  
				BEGIN  
					UPDATE NegociaMoratoriosMAVI SET Bonificacion = round(isnull(Bonificacion,0.00),2) + Round(@ParteContComercial,2),
					AdelantoPagos=Round(@ParteContComercial,2),
					IDAdelantoPagos=@AdelantoPagosId                            
					WHERE    
					Mov=@MovNvo AND MovID=@MovIdNvo  
					AND IDCobro=@IdCobro  
					AND Origen = @Origen AND Origenid = @OrigenId  
				END  
			FETCH NEXT FROM crVerificaAdelanto INTO @AdelantoDocto, @MovNvo, @MovIdNvo ,@IdBonificacion, @PorcBon1  
			END  
			CLOSE crVerificaAdelanto  
			DEALLOCATE crVerificaAdelanto	

			UPDATE MaviBonificacionTest SET MontoBonif = Round(@ParteContComercial,2), BaseParaAplicar = round(isnull(@BaseCalculo,0.00),2)  
			WHERE IdBonificacion = @IdBonificacion  
			AND Origen=@Origen AND OrigenId=@OrigenId AND PorcBon1 <> 0   
			AND IdCobro = @IdCobro
      END   
        
  ----END -- 3  
 FETCH NEXT FROM CrNegociaBonif INTO @Origen, @OrigenId  
END -- 2  
CLOSE CrNegociaBonif  
DEALLOCATE CrNegociaBonif  

IF EXISTS(SELECT ID FROM TEMPDB.SYS.SYSOBJECTS WHERE ID=OBJECT_ID('Tempdb.dbo.#NegociaMoratoriosMAVI') AND TYPE='U')          
	DROP TABLE #NegociaMoratoriosMAVI
CREATE TABLE #NegociaMoratoriosMAVI (Nro INT,ID INT,IDCobro INT,Mov VARCHAR(20),MovID VARCHAR(20),
									 ImporteAPagar MONEY,Bonificacion MONEY,Bonif VARCHAR(50),
									 BCC MONEY,BPP MONEY,BNA MONEY,BAP MONEY)
INSERT INTO #NegociaMoratoriosMAVI
        (Nro,ID,IDCobro,Mov,MovID,ImporteAPagar,Bonificacion,Bonif,BCC,BPP,BNA,BAP)
SELECT DISTINCT
       Nro = ROW_NUMBER() OVER(PARTITION BY N.IDCobro ORDER BY T.Vencimiento ASC),
	   N.ID,N.IDCobro,N.Mov,N.MovID,ISNULL(N.ImporteAPagar,0.00),ISNULL(N.Bonificacion,0.00),
	   Bonif=CASE WHEN ISNULL(N.ContadoComercial,0) <> 0 THEN 'Contado Comercial'
				  WHEN ISNULL(N.PagoPuntual,0) <> 0 THEN 'Pago Puntual'
				  WHEN ISNULL(N.IDAdelantoPagos,0) <> 0 AND ISNULL(N.IDNoAtraso,0) = 0 THEN 'Adelanto en Pagos'
				  WHEN ISNULL(N.IDNoAtraso,0) <> 0 AND ISNULL(N.IDAdelantoPagos,0) <> 0 THEN 'No Atraso - Adelanto en Pagos'
				  ELSE 'NA'
			 END,
	   ROUND(ISNULL(N.ContadoComercial,0.00),2),ROUND(ISNULL(N.PagoPuntual,0.00),2),ROUND(ISNULL(N.NoAtraso,0.00),2),ROUND(ISNULL(N.AdelantoPagos,0.00),2)
FROM NegociaMoratoriosMAVI N WITH(NOLOCK)
INNER JOIN (
	SELECT DISTINCT Mov,MovId,Vencimiento 
	FROM Cxc WITH(NOLOCK) 
	WHERE Mov<>PadreMAVI AND
	PadreMAVI=@Origen AND PadreIDMAVI=@OrigenId
)T ON T.Mov=N.Mov AND T.MovId=N.MovID
WHERE ISNULL(N.Bonificacion,0.00) > 0 AND N.IDCobro=@IdCobro


DECLARE @Ini INT,@Fin INT,@BonifTotal MONEY,@BonifDoc MONEY,@ImpDoc MONEY,
		@Bonif VARCHAR(50),@BAP MONEY,@BNA MONEY,@BPP MONEY,@BCC MONEY,
		@Porc FLOAT
SELECT @Ini=1,@Fin=MAX(Nro),@BonifTotal=0.00,@Porc=0,
	   @BAP=0.00,@BNA=0.00,@BCC=0.00,@BPP=0.00
FROM #NegociaMoratoriosMAVI

WHILE @Ini<=@Fin
BEGIN
	SELECT @BonifDoc=ISNULL(Bonificacion,0.00),@ImpDoc=ISNULL(ImporteAPagar,0.00) ,
		   @BAP=@BAP+BAP, @BNA=@BNA+BNA, @BCC=@BCC+BCC, @BPP=@BPP+BPP
	FROM #NegociaMoratoriosMAVI WHERE Nro=@Ini
	
	SET @BonifTotal = @BAP+@BNA+@BCC+@BPP
	IF @ImpDoc < @BonifTotal
	BEGIN
		UPDATE #NegociaMoratoriosMAVI SET Bonificacion=@BonifTotal, BAP=@BAP, BNA=@BNA, BCC=@BCC, BPP=@BPP
		WHERE Nro=@Ini
		
		SET @Porc = @BonifTotal-@ImpDoc
		SET @Porc = @Porc/@BonifTotal
		SELECT @BAP = ROUND(@BAP*@Porc,2),
			   @BNA = ROUND(@BNA*@Porc,2),
			   @BCC = ROUND(@BCC*@Porc,2),
			   @BPP = ROUND(@BPP*@Porc,2)
		SELECT @BonifTotal = @BonifTotal - (@BAP+@BNA+@BCC+@BPP)
		UPDATE #NegociaMoratoriosMAVI SET Bonificacion=@BonifTotal, BAP=BAP-@BAP, BNA=BNA-@BNA, BCC=BCC-@BCC, BPP=BPP-@BPP
		WHERE Nro=@Ini
	END
	ELSE IF @BonifTotal < @ImpDoc
			BEGIN
				UPDATE #NegociaMoratoriosMAVI SET Bonificacion = @BonifTotal, BAP=@BAP, BNA=@BNA, BCC=@BCC, BPP=@BPP
				WHERE Nro=@Ini
				SET @BonifTotal=0.00
				SET @Ini=@Fin
			END
	SET @Ini=@Ini+1
END

UPDATE NegociaMoratoriosMAVI SET Bonificacion = N2.Bonificacion, ContadoComercial = N2.BCC, PagoPuntual = N2.BPP, NoAtraso = N2.BNA, AdelantoPagos = N2.BAP
FROM NegociaMoratoriosMAVI N WITH(NOLOCK)
INNER JOIN #NegociaMoratoriosMAVI N2 ON N.IDCobro=@IdCobro AND N2.IDCobro=N.IDCobro
AND N2.Mov=N.Mov AND N2.MovID=N.MovID

RETURN  
END   
GO


/************************ spCalculaRemanenteMAVI *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spCalculaRemanenteMAVI') AND type = 'P') DROP PROCEDURE dbo.spCalculaRemanenteMAVI
GO
CREATE PROCEDURE dbo.spCalculaRemanenteMAVI            
   @ID    int,      
   @PorSist  char(1) -- '1' Notas Carg de mor, '2' Por sist              
--//WITH ENCRYPTION
AS BEGIN  --1      
	DECLARE      
	@Empresa   char(5),      
	@Sucursal  int,      
	@Hoy   datetime,      
	@Moneda   char(10),      
	@TipoCambio   float,      
	@Renglon   float,      
	@Aplica   varchar(20),      
	@AplicaID   varchar(20),      
	@AplicaMovTipo  varchar(20),      
	@Importe   money,      
	@SumaImporte  money,      
	@Impuestos   money,      
	@DesglosarImpuestos  bit,      
	@IDDetalle   int,      
	@IDCxc    int,      
	@ImporteReal   money,      
	@ImporteAPagar  money,      
	@ImporteMoratorio money,      
	@ImporteACondonar money,      
	  
	@MovGenerar   varchar(20),      
	@UEN    int,      
	@ImporteTotal  money,      
	@Mov    varchar(20),      
	@MovID    varchar(20),      
	@MovPadre   varchar(20),      
	@Ok     int,       
	@OkRef    varchar(255),      
	@Cliente   varchar(10),      
	@CteMoneda   varchar(10),      
	@CteTipoCambio  float,      
	@FechaAplicacion datetime,      
	@ClienteEnviarA     int,      
	@TotalMov   money,      
	@CampoExtra   varchar(50),      
	@Consecutivo  varchar(20),      
	@ValorCampoExtra varchar(255),      
	@Concepto   varchar(50),      
	@MoratorioAPagar money,      
	@MovIDGen   varchar(20),      
	@MovCobro   varchar(20),      
	@GeneraNC   char(1),      
	@Origen    varchar(20),      
	@OrigenID   varchar(20),      
	@Impuesto   money,      
	@DefImpuesto  float,      
	@Precalculo   money,      
	@Remanente   money,      
	@AbonoRealM   money,      
	@IDMovMor   int,  
	@FechaAnterior datetime,  
	@RemananteAnt money,
	@Vencimiento datetime 
      
	SET @FechaAplicacion = dbo.fnFechaSinHora(Getdate())      
	IF @PorSist = '1'      
	BEGIN      
		DECLARE crDetalle2 CURSOR FOR          
		SELECT Mov, MovID, ImporteReal, ImporteAPagar, ImporteMoratorio, ImporteACondonar, MoratorioAPagar            
		FROM NegociaMoratoriosMAVI      
		WHERE IDCobro = @ID  AND MoratorioAPagar > 0 AND Mov <> 'Cargo Moratorio'--      
		OPEN crDetalle2        
		FETCH NEXT FROM crDetalle2 INTO  @Mov, @MovID, @ImporteReal, @ImporteAPagar, @ImporteMoratorio, @ImporteACondonar, @MoratorioAPagar             
		WHILE @@FETCH_STATUS <> -1       
		BEGIN  -- 2      
			IF @@FETCH_STATUS <> -2 AND @OK IS NULL      
			BEGIN    -- 3      
				SELECT @IDMovMor = ID, @FechaAnterior = FechaOriginalAnt, @RemananteAnt = InteresMoratorioAnt, @Vencimiento = Vencimiento FROM CXC WHERE Mov = @Mov AND MovID = @MovID      
				SELECT  @Precalculo =  ISNULL(@MoratorioAPagar,0) - ISNULL(@ImporteACondonar,0)             
				IF @Precalculo = 0 SELECT  @AbonoRealM = 0      
				ELSE      
				IF @MoratorioAPagar >= @Precalculo      
				SELECT  @AbonoRealM = ISNULL(@Precalculo,0)      
				ELSE       
				SELECT  @AbonoRealM = ISNULL(@Precalculo,0) - ISNULL(@MoratorioAPagar,0)      
				-- Calcula Remanante      
				IF ( ISNULL(@ImporteMoratorio,0) - ISNULL(@ImporteACondonar,0) - ISNULL(@AbonoRealM,0)) < 0      
				SELECT @Remanente =  0      
				ELSE      
				SELECT @Remanente = (ISNULL(@ImporteMoratorio,0) - ISNULL(@ImporteACondonar,0) - ISNULL(@AbonoRealM,0))      

				UPDATE NegociaMoratoriosMAVI       
				SET AbonoRealM = ISNULL(@AbonoRealM,0),      
				Remanente  = @Remanente      
				WHERE IDCobro = @ID AND Mov = @Mov AND MovID = @MovID                       

				IF NOT EXISTS (Select IDCobro From HistCobroMoratoriosMAVI where IDCobro = @ID AND Mov = @Mov AND MovID = @MovID) 
				INSERT INTO HistCobroMoratoriosMAVI(IDCobro, Mov, MovID, FechaCobro, FechaOriginalAnt, InteresMoratoriosAnt)  
				VALUES(@ID, @Mov, @MovID, @FechaAplicacion, @FechaAnterior, @RemananteAnt)    

				IF (@Vencimiento <= @FechaAplicacion)
				BEGIN 
					UPDATE Cxc    
					SET FechaOriginalAnt = FechaOriginal,    
					FechaOriginal = @FechaAplicacion     
					WHERE ID = @IDMovMor    
				END

				UPDATE Cxc       
				SET InteresMoratorioAnt = ISNULL(InteresesMoratoriosMAVI,0)      
				WHERE ID = @IDMovMor      

				UPDATE Cxc       
				SET InteresesMoratoriosMAVI = ROUND(@Remanente, 2)  
				WHERE ID = @IDMovMor      
			END -- 3      
			FETCH NEXT FROM crDetalle2 INTO  @Mov, @MovID, @ImporteReal, @ImporteAPagar, @ImporteMoratorio, @ImporteACondonar, @MoratorioAPagar             
		END -- 2            
		CLOSE crDetalle2      
		DEALLOCATE crDetalle2      
	END      

	-- Se inserta en el detalle del cobro los doctos que se cubran      
	IF @PorSist = '2'      
	BEGIN      
		DECLARE crCondSist CURSOR FOR          
		SELECT Mov, MovID, MontoOriginal, MontoCondonado, MontoCondonado      
		FROM CondonaMoratoriosMAVI WHERE IdCobro = @ID AND Estatus = 'ALTA' and TipoCondonacion = 'Por Sistema'            
		OPEN crCondSist        
		FETCH NEXT FROM crCondSist INTO  @Mov, @MovID, @ImporteMoratorio, @ImporteACondonar, @MoratorioAPagar             
		WHILE @@FETCH_STATUS <> -1       
		BEGIN  -- 2      
			IF @@FETCH_STATUS <> -2 AND @OK IS NULL      
			BEGIN    -- 3      

				SELECT @IDMovMor = ID FROM CXC WHERE Mov = @Mov AND MovID = @MovID      
				SELECT  @Precalculo =  ISNULL(@MoratorioAPagar,0) - ISNULL(@ImporteACondonar,0)       
				IF @Precalculo = 0 SELECT  @AbonoRealM = 0      
				ELSE      
				IF @MoratorioAPagar >= @Precalculo      
				SELECT  @AbonoRealM = ISNULL(@Precalculo,0)      
				ELSE       
				SELECT  @AbonoRealM = ISNULL(@Precalculo,0) - ISNULL(@MoratorioAPagar,0)      
				IF ( ISNULL(@ImporteMoratorio,0) - ISNULL(@ImporteACondonar,0) - ISNULL(@AbonoRealM,0)) < 0      
				SELECT @Remanente =  0      
				ELSE      
				SELECT @Remanente =   (ISNULL(@ImporteMoratorio,0) - ISNULL(@ImporteACondonar,0) - ISNULL(@AbonoRealM,0))      
				UPDATE CondonaMoratoriosMAVI   
				SET AbonoRealM = ISNULL(@AbonoRealM,0),      
				Remanente  = ISNULL(@Remanente,0)      
				WHERE IDCobro = @ID AND Mov = @Mov AND MovID = @MovID                       

				IF NOT EXISTS (Select IDCobro From HistCobroMoratoriosMAVI where IDCobro = @ID AND Mov = @Mov AND MovID = @MovID) 
				INSERT INTO HistCobroMoratoriosMAVI(IDCobro, Mov, MovID, FechaCobro, FechaOriginalAnt, InteresMoratoriosAnt)  
				VALUES(@ID, @Mov, @MovID, @FechaAplicacion, @FechaAnterior, @RemananteAnt)  

				IF (@Vencimiento <= @FechaAplicacion)
				BEGIN 
					UPDATE Cxc    
					SET FechaOriginalAnt = FechaOriginal,    
					FechaOriginal = @FechaAplicacion     
					WHERE ID = @IDMovMor    
				END

				UPDATE Cxc       
				SET InteresMoratorioAnt = ISNULL(InteresesMoratoriosMAVI,0)      
				WHERE ID = @IDMovMor      

				UPDATE Cxc       
				SET InteresesMoratoriosMAVI = ROUND(ISNULL(@Remanente,0), 2)  WHERE ID = @IDMovMor      

			END -- 3      
			FETCH NEXT FROM crCondSist INTO  @Mov, @MovID, @ImporteMoratorio, @ImporteACondonar, @MoratorioAPagar             
		END -- 2            
		CLOSE crCondSist      
		DEALLOCATE crCondSist      
	END      
RETURN      
END  -- 1   
GO





/************************ spGeneraCobroSugeridoMAVI *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spGeneraCobroSugeridoMAVI') AND type = 'P') DROP PROCEDURE dbo.spGeneraCobroSugeridoMAVI
GO

CREATE PROCEDURE dbo.spGeneraCobroSugeridoMAVI  
@Modulo   char(5),  
@ID    int,  
@Usuario  varchar(10),  
@Estacion  int  
--//WITH ENCRYPTION
AS BEGIN    
DECLARE  
@Empresa   char(5),  
@Sucursal  int,  
@Hoy   datetime,  
@Moneda   char(10),  
@TipoCambio   float,  
@Renglon   float,  
@Aplica   varchar(20),  
@AplicaID   varchar(20),  
@AplicaMovTipo  varchar(20),  
@Importe   money,  
@SumaImporte  money,  
@Impuestos   money,  
@DesglosarImpuestos  bit,  
@IDDetalle   int,  
@IDCxc    int,  
@ImporteReal   money,  
@ImporteAPagar  money,  
@ImporteMoratorio money,  
@ImporteACondonar money,  
@MovGenerar   varchar(20),  
@UEN    int,  
@ImporteTotal  money,  
@Mov    varchar(20),  
@MovID    varchar(20),  
@MovPadre   varchar(20),  
@Ok     int,  
@OkRef    varchar(255),  
@Cliente   varchar(10),  
@CteMoneda   varchar(10),  
@CteTipoCambio  float,  
@FechaAplicacion datetime,  
@ClienteEnviarA     int,  
@TotalMov   money,  
@CampoExtra   varchar(50),  
@Consecutivo  varchar(20),  
@ValorCampoExtra varchar(255),  
@Concepto   varchar(50),  
@MoratorioAPagar money,  
@MovIDGen   varchar(20),  
@MovCobro   varchar(20),  
@GeneraNC   char(1),  
@Origen    varchar(20),  
@OrigenID   varchar(20),  
@Impuesto   money,  
@DefImpuesto  float,  
@ImporteDoc   money,  
@Bonificacion  money,  
@MovIDGenerado  varchar(20),  
@TotalAPagar  money,  
@IDCargoMor  int,  
@InteresPorPolitica money,  
@MovIDCgo varchar(20),  
@IDPadre int,  
@SaldoIniDia money,  
@PorcAbonoCapital float,  
@PorcMoratorioBonificar float,  
@TotalMoratorio money,  
@MoratorioBonificado money,  
@MoratorioXPagar  money,  
@TotalCobrosDia   money,  
@PorcIntaBonificar  float,  
@PorcPAgoCapital  float,  
@Nota     varchar(100),  
@CobroxPolitica   int,  
@MoratoriosaBonificar money,  
@VencimientoMasAntiguo datetime,  
@IDCargoMorEst  int,  
@IdCargoMoratorio int,  
@IdCargoMoratorioEst int,  
@SaldoNCPend  money,  
@SaldoEstPend  money,  
@EstatusNCEst varchar(15),  
@EstatusNC     varchar(15),  
@IDUltCobro  int,  
@TotalMoratUltCob money,  
@EstatusCargoMor varchar(15),  
@EstatusCargoMorEst varchar(15),  
@TotalBonificacion  money  
SET @CobroxPolitica = 0  
SET @FechaAplicacion = Getdate()  
SELECT @CteMoneda = ClienteMoneda, @CteTipoCambio = ClienteTipoCambio, @Cliente = Cliente FROM CXC WHERE ID = @ID  
SELECT @CobroxPolitica = ISNULL(TipoCobro,0) FROM TipoCobroMAVI WHERE IdCobro = @ID  
SELECT @DesglosarImpuestos = 0 , @Renglon = 0.0, @SumaImporte = 0.0, @ImporteTotal = NULLIF(@ImporteTotal, 0.0)  
SELECT @Renglon = 1024.0  
SELECT @GeneraNC = '1'  
IF not exists(SELECT * FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID)  
BEGIN  
SELECT 'No hay sugerencia a cobrar..'  
RETURN  
END  
BEGIN TRANSACTION BonMAVI  
IF @Modulo = 'CXC'  
BEGIN    
UPDATE CXC SET AplicaManual = 1 WHERE id = @ID  
SELECT @Empresa = Empresa, @Sucursal = Sucursal, @Hoy = FechaEmision, @Moneda = Moneda, @TipoCambio = TipoCambio, @ClienteEnviarA = ClienteEnviarA, @MovCobro = Mov  FROM Cxc WHERE ID = @ID  
DELETE CxcD WHERE ID = @ID  
DELETE DetalleAfectacionMAVI WHERE IDCobro = @ID  
EXEC spGeneraNCredPPMAVI @ID, @Usuario, @Ok OUTPUT, @OkRef OUTPUT  
IF @Ok IS NULL  
EXEC spGeneraNCredNAMAVI @ID, @Usuario, @Ok OUTPUT, @OkRef OUTPUT  
IF @Ok IS NULL  
EXEC spGeneraNCredAPMAVI @ID, @Usuario, @Ok OUTPUT, @OkRef OUTPUT  
IF @Ok IS NULL  
EXEC spGeneraNCredBonifMAVI @ID, @Usuario, @Ok OUTPUT, @OkRef OUTPUT  
IF @Ok IS NULL  
BEGIN    
DECLARE crDetalle CURSOR FAST_FORWARD FOR  
SELECT   
SUM(ISNULL(MoratorioAPagar,0) - ISNULL(ImporteACondonar,0)), Origen, OrigenID  
FROM NegociaMoratoriosMAVI  
WHERE IDCobro = @ID    
AND Estacion = @Estacion AND MoratorioAPagar > 0  
GROUP BY Origen, OrigenID  
OPEN crDetalle  
FETCH NEXT FROM crDetalle INTO  @ImporteMoratorio, @Origen, @OrigenID  
WHILE @@FETCH_STATUS <> -1  
BEGIN    
IF @@FETCH_STATUS <> -2 AND @OK IS NULL  
BEGIN      
SELECT @UEN = UEN, @ClienteEnviarA = ClienteEnviarA FROM CXC WHERE Mov = @Origen AND MovId = @OrigenID  
IF @ImporteMoratorio > 0  
BEGIN    
SELECT @MovGenerar = dbo.fnMaviObtieneMovSaldoMoratorios(@Origen,'Moratorios', @UEN)  
IF @MovGenerar Is NULL  
SELECT @MovGenerar = 'Nota Cargo'  
IF @MovGenerar = 'Endoso' SELECT @MovGenerar = 'Nota Cargo'  
SELECT @DefImpuesto = 1 + ISNULL(DefImpuesto,15.0)/100 FROM EmpresaGral WHERE Empresa = @Empresa  
SELECT @Importe = @ImporteMoratorio/@DefImpuesto     
SELECT @Impuesto = @ImporteMoratorio - @Importe  
IF @MovGenerar in ( 'Nota Cargo', 'Nota Cargo VIU')  SELECT @Concepto = 'MORATORIOS MENUDEO'  
IF @MovGenerar = 'Nota Cargo Mayoreo'  SELECT @Concepto = 'MORATORIOS MAYOREO'  
IF @GeneraNC = '1'  
BEGIN    
INSERT INTO Cxc(Empresa, Mov, MovID, FechaEmision, Concepto, UltimoCambio, Moneda, TipoCambio, Usuario, Referencia,  
Estatus, Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio, Vencimiento,  
Importe, Impuestos, AplicaManual, ConDesglose, Saldo,  
ConTramites, VIN, Sucursal, SucursalOrigen, UEN, PersonalCobrador, FechaOriginal, Nota,  
Comentarios, LineaCredito, TipoAmortizacion, TipoTasa, Amortizaciones, Comisiones, ComisionesIVA,  
FechaRevision, ContUso, TieneTasaEsp, TasaEsp, Codigo)  
VALUES(@Empresa, @MovGenerar, NULL, dbo.fnFechaSinHora(@FechaAplicacion), @Concepto, @FechaAplicacion, @Moneda, @TipoCambio, @Usuario, null,    
'SINAFECTAR',  @Cliente, @ClienteEnviarA, @Moneda, @TipoCambio, @FechaAplicacion,  
@Importe, @Impuesto, 0, 0, ISNULL(@Importe,0) + ISNULL(@Impuesto,0),  
0, NULL, @Sucursal, @Sucursal, @UEN, NULL, NULL, NULL,  
'', NULL, NULL, NULL, NULL, NULL, NULL,  
NULL, NULL, 0, NULL, NULL)  
SELECT @IDCxc = IDENT_CURRENT('CxC')  
EXEC spAfectar 'CXC', @IDCxc, 'AFECTAR', 'Todo', NULL, @Usuario,  NULL, 1, @Ok OUTPUT, @OkRef OUTPUT,NULL, @Conexion =  1   
INSERT INTO DetalleAfectacionMAVI( IDCobro, ID, Mov, MovID, ValorOK, ValorOKRef) VALUES(@ID, @IDCxc, @MovGenerar, @MovIDGen, @Ok, @OkRef )  
UPDATE NegociaMoratoriosMAVI  
SET NotaCargoMorId = @IDCxc  
WHERE IDCobro = @ID AND Estacion = @Estacion AND MoratorioAPagar > 0 AND Origen = @Origen AND OrigenID = @OrigenId  
SELECT @MovIDGen = MovId FROM CXC WHERE ID = @IDCxc  
INSERT CxcD (ID,  Sucursal,  Renglon,  Aplica,  AplicaID,  Importe,   InteresesOrdinarios, InteresesMoratorios, ImpuestoAdicional)  
VALUES (@ID, @Sucursal, @Renglon, @MovGenerar, @MovIDGen, NULLIF(@ImporteMoratorio, 0.0), 0.0, 0.0, 0.0)  
SELECT @Renglon = @Renglon + 1024.0  
IF @Ok = 80030  
SELECT @Ok = NULL  
IF @Ok IS NULL   
BEGIN    
IF NOT EXISTS(SELECT * FROM MovCampoExtra WHERE Modulo = @Modulo AND Mov = @MovGenerar AND ID = @IDCxc)  
BEGIN    
SELECT @AplicaId  = MovId FROM CXC WHERE ID = @IDCxc  
IF @MovGenerar = 'Nota Cargo'  SELECT @CampoExtra = 'NC_FACTURA'                         IF @MovGenerar = 'Nota Cargo VIU'  SELECT @CampoExtra = 'NCV_FACTURA'  
IF @MovGenerar = 'Nota Cargo Mayoreo'  SELECT @CampoExtra = 'NCM_FACTURA'  
SELECT @ValorCampoExtra =  RTRIM(@Origen)+'_'+RTRIM(@OrigenId)  
IF  @MovGenerar in ('Nota Cargo', 'Nota Cargo VIU', 'Nota Cargo Mayoreo')  
INSERT INTO MovCampoExtra (Modulo, Mov, ID, CampoExtra, Valor ) VALUES('CXC', @MovGenerar, @IDCxc, @CampoExtra, @ValorCampoExtra)  
END     
END    
END    
END   
END   
FETCH NEXT FROM crDetalle INTO  @ImporteMoratorio, @Origen, @OrigenID  
END   
CLOSE crDetalle  
DEALLOCATE crDetalle  
DECLARE crDoc CURSOR FAST_FORWARD FOR  
SELECT Mov, MovID, ImporteReal, ImporteAPagar, ImporteMoratorio, ImporteACondonar, Bonificacion, TotalAPagar  
FROM NegociaMoratoriosMAVI  
WHERE IDCobro = @ID AND Estacion = @Estacion AND ImporteAPagar > 0  
OPEN crDoc  
FETCH NEXT FROM crDoc INTO @Mov, @MovID, @ImporteReal, @ImporteAPagar, @ImporteMoratorio, @ImporteACondonar, @Bonificacion, @TotalAPagar  
WHILE @@FETCH_STATUS <> -1  
BEGIN    
IF @@FETCH_STATUS <> -2 AND @OK IS NULL  
BEGIN      
SELECT  @ImporteDoc =  ISNULL(@ImporteAPagar,0) - ISNULL(@Bonificacion,0)  
IF @ImporteDoc > 0   
BEGIN    
INSERT CxcD (ID,  Sucursal,  Renglon,  Aplica,  AplicaID,  Importe,   InteresesOrdinarios, InteresesMoratorios, ImpuestoAdicional)  
VALUES (@ID, @Sucursal, @Renglon, @Mov, @MovID, NULLIF(@ImporteDoc, 0.0), 0.0, 0.0, 0.0)  
SELECT @Renglon = @Renglon + 1024.0  
END    
END    
FETCH NEXT FROM crDoc INTO @Mov, @MovID, @ImporteReal, @ImporteAPagar, @ImporteMoratorio, @ImporteACondonar, @Bonificacion, @TotalAPagar  
END    
CLOSE crDoc  
DEALLOCATE crDoc  
IF @CobroxPolitica = 1  
BEGIN  
UPDATE CXC SET Concepto = 'POLITICA QUITA MORATORIOS' WHERE ID = @ID  
SELECT @InteresPorPolitica = MIN(InteresPorPolitica)  
FROM NegociaMoratoriosMAVI  
WHERE IDCobro = @ID AND InteresPorPolitica > 0  
SELECT @Origen = Origen, @OrigenID = OrigenID  
FROM NegociaMoratoriosMAVI  
WHERE IDCobro = @ID  
GROUP BY Origen, OrigenID     
SELECT @IDPadre = ID, @UEN = UEN, @ClienteEnviarA = ClienteEnviarA  
FROM CXC WHERE  Mov = @Origen AND MovID = @OrigenID  
SELECT @ImporteTotal = SUM(ISNULL(ImporteAPagar,0)) FROM NegociaMoratoriosMAVI  
WHERE IDCobro = @ID  
IF NOT EXISTS(SELECT * FROM  CobroXPoliticaHistMAVI WHERE Mov = @Origen AND MovID = @OrigenID AND  
CONVERT(varchar(8),FechaEmision,112) =  CONVERT(varchar(8),@FechaAplicacion,112)  
AND EstatusCobro = 'CONCLUIDO')  
BEGIN  
SET @TotalBonificacion = 0  
SELECT @TotalBonificacion = SUM(ISNULL(Bonificacion,0)) FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID  
SELECT @SaldoIniDia = dbo.fnSaldoPMMAVI(@IDPadre) + ISNULL(@TotalBonificacion,0)  
SELECT @TotalCobrosDia = @ImporteTotal  
END  
ELSE  
BEGIN  
SELECT TOP 1 @SaldoIniDia = SaldoInicioDelDia  
FROM CobroXPoliticaHistMAVI  
WHERE Mov = @Origen AND MovID = @OrigenID AND CONVERT(varchar(8),FechaEmision,112) = CONVERT(varchar(8),@FechaAplicacion,112)  AND EstatusCobro = 'CONCLUIDO'  
ORDER BY IDCobro ASC  
SELECT @TotalCobrosDia = SUM(ImporteCobro) + ISNULL(@ImporteTotal,0) FROM CobroXPoliticaHistMAVI WHERE Mov = @Origen AND MovID = @OrigenID AND  
CONVERT(varchar(8),FechaEmision,112) =  CONVERT(varchar(8),@FechaAplicacion,112) AND EstatusCobro = 'CONCLUIDO'  
SELECT /*@IdCargoMoratorio = 0, */ @IdCargoMoratorioEst = 0  
SELECT TOP 1 @IDUltCobro = idCobro, @PorcMoratorioBonificar = PorcMoratorioBonificar, /*@IdCargoMoratorio = IdCargoMoratorio,*/ @IdCargoMoratorioEst = IdCargoMoratorioEst, @TotalMoratUltCob = TotalMoratorio  
FROM CobroXPoliticaHistMAVI  
WHERE Mov = @Origen AND MovID = @OrigenID  
AND CONVERT(varchar(8),FechaEmision,112) =  CONVERT(varchar(8),@FechaAplicacion,112)  
AND EstatusCobro = 'CONCLUIDO'  
ORDER BY IDCobro DESC  
SELECT @InteresPorPolitica = @TotalMoratUltCob  
IF @PorcMoratorioBonificar <= 100  
BEGIN  
SELECT @SaldoEstPend = ISNULL(Importe,0) + ISNULL(Impuestos,0), @EstatusNCEst = Estatus  FROM CXC WHERE ID = @IdCargoMoratorioEst  
IF @IdCargoMoratorioEst > 0  
BEGIN  
EXEC spAfectar 'CXC', @IdCargoMoratorioEst, 'CANCELAR', 'Todo', NULL, @Usuario,  NULL, 1, @Ok OUTPUT, @OkRef OUTPUT,NULL, @Conexion =  1   
UPDATE CobroxPoliticaHistMAVI  
SET EstatusCargoMorEst = 'CANCELADO'  
WHERE IdCargoMoratorioEst = @IdCargoMoratorioEst  
END  
END  
END  
IF @SaldoIniDia > 0  
SELECT @PorcAbonoCapital = (@TotalCobrosDia / @SaldoIniDia)*100.0  
SELECT @PorcIntaBonificar = 0  
SELECT TOP 1 @PorcIntaBonificar = ISNULL(Valor,0) FROM TablaNumD WHERE TablaNum = 'CFG QUITA MORATORIOS' AND @PorcAbonoCapital >= Numero  ORDER BY Valor DESC  
SELECT @Nota = NULL  
IF @PorcIntaBonificar > 0.0  
BEGIN  
SELECT @PorcMoratorioBonificar = ISNULL(@InteresPorPolitica,0) - (ISNULL(@InteresPorPolitica,0) * (ISNULL(@PorcIntaBonificar,0)/100.0))  
SELECT @MoratorioXPagar = @PorcMoratorioBonificar  
SELECT @MoratoriosaBonificar =  ISNULL(@InteresPorPolitica,0) - ISNULL(@PorcMoratorioBonificar,0)  
SELECT @Nota = 'IM Bonificado:' + CONVERT(Varchar(20), @MoratoriosaBonificar)  
END  
ELSE  
BEGIN  
UPDATE NegociaMoratoriosMAVI SET InteresAPAgarConPolitica = 0 WHERE IDCobro = @ID  
SELECT @Nota = 'IM Bonificado: 0'  
SELECT @MoratoriosaBonificar = 0  
SELECT @MoratorioXPagar =  ISNULL(@InteresPorPolitica,0) - ISNULL(@PorcMoratorioBonificar,0)  
END  
SELECT @EstatusCargoMorEst = NULL  
IF @InteresPorPolitica > 0 AND @PorcIntaBonificar > 0 AND @PorcIntaBonificar <= 100    
BEGIN  
SELECT @EstatusCargoMorEst = 'CONCLUIDO'  
INSERT INTO Cxc(Empresa, Mov, MovID, FechaEmision, Concepto, UltimoCambio, Moneda, TipoCambio, Usuario, Referencia,  
Estatus, Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio, Condicion, Vencimiento,  
Importe, Impuestos, AplicaManual, ConDesglose, Saldo,  
ConTramites, VIN, Sucursal, SucursalOrigen, UEN, PersonalCobrador, FechaOriginal, Nota,  
Comentarios, LineaCredito, TipoAmortizacion, TipoTasa, Amortizaciones, Comisiones, ComisionesIVA,  
FechaRevision, ContUso, TieneTasaEsp, TasaEsp, Codigo, PadreMAVI, PadreIDMAVI, IDPadreMAVI  )  
VALUES(@Empresa, 'Cargo Moratorio Est', NULL, @FechaAplicacion, @Concepto, @FechaAplicacion, @Moneda, @TipoCambio, @Usuario, null,    
'SINAFECTAR',  @Cliente, @ClienteEnviarA, @Moneda, @TipoCambio, '(Fecha)', @FechaAplicacion,  
@MoratoriosaBonificar, @Impuesto, 0, 0, ISNULL(@MoratoriosaBonificar,0) + ISNULL(@Impuesto,0),  
0, NULL, @Sucursal, @Sucursal, @UEN, NULL, NULL, @Nota,  
'', NULL, NULL, NULL, NULL, NULL, NULL,  
NULL, NULL, 0, NULL, NULL, 'Cargo Moratorio Est', NULL, @IDPadre)  
SELECT @IDCargoMorEst = @@IDENTITY  
EXEC spAfectar 'CXC', @IDCargoMorEst, 'AFECTAR', 'Todo', NULL, @Usuario,  NULL, 1, @Ok OUTPUT, @OkRef OUTPUT,NULL, @Conexion =  1   
SELECT @MovIDCgo = MovId FROM CXC WHERE ID = @IDCargoMorEst  
UPDATE Cxc SET PadreIDMAVI = @MovIDCgo WHERE ID = @IDCargoMorEst  
INSERT INTO DetalleAfectacionMAVI( IDCobro, ID, Mov, MovID, ValorOK, ValorOKRef) VALUES(@ID, @IDCargoMorEst, 'Cargo Moratorio Est', @MovIDGen, @Ok, @OkRef )  
IF NOT EXISTS(SELECT * FROM MovCampoExtra WHERE Modulo = @Modulo AND Mov = 'Cargo Moratorio Est' AND ID = @IDCargoMorEst)  
BEGIN    
SELECT @CampoExtra = 'CM_FACTURA'  
SELECT @ValorCampoExtra =  RTRIM(@Origen)+'_'+RTRIM(@OrigenId)  
INSERT INTO MovCampoExtra (Modulo, Mov, ID, CampoExtra, Valor ) VALUES('CXC', 'Cargo Moratorio Est', @IDCargoMorEst, @CampoExtra, @ValorCampoExtra)  
END     
SELECT @VencimientoMasAntiguo = MIN(Vencimiento) FROM Cxc WHERE /*Cliente =  @Cliente*/ PadreMAVI = @Origen AND PadreIDMAVI = @OrigenID  
AND Estatus = 'PENDIENTE'  
IF @VencimientoMasAntiguo IS NULL  
SELECT @VencimientoMasAntiguo = @FechaAplicacion  
/* IF @PorcIntaBonificar = 100.0    
*/  
END  
INSERT INTO CobroXPoliticaHistMAVI (IdCobro, FechaEmision, EstatusCobro, ImporteCobro, Cliente, Mov, MovID,  
SaldoIniciodelDia, TotalCobrosdelDia, PorcAbonoCapital, PorcMoratorioBonificar, TotalMoratorio, MoratorioBonificado,  
MoratorioXPagar, /*IdCargoMoratorio, EstatusCargoMoratorio,*/ IdCargoMoratorioEst, EstatusCargoMorEst )  
VALUES(@ID, @FechaAplicacion, 'SINAFECTAR',  @ImporteTotal, @Cliente, @Origen, @OrigenID,  
@SaldoIniDia, @TotalCobrosDia, @PorcAbonoCapital, @PorcIntaBonificar, @InteresPorPolitica, ISNULL(@MoratoriosaBonificar,0),  
ISNULL(@MoratorioXPagar,0), /*@IDCargoMor, @EstatusCargoMor,*/ ISNULL(@IDCargoMorEst,0), @EstatusCargoMorEst)  
END  
SELECT @Impuestos = SUM(d.importe*isnull(ca.IVAFiscal,0))   
FROM CXCD d  
JOIN CxcAplica ca ON d.Aplica = ca.Mov AND d.AplicaID = ca.MovID AND ca.Empresa = @Empresa  
WHERE d.ID = @ID  
SELECT @TotalMov = SUM(d.Importe-isnull(d.Importe*ca.IVAFiscal,0))  
FROM CXCD d  
JOIN CxcAplica ca ON d.Aplica = ca.Mov AND d.AplicaID = ca.MovID AND ca.Empresa = @Empresa  
WHERE d.ID = @ID  
UPDATE CXC  
SET Importe = isnull(ROUND(@TotalMov,2),0.00),  
Impuestos = isnull(ROUND(@Impuestos,2),0.00),  
Saldo = isnull(ROUND(@TotalMov,2),0.00) + isnull(ROUND(@impuestos,2),0.00)  
WHERE ID = @ID  
/**** Despues */  
EXEC spAfectar 'CXC', @ID, 'AFECTAR', 'Todo', NULL, @Usuario,  NULL, 1, @Ok OUTPUT, @OkRef OUTPUT,NULL, @Conexion = 1    
SELECT @MovIDGenerado = MovID FROM CXC WHERE ID = @ID  
UPDATE CXC  
SET Referencia = RTRIM(@MovCobro)+'_'+RTRIM(@MovIDGenerado)  
WHERE IDCobroBonifMAVI = @ID  
/*IF @IDCargoMor > 0  
UPDATE CXC  
SET Referencia = RTRIM(@MovCobro)+'_'+RTRIM(@MovIDGenerado)  
WHERE ID = @IDCargoMor              */  
IF @IDCargoMorEst > 0  
UPDATE CXC  
SET Referencia = RTRIM(@MovCobro)+'_'+RTRIM(@MovIDGenerado)  
WHERE ID = @IDCargoMorEst  
END   
IF @Ok IS NULL OR @Ok = 80030  
BEGIN  
COMMIT TRANSACTION BonMAVI  
END  
ELSE  
BEGIN  
SELECT  @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok  ROLLBACK TRANSACTION BonMAVI  
SELECT @OkRef     
END  
RETURN  
END  
END    

GO
/************************ spGeneraNCredBonifMAVI *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spGeneraNCredBonifMAVI') AND type = 'P') DROP PROCEDURE dbo.spGeneraNCredBonifMAVI
GO
CREATE PROCEDURE dbo.spGeneraNCredBonifMAVI
      @ID		int,            
      @Usuario	varchar(10),              
      @Ok       int                OUTPUT,            
      @OkRef    varchar(255)       OUTPUT                         
--//WITH ENCRYPTION       
AS BEGIN            
  DECLARE            
    @Empresa   char(5),            
    @Sucursal   int,            
    @Hoy   datetime,            
    @Vencimiento  datetime,            
    @Moneda   char(10),            
    @TipoCambio   float,            
    @Contacto   char(10),            
    @Renglon   float,            
    @Aplica   varchar(20),            
    @AplicaID   varchar(20),                  
	@ImpReal    money,            
	@MoratorioAPagar  money,            
    @Origen    varchar(20),            
    @OrigenID   varchar(20),                            
    @MovPadre   varchar(20),            
    @MovPadre1   varchar(20),            
    @MovIDPadre   varchar(20),            
    @ContadoComercial money,            
    @UEN    int,            
	@MovCrear   varchar(20),            
    @Mov    varchar(20),            
    @IDCxc    int,            
    @FechaAplicacion datetime,            
    @CtaDinero   varchar(10),            
    @Concepto   varchar(50),            
	@IDPol    int,            
    @NumDoctos   int,            
    @ImpDocto   money,            	 
    @MovID    varchar(20),            
    @TotalMov   money,                
    @Referencia   varchar(100),            
    @Impuestos   money,            
    @CanalVenta   int,            
	@DocsPend   int,            
	@SdoDoc   money,            
    @ImpTotalBonif  money,        
	@IDCxc2    int,        
	@DefImpuesto float        
            
  SET @DocsPend = 0            
  SET @FechaAplicacion = GetDate()            
  SELECT @Empresa = Empresa, @Sucursal = Sucursal, @Hoy = FechaEmision, @Moneda = Moneda, @TipoCambio = TipoCambio, @Contacto = Cliente   FROM Cxc WHERE ID = @ID             
  -- OJO es importante tomar el concepto de cada politica            
            
  DECLARE crGenBonif CURSOR FOR            
   SELECT SUM(ISNULL(ContadoComercial,0)), Origen, OrigenId, IDContadoComercial            
     FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID  AND ContadoComercial > 0              
    GROUP BY Origen, OrigenId, IDContadoComercial            
  OPEN crGenBonif            
  FETCH NEXT FROM crGenBonif INTO @ContadoComercial, @Origen, @OrigenID, @IdPol            
  WHILE @@FETCH_STATUS <> -1             
  BEGIN  -- 2            
    IF @@FETCH_STATUS <> -2             
    BEGIN  -- 3            
      SET @ImpTotalBonif = @ContadoComercial            
      SET @Renglon = 1024.0             
      SELECT @UEN = UEN, @CanalVenta = ClienteEnviarA FROM CXC WHERE Mov = @Origen AND MovId = @OrigenID             
            
      SELECT @MovPadre = @Origen             
      SELECT @MovCrear = ISNULL(MovCrear, 'Nota Credito')  FROM MovCrearBonifMAVI WHERE Mov = @Movpadre AND UEN = @UEN            
                           
      IF @MovCrear IS NULL SELECT @MovCrear = 'Nota Credito'                     
                     
      SELECT @Concepto = Concepto            
          FROM MaviBonificacionConf where ID = @IDPol                         
          
      SELECT @DocsPend = Count(*) FROM CXC WHERE PadreMAVI = @Origen AND PadreIDMAVI = @OrigenID AND Estatus = 'PENDIENTE'          
        IF @DocsPend > 0          
        BEGIN  -- 5       
		  INSERT INTO Cxc(Empresa, Mov, MovID, FechaEmision, UltimoCambio, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Autorizacion, Referencia, DocFuente,             
			  Observaciones, Estatus, Situacion, SituacionFecha, SituacionUsuario, SituacionNota, Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio,   -- 2            
			  Cobrador, Condicion, Vencimiento, FormaCobro, CtaDinero, Importe, Impuestos, Retencion, AplicaManual, ConDesglose, FormaCobro1, FormaCobro2,             
			  FormaCobro3, FormaCobro4, FormaCobro5, Referencia1, Referencia2, Referencia3, Referencia4, Referencia5, Importe1, Importe2, Importe3,   --4            
			  Importe4, Importe5, Cambio, DelEfectivo, Agente, ComisionTotal, ComisionPendiente, MovAplica, MovAplicaID, OrigenTipo, Origen, OrigenID,             
			  Poliza, PolizaID, FechaConclusion, FechaCancelacion, Dinero, DineroID, DineroCtaDinero, ConTramites, VIN, Sucursal, SucursalOrigen, Cajero,             
			  UEN, PersonalCobrador, FechaOriginal, Nota, Comentarios, LineaCredito, TipoAmortizacion, TipoTasa, Amortizaciones, Comisiones, ComisionesIVA,             
			  FechaRevision, ContUso, TieneTasaEsp, TasaEsp, Codigo)            
		  VALUES (@Empresa, @MovCrear, NULL, cast(convert(varchar, @FechaAplicacion, 101) as datetime), @FechaAplicacion, @Concepto, NULL, @Moneda, @TipoCambio, @Usuario, NULL, @Referencia, NULL, --1            
				NULL, 'SINAFECTAR', NULL, NULL, NULL, NULL, @Contacto, @CanalVenta, @Moneda, @TipoCambio,   --2            
				NULL, NULL, @FechaAplicacion, NULL, @CtaDinero, NULL, NULL, NULL, 1, 0, NULL, NULL,   -- 3            
				NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,  -- 4            
				NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -- 5            
				NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, @Sucursal, @Sucursal, NULL,             
				@UEN, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL,             
				NULL, NULL, 0, NULL, NULL)  -- 7            
		      
		  SELECT @IDCxc = @@IDENTITY                                
                            
         -- Cursor para el detalle de la NCred            
		  DECLARE crDetNCBonif CURSOR FOR            
		   SELECT Mov, MovID, ContadoComercial             
			 FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID AND ContadoComercial > 0              
			 AND Origen = @Origen AND OrigenId = @OrigenID --AND IDContadoComercial = @IdPol            
		  OPEN crDetNCBonif            
		  FETCH NEXT FROM crDetNCBonif INTO @Mov, @MovID, @ImpDocto            
		  WHILE @@FETCH_STATUS <> -1             
		  BEGIN  -- 6            
			IF @@FETCH_STATUS <> -2 AND @ImpTotalBonif > 0            
			BEGIN  -- 7            
					 -- Se verifica el sdo pendiente de cada doc contra el importe de la bonificación            
             SELECT @SdoDoc = Saldo FROM CXC WHERE Mov = @Mov AND MovId = @MovId            

             IF @ImpDocto > @SdoDoc-- 8            
             BEGIN            
               SELECT @ImpDocto = @SdoDoc            
				-- SELECT @ImpDocto as 'ImpNotaCred'            
               SET @ImpTotalBonif = @ImpTotalBonif - @ImpDocto            
			   INSERT INTO CxcD(ID, Renglon, RenglonSub, Aplica, AplicaID, Importe, Fecha, Sucursal, SucursalOrigen, DescuentoRecargos, InteresesOrdinarios,             
								InteresesMoratorios, InteresesOrdinariosQuita, InteresesMoratoriosQuita, ImpuestoAdicional, Retencion)            
               VALUES(@IDCxc, @Renglon, 0, @Mov, @MovId, @ImpDocto, NULL, @Sucursal, @Sucursal, NULL, NULL, NULL, NULL, NULL, NULL, NULL)            
            
               SET @Renglon = @Renglon + 1024.0            
         
               UPDATE NegociaMoratoriosMAVI             
                  SET NotaCredBonId = @IDCxc            
                WHERE IDCobro = @ID              
                  AND Origen = @Origen AND OrigenId = @OrigenID  AND IDContadoComercial = @IdPol             
             END -- 8            
             ELSE            
             BEGIN            
                  
               IF @ImpDocto <= @SdoDoc --             
               BEGIN            
            
                 SET @ImpTotalBonif = @ImpTotalBonif - @ImpDocto            
          INSERT INTO CxcD(ID, Renglon, RenglonSub, Aplica, AplicaID, Importe, Fecha, Sucursal, SucursalOrigen, DescuentoRecargos, InteresesOrdinarios,             
                      InteresesMoratorios, InteresesOrdinariosQuita, InteresesMoratoriosQuita, ImpuestoAdicional, Retencion)            
          VALUES(@IDCxc, @Renglon, 0, @Mov, @MovId, @ImpDocto, NULL, @Sucursal, @Sucursal, NULL, NULL, NULL, NULL, NULL, NULL, NULL)            
            
                 SET @Renglon = @Renglon + 1024.0            
                        
                 UPDATE NegociaMoratoriosMAVI             
                    SET NotaCredBonId = @IDCxc            
                  WHERE IDCobro = @ID              
					AND Origen = @Origen AND OrigenId = @OrigenID  AND IDContadoComercial = @IdPol             
               END              
             END            
           END  -- 7            
           FETCH NEXT FROM crDetNCBonif INTO @Mov, @MovID, @ImpDocto            
         END -- 6            
         CLOSE crDetNCBonif            
         DEALLOCATE crDetNCBonif            
                   
         ---SELECT @Impuestos = SUM(d.Importe*isnull(ca.IVAFiscal,1.00))--, sum(d.Importe-(d.Importe*ca.IVAFiscal)) --d.Aplica, d.AplicaID, ca.Mov, ca.MovID, ca.Saldo, ca.IVAFiscal,  ca.Saldo*ca.IVAFiscal            
        SELECT @Impuestos = SUM(d.Importe*isnull(ca.IVAFiscal,0.00))                 
           FROM CXCD d            
           JOIN CxcAplica ca ON d.Aplica = ca.Mov AND d.AplicaID = ca.MovID AND ca.Empresa = @Empresa            
          WHERE d.ID = @IDCxc            
            
         SELECT @TotalMov = SUM(d.Importe-isnull(d.Importe*ca.IVAFiscal,0))---- SUM(d.Importe-(d.Importe*ca.IVAFiscal)) --d.Aplica, d.AplicaID, ca.Mov, ca.MovID, ca.Saldo, ca.IVAFiscal,  ca.Saldo*ca.IVAFiscal            
           FROM CXCD d            
           JOIN CxcAplica ca ON d.Aplica = ca.Mov AND d.AplicaID = ca.MovID AND ca.Empresa = @Empresa            
          WHERE d.ID = @IDCxc            
        
        UPDATE CXC        
           SET Importe = isnull(ROUND(@TotalMov,2),0.00),         
               Impuestos = isnull(ROUND(@Impuestos,2),0.00),        
               Saldo = isnull(ROUND(@TotalMov,2),0.00) + isnull(ROUND(@impuestos,2),0.00),        
               IDCobroBonifMAVI = @ID        
         WHERE ID = @IDCxc        
                
      END -- 5            
 -- ELSE            
   --    BEGIN            
         /*SELECT @Impuestos = SUM(d.Importe*ca.IVAFiscal)--, sum(d.Importe-(d.Importe*ca.IVAFiscal)) --d.Aplica, d.AplicaID, ca.Mov, ca.MovID, ca.Saldo, ca.IVAFiscal,  ca.Saldo*ca.IVAFiscal            
           FROM CXCD d            
           JOIN CxcAplica ca ON d.Aplica = ca.Mov AND d.AplicaID = ca.MovID AND ca.Empresa = @Empresa            
          WHERE d.ID = @IDCxc            
*/     
        /* UPDATE CXC SET AplicaManual = 0 WHERE id = @IDCxc            
         UPDATE CXC SET Importe = @ContadoComercial            
          WHERE ID = @IDCxc            
            
         ---SELECT @Impuestos = SUM(d.Importe*ca.IVAFiscal)--, sum(d.Importe-(d.Importe*ca.IVAFiscal)) --d.Aplica, d.AplicaID, ca.Mov, ca.MovID, ca.Saldo, ca.IVAFiscal,  ca.Saldo*ca.IVAFiscal            
         SELECT @Impuestos = SUM(d.Importe*isnull(ca.IVAFiscal,0.00))       
           FROM CXC d            
           JOIN CxcAplica ca ON d.Mov = ca.Mov AND d.MovID = ca.MovID AND ca.Empresa = @Empresa            
          WHERE d.ID = @IDCxc            
            
          --select * from CxcAplica            
         SELECT @TotalMov = SUM(ISNULL(d.Importe,0)-(ISNULL(d.Importe,0)*ISNULL(ca.IVAFiscal,0))) --d.Aplica, d.AplicaID, ca.Mov, ca.MovID, ca.Saldo, ca.IVAFiscal,  ca.Saldo*ca.IVAFiscal            
           FROM CXC d            
           JOIN CxcAplica ca ON d.Mov = ca.Mov AND d.MovID = ca.MovID AND ca.Empresa = @Empresa            
          WHERE d.ID = @IDCxc            
                
         UPDATE CXC            
            SET Importe = ROUND(@TotalMov,2),             
                Impuestos = ROUND(@Impuestos,2),            
                Saldo = ROUND(@TotalMov,2) + ROUND(@impuestos,2),            
                IDCobroBonifMAVI = @ID            
          WHERE ID = @IDCxc                          
            
       END*/            
     -- END -- 5              
       -- aki      
      IF @IDCxc > 0            
      BEGIN  -- aa       
        EXEC spAfectar 'CXC', @IDCxc, 'AFECTAR', 'Todo', NULL, @Usuario,  NULL, 1, @Ok OUTPUT, @OkRef OUTPUT,NULL, @Conexion =1  --1 dentro de trans            
        --select @OK as 'Ok NCred'  -- yrg            
        --select @OKRef as 'OkRef NCred'  -- yrg            
        --select @IDCxc as 'IDYani'  -- yrg            
        INSERT INTO DetalleAfectacionMAVI( IDCobro, ID, Mov, MovID, ValorOK, ValorOKRef) VALUES(@ID, @IDCxc, @MovCrear, NULL, @Ok, @OkRef )             
      END  -- aa
      IF @ImpTotalBonif > 0  -- Aun sobra bonificacion        
      BEGIN      -- bb  
          SELECT @DefImpuesto = DefImpuesto FROM EmpresaGral WHERE Empresa = @Empresa        
          INSERT INTO Cxc(Empresa, Mov, MovID, FechaEmision, UltimoCambio, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Autorizacion, Referencia, DocFuente,         
                             Observaciones, Estatus, Situacion, SituacionFecha, SituacionUsuario, SituacionNota, Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio,   -- 2        
                Cobrador, Condicion, Vencimiento, FormaCobro, CtaDinero, Importe, Impuestos, Retencion, AplicaManual, ConDesglose, FormaCobro1, FormaCobro2,         
                FormaCobro3, FormaCobro4, FormaCobro5, Referencia1, Referencia2, Referencia3, Referencia4, Referencia5, Importe1, Importe2, Importe3,   --4        
                Importe4, Importe5, Cambio, DelEfectivo, Agente, ComisionTotal, ComisionPendiente, MovAplica, MovAplicaID, OrigenTipo, Origen, OrigenID,         
                Poliza, PolizaID, FechaConclusion, FechaCancelacion, Dinero, DineroID, DineroCtaDinero, ConTramites, VIN, Sucursal, SucursalOrigen, Cajero,         
                UEN, PersonalCobrador, FechaOriginal, Nota, Comentarios, LineaCredito, TipoAmortizacion, TipoTasa, Amortizaciones, Comisiones, ComisionesIVA,         
                FechaRevision, ContUso, TieneTasaEsp, TasaEsp, Codigo)        
          VALUES (@Empresa, @MovCrear, NULL, cast(convert(varchar, @FechaAplicacion, 101) as datetime), @FechaAplicacion, @Concepto, NULL, @Moneda, @TipoCambio, @Usuario, NULL, @Referencia, NULL, --1        
                           NULL, 'SINAFECTAR', NULL, NULL, NULL, NULL, @Contacto, @CanalVenta, @Moneda, @TipoCambio,   --2        
                          NULL, NULL, @FechaAplicacion, NULL, @CtaDinero, NULL, NULL, NULL, 0, 0, NULL, NULL,   -- 3        
                          NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,  -- 4        
                          NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -- 5        
                          NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, @Sucursal, @Sucursal, NULL,         
                          @UEN, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL,         
                          NULL, NULL, 0, NULL, NULL)  -- 7        
        
          SELECT @IDCxc2 = @@IDENTITY        
        
          UPDATE CXC        
             SET Importe = ROUND(@ImpTotalBonif/ (1+@DefImpuesto/100.0), 2),        
                 Impuestos = ROUND(@ImpTotalBonif/ (1+@DefImpuesto/100.0), 2)*(@DefImpuesto/100.0),       
                 Saldo = ROUND(@ImpTotalBonif/ (1+@DefImpuesto/100.0), 2) + ROUND(@ImpTotalBonif/ (1+@DefImpuesto/100.0), 2)*(@DefImpuesto/100.0),        
           --select Importe = ROUND(1000/1.15,2)        
           --select Impuesto = ROUND(1000/1.15*(15/100.0),2)        
                 IDCobroBonifMAVI = @ID        
           WHERE ID = @IDCxc2        
        
          EXEC spAfectar 'CXC', @IDCxc2, 'AFECTAR', 'Todo', NULL, @Usuario,  NULL, 1, @Ok OUTPUT, @OkRef OUTPUT,NULL, @Conexion = 1   --1 dentro de trans        
                
          INSERT INTO DetalleAfectacionMAVI( IDCobro, ID, Mov, MovID, ValorOK, ValorOKRef) VALUES(@ID, @IDCxc2, @MovCrear, NULL, @Ok, @OkRef )         
        END  -- bb      
      --END            
        
    END  -- 3            
    FETCH NEXT FROM crGenBonif INTO @ContadoComercial, @Origen, @OrigenID, @IdPol            
  END -- 2                
  CLOSE crGenBonif            
  DEALLOCATE crGenBonif            
                      
END
GO

/************************ spGeneraNCredAPMAVI *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spGeneraNCredAPMAVI') AND type = 'P') DROP PROCEDURE dbo.spGeneraNCredAPMAVI
GO
Create PROCEDURE dbo.spGeneraNCredAPMAVI
      @ID   int,      
      @Usuario varchar(10),      
      @Ok         int                OUTPUT,      
   @OkRef      varchar(255)       OUTPUT                
--//WITH ENCRYPTION       
AS BEGIN      
  DECLARE      
    @Empresa   char(5),      
    @Sucursal   int,      
    @Hoy   datetime,      
    @Vencimiento  datetime,      
    @Moneda   char(10),      
    @TipoCambio   float,      
    @Contacto   char(10),      
    @Renglon   float,      
    @Aplica   varchar(20),      
    @AplicaID   varchar(20),         
 @ImpReal    money,      
 @MoratorioAPagar  money,      
    @Origen    varchar(20),      
    @OrigenID   varchar(20),      
          
    @MovPadre   varchar(20),      
    @MovPadre1   varchar(20),      
    @MovIDPadre   varchar(20),      
    @AdelantoPagos  money,      
    @UEN    int,      
 @MovCrear   varchar(20),      
    @Mov    varchar(20),      
    @IDCxc    int,      
    @FechaAplicacion datetime,      
    @CtaDinero   varchar(10),      
    @Concepto   varchar(50),      
 @IDPol    int,      
    @NumDoctos   int,      
    @ImpDocto   money,      
 --@Mov    varchar(20),      
    @MovID    varchar(20),      
    @TotalMov   money,      
    --@Ok     int,       
    --@OkRef    varchar(255),      
    @Referencia   varchar(100),      
 @CanalVenta   int,      
    @Impuestos   money,      
 @SdoDoc   money,          
    @ImpTotalBonif  money,      
    @DefImpuesto  float,      
    @IDCxc2 int,  
 @HayNotasCredCanc    int  
      
  SET @FechaAplicacion = GetDate()      
  SELECT @Empresa = Empresa, @Sucursal = Sucursal, @Hoy = FechaEmision, @Moneda = Moneda, @TipoCambio = TipoCambio, @Contacto = Cliente   FROM Cxc WHERE ID = @ID       
  -- OJO es importante tomar el concepto de cada politica      
  SELECT @HayNotasCredCanc = COUNT(*) FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID AND AdelantoPagos > 0 AND NotaCreditoxCanc = '1'  
  IF @HayNotasCredCanc = 0  
  BEGIN  
    DECLARE crGenBonifAP CURSOR FOR      
     SELECT SUM(ISNULL(AdelantoPagos,0)), Origen, OrigenId, IDAdelantoPagos      
       FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID  AND AdelantoPagos > 0        
      GROUP BY Origen, OrigenId, IDAdelantoPagos      
    OPEN crGenBonifAP      
    FETCH NEXT FROM crGenBonifAP INTO @AdelantoPagos, @Origen, @OrigenID, @IdPol      
    WHILE @@FETCH_STATUS <> -1       
    BEGIN  -- 2      
      IF @@FETCH_STATUS <> -2       
      BEGIN  -- 3      
        SET @Renglon = 1024.0       
        SET @ImpTotalBonif = @AdelantoPagos         
        SELECT @UEN = UEN, @CanalVenta = ClienteEnviarA  FROM CXC WHERE Mov = @Origen AND MovId = @OrigenID       
      
        SELECT @MovPadre = @Origen       
        SELECT @MovCrear = ISNULL(MovCrear, 'Nota Credito')  FROM MovCrearBonifMAVI WHERE Mov = @Movpadre AND UEN = @UEN      
         
        IF @MovCrear IS NULL SELECT @MovCrear = 'Nota Credito'               
                       
        SELECT @Concepto = Concepto      
          FROM MaviBonificacionConf where ID = @IDPol                   
       
        INSERT INTO Cxc(Empresa, Mov, MovID, FechaEmision, UltimoCambio, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Autorizacion, Referencia, DocFuente,       
                        Observaciones, Estatus, Situacion, SituacionFecha, SituacionUsuario, SituacionNota, Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio,   -- 2      
                        Cobrador, Condicion, Vencimiento, FormaCobro, CtaDinero, Importe, Impuestos, Retencion, AplicaManual, ConDesglose, FormaCobro1, FormaCobro2,       
                        FormaCobro3, FormaCobro4, FormaCobro5, Referencia1, Referencia2, Referencia3, Referencia4, Referencia5, Importe1, Importe2, Importe3,   --4      
                        Importe4, Importe5, Cambio, DelEfectivo, Agente, ComisionTotal, ComisionPendiente, MovAplica, MovAplicaID, OrigenTipo, Origen, OrigenID,       
                        Poliza, PolizaID, FechaConclusion, FechaCancelacion, Dinero, DineroID, DineroCtaDinero, ConTramites, VIN, Sucursal, SucursalOrigen, Cajero,       
                        UEN, PersonalCobrador, FechaOriginal, Nota, Comentarios, LineaCredito, TipoAmortizacion, TipoTasa, Amortizaciones, Comisiones, ComisionesIVA,       
                        FechaRevision, ContUso, TieneTasaEsp, TasaEsp, Codigo)      
                VALUES (@Empresa, @MovCrear, NULL, cast(convert(varchar, @FechaAplicacion, 101) as datetime), @FechaAplicacion, @Concepto, NULL, @Moneda, @TipoCambio, @Usuario, NULL, @Referencia, NULL, --1      
                        NULL, 'SINAFECTAR', NULL, NULL, NULL, NULL, @Contacto, @CanalVenta, @Moneda, @TipoCambio,   --2      
                        NULL, NULL, @FechaAplicacion, NULL, @CtaDinero, NULL, NULL, NULL, 1, 0, NULL, NULL,   -- 3      
                        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,  -- 4      
                        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -- 5      
                        NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, @Sucursal, @Sucursal, NULL,       
                        @UEN, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL,       
                        NULL, NULL, 0, NULL, NULL)  -- 7      
      
        SELECT @IDCxc = @@IDENTITY      
      
        --SELECT @IDCxc as 'Nota Cred'   -- yrg      
        -- Cursor para el detalle de la NCred      
        DECLARE crDetNCBonifAP CURSOR FOR      
         SELECT Mov, MovID, AdelantoPagos       
           FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID AND AdelantoPagos > 0        
            AND Origen = @Origen AND OrigenId = @OrigenID       
        OPEN crDetNCBonifAP      
        FETCH NEXT FROM crDetNCBonifAP INTO @Mov, @MovID, @ImpDocto      
        WHILE @@FETCH_STATUS <> -1       
        BEGIN  -- 2      
          IF @@FETCH_STATUS <> -2  AND @ImpTotalBonif > 0          
          BEGIN  -- 3      
                  
            SELECT @SdoDoc = Saldo FROM CXC WHERE Mov = @Mov AND MovId = @MovId          
      
            IF @ImpDocto > @SdoDoc-- 8          
            BEGIN          
      
              SELECT @ImpDocto = @SdoDoc          
              -- SELECT @ImpDocto as 'ImpNotaCred'          
              SET @ImpTotalBonif = @ImpTotalBonif - @ImpDocto          
      
              INSERT INTO CxcD(ID, Renglon, RenglonSub, Aplica, AplicaID, Importe, Fecha, Sucursal, SucursalOrigen, DescuentoRecargos, InteresesOrdinarios,       
                               InteresesMoratorios, InteresesOrdinariosQuita, InteresesMoratoriosQuita, ImpuestoAdicional, Retencion)      
              VALUES(@IDCxc, @Renglon, 0, @Mov, @MovId, @ImpDocto, NULL, @Sucursal, @Sucursal, NULL, NULL, NULL, NULL, NULL, NULL, NULL)      
      
              SET @Renglon = @Renglon + 1024.0      
                  
              UPDATE NegociaMoratoriosMAVI       
                 SET NotaCredBonId = @IDCxc      
               WHERE IDCobro = @ID        
                 AND Origen = @Origen AND OrigenId = @OrigenID  AND IDNoAtraso = @IdPol       
      
            END -- 8          
            ELSE          
            BEGIN          
                         
              IF @ImpDocto <= @SdoDoc --           
              BEGIN          
                SET @ImpTotalBonif = @ImpTotalBonif - @ImpDocto          
                INSERT INTO CxcD(ID, Renglon, RenglonSub, Aplica, AplicaID, Importe, Fecha, Sucursal, SucursalOrigen, DescuentoRecargos, InteresesOrdinarios,           
                                 InteresesMoratorios, InteresesOrdinariosQuita, InteresesMoratoriosQuita, ImpuestoAdicional, Retencion)          
                VALUES(@IDCxc, @Renglon, 0, @Mov, @MovId, @ImpDocto, NULL, @Sucursal, @Sucursal, NULL, NULL, NULL, NULL, NULL, NULL, NULL)          
          
                SET @Renglon = @Renglon + 1024.0          
                      
                UPDATE NegociaMoratoriosMAVI           
                   SET NotaCredBonId = @IDCxc          
                 WHERE IDCobro = @ID            
                   AND Origen = @Origen AND OrigenId = @OrigenID  AND IDNoAtraso = @IdPol           
              END            
            END          
          END      
          FETCH NEXT FROM crDetNCBonifAP INTO @Mov, @MovID, @ImpDocto      
        END       
        CLOSE crDetNCBonifAP      
        DEALLOCATE crDetNCBonifAP        
              
        -----SELECT @Impuestos = SUM(d.Importe*ca.IVAFiscal)--, sum(d.Importe-(d.Importe*ca.IVAFiscal)) --d.Aplica, d.AplicaID, ca.Mov, ca.MovID, ca.Saldo, ca.IVAFiscal,  ca.Saldo*ca.IVAFiscal      
        SELECT @Impuestos = SUM(d.Importe*isnull(ca.IVAFiscal,1.00))              
          FROM CXCD d      
          JOIN CxcAplica ca ON d.Aplica = ca.Mov AND d.AplicaID = ca.MovID AND ca.Empresa = @Empresa      
         WHERE d.ID = @IDCxc      
      
        SELECT @TotalMov = SUM(d.Importe-isnull(d.Importe*ca.IVAFiscal,0))----  SUM(d.Importe-(d.Importe*ca.IVAFiscal)) --d.Aplica, d.AplicaID, ca.Mov, ca.MovID, ca.Saldo, ca.IVAFiscal,  ca.Saldo*ca.IVAFiscal      
          FROM CXCD d      
          JOIN CxcAplica ca ON d.Aplica = ca.Mov AND d.AplicaID = ca.MovID AND ca.Empresa = @Empresa      
         WHERE d.ID = @IDCxc      
      
        UPDATE CXC      
           SET Importe = isnull(ROUND(@TotalMov,2),0.00),       
               Impuestos = isnull(ROUND(@Impuestos,2),0.00),      
               Saldo = isnull(ROUND(@TotalMov,2),0.00) + isnull(ROUND(@impuestos,2),0.00),      
               IDCobroBonifMAVI = @ID      
         WHERE ID = @IDCxc      
      
        --select @TotalMov as 'TotalMov'  -- yrg      
        -- Afectar el Cobro      
          
        EXEC spAfectar 'CXC', @IDCxc, 'AFECTAR', 'Todo', NULL, @Usuario,  NULL, 1, @Ok OUTPUT, @OkRef OUTPUT,NULL, @Conexion = 1   --1 dentro de trans      
        --select @OK as 'Ok NCred'      
        --select @OKRef as 'OkRef NCred'      
        INSERT INTO DetalleAfectacionMAVI( IDCobro, ID, Mov, MovID, ValorOK, ValorOKRef) VALUES(@ID, @IDCxc, @MovCrear, NULL, @Ok, @OkRef )       
      
        IF @ImpTotalBonif > 0  -- Aun sobra bonificacion      
        BEGIN      
          SELECT @DefImpuesto = DefImpuesto FROM EmpresaGral WHERE Empresa = @Empresa      
          INSERT INTO Cxc(Empresa, Mov, MovID, FechaEmision, UltimoCambio, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Autorizacion, Referencia, DocFuente,       
                   Observaciones, Estatus, Situacion, SituacionFecha, SituacionUsuario, SituacionNota, Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio,   -- 2      
            Cobrador, Condicion, Vencimiento, FormaCobro, CtaDinero, Importe, Impuestos, Retencion, AplicaManual, ConDesglose, FormaCobro1, FormaCobro2,       
         FormaCobro3, FormaCobro4, FormaCobro5, Referencia1, Referencia2, Referencia3, Referencia4, Referencia5, Importe1, Importe2, Importe3,   --4      
            Importe4, Importe5, Cambio, DelEfectivo, Agente, ComisionTotal, ComisionPendiente, MovAplica, MovAplicaID, OrigenTipo, Origen, OrigenID,       
            Poliza, PolizaID, FechaConclusion, FechaCancelacion, Dinero, DineroID, DineroCtaDinero, ConTramites, VIN, Sucursal, SucursalOrigen, Cajero,       
            UEN, PersonalCobrador, FechaOriginal, Nota, Comentarios, LineaCredito, TipoAmortizacion, TipoTasa, Amortizaciones, Comisiones, ComisionesIVA,       
            FechaRevision, ContUso, TieneTasaEsp, TasaEsp, Codigo)      
          VALUES (@Empresa, @MovCrear, NULL, cast(convert(varchar, @FechaAplicacion, 101) as datetime), @FechaAplicacion, @Concepto, NULL, @Moneda, @TipoCambio, @Usuario, NULL, @Referencia, NULL, --1      
                          NULL, 'SINAFECTAR', NULL, NULL, NULL, NULL, @Contacto, @CanalVenta, @Moneda, @TipoCambio,   --2      
                          NULL, NULL, @FechaAplicacion, NULL, @CtaDinero, NULL, NULL, NULL, 0, 0, NULL, NULL,   -- 3      
                          NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,  -- 4      
                          NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -- 5      
                          NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, @Sucursal, @Sucursal, NULL,       
                          @UEN, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL,       
                          NULL, NULL, 0, NULL, NULL)  -- 7      
      
          SELECT @IDCxc2 = @@IDENTITY      
                
          UPDATE CXC      
             SET Importe = ROUND(@ImpTotalBonif/ (1+@DefImpuesto/100.0), 2),      
                 Impuestos = ROUND(@ImpTotalBonif/ (1+@DefImpuesto/100.0), 2)*(@DefImpuesto/100.0),      
                 Saldo = ROUND(@ImpTotalBonif/ (1+@DefImpuesto/100.0), 2) + ROUND(@ImpTotalBonif/ (1+@DefImpuesto/100.0), 2)*(@DefImpuesto/100.0),      
                 IDCobroBonifMAVI = @ID      
           WHERE ID = @IDCxc2      
          EXEC spAfectar 'CXC', @IDCxc2, 'AFECTAR', 'Todo', NULL, @Usuario,  NULL, 1, @Ok OUTPUT, @OkRef OUTPUT,NULL, @Conexion = 1   --1 dentro de trans      
              
          INSERT INTO DetalleAfectacionMAVI( IDCobro, ID, Mov, MovID, ValorOK, ValorOKRef) VALUES(@ID, @IDCxc2, @MovCrear, NULL, @Ok, @OkRef )       
        END      
      END  -- 3      
              
      FETCH NEXT FROM crGenBonifAP INTO @AdelantoPagos, @Origen, @OrigenID, @IdPol      
    END -- 2          
    CLOSE crGenBonifAP      
    DEALLOCATE crGenBonifAP      
  END  
  ELSE  -- Notas de cred > 0  
  BEGIN  
    DECLARE crGenBonifAP CURSOR FOR      
     SELECT SUM(ISNULL(AdelantoPagos,0)), Origen, OrigenId, IDAdelantoPagos      
       FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID  AND AdelantoPagos > 0 AND NotaCreditoxCanc = '1'      
      GROUP BY Origen, OrigenId, IDAdelantoPagos      
    OPEN crGenBonifAP      
    FETCH NEXT FROM crGenBonifAP INTO @AdelantoPagos, @Origen, @OrigenID, @IdPol      
    WHILE @@FETCH_STATUS <> -1       
    BEGIN  -- 2      
      IF @@FETCH_STATUS <> -2       
      BEGIN  -- 3      
        SET @Renglon = 1024.0       
        SET @ImpTotalBonif = @AdelantoPagos         
        SELECT @UEN = UEN, @CanalVenta = ClienteEnviarA  FROM CXC WHERE Mov = @Origen AND MovId = @OrigenID       
      
        SELECT @MovPadre = @Origen       
        SELECT @MovCrear = ISNULL(MovCrear, 'Nota Credito')  FROM MovCrearBonifMAVI WHERE Mov = @Movpadre AND UEN = @UEN      
            
        IF @MovPadre = 'Credilana' SET @MovCrear = 'Nota Credito'  
        IF @MovPadre = 'Prestamo Personal' SET @MovCrear = 'Nota Credito VIU'  
        IF @MovCrear IS NULL SELECT @MovCrear = 'Nota Credito'               
                       
    SELECT @Concepto = Concepto      
          FROM MaviBonificacionConf where ID = @IDPol                   
       
        INSERT INTO Cxc(Empresa, Mov, MovID, FechaEmision, UltimoCambio, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Autorizacion, Referencia, DocFuente,       
                        Observaciones, Estatus, Situacion, SituacionFecha, SituacionUsuario, SituacionNota, Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio,   -- 2      
                        Cobrador, Condicion, Vencimiento, FormaCobro, CtaDinero, Importe, Impuestos, Retencion, AplicaManual, ConDesglose, FormaCobro1, FormaCobro2,       
                        FormaCobro3, FormaCobro4, FormaCobro5, Referencia1, Referencia2, Referencia3, Referencia4, Referencia5, Importe1, Importe2, Importe3,   --4      
                        Importe4, Importe5, Cambio, DelEfectivo, Agente, ComisionTotal, ComisionPendiente, MovAplica, MovAplicaID, OrigenTipo, Origen, OrigenID,       
                        Poliza, PolizaID, FechaConclusion, FechaCancelacion, Dinero, DineroID, DineroCtaDinero, ConTramites, VIN, Sucursal, SucursalOrigen, Cajero,       
                        UEN, PersonalCobrador, FechaOriginal, Nota, Comentarios, LineaCredito, TipoAmortizacion, TipoTasa, Amortizaciones, Comisiones, ComisionesIVA,       
                        FechaRevision, ContUso, TieneTasaEsp, TasaEsp, Codigo)      
                VALUES (@Empresa, @MovCrear, NULL, cast(convert(varchar, @FechaAplicacion, 101) as datetime), @FechaAplicacion, @Concepto, NULL, @Moneda, @TipoCambio, @Usuario, NULL, @Referencia, NULL, --1      
                        NULL, 'SINAFECTAR', NULL, NULL, NULL, NULL, @Contacto, @CanalVenta, @Moneda, @TipoCambio,   --2      
                        NULL, NULL, @FechaAplicacion, NULL, @CtaDinero, NULL, NULL, NULL, 1, 0, NULL, NULL,   -- 3      
                        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,  -- 4      
                        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -- 5      
                        NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, @Sucursal, @Sucursal, NULL,       
                        @UEN, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL,       
                        NULL, NULL, 0, NULL, NULL)  -- 7      
      
        SELECT @IDCxc = @@IDENTITY      
      
        --SELECT @IDCxc as 'Nota Cred'   -- yrg      
        -- Cursor para el detalle de la NCred      
        DECLARE crDetNCBonifAP CURSOR FOR      
         SELECT Mov, MovID, AdelantoPagos       
           FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID AND AdelantoPagos > 0  AND NotaCreditoxCanc = '1'          
            AND Origen = @Origen AND OrigenId = @OrigenID       
        OPEN crDetNCBonifAP      
        FETCH NEXT FROM crDetNCBonifAP INTO @Mov, @MovID, @ImpDocto      
        WHILE @@FETCH_STATUS <> -1       
        BEGIN  -- 2      
          IF @@FETCH_STATUS <> -2  AND @ImpTotalBonif > 0          
          BEGIN  -- 3      
                  
            SELECT @SdoDoc = Saldo FROM CXC WHERE Mov = @Mov AND MovId = @MovId          
      
            IF @ImpDocto > @SdoDoc-- 8          
            BEGIN          
      
              SELECT @ImpDocto = @SdoDoc          
              -- SELECT @ImpDocto as 'ImpNotaCred'          
              SET @ImpTotalBonif = @ImpTotalBonif - @ImpDocto          
      
              INSERT INTO CxcD(ID, Renglon, RenglonSub, Aplica, AplicaID, Importe, Fecha, Sucursal, SucursalOrigen, DescuentoRecargos, InteresesOrdinarios,       
                               InteresesMoratorios, InteresesOrdinariosQuita, InteresesMoratoriosQuita, ImpuestoAdicional, Retencion)      
              VALUES(@IDCxc, @Renglon, 0, @Mov, @MovId, @ImpDocto, NULL, @Sucursal, @Sucursal, NULL, NULL, NULL, NULL, NULL, NULL, NULL)      
      
              SET @Renglon = @Renglon + 1024.0      
                 
              UPDATE NegociaMoratoriosMAVI       
                 SET NotaCredBonId = @IDCxc      
               WHERE IDCobro = @ID        
                 AND Origen = @Origen AND OrigenId = @OrigenID  AND IDNoAtraso = @IdPol       
      
            END -- 8          
            ELSE          
            BEGIN          
                         
              IF @ImpDocto <= @SdoDoc --           
              BEGIN          
                SET @ImpTotalBonif = @ImpTotalBonif - @ImpDocto          
                INSERT INTO CxcD(ID, Renglon, RenglonSub, Aplica, AplicaID, Importe, Fecha, Sucursal, SucursalOrigen, DescuentoRecargos, InteresesOrdinarios,           
                                 InteresesMoratorios, InteresesOrdinariosQuita, InteresesMoratoriosQuita, ImpuestoAdicional, Retencion)          
                VALUES(@IDCxc, @Renglon, 0, @Mov, @MovId, @ImpDocto, NULL, @Sucursal, @Sucursal, NULL, NULL, NULL, NULL, NULL, NULL, NULL)          
          
                SET @Renglon = @Renglon + 1024.0          
                      
                UPDATE NegociaMoratoriosMAVI           
                   SET NotaCredBonId = @IDCxc          
                 WHERE IDCobro = @ID            
                   AND Origen = @Origen AND OrigenId = @OrigenID  AND IDNoAtraso = @IdPol           
              END            
            END          
          END      
          FETCH NEXT FROM crDetNCBonifAP INTO @Mov, @MovID, @ImpDocto      
        END       
        CLOSE crDetNCBonifAP      
        DEALLOCATE crDetNCBonifAP        
              
        -----SELECT @Impuestos = SUM(d.Importe*ca.IVAFiscal)--, sum(d.Importe-(d.Importe*ca.IVAFiscal)) --d.Aplica, d.AplicaID, ca.Mov, ca.MovID, ca.Saldo, ca.IVAFiscal,  ca.Saldo*ca.IVAFiscal      
        SELECT @Impuestos = SUM(d.Importe*isnull(ca.IVAFiscal,1.00))              
          FROM CXCD d      
          JOIN CxcAplica ca ON d.Aplica = ca.Mov AND d.AplicaID = ca.MovID AND ca.Empresa = @Empresa      
         WHERE d.ID = @IDCxc      
      
        SELECT @TotalMov = SUM(d.Importe-isnull(d.Importe*ca.IVAFiscal,0))----  SUM(d.Importe-(d.Importe*ca.IVAFiscal)) --d.Aplica, d.AplicaID, ca.Mov, ca.MovID, ca.Saldo, ca.IVAFiscal,  ca.Saldo*ca.IVAFiscal      
          FROM CXCD d      
          JOIN CxcAplica ca ON d.Aplica = ca.Mov AND d.AplicaID = ca.MovID AND ca.Empresa = @Empresa      
         WHERE d.ID = @IDCxc      
      
        UPDATE CXC      
           SET Importe = isnull(ROUND(@TotalMov,2),0.00),       
               Impuestos = isnull(ROUND(@Impuestos,2),0.00),      
               Saldo = isnull(ROUND(@TotalMov,2),0.00) + isnull(ROUND(@impuestos,2),0.00),      
               IDCobroBonifMAVI = @ID      
         WHERE ID = @IDCxc      
      
        --select @TotalMov as 'TotalMov'  -- yrg      
        -- Afectar el Cobro      
          
        EXEC spAfectar 'CXC', @IDCxc, 'AFECTAR', 'Todo', NULL, @Usuario,  NULL, 1, @Ok OUTPUT, @OkRef OUTPUT,NULL, @Conexion = 1   --1 dentro de trans      
        --select @OK as 'Ok NCred'      
        --select @OKRef as 'OkRef NCred'      
        INSERT INTO DetalleAfectacionMAVI( IDCobro, ID, Mov, MovID, ValorOK, ValorOKRef) VALUES(@ID, @IDCxc, @MovCrear, NULL, @Ok, @OkRef )       
      
       /* IF @ImpTotalBonif > 0  -- Aun sobra bonificacion      
        BEGIN      
          SELECT @DefImpuesto = DefImpuesto FROM EmpresaGral WHERE Empresa = @Empresa      
          INSERT INTO Cxc(Empresa, Mov, MovID, FechaEmision, UltimoCambio, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Autorizacion, Referencia, DocFuente,       
                   Observaciones, Estatus, Situacion, SituacionFecha, SituacionUsuario, SituacionNota, Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio,   -- 2      
            Cobrador, Condicion, Vencimiento, FormaCobro, CtaDinero, Importe, Impuestos, Retencion, AplicaManual, ConDesglose, FormaCobro1, FormaCobro2,       
            FormaCobro3, FormaCobro4, FormaCobro5, Referencia1, Referencia2, Referencia3, Referencia4, Referencia5, Importe1, Importe2, Importe3,   --4      
            Importe4, Importe5, Cambio, DelEfectivo, Agente, ComisionTotal, ComisionPendiente, MovAplica, MovAplicaID, OrigenTipo, Origen, OrigenID,       
            Poliza, PolizaID, FechaConclusion, FechaCancelacion, Dinero, DineroID, DineroCtaDinero, ConTramites, VIN, Sucursal, SucursalOrigen, Cajero,       
            UEN, PersonalCobrador, FechaOriginal, Nota, Comentarios, LineaCredito, TipoAmortizacion, TipoTasa, Amortizaciones, Comisiones, ComisionesIVA,       
            FechaRevision, ContUso, TieneTasaEsp, TasaEsp, Codigo)      
          VALUES (@Empresa, @MovCrear, NULL, cast(convert(varchar, @FechaAplicacion, 101) as datetime), @FechaAplicacion, @Concepto, NULL, @Moneda, @TipoCambio, @Usuario, NULL, @Referencia, NULL, --1      
                          NULL, 'SINAFECTAR', NULL, NULL, NULL, NULL, @Contacto, @CanalVenta, @Moneda, @TipoCambio,   --2      
                          NULL, NULL, @FechaAplicacion, NULL, @CtaDinero, NULL, NULL, NULL, 0, 0, NULL, NULL,   -- 3      
                          NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,  -- 4      
                          NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -- 5      
                          NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, @Sucursal, @Sucursal, NULL,       
                          @UEN, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL,       
                          NULL, NULL, 0, NULL, NULL)  -- 7      
      
          SELECT @IDCxc2 = @@IDENTITY      
                
          UPDATE CXC      
             SET Importe = ROUND(@ImpTotalBonif/ (1+@DefImpuesto/100.0), 2),      
                 Impuestos = ROUND(@ImpTotalBonif/ (1+@DefImpuesto/100.0), 2)*(@DefImpuesto/100.0),      
                 Saldo = ROUND(@ImpTotalBonif/ (1+@DefImpuesto/100.0), 2) + ROUND(@ImpTotalBonif/ (1+@DefImpuesto/100.0), 2)*(@DefImpuesto/100.0),      
                 IDCobroBonifMAVI = @ID      
           WHERE ID = @IDCxc2      
          EXEC spAfectar 'CXC', @IDCxc2, 'AFECTAR', 'Todo', NULL, @Usuario,  NULL, 1, @Ok OUTPUT, @OkRef OUTPUT,NULL, @Conexion = 1   --1 dentro de trans      
              
          INSERT INTO DetalleAfectacionMAVI( IDCobro, ID, Mov, MovID, ValorOK, ValorOKRef) VALUES(@ID, @IDCxc2, @MovCrear, NULL, @Ok, @OkRef )       
        END   */   
      END  -- 3      
              
      FETCH NEXT FROM crGenBonifAP INTO @AdelantoPagos, @Origen, @OrigenID, @IdPol      
    END -- 2          
    CLOSE crGenBonifAP      
    DEALLOCATE crGenBonifAP --   
    -- NCred normales y excedente  
    DECLARE crGenBonifAP2 CURSOR FOR      
     SELECT SUM(ISNULL(AdelantoPagos,0)), Origen, OrigenId, IDAdelantoPagos      
       FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID  AND AdelantoPagos > 0 AND NotaCreditoxCanc is null     
      GROUP BY Origen, OrigenId, IDAdelantoPagos      
    OPEN crGenBonifAP2      
    FETCH NEXT FROM crGenBonifAP2 INTO @AdelantoPagos, @Origen, @OrigenID, @IdPol      
    WHILE @@FETCH_STATUS <> -1       
    BEGIN  -- 2      
      IF @@FETCH_STATUS <> -2       
      BEGIN  -- 3      
        SET @Renglon = 1024.0       
        SET @ImpTotalBonif = @AdelantoPagos         
        SELECT @UEN = UEN, @CanalVenta = ClienteEnviarA  FROM CXC WHERE Mov = @Origen AND MovId = @OrigenID       
      
        SELECT @MovPadre = @Origen       
        SELECT @MovCrear = ISNULL(MovCrear, 'Nota Credito')  FROM MovCrearBonifMAVI WHERE Mov = @Movpadre AND UEN = @UEN                               
          
        IF @MovCrear IS NULL SELECT @MovCrear = 'Nota Credito'               
                       
        SELECT @Concepto = Concepto      
          FROM MaviBonificacionConf where ID = @IDPol                   
       
        INSERT INTO Cxc(Empresa, Mov, MovID, FechaEmision, UltimoCambio, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Autorizacion, Referencia, DocFuente,       
                        Observaciones, Estatus, Situacion, SituacionFecha, SituacionUsuario, SituacionNota, Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio,   -- 2      
                        Cobrador, Condicion, Vencimiento, FormaCobro, CtaDinero, Importe, Impuestos, Retencion, AplicaManual, ConDesglose, FormaCobro1, FormaCobro2,       
                        FormaCobro3, FormaCobro4, FormaCobro5, Referencia1, Referencia2, Referencia3, Referencia4, Referencia5, Importe1, Importe2, Importe3,   --4      
                        Importe4, Importe5, Cambio, DelEfectivo, Agente, ComisionTotal, ComisionPendiente, MovAplica, MovAplicaID, OrigenTipo, Origen, OrigenID,       
                        Poliza, PolizaID, FechaConclusion, FechaCancelacion, Dinero, DineroID, DineroCtaDinero, ConTramites, VIN, Sucursal, SucursalOrigen, Cajero,       
                        UEN, PersonalCobrador, FechaOriginal, Nota, Comentarios, LineaCredito, TipoAmortizacion, TipoTasa, Amortizaciones, Comisiones, ComisionesIVA,       
                        FechaRevision, ContUso, TieneTasaEsp, TasaEsp, Codigo)      
                VALUES (@Empresa, @MovCrear, NULL, cast(convert(varchar, @FechaAplicacion, 101) as datetime), @FechaAplicacion, @Concepto, NULL, @Moneda, @TipoCambio, @Usuario, NULL, @Referencia, NULL, --1      
                        NULL, 'SINAFECTAR', NULL, NULL, NULL, NULL, @Contacto, @CanalVenta, @Moneda, @TipoCambio,   --2      
                        NULL, NULL, @FechaAplicacion, NULL, @CtaDinero, NULL, NULL, NULL, 1, 0, NULL, NULL,   -- 3      
                        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,  -- 4      
                        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -- 5      
                        NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, @Sucursal, @Sucursal, NULL,       
                        @UEN, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL,       
                        NULL, NULL, 0, NULL, NULL)  -- 7      
      
        SELECT @IDCxc = @@IDENTITY      
      
        --SELECT @IDCxc as 'Nota Cred'   -- yrg      
        -- Cursor para el detalle de la NCred      
        DECLARE crDetNCBonifAP2 CURSOR FOR      
         SELECT Mov, MovID, AdelantoPagos       
           FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID AND AdelantoPagos > 0 AND NotaCreditoxCanc is null     
            AND Origen = @Origen AND OrigenId = @OrigenID       
        OPEN crDetNCBonifAP2      
        FETCH NEXT FROM crDetNCBonifAP2 INTO @Mov, @MovID, @ImpDocto      
        WHILE @@FETCH_STATUS <> -1       
        BEGIN  -- 2      
          IF @@FETCH_STATUS <> -2  AND @ImpTotalBonif > 0          
          BEGIN  -- 3      
                  
            SELECT @SdoDoc = Saldo FROM CXC WHERE Mov = @Mov AND MovId = @MovId          
      
            IF @ImpDocto > @SdoDoc-- 8          
            BEGIN          
      
              SELECT @ImpDocto = @SdoDoc          
              -- SELECT @ImpDocto as 'ImpNotaCred'          
              SET @ImpTotalBonif = @ImpTotalBonif - @ImpDocto          
      
              INSERT INTO CxcD(ID, Renglon, RenglonSub, Aplica, AplicaID, Importe, Fecha, Sucursal, SucursalOrigen, DescuentoRecargos, InteresesOrdinarios,       
                               InteresesMoratorios, InteresesOrdinariosQuita, InteresesMoratoriosQuita, ImpuestoAdicional, Retencion)      
              VALUES(@IDCxc, @Renglon, 0, @Mov, @MovId, @ImpDocto, NULL, @Sucursal, @Sucursal, NULL, NULL, NULL, NULL, NULL, NULL, NULL)      
      
              SET @Renglon = @Renglon + 1024.0      
                
              UPDATE NegociaMoratoriosMAVI       
                 SET NotaCredBonId = @IDCxc      
               WHERE IDCobro = @ID        
                 AND Origen = @Origen AND OrigenId = @OrigenID  AND IDNoAtraso = @IdPol       
      
            END -- 8          
            ELSE          
            BEGIN          
                         
              IF @ImpDocto <= @SdoDoc --           
              BEGIN          
                SET @ImpTotalBonif = @ImpTotalBonif - @ImpDocto          
                INSERT INTO CxcD(ID, Renglon, RenglonSub, Aplica, AplicaID, Importe, Fecha, Sucursal, SucursalOrigen, DescuentoRecargos, InteresesOrdinarios,           
                                 InteresesMoratorios, InteresesOrdinariosQuita, InteresesMoratoriosQuita, ImpuestoAdicional, Retencion)          
                VALUES(@IDCxc, @Renglon, 0, @Mov, @MovId, @ImpDocto, NULL, @Sucursal, @Sucursal, NULL, NULL, NULL, NULL, NULL, NULL, NULL)          
          
                SET @Renglon = @Renglon + 1024.0          
                      
                UPDATE NegociaMoratoriosMAVI           
                   SET NotaCredBonId = @IDCxc          
                 WHERE IDCobro = @ID            
                   AND Origen = @Origen AND OrigenId = @OrigenID  AND IDNoAtraso = @IdPol           
              END            
            END          
          END      
          FETCH NEXT FROM crDetNCBonifAP2 INTO @Mov, @MovID, @ImpDocto      
        END       
        CLOSE crDetNCBonifAP2      
        DEALLOCATE crDetNCBonifAP2        
              
        -----SELECT @Impuestos = SUM(d.Importe*ca.IVAFiscal)--, sum(d.Importe-(d.Importe*ca.IVAFiscal)) --d.Aplica, d.AplicaID, ca.Mov, ca.MovID, ca.Saldo, ca.IVAFiscal,  ca.Saldo*ca.IVAFiscal      
        SELECT @Impuestos = SUM(d.Importe*isnull(ca.IVAFiscal,1.00))              
          FROM CXCD d      
          JOIN CxcAplica ca ON d.Aplica = ca.Mov AND d.AplicaID = ca.MovID AND ca.Empresa = @Empresa      
         WHERE d.ID = @IDCxc      
      
        SELECT @TotalMov = SUM(d.Importe-isnull(d.Importe*ca.IVAFiscal,0))----  SUM(d.Importe-(d.Importe*ca.IVAFiscal)) --d.Aplica, d.AplicaID, ca.Mov, ca.MovID, ca.Saldo, ca.IVAFiscal,  ca.Saldo*ca.IVAFiscal      
          FROM CXCD d      
          JOIN CxcAplica ca ON d.Aplica = ca.Mov AND d.AplicaID = ca.MovID AND ca.Empresa = @Empresa      
         WHERE d.ID = @IDCxc      
      
        UPDATE CXC      
           SET Importe = isnull(ROUND(@TotalMov,2),0.00),       
               Impuestos = isnull(ROUND(@Impuestos,2),0.00),      
               Saldo = isnull(ROUND(@TotalMov,2),0.00) + isnull(ROUND(@impuestos,2),0.00),      
               IDCobroBonifMAVI = @ID      
         WHERE ID = @IDCxc      
      
        --select @TotalMov as 'TotalMov'  -- yrg      
        -- Afectar el Cobro      
          
        EXEC spAfectar 'CXC', @IDCxc, 'AFECTAR', 'Todo', NULL, @Usuario,  NULL, 1, @Ok OUTPUT, @OkRef OUTPUT,NULL, @Conexion = 1   --1 dentro de trans      
        --select @OK as 'Ok NCred'      
        --select @OKRef as 'OkRef NCred'      
        INSERT INTO DetalleAfectacionMAVI( IDCobro, ID, Mov, MovID, ValorOK, ValorOKRef) VALUES(@ID, @IDCxc, @MovCrear, NULL, @Ok, @OkRef )       
      
        IF @ImpTotalBonif > 0  -- Aun sobra bonificacion      
        BEGIN      
          SELECT @DefImpuesto = DefImpuesto FROM EmpresaGral WHERE Empresa = @Empresa      
          INSERT INTO Cxc(Empresa, Mov, MovID, FechaEmision, UltimoCambio, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Autorizacion, Referencia, DocFuente,       
                   Observaciones, Estatus, Situacion, SituacionFecha, SituacionUsuario, SituacionNota, Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio,   -- 2      
            Cobrador, Condicion, Vencimiento, FormaCobro, CtaDinero, Importe, Impuestos, Retencion, AplicaManual, ConDesglose, FormaCobro1, FormaCobro2,       
            FormaCobro3, FormaCobro4, FormaCobro5, Referencia1, Referencia2, Referencia3, Referencia4, Referencia5, Importe1, Importe2, Importe3,   --4      
            Importe4, Importe5, Cambio, DelEfectivo, Agente, ComisionTotal, ComisionPendiente, MovAplica, MovAplicaID, OrigenTipo, Origen, OrigenID,       
            Poliza, PolizaID, FechaConclusion, FechaCancelacion, Dinero, DineroID, DineroCtaDinero, ConTramites, VIN, Sucursal, SucursalOrigen, Cajero,       
            UEN, PersonalCobrador, FechaOriginal, Nota, Comentarios, LineaCredito, TipoAmortizacion, TipoTasa, Amortizaciones, Comisiones, ComisionesIVA,       
            FechaRevision, ContUso, TieneTasaEsp, TasaEsp, Codigo)      
          VALUES (@Empresa, @MovCrear, NULL, cast(convert(varchar, @FechaAplicacion, 101) as datetime), @FechaAplicacion, @Concepto, NULL, @Moneda, @TipoCambio, @Usuario, NULL, @Referencia, NULL, --1      
                          NULL, 'SINAFECTAR', NULL, NULL, NULL, NULL, @Contacto, @CanalVenta, @Moneda, @TipoCambio,   --2      
                    NULL, NULL, @FechaAplicacion, NULL, @CtaDinero, NULL, NULL, NULL, 0, 0, NULL, NULL,   -- 3      
                          NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,  -- 4      
                          NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -- 5      
                          NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, @Sucursal, @Sucursal, NULL,       
                          @UEN, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL,       
                          NULL, NULL, 0, NULL, NULL)  -- 7      
      
          SELECT @IDCxc2 = @@IDENTITY      
                
          UPDATE CXC      
             SET Importe = ROUND(@ImpTotalBonif/ (1+@DefImpuesto/100.0), 2),      
                 Impuestos = ROUND(@ImpTotalBonif/ (1+@DefImpuesto/100.0), 2)*(@DefImpuesto/100.0),      
                 Saldo = ROUND(@ImpTotalBonif/ (1+@DefImpuesto/100.0), 2) + ROUND(@ImpTotalBonif/ (1+@DefImpuesto/100.0), 2)*(@DefImpuesto/100.0),      
                 IDCobroBonifMAVI = @ID      
           WHERE ID = @IDCxc2      
          EXEC spAfectar 'CXC', @IDCxc2, 'AFECTAR', 'Todo', NULL, @Usuario,  NULL, 1, @Ok OUTPUT, @OkRef OUTPUT,NULL, @Conexion = 1   --1 dentro de trans      
              
          INSERT INTO DetalleAfectacionMAVI( IDCobro, ID, Mov, MovID, ValorOK, ValorOKRef) VALUES(@ID, @IDCxc2, @MovCrear, NULL, @Ok, @OkRef )       
        END     
      END  -- 3      
              
      FETCH NEXT FROM crGenBonifAP2 INTO @AdelantoPagos, @Origen, @OrigenID, @IdPol      
    END -- 2          
    CLOSE crGenBonifAP2      
    DEALLOCATE crGenBonifAP2 --   
  
  END    
END      
GO


/************************ spGeneraNCredNAMAVI *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spGeneraNCredNAMAVI') AND type = 'P') DROP PROCEDURE dbo.spGeneraNCredNAMAVI
GO
CREATE PROCEDURE [dbo].[spGeneraNCredNAMAVI]
      @ID         int,          
      @Usuario	  varchar(10),            
      @Ok         int                OUTPUT,          
      @OkRef      varchar(255)       OUTPUT                       
--//WITH ENCRYPTION     
AS BEGIN          
  DECLARE          
    @Empresa   char(5),          
    @Sucursal   int,          
    @Hoy   datetime,          
    @Vencimiento  datetime,          
    @Moneda   char(10),          
    @TipoCambio   float,          
    @Contacto   char(10),          
    @Renglon   float,          
    @Aplica   varchar(20),          
    @AplicaID   varchar(20),          
	@NoAtraso   money,             
	@ImpReal    money,          
	@MoratorioAPagar  money,          
    @Origen    varchar(20),          
    @OrigenID   varchar(20),                      
    @MovPadre   varchar(20),          
    @MovPadre1   varchar(20),          
    @MovIDPadre   varchar(20),          
    --@NoAtraso money,          
    @UEN    int,          
 @MovCrear   varchar(20),          
    @Mov    varchar(20),          
    @IDCxc    int,          
    @FechaAplicacion datetime,          
    @CtaDinero   varchar(10),          
    @Concepto   varchar(50),          
 @IDPol    int,          
    @NumDoctos   int,          
    @ImpDocto   money,          
 --@Mov    varchar(20),          
    @MovID    varchar(20),          
    @TotalMov   money,          
    --@Ok     int,           
    --@OkRef    varchar(255),          
    @Referencia   varchar(100),          
    @Impuestos   money,          
    @CanalVenta   int,          
 @DocsPend   int,          
 @SdoDoc   money,          
    @ImpTotalBonif  money,      
 @IDCxc2    int,      
 @DefImpuesto float,  
    @HayNotasCredCanc    int  
                 
  SET @DocsPend = 0          
  SET @FechaAplicacion = GetDate()          
  SELECT @Empresa = Empresa, @Sucursal = Sucursal, @Hoy = FechaEmision, @Moneda = Moneda, @TipoCambio = TipoCambio, @Contacto = Cliente   FROM Cxc WHERE ID = @ID           
  -- OJO es importante tomar el concepto de cada politica          
          
  SELECT @HayNotasCredCanc = COUNT(*) FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID AND NoAtraso > 0 AND NotaCreditoxCanc = '1'    
  IF @HayNotasCredCanc = 0    
  BEGIN -- 1   
  
    DECLARE crGenBonifNA CURSOR FOR       
     SELECT SUM(ISNULL(NoAtraso,0)), Origen, OrigenId, IDNoAtraso        
       FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID  AND NoAtraso > 0          
      GROUP BY Origen, OrigenId, IDNoAtraso                 
    OPEN crGenBonifNA          
    FETCH NEXT FROM crGenBonifNA INTO @NoAtraso, @Origen, @OrigenID, @IdPol          
    WHILE @@FETCH_STATUS <> -1           
    BEGIN  -- 2          
      IF @@FETCH_STATUS <> -2           
      BEGIN  -- 3          
        SET @ImpTotalBonif = @NoAtraso          
        SET @Renglon = 1024.0           
        SELECT @UEN = UEN, @CanalVenta = ClienteEnviarA FROM CXC WHERE Mov = @Origen AND MovId = @OrigenID           
          
        SELECT @MovPadre = @Origen           
        SELECT @MovCrear = ISNULL(MovCrear, 'Nota Credito')  FROM MovCrearBonifMAVI WHERE Mov = @Movpadre AND UEN = @UEN                  
             
        IF @MovCrear IS NULL SELECT @MovCrear = 'Nota Credito'                   
                   
        SELECT @Concepto = Concepto          
          FROM MaviBonificacionConf where ID = @IDPol     
        SELECT @DocsPend = Count(*) FROM CXC WHERE PadreMAVI = @Origen AND PadreIDMAVI = @OrigenID AND Estatus = 'PENDIENTE'          
        IF @DocsPend > 0          
        BEGIN  -- 5                       
           
          INSERT INTO Cxc(Empresa, Mov, MovID, FechaEmision, UltimoCambio, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Autorizacion, Referencia, DocFuente,           
                   Observaciones, Estatus, Situacion, SituacionFecha, SituacionUsuario, SituacionNota, Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio,   -- 2          
                        Cobrador, Condicion, Vencimiento, FormaCobro, CtaDinero, Importe, Impuestos, Retencion, AplicaManual, ConDesglose, FormaCobro1, FormaCobro2,           
                        FormaCobro3, FormaCobro4, FormaCobro5, Referencia1, Referencia2, Referencia3, Referencia4, Referencia5, Importe1, Importe2, Importe3,   --4          
                        Importe4, Importe5, Cambio, DelEfectivo, Agente, ComisionTotal, ComisionPendiente, MovAplica, MovAplicaID, OrigenTipo, Origen, OrigenID,           
                        Poliza, PolizaID, FechaConclusion, FechaCancelacion, Dinero, DineroID, DineroCtaDinero, ConTramites, VIN, Sucursal, SucursalOrigen, Cajero,           
                        UEN, PersonalCobrador, FechaOriginal, Nota, Comentarios, LineaCredito, TipoAmortizacion, TipoTasa, Amortizaciones, Comisiones, ComisionesIVA,           
                        FechaRevision, ContUso, TieneTasaEsp, TasaEsp, Codigo)          
          VALUES (@Empresa, @MovCrear, NULL, cast(convert(varchar, @FechaAplicacion, 101) as datetime), @FechaAplicacion, @Concepto, NULL, @Moneda, @TipoCambio, @Usuario, NULL, @Referencia, NULL, --1          
                        NULL, 'SINAFECTAR', NULL, NULL, NULL, NULL, @Contacto, @CanalVenta, @Moneda, @TipoCambio,   --2          
                        NULL, NULL, @FechaAplicacion, NULL, @CtaDinero, NULL, NULL, NULL, 1, 0, NULL, NULL,   -- 3          
                        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,  -- 4          
                        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -- 5          
                        NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, @Sucursal, @Sucursal, NULL,           
                        @UEN, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL,           
                        NULL, NULL, 0, NULL, NULL)  -- 7          
    
          SELECT @IDCxc = @@IDENTITY          
          
          -- Cursor para el detalle de la NCred          
          DECLARE crDetNCBonifNA CURSOR FOR          
           SELECT Mov, MovID, NoAtraso           
             FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID AND NoAtraso > 0            
              AND Origen = @Origen AND OrigenId = @OrigenID --AND IDNoAtraso = @IdPol          
          OPEN crDetNCBonifNA          
          FETCH NEXT FROM crDetNCBonifNA INTO @Mov, @MovID, @ImpDocto          
          WHILE @@FETCH_STATUS <> -1           
          BEGIN  -- 6          
            IF @@FETCH_STATUS <> -2 AND @ImpTotalBonif > 0          
            BEGIN  -- 7          
              -- Se verifica el sdo pendiente de cada doc contra el importe de la bonificación          
              SELECT @SdoDoc = Saldo FROM CXC WHERE Mov = @Mov AND MovId = @MovId          
              --OrigenTipo = 'CXC' AND Origen = @Origen AND OrigenId = @OrigenID AND Estatus = 'PENDIENTE'               
              IF @ImpDocto > @SdoDoc-- 8          
              BEGIN          
                
                SELECT @ImpDocto = @SdoDoc          
                -- SELECT @ImpDocto as 'ImpNotaCred'          
                SET @ImpTotalBonif = @ImpTotalBonif - @ImpDocto          
       INSERT INTO CxcD(ID, Renglon, RenglonSub, Aplica, AplicaID, Importe, Fecha, Sucursal, SucursalOrigen, DescuentoRecargos, InteresesOrdinarios,           
                     InteresesMoratorios, InteresesOrdinariosQuita, InteresesMoratoriosQuita, ImpuestoAdicional, Retencion)          
       VALUES(@IDCxc, @Renglon, 0, @Mov, @MovId, @ImpDocto, NULL, @Sucursal, @Sucursal, NULL, NULL, NULL, NULL, NULL, NULL, NULL)          
          
                SET @Renglon = @Renglon + 1024.0          
       
                UPDATE NegociaMoratoriosMAVI           
                   SET NotaCredBonId = @IDCxc          
                 WHERE IDCobro = @ID            
                  AND Origen = @Origen AND OrigenId = @OrigenID  AND IDNoAtraso = @IdPol           
 END -- 8          
              ELSE          
              BEGIN          
                
                IF @ImpDocto <= @SdoDoc --           
                BEGIN          
  
                  SET @ImpTotalBonif = @ImpTotalBonif - @ImpDocto          
                  INSERT INTO CxcD(ID, Renglon, RenglonSub, Aplica, AplicaID, Importe, Fecha, Sucursal, SucursalOrigen, DescuentoRecargos, InteresesOrdinarios,           
                                   InteresesMoratorios, InteresesOrdinariosQuita, InteresesMoratoriosQuita, ImpuestoAdicional, Retencion)          
                  VALUES(@IDCxc, @Renglon, 0, @Mov, @MovId, @ImpDocto, NULL, @Sucursal, @Sucursal, NULL, NULL, NULL, NULL, NULL, NULL, NULL)          
          
                  SET @Renglon = @Renglon + 1024.0          
                      
                  UPDATE NegociaMoratoriosMAVI           
                     SET NotaCredBonId = @IDCxc          
                   WHERE IDCobro = @ID            
                     AND Origen = @Origen AND OrigenId = @OrigenID  AND IDNoAtraso = @IdPol           
                END            
              END          
            END  -- 7          
            FETCH NEXT FROM crDetNCBonifNA INTO @Mov, @MovID, @ImpDocto          
          END -- 6          
          CLOSE crDetNCBonifNA          
          DEALLOCATE crDetNCBonifNA          
          
            SELECT @Impuestos = SUM(d.Importe*isnull(ca.IVAFiscal,0.00))               
              FROM CXCD d          
              JOIN CxcAplica ca ON d.Aplica = ca.Mov AND d.AplicaID = ca.MovID AND ca.Empresa = @Empresa          
             WHERE d.ID = @IDCxc          
          
            SELECT @TotalMov = SUM(d.Importe-isnull(d.Importe*ca.IVAFiscal,0))---- SUM(d.Importe-(d.Importe*ca.IVAFiscal)) --d.Aplica, d.AplicaID, ca.Mov, ca.MovID, ca.Saldo, ca.IVAFiscal,  ca.Saldo*ca.IVAFiscal          
              FROM CXCD d          
              JOIN CxcAplica ca ON d.Aplica = ca.Mov AND d.AplicaID = ca.MovID AND ca.Empresa = @Empresa          
             WHERE d.ID = @IDCxc          
      
            UPDATE CXC      
               SET Importe = isnull(ROUND(@TotalMov,2),0.00),       
                   Impuestos = isnull(ROUND(@Impuestos,2),0.00),      
                   Saldo = isnull(ROUND(@TotalMov,2),0.00) + isnull(ROUND(@impuestos,2),0.00),      
                   IDCobroBonifMAVI = @ID      
             WHERE ID = @IDCxc      
            
        END -- 5          
                  
        -- aki    
        IF @IDCxc > 0          
        BEGIN     -- aa  
          EXEC spAfectar 'CXC', @IDCxc, 'AFECTAR', 'Todo', NULL, @Usuario,  NULL, 1, @Ok OUTPUT, @OkRef OUTPUT,NULL, @Conexion =1  --1 dentro de trans          
          --select @OK as 'Ok NCred'  -- yrg          
          --select @OKRef as 'OkRef NCred'  -- yrg          
          --select @IDCxc as 'IDYani'  -- yrg          
          INSERT INTO DetalleAfectacionMAVI( IDCobro, ID, Mov, MovID, ValorOK, ValorOKRef) VALUES(@ID, @IDCxc, @MovCrear, NULL, @Ok, @OkRef )           
        END  -- aa
        IF @ImpTotalBonif > 0  -- Aun sobra bonificacion      
        BEGIN  -- bb    
            SELECT @DefImpuesto = DefImpuesto FROM EmpresaGral WHERE Empresa = @Empresa      
            INSERT INTO Cxc(Empresa, Mov, MovID, FechaEmision, UltimoCambio, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Autorizacion, Referencia, DocFuente,       
                             Observaciones, Estatus, Situacion, SituacionFecha, SituacionUsuario, SituacionNota, Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio,   -- 2      
                             Cobrador, Condicion, Vencimiento, FormaCobro, CtaDinero, Importe, Impuestos, Retencion, AplicaManual, ConDesglose, FormaCobro1, FormaCobro2,       
                             FormaCobro3, FormaCobro4, FormaCobro5, Referencia1, Referencia2, Referencia3, Referencia4, Referencia5, Importe1, Importe2, Importe3,   --4      
                             Importe4, Importe5, Cambio, DelEfectivo, Agente, ComisionTotal, ComisionPendiente, MovAplica, MovAplicaID, OrigenTipo, Origen, OrigenID,       
                             Poliza, PolizaID, FechaConclusion, FechaCancelacion, Dinero, DineroID, DineroCtaDinero, ConTramites, VIN, Sucursal, SucursalOrigen, Cajero,       
                             UEN, PersonalCobrador, FechaOriginal, Nota, Comentarios, LineaCredito, TipoAmortizacion, TipoTasa, Amortizaciones, Comisiones, ComisionesIVA,       
                             FechaRevision, ContUso, TieneTasaEsp, TasaEsp, Codigo)      
            VALUES (@Empresa, @MovCrear, NULL, cast(convert(varchar, @FechaAplicacion, 101) as datetime), @FechaAplicacion, @Concepto, NULL, @Moneda, @TipoCambio, @Usuario, NULL, @Referencia, NULL, --1      
                           NULL, 'SINAFECTAR', NULL, NULL, NULL, NULL, @Contacto, @CanalVenta, @Moneda, @TipoCambio,   --2      
                          NULL, NULL, @FechaAplicacion, NULL, @CtaDinero, NULL, NULL, NULL, 0, 0, NULL, NULL,   -- 3      
                          NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,  -- 4      
                          NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -- 5      
                          NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, @Sucursal, @Sucursal, NULL,       
                          @UEN, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL,       
                          NULL, NULL, 0, NULL, NULL)  -- 7      
      
            SELECT @IDCxc2 = @@IDENTITY      
      
            UPDATE CXC      
               SET Importe = ROUND(@ImpTotalBonif/ (1+@DefImpuesto/100.0), 2),      
                   Impuestos = ROUND(@ImpTotalBonif/ (1+@DefImpuesto/100.0), 2)*(@DefImpuesto/100.0),     
                   Saldo = ROUND(@ImpTotalBonif/ (1+@DefImpuesto/100.0), 2) + ROUND(@ImpTotalBonif/ (1+@DefImpuesto/100.0), 2)*(@DefImpuesto/100.0),      
                   --select Importe = ROUND(1000/1.15,2)      
                   --select Impuesto = ROUND(1000/1.15*(15/100.0),2)      
                   IDCobroBonifMAVI = @ID      
             WHERE ID = @IDCxc2      
      
            EXEC spAfectar 'CXC', @IDCxc2, 'AFECTAR', 'Todo', NULL, @Usuario,  NULL, 1, @Ok OUTPUT, @OkRef OUTPUT,NULL, @Conexion = 1   --1 dentro de trans      
              
            INSERT INTO DetalleAfectacionMAVI( IDCobro, ID, Mov, MovID, ValorOK, ValorOKRef) VALUES(@ID, @IDCxc2, @MovCrear, NULL, @Ok, @OkRef )       
        END    -- bb                
      END  -- 3          
      FETCH NEXT FROM crGenBonifNA INTO @NoAtraso, @Origen, @OrigenID, @IdPol          
    END -- 2              
    CLOSE crGenBonifNA          
    DEALLOCATE crGenBonifNA          
  END -- 1   
  ELSE    -- Hay Notas de cred x canc          
  BEGIN  -- 2  ADD GRB
    DECLARE crGenBonifPP CURSOR FOR                
     SELECT SUM(ISNULL(NoAtraso,0)), Origen, OrigenId, IDNoAtraso                
       FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID  AND NoAtraso > 0 AND NotaCreditoxCanc = '1'                 
      GROUP BY Origen, OrigenId, IDNoAtraso                
    OPEN crGenBonifPP                
    FETCH NEXT FROM crGenBonifPP INTO @NoAtraso, @Origen, @OrigenID, @IdPol                
    WHILE @@FETCH_STATUS <> -1                 
    BEGIN  -- 10                
      IF @@FETCH_STATUS <> -2                 
      BEGIN  -- 11               
        SET @Renglon = 1024.0                 
        SELECT @UEN = UEN, @CanalVenta = ClienteEnviarA FROM CXC WHERE Mov = @Origen AND MovId = @OrigenID                 
                
        SELECT @MovPadre = @Origen                 
        SELECT @MovCrear = ISNULL(MovCrear, 'Nota Credito')  FROM MovCrearBonifMAVI WHERE Mov = @Movpadre AND UEN = @UEN                
                        
        IF @MovPadre = 'Credilana' SET @MovCrear = 'Nota Credito'            
        IF @MovPadre = 'Prestamo Personal' SET @MovCrear = 'Nota Credito VIU'            
        IF @MovCrear IS NULL SELECT @MovCrear = 'Nota Credito'                                 
                        
        SELECT @Concepto = Concepto                
          FROM MaviBonificacionConf where ID = @IDPol                               
                 
        INSERT INTO Cxc(Empresa, Mov, MovID, FechaEmision, UltimoCambio, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Autorizacion, Referencia, DocFuente,                 
                        Observaciones, Estatus, Situacion, SituacionFecha, SituacionUsuario, SituacionNota, Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio,   -- 2                
                        Cobrador, Condicion, Vencimiento, FormaCobro, CtaDinero, Importe, Impuestos, Retencion, AplicaManual, ConDesglose, FormaCobro1, FormaCobro2,                 
                        FormaCobro3, FormaCobro4, FormaCobro5, Referencia1, Referencia2, Referencia3, Referencia4, Referencia5, Importe1, Importe2, Importe3,   --4                
                        Importe4, Importe5, Cambio, DelEfectivo, Agente, ComisionTotal, ComisionPendiente, MovAplica, MovAplicaID, OrigenTipo, Origen, OrigenID,                 
                        Poliza, PolizaID, FechaConclusion, FechaCancelacion, Dinero, DineroID, DineroCtaDinero, ConTramites, VIN, Sucursal, SucursalOrigen, Cajero,                 
                        UEN, PersonalCobrador, FechaOriginal, Nota, Comentarios, LineaCredito, TipoAmortizacion, TipoTasa, Amortizaciones, Comisiones, ComisionesIVA,                 
                        FechaRevision, ContUso, TieneTasaEsp, TasaEsp, Codigo)                
        VALUES (@Empresa, @MovCrear, NULL, cast(convert(varchar, @FechaAplicacion, 101) as datetime), @FechaAplicacion, @Concepto, NULL, @Moneda, @TipoCambio, @Usuario, NULL, @Referencia, NULL, --1                
                        NULL, 'SINAFECTAR', NULL, NULL, NULL, NULL, @Contacto, @CanalVenta, @Moneda, @TipoCambio,   --2                
                        NULL, NULL, cast(convert(varchar, @FechaAplicacion, 101) as datetime), NULL, @CtaDinero, NULL, NULL, NULL, 1, 0, NULL, NULL,   -- 3                
                        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,  -- 4                
                        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -- 5                
                        NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, @Sucursal, @Sucursal, NULL,                 
                        @UEN, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL,                 
                        NULL, NULL, 0, NULL, NULL)  -- 7                
                
     SELECT @IDCxc = @@IDENTITY                
                
        --SELECT @IDCxc as 'Nota Cred'   -- yrg                
        -- Cursor para el detalle de la NCred                
        DECLARE crDetNCBonifPP CURSOR FOR                
         SELECT Mov, MovID, NoAtraso                 
           FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID AND NoAtraso > 0  AND NotaCreditoxCanc = '1'                      
            AND Origen = @Origen AND OrigenId = @OrigenID --AND IDNoAtraso = @IdPol                
        OPEN crDetNCBonifPP                
        FETCH NEXT FROM crDetNCBonifPP INTO @Mov, @MovID, @ImpDocto                
        WHILE @@FETCH_STATUS <> -1                 
        BEGIN  -- 12                
          IF @@FETCH_STATUS <> -2                 
          BEGIN  -- 13                
            --insert cxcd                
            INSERT INTO CxcD(ID, Renglon, RenglonSub, Aplica, AplicaID, Importe, Fecha, Sucursal, SucursalOrigen, DescuentoRecargos, InteresesOrdinarios,                 
                             InteresesMoratorios, InteresesOrdinariosQuita, InteresesMoratoriosQuita, ImpuestoAdicional, Retencion)                
            VALUES(@IDCxc, @Renglon, 0, @Mov, @MovId, @ImpDocto, NULL, @Sucursal, @Sucursal, NULL, NULL, NULL, NULL, NULL, NULL, NULL)                
                
            SET @Renglon = @Renglon + 1024.0                
    
            UPDATE NegociaMoratoriosMAVI                 
               SET NotaCredBonId = @IDCxc                
             WHERE IDCobro = @ID                  
               AND Origen = @Origen AND OrigenId = @OrigenID  AND IDNoAtraso = @IdPol                 
          END   -- 13             
          FETCH NEXT FROM crDetNCBonifPP INTO @Mov, @MovID, @ImpDocto                
        END  -- 12               
        CLOSE crDetNCBonifPP                
        DEALLOCATE crDetNCBonifPP                
                
        SELECT @Impuestos = SUM(d.Importe*isnull(ca.IVAFiscal,0.00))                
          FROM CXCD d                
          JOIN CxcAplica ca ON d.Aplica = ca.Mov AND d.AplicaID = ca.MovID AND ca.Empresa = @Empresa                
         WHERE d.ID = @IDCxc                
                
        SELECT @TotalMov = SUM(d.Importe-isnull(d.Importe*ca.IVAFiscal,0)) --d.Aplica, d.AplicaID, ca.Mov, ca.MovID, ca.Saldo, ca.IVAFiscal,  ca.Saldo*ca.IVAFiscal                
          FROM CXCD d                
          JOIN CxcAplica ca ON d.Aplica = ca.Mov AND d.AplicaID = ca.MovID AND ca.Empresa = @Empresa                
         WHERE d.ID = @IDCxc                
                    
        UPDATE CXC                
           SET Importe = isnull(ROUND(@TotalMov,2),0.00),                 
               Impuestos = isnull(ROUND(@Impuestos,2),0.00),                
               Saldo = isnull(ROUND(@TotalMov,2),0.00) + isnull(ROUND(@impuestos,2),0.00),                
               IDCobroBonifMAVI = @ID                
         WHERE ID = @IDCxc                
                
        --select @TotalMov as 'TotalMov'  -- yrg                        
                    
        EXEC spAfectar 'CXC', @IDCxc, 'AFECTAR', 'Todo', NULL, @Usuario,  NULL, 1, @Ok OUTPUT, @OkRef OUTPUT,NULL, @Conexion = 1   --1 dentro de trans                
        --select @OK as 'Ok NCred'                
        --select @OKRef as 'OkRef NCred'                
        INSERT INTO DetalleAfectacionMAVI( IDCobro, ID, Mov, MovID, ValorOK, ValorOKRef) VALUES(@ID, @IDCxc, @MovCrear, NULL, @Ok, @OkRef )                        
                
        --        SELECT @Referencia = RTRIM(@Origen)+'_'+RTRIM(@OrigenID)                
                
      END  -- 10              
      FETCH NEXT FROM crGenBonifPP INTO @NoAtraso, @Origen, @OrigenID, @IdPol                

    END -- 2                    
    CLOSE crGenBonifPP                
    DEALLOCATE crGenBonifPP         
    -- Se generan las notas de cred normales cuando hay notas de credito por canc             
             
    DECLARE crGenBonifPP2 CURSOR FOR                
     SELECT SUM(ISNULL(NoAtraso,0)), Origen, OrigenId, IDNoAtraso                
       FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID  AND NoAtraso > 0 AND NotaCreditoxCanc is null                          
      GROUP BY Origen, OrigenId, IDNoAtraso                
    OPEN crGenBonifPP2                
    FETCH NEXT FROM crGenBonifPP2 INTO @NoAtraso, @Origen, @OrigenID, @IdPol                
    WHILE @@FETCH_STATUS <> -1                 
    BEGIN  --               
      IF @@FETCH_STATUS <> -2                 
      BEGIN  --                
        SET @Renglon = 1024.0                 
        SELECT @UEN = UEN, @CanalVenta = ClienteEnviarA FROM CXC WHERE Mov = @Origen AND MovId = @OrigenID                 
                
        SELECT @MovPadre = @Origen                 
        SELECT @MovCrear = ISNULL(MovCrear, 'Nota Credito')  FROM MovCrearBonifMAVI WHERE Mov = @Movpadre AND UEN = @UEN                               
                   
        IF @MovCrear IS NULL SELECT @MovCrear = 'Nota Credito'                                 
                        
        SELECT @Concepto = Concepto                
          FROM MaviBonificacionConf where ID = @IDPol                
                         
        --Bonificacion LIKE '%Contado Comercial%' AND Estatus = 'CONCLUIDO'                
                 
        INSERT INTO Cxc(Empresa, Mov, MovID, FechaEmision, UltimoCambio, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Autorizacion, Referencia, DocFuente,                 
                        Observaciones, Estatus, Situacion, SituacionFecha, SituacionUsuario, SituacionNota, Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio,   -- 2                
                        Cobrador, Condicion, Vencimiento, FormaCobro, CtaDinero, Importe, Impuestos, Retencion, AplicaManual, ConDesglose, FormaCobro1, FormaCobro2,                 
                        FormaCobro3, FormaCobro4, FormaCobro5, Referencia1, Referencia2, Referencia3, Referencia4, Referencia5, Importe1, Importe2, Importe3,   --4                
                        Importe4, Importe5, Cambio, DelEfectivo, Agente, ComisionTotal, ComisionPendiente, MovAplica, MovAplicaID, OrigenTipo, Origen, OrigenID,                 
                        Poliza, PolizaID, FechaConclusion, FechaCancelacion, Dinero, DineroID, DineroCtaDinero, ConTramites, VIN, Sucursal, SucursalOrigen, Cajero,                 
                        UEN, PersonalCobrador, FechaOriginal, Nota, Comentarios, LineaCredito, TipoAmortizacion, TipoTasa, Amortizaciones, Comisiones, ComisionesIVA,                 
                        FechaRevision, ContUso, TieneTasaEsp, TasaEsp, Codigo)                
						VALUES (@Empresa, @MovCrear, NULL, cast(convert(varchar, @FechaAplicacion, 101) as datetime), @FechaAplicacion, @Concepto, NULL, @Moneda, @TipoCambio, @Usuario, NULL, @Referencia, NULL, --1                
                        NULL, 'SINAFECTAR', NULL, NULL, NULL, NULL, @Contacto, @CanalVenta, @Moneda, @TipoCambio,   --2                
                        NULL, NULL, cast(convert(varchar, @FechaAplicacion, 101) as datetime), NULL, @CtaDinero, NULL, NULL, NULL, 1, 0, NULL, NULL,   -- 3                
                        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,  -- 4                
						NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -- 5                
                        NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, @Sucursal, @Sucursal, NULL,                 
                        @UEN, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL,                 
						NULL, NULL, 0, NULL, NULL)  -- 7                
                
        SELECT @IDCxc = @@IDENTITY                
                
        --SELECT @IDCxc as 'Nota Cred'   -- yrg                
        -- Cursor para el detalle de la NCred                
        DECLARE crDetNCBonifPP2 CURSOR FOR                
         SELECT Mov, MovID, NoAtraso                 
           FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID AND NoAtraso > 0 AND NotaCreditoxCanc is null                  
            AND Origen = @Origen AND OrigenId = @OrigenID --AND IDNoAtraso = @IdPol                
        OPEN crDetNCBonifPP2                
        FETCH NEXT FROM crDetNCBonifPP2 INTO @Mov, @MovID, @ImpDocto                
        WHILE @@FETCH_STATUS <> -1                 
        BEGIN  -- 2                
          IF @@FETCH_STATUS <> -2                 
          BEGIN  -- 3                
            --insert cxcd                
            -- verificar el sdo del docto      
            INSERT INTO CxcD(ID, Renglon, RenglonSub, Aplica, AplicaID, Importe, Fecha, Sucursal, SucursalOrigen, DescuentoRecargos, InteresesOrdinarios,                 
                             InteresesMoratorios, InteresesOrdinariosQuita, InteresesMoratoriosQuita, ImpuestoAdicional, Retencion)                
            VALUES(@IDCxc, @Renglon, 0, @Mov, @MovId, @ImpDocto, NULL, @Sucursal, @Sucursal, NULL, NULL, NULL, NULL, NULL, NULL, NULL)                
                
            SET @Renglon = @Renglon + 1024.0                
                            
            UPDATE NegociaMoratoriosMAVI                 
               SET NotaCredBonId = @IDCxc                
             WHERE IDCobro = @ID                  
               AND Origen = @Origen AND OrigenId = @OrigenID  AND IDNoAtraso = @IdPol                 
          END                
          FETCH NEXT FROM crDetNCBonifPP2 INTO @Mov, @MovID, @ImpDocto                
        END                 
        CLOSE crDetNCBonifPP2                
        DEALLOCATE crDetNCBonifPP2                
                
        ----SELECT @Impuestos = SUM(d.Importe*ca.IVAFiscal)--, sum(d.Importe-(d.Importe*ca.IVAFiscal)) --d.Aplica, d.AplicaID, ca.Mov, ca.MovID, ca.Saldo, ca.IVAFiscal,  ca.Saldo*ca.IVAFiscal                
        SELECT @Impuestos = SUM(d.Importe*isnull(ca.IVAFiscal,0.00))                
          FROM CXCD d                
          JOIN CxcAplica ca ON d.Aplica = ca.Mov AND d.AplicaID = ca.MovID AND ca.Empresa = @Empresa                
         WHERE d.ID = @IDCxc                
                
        SELECT @TotalMov = SUM(d.Importe-isnull(d.Importe*ca.IVAFiscal,0)) --d.Aplica, d.AplicaID, ca.Mov, ca.MovID, ca.Saldo, ca.IVAFiscal,  ca.Saldo*ca.IVAFiscal                
          FROM CXCD d                
          JOIN CxcAplica ca ON d.Aplica = ca.Mov AND d.AplicaID = ca.MovID AND ca.Empresa = @Empresa                
         WHERE d.ID = @IDCxc                
                    
        UPDATE CXC                
           SET Importe = isnull(ROUND(@TotalMov,2),0.00),                 
               Impuestos = isnull(ROUND(@Impuestos,2),0.00),                
               Saldo = isnull(ROUND(@TotalMov,2),0.00) + isnull(ROUND(@impuestos,2),0.00),                
               IDCobroBonifMAVI = @ID                
         WHERE ID = @IDCxc                
                
        --select @TotalMov as 'TotalMov'  -- yrg                
        -- Afectar el Cobro                                  
        EXEC spAfectar 'CXC', @IDCxc, 'AFECTAR', 'Todo', NULL, @Usuario,  NULL, 1, @Ok OUTPUT, @OkRef OUTPUT,NULL, @Conexion = 1  --1 dentro de trans                
        --select @OK as 'Ok NCred'                
        --select @OKRef as 'OkRef NCred'                
        INSERT INTO DetalleAfectacionMAVI( IDCobro, ID, Mov, MovID, ValorOK, ValorOKRef) VALUES(@ID, @IDCxc, @MovCrear, NULL, @Ok, @OkRef )                                              
                
      END  -- 3       
      FETCH NEXT FROM crGenBonifPP2 INTO @NoAtraso, @Origen, @OrigenID, @IdPol                
    END -- 2                    
    CLOSE crGenBonifPP2                
    DEALLOCATE crGenBonifPP2  
  END  -- 1  
            
END
GO



/************************ spGeneraNCredPPMAVI *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spGeneraNCredPPMAVI') AND type = 'P') DROP PROCEDURE dbo.spGeneraNCredPPMAVI
GO
CREATE PROCEDURE dbo.spGeneraNCredPPMAVI  
   @ID   int,                
   @Usuario varchar(10),                
   @Ok         int                OUTPUT,                
   @OkRef      varchar(255)       OUTPUT                     
--//WITH ENCRYPTION            
AS BEGIN   -- 1             
  DECLARE                
    @Empresa   char(5),                
    @Sucursal   int,                
    @Hoy   datetime,                
    @Vencimiento  datetime,                
    @Moneda   char(10),                
    @TipoCambio   float,                
    @Contacto   char(10),                
    @Renglon   float,                
    @Aplica   varchar(20),                
    @AplicaID   varchar(20),                
    @ImpReal    money,                
    @MoratorioAPagar  money,                
    @Origen    varchar(20),                
    @OrigenID   varchar(20),                                  
    @MovPadre   varchar(20),                
    @MovPadre1   varchar(20),                
    @MovIDPadre   varchar(20),                
    @PagoPuntual money,                
    @UEN    int,                
    @MovCrear   varchar(20),                
    @Mov    varchar(20),                
    @IDCxc    int,                
    @FechaAplicacion datetime,                
    @CtaDinero   varchar(10),                
    @Concepto   varchar(50),                
    @IDPol    int,                
    @NumDoctos   int,                
    @ImpDocto   money,                           
    @MovID    varchar(20),                
    @TotalMov   money,                           
    @Referencia   varchar(100),                
    @CanalVenta   int,                
    @Impuestos   money,            
    @HayNotasCredCanc    int,          
    @DocsPend   int,                  
    @SdoDoc   money,          
    @ImpTotalBonif  money,  
    @DefImpuesto float,  
    @IDCxc2    int           
                
  SET @DocsPend = 0             
  SET @FechaAplicacion = GetDate()                
  SELECT @Empresa = Empresa, @Sucursal = Sucursal, @Hoy = FechaEmision, @Moneda = Moneda, @TipoCambio = TipoCambio, @Contacto = Cliente   FROM Cxc WHERE ID = @ID                 
  -- OJO es importante tomar el concepto de cada politica                
  --IF             
  SELECT @HayNotasCredCanc = COUNT(*) FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID AND PagoPuntual > 0 AND NotaCreditoxCanc = '1'            
  IF @HayNotasCredCanc = 0            
  BEGIN  -- 2          
   --select 'No hay notasx canc'      
    DECLARE crGenBonifPP CURSOR FOR                
     SELECT SUM(ISNULL(PagoPuntual,0)), Origen, OrigenId, IDPagoPuntual                
       FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID  AND PagoPuntual > 0                  
      GROUP BY Origen, OrigenId, IDPagoPuntual                
    OPEN crGenBonifPP                
    FETCH NEXT FROM crGenBonifPP INTO @PagoPuntual, @Origen, @OrigenID, @IdPol                
    WHILE @@FETCH_STATUS <> -1                 
    BEGIN  -- 3               
      IF @@FETCH_STATUS <> -2                 
      BEGIN  -- 4            
        SET @ImpTotalBonif = @PagoPuntual                      
        SET @Renglon = 1024.0                 
        SELECT @UEN = UEN, @CanalVenta = ClienteEnviarA FROM CXC WHERE Mov = @Origen AND MovId = @OrigenID                 
                
        SELECT @MovPadre = @Origen                 
        SELECT @MovCrear = ISNULL(MovCrear, 'Nota Credito')  FROM MovCrearBonifMAVI WHERE Mov = @Movpadre AND UEN = @UEN                                           
                   
        IF @MovCrear IS NULL SELECT @MovCrear = 'Nota Credito'                                 
                        
        SELECT @Concepto = Concepto                
          FROM MaviBonificacionConf where ID = @IDPol                                           
          
        SELECT @DocsPend = Count(*) FROM CXC WHERE PadreMAVI = @Origen AND PadreIDMAVI = @OrigenID AND Estatus = 'PENDIENTE'            
        IF @DocsPend > 0            
        BEGIN  -- 5           
          INSERT INTO Cxc(Empresa, Mov, MovID, FechaEmision, UltimoCambio, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Autorizacion, Referencia, DocFuente,                 
                        Observaciones, Estatus, Situacion, SituacionFecha, SituacionUsuario, SituacionNota, Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio,   -- 2                
                        Cobrador, Condicion, Vencimiento, FormaCobro, CtaDinero, Importe, Impuestos, Retencion, AplicaManual, ConDesglose, FormaCobro1, FormaCobro2,                 
                        FormaCobro3, FormaCobro4, FormaCobro5, Referencia1, Referencia2, Referencia3, Referencia4, Referencia5, Importe1, Importe2, Importe3,   --4                
                        Importe4, Importe5, Cambio, DelEfectivo, Agente, ComisionTotal, ComisionPendiente, MovAplica, MovAplicaID, OrigenTipo, Origen, OrigenID,                 
                        Poliza, PolizaID, FechaConclusion, FechaCancelacion, Dinero, DineroID, DineroCtaDinero, ConTramites, VIN, Sucursal, SucursalOrigen, Cajero,                 
                        UEN, PersonalCobrador, FechaOriginal, Nota, Comentarios, LineaCredito, TipoAmortizacion, TipoTasa, Amortizaciones, Comisiones, ComisionesIVA,                 
                        FechaRevision, ContUso, TieneTasaEsp, TasaEsp, Codigo)                
          VALUES (@Empresa, @MovCrear, NULL, cast(convert(varchar, @FechaAplicacion, 101) as datetime), @FechaAplicacion, @Concepto, NULL, @Moneda, @TipoCambio, @Usuario, NULL, @Referencia, NULL, --1                
                        NULL, 'SINAFECTAR', NULL, NULL, NULL, NULL, @Contacto, @CanalVenta, @Moneda, @TipoCambio,   --2                
                        NULL, NULL, cast(convert(varchar, @FechaAplicacion, 101) as datetime), NULL, @CtaDinero, NULL, NULL, NULL, 1, 0, NULL, NULL,   -- 3                
                        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,  -- 4                
                        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -- 5                
                        NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, @Sucursal, @Sucursal, NULL,                 
                        @UEN, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL,                 
                        NULL, NULL, 0, NULL, NULL)  -- 7                
                
          SELECT @IDCxc = @@IDENTITY                
                
        --SELECT @IDCxc as 'Nota Cred'   -- yrg                
        -- Cursor para el detalle de la NCred               
                           
          DECLARE crDetNCBonifPP CURSOR FOR                
           SELECT Mov, MovID, PagoPuntual                 
             FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID AND PagoPuntual > 0                  
              AND Origen = @Origen AND OrigenId = @OrigenID --AND IDPagoPuntual = @IdPol                
          OPEN crDetNCBonifPP                
          FETCH NEXT FROM crDetNCBonifPP INTO @Mov, @MovID, @ImpDocto                
          WHILE @@FETCH_STATUS <> -1                 
          BEGIN  -- 6          
            IF @@FETCH_STATUS <> -2                 
            BEGIN  -- 7                
              SELECT @SdoDoc = Saldo FROM CXC WHERE Mov = @Mov AND MovId = @MovId                                       

              IF @ImpDocto > @SdoDoc-- 8                  
              BEGIN    -- 8        
     --          select 'Bonif > SdoDoc'            
                  
                SELECT @ImpDocto = @SdoDoc                  
       --        SELECT @ImpDocto as 'Importe detalle NC'                  
                SET @ImpTotalBonif = @ImpTotalBonif - @ImpDocto                  
               --insert cxcd                
                INSERT INTO CxcD(ID, Renglon, RenglonSub, Aplica, AplicaID, Importe, Fecha, Sucursal, SucursalOrigen, DescuentoRecargos, InteresesOrdinarios,              
                                 InteresesMoratorios, InteresesOrdinariosQuita, InteresesMoratoriosQuita, ImpuestoAdicional, Retencion)                
                VALUES(@IDCxc, @Renglon, 0, @Mov, @MovId, @ImpDocto, NULL, @Sucursal, @Sucursal, NULL, NULL, NULL, NULL, NULL, NULL, NULL)                
                
                SET @Renglon = @Renglon + 1024.0                
                            
                UPDATE NegociaMoratoriosMAVI                 
                   SET NotaCredBonId = @IDCxc                
                 WHERE IDCobro = @ID                  
                   AND Origen = @Origen AND OrigenId = @OrigenID  AND IDPagoPuntual = @IdPol                 
          
              END -- 8                  
              ELSE                  
              BEGIN  -- 8                                      

                IF @ImpDocto <= @SdoDoc --                   
                BEGIN  -- 9   
 
                SET @ImpTotalBonif = @ImpTotalBonif - @ImpDocto                          

                  -- antes 14.05.2010 SET @ImpTotalBonif = @ImpTotalBonif - @ImpDocto                  
              -- SET @ImpTotalBonif = @ImpDocto       
         --         select 'ImpBonif <= SdoDoc'      
           --      select @ImpDocto as 'ImpNcredDetalle 2'                 
                  INSERT INTO CxcD(ID, Renglon, RenglonSub, Aplica, AplicaID, Importe, Fecha, Sucursal, SucursalOrigen, DescuentoRecargos, InteresesOrdinarios,                   
                                  InteresesMoratorios, InteresesOrdinariosQuita, InteresesMoratoriosQuita, ImpuestoAdicional, Retencion)                  
                  VALUES(@IDCxc, @Renglon, 0, @Mov, @MovId, @ImpDocto, NULL, @Sucursal, @Sucursal, NULL, NULL, NULL, NULL, NULL, NULL, NULL)                  
                  
                  SET @Renglon = @Renglon + 1024.0                  
                         
                  UPDATE NegociaMoratoriosMAVI                   
                     SET NotaCredBonId = @IDCxc                  
                   WHERE IDCobro = @ID                    
                     AND Origen = @Origen AND OrigenId = @OrigenID  AND IDPagoPuntual = @IdPol            
                END   -- 9                 
              END -- 8                 
          
            END  -- 7              
            FETCH NEXT FROM crDetNCBonifPP INTO @Mov, @MovID, @ImpDocto                
          END  -- 6                 
          CLOSE crDetNCBonifPP                
          DEALLOCATE crDetNCBonifPP                
         
          SELECT @Impuestos = SUM(d.Importe*isnull(ca.IVAFiscal,0.00))                
            FROM CXCD d                
            JOIN CxcAplica ca ON d.Aplica = ca.Mov AND d.AplicaID = ca.MovID AND ca.Empresa = @Empresa                
           WHERE d.ID = @IDCxc                
                
          SELECT @TotalMov = SUM(d.Importe-isnull(d.Importe*ca.IVAFiscal,0)) --d.Aplica, d.AplicaID, ca.Mov, ca.MovID, ca.Saldo, ca.IVAFiscal,  ca.Saldo*ca.IVAFiscal                
            FROM CXCD d                
            JOIN CxcAplica ca ON d.Aplica = ca.Mov AND d.AplicaID = ca.MovID AND ca.Empresa = @Empresa                
           WHERE d.ID = @IDCxc                
                    
          UPDATE CXC                
             SET Importe = isnull(ROUND(@TotalMov,2),0.00),                 
                 Impuestos = isnull(ROUND(@Impuestos,2),0.00),                
                 Saldo = isnull(ROUND(@TotalMov,2),0.00) + isnull(ROUND(@impuestos,2),0.00),                
                 IDCobroBonifMAVI = @ID                
           WHERE ID = @IDCxc                
        END -- 5             
       --select @TotalMov as 'TotalMov'  -- yrg                                        
  IF @IDCxc > 0            
  BEGIN     -- aa    
   EXEC spAfectar 'CXC', @IDCxc, 'AFECTAR', 'Todo', NULL, @Usuario,  NULL, 1, @Ok OUTPUT, @OkRef OUTPUT,NULL, @Conexion = 1   --1 dentro de trans                
   --select @OK as 'Ok NCred'                
   --select @OKRef as 'OkRef NCred'                
   INSERT INTO DetalleAfectacionMAVI( IDCobro, ID, Mov, MovID, ValorOK, ValorOKRef) VALUES(@ID, @IDCxc, @MovCrear, NULL, @Ok, @OkRef )                                         
  END -- aa     

        IF @ImpTotalBonif > 0  -- Aun sobra bonificacion        
        BEGIN  -- bb              
            SELECT @DefImpuesto = DefImpuesto FROM EmpresaGral WHERE Empresa = @Empresa        
            INSERT INTO Cxc(Empresa, Mov, MovID, FechaEmision, UltimoCambio, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Autorizacion, Referencia, DocFuente,         
                             Observaciones, Estatus, Situacion, SituacionFecha, SituacionUsuario, SituacionNota, Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio,   -- 2        
                             Cobrador, Condicion, Vencimiento, FormaCobro, CtaDinero, Importe, Impuestos, Retencion, AplicaManual, ConDesglose, FormaCobro1, FormaCobro2,         
                             FormaCobro3, FormaCobro4, FormaCobro5, Referencia1, Referencia2, Referencia3, Referencia4, Referencia5, Importe1, Importe2, Importe3,   --4        
                             Importe4, Importe5, Cambio, DelEfectivo, Agente, ComisionTotal, ComisionPendiente, MovAplica, MovAplicaID, OrigenTipo, Origen, OrigenID,         
                             Poliza, PolizaID, FechaConclusion, FechaCancelacion, Dinero, DineroID, DineroCtaDinero, ConTramites, VIN, Sucursal, SucursalOrigen, Cajero,         
                             UEN, PersonalCobrador, FechaOriginal, Nota, Comentarios, LineaCredito, TipoAmortizacion, TipoTasa, Amortizaciones, Comisiones, ComisionesIVA,         
                             FechaRevision, ContUso, TieneTasaEsp, TasaEsp, Codigo)        
            VALUES (@Empresa, @MovCrear, NULL, cast(convert(varchar, @FechaAplicacion, 101) as datetime), @FechaAplicacion, @Concepto, NULL, @Moneda, @TipoCambio, @Usuario, NULL, @Referencia, NULL, --1        
                           NULL, 'SINAFECTAR', NULL, NULL, NULL, NULL, @Contacto, @CanalVenta, @Moneda, @TipoCambio,   --2        
                          NULL, NULL, @FechaAplicacion, NULL, @CtaDinero, NULL, NULL, NULL, 0, 0, NULL, NULL,   -- 3        
                          NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,  -- 4        
                          NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -- 5        
                          NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, @Sucursal, @Sucursal, NULL,         
                          @UEN, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL,         
                          NULL, NULL, 0, NULL, NULL)  -- 7        
        
            SELECT @IDCxc2 = @@IDENTITY        
        
            UPDATE CXC        
               SET Importe = ROUND(@ImpTotalBonif/ (1+@DefImpuesto/100.0), 2),        
                   Impuestos = ROUND(@ImpTotalBonif/ (1+@DefImpuesto/100.0), 2)*(@DefImpuesto/100.0),       
                   Saldo = ROUND(@ImpTotalBonif/ (1+@DefImpuesto/100.0), 2) + ROUND(@ImpTotalBonif/ (1+@DefImpuesto/100.0), 2)*(@DefImpuesto/100.0),        
                   --select Importe = ROUND(1000/1.15,2)        
                   --select Impuesto = ROUND(1000/1.15*(15/100.0),2)        
                   IDCobroBonifMAVI = @ID        
             WHERE ID = @IDCxc2        
        
            EXEC spAfectar 'CXC', @IDCxc2, 'AFECTAR', 'Todo', NULL, @Usuario,  NULL, 1, @Ok OUTPUT, @OkRef OUTPUT,NULL, @Conexion = 1  --1 dentro de trans        
                
            INSERT INTO DetalleAfectacionMAVI( IDCobro, ID, Mov, MovID, ValorOK, ValorOKRef) VALUES(@ID, @IDCxc2, @MovCrear, NULL, @Ok, @OkRef )         
        END    -- bb          
      END  -- 4          
      FETCH NEXT FROM crGenBonifPP INTO @PagoPuntual, @Origen, @OrigenID, @IdPol                   
    END --   3                
    CLOSE crGenBonifPP                
    DEALLOCATE crGenBonifPP                
  END  -- 2            
  ELSE    -- Hay Notas de cred x canc          
  BEGIN  -- 2          
    DECLARE crGenBonifPP CURSOR FOR                
     SELECT SUM(ISNULL(PagoPuntual,0)), Origen, OrigenId, IDPagoPuntual                
       FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID  AND PagoPuntual > 0 AND NotaCreditoxCanc = '1'                 
      GROUP BY Origen, OrigenId, IDPagoPuntual                
    OPEN crGenBonifPP                
    FETCH NEXT FROM crGenBonifPP INTO @PagoPuntual, @Origen, @OrigenID, @IdPol                
    WHILE @@FETCH_STATUS <> -1                 
    BEGIN  -- 10                
      IF @@FETCH_STATUS <> -2                 
      BEGIN  -- 11               
        SET @Renglon = 1024.0                 
        SELECT @UEN = UEN, @CanalVenta = ClienteEnviarA FROM CXC WHERE Mov = @Origen AND MovId = @OrigenID                 
                
        SELECT @MovPadre = @Origen                 
        SELECT @MovCrear = ISNULL(MovCrear, 'Nota Credito')  FROM MovCrearBonifMAVI WHERE Mov = @Movpadre AND UEN = @UEN                
                        
        IF @MovPadre = 'Credilana' SET @MovCrear = 'Nota Credito'            
        IF @MovPadre = 'Prestamo Personal' SET @MovCrear = 'Nota Credito VIU'            
        IF @MovCrear IS NULL SELECT @MovCrear = 'Nota Credito'                                 
                        
        SELECT @Concepto = Concepto                
          FROM MaviBonificacionConf where ID = @IDPol                               
                 
        INSERT INTO Cxc(Empresa, Mov, MovID, FechaEmision, UltimoCambio, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Autorizacion, Referencia, DocFuente,                 
                        Observaciones, Estatus, Situacion, SituacionFecha, SituacionUsuario, SituacionNota, Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio,   -- 2                
                        Cobrador, Condicion, Vencimiento, FormaCobro, CtaDinero, Importe, Impuestos, Retencion, AplicaManual, ConDesglose, FormaCobro1, FormaCobro2,                 
                        FormaCobro3, FormaCobro4, FormaCobro5, Referencia1, Referencia2, Referencia3, Referencia4, Referencia5, Importe1, Importe2, Importe3,   --4                
                        Importe4, Importe5, Cambio, DelEfectivo, Agente, ComisionTotal, ComisionPendiente, MovAplica, MovAplicaID, OrigenTipo, Origen, OrigenID,                 
                        Poliza, PolizaID, FechaConclusion, FechaCancelacion, Dinero, DineroID, DineroCtaDinero, ConTramites, VIN, Sucursal, SucursalOrigen, Cajero,                 
                        UEN, PersonalCobrador, FechaOriginal, Nota, Comentarios, LineaCredito, TipoAmortizacion, TipoTasa, Amortizaciones, Comisiones, ComisionesIVA,                 
                        FechaRevision, ContUso, TieneTasaEsp, TasaEsp, Codigo)                
        VALUES (@Empresa, @MovCrear, NULL, cast(convert(varchar, @FechaAplicacion, 101) as datetime), @FechaAplicacion, @Concepto, NULL, @Moneda, @TipoCambio, @Usuario, NULL, @Referencia, NULL, --1                
                        NULL, 'SINAFECTAR', NULL, NULL, NULL, NULL, @Contacto, @CanalVenta, @Moneda, @TipoCambio,   --2                
                        NULL, NULL, cast(convert(varchar, @FechaAplicacion, 101) as datetime), NULL, @CtaDinero, NULL, NULL, NULL, 1, 0, NULL, NULL,   -- 3              
                        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,  -- 4                
                        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -- 5                
                        NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, @Sucursal, @Sucursal, NULL,                 
                        @UEN, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL,                 
                        NULL, NULL, 0, NULL, NULL)  -- 7                
                
     SELECT @IDCxc = @@IDENTITY                
                
        --SELECT @IDCxc as 'Nota Cred'   -- yrg                
        -- Cursor para el detalle de la NCred                
        DECLARE crDetNCBonifPP CURSOR FOR                
         SELECT Mov, MovID, PagoPuntual                 
           FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID AND PagoPuntual > 0  AND NotaCreditoxCanc = '1'                      
            AND Origen = @Origen AND OrigenId = @OrigenID --AND IDPagoPuntual = @IdPol                
        OPEN crDetNCBonifPP                
        FETCH NEXT FROM crDetNCBonifPP INTO @Mov, @MovID, @ImpDocto                
        WHILE @@FETCH_STATUS <> -1                 
        BEGIN  -- 12                
          IF @@FETCH_STATUS <> -2                 
          BEGIN  -- 13                
            --insert cxcd                
            INSERT INTO CxcD(ID, Renglon, RenglonSub, Aplica, AplicaID, Importe, Fecha, Sucursal, SucursalOrigen, DescuentoRecargos, InteresesOrdinarios,                 
                             InteresesMoratorios, InteresesOrdinariosQuita, InteresesMoratoriosQuita, ImpuestoAdicional, Retencion)                
            VALUES(@IDCxc, @Renglon, 0, @Mov, @MovId, @ImpDocto, NULL, @Sucursal, @Sucursal, NULL, NULL, NULL, NULL, NULL, NULL, NULL)                
                
            SET @Renglon = @Renglon + 1024.0                
                            
            UPDATE NegociaMoratoriosMAVI                 
               SET NotaCredBonId = @IDCxc                
             WHERE IDCobro = @ID                  
               AND Origen = @Origen AND OrigenId = @OrigenID  AND IDPagoPuntual = @IdPol                 
          END   -- 13             
          FETCH NEXT FROM crDetNCBonifPP INTO @Mov, @MovID, @ImpDocto                
        END  -- 12               
        CLOSE crDetNCBonifPP                
        DEALLOCATE crDetNCBonifPP                
                
        ----SELECT @Impuestos = SUM(d.Importe*ca.IVAFiscal)--, sum(d.Importe-(d.Importe*ca.IVAFiscal)) --d.Aplica, d.AplicaID, ca.Mov, ca.MovID, ca.Saldo, ca.IVAFiscal,  ca.Saldo*ca.IVAFiscal                
        SELECT @Impuestos = SUM(d.Importe*isnull(ca.IVAFiscal,0.00))                
          FROM CXCD d                
          JOIN CxcAplica ca ON d.Aplica = ca.Mov AND d.AplicaID = ca.MovID AND ca.Empresa = @Empresa                
         WHERE d.ID = @IDCxc                
                
        SELECT @TotalMov = SUM(d.Importe-isnull(d.Importe*ca.IVAFiscal,0)) --d.Aplica, d.AplicaID, ca.Mov, ca.MovID, ca.Saldo, ca.IVAFiscal,  ca.Saldo*ca.IVAFiscal                
          FROM CXCD d                
          JOIN CxcAplica ca ON d.Aplica = ca.Mov AND d.AplicaID = ca.MovID AND ca.Empresa = @Empresa                
         WHERE d.ID = @IDCxc                
                    
        UPDATE CXC                
           SET Importe = isnull(ROUND(@TotalMov,2),0.00),                 
               Impuestos = isnull(ROUND(@Impuestos,2),0.00),                
               Saldo = isnull(ROUND(@TotalMov,2),0.00) + isnull(ROUND(@impuestos,2),0.00),                
               IDCobroBonifMAVI = @ID                
         WHERE ID = @IDCxc                
                
        --select @TotalMov as 'TotalMov'  -- yrg         
                    
        EXEC spAfectar 'CXC', @IDCxc, 'AFECTAR', 'Todo', NULL, @Usuario,  NULL, 1, @Ok OUTPUT, @OkRef OUTPUT,NULL, @Conexion = 1   --1 dentro de trans                
        --select @OK as 'Ok NCred'                
        --select @OKRef as 'OkRef NCred'                
        INSERT INTO DetalleAfectacionMAVI( IDCobro, ID, Mov, MovID, ValorOK, ValorOKRef) VALUES(@ID, @IDCxc, @MovCrear, NULL, @Ok, @OkRef )                        
                
        --        SELECT @Referencia = RTRIM(@Origen)+'_'+RTRIM(@OrigenID)                
                
      END  -- 10              
      FETCH NEXT FROM crGenBonifPP INTO @PagoPuntual, @Origen, @OrigenID, @IdPol                
      --FETCH NEXT FROM crGenBonif INTO @ContadoComercial, @Origen, @OrigenID, @IdPol                
    END -- 2                    
    CLOSE crGenBonifPP                
    DEALLOCATE crGenBonifPP         
    -- Se generan las notas de cred normales cuando hay notas de credito por canc             
             
    DECLARE crGenBonifPP2 CURSOR FOR                
     SELECT SUM(ISNULL(PagoPuntual,0)), Origen, OrigenId, IDPagoPuntual                
       FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID  AND PagoPuntual > 0 AND NotaCreditoxCanc is null                          
      GROUP BY Origen, OrigenId, IDPagoPuntual                
    OPEN crGenBonifPP2                
    FETCH NEXT FROM crGenBonifPP2 INTO @PagoPuntual, @Origen, @OrigenID, @IdPol                
    WHILE @@FETCH_STATUS <> -1                 
    BEGIN  --               
      IF @@FETCH_STATUS <> -2                 
      BEGIN  --                
        SET @Renglon = 1024.0                 
        SELECT @UEN = UEN, @CanalVenta = ClienteEnviarA FROM CXC WHERE Mov = @Origen AND MovId = @OrigenID                 
                
        SELECT @MovPadre = @Origen                 
        SELECT @MovCrear = ISNULL(MovCrear, 'Nota Credito')  FROM MovCrearBonifMAVI WHERE Mov = @Movpadre AND UEN = @UEN                                    
                   
        IF @MovCrear IS NULL SELECT @MovCrear = 'Nota Credito'                                 
                        
        SELECT @Concepto = Concepto                
          FROM MaviBonificacionConf where ID = @IDPol                
                         
        --Bonificacion LIKE '%Contado Comercial%' AND Estatus = 'CONCLUIDO'                
                 
        INSERT INTO Cxc(Empresa, Mov, MovID, FechaEmision, UltimoCambio, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Autorizacion, Referencia, DocFuente,                 
                        Observaciones, Estatus, Situacion, SituacionFecha, SituacionUsuario, SituacionNota, Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio,   -- 2                
                        Cobrador, Condicion, Vencimiento, FormaCobro, CtaDinero, Importe, Impuestos, Retencion, AplicaManual, ConDesglose, FormaCobro1, FormaCobro2,                 
                        FormaCobro3, FormaCobro4, FormaCobro5, Referencia1, Referencia2, Referencia3, Referencia4, Referencia5, Importe1, Importe2, Importe3,   --4                
                        Importe4, Importe5, Cambio, DelEfectivo, Agente, ComisionTotal, ComisionPendiente, MovAplica, MovAplicaID, OrigenTipo, Origen, OrigenID,                 
                        Poliza, PolizaID, FechaConclusion, FechaCancelacion, Dinero, DineroID, DineroCtaDinero, ConTramites, VIN, Sucursal, SucursalOrigen, Cajero,                 
                        UEN, PersonalCobrador, FechaOriginal, Nota, Comentarios, LineaCredito, TipoAmortizacion, TipoTasa, Amortizaciones, Comisiones, ComisionesIVA,                 
                        FechaRevision, ContUso, TieneTasaEsp, TasaEsp, Codigo)                
        VALUES (@Empresa, @MovCrear, NULL, cast(convert(varchar, @FechaAplicacion, 101) as datetime), @FechaAplicacion, @Concepto, NULL, @Moneda, @TipoCambio, @Usuario, NULL, @Referencia, NULL, --1                
                        NULL, 'SINAFECTAR', NULL, NULL, NULL, NULL, @Contacto, @CanalVenta, @Moneda, @TipoCambio,   --2                
                        NULL, NULL, cast(convert(varchar, @FechaAplicacion, 101) as datetime), NULL, @CtaDinero, NULL, NULL, NULL, 1, 0, NULL, NULL,   -- 3                
                        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,  -- 4                
      NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -- 5                
                        NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, @Sucursal, @Sucursal, NULL,                 
                        @UEN, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL,                 
NULL, NULL, 0, NULL, NULL)  -- 7                
                
        SELECT @IDCxc = @@IDENTITY                
                
        --SELECT @IDCxc as 'Nota Cred'   -- yrg                
        -- Cursor para el detalle de la NCred                
        DECLARE crDetNCBonifPP2 CURSOR FOR                
         SELECT Mov, MovID, PagoPuntual                 
           FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID AND PagoPuntual > 0 AND NotaCreditoxCanc is null                  
            AND Origen = @Origen AND OrigenId = @OrigenID --AND IDPagoPuntual = @IdPol                
        OPEN crDetNCBonifPP2                
        FETCH NEXT FROM crDetNCBonifPP2 INTO @Mov, @MovID, @ImpDocto                
        WHILE @@FETCH_STATUS <> -1                 
        BEGIN  -- 2                
          IF @@FETCH_STATUS <> -2                 
          BEGIN  -- 3                
            --insert cxcd                
            -- verificar el sdo del docto      
            INSERT INTO CxcD(ID, Renglon, RenglonSub, Aplica, AplicaID, Importe, Fecha, Sucursal, SucursalOrigen, DescuentoRecargos, InteresesOrdinarios,                 
                             InteresesMoratorios, InteresesOrdinariosQuita, InteresesMoratoriosQuita, ImpuestoAdicional, Retencion)                
            VALUES(@IDCxc, @Renglon, 0, @Mov, @MovId, @ImpDocto, NULL, @Sucursal, @Sucursal, NULL, NULL, NULL, NULL, NULL, NULL, NULL)                
                
            SET @Renglon = @Renglon + 1024.0                
                            
            UPDATE NegociaMoratoriosMAVI                 
               SET NotaCredBonId = @IDCxc                
             WHERE IDCobro = @ID                  
               AND Origen = @Origen AND OrigenId = @OrigenID  AND IDPagoPuntual = @IdPol                 
          END                
          FETCH NEXT FROM crDetNCBonifPP2 INTO @Mov, @MovID, @ImpDocto                
        END                 
        CLOSE crDetNCBonifPP2                
        DEALLOCATE crDetNCBonifPP2                
                
        ----SELECT @Impuestos = SUM(d.Importe*ca.IVAFiscal)--, sum(d.Importe-(d.Importe*ca.IVAFiscal)) --d.Aplica, d.AplicaID, ca.Mov, ca.MovID, ca.Saldo, ca.IVAFiscal,  ca.Saldo*ca.IVAFiscal                
        SELECT @Impuestos = SUM(d.Importe*isnull(ca.IVAFiscal,0.00))                
          FROM CXCD d                
          JOIN CxcAplica ca ON d.Aplica = ca.Mov AND d.AplicaID = ca.MovID AND ca.Empresa = @Empresa                
         WHERE d.ID = @IDCxc                
                
        SELECT @TotalMov = SUM(d.Importe-isnull(d.Importe*ca.IVAFiscal,0)) --d.Aplica, d.AplicaID, ca.Mov, ca.MovID, ca.Saldo, ca.IVAFiscal,  ca.Saldo*ca.IVAFiscal                
          FROM CXCD d                
          JOIN CxcAplica ca ON d.Aplica = ca.Mov AND d.AplicaID = ca.MovID AND ca.Empresa = @Empresa                
         WHERE d.ID = @IDCxc                
                    
        UPDATE CXC                
           SET Importe = isnull(ROUND(@TotalMov,2),0.00),                 
               Impuestos = isnull(ROUND(@Impuestos,2),0.00),                
               Saldo = isnull(ROUND(@TotalMov,2),0.00) + isnull(ROUND(@impuestos,2),0.00),                
               IDCobroBonifMAVI = @ID                
         WHERE ID = @IDCxc                
                
        --select @TotalMov as 'TotalMov'  -- yrg                
        -- Afectar el Cobro                                  
        EXEC spAfectar 'CXC', @IDCxc, 'AFECTAR', 'Todo', NULL, @Usuario,  NULL, 1, @Ok OUTPUT, @OkRef OUTPUT,NULL, @Conexion = 1  --1 dentro de trans                
        --select @OK as 'Ok NCred'                
        --select @OKRef as 'OkRef NCred'                
        INSERT INTO DetalleAfectacionMAVI( IDCobro, ID, Mov, MovID, ValorOK, ValorOKRef) VALUES(@ID, @IDCxc, @MovCrear, NULL, @Ok, @OkRef )                                              
                
      END  -- 3       
      FETCH NEXT FROM crGenBonifPP2 INTO @PagoPuntual, @Origen, @OrigenID, @IdPol                
    END -- 2                    
    CLOSE crGenBonifPP2                
    DEALLOCATE crGenBonifPP2                
              
  END                
END                            
GO

/************************ spImpTotalBonifMAVI *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spImpTotalBonifMAVI') AND type = 'P') DROP PROCEDURE dbo.spImpTotalBonifMAVI
GO
CREATE PROCEDURE spImpTotalBonifMAVI		 
		    @ID			int    	
--//WITH ENCRYPTION	   
AS BEGIN
  DECLARE
	@MoratorioAPagar		money,
    @Origen				varchar(20),
    @OrigenID			varchar(20),
    @Aplica				varchar(20),
	@AplicaID           varchar(20),
    @ImporteReal		money,
	@ImporteAPagar		money,
    @ImporteACondonar	money,
    @Bonificacion		money,
	@IDT				int
    
  DECLARE crSdoTotalBon CURSOR FOR
   SELECT ID, Mov, MovID, ImporteAPagar, MoratorioAPagar, ImporteACondonar, Bonificacion, Origen, OrigenId
     FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID    
  OPEN crSdoTotalBon
  FETCH NEXT FROM crSdoTotalBon INTO @IDT, @Aplica, @AplicaID, @ImporteAPagar, @MoratorioAPagar, @ImporteACondonar, @Bonificacion, @Origen, @OrigenID
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
                
      UPDATE NegociaMoratoriosMAVI
         SET TotalAPagar = ROUND((ISNULL(@ImporteAPagar,0) + ISNULL(@MoratorioAPagar,0) - ISNULL(@ImporteACondonar,0)) - ISNULL(@Bonificacion,0),2)
       WHERE Origen = @Origen AND OrigenID = @OrigenID AND IDCobro = @ID AND ID = @IDT
         
    END                   
    FETCH NEXT FROM crSdoTotalBon INTO @IDT, @Aplica, @AplicaID, @ImporteAPagar, @MoratorioAPagar, @ImporteACondonar, @Bonificacion, @Origen, @OrigenID
  END
    
  CLOSE crSdoTotalBon
  DEALLOCATE crSdoTotalBon
  
  RETURN
END
GO


/************************ spMAviBuscaCxCVentaBonif *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spMAviBuscaCxCVentaBonif') AND type = 'P') DROP PROCEDURE dbo.spMAviBuscaCxCVentaBonif
GO
CREATE PROCEDURE spMAviBuscaCxCVentaBonif
  @MovIdCxc    varchar(20),  
  @MovCxc      varchar(20), 
  @IdMovResul  varchar(20) Output, 
  @MovResul    varchar(20) Output,
  @IdOrigen    Int Output
  --//WITH ENCRYPTION
AS BEGIN
  DECLARE
		@Tipo      Varchar(20),
		@IdNvo     varchar(20),
		@IdMovNvo  varchar(20),
		@MovtipoNvo varchar(20),   
		@IdOrigenNvo  int,
		@Aplica    varchar(20),
		@AplicaID varchar(20),
		@IDdetalle varchar(20),
		@Contador  int , 
		@ContadorD int 
				
		--- Inicializa 

		SELECT @Tipo = 'CxC', @IdNvo = @MovIdCxc, @IdMovNvo= @MovCxc, @Contador = 0, @ContadorD = 0, @MovtipoNvo = ''
        WHILE @MovtipoNvo <> 'VTAS.F' AND @Contador < 10
        BEGIN
        	SELECT @Tipo=OModulo, @IdMovNvo=OMov, @IdNvo=(OMovId),@IdOrigenNvo=mf.OID, @MovtipoNvo = Mt.Clave
        	  FROM MovFlujo mf, Movtipo Mt WHERE mf.OMov=Mt.Mov 
        	  AND mf.DMov = @IdMovNvo AND mf.DMovID = @IdNvo --AND DModulo = @Tipo  
        	       Order BY OMovId DESC 
        	SELECT @Contador = @Contador + 1
          ---SELECT @IdOrigenNvo IdOrigenNvo, @IdNvo IdMov , @IdMovNvo Movimiento, @Tipo Tipo,@MovtipoNvo MovtipoNvo  --- Test
        END
        
    IF @Contador > 10 SELECT @IdNvo = NULL, @IdMovNvo = NULL, @IdOrigenNvo = 0
    
      SELECT @Aplica = Aplica, @AplicaID = AplicaID FROM CxcD WHERE Id = @IdOrigen
      IF NOT @AplicaID IS NULL 
      BEGIN
      DECLARE crCxCCte CURSOR FOR
       SELECT  Id FROM CXc WHERE Mov = @Aplica AND MovId = @AplicaID
      OPEN crCxCCte
      FETCH NEXT FROM crCxCCte INTO @IdMovNvo
      WHILE @MovtipoNvo <> 'VTAS.F'  AND @ContadorD < 10
      BEGIN 
        	SELECT @Tipo=OModulo, @IdMovNvo=OMov, @IdNvo=(OMovId),@IdOrigenNvo=mf.OID, @MovtipoNvo = Mt.Clave
        	  FROM MovFlujo mf, Movtipo Mt WHERE mf.OMov = Mt.Mov 
        	  AND mf.DMov = @IdMovNvo AND mf.DMovID = @IdNvo 
        	       Order BY OMovId DESC 
        	SELECT @ContadorD = @ContadorD + 1       
        	----SELECT 'A dETALLE'  
      FETCH NEXT FROM crCxCCte INTO @IdMovNvo
      END
      CLOSE crCxCCte
      DEALLOCATE crCxCCte
      END      
    SELECT @IdMovResul=@IdNvo, @MovResul=@IdMovNvo, @IdOrigen= @IdOrigenNvo
  RETURN 
 End
 GO
 
 
 /************************ spMAviBuscaCxCVentaTest *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spMAviBuscaCxCVentaTest') AND type = 'P') DROP PROCEDURE dbo.spMAviBuscaCxCVentaTest
GO
CREATE PROCEDURE spMAviBuscaCxCVentaTest            
  @MovIdCxc    varchar(20),              
  @MovCxc      varchar(20),             
  @IdMovResul  varchar(20) Output,             
  @MovResul    varchar(20) Output,            
  @IdOrigen    Int Output            
--//WITH ENCRYPTION
AS BEGIN            
  DECLARE            
  @Tipo      Varchar(20),            
  @IdNvo     varchar(20),            
  @IdMovNvo  varchar(20),            
  @IdMovNvo2 varchar(20),            
  @MovtipoNvo varchar(20),               
  @IdOrigenNvo  int,            
  @Aplica    varchar(20),            
  @AplicaID varchar(20),            
  @IDdetalle varchar(20),            
  @Contador  int ,             
  @ContadorD int             
                
  --- Inicializa             
  SELECT @Tipo = 'CxC', @IdNvo = @MovIdCxc, @IdMovNvo= @MovCxc, @Contador = 0, @ContadorD = 0, @MovtipoNvo = ''             
  
        ----SELECT 'text ', @IdNvo IdMov , @IdMovNvo Movimiento, @Tipo Tipo,@MovtipoNvo MovtipoNvo, @IdOrigenNvo IdNuevo   --- Test            
  
        WHILE @MovtipoNvo NOT IN('VTAS.F','CXC.EST')  AND @Contador < 10            
        BEGIN            
          
         SELECT @Tipo=OModulo, @IdMovNvo=OMov, @IdNvo=(OMovId),@IdOrigenNvo=isnull(mf.OID,0), @MovtipoNvo = Mt.Clave            
           FROM MovFlujo mf, Movtipo Mt WHERE mf.OMov=Mt.Mov             
           AND mf.DMov = @IdMovNvo AND mf.DMovID = @IdNvo AND DModulo = 'CXC'
                Order BY OMovId DESC             
                          
          IF @MovtipoNvo = 'CXC.EST'          
           BEGIN          
             SELECT @IdOrigenNvo = OID,@IdNvo = OMovID,@IdMovNvo = OMov          
              FROM MovFlujo mf, Movtipo Mt WHERE mf.OMov=Mt.Mov             
               AND mf.DMov = @MovCxC AND mf.DMovID = @MovIDCxC AND DModulo = 'CXC'         
              ORDER BY OMovId DESC             
           END          
             
         SELECT @Contador = @Contador + 1            
  
         -----SELECT @IdNvo IdMov , @IdMovNvo Movimiento, @Tipo Tipo,@MovtipoNvo MovtipoNvo, @IdOrigenNvo IdNuevo, @Contador   --- Test            
  
        END            
                    
    IF @Contador > 10 SELECT @IdNvo = NULL, @IdMovNvo = NULL, @IdOrigenNvo = 0            
    ---IF @Contador < 10 SELECT @IdOrigenNvo = id FROM venta WHERE Mov = @IdMovNvo AND MovID = @IdNvo    
      SELECT @Aplica = Aplica, @AplicaID = AplicaID FROM CxcD WHERE Id = @IdOrigen            
             
     IF NOT @AplicaID IS NULL             
      BEGIN            
      DECLARE crCxCCte CURSOR FOR            
       SELECT  Id FROM CXc WHERE Mov = @Aplica AND MovId = @AplicaID            
      OPEN crCxCCte            
      FETCH NEXT FROM crCxCCte INTO @IdMovNvo2            
      WHILE @MovtipoNvo <> 'VTAS.F' AND @ContadorD < 10            
      BEGIN  
            
         SELECT @Tipo=OModulo, @IdMovNvo=OMov, @IdNvo=(OMovId),@IdOrigenNvo=mf.OID, @MovtipoNvo = Mt.Clave            
           FROM MovFlujo mf, Movtipo Mt WHERE mf.OMov = Mt.Mov             
           AND mf.DMov = @IdMovNvo2 AND mf.DMovID = @IdNvo AND DModulo = 'CXC'            
                Order BY OMovId DESC             
         SELECT @ContadorD = @ContadorD + 1                   
      FETCH NEXT FROM crCxCCte INTO @IdMovNvo2            
      END            
      CLOSE crCxCCte            
      DEALLOCATE crCxCCte            
      END                  
    SELECT @IdMovResul=@IdNvo, @MovResul=@IdMovNvo, @IdOrigen= @IdOrigenNvo            
    ----SELECT @IdMovResul, @MovResul, @IdOrigen, 'jijo'         ----test     
    ---SELECT @IdNvo IdMov , @IdMovNvo Movimiento, @Tipo Tipo,@MovtipoNvo MovtipoNvo, @IdOrigenNvo IdNuevo , @Contador   --- Test            
  RETURN             
End         
GO


  /************************ spOrigenVentaPMMavi *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spOrigenVentaPMMavi') AND type = 'P') DROP PROCEDURE dbo.spOrigenVentaPMMavi
GO
CREATE PROCEDURE spOrigenVentaPMMavi           
  @Empresa    char(5),        
  @Cliente    char(10),        
  @Estacion int,    
  @TipoCobro int    
--//WITH ENCRYPTION
AS BEGIN        
  DECLARE        
  @IdCxc   int,        
  @IdOrigen   int,        
  @MovIDCxC   varchar(20),        
  @MovCxC   varchar(20),        
  @Clave   varchar(20),        
  @Concepto   varchar(50),    
  @DiasVencActMAVI float,    
  @DiasVencidos  float,    
  @DiasInacActMAVI  float,        
  @DiasInactivos float,    
  @CanalVentas  int,    
  --@CategoriaCanal varchar(50),    
  @SeccionCobranza varchar(50),    
  @PasaMov   int     
        
  DELETE ListaSt WHERE Estacion = @Estacion    
  DELETE CXCFacturaCteMavi WHERE Cliente = @Cliente    
    --select @Mov as 'mov'    
-- Solo para debuggear 12.05.2010 yrg    
 /*SELECT c.PadreMAVI, c.PadreIDMAVI, Id, c.Mov, c.MovID FROM CxcPendiente C        
      JOIN MovTipo ON MovTipo.Mov = C.Mov         
    WHERE c.Empresa = @Empresa AND c.Cliente = @Cliente        
          AND MovTipo.Mov ----= 'Endoso'         
IN ('Factura','Factura VIU','Factura Mayoreo','Credilana','Prestamo Personal',        
              'Seguro Auto','Seguro Vida','Nota Cargo','Nota Cargo VIU','Nota Cargo Mayoreo','Refinanciamiento','Cta Incobrable F',        
              'Cta Incobrable NV','Cheque Devuelto','Endoso','Documento') AND Modulo = 'CxC'         
   */    
  DECLARE crCxCCte2 CURSOR FOR        
   SELECT Id, c.Mov, c.MovID FROM CxcPendiente C        
      JOIN MovTipo ON MovTipo.Mov = C.Mov         
    WHERE c.Empresa = @Empresa AND c.Cliente = @Cliente        
          AND MovTipo.Clave ----= 'Endoso'         
		   IN ('CXC.F') 
          AND Modulo = 'CxC'         
        
   OPEN crCxCCte2        
   FETCH NEXT FROM crCxCCte2 INTO @IdCxc,@MovCxC,@MovIDCxC        
   WHILE @@FETCH_STATUS = 0        
   BEGIN         
     --SELECT 'DEBUG 01'
     SELECT @PasaMov = 1     
     SELECT @Concepto = Concepto FROM CXC WHERE ID = @IdCxc             
     --IF (@Concepto not in ('CANC COBRO CRED Y PP', 'CANC COBRO FACTURA','CANC COBRO SEG AUTO','CANC COBRO SEG VIDA', 'CANC COBRO FACTURA VIU','CANC COBRO MAYOREO')) OR (@Concepto IS NULL)        
     IF @MovCxC in ('Nota Cargo','Nota Cargo VIU','Nota Cargo Mayoreo')    
       IF @Concepto in ('CANC COBRO CRED Y PP', 'CANC COBRO FACTURA','CANC COBRO SEG AUTO','CANC COBRO SEG VIDA', 'CANC COBRO FACTURA VIU','CANC COBRO MAYOREO')-- OR (@Concepto IS NULL)          
         SELECT @PasaMov = 1     
       ELSE    
         SELECT @PasaMov = 1 --0    
     IF @PasaMov = 1        
     BEGIN          
        
       SELECT @Clave = Clave FROM MovTipo WHERE Modulo = 'CXC' AND Mov = @MovCxC        
        
  -------- Prueba        
  --------declare @MovIDCxC int, @MovCxC varchar(20), @IdOrigen int        
  --------set @MovIDCxC = 13452        
  --------        
  --------       EXEC spMAviBuscaCxCVenta 'AAA135','Factura', @MovIDCxC output , @MovCxC output, @IdOrigen output        
  --------       EXEC spMAviBuscaCxCVenta 'AAA135','Factura', @MovIDCxC output , @MovCxC output, @IdOrigen output        
  --------select @MovCxC         
    ----- Factura        
    ------SELECT @MovIDCxC MovIDCxC,@MovCxC MovCxC, @MovIDCxC MovIDCxC,  @Clave   clave         
       IF @Clave NOT IN ('CXC.F', 'CXC.DM', /*'CXC.CA',*/'CXC.FAC'/*,'CXC.CAP'*/)        
       BEGIN   
         --SELECT 'DEBUG 02'         
         EXEC spMAviBuscaCxCVentaTest @MovIDCxC,@MovCxC, @MovIDCxC output , @MovCxC output, @IdOrigen output        
          IF  (@MovCxC like 'Nota Cargo%')  or (@MovCxC like 'Prest%')    
         begin     
           select @MovCxC = PadreMAVI FROM CXC WHERE ID = @IdCxC           
           select @MovIDCxC = PadreIDMAVI FROM cxc WHERE ID = @IdCxC    
           select @IdOrigen = ID FROM CXC WHERE Mov = @MovCxC AND MovID = @MovIDCxC    
         end   
         --SELECT 'DEBUG 03', @MovIDCxC, @IdOrigen     
         IF NOT @MovIDCxC IS NULL AND NOT @IdOrigen is null -------@MovCxC IS NULL         
         BEGIN        
           IF NOT EXISTS(SELECT * FROM CXCFacturaCteMavi WHERE cliente = @Cliente AND Empresa = @Empresa AND IdOrigen = @IdOrigen AND IdCxcOrigen = @MovIDCxC AND IdCxCOrigenMov = @MovCxC )--AND Estacion = @Estacion)        
                                                    --Cliente, Empresa, IdOrigen, IdCxcOrigen, IdCxcOrigenMov        
           BEGIN
          --SELECT 'DEBUG 04'          
             -- Se verifica si cumple con las condiciones de dias vencidos y dias Inactivos para aplicar politica de Bonif de moratorios    
             IF @TipoCobro = 1    
             BEGIN   
               -- select 'entra aqui'    
               SELECT @CanalVentas = ClienteEnviarA         
                 FROM CXC WHERE ID = @IdOrigen         
                 --  select * from CXCFacturaCteMavi where Estacion = 123    
    --898692 124331 ZBM20427 select * from cxc where Mov = 'Factura' and movid = 'ZBM20427'  124331    
        
               SELECT @SeccionCobranza = SeccionCobranzaMAVI FROM CteEnviarA WHERE Cliente = @Cliente AND ID = @CanalVentas        
               --SELECT     @SeccionCobranza
               IF @SeccionCobranza <> 'INSTITUCIONES'    
			   BEGIN    
                 IF EXISTS(SELECT * FROM  CxcMavi WHERE ID = @IdOrigen )     
                 BEGIN
                   SELECT @DiasVencActMAVI = ISNULL(DiasVencActMAVI,0), @DiasInacActMAVI = ISNULL(DiasInacActMAVI,0) FROM CxcMavi WHERE ID = @IdOrigen    
                   SELECT @DiasVencidos = Numero, @DiasInactivos = Valor FROM TablaNumD WHERE TablaNum = 'CFG DV-DI POLITICA QUITA MORATORIOS'    
                 --select  @DiasVencActMAVI as '@DiasVencActMAVI'    -- yrg
                 --select @DiasInacActMAVI as '@DiasInacActMAVI'      -- yrg
                   IF @DiasVencActMAVI >= @DiasVencidos OR @DiasInacActMAVI >= @DiasInactivos    
                     INSERT INTO CXCFacturaCteMavi (Cliente, Empresa, IdCxC, IdOrigen, IdCxCOrigen, IdCxCOrigenMov, Estacion)        
                     VALUES (@Cliente, @Empresa, @IdCxC, @IdOrigen, @MovIDCxC, @MovCxC, @Estacion)
            --SELECT 'DEBUG 05'              
                 END
               END        
             END    
             ELSE      
             begin      
               --select 'aki2'
   
               INSERT INTO CXCFacturaCteMavi (Cliente, Empresa, IdCxC, IdOrigen, IdCxCOrigen, IdCxCOrigenMov, Estacion)        
               VALUES (@Cliente, @Empresa, @IdCxC, @IdOrigen, @MovIDCxC, @MovCxC, @Estacion)        
             end      
           END        
         END         
       END         
     --  IF @IdCxc  = 4037869 select 'Pasa 333'  
       IF @Clave IN ('CXC.F', 'CXC.CD',/*'CXC.FAC',*/ 'CXC.DM', /*'CXC.CA',*/'CXC.FAC'/*,'CXC.CAP'*/)        
       BEGIN         
         
         SELECT @IdOrigen = @IdCxc    
         
         IF NOT EXISTS(SELECT * FROM CXCFacturaCteMavi ccm WHERE cliente = @Cliente AND ccm.IdOrigen = @IdOrigen AND ccm.IdCxCOrigenMov = @MovCxC AND Estacion = @Estacion)        
         BEGIN       
           IF @TipoCobro = 1    
           BEGIN     
           -- select  @DiasVencActMAVI as '@DiasVencActMAVI 2'    
            -- select @DiasInacActMAVI as '@DiasInacActMAVI 2'    
             SELECT @CanalVentas = ClienteEnviarA         
               FROM CXC WHERE ID = @IdOrigen         
                     
             SELECT @SeccionCobranza = SeccionCobranzaMAVI FROM CteEnviarA WHERE Cliente = @Cliente AND ID = @CanalVentas        
                   
             IF @SeccionCobranza <> 'INSTITUCIONES'                       
		     BEGIN    
               IF EXISTS(SELECT * FROM  CxcMavi WHERE ID = @IdOrigen )   
               BEGIN  
                 SELECT @DiasVencActMAVI = ISNULL(DiasVencActMAVI,0), @DiasInacActMAVI = ISNULL(DiasInacActMAVI,0) FROM CxcMavi WHERE ID = @IdOrigen    
                 SELECT @DiasVencidos = Numero, @DiasInactivos = Valor FROM TablaNumD WHERE TablaNum = 'CFG DV-DI POLITICA QUITA MORATORIOS'    
                 IF @DiasVencActMAVI >= @DiasVencidos OR @DiasInacActMAVI >= @DiasInactivos              
                   INSERT INTO CXCFacturaCteMavi (Cliente, Empresa, IdCxC, IdOrigen, IdCxCOrigen, IdCxCOrigenMov, Estacion)        
                   VALUES (@Cliente, @Empresa, @IdCxC, @IdCxC, @MovIDCxC, @MovCxC, @Estacion)        
               END
             END    
           END      
           ELSE     
           begin       
             --select 'aki3'    
             INSERT INTO CXCFacturaCteMavi (Cliente, Empresa, IdCxC, IdOrigen, IdCxCOrigen, IdCxCOrigenMov, Estacion)      
             VALUES (@Cliente, @Empresa, @IdCxC, @IdCxC, @MovIDCxC, @MovCxC, @Estacion)       
           end      
         END                                
       END      
     END        
     FETCH NEXT FROM crCxCCte2 INTO @IdCxc,@MovCxC,@MovIDCxC        
 END        
 CLOSE crCxCCte2        
 DEALLOCATE crCxCCte2   
  --select * from CXCFacturaCtePolMMavi where Cliente = @Cliente    
END        
GO


 /************************ spSugerirCobroxFact *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spSugerirCobroxFact') AND type = 'P') DROP PROCEDURE dbo.spSugerirCobroxFact
GO
CREATE PROCEDURE [dbo].[spSugerirCobroxFact]      
      @SugerirPago varchar(20),      
      @Modulo  char(5),      
      @ID   int,      
      @ImporteTotal money, -- = NULL,      
      @Usuario varchar(10),      
   @Estacion int,
   @OrigenModulo		varchar(10) = NULL      
      
-- Se cambia el sp para q inserte en la tabla previa para Negociacion y condonacion de Moratorios antes de generar el cobro      
      
--//WITH ENCRYPTION      
AS BEGIN  -- 1      
  DECLARE      
    @Empresa   char(5),      
    @Sucursal   int,      
    @Hoy    datetime,      
    @Vencimiento  datetime,      
    @DiasCredito  int,      
    @DiasVencido  int,      
    @TasaDiaria   float,      
    @Moneda    char(10),      
    @TipoCambio   float,      
    @Contacto   char(10),      
    @Renglon   float,      
    @Aplica    varchar(20),      
    @AplicaID   varchar(20),      
    @AplicaMovTipo  varchar(20),      
    @Capital   money,      
    @Intereses   money,      
    @InteresesOrdinarios money,      
    @InteresesFijos  money,      
    @InteresesMoratorios money,      
    @ImpuestoAdicional  float,      
    @Importe   money,      
    @SumaImporte  money,      
    @Impuestos   money,      
    @DesglosarImpuestos  bit,      
    @LineaCredito  varchar(20),      
    @Metodo    int,      
    @GeneraMoratorioMAVI char(1),      
    @MontoMinimoMor  float,      
 @CondonaMoratorios int,      
 @IDDetalle   int,      
 @ImpReal   money,      
 @ClaveID   int,      
 @Mov    varchar(20),      
    @MovID    varchar(20),      
 @Valor    varchar(50),      
 @MovNC    varchar(20),      
    @MovIDNC   varchar(20),      
    @IdNc    int,      
    @MoratorioAPagar money,      
    @Concepto   varchar(50),      
    @Origen    varchar(20),      
    @OrigenID   varchar(20),    
    @NotaCredxCanc char(1),
    @AplicaNota varchar(20),
    @AplicaIDNota varchar(20),
    @IDPOS			varchar(50),      
    @MovClave	  varchar(20)	      
      
  -- Se  hace una primer pasada (cursor) para calculo de moratorios hasta donde cubra el importe del cobro      
  --  si @ImporteTotal > 0 se hace una segunda pasada para ver cuanto de los doctos se alcanza a cubrir      
  DELETE NegociaMoratoriosMAVI WHERE IDCobro = @ID --AND Usuario = @Usuario AND Estacion = @Estacion    
  DELETE FROM HistCobroMoratoriosMAVI WHERE IDCobro = @ID ---- pzamudio 30 julio 2010                                                   --    
  IF EXISTS(SELECT * FROM TipoCobroMAVI WHERE IDCobro = @ID)  
    UPDATE TipoCobroMAVI SET TipoCobro = 0  WHERE IDCobro = @ID  
  ELSE  
    INSERT INTO TipoCobroMAVI(IDCobro, TipoCobro) VALUES(@ID, 0)  
    
  SELECT @DesglosarImpuestos = 0 , @Renglon = 0.0, @SumaImporte = 0.0, @ImporteTotal = NULLIF(@ImporteTotal, 0.0), @SugerirPago = UPPER(@SugerirPago), @MoratorioAPagar = 0              
 
  IF @OrigenModulo <> 'POS'
  BEGIN
    SELECT @Empresa = Empresa, @Sucursal = Sucursal, @Hoy = FechaEmision, @Moneda = Moneda, @TipoCambio = TipoCambio, @Contacto = Cliente   FROM Cxc WHERE ID = @ID        
    DELETE CxcD WHERE ID = @ID       
  END ELSE
    SELECT @Empresa = Empresa, @Sucursal = Sucursal, @Hoy = FechaEmision, @Moneda = Moneda, @TipoCambio = TipoCambio, @Contacto = Cliente   FROM POSL WHERE Orden = @ID       
    SELECT @IDPOS = ID FROM POSL WHERE Orden = @ID
    DELETE POSLVenta WHERE ID = @IDPOS       
 
    
  SELECT @MontoMinimoMor = ISNULL(MontoMinMoratorioMAVI,0) FROM EmpresaCfg2 WHERE Empresa = @Empresa         
--Se comento el prestamo personal porque con la nueva configuracion no aplicara a prestamos personales
   CREATE TABLE #NotaXCanc(Mov varchar(20) NULL,MovID varchar(20) NULL)
  INSERT INTO  #NotaXCanc(Mov,MovID)
  SELECT DISTINCT d.mov,d.movid from negociamoratoriosmavi  c, cxcpendiente d, cxc n WHERE c.mov in('Nota Cargo'/*,'Nota Cargo VIU'*/) and d.cliente=@Contacto
  and d.mov=c.mov and d.movid=c.movid and d.padremavi in ('Credilana'/*,'Prestamo Personal'*/) and n.mov=c.mov and n.movid=c.movid
  and n.concepto in ('CANC COBRO CRED Y PP')
        
  -- Tabla donde se inserten las Facturas pendientes de pago del cte (ListaSt)      
   CREATE TABLE #MovsPendientes(ID  int IDENTITY(1,1) NOT NULL,      
          Aplica  varchar(20) NULL,      
          AplicaID  varchar(20) NULL,      
          Vencimiento datetime NULL,      
          Clave   varchar(20) NULL,      
          Saldo   money NULL,      
          Origen  varchar(20) NULL,      
          OrigenId  varchar(20) NULL,     
    NotaCredxCanc char(1) NULL      
          )      
  -- SELECT Clave FROM ListaSt WHERE Estacion = @Estacion    -- yani    
  DECLARE crLista CURSOR FOR             
   SELECT Clave FROM ListaSt WHERE Estacion = @Estacion      
  OPEN crLista      
  FETCH NEXT FROM crLista INTO @ClaveID      
      
  --SELECT Clave as 'Fact Selecc' FROM ListaSt WHERE Estacion = @Estacion  -- yrg      
  --select @ImporteTotal as 'ImporteTotal'  -- yrg      
  --select @SumaImporte as 'SumaImporte'  -- yrg      
  WHILE @@FETCH_STATUS <> -1 AND @ImporteTotal >=  @SumaImporte       
  BEGIN  -- 2      
 IF @@FETCH_STATUS <> -2  AND @ImporteTotal >=  @SumaImporte       
 BEGIN  -- 3      
      --select @ClaveID as 'ClaveID'      
      SELECT @Mov = Mov, @MovId = MovId FROM CXC WHERE ID = @ClaveID      
      SELECT @Valor = RTRIM(@Mov)+'_'+RTRIM(@MovId)      
      /*IF @Mov in ('Credilana','Prestamo Personal')    
        SET @NotaCredxCanc = '1'    
      ELSE    
        SET @NotaCredxCanc = NULL    */
      --SELECT @Valor as 'VALOR 1'  -- yrg      
      --   SELECT @Mov AS 'mOV'    -- yrg      
      --   SELECT @mOVID AS 'mOVid'  -- yrg      
      SELECT @MovClave = m.Clave 
        FROM Cxc c
		JOIN MovTipo m ON c.Mov = m.Mov AND m.Modulo = 'CXC'
	   WHERE c.ID = @ClaveID         
      
      -- Se verifica si el mov tiene hijos pendientes
      IF @MovClave = 'CXC.CA'
      INSERT INTO #MovsPendientes(Aplica, AplicaId, Vencimiento, Clave, Saldo, Origen, OrigenID)
      SELECT c.Mov, c.MovID, c.Vencimiento, @MovClave, ISNULL(c.Saldo*1* c.TipoCambio/@TipoCambio, 0.0), c.PadreMAVI, c.PadreIDMAVI       
        FROM Cxc C    
       WHERE c.Empresa = @Empresa AND ID = @ClaveID
      ELSE             
      INSERT INTO #MovsPendientes(Aplica, AplicaId, Vencimiento, Clave, Saldo, Origen, OrigenID)      
      SELECT c.Mov, c.MovID, c.Vencimiento, mt.Clave, ISNULL(c.Saldo*mt.Factor* c.TipoCambio/@TipoCambio, 0.0), c.PadreMAVI, c.PadreIDMAVI       
        FROM Cxc C    
        JOIN MovTipo mt ON mt.Modulo = @Modulo AND mt.Mov = c.Mov             
       WHERE c.Empresa = @Empresa AND c.Cliente = @Contacto AND c.estatus = 'PENDIENTE' AND mt.Clave NOT IN ('CXC.SCH','CXC.SD','CXC.NC') and Origen = @Mov AND OrigenID = @MovID                   
    END -- 3    
    FETCH NEXT FROM crLista INTO @ClaveID    
  END -- 2    
  CLOSE crLista    
  DEALLOCATE crLista        
      
      -- Cursor General sobro todos los movs Pendientes   -- yrg      
               
      DECLARE crAplica CURSOR FOR      
       SELECT Aplica, AplicaId, Vencimiento, Clave, Saldo, Origen, OrigenID, NotaCredxCanc      
         FROM #MovsPendientes       
        ORDER BY Vencimiento      
               
      OPEN crAplica      
      FETCH NEXT FROM crAplica INTO @Aplica, @AplicaID, @Vencimiento, @AplicaMovTipo, @Capital, @Origen, @OrigenID, @NotaCredxCanc       
      WHILE @@FETCH_STATUS <> -1 AND @ImporteTotal > @SumaImporte      
      BEGIN  -- 7      
        IF @@FETCH_STATUS <> -2       
        BEGIN  --8      
          --select 'Entra al cursor YANI' -- yrg      
          --SELECT @Aplica+' '+ @AplicaID  -- yrg      
          --select  @Vencimiento as 'Vencim'-- yrg      
       SELECT @CondonaMoratorios = 0, @GeneraMoratorioMAVI = NULL, @IDDetalle = 0, @MoratorioAPagar = 0            
          
    SELECT @IDDetalle = ID FROM CXC WHERE Mov = @Aplica AND MovId = @AplicaID --AND OrigenTipo = 'CXC'          
               --select @Aplica as 'Aplica'  -- yrg      
               --select @AplicaID as 'AplicaID' -- yrg      
     -- Si el docto esta en tiempo de pagarse no se le generan moratorios solo se traspasa al detalle del cobro      
      -- Verificar si el mov, el canal de venta y el cliente deben generar moratorios      
    SELECT @GeneraMoratorioMAVI = dbo.fnGeneraMoratorioMAVI(@IDDetalle)  
    
    IF (SELECT DescuentoRecargos FROM Cte WHERE Cliente = @Contacto) = 1  
		select @GeneraMoratorioMAVI = '1'
		
    IF @GeneraMoratorioMAVI = '1' --OR @Aplica = 'Cargo Moratorio'     
    BEGIN  --9      
      --select @GeneraMoratorioMAVI as 'Genera Mor'   -- yrg      
      SELECT @InteresesMoratorios = 0      
      --IF @Aplica <> 'Cargo Moratorio'  250511  
        SELECT @InteresesMoratorios = dbo.fnInteresMoratorioMAVI(@IDDetalle)
      /*--ELSE  
      BEGIN  
        SELECT @InteresesMoratorios = @Capital  
        SELECT @Capital = 0  
      END  */  
          
      SELECT @MoratorioAPagar = @InteresesMoratorios             
      
     --SELECT @InteresesMoratorios as 'Imp Moratorio'   -- YRG      
      IF @InteresesMoratorios <= @MontoMinimoMor AND  @InteresesMoratorios > 0      
      BEGIN  -- 10      
        -- Aun cuando el usuario est‚ autorizado a condonar moratorios, si estos son menores al monto m¡nimo se condonan y registran      
              IF EXISTS(SELECT * FROM CondonaMorxSistMAVI WHERE IDCobro = @ID AND IDMov = @IDDetalle AND Estatus = 'ALTA')      
                UPDATE CondonaMorxSistMAVI      
                   SET MontoOriginal = @InteresesMoratorios,      
                       MontoCondonado =  @InteresesMoratorios      
                 WHERE IDCobro = @ID AND IDMov = @IDDetalle AND Estatus = 'ALTA'      
      
              ELSE      
                INSERT INTO CondonaMorxSistMAVI(Usuario,  FechaAutorizacion, IDMov,   RenglonMov, Mov, MovID,  MontoOriginal,    MontoCondonado, TipoCondonacion, Estatus, IDCobro)      
                                       VALUES(@Usuario, Getdate(),   @IDDetalle, 0,   @Aplica, @AplicaID, @InteresesMoratorios, @InteresesMoratorios, 'Por Sistema', 'ALTA', @ID)       
              SELECT @InteresesMoratorios = 0      
   END  --  10      
                
    END   -- 9      
    ELSE   SELECT @InteresesMoratorios = 0      
     -- Intereses Moratorios                           
          IF @InteresesMoratorios > 0 --OR @Aplica = 'Cargo Moratorio'      
          BEGIN      
      
          IF @SumaImporte + @InteresesMoratorios > @ImporteTotal SELECT @MoratorioAPagar = @ImporteTotal - @SumaImporte      
             SELECT @SumaImporte = @SumaImporte + @MoratorioAPagar      
      
              INSERT NegociaMoratoriosMAVI( IDCobro, Estacion, Usuario, Mov, MovID, ImporteReal, ImporteAPagar, ImporteMoratorio, ImporteACondonar, MoratorioAPagar, Origen, OrigenID)      
                                    VALUES(@ID, @Estacion, @Usuario, @Aplica, @AplicaId, @Capital, 0, @InteresesMoratorios, 0, @MoratorioAPagar, @Origen, @OrigenId)      

            IF @Aplica IN ('Nota Cargo'/*,'Nota Cargo VIU'*/)
					BEGIN
					  SELECT @AplicaNota= ISNULL(Mov,'NA'), @AplicaIDNota = ISNULL(MovID,'NA') FROM #NotaXCanc WHERE Mov=@Aplica and MovID=@AplicaID 
						  IF @AplicaNota <> 'NA' AND @AplicaIDNota <> 'NA'
							UPDATE NegociaMoratoriosMAVI SET NotaCreditoxCanc = '1' WHERE IDCobro = @ID AND Estacion = @Estacion AND Mov = @Aplica AND MovID = @AplicaID      
					  END     
          END      
        END -- 8      
        FETCH NEXT FROM crAplica INTO @Aplica, @AplicaID, @Vencimiento, @AplicaMovTipo, @Capital, @Origen, @OrigenID, @NotaCredxCanc       
          
      END --7       CLOSE crAplica      
   DEALLOCATE crAplica      
--      DROP TABLE #MovsPendientes      
                        
      IF @Modulo = 'CXC' AND @SumaImporte <=  @ImporteTotal       
      BEGIN  -- 1      
        
        DECLARE crDocto CURSOR FOR      
         SELECT Aplica, AplicaId, Vencimiento, Clave, Saldo, Origen, OrigenID, NotaCredxCanc      
           FROM #MovsPendientes       
          ORDER BY Vencimiento      
                        
        OPEN crDocto      
        FETCH NEXT FROM crDocto INTO @Aplica, @AplicaID, @Vencimiento, @AplicaMovTipo, @Capital,  @Origen, @OrigenID, @NotaCredxCanc      
        WHILE @@FETCH_STATUS <> -1 AND @ImporteTotal >= @SumaImporte       
        BEGIN  -- 11      
          IF @@FETCH_STATUS <> -2       
          BEGIN  -- 12      
            -- Capital      
            --select @SumaImporte as 'SUMA IMPORTE'  --yrg      
            SELECT @ImpReal = @Capital      
            IF @SumaImporte + @Capital > @ImporteTotal SELECT @Capital = @ImporteTotal - @SumaImporte      
              SELECT @SumaImporte = @SumaImporte + @Capital      
      
              --select @Capital as 'Capital'  -- yrg      
            IF @Capital > 0      
              IF EXISTS(SELECT * FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID AND Estacion = @Estacion AND Mov = @Aplica AND MovID = @AplicaID)      
              begin  -- yrg  13      
                --select 'Entra a act Capital de Doctos'      
                UPDATE NegociaMoratoriosMAVI      
                   SET ImporteAPagar = @Capital      
                 WHERE Estacion = @Estacion      
                   AND Mov      = @Aplica      
                   AND MovID    = @AplicaID      

			IF @Aplica IN ('Nota Cargo'/*,'Nota Cargo VIU'*/)
					BEGIN
					  SELECT @AplicaNota= ISNULL(Mov,'NA'), @AplicaIDNota = ISNULL(MovID,'NA') FROM #NotaXCanc WHERE Mov=@Aplica and MovID=@AplicaID 
						  IF @AplicaNota <> 'NA' AND @AplicaIDNota <> 'NA'
							UPDATE NegociaMoratoriosMAVI SET NotaCreditoxCanc = '1' WHERE IDCobro = @ID AND Estacion = @Estacion AND Mov = @Aplica AND MovID = @AplicaID      
					  END 
                   end  -- 13      
            ELSE       
              INSERT NegociaMoratoriosMAVI( IDCobro, Estacion, Usuario, Mov, MovID, ImporteReal, ImporteAPagar, ImporteMoratorio, ImporteACondonar, Origen, OrigenID, NotaCreditoxCanc)      
              VALUES(@ID, @Estacion, @Usuario, @Aplica, @AplicaId, @ImpReal, @Capital, @InteresesMoratorios, 0, @Origen, @OrigenID, @NotaCredxCanc)      
         
     IF @Aplica IN ('Nota Cargo'/*,'Nota Cargo VIU'*/)
					BEGIN
					  SELECT @AplicaNota= ISNULL(Mov,'NA'), @AplicaIDNota = ISNULL(MovID,'NA') FROM #NotaXCanc WHERE Mov=@Aplica and MovID=@AplicaID 
						  IF @AplicaNota <> 'NA' AND @AplicaIDNota <> 'NA'
							UPDATE NegociaMoratoriosMAVI SET NotaCreditoxCanc = '1' WHERE IDCobro = @ID AND Estacion = @Estacion AND Mov = @Aplica AND MovID = @AplicaID      
					  END     
          END  --12      
          FETCH NEXT FROM crDocto INTO @Aplica, @AplicaID, @Vencimiento, @AplicaMovTipo, @Capital,  @Origen, @OrigenID, @NotaCredxCanc       
        END -- 11      
        CLOSE crDocto      
        DEALLOCATE crDocto      
      END -- 10      

  DROP TABLE #NotaXCanc
  DROP TABLE #MovsPendientes  -- yani 23.12.09      

  RETURN      
END  -- 1      
GO


 /************************ spTipoPagoBonifMAVI *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spTipoPagoBonifMAVI') AND type = 'P') DROP PROCEDURE dbo.spTipoPagoBonifMAVI
GO
CREATE PROCEDURE spTipoPagoBonifMAVI      
      @SugerirPago varchar(20),           
      @ID   int           
 --//WITH ENCRYPTION
AS BEGIN     -- 1   
  DECLARE      
    @Empresa   char(5),      
    @Sucursal   int,      
    @Hoy   datetime,      
    @Vencimiento  datetime,      
    @DiasCredito  int,      
    @DiasVencido  int,      
    @TasaDiaria   float,      
    @Moneda   char(10),      
    @TipoCambio   float,      
    @Contacto   char(10),      
    @Renglon   float,      
    @Aplica   varchar(20),      
    @AplicaID   varchar(20),      
    @AplicaMovTipo  varchar(20),      
    @Capital   money,      
    @Intereses   money,      
    @InteresesOrdinarios money,      
    @InteresesFijos  money,      
    @InteresesMoratorios money,      
    @ImpuestoAdicional  float,      
    @Importe   money,      
    @SumaImporte  money,      
    @Impuestos   money,      
    @DesglosarImpuestos  bit,      
    @LineaCredito  varchar(20),      
    @Metodo   int,      
    @GeneraMoratorioMAVI char(1),      
    @MontoMinimoMor   float,      
 @CondonaMoratorios  int,      
 @IDDetalle    int,      
 @ImpReal    money,      
 @MoratorioAPagar  money,      
    @Origen    varchar(20),      
    @OrigenID   varchar(20),      
    @TipoPago   char(1),      
    @ImporteReal  money,      
 @ImporteAPagar  money,      
    @DocsPend   int,      
    @DocsPendNeg  int,    
 @NotasCargoCanc  int, 
    @Padre			varchar(20),
	@PadreID		varchar(20)    
      
  SELECT @Empresa = Empresa, @Sucursal = Sucursal, @Hoy = FechaEmision, @Moneda = Moneda, @TipoCambio = TipoCambio, @Contacto = Cliente   FROM Cxc WHERE ID = @ID       
        
  IF @SugerirPago = 'SALDO TOTAL' SELECT @TipoPago = 'T'      
    UPDATE NegociaMoratoriosMAVI      
       SET TipoPago = @TipoPago      
     WHERE IDCobro = @ID      
      
  IF @SugerirPago <> 'SALDO TOTAL'  -- Recorrer NegociaMoratoriosMAVI en busca de Facturas q se liquidan      
  BEGIN      -- 2  
    DECLARE crFactLiq CURSOR FOR      
     SELECT Mov, MovID, ImporteReal, ImporteAPagar, Origen, OrigenId      
       FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID          
    OPEN crFactLiq      
    FETCH NEXT FROM crFactLiq INTO @Aplica, @AplicaID, @ImporteReal, @ImporteAPagar, @Origen, @OrigenID      
    WHILE @@FETCH_STATUS <> -1       
    BEGIN    -- 3  
      IF @@FETCH_STATUS <> -2       
      BEGIN    -- 4  
        IF @Origen <> NULL      
        BEGIN  -- 5 Verifica si se esta liquidando la factura      
          -- Se verifica el num de doctos por factura      
          SELECT @DocsPend = 0, @DocsPendNeg = 0, @NotasCargoCanc = 0      
          SELECT @DocsPend = COUNT(*) FROM Cxc WHERE PadreMAVI = @Origen AND PAdreIDMAVI = @OrigenID /*AND OrigenTipo = 'CXC'*/ AND Estatus = 'PENDIENTE'       
          /*SELECT @NotasCargoCanc  = COUNT(*) FROM NegociaMoratoriosMAVI      
           WHERE Origen = @Origen AND OrigenID = @OrigenID AND IDCobro = @ID       
             AND Mov in ('Nota Cargo', 'NotaCargo VIU' )    */
       -- select @DocsPend as 'DocsPend Cxc para ese origen'      
          SELECT @DocsPendNeg = COUNT(*) FROM NegociaMoratoriosMAVI      
           WHERE Origen = @Origen AND OrigenID = @OrigenID AND IDCobro = @ID       
             AND ImporteReal = ImporteAPagar                
            
          -- 06.05.2010 ya no va IF @NotasCargoCanc > 0 SELECT @DocsPend = ISNULL(@DocsPend,0) + ISNULL(@NotasCargoCanc,0)    
          --SELECT @DocsPendNeg as 'Docs Pends Negocia..'      
          --select @DocsPend as 'Docs Pend'  
          IF @DocsPend = @DocsPendNeg      
          begin -- 6  
            --select ' s¡ actualiza'  
            UPDATE NegociaMoratoriosMAVI      
               SET TipoPago = 'T'      
             WHERE Origen = @Origen AND OrigenID = @OrigenID AND IDCobro = @ID       
               AND ImporteReal = ImporteAPagar      
end -- 6  
        END ELSE      
        BEGIN    -- 7  
          SELECT @IDDetalle = ID FROM CXC WHERE Mov = @Aplica AND MovId = @AplicaID       
          SELECT @DocsPend = 0, @DocsPendNeg = 0      
          SELECT @DocsPend = COUNT(*) FROM Cxc WHERE PadreMAVI = @Origen AND PadreIDMavi = @OrigenID AND OrigenTipo = 'CXC' AND Estatus = 'PENDIENTE'       
          SELECT @DocsPendNeg = COUNT(*) FROM NegociaMoratoriosMAVI      
           WHERE Origen = @Origen AND OrigenID = @OrigenID AND IDCobro = @ID       
             AND ImporteReal = ImporteAPagar                
            
          IF @DocsPend = @DocsPendNeg      
            UPDATE NegociaMoratoriosMAVI      
               SET TipoPago = 'T'      
             WHERE Origen = @Origen AND OrigenID = @OrigenID AND IDCobro = @ID       
               AND ImporteReal = ImporteAPagar              
      
        END    --7  
        FETCH NEXT FROM crFactLiq INTO @Aplica, @AplicaID, @ImporteReal, @ImporteAPagar, @Origen, @OrigenID      
      END    -- 5  
    END    -- 4  
    CLOSE crFactLiq      
    DEALLOCATE crFactLiq      
    END    -- 3  
      
  RETURN      
END --2  
GO


 /************************ spValidaAutorizacionCondMAVI *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spValidaAutorizacionCondMAVI') AND type = 'P') DROP PROCEDURE dbo.spValidaAutorizacionCondMAVI
GO
CREATE PROCEDURE spValidaAutorizacionCondMAVI    
      --@Modulo   char(5),    
      @ID    int,    
      @Usuario  varchar(10),    
   @Estacion  int    
--//WITH ENCRYPTION 
AS BEGIN    
  DECLARE @UsuarioCondona     varchar(10),    
   @PorcentajeCondMoratorioMAVI float,    
   @PorcentajeReal     float,    
   @Mov       varchar(20),    
   @MovId       varchar(20),    
   @SePasa       char(1),    
   @ImporteACondonar    money,    
   @ImporteMoratorio    money    
    
  IF (SELECT COUNT(*) FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID AND Estacion = @Estacion AND MoratorioAPagar > 0  AND ImporteACondonar = 0) = ( SELECT COUNT(*) FROM  NegociaMoratoriosMAVI WHERE IDCobro = @ID AND Estacion = @Estacion AND MoratorioAPagar > 0 )    
  begin    
    SELECT @SePasa = '3' -- No condonaron nada    
    --select 'entro al primero'    
  end    
  ELSE    
    IF EXISTS(SELECT * FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID AND Estacion = @Estacion AND MoratorioAPagar > 0  AND ImporteACondonar > 0)     
    BEGIN    
      -- Validar primero si esta autorizado --IF EXISTS    
      SELECT DISTINCT @UsuarioCondona = UsuarioCondona FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID AND Estacion = @Estacion     
      --select @UsuarioCondona as 'UsuaCond' --yrg    
  IF @UsuarioCondona IS NOT NULL    
  BEGIN    
        --select 'No hay autorizacion para condonar...Verifique'          
      SELECT @PorcentajeCondMoratorioMAVI = PorcentajeCondMoratorioMAVI FROM UsuarioCfg2 WHERE Usuario = @Usuario    
    --SELECT PorcentajeCondMoratorioMAVI FROM UsuarioCfg2 WHERE Usuario = @UsuarioCondona --yrg    
    --SELECT @PorcentajeCondMoratorioMAVI as 'Porcusua' -- yrg    
      SELECT @SePasa = '2'    
    -- ciclo para verificar que no haya sobrepasado el % que tiene autorizado a condonar    
    
   DECLARE crCond CURSOR FOR    
    SELECT Mov, MovID, MoratorioAPagar, ImporteACondonar    
   FROM NegociaMoratoriosMAVI    
     WHERE IDCobro = @ID AND Estacion = @Estacion AND ImporteACondonar > 0    
      
   OPEN crCond      
   FETCH NEXT FROM crCond INTO @Mov, @MovID, @ImporteMoratorio, @ImporteACondonar    
   WHILE @@FETCH_STATUS <> -1     
   BEGIN  --     
      IF @@FETCH_STATUS <> -2     
      BEGIN    --     
    -- Se aplica regla de 3    
    --select @ImporteACondonar as 'Imp a condonar'    
    --select @ImporteMoratorio as 'Moratorio'    
     SELECT @PorcentajeReal = ((@ImporteACondonar)/ @ImporteMoratorio)*100.0    
    --select '((@ImporteACondonar )/ @ImporteMoratorio)*100.0'    
    --select @PorcentajeReal as 'Porc Real'  --yrg    
    IF @PorcentajeReal > @PorcentajeCondMoratorioMAVI    
    SELECT @SePasa = '1'        
      END    
   FETCH NEXT FROM crCond INTO @Mov, @MovID, @ImporteMoratorio, @ImporteACondonar    
   END    
  CLOSE crCond    
  DEALLOCATE CrCond    
 END    
 ELSE    
  SELECT @SePasa = '4'    
    END    
     
  SELECT @SePasa     
        
  RETURN    
END  -- 1    
GO


 /************************ spValidaNivelAccesoAgente *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spValidaNivelAccesoAgente') AND type = 'P') DROP PROCEDURE dbo.spValidaNivelAccesoAgente
GO

CREATE PROC spValidaNivelAccesoAgente
		@ID int, @Modulo varchar(5), @Ok int OUTPUT, @OkRef varchar(255) OUTPUT  
--//WITH ENCRYPTION
AS BEGIN 
DECLARE 	--	@ID int, @Modulo varchar(5), @Ok int , @OkRef varchar(255) ,  

	@Agente varchar(10), 
	@Agente2 varchar(10),  
	@Usuario varchar(30), 
	@NivelAcceso varchar(100), 
	@NivelAcceso2 varchar(100), 
	@Texto varchar(50), 
	@Texto2 varchar(50), 
	@Origen varchar(20), 
	@Valida bit   

	--SELECT @id=116, @modulo='cxc' 
	--SELECT @OkRef='Intelisis'
	SELECT @Valida=1

	IF (@Modulo IN ('COMS', 'CXP', 'VTAS', 'CXC', 'DIN', 'INV', 'ST', 'AGENT', 'EMB'))
	BEGIN 
		IF (@Modulo = 'COMS') 
				SELECT @Agente=Agente, @Usuario=Usuario, @Texto='Agente: ', @Origen=Origen FROM Compra WHERE ID=@ID --AND Origen IS NULL 	
		
		IF (@Modulo = 'CXP') 
				SELECT @Agente=Cajero, @Usuario=Usuario, @Texto='Cajero: ', @Origen=Origen FROM CxP WHERE ID=@ID --AND Origen IS NULL 
		
		IF (@Modulo = 'VTAS') 
		BEGIN 
				SELECT @Agente=Agente, @Agente2=AgenteServicio, @Usuario=Usuario, @Texto='Agente: ', @Origen=Origen FROM Venta WHERE ID=@ID --AND Origen IS NULL 

			IF ((SELECT M.Clave FROM Venta V, MovTipo M WHERE V.ID=@ID AND V.Mov=M.Mov AND M.Modulo='VTAS') IN ('VTAS.SD') )
				IF ((SELECT TOP 1 IDCopiaMavi FROM VentaD WHERE ID=@ID) IS NOT NULL )
				--	SELECT @Agente=NULL, @Agente2=NULL, @Usuario=NULL, @Texto=NULL, @Texto2=NULL 
					SELECT @Valida=0
		END

		IF (@Modulo = 'CXC') 
				SELECT @Agente=Agente, @Agente2=Cajero, @Usuario=Usuario, @Texto='Agente: ', @Texto2='Cajero: ', @Origen=Origen FROM CxC WHERE ID=@ID --AND Origen IS NULL 

		IF (@Modulo = 'DIN') 
				SELECT @Agente=Cajero, @Usuario=Usuario, @Texto='Cajero: ', @Origen=Origen  FROM Dinero WHERE ID=@ID --AND Origen IS NULL 

		IF (@Modulo = 'INV') 
				SELECT @Agente=Agente, @Usuario=Usuario, @Texto='Agente: ', @Origen=Origen  FROM Inv WHERE ID=@ID --AND Origen IS NULL 

		IF (@Modulo = 'ST') 
				SELECT @Agente=Agente, @Usuario=Usuario, @Texto='Agente: ', @Origen=Origen  FROM Soporte WHERE ID=@ID --AND Origen IS NULL 

		IF (@Modulo = 'AGENT') 
				SELECT @Agente=Agente, @Usuario=Usuario, @Texto='Agente: ', @Origen=Origen  FROM Agent WHERE ID=@ID --AND Origen IS NULL 

		IF (@Modulo = 'EMB') 
				SELECT @Agente=Agente, @Agente2=Agente2, @Usuario=Usuario, @Texto='Agente: ', @Texto='Agente: ', @Origen=Origen  FROM Embarque WHERE ID=@ID --AND Origen IS NULL 	

		IF (@Valida=1 AND @Origen IS NULL )
-- validacion 1: el agente del mov este en la tabla de agente
		IF (@Agente NOT IN ('', NULL) OR @Agente2 NOT IN ('', NULL) )
		--BEGIN
 			IF ( @Agente IS NOT NULL AND NOT EXISTS (SELECT Agente FROM Agente WHERE Agente=@Agente ) 
			 OR (@Agente2 IS NOT NULL AND NOT EXISTS(SELECT Agente FROM Agente WHERE Agente=@Agente2 ) ))
				SELECT @Ok=26090, @OkRef=CASE WHEN (@Agente IS NOT NULL AND NOT EXISTS (SELECT Agente FROM Agente 
					WHERE Agente=@Agente ) AND @Agente2 IS NULL) OR (@Agente IS NOT NULL AND NOT EXISTS (SELECT Agente FROM Agente 
					WHERE Agente=@Agente ) AND @Agente2 IS NOT NULL AND EXISTS(SELECT Agente FROM Agente WHERE Agente=@Agente2 )) 
						THEN @Agente 
								WHEN (@Agente2 IS NOT NULL AND NOT EXISTS (SELECT Agente FROM Agente WHERE Agente=@Agente2 ) 
									AND @Agente IS NULL) OR (@Agente2 IS NOT NULL AND NOT EXISTS (SELECT Agente FROM Agente 
					WHERE Agente=@Agente2 ) AND @Agente IS NOT NULL AND EXISTS(SELECT Agente FROM Agente WHERE Agente=@Agente ))  
					THEN @Agente2 
								WHEN @Agente IS NOT NULL AND NOT EXISTS (SELECT Agente FROM Agente WHERE Agente=@Agente ) 
									AND @Agente2 IS NOT NULL AND NOT EXISTS (SELECT Agente FROM Agente WHERE Agente=@Agente2 ) 
										THEN @Agente + char(10) + @Agente2  END	-- El Agente No Existe
			ELSE
			BEGIN 
	-- validacion 2: el agente este ligado a un grupo de trabajo o un usuario 

				SELECT @NivelAcceso=NivelAcceso FROM Agente WHERE Agente=@Agente 
				SELECT @NivelAcceso2=NivelAcceso FROM Agente WHERE Agente=@Agente2 
	--select @nivelacceso, @nivelacceso2
				IF (@NivelAcceso /*(SELECT NivelAcceso FROM Agente WHERE Agente=@Agente)*/ NOT IN ('(TODO)', NULL, '(Especifico)') OR
					@NivelAcceso2 /*(SELECT NivelAcceso FROM Agente WHERE Agente=@Agente2)*/ NOT IN ('(TODO)', NULL, '(Especifico)') )
				BEGIN 
					IF (SUBSTRING(@NivelAcceso, 1, 1)/*(SELECT SUBSTRING(NivelAcceso, 1, 1) FROM Agente WHERE Agente = @Agente)*/ <> '('  OR 
							SUBSTRING(@NivelAcceso2, 1, 1)/*(SELECT SUBSTRING(NivelAcceso, 1, 1) FROM Agente WHERE Agente = @Agente2)*/ <> '(' )
					BEGIN 
						IF (@NivelAcceso/*(SELECT NivelAcceso FROM Agente WHERE Agente=@Agente)*/ IS NOT NULL AND @NivelAcceso /*(SELECT NivelAcceso FROM Agente 
							WHERE Agente=@Agente)*/ <> @Usuario  AND @Agente IS NOT NULL AND SUBSTRING(@NivelAcceso, 1, 1) <> '(' ) 
						SELECT @Ok=100034, @OkRef=@Texto + @Agente --'agente ' + @Agente + ' no asignado al usuario ' + @usuario --@Ok=71010 --'No Esta Definido el Usuario' -- 'agente ' + @Agente + ' no asignado al usuario ' + @usuario 

						IF (@NivelAcceso2/*(SELECT NivelAcceso FROM Agente WHERE Agente=@Agente2)*/ IS NOT NULL AND @NivelAcceso2/*(SELECT NivelAcceso FROM Agente 
							WHERE Agente=@Agente2)*/ <> @Usuario  AND @Agente2 IS NOT NULL AND SUBSTRING(@NivelAcceso2, 1, 1) <> '(' )
							SELECT @Ok=100034, @OkRef=@Texto2 + @Agente2 --'agente ' + @Agente2 + ' no asignado al usuario ' + @usuario --@Ok=71010 --'No Esta Definido el Usuario' -- 'agente ' + @Agente2 + ' no asignado al usuario ' + @usuario 

						IF (@NivelAcceso/*(SELECT NivelAcceso FROM Agente WHERE Agente=@Agente)*/ = @Usuario  AND NOT EXISTS (SELECT Usuario FROM 
									Usuario WHERE Usuario=@Usuario)  AND @Agente IS NOT NULL) 
							SELECT @Ok=100031, @OkRef=@Texto + @Agente --'Usuario ' + @usuario + ' Asignado al agente '+ @Agente + ' no existe' --@Ok=71020  --'El Usuario Indicado, No Existe' ---'Usuario ' + @usuario + ' Asignado al agente '+ @Agente + ' no existe'

						IF (@NivelAcceso2/*(SELECT NivelAcceso FROM Agente WHERE Agente=@Agente2)*/ = @Usuario  AND NOT EXISTS (SELECT Usuario FROM 
									Usuario WHERE Usuario=@Usuario)  AND @Agente2 IS NOT NULL) 
							SELECT @Ok=100031, @OkRef=@Texto2 + @Agente2 --'Usuario ' + @usuario + ' Asignado al agente '+ @Agente2 + ' no existe' --@Ok=71020  --'El Usuario Indicado, No Existe' ---'Usuario ' + @usuario + ' Asignado al agente '+ @Agente2 + ' no existe' 

					END -- if usuario 
					
					IF (SUBSTRING(@NivelAcceso, 1, 1) /*(SELECT SUBSTRING(NivelAcceso, 1, 1) FROM Agente WHERE Agente = @Agente)*/ = '('  OR 
							SUBSTRING(@NivelAcceso2, 1, 1)/*(SELECT SUBSTRING(NivelAcceso, 1, 1) FROM Agente WHERE Agente = @Agente2)*/ = '(' )
					BEGIN 
						IF (@NivelAcceso/*(SELECT NivelAcceso FROM Agente WHERE Agente=@Agente)*/ <> (SELECT '(' + GrupoTrabajo + ')' FROM Usuario 
								WHERE Usuario=@Usuario) AND EXISTS (SELECT GrupoTrabajo FROM GrupoTrabajo WHERE '(' 
							+ GrupoTrabajo + ')' = @NivelAcceso /*(SELECT NivelAcceso FROM Agente WHERE Agente=@Agente)*/ ) AND 
							@NivelAcceso NOT IN ('(TODOS)', '(Especifico)', NULL)) 
							SELECT @Ok=100032, @OkRef=@Texto + @Agente --'el grupo de trabajo del usuario asignado al agente ' + @Agente + ' no es correcto' --@Ok=71010 --'No Esta Definido el Usuario' --- 'el grupo de trabajo del usuario asignado al agente ' + @Agente + ' no es correcto' 

						IF (@NivelAcceso2/*(SELECT NivelAcceso FROM Agente WHERE Agente=@Agente2)*/ <> (SELECT '(' + GrupoTrabajo + ')' FROM Usuario 
								WHERE Usuario=@Usuario) AND EXISTS (SELECT GrupoTrabajo FROM GrupoTrabajo WHERE '(' 
							+ GrupoTrabajo + ')' = @NivelAcceso2 /*(SELECT NivelAcceso FROM Agente WHERE Agente=@Agente2)*/ ) AND 
							@NivelAcceso NOT IN ('(TODOS)', '(Especifico)', NULL) ) 
							SELECT @Ok=100032, @OkRef=@Texto2 + @Agente2 

						IF ((@NivelAcceso/*(SELECT NivelAcceso FROM Agente WHERE Agente=@Agente)*/ = (SELECT '(' + GrupoTrabajo + ')' FROM Usuario 
								WHERE Usuario=@Usuario) AND NOT EXISTS (SELECT GrupoTrabajo FROM GrupoTrabajo WHERE '(' 
							+ GrupoTrabajo + ')' = @NivelAcceso /*(SELECT NivelAcceso FROM Agente WHERE Agente=@Agente)*/ )) OR 
							(@NivelAcceso /*(SELECT NivelAcceso FROM Agente WHERE Agente=@Agente)*/ <> (SELECT '(' + GrupoTrabajo + ')' FROM Usuario 
								WHERE Usuario=@Usuario) AND NOT EXISTS (SELECT GrupoTrabajo FROM GrupoTrabajo WHERE '(' 
							+ GrupoTrabajo + ')' =@NivelAcceso /*(SELECT NivelAcceso FROM Agente WHERE Agente=@Agente)*/ ) 
								AND ( CASE WHEN SUBSTRING(@NivelAcceso, 1, 1) <> '(' THEN NULL ELSE @NivelAcceso END) NOT IN ('(TODOS)', '(Especifico)', NULL)))    
							SELECT @Ok=100033, @OkRef=@Texto + @Agente --'El grupo de trabajo del usuario asginado al agente ' + @agente + ' no existe'
				
						IF ((@NivelAcceso2/*(SELECT NivelAcceso FROM Agente WHERE Agente=@Agente2)*/ = (SELECT '(' + GrupoTrabajo + ')' FROM Usuario 
								WHERE Usuario=@Usuario) AND NOT EXISTS (SELECT GrupoTrabajo FROM GrupoTrabajo WHERE '(' 
							+ GrupoTrabajo + ')' = @NivelAcceso2 /*(SELECT NivelAcceso FROM Agente WHERE Agente=@Agente2)*/ )) OR 
							(@NivelAcceso2/*(SELECT NivelAcceso FROM Agente WHERE Agente=@Agente2)*/ <> (SELECT '(' + GrupoTrabajo + ')' FROM Usuario 
								WHERE Usuario=@Usuario) AND NOT EXISTS (SELECT GrupoTrabajo FROM GrupoTrabajo WHERE '(' 
							+ GrupoTrabajo + ')' = @NivelAcceso2 /*(SELECT NivelAcceso FROM Agente WHERE Agente=@Agente2)*/ ) 
								AND (CASE WHEN SUBSTRING(@NivelAcceso2, 1, 1) <> '(' THEN NULL ELSE @NivelAcceso2 END) NOT IN ('(TODOS)', '(Especifico)', NULL) ) )
							SELECT @Ok=100033, @OkRef=@Texto2 + @Agente2 --'El grupo de trabajo del usuario asginado al agente ' + @agente + ' no existe'

					END -- if grupo

				END	 -- if usuario o grupo (no null, no especifico y no todo )		
				--ELSE 
					IF (@NivelAcceso/*(SELECT NivelAcceso FROM Agente WHERE Agente=@Agente)*/ = '(Especifico)' OR
						@NivelAcceso2/*(SELECT NivelAcceso FROM Agente WHERE Agente=@Agente2)*/ = '(Especifico)')
					BEGIN  --select @nivelacceso, @nivelacceso2
						IF (NOT EXISTS (SELECT Usuario FROM AgenteAcceso WHERE Agente=@Agente AND Usuario=@Usuario ) AND @Agente IS NOT NULL
							AND @NivelAcceso /*(SELECT NivelAcceso FROM Agente WHERE Agente=@Agente)*/ = '(Especifico)') 
						SELECT @Ok=100034, @OkRef=@Texto + @Agente --'agente ' + @agente + ' no asignado al usuario ' + @usuario 

						IF (NOT EXISTS (SELECT Usuario FROM AgenteAcceso WHERE Agente=@Agente2 AND Usuario=@Usuario ) AND @Agente2 IS NOT NULL
							AND @NivelAcceso2 /*(SELECT NivelAcceso FROM Agente WHERE Agente=@Agente2)*/ = '(Especifico)') 
						SELECT @Ok=100034, @OkRef=@Texto2 + @Agente2 --'agente ' + @agente2 + ' no asignado al usuario ' + @usuario 

						IF (EXISTS (SELECT Usuario FROM AgenteAcceso WHERE Agente=@Agente AND Usuario=@Usuario ) AND NOT EXISTS 
								(SELECT Usuario FROM Usuario WHERE Usuario=@Usuario)  AND @Agente IS NOT NULL AND @NivelAcceso /*(SELECT NivelAcceso 
									FROM Agente WHERE Agente=@Agente)*/ = '(Especifico)') 
						SELECT @Ok=100031, @OkRef=@Texto + @Agente --'agente ' + @agente + ' asignado al usuario ' + @usuario + ' no existe' 

						IF (EXISTS (SELECT Usuario FROM AgenteAcceso WHERE Agente=@Agente2 AND Usuario=@Usuario ) AND NOT EXISTS 
								(SELECT Usuario FROM Usuario WHERE Usuario=@Usuario)  AND @Agente2 IS NOT NULL AND @NivelAcceso2 /*(SELECT NivelAcceso 
									FROM Agente WHERE Agente=@Agente2)*/ = '(Especifico)') 
						SELECT @Ok=100031, @OkRef=@Texto2 + @Agente2 --'agente ' + @agente + ' asignado al usuario ' + @usuario + ' no existe' 

					END -- if espcifico
			END	-- if agente existe
		--END -- if si el agente no es nulo o vacio
	END -- if de modulos
--select @ok, @okref

--select @ok, @okref
	RETURN

END -- as begin
GO


 /************************ spValidaNumFactSelMAVI *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spValidaNumFactSelMAVI') AND type = 'P') DROP PROCEDURE dbo.spValidaNumFactSelMAVI
GO
CREATE PROCEDURE spValidaNumFactSelMAVI
     -- @Modulo  char(5),    
    @ID INT ,
    @Estacion INT ,
    @CobroXPolitica INT     
-- Se cambia el sp para q inserte en la tabla previa para Negociacion y condonacion de Moratorios antes de generar el cobro        
--//WITH ENCRYPTION    
AS 
    BEGIN  -- 1    
        DECLARE @Mensaje VARCHAR(50) ,
            @Sucursal INT ,
            @Hoy DATETIME ,
            @Vencimiento DATETIME ,
            @TipoCobro INT ,
            @Cantidad INT   
   
        SELECT  @Mensaje = '0'
        SELECT  @TipoCobro = ISNULL(TipoCobro, 0)
        FROM    TipoCobroMAVI
        WHERE   IDCobro = @ID

        SELECT  @Cantidad = COUNT(*)
        FROM    ListaSt
        WHERE   Estacion = @Estacion    
        IF @Cantidad < 1 
            SELECT  @Mensaje = 'Debe Seleccionar al menos un movimiento'
        ELSE 
        BEGIN
            IF @Cantidad > 1 
                SELECT  @Mensaje = 'No puede seleccionar mas de un movimiento'
            ELSE 
                SELECT  @Mensaje = '0'

        END
        SELECT  @Mensaje  

        RETURN    
    END  -- 1    
GO


 /************************ spValidarMayor12Meses *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spValidarMayor12Meses') AND type = 'P') DROP PROCEDURE dbo.spValidarMayor12Meses
GO
CREATE PROC [dbo].[spValidarMayor12Meses] 	
@ID int,
@Mov varchar(20), 
@Modulo varchar(5)
--//WITH ENCRYPTION
AS BEGIN 
DECLARE
@Desglose Bit,
@Mayor12meses bit

IF @Modulo='VTAS'
 BEGIN
  IF @Mov IN('Solicitud Credito','Analisis Credito','Pedido','Factura','Factura VIU')
	BEGIN
  SELECT @Mayor12meses=(SELECT CASE 
					WHEN (SELECT ISNULL(Cond.DANumeroDocumentos, ISNULL(Cond.Meses, (Cond.DiasVencimiento/30) )) FROM Condicion Cond
								WHERE v.Condicion=Cond.Condicion) < 12 OR 
						(SELECT Cond.DANumeroDocumentos FROM Condicion Cond WHERE v.Condicion=Cond.Condicion) = NULL  THEN 0
					WHEN (SELECT ISNULL(Cond.DANumeroDocumentos, ISNULL(Cond.Meses, (Cond.DiasVencimiento/30) )) FROM Condicion Cond
								WHERE v.Condicion=Cond.Condicion)>= 12 OR 
						(SELECT Cond.DANumeroDocumentos FROM Condicion Cond WHERE v.Condicion=Cond.Condicion) >= 12  THEN 1
				END), @Desglose=v.FacDesgloseIVA FROM Venta v WHERE v.ID=@ID
       IF (@Desglose=1 AND @Mayor12meses=1)
        UPDATE Venta SET FacDesgloseIVA=0 WHERE ID=@ID 
    END
  END
IF @Modulo='CXC'
 BEGIN
  IF @Mov IN('Nota Cargo')
	BEGIN
  SELECT @Mayor12meses=(SELECT CASE 
					WHEN (SELECT ISNULL(Cond.DANumeroDocumentos, ISNULL(Cond.Meses, (Cond.DiasVencimiento/30) )) FROM Condicion Cond
								WHERE c.Condicion=Cond.Condicion) < 12 OR 
						(SELECT Cond.DANumeroDocumentos FROM Condicion Cond WHERE c.Condicion=Cond.Condicion) = NULL  THEN 0
					WHEN (SELECT ISNULL(Cond.DANumeroDocumentos, ISNULL(Cond.Meses, (Cond.DiasVencimiento/30) )) FROM Condicion Cond
								WHERE c.Condicion=Cond.Condicion)>= 12 OR 
						(SELECT Cond.DANumeroDocumentos FROM Condicion Cond WHERE c.Condicion=Cond.Condicion) >= 12  THEN 1
				END), @Desglose=c.FacDesgloseIVA FROM CXC c WHERE c.ID=@ID
       IF (@Desglose=1 AND @Mayor12meses=1)
        UPDATE CXC SET FacDesgloseIVA=0 WHERE ID=@ID 
    END
  END

END
GO

 /************************ sp_ActualizaProgaramaFinanciamientoMAVI *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.sp_ActualizaProgaramaFinanciamientoMAVI') AND type = 'P') DROP PROCEDURE dbo.sp_ActualizaProgaramaFinanciamientoMAVI
GO
CREATE PROCEDURE sp_ActualizaProgaramaFinanciamientoMAVI  
@CxcID  int  
--//WITH ENCRYPTION
AS BEGIN    
DECLARE  
@ContRegistros   int,  
@Cont            int,  
@ID              int,  
@Ejercicio       int,  
@Periodo         int,   
@Anterior        money,  
@Exigible        money,  
@AnteriorTmp     money,  
@ExigiblePagado  money,  
@Adelantado      money,  
@PagoFinanciamiento money,  
@PagoNeto        money,  
@Arrastre        money,  
@Cobertura       money,  
@ArrastreTmp     money  
--@Creditos   money --Variable nueva para el manejo de las NC ARC(14-Oct-08)  
  
SET @ContRegistros = 0  
SET @Cont = 0  
SET @ID = 0  
SET @Ejercicio = 0  
SET @Periodo = 0  
SET @Anterior = 0.0  
SET @Exigible = 0.0  
SET @AnteriorTmp = 0.0  
SET @ExigiblePagado = 0.0  
SET @Adelantado = 0.0  
SET @PagoFinanciamiento = 0.0  
SET @PagoNeto = 0.0  
SET @Arrastre = 0.0  
SET @Cobertura = 0.0  
SET @ArrastreTmp = 0.0  
--SET @Creditos = 0.0  
  
  
  
SELECT @ContRegistros = Count(ID) FROM RecuperacionCredilanasPPMAVI WHERE ID = @CxcID  
DECLARE RecuperacionCredilanasPP CURSOR FOR SELECT R.ID, R.Ejercicio, R.Periodo, R.Exigible, R.PagoFinanciamiento, R.Arrastre, R.Cobertura FROM RecuperacionCredilanasPPMAVI R WHERE ID = @CxcID ORDER BY R.ID, R.Ejercicio, R.Periodo  
OPEN RecuperacionCredilanasPP  
WHILE @Cont < @ContRegistros -- Inicio while 1   
  BEGIN      
    FETCH NEXT FROM RecuperacionCredilanasPP      
    INTO @ID, @Ejercicio, @Periodo, @Exigible, @PagoFinanciamiento, @Arrastre, @Cobertura    --Asigna a la variable el valor del campo en el registro actual  
      
    IF @Cont = 0  
      BEGIN  
        SELECT @Arrastre = 0.0, @Cobertura = 0.0  
      END  
    SET @Cobertura = 0.0  
    SELECT @Arrastre = ISNULL(@ArrastreTmp, 0.0)  -- Inicia El arrastre del adelantado  22-Sep-08 (Arly Rubio)  
    IF  @Arrastre > 0.0  
      BEGIN  
        IF @Arrastre >= ISNULL(@Exigible, 0.0)  
          BEGIN  
            SELECT @Cobertura = ISNULL(@Exigible, 0.0)  
   SELECT @Arrastre = @Arrastre - ISNULL(@Exigible, 0.0)  
          END  
        ELSE  
          BEGIN  
            SELECT @Cobertura = ISNULL(@Arrastre, 0.0)  
            SET @Arrastre = 0.0  
          END  
      END   -- Termina el arrastre del adelantado  22-Sep-08 (Arly Rubio)  
      
    SELECT @PagoFinanciamiento = ISNULL(@PagoFinanciamiento, 0.0) + ISNULL(@Cobertura, 0.0) --+ ISNULL(@Creditos, 0.0)  
  
    IF @PagoFinanciamiento > @Anterior -- Comienza la actualización de campos de acuerdo al financiamiento pagado.  
      BEGIN  
        SELECT @PagoNeto = (ISNULL(@PagoFinanciamiento,0.0) - ISNULL(@Anterior, 0.0))  
        --SELECT @AnteriorTmp = 0.0  
        SELECT @AnteriorTmp = @Anterior  
        SELECT @Anterior = 0.0  
        IF @PagoNeto > @Exigible  
          BEGIN  
            SELECT @ExigiblePagado = ISNULL(@Exigible, 0.0)  
            SELECT @Adelantado = (@PagoNeto - ISNULL(@Exigible, 0.0))   
            SELECT @Arrastre = ISNULL(@Arrastre, 0.0) + ISNULL(@Adelantado, 0.0)  -- Arly Rubio 22-Sep-08  
          END  
        ELSE  
          BEGIN  
            SELECT @ExigiblePagado = @PagoNeto   
            SELECT @Adelantado = 0.0  
            SELECT @AnteriorTmp = @Anterior  
            SELECT @Anterior = (@Anterior+(@Exigible - @ExigiblePagado))  
          END  
      END  
    ELSE  
      BEGIN  
        SELECT @AnteriorTmp = @Anterior  
        --SELECT @PagoNeto = @Anterior - @PagoFinanciamiento  
        SELECT @Anterior = @Anterior - @PagoFinanciamiento  
        SELECT @Anterior = @Anterior+ISNULL(@Exigible, 0.0)  
        SELECT @ExigiblePagado = 0.0, @Adelantado = 0.0         
      END      -- Termina la actualización de campos de acuerdo al financiamiento pagado.  
      
    SELECT @ArrastreTmp = ISNULL(@Arrastre, 0.0)   
    UPDATE RecuperacionCredilanasPPMAVI SET Anterior = @AnteriorTmp, ExigiblePagado = @ExigiblePagado, Adelantado = @Adelantado, Arrastre = @Arrastre, Cobertura = @Cobertura WHERE ID = @ID AND Ejercicio = @Ejercicio AND Periodo = @Periodo  
    SET @Cont= @Cont + 1  
    SET @ExigiblePagado = 0.0  
  END -- Fin while 1  
CLOSE RecuperacionCredilanasPP     
DEALLOCATE RecuperacionCredilanasPP  
  
RETURN  
END  
GO


 /************************ spSugerirCobroMAVI *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spSugerirCobroMAVI') AND type = 'P') DROP PROCEDURE dbo.spSugerirCobroMAVI
GO
CREATE PROCEDURE [dbo].[spSugerirCobroMAVI]  
      @SugerirPago varchar(20),  
      @Modulo  char(5),  
      @ID   int,  
      @ImporteTotal money, -- = NULL,  
      @Usuario varchar(10),  
   @Estacion int,
   @OrigenModulo		varchar(10) = NULL        
  
-- Se cambia el sp para q inserte en la tabla previa para Negociacion y condonacion de Moratorios antes de generar el cobro  
--//WITH ENCRYPTION  
AS BEGIN  
  DECLARE  
    @Empresa   char(5),  
    @Sucursal   int,  
    @Hoy   datetime,  
    @Vencimiento  datetime,  
    @DiasCredito  int,  
    @DiasVencido  int,  
    @TasaDiaria   float,  
    @Moneda   char(10),  
    @TipoCambio   float,  
    @Contacto   char(10),  
    @Renglon   float,  
    @Aplica   varchar(20),  
    @AplicaID   varchar(20),  
    @AplicaMovTipo  varchar(20),  
    @Capital   money,  
    @Intereses   money,  
    @InteresesOrdinarios money,  
    @InteresesFijos  money,  
    @InteresesMoratorios money,  
    @ImpuestoAdicional  float,  
    @Importe   money,  
    @SumaImporte  money,  
    @Impuestos   money,  
    @DesglosarImpuestos  bit,  
    @LineaCredito  varchar(20),  
    @Metodo   int,  
    @GeneraMoratorioMAVI char(1),  
    @MontoMinimoMor   float,  
 @CondonaMoratorios  int,  
 @IDDetalle    int,  
 @ImpReal    money,  
 @MoratorioAPagar  money,  
    @Origen    varchar(20),  
    @OrigenID   varchar(20),  
 @MovPadre   varchar(20),  
    @MovPadreID   varchar(20),  
    @MovPadre1   varchar(20),  
    @MovIDPadre   varchar(20),
    @PadreMAviPend  varchar(20),  ---pzamudio 
    @PadreMaviIDPend  varchar(20), ---pzamudio 
    @NotaCredxCanc   char(1), -- JB  
    @Mov              varchar(20),  
    @AplicaNota varchar(20),  
    @AplicaIDNota varchar(20),
    @IDPOS			varchar(50)   
      
--select @Modulo as 'Modulo'  -- yrg  
  -- Se  hace una primer pasada (cursor) para calculo de moratorios hasta donde cubra el importe del cobro  
  --  si @ImporteTotal > 0 se hace una segunda pasada para ver cuanto de los doctos se alcanza a cubrir  
  DELETE NegociaMoratoriosMAVI WHERE IDCobro = @ID --AND Usuario = @Usuario AND Estacion = @Estacion  
  DELETE FROM HistCobroMoratoriosMAVI WHERE IDCobro = @ID ---- pzamudio 30 julio 2010  
  IF EXISTS(SELECT * FROM TipoCobroMAVI WHERE IDCobro = @ID)  
    UPDATE TipoCobroMAVI SET TipoCobro = 0  WHERE IDCobro = @ID  
  ELSE  
    INSERT INTO TipoCobroMAVI(IDCobro, TipoCobro) VALUES(@ID, 0)  
  
  --Se comento el prestamo personal porque con la nueva configuracion no aplicara a prestamos personales  
  CREATE TABLE #NotaXCanc(Mov varchar(20) NULL,MovID varchar(20) NULL)  
  INSERT INTO  #NotaXCanc(Mov,MovID)  
  SELECT DISTINCT d.mov,d.movid from negociamoratoriosmavi  c, cxcpendiente d, cxc n WHERE c.mov in('Nota Cargo','Nota Cargo VIU') and d.cliente=@Contacto  
  and d.mov=c.mov and d.movid=c.movid and d.padremavi in ('Credilana','Prestamo Personal') and n.mov=c.mov and n.movid=c.movid  
  and n.concepto in ('CANC COBRO CRED Y PP')    
  
  SELECT @DesglosarImpuestos = 0 , @Renglon = 0.0, @SumaImporte = 0.0, @ImporteTotal = NULLIF(@ImporteTotal, 0.0), @SugerirPago = UPPER(@SugerirPago) 
  
  IF @OrigenModulo <> 'POS'
  BEGIN
    SELECT @Empresa = Empresa, @Sucursal = Sucursal, @Hoy = FechaEmision, @Moneda = Moneda, @TipoCambio = TipoCambio, @Contacto = Cliente, @Mov = Mov    FROM Cxc WHERE ID = @ID        
  END ELSE
    SELECT @Empresa = Empresa, @Sucursal = Sucursal, @Hoy = FechaEmision, @Moneda = Moneda, @TipoCambio = TipoCambio, @Contacto = Cliente, @Mov = Mov    FROM POSL WHERE Orden = @ID       
    SELECT @IDPOS = ID FROM POSL WHERE Orden = @ID
    DELETE POSLVenta WHERE ID = @IDPOS       
       
    
  IF @SugerirPago <> 'IMPORTE ESPECIFICO' SELECT @ImporteTotal = 9999999 --NULL    
    
  --- jb  

  SELECT @MontoMinimoMor = ISNULL(MontoMinMoratorioMAVI,0.0) FROM EmpresaCfg2 WHERE Empresa = @Empresa     
  --SELECT @MontoMinimoMor  as 'Monto Minimo'  -- yrg  
  -- OJO hacer otro cursor para el caso de varias facturas  
  -- Tabla donde se inserten las Facturas pendientes de pago del cte (ListaSt)  
  IF @Modulo = 'CXC'  
  BEGIN  

    SELECT @Empresa = Empresa, @Sucursal = Sucursal, @Hoy = FechaEmision, @Moneda = Moneda, @TipoCambio = TipoCambio, @Contacto = Cliente   FROM Cxc WHERE ID = @ID   
    DELETE CxcD WHERE ID = @ID   
    DECLARE crAplica CURSOR FOR  
     SELECT p.Mov, p.MovID, p.Vencimiento, mt.Clave, ISNULL(p.Saldo*mt.Factor*p.MovTipoCambio/@TipoCambio, 0.0), ISNULL(p.InteresesOrdinarios*mt.Factor*p.MovTipoCambio/@TipoCambio, 0.0), ISNULL(p.InteresesFijos*p.MovTipoCambio/@TipoCambio, 0.0),   
     ISNULL(p.InteresesMoratorios*mt.Factor*p.MovTipoCambio/@TipoCambio, 0.0), ISNULL(p.Origen, p.Mov), ISNULL(p.OrigenID, p.MovId)  
      ,p.PadreMAVI, p.PadreIDMAVI  ----pzamudio                 
       FROM CxcPendiente p  
       JOIN MovTipo mt ON mt.Modulo = @Modulo AND mt.Mov = p.Mov  
       LEFT OUTER JOIN CfgAplicaOrden a ON a.Modulo = @Modulo AND a.Mov = p.Mov  
       LEFT OUTER JOIN Cxc r ON r.ID = p.RamaID  
       LEFT OUTER JOIN TipoAmortizacion ta ON ta.TipoAmortizacion = r.TipoAmortizacion  
      WHERE p.Empresa = @Empresa AND p.Cliente = @Contacto AND mt.Clave NOT IN ('CXC.SCH','CXC.SD', 'CXC.NC')  
      ORDER BY a.Orden, p.Vencimiento, p.Mov, p.MovID  
    SELECT @DesglosarImpuestos = ISNULL(CxcCobroImpuestos, 0) FROM EmpresaCfg2 WHERE Empresa = @Empresa  
  END ELSE  
    RETURN  
  
  OPEN crAplica  
  FETCH NEXT FROM crAplica INTO @Aplica, @AplicaID, @Vencimiento, @AplicaMovTipo, @Capital, @InteresesOrdinarios, @InteresesFijos, @InteresesMoratorios, @Origen, @OrigenID  
  ,@PadreMAviPend, @PadreMaviIDPend   ---pzamudio  
  WHILE @@FETCH_STATUS <> -1 AND ((@SugerirPago = 'SALDO VENCIDO' AND @Vencimiento<=@Hoy AND @ImporteTotal > @SumaImporte ) OR (@SugerirPago = 'IMPORTE ESPECIFICO' AND @ImporteTotal > @SumaImporte) OR @SugerirPago = 'SALDO TOTAL')  
  BEGIN  
    IF @@FETCH_STATUS <> -2   
    BEGIN  
      --Select * from NegociaMoratoriosMAVI    
      --SELECT @Capital as 'Capital 1 vez'  
      SELECT @CondonaMoratorios = 0, @GeneraMoratorioMAVI = NULL, @IDDetalle = 0, @MoratorioAPagar = 0        
        
  -- YANI  
      SELECT @IDDetalle = ID FROM CXC WHERE Mov = @Aplica AND MovId = @AplicaID --AND OrigenTipo = 'CXC'  
      --select @IDDetalle as 'IDMovYani'  -- yrg  
  
  -- Si el docto esta en tiempo de pagarse no se le generan moratorios solo se traspasa al detalle del cobro  
      -- Verificar si el mov, el canal de venta y el cliente deben generar moratorios  
      SELECT @GeneraMoratorioMAVI = dbo.fnGeneraMoratorioMAVI(@IDDetalle)
      IF (SELECT DescuentoRecargos FROM Cte WHERE Cliente = @Contacto) = 1  
		SELECT @GeneraMoratorioMAVI = '1'  
      IF @GeneraMoratorioMAVI = '1'  
      BEGIN  
        --select @GeneraMoratorioMAVI as 'Genera Mor'   -- yrg  
        SELECT @InteresesMoratorios = 0  
        SELECT @InteresesMoratorios = dbo.fnInteresMoratorioMAVI(@IDDetalle)  
        SELECT @MoratorioAPagar = @InteresesMoratorios  
        -- SELECT @TotalInteresMoratorio = @InteresesMoratorios         
        --SELECT @InteresesMoratorios as 'Antes'  -- yrg  
        IF @InteresesMoratorios <= @MontoMinimoMor AND  @InteresesMoratorios > 0  
        BEGIN  --   
          -- Aun cuando el usuario esté autorizado a condonar moratorios, si estos son menores al monto mínimo se condonan y registran  
          IF EXISTS(SELECT * FROM CondonaMorxSistMAVI WHERE IDCobro = @ID AND IDMov = @IDDetalle AND Estatus = 'ALTA')  
            UPDATE CondonaMorxSistMAVI  
               SET MontoOriginal = @InteresesMoratorios,  
                   MontoCondonado =  @InteresesMoratorios  
             WHERE IDCobro = @ID AND IDMov = @IDDetalle AND Estatus = 'ALTA'  
  
          ELSE  
            INSERT INTO CondonaMorxSistMAVI(Usuario,  FechaAutorizacion, IDMov,   RenglonMov, Mov, MovID,  MontoOriginal,    MontoCondonado, TipoCondonacion, Estatus, IDCobro)  
                                       VALUES(@Usuario, Getdate(),   @IDDetalle, 0,   @Aplica, @AplicaID, @InteresesMoratorios, @InteresesMoratorios, 'Por Sistema', 'ALTA', @ID)   
          SELECT @InteresesMoratorios = 0  
  END   --SELECT @CondonaMoratorios   = 1   
          --ELSE  
          --SELECT @InteresesMoratorios as 'SELECT @InteresesMoratorios'   -- yrg  
        IF @InteresesMoratorios > 0  AND @InteresesMoratorios > @MontoMinimoMor  --ISNULL(@MontoMinimoMor,0) AND  @InteresesMoratorios > 0  
        BEGIN  
          IF @SumaImporte + @InteresesMoratorios > @ImporteTotal  SELECT @MoratorioAPagar = @ImporteTotal - @SumaImporte  
          -- antes arriba SELECT @InteresesMoratorios = @ImporteTotal - @SumaImporte  
            SELECT @SumaImporte = @SumaImporte + @MoratorioAPagar  -- antes @InteresesMoratorios            
       
            --select @InteresesMoratorios as 'Importe Moratorio'  -- yrg  
            IF @InteresesMoratorios > 0 --AND @MoratorioAPagar > 0   -- Ivan  
            BEGIN  
              INSERT NegociaMoratoriosMAVI( IDCobro, Estacion, Usuario, Mov, MovID, ImporteReal, ImporteAPagar, ImporteMoratorio, ImporteACondonar, MoratorioAPagar, Origen, OrigenID)  
--              VALUES(@ID, @Estacion, @Usuario, @Aplica, @AplicaId, @Capital, 0, @InteresesMoratorios, 0, @MoratorioAPagar, @Origen, @OrigenID)  
              VALUES(@ID, @Estacion, @Usuario, @Aplica, @AplicaId, @Capital, 0, @InteresesMoratorios, 0, @MoratorioAPagar, @PadreMAviPend, @PadreMaviIDPend)  ----pzamudio  
  
   IF @Aplica IN ('Nota Cargo','Nota Cargo VIU')  
     BEGIN  
       SELECT @AplicaNota= ISNULL(Mov,'NA'), @AplicaIDNota = ISNULL(MovID,'NA') FROM #NotaXCanc WHERE Mov=@Aplica and MovID=@AplicaID   
        IF @AplicaNota <> 'NA' AND @AplicaIDNota <> 'NA'  
       UPDATE NegociaMoratoriosMAVI SET NotaCreditoxCanc = '1' WHERE IDCobro = @ID AND Estacion = @Estacion AND Mov = @Aplica AND MovID = @AplicaID        
       END       
                 
            END  
        END  
        
      END   
      ELSE   SELECT @InteresesMoratorios = 0  
      -- Intereses Moratorios  
  
      FETCH NEXT FROM crAplica INTO @Aplica, @AplicaID, @Vencimiento, @AplicaMovTipo, @Capital, @InteresesOrdinarios, @InteresesFijos, @InteresesMoratorios, @Origen, @OrigenID  
      ,@PadreMAviPend, @PadreMaviIDPend   ---pzamudio      
    END  
  END  
  CLOSE crAplica  
  DEALLOCATE crAplica  
  
  -- 2da  pasada a evaluar doctos mientras alcance el importe del cobro segun la opcion seleccionada   
  --select @SumaImporte as 'SumaImporte'  
  --select @ImporteTotal as '@ImporteTotal'  
  --IF @SumaImporte <=  @ImporteTotal   
  IF @Modulo = 'CXC' AND @SumaImporte <=  @ImporteTotal   
  BEGIN  
    --SELECT @Empresa = Empresa, @Sucursal = Sucursal, @Hoy = FechaEmision, @Moneda = Moneda, @TipoCambio = TipoCambio, @Contacto = Cliente   FROM Cxc WHERE ID = @ID   
      SELECT @Empresa = Empresa, @Sucursal = Sucursal, @Hoy = FechaEmision, @Moneda = Moneda, @TipoCambio = TipoCambio, @Contacto = Cliente, @Mov = Mov    FROM POSL WHERE ID = @IDPOS           

    DECLARE crDocto CURSOR FOR  
     SELECT p.Mov, p.MovID, p.Vencimiento, mt.Clave, ROUND(ISNULL(p.Saldo*mt.Factor*p.MovTipoCambio/@TipoCambio, 0.0),2), ISNULL(p.InteresesOrdinarios*mt.Factor*p.MovTipoCambio/@TipoCambio, 0.0), ISNULL(p.InteresesFijos*p.MovTipoCambio/@TipoCambio, 0.0),  
    ISNULL(p.InteresesMoratorios*mt.Factor*p.MovTipoCambio/@TipoCambio, 0.0), ISNULL(p.Origen,p.Mov), ISNULL(p.OrigenID, p.MovID)  
       ,p.PadreMAVI , p.PadreIDMAVI   ---pzamudio         
       FROM CxcPendiente p  
       JOIN MovTipo mt ON mt.Modulo = @Modulo AND mt.Mov = p.Mov  
       LEFT OUTER JOIN CfgAplicaOrden a ON a.Modulo = @Modulo AND a.Mov = p.Mov  
       LEFT OUTER JOIN Cxc r ON r.ID = p.RamaID  
       LEFT OUTER JOIN TipoAmortizacion ta ON ta.TipoAmortizacion = r.TipoAmortizacion  
      WHERE p.Empresa = @Empresa AND p.Cliente = @Contacto AND mt.Clave NOT IN ('CXC.SCH','CXC.SD', 'CXC.NC')  
      ORDER BY a.Orden, p.Vencimiento, p.Mov, p.MovID  
    --SELECT @DesglosarImpuestos = ISNULL(CxcCobroImpuestos, 0) FROM EmpresaCfg2 WHERE Empresa = @Empresa  
  END ELSE  
    RETURN  
  
  OPEN crDocto  
  FETCH NEXT FROM crDocto INTO @Aplica, @AplicaID, @Vencimiento, @AplicaMovTipo, @Capital, @InteresesOrdinarios, @InteresesFijos, @InteresesMoratorios, @Origen, @OrigenID   
  ,@PadreMAviPend, @PadreMaviIDPend   ---pzamudio  
  WHILE @@FETCH_STATUS <> -1 AND ((@SugerirPago = 'SALDO VENCIDO' AND @Vencimiento<=@Hoy AND @ImporteTotal > @SumaImporte ) OR (@SugerirPago = 'IMPORTE ESPECIFICO' AND @ImporteTotal > @SumaImporte) OR @SugerirPago = 'SALDO TOTAL')  
  BEGIN  
    IF @@FETCH_STATUS <> -2   
    BEGIN    
      -- Capital  
      --select @SumaImporte as 'SumaImporte antes'  --yrg  
--      select @OrigenID as 'Origen'  -- yrg  
      SELECT @ImpReal = @Capital  
      IF @SumaImporte + @Capital > @ImporteTotal SELECT @Capital = @ImporteTotal - @SumaImporte  
--      SELECT @SumaImporte = @SumaImporte + @Capital  
      --select @SumaImporte as 'SumaImporte'  
      IF @Capital > 0  
      BEGIN  
        SELECT @SumaImporte = @SumaImporte + @Capital  
   
        IF EXISTS(SELECT * FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID AND Estacion = @Estacion AND Mov = @Aplica AND MovID = @AplicaID)  
        begin  -- yrg  
          --select 'Entra a act'  -- yrg  
          UPDATE NegociaMoratoriosMAVI  
             SET ImporteAPagar = @Capital  
           WHERE Estacion = @Estacion  
             --AND Usuario  = @Usuario   
             AND Mov      = @Aplica  
             AND MovID    = @AplicaID  
             AND IDCobro  = @ID  
               
        IF @Aplica IN ('Nota Cargo','Nota Cargo VIU')  
     BEGIN  
       SELECT @AplicaNota= ISNULL(Mov,'NA'), @AplicaIDNota = ISNULL(MovID,'NA') FROM #NotaXCanc WHERE Mov=@Aplica and MovID=@AplicaID   
        IF @AplicaNota <> 'NA' AND @AplicaIDNota <> 'NA'  
       UPDATE NegociaMoratoriosMAVI SET NotaCreditoxCanc = '1' WHERE IDCobro = @ID AND Estacion = @Estacion AND Mov = @Aplica AND MovID = @AplicaID        
       END       
                   
        enD   
        ELSE   
        BEGIN  
          INSERT NegociaMoratoriosMAVI( IDCobro, Estacion, Usuario, Mov, MovID, ImporteReal, ImporteAPagar, ImporteMoratorio, ImporteACondonar, Origen, OrigenID)  
--          VALUES(@ID, @Estacion, @Usuario, @Aplica, @AplicaId, @ImpReal, @Capital, 0, 0, @Origen, @OrigenID)  
          VALUES(@ID, @Estacion, @Usuario, @Aplica, @AplicaId, @ImpReal, @Capital, 0, 0, @PadreMAviPend, @PadreMaviIDPend)  
            
          IF @Aplica IN ('Nota Cargo','Nota Cargo VIU')  
            BEGIN  
			SELECT @AplicaNota= ISNULL(Mov,'NA'), @AplicaIDNota = ISNULL(MovID,'NA') FROM #NotaXCanc WHERE Mov=@Aplica and MovID=@AplicaID   
			  IF @AplicaNota <> 'NA' AND @AplicaIDNota <> 'NA'  
			  UPDATE NegociaMoratoriosMAVI SET NotaCreditoxCanc = '1' WHERE IDCobro = @ID AND Estacion = @Estacion AND Mov = @Aplica AND MovID = @AplicaID        
			END       
  
        END  
      END  
      FETCH NEXT FROM crDocto INTO @Aplica, @AplicaID, @Vencimiento, @AplicaMovTipo, @Capital, @InteresesOrdinarios, @InteresesFijos, @InteresesMoratorios, @Origen, @OrigenID  
      ,@PadreMAviPend, @PadreMaviIDPend   ---pzamudio  
    END  
  END   
  CLOSE crDocto  
  DEALLOCATE crDocto  
  --Select * from NegociaMoratoriosMAVI  -- yrg  
  DROP TABLE #NotaXCanc  
  -- Determina el tipo de pago q se esta haciendo  
--  EXEC spTipoPagoBonifMAVI @SugerirPago, @ID  
  EXEC spOrigenNCxCancMAVI @ID  
  EXEC spOrigenCobrosInstMAVI @ID  
  RETURN  
END
GO

-- /************************ spOrigenVentaPMMavi *****************************/
--IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spOrigenVentaPMMavi') AND type = 'P') DROP PROCEDURE dbo.spOrigenVentaPMMavi
--GO
--CREATE PROCEDURE spOrigenVentaPMMavi           
--  @Empresa    char(5),        
--  @Cliente    char(10),        
--  @Estacion int,    
--  @TipoCobro int    
--AS BEGIN        
--  DECLARE        
--  @IdCxc   int,        
--  @IdOrigen   int,        
--  @MovIDCxC   varchar(20),        
--  @MovCxC   varchar(20),        
--  @Clave   varchar(20),        
--  @Concepto   varchar(50),    
--  @DiasVencActMAVI float,    
--  @DiasVencidos  float,    
--  @DiasInacActMAVI  float,        
--  @DiasInactivos float,    
--  @CanalVentas  int,    
--  --@CategoriaCanal varchar(50),    
--  @SeccionCobranza varchar(50),    
--  @PasaMov   int     
        
--  DELETE ListaSt WHERE Estacion = @Estacion    
--  DELETE CXCFacturaCteMavi WHERE Cliente = @Cliente    
--    --select @Mov as 'mov'    
---- Solo para debuggear 12.05.2010 yrg    
-- /*SELECT c.PadreMAVI, c.PadreIDMAVI, Id, c.Mov, c.MovID FROM CxcPendiente C        
--      JOIN MovTipo ON MovTipo.Mov = C.Mov         
--    WHERE c.Empresa = @Empresa AND c.Cliente = @Cliente        
--          AND MovTipo.Mov ----= 'Endoso'         
--IN ('Factura','Factura VIU','Factura Mayoreo','Credilana','Prestamo Personal',        
--              'Seguro Auto','Seguro Vida','Nota Cargo','Nota Cargo VIU','Nota Cargo Mayoreo','Refinanciamiento','Cta Incobrable F',        
--              'Cta Incobrable NV','Cheque Devuelto','Endoso','Documento') AND Modulo = 'CxC'         
--   */    
--  DECLARE crCxCCte2 CURSOR FOR        
--   SELECT Id, c.Mov, c.MovID FROM CxcPendiente C        
--      JOIN MovTipo ON MovTipo.Mov = C.Mov         
--    WHERE c.Empresa = @Empresa AND c.Cliente = @Cliente        
--          AND MovTipo.Mov ----= 'Endoso'         
--IN ('Factura','Factura VIU','Factura Mayoreo','Credilana','Prestamo Personal',        
--              'Seguro Auto','Seguro Vida','Nota Cargo','Nota Cargo VIU','Nota Cargo Mayoreo','Refinanciamiento','Cta Incobrable F',        
--              'Cta Incobrable NV','Cheque Devuelto','Endoso','Documento') AND Modulo = 'CxC'         
        
--   OPEN crCxCCte2        
--   FETCH NEXT FROM crCxCCte2 INTO @IdCxc,@MovCxC,@MovIDCxC        
--   WHILE @@FETCH_STATUS = 0        
--   BEGIN         
--     SELECT @PasaMov = 1     
--     SELECT @Concepto = Concepto FROM CXC WHERE ID = @IdCxc             
--     --IF (@Concepto not in ('CANC COBRO CRED Y PP', 'CANC COBRO FACTURA','CANC COBRO SEG AUTO','CANC COBRO SEG VIDA', 'CANC COBRO FACTURA VIU','CANC COBRO MAYOREO')) OR (@Concepto IS NULL)        
--     IF @MovCxC in ('Nota Cargo','Nota Cargo VIU','Nota Cargo Mayoreo')    
--       IF @Concepto in ('CANC COBRO CRED Y PP', 'CANC COBRO FACTURA','CANC COBRO SEG AUTO','CANC COBRO SEG VIDA', 'CANC COBRO FACTURA VIU','CANC COBRO MAYOREO')-- OR (@Concepto IS NULL)          
--         SELECT @PasaMov = 1     
--       ELSE    
--         SELECT @PasaMov = 1 --0    
--     IF @PasaMov = 1        
--     BEGIN          
        
--       SELECT @Clave = Clave FROM MovTipo WHERE Modulo = 'CXC' AND Mov = @MovCxC        
        
--  -------- Prueba        
--  --------declare @MovIDCxC int, @MovCxC varchar(20), @IdOrigen int        
--  --------set @MovIDCxC = 13452        
--  --------        
--  --------       EXEC spMAviBuscaCxCVenta 'AAA135','Factura', @MovIDCxC output , @MovCxC output, @IdOrigen output        
--  --------       EXEC spMAviBuscaCxCVenta 'AAA135','Factura', @MovIDCxC output , @MovCxC output, @IdOrigen output        
--  --------select @MovCxC         
--    ----- Factura        
--    ------SELECT @MovIDCxC MovIDCxC,@MovCxC MovCxC, @MovIDCxC MovIDCxC,  @Clave   clave         
--       IF @Clave NOT IN ('CXC.F', 'CXC.DM', /*'CXC.CA',*/'CXC.FAC'/*,'CXC.CAP'*/)        
--       BEGIN             
--         EXEC spMAviBuscaCxCVentaTest @MovIDCxC,@MovCxC, @MovIDCxC output , @MovCxC output, @IdOrigen output        
--          IF  (@MovCxC like 'Nota Cargo%')  or (@MovCxC like 'Prest%')    
--         begin     
--           select @MovCxC = PadreMAVI FROM CXC WHERE ID = @IdCxC           
--           select @MovIDCxC = PadreIDMAVI FROM cxc WHERE ID = @IdCxC    
--           select @IdOrigen = ID FROM CXC WHERE Mov = @MovCxC AND MovID = @MovIDCxC    
--         end        
--         IF NOT @MovIDCxC IS NULL AND NOT @IdOrigen is null -------@MovCxC IS NULL         
--         BEGIN        
--           IF NOT EXISTS(SELECT * FROM CXCFacturaCteMavi WHERE cliente = @Cliente AND Empresa = @Empresa AND IdOrigen = @IdOrigen AND IdCxcOrigen = @MovIDCxC AND IdCxCOrigenMov = @MovCxC )--AND Estacion = @Estacion)        
--                                                    --Cliente, Empresa, IdOrigen, IdCxcOrigen, IdCxcOrigenMov        
--           BEGIN         
--             -- Se verifica si cumple con las condiciones de dias vencidos y dias Inactivos para aplicar politica de Bonif de moratorios    
--             IF @TipoCobro = 1    
--             BEGIN    
--               -- select 'entra aqui'    
--               SELECT @CanalVentas = ClienteEnviarA         
--                 FROM CXC WHERE ID = @IdOrigen         
--                 --  select * from CXCFacturaCteMavi where Estacion = 123    
--    --898692 124331 ZBM20427 select * from cxc where Mov = 'Factura' and movid = 'ZBM20427'  124331    
        
--               SELECT @SeccionCobranza = SeccionCobranzaMAVI FROM CteEnviarA WHERE Cliente = @Cliente AND ID = @CanalVentas        
                   
--               IF @SeccionCobranza <> 'INSTITUCIONES'    
--			   BEGIN    
--                 IF EXISTS(SELECT * FROM  CxcMavi WHERE ID = @IdOrigen )     
--                 BEGIN
--                   SELECT @DiasVencActMAVI = ISNULL(DiasVencActMAVI,0), @DiasInacActMAVI = ISNULL(DiasInacActMAVI,0) FROM CxcMavi WHERE ID = @IdOrigen    
--                   SELECT @DiasVencidos = Numero, @DiasInactivos = Valor FROM TablaNumD WHERE TablaNum = 'CFG DV-DI POLITICA QUITA MORATORIOS'    
--                 --select  @DiasVencActMAVI as '@DiasVencActMAVI'    -- yrg
--                 --select @DiasInacActMAVI as '@DiasInacActMAVI'      -- yrg
--                   IF @DiasVencActMAVI >= @DiasVencidos OR @DiasInacActMAVI >= @DiasInactivos    
--                     INSERT INTO CXCFacturaCteMavi (Cliente, Empresa, IdCxC, IdOrigen, IdCxCOrigen, IdCxCOrigenMov, Estacion)        
--                     VALUES (@Cliente, @Empresa, @IdCxC, @IdOrigen, @MovIDCxC, @MovCxC, @Estacion)        
--                 END
--               END        
--             END    
--             ELSE      
--             begin      
--               --select 'aki2'    
--               INSERT INTO CXCFacturaCteMavi (Cliente, Empresa, IdCxC, IdOrigen, IdCxCOrigen, IdCxCOrigenMov, Estacion)        
--               VALUES (@Cliente, @Empresa, @IdCxC, @IdOrigen, @MovIDCxC, @MovCxC, @Estacion)        
--             end      
--           END        
--         END         
--       END         
--     --  IF @IdCxc  = 4037869 select 'Pasa 333'  
--       IF @Clave IN ('CXC.F', 'CXC.CD',/*'CXC.FAC',*/ 'CXC.DM', /*'CXC.CA',*/'CXC.FAC'/*,'CXC.CAP'*/)        
--       BEGIN         
         
--         SELECT @IdOrigen = @IdCxc    
         
--         IF NOT EXISTS(SELECT * FROM CXCFacturaCteMavi ccm WHERE cliente = @Cliente AND ccm.IdOrigen = @IdOrigen AND ccm.IdCxCOrigenMov = @MovCxC AND Estacion = @Estacion)        
--         BEGIN       
--           IF @TipoCobro = 1    
--           BEGIN     
--           -- select  @DiasVencActMAVI as '@DiasVencActMAVI 2'    
--            -- select @DiasInacActMAVI as '@DiasInacActMAVI 2'    
--             SELECT @CanalVentas = ClienteEnviarA         
--               FROM CXC WHERE ID = @IdOrigen         
                     
--             SELECT @SeccionCobranza = SeccionCobranzaMAVI FROM CteEnviarA WHERE Cliente = @Cliente AND ID = @CanalVentas        
                   
--             IF @SeccionCobranza <> 'INSTITUCIONES'                       
--		     BEGIN    
--               IF EXISTS(SELECT * FROM  CxcMavi WHERE ID = @IdOrigen )   
--               BEGIN  
--                 SELECT @DiasVencActMAVI = ISNULL(DiasVencActMAVI,0), @DiasInacActMAVI = ISNULL(DiasInacActMAVI,0) FROM CxcMavi WHERE ID = @IdOrigen    
--                 SELECT @DiasVencidos = Numero, @DiasInactivos = Valor FROM TablaNumD WHERE TablaNum = 'CFG DV-DI POLITICA QUITA MORATORIOS'    
--                 IF @DiasVencActMAVI >= @DiasVencidos OR @DiasInacActMAVI >= @DiasInactivos              
--                   INSERT INTO CXCFacturaCteMavi (Cliente, Empresa, IdCxC, IdOrigen, IdCxCOrigen, IdCxCOrigenMov, Estacion)        
--                   VALUES (@Cliente, @Empresa, @IdCxC, @IdCxC, @MovIDCxC, @MovCxC, @Estacion)        
--               END
--             END    
--           END      
--           ELSE     
--           begin       
--             --select 'aki3'    
--             INSERT INTO CXCFacturaCteMavi (Cliente, Empresa, IdCxC, IdOrigen, IdCxCOrigen, IdCxCOrigenMov, Estacion)      
--             VALUES (@Cliente, @Empresa, @IdCxC, @IdCxC, @MovIDCxC, @MovCxC, @Estacion)       
--           end      
--         END                                
--       END      
--     END        
--     FETCH NEXT FROM crCxCCte2 INTO @IdCxc,@MovCxC,@MovIDCxC        
-- END        
-- CLOSE crCxCCte2        
-- DEALLOCATE crCxCCte2        
--  --select * from CXCFacturaCtePolMMavi where Cliente = @Cliente    
--END        
--GO

 /************************ spOrigenNCxCancMAVI *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spOrigenNCxCancMAVI') AND type = 'P') DROP PROCEDURE dbo.spOrigenNCxCancMAVI
GO
CREATE PROCEDURE spOrigenNCxCancMAVI        
      @IDCobro   int  
--//WITH ENCRYPTION           
AS BEGIN  
  DECLARE      
    @Mov    varchar(20),  
    @ID     int,  
    @Concepto   varchar(50),  
    @MovID    varchar(20),  
    @Valor    varchar(50),  
    @Large    int,   
 @LargeOrigen  int,  
    @MovOrigen   varchar(20),  
    @MovIDOrigen  varchar(20),  
    @IDDetalle   int  
  
  IF EXISTS(SELECT * FROM NegociaMoratoriosMAVI WHERE IDCobro = @IDCobro AND Mov in ('Nota Cargo','Nota Cargo VIU'))  
  BEGIN  
    DECLARE crActOrigen CURSOR FOR  
     SELECT ID, Mov, MovId FROM NegociaMoratoriosMAVI WHERE IDCobro = @IDCobro AND Mov in ('Nota Cargo','Nota Cargo VIU')  
    OPEN crActOrigen  
    FETCH NEXT FROM crActOrigen INTO @ID, @Mov, @MovId  
    WHILE @@FETCH_STATUS <> -1   
    BEGIN  -- 2  
      IF @@FETCH_STATUS <> -2   
      BEGIN  -- 3  
           
        SELECT @Concepto = Concepto, @IDDetalle = ID from cxc where mov = @Mov and MovId = @MovId  
        --SELECT @Concepto  as 'Cpt0'  -- yrg  
          
        IF @Concepto in ('CANC COBRO CRED Y PP', 'CANC COBRO FACTURA','CANC COBRO SEG AUTO','CANC COBRO SEG VIDA', 'CANC COBRO FACTURA VIU','CANC COBRO MAYOREO')  
        BEGIN   
          -- se busca la referencia en Campo Extra para ver què Factura originò el mov   
         -- select * from MovCampoExtra where id = 247473  
          --SELECT * FROM MovCampoExtra WHERE /*Modulo = 'CXC' AND*/ ID = @ID  
          IF EXISTS(SELECT * FROM MovCampoExtra WHERE /*Modulo = 'Cxc' AND*/ ID = @IDDetalle)  
          BEGIN  
    
            SELECT @Valor = Valor FROM MovCampoExtra WHERE Modulo = 'Cxc' AND ID = @IDDetalle  
            --SELECT @Valor as 'Valor'  -- yrg  
            SELECT @Large = LEN(@Valor)  
  
            SELECT @LargeOrigen = PATINDEX('%[_]%', @Valor)  
            SELECT @MovOrigen = SUBSTRING(@Valor, 1, @LargeOrigen - 1 )  
            SELECT @MovIDOrigen = SUBSTRING(@Valor, @LargeOrigen + 1, @Large)  
  
            --SELECT @MovOrigen as '@MovOrigen'  -- yrg  
            --SELECT @MovIDOrigen as '@MovIDOrigen'  -- yrg  
  
            UPDATE NegociaMoratoriosMAVI  
               SET Origen = @MovOrigen,  
                   OrigenID = @MovIDOrigen  
             WHERE ID = @ID AND Mov = @Mov AND MovId = @MovId  
  
          END  
        END  
      END  -- 3  
          
      FETCH NEXT FROM crActOrigen INTO @ID, @Mov, @MovId  
    END -- 2      
    CLOSE crActOrigen  
    DEALLOCATE crActOrigen  
        
  END   
END
GO


 /************************ spOrigenCobrosInstMAVI *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spOrigenCobrosInstMAVI') AND type = 'P') DROP PROCEDURE dbo.spOrigenCobrosInstMAVI
GO
CREATE PROCEDURE spOrigenCobrosInstMAVI        
      @IDCobro   int  
--//WITH ENCRYPTION                  
AS BEGIN  
  DECLARE      
    @Mov    varchar(20),  
    @ID     int,      
    @MovID    varchar(20),      
    @MovOrigen   varchar(20),  
    @MovIDOrigen  varchar(20),      
 @OrigenID   varchar(20),  
 @Origen    varchar(20)  
  
  IF EXISTS(SELECT * FROM NegociaMoratoriosMAVI WHERE IDCobro = @IDCobro AND Mov in ('Contra Recibo','Contra Recibo Inst'))  
  BEGIN  
    DECLARE crActOrigenCR CURSOR FOR  
     SELECT ID, Mov, MovId FROM NegociaMoratoriosMAVI WHERE IDCobro = @IDCobro AND Mov in ('Contra Recibo','Contra Recibo Inst')  
    OPEN crActOrigenCR  
    FETCH NEXT FROM crActOrigenCR INTO @ID, @Mov, @MovId  
    WHILE @@FETCH_STATUS <> -1   
    BEGIN  -- 2  
      IF @@FETCH_STATUS <> -2   
      BEGIN  -- 3  
        SELECT @Origen = Origen,  
               @OrigenID = OrigenID  
          FROM CXC   
         WHERE Mov = @Mov AND MovID = @MovId  
        
        SELECT @MovOrigen = Origen,  
               @MovIDOrigen = OrigenID  
          FROM CXC  
         WHERE Mov = @Origen AND MovID = @OrigenID  
                        
        UPDATE NegociaMoratoriosMAVI  
           SET Origen = @MovOrigen,  
               OrigenID = @MovIDOrigen  
         WHERE ID = @ID AND Mov = @Mov AND MovId = @MovId  
          
      END  -- 3  
          
      FETCH NEXT FROM crActOrigenCR INTO @ID, @Mov, @MovId  
    END -- 2      
    CLOSE crActOrigenCR  
    DEALLOCATE crActOrigenCR  
        
  END   
END
GO


 /************************ spSerieCFDFolio *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spSerieCFDFolio') AND type = 'P') DROP PROCEDURE dbo.spSerieCFDFolio
GO  
CREATE PROCEDURE spSerieCFDFolio
    @Sucursal INT ,  
    @Empresa CHAR(5) ,  
    @Modulo CHAR(5) ,  
    @Mov CHAR(20) ,  
    @Serie VARCHAR(20) OUTPUT ,  
    @Ok INT OUTPUT ,  
    @OkRef VARCHAR(255) OUTPUT  
--//WITH ENCRYPTION
AS   
    BEGIN  
        SET NOCOUNT ON  
        DECLARE   
            @CFDFolio INT ,  
            @CFDFolioA INT ,  
            @CFDSerie VARCHAR(10) ,  
            @Nivel VARCHAR(10)  
        SELECT  @CFDFolioA = NULL  
        SELECT  @CFDFolioA = MIN(FolioA) ,  
                @Nivel = 'Global'  
        FROM    CFDFolio WITH ( NOLOCK )  
        WHERE   Empresa = @Empresa  
                AND Modulo = @Modulo  
                AND Mov = @Mov  
                AND Estatus = 'ALTA'  
                AND ISNULL(Folio, 0) < ISNULL(FolioA, 0)  
                AND Nivel = 'Global'  
        IF NULLIF(@CFDFolioA, 0) IS NULL   
            SELECT  @CFDFolioA = MIN(FolioA) ,  
                    @Nivel = 'Sucursal'  
            FROM    CFDFolio WITH ( NOLOCK )  
            WHERE   Empresa = @Empresa  
                    AND Modulo = @Modulo  
                    AND Mov = @Mov  
                    AND Estatus = 'ALTA'  
                    AND ISNULL(Folio, 0) < ISNULL(FolioA, 0)  
                    AND Nivel = 'Sucursal'  
                    AND Sucursal = @Sucursal  
        IF NULLIF(@CFDFolioA, 0) IS NULL   
            SELECT  @Ok = 30013  
        ELSE   
            BEGIN  
                IF @Nivel = 'Global'   
                    SELECT @CFDFolio = Folio, --= ISNULL(Folio, FolioD - 1) + 1 ,  
                            @CFDSerie = Serie  
     FROM CFDFolio WITH(NOLOCK)  
                    WHERE   Empresa = @Empresa  
                            AND Modulo = @Modulo  
                            AND Mov = @Mov  
                            AND Estatus = 'ALTA'  
                            AND FolioA = @CFDFolioA  
                            AND Nivel = 'Global'       
                ELSE   
                    IF @Nivel = 'Sucursal'   
     SELECT @CFDFolio = Folio, --= ISNULL(Folio, FolioD - 1) + 1 ,  
                            @CFDSerie = Serie  
     FROM CFDFolio WITH(NOLOCK)  
                    WHERE   Empresa = @Empresa  
                            AND Modulo = @Modulo  
                            AND Mov = @Mov  
                            AND Estatus = 'ALTA'  
                            AND FolioA = @CFDFolioA  
                            AND Nivel = 'Sucursal'  
       AND Sucursal = @Sucursal  
  
                IF @CFDFolio > @CFDFolioA      
                 SELECT  @Ok = 30013  
                 ELSE   
                 SELECT  @Serie = ISNULL(@CFDSerie, '')  
                        --+ CONVERT(VARCHAR, @CFDFolio)  
            END  
   
 IF ISNULL(@Serie,'') = ''   
  SELECT @Serie = Prefijo FROM Sucursal WHERE Sucursal = @Sucursal  
  
--test  
 --SELECT @Serie  
END
GO

 /************************ spConsecutivoDividirSeries *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spConsecutivoDividirSeries') AND type = 'P') DROP PROCEDURE dbo.spConsecutivoDividirSeries
GO
CREATE PROCEDURE [dbo].[spConsecutivoDividirSeries]  
 @Serie Varchar(10),  
 @ConsecutivoFiscal INT,  
    @Tipo CHAR(20) ,  
    @Sucursal INT ,  
    @Consecutivo VARCHAR(20) OUTPUT ,  
    @Maximo INT = NULL ,  
    @Referencia VARCHAR(50) = NULL OUTPUT ,  
    --@Ok INT = NULL OUTPUT ,  
    --@OkRef VARCHAR(255) = NULL OUTPUT ,  
    @PrefijoEsp VARCHAR(10) = NULL ,  
    @AutoGenerar BIT = 0  
--//WITH ENCRYPTION
AS   
    BEGIN  
    SET NOCOUNT ON  
        DECLARE @Nivel CHAR(20) ,  
            @Prefijo CHAR(10) ,  
            @UltConsecutivo INT ,  
            @TieneControl BIT ,  
            @Concurrencia VARCHAR(20) ,  
            @Tabla VARCHAR(100) ,  
            @SQL NVARCHAR(4000),  
   @DividirSeries BIT  
  
        SELECT  @UltConsecutivo = NULL ,  
                @Consecutivo = NULL ,  
                @Prefijo = NULL ,  
                @Referencia = NULL  
  
        --BEGIN TRANSACTION  
        SELECT  @Nivel = UPPER(Nivel) ,  
                @Prefijo = ISNULL(RTRIM(Prefijo), '') ,  
                @TieneControl = ISNULL(TieneControl, 0) ,  
                @Concurrencia = UPPER(ISNULL(RTRIM(Concurrencia), '')) ,  
                @UltConsecutivo = ISNULL(Consecutivo, 0),  
    @DividirSeries = DividirSeries  
        FROM    Consecutivo WITH (NOLOCK)  
        WHERE   Tipo = @Tipo  
        IF @@ROWCOUNT = 0  
            AND @AutoGenerar = 1   
            BEGIN  
                SELECT  @Nivel = 'Global' ,  
                        @Concurrencia = 'Normal'  
                INSERT  Consecutivo  
                        ( Tipo, Nivel, Concurrencia )  
                VALUES  ( @Tipo, @Nivel, @Concurrencia )  
            END  
  
        IF @PrefijoEsp IS NOT NULL   
            SELECT  @Prefijo = @PrefijoEsp  
  
        IF @Concurrencia = 'ALTA'   
            BEGIN  
                SELECT  @Tabla = 'Consecutivo/' + CONVERT(VARCHAR(20), @Tipo)   
                IF @Prefijo <> ''   
                    SELECT  @Tabla = @Tabla + '/'  
                            + CONVERT(VARCHAR(20), @Prefijo)  
                IF @Nivel = 'SUCURSAL'   
                    BEGIN  
                        SELECT  @Tabla = @Tabla + '/S'  
                                + CONVERT(VARCHAR, @Sucursal)  
                        SELECT  @UltConsecutivo = Consecutivo  
                        FROM    ConsecutivoSucursal WITH (NOLOCK)  
                        WHERE   Tipo = @Tipo  
                                AND Sucursal = @Sucursal  
                    END  
    SELECT @Tabla = @Tabla + '/' + @Serie  
                IF @DividirSeries = 1 AND @ConsecutivoFiscal = 0  
     SELECT  @Tabla = @Tabla + '/C'  --Seguros y Credilanas  
                  
    IF NOT EXISTS ( SELECT  *  
                    FROM    sysobjects WITH (NOLOCK)  
                    WHERE   id = OBJECT_ID(@Tabla)  
                    AND type = 'U' )   
                    BEGIN  
                        SELECT  @SQL = N'CREATE TABLE [' + @Tabla  
                                + '] (Consecutivo int IDENTITY('  
                                + CONVERT(VARCHAR, ISNULL(@UltConsecutivo, 0)  
                                + 1)  
                                + ', 1) NOT NULL PRIMARY KEY, Fecha datetime NULL DEFAULT GETDATE())'  
                        EXEC sp_ExecuteSQL @SQL  
                    END  
                SELECT  @SQL = N'INSERT [' + @Tabla  
                        + '] (Fecha) VALUES (DEFAULT) SELECT @UltConsecutivo=@@IDENTITY'  
                EXEC sp_ExecuteSQL @SQL, N'@UltConsecutivo int OUTPUT',  
                    @UltConsecutivo OUTPUT  
            END  
        ELSE   
            BEGIN  
                IF @Nivel = 'SUCURSAL'   
                    BEGIN  
                        UPDATE  ConsecutivoSucursal WITH ( ROWLOCK )  
                        SET     @UltConsecutivo = Consecutivo = ISNULL(Consecutivo,  
                                                              0) + 1  
                        WHERE   Tipo = @Tipo  
                                AND Sucursal = @Sucursal  
                        IF @@ROWCOUNT = 0   
               INSERT  ConsecutivoSucursal  
                                    ( Tipo, Sucursal, Consecutivo )  
                            VALUES  ( @Tipo, @Sucursal, 1 )  
  
                        IF @UltConsecutivo > @Maximo   
                            UPDATE  ConsecutivoSucursal WITH ( ROWLOCK )  
                            SET     @UltConsecutivo = Consecutivo = 1  
                            WHERE   Tipo = @Tipo  
                                    AND Sucursal = @Sucursal  
  
                        SELECT  @Prefijo = Prefijo  
                        FROM    Sucursal WITH ( NOLOCK )  
                        WHERE   Sucursal = @Sucursal  
                    END  
                ELSE   
                    BEGIN  
                        UPDATE  Consecutivo WITH ( ROWLOCK )  
                        SET     @UltConsecutivo = Consecutivo = ISNULL(Consecutivo,  
                                                              0) + 1  
                        WHERE   Tipo = @Tipo  
  
                        IF @UltConsecutivo > @Maximo   
                            UPDATE  Consecutivo WITH ( ROWLOCK )  
                            SET     @UltConsecutivo = Consecutivo = 1  
                            WHERE   Tipo = @Tipo  
                    END  
            END  
        IF @UltConsecutivo > 0   
            SELECT  @Consecutivo = RTRIM(@Prefijo)  
                    + CONVERT(VARCHAR, @UltConsecutivo)  
  
  
--        IF @Ok IS NULL   
--            COMMIT TRANSACTION  
--        ELSE   
--            ROLLBACK TRANSACTION  
        RETURN   
    END
GO

 /************************ spConsecutivoGral *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spConsecutivoGral') AND type = 'P') DROP PROCEDURE dbo.spConsecutivoGral
GO  
CREATE PROCEDURE [dbo].[spConsecutivoGral]  
@ID INT,  
@Modulo Varchar(20),  
@AplicaManual BIT  
 --//WITH ENCRYPTION 
AS BEGIN  
 DECLARE   
 @Mov varchar(20),  
 @Usuario varchar(20),  
 @MovID varchar(20),  
 @Sucursal int,  
 @Serie varchar(10),  
 @ULTConsecutivo varchar(20),  
 @ConsecutivoFiscal INT,  
 @Empresa Varchar(10),  
 @Ok INT ,  
 @OkRef Varchar(255),  
 @NoPadres INT,  
 @IDPadreMAVI INT,  
 @MovPadre Varchar(20),  
 @DividirSeries bit,  
 @Condicion varchar(20),  
 @Concepto varchar(20)  
  
 IF @Modulo = 'CXC' --AND @MovID IS NULL  
 BEGIN  
  SELECT @Usuario = Usuario, @Mov=Mov, @MovID=MovID, @Empresa = Empresa, @Sucursal = Sucursal FROM CXC WITH (NOLOCK) WHERE ID = @ID  
  
  IF @AplicaManual = 1   
  BEGIN  
   SELECT @NoPadres = COUNT(distinct p.ID), @IDPadreMAVI = p.ID--, @MovPadre = p.Mov  
   FROM Cxc c WITH (NOLOCK) JOIN CxcD d WITH (NOLOCK) ON c.Mov = d.Aplica AND c.MovID = d.AplicaID   
        JOIN CXC p WITH (NOLOCK) ON c.PadreMAVI = p.Mov AND c.PadreIDMAVI = p.MovID   
   WHERE d.ID = @ID   
   GROUP BY p.ID--, p.Mov  
  END  
  ELSE  
  BEGIN  
   SELECT @NoPadres = COUNT(distinct p.ID), @IDPadreMAVI = p.ID--, @MovPadre = p.Mov  
   FROM CXC p WITH (NOLOCK) JOIN NegociaMoratoriosMAVI n WITH (NOLOCK) ON n.Origen = p.Mov AND n.OrigenID = p.MovID WHERE n.IDCobro = @ID  
   GROUP BY p.ID--, p.Mov  
  END  
    
  EXEC spSerieCFDFolio @Sucursal, @Empresa, @Modulo, @Mov, @Serie OUTPUT, @Ok OUTPUT, @OkRef OUTPUT--, @ModuloAfectacion--, @ID           
  
  
  SELECT @DividirSeries = DividirSeries FROM Consecutivo WITH (NOLOCK) WHERE Tipo = @Mov  
  IF @DividirSeries = 1   
  BEGIN  
   SELECT @MovPadre = Mov, @Condicion = Condicion, @Concepto = Concepto FROM CXC WITH (NOLOCK) WHERE ID = @IDPadreMAVI  
   SELECT @ConsecutivoFiscal = ConsecutivoFiscal From MovTipo WITH (NOLOCK) WHERE Mov = @MovPadre AND Modulo = @Modulo  
   SELECT @Condicion = CFD_metodoDePago FROM Condicion WITH (NOLOCK) WHERE Condicion = @Condicion  
   --print 'Condicion '+ @Condicion + 'PadreIDMAVI' + Convert(Varchar,@IdPadreMAVI)  
   IF @Condicion = 'CONTADO'  
    SELECT @ConsecutivoFiscal = 0  
   IF @Concepto LIKE '%SALDO%'  
    SELECT @ConsecutivoFiscal = 0  
     
   --print @ConsecutivoFiscal  
   EXEC spConsecutivoDividirSeries @Serie, @ConsecutivoFiscal, @Mov, @Sucursal, @UltConsecutivo OUTPUT  
   IF @ConsecutivoFiscal = 0  
    SELECT @Serie = @Serie + 'C'  
  END  
  ELSE  
  EXEC spConsecutivo @Mov, @Sucursal, @UltConsecutivo OUTPUT  
  
   
    
  IF @UltConsecutivo IS NULL
	EXEC spConsecutivoAuto @Sucursal, @Empresa, 'CXC', @Mov, NULL, NULL, NULL, @UltConsecutivo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, NULL 
  
  SELECT @UltConsecutivo = @Serie + @UltConsecutivo
  UPDATE Cxc SET MovID = @UltConsecutivo WHERE ID = @ID  
 END  
  
 IF @Modulo = 'VTAS' --AND @MovID IS NULL  
 BEGIN  
  SELECT @Usuario = Usuario, @Mov=Mov, @MovID=MovID, @Empresa = Empresa, @Sucursal = Sucursal FROM Venta WITH (NOLOCK) WHERE ID = @ID  
  
  EXEC spSerieCFDFolio @Sucursal, @Empresa, 'CXC', @Mov, @Serie OUTPUT, @Ok OUTPUT, @OkRef OUTPUT--, @ModuloAfectacion--, @ID           
  
  SELECT @DividirSeries = DividirSeries FROM Consecutivo WITH (NOLOCK) WHERE Tipo = @Mov  
  IF @DividirSeries = 1   
  BEGIN  
   SELECT @ConsecutivoFiscal = ConsecutivoFiscal From MovTipo WITH (NOLOCK) WHERE Mov = @Mov AND Modulo = @Modulo  
   --print @ConsecutivoFiscal  
   EXEC spConsecutivoDividirSeries @Serie, @ConsecutivoFiscal, @Mov, @Sucursal, @UltConsecutivo OUTPUT  
   IF @ConsecutivoFiscal = 0  
    SELECT @Serie = @Serie + 'C'  
  END  
  ELSE  
  EXEC spConsecutivo @Mov, @Sucursal, @UltConsecutivo OUTPUT  
  
  SELECT @UltConsecutivo = @Serie + @UltConsecutivo  
  UPDATE Venta SET MovID = @UltConsecutivo WHERE ID = @ID  
 END  
  
 RETURN   
END
GO



/************************ spPOSMorarorios *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spPOSMorarorios') AND type = 'P') DROP PROCEDURE dbo.spPOSMorarorios
GO 
CREATE PROCEDURE spPOSMorarorios
@Empresa            char(5),          
@Sucursal           int,          
@Modulo             char(5),          
@ID                 int,          
@Estatus            char(15),          
@EstatusNuevo       char(15),        
@Usuario   varchar(10),          
@FechaEmision       datetime,          
@FechaRegistro      datetime,          
@Mov                char(20),          
@MovID              varchar(20),          
@MovTipo            char(20),          
@IDGenerar          int,          
@Ok                 int             OUTPUT,          
@OkRef              varchar(255)    OUTPUT          
--//WITH ENCRYPTION
AS     
BEGIN          
 DECLARE          
 @Concepto  varchar(50),        
 @AFArticulo  varchar(20),        
 @AFSerie  varchar(20),        
 @Lectura  int,        
 @Control  int,        
 @AutorizarGasto int,        
 @Articulo       varchar(20),  --Variable para modificacion de propre Propre20080822.sql  Arly Rubio 27-Ago-08        
 @Origen   char(20),        
 @OrigenID  char(20),        
 @IDOrigen  char(20),        
 @DMov           varchar(20),        
 @DmovID         varchar(20),        
 @OID   int,        
 @IDCxc   int,       
 @IDNCCxc int,     
 @IDCxcPend  int,        
 @IDCxcPendNC  int,    
 @IDDestino  int,        
 @Mensaje  varchar(255),        
 @MovSaldar  varchar(20),        
 @Cliente  varchar(10),        
 @Moneda   varchar(10),        
 @CteMoneda  varchar(10),        
 @TipoCambio  float,        
 @CteTipoCambio float,        
 @Renglon  float,        
 @RenglonSub  int,        
 @CondPago  varchar(50),        
 @IVA   money,        
 @UEN   int,        
 @CteEnviarA  INT,        
 @IDD      int,           
 @Clave     varchar(20),          
 @Aplica  varchar(20),          
 @AplicaID  varchar(20),           
 @Observaciones   varchar(100),           
 @FechaActual    datetime,          
 @Importe     money,           
 @ImporteInteres   money,          
 @InteresesMoratorios  money,          
 @CargoxMoratorioMavi   money,          
 @TotalInteresMoratorio money,          
 @MovMor     varchar(20),          
 @ValorCampoExtra   varchar(255),          
 @ImporteMoratorio   money,          
 @MoratorioAPagar   money,          
 @PendienteMoratorios  money,          
 @ImporteACondonar   money,          
 @FinMovMor    int,          
 @FinCadenaMovMor   int,          
 @IDMovMor     int,          
 @IDNCMor    int,          
 @MovMorId    varchar(20),          
 @IDDoc     int,          
 @UsuarioCondona   varchar(10),          
 @MontoMinimoMor   float,          
 @FechaOriginal   datetime,          
 @Remanente    money,          
 @IDNCBon    int,        
 @FechaOriginalAnt  datetime,        
 @InteresMoratorioAnt money,        
 @MasCobrosMor   int,        
 @FechaAnterior   datetime,        
 @RemananteAnt   money,        
 @IDMAx     int,      
 @CondxSist    int,      
 @TipoCondonacion  varchar(25),      
 @FechaOrigAnt   datetime,      
 @InteresesMoratoriosAnt money,      
 @IDFActCXC    int,      
 @Subclave    varchar(20),      
 @MovPadre    varchar(20),      
 @MovIDPadre    varchar(20),      
 @IDPadre    int,      
 @CxcID     int,      
 @FechaAplicacion  datetime,    
 @IDCobro int,    
 @HayNCA int,    
 @TipoCobro int,    
 @IdCargoMoratorio int,    
 @Padre  varchar(20),      
 @PadreID  varchar(20),    
 @IdCargoMoratorioEst int,    
 @IdCobroCargoMoratorioEstAnt int,    
 @IDCargoMoratorioEstAnt int,    
 @Vencimiento datetime,    
 @PorcMoratorioBonificar float,    
 @MoratorioXPagar money,    
 @RemanenteNvo money,    
 @DocMasAntiguo int,    
 @FechaAntigua datetime,    
 @IDDocPendiente int,    
 @MovDocV varchar(20),    
 @MovIDDocV varchar(20),    
 @Estadistico int,    
    @MovTipoCFDFlex   bit,    
    @CFDFlex    bit,        
    @eDoc     bit,    
    @XML     varchar(max),    
    @eDocOk     int,    
    @eDocOkRef    varchar(255),    
 @NoPadres INT,    
    @IDPadreMAVI INT,    
    @PadreMAVI varchar(20),    
    @PadreIDMAVI varchar(20),    
    @AplicaManual INT,    
    @NoParcialidad INT,     
    @Condicion varchar(20),  
    @dAplica varchar(20),    
    @dAplicaID varchar(20)    
    
 ---Inicia 1            
 SET @FechaAplicacion = Getdate()      
 SET @FechaAplicacion = CONVERT(varchar(8),@FechaAplicacion,112)           
 SELECT @AutorizarGasto=AutorizarGasto FROM Usuario WHERE Usuario=@Usuario        
      
    
 IF @Modulo = 'CXC' AND @EstatusNuevo in ('PENDIENTE', 'CONCLUIDO')     
 BEGIN      
  -- funcion para actualizar el mov padre      
  SELECT @IdPadre = dbo.fnIDOrigenCXCMovMAVI (@ID)      
  SELECT @MovPadre = Mov, @MovIDPadre = MovID FROM CXC WHERE ID = @IDPadre      
  UPDATE CXC      
  SET PadreMAVI = @MovPadre,      
  PadreIDMAVI = @MovIDPadre      
  WHERE ID = @ID      
 END      
      
 --Si se trata de una factura se actuliza el campo de Ponderacion       
 IF @Modulo = 'CXC' AND @EstatusNuevo in ('CONCLUIDO','PENDIENTE')          
 BEGIN  
  --Detalle CFDCA    
  SELECT @MovTipo=Clave FROM MovTipo WHERE Modulo = 'CXC' AND Mov = @Mov    
  IF @MovTipo = 'CXC.CA'            
  BEGIN     
   SELECT @Concepto = Concepto FROM Cxc WHERE ID = @ID    
   IF @Concepto like 'Canc%'    
   BEGIN    
    INSERT INTO CXCDNC (ID, Renglon, Aplica, AplicaID)    
    SELECT  ID, 1, PadreMAVI, PadreIDMAVI from CXC WHERE ID = @ID     
    --print 'Corr'     
   END    
   ELSE    
   BEGIN    
    INSERT INTO CXCDNC (ID, Renglon, Aplica, AplicaID)    
    SELECT  ID, 1, Origen, OrigenID from NegociaMoratoriosMAVI WHERE NotaCargoMorID = @ID     
    --print 'Mor'     
   END    
  END    
  --Detalle CFDCA    
    
  --Detalle CFDNC    
  SELECT @MovTipo=Clave FROM MovTipo WHERE Modulo = 'CXC' AND Mov = @Mov    
  IF @MovTipo = 'CXC.NC'            
  BEGIN     
   INSERT INTO CXCDNC (ID, Renglon, Aplica, AplicaID)    
   SELECT  ID, 1, Origen, OrigenID from NegociaMoratoriosMAVI WHERE NotaCredBonID = @ID         
  END    

 END      

    
/***************************** INICIA COBRO **************************/
 --Inicia Integracion Pago Parcial Moratorios           
 IF @Modulo = 'CXC' AND @MovTipo = 'CXC.C' AND @EstatusNuevo = 'CONCLUIDO'          
 BEGIN      
    
  IF NOT EXISTS (SELECT ISNULL(TipoCobro,0) FROM TipoCobroMAVI WHERE IDCobro = @ID )
    BEGIN
      SELECT @TipoCobro = 0
    END ELSE     
      SELECT @TipoCobro = ISNULL(TipoCobro,0) FROM TipoCobroMAVI WHERE IDCobro = @ID      
    
  IF @TipoCobro = 1    
  BEGIN  -- Se pasa sobre los doctos del padre    
   SELECT @PorcMoratorioBonificar = ISNULL(PorcMoratorioBonificar,0), @MoratorioXPagar = ISNULL(MoratorioXPagar,0) FROM CobroXPoliticaHistMAVI WHERE IdCobro = @ID     
   IF @MoratorioXPagar = 0 SELECT @RemanenteNvo = 0    
   ELSE     
   SELECT @RemanenteNvo = @MoratorioXPagar    
    
   -- Actualizacion de fechas sobre todos los doctos pendientes    
   SELECT @Padre = Origen, @PadreID = OrigenID FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID    
   -- Prueba    
   UPDATE CobroXPoliticaHistMAVI    
   SET EstatusCobro = 'CONCLUIDO'               
   WHERE IDCobro = @ID      
    
   DECLARE crCobroPol CURSOR FOR           
   SELECT Mov, MovID    
   FROM CXC WHERE PadreMAVI = @Padre AND PAdreIDMAVI = @PadreID AND Estatus = 'PENDIENTE' AND (Vencimiento <= @FechaAplicacion OR InteresesMoratoriosMAVI > 0)     
   UNION    
   SELECT Mov, MovID    
   FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID     
   UNION    
   SELECT Mov, MovID FROM CondonaMorxSistMAVI WHERE IDCobro = @ID    
   GROUP BY Mov, MovID    
     
   OPEN crCobroPol            
   FETCH NEXT FROM crCobroPol INTO  @Mov, @MovID--, @ImporteMoratorio, @ImporteACondonar, @MoratorioAPagar                 
   WHILE @@FETCH_STATUS <> -1           
   BEGIN  -- 2          
    IF @@FETCH_STATUS <> -2 --AND @OK IS NULL          
    BEGIN    -- 3     
     SELECT @IDMovMor = ID, @FechaAnterior = FechaOriginalAnt, @RemananteAnt = InteresMoratorioAnt, @Vencimiento = Vencimiento  FROM CXC WHERE Mov = @Mov AND MovID = @MovID            
    
     IF EXISTS(SELECT * FROM HistCobroMoratoriosMAVI WHERE IDCobro = @ID AND Mov = @Mov AND MovID = @MovID)     
     DELETE HistCobroMoratoriosMAVI WHERE IDCobro= @ID AND  Mov=@Mov AND  MovID=@MovID     
     INSERT INTO HistCobroMoratoriosMAVI(IDCobro, Mov, MovID, FechaCobro, FechaOriginalAnt, InteresMoratoriosAnt)     
     VALUES(@ID, @Mov, @MovID, @FechaAplicacion, @FechaAnterior, @RemananteAnt)        
     IF (@Vencimiento <= @FechaAplicacion)    
     BEGIN            
      UPDATE Cxc        
      SET FechaOriginalAnt = FechaOriginal,        
      FechaOriginal = @FechaAplicacion         
      WHERE ID = @IDMovMor        
     END    
      UPDATE Cxc           
      SET InteresMoratorioAnt = ISNULL(InteresesMoratoriosMAVI,0)          
      WHERE ID = @IDMovMor          
    
      UPDATE Cxc           
      SET     
      InteresesMoratoriosMAVI = 0     
      WHERE ID = @IDMovMor         
     --END         
    END    
    FETCH NEXT FROM crCobroPol INTO  @Mov, @MovID    
   END      
   CLOSE crCobroPol    
   DEALLOCATE crCobroPol        
       
   IF  @MoratorioXPagar > 0    
   BEGIN    
    SELECT @Remanente = @MoratorioXPagar     
    SELECT @IDDocPendiente = NULL    
    SELECT  @IDDocPendiente = MIN(Id) FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID  AND ROUND(ImporteAPagar,0) < ROUND(ImporteReal,0)    
    IF @IDDocPendiente IS NULL    
    SELECT @IDDocPendiente = MIN(ID) FROM CXC  WHERE PadreMAVI = @Padre AND PadreIDMAVI = @PadreID AND Estatus = 'PENDIENTE' AND MOVID NOT IN (SELECT MovID FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID )    
    ELSE    
    BEGIN     
     SELECT @MovDocV = Mov, @MovIDDocV = MovID FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID    
     SELECT @IDDocPendiente = MIN(ID) FROM CXC WHERE PadreMAVI = @Padre AND PadreIDMAVI = @PadreID AND Estatus = 'PENDIENTE' AND Mov = @MovDocV  AND MovID = @MovIDDocV     
    END      
    UPDATE CXC SET  InteresesMoratoriosMAVI = ROUND(@MoratorioXPagar, 2)      
    WHERE ID = @IDDocPendiente --@DocMasAntiguo     
    UPDATE CobroXPoliticaHistMAVI SET IdCxcMasViejo = @DocMasAntiguo WHERE IdCobro =  @ID       
   END    
  END  -- Fin de Tipo cobro = 1      
     
    
   -- Cond x Sistema      
  IF EXISTS(SELECT * FROM CondonaMorxSistMAVI WHERE IDCobro = @ID AND Estatus = 'ALTA')          
  BEGIN     
   INSERT INTO CondonaMoratoriosMAVI(Usuario,  FechaAutorizacion, IDMov,   RenglonMov, Mov, MovID,  MontoOriginal,    MontoCondonado, TipoCondonacion, Estatus, IDCobro)          
   SELECT Usuario, FechaAutorizacion, IDMov, RenglonMov, Mov, MovID, MontoOriginal,    MontoCondonado, TipoCondonacion, Estatus, IDCobro          
   FROM CondonaMorxSistMAVI WHERE IDCobro = @ID AND Estatus = 'ALTA'                    
  END      
    
  IF @TipoCobro = 0        
  BEGIN    
     --condonacion por sistema    
    IF (SELECT COUNT(*) FROM CondonaMorxSistMAVI where IdCobro = @ID) > 0      
      BEGIN      
      SET @FechaAplicacion = Getdate()      
   SET @FechaAplicacion = CONVERT(varchar(8),@FechaAplicacion,112)           
     
      DECLARE crCondxSist1 CURSOR FOR                          
       SELECT  CondonaMorxSistMAVI.Mov, CondonaMorxSistMAVI.MovID, cxc.ID, cxc.fechaoriginalAnt, cxc.InteresMoratorioAnt  --InteresesMoratoriosMAVI       
         FROM CondonaMorxSistMAVI       
         JOIN CXc on cxc.Mov = CondonaMorxSistMAVI.Mov and cxc.MovID = CondonaMorxSistMAVI.MovID      
        WHERE CondonaMorxSistMAVI.IdCobro = @ID     
       OPEN crCondxSist1              
      FETCH NEXT FROM crCondxSist1 INTO  @Mov, @MovID, @CxcID, @FechaOriginal, @ImporteMoratorio      
      WHILE @@FETCH_STATUS <> -1             
      BEGIN  -- 2            
        IF @@FETCH_STATUS <> -2-- AND @OK IS NULL            
        BEGIN    -- 3          
         UPDATE Cxc          
             SET FechaOriginalAnt = FechaOriginal,          
                 FechaOriginal = @FechaAplicacion           
      WHERE ID = @CxcID     
    
          INSERT INTO HistCobroMoratoriosMAVI(IDCobro, Mov, MOvID, FEchaCobro, FechaOriginalAnt, InteresMoratoriosAnt)      
          VALUES(@ID, @Mov, @MovID, @FechaAplicacion, @FechaOriginal, @ImporteMoratorio)      
            
       END      
         FETCH NEXT FROM crCondxSist1 INTO @Mov, @MovID, @CxcID, @FechaOriginal, @ImporteMoratorio      
      END      
      CLOSE crCondxSist1      
      DEALLOCATE crCondxSist1           
     END    
  -- condonacion al 100%    
   DECLARE crHist CURSOR FAST_FORWARD FOR          
   SELECT Mov, MovID, ImporteMoratorio, MoratorioAPagar, ImporteACondonar, UsuarioCondona           
   FROM NegociaMoratoriosMAVI           
   WHERE IDCobro = @ID AND ImporteACondonar = ImporteMoratorio AND ImporteACondonar > 0           
   OPEN crHist          
   FETCH NEXT FROM crHist INTO @MovMor, @MovMorID, @ImporteMoratorio, @MoratorioAPagar, @ImporteACondonar, @UsuarioCondona          
   WHILE @@Fetch_Status =0          
   BEGIN     
     INSERT INTO CondonaMoratoriosMAVI(Usuario,  FechaAutorizacion, IDMov,   RenglonMov, Mov, MovID,  MontoOriginal,    MontoCondonado, TipoCondonacion, Estatus, IDCobro)          
     VALUES(@UsuarioCondona, Getdate(),   @ID, 0,      @MovMor, @MovMorID, @ImporteMoratorio, @ImporteACondonar, 'Por Usuario', 'ALTA', @ID)            
    FETCH NEXT FROM crHist INTO @MovMor, @MovMorID, @ImporteMoratorio, @MoratorioAPagar, @ImporteACondonar, @UsuarioCondona          
   END      
   CLOSE crHist      
   DEALLOCATE crHist    
    
   EXEC spCalculaRemanenteMAVI  @ID, '2'            
   EXEC spCalculaRemanenteMAVI  @ID, '1'            
  END    
    
  SELECT @ImporteMoratorio = 0          
  SELECT @MoratorioAPagar = 0           
  SELECT @PendienteMoratorios = 0          
  SELECT @ImporteACondonar = 0          
    
  SELECT @ID = ID, @Estatus = Estatus, @Mov = Mov, @Usuario = Usuario, @Empresa = Empresa FROM CXC WHERE ID = @ID     -- Tabla Inserta y Modifica          
  SET @FechaActual = GETDATE()              
    
  CREATE TABLE #DetalleCobro(ID  int IDENTITY(1,1) NOT NULL,          
  IDCobro  int  NULL,          
  Aplica  varchar(20) NULL,          
  AplicaID  varchar(20) NULL,          
  Importe  money NULL)           
  INSERT INTO #DetalleCobro(IDCobro, Aplica, AplicaID, Importe)          
  SELECT @ID, Aplica, AplicaID, Importe--, Renglon--, MovMoratorioMAVI, MovIDMoratorioMAVI, TotalInteresMoratorioMAVI           
  FROM CxcD           
  WHERE ID = @ID          
    
  DECLARE C1 CURSOR FAST_FORWARD FOR          
  SELECT Aplica, AplicaID, Importe--, Renglon--, MovMoratorioMAVI, MovIDMoratorioMAVI, TotalInteresMoratorioMAVI           
  FROM #DetalleCobro           
  WHERE IDCobro = @ID          
  OPEN C1          
  FETCH NEXT FROM C1 INTO @Aplica, @AplicaID, @Importe--, @Renglon --, @MovMoratorioMAVI, @MovIDMoratorioMAVI, @TotalInteresMoratorio      
  WHILE @@Fetch_Status =0          
  BEGIN      
   SELECT @ImporteInteres = 0.0, @InteresesMoratorios = 0.0          
   --  Se verifica si el mov es una nota de cargo y si esta es por Moratorios                       
   IF @Aplica in ('Nota Cargo', 'Nota Cargo VIU', 'Nota Cargo Mayoreo')          
   BEGIN     
    SELECT @IDD = ID FROM Cxc WHERE Mov = @Aplica AND MovID = @AplicaID         
    DECLARE crFechaOriginal CURSOR FAST_FORWARD FOR          
    SELECT Mov, MovID, ImporteMoratorio, MoratorioAPagar, ImporteACondonar, UsuarioCondona           
    FROM NegociaMoratoriosMAVI           
    WHERE IDCobro = @ID AND NotaCargoMorId = @IDD AND MoratorioAPagar <> ImporteACondonar          
    OPEN crFechaOriginal         
    FETCH NEXT FROM crFechaOriginal INTO @MovMor, @MovMorID, @ImporteMoratorio, @MoratorioAPagar, @ImporteACondonar, @UsuarioCondona          
    WHILE @@Fetch_Status =0          
    BEGIN     
     SELECT @IDMovMor = ID, @FechaAnterior = FechaOriginalAnt, @RemananteAnt = InteresMoratorioAnt FROM CXC WHERE Mov =  @MovMor and MovId = @MovMorID          
    
     IF  @ImporteMoratorio <> @MoratorioAPagar  -- indica q se trata de un pago parcial de moratorios          
     BEGIN      
      SELECT @Remanente = ISNULL(Remanente,0)          
      FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID AND Mov = @MovMor AND MovId = @MovMorID          
     END       
     -- Si hay Condonacion Por usuario                       
     IF @ImporteACondonar > 0 and @ImporteACondonar <> @ImporteMoratorio           
     BEGIN          
      IF EXISTS(SELECT * FROM CondonaMoratoriosMAVI WHERE IdCobro = @ID AND IDMov = @IDD           
      AND TipoCondonacion = 'Por Usuario' AND Estatus = 'ALTA')           
      BEGIN      
       UPDATE CondonaMoratoriosMAVI          
       SET MontoOriginal = @ImporteMoratorio, MontoCondonado = @ImporteACondonar, Usuario = @UsuarioCondona          
       WHERE IDCobro = @ID AND IDMov = @IDD           
       AND TipoCondonacion = 'Por Usuario' ---and Estatus          
    
       SELECT @Remanente = ISNULL(Remanente,0)          
       FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID AND Mov = @MovMor AND MovId = @MovMorID          
      END      
      ELSE          
       INSERT INTO CondonaMoratoriosMAVI(Usuario,  FechaAutorizacion, IDMov, RenglonMov, Mov, MovID,  MontoOriginal,    MontoCondonado, TipoCondonacion, Estatus, IDCobro)          
       VALUES(@UsuarioCondona, Getdate(),   @ID, 0,      @MovMor, @MovMorID, @ImporteMoratorio, @ImporteACondonar, 'Por Usuario', 'ALTA', @ID)          
     END     
     FETCH NEXT FROM crFechaOriginal INTO @MovMor, @MovMorID, @ImporteMoratorio, @MoratorioAPagar, @ImporteACondonar, @UsuarioCondona          
    END     
    CLOSE crFechaOriginal          
    DEALLOCATE crFechaOriginal          
   END      
   FETCH NEXT FROM C1 INTO @Aplica, @AplicaID, @Importe--, @Renglon --, @MovMoratorioMAVI, @MovIDMoratorioMAVI, @TotalInteresMoratorio          
  END      
  CLOSE C1          
  DEALLOCATE C1          
  DROP TABLE #DetalleCobro       
    
  --Inicia Integracion NoParcialidades CFD Cobro    
 
    SELECT TOP 1 @dAplica=aplica, @dAplicaID=aplicaid FROM cxcd WHERE id=@ID  
    SELECT @PadreMAVI=padremavi,@PadreIDMAVI= padreidmavi FROM cxc WHERE mov=@dAplica and movid=@dAplicaID  
    SELECT @IDPAdreMAVI = Id FROM cxc WHERE mov=@PadreMAVI and movid=@PadreIDMAVI  

  IF (@PadreMAVI) in ('Nota Cargo','Nota Cargo VIU','Nota Cargo Mayoreo')     
  BEGIN    
   SELECT @PadreMAVI = Origen, @PadreIDMAVI = OrigenID FROM NegociaMoratoriosMAVI WHERE NotaCargoMorId = @IDPadreMAVI    
   SELECT @IDPadreMAVI = ID FROM CXC WHERE Mov = @PadreMAVI AND MovID =  @PadreIDMAVI    
  END    
    
  SELECT @PadreMAVI = Mov FRom CXC WHERE ID = @IDPadreMAVI AND Concepto NOT like 'Canc%'    
  IF (@PadreMAVI) in ('Nota Cargo','Nota Cargo VIU','Nota Cargo Mayoreo')     
  BEGIN    
   SELECT @PadreMAVI = PadreMAVI, @PadreIDMAVI = PadreIDMAVI FROM CXC WHERE Id = @IDPadreMAVI    
   SELECT @IDPadreMAVI = ID FROM CXC WHERE Mov = @PadreMAVI AND MovID =  @PadreIDMAVI    
  END    
      
  IF (@PadreMAVI) in ('Nota Credito','Nota Credito VIU','Nota Credito Mayoreo')     
  BEGIN    
   SELECT @PadreMAVI = Origen, @PadreIDMAVI = OrigenID FROM NegociaMoratoriosMAVI WHERE NotaCredBonID = @IDPadreMAVI    
   SELECT @IDPadreMAVI = ID FROM CXC WHERE Mov = @PadreMAVI AND MovID =  @PadreIDMAVI    
  END    
           
 END    
/***************************** TERMINA COBRO **************************/    
        
/*************** INICIA CANCELACION COBRO ********************/
 IF @Modulo = 'CXC' AND @MovTipo = 'CXC.C' AND @EstatusNuevo = 'CANCELADO'          
 BEGIN        
    
  SELECT @TipoCobro = ISNULL(TipoCobro,0) FROM TipoCobroMAVI WHERE IDCobro = @ID     
    
  IF @TipoCobro = 0       
  BEGIN   
   --documentos que no entran en condonaciones    
   DECLARE crCancelCobroNor CURSOR FAST_FORWARD FOR          
   SELECT Mov, MovID FROM     
   HistCobroMoratoriosMAVI     
   WHERE IDCobro = @ID     
    
   OPEN crCancelCobroNor          
   FETCH NEXT FROM crCancelCobroNor INTO @MovMor, @MovMorID    
   WHILE @@Fetch_Status =0          
   BEGIN -- 20        
    
    SELECT @FechaAnterior = NULL, @RemananteAnt = 0, @FechaOrigAnt = NULL,  @InteresesMoratoriosAnt = 0         
    
    SELECT @FechaAnterior = FechaOriginalAnt, @RemananteAnt  = InteresMoratoriosAnt          
    FROM HistCobroMoratoriosMAVI WHERE Mov = @MovMor AND MovID = @MovMorID AND IDCobro = @ID    
    
    SELECT @FechaOrigAnt = FechaOriginalAnt, @InteresesMoratoriosAnt = interesmoratorioant, @IDDoc = ID     
    FROM CXC WHERE Mov = @MovMor AND MovID = @MovMorID         
    
    UPDATE CXC        
    SET FechaOriginal = isnull(FechaOriginalAnt, NULL),                        
    InteresesMoratoriosMAVI = Isnull(Interesmoratorioant,0)    
    WHERE ID = @IDDoc                  
    
    UPDATE CXC        
    SET interesmoratorioant = isnull(@RemananteAnt, 0),     
    FechaOriginalAnt = Isnull(@FechaAnterior, NULL)      
    WHERE ID = @IDDoc                  

    IF /*NOT EXISTS (SELECT * FROM CondonaMoratoriosMAVI WHERE Mov = @MovMor AND MovID = @MovMorID AND IDCobro = @ID) AND */@TipoCobro = 0       
    DELETE HistCobroMoratoriosMAVI WHERE Mov = @MovMor AND MovID = @MovMorID AND IDCobro = @ID      
    
    FETCH NEXT FROM crCancelCobroNor INTO @MovMor, @MovMorID    
   END  -- 20        
   CLOSE crCancelCobroNor          
   DEALLOCATE crCancelCobroNor            
  END    
    
    
  ---- Inicia Cancela Condonaciones por sistema    
  IF EXISTS(SELECT * FROM CondonaMoratoriosMAVI WHERE IDCobro = @ID AND Estatus = 'ALTA' AND TipoCondonacion = 'Por Sistema')      
  BEGIN     
   DECLARE crCancelCond CURSOR FAST_FORWARD FOR       
   SELECT Mov, MovID, TipoCondonacion  FROM CondonaMoratoriosMAVI WHERE IDCobro = @ID AND Estatus = 'ALTA' AND TipoCondonacion = 'Por Sistema'           
   OPEN crCancelCond          
   FETCH NEXT FROM crCancelCond INTO @MovMor, @MovMorID, @TipoCondonacion --, @ImporteACondonar           
   WHILE @@Fetch_Status =0          
   BEGIN     
    
    UPDATE CondonaMoratoriosMAVI          
    SET Estatus = 'CANCELADO'            
    WHERE IDCobro = @ID AND Estatus = 'ALTA' AND TipoCondonacion = 'Por Sistema' AND           
    Mov = @MovMor AND MovID = @MovMorID      
    
    FETCH NEXT FROM crCancelCond INTO @MovMor, @MovMorID, @TipoCondonacion--, @ImporteACondonar           
   END      
   CLOSE crCancelCond          
   DEALLOCATE crCancelCond          
  END      
    
  /*Se modifico la validacion en el filtro del cursor y el update para que actualice el estatus en condonacion parcial y al 100% BVF 23072010*/      
  DECLARE crCondxUsua CURSOR FAST_FORWARD FOR           
  SELECT Mov, MovID, ImporteMoratorio, MoratorioAPagar, ImporteACondonar, UsuarioCondona           
  FROM NegociaMoratoriosMAVI           
  WHERE IDCobro = @ID AND ImporteACondonar > 0            
  OPEN crCondxUsua          
  FETCH NEXT FROM crCondxUsua INTO @MovMor, @MovMorID, @ImporteMoratorio, @MoratorioAPagar, @ImporteACondonar, @UsuarioCondona          
  WHILE @@Fetch_Status =0          
  BEGIN -- 21        
    
   UPDATE CondonaMoratoriosMAVI          
   SET Estatus = 'CANCELADO'            
   WHERE IDCobro = @ID AND Estatus = 'ALTA' AND           
   Mov = @MovMor AND MovID = @MovMorID           
    
   SELECT @PendienteMoratorios =  ISNULL(@ImporteMoratorio,0) - ISNULL(@ImporteACondonar,0) - ISNULL(@MoratorioAPagar,0)          
    
   SELECT @IDMovMor = ID FROM CXC WHERE Mov = @MovMor AND MovID = @MovMorID          
   -- cond x Usuario al 100% y parcial         
   FETCH NEXT FROM crCondxUsua INTO @MovMor, @MovMorID, @ImporteMoratorio, @MoratorioAPagar, @ImporteACondonar, @UsuarioCondona          
  END  -- 21        
  CLOSE crCondxUsua          
  DEALLOCATE crCondxUsua          
    
    
  --  Se cancelan las Notas de Cred referenciadas al Cobro que se esta cancelando          
  IF EXISTS( SELECT * FROM CXC WHERE IDCobroBonifMAVI = @ID ) --AND Estatus = 'CONCLUIDO'         
  BEGIN        
   -- Cursor para desafectar las NCred obtener el id de cu          
   DECLARE crCancBon CURSOR FAST_FORWARD FOR        
   SELECT ID FROM CXC                     
   WHERE IDCobroBonifMAVI = @ID AND Estatus  in ('PENDIENTE','CONCLUIDO' )      
   OPEN crCancBon        
   FETCH NEXT FROM crCancBon INTO @IDNCBon        
   WHILE @@Fetch_Status =0        
   BEGIN -- 6          
    EXEC spAfectar 'CXC', @IDNCBon, 'CANCELAR', 'Todo', NULL, @Usuario,  NULL, 1, @Ok OUTPUT, @OkRef OUTPUT,NULL, @Conexion = 1        
    
    FETCH NEXT FROM crCancBon INTO @IDNCBon        
   END        
   CLOSE crCancBon        
   DEALLOCATE crCancBon        
  END         
    
  -- Modalidad Cobro x Politica    
  IF @TipoCobro = 1     
  BEGIN --1    
      
   IF EXISTS(SELECT * FROM CobroXPoliticaHistMAVI WHERE IdCobro = @ID )    
   BEGIN--2    
    
    UPDATE CobroXPoliticaHistMAVI    
    SET EstatusCobro = 'CANCELADO'    
    WHERE IDCobro = @ID      
    -- Se cancela el cargo moratorio generado (estadistico)     
    SELECT @Origen = Mov, @OrigenID = MovID From CobroXPoliticaHistMAVI WHERE IdCobro = @ID    
    
    SELECT @IdCobroCargoMoratorioEstAnt = MAX(IDcobro) FROM  CobroXPoliticaHistMAVI WHERE Mov = @Origen AND MovID = @OrigenID --AND     
    AND EstatusCobro = 'CONCLUIDO'    
    
    IF @IdCobroCargoMoratorioEstAnt >0           
    BEGIN--3    
      SET @Estadistico = 0    
      SELECT @Estadistico = IdCargoMoratorioEst FROM CobroXPoliticaHistMAVI WHERE IdCobro = @IdCobroCargoMoratorioEstAnt    
      IF @Estadistico > 0    
      BEGIN--4    
     UPDATE CobroXPoliticaHistMAVI SET EstatusCargoMorEst = 'CONCLUIDO' WHERE IDCobro = @IdCobroCargoMoratorioEstAnt    
     UPDATE Cxc SET Estatus = 'CONCLUIDO' WHERE ID= @Estadistico    
         END --4    
    END--3    
   -- Se concluye el cargo moratorio generado (estadistico) anterior     
    
    SELECT @IdCargoMoratorioEst = IdCargoMoratorioEst FROM CobroXPoliticaHistMAVI WHERE IdCobro = @ID     
    IF @IdCargoMoratorioEst > 0    
    BEGIN--5    
     UPDATE CobroXPoliticaHistMAVI    
     SET EstatusCargoMorEst = 'CANCELADO'    
     WHERE IdCobro = @ID      
     EXEC spAfectar 'CXC', @IdCargoMoratorioEst, 'CANCELAR', 'Todo', NULL, @Usuario,  NULL, 1, @Ok OUTPUT, @OkRef OUTPUT,NULL, @Conexion = 1                     
    END  --5    
   END --2    
   -- Se regresan las fechas a los doctos pagados con el cobro q se cancela    
            CREATE TABLE #HIST(ID int NULL)    
            INSERT INTO #HIST    
            SELECT c.id FROM     
   HistCobroMoratoriosMAVI h, cxc c    
   WHERE h.IDCobro = @ID  and c.mov=h.mov and c.movid=h.movid       
      
   DECLARE crCancelCobroPol CURSOR FAST_FORWARD FOR          
   SELECT Mov, MovID FROM     
   HistCobroMoratoriosMAVI     
   WHERE IDCobro = @ID     
   --AND MovID NOT IN (SELECT c.MovID From CondonaMoratoriosMAVI c WHERE IdCobro = @ID )    
    
   OPEN crCancelCobroPol          
   FETCH NEXT FROM crCancelCobroPol INTO @MovMor, @MovMorID    
   WHILE @@Fetch_Status =0          
   BEGIN -- 20        
    
    SELECT @FechaAnterior = NULL, @RemananteAnt = 0, @FechaOrigAnt = NULL,  @InteresesMoratoriosAnt = 0         
    SELECT @IDMAx = MAX(IDCobro) FROM HistCobroMoratoriosMAVI            
    WHERE Mov = @MovMor AND MovID = @MovMorID          
    
    SELECT @FechaAnterior = FechaOriginalAnt,          
    @RemananteAnt  = InteresMoratoriosAnt          
    FROM HistCobroMoratoriosMAVI            
    WHERE Mov = @MovMor AND MovID = @MovMorID AND IDCobro = @IDMAx          
    
    SELECT @FechaOrigAnt = FechaOriginalAnt, @InteresesMoratoriosAnt = interesmoratorioant, @IDDoc = ID FROM CXC WHERE Mov = @MovMor AND MovID = @MovMorID         
    
    UPDATE CXC        
    SET FechaOriginal = @FechaOrigAnt,                        
    InteresesMoratoriosMAVI = @InteresesMoratoriosAnt,     
    interesmoratorioant = @RemananteAnt,     
    FechaOriginalAnt = @FechaAnterior      
    WHERE ID = @IDDoc                  
    
    DELETE HistCobroMoratoriosMAVI WHERE Mov = @MovMor AND MovID = @MovMorID AND IDCobro = @IDMAx                       
    
    FETCH NEXT FROM crCancelCobroPol INTO @MovMor, @MovMorID    
   END  -- 20        
   CLOSE crCancelCobroPol          
   DEALLOCATE crCancelCobroPol            
    
   SET @FechaAplicacion = Getdate()      
      SET @FechaAplicacion = CONVERT(varchar(8),@FechaAplicacion,112)           
    
             set @IDDoc=NULL    
    
   SELECT @Padre = Origen, @PadreID = OrigenID FROM NegociaMoratoriosMAVI WHERE IDCobro = @ID    
    
   SELECT @IDDoc=MIN(ID)    
   FROM CXC WHERE PadreMAVI = @Padre AND PAdreIDMAVI = @PadreID AND Estatus = 'PENDIENTE' AND (Vencimiento <= @FechaAplicacion OR InteresesMoratoriosMAVI > 0)     
         AND ID NOT IN (SELECT ID FROM #HIST)     
    
          IF @IDDoc IS NOT NULL    
            BEGIN    
             SELECT @FechaAnterior = NULL, @RemananteAnt = 0, @FechaOrigAnt = NULL,  @InteresesMoratoriosAnt = 0         
             SELECT @FechaAnterior=vencimiento, @FechaOrigAnt = FechaOriginalAnt, @InteresesMoratoriosAnt = isnull(interesmoratorioant,0) FROM CXC WHERE ID=@IDDoc    
             
             UPDATE CXC        
    SET FechaOriginal = @FechaOrigAnt,                        
    InteresesMoratoriosMAVI = @InteresesMoratoriosAnt,     
    interesmoratorioant = @RemananteAnt,     
    FechaOriginalAnt = @FechaAnterior      
    WHERE ID = @IDDoc                  
            END      
    
       DROP TABLE #HIST    
    
  END     --1        

 END      
 --------------- TERMINA CANCELACION COBRO ---------------------           
    

 -- Actualización de Sucursal de Venta para CXC. GRB 07-05-10      
 IF @Modulo = 'CXC' AND @EstatusNuevo in ('CONCLUIDO','PENDIENTE')       
 BEGIN      
  DECLARE @SucursalV int, @OT varchar(10)      
  IF @MovTipo in ('CXC.F','CXC.CAP')      
  BEGIN      
   SELECT @OT = (SELECT OrigenTipo FROM CXC WHERE ID=@ID)      
   IF @OT='VTAS'      
   BEGIN      
    SELECT @SucursalV = (SELECT v.Sucursal FROM Venta v, CXC c WHERE C.ID=@ID AND v.Mov=c.Origen AND v.MovID=c.OrigenID)      
    UPDATE CXC SET Sucursal = @SucursalV WHERE ID=@ID      
    UPDATE CXC SET SucursalOrigen = @SucursalV WHERE ID=@ID      
   END      
  END      
 END      
  -- Termina Actualización de Sucursal de Venta de CXC       
      
/* Integracion CFDFlex BVF 01062012 */    
    
 SELECT @CFDFlex = ISNULL(CFDFlex,0), @eDoc = ISNULL(eDoc,0)     
 FROM EmpresaGral WHERE Empresa = @Empresa    
    
 SELECT @MovTipoCFDFlex = ISNULL(CFDFlex,0)     
 FROM MovTipo WHERE Mov = @Mov AND Modulo = @Modulo     
    
 IF @Modulo = 'CXC'     
 BEGIN      
  SELECT @MovTipo=MovTIpo.Clave, @Mov = cxc.Mov FROM CXC JOIN MovTipo  ON MovTipo.Mov = CXC.Mov    
  WHERE MovTipo.Modulo = 'CXC' AND CXC.ID = @ID    
    
  IF @MovTipo = 'CXC.CA'    
  BEGIN    
   SELECT @IDPadreMAVI = c.ID FROM CXC c JOIN NegociaMoratoriosMAVI d ON c.Mov = d.Mov AND c.MovID = d.MovID WHERE d.IDCobro=@ID    
       
   SELECT @MovTipo=MovTIpo.Clave FROM CXC JOIN MovTipo  ON MovTipo.Mov = CXC.Mov    
   WHERE MovTipo.Modulo = 'CXC' AND CXC.ID = @IDPadreMAVI    
    
   IF @MovTipo = 'CXC.CA'            
   BEGIN     
    SELECT @Concepto = Concepto, @MovIDPadre = MovID FROM Cxc WHERE ID = @IDPadreMAVI    
      
    IF @Concepto LIKE '%SALDO%' OR @MovIDPadre Like 'Z%'    
    BEGIN    
     SELECT @MovTipoCFDFlex = 0, @eDoc = 0    
    Print 'Nota Cargo Saldo Inicial o Recaptura: '+ @MovIDPAdre    
    END    
   END    
    
  END    
    
  IF @Mov in ('Cobro', 'Cobro Instituciones', 'Cobro Credito')    
  BEGIN    
   --SELECT 'Aplica Manual OK'--Test     
   SELECT TOP 1 @IDPadreMAVI = p.ID--, @MovPadre = p.Mov    
   FROM Cxc c JOIN CxcD d ON c.Mov = d.Aplica AND c.MovID = d.AplicaID     
        JOIN CXC p  ON c.PadreMAVI = p.Mov AND c.PadreIDMAVI = p.MovID     
   WHERE d.ID = @ID     
   GROUP BY p.ID--, p.Mov    
    
   IF @IDPadreMAVI IS NULL    
    SELECT @IDPadreMAVI = c.ID FROM CXC c JOIN NegociaMoratoriosMAVI d ON c.Mov = d.Origen AND c.MovID = d.OrigenID WHERE d.IDCobro=@ID    
    
Print 'CXCDetalle: '+ Convert(Varchar(20),isnull(@IDPadreMAVI,999999))    
    
   SELECT @MovTipo=MovTIpo.Clave FROM CXC JOIN MovTipo  ON MovTipo.Mov = CXC.Mov    
   WHERE MovTipo.Modulo = 'CXC' AND CXC.ID = @IDPadreMAVI    
    
   IF @MovTipo = 'CXC.CA'            
   BEGIN     
    SELECT @Concepto = Concepto, @MovIDPadre = MovID FROM Cxc WHERE ID = @IDPadreMAVI    
      
    IF @Concepto LIKE '%SALDO%' OR @MovIDPadre Like 'Z%'    
    BEGIN    
     SELECT @MovTipoCFDFlex = 0, @eDoc = 0    
    Print 'Nota Cargo Saldo Inicial o Recaptura: '+ @MovIDPAdre    
    END    
    ELSE    
    BEGIN    
     IF @Concepto like 'Canc%'    
     BEGIN    
      SELECT  @PadreMAVI = PadreMAVI, @PadreIDMAVI = PadreIDMAVI from CXC WHERE ID = @IDPadreMAVI     
      --print 'Corr'     
     END    
     ELSE    
     BEGIN    
      SELECT  @PadreMAVI=Origen, @PadreIDMAVI=OrigenID from NegociaMoratoriosMAVI WHERE NotaCargoMorID = @ID         --print 'Mor'     
     END    
     SELECT @IDPAdreMAVI = ID FROM CXC WHERE Mov= @PadreMAVI AND MovID = @PadreIDMAVI        
    END    
   END    
    
   IF @MovTipo = 'CXC.NC'            
   BEGIN     
    SELECT  @PadreMAVI=Origen, @PadreIDMAVI=OrigenID from NegociaMoratoriosMAVI WHERE NotaCredBonID = @ID     
    SELECT @IDPAdreMAVI = ID FROM CXC WHERE Mov= @PadreMAVI AND MovID = @PadreIDMAVI    
        
   END    
           
   SELECT @PadreMAVI = Mov, @Condicion = Condicion FROM CXC WHERE ID = @IDPadreMAVI    
   IF (SELECT ConsecutivoFiscal  from movtipo where mov = @PadreMAVI AND Modulo = 'CXC') = 0    
    SELECT @MovTipoCFDFlex = 0, @eDoc = 0    
   IF (SELECT Concepto FROM CXC WHERE ID = @IDPadreMAVI ) like '%Canc%'    
    SELECT @MovTipoCFDFlex = 0, @eDoc = 0    
   SELECT @Condicion = CFD_metodoDePago FROM Condicion WHERE Condicion = @Condicion    
   --print 'Condicion '+ @Condicion    
   IF @Condicion = 'CONTADO'    
    SELECT @MovTipoCFDFlex = 0, @eDoc = 0    
        
  END    
    
 END    

RETURN          
END
GO


/************************ spPOSGenereDoctos *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spPOSGenereDoctos') AND type = 'P') DROP PROCEDURE dbo.spPOSGenereDoctos
GO
CREATE PROCEDURE spPOSGenereDoctos
  @ID  varchar(36) ,          
  @Mov varchar(20) = NULL,          
  @Cadena varchar(MAX)  OUTPUT        
  --//WITH ENCRYPTION
 AS BEGIN           
          
 DECLARE           
 @FechaEmision  DateTime ,          
 @FechaCorte    DateTime,          
 @EsPar         varchar(5),          
 @Importe       money,          
 @NoDoctos  int,          
 @i    int,        
 @CadenaDoc  varchar(MAX),  --Imprimir Doc en Ticket        
 @DAPeriodo  char(15)    
          
           
    
 SELECT @FechaEmision=FechaEmision,@EsPar=Cte.Grupo,@NoDoctos=DANumeroDocumentos,    
  @Importe=    
  --Subtotal    
  ROUND(((ISNULL(SUM(ISNULL(((POSLVenta.Cantidad - ISNULL(POSLVenta.CantidadObsequio,0)) * (POSLVenta.Precio - (POSLVenta.Precio * (ISNULL(POSLVenta.DescuentoLinea,0)/100)))),0)),0.0))-    
  -- Descuentos    
  (SUM(ISNULL(((POSLVenta.Cantidad - ISNULL(POSLVenta.CantidadObsequio,0)) * (POSLVenta.Precio - (POSLVenta.Precio * (ISNULL(POSLVenta.DescuentoLinea,0)/100)))),0) * (CASE WHEN ISNULL(POSLVenta.AplicaDescGlobal, 1) = 1 THEN ISNULL(POSL.DescuentoGlobal,0.0
  
) ELSE 0 END) /100))+    
  -- Impuesto    
  (SUM(dbo.fnPOSImporteMov(( ISNULL(((POSLVenta.Cantidad - ISNULL(POSLVenta.CantidadObsequio,0)) * ((POSLVenta.Precio - (POSLVenta.Precio * (ISNULL(POSLVenta.DescuentoLinea,0)/100)))-((POSLVenta.Precio - (POSLVenta.Precio * (ISNULL(POSLVenta.DescuentoLinea,0)/100))) *           
        (CASE WHEN ISNULL(POSLVenta.AplicaDescGlobal, 1) = 1 THEN ISNULL(POSL.DescuentoGlobal,0.0) ELSE 0 END)/100))),0)),POSLVenta.Impuesto1,POSLVenta.Impuesto2, POSLVenta.Impuesto3 ,POSLVenta.Cantidad)-(ISNULL(((POSLVenta.Cantidad - ISNULL(POSLVenta.CantidadObsequio,0)) * ((POSLVenta.Precio - (POSLVenta.Precio *           
  (ISNULL(POSLVenta.DescuentoLinea,0)/100)))-((POSLVenta.Precio - (POSLVenta.Precio * (ISNULL(POSLVenta.DescuentoLinea,0)/100))) * (CASE WHEN ISNULL(POSLVenta.AplicaDescGlobal, 1) = 1 THEN ISNULL(POSL.DescuentoGlobal,0.0) ELSE 0 END)/100))),0))))),4)     
  
         
  /DANumeroDocumentos,    
        @DAPeriodo = DAPeriodo           
   FROM  POSL JOIN POSLVenta ON POSL.ID=POSLVenta.ID          
              JOIN Cte ON PosL.Cliente=Cte.Cliente          
              JOIN Condicion ON POSL.Condicion=Condicion.Condicion          
  WHERE POSL.ID=@ID          
  GROUP BY FechaEmision,Cte.Grupo,DANumeroDocumentos, DAPeriodo          
            
 IF @Mov='Factura Credito' AND @EsPar IN ('Non', 'Par') AND @DAPeriodo = 'Mensual'    
  BEGIN          
          
  DELETE TmpImprimirDocCte WHERE ID=@ID  And Modulo='VTAS' And Mov=@Mov            
         
  SELECT @i=1 ,@Cadena=''          
          
  WHILE @i < = @NoDoctos          
    BEGIN           
            
   IF @EsPar='Par'          
   BEGIN           
      IF  DAY(@FechaEmision) < = 31          
      SELECT  @FechaCorte=dbo.fnUltimoDiaMes(DATEADD(MONTH,@i,@FechaEmision)+1)          
   ELSE           
      SELECT  @FechaCorte=dbo.fnUltimoDiaMes(DATEADD(MONTH,@i+1,@FechaEmision))           
    END          
          
 ELSE IF @EsPar='Non' AND @DAPeriodo = 'Mensual'         
   BEGIN          
      IF DAY(@FechaEmision) < = 15          
      SELECT @FechaCorte=CONVERT(VARCHAR,YEAR(DATEADD(MONTH,@i,@FechaEmision)))+CONVERT(VARCHAR,REPLACE(STR((MONTH(DATEADD(MONTH,@i,@FechaEmision))),2,0),' ','0'))+'15'          
       ELSE           
      SELECT @FechaCorte=CONVERT(VARCHAR,YEAR(DATEADD(MONTH,@i+1,@FechaEmision)))+CONVERT(VARCHAR,REPLACE(STR((MONTH(DATEADD(MONTH,@i+1,@FechaEmision))),2,0),' ','0'))+'15'          
   END     
       
                
     SELECT @Cadena=@Cadena+('DOC  '+ Convert(varchar,@i) +' Vencimiento :' + CONVERT(VARCHAR,@FechaCorte,103)+  ' Importe : ' + dbo.fnFormatoMoneda(@Importe,''))+'<BR>'          
             
     --Inicio. Modificacion Imprimir Ticket Doc Por Pagar        
     SELECT @CadenaDoc=('DOC '+ Convert(varchar,@i) +'  Vencimiento : ' + CONVERT(VARCHAR,@FechaCorte,103)+  ' Importe : ' + dbo.fnFormatoMoneda(@Importe,''))          
     ---SELECT @CadenaDoc=('DOC '+ Convert(varchar,@i) +' Vencimiento :' + CONVERT(VARCHAR,@FechaCorte,103)+  ' Importe : ' + dbo.fnFormatoMoneda(@Importe,''))          
  
     INSERT INTO TmpImprimirDocCte VALUES (@CadenaDoc,@ID,'VTAS',@Mov)               
       
     --Fin.        
      SET @i+=1          
 END           
-- INSERT INTO TmpImprimirDocCte VALUES (@Cadena)               
 --update TmpImprimirDocCte Set DocPorPagar = replace(DocPorPagar,'<BR>', ' ')         
 END          
    
    
 IF @Mov='Factura Credito' AND @EsPar IN ('Non', 'Par')  AND @DAPeriodo = 'Quincenal'        
  BEGIN      
    DELETE TmpImprimirDocCte WHERE ID=@ID  And Modulo='VTAS' And Mov=@Mov      
            
    EXEC spPOSProrrateoFecha  @@spid, 1, @FechaEmision, 'Quincenal', @NoDoctos    
    --SELECT @FechaCorte= Fecha FROM ProrrateoFecha WHERE Estacion = 888       
        
     --SELECT @Cadena=@Cadena+('DOC '+ Convert(varchar,ROW_NUMBER() OVER(ORDER BY Fecha ASC)) +' Vencimiento :' + CONVERT(VARCHAR,Fecha,103)+  ' Importe : ' + dbo.fnFormatoMoneda(@Importe,''))+'<BR>' FROM ProrrateoFecha WHERE Estacion = @@spid         
     SELECT @Cadena=@Cadena+('DOC '+ Convert(varchar,ROW_NUMBER() OVER(ORDER BY Fecha ASC)) +' Vencimiento :' + CONVERT(VARCHAR,Fecha,103)+  ' Importe : ' + dbo.fnFormatoMoneda(@Importe,'FREY'))+'<BR>' FROM ProrrateoFecha WHERE Estacion = @@spid         
                  
     --Inicio. Modificacion Imprimir Ticket Doc Por Pagar     
     INSERT INTO TmpImprimirDocCte     
     SELECT ('DOC  '+ Convert(varchar,ROW_NUMBER() OVER(ORDER BY Fecha ASC)) +' Vencimiento :' + CONVERT(VARCHAR,Fecha,103)+  ' Importe : ' + dbo.fnFormatoMoneda(@Importe,'')), @ID,'VTAS',@Mov         
      FROM ProrrateoFecha     
     WHERE Estacion = @@spid     
     GROUP BY Fecha       
  END    
              
  RETURN           
 END
GO


/*** OK **/