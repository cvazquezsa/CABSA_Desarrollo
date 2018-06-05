/* VISTAS          */
SET ANSI_NULLS OFF


-- insert Outlook (de, fecha, asunto) values ('Mexicana de Aviacion', GETDATE(), 'Prueba')
-- insert Outlookpara (id, para) values (1, 'American Airlines') 

-- select * from OutlookDeCte
/*** OutlookDeCte ***/
if exists (select * from sysobjects where id = object_id('dbo.OutlookDeCte') and type = 'V') drop view dbo.OutlookDeCte
GO
CREATE VIEW OutlookDeCte
--//WITH ENCRYPTION
AS 
SELECT c.Cliente, "OutlookID" = m.ID, m.Tipo, m.De, m.Fecha, m.Asunto, "Año"=YEAR(m.Fecha), "Mes"=MONTH(m.Fecha), "Dia"=DAY(m.Fecha)
  FROM OutlookPara p
  JOIN Outlook m ON m.ID = p.ID
  JOIN OutlookNombre n ON n.Nombre = p.Para
  JOIN Cte c ON c.Cliente = n.Cliente
 WHERE m.Recibido = 1
GO

-- select * from Outlook
-- select * from OutlookParaCte
/*** OutlookParaCte ***/
if exists (select * from sysobjects where id = object_id('dbo.OutlookParaCte') and type = 'V') drop view dbo.OutlookParaCte
GO
CREATE VIEW OutlookParaCte
--//WITH ENCRYPTION
AS 
SELECT c.Cliente, "OutlookID" = p.ID, m.Tipo, p.Para, m.De, m.Fecha, m.Asunto, "Año"=YEAR(m.Fecha), "Mes"=MONTH(m.Fecha), "Dia"=DAY(m.Fecha)
  FROM OutlookPara p
  JOIN Outlook m ON m.ID = p.ID
  JOIN OutlookNombre n ON n.Nombre = m.De
  JOIN Cte c ON c.Cliente = n.Cliente
 WHERE m.Recibido = 0 
GO


-- select * from OutlookDeCteCto
/*** OutlookDeCteCto ***/
if exists (select * from sysobjects where id = object_id('dbo.OutlookDeCteCto') and type = 'V') drop view dbo.OutlookDeCteCto
GO
CREATE VIEW OutlookDeCteCto
--//WITH ENCRYPTION
AS 
SELECT c.Cliente, "ClienteContacto"=c.ID, "OutlookID" = m.ID, m.Tipo, m.De, m.Fecha, m.Asunto, "Año"=YEAR(m.Fecha), "Mes"=MONTH(m.Fecha), "Dia"=DAY(m.Fecha)
  FROM OutlookPara p 
  JOIN Outlook m ON m.ID=p.ID
  JOIN OutlookNombre n ON n.Nombre = p.Para 
  JOIN CteCto c ON c.Cliente = n.Cliente AND c.ID = n.ClienteContacto
 WHERE m.Recibido = 1
GO

-- select * from OutlookParaCteCto
/*** OutlookParaCteCto ***/
if exists (select * from sysobjects where id = object_id('dbo.OutlookParaCteCto') and type = 'V') drop view dbo.OutlookParaCteCto
GO
CREATE VIEW OutlookParaCteCto
--//WITH ENCRYPTION
AS 
SELECT c.Cliente, "ClienteContacto"=c.ID, "OutlookID" = p.ID, m.Tipo, p.Para, m.De, m.Fecha, m.Asunto, "Año"=YEAR(m.Fecha), "Mes"=MONTH(m.Fecha), "Dia"=DAY(m.Fecha)
  FROM OutlookPara p
  JOIN Outlook m ON m.ID = p.ID
  JOIN OutlookNombre n ON n.Nombre = m.De
  JOIN CteCto c ON c.Cliente = n.Cliente AND c.ID = n.ClienteContacto
 WHERE m.Recibido = 0
GO

-- select * from OutlookDeProv
/*** OutlookDeProv ***/
if exists (select * from sysobjects where id = object_id('dbo.OutlookDeProv') and type = 'V') drop view dbo.OutlookDeProv
GO
CREATE VIEW OutlookDeProv
--//WITH ENCRYPTION
AS 
SELECT c.Proveedor, "OutlookID" = m.ID, m.Tipo, m.De, m.Fecha, m.Asunto, "Año"=YEAR(m.Fecha), "Mes"=MONTH(m.Fecha), "Dia"=DAY(m.Fecha)
  FROM OutlookPara p
  JOIN Outlook m ON m.ID = p.ID
  JOIN OutlookNombre n ON n.Nombre = p.Para 
  JOIN Prov c ON c.Proveedor = n.Proveedor
 WHERE m.Recibido = 1
GO

-- select * from OutlookParaProv
/*** OutlookParaProv ***/
if exists (select * from sysobjects where id = object_id('dbo.OutlookParaProv') and type = 'V') drop view dbo.OutlookParaProv
GO
CREATE VIEW OutlookParaProv
--//WITH ENCRYPTION
AS 
SELECT c.Proveedor, "OutlookID" = p.ID, m.Tipo, p.Para, m.De, m.Fecha, m.Asunto, "Año"=YEAR(m.Fecha), "Mes"=MONTH(m.Fecha), "Dia"=DAY(m.Fecha)
  FROM OutlookPara p
  JOIN Outlook m ON m.ID = p.ID
  JOIN OutlookNombre n ON n.Nombre = m.De
  JOIN Prov c ON c.Proveedor = n.Proveedor
 WHERE m.Recibido = 0
