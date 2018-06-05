/* VISTAS          */
SET ANSI_NULLS OFF


/*** pcxc_Auxiliar ***/
if exists (select * from sysobjects where id = object_id('dbo.pcxc_Auxiliar') and type = 'V') drop view dbo.pcxc_Auxiliar
GO
CREATE VIEW pcxc_Auxiliar
--//WITH ENCRYPTION
AS 
SELECT "Tipo" = CONVERT(int, 1), "ID"= CONVERT(char(10), NULL), "Descripcion" = FormaPago FROM FormaPago
UNION
SELECT "Tipo" = CONVERT(int, 2), "ID"= CtaDinero, Descripcion FROM CtaDinero
GO

/*** pcxc_cxc ***/
if exists (select * from sysobjects where id = object_id('dbo.pcxc_cxc') and type = 'V') drop view dbo.pcxc_cxc
GO
CREATE VIEW pcxc_cxc
--//WITH ENCRYPTION
AS 
SELECT cxc.Empresa, cxc.Cliente, cxc.Moneda, cxc.Mov, cxc.MovID, cxc.FechaEmision, cxc.Vencimiento, cxc.Referencia, cxc.Saldo, cxc.PersonalCobrador,
       "Cliente_Nombre" = cte.Nombre, "Cliente_Direccion" = cte.Direccion, "Cliente_Telefonos" = cte.Telefonos, "Cliente_Poblacion" = cte.Poblacion,
       "Cliente_Estado" = cte.Estado, "Cliente_CodigoPostal" = cte.CodigoPostal
  FROM Cxc, Cte, MovTipo mt
 WHERE Cxc.Cliente = Cte.Cliente AND Cxc.Estatus = 'PENDIENTE' AND ISNULL(Saldo, 0) > 0.0
   AND mt.Modulo = 'CXC' AND mt.Mov = Cxc.Mov AND mt.Clave IN ('CXC.F','CXC.FA','CXC.AF','CXC.CA', 'CXC.CAD','CXC.CAP','CXC.VV','CXC.CD','CXC.D','CXC.DA','CXC.DP','CXC.NCP', 'CXP.F','CXP.AF','CXP.CA', 'CXP.CAD','CXP.CAP','CXP.CD','CXP.D','CXP.PAG','CXP.DA','CXP.DP','CXP.NCP')
GO
