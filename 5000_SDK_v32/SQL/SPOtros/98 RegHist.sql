/***************************** RegHist ******************************************/
-- drop table CfgRegHist
/****** CfgRegHist ******/
if not exists(select * from SysTabla where SysTabla = 'CfgRegHist')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CfgRegHist','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CfgRegHist') and type = 'U') 
CREATE TABLE dbo.CfgRegHist (
	SysTabla		varchar(100)	NOT NULL,

	Estatus			varchar(15)	NULL,		-- ACTIVO, INACTIVO

	CONSTRAINT priCfgRegHist PRIMARY KEY  CLUSTERED (SysTabla)
)
GO
-- drop table CfgRegHistCampo
/****** CfgRegHistCampo ******/
if not exists(select * from SysTabla where SysTabla = 'CfgRegHistCampo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CfgRegHistCampo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CfgRegHistCampo') and type = 'U') 
CREATE TABLE dbo.CfgRegHistCampo (
	SysTabla		varchar(100)	NOT NULL,
	Campo			varchar(100)	NOT NULL,

	CONSTRAINT priCfgRegHistCampo PRIMARY KEY  CLUSTERED (SysTabla, Campo)
)
GO
-- drop table RegHist
/****** RegHist ******/
if not exists(select * from SysTabla where SysTabla = 'RegHist')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('RegHist','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.RegHist') and type = 'U') 
CREATE TABLE dbo.RegHist (
	SysTabla		varchar(100)	NOT NULL,
	Llave			varchar(750)	NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

	Fecha			datetime	NULL	DEFAULT GETDATE(),
	Empresa			varchar(5)	NULL,
	Sucursal		int		NULL,
	Usuario			varchar(10)	NULL,
	EstacionTrabajo		int		NULL,

	CONSTRAINT priRegHist PRIMARY KEY  CLUSTERED (SysTabla, Llave, ID)
)
GO

