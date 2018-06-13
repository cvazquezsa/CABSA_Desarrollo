SET DATEFIRST 7
SET ANSI_NULLS OFF
SET ANSI_WARNINGS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET QUOTED_IDENTIFIER OFF
SET NOCOUNT ON
SET IMPLICIT_TRANSACTIONS OFF
GO

EXEC sp_configure 'show advanced options', 1
RECONFIGURE
GO
EXEC sp_configure 'xp_cmdshell', 1
GO
RECONFIGURE
GO


-------------------------------------------------------------------
---------------------- Agregar Campos -----------------------------
-------------------------------------------------------------------

/****************** I N S T I T U C I O N F I N ************************/
EXEC spALTER_TABLE 'InstitucionFin', 'InstitucionFin',      'varchar(50) NULL'
EXEC spALTER_TABLE 'InstitucionFin', 'InstitucionFin2',     'varchar(50) NULL'
EXEC spALTER_TABLE 'InstitucionFin', 'OtroConcepto',        'bit NULL DEFAULT 0 WITH VALUES'
GO

/****************** P R O V ************************/
EXEC spALTER_TABLE 'Prov', 'Institucion',       'varchar(50) NULL'
EXEC spALTER_TABLE 'Prov', 'NombreInstitucion', 'varchar(100) NULL'
GO

/******************D I N E R O ************************/
EXEC spALTER_TABLE 'Dinero', 'Dispersion', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Dinero', 'EnvioComprobante', 'bit NULL DEFAULT 0 WITH VALUES'
GO

/******************A N E X O M O V************************/
ALTER TABLE AnexoMov ALTER COLUMN Tipo varchar(15) null
GO

-------------------------------------------------------------------
---------------------- ConfigDispersion --------------------
-------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE ID = Object_ID('dbo.ConfigDispersion') AND Type = 'U') --DROP TABLE ConfigDispersion
BEGIN
CREATE TABLE ConfigDispersion ( ID           int identity(1,1),
                                RutaDestino  varchar(255) NULL,
                                Asunto       varchar(255) NULL,
								Mensaje      varchar(255) NULL,
								NombreServer varchar(255) NULL,
								Puerto       varchar(10)  NULL,
								eMail        varchar(255) NULL,
								Contrasena   varchar(50)  NULL,
								Contrasena1  varchar(50)  NULL,
								ConexionSSL  bit          NULL DEFAULT 0) 
END
GO
EXEC spALTER_TABLE 'ConfigDispersion', 'Perfil', 'varchar(100) null'
EXEC spALTER_TABLE 'ConfigDispersion', 'UsuarioSQL', 'varchar(100) null'
EXEC spALTER_TABLE 'ConfigDispersion', 'ContrasenaSQL', 'varchar(100) null'
EXEC spALTER_TABLE 'ConfigDispersion', 'Cuenta', 'varchar(100) null'
GO


-------------------------------------------------------------------
---------------------- DispersionBanco --------------------
-------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE ID = Object_ID('dbo.DispersionBanco') AND Type = 'U') --DROP TABLE DispersionBanco
BEGIN
CREATE TABLE DispersionBanco (
                               Estacion      int          NULL,
                               TipoPago      varchar(50)  NULL,
							   CuentaOrigen  varchar(50)  NULL,
							   CuentaDestino varchar(50)  NULL,
							   Beneficiario  varchar(255) NULL,
							   Importe       float        NULL,
							   RefNum        varchar(10)  NULL,
							   RefSAlfn      varchar(50)  NULL
							  )
END
GO
EXEC spALTER_TABLE 'DispersionBanco', 'BancoSucursal',   'varchar(100) null'
EXEC spALTER_TABLE 'DispersionBanco', 'Moneda',          'varchar(20) null'
EXEC spALTER_TABLE 'DispersionBanco', 'TipoPersona',     'varchar(20) null'
EXEC spALTER_TABLE 'DispersionBanco', 'RFC',             'varchar(20) null'
EXEC spALTER_TABLE 'DispersionBanco', 'Impuestos',       'money       null'
EXEC spALTER_TABLE 'DispersionBanco', 'DescripcionTerc', 'varchar(100) null'
EXEC spALTER_TABLE 'DispersionBanco', 'ImporteTerc',     'varchar(14) null'
EXEC spALTER_TABLE 'DispersionBanco', 'IDMov',           'int null'
GO
ALTER TABLE DispersionBanco ALTER COLUMN Beneficiario varchar(255) NULL
GO

-------------------------------------------------------------------
---------------------- GeneraTxt --------------------
-------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE ID = Object_ID('dbo.GeneraTxt') AND Type = 'U') --DROP TABLE GeneraTxt
BEGIN
  CREATE TABLE GeneraTxt (Campo1 text NULL, estacion int NUll)
END
GO

-------------------------------------------------------------------
---------------------- RegistroUsuarioOrigen --------------------
-------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE ID = Object_ID('dbo.RegistroUsuarioOrigen') AND Type = 'U') --DROP TABLE RegistroUsuarioOrigen
BEGIN
  CREATE TABLE RegistroUsuarioOrigen ( Modulo   varchar(5) NULL,
                                   ModuloID int        NULL,
								   Usuario  varchar(20) NULL
                                  )
END
GO


-------------------------------------------------------------------
---------------------- ExploraDispersion --------------------
-------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE ID = Object_ID('dbo.ExploraDispersion') AND Type = 'U') --DROP TABLE ExploraDispersion
BEGIN
CREATE TABLE ExploraDispersion ( ID                 int identity(1,1),
                                 Estacion           int          NULL,
								 Seleccionar        bit          NULL DEFAULT 0,   
								 Dispersion         bit          NULL DEFAULT 0,       
								 IDMov              int          NULL,
								 Empresa            varchar(5)   NULL,
								 NombreE            varchar(100) NULL,  
								 RFCEmpresa         varchar(15)  NULL,           
								 Movimiento         varchar(50)  NULL,
								 FechaEmision       datetime     NULL,
								 Concepto           varchar(50)  NULL,
								 Moneda             varchar(10)  NULL,
								 TipoCambio         float        NULL,
								 Referencia         varchar(50)  NULL,
								 BeneficiarioNombre varchar(255) NULL,
                                 CtaDinero          varchar(10)  NULL,
								 Institucion        varchar(50)  NULL,
								 Importe            money        NULL,
								 Impuestos          money        NULL,
								 Monto              money        NULL,
								 FormaPago          varchar(50)  NULL,
								 OrigenMov          varchar(50)  NULL,
								 FechaRegistro      datetime     NULL,
                                 Sucursal           int          NULL,
								 UEN                int          NULL,
								 Contacto           varchar(20)  NULL,
								 NombreProv         varchar(255) NULL,
								 RFCProv            varchar(15)  NULL,
								 ContactoTipo       varchar(20)  NULL,
								 NumeroCta          varchar(20)  NULL,
								 BancoSucursal      varchar(100) NULL,
								 CuentaHabiente     varchar(255) NULL,
								 Color              varchar(50)  NULL                  
							  )
END
GO
EXEC spALTER_TABLE 'ExploraDispersion', 'Tipo', 'varchar(20) null'
EXEC spALTER_TABLE 'ExploraDispersion', 'UsuarioOrigen', 'varchar(20) null'
GO

------------------------------------------------------
----- AGREGAR SUBCLAVE EN TESORERIA -------
------------------------------------------------------
IF NOT EXISTS (SELECT * FROM MovClave WHERE Modulo = 'DIN' AND Clave = 'DIN.DISP')   
  INSERT INTO MovClave	(Modulo,  Clave,		NombreOmision,	        EstatusContabilizar,	SubClaveDe)
  VALUES				('DIN',   'DIN.DISP',	'Cheque Electronico',	'CONCLUIDO',		    'DIN.CHE')
