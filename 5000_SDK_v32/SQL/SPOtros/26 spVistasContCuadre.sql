
/** Cuadre Contable */

-- Tablas Temporales

/* ContCuadreMov */
if exists (select * from sysobjects where id = object_id('dbo.ContCuadreMov') and sysstat & 0xf = 3) drop table dbo.ContCuadreMov
go
CREATE TABLE dbo.ContCuadreMov (
	Estacion		int		NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

	Cuenta			varchar(20)	NULL,
	Mov			varchar(20)	NULL,
	MovID			varchar(20)	NULL,

	Importe			money		NULL,

	CONSTRAINT priContCuadreMov PRIMARY KEY CLUSTERED (Estacion, ID)
)
go

/* ContCuadreCont */
if exists (select * from sysobjects where id = object_id('dbo.ContCuadreCont') and sysstat & 0xf = 3) drop table dbo.ContCuadreCont
go
CREATE TABLE dbo.ContCuadreCont (
	Estacion		int		NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

	Cuenta			varchar(20)	NULL,
	Mov			varchar(20)	NULL,
	MovID			varchar(20)	NULL,

	Importe			money		NULL,

	CONSTRAINT priContCuadreCont PRIMARY KEY CLUSTERED (Estacion, ID)
)
go

/* ContCuadreDirecto */
if exists (select * from sysobjects where id = object_id('dbo.ContCuadreDirecto') and sysstat & 0xf = 3) drop table dbo.ContCuadreDirecto
go
CREATE TABLE dbo.ContCuadreDirecto (
	Estacion		int		NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

	Cuenta			varchar(20)	NULL,
	Importe			money		NULL,

	CONSTRAINT priContCuadreDirecto PRIMARY KEY CLUSTERED (Estacion, ID)
)
go


/* ContCuadre */
if exists (select * from sysobjects where id = object_id('dbo.ContCuadre') and sysstat & 0xf = 3) drop table dbo.ContCuadre
go
CREATE TABLE dbo.ContCuadre (
	Estacion		int		NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

	Cuenta			varchar(20)	NULL,
	Mov			varchar(20)	NULL,
	MovID			varchar(20)	NULL,

	ImporteMov		money		NULL,
	ImporteCont		money		NULL,
	ImporteDirecto		money		NULL,

	CONSTRAINT priContCuadre PRIMARY KEY CLUSTERED (Estacion, ID)
)
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContCuadre' AND sysindexes.name = 'Cuenta' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Cuenta ON dbo.ContCuadre (Cuenta)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContCuadre' AND sysindexes.name = 'Mov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Mov ON dbo.ContCuadre (MovID, Mov, Cuenta)
go
EXEC spALTER_TABLE 'ContCuadre', 'ImporteDirecto', 'money NULL'
GO

/* MovCuadre */
if exists (select * from sysobjects where id = object_id('dbo.MovCuadre') and sysstat & 0xf = 3) drop table dbo.MovCuadre
go
CREATE TABLE dbo.MovCuadre (
	Estacion		int		NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

	Modulo			char(5)		NULL,
	ModuloID		int		NULL,
	Estatus			varchar(15)	NULL,
	Mov			varchar(20)	NULL,
	MovID			varchar(20)	NULL,
	ImporteMN		money		NULL,

	Cuenta			varchar(20)	NULL,
	SubCuenta		varchar(20)	NULL,
	Debe			money		NULL,
	Haber			money		NULL,

	CONSTRAINT priMovCuadre PRIMARY KEY CLUSTERED (Estacion, ID)
)
go
EXEC spALTER_TABLE 'MovCuadre', 'ModuloID', 'int NULL'
go
-- select * from MovCuadreR 
/*** MovCuadreR ***/
if exists (select * from sysobjects where id = object_id('dbo.MovCuadreR') and type = 'V') drop view dbo.MovCuadreR
GO
CREATE VIEW MovCuadreR
--//WITH ENCRYPTION
AS
SELECT Estacion, Modulo, Mov, Estatus, Cuenta, SubCuenta, "Conteo" = COUNT(*), "ImporteMN" = SUM(ImporteMN), "Debe" = SUM(Debe), "Haber" = SUM(Haber)
  FROM MovCuadre
 GROUP BY Estacion, Modulo, Mov, Estatus, Cuenta, SubCuenta
GO     

