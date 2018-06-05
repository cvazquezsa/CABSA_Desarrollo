CREATE PROC SPNominaPTU      

   @ID INT      

      

AS BEGIN      

      

SELECT  D.PERSONAL,      

  P.ApellidoPaterno+' '+P.ApellidoMaterno+' '+P.Nombre as [NombreEmpleado],      

  'UtilidadRepartible'= max (CASE WHEN D.CONCEPTO='Utilidad Repartible' then D.importe else 0 end),      

  'FactorDias'= max (CASE WHEN D.CONCEPTO='Factor Dias' then convert (varchar (30),importe) else '' end),      

  'FactorSdo'= max (CASE WHEN D.CONCEPTO='Factor Sueldo' then convert (varchar (30),importe) else '' end),      

  'PTUDias'= max (CASE WHEN D.CONCEPTO='PTU Dias' then D.importe else 0 end),      

  'PTUSueldo'= max (CASE WHEN D.CONCEPTO='PTU Sueldo' then D.importe else 0 end),      

  'SueldoTopado'= max (CASE WHEN D.CONCEPTO='Sueldo Topado' then D.importe else 0 end),      

  'TotalPTU'= max (CASE WHEN D.CONCEPTO='Total PTU' then D.importe else 0 end),      

  'DiasAcumulados'= max (CASE WHEN D.CONCEPTO='Sueldo para PTU' then convert (varchar (30),Cantidad) else '' end),      

  'SueldoAcumulado'= max (CASE WHEN D.CONCEPTO='Sueldo para PTU' then D.Importe else 0 end),      

  'SueldoTopePTU'= max (CASE WHEN D.CONCEPTO='Sueldo para PTU' then D.importe else 0 end),      

  P.CentroCostos,      

  N.FechaEmision      

        

FROM NOMINA N LEFT OUTER JOIN NOMINAD D  ON  N.ID=D.ID      

  LEFT OUTER JOIN PERSONAL P  ON D.PERSONAL=P.PERSONAL      

  LEFT OUTER JOIN NominaPersonal NP ON NP.Personal=P.Personal      

      

      

WHERE   N.ID=@ID      

 AND  D.Personal is not null      

-- AND  Importe not in (null,0,'')      

       

GROUP BY D.PERSONAL, ApellidoPaterno,ApellidoMaterno, P.Nombre, N.Ejercicio, P.CentroCostos, N.FechaEmision      

      

ORDER BY D.PERSONAL      

      

END       

      

      

/*      

      

EXEC  SPNominaPTU  '11730'      

    

*/ 