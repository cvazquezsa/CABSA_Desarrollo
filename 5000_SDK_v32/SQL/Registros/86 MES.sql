SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_WARNINGS ON
SET ANSI_PADDING ON
GO


IF NOT EXISTS(SELECT * FROM TipoArticuloMES WHERE Codigo = 0) INSERT INTO TipoArticuloMES (Codigo, Descripcion) VALUES (0, 'Producto Acabado') 
IF NOT EXISTS(SELECT * FROM TipoArticuloMES WHERE Codigo = 1) INSERT INTO TipoArticuloMES (Codigo, Descripcion) VALUES (1, 'Producto Acabado 1')
IF NOT EXISTS(SELECT * FROM TipoArticuloMES WHERE Codigo = 2) INSERT INTO TipoArticuloMES (Codigo, Descripcion) VALUES (2, 'Semielaborado')
IF NOT EXISTS(SELECT * FROM TipoArticuloMES WHERE Codigo = 3) INSERT INTO TipoArticuloMES (Codigo, Descripcion) VALUES (3, 'Trabajo exterior')
IF NOT EXISTS(SELECT * FROM TipoArticuloMES WHERE Codigo = 4) INSERT INTO TipoArticuloMES (Codigo, Descripcion) VALUES (4, 'Materia Prima')
IF NOT EXISTS(SELECT * FROM TipoArticuloMES WHERE Codigo = 99) INSERT INTO TipoArticuloMES (Codigo, Descripcion) VALUES (99, 'Proyecto')
GO
