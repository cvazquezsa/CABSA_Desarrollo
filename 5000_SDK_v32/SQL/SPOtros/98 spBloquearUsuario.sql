/************************************ spRepParamInicializar *****************************************/
IF EXISTS(SELECT * FROM SysObjects WHERE ID = object_id('dbo.spRepParamInicializar') and type = 'P') 
DROP PROCEDURE dbo.spRepParamInicializar
GO
CREATE PROCEDURE spRepParamInicializar
			@Estacion	int,
			@Empresa	varchar(5),
			@Sucursal	int,
			@Usuario	varchar(10),
			@FechaTrabajo	datetime,
			@AccesoID	int
--//WITH ENCRYPTION 
AS BEGIN
  IF NOT EXISTS (SELECT * FROM RepParam rp WHERE rp.Estacion = @Estacion)	
    INSERT RepParam (Estacion) VALUES (@Estacion)
  
  UPDATE RepParam
     SET
		AccesoID = @AccesoID, 
		InfoAlCentroCostos = NULL,
		InfoAlCentroCostos2	= NULL,
		InfoAlCentroCostos3	= NULL,        
        InfoAgenteA = (SELECT MAX(a.Agente) FROM Agente a),
        InfoAgenteD = (SELECT MIN(a.Agente) FROM Agente a),
		InfoAgrupadoCC			= 'No',
		InfoArtCat = '(Todas)',
		InfoArtFam = '(Todas)',
		InfoArtGrupo = '(Todas)',
        InfoArticuloA = (SELECT MAX(a.Articulo) FROM Art a),
        InfoArticuloD = (SELECT MIN(a.Articulo) FROM Art a),
		InfoCentroCostos = '(Todos)',
		InfoCentroCostos2 = '(Todos)',
		InfoCentroCostos3 = '(Todos)',		
		InfoCliente  = '(Todos)',
        InfoClienteA = (SELECT MAX(c.Cliente) FROM Cte c),
		InfoClienteD = (SELECT MIN(c.Cliente) FROM Cte c),
		InfoConMovs	= 'Si',
		InfoContMoneda	= (SELECT ContMoneda FROM Empresacfg WHERE Empresa = @Empresa ),
		InfoContResAnual = 'Del Ejercicio',
		InfoControladora = NULL,
		InfoCtaA = (SELECT MAX(Cuenta) FROM Cta WHERE Tipo <> 'Estructura'),
		InfoCtaCat = '(Todos)',
		InfoCtaD = (SELECT MIN(Cuenta) FROM Cta WHERE Tipo <> 'Estructura'),
		InfoCtaDinero = (SELECT MIN(CtaDinero) FROM CtaDinero WHERE Estatus = 'ALTA'),		
		InfoCtaDineroD = (SELECT MIN(CtaDinero) FROM CtaDinero WHERE Estatus = 'ALTA'),				
		InfoCtaDineroA = (SELECT MAX(CtaDinero) FROM CtaDinero WHERE Estatus = 'ALTA'),						
		InfoCtaFam = '(Todos)',		
		InfoCtaGrupo = '(Todos)',
		InfoCtaNivel = 'Mayor',		
        InfoCteCat = '(Todos)',
        InfoCteFam = '(Todos)',
        InfoCteGrupo = '(Todos)',
        InfoCteTipo = '(Todos)',         
        InfoDesglosar = 'Si',
        InfoEjercicio = YEAR(GETDATE()),
		InfoEjercicioA = YEAR(GETDATE()),
		InfoEjercicioD = YEAR(GETDATE())-4,		
		InfoEmpresa = @Empresa,
		InfoFabricante = '(Todas)',		
        InfoFechaA = dbo.fnFechaSinHora(GETDATE()),
        InfoFechaD = dbo.fnFechaSinHora(GETDATE()) - DAY(GETDATE()) + 1,
        InfoFechaTrabajo = @FechaTrabajo,
        InfoInvVal = '(Sin Valuar)',
		InfoLineasPorPagina = 20,
		InfoMoneda = (SELECT TOP 1 m.Moneda FROM Mon m ORDER BY m.Orden),
		InfoNivel = NULL,
        InfoPeriodoA = 12,
        InfoPeriodoD = 1,
        InfoPersonalA = (SELECT MAX(p.Personal) FROM Personal p),
        InfoPersonalD = (SELECT MIN(p.Personal) FROM Personal p),
	    InfoProveedor  = '(Todos)',
        InfoProveedorA = (SELECT MAX(p.Proveedor) FROM Prov p),
	    InfoProveedorD = (SELECT MIN(p.Proveedor) FROM Prov p),
		InfoProyecto = '(Todos)',
	    InfoRepCompras = 'Entradas y Devoluciones',
	    InfoRepVentas = 'Ventas y Devoluciones',
		InfoSucursal = @Sucursal,
		InfoTitulo = NULL,
		InfoTituloContRes		= 'Estado de Resultados',
		InfoTituloContResAnual	= 'Estado de Resultados  (Varios Ejercicios)',
        InfoTituloCXCEC = 'Estado de Cuentas - Clientes',
        InfoTituloCXPEC = 'Estado de Cuentas - Proveedores',
        InfoTituloVTASTri = 'Ventas del Trimestre',		
		InfoUEN			= NULL,
		InfoUso = '(Todos)',
		InfoUsuario = @Usuario,
		InformeGraficarCantidad = 5,
		InformeGraficarFecha = 12,
		InformeGraficarTipo = 'Mas Sobresalientes',
		InfoClavePresupuestalD = (SELECT MIN(ClavePresupuestal) FROM ClavePresupuestal),
		InfoClavePresupuestalA = (SELECT MAX(ClavePresupuestal) FROM ClavePresupuestal),
		InfoEstatusEspecifico = '(Todos)',
		InfoAlmacen = '(Todos)',
		InfoFechaDia = dbo.fnFechaSinHora(GETDATE()),
		InfoInvValOtraMoneda = 'UEPS',
		InfoCajero = '(Todos)',
		InfoCorte = '(Todos)',	
        InfoFechaRequeridaA = dbo.fnFechaSinHora(GETDATE()),
        InfoFechaRequeridaD = dbo.fnFechaSinHora(GETDATE()) - DAY(GETDATE()) + 1,
		InfoServicio = '(Todos)',
		VerGraficaDetalle = 0,

		--REQ12615 WMS
		InfoContacto		= '(Todos)',
		InfoTipoCaducidad	= 'Caducados',
		InfoTarimaD			= (SELECT MIN(Tarima) FROM Tarima),
		InfoTarimaA			= (SELECT MAX(Tarima) FROM Tarima),
		InfoTarimaDRep		= (SELECT MIN(Tarima) FROM Tarima),
		InfoTarimaARep		= (SELECT MAX(Tarima) FROM Tarima),
		InfoPosicion		= '(Todas)',
		InfoEstatusTarima	= 'Alta',
		InfoOrdenWMS		= 'Tarima',
		InfoAlmacenWMS		= '(Todos)',
		InfoTipo			= '(Todos)',
		InfoArtFabricante	= '(Todos)',
		InfoArtLinea		= '(Todos)',
		InfoZona			= '(Todas)',
		InfoMovimientoEsp	= '',
		InfoValuacion		= 'Costo Promedio'
		
		
  WHERE Estacion = @Estacion