GO  
--UPDATE MOVTIPO SET SUBCLAVE='DIN.DISP' WHERE MODULO='DIN' AND ORDEN=40

--------------------------------------------------------------------------------------------------------------------------------
---- M E N S A J E  E R R O R     I N F O     M E N S A J E  E R R O R     I N F O     M E N S A J E  E R R O R     I N F O ----
--------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS(SELECT * FROM MensajeLista WHERE Mensaje = 80042) INSERT INTO MensajeLista (Mensaje,	Descripcion,											Tipo,	IE)
																VALUES					 (80042,	'El Envío de Comprobantes se realizó con éxito !<BR>',   'INFO',	0)

IF NOT EXISTS(SELECT * FROM MensajeLista WHERE Mensaje = 50112) INSERT INTO MensajeLista (Mensaje,	Descripcion,																Tipo,	    IE)
																VALUES					 (50112,	'Hubo errores en el envío.',	'ERROR',	0)
GO


-----------------------------------------------------
----------------- F U N C I O N E S ------------------
------------------------------------------------------

/***************fnNombreDispBNMX ********************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnNombreDispBNMX') DROP FUNCTION fnNombreDispBNMX
GO
CREATE FUNCTION [dbo].[fnNombreDispBNMX]
(@Nombre varchar(255))
RETURNS varchar(500)
AS
BEGIN
		DECLARE 
		@BeneficiarioMoral varchar(500),
		@Apellido1         varchar(100),
		@Apellido2         varchar(100),
		@Nombre1           varchar(100),
		@Nombre2           varchar(100)
		
		SET @BeneficiarioMoral = ''
		
		SELECT @Apellido1=PARSENAME(REPLACE(ISNULL(@Nombre,''),' ','.'),2), 
		       @Apellido2=PARSENAME(REPLACE(ISNULL(@Nombre,''),' ','.'),1) ,
		       @Nombre1  =PARSENAME(REPLACE(ISNULL(@Nombre,''),' ','.'),3), 
		       @Nombre2  =PARSENAME(REPLACE(ISNULL(@Nombre,''),' ','.'),4) 
			   
		SELECT @BeneficiarioMoral = @Apellido1+','+@Apellido2+'/'+ISNULL(@Nombre2,'')+ISNULL(@Nombre1,'')

		RETURN @BeneficiarioMoral

END
GO
--select dbo.fnNombreDispBNMX ('WALDY DUARTE TELLEZ')

-------------------------------------------------------------------
---------------------- spInsertUsuarioOrigen --------------------
-------------------------------------------------------------------
IF EXISTS (SELECT * FROM Sysobjects WHERE ID = Object_ID('dbo.spInsertUsuarioOrigen') AND Type = 'P') DROP PROCEDURE dbo.spInsertUsuarioOrigen
GO
CREATE PROCEDURE spInsertUsuarioOrigen
@ID    int,
@Modulo varchar(5),
@OK    int OUTPUT
AS BEGIN
   DECLARE @Usuario varchar(20)

   IF @Modulo='COMS'
   SELECT @Usuario=Usuario FROM Compra WHERE ID=@ID

   IF @Modulo='GAS'
   SELECT @Usuario=Usuario FROM Gasto WHERE ID=@ID

   INSERT INTO RegistroUsuarioOrigen (Modulo,  ModuloID,  Usuario)
                               SELECT @Modulo, @ID,       @Usuario
  
   IF @@ERROR<> 0 
   SELECT @Ok = 1

END
GO

-------------------------------------------------------------------
---------------------- xpInvAfectar --------------------
-------------------------------------------------------------------
IF EXISTS (SELECT * FROM Sysobjects WHERE ID = Object_ID('dbo.xpInvAfectar') AND Type = 'P') DROP PROCEDURE dbo.xpInvAfectar
GO
CREATE PROCEDURE xpInvAfectar
@ID                		int,
@Accion			char(20),
@Base			char(20),
@Empresa	      		char(5),
@Usuario			char(10),
@Modulo	      		char(5),
@Mov	  	      		char(20),
@MovID             		varchar(20),
@MovTipo     		char(20),
@MovMoneda	      		char(10),
@MovTipoCambio	 	float,
@Estatus	 	      	char(15),
@EstatusNuevo	      	char(15),
@FechaEmision		datetime,
@FechaRegistro		datetime,
@FechaAfectacion    		datetime,
@Conexion			bit,
@SincroFinal			bit,
@Sucursal			int,
@UtilizarID			int,
@UtilizarMovTipo    		char(20),
@Ok				int		OUTPUT,
@OkRef			varchar(255)	OUTPUT
AS BEGIN
DECLARE
@Error		int,
@ErrorRef	varchar(255),
@Origen                 char(5),
@OrigenID               varchar(20),
@OrigenMov              varchar(20),
@OrigenMovID            varchar(20),
@OrigenMovTipo          varchar(20),
@OID                    int,
@OrigenTipo             varchar(10),
@IDCancelar             int,
@ModuloCancelar         varchar(5),
@IDCancelarA            int,
@ModuloCancelarA        char(5),
@SubClave               char(20) 


  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
  BEGIN
    EXEC spINFORInvAfectar  @ID, @Accion, @Base, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @Estatus, @EstatusNuevo, @FechaEmision, @FechaRegistro, @FechaAfectacion, @Conexion, @SincroFinal, @Sucursal, NULL, NULL,@Error OUTPUT, @ErrorRef OUTPUT
    IF @Error IS NOT NULL OR @Error BETWEEN 80030 AND 81000
    SELECT @Ok = @Error, @OkRef = @OkRef
  END
  
  SELECT @SubClave = ISNULL(SubClave,'') FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov AND Clave = @MovTipo
  
  IF @Ok IS NULL AND @Modulo = 'INV' AND @MovTipo = 'INV.SOL' and @SubClave='INV.ENT' AND @Accion='CANCELAR' AND @Conexion = 0
  BEGIN
     SELECT @Origen = OrigenTipo, @OrigenMov = Origen, @OrigenMovID = OrigenID FROM Inv WHERE ID = @ID
     SELECT @OrigenMovTipo = Clave, @SubClave=SubClave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @OrigenMov
     IF @Conexion = 0
     IF @Estatus IN('CONCLUIDO', 'PROCESAR', 'PENDIENTE') AND @OrigenMovTipo = 'INV.A' AND @Origen = 'INV' AND @SubClave='INV.ATMAORENT'
     SELECT @Ok = 60070
  END

  /*****CABSA******/
  IF @Modulo='COMS' AND @MovTipo='COMS.F' AND @Accion='Afectar' AND @EstatusNuevo='CONCLUIDO'
  BEGIN
    EXEC spInsertUsuarioOrigen @ID, @Modulo, @Ok OUTPUT
  END
  
RETURN
END
GO

-------------------------------------------------------------------
---------------------- xpGastoAfectar --------------------
-------------------------------------------------------------------
IF EXISTS (SELECT * FROM Sysobjects WHERE ID = Object_ID('dbo.xpGastoAfectar') AND Type = 'P') DROP PROCEDURE dbo.xpGastoAfectar
GO
CREATE PROCEDURE xpGastoAfectar
@ID               		int,
@Accion			char(20),
@Empresa          		char(5),
@Usuario			char(10),
@Modulo	      		char(5),
@Mov              		char(20),
@MovID			varchar(20),
@MovTipo	      		char(20),
@MovMoneda			char(10),
@FechaEmision		datetime,
@Estatus			char(15),
@EstatusNuevo		char(15),
@Acreedor			char(10),
@Ok				int		OUTPUT,
@OkRef			varchar(255)	OUTPUT
AS BEGIN

  /*****CABSA******/
  IF @Modulo='GAS' AND @MovTipo='GAS.G' AND @Accion='Afectar' AND @EstatusNuevo='CONCLUIDO'
  BEGIN
    EXEC spInsertUsuarioOrigen @ID, @Modulo, @Ok OUTPUT
  END

