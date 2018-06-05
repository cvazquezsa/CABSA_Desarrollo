IF EXISTS (SELECT * FROM SysObjects WHERE Name = 'spCABRepFEF' AND Type = 'P')
	DROP PROCEDURE spCABRepFEF
GO
CREATE PROCEDURE spCABRepFEF
	@Empresa	varchar(5),
	@FechaD	datetime,
	@FechaA	datetime,
	@ClasificacionConcFEFondos varchar(100),
	@VerConcentradoras	bit
AS
BEGIN
	DECLARE @Reporte TABLE(
		ID	int,
		Empresa	varchar(5),
		EmpresaNombre	varchar(255),
		Modulo	varchar(5),
		ModuloID	int,
		Mov	varchar(20),
		MovID	varchar(50),
		Referencia	varchar(255),
		Observaciones	varchar(255),
		Clasificacion	varchar(100),
		Importe	money,
		FechaEmision	datetime,
		Cancelado	bit,
		ConceptoFEFondos	varchar(100),
		ClasificacionConcFEFondos	varchar(100),
		SaldoInicial	money,
		SaldoFinal	money,
		LogoIntelisis	varchar(max),
		LogoEmpresa	varchar(max)
		)
	DECLARE
		@SaldoInicial money,
		@SaldoFinal	money,
		@LogoIntelisis	varchar(max),
		@LogoEmpresa	varchar(max)

	SELECT @LogoIntelisis = 'E:\Version\Intelisis\Dibujos\Imagenes\Respaldo\Logo.bmp'
	SELECT @LogoEmpresa = CONCAT('E:\Version\Intelisis\Dibujos\Imagenes\', @Empresa, '.bmp')

	SELECT @ClasificacionConcFEFondos = NULLIF(@ClasificacionConcFEFondos,'(Todas)')
	SELECT @VerConcentradoras = NULLIF(@VerConcentradoras,1)
	
	INSERT INTO @Reporte
		(ID,		Empresa,			EmpresaNombre,	Modulo,			ModuloID,			Mov,			MovID,		Referencia,		Observaciones,			Clasificacion, 
		Importe,			FechaEmision,			Cancelado,			ConceptoFEFondos,		ClasificacionConcFEFondos,	LogoIntelisis, LogoEmpresa)
	SELECT 
		caf.ID, caf.Empresa,	e.Nombre,				caf.Modulo, caf.ModuloID, caf.Mov,	caf.MovID,d.Referencia,	d.Observaciones,	caf.Clasificacion,
		caf.Importe,	caf.FechaEmision, caf.Cancelado,	d.ConceptoFEFondos, d.ClasificacionConcFEFondos, @LogoIntelisis, @LogoEmpresa
		FROM CABAuxiliarFEFondos caf
			JOIN Dinero d ON caf.ModuloID = d.ID AND caf.Modulo = 'DIN'
			JOIN Empresa e ON caf.Empresa = e.Empresa
			JOIN ClasificacionConcFEFondos ccf ON d.ClasificacionConcFEFondos = ccf.Clasificacion
		WHERE caf.Cancelado = 0 AND caf.Empresa = @Empresa AND caf.FechaEmision >= @FechaD
			AND caf.FechaEmision <= @FechaA AND d.ClasificacionConcFEFondos = ISNULL(@ClasificacionConcFEFondos,d.ClasificacionConcFEFondos)
			AND ISNULL(ccf.EsConcentradora,0) = ISNULL(@VerConcentradoras, ISNULL(ccf.EsConcentradora,0))

		SELECT 
		@SaldoInicial = ISNULL(SUM(CASE 
			WHEN caf.Clasificacion = 'ORIGEN DE DEPOSITOS Y CARGOS' THEN 1
			WHEN caf.Clasificacion = 'APLICACION DE CHEQUES Y ABONOS' THEN -1
		END * caf.Importe),0)
		FROM CABAuxiliarFEFondos caf
			JOIN Dinero d ON caf.ModuloID = d.ID AND caf.Modulo = 'DIN'
			JOIN ClasificacionConcFEFondos ccf ON d.ClasificacionConcFEFondos = ccf.Clasificacion
		WHERE caf.Cancelado = 0 AND caf.Empresa = @Empresa AND caf.FechaEmision < @FechaD  
		AND d.ClasificacionConcFEFondos = ISNULL(@ClasificacionConcFEFondos,d.ClasificacionConcFEFondos)
		AND ISNULL(ccf.EsConcentradora,0) = ISNULL(@VerConcentradoras, ISNULL(ccf.EsConcentradora,0))

		SELECT 
		@SaldoFinal = ISNULL(SUM(CASE 
			WHEN caf.Clasificacion = 'ORIGEN DE DEPOSITOS Y CARGOS' THEN 1
			WHEN caf.Clasificacion = 'APLICACION DE CHEQUES Y ABONOS' THEN -1
		END * caf.Importe),0)
		FROM CABAuxiliarFEFondos caf
			JOIN Dinero d ON caf.ModuloID = d.ID AND caf.Modulo = 'DIN'
			JOIN ClasificacionConcFEFondos ccf ON d.ClasificacionConcFEFondos = ccf.Clasificacion
		WHERE caf.Cancelado = 0 AND caf.Empresa = @Empresa AND caf.FechaEmision <= @FechaA  
		AND d.ClasificacionConcFEFondos = ISNULL(@ClasificacionConcFEFondos,d.ClasificacionConcFEFondos)
		AND ISNULL(ccf.EsConcentradora,0) = ISNULL(@VerConcentradoras, ISNULL(ccf.EsConcentradora,0))
		
		UPDATE @Reporte SET SaldoInicial = @SaldoInicial, SaldoFinal = @SaldoFinal
		--SELECT @SaldoInicial
		SELECT * FROM @Reporte
END
GO
EXEC spCABRepFEF 'FAS', '20180501', '20180531','(Todas)',0
