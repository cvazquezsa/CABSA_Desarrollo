
/* Usuario Intelisis */
if substring(@@version, 1, 25) not in ('Microsoft SQL Server 2005', 'Microsoft SQL Server 2008', 'Microsoft SQL Server 2012', 'Microsoft SQL Server 2014', 'Microsoft SQL Server 2016') 
BEGIN
  if not exists(select * from sysusers where name = 'intelisis')
  BEGIN
    EXEC ("sp_adduser 'intelisis'")
    EXEC ("sp_addrolemember 'db_owner', 'intelisis'")
  END
END
GO

if substring(@@version, 1, 25) not in ('Microsoft SQL Server 2005', 'Microsoft SQL Server 2008', 'Microsoft SQL Server 2012', 'Microsoft SQL Server 2014', 'Microsoft SQL Server 2016') 
BEGIN
  DENY INSERT, UPDATE, DELETE ON Empresa 			TO intelisis
  DENY INSERT, UPDATE, DELETE ON EmpresaFecha			TO intelisis
  DENY INSERT, UPDATE, DELETE ON EmpresaGral			TO intelisis
  DENY INSERT, UPDATE, DELETE ON EmpresaCfg 			TO intelisis
  DENY INSERT, UPDATE, DELETE ON EmpresaCfg2			TO intelisis
  DENY INSERT, UPDATE, DELETE ON EmpresaCfgMov			TO intelisis
  DENY INSERT, UPDATE, DELETE ON EmpresaCfgMovGenera		TO intelisis
  DENY INSERT, UPDATE, DELETE ON EmpresaCfgMovImp		TO intelisis
  DENY INSERT, UPDATE, DELETE ON EmpresaCfgMovEsp		TO intelisis
  DENY INSERT, UPDATE, DELETE ON EmpresaCfgMovAlmacenDef	TO intelisis
  DENY INSERT, UPDATE, DELETE ON EmpresaCfgModulo		TO intelisis
  DENY INSERT, UPDATE, DELETE ON EmpresaCfgValidarFechasEx	TO intelisis
  DENY INSERT, UPDATE, DELETE ON EmpresaCfgCancelarMov		TO intelisis
  DENY INSERT, UPDATE, DELETE ON EmpresaConcepto		TO intelisis
  DENY INSERT, UPDATE, DELETE ON EmpresaConceptoValidar		TO intelisis
  DENY INSERT, UPDATE, DELETE ON EmpresaCfgAcceso		TO intelisis
  DENY INSERT, UPDATE, DELETE ON EmpresaCfgPV			TO intelisis
  DENY INSERT, UPDATE, DELETE ON EmpresaCfgPVCampo		TO intelisis
  DENY INSERT, UPDATE, DELETE ON EmpresaCfgPVEtiqueta		TO intelisis
  DENY INSERT, UPDATE, DELETE ON Usuario			TO intelisis
  DENY INSERT, UPDATE, DELETE ON UsuarioD			TO intelisis
  DENY INSERT, UPDATE, DELETE ON UsuarioCfg2			TO intelisis
  DENY INSERT, UPDATE, DELETE ON UsuarioSucursalAcceso		TO intelisis
  DENY INSERT, UPDATE, DELETE ON UsuarioMovCancelacionEx	TO intelisis
  DENY INSERT, UPDATE, DELETE ON UsuarioAlm			TO intelisis
  DENY INSERT, UPDATE, DELETE ON UsuarioPrecios			TO intelisis
  DENY INSERT, UPDATE, DELETE ON UsuarioAcceso			TO intelisis
  DENY INSERT, UPDATE, DELETE ON Sucursal			TO intelisis
  DENY INSERT, UPDATE, DELETE ON SucursalMovSeguimiento		TO intelisis
  DENY INSERT, UPDATE, DELETE ON CfgWeb				TO intelisis
  DENY INSERT, UPDATE, DELETE ON CfgMovFlujo			TO intelisis
END
GO