RETURN
END
GO

-------------------------------------------------------------------
---------------------- spUsuarioOrigen --------------------
-------------------------------------------------------------------
IF EXISTS (SELECT 1 from SysObjects WHERE name ='spUsuarioOrigen' AND type='P') drop procedure spUsuarioOrigen
GO
CREATE PROCEDURE spUsuarioOrigen
@Estacion int
AS BEGIN
   DECLARE @Modulo varchar(5),
           @ModuloID int,
		   @Empresa  varchar(5),
		   @ModuloO  varchar(5),
		   @ModuloIDO int,
		   @Usuario   varchar(20),
		   @ID        int

  SELECT @Modulo='DIN'
 
   DECLARE crUsuario CURSOR FAST_FORWARD FOR
     SELECT ID, IDMov, Empresa
	 FROM ExploraDispersion
	 WHERE Estacion=@Estacion 
   OPEN crUsuario
   FETCH NEXT FROM crUsuario INTO @ID, @ModuloID, @Empresa
   WHILE @@FETCH_STATUS = 0 
   BEGIN
     SELECT @ModuloO=NULL, @ModuloIDO=NULL, @Usuario=NULL
	 
	 DELETE VerMovFlujo WHERE Estacion=@Estacion

     EXEC spVerMovFlujoExplotar @Estacion, @Empresa, @Modulo, @ModuloID, 0, 'Origen'
     
	 SELECT @ModuloO=Modulo, @ModuloIDO=ModuloID FROM VerMovFlujo WHERE Estacion=@Estacion AND Nivel=(SELECT MAX(Nivel) FROM VerMovFlujo WHERE Estacion=@Estacion)

	 SELECT @Usuario=Usuario FROM RegistroUsuarioOrigen WHERE Modulo=@ModuloO AND ModuloID=@ModuloIDO

	 UPDATE ExploraDispersion SET UsuarioOrigen=@Usuario WHERE ID=@ID AND IDMov=@ModuloID AND Empresa=@Empresa

   FETCH NEXT FROM crUsuario INTO @ID, @ModuloID, @Empresa
   END
   CLOSE crUsuario
   DEALLOCATE crUsuario 

END
GO

