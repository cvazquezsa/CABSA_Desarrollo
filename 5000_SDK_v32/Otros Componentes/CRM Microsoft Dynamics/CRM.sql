USE CRM
GO

/*************************** TablaSyncro **************************/
--if not exists (select * from SysTabla where SysTabla = 'TablaSyncro') 
--INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TablaSyncro','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.TablaSyncro') and type = 'U') 
CREATE TABLE TablaSyncro
    (
	ID						int	IDENTITY(1,1)	NOT NULL,
	TablaIntelisis			varchar(256) NULL,
	TablaCRM				varchar(256) NULL,
	OrdenCampo				int			 NULL CONSTRAINT [DF_TablaSyncro_Orden]  DEFAULT ((1)),
	OrdenTabla				int			 NULL,
	CampoInt				varchar(256) NULL,
	CampoExt				varchar(256) NULL,
	IdAutomatico			bit		 NOT NULL CONSTRAINT [DF_TablaSyncro_IdAutomatico]  DEFAULT ((0)),
	BuscarDato				bit		 NOT NULL CONSTRAINT [DF_TablaSyncro_Buscar]  DEFAULT ((0)),
	DefaultInsert			varchar(50)  NULL,
	AccionEspecifica		varchar(50)  NULL,
	
	CONSTRAINT priTablaSyncro PRIMARY KEY  CLUSTERED (ID)
	)
GO

