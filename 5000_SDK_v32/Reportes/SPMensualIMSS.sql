    
alter PROC SPMensualIMSS                                
 @fechaD DATETIME,                    
 @FechaA DATETIME  
                                 
AS BEGIN                     
                             
SELECT DISTINCT                 
  P.Registro3,                
  P.ApellidoPaterno,                
  P.Registro,                
  D.Personal,      
  'Depto'=P.Departamento,                                
  'CtroCtos'=P.CentroCostos,                                  
  'NombreEmpleado'=P.ApellidoPaterno+' '+P.ApellidoMaterno+' '+P.Nombre,                                                        
  
  'SDI'= (select distinct MAX(D.Importe) from NominaD D LEFT OUTER JOIN Nomina N on D.ID=N.ID 
  where D.Concepto='SDI Usado para esta Nómina' and D.personal=NP.Personal and N.Estatus='Concluido' 
  and N.FechaEmision BETWEEN @fechaD AND  @FechaA),               
  
  'DiasIMSS'=(select SUM(D.Importe) from NominaD D LEFT OUTER JOIN Nomina N on D.ID=N.ID where 
  D.Concepto='Dias IMSS' and D.personal=NP.Personal and N.Estatus='Concluido' and 
  N.FechaEmision BETWEEN @fechaD AND  @FechaA ),                            
  
  'ObCtaAdic'=  isnull((select distinct SUM(D.Importe) from NominaD D LEFT OUTER JOIN Nomina N on 
  D.ID=N.ID where D.Concepto='Obrero EM Excedente' and D.personal=NP.Personal and 
  N.Estatus='Concluido'and N.FechaEmision BETWEEN @fechaD AND  @FechaA),0),                     
  
  'ObDinero'=  isnull((select distinct SUM(D.Importe) from NominaD D LEFT OUTER JOIN 
  Nomina N on D.ID=N.ID where D.Concepto='Obrero EM Prestaciones Dinero' and D.personal=NP.Personal 
  and N.Estatus='Concluido'and N.FechaEmision BETWEEN @fechaD AND  @FechaA),0),      
  
  'ObGtosMed'=  isnull((select distinct SUM(D.Importe) from NominaD D LEFT OUTER JOIN Nomina N on 
  D.ID=N.ID where D.Concepto='Obrero EM Gastos Medicos' and D.personal=NP.Personal and 
  N.Estatus='Concluido' and N.FechaEmision BETWEEN @fechaD AND  @FechaA),0), 
  
  'ObIV'=  (select SUM(D.Importe) from NominaD D LEFT OUTER JOIN Nomina N on D.ID=N.ID where 
  D.Concepto='Obrero IV' and D.personal=NP.Personal and N.Estatus='Concluido' and 
  N.FechaEmision BETWEEN @fechaD AND  @FechaA ),                                    
  
  'IMSSObrero'= (select SUM(D.Importe) from NominaD D LEFT OUTER JOIN Nomina N on D.ID=N.ID 
  where D.Concepto='IMSS Obrero' and D.personal=NP.Personal and N.Estatus='Concluido' and 
  N.FechaEmision BETWEEN @fechaD AND  @FechaA),  
                            
  'PaCuotaFija'= (select SUM(D.Importe) from NominaD D LEFT OUTER JOIN Nomina N on 
  D.ID=N.ID where D.Concepto='Patron EM Cuota Fija' and D.personal=NP.Personal and N.Estatus='Concluido' 
  and N.FechaEmision BETWEEN @fechaD AND  @FechaA),                      
  
  'PaCuotaadicional'=  isnull((select SUM(D.Importe) from NominaD D LEFT OUTER JOIN Nomina N on 
  D.ID=N.ID where D.Concepto='Patron EM Excedente' and D.personal=NP.Personal and 
  N.Estatus='Concluido' and N.FechaEmision BETWEEN @fechaD AND  @FechaA),0),  
  
  'PaPrestacionesDinero'=  isnull((select SUM(D.Importe) from NominaD D LEFT OUTER JOIN Nomina N on D.ID=N.ID 
  where D.Concepto='Patron EM Prestaciones Dinero' and D.personal=NP.Personal and N.Estatus='Concluido' and 
  N.FechaEmision BETWEEN @fechaD AND  @FechaA),0),                       
  
  'PaGastosMedicos'= (select SUM(D.Importe) from NominaD D LEFT OUTER JOIN Nomina N on D.ID=N.ID where 
  D.Concepto='Patron EM Gastos Medicos' and D.personal=NP.Personal and N.Estatus='Concluido' 
  and N.FechaEmision BETWEEN @fechaD AND  @FechaA),               
  
  'PaIV'=  (select SUM(D.Importe) from NominaD D LEFT OUTER JOIN Nomina N on D.ID=N.ID where 
  D.Concepto='Patron IV' and D.personal=NP.Personal and N.Estatus='Concluido' and 
  N.FechaEmision BETWEEN @fechaD AND  @FechaA),                                     
  
  'PaRiesgo'=  (select SUM(D.Importe) from NominaD D LEFT OUTER JOIN Nomina N on D.ID=N.ID where 
  D.Concepto='Patron Riesgo' and D.personal=NP.Personal and N.Estatus='Concluido' and N.FechaEmision BETWEEN 
  @fechaD AND  @FechaA),   
  
  'PaGuarderias'= (select SUM(D.Importe) from NominaD D LEFT OUTER JOIN Nomina N on D.ID=N.ID where 
  D.Concepto='Patron Guarderias' and D.personal=NP.Personal and N.Estatus='Concluido' and 
  N.FechaEmision BETWEEN @fechaD AND  @FechaA),
  
  'IMSSPatron'=  (select SUM(D.Importe) from NominaD D LEFT OUTER JOIN Nomina N on D.ID=N.ID 
  where D.Concepto='Total IMSS Patron' and D.personal=NP.Personal and N.Estatus='Concluido' and 
  N.FechaEmision BETWEEN @fechaD AND  @FechaA),                             
  
  'TotalIMSSOyP'=  (select SUM(D.Importe) from NominaD D LEFT OUTER JOIN Nomina N on D.ID=N.ID where 
  D.Concepto='Total IMSS O y P' and D.personal=NP.Personal and N.Estatus='Concluido' and 
  N.FechaEmision BETWEEN @fechaD AND  @FechaA),
  
  'ObCV'=  (select SUM(D.Importe) from NominaD D LEFT OUTER JOIN Nomina N on D.ID=N.ID where 
  D.Concepto='Obrero CV' and D.personal=NP.Personal and N.Estatus='Concluido' 
  and N.FechaEmision BETWEEN @fechaD AND  @FechaA),                                     
  
  'PaRetiro'= (select SUM(D.Importe) from NominaD D LEFT OUTER JOIN Nomina N on D.ID=N.ID where 
  D.Concepto='Patron Retiro' and D.personal=NP.Personal and N.Estatus='Concluido' 
  and N.FechaEmision BETWEEN @fechaD AND  @FechaA),                              
  
  'PaCV'= (select SUM(D.Importe) from NominaD D LEFT OUTER JOIN Nomina N on D.ID=N.ID where 
  D.Concepto='Patron CV' and D.personal=NP.Personal and N.Estatus='Concluido' 
  and N.FechaEmision BETWEEN @fechaD AND  @FechaA),                                      
  
  'RCVOyP'=  (select SUM(D.Importe) from NominaD D LEFT OUTER JOIN Nomina N on D.ID=N.ID where 
  D.Concepto='Total IMSS O y P Bimestral' and D.personal=NP.Personal and N.Estatus='Concluido' 
  and N.FechaEmision BETWEEN @fechaD AND  @FechaA),
  
  'PaInfonavit'=  (select SUM(D.Importe) from NominaD D LEFT OUTER JOIN Nomina N on D.ID=N.ID where 
  D.Concepto='Patron Infonavit' and D.personal=NP.Personal and N.Estatus='Concluido' 
  and N.FechaEmision BETWEEN @fechaD AND  @FechaA),                       
  
  'AmortCredInf'=(select SUM(D.Importe) from NominaD D LEFT OUTER JOIN Nomina N on D.ID=N.ID where 
  D.Concepto='Credito Infonavit' and D.personal=NP.Personal and N.Estatus='Concluido' 
  and N.FechaEmision BETWEEN @fechaD AND  @FechaA),                     
  
  'TotalInfonavit'= (select SUM(D.Importe) from NominaD D LEFT OUTER JOIN Nomina N on D.ID=N.ID where 
  D.Concepto='Total Infonavit' and D.personal=NP.Personal and N.Estatus='Concluido' 
  and N.FechaEmision BETWEEN @fechaD AND  @FechaA),                    
  
  'RegistroPat'=NP.RegistroPatronal,            
  
  'CFVSM'=(Select Valor from personalpropvalor where Cuenta=D.Personal and 
  Propiedad IN ('# SMGDF Credito Infonavit','% SDI Credito Infonavit') and Valor NOT IN (' ',NULL)),   
  
  'Falta'=(select isnull(SUM(D.Cantidad),0) from NominaD D LEFT OUTER JOIN 
  Nomina N on D.ID=N.ID where D.Concepto='Faltas' and D.personal=NP.Personal and N.Estatus='Concluido' and 
  N.FechaEmision BETWEEN @fechaD AND  @FechaA),                    
  
  'Incapacidad'=(select isnull(SUM(D.Cantidad),0) from NominaD D LEFT OUTER JOIN Nomina N on D.ID=N.ID 
  where D.Concepto='Incapacidades' and D.personal=NP.Personal and N.Estatus='Concluido' 
  and N.FechaEmision BETWEEN @fechaD AND  @FechaA),                 
  
  'DIMSSFin'=(select isnull(SUM(D.Cantidad),0) from NominaD D LEFT OUTER JOIN Nomina N on D.ID=N.ID where 
  D.Concepto='IMSS' and D.personal=NP.Personal and N.Estatus='Concluido' 
  and N.Mov IN ('Finiquito','Liquidacion') and N.FechaEmision BETWEEN @fechaD AND  @FechaA ),        
  
  'Femision'=(Select distinct Max(N.FechaEmision) from NominaD D LEFT OUTER JOIN Nomina N on D.ID=N.ID where 
  N.Mov='Finiquito' and D.personal=NP.Personal and N.Estatus='Concluido' and N.FechaEmision BETWEEN 
  @fechaD AND  @FechaA )  
       
FROM Nomina N JOIN NominaD D ON N.ID=D.ID                                
     JOIN Personal P ON D.Personal=P.Personal                    
     JOIN NominaPersonal NP ON N.ID=NP.ID                    
                                         
WHERE N.FechaEmision BETWEEN @fechaD AND  @FechaA                           
     and NP.PERSONAL IS NOT NULL                
     and N.Estatus='CONCLUIDO'                    
     and N.Mov IN ('Nomina','Finiquito','Liquidacion')                    
     and NP.Personal=d.Personal  
     --and NP.CentroCostos IS NOT NULL                   
                                 
GROUP BY  P.CentroCostos, D.Personal, NP.Personal,P.ApellidoPaterno, P.Departamento,              
          P.ApellidoMaterno, P.Nombre, NP.RegistroPatronal,P.Registro3,P.Registro,N.Empresa                                
                                
--ORDER BY P.ApellidoPaterno,NP.RegistroPatronal,D.Personal,P.CentroCostos      
          
END
GO 
EXEC SPMensualIMSS '01/09/14','30/09/14'      