GO

-- select * from OutlookDePersonal
/*** OutlookDePersonal ***/
if exists (select * from sysobjects where id = object_id('dbo.OutlookDePersonal') and type = 'V') drop view dbo.OutlookDePersonal
GO
CREATE VIEW OutlookDePersonal
--//WITH ENCRYPTION
AS 
SELECT c.Personal, "OutlookID" = m.ID, m.Tipo, m.De, m.Fecha, m.Asunto, "Año"=YEAR(m.Fecha), "Mes"=MONTH(m.Fecha), "Dia"=DAY(m.Fecha)
  FROM OutlookPara p
  JOIN Outlook m ON m.ID = p.ID
  JOIN OutlookNombre n ON n.Nombre = p.Para 
  JOIN Personal c ON c.Personal = n.Personal
 WHERE m.Recibido = 1
GO

-- select * from OutlookParaPersonal
/*** OutlookParaPersonal ***/
if exists (select * from sysobjects where id = object_id('dbo.OutlookParaPersonal') and type = 'V') drop view dbo.OutlookParaPersonal
GO
CREATE VIEW OutlookParaPersonal
--//WITH ENCRYPTION
AS 
SELECT c.Personal, "OutlookID" = p.ID, m.Tipo, p.Para, m.De, m.Fecha, m.Asunto, "Año"=YEAR(m.Fecha), "Mes"=MONTH(m.Fecha), "Dia"=DAY(m.Fecha)
  FROM OutlookPara p
  JOIN Outlook m ON m.ID = p.ID
  JOIN OutlookNombre n ON n.Nombre = m.De
  JOIN Personal c ON c.Personal = n.Personal
 WHERE m.Recibido = 0
GO

-- select * from OutlookDeAgente
/*** OutlookDeAgente ***/
if exists (select * from sysobjects where id = object_id('dbo.OutlookDeAgente') and type = 'V') drop view dbo.OutlookDeAgente
GO
CREATE VIEW OutlookDeAgente
--//WITH ENCRYPTION
AS 
SELECT c.Agente, "OutlookID" = m.ID, m.Tipo, m.De, m.Fecha, m.Asunto, "Año"=YEAR(m.Fecha), "Mes"=MONTH(m.Fecha), "Dia"=DAY(m.Fecha)
  FROM OutlookPara p
  JOIN Outlook m ON m.ID = p.ID
  JOIN OutlookNombre n ON n.Nombre = p.Para 
  JOIN Agente c ON c.Agente = n.Agente
 WHERE m.Recibido = 1
GO

-- select * from OutlookParaAgente
/*** OutlookParaAgente ***/
if exists (select * from sysobjects where id = object_id('dbo.OutlookParaAgente') and type = 'V') drop view dbo.OutlookParaAgente
GO
CREATE VIEW OutlookParaAgente
--//WITH ENCRYPTION
AS 
SELECT c.Agente, "OutlookID" = p.ID, m.Tipo, p.Para, m.De, m.Fecha, m.Asunto, "Año"=YEAR(m.Fecha), "Mes"=MONTH(m.Fecha), "Dia"=DAY(m.Fecha)
  FROM OutlookPara p
  JOIN Outlook m ON m.ID = p.ID
  JOIN OutlookNombre n ON n.Nombre = m.De
  JOIN Agente c ON c.Agente = n.Agente
 WHERE m.Recibido = 0
GO

-- select * from OutlookDeUsuario
/*** OutlookDeUsuario ***/
if exists (select * from sysobjects where id = object_id('dbo.OutlookDeUsuario') and type = 'V') drop view dbo.OutlookDeUsuario
GO
CREATE VIEW OutlookDeUsuario
--//WITH ENCRYPTION
AS 
SELECT c.Usuario, "OutlookID" = m.ID, m.Tipo, m.De, m.Fecha, m.Asunto, "Año"=YEAR(m.Fecha), "Mes"=MONTH(m.Fecha), "Dia"=DAY(m.Fecha)
  FROM OutlookPara p
  JOIN Outlook m ON m.ID = p.ID
  JOIN OutlookNombre n ON n.Nombre = p.Para 
  JOIN Usuario c ON c.Usuario = n.Usuario
 WHERE m.Recibido = 1
GO

-- select * from OutlookParaUsuario
/*** OutlookParaUsuario ***/
if exists (select * from sysobjects where id = object_id('dbo.OutlookParaUsuario') and type = 'V') drop view dbo.OutlookParaUsuario
GO
CREATE VIEW OutlookParaUsuario
--//WITH ENCRYPTION
AS 
SELECT c.Usuario, "OutlookID" = p.ID, m.Tipo, p.Para, m.De, m.Fecha, m.Asunto, "Año"=YEAR(m.Fecha), "Mes"=MONTH(m.Fecha), "Dia"=DAY(m.Fecha)
  FROM OutlookPara p
  JOIN Outlook m ON m.ID = p.ID
  JOIN OutlookNombre n ON n.Nombre = m.De
  JOIN Usuario c ON c.Usuario = n.Usuario
 WHERE m.Recibido = 0
GO

