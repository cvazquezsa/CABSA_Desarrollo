---SCRIP SQL: CREA LAS TABLAS TEMPORALES EN LAS CUALES SE INSERTARAN LOS DATOS EXTRAIDOS DEL ERP
---PARA SU IMPORTACIÓN Y VALIDACIÓN AL MODULO IFRS

---Se declaran variables que contendran datos generales de la actual importación,
---esto para preparar dichas tablas temporales unica y especificamente para una determinada Empresa, Ejercicio y periodo.
---y no afectar si existen datos extraido de alguna otra empresa.
DECLARE @Clave_empresa as varchar(20),	    --Nombre corto o identificador unico de la empresa
		@Ejercicio as bigint,				--Ejercicio actual de importación
		@Periodo as int;					--Periodo actual de importación.
		
		

----Los valores que se le asignaran a las variables declaradas previamente se obtendran por parametros 
----una ves implementado el Script SQL en un SP que se ejecutara desde la aplicación web (IFRS)(o ERP del cliente)

--Asignación manual de valores a las variables (Solo para crear manualmente y preparar las tablas temporales requeridas)
SET @Clave_empresa ='SPT';	--Nombre corto o identificador unico de la empresa
SET @Ejercicio = 2013;		--Ejercicio actual de importación
SET @Periodo =8;			--Periodo actual de importación.


PRINT '@Clave_empresa: ' + @Clave_empresa;
PRINT '@Ejercicio: ' + cast(@Ejercicio as varchar(10));
PRINT '@Periodo: ' + cast(@Periodo as varchar(10));

---Inicia el proceso para preparar las tablas temporales en donde se insertaran los datos.--------


--  #######  ######  #    #  #######   #####  ######  ########   #######
--  #        #    #  #    #     #     #     # #			 #	     #     #
--  #        #    #  ##   #     #     #     # #		     #	     #     #
--  #		 #	  #  # #  #     #     ####### #			 #		 #     #
--  #        #    #  #  # #     #     #     # #			 #		 #     #
--  #        #    #  #   ##     #     #     # #		     #	     #     #
--  #######  ######  #    #     #     #     # ######     #	     #######


-- Verifico si existen las tablas temporales, y si es asi, las elimino.
if exists (select * from sysobjects where id = object_id('tmpContactos'))
BEGIN
	DELETE FROM tmpContactos WHERE ID_empresa=@Clave_empresa; --Drop Table tmpContactos;
END
ELSE
BEGIN
CREATE TABLE [tmpContactos](
	[Clave] [varchar](20) NOT NULL,
	[Nombres] [varchar](50) NOT NULL,
	[Apellidos] [nvarchar](50) NOT NULL,		
	[Puesto] [varchar](30) NULL,
	[Telefono] [varchar](30) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[RFC] [varchar](16) NULL,
	[Curp] [varchar](30) NULL,
	[ID_empresa] [varchar](20) NOT NULL
) ON [PRIMARY]

SET ANSI_PADDING OFF

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Clave de usuario/Nombre corto/Nickname. No se repite' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tmpContactos', @level2type=N'COLUMN',@level2name=N'Clave'

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Clave de la empresa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tmpContactos', @level2type=N'COLUMN',@level2name=N'Nombres'

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre de la empresa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tmpContactos', @level2type=N'COLUMN',@level2name=N'Apellidos'

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Grupo al que eprtenece la empresa, (Opcional)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tmpContactos', @level2type=N'COLUMN',@level2name=N'Puesto'

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Dirección fiscal de la empresa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tmpContactos', @level2type=N'COLUMN',@level2name=N'Telefono'

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Numero exterior de la dirección de la empresa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tmpContactos', @level2type=N'COLUMN',@level2name=N'Email'

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Rfc del contacto' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tmpContactos', @level2type=N'COLUMN',@level2name=N'RFC'

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Curp del contacto' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tmpContactos', @level2type=N'COLUMN',@level2name=N'Curp'

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identificador de la empresa/Clave del catalogo de empresas' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tmpContactos', @level2type=N'COLUMN',@level2name=N'ID_empresa'

END


--  #######
--  #        #    #  #####   #####   ######   ####     ##     ####
--  #        ##  ##  #    #  #    #  #       #        #  #   #
--  #####    # ## #  #    #  #    #  #####    ####   #    #   ####
--  #        #    #  #####   #####   #            #  ######       #
--  #        #    #  #       #   #   #       #    #  #    #  #    #
--  #######  #    #  #       #    #  ######   ####   #    #   ####


