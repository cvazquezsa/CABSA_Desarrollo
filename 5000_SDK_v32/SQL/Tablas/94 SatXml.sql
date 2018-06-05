/****** SatXml ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='SatXml' and type ='U')
CREATE TABLE [dbo].[SatXml](
	[FolioFiscal] [uniqueidentifier] NOT NULL,
	[RFCEmisor] [varchar](50) NULL,
	[NombreoRazonSocialdelEmisor] [varchar](100) NULL,
	[RFCReceptor] [varchar](50) NULL,
	[NombreoRazonSocialdelReceptor] [varchar](100) NULL,
	[FechadeEmision] [datetime] NULL,
	[FechadeCertificacion] [datetime] NULL,
	[PACqueCertifico] [varchar](50) NULL,
	[Total] [money] NULL,
	[EfectodelComprobante] [varchar](20) NULL,
	[EstadodelComprobante] [varchar](20) NULL,
	[EmitidasRecibidas] [varchar](10) NULL,
	[FechadeCancelacion] [datetime] NULL,
	[RfcAutenticado] [varchar](50) NULL,
	[UrlXml] [text] NULL,
	[Xml] [text] NULL,
	[Empresa] [char](10) NULL,
UNIQUE NONCLUSTERED 
(
	[FolioFiscal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[FolioFiscal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF 
GO
ALTER TABLE SatXml ALTER COLUMN NombreoRazonSocialdelEmisor varchar(255) NULL
ALTER TABLE SatXml ALTER COLUMN NombreoRazonSocialdelReceptor varchar(255) NULL
GO