IF NOT EXISTS(SELECT * FROM TablaSyncro)
BEGIN
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'AccountBase', 25, 4, 'AlmacenDef', 'AccountId', 0, 0, '1', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'AccountBase', 34, 4, 'Categoria', 'AccountId', 0, 0, 'Dynamics', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'AccountBase', 2, 4, 'Cliente', 'AccountId', 1, 1, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'AccountBase', 29, 4, 'Conciliar', 'AccountId', 0, 0, '0', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'AccountBase', 33, 4, 'CreditoConCondiciones', 'AccountId', 0, 0, '0', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'AccountBase', 32, 4, 'CreditoConDias', 'AccountId', 0, 0, '0', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'AccountBase', 31, 4, 'CreditoConLimite', 'AccountId', 0, 0, '0', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'AccountBase', 30, 4, 'CreditoEspecial', 'AccountId', 0, 0, '0', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'AccountBase', 1, 4, 'CRMID', 'AccountId', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'AccountBase', 24, 4, 'DefMoneda', 'AccountId', 0, 0, 'Pesos', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'AccountBase', 27, 4, 'PedidosParciales', 'AccountId', 0, 0, '0', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'AccountBase', 35, 4, 'SincronizarCRM', 'AccountId', 0, 0, '1', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'AccountBase', 26, 4, 'SucursalEmpresa', 'AccountId', 0, 0, '0', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'AccountBase', 28, 4, 'VtasConsignacion', 'AccountId', 0, 0, '0', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'AccountBase', 11, 4, 'Estatus', 'CreatedBy', 0, 0, 'ALTA', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'AccountBase', 5, 4, 'Observaciones', 'Description', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'AccountBase', 7, 4, 'PedirTono', 'DoNotFax', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'AccountBase', 13, 4, 'eMail1', 'EMailAddress1', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'AccountBase', 15, 4, 'Fax', 'Fax', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'AccountBase', 14, 4, 'Tipo', 'LeadId', 0, 0, 'Cliente', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'AccountBase', 3, 4, 'Nombre', 'Name', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'AccountBase', 10, 4, 'Agente', 'OwnerId', 0, 1, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'AccountBase', 12, 4, 'Usuario', 'OwnerId', 0, 1, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'AccountBase', 9, 4, 'Comentarios', 'Subject', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'AccountBase', 6, 4, 'Telefonos', 'Telephone1', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'AccountBase', 8, 4, 'DirInternet', 'WebSiteURL', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte1', 'AccountBase', 2, 5, 'AccountId', 'AccountId', 0, 0, NULL, 'BORRACTO>CTE')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte1', 'AccountBase', 1, 5, 'CRMID', 'PrimaryContactId', 0, 0, NULL, 'BORRACTO>CTE')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte2', 'AccountBase', 2, 6, 'AccountId', 'AccountId', 0, 0, NULL, 'ASIGNACTO>CTE')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte2', 'AccountBase', 1, 6, 'CRMID', 'PrimaryContactId', 0, 0, NULL, 'ASIGNACTO>CTE')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Control1', 'ContactBase', 2, 2, 'AccountId', 'AccountId', 0, 0, NULL, 'BORRACTO>CTE')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Control1', 'ContactBase', 1, 2, 'CRMID', 'ContactId', 0, 0, NULL, 'BORRACTO>CTE')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Control2', 'ContactBase', 1, 3, 'CRMID', 'ContactId', 0, 0, NULL, 'ASIGNACTO>CTE')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Control2', 'ContactBase', 2, 3, 'AccountId', 'ParentCustomerId', 0, 0, NULL, 'ASIGNACTO>CTE')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Control3', 'ContactBase', 2, 4, 'AccountId', 'AccountId', 0, 0, NULL, 'BORRACTO>PRO')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Control3', 'ContactBase', 1, 4, 'CRMID', 'ContactId', 0, 0, NULL, 'BORRACTO>PRO')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Control4', 'ContactBase', 2, 5, 'AccountId', 'AccountId', 0, 0, NULL, 'ASIGNACTO>PRO')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Control4', 'ContactBase', 1, 5, 'CRMID', 'ContactId', 0, 0, NULL, 'ASIGNACTO>PRO')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'ContactBase', 24, 1, 'GrupoEmpresarial', 'CompanyName', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'ContactBase', 23, 1, 'NombreComercial', 'CompanyName', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'ContactBase', 36, 1, 'Categoria', 'ContactId', 0, 0, 'Dynamics', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'ContactBase', 1, 1, 'CRMID', 'ContactId', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'ContactBase', 2, 1, 'Prospecto', 'ContactId', 1, 1, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'ContactBase', 37, 1, 'SincronizarCRM', 'ContactId', 0, 0, '1', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'ContactBase', 26, 1, 'Tipo', 'ContactId', 0, 0, 'Contacto', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'ContactBase', 21, 1, 'Estatus', 'CreatedBy', 0, 0, 'ALTA', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'ContactBase', 8, 1, 'Observaciones', 'Description', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'ContactBase', 17, 1, 'PedirTono', 'DoNotFax', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'ContactBase', 25, 1, 'eMail', 'EMailAddress1', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'ContactBase', 16, 1, 'Fax', 'Fax', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'ContactBase', 3, 1, 'Nombre', 'FirstName', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'ContactBase', 4, 1, 'NombreCompleto', 'FullName', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'ContactBase', 5, 1, 'ApellidoPaterno', 'LastName', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'ContactBase', 20, 1, 'Agente', 'OwnerId', 0, 1, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'ContactBase', 22, 1, 'Usuario', 'OwnerId', 0, 1, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'ContactBase', 19, 1, 'Comentarios', 'Subject', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'ContactBase', 15, 1, 'Telefonos', 'Telephone1', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'ContactBase', 18, 1, 'PaginaWeb', 'WebSiteUrl', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'CustomerAddressBase', 8, 4, 'Pais', 'Country', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'CustomerAddressBase', 4, 4, 'DireccionNumero', 'Line1', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'CustomerAddressBase', 5, 4, 'DireccionNumeroInt', 'Line2', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'CustomerAddressBase', 6, 4, 'EntreCalles', 'Line3', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'CustomerAddressBase', 3, 4, 'Direccion', 'Name', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'CustomerAddressBase', 1, 4, 'CRMID', 'ParentId', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'CustomerAddressBase', 11, 4, 'SincronizarCRM', 'ParentId', 0, 0, '1', 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'CustomerAddressBase', 9, 4, 'CodigoPostal', 'PostalCode', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'CustomerAddressBase', 7, 4, 'Estado', 'StateOrProvince', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Cte', 'CustomerAddressBase', 2, 4, 'Poblacion', 'StateOrProvince', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'CustomerAddressBase', 8, 4, 'Pais', 'Country', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'CustomerAddressBase', 4, 4, 'DireccionNumero', 'Line1', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'CustomerAddressBase', 5, 4, 'DireccionNumeroInt', 'Line2', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'CustomerAddressBase', 6, 4, 'EntreCalles', 'Line3', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'CustomerAddressBase', 3, 4, 'Direccion', 'Name', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'CustomerAddressBase', 1, 4, 'CRMID', 'ParentId', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'CustomerAddressBase', 11, 4, 'SincronizarCRM', 'ParentId', 0, 0, '1', 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'CustomerAddressBase', 9, 4, 'CodigoPostal', 'PostalCode', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'CustomerAddressBase', 7, 4, 'Estado', 'StateOrProvince', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'CustomerAddressBase', 2, 4, 'Poblacion', 'StateOrProvince', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Agente', 'InternalAddressBase', 6, 2, 'Poblacion', 'City', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Agente', 'InternalAddressBase', 3, 2, 'Pais', 'Country', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Agente', 'InternalAddressBase', 7, 2, 'Direccion', 'Line1', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Agente', 'InternalAddressBase', 2, 2, 'Agente', 'ParentId', 1, 1, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Agente', 'InternalAddressBase', 1, 2, 'CRMID', 'ParentId', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Agente', 'InternalAddressBase', 5, 2, 'CodigoPostal', 'PostalCode', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Agente', 'InternalAddressBase', 4, 2, 'Estado', 'StateOrProvince', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'InvoiceBase', 4, 1, 'FechaEmision', 'CreatedOn', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'InvoiceBase', 5, 1, 'UltimoCambio', 'CreatedOn', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'InvoiceBase', 7, 1, 'Cliente', 'CustomerId', 0, 1, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'InvoiceBase', 16, 1, 'Comentarios', 'Description', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'InvoiceBase', 1, 1, 'CRMID', 'InvoiceId', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'InvoiceBase', 8, 1, 'Almacen', 'InvoiceNumber', 0, 1, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'InvoiceBase', 2, 1, 'Empresa', 'InvoiceNumber', 0, 0, 'DEMO', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'InvoiceBase', 6, 1, 'Moneda', 'InvoiceNumber', 0, 0, 'Pesos', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'InvoiceBase', 3, 1, 'Mov', 'InvoiceNumber', 0, 0, 'Factura', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'InvoiceBase', 15, 1, 'Observaciones', 'InvoiceNumber', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'InvoiceBase', 14, 1, 'SubModulo', 'InvoiceNumber', 0, 0, 'VTAS', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'InvoiceBase', 13, 1, 'Sucursal', 'InvoiceNumber', 0, 0, '0', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'InvoiceBase', 9, 1, 'TipoCambio', 'InvoiceNumber', 0, 0, '1', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'InvoiceBase', 17, 1, 'OpportunityId', 'OpportunityId', 0, 1, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'InvoiceBase', 12, 1, 'Agente', 'OwnerId', 0, 1, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'InvoiceBase', 10, 1, 'Usuario', 'OwnerId', 0, 1, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'InvoiceBase', 11, 1, 'Estatus', 'StateCode', 0, 1, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('VentaD', 'InvoiceDetailBase', 8, 2, 'Almacen', 'InvoiceId', 0, 1, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('VentaD', 'InvoiceDetailBase', 1, 2, 'CRMID', 'InvoiceId', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('VentaD', 'InvoiceDetailBase', 2, 2, 'ID', 'InvoiceId', 0, 1, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('VentaD', 'InvoiceDetailBase', 3, 2, 'Renglon', 'InvoiceId', 0, 0, '1024', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('VentaD', 'InvoiceDetailBase', 5, 2, 'RenglonID', 'InvoiceId', 0, 0, '1', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('VentaD', 'InvoiceDetailBase', 4, 2, 'RenglonSub', 'InvoiceId', 0, 0, '0', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('VentaD', 'InvoiceDetailBase', 6, 2, 'RenglonTipo', 'InvoiceId', 0, 0, 'N', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('VentaD', 'InvoiceDetailBase', 10, 2, 'Precio', 'PricePerUnit', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('VentaD', 'InvoiceDetailBase', 9, 2, 'Articulo', 'ProductId', 0, 1, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('VentaD', 'InvoiceDetailBase', 11, 2, 'Unidad', 'ProductId', 0, 1, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('VentaD', 'InvoiceDetailBase', 7, 2, 'Cantidad', 'Quantity', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'LeadAddressBase', 7, 2, 'Estado', 'City', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'LeadAddressBase', 8, 2, 'Pais', 'Country', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'LeadAddressBase', 3, 2, 'DireccionNumero', 'Line1', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'LeadAddressBase', 4, 2, 'DireccionNumeroInt', 'Line2', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'LeadAddressBase', 5, 2, 'EntreCalles', 'Line3', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'LeadAddressBase', 2, 2, 'Direccion', 'Name', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'LeadAddressBase', 1, 2, 'CRMID', 'ParentId', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'LeadAddressBase', 9, 2, 'CodigoPostal', 'PostalCode', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'LeadAddressBase', 10, 2, 'SincronizarCRM', 'PostalCode', 0, 0, '1', 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Prospecto', 'LeadAddressBase', 6, 2, 'Poblacion', 'StateOrProvince', 0, 0, NULL, 'Update')
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('CRMTemporal', 'OpportunityBase', 1, 1, 'CRMID', 'StatusCode', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('CRMTemporal', 'OpportunityBase', 2, 1, 'Dato', 'StatusCode', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'SalesOrderBase', 4, 1, 'FechaEmision', 'CreatedOn', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'SalesOrderBase', 5, 1, 'UltimoCambio', 'CreatedOn', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'SalesOrderBase', 7, 1, 'Cliente', 'CustomerId', 0, 1, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'SalesOrderBase', 16, 1, 'Comentarios', 'Description', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'SalesOrderBase', 17, 1, 'OpportunityId', 'OpportunityId', 0, 1, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'SalesOrderBase', 8, 1, 'Almacen', 'OrderNumber', 0, 1, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'SalesOrderBase', 2, 1, 'Empresa', 'OrderNumber', 0, 0, 'DEMO', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'SalesOrderBase', 6, 1, 'Moneda', 'OrderNumber', 0, 0, 'Pesos', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'SalesOrderBase', 3, 1, 'Mov', 'OrderNumber', 0, 0, 'Pedido', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'SalesOrderBase', 15, 1, 'Observaciones', 'OrderNumber', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'SalesOrderBase', 14, 1, 'SubModulo', 'OrderNumber', 0, 0, 'VTAS', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'SalesOrderBase', 13, 1, 'Sucursal', 'OrderNumber', 0, 0, '0', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'SalesOrderBase', 9, 1, 'TipoCambio', 'OrderNumber', 0, 0, '1', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'SalesOrderBase', 12, 1, 'Agente', 'OwnerId', 0, 1, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'SalesOrderBase', 10, 1, 'Usuario', 'OwnerId', 0, 1, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'SalesOrderBase', 1, 1, 'CRMID', 'SalesOrderId', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Venta', 'SalesOrderBase', 11, 1, 'Estatus', 'StatusCode', 0, 1, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('VentaD', 'SalesOrderDetailBase', 10, 2, 'Precio', 'PricePerUnit', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('VentaD', 'SalesOrderDetailBase', 9, 2, 'Articulo', 'ProductId', 0, 1, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('VentaD', 'SalesOrderDetailBase', 11, 2, 'Unidad', 'ProductId', 0, 1, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('VentaD', 'SalesOrderDetailBase', 7, 2, 'Cantidad', 'Quantity', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('VentaD', 'SalesOrderDetailBase', 8, 2, 'Almacen', 'SalesOrderId', 0, 1, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('VentaD', 'SalesOrderDetailBase', 1, 2, 'CRMID', 'SalesOrderId', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('VentaD', 'SalesOrderDetailBase', 2, 2, 'ID', 'SalesOrderId', 0, 1, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('VentaD', 'SalesOrderDetailBase', 3, 2, 'Renglon', 'SalesOrderId', 0, 0, '1024', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('VentaD', 'SalesOrderDetailBase', 5, 2, 'RenglonID', 'SalesOrderId', 0, 0, '1', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('VentaD', 'SalesOrderDetailBase', 4, 2, 'RenglonSub', 'SalesOrderId', 0, 0, '0', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('VentaD', 'SalesOrderDetailBase', 6, 2, 'RenglonTipo', 'SalesOrderId', 0, 0, 'N', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Agente', 'SystemUserBase', 3, 1, 'DomainName', 'DomainName', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Agente', 'SystemUserBase', 4, 1, 'Nombre', 'FullName', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Agente', 'SystemUserBase', 5, 1, 'Telefonos', 'HomePhone', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Agente', 'SystemUserBase', 6, 1, 'eMail', 'InternalEMailAddress', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Agente', 'SystemUserBase', 7, 1, 'Mensaje', 'MobilePhone', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Agente', 'SystemUserBase', 2, 1, 'Agente', 'SystemUserId', 1, 1, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Agente', 'SystemUserBase', 10, 1, 'Categoria', 'SystemUserId', 0, 0, 'Dynamics', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Agente', 'SystemUserBase', 1, 1, 'CRMID', 'SystemUserId', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Agente', 'SystemUserBase', 8, 1, 'Estatus', 'SystemUserId', 0, 0, 'ALTA', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Agente', 'SystemUserBase', 9, 1, 'SucursalEmpresa', 'SystemUserId', 0, 0, '0', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Usuario', 'SystemUserBase', 3, 2, 'Nombre', 'FullName', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Usuario', 'SystemUserBase', 1, 2, 'CRMID', 'SystemUserId', 0, 0, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Usuario', 'SystemUserBase', 6, 2, 'DefAgente', 'SystemUserId', 0, 1, NULL, NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Usuario', 'SystemUserBase', 5, 2, 'DefEmpresa', 'SystemUserId', 0, 0, 'DEMO', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Usuario', 'SystemUserBase', 8, 2, 'DefMoneda', 'SystemUserId', 0, 0, 'Pesos', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Usuario', 'SystemUserBase', 7, 2, 'Estatus', 'SystemUserId', 0, 0, 'ALTA', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Usuario', 'SystemUserBase', 9, 2, 'GrupoTrabajo', 'SystemUserId', 0, 0, 'Dynamics', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Usuario', 'SystemUserBase', 4, 2, 'Sucursal', 'SystemUserId', 0, 0, '0', NULL)
  INSERT TablaSyncro(TablaIntelisis, TablaCRM, OrdenCampo, OrdenTabla, CampoInt, CampoExt, IdAutomatico, BuscarDato, DefaultInsert, AccionEspecifica) VALUES('Usuario', 'SystemUserBase', 2, 2, 'Usuario', 'SystemUserId', 0, 1, NULL, NULL)
END
GO

--DROP TABLE CfgIntelisis
/*************************** CfgIntelisis **************************/
--if not exists (select * from SysTabla where SysTabla = 'CfgIntelisis') 
--INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CfgIntelisis','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CfgIntelisis') and type = 'U') 
CREATE TABLE CfgIntelisis
    (
	Servidor				varchar(100)	NOT	NULL,
	Base					varchar(100)	NOT	NULL,
	Usuario					varchar(10)			NULL,
	Contrasena				varchar(32)			NULL,
	CuentaAdministrador		varchar(100)		NULL,
	
	CONSTRAINT priCfgIntelisis PRIMARY KEY  CLUSTERED (Servidor, Base)
	)
GO
--INSERT CfgIntelisis select 'Labprod3', 'IntelisisCRM', 'DEMO', '0633971b5e442cd51b8e0a972d74f054', 'intelisisdemo\Administrator'

-- drop table IntelisisService
/****** IntelisisService ******/
--if not exists (select * from SysTabla where SysTabla = 'IntelisisService') 
--INSERT INTO SysTabla (SysTabla) VALUES ('IntelisisService')
if not exists (select * from sysobjects where id = object_id('dbo.IntelisisService') and type = 'U') 
BEGIN
  CREATE TABLE dbo.IntelisisService (
	ID  int				NOT NULL	IDENTITY(1,1),

	Sistema				varchar(100)		NULL,	
	Contenido			varchar(100)		NULL,
	Referencia			varchar(100)		NULL,
	SubReferencia		varchar(100)		NULL,
	Version				float				NULL,

	Usuario				varchar(10)			NULL,
	Solicitud			varchar(max)		NULL,
	Resultado			varchar(max)		NULL,
	Estatus				varchar(15)			NULL	DEFAULT 'SINPROCESAR',		-- SINPROCESAR, PROCESADO, ERROR, CONCLUIDO
	FechaEstatus		datetime			NULL	DEFAULT GETDATE(),
	Ok  int  NULL,
	OkRef				varchar(255)		NULL,	
	Conversacion		uniqueidentifier	NULL,
	SincroGUID			uniqueidentifier	NULL,
	SucursalOrigen		int  NULL,
	SucursalDestino		int  NULL,	
	SincroTabla			varchar(100)		NULL,	
	SincroSolicitud		uniqueidentifier	NULL,	

	CONSTRAINT priIntelisisService PRIMARY KEY  CLUSTERED (ID)
  )
END
GO

--DROP TABLE TriggerCRM
/*************************** TriggerCRM **************************/
--if not exists (select * from SysTabla where SysTabla = 'TriggerCRM') 
--INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TriggerCRM','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.TriggerCRM') and type = 'U') 
CREATE TABLE TriggerCRM
    (
	Tabla				varchar(255)	NOT	NULL,
	Eliminar			bit DEFAULT 0	NOT	NULL,
	
	CONSTRAINT priTriggerCRM PRIMARY KEY  CLUSTERED (Tabla)
	)
GO

IF NOT EXISTS(SELECT * FROM TriggerCRM)
BEGIN
  INSERT INTO TriggerCRM(Tabla, Eliminar) VALUES('ActivityPointerBase', 0)
  INSERT INTO TriggerCRM(Tabla, Eliminar) VALUES('SystemUserBase', 0)
  INSERT INTO TriggerCRM(Tabla, Eliminar) VALUES('ActivityPartyBase', 0)
  INSERT INTO TriggerCRM(Tabla, Eliminar) VALUES('TaskBase', 0)
  INSERT INTO TriggerCRM(Tabla, Eliminar) VALUES('InternalAddressBase', 0)
  INSERT INTO TriggerCRM(Tabla, Eliminar) VALUES('ProductBase', 0)
  INSERT INTO TriggerCRM(Tabla, Eliminar) VALUES('ContactBase', 0)
  INSERT INTO TriggerCRM(Tabla, Eliminar) VALUES('SalesOrderBase', 0)
  INSERT INTO TriggerCRM(Tabla, Eliminar) VALUES('SalesOrderDetailBase', 0)
  INSERT INTO TriggerCRM(Tabla, Eliminar) VALUES('OpportunityBase', 0)
  INSERT INTO TriggerCRM(Tabla, Eliminar) VALUES('LeadBase', 0)
  INSERT INTO TriggerCRM(Tabla, Eliminar) VALUES('LeadAddressBase', 0)
  INSERT INTO TriggerCRM(Tabla, Eliminar) VALUES('QueueItemBase', 0)
  INSERT INTO TriggerCRM(Tabla, Eliminar) VALUES('CustomerAddressBase', 0)
  INSERT INTO TriggerCRM(Tabla, Eliminar) VALUES('AccountBase', 0)
  INSERT INTO TriggerCRM(Tabla, Eliminar) VALUES('InvoiceBase', 0)
  INSERT INTO TriggerCRM(Tabla, Eliminar) VALUES('InvoiceDetailBase', 0)
END
GO


/***************** SysCampoExt *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.SysCampoExt') AND TYPE = 'V') DROP VIEW SysCampoExt
GO
CREATE VIEW SysCampoExt
--//WITH ENCRYPTION
AS
SELECT 
  'Tabla'		= tablas.name,
  'Campo'		= columnas.name,
  'Orden'		= columnas.ColID,
  'TipoDatos'	= tipos.name,
  'Ancho'		= columnas.length,
  'Precision'	= columnas.prec,
  'Escala'		= columnas.scale,
  'AceptaNulos'	= isnullable,
  'EsIdentity'	= convert(bit, CASE WHEN columnas.status = 128 THEN 1 ELSE 0 END),
  'EsCalculado'	= columnas.iscomputed,
  'Collation'	= columnas.Collation,
  'Tipo'		= tablas.type,
  'default'		= def.[text]
  FROM syscolumns columnas
  JOIN systypes tipos ON tipos.xtype = columnas.xtype
  JOIN sysobjects tablas ON columnas.ID = tablas.ID
  LEFT OUTER JOIN syscomments as def on def.id = columnas.[cdefault]

GO


/**************** fnTriggerCRMCampos ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTriggerCRMCampos') DROP FUNCTION fnTriggerCRMCampos
GO
CREATE FUNCTION fnTriggerCRMCampos 
	(
	@Tabla		sysname
	)
RETURNS varchar(max)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Campo			sysname,
    @Resultado		varchar(max)
    
  SELECT @Resultado = ''
  DECLARE crCampos CURSOR LOCAL FOR
   SELECT Campo 
     FROM SysCampoExt 
    WHERE Tabla = @Tabla
      AND TipoDatos NOT IN ('text', 'ntext', 'image')
    GROUP BY Campo

  OPEN crCampos
  FETCH NEXT FROM crCampos INTO @Campo
  WHILE @@FETCH_STATUS = 0 
  BEGIN
    IF @Resultado <> '' SELECT @Resultado = @Resultado + ', '
    SELECT @Resultado = @Resultado + @Campo
    FETCH NEXT FROM crCampos INTO @Campo
  END
  CLOSE crCampos
  DEALLOCATE crCampos
    
  RETURN (@Resultado)
END
GO

/**************** fnInformacionContexto ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnInformacionContexto') DROP FUNCTION fnInformacionContexto
GO
CREATE FUNCTION fnInformacionContexto 
	(
	@bit				varchar(100)
	)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Estatus		bit,
    @DosBigint		bigint
    
  SET @Estatus = 0
  SET @DosBigint = 2
    
  IF @bit = 'SINCROIS' AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,0))  <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'CRM'      AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,1))  <> 0 SET @Estatus = 1 ELSE  
  IF @bit = 'LSB3'     AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,2))  <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB4'     AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,3))  <> 0 SET @Estatus = 1 ELSE  
  IF @bit = 'LSB5'     AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,4))  <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB6'     AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,5))  <> 0 SET @Estatus = 1 ELSE  
  IF @bit = 'LSB7'     AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,6))  <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB8'     AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,7))  <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB9'     AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,8))  <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB10'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,9))  <> 0 SET @Estatus = 1 ELSE  
  IF @bit = 'LSB11'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,10)) <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB12'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,11)) <> 0 SET @Estatus = 1 ELSE  
  IF @bit = 'LSB13'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,12)) <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB14'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,13)) <> 0 SET @Estatus = 1 ELSE  
  IF @bit = 'LSB15'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,14)) <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB16'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,15)) <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB17'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,16)) <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB18'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,17)) <> 0 SET @Estatus = 1 ELSE  
  IF @bit = 'LSB19'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,18)) <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB20'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,19)) <> 0 SET @Estatus = 1 ELSE  
  IF @bit = 'LSB21'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,20)) <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB22'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,21)) <> 0 SET @Estatus = 1 ELSE  
  IF @bit = 'LSB23'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,22)) <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB24'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,23)) <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB25'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,24)) <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB26'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,25)) <> 0 SET @Estatus = 1 ELSE  
  IF @bit = 'LSB27'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,26)) <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB28'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,27)) <> 0 SET @Estatus = 1 ELSE  
  IF @bit = 'LSB29'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,28)) <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB30'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,29)) <> 0 SET @Estatus = 1 ELSE  
  IF @bit = 'LSB31'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,30)) <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB32'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,31)) <> 0 SET @Estatus = 1 
  
  RETURN (@Estatus)
END
GO

/**************** fnEstaSincronizandoCRM ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnEstaSincronizandoCRM') DROP FUNCTION fnEstaSincronizandoCRM
GO
CREATE FUNCTION fnEstaSincronizandoCRM ()
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado bit
    
  SELECT @Resultado = dbo.fnInformacionContexto('CRM')    
  
  RETURN(@Resultado)
END
GO


/**************** spGenerarTriggerCRM ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarTriggerCRM') and type = 'P') drop procedure dbo.spGenerarTriggerCRM
GO             
CREATE PROCEDURE spGenerarTriggerCRM
--//WITH ENCRYPTION
AS BEGIN
DECLARE
  @Tabla		varchar(255),
  @Eliminar		bit,
  @Campos		varchar(max),
  @SQL			varchar(max),
  @Trigger		sysname

  DECLARE crGenerarTriggerCRM CURSOR FOR
   SELECT Tabla, Eliminar
     FROM TriggerCRM
    WHERE Tabla NOT IN('ActivityPartyBase', 'LeadBase', 'OpportunityBase', 'ProductBase', 'QueueItemBase', 'TaskBase')
    ORDER BY Tabla, Eliminar
  OPEN crGenerarTriggerCRM
  FETCH NEXT FROM crGenerarTriggerCRM INTO @Tabla, @Eliminar
  WHILE @@FETCH_STATUS = 0
  BEGIN
 
    SELECT @Trigger = 'tg' + @Tabla + 'ABC_CRM'
    SELECT @Campos = dbo.fnTriggerCRMCampos(@Tabla)
  
    SELECT @SQL = '
IF EXISTS (SELECT name FROM sysobjects WHERE name = ''' + @Trigger + ''' AND type = ''TR'') DROP TRIGGER ' + @Trigger
    EXEC (@SQL)
    IF @Eliminar = 0
    BEGIN
      SELECT @SQL = '
CREATE TRIGGER ' + @Trigger + ' ON ' + @Tabla + '
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE
    @CRMIDI  		uniqueidentifier,
    @CRMIDD			uniqueidentifier,
    @Datos			varchar(max),
    @Usuario		varchar(10),
    @Contrasena		varchar(32),
    @Ok				int,
    @OkRef			varchar(255),
    @IDIS			int,
    @Accion			varchar(20),
    @Estacion		int,
    @Tabla			varchar(255)
  
  IF dbo.fnEstaSincronizandoCRM() = 1
    RETURN
  
  '

  IF @Tabla = 'AccountBase'
  BEGIN
    SELECT @SQL = @SQL + 'SELECT @CRMIDI = AccountId FROM Inserted '
    SELECT @SQL = @SQL + 'SELECT @CRMIDD = AccountId FROM Deleted '
  END
  ELSE
  IF @Tabla = 'ContactBase'
  BEGIN
    SELECT @SQL = @SQL + 'SELECT @CRMIDI = ContactId FROM Inserted '
    SELECT @SQL = @SQL + 'SELECT @CRMIDD = ContactId FROM Deleted '
  END
  ELSE
  IF @Tabla IN('CustomerAddressBase','InternalAddressBase','LeadAddressBase')
  BEGIN
    SELECT @SQL = @SQL + 'SELECT @CRMIDI = ParentId FROM Inserted '
    SELECT @SQL = @SQL + 'SELECT @CRMIDD = ParentId FROM Deleted '
  END
  ELSE
  IF @Tabla IN('InvoiceBase', 'InvoiceDetailBase')
  BEGIN
    SELECT @SQL = @SQL + 'SELECT @CRMIDI = InvoiceId FROM Inserted '
    SELECT @SQL = @SQL + 'SELECT @CRMIDD = InvoiceId FROM Deleted '
  END
  ELSE
  IF @Tabla = 'OpportunityBase'
  BEGIN
    SELECT @SQL = @SQL + 'SELECT @CRMIDI = StatusCode FROM Inserted '
    SELECT @SQL = @SQL + 'SELECT @CRMIDD = StatusCode FROM Deleted '
  END
  ELSE
  IF @Tabla IN('SalesOrderBase','SalesOrderDetailBase')
  BEGIN
    SELECT @SQL = @SQL + 'SELECT @CRMIDI = SalesOrderId FROM Inserted '
    SELECT @SQL = @SQL + 'SELECT @CRMIDD = SalesOrderId FROM Deleted '
  END
  ELSE    
  IF @Tabla = 'ActivityPointerBase'
  BEGIN
    SELECT @SQL = @SQL + 'SELECT @CRMIDI = OwningBusinessUnit FROM Inserted '
    SELECT @SQL = @SQL + 'SELECT @CRMIDD = OwningBusinessUnit FROM Deleted '
  END
  ELSE
  IF @Tabla = 'SystemUserBase'
  BEGIN
    SELECT @SQL = @SQL + 'SELECT @CRMIDI = SystemUserId FROM Inserted '
    SELECT @SQL = @SQL + 'SELECT @CRMIDD = SystemUserId FROM Deleted '
  END

  SELECT @SQL = @SQL + '  
  IF @CRMIDI IS NOT NULL AND @CRMIDD IS NULL
    SELECT @Accion = ' + '''INSERT''
  ELSE
  IF @CRMIDI IS NOT NULL AND @CRMIDD IS NOT NULL
    SELECT @Accion = ' + '''UPDATE''
  ELSE
  IF @CRMIDI IS NULL AND @CRMIDD IS NOT NULL
    SELECT @Accion = ' + '''DELETE''
  ELSE
    RETURN
  
  SELECT @Datos = '+ '''<Intelisis Sistema="CRM" Contenido="Solicitud" Referencia="CRM.CRM" SubReferencia="" Version="1.0"> <Solicitud> <' + ''' + @Accion + ''' + '>''
  
  IF @Accion IN (' + '''INSERT''' + ', ' + '''UPDATE''' + ')
    SELECT @Datos = @Datos + (SELECT ' + @Campos + ' FROM inserted ' + @Tabla + ' FOR XML AUTO)
  ELSE
    SELECT @Datos = @Datos + (SELECT ' + @Campos + ' FROM deleted ' + @Tabla + ' FOR XML AUTO)
  
  SELECT @Datos = @Datos + ' + '''</' + ''' + @Accion + ''' + '></Solicitud></Intelisis>''' + '
  
  SELECT
    @Usuario    = Usuario,
    @Contrasena = Contrasena
  FROM CfgIntelisis
  
  EXEC spIntelisisService @Usuario, @Contrasena, @Datos, NULL, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @IDIS OUTPUT
  
  RETURN
END
      '
      EXEC (@SQL)
      SELECT @SQL = ''
    END

    FETCH NEXT FROM crGenerarTriggerCRM INTO @Tabla, @Eliminar
  END
  CLOSE crGenerarTriggerCRM
  DEALLOCATE crGenerarTriggerCRM
  RETURN
END
GO
EXEC spGenerarTriggerCRM

/**************** spSetInformacionContexto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSetInformacionContexto') and type = 'P') drop procedure dbo.spSetInformacionContexto
GO             
CREATE PROCEDURE spSetInformacionContexto
		@bit		varchar(50),
		@Accion		bit = 1

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @InformacionContexto		bigint,
    @DosBigint					bigint,
    @MiContext_Info				varbinary(128)
    
  SELECT @DosBigint = 2
    
  SET @InformacionContexto = CONVERT(int,CONVERT(varbinary(8),CONTEXT_INFO()))  
  IF @bit = 'SINCROIS'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,0) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,0)
  END ELSE 
  IF @bit = 'CRM'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,1) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,1)
  END ELSE  
  IF @bit = 'LSB3'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,2) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,2)
  END ELSE  
  IF @bit = 'LSB4'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,3) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,3)
  END ELSE  
  IF @bit = 'LSB5'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,4) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,4)
  END ELSE  
  IF @bit = 'LSB6'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,5) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,5)
  END ELSE  
  IF @bit = 'LSB7'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,6) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,6)
  END ELSE  
  IF @bit = 'LSB8'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,7) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,7)
  END ELSE  

  IF @bit = 'LSB9'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,8) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,8)
  END ELSE 
  IF @bit = 'LSB10'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,9) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,9)
  END ELSE  
  IF @bit = 'LSB11'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,10) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,10)
  END ELSE  
  IF @bit = 'LSB12'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,11) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,11)
  END ELSE  
  IF @bit = 'LSB13'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,12) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,12)
  END ELSE  
  IF @bit = 'LSB14'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,13) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,13)
  END ELSE  
  IF @bit = 'LSB15'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,14) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,14)
  END ELSE  
  IF @bit = 'LSB16'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,15) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,15)
  END ELSE  
  IF @bit = 'LSB17'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,16) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,16)
  END ELSE 
  IF @bit = 'LSB18'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,17) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,17)
  END ELSE  
  IF @bit = 'LSB19'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,18) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,18)
  END ELSE  
  IF @bit = 'LSB20'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,19) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,19)
  END ELSE  
  IF @bit = 'LSB21'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,20) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,20)
  END ELSE  
  IF @bit = 'LSB22'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,21) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,21)
  END ELSE  
  IF @bit = 'LSB23'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,22) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,22)
  END ELSE  
  IF @bit = 'LSB24'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,23) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,23)
  END ELSE  
  IF @bit = 'LSB25'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,24) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,24)
  END ELSE 
  IF @bit = 'LSB26'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,25) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,25)
  END ELSE  
  IF @bit = 'LSB27'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,26) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,26)
  END ELSE  
  IF @bit = 'LSB28'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,27) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,27)
  END ELSE  
  IF @bit = 'LSB29'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,28) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,28)
  END ELSE  
  IF @bit = 'LSB30'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,29) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,29)
  END ELSE  
  IF @bit = 'LSB31'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,30) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,30)
  END ELSE  
  IF @bit = 'LSB32'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,31) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,31)
  END
  
  SET @MiContext_Info = ISNULL(CONVERT(varbinary(128),@InformacionContexto),0X0) 
  
  SET Context_Info @MiContext_Info
END
GO

/**************** spResetInformacionContexto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spResetInformacionContexto') and type = 'P') drop procedure dbo.spResetInformacionContexto
GO             
CREATE PROCEDURE spResetInformacionContexto
--//WITH ENCRYPTION
AS BEGIN

  SET Context_Info 0x0
END
GO

/**************** spGetInformacionContexto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGetInformacionContexto') and type = 'P') drop procedure dbo.spGetInformacionContexto
GO             
CREATE PROCEDURE spGetInformacionContexto
--//WITH ENCRYPTION
AS BEGIN

  SELECT CONVERT(varbinary(8),Context_Info())
END
GO

/******************* spBuscaDatoCRM *******************/
if OBJECT_ID('dbo.spBuscaDatoCRM') is not null DROP PROCEDURE spBuscaDatoCRM
GO
CREATE PROCEDURE spBuscaDatoCRM
  @Accion	varchar(100),
  @Tabla	varchar(100),
  @Filtro	varchar(100),
  @Valor	varchar(100) OUTPUT
  
--//WITH ENCRYPTION
AS BEGIN
DECLARE
  @CuentaAdministrador	varchar(100),
  @Guid					uniqueidentifier
  
  SELECT @CuentaAdministrador = CuentaAdministrador FROM CfgIntelisis
  
  SET nocount ON
  SET ANSI_NULLS ON
  SET ANSI_WARNINGS ON
  SET QUOTED_IDENTIFIER ON
  
  IF @Accion = 'Consecutivo'
    SELECT @Valor = NEWID()
  
  IF @Accion = 'Busca'
  BEGIN

    IF @Tabla = 'OpportunityId'
      IF @Filtro = '' OR @Filtro IS NULL
        SELECT  @Valor  = NEWID()
      ELSE
        SELECT @Valor = @Filtro

    IF @Tabla = 'OrganizationId'
      SELECT TOP 1 @Valor  = OrganizationId  FROM Organization
 
    IF @Tabla = 'OwningBusinessUnit'
      SELECT  @Valor = BusinessUnitId FROM BusinessUnitBase
    
    IF @Tabla = 'BusinessUnitId'
      SELECT TOP 1 @Valor  = BusinessUnitId  FROM BusinessUnit

    IF @Tabla = 'CreatedBy'
      SELECT  @Valor = SystemUserid FROM SystemUser WHERE DomainName = @CuentaAdministrador
    
    IF @Tabla = 'StateCode'
    BEGIN
      IF @Filtro = 'CANCELADO' SELECT  @Valor =  '2'
      IF @Filtro = 'AFECTANDO' SELECT  @Valor =  '3'
      IF @Filtro = 'PENDIENTE_0' SELECT  @Valor =  '1'
      IF @Filtro = 'PENDIENTE' SELECT  @Valor =  '3'
      IF @Filtro = 'CONCLUIDO' SELECT  @Valor =  '3'
    END
    
    IF @Tabla = 'StatusCode'
    BEGIN
      IF @Filtro = 'CANCELADO' SELECT  @Valor =  '4'
      IF @Filtro = 'AFECTANDO' SELECT  @Valor =  '100001'
      IF @Filtro = 'PENDIENTE_O' SELECT  @Valor =  '1'
      IF @Filtro = 'PENDIENTE' SELECT  @Valor =  '100001'
      IF @Filtro = 'CONCLUIDO' SELECT  @Valor =  '100001'
    END  

   IF @Tabla = 'OwningUser'
     SELECT  @Valor = SystemUserid FROM SystemUser WHERE DomainName = @CuentaAdministrador
   
   IF @Tabla = 'OwnerId'
   BEGIN
     SELECT @Valor = NULL
     SELECT @Valor = SystemUserid FROM SystemUser WHERE DomainName LIKE '%' + @Filtro + '%'
     IF @Valor IS NULL OR @Valor = ''
       SELECT  @Valor = SystemUserid FROM SystemUser WHERE DomainName = @CuentaAdministrador
   END
   
   IF @Tabla = 'ModifiedBy'
     SELECT  @Valor = SystemUserid FROM SystemUser WHERE DomainName = @CuentaAdministrador

   IF @Tabla = 'CalendarId'
   BEGIN
     SELECT @Valor = CalendarId FROM CalendarBase WHERE CONVERT(varchar(max),PrimaryUserId) = CONVERT(VARCHAR(40),@Filtro)
   END

   IF @Tabla = 'ActiveDirectoryGuid'
   BEGIN
     SELECT @Valor = ActiveDirectoryGuid FROM SystemUser WHERE CONVERT(varchar(max),SystemUserid) = @Filtro
     IF @Valor IS NULL OR @Valor = ''
       SELECT  @Valor = ActiveDirectoryGuid FROM SystemUser WHERE DomainName = @CuentaAdministrador
   END
   
   IF @Tabla = 'DefaultUoMId'
     SELECT TOP 1 @Valor = UoMid FROM UoM
  
   IF @Tabla = 'UoMid'
     SELECT TOP 1 @Valor = UoMid FROM UoM
  
   IF @Tabla = 'UomScheduleid'
     SELECT TOP 1 @Valor = UoMScheduleId FROM UoMSchedule
   
   IF @Tabla = 'DefaultUoMScheduleId'
     SELECT TOP 1 @Valor = UoMScheduleId FROM UoMSchedule
  
   IF @Tabla = 'SubjectId'
     SELECT TOP 1 @Valor = SubjectID FROM SubjectBase
  
   IF @Tabla = 'TransactionCurrencyId'
     SELECT TOP 1 @Valor = TransactionCurrencyId FROM TransactionCurrencyBase
   
   IF @Tabla = 'PriceLevelId'
     IF EXISTS(SELECT PriceLevelId FROM PriceLevelBase WHERE NAME = 'Precio Intelisis')
     BEGIN
       SELECT @Valor = PriceLevelId FROM PriceLevelBase WHERE NAME = 'Precio Intelisis'
     END
     ELSE
     BEGIN
       PRINT ('Se creo Precio Intelisis')
       SELECT @Guid = NEWID()
       INSERT INTO PriceLevelBase (PriceLevelId, OrganizationId,                                    Name,               Description,        StateCode, StatusCode, TransactionCurrencyId)
            VALUES                (@Guid,        (SELECT TOP 1 OrganizationId  FROM Organization ), 'Precio Intelisis', 'Precio Intelisis', 0,         10001,      (SELECT TOP 1 TransactionCurrencyId FROM TransactionCurrencyBase))
       SELECT @Valor = @Guid
     END

     IF @Tabla = 'SystemUserId'  
       IF EXISTS(SELECT TOP 1 SystemUserId FROM SystemUserBase WHERE CONVERT(varchar(max),SystemUserId) = @Filtro)  
         SELECT TOP 1 @Valor = SystemUserId FROM SystemUserBase WHERE CONVERT(varchar(max),SystemUserId) = @Filtro  
       ELSE  
         SELECT @Valor = @Filtro  
   END  

  IF @Accion = 'Llave'  
  BEGIN  
    SELECT @Valor = c.COLUMN_NAME    
      FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS pk, INFORMATION_SCHEMA.KEY_COLUMN_USAGE c   
     WHERE  pk.TABLE_NAME = @Tabla
       AND CONSTRAINT_TYPE = 'PRIMARY KEY'
       AND c.TABLE_NAME = pk.TABLE_NAME
       AND c.CONSTRAINT_NAME = pk.CONSTRAINT_NAME  
  END 
  RETURN
END
GO  

/******************* spArmaInstruccionCRM *******************/
if OBJECT_ID('dbo.spArmaInstruccionCRM') is not null DROP PROCEDURE spArmaInstruccionCRM
GO
CREATE PROCEDURE spArmaInstruccionCRM
		@Accion					varchar(100),
		@TablaIntelisis			varchar(100),
		@Campos					varchar(2000),
		@Variables				varchar(2000),
		@ModoDebug				varchar(2000),
		@CRMID					varchar(120),
		@TEMP					varchar(max) = NULL OUTPUT 

AS BEGIN
DECLARE
  @Servidor		varchar(100),
  @Base			varchar(100),
  @SQL			nvarchar(max)
  
  SELECT
    @Servidor	= Servidor,
    @Base		= Base
    FROM CfgIntelisis
      
  SET ANSI_NULLS ON
  SET ANSI_WARNINGS ON
  SET QUOTED_IDENTIFIER ON
--select @ModoDebug = 1

  IF @Accion IN ('Busca', 'Consecutivo')
  BEGIN  
  	SELECT @SQL = 'EXEC [' + @Servidor + '].[' + @Base + '].dbo.spBuscaDatoCRM ''' + @Accion + ''', ''' + @TablaIntelisis + ''', ''' + ISNULL(@Campos,'') + ''', @TEMP OUTPUT'
  	IF @ModoDebug = 1 
  	  PRINT (@Campos)
  	ELSE
  	BEGIN
  	  EXEC sp_executesql @SQL, N'@TEMP varchar(max) OUTPUT', @TEMP = @TEMP OUTPUT
  	END
  END

  IF @Accion = 'CAMBIA>CUENTA'
  BEGIN
    IF (@Campos IS NULL OR @Variables IS NULL) OR @Variables <> '1'
      SELECT @campos = ''
    ELSE
      SELECT @Campos = 'DELETE [' + @Servidor + '].[' + @Base + '].dbo.Prospecto WHERE CRMID = '''+@Campos+''''
    IF @ModoDebug = 1 
      PRINT (@Campos)
    ELSE
    BEGIN
      EXEC (@Campos)
    END
  END
  
  IF @Accion = 'BORRACTO>CTE'
  BEGIN
    IF @Campos IS NULL OR @Variables IS NULL
      SELECT @campos = ''
    ELSE
      SELECT @Campos = 'DELETE [' + @Servidor + '].[' + @Base + '].dbo.CTECTO WHERE PrimaryContactId = '''+@Campos+''' AND Cliente = (SELECT CLIENTE FROM [' + @Servidor + '].[' + @Base + '].dbo.CTE WHERE CRMID = '''+@Variables+''')'
    IF @ModoDebug = 1 
      PRINT (@Campos)
    ELSE
    BEGIN
      EXEC (@Campos)
    END
  END
  	
  IF @Accion = 'ASIGNACTO>CTE'
  BEGIN
  	if @Campos IS NULL or @Variables IS NULL
  	  SELECT @campos = ''
  	ELSE
  	  SELECT @Campos = 'IF NOT EXISTS(SELECT PrimaryContactId FROM [' + @Servidor + '].[' + @Base + '].dbo.CTECTO WHERE PrimaryContactId = '''+@Campos+''') INSERT INTO [' + @Servidor + '].[' + @Base + '].dbo.CTECTO (CLIENTE, Telefonos, Fax, NOMBRE, eMail, PrimaryContactId) (SELECT (SELECT CLIENTE FROM [' + @Servidor + '].[' + @Base + '].dbo.CTE WHERE CRMID = '''+@Variables+''') AS ''Prospecto'', Telefonos, Fax, NOMBRE, eMail, '''+@Campos+''' FROM [' + @Servidor + '].[' + @Base + '].dbo.PROSPECTO WHERE CRMID = '''+@Campos+''') 
  			Else 
  		Update [' + @Servidor + '].[' + @Base + '].dbo.CTECTO SET 
  		Nombre = (SELECT Nombre FROM [' + @Servidor + '].[' + @Base + '].dbo.Prospecto WHERE CRMID = '''+@Campos+'''), 
  		Telefonos = (SELECT Telefonos FROM [' + @Servidor + '].[' + @Base + '].dbo.Prospecto WHERE CRMID = '''+@Campos+'''), 
  		eMail = (SELECT eMail FROM [' + @Servidor + '].[' + @Base + '].dbo.Prospecto WHERE CRMID = '''+@Campos+''') , 
  		Fax = (SELECT Fax FROM [' + @Servidor + '].[' + @Base + '].dbo.Prospecto WHERE CRMID = '''+@Campos+''')  
  		WHERE PrimaryContactId = '''+@Campos+'''' 
  	IF @ModoDebug = 1 
  	  PRINT (@Campos)
  	ELSE
  	BEGIN
  	  EXEC (@Campos)
  	END
  END
  
  IF @Accion = 'BORRACTO>PRO'
  BEGIN
  	if @Campos IS NULL or @Variables IS NULL
  	  SELECT @campos = ''
  	ELSE
  	  SELECT @Campos = 'DELETE [' + @Servidor + '].[' + @Base + '].dbo.ProspectoCTO WHERE CRMID = '''+@Campos+''' AND PROSPECTO = (SELECT PROSPECTO FROM [' + @Servidor + '].[' + @Base + '].dbo.PROSPECTO WHERE CRMID = '''+@Variables+''')'
  	IF @ModoDebug = 1 
  	  PRINT (@Campos)
  	ELSE
  	BEGIN
  	  EXEC (@Campos)
  	END
  END
  
  IF @Accion = 'ASIGNACTO>PRO'
  BEGIN
  	IF @Campos IS NULL OR @Variables IS NULL
  	  SELECT @campos = ''
  	ELSE
  	  SELECT @Campos = 'IF NOT EXISTS(SELECT CRMID FROM [' + @Servidor + '].[' + @Base + '].dbo.ProspectoCTO WHERE CRMID = '''+@Campos+''') INSERT INTO [' + @Servidor + '].[' + @Base + '].dbo.ProspectoCTO (PROSPECTO, Telefonos, NOMBRE, eMail, CRMID, AccountId) (SELECT (SELECT PROSPECTO FROM [' + @Servidor + '].[' + @Base + '].dbo.PROSPECTO WHERE CRMID = '''+@Variables+''') AS ''Prospecto'', Telefonos, NOMBRE, eMail, CRMID, '''+@Campos+''' FROM [' + @Servidor + '].[' + @Base + '].dbo.PROSPECTO WHERE CRMID = '''+@Campos+''')' 
  	IF @ModoDebug = 1 
  	  PRINT (@Campos)
  	ELSE
  	BEGIN
  	  EXEC (@Campos)
  	END
  END

  IF @Accion = 'INSERT'
  BEGIN
  	SET @Campos = SUBSTRING(@Campos,1,LEN(@Campos)-1)
  	SET @Variables = SUBSTRING(@Variables,1,LEN(@Variables)-1)
  	SELECT @Campos = 'EXEC spSetInformacionContexto CRM, 1 INSERT INTO [' + @Servidor + '].[' + @Base + '].dbo.'+@TablaIntelisis+' (' +@Campos+ ') VALUES'
  	SELECT @Variables = '(' +@Variables+ ')'
  	SELECT @CAMPOS = @CAMPOS + @Variables
  	IF @ModoDebug = 1 
  	  PRINT (@Campos)
  	ELSE
  	BEGIN
  	  EXEC (@Campos)
  	END
  END

  IF @Accion = 'UPDATE'				
  BEGIN
  	SET @Campos = SUBSTRING(@Campos,1,LEN(@Campos)-1)
  	SELECT @Campos = 'EXEC spSetInformacionContexto CRM, 1 UPDATE [' + @Servidor + '].[' + @Base + '].dbo.' + @TablaIntelisis + ' SET '+ @Campos+' WHERE CRMID = '''+@CRMID+''''
  	IF @ModoDebug = 1 
  	  PRINT (@Campos)
  	ELSE
  	BEGIN
  	  EXEC (@Campos)
  	END
  END
  IF @Accion = 'DELETE'				
  BEGIN  
  	SELECT @Campos = 'EXEC spSetInformacionContexto CRM, 1 DELETE [' + @Servidor + '].[' + @Base + '].dbo.' + @TablaIntelisis + ' WHERE CRMID = '''+@CRMID+''''
  	IF @ModoDebug = 1 
  	  PRINT (@Campos)
  	ELSE
  	BEGIN
  	  EXEC (@Campos)
  	END
  END
  RETURN  
END
GO

/******************* spISCRM *******************/
if OBJECT_ID('dbo.spISCRM') is not null DROP PROCEDURE spISCRM
GO
CREATE PROCEDURE spISCRM
		@ID					int,
		@iSolicitud			int,
		@Version			float,
		@Resultado			varchar(max) = NULL OUTPUT,
		@Ok					int			 = NULL OUTPUT,    
		@OkRef				varchar(255) = NULL OUTPUT,
		@CambiarEstatus		bit					OUTPUT
		
AS BEGIN
DECLARE
  @CampoInt				varchar(100),
  @CampoExt				varchar(100),
  @Campos				varchar(5000),
  @Variables			varchar(5000),
  @Valor				varchar(max),
  @TablaIntelisis		varchar(100),
  @Accion				varchar(100),
  @CRMID				varchar(100),
  @Bandera				int,
  @idAutomatico			bit,
  @TEMP					varchar(max),
  @BuscarDato			bit,
  @DefaultInsert		varchar(100),
  @AccionEspecifica		varchar(100),
  @ModoDebug			bit,
  @SSQL					varchar(5000),
  @SSQL1				varchar(2000),
  @SSQL2				varchar(2000),
  @PASO					int,  
  @TablaAnterior		varchar(50),  
  @Tabla				varchar(255),
  @RutaXML				varchar(255),
  @SQL					nvarchar(max),
  @Servidor				varchar(100),
  @Base					varchar(100)
  
  SELECT
    @Servidor	= Servidor,
    @Base		= Base
    FROM CfgIntelisis

  --SET @ModoDebug = 1 --@Debug
  
  IF (OBJECT_ID('Tempdb..#CRMDatosXML')) IS NOT NULL
    DROP TABLE #CRMDatosXML
  ELSE
    CREATE TABLE #CRMDatosXML
    (
      Campo varchar(max) COLLATE Modern_Spanish_CS_AS NOT NULL,
      Valor varchar(max) COLLATE Modern_Spanish_CS_AS NULL
     )
       
  SET ANSI_NULLS ON
  SET ANSI_WARNINGS ON
  SET QUOTED_IDENTIFIER ON	
  SET CONTEXT_INFO 0x01

  SELECT @Accion = localname
    FROM OPENXML(@iSolicitud,'/Intelisis/Solicitud',1)
   WHERE nodetype = 1 AND parentid = 7

  SELECT @Tabla = localname
    FROM OPENXML(@iSolicitud,'/Intelisis/Solicitud',1)
   WHERE nodetype = 1 AND parentid = 8

  SELECT @RutaXML = '/Intelisis/Solicitud/' + @Accion + '/' + @Tabla
     
  INSERT #CRMDatosXML
  SELECT Campo.localname Campo, Valor.text Valor
    FROM OPENXML (@iSolicitud, @Rutaxml, 3) Campo
    LEFT OUTER JOIN OPENXML (@iSolicitud, @Rutaxml, 1) Valor
      ON Campo.id = Valor.parentid
   WHERE Campo.nodetype = 2
     AND Valor.nodetype = 3
    
  SELECT
    @Campos			='',
    @Variables		='',
    @Bandera		= 0,
    @TablaAnterior	= '',
    @SSQL			= '',
    @SSQL1			= '',
    @SSQL2			= '',
    @PASO			= 0

  DECLARE crTablaSyncroCRM CURSOR FOR
   SELECT TablaIntelisis,Campoint, CampoExt , idAutomatico, BuscarDato, DefaultInsert, AccionEspecifica
     FROM TablaSyncro
    WHERE TablaCRM = @Tabla
    ORDER BY OrdenTabla, TablaIntelisis, TablaCRM, OrdenCampo
  OPEN crTablaSyncroCRM
  FETCH NEXT FROM crTablaSyncroCRM
  INTO @TablaIntelisis, @Campoint, @CampoExt, @idAutomatico, @BuscarDato, @DefaultInsert, @AccionEspecifica
  WHILE @@FETCH_STATUS = 0
  BEGIN

    IF @CampoExt IS NOT NULL
    BEGIN
      IF @TablaAnterior <> @TablaIntelisis AND @Bandera=0
        SELECT @TablaAnterior = @TablaIntelisis
      IF @TablaAnterior <> @TablaIntelisis
      BEGIN  
        EXEC spArmaInstruccionCRM @Accion, @TablaAnterior, @Campos, @Variables, @ModoDebug, @CRMID
        SELECT @TablaAnterior	= @TablaIntelisis,
               @Campos			= '',
               @Variables		= ''
      END
      
      IF @AccionEspecifica IS NOT NULL
        SELECT @Accion = @AccionEspecifica

      IF @Accion = 'CAMBIA>CUENTA'
      BEGIN
	    SELECT @SQL = 'SELECT @Valor = Valor '+ ' FROM #CRMDatosXML WHERE Campo = ''' + @CampoExt + ''''
	    EXECUTE sp_executesql @SQL, N'@Valor varchar(max) OUTPUT', @Valor OUTPUT
		IF @PASO = 0 SELECT @SSQL1 = @Valor
		IF @PASO = 1 SELECT @SSQL2 = @Valor
		SELECT @PASO = @PASO + 1
		SELECT @Campos = @SSQL1
		SELECT @Variables = @SSQL2
		IF @PASO = 2 SELECT @PASO = 0
	  END

	  IF @Accion = 'BORRACTO>CTE'
	  BEGIN
	    SELECT @SQL = 'SELECT @Valor = Valor '+ ' FROM #CRMDatosXML WHERE Campo = ''' + @CampoExt + ''''
	    EXECUTE sp_executesql @SQL, N'@Valor varchar(max) OUTPUT', @Valor OUTPUT
		IF @PASO = 0 SELECT @SSQL1 = @Valor
		IF @PASO = 1 SELECT @SSQL2 = @Valor
		SELECT @PASO = @PASO + 1
		SELECT @Campos = @SSQL1
		SELECT @Variables = @SSQL2
		if @PASO = 2 SELECT @PASO = 0
	  END
	  
	  IF @Accion = 'ASIGNACTO>CTE'
	  BEGIN
	    SELECT @SQL = 'SELECT @Valor = Valor '+ ' FROM #CRMDatosXML WHERE Campo = ''' + @CampoExt + ''''
	    EXECUTE sp_executesql @SQL, N'@Valor varchar(max) OUTPUT', @Valor OUTPUT
		IF @PASO = 0 SELECT @SSQL1 = @Valor
		IF @PASO = 1 SELECT @SSQL2 = @Valor
		SELECT @PASO = @PASO + 1
		SELECT @Campos = @SSQL1
		SELECT @Variables = @SSQL2
		if @PASO = 2 SELECT @PASO = 0
	  END
	  
	  IF @Accion = 'BORRACTO>PRO'
	  BEGIN
	    SELECT @SQL = 'SELECT @Valor = Valor '+ ' FROM #CRMDatosXML WHERE Campo = ''' + @CampoExt + ''''
	    EXECUTE sp_executesql @SQL, N'@Valor varchar(max) OUTPUT', @Valor OUTPUT
		IF @PASO = 0 SELECT @SSQL1 = @Valor
		IF @PASO = 1 SELECT @SSQL2 = @Valor
		SELECT @PASO = @PASO + 1
		SELECT @Campos = @SSQL1
		SELECT @Variables = @SSQL2
		if @PASO = 2 SELECT @PASO = 0
	  END
	  
	  IF @Accion = 'ASIGNACTO>PRO'
	  BEGIN
	    SELECT @SQL = 'SELECT @Valor = Valor '+ ' FROM #CRMDatosXML WHERE Campo = ''' + @CampoExt + ''''
	    EXECUTE sp_executesql @SQL, N'@Valor varchar(max) OUTPUT', @Valor OUTPUT
		IF @PASO = 0 SELECT @SSQL1 = @Valor
		IF @PASO = 1 SELECT @SSQL2 = @Valor
		SELECT @PASO = @PASO + 1
		SELECT @Campos = @SSQL1
		SELECT @Variables = @SSQL2
		if @PASO = 2 SELECT @PASO = 0
	  END

	  IF @Accion = 'INSERT'
	    SET @Campos = @Campos + @CampoInt + ', '
	  
	  SELECT @SQL = 'SELECT @Valor = Valor '+ ' FROM #CRMDatosXML WHERE Campo = ''' + @CampoExt + ''''
	  EXECUTE sp_executesql @SQL, N'@Valor varchar(max) OUTPUT', @Valor OUTPUT

	  IF @Valor IS NULL
	    SELECT @Valor =''
	    
	  IF @CampoExt = 'StatusCode' AND @Valor = '1'
	    SELECT @Valor = 'ALTA'
	    
	  IF @CampoExt = 'StatusCode' AND @Valor = '2'
	    SELECT @Valor = 'BAJA'

	  IF @BuscarDato= 1
	  BEGIN
	    EXEC spArmaInstruccionCRM 'Busca', @Campoint, @Valor, NULL, NULL, NULL, @TEMP OUTPUT
	    SELECT @Valor= RTRIM(@TEMP)	    	      
	  END
	  
	  IF @idAutomatico= 1
	  BEGIN
	    EXEC spArmaInstruccionCRM 'Consecutivo', @TablaIntelisis, @Valor, NULL, NULL, NULL, @TEMP OUTPUT
	    SELECT @Valor = RTRIM(@TEMP)
	  END

	  IF @BuscarDato= 1 AND @idAutomatico= 0
	  BEGIN
	    EXEC spArmaInstruccionCRM 'Busca', @Campoint, @Valor, NULL, NULL, NULL, @TEMP OUTPUT
	    SELECT @Valor = RTRIM(@TEMP)
	  END
	    
	  IF @DefaultInsert IS NOT NULL
	    SELECT @Valor = @DefaultInsert

	  IF @Accion = 'INSERT'
	    SELECT @Variables = ISNULL(@Variables,'') + '''' +ISNULL(@Valor,'') + ''', '
	  ELSE
	  IF @Valor<>'' AND @Accion <> 'UPDATE'
	    SET @Campos = @Campos + @CampoInt + '= ''' + @Valor + ''', '
	END

	  IF @Accion = 'UPDATE'
	  BEGIN
	    SELECT @SQL = 'SELECT @Valor = Valor '+ ' FROM #CRMDatosXML WHERE Campo = ''' + @CampoExt + ''''
	    EXECUTE sp_executesql @SQL, N'@Valor varchar(max) OUTPUT', @Valor OUTPUT
	    IF @Valor IS NULL SELECT @Valor =''
	    IF @CampoExt = 'StatusCode' AND @Valor = '1'
	      SELECT @Valor = 'ALTA'
	    IF @CampoExt = 'StatusCode' AND @Valor = '2'
	      SELECT @Valor = 'BAJA'
	    IF @BuscarDato= 1
	    BEGIN
	      SELECT @SQL = 'EXEC [' + @Servidor + '].[' + @Base + '].dbo.spBuscaDatoCRM ''' + 'Busca'',''' + @Campoint + ''', ''' + @Valor + ''', @TEMP OUTPUT'	      
	      IF @ModoDebug = 1
	        PRINT (@Campos)
	      ELSE	     
	        EXEC sp_executesql @SQL, N'@TEMP varchar(max) OUTPUT', @TEMP = @TEMP OUTPUT

	      SELECT @Valor= RTRIM(@TEMP)
	    END
	    
	    IF @DefaultInsert IS NOT NULL
	      SELECT @Valor= @DefaultInsert
	    IF @Valor<>''
	      SET @Campos = @Campos + @CampoInt + '= ''' + @Valor + ''', '
	  END


	IF @Bandera = 0
	BEGIN
	  SELECT @CRMID = @Valor
	  SELECT @Bandera = 1
	END
    FETCH NEXT FROM crTablaSyncroCRM
    INTO @TablaIntelisis, @Campoint, @CampoExt, @idAutomatico, @BuscarDato, @DefaultInsert, @AccionEspecifica
  END
  CLOSE crTablaSyncroCRM
  DEALLOCATE crTablaSyncroCRM

  IF @Campos<>''
  BEGIN 
    EXEC spArmaInstruccionCRM @Accion, @TablaIntelisis, @Campos, @Variables, @ModoDebug, @CRMID
  END				
  
  IF @Ok IS NULL
  BEGIN
    SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL('CRM.CRM','') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL('','') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max),'') + '</Resultado></Intelisis>'
    IF @@ERROR <> 0 SET @Ok = 1
  END
  EXEC spSetInformacionContexto CRM, 0
  RETURN
END
GO

/**************** spIntelisisServiceProcesar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisServiceProcesar') and type = 'P') drop procedure dbo.spIntelisisServiceProcesar
GO             
CREATE PROCEDURE spIntelisisServiceProcesar
				@ID	int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Sistema			varchar(100),
    @Contenido			varchar(100),
    @Referencia			varchar(100),
    @SubReferencia		varchar(100),
    @Version			float,
    @Estatus			varchar(15),
    @EstatusNuevo		varchar(15),
    @Solicitud			varchar(max),
    @iSolicitud			int,
    @Resultado			varchar(max),
    @Ok  int,
    @OkRef				varchar(255),
    @CambiarEstatus		bit

  SELECT @Ok = NULL, @OkRef = NULL, @CambiarEstatus = 1

  SELECT @Sistema = Sistema, @Contenido = Contenido, @Referencia = Referencia, @SubReferencia = SubReferencia, @Version = Version, @Estatus = Estatus, @Solicitud = Solicitud
  FROM IntelisisService
  WHERE ID = @ID

  IF @Estatus = 'SINPROCESAR'
  BEGIN
    IF @Sistema IN ('CRM')
    BEGIN
      IF @Contenido = 'Solicitud'
      BEGIN
        EXEC sp_xml_preparedocument @iSolicitud OUTPUT, @Solicitud

        IF @Referencia = 'CRM.CRM'
          EXEC spISCRM @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @CambiarEstatus OUTPUT

        EXEC sp_xml_removedocument @iSolicitud

        IF @CambiarEstatus = 1
        BEGIN
          IF @Ok IS NULL OR @OK = 80030
            SELECT @EstatusNuevo = 'PROCESADO'
          ELSE
            SELECT @EstatusNuevo = 'ERROR'

          UPDATE IntelisisService
          SET Estatus = @EstatusNuevo, Resultado = @Resultado, Ok = @Ok, OkRef = @OkRef
          WHERE ID = @ID
        END
      END
    END
  END

  RETURN
END
GO

/**************** spIntelisisService ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisService') and type = 'P') drop procedure dbo.spIntelisisService
GO             
CREATE PROCEDURE spIntelisisService
			@Usuario			varchar(10),
			@Contrasena			varchar(32),
			@Solicitud			varchar(max),			
			@Resultado			varchar(max)	= NULL	OUTPUT,
		  	@Ok  int				= NULL  OUTPUT,
		  	@OkRef				varchar(255)	= NULL  OUTPUT,		  
			@Procesar			bit				= 1,
			@EliminarProcesado	bit				= 1,
			@ID  int				= NULL  OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @iSolicitud  	int,
    @Contenido  	varchar(100),
    @Sistema  	varchar(100),
    @Referencia  	varchar(100),
    @SubReferencia  varchar(100),
    @Version  	float,
    @ISDiasResguardoSolicitud		int,
    @FechaDepuracion				datetime

  --SELECT @ISDiasResguardoSolicitud = ISDiasResguardoSolicitud FROM Version   

  IF EXISTS(SELECT * FROM CfgIntelisis WHERE Usuario = @Usuario AND Contrasena = @Contrasena)
  BEGIN
    EXEC sp_xml_preparedocument @iSolicitud OUTPUT, @Solicitud

    SELECT @Sistema = Sistema, @Contenido = Contenido, @Referencia = Referencia, @SubReferencia = SubReferencia, @Version = Version
    FROM OPENXML(@iSolicitud, '/Intelisis', 1) WITH (Sistema varchar(100), Contenido varchar(100), Referencia varchar(100), SubReferencia varchar(100), Version FLOAT)

    EXEC sp_xml_removedocument @iSolicitud

    INSERT IntelisisService (Sistema, Contenido, Referencia, SubReferencia, Version, Usuario, Solicitud)
    VALUES (@Sistema, @Contenido, @Referencia, @SubReferencia, @Version, @Usuario, @Solicitud)

    SELECT @ID = SCOPE_IDENTITY()

    IF @Procesar = 1
    BEGIN
      EXEC spIntelisisServiceProcesar @ID

      SELECT @Resultado = Resultado, @Ok = Ok, @OkRef = OkRef
      FROM IntelisisService
      WHERE ID = @ID

      IF @EliminarProcesado = 1
        DELETE IntelisisService
        WHERE ID = @ID
    END

    --SELECT @FechaDepuracion = dbo.fnFechaSinHora(DATEADD(DAY, 0 - (@ISDiasResguardoSolicitud + 1), GETDATE()))

    DELETE
    FROM IntelisisService
    WHERE Estatus = 'PROCESADO' AND FechaEstatus <= @FechaDepuracion
  END
  ELSE
    SELECT @Ok = 3, @OkRef = @Usuario

  RETURN
END
GO

--INSERT SystemUserBase (AccessMode, ActiveDirectoryGuid, BusinessUnitId, CalendarId, CALType, CreatedBy, DefaultFiltersPopulated, DisplayInServiceViews, DomainName, EmailRouterAccessApproval, FirstName, FullName, HomePhone, IncomingEmailDeliveryMethod, InternalEMailAddress, InviteStatusCode, IsActiveDirectoryUser, IsDisabled, IsIntegrationUser, LastName, ModifiedBy, OrganizationId, OutgoingEmailDeliveryMethod, PreferredAddressCode, PreferredEmailCode, SetupUser, SystemUserId, VersionNumber, YomiFullName)
--SELECT 0, '4DEA22A6-0E7C-40FE-A63D-F6CB46E097F9', '0CF86EF3-AF25-E111-B169-00163E33D990', '07962CA7-98AA-499E-AF4B-E92FA399B074', 0, 'EF0B6FF3-AF25-E111-B169-00163E33D990', 0, 0, 'INTELISISDEMO\dongay', 0, 'David Ongay', 'David Ongay', 14, 1, '', 0, 1, 0, 0, 'David Ongay', 'EF0B6FF3-AF25-E111-B169-00163E33D990', 'BD51CD26-2C0F-45CD-9060-E129696DDEF0', 1, 1, 1, 0, 'FF62F2F9-6D1C-4779-AE1E-15E3E63388E2', 'AAAAAAAFIlw=', 'David Ongaykjdffkgdf'

/*
DELETE IntelisisService

SELECT TELEFONOS, * FROM [labprod3].[IntelisisCRM].dbo.AGENTE WHERE CRMID = 'FF62F2F9-6D1C-4779-AE1E-15E3E63388E2'
UPDATE SystemUserBase SET HomePhone = '551' where SystemUserId = 'FF62F2F9-6D1C-4779-AE1E-15E3E63388E2'
SELECT TELEFONOS, * FROM [labprod3].[IntelisisCRM].dbo.AGENTE WHERE CRMID = 'FF62F2F9-6D1C-4779-AE1E-15E3E63388E2'

delete SystemUserBase WHERE SystemUserId = 'B1944CCC-A7C3-4C5D-88DA-419763C2FCC6'
SELECT CRMID, * FROM [labprod3].[IntelisisCRM].dbo.AGENTE WHERE CRMID = 'B1944CCC-A7C3-4C5D-88DA-419763C2FCC6'
SELECT CRMID, * FROM [labprod3].[IntelisisCRM].dbo.USUARIO WHERE CRMID = 'B1944CCC-A7C3-4C5D-88DA-419763C2FCC6'

insert SystemUserBase(OrganizationId, SystemUserId, BusinessUnitId, DomainName)
SELECT 'BD51CD26-2C0F-45CD-9060-E129696DDEF0', 'B1944CCC-A7C3-4C5D-88DA-419763C2FCC6', '0CF86EF3-AF25-E111-B169-00163E33D990', 'INTELISISDEMO\dongay565464'

SELECT CRMID, * FROM [labprod3].[IntelisisCRM].dbo.AGENTE WHERE CRMID = 'B1944CCC-A7C3-4C5D-88DA-419763C2FCC6'
SELECT CRMID, * FROM [labprod3].[IntelisisCRM].dbo.USUARIO WHERE CRMID = 'B1944CCC-A7C3-4C5D-88DA-419763C2FCC6'
--SELECT CRMID, * FROM [labprod3].[IntelisisCRM].dbo.AGENTE WHERE CRMID <> 'B1944CCC-A7C3-4C5D-88DA-419763C2FCC6' AND AGENTE = ''
--SELECT CRMID, * FROM [labprod3].[IntelisisCRM].dbo.USUARIO WHERE CRMID <> 'B1944CCC-A7C3-4C5D-88DA-419763C2FCC6' AND USUARIO = ''
*/

--DELETE [labprod3].[IntelisisCRM].dbo.AGENTE WHERE CRMID <> 'B1944CCC-A7C3-4C5D-88DA-419763C2FCC6' AND AGENTE = ''
--DELETE [labprod3].[IntelisisCRM].dbo.USUARIO WHERE CRMID <> 'B1944CCC-A7C3-4C5D-88DA-419763C2FCC6' AND USUARIO = ''


--SELECT CRMID, * FROM [labprod3].[IntelisisCRM].dbo.AGENTE WHERE CRMID = 'B1944CCC-A7C3-4C5D-88DA-419763C2FCC6'
--SELECT CRMID, * FROM [labprod3].[IntelisisCRM].dbo.USUARIO WHERE CRMID = 'B1944CCC-A7C3-4C5D-88DA-419763C2FCC6'
--select * from [Labprod3].[CRM].dbo.CalendarBase --WHERE CalendarId = 'FF62F2F9-6D1C-4779-AE1E-15E3E63388E2'
--select * from [Labprod3].[CRM].dbo.SystemUserBase  --WHERE SystemUserId = 'FF62F2F9-6D1C-4779-AE1E-15E3E63388E2'
--select * from [Labprod3].[CRM].dbo.InternalAddressBase --WHERE InternalAddressId = 'FF62F2F9-6D1C-4779-AE1E-15E3E63388E2'
--SELECT * FROM TriggerIntelisis