-- Verifico si existen las tablas temporales, y si es asi, las elimino.
if exists (select * from sysobjects where id = object_id('tmpEmpresas'))
BEGIN
	DELETE FROM tmpEmpresas WHERE ID_empresa= @Clave_empresa; --Drop Table tmpEmpresas;
END
ELSE
BEGIN
CREATE TABLE [tmpEmpresas](
	[ID_empresa] [varchar](20) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,		
	[Grupo] [varchar](100) NULL,	
	[Registro_patronal] [varchar](20) NULL,
	--EWQ
	--[Tipo_empresa] [varchar](10) NULL,
	--[Giro_empresa] [varchar](10) NULL,
	--[Rango_empleados] int NULL,			
	[Tipo_empresa] [varchar](10) NULL,
	[Giro_empresa] [varchar](10) NULL,
	[Rango_empleados] int NULL,		
	[Direccion] [varchar](200) NOT NULL,
	[DireccionNumero] [varchar](20) NOT NULL,
	[DireccionNumeroInt] [varchar](20) NULL,
	[Clave_pais] [varchar](20) NULL,	
	[Clave_estado] [varchar](20)  NULL,	
	[Clave_ciudad] [varchar](50)  NULL,	
	[Colonia] [varchar](200) NULL,
	[Localidad] [varchar](200) NULL,	
	[CodigoPostal] [varchar](20) NOT NULL,
	[Telefonos] [varchar](20) NOT NULL,
	[RFC] [varchar](20) NOT NULL,
	[Curp] [nvarchar](50) NULL	
) ON [PRIMARY]

SET ANSI_PADDING OFF

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Clave de la empresa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tmpEmpresas', @level2type=N'COLUMN',@level2name=N'ID_empresa'

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre de la empresa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tmpEmpresas', @level2type=N'COLUMN',@level2name=N'Nombre'

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Grupo al que eprtenece la empresa, (Opcional)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tmpEmpresas', @level2type=N'COLUMN',@level2name=N'Grupo'


EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Asignado por el IMSS' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tmpEmpresas', @level2type=N'COLUMN',@level2name=N'Registro_patronal'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Proviene de catálogo: 1=Empresa, 2=Despacho, 3=Gobierno, 4=Universidad' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tmpEmpresas', @level2type=N'COLUMN',@level2name=N'Tipo_empresa'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Proviene de catálogo: 1=Servicios, 2=Comercial, 3=Industrial' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tmpEmpresas', @level2type=N'COLUMN',@level2name=N'Giro_empresa'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Proviene de catálogo: 1=1-10, 2=11-50, 3=51-250, 4=251-adelante' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tmpEmpresas', @level2type=N'COLUMN',@level2name=N'Rango_empleados'

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Dirección fiscal de la empresa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tmpEmpresas', @level2type=N'COLUMN',@level2name=N'Direccion'

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Numero exterior de la dirección de la empresa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tmpEmpresas', @level2type=N'COLUMN',@level2name=N'DireccionNumero'

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Numero interior de la empresa (opcional)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tmpEmpresas', @level2type=N'COLUMN',@level2name=N'DireccionNumeroInt'

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Proviene de catálogo, Clave del País' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tmpEmpresas', @level2type=N'COLUMN',@level2name=N'Clave_pais'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Proviene de catálogo, Clave del Estado' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tmpEmpresas', @level2type=N'COLUMN',@level2name=N'Clave_estado'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Clave de la ciudad, del catalogo general' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tmpEmpresas', @level2type=N'COLUMN',@level2name=N'Clave_ciudad'

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Clave de la ciudad, del catalogo general' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tmpEmpresas', @level2type=N'COLUMN',@level2name=N'Colonia'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Clave de la ciudad, del catalogo general' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tmpEmpresas', @level2type=N'COLUMN',@level2name=N'Localidad'

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo postal de la ubicación de la empresa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tmpEmpresas', @level2type=N'COLUMN',@level2name=N'CodigoPostal'

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Telefonos de la empresa separados por coma.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tmpEmpresas', @level2type=N'COLUMN',@level2name=N'Telefonos'

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'RFC de la empresa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tmpEmpresas', @level2type=N'COLUMN',@level2name=N'RFC'

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(si es persona física)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tmpEmpresas', @level2type=N'COLUMN',@level2name=N'Curp'

END

