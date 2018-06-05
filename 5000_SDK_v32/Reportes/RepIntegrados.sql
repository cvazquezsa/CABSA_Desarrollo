CREATE proc SPReporteIntegrados                        
@Ejercicio INT,                       
@PeriodoD INT,                        
@PeriodoA INT                      
                                
AS                        
Begin                        
select distinct                        
NP.Personal,                        
Nombre1= (select distinct Nombre=P.ApellidoPaterno+' '+P.ApellidoMaterno+' '+P.Nombre from Personal P LEFT OUTER JOIN NominaD D on P.Personal=D.Personal where D.personal=NP.Personal),                        
FechaAlta= (select distinct P.fechaAlta from Personal P LEFT OUTER JOIN NominaD D on P.Personal=D.Personal where D.personal=NP.Personal),                        
SueldoDiario=Max(NP.SueldoDiario),                        
'Factor'= (Select distinct max(d.Cantidad) from NominaD D, Nomina N where D.Concepto='Factor de Integracion' 
and D.Personal=NP.Personal and N.Periodo Between @PeriodoD and @PeriodoA And N.Ejercicio=@Ejercicio ),  
                      
'Integrado'= (Select distinct max(d.Importe) from NominaD D, Nomina N where D.Concepto='Salario Integrado de Ley' 
and D.Personal=NP.Personal and N.Periodo Between @PeriodoD and @PeriodoA And N.Ejercicio=@Ejercicio ),
                        
'ValesDesp'= (select SUM(D.Importe) from NominaD D LEFT OUTER JOIN Nomina N on D.ID=N.ID 
where D.Concepto='Vales Gravable IMSS' and D.personal=NP.Personal and 
N.Periodo between @PeriodoD and @PeriodoA and N.Estatus='Concluido' And N.Ejercicio=@Ejercicio ), 

'BaseVariable'= (select Max(D.Importe) from NominaD D LEFT OUTER JOIN Nomina N on D.ID=N.ID where 
D.Concepto='Acum Importe Bimestral Variable IMSS' and D.personal=NP.Personal 
and N.Periodo between @PeriodoA and @PeriodoA and N.Ejercicio=@Ejercicio and      
N.Estatus='Concluido'),     
                   
'DiasPeriodo'=(select Distinct sum(D.Importe) from NominaD D LEFT OUTER JOIN 
Nomina N on D.ID=N.ID where D.Concepto='No Dias del Bimestre' and 
D.personal=NP.Personal and N.Periodo between @PeriodoD and @PeriodoA and 
N.Estatus='Concluido' And N.Ejercicio=@Ejercicio and N.ID=MAX(NP.ID)),
                   
'ParteVariable'=(select D.Importe from NominaD D LEFT OUTER JOIN 
Nomina N on D.ID=N.ID where D.Concepto='Variable Diaria del Bimestre' and 
D.personal=NP.Personal and N.Periodo between @PeriodoA and @PeriodoA and 
N.Estatus='Concluido' And N.Ejercicio=@Ejercicio and N.ID=MAX(NP.ID)),

'SDIEstaNomina'=(select distinct Max(D.Importe) from NominaD D LEFT OUTER JOIN Nomina N on D.ID=N.ID where 
D.Concepto='SDI Usado para esta Nómina' and D.personal=NP.Personal and N.Periodo between @PeriodoD and @PeriodoA                     
and N.Estatus='Concluido' And N.Ejercicio=@Ejercicio),    
                    
'SDI'= (select DISTINCT D.Importe from NominaD D LEFT OUTER JOIN Nomina N on D.ID=N.ID where D.Concepto='SDI' and D.personal=NP.Personal and N.Periodo between @PeriodoA and @PeriodoA and N.Estatus='Concluido' And N.Ejercicio=@Ejercicio)                     
into #TablaSDI                        

FROM Personal P LEFT OUTER JOIN NominaD D  on P.Personal=D.Personal,Nomina N, NominaPersonal NP                        
                        
where                         
NP.ID=N.ID                        
AND N.EStatus='CONCLUIDO'                        
AND N.Mov='Nomina'                        
and N.Periodo between @PeriodoD and @PeriodoA                      
AND N.Ejercicio=@Ejercicio                       
      
GROUP BY NP.Personal      
                        
ORDER BY NP.Personal     
    
select * from #TablaSDI    
       
END 