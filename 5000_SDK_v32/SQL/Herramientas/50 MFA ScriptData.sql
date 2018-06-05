IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ElementoBasico_Estatus]') AND parent_object_id = OBJECT_ID(N'[dbo].[ElementoBasico]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ElementoBasico_Estatus]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ElementoBasico] DROP CONSTRAINT [DF_ElementoBasico_Estatus]
END
End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_MovContables_cargo]') AND parent_object_id = OBJECT_ID(N'[dbo].[MovContables]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_MovContables_cargo]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[MovContables] DROP CONSTRAINT [DF_MovContables_cargo]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_MovContables_abono]') AND parent_object_id = OBJECT_ID(N'[dbo].[MovContables]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_MovContables_abono]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[MovContables] DROP CONSTRAINT [DF_MovContables_abono]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_RubrosFiscales_Estatus]') AND parent_object_id = OBJECT_ID(N'[dbo].[RubrosFiscales]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_RubrosFiscales_Estatus]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[RubrosFiscales] DROP CONSTRAINT [DF_RubrosFiscales_Estatus]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_SaldosIni_saldoinicial]') AND parent_object_id = OBJECT_ID(N'[dbo].[SaldosIni]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SaldosIni_saldoinicial]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SaldosIni] DROP CONSTRAINT [DF_SaldosIni_saldoinicial]
END


End
GO
/****** Object:  ForeignKey [FK_BaseCalculoRubroFiscal_BasesDeCalculo]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BaseCalculoRubroFiscal_BasesDeCalculo]') AND parent_object_id = OBJECT_ID(N'[dbo].[BaseCalculoRubroFiscal]'))
ALTER TABLE [dbo].[BaseCalculoRubroFiscal] DROP CONSTRAINT [FK_BaseCalculoRubroFiscal_BasesDeCalculo]
GO
/****** Object:  ForeignKey [FK_BaseCalculoRubroFiscal_RubrosFiscales]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BaseCalculoRubroFiscal_RubrosFiscales]') AND parent_object_id = OBJECT_ID(N'[dbo].[BaseCalculoRubroFiscal]'))
ALTER TABLE [dbo].[BaseCalculoRubroFiscal] DROP CONSTRAINT [FK_BaseCalculoRubroFiscal_RubrosFiscales]
GO
/****** Object:  ForeignKey [FK_CuentasRetenciones_CatRetenciones]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CuentasRetenciones_CatRetenciones]') AND parent_object_id = OBJECT_ID(N'[dbo].[CuentasRetenciones]'))
ALTER TABLE [dbo].[CuentasRetenciones] DROP CONSTRAINT [FK_CuentasRetenciones_CatRetenciones]
GO
/****** Object:  ForeignKey [FK_CuentasRetenciones_CuentasContables]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CuentasRetenciones_CuentasContables]') AND parent_object_id = OBJECT_ID(N'[dbo].[CuentasRetenciones]'))
ALTER TABLE [dbo].[CuentasRetenciones] DROP CONSTRAINT [FK_CuentasRetenciones_CuentasContables]
GO
/****** Object:  ForeignKey [FK_CuentaRubro_CuentasContables]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CuentaRubro_CuentasContables]') AND parent_object_id = OBJECT_ID(N'[dbo].[CuentaRubro]'))
ALTER TABLE [dbo].[CuentaRubro] DROP CONSTRAINT [FK_CuentaRubro_CuentasContables]
GO
/****** Object:  ForeignKey [FK_CuentaRubro_RubrosFiscales]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CuentaRubro_RubrosFiscales]') AND parent_object_id = OBJECT_ID(N'[dbo].[CuentaRubro]'))
ALTER TABLE [dbo].[CuentaRubro] DROP CONSTRAINT [FK_CuentaRubro_RubrosFiscales]
GO
/****** Object:  ForeignKey [FK_ElementoBasicoSub_ElementoBasico]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ElementoBasicoSub_ElementoBasico]') AND parent_object_id = OBJECT_ID(N'[dbo].[ElementoBasicoSub]'))
ALTER TABLE [dbo].[ElementoBasicoSub] DROP CONSTRAINT [FK_ElementoBasicoSub_ElementoBasico]
GO
/****** Object:  ForeignKey [FK_Empresa_inhibido]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Empresa_inhibido]') AND parent_object_id = OBJECT_ID(N'[dbo].[empresa_respuesta]'))
ALTER TABLE [dbo].[empresa_respuesta] DROP CONSTRAINT [FK_Empresa_inhibido]
GO
/****** Object:  ForeignKey [FK_Pregunta_inhibido]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Pregunta_inhibido]') AND parent_object_id = OBJECT_ID(N'[dbo].[empresa_respuesta]'))
ALTER TABLE [dbo].[empresa_respuesta] DROP CONSTRAINT [FK_Pregunta_inhibido]
GO
/****** Object:  ForeignKey [FK_Respuesta_inhibido]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Respuesta_inhibido]') AND parent_object_id = OBJECT_ID(N'[dbo].[empresa_respuesta]'))
ALTER TABLE [dbo].[empresa_respuesta] DROP CONSTRAINT [FK_Respuesta_inhibido]
GO
/****** Object:  ForeignKey [FK_MovContables_CuentasContables]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MovContables_CuentasContables]') AND parent_object_id = OBJECT_ID(N'[dbo].[MovContables]'))
ALTER TABLE [dbo].[MovContables] DROP CONSTRAINT [FK_MovContables_CuentasContables]
GO
/****** Object:  ForeignKey [FK_ReporteBaseCalculo_BasesDeCalculo]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ReporteBaseCalculo_BasesDeCalculo]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReporteBaseCalculo]'))
ALTER TABLE [dbo].[ReporteBaseCalculo] DROP CONSTRAINT [FK_ReporteBaseCalculo_BasesDeCalculo]
GO
/****** Object:  ForeignKey [FK_ReporteBaseCalculo_Reportes]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ReporteBaseCalculo_Reportes]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReporteBaseCalculo]'))
ALTER TABLE [dbo].[ReporteBaseCalculo] DROP CONSTRAINT [FK_ReporteBaseCalculo_Reportes]
GO
/****** Object:  ForeignKey [FK_RubrosFiscales_RubrosFiscales]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RubrosFiscales_RubrosFiscales]') AND parent_object_id = OBJECT_ID(N'[dbo].[RubrosFiscales]'))
ALTER TABLE [dbo].[RubrosFiscales] DROP CONSTRAINT [FK_RubrosFiscales_RubrosFiscales]
GO
/****** Object:  ForeignKey [FK_PreguntasInh]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_PreguntasInh]') AND parent_object_id = OBJECT_ID(N'[dbo].[rubros_inhibidos]'))
ALTER TABLE [dbo].[rubros_inhibidos] DROP CONSTRAINT [FK_PreguntasInh]
GO
/****** Object:  ForeignKey [FK_RespuestasInh]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RespuestasInh]') AND parent_object_id = OBJECT_ID(N'[dbo].[rubros_inhibidos]'))
ALTER TABLE [dbo].[rubros_inhibidos] DROP CONSTRAINT [FK_RespuestasInh]
GO
/****** Object:  ForeignKey [FK_RubrosInh]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RubrosInh]') AND parent_object_id = OBJECT_ID(N'[dbo].[rubros_inhibidos]'))
ALTER TABLE [dbo].[rubros_inhibidos] DROP CONSTRAINT [FK_RubrosInh]
GO
/****** Object:  ForeignKey [FK_SaldosIni_CuentasContables]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SaldosIni_CuentasContables]') AND parent_object_id = OBJECT_ID(N'[dbo].[SaldosIni]'))
ALTER TABLE [dbo].[SaldosIni] DROP CONSTRAINT [FK_SaldosIni_CuentasContables]
GO
/****** Object:  Table [dbo].[MovContables]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MovContables]') AND type in (N'U'))
DROP TABLE [dbo].[MovContables]
GO
/****** Object:  Table [dbo].[CuentaRubro]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CuentaRubro]') AND type in (N'U'))
DROP TABLE [dbo].[CuentaRubro]
GO
/****** Object:  Table [dbo].[CuentasRetenciones]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CuentasRetenciones]') AND type in (N'U'))
DROP TABLE [dbo].[CuentasRetenciones]
GO
/****** Object:  Table [dbo].[rubros_inhibidos]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rubros_inhibidos]') AND type in (N'U'))
DROP TABLE [dbo].[rubros_inhibidos]
GO
/****** Object:  Table [dbo].[ReporteBaseCalculo]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReporteBaseCalculo]') AND type in (N'U'))
DROP TABLE [dbo].[ReporteBaseCalculo]
GO
/****** Object:  Table [dbo].[SaldosIni]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SaldosIni]') AND type in (N'U'))
DROP TABLE [dbo].[SaldosIni]
GO
/****** Object:  Table [dbo].[ElementoBasicoSub]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ElementoBasicoSub]') AND type in (N'U'))
DROP TABLE [dbo].[ElementoBasicoSub]
GO
/****** Object:  Table [dbo].[BaseCalculoRubroFiscal]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BaseCalculoRubroFiscal]') AND type in (N'U'))
DROP TABLE [dbo].[BaseCalculoRubroFiscal]
GO
/****** Object:  Table [dbo].[BasesDeCalculo]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BasesDeCalculo]') AND type in (N'U'))
DROP TABLE [dbo].[BasesDeCalculo]
GO
/****** Object:  Table [dbo].[RubrosFiscales]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RubrosFiscales]') AND type in (N'U'))
DROP TABLE [dbo].[RubrosFiscales]
GO
/****** Object:  Table [dbo].[DatosIetu]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DatosIetu]') AND type in (N'U'))
DROP TABLE [dbo].[DatosIetu]
GO
/****** Object:  Table [dbo].[CatRetenciones]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatRetenciones]') AND type in (N'U'))
DROP TABLE [dbo].[CatRetenciones]
GO
/****** Object:  Table [dbo].[Reportes]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Reportes]') AND type in (N'U'))
DROP TABLE [dbo].[Reportes]
GO
/****** Object:  Table [dbo].[respuestas_inhibicion]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[respuestas_inhibicion]') AND type in (N'U'))
DROP TABLE [dbo].[respuestas_inhibicion]
GO
/****** Object:  Table [dbo].[empresa_respuesta]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[empresa_respuesta]') AND type in (N'U'))
DROP TABLE [dbo].[empresa_respuesta]
GO
/****** Object:  Table [dbo].[ximpiva]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ximpiva]') AND type in (N'U'))
DROP TABLE [dbo].[ximpiva]
GO
/****** Object:  Table [dbo].[CuentasContables]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CuentasContables]') AND type in (N'U'))
DROP TABLE [dbo].[CuentasContables]
GO
/****** Object:  Table [dbo].[preguntas_inhibicion]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[preguntas_inhibicion]') AND type in (N'U'))
DROP TABLE [dbo].[preguntas_inhibicion]
GO
/****** Object:  Table [dbo].[PartidaFinanciera]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PartidaFinanciera]') AND type in (N'U'))
DROP TABLE [dbo].[PartidaFinanciera]
GO

/**************************************************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Empresa]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Empresa](
	[Empresa] [varchar](5) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[RFC] [nvarchar](15) NOT NULL,
	[Grupo] [nvarchar](100) NULL,
	[Calle] [nvarchar](100) NULL,
	[NumExt] [nvarchar](20) NULL,
	[NumInt] [nvarchar](20) NULL,
	[Colonia] [nvarchar](30) NULL,
	[DelegacionMuni] [nvarchar](30) NULL,
	[Estado] [nvarchar](30) NULL,
	[Pais] [nvarchar](30) NULL,
	[CodigoPostal] [nvarchar](15) NULL,
	[Telefono] [nvarchar](100) NULL,
	[Fax] [nvarchar](50) NULL,
	[Encabezado1] [nvarchar](255) NULL,
	[Encabezado2] [nvarchar](255) NULL,
	[RegistroPatronal] [nvarchar](20) NULL,
	[ClaveActividad] [nvarchar](20) NULL,
	[Representante] [nvarchar](100) NULL,
	[RepresentanteRFC] [nvarchar](20) NULL,
	[RepresentanteCURP] [nvarchar](20) NULL,
	[Zona] [nvarchar](50) NULL,
	[Controladora] [nvarchar](5) NULL,
	[FiscalRegimen] [nvarchar](30) NULL,
	[RutaServer] [nvarchar](100) NULL,
	[Estatus] [bit]  NULL,
 CONSTRAINT [PK_Empresas] PRIMARY KEY CLUSTERED 
(
	[Empresa] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END 
GO

/**************************************************************************************************************************************/

