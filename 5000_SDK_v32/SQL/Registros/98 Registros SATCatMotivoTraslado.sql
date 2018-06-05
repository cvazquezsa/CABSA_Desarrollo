SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

/******************* Catálogo de Motivos de Traslado ***********/
TRUNCATE TABLE SATCatMotivoTraslado
GO
INSERT SATCatMotivoTraslado(Clave, Descripcion) VALUES('01','Envío de mercancias facturadas con anterioridad')
INSERT SATCatMotivoTraslado(Clave, Descripcion) VALUES('02','Reubicación de mercancías propias')
INSERT SATCatMotivoTraslado(Clave, Descripcion) VALUES('03','Envío de mercancías objeto de contrato de consignación')
INSERT SATCatMotivoTraslado(Clave, Descripcion) VALUES('04','Envío de mercancías para posterior enajenación')
INSERT SATCatMotivoTraslado(Clave, Descripcion) VALUES('05','Envío de mercancías propiedad de terceros')
INSERT SATCatMotivoTraslado(Clave, Descripcion) VALUES('99','Otros')
GO