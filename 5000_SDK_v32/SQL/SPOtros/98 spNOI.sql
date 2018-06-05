SET ANSI_NULLS ON
SET ANSI_WARNINGS ON






IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'AGUASCALIENTES' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '1' WHERE  Pais = 'Mexico' AND Estado = 'AGUASCALIENTES'
GO
IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'BAJA CALIFORNIA' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '2' WHERE  Pais = 'Mexico' AND Estado = 'BAJA CALIFORNIA'
GO
IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'BAJA CALIFORNIA SUR' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '3' WHERE  Pais = 'Mexico' AND Estado = 'BAJA CALIFORNIA SUR'
GO
IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'CAMPECHE' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '4' WHERE  Pais = 'Mexico' AND Estado = 'CAMPECHE'
GO
IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'CHIAPAS' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '7' WHERE  Pais = 'Mexico' AND Estado = 'CHIAPAS'
GO
IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'CHIHUAHUA' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '5' WHERE  Pais = 'Mexico' AND Estado = 'CHIHUAHUA'
GO
IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'COAHUILA' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '8' WHERE  Pais = 'Mexico' AND Estado = 'COAHUILA'
GO

IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'COLIMA' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '6' WHERE  Pais = 'Mexico' AND Estado = 'COLIMA'
GO
IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'CIUDAD DE MEXICO' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '9' WHERE  Pais = 'Mexico' AND Estado = 'CIUDAD DE MEXICO'
GO
IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'DURANGO' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '10' WHERE  Pais = 'Mexico' AND Estado = 'DURANGO'
GO
IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'GUANAJUATO' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '11' WHERE  Pais = 'Mexico' AND Estado = 'GUANAJUATO'
GO

IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'GUERRERO' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '12' WHERE  Pais = 'Mexico' AND Estado = 'GUERRERO'
GO
IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'HIDALGO' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '13' WHERE  Pais = 'Mexico' AND Estado = 'HIDALGO'
GO
IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'JALISCO' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '14' WHERE  Pais = 'Mexico' AND Estado = 'JALISCO'
GO

IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'MEXICO' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '15' WHERE  Pais = 'Mexico' AND Estado = 'MEXICO'
GO
IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'MICHOACAN' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '16' WHERE  Pais = 'Mexico' AND Estado = 'MICHOACAN'
GO

IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'MORELOS' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '17' WHERE  Pais = 'Mexico' AND Estado = 'MORELOS'
GO
IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'NAYARIT' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '18' WHERE  Pais = 'Mexico' AND Estado = 'NAYARIT'
GO
IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'NUEVO LEON' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '19' WHERE  Pais = 'Mexico' AND Estado = 'NUEVO LEON'
GO
IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'OAXACA' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '20' WHERE  Pais = 'Mexico' AND Estado = 'OAXACA'
GO
IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'PUEBLA' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '21' WHERE  Pais = 'Mexico' AND Estado = 'PUEBLA'
GO
IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'QUERETARO' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '22' WHERE  Pais = 'Mexico' AND Estado = 'QUERETARO'
GO
IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'QUINTANA ROO' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '23' WHERE  Pais = 'Mexico' AND Estado = 'QUINTANA ROO'
GO
IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'AN LUIS POTOSI' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '24' WHERE  Pais = 'Mexico' AND Estado = 'SAN LUIS POTOSI'
GO
IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'SINALOA' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '25' WHERE  Pais = 'Mexico' AND Estado = 'SINALOA'
GO
IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'SONORA' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '26' WHERE  Pais = 'Mexico' AND Estado = 'SONORA'
GO
IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'TABASCO' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '27' WHERE  Pais = 'Mexico' AND Estado = 'TABASCO'
GO
IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'TAMAULIPAS' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '28' WHERE  Pais = 'Mexico' AND Estado = 'TAMAULIPAS'
GO
IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'TLAXCALA' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '29' WHERE  Pais = 'Mexico' AND Estado = 'TLAXCALA'
GO
IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'VERACRUZ' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '30' WHERE  Pais = 'Mexico' AND Estado = 'VERACRUZ'
GO
IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'YUCATAN' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '31' WHERE  Pais = 'Mexico' AND Estado = 'YUCATAN'
GO
IF  EXISTS(SELECT * FROM PaisEstado  WHERE  Pais = 'Mexico' AND Estado = 'ZACATECAS' AND Clave IS NULL)
UPDATE PaisEstado SET Clave = '32' WHERE  Pais = 'Mexico' AND Estado = 'ZACATECAS'

GO


/**************** spNOIImportarConceptoNomina ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNOIImportarConceptoNomina')           AND type = 'P') drop procedure dbo.spNOIImportarConceptoNomina
GO
CREATE PROCEDURE spNOIImportarConceptoNomina
                @Empresa        varchar(5),
	        @TablaPeriodo	varchar(10),
	        @Estacion       int
--//WITH ENCRYPTION
AS BEGIN

DECLARE
@Sucursal                       int,
@SQL				varchar(MAX),
@SQL2				varchar(MAX),
@SQL3				varchar(MAX),
@SQL4				varchar(MAX),
@Datos                        	varchar(MAX),
@BaseNOI	                varchar(255),
@EmpresaNOI                     varchar(2),
@ID    	        		int,
@Ok     			int,
@OkRef	                	varchar(255)

DECLARE @Tabla table
(NominaConcepto varchar(10),
Concepto        varchar(50),
Estatus         varchar(15),
Movimiento      varchar(20),
Pais            varchar(30),
CuentaGrupo     varchar(20),
Modulo          varchar(5),
Status          varchar(10))

DECLARE @Tabla2 table
(NominaConcepto         varchar(10),
 GravaISR               varchar(50) 
)

DECLARE @Tabla3 table
(NominaConcepto         varchar(10),
 GravaIMSS              varchar(50) 
)
DECLARE @Tabla4 table
(NominaConcepto             varchar(10),
 GravaImpuestoEstatal       varchar(50) 
)
 
SELECT @BaseNOI = '['+Servidor +'].'+BaseDatosNombre,@EmpresaNOI = EmpresaAspel ,@Sucursal = SucursalIntelisis
  FROM InterfaseAspel WHERE SistemaAspel = 'NOI' AND Empresa = @Empresa


SET ANSI_NULLS ON
SET ANSI_WARNINGS ON
  SELECT @SQL = 'SELECT UPPER(CHAR(PER_O_DED))+dbo.fnRellenarCerosIzquierda(NUM_PERDED,3) NominaConcepto,  
          NOMBRE,
          CASE WHEN STATUS = '+CHAR(39)+'A'+CHAR(39)+' THEN'+CHAR(39)+ 'ALTA'+CHAR(39)+' WHEN STATUS ='+CHAR(39)+ 'Baja' +CHAR(39)+'THEN'+CHAR(39)+ 'Baja'+CHAR(39)+' WHEN STATUS ='+CHAR(39)+ 'Baja' +CHAR(39)+'THEN'+CHAR(39)+ 'Baja'+CHAR(39)+' ELSE NULL END Estatus,
          CASE WHEN  UPPER(CHAR(PER_O_DED)) ='+CHAR(39)+ 'P'+CHAR(39)+ ' THEN'+CHAR(39)+ 'Percepcion'+CHAR(39)+' WHEN UPPER(CHAR(PER_O_DED)) ='+CHAR(39)+ 'D'+CHAR(39)+ 'THEN '+CHAR(39)+'Deduccion' +CHAR(39)+' WHEN  UPPER(CHAR(PER_O_DED)) ='+CHAR(39)+ 'E'+CHAR(39)+ ' THEN'+CHAR(39)+ 'Estadistica'+CHAR(39)+'ELSE NULL END Movimiento,
          '+CHAR(39)+'Mexico' +CHAR(39)+'As Pais,
          '+CHAR(39)+'ASPEL' +CHAR(39)+'As CuentaGrupo,
          '+CHAR(39)+'NOM' +CHAR(39)+'As Modulo ,
          STATUS
           FROM ' + @BaseNOI + '.dbo.PD' + @TablaPeriodo+@EmpresaNOI + '
	  WHERE TIPO_REG = 0 ORDER BY PER_O_DED, NUM_PERDED'
			
  INSERT @Tabla(NominaConcepto,Concepto,Estatus,Movimiento,Pais,CuentaGrupo,Modulo,Status)
  EXEC (@SQL)
  
  UPDATE @Tabla SET Movimiento = 'Estadistica' WHERE Status = 'C'
  SELECT @SQL2 = 'SELECT UPPER(CHAR(PER_O_DED))+dbo.fnRellenarCerosIzquierda(NUM_PERDED,3), 
                 CASE WHEN DIG_GRAV ='+CHAR(39)+ 'G' +CHAR(39)+'THEN'+CHAR(39)+ 'Si'+CHAR(39)+' WHEN DIG_GRAV='+CHAR(39)+ 'E'+CHAR(39)+' THEN'+CHAR(39)+ 'No' +CHAR(39)+'END 
     FROM ' + @BaseNOI + '.dbo.PD' + @TablaPeriodo+@EmpresaNOI + '
   WHERE TIPO_REG IN(1)
     AND DIG_GRAV IN ('+CHAR(39)+'G'+CHAR(39)+','+CHAR(39)+'E'+CHAR(39)+')
  ORDER BY PER_O_DED'
  INSERT @Tabla2(NominaConcepto,GravaISR)
  EXEC (@SQL2)
  
  SELECT @SQL3 = 'SELECT UPPER(CHAR(PER_O_DED))+dbo.fnRellenarCerosIzquierda(NUM_PERDED,3), 
                 CASE WHEN DIG_GRAV ='+CHAR(39)+ 'G' +CHAR(39)+'THEN'+CHAR(39)+ 'Si'+CHAR(39)+' WHEN DIG_GRAV='+CHAR(39)+ 'E'+CHAR(39)+' THEN'+CHAR(39)+ 'No' +CHAR(39)+'END 
     FROM ' + @BaseNOI + '.dbo.PD' + @TablaPeriodo+@EmpresaNOI + '
   WHERE TIPO_REG IN(2)
     AND DIG_GRAV IN ('+CHAR(39)+'G'+CHAR(39)+','+CHAR(39)+'E'+CHAR(39)+')
  ORDER BY PER_O_DED'  

  INSERT @Tabla3(NominaConcepto,GravaIMSS)
  EXEC (@SQL3)
  
  SELECT @SQL4 = 'SELECT UPPER(CHAR(PER_O_DED))+dbo.fnRellenarCerosIzquierda(NUM_PERDED,3), 
                 CASE WHEN DIG_GRAV ='+CHAR(39)+ 'G' +CHAR(39)+'THEN'+CHAR(39)+ 'Si'+CHAR(39)+' WHEN DIG_GRAV='+CHAR(39)+ 'E'+CHAR(39)+' THEN'+CHAR(39)+ 'No' +CHAR(39)+'END 
     FROM ' + @BaseNOI + '.dbo.PD' + @TablaPeriodo+@EmpresaNOI + '
   WHERE TIPO_REG IN(4)
     AND DIG_GRAV IN ('+CHAR(39)+'G'+CHAR(39)+','+CHAR(39)+'E'+CHAR(39)+')
  ORDER BY PER_O_DED'  
  
  INSERT @Tabla4(NominaConcepto,GravaImpuestoEstatal)
  EXEC (@SQL4)

  IF EXISTS (SELECT * FROM NOINominaConcepto WHERE Nomina = @TablaPeriodo AND EmpresaNOI = @EmpresaNOI AND Estacion = @Estacion)
  DELETE  NOINominaConcepto
  WHERE Nomina = @TablaPeriodo AND EmpresaNOI = @EmpresaNOI AND Estacion = @Estacion
  
  
  INSERT NOINominaConcepto(Estacion,  NominaConcepto,   GravaISR,                GravaIMSS,                GravaImpuestoEstatal,                 Concepto,   Estatus,   Movimiento,   Pais,   CuentaGrupo,   Modulo, EmpresaNOI, Nomina)
  SELECT                   @Estacion, a.NominaConcepto, ISNULL(b.GravaISR,'Si'), ISNULL(c.GravaIMSS,'Si'), ISNULL(d.GravaImpuestoEstatal,'Si') , a.Concepto, a.Estatus, a.Movimiento, a.Pais, a.CuentaGrupo, a.Modulo,@EmpresaNOI,@TablaPeriodo
    FROM  @Tabla a 
    LEFT JOIN @Tabla2 b ON a.NominaConcepto = b.NominaConcepto
    LEFT JOIN @Tabla3 c ON a.NominaConcepto = c.NominaConcepto
    LEFT JOIN @Tabla4 d ON a.NominaConcepto = d.NominaConcepto


RETURN
END

GO
--spNOIImportarConceptoNomina 'DEMO','150210',1



/**************** spNOIImportarDepartamento ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNOIImportarDepartamento')           AND type = 'P') drop procedure dbo.spNOIImportarDepartamento
GO
CREATE PROCEDURE spNOIImportarDepartamento
                @Empresa        varchar(5),
                @Estacion       int
--//WITH ENCRYPTION
AS BEGIN

DECLARE
@Sucursal                       int,
@SQL				varchar(MAX),
@Datos                        	varchar(MAX),
@BaseNOI	                varchar(255),
@EmpresaNOI                     varchar(2),
@ID    	        		int,
@Ok     			int,
@OkRef	                	varchar(255)

DECLARE @Tabla table
(Departamento varchar(50))


 
SELECT @BaseNOI = '['+Servidor +'].'+BaseDatosNombre,@EmpresaNOI = EmpresaAspel ,@Sucursal = SucursalIntelisis
  FROM InterfaseAspel WHERE SistemaAspel = 'NOI' AND Empresa = @Empresa


SET ANSI_NULLS ON
SET ANSI_WARNINGS ON
  SELECT @SQL = 'SELECT NULLIF(NOMBRE,'+CHAR(39)+''+CHAR(39)+')
           FROM ' + @BaseNOI + '.dbo.DEPTOS' + @EmpresaNOI 
	  
			
  INSERT @Tabla (Departamento)
  EXEC (@SQL)

  IF EXISTS (SELECT * FROM NOIDepartamento WHERE EmpresaNOI = @EmpresaNOI AND Estacion = @Estacion)
  DELETE NOIDepartamento WHERE EmpresaNOI = @EmpresaNOI AND Estacion = @Estacion
  
  INSERT NOIDepartamento(Estacion, EmpresaNOI,Departamento,Sucursal)
  SELECT                 @Estacion,@EmpresaNOI,Departamento,@Sucursal
    FROM @Tabla
  WHERE Departamento IS NOT NULL

RETURN
END

GO

--exec spNOIImportarDepartamento 'DEMO',1


/**************** spNOIImportarPuestos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNOIImportarPuestos')           AND type = 'P') drop procedure dbo.spNOIImportarPuestos
GO
CREATE PROCEDURE spNOIImportarPuestos
                @Empresa        varchar(5),
                @Estacion       int
--//WITH ENCRYPTION
AS BEGIN

DECLARE
@Sucursal                       int,
@SQL				varchar(MAX),
@Datos                        	varchar(MAX),
@BaseNOI	                varchar(255),
@EmpresaNOI                     varchar(2),
@ID    	        		int,
@Ok     			int,
@OkRef	                	varchar(255)

DECLARE @Tabla table
(Puesto varchar(50),
 SueldoRangoMinimo float,
 SueldoRangoMaximo float
 )


 
SELECT @BaseNOI = '['+Servidor +'].'+BaseDatosNombre,@EmpresaNOI = EmpresaAspel ,@Sucursal = SucursalIntelisis
  FROM InterfaseAspel WHERE SistemaAspel = 'NOI' AND Empresa = @Empresa


SET ANSI_NULLS ON
SET ANSI_WARNINGS ON
  SELECT @SQL = 'SELECT NULLIF(NOMBRE,'+CHAR(39)+''+CHAR(39)+'),SUELDO_SUG,SUELDO_MAX
           FROM ' + @BaseNOI + '.dbo.PUESTOS' + @EmpresaNOI 
	  
			
  INSERT @Tabla (Puesto,SueldoRangoMinimo,SueldoRangoMaximo)
  EXEC (@SQL)

  IF EXISTS (SELECT * FROM NOIPuestos WHERE EmpresaNOI = @EmpresaNOI AND Estacion = @Estacion)
  DELETE NOIPuestos WHERE EmpresaNOI = @EmpresaNOI AND Estacion = @Estacion
  
  INSERT NOIPuestos(Estacion,  EmpresaNOI,Puesto,SueldoRangoMinimo,SueldoRangoMaximo)
  SELECT            @Estacion, @EmpresaNOI,Puesto,SueldoRangoMinimo,SueldoRangoMaximo
    FROM @Tabla
   WHERE Puesto IS NOT NULL

RETURN
END

GO

--exec spNOIImportarPuestos 'DEMO'


/**************** spCEValidarPersonal ****************/
if exists (SELECT * FROM sysobjects where id = object_id('dbo.spCEValidarPersonal') and type = 'P') drop procedure dbo.spCEValidarPersonal
GO             
CREATE PROCEDURE spCEValidarPersonal
		
			@Empresa       varchar(5)
			


