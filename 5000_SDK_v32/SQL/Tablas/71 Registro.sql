/* Registro */
if exists (select * from sysobjects where id = object_id('dbo.CfgRegistroCta') and type = 'U') DROP TABLE CfgRegistroCta
if exists (select * from sysobjects where id = object_id('dbo.MovRegistro')    and type = 'U') DROP TABLE MovRegistro
if exists (select * from sysobjects where id = object_id('dbo.Registro')       and type = 'U') DROP TABLE Registro
if exists (select * from sysobjects where id = object_id('dbo.RegistroD')      and type = 'U') DROP TABLE RegistroD
GO
