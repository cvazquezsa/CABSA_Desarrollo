-- spIntelisisFueraLinea null
-- spIntelisisFueraLinea '<Intelisis Contenido="FueraLinea"> <FueraLinea Modulo="VTAS" ModuloID="2">    <Venta ID="2" Empresa="DEMO" Mov="Pedido" MovID="2" FechaEmision="2009-03-31T00:00:00" UltimoCambio="2009-05-11T14:11:45.867" Moneda="Pesos" TipoCambio="1.000000000000000e+000" Usuario="DEMO" Estatus="FUERALINEA" Directo="1" Prioridad="Normal" RenglonID="1" Cliente="C1" Almacen="A1" FechaRequerida="2009-03-31T00:00:00" Vencimiento="2009-03-31T00:00:00" Importe="100.0000" Impuestos="15.0000" Saldo="115.0000" DescuentoLineal="0.0000" ComisionTotal="0.0000" CostoTotal="50.0000" PrecioTotal="100.0000" ServicioGarantia="0" ServicioFlotilla="0" ServicioRampa="0" ServicioExpress="0" ServicioDemerito="0" ServicioDeducible="0" ServicioPuntual="0" GenerarPoliza="0" Ejercicio="2009" Periodo="3" FechaRegistro="2009-05-11T14:11:45.867" Peso="0.000000000000000e+000" Volumen="0.000000000000000e+000" Extra="0" Sucursal="0" GenerarOP="0" DesglosarImpuestos="0" DesglosarImpuesto2="0" ExcluirPlaneacion="0" ConVigencia="0" IVAFiscal="1.304347826086957e-001" IEPSFiscal="0.000000000000000e+000" EstaImpreso="0" SubModulo="VTAS" Logico1="0" Logico2="0" Logico3="0" Logico4="0" EspacioResultado="0" Comentarios=" " GenerarDinero="0" DineroConciliado="0" Extra1="0" Extra2="0" Extra3="0" Reabastecido="0" SucursalVenta="0" AF="0" FordVisitoOASIS="0" TieneTasaEsp="0" SucursalOrigen="0" />    <VentaD ID="2" Renglon="2.048000000000000e+003" RenglonSub="0" RenglonID="1" RenglonTipo="N" Cantidad="1.000000000000000e+000" Almacen="A1" Articulo="A1" Precio="1.000000000000000e+002" PrecioSugerido="1.000000000000000e+002" Impuesto1="1.500000000000000e+001" Impuesto2="0.000000000000000e+000" Impuesto3="0.000000000000000e+000" Costo="50.0000" CantidadPendiente="1.000000000000000e+000" Unidad="Piezas" Factor="1.000000000000000e+000" FechaRequerida="2009-03-31T00:00:00" Sucursal="0" SucursalOrigen="0" PrecioMoneda="Pesos" PrecioTipoCambio="1.000000000000000e+000" ExcluirPlaneacion="0" Anexo="0" PresupuestoEsp="0" ExcluirISAN="0" />  </FueraLinea></Intelisis>'

-- select * from venta where estatus = 'fueralinea'
-- select * from ventad where id = 16
-- delete venta where id = 17
-- delete venta where id = 17