-- drop table RegHistD
/****** RegHistD ******/
if not exists(select * from SysTabla where SysTabla = 'RegHistD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('RegHistD','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.RegHistD') and type = 'U') 
CREATE TABLE dbo.RegHistD (
	SysTabla		varchar(100)	NOT NULL,
	Llave			varchar(750)	NOT NULL,
	ID			int		NOT NULL,
	RID			int		NOT NULL IDENTITY(1,1),

	Campo			varchar(255)	NULL,
	Valor			varchar(255)	NULL,
	ValorAnterior		varchar(255)	NULL,

	CONSTRAINT priRegHistD PRIMARY KEY  CLUSTERED (SysTabla, Llave, ID, RID)
)
GO

/****************************** spRegHistTriggerPK ******************************/
if exists (select * from sysobjects where id = object_id('dbo.spRegHistTriggerPK') and type = 'p') drop procedure dbo.spRegHistTriggerPK
GO
CREATE PROCEDURE spRegHistTriggerPK
			@Tabla			varchar(100),
			@PK			varchar(1000)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Valor	varchar(255)

  SELECT @PK = ''
  DECLARE crTablaPK CURSOR LOCAL FOR 
   SELECT n.Valor
     FROM dbo.fnTablaPK(@Tabla) e
     JOIN #Nueva n ON n.Campo = e.Campo
    ORDER BY e.Orden
  OPEN crTablaPK
  FETCH NEXT FROM crTablaPK INTO @Valor
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @PK <> '' SELECT @PK = @PK + '|'
      SELECT @PK = @PK + ISNULL(@Valor, '')
    END
    FETCH NEXT FROM crTablaPK INTO @Valor
  END  -- While
  CLOSE crTablaPK
  DEALLOCATE crTablaPK

  SELECT @PK = NULLIF(RTRIM(@PK), '')
  RETURN
END
GO

-- spRegHistTrigger 'Art', 'ACTIVO'
/****************************** spRegHistTrigger ******************************/
if exists (select * from sysobjects where id = object_id('dbo.spRegHistTrigger') and type = 'p') drop procedure dbo.spRegHistTrigger
GO
CREATE PROCEDURE spRegHistTrigger
			@Tabla		varchar(100),
			@Estatus	varchar(15)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SELECT			varchar(max),
    @SQL			varchar(max),
    @SQL1			varchar(max),
    @SQL2			varchar(max),
    @TABLE			varchar(max),
    
    @SQLINSERTED	varchar(max),
    @SQLDELETED		varchar(max)

  IF NOT EXISTS(SELECT * FROM sysobjects WHERE id = object_id(@Tabla) and type = 'U')
    RETURN

  SELECT @SQL = 'if exists (select * from sysobjects where id = object_id(''dbo.tgRegHist'+@Tabla+''') and sysstat & 0xf = 8) drop trigger dbo.tgRegHist'+@Tabla
  EXEC (@SQL)

  IF UPPER(@Estatus) <> 'ACTIVO' RETURN

  SELECT @SQL = '
  CREATE TRIGGER tgRegHist'+@Tabla+' ON '+@Tabla+'
  FOR INSERT, UPDATE
  AS BEGIN
    DECLARE
      @ID		int,
      @Llave		varchar(1000),
      @Empresa		varchar(5),
      @Sucursal		int,
      @Usuario		varchar(10),
      @EstacionTrabajo	int,
      @AccesoID		int

    IF dbo.fnEstaSincronizando() = 1 RETURN
  
    IF NOT EXISTS(SELECT * FROM Version WHERE RegHist = 1) RETURN
    IF NOT EXISTS(SELECT * FROM CfgRegHist WHERE SysTabla = '''+@Tabla+''' AND UPPER(Estatus) = ''ACTIVO'') RETURN
    IF (SELECT COUNT(*) FROM INSERTED) <> 1 RETURN
    SELECT @AccesoID = MAX(ID) FROM Acceso WHERE SPID = @@SPID
    SELECT @Empresa = Empresa, @Sucursal = Sucursal, @Usuario = Usuario, @EstacionTrabajo = EstacionTrabajo FROM Acceso WHERE ID = @AccesoID

    CREATE TABLE #Anterior (Campo varchar(255) COLLATE Database_Default NOT NULL, Valor varchar(255) COLLATE Database_Default NULL)
    CREATE TABLE #Nueva (Campo varchar(255) COLLATE Database_Default NOT NULL, Valor varchar(255) COLLATE Database_Default NULL)'

  EXEC spTablaEstructura @Tabla, @SELECT = @SELECT OUTPUT, @TABLE = @TABLE OUTPUT, @ExcluirTimeStamp = 1, @ExcluirCalculados = 1, @ExcluirImage = 1, @ExcluirBLOBs = 1, @Prefijo = 'CONVERT(varchar(255), ', @Sufijo = ')', @ASCampo = 1, @ReemplazarTipo = 'varchar(255)'

  SELECT @SQLINSERTED = ') SELECT ' + @SELECT + ' FROM INSERTED'
  SELECT @SQLDELETED = ') SELECT ' + @SELECT + ' FROM DELETED'  

  SELECT @SQL = @SQL + ' 
    CREATE TABLE #INSERTED(' + @TABLE + ')'

  SELECT @SQL = @SQL + ' 
    CREATE TABLE #DELETED(' + @TABLE + ')'

  SELECT @SQL1 = '(Campo, Valor) SELECT Campo, Valor FROM (SELECT '+@SELECT 
  EXEC spTablaEstructura @Tabla,  @SELECT = @SELECT OUTPUT, @TABLE = @TABLE OUTPUT, @ExcluirTimeStamp = 1, @ExcluirCalculados = 1, @ExcluirImage = 1, @ExcluirBLOBs = 1, @ReemplazarTipo = 'varchar(255)'

  SELECT @SQL = @SQL + '
    INSERT INTO #INSERTED(' + @SELECT + @SQLINSERTED
  SELECT @SQL = @SQL + '
    INSERT INTO #DELETED(' + @SELECT + @SQLDELETED  

  SELECT @SQL1 = @SQL1 +' FROM '
  SELECT @SQL2 = ') Origen UNPIVOT (Valor FOR Campo IN ('+@SELECT+')) AS Resultado'
  SELECT @SQL = @SQL + ' 
    INSERT #Anterior '+@SQL1 + '#DELETED'+@SQL2
  SELECT @SQL = @SQL + ' 
    INSERT #Nueva '+@SQL1 + '#INSERTED'+@SQL2
  SELECT @SQL = @SQL + ' 
    EXEC spRegHistTriggerPK '''+@Tabla+''', @Llave OUTPUT
    IF @Llave IS NOT NULL
    BEGIN
      INSERT RegHist (SysTabla, Llave, Empresa, Sucursal, Usuario, EstacionTrabajo) VALUES ('''+@Tabla+''', @Llave, @Empresa, @Sucursal, @Usuario, @EstacionTrabajo)
      SELECT @ID = SCOPE_IDENTITY()

      IF EXISTS(SELECT * FROM CfgRegHistCampo WHERE SysTabla = '''+@Tabla+''')
        INSERT RegHistD (SysTabla, Llave, ID, Campo,    Valor,   ValorAnterior)
        SELECT '''+@Tabla+''', @Llave, @ID, n.Campo, n.Valor, a.Valor
          FROM #Nueva n 
          LEFT OUTER JOIN #Anterior a ON a.Campo = n.Campo 
         WHERE ISNULL(a.Valor, '''') <> ISNULL(n.Valor, '''') AND n.Campo IN (SELECT Campo FROM CfgRegHistCampo WHERE SysTabla = '''+@Tabla+''')
      ELSE
        INSERT RegHistD (SysTabla, Llave, ID, Campo,    Valor,   ValorAnterior)
        SELECT '''+@Tabla+''', @Llave, @ID, n.Campo, n.Valor, a.Valor
          FROM #Nueva n 
          LEFT OUTER JOIN #Anterior a ON a.Campo = n.Campo 
         WHERE ISNULL(a.Valor, '''') <> ISNULL(n.Valor, '''') 
      IF @@ROWCOUNT = 0
        DELETE RegHist WHERE SysTabla = '''+@Tabla+''' AND Llave = @Llave AND ID = @ID
    END

    DROP TABLE #Anterior 
    DROP TABLE #Nueva 
  END'  
  
  EXEC (@SQL)
  RETURN
END
GO

-- select NombreCorto, * from cte
-- delete RegHist
-- delete RegHistD
-- update cte set nombrecorto = NULL
-- update cte set nombrecorto = 'uno' where cliente = 'c1'
/*
 select *  from CfgRegHist 
select *  from RegHist
 select *  from RegHistD
*/
-- INSERT CfgRegHist (SysTabla, Estatus) VALUES ('Cte', 'ACTIVO')
/****************************** spCfgRegHist ******************************/
if exists (select * from sysobjects where id = object_id('dbo.spCfgRegHist') and type = 'p') drop procedure dbo.spCfgRegHist
GO
CREATE PROCEDURE spCfgRegHist
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Tabla	varchar(100),
    @Estatus	varchar(15)

  DECLARE crCfgRegHist CURSOR LOCAL FOR 
   SELECT SysTabla, Estatus
     FROM CfgRegHist
    ORDER BY SysTabla
  OPEN crCfgRegHist
  FETCH NEXT FROM crCfgRegHist INTO @Tabla, @Estatus
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spRegHistTrigger @Tabla, @Estatus
    END
    FETCH NEXT FROM crCfgRegHist INTO @Tabla, @Estatus
  END  -- While
  CLOSE crCfgRegHist
  DEALLOCATE crCfgRegHist
  RETURN
END
GO

--Corrección Bug XXX
EXEC spCfgRegHist
GO