-------------------------------------------------------------------
---------------------- spExploraDispersion --------------------
-------------------------------------------------------------------
IF EXISTS (SELECT 1 from SysObjects WHERE name ='spExploraDispersion' AND type='P') drop procedure spExploraDispersion
GO
CREATE PROCEDURE spExploraDispersion
@Estacion int,
@Cuenta   varchar(50),
@Tipo     varchar(5),
@Valor    int
AS BEGIN
   DECLARE @sql    varchar(max),
           @sql2   varchar(max),
           @sql3   varchar(max),
           @sql4   varchar(max)
    
	DELETE ExploraDispersion WHERE Estacion=@Estacion AND CtaDinero=@Cuenta  
	
	IF @Tipo=1
	BEGIN
      SELECT @sql='INSERT INTO ExploraDispersion (Estacion,                           IDMov,                   Empresa,                  NombreE,                 RFCEmpresa,                               Movimiento,  '+                      
	              '                               FechaEmision,                       Concepto,                Moneda,                   Tipocambio,              Referencia,                               BeneficiarioNombre, '+        
                  '      				          CtaDinero,                          Institucion,             Importe,                  Impuestos,               Monto,                                    Formapago, '+
				  '				                  OrigenMov,                          FechaRegistro,           Sucursal,                 UEN,                     Contacto,                                 NombreProv, '+
				  '				                  RFCProv,                            ContactoTipo,            NumeroCta,                BancoSucursal,           CuentaHabiente,                           Dispersion, '+        
				  '				                  Color,                              Tipo) '+
                  '                        SELECT '+ CONVERT(VARCHAR, @Estacion )+',   Dinero.ID,               Dinero.Empresa,           e.Nombre,                e.RFC,                                     (Dinero.Mov+'+CHAR(39) + ' ' + CHAR(39)+'+Dinero.MovID), '+
				  '			                    Dinero.FechaEmision,                Dinero.Concepto,         Dinero.Moneda,            Dinero.TipoCambio,       Dinero.Referencia,                         Dinero.BeneficiarioNombre, '+
				  '				                Dinero.CtaDinero,                   CtaDinero.Institucion,   Dinero.Importe,           Dinero.Impuestos,        Dinero.Importe+ISNULL(Dinero.Impuestos,0), Dinero.FormaPago, '+
				  '				                Dinero.Origen+'+CHAR(39) + ' ' + CHAR(39)+'+Dinero.OrigenID,      Dinero.FechaRegistro,     Dinero.Sucursal,         Dinero.UEN,    Dinero.Contacto,            p.Nombre,  '+                                
				  '				                p.RFC,                              Dinero.ContactoTipo,     CtaDinero.NumeroCta,      CtaDinero.BancoSucursal, CtaDinero.CuentaHabiente,                  ISNULL(Dispersion,0), '+         
				  '				                CASE WHEN ISNULL(Dispersion,0)=1 THEN '+ CHAR(39)+ 'VERDE' + CHAR(39) +' ELSE '+ CHAR(39) + 'ROJO' +CHAR(39) + ' END Color,'+ char(39)+@Tipo+char(39)+
                  '                        FROM Dinero '+
                  '                        LEFT OUTER JOIN MovTipo ON '+CHAR(39)+ 'DIN' + CHAR(39) + '=MovTipo.Modulo AND Dinero.Mov=MovTipo.Mov '+
                  '                        LEFT OUTER JOIN CtaDinero ON Dinero.CtaDinero=CtaDinero.CtaDinero '+
                  '                        JOIN MovTipo mt ON Dinero.Mov = mt.Mov AND mt.Modulo ='+CHAR(39)+ 'DIN'+CHAR(39)+' AND ISNULL(mt.SubClave,'+CHAR(39)+CHAR(39)+') ='+CHAR(39)+ 'DIN.DISP' + CHAR(39) +
                  '                        JOIN ContMoneda ON Dinero.Empresa=ContMoneda.Empresa '+
				  '			             JOIN Empresa e on Dinero.Empresa=e.Empresa '+
				  '			             JOIN Prov p on Dinero.Contacto=p.Proveedor  '

    --SELECT @SQL
	
	IF @Valor=1
    SELECT @SQL2='WHERE Dinero.Estatus='+CHAR(39)+'CONCLUIDO'+CHAR(39)+' AND Dinero.CtaDinero='+CHAR(39)+@Cuenta+CHAR(39) + 
	             ' AND CtaDinero.NumeroCta IS NOT NULL AND p.ProvCuenta IS NOT NULL AND Dinero.Contacto IS NOT NULL AND Dinero.Referencia IS NOT NULL ' +
	             ' AND ISNULL(Dinero.Dispersion,0)=1 '

	IF @Valor=2
    SELECT @SQL2='WHERE Dinero.Estatus='+CHAR(39)+'CONCLUIDO'+CHAR(39)+' AND Dinero.CtaDinero='+CHAR(39)+@Cuenta+CHAR(39) + 
	             ' AND CtaDinero.NumeroCta IS NOT NULL AND p.ProvCuenta IS NOT NULL AND Dinero.Contacto IS NOT NULL AND Dinero.Referencia IS NOT NULL ' +
	             ' AND ISNULL(Dinero.Dispersion,0)=0 '

	IF @Valor=3
    SELECT @SQL2='WHERE Dinero.Estatus='+CHAR(39)+'CONCLUIDO'+CHAR(39)+' AND Dinero.CtaDinero='+CHAR(39)+@Cuenta+CHAR(39) +
	             ' AND CtaDinero.NumeroCta IS NOT NULL AND p.ProvCuenta IS NOT NULL AND Dinero.Contacto IS NOT NULL AND Dinero.Referencia IS NOT NULL ' 
	
    SELECT @sql3=@sql+@sql2
	--SELECT @sql3
	EXEC(@sql3)

	END

	IF @Tipo=2
	BEGIN
	  	SELECT @sql='INSERT INTO ExploraDispersion (Estacion,                       IDMov,                   Empresa,                  NombreE,                 RFCEmpresa,                               Movimiento,  '+                      
	            '                               FechaEmision,                       Concepto,                Moneda,                   Tipocambio,              Referencia,                               BeneficiarioNombre, '+        
				'      				            CtaDinero,                          Institucion,             Importe,                  Impuestos,               Monto,                                    Formapago, '+
				'				                OrigenMov,                          FechaRegistro,           Sucursal,                 UEN,                     Contacto,                                 NombreProv, '+
				'				                RFCProv,                            ContactoTipo,            NumeroCta,                BancoSucursal,           CuentaHabiente,                           Dispersion, '+        
				'				                Color,                              Tipo ) '+
                '                        SELECT '+ CONVERT(VARCHAR, @Estacion )+',   Dinero.ID,               Dinero.Empresa,           e.Nombre,                e.RFC,                                     (Dinero.Mov+'+CHAR(39) + ' ' + CHAR(39)+'+Dinero.MovID), '+
				'			                    Dinero.FechaEmision,                Dinero.Concepto,         Dinero.Moneda,            Dinero.TipoCambio,       Dinero.Referencia,                         Dinero.BeneficiarioNombre, '+
				'				                Dinero.CtaDinero,                   CtaDinero.Institucion,   Dinero.Importe,           Dinero.Impuestos,        Dinero.Importe+ISNULL(Dinero.Impuestos,0), Dinero.FormaPago, '+
				'				                Dinero.Origen+'+CHAR(39) + ' ' + CHAR(39)+'+Dinero.OrigenID,      Dinero.FechaRegistro,     Dinero.Sucursal,         Dinero.UEN,    Dinero.Contacto,            p.Nombre,  '+                                
				'				                p.RFC,                              Dinero.ContactoTipo,     CtaDinero.NumeroCta,      CtaDinero.BancoSucursal, CtaDinero.CuentaHabiente,                  ISNULL(EnvioComprobante,0), '+         
				'				                CASE WHEN ISNULL(Dispersion,0)=1 THEN '+ CHAR(39)+ 'VERDE' + CHAR(39) +' ELSE '+ CHAR(39) + 'ROJO' +CHAR(39) + ' END Color,'+ char(39)+@Tipo+char(39)+
                '                        FROM Dinero '+
                '                        LEFT OUTER JOIN MovTipo ON '+CHAR(39)+ 'DIN' + CHAR(39) + '=MovTipo.Modulo AND Dinero.Mov=MovTipo.Mov '+
                '                        LEFT OUTER JOIN CtaDinero ON Dinero.CtaDinero=CtaDinero.CtaDinero '+
                '                        JOIN MovTipo mt ON Dinero.Mov = mt.Mov AND mt.Modulo ='+CHAR(39)+ 'DIN'+CHAR(39)+' AND ISNULL(mt.SubClave,'+CHAR(39)+CHAR(39)+') ='+CHAR(39)+ 'DIN.DISP' + CHAR(39) +
                '                        JOIN ContMoneda ON Dinero.Empresa=ContMoneda.Empresa '+
				'			             JOIN Empresa e on Dinero.Empresa=e.Empresa '+
				'			             JOIN Prov p on Dinero.Contacto=p.Proveedor AND Dinero.ContactoTipo='+CHAR(39)+'Proveedor'+CHAR(39)+
				'                        JOIN AnexoMov a on Dinero.ID=a.ID AND a.Rama='+CHAR(39)+'DIN'+CHAR(39)+' AND a.Tipo='+CHAR(39)+'Comprobante'+CHAR(39) +' '

        --SELECT @SQL
	
	    IF @Valor=1
        SELECT @SQL2='WHERE Dinero.Estatus='+CHAR(39)+'CONCLUIDO'+CHAR(39)+' AND Dinero.CtaDinero='+CHAR(39)+@Cuenta+CHAR(39) + 
		            ' AND CtaDinero.NumeroCta IS NOT NULL AND p.ProvCuenta IS NOT NULL AND Dinero.Contacto IS NOT NULL AND Dinero.Referencia IS NOT NULL ' +
					' AND ISNULL(Dinero.Dispersion,0)=1 AND ISNULL(Dinero.EnvioComprobante,0)=1 '

	    IF @Valor=2
        SELECT @SQL2='WHERE Dinero.Estatus='+CHAR(39)+'CONCLUIDO'+CHAR(39)+' AND Dinero.CtaDinero='+CHAR(39)+@Cuenta+CHAR(39) + 
		' AND CtaDinero.NumeroCta IS NOT NULL AND p.ProvCuenta IS NOT NULL AND Dinero.Contacto IS NOT NULL AND Dinero.Referencia IS NOT NULL '+
		' AND ISNULL(Dinero.Dispersion,0)=1 AND ISNULL(Dinero.EnvioComprobante,0)=0 '

	    IF @Valor=3
        SELECT @SQL2='WHERE Dinero.Estatus='+CHAR(39)+'CONCLUIDO'+CHAR(39)+' AND ISNULL(Dinero.Dispersion,0)=1 AND Dinero.CtaDinero='+CHAR(39)+@Cuenta+CHAR(39) +
		             ' AND CtaDinero.NumeroCta IS NOT NULL AND p.ProvCuenta IS NOT NULL AND Dinero.Contacto IS NOT NULL AND Dinero.Referencia IS NOT NULL '
	
        SELECT @sql3=@sql+@sql2
	    --SELECT @SQL3
	    EXEC(@sql3)
	
	END

	EXEC spUsuarioOrigen @Estacion

	SELECT * FROM ExploraDispersion WHERE Estacion=@Estacion

 END
 GO
 EXEC spExploraDispersion 18, 'BNMX8511', '1', 3
--EXEC spExploraDispersion 1, 'BNMX8511', 2, '2'
--EXEC spExploraDispersion 1, 'BNMX8511', 2, '3'
--EXEC spExploraDispersion 1, 'BNMX8511', 1, 1

-------------------------------------------------------------------
---------------- S P A C T U A L I Z A C H E C K ------------------
-------------------------------------------------------------------
IF EXISTS (SELECT * FROM Sysobjects WHERE ID = Object_ID('dbo.spActualizaCheck') AND Type = 'P') DROP PROCEDURE dbo.spActualizaCheck
GO
CREATE PROCEDURE spActualizaCheck
@EstacionTrabajo		int,			
@Operacion				int
AS BEGIN  

  IF @Operacion = 1   
  UPDATE ExploraDispersion SET Seleccionar= 1 WHERE Estacion = @EstacionTrabajo
  
  IF @Operacion = 10  
  UPDATE ExploraDispersion SET Seleccionar= 0 WHERE Estacion = @EstacionTrabajo

  /*****ACTUALIZA BIT DISPERSION EN TESORERIA*******/
  IF @Operacion = 2
  UPDATE d SET d.Dispersion=0
  FROM Dinero d
  JOIN ExploraDispersion e on d.ID=e.IDMov
  WHERE Estacion = @EstacionTrabajo 
  AND ISNULL(e.Seleccionar,0)=1

END
GO

