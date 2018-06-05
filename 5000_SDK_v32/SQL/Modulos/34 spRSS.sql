/********* RSS ***********/


-- spRSSCanal @Canal (XML del RSS, UPDATE RSSCanal SET Actualizar = 0
-- spRSSCanalLista  (SELECT Canal, Archivo FROM RSSCanal WHERE Estatus = 'ALTA' AND Actualizar = 1)


-- Es Necesario Instalar SQLXML en IIS
/*
<head>
<link rel="alternate" type="application/rss+xml" title="Intelisis - Noticias [RSS]" href="http://www.intelisis.com/Intelisis/rss/noticias.rss">
<link rel="alternate" type="application/rss+xml" title="Intelisis - Mejoras [RSS]" href="http://www.intelisis.com/Intelisis/rss/mejoras.rss">
</head>
*/

-- update rsscanal set actualizar = 1
-- spRSSCanalLista

/**************** spRSSCanalLista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRSSCanalLista') and type = 'P') drop procedure dbo.spRSSCanalLista
GO
CREATE PROCEDURE spRSSCanalLista
--//WITH ENCRYPTION
AS BEGIN
  SELECT c.Canal, 'Archivo' = dbo.fnDir(t.RutaXML)+c.ArchivoXML 
    FROM RSSCanal c
    JOIN RSSCanalTipo t ON t.Tipo = c.Tipo
   WHERE c.Estatus = 'ALTA' AND c.Actualizar = 1
  RETURN
END
GO

-- set nocount on
-- spRSSCanal 'Noticias'
/**************** spRSSCanal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRSSCanal') and type = 'P') drop procedure dbo.spRSSCanal
GO
CREATE PROCEDURE spRSSCanal
			@Canal	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Codificacion	varchar(20),
    @GUID		varchar(255),
    @CDATA		bit,
    @ZonaHoraria	varchar(20),
    @DesdeFecha		datetime,
    @ID			int,
    @Adjunto		bit,
    @Titulo		varchar(255), 
    @Hipervinculo	varchar(255), 
    @FechaPublicacion	datetime,
    @AutorEMail		varchar(50),
    @ArtOrigen		varchar(50),
    @ArtOrigenLink	varchar(50),
    @Categoria		varchar(50)

  SELECT @Categoria = Categoria,
         @Codificacion = Codificacion,
         @GUID = NULLIF(RTRIM(GUID), ''),
         @CDATA = CDATA,
         @ZonaHoraria = ZonaHoraria,
         @DesdeFecha = dbo.fnHastaFecha(GETDATE(), Publicar, PublicarUnidad)
    FROM RSSCanal
    JOIN RSSCanalTipo t ON t.Tipo = rssCanal.Tipo
   WHERE Canal = @Canal

  SELECT '<?xml'+
              dbo.fnXML('version','1.0')+
              dbo.fnXML('encoding', @Codificacion)+
             ' ?>'
   FROM RSSCanal
  WHERE Canal = @Canal

  SELECT '<rss'+dbo.fnXML('version','2.0')+'>'
  SELECT '<channel>'+
            dbo.fnTag('title', Titulo)+
            dbo.fnTag('link', Hipervinculo)+
            dbo.fnTag('description', Descripcion)+
            dbo.fnTag('language', Lenguaje)+
            dbo.fnTagDatetimeFmtZH('pubDate', GETDATE(), 'RFC822', @ZonaHoraria)+
            dbo.fnTagDatetimeFmtZH('lastBuildDate', UltimoCambio, 'RFC822', @ZonaHoraria)+
            dbo.fnTag('copyright', Copyright)+
            dbo.fnTag('managingEditor', ResponsableContenido)+
            dbo.fnTag('webMaster', WebMaster)+
            dbo.fnTag('category', Categoria)+
            dbo.fnTag('generator', 'Intelisis')+
            dbo.fnTag('docs', 'http://www.rssboard.org/rss-specification')+
            dbo.fnTag('ttl', TTL)
    FROM RSSCanal 
    JOIN RSSCanalTipo t ON t.Tipo = rssCanal.Tipo
   WHERE Canal = @Canal

  IF (SELECT Imagen FROM RSSCanalCat WHERE Categoria = @Categoria) = 1
    SELECT '<image>'+
              dbo.fnTag('title', ImagenTitulo)+
              dbo.fnTag('url',   ImagenURL)+
              dbo.fnTag('link',  ImagenHipervinculo)+
              dbo.fnTagInt('width', ImagenAncho)+
              dbo.fnTagInt('height', ImagenAlto)+
           '</image>'
      FROM RSSCanalCat
     WHERE Categoria = @Categoria

  DECLARE crRSS CURSOR LOCAL FOR
   SELECT rss.ID, rss.Titulo, rss.Hipervinculo, rss.FechaPublicacion, ISNULL(rss.Adjunto, 0), a.eMail, NULLIF(RTRIM(rss.ArtOrigen), ''), f.Hipervinculo
     FROM RSS
     LEFT OUTER JOIN Agente a ON a.Agente = rss.Autor
     LEFT OUTER JOIN RSSArtOrigen f ON f.ArtOrigen = rss.ArtOrigen
    WHERE rss.Estatus = 'CONCLUIDO' AND rss.FechaPublicacion >= @DesdeFecha AND rss.Canal = @Canal
    ORDER BY rss.FechaPublicacion DESC

  OPEN crRSS
  FETCH NEXT FROM crRSS INTO @ID, @Titulo, @Hipervinculo, @FechaPublicacion, @Adjunto, @AutorEMail, @ArtOrigen, @ArtOrigenLink
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2
    BEGIN
      SELECT '<item>'
        SELECT '<title>'
        IF @CDATA = 1 SELECT '<![CDATA['
        SELECT @Titulo
        IF @CDATA = 1 SELECT ']]>'
        SELECT '</title>'

        SELECT '<description>'
        IF @CDATA = 1 SELECT '<![CDATA['
        SELECT Descripcion FROM RSS WHERE ID = @ID
        IF @CDATA = 1 SELECT ']]>'
        SELECT '</description>'

        SELECT '<comments>'
        IF @CDATA = 1 SELECT '<![CDATA['
        SELECT Comentarios FROM RSS WHERE ID = @ID
        IF @CDATA = 1 SELECT ']]>'
        SELECT '</comments>'

        SELECT dbo.fnTag('link', @Hipervinculo)+
               dbo.fnTagDatetimeFmtZH('pubDate', @FechaPublicacion, 'RFC822', @ZonaHoraria)+
               dbo.fnTag('category', @Categoria)+
               dbo.fnTag('author', @AutorEMail)+
               dbo.fnTag('guid', @GUID+'\'+CONVERT(varchar, @ID))

        IF @ArtOrigen IS NOT NULL
          SELECT '<source'+
                    dbo.fnXML('url', @ArtOrigenLink)+'>'+
                    @ArtOrigen+
                 '</source>'

        IF @Adjunto = 1
          SELECT '<enclosure'+
                    dbo.fnXML('url', AdjuntoURL)+
                    dbo.fnXML('length', AdjuntoTamano)+
                    dbo.fnXML('type', AdjuntoTipo)+' />'
            FROM RSS 
           WHERE ID = @ID
      SELECT '</item>'
    END
    FETCH NEXT FROM crRSS INTO @ID, @Titulo, @Hipervinculo, @FechaPublicacion, @Adjunto, @AutorEMail, @ArtOrigen, @ArtOrigenLink
  END
  CLOSE crRSS
  DEALLOCATE crRSS

  SELECT '</channel>'
  SELECT '</rss>'

  UPDATE RSSCanal SET Actualizar = 0 WHERE Canal = @Canal
  RETURN
END
GO


/**************** spRSSVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRSSVerificar') and type = 'P') drop procedure dbo.spRSSVerificar
GO
CREATE PROCEDURE spRSSVerificar
    		    @ID               		int,
		    @Accion			char(20),
    		    @Empresa          		char(5),
		    @Usuario			char(10),
    		    @Modulo	      		char(5),
    		    @Mov              		char(20),
	            @MovID			varchar(20),
    		    @MovTipo	      		char(20),
		    @MovMoneda			char(10),
		    @MovTipoCambio		float,
		    @FechaEmision		datetime,
		    @Estatus			char(15),
		    @EstatusNuevo		char(15),

		    @Canal			varchar(50),

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,

    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN

  IF @Accion = 'CANCELAR'
  BEGIN
    -- Checar que se haya capturado el movimiento en este modulo
    IF @Conexion = 0 
      IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo)
	SELECT @Ok = 60070
  END ELSE
  BEGIN
    IF @Canal IS NULL SELECT @Ok = 13510
  END

  RETURN
END
GO


/**************** spRSSAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRSSAfectar') and type = 'P') drop procedure dbo.spRSSAfectar
GO             
CREATE PROCEDURE spRSSAfectar
    		   @ID                		int,

		   @Accion			char(20),
		   @Base			char(20),
    		   @Empresa	      		char(5),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20)	OUTPUT,
    		   @MovTipo     		char(20),
		   @MovMoneda			char(10),
		   @MovTipoCambio		float,
    		   @FechaEmision      		datetime,
    		   @FechaAfectacion      	datetime,
    		   @FechaConclusion		datetime,

    	 	   @Proyecto	      		varchar(50),
    		   @Usuario	      		char(10),
    		   @Autorizacion      		char(10),
    		   @DocFuente	      		int,
    		   @Observaciones     		varchar(255),
    		   @Concepto     		varchar(50),
		   @Referencia			varchar(50),
    		   @Estatus           		char(15),
 	    	   @EstatusNuevo	      	char(15),
    		   @FechaRegistro     		datetime,
    		   @Ejercicio	      		int,
    		   @Periodo	      		int,
		   @MovUsuario			char(10),

		   @Canal			varchar(50),

		   @Conexion			bit,
                   @SincroFinal			bit,
                   @Sucursal			int,
                   @SucursalDestino		int,
                   @SucursalOrigen		int,

		   @CfgContX			bit,
		   @CfgContXGenerar		char(20),
		   @GenerarPoliza		bit,

		   @Generar			bit,
    		   @GenerarMov			char(20),
	           @GenerarAfectado		bit,
		   @IDGenerar			int	     	OUTPUT,	
    		   @GenerarMovID	  	varchar(20)	OUTPUT,

       		   @Ok                		int          OUTPUT,
    		   @OkRef             		varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @CancelarID		int,
    @FechaCancelacion	datetime,
    @GenerarMovTipo	char(20),
    @GenerarPeriodo	int,
    @GenerarEjercicio	int
    
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

    IF @Ok IS NULL
    BEGIN
      INSERT RSSD (
             Aplica, AplicaID, Sucursal,  ID,         Renglon, RenglonSub, Tarima, Unidad, Factor, Posicion, PosicionDestino, Articulo, Cantidad) 
      SELECT @Mov,   @MovID,   @Sucursal, @IDGenerar, Renglon, RenglonSub, Tarima, Unidad, Factor, Posicion, PosicionDestino, Articulo, CASE @Base WHEN 'SELECCION' THEN CantidadA WHEN 'PENDIENTE' THEN CantidadPendiente ELSE Cantidad END
        FROM RSSD
       WHERE ID = @ID

      IF @Base = 'SELECCION' UPDATE RSSD SET CantidadA = NULL WHERE ID = @ID
      DELETE RSSD WHERE ID= @IDGenerar AND NULLIF(Cantidad, 0.0) IS NULL

      IF @Ok IS NULL SELECT @Ok = 80030
    END
    RETURN
  END


  IF @Conexion = 0 
    BEGIN TRANSACTION

    -- Poner el Estatus del Movimiento en "AFECTANDO"
    EXEC spMovEstatus @Modulo, 'AFECTANDO', @ID, @Generar, @IDGenerar, @GenerarAfectado, @Ok OUTPUT

    -- Cancelar Movimientos Generados en el Mismo Modulo
    IF @Accion = 'CANCELAR'
    BEGIN
      DECLARE crRSSCancelar CURSOR FOR
       SELECT ID
         FROM RSS
        WHERE OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
      OPEN crRSSCancelar
      FETCH NEXT FROM crRSSCancelar INTO @CancelarID
      WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 
          EXEC spAfectar @Modulo, @CancelarID, 'CANCELAR', @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

        FETCH NEXT FROM crRSSCancelar INTO @CancelarID
      END
      CLOSE crRSSCancelar
      DEALLOCATE crRSSCancelar
    END

    IF @Accion <> 'CANCELAR' 
      -- Registrar el Movimiento en "Mov"
      EXEC spRegistrarMovimiento @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @Ejercicio, @Periodo, @FechaRegistro, @FechaEmision,
                       	         NULL, @Proyecto, @MovMoneda, @MovTipoCambio,
                       	         @Usuario, @Autorizacion, NULL, @DocFuente, @Observaciones,
			         @Generar, @GenerarMov, @GenerarMovID, @IDGenerar,
				 @Ok OUTPUT

    IF @Accion IN ('AFECTAR', 'CANCELAR') 
    BEGIN
      -- Actualizar Canal
      UPDATE RSSCanal
         SET TieneMovimientos = 1,
             Actualizar = 1,
             UltimoCambio = @FechaRegistro
       WHERE Canal = @Canal

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
        UPDATE RSS
           SET FechaConclusion  = @FechaConclusion, 
               FechaCancelacion = @FechaCancelacion, 
               UltimoCambio     = CASE WHEN UltimoCambio IS NULL THEN @FechaRegistro ELSE UltimoCambio END,
	       Estatus          = @EstatusNuevo,
               Situacion 	= CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END/*,
               GenerarPoliza    = @GenerarPoliza*/
         WHERE ID = @ID 
        IF @@ERROR <> 0 SELECT @Ok = 1
      END
    END

    -- Agregar a Estatus Log
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT

    -- Cancelar el Flujo
    IF @Accion = 'CANCELAR' AND @EstatusNuevo = 'CANCELADO' AND @Ok IS NULL
      EXEC spCancelarFlujo @Empresa, @Modulo, @ID, @Ok OUTPUT 

  IF @Conexion = 0
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      COMMIT TRANSACTION
    ELSE
      ROLLBACK TRANSACTION
    
  RETURN
END
GO

/**************** spRSS ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRSS') and type = 'P') drop procedure dbo.spRSS
GO
CREATE PROCEDURE spRSS
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
  -- SET nocount ON
  DECLARE
    @Generar		bit,
    @GenerarAfectado	bit,
    @Sucursal		int,
    @SucursalDestino	int,
    @SucursalOrigen	int,
    @EnLinea		bit,
    @PuedeEditar	bit,
    @Empresa	      	char(5),
    @MovTipo   		char(20),
    @MovMoneda		char(10),
    @MovTipoCambio	float,
    @FechaEmision     	datetime,
    @FechaAfectacion	datetime,
    @FechaConclusion	datetime,
    @Proyecto	      	varchar(50),
    @MovUsuario	      	char(10),
    @Autorizacion     	char(10),
    @DocFuente	      	int,
    @Concepto    	varchar(50),
    @Referencia 	varchar(50),
    @Observaciones    	varchar(255),
    @Estatus          	char(15),
    @EstatusNuevo	char(15),
    @Ejercicio	      	int,
    @Periodo	      	int,
    @Canal		varchar(50),
    @GenerarMovID	varchar(20),
    @GenerarPoliza	bit,
    @CfgContX		bit,
    @CfgContXGenerar	char(20)/*,
    @Verificar		bit*/

  -- Inicializar Variables
  SELECT @Generar	   = 0,
	 @GenerarAfectado  = 0,
         @CfgContX         = 0,
         @CfgContXGenerar  = 'NO'/*,
	 @Verificar        = 1*/

  -- Leer Datos Generales del Movimiento
  SELECT @Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, @Empresa = Empresa, @MovID = MovID, @Mov = Mov, @FechaEmision = FechaEmision, @Proyecto = NULLIF(RTRIM(Proyecto), ''),
         @MovUsuario = Usuario, @Autorizacion = Autorizacion, 
         /*@MovMoneda = Moneda, @MovTipoCambio = TipoCambio,*/
         @DocFuente = DocFuente, @Observaciones = Observaciones, @Estatus = UPPER(Estatus), 
         /*@GenerarPoliza = GenerarPoliza, */@FechaConclusion = FechaConclusion,
         @Concepto = Concepto, @Referencia = Referencia, 
         @Canal = NULLIF(RTRIM(Canal), '')
    FROM RSS
   WHERE ID = @ID
  IF @@ERROR <> 0 SELECT @Ok = 1

  IF NULLIF(RTRIM(@Usuario), '') IS NULL SELECT @Usuario = @MovUsuario
  -- Leer MovTipo, Periodo y Ejercicio	
  -- IF @Accion IN ('AFECTAR', 'GENERAR') SELECT @FechaAfectacion = @FechaEmision ELSE SELECT @FechaAfectacion = @FechaRegistro
  EXEC spFechaAfectacion @Empresa, @Modulo, @ID, @Accion, @FechaEmision OUTPUT, @FechaRegistro, @FechaAfectacion OUTPUT
  EXEC spExtraerFecha @FechaAfectacion OUTPUT
  EXEC spMovTipo @Modulo, @Mov, @FechaAfectacion, @Empresa, NULL, NULL, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT
  EXEC spMovOk @SincroFinal, @ID, @Estatus, @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @FechaAfectacion, @FechaRegistro, @Ejercicio, @Periodo, @Proyecto, @Ok OUTPUT, @OkRef OUTPUT

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

  IF (@Accion <> 'CANCELAR' AND @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'PENDIENTE')) OR 
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
  
    IF @Accion = 'CANCELAR' 
      SELECT @EstatusNuevo = 'CANCELADO' 
    ELSE 
      SELECT @EstatusNuevo = 'CONCLUIDO' 

    -- Verificar antes de Afectar
    IF (@Conexion = 0 OR @Accion = 'CANCELAR') AND @Accion NOT IN ('GENERAR', 'CONSECUTIVO'/*, 'SINCRO'*/) AND @Ok IS NULL
    BEGIN
      EXEC spRSSVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @Estatus, @EstatusNuevo, 
			  @Canal,
         	          @Conexion, @SincroFinal, @Sucursal, 
     			  @Ok OUTPUT, @OkRef OUTPUT

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
      EXEC spRSSAfectar @ID, @Accion, @Base, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaAfectacion, @FechaConclusion,
			@Proyecto, @Usuario, @Autorizacion, @DocFuente, @Observaciones, @Concepto, @Referencia,               
                        @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario,
                        @Canal,
		        @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @CfgContX, @CfgContXGenerar, @GenerarPoliza,
                        @Generar, @GenerarMov, @GenerarAfectado, @IDGenerar OUTPUT, @GenerarMovID OUTPUT,
                        @Ok OUTPUT, @OkRef OUTPUT

  END ELSE 
  BEGIN
    IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @Accion = 'CANCELAR' EXEC spMovCancelarSinAfectar @Modulo, @ID, @Ok OUTPUT ELSE
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


PRINT "******************* SP RSS ******************"
GO
