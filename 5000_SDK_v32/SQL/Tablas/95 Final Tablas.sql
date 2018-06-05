if exists (select * from sysobjects where id = object_id('dbo.tgAccesoA') and sysstat & 0xf = 8) drop trigger dbo.tgAccesoA
GO
-- Aqui va el Matenimiento a la tabla
CREATE TRIGGER tgAccesoA ON Acceso
--//WITH ENCRYPTION
FOR INSERT
AS BEGIN
  DECLARE
    @Empresa		varchar(5),
    @Sucursal		int,
    @Usuario		varchar(10),
    @EstacionTrabajo	int,
    @FechaTrabajo	datetime,
    @UltimoCierre	datetime,
    @Ayer		datetime,
    @Ok			int,
    @OkRef		varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Ok = NULL, @OkRef = NULL
  SELECT @Empresa = Empresa, @Sucursal = Sucursal, @Usuario = Usuario, @FechaTrabajo = FechaTrabajo, @EstacionTrabajo = EstacionTrabajo FROM INSERTED
  IF (SELECT CerrarDiaAuto FROM EmpresaGral WHERE Empresa = @Empresa) = 1
  BEGIN
    IF dbo.fnFechaSinHora(GETDATE()) = @FechaTrabajo
    BEGIN
      SELECT @UltimoCierre = NULL
      SELECT @UltimoCierre = FechaTrabajo FROM FechaTrabajo WHERE Empresa = @Empresa AND Sucursal = @Sucursal
      IF @UltimoCierre IS NULL OR @UltimoCierre < @FechaTrabajo
      BEGIN
        SELECT @Ayer = DATEADD(day, -1, @FechaTrabajo)
        EXEC spCerrarDia @Empresa, @Sucursal, @Ayer, @Usuario, @EstacionTrabajo, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      END
    END ELSE 
     SELECT @Ok = 10551
  END
  EXEC spOk_RAISERROR @Ok, @OkRef
END
GO

--REQ 13389
if exists (select * from sysobjects where id = object_id('dbo.tgCopiaCtoABC_CRM') and sysstat & 0xf = 8) drop trigger dbo.tgCopiaCtoABC_CRM
GO
CREATE TRIGGER tgCopiaCtoABC_CRM ON Cte
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE
    @PrimaryContactId	varchar(40),
    @Cliente			varchar(10)
       
  SELECT @Cliente = Cliente, @PrimaryContactId =  PrimaryContactId FROM Inserted
    
  IF NOT EXISTS(SELECT Cliente FROM CteCto WHERE PrimaryContactId = @PrimaryContactId AND Cliente = @Cliente)  
  BEGIN  
    IF @PrimaryContactId <> '0' AND @Cliente IS NOT NULL
      INSERT CteCto (Cliente, Nombre, Telefonos, eMail, Fax, PrimaryContactId)
      SELECT        @Cliente, Nombre, Telefonos, eMail, Fax, @PrimaryContactId
        FROM Prospecto
       WHERE CRMID = @PrimaryContactId  
  END   
  RETURN
END
GO
if exists (select * from sysobjects where id = object_id('dbo.tgEmpresaABC') and sysstat & 0xf = 8) drop trigger dbo.tgEmpresaABC
GO
CREATE TRIGGER tgEmpresaABC ON Empresa
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE
    @EmpresaI	char(5),
    @EmpresaD	char(5),
    @PaisI	varchar(50),
    @PaisD	varchar(50),
    @ID		int,
    @ConfiguracionI		char(10),
    @ConfiguracionD		char(10)


  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @EmpresaI = Empresa, @PaisI = Pais, @ConfiguracionI = NULLIF(RTRIM(Configuracion), '') FROM Inserted
  SELECT @EmpresaD = Empresa, @PaisD = Pais, @ConfiguracionD = NULLIF(RTRIM(Configuracion), '') FROM Deleted
 
 IF @PaisI = 'México' SELECT @PaisI ='Mexico'
IF @PaisD = 'México' SELECT @PaisD ='Mexico'

IF EXISTS (SELECT Pais FROM PersonalPropPais WHERE Pais = 'México')
    UPDATE PersonalPropPais SET Pais = 'Mexico'
 
IF EXISTS (SELECT Pais FROM Empresa WHERE Pais = 'México')
    UPDATE Empresa SET Pais = 'Mexico'
 
IF EXISTS (SELECT Pais FROM Sucursal WHERE Pais = 'México')
    UPDATE Sucursal SET Pais = 'Mexico'

IF EXISTS (SELECT Pais FROM Personal WHERE Pais = 'México')
   UPDATE Personal SET Pais = 'Mexico'
  
  IF @EmpresaI = @EmpresaD AND @PaisI <> @PaisD
  BEGIN
    DELETE PersonalPropValor WHERE Rama = 'EMP' AND Cuenta = @EmpresaI
    INSERT PersonalPropValor (Propiedad, Rama, Cuenta, Valor) 
    SELECT p.Propiedad, 'EMP', @EmpresaI, p.porOmision 
      FROM PersonalProp p 
      JOIN PersonalPropPais pp ON pp.Propiedad = p.Propiedad AND pp.Pais = @PaisI 
     WHERE p.NivelEmpresa = 1

    IF @PaisI = 'Ecuador'
    BEGIN
      SELECT @ID = ID FROM Compra WHERE TipoComprobante IS NOT NULL OR SustentoComprobante IS NOT NULL OR TipoIdentificacion IS NOT NULL OR DerechoDevolucion IS NOT NULL OR Establecimiento IS NOT NULL OR PuntoEmision IS NOT NULL OR SecuencialSRI IS NOT NULL OR AutorizacionSRI IS NOT NULL OR VigenteA IS NOT NULL OR SecuenciaRetencion IS NOT NULL OR Comprobante IS NOT NULL OR FechaContableMov IS NOT NULL
      IF @@ROWCOUNT = 0
      BEGIN
        EXEC spDROP_COLUMN 'Compra', 'TipoComprobante'
        EXEC spDROP_COLUMN 'Compra', 'SustentoComprobante'
        EXEC spDROP_COLUMN 'Compra', 'TipoIdentificacion'
        EXEC spDROP_COLUMN 'Compra', 'DerechoDevolucion'
        EXEC spDROP_COLUMN 'Compra', 'Establecimiento'
        EXEC spDROP_COLUMN 'Compra', 'PuntoEmision'
        EXEC spDROP_COLUMN 'Compra', 'SecuencialSRI'
        EXEC spDROP_COLUMN 'Compra', 'AutorizacionSRI'
        EXEC spDROP_COLUMN 'Compra', 'VigenteA'
        EXEC spDROP_COLUMN 'Compra', 'SecuenciaRetencion'
        EXEC spDROP_COLUMN 'Compra', 'Comprobante'
        EXEC spDROP_COLUMN 'Compra', 'FechaContableMov'
	EXEC spDROP_COLUMN 'Compra', 'PuntoEmisionRetencion'
	EXEC spDROP_COLUMN 'Compra', 'SecuencialSRIRetencion'
      END

      SELECT @ID = ID FROM CompraD WHERE TipoComprobante IS NOT NULL OR SustentoComprobante IS NOT NULL OR TipoIdentificacion IS NOT NULL OR DerechoDevolucion IS NOT NULL OR Establecimiento IS NOT NULL OR PuntoEmision IS NOT NULL OR SecuencialSRI IS NOT NULL OR AutorizacionSRI IS NOT NULL OR VigenteA IS NOT NULL OR SecuenciaRetencion IS NOT NULL OR Comprobante IS NOT NULL OR FechaContableMov IS NOT NULL
      IF @@ROWCOUNT = 0
      BEGIN 
        EXEC spDROP_COLUMN 'CompraD', 'TipoComprobante'
        EXEC spDROP_COLUMN 'CompraD', 'SustentoComprobante'
        EXEC spDROP_COLUMN 'CompraD', 'TipoIdentificacion'
        EXEC spDROP_COLUMN 'CompraD', 'DerechoDevolucion'
        EXEC spDROP_COLUMN 'CompraD', 'Establecimiento'
        EXEC spDROP_COLUMN 'CompraD', 'PuntoEmision'
        EXEC spDROP_COLUMN 'CompraD', 'SecuencialSRI'
        EXEC spDROP_COLUMN 'CompraD', 'AutorizacionSRI'
        EXEC spDROP_COLUMN 'CompraD', 'VigenteA'
        EXEC spDROP_COLUMN 'CompraD', 'SecuenciaRetencion'
        EXEC spDROP_COLUMN 'CompraD', 'Comprobante'
        EXEC spDROP_COLUMN 'CompraD', 'FechaContableMov'
      END

      SELECT @ID = ID FROM Venta WHERE TipoComprobante IS NOT NULL OR SustentoComprobante IS NOT NULL OR TipoIdentificacion IS NOT NULL OR DerechoDevolucion IS NOT NULL OR Establecimiento IS NOT NULL OR PuntoEmision IS NOT NULL OR SecuencialSRI IS NOT NULL OR AutorizacionSRI IS NOT NULL OR VigenteA IS NOT NULL OR SecuenciaRetencion IS NOT NULL OR Comprobante IS NOT NULL OR FechaContableMov IS NOT NULL
      IF @@ROWCOUNT = 0
      BEGIN 
        EXEC spDROP_COLUMN 'Venta', 'TipoComprobante'
        EXEC spDROP_COLUMN 'Venta', 'SustentoComprobante'
        EXEC spDROP_COLUMN 'Venta', 'TipoIdentificacion'
        EXEC spDROP_COLUMN 'Venta', 'DerechoDevolucion'
        EXEC spDROP_COLUMN 'Venta', 'Establecimiento'
        EXEC spDROP_COLUMN 'Venta', 'PuntoEmision'
        EXEC spDROP_COLUMN 'Venta', 'SecuencialSRI'
        EXEC spDROP_COLUMN 'Venta', 'AutorizacionSRI'
        EXEC spDROP_COLUMN 'Venta', 'VigenteA'
        EXEC spDROP_COLUMN 'Venta', 'SecuenciaRetencion'
        EXEC spDROP_COLUMN 'Venta', 'Comprobante'
        EXEC spDROP_COLUMN 'Venta', 'FechaContableMov'
      END

      SELECT @ID = ID FROM VentaD WHERE TipoComprobante IS NOT NULL OR SustentoComprobante IS NOT NULL OR TipoIdentificacion IS NOT NULL OR DerechoDevolucion IS NOT NULL OR Establecimiento IS NOT NULL OR PuntoEmision IS NOT NULL OR SecuencialSRI IS NOT NULL OR AutorizacionSRI IS NOT NULL OR VigenteA IS NOT NULL OR SecuenciaRetencion IS NOT NULL OR Comprobante IS NOT NULL OR FechaContableMov IS NOT NULL
      IF @@ROWCOUNT = 0
      BEGIN 
        EXEC spDROP_COLUMN 'VentaD', 'TipoComprobante'
        EXEC spDROP_COLUMN 'VentaD', 'SustentoComprobante'
        EXEC spDROP_COLUMN 'VentaD', 'TipoIdentificacion'
        EXEC spDROP_COLUMN 'VentaD', 'DerechoDevolucion'
        EXEC spDROP_COLUMN 'VentaD', 'Establecimiento'
        EXEC spDROP_COLUMN 'VentaD', 'PuntoEmision'
        EXEC spDROP_COLUMN 'VentaD', 'SecuencialSRI'
        EXEC spDROP_COLUMN 'VentaD', 'AutorizacionSRI'
        EXEC spDROP_COLUMN 'VentaD', 'VigenteA'
        EXEC spDROP_COLUMN 'VentaD', 'SecuenciaRetencion'
        EXEC spDROP_COLUMN 'VentaD', 'Comprobante'
        EXEC spDROP_COLUMN 'VentaD', 'FechaContableMov'
      END

      SELECT @ID = ID FROM Gasto WHERE TipoComprobante IS NOT NULL OR SustentoComprobante IS NOT NULL OR TipoIdentificacion IS NOT NULL OR DerechoDevolucion IS NOT NULL OR Establecimiento IS NOT NULL OR PuntoEmision IS NOT NULL OR SecuencialSRI IS NOT NULL OR AutorizacionSRI IS NOT NULL OR VigenteA IS NOT NULL OR SecuenciaRetencion IS NOT NULL OR Comprobante IS NOT NULL OR FechaContableMov IS NOT NULL
      IF @@ROWCOUNT = 0
      BEGIN 
        EXEC spDROP_COLUMN 'Gasto', 'TipoComprobante'
        EXEC spDROP_COLUMN 'Gasto', 'SustentoComprobante'
        EXEC spDROP_COLUMN 'Gasto', 'TipoIdentificacion'
        EXEC spDROP_COLUMN 'Gasto', 'DerechoDevolucion'
        EXEC spDROP_COLUMN 'Gasto', 'Establecimiento'
        EXEC spDROP_COLUMN 'Gasto', 'PuntoEmision'
        EXEC spDROP_COLUMN 'Gasto', 'SecuencialSRI'
        EXEC spDROP_COLUMN 'Gasto', 'AutorizacionSRI'
        EXEC spDROP_COLUMN 'Gasto', 'VigenteA'
        EXEC spDROP_COLUMN 'Gasto', 'SecuenciaRetencion'
        EXEC spDROP_COLUMN 'Gasto', 'Comprobante'
        EXEC spDROP_COLUMN 'Gasto', 'FechaContableMov'
	EXEC spDROP_COLUMN 'Gasto', 'PuntoEmisionRetencion'
	EXEC spDROP_COLUMN 'Gasto', 'SecuencialSRIRetencion'
      END

      SELECT @ID = ID FROM GastoD WHERE TipoComprobante IS NOT NULL OR SustentoComprobante IS NOT NULL OR TipoIdentificacion IS NOT NULL OR DerechoDevolucion IS NOT NULL OR Establecimiento IS NOT NULL OR PuntoEmision IS NOT NULL OR SecuencialSRI IS NOT NULL OR AutorizacionSRI IS NOT NULL OR VigenteA IS NOT NULL OR SecuenciaRetencion IS NOT NULL OR Comprobante IS NOT NULL OR FechaContableMov IS NOT NULL
      IF @@ROWCOUNT = 0
      BEGIN 
        EXEC spDROP_COLUMN 'GastoD', 'TipoComprobante'
        EXEC spDROP_COLUMN 'GastoD', 'SustentoComprobante'
        EXEC spDROP_COLUMN 'GastoD', 'TipoIdentificacion'
        EXEC spDROP_COLUMN 'GastoD', 'DerechoDevolucion'
        EXEC spDROP_COLUMN 'GastoD', 'Establecimiento'
        EXEC spDROP_COLUMN 'GastoD', 'PuntoEmision'
        EXEC spDROP_COLUMN 'GastoD', 'SecuencialSRI'
        EXEC spDROP_COLUMN 'GastoD', 'AutorizacionSRI'
        EXEC spDROP_COLUMN 'GastoD', 'VigenteA'
        EXEC spDROP_COLUMN 'GastoD', 'SecuenciaRetencion'
        EXEC spDROP_COLUMN 'GastoD', 'Comprobante'
        EXEC spDROP_COLUMN 'GastoD', 'FechaContableMov'
	EXEC spDROP_COLUMN 'GastoD', 'EcuadorTipoOperacionGasto'
      END

      EXEC spALTER_TABLE 'Compra', 'TipoComprobante', 'varchar(20) NULL'
      EXEC spALTER_TABLE 'Compra', 'SustentoComprobante', 'varchar(20) NULL'
      EXEC spALTER_TABLE 'Compra', 'TipoIdentificacion', 'varchar(20) NULL'
      EXEC spALTER_TABLE 'Compra', 'DerechoDevolucion', 'bit NULL'
      EXEC spALTER_TABLE 'Compra', 'Establecimiento', 'varchar(20) NULL'
      EXEC spALTER_TABLE 'Compra', 'PuntoEmision', 'varchar(50) NULL'
      EXEC spALTER_TABLE 'Compra', 'SecuencialSRI', 'varchar(50) NULL'
      EXEC spALTER_TABLE 'Compra', 'AutorizacionSRI', 'varchar(50) NULL'
      EXEC spALTER_TABLE 'Compra', 'VigenteA', 'datetime NULL'
      EXEC spALTER_TABLE 'Compra', 'SecuenciaRetencion', 'varchar(50) NULL'
      EXEC spALTER_TABLE 'Compra', 'Comprobante', 'bit NULL'
      EXEC spALTER_TABLE 'Compra', 'FechaContableMov', 'datetime NULL'
      EXEC spALTER_TABLE 'Compra', 'PuntoEmisionRetencion', 'varchar(50) NULL'
      EXEC spALTER_TABLE 'Compra', 'SecuencialSRIRetencion', 'varchar(50) NULL'

      EXEC spALTER_TABLE 'CompraD', 'TipoComprobante', 'varchar(20) NULL'
      EXEC spALTER_TABLE 'CompraD', 'SustentoComprobante', 'varchar(20) NULL'
      EXEC spALTER_TABLE 'CompraD', 'TipoIdentificacion', 'varchar(20) NULL'
      EXEC spALTER_TABLE 'CompraD', 'DerechoDevolucion', 'bit NULL'
      EXEC spALTER_TABLE 'CompraD', 'Establecimiento', 'varchar(20) NULL'
      EXEC spALTER_TABLE 'CompraD', 'PuntoEmision', 'varchar(50) NULL'
      EXEC spALTER_TABLE 'CompraD', 'SecuencialSRI', 'varchar(50) NULL'
      EXEC spALTER_TABLE 'CompraD', 'AutorizacionSRI', 'varchar(50) NULL'
      EXEC spALTER_TABLE 'CompraD', 'VigenteA', 'datetime NULL'
      EXEC spALTER_TABLE 'CompraD', 'SecuenciaRetencion', 'varchar(50) NULL'
      EXEC spALTER_TABLE 'CompraD', 'Comprobante', 'bit NULL'
      EXEC spALTER_TABLE 'CompraD', 'FechaContableMov', 'datetime NULL'

      EXEC spALTER_TABLE 'Venta', 'TipoComprobante', 'varchar(20) NULL'
      EXEC spALTER_TABLE 'Venta', 'SustentoComprobante', 'varchar(20) NULL'
      EXEC spALTER_TABLE 'Venta', 'TipoIdentificacion', 'varchar(20) NULL'
      EXEC spALTER_TABLE 'Venta', 'DerechoDevolucion', 'bit NULL'
      EXEC spALTER_TABLE 'Venta', 'Establecimiento', 'varchar(20) NULL'
      EXEC spALTER_TABLE 'Venta', 'PuntoEmision', 'varchar(50) NULL'
      EXEC spALTER_TABLE 'Venta', 'SecuencialSRI', 'varchar(50) NULL'
      EXEC spALTER_TABLE 'Venta', 'AutorizacionSRI', 'varchar(50) NULL'
      EXEC spALTER_TABLE 'Venta', 'VigenteA', 'datetime NULL'
      EXEC spALTER_TABLE 'Venta', 'SecuenciaRetencion', 'varchar(50) NULL'
      EXEC spALTER_TABLE 'Venta', 'Comprobante', 'bit NULL'
      EXEC spALTER_TABLE 'Venta', 'FechaContableMov', 'datetime NULL'

      EXEC spALTER_TABLE 'VentaD', 'TipoComprobante', 'varchar(20) NULL'
      EXEC spALTER_TABLE 'VentaD', 'SustentoComprobante', 'varchar(20) NULL'
      EXEC spALTER_TABLE 'VentaD', 'TipoIdentificacion', 'varchar(20) NULL'
      EXEC spALTER_TABLE 'VentaD', 'DerechoDevolucion', 'bit NULL'
      EXEC spALTER_TABLE 'VentaD', 'Establecimiento', 'varchar(20) NULL'
      EXEC spALTER_TABLE 'VentaD', 'PuntoEmision', 'varchar(50) NULL'
      EXEC spALTER_TABLE 'VentaD', 'SecuencialSRI', 'varchar(50) NULL'
      EXEC spALTER_TABLE 'VentaD', 'AutorizacionSRI', 'varchar(50) NULL'
      EXEC spALTER_TABLE 'VentaD', 'VigenteA', 'datetime NULL'
      EXEC spALTER_TABLE 'VentaD', 'SecuenciaRetencion', 'varchar(50) NULL'
      EXEC spALTER_TABLE 'VentaD', 'Comprobante', 'bit NULL'
      EXEC spALTER_TABLE 'VentaD', 'FechaContableMov', 'datetime NULL'

      EXEC spALTER_TABLE 'Gasto', 'TipoComprobante', 'varchar(20) NULL'
      EXEC spALTER_TABLE 'Gasto', 'SustentoComprobante', 'varchar(20) NULL'
      EXEC spALTER_TABLE 'Gasto', 'TipoIdentificacion', 'varchar(20) NULL'
      EXEC spALTER_TABLE 'Gasto', 'DerechoDevolucion', 'bit NULL'
      EXEC spALTER_TABLE 'Gasto', 'Establecimiento', 'varchar(20) NULL'
      EXEC spALTER_TABLE 'Gasto', 'PuntoEmision', 'varchar(50) NULL'
      EXEC spALTER_TABLE 'Gasto', 'SecuencialSRI', 'varchar(50) NULL'
      EXEC spALTER_TABLE 'Gasto', 'AutorizacionSRI', 'varchar(50) NULL'
      EXEC spALTER_TABLE 'Gasto', 'VigenteA', 'datetime NULL'
      EXEC spALTER_TABLE 'Gasto', 'SecuenciaRetencion', 'varchar(50) NULL'
      EXEC spALTER_TABLE 'Gasto', 'Comprobante', 'bit NULL'
      EXEC spALTER_TABLE 'Gasto', 'FechaContableMov', 'datetime NULL'

      EXEC spALTER_TABLE 'GastoD', 'TipoComprobante', 'varchar(20) NULL'
      EXEC spALTER_TABLE 'GastoD', 'SustentoComprobante', 'varchar(20) NULL'
      EXEC spALTER_TABLE 'GastoD', 'TipoIdentificacion', 'varchar(20) NULL'
      EXEC spALTER_TABLE 'GastoD', 'DerechoDevolucion', 'bit NULL'
      EXEC spALTER_TABLE 'GastoD', 'Establecimiento', 'varchar(20) NULL'
      EXEC spALTER_TABLE 'GastoD', 'PuntoEmision', 'varchar(50) NULL'
      EXEC spALTER_TABLE 'GastoD', 'SecuencialSRI', 'varchar(50) NULL'
      EXEC spALTER_TABLE 'GastoD', 'AutorizacionSRI', 'varchar(50) NULL'
      EXEC spALTER_TABLE 'GastoD', 'VigenteA', 'datetime NULL'
      EXEC spALTER_TABLE 'GastoD', 'SecuenciaRetencion', 'varchar(50) NULL'
      EXEC spALTER_TABLE 'GastoD', 'Comprobante', 'bit NULL'
      EXEC spALTER_TABLE 'GastoD', 'FechaContableMov', 'datetime NULL'
      EXEC spALTER_TABLE 'GastoD', 'EcuadorTipoOperacionGasto', 'varchar(50) NULL'
    END
  END