-------------------------------------------------------------------
---------------- S P V A L I D A A N E X O ------------------
-------------------------------------------------------------------
IF EXISTS (SELECT * FROM Sysobjects WHERE ID = Object_ID('dbo.spValidaAnexo') AND Type = 'P') DROP PROCEDURE dbo.spValidaAnexo
GO
CREATE PROCEDURE spValidaAnexo
@ID   int,
@Tipo varchar(15),
@Rama varchar(5)
AS BEGIN
   DECLARE @Valor int

   SELECT @valor=NULL

   IF @Tipo='Comprobante' AND @Rama='DIN'
   BEGIN
   IF EXISTS (SELECT * FROM AnexoMov WHERE ID=@ID AND Rama=@Rama AND Tipo=@Tipo)
      SELECT @Valor=1
   ELSE
      SELECT @Valor=0
   END
   ELSE
   SELECT @Valor=0

   SELECT @Valor as valor

RETURN
END
GO
--EXEC spValidaAnexo 2077, 'Comentario', 'DIN'
--select * from anexomov where id=2077

-------------------------------------------------------------------
---------------------- spGeneraRPTDispersion --------------------
-------------------------------------------------------------------
IF EXISTS (SELECT 1 from SysObjects WHERE name ='spGeneraRPTDispersion' AND type='P') drop procedure spGeneraRPTDispersion
GO
CREATE PROCEDURE spGeneraRPTDispersion
@Estacion int
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE @InstitucionO    varchar(50),
          @CtaOrigen       varchar(50),
		  @TipoPago        varchar(50),
		  @InstitucionFin  varchar(50),
		  @InstitucionFin2 varchar(50),
		  @Fecha           varchar(10),
		  @dia             char(2),
		  @mes             char(2),
		  @año             char(2),
		  @FechaDispersion varchar(8),
		  @IDDin           int,
		  @Empresa         varchar(5)

  SELECT @Fecha=getdate()
  SELECT @dia=convert(char(2),day(getdate())), @mes= REPLICATE('0', (2 - LEN(month(getdate()))))+convert(char(2),month(getdate())), @año=right((year(getdate())),2)
  SELECT @FechaDispersion=@dia+@mes+@año
  --select @dia, @mes, @año, @fechadispersion
  
  DELETE FROM DispersionBanco WHERE Estacion=@Estacion
  
    INSERT INTO DispersionBanco (Estacion,              CuentaOrigen, CuentaDestino, Beneficiario,         Importe, RefNum, 
							     RefSAlfn,              TipoPago,
								 BancoSucursal,         Moneda,       TipoPersona,   
								 RFC,                   Impuestos,    DescripcionTerc, ImporteTerc,        IDMov)
                          SELECT @Estacion as Estacion, c.NumeroCta,  p.ProvCuenta,  e.BeneficiarioNombre, e.Importe, @FechaDispersion,
						         e.Referencia,          CASE WHEN e.Institucion=p.Institucion THEN i.InstitucionFin ELSE i.InstitucionFin2 END TipoPago,
								 e.BancoSucursal,       e.Moneda, 	  CASE WHEN p.FiscalRegimen in ('612','621') THEN 'Fisica' ELSE 'Moral' END,
								 e.RFCProv,             e.Impuestos,  ISNULL(e.Empresa,'')+' '+ISNULL(p.NombreCorto,''), Monto, e.IDMov
                          FROM ExploraDispersion e
                          JOIN Prov p on e.Contacto=p.Proveedor
                          JOIN InstitucionFin i on e.Institucion=i.Institucion
						  JOIN CtaDinero c on e.CtaDinero=c.CtaDinero
                          WHERE Estacion=@Estacion
                          AND ISNULL(Seleccionar,0)=1

  SELECT * FROM DispersionBanco WHERE Estacion=@Estacion
  
END
GO
--exec spGeneraRPTDispersion 1

-------------------------------------------------------------------
---------------------- spRutaNombre --------------------
-------------------------------------------------------------------
IF EXISTS (SELECT 1 from SysObjects WHERE name ='spRutaNombre' AND type='P') drop procedure spRutaNombre
GO
CREATE PROCEDURE spRutaNombre
AS BEGIN
  DECLARE @Fecha           varchar(10),
		  @dia             char(2),
		  @mes             char(2),
		  @RutaSalida      varchar(255),
		  @NombreArchivo   varchar(100),
		  @Extension       varchar(10),
		  @Archivo         varchar(255),
		  @RutaNombre      varchar(255)


  SELECT @Fecha=getdate()
  SELECT @dia=convert(char(2), day(getdate())), @mes= replicate('0', (2 - LEN(month(getdate()))))+convert(char(2),month(getdate()))
  SELECT @RutaSalida=RutaDestino FROM ConfigDispersion 
  SELECT @NombreArchivo='PAGOS'+@Dia+UPPER(dbo.fnMesNumeroNombre(@Mes))
  SELECT @Extension='.txt'
  SELECT @Archivo=@NombreArchivo+@Extension 
  

  SELECT @RutaNombre=@RutaSalida+'\'+@Archivo

  SELECT @RutaNombre as 'RutaNombre'

END
GO