--//WITH ENCRYPTION
AS BEGIN
DECLARE
    @EmpresaNOI  varchar(2),
    @TipoPeriodo varchar(20),
    @CtaDinero   varchar(10),
    @Moneda      varchar(10),
    @Sucursal    int,
    @ZonaEconomica varchar(30),
    @ConceptoDIN varchar(50),
    @OK          varchar(200)
    
  SELECT @EmpresaNOI = EmpresaAspel,@Sucursal =SucursalIntelisis
    FROM InterfaseAspel WHERE SistemaAspel = 'NOI' AND Empresa = @Empresa
    
  SELECT @TipoPeriodo = TipoPeriodo,@CtaDinero = CtaDinero ,@Moneda = Moneda , @ConceptoDIN =ConceptoDIN
    FROM InterfaseAspelNOI WHERE  Empresa = @Empresa
        
  SELECT @ZonaEconomica = ZonaEconomica FROM Sucursal WHERE Sucursal = @Sucursal    
   
   SET @OK = NULL
   
   IF  NULLIF(@ZonaEconomica,'') IS NULL
   SELECT @OK = 'Es Necesario Asignar La Zona Economica De La Sucursal'   
   
   IF  @Sucursal IS NULL
   SELECT @OK = 'Es Necesario Asignar La Sucursal'
   
   IF  NULLIF(@TipoPeriodo,'') IS NULL
   SELECT @OK = 'Es Necesario Asignar El Tipo Periodo'   

   IF  NULLIF(@Moneda,'') IS NULL
   SELECT @OK = 'Es Necesario Asignar La Moneda' 
   
   IF  NULLIF(@CtaDinero,'') IS NULL
   SELECT @OK = 'Es Necesario Asignar La Cuenta Dinero'   
   
   IF  NULLIF(@ConceptoDIN,'') IS NULL
   SELECT @OK = 'Es Necesario Asignar El Concepto Tesoreria'   
   
         
   
  
   
   SELECT @OK
END
GO

--spCEValidarPersonal 'demo'





/**************** spNOIVerificarPersonal ****************/
if exists (SELECT * FROM sysobjects where id = object_id('dbo.spNOIVerificarPersonal') and type = 'P') drop procedure dbo.spNOIVerificarPersonal
GO             
CREATE PROCEDURE spNOIVerificarPersonal
		
			@Empresa       varchar(5),
			@TablaPeriodo  varchar(10),
			@Estacion      int
			


--//WITH ENCRYPTION
AS BEGIN
DECLARE
    @EmpresaNOI         varchar(2),
    @Ok                 int,
    @OKRef              varchar(255),
    @Verificado         bit,
    @Personal           varchar(10), 
    @Nombre             varchar(30), 
    @ApellidoPaterno    varchar(30), 
    @ApellidoMaterno    varchar(30), 
    @FechaAlta          datetime,
    @FormaPago          varchar(50),  
    @Departamento       varchar(50),  
    @Puesto             varchar(50),  
    @SueldoDiario       money
     
    
  SElECT @Ok = NULL,@OKRef = NULL, @Verificado =0 
  SELECT @EmpresaNOI = EmpresaAspel
    FROM InterfaseAspel WHERE SistemaAspel = 'NOI' AND Empresa = @Empresa
    
  DECLARE crDetalle CURSOR FOR 
  SELECT  Personal,Nombre,ApellidoPaterno,ApellidoMaterno,FechaAlta,FormaPago,SueldoDiario,Departamento,Puesto
    FROM NOIPersonal 
   WHERE EmpresaNOI = @EmpresaNOI AND Nomina = @TablaPeriodo AND Estacion = @Estacion 
  OPEN crDetalle
  FETCH NEXT FROM crDetalle INTO   @Personal, @Nombre, @ApellidoPaterno, @ApellidoMaterno,@FechaAlta,@FormaPago, @SueldoDiario, @Departamento, @Puesto
  WHILE @@FETCH_STATUS = 0 
  BEGIN
    SELECT @Verificado = 0 ,@Ok = NULL,@OkRef= NULL
 
    IF NULLIF(@ApellidoPaterno,'') IS NULL
    SELECT @Ok = 74100
    
    IF NULLIF(@Nombre,'') IS NULL
    SELECT @Ok = 74105
    
    IF NULLIF(@FormaPago,'') IS NULL
    SELECT @Ok = 74110
    
    IF @SueldoDiario IS NULL
    SELECT @Ok = 74115            

    IF @FechaAlta IS NULL
    SELECT @Ok = 74120 
    
    IF NULLIF(@ApellidoPaterno,'') IS NULL
    SELECT @Ok = 74100
    
    IF NULLIF(@Departamento,'') IS NULL OR NOT EXISTS (SELECT * FROM Departamento WHERE Departamento = @Departamento)
    SELECT @Ok = 74125    
    
    IF NULLIF(@Puesto,'') IS NULL OR NOT EXISTS (SELECT * FROM Puesto WHERE Puesto = @Puesto)
    SELECT @Ok = 74130      
    

    


   IF @Ok IS NOT NULL
   SELECT @OkRef = Descripcion
     FROM MensajeLista
    WHERE  Mensaje = @Ok

   IF @Ok IS NULL SET @Verificado = 1
   
   UPDATE NOIPersonal SET Verificado = @Verificado,Ok = @OK,OkRef = @OkRef
   WHERE Personal = @Personal AND EmpresaNOI = @EmpresaNOI AND Nomina = @TablaPeriodo AND Estacion = @Estacion 
   

    FETCH NEXT FROM crDetalle INTO  @Personal, @Nombre, @ApellidoPaterno, @ApellidoMaterno,@FechaAlta,@FormaPago, @SueldoDiario, @Departamento, @Puesto
  END
  CLOSE crDetalle
  DEALLOCATE crDetalle     
  
  UPDATE NOINomina 
     SET Ok = p.Ok,OkRef =p.OkRef,Verificado = p.Verificado
    FROM NOINomina n JOIN  NOIPersonal p ON n.Personal = p.Personal AND p.Estacion = n.Estacion AND p.Nomina = n.Nomina
   WHERE n.EmpresaNOI = @EmpresaNOI AND n.Nomina = @TablaPeriodo AND n.Estacion = @Estacion AND n.Ok <> 30100
    