END
GO

/************** spAccesoUsuarioOk *************/
if exists (select * from sysobjects where id = object_id('dbo.spAccesoUsuarioOk') and type = 'P') drop procedure dbo.spAccesoUsuarioOk
GO
CREATE PROCEDURE spAccesoUsuarioOk
                   @Usuario	     	varchar(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Bloquear		bit,
    @Dias		int,
    @UltimoAcceso	datetime,
    @Hoy		datetime,
    @Estatus		varchar(15)
    
  SELECT @Hoy = dbo.fnFechaSinHora(GETDATE())
  SELECT @Estatus = Estatus FROM Usuario WHERE Usuario = @Usuario
  SELECT @Bloquear = BloquearUsuariosInactivos, @Dias = NULLIF(BloquearUsuariosInactivosDias, 0)
    FROM Version

  IF @Bloquear = 1 AND @Dias IS NOT NULL AND @Estatus = 'ALTA'
  BEGIN
    SELECT @UltimoAcceso = UltimoAcceso FROM Usuario WHERE Usuario = @Usuario
    IF @UltimoAcceso IS NOT NULL
    BEGIN
      IF @Hoy > DATEADD(day, @Dias, @UltimoAcceso) 
        UPDATE Usuario SET Estatus = 'BLOQUEADO' WHERE Usuario = @Usuario      
    END
  END
  RETURN 
END
GO

/************** spAccesoOk *************/
if exists (select * from sysobjects where id = object_id('dbo.spAccesoOk') and type = 'P') drop procedure dbo.spAccesoOk
GO
CREATE PROCEDURE spAccesoOk
	@Empresa		VARCHAR(5),
	@Sucursal		INT,
	@Usuario	    VARCHAR(10),
	@FechaTrabajo	DATETIME,
	@AccesoID		INT 
--//WITH ENCRYPTION
AS BEGIN
	DECLARE
		@Hoy		DATETIME,
		@Estacion	INT 
    
	SELECT @Hoy = dbo.fnFechaSinHora(GETDATE())
	UPDATE Usuario SET UltimoAcceso = @Hoy WHERE Usuario = @Usuario      
  
	SELECT @Estacion = EstacionTrabajo FROM Acceso WHERE ID = @AccesoID
  
	UPDATE AccesoMes SET Empresa = @Empresa, Usuario = @Usuario, FechaRegistro = GETDATE() WHERE ID = @AccesoID
  
	IF @@ROWCOUNT = 0
		INSERT INTO AccesoMes(ID, Empresa, Usuario, FechaRegistro)
		VALUES(@AccesoID, @Empresa, @Usuario, GETDATE())
  
	EXEC spRepParamInicializar @Estacion, @Empresa, @Sucursal, @Usuario, @FechaTrabajo, @AccesoID  
	RETURN 
END
GO

/**************** spBloquearUsuario ****************/
if exists (select * from sysobjects where id = object_id('dbo.spBloquearUsuario') and type = 'P') drop procedure dbo.spBloquearUsuario
GO
CREATE PROCEDURE spBloquearUsuario
			@Usuario	varchar(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Estatus	varchar(15)

   SELECT @Estatus = UPPER(Estatus) FROM Usuario WHERE Usuario = @Usuario
   IF @Estatus = 'ALTA'
     UPDATE Usuario SET Estatus = 'BLOQUEADO' WHERE Usuario = @Usuario
     
  RETURN
END
GO