--   #####
--  #     #  #    #  ######  #    #   #####    ##     ####
--  #        #    #  #       ##   #     #     #  #   #
--  #        #    #  #####   # #  #     #    #    #   ####
--  #        #    #  #       #  # #     #    ######       #
--  #     #  #    #  #       #   ##     #    #    #  #    #
--   #####    ####   ######  #    #     #    #    #   ####

-- Verifico si existen las tablas temporales, y si es asi, las elimino.
if exists (select * from sysobjects where id = object_id('tmpCuentas_Contables'))
BEGIN
	 DELETE FROM tmpCuentas_Contables where ID_empresa=@Clave_empresa;--Drop Table tmpCuentas_Contables;
END
ELSE
BEGIN
CREATE TABLE [tmpCuentas_Contables] ( 
 [ID_empresa] varchar(20) COLLATE Modern_Spanish_CI_AS NOT NULL,
 [Cuenta_contable] nvarchar(60) COLLATE Modern_Spanish_CI_AS NOT NULL,
 [Cuenta_control] nvarchar(60) COLLATE Modern_Spanish_CI_AS NOT NULL, 
 [Descripcion] nvarchar(250) COLLATE Modern_Spanish_CI_AS NOT NULL,
 [Clase_cuenta] nvarchar(1) COLLATE Modern_Spanish_CI_AS NOT NULL,
 [Moneda] nvarchar(10) COLLATE Modern_Spanish_CI_AS NOT NULL,  
 [Estatus] nvarchar(10) COLLATE Modern_Spanish_CI_AS NULL,
 [ID_impuesto] int NOT NULL,
 [Es_Deducible] int NULL
) 
ON [PRIMARY]

EXEC sp_addextendedproperty 'MS_Description', N'Identificador unico de la empresa/Clave de la empresa', 'schema', 'dbo', 'table', 'tmpCuentas_Contables', 'column', 'ID_empresa'

EXEC sp_addextendedproperty 'MS_Description', N'Clave de la cuenta contable', 'schema', 'dbo', 'table', 'tmpCuentas_Contables', 'column', 'Cuenta_contable'

EXEC sp_addextendedproperty 'MS_Description', N'clave de la cuenta agrupadora', 'schema', 'dbo', 'table', 'tmpCuentas_Contables', 'column', 'Cuenta_control'

EXEC sp_addextendedproperty 'MS_Description', N'Descripción/Nombre de la cuenta', 'schema', 'dbo', 'table', 'tmpCuentas_Contables', 'column', 'Descripcion'

EXEC sp_addextendedproperty 'MS_Description', N'R= Cuenta de registro; C=Cuenta de control', 'schema', 'dbo', 'table', 'tmpCuentas_Contables', 'column', 'Clase_cuenta'

EXEC sp_addextendedproperty 'MS_Description', N'Tipo de cambio, clave de la moneda extranjera (depende de parametro),
Moneda local =1', 'schema', 'dbo', 'table', 'tmpCuentas_Contables', 'column', 'Moneda'

EXEC sp_addextendedproperty 'MS_Description', N'1=Activa, 2=Inactiva', 'schema', 'dbo', 'table', 'tmpCuentas_Contables', 'column', 'Estatus'

EXEC sp_addextendedproperty 'MS_Description', N'Tasa de impuesto que grava (1 = IVA16, 2=IVA0, 3=EXENTO)', 'schema', 'dbo', 'table', 'tmpCuentas_Contables', 'column', 'ID_impuesto'

EXEC sp_addextendedproperty 'MS_Description', N'1=SI, 2=NO', 'schema', 'dbo', 'table', 'tmpCuentas_Contables', 'column', 'Es_Deducible'

END



-- ######
-- #     #   ####   #          #    ######    ##     ####
-- #     #  #    #  #          #        #    #  #   #
-- ######   #    #  #          #       #    #    #   ####
-- #        #    #  #          #      #     ######       #
-- #        #    #  #          #     #      #    #  #    #
-- #         ####   ######     #    ######  #    #   ####

-- Verifico si existen las tablas temporales, y si es asi, las elimino.
if exists (select * from sysobjects where id = object_id('tmpPolizas'))
BEGIN
	DELETE FROM tmpPolizas WHERE ID_empresa =@Clave_empresa and Ejercicio=@Ejercicio and Periodo=@Periodo;--Drop Table [tmpPolizas];
