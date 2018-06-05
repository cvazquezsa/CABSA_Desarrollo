/*************************     Contabilidad Electrónica     ****************************************/
/*
IMPORTANTE: EL SIGUIENTE TRIGGER FORMA PARTE DE LA VERSION Y NO SE DEBEN DE CORRER DIRECTAMENTE 
PORQUE PODRÍA CAUSAR RESULTADOS INESPERADOS EN EL SISTEMA. SE DEBEN DE MODIFICAR MANUALMENTE PARA EVITAR PROBLEMAS. 
LAS LINEAS QUE SE CAMBIARON ESTAN MARCADAS CON LA LEYENDA: --CAMBIO CONTABILIDAD ELECTRONICA
*/

/**************** dbo.tgNominaPersonalCFDI ****************/

if exists (select * from sysobjects where id = object_id('dbo.tgNominaPersonalCFDI') and sysstat & 0xf = 8) 
	drop trigger dbo.tgNominaPersonalCFDI
GO
CREATE TRIGGER dbo.tgNominaPersonalCFDI ON Nomina  
FOR UPDATE  
AS  
BEGIN  
  DECLARE @ID          int,  
    @IDAnt             int,  
    @Ok                int,  
    @OkRef             varchar(255),  
    @Mov               varchar(20),  
    @MovID             varchar(20),  
    @Personal          varchar(10),  
    @PersonalAnt       varchar(10),  
    @SucursalTrabajo   int,  
    @Categoria         varchar(50),  
    @Puesto            varchar(50),  
    @Empresa           varchar(5),  
    @Valor             varchar(50),  
    @Version           int,
/******     Inicio declaración variables CAMBIO CONTABILIDAD ELECTRONICA     ******/
	@RFC			   varchar(30),
	@Nombre			   varchar(100),
    @ImportePercepcion money,
    @ImporteDeduccion  money,
    @Importe           money,
    @FechaPago         datetime,
    @CuentaDestino     varchar(20),
    @BancoDestino	   varchar(50),
    @BancoOrigen	   varchar(50),
    @CtaDinero         varchar(10),
    @NumeroCta         varchar(100),
    @BancoSucursal     varchar(100)
/******    Fin declaración variables CAMBIO CONTABILIDAD ELECTRONICA     ******/

    SELECT @IDAnt = 0  
    WHILE(1=1)  
    BEGIN  
      SELECT @ID = MIN(i.ID)  
        FROM Inserted i  
        JOIN Deleted d ON i.ID = d.ID  
        JOIN MovTipo ON i.Mov = MovTipo.Mov AND MovTipo.Modulo = 'NOM' AND MovTipo.Clave IN('NOM.N', 'NOM.NA', 'NOM.NE', 'NOM.NC')  
       WHERE i.Estatus =  'CONCLUIDO'  
         AND d.Estatus <> 'CONCLUIDO'  
         AND i.ID > @IDAnt          
   
      IF @ID IS NULL BREAK  
      
      SELECT @IDAnt = @ID  
        
      SELECT @Empresa = Empresa FROM Nomina WHERE ID = @ID  
  
      SELECT @PersonalAnt = ''  
      WHILE(1=1)  
      BEGIN  
        SELECT @Personal = MIN(Personal)   
          FROM NominaD  
         WHERE NominaD.ID =  @ID  
           AND NominaD.Personal > @PersonalAnt  
  
        IF @Personal IS NULL BREAK  
          
        SELECT @PersonalAnt = @Personal 
        
/******     Inicio Obtención de Info CAMBIO CONTABILIDAD ELECTRONICA     ******/             
        SELECT @RFC = Registro2, 
               @Nombre = (ApellidoPaterno + ' ' + isnull(ApellidoMaterno,'') + ' ' + Nombre),
               @CuentaDestino = PersonalCuenta,
               @BancoDestino = PersonalSucursal,
               @CtaDinero = ISNULL(CtaDinero,'')
          FROM Personal 
         WHERE Personal = @Personal         

        SELECT @NumeroCta = NumeroCta,
               @BancoSucursal = BancoSucursal
          FROM CtaDinero
         WHERE CtaDinero = @CtaDinero
         
        SELECT @ImportePercepcion = SUM(Importe)
		  FROM nomina a JOIN NominaD b ON a.ID = b.ID 
		  JOIN Personal p ON p.Personal = b.Personal
		 WHERE a.Estatus = 'CONCLUIDO' 
		   --AND a.Mov = 'NOMINA'       
		   AND Movimiento = 'PERCEPCION'
		   AND a.ID = @ID
		   AND p.Personal = @Personal 

		SELECT @ImporteDeduccion = SUM(Importe)
		  FROM nomina a JOIN NominaD b ON a.ID = b.ID 
		  JOIN Personal p ON p.Personal = b.Personal
		 WHERE a.Estatus = 'CONCLUIDO' 
		   --AND a.Mov = 'NOMINA' 
		   AND Movimiento = 'DEDUCCION'
		   AND a.ID = @ID 
		   AND p.Personal = @Personal 
		    
		SET @Importe = ISNULL(@ImportePercepcion,0) - ISNULL(@ImporteDeduccion,0)
		
		SELECT @FechaPago = a.FechaA
		  FROM nomina a JOIN NominaD b ON a.ID = b.ID 
		 WHERE a.ID = @ID		 
/******     Fin Obtención de Info CAMBIO CONTABILIDAD ELECTRONICA     ******/   
              
        SELECT @SucursalTrabajo = SucursalTrabajo, @Categoria = Categoria, @Puesto = Puesto  
          FROM Personal  
          JOIN NominaD ON NominaD.Personal=Personal.Personal  
         WHERE NominaD.ID =  @ID      
           AND Personal.Personal = @Personal  
      
        SELECT @Valor = NULL  
        EXEC spCFDIPersonalPropValor @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'REGISTRO PATRONAL', @Valor OUTPUT  
  
        UPDATE NominaPersonal  
           SET RegistroPatronal = @Valor,  
               Departamento  = p.Departamento,  
               Puesto   = p.Puesto,  
               TipoContrato  = p.TipoContrato,  
               Jornada   = p.Jornada,  
               SDIEstaNomina = p.SDI ,
/******     Inicio asignación variables CAMBIO CONTABILIDAD ELECTRONICA     ******/ 
               RFC = @RFC,
               Beneficiario = @Nombre,
               ImporteNeto = @Importe,
               FechaPago = @FechaPago,
               BancoDestino = @BancoDestino,
               CtaDestino =  @CuentaDestino,
               CtaOrigen = @CtaDinero,
               BancoOrigen = @BancoSucursal
/******     Fin asignación variables CAMBIO CONTABILIDAD ELECTRONICA     ******/ 
          FROM NominaPersonal n  
          JOIN Personal p ON n.Personal = p.Personal  
         WHERE n.ID = @ID          
           AND n.Personal = @Personal  
      END  
    END  
  RETURN  
END  
GO