-- spRenombrarEmpresa 'DEMO', 'DEMO2'


/**************** spRenombrarEmpresa ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRenombrarEmpresa') and type = 'P') drop procedure dbo.spRenombrarEmpresa
GO             
CREATE PROCEDURE spRenombrarEmpresa
			@EmpresaD	varchar(5), 
			@EmpresaA	varchar(5),
			@Ejecutar	bit	= 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Tabla	varchar(100),
    @Campo	varchar(100),
    @SQL	nvarchar(1000),
    @Conteo	int

  IF @Ejecutar = 0    
    CREATE TABLE #RenombrarEmpresa (Tabla varchar(100) COLLATE Database_Default NOT NULL, Campo varchar(100) COLLATE Database_Default NOT NULL, Registros int NULL)
  
  SELECT @EmpresaA = UPPER(@EmpresaA)
    
  DECLARE crTabla CURSOR FOR
   SELECT Tabla, Campo 
     FROM SysCampoExt 
    WHERE Campo LIKE '%Empresa%' AND EsCalculado = 0 AND Tipo='U' AND Ancho = 5

  OPEN crTabla
  FETCH NEXT FROM crTabla INTO @Tabla, @Campo
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @Ejecutar = 1
      BEGIN
        SELECT @SQL = N'DISABLE TRIGGER ALL ON '+@Tabla
        EXEC sp_executesql @SQL

        SELECT @SQL = N'UPDATE '+@Tabla+N' SET '+@Campo+N' = @EmpresaA WHERE '+@Campo+N' = @EmpresaD'
        EXEC sp_executesql @SQL, N'@EmpresaD varchar(5), @EmpresaA varchar(5)', @EmpresaD, @EmpresaA

        SELECT @SQL = N'ENABLE TRIGGER ALL ON '+@Tabla
        EXEC sp_executesql @SQL
      END ELSE 
      BEGIN
        SELECT @SQL = N'SELECT @Conteo = COUNT(*) FROM '+@Tabla+N' WHERE '+@Campo+N' = @EmpresaD'
        EXEC sp_executesql @SQL, N'@Conteo int OUTPUT, @EmpresaD varchar(5)', @Conteo OUTPUT, @EmpresaD
        IF @Conteo > 0 
          INSERT #RenombrarEmpresa (
                  Tabla,  Campo,  Registros) 
          VALUES (@Tabla, @Campo, @Conteo)
      END
    END
    FETCH NEXT FROM crTabla INTO @Tabla, @Campo
  END  -- While
  CLOSE crTabla
  DEALLOCATE crTabla
  
  IF @Ejecutar = 0 
    SELECT * FROM #RenombrarEmpresa

  RETURN
END
GO