END
GO
 

--EXEC spNOIImportarConceptoNomina 'DEMO','150110',1


/**************** spNOIImportarPersonal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNOIImportarPersonal')           AND type = 'P') drop procedure dbo.spNOIImportarPersonal
GO
CREATE PROCEDURE spNOIImportarPersonal
                @Empresa        varchar(5),
	        @TablaPeriodo	varchar(10),
	        @Estacion       int,
	        @FechaA         datetime
--//WITH ENCRYPTION
AS BEGIN

DECLARE
  @Sucursal             int,
  @SQL			varchar(MAX),
  @SQL2			varchar(MAX),
  @SQL3			varchar(MAX),
  @BaseNOI	        varchar(255),
  @EmpresaNOI           varchar(2),
  @Personal             varchar(10), 
  @Nombre               varchar(30), 
  @ApellidoPaterno      varchar(30), 
  @ApellidoMaterno      varchar(30), 
  @Estatus              varchar(15), 
  @Registro2            varchar(30), 
  @Departamento         varchar(50), 
  @Puesto               varchar(50), 
  @Registro3            varchar(30), 
  @FechaAlta            datetime   , 
  @FechaBaja            datetime   , 
  @FormaPago            varchar(50), 
  @SueldoDiario         money   , 
  @SDI                  money   , 
  @TipoSueldo           varchar(10), 
  @Direccion            varchar(100), 
  @Colonia              varchar(100), 
  @Poblacion            varchar(100), 
  @Estado               varchar(30), 
  @CodigoPostal         varchar(15), 
  @CtaDinero            varchar(10), 
  @PersonalCuenta       varchar(20), 
  @LugarNacimiento      varchar(50), 
  @Tipo                 varchar(20), 
  @TipoContrato         varchar(50), 
  @EstadoCivil          varchar(20), 
  @UnidadMedica         int   , 
  @Padre                varchar(50), 
  @Madre                varchar(50), 
  @Telefono             varchar(50), 
  @Sexo                 varchar(10), 
  @FechaNacimiento      datetime   , 
  @Registro             varchar(30), 
  @Email                varchar(50), 
  @Jornada              varchar(20),
  @ZonaEconomica        varchar(20),
  @PeriodoTipo          varchar(20),
  @Moneda               varchar(10),
  @Ok           	int,
  @OkRef              	varchar(255),
  @Verificado           bit,
  @FechaUltimoPago      datetime,
  @FechaD               datetime
   
  SELECT @BaseNOI = '['+Servidor +'].'+BaseDatosNombre,@EmpresaNOI = EmpresaAspel ,@Sucursal = SucursalIntelisis
    FROM InterfaseAspel WHERE SistemaAspel = 'NOI' AND Empresa = @Empresa
    
  SELECT @PeriodoTipo = TipoPeriodo,@Moneda = Moneda,@CtaDinero = CtaDinero
    FROM InterfaseAspelNOI WHERE Empresa = @Empresa
  
  SELECT @ZonaEconomica = ZonaEconomica FROM Sucursal WHERE Sucursal = @Sucursal

  DECLARE 
  @Tabla table(
    Personal  varchar(10), Nombre  varchar(30), ApellidoPaterno  varchar(30), ApellidoMaterno  varchar(30), Estatus  varchar(15), Registro2  varchar(30), Departamento  varchar(50), Puesto  varchar(50), Registro3  varchar(30), FechaAlta  datetime, FechaBaja  datetime, FormaPago  varchar(50), SueldoDiario  money, SDI  money, TipoSueldo  varchar(10), Direccion  varchar(100), Colonia  varchar(100), Poblacion  varchar(100), Estado  varchar(30), CodigoPostal  varchar(15), CtaDinero  varchar(10), PersonalCuenta  varchar(20), LugarNacimiento  varchar(50), Tipo  varchar(20), TipoContrato  varchar(50), EstadoCivil  varchar(20), UnidadMedica  int, Padre  varchar(50), Madre  varchar(50), Telefono  varchar(50), Sexo  varchar(10), FechaNacimiento  datetime, Registro  varchar(30), Email  varchar(50), Jornada  varchar(20))
  DECLARE 
  @Deptos table(
     Departamento  varchar(50),
     Clave         int
   )
  DECLARE 
  @Puestos table(
     Puesto        varchar(50),
     Clave         int
   )    
    

  IF EXISTS (SELECT * FROM NOIPersonal WHERE EmpresaNOI = @EmpresaNOI AND Nomina = @TablaPeriodo AND Estacion = @Estacion)
  DELETE NOIPersonal WHERE EmpresaNOI = @EmpresaNOI AND Nomina = @TablaPeriodo AND Estacion = @Estacion

  SET ANSI_NULLS ON
  SET ANSI_WARNINGS ON
  SELECT @SQL = '  SELECT RTRIM(LTRIM(CLAVE)),NOMBRE,AP_PAT_,AP_MAT_,STATUS,R_F_C_,DEPTO,PUESTO,IMSS,FECH_ALTA,FECH_BAJA,FORM_PAGO,SAL_DIARIO,SDI,TIP_SAL,CALLE,COLONIA,CD_POBLAC,ENT_FED,COD_POST,BANC_NOM,CTACHEQNOM,LUG_NACIM,TIP_EMPL,CONTRATO,EDO_CIVIL,UN_MED_FAM,NOM_PADRE,NOM_MADRE,TELEFONO,SEXO,FECH_NACIM,CURP,EMAIL,TIPOJORNADA
                     FROM ' + @BaseNOI + '.dbo.TB' + @TablaPeriodo+@EmpresaNOI 
	  
			
  INSERT @Tabla(Personal, Nombre, ApellidoPaterno, ApellidoMaterno, Estatus, Registro2, Departamento, Puesto, Registro3, FechaAlta, FechaBaja, FormaPago, SueldoDiario, SDI, TipoSueldo, Direccion, Colonia, Poblacion, Estado, CodigoPostal, CtaDinero, PersonalCuenta, LugarNacimiento, Tipo, TipoContrato, EstadoCivil, UnidadMedica, Padre, Madre, Telefono, Sexo, FechaNacimiento, Registro, Email, Jornada)
  EXEC (@SQL)

  SELECT @SQL2 = 'SELECT RTRIM(LTRIM(CLAVE)),NULLIF(NOMBRE,'+CHAR(39)+''+CHAR(39)+')
                   FROM ' + @BaseNOI + '.dbo.DEPTOS' + @EmpresaNOI 
	  
			
  INSERT @Deptos (Clave,Departamento)
  EXEC (@SQL2)

  SELECT @SQL3 = 'SELECT RTRIM(LTRIM(CLAVE)),NULLIF(NOMBRE,'+CHAR(39)+''+CHAR(39)+')
                   FROM ' + @BaseNOI + '.dbo.PUESTOS' + @EmpresaNOI 

		
  INSERT @Puestos(Clave,Puesto)
  EXEC (@SQL3)         
  
   DECLARE crDetalle CURSOR FOR 
   SELECT   RTRIM(LTRIM(a.Personal)), a.Nombre, a.ApellidoPaterno, a.ApellidoMaterno, CASE WHEN a.Estatus = 'A' THEN 'ALTA' WHEN a.Estatus ='B' THEN 'BAJA' ELSE NULL END, a.Registro2, d.Departamento, p.Puesto, a.Registro3, a.FechaAlta, a.FechaBaja, f.FormaPago, a.SueldoDiario, a.SDI,
   CASE WHEN a.TipoSueldo = 'F' THEN 'Fijo' WHEN a.TipoSueldo = 'V' THEN 'Variable' WHEN a.TipoSueldo = 'M' THEN 'Mixto' ELSE NULL END
   , a.Direccion, a.Colonia, a.Poblacion, cp.Estado, a.CodigoPostal, a.PersonalCuenta, pp.Estado, te.Tipo,
   CASE WHEN a.TipoContrato = 'P' THEN 'Permanente' WHEN a.TipoContrato = 'E' THEN 'Eventual' WHEN a.TipoContrato = 'C' THEN 'Construcción' WHEN a.TipoContrato = 'A' THEN 'Eventual' ELSE NULL END
   ,  CASE WHEN a.EstadoCivil = 'S' THEN 'Soltero' WHEN a.EstadoCivil = 'C' THEN 'Casado'  ELSE NULL END
   , a.UnidadMedica, a.Padre, a.Madre, a.Telefono, 
  CASE WHEN a.Sexo = 'F' THEN 'Femenino' WHEN a.Sexo = 'M' THEN 'Masculino'  ELSE NULL END
  , a.FechaNacimiento, a.Registro, a.Email, 'Horario Completo'
  FROM @Tabla a JOIN @Deptos d ON a.Departamento = d.Clave 
  JOIN @Puestos p ON a.Puesto = p.Clave
  LEFT JOIN NOIFormaPago f ON f.ClaveNOI = a.FormaPago
  LEFT JOIN NOITipoEmpleado te ON te.ClaveNOI = a.Tipo
  JOIN PaisEstado cp ON RTRIM(LTRIM(a.Estado)) = RTRIM(LTRIM(cp.Clave)) AND cp.Pais = 'Mexico'
  JOIN PaisEstado pp ON RTRIM(LTRIM(a.LugarNacimiento)) = RTRIM(LTRIM(pp.Clave)) AND pp.Pais = 'Mexico'     
  OPEN crDetalle
  FETCH NEXT FROM crDetalle INTO   @Personal, @Nombre, @ApellidoPaterno, @ApellidoMaterno, @Estatus, @Registro2, @Departamento, @Puesto, @Registro3, @FechaAlta, @FechaBaja, @FormaPago, @SueldoDiario, @SDI, @TipoSueldo, @Direccion, @Colonia, @Poblacion, @Estado, @CodigoPostal, @PersonalCuenta, @LugarNacimiento, @Tipo, @TipoContrato, @EstadoCivil, @UnidadMedica, @Padre, @Madre, @Telefono, @Sexo, @FechaNacimiento, @Registro, @Email, @Jornada
  WHILE @@FETCH_STATUS = 0 
  BEGIN
    SELECT @Verificado = 0 ,@Ok = NULL,@OkRef= NULL
 
    IF NULLIF(@ApellidoPaterno,'') IS NULL
    SELECT @Ok = 74100
    
    IF NULLIF(@Nombre,'') IS NULL
    SELECT @Ok = 74105
    
    IF NULLIF(@FormaPago,'') IS NULL
    SELECT @Ok = 74110
    
    IF NULLIF(@Tipo,'') IS NULL
    SELECT @Ok = 74113    
    
    IF @SueldoDiario IS NULL
    SELECT @Ok = 74115            

    IF @FechaAlta IS NULL
    SELECT @Ok = 74120 
    
    IF NULLIF(@Departamento,'') IS NULL OR NOT EXISTS (SELECT * FROM Departamento WHERE Departamento = @Departamento)
    SELECT @Ok = 74125    
    
    IF NULLIF(@Puesto,'') IS NULL OR NOT EXISTS (SELECT * FROM Puesto WHERE Puesto = @Puesto)
    SELECT @Ok = 74130       
    
    SELECT @FechaUltimoPago = UltimoPago FROM PersonalUltimoPago WHERE Personal = @Personal
    IF ISNULL(@FechaUltimoPago,@FechaA-1)>=@FechaA
    SELECT @Ok = 74135

   IF @Ok IS NOT NULL
   SELECT @OkRef = Descripcion
     FROM MensajeLista
    WHERE  Mensaje = @Ok

   IF @Ok IS NULL SET @Verificado = 1
   
   INSERT NOIPersonal(Estacion,  EmpresaNOI,Nomina,Personal, Nombre, ApellidoPaterno, ApellidoMaterno, Estatus, Registro2, Departamento, Puesto, Registro3, FechaAlta, FechaBaja, FormaPago, SueldoDiario, SDI, TipoSueldo, Direccion, Colonia, Poblacion, Estado, CodigoPostal, CtaDinero, PersonalCuenta, LugarNacimiento, Tipo, TipoContrato, EstadoCivil, UnidadMedica, Padre, Madre, Telefono, Sexo, FechaNacimiento, Registro, Email, Jornada,Ok,OkRef,Verificado,ZonaEconomica,PeriodoTipo,Moneda)
   SELECT            @Estacion,  @EmpresaNOI,@TablaPeriodo,@Personal, @Nombre, @ApellidoPaterno, @ApellidoMaterno, @Estatus, @Registro2, @Departamento, @Puesto, @Registro3, @FechaAlta, @FechaBaja, @FormaPago, @SueldoDiario, @SDI, @TipoSueldo, @Direccion, @Colonia, @Poblacion, @Estado, @CodigoPostal, @CtaDinero, @PersonalCuenta, @LugarNacimiento, @Tipo, @TipoContrato, @EstadoCivil, @UnidadMedica, @Padre, @Madre, @Telefono, @Sexo, @FechaNacimiento, @Registro, @Email, @Jornada,@Ok,@OkRef,@Verificado,@ZonaEconomica,@PeriodoTipo,@Moneda

    FETCH NEXT FROM crDetalle INTO  @Personal, @Nombre, @ApellidoPaterno, @ApellidoMaterno, @Estatus, @Registro2, @Departamento, @Puesto, @Registro3, @FechaAlta, @FechaBaja, @FormaPago, @SueldoDiario, @SDI, @TipoSueldo, @Direccion, @Colonia, @Poblacion, @Estado, @CodigoPostal, @PersonalCuenta, @LugarNacimiento, @Tipo, @TipoContrato, @EstadoCivil, @UnidadMedica, @Padre, @Madre, @Telefono, @Sexo, @FechaNacimiento, @Registro, @Email, @Jornada
  END
  CLOSE crDetalle
  DEALLOCATE crDetalle 

RETURN
END

GO

--EXEC spNOIImportarPersonal 'DEMO','310110',1

/**************** spNOIImportarNomina ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNOIImportarNomina')           AND type = 'P') drop procedure dbo.spNOIImportarNomina
GO
CREATE PROCEDURE spNOIImportarNomina
                @Empresa        varchar(5),
	        @TablaPeriodo	varchar(10),
	        @Estacion       int
--//WITH ENCRYPTION
AS BEGIN

  DECLARE
  @Sucursal                       int,
  @SQL				  varchar(MAX),
  @SQL2				  varchar(MAX),
  @SQL3				  nvarchar(MAX),
  @NomEspecial                    varchar(1),
  @BaseNOI	                  varchar(255),
  @EmpresaNOI                     varchar(2),
  @Tipo                           varchar(20),
  @FechaD                         datetime,
  @FechaA                         datetime,
  @ID    	        	  int,
  @Ok     			  int,
  @OkRef	                  varchar(255)
 
   DECLARE @Tabla table
  ( Personal        varchar(10),	
    SueldoDiario    float,         
    TotalPer        float,         
    TotalDed        float,         
    IMSS            float,         
    ISPT            float,         
    Infonavit       float,        
    NetoPagado      float,
    NomEspecial     bit)
 
 
  DECLARE @Tabla2 table
  ( Personal       varchar(10),	
    NominaConcepto varchar(10),
    Valor          float )
 
  SELECT @BaseNOI = '['+Servidor +'].'+BaseDatosNombre,@EmpresaNOI = EmpresaAspel ,@Sucursal = SucursalIntelisis
    FROM InterfaseAspel WHERE SistemaAspel = 'NOI' AND Empresa = @Empresa
    
  SELECT @Tipo = TipoPeriodo
    FROM InterfaseAspelNOI WHERE Empresa = @Empresa  
  
  
  SELECT @FechaD = FechaD, @FechaA = FechaA
    FROM NOITablaPeriodo WHERE Nomina = @TablaPeriodo AND Estacion = @Estacion  



  SET ANSI_NULLS ON
  SET ANSI_WARNINGS ON
           SELECT @SQL ='SELECT RTRIM(LTRIM(CLAVE_TRAB)),SUEL_DR,TOT_PER,TOT_DED,IMSS_TR,ISPT_TR,INFONTR,NETO_PG,0
	                   FROM   ' + @BaseNOI + '.dbo.RESINT' + @TablaPeriodo+@EmpresaNOI  
           SELECT @SQL2 ='SELECT RTRIM(LTRIM(CLAVE_TRAB)),UPPER(CHAR(PER_DED))+dbo.fnRellenarCerosIzquierda(NUM_PER,3),VALOR
	                   FROM   ' + @BaseNOI + '.dbo.RESINTPERDED' + @TablaPeriodo+@EmpresaNOI  	                   
  INSERT @Tabla (Personal,SueldoDiario,TotalPer,TotalDed,IMSS,ISPT,Infonavit,NetoPagado,NomEspecial)
  EXEC (@SQL)
  IF @@ERROR <>0 SET @Ok = 1

  INSERT @Tabla2 (Personal,NominaConcepto,Valor)
  EXEC (@SQL2)
  IF @@ERROR <>0 SET @Ok = 1
  
               
  SELECT @SQL3 = N'SELECT @NomEspecial = NOM_ESP  FROM   ' + @BaseNOI + '.dbo.TB' + @TablaPeriodo+@EmpresaNOI+'C' 
  EXEC sp_executesql @SQL3, N'@NomEspecial   varchar(1)  OUTPUT',  @NomEspecial OUTPUT              
                   
                
  
  UPDATE @Tabla SET NomEspecial = CASE WHEN @NomEspecial = 'S' THEN 1 ELSE 0 END 
 


  IF EXISTS (SELECT * FROM NOINomina WHERE EmpresaNOI = @EmpresaNOI AND Nomina = @TablaPeriodo AND Estacion = @Estacion) AND @Ok IS NULL
  DELETE NOINomina WHERE EmpresaNOI = @EmpresaNOI AND Nomina = @TablaPeriodo AND Estacion = @Estacion
  IF @@ERROR <>0 SET @Ok = 1
  
  IF @Ok IS NULL  
  INSERT NOINomina(Estacion,  EmpresaNOI,  Nomina,        Empresa,  Sucursal,  Tipo,  FechaD,  FechaA,  Personal,SueldoDiario,TotalPer,TotalDed,IMSS,ISPT,Infonavit,NetoPagado,Verificado,NominaEspecial )
  SELECT           @Estacion, @EmpresaNOI, @TablaPeriodo, @Empresa, @Sucursal, @Tipo, @FechaD, @FechaA, Personal,SueldoDiario,TotalPer,TotalDed,IMSS,ISPT,Infonavit,NetoPagado,1,NomEspecial
    FROM @Tabla
  IF @@ERROR <>0 SET @Ok = 1    
  
  IF EXISTS (SELECT * FROM NOINominaD WHERE EmpresaNOI = @EmpresaNOI AND Nomina = @TablaPeriodo AND Estacion = @Estacion) AND @Ok IS NULL
  DELETE NOINominaD WHERE EmpresaNOI = @EmpresaNOI AND Nomina = @TablaPeriodo AND Estacion = @Estacion
  IF @@ERROR <>0 SET @Ok = 1
  IF @Ok IS NULL  
  INSERT NOINominaD(Estacion, EmpresaNOI,  Nomina,       Personal, NominaConcepto, Valor)
  SELECT           @Estacion, @EmpresaNOI, @TablaPeriodo, Personal, NominaConcepto, Valor
    FROM @Tabla2
  IF @@ERROR <>0 SET @Ok = 1     
  
  UPDATE NOINomina 
     SET Ok = p.Ok,OkRef =p.OkRef,Verificado = p.Verificado,Nombre = p.Nombre+' '+p.ApellidoPaterno+' '+p.ApellidoMaterno
    FROM NOINomina n JOIN  NOIPersonal p ON n.Personal = p.Personal AND p.Estacion = n.Estacion AND p.Nomina = n.Nomina
   WHERE n.EmpresaNOI = @EmpresaNOI AND n.Nomina = @TablaPeriodo AND n.Estacion = @Estacion 
   
   
  IF EXISTS (SELECT * FROM NOINomina WHERE NetoPagado < 0.0 AND EmpresaNOI = @EmpresaNOI AND Nomina = @TablaPeriodo AND Estacion = @Estacion )
  UPDATE NOINomina 
     SET Ok = 30100,OkRef = 'Importe Incorrecto',Verificado = 0
   WHERE EmpresaNOI = @EmpresaNOI AND Nomina = @TablaPeriodo AND Estacion = @Estacion  AND NetoPagado <  0.0 

RETURN
END

GO
--EXEC spNOIImportarNomina 'DEMO','150110',1


/**************** spNOIGenerarConceptoNomina ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNOIGenerarConceptoNomina')           AND type = 'P') drop procedure dbo.spNOIGenerarConceptoNomina
GO             
CREATE PROCEDURE spNOIGenerarConceptoNomina
                @Empresa        varchar(5),
	        @TablaPeriodo	varchar(10),
	        @Estacion       int


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE 

     @NominaConcepto    varchar(10), 
     @Concepto          varchar(50), 
     @ConceptoOriginal  varchar(50), 
     @Movimiento        varchar(20), 
     @GravaISR          varchar(50), 
     @GravaIMSS         varchar(50), 
     @GravaImpuestoEstatal   varchar(50), 
     @Modulo            varchar(5), 
     @Estatus           varchar(15), 
     @EstatusOriginal   varchar(15), 
     @Pais              varchar(30), 
     @CuentaGrupo       varchar(20),
     @EmpresaNOI        varchar(2),
     @Ok                int


  SELECT @EmpresaNOI = EmpresaAspel
    FROM InterfaseAspel WHERE SistemaAspel = 'NOI' AND Empresa = @Empresa
  
  DECLARE crDetalle CURSOR FOR 
   SELECT   NominaConcepto, Concepto, Movimiento, GravaISR, GravaIMSS, GravaImpuestoEstatal, Modulo, Estatus, Pais, CuentaGrupo
     FROM NOINominaConcepto
    WHERE EmpresaNOI = @EmpresaNOI AND Nomina = @TablaPeriodo AND Estacion = @Estacion
  OPEN crDetalle
  FETCH NEXT FROM crDetalle INTO   @NominaConcepto, @Concepto, @Movimiento, @GravaISR, @GravaIMSS, @GravaImpuestoEstatal, @Modulo, @Estatus, @Pais, @CuentaGrupo
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL 
  BEGIN
    
    IF EXISTS(SELECT * FROM NominaConcepto WHERE  NominaConcepto = @NominaConcepto )
    BEGIN
      SELECT @ConceptoOriginal = Concepto,@EstatusOriginal = Estatus
        FROM NominaConcepto
       WHERE  NominaConcepto = @NominaConcepto
      
      IF @Concepto <> @ConceptoOriginal  OR @Estatus <> @EstatusOriginal
      
      UPDATE NominaConcepto SET
             Concepto = @Concepto , 
             Estatus =   @Estatus ,
             ConceptoNOI = 1,
             ConceptoNOIValidado = 0
       WHERE NominaConcepto =  @NominaConcepto
       IF @@ERROR <> 0 SET @Ok = 1
      
       
      IF EXISTS(SELECT * FROM CfgNominaConcepto WHERE ClaveInterna = @NominaConcepto )
      UPDATE CfgNominaConcepto SET
      ClaveInterna = @NominaConcepto,
      Descripcion = @Concepto, 
      NominaConcepto = @NominaConcepto, 
      Pais = @Pais
      WHERE  ClaveInterna = @NominaConcepto
      IF @@ERROR <> 0 SET @Ok = 1
    
    END
     
   
    IF NOT EXISTS(SELECT * FROM NominaConcepto WHERE  NominaConcepto = @NominaConcepto)
    INSERT  NominaConcepto (NominaConcepto,   Concepto,  Movimiento,   Pais,  Estatus,   CuentaGrupo,  GravaISR,  GravaIMSS,  GravaImpuestoEstatal,  Modulo,  ConceptoNOI, ConceptoNOIValidado) 
    SELECT                 @NominaConcepto , @Concepto , @Movimiento , @Pais, @Estatus , @CuentaGrupo, @GravaISR, @GravaIMSS, @GravaImpuestoEstatal, @Modulo, 1,           0
    IF @@ERROR <> 0 SET @Ok = 1
		
    IF NOT EXISTS(SELECT * FROM CfgNominaConcepto WHERE ClaveInterna = @NominaConcepto)
    INSERT CfgNominaConcepto(ClaveInterna,     Descripcion, NominaConcepto,   Pais) 
    SELECT                   @NominaConcepto , @Concepto ,  @NominaConcepto , @Pais
    IF @@ERROR <> 0 SET @Ok = 1

    FETCH NEXT FROM crDetalle INTO  @NominaConcepto, @Concepto, @Movimiento, @GravaISR, @GravaIMSS, @GravaImpuestoEstatal, @Modulo, @Estatus, @Pais, @CuentaGrupo
  END
  CLOSE crDetalle
  DEALLOCATE crDetalle
  
  IF @Ok IS NULL
  DELETE  NOINominaConcepto
   WHERE Nomina = @TablaPeriodo 
     AND EmpresaNOI = @EmpresaNOI AND Estacion = @Estacion
     
IF @Ok IS NULL
SELECT 'Conceptos Importados Correctamente'
ELSE
SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok
      
					
END
GO 
--select * from NOINominaConcepto
--spNOIGenerarConceptoNomina 'DEMO','150210',1






/**************** spNOIGenerarDepartamento ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNOIGenerarDepartamento')           AND type = 'P') drop procedure dbo.spNOIGenerarDepartamento
GO             
CREATE PROCEDURE spNOIGenerarDepartamento
                @Empresa        varchar(5),
                @Estacion       int


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE 
     @Departamento      varchar(50),
     @Sucursal          int,
     @EmpresaNOI        varchar(2),
     @Ok                int


  SELECT @EmpresaNOI = EmpresaAspel
    FROM InterfaseAspel WHERE SistemaAspel = 'NOI' AND Empresa = @Empresa
  
  DECLARE crDetalle CURSOR FOR 
   SELECT   Departamento, Sucursal
     FROM NOIDepartamento
    WHERE EmpresaNOI = @EmpresaNOI AND Estacion = @Estacion
  OPEN crDetalle
  FETCH NEXT FROM crDetalle INTO   @Departamento, @Sucursal
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL 
  BEGIN
    
    IF EXISTS(SELECT * FROM Departamento WHERE  Departamento = @Departamento)
     
      UPDATE Departamento SET
             Departamento = @Departamento , 
             Sucursal = @Sucursal
       WHERE Departamento = @Departamento 
       IF @@ERROR <> 0 SET @Ok = 1
      
 
    IF NOT EXISTS(SELECT * FROM Departamento WHERE  Departamento = @Departamento)
    INSERT  Departamento (Departamento,Sucursal)
    SELECT                 @Departamento,@Sucursal
    IF @@ERROR <> 0 SET @Ok = 1

    FETCH NEXT FROM crDetalle INTO   @Departamento, @Sucursal
  END
  CLOSE crDetalle
  DEALLOCATE crDetalle
  
  IF @Ok IS NULL
  DELETE  NOIDepartamento
    WHERE EmpresaNOI = @EmpresaNOI AND Estacion = @Estacion
IF @Ok IS NULL
SELECT 'Departamentos Importados Correctamente'
ELSE
SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok
					
END
GO 

--exec spNOIGenerarDepartamento 'DEMO'





/**************** spNOIGenerarPuestos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNOIGenerarPuestos')           AND type = 'P') drop procedure dbo.spNOIGenerarPuestos
GO             
CREATE PROCEDURE spNOIGenerarPuestos
                @Empresa        varchar(5),
                @Estacion       int


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE 
     @Puesto            varchar(50),
     @SueldoRangoMinimo float,
     @SueldoRangoMaximo float,     
     @Sucursal          int,
     @EmpresaNOI        varchar(2),
     @Ok                int


  SELECT @EmpresaNOI = EmpresaAspel
    FROM InterfaseAspel WHERE SistemaAspel = 'NOI' AND Empresa = @Empresa
  
  DECLARE crDetalle CURSOR FOR 
   SELECT   Puesto,SueldoRangoMinimo,SueldoRangoMaximo
     FROM NOIPuestos
    WHERE EmpresaNOI = @EmpresaNOI AND Estacion = @Estacion
  OPEN crDetalle
  FETCH NEXT FROM crDetalle INTO   @Puesto,@SueldoRangoMinimo,@SueldoRangoMaximo
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL 
  BEGIN
    
    IF EXISTS(SELECT * FROM Puesto WHERE  Puesto = @Puesto)
     
      UPDATE Puesto SET
             Puesto = @Puesto , 
             SueldoRangoMinimo = @SueldoRangoMinimo,
             SueldoRangoMaximo = @SueldoRangoMaximo
       WHERE Puesto = @Puesto
       IF @@ERROR <> 0 SET @Ok = 1
      
 
    IF NOT EXISTS(SELECT * FROM Puesto WHERE  Puesto = @Puesto)
    INSERT  Puesto (Puesto,  SueldoDef,  SueldoRangoMaximo)
    SELECT          @Puesto, @SueldoRangoMinimo, @SueldoRangoMaximo
    IF @@ERROR <> 0 SET @Ok = 1

    FETCH NEXT FROM crDetalle INTO  @Puesto,@SueldoRangoMinimo,@SueldoRangoMaximo
  END
  CLOSE crDetalle
  DEALLOCATE crDetalle
  
  IF @Ok IS NULL
  DELETE  NOIPuestos
    WHERE EmpresaNOI = @EmpresaNOI AND Estacion = @Estacion
    
IF @Ok IS NULL
SELECT 'Puestos Importados Correctamente'
ELSE
SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok
    
				  
					
END
GO 

--spNOIGenerarPuestos 'DEMO'
/**************** spNOIGenerarPersonal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNOIGenerarPersonal')           AND type = 'P') drop procedure dbo.spNOIGenerarPersonal
GO             
CREATE PROCEDURE spNOIGenerarPersonal
                @Empresa        varchar(5),
                @TablaPeriodo	varchar(10),
                @Usuario        varchar(10),
	        @Estacion       int,
	        @Generar        bit =NULL,
	        @Mensaje        bit =NULL OUTPUT,
	        @Ok             int =NULL  OUTPUT, 
                @OkRef          varchar(255)=NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE 

     
     @EmpresaNOI        varchar(2),
     @Sucursal          int,
     @Nomina            varchar(10), 
     @Personal          varchar(10), 
     @Nombre            varchar(30), 
     @ApellidoPaterno   varchar(30), 
     @ApellidoPaternoO  varchar(30), 
     @ApellidoMaterno   varchar(30), 
     @ApellidoMaternoO  varchar(30), 
     @Estatus           varchar(15), 
     @Registro2         varchar(30), 
     @Registro2O        varchar(30), 
     @Departamento      varchar(50), 
     @DepartamentoO     varchar(50), 
     @Puesto            varchar(50), 
     @Registro3         varchar(30),    
     @Registro3O        varchar(30),    
     @FechaAlta         datetime   , 
     @FechaAltaO        datetime   , 
     @FechaBaja         datetime   , 
     @FormaPago         varchar(50), 
     @FormaPagoO        varchar(50), 
     @SueldoDiario      money   , 
     @SueldoDiarioO     money   , 
     @SDI               money   ,       
     @SDIO              money   ,       
     @TipoSueldo        varchar(10),    
     @TipoSueldoO       varchar(10),    
     @Direccion         varchar(100), 
     @DireccionO        varchar(100), 
     @Colonia           varchar(100), 
     @ColoniaO          varchar(100), 
     @Poblacion         varchar(100), 
     @PoblacionO        varchar(100), 
     @Estado            varchar(30),    
     @EstadoO           varchar(30),    
     @CodigoPostal      varchar(15), 
     @CtaDinero         varchar(10), 
     @PersonalCuenta    varchar(20), 
     @LugarNacimiento   varchar(50), 
     @Tipo              varchar(20), 
     @TipoContrato      varchar(50), 
     @EstadoCivil       varchar(20), 
     @UnidadMedica      int   ,         
     @Padre             varchar(50), 
     @Madre             varchar(50), 
     @Telefono          varchar(50), 
     @Sexo              varchar(10), 
     @FechaNacimiento   datetime   , 
     @Registro          varchar(30), 
     @RegistroO         varchar(30), 
     @Email             varchar(50), 
     @Jornada           varchar(20), 
     @PeriodoTipo       varchar(20), 
     @ZonaEconomica     varchar(30), 
     @Moneda            varchar(10), 
     @Fecha             datetime   ,
     @MovAlta           varchar(20), 
     @MovBaja           varchar(20), 
     @MovCambio         varchar(20),
     @IDAlta            int,
     @IDBaja            int,
     @IDCambio          int,
     @TipoCambio        float ,
     @Renglon           float,
     @FechaBaja2        datetime    
     
     
     
     
     DECLARE
     @Alta table(
     Renglon   float,
     Personal  varchar(10))
     
     DECLARE
     @Baja table(
     Renglon   float,
     Personal  varchar(10),
     FechaBaja datetime)
     
      DECLARE
     @Cambio table(
     Renglon   float,
     Personal  varchar(10))


  SELECT @Fecha = dbo.fnFechaSinHora(GETDATE())
  SELECT @EmpresaNOI = EmpresaAspel,@Sucursal = SucursalIntelisis
    FROM InterfaseAspel WHERE SistemaAspel = 'NOI' AND Empresa = @Empresa
    
  SELECT @Moneda = Moneda
    FROM InterfaseAspelNOI WHERE  Empresa = @Empresa    
    
    
  SELECT @TipoCambio = TipoCambio 
    FROM Mon WHERE Moneda = @Moneda     
  
  SELECT @MovAlta = RHAltas ,@MovBaja = RHBajas, @MovCambio= RHModificaciones
    FROM EmpresaCfgMov WHERE Empresa = @Empresa   

  IF NOT EXISTS(SELECT * FROM NOIPersonal WHERE Ok IS NOT NULL AND Estacion = @Estacion)
  BEGIN
    DECLARE crDetalle CURSOR FOR 
     SELECT LTRIM(RTRIM(Personal)), Nombre, ApellidoPaterno, ApellidoMaterno, RTRIM(LTRIM(Estatus)), Registro2, Departamento, Puesto, Registro3, FechaAlta, FechaBaja, FormaPago, SueldoDiario, SDI, TipoSueldo, Direccion, Colonia, Poblacion, Estado, CodigoPostal, CtaDinero, PersonalCuenta, LugarNacimiento, Tipo, TipoContrato, EstadoCivil, UnidadMedica, Padre, Madre, Telefono, Sexo, FechaNacimiento, Registro, Email, Jornada, PeriodoTipo, ZonaEconomica, Moneda 
       FROM NOIPersonal
      WHERE EmpresaNOI = @EmpresaNOI 
        AND Nomina = @TablaPeriodo 
        AND Verificado = 1
        AND Estacion = @Estacion
    OPEN crDetalle
    FETCH NEXT FROM crDetalle INTO  @Personal, @Nombre, @ApellidoPaterno, @ApellidoMaterno, @Estatus, @Registro2, @Departamento, @Puesto, @Registro3, @FechaAlta, @FechaBaja, @FormaPago, @SueldoDiario, @SDI, @TipoSueldo, @Direccion, @Colonia, @Poblacion, @Estado, @CodigoPostal, @CtaDinero, @PersonalCuenta, @LugarNacimiento, @Tipo, @TipoContrato, @EstadoCivil, @UnidadMedica, @Padre, @Madre, @Telefono, @Sexo, @FechaNacimiento, @Registro, @Email, @Jornada, @PeriodoTipo, @ZonaEconomica, @Moneda
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL 
    BEGIN
       
      IF NOT EXISTS (SELECT * FROM Personal WHERE Personal = @Personal) 
      BEGIN
     
        INSERT Personal (Personal,  Nombre,  ApellidoPaterno,  ApellidoMaterno,  Estatus,     Registro2,  Departamento,  Puesto,  Registro3,  FechaAlta,  FechaBaja,  FormaPago,  SueldoDiario,  SDI,  TipoSueldo,  Direccion,  Colonia,  Poblacion,  Estado,  CodigoPostal,  CtaDinero,  PersonalCuenta,  LugarNacimiento,  Tipo,  TipoContrato,  EstadoCivil,  UnidadMedica,  Padre,  Madre,  Telefono,  Sexo,  FechaNacimiento,  Registro,  Email,  Jornada,  PeriodoTipo,  ZonaEconomica,  Moneda, SucursalTrabajo,FechaAntiguedad, DiasPeriodo  )
        SELECT           @Personal, @Nombre, @ApellidoPaterno, @ApellidoMaterno, 'ASPIRANTE', @Registro2, @Departamento, @Puesto, @Registro3, @FechaAlta, @FechaBaja, @FormaPago, @SueldoDiario, @SDI, @TipoSueldo, @Direccion, @Colonia, @Poblacion, @Estado, @CodigoPostal, @CtaDinero, @PersonalCuenta, @LugarNacimiento, @Tipo, @TipoContrato, @EstadoCivil, @UnidadMedica, @Padre, @Madre, @Telefono, @Sexo, @FechaNacimiento, @Registro, @Email, @Jornada, @PeriodoTipo, @ZonaEconomica, @Moneda, @Sucursal,     @FechaAlta,      'Dias Periodo'
        IF @@ERROR <> 0 SET @Ok = 1
        
        IF @Ok IS NULL
        INSERT @Alta(Personal)
        SELECT @Personal
        IF @@ERROR <> 0 SET @Ok = 1
        

      END
      IF EXISTS (SELECT * FROM Personal WHERE Personal = @Personal)
      BEGIN
        IF @Estatus = 'ALTA'
        BEGIN
          SELECT @ApellidoPaternoO=ApellidoPaterno,
                  @ApellidoMaternoO=ApellidoMaterno,
                  @Registro2O=Registro2,
                  @DepartamentoO=Departamento,
                  @RegistroO=Registro,
                  @Registro3O=Registro3,
                  @FechaAltaO=FechaAlta,
                  @FormaPagoO=FormaPago,
                  @SueldoDiarioO=SueldoDiario,
                  @SDIO=SDI,
                  @TipoSueldoO=TipoSueldo,
                  @DireccionO=Direccion,
                  @ColoniaO=Colonia,
                  @PoblacionO=Poblacion,
                  @EstadoO=Estado
            FROM Personal 
           WHERE Personal = @Personal 
           
           IF  @ApellidoPaternoO  <> @ApellidoPaterno   OR
               @ApellidoMaternoO  <> @ApellidoMaterno   OR
               @Registro2O  <> @Registro2   OR
               @DepartamentoO  <> @Departamento   OR
               @RegistroO  <> @Registro   OR
               @Registro3O  <> @Registro3   OR
               @FechaAltaO  <> @FechaAlta   OR
               @FormaPagoO  <> @FormaPago   OR
               @SueldoDiarioO  <> @SueldoDiario   OR
               @SDIO  <> @SDI   OR
               @TipoSueldoO  <> @TipoSueldo   OR
               @DireccionO  <> @Direccion   OR
               @ColoniaO  <> @Colonia   OR
               @PoblacionO  <> @Poblacion   OR
               @EstadoO  <> @Estado
          BEGIN
            UPDATE Personal SET ApellidoPaterno   =  @ApellidoPaterno, ApellidoMaterno   =  @ApellidoMaterno,  Registro2   =  @Registro2, Departamento   =  @Departamento, Registro   =  @Registro, FechaAlta   =  @FechaAlta, FechaAntiguedad = @FechaAlta,  FormaPago   =  @FormaPago, SueldoDiario   =  @SueldoDiario, SDI   =  @SDI, TipoSueldo   =  @TipoSueldo, Direccion   =  @Direccion, Colonia   =  @Colonia, Poblacion   =  @Poblacion, Estado   =  @Estado, SucursalTrabajo = @Sucursal
             WHERE Personal = @Personal
            IF @@ERROR <> 0 SET @Ok = 1
            
            IF @Ok IS NULL 
            INSERT @Cambio(Personal)
            SELECT @Personal  
            IF @@ERROR <> 0 SET @Ok = 1
                    
          END  

        END
        IF @Estatus = 'BAJA'
        BEGIN
    
          INSERT @Baja (Personal,FechaBaja)
          SELECT @Personal,@FechaBaja
          IF @@ERROR <> 0 SET @Ok = 1
          
        END        
      
      END
      FETCH NEXT FROM crDetalle INTO  @Personal, @Nombre, @ApellidoPaterno, @ApellidoMaterno, @Estatus, @Registro2, @Departamento, @Puesto, @Registro3, @FechaAlta, @FechaBaja, @FormaPago, @SueldoDiario, @SDI, @TipoSueldo, @Direccion, @Colonia, @Poblacion, @Estado, @CodigoPostal, @CtaDinero, @PersonalCuenta, @LugarNacimiento, @Tipo, @TipoContrato, @EstadoCivil, @UnidadMedica, @Padre, @Madre, @Telefono, @Sexo, @FechaNacimiento, @Registro, @Email, @Jornada, @PeriodoTipo, @ZonaEconomica, @Moneda
    END
    CLOSE crDetalle
    DEALLOCATE crDetalle
  END  

  IF EXISTS(SELECT * FROM NOIPersonal WHERE Ok IS NOT NULL AND Estacion = @Estacion)
  SELECT TOP 1 @Ok = Ok FROM NOIPersonal WHERE Ok IS NOT NULL
    
  BEGIN TRANSACTION
    IF @Ok IS NULL AND EXISTS (SELECT * FROM @Alta)
    BEGIN
      SET @Renglon = 0.0
      UPDATE @Alta
           SET @Renglon = Renglon = @Renglon + 2048.0
          FROM @Alta  
      IF @@ERROR <> 0 SET @Ok = 1 
      
      IF @Ok IS NULL
      INSERT RH (UltimoCambio, Sucursal, SucursalOrigen, SucursalDestino, Empresa,  Usuario,  Estatus,      Mov,      FechaEmision,  Moneda,  TipoCambio)
      SELECT     GETDATE(),   @Sucursal, @Sucursal,      @Sucursal,       @Empresa, @Usuario, 'SINAFECTAR',   @MovAlta, @Fecha, @Moneda, @TipoCambio 
      SELECT @IDAlta = SCOPE_IDENTITY() 
      IF @@ERROR <> 0 SET @Ok = 1 
      
      IF @Ok IS NULL   
      INSERT RHD (ID,  Renglon, Sucursal, SucursalOrigen, Personal,   SueldoDiario,   SueldoDiarioComplemento,   SDI,   TipoContrato,   PeriodoTipo,   Jornada,   TipoSueldo,   Categoria,   Departamento,   Puesto,   Grupo,   FechaAlta,   FechaAntiguedad,   SucursalTrabajo,   ReportaA,   CentroCostos,   VencimientoContrato,   Plaza)
      SELECT @IDAlta, a.Renglon,  @Sucursal,  @Sucursal,      a.Personal, p.SueldoDiario, p.SueldoDiarioComplemento, p.SDI, p.TipoContrato, p.PeriodoTipo, p.Jornada, p.TipoSueldo, p.Categoria, p.Departamento, p.Puesto, p.Grupo, p.FechaAlta, p.FechaAntiguedad, p.SucursalTrabajo, p.ReportaA, p.CentroCostos, p.VencimientoContrato, p.Plaza
        FROM @Alta a JOIN Personal p ON a.Personal = p.Personal
      IF @@ERROR <> 0 SET @Ok = 1 
           
      IF @Ok IS NULL  AND @IDAlta IS NOT NULL
      EXEC spAfectar 'RH', @IDAlta, 'AFECTAR', 'Todo', NULL, @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      
      IF @Ok IS NULL AND @Mensaje IS NULL AND @IDAlta IS NOT NULL
      SELECT @Mensaje = 1
    END   
    IF @Ok IS NULL AND EXISTS (SELECT * FROM @Cambio)
    BEGIN
      SET @Renglon = 0.0
      UPDATE @Cambio
           SET @Renglon = Renglon = @Renglon + 2048.0
          FROM @Cambio  
      IF @@ERROR <> 0 SET @Ok = 1 
        
      IF @Ok IS NULL
      INSERT RH (UltimoCambio, Sucursal, SucursalOrigen, SucursalDestino, Empresa,  Usuario,  Estatus,      Mov,      FechaEmision,  Moneda,  TipoCambio)
      SELECT     GETDATE(),   @Sucursal, @Sucursal,      @Sucursal,       @Empresa, @Usuario, 'SINAFECTAR',   @MovCambio, @Fecha, @Moneda, @TipoCambio 
      SELECT @IDCambio = SCOPE_IDENTITY() 
      IF @@ERROR <> 0 SET @Ok = 1 
      
      IF @Ok IS NULL   
      INSERT RHD (ID,  Renglon, Sucursal, SucursalOrigen, Personal,   SueldoDiario,   SueldoDiarioComplemento,   SDI,   TipoContrato,   PeriodoTipo,   Jornada,   TipoSueldo,   Categoria,   Departamento,   Puesto,   Grupo,   FechaAlta,   FechaAntiguedad,   SucursalTrabajo,   ReportaA,   CentroCostos,   VencimientoContrato,   Plaza)
      SELECT @IDCambio, a.Renglon,  @Sucursal,  @Sucursal,      a.Personal, p.SueldoDiario, p.SueldoDiarioComplemento, p.SDI, p.TipoContrato, p.PeriodoTipo, p.Jornada, p.TipoSueldo, p.Categoria, p.Departamento, p.Puesto, p.Grupo, p.FechaAlta, p.FechaAntiguedad, p.SucursalTrabajo, p.ReportaA, p.CentroCostos, p.VencimientoContrato, p.Plaza
        FROM @Cambio a JOIN Personal p ON a.Personal = p.Personal
      IF @@ERROR <> 0 SET @Ok = 1      

      IF @Ok IS NULL  AND @IDCambio IS NOT NULL
      EXEC spAfectar 'RH', @IDCambio, 'AFECTAR', 'Todo', NULL, @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT  
      
      IF @Ok IS NULL AND @Mensaje IS NULL AND @IDCambio IS NOT NULL
      SELECT @Mensaje = 1      
             
    END   
 
    IF @Ok IS NULL AND EXISTS (SELECT * FROM @Baja)
    BEGIN
      SET @Renglon = 0.0
      UPDATE @Baja
           SET @Renglon = Renglon = @Renglon + 2048.0
          FROM @Baja  
        IF @@ERROR <> 0 SET @Ok = 1 

      DECLARE crBaja CURSOR FOR 
       SELECT FechaBaja
         FROM @Baja
      GROUP BY  FechaBaja  
    
      OPEN crBaja
      FETCH NEXT FROM crBaja INTO @FechaBaja2
      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
      BEGIN
        SELECT @FechaBaja2 = dbo.fnFechaSinHora(@FechaBaja2)
        IF @Ok IS NULL
        INSERT RH (UltimoCambio, Sucursal, SucursalOrigen, SucursalDestino, Empresa,  Usuario,  Estatus,      Mov,        FechaEmision,  Moneda,  TipoCambio)
        SELECT     GETDATE(),   @Sucursal, @Sucursal,      @Sucursal,       @Empresa, @Usuario, 'SINAFECTAR',   @MovBaja, @FechaBaja2,   @Moneda, @TipoCambio 
        SELECT @IDBaja = SCOPE_IDENTITY() 
        IF @@ERROR <> 0 SET @Ok = 1 
        
        IF @Ok IS NULL   
        INSERT RHD (ID,  Renglon, Sucursal, SucursalOrigen, Personal)
        SELECT @IDBaja, a.Renglon,  @Sucursal,  @Sucursal,      a.Personal
          FROM @Baja a JOIN Personal p ON a.Personal = p.Personal
         WHERE a.FechaBaja = @FechaBaja2
        IF @@ERROR <> 0 SET @Ok = 1    
        
        SET @Renglon = 0.0
        UPDATE RHD
           SET @Renglon = Renglon = @Renglon + 2048.0
          FROM RHD
         WHERE ID = @IDBaja
       
        IF @Ok IS NULL  AND @IDBaja IS NOT NULL
        EXEC spAfectar 'RH', @IDBaja, 'AFECTAR', 'Todo', NULL, @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT   
        
        IF @Ok IS NULL AND @Mensaje IS NULL AND @IDBaja IS NOT NULL
        SELECT @Mensaje = 1          
               
        FETCH NEXT FROM crBaja INTO @FechaBaja2
      END
      CLOSE crBaja
      DEALLOCATE crBaja      
    END   

  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION
    DELETE NOIPersonal
    WHERE EmpresaNOI = @EmpresaNOI AND Estacion = @Estacion AND Nomina = @TablaPeriodo 
    IF @Mensaje = 1 AND @Generar IS NULL
    SELECT 'Se Generaron Los Movimientos En El Modulo RH'
    ELSE
    IF ISNULL(@Mensaje,0) = 0 AND @Generar IS NULL 
    SELECT 'Se Actualizo La Informacion Correctamente' 
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT Descripcion+' '+ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok  
  END

RETURN    
				
END
GO 




--EXEC spNOIGenerarPersonal 'DEMO','DEMO','300110'


/**************** spNOIGenerarNomina ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNOIGenerarNomina')           AND type = 'P') drop procedure dbo.spNOIGenerarNomina
GO             
CREATE PROCEDURE spNOIGenerarNomina
                @Empresa        varchar(5),
	        @TablaPeriodo	varchar(10),
	        @Usuario     	varchar(10),
	        @Estacion       int,
	        @Mov            varchar(20)


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE 

     @ID                int,
     @EmpresaNOI        varchar(2),
     @Concepto          varchar(50),  
     @ConceptoDIN       varchar(50),  
     @Mon               varchar(10), 
     @Tipo              varchar(20),  
     @Fecha             datetime,    
     @FechaNomina       datetime,    
     @FechaD            datetime,    
     @FechaA            datetime, 
     @Sucursal          int, 
     @Renglon           float,  
     @Plaza             varchar(20),  
     @Personal          varchar(10), 
     @Cuenta            varchar(10), 
     @CuentaContable    varchar(20), 
     @Importe           float,
     @NominaConcepto    varchar(10),  
     @Movimiento        varchar(20),
     @Beneficiario      varchar(100), 
     @FormaPago         varchar(50), 
     @BaseNOI           varchar(50),
     @SQL               varchar(max),
     @Mensaje           bit,
     @Ok                int,
     @OkRef             varchar(100)
     
   
  SELECT @Mensaje = NULL
 
  SELECT @Fecha = dbo.fnFechaSinHora(GETDATE())

  SELECT @FechaNomina = CONVERT(datetime,SUBSTRING(@TablaPeriodo,1,2)+'/'+SUBSTRING(@TablaPeriodo,3,2)+'/'++SUBSTRING(@TablaPeriodo,5,2))

  SELECT @EmpresaNOI = EmpresaAspel,@Sucursal = SucursalIntelisis,@BaseNOI = '['+Servidor +'].'+BaseDatosNombre
    FROM InterfaseAspel WHERE SistemaAspel = 'NOI' AND Empresa = @Empresa
    
  SELECT @Mon = Moneda, @Tipo = TipoPeriodo,@ConceptoDIN = ConceptoDIN, @Concepto = Concepto
    FROM InterfaseAspelNOI WHERE  Empresa = @Empresa    
  
  IF @Mov IS NULL  
  SELECT @Mov = MovNomina
    FROM InterfaseAspelNOI WHERE  Empresa = @Empresa       
    
  SELECT @FechaD = FechaD ,@FechaA = FechaA  FROM NOITablaPeriodo WHERE Nomina = @TablaPeriodo AND Estacion = @Estacion
    
  IF EXISTS (SELECT * FROM NOINomina WHERE Verificado = 0 AND EmpresaNOI = @EmpresaNOI AND Nomina = @TablaPeriodo   AND Estacion = @Estacion AND @Ok <> 30100)
  BEGIN
    SELECT @Ok = 1,@OkRef= 'Hay Personal No Validado'
  END
  
  IF  EXISTS(SELECT NominaConcepto FROM NOINominaConcepto WHERE Estacion = @Estacion AND Nomina = @TablaPeriodo  EXCEPT SELECT  NominaConcepto FROM  NominaConcepto)
  BEGIN
    SELECT @OK = 1,@OkRef='Es Necesario Importar Los Conceptos'
  END
  
  
  IF @Ok IS NULL
  EXEC spNOIGenerarPersonal  @Empresa, @TablaPeriodo, @Usuario, @Estacion,1,@Mensaje   OUTPUT ,@Ok  OUTPUT, @OkRef  OUTPUT 
  
  
       
   
  SET @Renglon = 2048.0   
  

  
  IF @Ok IS NULL
  INSERT Nomina(Empresa,  Mov,  FechaEmision, Concepto,  Moneda, TipoCambio, Usuario, Estatus,     PeriodoTipo, FechaD,  FechaA,  Sucursal,  FechaOrigen, NOI)
  SELECT        @Empresa, @Mov, @Fecha,       @Concepto, @Mon,   1,          @Usuario, 'BORRADOR', @Tipo,       @FechaD, @FechaA, @Sucursal, @Fecha,      1
  SELECT @ID = SCOPE_IDENTITY()
  IF @@ERROR <> 0 SET @Ok = 1

   
   IF @Ok IS NULL
   BEGIN
   
     DECLARE crNomina CURSOR FOR 
      SELECT p.Plaza,RTRIM(LTRIM(d.Personal)),d.Valor,n.Concepto, d.NominaConcepto,n.Movimiento, n.Cuenta  
        FROM NOINominaD d JOIN Personal p ON RTRIM(LTRIM(d.Personal)) = RTRIM(LTRIM(p.Personal)) 
        JOIN NominaConcepto n ON n.NominaConcepto = d.NominaConcepto
      WHERE d.EmpresaNOI = @EmpresaNOI AND d.Nomina = @TablaPeriodo   AND d.Estacion = @Estacion
        AND d.Valor > 0.0 

      OPEN crNomina
      FETCH NEXT FROM crNomina INTO @Plaza, @Personal, @Importe, @Concepto, @NominaConcepto, @Movimiento, @Cuentacontable
      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
      BEGIN
      
        INSERT NominaD (ID,  Sucursal,  Renglon, Modulo,    Personal,  NominaConcepto,   Movimiento,    Concepto,   Importe,  CuentaContable, ContUso,Cuenta)
        SELECT @ID, @Sucursal,@Renglon,    nc.Modulo,     @Personal, @NominaConcepto, nc.Movimiento, nc.Concepto, @Importe, @Cuentacontable,(SELECT CentroCostos FROM Personal WHERE Personal = @Personal),AcreedorDef
          FROM NominaConcepto nc 
         WHERE nc.NominaConcepto = @NominaConcepto

        IF @@ERROR <> 0 SET  @Ok = 1
        SET @Renglon = @Renglon + 2048.0
      FETCH NEXT FROM crNomina INTO @Plaza, @Personal, @Importe, @Concepto, @NominaConcepto, @Movimiento, @Cuentacontable
      END
      CLOSE crNomina
      DEALLOCATE crNomina   
    END    

   IF @Ok IS NULL
   BEGIN
     
     DECLARE crNomina2 CURSOR FOR 
      SELECT p.Plaza,RTRIM(LTRIM(d.Personal)),p.CtaDinero,d.NetoPagado,p.ApellidoPaterno+' '+p.ApellidoMaterno+' '+p.Nombre,p.FormaPago,f.MovEgresos
        FROM NOINomina d JOIN Personal p ON RTRIM(LTRIM(d.Personal)) = RTRIM(LTRIM(p.Personal))  
        JOIN FormaPago f ON p.FormaPago = f.FormaPago
      WHERE d.EmpresaNOI = @EmpresaNOI AND d.Nomina = @TablaPeriodo AND d.Estacion = @Estacion AND d.NetoPagado >= 0.0
      SELECT @Renglon = MAX(ISNULL(Renglon,0))+2048.0 FROM NominaD WHERE ID = @ID
      SELECT @Renglon = ISNULL(@Renglon,2048.0)
      OPEN crNomina2
      FETCH NEXT FROM crNomina2 INTO @Plaza, @Personal, @Cuenta,@Importe, @Beneficiario, @FormaPago, @Movimiento
      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
      BEGIN
            
        INSERT NominaD(ID, Sucursal,   Renglon,  Modulo, Plaza, Personal,  Cuenta,     Importe,   Beneficiario,  FormaPago,  Movimiento, Concepto,NominaConcepto, CuentaContable, ContUso)    
        SELECT         @ID, @Sucursal, @Renglon, Modulo, @Plaza, @Personal,AcreedorDef,@Importe, @Beneficiario, @FormaPago, Movimiento, Concepto ,@ConceptoDIN, dbo.fnNominaCuentaContable (CuentaBase, Cuenta, @Personal, NominaConcepto, @Cuenta, @Empresa), (SELECT CentroCostos FROM Personal WHERE Personal = @Personal)
          FROM NominaConcepto 
         WHERE  NominaConcepto = @ConceptoDIN
        IF @@ERROR <> 0 SET  @Ok = 1
        
        SET @Renglon = @Renglon + 2048.0
      FETCH NEXT FROM crNomina2 INTO @Plaza, @Personal, @Cuenta,@Importe, @Beneficiario, @FormaPago, @Movimiento
      END
      CLOSE crNomina2
      DEALLOCATE crNomina2   
    END 
	
  IF @Ok IS NULL
  BEGIN
    SET ANSI_NULLS ON
    SET ANSI_WARNINGS ON
    SELECT @SQL =' UPDATE ' + @BaseNOI + '.dbo.INTELISIS' + @EmpresaNOI +' SET  INTELISIS = 1 WHERE FECH_NOM_INI = '+CHAR(39)+dbo.fnFormatearFecha(@FechaD,'DD/MM/AAAA')+CHAR(39)+' AND FECH_NOM_FIN = '+CHAR(39)+dbo.fnFormatearFecha(@FechaA,'DD/MM/AAAA')+CHAR(39)
    EXEC (@SQL)		
    IF @@ERROR <> 0 SET @Ok = 1  
  END  
  
  IF @OkRef IS NULL AND @Ok IS NOT NULL 
  SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok  
 
  IF @Ok IS NULL 
  BEGIN
    IF @Mensaje IS NULL
    SELECT 'Se Generaron Los Movimientos En El Modulo De Nomina '
    ELSE
    SELECT 'Se Generaron Los Movimientos En Los Modulos De Nomina y RH '
    
    DELETE   NOINomina
    WHERE EmpresaNOI = @EmpresaNOI AND Estacion = @Estacion AND Nomina = @TablaPeriodo 
    
    DELETE   NOINominaD
    WHERE EmpresaNOI = @EmpresaNOI AND Estacion = @Estacion AND Nomina = @TablaPeriodo 
    
  
  END  
  ELSE
  SELECT @OkRef				
END
GO



/**************** spNOITablaPeriodo ****************/
if exists (SELECT * FROM sysobjects where id = object_id('dbo.spNOITablaPeriodo') and type = 'P') drop procedure dbo.spNOITablaPeriodo
GO             
CREATE PROCEDURE spNOITablaPeriodo
		
			@Empresa       varchar(5),
			@Estacion      int
			