-- select * from cta where Cuenta in (select cuenta from dbo.fnCtaExplosion('B'))
/**************** fnCtaExplosion ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCtaExplosion' AND type = 'TF') DROP FUNCTION fnCtaExplosion
GO
CREATE FUNCTION fnCtaExplosion (@Cuenta varchar(20))
RETURNS @Resultado TABLE (Cuenta varchar(20))
--//WITH ENCRYPTION
AS BEGIN
  INSERT @Resultado 
  SELECT c.Cuenta
    FROM Cta c
    JOIN Cta r ON r.Cuenta = c.Rama
   WHERE c.Cuenta = @Cuenta OR c.Rama = @Cuenta OR r.Rama = @Cuenta

  RETURN 
END
GO

/**************** spContCuadreTablaCampo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContCuadreTablaCampo') and type = 'P') drop procedure dbo.spContCuadreTablaCampo
GO
CREATE PROCEDURE spContCuadreTablaCampo
			@Modulo		char(5),
			@Tabla		varchar(50)	OUTPUT,
			@Campo		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SuFijo		varchar(50),
    @CampoFisico	varchar(255),
    @TieneImporte	bit,
    @TieneImpuestos	bit,
    @TieneRetencion	bit

  SELECT @CampoFisico = NULL, @TieneImporte = 0, @TieneImpuestos = 0, @TieneRetencion = 0, @Sufijo = ''
  SELECT @Tabla = dbo.fnMovTabla(@Modulo)
  IF @Modulo = 'GAS' SELECT @Sufijo = 'Linea'

  IF @Tabla IS NOT NULL
  BEGIN
    IF EXISTS(SELECT * FROM SysCampo WHERE Tabla = @Tabla AND Campo = 'Importe')   SELECT @TieneImporte = 1 
    IF EXISTS(SELECT * FROM SysCampo WHERE Tabla = @Tabla AND Campo = 'Impuestos') SELECT @TieneImpuestos = 1 
    IF EXISTS(SELECT * FROM SysCampo WHERE Tabla = @Tabla AND Campo = 'Retencion') SELECT @TieneRetencion = 1 
    
    IF @Campo = 'Importe'              AND @TieneImporte   = 1 SELECT @CampoFisico = 'm.'+@Campo+@Sufijo ELSE
    IF @Campo = 'Impuestos'            AND @TieneImpuestos = 1 SELECT @CampoFisico = 'm.'+@Campo+@Sufijo ELSE
    IF @Campo = 'Retencion'            AND @TieneRetencion = 1 SELECT @CampoFisico = 'm.'+@Campo+@Sufijo ELSE
    IF @Campo = 'Costo Total'          AND @TieneRetencion = 1 SELECT @CampoFisico = 'm.CostoTotal' ELSE
    IF @Campo = 'Diferencia Cambiaria' AND @TieneRetencion = 1 SELECT @CampoFisico = 'm.DiferenciaCambiaria' ELSE
    IF @Campo = 'Importe Total'
    BEGIN
      IF @TieneImporte   = 1 SELECT @CampoFisico = 'ISNULL(m.Importe'+@Sufijo+', 0.0)' 
      IF @TieneImpuestos = 1 SELECT @CampoFisico = @CampoFisico + ' + ISNULL(m.Impuestos'+@Sufijo+', 0.0)'
      IF @TieneRetencion = 1 SELECT @CampoFisico = @CampoFisico + ' - ISNULL(m.Retencion'+@Sufijo+', 0.0)'
    END
  END

  SELECT @Campo = @CampoFisico
  IF @Modulo = 'GAS' SELECT @Tabla = 'GastoT'
  RETURN
END
GO


/**************** spContCuadreMovCampo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContCuadreMovCampo') and type = 'P') drop procedure dbo.spContCuadreMovCampo
GO
CREATE PROCEDURE spContCuadreMovCampo
                   @Estacion		int,                   
		   @Cuenta		varchar(20),
                   @Empresa		char(5),
                   @FechaD		datetime,
		   @FechaA		datetime,
		   @Desglosar		char(2),
    		   @Modulo		char(5),
    		   @Mov			varchar(20),
		   @Concepto		varchar(50),
		   @Clase		varchar(50),
		   @SubClase		varchar(50),
		   @ContactoTipo	varchar(20),
		   @ContactoNivel	varchar(20),
		   @ContactoClave	varchar(20),
    		   @Campo		varchar(255),
		   @Factor		float	= 1.0

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Tabla		varchar(50),
    @SQLWhere		nvarchar(2000),
    @SQL 		nvarchar(4000)

  SELECT @Concepto = NULLIF(RTRIM(@Concepto), ''), @Clase = NULLIF(RTRIM(@Clase), ''), @SubClase = NULLIF(RTRIM(@SubClase), ''), @ContactoTipo = NULLIF(RTRIM(@ContactoTipo), ''), @ContactoNivel = NULLIF(RTRIM(@ContactoNivel), ''), @ContactoClave = NULLIF(RTRIM(@ContactoClave), '')
  EXEC spContCuadreTablaCampo @Modulo, @Tabla OUTPUT, @Campo OUTPUT
  IF @Tabla IS NOT NULL AND @Campo IS NOT NULL
  BEGIN
    SELECT @SQLWhere = N'WHERE m.Mov = @Mov AND m.Empresa = @Empresa AND m.Estatus IN ("PENDIENTE", "CONCLUIDO") AND m.FechaEmision BETWEEN @FechaD AND @FechaA AND ISNULL(Concepto, "") = ISNULL(@Concepto, ISNULL(Concepto, ""))'
    IF NULLIF(RTRIM(@ContactoTipo), '') IS NOT NULL AND @ContactoNivel IS NOT NULL AND @ContactoClave IS NOT NULL
    BEGIN
      IF @Modulo = 'DIN'
        SELECT @SQLWhere = @SQLWhere + N' AND dbo.fnContactoNivel(ContactoTipo, Contacto, @ContactoNivel)=@ContactoClave'
      ELSE
        SELECT @SQLWhere = @SQLWhere + N' AND dbo.fnContactoNivel(@ContactoTipo, ' + @ContactoTipo + N', @ContactoNivel)=@ContactoClave'
    END

    IF @Modulo = 'GAS'
    BEGIN
      SELECT @SQLWhere = @SQLWhere + N' AND ISNULL(ConceptoClase, "") = ISNULL(@Clase, ISNULL(ConceptoClase, "")) AND ISNULL(ConceptoSubClase, "") = ISNULL(@SubClase, ISNULL(ConceptoSubClase, ""))'
      IF @Desglosar = 'NO'
        SELECT @SQL = N'INSERT ContCuadreMov (Estacion, Cuenta, Importe) SELECT @Estacion, @Cuenta, SUM(('+@Campo+N')*m.TipoCambio*mt.Factor)*@Factor FROM '+@Tabla+N' m JOIN MovTipo mt ON mt.Modulo="'+@Modulo+N'" AND mt.Mov = m.Mov '+@SQLWhere
      ELSE
        SELECT @SQL = N'INSERT ContCuadreMov (Estacion, Cuenta, Mov, MovID, Importe) SELECT @Estacion, @Cuenta, Mov, MovID, SUM(('+@Campo+N')*m.TipoCambio)*@Factor FROM '+@Tabla+N' m '+@SQLWhere+N' GROUP BY Mov, MovID'
    END ELSE
    IF @Modulo = 'VTAS'
    BEGIN
      SELECT @SQLWhere = @SQLWhere + N' AND ISNULL(Clase, "") = ISNULL(@Clase, ISNULL(Clase, "")) AND ISNULL(SubClase, "") = ISNULL(@SubClase, ISNULL(SubClase, ""))'
      IF @Desglosar = 'NO'
        SELECT @SQL = N'INSERT ContCuadreMov (Estacion, Cuenta, Importe) SELECT @Estacion, @Cuenta, SUM(('+@Campo+N')*m.TipoCambio*mt.Factor)*@Factor FROM '+@Tabla+N' m JOIN MovTipo mt ON mt.Modulo="'+@Modulo+N'" AND mt.Mov = m.Mov '+@SQLWhere
      ELSE
        SELECT @SQL = N'INSERT ContCuadreMov (Estacion, Cuenta, Mov, MovID, Importe) SELECT @Estacion, @Cuenta, Mov, MovID, SUM(('+@Campo+N')*m.TipoCambio)*@Factor FROM '+@Tabla+N' m '+@SQLWhere+N' GROUP BY Mov, MovID'
    END ELSE
    BEGIN
      IF @Desglosar = 'NO'
        SELECT @SQL = N'INSERT ContCuadreMov (Estacion, Cuenta, Importe) SELECT @Estacion, @Cuenta, SUM(('+@Campo+N')*m.TipoCambio*mt.Factor)*@Factor FROM '+@Tabla+N' m JOIN MovTipo mt ON mt.Modulo="'+@Modulo+N'" AND mt.Mov = m.Mov '+@SQLWhere
      ELSE
        SELECT @SQL = N'INSERT ContCuadreMov (Estacion, Cuenta, Mov, MovID, Importe) SELECT @Estacion, @Cuenta, Mov, MovID, SUM(('+@Campo+N')*m.TipoCambio)*@Factor FROM '+@Tabla+N' m '+@SQLWhere+N' GROUP BY Mov, MovID'
    END

--SELECT @SQL
--SELECT @Estacion, @Cuenta, @Empresa, @FechaD, @FechaA, @Factor, @Mov, @Concepto, @Clase, @SubClase, @ContactoTipo, @ContactoNivel, @ContactoClave
    EXEC sp_executesql @SQL, 
                       N'@Estacion int, @Cuenta varchar(20), @Empresa char(5), @FechaD datetime, @FechaA datetime, @Factor float, @Mov varchar(20), @Concepto varchar(50), @Clase varchar(50), @SubClase varchar(50), @ContactoTipo varchar(20), @ContactoNivel varchar(20), @ContactoClave varchar(20)', 
                       @Estacion, @Cuenta, @Empresa, @FechaD, @FechaA, @Factor, @Mov, @Concepto, @Clase, @SubClase, @ContactoTipo, @ContactoNivel, @ContactoClave
  END
  RETURN
END
GO

-- spContCuadreMov 1, '100-00-000', 'DEMO', '1/1/4','1/1/6', 'VTAS', 'Pedido', 'Importe', 1
-- spContCuadre 12.0, 'DEMO', '01/01/2005 00:00:00', '09/07/2005 00:00:00', '(TODAS)', 'No'
-- select * from contcuadre
/**************** spContCuadreMov ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContCuadreMov') and type = 'P') drop procedure dbo.spContCuadreMov
GO
CREATE PROCEDURE spContCuadreMov
                   @Estacion	int,                   
		   @Cuenta	varchar(20),
                   @Empresa	char(5),
                   @FechaD	datetime,
		   @FechaA	datetime,
		   @Desglosar	char(2)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Modulo		char(5),
    @Mov		varchar(20),
    @Concepto		varchar(50),
    @Clase		varchar(50),
    @SubClase		varchar(50),
    @ContactoTipo	varchar(20),
    @ContactoNivel	varchar(20),
    @ContactoClave	varchar(20),
    @Campo		varchar(255),
    @Debe		varchar(20),
    @Haber		varchar(20)

  DECLARE crCtaMov CURSOR FOR
   SELECT Modulo, Mov, NULLIF(RTRIM(Concepto), ''), NULLIF(RTRIM(Clase), ''), NULLIF(RTRIM(SubClase), ''), NULLIF(RTRIM(ContactoTipo), ''), NULLIF(RTRIM(ContactoNivel), ''), NULLIF(RTRIM(ContactoClave), ''), NULLIF(RTRIM(Debe), ''), NULLIF(RTRIM(Haber), '')
     FROM CtaMov
    WHERE Cuenta = @Cuenta
  OPEN crCtaMov
  FETCH NEXT FROM crCtaMov INTO @Modulo, @Mov, @Concepto, @Clase, @SubClase, @ContactoTipo, @ContactoNivel, @ContactoClave, @Debe, @Haber
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
       IF @Debe  IS NOT NULL EXEC spContCuadreMovCampo @Estacion, @Cuenta, @Empresa, @FechaD, @FechaA, @Desglosar, @Modulo, @Mov, @Concepto, @Clase, @SubClase, @ContactoTipo, @ContactoNivel, @ContactoClave, @Debe, 1.0
       IF @Haber IS NOT NULL EXEC spContCuadreMovCampo @Estacion, @Cuenta, @Empresa, @FechaD, @FechaA, @Desglosar, @Modulo, @Mov, @Concepto, @Clase, @SubClase, @ContactoTipo, @ContactoNivel, @ContactoClave, @Haber, -1.0
    END
    FETCH NEXT FROM crCtaMov INTO @Modulo, @Mov, @Concepto, @Clase, @SubClase, @ContactoTipo, @ContactoNivel, @ContactoClave, @Debe, @Haber
  END
  CLOSE crCtaMov
  DEALLOCATE crCtaMov
  RETURN
END
GO

-- spContCuadre 110, 'DEMO', '1/1/5', '1/1/6' 
/**************** spContCuadre ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContCuadre') and sysstat & 0xf = 4) drop procedure dbo.spContCuadre
GO             
CREATE PROCEDURE spContCuadre
			@Estacion		int,
			@Empresa		char(5),
			@FechaD			datetime,
			@FechaA			datetime,
			@CuentaEspecifica	varchar(20)	= NULL,
			@Desglosar		char(2) 	= 'NO'
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Cuenta	varchar(20),
    @Mov	varchar(20),
    @MovID	varchar(20),
    @Importe	money

  SELECT @CuentaEspecifica = NULLIF(NULLIF(NULLIF(RTRIM(@CuentaEspecifica), '0'), ''), '(TODAS)')
  DELETE ContCuadre     WHERE Estacion = @Estacion
  DELETE ContCuadreCont WHERE Estacion = @Estacion
  DELETE ContCuadreMov  WHERE Estacion = @Estacion

  DECLARE crCta CURSOR FOR
   SELECT Cuenta
     FROM Cta
    WHERE Cuenta = ISNULL(@CuentaEspecifica, Cuenta) AND CuadreContable = 1
  OPEN crCta
  FETCH NEXT FROM crCta INTO @Cuenta
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      -- Movimientos
      EXEC spContCuadreMov @Estacion, @Cuenta, @Empresa, @FechaD, @FechaA, @Desglosar

      -- Contabilidad
      IF UPPER(@Desglosar) = 'NO'
        INSERT ContCuadreCont (Estacion,  Cuenta,  Importe)        
        SELECT @Estacion, @Cuenta, ISNULL(SUM(d.Debe), 0.0)-ISNULL(SUM(d.Haber), 0.0)
          FROM ContD d
          JOIN Cont e ON e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus = 'CONCLUIDO' AND e.FechaContable BETWEEN @FechaD AND @FechaA
         WHERE d.Cuenta IN (SELECT Cuenta FROM dbo.fnCtaExplosion(@Cuenta))
      ELSE
        INSERT ContCuadreCont (Estacion,  Cuenta,  Mov, MovID, Importe)
        SELECT @Estacion, @Cuenta, e.Origen, e.OrigenID, ISNULL(SUM(d.Debe), 0.0)-ISNULL(SUM(d.Haber), 0.0)
          FROM ContD d
          JOIN Cont e ON e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus = 'CONCLUIDO' AND e.FechaContable BETWEEN @FechaD AND @FechaA
         WHERE d.Cuenta IN (SELECT Cuenta FROM dbo.fnCtaExplosion(@Cuenta))
         GROUP BY e.Origen, e.OrigenID
         ORDER BY e.Origen, e.OrigenID

      -- Directo
      INSERT ContCuadreDirecto (Estacion,  Cuenta,  Importe)        
      SELECT @Estacion, @Cuenta, ISNULL(SUM(d.Debe), 0.0)-ISNULL(SUM(d.Haber), 0.0)
        FROM ContD d
        JOIN Cont e ON e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus = 'CONCLUIDO' AND e.FechaContable BETWEEN @FechaD AND @FechaA
       WHERE d.Cuenta IN (SELECT Cuenta FROM dbo.fnCtaExplosion(@Cuenta))
         AND e.Origen IS NULL AND e.OrigenID IS NULL
    END
    FETCH NEXT FROM crCta INTO @Cuenta
  END
  CLOSE crCta
  DEALLOCATE crCta

  INSERT ContCuadre (Estacion, Cuenta, Mov, MovID, ImporteMov)
  SELECT @Estacion, Cuenta, ISNULL(Mov, ''), ISNULL(MovID, ''), SUM(Importe)
    FROM ContCuadreMov
   WHERE Estacion = @Estacion
   GROUP BY Cuenta, ISNULL(Mov, ''), ISNULL(MovID, '') 
   ORDER BY Cuenta, ISNULL(Mov, ''), ISNULL(MovID, '') 

  DECLARE crContCuadreCont CURSOR FOR
   SELECT Cuenta, ISNULL(Mov, ''), ISNULL(MovID, ''), SUM(Importe)
     FROM ContCuadreCont
    WHERE Estacion = @Estacion
    GROUP BY Cuenta, ISNULL(Mov, ''), ISNULL(MovID, '')
    ORDER BY Cuenta, ISNULL(Mov, ''), ISNULL(MovID, '')
  OPEN crContCuadreCont
  FETCH NEXT FROM crContCuadreCont INTO @Cuenta, @Mov, @MovID, @Importe
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      UPDATE ContCuadre 
         SET ImporteCont = @Importe
       WHERE Estacion = @Estacion AND Cuenta = @Cuenta AND Mov = @Mov AND MovID = @MovID
      IF @@ROWCOUNT = 0
        INSERT ContCuadre (Estacion,  Cuenta,  Mov,  MovID,  ImporteCont)
                   VALUES (@Estacion, @Cuenta, @Mov, @MovID, @Importe)     
    END
    FETCH NEXT FROM crContCuadreCont INTO @Cuenta, @Mov, @MovID, @Importe
  END
  CLOSE crContCuadreCont
  DEALLOCATE crContCuadreCont

  DECLARE crContCuadreDirecto CURSOR FOR
   SELECT Cuenta, SUM(Importe)
     FROM ContCuadreDirecto
    WHERE Estacion = @Estacion
    GROUP BY Cuenta
    ORDER BY Cuenta
  OPEN crContCuadreDirecto
  FETCH NEXT FROM crContCuadreDirecto INTO @Cuenta, @Importe
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      UPDATE ContCuadre 
         SET ImporteDirecto = @Importe
       WHERE Estacion = @Estacion AND Cuenta = @Cuenta 
      IF @@ROWCOUNT = 0
        INSERT ContCuadre (Estacion,  Cuenta,  ImporteDirecto)
                   VALUES (@Estacion, @Cuenta, @Importe)     
    END
    FETCH NEXT FROM crContCuadreDirecto INTO @Cuenta, @Importe
  END
  CLOSE crContCuadreDirecto
  DEALLOCATE crContCuadreDirecto

  SELECT "Proceso Concluido con Exito"
  RETURN
END
GO


-- spMovCuadre 100, 'DEMO', '1/1/5', '1/1/6' 
-- select * from movcuadre
/**************** spMovCuadre ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMovCuadre') and sysstat & 0xf = 4) drop procedure dbo.spMovCuadre
GO             
CREATE PROCEDURE spMovCuadre
			@Estacion		int,
			@Empresa		char(5),
			@FechaD			datetime,
			@FechaA			datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Cuenta	varchar(20),
    @ImporteMN	money,
    @Modulo	char(5),
    @ID		int,
    @Estatus	varchar(15),
    @Mov	varchar(20),
    @MovID	varchar(20),
    @Conteo	int,
    @Importe	money,
    @ContID	int

  DELETE MovCuadre WHERE Estacion = @Estacion

  DECLARE crMov CURSOR FOR
   SELECT Modulo, ID
     FROM Mov
    WHERE Empresa = @Empresa AND FechaEmision BETWEEN @FechaD AND @FechaA AND Modulo <> 'CONT'
  OPEN crMov
  FETCH NEXT FROM crMov INTO @Modulo, @ID
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Mov = Mov, @MovID = MovID, @Estatus = Estatus, @ImporteMN = ImporteMN, @ContID = ContID FROM dbo.fnMovReg(@Modulo, @ID)
      INSERT MovCuadre (Estacion, Modulo, ModuloID, Estatus, Mov, MovID, ImporteMN, Cuenta, SubCuenta, Debe, Haber)
      SELECT @Estacion, @Modulo, @ID, @Estatus, @Mov, @MovID, @ImporteMN, d.Cuenta, d.SubCuenta, SUM(d.Debe), SUM(d.Haber)
        FROM ContD d
        JOIN Cont e ON e.ID = d.ID
       WHERE e.Empresa = @Empresa AND e.Estatus = 'CONCLUIDO' AND e.ID = @ContID
       GROUP BY d.Cuenta, d.SubCuenta
      IF @@ROWCOUNT = 0 
        INSERT MovCuadre (Estacion,  Modulo,  ModuloID, Estatus,  Mov,  MovID,  ImporteMN)
                  VALUES (@Estacion, @Modulo, @ID,      @Estatus, @Mov, @MovID, @ImporteMN)
    END
    FETCH NEXT FROM crMov INTO @Modulo, @ID
  END
  CLOSE crMov
  DEALLOCATE crMov

  SELECT "Proceso Concluido con Exito"
  RETURN
END
GO
