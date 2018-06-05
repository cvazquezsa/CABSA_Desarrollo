/* Eliminar Tablas */

if (select version from version) <= 1093 and exists (select * from sysobjects where id = object_id('dbo.OpcionTipo') and type = 'U') 
  drop table dbo.OpcionTipo
GO

if (select version from version) <= 1107 and exists (select * from sysobjects where id = object_id('dbo.CerrarPresupuesto') and type = 'U') 
  drop table dbo.CerrarPresupuesto
GO

if (select version from version) <= 1107 and exists (select * from sysobjects where id = object_id('dbo.ImagenCta') and type = 'U') 
  drop table dbo.ImagenCta
GO

if (select version from version) <= 1107 and exists (select * from sysobjects where id = object_id('dbo.ImagenMov') and type = 'U') 
  drop table dbo.ImagenMov
GO

if (select version from version) <= 1153 and exists (select * from sysobjects where id = object_id('dbo.Sincro') and type = 'U') 
  DROP TABLE dbo.Sincro
GO

if (select version from version) <= 1153 and exists (select * from sysobjects where id = object_id('dbo.SincroExcepCampos') and type = 'U') 
  DROP TABLE dbo.SincroExcepCampos
GO

if (select version from version) <= 1172 and exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgMovMatrizSucursal') and type = 'U') 
  DROP TABLE dbo.EmpresaCfgMovMatrizSucursal
GO