END
ELSE
BEGIN
CREATE TABLE [tmpPolizas] ( 
 [ID_empresa] varchar(10) COLLATE Modern_Spanish_CI_AS NOT NULL,
 [ID_concepto] varchar(20) COLLATE Modern_Spanish_CI_AS NULL,
 [ID_recordatorio] varchar(20) COLLATE Modern_Spanish_CI_AS NULL,
 [Referencia] nvarchar(30) COLLATE Modern_Spanish_CI_AS NOT NULL,
 [Origen_modulo] nvarchar(50) COLLATE Modern_Spanish_CI_AS NULL,
 --EWQ
 ----[Deducible] int NOT NULL,
 ----[No_deducible] int NOT NULL,
 --[Tipo_transaccion] int NOT NULL,
 [Deducible] int NULL,
 [No_deducible] int NULL,
 [Tipo_transaccion] int NULL, 
 [Ejercicio] int NULL,
 [Periodo] int NULL,
 [Fecha_operacion] varchar(10) COLLATE Modern_Spanish_CI_AS NULL,   
 --EWQ 
 --[Tipo_poliza] nvarchar(10) COLLATE Modern_Spanish_CI_AS NOT NULL,
 --[No_Poliza] nvarchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL,  
 [Tipo_poliza] nvarchar(10) COLLATE Modern_Spanish_CI_AS NULL,
 [No_Poliza] nvarchar(50) COLLATE Modern_Spanish_CI_AS NULL,   
 [Fecha_registro] varchar(10) COLLATE Modern_Spanish_CI_AS NULL,
 [Concepto_poliza] nvarchar(50) COLLATE Modern_Spanish_CI_AS NULL,
 [Cuenta_contable] nvarchar(60) COLLATE Modern_Spanish_CI_AS NOT NULL,
 [Concepto_transaccion] varchar(300) COLLATE Modern_Spanish_CI_AS NULL,
 --[Debe] numeric(18, 2) NOT NULL,
 --[Haber] numeric(18, 2) NOT NULL, 
 --EWQ
 [Debe] float NOT NULL,
 [Haber] float NOT NULL, 
 [Tipo_cambio] nvarchar(30) COLLATE Modern_Spanish_CI_AS NOT NULL,      
 [No_cheque] varchar(20) COLLATE Modern_Spanish_CI_AS NULL,
 [Banco_origen_cheque] varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
 [Cuenta_origen_cheque] varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
 [Fecha_cheque] varchar(10) COLLATE Modern_Spanish_CI_AS NULL,
 [Monto_cheque] decimal(18, 4) NULL, 
 [Beneficiario_cheque] varchar(100) COLLATE Modern_Spanish_CI_AS NULL,
 [RFC_beneficiario_cheque] varchar(100) COLLATE Modern_Spanish_CI_AS NULL, 
 [Cuenta_origen_trans] varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
 [Banco_origen_trans] varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
 [Monto_transferencia] decimal(18, 4) NULL, 
 [Cuenta_destinatario_trans] varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
 [Banco_destinatario_trans] varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
 [Fecha_transferencia] varchar(10) COLLATE Modern_Spanish_CI_AS NULL,
 [Beneficiario_transferencia] varchar(300) COLLATE Modern_Spanish_CI_AS NULL,
 [RFC_destinatario_trans] varchar(13) COLLATE Modern_Spanish_CI_AS NULL, 
 [Foliof_digital] nvarchar(36) COLLATE Modern_Spanish_CI_AS NULL,
 [Monto_comprobante] decimal(18, 4) NULL, 
 [RFC_destinatario_comprobante] nvarchar(13) COLLATE Modern_Spanish_CI_AS NULL,
 --BUG24986
 [Tipo_moneda] nvarchar(15) COLLATE Modern_Spanish_CI_AS NULL
 
)
ON [PRIMARY]

EXEC spALTER_TABLE 'tmpPolizas', 'Tipo_moneda', 'nvarchar(15) NULL'

EXEC sp_addextendedproperty 'MS_Description', N'Identificador unico del catalogo de empresas/Clave de la empresa', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'ID_empresa'

EXEC sp_addextendedproperty 'MS_Description', N'Clave/identificador del catalogo de conceptos', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'ID_concepto'


EXEC sp_addextendedproperty 'MS_Description', N'Clave/identificador del catalogo de recordatorios', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'ID_recordatorio'

EXEC sp_addextendedproperty 'MS_Description', N'Clave del origen del movimiento dentro del ERP', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'Referencia'

EXEC sp_addextendedproperty 'MS_Description', N'Módulo que origina el registro:
- compras 
- ventas 
- gastos 
- cxc 
- cxp', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'Origen_modulo'

EXEC sp_addextendedproperty 'MS_Description', N'% deducible del monto', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'Deducible'