-------------------------------------------------------------------
---------------------- spGeneraDispersion --------------------
-------------------------------------------------------------------
IF EXISTS (SELECT 1 from SysObjects WHERE name ='spGeneraDispersion' AND type='P') drop procedure spGeneraDispersion
GO
CREATE PROCEDURE spGeneraDispersion
@Estacion int--,
--@Opcion   int
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE @InstitucionO    varchar(50),
          @CtaOrigen       varchar(50),
		  @TipoPago        varchar(50),
		  @InstitucionFin  varchar(50),
		  @InstitucionFin2 varchar(50),
		  @Fecha           varchar(10),
		  @dia             char(2),
		  @mes             char(2),
		  @año             char(2),
		  @FechaDispersion varchar(8),
		  @IDDin           int,
		  @Empresa         varchar(5),
		  @RutaSalida      varchar(800),
		  @TipoCtaO        varchar(2),
		  @TipoCtaD        varchar(2),
		  @Referencia      varchar(7),
		  @Plazo           varchar(2),
		  @hora            varchar(2),
		  @min             varchar(2),
		  @HoraAplica      varchar(4),
		  @Concepto        varchar(7),
		  @Moneda          varchar(3),
		  @sql_user_name   varchar(100),
		  @sql_password    varchar(100),
		  @Extension       varchar(20),
		  @Archivo         varchar(100),
		  @Archivo2        varchar(100),
		  @NombreArchivo   varchar(100),
		  @NombreArchivo2  varchar(100),
		  @SQLGeneratTxt   varchar(max),
		  @Ok              int

  SELECT @Fecha=getdate()
  SELECT @dia=convert(char(2), day(getdate())), @mes= replicate('0', (2 - LEN(month(getdate()))))+convert(char(2),month(getdate())), @año=right((year(getdate())),2),
         @hora=datepart(hh, getdate()), @min=datepart(n, getdate())
  SELECT @HoraAplica=@hora+@min
  --select @HoraAplica 
  SELECT @FechaDispersion=@dia+@mes+@año
  --select @dia, @mes, @año, @fechadispersion
  SELECT @RutaSalida=RutaDestino, @sql_user_name=UsuarioSQL, @sql_password=ISNULL(ContrasenaSQL,'') FROM ConfigDispersion 
  SELECT @TipoCtaO='01', @TipoCtaD='40', @Referencia='0000000', @Plazo='00', @Concepto=SPACE(34), @Moneda='000'
  SELECT @NombreArchivo='PAGOS'+@Dia+UPPER(dbo.fnMesNumeroNombre(@Mes))
  SELECT @Extension='.txt'
  SELECT @Archivo=@NombreArchivo+@Extension 
  
  DELETE FROM DispersionBanco WHERE Estacion=@Estacion
  DELETE FROM GeneraTxt       WHERE Estacion=@Estacion

  CREATE TABLE #ForOutPut2 (Salida	varchar(max) NULL)  
  CREATE TABLE #Banamex (Estacion             int            NULL,
                         TipoPago             varchar(30)    NULL,
                         TipoTransac          varchar(2)     NULL,
						 TipoCtaO             varchar(2)     NULL,
						 SucCtaO              varchar(4)     NULL,
						 CtaOrigen            varchar(20)    NULL,
						 Importe              varchar(14)    NULL,
						 Moneda               varchar(3)     NULL,
						 TipoCtaD             varchar(2)     NULL,
						 CtaDestino           varchar(20)    NULL,
						 Descripcion          varchar(40)    NULL,
						 Referencia           varchar(7)     NULL,
						 Beneficiario         varchar(55)    NULL,
						 Plazo                varchar(2)     NULL,
						 RFC                  varchar(14)    NULL,
						 IVA                  varchar(12)    NULL,
						 Banco                varchar(4)     NULL,
						 FechaAplica          varchar(6)     NULL,
						 HoraAplica           varchar(4)     NULL,
						 DescripcionTerc      varchar(24)    NULL,
						 SucCtaD              varchar(4)     NULL,
						 ReferenciaTerc       varchar(10)    NULL,
						 ImporteTerc          varchar(14)    NULL )   

 
    INSERT INTO DispersionBanco (Estacion,              CuentaOrigen, CuentaDestino, Beneficiario,         Importe, RefNum, 
							     RefSAlfn,              TipoPago,
								 BancoSucursal,         Moneda,       TipoPersona,   
								 RFC,                   Impuestos,    DescripcionTerc, ImporteTerc,        IDMov)
                          SELECT @Estacion as Estacion, c.NumeroCta,  p.ProvCuenta,  e.BeneficiarioNombre, e.Importe, @FechaDispersion,
						         e.Referencia,          CASE WHEN e.Institucion=p.Institucion THEN i.InstitucionFin ELSE i.InstitucionFin2 END TipoPago,
								 e.BancoSucursal,       e.Moneda, 	  CASE WHEN p.FiscalRegimen in ('612','621') THEN 'Fisica' ELSE 'Moral' END,
								 e.RFCProv,             e.Impuestos,  ISNULL(e.Empresa,'')+' '+ISNULL(p.NombreCorto,''), Monto, e.IDMov
                          FROM ExploraDispersion e
                          JOIN Prov p on e.Contacto=p.Proveedor
                          JOIN InstitucionFin i on e.Institucion=i.Institucion
						  JOIN CtaDinero c on e.CtaDinero=c.CtaDinero
                          WHERE Estacion=@Estacion
                          AND ISNULL(Seleccionar,0)=1						  

     --select * from dispersionbanco where estacion=@estacion

      INSERT INTO #Banamex (Estacion,   
	                        TipoPago,   
							TipoTransac, 
	                        TipoCtaO,   
							SucCtaO, 
							CtaOrigen,  
							Importe,    
							Moneda, 
							TipoCtaD,   
							CtaDestino, 
							Descripcion,
	                        Referencia, 
							Beneficiario, 
							Plazo, 
							RFC, 
							IVA, 
							Banco, 
							FechaAplica, 
							HoraAplica, 
							DescripcionTerc, 
							SucCtaD,
							ImporteTerc,
							ReferenciaTerc )
                     SELECT Estacion,   
					        TipoPago, 
							CASE WHEN TipoPago='Interbancario' THEN '09' ELSE '03' END,
	                        @TipoCtaO,  
							(REPLICATE('0', (4 - LEN(CONVERT(varchar(4),ISNULL(d.BancoSucursal,''))))) + CONVERT(varchar(4),ISNULL(d.BancoSucursal,''))),
			                (REPLICATE('0', (20 - LEN(CONVERT(varchar(20),ISNULL(d.CuentaOrigen,''))))) + CONVERT(varchar(20),ISNULL(d.CuentaOrigen,''))),
                            REPLICATE('0', (14 - LEN(REPLACE(REPLACE(FORMAT(ISNULL(ABS(d.Importe),0),'N2'),',',''),'.',''))))+(REPLACE(REPLACE(FORMAT(ISNULL(ABS(d.Importe),0),'N2'),',',''),'.','')),
			                CASE WHEN d.Moneda='Pesos' THEN '001' WHEN d.Moneda='Dolares' THEN '005' END,
			                @TipoCtaD,
                            (REPLICATE('0', (20 - LEN(CONVERT(varchar(20),ISNULL(d.CuentaDestino,''))))) + CONVERT(varchar(20),ISNULL(d.CuentaDestino,''))),
							(ISNULL(d.RefSAlfn, SPACE(40)) + SPACE(40  - LEN(ISNULL(d.RefSAlfn, SPACE(40))))),
			                @Referencia,
			                (ISNULL( CASE WHEN TipoPersona='Moral' THEN d.Beneficiario ELSE dbo.fnNombreDispBNMX(d.Beneficiario) END, SPACE(55)) + SPACE(55  - LEN(ISNULL( CASE WHEN TipoPersona='Moral' THEN d.Beneficiario ELSE dbo.fnNombreDispBNMX(d.Beneficiario) END, SPACE(55))))),
			                @Plazo,
			                (REPLICATE('0', (14 - LEN(CONVERT(varchar(14),ISNULL(d.RFC,''))))) + CONVERT(varchar(14),ISNULL(d.RFC,''))),
			                REPLICATE('0', (12 - LEN(REPLACE(REPLACE(FORMAT(ISNULL(ABS(d.Impuestos),0),'N2'),',',''),'.',''))))+(REPLACE(REPLACE(FORMAT(ISNULL(ABS(d.Impuestos),0),'N2'),',',''),'.','')),
			                (REPLICATE('0', (4 - LEN(CONVERT(varchar(4),ISNULL(LEFT(CuentaDestino,3),''))))) + CONVERT(varchar(4),ISNULL(LEFT(CuentaDestino,3),''))),
			                (REPLICATE('0', (6 - LEN(CONVERT(varchar(6),ISNULL(d.RefNum,''))))) + CONVERT(varchar(6),ISNULL(d.RefNum,''))),
			                @HoraAplica,
			                (ISNULL(d.DescripcionTerc, SPACE(24)) + SPACE(24  - LEN(ISNULL(d.DescripcionTerc, SPACE(24))))),
							(REPLICATE('0', (4 - LEN(CONVERT(varchar(4),ISNULL(SUBSTRING(CuentaDestino,4,6),''))))) + CONVERT(varchar(4),ISNULL(SUBSTRING(CuentaDestino,4,6),''))),
                            REPLICATE('0', (14 - LEN(REPLACE(REPLACE(FORMAT(ISNULL(ABS(d.ImporteTerc),0),'N2'),',',''),'.',''))))+(REPLACE(REPLACE(FORMAT(ISNULL(ABS(d.ImporteTerc),0),'N2'),',',''),'.','')),
							REPLICATE('0', (10 - LEN(REPLACE(REPLACE(FORMAT(ISNULL(ABS(d.ImporteTerc),0),'N2'),',',''),'.',''))))+(REPLACE(REPLACE(FORMAT(ISNULL(ABS(d.ImporteTerc),0),'N2'),',',''),'.',''))
                     FROM DispersionBanco d
                     WHERE Estacion=@Estacion
					 
					 --select * from #Banamex

      INSERT INTO GeneraTXT (Campo1,   
	                         Estacion) 
                      SELECT TipoTransac +
	                         TipoCtaO +
			                 SucCtaO +
			                 CtaOrigen +
			                 Importe +
			                 Moneda +
			                 TipoCtaD +
			                 CtaDestino +
			                 (ISNULL(Descripcion, SPACE(40)) + SPACE(40  - LEN(ISNULL(Descripcion, SPACE(40))))) +
			                 Referencia +
			                 (ISNULL(Beneficiario, SPACE(55)) + SPACE(55  - LEN(ISNULL(Beneficiario, SPACE(55))))) +
			                 Plazo +
			                 RFC +
			                 IVA +
			                 Banco +
			                 FechaAplica +
			                 HoraAplica,			 
			                 Estacion
                      FROM #Banamex
                      WHERE TipoPago='Interbancario'
                      AND Estacion=@Estacion
					  UNION ALL
                      SELECT TipoTransac +
	                         TipoCtaO +
			                 SucCtaO +
			                 CtaOrigen +
                             @TipoCtaO +
							 SucCtaD +
			                 CtaDestino +
			                 ImporteTerc +
			                 Moneda +
			                 (ISNULL(DescripcionTerc, SPACE(24)) + SPACE(24  - LEN(ISNULL(DescripcionTerc, SPACE(24))))) +
							 (ISNULL(@Concepto, SPACE(34)) + SPACE(34  - LEN(ISNULL(@Concepto, SPACE(34))))) +
							 ReferenciaTerc +
							 @Moneda +
			                 FechaAplica +
			                 HoraAplica,			 
			                 Estacion
                      FROM #Banamex
                      WHERE TipoPago <> 'Interbancario'
                      AND Estacion=@Estacion	 

					  --SELECT Campo1 FROM GeneraTXT WHERE Estacion=@Estacion

	    BEGIN TRY
          SELECT @SQLGeneratTxt = 'EXEC MASTER..xp_Cmdshell ''bcp "'    +
                                  'SELECT Campo1'                       + 
                                  ' FROM '                             +   DB_NAME() + '..GeneraTXT WHERE Estacion = ' + convert(varchar(100), @Estacion) +
                                  ' " queryout "'+@RutaSalida+'\'+@Archivo +'" -c -T -S"' + @@SERVERNAME + '" -U"'+@sql_user_name+ '" -P"'+ @sql_password+'"'+''''	
		  --SELECT @SQLGeneratTxt		 	                                                                                                                                  
          INSERT INTO #ForOutPut2
          EXEC(@SQLGeneratTxt) 
		  --SELECT * FROM #ForOutPut2     
       END TRY       
        BEGIN CATCH        
           SELECT @Ok = ERROR_NUMBER()         
           IF @OK IS NOT NULL
           SELECT @OK=1
         END CATCH           
           IF @OK IS NULL

		   UPDATE d SET Dispersion=1
		   FROM Dinero d
		   JOIN DispersionBanco db on d.ID=db.IDMov
		   WHERE db.Estacion=@Estacion

           SELECT 'Archivo de Dispersión Generado' 

