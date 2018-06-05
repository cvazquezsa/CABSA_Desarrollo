
CREATE PROC spSUAAfiliatorio  
  @EMPRESA  VARCHAR(20),  
  @FECHAD   DATETIME,  
  @FECHAA   DATETIME,
  @RegistroPat    Varchar(11)  
  
AS BEGIN  
  
SELECT   
    PersonalPropValor.Valor RegistroPatronal,  
    Registro3             IMSS, 
	Personal.CodigoPostal  CP, 
	RIGHT('0'+LTRIM(DATEPART(dd,personal.FechaNacimiento)),2)+RIGHT('0'+LTRIM(DATEPART(mm,personal.FechaNacimiento)),2)+LTRIM(DATEPART(yyyy,personal.FechaNacimiento)) FechaNacimiento,
	UPPER(Personal.LugarNacimiento) Nacimiento,
	'09' Entidad,
	RIGHT('0'+LTRIM(Personal.UnidadMedica),3) Clinica,
	Personal.Puesto Puestos,
	Personal.Sexo Sexo,
	TipoSueldo= Case Personal.TipoSueldo
	            When 'Fijo' then '0'
				When 'Variable' then '1'
				When 'Mixto' then '2'
				Else '2'
				End,


	--select * from personal WHERE REGISTRO3='94028304379'
    
    Jornada = '8'--Case Jornada WHEN 'Horario Completo' THEN '0' END 
    
FROM   
      Personal JOIN Sucursal ON Personal.SucursalTrabajo=Sucursal.Sucursal JOIN
      PersonalPropValor ON Sucursal.Sucursal=PersonalPropValor.Cuenta  
WHERE   
      Personal.Estatus = 'ALTA' AND  
      Personal.Empresa = @EMPRESA AND  
      PersonalPropValor.Propiedad = 'Registro Patronal' AND
      PersonalPropValor.Cuenta = Personal.SucursalTrabajo AND
      Sucursal.Sucursal = Personal.SucursalTrabajo AND
	  PersonalPropValor.Valor=@RegistroPat  AND
      Personal.FechaAlta BETWEEN @FECHAD AND @FECHAA  
  
END  