/****** Object:  Table [dbo].[ElementoBasico]    Script Date: 09/12/2012 03:04:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ElementoBasico]') AND type in (N'U'))
DROP TABLE [dbo].[ElementoBasico]
GO
/****** Object:  Table [dbo].[preguntas_inhibicion]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[preguntas_inhibicion]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[preguntas_inhibicion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Pregunta] [varchar](200) NOT NULL,
	[Explicacion] [text] NULL,
	[Grupo] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[preguntas_inhibicion] ON
INSERT [dbo].[preguntas_inhibicion] ([id], [Pregunta], [Explicacion], [Grupo]) VALUES (1, N'¿Tipo de sector al que pertenece?', N'La empresa del sector servicios es la que presta sus obligaciones a favor de otra, cualquiera que sea el acto que le de origen y el nombre o clasificación que a dicho acto le otorguen otras personas.
es aquella empresa que tiene su base fija o establecimiento en el país donde presta sus servicios; constituye la base fija, cualquier lugar en el que se presten servicios de carácter científico, literario, artístico, educativo o pedagógico, entre otros, y las profesiones independientes.
las empresas comerciales son las que de conformidad con las leyes federales tienen ese carácter comercial y no están comprendidas dentro de las empresas industriales, agrícolas, ganaderas, de pesca y las silvícolas.
las industriales se dedican a la extracción, conservación o transformación de materias primas, acabado de productos y la elaboración de satisfactores; si es persona moral del sector industrial el sistema imprime el anexo c de la forma fiscal 2, si es controladora y del sector industrial ocupa el anexo iii de la forma fiscal 2-a  y si es persona física del sector industrial utiliza el anexo 4 bis.', 2)
INSERT [dbo].[preguntas_inhibicion] ([id], [Pregunta], [Explicacion], [Grupo]) VALUES (2, N'¿Realiza operaciones en la región fronteriza?', N'Es la compra de bienes y/o la adquisición de servicios gravados al 10% de IVA, siempre que la mercancía o servicio sea recibida en la citada región fronteriza.  se considera como región fronteriza, además de la franja fronteriza de 20 kilómetros paralela a las líneas divisorias internacionales del norte y sur del país, todo el territorio de los estados de baja california norte y sur, y quintana roo. ', 1)
INSERT [dbo].[preguntas_inhibicion] ([id], [Pregunta], [Explicacion], [Grupo]) VALUES (3, N'¿Realiza operaciones en moneda extranjera?', N' Es la adquisición de bienes y/o servicios con empresas situadas fuera del territorio nacional.', 1)
INSERT [dbo].[preguntas_inhibicion] ([id], [Pregunta], [Explicacion], [Grupo]) VALUES (4, N'¿Es empresa controladora?', N'Para que una Empresa se considere como controladora debe de reunir los siguientes requisitos
i. que se trate de una sociedad residente en méxico.
ii. que sean propietarias de mas del 50% de las acciones con derecho a voto de otra u otras sociedades controladas, inclusive cuando dicha propiedad se tenga por conducto de otras sociedades que a su vez sean controladas por la misma controladora.
iii. que en ningún caso más del 50% de sus acciones con derecho a voto sean propiedad de otra u otras sociedades, salvo que dichas sociedades sean residentes en algún país con el que se tenga acuerdo amplio de intercambio de información. para estos efectos no se computarán sus acciones que se coloquen entre el gran público inversionista, de conformidad con las reglas que al efecto dicte la secretaría  de hacienda y crédito público.', 1)
INSERT [dbo].[preguntas_inhibicion] ([id], [Pregunta], [Explicacion], [Grupo]) VALUES (5, N'¿Método de inventarios para determinar el costo de ventas?', N'', 3)
SET IDENTITY_INSERT [dbo].[preguntas_inhibicion] OFF
/****** Object:  Table [dbo].[CuentasContables]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CuentasContables]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CuentasContables](
	[CuentaContable] [nvarchar](60) NOT NULL,
	[CuentaControl] [nvarchar](60) NULL,
	[Nivel] [int] NOT NULL,
	[Descripcion] [nvarchar](150) NULL,
	[Clase] [nvarchar](1) NOT NULL,
	[Tipo] [nvarchar](2) NULL,
	[Moneda] [nvarchar](10) NULL,
 CONSTRAINT [PK_CuentasContables] PRIMARY KEY CLUSTERED 
(
	[CuentaContable] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'CuentasContables', N'COLUMN',N'CuentaContable'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'numero de cuenta contable' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CuentasContables', @level2type=N'COLUMN',@level2name=N'CuentaContable'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'CuentasContables', N'COLUMN',N'CuentaControl'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'cuenta de control a la que pertenece la cuenta contable' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CuentasContables', @level2type=N'COLUMN',@level2name=N'CuentaControl'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'CuentasContables', N'COLUMN',N'Nivel'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'nivel de la cuenta contable' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CuentasContables', @level2type=N'COLUMN',@level2name=N'Nivel'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'CuentasContables', N'COLUMN',N'Descripcion'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'descripcion de la cuenta contable' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CuentasContables', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'CuentasContables', N'COLUMN',N'Clase'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'clase de cuenta contable (C=control, R=registro)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CuentasContables', @level2type=N'COLUMN',@level2name=N'Clase'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'CuentasContables', N'COLUMN',N'Tipo'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'tipo de cuenta contable (A=activo, P=pasivo, etc)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CuentasContables', @level2type=N'COLUMN',@level2name=N'Tipo'
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ximpiva]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ximpiva](
	[identify] [int] IDENTITY(1,1) NOT NULL,
	[id] [varchar](50) NOT NULL,
	[empresa] [varchar](5) NOT NULL,
	[cheque] [varchar](100) NOT NULL,
	[mov] [varchar](200) NOT NULL,
	[nombre] [varchar](150) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[ejercicio] [numeric](4, 0) NULL,
	[periodo] [numeric](2, 0) NULL,
	[tipoiva] [numeric](2, 0) NOT NULL,
	[tipoopera] [numeric](2, 0) NOT NULL,
	[importe] [numeric](18, 4) NOT NULL,
	[tasa] [numeric](2, 2) NOT NULL,
	[iva] [numeric](18, 4) NOT NULL,
	[origen] [numeric](2, 0) NOT NULL,
	[rfc] [varchar](15) NULL,
	[idfiscal] [varchar](50) NULL,
	[tipoter] [varchar](10) NULL,
	[tipoope] [varchar](10) NULL,
	[cvepais] [varchar](20) NULL,
	[naciona] [varchar](50) NULL,
	[reten2] [numeric](18, 4) NULL,
 CONSTRAINT [PK_ximpiva] PRIMARY KEY CLUSTERED 
(
	[identify] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[empresa_respuesta]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[empresa_respuesta]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[empresa_respuesta](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Empresa] [varchar](5) NOT NULL,
	[Pregunta] [int] NOT NULL,
	[Respuesta] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[respuestas_inhibicion]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[respuestas_inhibicion]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[respuestas_inhibicion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Respuesta] [varchar](100) NOT NULL,
	[Explicacion] [text] NULL,
	[Grupo] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[respuestas_inhibicion] ON
INSERT [dbo].[respuestas_inhibicion] ([id], [Respuesta], [Explicacion], [Grupo]) VALUES (1, N'Si', N'', 1)
INSERT [dbo].[respuestas_inhibicion] ([id], [Respuesta], [Explicacion], [Grupo]) VALUES (2, N'No', N'', 1)
INSERT [dbo].[respuestas_inhibicion] ([id], [Respuesta], [Explicacion], [Grupo]) VALUES (3, N'Industrial', N'', 2)
INSERT [dbo].[respuestas_inhibicion] ([id], [Respuesta], [Explicacion], [Grupo]) VALUES (4, N'Comercial', N'', 2)
INSERT [dbo].[respuestas_inhibicion] ([id], [Respuesta], [Explicacion], [Grupo]) VALUES (5, N'Servicios', N'', 2)
INSERT [dbo].[respuestas_inhibicion] ([id], [Respuesta], [Explicacion], [Grupo]) VALUES (6, N'Perpetuos', N'', 3)
INSERT [dbo].[respuestas_inhibicion] ([id], [Respuesta], [Explicacion], [Grupo]) VALUES (7, N'Periodicos', N'', 3)
SET IDENTITY_INSERT [dbo].[respuestas_inhibicion] OFF
/****** Object:  Table [dbo].[Reportes]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Reportes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Reportes](
	[Reporte] [int] NOT NULL,
	[Nombre] [nvarchar](50) NULL,
 CONSTRAINT [PK_Reportes_1] PRIMARY KEY CLUSTERED 
(
	[Reporte] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'Reportes', N'COLUMN',N'Reporte'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'clave o numero del reporte' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reportes', @level2type=N'COLUMN',@level2name=N'Reporte'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'Reportes', N'COLUMN',N'Nombre'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'nombre de la base de caclulo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reportes', @level2type=N'COLUMN',@level2name=N'Nombre'
GO
INSERT [dbo].[Reportes] ([Reporte], [Nombre]) VALUES (20, N'Estado de posición financiera                     ')
INSERT [dbo].[Reportes] ([Reporte], [Nombre]) VALUES (30, N'Estado de resultados contable                     ')
INSERT [dbo].[Reportes] ([Reporte], [Nombre]) VALUES (31, N'Estado de resultados fiscal                       ')
INSERT [dbo].[Reportes] ([Reporte], [Nombre]) VALUES (40, N'Conciliación contable fiscal                      ')
INSERT [dbo].[Reportes] ([Reporte], [Nombre]) VALUES (45, N'Datos de algunas deducciones autorizadas          ')
INSERT [dbo].[Reportes] ([Reporte], [Nombre]) VALUES (50, N'Participación de los trabajadores en las utilidade')
INSERT [dbo].[Reportes] ([Reporte], [Nombre]) VALUES (60, N'Pagos provisionales de ISR personas morales       ')
INSERT [dbo].[Reportes] ([Reporte], [Nombre]) VALUES (61, N'Pagos provisionales de ISR personas físicas       ')
INSERT [dbo].[Reportes] ([Reporte], [Nombre]) VALUES (65, N'Ajuste por inflación                              ')
INSERT [dbo].[Reportes] ([Reporte], [Nombre]) VALUES (70, N'IMPAC                                             ')
INSERT [dbo].[Reportes] ([Reporte], [Nombre]) VALUES (80, N'Retenciones                                       ')
INSERT [dbo].[Reportes] ([Reporte], [Nombre]) VALUES (90, N'Pasivos no deducibles                             ')
INSERT [dbo].[Reportes] ([Reporte], [Nombre]) VALUES (100, N'Reservas y pagos anticipados                      ')
INSERT [dbo].[Reportes] ([Reporte], [Nombre]) VALUES (110, N'Anticipos de clientes                             ')
INSERT [dbo].[Reportes] ([Reporte], [Nombre]) VALUES (120, N'Determinación de compras                          ')
INSERT [dbo].[Reportes] ([Reporte], [Nombre]) VALUES (130, N'Cuenta de capital de aportación                   ')
INSERT [dbo].[Reportes] ([Reporte], [Nombre]) VALUES (160, N'Costo de lo vendido fiscal (perpetuos)            ')
INSERT [dbo].[Reportes] ([Reporte], [Nombre]) VALUES (161, N'Costo de ventas contable (perpetuos)              ')
INSERT [dbo].[Reportes] ([Reporte], [Nombre]) VALUES (162, N'Costo de ventas contable (periódicos)             ')
INSERT [dbo].[Reportes] ([Reporte], [Nombre]) VALUES (163, N'Costo de lo vendido fiscal (periódicos)           ')
INSERT [dbo].[Reportes] ([Reporte], [Nombre]) VALUES (170, N'Determinación del Impuesto Sobre la Renta         ')
INSERT [dbo].[Reportes] ([Reporte], [Nombre]) VALUES (171, N'Impuesto Empresarial a Tasa Única                 ')
INSERT [dbo].[Reportes] ([Reporte], [Nombre]) VALUES (172, N'Impuesto al Valor Agregado                        ')
/****** Object:  Table [dbo].[CatRetenciones]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatRetenciones]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CatRetenciones](
	[IdRetencion] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
	[Porcentaje] [numeric](3, 2) NOT NULL,
	[Ejercicio] [int] NOT NULL,
 CONSTRAINT [PK_CatRetenciones] PRIMARY KEY CLUSTERED 
(
	[IdRetencion] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[CatRetenciones] ON
INSERT [dbo].[CatRetenciones] ([IdRetencion], [Descripcion], [Porcentaje], [Ejercicio]) VALUES (1, N'ISR retenido por salario', CAST(0.00 AS Numeric(3, 2)), 2012)
INSERT [dbo].[CatRetenciones] ([IdRetencion], [Descripcion], [Porcentaje], [Ejercicio]) VALUES (2, N'ISR retenido por pagos al extranjero', CAST(0.00 AS Numeric(3, 2)), 2012)
INSERT [dbo].[CatRetenciones] ([IdRetencion], [Descripcion], [Porcentaje], [Ejercicio]) VALUES (3, N'Otras retenciones', CAST(0.00 AS Numeric(3, 2)), 2012)
INSERT [dbo].[CatRetenciones] ([IdRetencion], [Descripcion], [Porcentaje], [Ejercicio]) VALUES (4, N'Retenciones de IVA', CAST(0.00 AS Numeric(3, 2)), 2012)
INSERT [dbo].[CatRetenciones] ([IdRetencion], [Descripcion], [Porcentaje], [Ejercicio]) VALUES (5, N'Subsidio al empleo pagado', CAST(0.00 AS Numeric(3, 2)), 2012)
INSERT [dbo].[CatRetenciones] ([IdRetencion], [Descripcion], [Porcentaje], [Ejercicio]) VALUES (6, N'IDE Retenido', CAST(0.00 AS Numeric(3, 2)), 2012)
INSERT [dbo].[CatRetenciones] ([IdRetencion], [Descripcion], [Porcentaje], [Ejercicio]) VALUES (7, N'ISR retenido asimilados a salarios', CAST(0.00 AS Numeric(3, 2)), 2012)
INSERT [dbo].[CatRetenciones] ([IdRetencion], [Descripcion], [Porcentaje], [Ejercicio]) VALUES (8, N'ISR retenido servicios profesionales', CAST(0.00 AS Numeric(3, 2)), 2012)
INSERT [dbo].[CatRetenciones] ([IdRetencion], [Descripcion], [Porcentaje], [Ejercicio]) VALUES (9, N'ISR retenido uso o goce temporal de bienes', CAST(0.00 AS Numeric(3, 2)), 2012)
INSERT [dbo].[CatRetenciones] ([IdRetencion], [Descripcion], [Porcentaje], [Ejercicio]) VALUES (10, N'No Asignado', CAST(0.00 AS Numeric(3, 2)), 2012)
SET IDENTITY_INSERT [dbo].[CatRetenciones] OFF
/****** Object:  Table [dbo].[DatosIetu]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DatosIetu]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DatosIetu](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[empresa] [varchar](5) NOT NULL,
	[movimiento] [varchar](50) NOT NULL,
	[nocliente] [varchar](20) NOT NULL,
	[nombre] [varchar](150) NOT NULL,
	[concepto] [varchar](200) NOT NULL,
	[referencia] [varchar](100) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[ejercicio] [numeric](4, 0) NOT NULL,
	[periodoasi] [numeric](2, 0) NOT NULL,
	[ietu] [numeric](18, 4) NOT NULL,
	[tipo] [numeric](2, 0) NOT NULL,
	[cuenta] [varchar](50) NULL,
	[retencion] [numeric](18, 4) NULL,
	[retencion2] [numeric](18, 4) NULL,
	[impuestos] [numeric](18, 4) NOT NULL,
	[movto] [varchar](50) NULL,
 CONSTRAINT [PK_DatosIetu] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[RubrosFiscales]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RubrosFiscales]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RubrosFiscales](
	[Rubro] [int] NOT NULL,
	[Nombre] [nvarchar](150) NOT NULL,
	[Descripcion] [nvarchar](max) NULL,
	[IdElementoBasico] [int] NULL,
	[Regis] [int] NULL,
	[Clasificacion] [int] NULL,
	[Estatus] [bit] NOT NULL,
 CONSTRAINT [PK_RubrosFiscales] PRIMARY KEY CLUSTERED 
(
	[Rubro] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (100, N'aaaaaaaaaaaa', N'Son los ingresos por enajenación de bienes y/o por la prestación de servicios realizados en territorio nacional, gravados a la tasa del 15% de IVA.

Son ventas brutas, no incluyen las devoluciones, rebajas y descuentos sobre ingresos (rubros 200, 210, 220, 230, 240, 250).

Estos ingresos se obtienen por el giro propio de la empresa,  no incluyen ingresos por partidas discontinuas y extraordinarias (rubros 300, 310, 320, 340, 390, 400, 410, 420, 500, 510, 520, 530, 540, 550, 560, 570, 580, 590, 600, 610, 620, 630, 640).

Son ingresos obtenidos en territorio nacional,  no incluyen los ingresos por exportaciones (rubros 140), ni los ingresos obtenidos por establecimientos en el extranjero (rubro 150).

Son ingresos con IVA al 15%,  no incluyen ingresos exentos de IVA (rubro 100) ni gravados con otras tasas de IVA (rubros 110, 120).

La tasa general del IVA es el 15%, se aplica a todas las personas físicas y morales que, en territorio nacional, realicen ventas o presten servicios independientes.

Fundamento legal LIVA Art. 1, LIVA Art. 10', 9, 3, NULL, 0)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (101, N'bbbbbbbbbb', N'Son los ingresos por enajenación de bienes y/o por la prestación de servicios realizados en territorio nacional, gravados a la tasa del 15% de IVA.

Son ventas brutas, no incluyen las devoluciones, rebajas y descuentos sobre ingresos (rubros 200, 210, 220, 230, 240, 250).

Estos ingresos se obtienen por el giro propio de la empresa,  no incluyen ingresos por partidas discontinuas y extraordinarias (rubros 300, 310, 320, 340, 390, 400, 410, 420, 500, 510, 520, 530, 540, 550, 560, 570, 580, 590, 600, 610, 620, 630, 640).

Son ingresos obtenidos en territorio nacional,  no incluyen los ingresos por exportaciones (rubros 140), ni los ingresos obtenidos por establecimientos en el extranjero (rubro 150).

Son ingresos con IVA al 15%,  no incluyen ingresos exentos de IVA (rubro 100) ni gravados con otras tasas de IVA (rubros 110, 120).

La tasa general del IVA es el 15%, se aplica a todas las personas físicas y morales que, en territorio nacional, realicen ventas o presten servicios independientes.

Fundamento legal LIVA Art. 1, LIVA Art. 10', 10, 3, NULL, 0)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (102, N'aaaaaaa', N'Son los ingresos por enajenación de bienes y/o por la prestación de servicios realizados en territorio nacional, gravados a la tasa del 15% de IVA.

Son ventas brutas, no incluyen las devoluciones, rebajas y descuentos sobre ingresos (rubros 200, 210, 220, 230, 240, 250).

Estos ingresos se obtienen por el giro propio de la empresa,  no incluyen ingresos por partidas discontinuas y extraordinarias (rubros 300, 310, 320, 340, 390, 400, 410, 420, 500, 510, 520, 530, 540, 550, 560, 570, 580, 590, 600, 610, 620, 630, 640).

Son ingresos obtenidos en territorio nacional,  no incluyen los ingresos por exportaciones (rubros 140), ni los ingresos obtenidos por establecimientos en el extranjero (rubro 150).

Son ingresos con IVA al 15%,  no incluyen ingresos exentos de IVA (rubro 100) ni gravados con otras tasas de IVA (rubros 110, 120).

La tasa general del IVA es el 15%, se aplica a todas las personas físicas y morales que, en territorio nacional, realicen ventas o presten servicios independientes.

Fundamento legal LIVA Art. 1, LIVA Art. 10', 7, 3, 1, 0)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (130, N'Ventas brutas de bienes y/o servicios nacionales', N'Son los ingresos por enajenación de bienes y/o por la prestación de servicios realizados en territorio nacional, gravados a la tasa del 15% de IVA.

Son ventas brutas, no incluyen las devoluciones, rebajas y descuentos sobre ingresos (rubros 200, 210, 220, 230, 240, 250).

Estos ingresos se obtienen por el giro propio de la empresa,  no incluyen ingresos por partidas discontinuas y extraordinarias (rubros 300, 310, 320, 340, 390, 400, 410, 420, 500, 510, 520, 530, 540, 550, 560, 570, 580, 590, 600, 610, 620, 630, 640).

Son ingresos obtenidos en territorio nacional,  no incluyen los ingresos por exportaciones (rubros 140), ni los ingresos obtenidos por establecimientos en el extranjero (rubro 150).

Son ingresos con IVA al 15%,  no incluyen ingresos exentos de IVA (rubro 100) ni gravados con otras tasas de IVA (rubros 110, 120).

La tasa general del IVA es el 15%, se aplica a todas las personas físicas y morales que, en territorio nacional, realicen ventas o presten servicios independientes.

Fundamento legal LIVA Art. 1, LIVA Art. 10', 4, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (140, N'Ventas brutas de bienes y/o servicios por exportaciones                                                                 ', N'Son los ingresos por enajenación de bienes y/o la prestación de servicios realizados por residentes en el país a residentes en el extranjero, no incluyen ingresos obtenidos en territorio nacional (rubros 100, 110, 120, 130), ni los obtenidos por establecimientos en el extranjero (rubro 150).

Son ingresos que no incluyen las devoluciones, rebajas y descuentos sobre ingresos (200, 210, 220, 230, 240, 250).

Son ingresos propios de la actividad de la empresa,  no incluyen ingresos por partidas discontinuas y extraordinarias
(rubros 300, 310, 320, 340, 390, 400, 410, 420, 500, 510, 520, 530, 540, 550, 560, 570, 580, 590, 600, 610, 620, 630, 640).

Estos ingresos son gravados a la tasa de 0%

Fundamento legal:  LIVA. Art.  29
', 4, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (150, N'Ventas brutas de bienes y/o servicios en establecimientos en el extranjero                                              ', N'Son los ingresos obtenidos por enajenación de bienes y/o la prestación de servicios en establecimientos de la empresa ubicados en el extranjero.

No incluyen ingresos obtenidos en territorio nacional (rubros 100, 110, 120, 130), ni los obtenidos por exportación (rubro 140).

Son ingresos brutos, por lo tanto no incluyen las devoluciones, rebajas y descuentos sobre ingresos (rubros 200, 210, 220, 230, 240, 250).

Son ventas de bienes y servicios propios de la actividad de la empresa,  no incluyen ingresos por partidas discontinuas y extraordinarias (rubros 300, 310, 320, 340, 390, 400, 410, 420, 500, 510, 520, 530, 540, 550, 560, 570, 580, 590, 600, 610, 620, 630, 640).

Estos ingresos no están gravados con el IVA, ni el IEPS.

Este rubro capta los ingresos que no están afecto al IVA, por ser  actos o actividades se realizan fuera del territorio nacional. LIVA Art. 1
', 4, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (230, N'Devoluciones, rebajas y descuentos s/ventas nacionales                                                                  ', N'Si las mercancías entregadas en venta no reúnen los requisitos solicitados por el comprador, es probable que éste proceda a devolverlas. En este caso, observamos una entrada física de mercancías a la empresa que no corresponde a una compra, esto se conceptúa como devoluciones sobre ventas.

La empresa puede evitar que un cliente devuelva las mercancías vendidas, porque no reúnan éstas los requisitos por él solicitados, o porque se hubiesen deteriorado durante su envío, concediendo a éste que pague un precio más bajo al fijado originalmente, esto se conceptúa como rebajas sobre ventas.

Si la empresa necesita recuperar el importe de las ventas efectuadas a crédito, en un plazo menor al convenido al efectuarse la operación, puede ofrecer a sus clientes una disminución en el precio que se fijo originalmente, esta disminución se hace generalmente mediante un porcentaje. La cantidad que se recibe de menos al recuperar anticipadamente a la fecha de su vencimiento el importe del adeudo de un cliente, se denomina como descuentos sobre ventas.

La empresa puede otorgar precios bajos a aquellos compradores que adquieran un número elevado de unidades, con el fin de incrementar su volumen de ventas. La disminución el precio de venta se conceptúa como bonificaciones sobre ventas.

Estas devoluciones, rebajas y descuentos otorgados a los clientes se hacen sobre las ventas realizadas en territorio nacional, gravadas al 15% de IVA registradas en el rubro 130. No incluye las devoluciones, rebajas y descuentos sobre ventas gravadas con otras tasas de IVA (rubros 200, 210, 220). Tampoco incluye las devoluciones, rebajas y descuentos por ventas de exportación (rubro 240), ni por ventas de establecimientos en el extranjero (rubro 250).
', 4, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (240, N'Devoluciones, rebajas y descuentos s/ventas de exportación                                                              ', N'Si las mercancías entregadas en venta no reúnen los requisitos solicitados por el comprador, es probable que éste proceda a devolverlas. En este caso, observamos una entrada física de mercancías a la empresa que no corresponde a una compra, esto se conceptúa como devoluciones sobre ventas.

La empresa puede evitar que un cliente devuelva las mercancías vendidas, porque no reúnan éstas los requisitos por él solicitados, o porque se hubiesen deteriorado durante su envío, concediendo a éste que pague un precio más bajo al fijado originalmente, esto se conceptúa como rebajas sobre ventas.

Si la empresa necesita recuperar el importe de las ventas efectuadas a crédito, en un plazo menor al convenido al efectuarse la operación, puede ofrecer a sus clientes una disminución en el precio que se fijo originalmente, esta disminución se hace generalmente mediante un porcentaje. La cantidad que se recibe de menos al recuperar anticipadamente a la fecha de su vencimiento el importe del adeudo de un cliente, se denomina como descuentos sobre ventas.

La empresa puede otorgar precios bajos a aquellos compradores que adquieran un número elevado de unidades, con el fin de incrementar su volumen de ventas. La disminución en el precio de venta se conceptúa como bonificaciones sobre ventas.

Estas devoluciones, rebajas y descuentos otorgados a los clientes se hacen sobre las ventas realizadas por residentes en el país a residentes en el extranjero, gravadas al 0% de IVA registradas en el rubro 140. No incluye las devoluciones, rebajas y descuentos sobre ventas gravadas con otras tasas de IVA (rubros 200, 210, 220, 230). Tampoco incluye las devoluciones, rebajas y devoluciones por ventas de establecimientos en el extranjero (rubro 250).
', 4, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (250, N'Devoluciones, rebajas y descuentos sobre ventas en establecimientos en el extranjero                                    ', N'Si las mercancías entregadas en venta no reúnen los requisitos solicitados por el comprador, es probable que éste proceda a devolverlas. En este caso, observamos una entrada física de mercancías a la empresa que no corresponde a una compra, esto se conceptúa como devoluciones sobre ventas.

La empresa puede evitar que un cliente devuelva las mercancías vendidas, porque no reúnan éstas los requisitos por él solicitados, o porque se hubiesen deteriorado durante su envío, concediendo a éste que pague un precio más bajo al fijado originalmente, esto se conceptúa como rebajas sobre ventas.

Si la empresa necesita recuperar el importe de las ventas efectuadas a crédito, en un plazo menor al convenido al efectuarse la operación, puede ofrecer a sus clientes una disminución en el precio que se fijo originalmente, esta disminución se hace generalmente mediante un porcentaje. La cantidad que se recibe de menos al recuperar anticipadamente a la fecha de su vencimiento el importe del adeudo de un cliente, se denomina como descuentos sobre ventas.

La empresa puede otorgar precios bajos a aquellos compradores que adquieran un número elevado de unidades, con el fin de incrementar su volumen de ventas. La disminución el precio de venta se conceptúa como bonificaciones sobre ventas.

Estas devoluciones, rebajas y descuentos otorgados a los clientes se hacen sobre las ventas realizadas en establecimientos de la empresa ubicados en el extranjero registradas en el rubro 150. No incluye las devoluciones, rebajas y descuentos sobre ventas gravadas con otras tasas de IVA (rubros 200, 210, 220, 230). Tampoco incluye las devoluciones, rebajas y devoluciones por ventas de exportación (rubro 240).
', 4, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (330, N'Intereses devengados a favor cobrados                                                                                   ', N'El interés es el rédito o provecho que produce un capital prestado o invertido en valores.

Los intereses a que se refiere este rubro son los ganados por créditos a clientes y deudores diversos.

No incluye los ingresos por intereses exentos de IVA (rubro 300), ni los gravados a otras tasas (rubros, 310, 320).

Si los intereses no están exentos por el Art. 15 Fracc. X LIVA, estarán gravados a la tasa del 15% 

Estos intereses son ingresos acumulables, LISR Art. 20, Fracc. X
', 7, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (332, N'Intereses devengados a favor del extranjero                                                                             ', N'Son los ingresos por enajenación de bienes y/o por la prestación de servicios realizados en territorio nacional, gravados a la tasa del 15% de IVA.

Son ventas brutas, no incluyen las devoluciones, rebajas y descuentos sobre ingresos (rubros 200, 210, 220, 230, 240, 250).

Estos ingresos se obtienen por el giro propio de la empresa,  no incluyen ingresos por partidas discontinuas y extraordinarias (rubros 300, 310, 320, 340, 390, 400, 410, 420, 500, 510, 520, 530, 540, 550, 560, 570, 580, 590, 600, 610, 620, 630, 640).

Son ingresos obtenidos en territorio nacional,  no incluyen los ingresos por exportaciones (rubros 140), ni los ingresos obtenidos por establecimientos en el extranjero (rubro 150).

Son ingresos con IVA al 15%,  no incluyen ingresos exentos de IVA (rubro 100) ni gravados con otras tasas de IVA (rubros 110, 120).

La tasa general del IVA es el 15%, se aplica a todas las personas físicas y morales que, en territorio nacional, realicen ventas o presten servicios independientes.

Fundamento legal LIVA Art. 1, LIVA Art. 10', 7, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (350, N'Intereses moratorios efectivamente cobrados (ingreso fiscal no contable)                                                ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 7, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (352, N'Intereses moratorio a favor del extranjero                                                                              ', N'Son los ingresos por enajenación de bienes y/o por la prestación de servicios realizados en territorio nacional, gravados a la tasa del 15% de IVA.

Son ventas brutas, no incluyen las devoluciones, rebajas y descuentos sobre ingresos (rubros 200, 210, 220, 230, 240, 250).

Estos ingresos se obtienen por el giro propio de la empresa,  no incluyen ingresos por partidas discontinuas y extraordinarias (rubros 300, 310, 320, 340, 390, 400, 410, 420, 500, 510, 520, 530, 540, 550, 560, 570, 580, 590, 600, 610, 620, 630, 640).

Son ingresos obtenidos en territorio nacional,  no incluyen los ingresos por exportaciones (rubros 140), ni los ingresos obtenidos por establecimientos en el extranjero (rubro 150).

Son ingresos con IVA al 15%,  no incluyen ingresos exentos de IVA (rubro 100) ni gravados con otras tasas de IVA (rubros 110, 120).

La tasa general del IVA es el 15%, se aplica a todas las personas físicas y morales que, en territorio nacional, realicen ventas o presten servicios independientes.

Fundamento legal LIVA Art. 1, LIVA Art. 10', 7, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (360, N'Intereses moratorios devengados  a favor cobrados o no (ingreso contable no fiscal)                                     ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 7, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (370, N'Intereses devengados que exceden el valor de mercado y moratorios cobrados o no (ingreso contable no fiscal)            ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 7, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (380, N'Utilidad cambiaria cobrada                                                                                              ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 7, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (390, N'Utilidad cambiaria devengada                                                                                            ', N'La utilidad cambiaria es la diferencia entre el tipo de cambio existente a la fecha de la operación realizada en moneda extranjera y el que exista a la fecha de cierre de los estados financieros.

La utilidad cambiaria, al igual que la pérdida cambiaria devengada (rubro 2350), únicamente se generan cuando se mantienen saldos de cuentas de activo o de pasivo en moneda extranjera.

Las cuentas en moneda extranjera tienen que ser valuadas en moneda nacional.

El tipo de cambio usado para valuar las cuentas en moneda extranjera en el momento de su registro puede ser diferente al tipo de cambio existente al finalizar el período.

Los ajustes de valuación de las cuentas en moneda extranjera al final del período tienen como contracuentas la "utilidad cambiaria" o la "pérdida cambiaria", según sea el caso.

Aunque podría ocupar una sola cuenta denominada "utilidad o pérdida cambiaria", es más explícito usar las dos cuentas antes mencionadas para registrar la utilidad cambiaria devengada en el rubro 390 y la pérdida cambiaria devengada en el rubro 2350.

A la ganancia cambiaria se da el tratamiento de interés de acuerdo al Art. 9  parrafo 6 de la LISR,  Forma parte de los ingresos nominales para el cálculo de los pagos provisionales Art. 14 LISR, Fracc. III Tercer parrafo y 111 LISR, también forma parte de los ingresos acumulables para el cálculo  de la declaración anual Art. 17 LISR Primer Parrafo.

Nota : El contador tiene que calcular y registrar la utilidad o pérdida cambiaria cuando menos al final del primer semestre (para el cálculo del ajuste a los pagos provisionales) y al final del año (para el cálculo de la declaración anual). Si usted calcula el impuesto real devengado cada mes, debe calcular y registrar la utilidad o pérdida cambiaria cada fin de mes.
', 7, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (410, N'Resultado por posición monetaria en ingresos                                                                            ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 7, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (420, N'Otras operaciones financieras a favor                                                                                   ', N'', 7, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (430, N'Otras operaciones financieras del extranjero                                                                            ', N'Son los ingresos por enajenación de bienes y/o por la prestación de servicios realizados en territorio nacional, gravados a la tasa del 15% de IVA.

Son ventas brutas, no incluyen las devoluciones, rebajas y descuentos sobre ingresos (rubros 200, 210, 220, 230, 240, 250).

Estos ingresos se obtienen por el giro propio de la empresa,  no incluyen ingresos por partidas discontinuas y extraordinarias (rubros 300, 310, 320, 340, 390, 400, 410, 420, 500, 510, 520, 530, 540, 550, 560, 570, 580, 590, 600, 610, 620, 630, 640).

Son ingresos obtenidos en territorio nacional,  no incluyen los ingresos por exportaciones (rubros 140), ni los ingresos obtenidos por establecimientos en el extranjero (rubro 150).

Son ingresos con IVA al 15%,  no incluyen ingresos exentos de IVA (rubro 100) ni gravados con otras tasas de IVA (rubros 110, 120).

La tasa general del IVA es el 15%, se aplica a todas las personas físicas y morales que, en territorio nacional, realicen ventas o presten servicios independientes.

Fundamento legal LIVA Art. 1, LIVA Art. 10', 7, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (440, N'Otros productos nacionales                                                                                              ', N'Son los ingresos por enajenación de bienes y/o por la prestación de servicios realizados en territorio nacional, gravados a la tasa del 15% de IVA.

Son ventas brutas, no incluyen las devoluciones, rebajas y descuentos sobre ingresos (rubros 200, 210, 220, 230, 240, 250).

Estos ingresos se obtienen por el giro propio de la empresa,  no incluyen ingresos por partidas discontinuas y extraordinarias (rubros 300, 310, 320, 340, 390, 400, 410, 420, 500, 510, 520, 530, 540, 550, 560, 570, 580, 590, 600, 610, 620, 630, 640).

Son ingresos obtenidos en territorio nacional,  no incluyen los ingresos por exportaciones (rubros 140), ni los ingresos obtenidos por establecimientos en el extranjero (rubro 150).

Son ingresos con IVA al 15%,  no incluyen ingresos exentos de IVA (rubro 100) ni gravados con otras tasas de IVA (rubros 110, 120).

La tasa general del IVA es el 15%, se aplica a todas las personas físicas y morales que, en territorio nacional, realicen ventas o presten servicios independientes.

Fundamento legal LIVA Art. 1, LIVA Art. 10', 7, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (450, N'Otros productos extranjeros                                                                                             ', N'Son los ingresos por enajenación de bienes y/o por la prestación de servicios realizados en territorio nacional, gravados a la tasa del 15% de IVA.

Son ventas brutas, no incluyen las devoluciones, rebajas y descuentos sobre ingresos (rubros 200, 210, 220, 230, 240, 250).

Estos ingresos se obtienen por el giro propio de la empresa,  no incluyen ingresos por partidas discontinuas y extraordinarias (rubros 300, 310, 320, 340, 390, 400, 410, 420, 500, 510, 520, 530, 540, 550, 560, 570, 580, 590, 600, 610, 620, 630, 640).

Son ingresos obtenidos en territorio nacional,  no incluyen los ingresos por exportaciones (rubros 140), ni los ingresos obtenidos por establecimientos en el extranjero (rubro 150).

Son ingresos con IVA al 15%,  no incluyen ingresos exentos de IVA (rubro 100) ni gravados con otras tasas de IVA (rubros 110, 120).

La tasa general del IVA es el 15%, se aplica a todas las personas físicas y morales que, en territorio nacional, realicen ventas o presten servicios independientes.

Fundamento legal LIVA Art. 1, LIVA Art. 10', 7, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (500, N'Ingresos en regímenes fiscales preferentes                                                                              ', N'Una jurisdicción de baja imposición fiscal es el país que no tiene tratados internacionales en materia fiscal Se considera que una sociedad, entidad o fideicomiso está ubicado en una jurisdicción de baja imposición fiscal, cuando tenga presencia física o cuente con un domicilio o apartado postal en dicha jurisdicción.

Los países que se consideran de baja imposición fiscal se listan en el artículo cuarto, fracción XI, de las disposiciones transitorias de la LISR para 1998, publicadas en el Diario Oficial de la Federación el 29 de diciembre de 1997.

Estos países tienen un bajo porcentaje de gravamen para la recaudación de impuestos.
', 7, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (510, N'Dividendos percibidos de residentes en México                                                                           ', N'Dividendo es el beneficio que produce a los socios una empresa por acciones.

Son los ingresos que perciben los socios de empresas ubicadas en territorio nacional por la distribución de utilidades de dichas empresas.

No incluye los dividendos percibidos de residentes en el extranjero (rubro 520).

Estos dividendos no se consideran para el cálculo de los pagos provisionales, y declaración anual en virtud de que son ingresos No Acumulables, según la LISR Art. 17, último párrafo.

Estos ingresos incrementan la base gravable para la PTU, LISR Art. 16, Fracc.I, inciso a)
', 7, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (520, N'Dividendos percibidos de residentes en el extranjero                                                                    ', N'Es el beneficio que produce a los socios una empresa por acciones.

Son los ingresos que perciben los socios de empresas ubicadas en territorio extranjero por la distribución de utilidades de dichas empresas.

No incluye los dividendos percibidos de residentes en México (rubro 510).

Estos dividendos  son ingresos acumulables, por  recibirse de empresas residentes en el extranjero.
', 7, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (530, N'Utilidad contable en enajenación de acciones                                                                            ', N'
Esta utilidad al igual que la pérdida contable en venta de acciones (rubro 2400) se genera cuando se venden acciones de sociedades (rubro 3580, 3590) .

Aunque podría utilizar una sola cuenta denominada "utilidad o pérdida contable en venta de acciones", es más explícito usar las dos cuentas antes mencionadas para registrar la utilidad contable en venta de acciones el rubro 530 y la pérdida contable en venta de acciones el rubro 2400.

Nota : El contador tiene que calcular y registrar la utilidad o pérdida en venta de acciones cuando menos al final de cada año para el cálculo de la declaración anual.

Si usted calcula el impuesto real devengado cada mes, debe calcular y registrar la utilidad o pérdida en venta de acciones cada fin de mes.

El "Catálogo de Activos Fijos e Inversiones" calcula tanto las utilidades como las pérdidas contables y fiscales por venta de acciones.

Son acumulables la utilidad fiscal en  venta de acciones, su fundamento lo encontramos en la LISR Art. 24
', 7, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (540, N'Utilidad contable en enajenación de activos fijos                                                                       ', N'La utilidad contable en venta de inversiones en activos fijos, al igual que la pérdida contable en venta de inversiones en activos fijos (rubro 2410), se genera cuando se venden activos fijos de la empresa (rubros 3620, 3640, 3660, 3680, 3700, 3720, 3760).

Aunque podría utilizar una sola cuenta denominada "utilidad o pérdida en venta de inversiones en activos fijos", es más explícito usar las dos cuentas antes mencionadas para registrar la utilidad en venta de activos fijos en el rubro 540 y la pérdida en venta de inversiones de terrenos y activos fijos en el rubro 2410.

Nota: El contador tiene que calcular y registrar la utilidad o pérdida en venta de inversiones en activos fijos (para el cálculo del los pagos provisionales) y al final del año (para el cálculo de la declaración anual).

Si usted calcula el impuesto real devengado cada mes, debe calcular y registrar la utilidad o pérdida en venta de inversiones en activos fijos cada fin de mes.

El "Catálogo de Activos Fijos e Inversiones" calcula tanto las utilidades como las pérdidas contables y fiscales por venta de inversiones en activos fijos.
', 7, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (550, N'Estímulos fiscales                                                                                                      ', N'Son beneficios derivados de disposiciones fiscales y decretos, incluyendo 30% de las cuotas pagadas por utilización de carreteras, 20% del salario mínimo por empleo adicional, entre otros,  dichos estimulos son ingresos no acumulables.', 7, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (560, N'Saldos a favor de impuestos y su actualización                                                                          ', N'', 7, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (570, N'Actualización de contribuciones a favor                                                                                 ', N'Se asigna a la cuenta que registra el incremento que sufre el importe de las contribuciones a favor, por el transcurso del tiempo y con motivo de los cambios de precios en el país. Se actualiza una contribución cuando se solicita su devolución o cuando se compensa cantidades a favor contra las que se este obligado a pagar.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 7, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (580, N'Otros ingresos no acumulables para ISR ni para IETU (contables no fiscales)                                             ', N'Ingresos por partidas discontinuas y extraordinarias exclusivamente contables, No acumulables para efectos fiscales.

No confundir con los otros ingresos eventuales contables y fiscales (rubros 590, 600, 610, 620), ni con los otros ingresos  eventuales fiscales No contables (rubro 6000, 6010, 6020, 6030,) que se registra en cuentas de orden.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 7, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (584, N'Otros ingresos no acumulables para ISR si para IETU                                                                     ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 7, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (586, N'Otros ingresos no acumulables para para IETU, si para ISR                                                               ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 4, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (620, N'Otros ingresos  contables y fiscales                                                                                    ', N'Ingresos por partidas discontinuas y extraordinarias gravadas al 15% de IVA, exclusivamente contables que Si se acumulan para efectos fiscales, que no pueden ser clasificados como utilidad en venta de acciones y activos fijos (rubros 530, 540), dividendos (rubros 510, 520), estímulos fiscales (rubro 550), intereses (rubros 300, 310, 320, 330), o utilidad cambiaria devengada y exigible (rubro 390, 400).

No confundir con los otros ingresos acumulables  (rubro 580) ni con los otros ingresos fiscales NO contables (rubro 6000, 6010, 6020, 6030).
', 7, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (630, N'Participación de resultados en subsidiarias a favor                                                                     ', N'Es la parte de la cual participa una empresa controladora por sus inversiones en empresas subsidiarias.

Una empresa controladora es aquélla que posee directa o indirectamente, a través de subsidiarias (controladas), más del 50% de las acciones en circulación con derecho a voto de la compañía emisora, (de la subsidiaria).
', 7, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (640, N'Efectos de reexpresión en ingresos (excepto resultado por posición monetaria)                                           ', N'La reexpresión de las cifras de los estados financieros es reflejar los efectos de la inflación en cada una de las partidas contenidas en estos.

El resultado a favor de los efectos de la reexpresión de los estados financieros, al igual que los efectos en costos y gastos (rubro 2460), se originan cuando la reexpresión de los estados financieros afecta la cuenta de resultados. Si la reexpresión de sus estados financieros afecta su utilidad (o pérdida) del ejercicio, debe utilizar una cuenta por separado para registrar esta diferencia.

Aunque podría utilizar una sola cuenta denominada "efectos de reexpresión", es más explícito usar las dos cuentas antes mencionadas para registrar los efectos de reexpresión en ingresos  en el rubro 640 y los efectos de reexpresión en costos y gastos  en el rubro 2460.

No se acumula por la revaluación de sus activos y de su capital. LISR Art.17, segundo párrafo.
', 7, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1000, N'Costo de ventas contable                                                                                                ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 5, 3, 5, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1010, N'Costo de lo vendido fiscal                                                                                              ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 10, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1020, N'Compras netas nacionales de materias primas                                                                             ', N'Son las adquisiciones de materias primas  que serán vendidas como parte de las operaciones propias de la empresa, cuando éstas hayan sido procesadas.

Las compras netas abarcan tanto las compras brutas como las devoluciones, rebajas y descuentos sobre las compras. Se entiende como compras nacionales cuando el proveedor está ubicado en territorio nacional, aunque el producto sea extranjero pero no incluye las compras de importación efectuadas a proveedores ubicados en el extranjero (rubros  1050, 1060, 1070).

Las compras de materias primas no incluyen las compras de productos semiterminados (rubros 1030, 1060), ni las compras de productos terminados (rubros 1040, 1070). Tampoco incluyen las compras de materias primas (rubro 1050).

Las materias primas son elementos básicos para la elaboración del producto que vende la empresa.
', 5, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1024, N'Dev. Desc. O bonificaciones s/compras nacionales de mat. Prima                                                          ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 5, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1030, N'Compras netas nacionales de productos semiterminados                                                                    ', N'Son las adquisiciones de productos semiterminados, efectuadas con la intención de incorporarlas en la producción de artículos que serán vendidos como parte de las operaciones propias de la empresa, por lo tanto no incluye las compras de productos semiterminados que se utilicen con otros propósitos.
Las compras netas abarcan tanto las compras brutas como las devoluciones, rebajas y descuentos sobre las compras.

Se entiende como compras nacionales cuando el proveedor está ubicado en territorio nacional, aunque el producto sea extranjero pero no incluye las compras de importación efectuadas a proveedores ubicados en el extranjero (rubros  1050, 1060, 1070).

Las compras de productos semiterminados no incluyen las compras de materias primas (rubros 1020, 1050), ni las compras de productos terminados (rubros 1040, 1070), Los productos semiterminados son las materias primas que se encuentran en un proceso de transformación.
', 5, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1034, N'Dev. Desc. O bonificaciones s/compras nacionales de prod. Semiterminados                                                ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 5, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1040, N'Compras netas nacionales de productos terminados                                                                        ', N'Son las adquisiciones de productos terminados, que serán vendidos como parte de las operaciones propias de la empresa.

Las compras netas abarcan tanto las compras brutas como las devoluciones, rebajas y descuentos sobre las compras.

Se entiende como compras nacionales cuando el proveedor está ubicado en territorio nacional, aunque el producto sea extranjero pero no incluye las compras de importación efectuadas a proveedores ubicados en el extranjero (rubro 1050, 1060, 1070).

Las compras de productos terminados no incluyen las compras de productos semiterminados, ni las compras de materias primas (rubros  1020, 1050). Tampoco incluyen las compras de productos terminados  (rubro  1070).

Los productos terminados son las materias primas que han pasado por un proceso de transformación.
', 5, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1044, N'Dev. Desc. O bonificaciones s/compras nacionales de prod. Terminados                                                    ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 5, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1050, N'Compras netas de importación de materias primas                                                                         ', N'Son las adquisiciones de materias primas de un país extranjero introducidas a México.
Estas mercancías serán vendidas como parte de las operaciones de la empresa.

Las compras netas abarcan tanto las compras brutas como las devoluciones, rebajas y descuentos sobre las compras.

Se entiende como compras de importación cuando el proveedor esta ubicado en el extranjero.

Las compras de materias primas de importación gravadas por el IVA no incluyen las compras de productos semiterminados de importación (rubros 1060), ni las compras de productos terminados de importación (rubros 1070).

Las materias primas son elementos básicos para la elaboración del producto que vende la empresa.
', 5, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1054, N'Dev. Desc. O bonificaciones s/compras de importación de mat. Prima                                                      ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 5, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1060, N'Compras netas de importación de productos semiterminados                                                                ', N'Son las adquisiciones de productos semiterminados en un país extranjero introducidas a México.

Estas mercancías serán vendidas como parte de las operaciones propias de la empresa.

Las compras netas abarcan tanto las compras brutas como las devoluciones, rebajas y descuentos sobre las compras.

Se entiende como compras de importación cuando el proveedor está ubicado en el extranjero.

Las compras de productos semiterminados de importación gravadas por el IVA, no incluyen las compras de materias primas de importación (rubro 1050), ni las compras de productos terminados de importación (rubro 1070).

Los productos semiterminados son las materias primas que se encuentran en un proceso de transformación.
', 5, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1064, N'Dev. Desc. O bonificaciones s/compras de importación de prod. Semiterminados                                            ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 5, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1070, N'Compras netas de importación de productos terminados                                                                    ', N'Son las adquisiciones de productos terminados en un país extranjero introducidas a México.

Estas mercancías serán vendidas como parte de las operaciones propias de la empresa.

Las compras netas abarcan tanto las compras brutas como las devoluciones, rebajas y descuentos sobre las compras.

Se entiende como compras de importación cuando el proveedor está ubicado en el extranjero.

Las compras de productos terminados de importación gravadas con IVA, no incluyen las compras de materias primas de importación (rubro 1050), ni las compras de productos semiterminados de importación (rubro 1060). 

Los productos terminados son las materias primas que han pasado por un proceso de transformación.
', 5, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1074, N'Dev. Desc. O bonificaciones s/compras de importación de prod. Terminados                                                ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 5, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1080, N'Mano de obra de fabricación                                                                                             ', N'Es el pago de sueldos y salarios (nómina), correspondiente a los gastos de fabricación de la empresa. No incluye los sueldos y salarios de gastos de operación (rubro 2000).

Es el esfuerzo humano necesario para transformar la materia prima en un producto manufacturado. Dicho esfuerzo se remunera en efectivo y éste interviene como un elemento importante del costo de producción.
', 5, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1090, N'Maquilas de fabricación                                                                                                 ', N'Cuando la empresa le da a fabricar determinados bienes a otras empresas y se les paga solo por el servicio de manufactura. Estos gastos corresponden a gastos de fabricación.
', 5, 3, 4, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1100, N'Previsión social de fabricación                                                                                         ', N'Son las prestaciones otorgadas a los trabajadores por concepto de subsidio por incapacidad, jubilaciones, fallecimientos, invalidez, servicios médicos y hospitalarios, fondos de ahorro, becas educacionales para los trabajados o sus hijos, guarderías infantiles, actividades culturales, actividades deportivas.

Estas prestaciones pueden ser concedidas de manera general, de acuerdo con las leyes o por contratos de trabajo.

Estos gastos de previsión social son derivados de relaciones laborales, correspondientes a los gastos de fabricación de la empresa. No incluye los gastos de previsión social de gastos de operación.
', 5, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1110, N'Aportaciones al INFONAVIT de fabricación                                                                                ', N'Estas aportaciones forman parte de las llamadas aportaciones de seguridad social las cuales son contribuciones establecidas en la ley a cargo de personas que son sustituidas por el Estado en el cumplimiento de obligaciones fijadas por la Ley en materia de seguridad social o a las personas que se beneficien en forma especial por servicios de seguridad social proporcionados por el mismo Estado.

Son gastos que se afectan por el pago de las aportaciones al INFONAVIT los cuales se derivan de la relación laboral, correspondientes a los gastos de fabricación de la empresa.

No incluyen las aportaciones al INFONAVIT de gastos de operación (rubro 2160).
', 5, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1120, N'Aportaciones al SAR de fabricación                                                                                      ', N'Estas aportaciones forman parte de las llamadas aportaciones de seguridad social las cuales son contribuciones establecidas en la ley a cargo de personas que son sustituidas por el Estado en el cumplimiento de obligaciones fijadas por la Ley en materia de seguridad social o a las personas que se beneficien en forma especial por servicios de seguridad social proporcionados por el mismo Estado.

Son gastos que se afectan por el pago de las aportaciones al SAR los cuales se derivan de la relación laboral, correspondientes a los gastos de fabricación de la empresa.

No incluyen las aportaciones SAR de gastos de operación (rubro 2150).
', 5, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1130, N'Cuotas patronales IMSS de fabricación                                                                                   ', N'Es la proporción que de las aportaciones al IMSS le corresponde pagar al patrón por concepto de Enfermedades y maternidad, invalidez y vida, guarderías y gastos de previsión social y retiro.

En el caso de trabajadores que perciban un ingreso diario del salario mínimo, será el patrón quien pague íntegramente las aportaciones al IMSS.

Son gastos que se afectan por el pago de las aportaciones al IMSS los cuales se derivan de la relación laboral, correspondientes a los gastos de fabricación de la empresa.

No incluye las aportaciones IMSS de los gastos de operación (rubro 2190).
', 5, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1140, N'Depreciación del ejercicio de fabricación                                                                               ', N'La depreciación es la disminución de valor o precio que sufre un bien tangible por causa del uso o transcurso del tiempo.

Depreciación contable del ejercicio para gastos de producción. No incluye la amortización del ejercicio para gastos de producción (rubro 1150).
', 5, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1150, N'Amortización del ejercicio de fabricación                                                                               ', N'La amortización es cada una de las partes en que se divide un valor en su proceso de extinción.

Gastos por amortización del ejercicio para gastos de producción. No incluye la depreciación de activos fijos del ejercicio para gastos de fabricación (rubro 1140).
', 5, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1160, N'Honorarios  profesionales de fabricación                                                                                ', N'Se derivan de la contratación de servicios personales independientes que inciden directa o indirectamente en la fabricación de los productos y que están gravados al 15% de IVA, a cambio de ese pago la empresa recibe un servicio y un recibo de honorarios.', 5, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1170, N'Arrendamiento de bienes muebles de fabricación                                                                          ', N'Son los pagos que se afectan por concepto del uso o goce temporal de bienes muebles que la empresa tomó en arrendamiento y que inciden directa o indirectamente en la fabricación de sus productos, a cambio la empresa recibe el servicio y un recibo de arrendamiento.', 5, 3, 4, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1180, N'Arrendamiento de bienes inmuebles de fabricación                                                                        ', N'Son los pagos que se afectan por concepto del uso o goce temporal de bienes inmuebles , que la empresa tomó en arrendamiento y que inciden directa o indirectamente en la fabricación de sus productos, a cambio la empresa recibe el servicio y un recibo de arrendamiento.', 5, 3, 4, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1190, N'Regalías y asistencia técnica  de fabricación                                                                           ', N'Se consideran regalías, entre otros, los pagos de cualquier clase por el uso o goce temporal de patentes, certificados de invención y mejora, marcas de fábrica, nombres comerciales, derechos de autor sobre obras literarias, artísticas o científicas, incluidas las películas cinematográficas y grabaciones para radio o televisión, así como de dibujos o modelos, planos, fórmulas, o procedimientos y equipos industriales, comerciales o científicos, así como las cantidades pagadas por transferencia de tecnología o informaciones relativas a experiencias industriales, comerciales o científicas, u otro derecho o propiedad similar.

Se entenderá por asistencia técnica la prestación de servicios personales independientes por los que el prestador se obliga a proporcionar conocimientos no patentables, que no impliquen la transmisión de información confidencial relativa a experiencias industriales, comerciales o científicas, obligándose con el prestatario a intervenir en la aplicación de dichos conocimientos.

Estos gastos afectan directa o indirectamente a la fabricación de los productos que vende la empresa.


Para el ISR, las regalías y asistencia técnica son gastos indispensables para el desarrollo del producto, pero debe cubrir ciertos requisitos para que sean deducibles, de acuerdo a los Arts. 29 y 31 fracc. XI de la LISR.', 5, 3, 4, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1200, N'Primas por fianzas y seguros de fabricación                                                                             ', N'Es la cantidad que debe pagar el asegurado a la empresa aseguradora para obtener el beneficio contratado.

Gastos por el pago de fianzas y seguros, correspondientes a gastos de fabricación.

Para el ISR, las primas por fianzas y seguros  son gastos indispensables para el desarrollo del producto, pero debe cubrir ciertos requisitos para que sean deducibles, de acuerdo a los Arts. 29 y 31 fracc. XIII de la LISR.


', 5, 3, 4, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1210, N'Fletes y acarreos de fabricación                                                                                        ', N'Son gastos que se realizan por la transportación de mercancía u otros bienes, acarreos y maniobras, correspondientes a gastos de fabricación de la empresa. No incluye los fletes y acarreos de gastos de operación.

Para el ISR, los fletes y acarreos,  son gastos indispensables para el desarrollo del producto, pero debe cubrir ciertos requisitos para que sean deducibles, de acuerdo a los Art. 31 fracc. I, III, de la LISR.', 5, 3, 4, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1220, N'Otros impuestos y derechos de fabricación                                                                               ', N'Corresponde al pago de otros impuestos y derechos, tanto locales como federales que afectan directamente a la fabricación.', 5, 3, 4, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1230, N'Gastos de fabricación no deducibles                                                                                     ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              Son gastos de fabricación, que realiza la empresa pero que fiscalmente son NO deducibles, según el Art. 32 LISR.
Estos gastos intervienen en los resultados contables más no en los fiscales y son aquellos que de alguna manera no cumplen con alguno o algunos de los requisitos establecidos en Ley, para que sean fiscalmente deducibles. LISR Arts. 31 y 32', 5, 3, 4, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (1240, N'Otros costos de fabricación                                                                                             ', N'Son otros costos  que afectan directamente la fabricación de los productos de la empresa.

Son costos distintos a los mencionados anteriormente.

Este rubro se asigna a aquellas cuentas que no fuerón consideradas por los rubros arriba disponibles.
', 5, 3, 4, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2000, N'Sueldos y salarios de gastos de operación                                                                               ', N'Retribución en efectivo que debe pagar el patrón al trabajador en virtud de un contrato de trabajo.

Se distingue el sueldo del salario en que éste se paga a obreros y destajistas, por día, por semana o por unidad de obra en actividades directamente involucradas con la producción, en tanto que el sueldo se paga a empleados y funcionarios y se cotiza por mes o año de actividades generalmente de oficina.

Es el pago de sueldos y salarios (nóminas), correspondientes a los gastos de operación de la empresa.
No incluye la mano de obra relacionada al costo de venta de los gastos de fabricación.

Para el ISR,  son gastos indispensables para la empresa, pero debe cubrir ciertos requisitos para que sean deducibles, de acuerdo a los Art. 31 fracc. I, IV de la LISR.
', 6, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2004, N'Previsión social de gastos de operación                                                                                 ', N'Son las prestaciones otorgadas a los trabajadores por concepto de subsidio por incapacidad, jubilaciones, fallecimientos, invalidez, servicios médicos y hospitalarios, fondos de ahorro, becas educacionales para los trabajados o sus hijos, guarderías infantiles, actividades culturales, actividades deportivas.

Estas prestaciones pueden ser concedidas de manera general, de acuerdo con las leyes o por contratos de trabajo.

Estos gastos de previsión social son derivados de relaciones laborales, correspondientes a los gastos de operación de la empresa.

No incluye los gastos de previsión social de fabricación (rubro 302).

Para el ISR,   son gastos indispensables para la empresa, pero debe cubrir ciertos requisitos para que sean deducibles, de acuerdo a los Art. 31 fracc. I, IV, XI y XIIde la LISR.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 6, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2010, N'Honorarios pagados a personas fisicas de gastos de operación                                                            ', N'Se derivan de la contratación de servicios personales independientes, gravados, correspondientes a gastos de operación, a cambio de ese pago la empresa recibe un servicio y un recibo de honorarios.', 6, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2014, N'Honorarios pagados a personas morales de gastos de operación                                                            ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 6, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2020, N'Regalías y asistencia técnica de gastos de operación                                                                    ', N'Se consideran regalías, entre otros, los pagos de cualquier clase por el uso o goce temporal de patentes, certificados de invención y mejora, marcas de fábrica, nombres comerciales, derechos de autor sobre obras literarias, artísticas o científicas, incluidas las películas cinematográficas y grabaciones para radio o televisión, así como de dibujos o modelos, planos, fórmulas, o procedimientos y equipos industriales, comerciales o científicos, así como las cantidades pagadas por transferencia de tecnología o informaciones relativas a experiencias industriales, comerciales o científicas, u otro derecho o propiedad similar.

Se entenderá por asistencia técnica la prestación de servicios personales independientes por los que el prestador se obliga a proporcionar conocimientos no patentables, que no impliquen la transmisión de información confidencial relativa a experiencias industriales, comerciales o científicas, obligándose con el prestatario a intervenir en la aplicación de dichos conocimientos.

Estos gastos corresponden a los gastos de operación.

Es un gasto deducible de acuerdo a la LISR Art. 31, fracc. I, IV y XI, siempre y cuando cumpla con los requisitos fiscales.', 6, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2030, N'Donativos otorgados                                                                                                     ', N'Donativos a  instituciones autorizadas para recibir donativos deducibles de impuestos, por ejemplo  los otorgados a instituciones de enseñanza. Debe de reunir los requisitos LISR Art. 31 fracc. I y IV                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 6, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2034, N'Donativos no deducibles                                                                                                 ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 6, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2040, N'Uso o goce temporal de bienes pagados a personas fisicas                                                                ', N'', 6, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2050, N'Uso o goce temporal de bienes pagados a personas morales                                                                ', N'', 6, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2060, N'Fletes y acarreos pagados a personas fisicas de gastos de operación                                                     ', N'Son gastos que se realizan por la transportación de mercancía u otros bienes, acarreos y maniobras, correspondientes a gastos de operación de la empresa.

No incluye los fletes y acarreos de gastos de fabricación.

Es un gasto deducible de acuerdo a la LISR Art. 31, fracc. I, IV 

Este rubro fiscal nos va  a servir para integrar el anexo "G  Datos de algunas Deducciones Autorizadas"', 6, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2070, N'Fletes y acarreos pagados a personas morales de gastos de operación                                                     ', N'Son gastos que se realizan por la transportación de mercancía u otros bienes, acarreos y maniobras, correspondientes a gastos de operación de la empresa.

No incluye los fletes y acarreos de gastos de fabricación.

Es un gasto deducible de acuerdo a la LISR Art. 31, fracc. I, IV 
', 6, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2080, N'Contribuciones pagadas, excepto ISR, IETU e IVA                                                                         ', N'El pago de otros impuestos y derechos, tanto locales como federales, correspondientes a gastos de operación.
Estos gastos no estan afectos al IVA.', 6, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2090, N'Seguros y fianzas de gastos de operación                                                                                ', N'Es la cantidad que debe pagar el asegurado a la empresa aseguradora para obtener el beneficio contratado.

Gastos por el pago de fianzas y seguros, correspondientes a gastos de operación.

Es un gasto deducible de acuerdo a la LISR Art. 31, fracc. I, IV y XIII, siempre y cuando cumpla con los requisitos fiscales.
', 6, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2100, N'Pérdida por créditos incobrables de gastos de operación                                                                 ', N'', 6, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2110, N'Viáticos y gastos de viaje, de gastos de operación                                                                      ', N'Son gastos de operación que se realizan por motivo de viajes, y que se aplican con la finalidad de promover y/o vender los productos que  proporciona la empresa.

Para que este gasto sea deducible se deberá cumplir con la documentación relativa al hospedaje, alimentación y  transporte o cuando menos con el requisito de dos de ellos, además la persona beneficiaria de dicho gasto debe tener relación de trabajo con el contribuyente o en su caso deberá estar prestando servicios profesionales, asimismo el viático o gasto se debe realizar fuera de una faja de 50 kilómetros a partir del establecimiento de dicho contribuyente.

Es un gasto deducible de acuerdo a la LISR Art. 31, fracc. I, IV , Art.32, fracc.IV', 6, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2120, N'Combustibles y lubricantes, de gastos de operación                                                                      ', N'', 6, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2130, N'Subsidio al empleo no disminuido de contribuciones                                                                      ', N'', 6, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2140, N'Impuesto sustitutivo del crédito al salario efectivamente pagado                                                        ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 6, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2150, N'Aportaciones al SAR de gastos de operación                                                                              ', N'Estas aportaciones forman parte de las llamadas aportaciones de seguridad social las cuales son contribuciones establecidas en la ley a cargo de personas que son sustituidas por el Estado en el cumplimiento de obligaciones fijadas por la Ley en materia de seguridad social o a las personas que se beneficien en forma especial por servicios de seguridad social proporcionados por el mismo Estado.

Son gastos que se afectan por el pago de las aportaciones al SAR los cuales se derivan de la relación laboral, correspondientes a los gastos de operación de la empresa.

No incluyen las aportaciones SAR de gastos de fabricación (rubro 1120).

Para el ISR,   son gastos indispensables para la empresa, pero debe cubrir ciertos requisitos para que sean deducibles, de acuerdo a los Art. 31 fracc. I, IV de la LISR.', 6, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2160, N'Aportaciones al INFONAVIT de gastos de operación                                                                        ', N'Estas aportaciones forman parte de las llamadas aportaciones de seguridad social las cuales son contribuciones establecidas en la ley a cargo de personas que son sustituidas por el Estado en el cumplimiento de obligaciones fijadas por la Ley en materia de seguridad social o a las personas que se beneficien en forma especial por servicios de seguridad social proporcionados por el mismo Estado.

Son gastos que se afectan por el pago de las aportaciones al INFONAVIT los cuales se derivan de la relación laboral, correspondientes a los gastos de operación de la empresa.

No incluyen las aportaciones al INFONAVIT de gastos de fabricación (rubro 1110).

Para el ISR,   son gastos indispensables para la empresa, pero debe cubrir ciertos requisitos para que sean deducibles, de acuerdo a los Art. 31 fracc. I, IV de la LISR.
', 6, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2170, N'Aportaciones y jubilaciones por vejez, de gastos de operación                                                           ', N'', 6, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2180, N'Aportaciones para fondos de pensiones y jubilaciones, de gastos de operación                                            ', N'', 6, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2190, N'Cuotas patronales IMSS de gastos de operación                                                                           ', N'Es la proporción que de las aportaciones al IMSS le corresponde pagar al patrón por concepto de Enfermedades y maternidad, invalidez , guarderías y gastos de previsión social y retiro.

En el caso de trabajadores que perciban un ingreso diario del salario mínimo, será el patrón quien pague íntegramente las aportaciones al IMSS.

Son gastos que se afectan por el pago de las aportaciones al IMSS los cuales se derivan de la relación laboral, correspondientes a los gastos de operación de la empresa.

No incluye las aportaciones IMSS de los gastos de fabricación (rubro 1130).

Para el ISR,   son gastos indispensables para la empresa, pero debe cubrir ciertos requisitos para que sean deducibles, de acuerdo a los Arts. 29 fracc. VIII, 31 fracc. I, IV de la LISR.
', 6, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2200, N'Consumos en restaurantes de gastos de operación                                                                         ', N'', 6, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2210, N'Depreciación del ejercicio de gastos de operación                                                                       ', N'La depreciación es la disminución de valor o precio que sufre un bien tangible por causa del uso o transcurso del tiempo.

No incluye la amortización del ejercicio para gastos de operación (rubro 2220).

Este rubro fiscal, se debe asignar a las cuentas donde se registre la depreciación contable de los activos fijos,  ya que la depreciación fiscal, Exentus la determinara con el catalogo de inversiones, y llevara en automatico la deducción fiscal en la conciliación contable fiscal.
', 6, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2220, N'Amortización del ejercicio de gastos de operación                                                                       ', N'La amortización es cada una de las partes en que se divide un valor en su proceso de extinción.

Gastos por amortización del ejercicio para gastos de operación.

No incluye la depreciación de activos fijos del ejercicio para gastos de operación (rubro 2210).

Depreciación contable del ejercicio para gastos de operación es deducible contablemente y por separado se obtiene su amortización fiscal. LISR Art. 37 y 39

', 6, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2230, N'Honorarios a consejeros, comisarios y asimilables a sueldos y salarios                                                  ', N'Son gastos que se realizan por el pago a miembros del consejo de administración o comisarios, estos gastos aparecerán en nómina por la similitud que tienen con los sueldos y salarios.

Es un gasto deducible de acuerdo a la LISR Art. 31, fracc. I,  IV y X, siempre y cuando cumpla con los requisitos fiscales.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 6, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2240, N'Arrendamiento de bienes muebles de gastos de operación                                                                  ', N'Son los pagos que se afectan por concepto del uso o goce temporal de bienes muebles , que la empresa tomó en arrendamiento, correspondientes a los gastos de operación, a cambio la empresa recibe el servicio y un recibo de arrendamiento.
Es un gasto deducible de acuerdo a la LISR Art. 31, fracc. I y IV, siempre y cuando cumpla con los requisitos fiscales.
', 6, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2250, N'Arrendamiento de bienes inmuebles de gastos de operación                                                                ', N'Son los pagos que se afectan por concepto del uso o goce temporal de bienes inmuebles , que la empresa tomó en arrendamiento, correspondiente a los gastos de operación, a cambio la empresa recibe el servicio y un recibo de arrendamiento.
Es un gasto deducible de acuerdo a la LISR Art. 31, fracc. I y IV, siempre y cuando cumpla con los requisitos fiscales.
', 6, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2300, N'Gastos que no reunen requisitos fiscales (no deducibles)                                                                ', N'Son gastos que realiza la empresa pero que fiscalmente son NO deducibles, según el Art. 32 LISR.
Estos gastos intervienen en los resultados contables más no en los fiscales y son aquellos que de alguna manera no cumplen con alguno o algunos de los requisitos establecidos en Ley,para que sean fiscalmente deducibles. LISR Arts. 31 y 32', 6, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2310, N'Provisión de ISR                                                                                                        ', N'Son los ingresos por enajenación de bienes y/o por la prestación de servicios realizados en territorio nacional, gravados a la tasa del 15% de IVA.

Son ventas brutas, no incluyen las devoluciones, rebajas y descuentos sobre ingresos (rubros 200, 210, 220, 230, 240, 250).

Estos ingresos se obtienen por el giro propio de la empresa,  no incluyen ingresos por partidas discontinuas y extraordinarias (rubros 300, 310, 320, 340, 390, 400, 410, 420, 500, 510, 520, 530, 540, 550, 560, 570, 580, 590, 600, 610, 620, 630, 640).

Son ingresos obtenidos en territorio nacional,  no incluyen los ingresos por exportaciones (rubros 140), ni los ingresos obtenidos por establecimientos en el extranjero (rubro 150).

Son ingresos con IVA al 15%,  no incluyen ingresos exentos de IVA (rubro 100) ni gravados con otras tasas de IVA (rubros 110, 120).

La tasa general del IVA es el 15%, se aplica a todas las personas físicas y morales que, en territorio nacional, realicen ventas o presten servicios independientes.

Fundamento legal LIVA Art. 1, LIVA Art. 10', 9, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2311, N'Provisión de IETU                                                                                                       ', N'Son los ingresos por enajenación de bienes y/o por la prestación de servicios realizados en territorio nacional, gravados a la tasa del 15% de IVA.

Son ventas brutas, no incluyen las devoluciones, rebajas y descuentos sobre ingresos (rubros 200, 210, 220, 230, 240, 250).

Estos ingresos se obtienen por el giro propio de la empresa,  no incluyen ingresos por partidas discontinuas y extraordinarias (rubros 300, 310, 320, 340, 390, 400, 410, 420, 500, 510, 520, 530, 540, 550, 560, 570, 580, 590, 600, 610, 620, 630, 640).

Son ingresos obtenidos en territorio nacional,  no incluyen los ingresos por exportaciones (rubros 140), ni los ingresos obtenidos por establecimientos en el extranjero (rubro 150).

Son ingresos con IVA al 15%,  no incluyen ingresos exentos de IVA (rubro 100) ni gravados con otras tasas de IVA (rubros 110, 120).

La tasa general del IVA es el 15%, se aplica a todas las personas físicas y morales que, en territorio nacional, realicen ventas o presten servicios independientes.

Fundamento legal LIVA Art. 1, LIVA Art. 10', 9, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2312, N'Provisión IMPAC                                                                                                         ', N'Son los ingresos por enajenación de bienes y/o por la prestación de servicios realizados en territorio nacional, gravados a la tasa del 15% de IVA.

Son ventas brutas, no incluyen las devoluciones, rebajas y descuentos sobre ingresos (rubros 200, 210, 220, 230, 240, 250).

Estos ingresos se obtienen por el giro propio de la empresa,  no incluyen ingresos por partidas discontinuas y extraordinarias (rubros 300, 310, 320, 340, 390, 400, 410, 420, 500, 510, 520, 530, 540, 550, 560, 570, 580, 590, 600, 610, 620, 630, 640).

Son ingresos obtenidos en territorio nacional,  no incluyen los ingresos por exportaciones (rubros 140), ni los ingresos obtenidos por establecimientos en el extranjero (rubro 150).

Son ingresos con IVA al 15%,  no incluyen ingresos exentos de IVA (rubro 100) ni gravados con otras tasas de IVA (rubros 110, 120).

La tasa general del IVA es el 15%, se aplica a todas las personas físicas y morales que, en territorio nacional, realicen ventas o presten servicios independientes.

Fundamento legal LIVA Art. 1, LIVA Art. 10', 9, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2313, N'Provisión PTU.                                                                                                          ', N'Son los ingresos por enajenación de bienes y/o por la prestación de servicios realizados en territorio nacional, gravados a la tasa del 15% de IVA.

Son ventas brutas, no incluyen las devoluciones, rebajas y descuentos sobre ingresos (rubros 200, 210, 220, 230, 240, 250).

Estos ingresos se obtienen por el giro propio de la empresa,  no incluyen ingresos por partidas discontinuas y extraordinarias (rubros 300, 310, 320, 340, 390, 400, 410, 420, 500, 510, 520, 530, 540, 550, 560, 570, 580, 590, 600, 610, 620, 630, 640).

Son ingresos obtenidos en territorio nacional,  no incluyen los ingresos por exportaciones (rubros 140), ni los ingresos obtenidos por establecimientos en el extranjero (rubro 150).

Son ingresos con IVA al 15%,  no incluyen ingresos exentos de IVA (rubro 100) ni gravados con otras tasas de IVA (rubros 110, 120).

La tasa general del IVA es el 15%, se aplica a todas las personas físicas y morales que, en territorio nacional, realicen ventas o presten servicios independientes.

Fundamento legal LIVA Art. 1, LIVA Art. 10', 9, 3, 1, 1)
GO
print 'Processed 100 total records'
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2320, N'Otros gastos de operación deducibles                                                                                    ', N'Son otros gastos generales que realiza la empresa y que quedaron sin rubro fiscal asignado, deben agruparse a otros gastos.

Este rubro fiscal se asigna a las cuentas que no fuerón consideradas para ser asignadas por los rubros arriba disponibles.

Independientemente del tipo de gastos debe de cumplir ciertos requisitos fiscales para ser deducibles, por ejemplo que sea un gasto indispensable, estar amparadas con documentación que reúnan requisitos  fiscales, estar debidamente registrada en contabilidad, etc. LISR Art. 31
', 6, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2322, N'Otros gastos de operación extranjeros                                                                                   ', N'Son los ingresos por enajenación de bienes y/o por la prestación de servicios realizados en territorio nacional, gravados a la tasa del 15% de IVA.

Son ventas brutas, no incluyen las devoluciones, rebajas y descuentos sobre ingresos (rubros 200, 210, 220, 230, 240, 250).

Estos ingresos se obtienen por el giro propio de la empresa,  no incluyen ingresos por partidas discontinuas y extraordinarias (rubros 300, 310, 320, 340, 390, 400, 410, 420, 500, 510, 520, 530, 540, 550, 560, 570, 580, 590, 600, 610, 620, 630, 640).

Son ingresos obtenidos en territorio nacional,  no incluyen los ingresos por exportaciones (rubros 140), ni los ingresos obtenidos por establecimientos en el extranjero (rubro 150).

Son ingresos con IVA al 15%,  no incluyen ingresos exentos de IVA (rubro 100) ni gravados con otras tasas de IVA (rubros 110, 120).

La tasa general del IVA es el 15%, se aplica a todas las personas físicas y morales que, en territorio nacional, realicen ventas o presten servicios independientes.

Fundamento legal LIVA Art. 1, LIVA Art. 10', 8, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2340, N'Intereses devengados a cargo, efectivamente pagados                                                                     ', N'El interés es el rédito o provecho que produce un capital prestado o invertido en valores.

Gastos por intereses que paga la empresa por sus deudas (pasivos).

Estos intereses se deducen en el ejercicio, sin ajuste alguno.  LISR Art. 29, fracc. IX', 8, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2342, N'Intereses devengados a cargo del extranjero                                                                             ', N'Son los ingresos por enajenación de bienes y/o por la prestación de servicios realizados en territorio nacional, gravados a la tasa del 15% de IVA.

Son ventas brutas, no incluyen las devoluciones, rebajas y descuentos sobre ingresos (rubros 200, 210, 220, 230, 240, 250).

Estos ingresos se obtienen por el giro propio de la empresa,  no incluyen ingresos por partidas discontinuas y extraordinarias (rubros 300, 310, 320, 340, 390, 400, 410, 420, 500, 510, 520, 530, 540, 550, 560, 570, 580, 590, 600, 610, 620, 630, 640).

Son ingresos obtenidos en territorio nacional,  no incluyen los ingresos por exportaciones (rubros 140), ni los ingresos obtenidos por establecimientos en el extranjero (rubro 150).

Son ingresos con IVA al 15%,  no incluyen ingresos exentos de IVA (rubro 100) ni gravados con otras tasas de IVA (rubros 110, 120).

La tasa general del IVA es el 15%, se aplica a todas las personas físicas y morales que, en territorio nacional, realicen ventas o presten servicios independientes.

Fundamento legal LIVA Art. 1, LIVA Art. 10', 8, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2344, N'Intereses moratorios efectivamente pagados (deducciones fiscales no contables)                                          ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 8, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2346, N'Intereses moratorios a cargo del extranjero                                                                             ', N'Son los ingresos por enajenación de bienes y/o por la prestación de servicios realizados en territorio nacional, gravados a la tasa del 15% de IVA.

Son ventas brutas, no incluyen las devoluciones, rebajas y descuentos sobre ingresos (rubros 200, 210, 220, 230, 240, 250).

Estos ingresos se obtienen por el giro propio de la empresa,  no incluyen ingresos por partidas discontinuas y extraordinarias (rubros 300, 310, 320, 340, 390, 400, 410, 420, 500, 510, 520, 530, 540, 550, 560, 570, 580, 590, 600, 610, 620, 630, 640).

Son ingresos obtenidos en territorio nacional,  no incluyen los ingresos por exportaciones (rubros 140), ni los ingresos obtenidos por establecimientos en el extranjero (rubro 150).

Son ingresos con IVA al 15%,  no incluyen ingresos exentos de IVA (rubro 100) ni gravados con otras tasas de IVA (rubros 110, 120).

La tasa general del IVA es el 15%, se aplica a todas las personas físicas y morales que, en territorio nacional, realicen ventas o presten servicios independientes.

Fundamento legal LIVA Art. 1, LIVA Art. 10', 8, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2348, N'Intereses devengados que exceden el valor de mercado y moratorios pagados o no (Deducción Contable no fiscal)           ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 8, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2349, N'Pérdida cambiaria cobrada                                                                                               ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 8, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2350, N'Pérdida cambiaria devengada                                                                                             ', N'La utilidad cambiaria es la diferencia entre el tipo de cambio existente a la fecha de la operación realizada en moneda extranjera y el que exista a la fecha de cierre de los estados financieros.

La pérdida cambiaria devengada , al igual que la utilidad cambiaria devengada (rubro 110), únicamente se generan cuando se mantienen saldos de cuentas de activo o de pasivo en moneda extranjera.

Las cuentas en moneda extranjera tienen que ser valuadas en moneda nacional.

El tipo de cambio usado para valuar las cuentas en moneda extranjera en el momento de su registro puede ser diferente al tipo de cambio existente al finalizar el período.

Los ajustes de valuación de las cuentas en moneda extranjera al final del período tienen como contracuentas la "utilidad cambiaria" o la "pérdida cambiaria", según sea el caso.

Aunque podría ocupar una sola cuenta denominada "utilidad o pérdida cambiaria", es más explícito usar las dos cuentas antes mencionadas para registrar la utilidad cambiaria  devengada en el rubro 110 y la pérdida cambiaria devengada en el rubro 710.

A la pérdida cambiaria se da el tratamiento de interés de acuerdo al Art. 9 LISR, y por lo tanto se utiliza para el cálculo del ajuste anual por inflación. LISR Art. 46, 48

Forma parte de los ingresos nominales para el cálculo de los pagos provisionales Art. 14 LISR,  también forma parte para el cálculo de la declaración anual.

Nota : El contador tiene que calcular y registrar la utilidad o pérdida cambiaria cuando menos al final del primer semestre (para el cálculo del ajuste a los pagos provisionales) y al final del año (para el cálculo de la declaración anual.

Si usted calcula el impuesto real devengado cada mes, debe calcular y registrar la utilidad o pérdida cambiaria cada fin de mes.
', 8, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2370, N'Resultado por posición monetaria en costos y gastos                                                                     ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 8, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2380, N'Otras operaciones financieras a cargo                                                                                   ', N'Estas operaciones son diferentes de los intereses devengados a cargo (rubro 706) y la pérdida cambiaria devengada (rubro 710).

Estas operaciones participan en el cálculo del ajuste anual por inflación.  LISR Art. 48', 8, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2390, N'Pérdida contable en enajenación de acciones                                                                             ', N'Esta pérdida al igual que la utilidad contable en venta de acciones (rubro 140), se genera cuando se venden acciones de sociedades nacionales y del extranjero  (rubros 854, 856).

Aunque podría utilizar una sola cuenta denominada "utilidad o pérdida en venta de acciones", es más explícito usar las dos cuentas antes mencionadas para registrar la utilidad contable en venta de acciones en el rubro 140 y la pérdida contable en venta de acciones en el rubro 740.

Nota: El contador tiene que calcular y registrar la utilidad o pérdida en venta de acciones cuando menos al final del primer semestre (para el cálculo del ajuste a los pagos provisionales) y al final del año (para el cálculo de la declaración anual).

Si usted calcula el impuesto real devengado cada mes, debe calcular y registrar la utilidad o pérdida en venta de acciones cada fin de mes.

El "Catálogo de activos fijos e inversiones" calcula tanto las utilidades como las pérdidas contables y fiscales por venta de acciones.

Es una deducción fiscal LISR Art. 32, fracc. XVII
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 8, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2400, N'Pérdida contable en enajenación de terrenos y activo fijo                                                               ', N'Esta pérdida al igual que la utilidad contable en venta de inversiones en activos fijos (rubro 145), se genera cuando se venden, pierden o quedan sin uso los activos fijos de la empresa (rubros 870, 872, 874, 876, 878, 880).

Aunque podría utilizar una sola cuenta denominada "utilidad o pérdida en venta de  activos fijos", es más explícito usar las dos cuentas antes mencionadas para registrar por la utilidad contable en venta de activos fijos en el rubro 145 y la pérdida contable en venta de terrenos y activos fijos en el rubro 745. 
Nota: El contador tiene que calcular y registrar la utilidad o pérdida en venta de activos fijos cuando menos al final de cada mes  y al final del año (para el cálculo de la declaración anual).

Si usted calcula el impuesto real devengado cada mes, debe calcular y registrar la utilidad o pérdida en venta de inversiones en activos fijos cada fin de mes.

El "Catálogo de activos fijos e inversiones" calcula tanto las utilidades como las pérdidas contables y fiscales por venta de inversiones en activos fijos. 
', 8, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2410, N'Otros gastos deducibles por operaciónes en partidas discontinuas                                                        ', N'Son gastos eventuales gravados que realiza la empresa y que no tienen un renglón específico para su presentación en la declaración anual.

Estos gastos provienen de operaciones eventuales que no son de la naturaleza del giro principal del negocio.

Estos gastos son deducibles siempre y cuando cumplan con los requisitos que nos marca la LISR Art. 31', 8, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2420, N'Gastos no deducibles por operaciones en partidas discontinuas                                                           ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 8, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2430, N'Participación de resultados en subsidiarias a cargo                                                                     ', N'Es la parte de la cual participa una empresa controladora por sus inversiones en empresas subsidiarias.

Una empresa controladora es aquélla que posee directa o indirectamente, a través de subsidiarias (controladas), más del 50% de las acciones en circulación con derecho a voto de la compañía emisora, (de la subsidiaria).

', 8, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2440, N'Efectos de reexpresión en costos y gastos                                                                               ', N'La reexpresión de las cifras de los estados financieros es reflejar los efectos de la inflación en cada una de las partidas contenidas en estos.

El resultado a cargo de los efectos de la reexpresión de los estados financieros, al igual que los efectos en ingresos (rubro 165), se originan cuando la reexpresión de los estados financieros afecta la cuenta de resultados.

Si la reexpresión de sus estados financieros afecta su utilidad (o pérdida) del ejercicio, debe utilizar una cuenta por separado para registrar esta diferencia. Aunque podría utilizar una sola cuenta denominada "efectos de reexpresión", es más explícito usar las dos cuentas antes mencionadas para registrar los efectos de reexpresión en ingresos en el rubro 165 y los efectos de reexpresión en costos y gasto  en el rubro 765.

Deducción contable pero no fiscal.', 8, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2470, N'Otros gastos no deducibles para ISR, si para IETU                                                                       ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 8, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2480, N'Otras deducciones contables fiscales                                                                                    ', N'', 8, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2490, N'Anticipos y rendimientos distribuidos                                                                                   ', N'Los anticipos o rendimientos que pagan las sociedades cooperativas de producción, asi como los anticipos que entreguen las sociedades y asociaciones civiles a sus miembros serán deducibles de acuerdo a la LISR Art. 29 fracc. XI,

Su cuenta básica sería: Gastos de operación y su partida financiera: Otros gastos.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 6, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2500, N'Estímulo fiscal de las personas con discapacidad y/o adultos mayores                                                    ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 8, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2510, N'Otros gastos no deducibles para IETU, si para ISR.                                                                      ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 8, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (2520, N'Deducción adicional por trabajadores de primer empleo                                                                   ', N'', NULL, 3, NULL, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3000, N'Efectivo en caja en territorio nacional  (no ajuste x inflación)                                                        ', N'Es el dinero de que dispone la empresa ya sea en moneda, billetes de banco, cheques recibidos, giros bancarios, postales o telegráficos valuados en moneda nacional y que se localiza en territorio nacional.

El efectivo en caja no se considera "Crédito" para el cálculo del ajuste anual por inflación. Art. 47 LISR fr. VII
El efectivo en caja no  forma  parte de los activos financieros, por lo tanto no juega  en  el  cálculo del  IMPAC. de acuerdo al Art. 4 Fracc. IV de LIA
', 1, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3010, N'Efectivo en caja en el extranjero  (no ajuste x inflación)                                                              ', N'El efectivo en caja que se encuentra en el extranjero, para ser registrado en la contabilidad de nuestro país debemos convertirlo en moneda nacional, por lo tanto estaríamos hablando de caja, el efectivo en caja no se considera "Crédito" para el cálculo del ajuste anual por inflación. Art. 47 LISR fr. VII

El efectivo en caja no forma parte de los activos financieros,  por  lo tanto no juega en el calculo del IMPAC. Art. 4 Fracc. IV de la LIA.
', 1, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3020, N'Depósitos en bancos y en otros organismos del sistema financiero nacional (si ajuste x inflación)                       ', N'Son las inversiones bancarias y en otros organismos del sistema financiero nacional valuados en moneda nacional.

El sistema financiero esta formado por instituciones de crédito, de seguros y de fianzas, de almacenes generales de depósito, administradoras de fondos de ahorro para el retiro, arrendadoras financieras, sociedades de ahorro y préstamo, uniones de crédito, empresas de factoraje financiero, casas de bolsa, casa de cambio y sociedades financieras de objeto limitado.
Todas ellas realizan operaciones financieras que darán lugar al cálculo del ajuste anual por inflación, de acuerdo a lo establecido en los siguientes Arts. 46, 47 y 22 LISR

Los depósitos que realiza el sistema financiero forma parte de los activos financieros que dan lugar al cálculo anual del impuesto al activo, su fundamento lo encontramos en los siguientes arts. 4 LISR, 13 RLIAC.
', 1, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3030, N'Depósitos en bancos y en otros organismos del sistema financiero extranjero (si ajuste x inflación)                     ', N'Son las inversiones bancarias y en otros organismos del sistema financiero nacional valuados en moneda extranjera.

dichas inversiones darán lugar al cálculo del ajuste anual por inflación, de acuerdo a lo establecido en los siguientes Arts. 46, 47 y 22 LISR

Los depósitos que realiza el sistema financiero forma parte de los activos financieros que dan lugar al cálculo anual del impuesto al activo, su fundamento lo encontramos en los siguientes arts. 4 LISR, 13 RLIAC.
', 1, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3040, N'Complementaria depósitos en bancos y en otros organismos del sistema financiero extranjero                              ', N'Este rubro se debe asignar a las cuentas complementarias que es donde se registra la diferencia entre el importe en moneda extranjera y el importe en la moneda origen considerando normalmente el tipo de cambio histórico cuando utilizamos para registrar las operaciones en moneda extranjera el método de tipo fijo con cuenta complementaria de activo.

El método de tipo fijo con cuenta complementaria de activo registra las operaciones en cuentas de moneda extranjera a un tipo de cambio establecido y la diferencia con el tipo de cambio real se registra en una cuenta complementaria de activo.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Es una  cuenta complementaria de otra que maneja moneda extranjera y por lo cual tiene su cuenta principal, no se considera para el cálculo del ajuste anual por inflación, ni para el cálculo del IMPAC.
', 1, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3050, N'Inversiones en valores nacionales (si ajuste x inflación)                                                               ', N'Inversiones en valores nacionales, tales como: CETES, etc. Valuadas en moneda nacional. Estas inversiones se consideran "créditos" para el cálculo del ajuste anual por inflación. LISR Art. 47, primer  párrafo.

Son considerados para el cálculo del IMPAC,   IMPAC Arts 4 y 13 del RLIAC

', 1, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3060, N'Inversiones en valores en el extranjero (si ajuste x inflación)                                                         ', N'Inversiones en valores en el extranjero, tales como: Inversiones en casa de bolsa, etc. Valuadas en moneda extranjera. Estas inversiones se consideran "créditos" para el cálculo del ajuste anual por inflación.

Son considerados para el cálculo del IMPAC Art.4 fr. II y Art. 13 del RLIAC', 1, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3070, N'Complementaria de inversiones en valores en el extranjero                                                               ', N'Este rubro se debe asignar a las cuentas complementarias que es donde se registra la diferencia entre el importe en moneda extranjera y el importe en la moneda origen considerando normalmente el tipo de cambio histórico cuando utilizamos para registrar las operaciones en moneda extranjera el método de tipo fijo con cuenta complementaria de activo.

El método de tipo fijo con cuenta complementaria de activo registra las operaciones en cuentas de moneda extranjera a un tipo de cambio establecido y la diferencia con el tipo de cambio real se registra en una cuenta complementaria de activo.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Es una  cuenta complementaria de otra que maneja moneda extranjera y por lo cual tiene su cuenta principal, no se considera para el cálculo del ajuste anual por inflación, ni para el cálculo del IMPAC.
', 1, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3100, N'Clientes nacionales en moneda nacional  (si ajuste x inflación)                                                         ', N'Se considera "Créditos" el derecho que tiene una persona acreedora a recibir de otra deudora una cantidad  de numerario. Art- 47 primer párrafo LISR. Ejemplo clásico son los clientes que tiene la empresa con personas fisicas o morales que le pagan en moneda nacional .

También forman parte del cálculo del IMPAC                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   ', 1, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3110, N'Clientes nacionales en moneda extranjera (si ajuste x inflación)                                                        ', N'', 1, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3120, N'Complementaria de clientes nacionales en moneda extranjera                                                              ', N'Este rubro se debe asignar a las cuentas complementarias que es donde se registra la diferencia entre el importe en moneda extranjera y el importe en la moneda origen considerando normalmente el tipo de cambio histórico cuando utilizamos para registrar las operaciones en moneda extranjera el método de tipo fijo con cuenta complementaria de activo.

El método de tipo fijo con cuenta complementaria de activo registra las operaciones en cuentas de moneda extranjera a un tipo de cambio establecido y la diferencia con el tipo de cambio real se registra en una cuenta complementaria de activo.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Es una  cuenta complementaria de otra que maneja moneda extranjera y por lo cual tiene su cuenta principal, no se considera para el cálculo del ajuste anual por inflación, ni para el cálculo del IMPAC.
', 1, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3122, N'Clientes extanjeros en moneda nacional (si ajuste por inflación)                                                        ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 1, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3130, N'Clientes extranjeros en moneda extranjera (si ajuste x inflación)                                                       ', N'Se considera "Créditos" el derecho que tiene una persona acreedora a recibir de otra deudora una cantidad  de numerario. Art- 47 primer párrafo LISR. Ejemplo clásico son los clientes que tiene la empresa con personas fisicas o morales que le pagan en moneda nacional  o moneda extranjera.

También forman parte del cálculo del IMPAC                    

Son los clientes que la empresa tiene con personas fisicas o morales que le pagan en monedas extranjeras
', 1, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3140, N'Complementaria de clientes extranjeros en moneda extranjera                                                             ', N'Este rubro se debe asignar a las cuentas complementarias que es donde se registra la diferencia entre el importe en moneda extranjera y el importe en la moneda origen considerando normalmente el tipo de cambio histórico cuando utilizamos para registrar las operaciones en moneda extranjera el método de tipo fijo con cuenta complementaria de activo.

El método de tipo fijo con cuenta complementaria de activo registra las operaciones en cuentas de moneda extranjera a un tipo de cambio establecido y la diferencia con el tipo de cambio real se registra en una cuenta complementaria de activo.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Es una  cuenta complementaria de otra que maneja moneda extranjera y por lo cual tiene su cuenta principal, no se considera para el cálculo del ajuste anual por inflación, ni para el cálculo del IMPAC.
', 1, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3150, N'Otras cuentas por cobrar (si ajuste x inflación)                                                                        ', N'Son otras cuentas que la empresa tiene derecho a cobrar, y que no fueron
consideradas en los rubros arriba mencionados .  que si se consideran para el 
cálculo del ISR e IMPAC.', 1, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3160, N'Otras cuentas por cobrar (no ajuste x inflación)                                                                        ', N'Cuentas NO registradas en los rubros anteriores que  si son consideradas para el cálculo del ajuste por inflación pero que no intervienen para el calculo del  IMPAC.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ', 1, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3190, N'Otras cuentas por cobrar a extranjeros (si ajuste x inflación)                                                          ', N'Se asigna a las cuentas que acumulen los créditos otorgados a extranjeros, diferentes de los créditos por venta de bienes o servicios.', 1, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3200, N'Complementaria de otras cuentas por cobrar a extranjeros                                                                ', N'Este rubro se debe asignar a las cuentas complementarias que es donde se registra la diferencia entre el importe en moneda extranjera y el importe en la moneda origen considerando normalmente el tipo de cambio histórico cuando utilizamos para registrar las operaciones en moneda extranjera el método de tipo fijo con cuenta complementaria de activo.

El método de tipo fijo con cuenta complementaria de activo registra las operaciones en cuentas de moneda extranjera a un tipo de cambio establecido y la diferencia con el tipo de cambio real se registra en una cuenta complementaria de activo.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Es una  cuenta complementaria de otra que maneja moneda extranjera y por lo cual tiene su cuenta principal, no se considera para el cálculo del ajuste anual por inflación, ni para el cálculo del IMPAC.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 1, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3210, N'Cuentas y documentos por cobrar a intercompañias nacionales (si ajuste x inflación)                                     ', N'Se asigna a las cuentas de créditos valuados en moneda nacional otorgados a compañías afiliadas.

Las compañías afiliadas son aquéllas que tienen accionistas comunes o administración común con otra empresa e influencia significativa.

Se asigna a las cuentas de créditos valuados en moneda nacional otorgados a compañías afiliadas.

Se considerán créditos para el cálculo del ISR e IMPAC
', 1, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3220, N'Cuentas y documentos por cobrar a intercompañias nacionales en moneda extranjera (si ajuste x infla                     ', N'', 1, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3230, N'Complementaria de cuentas y documentos por cobrar a intercompañias nacionales en moneda extranjera                      ', N'Este rubro se debe asignar a las cuentas complementarias que es donde se registra la diferencia entre el importe en moneda extranjera y el importe en la moneda origen considerando normalmente el tipo de cambio histórico cuando utilizamos para registrar las operaciones en moneda extranjera el método de tipo fijo con cuenta complementaria de activo.

El método de tipo fijo con cuenta complementaria de activo registra las operaciones en cuentas de moneda extranjera a un tipo de cambio establecido y la diferencia con el tipo de cambio real se registra en una cuenta complementaria de activo.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Es una  cuenta complementaria de otra que maneja moneda extranjera y por lo cual tiene su cuenta principal, no se considera para el cálculo del ajuste anual por inflación, ni para el cálculo del IMPAC.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     ', 1, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3240, N'Cuentas y documentos por cobrar a intercompañias extranjeras en moneda extranjera  (si ajuste x i                       ', N'Son las cuentas por cobrar a compañías afiliadas del extranjero, que surgen con motivo de operaciones realizadas con estas.

Las compañías afiliadas son aquéllas que tienen accionistas comunes o administración común significativos.
', 1, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3250, N'Complementaria de cuentas y documentos por cobrar a intercompañías extranjeras en moneda extranjera                     ', N'Este rubro se debe asignar a las cuentas complementarias que es donde se registra la diferencia entre el importe en moneda extranjera y el importe en la moneda origen considerando normalmente el tipo de cambio histórico cuando utilizamos para registrar las operaciones en moneda extranjera el método de tipo fijo con cuenta complementaria de activo.

El método de tipo fijo con cuenta complementaria de activo registra las operaciones en cuentas de moneda extranjera a un tipo de cambio establecido y la diferencia con el tipo de cambio real se registra en una cuenta complementaria de activo.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Es una  cuenta complementaria de otra que maneja moneda extranjera y por lo cual tiene su cuenta principal, no se considera para el cálculo del ajuste anual por inflación, ni para el cálculo del IMPAC.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   ', 1, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3260, N'Estimación para cuentas incobrables (no ajuste x inflación)                                                             ', N'Son las cantidades que la empresa estima que no podrá cobrar por los créditos otorgados.', 1, 3, 4, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3300, N'Pagos provisionales, (no ajuste x inflación)                                                                            ', N'Este rubro se asigna a las cuentas que controlan los pagos efectuados a cuenta de las contribuciones causadas                                                                                                                                                                                                                                                                                                                                                                                                                                                             
Este rubro no son considerados para el cálculo del ISR Art. 47, fracc. IV  ni para el IMPAC Art. 4, fracc. III, segundo párrafo.
', 1, 3, 5, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3310, N'Contribuciones a favor (si ajuste x inflación)                                                                          ', N'', 1, 3, 6, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3320, N'Contribuciones a favor (no ajuste x inflación)                                                                          ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 1, 3, 6, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3330, N'IDE retenido                                                                                                            ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 1, 3, 6, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3340, N'Cuentas por cobrar a cargo de otros acreedores (no ajuste x inflación)                                                  ', N'Son los ingresos por enajenación de bienes y/o por la prestación de servicios realizados en territorio nacional, gravados a la tasa del 15% de IVA.

Son ventas brutas, no incluyen las devoluciones, rebajas y descuentos sobre ingresos (rubros 200, 210, 220, 230, 240, 250).

Estos ingresos se obtienen por el giro propio de la empresa,  no incluyen ingresos por partidas discontinuas y extraordinarias (rubros 300, 310, 320, 340, 390, 400, 410, 420, 500, 510, 520, 530, 540, 550, 560, 570, 580, 590, 600, 610, 620, 630, 640).

Son ingresos obtenidos en territorio nacional,  no incluyen los ingresos por exportaciones (rubros 140), ni los ingresos obtenidos por establecimientos en el extranjero (rubro 150).

Son ingresos con IVA al 15%,  no incluyen ingresos exentos de IVA (rubro 100) ni gravados con otras tasas de IVA (rubros 110, 120).

La tasa general del IVA es el 15%, se aplica a todas las personas físicas y morales que, en territorio nacional, realicen ventas o presten servicios independientes.

Fundamento legal LIVA Art. 1, LIVA Art. 10', 1, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3350, N'IVA retenido en la venta de desperdicios                                                                                ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Este rubro se  asigna a la cuenta que registra las operaciones de la empresa por las que retiene el  IVA,  por venta de desperdicios

No se considera para el cálculo del ajuste anual por inflación, LISR Art. 48, tercer párrafo, por ser partidas no deducibles.

No forma parte de las deudas para el cálculo del IMPAC Art. 5, por ser venta que se realiza a personas físicas comúnmente y que no tienen un establecimiento  permanente
', 1, 3, 5, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3380, N'IVA acreditable efectivamente pagado                                                                                    ', N'Este rubro se  asigna a la cuenta que registra el IVA Acreditable que  ya fue efectivamente  pagado.

No son considerados créditos  los impuestos  por lo tanto no se considera  para el cálculo del ISR e IMPAC', 1, 3, 14, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3381, N'IVA acreditable efectivamente pagado a tasa 16%                                                                         ', N'Son los ingresos por enajenación de bienes y/o por la prestación de servicios realizados en territorio nacional, gravados a la tasa del 15% de IVA.

Son ventas brutas, no incluyen las devoluciones, rebajas y descuentos sobre ingresos (rubros 200, 210, 220, 230, 240, 250).

Estos ingresos se obtienen por el giro propio de la empresa,  no incluyen ingresos por partidas discontinuas y extraordinarias (rubros 300, 310, 320, 340, 390, 400, 410, 420, 500, 510, 520, 530, 540, 550, 560, 570, 580, 590, 600, 610, 620, 630, 640).

Son ingresos obtenidos en territorio nacional,  no incluyen los ingresos por exportaciones (rubros 140), ni los ingresos obtenidos por establecimientos en el extranjero (rubro 150).

Son ingresos con IVA al 15%,  no incluyen ingresos exentos de IVA (rubro 100) ni gravados con otras tasas de IVA (rubros 110, 120).

La tasa general del IVA es el 15%, se aplica a todas las personas físicas y morales que, en territorio nacional, realicen ventas o presten servicios independientes.

Fundamento legal LIVA Art. 1, LIVA Art. 10', 1, 3, 14, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3382, N'IVA acreditable efectivamente pagado a tasa 11%                                                                         ', N'Son los ingresos por enajenación de bienes y/o por la prestación de servicios realizados en territorio nacional, gravados a la tasa del 15% de IVA.

Son ventas brutas, no incluyen las devoluciones, rebajas y descuentos sobre ingresos (rubros 200, 210, 220, 230, 240, 250).

Estos ingresos se obtienen por el giro propio de la empresa,  no incluyen ingresos por partidas discontinuas y extraordinarias (rubros 300, 310, 320, 340, 390, 400, 410, 420, 500, 510, 520, 530, 540, 550, 560, 570, 580, 590, 600, 610, 620, 630, 640).

Son ingresos obtenidos en territorio nacional,  no incluyen los ingresos por exportaciones (rubros 140), ni los ingresos obtenidos por establecimientos en el extranjero (rubro 150).

Son ingresos con IVA al 15%,  no incluyen ingresos exentos de IVA (rubro 100) ni gravados con otras tasas de IVA (rubros 110, 120).

La tasa general del IVA es el 15%, se aplica a todas las personas físicas y morales que, en territorio nacional, realicen ventas o presten servicios independientes.

Fundamento legal LIVA Art. 1, LIVA Art. 10', 1, 3, 14, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3386, N'IVA acreditable a tasa 0%                                                                                               ', N'', 1, 3, 14, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3388, N'IVA acreditable exento                                                                                                  ', N'', 1, 3, 14, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3390, N'IVA acreditable no pagado cuenta puente                                                                                 ', N'Este rubro se  asigna a la cuentas que registran el IVA Acreditable que  aun no ha sido efectivamente pagado.

No son considerados créditos  los impuestos  por lo tanto no se considera  para el cálculo del ISR e IMPAC', 1, 3, 14, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3400, N'ISR retenido por intereses bancarios e inversiones, (no ajuste x inflación)                                             ', N'Este rubro debe de asignarse a las cuentas donde se registren retenciones a favor, por ejemplo de bancos que se disminuiran de las cantidades que resulten a pagar en los pagos provisionales

Los impuestos no son considerados para el cálculo del  ajuste anual por inflación LISR Art. 47 fracc. Tampoco son considerados para el IMPAC Art. 4 fracc.    ', 1, 3, 5, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3410, N'Subsidio al empleo por acreditar (no ajuste x inflación)                                                                ', N'

Este rubro no son considerados para el cálculo del ISR Art. 47, fracc. IV  ni para el IMPAC Art. 4, fracc. III, segundo párrafo.
', 1, 3, 6, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3420, N'Impuesto acreditable pagado en el extranjero                                                                            ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 1, 3, 6, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3430, N'Impuesto acreditable por dividendos o utilidades distribuidos                                                           ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 1, 3, 6, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3450, N'Anticipo a proveedores de materia prima  (inventario para ISR)                                                          ', N'Son los importes de anticipos que la empresa dio a los proveedores para compras futuras de materia prima. Valuada en moneda nacional.

Estos anticipos no forman parte de los demás créditos para el cálculo del ajuste anual por inflación, y tampoco se consideran creditos para el cálculo del IMPAC, pueden formar parte de los inventarios para la deteminación del costo de ventas  para efectos de ISR, y támbien pueden considerarse como parte de los  inventarios para efectos del IMPAC, si se cumple  con lo mencionado en el Boletin C-4  de Principios de                                                                                                                                                                                                                                                                                                                                                                                                                                           ', 1, 3, 8, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3454, N'Anticipo a proveedores de productos en proceso                                                                          ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 1, 3, 7, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3460, N'Anticipo a proveedores  de productos terminados  (Inventario para ISR)                                                  ', N'Son los importes de anticipos que la empresa dio a los proveedores para compras futuras de productos terminados. Valuados en moneda nacional.

Estos anticipos no forman parte de los demás créditos para el cálculo del ajuste anual por inflación, y tampoco se consideran creditos para el cálculo del IMPAC, pueden formar parte de los inventarios para la deteminación del costo de ventas  para efectos de ISR, y támbien pueden considerarse como parte de los  inventarios para efectos del IMPAC, si se cumple  con lo mencionado en el Boletin C-4  de Principios de Contabilidad.
', 1, 3, 7, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3470, N'Mercancías en tránsito de materia prima                                                                                 ', N' Las mercancías en tránsito de productos terminados forman parte de los inventarios de la empresa, por lo tanto participa en el  cálculo del  IMPAC  Art. 2 fracc. IV

Para la LISR, es un gasto deducible, aunque todavía no este en la empresa, el fundamento legal lo encontramos en el Art. fracc. II, 31 fracc. I, III y IV


', 1, 3, 8, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3474, N'Mercancias en transito de productos en proceso                                                                          ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 1, 3, 9, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3480, N'Mercancías en tránsito de productos terminados                                                                          ', N'Las mercancías en tránsito de materias primas forman parte de los inventarios de la empresa, por lo tanto forma parte de los valores de los activos para el cálculo del IMPAC Art. 2 fracc. IV
', 1, 3, 7, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3490, N'Inventario de materia prima / almacen de materia prima                                                                  ', N'Es la existencia de mercancía en el almacén de empresas industriales, esta mercancía son elementos básicos para la elaboración del producto que vende la empresa.

Forma parte de los valores de los activos para el cálculo del IMPAC Art. 2 fracc. IV', 1, 3, 8, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3500, N'Actualización de inventario de materia prima B-10                                                                       ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 1, 3, 8, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3510, N'Inventario de productos en proceso / almacen de productos en proceso                                                    ', N'Es la existencia de productos aún no terminados de una empresa industrial.

Forma parte de los valores de los activos para el cálculo del IMPAC Art. 2 fracc. IV', 1, 3, 9, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3520, N'Actualización de inventario de productos en proceso B-10                                                                ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 1, 3, 9, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3530, N'Inventario de productos terminados / almacen de productos terminados                                                    ', N'Es la existencia de productos elaborados de empresas comerciales e industriales.

Forma parte de los valores de los activos para el cálculo del IMPAC Art. 2 fracc. IV', 1, 3, 7, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3540, N'Actualización de inventario de productos terminados B-10                                                                ', N'Para incorporar los efectos de la inflación en la información financiera, en México el Instituto Mexicano de Contadores Públicos, A. C. ha venido emitiendo una serie de directrices plasmadas en el boletín B -10, denominado "Reconocimiento de los Efectos de la Inflación en la Información Financiera", y en los documentos de adecuaciones al mismo, que forman parte de los Principios de Contabilidad Generalmente Aceptados ( PCGA).

Se utiliza un Rubro especial para el reconocimiento de la Inflación, y las cuentas contables a las que se asigne este rubro solamente integraran los estados financieros, y no intervendran en los calculos fiscales porque para dichos calculos se utilizan  datos historicós.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 1, 3, 7, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3550, N'Reevaluación de inventarios                                                                                             ', N'Reevaluación de inventarios                                           ', 1, 3, 7, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3560, N'Estimación para obsolescencia y lento movimiento de inventarios                                                         ', N'Provisión por la pérdida de valor y lenta renovación de los artículos que forman parte del inventario.

Para el ISR no se considera porque es una provisión y no un derecho que tiene una persona acreedora a recibir de otra deudora una cantidad en numerario.
No se considera para el cálculo del IMPAC', 1, 3, 7, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3600, N'Otros activos circulantes  (si ajuste x inflación)                                                                      ', N'', 1, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3610, N'Otros activos circulantes  (no ajuste x inflación)                                                                      ', N'', 1, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3640, N'Intereses devengados a favor, no cobrados (si ajuste x inflación)                                                       ', N'Los intereses devengados a favor y que no an sido cobrados, se registraran en cuentas de balance (Activo) y es a estas cuentas a las que se les asignara este rubro fiscal,

Estas cuentas se van a considerar como "Creditos" para efectos del Ajuste anual por Inflación esto de acuerdo al Art. 47 de la LISR.

Tambien se considera como Activos Financieros para efectos del IMPAC. de acuerdo al Art. 4 Fracción 4 de LIA.', 1, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3660, N'Acciones de sociedades nacionales                                                                                       ', N'Son las inversiones en acciones de otras personas morales residentes en México.

Las acciones no se consideran créditos para el cálculo del ISR Art.47, fracc.VI

Las acciones emitidas por las empresas nacionales no se considera para el cálculo del IMPAC, fracc. II, siempre y cuando tengan su residencia en México
', 1, 3, 13, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3670, N'Acciones de sociedades del extranjero                                                                                   ', N'Inversiones en acciones de otras personas morales residentes en el extranjero. Diferentes de las sociedades de inversión extranjera.
Las acciones no se consideran créditos para el cálculo del ISR Art.47, fracc.VI

Las acciones emitidas por las empresas extranjeras no se considera para el cálculo del IMPAC, fracc. II, siempre y cuando tengan su residencia en México', 1, 3, 13, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3680, N'Efectos de actualizacion cuentas de activo                                                                              ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 1, 3, 11, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3700, N'Terrenos (costo de adquisición)                                                                                         ', N'Inversiones en predios que pertenecen al contribuyente, tienen la caracteristica de que no se deprecian ni se amortizan contable  ni fiscalmente.

Para el  cálculo del IMPAC el terreno se actualiza. Art. 3, tercer párrafo IMPAC

', 1, 3, 10, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3710, N'Actualización de terrenos B-10                                                                                          ', N'Para hacer frente a esa falta de comparabilidad y para incorporar los efectos de la inflación en la información financiera, en México el Instituto Mexicano de Contadores Públicos, A. C. ha venido emitiendo una serie de directrices plasmadas en el boletín B -10, denominado "Reconocimiento de los Efectos de la Inflación en la Información Financiera", y en los documentos de adecuaciones al mismo, que forman parte de los Principios de Contabilidad Generalmente Aceptados ( PCGA).
Se utiliza un Rubro especial para la Actualización, y las cuentas contables a las que se asigne este rubro solamente integraran los estados financieros, y no intervendran en los calculos fiscales porque la información que se utiliza para los Cálculos Fiscales, son datos históricos.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      ', 1, 3, 10, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3720, N'Construcciones                                                                                                          ', N'Inversiones en activo fijo referente a las construcciones, aún cuando están en proceso. Es el valor del inmueble donde el contribuyente realiza las actividades propias del negocio, tienen la caracteristica de que sufren depreciación,  no se amortizan ni se revaluan.

Las inversiones por construcción se deprecian según sea el caso si  es para inmuebles declarados como monumentos arqueológicos, artísticos, históricos o patrimoniales o en los demás casos. 
 
Las inversiones se deprecian y Exentus obtiene  su cálculo para ser considerado una deducción para el cálculo del ISR Art.37, 38, 40

También es considerado para el cálculo del IMPAC Art. 2, 3
', 1, 3, 10, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3730, N'Actualización de construcciones B-10                                                                                    ', N'Para incorporar los efectos de la inflación en la información financiera, en México el Instituto Mexicano de Contadores Públicos, A. C. ha venido emitiendo una serie de directrices plasmadas en el boletín B -10, denominado "Reconocimiento de los Efectos de la Inflación en la Información Financiera", y en los documentos de adecuaciones al mismo, que forman parte de los Principios de Contabilidad Generalmente Aceptados ( PCGA).

Se utiliza un Rubro especial para el reconocimiento de la Inflación, y las cuentas contables a las que se asigne este rubro solamente integraran los estados financieros, y no intervendran en los calculos fiscales porque para dichos calculos se utilizan  datos historicós.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 1, 3, 10, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3732, N'Construcciones en proceso                                                                                               ', N'Son los ingresos por enajenación de bienes y/o por la prestación de servicios realizados en territorio nacional, gravados a la tasa del 15% de IVA.

Son ventas brutas, no incluyen las devoluciones, rebajas y descuentos sobre ingresos (rubros 200, 210, 220, 230, 240, 250).

Estos ingresos se obtienen por el giro propio de la empresa,  no incluyen ingresos por partidas discontinuas y extraordinarias (rubros 300, 310, 320, 340, 390, 400, 410, 420, 500, 510, 520, 530, 540, 550, 560, 570, 580, 590, 600, 610, 620, 630, 640).

Son ingresos obtenidos en territorio nacional,  no incluyen los ingresos por exportaciones (rubros 140), ni los ingresos obtenidos por establecimientos en el extranjero (rubro 150).

Son ingresos con IVA al 15%,  no incluyen ingresos exentos de IVA (rubro 100) ni gravados con otras tasas de IVA (rubros 110, 120).

La tasa general del IVA es el 15%, se aplica a todas las personas físicas y morales que, en territorio nacional, realicen ventas o presten servicios independientes.

Fundamento legal LIVA Art. 1, LIVA Art. 10', 1, 3, 10, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3734, N'Actualización de construcciones en proceso B-10                                                                         ', N'Son los ingresos por enajenación de bienes y/o por la prestación de servicios realizados en territorio nacional, gravados a la tasa del 15% de IVA.

Son ventas brutas, no incluyen las devoluciones, rebajas y descuentos sobre ingresos (rubros 200, 210, 220, 230, 240, 250).

Estos ingresos se obtienen por el giro propio de la empresa,  no incluyen ingresos por partidas discontinuas y extraordinarias (rubros 300, 310, 320, 340, 390, 400, 410, 420, 500, 510, 520, 530, 540, 550, 560, 570, 580, 590, 600, 610, 620, 630, 640).

Son ingresos obtenidos en territorio nacional,  no incluyen los ingresos por exportaciones (rubros 140), ni los ingresos obtenidos por establecimientos en el extranjero (rubro 150).

Son ingresos con IVA al 15%,  no incluyen ingresos exentos de IVA (rubro 100) ni gravados con otras tasas de IVA (rubros 110, 120).

La tasa general del IVA es el 15%, se aplica a todas las personas físicas y morales que, en territorio nacional, realicen ventas o presten servicios independientes.

Fundamento legal LIVA Art. 1, LIVA Art. 10', 1, 3, 10, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3740, N'Maquinaria y equipo                                                                                                     ', N'Inversiones en máquinas de las que se sirven las industrias para realizar su producción.

Son bienes tangibles que tienen como caracteristica que se deprecian, no se amortizan ni se revaluan, pierden su valor por el uso y por el transcurso del tiempo. 

Las maquinarias y equipo se deprecian de acuerdo a la actividad en que sean utilizados por lo cual el  % varia de acuerdo a la actividad que desarrolla. Art. 41 LISR
 
Las inversiones se deprecian y Exentus obtiene  su cálculo para ser considerado una deducción fiscal para el cálculo del ISR Art. 41

También es considerado para el cálculo del IMPAC Art. 2, 3
', 1, 3, 10, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3750, N'Actualización de maquinaria y equipo B-10                                                                               ', N'Para incorporar los efectos de la inflación en la información financiera, en México el Instituto Mexicano de Contadores Públicos, A. C. ha venido emitiendo una serie de directrices plasmadas en el boletín B -10, denominado "Reconocimiento de los Efectos de la Inflación en la Información Financiera", y en los documentos de adecuaciones al mismo, que forman parte de los Principios de Contabilidad Generalmente Aceptados ( PCGA).

Se utiliza un Rubro especial para el reconocimiento de la Inflación, y las cuentas contables a las que se asigne este rubro solamente integraran los estados financieros, y no intervendran en los calculos fiscales porque para dichos calculos se utilizan  datos historicós.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 1, 3, 10, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3760, N'Mobiliario y equipo de oficina                                                                                          ', N'Inversiones en escritorios, sillas, mesas, libreros, mostradores, básculas, vitrinas, máquinas de escribir, etc.

Son bienes tangibles que tienen la caracteristica que se deprecian,  no se amortizan ni se revaluan, pierden su valor por el uso y por el transcurso del tiempo. 

El mobiliario y equipo de oficina tiene un porcentaje de depreciación de 10%  Art. 40 LISR
 
Las inversiones se deprecian y Exentus obtiene  su cálculo para ser considerado una deducción fiscal para el cálculo del ISR Art. 40

También es considerado para el cálculo del IMPAC Art. 2, 3
', 1, 3, 10, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3770, N'Actualización de mobiliario y equipo de oficina  B-10                                                                   ', N'Para incorporar los efectos de la inflación en la información financiera, en México el Instituto Mexicano de Contadores Públicos, A. C. ha venido emitiendo una serie de directrices plasmadas en el boletín B -10, denominado "Reconocimiento de los Efectos de la Inflación en la Información Financiera", y en los documentos de adecuaciones al mismo, que forman parte de los Principios de Contabilidad Generalmente Aceptados ( PCGA).

Se utiliza un Rubro especial para el reconocimiento de la Inflación, y las cuentas contables a las que se asigne este rubro solamente integraran los estados financieros, y no intervendran en los calculos fiscales porque para dichos calculos se utilizan  datos historicós.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 1, 3, 10, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3780, N'Equipo de cómputo y periféricos                                                                                         ', N'En este rubro fiscal se asignara a todos los dispositivos y perifericos de computo                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
El Equipo de computo y periferico tiene un porcentaje de depreciación del 30%  Art. 40 LISR
 
Las inversiones se deprecian y Exentus obtiene  su cálculo para ser considerado una deducción fiscal para el cálculo del ISR Art. 40

También es considerado para el cálculo del IMPAC Art. 2, 3
', 1, 3, 10, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3790, N'Actualización de equipo de cómputo y periféricos B-10                                                                   ', N'Para incorporar los efectos de la inflación en la información financiera, en México el Instituto Mexicano de Contadores Públicos, A. C. ha venido emitiendo una serie de directrices plasmadas en el boletín B -10, denominado "Reconocimiento de los Efectos de la Inflación en la Información Financiera", y en los documentos de adecuaciones al mismo, que forman parte de los Principios de Contabilidad Generalmente Aceptados ( PCGA).

Se utiliza un Rubro especial para el reconocimiento de la Inflación, y las cuentas contables a las que se asigne este rubro solamente integraran los estados financieros, y no intervendran en los calculos fiscales porque para dichos calculos se utilizan  datos historicós.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 1, 3, 10, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3800, N'Equipo de transporte automóviles                                                                                        ', N'Inversiones en camiones, camionetas, motocicletas, bicicletas, etc., que se utilizan en el reparto de las mercancías.

Son bienes tangibles que tienen la caracteristica que se deprecian, no se amortizan ni se revaluan, pierden su valor por el uso y por el transcurso del tiempo. 

El Equipo de transporte tiene un porcentaje de depreciación de 25%  Art. 40 LISR
 
Las inversiones se deprecian y Exentus obtiene  su cálculo para ser considerado una deducción fiscal para el cálculo del ISR Art. 40

También es considerado para el cálculo del IMPAC Art. 2, 3
', 1, 3, 10, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3810, N'Actualización de equipo de transporte automóviles B-10                                                                  ', N'Para incorporar los efectos de la inflación en la información financiera, en México el Instituto Mexicano de Contadores Públicos, A. C. ha venido emitiendo una serie de directrices plasmadas en el boletín B -10, denominado "Reconocimiento de los Efectos de la Inflación en la Información Financiera", y en los documentos de adecuaciones al mismo, que forman parte de los Principios de Contabilidad Generalmente Aceptados ( PCGA).

Se utiliza un Rubro especial para el reconocimiento de la Inflación, y las cuentas contables a las que se asigne este rubro solamente integraran los estados financieros, y no intervendran en los calculos fiscales porque para dichos calculos se utilizan  datos historicós.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 1, 3, 10, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3820, N'Equipo de transporte otros                                                                                              ', N'Inversiones en camiones, camionetas, motocicletas, bicicletas, etc., que se utilizan en el reparto de las mercancías.

Son bienes tangibles que tienen la caracteristica que se deprecian, no se amortizan ni se revaluan, pierden su valor por el uso y por el transcurso del tiempo. 

El Equipo de transporte tiene un porcentaje de depreciación de 25%  Art. 40 LISR
 
Las inversiones se deprecian y Exentus obtiene  su cálculo para ser considerado una deducción fiscal para el cálculo del ISR Art. 40

También es considerado para el cálculo del IMPAC Art. 2, 3
', 1, 3, 10, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3830, N'Actualización de equipo de transporte otros B-10                                                                        ', N'Para incorporar los efectos de la inflación en la información financiera, en México el Instituto Mexicano de Contadores Públicos, A. C. ha venido emitiendo una serie de directrices plasmadas en el boletín B -10, denominado "Reconocimiento de los Efectos de la Inflación en la Información Financiera", y en los documentos de adecuaciones al mismo, que forman parte de los Principios de Contabilidad Generalmente Aceptados ( PCGA).

Se utiliza un Rubro especial para el reconocimiento de la Inflación, y las cuentas contables a las que se asigne este rubro solamente integraran los estados financieros, y no intervendran en los calculos fiscales porque para dichos calculos se utilizan  datos historicós.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 1, 3, 10, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3834, N'Maquinaria y equipo para la generacion de energia (fuentes renovables)                                                  ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 1, 3, 10, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3836, N'Actualización de maquinaria y equipo para la generacion de energia (fuentes renovables) B-10                            ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 1, 3, 10, 1)
GO
print 'Processed 200 total records'
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3840, N'Otras inversiones en activos fijos                                                                                      ', N'Son otras inversiones en activos fijos, tienen la caracteristica de que se deprecian, no se amortizan ni se revaluan.
Este rubro fiscal es asignado a aquellas inversiones que no fuerón consideradas o asignadas por ninguno de los rubros arriba disponibles.', 1, 3, 11, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3850, N'Actualización de otras inversiones en activos fijos B-10                                                                ', N'Para incorporar los efectos de la inflación en la información financiera, en México el Instituto Mexicano de Contadores Públicos, A. C. ha venido emitiendo una serie de directrices plasmadas en el boletín B -10, denominado "Reconocimiento de los Efectos de la Inflación en la Información Financiera", y en los documentos de adecuaciones al mismo, que forman parte de los Principios de Contabilidad Generalmente Aceptados ( PCGA).

Se utiliza un Rubro especial para el reconocimiento de la Inflación, y las cuentas contables a las que se asigne este rubro solamente integraran los estados financieros, y no intervendran en los calculos fiscales porque para dichos cálculos se utilizan  datos historicós.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          ', 1, 3, 11, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3860, N'Depreciación acumulada                                                                                                  ', N'En este rubro se suma ejercicio con ejercicio la disminución de valor o precio que sufren las inversiones en activo fijo por causa del uso o transcurso del tiempo.

Son cuentas complementarias del activo fijo.

No se considera la depreciación historica para el cálculo del ISR,   Exentus considera la depreciacion actualizada. por ejercicio.

Tampoco se considera para el cálculo del IMPAC

No incluye las amortizaciones acumuladas de gastos y cargos diferidos.
', 1, 3, 12, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3870, N'Actualización de la depreciación acumulada B-10                                                                         ', N'Para incorporar los efectos de la inflación en la información financiera, en México el Instituto Mexicano de Contadores Públicos, A. C. ha venido emitiendo una serie de directrices plasmadas en el boletín B -10, denominado "Reconocimiento de los Efectos de la Inflación en la Información Financiera", y en los documentos de adecuaciones al mismo, que forman parte de los Principios de Contabilidad Generalmente Aceptados ( PCGA).

Se utiliza un Rubro especial para el reconocimiento de la Inflación, y las cuentas contables a las que se asigne este rubro solamente integraran los estados financieros, y no intervendran en los calculos fiscales porque para dichos cálculos se utilizan  datos historicós.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ', 1, 3, 12, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3880, N'Gastos, cargos diferidos y erogaciones en periodos preoperativos                                                        ', N'Los gastos diferidos son los activos intangibles representados por bienes o derechos que permitan reducir costos de operación o mejorar la calidad o aceptación de un producto, por un período limitado, inferior a la duración de la actividad de la persona moral.

Los cargos diferidos son los activos intangibles representados por bienes o derechos que permitan reducir costos de operación o mejorar la calidad o aceptación de un producto, por un período ilimitado que dependerá de la duración de la actividad de la persona moral.

Los gastos preoperativos, son aquellos que tienen por objeto la investigación y el desarrollo, relacionados con el diseño, elaboración, mejoramiento, empaque o distribución de un producto, así como la prestación de un servicio; siempre que las eragaciones se efectúen antes de que el contribuyente enajene sus productos o preste sus servicios en forma constante.

Estos gastos tienen la caracteristica de que se amortizan, no se deprecian ni se revaluan. Tienen varios porcentajes en relacion al tipo de gastos (preoperativos, gastos y cargos diferidos),  Art. 39 LISR.

Los gastos y cargos diferidos se actualizan para el cálculo del IMPAC Art. 3


', 1, 3, 11, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3890, N'Actualización de gastos, cargos diferidos y erogaciones en periodos preoperativos B-10                                  ', N'Para incorporar los efectos de la inflación en la información financiera, en México el Instituto Mexicano de Contadores Públicos, A. C. ha venido emitiendo una serie de directrices plasmadas en el boletín B -10, denominado "Reconocimiento de los Efectos de la Inflación en la Información Financiera", y en los documentos de adecuaciones al mismo, que forman parte de los Principios de Contabilidad Generalmente Aceptados ( PCGA).

Se utiliza un Rubro especial para el reconocimiento de la Inflación, y las cuentas contables a las que se asigne este rubro solamente integraran los estados financieros, y no intervendran en los calculos fiscales porque para dichos cálculos se utilizan  datos historicós.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ', 1, 3, 11, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3900, N'Pagos anticipados                                                                                                       ', N'No se considera crédito para efectos de la determinación del Impuesto al Activo por lo siguiente:

De acuerdo con la fracción II del artículo 2o. de la LIA, 
Activos fijos, gastos y cargos diferidos 
II.	Tratándose de los activos fijos, gastos y cargos diferidos, se calculará el promedio de cada bien, actualizando en los términos del artículo 3o. de esta Ley, su saldo pendiente de deducir en el impuesto sobre la renta al inicio del ejercicio o el monto original de la inversión en el caso de bienes adquiridos en el mismo y de aquellos no deducibles para los efectos de dicho impuesto, aun cuando para estos efectos no se consideren activos fijos. El saldo actualizado se disminuirá con la mitad de la deducción anual de las inversiones en el ejercicio, determinada conforme a los artículos 41 y 47 de la Ley del Impuesto sobre la Renta. 
Considerando que este rubro fiscal se le asignara únicamente a  aquellas cuentas que registren pagos anticipados que se hicieron deducibles en el momento de realizar el pago, y de los cuales se tiene la certeza de que se va a recibir el servicio o el beneficio, entonces al no haber saldo pendiente por deducir no se considerara Crédito para la determinación del Impuesto al Activo.



Tampoco se considera crédito para la determinación del Ajuste por Inflación por lo siguiente:

LISR Art. 47, párrafo 1 concepto de crédito para el Ajuste por Inflación.

Para los efectos del artículo 46, se considerará crédito, el derecho que tiene una persona acreedora a recibir de otra deudora una cantidad en numerario, entre otros: los derechos de crédito que adquieran las empresas de factoraje financiero, las inversiones en acciones de sociedades de inversión en instrumentos de deuda y las operaciones financieras derivadas señaladas en la fracción IX del artículo 22 de esta Ley. 
Los pagos anticipados se realizan con la intención de recibir un servicio o un beneficio, y no con la intención de recibir una cantidad en numerario, además que  en los pagos anticipados ya no existe el derecho de cobro, debido a que ya fueron  una erogación deducible, por lo tanto no se considera crédito.

Si se consideraran como créditos se estaría deduciendo doblemente.

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 1, 3, 11, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3904, N'Adaptación a instalaciones para personas con capacidades diferentes                                                     ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 1, 3, 11, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3906, N'Actualización de adaptación a instalaciones para personas con capacidades diferentes B-10                               ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 1, 3, 11, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3910, N'Amortización acumulada                                                                                                  ', N'En este rubro se va sumando ejercicio con ejercicio cada una de las partes en que se dividió el valor de las partidas que forman los gastos y cargos diferidos. Son cuentas complementarias del activo diferido. No incluye la depreciación acumulada del activo fijo.

No se considera para el cálculo del ISR ni  IMPAC                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 1, 3, 12, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (3920, N'Actualización de la amortización acumulada B-10                                                                         ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 1, 3, 12, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4000, N'Cuentas por pagar a proveedores de empresas nacionales (si ajuste x inflación)                                          ', N'Son deudas que tiene que pagar la empresa ya sea por compra de mercancía a crédito o por deudas que garantiza la empresa con títulos de crédito a cargo (pagarés, letras de cambio).

Estas deudas son valuadas en moneda nacional.

Forman parte de las "Deudas" para el cálculo del ajuste anual por inflación

Son deudas que no se consideran para la determinación del Impuesto al Activo, esto debido a que derogo el Art. 5 de LIAC. (Se deroga el DOF del 27 de Diciembre de 2006)', 2, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4010, N'Cuentas por pagar a proveedores de empresas nacionales en moneda extranjera (si ajuste x inflación)                     ', N'Son deudas que tiene que pagar la empresa ya sea por compra de mercancía a crédito o por deudas que garantiza la empresa con títulos de crédito a cargo (pagarés, letras de cambio).

Estas deudas son valuadas en moneda extranjera.

Forman parte de las "Deudas" para el cálculo del ajuste anual por inflación

Son deudas que no se consideran para la determinación del Impuesto al Activo, esto debido a que derogo el Art. 5 de LIAC. (Se deroga el DOF del 27 de Diciembre de 2006)', 2, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4020, N'Complementaria de cuentas por pagar a proveedores de empresas nacionales en moneda extranjera                           ', N'Este rubro se debe asignar a las cuentas complementarias que es donde se registra la diferencia entre el importe en moneda extranjera y el importe en la moneda origen considerando normalmente el tipo de cambio histórico cuando utilizamos para registrar las operaciones en moneda extranjera el método de tipo fijo con cuenta complementaria de pasivo.

El método de tipo fijo con cuenta complementaria de pasivo registra las operaciones en cuentas de moneda extranjera a un tipo de cambio establecido y la diferencia con el tipo de cambio real se registra en una cuenta complementaria de pasivo.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Es una  cuenta complementaria de otra que maneja moneda extranjera y por lo cual tiene su cuenta principal. No se considera para el cálculo del ajuste anual por inflación, ni para el cálculo del IMPAC.
', 2, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4030, N'Anticipos de clientes nacionales (solo ingreso acumulable)                                                              ', N'Son los importes de anticipos que los clientes dan a la empresa para ventas futuras.

Que se obtengan exclusivamente en el ejercicio en curso. Valuados en moneda nacional.

Estos anticipos forman no parte de las deudas para el cálculo del Ajuste por Inflación de las deudas.
 
Tampoco forman parte de las deudas para la determinación del Impuesto al Activo.
', 2, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4040, N'Anticipos de clientes extranjeros (solo ingreso acumulable)                                                             ', N'Son los importes de anticipos que los clientes dan a la empresa para ventas futuras. 

Que se obtengan exclusivamente en el ejercicio en curso valuados en moneda extranjera. 

Estos anticipos no forman parte de las deudas para el cálculo del   Ajuste por Inflación.

Tampoco forman parte de las deudas para la determinación del Impuesto al Activo.
', 2, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4050, N'Otros ingresos cobrados por anticipado (solo ingreso acumulable)                                                        ', N'Se asigna a las cuentas que registran todas aquellas cantidades cobradas anticipadamente, por las que tenemos la obligación de proporcionar un servicio, tanto en el mismo ejercicio como en los posteriores.     

Este rubro no se considera para el cálculo del ajuste anual por inflación. LISR Art. 48, y tampoco
se considera para el cálculo del Impuesto al Activo.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              ', 2, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4060, N'Ctas. por pagar con extranjeros que tengan establecimiento permanente en México (si ajuste x inflación)                 ', N'Son cuentas y documentos por pagar a empresas extranjeras por concepto de compra de mercancía a crédito, por prestación de servicios que recibe la empresa o por deudas que garantiza la empresa con títulos de crédito (pagarés, letras de cambio).

Estas cuentas son comúnmente llamadas proveedores en moneda extranjera.

Forman parte de las "Deudas" para efectos del cálculo del ajuste anual por inflación.

Son deudas que no se consideran para la determinación del Impuesto al Activo, esto debido a que se derogo el Art. 5 de LIAC. (Se deroga DOF 27 de Diciembre 2006).', 2, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4070, N'Complementaria de ctas. por pagar con extranjeros que tengan establecimiento permanente en México                       ', N'Este rubro se debe asignar a las cuentas complementarias que es donde se registra la diferencia entre el importe en moneda extranjera y el importe en la moneda origen considerando normalmente el tipo de cambio histórico cuando utilizamos para registrar las operaciones en moneda extranjera el método de tipo fijo con cuenta complementaria de pasivo.

El método de tipo fijo con cuenta complementaria de pasivo registra las operaciones en cuentas de moneda extranjera a un tipo de cambio establecido y la diferencia con el tipo de cambio real se registra en una cuenta complementaria de pasivo.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Es una  cuenta complementaria de otra que maneja moneda extranjera y por lo cual tiene su cuenta principal. No se considera para el cálculo del ajuste anual por inflación, ni para el cálculo del IMPAC.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 2, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4080, N'Ctas. por pagar con extranjeros que no tengan establecimiento perman. en México  (si ajuste x inflación)                ', N'Se asigna a la cuenta que registra las cantidades que adeudamos a nuestros proveedores por compras de importación, valuadas en moneda extranjera  y que tienen su establecimiento permanente fuera de nuestro país.

Se considera para el cálculo del  ajuste anual por inflación LISR Art. 48, cuarto párrafo.

Son deudas que no se consideran para la determinación del Impuesto al Activo, esto debido a que se derogo el Art. 5 de LIAC. (Se deroga DOF 27 de Diciembre 2006)', 2, 3, 5, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4090, N'Complementaria de cuentas por pagar con extranjeros sin establecimiento permanente                                      ', N'Este rubro se debe asignar a las cuentas complementarias que es donde se registra la diferencia entre el importe en moneda extranjera y el importe en la moneda origen considerando normalmente el tipo de cambio histórico cuando utilizamos para registrar las operaciones en moneda extranjera el método de tipo fijo con cuenta complementaria de pasivo.

El método de tipo fijo con cuenta complementaria de pasivo registra las operaciones en cuentas de moneda extranjera a un tipo de cambio establecido y la diferencia con el tipo de cambio real se registra en una cuenta complementaria de pasivo.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Es una  cuenta complementaria de otra que maneja moneda extranjera y por lo cual tiene su cuenta principal. No se considera para el cálculo del ajuste anual por inflación, ni para el cálculo del IMPAC.
', 2, 3, 5, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4100, N'Cuentas por pagar a intercompañías nacionales (si ajuste x inflación)                                                   ', N'Son deudas que tiene que pagar la empresa ya sea por compra de mercancía a crédito o por deudas que garantiza la empresa con títulos de crédito a cargo (pagarés, letras de cambio).

Estas deudas son valuadas en moneda nacional.

Las compañías afiliadas son aquéllas que tienen accionistas comunes o administración común significativos.

Forman parte de las "Deudas" para el cálculo del ajuste anual por inflación.

Son deudas que no se consideran para la determinación del Impuesto al Activo, esto debido a que se derogo el Art. 5 de LIAC. (Se deroga DOF 27 de Diciembre 2006).
', 2, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4110, N'Cuentas por pagar a intercompañias nacionales moneda extranjera (si ajuste x inflación)                                 ', N'Son deudas que tiene que pagar la empresa ya sea por compra de mercancía a crédito o por deudas que garantiza la empresa con títulos de crédito a cargo (pagarés, letras de cambio).

Estas deudas son valuadas en moneda extranjera.

Las compañías afiliadas son aquéllas que tienen accionistas comunes o administración común significativos.

Forman parte de las "Deudas" para el cálculo del ajuste anual por inflación

Son deudas que no se consideran para la determinación del Impuesto al Activo, esto debido a que se derogo el Art. 5 de LIAC. (Se deroga DOF 27 de Diciembre 2006).
', 2, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4120, N'Complementaria de cuentas por pagar a intercompañias nacionales moneda extranjera                                       ', N'Este rubro se debe asignar a las cuentas complementarias que es donde se registra la diferencia entre el importe en moneda extranjera y el importe en la moneda origen considerando normalmente el tipo de cambio histórico cuando utilizamos para registrar las operaciones en moneda extranjera el método de tipo fijo con cuenta complementaria de pasivo.

El método de tipo fijo con cuenta complementaria de pasivo registra las operaciones en cuentas de moneda extranjera a un tipo de cambio establecido y la diferencia con el tipo de cambio real se registra en una cuenta complementaria de pasivo.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Es una  cuenta complementaria de otra que maneja moneda extranjera y por lo cual tiene su cuenta principal. No se considera para el cálculo del ajuste anual por inflación, ni para el cálculo del IMPAC.
', 2, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4130, N'Cuentas por pagar a intercompañías extranjeras (si ajuste x inflación)                                                  ', N'Son deudas que tiene que pagar la empresa ya sea por compra de mercancía a crédito o por deudas que garantiza la empresa con títulos de crédito a cargo (pagarés, letras de cambio).

Estas deudas son valuadas en moneda extranjera.

Las compañías afiliadas son aquéllas que tienen accionistas comunes o administración común significativos.

Forman parte de las "Deudas" para el cálculo del ajuste anual por inflación.

Son deudas que no se consideran para la determinación del Impuesto al Activo, esto debido a que se derogo el Art. 5 de LIAC. (Se deroga DOF 27 de Diciembre 2006)', 2, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4140, N'Complementaria de cuentas por pagar a intercompañías extranjeras                                                        ', N'Este rubro se debe asignar a las cuentas complementarias que es donde se registra la diferencia entre el importe en moneda extranjera y el importe en la moneda origen considerando normalmente el tipo de cambio histórico cuando utilizamos para registrar las operaciones en moneda extranjera el método de tipo fijo con cuenta complementaria de pasivo.

El método de tipo fijo con cuenta complementaria de pasivo registra las operaciones en cuentas de moneda extranjera a un tipo de cambio establecido y la diferencia con el tipo de cambio real se registra en una cuenta complementaria de pasivo.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Es una  cuenta complementaria de otra que maneja moneda extranjera y por lo cual tiene su cuenta principal. No se considera para el cálculo del ajuste anual por inflación, ni para el cálculo del IMPAC.
', 2, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4150, N'Otras cuentas por pagar (no ajuste x inflación)                                                                         ', N'Este rubro fiscal se debe de asignar a aquellas cuentas por pagar que no intervienen para el calculo del ajuste  anual por inflación, ni para el cálculo del Impuesto al Activo, y que solamente van a formar parte del Estado de posición financiera en el "grupo" de cuentas y documentos por pagar nacionales.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                ', 2, 3, 5, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4220, N'IVA trasladado efectivamente cobrado                                                                                    ', N'Este rubro se  asigna a la cuenta que registra las operaciones de la empresa por las que traslada el IVA efectivamente cobrado, clasificandola en sus diferentes tasas.

No se considera para el cálculo del ajuste anual por inflación, LISR Art. 48, tercer párrafo.

No forma parte de las deudas para el cálculo del IMPAC Art. 5

', 2, 3, 6, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4221, N'IVA trasladado efectivamente cobrado a tasa 16%                                                                         ', N'Son los ingresos por enajenación de bienes y/o por la prestación de servicios realizados en territorio nacional, gravados a la tasa del 15% de IVA.

Son ventas brutas, no incluyen las devoluciones, rebajas y descuentos sobre ingresos (rubros 200, 210, 220, 230, 240, 250).

Estos ingresos se obtienen por el giro propio de la empresa,  no incluyen ingresos por partidas discontinuas y extraordinarias (rubros 300, 310, 320, 340, 390, 400, 410, 420, 500, 510, 520, 530, 540, 550, 560, 570, 580, 590, 600, 610, 620, 630, 640).

Son ingresos obtenidos en territorio nacional,  no incluyen los ingresos por exportaciones (rubros 140), ni los ingresos obtenidos por establecimientos en el extranjero (rubro 150).

Son ingresos con IVA al 15%,  no incluyen ingresos exentos de IVA (rubro 100) ni gravados con otras tasas de IVA (rubros 110, 120).

La tasa general del IVA es el 15%, se aplica a todas las personas físicas y morales que, en territorio nacional, realicen ventas o presten servicios independientes.

Fundamento legal LIVA Art. 1, LIVA Art. 10', 2, 3, 6, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4222, N'IVA trasladado efectivamente cobrado a tasa 11%                                                                         ', N'Son los ingresos por enajenación de bienes y/o por la prestación de servicios realizados en territorio nacional, gravados a la tasa del 15% de IVA.

Son ventas brutas, no incluyen las devoluciones, rebajas y descuentos sobre ingresos (rubros 200, 210, 220, 230, 240, 250).

Estos ingresos se obtienen por el giro propio de la empresa,  no incluyen ingresos por partidas discontinuas y extraordinarias (rubros 300, 310, 320, 340, 390, 400, 410, 420, 500, 510, 520, 530, 540, 550, 560, 570, 580, 590, 600, 610, 620, 630, 640).

Son ingresos obtenidos en territorio nacional,  no incluyen los ingresos por exportaciones (rubros 140), ni los ingresos obtenidos por establecimientos en el extranjero (rubro 150).

Son ingresos con IVA al 15%,  no incluyen ingresos exentos de IVA (rubro 100) ni gravados con otras tasas de IVA (rubros 110, 120).

La tasa general del IVA es el 15%, se aplica a todas las personas físicas y morales que, en territorio nacional, realicen ventas o presten servicios independientes.

Fundamento legal LIVA Art. 1, LIVA Art. 10', 2, 3, 6, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4226, N'IVA Trasladado al  0%                                                                                                   ', N'', 2, 3, 6, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4228, N'IVA Trasladado exento                                                                                                   ', N'', 2, 3, 6, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4230, N'IVA trasladado no cobrado cuenta puente                                                                                 ', N'Este rubro se  asigna a la cuenta que registra las operaciones de la empresa por las que traslada el IVA, clasificandola en sus diferentes tasas.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   No se considera para el cálculo del ajuste anual por inflación, LISR Art. 48, tercer párrafo.

No forma parte de las deudas para el cálculo del IMPAC Art. 5
', 2, 3, 6, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4240, N'Contribuciones por pagar (si ajuste x inflación)                                                                        ', N'Las contribuciones son las aportaciones que hacen los contribuyentes al Estado para  sufragar los gastos publicos, pueden ser tanto en  pagos provisionales como en la declaración anual.

Las contribciones por pagar:
Son aquellas cantidades que están pendientes de pago al fisco, por parte del contibuyente y que es obligación de enterarlas por encontarse en situaciones previstas por las leyes fiscales.

No son deudas para el cálculo del IMPAC Art. 5 pero si se consideran deudas  para el cálculo del ajuste anual por inflación, 




', 2, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4244, N'Contribuciones por pagar (no ajuste por inflación)                                                                      ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 2, 3, 5, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4250, N'Retenciones por enterar (si ajuste x inflación)                                                                         ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 2, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4260, N'Retenciones por enterar (no ajuste x inflación)                                                                         ', N'Este rubro se debe asignar a toda aquellas cuentas que registren retenciones como son  de ISR,  IVA, ISPT. por enterar

No son  considerados para el cálculo de ajuste anual por inflación, por ser partidas no deducibles, LISR Art. 48, tercer párrafo,  32, fracc. I, VIII y IX

No son parte de las deudas del IMPAC  Art. 5.', 2, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4270, N'Impuesto a cargo correspondiente a la última consolidación                                                              ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 2, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4280, N'Impuesto por inversiones en territorios con regimenes fiscales preferentes                                              ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 1, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4290, N'Impuesto sobre ingresos sujetos a regimenes fiscales preferentes                                                        ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 2, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4300, N'Anticipos y rendimientos por distribuir  (no ajuste x inflación)                                                        ', N'Los anticipos y rendimientos distribuidos para el ISR, no son deudas por la adquisición  de bienes o servicios, por la obtención del uso o goce temporal de bienes o por capitales tomados en préstamo, por lo tanto no se considera deuda para el cálculo del ajuste anual por inflación.                                                                                                                                                                                        
Los anticipos o rendimientos distribuido no son deudas del IMPAC, no son contratadas con empresas residentes en el país, son socios a  los cuales le proporcionan sus rendimientos.

', 2, 3, 5, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4310, N'Cuentas por pagar a instituciones de crédito nacionales  (si ajuste x inflación)                                        ', N'Deudas contratadas con el sistema financiero, valuados en moneda nacional.

Forman parte de las "Deudas" para el cálculo del ajuste anual por inflación, LISR Art. 48.

Son deudas que no se consideran para la determinación del Impuesto al Activo, esto debido a que se derogo el Art. 5 de LIAC. (Se deroga DOF 27 de Diciembre 2006).

', 2, 3, 4, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4320, N'Cuentas por pagar a instituciones de crédito extranjeras (si ajuste x inflación)                                        ', N'Deudas contratadas con el sistema financiero extranjero, valuados en moneda extranjera, 

Forman parte de las "Deudas" para el cálculo del ajuste anual por inflación, 

Pero no se incluyen en las deudas para efectos del Impuesto al Activo, por ser deuda cotratadas con empresas residentes en el extranjero.                                                                                                                                                                                                                                                                                                                                                                                                                                                          
Son deudas que no se consideran para la determinación del Impuesto al Activo, esto debido a que se derogo el Art. 5 de LIAC. (Se deroga DOF 27 de Diciembre 2006)', 2, 3, 4, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4330, N'Complementaria de cuentas por pagar a instituciones de crédito extranjeras                                              ', N'Este rubro se debe asignar a las cuentas complementarias que es donde se registra la diferencia entre el importe en moneda extranjera y el importe en la moneda origen considerando normalmente el tipo de cambio histórico cuando utilizamos para registrar las operaciones en moneda extranjera el método de tipo fijo con cuenta complementaria de pasivo.

El método de tipo fijo con cuenta complementaria de pasivo registra las operaciones en cuentas de moneda extranjera a un tipo de cambio establecido y la diferencia con el tipo de cambio real se registra en una cuenta complementaria de pasivo.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Es una  cuenta complementaria de otra que maneja moneda extranjera y por lo cual tiene su cuenta principal. No se considera para el cálculo del ajuste anual por inflación, ni para el cálculo del IMPAC.
', 2, 3, 4, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4340, N'Reservas y provisiones de pasivo (si ajuste x inflación)                                                                ', N'Son estimaciones respecto a las erogaciones que se realizaran en el ejercicio  por ejemplo las gratificaciones a los trabajadores correspondientes al ejercicio, siempre y cuando sean deducibles de la base gravable del ISR, o  Las aportaciones efectuadas para la creación o incremento de reservas para fondos de pensiones o jubilaciones del personal, complementarias a las que establece la Ley del Seguro Social, y de primas de antigüedad constituidas en los términos de esta Ley. Que son las  mencionadas en  el Art. 29  frac. VII de la LISR.

Se consideran deudas para efectos del ajuste por inflación de acuerdo al Art. 48 segundo párrafo de la LISR.

Pero no participan en el cálculo del IMPAC,  no son deudas contratadas con empresas residentes en el país, son provisiones para pagos a los trabajadores LIAC Art. 5.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   NOTA:
Las cuentas asignadas a este rubro se van al modulo de reservas, los cargos ajustados de este modulo pasan a la conciliación contable fiscal en el rubro de deducciones fiscales no contables;  y lo abonos ajustados se ubican en la conciliación contable fiscal como deducciones contables no fiscales. Debe cuidarse que en la parametrización de las cuentas de gastos el rubro asignado corresponda a un gasto deducible con el fin de no duplicar el efecto en la conciliación contable  fiscal  y en el estado de  resultados fiscal.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ', 2, 3, 5, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4350, N'Reservas y provisiones de pasivo (no ajuste x inflación)                                                                ', N'Son estimaciones respecto a las erogaciones que se realizaran en periodos futuros, su creación o incremento no se considera deducible de la base gravable de ISR. Art. 32, F-VIII.

No son considerados deudas de acuerdo a la LISR  Art. 32, fracc. IX.

Tampoco participa en el cálculo del IMPAC,  no son deudas contratadas con empresas residentes en el país, son provisiones para pagos a los trabajadores LIAC Art. 5.

Por el contrario, son deducibles las aplicaciones a las reservas originadas porque se cumplieron los requisitos que para su deducibilidad establece la LISR.  Art. 29 de RLISR.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   NOTA:
Las cuentas asignadas a este rubro se van al modulo de reservas, los cargos ajustados de este modulo pasan a la conciliación contable fiscal en el rubro de deducciones fiscales no contables;  y lo abonos ajustados se ubican en la conciliación contable fiscal como deducciones contables no fiscales. Debe cuidarse que en la parametrización de las cuentas de gastos el rubro asignado corresponda a un gasto deducible con el fin de no duplicar el efecto en la conciliación contable  fiscal  y en el estado de  resultados fiscal.
', 2, 3, 5, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4360, N'Otros pasivos  (si ajuste x inflación)                                                                                  ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 2, 3, 5, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4370, N'Otros pasivos  (no ajuste x inflación)                                                                                  ', N'Se asigna a las cuentas  que no se encuentran comprendidas en un rubro especifico y  que pertenecen  al pasivo.  En este rubro  las deudas que deben considerar son las contratadas con empresas residentes en el extranjero y estas no formarían parte del cálculo del IMPAC         

Formaria parte del ajuste anual por inflación LISR Art. 48                                
                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', 2, 3, 5, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4380, N'Aportaciones para futuros aumentos de capital (si ajuste x inflación)                                                   ', N'Son los ingresos por enajenación de bienes y/o por la prestación de servicios realizados en territorio nacional, gravados a la tasa del 15% de IVA.

Son ventas brutas, no incluyen las devoluciones, rebajas y descuentos sobre ingresos (rubros 200, 210, 220, 230, 240, 250).

Estos ingresos se obtienen por el giro propio de la empresa,  no incluyen ingresos por partidas discontinuas y extraordinarias (rubros 300, 310, 320, 340, 390, 400, 410, 420, 500, 510, 520, 530, 540, 550, 560, 570, 580, 590, 600, 610, 620, 630, 640).

Son ingresos obtenidos en territorio nacional,  no incluyen los ingresos por exportaciones (rubros 140), ni los ingresos obtenidos por establecimientos en el extranjero (rubro 150).

Son ingresos con IVA al 15%,  no incluyen ingresos exentos de IVA (rubro 100) ni gravados con otras tasas de IVA (rubros 110, 120).

La tasa general del IVA es el 15%, se aplica a todas las personas físicas y morales que, en territorio nacional, realicen ventas o presten servicios independientes.

Fundamento legal LIVA Art. 1, LIVA Art. 10', 2, 3, 5, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4400, N'Otros pasivos moneda extranjera (si ajuste x inflación)                                                                 ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Se refiere a deudas con acreedores diversos en moneda extranjera', 2, 3, 5, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4410, N'Complementaria otros pasivos en moneda extranjera                                                                       ', N'Este rubro se debe asignar a las cuentas complementarias que es donde se registra la diferencia entre el importe en moneda extranjera y el importe en la moneda origen considerando normalmente el tipo de cambio histórico cuando utilizamos para registrar las operaciones en moneda extranjera el método de tipo fijo con cuenta complementaria de pasivo.

El método de tipo fijo con cuenta complementaria de pasivo registra las operaciones en cuentas de moneda extranjera a un tipo de cambio establecido y la diferencia con el tipo de cambio real se registra en una cuenta complementaria de pasivo.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Es una  cuenta complementaria de otra que maneja moneda extranjera y por lo cual tiene su cuenta principal. No se considera para el cálculo del ajuste anual por inflación, ni para el cálculo del IMPAC.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 2, 3, 5, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4430, N'Pasivos no deducibles (no ajuste x inflación)                                                                           ', N'Cuentas por pagar a personas físicas y morales régimen simplificado o donatarias, las personas físicas pueden ser por la adquisición de servicios, por la obtención  del uso o goce temporal  de bienes, este rubro  SI es considerado para el cálculo del ajuste anual por inflación.

Pero no es considerado deuda para el cálculo del IMPAC Art. 5, por ser cuentas por pagar a personas fisicas. 

NOTA:
Las cuentas asignadas a este rubro se van al módulo de Pasivos No Deducibles, los saldos Iniciales Ajustados pasan a la conciliación contable fiscal como  Deducciones Fiscales no Contables; y los saldos Finales Ajustados se ubican en la conciliación contable fiscal como Deducciones Contables no Fiscales.  Debe cuidarse que en la parametrización de las cuentas de gastos,  el rubro asignado debe corresponder a un gasto deducible con el fin de no duplicar el efecto en la conciliación Contable Fiscal y en el Estado de Resultados Fiscal.

Fundamento
Art. 31 Fr. IX Pagos que sean ingresos de personas físicas y donativos

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      ', 2, 3, 5, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4460, N'Intereses devengados a cargo no pagados (si ajuste x inflación)                                                         ', N'Este Rubro Fiscal  debe asignarse a aquellas cuentas en donde se registren los intereses devengados a cargo NO pagados, estas cuentas deben ser cuentas de pasivo. 

Este rubro  es considerado "Deuda" para el cálculo del ajuste anual por inflación.

Son deudas que no se consideran para la determinación del Impuesto al Activo, esto debido a que se derogo el Art. 5 de LIAC. (Se deroga DOF 27 de Diciembre 2006).', 2, 3, 5, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (4470, N'Efectos de actualizacion cuentas de pasivos                                                                             ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 2, 3, 5, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (5000, N'Capital social proveniente de aportaciones                                                                              ', N'En el caso de personas morales es el importe total de las aportaciones que hacen los socios a la empresa o en el caso de personas físicas es su patrimonio.

No participa en el cálculo del ajuste anual por inflación, ni por el impuesto al activo', 3, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (5010, N'Capital social proveniente de capitalización                                                                            ', N'Aportaciones al capital vía capitalización de utilidades.

No participa en el cálculo del ajuste anual por inflación, ni por el impuesto al activo', 3, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (5020, N'Reservas de capital                                                                                                     ', N'Las reservas de capital se crean para evitar que alguna porción de las utilidades se repartan entre los socios logrando así no restarle recursos a la empresa en un momento determinado y fortalecer el Capital Social como una garantía para los acreedores; tales como la reserva legal (la reserva legal es la separación del 5% de las utilidades netas de toda sociedad, dicha separación de las utilidades deja de ser obligatoria cuando haya alcanzado el 20% del capital social y debe ser reconstituida, de la misma manera cuando disminuya por cualquier motivo).

No es deuda y es una cuenta de capital,  por lo tanto no se considera  para el cálculo del ajuste anual por inflación ni para el cálculo del impuesto al activo.', 3, 3, 5, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (5030, N'Otras cuentas de capital                                                                                                ', N'Demás cuentas del capital que quedaron sin rubro fiscal asignado.
Este rubro fiscal se asigna a aquellas cuentas que no fuerón consideradas o asignadas por ninguno de los rubros arriba disponibles.

Es cuenta de capital y no deuda para el ajuste anual por inflación ni para el impuesto al activo.', 3, 3, 5, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (5040, N'Aportaciones para futuros aumentos de capital (si ajuste x inflación)                                                   ', N'Son los anticipos de los socios para futuros aumentos el capital social de la empresa. Para que estos anticipos sean considerados como futuros aumentos de capital debe acordarse así en asamblea de socios.

Se considera deuda para el ajuste anual por inflación, pero no para el impuesto al activo por ser los socios los que lo aportan.', 3, 3, 3, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (5050, N'Reducciones de capital                                                                                                  ', N'', 3, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (5060, N'Aportaciones de capital                                                                                                 ', N'', 3, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (5070, N'Primas netas por suscripción de acciones                                                                                ', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Es cuenta de capital y no deuda para el ajuste anual por inflación ni para el impuesto al activo.', 3, 3, 5, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (5080, N'Utilidades acumuladas de ejercicios anteriores                                                                          ', N'Son las utilidades obtenidas en ejercicio anteriores.
No incluye las pérdidas acumuladas de ejercicios anteriores.

Es cuenta de capital y no deuda para el ajuste anual por inflación ni para el impuesto al activo.', 3, 3, 4, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (5090, N'Pérdidas acumuladas de ejercicios anteriores                                                                            ', N'Pérdidas que se determinaron en ejercicios anteriores y que se van sumando año con año.
Son distintas de las Utilidades acumuladas de ejercicios anteriores.', 3, 3, 4, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (5100, N'Resultado del ejercicio                                                                                                 ', N'', 3, 3, 5, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (5110, N'Exceso en la actualización del capital                                                                                  ', N'Son los ingresos por enajenación de bienes y/o por la prestación de servicios realizados en territorio nacional, gravados a la tasa del 15% de IVA.

Son ventas brutas, no incluyen las devoluciones, rebajas y descuentos sobre ingresos (rubros 200, 210, 220, 230, 240, 250).

Estos ingresos se obtienen por el giro propio de la empresa,  no incluyen ingresos por partidas discontinuas y extraordinarias (rubros 300, 310, 320, 340, 390, 400, 410, 420, 500, 510, 520, 530, 540, 550, 560, 570, 580, 590, 600, 610, 620, 630, 640).

Son ingresos obtenidos en territorio nacional,  no incluyen los ingresos por exportaciones (rubros 140), ni los ingresos obtenidos por establecimientos en el extranjero (rubro 150).

Son ingresos con IVA al 15%,  no incluyen ingresos exentos de IVA (rubro 100) ni gravados con otras tasas de IVA (rubros 110, 120).

La tasa general del IVA es el 15%, se aplica a todas las personas físicas y morales que, en territorio nacional, realicen ventas o presten servicios independientes.

Fundamento legal LIVA Art. 1, LIVA Art. 10', 3, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (5120, N'Insuficiencia en la actualización del capital                                                                           ', N'Son los ingresos por enajenación de bienes y/o por la prestación de servicios realizados en territorio nacional, gravados a la tasa del 15% de IVA.

Son ventas brutas, no incluyen las devoluciones, rebajas y descuentos sobre ingresos (rubros 200, 210, 220, 230, 240, 250).

Estos ingresos se obtienen por el giro propio de la empresa,  no incluyen ingresos por partidas discontinuas y extraordinarias (rubros 300, 310, 320, 340, 390, 400, 410, 420, 500, 510, 520, 530, 540, 550, 560, 570, 580, 590, 600, 610, 620, 630, 640).

Son ingresos obtenidos en territorio nacional,  no incluyen los ingresos por exportaciones (rubros 140), ni los ingresos obtenidos por establecimientos en el extranjero (rubro 150).

Son ingresos con IVA al 15%,  no incluyen ingresos exentos de IVA (rubro 100) ni gravados con otras tasas de IVA (rubros 110, 120).

La tasa general del IVA es el 15%, se aplica a todas las personas físicas y morales que, en territorio nacional, realicen ventas o presten servicios independientes.

Fundamento legal LIVA Art. 1, LIVA Art. 10', 3, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (5200, N'Actualización del capital contable                                                                                      ', N'Es la cantidad necesaria para mantener la inversión de los accionistas en términos del poder adquisitivo de la moneda, equivalente al de las fechas en que se hicieron las aportaciones y en que las utilidades les fueron retenidas.

Se actualiza el capital contable cuando la empresa aplique los principios de contabilidad referentes a la reexpresión de estados financieros.

Es cuenta de capital y no deuda, no participa en el ajuste anual por inflación ni para el impuesto al activo.', 3, 3, 2, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (6030, N'Otros ingresos  fiscales no contables, (para asignar a cuentas de orden)                                                ', N'Ingresos por partidas discontinuas y extraordinarias exclusivamente fiscales, que no se consideran como ingresos contables, diferentes de otros ingresos fiscales no contables que Exentus calcula.

No confundir con los otros ingresos contables y fiscales (rubro 190,192, 194,196) ni con los otros ingresos no acumulables  (rubro 188).

Este rubro debe ser asignado a cuentas de orden, donde se tiene reflejado unicamente ingresos fiscales, que no se encuentran contemplados en cuentas reales de la contabilidad.

Es otro tipo de ingresos fiscales en los cuales se registran en las cuentas de orden, no son créditos para el ISR, IMPAC', 10, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (6050, N'Otras deducciones fiscales no contables,  (para asignar a cuentas de orden)                                             ', N'Son otros gastos exclusivamente fiscales y que no participan para gastos contables.
Este rubro debe ser asignado a cuentas de orden, donde se tiene registrado deducciones unicamente fiscales, que no se tiene contemplado en cuentas reales de la contabilidad.', 10, 3, 1, 1)
INSERT [dbo].[RubrosFiscales] ([Rubro], [Nombre], [Descripcion], [IdElementoBasico], [Regis], [Clasificacion], [Estatus]) VALUES (6100, N'Sin efectos contables ni fiscales, (para asignar a cuentas de orden)                                                    ', N'Este rubro se asigna a las cuentas de orden de la contabilidad, distintas a las que son asignadas por los rubros Otros ingresos fiscales no contables (990) y Otras deducciones  fiscales NO contables (992)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
No participan en el cálculo del ISR, e IMPAC', 10, 3, 1, 1)
/****** Object:  Table [dbo].[ElementoBasico]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ElementoBasico]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ElementoBasico](
	[IdElementoBasico] [int] IDENTITY(1,1) NOT NULL,
	[Clave] [nvarchar](2) NOT NULL,
	[Descripcion] [nvarchar](100) NULL,
	[Estatus] [bit] NULL,
 CONSTRAINT [PK_ElementoBasico] PRIMARY KEY CLUSTERED 
(
	[IdElementoBasico] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_ElementoBasico] UNIQUE NONCLUSTERED 
(
	[Clave] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[ElementoBasico] ON
INSERT [dbo].[ElementoBasico] ([IdElementoBasico], [Clave], [Descripcion], [Estatus]) VALUES (1, N'A', N'Activos                  ', 1)
INSERT [dbo].[ElementoBasico] ([IdElementoBasico], [Clave], [Descripcion], [Estatus]) VALUES (2, N'P', N'Pasivos                  ', 1)
INSERT [dbo].[ElementoBasico] ([IdElementoBasico], [Clave], [Descripcion], [Estatus]) VALUES (3, N'C', N'Capital                  ', 1)
INSERT [dbo].[ElementoBasico] ([IdElementoBasico], [Clave], [Descripcion], [Estatus]) VALUES (4, N'V', N'Ingresos                 ', 1)
INSERT [dbo].[ElementoBasico] ([IdElementoBasico], [Clave], [Descripcion], [Estatus]) VALUES (5, N'T', N'Costo de Ventas          ', 1)
INSERT [dbo].[ElementoBasico] ([IdElementoBasico], [Clave], [Descripcion], [Estatus]) VALUES (6, N'G', N'Gastos de Operación      ', 1)
INSERT [dbo].[ElementoBasico] ([IdElementoBasico], [Clave], [Descripcion], [Estatus]) VALUES (7, N'H', N'Otros Productos          ', 1)
INSERT [dbo].[ElementoBasico] ([IdElementoBasico], [Clave], [Descripcion], [Estatus]) VALUES (8, N'F', N'Otros Gastos             ', 1)
INSERT [dbo].[ElementoBasico] ([IdElementoBasico], [Clave], [Descripcion], [Estatus]) VALUES (9, N'I', N'Impuestos                ', 1)
INSERT [dbo].[ElementoBasico] ([IdElementoBasico], [Clave], [Descripcion], [Estatus]) VALUES (10, N'O', N'Cuentas de Orden         ', 1)
SET IDENTITY_INSERT [dbo].[ElementoBasico] OFF
/****** Object:  Table [dbo].[BasesDeCalculo]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BasesDeCalculo]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BasesDeCalculo](
	[idBaseDeCalculo] [int] IDENTITY(1,1) NOT NULL,
	[Reporte] [int] NOT NULL,
	[ClaveBC] [int] NOT NULL,
	[Nombre] [nvarchar](200) NULL,
	[Descripcion] [nvarchar](max) NULL,
	[Naturaleza] [nvarchar](4) NULL,
	[Orden] [int] NULL,
 CONSTRAINT [PK_BasesDeCalculo] PRIMARY KEY CLUSTERED 
(
	[idBaseDeCalculo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_BasesDeCalculo] UNIQUE NONCLUSTERED 
(
	[Reporte] ASC,
	[ClaveBC] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'BasesDeCalculo', N'COLUMN',N'idBaseDeCalculo'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'identificador unico de la tabla' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BasesDeCalculo', @level2type=N'COLUMN',@level2name=N'idBaseDeCalculo'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'BasesDeCalculo', N'COLUMN',N'ClaveBC'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'clave de la base de calculo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BasesDeCalculo', @level2type=N'COLUMN',@level2name=N'ClaveBC'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'BasesDeCalculo', N'COLUMN',N'Nombre'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'nombre de la base de calculo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BasesDeCalculo', @level2type=N'COLUMN',@level2name=N'Nombre'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'BasesDeCalculo', N'COLUMN',N'Descripcion'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Descripcion detallada sobre la base de calculo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BasesDeCalculo', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
SET IDENTITY_INSERT [dbo].[BasesDeCalculo] ON
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (1, 30, 1, N'Ingresos totales                                                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (2, 30, 2, N'Ventas y/o servicios nacionales (partes no relacionadas)              ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (3, 30, 3, N'Ventas y/o servicios extranjeros (partes no relacionadas)             ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (4, 30, 4, N'Dev., descuentos y bonificaciones sobre ventas nacionales (partes no r', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (5, 30, 5, N'Ingresos netos                                                        ', N'
', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (6, 30, 6, N'Inventario inicial                                                    ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (7, 30, 7, N'Compras netas                                                         ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (8, 30, 8, N'Compras nacionales                                                    ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (9, 30, 9, N'Compras extranjeras                                                   ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (10, 30, 10, N'Inventario final                                                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (11, 30, 11, N'Costo de mercancías                                                   ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (12, 30, 12, N'Mano de obra                                                          ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (13, 30, 13, N'Gastos indirectos                                                     ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (14, 30, 14, N'Costo de ventas y/o servicios                                         ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (15, 30, 15, N'Utilidad (o perdida) bruta                                            ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (16, 30, 16, N'Gastos de operación (partes no relacionadas)                          ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (17, 30, 17, N'Utilidad (o pérdida de operación)                                     ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (18, 30, 18, N'Intereses devengados a favor nacionales (partes no relacionadas)      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (19, 30, 19, N'Intereses devengados a cargo nacionales (partes no relacionadas)      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (20, 30, 22, N'Otras operaciones financieras nacionales (partes no relacionadas)     ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (21, 30, 23, N'Costo integral de financiamiento                                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (22, 30, 24, N'Ingresos por partidas discontinuas y extraordinarias                  ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (23, 30, 25, N'Gastos por partidas discontinuas  Y extraordinarias                   ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (24, 30, 26, N'Utilidad (o perdida) por partidas  discontinuas y extraordinarias     ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (25, 30, 27, N'Utilidad (o perdida) antes de Impuestos                               ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (26, 30, 28, N'ISR                                                                   ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (27, 30, 31, N'Utilidad (o perdida) neta                                             ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (28, 30, 32, N'Maquilas                                                              ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (29, 30, 33, N'Resultado por posición monetaria favorable (partes no relacionadas)   ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (30, 40, 1, N'Utilidad (o pérdida) neta                                             ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (31, 40, 2, N'Efectos de reexpresión                                                ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (32, 40, 4, N'Utilidad (o pérdida) neta histórica                                   ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (33, 40, 5, N'Ingresos fiscales no contables (en caso de haber pérdida se restarán) ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (34, 40, 6, N'Ajuste por inflación acumulable                                       ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (35, 40, 9, N'Ganancia en la enajenación de acciones o por reembolso de capital     ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (36, 40, 10, N'Ganancia en la enajenacion de terrenos y activo fijo                  ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (37, 40, 13, N'Otros ingresos fiscales no contables                                  ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (38, 40, 15, N'Costo de ventas contable                                              ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (39, 40, 14, N'Deducciones contables no fiscales (si hubiera Pérdida se restará)     ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (40, 40, 16, N'Depreciación y amortización contable                                  ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (41, 40, 17, N'Gastos  que no reunen requisitos fiscales                             ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (42, 40, 18, N'Gastos no deducibles (Art. 32 fr. VIII y IX LISR)                     ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (43, 40, 19, N'Provisiones de ISR,  IETU y  PTU                                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (44, 40, 20, N'Pérdida contable en enajenación de acciones                           ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (45, 40, 21, N'Pérdida contable en venta de terrenos y activo fijo                   ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (46, 40, 22, N'Pérdida en participacion subsidiarias (a cargo)                       ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (47, 40, 28, N'Otros gastos contables no fiscales                                    ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (48, 40, 29, N'Deducciones fiscales no contables (si hubiera pérdida se sumará)      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (49, 40, 30, N'Ajuste anual  por inflación deducible                                 ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (50, 40, 31, N'Costo de lo vendido fiscal                                            ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (51, 40, 32, N'Deducción  de inversiones                                             ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (52, 40, 35, N'Pérdida fiscal en venta de acciones                                   ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (53, 40, 36, N'Pérdida fiscal en  enajenacion de  terrenos y activo fijo             ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (54, 40, 42, N'Otras deducciones fiscales no contables                               ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (55, 40, 43, N'Ingresos contables no fiscales (si hubiera pérdida se sumará)         ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (56, 40, 46, N'Saldos a favor de impuestos y su actualización                        ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (57, 40, 47, N'Utilidad contable en venta de activos                                 ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (58, 40, 48, N'Utilidad contable en venta de acciones                                ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (59, 40, 49, N'Utilidad en  participación  en subsidiarias (a favor)                 ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (60, 40, 50, N'Otros ingresos contables no fiscales                                  ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (61, 40, 51, N'Utilidad o pérdida fiscal                                             ', N'En caso de obtener utilidad, se suma los conceptos Utilidad (o perdida) neta histórica, Ingresos fiscales no contables  (en caso de haber obtenido Pérdidase restaran) y Deducciones contables no fiscales (en caso de haber obtenido Pérdida se restaran), menos el Deducciones fiscales no contables (en caso de haber obtenido Pérdida se sumaran) y el Ingresos contables no fiscales (en caso de haber obtenido Pérdida se sumaran). En caso de obtener pérdida, el concepto Utilidad (o perdida) neta histórica se disminuye con los renglones Ingresos fiscales no contables  (en caso de haber obtenido Pérdida se restaran) y Deducciones contables no fiscales (en caso de haber obtenido Pérdidase restaran), más el Deducciones fiscales no contables (en caso de haber obtenido Pérdida se sumaran) y el Ingresos contables no fiscales (en caso de haber obtenido Pérdida se sumaran). 
', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (62, 40, 52, N'Ingresos no acumulables                                               ', N'Son ingresos contables que no entran para la base del impuesto', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (63, 55, 1, N'Inventarios                                                           ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (64, 55, 2, N'Mercancias en Transito                                                ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (65, 55, 3, N'Reservas de Inventarios                                               ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (66, 55, 4, N'Compras reales                                                        ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (67, 55, 5, N'Mano de Obra y Gastos Indirectos de Fabricación                       ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (68, 60, 1, N'Ingresos totales contables                                            ', N'Son todos los ingresos acumulables que tienen los contribuyentes, excepto el ajuste anual por inflación acumulable.           ', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (69, 60, 2, N'Ingresos no afectos a calculo                                         ', N'Son los que contienen los rubros fiscales que determinan los ingresos provenientes de establecimiento del extranjero

No se considerarán los ingresos de fuente de riqueza ubicada en el extranjero que hayan sido objeto de retención por concepto de impuesto sobre la renta ni los ingresos atribuibles a sus establecimientos ubicados en el extranjero que esten sujetos al pago del impuesto sobre la renta en el país donde se encuentren ubicados estos establecimientos. 
           ', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (70, 60, 3, N'Anticipos y rendimientos distribuidos                                 ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (71, 60, 4, N'Retenciones a Favor                                                   ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (72, 60, 5, N'Retenciones a Cargo                                                   ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (73, 65, 1, N'Créditos                                                              ', N'Para efectos del cálculo del Ajuste anual por inflación, se considerará crédito, el derecho que tiene una persona acreedora a recibir de otra deudora una cantidad en numerario, entre otros: los derechos de crédito que adquieran las empresas de factoraje financiero, las inversiones en acciones de sociedades de inversión en instrumentos de deuda y las operaciones financieras derivadas señaladas en la fracción IX del Art. 22 LISR.           ', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (74, 65, 2, N'Deudas                                                                ', N'Para efectos del cálculo del Ajuste anual por inflación, se considerará deuda, cualquier obligación en numerario pendiente de cumplimiento, entre otras: las derivadas de contratos de arrendamiento financiero, de operaciones financieras derivadas a que se refiere la fracción IX del Art. 22 LISR, las aportaciones para futuros aumentos de capital y las contribuciones causadas desde el último día del periodo al que correspondan y hasta el día en el que deban pagarse.            ', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (75, 70, 1, N'Créditos con el sistema financiero                                    ', N'Promedio mensual de activos financieros 
El promedio mensual de los activos será el que resulte de dividir entre dos la suma del activo al inicio y al final del mes, excepto los correspondientes a operaciones contratadas con el sistema financiero o con su intermediación, el que se calculará en los mismos términos de la Ley del Impuesto sobre la Renta. 

Para los efectos del artículo anterior, se considerará crédito, el derecho que tiene una persona acreedora a recibir de otra deudora una cantidad en numerario, entre otros: los derechos de crédito que adquieran las empresas de factoraje financiero, las inversiones en acciones de sociedades de inversión en instrumentos de deuda y las operaciones financieras derivadas señaladas en la fracción IX del Art. 22 LISR 
           ', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (76, 70, 2, N'Otros activos financieros                                             ', N'           Se consideran Demás activos financieros, entre otros, los siguientes: 
·	Las inversiones en Títulos de crédito, a excepción de las acciones emitidas por personas morales residentes en México. Las acciones emitidas por sociedades de inversión de renta fija se considerarán activos financieros. 
·	Las cuentas y documentos por cobrar. No se consideran cuentas por cobrar las que sean a cargo de socios o accionistas residentes en el extranjero, ya sean personas físicas o sociedades. 
·	No son cuentas por cobrar los pagos provisionales, los saldos a favor de contribuciones, ni los estímulos fiscales por aplicar. 
·	Los intereses devengados a favor, no cobrados. 
·	Valuación de activos financieros en moneda extranjera 
Los activos financieros denominados en moneda extranjera, se valuarán al tipo de cambio del primer día de cada mes. Para este efecto, cuando no sea aplicable el tipo controlado de cambio, se estará al tipo de cambio promedio para enajenación con el cual inicien operaciones en el mercado las instituciones de crédito de la ciudad de México. 
', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (77, 70, 3, N'Inventarios                                                           ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (78, 70, 4, N'Deudas                                                                ', N'           ', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (79, 70, 5, N'Otros activos financieros (Saldos contrarios No IMPAC)                ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (80, 70, 6, N'Deudas (Saldos contrarios SI IMPAC)                                   ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (81, 80, 1, N'ISR retenido por salarios                                             ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (82, 80, 2, N'ISR retenido por pagos al extranjero                                  ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (83, 80, 3, N'Otras retenciones                                                     ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (84, 80, 4, N'Retenciones de IVA                                                    ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (85, 80, 5, N'Crédito al Salario                                                    ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (86, 90, 1, N'Pasivos no deducibles                                                 ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (87, 100, 1, N'Estimación para cuentas incobrables                                   ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (88, 100, 2, N'Pagos anticipados                                                     ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (89, 100, 3, N'Reservas de pasivo                                                    ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (90, 110, 1, N'Anticipos a Clientes nacionales                                       ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (91, 110, 2, N'Anticipos a Clientes extranjeros                                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (92, 120, 1, N'Almacén de materia prima                                              ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (93, 120, 2, N'Inventario inicial de materia prima                                   ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (94, 120, 3, N'Mercancías en tránsito de materia prrima                              ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (95, 120, 4, N'Anticipo a proveedores de materia prima                               ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (96, 120, 5, N'Almacén de producción en proceso                                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (97, 120, 6, N'Inventario inicial de producción en proceso                           ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (98, 130, 1, N'Aportaciones de capital                                               ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (99, 130, 2, N'Reducciones de capital                                                ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (100, 130, 3, N'Primas netas por suscripción de acciones                              ', N'', N'', 0)
GO
print 'Processed 100 total records'
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (101, 140, 1, N'Dividendo Percibidos                                                  ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (102, 140, 2, N'Dividendo pagados                                                     ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (103, 140, 3, N'Utilidades distribuidas por reducción de capital                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (104, 150, 1, N'IVA TRASLADADO AL 15%                                                 ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (105, 150, 2, N'IVA TRASLADADO AL 10%                                                 ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (106, 150, 3, N'IVA ACREDITABLE AL 15%                                                ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (107, 150, 4, N'IVA ACREDITABLE AL 10%                                                ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (108, 65, 3, N'Intereses a Favor Devengados                                          ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (109, 65, 4, N'Intereses a Cargo Devengados                                          ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (110, 160, 1, N'Inventario inicial de materias primas                                 ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (111, 160, 2, N'Compras netas de materias primas deducibles                           ', N'Ajustes cicliclos de inventario en gran producción                    ', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (112, 160, 3, N'Inventario final de materias primas                                   ', N'Desperdicio en gran producción                                        ', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (113, 160, 4, N'Inventario inicial de producción en proceso                           ', N'Consumo de inventarios en gastos de producción                        ', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (114, 160, 5, N'Mano de obra                                                          ', N'Costo de herramentales incluido en el costo directo                   ', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (115, 160, 6, N'Gastos indirectos de fabricacion deducible                            ', N'Compras que no pasan por inventarios                                  ', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (116, 160, 7, N'Deducción de inversiones                                              ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (117, 160, 8, N'Maquilas                                                              ', N'Traspaso de inventarios a herramentales                               ', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (118, 160, 9, N'Compras netas de producción en proceso deducibles                     ', N'Traspaso de inventarios a garantias                                   ', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (119, 160, 10, N'Inventario final de producción en proceso                             ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (120, 160, 11, N'Inventario inicial de productos terminados                            ', N'Reserva de inventarios obsoletos                                      ', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (121, 40, 33, N'Estimulo fiscal por deducción inmediata de inversiones                ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (122, 40, 55, N'Deducción adicional a la inmediata                                    ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (123, 40, 24, N'Amortización de pagos anticipados                                     ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (124, 40, 25, N'Incremento a estimación para cuentas incobrables                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (125, 40, 37, N'Aplicación a reservas de pasivos                                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (126, 40, 38, N'Incremento a pagos anticipados                                        ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (127, 40, 39, N'Aplicación a estimación para cuentas incobrables                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (128, 40, 45, N'Anticipos de clientes del ejercicio (disminución)                     ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (129, 40, 26, N'Deducciones no pagadas al cierre de este ejercicio                    ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (130, 40, 40, N'Deducciones no pagadas al cierre del ejercicio anterior               ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (131, 40, 27, N'Intereses  devengados que exceden del valor de mercado y moratorios   ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (132, 40, 34, N'Estimulo fiscal de las personas con discapacidad                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (133, 40, 41, N'Intereses moratorios efectivamente pagados                            ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (134, 40, 44, N'Intereses moratorios devengados a favor cobrados o no                 ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (135, 30, 34, N'Dev., descuentos y bonificaciones sobre ventas al extranjero (partes n', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (136, 40, 7, N'Anticipos de clientes del ejercicio (aumento)                         ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (137, 40, 8, N'Intereses moratorios efectivamente cobrados                           ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (138, 40, 23, N'Incremento a reservas de pasivos                                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (139, 40, 3, N'Resultado por posicion monetaria                                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (140, 40, 11, N'Inventario acumulable                                                 ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (141, 40, 12, N'Inventario de mercancía Importadas  directamente                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (142, 65, 5, N'Determinación de las contribuciones a favor para ajuste por inflación ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (143, 65, 6, N'Determinación de las contribuciones a cargo  para ajuste por inflación', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (144, 60, 6, N'Ingresos por fluctuacion cambiaria  e intereses (no realizada)        ', N'Esta Base de calculo fue agregado el 29-09-2008 por cuestiones de consideraciones especiales en los calculos de los pagos provisionales de cada empresa
', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (145, 60, 7, N'IPérdida por fluctuacion cambiaria e intereses  (no realizada)        ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (146, 80, 6, N'IDE Retenido                                                          ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (147, 120, 12, N'Mercancías en tránsito de producción en proceso                       ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (148, 120, 13, N'Anticipo a proveedores de producción en proceso                       ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (149, 120, 14, N'Almacén de productos terminados                                       ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (150, 120, 15, N'Inventario inicial de productos terminados                            ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (151, 120, 16, N'Mercancías en tránsito de productos terminados                        ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (152, 120, 17, N'Anticipo a proveedores de productos terminados                        ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (153, 161, 1, N'Inventario inicial de materias primas                                 ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (154, 161, 2, N'Compras netas  nacionales de materias primas                          ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (155, 161, 3, N'Compras netas de importación de materias primas                       ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (156, 161, 4, N'Inventario final de materias primas                                   ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (157, 161, 5, N'inventario inicial de producción en  proceso                          ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (158, 161, 6, N'Mano de obra                                                          ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (159, 161, 7, N'Gastos indirectos de fabricación deducible                            ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (160, 161, 8, N'Gastos indirectos de fabricación  no deducible                        ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (161, 161, 9, N'Maquilas                                                              ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (162, 161, 10, N'Compras netas  nacionales de producción en proceso                    ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (163, 161, 11, N'Compras netas  de importacion de producción en proceso                ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (164, 161, 12, N'Inventario final de producción en proceso                             ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (165, 161, 13, N'Inventario inicial de productos terminados                            ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (166, 161, 14, N'Compras netas nacionales de productos terminados                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (167, 161, 15, N'Compras netas importación de productos terminados                     ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (168, 161, 16, N'Inventario final de productos terminados                              ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (169, 161, 17, N'Otros                                                                 ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (170, 160, 12, N'Compras netas de productos terminados deducibles                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (171, 160, 13, N'Inventario final de productos terminados                              ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (172, 160, 14, N'Otros                                                                 ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (173, 60, 9, N'Cálculo de factoraje financiero                                       ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (174, 162, 1, N'Inventario inicial de materias primas                                 ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (175, 162, 2, N'Compras netas  nacionales de materias primas                          ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (176, 162, 3, N'Compras netas de importación de materias primas                       ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (177, 162, 4, N'Inventario final de materias primas                                   ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (178, 162, 5, N'Inventario inicial de producción en  proceso                          ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (179, 162, 6, N'Mano de obra                                                          ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (180, 162, 7, N'Gastos indirectos de fabricación deducible                            ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (181, 162, 8, N'Gastos indirectos de fabricación  no deducible                        ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (182, 162, 9, N'Maquilas                                                              ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (183, 162, 10, N'Compras netas  nacionales de producción en proceso                    ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (184, 162, 11, N'Compras netas de importación de producción en proceso                 ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (185, 162, 12, N'Inventario final de produccion en proceso                             ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (186, 162, 13, N'Inventario inicial de productos terminados                            ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (187, 162, 14, N'Compras netas nacionales de productos terminados                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (188, 162, 15, N'Compras netas  de importación de productos terminados                 ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (189, 162, 16, N'Inventario final de productos terminados                              ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (190, 162, 17, N'Otros                                                                 ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (191, 163, 1, N'Inventario inicial de materias primas                                 ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (192, 163, 2, N'Compras netas de materias primas deducibles                           ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (193, 163, 3, N'Inventario final de materias primas                                   ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (194, 163, 4, N'Inventario inicial de producción en proceso                           ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (195, 163, 5, N'Mano de obra                                                          ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (196, 163, 6, N'Gastos indirectos de fabricación deducible                            ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (197, 163, 7, N'Deducción de inversiones                                              ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (198, 163, 8, N'Maquilas                                                              ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (199, 163, 9, N'Compras netas de producción en proceso deducibles                     ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (200, 163, 10, N'Inventario final de producción en proceso                             ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (201, 163, 11, N'Inventario inicial de productos terminados                            ', N'', N'', 0)
GO
print 'Processed 200 total records'
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (202, 163, 12, N'Compras netas de productos terminados deducibles                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (203, 163, 13, N'Inventario final de productos terminados                              ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (204, 163, 14, N'Otros                                                                 ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (205, 161, 20, N'Sueldos y salarios                                                    ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (206, 161, 21, N'Previsión social                                                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (207, 161, 22, N'Aportaciones al INFONAVIT                                             ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (208, 161, 23, N'Aportaciones al SAR                                                   ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (209, 161, 24, N'Cuotas patronales IMSS                                                ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (210, 161, 25, N'Arrendamiento de bienes                                               ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (211, 161, 26, N'Servicios profesionales                                               ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (212, 161, 27, N'Primas por fianzas y seguros                                          ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (213, 161, 28, N'Fletes y accarreos                                                    ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (214, 161, 29, N'Otros impuestos y derechos                                            ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (215, 161, 30, N'Depreciaciones                                                        ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (216, 161, 31, N'Amortizaciones                                                        ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (217, 160, 20, N'Sueldos y salarios                                                    ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (218, 160, 21, N'Previsión social                                                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (219, 160, 22, N'Aportaciones al INFONAVIT                                             ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (220, 160, 23, N'Aportaciones al SAR                                                   ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (221, 160, 24, N'Cuotas patronales IMSS                                                ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (222, 160, 25, N'Arrendamiento de bienes                                               ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (223, 160, 26, N'Servicios profesionales                                               ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (224, 160, 27, N'Primas por fianzas y seguros                                          ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (225, 160, 28, N'Fletes y accarreos                                                    ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (226, 160, 29, N'Otros impuestos y derechos                                            ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (227, 120, 21, N'Compras netas de materia prima                                        ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (228, 120, 22, N'Compras netas de producción  en proroceso                             ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (229, 120, 23, N'Compras netas de  productos  terminados                               ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (230, 161, 32, N'No deducibles                                                         ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (231, 120, 18, N'Compras netas de  importación de materia prima                        ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (232, 120, 19, N'Compras netas de  importación de producción en proceso                ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (233, 120, 20, N'Compras netas de  importación de productos terminados                 ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (234, 162, 20, N'Sueldos y salarios                                                    ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (235, 162, 21, N'Previsión social                                                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (236, 162, 22, N'Aportaciones al INFONAVIT                                             ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (237, 162, 23, N'Aportaciones al SAR                                                   ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (238, 162, 24, N'Cuotas patronales IMSS                                                ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (239, 162, 25, N'Arrendamiento de bienes                                               ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (240, 162, 26, N'Servicios profesionales                                               ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (241, 162, 27, N'Primas por fianzas y seguros                                          ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (242, 162, 28, N'Fletes y accarreos                                                    ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (243, 162, 29, N'Otros impuestos y derechos                                            ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (244, 162, 30, N'Depreciaciones                                                        ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (245, 162, 31, N'Amortizaciones                                                        ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (246, 162, 32, N'No deducibles                                                         ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (247, 163, 20, N'Sueldos y salarios                                                    ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (248, 163, 21, N'Previsión social                                                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (249, 163, 22, N'Aportaciones al INFONAVIT                                             ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (250, 163, 23, N'Aportaciones al SAR                                                   ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (251, 163, 24, N'Cuotas patronales IMSS                                                ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (252, 163, 25, N'Arrendamiento de bienes                                               ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (253, 163, 26, N'Servicios profesionales                                               ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (254, 163, 27, N'Primas por fianzas y seguros                                          ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (255, 163, 28, N'Fletes y accarreos                                                    ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (256, 163, 29, N'Otros impuestos y derechos                                            ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (257, 31, 1, N'Ingresos propios de la actividad                                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (258, 31, 2, N'Ajuste por inflación acumulable                                       ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (259, 31, 3, N'Anticipos de clientes del ejercicio (aumento)                         ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (260, 31, 4, N'Intereses moratorios efectivamente cobrados                           ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (261, 31, 5, N'Ganancia en la enajenación de acciones o por reembolso de capital     ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (262, 31, 6, N'Ganancia en la enajenación de terrenos de activos fijos               ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (263, 31, 7, N'Invetario acumulable del ejercicio                                    ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (264, 31, 8, N'Intereses devengados a favor                                          ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (265, 31, 9, N'Ganancia cambiaria                                                    ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (266, 31, 10, N'Otros ingresos fiscales contables                                     ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (267, 31, 13, N'Ajuste por inflación deducible                                        ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (268, 31, 14, N'Costo de lo vendido fiscal                                            ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (269, 31, 15, N'Adquisiciones netas de mercancías                                     ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (270, 31, 16, N'Mano de obra directa                                                  ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (271, 31, 17, N'Maquilas                                                              ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (272, 31, 18, N'Gastos indirectos de fabricación                                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (273, 31, 19, N'Deducción de inversiones                                              ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (274, 31, 20, N'Estimulo fiscal por deducción inmediata de inversiones                ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (275, 31, 21, N'Deuduccion adicional a la inmediata por venta de activo  fijo         ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (276, 31, 22, N'Estimulo fiscal de las personas con discapacidad y/o adultos mayores  ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (277, 31, 23, N'Pérdida fiscal en enajenación de acciones                             ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (278, 31, 24, N'Pérdida fiscal en enajenación de terrenos y activos fijos             ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (279, 31, 25, N'Intereses moratorios efectivamente pagados                            ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (280, 31, 26, N'Devuloción, rebajas y descuentos sobre ventas                         ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (281, 31, 27, N'Intereses devengados a cargo                                          ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (282, 31, 28, N'Pérdida cambiaria                                                     ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (283, 31, 29, N'Aplicación a reservas                                                 ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (284, 31, 30, N'Aplicación a pagos anticipados                                        ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (285, 31, 31, N'Aplicación a estimación para cuentas incobrables                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (286, 31, 32, N'Deducciones no pagadas al cierre del ejercicio anterior               ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (287, 31, 33, N'Otras deducciones fiscales contables                                  ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (288, 31, 34, N'Otras deducciones fiscales  no contables                              ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (289, 31, 11, N'Otros ingresos fiscales no contables                                  ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (290, 31, 12, N'Gastos de operación deducible                                         ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (291, 170, 1, N'Total de ingresos acumulables                                         ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (292, 170, 2, N'Total de deducciones autorizadas y deducción inmediata de inversiones ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (293, 170, 3, N'Utilidad o pérdida fiscal antes de la PTU                             ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (294, 170, 4, N'PTU pagada en el  ejercicio                                           ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (295, 170, 5, N'Utilidad o pérdida  fiscal del ejercicio                              ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (296, 170, 6, N'Pérdidas fiscales de ejercicios anteriores que se aplican en el ejerci', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (297, 170, 7, N'Resultado fiscal                                                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (298, 170, 8, N'Impuesto sobre la renta del ejercicio                                 ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (299, 170, 9, N'Reducicones del ISR                                                   ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (300, 170, 10, N'Impuesto causado en el ejercicio                                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (301, 170, 11, N'Estímulo por proyectos en invest. y des. tecnologico                  ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (302, 170, 12, N'Otros estímulos                                                       ', N'', N'', 0)
GO
print 'Processed 300 total records'
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (303, 170, 13, N'Pagos provisionales efectuados                                        ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (304, 170, 14, N'Impuesto retenido al contribuyente                                    ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (305, 170, 15, N'Impuesto acreditable pagado en el extranjero                          ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (306, 170, 16, N'Impuesto acreditable por dividendos o utilidades distribuidos         ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (307, 170, 17, N'Impuesto a cargo  correspondiente a la consolidación fiscal           ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (308, 170, 18, N'Diferencia a cargo o a favor                                          ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (309, 170, 19, N'Impuesto a la venta de bienes y servicios suntuarios acreditable      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (310, 170, 20, N'Impuesto por inversiones en territorios con regímenes fiscales prerfer', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (311, 170, 21, N'Impuestos sobre ingresos sujetos a regímenes fiscales preferentes     ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (312, 170, 22, N'ISR pagado en Exceso aplicado contra el IMPAC                         ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (313, 170, 23, N'Impuesto a cargo o a favor del ejercicio                              ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (314, 45, 1, N'Sueldos y salarios                                                    ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (315, 45, 2, N'Honorarios pagados a personas físicas                                 ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (316, 45, 3, N'Regalías y asistencia técnica                                         ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (317, 45, 4, N'Donativos otorgados                                                   ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (318, 45, 5, N'Uso o goce temporal de bienes pagados a personas físicas              ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (319, 45, 6, N'Fletes y acarreos pagados a personas físicas                          ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (320, 45, 7, N'Contribuciones pagadas, excepto ISR e IVA                             ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (321, 45, 8, N'Seguros y fianzas                                                     ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (322, 45, 9, N'Pérdida por créditos incobrables                                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (323, 45, 10, N'Viáticos y gastos de viaje                                            ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (324, 45, 11, N'Combustible y lubricantes                                             ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (325, 45, 12, N'Crédito al salario no disminuido de contribuciones                    ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (326, 45, 13, N'Impuesto sustitutivo del crédito al salario, efectivamente pagado     ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (327, 45, 14, N'Aportaciones SAR, INFONAVIT, y jubilaciones por vejez                 ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (328, 45, 15, N'Aportaciones para fondos de pensiones y jubilaciones                  ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (329, 45, 16, N'Cuotas al IMSS                                                        ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (330, 45, 17, N'Consumo en restaurantes                                               ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (331, 120, 24, N'Dev. Desc  O bonif s/ compras de materias primas                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (332, 120, 25, N'Dev. Desc O bonif s/ compras de  producción en proceso                ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (333, 120, 26, N'Dev. Desc O bonif s/ compras de productos terminados                  ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (334, 162, 33, N'Dev. Desc. O bonif s/compras nacionales de materias primas            ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (335, 162, 34, N'Dev. Desc. O bonif s/compras importacion de materias primas           ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (336, 162, 35, N'Dev. Desc. O bonif s/compras nacionales de producción en proceso      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (337, 162, 36, N'Dev. Desc.O bonif s/compras importación de producción en proceso      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (338, 162, 37, N'Dev. Desc.O bonif s/compras nacionales de  productos terminados       ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (339, 162, 38, N'Dev. Desc. O bonif s/compras  importación de  productos terminados    ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (340, 163, 30, N'Dev. Desc. O bonif s/compras de materias primas                       ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (341, 163, 31, N'Dev. Desc. O bonifa s/compras de producción en proceso                ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (342, 163, 32, N'Dev. Desc. O bonif s/compras de  productos terminados                 ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (343, 50, 1, N'Utilidad cambiaria exigible                                           ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (344, 50, 2, N'Pérdida cambiaria exigible                                            ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (345, 20, 1, N'Efectivo en caja y depósitos en Instituciones de crédito Nacionales.  ', N'', N'A', 1)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (346, 20, 2, N'Efectivo en caja y depósitos en Instituciones de crédito del Extranjer', N'', N'A', 2)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (347, 20, 3, N'Inversiones en valores con instituciones nacionales (excepto acciones)', N'', N'A', 3)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (348, 20, 4, N'Inversiones en valores con instituciones extranjeras (excepto acciones', N'', N'A', 4)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (349, 20, 6, N'Cuentas y documentos por cobrar nacionales (Partes no relacionadas).  ', N'', N'A', 6)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (350, 20, 8, N'Cuentas y documentos por cobrar del extranjero (Partes no relacionadas', N'', N'A', 8)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (351, 20, 9, N'Contribuciones a favor.                                               ', N'', N'A', 9)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (352, 20, 10, N'Inventarios.                                                          ', N'', N'A', 10)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (353, 20, 11, N'Otros activos circulantes.                                            ', N'', N'A', 11)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (354, 20, 12, N'Inversiones en acciones nacionales.                                   ', N'', N'A', 12)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (355, 20, 13, N'Inversiones en acciones del extranjero.                               ', N'', N'A', 13)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (356, 20, 14, N'Terrenos.                                                             ', N'', N'A', 14)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (357, 20, 15, N'Construcciones.                                                       ', N'', N'A', 15)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (358, 20, 16, N'Construcciones en proceso.                                            ', N'', N'A', 16)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (359, 20, 17, N'Maquinaria y equipo.                                                  ', N'', N'A', 17)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (360, 20, 18, N'Mobiliario y equipo de oficina.                                       ', N'', N'A', 18)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (361, 20, 19, N'Equipo de cómputo.                                                    ', N'', N'A', 19)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (362, 20, 20, N'Equipo de transporte.                                                 ', N'', N'A', 20)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (363, 20, 21, N'Otros activos fijos.                                                  ', N'', N'A', 21)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (364, 20, 22, N'Depreciación acumulada.                                               ', N'', N'A', 22)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (365, 20, 23, N'Cargos y gastos diferidos.                                            ', N'', N'A', 23)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (366, 20, 24, N'Amortización acumulada.                                               ', N'', N'A', 24)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (367, 20, 26, N'Cuentas y documentos por pagar nacionales (Partes no relacionadas).   ', N'', N'B', 26)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (368, 20, 28, N'Cuentas y documentos por pagar del extranjero (Partes no relacionadas)', N'', N'B', 28)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (369, 20, 29, N'Contribuciones por pagar.                                             ', N'', N'B', 29)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (370, 20, 30, N'Anticipos de clientes (Partes relacionadas).                          ', N'', N'B', 30)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (371, 20, 31, N'Anticipos de clientes (Partes no relacionadas).                       ', N'', N'B', 31)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (372, 20, 33, N'Otros pasivos.                                                        ', N'', N'B', 33)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (373, 20, 34, N'Capital social proveniente de aportaciones.                           ', N'', N'C', 34)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (374, 20, 35, N'Capital social proveniente de capitalización.                         ', N'', N'C', 35)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (375, 20, 36, N'Reservas.                                                             ', N'', N'C', 36)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (376, 20, 37, N'Otras cuentas de capital.                                             ', N'', N'C', 37)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (377, 20, 39, N'Utilidades acumuladas.                                                ', N'', N'C', 38)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (378, 20, 40, N'Utilidad del ejercicio.                                               ', N'', N'C', 39)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (379, 20, 41, N'Pérdidas acumuladas.                                                  ', N'', N'C', 40)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (380, 20, 42, N'Pérdida del ejercicio.                                                ', N'', N'C', 41)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (381, 20, 43, N'Exceso en la actualización del capital.                               ', N'', N'C', 42)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (382, 20, 44, N'Insuficiencia en la actualización del capital.                        ', N'', N'C', 43)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (383, 20, 45, N'Actualización del capital contable.                                   ', N'', N'C', 44)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (384, 30, 20, N'Intereses devengados a favor del extranjero (partes no relacionadas)  ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (385, 30, 21, N'Intereses devengados a cargo del extranjero (partes no relacionadas)  ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (386, 30, 35, N'Intereses moratorios a favor nacionales (partes no relacionadas)      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (387, 30, 36, N'Intereses moratorios a cargo nacionales (partes no relacionadas)      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (388, 30, 37, N'Intereses moratorios a favor del extranjero (partes no relacionadas)  ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (389, 30, 38, N'Intereses moratorios a cargo del extranjero (partes no relacionadas)  ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (390, 30, 39, N'Ganancia cambiaria (partes no relacionadas)                           ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (391, 30, 40, N'Pérdida cambiaria (partes no relacionadas)                            ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (392, 30, 41, N'Resultado por posición monetaria desfavorable                         ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (393, 30, 42, N'Otras operaciones financieras del extranjero (partes no relacionadas) ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (394, 30, 43, N'Otros gastos nacionales (total)                                       ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (395, 30, 44, N'Otros gastos extranjeros (total)                                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (396, 30, 45, N'Otros productos nacionales                                            ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (397, 30, 46, N'Otros productos extranjeros                                           ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (398, 30, 47, N'IETU                                                                  ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (399, 30, 48, N'IMPAC                                                                 ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (400, 30, 49, N'PTU                                                                   ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (401, 30, 50, N'Utilidad en participación subsidiaria                                 ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (402, 30, 51, N'Pérdida en participación subsidiaria                                  ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (403, 30, 52, N'Efectos de reexpresión favorables excepto resultado por posición finan', N'', N'', 0)
GO
print 'Processed 400 total records'
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (404, 30, 53, N'Efectos de reexpresión desfavorables excepto resultado por posición fi', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (405, 20, 32, N'Aportaciones para futuros aumentos de capital.                        ', N'', N'B', 32)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (406, 20, 38, N'Aportaciones para futuros aumentos de capital.                        ', N'', N'C', 38)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (407, 170, 24, N'Deducción adicional por trabajadores del primer empleo                ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (408, 171, 1, N'Acréditamiento por sueldos y salarios gravados                        ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (409, 171, 2, N'Acréditamiento por aportaciones de seguridad social                   ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (410, 80, 7, N'ISR retenido asimilados a salarios                                    ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (411, 80, 8, N'ISR retenido servicios profesionales                                  ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (412, 80, 9, N'ISR retenido uso o goce temporal de bienes                            ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (413, 172, 4, N'Actividades a la tasa 0% otros (IVA trasladado)                       ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (414, 172, 5, N'Valor de los actos o actividades excentas (IVA trasladado)            ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (415, 172, 11, N'Actividades a la tasa 0% otros (IVA acreditable)                      ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (416, 172, 12, N'Valor de los actos o actividades excentas (IVA acreditable)           ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (417, 172, 1, N'IVA trasladado a la tasa 16%                                          ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (418, 172, 2, N'IVA trasladado a la tasa 11%                                          ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (419, 172, 8, N'IVA acreditable a la tasa 16%                                         ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (420, 172, 9, N'IVA acreditable a la tasa 11%                                         ', N'', N'', 0)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (421, 20, 5, N'Cuentas y documentos por cobrar nacionales (Partes relacionadas).      ', N'',N'A',5)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (422, 20, 7, N'Cuentas y documentos por cobrar del extranjero (Partes relacionadas).  ', N'',N'A',7)
INSERT [dbo].[BasesDeCalculo] ([idBaseDeCalculo], [Reporte], [ClaveBC], [Nombre], [Descripcion], [Naturaleza], [Orden]) VALUES (423, 20, 25, N'Cuentas y documentos por pagar nacionales (Partes relacionadas).      ', N'',N'B',25)
SET IDENTITY_INSERT [dbo].[BasesDeCalculo] OFF
/****** Object:  Table [dbo].[BaseCalculoRubroFiscal]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BaseCalculoRubroFiscal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BaseCalculoRubroFiscal](
	[idBaseDeCalculo] [int] NOT NULL,
	[Rubro] [int] NOT NULL,
 CONSTRAINT [PK_BaseCalculoRubroFiscal] PRIMARY KEY CLUSTERED 
(
	[idBaseDeCalculo] ASC,
	[Rubro] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'BaseCalculoRubroFiscal', N'COLUMN',N'idBaseDeCalculo'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'id de la base de calculo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BaseCalculoRubroFiscal', @level2type=N'COLUMN',@level2name=N'idBaseDeCalculo'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'BaseCalculoRubroFiscal', N'COLUMN',N'Rubro'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'id del rubro fiscal' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BaseCalculoRubroFiscal', @level2type=N'COLUMN',@level2name=N'Rubro'
GO

INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (2, 130)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (3, 140)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (3, 150)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (4, 230)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2000)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2004)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2010)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2014)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2020)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2030)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2034)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2040)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2050)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2060)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2070)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2080)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2090)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2100)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2110)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2120)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2130)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2140)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2150)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2160)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2170)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2180)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2190)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2200)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2210)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2220)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2230)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2240)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2250)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2300)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2320)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2490)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (16, 2510)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (18, 330)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (19, 2340)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (20, 420)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (20, 2380)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (22, 360)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (22, 370)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (22, 500)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (22, 510)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (22, 520)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (22, 530)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (22, 540)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (22, 550)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (22, 560)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (22, 570)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (22, 580)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (22, 584)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (22, 586)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (22, 620)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (23, 2348)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (23, 2390)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (23, 2400)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (23, 2410)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (23, 2420)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (23, 2470)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (23, 2480)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (26, 2310)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (29, 410)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (31, 640)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (31, 2440)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (37, 6030)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (40, 2210)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (40, 2220)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (41, 2300)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (43, 2310)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (43, 2311)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (43, 2312)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (43, 2313)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (44, 2390)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (45, 2400)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (46, 2430)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (47, 2034)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (47, 2420)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (47, 2470)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (54, 6050)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (56, 560)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (56, 570)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (57, 540)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (58, 530)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (59, 630)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (60, 370)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (60, 510)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (60, 550)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (60, 580)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (60, 584)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (63, 3490)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (63, 3510)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (63, 3530)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (64, 3470)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (64, 3480)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (66, 1020)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (66, 1030)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (66, 1040)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (66, 1050)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (66, 1060)
GO
print 'Processed 100 total records'
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (66, 1070)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (67, 1080)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (67, 1090)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (67, 1100)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (67, 1110)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (67, 1120)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (67, 1130)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (67, 1140)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (67, 1150)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (67, 1160)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (67, 1170)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (67, 1180)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (67, 1190)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (67, 1200)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (67, 1210)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (67, 1220)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (67, 1230)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (67, 1240)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (68, 130)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (68, 140)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (68, 150)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (68, 330)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (68, 332)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (68, 350)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (68, 352)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (68, 360)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (68, 370)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (68, 380)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (68, 440)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (68, 450)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (68, 500)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (68, 510)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (68, 520)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (68, 530)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (68, 540)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (68, 550)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (68, 560)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (68, 570)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (68, 580)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (68, 584)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (68, 586)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (68, 620)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (68, 630)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (68, 640)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (68, 6030)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (69, 360)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (69, 370)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (69, 510)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (69, 530)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (69, 540)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (69, 550)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (69, 560)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (69, 570)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (69, 580)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (69, 584)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (69, 630)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (69, 640)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (70, 2490)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (71, 3400)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (73, 3020)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (73, 3030)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (73, 3050)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (73, 3060)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (73, 3100)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (73, 3110)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (73, 3122)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (73, 3130)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (73, 3150)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (73, 3190)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (73, 3210)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (73, 3220)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (73, 3240)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (73, 3600)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (74, 4000)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (74, 4010)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (74, 4060)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (74, 4080)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (74, 4100)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (74, 4110)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (74, 4130)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (74, 4250)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (74, 4310)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (74, 4320)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (74, 4340)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (74, 4360)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (74, 4400)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (74, 5040)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (81, 4250)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (81, 4260)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (82, 4250)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (82, 4260)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (83, 4250)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (83, 4260)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (84, 4250)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (84, 4260)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (85, 3410)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (86, 4430)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (87, 3260)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (88, 3900)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (89, 4340)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (89, 4350)
GO
print 'Processed 200 total records'
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (90, 4030)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (90, 4050)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (91, 4040)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (92, 3490)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (93, 3490)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (94, 3470)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (95, 3450)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (96, 3510)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (97, 3510)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (98, 5060)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (99, 5050)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (100, 5070)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (101, 510)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (101, 520)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (104, 4220)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (106, 3380)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (108, 3640)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (109, 4460)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (110, 3490)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (112, 3490)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (113, 3510)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (114, 1080)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (114, 1100)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (114, 1110)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (114, 1120)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (114, 1130)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (115, 1160)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (115, 1170)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (115, 1180)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (115, 1190)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (115, 1200)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (115, 1210)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (115, 1220)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (115, 1240)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (117, 1090)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (119, 3510)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (120, 3530)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (131, 2348)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (132, 2500)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (133, 2344)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (134, 360)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (135, 240)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (135, 250)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (137, 350)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (139, 410)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (139, 2370)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (142, 3310)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (143, 4240)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (144, 390)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (145, 2350)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (146, 3330)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (147, 3474)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (148, 3454)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (149, 3530)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (150, 3530)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (151, 3480)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (152, 3460)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (153, 3450)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (153, 3470)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (153, 3490)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (156, 3450)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (156, 3470)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (156, 3490)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (157, 3454)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (157, 3474)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (157, 3510)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (158, 1080)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (158, 1100)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (158, 1110)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (158, 1120)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (158, 1130)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (159, 1160)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (159, 1170)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (159, 1180)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (159, 1190)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (159, 1200)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (159, 1210)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (159, 1220)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (159, 1240)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (160, 1140)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (160, 1150)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (160, 1230)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (161, 1090)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (164, 3454)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (164, 3474)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (164, 3510)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (165, 3460)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (165, 3480)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (165, 3530)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (168, 3460)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (168, 3480)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (168, 3530)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (171, 3530)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (174, 3450)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (174, 3470)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (174, 3490)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (175, 1020)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (176, 1050)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (177, 3450)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (177, 3470)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (177, 3490)
GO
print 'Processed 300 total records'
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (178, 3454)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (178, 3474)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (178, 3510)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (179, 1080)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (179, 1100)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (179, 1110)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (179, 1120)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (179, 1130)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (180, 1160)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (180, 1170)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (180, 1180)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (180, 1190)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (180, 1200)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (180, 1210)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (180, 1220)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (180, 1240)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (181, 1140)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (181, 1150)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (181, 1230)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (182, 1090)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (183, 1030)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (184, 1060)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (185, 3454)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (185, 3474)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (185, 3510)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (186, 3460)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (186, 3480)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (186, 3530)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (187, 1040)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (188, 1070)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (189, 3460)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (189, 3480)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (189, 3530)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (191, 3490)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (192, 1020)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (192, 1050)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (193, 3490)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (194, 3510)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (195, 1080)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (195, 1100)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (195, 1110)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (195, 1120)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (195, 1130)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (196, 1160)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (196, 1170)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (196, 1180)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (196, 1190)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (196, 1200)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (196, 1210)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (196, 1220)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (196, 1240)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (198, 1090)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (199, 1030)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (199, 1060)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (200, 3510)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (201, 3530)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (202, 1040)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (202, 1070)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (203, 3530)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (205, 1080)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (206, 1100)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (207, 1110)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (208, 1120)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (209, 1130)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (210, 1170)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (211, 1160)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (212, 1200)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (213, 1210)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (214, 1220)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (215, 1140)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (216, 1150)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (217, 1080)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (218, 1100)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (219, 1110)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (220, 1120)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (221, 1130)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (222, 1170)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (223, 1160)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (224, 1200)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (225, 1210)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (226, 1220)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (227, 1020)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (227, 1050)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (228, 1030)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (228, 1060)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (229, 1040)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (229, 1070)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (230, 1230)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (231, 1050)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (232, 1060)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (233, 1070)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (234, 1080)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (235, 1100)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (236, 1110)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (237, 1120)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (238, 1130)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (239, 1170)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (240, 1160)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (241, 1200)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (242, 1210)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (243, 1220)
GO
print 'Processed 400 total records'
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (244, 1140)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (245, 1150)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (246, 1230)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (247, 1080)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (248, 1100)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (249, 1110)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (250, 1120)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (251, 1130)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (252, 1170)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (253, 1160)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (254, 1200)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (255, 1210)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (256, 1220)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (257, 130)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (257, 140)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (257, 150)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (260, 350)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (260, 352)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (264, 330)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (264, 332)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (265, 380)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (265, 390)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (266, 420)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (266, 430)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (266, 440)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (266, 450)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (266, 500)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (266, 520)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (266, 586)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (266, 620)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (276, 2500)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (279, 2344)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (280, 230)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (280, 240)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (280, 250)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (281, 2340)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (281, 2342)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (281, 2346)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (282, 2349)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (282, 2350)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (287, 2380)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (287, 2410)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (287, 2480)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (287, 2510)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (287, 2520)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (288, 6050)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (289, 6030)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (290, 2000)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (290, 2004)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (290, 2010)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (290, 2014)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (290, 2020)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (290, 2030)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (290, 2040)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (290, 2050)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (290, 2060)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (290, 2070)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (290, 2080)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (290, 2090)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (290, 2100)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (290, 2110)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (290, 2120)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (290, 2130)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (290, 2140)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (290, 2150)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (290, 2160)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (290, 2170)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (290, 2180)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (290, 2190)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (290, 2200)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (290, 2230)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (290, 2240)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (290, 2250)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (290, 2320)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (290, 2322)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (290, 2490)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (305, 3420)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (306, 3430)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (307, 4270)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (310, 4280)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (311, 4290)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (314, 2000)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (314, 2004)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (315, 2010)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (316, 2020)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (317, 2030)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (318, 2040)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (319, 2060)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (320, 2080)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (321, 2090)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (322, 2100)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (323, 2110)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (324, 2120)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (325, 2130)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (326, 2140)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (327, 2150)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (327, 2160)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (327, 2170)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (328, 2180)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (329, 2190)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (330, 2200)
GO
print 'Processed 500 total records'
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (331, 1024)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (331, 1054)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (332, 1034)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (332, 1064)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (333, 1044)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (333, 1074)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (334, 1024)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (335, 1054)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (336, 1034)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (337, 1064)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (338, 1044)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (339, 1074)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (340, 1024)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (340, 1054)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (341, 1034)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (341, 1064)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (342, 1044)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (342, 1074)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (345, 3000)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (345, 3020)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (346, 3010)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (346, 3030)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (346, 3040)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (347, 3050)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (348, 3060)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (348, 3070)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (349, 3100)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (349, 3150)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (349, 3160)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (349, 3210)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (349, 3220)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (349, 3230)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (349, 3260)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (349, 3340)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (350, 3110)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (350, 3120)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (350, 3122)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (350, 3130)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (350, 3140)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (350, 3190)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (350, 3200)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (350, 3240)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (350, 3250)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (351, 3310)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (351, 3320)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (351, 3350)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (351, 3400)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (351, 3410)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (352, 3450)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (352, 3454)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (352, 3460)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (352, 3470)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (352, 3474)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (352, 3480)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (352, 3490)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (352, 3500)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (352, 3510)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (352, 3520)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (352, 3530)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (352, 3540)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (352, 3550)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (352, 3560)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (353, 3300)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (353, 3380)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (353, 3390)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (353, 3600)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (353, 3610)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (353, 3640)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (354, 3660)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (355, 3670)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (356, 3700)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (356, 3710)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (357, 3720)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (357, 3730)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (358, 3732)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (358, 3734)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (359, 3740)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (359, 3750)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (359, 3834)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (359, 3836)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (360, 3760)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (360, 3770)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (361, 3780)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (361, 3790)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (362, 3800)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (362, 3810)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (362, 3820)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (362, 3830)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (363, 3840)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (363, 3850)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (364, 3860)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (364, 3870)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (365, 3680)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (365, 3880)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (365, 3890)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (365, 3900)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (365, 3904)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (365, 3906)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (366, 3910)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (366, 3920)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (367, 4000)
GO
print 'Processed 600 total records'
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (367, 4010)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (367, 4020)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (367, 4100)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (367, 4110)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (367, 4120)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (367, 4150)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (367, 4400)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (367, 4410)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (368, 4060)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (368, 4070)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (368, 4080)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (368, 4090)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (368, 4130)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (368, 4140)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (369, 4220)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (369, 4230)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (369, 4240)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (369, 4244)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (369, 4250)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (369, 4260)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (371, 4030)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (371, 4040)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (372, 4050)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (372, 4300)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (372, 4310)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (372, 4320)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (372, 4330)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (372, 4340)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (372, 4350)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (372, 4360)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (372, 4370)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (372, 4430)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (372, 4460)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (372, 4470)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (373, 5000)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (373, 5070)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (374, 5010)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (375, 5020)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (376, 5030)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (377, 5080)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (379, 5090)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (381, 5110)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (382, 5120)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (384, 332)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (385, 2342)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (386, 350)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (388, 352)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (389, 2346)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (390, 380)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (390, 390)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (391, 2349)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (391, 2350)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (392, 2370)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (393, 430)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (394, 2520)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (395, 2322)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (396, 440)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (397, 450)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (398, 2311)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (399, 2312)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (400, 2313)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (401, 630)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (402, 2430)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (403, 640)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (404, 2440)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (405, 4380)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (406, 5040)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (407, 2520)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (408, 1080)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (408, 1100)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (408, 2000)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (408, 2004)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (409, 332)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (409, 1110)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (409, 1120)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (409, 1130)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (409, 2150)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (409, 2160)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (409, 2170)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (409, 2190)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (410, 4250)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (411, 4250)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (412, 4250)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (415, 1020)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (415, 1030)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (415, 1040)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (415, 1050)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (415, 1060)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (415, 1070)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (417, 4221)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (418, 4222)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (419, 3381)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (420, 3382)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (421, 3100)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (421, 3150)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (421, 3160)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (421, 3210)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (421, 3220)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (421, 3230)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (421, 3260)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (421, 3340)
GO
print 'Processed 700 total records'
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (422, 3110)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (422, 3120)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (422, 3122)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (422, 3130)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (422, 3140)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (422, 3190)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (422, 3200)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (422, 3240)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (422, 3250)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (423, 4000)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (423, 4010)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (423, 4020)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (423, 4030)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (423, 4100)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (423, 4110)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (423, 4120)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (423, 4150)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (423, 4400)
INSERT [dbo].[BaseCalculoRubroFiscal] ([idBaseDeCalculo], [Rubro]) VALUES (423, 4410)

/****** Object:  Table [dbo].[ElementoBasicoSub]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ElementoBasicoSub]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ElementoBasicoSub](
	[IdElementoBasico] [int] NOT NULL,
	[ClaveSub] [nvarchar](2) NOT NULL,
	[Descripcion] [nvarchar](100) NULL,
 CONSTRAINT [PK_ElementoBasicoSub_1] PRIMARY KEY CLUSTERED 
(
	[IdElementoBasico] ASC,
	[ClaveSub] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
INSERT [dbo].[ElementoBasicoSub] ([IdElementoBasico], [ClaveSub], [Descripcion]) VALUES (1, N'A1', N'Activo Circulante')
INSERT [dbo].[ElementoBasicoSub] ([IdElementoBasico], [ClaveSub], [Descripcion]) VALUES (1, N'A2', N'Activo Fijo')
INSERT [dbo].[ElementoBasicoSub] ([IdElementoBasico], [ClaveSub], [Descripcion]) VALUES (1, N'A3', N'Activo diferido')
INSERT [dbo].[ElementoBasicoSub] ([IdElementoBasico], [ClaveSub], [Descripcion]) VALUES (2, N'P1', N'Pasivo a Corto Plazo')
INSERT [dbo].[ElementoBasicoSub] ([IdElementoBasico], [ClaveSub], [Descripcion]) VALUES (2, N'P2', N'Pasivo a Largo Plazo')
INSERT [dbo].[ElementoBasicoSub] ([IdElementoBasico], [ClaveSub], [Descripcion]) VALUES (2, N'P4', N'pasivo mine modify')
INSERT [dbo].[ElementoBasicoSub] ([IdElementoBasico], [ClaveSub], [Descripcion]) VALUES (3, N'C1', N'Capital Contable')
INSERT [dbo].[ElementoBasicoSub] ([IdElementoBasico], [ClaveSub], [Descripcion]) VALUES (4, N'V1', N'Ingresos')
INSERT [dbo].[ElementoBasicoSub] ([IdElementoBasico], [ClaveSub], [Descripcion]) VALUES (4, N'V2', N'Ingresos del Extranjero')
INSERT [dbo].[ElementoBasicoSub] ([IdElementoBasico], [ClaveSub], [Descripcion]) VALUES (5, N'T1', N'Costo de ventas')
INSERT [dbo].[ElementoBasicoSub] ([IdElementoBasico], [ClaveSub], [Descripcion]) VALUES (6, N'G1', N'Gastos de Venta')
INSERT [dbo].[ElementoBasicoSub] ([IdElementoBasico], [ClaveSub], [Descripcion]) VALUES (6, N'G2', N'Gastos de Administracion')
INSERT [dbo].[ElementoBasicoSub] ([IdElementoBasico], [ClaveSub], [Descripcion]) VALUES (7, N'H5', N'Productos Eventuales')
INSERT [dbo].[ElementoBasicoSub] ([IdElementoBasico], [ClaveSub], [Descripcion]) VALUES (8, N'F1', N'Gastos Eventuales')
INSERT [dbo].[ElementoBasicoSub] ([IdElementoBasico], [ClaveSub], [Descripcion]) VALUES (9, N'I1', N'Impuesto Sobre la renta y PTU')
INSERT [dbo].[ElementoBasicoSub] ([IdElementoBasico], [ClaveSub], [Descripcion]) VALUES (10, N'O1', N'Cuentas de Orden Deudora')
INSERT [dbo].[ElementoBasicoSub] ([IdElementoBasico], [ClaveSub], [Descripcion]) VALUES (10, N'O2', N'Cuentas de Orden Acreedora')
/****** Object:  Table [dbo].[SaldosIni]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SaldosIni]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SaldosIni](
	[Empresa] [nvarchar](20) NOT NULL,
	[CuentaContable] [nvarchar](60) NOT NULL,
	[anio] [int] NOT NULL,
	[saldoinicial] [float] NULL,
 CONSTRAINT [PK_SaldosIni] PRIMARY KEY CLUSTERED 
(
	[Empresa] ASC,
	[CuentaContable] ASC,
	[anio] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'SaldosIni', N'COLUMN',N'Empresa'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'identificador de la empresa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SaldosIni', @level2type=N'COLUMN',@level2name=N'Empresa'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'SaldosIni', N'COLUMN',N'CuentaContable'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'numero de la cuenta contable' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SaldosIni', @level2type=N'COLUMN',@level2name=N'CuentaContable'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'SaldosIni', N'COLUMN',N'anio'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'anio la que pertenece el saldo inicial' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SaldosIni', @level2type=N'COLUMN',@level2name=N'anio'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'SaldosIni', N'COLUMN',N'saldoinicial'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'importe del saldo inicial' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SaldosIni', @level2type=N'COLUMN',@level2name=N'saldoinicial'
GO

/****** Object:  Table [dbo].[ReporteBaseCalculo]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReporteBaseCalculo]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ReporteBaseCalculo](
	[Reporte] [int] NOT NULL,
	[idBaseDeCalculo] [int] NOT NULL,
 CONSTRAINT [PK_ReporteBaseCalculo] PRIMARY KEY CLUSTERED 
(
	[Reporte] ASC,
	[idBaseDeCalculo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'ReporteBaseCalculo', N'COLUMN',N'Reporte'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'id del reporte' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReporteBaseCalculo', @level2type=N'COLUMN',@level2name=N'Reporte'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'ReporteBaseCalculo', N'COLUMN',N'idBaseDeCalculo'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'id de la base de calculo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReporteBaseCalculo', @level2type=N'COLUMN',@level2name=N'idBaseDeCalculo'
GO
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 348)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 349)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 350)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 351)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 352)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 353)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 354)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 355)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 356)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 357)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 358)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 359)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 360)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 361)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 362)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 363)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 364)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 365)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 366)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 367)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 368)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 369)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 370)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 371)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 372)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 373)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 374)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 375)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 376)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 377)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 378)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 379)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 380)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 381)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 382)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 383)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 384)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 385)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 386)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 408)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (20, 409)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 1)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 2)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 3)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 4)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 5)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 6)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 7)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 8)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 9)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 10)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 11)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 12)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 13)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 14)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 15)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 16)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 17)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 18)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 19)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 20)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 21)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 22)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 23)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 24)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 25)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 26)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 27)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 28)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 29)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 138)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 387)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 388)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 389)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 390)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 391)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 392)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 393)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 394)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 395)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 396)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 397)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 398)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 399)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 400)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 401)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 402)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 403)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 404)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 405)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 406)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (30, 407)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 260)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 261)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 262)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 263)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 264)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 265)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 266)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 267)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 268)
GO
print 'Processed 100 total records'
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 269)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 270)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 271)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 272)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 273)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 274)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 275)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 276)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 277)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 278)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 279)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 280)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 281)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 282)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 283)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 284)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 285)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 286)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 287)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 288)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 289)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 290)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 291)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 292)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (31, 293)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 30)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 31)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 32)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 33)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 34)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 35)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 36)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 37)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 38)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 39)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 40)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 41)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 42)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 43)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 44)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 45)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 46)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 47)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 48)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 49)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 50)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 51)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 52)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 53)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 54)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 55)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 56)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 57)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 58)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 59)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 60)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 61)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 62)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 121)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 122)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 123)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 124)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 125)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 126)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 127)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 128)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 129)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 130)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 134)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 135)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 136)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 137)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 139)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 140)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 141)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 142)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 143)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (40, 144)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (45, 317)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (45, 318)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (45, 319)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (45, 320)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (45, 321)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (45, 322)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (45, 323)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (45, 324)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (45, 325)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (45, 326)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (45, 327)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (45, 328)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (45, 329)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (45, 330)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (45, 331)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (45, 332)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (45, 333)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (50, 346)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (50, 347)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (60, 68)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (60, 69)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (60, 70)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (60, 71)
GO
print 'Processed 200 total records'
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (60, 72)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (60, 147)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (60, 148)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (60, 176)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (65, 73)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (65, 74)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (65, 108)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (65, 109)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (65, 145)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (65, 146)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (70, 75)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (70, 76)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (70, 77)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (70, 78)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (70, 79)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (70, 80)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (80, 81)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (80, 82)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (80, 83)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (80, 84)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (80, 85)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (80, 149)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (80, 413)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (80, 414)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (80, 415)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (90, 86)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (100, 87)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (100, 88)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (100, 89)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (110, 90)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (110, 91)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (120, 92)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (120, 93)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (120, 94)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (120, 95)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (120, 96)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (120, 97)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (120, 150)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (120, 151)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (120, 152)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (120, 153)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (120, 154)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (120, 155)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (120, 230)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (120, 231)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (120, 232)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (120, 234)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (120, 235)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (120, 236)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (120, 334)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (120, 335)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (120, 336)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (130, 98)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (130, 99)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (130, 100)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (160, 110)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (160, 111)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (160, 112)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (160, 113)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (160, 114)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (160, 115)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (160, 116)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (160, 117)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (160, 118)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (160, 119)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (160, 120)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (160, 173)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (160, 174)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (160, 175)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (160, 220)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (160, 221)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (160, 222)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (160, 223)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (160, 224)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (160, 225)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (160, 226)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (160, 227)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (160, 228)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (160, 229)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 156)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 157)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 158)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 159)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 160)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 161)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 162)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 163)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 164)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 165)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 166)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 167)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 168)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 169)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 170)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 171)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 172)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 208)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 209)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 210)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 211)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 212)
GO
print 'Processed 300 total records'
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 213)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 214)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 215)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 216)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 217)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 218)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 219)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (161, 233)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 177)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 178)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 179)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 180)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 181)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 182)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 183)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 184)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 185)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 186)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 187)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 188)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 189)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 190)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 191)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 192)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 193)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 237)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 238)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 239)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 240)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 241)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 242)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 243)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 244)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 245)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 246)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 247)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 248)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 249)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 337)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 338)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 339)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 340)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 341)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (162, 342)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (163, 194)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (163, 195)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (163, 196)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (163, 197)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (163, 198)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (163, 199)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (163, 200)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (163, 201)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (163, 202)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (163, 203)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (163, 204)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (163, 205)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (163, 206)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (163, 207)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (163, 250)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (163, 251)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (163, 252)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (163, 253)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (163, 254)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (163, 255)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (163, 256)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (163, 257)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (163, 258)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (163, 259)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (163, 343)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (163, 344)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (163, 345)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (170, 294)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (170, 295)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (170, 296)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (170, 297)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (170, 298)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (170, 299)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (170, 300)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (170, 301)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (170, 302)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (170, 303)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (170, 304)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (170, 305)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (170, 306)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (170, 307)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (170, 308)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (170, 309)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (170, 310)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (170, 311)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (170, 312)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (170, 313)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (170, 314)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (170, 315)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (170, 316)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (170, 410)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (171, 411)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (171, 412)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (172, 416)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (172, 417)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (172, 418)
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (172, 419)
GO
print 'Processed 400 total records'
INSERT [dbo].[ReporteBaseCalculo] ([Reporte], [idBaseDeCalculo]) VALUES (172, 420)
/****** Object:  Table [dbo].[rubros_inhibidos]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rubros_inhibidos]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[rubros_inhibidos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Pregunta] [int] NOT NULL,
	[Respuesta] [int] NOT NULL,
	[RubroFiscal] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[rubros_inhibidos] ON
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (1, 1, 4, 1020)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (2, 1, 4, 1030)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (3, 1, 4, 1050)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (4, 1, 4, 1060)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (5, 1, 4, 1080)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (6, 1, 4, 1090)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (7, 1, 4, 1100)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (8, 1, 4, 1110)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (9, 1, 4, 1120)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (10, 1, 4, 1130)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (11, 1, 4, 1140)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (12, 1, 4, 1150)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (13, 1, 4, 1160)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (14, 1, 4, 1170)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (15, 1, 4, 1180)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (16, 1, 4, 1190)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (17, 1, 4, 1200)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (18, 1, 4, 1210)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (19, 1, 4, 1220)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (20, 1, 4, 1230)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (21, 1, 4, 3450)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (22, 1, 4, 3470)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (23, 1, 4, 1024)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (24, 1, 4, 1034)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (25, 1, 4, 1054)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (26, 1, 4, 1064)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (27, 1, 4, 1240)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (28, 1, 4, 3454)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (29, 1, 4, 3474)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (30, 1, 4, 3490)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (31, 1, 4, 3500)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (32, 1, 4, 3510)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (33, 1, 4, 3520)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (34, 1, 5, 1020)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (35, 1, 5, 1030)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (36, 1, 5, 1040)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (37, 1, 5, 1050)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (38, 1, 5, 1060)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (39, 1, 5, 1090)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (40, 1, 5, 1180)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (41, 1, 5, 1190)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (42, 1, 5, 3480)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (43, 1, 5, 3510)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (44, 1, 5, 1070)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (45, 1, 5, 1080)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (46, 1, 5, 1100)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (47, 1, 5, 1110)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (48, 1, 5, 1120)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (49, 1, 5, 1130)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (50, 1, 5, 1140)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (51, 1, 5, 1150)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (52, 1, 5, 1160)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (53, 1, 5, 1170)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (54, 1, 5, 1200)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (55, 1, 5, 1210)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (56, 1, 5, 1220)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (57, 1, 5, 1230)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (58, 1, 5, 3450)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (59, 1, 5, 3470)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (60, 1, 5, 1024)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (61, 1, 5, 1034)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (62, 1, 5, 1054)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (63, 1, 5, 1064)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (64, 1, 5, 1240)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (65, 1, 5, 3454)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (66, 1, 5, 3474)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (67, 1, 5, 1044)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (68, 1, 5, 1074)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (69, 1, 5, 3460)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (70, 1, 5, 3480)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (71, 1, 5, 3490)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (72, 1, 5, 3500)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (73, 1, 5, 3510)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (74, 1, 5, 3520)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (75, 1, 5, 3530)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (76, 1, 5, 3540)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (77, 1, 5, 3550)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (78, 1, 5, 3560)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (79, 3, 2, 140)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (80, 3, 2, 150)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (81, 3, 2, 240)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (82, 3, 2, 250)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (83, 3, 2, 3010)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (84, 3, 2, 3030)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (85, 3, 2, 3040)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (86, 3, 2, 3060)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (87, 3, 2, 3070)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (88, 3, 2, 3120)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (89, 3, 2, 3130)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (90, 3, 2, 3190)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (91, 3, 2, 3230)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (92, 3, 2, 3240)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (93, 3, 2, 4020)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (94, 3, 2, 4060)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (95, 3, 2, 4070)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (96, 3, 2, 4080)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (97, 3, 2, 4090)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (98, 3, 2, 4120)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (99, 3, 2, 4130)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (100, 3, 2, 4140)
GO
print 'Processed 100 total records'
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (101, 3, 2, 4320)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (102, 3, 2, 4330)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (103, 3, 2, 3110)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (104, 3, 2, 3122)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (105, 3, 2, 3140)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (106, 3, 2, 3200)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (107, 3, 2, 3220)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (108, 3, 2, 3250)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (109, 3, 2, 4010)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (110, 3, 2, 4040)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (111, 3, 2, 4110)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (112, 4, 2, 630)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (113, 4, 2, 2430)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (114, 5, 6, 1020)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (115, 5, 6, 1030)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (116, 5, 6, 1040)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (117, 5, 6, 1050)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (118, 5, 6, 1060)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (119, 5, 6, 1070)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (120, 5, 6, 1024)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (121, 5, 6, 1034)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (122, 5, 6, 1044)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (123, 5, 6, 1054)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (124, 5, 6, 1064)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (125, 5, 6, 1074)
INSERT [dbo].[rubros_inhibidos] ([id], [Pregunta], [Respuesta], [RubroFiscal]) VALUES (126, 5, 7, 1000)
SET IDENTITY_INSERT [dbo].[rubros_inhibidos] OFF
/****** Object:  Table [dbo].[CuentasRetenciones]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CuentasRetenciones]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CuentasRetenciones](
	[IdCuentaRetencion] [int] IDENTITY(1,1) NOT NULL,
	[CuentaContable] [nvarchar](60) NOT NULL,
	[IdRetencion] [int] NOT NULL,
	[Ejercicio] [int] NOT NULL,
 CONSTRAINT [PK_CuentasRetenciones] PRIMARY KEY CLUSTERED 
(
	[IdCuentaRetencion] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CuentaRubro]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CuentaRubro]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CuentaRubro](
	[CuentaContable] [nvarchar](60) NOT NULL,
	[Rubro] [int] NOT NULL,
 CONSTRAINT [PK_CuentaRubro] PRIMARY KEY CLUSTERED 
(
	[CuentaContable] ASC,
	[Rubro] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'CuentaRubro', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Almacena las asignaciones de rubros a cuentas contables' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CuentaRubro'
GO

/****** Object:  Table [dbo].[MovContables]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MovContables]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MovContables](
	[Empresa] [nvarchar](20) NOT NULL,
	[CuentaContable] [nvarchar](60) NOT NULL,
	[anio] [smallint] NOT NULL,
	[mes] [tinyint] NOT NULL,
	[cargo] [float] NULL,
	[abono] [float] NULL,
 CONSTRAINT [PK_MovContables] PRIMARY KEY CLUSTERED 
(
	[Empresa] ASC,
	[CuentaContable] ASC,
	[anio] ASC,
	[mes] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'MovContables', N'COLUMN',N'Empresa'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'identificador de la empresa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovContables', @level2type=N'COLUMN',@level2name=N'Empresa'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'MovContables', N'COLUMN',N'CuentaContable'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'numerod e la cuenta contable' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovContables', @level2type=N'COLUMN',@level2name=N'CuentaContable'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'MovContables', N'COLUMN',N'anio'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'anio en que se genero el movimiento contable' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovContables', @level2type=N'COLUMN',@level2name=N'anio'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'MovContables', N'COLUMN',N'mes'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'mes en que se genero el movimiento contable' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovContables', @level2type=N'COLUMN',@level2name=N'mes'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'MovContables', N'COLUMN',N'cargo'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'importe del cargo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovContables', @level2type=N'COLUMN',@level2name=N'cargo'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'MovContables', N'COLUMN',N'abono'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'importe del abono' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovContables', @level2type=N'COLUMN',@level2name=N'abono'
GO

/****** Object:  Default [DF_ElementoBasico_Estatus]    Script Date: 09/12/2012 03:04:57 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ElementoBasico_Estatus]') AND parent_object_id = OBJECT_ID(N'[dbo].[ElementoBasico]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ElementoBasico_Estatus]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ElementoBasico] ADD  CONSTRAINT [DF_ElementoBasico_Estatus]  DEFAULT ((1)) FOR [Estatus]
END


End
GO
/****** Object:  Default [DF_MovContables_cargo]    Script Date: 09/12/2012 03:04:57 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_MovContables_cargo]') AND parent_object_id = OBJECT_ID(N'[dbo].[MovContables]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_MovContables_cargo]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[MovContables] ADD  CONSTRAINT [DF_MovContables_cargo]  DEFAULT ((0)) FOR [cargo]
END


End
GO
/****** Object:  Default [DF_MovContables_abono]    Script Date: 09/12/2012 03:04:57 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_MovContables_abono]') AND parent_object_id = OBJECT_ID(N'[dbo].[MovContables]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_MovContables_abono]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[MovContables] ADD  CONSTRAINT [DF_MovContables_abono]  DEFAULT ((0)) FOR [abono]
END


End
GO
/****** Object:  Default [DF_RubrosFiscales_Estatus]    Script Date: 09/12/2012 03:04:57 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_RubrosFiscales_Estatus]') AND parent_object_id = OBJECT_ID(N'[dbo].[RubrosFiscales]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_RubrosFiscales_Estatus]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[RubrosFiscales] ADD  CONSTRAINT [DF_RubrosFiscales_Estatus]  DEFAULT ((1)) FOR [Estatus]
END


End
GO
/****** Object:  Default [DF_SaldosIni_saldoinicial]    Script Date: 09/12/2012 03:04:57 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_SaldosIni_saldoinicial]') AND parent_object_id = OBJECT_ID(N'[dbo].[SaldosIni]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SaldosIni_saldoinicial]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SaldosIni] ADD  CONSTRAINT [DF_SaldosIni_saldoinicial]  DEFAULT ((0)) FOR [saldoinicial]
END


End
GO
/****** Object:  ForeignKey [FK_BaseCalculoRubroFiscal_BasesDeCalculo]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BaseCalculoRubroFiscal_BasesDeCalculo]') AND parent_object_id = OBJECT_ID(N'[dbo].[BaseCalculoRubroFiscal]'))
ALTER TABLE [dbo].[BaseCalculoRubroFiscal]  WITH CHECK ADD  CONSTRAINT [FK_BaseCalculoRubroFiscal_BasesDeCalculo] FOREIGN KEY([idBaseDeCalculo])
REFERENCES [dbo].[BasesDeCalculo] ([idBaseDeCalculo])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BaseCalculoRubroFiscal_BasesDeCalculo]') AND parent_object_id = OBJECT_ID(N'[dbo].[BaseCalculoRubroFiscal]'))
ALTER TABLE [dbo].[BaseCalculoRubroFiscal] CHECK CONSTRAINT [FK_BaseCalculoRubroFiscal_BasesDeCalculo]
GO
/****** Object:  ForeignKey [FK_BaseCalculoRubroFiscal_RubrosFiscales]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BaseCalculoRubroFiscal_RubrosFiscales]') AND parent_object_id = OBJECT_ID(N'[dbo].[BaseCalculoRubroFiscal]'))
ALTER TABLE [dbo].[BaseCalculoRubroFiscal]  WITH CHECK ADD  CONSTRAINT [FK_BaseCalculoRubroFiscal_RubrosFiscales] FOREIGN KEY([Rubro])
REFERENCES [dbo].[RubrosFiscales] ([Rubro])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BaseCalculoRubroFiscal_RubrosFiscales]') AND parent_object_id = OBJECT_ID(N'[dbo].[BaseCalculoRubroFiscal]'))
ALTER TABLE [dbo].[BaseCalculoRubroFiscal] CHECK CONSTRAINT [FK_BaseCalculoRubroFiscal_RubrosFiscales]
GO
/****** Object:  ForeignKey [FK_CuentasRetenciones_CatRetenciones]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CuentasRetenciones_CatRetenciones]') AND parent_object_id = OBJECT_ID(N'[dbo].[CuentasRetenciones]'))
ALTER TABLE [dbo].[CuentasRetenciones]  WITH CHECK ADD  CONSTRAINT [FK_CuentasRetenciones_CatRetenciones] FOREIGN KEY([IdRetencion])
REFERENCES [dbo].[CatRetenciones] ([IdRetencion])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CuentasRetenciones_CatRetenciones]') AND parent_object_id = OBJECT_ID(N'[dbo].[CuentasRetenciones]'))
ALTER TABLE [dbo].[CuentasRetenciones] CHECK CONSTRAINT [FK_CuentasRetenciones_CatRetenciones]
GO
/****** Object:  ForeignKey [FK_CuentasRetenciones_CuentasContables]    Script Date: 09/12/2012 03:04:57 ******/
/*Comentado la creacion del indice, para evitar la integridad referencial
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CuentasRetenciones_CuentasContables]') AND parent_object_id = OBJECT_ID(N'[dbo].[CuentasRetenciones]'))
ALTER TABLE [dbo].[CuentasRetenciones]  WITH CHECK ADD  CONSTRAINT [FK_CuentasRetenciones_CuentasContables] FOREIGN KEY([CuentaContable])
REFERENCES [dbo].[CuentasContables] ([CuentaContable])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CuentasRetenciones_CuentasContables]') AND parent_object_id = OBJECT_ID(N'[dbo].[CuentasRetenciones]'))
ALTER TABLE [dbo].[CuentasRetenciones] CHECK CONSTRAINT [FK_CuentasRetenciones_CuentasContables]
GO
*/
/****** Object:  ForeignKey [FK_CuentaRubro_CuentasContables]    Script Date: 09/12/2012 03:04:57 ******/
/*Comentado la creacion del indice para evitar la integridad referencial
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CuentaRubro_CuentasContables]') AND parent_object_id = OBJECT_ID(N'[dbo].[CuentaRubro]'))
ALTER TABLE [dbo].[CuentaRubro]  WITH CHECK ADD  CONSTRAINT [FK_CuentaRubro_CuentasContables] FOREIGN KEY([CuentaContable])
REFERENCES [dbo].[CuentasContables] ([CuentaContable])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CuentaRubro_CuentasContables]') AND parent_object_id = OBJECT_ID(N'[dbo].[CuentaRubro]'))
ALTER TABLE [dbo].[CuentaRubro] CHECK CONSTRAINT [FK_CuentaRubro_CuentasContables]
GO
*/
/****** Object:  ForeignKey [FK_CuentaRubro_RubrosFiscales]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CuentaRubro_RubrosFiscales]') AND parent_object_id = OBJECT_ID(N'[dbo].[CuentaRubro]'))
ALTER TABLE [dbo].[CuentaRubro]  WITH CHECK ADD  CONSTRAINT [FK_CuentaRubro_RubrosFiscales] FOREIGN KEY([Rubro])
REFERENCES [dbo].[RubrosFiscales] ([Rubro])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CuentaRubro_RubrosFiscales]') AND parent_object_id = OBJECT_ID(N'[dbo].[CuentaRubro]'))
ALTER TABLE [dbo].[CuentaRubro] CHECK CONSTRAINT [FK_CuentaRubro_RubrosFiscales]
GO
/****** Object:  ForeignKey [FK_ElementoBasicoSub_ElementoBasico]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ElementoBasicoSub_ElementoBasico]') AND parent_object_id = OBJECT_ID(N'[dbo].[ElementoBasicoSub]'))
ALTER TABLE [dbo].[ElementoBasicoSub]  WITH CHECK ADD  CONSTRAINT [FK_ElementoBasicoSub_ElementoBasico] FOREIGN KEY([IdElementoBasico])
REFERENCES [dbo].[ElementoBasico] ([IdElementoBasico])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ElementoBasicoSub_ElementoBasico]') AND parent_object_id = OBJECT_ID(N'[dbo].[ElementoBasicoSub]'))
ALTER TABLE [dbo].[ElementoBasicoSub] CHECK CONSTRAINT [FK_ElementoBasicoSub_ElementoBasico]
GO
/****** Object:  ForeignKey [FK_Empresa_inhibido]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Empresa_inhibido]') AND parent_object_id = OBJECT_ID(N'[dbo].[empresa_respuesta]'))
ALTER TABLE [dbo].[empresa_respuesta]  WITH CHECK ADD  CONSTRAINT [FK_Empresa_inhibido] FOREIGN KEY([Empresa])
REFERENCES [dbo].[Empresa] ([Empresa])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Empresa_inhibido]') AND parent_object_id = OBJECT_ID(N'[dbo].[empresa_respuesta]'))
ALTER TABLE [dbo].[empresa_respuesta] CHECK CONSTRAINT [FK_Empresa_inhibido]
GO
/****** Object:  ForeignKey [FK_Pregunta_inhibido]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Pregunta_inhibido]') AND parent_object_id = OBJECT_ID(N'[dbo].[empresa_respuesta]'))
ALTER TABLE [dbo].[empresa_respuesta]  WITH CHECK ADD  CONSTRAINT [FK_Pregunta_inhibido] FOREIGN KEY([Pregunta])
REFERENCES [dbo].[preguntas_inhibicion] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Pregunta_inhibido]') AND parent_object_id = OBJECT_ID(N'[dbo].[empresa_respuesta]'))
ALTER TABLE [dbo].[empresa_respuesta] CHECK CONSTRAINT [FK_Pregunta_inhibido]
GO
/****** Object:  ForeignKey [FK_Respuesta_inhibido]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Respuesta_inhibido]') AND parent_object_id = OBJECT_ID(N'[dbo].[empresa_respuesta]'))
ALTER TABLE [dbo].[empresa_respuesta]  WITH CHECK ADD  CONSTRAINT [FK_Respuesta_inhibido] FOREIGN KEY([Respuesta])
REFERENCES [dbo].[respuestas_inhibicion] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Respuesta_inhibido]') AND parent_object_id = OBJECT_ID(N'[dbo].[empresa_respuesta]'))
ALTER TABLE [dbo].[empresa_respuesta] CHECK CONSTRAINT [FK_Respuesta_inhibido]
GO
/****** Object:  ForeignKey [FK_MovContables_CuentasContables]    Script Date: 09/12/2012 03:04:57 ******/
/*Evitar la integridad referencial, permitir truncate
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MovContables_CuentasContables]') AND parent_object_id = OBJECT_ID(N'[dbo].[MovContables]'))
ALTER TABLE [dbo].[MovContables]  WITH CHECK ADD  CONSTRAINT [FK_MovContables_CuentasContables] FOREIGN KEY([CuentaContable])
REFERENCES [dbo].[CuentasContables] ([CuentaContable])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MovContables_CuentasContables]') AND parent_object_id = OBJECT_ID(N'[dbo].[MovContables]'))
ALTER TABLE [dbo].[MovContables] CHECK CONSTRAINT [FK_MovContables_CuentasContables]
GO
*/
/****** Object:  ForeignKey [FK_ReporteBaseCalculo_BasesDeCalculo]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ReporteBaseCalculo_BasesDeCalculo]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReporteBaseCalculo]'))
ALTER TABLE [dbo].[ReporteBaseCalculo]  WITH CHECK ADD  CONSTRAINT [FK_ReporteBaseCalculo_BasesDeCalculo] FOREIGN KEY([idBaseDeCalculo])
REFERENCES [dbo].[BasesDeCalculo] ([idBaseDeCalculo])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ReporteBaseCalculo_BasesDeCalculo]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReporteBaseCalculo]'))
ALTER TABLE [dbo].[ReporteBaseCalculo] CHECK CONSTRAINT [FK_ReporteBaseCalculo_BasesDeCalculo]
GO
/****** Object:  ForeignKey [FK_ReporteBaseCalculo_Reportes]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ReporteBaseCalculo_Reportes]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReporteBaseCalculo]'))
ALTER TABLE [dbo].[ReporteBaseCalculo]  WITH CHECK ADD  CONSTRAINT [FK_ReporteBaseCalculo_Reportes] FOREIGN KEY([Reporte])
REFERENCES [dbo].[Reportes] ([Reporte])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ReporteBaseCalculo_Reportes]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReporteBaseCalculo]'))
ALTER TABLE [dbo].[ReporteBaseCalculo] CHECK CONSTRAINT [FK_ReporteBaseCalculo_Reportes]
GO
/****** Object:  ForeignKey [FK_RubrosFiscales_RubrosFiscales]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RubrosFiscales_RubrosFiscales]') AND parent_object_id = OBJECT_ID(N'[dbo].[RubrosFiscales]'))
ALTER TABLE [dbo].[RubrosFiscales]  WITH CHECK ADD  CONSTRAINT [FK_RubrosFiscales_RubrosFiscales] FOREIGN KEY([Rubro])
REFERENCES [dbo].[RubrosFiscales] ([Rubro])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RubrosFiscales_RubrosFiscales]') AND parent_object_id = OBJECT_ID(N'[dbo].[RubrosFiscales]'))
ALTER TABLE [dbo].[RubrosFiscales] CHECK CONSTRAINT [FK_RubrosFiscales_RubrosFiscales]
GO
/****** Object:  ForeignKey [FK_PreguntasInh]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_PreguntasInh]') AND parent_object_id = OBJECT_ID(N'[dbo].[rubros_inhibidos]'))
ALTER TABLE [dbo].[rubros_inhibidos]  WITH CHECK ADD  CONSTRAINT [FK_PreguntasInh] FOREIGN KEY([Pregunta])
REFERENCES [dbo].[preguntas_inhibicion] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_PreguntasInh]') AND parent_object_id = OBJECT_ID(N'[dbo].[rubros_inhibidos]'))
ALTER TABLE [dbo].[rubros_inhibidos] CHECK CONSTRAINT [FK_PreguntasInh]
GO
/****** Object:  ForeignKey [FK_RespuestasInh]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RespuestasInh]') AND parent_object_id = OBJECT_ID(N'[dbo].[rubros_inhibidos]'))
ALTER TABLE [dbo].[rubros_inhibidos]  WITH CHECK ADD  CONSTRAINT [FK_RespuestasInh] FOREIGN KEY([Respuesta])
REFERENCES [dbo].[respuestas_inhibicion] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RespuestasInh]') AND parent_object_id = OBJECT_ID(N'[dbo].[rubros_inhibidos]'))
ALTER TABLE [dbo].[rubros_inhibidos] CHECK CONSTRAINT [FK_RespuestasInh]
GO
/****** Object:  ForeignKey [FK_RubrosInh]    Script Date: 09/12/2012 03:04:57 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RubrosInh]') AND parent_object_id = OBJECT_ID(N'[dbo].[rubros_inhibidos]'))
ALTER TABLE [dbo].[rubros_inhibidos]  WITH CHECK ADD  CONSTRAINT [FK_RubrosInh] FOREIGN KEY([RubroFiscal])
REFERENCES [dbo].[RubrosFiscales] ([Rubro])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RubrosInh]') AND parent_object_id = OBJECT_ID(N'[dbo].[rubros_inhibidos]'))
ALTER TABLE [dbo].[rubros_inhibidos] CHECK CONSTRAINT [FK_RubrosInh]
GO
/****** Object:  ForeignKey [FK_SaldosIni_CuentasContables]    Script Date: 09/12/2012 03:04:57 ******/
/*Evitar la integridad referencial, permitir truncate
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SaldosIni_CuentasContables]') AND parent_object_id = OBJECT_ID(N'[dbo].[SaldosIni]'))
ALTER TABLE [dbo].[SaldosIni]  WITH CHECK ADD  CONSTRAINT [FK_SaldosIni_CuentasContables] FOREIGN KEY([CuentaContable])
REFERENCES [dbo].[CuentasContables] ([CuentaContable])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SaldosIni_CuentasContables]') AND parent_object_id = OBJECT_ID(N'[dbo].[SaldosIni]'))
ALTER TABLE [dbo].[SaldosIni] CHECK CONSTRAINT [FK_SaldosIni_CuentasContables]
GO
*/
/****** Object:  ForeignKey [FK_PartidaFinanciera_ElementoBasico]    Script Date: 09/12/2012 03:21:41 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_PartidaFinanciera_ElementoBasico]') AND parent_object_id = OBJECT_ID(N'[dbo].[PartidaFinanciera]'))
ALTER TABLE [dbo].[PartidaFinanciera] DROP CONSTRAINT [FK_PartidaFinanciera_ElementoBasico]
GO
/****** Object:  Table [dbo].[PartidaFinanciera]    Script Date: 09/12/2012 03:21:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PartidaFinanciera]') AND type in (N'U'))
DROP TABLE [dbo].[PartidaFinanciera]
GO
/****** Object:  Table [dbo].[PartidaFinanciera]    Script Date: 09/12/2012 03:21:41 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PartidaFinanciera]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PartidaFinanciera](
	[IdPartida] [int] IDENTITY(1,1) NOT NULL,
	[Clave] [int] NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[IdElementoBasico] [int] NOT NULL,
	[Descripcion] [text] NULL,
 CONSTRAINT [PK_PartidaFinanciera] PRIMARY KEY CLUSTERED 
(
	[IdPartida] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_PartidaFinanciera] UNIQUE NONCLUSTERED 
(
	[Clave] ASC,
	[IdElementoBasico] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'PartidaFinanciera', N'COLUMN',N'IdPartida'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'identificador unico de la tabla' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PartidaFinanciera', @level2type=N'COLUMN',@level2name=N'IdPartida'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'PartidaFinanciera', N'COLUMN',N'Clave'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'clave de la partida financiera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PartidaFinanciera', @level2type=N'COLUMN',@level2name=N'Clave'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'PartidaFinanciera', N'COLUMN',N'Nombre'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre de la partida financiera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PartidaFinanciera', @level2type=N'COLUMN',@level2name=N'Nombre'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'PartidaFinanciera', N'COLUMN',N'IdElementoBasico'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Elemento basico a la que corresponde la partida financiera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PartidaFinanciera', @level2type=N'COLUMN',@level2name=N'IdElementoBasico'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'PartidaFinanciera', N'COLUMN',N'Descripcion'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Descripcion detallada de la partida financiera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PartidaFinanciera', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
SET IDENTITY_INSERT [dbo].[PartidaFinanciera] ON
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (1, 1, N'Efectivo', 1, N'Definición: Moneda de curso legal o sus equivalentes, tales como: depósitos bancarios en cuentas de cheques, giros bancarios, telegráficos o postales, monedas extranjeras y metales preciosos amonedados.
tipo de cuenta: activos
naturaleza: deudora
movimientos comunes: deudores y acreedores
principios de contabilidad: boletín c-1 efectivo e inversiones temporales
no confundir con: inversiones temporales')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (2, 2, N'Inversiones temporales', 1, N'Definición: Valores negociables, o cualquier otro instrumento de inversión, convertibles en efectivo a corto plazo cuyo objetivo es obtener un rendimiento hasta el momento en que estos recursos sean utilizados.
tipo de cuenta: activos
naturaleza: deudora
movimientos comunes: deudores y acreedores
principios de contabilidad: boletín c-1 efectivo e inversiones temporales
no confundir con: inversiones a largo plazo o acciones')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (3, 3, N'Documentos y Cuentas por Cobrar', 1, N'Definición: Derechos exigibles a clientes originados por ventas, prestación de servicios, que representen la actividad normal de la empresa 
tipo de cuenta: activos
naturaleza: deudora
movimientos comunes: deudores y acreedores
principios de contabilidad: boletín c-3 cuentas por cobrar
no confundir con: otras cuentas por cobrar')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (4, 4, N'Reserva para cuentas de cobro dudoso', 1, N'Definición: Estimaciones para cuentas incobrables, descuentos, bonificaciones, etc.
tipo de cuenta: activos
naturaleza: acreedora
movimientos comunes: acreedores y deudores
principios de contabilidad: boletín c-3 cuentas por cobrar')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (5, 5, N'Anticipo de contribuciones', 1, N'Definición: Derechos de recuperación del IVA pagado en la adquisición de bienes y servicios a terceros. También se conoce como IVA acreditable.
tipo de cuenta: activos
naturaleza: acreedora
movimientos comunes: acreedores
principios de contabilidad: boletín c-3 cuentas por cobrar
está relacionada con las cuentas de iva pagado y cuentas por pagar - iva')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (6, 6, N'Contribuciones a Favor', 1, N'Definición: Cuenta usada exclusivamente para registrar los pagos del ISR.
tipo de cuenta: activos
naturaleza: acreedora
movimientos comunes: acreedores
está relacionada con cuentas por pagar - isr')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (7, 7, N'Inventarios de Productos Terminados', 1, N'Definición: Erogaciones efectuadas por servicios que se van a recibir o por bienes que se van a consumir en el uso exclusivo de la empresa y cuyo propósito no es el de venderlos ni utilizarlos en el proceso productivo.
tipo de cuenta: activos
movimientos comunes: deudores y acreedores
principios de contabilidad: boletín c-5 pagos anticipados
no confundir con: anticipos a proveedores')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (8, 8, N'Inventarios de materia prima', 1, N'Definición: Artículos que adquiere una empresa industrial para ser usados en el proceso de producción de los bienes destinados a la venta.
tipo de cuenta: activos
movimientos comunes: deudores (con el método de inventarios periódicos). deudores y acreedores (con el método de inventarios perpetuos)
principios de contabilidad: boletín c-4 inventarios')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (9, 9, N'Inventarios de productos en proceso', 1, N'Definición: Artículos que aún no están terminados al momento del corte de operaciones de la contabilidad y que forman parte del proceso de fabricación de productos destinados a la venta de una empresa industrial.
tipo de cuenta: activos
movimientos comunes: deudores (con el método de inventarios periódicos). deudores y acreedores (con el método de inventarios perpetuos)
principios de contabilidad: boletín c-4 inventarios')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (10, 10, N'Activos fijos', 1, N'Definición: Son bienes tangibles que tienen por objeto
a) el uso o usufructo de los mismos en beneficio de la empresa 
b) la producción de artículos para su venta o para el uso de la propia empresa y 
c) la prestación de servicios a la empresa, a su clientela o al publico en general.
tipo de cuenta: activos
naturaleza: deudora
movimientos comunes: deudores y acreedores
principios de contabilidad: boletín c-6 inmuebles, maquinaria y equipo')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (11, 11, N'Activos diferidos y gastos de organización', 1, N'Definición: Representan un derecho, por erogaciones efectuadas en el pasado, a recibir servicios necesarios para producir, en el futuro, beneficios económicos fundadamente esperados 
tipo de cuenta: activos
naturaleza: deudora
movimientos comunes: deudores y acreedores
principios de contabilidad: boletín a-11 definición de los conceptos básicos integrantes de los estados financieros')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (12, 12, N'Depreciación y amortización acumulada', 1, N'Definición: La depreciación es un procedimiento de contabilidad cuyo fin es distribuir sistemática y razonablemente el costo de los activos fijos tangibles, menos su valor de desecho, si lo tienen, entre la vida útil estimada de la unidad. la amortización es la reducción gradual en libros de bienes intangibles durante un periodo de tiempo determinado.
tipo de cuenta: activos
naturaleza: acreedora
movimientos comunes: acreedores
principios de contabilidad: boletín c-6 inmuebles, maquinaria y equipo')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (13, 13, N'Inversiones en acciones', 1, N'Definición: Inversiones en valores bursátiles y en otros bienes o derechos de propiedad en cartera, pero no destinados para su venta, y por lo tanto, excluidos de la clasificación de inversiones temporales.
tipo de cuenta: activos
naturaleza: deudora
movimientos comunes: deudores y acreedores')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (14, 14, N'IVA Acreditable', 1, N'Definición: Cuenta usada exclusivamente para registrar los pagos de IVA por conceptos de erogaciones gravadas
tipo de cuenta: activos
naturaleza: deudora
movimientos comunes: deudores
está relacionada con cuentas por cobrar')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (15, 1, N'Capital Social', 3, N'Definición: Es el derecho de los propietarios sobre los activos netos que surge por aportaciones de los dueños, por transacciones y otros eventos o circunstancias que afectan una entidad y el cual se ejerce mediante reembolso o distribución
principios contables: boletín a-11 definición de los conceptos básicos integrantes de los estados financieros
definición: es el derecho de los propietarios sobre los activos netos de una entidad, de acuerdo a su origen esta formado por capital contribuido y capital ganado o déficit, en su caso
tipo de cuenta: capital
naturaleza: acreedora
principios de contabilidad: boletín c-11 capital contable')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (16, 2, N'Actualización del capital', 3, N'Definición: Capitalización por la revaluación de activos fijos
tipo de cuenta: capital
naturaleza: acreedora
movimientos comunes: acreedores y deudores
principios de contabilidad: boletín b-10 reconocimiento de los efectos de la inflación en la información financiera')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (17, 3, N'Aportaciones para futuros aumentos de capital', 3, N'Definición: Anticipo de socios o accionistas para futuros aumentos al capital social 
tipo de cuenta: capital 
naturaleza: acreedora
movimientos comunes: acreedores y deudores
principios de contabilidad: boletín c-11 capital contable')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (18, 4, N'Resultados de ejercicios anteriores', 3, N'Definición: Capital ganado o déficit correspondiente al resultado de las actividades operativas de la entidad y de otros eventos o circunstancias que le afecten en periodos fiscales anteriores 
tipo de cuenta: capital
naturaleza: acreedora 
movimientos comunes: acreedores y deudores
principios de contabilidad: boletín c-11 capital contable')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (19, 5, N'Reservas y otras cuentas de capital', 3, N'Definición: Capital ganado o déficit correspondiente al resultado de las actividades operativas de la entidad y de otros eventos o circunstancias que le afecten durante un periodo contable* 
tipo de cuenta: capital
naturaleza: acreedora
movimientos comunes: acreedores y deudores
principios de contabilidad: boletín c-11 capital contable
*es el lapso convencional en que se subdivide la vida de la entidad y a cuyo termino se formulan estados financieros básicos
boletín a-11 definición de los conceptos básicos integrantes de los estados financieros')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (20, 1, N'Intereses a cargo y perdida cambiaria', 8, N'Definición: Gastos distintos a los de operación que se identifican principalmente con las operaciones financieras de la empresa
tipo de cuenta: gastos eventuales
naturaleza: deudora
movimientos comunes: deudores
principios de contabilidad: boletín b-3 estado de resultados')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (21, 2, N'Otros Gastos', 8, N'Definición: Gastos distintos a los de operación resultado de transacciones inusuales e infrecuentes o de una actividad no primaria de la empresa
tipo de cuenta: gastos eventuales
naturaleza: deudora
movimientos comunes: deudores
principios de contabilidad: boletín b-3 estado de resultados')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (22, 1, N'Salarios y prestaciones de gastos de operación', 6, N'Definición: El total de salarios pagaderos en relación con un periodo de tiempo 
tipo de cuenta: gastos
naturaleza: deudora
movimientos comunes: deudores
principios de contabilidad:')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (23, 2, N'Depreciaciones y amortizaciones de gastos de operación', 6, N'Definición: Depreciación es la disminución de valor o precio que sufre un bien tangible por causa del uso o transcurso del tiempo. Amortización es cada una de las partes en que se divide un valor en su proceso de extinción  
tipo de cuenta: gastos
naturaleza: deudora
movimientos comunes: deudores
principios de contabilidad:')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (24, 3, N'Otros gastos de operación', 6, N'Definición: Gastos correspondientes a la operación de una empresa
tipo de cuenta: gastos
naturaleza: deudora
movimientos comunes: deudores
principios de contabilidad:')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (25, 1, N'Intereses a favor y ganancia cambiaria', 7, N'Definición: Ingresos distintos a los de operación que se identifican principalmente con las operaciones financieras de la empresa  
tipo de cuenta: productos eventuales
naturaleza: acreedora
movimientos comunes: acreedores
principios de contabilidad: boletín b-3 estado de resultados')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (26, 2, N'Otros Ingresos', 7, N'Definición: Ingresos distintos a los de operación resultado de transacciones inusuales e infrecuentes o de una actividad no primaria de la empresa  
tipo de cuenta: productos eventuales
naturaleza: acreedora
movimientos comunes: acreedores
principios de contabilidad: boletín b-3 estado de resultados')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (27, 1, N'Provisión de impuestos y PTU', 9, N'Definición: 
tipo de cuenta: impuestos
naturaleza: deudora
movimientos comunes: deudores
principios de contabilidad:')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (28, 1, N'Cuentas de Orden', 10, N'Definición:
tipo de cuenta: orden
naturaleza: 
movimientos comunes: deudores y acreedores
principios de contabilidad:')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (29, 1, N'Cobros anticipados', 2, N'Definición: Importe recibido de clientes a cuenta de futuras ventas de mercancías o prestación de servicios
tipo de cuenta: pasivos
naturaleza: acreedora
movimientos comunes: acreedores y deudores
principios de contabilidad: boletín c-9 pasivo')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (30, 2, N'Cuentas por pagar (Proveedores de bienes y servicios)', 2, N'Definición: Deudas con proveedores por la adquisición de bienes que se destinarán a la venta como parte de las operaciones normales de la empresa.
tipo de cuenta: pasivos
naturaleza: acreedora
movimientos comunes: acreedores y deudores
principios de contabilidad: boletín c-9 pasivo')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (31, 3, N'Impuestos por pagar', 2, N'Definición: Deudas provenientes de obligaciones contractuales
tipo de cuenta: pasivos
naturaleza: acreedora
movimientos comunes: acreedores y deudores
principios de contabilidad: boletín c-9 pasivo')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (32, 4, N'Cuentas por pagar (Sistema financiero)', 2, N'Definición: Deudas por prestamos de instituciones de crédito
tipo de cuenta: pasivos
naturaleza: acreedora
movimientos comunes: acreedores y deudores
principios de contabilidad: boletín c-9 pasivo')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (33, 5, N'Otras cuentas por pagar', 2, N'Definición: Otras deudas, como: prestamos de particulares, de compañías filiales, de accionistas o funcionarios, etc. o ciertos casos de obligaciones provenientes de operaciones bancarias de descuento de documentos
tipo de cuenta: pasivos
naturaleza: acreedora
movimientos comunes: acreedores y deudores
principios de contabilidad: boletín c-9 pasivo')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (34, 6, N'IVA Trasladado', 2, N'Definición: Cuenta usada exclusivamente para registrar los cobros de IVA por concepto de ventas y otros ingresos, gravados
tipo de cuenta: pasivos
naturaleza: acreedora
movimientos comunes: acreedores y deudores')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (35, 1, N'Compras', 5, N'Definición: Adquisición de materia prima o artículos para su venta
tipo de cuenta: costos
naturaleza: deudora
movimientos comunes: deudores
principios de contabilidad:')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (36, 2, N'Gastos de fabricación, mano de obra y prestaciones', 5, N'Definición: Es el pago de sueldos y salarios correspondientes a los gastos de fabricación de la empresa  
tipo de cuenta: costos
naturaleza: deudora
movimientos comunes: deudores
principios de contabilidad:')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (37, 3, N'Gastos de fabricación, depreciaciones y amortizaciones', 5, N'Definición: Depreciación es la disminución de valor o precio que sufre un bien tangible por causa del uso o transcurso del tiempo. Amortización es cada una de las partes en que se divide un valor en su proceso de extinción
tipo de cuenta: costos
naturaleza: deudora
movimientos comunes: deudores
principios de contabilidad:')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (38, 4, N'Otros Gastos de fabricación', 5, N'Definición: Gastos que afectan directamente a la producción de una empresa 
tipo de cuenta: costos
naturaleza: deudora
movimientos comunes: deudores
principios de contabilidad:')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (39, 5, N'Costo de ventas', 5, N'Definición: Gastos que afectan directamente a la producción de una empresa 
tipo de cuenta: costos
naturaleza: deudora
movimientos comunes: deudores
principios de contabilidad:')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (40, 1, N'Ventas', 4, N'Definición: Ingresos brutos obtenidos como resultado de las actividades primarias o normales de una entidad
tipo de cuenta: ingresos 
naturaleza: acreedora
movimientos comunes: acreedores
principios de contabilidad: boletín a-11 definición de los conceptos básicos integrantes de los estados financieros y boletín b-3 estado de resultados')
INSERT [dbo].[PartidaFinanciera] ([IdPartida], [Clave], [Nombre], [IdElementoBasico], [Descripcion]) VALUES (41, 2, N'Devoluciones, rebajas y descuentos sobre ventas', 4, N'Definición: Ajuste a los ingresos por descuentos ofrecidos a los clientes, rebajas derivadas de negociaciones posteriores al reconocimiento de la venta y devoluciones
tipo de cuenta: ingresos
naturaleza: deudora
movimientos comunes: deudores
principios de contabilidad: boletín a-11 definición de los conceptos básicos integrantes de los estados financieros y boletín b-3 estado de resultados')
SET IDENTITY_INSERT [dbo].[PartidaFinanciera] OFF
/****** Object:  ForeignKey [FK_PartidaFinanciera_ElementoBasico]    Script Date: 09/12/2012 03:21:41 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_PartidaFinanciera_ElementoBasico]') AND parent_object_id = OBJECT_ID(N'[dbo].[PartidaFinanciera]'))
ALTER TABLE [dbo].[PartidaFinanciera]  WITH CHECK ADD  CONSTRAINT [FK_PartidaFinanciera_ElementoBasico] FOREIGN KEY([IdElementoBasico])
REFERENCES [dbo].[ElementoBasico] ([IdElementoBasico])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_PartidaFinanciera_ElementoBasico]') AND parent_object_id = OBJECT_ID(N'[dbo].[PartidaFinanciera]'))
ALTER TABLE [dbo].[PartidaFinanciera] CHECK CONSTRAINT [FK_PartidaFinanciera_ElementoBasico]
GO
/*--------------------------------------------Stored Procedures---------------------------------------------------*/
/****** Object:  StoredProcedure [dbo].[spMFAObtenerCuentasContables]    Script Date: 09/12/2012 03:26:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spMFAObtenerCuentasContables]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spMFAObtenerCuentasContables]
GO
/****** Object:  StoredProcedure [dbo].[spMFAObtenerSaldosCuentas]    Script Date: 09/12/2012 03:26:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spMFAObtenerSaldosCuentas]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spMFAObtenerSaldosCuentas]
GO
/****** Object:  StoredProcedure [dbo].[getBaseCalculoISR]    Script Date: 09/12/2012 03:26:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[getBaseCalculoISR]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[getBaseCalculoISR]
GO
/****** Object:  StoredProcedure [dbo].[getBaseCalculoISR]    Script Date: 09/12/2012 03:26:24 ******/
--drop procedure dbo.getBaseCalculoISR
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[getBaseCalculoISR]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Create date: 07/06/2012
-- Description:	Sp que devuelve los importes de las bases de calculo
-- v1 - corregido los apostro para hacer el select a la clave de la empresa
-- v2 - Corregido para que la clave que recibe de parametro no es el idbasedecalculo...es la claveBC
-- =============================================
CREATE PROCEDURE [dbo].[getBaseCalculoISR]
	@idempresa			as nvarchar(20),		--id de la empresa a consultar
	@anio				as smallint,	--anio del movimiento a consultar
	@mes				as tinyint,		--mes del movimiento a consultar
	@idbc				as bigint,		--id de la base de calculo
	@idreporte			as bigint,		--id del reporte de que se trate
	@saldofin			as nvarchar(4),	--indica se se obtendra el saldo final acumulado unicamente hasta el mes que se indique (true 1 o false 0)
	@saldoini			as nvarchar(4),	--indica se se obtendra el saldo inicial unicamente (true 1 o false 0)
	@cargo				as nvarchar(4),	--indica se se obtendra el cargo acumulado unicamente hasta el mes que se indique (true 1 o false 0)
	@abono				as nvarchar(4),	--indica se se obtendra el abono acumulado unicamente hasta el mes que se indique (true 1 o false 0)
	@saldomes			as nvarchar(4)	--indica si se obtendrá solo el importe del mes que se indique (true 1) o no relacionada (false 0)
