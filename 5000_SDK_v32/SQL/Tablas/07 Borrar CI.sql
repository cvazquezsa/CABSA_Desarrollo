/*  CI */
if (select version from version)<=1296 and exists(select * from syscampo where tabla = 'SaldoC')
BEGIN
  DELETE SysTabla WHERE SysTabla = 'SaldoC'
  DROP TABLE SaldoC
END
GO
if (select version from version)<=1296 and exists(select * from syscampo where tabla = 'AcumC')
BEGIN
  DELETE SysTabla WHERE SysTabla = 'AcumC'
  DROP TABLE AcumC
END
GO
if (select version from version)<=1296 and exists(select * from syscampo where tabla = 'MovCampo')
BEGIN
  DELETE SysTabla WHERE SysTabla = 'MovCampo'
  DROP TABLE MovCampo
END
GO
if (select version from version)<=1296 and exists(select * from syscampo where tabla = 'MovCampoCI')
BEGIN
  DELETE SysTabla WHERE SysTabla = 'MovCampoCI'
  DROP TABLE MovCampoCI
END
GO
if (select version from version)<=1296 and exists(select * from syscampo where tabla = 'MovPoliza')
BEGIN
  DELETE SysTabla WHERE SysTabla = 'MovPoliza'
  DROP TABLE MovPoliza
END
GO
if (select version from version)<=1296 and exists(select * from syscampo where tabla = 'MovPolizaDetalleCI')
BEGIN
  DELETE SysTabla WHERE SysTabla = 'MovPolizaDetalleCI'
  DROP TABLE MovPolizaDetalleCI
END
GO
if (select version from version)<=1296 and exists(select * from syscampo where tabla = 'CID')
BEGIN
  DELETE SysTabla WHERE SysTabla = 'CID'
  DROP TABLE CID
END
GO
if (select version from version)<=1296 and exists(select * from syscampo where tabla = 'MovCampoTipo')
BEGIN
  DELETE SysTabla WHERE SysTabla = 'MovCampoTipo'
  DROP TABLE MovCampoTipo
END
GO
if (select version from version)<=1296 and exists(select * from syscampo where tabla = 'CI')
BEGIN
  DELETE SysTabla WHERE SysTabla = 'CI'
  DROP TABLE CI
END
GO
if (select version from version)<=1296 and exists(select * from syscampo where tabla = 'CIOpCampos')
BEGIN
  DELETE SysTabla WHERE SysTabla = 'CIOpCampos'
  DROP TABLE CIOpCampos
END
GO
if (select version from version)<=1296 and exists(select * from syscampo where tabla = 'CIOpCamposTipo')
BEGIN
  DELETE SysTabla WHERE SysTabla = 'CIOpCamposTipo'
  DROP TABLE CIOpCamposTipo
END
GO
if (select version from version)<=1296 and exists(select * from syscampo where tabla = 'CIOpCamposTipo')
BEGIN
  DELETE SysTabla WHERE SysTabla = 'CIOpPoliza'
  DROP TABLE CIOpPoliza
END
GO
if (select version from version)<=1296 and exists(select * from syscampo where tabla = 'CIOpPolizaCampos')
BEGIN
  DELETE SysTabla WHERE SysTabla = 'CIOpPolizaCampos'
  DROP TABLE CIOpPolizaCampos
END
GO
if (select version from version)<=1296 and exists(select * from syscampo where tabla = 'CIOp')
BEGIN
  DELETE SysTabla WHERE SysTabla = 'CIOp'
  DROP TABLE CIOp
END
GO
if (select version from version)<=1296 and exists(select * from syscampo where tabla = 'CIOpPoliza')
BEGIN
  DELETE SysTabla WHERE SysTabla = 'CIOpPoliza'
  DROP TABLE CIOpPoliza
END
GO
if (select version from version)<=1296 and exists(select * from syscampo where tabla = 'CIConcepto')
BEGIN
  DELETE SysTabla WHERE SysTabla = 'CIConcepto'
  DROP TABLE CIConcepto
END
GO
if (select version from version)<=1296 and exists(select * from syscampo where tabla = 'ConceptoCat')
BEGIN
  DELETE SysTabla WHERE SysTabla = 'ConceptoCat'
  DROP TABLE ConceptoCat
END
GO
if (select version from version)<=1296 and exists(select * from syscampo where tabla = 'ConceptoFam')
BEGIN
  DELETE SysTabla WHERE SysTabla = 'ConceptoFam'
  DROP TABLE ConceptoFam
END
GO
if (select version from version)<=1296 and exists(select * from syscampo where tabla = 'ConceptoGrupo')
BEGIN
  DELETE SysTabla WHERE SysTabla = 'ConceptoGrupo'
  DROP TABLE ConceptoGrupo
END
GO
if (select version from version)<=1296 and exists(select * from syscampo where tabla = 'CIPolizaCampo')
BEGIN
  DELETE SysTabla WHERE SysTabla = 'CIPolizaCampo'
  DROP TABLE CIPolizaCampo
END
GO
if (select version from version)<=1296 and exists(select * from syscampo where tabla = 'CICampoLista')
BEGIN
  DELETE SysTabla WHERE SysTabla = 'CICampoLista'
  DROP TABLE CICampoLista
END
GO
if (select version from version)<=1296 and exists(select * from syscampo where tabla = 'CICampoTipoLista')
BEGIN
  DELETE SysTabla WHERE SysTabla = 'CICampoTipoLista'
  DROP TABLE CICampoTipoLista
END
GO
if (select version from version)<=1296 and exists(select * from syscampo where tabla = 'MovPolizaCI')
BEGIN
  DELETE SysTabla WHERE SysTabla = 'MovPolizaCI'
  DROP TABLE MovPolizaCI
END
GO
if (select version from version)<=1296 and exists(select * from syscampo where tabla = 'ContactoCat')
BEGIN
  DELETE SysTabla WHERE SysTabla = 'ContactoCat'
  DROP TABLE ContactoCat
END
GO
if (select version from version)<=1296 and exists(select * from syscampo where tabla = 'ContactoFam')
BEGIN
  DELETE SysTabla WHERE SysTabla = 'ContactoFam'
  DROP TABLE ContactoFam
END
GO
if (select version from version)<=1296 and exists(select * from syscampo where tabla = 'ContactoGrupo')
BEGIN
  DELETE SysTabla WHERE SysTabla = 'ContactoGrupo'
  DROP TABLE ContactoGrupo
END
GO
if (select version from version)<=1296 and exists(select * from syscampo where tabla = 'Contacto')
BEGIN
  DELETE SysTabla WHERE SysTabla = 'Contacto'
  DROP TABLE Contacto
END
GO
if (select version from version)<=1296 and exists(select * from syscampo where tabla = 'ContactoD')
BEGIN
  DELETE SysTabla WHERE SysTabla = 'ContactoD'
  DROP TABLE ContactoD
END
GO
if exists (select * from sysobjects where id = object_id('dbo.CIOpCamposLista') and type = 'V') drop view dbo.CIOpCamposLista
GO
if exists (select * from sysobjects where id = object_id('dbo.CIOpCamposTipoLista') and type = 'V') drop view dbo.CIOpCamposTipoLista
GO