END
GO
--exec spGeneraDispersion 1
--select * from dinero where dispersion=1
--update dinero set Dispersion=0

---------------------------------------------------------------------------
--------------- S P V A L I D A C O R R E O  -----------------------------
---------------------------------------------------------------------------
IF EXISTS (SELECT * FROM Sysobjects WHERE ID = Object_ID('dbo.spValidaCorreo') and sysstat & 0xf = 4) drop procedure dbo.spValidaCorreo
GO             
CREATE  PROCEDURE spValidaCorreo
@Estacion int
AS BEGIN
  DECLARE @Valor int

   IF (SELECT COUNT(*)
   FROM ExploraDispersion e
   JOIN Prov p on e.Contacto=p.Proveedor
   JOIN Usuario u on e.UsuarioOrigen=u.Usuario
   WHERE Estacion=@Estacion AND ISNULL(Seleccionar,0)=1
   AND (p.eMail1 IS NULL) OR (u.eMail IS NULL)) >0
   SELECT @Valor=1
   ELSE 
   SELECT @Valor=0

   SELECT @Valor 'Valor'

RETURN
END
GO

---------------------------------------------------------------------------
------------ S P E N V I O C O R R E O F O R M A T O ---------------------
---------------------------------------------------------------------------
IF EXISTS (SELECT * FROM Sysobjects WHERE ID = Object_ID('dbo.spEnvioCorreoFormato') and sysstat & 0xf = 4) drop procedure dbo.spEnvioCorreoFormato
GO             
CREATE  PROCEDURE dbo.spEnvioCorreoFormato
			@ID					int,
            @Proveedor          varchar(20),
			@NombreProv		    varchar(255),
			@Mensaje            varchar(255),
			@EstacionTrabajo	int,
			@OK					int          OUTPUT,
			@OKRef				varchar(255) OUTPUT,
		    @strPrint		    varchar(MAX) OUTPUT     