--//WITH ENCRYPTION
AS BEGIN

DECLARE @BaseNOI        varchar (100),
        @EmpresaNOI     varchar(2),
        @TipoPeriodo    varchar(50),
        @SQL            varchar(max),
        @Fecha          datetime,
        @FechaD         datetime,
        @FechaA         datetime
        
  DECLARE         
  @Tabla2 table (FechaD datetime, FechaA datetime)
 


  set dateformat dmy
 
  SELECT @BaseNOI = '['+Servidor +'].'+BaseDatosNombre,@EmpresaNOI = EmpresaAspel
    FROM InterfaseAspel WHERE SistemaAspel = 'NOI' AND Empresa = @Empresa

  SELECT @TipoPeriodo = TipoPeriodo
    FROM InterfaseAspelNOI WHERE  Empresa = @Empresa  
  
  SET ANSI_NULLS ON
  SET ANSI_WARNINGS ON

  SELECT @SQL = 'IF  EXISTS (SELECT * FROM' + @BaseNOI + '.dbo.INTELISIS' + @EmpresaNOI +'
                   WHERE INTELISIS = 0)
           SELECT FECH_NOM_INI,FECH_NOM_FIN
                   FROM ' + @BaseNOI + '.dbo.INTELISIS' + @EmpresaNOI +'
                   WHERE INTELISIS = 0'
  INSERT @Tabla2 (FechaD,FechaA)
  EXEC (@SQL)                   
      
  IF EXISTS (SELECT * FROM NOITablaPeriodo WHERE Estacion = @Estacion)
  DELETE NOITablaPeriodo WHERE Estacion = @Estacion


        
  INSERT NOITablaPeriodo (Estacion, Nomina,                                FechaD, FechaA)
  SELECT                 @Estacion, dbo.fnFormatearFecha(FechaA,'DDMMAA'), FechaD, FechaA
    FROM @Tabla2


 RETURN
 END