--  IF @EmpresaI = @EmpresaD RETURN
  IF @EmpresaI IS NULL AND @EmpresaD IS NULL RETURN

  -- Si Inserto
  IF @EmpresaD IS NULL
  BEGIN
    DELETE EmpresaCfg        WHERE Empresa = @EmpresaI
    DELETE EmpresaCfg2       WHERE Empresa = @EmpresaI
    DELETE EmpresaCfgNomAuto WHERE Empresa = @EmpresaI
    DELETE EmpresaCfgPuntosEnVales	WHERE Empresa = @EmpresaI
--    DELETE EmpresaCfgPuntosEnValesMov	WHERE Empresa = @EmpresaI
--    DELETE EmpresaCfgGastoIndirecto	WHERE Empresa = @EmpresaI
--    DELETE EmpresaCfgMovAmortizacion	WHERE Empresa = @EmpresaI
    DELETE EmpresaCfgMov     WHERE Empresa = @EmpresaI
    DELETE EmpresaCfgMovWMS     WHERE Empresa = @EmpresaI --REQ12615 WMS
    DELETE EmpresaCfgAcceso  WHERE Empresa = @EmpresaI
    DELETE EmpresaCfgPV      WHERE Empresa = @EmpresaI
    DELETE EmpresaCfgFRP     WHERE Empresa = @EmpresaI  --Para la Vertical Financiera
    DELETE EmpresaGral       WHERE Empresa = @EmpresaI
    DELETE PersonalPropValor WHERE Rama = 'EMP' AND Cuenta = @EmpresaI
    
    DELETE EmpresaCfgMovCompra	WHERE Empresa = @EmpresaI
    DELETE EmpresaCfgMovCxp		WHERE Empresa = @EmpresaI
    DELETE EmpresaCfgMovCxc		WHERE Empresa = @EmpresaI --MEJORA10041
    DELETE EmpresaCfgMovCP		WHERE Empresa = @EmpresaI
    DELETE EmpresaCfgMovPCP		WHERE Empresa = @EmpresaI
    DELETE EmpresaCfgMovGES		WHERE Empresa = @EmpresaI
    
    --REQ25014
    DELETE EmpresaCfgMovContParalela WHERE Empresa = @EmpresaI

    INSERT EmpresaCfg        (Empresa) VALUES (@EmpresaI)
    INSERT EmpresaCfg2       (Empresa) VALUES (@EmpresaI)
    INSERT EmpresaCfgNomAuto (Empresa) VALUES (@EmpresaI)
    INSERT EmpresaCfgPuntosEnVales	(Empresa) VALUES (@EmpresaI)
--    INSERT EmpresaCfgPuntosEnValesMov	(Empresa) VALUES (@EmpresaI)
--    INSERT EmpresaCfgGastoIndirecto	(Empresa) VALUES (@EmpresaI)
    --INSERT EmpresaCfgMovAmortizacion	(Empresa) VALUES (@EmpresaI)
    INSERT EmpresaCfgMov     (Empresa) VALUES (@EmpresaI)
    INSERT EmpresaCfgMovWMS     (Empresa) VALUES (@EmpresaI) --REQ12615 WMS
    INSERT EmpresaCfgMovRecluta (Empresa) VALUES (@EmpresaI)
    INSERT EmpresaCfgMovVenta (Empresa) VALUES (@EmpresaI)

    -- 'CORTE'
    INSERT EmpresaCfgMovCorte (Empresa) VALUES (@EmpresaI)

    --REQ16092
    INSERT EmpresaCfgMovOPORT (Empresa) VALUES (@EmpresaI)
   

    -- BUG14129
    INSERT EmpresaCfgMovImp(Empresa, Modulo, Mov, Estatus, ReporteImpresora, ReportePantalla, Sucursal) VALUES(@EmpresaI, 'CORTE', 'Estado Cuenta Cxc',		'CONCLUIDO', 'CorteEdoCtaCx',	'CorteEdoCtaCx', 0)
    INSERT EmpresaCfgMovImp(Empresa, Modulo, Mov, Estatus, ReporteImpresora, ReportePantalla, Sucursal) VALUES(@EmpresaI, 'CORTE', 'Estado Cuenta Cxp',		'CONCLUIDO', 'CorteEdoCtaCx',	'CorteEdoCtaCx', 0)
    INSERT EmpresaCfgMovImp(Empresa, Modulo, Mov, Estatus, ReporteImpresora, ReportePantalla, Sucursal) VALUES(@EmpresaI, 'CORTE', 'Reporte Externo',		'CONCLUIDO', 'CorteRepExterno', 'CorteRepExterno', 0)
    INSERT EmpresaCfgMovImp(Empresa, Modulo, Mov, Estatus, ReporteImpresora, ReportePantalla, Sucursal) VALUES(@EmpresaI, 'CORTE', 'Valuacion Inventario',	'CONCLUIDO', 'CorteInvVal',		'CorteInvVal', 0)
    INSERT EmpresaCfgMovImp(Empresa, Modulo, Mov, Estatus, ReporteImpresora, ReportePantalla, Sucursal) VALUES(@EmpresaI, 'CORTE', 'Corte Importe',			'CONCLUIDO', 'CorteImporte',	'CorteImporte', 0)
    INSERT EmpresaCfgMovImp(Empresa, Modulo, Mov, Estatus, ReporteImpresora, ReportePantalla, Sucursal) VALUES(@EmpresaI, 'CORTE', 'Corte Contable',		'CONCLUIDO', 'CorteContable',	'CorteContable', 0)
    INSERT EmpresaCfgMovImp(Empresa, Modulo, Mov, Estatus, ReporteImpresora, ReportePantalla, Sucursal) VALUES(@EmpresaI, 'CORTE', 'Corte Unidades',		'CONCLUIDO', 'CorteUnidades',	'CorteUnidades', 0)
    INSERT EmpresaCfgMovImp(Empresa, Modulo, Mov, Estatus, ReporteImpresora, ReportePantalla, Sucursal) VALUES(@EmpresaI, 'CORTE', 'Corte Cx',				'CONCLUIDO', 'CorteCx',			'CorteCx', 0)
    INSERT EmpresaCfgMovImp(Empresa, Modulo, Mov, Estatus, ReporteImpresora, ReportePantalla, Sucursal) VALUES(@EmpresaI, 'CORTE', 'Estado Cuenta Cxc',		'CANCELADO', 'CorteEdoCtaCx',	'CorteEdoCtaCx', 0)
    INSERT EmpresaCfgMovImp(Empresa, Modulo, Mov, Estatus, ReporteImpresora, ReportePantalla, Sucursal) VALUES(@EmpresaI, 'CORTE', 'Estado Cuenta Cxp',		'CANCELADO', 'CorteEdoCtaCx',	'CorteEdoCtaCx', 0)
    INSERT EmpresaCfgMovImp(Empresa, Modulo, Mov, Estatus, ReporteImpresora, ReportePantalla, Sucursal) VALUES(@EmpresaI, 'CORTE', 'Reporte Externo',		'CANCELADO', 'CorteRepExterno', 'CorteRepExterno', 0)
    INSERT EmpresaCfgMovImp(Empresa, Modulo, Mov, Estatus, ReporteImpresora, ReportePantalla, Sucursal) VALUES(@EmpresaI, 'CORTE', 'Valuacion Inventario',	'CANCELADO', 'CorteInvVal',		'CorteInvVal', 0)
    INSERT EmpresaCfgMovImp(Empresa, Modulo, Mov, Estatus, ReporteImpresora, ReportePantalla, Sucursal) VALUES(@EmpresaI, 'CORTE', 'Corte Importe',			'CANCELADO', 'CorteImporte',	'CorteImporte', 0)
    INSERT EmpresaCfgMovImp(Empresa, Modulo, Mov, Estatus, ReporteImpresora, ReportePantalla, Sucursal) VALUES(@EmpresaI, 'CORTE', 'Corte Contable',		'CANCELADO', 'CorteContable',	'CorteContable', 0)
    INSERT EmpresaCfgMovImp(Empresa, Modulo, Mov, Estatus, ReporteImpresora, ReportePantalla, Sucursal) VALUES(@EmpresaI, 'CORTE', 'Corte Unidades',		'CANCELADO', 'CorteUnidades',	'CorteUnidades', 0)
    INSERT EmpresaCfgMovImp(Empresa, Modulo, Mov, Estatus, ReporteImpresora, ReportePantalla, Sucursal) VALUES(@EmpresaI, 'CORTE', 'Corte Cx',				'CANCELADO', 'CorteCx',			'CorteCx', 0)
    -- BUG14129
        
    INSERT EmpresaCfgMovCompra (Empresa) VALUES (@EmpresaI) --MEJORASLC    
    INSERT EmpresaCfgMovCxp (Empresa) VALUES (@EmpresaI) --MEJORASLC  
    INSERT EmpresaCfgMovCxc (Empresa) VALUES (@EmpresaI) --MEJORA10041      
    INSERT EmpresaCfgMovCP (Empresa) VALUES (@EmpresaI)
    INSERT EmpresaCfgMovPCP (Empresa) VALUES (@EmpresaI)
    INSERT EmpresaCfgMovGES (Empresa) VALUES (@EmpresaI) --MEJORA5066    
    INSERT EmpresaCfgMovDinero (Empresa) VALUES (@EmpresaI) --Mejora 5669
    
    --REQ25014
    INSERT EmpresaCfgMovContParalela (Empresa) VALUES (@EmpresaI) --Mejora 5669
    
    INSERT EmpresaCfgAcceso  (Empresa) VALUES (@EmpresaI)
    INSERT EmpresaCfgPV      (Empresa) VALUES (@EmpresaI)
    INSERT EmpresaCfgFRP      (Empresa) VALUES (@EmpresaI)  --Para la Vertical Financiera
    INSERT EmpresaGral       (Empresa) VALUES (@EmpresaI)
    INSERT PersonalPropValor (Propiedad, Rama, Cuenta, Valor) 
    SELECT p.Propiedad, 'EMP', @EmpresaI, p.porOmision 
      FROM PersonalProp p 
      JOIN PersonalPropPais pp ON pp.Propiedad = p.Propiedad AND pp.Pais = @PaisI 
     WHERE p.NivelEmpresa = 1
  END ELSE

  -- Si Elimino 
  IF @EmpresaI IS NULL 
  BEGIN
    DELETE EmpresaCfg        WHERE Empresa = @EmpresaD
    DELETE EmpresaCfg2       WHERE Empresa = @EmpresaD
    DELETE EmpresaCfgNomAuto WHERE Empresa = @EmpresaD
    DELETE EmpresaCfgPuntosEnVales	WHERE Empresa = @EmpresaD