AS  
BEGIN       

  SELECT @strPrint =  '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
         <html xmlns="http://www.w3.org/1999/xhtml">  
         <head>  
            <meta http-equiv="Content-Language" content="es" />  
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />  
            <title></title>   
            <style type="text/css">  
              .style1 {  
              font-family: "Century Gothic";  
              border-left-style: none;  
              border-left-width: medium;  
              border-right-style: none;  
              border-right-width: medium;  
              border-top-style: none;  
              border-top-width: medium;  
              background-color: #003082;  }  
              .style2 {  
              margin-left: 20px;          }  
              .style3 {  
              background-color: #E9E9E9;  
              border-left-style: none;  
              border-left-width: medium;  
              border-right-style: none;  
              border-right-width: medium; }  
              .style4 {  
              font-family: "Century Gothic";  
              color: #003082;   
              font-family: "Century Gothic";}  
              .style5 {  
              color: #ffffff;  
              margin-left: 20px; }  
              .style6 {  
              border-left: medium none #E9E9E9;  
              border-right: medium none #E9E9E9;  
              border-bottom: medium none #E9E9E9;  
              background-color: #E9E9E9;  
              text-align: center;  
              font-family: "Century Gothic";  
              color: #003082;  
              font-size: 10pt;  
              border-top-style: solid;  
              border-top-color: #E9E9E9; }  
              .style7 {  
              border-width: 0px; }  
              .style10 {  
              margin-left: 20px;  
              color: #0030822;  
              font-family: "Century Gothic";  
              font-size: small; }  
              .style11 {  
              margin-left: 20px;  
              color: #003082;  
              font-family: "Century Gothic";  
              font-size: x-small; }  
              .style12 {  
              color: #808080; }  
              .style13 {  
              margin-left: 20px;  
              color: #808080;  
              font-family: "Century Gothic";  
              font-size: x-small; }  
            </style>  
         </head>  
		  <body>  
            <table style="width: 600px; height: 190px" class="style7">  
               <tr>  
                  <td style="width: 700px; height: 39px" class="style1">                    
                  <p class="style5"><strong> ' + UPPER(ISNULL('COMPROBANTE DE PAGO','')) + ' </strong></p></td>  
               </tr>          
               <tr>  
                 <td style="width: 700px; height: 109px;" class="style3">  
                   <p class="style2">&nbsp;</p>  
                   <p class="style11"><strong>' + 'Proveedor: '              + ' <span class="style12">' + @Proveedor+' - '+ @NombreProv  + '</span></strong></p>
				   <p class="style10">&nbsp;</p>
                   <font SIZE="2">  
                   </font>  
                 </td>  
               </tr> ' + '	
			   <tr>  
                 <td style="width: 700px" class="style6">  
				   <p class="style10">&nbsp;</p>
                   <p class="style11"><strong>'+ ISNULL(@Mensaje,'') +'<br />  
                   </p>                   <font SIZE="2">  </td>  
               </tr>  
            </table>  
         </body>  
         </html>'	 

RETURN  
END   
GO

-------------------------------------------------------------------
---------------------- spEnvioFormatoComprobante --------------------
-------------------------------------------------------------------
IF EXISTS (SELECT 1 from SysObjects WHERE name ='spEnvioFormatoComprobante' AND type='P') drop procedure spEnvioFormatoComprobante
GO
CREATE PROCEDURE spEnvioFormatoComprobante
@Estacion int,
@Perfil   varchar(100),
@eMail    varchar(255),
@Asunto   varchar(255),
@Mensaje  varchar(255),
@OK       int OUTPUT,
@OKRef    varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  --SET NOCOUNT on
  DECLARE @Proveedor      varchar(20),
		  @ID             int,
		  @recipients     varchar(max),
		  @NombreProv     varchar(255),
		  @eMailProv      varchar(255),	  
		  @Anexos         varchar(max),
		  @strPrint       varchar(max),
		  @Tipo           varchar(100),
		  @Rama           varchar(50),
		  @NombreUsr      varchar(255),
		  @eMailUsr       varchar(255)


     SELECT @Tipo='Comprobante', @Rama='DIN'

     DECLARE crEnvio CURSOR FAST_FORWARD FOR 
	    SELECT e.IDMov, Contacto, p.eMail1, a.Direccion, p.Nombre, u.Nombre, u.eMail
	    FROM ExploraDispersion e
	    JOIN Prov p on e.Contacto=p.Proveedor
		JOIN Usuario u on e.UsuarioOrigen=u.Usuario
	    JOIN AnexoMov a on e.IDMov=a.ID  AND a.Rama=@Rama AND a.Tipo=@Tipo
	    WHERE ISNULL(Seleccionar,0)=1 AND e.Estacion=@Estacion
     OPEN crEnvio
	 FETCH NEXT FROM crEnvio INTO @ID, @Proveedor, @eMailProv, @Anexos, @NombreProv, @NombreUsr, @eMailUsr
     WHILE @@FETCH_STATUS = 0 
     BEGIN 
	 	SELECT @strPrint = NULL
        EXEC spEnvioCorreoFormato @ID, @Proveedor, @NombreProv, @Mensaje, @Estacion, @OK OUTPUT, @OKRef OUTPUT, @strPrint OUTPUT		

	    IF ISNULL(@strPrint,'') <> ''
	    BEGIN ---- E N V I O		
	      --SELECT @Asunto = 'Notificación Automática Comprobante de Pago: ' + ISNULL(@Proveedor,'')
	      EXEC msdb.dbo.sp_send_dbmail 
	       @profile_name =@Perfil,
		   @recipients=@eMailProv,
		   @copy_recipients=@eMailUsr,  
		   --@blind_copy_recipients=@blind_copy_recipients,  --CCO
		   @subject =@Asunto,
		   @body = @strPrint, 
		   @file_attachments = @Anexos,
		   @body_format = 'HTML';
	    END   ---- E N V I O   

	 FETCH NEXT FROM crEnvio INTO @ID, @Proveedor, @eMailProv, @Anexos, @NombreProv, @NombreUsr, @eMailUsr
     END
     CLOSE crEnvio
     DEALLOCATE crEnvio 
--SET NOCOUNT OFF
RETURN
END
GO
--BEGIN TRANSACTION
--exec spEnvioComprobante 1, null, null
--SELECT * FROM DINERO WHERE ENVIOCOMPROBANTE=1
--ROLLBACK

-------------------------------------------------------------------
---------------------- spEnvioComprobante --------------------
-------------------------------------------------------------------
IF EXISTS (SELECT 1 from SysObjects WHERE name ='spEnvioComprobante' AND type='P') drop procedure spEnvioComprobante
GO
CREATE PROCEDURE spEnvioComprobante
@Estacion int,
@OK       int OUTPUT,
@OKRef    varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  --SET NOCOUNT on
  DECLARE @Asunto         varchar(255),
          @Mensaje        varchar(255),
		  @Server         varchar(255),
		  @Puerto         varchar(10),
		  @eMailProv      varchar(255),
		  @Contrasena     varchar(50),
		  @Contrasena1    varchar(50),
		  @Anexos         varchar(max),
		  @Proveedor      varchar(20),
		  @ID             int,
		  @eMail          varchar(255),
		  @strPrint       varchar(max),
		  @Perfil         varchar(100),
		  @ConexionSSL    bit,
		  @SSL            char(5),
		  @account        varchar(100),
		  @description    varchar(255),
		  @account_id     int,
		  @recipients     varchar(max)  

    SELECT @Asunto=Asunto, @Mensaje=Mensaje, @Server=NombreServer, @Puerto=Puerto, @eMail=eMail, @Contrasena=Contrasena, @Contrasena1=Contrasena1,
	       @Perfil=ISNULL(Perfil,'EnvioComprobantes'), @ConexionSSL=ISNULL(ConexionSSL,0), @account=Cuenta
	FROM ConfigDispersion
	--select * from ConfigDispersion

	--SELECT @SSL=CASE WHEN @ConexionSSL=1 THEN 'TRUE' ELSE 'FALSE' END

	IF ISNULL(@Server,'') = ''
    BEGIN
      SELECT @Ok = 53060, @OkRef = 'No se encuentra configurado el servidor de correo, el usuario no recibira notificación por correo'
    RETURN(0)
    END

	IF ISNULL(@account,'') = '' OR ISNULL(@eMail,'') = '' 
    BEGIN
      SELECT @Ok = 53050, @OkRef = @account
    RETURN(0)
    END

	BEGIN TRANSACTION
	
	IF @Ok IS NULL AND NOT EXISTS (SELECT * FROM msdb.dbo.sysmail_account WHERE name = @account )
    BEGIN
	  DECLARE @rv INT
	  SET @description = 'Cuenta de correo para el usuario ' + @account

      EXECUTE @rv = msdb.dbo.sysmail_add_account_sp
			  @account_name = @account,
			  @email_address = @email,
			  @display_name = @account,
			  @replyto_address = @email,
			  @description = @description,
			  @mailserver_name = @Server,
			  @port = @Puerto,
			  @enable_ssl = @ConexionSSL,
			  @mailserver_type =  'SMTP' , 
			  @username = @email,
			  @password = @Contrasena,
			  @account_id = @account_id OUTPUT

      IF @rv<>0
      BEGIN
		SELECT @Ok = 1, @OkRef = 'Error al crear la cuenta de correo (' + @account + ').'
		ROLLBACK TRANSACTION
	  END
    END

    IF @Ok IS NULL AND NOT EXISTS (SELECT * FROM msdb.dbo.sysmail_profile WHERE name = @perfil)
    BEGIN
	  SET @description = 'Perfil de correo: ' + @perfil
	  EXECUTE @rv = msdb.dbo.sysmail_add_profile_sp @profile_name = @perfil, @description = @description

	  IF @rv<>0
	  BEGIN
		SELECT @Ok = 1, @OkRef = 'Error al crear el perfil para el correo (' + @perfil + ').'
		ROLLBACK TRANSACTION
	  END
    END

	IF @Ok IS NULL AND @account_id IS NOT NULL
    BEGIN
	  EXECUTE @rv = msdb.dbo.sysmail_add_profileaccount_sp
		@profile_name = @perfil,
		@account_name = @account,
		@sequence_number = 1

	  IF @rv<>0
	  BEGIN
		SELECT @Ok = 1, @OkRef = 'Error al asociar el perfil con la cuenta(' + @account + ').'
		ROLLBACK TRANSACTION
	  END
    END	

	IF @OK IS NULL
  	  EXEC spEnvioFormatoComprobante @Estacion, @Perfil, @eMail, @Asunto, @Mensaje,  @OK OUTPUT, @OKRef OUTPUT

	  --select @ok

    IF ISNULL(@OK,0) = 0
    BEGIN 
	  COMMIT
	  UPDATE d SET EnvioComprobante=1
	  FROM Dinero d  
	  JOIN ExploraDispersion e on d.ID=e.IDMov
	  WHERE e.Estacion=@Estacion
	  SELECT @OK = 80042
    END 
    ELSE
    BEGIN
	   ROLLBACK
	   IF ISNULL(@OK,0) = 0 
	   SELECT @OK = 52010
    END    			
  
    SELECT @OKRef = Descripcion + ISNULL(@OKRef,'')
    FROM MensajeLista 
    WHERE Mensaje = @OK

	SELECT @OKREF 'OKREF'
 
	   		 	 	  
RETURN  
END  
GO
--EXEC spEnvioComprobante 1, NULL, NULL