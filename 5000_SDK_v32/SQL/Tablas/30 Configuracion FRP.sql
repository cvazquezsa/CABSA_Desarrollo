
/* Configuracion MS SQL Server */

SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
--drop table EmpresaFRPCfg
GO
/****** Configuracion de la Empresa Vertical Financiera FRP ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgFRP')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgFRP','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgFRP') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgFRP (
	Empresa 			varchar(5)  	NOT NULL,
	CONSTRAINT priEmpresaCfgFRP PRIMARY KEY  CLUSTERED (Empresa)
)
GO
EXEC spALTER_TABLE 'EmpresaCfgFRP', 'ModuloPREV', 'bit NOT NULL DEFAULT 0 WITH VALUES'
--EXEC spALTER_TABLE 'EmpresaCfgFRP', 'TransferirDemas', 'bit NOT NULL DEFAULT 0 WITH VALUES'
--EXEC spALTER_TABLE 'EmpresaCfgFRP', 'VentaTEEstandarTipoDias', 'varchar(10) NULL DEFAULT "Habiles" WITH VALUES'
--EXEC spALTER_TABLE 'EmpresaCfgFRP', 'ClienteFacturaVMOS', 'varchar(10) NULL'


GO
IF NOT EXISTS (SELECT * FROM EmpresaCfgFRP WHERE Empresa='DEMO')
    INSERT INTO EmpresaCfgFRP (Empresa,ModuloPREV) VALUES ('DEMO',0)