WITH ENCRYPTION	
AS
BEGIN
	declare	@campo nvarchar(200)
	declare @where nvarchar(200)=''''
	declare @sql nvarchar(2000)
	declare @operador nvarchar(2)=''<=''

		--  =================
		--	validamos el campo que se desea devolver, una base de calculo solo necesita uno de los cuatro campos
		--	(saldofi,saldoini,cargo ó abono), se debe cumplir solo una condicion.
		--  si por error se enciende las 4 banderas, toma la primera condicion que se cumpla.
		--	=================
			if (@saldofin=''1'')
				set @campo = ''sum(isnull(si.SaldoInicial,0) + isnull(mm.Cargo,0) - isnull(mm.Abono,0)) as importe''
			else 
				if (@saldoini=''1'')
					set @campo =''sum(isnull(si.SaldoInicial,0)) as importe''
				else 
					if (@cargo=''1'')
						set @campo =''sum(isnull(mm.Cargo,0)) as importe''
					else
						if (@abono=''1'')
							set @campo=''sum(isnull(mm.Abono,0)) as importe''
						else
							set @campo=''0 as importe''
		
			if(DATALENGTH(@saldomes)!=0)
			begin
				if(@saldomes=''1'')
					set @operador=''=''
				else
					set @operador=''<=''
			end
			
			set @sql=''
			select  bc.Reporte,bct.idBaseDeCalculo,ct.rubro, '' + @campo + ''
				from	/*		Reportes rep 
					inner join  ReporteBaseCalculo rbc 
								on rep.Reporte=rbc.Reporte		 
					inner join */ BasesDeCalculo bc 
								/*on rbc.idBaseDeCalculo=bc.idBaseDeCalculo*/
					inner join  BaseCalculoRubroFiscal bct 
								on bc.idBaseDeCalculo=bct.idBaseDeCalculo
					inner join  RubrosFiscales ct 
								on bct.rubro=ct.rubro 
					inner join CuentaRubro cr
								on ct.Rubro = cr.rubro
					inner join  CuentasContables cc 
								on cr.CuentaContable=cc.CuentaContable
					left join   SaldosIni si 
								on cc.CuentaContable=si.CuentaContable and si.Empresa='''''' + @idempresa + ''''''  and si.Anio='' + cast(@anio as nvarchar(4))  +''
					left join   MovContables mm 
								on cc.CuentaContable=mm.CuentaContable and mm.Empresa='''''' + @idempresa + ''''''  and mm.Anio='' + cast(@anio as nvarchar(4)) + '' and mm.Mes''+ @operador + cast(@mes as nvarchar(2)) +''
				where  bc.Reporte='' + cast(@idreporte as nvarchar(5)) + ''
					   /*--and rbc.idBaseDeCalculo=cast(@idbc as nvarchar(5))-- */
					  and bc.ClaveBC = '' + cast(@idbc as nvarchar(5)) + ''
					   and upper(cc.clase)=''''''+''R''+''''''
				group by bc.Reporte,bct.idBaseDeCalculo,ct.rubro
				order by bc.Reporte,bct.idBaseDeCalculo,ct.rubro''
				begin try
					exec(@sql)
				end try
				begin catch
					  SELECT
						ERROR_NUMBER() AS Numero_de_Error,
						ERROR_SEVERITY() AS Gravedad_del_Error,
						ERROR_STATE() AS Estado_del_Error,
						ERROR_PROCEDURE() AS Procedimiento_del_Error,
						ERROR_LINE() AS Linea_de_Error,
						ERROR_MESSAGE() AS Mensaje_de_Error;
				end catch
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[spMFAObtenerSaldosCuentas]    Script Date: 09/12/2012 03:26:24 ******/
--drop procedure dbo.spMFAObtenerSaldosCuentas
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spMFAObtenerSaldosCuentas]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spMFAObtenerSaldosCuentas](
@empresa varchar(5), @ejer int
)
WITH ENCRYPTION
AS
BEGIN
/*declare @empresa varchar(5), @ejer int
set @empresa = ''PME''
set @ejer = 2012*/
SELECT distinct a.cuentacontable as cuenumero,isnull(b.saldoinicial,0) as sainicial,     
		isnull((select cargo from MovContables cc where cc.mes=1 and cc.anio=@ejer and cc.cuentacontable=a.cuentacontable),0) as sade11,isnull((select abono from MovContables cc where cc.mes=1 and cc.anio=@ejer and cc.cuentacontable=a.cuentacontable),0) as saha11, 
		isnull((select cargo from MovContables cc where cc.mes=2 and cc.anio=@ejer and cc.cuentacontable=a.cuentacontable),0) as sade12,isnull((select abono from MovContables cc where cc.mes=2 and cc.anio=@ejer and cc.cuentacontable=a.cuentacontable),0) as saha12, 
		isnull((select cargo from MovContables cc where cc.mes=3 and cc.anio=@ejer and cc.cuentacontable=a.cuentacontable),0) as sade13,isnull((select abono from MovContables cc where cc.mes=3 and cc.anio=@ejer and cc.cuentacontable=a.cuentacontable),0) as saha13, 
		isnull((select cargo from MovContables cc where cc.mes=4 and cc.anio=@ejer and cc.cuentacontable=a.cuentacontable),0) as sade14,isnull((select abono from MovContables cc where cc.mes=4 and cc.anio=@ejer and cc.cuentacontable=a.cuentacontable),0) as saha14, 
		isnull((select cargo from MovContables cc where cc.mes=5 and cc.anio=@ejer and cc.cuentacontable=a.cuentacontable),0) as sade15,isnull((select abono from MovContables cc where cc.mes=5 and cc.anio=@ejer and cc.cuentacontable=a.cuentacontable),0) as saha15, 
		isnull((select cargo from MovContables cc where cc.mes=6 and cc.anio=@ejer and cc.cuentacontable=a.cuentacontable),0) as sade16,isnull((select abono from MovContables cc where cc.mes=6 and cc.anio=@ejer and cc.cuentacontable=a.cuentacontable),0) as saha16, 
		isnull((select cargo from MovContables cc where cc.mes=7 and cc.anio=@ejer and cc.cuentacontable=a.cuentacontable),0) as sade17,isnull((select abono from MovContables cc where cc.mes=7 and cc.anio=@ejer and cc.cuentacontable=a.cuentacontable),0) as saha17, 
		isnull((select cargo from MovContables cc where cc.mes=8 and cc.anio=@ejer and cc.cuentacontable=a.cuentacontable),0) as sade18,isnull((select abono from MovContables cc where cc.mes=8 and cc.anio=@ejer and cc.cuentacontable=a.cuentacontable),0) as saha18, 
		isnull((select cargo from MovContables cc where cc.mes=9 and cc.anio=@ejer and cc.cuentacontable=a.cuentacontable),0) as sade19,isnull((select abono from MovContables cc where cc.mes=9 and cc.anio=@ejer and cc.cuentacontable=a.cuentacontable),0) as saha19, 
		isnull((select cargo from MovContables cc where cc.mes=10 and cc.anio=@ejer and cc.cuentacontable=a.cuentacontable),0) as sade20,isnull((select abono from MovContables cc where cc.mes=10 and cc.anio=@ejer and cc.cuentacontable=a.cuentacontable),0) as saha20, 
		isnull((select cargo from MovContables cc where cc.mes=11 and cc.anio=@ejer and cc.cuentacontable=a.cuentacontable),0) as sade21,isnull((select abono from MovContables cc where cc.mes=11 and cc.anio=@ejer and cc.cuentacontable=a.cuentacontable),0) as saha21, 
		isnull((select cargo from MovContables cc where cc.mes=12 and cc.anio=@ejer and cc.cuentacontable=a.cuentacontable),0) as sade22,isnull((select abono from MovContables cc where cc.mes=12 and cc.anio=@ejer and cc.cuentacontable=a.cuentacontable),0) as saha22, 
		0 as sade23, 0 as saha23, 0 as sade24, 0 as saha24     
		FROM dbo.CuentasContables a     
		 left join dbo.SaldosIni b on a.CuentaContable=b.CuentaContable and b.anio=@ejer and b.empresa=@empresa
		 inner join dbo.MovContables c  on a.CuentaContable=c.CuentaContable and c.anio=@ejer and c.empresa=@empresa
END 
' 
END
GO
/****** Object:  StoredProcedure [dbo].[spMFAObtenerCuentasContables]    Script Date: 09/12/2012 03:26:24 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spMFAObtenerCuentasContables]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spMFAObtenerCuentasContables]
WITH ENCRYPTION
AS
BEGIN
SELECT a.CuentaContable as cuenumero,isnull(a.CuentaControl,'''') as cuecontrol,a.nivel as cuenivel,
					 a.descripcion as cuedescri,isnull(a.tipo,'''') as cuetipo,a.clase as cueclase,
					 '''' as cuenatur, 0 as cuedepto,0 as cuecatego,ISNULL(b.Rubro,'''') as cuerubro,
					 ''A'' as cuestatus,0 as cuecantid,0 as cuedigito,moneda as cuemoneda,'''' as cueclasi,
					 0 as cuesepara,isnull(cr.IdRetencion,10) as cueretenc,0 as cueautonum,0 as cuerubroc 
			 FROM CuentasContables a 
				  left join CuentaRubro b on a.CuentaContable=b.CuentaContable
				 left join cuentasretenciones cr on a.CuentaContable = cr.CuentaContable 
END
' 
END
GO

--drop procedure dbo.spMFAObtenerCuentasContables
/*
insert into BasesDeCalculo(Reporte,ClaveBC,Nombre,Descripcion,Naturaleza,Orden)values(20,5,'Cuentas y documentos por cobrar nacionales (Partes relacionadas).','','A',5)
insert into BasesDeCalculo(Reporte,ClaveBC,Nombre,Descripcion,Naturaleza,Orden)values(20,7,'Cuentas y documentos por cobrar del extranjero (Partes relacionadas).','','A',7)
insert into BasesDeCalculo(Reporte,ClaveBC,Nombre,Descripcion,Naturaleza,Orden)values(20,25,'Cuentas y documentos por pagar nacionales (Partes relacionadas).','','B',25)
*/