/**************** xpIntelisisFueraLineaEnviarOtros ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpIntelisisFueraLineaEnviarOtros') and sysstat & 0xf = 4) drop procedure dbo.xpIntelisisFueraLineaEnviarOtros
GO             
CREATE PROCEDURE xpIntelisisFueraLineaEnviarOtros
			@Modulo		varchar(5),
			@ID		int,
			@Resultado	varchar(max)	OUTPUT
AS BEGIN

  RETURN
END
GO

/**************** xpIntelisisFueraLineaRecibirOtros ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpIntelisisFueraLineaRecibirOtros') and sysstat & 0xf = 4) drop procedure dbo.xpIntelisisFueraLineaRecibirOtros
GO             
CREATE PROCEDURE xpIntelisisFueraLineaRecibirOtros
			@Modulo		varchar(5),
			@GenerarIDSt	varchar(20),
			@iDatos		int,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
AS BEGIN

  RETURN
END
GO


/**************** spIntelisisFueraLinea ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisFueraLinea') and sysstat & 0xf = 4) drop procedure dbo.spIntelisisFueraLinea
GO             
CREATE PROCEDURE spIntelisisFueraLinea
			@Datos	varchar(max)
--//WITH ENCRYPTION
AS BEGIN
DECLARE
  @Modulo	varchar(5),
  @ModuloID	int,
  @GenerarID	int,
  @GenerarIDSt	varchar(20),
  @Contenido	varchar(100),
  @iDatos	int,
  @Resultado	varchar(max),
  @MovID	varchar(20),
  @Estatus	varchar(15),
  @Ok		int,
  @OkRef	varchar(255)

  SET CONCAT_NULL_YIELDS_NULL ON
  
  SELECT @ModuloID = NULL, @Ok = NULL, @OkRef = NULL, @Resultado = NULL
  SELECT @Datos = NULLIF(RTRIM(@Datos),'')
  IF @Datos IS NOT NULL
  BEGIN
    EXEC sp_xml_preparedocument @iDatos OUTPUT, @Datos
    SELECT @Contenido = Contenido 
      FROM OPENXML (@iDatos, '/Intelisis',1) 
      WITH (Contenido varchar(255)) 
      
    IF @Contenido = 'FueraLinea'
    BEGIN
      SELECT @Modulo = Modulo, @ModuloID = ModuloID, @MovID = MovID
        FROM OPENXML (@iDatos, '/Intelisis/FueraLinea',1) 
        WITH (Modulo varchar(5), ModuloID int, MovID varchar(20))
      
      IF @Modulo = 'COMS'
      BEGIN
        SELECT @Estatus = NULL
        SELECT @Estatus = Estatus FROM Compra WHERE OrigenTipo = 'FR' AND Origen = @Modulo AND OrigenID = @MovID
        IF @Estatus IN ('BORRADOR', 'SINAFECTAR')
        BEGIN
          EXEC spEliminarMov @Modulo, @ModuloID
          SELECT @Estatus = NULL
        END
          
        IF @Estatus IS NULL
        BEGIN
          EXEC spTablaInsertarDesdeXML 'Compra',		@iDatos, '/Intelisis/FueraLinea/Compra'			SELECT @GenerarID = SCOPE_IDENTITY() SELECT @GenerarIDSt = CONVERT(varchar(20), @GenerarID)
          EXEC spTablaInsertarDesdeXML 'CompraD',		@iDatos, '/Intelisis/FueraLinea/CompraD',		'ID', @GenerarIDSt
          EXEC spTablaInsertarDesdeXML 'CompraCB',		@iDatos, '/Intelisis/FueraLinea/CompraCB',		'ID', @GenerarIDSt
          EXEC spTablaInsertarDesdeXML 'CompraGastoDiverso',	@iDatos, '/Intelisis/FueraLinea/CompraGastoDiverso',	'ID', @GenerarIDSt
          EXEC spTablaInsertarDesdeXML 'CompraGastoDiversoD',	@iDatos, '/Intelisis/FueraLinea/CompraGastoDiversoD',	'ID', @GenerarIDSt
          EXEC spTablaInsertarDesdeXML 'CompraDPresupuestoEsp',	@iDatos, '/Intelisis/FueraLinea/CompraDPresupuestoEsp',	'ID', @GenerarIDSt
          EXEC spTablaInsertarDesdeXML 'CompraDProrrateo',	@iDatos, '/Intelisis/FueraLinea/CompraDProrrateo',	'ID', @GenerarIDSt
          EXEC spTablaInsertarDesdeXML 'CompraImportacion',	@iDatos, '/Intelisis/FueraLinea/CompraImportacion',	'ID', @GenerarIDSt
          EXEC spTablaInsertarDesdeXML 'SerieLoteMov',		@iDatos, '/Intelisis/FueraLinea/SerieLoteMov',		'ID', @GenerarIDSt
        
          EXEC xpIntelisisFueraLineaRecibirOtros @Modulo, @GenerarIDSt, @iDatos, @Ok OUTPUT, @OkRef OUTPUT
          IF @Ok IS NULL
          BEGIN
            UPDATE Compra SET OrigenTipo = 'FR', Origen = @Modulo, OrigenID = @MovID, MovID = NULL, Estatus = 'BORRADOR' WHERE ID = @GenerarID
            EXEC spAfectar @Modulo, @GenerarID, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
          END
        END
      END

      IF @Modulo = 'INV'
      BEGIN
        SELECT @Estatus = NULL
        SELECT @Estatus = Estatus FROM Inv WHERE OrigenTipo = 'FR' AND Origen = @Modulo AND OrigenID = @MovID
        IF @Estatus IN ('BORRADOR', 'SINAFECTAR')
        BEGIN
          EXEC spEliminarMov @Modulo, @ModuloID
          SELECT @Estatus = NULL
        END
          
        IF @Estatus IS NULL
        BEGIN
          EXEC spTablaInsertarDesdeXML 'Inv',			@iDatos, '/Intelisis/FueraLinea/Inv'			SELECT @GenerarID = SCOPE_IDENTITY() SELECT @GenerarIDSt = CONVERT(varchar(20), @GenerarID)
          EXEC spTablaInsertarDesdeXML 'InvD',			@iDatos, '/Intelisis/FueraLinea/InvD',			'ID', @GenerarIDSt
          EXEC spTablaInsertarDesdeXML 'InvGastoDiverso',	@iDatos, '/Intelisis/FueraLinea/InvGastoDiverso',	'ID', @GenerarIDSt
          EXEC spTablaInsertarDesdeXML 'InvGastoDiversoD',	@iDatos, '/Intelisis/FueraLinea/InvGastoDiversoD',	'ID', @GenerarIDSt
          EXEC spTablaInsertarDesdeXML 'SerieLoteMov',		@iDatos, '/Intelisis/FueraLinea/SerieLoteMov',		'ID', @GenerarIDSt
        
          EXEC xpIntelisisFueraLineaRecibirOtros @Modulo, @GenerarIDSt, @iDatos, @Ok OUTPUT, @OkRef OUTPUT
          IF @Ok IS NULL
          BEGIN
            UPDATE Inv SET OrigenTipo = 'FR', Origen = @Modulo, OrigenID = @MovID, MovID = NULL, Estatus = 'BORRADOR' WHERE ID = @GenerarID
            EXEC spAfectar @Modulo, @GenerarID, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
          END
        END
      END

      IF @Modulo = 'VTAS'
      BEGIN
        SELECT @Estatus = NULL
        SELECT @Estatus = Estatus FROM Venta WHERE OrigenTipo = 'FR' AND Origen = @Modulo AND OrigenID = @MovID
        IF @Estatus IN ('BORRADOR', 'SINAFECTAR')
        BEGIN
          EXEC spEliminarMov @Modulo, @ModuloID
          SELECT @Estatus = NULL
        END
          
        IF @Estatus IS NULL
        BEGIN
          EXEC spTablaInsertarDesdeXML 'Venta',			@iDatos, '/Intelisis/FueraLinea/Venta'			SELECT @GenerarID = SCOPE_IDENTITY() SELECT @GenerarIDSt = CONVERT(varchar(20), @GenerarID)
          EXEC spTablaInsertarDesdeXML 'VentaD',		@iDatos, '/Intelisis/FueraLinea/VentaD',		'ID', @GenerarIDSt
          EXEC spTablaInsertarDesdeXML 'VentaDAgente',		@iDatos, '/Intelisis/FueraLinea/VentaDAgente',		'ID', @GenerarIDSt
          EXEC spTablaInsertarDesdeXML 'VentaCobro',		@iDatos, '/Intelisis/FueraLinea/VentaCobro',		'ID', @GenerarIDSt
          EXEC spTablaInsertarDesdeXML 'VentaCobroD',		@iDatos, '/Intelisis/FueraLinea/VentaCobroD',		'ID', @GenerarIDSt
          EXEC spTablaInsertarDesdeXML 'VentaEntrega',		@iDatos, '/Intelisis/FueraLinea/VentaEntrega',		'ID', @GenerarIDSt
          EXEC spTablaInsertarDesdeXML 'VentaFacturaAnticipo',	@iDatos, '/Intelisis/FueraLinea/VentaFacturaAnticipo',  'ID', @GenerarIDSt
          EXEC spTablaInsertarDesdeXML 'VentaOtros',		@iDatos, '/Intelisis/FueraLinea/VentaOtros',		'ID', @GenerarIDSt
          EXEC spTablaInsertarDesdeXML 'SerieLoteMov',		@iDatos, '/Intelisis/FueraLinea/SerieLoteMov',		'ID', @GenerarIDSt
          EXEC spTablaInsertarDesdeXML 'Cte',			@iDatos, '/Intelisis/FueraLinea/Cte',			'FueraLinea', '0'	
          EXEC spTablaInsertarDesdeXML 'CteCto',		@iDatos, '/Intelisis/FueraLinea/CteCto',		'FueraLinea', '0'	
          EXEC spTablaInsertarDesdeXML 'CteEnviarA',		@iDatos, '/Intelisis/FueraLinea/CteEnviarA',		'FueraLinea', '0'	
          EXEC spTablaInsertarDesdeXML 'Agente',		@iDatos, '/Intelisis/FueraLinea/Agente',		'FueraLinea', '0'	
          EXEC spTablaInsertarDesdeXML 'AgenteCte',		@iDatos, '/Intelisis/FueraLinea/AgenteCte',		'FueraLinea', '0'	
        
          EXEC xpIntelisisFueraLineaRecibirOtros @Modulo, @GenerarIDSt, @iDatos, @Ok OUTPUT, @OkRef OUTPUT
          IF @Ok IS NULL
          BEGIN
            UPDATE Venta SET OrigenTipo = 'FR', Origen = @Modulo, OrigenID = @MovID, MovID = NULL, Estatus = 'BORRADOR' WHERE ID = @GenerarID
            EXEC spAfectar @Modulo, @GenerarID, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
          END
        END
      END
      IF @Modulo IS NOT NULL
        SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252" ?>'+
               '<Intelisis'+
               dbo.fnXML('Contenido', 'FueraLineaProcesado')+
               '>'+
               '<FueraLineaProcesado'+
               dbo.fnXML('Modulo', @Modulo)+
               dbo.fnXMLInt('ModuloID', @ModuloID)+
               dbo.fnXMLInt('GenerarID', @GenerarID)+
               dbo.fnXMLInt('Ok', @Ok)+
               dbo.fnXML('OkRef', @OKRef)+             
               '></FueraLineaProcesado></Intelisis>'
    END ELSE
    IF @Contenido = 'FueraLineaProcesado'
    BEGIN
      SELECT @Modulo = Modulo, @ModuloID = ModuloID, @Ok = NULLIF(Ok, 0), @OkRef = OkRef
      FROM OPENXML (@iDatos, '/Intelisis/FueraLineaProcesado',1) 
      WITH (Modulo varchar(5), ModuloID int, Ok int, OkRef varchar(255))      
      IF @Ok BETWEEN 80030 AND 81000 SELECT @Ok = NULL
      IF @Modulo = 'VTAS' UPDATE Venta  SET Estatus = 'ENLINEA' WHERE ID = @ModuloID        
      IF @Modulo = 'COMS' UPDATE Compra SET Estatus = 'ENLINEA' WHERE ID = @ModuloID        
      IF @Modulo = 'INV'  UPDATE Inv    SET Estatus = 'ENLINEA' WHERE ID = @ModuloID        
      
      UPDATE Cte	SET FueraLinea = 0 WHERE FueraLinea = 1
      UPDATE CteCto	SET FueraLinea = 0 WHERE FueraLinea = 1
      UPDATE CteEnviarA	SET FueraLinea = 0 WHERE FueraLinea = 1
      UPDATE Agente	SET FueraLinea = 0 WHERE FueraLinea = 1
      UPDATE AgenteCte	SET FueraLinea = 0 WHERE FueraLinea = 1

      -- para que mande otro movimiento hay que borrar datos
      SELECT @Datos = NULL
    END 
    EXEC sp_xml_removedocument @iDatos
  END


  -- Aqui inicia el proceso
  IF @Datos IS NULL
  BEGIN
    UPDATE Version SET FueraLinea = 0
    SELECT @ModuloID = NULL, @Modulo = NULL

    -- Compras
    IF @ModuloID IS NULL
      SELECT @ModuloID = MIN(ID) FROM Compra WHERE Estatus = 'FUERALINEA'
    IF @ModuloID IS NOT NULL AND @Modulo IS NULL
    BEGIN
      SELECT @Modulo = 'COMS'
      SELECT @MovID = MovID 
        FROM Compra
       WHERE ID = @ModuloID
      SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?>'+
             '<Intelisis'+
             dbo.fnXML('Contenido', 'FueraLinea')+
             '>'+         
             '<FueraLinea'+
             dbo.fnXML('Modulo', @Modulo)+
             dbo.fnXMLInt('ModuloID', @ModuloID)+
             dbo.fnXML('MovID', @MovID)+
             '>'             
      SELECT @Resultado = @Resultado + ISNULL((SELECT * FROM Compra                WHERE ID = @ModuloID FOR XML RAW('Compra')), '')
      SELECT @Resultado = @Resultado + ISNULL((SELECT * FROM CompraD               WHERE ID = @ModuloID FOR XML RAW('CompraD')), '')
      SELECT @Resultado = @Resultado + ISNULL((SELECT * FROM CompraCB		   WHERE ID = @ModuloID FOR XML RAW('CompraCB')), '')
      SELECT @Resultado = @Resultado + ISNULL((SELECT * FROM CompraGastoDiverso    WHERE ID = @ModuloID FOR XML RAW('CompraGastoDiverso')), '')     
      SELECT @Resultado = @Resultado + ISNULL((SELECT * FROM CompraGastoDiversoD   WHERE ID = @ModuloID FOR XML RAW('CompraGastoDiversoD')), '')     
      SELECT @Resultado = @Resultado + ISNULL((SELECT * FROM CompraDPresupuestoEsp WHERE ID = @ModuloID FOR XML RAW('CompraDPresupuestoEsp')), '')     
      SELECT @Resultado = @Resultado + ISNULL((SELECT * FROM CompraDProrrateo      WHERE ID = @ModuloID FOR XML RAW('CompraDProrrateo')), '')     
      SELECT @Resultado = @Resultado + ISNULL((SELECT * FROM CompraImportacion     WHERE ID = @ModuloID FOR XML RAW('CompraImportacion')), '')
      SELECT @Resultado = @Resultado + ISNULL((SELECT * FROM SerieLoteMov          WHERE Modulo = @Modulo AND ID = @ModuloID FOR XML RAW('SerieLoteMov')), '')

      EXEC xpIntelisisFueraLineaEnviarOtros @Modulo, @ModuloID, @Resultado OUTPUT
      SELECT @Resultado = @Resultado + '</FueraLinea></Intelisis>'
    END

    -- Inv
    IF @ModuloID IS NULL
      SELECT @ModuloID = MIN(ID) FROM Inv WHERE Estatus = 'FUERALINEA'
    IF @ModuloID IS NOT NULL AND @Modulo IS NULL
    BEGIN
      SELECT @Modulo = 'INV'
      SELECT @MovID = MovID 
        FROM Inv
       WHERE ID = @ModuloID
      SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?>'+
             '<Intelisis'+
             dbo.fnXML('Contenido', 'FueraLinea')+
             '>'+         
             '<FueraLinea'+
             dbo.fnXML('Modulo', @Modulo)+
             dbo.fnXMLInt('ModuloID', @ModuloID)+
             dbo.fnXML('MovID', @MovID)+
             '>'             
      SELECT @Resultado = @Resultado + ISNULL((SELECT * FROM Inv		   WHERE ID = @ModuloID FOR XML RAW('Inv')), '')
      SELECT @Resultado = @Resultado + ISNULL((SELECT * FROM InvD		   WHERE ID = @ModuloID FOR XML RAW('InvD')), '')
      SELECT @Resultado = @Resultado + ISNULL((SELECT * FROM InvGastoDiverso       WHERE ID = @ModuloID FOR XML RAW('InvGastoDiverso')), '')     
      SELECT @Resultado = @Resultado + ISNULL((SELECT * FROM InvGastoDiversoD      WHERE ID = @ModuloID FOR XML RAW('InvGastoDiversoD')), '')     
      SELECT @Resultado = @Resultado + ISNULL((SELECT * FROM SerieLoteMov          WHERE Modulo = @Modulo AND ID = @ModuloID FOR XML RAW('SerieLoteMov')), '')

      EXEC xpIntelisisFueraLineaEnviarOtros @Modulo, @ModuloID, @Resultado OUTPUT
      SELECT @Resultado = @Resultado + '</FueraLinea></Intelisis>'
    END


    -- Ventas
    IF @ModuloID IS NULL
      SELECT @ModuloID = MIN(ID) FROM Venta WHERE Estatus = 'FUERALINEA'
    IF @ModuloID IS NOT NULL AND @Modulo IS NULL
    BEGIN
      SELECT @Modulo = 'VTAS'
      SELECT @MovID = MovID 
        FROM Venta
       WHERE ID = @ModuloID
      SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?>'+
             '<Intelisis'+
             dbo.fnXML('Contenido', 'FueraLinea')+
             '>'+         
             '<FueraLinea'+
             dbo.fnXML('Modulo', @Modulo)+
             dbo.fnXMLInt('ModuloID', @ModuloID)+
             dbo.fnXML('MovID', @MovID)+
             '>'

      SELECT @Resultado = @Resultado + ISNULL((SELECT * FROM Venta                WHERE ID = @ModuloID FOR XML RAW('Venta')), '')
      SELECT @Resultado = @Resultado + ISNULL((SELECT * FROM VentaD               WHERE ID = @ModuloID FOR XML RAW('VentaD')), '')
      SELECT @Resultado = @Resultado + ISNULL((SELECT * FROM VentaDAgente         WHERE ID = @ModuloID FOR XML RAW('VentaDAgente')), '')
      SELECT @Resultado = @Resultado + ISNULL((SELECT * FROM VentaCobro           WHERE ID = @ModuloID FOR XML RAW('VentaCobro')), '')
      SELECT @Resultado = @Resultado + ISNULL((SELECT * FROM VentaCobroD          WHERE ID = @ModuloID FOR XML RAW('VentaCobroD')), '')
      SELECT @Resultado = @Resultado + ISNULL((SELECT * FROM VentaEntrega         WHERE ID = @ModuloID FOR XML RAW('VentaEntrega')), '')
      SELECT @Resultado = @Resultado + ISNULL((SELECT * FROM VentaFacturaAnticipo WHERE ID = @ModuloID FOR XML RAW('VentaFacturaAnticipo')), '')
      SELECT @Resultado = @Resultado + ISNULL((SELECT * FROM VentaOtros           WHERE ID = @ModuloID FOR XML RAW('VentaOtros')), '')
      SELECT @Resultado = @Resultado + ISNULL((SELECT * FROM SerieLoteMov         WHERE Modulo = @Modulo AND ID = @ModuloID FOR XML RAW('SerieLoteMov')), '')
      SELECT @Resultado = @Resultado + ISNULL((SELECT * FROM Cte	          WHERE FueraLinea = 1 FOR XML RAW('Cte')), '')
      SELECT @Resultado = @Resultado + ISNULL((SELECT * FROM CteCto	          WHERE FueraLinea = 1 FOR XML RAW('CteCto')), '')
      SELECT @Resultado = @Resultado + ISNULL((SELECT * FROM CteEnviarA	          WHERE FueraLinea = 1 FOR XML RAW('CteEnviarA')), '')
      SELECT @Resultado = @Resultado + ISNULL((SELECT * FROM Agente	          WHERE FueraLinea = 1 FOR XML RAW('Agente')), '')
      SELECT @Resultado = @Resultado + ISNULL((SELECT * FROM AgenteCte	          WHERE FueraLinea = 1 FOR XML RAW('AgenteCte')), '')

      EXEC xpIntelisisFueraLineaEnviarOtros @Modulo, @ModuloID, @Resultado OUTPUT
      SELECT @Resultado = @Resultado + '</FueraLinea></Intelisis>'

    END
  END

  SELECT 'Resultado' = @Resultado

  SET CONCAT_NULL_YIELDS_NULL OFF
  RETURN
END
GO