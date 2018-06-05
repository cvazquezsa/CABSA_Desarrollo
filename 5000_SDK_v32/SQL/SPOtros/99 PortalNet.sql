SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

/******************************************************************************** AnexoToyota ********************************************************************************/
/**************** spAPIAnexo ****************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('dbo.spAPIAnexo') AND type = 'P') 
	DROP PROCEDURE dbo.spAPIAnexo
GO
CREATE PROCEDURE dbo.spAPIAnexo
	@ID        int,
	@Mov	   varchar(20),
	@finalPath varchar(max)
AS BEGIN
  DECLARE @Ok int, @OkRef varchar(max)

  IF ISNULL(@Mov,'') = 'Toyota'
  BEGIN
	DECLARE 
		@Estatus    varchar(15),
		@MovI       varchar(20),
		@Sucursal   int,
		@usuario	varchar(20),
		@Empresa    varchar(15),
		@NomArch    varchar(255),
		@Ext	    varchar(20),
		@icono		int,
		@i			int,
		@Tipo		varchar(10),
		@FechaEmision datetime

	SELECT	@Empresa = Empresa, 
			@FechaEmision = FechaEmision, 
			@Sucursal = Sucursal, 
			@Empresa = Empresa, 
			@MovI = Mov, 
			@Estatus = Estatus,
			@usuario = usuario
	  FROM	Venta 
	 WHERE	ID = @ID

	 select @NomArch = ''
	 select @i = charindex('\', @finalPath)
	 select @NomArch = @finalPath
	 while (@i > 0)
	 begin
		select @NomArch = substring(@NomArch, @i+1, len(@NomArch))
		select @i = charindex('\', @NomArch)
	 end

	 select @i = charindex('.', @NomArch)
	 select @Ext = @NomArch
	 while (@i > 0)
	 begin
		select @Ext = substring(@Ext, @i+1, len(@Ext))
		select @i = charindex('.', @Ext)
	 end

	 IF (LOWER(@Ext) IN  ('png', 'jpg', 'bmp', 'gif'))
		SELECT @icono = 59, @Tipo = 'Imagen'
	 IF (LOWER(@Ext) IN  ('pdf'))
		SELECT @icono = 745, @Tipo = 'Archivo'
	 IF (LOWER(@Ext) IN  ('doc', 'docx'))
		SELECT @icono = 738, @Tipo = 'Archivo'
	 IF (LOWER(@Ext) IN  ('xls', 'xlsx'))
		SELECT @icono = 733, @Tipo = 'Archivo'

	IF NOT EXISTS(SELECT * FROM AnexoMov WHERE Rama = 'VTAS' AND @Estatus = 'CANCELADO')
	BEGIN
		INSERT AnexoMov (Sucursal,  Rama,    ID,  Nombre,    Direccion,   Tipo,      Icono, Alta,          UltimoCambio, Usuario) 
				VALUES (@Sucursal, 'VTAS',  @ID, @NomArch, @finalPath,   @Tipo, @icono,   @FechaEmision, GETDATE(),   @Usuario)
	END
  END

  SELECT @Ok Ok, @OkRef OkRef
  
RETURN
END
GO


/**************** spPNetInsertaGarantia ****************/
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('dbo.spPNetInsertaGarantia'))
DROP PROCEDURE dbo.spPNetInsertaGarantia
GO
CREATE PROC dbo.spPNetInsertaGarantia
 @Usuario				 varchar(10),
 @Cliente	             varchar(10), 
 @ServicioArticulo		 varchar(20),
 @ServicioSerie			 varchar(50),
 @ServicioTipo		     varchar(50), -- SELECT Tipo FROM ServicioTipo
 @ServicioTipoOperacion	 varchar(50), -- SELECT TipoOperacion FROM ServicioTipoOperacion
 @Comentarios            varchar(max)
AS BEGIN
DECLARE
 /* Datos que va a regresar el SP */
 @Ok                 int,
 @OkRef              varchar(255),
 @ID                 int,
 @Ruta               varchar(max),
 @NombreArch         varchar(max),

 @Empresa            varchar(5),
 @Agente		     varchar(10),
 @Mov                varchar(20),
 @Moneda             varchar(15),  
 @TipoCambio         float,
 @FechaEmision       datetime,
 @Almacen	         varchar(10),
 @Sucursal	         int,
 @DefArticulo        varchar(20),

 @Renglon            float,
 @RenglonSub         int,
 @RenglonID          int,
 @RenglonTipo        varchar(1),
 @Cantidad           float,
 @Tipo               varchar(20),
 @Unidad             varchar(50),
 @Impuesto1          float,
 @Factor             float,
 @PrecioMoneda       varchar(50),
 @PrecioTipoCambio   float,
 @ServicioTipoOrden	 varchar(20), -- SELECT TipoOrden FROM ServicioTipoOrden
 @TipoAlmacen		 varchar(15), 
 @EnGarantia	     bit,
 @ConVigencia        bit,
 @VigenciaDesde      datetime,
 @VigenciaHasta      datetime,
 @ServicioSerieO     varchar(50),
 @Serie				 varchar(20),
 @Folio				 bigint,
 @MovID				 varchar(20)

 /* Obtener valor por omision */
 SELECT @FechaEmision = dbo.fnFechaSinHora(GETDATE())
 SELECT @Moneda = DefMoneda, @Almacen = DefAlmacen, @Mov = DefMovVentas, @Agente = DefAgente FROM Usuario WHERE Usuario = @Usuario
 SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda
 SELECT @Sucursal = SucursalEmpresa, @DefArticulo = ArticuloDef FROM Agente WHERE Agente = @Agente
 SELECT TOP 1 @Empresa = ud.Empresa FROM UsuarioD ud JOIN Empresa e ON ud.Empresa = e.Empresa WHERE ud.Usuario = @Usuario
 SELECT TOP 1 @ServicioTipoOrden = TipoOrden FROM ServicioTipoOrden 
 SELECT @TipoAlmacen = Tipo FROM Alm WHERE Almacen = @Almacen
 /* Validar el tipo de Almacen para saber si está en Garantía o no */
 IF ISNULL(@TipoAlmacen,'') = 'Garantias' SELECT @EnGarantia = 1 ELSE SELECT @EnGarantia = 0
 
 /* Obtener la vigencia del movimiento original de venta del articulo */
 SELECT @ConVigencia = v.ConVigencia, @VigenciaDesde = v.VigenciaDesde, @VigenciaHasta = v.VigenciaHasta, @ServicioSerieO = s.SerieLote
   FROM Venta v JOIN MovTipo mt ON 'VTAS' = mt.Modulo AND v.Mov = mt.Mov 
   JOIN VentaD vd ON v.ID = vd.ID 
   JOIN SerieLoteMov s ON v.Empresa = s.Empresa AND 'VTAS' = s.Modulo AND v.ID = s.ID AND vd.Articulo = s.Articulo
  WHERE v.Empresa = @Empresa AND v.Estatus NOT IN ('SIANFECTAR', 'CANCELADO')
    AND v.Cliente = @Cliente AND mt.Clave = 'VTAS.F' AND vd.Articulo = @ServicioArticulo AND s.SerieLote =  @ServicioSerie

 IF ISNULL(@Empresa, '') = '' OR NOT EXISTS ( SELECT 1 FROM Empresa WHERE Empresa = @Empresa ) 
  SELECT @Ok = 1, @OkRef = 'Empresa Incorrecta'
 /* Validar datos que vienen del usuario */
 ELSE IF ISNULL(@Cliente, '') = '' OR NOT EXISTS ( SELECT 1 FROM Cte WHERE Cliente = @Cliente ) 
  SELECT @Ok = 1, @OkRef = 'Cliente Incorrecto'
 ELSE IF ISNULL(@Usuario, '') = '' OR NOT EXISTS ( SELECT 1 FROM Usuario WHERE Usuario = @Usuario )
  SELECT @Ok = 1, @OkRef = 'Usuario Incorrecto'
 ELSE IF ISNULL(@Agente, '') = '' OR NOT EXISTS ( SELECT 1 FROM Agente WHERE Agente = @Agente )
  SELECT @Ok = 1, @OkRef = 'Falta Configurar el Agente'
 ELSE IF NOT EXISTS ( SELECT 1 FROM AgenteCte WHERE Agente = @Agente AND Cliente =  @Cliente )
  SELECT @Ok = 1, @OkRef = 'El Cliente no corresponde al Agente'
 ELSE IF ISNULL(@ServicioArticulo,'') = '' OR NOT EXISTS ( SELECT 1 FROM Art WHERE Articulo = @ServicioArticulo AND Tipo IN ('Serie', 'VIN') AND Estatus = 'ALTA')
  SELECT @Ok = 1, @OkRef = 'Artículo de Servicio Incorrecto'
 ELSE IF ISNULL(@ServicioSerie,'') = '' OR NOT EXISTS ( SELECT 1 FROM VIN WHERE VIN = @ServicioSerie AND Articulo = @ServicioArticulo ) OR NOT EXISTS
 ( SELECT 1 FROM SerieLote WHERE Articulo = @ServicioArticulo AND SerieLote = @ServicioSerie ) 
  SELECT @Ok = 1, @OkRef = '# Serie/VIN Incorrecto' 
 /* Validar si el movimiento original de venta tenía vigencia */
 ELSE IF ISNULL(@ServicioSerieO,'') <> ISNULL(@ServicioSerie,'')
  SELECT @Ok = 1, @OkRef = 'La Serie/VIN no pertenece al Cliente'
 ELSE IF ISNULL(@ConVigencia,0) = 1
 BEGIN
  IF @FechaEmision < @VigenciaDesde OR @FechaEmision > @VigenciaHasta 
   SELECT @Ok = 1, @OkRef = 'La Vigencia de la Garantía ha expirado'
 END
 ELSE IF ISNULL(@ConVigencia, 0) = 0
  SELECT @Ok = 1, @OkRef = 'No se encuentra con Garantía'
 ELSE IF NOT EXISTS ( SELECT 1 FROM ServicioTipo WHERE Tipo = ISNULL(@ServicioTipo,'') )
  SELECT @Ok = 1, @OkRef = 'Tipo Servicio Incorrecto' 
 ELSE IF NOT EXISTS ( SELECT 1 FROM ServicioTipoOperacion WHERE TipoOperacion = ISNULL(@ServicioTipoOperacion,'') )
  SELECT @Ok = 1, @OkRef = 'Tipo Operación Incorrecta'
 /* Validar datos que vienen de la configuración */
 ELSE IF ISNULL(@Moneda,'') = '' OR NOT EXISTS ( SELECT 1 FROM Mon WHERE Moneda = @Moneda )
  SELECT @Ok = 1, @OkRef = 'Moneda Incorrecta'
 ELSE IF ISNULL(@Almacen,'') = '' OR NOT EXISTS ( SELECT 1 FROM Alm WHERE Almacen = @Almacen )
  SELECT @Ok = 1, @OkRef = 'Almacén Incorrecto'
 ELSE IF ISNULL(@Mov,'') = ''  OR NOT EXISTS ( SELECT 1 FROM MovTipo WHERE Modulo = 'VTAS' AND Mov = @Mov )
  SELECT @Ok = 1, @OkRef = 'Falta Configurar el Movimiento'
 ELSE IF ISNULL(@Sucursal,-1) = -1 OR NOT EXISTS ( SELECT 1 FROM Sucursal WHERE Sucursal = @Sucursal )
  SELECT @Ok = 1, @OkRef = 'Falta Configurar la Sucursal'
 ELSE IF ISNULL(@DefArticulo,'') = '' OR NOT EXISTS ( SELECT 1 FROM Art WHERE Articulo = @DefArticulo )
  SELECT @Ok = 1, @OkRef = 'Falta Configurar el Artículo'
 ELSE IF ISNULL(@Empresa, '') = ''
  SELECT @Ok = 1, @OkRef = 'Falta Especificar la Empresa'

 IF @Ok IS NULL
  BEGIN
	 /* Insertar el encabezado */
	 INSERT INTO Venta(Empresa, Sucursal, Mov, FechaEmision, Moneda, TipoCambio, Usuario, Estatus, Cliente,
		Almacen, Agente, ServicioTipo, ServicioArticulo, ServicioSerie, ServicioTipoOrden, ServicioTipoOperacion, Comentarios, ServicioGarantia,
		ConVigencia, VigenciaDesde, VigenciaHasta)
	  SELECT @Empresa, @Sucursal, @Mov, @FechaEmision, @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR', @Cliente,
		@Almacen, @Agente, @ServicioTipo, @ServicioArticulo, @ServicioSerie, @ServicioTipoOrden, @ServicioTipoOperacion, @Comentarios, @EnGarantia,
		@ConVigencia, @VigenciaDesde, @VigenciaHasta
 
	  SELECT @ID = SCOPE_IDENTITY(), @Renglon = 2048, @RenglonSub = 0, @Cantidad = 1, @RenglonID = 1
	  SELECT @Tipo = Tipo, @Unidad = Unidad, @Impuesto1 = Impuesto1, @PrecioMoneda = MonedaPrecio FROM Art WHERE Articulo = @DefArticulo
	  SELECT @Factor = Factor FROM Unidad WHERE Unidad = @Unidad
	  SELECT @PrecioTipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda
	  EXEC spRenglonTipo @Tipo, NULL, @RenglonTipo OUTPUT

	  IF ISNULL(@DefArticulo,'') = '' OR NOT EXISTS ( SELECT 1 FROM Art WHERE Articulo = @DefArticulo)
	   SELECT @Ok = 1, @OkRef = 'Artículo por Omisión Incorrecto'

	  IF @Ok IS NULL
	   BEGIN
		 /* Insertar el detalle */
		 INSERT INTO VentaD(ID, Renglon, RenglonSub, RenglonID, RenglonTipo, Cantidad, Almacen, Articulo, Impuesto1, 
			Precio, Unidad, Factor, CantidadInventario, Agente, PrecioMoneda, PrecioTipoCambio)
		   SELECT @ID, @Renglon, @RenglonSub, @RenglonID, @RenglonTipo, @Cantidad, @Almacen, @DefArticulo, @Impuesto1, 
			0.0, @Unidad, @Factor, @Factor*@Cantidad, @Agente, @PrecioMoneda, @PrecioTipoCambio

		 /* Afectar el movimiento */
		 EXEC spAfectar 'VTAS', @ID, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion=@@SPID, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

  	     /* Obtener la ruta para guardar los anexos */
		 --IF @Ok IS NULL 
		 --  EXEC spPNetAnexoArchivo 'VTAS', @ID, @Mov, @Cliente, @Sucursal, @Empresa, @FechaEmision, @Usuario, @Ruta = @Ruta OUTPUT, @NomArch = @NombreArch OUTPUT
       END
  END

  SELECT @Mov = Mov, @Cliente = Cliente, @MovID = MovID FROM Venta WHERE ID = @ID

  SELECT @Ruta = DirectorioAnexosEsp 
    FROM EmpresaGral WHERE Empresa = @Empresa
	
  EXEC spMovIDEnSerieConsecutivo @MovID, @Serie OUTPUT, @Folio OUTPUT

  SELECT @Ruta = REPLACE(@Ruta, '<Cliente>', @Cliente)
  SELECT @Ruta = REPLACE(@Ruta, '<Ejercicio>', CONVERT(varchar, YEAR(GETDATE())))
  SELECT @Ruta = REPLACE(@Ruta, '<Periodo>', CONVERT(varchar, MONTH(GETDATE())))

  SELECT @Ok Ok, @OkRef OkRef, @ID ID, @Ruta Ruta

RETURN 
END 
GO

/**************** spPNetConsultaGarantia ****************/
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('dbo.spPNetConsultaGarantia'))
DROP PROCEDURE dbo.spPNetConsultaGarantia
GO
CREATE PROC dbo.spPNetConsultaGarantia
 @Usuario   varchar(10)
AS BEGIN
DECLARE
 @DefAgente varchar(10)

SELECT @DefAgente = DefAgente FROM Usuario WHERE Usuario = @Usuario

SELECT v.ID, c.Nombre, LTRIM(RTRIM(ISNULL(v.Mov,'')))+ ' '+LTRIM(RTRIM(ISNULL(v.MovID,''))) as 'Movimiento',
 CONVERT(VARCHAR(10),v.FechaEmision,110) as 'FechaEmision', a.Descripcion1 Articulo, v.ServicioSerie, v.ServicioTipo,
 CONVERT(VARCHAR(10),v.VigenciaDesde,110) as 'VigenciaDesde', CONVERT(VARCHAR(10),v.VigenciaHasta,110) as 'VigenciaHasta', v.Situacion, v.SituacionNota, CONVERT(VARCHAR(10),v.ServicioFecha,110) as 'ServicioFecha' 
  FROM Venta v JOIN Cte c ON v.Cliente = c.Cliente
  JOIN MovTipo mt ON 'VTAS' = mt.Modulo AND v.Mov = mt.Mov
  JOIN Art a ON a.Articulo = v.ServicioArticulo
 WHERE v.Estatus <> 'CANCELADO'
   AND mt.Clave = 'VTAS.S' AND v.Agente = @DefAgente

RETURN
END
GO

/************** spPNetConsultaGarantiaD **************/
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('dbo.spPNetConsultaGarantiaD'))
DROP PROCEDURE dbo.spPNetConsultaGarantiaD
GO
CREATE PROC dbo.spPNetConsultaGarantiaD
 @ID     int
AS BEGIN
 SELECT a.Descripcion1, vd.Cantidad, vd.Unidad, vd.Precio, vd.DescuentoLinea, vd.DescuentoImporte, 
    vc.Impuesto1Total - vc.Retencion1Total as Impuestos, 
	vc.TotalNeto Importe
   FROM VentaD vd JOIN VentaTCalc vc ON vd.ID = vc.ID AND vd.Renglon = vc.Renglon
    JOIN Art a ON vd.Articulo = a.Articulo
  WHERE vd.ID = @ID

RETURN
END
GO
/******************************************************************************** Reportes ********************************************************************************/
/************************************************spGenerarEstadoCuenta************************************************/
IF exists (SELECT * FROM sysobjects WHERE id = object_id('spGenerarEstadoCuenta') and type = 'P') 
	drop procedure spGenerarEstadoCuenta
GO   
CREATE PROCEDURE spGenerarEstadoCuenta
	 @Estacion				int,
	 @Empresa				char(5),
	 @Modulo				char(5),
	 @FechaD				datetime,
	 @Cuenta				char(10),
	 @Sucursal				int,
	 @EstatusEspecifico		char(15) = NULL,
	 @FechaA				datetime = NULL 
AS BEGIN 
  EXEC spExtraerFecha @FechaD OUTPUT
  IF @Cuenta = '0' SELECT @Cuenta = NULL
  IF @Sucursal = -1 SELECT @Sucursal = NULL
  SELECT @EstatusEspecifico = NULLIF(RTRIM(@EstatusEspecifico), '')
  IF @EstatusEspecifico = '0' SELECT @EstatusEspecifico = NULL

  DELETE EstadoCuenta WHERE Estacion = @Estacion AND Modulo = @Modulo
  IF @Modulo = 'CXC' 
  BEGIN
    INSERT EstadoCuenta (Estacion, Modulo, Cuenta, Efectivo, Consumos, Vales, Redondeo, Moneda) 
    SELECT @Estacion, @Modulo, c.Cliente, SUM(Efectivo), SUM(Consumos), SUM(Vales), SUM(Redondeo), c.Moneda
      FROM CxcCuentaCorriente c, Cte
     WHERE c.Empresa = @Empresa 
       AND c.Cliente = ISNULL(@Cuenta, c.Cliente)
       AND cte.Cliente = c.Cliente
       --AND ISNULL(cte.SucursalEmpresa, -1) = ISNULL(ISNULL(@Sucursal, cte.SucursalEmpresa), -1)
     GROUP BY c.Cliente, c.Moneda

    INSERT EstadoCuenta (Estacion, Modulo, Cuenta, Moneda, AuxiliarID, ModuloID) 
    SELECT @Estacion, @Modulo, a.Cuenta, a.Moneda, a.ID, a.ModuloID
      FROM Auxiliar a, Cxc c, Cxc ca, MovTipo mt, Cte
     WHERE a.Empresa  = @Empresa AND a.Rama = @Modulo
       AND a.Aplica   = ca.Mov
       AND a.AplicaID = ca.MovID
       AND a.ModuloID = c.ID AND a.Modulo = 'CXC'
       AND c.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
       AND c.Empresa  = a.Empresa
--       AND c.Cliente = ISNULL(@Cuenta, c.Cliente)
       AND a.Cuenta = ISNULL(@Cuenta, a.Cuenta)
       AND c.Cliente = cte.Cliente
       --AND ISNULL(cte.SucursalEmpresa, -1) = ISNULL(ISNULL(@Sucursal, cte.SucursalEmpresa), -1)
       AND ca.Empresa = c.Empresa
       AND ca.Mov = mt.Mov AND mt.Clave IN ('CXC.A', 'CXC.AR', 'CXC.F', 'CXC.FAC', 'CXC.FA', 'CXC.D', 'CXC.DM', 'CXC.DA', 'CXC.DP', 'CXC.NC', 'CXC.DAC', 'CXC.NCD','CXC.NCF', 'CXC.DV', 'CXC.NCP', 'CXC.CA', 'CXC.CAD', 'CXC.CAP','CXC.CD', 'CXC.RM', 'CXC.IM', 'CXC.SD', 'CXC.SCH') 
	   --OR (mt.Clave IN ('CXC.SD', 'CXC.SCH') AND ca.Estatus = 'PENDIENTE')
       AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaD AND ca.FechaConclusion <= ISNULL(@FechaA,ca.FechaConclusion)))
       AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END
     ORDER BY a.Moneda, a.Cuenta, a.Aplica, a.AplicaID, a.ID

    INSERT EstadoCuenta (Estacion, Modulo, Cuenta, Moneda, AuxiliarID, ModuloID) 
    SELECT @Estacion, @Modulo, a.Cuenta, a.Moneda, a.ID, a.ModuloID
      FROM Auxiliar a, Dinero c, Dinero ca, MovTipo mt, Cte
     WHERE a.Empresa  = @Empresa AND a.Rama = @Modulo
       AND a.Aplica   = ca.Mov
       AND a.AplicaID = ca.MovID
       AND a.ModuloID = c.ID AND a.Modulo = 'DIN'
       AND c.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
       AND c.Empresa  = a.Empresa
       AND a.Cuenta = ISNULL(@Cuenta, a.Cuenta)
       AND a.Cuenta = cte.Cliente
       --AND ISNULL(cte.SucursalEmpresa, -1) = ISNULL(ISNULL(@Sucursal, cte.SucursalEmpresa), -1)
       AND ca.Empresa = c.Empresa
       AND ca.Mov = mt.Mov AND mt.Clave IN ('DIN.SD','DIN.D','DIN.CH','DIN.SCH') 
       AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaD AND ca.FechaConclusion <= ISNULL(@FechaA,ca.FechaConclusion)))
       AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END
     ORDER BY a.Moneda, a.Cuenta, a.Aplica, a.AplicaID, a.ID     
  END ELSE
  IF @Modulo = 'CXP'
  BEGIN
    INSERT EstadoCuenta (Estacion, Modulo, Cuenta, Efectivo, Vales, Redondeo, Moneda) 
    SELECT @Estacion, @Modulo, Proveedor, SUM(Efectivo), SUM(Vales), SUM(Redondeo), Moneda
      FROM CxpCuentaCorriente
     WHERE Empresa = @Empresa AND Proveedor = CASE WHEN @Cuenta IS NULL THEN Proveedor ELSE @Cuenta END
     GROUP BY Proveedor, Moneda

    INSERT EstadoCuenta (Estacion, Modulo, Cuenta, Moneda, AuxiliarID, ModuloID) 
    SELECT @Estacion, @Modulo, a.Cuenta, a.Moneda, a.ID, a.ModuloID
      FROM Auxiliar a, Cxp c, Cxp ca, MovTipo mt
     WHERE a.Empresa  = @Empresa AND Rama = @Modulo
       AND a.Aplica   = ca.Mov
       AND a.AplicaID = ca.MovID
       AND a.ModuloID = c.ID AND a.Modulo = 'CXP'
       AND c.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
       AND c.Empresa  = a.Empresa
       AND ca.Empresa = c.Empresa
       AND ca.Proveedor = CASE WHEN @Cuenta IS NULL THEN ca.Proveedor ELSE @Cuenta END
       AND ca.Mov = mt.Mov AND mt.Clave IN ('CXP.A', 'CXP.F', 'CXP.D', 'CXP.DM', 'CXP.PAG', 'CXP.DA', 'CXP.DP', 'CXP.NC', 'CXP.DAC', 'CXP.NCD','CXP.NCF', 'CXP.NCP', 'CXP.CA', 'CXP.CAD', 'CXP.CAP','CXP.CD', 'CXP.FAC', 'CXP.SD', 'CXP.SCH') 
	   --OR (mt.Clave IN ('CXP.SD', 'CXP.SCH') AND ca.Estatus = 'PENDIENTE')
       AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaD AND ca.FechaConclusion <= ISNULL(@FechaA,ca.FechaConclusion)))
       AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END
     ORDER BY a.Moneda, a.Cuenta, a.Aplica, a.AplicaID, a.ID

    INSERT EstadoCuenta (Estacion, Modulo, Cuenta, Moneda, AuxiliarID, ModuloID) 
    SELECT @Estacion, @Modulo, a.Cuenta, a.Moneda, a.ID, a.ModuloID
      FROM Auxiliar a, Dinero c, Dinero ca, MovTipo mt, Prov
     WHERE a.Empresa  = @Empresa AND a.Rama = @Modulo
       AND a.Aplica   = ca.Mov
       AND a.AplicaID = ca.MovID
       AND a.ModuloID = c.ID AND a.Modulo = 'DIN'
       AND c.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
       AND c.Empresa  = a.Empresa
       AND a.Cuenta = ISNULL(@Cuenta, a.Cuenta)
       AND a.Cuenta = Prov.Proveedor
       --AND ISNULL(cte.SucursalEmpresa, -1) = ISNULL(ISNULL(@Sucursal, cte.SucursalEmpresa), -1)
       AND ca.Empresa = c.Empresa
       AND ca.Mov = mt.Mov AND mt.Clave IN ('DIN.SD','DIN.D','DIN.CH','DIN.SCH') 
       AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaD AND ca.FechaConclusion <= ISNULL(@FechaA,ca.FechaConclusion)))
       AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END
     ORDER BY a.Moneda, a.Cuenta, a.Aplica, a.AplicaID, a.ID   
   END
END
GO
/********spNetProvEdoCtaInfoGeneral*************/
IF exists (SELECT * FROM sysobjects WHERE id = object_id('spNetProvEdoCtaInfoGeneral') and type = 'P') 
	drop procedure spNetProvEdoCtaInfoGeneral
GO   
CREATE PROCEDURE spNetProvEdoCtaInfoGeneral
	@Desde			varchar(100),
	@Hasta			varchar(100),
	@Proveedor		varchar(10),
	@Empresa		varchar(50)
AS
BEGIN
DECLARE 
 @DesdeD		datetime,
 @HastaD		datetime

 SET @DesdeD =  Convert(datetime,@Desde,120)
 SET @HastaD =  Convert(datetime,@Hasta,120)
		  
 EXEC spGenerarEstadoCuenta @@SPID, @Empresa, 'CXP', @DesdeD, @Proveedor, -1, NULL, @HastaD
	
  SELECT ISNULL(P.Nombre,'') [ProveedorD], 
		 ISNULL(A.Agente,'') [AgenteVentas], 
		 ISNULL(P.Condicion,'') [CondicionPago], 
		 ISNULL(P.DefMoneda,'') [Moneda], 
		 (X.Saldo * M.TipoCambio) [SaldoTotal]
	FROM EstadoCuenta EC
	JOIN Prov P ON P.Proveedor = EC.Cuenta
	LEFT JOIN Auxiliar AU ON EC.AuxiliarID = Au.ID
	LEFT JOIN CxpSaldo X ON X.Proveedor = p.Proveedor
	LEFT JOIN Mon M ON M.Moneda = X.Moneda AND M.Moneda = P.DefMoneda
	LEFT JOIN Agente A ON A.Agente = p.Agente
	WHERE P.Proveedor = @Proveedor
		AND EC.Modulo='CXP'
		AND AU.FECHA BETWEEN @DesdeD AND @HastaD
	GROUP BY P.Nombre, A.Agente, p.Condicion, p.DefMoneda, X.Saldo, M.TipoCambio		        

RETURN
END
GO

/****** spPUVerSaldoInicialM ******/				
if exists (select * from sysobjects where id = object_id('dbo.spPUVerSaldoInicialM') and type = 'P') drop procedure dbo.spPUVerSaldoInicialM
GO
CREATE PROCEDURE dbo.spPUVerSaldoInicialM
 @Empresa		char(5),
 @Rama			char(5),
 @Moneda		char(10),
 @Cuenta		char(20),
 @FechaInicial	datetime,
 @SubCuenta		varchar(50) = NULL,
 @Costo			money OUTPUT
AS BEGIN
DECLARE
 @Ejercicio	  	int,
 @Periodo	  	int,
 @EsMonetario	bit,
 @EsUnidades	bit,
 @EsResultados	bit,
 @CargoInicial 	money,
 @AbonoInicial 	money,
 @CargoInicialU float,
 @AbonoInicialU float,
 @Ok		  	int

SELECT @SubCuenta = NULLIF(RTRIM(@SubCuenta), '')
SELECT @SubCuenta = NULLIF(@SubCuenta, '0')

SELECT @EsMonetario = EsMonetario, @EsUnidades = EsUnidades, @EsResultados = EsResultados
 FROM Rama
WHERE Rama = @Rama

 EXEC spPeriodoEjercicio @Empresa, @Rama, @FechaInicial, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT
 EXEC spSaldoInicial @Empresa, @Rama, @Moneda, NULL, @Cuenta, @SubCuenta, @FechaInicial, @EsMonetario, @EsUnidades, @EsResultados, @CargoInicial OUTPUT, @AbonoInicial OUTPUT, @CargoInicialU OUTPUT, @AbonoInicialU OUTPUT, @Ok OUTPUT

SELECT @Costo = CONVERT(money, ISNULL(@CargoInicial, 0.0) - ISNULL(@AbonoInicial, 0.0))
END
GO

/****** spEspEstadoCuenta ******/				
if exists (select * from sysobjects where id = object_id('dbo.spEspEstadoCuenta') and type = 'P') drop procedure dbo.spEspEstadoCuenta
GO
CREATE PROC spEspEstadoCuenta
 @Estacion	int,  
 @Empresa	char(5),  
 @ClienteD	char(10),  
 @ClienteA	char(10),  
 @FechaD	datetime,  
 @FechaA	datetime,  
 @Moneda	char(10),  
 @SinMovAplicacion  bit = 0  
-- WITH ENCRYPTION  
/*  
Fast Forward Panama  
Version 7  
Fecha: 2007-11-28  
JNAVARRETE  
*/  
AS BEGIN  
DECLARE  
  @Plazo1 int,  
  @Plazo2 int,  
  @Plazo3 int,  
  @Plazo4 int,  
  @ID  int,  
  @SaldoMovil money,  
  @Cargo money,  
  @Abono money,  
  @Cliente char(10),  
  @ClienteAnterior char(10),  
  @cr_Moneda char(10),  
  @cr_MonedaAnterior char(10)  
  
-- Inicializar variables  
SELECT @Moneda=NULLIF(@Moneda,'Null')  
SELECT @Moneda=NULLIF(@Moneda,'')  
SELECT @Plazo1=CxcPlazo1, @Plazo2=CxcPlazo2, @Plazo3=CxcPlazo3, @Plazo4=CxcPlazo4 FROM EmpresaCfg WHERE Empresa=@Empresa  
  
-- antiguedad de saldos  
--EXEC spVerAuxCorte @Estacion, @Empresa, 'CXC', '12/30/1899 00:00:00', @FechaA, @ClienteD, @ClienteA  
EXEC spVerAuxCorte @Estacion, @Empresa, 'CXC', '18991230', @FechaA, @ClienteD, @ClienteA 
  
DELETE espCxcEstadoCuentaAntiguedad WHERE Estacion=@Estacion  
INSERT INTO espCxcEstadoCuentaAntiguedad  
SELECT   
  @Estacion, v.Moneda, v.Cuenta, v.Mov, v.MovID, v.ModuloID, v.Saldo, Cxc.Vencimiento, m.Clave,  
  'Dias'=CASE WHEN m.Clave IN   
    ('CXC.F','CXC.FA','CXC.AF','CXC.CA','CXC.CAD','CXC.CAP','CXC.VV','CXC.CD','CXC.D','CXC.DM','CXC.DA','CXC.DP','CXC.NCP','CXC.FAC','CXC.DAC')  
    THEN DATEDIFF(dd,Cxc.Vencimiento,@FechaA) ELSE NULL END,  
  NULL, NULL, NULL, NULL, NULL, NULL, NULL  
FROM   
  VerAuxCorte v   
  LEFT OUTER JOIN Cxc ON v.ModuloID=Cxc.ID   
  LEFT OUTER JOIN MovTipo m ON v.Mov=m.Mov AND m.Modulo='CXC'  
WHERE v.Estacion=@Estacion AND v.Empresa=@Empresa  
  
UPDATE espCxcEstadoCuentaAntiguedad SET   
  Posfechado=CASE WHEN MovTipo='CXC.NCP' THEN Saldo ELSE NULL END,  
  AlCorriente=CASE WHEN ISNULL(Dias,0)<=0 THEN Saldo ELSE NULL END,  
  Plazo1=CASE WHEN @Plazo1>0 AND ISNULL(Dias,0)>0 AND ISNULL(Dias,0)<=@Plazo1 THEN Saldo ELSE NULL END,  
  Plazo2=CASE WHEN @Plazo2>0 AND ISNULL(Dias,0)>@Plazo1 AND ISNULL(Dias,0)<=@Plazo2 THEN Saldo ELSE NULL END,  
  Plazo3=CASE WHEN @Plazo3>0 AND ISNULL(Dias,0)>@Plazo2 AND ISNULL(Dias,0)<=@Plazo3 THEN Saldo ELSE NULL END,  
  Plazo4=CASE WHEN @Plazo4>0 AND ISNULL(Dias,0)>@Plazo3 AND ISNULL(Dias,0)<=@Plazo4 THEN Saldo ELSE NULL END,  
  PlazoMayor=CASE WHEN ISNULL(Dias,0)>@Plazo4 THEN Saldo ELSE NULL END  
WHERE Estacion=@Estacion  
  
-----------------------------------------------------------------------------------------------------------------   
-- Tabla con claves de clientes (Para asegurar que se muestren sus datos sin tener movimientos)  
DELETE espCxcEstadoCuentaClaveClientes WHERE Estacion=@Estacion  
  
-- Cargo claves de clientes  
INSERT INTO espCxcEstadoCuentaClaveClientes  
SELECT @Estacion,   
  Cte.Cliente,  
 Mon.Moneda  
FROM Cte CROSS JOIN Mon  
WHERE Cte.Cliente BETWEEN @ClienteD AND @ClienteA AND  
 Mon.Moneda=ISNULL(@Moneda,Mon.Moneda) AND  
 Cte.TieneMovimientos=1  
  
-----------------------------------------------------------------------------------------------------------------  
-- Tabla con llaves de movimientos  
DELETE espCxcEstadoCuentaAux WHERE Estacion=@Estacion  
  
-- Inserción de llaves de movimientos  
INSERT INTO espCxcEstadoCuentaAux  
SELECT   
  @Estacion,  
  Auxiliar.ID,  
  Auxiliar.Moneda,  
  Auxiliar.Cuenta,  
  Auxiliar.ModuloID,  
  Auxiliar.Mov,  
  Auxiliar.MovID,  
  Auxiliar.Fecha,  
  Auxiliar.Cargo,  
  Auxiliar.Abono,  
  Auxiliar.TipoCambio,  
  'Dias'=CASE WHEN MovTipo.Clave IN   
    ('CXC.F','CXC.FA','CXC.AF','CXC.CA','CXC.CAD','CXC.CAP','CXC.VV','CXC.CD','CXC.D','CXC.DM','CXC.DA','CXC.DP','CXC.NCP','CXC.FAC','CXC.DAC')  
    THEN DATEDIFF(dd,Cxc.Vencimiento,@FechaA) ELSE NULL END,  
  Aplica.ID,  
  Aplica.Mov,  
  Aplica.MovID  
FROM  
  espCxcEstadoCuentaClaveClientes  
  JOIN Auxiliar  ON espCxcEstadoCuentaClaveClientes.Cliente=Auxiliar.Cuenta  
    AND espCxcEstadoCuentaClaveClientes.Moneda=Auxiliar.Moneda  
  JOIN Cxc   ON  Auxiliar.ModuloID=Cxc.ID   
    AND Auxiliar.Modulo='CXC'  
  JOIN Cxc Aplica  ON  Auxiliar.Aplica=Aplica.Mov   
    AND Auxiliar.AplicaID=Aplica.MovID   
    AND Auxiliar.Empresa=Aplica.Empresa   
    AND Auxiliar.Cuenta=Aplica.Cliente  
  JOIN MovTipo mtAplica ON Auxiliar.Aplica=mtAplica.Mov  
    AND mtAplica.Modulo='CXC'  
  JOIN MovTipo  ON Auxiliar.Mov=MovTipo.Mov  
    AND MovTipo.Modulo='CXC'  
WHERE   
  espCxcEstadoCuentaClaveClientes.Estacion=@Estacion AND  
  Aplica.Estatus NOT IN ('SINAFECTAR', 'CANCELADO') AND  
  Auxiliar.Moneda=ISNULL(@Moneda,Auxiliar.Moneda) AND  
  mtAplica.Clave IN ('CXC.A', 'CXC.F', 'CXC.FA', 'CXC.D', 'CXC.DA', 'CXC.DP', 'CXC.NC', 'CXC.NCD', 'CXC.DV', 'CXC.NCP', 'CXC.CA', 'CXC.CAD',   
    'CXC.CAP','CXC.CD', 'CXC.FAC', 'CXC.RM', 'CXC.IM', 'CXC.AR', 'CXC.DM', 'CXC.DAC', 'CXC.NCF') AND  
  Auxiliar.Fecha BETWEEN @FechaD AND @FechaA AND  
  Auxiliar.EsCancelacion = 0 AND  
  Cxc.Estatus NOT IN ('SINAFECTAR', 'CANCELADO') AND  
  Auxiliar.Empresa=@Empresa  
  
----- Borrar Movimiento Aplicacion v6  
IF @SinMovAplicacion=1  
BEGIN  
  DELETE espCxcEstadoCuentaAux   
  FROM espCxcEstadoCuentaAux JOIN MovTipo ON espCxcEstadoCuentaAux.Mov=MovTipo.Mov AND MovTipo.Modulo='CXC'  
  WHERE MovTipo.Clave IN ('CXC.ANC') AND Estacion=@Estacion  
END  
  
-----------------------------------------------------------------------------------------------------------------   
-- Tabla antiguedad de saldos  
DELETE espCxcEstadoCuentaSaldos WHERE Estacion=@Estacion  
  
-- Cursor con lista de clientes  
DECLARE curTempCtes CURSOR LOCAL FOR   
  SELECT Cliente, Moneda FROM espCxcEstadoCuentaClaveClientes WHERE Estacion=@Estacion  
  
-- Para almacenar variables del cursor  
DECLARE @C_Cte  char(10),  
 @C_Mon  char(10),  
 @SInicial money,  
 @SFinal  money,  
 @Posfechado money,  
 @AlCorriente money,  
 @Rango1  money,  
 @Rango2  money,  
 @Rango3  money,  
 @Rango4  money,  
 @RangoMayor money,  
 @CargosA money,  
 @AbonosA money,  
 @FechaAMasUno datetime  
  
SELECT @FechaAMasUno=DATEADD(dd,1,@FechaA)  
  
-- Abro cursor  
OPEN curTempCtes  
FETCH NEXT FROM curTempCtes INTO @C_Cte, @C_Mon  
WHILE @@FETCH_STATUS<>-1  
BEGIN  
IF @@FETCH_STATUS<>-2  
BEGIN  
 -- Saldo Inicial  
 EXEC dbo.spPUVerSaldoInicialM @Empresa, 'CXC', @C_Mon, @C_Cte, @FechaD, NULL, @SInicial OUTPUT  
 SELECT @SInicial=ISNULL(@SInicial, 0)  
  
 -- Saldo Final  
 EXEC dbo.spPUVerSaldoInicialM @Empresa, 'CXC', @C_Mon, @C_Cte, @FechaAMasUno, NULL, @SFinal OUTPUT  
 SELECT @SFinal=ISNULL(@SFinal, 0)  
  
 -- Antiguedad  
 SELECT   
   @Posfechado=SUM(ISNULL(Posfechado,0)),  
   @AlCorriente=SUM(ISNULL(AlCorriente,0)),  
   @Rango1=SUM(ISNULL(Plazo1,0)),  
   @Rango2=SUM(ISNULL(Plazo2,0)),  
   @Rango3=SUM(ISNULL(Plazo3,0)),  
   @Rango4=SUM(ISNULL(Plazo4,0)),  
   @RangoMayor=SUM(ISNULL(PlazoMayor,0))  
 FROM espCxcEstadoCuentaAntiguedad  
 WHERE Estacion=@Estacion AND Moneda=@C_Mon AND Cuenta=@C_Cte  
  
 -- Cargos y abonos correspondientes solo al periodo seleccionado  
 SELECT @CargosA=SUM(ISNULL(Cargo,0)) FROM espCxcEstadoCuentaAux WHERE Estacion=@Estacion AND Cliente=@C_Cte AND Moneda=@C_Mon  
 SELECT @AbonosA=SUM(ISNULL(Abono,0)) FROM espCxcEstadoCuentaAux WHERE Estacion=@Estacion AND Cliente=@C_Cte AND Moneda=@C_Mon  
  
 -- Ingreso información  
 INSERT INTO espCxcEstadoCuentaSaldos  
 VALUES (@Estacion, @C_Cte, @C_Mon, @SInicial, @SFinal, @Posfechado, @AlCorriente, @Rango1, @Rango2, @Rango3, @Rango4, @RangoMayor, @CargosA, @AbonosA)  
  
END  
FETCH NEXT FROM curTempCtes INTO @C_Cte, @C_Mon  
END  
CLOSE curTempCtes  
DEALLOCATE curTempCtes  
  
-----------------------------------------------------------------------------------------------------------------  
-- Select de Retorno  
DELETE espCxcEstadoCuenta WHERE Estacion=@Estacion  
INSERT INTO espCxcEstadoCuenta (Estacion, Cliente, EnviarA, Moneda, AuxiliarID, IDMov, Mov, MovID, FechaEmision, Cargo, Abono, TipoCambio, Vencimiento, Dias,  
  IDAplica, Aplica, AplicaID, FechaAplica, SaldoInicial, SaldoFinal, Posfechado, AlCorriente, Rango1, Rango2, Rango3, Rango4, RangoMayor, CargoA, AbonosA)  
SELECT  
 @Estacion,  
 espCxcEstadoCuentaClaveClientes.Cliente,  
 Cxc.ClienteEnviarA,  
 espCxcEstadoCuentaClaveClientes.Moneda,  
 espCxcEstadoCuentaAux.AuxiliarID,  
 espCxcEstadoCuentaAux.IDMov,  
 espCxcEstadoCuentaAux.Mov,  
 espCxcEstadoCuentaAux.MovID,  
 espCxcEstadoCuentaAux.FechaEmision,  
 espCxcEstadoCuentaAux.Cargo,  
 espCxcEstadoCuentaAux.Abono,  
 espCxcEstadoCuentaAux.TipoCambio,  
   'Vencimiento'=CASE WHEN MovTipo.Clave IN   
     ('CXC.F','CXC.FA','CXC.AF','CXC.CA','CXC.CAD','CXC.CAP','CXC.VV','CXC.CD','CXC.D','CXC.DM','CXC.DA','CXC.DP','CXC.NCP','CXC.FAC','CXC.DAC')  
     THEN Cxc.Vencimiento ELSE NULL END,  
 espCxcEstadoCuentaAux.Dias,  
 espCxcEstadoCuentaAux.IDAplica,  
 espCxcEstadoCuentaAux.Aplica,  
 espCxcEstadoCuentaAux.AplicaID,  
 'FechaAplica'=Aplica.FechaEmision,  
 espCxcEstadoCuentaSaldos.Inicial,  
 espCxcEstadoCuentaSaldos.Final,  
 espCxcEstadoCuentaSaldos.Posfechado,  
 espCxcEstadoCuentaSaldos.AlCorriente,  
 espCxcEstadoCuentaSaldos.Rango1,  
 espCxcEstadoCuentaSaldos.Rango2,  
 espCxcEstadoCuentaSaldos.Rango3,  
 espCxcEstadoCuentaSaldos.Rango4,  
 espCxcEstadoCuentaSaldos.RangoMayor,  
 espCxcEstadoCuentaSaldos.CargosA,  
 espCxcEstadoCuentaSaldos.AbonosA  
FROM  
espCxcEstadoCuentaClaveClientes  
LEFT OUTER JOIN espCxcEstadoCuentaAux ON   
 espCxcEstadoCuentaClaveClientes.Estacion=espCxcEstadoCuentaAux.Estacion   
 AND espCxcEstadoCuentaClaveClientes.Cliente=espCxcEstadoCuentaAux.Cliente   
 AND espCxcEstadoCuentaClaveClientes.Moneda=espCxcEstadoCuentaAux.Moneda  
LEFT OUTER JOIN Cxc Aplica ON espCxcEstadoCuentaAux.IDAplica=Aplica.ID  
LEFT OUTER JOIN Cxc  ON espCxcEstadoCuentaAux.IDMov=Cxc.ID  
JOIN espCxcEstadoCuentaSaldos ON   
 espCxcEstadoCuentaClaveClientes.Estacion=espCxcEstadoCuentaSaldos.Estacion AND  
 espCxcEstadoCuentaClaveClientes.Cliente=espCxcEstadoCuentaSaldos.Cliente AND   
 espCxcEstadoCuentaClaveClientes.Moneda=espCxcEstadoCuentaSaldos.Moneda  
LEFT OUTER JOIN MovTipo  ON espCxcEstadoCuentaAux.Mov=MovTipo.Mov AND MovTipo.Modulo='CXC'  
WHERE espCxcEstadoCuentaClaveClientes.Estacion=@Estacion  
ORDER BY   
espCxcEstadoCuentaClaveClientes.Cliente, espCxcEstadoCuentaAux.Moneda, espCxcEstadoCuentaAux.FechaEmision, Cxc.ID  
  
-----------------------------------------------------------------------------------------------------------------  
-- Saldo Movil  
SELECT @SaldoMovil=0  
DECLARE crSaldoMovil CURSOR LOCAL FOR   
  SELECT ID, Cliente, Moneda, Cargo, Abono FROM espCxcEstadoCuenta WHERE Estacion=@Estacion  
OPEN crSaldoMovil  
FETCH NEXT FROM crSaldoMovil INTO @ID, @Cliente, @cr_Moneda, @Cargo, @Abono  
SELECT @ClienteAnterior=@Cliente, @cr_MonedaAnterior=@cr_Moneda  
WHILE @@FETCH_STATUS<>-1  
BEGIN  
IF @@FETCH_STATUS<>-2  
BEGIN  
  
IF NOT (@ClienteAnterior=@Cliente AND @cr_MonedaAnterior=@cr_Moneda) SELECT @SaldoMovil=0  
SELECT @SaldoMovil=@SaldoMovil+ISNULL(@Cargo,0)-ISNULL(@Abono,0)   
UPDATE espCxcEstadoCuenta SET SaldoMovil=@SaldoMovil WHERE ID=@ID  
SELECT @ClienteAnterior=@Cliente, @cr_MonedaAnterior=@cr_Moneda  
  
END  
FETCH NEXT FROM crSaldoMovil INTO @ID, @Cliente, @cr_Moneda, @Cargo, @Abono  
END  
CLOSE crSaldoMovil  
DEALLOCATE crSaldoMovil  
  
UPDATE espCxcEstadoCuenta SET SaldoMovil=SaldoMovil+ISNULL(SaldoInicial,0) WHERE Estacion=@Estacion  
  
END  
GO

/****** spNetEstadoCuentaCte ******/				
if exists (select * from sysobjects where id = object_id('dbo.spNetEstadoCuentaCte') and type = 'P') drop procedure dbo.spNetEstadoCuentaCte
GO
CREATE PROC spNetEstadoCuentaCte
 @Empresa	varchar(5)	= NULL,
 @Cliente	varchar(10)	= NULL,
 @FechaD	datetime	= NULL,
 @FechaA	datetime	= NULL,
 @Moneda	varchar(10)	= NULL,
 @SinMovAplicacion varchar(2) = NULL
AS BEGIN
DECLARE 
 @SinMov  bit,
 @Estacion int

 IF ISNULL(@SinMovAplicacion,'') = 'Si'
  SELECT @SinMov = 1
 ELSE
  SELECT @SinMov = 0

 SELECT @FechaD = dbo.fnFechaSinHora(@FechaD)
 SELECT @FechaA = dbo.fnFechaSinHora(@FechaA)
 SELECT @Estacion = @@SPID

 EXEC spEspEstadoCuenta @Estacion, @Empresa, @Cliente, @Cliente, @FechaD, @FechaA, @Moneda, @SinMov

SELECT 
 espCxcEstadoCuenta.ID,
 espCxcEstadoCuenta.Cliente,
 espCxcEstadoCuenta.Moneda,
 espCxcEstadoCuenta.IDMov,
 espCxcEstadoCuenta.Mov,
 espCxcEstadoCuenta.MovID,
 espCxcEstadoCuenta.FechaEmision,
 espCxcEstadoCuenta.Cargo,
 espCxcEstadoCuenta.Abono,
 espCxcEstadoCuenta.SaldoInicial,
 espCxcEstadoCuenta.SaldoFinal,
 espCxcEstadoCuenta.AlCorriente,
 espCxcEstadoCuenta.Rango1,
 espCxcEstadoCuenta.Rango2,
 espCxcEstadoCuenta.Rango3,
 espCxcEstadoCuenta.Rango4,
 espCxcEstadoCuenta.RangoMayor,
 espCxcEstadoCuenta.CargoA,
 espCxcEstadoCuenta.AbonosA,
 espCxcEstadoCuenta.SaldoMovil,
 Cte.Nombre,                                                                                                                                                                                                           CxcAplica.Referencia FROM
 espCxcEstadoCuenta
  JOIN Cte ON espCxcEstadoCuenta.Cliente=Cte.Cliente
  LEFT OUTER JOIN Cxc ON espCxcEstadoCuenta.IDMov=Cxc.ID
  LEFT OUTER JOIN CxcAplica ON espCxcEstadoCuenta.IDAplica=CxcAplica.ID
  LEFT OUTER JOIN CteEnviarA ON espCxcEstadoCuenta.Cliente=CteEnviarA.Cliente AND espCxcEstadoCuenta.EnviarA=CteEnviarA.ID
  WHERE espCxcEstadoCuenta.Estacion = @Estacion
    AND Cte.Condicion NOT IN ('Contado')
  ORDER BY espCxcEstadoCuenta.Cliente, espCxcEstadoCuenta.Moneda, espCxcEstadoCuenta.FechaEmision, espCxcEstadoCuenta.IDMov 

RETURN
END
GO

/**************************************************************************************/

/****** sppNetConDin ******/
IF EXISTS(SELECT name FROM sysobjects where name ='sppNetConDin' and type ='P')
	DROP PROCEDURE dbo.sppNetConDin
GO
CREATE PROCEDURE dbo.sppNetConDin (@IDUsuario int, @IDUsuarioTipo int)
AS
BEGIN
SET NOCOUNT ON

SELECT	DISTINCT 
		ISNULL(F.ID,		ISNULL(U.ID,		M.ID))			ID,
		ISNULL(F.name,		ISNULL(U.name,		M.name))		name,
		ISNULL(F.DBoBJECT,	ISNULL(U.DBoBJECT,	M.DBoBJECT))	dbObject,
		isnull(F.Fav, 0) Fav,
		isnull(U.Users, 0) Users,
		isnull(M.Me, 0) Me,
		ISNULL(F.API,		ISNULL(U.API,		M.API))			API,
		ISNULL(F.metaData,	ISNULL(U.metaData,	M.metaData))	metaData
  FROM	(
		SELECT	DISTINCT 
				Q.IDpNetConDin ID,
				--F.IDUsuario,
				--F.IDUsuarioTipo,
				--ISNULL(Q.Favorito, 0) isFav,
				--ISNULL(Q.Privado, 0) isLock,
				Q.Nombre name,
				Q.ObjetoBase DBoBJECT,
				Q.APIGetString API,
				Q.JSONMetaData metaData,
				1 Fav
				--Q.IDUsuario IDUsuarioCreator,
				--Q.IDUsuarioTipo IDUsuarioTipoCreator,
				--CASE Privado WHEN 1 THEN 'X' ELSE 'P' END  + '-' + CAST(Q.IDUsuario as varchar(10)) + '-' + CAST(Q.IDUsuarioTipo as varchar(10)) Seguro
			FROM	pNetConDin Q LEFT JOIN pNetConDinFavs F ON Q.IDpNetConDin = F.IDpNetConDin
			WHERE	(F.IDUsuario = @IDUsuario OR q.IDUsuario = @IDUsuario) AND (F.IDUsuarioTipo = @IDUsuarioTipo OR Q.IDUsuarioTipo = @IDUsuarioTipo) AND ISNULL(Q.Favorito, 0) = 1
 ) AS F
   FULL JOIN (
			SELECT	DISTINCT 
				Q.IDpNetConDin ID,
				--F.IDUsuario,
				--F.IDUsuarioTipo,
				--ISNULL(Q.Favorito, 0) isFav,
				--ISNULL(Q.Privado, 0) isLock,
				Q.Nombre name,
				Q.ObjetoBase DBoBJECT,
				Q.APIGetString API,
				Q.JSONMetaData metaData,
				1 Users
				--Q.IDUsuario IDUsuarioCreator,
				--Q.IDUsuarioTipo IDUsuarioTipoCreator,
				--CASE Privado WHEN 1 THEN 'X' ELSE 'P' END  + '-' + CAST(Q.IDUsuario as varchar(10)) + '-' + CAST(Q.IDUsuarioTipo as varchar(10)) Seguro
			FROM	pNetConDin Q LEFT JOIN pNetConDinFavs F ON Q.IDpNetConDin = F.IDpNetConDin
			WHERE	ISNULL(Q.Privado, 0) = 0
) AS U ON F.ID = U.ID
  FULL JOIN ( 
			SELECT	DISTINCT 
					Q.IDpNetConDin ID,
					--F.IDUsuario,
					--F.IDUsuarioTipo,
					--ISNULL(Q.Favorito, 0) isFav,
					--ISNULL(Q.Privado, 0) isLock,
					Q.Nombre name,
					Q.ObjetoBase DBoBJECT,
					Q.APIGetString API,
					Q.JSONMetaData metaData,
					1 Me
					--Q.IDUsuario IDUsuarioCreator,
					--Q.IDUsuarioTipo IDUsuarioTipoCreator
					--CASE Privado WHEN 1 THEN 'X' ELSE 'P' END  + '-' + CAST(Q.IDUsuario as varchar(10)) + '-' + CAST(Q.IDUsuarioTipo as varchar(10)) Seguro
			  FROM	pNetConDin Q LEFT JOIN pNetConDinFavs F ON Q.IDpNetConDin = F.IDpNetConDin
			 WHERE	(F.IDUsuario = @IDUsuario OR q.IDUsuario = @IDUsuario) AND (F.IDUsuarioTipo = @IDUsuarioTipo OR Q.IDUsuarioTipo = @IDUsuarioTipo) AND ISNULL(Q.Privado, 0) = 1
) AS M ON U.ID = M.ID OR F.ID = M.ID
ORDER BY name
 
SET NOCOUNT OFF

RETURN
END
GO


/********** spPNETConsultaVtasFactE ************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('spPNETConsultaVtasFactE') AND type = 'P') 
	DROP PROCEDURE spPNETConsultaVtasFactE
GO
CREATE PROCEDURE spPNETConsultaVtasFactE
	@Usuario		varchar(100),
	@EstatusV1		varchar(max),
	@Desde			date,
	@Hasta			date
AS BEGIN
	IF @EstatusV1 = '(Todos)'
	BEGIN
		SELECT	v.ID,
				e.Nombre AS Empresa,
				s.Nombre AS Sucursal,
				RTRIM(v.Mov)+' '+RTRIM(ISNULL(v.MovID,'')) AS Movimiento,
				CONVERT(VARCHAR(50),v.FechaEmision,121) AS FechaEmision,
				v.Estatus,
				v.Moneda,
				v.TipoCambio,
				v.Condicion CondicionPago,
				v.Referencia,
				v.Concepto,
				t.importe,
				CASE WHEN t.DescuentosTotales <> 0 THEN (ISNULL(t.DescuentosTotales,0)-ISNULL(t.DescuentoLineal,0)) ELSE 0 END AS Descuento,
				t.SubTotal,
				t.Impuestos,
				t.ImporteTotal,
				CASE WHEN v.Estatus = 'PENDIENTE' THEN 1 WHEN v.Estatus = 'CONCLUIDO' THEN 2 WHEN v.Estatus = 'CANCELADO' THEN 3 ELSE 4 END Orden
		  FROM	Venta v
		  JOIN	MovTipo m ON v.Mov = m.Mov AND m.Modulo = 'VTAS'
		  JOIN	VentaCalc t ON v.ID = t.ID
		  LEFT	JOIN CFD f ON (v.ID = f.ModuloID AND f.Modulo = 'VTAS')
		  JOIN	Empresa e ON v.Empresa = e.Empresa
		  JOIN	Sucursal s ON v.Sucursal = s.Sucursal
		 WHERE	m.Clave IN ('VTAS.P','VTAS.F')
				AND v.Cliente = @Usuario
				AND v.FechaEmision BETWEEN @Desde AND @Hasta
				AND v.Estatus IN ('CONCLUIDO','PENDIENTE')
		 GROUP	BY v.ID, V.Mov, v.MovID, v.FechaEmision, v.Estatus, v.Moneda, v.TipoCambio, v.Condicion, v.Concepto, v.Referencia, t.importe, t.DescuentosTotales, t.DescuentosTotales, t.DescuentoLineal, t.SubTotal, t.Impuestos, t.ImporteTotal, e.Nombre, s.Nombre 
		 ORDER	BY Orden ASC, CONVERT(DATETIME,v.FechaEmision) DESC
	END
	ELSE
	BEGIN
		SELECT	v.ID,
				e.Nombre AS Empresa,
				s.Nombre AS Sucursal,
				RTRIM(v.Mov)+' '+RTRIM(ISNULL(v.MovID,'')) AS Movimiento,
				CONVERT(VARCHAR(50),v.FechaEmision,121) AS FechaEmision,
				v.Estatus,
				v.Moneda,
				v.TipoCambio,
				v.Condicion CondicionPago,
				v.Referencia,
				v.Concepto,
				t.importe,
				CASE WHEN t.DescuentosTotales <> 0 THEN (ISNULL(t.DescuentosTotales,0)-ISNULL(t.DescuentoLineal,0)) ELSE 0 END AS Descuento,
				t.SubTotal,
				t.Impuestos,
				t.ImporteTotal,
				CASE WHEN v.Estatus = 'PENDIENTE' THEN 1 WHEN v.Estatus = 'CONCLUIDO' THEN 2 WHEN v.Estatus = 'CANCELADO' THEN 3 ELSE 4 END Orden
		  FROM	Venta v
		  JOIN	MovTipo m ON v.Mov = m.Mov AND m.Modulo = 'VTAS'
		  JOIN	VentaCalc t ON v.ID = t.ID
		  LEFT	JOIN CFD f ON (v.ID = f.ModuloID AND f.Modulo = 'VTAS')
		  JOIN	Empresa e ON v.Empresa = e.Empresa
		  JOIN	Sucursal s ON v.Sucursal = s.Sucursal
		 WHERE	m.Clave IN ('VTAS.P','VTAS.F')
				AND v.Cliente = @Usuario
				AND v.FechaEmision BETWEEN @Desde AND @Hasta
				AND v.Estatus = ISNULL(@EstatusV1,'')
		 GROUP	BY v.ID, V.Mov, v.MovID, v.FechaEmision, v.Estatus, v.Moneda, v.TipoCambio, v.Condicion, v.Concepto, v.Referencia, t.importe, t.DescuentosTotales, t.DescuentosTotales, t.DescuentoLineal, t.SubTotal, t.Impuestos, t.ImporteTotal, e.Nombre, s.Nombre 
		 ORDER	BY Orden ASC, CONVERT(DATETIME,v.FechaEmision) DESC
	END

RETURN
END
GO


/********* spPNETConsultaVtasFactED *****************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('spPNETConsultaVtasFactED') AND type = 'P') 
  DROP PROCEDURE spPNETConsultaVtasFactED
GO
CREATE PROCEDURE spPNETConsultaVtasFactED
	@ID varchar(max)
AS BEGIN
 SELECT DISTINCT TOP 1500 CASE WHEN d.RenglonTipo = 'C' THEN '    '+a.Descripcion1 ELSE a.Descripcion1 END [Descripcion],
		ISNULL(d.SubCuenta,'') AS [SubCuenta],
		ISNULL(d.Cantidad,'') AS [Cantidad], 
		ISNULL(d.Unidad,'') AS [Unidad], 
		d.Precio AS [Precio], 
		d.Importe AS [Importe],
		CONVERT(FLOAT,ISNULL(d.DescuentoLinea,'')) AS DescuentoLinea, 
		d.SubTotal AS [SubTotal], 
		d.Impuestos AS [Impuestos], 
		d.ImporteTotal AS [ImporteTotal],
		d.RenglonID
   FROM VentaTCalc d
   JOIN Art a ON d.Articulo = a.Articulo
  WHERE ID = CONVERT(INT,RTRIM(@ID))
  ORDER BY d.RenglonID

RETURN
END
GO


/********* spPNetEstadoCtaCte **********/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('dbo.spPNetEstadoCtaCte') AND type = 'P') 
	DROP PROCEDURE dbo.spPNetEstadoCtaCte
GO
CREATE PROC spPNetEstadoCtaCte
 @Cliente  varchar(10)
AS BEGIN
DECLARE
 @Empresa  varchar(5),
 @Fecha    datetime,
 @Estacion int

 SELECT TOP 1 @Empresa = Empresa FROM CXC WHERE Cliente = @Cliente
 SELECT @Fecha = dbo.fnFechaSinHora(GETDATE())
 SELECT @Estacion = @@SPID

 EXEC spGenerarEstadoCuenta @Estacion, @Empresa, 'CXC', @Fecha, @Cliente, -1, NULL

 SELECT EstadoCuenta.ID,
        EstadoCuenta.Moneda,
		'$' + CONVERT(varchar,CAST(EstadoCuenta.Efectivo as money),1) Efectivo,
		'$' + CONVERT(varchar,CAST(EstadoCuenta.Consumos as money),1) Consumos,
		'$' + CONVERT(varchar,CAST(EstadoCuenta.Vales as money),1) Vales,
		'$' + CONVERT(varchar,CAST(EstadoCuenta.Redondeo as money),1) Redondeo,
		Auxiliar.ID,
		CONVERT(VARCHAR(11), Auxiliar.Fecha,106) Fecha,
		LTRIM(RTRIM(Auxiliar.Mov)) + ' ' + LTRIM(RTRIM(Auxiliar.MovID)) Movimiento,
		'$' + CONVERT(varchar,CAST(Auxiliar.Cargo as money),1) Cargo,
		'$' + CONVERT(varchar,CAST(Auxiliar.Abono as money),1) Abono,
		'$' + CONVERT(varchar,CAST(ISNULL(Auxiliar.Cargo,0) - ISNULL(Auxiliar.Abono,0) as money),1) Saldo,
		LTRIM(RTRIM(Auxiliar.Aplica)) + ' ' + LTRIM(RTRIM(Auxiliar.AplicaID)) Aplica,
		Cte.Cliente,
		Cte.Nombre 
	FROM EstadoCuenta
	LEFT OUTER JOIN Auxiliar ON EstadoCuenta.AuxiliarID=Auxiliar.ID
	JOIN Cte ON EstadoCuenta.Cuenta=Cte.Cliente
   WHERE EstadoCuenta.Estacion=@Estacion AND EstadoCuenta.Modulo='CXC'
   ORDER BY EstadoCuenta.Moneda, Cte.Cliente, Auxiliar.Fecha, Auxiliar.Aplica, Auxiliar.AplicaID, EstadoCuenta.ID 

RETURN
END
GO

/************* spNetCteEdoCtaInfoGeneral ********************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('spNetCteEdoCtaInfoGeneral') AND type = 'P') 
	DROP PROCEDURE spNetCteEdoCtaInfoGeneral
GO
CREATE PROCEDURE spNetCteEdoCtaInfoGeneral
	@Desde			varchar(100),
	@Hasta			varchar(100),
	@Cliente		varchar(10),
	@Empresa		varchar(50)
AS BEGIN
 DECLARE 
	@DesdeD		date,
	@HastaD		date,
	@CreditoConLimite   BIT,
	@CreditoDisponible	VARCHAR(255)

	SET @DesdeD =  Convert(date,@Desde,120)
	SET @HastaD =  Convert(date,@Hasta,120)			  
		
	EXEC spGenerarEstadoCuenta @@SPID, @Empresa, 'CXC', @DesdeD, @Cliente, -1, NULL, @HastaD
	SELECT @CreditoConLimite = CreditoConLimite FROM Cte WHERE Cliente = @Cliente

	IF(@CreditoConLimite = 1)
		BEGIN				
			SELECT ISNULL(c.Nombre,'') [NombreCliente], 
				   ISNULL(A.Nombre,'') [AgenteVentas], 
				   C.Condicion [CondicionPago],
				   'PESOS' [Moneda], 
				   dbo.fnFormatoMonedaDec(CONVERT(DECIMAL(30,10),(X.Saldo * M.TipoCambio)), 2) [SaldoTotal],
				   dbo.fnFormatoMonedaDec(CONVERT(DECIMAL(30,10),C.CreditoLimite),2) [LimiteSaldo],
				   dbo.fnFormatoMonedaDec(CONVERT(DECIMAL(30,10),(C.CreditoLimite - (X.Saldo * M.TipoCambio))),2) [CreditoDisponible]
			  FROM EstadoCuenta EC
			  JOIN Cte C ON EC.Cuenta = C.Cliente     
			  LEFT JOIN Auxiliar AU ON EC.AuxiliarID = Au.ID     
			  LEFT JOIN CxcSaldo X ON X.Cliente = C.Cliente      
			  LEFT JOIN Mon M ON M.Moneda = X.Moneda
			  LEFT JOIN Agente A ON A.Agente = C.Agente
			 WHERE C.Cliente = @Cliente
			   AND EC.Modulo='CXC'
			   AND AU.FECHA BETWEEN @DesdeD AND @HastaD
			 GROUP BY c.Nombre, X.Saldo, M.TipoCambio, m.moneda, C.CreditoConLimite, A.Nombre, C.Condicion, C.CreditoMoneda, C.CreditoLimite						 	
		END
	ELSE
		BEGIN		
			SELECT ISNULL(c.Nombre,'') [NombreCliente], 
				   ISNULL(A.Nombre,'') [AgenteVentas], 
				   C.Condicion [CondicionPago],
				   'PESOS' [Moneda], 
				   dbo.fnFormatoMonedaDec(CONVERT(DECIMAL(30,10),(X.Saldo * M.TipoCambio)), 2) [SaldoTotal],
				   'No cuenta con un límite de Crédito' [LimiteSaldo],
				   'No cuenta con un límite de Crédito' [CreditoDisponible]
			   FROM EstadoCuenta EC
			   JOIN Cte C ON EC.Cuenta = C.Cliente     
			   LEFT JOIN Auxiliar AU ON EC.AuxiliarID = Au.ID     
			   LEFT JOIN CxcSaldo X ON X.Cliente = C.Cliente      
			   LEFT JOIN Mon M ON M.Moneda = X.Moneda
			   LEFT JOIN Agente A ON A.Agente = C.Agente
		      WHERE C.Cliente = @Cliente
			    AND EC.Modulo='CXC'
				AND AU.FECHA BETWEEN @DesdeD AND @HastaD    
			  GROUP BY c.Nombre, X.Saldo, M.TipoCambio, m.moneda, C.CreditoConLimite, A.Nombre, C.Condicion, C.CreditoMoneda, C.CreditoLimite
		 END
		 	
RETURN
END
GO


/******** spNetConsultaCteEdoCta *****************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('spNetConsultaCteEdoCta') AND type = 'P') 
	DROP PROCEDURE spNetConsultaCteEdoCta
GO
CREATE PROCEDURE spNetConsultaCteEdoCta
	@Desde			varchar(100),
	@Hasta			varchar(100),
	@Cliente		varchar(10),
	@Empresa		varchar(50)
AS BEGIN
 DECLARE 
	@DesdeD		date,
	@HastaD		date
		
	SET @DesdeD =  Convert(date,@Desde,120)
	SET @HastaD =  Convert(date,@Hasta,120)
	--EXEC spGenerarEstadoCuenta @@SPID, @Empresa, 'CXC', @DesdeD, @Cliente, -1, NULL, @HastaD

	DECLARE @EstadoCuentaCtes TABLE
	(
		MODULOID     INT NULL,
		MOV          VARCHAR(20) NULL,
		MOVID        VARCHAR(20) NULL,
		Fecha        DATETIME NULL,
		Concepto     VARCHAR(100) NULL,
		Moneda       VARCHAR(20) NULL,
		TipoCambio   MONEY NULL,
		Cargo        MONEY NULL,
		Abono        MONEY NULL,
		Saldo        MONEY NULL,
		Vencimiento  DATETIME NULL,
		Modulo       varchar(5) null,
		CUENTA       VARCHAR(100) NULL,
		APLICA       VARCHAR(20) NULL,
		APLICAID     VARCHAR(20)NULL
	)
		
	DECLARE @EstadoCuentaCtes1 TABLE
	(
		MOV        VARCHAR(20) NULL,
		MOVID      VARCHAR(20) NULL,
		Cargo      MONEY NULL,
		Abono      MONEY NULL,
		Saldo      MONEY NULL,
		APLICA       VARCHAR(20) NULL,
		APLICAID     VARCHAR(20)NULL
	)

	INSERT @EstadoCuentaCtes (MODULOID, MOV, MOVID, Fecha, MONEDA, TipoCambio, Cargo, Abono, Modulo, CUENTA, APLICA, APLICAID)
	SELECT DISTINCT MODULOID, MOV, MOVID, Fecha, MONEDA, TipoCambio, SUM(Cargo), SUM(Abono), Modulo, CUENTA, APLICA, APLICAID
			FROM AUXILIAR
	WHERE RAMA = 'CXC'
	GROUP BY MODULOID, MOV, MOVID, Fecha, MONEDA, TipoCambio, Modulo, ModuloId, CUENTA, APLICA, APLICAID
			
	INSERT @EstadoCuentaCtes1(MOV, MOVID, Cargo, Abono, Saldo, Aplica, AplicaID)
	SELECT DISTINCT Aplica, AplicaID, SUM(Cargo) ,SUM(Abono),0, A.Aplica, A.AplicaID
			FROM AUXILIAR A
	WHERE A.RAMA = 'CXC'		 
			AND ((MOV + MOVID) <> APLICA + APLICAID)
	GROUP BY Aplica, AplicaID
			
		SELECT CONVERT(VARCHAR(10),A.Fecha,105) [Fecha], 
			RTRIM(A.MOV) + ' ' + RTRIM(ISNULL(A.MOVID,'')) [Movimiento],
			ISNULL(C.concepto,'') [Concepto], 
			ISNULL(C.Estatus,'') [Estatus], 
			ISNULL(A.Moneda,'') [Moneda], 
			dbo.fnFormatoMonedaDec(CONVERT(DECIMAL(30,10),A.tipocambio),2) [Tipocambio], 
			dbo.fnFormatoMonedaDec(CONVERT(DECIMAL(30,10),ISNULL(A.Cargo,0.00) + ISNULL(B.Cargo,0.00)),2) [Cargo], 
			dbo.fnFormatoMonedaDec(CONVERT(DECIMAL(30,10),ISNULL(B.Abono,0.00) + ISNULL(A.Abono,0.00)),2) [Abono], 
			dbo.fnFormatoMonedaDec(CONVERT(DECIMAL(30,10),((ISNULL(A.Cargo,0.00) + ISNULL(B.Cargo,0.00)) - (ISNULL(B.Abono,0.00) + ISNULL(A.Abono,0.00)))),2) [Saldo],   
			CONVERT(VARCHAR(10),C.Vencimiento,105) [Vencimiento], 
			RTRIM(ISNULL(A.MOVID,'')) [MovID]								
		FROM @EstadoCuentaCtes A
		LEFT JOIN @EstadoCuentaCtes1 B ON A.MOV = B.MOV AND A.MOVID = B.MOVID
		JOIN CXC C ON C.ID = A.MODULOID
		JOIN Cte ON A.Cuenta = Cte.Cliente
		LEFT JOIN MovTipo MT ON MT.Modulo = A.Modulo AND C.Mov = MT.Mov
		WHERE Cte.Cliente = @Cliente
		AND MT.Clave NOT IN ('CXC.EST','CXC.SD','CXC.SCH')
		AND C.Estatus NOT IN ('CANCELADO')	
		AND C.Vencimiento BETWEEN @DesdeD AND @HastaD					 
		AND A.AplicaID  = CASE WHEN A.AplicaID = A.MovID AND A.Aplica = A.Mov THEN A.AplicaID END 		  
	    ORDER BY CONVERT(DATETIME,C.Vencimiento) DESC

RETURN
END
GO


/************ spNetEmpresaUsuario *****************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('spNetEmpresaUsuario') AND type = 'P') 
	DROP PROCEDURE spNetEmpresaUsuario
GO
CREATE PROCEDURE spNetEmpresaUsuario
	@IDUsuario	varchar(100)
AS BEGIN

	SELECT e.Empresa, e.Nombre FROM Empresa as e
	 INNER JOIN pNetUsuarioEmpresa AS u ON u.Empresa = e.Empresa
	 WHERE u.IDUsuario = @IDUsuario

RETURN
END
GO

/********** spNetProvEdoCtaInfoGeneral ***************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('spNetProvEdoCtaInfoGeneral') AND type = 'P') 
	DROP PROCEDURE spNetProvEdoCtaInfoGeneral
GO
CREATE PROCEDURE spNetProvEdoCtaInfoGeneral
	@Desde			varchar(100),
	@Hasta			varchar(100),
	@Proveedor		varchar(10),
	@Empresa		varchar(50)
AS BEGIN
 DECLARE 
	@DesdeD		date,
	@HastaD		date

	SET @DesdeD =  CONVERT(date,@Desde,120)
	SET @HastaD =  CONVERT(date,@Hasta,120)
	EXEC spGenerarEstadoCuenta @@SPID, @Empresa, 'CXP', @DesdeD, @Proveedor, -1, NULL, @HastaD

	SELECT ISNULL(P.Nombre,'') [ProveedorD], 
	       ISNULL(A.Agente,'') [AgenteVentas], 
		   ISNULL(P.Condicion,'') [CondicionPago], 
		   ISNULL(P.DefMoneda,'') [Moneda], 
		   (X.Saldo * M.TipoCambio) [SaldoTotal]
	  FROM EstadoCuenta EC
	  JOIN Prov P ON P.Proveedor = EC.Cuenta
	  LEFT JOIN Auxiliar AU ON EC.AuxiliarID = Au.ID
	  LEFT JOIN CxpSaldo X ON X.Proveedor = p.Proveedor
	  LEFT JOIN Mon M ON M.Moneda = X.Moneda AND M.Moneda = P.DefMoneda
	  LEFT JOIN Agente A ON A.Agente = p.Agente
	 WHERE P.Proveedor = @Proveedor
	   AND EC.Modulo='CXP'
	   AND AU.FECHA BETWEEN @Desde AND @Hasta
	 GROUP BY P.Nombre, A.Agente, p.Condicion, p.DefMoneda, X.Saldo, M.TipoCambio
				
RETURN
END
GO

/********* spNetFechaIngresoPers *****************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('spNetFechaIngresoPers') AND type = 'P') 
	DROP PROCEDURE spNetFechaIngresoPers
GO
CREATE PROCEDURE spNetFechaIngresoPers
	@Personal		varchar(10)
AS BEGIN

	SELECT TOP 1 P.FechaAntiguedad, CONVERT(VARCHAR(10), P.FechaAntiguedad,105) [FechaAntiguedadString]  
	  FROM AcumU A, Personal P
	 WHERE (P.Personal=A.Cuenta) AND (Rama='VAC') AND (P.Personal = @Personal)	

RETURN
END
GO

/**************** sppNetFlujoViaticos ****************/
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.sppNetFlujoViaticos') AND TYPE = 'P') 
	DROP PROCEDURE dbo.sppNetFlujoViaticos
GO            
CREATE PROCEDURE sppNetFlujoViaticos
    @ID			int,
    @showCONT	bit
--//WITH ENCRYPTION
AS BEGIN
SET NOCOUNT ON

 CREATE TABLE #preMovFlujo(
	Indx		 int identity,
	Sucursal	 int,
	Empresa		 varchar(5),
	OModulo		 varchar(5),
	OID			 int,
	OMov		 varchar(20),
	OMovID		 varchar(20),
	DModulo		 char(5),
	DID			 int,
	DMov		 varchar(20),
	DMovID		 varchar(20),
	Cancelado	 bit,
	dateInsert	 datetime,
	statusInsert int)

 IF EXISTS (SELECT * FROM MovFlujo WHERE OID = @ID AND OModulo = 'GAS' AND Cancelado = 0)
 BEGIN
	 INSERT INTO #preMovFlujo
	 SELECT Sucursal, Empresa, 'GAS' OModulo, 0 OID, '' OMov, '' OMovID, OModulo DModulo, OID DID, OMov DMov, OMovID DMovID, 0 Cancelado, DATEADD(SS, -1, GETDATE()) dateInsert, 0 statusInsert  
	  FROM MovFlujo 
	 WHERE OID = @ID AND OModulo = 'GAS'

	 INSERT INTO #preMovFlujo
	 SELECT *, GETDATE() dateInsert, 1 statusInsert  
	  FROM MovFlujo 
	 WHERE OID = @ID AND OModulo = 'GAS'
 END

 DECLARE @OID int, @OMov varchar(20), @OMovID varchar(20)
 DECLARE @DID int, @DMov varchar(20), @DMovID varchar(20)

 WHILE EXISTS (SELECT * FROM #preMovFlujo WHERE statusInsert = 1)
 BEGIN
	DECLARE flujo_cursor CURSOR FOR 
		SELECT OID, OMov, OMovID, DID, DMov, DMovID FROM #preMovFlujo WHERE statusInsert = 1 

		OPEN flujo_cursor
		FETCH NEXT FROM flujo_cursor INTO @OID, @OMov, @OMovID, @DID, @DMov, @DMovID

		WHILE @@FETCH_STATUS = 0
		BEGIN
			UPDATE #preMovFlujo SET statusInsert = 0 
			WHERE OID = @OID AND OMov = @OMov AND OMovID = @OMovID AND DID = @DID AND DMov = @DMov AND DMovID = @DMovID

			INSERT INTO #preMovFlujo
			SELECT *, GETDATE() dateInsert, 1 statusInsert  
			  FROM MovFlujo 
			 WHERE OID = @DID AND OMov = @DMov AND OMovID = @DMovID

			FETCH NEXT FROM flujo_cursor INTO @OID, @OMov, @OMovID, @DID, @DMov, @DMovID
		END

	CLOSE flujo_cursor
	DEALLOCATE flujo_cursor
 END

 CREATE TABLE #HeaderV (
	Indx		 int identity,
	Modulo		 char(5),
	ID			 int,
	Movimiento	 varchar(50),
	ConceptoGral varchar(255),
	FechaEmision datetime,
	Importe		 money,
	Estatus		varchar(15),
	xmlFiles	int,
	nFiles		int)
	
 CREATE TABLE #DetailGasto (
	Modulo		 char(5),
	ID			 int,
	Renglon		 float,
	Acreedor	 varchar(255),
	Concepto	 varchar(255),
	--Fecha		 datetime,
	Importe		 money,
	Referencia	 varchar(50),
	Comprobante	 bit)

 IF (@showCONT = 1)
 BEGIN
	CREATE TABLE #DetailCont (
		Modulo		 char(5),
		ID			 int,
		Renglon		 float,
		Cuenta		 varchar(20),
		Descripcion	 varchar(100),
		Concepto	 varchar(50),
		Debe		 money,
		Haber		 money)
 END

 CREATE TABLE #DetailDinero (
	Modulo		 char(5),
	ID			 int,
	Renglon		 float,
	Aplica		 varchar(50),
	FormaPago	 varchar(50),
	Importe		 money,
	Referencia	 varchar(50))

 DECLARE @FModulo char(5), @FID int, @FMov varchar(20), @FMovID varchar(20)

 DECLARE dflujo_cursor CURSOR FOR 
	SELECT DModulo, DID, DMov, DMovID FROM #preMovFlujo ORDER BY Indx, dateInsert
	OPEN dflujo_cursor
	FETCH NEXT FROM dflujo_cursor INTO @FModulo, @FID, @FMov, @FMovID

	WHILE @@FETCH_STATUS = 0
	BEGIN
		DECLARE @hasFiles int, @hasXMLFiles int

		IF (RTRIM(@FModulo) = 'GAS')
		BEGIN
			SELECT @hasXMLFiles =	SUM(CAST(CAST(ISNULL(LEN(Direccion), 0)  as bit) as int)) FROM AnexoMov WHERE Rama = @FModulo AND ID = @FID AND RIGHT(Direccion, 4)  = '.xml' 
			SELECT @hasFiles =		SUM(CAST(CAST(ISNULL(LEN(Direccion), 0)  as bit) as int)) FROM AnexoMov WHERE Rama = @FModulo AND ID = @FID AND RIGHT(Direccion, 4) <> '.xml'

			INSERT INTO #HeaderV
			SELECT @FModulo Modulo, Gasto.ID, Gasto.Mov + ISNULL(' ' + Gasto.MovID, '') Movimiento, Prov.Tipo + ISNULL(' : ' + Prov.Proveedor, '') + ISNULL(' - ' + Prov.Nombre, '') ConceptoGral,
					Gasto.FechaEmision, Gasto.Importe - Gasto.Retencion + Gasto.Impuestos Importe, Gasto.Estatus, ISNULL(@hasXMLFiles, 0) xmlFiles, ISNULL(@hasFiles, 0) nFiles
					--Gasto.Saldo, Gasto.Clase, Gasto.SubClase
				FROM Gasto JOIN Prov ON Gasto.Acreedor=Prov.Proveedor
				WHERE Gasto.ID = @FID 
			 
			INSERT INTO #DetailGasto
			SELECT @FModulo Modulo, GastoD.ID, GastoD.Renglon, ISNULL(Acreedor.Proveedor + ISNULL(' - ' + Acreedor.Nombre, ''), '') Acreedor, GastoD.Concepto, --GastoD.Fecha, 
					GastoD.Importe + GastoD.Impuestos + GastoD.Impuestos2 + GastoD.Impuestos3 - GastoD.Retencion - GastoD.Retencion2 - GastoD.Retencion3 Importe,
					ISNULL(GastoD.Referencia, '') Referencia, GastoD.Comprobante
				FROM GastoD LEFT OUTER JOIN Prov Acreedor ON GastoD.AcreedorRef=Acreedor.Proveedor
				WHERE GastoD.ID = @FID ORDER BY GastoD.Renglon, GastoD.RenglonSub 
		END

		IF (@showCONT = 1)
		BEGIN
			IF (RTRIM(@FModulo) = 'CONT')
			BEGIN
				SELECT @hasXMLFiles =	SUM(CAST(CAST(ISNULL(LEN(Direccion), 0)  as bit) as int)) FROM AnexoMov WHERE Rama = @FModulo AND ID = @FID AND RIGHT(Direccion, 4)  = '.xml' 
				SELECT @hasFiles =		SUM(CAST(CAST(ISNULL(LEN(Direccion), 0)  as bit) as int)) FROM AnexoMov WHERE Rama = @FModulo AND ID = @FID AND RIGHT(Direccion, 4) <> '.xml'

				INSERT INTO #HeaderV
				SELECT @FModulo Modulo, Cont.ID, Cont.Mov + ISNULL(' ' + Cont.MovID, '') Movimiento, ISNULL(Cont.Concepto, Cont.Referencia) ConceptoGral, Cont.FechaEmision,
						Cont.Importe, Cont.Estatus, ISNULL(@hasXMLFiles, 0) xmlFiles, ISNULL(@hasFiles, 0) nFiles -- Cont.Contacto, 
					FROM Cont 
					WHERE Cont.ID = @FID 

				INSERT INTO #DetailCont
				SELECT @FModulo Modulo, ContD.ID, ContD.Renglon, ContD.Cuenta, Cta.Descripcion, ISNULL(ContD.Concepto, '') Concepto, ContD.Debe, ContD.Haber
					FROM ContD
					LEFT OUTER JOIN Cta ON ContD.Cuenta=Cta.Cuenta
					WHERE ContD.ID = @FID AND ISNULL(ContD.Presupuesto, 0)=0 ORDER BY ContD.Renglon, ContD.RenglonSub 
			END
		END

		IF (RTRIM(@FModulo) = 'DIN')
		BEGIN
			SELECT @hasXMLFiles =	SUM(CAST(CAST(ISNULL(LEN(Direccion), 0)  as bit) as int)) FROM AnexoMov WHERE Rama = @FModulo AND ID = @FID AND RIGHT(Direccion, 4)  = '.xml' 
			SELECT @hasFiles =		SUM(CAST(CAST(ISNULL(LEN(Direccion), 0)  as bit) as int)) FROM AnexoMov WHERE Rama = @FModulo AND ID = @FID AND RIGHT(Direccion, 4) <> '.xml'
			
			INSERT INTO #HeaderV
			SELECT @FModulo Modulo, Dinero.ID, Dinero.Mov + ISNULL(' ' + Dinero.MovID, '') Movimiento,
					Dinero.ContactoTipo + ISNULL(' : ' + Dinero.Contacto + ISNULL(' - ' + Dinero.BeneficiarioNombre, ''), '') ConceptoGral,
					Dinero.FechaEmision, Dinero.Importe + Dinero.Impuestos Importe, Dinero.Estatus, ISNULL(@hasXMLFiles, 0) xmlFiles, ISNULL(@hasFiles, 0) nFiles
					--Dinero.Concepto, Dinero.Referencia, Dinero.Observaciones,
				FROM Dinero
				WHERE Dinero.ID = @FID

			INSERT INTO #DetailDinero
			SELECT @FModulo Modulo, DineroD.ID, DineroD.Renglon, ISNULL(DineroD.Aplica + ISNULL(' ' + DineroD.AplicaID, ''), '') Aplica,
					ISNULL(DineroD.FormaPago, '') FormaPago, DineroD.Importe, ISNULL(DineroD.Referencia, '') Referencia
				FROM DineroD
				WHERE DineroD.ID = @FID ORDER BY DineroD.Renglon, DineroD.RenglonSub 
		END

		FETCH NEXT FROM dflujo_cursor INTO @FModulo, @FID, @FMov, @FMovID
	END
	CLOSE dflujo_cursor
 DEALLOCATE dflujo_cursor

 SELECT Indx, Modulo, ID, Movimiento, ConceptoGral, CONVERT(VARCHAR(10), FechaEmision, 105) FechaEmision, Importe, Estatus FROM #HeaderV ORDER BY Indx
 SELECT * FROM #DetailGasto	ORDER BY ID, Renglon
 SELECT * FROM #DetailDinero	ORDER BY ID, Renglon

 IF (@showCONT = 1)
 BEGIN
	SELECT * FROM #DetailCont	ORDER BY ID, Renglon
	DROP TABLE #DetailCont
 END

 DROP TABLE #DetailDinero
 DROP TABLE #DetailGasto
 DROP TABLE #HeaderV
 DROP TABLE #preMovFlujo

 SET NOCOUNT OFF

RETURN
END
GO

/********** spInfoGeneralReciboNomina ***************/
IF exists (SELECT * FROM sysobjects WHERE id = object_id('spInfoGeneralReciboNomina') and type = 'P') 
	DROP PROCEDURE spInfoGeneralReciboNomina
GO   
CREATE PROCEDURE spInfoGeneralReciboNomina
	@Origen			varchar(max),
	@Personal		varchar(20)
AS BEGIN
 -- Obtener Identificador de la Empresa
 DECLARE @Empresa		VARCHAR(5)
		
 SELECT @Empresa = Empresa FROM Personal WHERE Personal = @Personal

 -- Información de la Empresa
 DECLARE
	@RfcEmpresa		VARCHAR(255),	-- Mostrar el RFC de la empresa
	@NombreEmpresa	VARCHAR(255),	-- Nombre del empleador
	@Direccion		VARCHAR(255)	-- Dirección de la empresa
		
	SELECT @RfcEmpresa    = ISNULL(RFC,''),
		   @NombreEmpresa = ISNULL(Nombre,''),
		   @Direccion     = ISNULL(Direccion,'') + ' ' + ISNULL(DireccionNumero,'') + ' ' + ISNULL(DireccionNumeroInt,'') + ' ' + ISNULL(Colonia,'') + ' ' + ISNULL(Poblacion,'') + ' ' + ISNULL(CodigoPostal,'')
	  FROM Empresa
	 WHERE Empresa = @Empresa
	 ORDER BY RFC, Nombre, Direccion, DireccionNumero, DireccionNumeroInt, Colonia, Poblacion, CodigoPostal
		
 -- Información del Empleado
 DECLARE
	@NombreEmpleado	VARCHAR(255),	-- Mostrar el nombre del empleado
	@RfcEmpleado	VARCHAR(255),	-- Mostrar el RFC del empleado
	@CurpEmpleado	VARCHAR(255),	-- Mostrar CURP del empleado
	@NssEmpleado	VARCHAR(255)	-- Mostrar el numero de seguridad social del empleado
		
	SELECT @NombreEmpleado = ISNULL(Nombre,'') + ' ' + ISNULL(ApellidoPaterno,'') + ' ' + isnull(ApellidoMaterno,''),
	       @RfcEmpleado    = ISNULL(Registro2,''),
	       @CurpEmpleado   = ISNULL(Registro,''),
	       @NssEmpleado    = ISNULL(Registro3,'')
	  FROM Personal
	 WHERE Personal = ISNULL(@Personal,'') 
	 GROUP BY Nombre, ApellidoPaterno, ApellidoMaterno, Registro2, Registro, Registro3

 -- Suma percepciones
 DECLARE @Percepcion    MONEY

  SELECT @Percepcion = SUM(Importe)
    FROM NominaD ND
	JOIN Nomina N ON N.ID = ND.ID   
   WHERE ND.Movimiento = 'Percepcion'
	 AND N.Mov         = 'Nomina'
	 AND ND.Personal   = ISNULL(@Personal,'')
	 AND N.id          = @Origen 
	 AND N.Estatus     = 'CONCLUIDO'
			
 -- Suma deducciones
 DECLARE @Deducciones    MONEY

  SELECT @Deducciones = SUM(Importe)
	FROM NominaD ND
	JOIN Nomina N ON N.ID = ND.ID   
   WHERE ND.Movimiento = 'Deduccion'
  	 AND N.Mov         = 'Nomina'
	 AND ND.Personal   = ISNULL(@Personal,'') 
	 AND N.id          = @Origen 
	 AND N.Estatus     = 'CONCLUIDO'
	 
  SELECT ISNULL(NP.RegistroPatronal,'') as RegistroPatronal, 
         NP.Personal as NumeroEmpleado,
         ISNULL(P.Departamento,'') as Departamento,
         ISNULL(P.Puesto,'') as Puesto,
         ISNULL(P.TipoContrato,'') as TipoContrato,
         ISNULL(P.Jornada,'') as TipoJornada,
         dbo.fnCalculaAntiguedad(P.FechaAntiguedad,GETDATE()) as Antiguedad,
         ISNULL(CONVERT(VARCHAR(10),P.FechaAntiguedad,105),'') as InicioRelacionLaboral,
         ISNULL(P.PeriodoTipo,'') PeriodoPago,
         dbo.fnFormatoMonedaDec(CONVERT(DECIMAL(30,10),P.SDI),2) as SDI,
         ISNULL(CONVERT(VARCHAR(10),N.FechaEmision,105),'') as FechaPago, 
         ISNULL(CONVERT(VARCHAR(10),N.FechaD,105),'') as FechaInicialPago,
         ISNULL(CONVERT(VARCHAR(10),N.FechaA,105),'') as FechaFinalPago,
         ISNULL(P.PersonalSucursal,'') as Banco,
         CONVERT(DECIMAL(30,10),ND.importe) as NetoPagar,
         @RfcEmpresa as RfcEmpresa,
         @NombreEmpresa as NombreEmpresa,
         @Direccion as DireccionEmpresa,
         @NombreEmpleado as NombreEmpleado,
         @RfcEmpleado as RfcEmpleado,
         @CurpEmpleado as CurpEmpleado,
         @NssEmpleado as NssEmpleado,
         @Percepcion as TotalPercepciones,
         @Deducciones as TotalDeducciones
	 --  CFD.*
	FROM Personal P 
	JOIN NominaD ND ON ND.Personal = P.Personal
	JOIN Nomina N ON N.ID = ND.ID
	JOIN NominaPersonal NP ON NP.Personal = ND.Personal AND NP.ID = N.ID
	JOIN CFDNomina CFD ON NP.ID = CFD.ModuloID AND NP.Personal = CFD.Personal
   WHERE NP.Personal = ISNULL(@Personal,'') 
	 AND NP.ID = @Origen
	 AND ND.Concepto = 'Nomina' 
   GROUP BY NP.RegistroPatronal, NP.Personal, P.Departamento, P.Puesto, P.TipoContrato, P.Jornada, P.FechaAntiguedad, P.PeriodoTipo, P.SDI, N.FechaEmision,
 		 N.FechaD, N.FechaA, P.PersonalSucursal, ND.importe
   ORDER BY CONVERT(DATETIME,N.FechaD) DESC		           

RETURN
END
GO

/********* spReciboNominaPercepcionDeduccion **********/
IF exists (SELECT * FROM sysobjects WHERE id = object_id('spReciboNominaPercepcionDeduccion') and type = 'P') 
	DROP PROCEDURE spReciboNominaPercepcionDeduccion
GO   
CREATE PROCEDURE spReciboNominaPercepcionDeduccion
	@Origen			varchar(max),
	@Personal		varchar(20),
	@Movimiento		varchar(50)
AS BEGIN
	SELECT ISNULL(ND.Concepto,'') [Concepto],
		   ND.Importe [Importe]
	  FROM NominaD ND
	  JOIN Nomina N ON N.ID = ND.ID   
	 WHERE ND.Movimiento = @Movimiento
	   AND N.Mov         ='Nomina'
	   AND ND.Personal   = ISNULL(@Personal,'')
	   AND N.id          = @Origen 
	   AND N.Estatus     = 'CONCLUIDO'
	 GROUP BY ND.Concepto, ND.Importe

RETURN
END
GO


/************ spReciboNominaHistorial *****************/
IF exists (SELECT * FROM sysobjects WHERE id = object_id('spReciboNominaHistorial') and type = 'P') 
	DROP PROCEDURE spReciboNominaHistorial
GO   
CREATE PROCEDURE spReciboNominaHistorial
	@Personal		varchar(20)
AS BEGIN
	 SELECT A.ID [Detalle],
			ISNULL(B.Personal,'') [Personal], 			        
			ISNULL(A.PeriodoTipo,'') [PeriodoTipo],
			ISNULL(CONVERT(VARCHAR(10),A.FechaD,126),'') FechaD,
			ISNULL(CONVERT(VARCHAR(10),A.FechaA,126),'') FechaA,
			B.importe [NetoaPagar]
	   FROM Nomina A
	   JOIN NominaD B ON A.ID = B.ID
	  WHERE B.Concepto = 'Nomina'  
		AND B.Personal = @Personal
		AND A.Estatus='CONCLUIDO' 
	GROUP BY B.Personal, A.FechaD, A.FechaA, A.PeriodoTipo, B.importe, A.ID
	ORDER BY CONVERT(DATETIME,A.FechaD) DESC

RETURN
END
GO

-- Verifica el Estatus del Personal para enviar correo de BIENVENIDA
/*********** spPNetEnviarCorreoPersonal ************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spPNetEnviarCorreoPersonal')  AND type = 'P') 
	DROP PROCEDURE dbo.spPNetEnviarCorreoPersonal
GO
CREATE PROC spPNetEnviarCorreoPersonal 
	@Personal	varchar(10),
	@Condicion	varchar(20),
	@Parametro1	varchar(MAX) = NULL,
	@Parametro2	varchar(MAX) = NULL,
	@Parametro3	varchar(MAX) = NULL
AS
BEGIN
	DECLARE
	@eMail				varchar(255),
	@Empresa			varchar(5),

	@Nombre				varchar(20),
	@eMailAutoPerfil	varchar(50),
	@eMailAutoAsunto	varchar(255),
	@eMailAutoMensaje	varchar(max)
 
	-- Obtener el correo
	SELECT @eMail = ISNULL(pnet.eMail, p.eMail), @Empresa = p.Empresa
	  FROM Personal p /*LEFT*/ JOIN pNetUsuario pnet ON p.Personal = pnet.Usuario
	 WHERE p.Personal = @Personal

	SELECT @Nombre = MIN(Nombre) 
	  FROM EmpresaCfgPNetPlantillas 
	 WHERE Empresa = @Empresa AND ISNULL(Condicion,'') = @Condicion AND ISNULL(Estatus,'') = 'ACTIVA' 
	 
	WHILE @Nombre IS NOT NULL AND @eMail IS NOT NULL
	BEGIN
		SELECT @eMailAutoPerfil = NULL, @eMailAutoAsunto = NULL, @eMailAutoMensaje = NULL
	
		-- Leer la configuración de cada plantilla
		SELECT @eMailAutoPerfil = Perfil, @eMailAutoAsunto = Asunto, @eMailAutoMensaje = Mensaje
		  FROM EmpresaCfgPNetPlantillas 
		 WHERE Empresa = @Empresa AND Nombre = @Nombre AND ISNULL(Condicion,'') = @Condicion AND ISNULL(Estatus,'') = 'ACTIVA'
	
		-- Agregamos validaciones, en caso de que se mande algún parámetro dinámico
		IF (@Condicion = 'Generar Nómina')
		BEGIN
			SET @eMailAutoMensaje = replace(@eMailAutoMensaje, '@@Periodo', @Parametro1)
		END
	
		-- Si no tiene configurado un Perfil, se busca en la configuración general de la Empresa
		IF ISNULL(@eMailAutoPerfil,'') = '' SELECT @eMailAutoPerfil = DBMailPerfil FROM EmpresaGral WHERE Empresa = @Empresa	

		IF ISNULL(@eMailAutoPerfil,'') <> '' AND ISNULL(@eMail,'') <> ''
		BEGIN
			-- SELECT @eMailAutoPerfil, @eMail, @eMailAutoAsunto, @eMailAutoMensaje, 'HTML'
			EXEC spEnviarDBMail @Perfil = @eMailAutoPerfil, @Para = @eMail, @Asunto = @eMailAutoAsunto, @Mensaje = @eMailAutoMensaje, @Formato = 'HTML'
		END
 
 		SELECT @Nombre = MIN(Nombre) FROM EmpresaCfgPNetPlantillas WHERE Empresa = @Empresa AND ISNULL(Condicion,'') = 'Alta Personal' AND ISNULL(Estatus,'') = 'ACTIVA' AND Nombre > @Nombre
	END
	 
RETURN
END
GO

/**************** spPNetNominaCorreoEnviar ****************/					
if exists (select * from sysobjects where id = object_id('dbo.spPNetNominaCorreoEnviar') and type = 'P') drop procedure dbo.spPNetNominaCorreoEnviar
GO
CREATE PROC spPNetNominaCorreoEnviar
 @Empresa			varchar(5)
AS BEGIN
DECLARE
 @Nombre            varchar(20),
 @eMailAutoPerfil	varchar(50),
 @eMailAutoAsunto	varchar(255),
 @eMailAutoMensaje	varchar(max),
 @eMailAutoDias		int,

 @Fecha				datetime,
 @Personal          varchar(10),
 @eMail             varchar(255),
 @ReportaA          varchar(10),
 @eMailReportaA     varchar(255)

 DECLARE @Para TABLE(
  Personal      varchar(10)  NULL,
  eMail		    varchar(255) NULL,
  ReportaA      varchar(10)  NULL,
  eMailReportaA varchar(255) NULL)

 -- Obtener valores configurados
 
SELECT @Nombre = MIN(Nombre) FROM EmpresaCfgPNetPlantillas WHERE Empresa = @Empresa AND ISNULL(Condicion,'') = 'Periódica' AND ISNULL(Estatus,'') = 'ACTIVA'
WHILE @Nombre IS NOT NULL
BEGIN
 SELECT @eMailAutoPerfil = NULL, @eMailAutoAsunto = NULL, @eMailAutoMensaje = NULL, @eMailAutoDias = NULL
 -- Leer la configuración de cada plantilla
 SELECT @eMailAutoPerfil = Perfil, @eMailAutoAsunto = Asunto, @eMailAutoMensaje = Mensaje, @eMailAutoDias = ISNULL(Dias,0)
   FROM EmpresaCfgPNetPlantillas WHERE Empresa = @Empresa AND Nombre = @Nombre AND ISNULL(Condicion,'') = 'Periódica' AND ISNULL(Estatus,'') = 'ACTIVA'
 -- Si no tiene configurado un Perfil, se busca en la configuración general de la Empresa
 IF ISNULL(@eMailAutoPerfil,'') = '' SELECT @eMailAutoPerfil = DBMailPerfil FROM EmpresaGral WHERE Empresa = @Empresa	

 IF ISNULL(@eMailAutoPerfil,'') <> ''
 BEGIN
  -- Se borran los destinatarios
  DELETE FROM @Para
  -- Se obtiene la fecha actual más los días configurados
  SELECT @Fecha = DATEADD(day, ISNULL(@eMailAutoDias,0), dbo.fnFechaSinHora(GETDATE()))  
  -- Lista de Destinatarios
  INSERT INTO @Para
  SELECT DISTINCT NominaD.Personal, ISNULL(pnet.eMail, p.eMail), p.ReportaA, ISNULL(pnetr.eMail, pr.eMail)
    FROM Nomina    
    JOIN NominaD ON NominaD.ID = Nomina.ID
    JOIN Personal p ON NominaD.Personal = p.Personal
    LEFT JOIN pNetUsuario pnet ON p.Personal = pnet.Usuario
	LEFT JOIN Personal pr ON p.ReportaA = pr.Personal
	LEFT JOIN pNetUsuario pnetr ON p.ReportaA = pnetr.Usuario
   WHERE Nomina.Empresa = @Empresa
     AND Nomina.FechaA <= @Fecha  
     AND NominaD.Movimiento IN ('Percepcion', 'Deduccion')
     AND Nomina.Estatus = 'CONCLUIDO'    
     AND NominaD.Modulo IN ('NOM', 'CXC', 'CXP' )    
     AND Nomina.Mov IN (SELECT Mov FROM MovTipo WHERE Modulo = 'NOM' AND RTRIM(UPPER(Clave)) IN ('NOM.N')) 
     AND NOT EXISTS (SELECT 1 FROM NominaConsulta nc WHERE nc.Personal = NominaD.Personal AND nc.Empresa = Nomina.Empresa)
     AND ISNULL(p.eMail,'') <> ''
   ORDER BY NominaD.Personal ASC 
   
  -- Enviar correos
  SELECT @Personal = MIN(Personal) FROM @Para
  WHILE @Personal IS NOT NULL
  BEGIN
   SELECT @eMail = eMail, @ReportaA = ReportaA, @eMailReportaA = eMailReportaA FROM @Para WHERE Personal = @Personal

   IF @Nombre = 'Recordatorio' AND ISNULL(@eMail,'') <> ''
    EXEC spEnviarDBMail @Perfil = @eMailAutoPerfil, @Para = @eMail, @Asunto = @eMailAutoAsunto, @Mensaje = @eMailAutoMensaje, @Formato = 'HTML'
   IF @Nombre = 'SeguimientO' AND ISNULL(@eMail,'') <> ''
    EXEC spEnviarDBMail @Perfil = @eMailAutoPerfil, @Para = @eMail, @CC = @eMailReportaA, @Asunto = @eMailAutoAsunto, @Mensaje = @eMailAutoMensaje, @Formato = 'HTML'

   SELECT @Personal = MIN(Personal) FROM @Para WHERE Personal > @Personal
  END  
  END
 
 SELECT @Nombre = MIN(Nombre) FROM EmpresaCfgPNetPlantillas WHERE Empresa = @Empresa AND ISNULL(Condicion,'') = 'Periódica' AND ISNULL(Estatus,'') = 'ACTIVA' AND Nombre > @Nombre
END

RETURN
END
GO

/**************** spPNetNotificacionCrearJobs ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPNetNotificacionCrearJobs') and type = 'P') drop procedure dbo.spPNetNotificacionCrearJobs
GO             
CREATE PROCEDURE spPNetNotificacionCrearJobs
  @Nombre			varchar(100),
  @BaseDatos        varchar(30),
  @UsuarioI         varchar(30)
--//WITH ENCRYPTION
AS
  DECLARE
  @TrabajoID        binary (16),
  @ReturnCode       int,
  @Usuario          varchar(30),
  @Contrasena       varchar(30),
  @Activo           bit,
  @Trabajo          char(20),
  @Cadena           varchar(100),
  @Servidor         varchar(30),   
  @HoraInicial      int,
  @HoraFinal        int,
  @Frecuencia       tinyint,
  @Valor            tinyint,
  @Recurrencia      tinyint, 
  @FrecuenciaD      tinyint,
  @ValorD           tinyint,
 
  @Domingo          bit,
  @Lunes            bit,
  @Martes           bit,
  @Miercoles        bit,
  @Jueves           bit,
  @Viernes          bit,
  @Sabado           bit,
  @Valor2           tinyint,
  @Tipo             tinyint,
  @Dia              tinyint,
  @Fecha2           int,
 
  @Estatus          bit,
 
  @spSucursal       int,
  @spEmpresa        varchar(5),
  @spUsuario        varchar(30),
  @spFecha          datetime,
  @NombreOriginal   varchar(100),
  @Procesar         varchar(30)
 
  BEGIN TRANSACTION
    DECLARE @SQLServerAgent TABLE(Estatus varchar(50))
 
    SELECT @NombreOriginal = ISNULL(@Nombre,'')
    SELECT @Nombre = ISNULL(@Nombre,'') + '.' + @@SERVERNAME + '.' + @BaseDatos
    SELECT @ReturnCode = 0    
    IF (SELECT COUNT(*) FROM msdb.dbo.syscategories WHERE name = '[Uncategorized (Local)]') < 1
      EXECUTE msdb.dbo.sp_add_category @name = '[Uncategorized (Local)]'
   
    SELECT @TrabajoID = job_id FROM   msdb.dbo.sysjobs WHERE (name = @Nombre)
    IF (@TrabajoID IS NOT NULL)   
    BEGIN 
       IF (EXISTS (SELECT  * FROM    msdb.dbo.sysjobservers WHERE   (job_id = @TrabajoID) AND (server_id <> 0)))
         BEGIN
            RAISERROR ('Unable to import job ''Notificacion '' since there is already a multi-server job with this name.', 16, 1)
            SELECT @ReturnCode = 1    
         END
       ELSE
         EXECUTE msdb.dbo.sp_delete_job @job_name = @Nombre
      SELECT @TrabajoID = NULL
    END 
 
  IF (@@ERROR = 0 AND @ReturnCode = 0) AND EXISTS(SELECT * FROM pNetNotificacionTrabajo WHERE Trabajo = @NombreOriginal)
  BEGIN
    IF @ReturnCode = 0
      EXECUTE @ReturnCode = msdb.dbo.sp_add_job @job_id = @TrabajoID OUTPUT , @job_name = @Nombre, @owner_login_name = @Usuario, @description =  @Nombre, @category_name = '[Uncategorized (Local)]', @enabled = 1, @notify_level_email = 0, @notify_level_page = 0, @notify_level_netsend = 0, @notify_level_eventlog = 2, @delete_level= 0
 
       DECLARE crTrabajo SCROLL CURSOR FOR
       SELECT Trabajo, Usuario, Contrasena, CONVERT(int, SUBSTRING(HoraInicial,1,2) + SUBSTRING(HoraInicial,4,2) + '00'), CONVERT(int, SUBSTRING(HoraFinal,1,2) + SUBSTRING(HoraFinal,4,2) + '00'), CASE Frecuencia WHEN 'Diaria' THEN 4 WHEN 'Semanal' THEN 8 WHEN 'Mensual' THEN 16 WHEN 'Mensual 2' THEN 32 END, Valor, Recurrencia, CASE FrecuenciaD WHEN 'Minutos' THEN 4 WHEN 'Horas' THEN 8 END , ValorD, Activo, Domingo, Lunes, Martes, Miercoles, Jueves, Viernes, Sabado, CASE Tipo WHEN 'Primer' THEN 1 WHEN 'Segundo' THEN 2 WHEN 'Tercer' THEN 4 WHEN 'Cuarto' THEN 8 WHEN 'Ultimo' THEN 16 END, CASE Dia WHEN 'Domingo' THEN 1 WHEN 'Lunes' THEN 2 WHEN 'Martes' THEN 3 WHEN 'Miercoles' THEN 4 WHEN 'Jueves' THEN 5 WHEN 'Viernes' THEN 6 WHEN 'Sabado' THEN 7 WHEN 'Día' THEN 8 WHEN 'Día de la semana' THEN 9 WHEN 'Día del fin de semana' THEN 10 END, CONVERT(int, CONVERT(varchar,DATEPART(YEAR,FechaInicial)) + dbo.fnRellenarCerosIzquierda(CONVERT(varchar,DATEPART(MONTH,FechaInicial)),2) + dbo.fnRellenarCerosIzquierda(CONVERT(varchar,DATEPART(DAY,FechaInicial)),2)), spSucursal, spEmpresa, spUsuario, GETDATE(), ISNULL(Procesar,'')
         FROM pNetNotificacionTrabajo
       WHERE Trabajo = @NombreOriginal
      
       IF ISNULL(@Contrasena,'') = ''
             SELECT @Contrasena = 'NULL'
			 			  
       OPEN crTrabajo
 
       FETCH NEXT FROM crTrabajo INTO @Trabajo, @Usuario, @Contrasena, @HoraInicial, @HoraFinal, @Frecuencia, @Valor, @Recurrencia, @FrecuenciaD, @ValorD, @Activo, @Domingo, @Lunes, @Martes, @Miercoles, @Jueves, @Viernes, @Sabado, @Tipo, @Dia, @Fecha2, @spSucursal, @spEmpresa, @spUsuario, @spFecha, @Procesar
 
       WHILE @@FETCH_STATUS = 0 AND @ReturnCode = 0
       BEGIN
       --select @Frecuencia = 32
         SELECT @Valor2 = 0
      IF @Frecuencia = 8
      BEGIN
        IF @Domingo = 1
          SELECT @Valor2 = @Valor2 + 1
       
        IF @Lunes = 1
          SELECT @Valor2 = @Valor2 + 2
       
        IF @Martes = 1
          SELECT @Valor2 = @Valor2 + 4
       
        IF @Miercoles = 1
          SELECT @Valor2 = @Valor2 + 8
        
        IF @Jueves = 1
          SELECT @Valor2 = @Valor2 + 16
       
        IF @Viernes = 1
          SELECT @Valor2 = @Valor2 + 32
       
        IF @Sabado = 1
          SELECT @Valor2 = @Valor2 + 64
     
        SELECT @Valor = @Valor2
      END
 
      ELSE
      IF @Frecuencia = 32
        SELECT @Valor = @Dia
 
         IF @Procesar = 'Procesar Correos'
           SET @cadena     = 'EXEC spPNetNominaCorreoEnviar ' + '''' + RTRIM(@spEmpresa) + ''''
 
         -- select @Cadena
 
         EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @TrabajoID, @step_id = 1, @step_name = @Trabajo, @command = @cadena, @database_name = @BaseDatos, @server = '', @database_user_name = '', @subsystem = 'TSQL', @cmdexec_success_code = 0, @flags = 0, @retry_attempts = 0, @retry_interval = 1, @output_file_name = '', @on_success_step_id = 0, @on_success_action = 1, @on_fail_step_id = 0, @on_fail_action = 2
 
         UPDATE pNetNotificacionTrabajo SET UltimaActualizacion = GETDATE() WHERE Trabajo = @Trabajo
        
         FETCH NEXT FROM crTrabajo INTO  @Trabajo, @Usuario, @Contrasena, @HoraInicial, @HoraFinal, @Frecuencia, @Valor, @Recurrencia, @FrecuenciaD, @ValorD, @Activo, @Domingo, @Lunes, @Martes, @Miercoles, @Jueves, @Viernes, @Sabado, @Tipo, @Dia, @Fecha2, @spSucursal, @spEmpresa, @spUsuario, @spFecha, @Procesar
       END
 
    --select @Trabajo Trabajo, @Usuario Usuario, @Contrasena Contrasena, @HoraInicial HoraInicial, @HoraFinal HoraFinal, @Frecuencia Frecuencia, @Valor Valor, @Recurrencia Recurrencia, @FrecuenciaD FrecuenciaD, @ValorD ValorD, @Activo Activo
 
    IF @ReturnCode = 0
         EXECUTE @ReturnCode = msdb.dbo.sp_update_job @job_id = @TrabajoID, @start_step_id = 1, @enabled  = @Activo
 
    IF @ReturnCode = 0
         EXECUTE @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @TrabajoID, @name = @Nombre, @enabled = @Activo, @freq_type = @Frecuencia, @active_start_date = @Fecha2, @active_start_time = @HoraInicial, @freq_interval = @Valor, @freq_subday_type = @FrecuenciaD , @freq_subday_interval = @ValorD, @freq_relative_interval = @Tipo, @freq_recurrence_factor = @Recurrencia, @active_end_date = 99991231, @active_end_time = @HoraFinal
 
    IF @ReturnCode = 0
         EXECUTE @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @TrabajoID, @server_name = @@SERVERNAME
 
  CLOSE crTrabajo
  DEALLOCATE crTrabajo
  --select @ReturnCode = 1
  END 
  INSERT @SQLServerAgent (Estatus)
  EXEC master.dbo.xp_ServiceControl 'QUERYSTATE', 'SQLServerAgent'
 
  IF (SELECT TOP 1 Estatus FROM @SQLServerAgent) = 'Running.' SELECT @Estatus = 1 ELSE SELECT @Estatus = 0
 
  IF @ReturnCode = 0
  BEGIN
    IF @Estatus = 1 SELECT 'Proceso terminado.' ELSE SELECT 'Favor de verificar el servicio del Agente SQL Server para la ejecución del trabajo.'
    COMMIT TRANSACTION
  END
  ELSE
  BEGIN
    IF @Estatus = 1 SELECT 'Proceso terminado.' ELSE SELECT 'Favor de verificar el servicio del Agente SQL Server para la ejecución del trabajo.'
    ROLLBACK TRANSACTION
  END
GO


/*************** fnPNet_MenuInsert *******************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'fnPNet_MenuInsert' AND Type = 'P')
	DROP PROCEDURE fnPNet_MenuInsert
GO
CREATE PROCEDURE dbo.fnPNet_MenuInsert 
	@IDUsuarioTipo		int, 
	@IDRole				int,
	@IDPermisoParent	int, 
	@DescripcionParent	nvarchar (200) = NULL, 
	@IconParent			nvarchar(100),
	@IDPermiso			int,
	@Descripcion		nvarchar (200),
	@RutaPNet			nvarchar(100)
AS BEGIN
	-- PARENT --
	IF NOT EXISTS (SELECT IDPermiso FROM dbo.pNetPermiso WHERE IDPermiso = @IDPermisoParent) AND @DescripcionParent IS NOT NULL
	BEGIN
		INSERT INTO dbo.pNetPermiso (IDPermiso, Descripcion, IDUsuarioTipo, Icon, Ruta, IDPermisoPadre, Mostrar)
		SELECT @IDPermisoParent, @DescripcionParent, @IDUsuarioTipo, @IconParent, '', NULL, 1
	END

	IF NOT EXISTS (SELECT IDRolePermiso FROM dbo.pNetRolePermiso WHERE IDRole = @IDRole AND IDPermiso = @IDPermisoParent)
	BEGIN
		INSERT INTO dbo.pNetRolePermiso (IDRole, IDPermiso)
		SELECT @IDRole, @IDPermisoParent
	END

	-- OPCION --
	IF NOT EXISTS (SELECT IDPermiso FROM dbo.pNetPermiso WHERE IDPermiso = @IDPermiso)
	BEGIN
		INSERT INTO dbo.pNetPermiso (IDPermiso, Descripcion, IDUsuarioTipo, Icon, Ruta, IDPermisoPadre, Mostrar)
		SELECT @IDPermiso, @Descripcion, @IDUsuarioTipo, '', @RutaPNet, @IDPermisoParent, 1
	END

	IF NOT EXISTS (SELECT IDRolePermiso FROM dbo.pNetRolePermiso WHERE IDRole = @IDRole AND IDPermiso = @IDPermiso)
	BEGIN
		INSERT INTO dbo.pNetRolePermiso 
		SELECT @IDRole, @IDPermiso
	END

RETURN
END
GO

/************* spNetEmpresaUsuario *********/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE NAME = 'spNetEmpresaUsuario' and Type = 'P')
  DROP PROCEDURE spNetEmpresaUsuario
GO
CREATE PROCEDURE spNetEmpresaUsuario
  @IDUsuario  varchar(100)  
AS BEGIN   

  SELECT e.Empresa, e.Nombre FROM Empresa as e  
  INNER JOIN pNetUsuarioEmpresa AS u ON u.Empresa = e.Empresa  
  WHERE u.IDUsuario = @IDUsuario  

RETURN  
END
GO  

/***************** spWebUltRegAsisteD *****************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'spWebUltRegAsisteD' AND Type = 'P')
	DROP PROCEDURE spWebUltRegAsisteD
GO
CREATE PROCEDURE spWebUltRegAsisteD  
 @Personal  Char(10)  
AS BEGIN 
 
 SELECT TOP 1 Registro, HoraRegistro  
   FROM Asisted   
  WHERE FechaD = CONVERT(Datetime, CONVERT(Varchar, GETDATE(), 102), 102) 
	AND FechaA = CONVERT(Datetime, CONVERT(Varchar, GETDATE(), 102), 102) 
	AND Personal = @Personal  
  ORDER BY HoraRegistro DESC 
 
RETURN 
END  
GO

/*************** spWebAsistenciasPers *******************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'spWebAsistenciasPers' AND Type = 'P')
	DROP PROCEDURE spWebAsistenciasPers
GO
CREATE PROCEDURE spWebAsistenciasPers      
    @Personal    Char(10),      
    @FechaD      Datetime,      
    @FechaA      Datetime,      
    @Empresa     Char(5)      
AS BEGIN      
  SET NOCOUNT ON      
  SET DATEFIRST 7      
  DECLARE @Fecha      Datetime,       
          @Entrada    Char(5)      
      
  CREATE TABLE #AsistenciasPers (      
    Personal         Char(10) NULL,      
    Fecha            Datetime NULL,      
    HoraRegistroE    Char(5)  NULL,      
    HoraRegistroS    Char(5)  NULL,      
    Usuario          Char(10) NULL,      
    Comentarios      varChar(max) NULL,  
    Localidad     Varchar(50) NULL  
  )      
      
  SELECT @Fecha = @FechaD      
  WHILE @Fecha <= @FechaA      
    BEGIN      
      INSERT INTO #AsistenciasPers (Personal, Fecha) VALUES (@Personal, @Fecha)      
      SELECT @Fecha = DATEADD(DD, 1, @Fecha)      
    END      
      
  DELETE #AsistenciasPers      
  WHERE DATEPART(dw, Fecha) = 7 OR DATEPART(dw, Fecha) = 1      
      
  -- Registra Entradas, Usuario de registro y Comentarios      
  UPDATE #AsistenciasPers      
     SET HoraRegistroE = (SELECT MIN(HoraRegistro) FROM AsisteD, Asiste       
                           WHERE Asiste.Id = AsisteD.Id       
                                 AND AsisteD.Personal = @Personal       
                                 AND CONVERT(Datetime, CONVERT(Varchar, AsisteD.FechaD, 102), 102) = #AsistenciasPers.Fecha       
                                 AND AsisteD.Registro = 'Entrada'       
                                 AND Asiste.Estatus <> 'CANCELADO'       
                                 AND Asiste.Mov IN ('Permiso Dias', 'Registro', 'Reporte Actividades', 'Actividades Extras', 'Registro por Periodo', 'Registro IAS')),  
      
           Comentarios = (SELECT MIN(Asiste.Mov) FROM AsisteD, Asiste       
                           WHERE Asiste.Id = AsisteD.Id       
                                 AND AsisteD.Personal = @Personal       
                                 AND #AsistenciasPers.Fecha BETWEEN CONVERT(Datetime, CONVERT(Varchar, AsisteD.FechaD, 102), 102) AND CONVERT(Datetime, CONVERT(Varchar, AsisteD.FechaA, 102), 102)      
                                 AND Asiste.Estatus <> 'CANCELADO'       
                                 AND Asiste.Mov IN ('Permiso Dias', 'Registro', 'Reporte Actividades', 'Actividades Extras', 'Registro por Periodo', 'Registro IAS')),  
                                   
        Localidad = (SELECT MIN(Asiste.Localidad) FROM AsisteD       
                            JOIN Asiste ON Asiste.Id = AsisteD.Id       
                                 AND Asiste.Mov IN ('Permiso Dias', 'Registro', 'Reporte Actividades', 'Actividades Extras', 'Registro por Periodo', 'Registro IAS')   
                                 AND Asiste.Estatus <> 'CANCELADO'       
                                 AND Asiste.Empresa IN (@Empresa, 'INTEL')      
                           WHERE AsisteD.personal = @Personal       
                                 AND CONVERT(Datetime, CONVERT(Varchar,  AsisteD.FechaD, 102), 102) = #AsistenciasPers.Fecha      
                                 AND AsisteD.Registro = 'Entrada')  
                                   
  -- Registra Salidas      
  UPDATE #AsistenciasPers      
     SET HoraRegistroS = (SELECT MAX(HoraRegistro) FROM AsisteD, Asiste       
                           WHERE Asiste.Id = AsisteD.Id       
                                 AND AsisteD.Personal = @Personal       
                                 AND CONVERT(Datetime, CONVERT(Varchar, AsisteD.FechaD, 102), 102) = #AsistenciasPers.Fecha       
                                 AND AsisteD.Registro = 'Salida'       
                                 AND Asiste.Estatus <> 'CANCELADO'       
                                 AND Asiste.Mov IN ('Permiso Dias', 'Registro', 'Reporte Actividades', 'Actividades Extras', 'Registro por Periodo', 'Registro IAS'))   
      
  -- Actualiza Comentarios Con los días festivos que apliquen      
  UPDATE #AsistenciasPers      
    SET Comentarios = 'Dia festivo - ' + DiaFestivo.Concepto      
    FROM DiaFestivo, #AsistenciasPers       
   WHERE DiaFestivo.Fecha = #AsistenciasPers.Fecha      
      
  -- Nuevamente actualiza el campo Comentarios Con los conceptos de nomina que apliquen      
  UPDATE #AsistenciasPers      
     SET Comentarios = NominaConcepto.Concepto      
    FROM Incidencia      
   JOIN IncidenciaD ON IncidenciaD.Id = Incidencia.Id      
    JOIN #AsistenciasPers ON #AsistenciasPers.Fecha = IncidenciaD.FechaAplicacion      
    JOIN NominaConcepto ON NominaConcepto.NominaConcepto = Incidencia.NominaConcepto      
   WHERE Incidencia.Personal = @Personal       
         AND Incidencia.NominaConcepto IN ('101', '255', '255C', '256', '257', '257T')      
      
  -- Una Vez mas actualiza el campo Comentarios con las faltas del periodo      
  UPDATE #AsistenciasPers      
     SET Comentarios = NominaConcepto.Concepto      
    FROM Incidencia      
    JOIN IncidenciaD ON IncidenciaD.Id = Incidencia.Id      
         AND IncidenciaD.Cantidad > 0      
         AND IncidenciaD.Importe > 0      
         AND IncidenciaD.NominaConcepto In ('254')      
    JOIN #AsistenciasPers ON #AsistenciasPers.Fecha = IncidenciaD.FechaAplicacion      
    JOIN NominaConcepto ON NominaConcepto.NominaConcepto = IncidenciaD.NominaConcepto      
   WHERE Incidencia.Estatus in ('CONCLUIDO','PENDIENTE')      
         AND Incidencia.Personal = @Personal       
      
  -- Depura los permisos que hayan tenido registros de entrada y/o salida      
  UPDATE #AsistenciasPers      
     SET HoraRegistroE = '', HoraRegistroS = ''      
   WHERE RTRIM(Comentarios) = 'Permiso Dias'      
      
  -- Borra los registros posteriores al día de hoy      
  DELETE #AsistenciasPers WHERE Fecha > getdate()      
      
  --Para sacar los retardos      
  SELECT @Entrada = ISNULL(Entrada, '09:00')      
    FROM JornadaD      
    JOIN Personal ON Personal.Jornada = JornadaD.Jornada      
         AND Personal.Personal = @Personal       
   WHERE JornadaD.Logico3 = 1      
      
  -- Finalmente muestra el resultado      
  SELECT Personal,       
         Fecha,       
         HoraRegistroE = ISNULL(HoraRegistroE, ''),       
         HoraRegistroS = ISNULL(HoraRegistroS, ''),       
         Lugar = ISNULL(Localidad, ''),      
         Retardo = CASE WHEN Comentarios = 'Registro' THEN IsNull(Datediff(n, @Entrada, HoraRegistroE), '')      
                        ELSE 0 END,      
         Comentarios = ISNULL(Comentarios, '')      
    FROM #AsistenciasPers      
  SET NOCOUNT OFF    

RETURN  
END      
GO


/***************** spWebEjercicioIngresoPers *****************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'spWebEjercicioIngresoPers' AND Type = 'P')
  DROP PROCEDURE spWebEjercicioIngresoPers
GO
CREATE PROCEDURE spWebEjercicioIngresoPers  
  @Personal Char(10)  
  
AS BEGIN  
  SET NOCOUNT ON  
  SELECT EjercicioInicial = CONVERT(Integer, DATEPART(YYYY, ISNULL(FechaAntiguedad, GETDATE())))   
    FROM PERSONAL   
   WHERE Estatus = 'ALTA'  
         AND Personal = @Personal  
  SET NOCOUNT OFF  

RETURN
END  
GO

/*************** spWebCFDIsRecibosNomina *******************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'spWebCFDIsRecibosNomina' AND Type = 'P')
	DROP PROCEDURE spWebCFDIsRecibosNomina
GO
CREATE PROCEDURE spWebCFDIsRecibosNomina
  @Id			Int,		
  @Personal		Char(10)    
AS BEGIN    
  SET NOCOUNT ON
  
  SELECT DISTINCT a.Nombre
	FROM AnexoMov a
	JOIN NominaD b ON b.Id = a.Id
	 AND b.Personal = RTRIM(@Personal)
   WHERE a.Rama = 'NOM'
	 AND a.id = @Id
	 AND Nombre like RTRIM(@Personal) + '%'

RETURN
END    
GO

/***************** spWebLevantarSolicitudPers *****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE NAME = 'spWebLevantarSolicitudPers' AND TYPE = 'P')
	DROP PROC spWebLevantarSolicitudPers
GO
CREATE PROCEDURE spWebLevantarSolicitudPers
	@Empresa		Varchar(5),
	@SolicitudMov	Varchar(20),	
	@Usuario		Varchar(10),
	@Recurso		Varchar(10),
	@Personal		Varchar(10),
	@Prioridad		Varchar(10),
	@Comentarios	Varchar(500)
AS BEGIN
 SET NOCOUNT ON
 DECLARE @NuevoID INT
 DECLARE @UsuarioResponsable VARCHAR(10)  
    
 SELECT @UsuarioResponsable = Usuario FROM Recurso WHERE Recurso = @Recurso 

 INSERT INTO Soporte (Empresa,	Mov,			FechaEmision,												Usuario,		Estatus, 
					  Personal,	Estado,			UsuarioResponsable,											Vencimiento,							
					  Prioridad,	Titulo,			Comentarios,		SubModulo)
			   VALUES(@Empresa, @SolicitudMov, CONVERT(Datetime, CONVERT(Varchar, GETDATE(), 102), 102),		@Usuario,		'SINAFECTAR', 
					  @Personal, 'No comenzado',	@UsuarioResponsable,	   CONVERT(Datetime, CONVERT(Varchar, GETDATE(), 102), 102), 
					  @Prioridad, @SolicitudMov,	@Comentarios,	'STPER')

 IF @@IDENTITY > 0	
  SET @NuevoID = @@IDENTITY
 ELSE
  SET @NuevoID = 0

 EXEC spAfectar @Modulo = 'ST', @ID = @NuevoID, @Accion = 'AFECTAR', @Base = 'TODO', @GenerarMov = NULL, @Usuario = @Usuario, @SincroFinal = false, @EnSilencio = false
 
 SET NOCOUNT OFF	

RETURN
END
GO

/************ spWebConfirmaRecibosNomina ***************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'spWebConfirmaRecibosNomina' AND Type = 'P')
	DROP PROCEDURE spWebConfirmaRecibosNomina
GO
CREATE PROC spWebConfirmaRecibosNomina
 @ID          int  = NULL,
 @Personal	  varchar(10) = NULL,
 @Empresa	  varchar(5)  = NULL,
 @MovID	      varchar(20) = NULL,
 @VioDetalle  bit         = NULL,
 @Acuerdo     bit         = NULL
AS BEGIN
 IF NOT EXISTS(SELECT 1 FROM NominaConsulta WHERE ID = @ID AND Personal = @Personal AND Empresa = @Empresa AND MovID = @MovID)
 BEGIN
  IF ISNULL(@VioDetalle,0) = 1
   INSERT INTO NominaConsulta(ID, Personal, Empresa, MovID, VioDetalle, FechaDetalle)
    SELECT @ID, @Personal, @Empresa, @MovID, @VioDetalle, GETDATE()
  IF ISNULL(@Acuerdo,0) = 1
   INSERT INTO NominaConsulta(ID, Personal, Empresa, MovID, Acuerdo, FechaAcuerdo)
    SELECT @ID, @Personal, @Empresa, @MovID, @Acuerdo, GETDATE()
 END
 ELSE
 BEGIN
  IF ISNULL(@VioDetalle,0) = 1
   UPDATE NominaConsulta SET VioDetalle = @VioDetalle, FechaDetalle = GETDATE() WHERE ID = @ID AND Personal = @Personal AND Empresa = @Empresa AND MovID = @MovID
  IF ISNULL(@Acuerdo,0) = 1
   UPDATE NominaConsulta SET Acuerdo = @Acuerdo, FechaAcuerdo = GETDATE() WHERE ID = @ID AND Personal = @Personal AND Empresa = @Empresa AND MovID = @MovID
 END

 SELECT 'Registro actualizado'
RETURN
END
GO

/*************** spWebRepRecibosNomina *******************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'spWebRepRecibosNomina' AND Type = 'P')
 DROP PROCEDURE spWebRepRecibosNomina
GO
CREATE PROCEDURE spWebRepRecibosNomina
   @Personal	varchar(10) = NULL, 
   @FechaD		datetime,    
   @FechaA		datetime,
   @Estatus     varchar(15),
   @PersonalVioDetalle	varchar(2) = NULL,
   @PersonalAcuerdo     varchar(2) = NULL
AS BEGIN
DECLARE
	@VioDetalle bit,
	@Acuerdo    bit

 IF ISNULL(@Personal, '') IN ('', '(Todos)', 'Todos', '(Todas)', 'Todas', 'NULL') SELECT @Personal = NULL
 IF ISNULL(@Estatus, '') IN ('', '(Todos)', 'Todos', '(Todas)', 'Todas', 'NULL') SELECT @Estatus = NULL
 IF ISNULL(UPPER(@PersonalVioDetalle),'') = 'SI' SELECT @VioDetalle = 1 ELSE SELECT @VioDetalle = 0
 IF ISNULL(UPPER(@PersonalAcuerdo),'') = 'SI' SELECT @Acuerdo = 1 ELSE SELECT @Acuerdo = 0

  SELECT Nomina.ID,     
		 Nomina.Mov,  
         Nomina.MovID,     
         Empresa.Nombre EmpresaNombre,     
         RFCEmpresa = ISNULL(RFC,''),     
         RegistroPatronal = ISNULL(RegistroPatronal, ''),     
         Nomina.FechaD,     
         Nomina.FechaA,     
         TipoNomina = RTRIM(Nomina.Mov),     
         NominaD.Concepto,     
         Referencia = ISNULL(NominaD.Referencia, ''),    
         Cantidad = ISNULL(NominaD.Cantidad, 0),    
         Percepcion = CASE WHEN NominaD.Movimiento = 'Percepcion' THEN NominaD.Importe ELSE 0 END,     
         Deduccion = CASE WHEN NominaD.Movimiento = 'Deduccion'  THEN NominaD.Importe ELSE 0 END,
		 Nomina.Empresa,
		 ISNULL(nc.VioDetalle,0) VioDetalle,
		 nc.FechaDetalle,
		 ISNULL(nc.Acuerdo,0) Acuerdo,
		 nc.FechaAcuerdo,
		 NominaD.Personal,
		 p.Nombre + ' ' + p.ApellidoPaterno + ' ' + ISNULL(p.ApellidoMaterno, '') NombreCompleto,
		 p.Estatus
    FROM Nomina    
    JOIN NominaD ON NominaD.ID = Nomina.ID AND NominaD.Personal = ISNULL(@Personal, NominaD.Personal)    
    JOIN Empresa ON Empresa.Empresa = Nomina.Empresa  
	JOIN Personal p ON NominaD.Personal = p.Personal
	LEFT JOIN NominaConsulta nc ON Nomina.ID = nc.ID AND NominaD.Personal = nc.Personal AND Nomina.Empresa = nc.Empresa AND Nomina.MovID = nc.MovID  
   WHERE Nomina.FechaA Between @FechaD AND @FechaA    
         AND NominaD.Movimiento IN ('Percepcion', 'Deduccion')
         AND Nomina.Estatus = 'CONCLUIDO'    
         AND NominaD.Modulo IN ('NOM', 'CXC', 'CXP' )    
         AND Nomina.Mov IN (SELECT Mov FROM MovTipo WHERE Modulo = 'NOM' AND RTRIM(UPPER(Clave)) IN ('NOM.N')) 
		 AND ISNULL(p.Estatus,'') = ISNULL(@Estatus, ISNULL(p.Estatus,''))
		 AND ISNULL(nc.VioDetalle,0) = ISNULL(@VioDetalle, ISNULL(nc.VioDetalle,0))
		 AND ISNULL(nc.Acuerdo,0) = ISNULL(@Acuerdo, ISNULL(nc.Acuerdo,0))
   ORDER BY NominaD.Personal ASC 

RETURN
END
GO

/*************** spWebRecibosNomina *******************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'spWebRecibosNomina' AND Type = 'P')
	DROP PROCEDURE spWebRecibosNomina
GO
CREATE PROCEDURE spWebRecibosNomina
   @Personal  Char(10),    
   @FechaD   Datetime,    
   @FechaA   Datetime,
   @Estatus	 tinyint = 0    
    
AS BEGIN
  DECLARE  @Id                  Int,    
           @Renglon             Float,    
           @MovId               Varchar(20),    
           @Empresa             Varchar(100),    
           @RFC                 Varchar(20),    
           @RegistroPatronal    Varchar(20),    
           @FechaDe             Datetime,    
           @FechaAA             Datetime,    
           @TipoNomina          Char(20),    
           @Concepto            Varchar(50),    
           @Referencia          Varchar(50),    
           @Cantidad            Money,    
           @Percepcion          Money,    
           @Deduccion           Money,
		   @NombreAnexoXML		Varchar(255),
		   @NombreAnexoPDF		Varchar(255),
		   
		   @VioDetalle			Bit,
		   @FechaDetalle		Datetime,
		   @Acuerdo				Bit,
		   @FechaAcuerdo		Datetime,
		   @ClaveEmpresa		varchar(5)
    
  CREATE TABLE #ConcNom (    
      Id                  Int NULL,    
      Renglon             Float NULL,    
      MovId               Varchar(20) NULL,    
      Empresa             Varchar(100) NULL,    
      RFC                 Varchar(20) NULL,    
      RegistroPatronal    Varchar(20) NULL,    
      FechaD              Datetime NULL,    
      FechaA              Datetime NULL,    
      TipoNomina          Char(20) NULL,    
      Concepto            Varchar(50) NULL,    
      Referencia          Varchar(50) NULL,    
      Cantidad            Money NULL,    
      Percepcion          Money NULL,    
      Deduccion           Money NULL,
      NombreAnexoXML	  Varchar(255) NULL,
      NombreAnexoPDF	  Varchar(255) NULL,
	  VioDetalle		  Bit NULL,	
	  FechaDetalle		  Datetime NULL,	
	  Acuerdo			  Bit NULL,
	  FechaAcuerdo		  Datetime NULL,
	  ClaveEmpresa        varchar(5) NULL
  )    

  SET NOCOUNT ON 
    
  DECLARE curConcNom CURSOR FAST_FORWARD FOR    
  SELECT Nomina.Id,     
         NominaD.Renglon,     
         Nomina.MovId,     
         Empresa = Empresa.Nombre,     
         RFCEmpresa = ISNULL(RFC, ''),     
         RegistroPatronal = ISNULL(RegistroPatronal, ''),     
         Nomina.FechaD,     
         Nomina.FechaA,     
         TipoNomina = RTRIM(Nomina.Mov),     
         NominaD.Concepto,     
         Referencia = ISNULL(NominaD.Referencia, ''),    
         Cantidad = ISNULL(NominaD.Cantidad, 0),    
         Percepcion = CASE WHEN NominaD.Movimiento = 'Percepcion' THEN Nominad.Importe ELSE 0 END,     
         Deduccion = CASE WHEN NominaD.Movimiento = 'Deduccion'  THEN Nominad.Importe ELSE 0 END,
		 Nomina.Empresa
    FROM Nomina    
    JOIN NominaD ON NominaD.Id = Nomina.Id    
         AND NominaD.Personal = @Personal    
    JOIN Empresa ON Empresa.Empresa = Nomina.Empresa    
   WHERE Nomina.FechaA Between @FechaD AND @FechaA    
         AND NominaD.Movimiento IN ('Percepcion', 'Deduccion')
         AND Nomina.Estatus = 'CONCLUIDO'    
         AND NominaD.Modulo IN ('NOM', 'CXC', 'CXP' )    
         AND Nomina.Mov IN (SELECT Mov FROM MovTipo WHERE Modulo = 'NOM' AND RTRIM(UPPER(Clave)) IN ('NOM.N')) /*, 'NOM.NE', 'NOM.NC', 'COMS.B', 'COMS.CC', 'COMS.FL', 'COMS.CP', 'COMS.OP', 'COMS.O', 'COMS.C', 'COMS.DC', 'COMS.D','COMS.DG', 'COMS.F','COMS.EG', 'COMS.EI', 'COMS.EST', 'COMS.CA', 'COMS.GX', 'COMS.IG', 'COMS.R', 'COMS.OI', 'COMS.OD', 'COMS.OG', 'COMS.PR', 'COMS.R', 'COMS.F', 'COMS.D')) */   
 ORDER  BY Nomina.FechaD ASC, Nomina.Mov ASC, Percepcion DESC      
    
  OPEN curConcNom    
  FETCH NEXT FROM curConcNom INTO @Id, @Renglon, @MovId, @Empresa, @RFC, @RegistroPatronal, @FechaDe, @FechaAA, @TipoNomina, @Concepto, @Referencia, @Cantidad, @Percepcion, @Deduccion, @ClaveEmpresa   
	
  WHILE @@FETCH_STATUS = 0    
    BEGIN    
		SELECT @VioDetalle = NULL, @FechaDetalle = NULL, @Acuerdo = NULL, @FechaAcuerdo = NULL

		SELECT @VioDetalle = VioDetalle,  @FechaDetalle = FechaDetalle, @Acuerdo = Acuerdo, @FechaAcuerdo = FechaAcuerdo, @NombreAnexoXML= NULL, @NombreAnexoPDF = NULL 
		  FROM NominaConsulta WHERE ID = @Id AND Personal = @Personal AND Empresa = @ClaveEmpresa AND MovID = @MovId

        UPDATE #ConcNom    
           SET Cantidad = Cantidad + @Cantidad, Percepcion = Percepcion + @Percepcion, Deduccion = Deduccion + @Deduccion   
         WHERE Concepto = @Concepto AND FechaD = @FechaDe AND FechaA = @FechaAA --AND TipoNomina = @TipoNomina    
    
        IF @@Rowcount = 0
		BEGIN
		  SELECT @NombreAnexoXML = Nombre FROM AnexoMov WHERE Rama = 'NOM' AND id = @Id AND Nombre Like '%' + ltrim(rtrim(@Personal)) + '%.xml%'
		  SELECT @NombreAnexoPDF = Nombre FROM AnexoMov WHERE Rama = 'NOM' AND id = @Id AND Nombre Like '%' + ltrim(rtrim(@Personal)) + '%.pdf%'
  
          INSERT INTO #ConcNom VALUES(@Id, @Renglon, @MovId, @Empresa, @RFC, @RegistroPatronal, @FechaDe, @FechaAA, @TipoNomina, @Concepto, @Referencia, @Cantidad, @Percepcion, @Deduccion, @NombreAnexoXML, @NombreAnexoPDF, @VioDetalle, @FechaDetalle, @Acuerdo, @FechaAcuerdo, @ClaveEmpresa)
		END
    
	    --SELECT @NombreAnexoXML = Nombre FROM AnexoMov WHERE Rama = 'NOM' AND id = @Id AND Nombre Like '%.xml%'
        --SELECT @Id, @NombreAnexoXML 

        FETCH NEXT FROM curConcNom INTO @Id, @Renglon, @MovId, @Empresa, @RFC, @RegistroPatronal, @FechaDe, @FechaAA, @TipoNomina, @Concepto, @Referencia, @Cantidad, @Percepcion, @Deduccion, @ClaveEmpresa
    END    
  CLOSE curConcNom    
  DEALLOCATE curConcNom 

  --SELECT @NombreAnexoXML = Nombre FROM AnexoMov WHERE Rama = 'NOM' AND id = @Id AND Nombre Like '%.xml%'
  --SELECT @NombreAnexoPDF = Nombre FROM AnexoMov WHERE Rama = 'NOM' AND id = @Id AND Nombre Like '%.pdf%'

  SELECT Id,    
         Renglon,    
         MovId,    
         Empresa = RTRIM(Empresa),     
         RFC = RTRIM(RFC),     
         RegistroPatronal = RTRIM(RegistroPatronal),    
         FechaD = dbo.fnFormatDateTime(FechaD, 'YYYY-MM-DD'),     
		 FechaA = dbo.fnFormatDateTime(FechaA, 'YYYY-MM-DD'),    
         TipoNomina = RTRIM(TipoNomina),    
         Concepto = RTRIM(Concepto),     
		 Referencia  = RTRIM(Referencia),     
         Cantidad = ROUND(Cantidad, 0),    
         Percepcion = ROUND(Percepcion, 2),    
         Deduccion = ROUND(Deduccion, 2),
		 replace(NombreAnexoXML, ' ', '') NombreAnexoXML,
		 replace(NombreAnexoPDF, ' ', '') NombreAnexoPDF,
		 ISNULL(VioDetalle,0) VioDetalle,
		 FechaDetalle,
		 ISNULL(Acuerdo,0) Acuerdo,
		 FechaAcuerdo,
		 ClaveEmpresa
    FROM #ConcNom      
   WHERE (Cantidad <> 0 OR Percepcion <> 0 OR Deduccion <> 0)
		 AND ISNULL(VioDetalle,0) = case 
			when @Estatus = 0 then ISNULL(VioDetalle,0)
			when @Estatus = 1 then 0
			when @Estatus = 2 then 1
			when @Estatus = 3 then 1
		 end
		 AND ISNULL(Acuerdo,0) = case 
			when @Estatus = 0 then ISNULL(Acuerdo,0)
			when @Estatus = 1 then 0
			when @Estatus = 2 then 0
			when @Estatus = 3 then 1
		 end
  SET NOCOUNT OFF    
END    
GO


/************** pNetPersonalA *************/
if exists (select * from sysobjects where id = object_id('dbo.pNetPersonalA') and type = 'P') DROP PROCEDURE dbo.pNetPersonalA
GO
CREATE PROC pNetPersonalA
AS BEGIN
SELECT '(Todos)' Personal, '(Todos)' NombreCompleto
UNION ALL
SELECT LTRIM(RTRIM(Personal)) Personal, LTRIM(RTRIM(NombreCompleto)) NombreCompleto
  FROM PersonalA WHERE Estatus = 'ALTA'
 ORDER BY NombreCompleto
RETURN
END
GO

/************** pNetLogRecibosNomina *************/
IF exists (select * from sysobjects where id = object_id('dbo.pNetLogRecibosNomina') and type = 'P') DROP PROCEDURE dbo.pNetLogRecibosNomina
GO
CREATE PROC pNetLogRecibosNomina
AS BEGIN
SELECT '(Todas)' Descripcion
UNION ALL
SELECT DISTINCT Descripcion
  FROM LogRecibosNomina
  ORDER BY Descripcion
RETURN
END
GO

/************************ spWebEvaluacionesPersonal ***************************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE NAME = 'spWebEvaluacionesPersonal' and Type = 'P')
  DROP PROCEDURE spWebEvaluacionesPersonal
GO
CREATE PROCEDURE spWebEvaluacionesPersonal
  @Personal            Varchar(20)
AS BEGIN 
 SELECT Evaluacion.Evaluacion,
        PromedioEval = ROUND(EvaluacionCalificacion.Calificacion, 2),
        EvaluacionCalificacion.Fecha
   FROM Evaluacion
   JOIN EvaluacionCalificacion ON Evaluacion.Evaluacion=EvaluacionCalificacion.Evaluacion 
  WHERE Evaluacion.Aplica = 'Personal' 
    AND EvaluacionCalificacion.Contacto = @Personal
  ORDER BY EvaluacionCalificacion.Fecha DESC 

RETURN
END
GO

/******* spSWProv_Xcobrar ************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE NAME = 'spSWProv_Xcobrar' and Type = 'P')
  DROP PROCEDURE spSWProv_Xcobrar
GO
CREATE PROCEDURE dbo.spSWProv_Xcobrar
    @Empresa varchar(5),
	@Proveedor varchar(10),    
	@FechaD   Datetime,    
	@FechaA   Datetime    
AS BEGIN 
DECLARE @Tasa FLOAT; 
 SELECT @Tasa = CxPMoratoriosTasa FROM EmpresaCfg WHERE Empresa = @Empresa; 
 SELECT @Tasa = ISNULL(@Tasa, 1.00);

SELECT 
	RTrim(CxPInfo.Mov) Mov, 
	RTrim(CxPInfo.MovID) MovID, 
	(RTrim(CxPInfo.Mov) + ' ' + RTrim(CxPInfo.MovID)) as Movimiento,
	CxPInfo.DiasMoratorios Dias, 
	CxPInfo.Vencimiento, 
	CASE WHEN CxPInfo.DiasMoratorios < 0 THEN 0 ELSE CxPInfo.Saldo * CxPInfo.DiasMoratorios * @Tasa / 100 END Moratorios, 
	CxPInfo.Saldo, 
	RTrim(Moneda) Moneda, 
	Referencia, 
	AnexoXml = (SELECT TOP 1 a.Direccion FROM AnexoMov a WHERE a.Tipo = 'Archivo' AND a.Direccion like '%.xml' AND a.id = CxPInfo.id), 
	AnexoPdf = (SELECT TOP 1 a.Direccion FROM AnexoMov a WHERE a.Tipo = 'Archivo' AND a.Direccion like '%.pdf' AND a.id = CxPInfo.id) 
  FROM CxPInfo 
 WHERE CxPInfo.Empresa = '' AND CxPInfo.Proveedor = @Proveedor AND CxPInfo.Vencimiento between @FechaD AND @FechaA
 ORDER BY Mov ASC

RETURN
END
GO

/************************ spSWCte_Xpagar ***************************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE NAME = 'spSWCte_Xpagar' and Type = 'P')
  DROP PROCEDURE spSWCte_Xpagar
GO
CREATE PROCEDURE dbo.spSWCte_Xpagar
    @Empresa varchar(5),
	@Cliente varchar(10),    
	@FechaD   Datetime,    
	@FechaA   Datetime    
AS BEGIN 
DECLARE @Tasa FLOAT; 
 SELECT @Tasa = CxCMoratoriosTasa FROM EmpresaCfg WHERE Empresa = @Empresa; 
 SELECT @Tasa = ISNULL(@Tasa, 1.00);

SELECT 
	CxcInfo.ID,
	RTrim(CxcInfo.Mov) Mov, 
	RTrim(CxcInfo.MovID) MovID,
	(RTrim(CxcInfo.Mov) + ' ' + RTrim(CxcInfo.MovID)) as Movimiento, 
	CxcInfo.DiasMoratorios Dias, 
	CxcInfo.Saldo, 
	CxcInfo.Vencimiento, 
	CONVERT(char(12), CxcInfo.Vencimiento, 106) FechaVencimiento, 
	CxcInfo.FechaEmision, CONVERT(char(12), CxcInfo.FechaEmision, 106) Emision, 
	CASE WHEN CxcInfo.DiasMoratorios < 0 THEN 0 ELSE CxcInfo.Saldo * CxcInfo.DiasMoratorios * @Tasa / 100 END Moratorios, 
	RTrim(CxcInfo.Moneda) Moneda, 
	CxcInfo.Empresa, 
	CxcInfo.Cliente, 
	CxcInfo.Vencimiento--,
	--CxcInfo.Proyecto,
	--CxcInfo.UEN,
	--CxcInfo.Concepto, 
	--CxcInfo.Referencia,

	--Cxc.TipoCambio,
	--Cxc.Importe,
	--Cxc.Impuestos,
	--Cxc.Condicion,
	--Cxc.FormaCobro,
	--Cxc.Observaciones
  FROM CxcInfo --JOIN Cxc ON CxcInfo.ID = Cxc.ID
 
 WHERE CxcInfo.ID IS NOT NULL AND 
	   CxcInfo.Empresa = @Empresa AND 
	   CxcInfo.Cliente = @Cliente AND 
	   CxcInfo.Vencimiento BETWEEN @FechaD AND @FechaA AND 
	   CxcInfo.Mov NOT IN ('Cobro Posfechado') 
 ORDER BY Dias DESC

RETURN
END
GO

/************************ spVerAuxiliar ***************************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE NAME = 'spVerAuxiliar' and Type = 'P')
  DROP PROCEDURE spVerAuxiliar
GO
CREATE PROCEDURE spVerAuxiliar  
		@Empresa  char(5),  
		@Estacion  int,  
		@Rama  char(5),  
        @Moneda  char(10),  
		@GrupoBase  char(10)  = NULL,  
		@CuentaBase  char(20)  = NULL,  
		@FechaD  datetime  = NULL,  
		@FechaA  datetime  = NULL,  
		@Nivel  char(20)  = 'DIA',      -- Movimiento, Dia, DiaSemana, Semana, Aplicacion  
		@Vista  char(20)  = 'NORMAL',   -- Normal, Detalles  
		@VerGrupo  bit   = 0,  -- Grupo, Cuenta  
		@Totalizar  bit   = 0  
--//WITH ENCRYPTION  
AS BEGIN  
  -- SET nocount ON  
  DECLARE  
     @EsMonetario bit,  
     @EsUnidades bit,  
     @EsResultados bit,  
     @DelEjercicio  int,  
     @AlEjercicio  int,  
     @DelPeriodo    int,   
     @AlPeriodo    int,  
     @CargoInicial  money,  
     @Cargos  money,  
     @AbonoInicial  money,   
     @Abonos  money,  
     @Saldo  money,  
     @Total  money,  
     @CargoInicialU  float,   
     @CargosU  float,  
     @AbonoInicialU float,  
     @AbonosU  float,  
     @TotalU  float,  
  
     @Ok  int  
  
  -- Inicializar Parametros  
  SELECT @Nivel = UPPER(@Nivel), @Vista = UPPER(@Vista), @VerGrupo = ISNULL(@VerGrupo, 0),  
         @CuentaBase = NULLIF(RTRIM(@CuentaBase), ''), @GrupoBase = NULLIF(RTRIM(@GrupoBase), ''),   
         @FechaA = DATEADD(millisecond, -2, DATEADD(day, 1, @FechaA))  
  
  SELECT @EsMonetario  = EsMonetario,  
  @EsUnidades   = EsUnidades,  
  @EsResultados = EsResultados  
    FROM Rama   
   WHERE Rama = @Rama  
  
  
  DELETE VerAux WHERE Estacion = @Estacion  
  SELECT @CargoInicial  = 0, @AbonoInicial  = 0.0,  
         @CargoInicialU = 0, @AbonoInicialU = 0  
  
  EXEC spPeriodoEjercicio @Empresa, @Rama, @FechaD, @DelPeriodo OUTPUT, @DelEjercicio OUTPUT, @Ok OUTPUT  
  EXEC spPeriodoEjercicio @Empresa, @Rama, @FechaA, @AlPeriodo  OUTPUT, @AlEjercicio  OUTPUT, @Ok OUTPUT  
  
  IF @DelEjercicio <> @AlEjercicio SELECT @DelPeriodo = 0, @AlPeriodo = 9999  
  
  EXEC spSaldoInicial  @Empresa, @Rama, @Moneda, @GrupoBase, @CuentaBase, NULL, @FechaD, @EsMonetario, @EsUnidades, @EsResultados,   
                       @CargoInicial OUTPUT, @AbonoInicial OUTPUT, @CargoInicialU OUTPUT, @AbonoInicialU OUTPUT, @Ok OUTPUT  
  
  IF @CargoInicial <> 0 OR @AbonoInicial <> 0  
    INSERT VerAux (Estacion, Fecha, Mov, Cargo, Abono, Saldo, CargoU, AbonoU)   
           VALUES (@Estacion, DATEADD(day, -1, @FechaD), 'Saldo Inicial', @CargoInicial, @AbonoInicial, (@CargoInicial-@AbonoInicial), @CargoInicialU, @AbonoInicialU)  
  
  IF @Rama = 'CONT'  
    EXEC spVerAuxCont @Empresa, @Estacion, @CuentaBase, @DelEjercicio, @AlEjercicio, @DelPeriodo, @AlPeriodo, @FechaD, @FechaA, @Nivel, @Moneda  
  
  ELSE  
  IF @Rama = 'CC'  
    EXEC spVerAuxCC @Empresa, @Estacion, @CuentaBase, @DelEjercicio, @AlEjercicio, @DelPeriodo, @AlPeriodo, @FechaD, @FechaA, @Nivel  
  
  IF @Rama = 'CC2'  
    EXEC spVerAuxCC2 @Empresa, @Estacion, @CuentaBase, @DelEjercicio, @AlEjercicio, @DelPeriodo, @AlPeriodo, @FechaD, @FechaA, @Nivel  
  
  IF @Rama = 'CC3'  
    EXEC spVerAuxCC3 @Empresa, @Estacion, @CuentaBase, @DelEjercicio, @AlEjercicio, @DelPeriodo, @AlPeriodo, @FechaD, @FechaA, @Nivel  
   
  IF @EsUnidades = 0 AND @EsResultados = 0  
    EXEC spVerAux @Empresa, @Estacion, @Rama, @Moneda, @GrupoBase, @CuentaBase, @DelEjercicio, @AlEjercicio, @DelPeriodo, @AlPeriodo, @FechaD, @FechaA, @Nivel  
   
  ELSE  
  IF @EsUnidades = 0 AND @EsResultados = 1   
    EXEC spVerAuxR @Empresa, @Estacion, @Rama, @Moneda, @GrupoBase, @CuentaBase, @DelEjercicio, @AlEjercicio, @DelPeriodo, @AlPeriodo, @FechaD, @FechaA, @Nivel  
  
  ELSE  
  IF @EsUnidades = 1 AND @EsResultados = 0  
    EXEC spVerAuxU @Empresa, @Estacion, @Rama, @Moneda, @GrupoBase, @CuentaBase, @DelEjercicio, @AlEjercicio, @DelPeriodo, @AlPeriodo, @FechaD, @FechaA, @Nivel  
  
  ELSE  
  IF @EsUnidades = 1 AND @EsResultados = 1  
    EXEC spVerAuxRU @Empresa, @Estacion, @Rama, @Moneda, @GrupoBase, @CuentaBase, @DelEjercicio, @AlEjercicio, @DelPeriodo, @AlPeriodo, @FechaD, @FechaA, @Nivel  
   
  IF @Nivel = 'APLICACION'  
  BEGIN  
    IF @Rama IN ('CXC','CXP')   
    BEGIN  
      IF @Rama = 'CXC'   
        UPDATE VerAux   
           SET VerAux.Saldo = CASE   
                                WHEN VerAux.Abono IS NOT NULL THEN -Cxc.Saldo   
                                ELSE Cxc.Saldo  
                              END  
          FROM VerAux, Cxc   
         WHERE Cxc.ID = VerAux.ModuloID   
           AND Cxc.Estatus = 'PENDIENTE'   
           AND VerAux.Mov = VerAux.Aplica   
           AND VerAux.MovID = VerAux.AplicaID   
      ELSE  
      IF @Rama = 'CXP'   
        UPDATE VerAux   
           SET VerAux.Saldo = CASE   
                                WHEN VerAux.Abono IS NOT NULL THEN -Cxp.Saldo   
                                ELSE Cxp.Saldo  
                              END  
          FROM VerAux, Cxp  
         WHERE Cxp.ID = VerAux.ModuloID   
           AND Cxp.Estatus = 'PENDIENTE'   
           AND VerAux.Mov = VerAux.Aplica   
           AND VerAux.MovID = VerAux.AplicaID   
  
      SELECT @Cargos  = SUM(Cargo),  
             @Abonos  = SUM(Abono),  
             @Saldo   = SUM(Saldo),  
             @CargosU = SUM(CargoU),  
             @AbonosU = SUM(AbonoU)  
        FROM VerAux  
       WHERE Estacion = @Estacion   
    END  
    SELECT ID,  
       Fecha,  
       Orden,  
       Estacion,  
       Grupo,  
       SubCuenta,  
    Ejercicio,  
    Periodo,  
    Modulo,  
    ModuloID,  
    Mov,  
    MovID,  
    (RTrim(Mov) + ' ' + RTrim(MovID)) as Movimiento,
    Aplica,  
    AplicaID,  
    Concepto,  
    Referencia,  
    Cargo,  
    Abono,  
    Saldo,  
    Total,  
    CargoU,  
    AbonoU,  
    TotalU  
      FROM VerAux WHERE Estacion = @Estacion  
    UNION  
    SELECT "ID"  = NULL,  
       "Fecha" = @FechaA,  
           "Orden"      = 2147483647,  
       "Estacion" = @Estacion,  
       "Grupo" = NULL,  
       "SubCuenta" = NULL,  
       "Ejercicio" = NULL,  
       "Periodo" = 999,  
           "Modulo" = NULL,  
       "ModuloID" = NULL,  
       "Mov" = NULL,  
       "MovID" = NULL,  
       "Movimiento"=NULL,
       "Aplica" = 'zz',  
       "AplicaID" = NULL,  
       "Concepto" = NULL,  
       "Referencia" = NULL,  
       "Cargo" = ISNULL(@Cargos, 0.0),  
       "Abono" = ISNULL(@Abonos, 0.0),  
       "Saldo" = ISNULL(@Cargos, 0.0) - ISNULL(@Abonos, 0.0),  
       "Total" = NULL,  
       "CargoU" = NULL,  
       "AbonoU" = NULL,  
       "TotalU" = NULL  
     ORDER BY Estacion, Aplica, AplicaID, Fecha, ModuloID  
  END ELSE   
  BEGIN  
    SELECT @Total  = 0.0, @Cargos  = 0.0, @Abonos  = 0.0,  
           @TotalU = 0,   @CargosU = 0.0, @AbonosU = 0.0  
  
    UPDATE VerAux  
       SET @Cargos  = @Cargos  + ISNULL(Cargo, 0.0),  
           @Abonos  = @Abonos  + ISNULL(Abono, 0.0),  
           @Total   = Total    = @Total  + ISNULL(Cargo, 0.0) - ISNULL(Abono, 0.0),   
    @CargosU = @CargosU + ISNULL(CargoU, 0.0),  
           @AbonosU = @AbonosU + ISNULL(AbonoU, 0.0),  
           @TotalU  = TotalU   = @TotalU + ISNULL(CargoU, 0.0) - ISNULL(AbonoU, 0.0)   
     WHERE Estacion = @Estacion  
  
    INSERT VerAux (Estacion, Orden, Periodo, Fecha, Cargo, Abono, Total, CargoU, AbonoU, TotalU) VALUES (@Estacion, 2147483647, 999, @FechaA, @Cargos, @Abonos, @Total, @CargosU, @AbonosU, @TotalU)  
  
    SELECT * FROM VerAux WHERE Estacion = @Estacion ORDER BY Estacion, Fecha, Orden, ID   
  END  
  RETURN  
END  
GO

/************************ spSWCte_MovArt ***************************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE NAME = 'spSWCte_MovArt' and Type = 'P')
  DROP PROCEDURE spSWCte_MovArt
GO
CREATE PROCEDURE dbo.spSWCte_MovArt
    @Empresa varchar(5),
	@Cliente varchar(10),    
	@FechaD   Datetime,    
	@FechaA   Datetime    
AS BEGIN 
 SELECT 
	VentaUtilD.MovClave,
	Art.Articulo,
	Art.Categoria,
	Art.Familia,
	Art.Grupo,
	Art.Linea,
	Art.Fabricante,
	VentaUtilD.Moneda,
	VentaUtilD.DescuentoGlobal,
	CASE VentaUtilD.MovClave 
		WHEN 'CXC.NC' THEN SUM(VentaUtilD.Cantidad *-1) 
		WHEN 'CXC.NCD' THEN SUM(VentaUtilD.Cantidad *-1) 
		WHEN 'VTAS.D'  THEN SUM(VentaUtilD.Cantidad *-1) 
		WHEN 'VTAS.F'  THEN SUM(VentaUtilD.Cantidad) 
		WHEN 'VTAS.B'  THEN SUM(VentaUtilD.Cantidad *-1) 
		WHEN 'CXC.DV'   THEN SUM(VentaUtilD.Cantidad *-1) 
	END Cantidad, 
	CASE VentaUtilD.MovClave 
		WHEN 'CXC.NC'  THEN SUM(VentaUtilD.Importe *-1) 
		WHEN 'CXC.NCD' THEN SUM(VentaUtilD.Importe *-1) 
		WHEN 'VTAS.D'  THEN SUM(VentaUtilD.Importe *-1) 
		WHEN 'VTAS.F'  THEN SUM(VentaUtilD.Importe) 
		WHEN 'VTAS.B'  THEN SUM(VentaUtilD.Importe *-1) 
		WHEN 'CXC.DV'   THEN SUM(VentaUtilD.Importe *-1) 
	END Saldo,VentaUtilD.Cliente
	FROM Art WITH(NOLOCK, INDEX(priArt)) JOIN VentaUtilD WITH(NOLOCK) ON Art.Articulo = VentaUtilD.Articulo
	WHERE 
	Importe IS NOT NULL 
	AND VentaUtilD.Empresa = @Empresa
	AND VentaUtilD.Cliente = @Cliente
	AND VentaUtilD.FechaEmision BETWEEN @FechaD AND @FechaA
	GROUP BY VentaUtilD.Mov, Art.Articulo, Art.Familia, Art.Categoria, Art.Grupo, Art.Linea, Art.Fabricante, VentaUtilD.Moneda, VentaUtilD.MovClave, VentaUtilD.DescuentoGlobal, VentaUtilD.Cliente
	ORDER BY Mov ASC

RETURN
END
GO

/***************** spWebRecursosActuales *****************/
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('spWebRecursosActuales'))
  DROP PROCEDURE spWebRecursosActuales
GO
CREATE PROCEDURE spWebRecursosActuales
AS BEGIN
  SELECT Recurso, Nombre
    FROM Recurso 
   WHERE Estatus = 'ALTA'
         AND Nombre Is NOT NULL AND Nombre <> ''
   ORDER BY Nombre

RETURN
END
GO

/********** spSWCte_AltaAtenRep *********/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE NAME = 'spSWCte_AltaAtenRep' and Type = 'P')
  DROP PROCEDURE spSWCte_AltaAtenRep
GO
CREATE PROCEDURE spSWCte_AltaAtenRep 
 @Cliente		char(10),  
 @Empresa		char(5),  
 @Recurso		varchar(10),  
 @Prioridad		char(10),
 @Mov			char(20),  
 @Comentarios	varchar(50) = NULL  
--WITH ENCRYPTION  
AS BEGIN  
 DECLARE   
  @Usuario		  char(10),  
  @Observaciones  varchar(100),  
  @Contacto		  varchar(50),  
  @Agente		  char(10),  
  @Telefono		  varchar(30),  
  @Extencion      varchar(10),  
  @Fax			  varchar(30),  
  @SucursalCte    int,  
  @eMail		  varchar(30),  
  @Proyecto       varchar(50)  
  
 SELECT @Usuario = Usuario, @Observaciones = @Observaciones  
   FROM Recurso   
  WHERE Recurso = @Recurso
  
 SELECT @Usuario = ISNULL(@Usuario, @Cliente)
  
 SELECT   
  @Contacto		= NULLIF(RTrim(Contacto1), ''),   
  @Agente		= NULLIF(RTrim(Agente), ''),   
  @Telefono		= NULLIF(RTrim(SUBSTRING(Telefonos, 1, 30)), ''),   
  @Extencion	= NULLIF(RTrim(Extencion1), ''),   
  @Fax			= NULLIF(RTrim(SUBSTRING(Fax, 1, 30)), ''),   
  @SucursalCte	= RTRIM(EnviarA),   
  @eMail		= NULLIF(RTrim(SUBSTRING(eMail1, 1, 30)), ''),   
  @Proyecto		= NULLIF(RTrim(Proyecto), '')   
   FROM Cte   
  WHERE Cliente = @Cliente  
  
 SET NOCOUNT ON   
 INSERT INTO Soporte (  
  Empresa, Usuario,  UsuarioResponsable, FechaEmision, UltimoCambio, Cliente,  EnviarA,   
  Proyecto, Contacto,  Telefono,   Extencion,  Fax,   eMail,   Agente,   
  Titulo,  Observaciones, Referencia,   Prioridad,  Mov,   Version,  Problema,  Comentarios,   
  SubModulo, Estatus,  Estado,    Sucursal,  SucursalOrigen, TieneContrato, PuedeDevolver, GenerarPoliza)   
 VALUES (  
  @Empresa, @Usuario, @Usuario, dbo.fnFechaSinHora(GETDATE()),  GETDATE(),  @Cliente,  @SucursalCte,   
  @Proyecto, @Contacto,  @Telefono,   @Extencion,  @Fax,   @Email,   @Agente,   
  @Mov, @Observaciones, '',     NULLIF(@Prioridad,''),    @Mov,   0,  NULL, CAST(@Comentarios + CASE WHEN @Usuario IS NULL THEN ' - SIN USUARIO, Cliente: ' + @Cliente ELSE '' END AS TEXT),   
  'ST',  'SINAFECTAR', 'No comenzado',  0,    0,    0,    0,    0)
 SET NOCOUNT OFF  
  
 SELECT @@IDENTITY AS NewID   

RETURN
END  
GO

/************* spSWProv_Xcobrar ********/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE NAME = 'spSWProv_Xcobrar' and Type = 'P')
  DROP PROCEDURE spSWProv_Xcobrar
GO
CREATE PROCEDURE dbo.spSWProv_Xcobrar
    @Empresa   varchar(5),
	@Proveedor varchar(10),    
	@FechaD    datetime,    
	@FechaA    datetime    
AS BEGIN 
DECLARE @Tasa float
 SELECT @Tasa = CxPMoratoriosTasa FROM EmpresaCfg WHERE Empresa = @Empresa; 
 SELECT @Tasa = ISNULL(@Tasa, 1.00);

SELECT 
	RTrim(CxPInfo.ID) ID,
	RTrim(CxPInfo.Mov) Mov, 
	RTrim(CxPInfo.MovID) MovID, 
	(RTrim(CxPInfo.Mov) + ' ' + RTrim(CxPInfo.MovID)) as Movimiento,
	CxPInfo.DiasMoratorios Dias, 
	CxPInfo.Vencimiento, 
	CASE WHEN CxPInfo.DiasMoratorios < 0 THEN 0 ELSE CxPInfo.Saldo * CxPInfo.DiasMoratorios * @Tasa / 100 END Moratorios, 
	CxPInfo.Saldo, 
	RTrim(Moneda) Moneda, 
	Referencia, 
	AnexoXml = (SELECT TOP 1 a.Direccion FROM AnexoMov a WHERE a.Tipo = 'Archivo' AND a.Direccion like '%.xml' AND a.id = CxPInfo.id), 
	AnexoPdf = (SELECT TOP 1 a.Direccion FROM AnexoMov a WHERE a.Tipo = 'Archivo' AND a.Direccion like '%.pdf' AND a.id = CxPInfo.id) 
  FROM CxPInfo 
 WHERE CxPInfo.Empresa = @Empresa AND CxPInfo.Proveedor = @Proveedor AND CxPInfo.Vencimiento between @FechaD AND @FechaA
 ORDER BY Mov ASC

RETURN
END
GO


/********************* spWebLevantarSugerenciaProv *********************************/
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[spWebLevantarSugerenciaProv]'))
	DROP PROCEDURE [dbo].[spWebLevantarSugerenciaProv]
GO

CREATE PROCEDURE spWebLevantarSugerenciaProv
	@Empresa		char(5),
	@Usuario		char(10),
	@FechaHoy		datetime,
	@User			char(10),
	@Proyecto		varchar(50),
	@Contacto		varchar(50),
	@Telefono		varchar(30),
	@Extencion		varchar(10),
	@Fax			varchar(30),
	@eMail			varchar(30),
	@Agente			char(10),
	@Comentarios 	varchar(4192)
AS BEGIN
	SET NOCOUNT ON 

	INSERT INTO Soporte (Empresa, Usuario, UsuarioResponsable, FechaEmision, UltimoCambio, Vencimiento, Proveedor, Proyecto, 
	Contacto, Telefono, Extencion, Fax, eMail, Agente, Comentarios, Titulo, Problema, Solucion, 
	Mov, SubModulo, Estatus, Estado, Sucursal, SucursalOrigen, TieneContrato, PuedeDevolver, GenerarPoliza) 

	VALUES(@Empresa, @Usuario, @Usuario, @FechaHoy, @FechaHoy, @FechaHoy, @User, @Proyecto, 
	@Contacto, @Telefono, @Extencion, @Fax, @Email, @Agente, @Comentarios, 
	'Sugerencia', '', '', 'Sugerencia', 'STPRO', 'SINAFECTAR', 'No comenzado', 0, 0, 0, 0, 0) 

	SELECT @@IDENTITY AS NewID 

RETURN
END
GO

/********************* spWebLevantarQuejaProv *********************************/
IF EXISTS(SELECT * FROM SysObjects WHERE Name = 'spWebLevantarQuejaProv' AND TYPE = 'P')
	DROP PROCEDURE spWebLevantarQuejaProv
GO

CREATE PROCEDURE spWebLevantarQuejaProv 
	@Empresa		char(5),
	@Usuario		char(10),
	@FechaHoy		datetime,
	@User			char(10),
	@Proyecto		varchar(50),
	@Contacto		varchar(50),
	@Telefono		varchar(30),
	@Extencion		varchar(10),
	@Fax			varchar(30),
	@eMail			varchar(30),
	@Agente			char(10),
	@Titulo 		varchar(100),
	@Comentarios 	varchar(4192),	
	@Observaciones 	varchar(100),
	@Referencia 	varchar(50),
	@Prioridad 		char(10)
AS BEGIN
	SET NOCOUNT ON
	 
	INSERT INTO Soporte 
	(Empresa, Usuario, UsuarioResponsable, FechaEmision, UltimoCambio, Vencimiento, Proveedor, Proyecto, Contacto, 
	Telefono, Extencion, Fax, eMail, Agente, Titulo, Comentarios, Observaciones, Referencia, Prioridad, Problema, Solucion, 
	Mov, SubModulo, Estatus, Estado, Sucursal, SucursalOrigen, TieneContrato, PuedeDevolver, GenerarPoliza) 
	VALUES(@Empresa, @Usuario, @Usuario, @FechaHoy, @FechaHoy, @FechaHoy, @User, @Proyecto, 
	@Contacto, @Telefono, @Extencion, @Fax, @Email, @Agente, @Titulo, @Comentarios, 
	@Observaciones, @Referencia, @Prioridad, '', '',
	'Queja', 'STPRO', 'SINAFECTAR', 'No comenzado', 0, 0, 0, 0, 0) 

	SELECT @@IDENTITY AS NewID 

RETURN
END
GO


/********************* spWebLevantarQuejaProv *********************************/
IF EXISTS(SELECT * FROM SysObjects WHERE Name = 'spWebLevantarQuejaProv' AND TYPE = 'P')
	DROP PROCEDURE spWebLevantarQuejaProv
GO
CREATE PROCEDURE spWebLevantarQuejaProv 
	@Empresa		char(5),
	@Usuario		char(10),
	@FechaHoy		DATETIME,
	@User			CHAR(10),
	@Proyecto		VARCHAR(50),
	@Contacto		VARCHAR(50),
	@Telefono		VARCHAR(30),
	@Extencion		VARCHAR(10),
	@Fax			VARCHAR(30),
	@eMail			VARCHAR(30),
	@Agente			CHAR(10),
	@Titulo 		VARCHAR(100),
	@Comentarios 		VARCHAR(4192),	
	@Observaciones 		VARCHAR(100),
	@Referencia 		VARCHAR(50),
	@Prioridad 		CHAR(10)

AS BEGIN
	SET NOCOUNT ON
	 
	INSERT INTO Soporte 
	(Empresa, Usuario, UsuarioResponsable, FechaEmision, UltimoCambio, Vencimiento, Proveedor, Proyecto, Contacto, 
	Telefono, Extencion, Fax, eMail, Agente, Titulo, Comentarios, Observaciones, Referencia, Prioridad, Problema, Solucion, 
	Mov, SubModulo, Estatus, Estado, Sucursal, SucursalOrigen, TieneContrato, PuedeDevolver, GenerarPoliza) 
	VALUES(@Empresa, @Usuario, @Usuario, @FechaHoy, @FechaHoy, @FechaHoy, @User, @Proyecto, 
	@Contacto, @Telefono, @Extencion, @Fax, @Email, @Agente, @Titulo, @Comentarios, 
	@Observaciones, @Referencia, @Prioridad, '', '',
	'Queja', 'STPRO', 'SINAFECTAR', 'No comenzado', 0, 0, 0, 0, 0) 

	SELECT @@IDENTITY AS NewID 

RETURN
END
GO

/*************** spWebLevantarMinutaProv ***********************/
IF EXISTS(SELECT * FROM SysObjects WHERE Name = 'spWebLevantarMinutaProv' AND TYPE = 'P')
	DROP PROCEDURE spWebLevantarMinutaProv
GO
CREATE PROCEDURE spWebLevantarMinutaProv 
	@Empresa		char(5),
	@Usuario		char(10),
	@FechaHoy		DATETIME,
	@User			CHAR(10),
	@Proyecto		VARCHAR(50),
	@Contacto		VARCHAR(50),
	@Telefono		VARCHAR(30),
	@Extencion		VARCHAR(10),
	@Fax			VARCHAR(30),
	@eMail			VARCHAR(30),
	@Agente			CHAR(10),
	@Titulo 		VARCHAR(100),
	@Comentarios 		TEXT,	
	@Observaciones 		VARCHAR(100),
	@Referencia 		VARCHAR(50),
	@Prioridad 		CHAR(10)

AS BEGIN
	SET NOCOUNT ON 

	INSERT INTO Soporte 
	(Empresa, Usuario, UsuarioResponsable, FechaEmision, UltimoCambio, Vencimiento, Proveedor, Proyecto, Contacto, 
	Telefono, Extencion, Fax, eMail, Agente, Titulo, Comentarios, Observaciones, Referencia, Prioridad, Problema, Solucion, 
	Mov, SubModulo, Estatus, Estado, Sucursal, SucursalOrigen, TieneContrato, PuedeDevolver, GenerarPoliza) 
	VALUES(@Empresa, @Usuario, @Usuario, @FechaHoy, @FechaHoy, @FechaHoy, @User, @Proyecto, 
	@Contacto, @Telefono, @Extencion, @Fax, @eMail, @Agente, @Titulo, @Comentarios, @Observaciones, 
	@Referencia, @Prioridad, 
	'', '', 'Minuta', 'STPRO', 'SINAFECTAR', 'No comenzado', 0, 0, 0, 0, 0) 

	SELECT @@IDENTITY AS NewID 

RETURN
END
GO

/***************** spSWProv_VerRep ******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spSWProv_VerRep') AND type = 'P') 
 DROP PROCEDURE dbo.spSWProv_VerRep
GO 
CREATE PROCEDURE dbo.spSWProv_VerRep 
	@Proveedor		VARCHAR(10),
	@Empresa		VARCHAR(5),
	@Estatus		VARCHAR(15),
	@FechaIni 		date,
	@FechaFin 		date
AS BEGIN
SET NOCOUNT ON

	SELECT ID, RTrim(Mov) + isnull(' ' + RTrim(MovID), '') as Titulo, Submodulo,  Proveedor, Mov, MovID , Estatus, FechaEmision, FechaInicio, FechaConclusion, Empresa 
	  FROM Soporte 
	 WHERE Proveedor = @Proveedor AND Empresa = @Empresa AND  FechaEmision BETWEEN @FechaIni AND @FechaFin 
	   AND Estatus = CASE WHEN ISNULL(@Estatus, '') = '' THEN Estatus ELSE @Estatus END
	 ORDER BY ID

SET NOCOUNT OFF

RETURN
END
GO


/********* spVWSWProv_ComPendientes ********/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spVWSWProv_ComPendientes') AND type = 'P') 
  DROP PROCEDURE dbo.spVWSWProv_ComPendientes
GO 
CREATE PROCEDURE dbo.spVWSWProv_ComPendientes
	@Proveedor  varchar(10),
	@Empresa	varchar(5),
	@FechaD		datetime,
	@FechaA		datetime
AS BEGIN
	SELECT Mov, MovID,(RTrim(Mov) + ' ' + RTrim(MovID)) as Movimiento,FechaEmision,SubTotal,Impuestos,Saldo,Total,Moneda,Referencia,Empresa,Proveedor
	  FROM vwSWProv_ComPendientes
	 WHERE Proveedor = @Proveedor AND Empresa = @Empresa AND FechaEmision BETWEEN @fechaD AND @fechaA

RETURN
END
GO


/************** spSWMovSoporte ****************/
IF EXISTS(SELECT * FROM SysObjects WHERE Name = 'spSWMovSoporte' AND TYPE = 'P')
	DROP PROCEDURE spSWMovSoporte
GO
CREATE PROCEDURE spSWMovSoporte 
AS BEGIN

	SELECT Mov FROM MovTipo WHERE ConsecutivoModulo = 'ST' ORDER BY Orden

RETURN
END
GO


/**************** spSWProv_AltaRep *************/
IF EXISTS(SELECT * FROM SysObjects WHERE Name = 'spSWProv_AltaRep' AND TYPE = 'P')
	DROP PROCEDURE spSWProv_AltaRep
GO
CREATE PROCEDURE spSWProv_AltaRep
	@Empresa		VARCHAR(5),
	@Proveedor		VARCHAR(10),
	@Mov 			VARCHAR(100),
	@Prioridad 		CHAR(10),
	@Recurso		VARCHAR(10),
	@Comentarios 	VARCHAR(MAX)
AS BEGIN
	
	DECLARE 	
		@Usuario		VARCHAR(10),
		@UsuarioResp	VARCHAR(10),
		@Contacto		VARCHAR(50),
		@Telefono		VARCHAR(30),
		@Extencion		VARCHAR(10),
		@Fax			VARCHAR(30),
		@eMail			VARCHAR(30),
		@Agente			CHAR(10),
		@Proyecto		VARCHAR(50)

	SELECT	@Usuario = NULLIF(Usuario, ''), @UsuarioResp = Usuario
	  FROM	Recurso 
	 WHERE	Recurso = @Recurso

	SELECT	@Usuario = ISNULL(@Usuario, @Proveedor), @UsuarioResp = ISNULL(@UsuarioResp, @Recurso)
			 
    SET NOCOUNT ON
	INSERT INTO Soporte (
		Empresa,	Usuario,	UsuarioResponsable,	FechaEmision,	UltimoCambio,	Vencimiento, 
		Proveedor,	Proyecto,	Contacto,			Telefono,		Extencion,		Fax,			eMail,			Agente, 
		Titulo,		Comentarios,					Observaciones,	Referencia,		Prioridad,		Problema,		Solucion, 
		Mov,		SubModulo,	Estatus,			Estado,			Sucursal,		SucursalOrigen,	TieneContrato,	PuedeDevolver,	GenerarPoliza) 
	VALUES(
		@Empresa,	@Usuario,	@UsuarioResp,		dbo.fnFechaSinHora(GETDATE()),	GETDATE(),		dbo.fnFechaSinHora(GETDATE()), 
		@Proveedor,	@Proyecto,	@Contacto,			@Telefono,		@Extencion,		@Fax,			@Email,			@Agente,
		@Mov,		CAST(@Comentarios AS TEXT),		@Comentarios,	@Recurso,		@Prioridad,		'',				'',
		@Mov,		'STPRO',	'SINAFECTAR',		'No Comenzado', 0,				0,				0,				0,				0) 
    SET NOCOUNT OFF

	SELECT @@IDENTITY AS NewID 

RETURN
END
GO

/******************************************************************************************** Venta Asistida ********************************************************************************************/
/****** spAPIArtAnexo ******/
IF EXISTS(SELECT name FROM sysobjects where name ='spAPIArtAnexo' and type ='P')
	DROP PROCEDURE dbo.spAPIArtAnexo
GO
CREATE procedure dbo.spAPIArtAnexo
	@Cuenta		varchar(max),
	@IDR		varchar(max),
	@name		varchar(max),
	@extension	varchar(max),
	@mimeType	varchar(max),
	@Usuario	varchar(max)
AS BEGIN
	DECLARE @NomArch	varchar(255),
			@finalPath	varchar(MAX),
			@finalName	varchar(255),
			@Tipo		varchar(10),
			@icono	    int,
			@maxOrder	int

	SET @finalPath = 'C:\Temp\'
	SET @NomArch = @finalPath + @name
	SET @finalName = LEFT(REPLACE(@name, @extension, ''), LEN(REPLACE(@name, @extension, ''))-1)
	
	IF (LOWER(@extension) IN  ('png', 'jpg', 'bmp', 'gif'))
		SELECT @icono = 59, @Tipo = 'Imagen'
	IF (LOWER(@extension) IN  ('pdf'))
		SELECT @icono = 745, @Tipo = 'Archivo'
	IF (LOWER(@extension) IN  ('doc', 'docx'))
		SELECT @icono = 738, @Tipo = 'Archivo'
	IF (LOWER(@extension) IN  ('xls', 'xlsx'))
		SELECT @icono = 733, @Tipo = 'Archivo'
	--IF (LOWER(@Ext) IN  ('ppt', 'pptx'))
		--SELECT @icono = 053, @Tipo = 'Archivo'

	SELECT @maxOrder = MAX(Orden) FROM AnexoCta WHERE Rama = 'INV' AND Cuenta = @Cuenta
	SET @maxOrder = ISNULL(@maxOrder, 0);
	SET @maxOrder = @maxOrder + 1

	SELECT * FROM AnexoCta WHERE Rama = 'INV' AND Cuenta = @Cuenta

	SELECT 'INV', @Cuenta,	@IDR,	@finalName,	@Tipo,	@NomArch,	@icono,	@maxOrder,	GETDATE(),	GETDATE(),		@Usuario

	SELECT '' Ok, '' OkRef

RETURN
END
GO
/*************************************************Opciones Usuario Intelisis***********************************************/

-- Alta de Opciones --
-- Usuario Intelisis --
DECLARE @SET_IDUsuarioTipo INT
SET @SET_IDUsuarioTipo = 1

DECLARE @SET_IDRole INT
 SELECT @SET_IDRole = IDRole
   FROM dbo.pNetRole 
  WHERE IDUsuarioTipo = @SET_IDUsuarioTipo AND Descripcion = 'Administrador'

IF (@SET_IDRole IS NULL)
BEGIN
	INSERT INTO dbo.pNetRole (IDUsuarioTipo, Descripcion)
	SELECT @SET_IDUsuarioTipo, 'Administrador'
	SELECT @SET_IDRole = SCOPE_IDENTITY();
END

-- Datos Personales --
EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, @IconParent  = 'fa fa-cog', 
	@IDPermisoParent = 68, @DescripcionParent  = 'Configurar Módulos',
	@IDPermiso  = 69, @Descripcion  = 'Soporte', @RutaPNet  = 'CfgSoporte'


-- Configuación Empresas --
EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, @IconParent  = 'fa fa-cog', 
	@IDPermisoParent = 102, @DescripcionParent  = 'Configurar',
	@IDPermiso  = 103, @Descripcion  = 'Empresas', @RutaPNet  = 'configuracion'
GO

/*************************************************Opciones Usuario Personal***********************************************/
-- Usuario Personal --
DECLARE @SET_IDUsuarioTipo int
SET @SET_IDUsuarioTipo = 2

DECLARE @SET_IDRole int
SELECT @SET_IDRole = IDRole
  FROM dbo.pNetRole 
 WHERE IDUsuarioTipo = @SET_IDUsuarioTipo AND Descripcion = 'SW'

IF (@SET_IDRole IS NULL)
BEGIN
	INSERT INTO dbo.pNetRole (IDUsuarioTipo, Descripcion)
	SELECT @SET_IDUsuarioTipo, 'SW'
	SELECT @SET_IDRole = SCOPE_IDENTITY();
END

-- Datos Personales --
EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, @IconParent  = 'fa fa-bookmark-o', 
	@IDPermisoParent = 35, @DescripcionParent  = 'Información de Personal',
	@IDPermiso  = 36, @Descripcion  = 'Datos Personales', @RutaPNet  = 'swPersonal_Info'

---- Asistencia y Retardos --
EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, @IconParent  = 'fa fa-bookmark-o', 
	@IDPermisoParent = 35, @DescripcionParent  = 'Información de Personal',
	@IDPermiso  = 37, @Descripcion  = 'Asistencia y Retardos', @RutaPNet  = 'swPersonal_AsisRet'

-- Reportes de Nómina --
EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, @IconParent  = 'fa fa-bookmark-o', 
	@IDPermisoParent = 35, @DescripcionParent  = 'Información de Personal',
	@IDPermiso  = 40, @Descripcion  = 'Recibos de Nómina', @RutaPNet  = 'swPersonal_Nomina'

-- Consultar Solicitudes de Permisos --
EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, @IconParent  = 'fa fa-bookmark-o', 
	@IDPermisoParent = 41, @DescripcionParent  = 'Atención al Personal',
	@IDPermiso  = 42, @Descripcion  = 'Consultar Solicitudes de Permisos', @RutaPNet  = 'swPersonal_ConsultaSol'

-- Registrar Solicitudes de Permisos --
EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, @IconParent  = 'fa fa-bookmark-o', 
	@IDPermisoParent = 41, @DescripcionParent  = 'Atención al Personal',
	@IDPermiso  = 43, @Descripcion  = 'Registrar Solicitudes de Permiso', @RutaPNet  = 'swPersonal_RegistroSol'

EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, @IconParent  = 'fa fa-bookmark-o', 
	@IDPermisoParent = 35, @DescripcionParent  = 'Información de Personal',
	@IDPermiso  = 94, @Descripcion  = 'Firmar Recibos de Nómina', @RutaPNet  = 'swPersonal_NominaFirmar'

GO
-- Borrar Permiso de Consulta Recibos Nómina
DECLARE
 @IDRole int
 
SELECT @IDRole = MIN(IDRole) FROM pNetRole WHERE IDUsuarioTipo = 2 AND Descripcion = 'SW'
WHILE @IDRole IS NOT NULL
BEGIN 
 DELETE FROM pNetRolePermiso WHERE IDRole = @IDRole AND IDPermiso = 40
 SELECT @IDRole = MIN(IDRole) FROM pNetRole WHERE IDUsuarioTipo = 2 AND Descripcion = 'SW' AND IDRole > @IDRole
END
GO

-- ROL GERENTE--
DECLARE @SET_IDUsuarioTipo int
SET @SET_IDUsuarioTipo = 2

DECLARE @SET_IDRole int
SELECT @SET_IDRole = IDRole
  FROM dbo.pNetRole 
 WHERE IDUsuarioTipo = @SET_IDUsuarioTipo AND Descripcion = 'Gerente'
IF (@SET_IDRole IS NULL)
BEGIN
	INSERT INTO dbo.pNetRole (IDUsuarioTipo, Descripcion)
	SELECT @SET_IDUsuarioTipo, 'Gerente'
	SELECT @SET_IDRole = SCOPE_IDENTITY();
END

EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, @IconParent  = 'fa fa-bookmark-o', 
	@IDPermisoParent = 35, @DescripcionParent  = 'Información de Personal',
	@IDPermiso  = 104, @Descripcion  = 'Asistencia y Retardos', @RutaPNet  = 'swPersonal_AsisRetGte'
GO

/*************************************************Opciones Usuario Cliente***********************************************/
-- Usuario Cliente --
DECLARE @SET_IDUsuarioTipo int
SET @SET_IDUsuarioTipo = 3

DECLARE @SET_IDRole int
SELECT @SET_IDRole = IDRole
  FROM dbo.pNetRole 
 WHERE IDUsuarioTipo = @SET_IDUsuarioTipo AND Descripcion = 'SW'

IF (@SET_IDRole IS NULL)
BEGIN
	INSERT INTO dbo.pNetRole (IDUsuarioTipo, Descripcion)
	SELECT @SET_IDUsuarioTipo, 'SW'
	SELECT @SET_IDRole = SCOPE_IDENTITY();
END

-- Por Pagar --
EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, @IconParent  = 'fa fa-bookmark-o', 
	@IDPermisoParent = 53, @DescripcionParent  = 'Información del Cliente',
	@IDPermiso  = 54, @Descripcion  = 'Por Pagar', @RutaPNet  = 'swCte_Xpagar'

-- Estado de Cuenta --
EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, @IconParent  = 'fa fa-bookmark-o', 
	@IDPermisoParent = 53, @DescripcionParent  = 'Información del Cliente',
	@IDPermiso  = 55, @Descripcion  = 'Estado de Cuenta', @RutaPNet  = 'swCte_EdoCuenta'

-- Pagos Posfechados --
EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, @IconParent  = 'fa fa-bookmark-o', 
	@IDPermisoParent = 53, @DescripcionParent  = 'Información del Cliente',
	@IDPermiso  = 56, @Descripcion  = 'Pagos Posfechados', @RutaPNet  = 'swCte_PagosPosfechados'

-- Compras Pendientes --
EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, @IconParent  = 'fa fa-bookmark-o', 
	@IDPermisoParent = 53, @DescripcionParent  = 'Información del Cliente',
	@IDPermiso  = 57, @Descripcion  = 'Compras Pendientes', @RutaPNet  = 'swCte_ComprasPendientes'

-- Pagos Aplicados --
EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, @IconParent  = 'fa fa-bookmark-o', 
	@IDPermisoParent = 53, @DescripcionParent  = 'Información del Cliente',
	@IDPermiso  = 58, @Descripcion  = 'Pagos Aplicados', @RutaPNet  = 'swCte_PagosAplicados'

-- Embarques --
EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, @IconParent  = 'fa fa-bookmark-o', 
	@IDPermisoParent = 53, @DescripcionParent  = 'Información del Cliente',
	@IDPermiso  = 59, @Descripcion  = 'Embarques', @RutaPNet  = 'swCte_Embarques'

-- Compras por Movimiento --
EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, @IconParent  = 'fa fa-bookmark-o', 
	@IDPermisoParent = 60, @DescripcionParent  = 'Reportes',
	@IDPermiso  = 61, @Descripcion  = 'Compras por Movimiento', @RutaPNet  = 'swCte_ComMov'

-- Pedidos --
EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, @IconParent  = 'fa fa-bookmark-o', 
	@IDPermisoParent = 60, @DescripcionParent  = 'Reportes',
	@IDPermiso  = 62, @Descripcion  = 'Pedidos', @RutaPNet  = 'swCte_Pedidos'

-- Guías de Embarques --
EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, @IconParent  = 'fa fa-bookmark-o', 
	@IDPermisoParent = 60, @DescripcionParent  = 'Reportes',
	@IDPermiso  = 63, @Descripcion  = 'Guías de Embarques', @RutaPNet  = 'swCte_GuiaEmbarque'

-- Movimientos por Artículos --
EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, @IconParent  = 'fa fa-bookmark-o', 
	@IDPermisoParent = 60, @DescripcionParent  = 'Reportes',
	@IDPermiso  = 64, @Descripcion  = 'Movimientos por Artículos', @RutaPNet  = 'swCte_MovArt'

-- Consultar Reportes --
EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, @IconParent  = 'fa fa-bookmark-o', 
	@IDPermisoParent = 65, @DescripcionParent  = 'Atención al Cliente',
	@IDPermiso  = 66, @Descripcion  = 'Consultar Reportes', @RutaPNet  = 'swCte_ConAtenRep'

-- Levantar Reporte --
EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, @IconParent  = 'fa fa-bookmark-o', 
	@IDPermisoParent = 65, @DescripcionParent  = 'Atención al Cliente',
	@IDPermiso  = 67, @Descripcion  = 'Levantar Reporte', @RutaPNet  = 'swCte_AltaAtenRep'
GO

/*************************************************Opciones Proveedor***********************************************/
-- Usuario Proveedor --
DECLARE @SET_IDUsuarioTipo int
SET @SET_IDUsuarioTipo = 4

DECLARE @SET_IDRole int
SELECT @SET_IDRole = IDRole
  FROM dbo.pNetRole 
 WHERE IDUsuarioTipo = @SET_IDUsuarioTipo AND Descripcion = 'SW'

IF (@SET_IDRole IS NULL)
BEGIN
	INSERT INTO dbo.pNetRole (IDUsuarioTipo, Descripcion)
	SELECT @SET_IDUsuarioTipo, 'SW'
	SELECT @SET_IDRole = SCOPE_IDENTITY();
END

-- Por Cobrar --
EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, @IconParent  = 'fa fa-bookmark-o', 
	@IDPermisoParent = 44, @DescripcionParent  = 'Información del Proveedor',
	@IDPermiso  = 45, @Descripcion  = 'Por Cobrar', @RutaPNet  = 'swProv_Xcobrar'

-- Compras Pendientes --
EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, @IconParent  = 'fa fa-bookmark-o', 
	@IDPermisoParent = 44, @DescripcionParent  = 'Información del Proveedor',
	@IDPermiso  = 46, @Descripcion  = 'Compras Pendientes', @RutaPNet  = 'swProv_ComPendientes'

-- Pagos Aplicados --
EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, @IconParent  = 'fa fa-bookmark-o', 
	@IDPermisoParent = 44, @DescripcionParent  = 'Información del Proveedor',
	@IDPermiso  = 47, @Descripcion  = 'Pagos Aplicados', @RutaPNet  = 'swProv_PagosAplicados'

-- Gastos Pendientes --
EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, @IconParent  = 'fa fa-bookmark-o', 
	@IDPermisoParent = 44, @DescripcionParent  = 'Información del Proveedor',
	@IDPermiso  = 48, @Descripcion  = 'Gastos Pendientes', @RutaPNet  = 'swProv_GastosPendientes'

-- Pagos aprobados --
EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, @IconParent  = 'fa fa-bookmark-o', 
	@IDPermisoParent = 44, @DescripcionParent  = 'Información del Proveedor',
	@IDPermiso  = 49, @Descripcion  = 'Pagos aprobados', @RutaPNet  = 'swProv_PagosAprobados'

-- Inventario de Artículos --
EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, @IconParent  = 'fa fa-bookmark-o', 
	@IDPermisoParent = 44, @DescripcionParent  = 'Información del Proveedor',
	@IDPermiso  = 75, @Descripcion  = 'Inventario de Artículos', @RutaPNet  = 'swProv_ArtExistencia'


-- Consultar Reportes --
EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, @IconParent  = 'fa fa-bookmark-o', 
	@IDPermisoParent = 50, @DescripcionParent  = 'Atención al Proveedor',
	@IDPermiso  = 51, @Descripcion  = 'Consultar Reportes', @RutaPNet  = 'swProv_VerRep'

-- Levantar Reporte --
EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, @IconParent  = 'fa fa-bookmark-o', 
	@IDPermisoParent = 50, @DescripcionParent  = 'Atención al Proveedor',
	@IDPermiso  = 52, @Descripcion  = 'Levantar Reporte', @RutaPNet  = 'swProv_AltaRep'

-- Venta Asistida  --
-- Anexos Artículos --
EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = 1, @IDRole = 1, @IconParent  = 'fa fa-file-image-o', 
	@IDPermisoParent = 70, @DescripcionParent  = 'Administrar Anexos',
	@IDPermiso = 71, @Descripcion  = 'Artículos', @RutaPNet  = 'AnexosArt'
GO

/**************** pNetActualizarCampana ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('pNetActualizarCampana') AND type = 'P') 
	DROP PROCEDURE pNetActualizarCampana
GO  
CREATE PROC pNetActualizarCampana
 @Usuario       varchar(10),
 @Empresa       varchar(5),
 @Sucursal      int,

 @ID            int = NULL,
 @Asunto        varchar(100),
 @Agente        varchar(10), 
 @CampanaTipo   varchar(50),
 @Estatus       varchar(15),
 @FechaEmision  datetime,
 @Observaciones varchar(100),
 @Proyecto      varchar(50),
 @Concepto      varchar(50)
AS BEGIN
DECLARE
 @UltimoCambio datetime,
 @Mov          varchar(20)

 SELECT @UltimoCambio = GETDATE()
 SELECT @Mov = 'Campaña'

 IF @ID IS NOT NULL AND EXISTS (SELECT 1 FROM Campana WHERE ID = @ID AND Estatus = 'SINAFECTAR')
  UPDATE Campana SET
   Empresa = @Empresa, Mov = @Mov, FechaEmision = @FechaEmision, UltimoCambio = @UltimoCambio, 
   Concepto = @Concepto, Proyecto = @Proyecto, Usuario = @Usuario, Observaciones = @Observaciones,
   Estatus = @Estatus, FechaRegistro = @UltimoCambio, Sucursal = @Sucursal, Asunto = @Asunto,
   Agente = @Agente, CampanaTipo = @CampanaTipo
   WHERE ID = @ID
 ELSE IF NOT EXISTS (SELECT 1 FROM Campana WHERE ID = @ID)
  INSERT INTO Campana(Empresa, Mov, FechaEmision, UltimoCambio, Concepto, Proyecto, Usuario,
   Observaciones, Estatus, FechaRegistro, Sucursal, Asunto, Agente, CampanaTipo)
   SELECT @Empresa, @Mov, @FechaEmision, @UltimoCambio, @Concepto, @Proyecto, @Usuario,
   @Observaciones, @Estatus, @UltimoCambio, @Sucursal, @Asunto, @Agente, @CampanaTipo

 SELECT 'La Campaña se actualizó con éxito'

RETURN
END
GO

/**************** pNetActualizarCampanaTipo ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.pNetActualizarCampanaTipo') AND type = 'P') 
	DROP PROCEDURE pNetActualizarCampanaTipo
GO  
CREATE PROC pNetActualizarCampanaTipo
 @Usuario       varchar(10) = NULL,
 @Empresa       varchar(5)  = NULL,
 @Sucursal      int         = NULL,

 @CampanaTipo   varchar(50) = NULL
AS BEGIN

IF NOT EXISTS(SELECT 1 FROM CampanaTipo WHERE CampanaTipo = ISNULL(@CampanaTipo,''))
INSERT INTO CampanaTipo(CampanaTipo, ParaProspectos, ParaClientes, ParaProveedores, ParaPersonal, ParaAgentes)
                SELECT @CampanaTipo, 1,              0,            0,               0,            0
ELSE
 UPDATE CampanaTipo SET CampanaTipo = @CampanaTipo, ParaProspectos = 1 WHERE CampanaTipo = ISNULL(@CampanaTipo,'')

SELECT 'El registro se actualizó con éxito'


RETURN
END
GO

/**************** pNetActualizarCampanaTipoSituacion ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('pNetActualizarCampanaTipoSituacion') AND type = 'P') 
	DROP PROCEDURE pNetActualizarCampanaTipoSituacion
GO  
CREATE PROC pNetActualizarCampanaTipoSituacion
 @Usuario       varchar(10) = NULL,
 @Empresa       varchar(5)  = NULL,
 @Sucursal      int = NULL,

 @CampanaTipo   varchar(50) = NULL,
 @Situacion     varchar(50) = NULL,
 @Flujo         varchar(20) = NULL,
 @Orden         int = NULL
AS BEGIN

IF EXISTS(SELECT 1 FROM CampanaTipoSituacion WHERE CampanaTipo = @CampanaTipo AND Situacion = @Situacion)
UPDATE CampanaTipoSituacion SET
  Flujo = @Flujo,
  Orden = @Orden
  WHERE CampanaTipo = @CampanaTipo AND Situacion = @Situacion 
ELSE
 INSERT INTO CampanaTipoSituacion(CampanaTipo, Situacion, Flujo, Orden)
                           SELECT @CampanaTipo, @Situacion, @Flujo, @Orden
 
SELECT 'El Registro se actualizó con éxito'

RETURN
END
GO

/**************** pNetActualizarCargo ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('pNetActualizarCargo') AND type = 'P') 
	DROP PROCEDURE pNetActualizarCargo
GO  
CREATE PROC pNetActualizarCargo
 @Usuario       varchar(10) = NULL,
 @Empresa       varchar(5)  = NULL,
 @Sucursal      int         = NULL,

 @Cargo         varchar(50) = NULL
AS BEGIN

IF NOT EXISTS(SELECT 1 FROM Cargo WHERE Cargo = ISNULL(@Cargo,''))
 INSERT INTO Cargo(Cargo) SELECT @Cargo
ELSE
 UPDATE Cargo SET Cargo = @Cargo WHERE Cargo = ISNULL(@Cargo,'')

SELECT 'El registro se actualizó con éxito'

RETURN
END
GO

/**************** pNetActualizarProspecto ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('pNetActualizarProspecto') AND type = 'P') 
	DROP PROCEDURE pNetActualizarProspecto
GO  
CREATE PROC pNetActualizarProspecto
 @Usuario             varchar(10)  = NULL,
 @Empresa             varchar(5)   = NULL,
 @Sucursal            int          = NULL, 
 
 @IncluyeCatalogo     bit          = NULL, --- Indicar si se incluye catálogo
 @IncluyeMov		  bit          = NULL, --- Indicar si se incluye campaña
 @ID                  int          = NULL, --- ID de la Campaña
 @Prospecto           varchar(10)  = NULL,
 @Nombre              varchar(100) = NULL,
 @Direccion           varchar(100) = NULL,       
 @DireccionNumero     varchar(20)  = NULL, 
 @DireccionNumeroInt  varchar(20)  = NULL,
 @EntreCalles         varchar(100) = NULL,
 @Plano               varchar(15)  = NULL, 
 @Observaciones       varchar(100) = NULL, 
 @Delegacion          varchar(100) = NULL,
 @Colonia             varchar(100) = NULL, 
 @Poblacion           varchar(100) = NULL,
 @Estado              varchar(30)  = NULL,
 @Pais                varchar(30)  = NULL, 
 @Zona                varchar(30)  = NULL,
 @CodigoPostal        varchar(15)  = NULL, 
 @RFC                 varchar(15)  = NULL,  
 @CURP                varchar(30)  = NULL, 
 @Telefonos           varchar(100) = NULL, 
 @TelefonosLada       varchar(6)   = NULL, 
 @Fax                 varchar(50)  = NULL, 
 @PedirTono           varchar(2)   = NULL,  
 @PaginaWeb			  varchar(100) = NULL,--
 @eMail               varchar(50)  = NULL,-- 
 @Comentarios		  varchar(max) = NULL,--
 @Categoria           varchar(50)  = NULL, 
 @Grupo               varchar(50)  = NULL, 
 @Familia             varchar(50)  = NULL, 
 @Tipo                varchar(15)  = NULL, 
 @Estatus             varchar(15)  = NULL, 
 @Origen              varchar(50)  = NULL,
 @Agente              varchar(10)  = NULL, 
 @NombreComercial     varchar(100) = NULL, 
 @ReferidoNombre      varchar(100) = NULL, 
 @ReferidoMail        varchar(50)  = NULL, 
 @ReferidoTelefono    varchar(100) = NULL, 
 @ReferidoRFC         varchar(10)  = NULL, 
 @RelacionReferencia  varchar(40)  = NULL
AS BEGIN
DECLARE
 @UltimoCambio        datetime,
 @Alta                datetime,
 @PedirTonoCond  	  bit

 SELECT @UltimoCambio = GETDATE(), @Alta = dbo.fnFechaSinHora(GETDATE())
 
 IF UPPER(ISNULL(@PedirTono,'')) <> 'SI'
  SELECT @PedirTonoCond = 0
 ELSE
  SELECT @PedirTonoCond = 1

 IF (ISNULL(@IncluyeCatalogo,0) = 1)
 BEGIN
 
	IF EXISTS(SELECT 1 FROM Prospecto WHERE Prospecto = ISNULL(@Prospecto,''))
		UPDATE Prospecto SET
		Nombre              = @Nombre, 
		Direccion           = @Direccion,   
		DireccionNumero     = @DireccionNumero, 
		DireccionNumeroInt  = @DireccionNumeroInt, 
		EntreCalles         = @EntreCalles, 
		Plano               = @Plano,  
		Observaciones       = @Observaciones, 
		Delegacion          = @Delegacion,  
		Colonia             = @Colonia,  
		Poblacion			  = @Poblacion,
		Estado              = @Estado,  
		Pais                = @Pais,  
		Zona                = @Zona,  
		CodigoPostal        = @CodigoPostal,  
		RFC                 = @RFC, 
		CURP                = @CURP,  
		Telefonos           = @Telefonos,  
		TelefonosLada       = @TelefonosLada,  
		Fax                 = @Fax, 
		PedirTono           = @PedirTonoCond,  
		PaginaWeb			= @PaginaWeb,
		Comentarios			= @Comentarios,
		Categoria           = @Categoria,  
		Grupo               = @Grupo,  
		Familia             = @Familia,  
		Tipo                = @Tipo,  
		Estatus             = @Estatus,  
		UltimoCambio        = @UltimoCambio,  
		Origen              = @Origen,
		Agente              = @Agente,  
		eMail               = @eMail,  
		NombreComercial     = @NombreComercial,  
		ReferidoNombre      = @ReferidoNombre,  
		ReferidoMail        = @ReferidoMail,  
		ReferidoTelefono    = @ReferidoTelefono,  
		ReferidoRFC         = @ReferidoRFC,  
		RelacionReferencia  = @RelacionReferencia 
		WHERE Prospecto = @Prospecto 

	ELSE
	BEGIN
		IF ISNULL(@Prospecto,'') = ''
			EXEC spConsecutivo 'Prospecto', @Sucursal, @Prospecto OUTPUT, @AutoGenerar = 1

		IF ISNULL(@Prospecto, '') <> ''
			INSERT INTO Prospecto(Prospecto, Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Plano, Observaciones, 
				Delegacion, Colonia, Poblacion, Estado, Pais, Zona, CodigoPostal, RFC, CURP, Telefonos, TelefonosLada, Fax,
				PedirTono, PaginaWeb, Comentarios, Categoria, Grupo, Familia, Tipo, Estatus, UltimoCambio, Agente, 
				eMail, NombreComercial, ReferidoNombre, ReferidoMail, ReferidoTelefono, ReferidoRFC, RelacionReferencia, Origen, Alta)
			SELECT @Prospecto, @Nombre, @Direccion, @DireccionNumero, @DireccionNumeroInt, @EntreCalles, @Plano, @Observaciones, 
			@Delegacion, @Colonia, @Poblacion, @Estado, @Pais, @Zona, @CodigoPostal, @RFC, @CURP, @Telefonos, @TelefonosLada, @Fax,
			@PedirTonoCond, @PaginaWeb, @Comentarios, @Categoria, @Grupo, @Familia, @Tipo, @Estatus, @UltimoCambio, @Agente, 
			@eMail, @NombreComercial, @ReferidoNombre, @ReferidoMail, @ReferidoTelefono, @ReferidoRFC, @RelacionReferencia, @Origen, @Alta
	END
END

IF (ISNULL(@IncluyeMov,0) = 1)
BEGIN
	IF @ID IS NOT NULL AND EXISTS(SELECT 1 FROM Campana WHERE ID = @ID AND Estatus IN ('SINAFECTAR', 'PENDIENTE'))
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM CampanaD WHERE ID = @ID AND ContactoTipo = 'Prospecto' AND Contacto = @Prospecto)
			INSERT INTO CampanaD(ID, Contacto, ContactoTipo, Usuario, Sucursal, SucursalOrigen) 
				SELECT @ID, @Prospecto, 'Prospecto', @Usuario, @Sucursal, @Sucursal
	END
END

SELECT 'Se agregó el Prospecto'

RETURN
END
GO

/**************** pNetActualizarProspectoCto ****************/
IF EXISTS (SELECT * FROM sysobjects where id = object_id('pNetActualizarProspectoCto') AND type = 'P') 
	DROP PROCEDURE pNetActualizarProspectoCto
GO  
CREATE PROC pNetActualizarProspectoCto
 @Usuario           varchar(10)  = NULL,
 @Empresa           varchar(5)   = NULL,
 @Sucursal          int          = NULL,
 
 @Prospecto         varchar(10)  = NULL,
 @ID                int          = NULL,
 @Nombre            varchar(100) = NULL,
 @ApellidoPaterno   varchar(30) = NULL,
 @ApellidoMaterno   varchar(30) = NULL,
 @Atencion          varchar(50) = NULL,
 @Tratamiento       varchar(20) = NULL,
 @Cargo             varchar(50) = NULL,
 @Grupo             varchar(50) = NULL,
 @FechaNacimiento   datetime = NULL,
 @Telefonos         varchar(100) = NULL,
 @Extencion         varchar(20) = NULL,
 @eMail             varchar(100) = NULL,
 @Fax               varchar(50) = NULL,
 @PedirTono         varchar(2)  = NULL,
 @Tipo              varchar(20) = NULL,
 @Sexo              varchar(20) = NULL
AS BEGIN
DECLARE
 @PedirTonoCond	    bit
 
 IF UPPER(ISNULL(@PedirTono,'')) <> 'SI'
  SELECT @PedirTonoCond = 0
 ELSE
  SELECT @PedirTonoCond = 1

 IF EXISTS(SELECT 1 FROM ProspectoCto WHERE Prospecto = ISNULL(@Prospecto,'') AND ID = @ID)
  UPDATE ProspectoCto SET
   Nombre          = @Nombre,
   ApellidoPaterno = @ApellidoPaterno,
   ApellidoMaterno = @ApellidoMaterno,
   Atencion        = @Atencion,
   Tratamiento     = @Tratamiento,
   Cargo           = @Cargo,
   Grupo           = @Grupo,
   FechaNacimiento = @FechaNacimiento,
   Telefonos       = @Telefonos,
   Extencion       = @Extencion,
   eMail           = @eMail,
   Fax             = @Fax,
   Tipo            = @Tipo,
   Sexo            = @Sexo,
   PedirTono	   = @PedirTonoCond
 WHERE Prospecto = @Prospecto AND ID = @ID
 
 ELSE IF ISNULL(@Prospecto,'') <> ''
 INSERT INTO ProspectoCto(Prospecto, Nombre, ApellidoPaterno, ApellidoMaterno, Atencion, Tratamiento, Cargo, Grupo, FechaNacimiento, 
					      Telefonos, Extencion, eMail, Fax, PedirTono, Tipo, Sexo)
                   SELECT @Prospecto, @Nombre, @ApellidoPaterno, @ApellidoMaterno, @Atencion, @Tratamiento, @Cargo, @Grupo, @FechaNacimiento, 
					      @Telefonos, @Extencion, @eMail, @Fax, @PedirTonoCond, @Tipo, @Sexo

 SELECT 'El registro de actualizó'
RETURN
END
GO

/**************** pNetAsignaCampana ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('pNetAsignaCampana') AND type = 'P') 
	DROP PROCEDURE pNetAsignaCampana
GO  
CREATE PROC pNetAsignaCampana
 @ID            int         = NULL,
 @RID           int         = NULL,
 @Usuario       varchar(10) = NULL
AS BEGIN
 IF ISNULL(@Usuario,'') <> ''
  UPDATE CampanaD SET Usuario = @Usuario WHERE ID = @ID AND RID = @RID

 SELECT 'El registro se actualizó con éxito'
RETURN
END
GO

/**************** pNetCrearCampanaEvento ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.pNetCrearCampanaEvento') AND type = 'P') 
	DROP PROCEDURE pNetCrearCampanaEvento
GO  
CREATE PROC pNetCrearCampanaEvento
 @Usuario       varchar(10) = NULL,
 @Empresa       varchar(5)  = NULL,
 @Sucursal      int         = NULL,

 @ID            int         = NULL,
 @Prospecto     varchar(10) = NULL,
 @FechaHora     datetime    = NULL,
 @Tipo          varchar(10) = NULL,
 @Situacion     varchar(50) = NULL,
 @Observaciones varchar(100) = NULL
AS BEGIN
DECLARE
 @RID           int

 SELECT TOP 1 @RID = RID FROM CampanaD WHERE ID = @ID AND ContactoTipo = 'Prospecto' AND Contacto = @Prospecto

 INSERT INTO CampanaEvento(ID, RID, FechaHora, Tipo, Situacion, SituacionFecha, Observaciones, Sucursal, SucursalOrigen)
                    SELECT @ID, @RID, @FechaHora, @Tipo, @Situacion, @FechaHora, @Observaciones, @Sucursal, @Sucursal

 IF ISNULL(@Situacion,'') <> ''
  UPDATE CampanaD SET Situacion = @Situacion, SituacionFecha = @FechaHora, Observaciones = @Observaciones WHERE ID = @ID AND RID = @RID

 SELECT 'La Actividad se creó correctamente'
RETURN
END
GO

/**************** pNetEliminarCampana ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('pNetEliminarCampana') AND type = 'P') 
	DROP PROCEDURE pNetEliminarCampana
GO  
CREATE PROC pNetEliminarCampana
 @TipoCuenta    varchar(50),  -- CampanaTipo, CampanaTipoSituacion, Cargo, Campana, CampanaD, CampanaEvento, Prospecto, ProspectoCto
 @ID            int         = NULL,
 @RID           int         = NULL,
 @EventoID      int         = NULL,
 @Cuenta        varchar(50) = NULL,
 @SubCuenta     varchar(50) = NULL
AS BEGIN

 IF ISNULL(@TipoCuenta,'') = 'CampanaTipo'
 BEGIN
   DELETE FROM CampanaTipoSituacion WHERE CampanaTipo = @Cuenta
   DELETE FROM CampanaTipo WHERE CampanaTipo = @Cuenta
 END
 ELSE IF ISNULL(@TipoCuenta,'') = 'CampanaTipoSituacion'
 BEGIN
  DELETE FROM CampanaTipoSituacion WHERE CampanaTipo = @Cuenta AND Situacion = @SubCuenta
 END
 ELSE IF ISNULL(@TipoCuenta,'') = 'Cargo'
 BEGIN
  DELETE FROM Cargo WHERE Cargo = @Cuenta
 END
 ELSE IF ISNULL(@TipoCuenta,'') = 'Campana'
 BEGIN
  DELETE FROM CampanaEvento WHERE ID = @ID
  DELETE FROM CampanaD WHERE ID = @ID
  DELETE FROM Campana WHERE ID = @ID
 END
 ELSE IF ISNULL(@TipoCuenta,'') = 'CampanaD'
 BEGIN
  DELETE FROM CampanaD WHERE ID = @ID AND RID = @RID
 END
 ELSE IF ISNULL(@TipoCuenta,'') = 'CampanaEvento'
 BEGIN 
  DELETE FROM CampanaEvento WHERE ID = @ID AND RID = @RID AND EventoID = @EventoID
 END
 ELSE IF ISNULL(@TipoCuenta,'') = 'Prospecto'
 BEGIN
  DELETE FROM ProspectoCto WHERE Prospecto = @Cuenta
  DELETE FROM Prospecto WHERE Prospecto = @Cuenta
  DELETE e FROM CampanaEvento e INNER JOIN CampanaD d ON e.ID = d.ID AND e.RID = d.RID WHERE d.ContactoTipo = @TipoCuenta AND d.Contacto = @Cuenta
  DELETE FROM CampanaD WHERE ContactoTipo = @TipoCuenta AND Contacto = @Cuenta 
 END
 ELSE IF ISNULL(@TipoCuenta,'') = 'ProspectoCto'
 BEGIN
  DELETE FROM ProspectoCto WHERE Prospecto = @Cuenta AND ID = @ID
 END
 ELSE IF ISNULL(@TipoCuenta,'') = 'CampanaProspecto'
 BEGIN
  DELETE FROM CampanaD WHERE ID = @ID AND RID = @RID AND ContactoTipo = 'Prospecto'
  DELETE FROM CampanaEvento WHERE ID = @ID AND RID = @RID
 END

 SELECT 'Se eliminó el registro'

RETURN
END
GO

/********************************************************************** Condominios  Usuarios Roles y Opciones **********************************************************************/

-- Condominios --
-- Administrador Condominios --
-- Roles --
DECLARE @SET_IDUsuarioTipo int
 SELECT @SET_IDUsuarioTipo = 1

DECLARE @SET_IDRole int
 SELECT @SET_IDRole = IDRole FROM dbo.pNetRole 
  WHERE IDUsuarioTipo = @SET_IDUsuarioTipo AND Descripcion = 'Condominios'

IF (@SET_IDRole IS NULL)
BEGIN
 INSERT INTO dbo.pNetRole (IDUsuarioTipo, Descripcion) SELECT @SET_IDUsuarioTipo, 'Condominios'
 SELECT @SET_IDRole = SCOPE_IDENTITY()
END

-- Usuarios --
EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'icon-users', @IDPermisoParent = 3, @DescripcionParent  = 'Usuarios',
 @IDPermiso  = 4, @Descripcion  = 'Todos los usuarios', @RutaPNet  = 'todos-usuarios'

EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'icon-users', @IDPermisoParent = 3, @DescripcionParent  = 'Usuarios',
 @IDPermiso  = 5, @Descripcion  = 'Alta usuario', @RutaPNet  = 'usuario-portal'

-- Roles --
EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'fa fa-lock', @IDPermisoParent = 6, @DescripcionParent  = 'Roles',
 @IDPermiso  = 7, @Descripcion  = 'Roles', @RutaPNet  = 'roles'

EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'icon-users', @IDPermisoParent = 3, @DescripcionParent  = 'Usuarios',
 @IDPermiso  = 10, @Descripcion  = 'Editar Usuario', @RutaPNet  = 'usuario-portal-editar'

-- Reportes Condominios --
EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'fa fa-bookmark-o', @IDPermisoParent = 76, @DescripcionParent  = 'Reportes',
 @IDPermiso  = 77, @Descripcion  = 'Antigüedad de Saldos', @RutaPNet  = 'cond_RepSaldos'

EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'fa fa-bookmark-o', @IDPermisoParent = 76, @DescripcionParent  = 'Reportes',
 @IDPermiso  = 78, @Descripcion  = 'Estado de Resultados', @RutaPNet  = 'cond_RepEdoResultados'

EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'fa fa-bookmark-o', @IDPermisoParent = 76, @DescripcionParent  = 'Reportes',
 @IDPermiso  = 79, @Descripcion  = 'Posición Financiera', @RutaPNet  = 'cond_RepPosicionFin'
/*
EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'fa fa-bookmark-o', @IDPermisoParent = 75, @DescripcionParent  = 'Reportes',
 @IDPermiso  = 92, @Descripcion  = 'Estado de Cuenta', @RutaPNet  = 'cond_RepEdoCuenta'
*/
 EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'fa fa-bookmark-o', @IDPermisoParent = 76, @DescripcionParent  = 'Reportes',
 @IDPermiso  = 80, @Descripcion  = 'Balanza de Comprobación', @RutaPNet  = 'cond_RepBlzComprobacion'

-- Atención a Cliente --
EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'fa fa-bookmark-o', @IDPermisoParent = 81, @DescripcionParent  = 'Atención al Cliente',
 @IDPermiso  = 82, @Descripcion  = 'Consultar Reportes', @RutaPNet  = 'swCte_ConAtenRep'

EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'fa fa-bookmark-o', @IDPermisoParent = 81, @DescripcionParent  = 'Atención al Cliente',
 @IDPermiso  = 83, @Descripcion  = 'Levantar Reporte', @RutaPNet  = 'swCte_AltaAtenRep'

-- Amenidades --
EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'fa fa-building-o', @IDPermisoParent = 84, @DescripcionParent  = 'Amenidades',
 @IDPermiso  = 85, @Descripcion  = 'Consultar Solicitudes', @RutaPNet  = 'condAmenidades'

EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'fa fa-building-o', @IDPermisoParent = 84, @DescripcionParent  = 'Amenidades',
 @IDPermiso  = 86, @Descripcion  = 'Levantar Solicitud', @RutaPNet  = 'condSolicitarAmenidades'

-- Comunicados --
EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'fa fa-pencil-square-o', @IDPermisoParent = 87, @DescripcionParent  = 'Comunicados',
 @IDPermiso  = 88, @Descripcion  = 'Administrar Comunicados', @RutaPNet  = 'cond_RepComunicados'

EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'fa fa-pencil-square-o', @IDPermisoParent = 87, @DescripcionParent  = 'Comunicados',
 @IDPermiso  = 89, @Descripcion  = 'Levantar Comunicado', @RutaPNet  = 'cond_AltaComunicados'
GO


-- Vigilancia --
-- ROL --
DECLARE @SET_IDUsuarioTipo int
 SELECT @SET_IDUsuarioTipo = 1

DECLARE @SET_IDRole int
 SELECT @SET_IDRole = IDRole FROM dbo.pNetRole 
  WHERE IDUsuarioTipo = @SET_IDUsuarioTipo AND Descripcion = 'Vigilancia'

IF (@SET_IDRole IS NULL)
BEGIN
 INSERT INTO dbo.pNetRole (IDUsuarioTipo, Descripcion) SELECT @SET_IDUsuarioTipo, 'Vigilancia'
 SELECT @SET_IDRole = SCOPE_IDENTITY()
END

-- Eventualidades --
EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'fa fa-calendar', @IDPermisoParent = 90, @DescripcionParent  = 'Eventualidades',
 @IDPermiso  = 91, @Descripcion  = 'Consultar Reportes', @RutaPNet  = 'cond_RepEventualidades'

EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'fa fa-calendar', @IDPermisoParent = 90, @DescripcionParent  = 'Eventualidades',
 @IDPermiso  = 92, @Descripcion  = 'Levantar Reporte', @RutaPNet  = 'cond_AltaEventualidades'


 -- Auditor Recibos de Nómina --
SET @SET_IDUsuarioTipo = 1

DECLARE @SET_IDRoleA int
SELECT @SET_IDRoleA = IDRole
  FROM dbo.pNetRole 
 WHERE IDUsuarioTipo = @SET_IDUsuarioTipo AND Descripcion = 'Auditor'

IF (@SET_IDRoleA IS NULL)
BEGIN
	INSERT INTO dbo.pNetRole (IDUsuarioTipo, Descripcion)
	SELECT @SET_IDUsuarioTipo, 'Auditor'
	SELECT @SET_IDRoleA = SCOPE_IDENTITY();
END

-- Datos Personales --
EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRoleA, @IconParent  = 'fa fa-bookmark-o', 
	@IDPermisoParent = 76, @DescripcionParent  = 'Reportes',
	@IDPermiso  = 93, @Descripcion  = 'Auditar Recibos', @RutaPNet  = 'auditar-recibos'

-- Recursos Humanos --
IF (@SET_IDRoleA IS NULL)
BEGIN
	INSERT INTO dbo.pNetRole (IDUsuarioTipo, Descripcion)
	SELECT @SET_IDUsuarioTipo, 'Recursos Humanos'
	SELECT @SET_IDRoleA = SCOPE_IDENTITY();
END

EXEC dbo.fnPNet_MenuInsert @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRoleA, @IconParent  = 'fa fa-bookmark-o', 
	@IDPermisoParent = 100, @DescripcionParent  = 'Personal',
	@IDPermiso  = 101, @Descripcion  = 'Documentación', @RutaPNet  = 'documentos'
GO

/********************************Opcopnes Usuiario Clientes Condominio *************************************/
-- Condominios --
-- Arrendatario --
-- ROL --
DECLARE @SET_IDUsuarioTipo int
 SELECT @SET_IDUsuarioTipo = 3

DECLARE @SET_IDRole int
 SELECT @SET_IDRole = IDRole FROM dbo.pNetRole 
  WHERE IDUsuarioTipo = @SET_IDUsuarioTipo AND Descripcion = 'Arrendatario'

IF (@SET_IDRole IS NULL)
BEGIN
 INSERT INTO dbo.pNetRole (IDUsuarioTipo, Descripcion) SELECT @SET_IDUsuarioTipo, 'Arrendatario'
 SELECT @SET_IDRole = SCOPE_IDENTITY()
END

-- Reportes condominios --
EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'fa fa-bookmark-o', @IDPermisoParent = 60, @DescripcionParent  = 'Reportes',
 @IDPermiso  = 95, @Descripcion  = 'Estado de Resultados', @RutaPNet  = 'cond_RepEdoResultados'

EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'fa fa-bookmark-o', @IDPermisoParent = 60, @DescripcionParent  = 'Reportes',
 @IDPermiso  = 96, @Descripcion  = 'Posición Financiera', @RutaPNet  = 'cond_RepPosicionFin'

EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'fa fa-bookmark-o', @IDPermisoParent = 60, @DescripcionParent  = 'Reportes',
 @IDPermiso  = 105, @Descripcion  = 'Estado de Cuenta', @RutaPNet  = 'cond_EdoCuenta'

-- Atención a Cliente --
EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'fa fa-bookmark-o', @IDPermisoParent = 65, @DescripcionParent  = 'Atención al Cliente',
 @IDPermiso  = 66, @Descripcion  = 'Consultar Reportes', @RutaPNet  = 'swCte_ConAtenRep'

EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'fa fa-bookmark-o', @IDPermisoParent = 65, @DescripcionParent  = 'Atención al Cliente',
 @IDPermiso  = 67, @Descripcion  = 'Levantar Reporte', @RutaPNet  = 'swCte_AltaAtenRep'

-- Amenidades --
EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'fa fa-calendar-o', @IDPermisoParent = 97, @DescripcionParent  = 'Amenidades',
 @IDPermiso  = 98, @Descripcion  = 'Consultar Solicitudes', @RutaPNet  = 'condAmenidadesCte'

EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'fa fa-calendar-o', @IDPermisoParent = 97, @DescripcionParent  = 'Amenidades',
 @IDPermiso  = 99, @Descripcion  = 'Levantar Solicitud', @RutaPNet  = 'condSolicitarAmenidadesCte'
GO

-- ROL --
-- Inquilino --
DECLARE @SET_IDUsuarioTipo int
 SELECT @SET_IDUsuarioTipo = 3

DECLARE @SET_IDRole int
 SELECT @SET_IDUsuarioTipo = 3
 SELECT @SET_IDRole = IDRole FROM dbo.pNetRole 
  WHERE IDUsuarioTipo = @SET_IDUsuarioTipo AND Descripcion = 'Inquilino'

IF (@SET_IDRole IS NULL)
BEGIN
 INSERT INTO dbo.pNetRole (IDUsuarioTipo, Descripcion) SELECT @SET_IDUsuarioTipo, 'Inquilino'
 SELECT @SET_IDRole = SCOPE_IDENTITY()
END

-- Reportes condominios --
EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'fa fa-bookmark-o', @IDPermisoParent = 60, @DescripcionParent  = 'Reportes',
 @IDPermiso  = 95, @Descripcion  = 'Estado de Resultados', @RutaPNet  = 'cond_RepEdoResultados'

EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'fa fa-bookmark-o', @IDPermisoParent = 60, @DescripcionParent  = 'Reportes',
 @IDPermiso  = 96, @Descripcion  = 'Posición Financiera', @RutaPNet  = 'cond_RepPosicionFin'

 EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'fa fa-bookmark-o', @IDPermisoParent = 60, @DescripcionParent  = 'Reportes',
 @IDPermiso  = 105, @Descripcion  = 'Estado de Cuenta', @RutaPNet  = 'cond_EdoCuenta'

-- Atención a Cliente --
EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'fa fa-bookmark-o', @IDPermisoParent = 65, @DescripcionParent  = 'Atención al Cliente',
 @IDPermiso  = 66, @Descripcion  = 'Consultar Reportes', @RutaPNet  = 'swCte_ConAtenRep'

EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'fa fa-bookmark-o', @IDPermisoParent = 65, @DescripcionParent  = 'Atención al Cliente',
 @IDPermiso  = 67, @Descripcion  = 'Levantar Reporte', @RutaPNet  = 'swCte_AltaAtenRep'

-- Amenidades --
EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'fa fa-calendar-o', @IDPermisoParent = 97, @DescripcionParent  = 'Amenidades',
 @IDPermiso  = 98, @Descripcion  = 'Consultar Solicitudes', @RutaPNet  = 'condAmenidadesCte'

EXEC dbo.fnPNet_MenuInsert 
 @IDUsuarioTipo = @SET_IDUsuarioTipo, @IDRole = @SET_IDRole, 
 @IconParent  = 'fa fa-calendar-o', @IDPermisoParent = 97, @DescripcionParent  = 'Amenidades',
 @IDPermiso  = 99, @Descripcion  = 'Levantar Solicitud', @RutaPNet  = 'condSolicitarAmenidadesCte'
GO


/********************************************************************** Amenidades **********************************************************************/

/************************ spNetAmenidadesCte *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spNetAmenidadesCte') AND type = 'P') DROP PROCEDURE dbo.spNetAmenidadesCte
GO           
CREATE PROCEDURE spNetAmenidadesCte
	@Cliente 			varchar(20)	     
--//WITH ENCRYPTION	     	     
AS 
BEGIN
BEGIN TRAN
	BEGIN TRY
		SELECT 
		A.ID as ID,
		A.Espacio as Espacio,
		A.DiaCompletoHora as DiaCompletoHora,
		E.Nombre as Nombre,
		CONVERT(VARCHAR(24),A.FechaDesde,121) as FechaDesde,
		CONVERT(VARCHAR(24),A.FechaHasta,121) as FechaHasta,
		A.NumPersonas as NumPersonas,
		A.Vivienda as Vivienda,
		A.Telefono as Telefono,
		A.eMail as eMail,
		A.Observaciones as Observaciones
		from Amenidades as A
		INNER JOIN Espacio as E ON A.Espacio = E.Espacio 
		WHERE A.Cliente = @Cliente

	COMMIT TRAN
	END TRY
	BEGIN CATCH
		SELECT -1 Ok, ERROR_MESSAGE() OkRef
		ROLLBACK TRAN
	END CATCH
END
GO

/**************** spNetAmenidadesFacCte ****************/

IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('dbo.spNetAmenidadesFacCte') AND type = 'P') 
	DROP PROCEDURE dbo.spNetAmenidadesFacCte
GO
CREATE PROCEDURE dbo.spNetAmenidadesFacCte
  @Cliente		varchar(10)

 AS BEGIN
	DECLARE @TablaAmenidades TABLE (
		ID				INT IDENTITY(1, 1) ,
		IDMovDet		INT,
		Mov				VARCHAR(20),
		MovID			INT,
		Espacio			VARCHAR(10),
		DiaCompletoHora VARCHAR(20),
		Cliente			VARCHAR(10),
		NombreCliente	VARCHAR(100),
		Nombre			VARCHAR(100),
		FechaDesde		VARCHAR(24), 
		FechaHasta		VARCHAR(24),
		NumPersonas		INT,
		Vivienda		VARCHAR(20),
		Telefono		VARCHAR(100),
		eMail			VARCHAR(255),
		Observaciones	VARCHAR(255),
		Estatus			VARCHAR(15)

	)

	IF @Cliente = '' OR @Cliente IS NULL
		BEGIN
			--Todos los clientes
			INSERT INTO @TablaAmenidades
			SELECT
			V.ID as IDMovDet,
			V.Mov AS Mov,
			V.MovID AS MovID,
			A.Espacio AS Espacio,
			A.DiaCompletoHora,
			V.Cliente,
			C.Nombre as NombreCliente,
			e.Nombre AS Nombre, 
			CONVERT(VARCHAR(24),A.FechaDesde,121) as FechaDesde,
			CONVERT(VARCHAR(24),A.FechaHasta,121) as FechaHasta,
			A.NumPersonas as NumPersonas,
			A.Vivienda as Vivienda,
			A.Telefono as Telefono,
			A.eMail as eMail,
			A.Observaciones as Observaciones,
			CASE WHEN v.Estatus IS NULL OR v.Estatus = 'SINAFECTAR' THEN 'SOLICITUD' WHEN v.Estatus = 'CONCLUIDO' THEN v.Estatus END AS Estatus
			FROM Amenidades A
			JOIN Venta V ON A.IDMovDet = V.ID
			JOIN Cte as C ON C.Cliente = A.Cliente
			JOIN Espacio e ON A.Espacio = e.Espacio AND e.Tipo IN ('Amenidades')
			WHERE
			V.Estatus IN ('SINAFECTAR','CONCLUIDO') 
		
		END
	ELSE
		BEGIN
			--Datos del Cliente
			INSERT INTO @TablaAmenidades
			SELECT 
			V.ID as IDMovDet,
			V.Mov AS Mov,
			V.MovID AS MovID,
			A.Espacio AS Espacio,
			A.DiaCompletoHora,
			V.Cliente,
			C.Nombre as NombreCliente,
			e.Nombre AS Nombre, 
			CONVERT(VARCHAR(24),A.FechaDesde,121) as FechaDesde,
			CONVERT(VARCHAR(24),A.FechaHasta,121) as FechaHasta,
			A.NumPersonas as NumPersonas,
			A.Vivienda as Vivienda,
			A.Telefono as Telefono,
			A.eMail as eMail,
			A.Observaciones as Observaciones,
			CASE WHEN v.Estatus IS NULL OR v.Estatus = 'SINAFECTAR' THEN 'SOLICITUD' WHEN v.Estatus = 'CONCLUIDO' THEN v.Estatus END AS Estatus
			FROM Amenidades A
			JOIN Venta V ON A.IDMovDet = V.ID
			JOIN Cte as C ON C.Cliente = A.Cliente
			JOIN Espacio e ON A.Espacio = e.Espacio AND e.Tipo IN ('Amenidades')
			WHERE
			V.Estatus IN ('SINAFECTAR','CONCLUIDO') 
			AND A.Cliente = @Cliente	
		END

		--Resultado Final
		SELECT * FROM @TablaAmenidades ORDER BY ID DESC

END
GO

/**************************************************** spNetSolClienteAmenidad ****************************************************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('dbo.spNetSolClienteAmenidad') AND type = 'P') 
	DROP PROCEDURE dbo.spNetSolClienteAmenidad
GO
CREATE PROCEDURE dbo.spNetSolClienteAmenidad
		@Cliente			VARCHAR(20),
		@DiaCompletoHora	VARCHAR(20),
		@Espacio			VARCHAR(20),
		@FechaDesde			VARCHAR(20),
		@FechaHasta			VARCHAR(20),
		@FechaRegistro		VARCHAR(20),
		@HorasEvento		VARCHAR(MAX),
		@NomCteInquilino	VARCHAR(100),
		@NumPersonas		INT,
		@Observaciones		VARCHAR(100),
		@Telefono			VARCHAR(100),
		@Vivienda			VARCHAR(20),
		@eMail				VARCHAR(255) = NULL,
		@IDSol					INT = NULL
		
 AS BEGIN
 
	/*Extrae Datos para obtener Info de la Venta*/
	DECLARE 
		@ID				INT,
		@Articulo		VARCHAR(20),
		@Descripcion	VARCHAR(100),
		@MonedaTipo		CHAR(10),
		@TipoCambio		FLOAT,
		@Empresa		CHAR(5),
		@Sucursal		INT,
		@Responsable	VARCHAR(100),
		@Mov			VARCHAR(20),
		@SituacionTipo	VARCHAR(20),
		@MonedaPrecio	VARCHAR(10),
		@TipoArticulo	VARCHAR(20),
		@OcupacionMax	INT,
		@Precio			MONEY,
		@Almacen		VARCHAR(20),
		@Renglon		FLOAT,
		@RenglonID		INT,
		@NumHorasRes	INT,
		@IDAmenidades   INT,
		@Ok				INT,
		@OkRef			VARCHAR(255),
		@VentaFactura	CHAR(20)


	--Valida la Disponibilidad del Espacio
	EXEC spNetDisponibilidadAmenidad @Cliente,@DiaCompletoHora,@Espacio, @FechaDesde,@FechaHasta,@HorasEvento,@IDSol,@Ok OUTPUT, @OkRef OUTPUT
	 
	--Si el Resultado de la Disponibilidad Esnula puede realizar el Registro
	IF @Ok IS NULL
	BEGIN
		--Datos del Cliente
		SELECT @Empresa = CteRep.Empresa, @Sucursal = CteRep.Sucursal, @Responsable = CteRep.Responsable
		FROM Cte Cte
			LEFT JOIN CteRep CteRep ON Cte.Cliente = CteRep.Cliente
		WHERE Cte.Cliente = @Cliente
			AND Cte.Estatus = 'Alta'

		--Moneda y Cambio
		SELECT @MonedaTipo = Moneda , @TipoCambio = TipoCambio FROM Mon WHERE Mon.Moneda = 'Dolares'

		SELECT @VentaFactura = VentaFactura FROM EmpresaCfgMov WHERE Empresa = @Empresa

		--Tipo de Situación
		SELECT @SituacionTipo = dbo.fnMovSituacionTipoFlujo(@Empresa, 'VTAS', @VentaFactura, 'SINAFECTAR')

		--Almacen por Omisión
		SELECT @Almacen = AlmacenTransito FROM EmpresaGral WHERE Empresa = @Empresa

		--Amenidad
		SELECT @Articulo = A.Articulo,@Descripcion = A.Descripcion1,@TipoArticulo = A.Tipo,@MonedaPrecio = A.MonedaPrecio,@Precio = A.PrecioLista
		FROM Art A
			JOIN ArtEspacio AE ON A.Articulo = AE.Articulo AND A.Estatus = 'Alta'
			JOIN Espacio E ON AE.Espacio = E.Espacio AND E.Estatus = 'Alta'
		WHERE 
			E.Espacio = @Espacio

		--Movimiento Facturación
		SELECT  @Mov = Mov
		FROM MovTipo MT
			JOIN EmpresaCfgMov ECM ON MT.Mov = ECM.VentaFactura
		WHERE ECM.Empresa =  @Empresa
			AND Modulo = 'VTAS'

		--Si Registro no Existe
		SET @Renglon = 0
		SET @RenglonID = 0

		BEGIN TRAN
		--Registro Venta Solictud de Amenidad
		IF @IDSol IS NULL	
			BEGIN
				INSERT INTO VENTA (Empresa,Mov,FechaEmision,UltimoCambio,Concepto,Moneda,TipoCambio,Usuario,Estatus,Directo,Prioridad,FechaOriginal,Cliente,Almacen,FechaRequerida,Vencimiento,Comentarios,Referencia)
				VALUES (@Empresa,@Mov,GETDATE(),GETDATE(),@Descripcion,@MonedaTipo,@TipoCambio,@Responsable,'SINAFECTAR',1,@SituacionTipo,CONVERT(DATETIME,@FechaHasta),@Cliente,@Almacen,CONVERT(DATETIME,@FechaDesde),GETDATE(),@Observaciones,@Cliente)
	
				SET @ID = @@IDENTITY 

			END	 
			ELSE
			BEGIN
				--ID ya Existente
				SET @ID = @IDSol

				--Si ID ya Existe obtiene los ultimos valores de Renglonn y RenglonID
				IF  EXISTS( SELECT * FROM VentaD WHERE ID = @IDSol)
				BEGIN
					SELECT @Renglon = MAX(Renglon),  @RenglonID = MAX(RenglonID) FROM VentaD WHERE ID = @IDSol
				END

			END

			--Variable Hora Requerida
			DECLARE @HoraRequerida NVARCHAR(255)
		
			--Inicia Cursor Detalle Horas Solicitud
			DECLARE db_cursor CURSOR FOR 
				SELECT * FROM dbo.splitstring(@HorasEvento)
	
			OPEN db_cursor   
			FETCH NEXT FROM db_cursor INTO @HoraRequerida

			WHILE @@FETCH_STATUS = 0   
			BEGIN  
				--SELECT @HoraRequerida
	
				--Renglon Tipo
				 DECLARE @RenglonTipo	CHAR(1)
				 EXEC spRenglonTipo @TipoArticulo, NULL, @RenglonTipo OUTPUT
		 
				 --Renglon y Renglon ID Incremento
				 SET @Renglon = @Renglon + 2048.0 
				 SET @RenglonID = @RenglonID + 1

				--INSERTAR DETALLE DE LA FACTURA
				INSERT INTO VentaD
					(ID, Renglon, RenglonSub, RenglonID, RenglonTipo, EnviarA, Almacen, Codigo, SubCuenta, Articulo, Cantidad, Precio, PrecioSugerido, DescuentoTipo, DescuentoLinea, DescuentoImporte, Impuesto1, Impuesto2, Impuesto3, DescripcionExtra, Costo, Paquete, ContUso, Comision, Aplica, AplicaID, CantidadA, Factor, SustitutoArticulo, SustitutoSubCuenta, Unidad, FechaRequerida, Instruccion, CantidadInventario, Agente, Departamento, Sucursal, PoliticaPrecios, SucursalOrigen, AutoLocalidad, UEN, Espacio, HoraRequerida,CantidadAlterna, PrecioMoneda, PrecioTipoCambio, Estado, ServicioNumero, AgentesAsignados, AFArticulo, AFSerie, ExcluirPlaneacion, ExcluirISAN, Posicion, PresupuestoEsp, ProveedorRef, TransferirA, Tarima, ContUso2, ContUso3, ABC, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Retencion1, Retencion2, Retencion3, AnticipoFacturado, RecargaTelefono, RecargaConfirmarTelefono, LDIReferencia, LDICuenta, POSDesGlobal, POSDesLinea)
				VALUES
					(@ID, @Renglon, 0,  @RenglonID, @RenglonTipo, NULL, @Almacen, NULL, NULL, @Articulo, 1.0, @Precio, @Precio, NULL, 0.0, NULL, 0.0, 0.0, 0.0, NULL, 0.0, NULL, NULL, NULL, NULL, NULL, NULL, 1.0, NULL, NULL, NULL, CONVERT(datetime,dateadd(day, datediff(day,'19000101',CONVERT(DATETIME,@FechaDesde)), CAST(@HoraRequerida AS DATETIME))), NULL, NULL, NULL, NULL, @Sucursal, NULL, 0, NULL, NULL, @Espacio, @HoraRequerida, NULL, @MonedaTipo, 1.0, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
			
			
			FETCH NEXT FROM db_cursor INTO @HoraRequerida
			END   

			CLOSE db_cursor   
			DEALLOCATE db_cursor

			--Finaliza Cursor Detalle Horas Solicitud
			INSERT INTO Amenidades(Espacio,DiaCompletoHora,FechaRegistro,FechaDesde,FechaHasta,NumPersonas,Cliente,
			NomCteInquilino,Vivienda,Telefono,eMail,Observaciones,Mov,MovID,IDMovDet) 
			VALUES(@Espacio,@DiaCompletoHora,@FechaRegistro,@FechaDesde,CONVERT(DATETIME,@FechaHasta),@NumPersonas,@Cliente,
			@NomCteInquilino,@Vivienda,@Telefono,ISNULL(@eMail,''),ISNULL(@Observaciones,''),@Mov,NULL,@ID)

			SET @IDAmenidades = @@IDENTITY 

			EXEC spAfectar 'VTAS', @ID, 'VERIFICAR', NULL, NULL, @Responsable, @Estacion=5, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

			

			IF @Ok >= 80000
				COMMIT TRAN
			ELSE
			BEGIN
				ROLLBACK
				SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
			END

	END
	ELSE
	BEGIN
		--Solo agreaga el ID Existente que se ha validado en acaso de no ser Nulo
		SET @ID = @IDSol
	END

	--Resultado
	SELECT @ID as ID, @Ok Ok, @OkRef OkRef
	
 END
 GO

 /******************************************spNetListaHorarios******************************************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('dbo.spNetListaHorarios') AND type = 'P') 
	DROP PROCEDURE dbo.spNetListaHorarios
GO
CREATE PROCEDURE dbo.spNetListaHorarios

 AS BEGIN

	/*Funcion Ciclo de Horas Amenidades*/
	DECLARE @contador INT,
			@NumHoras INT,
			@datetime1 datetime2,
			@datetime2 datetime2,
			@datetime3 datetime2

	SET @contador = 1
	SET @NumHoras = (SELECT DISTINCT DATEDIFF( HH , EspaciosHoraD , EspaciosHoraA ) FROM Empresacfg)
	SET @NumHoras = @NumHoras + 1
	SET @datetime1 = (SELECT DISTINCT EspaciosHoraD FROM Empresacfg)
	SET @datetime2 = (SELECT DISTINCT EspaciosHoraD FROM Empresacfg)
	SET @datetime3 = (SELECT DISTINCT EspaciosHoraA FROM Empresacfg)

	--Tabla Temporal DiasLaborables
		DECLARE @TablaListaHoras TABLE (Horas TIME)

	WHILE (@contador < @NumHoras)
	BEGIN
	
		--Primera vez
		IF @datetime2 = @datetime1
		BEGIN
			SET @datetime2 = @datetime1 
		END
		--Mayores a la primera
		ELSE IF @datetime2 > @datetime1 AND @datetime2 < @datetime3
		BEGIN
			SET @datetime2 = @datetime2
		END

		--Hora Generada
		INSERT INTO @TablaListaHoras
		SELECT CONVERT(time,@datetime2) as HoraEvento

		--Contador
		SET @contador = @contador + 1
		SET @datetime2 = DATEADD(mi,60,@datetime2) 
		--SELECT @datetime2

	END

	SELECT CONVERT(VARCHAR(8),Horas) as HoraEvento FROM @TablaListaHoras

END
GO

 /**************************************************** spNetDisponibilidadAmenidad ****************************************************/
 IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('dbo.spNetDisponibilidadAmenidad') AND type = 'P') 
	DROP PROCEDURE dbo.spNetDisponibilidadAmenidad
GO
CREATE PROCEDURE dbo.spNetDisponibilidadAmenidad
		@Cliente			VARCHAR(20),
		@DiaCompletoHora	VARCHAR(20),
		@Espacio			VARCHAR(20),
		@FechaDesde			VARCHAR(20),
		@FechaHasta			VARCHAR(20),
		@HorasEvento		VARCHAR(MAX),
		@IDSol				INT,
		@Ok					INT OUTPUT,
		@OkRef				VARCHAR(255) OUTPUT
		
		
 AS BEGIN
 
 DECLARE @Disponibilidad TABLE
	(
		Espacio		VARCHAR(255),
		Total			INT
	)

 IF @IDSol IS NULL
 BEGIN

	
	INSERT INTO @Disponibilidad
	SELECT DISTINCT E.Espacio as Espacio,  COUNT(*) as Total --SELECT DISTINCT 'LA AMENIDAD ' + E.Espacio+' NO SE PUEDE PROCESAR.', COUNT(*) as Total
	FROM Art A 
		JOIN ArtEspacio AE ON A.Articulo = AE.Articulo AND A.Estatus = 'Alta' 
		JOIN Espacio E ON AE.Espacio = E.Espacio AND E.Estatus = 'Alta' 
		JOIN VentaD VD ON VD.Articulo = A.Articulo AND VD.Espacio = E.Espacio
		JOIN Venta V ON V.ID = VD.ID
	WHERE 
	E.Espacio = @Espacio AND  
	CONVERT(DATE,VD.FechaRequerida)  BETWEEN CONVERT(DATE,@FechaDesde) AND CONVERT(DATE,@FechaHasta)
	AND CONVERT(TIME,VD.FechaRequerida) IN (SELECT * FROM dbo.splitstring(@HorasEvento))
	AND  V.Estatus IN ('CONCLUIDO')
	GROUP BY E.Espacio
END
ELSE
BEGIN
	INSERT INTO @Disponibilidad
	SELECT DISTINCT E.Espacio as Espacio,  COUNT(*) as Total
	FROM Art A 
		JOIN ArtEspacio AE ON A.Articulo = AE.Articulo AND A.Estatus = 'Alta' 
		JOIN Espacio E ON AE.Espacio = E.Espacio AND E.Estatus = 'Alta' 
		JOIN VentaD VD ON VD.Articulo = A.Articulo AND VD.Espacio = E.Espacio
		JOIN Venta V ON V.ID = VD.ID
	WHERE 
	E.Espacio = @Espacio AND  
	CONVERT(DATE,VD.FechaRequerida)  BETWEEN CONVERT(DATE,@FechaDesde) AND CONVERT(DATE,@FechaHasta)
	AND CONVERT(TIME,VD.FechaRequerida) IN (SELECT * FROM dbo.splitstring(@HorasEvento))
	AND  V.Estatus IN ('CONCLUIDO')
	GROUP BY E.Espacio
	UNION  
		SELECT DISTINCT E.Espacio as Espacio,  COUNT(*) as Total
	FROM Art A 
		JOIN ArtEspacio AE ON A.Articulo = AE.Articulo AND A.Estatus = 'Alta' 
		JOIN Espacio E ON AE.Espacio = E.Espacio AND E.Estatus = 'Alta' 
		JOIN VentaD VD ON VD.Articulo = A.Articulo AND VD.Espacio = E.Espacio
		JOIN Venta V ON V.ID = VD.ID
		--JOIN Amenidades AM ON AM.Amenidades = 
	WHERE 
	E.Espacio = @Espacio AND  
	CONVERT(DATE,VD.FechaRequerida)  BETWEEN CONVERT(DATE,@FechaDesde) AND CONVERT(DATE,@FechaHasta)
	AND CONVERT(TIME,VD.FechaRequerida) IN (SELECT * FROM dbo.splitstring(@HorasEvento))
	AND V.ID = @IDSol
	GROUP BY E.Espacio;
	
END
	
	SELECT @Ok = Total, @OkRef = 'No se pudo registrar la Solicitud '+Espacio FROM @Disponibilidad
	
 END
 GO

 
/**************** spNetAmenidadesAfecta ****************/

IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('dbo.spNetAmenidadesAfecta') AND type = 'P') 
	DROP PROCEDURE dbo.spNetAmenidadesAfecta
GO
CREATE PROCEDURE dbo.spNetAmenidadesAfecta
 @ID			INT,
 @Cliente		VARCHAR(10),
 @FechaD		DATETIME = NULL,
 @Mov			VARCHAR(20),
 @MovID			VARCHAR(20),
 @FechaDesde	DATETIME,
 @FechaHasta	DATETIME
 
 AS BEGIN

	IF @FechaHasta IS NULL OR @FechaHasta = ''
	BEGIN
		UPDATE Amenidades SET Mov = @Mov, MovID = @MovID, FechaHasta = @FechaDesde WHERE Cliente = RTRIM(LTRIM(@Cliente)) AND CONVERT(DATE, FechaDesde) = @FechaD
	END
	ELSE
	BEGIN
		UPDATE Amenidades SET Mov = @Mov, MovID = @MovID WHERE Cliente = RTRIM(LTRIM(@Cliente)) AND CONVERT(DATE, FechaDesde) = @FechaD
	END
 
END
GO


/**************** spNetAmenidadesBorrarEspacio  ****************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('dbo.spNetAmenidadesBorrarEspacio') AND type = 'P') 
	DROP PROCEDURE dbo.spNetAmenidadesBorrarEspacio
GO
CREATE PROCEDURE dbo.spNetAmenidadesBorrarEspacio
 @ID				INT,
 @Espacio			VARCHAR(20),
 @FechaReservacion	VARCHAR(20),
 @HorasEvento		VARCHAR(MAX)
 
 AS BEGIN

		DECLARE @HoraRequerida NVARCHAR(255)
		
		--Inicia Cursor Detalle Horas Solicitud
		DECLARE db_cursor CURSOR FOR 
			SELECT * FROM dbo.splitstring(@HorasEvento)
	
		OPEN db_cursor   
		FETCH NEXT FROM db_cursor INTO @HoraRequerida

		WHILE @@FETCH_STATUS = 0   
		BEGIN  

			DECLARE @FechaRequerida   VARCHAR(MAX)

			SET @FechaRequerida = @FechaReservacion + ' ' + @HoraRequerida
			select @FechaRequerida
			DELETE VentaD WHERE ID = @ID AND Espacio = @Espacio AND FechaRequerida = @FechaRequerida
	
			
		FETCH NEXT FROM db_cursor INTO @HoraRequerida
		END   

		CLOSE db_cursor   
		DEALLOCATE db_cursor
 
END
GO

/********************************************************************** Comunicados **********************************************************************/

/***************************************spNetAltaComunicado***************************************/
IF EXISTS(SELECT * FROM sys.objects where name = 'spNetAltaComunicado')
	DROP PROCEDURE spNetAltaComunicado
GO
CREATE PROCEDURE spNetAltaComunicado
@Titulo VARCHAR(60),
@Registro VARCHAR(10),
@DirigidoA VARCHAR(15),
@FechaPublicado DATETIME,
@FechaVigencia DATETIME,
@Descripcion VARCHAR(255),
@Prioridad VARCHAR(15),
@Tipo INT,
@Estatus bit
AS
BEGIN

	IF (EXISTS(SELECT * FROM pNetUsuario WHERE Usuario = @Registro))
	BEGIN 

		INSERT INTO pNetComunicado VALUES(@Titulo,@Registro,@DirigidoA,GETDATE(),@FechaPublicado,@FechaVigencia,@Descripcion,@Prioridad,@Tipo,@Estatus)
	
		SELECT @@IDENTITY as ID
	END
	ELSE
		SELECT-1 as ID
	
END
GO
/***************************************spNet_UpdComunicado***************************************/
IF EXISTS(SELECT * FROM sys.objects where name = 'spNetUpdComunicado')
	DROP PROCEDURE spNetUpdComunicado
GO
CREATE PROCEDURE spNetUpdComunicado
@IDComunicado INT,
@Titulo VARCHAR(60),
@Registro VARCHAR(10),
@DirigidoA VARCHAR(15),
@FechaPublicado DATETIME,
@FechaVigencia DATETIME,
@Descripcion VARCHAR(255),
@Prioridad VARCHAR(15),
@Tipo INT,
@Estatus bit
AS
BEGIN

	IF (EXISTS(SELECT * FROM pNetUsuario WHERE Usuario = @Registro) AND EXISTS(SELECT * FROM pNetComunicado WHERE IDComunicado = @IDComunicado))
	BEGIN 

		UPDATE pNetComunicado SET Titulo = @Titulo, Registro = @Registro, DirigidoA = @DirigidoA, FechaRegistro = GETDATE(),FechaPublicado = @FechaPublicado, FechaVigencia = @FechaVigencia, Descripcion = @Descripcion, Prioridad = @Prioridad, Tipo = @Tipo, Estatus = @Estatus WHERE IDComunicado = @IDComunicado
		SELECT @IDComunicado as ID

	END
	ELSE
		SELECT -1 as ID
	
END
GO
/***************************************spNetAddComunicadoPerfil***************************************/
IF EXISTS(SELECT * FROM sys.objects where name = 'spNetAddComunicadoPerfil')
	DROP PROCEDURE spNetAddComunicadoPerfil
GO
CREATE PROCEDURE spNetAddComunicadoPerfil
@IDComunicado INT,
@IDUsuarioTipo INT
AS
BEGIN
	IF (EXISTS(SELECT * FROM pNetUsuarioTipo WHERE IDUsuarioTipo = @IDUsuarioTipo) AND EXISTS(SELECT * FROM pNetComunicado WHERE IDComunicado = @IDComunicado) AND NOT EXISTS(select * from pNetComunicadoXPerfil where IDComunicado = @IDComunicado AND IDUsuarioTipo = @IDUsuarioTipo))
	BEGIN 
	
		INSERT INTO pNetComunicadoXPerfil values(@IDComunicado,@IDUsuarioTipo)
	
		SELECT COUNT (IDComunicado) as ID FROM pNetComunicadoXPerfil WHERE IDComunicado = @IDComunicado
	END
	ELSE
		SELECT -1 as ID
END
GO
/***************************************spNetAddComunicadoUsuarios***************************************/
IF EXISTS(SELECT * FROM sys.objects where name = 'spNetAddComunicadoUsuarios')
	DROP PROCEDURE spNetAddComunicadoUsuarios
GO
CREATE PROCEDURE spNetAddComunicadoUsuarios
@IDComunicado INT,
@Usuario VARCHAR(10),
@IDUsuarioTipo INT
AS
BEGIN
	IF (EXISTS(SELECT * FROM pNetUsuario WHERE Usuario = @Usuario AND IDUsuarioTipo = @IDUsuarioTipo ) AND EXISTS(SELECT * FROM pNetComunicado WHERE IDComunicado = @IDComunicado) AND NOT EXISTS(select * from pNetComunicadoXUsuario where IDComunicado = @IDComunicado AND Usuario = @Usuario AND IDUsuarioTipo = @IDUsuarioTipo))
	BEGIN 
	
		INSERT INTO pNetComunicadoXUsuario values(@IDComunicado,@Usuario,@IDUsuarioTipo)
	
		SELECT COUNT (IDComunicado) as  ID FROM pNetComunicadoXUsuario WHERE IDComunicado = @IDComunicado
	END
	ELSE
		SELECT -1 as ID
END
GO
/***************************************spNetDeleteComunicadoPerfil***************************************/
IF EXISTS(SELECT * FROM sys.objects where name = 'spNetDeleteComunicadoPerfil')
	DROP PROCEDURE spNetDeleteComunicadoPerfil
GO
CREATE PROCEDURE spNetDeleteComunicadoPerfil
@IDComunicado INT,
@IDUsuarioTipo INT
AS
BEGIN
	IF (EXISTS(SELECT * FROM pNetComunicado pnc JOIN pNetComunicadoXPerfil pncxp ON pnc.IDComunicado = pncxp.IDComunicado JOIN pNetUsuarioTipo pnut ON pnut.IDUsuarioTipo = pncxp.IDUsuarioTipo WHERE pnc.IDComunicado = @IDComunicado AND pncxp.IDUsuarioTipo = @IDUsuarioTipo))
	BEGIN 
	
		DELETE FROM pNetComunicadoXPerfil WHERE IDComunicado = @IDComunicado AND IDUsuarioTipo = @IDUsuarioTipo
	
		SELECT COUNT (IDComunicado) as  ID FROM pNetComunicadoXPerfil WHERE IDComunicado = @IDComunicado
	END
	ELSE
		SELECT -1 as ID
END
GO
/***************************************spNetDeleteComunicadoUsuario***************************************/
IF EXISTS(SELECT * FROM sys.objects where name = 'spNetDeleteComunicadoUsuario')
	DROP PROCEDURE spNetDeleteComunicadoUsuario
GO
CREATE PROCEDURE spNetDeleteComunicadoUsuario
@IDComunicado INT,
@Usuario VARCHAR(10),
@IDUsuarioTipo INT

AS
BEGIN
	IF (EXISTS(SELECT * FROM pNetUsuario WHERE Usuario = @Usuario AND IDUsuarioTipo = @IDUsuarioTipo) AND EXISTS(SELECT * FROM pNetComunicado WHERE IDComunicado = @IDComunicado))
	BEGIN 
	
		DELETE FROM pNetComunicadoXUsuario WHERE IDComunicado = @IDComunicado AND Usuario = @Usuario AND IDUsuarioTipo = @IDUsuarioTipo
	
		SELECT COUNT (IDComunicado) as  ID FROM pNetComunicadoXUsuario WHERE IDComunicado = @IDComunicado
	END
	ELSE
		SELECT -1 as ID
END
GO

/*************************spNetComunicados***************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spNetComunicados') AND type = 'P') DROP PROCEDURE dbo.spNetComunicados
GO           
CREATE PROCEDURE spNetComunicados
	@Estatus 			int	     
--//WITH ENCRYPTION	     	     
AS 
BEGIN
BEGIN TRAN
	BEGIN TRY
		SELECT
		 c.IDComunicado AS ID,
		 c.Titulo AS Titulo,
		 c.DirigidoA AS Dirigido,
		 (CONVERT(VARCHAR(24),c.FechaPublicado,113)) AS Publicado,  
		 (CONVERT(VARCHAR(24),c.FechaVigencia,113)) AS Vigencia,
		 c.Descripcion AS Descripcion,
		 c.Prioridad AS Prioridad,
		 a.Descripcion AS Tipo
		FROM pNetComunicado AS c
		INNER JOIN pnetCatComunicado AS a ON c.Tipo = a.IDCatCom
		WHERE c.Estatus = 1

	COMMIT TRAN
	END TRY
	BEGIN CATCH
		SELECT -1 Ok, ERROR_MESSAGE() OkRef
		ROLLBACK TRAN
	END CATCH
END
GO

/*************************spNetComunicadosFecha***************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spNetComunicadosFecha') AND type = 'P') DROP PROCEDURE dbo.spNetComunicadosFecha
GO           
CREATE PROCEDURE spNetComunicadosFecha
	@ID 				INT,
	@Estatus			INT,
	@FechaComunicado    VARCHAR(50)   
--//WITH ENCRYPTION	     	     
AS 
BEGIN
BEGIN TRAN
	BEGIN TRY


		SELECT * FROM vwPNETComunicados where ID = @ID AND Estatus = @Estatus 
		   AND CAST(CONVERT(CHAR(16), FechaPublicadoDate, 113) AS DATETIME)  <= @FechaComunicado 
		   AND CAST(CONVERT(CHAR(16), FechaVigenciaDate, 113) AS DATETIME) >= @FechaComunicado

	COMMIT TRAN
	END TRY
	BEGIN CATCH
		SELECT -1 Ok, ERROR_MESSAGE() OkRef
		ROLLBACK TRAN
	END CATCH
END
GO
/**************** spNetAnexoComunicado ****************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('dbo.spNetAnexoComunicado') AND type = 'P') 
	DROP PROCEDURE dbo.spNetAnexoComunicado
GO
CREATE PROCEDURE dbo.spNetAnexoComunicado
	@ID	INT,
	@Nombre VARCHAR(100),
	@Extension VARCHAR(5),
	@MimeType VARCHAR(100),
	@Size INT,
	@Archivo	VARCHAR(MAX)
AS
BEGIN
SET NOCOUNT ON

	DECLARE @strChars		AS VARCHAR(62),        
			@AnexoBase64	AS VARCHAR(8),
			@index			AS INT,
			@cont			AS INT,
			@IDb64			AS INT,
			@Ok				AS INT, 
			@OkRef			AS varchar(max)

    SET @strChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    SET @AnexoBase64 = ''


    SET @cont = 0
    WHILE @cont < 8
    BEGIN
        SET @index = ceiling((SELECT RAND()) * (len(@strChars)))
        SET @AnexoBase64 = @AnexoBase64 + substring(@strChars, @index, 1)
        SET @cont = @cont + 1
    END    
	
	IF (NULLIF(@AnexoBase64,'') IS NULL OR LEN(@AnexoBase64) <> 8)
	BEGIN
		RAISERROR ('Error al generar identificador de anexo', 18, 1)
		RETURN
	END
	
	IF (NULLIF(@Archivo,'') IS NULL OR LEN(@Archivo) < 30)
	BEGIN

		RAISERROR ('Error al cargar anexo', 18, 1)
		RETURN
	END

	BEGIN TRY

		IF  NOT EXISTS(SELECT * FROM AnexoBase64 WHERE AnexoBase64 = @AnexoBase64) AND EXISTS(SELECT * FROM pNetComunicado WHERE IDComunicado = @ID) 
		BEGIN

			INSERT INTO pNetAnexoComunicado (IDComunicado,AnexoBase64,Nombre,Extension,MimeType,Size)
			VALUES (@ID, @AnexoBase64,@Nombre,@Extension,@MimeType,@Size)

			INSERT INTO AnexoBase64 (AnexoBase64, Archivo)
			VALUES (@AnexoBase64, @Archivo)
			SELECT @IDb64 = SCOPE_IDENTITY()

		END

		IF (@@rowcount <> 1)
		BEGIN
			SET @OK = 1
			SET @OkRef = 'Error al generar el registro'
			
		END
	END TRY
	BEGIN CATCH
		
		SET @OK = 1
		SET @OkRef = ERROR_MESSAGE()
		
	END CATCH
	
	SELECT @Ok Ok, @OkRef OkRef

SET NOCOUNT OFF
END
GO

/**************** spNetGetEditAnexoComunicado ****************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('dbo.spNetGetEditAnexoComunicado') AND type = 'P') 
	DROP PROCEDURE dbo.spNetGetEditAnexoComunicado
GO
CREATE PROCEDURE dbo.spNetGetEditAnexoComunicado
	@ID	INT
AS
BEGIN
SET NOCOUNT ON

	DECLARE @strChars		AS VARCHAR(62),        
			@AnexoBase64	AS VARCHAR(8),
			@index			AS INT,
			@cont			AS INT,
			@IDb64			AS INT,
			@Ok				AS INT, 
			@OkRef			AS varchar(max),
			@urlApi			varchar(255)

	BEGIN TRY

		SELECT @urlApi = URL FROM PortalNetCfg WHERE Descripcion = 'APIMedia' AND Estatus = 'Alta'

		SELECT C.IDComunicado,
					AC.AnexoBase64,
					AC.Nombre,
					AC.Extension,
					AC.MimeType,
					AC.Size,
					@urlApi as urlApi 
					FROM pNetComunicado C 
					JOIN pNetAnexoComunicado AC ON C.IDComunicado = AC.IDComunicado 
					JOIN AnexoBase64 B64 ON AC.AnexoBase64 = B64.AnexoBase64 WHERE C.IDComunicado = @ID

		
	END TRY
	BEGIN CATCH
		
		SET @OK = 1
		SET @OkRef = ERROR_MESSAGE()
		
	END CATCH

SET NOCOUNT OFF
END
GO

/**************** spNetDeleteAnexoComunicado ****************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('dbo.spNetDeleteAnexoComunicado') AND type = 'P') 
	DROP PROCEDURE dbo.spNetDeleteAnexoComunicado
GO
CREATE PROCEDURE dbo.spNetDeleteAnexoComunicado
	@ID	INT,
	@AnexoBase64	AS VARCHAR(8)
AS
BEGIN
SET NOCOUNT ON

	DECLARE @Ok				AS INT, 
			@OkRef			AS varchar(max)

	BEGIN TRY

		IF EXISTS(SELECT C.IDComunicado,AC.AnexoBase64 FROM pNetComunicado C JOIN pNetAnexoComunicado AC ON C.IDComunicado = AC.IDComunicado JOIN AnexoBase64 B64 ON AC.AnexoBase64 = B64.AnexoBase64 WHERE AC.IDComunicado = @ID AND AC.AnexoBase64 = @AnexoBase64) 
		BEGIN
			
			DELETE FROM pNetAnexoComunicado WHERE IDComunicado = @ID AND AnexoBase64 = @AnexoBase64
			DELETE FROM AnexoBase64 WHERE AnexoBase64 = @AnexoBase64
		END

		IF (@@rowcount <> 1)
		BEGIN
			SET @OK = 1
			SET @OkRef = 'No hay registro(s)'

		END
	END TRY
	BEGIN CATCH

		SET @OK = 1
		SET @OkRef = ERROR_MESSAGE()

	END CATCH

	SELECT @Ok Ok, @OkRef OkRef

SET NOCOUNT OFF
END
GO

/********** spNetAnexoCuenta *********/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('spNetAnexoCuenta') AND type = 'P') 
	DROP PROCEDURE spNetAnexoCuenta
GO
CREATE PROCEDURE spNetAnexoCuenta
 @Rama		varchar(5)		= NULL,
 @Cuenta	varchar(20)		= NULL,
 @Documento	varchar(255)	= NULL,
 @Ruta		varchar(255)	= NULL,
 @Nombre	varchar(100)	= NULL,
 @Extension	varchar(5)		= NULL,
 @MimeType	varchar(100)	= NULL,
 @Size		int				= NULL,
 @Archivo	varchar(max)	= NULL
AS BEGIN
 DECLARE 
  @strChars		varchar(62),        
  @AnexoBase64	varchar(8),
  @index		int,
  @cont			int,
  @IDBase64		int,
  @Ok		    int, 
  @OkRef		varchar(255),
  @icono		int,
  @Tipo			varchar(10),
  @Comentario	varchar(max)

  SET @strChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
  SET @AnexoBase64 = ''

  SET @cont = 0
  WHILE @cont < 8
  BEGIN
   SET @index = ceiling((SELECT RAND()) * (len(@strChars)))
   SET @AnexoBase64 = @AnexoBase64 + substring(@strChars, @index, 1)
   SET @cont = @cont + 1
  END 

  IF (LOWER(@Extension) IN  ('png', 'jpg', 'bmp', 'gif'))
	SELECT @icono = 59, @Tipo = 'Imagen'
  IF (LOWER(@Extension) IN  ('pdf'))
	SELECT @icono = 745, @Tipo = 'Archivo'
  IF (LOWER(@Extension) IN  ('doc', 'docx'))
	SELECT @icono = 738, @Tipo = 'Archivo'
  IF (LOWER(@Extension) IN  ('xls', 'xlsx'))
    SELECT @icono = 733, @Tipo = 'Archivo'
  IF (LOWER(@Extension) IN  ('ppt', 'pptx'))
    SELECT @icono = 1, @Tipo = 'Archivo'
	
  IF NOT EXISTS(SELECT * FROM AnexoBase64 WHERE AnexoBase64 = @AnexoBase64)
  BEGIN
   INSERT INTO AnexoBase64 (AnexoBase64, Archivo) SELECT @AnexoBase64, @Archivo
   SELECT @IDBase64 = SCOPE_IDENTITY()
  END

  IF @IDBase64 IS NOT NULL
  BEGIN
   SELECT @Comentario = CONVERT(varchar(max),@IDBase64)+','+@AnexoBase64
   INSERT INTO AnexoCta(Rama, Cuenta,  Nombre,  Direccion, Documento, Alta,      UltimoCambio, Comentario,	Icono, Tipo)
			    SELECT @Rama, @Cuenta, @Nombre, @Ruta,     @Documento, GETDATE(), GETDATE(),    @Comentario, @icono, @Tipo
  END
  ELSE
    INSERT INTO AnexoCta(Rama, Cuenta,  Nombre,  Direccion, Documento, Alta,      UltimoCambio, Icono, Tipo)
			     SELECT @Rama, @Cuenta, @Nombre, @Ruta,     @Documento, GETDATE(), GETDATE(),   @icono, @Tipo

  IF ISNULL(@Rama,'') = 'NOM' SELECT @Rama = 'RH'
  IF ISNULL(@Documento,'') <> '' AND NOT EXISTS (SELECT 1 FROM DocCta WHERE Rama = @Rama AND Cuenta = @Cuenta AND Documento = @Documento)
  BEGIN
   INSERT INTO DocCta(Rama, Cuenta, Documento) SELECT @Rama, @Cuenta, @Documento
  END

 SELECT @Ok Ok, @OkRef OkRef

RETURN
END
GO

/********** spNetDeleteAnexoCuenta *********/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('spNetDeleteAnexoCuenta') AND type = 'P') 
	DROP PROCEDURE spNetDeleteAnexoCuenta
GO
CREATE PROCEDURE spNetDeleteAnexoCuenta
 @Rama			varchar(5)		= NULL,
 @Cuenta		varchar(20)		= NULL,
 @Documento		varchar(255)	= NULL,
 @Ruta			varchar(255)	= NULL,
 @Nombre		varchar(100)	= NULL
AS BEGIN
DECLARE
 @Ok			int,
 @OkRef			varchar(255),
 @AnexoBase64	varchar(8)
 
 SELECT @AnexoBase64 = SUBSTRING(CAST(Comentario as varchar(max)), charindex(',', CAST(Comentario as varchar(max)))+1, LEN(CAST(Comentario as varchar(max))))
   FROM AnexoCta WHERE Rama = @Rama AND Cuenta = @Cuenta AND Nombre = @Nombre

 DELETE FROM AnexoBase64 WHERE AnexoBase64 = @AnexoBase64
 DELETE FROM AnexoCta WHERE Rama = @Rama AND Cuenta = @Cuenta AND Nombre = @Nombre

 IF NOT EXISTS (SELECT 1 FROM AnexoCta WHERE Rama = @Rama AND Cuenta = @Cuenta AND Documento = @Documento)
 BEGIN 
  IF ISNULL(@Rama,'') = 'NOM' SELECT @Rama = 'RH'
  DELETE FROM DocCta WHERE Rama = @Rama AND Cuenta = @Cuenta AND Documento = @Documento
 END

 SELECT @Ok Ok, @OkRef OkRef

RETURN
END
GO

/**************** spNetGetAnexoCta ****************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('dbo.spNetGetAnexoCta') AND type = 'P') 
	DROP PROCEDURE dbo.spNetGetAnexoCta
GO
CREATE PROCEDURE dbo.spNetGetAnexoCta
 @Rama    varchar(10) = NULL,
 @Cuenta  varchar(20) = NULL
AS BEGIN
 DECLARE @Anexos TABLE(
  ID		  int,
  AnexoBase64 nvarchar(16),
  Ext		  varchar(10),
  Rama		  varchar(5),
  Cuenta	  varchar(20),
  Nombre	  varchar(255),
  Direccion	  varchar(255),
  Tipo		  varchar(10),
  Documento	  varchar(50))

 INSERT INTO @Anexos
 SELECT	SUBSTRING(CAST(Comentario AS VARCHAR(255)), 0, CHARINDEX(',', CAST(Comentario AS VARCHAR(255)))) ID,
	    SUBSTRING(CAST(Comentario AS VARCHAR(255)), CHARINDEX(',', CAST(Comentario AS VARCHAR(255)))+1, LEN(CAST(Comentario AS VARCHAR(255)))) AnexoBase64,
	    LOWER(REVERSE(SUBSTRING(REVERSE(Direccion),0,CHARINDEX('.',REVERSE(Direccion))))) Ext,
		Rama,
	    Cuenta,
		Nombre,
		Direccion,
		Tipo,
		Documento
   FROM	AnexoCta 
  WHERE	Rama = @Rama 
    AND Cuenta = @Cuenta

  SELECT ac.*, b.Archivo
    FROM @Anexos ac 
	JOIN AnexoBase64 b ON ac.ID = b.ID AND ac.AnexoBase64 = b.AnexoBase64

RETURN
END
GO

/********** spNetRutaAnexos *********/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('spNetRutaAnexos') AND type = 'P') 
	DROP PROCEDURE spNetRutaAnexos
GO
CREATE PROCEDURE spNetRutaAnexos
 @TipoCuenta    varchar(20) = NULL,
 @Cuenta        varchar(20) = NULL
AS BEGIN
DECLARE
 @Empresa   varchar(5),
 @Ruta      varchar(255),
 @RutaMedia varchar(max)

 IF ISNULL(@TipoCuenta,'') = 'Personal'
 BEGIN
 SELECT @Empresa = Empresa FROM Personal WHERE Personal = @Cuenta

  SELECT @Ruta = DirectorioAnexosEsp 
    FROM EmpresaGral WHERE Empresa = @Empresa

  SELECT @RutaMedia = URL
    FROM PortalNetCfg WHERE Empresa = @Empresa AND Descripcion = 'APIMedia' AND UPPER(Estatus) = 'ALTA'
 END

 SELECT @Ruta Ruta, @RutaMedia RutaMedia

RETURN
END
GO

/****************************************************Reporte Antiguedad de Saldos**************************************************/

/****************************spNetCatCteSaldo*********************************/
IF EXISTS(SELECT * FROM sys.objects where name = 'spNetCatCteSaldo')
	DROP PROCEDURE spNetCatCteSaldo
GO
CREATE PROCEDURE spNetCatCteSaldo 
    
--WITH ENCRYPTION  
AS  
BEGIN 

	SELECT Cte.Cliente,Cte.Nombre  FROM Cte
	LEFT OUTER JOIN CtaSituacion ON 'CXC'=CtaSituacion.Rama AND Cte.Situacion=CtaSituacion.Situacion
	WHERE Cte.Estatus = 'ALTA' AND Cte.Tipo<>'Estructura'
	ORDER BY Cte.Cliente 
  
END  
GO

/****************************spNetSaldosCteRango****************************/
IF EXISTS(SELECT * FROM sys.objects where name = 'spNetSaldosCteRango')
	DROP PROCEDURE spNetSaldosCteRango
GO
CREATE PROCEDURE spNetSaldosCteRango 
 @Metodo  bit
   
--WITH ENCRYPTION  
AS  
BEGIN  

	IF @Metodo = 0 
	BEGIN

		SELECT MIN(Cliente) as CteMin FROM Cte WHERE Estatus = 'ALTA'

	END
	ELSE
	BEGIN
		SELECT MAX(Cliente) as CteMax FROM Cte WHERE Estatus = 'ALTA'
	END

END 
GO

/***************************************spNetInformeCXCAntiguedadSaldos***************************************/
IF EXISTS(SELECT * FROM sys.objects where name = 'spNetInformeCXCAntiguedadSaldos')
	DROP PROCEDURE spNetInformeCXCAntiguedadSaldos
GO
CREATE PROCEDURE spNetInformeCXCAntiguedadSaldos 
	@PEmpresa				varchar(5),
    @PClienteD				varchar(10),
    @PClienteA				varchar(10),    
    @PMoneda					varchar(10),
    @PInfoDesglosar			varchar(20)
--WITH ENCRYPTION  
AS  
BEGIN 
  DECLARE
    @Empresa				varchar(5),
    @ClienteD				varchar(10),
    @ClienteA				varchar(10),    
    @Moneda					varchar(10),
    @Hoy					datetime,	
    @De01A30D				datetime,    
    @De01A30A				datetime,
    @De31A60D				datetime,
    @De31A60A				datetime,
    @De61A90D				datetime,
    @De61A90A				datetime,
	@De91A120D				datetime,
    @De91A120A				datetime,
    @MasDe120				datetime,
    @Etiqueta				bit,
    @VerGraficaDetalle		bit,
    @InfoDesglosar			varchar(20)

   DECLARE
    @Cliente varchar(10),
	@Mov varchar(21),
	@Mon varchar(10)

	SET @Empresa = @PEmpresa
	SET @ClienteD = @PClienteD
    SET @ClienteA = @PClienteA
    SET @Moneda = @PMoneda
    SET @InfoDesglosar = @PInfoDesglosar


  SET @Hoy = GETDATE()    
  
  EXEC spExtraerFecha @Hoy OUTPUT    
  
  SET @De01A30D = DATEADD(day,-30,@Hoy)  
  SET @De01A30A = DATEADD(day,-1,@Hoy)

  SET @De31A60D = DATEADD(day,-60,@Hoy)  
  SET @De31A60A = DATEADD(day,-31,@Hoy)
  
  SET @De61A90D = DATEADD(day,-90,@Hoy)  
  SET @De61A90A = DATEADD(day,-61,@Hoy)

  SET @De91A120D = DATEADD(day,-120,@Hoy)  
  SET @De91A120A = DATEADD(day,-91,@Hoy)

  SET @MasDe120 = DATEADD(day,-121,@Hoy)  
  
  --DECLARE @InfoCxcSaldo TABLE
  CREATE TABLE #InfoCxcDetSaldo
  (
   
   Cliente					varchar(10) COLLATE DATABASE_DEFAULT NULL,
   ClienteNombre			varchar(100) COLLATE DATABASE_DEFAULT NULL,   
   Moneda					varchar(10) COLLATE DATABASE_DEFAULT NULL,
   Mov						varchar(21) COLLATE DATABASE_DEFAULT NULL,
   MovID					varchar(20) COLLATE DATABASE_DEFAULT NULL,
   Referencia				varchar(50) COLLATE DATABASE_DEFAULT NULL,   
   FechaEmision				datetime,
   Vencimiento				datetime,
   DiasMoratorios			int,
   AlCorriente				float,
   Plazo1					float,  
   Plazo2					float,     
   Plazo3					float,        
   Plazo4					float,           
   PlazoMayor					float
  
  )   
  
  --Obtiene los valores de los Plazos para la Antigüedad de Saldos
  INSERT INTO #InfoCxcDetSaldo (Cliente,ClienteNombre,Moneda,Mov,MovID,Referencia,FechaEmision,Vencimiento,DiasMoratorios,AlCorriente,Plazo1,Plazo2,Plazo3,Plazo4,PlazoMayor)			
   SELECT
    CxcInfo.Cliente,
    Cte.Nombre,
    CxcInfo.Moneda,
    CxcInfo.Mov,
    CxcInfo.MovID,
    CxcInfo.Referencia,
    CxcInfo.FechaEmision,
    CxcInfo.Vencimiento,
    ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN DATEDIFF(DAY, CxcInfo.Vencimiento, @Hoy) END,0) as DiasMoratorios,
    CASE WHEN ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN DATEDIFF(DAY, CxcInfo.Vencimiento, @Hoy) END,0) <= 0 THEN ISNULL(CxcInfo.Saldo,0)  ELSE 0 END as Alcorriente,
    CASE WHEN CxcInfo.Vencimiento BETWEEN @De01A30D AND @De01A30A AND ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN CxcInfo.DiasMoratorios END,0) > 0 THEN ISNULL(CxcInfo.Saldo,0) ELSE 0 END as Plazo1,        
    CASE WHEN CxcInfo.Vencimiento BETWEEN @De31A60D AND @De31A60A AND ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN CxcInfo.DiasMoratorios END,0) > 0 THEN ISNULL(CxcInfo.Saldo,0) ELSE 0 END as Plazo2,           
    CASE WHEN CxcInfo.Vencimiento BETWEEN @De61A90D AND @De61A90A AND ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN CxcInfo.DiasMoratorios END,0) > 0 THEN ISNULL(CxcInfo.Saldo,0) ELSE 0 END as Plazo3,
	CASE WHEN CxcInfo.Vencimiento BETWEEN @De91A120D AND @De91A120A AND ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN CxcInfo.DiasMoratorios END,0) > 0 THEN ISNULL(CxcInfo.Saldo,0) ELSE 0 END as Plazo4,
    CASE WHEN CxcInfo.Vencimiento <= @MasDe120 AND ISNULL(CASE WHEN CxcInfo.Saldo > 0.00 THEN CxcInfo.DiasMoratorios END,0) > 0 THEN ISNULL(CxcInfo.Saldo,0) ELSE 0 END as PlazoMayor
	
    FROM CxcInfo JOIN Cte 
      ON CxcInfo.Cliente = Cte.Cliente	

   WHERE CxcInfo.Empresa = @Empresa 
     AND CxcInfo.Cliente BETWEEN  @ClienteD AND @ClienteA 
     AND CxcInfo.Moneda = ISNULL(@Moneda, CxcInfo.Moneda) 
   ORDER BY CxcInfo.Cliente, CxcInfo.Moneda, CxcInfo.Mov, CxcInfo.Vencimiento DESC 

   --Generacion de Resultado con Detalle
   IF @PInfoDesglosar = 'Si'
   BEGIN
		SELECT * FROM #InfoCxcDetSaldo 
   END
   ELSE
   BEGIN

	  --Generacion de Resultyado sin Detalle
	  SELECT DISTINCT Cliente, Moneda, SUM(ISNULL(AlCorriente,0.0)) as AlCorriente, SUM(ISNULL(Plazo1,0.0)) as Plazo1, SUM(ISNULL(Plazo2,0.0)) as Plazo2,  SUM(ISNULL(Plazo3,0.0)) as Plazo3, SUM(ISNULL(Plazo4,0.0)) as Plazo4 , SUM(ISNULL(PlazoMayor,0.0)) as PlazoMayor FROM #InfoCxcDetSaldo 
	  WHERE #InfoCxcDetSaldo.Cliente  BETWEEN  @ClienteD AND @ClienteA--= 'TA1D' 
	  GROUP BY Cliente, Moneda ORDER BY  Cliente, Moneda

   END 

   DROP TABLE #InfoCxcDetSaldo

END
GO

/********************************************************************** Eventualidades **********************************************************************/

/****** spNetRegistrarEvento ******/				
if exists (select * from sysobjects where id = object_id('dbo.spNetRegistrarEvento') and type = 'P') drop procedure dbo.spNetRegistrarEvento
GO
CREATE PROC spNetRegistrarEvento
    @Fecha			datetime = NULL,
	@Identificacion varchar(100) = NULL,
	@Acomp			varchar(255) = NULL,
	@Apartamento	varchar(100) = NULL,
	@Cliente		varchar(10)  = NULL,
	@Torre			varchar(100) = NULL,
	@Matricula		varchar(20)  = NULL,
	@Cajon			varchar(50)  = NULL,
	@Comentarios	varchar(max) = NULL
AS BEGIN
   
   INSERT INTO pNetEventualidades(Fecha,Identificacion,Acomp,Apartamento,Cliente,Torre,Matricula, Cajon, Comentarios)
	SELECT @Fecha,@Identificacion,@Acomp,@Apartamento,@Cliente,@Torre,@Matricula,@Cajon,@Comentarios


   SELECT 'Evento registrado'
RETURN
END
GO

/**************************************************************************************** Checador *******************************************************************/
/**************** spApp_GenChecador ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spApp_GenChecador') and type = 'P') 
	DROP PROCEDURE dbo.spApp_GenChecador
GO
CREATE PROC dbo.spApp_GenChecador
	@Personal		varchar(10),
	@MapaLatitud	float,
	@MapaLongitud	float,
	@Archivo		varchar(max) = NULL
AS
BEGIN SET NOCOUNT ON

DECLARE @Cuenta varchar(20), @Color varchar(50), @Mensaje varchar(MAX), @Retardo int, @Empresa varchar(5), @Usuario varchar(10), @Sucursal int
DECLARE @Nombre varchar(30), @ApellidoPaterno varchar(30), @ApellidoMaterno varchar(30), @Estatus char(15), @EstaPresente bit, @FechaNacimiento datetime, @Direccion varchar(255)
DECLARE @FechaActual datetime = GETDATE()
DECLARE @tmpSPResult AS TABLE (Color varchar(50), Mensaje varchar(MAX), Retardo int)

SELECT @Empresa = Empresa, @Sucursal = SucursalTrabajo FROM Personal WHERE Personal = @Personal
SELECT @Usuario = Usuario, @Sucursal = CASE WHEN @Sucursal IS NULL THEN Sucursal ELSE @Sucursal END FROM Usuario WHERE Personal = @Personal
-- SELECT @Cuenta = Cuenta FROM CB WHERE Codigo = @Personal AND TipoCuenta = 'Personal' -- Biometrico

IF (@Personal IS NULL OR NOT EXISTS(SELECT Personal FROM Personal WHERE Personal = @Personal))
BEGIN
	SELECT Mensaje Ok, Descripcion OkRef FROM MensajeLista WHERE Mensaje = 20950
	return
END
IF (@Sucursal IS NULL)
BEGIN
	SELECT Mensaje Ok, Descripcion OkRef FROM MensajeLista WHERE Mensaje = 10200
	return
END
IF (@Empresa IS NULL)
BEGIN
	SELECT Mensaje Ok, Descripcion OkRef FROM MensajeLista WHERE Mensaje = 26070
	return
END

BEGIN TRY 
	INSERT INTO @tmpSPResult EXEC xpAccesoControl @Empresa = @Empresa, @Sucursal = @Sucursal, @Usuario = @Usuario, @Codigo = @Personal, @FechaHora = @FechaActual
	SELECT @Color = Color, @Mensaje = Mensaje, @Retardo = Retardo FROM @tmpSPResult

	SELECT @Nombre = A.Nombre, @ApellidoPaterno = A.ApellidoPaterno, @ApellidoMaterno = A.ApellidoMaterno, @Estatus = A.Estatus, @EstaPresente = PP.EstaPresente, @FechaNacimiento = A.FechaNacimiento, @Direccion = B.Direccion
	FROM Personal A LEFT OUTER JOIN AnexoCta B ON (B.Cuenta = A.Personal AND UPPER(B.Nombre) = 'Foto' AND B.Tipo = 'Imagen') LEFT OUTER JOIN Personal PP ON PP.Personal = A.Personal WHERE A.Personal = @Personal

	EXEC dbo.spAsisteRegistro @Empresa = @Empresa, @Sucursal = 0, @Usuario = @Usuario, @Personal = @Personal, @EstaPresente = @EstaPresente, @Retardo = @Retardo, @FechaHora = @FechaActual
	
	-- Anexo
	DECLARE @ID				AS INT, 
			@IDR			AS INT,
			@strChars		AS VARCHAR(62),        
			@AnexoBase64	AS VARCHAR(8),
			@index			AS INT,
			@cont			AS INT,
			@IDb64			AS INT

    SET @strChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    SET @AnexoBase64 = ''

    SET @cont = 0
    WHILE @cont < 8
    BEGIN
        SET @index = ceiling((SELECT RAND()) * (len(@strChars)))
        SET @AnexoBase64 = @AnexoBase64 + substring(@strChars, @index, 1)
        SET @cont = @cont + 1
    END    
        
	IF (NULLIF(@AnexoBase64,'') IS NULL OR LEN(@AnexoBase64) <> 8)
	BEGIN
		RAISERROR ('Error al generar identificador de imágen', 18, 1)
		RETURN
	END

	-- Se obtiene con Top el registro para no modificar scripts actuales --
	SELECT TOP 1 @ID = ID, @IDR = Renglon FROM AsisteD WHERE Personal = @Personal and FechaA = CONVERT(VARCHAR(10), GETDATE(), 112) ORDER BY FechaA DESC, HoraRegistro DESC, ID DESC, Renglon DESC
	UPDATE AsisteD SET MapaLatitud = @MapaLatitud, MapaLongitud = @MapaLongitud WHERE ID = @ID AND Renglon = @IDR 
	INSERT INTO AnexoBase64 (Rama, ID, IDR, AnexoBase64, Archivo) SELECT 'ASIS', @ID , @IDR, @AnexoBase64, @Archivo

	SELECT	LTRIM(RTRIM(@Nombre + ISNULL(' ' + @ApellidoPaterno, '') + ISNULL(' ' + @ApellidoMaterno, ''))) Nombre, LTRIM(RTRIM(@Color)) Color, LTRIM(RTRIM(@Mensaje)) Mensaje,LTRIM(RTRIM(@Direccion)) Direccion
			-- , @Usuario Usuario, @Sucursal Sucursal, @Empresa Empresa, @Retardo Retardo, @Nombre Nombre, @ApellidoPaterno ApellidoPaterno, @ApellidoMaterno ApellidoMaterno, @Estatus Estatus, PP.EstaPresente, @FechaNacimiento FechaNacimiento
	  FROM	Personal PP WHERE PP.Personal = @Personal
END TRY
BEGIN CATCH
	SELECT '-1' Ok, ERROR_MESSAGE() OkRef
	return
END CATCH
SET NOCOUNT OFF
END
GO
/********************************************************************** Configuraciones PortalNet **********************************************************************/
/****** spNetDeleteCfg ******/
IF EXISTS(SELECT * FROM sys.objects where name = 'spNetDeleteCfg') DROP PROCEDURE spNetDeleteCfg
GO
CREATE PROCEDURE spNetDeleteCfg
 @Empresa		varchar(5)  = NULL,
 @Descripcion	varchar(80) = NULL,
 @VisiblePara	varchar(10)	= NULL
AS BEGIN
 
 IF ISNULL(@VisiblePara,'') = 'Usuario'
 BEGIN
  DELETE FROM PortalNetCfgXUsuario WHERE Empresa = @Empresa AND Descripcion = @Descripcion 
  IF EXISTS(SELECT 1 FROM PortalNetCfgXPerfil WHERE Empresa = @Empresa AND Descripcion = @Descripcion)
   DELETE FROM PortalNetCfgXPerfil WHERE Empresa = @Empresa AND Descripcion = @Descripcion 
 END
 ELSE IF ISNULL(@VisiblePara,'') = 'Perfil'
 BEGIN
  DELETE FROM PortalNetCfgXPerfil WHERE Empresa = @Empresa AND Descripcion = @Descripcion 
  IF EXISTS(SELECT 1 FROM PortalNetCfgXUsuario WHERE Empresa = @Empresa AND Descripcion = @Descripcion)
   DELETE FROM PortalNetCfgXUsuario WHERE Empresa = @Empresa AND Descripcion = @Descripcion 
 END

 SELECT 'Registros Actualizados'
RETURN
END
GO

/****** spNetAddCfgXUsuario ******/
IF EXISTS(SELECT * FROM sys.objects where name = 'spNetAddCfgXUsuario') DROP PROCEDURE spNetAddCfgXUsuario
GO
CREATE PROCEDURE spNetAddCfgXUsuario
 @Empresa		varchar(5)  = NULL,
 @Descripcion	varchar(80) = NULL,
 @IDUsuario 	int			= NULL
AS BEGIN
 IF NOT EXISTS(SELECT 1 FROM PortalNetCfgXUsuario WHERE Empresa = @Empresa AND Descripcion = @Descripcion AND IDUsuario = @IDUsuario)
  INSERT INTO PortalNetCfgXUsuario SELECT @Empresa, @Descripcion, @IDUsuario

 SELECT 'Registro actualizado'	
END
GO


/****** spNetAddCfgXPerfil ******/
IF EXISTS(SELECT * FROM sys.objects where name = 'spNetAddCfgXPerfil') DROP PROCEDURE spNetAddCfgXPerfil
GO
CREATE PROCEDURE spNetAddCfgXPerfil
 @Empresa		varchar(5)  = NULL,
 @Descripcion	varchar(80) = NULL,
 @IDUsuarioTipo	int			= NULL
AS BEGIN
 IF NOT EXISTS(SELECT 1 FROM PortalNetCfgXPerfil WHERE Empresa = @Empresa AND Descripcion = @Descripcion AND IDUsuarioTipo = @IDUsuarioTipo)
  INSERT INTO PortalNetCfgXPerfil SELECT @Empresa, @Descripcion, @IDUsuarioTipo

 SELECT 'Registro actualizado'	
END
GO

/****** spNetGuardarCfg ******/				
if exists (select * from sysobjects where id = object_id('dbo.spNetGuardarCfg') and type = 'P') drop procedure dbo.spNetGuardarCfg
GO
CREATE PROC spNetGuardarCfg
 @Empresa			varchar(5)	 = NULL,
 @VisiblePara		varchar(10)  = NULL,
 @APIMedia			varchar(255) = NULL,	
 @APIMediaEstatus	varchar(15)  = NULL,
 @Proyectos			varchar(255) = NULL,
 @ProyectosEstatus	varchar(15)  = NULL
AS BEGIN

 IF ISNULL(@Empresa,'') <> '' AND EXISTS(SELECT 1 FROM PortalNetCfg WHERE Empresa = @Empresa AND Descripcion = 'APIMedia')
  UPDATE PortalNetCfg SET URL = @APIMedia, Estatus = @APIMediaEstatus WHERE Empresa = @Empresa AND Descripcion = 'APIMedia'
 ELSE
  INSERT INTO PortalNetCfg(Empresa, URL, Descripcion, Estatus) SELECT @Empresa, @APIMedia, 'APIMedia', @APIMediaEstatus

 IF ISNULL(@Empresa,'') <> '' AND EXISTS(SELECT 1 FROM PortalNetCfg WHERE Empresa = @Empresa AND Descripcion = 'Proyectos')
  UPDATE PortalNetCfg SET URL = @Proyectos, Estatus = @ProyectosEstatus, VisiblePara = @VisiblePara  WHERE Empresa = @Empresa AND Descripcion = 'Proyectos'
 ELSE
  INSERT INTO PortalNetCfg(Empresa, URL, Descripcion, Estatus, VisiblePara) SELECT @Empresa, @Proyectos, 'Proyectos', @ProyectosEstatus, @VisiblePara

 SELECT 'Configuración actualizada con éxito'

RETURN
END
GO

/********************************************************************** Incidencias Personal **********************************************************************/
/**************** spNetIncidenciasPersonal ****************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('dbo.spNetIncidenciasPersonal') AND type = 'P') 
	DROP PROCEDURE dbo.spNetIncidenciasPersonal
GO
CREATE PROCEDURE dbo.spNetIncidenciasPersonal
 @Personal		varchar(10),
 @FechaD		datetime = NULL,
 @FechaA		datetime = NULL
AS BEGIN
 --Tabla Temporal MES
 DECLARE @TablaMES TABLE (Fecha DATETIME)

 --Tabla Temporal DiasLaborables
 DECLARE @TablaDiasLaborables TABLE (Fecha datetime)

 --Tabla Temporal 
 DECLARE @TablaJornada TABLE (
  Personal		varchar(10),
  Jornada		varchar(20),
  Dia			int,
  Entrada		varchar(5))

 --Tabla Incidencias 
 DECLARE @TablaIncidencias TABLE (
  ID			int,
  Renglon		float,
  MovClave		varchar(20),
  Mov			varchar(20),
  MovID			varchar(20),
  Personal		varchar(10),
  Registro		varchar(25), 
  HoraRegistro	varchar(5), 
  HoraD			time, 
  HoraA			time,
  FechaD		datetime, 
  FechaA		datetime,
  Concepto		varchar(50),
  Incidencia	varchar(50),
  Observaciones varchar(100))

 --Tabla Incidencias 
 DECLARE @TablaRegistros TABLE (
  ID			int,
  Renglon		float,
  MovClave		varchar(20),
  Mov			varchar(20),
  MovID			varchar(20),
  Personal		varchar(10),
  Registro		varchar(25), 
  HoraRegistro	varchar(5),
  HoraD			time, 
  HoraA			time, 
  FechaD		datetime, 
  FechaA		datetime,
  Concepto		varchar(50),
  Incidencia	varchar(50),
  Observaciones varchar(100))

 --Registro Final
 DECLARE @PrepFinal TABLE(
  ID			int identity(1,1),
  Registro		varchar(255),
  Concepto		varchar(255),
  Incidencia	varchar(255),
  FechaD		datetime,
  FechaA		datetime)

 DECLARE @Final TABLE(
  id			int identity(1,1),
  title			varchar(255),
  className		varchar(255),
  start			datetime,
  [end]			datetime)

 --Se obtiene el Primer dia  y último de cada Mes 
 DECLARE 
  @FirstDOM			datetime, 
  @LastDOM			datetime,
 --Se Forma el Mes Completo 
  @MinDate			date,
  @MaxDate			date,
 --Cursor de Incidencias del Empleado
  @I_ID				int,
  @I_Renglon		float,
  @I_MovClave		varchar(20),
  @I_Mov			varchar(20),
  @I_MovID			varchar(20),
  @I_Personal		varchar(10),
  @I_Registro		varchar(10), 
  @I_HoraRegistro	varchar(5), 
  @I_HoraD			time, 
  @I_HoraA			time,
  @I_FechaD			datetime, 
  @I_FechaA			datetime,
  @I_Concepto		varchar(50),
  @I_Incidencia		varchar(50),
  @I_Observaciones  varchar(100),
 --Cursor de Incidencias del Empleado
  @FIni				datetime,
  @FFin				datetime,
  @FechaIncidencia	datetime,
 --Cursor de Registros del Empleado
  @R_Fecha			datetime,
  @R_ID				int,
  @R_Renglon		float,
  @R_MovClave		varchar(20),
  @R_Mov			varchar(20),
  @R_MovID			varchar(20),
  @R_Personal		varchar(10),
  @R_Registro		varchar(10), 
  @R_HoraRegistro	varchar(5), 
  @R_HoraD			time, 
  @R_HoraA			time,
  @R_FechaD			datetime, 
  @R_FechaA			datetime,
  @R_Concepto		varchar(50),
  @R_Incidencia		varchar(50),
  @R_Observaciones	varchar(100),
 --Cursor de Registros del Empleado
  @FR				datetime,
  @Dia_W			int,
  @HR				time,
  @HR1				time,
  @HR2				time,
  @time_2			time,
  @time_1			time,
  @time_Acceso		int,
  @time_ToletenciaEntrada int,
 -- Empresa y Jornada del Personal
  @Empresa			varchar(5),
  @Jornada			varchar(20),
 -- Validación de clases (para página de calendario)
  @ID				int,
  @Fecha			datetime,
  @Incidencia		varchar(255),
  @title			varchar(255),
  @classN			varchar(355)

  SELECT @Empresa = Empresa, @Jornada = Jornada FROM Personal WHERE Personal = @Personal
  --Minutos de Tolerancia
  SELECT @time_ToletenciaEntrada = AsisteToleraEntrada FROM EmpresaCfg WHERE Empresa = @Empresa

  IF @FechaD IS NULL
   SELECT @FechaD = MIN(Fecha) FROM JornadaTiempo WHERE Jornada = @Jornada
  IF @FechaA IS NULL
   SELECT @FechaA = MAX(Fecha) FROM JornadaTiempo WHERE Jornada = @Jornada

  SELECT @MinDate = @FechaD, @MaxDate = @FechaA

  INSERT INTO @TablaMES
  SELECT TOP (DATEDIFF(DAY, @MinDate, @MaxDate) + 1)
		 Date = DATEADD(DAY, ROW_NUMBER() OVER(ORDER BY a.object_id) - 1, @MinDate)
	FROM sys.all_objects a
   CROSS JOIN sys.all_objects b;

 --Incidencias
 INSERT INTO @TablaIncidencias
 SELECT a.ID, ad.Renglon, mt.Clave, a.Mov,a.MovID,ad.Personal,ad.Registro,ad.HoraRegistro,ad.HoraD,ad.HoraA,ad.FechaD,ad.FechaA,ad.Concepto, NULL,a.Observaciones
   FROM Asiste a 
   JOIN AsisteD ad ON a.ID = ad.ID
   JOIN MovTipo mt ON 'ASIS' = mt.Modulo AND a.Mov = mt.Mov
  WHERE mt.Clave NOT IN ('ASIS.R','ASIS.A','ASIS.C', 'ASIS.RA')	 
	AND a.Estatus NOT IN ('SINAFECTAR','CANCELADO')
	AND dbo.fnFechaSinHora(ad.FechaD) BETWEEN @FechaD AND @FechaA
	AND ad.Personal = @Personal
	
 --Registros
 INSERT INTO @TablaRegistros
 SELECT a.ID, ad.Renglon, mt.Clave, a.Mov,a.MovID,ad.Personal,ad.Registro,ad.HoraRegistro,ad.HoraD,ad.HoraA,ad.FechaD,ad.FechaA,ad.Concepto, NULL,a.Observaciones
  FROM Asiste a 
  JOIN AsisteD ad ON a.ID = ad.ID
  JOIN MovTipo mt ON 'ASIS' = mt.Modulo AND a.Mov = mt.Mov
 WHERE mt.Clave IN ('ASIS.R','ASIS.A') 
-- AND Registro IN ('Entrada')
   AND a.Estatus NOT IN ('SINAFECTAR','CANCELADO')
   AND dbo.fnFechaSinHora(ad.FechaD) BETWEEN @FechaD AND @FechaA
   AND ad.Personal = @Personal

 --Jornada del Personal
 INSERT INTO @TablaJornada
 SELECT p.Personal, j.Jornada,jd.Dia,MIN(jd.Entrada) Entrada
   FROM Personal p 
   JOIN Jornada j ON p.Jornada = j.Jornada
   JOIN JornadaD jd ON j.Jornada = jd.Jornada
  WHERE p.Personal = @Personal
  GROUP BY p.Personal, j.Jornada,jd.Dia

 --Obtiene Días Laborables
 INSERT INTO @TablaDiasLaborables
 SELECT Fecha FROM @TablaMES WHERE DATEPART(dw,CONVERT(DATE,Fecha-1)) IN (SELECT Dia FROM @TablaJornada)

 -- Cursor Incidencias. Inicio
 DECLARE db_cursor CURSOR FOR  
 SELECT ID, Renglon, MovClave, Mov,MovID,Personal,Registro,HoraRegistro,HoraA, FechaD,FechaD,FechaA,Concepto, Incidencia,Observaciones FROM @TablaIncidencias 
 OPEN db_cursor   
 FETCH NEXT FROM db_cursor INTO @I_ID, @I_Renglon, @I_MovClave, @I_Mov,@I_MovID,@I_Personal,@I_Registro, @I_HoraRegistro,@I_HoraD,@I_HoraA, @I_FechaD, @I_FechaA,@I_Concepto,@I_Incidencia,@I_Observaciones
 WHILE @@FETCH_STATUS = 0   
 BEGIN  
  
  -- Inicializar variables
  SELECT @FIni = NULL, @FFin = NULL, @FechaIncidencia = NULL
 
  --Rango de Fechas de la Incidencia Ej. Vacaciones / Permisos Dias
  SELECT @FIni = FechaD, @FFin = FechaA  FROM @TablaIncidencias WHERE ID = @I_ID
			
  --Fechas Incidencia
  INSERT INTO @TablaRegistros
  SELECT @I_ID AS ID, @I_Renglon AS Renglon, @I_MovClave AS MovClave, @I_Mov AS Mov,@I_MovID as MovID,@I_Personal as Personal,@I_Registro as Registro, @I_HoraRegistro as HoraRegistro,@I_HoraD as HoraD,@I_HoraA as HoraA, Fecha,Fecha,@I_Concepto as Concepto, '' as Incidencia, @I_Observaciones as Observaciones
	FROM @TablaMES 
   WHERE DATEPART( dw,Fecha-1) IN (SELECT Dia FROM @TablaJornada) AND Fecha BETWEEN  @FIni AND @FFin

  --Identificacion de Ausencias
  IF @I_MovClave IN ('ASIS.AU')
   UPDATE @TablaRegistros SET Concepto = 'Ausente', Registro = 'Ausente' WHERE ID = @I_ID AND Mov = @I_Mov AND Personal = @I_Personal AND MovClave IN ('ASIS.AU') 
 
  --Permisos Justificados Vacaciones, Incapacidad, Permisos de Ausentarse
  IF @I_MovClave IN ('ASIS.PD', 'ASIS.PH')
   UPDATE @TablaRegistros SET Incidencia = 'Justificado', Registro = 'Justificado' WHERE ID = @I_ID AND Mov = @I_Mov AND Personal = @I_Personal AND MovClave IN ('ASIS.PD', 'ASIS.PH')
  ELSE
   UPDATE @TablaRegistros SET Incidencia = Concepto WHERE ID = @I_ID AND Mov = @I_Mov AND Personal = @I_Personal 

  --Horas o Dias Laborables Extras
  IF @I_MovClave IN ('ASIS.PH') AND DATEPART(dw,@FIni -1) NOT IN (SELECT Dia FROM @TablaJornada)
   INSERT INTO @TablaRegistros
   SELECT @I_ID AS ID, @I_Renglon AS Renglon, @I_MovClave AS MovClave, @I_Mov AS Mov,@I_MovID as MovID,@I_Personal as Personal,'Fuera de Jornada Laboral' as Registro, @I_HoraRegistro as HoraRegistro,@I_HoraD as HoraD,@I_HoraA as HoraA, Fecha,Fecha,@I_Concepto as Concepto, 'Fuera de Jornada Laboral' as Incidencia, @I_Observaciones as Observaciones
	 FROM @TablaMES 
  	WHERE DATEPART(dw,Fecha-1) NOT IN (SELECT Dia FROM @TablaJornada) AND Fecha BETWEEN  @FIni AND @FFin

 FETCH NEXT FROM db_cursor INTO @I_ID, @I_Renglon, @I_MovClave, @I_Mov,@I_MovID,@I_Personal,@I_Registro, @I_HoraRegistro,@I_HoraD,@I_HoraA, @I_FechaD, @I_FechaA,@I_Concepto,@I_Incidencia,@I_Observaciones
 END   
 CLOSE db_cursor   
 DEALLOCATE db_cursor
 -- Cursor Incidencias. Fin

 -- Cursor Registros. Inicio
 DECLARE db_cursor_reg CURSOR FOR  
 SELECT * FROM @TablaDiasLaborables tdl LEFT OUTER JOIN @TablaRegistros tr ON tdl.Fecha = tr.FechaD ORDER BY Fecha,FechaD, ID DESC
 OPEN db_cursor_reg   
 FETCH NEXT FROM db_cursor_reg INTO @R_Fecha,@R_ID, @R_Renglon, @R_MovClave, @R_Mov,@R_MovID,@R_Personal,@R_Registro, @R_HoraRegistro,@R_HoraD,@R_HoraA, @R_FechaD, @R_FechaA,@R_Concepto,@R_Incidencia,@R_Observaciones
 WHILE @@FETCH_STATUS = 0   
 BEGIN 

  -- Inicializar variables 
  SELECT @FR = NULL, @Dia_W = NULL, @HR = NULL, @HR1 = NULL, @HR2 = NULL,@time_2 = NULL, @time_1 = NULL, @time_Acceso = NULL
   
  IF @R_MovClave = 'ASIS.A'
  BEGIN
   SET @HR1 = @R_HoraD
   SET @HR2 = @R_HoraA

   UPDATE @TablaRegistros SET Registro = 'Entrada', HoraRegistro = @R_HoraD
	WHERE MovClave = 'ASIS.A' AND  ID = @R_ID AND Renglon = @R_Renglon
					
   INSERT INTO @TablaRegistros 
     SELECT 0, 0, @R_MovClave,@R_Mov,@R_MovID,@R_Personal,'Salida', @HR2,@HR1,@HR2 , @R_FechaD , @R_FechaA ,@R_Concepto,'Asistencia',@R_Observaciones
  END
   
  --Hora de registro del Empleado
  SET @time_2 = @R_HoraRegistro
				
  --Dia de la Jornada
  SELECT @Dia_W =(DATEPART(dw,tr.FechaD) -1), @FR = tr.FechaD ,@HR =  tr.HoraRegistro FROM @TablaRegistros tr WHERE tr.ID = @R_ID AND tr.MovClave = 'ASIS.R'

  --Hora de Entrada segun la Jornada
  SELECT @time_1 = Entrada FROM @TablaJornada WHERE Dia = @Dia_W

  -- Operacion para Identificar Retardo
  IF @time_2 >= @time_1
   SELECT @time_Acceso = DATEDIFF(mi, @time_1,@time_2)
  ELSE IF @time_2 < @time_1
   SELECT @time_Acceso = DATEDIFF(mi,@time_2,@time_1)

  --Registro de Retardos
  IF  @time_Acceso > ISNULL(@time_ToletenciaEntrada,0) AND @R_MovClave IN ('ASIS.R','ASIS.A')  AND @R_Registro = 'Entrada' 
  BEGIN
   UPDATE @TablaRegistros SET Concepto = 'Retardo'--, Registro = 'Retardo'
    WHERE ID = @R_ID AND Mov = @R_Mov AND Personal = @R_Personal AND MovClave IN ('ASIS.R','ASIS.A') AND Registro = 'Entrada'
      AND HoraRegistro IN (SELECT TOP 1 HoraRegistro FROM @TablaRegistros
							WHERE MovClave IN ('ASIS.R','ASIS.A') AND Registro = 'Entrada' 
							  AND FechaD = @R_FechaD AND Personal = @R_Personal ORDER BY ID)
  END
  ELSE IF @time_Acceso <= ISNULL(@time_ToletenciaEntrada,0) IF @R_MovClave IN ('ASIS.R','ASIS.A') 
  BEGIN 
   UPDATE @TablaRegistros SET Incidencia = 'Asistencia'--, Registro = @R_Registro 
	WHERE ID = @R_ID AND Mov = @R_Mov AND Personal = @R_Personal AND MovClave IN ('ASIS.R','ASIS.A') AND Registro = 'Entrada'
	  AND HoraRegistro IN (SELECT TOP 1 HoraRegistro FROM @TablaRegistros
							WHERE MovClave IN ('ASIS.R','ASIS.A') AND Registro = 'Entrada' 
							  AND FechaD = @R_FechaD AND Personal = @R_Personal ORDER BY ID)
  END
  --Registrando Faltas No Identificadas
  IF @R_ID IS NULL AND @R_Fecha IS NOT NULL AND @R_Fecha NOT IN (SELECT Fecha FROM JornadaDiaFestivo WHERE Fecha = @R_Fecha) AND @R_Fecha <= GETDATE()
   INSERT INTO @TablaRegistros SELECT 0, 0, '', 'Falta',NULL,@R_Personal,'Falta',CONVERT(TIME,GETDATE()),@R_HoraD,@R_HoraA,@R_Fecha,@R_Fecha,'Falta', 'Falta',@R_Observaciones
  --Dias Festivos No Laborables
  ELSE IF @R_ID IS NULL AND @R_Fecha IS NOT NULL AND @R_Fecha IN (SELECT Fecha FROM JornadaDiaFestivo WHERE Fecha = @R_Fecha)
   INSERT INTO @TablaRegistros SELECT 0, 0, '','Día Festivo',NULL,@R_Personal,'Festivo',CONVERT(TIME,GETDATE()),@R_HoraD,@R_HoraA,@R_Fecha,@R_Fecha,'Día Festivo','Día Festivo',@R_Observaciones

 FETCH NEXT FROM db_cursor_reg INTO @R_Fecha,@R_ID, @R_Renglon, @R_MovClave, @R_Mov,@R_MovID,@R_Personal,@R_Registro, @R_HoraRegistro,@R_HoraD,@R_HoraA, @R_FechaD, @R_FechaA,@R_Concepto,@R_Incidencia,@R_Observaciones
 END   
 CLOSE db_cursor_reg   
 DEALLOCATE db_cursor_reg
 -- Cursor Registros. Fin

 --Actualización de Incidencia
 UPDATE @TablaRegistros SET Incidencia = Concepto WHERE ISNULL(Incidencia,'') = ''

 INSERT INTO @PrepFinal(Registro, Concepto, Incidencia, FechaD, FechaA)
 SELECT 
  CASE 
   WHEN tr.ID IS NULL AND tr.MovClave IS NULL THEN 'No Laborable'
   WHEN tr.ID IS NOT NULL AND tr.MovClave IS NOT NULL THEN tr.Registro  
  END Registro,
  tr.Concepto,
  CASE 
   WHEN ID IS NULL AND MovClave IS NULL THEN 'No Laborable'
   WHEN ID IS NOT NULL AND MovClave IS NOT NULL THEN tr.Incidencia 
  END Incidencia,
  DATEADD(HOUR,CONVERT(int,LEFT(tr.HoraRegistro, 2)), DATEADD(MINUTE,CONVERT(int,RIGHT(tr.HoraRegistro, 2)),tr.FechaD)) FechaD, 
  DATEADD(HOUR,CONVERT(int,LEFT(tr.HoraRegistro, 2)), DATEADD(MINUTE,CONVERT(int,RIGHT(tr.HoraRegistro, 2)),tr.FechaA)) FechaA
  FROM @TablaMES tdl LEFT OUTER JOIN @TablaRegistros tr ON tdl.Fecha = tr.FechaD 
 WHERE tr.FechaD IS NOT NULL 
 ORDER BY DATEADD(HOUR,CONVERT(int,LEFT(tr.HoraRegistro, 2)), DATEADD(MINUTE,CONVERT(int,RIGHT(tr.HoraRegistro, 2)),tr.FechaD)), ID 

 SELECT @Fecha = MIN(dbo.fnFechaSinHora(FechaD)) FROM @PrepFinal
 WHILE @Fecha IS NOT NULL
 BEGIN
   SELECT @Incidencia = NULL, @title = NULL
   SELECT TOP 1 @Incidencia = Incidencia, @title = Concepto FROM @PrepFinal WHERE dbo.fnFechaSinHora(FechaD) = @Fecha AND ISNULL(Incidencia,'') <> ''
   SELECT @classN = CASE ISNULL(@Incidencia,'')
     WHEN 'Día Festivo' THEN 'diafestivo labelE'
	 WHEN 'Ausente' THEN 'falta labelE'
	 WHEN 'Fuera de Jornada Laboral' THEN 'domingo labelE'
	 WHEN 'Asistencia' THEN 'asistencia labelE'
	 WHEN 'Retardo' THEN 'retardo labelE'
	 WHEN 'Justificado' THEN 'justificado labelE'
	 WHEN 'Falta' THEN 'falta labelE'
      END

   IF ISNULL(@title,'') = '' SELECT @title = @Incidencia
   -- Insertar titulo de la Incidencia
   IF ISNULL(@title,'') = '' 
    INSERT INTO @Final (title, className, start, [end]) SELECT Registro, NULL, FechaD, FechaA FROM @PrepFinal WHERE dbo.fnFechaSinHora(FechaD) = @Fecha
   ELSE
    INSERT INTO @Final (title, className, start, [end]) SELECT @title, @classN, @Fecha, NULL
   -- Insertar detalle de la Incidencia
   IF ((SELECT COUNT(1) FROM @PrepFinal WHERE dbo.fnFechaSinHora(FechaD) = @Fecha AND ISNULL(Incidencia,'') = '') >= 1) AND
      ((SELECT COUNT(1) FROM @PrepFinal WHERE dbo.fnFechaSinHora(FechaD) = @Fecha AND ISNULL(Incidencia,'') <> '') >= 1)
    INSERT INTO @Final (title, className, start, [end]) SELECT Registro, NULL, FechaD, FechaA FROM @PrepFinal WHERE dbo.fnFechaSinHora(FechaD) = @Fecha
   
  SELECT @Fecha = MIN(dbo.fnFechaSinHora(FechaD)) FROM @PrepFinal WHERE dbo.fnFechaSinHora(FechaD) > @Fecha
 END 

 SELECT * FROM @Final

RETURN
END
GO
/****************************************************************************** Documentacion Personal *****************************************************************/
/******************************************** spNetEntregaDocsPersonal ********************************************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('dbo.spNetEntregaDocsPersonal') AND type = 'P') 
	DROP PROCEDURE dbo.spNetEntregaDocsPersonal
GO
CREATE PROCEDURE dbo.spNetEntregaDocsPersonal
	@Estatus		AS VARCHAR(20),
	@ListDocs		AS VARCHAR(MAX),
	@ListPersonal	AS VARCHAR(MAX)

	
AS
BEGIN
SET NOCOUNT ON

	DECLARE @Ok				AS INT, 
			@OkRef			AS varchar(MAX),
			@Archivos	AS VARCHAR(MAX)


			--SELECT * FROM dbo.splitstring(@ListDocs)

	IF @Estatus = 'Entregaron'
	BEGIN

		SELECT DISTINCT
		Personal.Personal,
		Personal.ApellidoPaterno,
		Personal.ApellidoMaterno,
		Personal.Nombre,
		Personal.Tipo
		FROM Personal
		LEFT OUTER JOIN CtaSituacion ON 'RH'=CtaSituacion.Rama AND Personal.Situacion=CtaSituacion.Situacion
		LEFT OUTER JOIN CtaDinero CtaDineroDestino ON Personal.CtaDinero=CtaDineroDestino.CtaDinero
		LEFT OUTER JOIN Prov ON Personal.Afore=Prov.Proveedor
		LEFT OUTER JOIN Personal PersonalLista ON Personal.ReportaA=PersonalLista.Personal
		LEFT OUTER JOIN Sucursal ON Personal.SucursalTrabajo=Sucursal.Sucursal
		LEFT OUTER JOIN CentroCostos ON Personal.CentroCostos=CentroCostos.CentroCostos
		LEFT OUTER JOIN MinimosProfesionales ON Personal.MinimoProfesional=MinimosProfesionales.Numero
		LEFT OUTER JOIN Vehiculo ON Personal.Vehiculo=Vehiculo.Vehiculo
		LEFT OUTER JOIN Departamento ON Personal.Departamento=Departamento.Departamento
		LEFT OUTER JOIN Puesto ON Personal.Puesto=Puesto.Puesto
		LEFT OUTER JOIN PersonalCat ON Personal.Categoria=PersonalCat.Categoria
		LEFT OUTER JOIN PersonalGrupo ON Personal.Grupo=PersonalGrupo.Grupo
		LEFT OUTER JOIN UEN ON Personal.UEN=UEN.UEN
		LEFT OUTER JOIN Personal PersonalDestino ON Personal.Reclutador=PersonalDestino.Personal
		LEFT OUTER JOIN Personal PersonalOrigen ON Personal.RecomendadoPor=PersonalOrigen.Personal
		LEFT OUTER JOIN Cta ON Personal.Cuenta=Cta.Cuenta
		LEFT OUTER JOIN Cta CtaRetencion ON Personal.CuentaRetencion=CtaRetencion.Cuenta
		LEFT OUTER JOIN Cte ON Personal.Cliente=Cte.Cliente
		LEFT OUTER JOIN Plaza ON Personal.Plaza=Plaza.Plaza
		LEFT OUTER JOIN ProyectoDEnFirme ON Personal.Proyecto=ProyectoDEnFirme.Proyecto AND Personal.Actividad=ProyectoDEnFirme.Actividad
		LEFT OUTER JOIN Empresa ON Personal.Empresa=Empresa.Empresa
		WHERE Personal.Empresa = 'SHMEX' AND NOT Personal.Estatus = 'BAJA' 
		AND Personal.Personal IN (
			SELECT Cuenta 
			FROM DocCta WHERE Rama = 'RH' 
			AND Documento IN (SELECT * FROM dbo.splitstring(@ListDocs))
			AND Cuenta IN (SELECT * FROM dbo.splitstring(@ListPersonal))
			) 
		ORDER BY Personal.ApellidoPaterno, Personal.ApellidoMaterno, Personal.Nombre 

	END
	ELSE
	BEGIN

		--Tabla Temporal 
		DECLARE @TablaPersonal TABLE (
			Personal VARCHAR(10),
			ApellidoPaterno VARCHAR(30),
			ApellidoMaterno VARCHAR(30),
			Nombre VARCHAR(30),
			Tipo VARCHAR(20)
		)

		INSERT INTO @TablaPersonal
		SELECT DISTINCT
		Personal.Personal,
		Personal.ApellidoPaterno,
		Personal.ApellidoMaterno,
		Personal.Nombre,
		Personal.Tipo
		FROM Personal
		LEFT OUTER JOIN CtaSituacion ON 'RH'=CtaSituacion.Rama AND Personal.Situacion=CtaSituacion.Situacion
		LEFT OUTER JOIN CtaDinero CtaDineroDestino ON Personal.CtaDinero=CtaDineroDestino.CtaDinero
		LEFT OUTER JOIN Prov ON Personal.Afore=Prov.Proveedor
		LEFT OUTER JOIN Personal PersonalLista ON Personal.ReportaA=PersonalLista.Personal
		LEFT OUTER JOIN Sucursal ON Personal.SucursalTrabajo=Sucursal.Sucursal
		LEFT OUTER JOIN CentroCostos ON Personal.CentroCostos=CentroCostos.CentroCostos
		LEFT OUTER JOIN MinimosProfesionales ON Personal.MinimoProfesional=MinimosProfesionales.Numero
		LEFT OUTER JOIN Vehiculo ON Personal.Vehiculo=Vehiculo.Vehiculo
		LEFT OUTER JOIN Departamento ON Personal.Departamento=Departamento.Departamento
		LEFT OUTER JOIN Puesto ON Personal.Puesto=Puesto.Puesto
		LEFT OUTER JOIN PersonalCat ON Personal.Categoria=PersonalCat.Categoria
		LEFT OUTER JOIN PersonalGrupo ON Personal.Grupo=PersonalGrupo.Grupo
		LEFT OUTER JOIN UEN ON Personal.UEN=UEN.UEN
		LEFT OUTER JOIN Personal PersonalDestino ON Personal.Reclutador=PersonalDestino.Personal
		LEFT OUTER JOIN Personal PersonalOrigen ON Personal.RecomendadoPor=PersonalOrigen.Personal
		LEFT OUTER JOIN Cta ON Personal.Cuenta=Cta.Cuenta
		LEFT OUTER JOIN Cta CtaRetencion ON Personal.CuentaRetencion=CtaRetencion.Cuenta
		LEFT OUTER JOIN Cte ON Personal.Cliente=Cte.Cliente
		LEFT OUTER JOIN Plaza ON Personal.Plaza=Plaza.Plaza
		LEFT OUTER JOIN ProyectoDEnFirme ON Personal.Proyecto=ProyectoDEnFirme.Proyecto AND Personal.Actividad=ProyectoDEnFirme.Actividad
		LEFT OUTER JOIN Empresa ON Personal.Empresa=Empresa.Empresa
		WHERE Personal.Empresa = 'SHMEX' AND NOT Personal.Estatus = 'BAJA' 
		AND Personal.Personal IN (
			SELECT * FROM dbo.splitstring(@ListPersonal)	
		)  
		ORDER BY Personal.ApellidoPaterno, Personal.ApellidoMaterno, Personal.Nombre 

		SELECT * FROM  @TablaPersonal 
		WHERE Personal NOT IN (
			SELECT DISTINCT  DC.Cuenta 
			FROM  DocRama DR LEFT OUTER JOIN DocCta DC ON DR.Documento = DC.Documento 
			WHERE DC.Documento IN (SELECT * FROM dbo.splitstring(@ListDocs)) 
		)
		

	

	END
	
SET NOCOUNT OFF
END
GO


/******************************************** spNetDocsPersonal ********************************************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('dbo.spNetDocsPersonal') AND type = 'P') 
	DROP PROCEDURE dbo.spNetDocsPersonal
GO
CREATE PROCEDURE dbo.spNetDocsPersonal
	@Personal	AS VARCHAR(20),
	@Grupo AS VARCHAR(50)
	
AS
BEGIN
SET NOCOUNT ON

	IF LEN(@Grupo) > 0
	BEGIN

		DECLARE @Q_Grupo  VARCHAR(50),
			@Rama   VARCHAR(50)
			SET @Rama = 'RH' 
			
			DECLARE db_cursor_docs CURSOR FOR  
			SELECT DISTINCT Grupo  FROM DocRama gdr WHERE Rama IN ( @Rama) AND Grupo = @Grupo
	
			OPEN db_cursor_docs   
			FETCH NEXT FROM db_cursor_docs INTO @Q_Grupo

			WHILE @@FETCH_STATUS = 0   
			BEGIN   
				
				SELECT DISTINCT  DR.Documento,DR.Grupo,ISNULL(DC.Cuenta,'') Cuenta,DR.Orden FROM  DocRama DR LEFT OUTER JOIN DocCta DC ON DR.Documento = DC.Documento AND DC.Cuenta IN (@Personal) WHERE DR.Grupo = @Q_Grupo ORDER BY DR.Grupo, DR.Orden

				FETCH NEXT FROM db_cursor_docs INTO @Q_Grupo
			END   

			CLOSE db_cursor_docs   
			DEALLOCATE db_cursor_docs

	END
	ELSE IF LEN(@Grupo) = 0 
	BEGIN
		SELECT DISTINCT  DR.Documento,DR.Grupo,ISNULL(DC.Cuenta,'') Cuenta,DR.Orden FROM  DocRama DR LEFT OUTER JOIN DocCta DC ON DR.Documento = DC.Documento AND DC.Cuenta IN (@Personal)  ORDER BY DR.Orden
	END

SET NOCOUNT OFF
END
GO


/******************************************** spNetDocsGrupo ********************************************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('dbo.spNetDocsGrupo') AND type = 'P') 
	DROP PROCEDURE dbo.spNetDocsGrupo
GO
CREATE PROCEDURE dbo.spNetDocsGrupo
	@Grupo	AS VARCHAR(50)
	
	
AS
BEGIN
SET NOCOUNT ON

	SELECT DISTINCT Grupo  FROM DocRama gdr WHERE Rama = @Grupo

SET NOCOUNT OFF
END
GO

/*************************************************************************** Funciones ***************************************************************************/

/*************************************** fnFormatoMonedaDec ***************************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFormatoMonedaDec') 
	DROP FUNCTION fnFormatoMonedaDec
GO
CREATE FUNCTION dbo.fnFormatoMonedaDec
(			
	@Valor decimal(30,10), 
	@Decimales int
) 
RETURNS varchar(50) 
AS BEGIN
    DECLARE @Resultado          varchar(20),
            @Negativo           bit,
            @Antes              varchar(20),   
            @Despues            varchar(20),
            @Coma               int,
            @RedondeoMonetarios int

	SELECT @Negativo = CASE WHEN @Valor < 0 THEN 1 ELSE 0 END
    SELECT @Valor    = ROUND(@Valor, @Decimales)
        
	IF @Negativo = 1	
		SET @Valor = -1 * @Valor

	SET @Resultado = CONVERT(varchar, ISNULL(@Valor, 0.0))
	
	IF CHARINDEX ('.',@Resultado) > 0 
	BEGIN
		SET @Despues = SUBSTRING(@Resultado, CHARINDEX ('.', @Resultado), LEN(@Resultado))	
		SET @Antes  = SUBSTRING(@Resultado,1, CHARINDEX ('.', @Resultado)-1)	
	END
	ELSE
	BEGIN
		SET @Antes =   @Resultado
		SET @Despues = ''
	END
	
	IF LEN(@Antes) > 3 
	BEGIN
		SET @Coma = 3
		WHILE @Coma > 1 and @Coma < LEN(  @Antes)
		BEGIN
			SET @Antes = SUBSTRING(@Antes,1,LEN(@Antes) - @Coma) + ',' + RIGHT(@Antes,@Coma)
			SET @Coma = @Coma + 4
		END
	END
	
	SET @Resultado = @Antes + SUBSTRING(@Despues,1,@Decimales + 1)

	IF @Negativo = 1
		SET @Resultado = '-' + @Resultado
	
	SELECT @Resultado = '$' + @Resultado
	
	RETURN  @Resultado	

  RETURN (@Resultado)
 END
GO

/************************************************fnCalculaAntiguedad************************************************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('dbo.fnCalculaAntiguedad') AND Type = 'FN') 
	DROP FUNCTION dbo.fnCalculaAntiguedad
GO
CREATE FUNCTION dbo.fnCalculaAntiguedad
(
        @FechaIngreso datetime,
        @FechaActual  datetime
)
RETURNS varchar(25)
BEGIN

 DECLARE @FechaAñoActual    datetime,
         @FechaAñoActualMes datetime, 
         @DiffAño           int,
         @DiffMes           int,
         @DiffDia           int,
         @sAño              varchar(8),
         @sMes              varchar(9),
         @sDia              varchar(8),
         @sSalida           varchar(25) 

 SET @DiffAño = dbo.fnDiferenciaFecha('yy', @FechaIngreso, @FechaActual) 
 
 SET @FechaAñoActual = DATEADD(yy, @DiffAño, @FechaIngreso)  
 SET @DiffMes = dbo.fnDiferenciaFecha('mm', @FechaAñoActual, @FechaActual)
 
 SET @FechaAñoActualMes = DATEADD(mm, @DiffMes, @FechaAñoActual)  
 SET @DiffDia = dbo.fnDiferenciaFecha('dd', @FechaAñoActualMes, @FechaActual)
 
 SET @sAño =        
             CASE WHEN @DiffAño = 0 THEN ''
                  WHEN @DiffAño = 1 THEN CAST(@DiffAño AS varchar) + ' Año '
                  WHEN @DiffAño > 1 THEN CAST(@DiffAño AS varchar) + ' Años '
             END

 SET @sMes =       
             CASE WHEN @DiffMes = 0 THEN ''
                  WHEN @DiffMes = 1 THEN CAST(@DiffMes AS varchar) + ' Mes '
                  WHEN @DiffMes > 1 THEN CAST(@DiffMes AS varchar) + ' Meses '
             END

 SET @sDia = 
             CASE WHEN @DiffDia = 0 THEN ''
                  WHEN @DiffDia = 1 THEN CAST(@DiffDia AS varchar) + ' Día '
                  WHEN @DiffDia > 1 THEN CAST(@DiffDia AS varchar) + ' Días '
             END
             
 SET @sSalida = CASE WHEN @sAño + @sMes + @sDia = '' THEN 'Sin Antiguedad' 
                     ELSE @sAño + @sMes + @sDia 
                END

 RETURN @sSalida
 
END
GO

/************************************************fnDiferenciaFecha************************************************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('dbo.fnDiferenciaFecha') AND Type = 'FN') 
	DROP FUNCTION dbo.fnDiferenciaFecha
GO
CREATE FUNCTION dbo.fnDiferenciaFecha
(
	@Tipo         varchar(2),
	@FechaIngreso datetime,
	@FechaActual  datetime
)
RETURNS INT
BEGIN
       RETURN  
        
      CASE WHEN @FechaIngreso > @FechaActual 
		   THEN NULL 
           ELSE
			   CASE WHEN UPPER(@Tipo) NOT IN ('YY','MM','DD') THEN NULL    
					WHEN UPPER(@Tipo) = 'YY' THEN                
												  CASE 
													   WHEN DATEPART(DAY, @FechaIngreso) > DATEPART(DAY, @FechaActual) THEN DATEDIFF(MONTH, @FechaIngreso, @FechaActual) - 1
													   ELSE DATEDIFF(MONTH, @FechaIngreso, @FechaActual)
												   END / 12
					WHEN UPPER(@Tipo) = 'MM' THEN                   
												 CASE     
													  WHEN DATEPART(DAY, @FechaIngreso) > DATEPART(DAY, @FechaActual) THEN DATEDIFF(MONTH, @FechaIngreso, @FechaActual) - 1
													  ELSE DATEDIFF(MONTH, @FechaIngreso, @FechaActual)
												  END
					WHEN UPPER(@Tipo) = 'DD' THEN      
												CASE     
													 WHEN CONVERT(varchar,@FechaIngreso,108) > CONVERT(varchar,@FechaActual,108)  THEN DATEDIFF(dd, @FechaIngreso, @FechaActual) - 1
													 ELSE DATEDIFF(dd, @FechaIngreso, @FechaActual)
												 END
			   END
       END
END
GO

/******************************************** splitstring ********************************************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('dbo.splitstring') AND type = 'TF') 
	DROP FUNCTION dbo.splitstring
GO
CREATE FUNCTION dbo.splitstring ( @stringToSplit VARCHAR(MAX) )
RETURNS
 @returnList TABLE ([Name] [nvarchar] (500))
AS
BEGIN

 DECLARE @name NVARCHAR(255)
 DECLARE @pos INT

 WHILE CHARINDEX(',', @stringToSplit) > 0
 BEGIN
  SELECT @pos  = CHARINDEX(',', @stringToSplit)  
  SELECT @name = SUBSTRING(@stringToSplit, 1, @pos-1)

  INSERT INTO @returnList 
  SELECT @name

  SELECT @stringToSplit = SUBSTRING(@stringToSplit, @pos+1, LEN(@stringToSplit)-@pos)
 END

 INSERT INTO @returnList
 SELECT @stringToSplit

 RETURN
END
GO