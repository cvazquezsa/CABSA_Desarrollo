----------------------------
/***** MODIFICACIONES *****/
----------------------------

/**** INICIA: CONCEPTO FLujo de Efectivo ****/
EXEC spAlter_Table 'Gasto', 'ConceptoFE','varchar(50) NULL'
EXEC spAlter_Table 'Compra', 'ConceptoFE','varchar(50)  NULL' 
EXEC spAlter_Table 'Venta', 'ConceptoFE','varchar(50)  NULL'
EXEC spAlter_Table 'CXC', 'ConceptoFE','varchar(50)  NULL'
EXEC spAlter_Table 'CXP', 'ConceptoFE','varchar(50)  NULL'
EXEC spAlter_Table 'Dinero', 'ConceptoFE','varchar(50)  NULL'
GO

EXEC spAlter_Table 'Dinero', 'ConceptoFEFondos','varchar(100)  NULL'
EXEC spAlter_Table 'Dinero', 'ClasificacionConcFEFondos','varchar(100)  NULL'

/**** INICIA: Deposito no identificado ****/
EXEC spAlter_Table 'FormaPago', 'EsNoIdentificado','bit NULL'
/**** TERMINA: Deposito no identificado ****/

--------------------
/***** TABLAS *****/
--------------------

IF NOT EXISTS(SELECT * FROM SysObjects WHERE name = 'ConceptoFE' AND type='U')
	CREATE TABLE ConceptoFE(
		ConceptoFE varchar(50) PRIMARY KEY NOT NULL
		)
/**** TERMINA: CONCEPTO FLujo de Efectivo ****/
--DROP TABLE VtasProrrateo

/**** INICIA: Factura prorrateada ****/
if not exists (select * from sysobjects where id = object_id('dbo.VtasProrrateo') and type = 'U') 
	CREATE TABLE dbo.VtasProrrateo(
		ID	int NOT NULL,
		RenglonID		int IDENTITY(1,1)	NOT NULL,
		Articulo	varchar(20) NOT NULL,
		EmpresaProrrateo	varchar(7)		NULL DEFAULT ('(Todas)'),
		SucursalProrrateo	int			NULL,
		CCProrrateo		varchar(20)		NULL,
		CC2Prorrateo		varchar(20)		NULL,
		CC3Prorrateo		varchar(20)		NULL,
		EspacioProrrateo	varchar(10)		NULL,
		VINProrrateo		varchar(20)		NULL,
		ProyectoProrrateo	varchar(50)		NULL,
		UENProrrateo		int			NULL,
		ActividadProrrateo	varchar(100)		NULL,
		Importe	money	NOT NULL,
		Porcentaje		float			NULL,

		CONSTRAINT priVtasProrrateo PRIMARY KEY  CLUSTERED (ID, RenglonID)
	)
	GO
/**** FIN: Factura prorrateada ****/

/**** INICIA: Flujo Efectivo Fondos ****/

IF NOT EXISTS(SELECT * FROM SysObjects WHERE name = 'ConceptoFEFondos' AND type='U')
	CREATE TABLE ConceptoFEFondos(
		ConceptoFEFondos varchar(50) NOT NULL,
		CONSTRAINT pkConceptoFEFondos PRIMARY KEY CLUSTERED (ConceptoFEFondos)
		)
EXEC spAlter_Table 'ConceptoFEFondos', 'Cuenta','varchar(20) NULL'

IF NOT EXISTS(SELECT * FROM SysObjects WHERE name = 'ClasificacionConcFEFondos' AND type='U')
	CREATE TABLE ClasificacionConcFEFondos(
		Clasificacion	varchar(50) PRIMARY KEY NOT NULL
		)
EXEC spAlter_Table 'ClasificacionConcFEFondos', 'Cuenta','varchar(20) NULL'
EXEC spAlter_Table 'ClasificacionConcFEFondos', 'EsConcentradora','bit NULL'

IF NOT EXISTS(SELECT * FROM SysObjects WHERE name = 'CABAuxiliarFEFondos' AND type='U')
	CREATE TABLE CABAuxiliarFEFondos(
		ID	int	IDENTITY(1,1),
		Empresa	varchar(5),
		Modulo	varchar(5),
		ModuloID	int,
		Mov	varchar(20),
		MovId	varchar(50),
		Clasificacion	varchar(100),
		Importe	money,
		FechaEmision	datetime,
		Cancelado	bit
	)

/**** FIN: Flujo Efectivo Fondos ****/