EXEC sp_addextendedproperty 'MS_Description', N'% No dedicible del monto', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'No_deducible'

EXEC sp_addextendedproperty 'MS_Description', N'Tipo de la póliza transacción, 1=Cheque, 2=Transferencia y 3=Comprobante', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'Tipo_transaccion'

EXEC sp_addextendedproperty 'MS_Description', N'Fecha de operación dia/mes/año', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'Fecha_operacion'

EXEC sp_addextendedproperty 'MS_Description', N'Tipo/Identificador tipo de poliza del cliente', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'Tipo_poliza'

EXEC sp_addextendedproperty 'MS_Description', N'Numero de póliza', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'No_Poliza'

EXEC sp_addextendedproperty 'MS_Description', N'Fecha de registro de la póliza', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'Fecha_registro'

EXEC sp_addextendedproperty 'MS_Description', N'Concepto de la operación. (Obligatorio si se omite ID_concepto)', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'Concepto_poliza'

EXEC sp_addextendedproperty 'MS_Description', N'Clave de la cuenta contable', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'Cuenta_contable'

EXEC sp_addextendedproperty 'MS_Description', N'Concepto de la transacción.', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'Concepto_transaccion'

EXEC sp_addextendedproperty 'MS_Description', N'Importe del cargo', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'Debe'

EXEC sp_addextendedproperty 'MS_Description', N'Importe del abono', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'Haber'

EXEC sp_addextendedproperty 'MS_Description', N'Identificador del tipo de cambio', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'Tipo_cambio'

EXEC sp_addextendedproperty 'MS_Description', N'Numero del cheque, solo si es egresos y pago con cheque.', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'No_cheque'

EXEC sp_addextendedproperty 'MS_Description', N'Nombre del banco origen, Solo si es Egresos y pago con cheque.', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'Banco_origen_cheque'

EXEC sp_addextendedproperty 'MS_Description', N'Cuenta del banco origen de la transacción, Solo si es Egresos y pago con cheque.', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'Cuenta_origen_cheque'

EXEC sp_addextendedproperty 'MS_Description', N'Fecha de expedición del cheque dia/mes/año, Solo si es Egresos y pago con cheque.', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'Fecha_cheque'

EXEC sp_addextendedproperty 'MS_Description', N'Monto/Importe del cheque, Solo si es Egresos y pago con cheque.', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'Monto_cheque'

EXEC sp_addextendedproperty 'MS_Description', N'Nombre del beneficiario, Solo si es Egresos y pago con cheque.', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'Beneficiario_cheque'

EXEC sp_addextendedproperty 'MS_Description', N'RFC del beneficiario, Solo si es Egresos y pago con cheque.', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'RFC_beneficiario_cheque'

EXEC sp_addextendedproperty 'MS_Description', N'Cuenta origen de la transacción, Solo si es Egresos y pago con transferencia.', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'Cuenta_origen_trans'

EXEC sp_addextendedproperty 'MS_Description', N'Nombre del banco origen de la transacción, Solo si es Egresos y pago con transferencia.', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'Banco_origen_trans'

EXEC sp_addextendedproperty 'MS_Description', N'Monto/Importe de la transferencia o transacción , Solo si es Egresos y pago con transferencia.', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'Monto_transferencia'

EXEC sp_addextendedproperty 'MS_Description', N'Numero de cuenta del destinatario/beneficiario, Solo si es Egresos y pago con transferencia.', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'Cuenta_destinatario_trans'

EXEC sp_addextendedproperty 'MS_Description', N'Nombre del banco destino de la transacción, Solo si es Egresos y pago con transferencia.', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'Banco_destinatario_trans'

EXEC sp_addextendedproperty 'MS_Description', N'Fecha de la transacción dia/mes/año, Solo si es Egresos y pago con transferencia.', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'Fecha_transferencia'

EXEC sp_addextendedproperty 'MS_Description', N'Nombre del beneficiario , Solo si es Egresos y pago con transferencia.', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'Beneficiario_transferencia'

EXEC sp_addextendedproperty 'MS_Description', N'RFC del destinatario/beneficiario, Solo si es Egresos y pago con transferencia.', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'RFC_destinatario_trans'

EXEC sp_addextendedproperty 'MS_Description', N'Folio fiscal digital, Solo si es póliza de diario de comprobación (Registro de costo, gasto o activo fijo, ingresos).', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'Foliof_digital'

EXEC sp_addextendedproperty 'MS_Description', N'Monto de la transacción, Solo si es póliza de diario de comprobación (Registro de costo, gasto o activo fijo, ingresos).', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'Monto_comprobante'

