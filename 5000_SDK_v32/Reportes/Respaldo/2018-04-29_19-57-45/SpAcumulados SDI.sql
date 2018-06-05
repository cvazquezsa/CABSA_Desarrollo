CREATE proc reportesdipruebamarzo      
@Ejercicio INT,      
@PeriodoD INT,      
@PeriodoA INT      
      
AS       
BEGIN      
    
select     
N.Personal,      
PP.ApellidoPaterno,      
PP.ApellidoMaterno,                          
PP.Nombre,      
N.Concepto,      
'Importe1'=(Case O.periodo When '1' Then Sum(N.Importe) else NULL END),      
'Cantidad1'=(Case O.periodo When '1' Then sum(N.Cantidad)Else NULL END),      
'Importe2'=(Case O.periodo When '2' Then Sum(N.Importe) else NULL END),      
'Cantidad2'=(Case O.periodo When '2' Then sum(N.Cantidad) Else NULL END),      
'Importe3'=(Case O.periodo When '3' Then Sum(N.Importe) else NULL END),      
'Cantidad3'=(Case O.periodo When '3' Then sum(N.Cantidad) Else NULL END),      
'Importe4'=(Case O.periodo When '4' Then Sum(N.Importe) else NULL END),      
'Cantidad4'=(Case O.periodo When '4' Then sum(N.Cantidad) Else NULL END),    
'Importe5'=(Case O.periodo When '5' Then Sum(N.Importe) else NULL END),      
'Cantidad5'=(Case O.periodo When '5' Then sum(N.Cantidad) Else NULL END),               
'Importe6'=(Case O.periodo When '6' Then Sum(N.Importe) else NULL END),      
'Cantidad6'=(Case O.periodo When '6' Then sum(N.Cantidad) Else NULL END),     
'Importe7'=(Case O.periodo When '7' Then Sum(N.Importe) else NULL END),      
'Cantidad7'=(Case O.periodo When '7' Then sum(N.Cantidad) Else NULL END),     
'Importe8'=(Case O.periodo When '8' Then Sum(N.Importe) else NULL END),      
'Cantidad8'=(Case O.periodo When '8' Then sum(N.Cantidad) Else NULL END),     
'Importe9'=(Case O.periodo When '9' Then Sum(N.Importe) else NULL END),      
'Cantidad9'=(Case O.periodo When '9' Then sum(N.Cantidad) Else NULL END),     
'Importe10'=(Case O.periodo When '10' Then Sum(N.Importe) else NULL END),      
'Cantidad10'=(Case O.periodo When '10' Then sum(N.Cantidad) Else NULL END),     
'Importe11'=(Case O.periodo When '11' Then Sum(N.Importe) else NULL END),      
'Cantidad11'=(Case O.periodo When '11' Then sum(N.Cantidad) Else NULL END),     
'Importe12'=(Case O.periodo When '12' Then Sum(N.Importe) else NULL END),      
'Cantidad12'=(Case O.periodo When '12' Then sum(N.Cantidad) Else NULL END)    
          
from        
  Nomina O INNER JOIN     
  NominaD N on O.ID=N.ID join    
  NomXPersonal P on N.concepto=p.Concepto join    
  Personal PP on PP.Personal=N.Personal     
  where      
  O.Periodo between @PeriodoD and @PeriodoA AND      
O.Ejercicio=@Ejercicio AND                         
O.Estatus='CONCLUIDO' AND                                               
O.Mov='Nomina'        AND                                             
P.Acum like '%IMSS%'   and     
p.ID='1'    
     
Group By                           
N.Personal,      
PP.ApellidoPaterno,      
PP.ApellidoMaterno,      
PP.Nombre,      
N.Concepto,                          
--sum(N.Importe),      
--N.Cantidad,                          
P.Orden,      
O.Periodo ,    
p.ID                  
Order By        
N.Personal,      
PP.ApellidoPaterno,      
PP.ApellidoMaterno,      
PP.Nombre,      
N.Concepto,                          
--sum(N.Importe),      
--N.Cantidad,                          
P.Orden,      
O.Periodo ,    
p.ID     
    
END    
  
  
  
--select * from nomina where estatus='Concluido'