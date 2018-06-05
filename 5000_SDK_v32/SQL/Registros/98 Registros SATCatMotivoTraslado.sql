SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

/******************* Cat�logo de Motivos de Traslado ***********/
TRUNCATE TABLE SATCatMotivoTraslado
GO
INSERT SATCatMotivoTraslado(Clave, Descripcion) VALUES('01','Env�o de mercancias facturadas con anterioridad')
INSERT SATCatMotivoTraslado(Clave, Descripcion) VALUES('02','Reubicaci�n de mercanc�as propias')
INSERT SATCatMotivoTraslado(Clave, Descripcion) VALUES('03','Env�o de mercanc�as objeto de contrato de consignaci�n')
INSERT SATCatMotivoTraslado(Clave, Descripcion) VALUES('04','Env�o de mercanc�as para posterior enajenaci�n')
INSERT SATCatMotivoTraslado(Clave, Descripcion) VALUES('05','Env�o de mercanc�as propiedad de terceros')
INSERT SATCatMotivoTraslado(Clave, Descripcion) VALUES('99','Otros')
GO