EXEC sp_addextendedproperty 'MS_Description', N'RFC del destinatario, Solo si es póliza de diario de comprobación (Registro de costo, gasto o activo fijo, ingresos).', 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'RFC_destinatario_comprobante'

EXEC sp_addextendedproperty 'MS_Description', N'Tipo de moneda de la operación' , 'schema', 'dbo', 'table', 'tmpPolizas', 'column', 'Tipo_moneda'



END


---Int_Tipospoliza_clases

if exists (select * from sysobjects where id = object_id('Int_Tipospolizas_Clases'))
BEGIN
	DELETE FROM Int_Tipospolizas_Clases WHERE ID_empresa = @Clave_empresa; 
END
ELSE
BEGIN
CREATE TABLE [Int_Tipospolizas_Clases] ( 
 [ID_poliza] varchar(10) COLLATE Modern_Spanish_CI_AS NOT NULL,
 [Descripcion] nvarchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL,
 [Clase] nvarchar(2) COLLATE Modern_Spanish_CI_AS NOT NULL,
 [ID_empresa] nvarchar(2) COLLATE Modern_Spanish_CI_AS NOT NULL  
)

EXEC sp_addextendedproperty 'MS_Description', N'Tipo/Identificador de poliza del cliente', 'schema', 'dbo', 'table', 'Int_Tipospolizas_Clases', 'column', 'ID_poliza'

EXEC sp_addextendedproperty 'MS_Description', N'Descripcion del tipo de poliza', 'schema', 'dbo', 'table', 'Int_Tipospolizas_Clases', 'column', 'Descripcion'

EXEC sp_addextendedproperty 'MS_Description', N'Identificador/Clase de poliza', 'schema', 'dbo', 'table', 'Int_Tipospolizas_Clases', 'column', 'Clase'

EXEC sp_addextendedproperty 'MS_Description', N'Identificador unico del catalogo de empresas/Clave de la empresa', 'schema', 'dbo', 'table', 'Int_Tipospolizas_Clases', 'column', 'ID_empresa'

END



-- 
--    ####	   #####
--  #			 #
--    ####		 #
--        #		 #
--   #    #		 #
--    ####  #  ##### #

if exists (select * from sysobjects where id = object_id('tmpSaldo_Inicial'))
BEGIN
	DELETE FROM tmpSaldo_Inicial WHERE ID_empresa = @Clave_empresa and Ejercicio=@Ejercicio and Periodo=@Periodo;--Drop Table [tmpSaldo_Inicial];
END
ELSE
BEGIN
CREATE TABLE [tmpSaldo_Inicial] ( 
 [ID_empresa] varchar(10) COLLATE Modern_Spanish_CI_AS NOT NULL,
 [Cuenta_contable] nvarchar(60) COLLATE Modern_Spanish_CI_AS NOT NULL,
 [Ejercicio] smallint NOT NULL,
 [Periodo] smallint NOT NULL, 
 [Saldo_inicial_debe] float NOT NULL,
 [Saldo_inicial_haber] float NOT NULL 
  
)

EXEC sp_addextendedproperty 'MS_Description', N'id de la empresa, identificador único del catálogo de empresas', 'schema', 'dbo', 'table', 'tmpSaldo_Inicial', 'column', 'ID_empresa'

EXEC sp_addextendedproperty 'MS_Description', N'Clave de la cuenta contable', 'schema', 'dbo', 'table', 'tmpSaldo_Inicial', 'column', 'Cuenta_contable'

EXEC sp_addextendedproperty 'MS_Description', N'anio de 4 digitos; 2010,2011,2012, etc', 'schema', 'dbo', 'table', 'tmpSaldo_Inicial', 'column', 'Ejercicio'

EXEC sp_addextendedproperty 'MS_Description', N'numero de mes 1=Enero', 'schema', 'dbo', 'table', 'tmpSaldo_Inicial', 'column', 'Periodo'

EXEC sp_addextendedproperty 'MS_Description', N'Monto deudor del saldo inicial', 'schema', 'dbo', 'table', 'tmpSaldo_Inicial', 'column', 'Saldo_inicial_debe'

EXEC sp_addextendedproperty 'MS_Description', N'Monto acreedor del saldo inicial', 'schema', 'dbo', 'table', 'tmpSaldo_Inicial', 'column', 'Saldo_inicial_haber'

END

PRINT 'Termina el proceso de creación de tablas contables.'