GO


--exec spNOITablaPeriodo 'DEMO',1

/**************** spNOITablaPeriodo2 ****************/
if exists (SELECT * FROM sysobjects where id = object_id('dbo.spNOITablaPeriodo2') and type = 'P') drop procedure dbo.spNOITablaPeriodo2
GO             
CREATE PROCEDURE spNOITablaPeriodo2
		
			@Empresa       varchar(5),
			@Estacion      int
			


--//WITH ENCRYPTION
AS BEGIN

DECLARE @BaseNOI        varchar (100),
        @EmpresaNOI     varchar(2),
        @TipoPeriodo    varchar(50),
        @SQL            varchar(max),
        @Fecha          datetime,
        @FechaD         datetime,
        @FechaA         datetime
        



  set dateformat dmy
  DELETE NOITablaPeriodo WHERE Estacion = @Estacion


        
  INSERT NOITablaPeriodo (Estacion, Nomina,                                FechaD, FechaA)
  SELECT  @Estacion, dbo.fnFormatearFecha(FechaA,'DDMMAA'), FechaD, FechaA
    FROM NOINominaGenerada
   WHERE Empresa = @Empresa
  GROUP BY FechaD, FechaA 


 RETURN
 END
GO



/**************** spNOINominaEspecial ****************/
if exists (SELECT * FROM sysobjects where id = object_id('dbo.spNOINominaEspecial') and type = 'P') drop procedure dbo.spNOINominaEspecial
GO             
CREATE PROCEDURE spNOINominaEspecial
		
			@Estacion      int
			