--    DELETE EmpresaCfgPuntosEnValesMov	WHERE Empresa = @EmpresaD
--    DELETE EmpresaCfgGastoIndirecto	WHERE Empresa = @EmpresaD
--    DELETE EmpresaCfgMovAmortizacion	WHERE Empresa = @EmpresaD
    DELETE EmpresaCfgMov     WHERE Empresa = @EmpresaD
    DELETE EmpresaCfgMovWMS     WHERE Empresa = @EmpresaD --REQ12615 WMS
    DELETE EmpresaCfgAcceso  WHERE Empresa = @EmpresaD
    DELETE EmpresaCfgPV      WHERE Empresa = @EmpresaD
    DELETE EmpresaCfgFRP      WHERE Empresa = @EmpresaD
    DELETE EmpresaGral       WHERE Empresa = @EmpresaD
    DELETE EmpresaPedidosReservarEsp WHERE Empresa = @EmpresaD
    DELETE PersonalPropValor WHERE Rama = 'EMP' AND Cuenta = @EmpresaD    
    DELETE EmpresaSocio      WHERE Empresa = @EmpresaD
    
    DELETE EmpresaCfgMovRecluta WHERE Empresa = @EmpresaD
    DELETE EmpresaCfgMovVenta WHERE Empresa = @EmpresaD
    -- 'CORTE'
    DELETE EmpresaCfgMovCorte WHERE Empresa = @EmpresaD

    --REQ16092
    DELETE EmpresaCfgMovOPORT WHERE Empresa = @EmpresaD

    
    -- BUG14129
    DELETE EmpresaCfgMovImp WHERE Empresa = @EmpresaD AND Modulo = 'CORTE'
    
    DELETE EmpresaCfgMovDinero       WHERE Empresa = @EmpresaD
    
  END ELSE


  -- Si Modifico
  IF @EmpresaD <> @EmpresaI
  BEGIN
    UPDATE EmpresaCfg        SET Empresa = @EmpresaI WHERE Empresa = @EmpresaD
    UPDATE EmpresaCfg2       SET Empresa = @EmpresaI WHERE Empresa = @EmpresaD
    UPDATE EmpresaCfgNomAuto SET Empresa = @EmpresaI WHERE Empresa = @EmpresaD
    UPDATE EmpresaCfgPuntosEnVales SET Empresa = @EmpresaI WHERE Empresa = @EmpresaD
    UPDATE EmpresaCfgMov     SET Empresa = @EmpresaI WHERE Empresa = @EmpresaD
    UPDATE EmpresaCfgMovWMS     SET Empresa = @EmpresaI WHERE Empresa = @EmpresaD --REQ12615 WMS
    UPDATE EmpresaCfgAcceso  SET Empresa = @EmpresaI WHERE Empresa = @EmpresaD
    UPDATE EmpresaCfgPV      SET Empresa = @EmpresaI WHERE Empresa = @EmpresaD
    UPDATE EmpresaCfgFRP      SET Empresa = @EmpresaI WHERE Empresa = @EmpresaD
    UPDATE EmpresaGral       SET Empresa = @EmpresaI WHERE Empresa = @EmpresaD
    UPDATE EmpresaCfgMovDinero       SET Empresa = @EmpresaI WHERE Empresa = @EmpresaD
    UPDATE EmpresaPedidosReservarEsp SET Empresa = @EmpresaI WHERE Empresa = @EmpresaD
    UPDATE PersonalPropValor SET Cuenta  = @EmpresaI WHERE Rama = 'EMP' AND Cuenta = @EmpresaD
    UPDATE EmpresaSocio      SET Empresa = @EmpresaI WHERE Empresa = @EmpresaD
  END

  IF @EmpresaI IS NOT NULL 
  BEGIN
    IF @ConfiguracionI IS NULL 
      EXEC spCopiarTablaLista 'Empresa', @EmpresaI
    ELSE BEGIN
        EXEC spCopiarTabla 'Empresa', @ConfiguracionI, @EmpresaI
    END
  END

END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgEmpresaGralINFORC') and sysstat & 0xf = 8) drop trigger dbo.tgEmpresaGralINFORC
GO
--CREATE TRIGGER tgEmpresaGralINFORC ON EmpresaGral
----//WITH ENCRYPTION
--FOR UPDATE
--AS BEGIN
--  DECLARE	@EmpresaI		varchar(5),
--		@EmpresaD		varchar(5),
--		@ProdInterfazInforD	bit,
--		@ProdInterfazInforI	bit,
--		@Alm			varchar(10)

--  IF dbo.fnEstaSincronizando() = 1 RETURN
  
--  SELECT TOP 1 @EmpresaI = Empresa, @ProdInterfazINFORI = ProdInterfazINFOR FROM Inserted
--  SELECT TOP 1 @EmpresaD = Empresa, @ProdInterfazINFORD = ProdInterfazINFOR FROM Deleted


--  IF @EmpresaI = @EmpresaD AND @ProdInterfazINFORI <> @ProdInterfazINFORD AND @ProdInterfazINFORI IS NOT NULL AND @ProdInterfazINFORD IS NOT NULL
--  BEGIN
--    IF (SELECT ProdInterfazINFOR FROM Inserted) = 1
--    BEGIN
--      SELECT @Alm = Almacen FROM Alm WHERE PermiteRechazos IS NOT NULL OR PermiteUbicaciones IS NOT NULL
--      IF @@ROWCOUNT = 0
--      BEGIN 
--        EXEC spDROP_COLUMN 'Alm', 'PermiteRechazos'
--        EXEC spDROP_COLUMN 'Alm', 'PermiteUbicaciones'
--        EXEC spDROP_COLUMN 'Alm', 'EsAlmacenDeDeposito'
--        EXEC spDROP_COLUMN 'Alm', 'EsAlmacenMaterialesExteriores'
--        EXEC spDROP_COLUMN 'Alm', 'NoDisponibleConsumos'


--        EXEC spALTER_TABLE 'Alm', 'PermiteRechazos', 'bit NULL'
--	EXEC spALTER_TABLE 'Alm', 'PermiteUbicaciones', 'bit NULL'
--	EXEC spALTER_TABLE 'Alm', 'EsAlmacenDeDeposito', 'bit NULL'
--	EXEC spALTER_TABLE 'Alm', 'EsAlmacenMaterialesExteriores', 'bit NULL'
--	EXEC spALTER_TABLE 'Alm', 'NoDisponibleConsumos', 'bit NULL'
--      END
--    END
--  END		  
  
--END
--GO

/* tgSerieLoteMovFinal */
if exists (select * from sysobjects where id = object_id('dbo.tgSerieLoteMovFinal') and sysstat & 0xf = 8) drop trigger dbo.tgSerieLoteMovFinal
GO
CREATE TRIGGER tgSerieLoteMovFinal ON SerieLoteMov
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  
  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  IF UPDATE(Propiedades)
    UPDATE SerieLote 
       SET Propiedades = i.Propiedades 
      FROM SerieLote sl, Inserted i 
     WHERE sl.Empresa = i.Empresa AND sl.Articulo = i.Articulo AND ISNULL(sl.SubCuenta, '') = ISNULL(i.SubCuenta, '') AND sl.SerieLote = i.SerieLote AND ISNULL(sl.Propiedades, '') <> ISNULL(i.Propiedades, '') AND NULLIF(RTRIM(i.Propiedades), '') IS NOT NULL
END
GO


