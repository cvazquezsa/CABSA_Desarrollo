SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF 
SET NOCOUNT ON
GO
/************************************************** Tablas **************************************************/
/************************ SUAFiltro ***********************/
if exists (select * from sysobjects where id = object_id('SUAFiltro') and type = 'U') DROP TABLE SUAFiltro
BEGIN
  CREATE TABLE SUAFiltro(
    Estacion		  int		  NOT NULL,
    Empresa			  char(5)	  NOT NULL,
    Reporte			  varchar(5)  NULL,
    RegistroPatronal  varchar(50) NULL,
    Ejercicio		  int		  NULL,
    Periodo			  int		  NULL,
    CONSTRAINT priSUAFiltro PRIMARY KEY CLUSTERED(Estacion,Empresa)
	)
END

/************************ SUA ***********************/
if exists (select * from sysobjects where id = object_id('SUA') and type = 'U') DROP TABLE SUA
BEGIN
  CREATE TABLE SUA(
	Personal		  varchar(10)	NULL,
	NSS				  varchar(30)	NULL, 
	Nombre			  varchar(100)	NULL, 
	Origen			  int			NULL, 
	Tipo			  int			NULL, 
	Fecha			  datetime		NULL, 
	Dias			  int			NULL, 
	SDI				  money			NULL,
	TipoDescuento	  varchar(10)	NULL,
	ValorDescuento	  money			NULL,
	Credito			  varchar(20)	NULL,
	Validacion		  bit			NULL
	)
END

/************************ SUAImportacion ***********************/
if exists (select * from sysobjects where id = object_id('SUAImportacion') and type = 'U') DROP TABLE SUAImportacion
BEGIN
  CREATE TABLE SUAImportacion(
	NSS				  varchar(30)	NULL, 
	Nombre			  varchar(100)	NULL, 
	Origen			  int			NULL, 
	Tipo			  int			NULL, 
	Fecha			  datetime		NULL, 
	Dias			  int			NULL, 
	SDI				  money			NULL,
	TipoDescuento	  varchar(10)	NULL,
	ValorDescuento	  money			NULL,
	Credito			  varchar(20)	NULL,
	Validacion		  bit			NULL
	)
END

/************************ SUAComparacion ***********************/
if exists (select * from sysobjects where id = object_id('SUAComparacion') and type = 'U') DROP TABLE SUAComparacion
BEGIN
  CREATE TABLE SUAComparacion(
	OrigenDatos		  varchar(10)	NULL,
	NSS				  varchar(30)	NULL, 
	Nombre			  varchar(100)	NULL, 
	Origen			  int			NULL, 
	Tipo			  int			NULL, 
	Fecha			  datetime		NULL, 
	Dias			  int			NULL, 
	SDI				  money			NULL,
	TipoDescuento	  varchar(10)	NULL,
	ValorDescuento	  money			NULL,
	Credito			  varchar(20)	NULL,
	Validacion		  bit			NULL
	)
END

/************************ SUAFalta ***********************/
if not exists(select * from SysTabla where SysTabla = 'SUAFalta')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SUAFalta','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SUAFalta') and type = 'U') 
  CREATE TABLE dbo.SUAFalta (
    RID					int identity(1,1) NOT NULL,
	Mov					varchar(20)		  NULL,
    Concepto			varchar(50)		  NULL,
    Tipo				varchar(20)		  NULL
	CONSTRAINT priSUAFalta PRIMARY KEY CLUSTERED (RID)
)
GO