--//WITH ENCRYPTION
AS BEGIN
                
      
  IF EXISTS (SELECT * FROM NOINominaEspecial WHERE Estacion = @Estacion)
  DELETE NOINominaEspecial WHERE Estacion = @Estacion

 RETURN
 END
GO


--exec spNOITablaPeriodo 'DEMO',1




/**************** spNOIImportarCatalogos ****************/
if exists (SELECT * FROM sysobjects where id = object_id('dbo.spNOIImportarCatalogos') and type = 'P') drop procedure dbo.spNOIImportarCatalogos
GO             
CREATE PROCEDURE spNOIImportarCatalogos
		
			@Empresa       varchar(5),
			@TablaPeriodo  varchar(10),
			@Estacion      int,
			@FechaA        datetime
			


--//WITH ENCRYPTION
AS BEGIN

  EXEC spNOIImportarConceptoNomina @Empresa,@TablaPeriodo,@Estacion
  EXEC spNOIImportarDepartamento @Empresa,@Estacion
  EXEC spNOIImportarPuestos @Empresa,@Estacion
  EXEC spNOIImportarPersonal @Empresa,@TablaPeriodo,@Estacion, @FechaA
  EXEC spNOIImportarNomina @Empresa,@TablaPeriodo,@Estacion
  

 END
