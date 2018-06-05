SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF 
GO
--REQ12534 Factory 
/**************** spIntelisisServiceProcesarInfor ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisServiceProcesarInfor') and type = 'P') drop procedure dbo.spIntelisisServiceProcesarInfor
GO
CREATE PROCEDURE spIntelisisServiceProcesarInfor
      @Sistema          varchar(100),
      @ID               int,
      @iSolicitud       int,
      @Solicitud        varchar(max),
      @Version          float,
      @Referencia       varchar(100),
      @SubReferencia    varchar(100),
      @Resultado        varchar(max)    OUTPUT,
      @Ok               int    OUTPUT,
      @OkRef            varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
 IF @Referencia = 'Intelisis.COMS.InsertarMov.COMS_O'           EXEC spISIntelisisCOMSInsertarMovCOMS_O      @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.COMS.Mov.Listado'                  EXEC spIntelisisCOMSMovListado        @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Cuenta.Alm.Listado'                EXEC spIntelisisCuentaAlmListado       @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Cuenta.Art.Insertar'               EXEC spCuentaInsertarArt         @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Cuenta.ArtFam.Listado'             EXEC spIntelisisCuentaArtFamListado       @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Cuenta.Articulo.Listado'           EXEC spIntelisisCuentaArticuloListado      @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Cuenta.ArtLinea.Listado'           EXEC spIntelisisCuentaArtLineaListado      @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Cuenta.Cte.Listado'                EXEC spIntelisisCuentaCteListado       @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Cuenta.CteTipo.Listado'            EXEC spIntelisisCuentaCteTipoListado      @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Cuenta.Departamento.Listado'       EXEC spIntelisisCuentaDepartamentoListado     @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Cuenta.Empresa.Listado'            EXEC spIntelisisCuentaEmpresaListado      @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Cuenta.Mon.Listado'                EXEC spIntelisisCuentaMonListado       @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Cuenta.Mon.Listado'                EXEC spIntelisisMonTipoListado        @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Cuenta.MotivoRechazo.Listado'      EXEC spIntelisisCuentaMotivoRechazoListado     @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Cuenta.Personal.Listado'           EXEC spIntelisisCuentaPersonalListado      @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Cuenta.Planta.Listado'             EXEC spIntelisisCuentaPlantaListado       @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Cuenta.Planta.Usuario.Listado'     EXEC spIntelisisCuentaPlantaUsuarioListado     @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Cuenta.Prov.Listado'               EXEC spIntelisisCuentaProvListado       @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Cuenta.Sucursal.Listado'           EXEC spIntelisisCuentaSucursalListado      @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Cuenta.Unidad.Listado'             EXEC spIntelisisCuentaUnidadListado       @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Cuenta.Usuario.Listado'            EXEC spIntelisisCuentaUsuarioListado      @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.CancelarMov'        EXEC spISIntelisisCancelarMov        @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.ExistenciaMES'      EXEC sp_InvMES            @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.Insertar.CancelacionMov'    EXEC spISIntelisisCancelarMov        @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.Solicitud.ObjetivosVentas'  EXEC spObjetivoVentasIntelisisMES       @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.Transferencia.Alm'          EXEC spIntelisisInterfazInforTransferenciaAlm    @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.Transferencia.Art'          EXEC spIntelisisInterfazInforTransferenciaArt    @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.Transferencia.ArtContadorLotes'  EXEC spIntelisisInterfazInforTransferenciaArtContadorLotes @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.Transferencia.ArtFam'       EXEC spIntelisisInterfazInforTransferenciaArtFam   @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.Transferencia.ArtLinea'     EXEC spIntelisisInterfazInforTransferenciaArtLinea   @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.Transferencia.COMS_F'       EXEC spInforTransferenciaCOMS_F        @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.Transferencia.COMS_O'       EXEC spInforTransferenciaCOMS_O        @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.Transferencia.COMS_OC'      EXEC spInforTransferenciaCOMS_OC        @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.Transferencia.Cte'          EXEC spIntelisisInterfazInforTransferenciaCte    @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.Transferencia.CteTipo'      EXEC spIntelisisInterfazInforTransferenciaCteTipo   @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.Transferencia.Departamento'   EXEC spIntelisisInterfazInforTransferenciaDepartamento  @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.Transferencia.Empresa'      EXEC spIntelisisInterfazInforTransferenciaEmpresa   @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.Transferencia.Mon'          EXEC spIntelisisInterfazInforTransferenciaMon    @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.Transferencia.MotivoRechazo'  EXEC spIntelisisInterfazInforTransferenciaMotivoRechazo  @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.Transferencia.Opcion'       EXEC spIntelisisInterfazInforTransferenciaArtOpcion   @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.Transferencia.OpcionDetalle'  EXEC spIntelisisInterfazInforTransferenciaArtOpcionDetalle @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.Transferencia.Personal'     EXEC spIntelisisInterfazInforTransferenciaPersonal   @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.Transferencia.Planta'       EXEC spIntelisisInterfazInforTransferenciaPlanta   @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.Transferencia.PlantaUsuario'  EXEC spIntelisisInterfazInforTransferenciaPlantaUsuario  @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.Transferencia.Prov'         EXEC spIntelisisInterfazInforTransferenciaProv    @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.Transferencia.Sucursal'     EXEC spIntelisisInterfazInforTransferenciaSucursal   @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.Transferencia.Unidad'       EXEC spIntelisisInterfazInforTransferenciaUnidad   @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.Transferencia.Usuario'      EXEC spIntelisisInterfazInforTransferenciaUsuario   @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.Transferencia.VTAS_F'       EXEC spInforTransferenciaVTAS_F        @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.Transferencia.VTAS_P'       EXEC spInforTransferenciaVTAS_P        @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Interfaz.Infor.Transferencia.VTAS_PR'      EXEC spInforTransferenciaVTAS_PR        @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.INV.InsertarMov.INV_E'        EXEC spISIntelisisINVInsertarMovINV_E      @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.INV.InsertarMov.INV_EST'        EXEC spISIntelisisINVInsertarMovINV_EST      @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.INV.InsertarMov.INV_S'        EXEC spISIntelisisINVInsertarMovINV_S      @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 --- RJP 13 de Noviembre del 2014, para que no se generen solicitudes en la interfaz
 --- IF @Referencia = 'Intelisis.INV.InsertarMov.INV_SOL'      EXEC spISIntelisisINVInsertarMovINV_SOL      @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.COMS_INV.InsertarMov.Maquila' EXEC spISIntelisisCOMSInsertarMovCOMS_Maquila      @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.NOM.Rendimiento.NOM_P'        EXEC spIntelisisInterfazInforNOM_P       @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.PC.InsertarMov.PC_C'          EXEC spISIntelisisPCInsertarMovPC_C       @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.VTAS.Mov.Listado'             EXEC spIntelisisVTASMovListado        @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
 IF @Referencia = 'Intelisis.Art.ActCosto'                 EXEC spISIntelisisActualizarCosto @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT  

  RETURN
END
GO

/**************** sp_InvMES ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.sp_InvMES') and type = 'P') DROP PROCEDURE dbo.sp_InvMES
GO            
CREATE PROCEDURE sp_InvMES
  @ID    INT,
  @iSolicitud  INT,
  @Version  FLOAT,
  @Resultado  VARCHAR(MAX) = NULL OUTPUT,
  @Ok    INT = NULL OUTPUT,   
  @OkRef   VARCHAR(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
 
      SET NOCOUNT ON;
 
      DECLARE @query NVARCHAR(500)
      DECLARE @SQL NVARCHAR(MAX), @ReferenciaIntelisisService VARCHAR(50)
      DECLARE @inv VARCHAR(MAX), @xml VARCHAR(MAX), @ReferenciaIS VARCHAR(100), @SubReferencia VARCHAR(255)
      DECLARE @Articulo VARCHAR(50), @Lote VARCHAR(250), @Almacen VARCHAR(50), @Existencia FLOAT, @Pos INT, @Art VARCHAR(50)
      DECLARE @Coste FLOAT, @cont INTEGER, @SubCuenta VARCHAR(50)
      DECLARE @temp TABLE(
            Articulo VARCHAR(50),
            Lote VARCHAR(250),
            Almacen VARCHAR(50),
            Existencia FLOAT,
            Coste FLOAT
      )
 
      DECLARE @tabla TABLE(
            Articulo VARCHAR(50),
            SubCuenta VARCHAR(50),
            Lote VARCHAR(250),
            Almacen VARCHAR(50),
            Existencia FLOAT,
            Coste FLOAT
      )
    SELECT @ReferenciaIntelisisService = ReferenciaIntelisisService FROM OPENXML (@iSolicitud,'/Intelisis')
            WITH (ReferenciaIntelisisService VARCHAR(255))
 
      DECLARE @Cadena VARCHAR(500), @ResultadoBD VARCHAR(500), @Base VARCHAR(500)
      SET @SQL = N'SET ANSI_NULLS ON ' +
                     N'SET ANSI_WARNINGS ON ' +
               N'SET QUOTED_IDENTIFIER ON ' +
                     N'BEGIN TRY ' +
                     N'SELECT @Cadena = stringconexion
                         FROM QPFactoryQPL.dbo.relsucintelisis
                         WHERE nombrelogico = ' + CHAR(39) + @ReferenciaIntelisisService + CHAR(39) + N'END TRY ' +
                     N'BEGIN CATCH ' +
               N'  SELECT @Ok = @@ERROR,  @OkRef = ERROR_MESSAGE() ' +
               N'  IF XACT_STATE() = -1 ' +
               N'  BEGIN ' +
               N'    ROLLBACK TRAN ' +
               N'    SET @OkRef = ' + CHAR(39) + N'Error  ' + CHAR(39) + N' + CONVERT(VARCHAR,@Ok) + ' + CHAR(39) + N', ' + CHAR(39) + N' + @OkRef ' +
               N'    RAISERROR(@OkRef,20,1) WITH LOG ' +
               N'  END ' +
               N'END CATCH '
 
      EXEC sp_executesql @SQL, N'@Cadena VARCHAR(500) OUTPUT, @Ok INT OUTPUT, @OkRef VARCHAR(255) OUTPUT', @Cadena = @Cadena OUTPUT, @OK = @OK OUTPUT, @OkRef = @OkRef OUTPUT
 
      DECLARE @db_name VARCHAR(50)
      
    SELECT @Base = SUBSTRING(@Cadena, CHARINDEX('Catalog=',@Cadena)+ 8, LEN(@Cadena))
    SELECT @ResultadoBD = SUBSTRING(@Base, 1, CHARINDEX(';',@Base)-1)
 
    SET @db_name = @ResultadoBD
      /************* AGREGAR CONSULTA A VARIABLE @query PARA IMPORTAR ARTICULOS DESDE QP *************/
      SET @query = 'SELECT s.item AS CodigoArticulo, s.identificacion AS NumeroLote, ia.intalmacen AS almacen,
                          s.fisico As Existencia, i.scosto AS PrecioCosteMedio
                        FROM ' + @db_name + '.dbo.stock s
                        INNER JOIN ' + @db_name + '.dbo.items i ON i.item = s.item AND i.version = s.version ' +
                        'INNER JOIN ' + @db_name + '.dbo.intelisisalmacen ia ON ia.qpfalmacen = s.almacen'
                    
      INSERT INTO @temp
      EXEC sp_executesql @query
 
      DECLARE INVEN CURSOR FOR
      SELECT Articulo, Lote, Almacen, Existencia, Coste
      FROM @temp
 
      OPEN INVEN
      FETCH NEXT FROM INVEN INTO @Articulo , @Lote, @Almacen, @Existencia, @Coste
      WHILE @@FETCH_STATUS = 0 
      BEGIN
            SET @Articulo = LTRIM(RTRIM(@Articulo))+ '\'
            SET @Pos = CHARINDEX('\', @Articulo, 1)
 
            IF REPLACE(@Articulo, '\', '') <> ''
                  BEGIN
                        SET @cont = 0
                        WHILE @Pos > 0
                             BEGIN
                                   IF @cont = 0
                                         BEGIN
                                               SET @Art = LTRIM(RTRIM(LEFT(@Articulo, @Pos - 1)))
                                               SET @cont = @cont + 1
                                               SET @SubCuenta = ''
                                         END
                                   ELSE
                                         BEGIN
                                               SET @SubCuenta = LTRIM(RTRIM(LEFT(@Articulo, @Pos - 1)))
                                               SET @cont = 0
                                               INSERT INTO @tabla(Articulo, SubCuenta, Lote, Almacen, Existencia, Coste)
                                               VALUES (@Art, @SubCuenta, @Lote, @Almacen, @Existencia, @Coste)
                                         END
                                        
                                   SET @Articulo = RIGHT(@Articulo, LEN(@Articulo) - @Pos)
                                   SET @Pos = CHARINDEX('\', @Articulo, 1)
                                  
                                   IF @cont = 1 AND @Pos = 0
                                         BEGIN
                                               INSERT INTO @tabla(Articulo, SubCuenta, Lote, Almacen, Existencia, Coste)
                                               VALUES (@Art, @SubCuenta, @Lote, @Almacen, @Existencia, ISNULL(@Coste,0.0))
                                         END  
                             END
                  END
            FETCH NEXT FROM INVEN INTO @Articulo , @Lote, @Almacen, @Existencia, @Coste
      END
     
      CLOSE INVEN
      DEALLOCATE INVEN
 
      SET @inv = convert(VARCHAR(MAX), (SELECT * FROM @tabla INV FOR XML AUTO))
      IF @Ok IS NULL
            BEGIN
                  SELECT @ReferenciaIS = Referencia
                  FROM IntelisisService
                  WHERE ID = @ID
 
                  SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' +
                                               CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') +
                                               CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(VARCHAR ,@Version),'') + CHAR(34) +
                                               '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(VARCHAR,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) +
                                               ISNULL(CONVERT(VARCHAR,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +
                                               ' ReferenciaIntelisisService=' + CHAR(34) + ISNULL(@ReferenciaIntelisisService,'') + CHAR(34) + '>' +
                                               CONVERT(VARCHAR(MAX),@inv) + '</Resultado></Intelisis>'
                  IF @@ERROR <> 0 SET @Ok = 1
            END
END
GO
SET ANSI_WARNINGS OFF
GO    
/******************************* spValidaAux *************************************************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('spValidaAux') AND type = 'P') 
	DROP PROCEDURE dbo.spValidaAux
GO
CREATE PROCEDURE dbo.spValidaAux (
	@Empresa	varchar(5),
    @Usuario	varchar(10),
    @Sucursal	int,
	@Articulo	varchar(20) = NULL,
	@Almacen	varchar(100) = NULL,
	@SerieLote	varchar(50) = NULL,
	@Detalle	bit = 0,				-- 0 / 1 Muestra mas a detalle el resultado de las diferencias
	@SolicitarExistenciaMES bit = 1		-- 0 / 1 Ejecuta el sp spSolicitarExistenciaMES para mostrar diferencias en Inventarios
)
--//WITH ENCRYPTION
AS 
BEGIN
SET NOCOUNT ON

-- Verificar Inventarios, Actulizar ArtExistenciaIntMES --
IF @SolicitarExistenciaMES = 1
	EXEC spSolicitarExistenciaMES @Empresa, @Usuario, @Sucursal

IF (SELECT CHARACTER_MAXIMUM_LENGTH FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ArtExistenciaIntMES' AND COLUMN_NAME = 'SerieLote') < 50
	ALTER TABLE ArtExistenciaIntMES ALTER COLUMN SerieLote VARCHAR(50)

TRUNCATE TABLE dbo.IntelisisResultadoAux

-- Declaracion de Variables --
BEGIN
	DECLARE @ToleranciaAjuste	float,
			@RedondeoMonetarios	int,
			@Articulo_C			varchar(20),
			@SerieLote_C		varchar(50),
			@Almacen_C			varchar(100),
			@ExistenciaInte_C	float,
			@ExistenciaMES_C	float,
			@Direferncia_C		float,
			@Fecha_i1			datetime,
			@Cantidad_i1		float,
			@Articulo_i1		varchar(20),
			@Almacen_i1			varchar(100),
			@SerieLote_i1		varchar(50)

	DECLARE @IntelisisAux AS TABLE(
		IDRef			int identity,
		ID				int,
		Empresa			char(5),
		Articulo		char(20),
		Descripcion1	varchar(100),
		Tipo			varchar(20),
		EsFactory		bit,
		Almacen			char(100),
		Modulo			char(5),
		ModuloID		int,
		Mov				char(20),
		MovID			varchar(20),
		Renglon_AU		float,
		Fecha			datetime,
		Renglon			float,
		RenglonID		int,
		Cantidad		float,
		AlmOrigen		char(10),
		AlmDestino		char(10),
		CargoU			float,
		AbonoU			float,
		SerieLote		varchar(50),
		Cantidad_S		float,
		EsCancelacion	bit,
		numProcesado	tinyint)

	DECLARE @FactoryAux AS TABLE(
		IDRef				int identity,
		tipoubicacion		varchar(3),
		codigoubicacion		nvarchar(40),
		cantnota			real,
		id					int,
		codnota				nvarchar(6),
		letnota				nvarchar(2),
		sucnota				smallint,
		numnota				int,
		linnota				smallint,
		fecha				datetime,
		concepto			nvarchar(6),
		numeroot			int,
		almacen				nvarchar(16),
		seccion				nvarchar(20),
		proveedor			nvarchar(40),
		cliente				nvarchar(40),
		item				nvarchar(40),
		version				nvarchar(10),
		variante			nvarchar(10),
		identificacion		nvarchar(100),
		cantidad			real,
		stockantes			real,
		stockdespues		real,
		umedida				nvarchar(6),
		condicion			nvarchar(4),
		precio				money,
		codrel				nvarchar(6),
		sucrel				smallint,
		numrel				int,
		letrel				nvarchar(20),
		linrel				smallint,
		codrechazo			nvarchar(30),
		preciocalantes		money,
		preciocaldespues	money,
		importenencia		real,
		genera				nvarchar(30),
		fechasys			datetime,
		consolidado			bit,
		docproveedorsuc		smallint,
		docproveedornum		nvarchar(40),
		ordservicio			nvarchar(16),
		programa			varchar(20),
		numProcesado		tinyint)

	DECLARE @IntelisisRes AS TABLE(
		IDRef			int,
		ID				int,
		Empresa			char(5),
		Articulo		char(20),
		Descripcion1	varchar(100),
		Tipo			varchar(20),
		EsFactory		bit,
		Almacen			char(100),
		Modulo			char(5),
		ModuloID		int,
		Mov				char(20),
		MovID			varchar(20),
		Renglon_AU		float,
		Fecha			datetime,
		Renglon			float,
		RenglonID		int,
		Cantidad		float,
		AlmOrigen		char(10),
		AlmDestino		char(10),
		CargoU			float,
		AbonoU			float,
		SerieLote		varchar(50),
		Cantidad_S		float,
		EsCancelacion	bit,
		numProcesado	tinyint)

	DECLARE @FactoryRes AS TABLE(
		IDRef				int,
		tipoubicacion		varchar(3),
		codigoubicacion		nvarchar(40),
		cantnota			real,
		id					int,
		codnota				nvarchar(6),
		letnota				nvarchar(2),
		sucnota				smallint,
		numnota				int,
		linnota				smallint,
		fecha				datetime,
		concepto			nvarchar(6),
		numeroot			int,
		almacen				nvarchar(16),
		seccion				nvarchar(20),
		proveedor			nvarchar(40),
		cliente				nvarchar(40),
		item				nvarchar(40),
		version				nvarchar(10),
		variante			nvarchar(10),
		identificacion		nvarchar(100),
		cantidad			real,
		stockantes			real,
		stockdespues		real,
		umedida				nvarchar(6),
		condicion			nvarchar(4),
		precio				money,
		codrel				nvarchar(6),
		sucrel				smallint,
		numrel				int,
		letrel				nvarchar(20),
		linrel				smallint,
		codrechazo			nvarchar(30),
		preciocalantes		money,
		preciocaldespues	money,
		importenencia		real,
		genera				nvarchar(30),
		fechasys			datetime,
		consolidado			bit,
		docproveedorsuc		smallint,
		docproveedornum		nvarchar(40),
		ordservicio			nvarchar(16),
		programa			varchar(20),
		numProcesado		tinyint)
END

SELECT @ToleranciaAjuste = ToleranciaAjuste FROM EmpresaCfg
SELECT @RedondeoMonetarios = dbo.fnRedondeoMonetarios()

DECLARE ArtAux_Cursor_1 CURSOR FOR 
 SELECT Articulo, SerieLote, Almacen, ExistenciaInte, ExistenciaMES, ABS(ROUND(ExistenciaInte, @RedondeoMonetarios) - ROUND(ExistenciaMES, @RedondeoMonetarios)) Direferncia
   FROM ArtExistenciaIntMES 
  WHERE ROUND(ExistenciaInte, @RedondeoMonetarios) <> ROUND(ExistenciaMES, @RedondeoMonetarios)
    AND ABS(ROUND(ExistenciaInte, @RedondeoMonetarios) - ROUND(ExistenciaMES, @RedondeoMonetarios)) >= @ToleranciaAjuste
	AND	Articulo = ISNULL(@Articulo, Articulo) AND Almacen = ISNULL(@Almacen, Almacen) AND SerieLote = ISNULL(@SerieLote, SerieLote)
  ORDER BY Direferncia DESC

OPEN ArtAux_Cursor_1
FETCH NEXT FROM ArtAux_Cursor_1 
INTO @Articulo_C, @SerieLote_C, @Almacen_C, @ExistenciaInte_C, @ExistenciaMES_C, @Direferncia_C
WHILE @@FETCH_STATUS = 0
BEGIN
	BEGIN -- INSERTS
	INSERT	@IntelisisAux
	SELECT	au.ID, au.Empresa, au.Cuenta, a.Descripcion1, a.Tipo, a.EsFactory, au.Grupo, au.Modulo, au.ModuloID, au.Mov, au.MovID, au.Renglon, au.Fecha,
			'Renglon'= CASE
				WHEN au.Modulo = 'VTAS' THEN v.Renglon
				WHEN au.Modulo = 'COMS' THEN c.Renglon
				WHEN au.Modulo = 'INV'  THEN i.Renglon
				WHEN au.Modulo = 'PROD' THEN p.Renglon END,
			'RenglonID'= CASE
				WHEN au.Modulo = 'VTAS' THEN v.RenglonID
				WHEN au.Modulo = 'COMS' THEN c.RenglonID
				WHEN au.Modulo = 'INV'  THEN i.RenglonID
				WHEN au.Modulo = 'PROD' THEN p.RenglonID END,
			'Cantidad'= CASE
				WHEN au.Modulo = 'VTAS' THEN v.Cantidad
				WHEN au.Modulo = 'COMS' THEN c.Cantidad
				WHEN au.Modulo = 'INV'  THEN i.Cantidad
				WHEN au.Modulo = 'PROD' THEN p.Cantidad END,
			'AlmOrigen'=CASE
				WHEN au.Modulo = 'INV'  THEN (SELECT Almacen FROM Inv WHERE ID =i. ID) END,
			'AlmDestino'=CASE
				WHEN au .Modulo = 'INV' THEN (SELECT AlmacenDestino FROM Inv WHERE ID= i .ID) END,
			au.CargoU, au.AbonoU, s.SerieLote, s.Cantidad, au.EsCancelacion, 1
	  FROM	AuxiliarU au		WITH(NoLock, INDEX(Cuenta))
	  JOIN	Art a				WITH(NoLock, INDEX(priArt))  ON au.Cuenta = a.Articulo
	  LEFT	JOIN Alm al			WITH(NoLock, INDEX(priAlm))  ON au.Grupo  = al.Almacen
	  LEFT	JOIN VentaD v		WITH(NoLock, INDEX(Detalle))		 ON au.Modulo = 'VTAS' AND au.ModuloID = v.ID AND au.Renglon = v.Renglon AND au.Cuenta = v.Articulo
	  LEFT	JOIN CompraD c		WITH(NoLock, INDEX(MatarPendiente))  ON au.Modulo = 'COMS' AND au.ModuloID = c.ID AND au.Renglon = c.Renglon AND au.Cuenta = c.Articulo
	  LEFT	JOIN InvD i			WITH(NoLock, INDEX(MatarPendiente))  ON au.Modulo = 'INV'  AND au.ModuloID = i.ID AND au.Renglon = i.Renglon AND au.Cuenta = i.Articulo
	  LEFT	JOIN ProdD p		WITH(NoLock, INDEX(MatarPendiente))  ON au.Modulo = 'PROD' AND au.ModuloID = p.ID AND au.Renglon = p.Renglon AND au.Cuenta = p.Articulo
	  LEFT	JOIN SerieLoteMov s	WITH(NOLOCK, INDEX(priSerieLoteMov)) ON au.ModuloID = s.ID AND s.Modulo = au.Modulo AND s.RenglonID = (
			CASE
				WHEN au.Modulo = 'VTAS' THEN v.RenglonID
				WHEN au.Modulo = 'COMS' THEN c.RenglonID
				WHEN au.Modulo = 'INV'  THEN i.RenglonID
				WHEN au.Modulo = 'PROD' THEN p.RenglonID
			END)
	 WHERE	au.Rama = 'INV' AND a.Tipo IN ('Serie', 'Lote') AND a.EsFactory = 1 AND al.EsFactory = 1 AND a.Articulo = @Articulo_C AND al.Almacen = @Almacen_C AND s.SerieLote = @SerieLote_C
	 ORDER	BY au.ID DESC

	INSERT	@IntelisisAux 
	SELECT	ID, Empresa, Articulo, Descripcion1, Tipo, EsFactory, Almacen, Modulo, ModuloID, Mov, MovID, Renglon_AU, Fecha, Renglon, RenglonID, Cantidad, AlmOrigen, AlmDestino, CargoU, AbonoU, SerieLote, Cantidad_S, EsCancelacion, 2 
	  FROM	@IntelisisAux
	 WHERE	numProcesado = 1

	INSERT	@FactoryAux
	SELECT	*, 1
	  FROM	qpfactorynv.dbo.logstock WHERE item = @Articulo_C AND version = '0' AND tipoubicacion = 'ALM' AND codigoubicacion = cast(@Almacen_C as char(5)) AND identificacion = REPLACE (@SerieLote_C, '´','''')
	 ORDER	BY id DESC

	INSERT	@FactoryAux
	SELECT	*, 2
	  FROM	qpfactorynv.dbo.logstock WHERE item = @Articulo_C AND version = '0' AND tipoubicacion = 'ALM' AND codigoubicacion = cast(@Almacen_C as char(5)) AND identificacion = REPLACE (@SerieLote_C, '´','''')
	 ORDER	BY id DESC
	END -- INSERTS

	BEGIN -- CURSOR INTELISIS
	DECLARE IntelisisAux_Cursor_1 CURSOR FOR 
	 SELECT	Fecha, Cantidad, Articulo, Almacen, SerieLote
	   FROM	@IntelisisAux
	  WHERE	numProcesado = 1
	  ORDER	BY IDRef

	OPEN IntelisisAux_Cursor_1
	FETCH NEXT FROM IntelisisAux_Cursor_1 
	INTO @Fecha_i1, @Cantidad_i1, @Articulo_i1, @Almacen_i1, @SerieLote_i1
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET ROWCOUNT 1
		DELETE
		  FROM	@FactoryAux
		 WHERE	numProcesado = 2 AND fecha = @Fecha_i1 AND cantnota = @Cantidad_i1 AND item = @Articulo_i1 AND codigoubicacion = cast(@Almacen_i1 as char(5)) AND identificacion = REPLACE (@SerieLote_i1, '´','''')
		SET ROWCOUNT 0
		FETCH NEXT FROM IntelisisAux_Cursor_1 
		INTO @Fecha_i1, @Cantidad_i1, @Articulo_i1, @Almacen_i1, @SerieLote_i1
	END 
	CLOSE IntelisisAux_Cursor_1
	DEALLOCATE IntelisisAux_Cursor_1
	END -- CURSOR INTELISIS

	SELECT @Fecha_i1 = NULL, @Cantidad_i1 = NULL, @Articulo_i1 = NULL, @Almacen_i1 = NULL, @SerieLote_i1 = NULL

	BEGIN -- CURSOR FACTORY
	DECLARE FactoryAux_Cursor_1 CURSOR FOR 
	 SELECT	fecha, cantnota, item, codigoubicacion, identificacion
	   FROM	@FactoryAux
	  WHERE	numProcesado = 1
	  ORDER	BY IDRef

	BEGIN -- INSERT IntelisisResultadoAux
	OPEN FactoryAux_Cursor_1
	FETCH NEXT FROM FactoryAux_Cursor_1 
	INTO @Fecha_i1, @Cantidad_i1, @Articulo_i1, @Almacen_i1, @SerieLote_i1
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET ROWCOUNT 1
		DELETE
		  FROM	@IntelisisAux
		 WHERE	numProcesado = 2 AND Fecha = @Fecha_i1 AND Cantidad = @Cantidad_i1 AND Articulo = @Articulo_i1 AND cast(Almacen as char(5)) = @Almacen_i1 AND REPLACE (SerieLote, '´','''') = @SerieLote_i1
		SET ROWCOUNT 0
		FETCH NEXT FROM FactoryAux_Cursor_1 
		INTO @Fecha_i1, @Cantidad_i1, @Articulo_i1, @Almacen_i1, @SerieLote_i1
	END 
	CLOSE FactoryAux_Cursor_1
	DEALLOCATE FactoryAux_Cursor_1
	END -- CURSOR FACTORY

	INSERT	dbo.IntelisisResultadoAux 
	SELECT	IDRef, 'Intelisis',	Fecha,	Almacen,			Articulo,	SerieLote,		Cantidad,	ModuloID,	Mov,		MovID
	  FROM	@IntelisisAux
	 WHERE	numProcesado = 2

	INSERT	dbo.IntelisisResultadoAux 
	SELECT	IDRef, 'Infor',		fecha,	codigoubicacion,	item,		identificacion,	cantnota,	id,			Concepto,	cast(numnota as varchar(20))
	  FROM	@FactoryAux
	 WHERE	numProcesado = 2

    FETCH NEXT FROM ArtAux_Cursor_1 
    INTO @Articulo_C, @SerieLote_C, @Almacen_C, @ExistenciaInte_C, @ExistenciaMES_C, @Direferncia_C

	INSERT	@IntelisisRes
	SELECT	*
	  FROM	@IntelisisAux
	 WHERE	numProcesado = 2

	INSERT	@FactoryRes
	SELECT	*
	  FROM	@FactoryAux
	 WHERE	numProcesado = 2

	 DELETE	@IntelisisAux
	 DELETE	@FactoryAux
	END -- INSERT IntelisisResultadoAux

END 
CLOSE ArtAux_Cursor_1
DEALLOCATE ArtAux_Cursor_1

 SELECT 'ArtExistenciaIntMES' Sistema, Articulo, SerieLote, Almacen, ExistenciaInte, ExistenciaMES, ABS(ROUND(ExistenciaInte, @RedondeoMonetarios) - ROUND(ExistenciaMES, @RedondeoMonetarios)) Direferncia
   FROM ArtExistenciaIntMES 
  WHERE ROUND(ExistenciaInte, @RedondeoMonetarios) <> ROUND(ExistenciaMES, @RedondeoMonetarios)
    AND ABS(ROUND(ExistenciaInte, @RedondeoMonetarios) - ROUND(ExistenciaMES, @RedondeoMonetarios)) >= @ToleranciaAjuste
	AND	Articulo = ISNULL(@Articulo, Articulo) AND Almacen = ISNULL(@Almacen, Almacen) AND SerieLote = ISNULL(@SerieLote, SerieLote)

SELECT	'IntelisisResultadoAux' Sistema, * 
  FROM	dbo.IntelisisResultadoAux
 WHERE	Articulo = ISNULL(@Articulo, Articulo) AND Almacen = ISNULL(@Almacen, Almacen) AND SerieLote = ISNULL(@SerieLote, SerieLote)

IF @Detalle = 1
BEGIN
	SELECT	'Intelisis' Sistema, *
	  FROM	@IntelisisRes

	SELECT	'Infor' Sistema, *
	  FROM	@FactoryRes
END
SET NOCOUNT OFF
END
GO