/************************************************** Procedimientos **************************************************/
/**************** spSUAComparacion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSUAComparacion') and type = 'P') drop procedure dbo.spSUAComparacion
GO
CREATE PROCEDURE spSUAComparacion
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE
	@NSS			  varchar(30), 
	@Nombre			  varchar(100), 
	@Origen			  int, 
	@Tipo			  int, 
	@Fecha			  datetime, 
	@Dias			  int, 
	@SDI			  money, 
	@TipoDescuento	  varchar(10), 
	@ValorDescuento	  money, 
	@Credito		  varchar(20), 
	@Validacion		  bit
	
  DELETE SUAComparacion
	
  DECLARE cComparacion CURSOR FOR
  SELECT NSS, Nombre, Origen, Tipo, Fecha, Dias, SDI, TipoDescuento, ValorDescuento, Credito, Validacion FROM SUA
        
  OPEN cComparacion
  FETCH NEXT FROM cComparacion INTO @NSS, @Nombre, @Origen, @Tipo, @Fecha, @Dias, @SDI, @TipoDescuento, @ValorDescuento, @Credito, @Validacion
  WHILE @@FETCH_STATUS = 0    
  BEGIN  
	IF EXISTS(SELECT * FROM SUAImportacion
			  WHERE NSS = @NSS 
				AND Nombre = @Nombre 
				AND Origen = @Origen 
				AND Tipo = @Tipo 
				AND Fecha = @Fecha 
				AND Dias = @Dias
				AND SDI = @SDI
				AND TipoDescuento = @TipoDescuento
				AND ValorDescuento = @ValorDescuento
				AND Credito = @Credito)
			  UPDATE SUA SET Validacion = 1
			  WHERE NSS = @NSS 
				AND Nombre = @Nombre 
				AND Origen = @Origen 
				AND Tipo = @Tipo 
				AND Fecha = @Fecha 
				AND Dias = @Dias
				AND SDI = @SDI
				AND TipoDescuento = @TipoDescuento
				AND ValorDescuento = @ValorDescuento
				AND Credito = @Credito
      
	  FETCH NEXT FROM cComparacion INTO @NSS, @Nombre, @Origen, @Tipo, @Fecha, @Dias, @SDI, @TipoDescuento, @ValorDescuento, @Credito, @Validacion
  END    
  CLOSE cComparacion    
  DEALLOCATE cComparacion
  
  INSERT INTO SUAComparacion (OrigenDatos, NSS, Nombre, Origen, Tipo, Fecha, Dias, SDI, TipoDescuento, ValorDescuento, Credito, Validacion) 
  SELECT 'Intelisis', NSS, Nombre, Origen, Tipo, Fecha, Dias, SDI, TipoDescuento, ValorDescuento, Credito, Validacion FROM SUA
  
  DECLARE cComparacion2 CURSOR FOR
  SELECT * FROM SUAImportacion
        
  OPEN cComparacion2
  FETCH NEXT FROM cComparacion2 INTO @NSS, @Nombre, @Origen, @Tipo, @Fecha, @Dias, @SDI, @TipoDescuento, @ValorDescuento, @Credito, @Validacion
  WHILE @@FETCH_STATUS = 0    
  BEGIN  
	IF EXISTS(SELECT * FROM SUA
			  WHERE NSS = @NSS 
				AND Nombre = @Nombre 
				AND Origen = @Origen 
				AND Tipo = @Tipo 
				AND Fecha = @Fecha 
				AND Dias = @Dias
				AND SDI = @SDI
				AND TipoDescuento = @TipoDescuento
				AND ValorDescuento = @ValorDescuento
				AND Credito = @Credito)
			  UPDATE SUAImportacion SET Validacion = 1
			  WHERE NSS = @NSS 
				AND Nombre = @Nombre 
				AND Origen = @Origen 
				AND Tipo = @Tipo 
				AND Fecha = @Fecha 
				AND Dias = @Dias
				AND SDI = @SDI
				AND TipoDescuento = @TipoDescuento
				AND ValorDescuento = @ValorDescuento
				AND Credito = @Credito
      
	  FETCH NEXT FROM cComparacion2 INTO @NSS, @Nombre, @Origen, @Tipo, @Fecha, @Dias, @SDI, @TipoDescuento, @ValorDescuento, @Credito, @Validacion
  END    
  CLOSE cComparacion2    
  DEALLOCATE cComparacion2
  
  INSERT INTO SUAComparacion (OrigenDatos, NSS, Nombre, Origen, Tipo, Fecha, Dias, SDI, TipoDescuento, ValorDescuento, Credito, Validacion) 
  SELECT 'SUA', NSS, Nombre, Origen, Tipo, Fecha, Dias, SDI, TipoDescuento, ValorDescuento, Credito, Validacion FROM SUAImportacion
	
END
GO

/**************** spSUA ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSUA') and type = 'P') drop procedure dbo.spSUA
GO
CREATE PROCEDURE spSUA
			@Estacion		  int,
			@Empresa		  varchar(5),
			@Reporte		  varchar(5),
			@RegistroPatronal varchar(50),
			@Ejercicio		  int,
			@Periodo		  int
--//WITH ENCRYPTION

AS
BEGIN

  DECLARE 
	@EmpresaRegistroPatronal	bit,
	@SucursalRegistroPatronal	bit,
	@PuestoRegistroPatronal		bit,
	@PersonalRegistroPatronal	bit,
	@CategoriaRegistroPatronal	bit,
	@PrimerDia					datetime,
	@UltimoDia					datetime,
	@NSS						varchar(30),
	@Fecha						datetime,
	@SDIAnterior				money,
	@Periodo1					int,
	@Periodo2					int
	
  DECLARE @Tabla TABLE(Personal varchar(10), NSS varchar(30), Nombre varchar(100), Origen int, Tipo int, Fecha datetime, Dias int, SDI money, TipoDescuento varchar(10), ValorDescuento money, Credito varchar(20), Validacion bit)
  DECLARE @Personal TABLE(Personal varchar(10), NSS varchar(30), Nombre varchar(100), SDI money, FechaAlta datetime, TIPO INT)

  DELETE SUA
  DELETE SUAImportacion
  
  SELECT @SucursalRegistroPatronal = ISNULL((SELECT 1 FROM PersonalPropValor WHERE Rama = 'SUC' AND Propiedad = 'Registro Patronal' AND Valor = @RegistroPatronal),0)
  SELECT @EmpresaRegistroPatronal = ISNULL((SELECT 1 FROM PersonalPropValor WHERE Rama = 'EMP' AND Cuenta = @Empresa AND Propiedad = 'Registro Patronal' AND Valor = @RegistroPatronal),0)
  SELECT @PuestoRegistroPatronal = ISNULL((SELECT 1 FROM PersonalPropValor WHERE Rama = 'PUE' AND Propiedad = 'Registro Patronal' AND Valor = @RegistroPatronal),0)
  SELECT @PersonalRegistroPatronal = ISNULL((SELECT 1 FROM PersonalPropValor WHERE Rama = 'PER' AND Propiedad = 'Registro Patronal' AND Valor = @RegistroPatronal),0)
  SELECT @CategoriaRegistroPatronal = ISNULL((SELECT 1 FROM PersonalPropValor WHERE Rama = 'CAT' AND Propiedad = 'Registro Patronal' AND Valor = @RegistroPatronal),0)
  SELECT @PrimerDia = CASE @Reporte WHEN 'EMA' THEN '1/' + CONVERT(varchar,@Periodo) + '/' + CONVERT(varchar,@Ejercicio) ELSE CASE @Periodo%2 WHEN 1 THEN '1/' + CONVERT(varchar,@Periodo) + '/' + CONVERT(varchar,@Ejercicio) ELSE '1/' + CONVERT(varchar,@Periodo-1) + '/' + CONVERT(varchar,@Ejercicio) END END
  SELECT @UltimoDia = CASE @Reporte WHEN 'EMA' THEN CONVERT(varchar,dbo.fnDiasMes(@Periodo,@Ejercicio)) + '/' + CONVERT(varchar,@Periodo) + '/' + CONVERT(varchar,@Ejercicio) ELSE CASE @Periodo%2 WHEN 1 THEN CONVERT(varchar,dbo.fnDiasMes(@Periodo+1,@Ejercicio)) + '/' + CONVERT(varchar,@Periodo+1) + '/' + CONVERT(varchar,@Ejercicio) ELSE CONVERT(varchar,dbo.fnDiasMes(@Periodo,@Ejercicio)) + '/' + CONVERT(varchar,@Periodo) + '/' + CONVERT(varchar,@Ejercicio) END END
  SELECT @Periodo1 = CASE @Periodo WHEN 1 THEN 1 WHEN 2 THEN 1 WHEN 3 THEN 3 WHEN 4 THEN 3 WHEN 5 THEN 5 WHEN 6 THEN 5 WHEN 7 THEN 7 WHEN 8 THEN 7 WHEN 9 THEN 9 WHEN 10 THEN 9 WHEN 11 THEN 11 WHEN 12 THEN 11 END
  SELECT @Periodo2 = CASE @Periodo WHEN 1 THEN 2 WHEN 2 THEN 2 WHEN 3 THEN 4 WHEN 4 THEN 4 WHEN 5 THEN 6 WHEN 6 THEN 6 WHEN 7 THEN 8 WHEN 8 THEN 8 WHEN 9 THEN 10 WHEN 10 THEN 10 WHEN 11 THEN 12 WHEN 12 THEN 12 END
  
  IF @SucursalRegistroPatronal = 1
  BEGIN
	INSERT INTO @Personal(
				Personal, NSS,		 Nombre,																	  SDI, FechaAlta)
		 SELECT Personal, Registro3, UPPER(ApellidoPaterno) + ' ' + UPPER(ApellidoMaterno) + ' ' + UPPER(Nombre), SDI, FechaAlta
		   FROM Personal
		   JOIN PersonalPropValor ON PersonalPropValor.Rama = 'SUC' AND PersonalPropValor.Cuenta = Personal.SucursalTrabajo AND PersonalPropValor.Propiedad = 'Registro Patronal' AND PersonalPropValor.Valor = @RegistroPatronal
		  WHERE Empresa = @Empresa AND FechaAlta <= @UltimoDia
  END ELSE
  IF @EmpresaRegistroPatronal = 1
  BEGIN
	INSERT INTO @Personal(
				Personal, NSS,		 Nombre,																	  SDI, FechaAlta)
		 SELECT Personal, Registro3, UPPER(ApellidoPaterno) + ' ' + UPPER(ApellidoMaterno) + ' ' + UPPER(Nombre), SDI, FechaAlta
		   FROM Personal
		   JOIN PersonalPropValor ON PersonalPropValor.Rama = 'EMP' AND PersonalPropValor.Cuenta = @Empresa AND PersonalPropValor.Propiedad = 'Registro Patronal' AND PersonalPropValor.Valor = @RegistroPatronal
		  WHERE Empresa = @Empresa AND FechaAlta <= @UltimoDia
  END ELSE
  IF @PuestoRegistroPatronal = 1
  BEGIN
	INSERT INTO @Personal(
				Personal, NSS,		 Nombre,																	  SDI, FechaAlta)
		 SELECT Personal, Registro3, UPPER(ApellidoPaterno) + ' ' + UPPER(ApellidoMaterno) + ' ' + UPPER(Nombre), SDI, FechaAlta
		   FROM Personal
		   JOIN Puesto ON Puesto.Puesto = Personal.Puesto
		   JOIN PersonalPropValor ON PersonalPropValor.Rama = 'PUE' AND PersonalPropValor.Cuenta = Personal.Puesto AND PersonalPropValor.Propiedad = 'Registro Patronal' AND PersonalPropValor.Valor = @RegistroPatronal
		  WHERE Empresa = @Empresa AND FechaAlta <= @UltimoDia
  END ELSE
  IF @CategoriaRegistroPatronal = 1
  BEGIN
	INSERT INTO @Personal(
				Personal, NSS,		 Nombre,																	  SDI, FechaAlta)
		 SELECT Personal, Registro3, UPPER(ApellidoPaterno) + ' ' + UPPER(ApellidoMaterno) + ' ' + UPPER(Nombre), SDI, FechaAlta
		   FROM Personal
		   JOIN PersonalCat ON PersonalCat.Categoria = Personal.Categoria
		   JOIN PersonalPropValor ON PersonalPropValor.Rama = 'CAT' AND PersonalPropValor.Cuenta = Personal.Categoria AND PersonalPropValor.Propiedad = 'Registro Patronal' AND PersonalPropValor.Valor = @RegistroPatronal
		  WHERE Empresa = @Empresa AND FechaAlta <= @UltimoDia
  END ELSE
  IF @PersonalRegistroPatronal = 1
  BEGIN
	INSERT INTO @Personal(
				Personal, NSS,		 Nombre,																	  SDI, FechaAlta)
		 SELECT Personal, Registro3, UPPER(ApellidoPaterno) + ' ' + UPPER(ApellidoMaterno) + ' ' + UPPER(Nombre), SDI, FechaAlta
		   FROM Personal
		   JOIN PersonalPropValor ON PersonalPropValor.Rama = 'PER' AND PersonalPropValor.Cuenta = Personal.Personal AND PersonalPropValor.Propiedad = 'Registro Patronal' AND PersonalPropValor.Valor = @RegistroPatronal
		  WHERE Empresa = @Empresa AND FechaAlta <= @UltimoDia
  END
  
  IF @Reporte = 'EMA'
  BEGIN
	-- Se inserta Personal
	INSERT INTO @Tabla(
		   Personal, NSS,	  Nombre,	Origen, Tipo, Fecha, Dias,								  SDI, TipoDescuento, ValorDescuento, Credito, Validacion)
	SELECT p.Personal, p.NSS, p.Nombre, 4,		9,	  NULL,  dbo.fnDiasMes(@Periodo, @Ejercicio), SDI, NULL,		  NULL,			  NULL,	   NULL
	  FROM @Personal p
  
	/********************* BAJA ******************/
	INSERT INTO @Tabla(
		   Personal, NSS,	  Nombre,	Origen,	Tipo, Fecha,		   Dias, SDI,  TipoDescuento, ValorDescuento, Credito, Validacion)
    SELECT p.Personal, p.NSS, p.Nombre, 0,		2,	  RH.FechaEmision, 0,	 NULL, NULL,		  NULL,			  NULL,	   NULL
	  FROM @Personal p
	  JOIN RH ON RH.Ejercicio = @Ejercicio AND RH.Periodo = @Periodo AND RH.Estatus = 'CONCLUIDO'
	  JOIN RHD ON RHD.ID = RH.ID AND RHD.Personal = p.Personal
	  JOIN MovTipo mt ON mt.Modulo = 'RH' AND mt.Mov = RH.Mov AND mt.Clave = 'RH.B'
	
	DECLARE cBaja CURSOR FOR
	 SELECT NSS, Fecha
	   FROM @Tabla
	  WHERE Origen = 0 AND Tipo = 2
        
	OPEN cBaja
	FETCH NEXT FROM cBaja INTO @NSS, @Fecha
	WHILE @@FETCH_STATUS = 0    
	BEGIN  
	  UPDATE @Tabla SET Dias = DATEDIFF(D,@PrimerDia,@Fecha)+1
	   WHERE NSS = @NSS AND Origen = 4 AND Tipo = 9
      
	  FETCH NEXT FROM cBaja INTO @NSS, @Fecha
	END    
	CLOSE cBaja    
	DEALLOCATE cBaja
	
	/********************* MODIFICACION DE SALARIO ******************/
	INSERT INTO @Tabla(
		   Personal, NSS,	  Nombre,	Origen, Tipo, Fecha,		   Dias,									   SDI,		TipoDescuento, ValorDescuento, Credito, Validacion)
	SELECT p.Personal, p.NSS, p.Nombre, 4,		7,	  RH.FechaEmision, DATEDIFF(D,RH.FechaEmision,@UltimoDia) + 1, RHD.SDI,	NULL,		   NULL,		   NULL, NULL
	  FROM @Personal p
	  JOIN RH ON RH.Ejercicio = @Ejercicio AND RH.Periodo = @Periodo AND RH.Estatus = 'CONCLUIDO'
	  JOIN RHD ON RHD.ID = RH.ID AND RHD.Personal = p.Personal AND RH.Concepto = 'SDI'
	  JOIN MovTipo mt ON mt.Modulo = 'RH' AND mt.Mov = RH.Mov AND mt.Clave = 'RH.M'
	  
	DECLARE cModificacion CURSOR FOR
	 SELECT NSS, Fecha
	   FROM @Tabla
	  WHERE Origen = 4 AND Tipo = 7
        
	OPEN cModificacion
	FETCH NEXT FROM cModificacion INTO @NSS, @Fecha
	WHILE @@FETCH_STATUS = 0    
	BEGIN  
	  UPDATE @Tabla 
		 SET SDI = (SELECT SDIAnterior FROM Personal WHERE Registro3 = @NSS),
			 Dias = DATEDIFF(D,@PrimerDia,@Fecha)
	   WHERE NSS = @NSS AND Origen = 4 AND Tipo = 9
      
	  FETCH NEXT FROM cModificacion INTO @NSS, @Fecha
	END    
	CLOSE cModificacion
	DEALLOCATE cModificacion
	
	DELETE FROM @Tabla WHERE Origen = 4 AND Tipo = 9 AND Dias = 0
	  
	/********************* REINGRESO ******************/
	INSERT INTO @Tabla(
		   Personal, NSS,	  Nombre,	Origen,	Tipo, Fecha,			   Dias,										   SDI,		TipoDescuento, ValorDescuento, Credito, Validacion)
    SELECT p.Personal, p.NSS, p.Nombre, 4,		8,	  RHD.FechaAntiguedad, DATEDIFF(D,RHD.FechaAntiguedad,@UltimoDia) + 1, RHD.SDI, NULL,		   NULL,		   NULL, NULL
	  FROM @Personal p
	  JOIN RH ON RH.Estatus = 'CONCLUIDO'
	  JOIN RHD ON RHD.ID = RH.ID AND RHD.Personal = p.Personal AND RHD.FechaAlta >= @PrimerDia AND RHD.FechaAlta <= @UltimoDia
	  JOIN MovTipo mt ON mt.Modulo = 'RH' AND mt.Mov = RH.Mov AND mt.Clave = 'RH.A'
	
	DECLARE cAlta CURSOR FOR
	 SELECT NSS
	   FROM @Tabla
	  WHERE Origen = 4 AND Tipo = 8
        
	OPEN cAlta
	FETCH NEXT FROM cAlta INTO @NSS
	WHILE @@FETCH_STATUS = 0    
	BEGIN  
	  DELETE FROM @Tabla WHERE NSS = @NSS AND Origen = 4 AND Tipo = 9
      
	  FETCH NEXT FROM cAlta INTO @NSS
	END    
	CLOSE cAlta
	DEALLOCATE cAlta
	
	/********************* AUSENTISMO ******************/
	INSERT INTO @Tabla(
		   Personal, NSS,	  Nombre,	Origen,	Tipo, Fecha,	 Dias,		  SDI,	TipoDescuento, ValorDescuento, Credito, Validacion)
    SELECT p.Personal, p.NSS, p.Nombre, 4,		11,	  nd.FechaD, nd.Cantidad, NULL, NULL,		   NULL,		   NULL, NULL
	  FROM @Personal p
	  JOIN Nomina n ON n.Ejercicio = @Ejercicio AND n.Periodo = @Periodo AND n.Estatus IN ('PROCESAR','CONCLUIDO') AND n.Concepto IN ('Falta Injustificada','Sin Goce de Sueldo')
	  JOIN NominaD nd ON nd.ID = n.ID AND nd.Personal = p.Personal
	  JOIN MovTipo mt ON mt.Modulo = 'NOM' AND mt.Mov = n.Mov AND mt.Clave = 'NOM.CD'
	
	/********************* INCAPACIDAD ******************/
	INSERT INTO @Tabla(
		   Personal, NSS,	  Nombre,	Origen,	Tipo, Fecha,	 Dias,		  SDI,	TipoDescuento, ValorDescuento, Credito, Validacion)
    SELECT p.Personal, p.NSS, p.Nombre, 4,		12,	  nd.FechaD, nd.Cantidad, NULL,	NULL,		   NULL,		   NULL, NULL
	  FROM @Personal p
	  JOIN Nomina n ON n.Ejercicio = @Ejercicio AND n.Periodo = @Periodo AND n.Estatus IN ('PROCESAR','CONCLUIDO') AND n.Concepto IN ('Accidente Trabajo','Accidente Trabajo Transito','Enfermedad General Inicial','Enfermedad General Subsecuente','Maternidad Enlace','Maternidad Posnatal','Maternidad Prenatal','Falta Justificada','Con Goce de Sueldo')
	  JOIN NominaD nd ON nd.ID = n.ID AND nd.Personal = p.Personal
	  JOIN MovTipo mt ON mt.Modulo = 'NOM' AND mt.Mov = n.Mov AND mt.Clave = 'NOM.CD'
	  
	INSERT INTO SUA SELECT * FROM @Tabla ORDER BY Nombre, Origen, Tipo
  END ELSE
  BEGIN
	-- Se inserta Personal
	INSERT INTO @Tabla(
		   Personal, NSS,	  Nombre,	Origen, Tipo, Fecha, Dias,																																																	SDI, TipoDescuento, ValorDescuento, Credito, Validacion)
	SELECT p.Personal, p.NSS, p.Nombre, 4,		9,	  NULL,  CASE @Periodo%2 WHEN 1 THEN dbo.fnDiasMes(@Periodo, @Ejercicio) + dbo.fnDiasMes(@Periodo + 1, @Ejercicio) WHEN 0 THEN dbo.fnDiasMes(@Periodo, @Ejercicio) + dbo.fnDiasMes(@Periodo-1, @Ejercicio) END, SDI, ppvt.Valor, ppvv.Valor, ppvc.Valor, NULL
	  FROM @Personal p
	  JOIN PersonalPropValor ppvt ON ppvt.Rama = 'PER' AND ppvt.Propiedad = '# SMGDF Credito Infonavit' AND ppvt.Cuenta = p.Personal
	  JOIN PersonalPropValor ppvv ON ppvv.Rama = 'PER' AND ppvv.Propiedad = '% SDI Credito Infonavit' AND ppvv.Cuenta = p.Personal
	  JOIN PersonalPropValor ppvc ON ppvc.Rama = 'PER' AND ppvc.Propiedad = '# Crédito Infonavit' AND ppvc.Cuenta = p.Personal
	  
	/********************* BAJA ******************/
	INSERT INTO @Tabla(
		   Personal, NSS,	  Nombre,	Origen,	Tipo, Fecha,		   Dias, SDI,  TipoDescuento, ValorDescuento, Credito,	  Validacion)
    SELECT p.Personal, p.NSS, p.Nombre, 0,		2,	  RH.FechaEmision, 0,	 NULL, ppvt.Valor,	  ppvv.Valor,	  ppvc.Valor, NULL
	  FROM @Personal p
	  JOIN PersonalPropValor ppvt ON ppvt.Rama = 'PER' AND ppvt.Propiedad = '# SMGDF Credito Infonavit' AND ppvt.Cuenta = p.Personal
	  JOIN PersonalPropValor ppvv ON ppvv.Rama = 'PER' AND ppvv.Propiedad = '% SDI Credito Infonavit' AND ppvv.Cuenta = p.Personal
	  JOIN PersonalPropValor ppvc ON ppvc.Rama = 'PER' AND ppvc.Propiedad = '# Crédito Infonavit' AND ppvc.Cuenta = p.Personal
	  JOIN RH ON RH.Ejercicio = @Ejercicio AND (RH.Periodo = @Periodo1 OR RH.Periodo = @Periodo2) AND RH.Estatus = 'CONCLUIDO'
	  JOIN RHD ON RHD.ID = RH.ID AND RHD.Personal = p.Personal
	  JOIN MovTipo mt ON mt.Modulo = 'RH' AND mt.Mov = RH.Mov AND mt.Clave = 'RH.B'
	
	DECLARE cBaja CURSOR FOR
	 SELECT NSS, Fecha
	   FROM @Tabla
	  WHERE Origen = 0 AND Tipo = 2
        
	OPEN cBaja
	FETCH NEXT FROM cBaja INTO @NSS, @Fecha
	WHILE @@FETCH_STATUS = 0
	BEGIN
	  UPDATE @Tabla SET Dias = DATEDIFF(D,@PrimerDia,@Fecha)+1
	   WHERE NSS = @NSS AND Origen = 4 AND Tipo = 9
      
	  FETCH NEXT FROM cBaja INTO @NSS, @Fecha
	END
	CLOSE cBaja
	DEALLOCATE cBaja
	
	/********************* MODIFICACION DE SALARIO ******************/
	INSERT INTO @Tabla(
		   Personal, NSS,	  Nombre,	Origen, Tipo, Fecha,		   Dias,									   SDI,		TipoDescuento, ValorDescuento, Credito, Validacion)
	SELECT p.Personal, p.NSS, p.Nombre, 4,		7,	  RH.FechaEmision, DATEDIFF(D,RH.FechaEmision,@UltimoDia) + 1, RHD.SDI,	ppvt.Valor,	   ppvv.Valor,	   ppvc.Valor, NULL
	  FROM @Personal p
	  JOIN PersonalPropValor ppvt ON ppvt.Rama = 'PER' AND ppvt.Propiedad = '# SMGDF Credito Infonavit' AND ppvt.Cuenta = p.Personal
	  JOIN PersonalPropValor ppvv ON ppvv.Rama = 'PER' AND ppvv.Propiedad = '% SDI Credito Infonavit' AND ppvv.Cuenta = p.Personal
	  JOIN PersonalPropValor ppvc ON ppvc.Rama = 'PER' AND ppvc.Propiedad = '# Crédito Infonavit' AND ppvc.Cuenta = p.Personal
	  JOIN RH ON RH.Ejercicio = @Ejercicio AND (RH.Periodo = @Periodo1 OR RH.Periodo = @Periodo2) AND RH.Estatus = 'CONCLUIDO'
	  JOIN RHD ON RHD.ID = RH.ID AND RHD.Personal = p.Personal AND RH.Concepto = 'SDI'
	  JOIN MovTipo mt ON mt.Modulo = 'RH' AND mt.Mov = RH.Mov AND mt.Clave = 'RH.M'
	  
	DECLARE cModificacion CURSOR FOR
	 SELECT NSS, Fecha
	   FROM @Tabla
	  WHERE Origen = 4 AND Tipo = 7
        
	OPEN cModificacion
	FETCH NEXT FROM cModificacion INTO @NSS, @Fecha
	WHILE @@FETCH_STATUS = 0
	BEGIN  
	  UPDATE @Tabla 
		 SET SDI = (SELECT SDIAnterior FROM Personal WHERE Registro3 = @NSS),
			 Dias = DATEDIFF(D,@PrimerDia,@Fecha)
	   WHERE NSS = @NSS AND Origen = 4 AND Tipo = 9
      
	  FETCH NEXT FROM cModificacion INTO @NSS, @Fecha
	END    
	CLOSE cModificacion
	DEALLOCATE cModificacion
	
	DELETE FROM @Tabla WHERE Origen = 4 AND Tipo = 9 AND Dias = 0
	
	/********************* REINGRESO ******************/
	INSERT INTO @Tabla(
		   Personal, NSS,	  Nombre,	Origen,	Tipo, Fecha,			   Dias,										   SDI,		TipoDescuento, ValorDescuento, Credito,	   Validacion)
    SELECT p.Personal, p.NSS, p.Nombre, 4,		8,	  RHD.FechaAntiguedad, DATEDIFF(D,RHD.FechaAntiguedad,@UltimoDia) + 1, RHD.SDI, ppvt.Valor,	   ppvv.Valor,	   ppvc.Valor, NULL
	  FROM @Personal p
	  JOIN PersonalPropValor ppvt ON ppvt.Rama = 'PER' AND ppvt.Propiedad = '# SMGDF Credito Infonavit' AND ppvt.Cuenta = p.Personal
	  JOIN PersonalPropValor ppvv ON ppvv.Rama = 'PER' AND ppvv.Propiedad = '% SDI Credito Infonavit' AND ppvv.Cuenta = p.Personal
	  JOIN PersonalPropValor ppvc ON ppvc.Rama = 'PER' AND ppvc.Propiedad = '# Crédito Infonavit' AND ppvc.Cuenta = p.Personal
	  JOIN RH ON RH.Estatus = 'CONCLUIDO'
	  JOIN RHD ON RHD.ID = RH.ID AND RHD.Personal = p.Personal AND RHD.FechaAlta >= @PrimerDia AND RHD.FechaAlta <= @UltimoDia
	  JOIN MovTipo mt ON mt.Modulo = 'RH' AND mt.Mov = RH.Mov AND mt.Clave = 'RH.A'
	
	DECLARE cAlta CURSOR FOR
	 SELECT NSS
	   FROM @Tabla
	  WHERE Origen = 4 AND Tipo = 8
        
	OPEN cAlta
	FETCH NEXT FROM cAlta INTO @NSS
	WHILE @@FETCH_STATUS = 0    
	BEGIN  
	  DELETE FROM @Tabla WHERE NSS = @NSS AND Origen = 4 AND Tipo = 9
      
	  FETCH NEXT FROM cAlta INTO @NSS
	END    
	CLOSE cAlta
	DEALLOCATE cAlta
	
	/********************* AUSENTISMO ******************/
	INSERT INTO @Tabla(
		   Personal, NSS,	  Nombre,	Origen,	Tipo, Fecha,	 Dias,		  SDI,	TipoDescuento, ValorDescuento, Credito,	   Validacion)
    SELECT p.Personal, p.NSS, p.Nombre, 4,		11,	  nd.FechaD, nd.Cantidad, NULL, ppvt.Valor,	   ppvv.Valor,	   ppvc.Valor, NULL
	  FROM @Personal p
	  JOIN PersonalPropValor ppvt ON ppvt.Rama = 'PER' AND ppvt.Propiedad = '# SMGDF Credito Infonavit' AND ppvt.Cuenta = p.Personal
	  JOIN PersonalPropValor ppvv ON ppvv.Rama = 'PER' AND ppvv.Propiedad = '% SDI Credito Infonavit' AND ppvv.Cuenta = p.Personal
	  JOIN PersonalPropValor ppvc ON ppvc.Rama = 'PER' AND ppvc.Propiedad = '# Crédito Infonavit' AND ppvc.Cuenta = p.Personal
	  JOIN Nomina n ON n.Ejercicio = @Ejercicio AND (n.Periodo = @Periodo1 OR n.Periodo = @Periodo2) AND n.Estatus IN ('PROCESAR','CONCLUIDO') AND n.Concepto IN ('Falta Injustificada','Sin Goce de Sueldo')
	  JOIN NominaD nd ON nd.ID = n.ID AND nd.Personal = p.Personal
	  JOIN MovTipo mt ON mt.Modulo = 'NOM' AND mt.Mov = n.Mov AND mt.Clave = 'NOM.CD'
	
	/********************* INCAPACIDAD ******************/
	INSERT INTO @Tabla(
		   Personal, NSS,	  Nombre,	Origen,	Tipo, Fecha,	 Dias,		  SDI,	TipoDescuento, ValorDescuento, Credito,	   Validacion)
    SELECT p.Personal, p.NSS, p.Nombre, 4,		12,	  nd.FechaD, nd.Cantidad, NULL,	ppvt.Valor,	   ppvv.Valor,	   ppvc.Valor, NULL
	  FROM @Personal p
	  JOIN PersonalPropValor ppvt ON ppvt.Rama = 'PER' AND ppvt.Propiedad = '# SMGDF Credito Infonavit' AND ppvt.Cuenta = p.Personal
	  JOIN PersonalPropValor ppvv ON ppvv.Rama = 'PER' AND ppvv.Propiedad = '% SDI Credito Infonavit' AND ppvv.Cuenta = p.Personal
	  JOIN PersonalPropValor ppvc ON ppvc.Rama = 'PER' AND ppvc.Propiedad = '# Crédito Infonavit' AND ppvc.Cuenta = p.Personal
	  JOIN Nomina n ON n.Ejercicio = @Ejercicio AND (n.Periodo = @Periodo1 OR n.Periodo = @Periodo2) AND n.Estatus IN ('PROCESAR','CONCLUIDO') AND n.Concepto IN ('Accidente Trabajo','Accidente Trabajo Transito','Enfermedad General Inicial','Enfermedad General Subsecuente','Maternidad Enlace','Maternidad Posnatal','Maternidad Prenatal','Falta Justificada','Con Goce de Sueldo')
	  JOIN NominaD nd ON nd.ID = n.ID AND nd.Personal = p.Personal
	  JOIN MovTipo mt ON mt.Modulo = 'NOM' AND mt.Mov = n.Mov AND mt.Clave = 'NOM.CD'
	
	INSERT INTO SUA SELECT * FROM @Tabla ORDER BY Nombre, Origen, Tipo
  END
END
GO
--EXEC spSUA 1, 'DEMO', 'EBA', 'A0123456789', '2017', '7'