go

--EXEC spNOIImportarConceptoNomina 'DEMO','150110',1









/**************** spNOIBorrarNomina ****************/
if exists (SELECT * FROM sysobjects where id = object_id('dbo.spNOIBorrarNomina') and type = 'P') drop procedure dbo.spNOIBorrarNomina
GO             
CREATE PROCEDURE spNOIBorrarNomina
		
			@Empresa       varchar(5),
			@Estacion      int
			


--//WITH ENCRYPTION
AS BEGIN

  DELETE NOIParamNominaGenerada WHERE Estacion = @Estacion

 RETURN
 END
GO


/**************** fnNOIValidarImporte ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnNOIValidarImporte') DROP FUNCTION fnNOIValidarImporte
GO
CREATE FUNCTION dbo.fnNOIValidarImporte
(@EmpresaNOI     varchar(2),@Estacion  int,@TablaPeriodo  varchar(10)) 
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
DECLARE 
    @Resultado  bit
    SET @Resultado = 0
    
    IF EXISTS(SELECT * FROM NOINomina WHERE NetoPagado <0.0  AND EmpresaNOI = @EmpresaNOI AND Nomina = @TablaPeriodo AND Estacion = @Estacion)
    SELECT @Resultado = 1

  RETURN (@Resultado)
 END

GO

--SELECT dbo.fnNOIValidarImporte('01',1,'150210')

/**************** spNOICancelarNomina ****************/
if exists (SELECT * FROM sysobjects where id = object_id('dbo.spNOICancelarNomina') and type = 'P') drop procedure dbo.spNOICancelarNomina
GO             
CREATE PROCEDURE spNOICancelarNomina
		
			@Empresa       varchar(5),
			@Estacion      int,
			@ID            int,
			@Usuario       varchar(10),
			@FechaA        datetime
			


