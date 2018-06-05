
if exists (select * from sysobjects where id = object_id('dbo.spNominaPrimaRiesgo') and type = 'P') drop procedure dbo.spNominaPrimaRiesgo
GO
CREATE PROCEDURE spNominaPrimaRiesgo
                    @FechaD		DateTime,
                    @FechaA		DateTime,
                    @Concepto		varchar(50),
                    @Empresa		char(5)
--//WITH ENCRYPTION
AS BEGIN
SELECT a.Empresa, c.Registro2, c.ApellidoPaterno, c.ApellidoMaterno, c.Nombre,
       b.FechaD, FechaA = b.FechaD + b.Cantidad, b.Referencia, b.Cantidad,
       a.Concepto,
       IncRTrab = CASE WHEN a.Concepto = 'Accidente Trabajo' THEN 1 END,
       IncRTrabTran = CASE WHEN a.Concepto = 'Accidente Trabajo Transito' THEN 1 END,
       IncEnfGral = CASE WHEN a.Concepto = 'Enfermedad General Inicial' THEN 1 
                         WHEN a.Concepto = 'Enfermedad General Subsecuente' THEN 1 END,
       IncMatPre = CASE WHEN a.Concepto = 'Maternidad Prenatal' THEN 1 END,
       IncMatPos = CASE WHEN a.Concepto = 'Maternidad Posnatal' THEN 1 END,
       IncMatEnl = CASE WHEN a.Concepto = 'Maternidad Enlace' THEN 1 END,
       IncEnfGralIni = CASE WHEN a.Concepto = 'Enfermedad General Inicial' THEN 1 END,
       IncEnfGralSub = CASE WHEN a.Concepto = 'Enfermedad General Subsecuente' THEN 1 END,
       SubIncRT = CASE WHEN a.Concepto = 'Accidente Trabajo' THEN b.Cantidad END
  FROM Nomina a, NominaD b, Personal c
 WHERE a.ID = b.ID
   AND b.Personal = c.Personal
   AND a.Mov = 'Incapacidades'
   AND a.FechaEmision BETWEEN @FechaD AND @FechaA
   AND a.Estatus = 'CONCLUIDO'
   AND ISNULL(a.Concepto, '') = CASE @Concepto  WHEN 'NULL' THEN ISNULL(a.Concepto, '') ELSE @Concepto END
   AND a.Empresa = @Empresa
 ORDER BY c.ApellidoPaterno
END
GO