/* tgSerieLoteMovEliminar */
if exists (select * from sysobjects where id = object_id('dbo.tgSerieLoteMovEliminar') and sysstat & 0xf = 8) drop trigger dbo.tgSerieLoteMovEliminar
GO
CREATE TRIGGER tgSerieLoteMovEliminar ON SerieLoteMov
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
    @Modulo 	char(5),
    @Sucursal  	int,
    @ID     	int,
    @Estatus	char(15),
    @Mensaje 	char(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Estatus = NULL
  SELECT @Modulo = MIN(Modulo), @Sucursal = MIN(Sucursal) , @ID = MIN(ID) FROM Deleted
  IF @Modulo = 'VTAS' SELECT @Estatus = Estatus FROM Venta  WHERE Sucursal = @Sucursal AND ID = @ID ELSE
  IF @Modulo = 'COMS' SELECT @Estatus = Estatus FROM Compra WHERE Sucursal = @Sucursal AND ID = @ID ELSE
  IF @Modulo = 'INV'  SELECT @Estatus = Estatus FROM Inv    WHERE Sucursal = @Sucursal AND ID = @ID ELSE
  IF @Estatus NOT IN (NULL, 'SINAFECTAR', 'CONFIRMAR')
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 30330
    RAISERROR (@Mensaje,16,-1) 
  END
END
GO


/* tgEmbarqueFinal */
if exists (select * from sysobjects where id = object_id('dbo.tgEmbarqueFinal') and sysstat & 0xf = 8) drop trigger dbo.tgEmbarqueFinal
GO
CREATE TRIGGER tgEmbarqueFinal ON EmbarqueD
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @Modulo		char(5),
    @Sucursal		int,
    @ID			int,
    @EmbarqueMov 	int,
    @EstadoA		varchar(50),
    @EstadoN		varchar(50),
    @Causa		varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @EstadoA = Estado FROM Deleted
  SELECT @EstadoN = Estado, @EmbarqueMov = EmbarqueMov, @Causa = Causa FROM Inserted

  IF @EstadoA <> @EstadoN
  BEGIN
    SELECT @Modulo = Modulo, @Sucursal = Sucursal, @ID = ModuloID 
      FROM EmbarqueMov 
     WHERE ID = @EmbarqueMov

    IF @Modulo = 'VTAS' UPDATE Venta  SET EmbarqueEstado = @EstadoN, Causa = @Causa WHERE @Sucursal = Sucursal AND ID = @ID ELSE
    IF @Modulo = 'COMS' UPDATE Compra SET EmbarqueEstado = @EstadoN WHERE @Sucursal = Sucursal AND ID = @ID ELSE
    IF @Modulo = 'INV'  UPDATE Inv    SET EmbarqueEstado = @EstadoN WHERE @Sucursal = Sucursal AND ID = @ID ELSE
    IF @Modulo = 'CXC'  UPDATE Cxc    SET EmbarqueEstado = @EstadoN WHERE @Sucursal = Sucursal AND ID = @ID ELSE
    IF @Modulo = 'DIN'  UPDATE DInero SET EmbarqueEstado = @EstadoN WHERE @Sucursal = Sucursal AND ID = @ID 
  END
END
GO

/****** Auxiliares Monetarios ******/
if not exists(select * from SysTabla where SysTabla = 'Auxiliar') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Auxiliar','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.Auxiliar') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Auxiliar (
	ID			int		NOT NULL IDENTITY(1,1),

	Empresa			char(5)         NULL,
	Rama			char(5)         NULL,
	Mov 			char(20)   	NULL,
	MovID			varchar(20)    	NULL,
	Modulo			char(5) 	NULL,
        ModuloID		int		NULL,
	Moneda			char(10)	NULL,
	TipoCambio		float		NULL,
	Grupo			char(10)        NULL,
	Cuenta			char(20)        NULL,
	SubCuenta		varchar(50)	NULL,
	Ejercicio		int		NULL,
	Periodo			int		NULL,
        Fecha			datetime	NULL,
	Cargo			money		NULL,
	Abono			money		NULL,
	Aplica			varchar(20)     NULL,
	AplicaID		varchar(20)	NULL,
	Acumulado		bit		NOT NULL DEFAULT 0,
	Conciliado		bit		NOT NULL DEFAULT 0,
	EsCancelacion		bit		NOT NULL DEFAULT 0,
	FechaConciliacion	datetime	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
--	SincroID 		timestamp 	NULL,
--	SincroC  		int 		NULL 	 DEFAULT 1,
	Renglon			float		NULL,
	RenglonSub		int		NULL,

	CONSTRAINT priAuxiliar PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Auxiliar'
END
GO
if (select version from version) BETWEEN 1 and 1095
  ALTER TABLE Auxiliar ALTER COLUMN MovID varchar(20)
GO
if (select version from version) BETWEEN 1 and 1095
  ALTER TABLE Auxiliar ALTER COLUMN AplicaID varchar(20)
GO
EXEC spALTER_COLUMN 'Auxiliar', 'SubCuenta', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Auxiliar', 'Renglon', 'float NULL'
EXEC spALTER_TABLE 'Auxiliar', 'RenglonSub', 'int NULL'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Auxiliar' AND sysindexes.name = 'Cuenta' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Cuenta ON dbo.Auxiliar (Cuenta, SubCuenta, Grupo, Rama, Moneda, Ejercicio, Periodo, Fecha, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Auxiliar' AND sysindexes.name = 'Grupo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Grupo ON dbo.Auxiliar (Grupo, Rama, Moneda, Ejercicio, Periodo, Fecha, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Auxiliar' AND sysindexes.name = 'Fecha' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Fecha ON dbo.Auxiliar (Fecha, Cuenta, SubCuenta, Grupo, Moneda)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Auxiliar' AND sysindexes.name = 'ModuloID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ModuloID ON dbo.Auxiliar (ModuloID, Modulo)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Auxiliar' AND sysindexes.name = 'CargoAbono' AND sysobjects.id = sysindexes.id)--Bug 21604
CREATE INDEX CargoAbono ON Auxiliar(Rama,Cuenta,Moneda,Empresa,ID,Fecha)INCLUDE(Cargo,Abono)
GO

EXEC spADD_INDEX 'Auxiliar', 'Conciliar', 'Conciliado, Fecha, Cuenta, Rama, Modulo, Empresa'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Auxiliar' AND sysindexes.name = 'Conciliado' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Conciliado ON Auxiliar (Empresa,Rama,Modulo,Cuenta,Conciliado,Fecha)INCLUDE(Mov,MovID,ModuloID,Cargo,Abono)
GO

if exists (select * from sysobjects where id = object_id('dbo.tgAuxiliarC') and sysstat & 0xf = 8) 
DROP TRIGGER dbo.tgAuxiliarC
GO
-- Aqui va el Matenimiento a la tabla
EXEC spModificarPK_SucursalSinOrigen 'Auxiliar', '(ID)'
GO

CREATE TRIGGER tgAuxiliarC ON Auxiliar
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @ConciliadoAnterior 	bit,
    @ConciliadoNuevo		bit,
    @Importe			money,
    @Sucursal			int,
    @Empresa            	char(5),
    @Usuario			varchar(10),
    @Rama	      		char(5),
    @Moneda	       		char(10),
    @Grupo	       		char(10),
    @Cuenta	       		char(20),
    @SubCuenta          	varchar(50),
    @Modulo			char(5),
    @ModuloID			int,
    @Mov			char(20),
    @MovID			varchar(20),
    @MovTipo			varchar(20),
    @FechaConciliacion		datetime,
    @FechaAnterior		datetime,
    @FechaRegistro		datetime,
    @CfgConciliarEstatus	bit,
    @Estatus			varchar(15),
    @ModificarEstatus		bit,
    @ContAuto			bit,
    @ContAutoEstatus		varchar(15)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  IF UPDATE(Conciliado) OR UPDATE(FechaConciliacion)
  BEGIN
    SELECT @ConciliadoAnterior = Conciliado,
           @FechaAnterior      = FechaConciliacion
      FROM Deleted

    SELECT @ConciliadoNuevo    = Conciliado,
           @Sucursal	       = Sucursal,
           @Empresa            = RTRIM(Empresa),
           @Rama	       = Rama,
           @Moneda	       = Moneda,
           @Grupo	       = Grupo,
           @Cuenta	       = RTRIM(Cuenta),
           @SubCuenta          = SubCuenta,
           @Modulo	       = Modulo,
           @ModuloID	       = ModuloID,
           @Mov		       = RTRIM(Mov),
           @MovID	       = RTRIM(MovID),
           @FechaConciliacion  = FechaConciliacion
      FROM Inserted

    IF @ConciliadoNuevo <> @ConciliadoAnterior
    BEGIN
      SELECT @Estatus = NULL, @ModificarEstatus = 0
      SELECT @CfgConciliarEstatus = ISNULL(DineroConciliarEstatus, 0) 
        FROM EmpresaCfg 
       WHERE Empresa = @Empresa 

      SELECT @ContAuto = ISNULL(ContAuto, 0)
        FROM EmpresaGral 
       WHERE Empresa = @Empresa

      IF @CfgConciliarEstatus = 1 AND @Modulo = 'DIN'
      BEGIN
        SELECT @Estatus = Estatus FROM Dinero WHERE ID = @ModuloID
        IF (@ConciliadoNuevo = 1 AND @Estatus = 'CONCLUIDO') OR (@ConciliadoNuevo = 0 AND @Estatus = 'CONCILIADO')
        BEGIN
          IF @ConciliadoNuevo = 1 SELECT @Estatus = 'CONCILIADO' ELSE SELECT @Estatus = 'CONCLUIDO'
          SELECT @ModificarEstatus = 1
        END
      END

      SELECT @Importe = (ISNULL(Cargo, 0.0) - ISNULL(Abono, 0.0)) FROM Inserted
      UPDATE Saldo WITH (ROWLOCK)
         SET PorConciliar = CASE @ConciliadoNuevo WHEN 1 THEN ISNULL(PorConciliar, 0.0) - @Importe ELSE ISNULL(PorConciliar, 0.0) + @Importe END
       WHERE Empresa   = @Empresa
         AND Sucursal  = @Sucursal
         AND Rama      = @Rama
         AND Moneda    = @Moneda
         AND Grupo     = @Grupo
         AND Cuenta    = @Cuenta
         AND SubCuenta = @SubCuenta

       IF @Modulo = 'DIN'
       BEGIN
         UPDATE Dinero WITH (ROWLOCK) SET Conciliado       = @ConciliadoNuevo, FechaConciliacion       = @FechaConciliacion, Estatus = ISNULL(@Estatus, Estatus) WHERE ID = @ModuloID
         UPDATE Cxc    WITH (ROWLOCK) SET DineroConciliado = @ConciliadoNuevo, DineroFechaConciliacion = @FechaConciliacion WHERE Empresa = @Empresa AND Dinero = @Mov AND DineroID = @MovID AND DineroCtaDinero = @Cuenta
         UPDATE Cxp    WITH (ROWLOCK) SET DineroConciliado = @ConciliadoNuevo, DineroFechaConciliacion = @FechaConciliacion WHERE Empresa = @Empresa AND Dinero = @Mov AND DineroID = @MovID AND DineroCtaDinero = @Cuenta
         UPDATE Gasto  WITH (ROWLOCK) SET DineroConciliado = @ConciliadoNuevo, DineroFechaConciliacion = @FechaConciliacion WHERE Empresa = @Empresa AND Dinero = @Mov AND DineroID = @MovID AND DineroCtaDinero = @Cuenta
         UPDATE Venta  WITH (ROWLOCK) SET DineroConciliado = @ConciliadoNuevo, DineroFechaConciliacion = @FechaConciliacion WHERE Empresa = @Empresa AND Dinero = @Mov AND DineroID = @MovID AND DineroCtaDinero = @Cuenta

         IF @CfgConciliarEstatus = 1 AND @ContAuto = 1 AND @ModificarEstatus = 1
         BEGIN
           SELECT @FechaRegistro = GETDATE()
           IF @ConciliadoNuevo = 1 SELECT @ContAutoEstatus = @Estatus ELSE SELECT @ContAutoEstatus = 'CANCELADO'
           SELECT @MovTipo = Clave FROM MovTipo WHERE Modulo = 'DIN' AND Mov = @Mov
           SELECT @Usuario = Usuario FROM Dinero WHERE ID = @ModuloID
           EXEC spMovContAuto @Empresa, @Sucursal, 'DIN', @ModuloID, 'CONCILIADO', @ContAutoEstatus, @Usuario, @FechaConciliacion, @FechaRegistro, @Mov, @MovID, @MovTipo, NULL, NULL, NULL
         END
       END
    END
    IF @FechaAnterior <> @FechaConciliacion AND @Modulo = 'DIN'
    BEGIN
      UPDATE Dinero WITH (ROWLOCK) SET FechaConciliacion       = @FechaConciliacion WHERE ID = @ModuloID
      UPDATE Cxc    WITH (ROWLOCK) SET DineroFechaConciliacion = @FechaConciliacion WHERE Empresa = @Empresa AND Dinero = @Mov AND DineroID = @MovID AND DineroCtaDinero = @Cuenta
      UPDATE Cxp    WITH (ROWLOCK) SET DineroFechaConciliacion = @FechaConciliacion WHERE Empresa = @Empresa AND Dinero = @Mov AND DineroID = @MovID AND DineroCtaDinero = @Cuenta
      UPDATE Gasto  WITH (ROWLOCK) SET DineroFechaConciliacion = @FechaConciliacion WHERE Empresa = @Empresa AND Dinero = @Mov AND DineroID = @MovID AND DineroCtaDinero = @Cuenta
      UPDATE Venta  WITH (ROWLOCK) SET DineroFechaConciliacion = @FechaConciliacion WHERE Empresa = @Empresa AND Dinero = @Mov AND DineroID = @MovID AND DineroCtaDinero = @Cuenta
    END
  END
END
GO

/****** Auxiliares (Resultados) Monetarios ******/
if not exists(select * from SysTabla where SysTabla = 'AuxiliarR') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AuxiliarR','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.AuxiliarR') and type = 'U') 
BEGIN
  CREATE TABLE dbo.AuxiliarR (
	ID			int		NOT NULL IDENTITY(1,1),

	Empresa			char(5)         NULL,
	Rama			char(5)         NULL,
	Mov 			char(20)   	NULL,
	MovID			varchar(20)    	NULL,
	Modulo			char(5) 	NULL,
        ModuloID		int		NULL,
	Moneda			char(10)	NULL,
	TipoCambio		float		NULL,
	Grupo			char(10)        NULL,
	Cuenta			char(20)        NULL,
	SubCuenta		varchar(50)	NULL,
	Ejercicio		int		NULL,
	Periodo			int		NULL,
        Fecha			datetime	NULL,
	Cargo			money		NULL,
	Abono			money		NULL,
	Aplica			varchar(20)     NULL,
	AplicaID		varchar(20)	NULL,
	Acumulado		bit		NOT NULL DEFAULT 0,
	Conciliado		bit		NOT NULL DEFAULT 0,
	EsCancelacion		bit		NOT NULL DEFAULT 0,
	FechaConciliacion	datetime	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
--	SincroID 		timestamp 	NULL,
--	SincroC  		int 		NULL 	 DEFAULT 1,
	Renglon			float		NULL,
	RenglonSub		int		NULL,

	CONSTRAINT priAuxiliarR PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'AuxiliarR'
END
GO
if (select version from version) BETWEEN 1 and 1095
  ALTER TABLE AuxiliarR ALTER COLUMN MovID varchar(20)
GO
if (select version from version) BETWEEN 1 and 1095
  ALTER TABLE AuxiliarR ALTER COLUMN AplicaID varchar(20)
GO
EXEC spALTER_COLUMN 'AuxiliarR', 'SubCuenta', 'varchar(50) NULL'
EXEC spALTER_TABLE 'AuxiliarR', 'Renglon', 'float NULL'
EXEC spALTER_TABLE 'AuxiliarR', 'RenglonSub', 'int NULL'
GO
EXEC spModificarPK_SucursalSinOrigen 'AuxiliarR', '(ID)'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarR' AND sysindexes.name = 'Cuenta' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Cuenta ON dbo.AuxiliarR (Cuenta, SubCuenta, Grupo, Rama, Moneda, Ejercicio, Periodo, Fecha, Sucursal, Empresa)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarR' AND sysindexes.name = 'Grupo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Grupo  ON dbo.AuxiliarR (Grupo, Rama, Moneda, Ejercicio, Periodo, Fecha, Sucursal, Empresa)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarR' AND sysindexes.name = 'Fecha' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Fecha ON dbo.AuxiliarR (Fecha, Cuenta, SubCuenta, Grupo, Moneda)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarR' AND sysindexes.name = 'ModuloID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ModuloID ON dbo.AuxiliarR (ModuloID, Modulo)
GO

/****** Auxiliares Unidades ******/
if not exists(select * from SysTabla where SysTabla = 'AuxiliarU')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AuxiliarU','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.AuxiliarU') and type = 'U') 
BEGIN
  CREATE TABLE dbo.AuxiliarU (
	ID			int		NOT NULL IDENTITY(1,1),

	Empresa			char(5)         NOT NULL,
	Rama			char(5)         NOT NULL,
	Mov 			char(20)   	NOT NULL,
	MovID			varchar(20)    	NOT NULL,
	Modulo			char(5) 	NULL,
        ModuloID		int		NULL,
	Moneda			char(10)	NULL,
	TipoCambio		float		NULL,
	Grupo			char(10)        NULL,
	SubGrupo		varchar(20)	NULL,
	Cuenta			char(20)        NULL,
	SubCuenta		varchar(50)	NULL,
	Ejercicio		int		NULL,
	Periodo			int		NULL,
        Fecha			datetime	NULL,
	Cargo			money		NULL,
	Abono			money		NULL,
	CargoU			float		NULL,
	AbonoU			float		NULL,
	Aplica			varchar(20)     NULL,
	AplicaID		varchar(20)	NULL,
	Acumulado		bit		NOT NULL DEFAULT 0,
	Conciliado		bit		NOT NULL DEFAULT 0,
	EsCancelacion		bit		NOT NULL DEFAULT 0,
	FechaConciliacion	datetime	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
--	SincroID 		timestamp 	NULL,
--	SincroC  		int 		NULL 	 DEFAULT 1,
	Renglon			float		NULL,
	RenglonSub		int		NULL,

	CONSTRAINT priAuxiliarU PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'AuxiliarU'
END
GO
if (select version from version) BETWEEN 1 and 1095
  ALTER TABLE AuxiliarU ALTER COLUMN MovID varchar(20)
GO
if (select version from version) BETWEEN 1 and 1095
  ALTER TABLE AuxiliarU ALTER COLUMN AplicaID varchar(20)
GO
EXEC spALTER_COLUMN 'AuxiliarU', 'SubCuenta', 'varchar(50) NULL'
GO
EXEC spALTER_TABLE 'AuxiliarU', 'SubGrupo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'AuxiliarU', 'Renglon', 'float NULL'
EXEC spALTER_TABLE 'AuxiliarU', 'RenglonSub', 'int NULL'
EXEC spALTER_TABLE 'AuxiliarU', 'IDAuxU', 'int NULL'
--EXEC spALTER_TABLE 'AuxiliarU', 'IDWMS', 'timestamp'
GO
--TASK2512
if exists (select * from sysobjects where id = object_id('AuxiliarU') and type = 'U')
Begin
	if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarU' AND sysindexes.name = 'Cuenta' AND sysobjects.id = sysindexes.id)
	  CREATE INDEX Cuenta ON dbo.AuxiliarU (Cuenta, SubCuenta, Grupo, Rama, Moneda, Ejercicio, Periodo, Fecha, Sucursal, Empresa)
	--GO
	if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarU' AND sysindexes.name = 'Grupo' AND sysobjects.id = sysindexes.id)
	  CREATE INDEX Grupo ON dbo.AuxiliarU (Grupo, Rama, Moneda, Ejercicio, Periodo, Fecha, Sucursal, Empresa)
	--GO
	if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarU' AND sysindexes.name = 'Fecha' AND sysobjects.id = sysindexes.id)
	  CREATE INDEX Fecha ON dbo.AuxiliarU (Fecha, Cuenta, SubCuenta, Grupo, Moneda)
	--GO
	if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarU' AND sysindexes.name = 'ModuloID' AND sysobjects.id = sysindexes.id)
	  CREATE INDEX ModuloID ON dbo.AuxiliarU (ModuloID, Modulo)
	--GO
	EXEC spModificarPK_SucursalSinOrigen 'AuxiliarU', '(ID)'

	if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarU' AND sysindexes.name = 'Cuenta' AND sysobjects.id = sysindexes.id)
	  CREATE INDEX Cuenta ON dbo.AuxiliarU (Cuenta, SubCuenta, Grupo, Rama, Moneda, Ejercicio, Periodo, Fecha, Sucursal, Empresa)
	if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarU' AND sysindexes.name = 'Fecha' AND sysobjects.id = sysindexes.id)
	  CREATE INDEX Fecha ON dbo.AuxiliarU (Fecha, Cuenta, SubCuenta, Grupo, Moneda)
	if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarU' AND sysindexes.name = 'Grupo' AND sysobjects.id = sysindexes.id)
	  CREATE INDEX Grupo ON dbo.AuxiliarU (Grupo, Rama, Moneda, Ejercicio, Periodo, Fecha, Sucursal, Empresa)
	if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarU' AND sysindexes.name = 'SubGrupo' AND sysobjects.id = sysindexes.id)
	  CREATE INDEX SubGrupo ON dbo.AuxiliarU (SubGrupo, Grupo, Rama, Moneda, Ejercicio, Periodo, Fecha, Sucursal, Empresa)
	if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarU' AND sysindexes.name = 'ModuloID' AND sysobjects.id = sysindexes.id)
	  CREATE INDEX ModuloID ON dbo.AuxiliarU (ModuloID, Modulo)

End
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarU' AND sysindexes.name = 'Renglon' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Renglon ON AuxiliarU (Modulo,ModuloID,Renglon,RenglonSub,Cargo,Abono,ID)
GO
/****** Auxiliares (Resultados) Unidades ******/
if not exists(select * from SysTabla where SysTabla = 'AuxiliarRU')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AuxiliarRU','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.AuxiliarRU') and type = 'U') 
BEGIN
  CREATE TABLE dbo.AuxiliarRU (
	ID			int		NOT NULL IDENTITY(1,1),

	Empresa			char(5)         NOT NULL,
	Rama			char(5)         NOT NULL,
	Mov 			char(20)   	NOT NULL,
	MovID			varchar(20)    	NOT NULL,
	Modulo			char(5) 	NULL,
        ModuloID		int		NULL,
	Moneda			char(10)	NULL,
	TipoCambio		float		NULL,
	Grupo			char(10)        NULL,
	Cuenta			char(20)        NULL,
	SubCuenta		varchar(50)	NULL,
	Ejercicio		int		NULL,
	Periodo			int		NULL,
        Fecha			datetime	NULL,
	Cargo			money		NULL,
	Abono			money		NULL,
	CargoU			float		NULL,
	AbonoU			float		NULL,
	Aplica			varchar(20)     NULL,
	AplicaID		varchar(20)	NULL,
	Acumulado		bit		NOT NULL DEFAULT 0,
	Conciliado		bit		NOT NULL DEFAULT 0,
	EsCancelacion		bit		NOT NULL DEFAULT 0,
	FechaConciliacion	datetime	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
--	SincroID 		timestamp 	NULL,
--	SincroC  		int 		NULL 	 DEFAULT 1,
	Renglon			float		NULL,
	RenglonSub		int		NULL,

	CONSTRAINT priAuxiliarRU PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'AuxiliarRU'
END
GO
if (select version from version) BETWEEN 1 and 1095
  ALTER TABLE AuxiliarRU ALTER COLUMN MovID varchar(20)
GO
if (select version from version) BETWEEN 1 and 1095
  ALTER TABLE AuxiliarRU ALTER COLUMN AplicaID varchar(20)
GO
EXEC spALTER_COLUMN 'AuxiliarRU', 'SubCuenta', 'varchar(50) NULL'
EXEC spALTER_TABLE 'AuxiliarRU', 'Renglon', 'float NULL'
EXEC spALTER_TABLE 'AuxiliarRU', 'RenglonSub', 'int NULL'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarRU' AND sysindexes.name = 'Cuenta' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Cuenta ON dbo.AuxiliarRU (Cuenta, SubCuenta, Grupo, Rama, Moneda, Ejercicio, Periodo, Fecha, Sucursal, Empresa)
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarRU' AND sysindexes.name = 'Grupo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Grupo  ON dbo.AuxiliarRU (Grupo, Rama, Moneda, Ejercicio, Periodo, Fecha, Sucursal, Empresa)
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarRU' AND sysindexes.name = 'Fecha' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Fecha ON dbo.AuxiliarRU (Fecha, Cuenta, SubCuenta, Grupo, Moneda)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarRU' AND sysindexes.name = 'ModuloID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ModuloID ON dbo.AuxiliarRU (ModuloID, Modulo)
GO
EXEC spModificarPK_SucursalSinOrigen 'AuxiliarRU', '(ID)'
GO

-- Auxiliar de las Tarjetas del módulo de Vales
if not exists(select * from SysTabla where SysTabla = 'AuxiliarValeSerie')	-- ETO Tarjetas 9-Feb-2007
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AuxiliarValeSerie','Movimiento')
GO
if not exists (select * from sysobjects where id = object_id('dbo.AuxiliarValeSerie') and type = 'U')
CREATE TABLE AuxiliarValeSerie(
	ID			int	IDENTITY,
	Mov			char(20)	NULL,
	MovID			varchar(20)	NULL,
	Modulo			char(5)		NULL,
	ModuloID		int		NULL,
	Serie			varchar(20)	NULL,
	Ejercicio		int		NULL,
	Periodo			int		NULL,
	Fecha			datetime	NULL,
	Cargo			money		NULL,
	Abono			money		NULL,
	PorConciliar		bit		NULL,
	EsCancelacion		bit		NULL
CONSTRAINT priAuxiliarValeSerie PRIMARY KEY(ID))
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarValeSerie' AND sysindexes.name = 'Serie' AND sysobjects.id = sysindexes.id)	-- ETO Tarjetas 9-Feb-2007
  CREATE INDEX Serie ON dbo.AuxiliarValeSerie (Serie, Fecha)
GO
EXEC spModificarPK_SucursalSinOrigen 'AuxiliarValeSerie', '(ID)'
GO


/****** Acumulados Monetarios ******/
if not exists(select * from SysTabla where SysTabla = 'Acum')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Acum','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.Acum') and type = 'U') 
CREATE TABLE dbo.Acum (
	Sucursal		int		NOT NULL DEFAULT 0,
	Empresa			char(5)         NOT NULL,
	Rama			char(5)         NOT NULL,
	Ejercicio		int		NOT NULL,
	Periodo			int		NOT NULL,
	Moneda			char(10)	NOT NULL,
	Grupo			char(10)	NOT NULL,
	Cuenta			char(20)        NOT NULL,
	SubCuenta		varchar(50)	NOT NULL,
	SubCuenta2		varchar(50)	NOT NULL DEFAULT '',
	SubCuenta3		varchar(50)	NOT NULL DEFAULT '',
	Proyecto		varchar(50)	NOT NULL DEFAULT '',
	UEN			int		NOT NULL DEFAULT 0,	

	Cargos			money		NULL,
	Abonos			money		NULL,
	UltimoCambio		datetime	NULL,

	CONSTRAINT priAcum PRIMARY KEY CLUSTERED (Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Grupo, Proyecto, UEN, Rama, Ejercicio, Periodo, Moneda, Sucursal, Empresa)
)
go
if NOT EXISTS(select * from SysCampo WHERE Tabla = 'Acum' AND Campo = 'SubCuenta2')
BEGIN
  EXEC spEliminarPK 'Acum'  
  EXEC spALTER_COLUMN 'Acum', 'SubCuenta', 'varchar(50) NOT NULL'
  EXEC spALTER_TABLE 'Acum', 'SubCuenta2', 'varchar(50) NOT NULL DEFAULT "" WITH VALUES'
  EXEC spALTER_TABLE 'Acum', 'SubCuenta3', 'varchar(50) NOT NULL DEFAULT "" WITH VALUES'
  EXEC spALTER_TABLE 'Acum', 'Proyecto', 'varchar(50) NOT NULL DEFAULT "" WITH VALUES'
  EXEC spALTER_TABLE 'Acum', 'UEN', 'int NOT NULL DEFAULT 0 WITH VALUES'
  EXEC('ALTER TABLE Acum ADD CONSTRAINT priAcum PRIMARY KEY CLUSTERED (Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Grupo, Proyecto, UEN, Rama, Ejercicio, Periodo, Moneda, Sucursal, Empresa)')
END
GO
EXEC spModificarPK_AcumSaldo 'Acum', '(Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Grupo, Proyecto, UEN, Rama, Ejercicio, Periodo, Moneda, Sucursal, Empresa)'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Acum' AND sysindexes.name = 'Grupo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Grupo ON dbo.Acum (Grupo, Rama, Moneda, Ejercicio, Periodo, Sucursal, Empresa)
go

EXEC spFK 'Acum','Empresa','Empresa','Empresa'
GO


/****** Acumulados Contabilidad ******/
/*if not exists(select * from SysTabla where SysTabla = 'AcumCont')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AcumCont','Saldo')
if not exists (select * from sysobjects where id = object_id('dbo.AcumCont') and type = 'U') 
CREATE TABLE dbo.AcumCont (
	Sucursal		int		NOT NULL,
	Empresa			char(5)         NOT NULL,
	Rama			char(5)         NOT NULL,
	Ejercicio		int		NOT NULL,
	Periodo			int		NOT NULL,
	Moneda			char(10)	NOT NULL,
	Grupo			char(10)        NOT NULL,
	Cuenta			char(20)        NOT NULL,	
	SubCuenta		varchar(50)	NOT NULL,
	SubCuenta2		varchar(50)	NOT NULL,
	SubCuenta3		varchar(50)	NOT NULL,
	Proyecto		varchar(50)	NOT NULL,
	UEN			int		NOT NULL,

	Cargos			money		NULL,
	Abonos			money		NULL,

	CONSTRAINT priAcumCont PRIMARY KEY CLUSTERED (Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Proyecto, UEN, Grupo, Rama, Ejercicio, Periodo, Moneda, Sucursal, Empresa)
)*/
EXEC spDROP_TABLE 'AcumCont', 3241
GO

/****** Acumulados (Resultados) Monetarios ******/
if not exists(select * from SysTabla where SysTabla = 'AcumR')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AcumR','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.AcumR') and type = 'U') 
CREATE TABLE dbo.AcumR (
	Sucursal		int		NOT NULL DEFAULT 0,
	Empresa			char(5)         NOT NULL,
	Rama			char(5)         NOT NULL,
	Ejercicio		int		NOT NULL,
	Periodo			int		NOT NULL,
	Moneda			char(10)	NOT NULL,
	Grupo			char(10)	NOT NULL,
	Cuenta			char(20)        NOT NULL,
	SubCuenta		varchar(50)	NOT NULL,

	Cargos			money		NULL,
	Abonos			money		NULL,
	UltimoCambio		datetime	NULL,
                                                     
	CONSTRAINT priAcumR PRIMARY KEY CLUSTERED (Cuenta, SubCuenta, Grupo, Rama, Ejercicio, Periodo, Moneda, Sucursal, Empresa)
)
go
if exists(select * from SysTipoDatos WHERE Tabla = 'AcumR' AND Campo = 'SubCuenta' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'AcumR'
  EXEC spALTER_COLUMN 'AcumR', 'SubCuenta', 'varchar(50) NOT NULL'
  EXEC('ALTER TABLE AcumR ADD CONSTRAINT priAcumR PRIMARY KEY CLUSTERED (Cuenta, SubCuenta, Grupo, Rama, Ejercicio, Periodo, Moneda, Sucursal, Empresa)')
END
GO
EXEC spModificarPK_AcumSaldo 'AcumR', '(Cuenta, SubCuenta, Grupo, Rama, Ejercicio, Periodo, Moneda, Sucursal, Empresa)'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AcumR' AND sysindexes.name = 'Grupo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Grupo ON dbo.AcumR (Grupo, Rama, Moneda, Ejercicio, Periodo, Sucursal, Empresa)
go

/****** Acumulados Unidades ******/
if not exists(select * from SysTabla where SysTabla = 'AcumU')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AcumU','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.AcumU') and type = 'U') 
CREATE TABLE dbo.AcumU (
	Sucursal		int		NOT NULL DEFAULT 0,
	Empresa			char(5)         NOT NULL,
	Rama			char(5)         NOT NULL,
	Ejercicio		int		NOT NULL,
	Periodo			int		NOT NULL,
	Moneda			char(10)	NOT NULL,
	Grupo			char(10)        NOT NULL,
	SubGrupo		varchar(20)	NOT NULL,
	Cuenta			char(20)        NOT NULL,
	SubCuenta		varchar(50)	NOT NULL,

	Cargos			money		NULL,
	Abonos			money		NULL,
	CargosU			float		NULL,
	AbonosU			float		NULL,
	UltimoCambio		datetime	NULL,
						  
	CONSTRAINT priAcumU PRIMARY KEY CLUSTERED (Cuenta, SubCuenta, Grupo, SubGrupo, Rama, Ejercicio, Periodo, Moneda, Sucursal, Empresa)
)
go

--TASK2512
if exists (select * from sysobjects where id = object_id('AcumU') and type = 'U')
Begin
	EXEC spModificarPK_AcumSaldo 'AcumU', '(Cuenta, SubCuenta, Grupo, SubGrupo, Rama, Ejercicio, Periodo, Moneda, Sucursal, Empresa)'
	--GO
	IF NOT EXISTS(SELECT * FROM SysCampo WHERE Tabla='AcumU' AND Campo='SubGrupo')
	BEGIN
	  EXEC spALTER_TABLE 'AcumU', 'SubGrupo', 'varchar(20) NOT NULL DEFAULT '''' WITH VALUES'
	  EXEC spALTER_PK 'AcumU', 'Cuenta, SubCuenta, Grupo, SubGrupo, Rama, Ejercicio, Periodo, Moneda, Sucursal, Empresa'
	END
	--GO
	if exists(select * from SysTipoDatos WHERE Tabla = 'AcumU' AND Campo = 'SubCuenta' and Tamano=20)
	BEGIN
	  EXEC spEliminarPK 'AcumU'
	  EXEC spALTER_COLUMN 'AcumU', 'SubCuenta', 'varchar(50) NOT NULL'
	  EXEC('ALTER TABLE AcumU ADD CONSTRAINT priAcumU PRIMARY KEY CLUSTERED (Cuenta, SubCuenta, Grupo, SubGrupo, Rama, Ejercicio, Periodo, Moneda, Sucursal, Empresa)')
	END
	--GO
	if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AcumU' AND sysindexes.name = 'Grupo' AND sysobjects.id = sysindexes.id)
	  CREATE INDEX Grupo ON dbo.AcumU (Grupo, Rama, Moneda, Ejercicio, Periodo, Sucursal, Empresa)
End
go

/****** Acumulados (Resultados) Unidades ******/
if not exists(select * from SysTabla where SysTabla = 'AcumRU')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AcumRU','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.AcumRU') and type = 'U') 
CREATE TABLE dbo.AcumRU (
	Sucursal		int		NOT NULL DEFAULT 0,
	Empresa			char(5)         NOT NULL,
	Rama			char(5)         NOT NULL,
	Ejercicio		int		NOT NULL,
	Periodo			int		NOT NULL,
	Moneda			char(10)	NOT NULL,
	Grupo			char(10)        NOT NULL,
	Cuenta			char(20)        NOT NULL,
	SubCuenta		varchar(50)	NOT NULL,

	Cargos			money		NULL,
	Abonos			money		NULL,
	CargosU			float		NULL,
	AbonosU			float		NULL,
	UltimoCambio		datetime	NULL,
						   
	CONSTRAINT priAcumRU PRIMARY KEY CLUSTERED (Cuenta, SubCuenta, Grupo, Rama, Ejercicio, Periodo, Moneda, Sucursal, Empresa)
)
go
EXEC spModificarPK_AcumSaldo 'AcumRU', '(Cuenta, SubCuenta, Grupo, Rama, Ejercicio, Periodo, Moneda, Sucursal, Empresa)'
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'AcumRU' AND Campo = 'SubCuenta' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'AcumRU'
  EXEC spALTER_COLUMN 'AcumRU', 'SubCuenta', 'varchar(50) NOT NULL'
  EXEC('ALTER TABLE AcumRU ADD CONSTRAINT priAcumRU PRIMARY KEY CLUSTERED (Cuenta, SubCuenta, Grupo, Rama, Ejercicio, Periodo, Moneda, Sucursal, Empresa)')
END
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AcumRU' AND sysindexes.name = 'Grupo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Grupo ON dbo.AcumRU (Grupo, Rama, Moneda, Ejercicio, Periodo, Sucursal, Empresa)
go

-- BUG12047
EXEC spADD_INDEX 'AcumRU', 'VentaAcumD', 'Empresa, Ejercicio, Periodo, Moneda, Grupo, Cuenta) INCLUDE(CargosU, AbonosU'

/****** Saldos Monetarios ******/
if not exists(select * from SysTabla where SysTabla = 'Saldo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Saldo','Saldo')
if not exists (select * from sysobjects where id = object_id('dbo.Saldo') and type = 'U') 
CREATE TABLE dbo.Saldo (
	Sucursal		int		NOT NULL DEFAULT 0,
	Empresa			char(5)         NOT NULL,
	Rama			char(5)         NOT NULL,
	Moneda			char(10)	NOT NULL,
	Grupo			char(10)        NOT NULL,
	Cuenta			char(20)        NOT NULL,
	SubCuenta		varchar(50)	NOT NULL,
	SubCuenta2		varchar(50)	NOT NULL DEFAULT '',
	SubCuenta3		varchar(50)	NOT NULL DEFAULT '',
	Proyecto		varchar(50)	NOT NULL DEFAULT '',
	UEN			int		NOT NULL DEFAULT 0,	

	Saldo			money		NULL,
	PorConciliar		money		NULL,
	UltimoCambio		datetime	NULL,

	CONSTRAINT priSaldo PRIMARY KEY CLUSTERED (Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Grupo, Proyecto, UEN, Rama, Moneda, Sucursal, Empresa)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgSaldoC') and sysstat & 0xf = 8) 
  drop trigger dbo.tgSaldoC
GO
if NOT EXISTS(select * from SysCampo WHERE Tabla = 'Saldo' AND Campo = 'SubCuenta2')
BEGIN
  EXEC spEliminarPK 'Saldo'  
  EXEC spALTER_COLUMN 'Saldo', 'SubCuenta', 'varchar(50) NOT NULL'
  EXEC spALTER_TABLE 'Saldo', 'SubCuenta2', 'varchar(50) NOT NULL DEFAULT "" WITH VALUES'
  EXEC spALTER_TABLE 'Saldo', 'SubCuenta3', 'varchar(50) NOT NULL DEFAULT "" WITH VALUES'
  EXEC spALTER_TABLE 'Saldo', 'Proyecto', 'varchar(50) NOT NULL DEFAULT "" WITH VALUES'
  EXEC spALTER_TABLE 'Saldo', 'UEN', 'int NOT NULL DEFAULT 0 WITH VALUES'
  EXEC('ALTER TABLE Saldo ADD CONSTRAINT priSaldo PRIMARY KEY CLUSTERED (Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Grupo, Proyecto, UEN, Rama, Moneda, Sucursal, Empresa)')
END
GO
EXEC spModificarPK_AcumSaldo 'Saldo', '(Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Grupo, Proyecto, UEN, Rama, Moneda, Sucursal, Empresa)'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Saldo' AND sysindexes.name = 'Grupo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Grupo ON dbo.Saldo (Grupo, Rama, Moneda, Sucursal, Empresa)
go

/****** Saldos Contabilidad ******/
/*if not exists(select * from SysTabla where SysTabla = 'SaldoCont')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SaldoCont','Saldo')
if not exists (select * from sysobjects where id = object_id('dbo.SaldoCont') and type = 'U') 
CREATE TABLE dbo.SaldoCont (
	Ejercicio		int		NOT NULL,

	Sucursal		int		NOT NULL,
	Empresa			char(5)         NOT NULL,
	Rama			char(5)         NOT NULL,
	Moneda			char(10)	NOT NULL,
	Grupo			char(10)        NOT NULL,
	Cuenta			char(20)        NOT NULL,	
	SubCuenta		varchar(50)	NOT NULL,
	SubCuenta2		varchar(50)	NOT NULL,
	SubCuenta3		varchar(50)	NOT NULL,
	Proyecto		varchar(50)	NOT NULL,
	UEN			int		NOT NULL,

	Saldo			money		NULL,

	CONSTRAINT priSaldoCont PRIMARY KEY CLUSTERED (Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Proyecto, UEN, Grupo, Rama, Ejercicio, Moneda, Sucursal, Empresa)
)*/
EXEC spDROP_TABLE 'SaldoCont', 3241
GO

/****** Saldos (Resultados) Monetarios ******/
if not exists(select * from SysTabla where SysTabla = 'SaldoR')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SaldoR','Saldo')
if not exists (select * from sysobjects where id = object_id('dbo.SaldoR') and type = 'U') 
CREATE TABLE dbo.SaldoR (
	Sucursal		int		NOT NULL DEFAULT 0,
	Empresa			char(5)         NOT NULL,
	Rama			char(5)         NOT NULL,
	Moneda			char(10)	NOT NULL,
	Grupo			char(10)        NOT NULL,
	Cuenta			char(20)        NOT NULL,
	SubCuenta		varchar(50)	NOT NULL,

	Saldo			money		NULL,
	PorConciliar		money		NULL,
	UltimoCambio		datetime	NULL,

	CONSTRAINT priSaldoR PRIMARY KEY CLUSTERED (Cuenta, SubCuenta, Grupo, Rama, Moneda, Sucursal, Empresa)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgSaldoRC') and sysstat & 0xf = 8) 
  drop trigger dbo.tgSaldoRC
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'SaldoR' AND Campo = 'SubCuenta' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'SaldoR'
  EXEC spALTER_COLUMN 'SaldoR', 'SubCuenta', 'varchar(50) NOT NULL'
  EXEC('ALTER TABLE SaldoR ADD CONSTRAINT priSaldoR PRIMARY KEY CLUSTERED (Cuenta, SubCuenta, Grupo, Rama, Moneda, Sucursal, Empresa)')
END
GO
EXEC spModificarPK_AcumSaldo 'SaldoR', '(Cuenta, SubCuenta, Grupo, Rama, Moneda, Sucursal, Empresa)'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'SaldoR' AND sysindexes.name = 'Grupo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Grupo ON dbo.SaldoR (Grupo, Rama, Moneda, Sucursal, Empresa)
go

/****** Saldos Unidades ******/
if not exists(select * from SysTabla where SysTabla = 'SaldoU')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SaldoU','Saldo')
if not exists (select * from sysobjects where id = object_id('dbo.SaldoU') and type = 'U') 
CREATE TABLE dbo.SaldoU (
	Sucursal		int		NOT NULL DEFAULT 0,
	Empresa			char(5)         NOT NULL,
	Rama			char(5)         NOT NULL,
 	Moneda			char(10)	NOT NULL,
	Grupo			char(10)        NOT NULL,
	SubGrupo		varchar(20)     NOT NULL,
	Cuenta			char(20)        NOT NULL,
	SubCuenta		varchar(50)	NOT NULL,

	Saldo			money		NULL,
	SaldoU			float		NULL,
	PorConciliar		money		NULL,
	PorConciliarU		float		NULL,
	UltimoCambio		datetime	NULL,

	CONSTRAINT priSaldoU PRIMARY KEY CLUSTERED (Cuenta, SubCuenta, Grupo, SubGrupo, Rama, Moneda, Sucursal, Empresa)
)
GO

--TASK2512
if exists (select * from sysobjects where id = object_id('SaldoU') and type = 'U')
Begin
	if exists (select * from sysobjects where id = object_id('dbo.tgSaldoUC') and sysstat & 0xf = 8) 
	  drop trigger dbo.tgSaldoUC
	--GO
	IF NOT EXISTS(SELECT * FROM SysCampo WHERE Tabla='SaldoU' AND Campo='SubGrupo')
	BEGIN
	  EXEC spALTER_TABLE 'SaldoU', 'SubGrupo', 'varchar(20) NOT NULL DEFAULT '''' WITH VALUES'
	  EXEC spALTER_PK 'SaldoU', 'Cuenta, SubCuenta, Grupo, SubGrupo, Rama, Moneda, Sucursal, Empresa'
	END
	--GO
	if exists(select * from SysTipoDatos WHERE Tabla = 'SaldoU' AND Campo = 'SubCuenta' and Tamano=20)
	BEGIN
	  EXEC spEliminarPK 'SaldoU'
	  EXEC spALTER_COLUMN 'SaldoU', 'SubCuenta', 'varchar(50) NOT NULL'
	  EXEC('ALTER TABLE SaldoU ADD CONSTRAINT priSaldoU PRIMARY KEY CLUSTERED (Cuenta, SubCuenta, Grupo, SubGrupo, Rama, Moneda, Sucursal, Empresa)')
	END
	--GO
	EXEC spModificarPK_AcumSaldo 'SaldoU', '(Cuenta, SubCuenta, Grupo, SubGrupo, Rama, Moneda, Sucursal, Empresa)'
	--GO
	if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'SaldoU' AND sysindexes.name = 'Grupo' AND sysobjects.id = sysindexes.id)
	  CREATE INDEX Grupo ON dbo.SaldoU (Grupo, Rama, Moneda, Sucursal, Empresa)
	--go
	EXEC spADD_INDEX 'SaldoU', 'SubGrupo', 'SubGrupo, Grupo, Empresa'
	--GO
	-- BUG12036
	EXEC spADD_INDEX 'SaldoU', 'InvAlm', 'Empresa) INCLUDE(Rama, Grupo, Cuenta, SaldoU'
End
GO

-- BUG12036
EXEC spADD_INDEX 'SaldoU', 'InvAlm', 'Empresa) INCLUDE(Rama, Grupo, Cuenta, SaldoU'
GO

/****** Saldos (Resultados) Unidades ******/
if not exists(select * from SysTabla where SysTabla = 'SaldoRU')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SaldoRU','Saldo')
if not exists (select * from sysobjects where id = object_id('dbo.SaldoRU') and type = 'U') 
CREATE TABLE dbo.SaldoRU (
	Sucursal		int		NOT NULL DEFAULT 0,
	Empresa			char(5)         NOT NULL,
	Rama			char(5)         NOT NULL,
	Moneda			char(10)	NOT NULL,
	Grupo			char(10)        NOT NULL,
	Cuenta			char(20)        NOT NULL,
	SubCuenta		varchar(50)	NOT NULL,

	Saldo			money		NULL,
	SaldoU			float		NULL,
	PorConciliar		money		NULL,
	PorConciliarU		float		NULL,
	UltimoCambio		datetime	NULL,

	CONSTRAINT priSaldoRU PRIMARY KEY CLUSTERED (Cuenta, SubCuenta, Grupo, Rama, Moneda, Sucursal, Empresa)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgSaldoRUC') and sysstat & 0xf = 8) 
  drop trigger dbo.tgSaldoRUC
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'SaldoRU' AND Campo = 'SubCuenta' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'SaldoRU'
  EXEC spALTER_COLUMN 'SaldoRU', 'SubCuenta', 'varchar(50) NOT NULL'
  EXEC('ALTER TABLE SaldoRU ADD CONSTRAINT priSaldoRU PRIMARY KEY CLUSTERED (Cuenta, SubCuenta, Grupo, Rama, Moneda, Sucursal, Empresa)')
END
GO
EXEC spModificarPK_AcumSaldo 'SaldoRU', '(Cuenta, SubCuenta, Grupo, Rama, Moneda, Sucursal, Empresa)'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'SaldoRU' AND sysindexes.name = 'Grupo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Grupo ON dbo.SaldoRU (Grupo, Rama, Moneda, Sucursal, Empresa)
go

-- BUG12047
EXEC spADD_INDEX 'SaldoRU', 'VentaAcumD', 'Empresa, Rama, Moneda) INCLUDE(Grupo, Cuenta, Saldo, SaldoU'

/****** Sentinel ******/
if exists (select * from sysobjects where id = object_id('dbo.tgSentinelFinal') and sysstat & 0xf = 8) drop trigger dbo.tgSentinelFinal
GO
CREATE TRIGGER tgSentinelFinal ON Sentinel
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
  DECLARE
   @Cliente	char(10),
   @Usuarios	int
   
  IF dbo.fnEstaSincronizando() = 1 RETURN
     
  SELECT @Cliente = Cliente FROM Inserted
  SELECT @Usuarios = ISNULL(SUM(Usuarios), 0) FROM Sentinel WHERE Cliente = @Cliente
  IF @Usuarios > (SELECT ISNULL(Licencias, 0) FROM Cte WHERE Cliente = @Cliente)
  BEGIN
    RAISERROR ('No se Puede Exceder a las Licencias',16,-1) 
    RETURN
  END
  
  IF UPDATE(Serie) OR UPDATE(Cliente) OR UPDATE(Nombre) OR UPDATE(Usuarios) OR UPDATE(Fabricacion) OR UPDATE(Vencimiento)
    INSERT SentinelHist (Fecha, Serie, Cliente, Nombre, Usuarios, Fabricacion, Vencimiento, Mantenimiento)
                  SELECT GETDATE(), Serie, Cliente, Nombre, Usuarios, Fabricacion, Vencimiento, Mantenimiento 
                    FROM Inserted
END
GO

/****** AuxiliarAlterno ******/
if not exists(select * from SysTabla where SysTabla = 'AuxiliarAlterno')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AuxiliarAlterno','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.AuxiliarAlterno') and type = 'U') 
BEGIN
  CREATE TABLE dbo.AuxiliarAlterno (
	RID			int		NOT NULL IDENTITY(1,1),

	Empresa			char(5)         NULL,
	Sucursal		int		NULL,
	Almacen			varchar(10)	NULL,
	SerieLote		varchar(50)	NULL,
	Posicion		varchar(10)	NULL,
	Modulo			char(5) 	NULL,
        ID			int		NULL,
	Renglon			float		NULL,
	RenglonSub		int		NULL,
	Articulo		char(20)	NULL,
	SubCuenta		varchar(50)	NULL,
	Unidad			varchar(50)	NULL,
	Factor			float		NULL,

	Entrada			float		NULL,
	Salida			float		NULL,

	CONSTRAINT priAuxiliarAlterno PRIMARY KEY CLUSTERED (RID)
  )
  EXEC spSincroSemilla 'AuxiliarAlterno'
END
GO
EXEC spALTER_COLUMN 'AuxiliarAlterno', 'SerieLote', 'varchar(50) NULL'
EXEC spALTER_COLUMN 'AuxiliarAlterno', 'SubCuenta', 'varchar(50) NULL'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarAlterno' AND sysindexes.name = 'Saldo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Saldo ON dbo.AuxiliarAlterno (Articulo, SubCuenta, SerieLote, Posicion, Almacen, Empresa)
GO

if exists(select * from sysobjects where id = object_id('dbo.PosicionAux') and type = 'U') 
BEGIN

  --EXEC("INSERT AuxiliarAlterno(
  --       Empresa, Sucursal, Almacen, Posicion, Modulo, ID, Renglon, RenglonSub, Articulo, SubCuenta, Unidad, Factor, Entrada, Salida)
  --SELECT Empresa, Sucursal, Almacen, Posicion, Modulo, ID, Renglon, RenglonSub, Articulo, SubCuenta, Unidad, Factor, Entrada, Salida
  --  FROM PosicionAux")
  --EXEC("DROP TABLE PosicionAux")

  --TASK2512
  DECLARE @Str VARCHAR(MAX)

  SELECT @Str='INSERT AuxiliarAlterno(
                          Empresa, Sucursal, Almacen, Posicion, Modulo, ID, Renglon, RenglonSub, Articulo, SubCuenta, Unidad, Factor, Entrada, Salida)
                SELECT Empresa, Sucursal, Almacen, Posicion, Modulo, ID, Renglon, RenglonSub, Articulo, SubCuenta, Unidad, Factor, Entrada, Salida
                FROM PosicionAux'

  EXEC(@Str)
  SELECT @Str='DROP TABLE PosicionAux'
  EXEC(@Str)
END
GO


-- Estos triggers se deben de crear al final de otros triggers, por eso se corren estos procedimientos al final
/*IF (SELECT Version FROM Version)<=3100
BEGIN
  EXEC spSincroNivelTabla @CrearTrigger = 0
  EXEC spSincroNivelRegistro @EliminarSincro = 1
END*/
GO

/****** Saldos Contabilidad (Control) ******/
/*if not exists(select * from SysTabla where SysTabla = 'SaldoContCRC')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SaldoContCRC','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SaldoContCRC') and type = 'U') 
CREATE TABLE dbo.SaldoContCRC (
	Ejercicio		int		NOT NULL,
	
	CRC			money		NULL,

	CONSTRAINT priSaldoContCRC PRIMARY KEY CLUSTERED (Ejercicio)
)*/
EXEC spDROP_TABLE 'SaldoContCRC', 3241
GO

/************** spTRCLActivarTabla *************/
if exists (select * from sysobjects where id = object_id('dbo.spTRCLActivarTabla') and type = 'P') drop procedure dbo.spTRCLActivarTabla
GO
CREATE PROCEDURE spTRCLActivarTabla
			@Tabla		varchar(100),
			@Activar	bit = 1
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SQL	varchar(max),
    @Trigger	varchar(100)

  SELECT @Trigger = 'dbo.tg'+@Tabla+'TRCL'
  SELECT @SQL = 'spDROP_TRIGGER '''+@Trigger+'_ABC'''
  EXEC (@SQL)
  IF @Activar = 1
  BEGIN
      SELECT @SQL = 
      'CREATE TRIGGER '+@Trigger+'_ABC ON '+@Tabla+'
      --//WITH ENCRYPTION
      FOR INSERT, UPDATE, DELETE
      AS BEGIN
        IF dbo.fnEstaSincronizando() = 1 RETURN
        IF (SELECT FueraLinea FROM Version WHERE TRCL = 1) = 1
        BEGIN
          SELECT @SQL = "No se puede Editar Fuera Linea ('+@Tabla+')"
          RAISERROR (@SQL,16,-1)     
        END
      END'

      BEGIN TRY
        EXEC (@SQL)
      END TRY
      BEGIN CATCH
        SELECT @SQL = 'Error al Creare el Trigger '+@Trigger+' en la Tabla '+@Tabla
        RAISERROR (@SQL,16,-1)     
      END CATCH
  END
  RETURN
END
GO

/************** spTRCLActualizar *************/
if exists (select * from sysobjects where id = object_id('dbo.spTRCLActualizar') and type = 'P') drop procedure dbo.spTRCLActualizar
GO
CREATE PROCEDURE spTRCLActualizar
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Tabla	varchar(100),
    @Tipo	varchar(100),
    @TRCL	bit,
    @Activar	bit

  SELECT @TRCL = TRCL FROM Version
  --UPDATE SysTabla SET UltimoCambio = GETDATE()
  DECLARE crTRCLActualizar CURSOR LOCAL FOR 
   SELECT SysTabla, Tipo
     FROM SysTabla
  OPEN crTRCLActualizar
  FETCH NEXT FROM crTRCLActualizar INTO @Tabla, @Tipo
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 AND dbo.fnTablaExiste(@Tabla) = 1
    BEGIN
      SELECT @Activar = 0
      IF @TRCL = 1 AND @Tipo IN ('Maestro', 'Cuenta') AND @Tabla NOT IN (SELECT SysTabla FROM SysTabla WHERE FueraLinea = 1) 
        SELECT @Activar = 1
      EXEC spTRCLActivarTabla @Tabla, @Activar
    END
    FETCH NEXT FROM crTRCLActualizar INTO @Tabla, @Tipo
  END
  CLOSE crTRCLActualizar
  DEALLOCATE crTRCLActualizar

  RETURN
END
GO



-- Estos triggers se deben de crear al final de otros triggers, por eso se corren estos procedimientos al final
--EXEC spSincroNivelTabla 
GO
--EXEC spSincroNivelRegistro 
GO
IF (SELECT SincroSSB FROM Version) = 1
  EXEC spSincroSSBActualizar
GO

EXEC spTRCLActualizar
EXEC spFKFinal
GO

UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'MovImpuesto'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'PagadoAux'
GO
--JGD
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'AfectarBitacora'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'AgenteAgenda'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'Anticipo'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'BackOrderLog'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'CB'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'CFDEnviar'
UPDATE SysTabla SET Tipo = 'Movimiento' ,Modulo = 'COMS' WHERE SysTabla = 'CompraSugerir'
UPDATE SysTabla SET Tipo = 'Movimiento' ,Modulo = 'CONT' WHERE SysTabla = 'ContReg'
UPDATE SysTabla SET Tipo = 'Movimiento' ,Modulo = 'CONT' WHERE SysTabla = 'ContXProcesar'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'CuotaCxD'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'eDocSeccionTemporal'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'EstadoCuenta'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'EvaluacionCto'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'InvCapaAux'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'ListaIDRenglon'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'ListaModuloID'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'MovCampoExtra'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'MovCodigo'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'MovCto'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'MovDReg'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'MovExportacionDatos'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'MovFormaAnexo'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'MovGastoIndirecto'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'MovGrupo'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'MovPersonal'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'MovPresupuesto'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'MovRecibo'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'MovReg'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'MovXML'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'Outlook'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'OutlookProcesar'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'ProcesarCBInfo'
UPDATE SysTabla SET Tipo = 'Movimiento' ,Modulo = 'PROD' WHERE SysTabla = 'ProdSerieLoteCosto'
UPDATE SysTabla SET Tipo = 'Movimiento' ,Modulo = 'PROD' WHERE SysTabla = 'ProyResultado'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'SMS'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'TablaAmortizacion'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'TablaAmortizacionGuia'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'TablaAmortizacionMigracion'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'Tarea'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'VerAux'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'VerAuxCorte'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'VerMovFlujo'
--Fin JGD
GO

UPDATE SysTabla SET Tipo = 'Maestro', Modulo = 'PRECI' WHERE SysTabla = 'Precio'
UPDATE SysTabla SET Tipo = 'Maestro', Modulo = 'PRECI' WHERE SysTabla = 'PrecioD'
UPDATE SysTabla SET Tipo = 'Cuenta', Modulo = 'SIS01'  WHERE SysTabla = 'AroEventoPerdida'
UPDATE SysTabla SET Tipo = 'Cuenta', Modulo = 'SIS01' WHERE SysTabla = 'AroEventoPerdidaD'
UPDATE SysTabla SET Tipo = 'Cuenta', Modulo = 'SIS02'  WHERE SysTabla = 'AroRiesgoEvaluacion'
UPDATE SysTabla SET Tipo = 'Cuenta', Modulo = 'SIS02' WHERE SysTabla = 'AroRiesgoEvaluacionD'
UPDATE SysTabla SET Tipo = 'Cuenta', Modulo = 'SIS03'  WHERE SysTabla = 'ArtMaterialHist'
UPDATE SysTabla SET Tipo = 'Cuenta', Modulo = 'SIS03' WHERE SysTabla = 'ArtMaterialHistD'
UPDATE SysTabla SET Tipo = 'Maestro', Modulo = 'SIS04'  WHERE SysTabla = 'GRP_Presupuesto'
UPDATE SysTabla SET Tipo = 'Maestro', Modulo = 'SIS04' WHERE SysTabla = 'GRP_PresupuestoD'
UPDATE SysTabla SET Tipo = 'Maestro', Modulo = 'SIS05'  WHERE SysTabla = 'MovSituacion'
UPDATE SysTabla SET Tipo = 'Maestro', Modulo = 'SIS05' WHERE SysTabla = 'MovSituacionD'
UPDATE SysTabla SET Tipo = 'Maestro', Modulo = 'SIS05' WHERE SysTabla = 'MovSituacionUsuario'
UPDATE SysTabla SET Tipo = 'Maestro', Modulo = 'SIS06'  WHERE SysTabla = 'PlantillaOffice'
UPDATE SysTabla SET Tipo = 'Maestro', Modulo = 'SIS06' WHERE SysTabla = 'PlantillaOfficeD'
GO
UPDATE SysTabla SET Tipo = 'Cuenta', Modulo = 'SIS07'  WHERE SysTabla = 'CteCto'
UPDATE SysTabla SET Tipo = 'Maestro', Modulo = 'SIS07' WHERE SysTabla = 'CteCtoGrupo'
UPDATE SysTabla SET Tipo = 'Maestro', Modulo = 'SIS07' WHERE SysTabla = 'CteCtoComites'
UPDATE SysTabla SET Tipo = 'Maestro', Modulo = 'SIS07' WHERE SysTabla = 'CteCtoActividad'
UPDATE SysTabla SET Tipo = 'Maestro', Modulo = 'SIS07' WHERE SysTabla = 'CteCtoDireccion'
UPDATE SysTabla SET Tipo = 'Cuenta', Modulo = 'SIS07' WHERE SysTabla = 'CteCtoEvento'
UPDATE SysTabla SET Tipo = 'Cuenta', Modulo = 'SIS07' WHERE SysTabla = 'CteCtoHist'
GO
UPDATE SysTabla SET Tipo = 'Cuenta' WHERE SysTabla = 'DocCta'
UPDATE SysTabla SET Tipo = 'Cuenta' WHERE SysTabla = 'Politica'
GO
UPDATE SysTabla SET Tipo = 'Movimiento', Modulo = 'SIS08' WHERE SysTabla = 'Tarea'
UPDATE SysTabla SET Tipo = 'Cuenta', Modulo = 'SIS08' WHERE SysTabla = 'TareaBitacora'
UPDATE SysTabla SET Modulo = 'SIS09' WHERE SysTabla = 'NomX'
UPDATE SysTabla SET Modulo = 'SIS09' WHERE SysTabla = 'NomXDin'
UPDATE SysTabla SET Modulo = 'SIS09' WHERE SysTabla = 'NomXGasto'
UPDATE SysTabla SET Modulo = 'SIS09' WHERE SysTabla = 'NomXCxp'
UPDATE SysTabla SET Modulo = 'SIS09' WHERE SysTabla = 'NomXPersonal'
UPDATE SysTabla SET Modulo = 'SIS09' WHERE SysTabla = 'NomXCxc'
UPDATE SysTabla SET Modulo = 'SIS09' WHERE SysTabla = 'NomXFormula'
UPDATE SysTabla SET Modulo = 'SIS09' WHERE SysTabla = 'NomXPersonalGrupo'

GO
UPDATE SysTabla SET Tipo = 'N/A' WHERE SysTabla = 'eDocModuloVista'
UPDATE SysTabla SET Tipo = 'N/A' WHERE SysTabla = 'eDocModuloVistaAyuda'
GO
UPDATE SysTabla SET Tipo = 'N/A' WHERE SysTabla = 'eDocModuloVista'
UPDATE SysTabla SET Tipo = 'N/A' WHERE SysTabla = 'eDocModuloVistaAyuda'
GO
UPDATE SysTabla SET Tipo = 'Cuenta' WHERE SysTabla = 'ProyPuntoCritico'
GO
UPDATE SysTabla SET Modulo = 'SIS10' WHERE SysTabla = 'eDocD'
UPDATE SysTabla SET Modulo = 'SIS10' WHERE SysTabla = 'eDocDMapeoCampo'
UPDATE SysTabla SET Modulo = 'SIS10' WHERE SysTabla = 'eDocDTagSostener'
UPDATE SysTabla SET Modulo = 'SIS11' WHERE SysTabla = 'ContX'
UPDATE SysTabla SET Modulo = 'SIS11' WHERE SysTabla = 'ContXD'
UPDATE SysTabla SET Modulo = 'SIS12' WHERE SysTabla = 'Evento'
UPDATE SysTabla SET Modulo = 'SIS12' WHERE SysTabla = 'EventoD'
UPDATE SysTabla SET Modulo = 'SIS13' WHERE SysTabla = 'EmbarqueMov'
GO
UPDATE SysTabla SET Tipo = 'Maestro' WHERE SysTabla = 'EmpresaCfgPVMonCta'
GO

GO
if not exists (select * from SysTabla where SysTabla = 'MovEspecificoNomina') INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovEspecificoNomina', 'Maestro')
if not exists (select * from SysTabla where SysTabla = 'ImpuestoEstatalGastoOperacion') INSERT INTO SysTabla (SysTabla, Tipo, Modulo) VALUES ('ImpuestoEstatalGastoOperacion', 'Movimiento','NOM')
GO

IF NOT EXISTS (SELECT * FROM EmpresaCfgMovRecluta) INSERT EmpresaCfgMovRecluta (Empresa) SELECT Empresa FROM Empresa
IF NOT EXISTS (SELECT * FROM EmpresaCfgMovVenta)   INSERT EmpresaCfgMovVenta (Empresa) SELECT Empresa FROM Empresa

-- 'CORTE'
IF NOT EXISTS (SELECT * FROM EmpresaCfgMovCorte)   INSERT EmpresaCfgMovCorte(Empresa) SELECT Empresa FROM Empresa

--REQ16092
IF NOT EXISTS (SELECT * FROM EmpresaCfgMovOPORT)   INSERT EmpresaCfgMovOPORT(Empresa) SELECT Empresa FROM Empresa


IF NOT EXISTS (SELECT * FROM EmpresaCfgMovCompra)  INSERT EmpresaCfgMovCompra (Empresa) SELECT Empresa FROM Empresa    
IF NOT EXISTS (SELECT * FROM EmpresaCfgMovCxp)     INSERT EmpresaCfgMovCxp (Empresa) SELECT Empresa FROM Empresa                
IF NOT EXISTS (SELECT * FROM EmpresaCfgMovCP)      INSERT EmpresaCfgMovCP (Empresa) SELECT Empresa FROM Empresa
IF NOT EXISTS (SELECT * FROM EmpresaCfgMovPCP)     INSERT EmpresaCfgMovPCP (Empresa) SELECT Empresa FROM Empresa
IF NOT EXISTS (SELECT * FROM EmpresaCfgMovGES)     INSERT EmpresaCfgMovGES (Empresa) SELECT Empresa FROM Empresa    
IF NOT EXISTS (SELECT * FROM EmpresaCfgMovDinero)  INSERT EmpresaCfgMovDinero (Empresa) SELECT Empresa FROM Empresa
GO

/****** Saldos Unidades WMS******/
if not exists(select * from SysTabla where SysTabla = 'SaldoUWMS')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SaldoUWMS','Saldo')
if not exists (select * from sysobjects where id = object_id('dbo.SaldoUWMS') and type = 'U') --TASK2512
CREATE TABLE dbo.SaldoUWMS (
	Sucursal		int		NOT NULL DEFAULT 0,
	Empresa			char(5)         NOT NULL,
	Rama			char(5)         NOT NULL,
 	Moneda			char(10)	NOT NULL,
	Grupo			char(10)        NOT NULL,
	SubGrupo		varchar(20)     NOT NULL,
	Cuenta			char(20)        NOT NULL,
	SubCuenta		varchar(50)	NOT NULL,

	Saldo			money		NULL,
	SaldoU			float		NULL,
	PorConciliar		money		NULL,
	PorConciliarU		float		NULL,
	UltimoCambio		datetime	NULL,

	CONSTRAINT priSaldoUWMS PRIMARY KEY CLUSTERED (Cuenta, SubCuenta, Grupo, SubGrupo, Rama, Moneda, Sucursal, Empresa)
)
GO
--TASK2512
/****** Acumulados Unidades WMS ******/
if not exists(select * from SysTabla where SysTabla = 'AcumUWMS')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AcumUWMS','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.AcumUWMS') and Type = 'U') --TASK2512
CREATE TABLE dbo.AcumUWMS (
	Sucursal		int		NOT NULL DEFAULT 0,
	Empresa			char(5)         NOT NULL,
	Rama			char(5)         NOT NULL,
	Ejercicio		int		NOT NULL,
	Periodo			int		NOT NULL,
	Moneda			char(10)	NOT NULL,
	Grupo			char(10)        NOT NULL,
	SubGrupo		varchar(20)	NOT NULL,
	Cuenta			char(20)        NOT NULL,
	SubCuenta		varchar(50)	NOT NULL,

	Cargos			money		NULL,
	Abonos			money		NULL,
	CargosU			float		NULL,
	AbonosU			float		NULL,
	UltimoCambio		datetime	NULL,
						  
	CONSTRAINT priAcumUWMS PRIMARY KEY CLUSTERED (Cuenta, SubCuenta, Grupo, SubGrupo, Rama, Ejercicio, Periodo, Moneda, Sucursal, Empresa)
)
go
--TASK2512
if exists (select * from sysobjects where id = object_id('AcumUWMS') and type = 'U')
Begin
	EXEC spModificarPK_AcumSaldo 'AcumUWMS', '(Cuenta, SubCuenta, Grupo, SubGrupo, Rama, Ejercicio, Periodo, Moneda, Sucursal, Empresa)'
	--GO
	IF NOT EXISTS(SELECT * FROM SysCampo WHERE Tabla='AcumUWMS' AND Campo='SubGrupo')
	BEGIN
	  EXEC spALTER_TABLE 'AcumUWMS', 'SubGrupo', 'varchar(20) NOT NULL DEFAULT '''' WITH VALUES'
	  EXEC spALTER_PK 'AcumUWMS', 'Cuenta, SubCuenta, Grupo, SubGrupo, Rama, Ejercicio, Periodo, Moneda, Sucursal, Empresa'
	END
	--GO
	if exists(select * from SysTipoDatos WHERE Tabla = 'AcumUWMS' AND Campo = 'SubCuenta' and Tamano=20)
	BEGIN
	  EXEC spEliminarPK 'AcumUWMS'
	  EXEC spALTER_COLUMN 'AcumUWMS', 'SubCuenta', 'varchar(50) NOT NULL'
	  EXEC('ALTER TABLE AcumUWMS ADD CONSTRAINT priAcumUWMS PRIMARY KEY CLUSTERED (Cuenta, SubCuenta, Grupo, SubGrupo, Rama, Ejercicio, Periodo, Moneda, Sucursal, Empresa)')
	END
	--GO
	if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AcumUWMS' AND sysindexes.name = 'Grupo' AND sysobjects.id = sysindexes.id)
	  CREATE INDEX Grupo ON dbo.AcumUWMS (Grupo, Rama, Moneda, Ejercicio, Periodo, Sucursal, Empresa)
End
GO
/****** Auxiliares Unidades ******/
if not exists(select * from SysTabla where SysTabla = 'AuxiliarUWMS')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AuxiliarUWMS','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.AuxiliarUWMS') and type = 'U') --TASK2512
BEGIN
  CREATE TABLE dbo.AuxiliarUWMS (
	ID			        int		    NOT NULL IDENTITY(1,1),
	Empresa			    char(5)     NOT NULL,
	Rama			    char(5)     NOT NULL,
	Mov 			    char(20)   	NOT NULL,
	MovID			    varchar(20) NOT NULL,
	Modulo			    char(5) 	NULL,
    ModuloID		    int		    NULL,
	Moneda			    char(10)	NULL,
	TipoCambio		    float		NULL,
	Grupo			    char(10)    NULL,
	SubGrupo		    varchar(20)	NULL,
	Cuenta			    char(20)    NULL,
	SubCuenta		    varchar(50)	NULL,
	Ejercicio		    int		    NULL,
	Periodo			    int		    NULL,
    Fecha			    datetime	NULL,
	Cargo			    money		NULL,
	Abono			    money		NULL,
	CargoU			    float		NULL,
	AbonoU			    float		NULL,
	Aplica			    varchar(20) NULL,
	AplicaID		    varchar(20)	NULL,
	Acumulado		    bit		    NOT NULL DEFAULT 0,
	Conciliado		    bit		    NOT NULL DEFAULT 0,
	EsCancelacion		bit		    NOT NULL DEFAULT 0,
	FechaConciliacion	datetime	NULL,
	Sucursal		    int	        NOT NULL DEFAULT 0,
--	SincroID 		    timestamp 	NULL,
--	SincroC  		    int 		NULL 	 DEFAULT 1,
	Renglon			    float       NULL,
	RenglonSub		    int	        NULL,
    IDAuxU              int         NULL, 
    IDWMS               int         NULL
	CONSTRAINT priAuxiliarUWMS PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'AuxiliarUWMS'
END
GO
if (select version from version) BETWEEN 1 and 1095
  ALTER TABLE AuxiliarUWMS ALTER COLUMN MovID varchar(20)
GO
if (select version from version) BETWEEN 1 and 1095
  ALTER TABLE AuxiliarUWMS ALTER COLUMN AplicaID varchar(20)
GO
EXEC spALTER_COLUMN 'AuxiliarU', 'SubCuenta', 'varchar(50) NULL'
GO
EXEC spALTER_TABLE 'AuxiliarUWMS', 'SubGrupo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'AuxiliarUWMS', 'Renglon', 'float NULL'
EXEC spALTER_TABLE 'AuxiliarUWMS', 'RenglonSub', 'int NULL'
GO
--TASK2512
if exists (select * from sysobjects where id = object_id('AuxiliarU') and type = 'U')
Begin
	if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarUWMS' AND sysindexes.name = 'Cuenta' AND sysobjects.id = sysindexes.id)
	  CREATE INDEX Cuenta ON dbo.AuxiliarUWMS (Cuenta, SubCuenta, Grupo, Rama, Moneda, Ejercicio, Periodo, Fecha, Sucursal, Empresa)
	--GO
	if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarUWMS' AND sysindexes.name = 'Grupo' AND sysobjects.id = sysindexes.id)
	  CREATE INDEX Grupo ON dbo.AuxiliarUWMS (Grupo, Rama, Moneda, Ejercicio, Periodo, Fecha, Sucursal, Empresa)
	--GO
	if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarUWMS' AND sysindexes.name = 'Fecha' AND sysobjects.id = sysindexes.id)
	  CREATE INDEX Fecha ON dbo.AuxiliarUWMS (Fecha, Cuenta, SubCuenta, Grupo, Moneda)
	--GO
	if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarUWMS' AND sysindexes.name = 'ModuloID' AND sysobjects.id = sysindexes.id)
	  CREATE INDEX ModuloID ON dbo.AuxiliarUWMS (ModuloID, Modulo)
	--GO
	EXEC spModificarPK_SucursalSinOrigen 'AuxiliarUWMS', '(ID)'

	if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarUWMS' AND sysindexes.name = 'Cuenta' AND sysobjects.id = sysindexes.id)
	  CREATE INDEX Cuenta ON dbo.AuxiliarUWMS (Cuenta, SubCuenta, Grupo, Rama, Moneda, Ejercicio, Periodo, Fecha, Sucursal, Empresa)
	if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarUWMS' AND sysindexes.name = 'Fecha' AND sysobjects.id = sysindexes.id)
	  CREATE INDEX Fecha ON dbo.AuxiliarUWMS (Fecha, Cuenta, SubCuenta, Grupo, Moneda)
	if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarUWMS' AND sysindexes.name = 'Grupo' AND sysobjects.id = sysindexes.id)
	  CREATE INDEX Grupo ON dbo.AuxiliarUWMS (Grupo, Rama, Moneda, Ejercicio, Periodo, Fecha, Sucursal, Empresa)
	if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarUWMS' AND sysindexes.name = 'SubGrupo' AND sysobjects.id = sysindexes.id)
	  CREATE INDEX SubGrupo ON dbo.AuxiliarUWMS (SubGrupo, Grupo, Rama, Moneda, Ejercicio, Periodo, Fecha, Sucursal, Empresa)
	if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarUWMS' AND sysindexes.name = 'ModuloID' AND sysobjects.id = sysindexes.id)
	  CREATE INDEX ModuloID ON dbo.AuxiliarUWMS (ModuloID, Modulo)

End
GO
if exists (select * from sysobjects where id = object_id('SaldoUWMS') and type = 'U')
Begin
	IF NOT EXISTS(SELECT * FROM SysCampo WHERE Tabla='SaldoUWMS' AND Campo='SubGrupo')
	BEGIN
	  EXEC spALTER_TABLE 'SaldoUWMS', 'SubGrupo', 'varchar(20) NOT NULL DEFAULT '''' WITH VALUES'
	  EXEC spALTER_PK 'SaldoUWMS', 'Cuenta, SubCuenta, Grupo, SubGrupo, Rama, Moneda, Sucursal, Empresa'
	END
	--GO
	if exists(select * from SysTipoDatos WHERE Tabla = 'SaldoUWMS' AND Campo = 'SubCuenta' and Tamano=20)
	BEGIN
	  EXEC spEliminarPK 'SaldoUWMS'
	  EXEC spALTER_COLUMN 'SaldoUWMS', 'SubCuenta', 'varchar(50) NOT NULL'
	  EXEC('ALTER TABLE SaldoUWMS ADD CONSTRAINT priSaldoUWMS PRIMARY KEY CLUSTERED (Cuenta, SubCuenta, Grupo, SubGrupo, Rama, Moneda, Sucursal, Empresa)')
	END
	--GO
	EXEC spModificarPK_AcumSaldo 'SaldoUWMS', '(Cuenta, SubCuenta, Grupo, SubGrupo, Rama, Moneda, Sucursal, Empresa)'
	--GO
	if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'SaldoUWMS' AND sysindexes.name = 'Grupo' AND sysobjects.id = sysindexes.id)
	  CREATE INDEX Grupo ON dbo.SaldoUWMS (Grupo, Rama, Moneda, Sucursal, Empresa)
	--go
	EXEC spADD_INDEX 'SaldoUWMS', 'SubGrupo', 'SubGrupo, Grupo, Empresa'
	--GO
	-- BUG12036
	EXEC spADD_INDEX 'SaldoUWMS', 'InvAlm', 'Empresa) INCLUDE(Rama, Grupo, Cuenta, SaldoU'
End
GO

IF EXISTS (SELECT * FROM SYSTABLA WHERE SysTabla = 'PeriodoTipo')
BEGIN
	EXEC spALTER_TABLE 'PeriodoTipo', 'PeriodicidadPago', 'int NULL' 
	EXEC spALTER_TABLE 'PeriodoTipo', 'NominaAnexo20', 'bit NULL DEFAULT 0 WITH VALUES' 
END
GO