--//WITH ENCRYPTION
AS BEGIN

DECLARE @BaseNOI        varchar (100),
        @EmpresaNOI     varchar(2),
        @Estatus        varchar(15),
        @SQL            varchar(max),
        @Ok             int,
        @OkRef          varchar(255)

        

 
  SELECT @BaseNOI = '['+Servidor +'].'+BaseDatosNombre,@EmpresaNOI = EmpresaAspel
    FROM InterfaseAspel WHERE SistemaAspel = 'NOI' AND Empresa = @Empresa
    
    
 SELECT @Estatus = Estatus FROM Nomina WHERE ID = @ID
 
  IF @Estatus <> 'BORRADOR'
    EXEC spAfectar 'NOM', @ID, 'CANCELAR', 'Todo', NULL, @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
  
  IF @Ok IS NULL
  BEGIN
    SET ANSI_NULLS ON
    SET ANSI_WARNINGS ON
    SELECT @SQL =' UPDATE ' + @BaseNOI + '.dbo.INTELISIS' + @EmpresaNOI +' SET  INTELISIS = 0 WHERE FECH_NOM_FIN = '+CHAR(39)+dbo.fnFormatearFecha(@FechaA,'DD/MM/AAAA')+CHAR(39)
    EXEC (@SQL)		
    IF @@ERROR <> 0 SET @Ok = 1  
  END 
  
  IF @Ok IS NULL
    SELECT 'Se Activo La Nomina del '+dbo.fnFormatearFecha(@FechaA,'DD/MM/AAAA')
  ELSE
    SELECT @OkRef
  
 RETURN
 END
GO



/**************** spNOIActualizarConcepto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNOIActualizarConcepto')           AND type = 'P') drop procedure dbo.spNOIActualizarConcepto
GO             
CREATE PROCEDURE spNOIActualizarConcepto
                @Empresa        varchar(5)


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE 
     @ConceptoDIN       varchar(50),
     @Ok                int


 
  DECLARE crDetalle CURSOR FOR 
   SELECT   ConceptoDIN
     FROM InterfaseAspelNOI
    WHERE Empresa = @Empresa
  OPEN crDetalle
  FETCH NEXT FROM crDetalle INTO   @ConceptoDIN
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL 
  BEGIN
    IF @ConceptoDIN IS NOT NULL
    BEGIN
      IF EXISTS(SELECT * FROM NominaConcepto WHERE  NominaConcepto = @ConceptoDIN AND ConceptoNOI = 0)
        UPDATE  NominaConcepto SET   ConceptoNOI = 1   WHERE  NominaConcepto = @ConceptoDIN 
    END    
      
    FETCH NEXT FROM crDetalle INTO   @ConceptoDIN
  END
  CLOSE crDetalle
  DEALLOCATE crDetalle
  
					
END
GO 