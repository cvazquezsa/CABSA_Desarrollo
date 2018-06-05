/* Configuracion MS SQL Server */
SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

/**************** spNominaG4CargaArchivo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaG4CargaArchivo') and sysstat & 0xf = 4) drop procedure dbo.spNominaG4CargaArchivo
GO             
CREATE PROCEDURE spNominaG4CargaArchivo
                 @Estacion    INT,
                 @Empresa     VARCHAR(5),
                 @Sucursal    INT,
                 @ID          INT,
                 @OK          INT,
                 @PeriodoTipo VARCHAR(50),
                 @FechaD      DATETIME,
                 @FechaA      DATETIME,
                 @UUID        VARCHAR(101)
--//WITH ENCRYPTION                
AS BEGIN
  DECLARE     
    @Archivo            VARCHAR(500),
    @Bulk               VARCHAR(400),
    @Renglon	          FLOAT, 
    @Mov                VARCHAR(20),
    @IDNomX             INT,
    @Debug              BIT,
    @Directorio         VARCHAR(255),
    @Ruta               VARCHAR(255),
    @Ruta2              VARCHAR(255),
    @ComandShell        VARCHAR(255)
  
  SELECT @Mov = Mov FROM Nomina WHERE ID = @ID
  SELECT @IDNomX = ID FROM NomX WHERE NomMov = @Mov
  SELECT TOP 1 @Directorio = DirectorioArchivosZip, @Debug = ISNULL(Debug, 0)  FROM ServiciosG3 WHERE Servicio = 'Nomina' AND Estatus = 1
  SELECT @Ruta =    @Directorio+'\'+@UUID, 
         @Ruta2 =   @Directorio+'\'+@UUID+'CSV', 
         @Archivo = @Directorio+'\'+@UUID+'CSV\output.csv'
    
  --SELECT @Ruta = 'C:\Temp\BetaNomina\CSV\output.csv'
  --FROM NominaG4CFG WHERE Empresa = @Empresa
  SELECT @Renglon = 2048  
  TRUNCATE TABLE OutputNominaG4 

  CREATE TABLE #OutputNominaG4(      
      Personal    VARCHAR(100), 
      Cuenta      VARCHAR(100) NULL,
      Importe     VARCHAR(100) NULL,
      Cantidad    VARCHAR(100) NULL,
      Concepto    VARCHAR(100),
      Movimiento  VARCHAR(100) NULL,
      Fecha       VARCHAR(100) NULL,
      Grupo       VARCHAR(50)  NULL,    
      Objeto      VARCHAR(100) NULL,            
      )



  CREATE TABLE #OutputNominaG4_2(
      Personal          VARCHAR(100), 
      Cuenta            VARCHAR(100) NULL,
      Importe           VARCHAR(100) NULL,
      Cantidad          VARCHAR(100) NULL,
      Concepto          VARCHAR(100),
      ConceptoIntelisis VARCHAR(100) NULL,
      Movimiento        VARCHAR(100) NULL,
      Fecha             VARCHAR(100) NULL,
      Grupo             VARCHAR(50)  NULL,    
      Objeto            VARCHAR(100) NULL,
      TipoCuenta        VARCHAR(50)  NULL,
      CuentaContable    VARCHAR(50)  NULL,    
      TipoAgrupador     VARCHAR(50)  NULL,
      GrupoPersonal     VARCHAR(50)  NULL,
      CentroCostos      VARCHAR(20)  NULL,
      Departamento      VARCHAR(50)  NULL,
      Puesto            VARCHAR(50)  NULL,
      UEN               INT          NULL,
      SucursalTrabajo   INT          NULL,
      Area              VARCHAR(50)  NULL,
      Proyecto          VARCHAR(50)  NULL,
      Categoria         VARCHAR(50)  NULL,
      Renglon           INT IDENTITY(2048, 2048),
      CuentaD           VARCHAR(10)  NULL,
constraint priOutputNominaG4_2 primary key clustered (Renglon)
      )
CREATE NONCLUSTERED INDEX Compuesto
ON #OutputNominaG4_2 ([Personal],[Objeto])
INCLUDE ([Importe],[Cantidad],[Concepto],[Fecha],[Grupo],[Renglon])

          
  SELECT @Bulk = 'BULK
    INSERT #OutputNominaG4 
    FROM '''+@Archivo+''' 
    WITH
    ( FIELDTERMINATOR = ''|'',
      ROWTERMINATOR = ''0x0a'',
      CODEPAGE = ''ACP'' )'

  EXEC(@Bulk)
  
  INSERT INTO #OutputNominaG4_2 (Personal,      Cuenta,         Importe,        Cantidad,   Concepto,   ConceptoIntelisis, Movimiento,    Fecha,   Grupo,      Objeto,   TipoCuenta,   TipoAgrupador,   CuentaContable, 
                                 GrupoPersonal, CentroCostos,   Departamento,   Puesto,     UEN,        SucursalTrabajo,   Area,          Proyecto,   Categoria)
       SELECT                    o.Personal,    o.Cuenta,       o.Importe,      o.Cantidad, o.Concepto, n.Concepto,        o.Movimiento,  o.Fecha, o.Grupo,    o.Objeto, n.TipoCuenta, n.TipoAgrupador, CASE WHEN n.TipoCuenta = 'Especifica' THEN n.CuentaEspecifica ELSE CASE WHEN n.TipoCuenta = 'Personal' THEN p.Cuenta ELSE CASE WHEN n.TipoCuenta = 'Personal Retencion' THEN p.CuentaRetencion ELSE NULL END END END,
                                 p.Grupo,       p.CentroCostos, p.Departamento, p.Puesto,   p.UEN,      p.SucursalTrabajo, p.Area,  p.Proyecto, p.Categoria
         FROM #OutputNominaG4 o
         JOIN Personal p on p.Personal = o.Personal
         JOIN NominaConceptoEx n ON n.Clave = o.Concepto AND n.Objeto = o.Objeto AND n.IDNomX = @IDNomX         
        WHERE n.Ocultar = 'no'
        ORDER BY Personal, Movimiento

       UPDATE o SET o.CuentaContable = n.Cuenta
         FROM #OutputNominaG4_2 o  JOIN NominaG4TablaCuentas n ON n.Clave = o.Concepto AND n.Objeto = o.Objeto AND n.IDNomX = @IDNomX AND o.TipoAgrupador = n.TipoAgrupador AND n.Valor = o.GrupoPersonal 
        WHERE o.TipoCuenta = 'Tabla'  AND o.TipoAgrupador = 'Grupo' 

       UPDATE o SET o.CuentaContable = n.Cuenta
         FROM #OutputNominaG4_2 o  JOIN NominaG4TablaCuentas n ON n.Clave = o.Concepto AND n.Objeto = o.Objeto AND n.IDNomX = @IDNomX AND o.TipoAgrupador = n.TipoAgrupador AND n.Valor = o.CentroCostos 
        WHERE o.TipoCuenta = 'Tabla'  AND o.TipoAgrupador = 'CentroCostos' 

       UPDATE o SET o.CuentaContable = n.Cuenta
         FROM #OutputNominaG4_2 o  JOIN NominaG4TablaCuentas n ON n.Clave = o.Concepto AND n.Objeto = o.Objeto AND n.IDNomX = @IDNomX AND o.TipoAgrupador = n.TipoAgrupador AND n.Valor = o.Departamento 
        WHERE o.TipoCuenta = 'Tabla'  AND o.TipoAgrupador = 'Departamento' 

       UPDATE o SET o.CuentaContable = n.Cuenta
         FROM #OutputNominaG4_2 o  JOIN NominaG4TablaCuentas n ON n.Clave = o.Concepto AND n.Objeto = o.Objeto AND n.IDNomX = @IDNomX AND o.TipoAgrupador = n.TipoAgrupador AND n.Valor = o.Puesto 
        WHERE o.TipoCuenta = 'Tabla'  AND o.TipoAgrupador = 'Puesto' 

       UPDATE o SET o.CuentaContable = n.Cuenta
         FROM #OutputNominaG4_2 o  JOIN NominaG4TablaCuentas n ON n.Clave = o.Concepto AND n.Objeto = o.Objeto AND n.IDNomX = @IDNomX AND o.TipoAgrupador = n.TipoAgrupador AND n.Valor = o.UEN 
        WHERE o.TipoCuenta = 'Tabla'  AND o.TipoAgrupador = 'UEN'

       UPDATE o SET o.CuentaContable = n.Cuenta
         FROM #OutputNominaG4_2 o  JOIN NominaG4TablaCuentas n ON n.Clave = o.Concepto AND n.Objeto = o.Objeto AND n.IDNomX = @IDNomX AND o.TipoAgrupador = n.TipoAgrupador AND n.Valor = o.SucursalTrabajo 
        WHERE o.TipoCuenta = 'Tabla'  AND o.TipoAgrupador = 'SucursalTrabajo' 

       UPDATE o SET o.CuentaContable = n.Cuenta
         FROM #OutputNominaG4_2 o  JOIN NominaG4TablaCuentas n ON n.Clave = o.Concepto AND n.Objeto = o.Objeto AND n.IDNomX = @IDNomX AND o.TipoAgrupador = n.TipoAgrupador AND n.Valor = o.Area 
        WHERE o.TipoCuenta = 'Tabla'  AND o.TipoAgrupador = 'Area' 

       UPDATE o SET o.CuentaContable = n.Cuenta
         FROM #OutputNominaG4_2 o  JOIN NominaG4TablaCuentas n ON n.Clave = o.Concepto AND n.Objeto = o.Objeto AND n.IDNomX = @IDNomX AND o.TipoAgrupador = n.TipoAgrupador AND n.Valor = o.Proyecto 
        WHERE o.TipoCuenta = 'Tabla'  AND o.TipoAgrupador = 'Proyecto'

       UPDATE o SET o.CuentaContable = n.Cuenta
         FROM #OutputNominaG4_2 o  JOIN NominaG4TablaCuentas n ON n.Clave = o.Concepto AND n.Objeto = o.Objeto AND n.IDNomX = @IDNomX AND o.TipoAgrupador = n.TipoAgrupador AND n.Valor = o.Categoria 
        WHERE o.TipoCuenta = 'Tabla'  AND o.TipoAgrupador = 'Categoria'

    INSERT INTO #OutputNominaG4_2 (Personal,   Cuenta,   Importe, Cantidad, Concepto,   Movimiento,   Fecha, Grupo,   Objeto,   CuentaD, ConceptoIntelisis)
         SELECT                    o.Personal, o.Cuenta, Importe, Cantidad, o.Concepto, o.Movimiento, Fecha, o.Grupo, o.Objeto, p.Valor, n.Concepto 
           FROM #OutputNominaG4 o         
           JOIN NominaConceptoEx n ON n.Clave = o.Concepto AND n.Objeto = o.Objeto AND n.IDNomX = @IDNomX 
           LEFT JOIN PersonalPropValor p ON p.Propiedad = n.AcreedorPropiedad AND p.Cuenta = @Empresa AND p.Rama = 'EMP'        
          WHERE ISNULL(o.Personal, '') = '' AND n.Ocultar = 'no' 

  IF @OK = 200
  BEGIN
   
     INSERT INTO NominaD (ID,   Renglon,   Modulo, Personal,   Importe,   Cantidad,   Concepto,            FechaA,                     Movimiento,   Sucursal,  SucursalOrigen, CuentaContable)
          SELECT          @ID,  o.Renglon, 'NOM',  o.Personal, o.Importe, o.Cantidad, o.ConceptoIntelisis, CONVERT(DATETIME, o.Fecha), o.Movimiento, @Sucursal, @Sucursal,      o.CuentaContable
             FROM #OutputNominaG4_2 o 
             WHERE ISNULL(o.Personal, '') <> '' 
  
     INSERT INTO NominaD (ID,  Renglon,   Modulo, Cuenta,                      Importe,   Concepto,            FechaA,  Movimiento,  Sucursal,  SucursalOrigen)                 
          SELECT          @ID, o.Renglon, 'CXP',  ISNULL(o.Cuenta, o.CuentaD), o.Importe, o.ConceptoIntelisis, o.Fecha, 'por Pagar', @Sucursal, @Sucursal
       FROM #OutputNominaG4_2 o 
       WHERE ISNULL(o.Personal, '') = '' 

    UPDATE Nomina SET PeriodoTipo = @PeriodoTipo, FechaD = @FechaD, FechaA = @FechaA, Estatus = 'BORRADOR' WHERE ID = @ID

    IF @Debug = 0
    BEGIN
      SELECT @ComandShell = 'rd '+ @Ruta  +' /S /Q;' 
      EXEC xp_cmdshell @ComandShell, NO_OUTPUT  

      SELECT @ComandShell = 'rd '+ @Ruta2  +' /S /Q;' 
      EXEC xp_cmdshell @ComandShell, NO_OUTPUT  
    END

    SELECT 'Proceso Concluido'  
  END
  ELSE 
  BEGIN
    SELECT 'Proceso Concluido Con Errores'  
  END

END
GO
--EXEC spNominaG4CargaArchivo 100, 'SHMEX', 0, 4632, 200, 'Quincenal Periodo ', '08/31/2015 00:00:00', '08/31/2015 00:00:00'


/**************** spNominaG4Acumulados ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaG4Acumulados') and sysstat & 0xf = 4) drop procedure dbo.spNominaG4Acumulados
GO             
CREATE PROCEDURE spNominaG4Acumulados
                 @Estacion      INT,
                 @Empresa       VARCHAR(5),
                 @Sucursal      INT,
                 @ID            INT,
                 @PeriodoTipo   VARCHAR(50),
                 @FechaD        DATETIME,
                 @FechaA        DATETIME,
                 @TipoNominaG4  VARCHAR(50)
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE
    @Ultima           VARCHAR(2),
    @FinBimestre      VARCHAR(2),
    @FinAno           VARCHAR(2),
    @Periodo          INT,
    @Ejercicio        INT,    
    @Bimestre         INT,
    @FechaInicioP     DATETIME,
    @FechaInicioB     DATETIME,
    @FechaInicioA     DATETIME,
    @FechaFin         DATETIME,
    @AcumuladoClave   VARCHAR(100), 
    @AcumuladoObjeto  VARCHAR(100), 
    @Concepto         VARCHAR(100),
    @TipoDato         VARCHAR(20),
    @Clave            VARCHAR(100),
    @Mov              VARCHAR(20),
    @IDNomX           INT,
    @Primera          VARCHAR(2)
  
  SELECT @Mov = Mov FROM Nomina WHERE ID = @ID
  SELECT @IDNomX = ID FROM NomX WHERE NomMov = @Mov

  DELETE NominaAcumuladoInicial WHERE Estacion = @Estacion

  CREATE TABLE #Acumulados (Clave VARCHAR(100), AcumuladoClave VARCHAR(100), AcumuladoObjeto VARCHAR(100), AplicaCalendario VARCHAR(50), Concepto VARCHAR(100) NULL, TipoDato VARCHAR(20) NULL, FechaInicio DATETIME NULL, FechaFin DATETIME NULL, Aplica BIT DEFAULT 0)

  INSERT INTO #Acumulados (Clave, AcumuladoClave, AcumuladoObjeto, AplicaCalendario)
       SELECT Clave, AcumuladoClave, AcumuladoObjeto, AplicaCalendario 
         FROM NominaConceptoEx WHERE Tipo = 'Acumulado' AND ISNULL(LTRIM(AcumuladoClave), '') <> '' AND IDNomX = @IDNomX

  UPDATE a SET a.Concepto = n.Concepto, a.TipoDato = n.TipoDato
    FROM #Acumulados a join NominaConceptoEx n on a.AcumuladoClave = n.Clave AND a.AcumuladoObjeto = n.Objeto

  SELECT @FechaFin = @FechaA
  SELECT @Periodo = Periodo, @Ejercicio = Ejercicio, @Bimestre = Bimestre, @Ultima = Ultima, @FinBimestre = FinBimestre, @FinAno = FinAno, @Primera = Primera FROM NominaG4Calendario WHERE TipoPeriodo = @PeriodoTipo AND Tiempo = @FechaA  


  IF @TipoNominaG4 = 'Nomina Normal'
  BEGIN
    IF @Ultima = 'Si'
    BEGIN
      SELECT @FechaInicioP = MIN(Fin) FROM NominaG4Calendario WHERE TipoPeriodo = @PeriodoTipo AND Periodo = @Periodo AND Ejercicio = @Ejercicio  
      UPDATE #Acumulados SET FechaInicio = @FechaInicioP, FechaFin = @FechaFin, Aplica = 1 WHERE AplicaCalendario = 'Ultima'    
    END
    IF @FinBimestre = 'Si'
    BEGIN
      SELECT @FechaInicioB = MIN(Fin) FROM NominaG4Calendario WHERE TipoPeriodo = @PeriodoTipo AND Bimestre = @Bimestre AND Ejercicio = @Ejercicio  
      UPDATE #Acumulados SET FechaInicio = @FechaInicioB, FechaFin = @FechaFin, Aplica = 1 WHERE AplicaCalendario = 'FinBimestre'    
    END
    IF @FinAno = 'Si'
    BEGIN
      SELECT @FechaInicioA = MIN(Fin) FROM NominaG4Calendario WHERE TipoPeriodo = @PeriodoTipo AND Ejercicio = @Ejercicio  
      UPDATE #Acumulados SET FechaInicio = @FechaInicioA, FechaFin = @FechaFin, Aplica = 1 WHERE AplicaCalendario = 'FinAno'    
    END
    IF @Primera = 'No'
    BEGIN
	    SELECT @FechaInicioP = MIN(Fin) FROM NominaG4Calendario WHERE TipoPeriodo = @PeriodoTipo AND Periodo = @Periodo AND Ejercicio = @Ejercicio
      UPDATE #Acumulados SET FechaInicio = @FechaInicioP, FechaFin = @FechaFin, Aplica = 1 WHERE AplicaCalendario = 'PrimeraNo'
    END
  END
  ELSE
  IF @TipoNominaG4 IN('Nomina Finiquito', 'Nomina Liquidacion')
  BEGIN
    IF @Ultima = 'Si'
    BEGIN
      SELECT @FechaInicioP = MIN(Fin) FROM NominaG4Calendario WHERE TipoPeriodo = @PeriodoTipo AND Periodo = @Periodo AND Ejercicio = @Ejercicio 
      UPDATE #Acumulados SET FechaInicio = @FechaInicioP, FechaFin = @FechaFin, Aplica = 1 WHERE AplicaCalendario = 'Ultima'    
    END
    IF @FinBimestre = 'Si'
    BEGIN
      SELECT @FechaInicioB = MIN(Fin) FROM NominaG4Calendario WHERE TipoPeriodo = @PeriodoTipo AND Bimestre = @Bimestre AND Ejercicio = @Ejercicio 
      UPDATE #Acumulados SET FechaInicio = @FechaInicioB, FechaFin = @FechaFin, Aplica = 1 WHERE AplicaCalendario = 'FinBimestre'    
    END
    IF @FinAno = 'Si'
    BEGIN
      SELECT @FechaInicioA = MIN(Fin) FROM NominaG4Calendario WHERE TipoPeriodo = @PeriodoTipo AND Ejercicio = @Ejercicio 
      UPDATE #Acumulados SET FechaInicio = @FechaInicioA, FechaFin = @FechaFin, Aplica = 1 WHERE AplicaCalendario = 'FinAno'    
    END
    IF @Primera = 'No'
    BEGIN
	    SELECT @FechaInicioP = MIN(Fin) FROM NominaG4Calendario WHERE TipoPeriodo = @PeriodoTipo AND Periodo = @Periodo AND Ejercicio = @Ejercicio
      UPDATE #Acumulados SET FechaInicio = @FechaInicioP, FechaFin = @FechaFin, Aplica = 1 WHERE AplicaCalendario = 'PrimeraNo'
    END

  END


  DECLARE crDatos CURSOR LOCAL FOR
  SELECT Clave, AcumuladoClave, AcumuladoObjeto, Concepto, FechaInicio, FechaFin, TipoDato
    FROM #Acumulados
   WHERE ISNULL(LTRIM(Concepto), '') <> '' AND Aplica = 1
  OPEN crDatos
  FETCH NEXT FROM crDatos INTO @Clave, @AcumuladoClave, @AcumuladoObjeto, @Concepto, @FechaInicioA, @FechaFin, @TipoDato
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN

      INSERT INTO NominaAcumuladoInicial (Estacion, _id, Acumulado, Importe)
      SELECT @Estacion, nd.Personal, @Clave, CASE WHEN @TipoDato = 'Importe' THEN SUM(nd.Importe) ELSE SUM(nd.Cantidad) END AS Importe
       FROM Nomina n 
            JOIN MovTipo mt ON mt.Mov = n.Mov AND mt.Modulo = 'NOM' 
            JOIN NominaD nd ON nd.ID = n.ID
            JOIN ListaSt l ON l.Clave = nd.Personal
       WHERE Estatus = 'CONCLUIDO' AND Empresa = @Empresa AND mt.Clave = 'NOM.N' AND n.FechaA BETWEEN @FechaInicioA AND @FechaFin AND nd.Concepto = @Concepto AND l.Estacion = @Estacion
       GROUP BY nd.Personal
      
      FETCH NEXT FROM crDatos INTO @Clave, @AcumuladoClave, @AcumuladoObjeto, @Concepto, @FechaInicioA, @FechaFin, @TipoDato
    END
  END
  CLOSE crDatos
  DEALLOCATE crDatos

  RETURN
END
GO
--EXEC spNominaG4Acumulados 5, 'SHMEX', 0, 4589, 'Quincenal Periodo', '12/16/2015 00:00:00', '12/30/2015 00:00:00'

/**************** spNominaG4Incidencias ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaG4Incidencias') and sysstat & 0xf = 4) drop procedure dbo.spNominaG4Incidencias
GO             
CREATE PROCEDURE spNominaG4Incidencias
                 @Estacion      INT,
                 @Empresa       VARCHAR(5),
                 @TipoNominaG4  VARCHAR(50)
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE
    @Personal VARCHAR(10),
    @Valor    VARCHAR(100),
    @Importe  MONEY,
    @Cantidad MONEY,
    @TipoDato VARCHAR(20),
    @Clave    VARCHAR(100),
    @Concepto VARCHAR(100),   
    @MovTipo  VARCHAR(20)
    

  DECLARE crDatos CURSOR LOCAL FOR -- Inicio Primer Cursor
  SELECT ni.Clave
    FROM ListaSt ni         
   WHERE ni.Estacion = @Estacion
  OPEN crDatos
  FETCH NEXT FROM crDatos INTO @Personal
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      DECLARE crDatos2 CURSOR LOCAL FOR -- Inicio Segundo Cursor
      SELECT nc.Clave, nc.Concepto, nc.TipoDato, mt.Clave
        FROM NominaConceptoEx nc
              LEFT join MovTipo mt ON mt.Mov = nc.Concepto AND mt.Modulo = 'NOM'             
        WHERE nc.Tipo = 'Incidencia' AND isnull(Concepto, '') <> ''
      OPEN crDatos2
      FETCH NEXT FROM crDatos2 INTO @Clave, @Concepto, @TipoDato, @MovTipo
      WHILE @@FETCH_STATUS <> -1 
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN          
          SELECT @Valor = ''
          IF @TipoNominaG4 = 'Nomina Normal'
          IF @MovTipo <> 'NOM.PD'
            SELECT  @Importe = sum(nd.Importe), @Cantidad = sum(nd.Cantidad)
              FROM Nomina n                  
                    LEFT JOIN NominaD nd ON n.ID = nd.ID
                    LEFT join MovTipo mt ON mt.Mov = n.Mov AND mt.Modulo = 'NOM'
              WHERE n.Estatus IN ('PROCESAR', 'PORPROCESAR') AND n.Mov = @Concepto AND nd.Personal = @Personal
          ELSE
            SELECT  @Importe = SUM(nd.Monto), @Cantidad = SUM(nd.Cantidad)
              FROM Nomina n                  
                    LEFT JOIN NominaD nd ON n.ID = nd.ID
                    LEFT join MovTipo mt ON mt.Mov = n.Mov AND mt.Modulo = 'NOM'
              WHERE n.Estatus IN ('VIGENTE') AND n.Mov = @Concepto AND nd.Personal = @Personal
          ELSE
          IF @TipoNominaG4 IN('Nomina Finiquito', 'Nomina Liquidacion')
          BEGIN            
          IF @MovTipo <> 'NOM.PD'
            SELECT  @Importe = sum(nd.Importe), @Cantidad = sum(nd.Cantidad)
              FROM Nomina n                  
                    LEFT JOIN NominaD nd ON n.ID = nd.ID
                    LEFT join MovTipo mt ON mt.Mov = n.Mov AND mt.Modulo = 'NOM'
              WHERE n.Estatus IN ('PROCESAR', 'PORPROCESAR') AND n.Mov = @Concepto AND nd.Personal = @Personal
          ELSE
            SELECT  @Importe = sum(nd.Saldo), @Cantidad = sum(nd.Cantidad)
              FROM Nomina n                  
                    LEFT JOIN NominaD nd ON n.ID = nd.ID
                    LEFT join MovTipo mt ON mt.Mov = n.Mov AND mt.Modulo = 'NOM'
              WHERE n.Estatus IN ('VIGENTE') AND n.Mov = @Concepto AND nd.Personal = @Personal
          END

          IF @TipoDato = 'Importe'
          SELECT @Valor = CONVERT( VARCHAR(100), @Importe )
          ELSE
          IF @TipoDato = 'Cantidad'
            SELECT @Valor = CONVERT( VARCHAR(100), @Cantidad )
          ELSE 
            SELECT @Valor = ''

          IF LTRIM(@Valor) <> ''
          BEGIN
            INSERT NominaIncidenciaG4 (Estacion,  element1,  element2, value)
            VALUES                    (@Estacion, @Personal, @Clave,   @Valor)
          END

          FETCH NEXT FROM crDatos2 INTO @Clave, @Concepto, @TipoDato, @MovTipo
        END
      END
      CLOSE crDatos2
      DEALLOCATE crDatos2  -- Fin Segundo Cursor

      FETCH NEXT FROM crDatos INTO @Personal
    END
  END
  CLOSE crDatos
  DEALLOCATE crDatos -- Fin Primer Cursor

  RETURN
END
GO

/**************** spNominaG4Archivos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaG4Archivos') and sysstat & 0xf = 4) drop procedure dbo.spNominaG4Archivos
GO             
CREATE PROCEDURE spNominaG4Archivos
                 @Estacion      INT,
                 @Empresa       VARCHAR(5),
                 @Sucursal      INT,
                 @ID            INT,
                 @PeriodoTipo   VARCHAR(50),
                 @FechaD        DATETIME,
                 @FechaA        DATETIME,
                 @TipoNominaG4  VARCHAR(50)
--//WITH ENCRYPTION
AS BEGIN
DECLARE
 @Clave                   VARCHAR(200), 
 @Concepto                VARCHAR(200), 
 @Personal                VARCHAR(10),
 @vchSql                  nVARCHAR(4000),
 @bcp                     nVARCHAR(4000),
 @Base                    VARCHAR(100),
 @TipoDato                VARCHAR(20),
 @Valor                   VARCHAR(100),
 @Importe                 MONEY,
 @Cantidad                MONEY,
 @Ok                      VARCHAR(10), 
 @OkRef                   VARCHAR(255),
 @result                  VARCHAR(max),
 @URL                     VARCHAR(200),
 @Funcion                 nVARCHAR(4000),
 @Parmetros               nVARCHAR(4000),
 @FechaDD                 CHAR(10),
 @FechaAA                 CHAR(10),
 @IDD                     VARCHAR(200),
 @ProcessID               VARCHAR(50), 
 @Mov                     VARCHAR(20),
 @SucursalT               VARCHAR(10),
 @FechaEmision            CHAR(10),
 @Rama                    VARCHAR(3),
 @IDNomX                  INT,
 @API                     VARCHAR(100),
 @XML                     XML,
 @Usuario                 varchar(10),
 @Json                    VARCHAR(MAX)

  DELETE NominaPersonalPropiedadG4 WHERE Estacion = @Estacion
  DELETE PersonalIncidenciaG4      WHERE Estacion = @Estacion
  DELETE NominaIncidenciaG4        WHERE Estacion = @Estacion
  DELETE NominaEmpresaPropiedadG4  WHERE Estacion = @Estacion
  DELETE NominaConceptosG4         WHERE Estacion = @Estacion
  DELETE NominaPersonalG4          WHERE Estacion = @Estacion
  DELETE ServicioJSON              WHERE Estacion = @Estacion

  SELECT TOP 1 @URL = URL, @API = ISNULL(API, 'API') FROM ServiciosG3 WHERE Servicio = 'Nomina' AND Estatus = 1
  SELECT @FechaDD = CONVERT(char(10),@FechaD, 126), @FechaAA = CONVERT(char(10),@FechaA, 126), @Base =  DB_NAME(), @IDD = CONVERT(varchar(200), @ID), @ProcessID = NEWID(), @SucursalT = CONVERT(VARCHAR(10), @Sucursal)
  SELECT @Mov = Mov, @FechaEmision = CONVERT(char(10),FechaEmision, 126), @Usuario = Usuario FROM Nomina WHERE ID = @ID
  SELECT @IDNomX = ID FROM NomX WHERE NomMov = @Mov

  --IF @TipoNominaG4 = 'Nomina Finiquito'
  --  SELECT 
  
  ---- 01.Nomina.Conceptos.csv
  INSERT INTO NominaConceptosG4 (Estacion,  Clave, Tipo, Objeto, Orden, Ocultar, TipoDato, Concepto2, EnCero, Grupo)
       SELECT                    @Estacion, Clave, Tipo, Objeto, Orden, Ocultar, TipoDato, Concepto2, EnCero, Grupo 
         FROM NominaConceptoEx 
        WHERE IDNomX IN (@IDNomX, 0)
     ORDER BY ISNULL(Orden, 1000), Clave

 ---- 10.Nomina.Empresa.Propiedad.csv
  INSERT INTO NominaEmpresaPropiedadG4 (Estacion, element1, element2, value) 
       SELECT @Estacion, pp.Cuenta, Clave, pp.Valor
         FROM NominaConceptoEx nc          
              JOIN  PersonalPropValor pp ON rtrim(pp.Propiedad) = rtrim(nc.Concepto) AND pp.Rama = 'EMP' AND pp.Cuenta =  @Empresa
        WHERE nc.Tipo = 'EmpresaPropiedad' 

 ---- 20.Nomina.Personal.csv
  INSERT INTO NominaPersonalG4 (Estacion,  Personal,   Sindicato,                                                               FechaAntiguedad,                          FechaAlta,                          PeriodoTipo,                                                                                                                                                       UltimoPago,                          FechaBaja,                                                                                                                                                            SueldoMensual,     Empresa) 
       SELECT                   @Estacion, p.Personal, CASE WHEN Sindicato = '(Confianza)' THEN 'Confianza' ELSE Sindicato END, CONVERT(char(10),p.FechaAntiguedad, 126), CONVERT(char(10),p.FechaAlta, 126), CASE WHEN p.PeriodoTipo = 'Quincenal' THEN CASE WHEN p.DiasPeriodo = 'Dias Periodo' THEN 'Quincenal Periodo' ELSE 'Quincenal Natural' END ELSE p.PeriodoTipo END , CONVERT(char(10),p.UltimoPago, 126), CASE WHEN @TipoNominaG4 in('Nomina Finiquito', 'Nomina Liquidacion') AND ISNULL(CONVERT(char(10),p.FechaBaja, 126), '') = '' THEN @FechaEmision ELSE CONVERT(char(10),p.FechaBaja, 126) END , p.SueldoDiario*30, Empresa 
         FROM Personal p 
        INNER JOIN Listast l on p.Personal = l.Clave 
       WHERE DiasPeriodo <> 'Dias Jornada' AND l.Estacion=@Estacion
  
  ---- 50.Nomina.Personal.Propiedad.csv  
  CREATE TABLE #PersonalPropiedadTemp (Personal varchar(50), Sucursal INT)
  INSERT INTO #PersonalPropiedadTemp (Personal, Sucursal) SELECT Personal, SucursalTrabajo FROM Personal INNER JOIN Listast l ON Personal = l.Clave WHERE l.Estacion = @Estacion

  INSERT INTO NominaPersonalPropiedadG4 (Estacion,  element1,  element2, value) 
       SELECT                            @Estacion, pp.Cuenta, nc.Clave, pp.Valor
         FROM NominaConceptoEx nc              
              JOIN PersonalPropValor pp ON rtrim(pp.Propiedad) = rtrim(nc.Concepto) AND pp.Rama = 'PER'
              JOIN PersonalProp ppa ON ppa.Propiedad = pp.Propiedad
              JOIN Listast l ON l.Clave = pp.Cuenta 
        WHERE nc.Tipo = 'PersonalPropiedad' AND isnull(Concepto, '') <> '' AND isnull(Valor, '') <> '' AND l.Estacion = @Estacion AND ppa.NivelPersonal = 1
        ORDER BY pp.Cuenta, nc.Clave

  INSERT INTO NominaPersonalPropiedadG4 (Estacion,  element1,   element2, value) 
       SELECT                            @Estacion, p.Personal, nc.Clave, Valor
         FROM #PersonalPropiedadTemp p          
              JOIN PersonalPropValor pp ON pp.Cuenta = p.Sucursal AND pp.Rama = 'SUC' 
              JOIN PersonalProp ppa ON ppa.Propiedad = pp.Propiedad
              JOIN NominaConceptoEx nc ON rtrim(nc.Concepto) = rtrim(pp.Propiedad) 
        WHERE nc.Tipo = 'PersonalPropiedad' AND isnull(nc.Concepto, '') <> '' AND ppa.NivelSucursal = 1
        ORDER BY pp.Cuenta

  -- 30.Nomina.Acumulado.Inicial.csv
  EXEC spNominaG4Acumulados @Estacion, @Empresa, @Sucursal, @ID, @PeriodoTipo, @FechaD, @FechaA, @TipoNominaG4

  -- 40.Nomina.Incidencia.csv
  EXEC spNominaG4Incidencias @Estacion, @Empresa, @TipoNominaG4

  --SELECT 'Calendario'as Action, @ProcessID as Process_id, @Empresa as company, @Sucursal as subCompany, getdate() as date, 'Nomina5000' as tenant_id, 'G3' as system, '2' as ordenSemana, @Usuario as Usuario
  --  INTO #TablaDatos
 
  SET @XML = (SELECT * FROM (SELECT 'draft' as action, @IDD as document_id, @ProcessID as process_id, @TipoNominaG4 as documentType, @Mov as documentName, @Empresa as company, @SucursalT as subCompany, @FechaEmision as date, @Base as tenant_id, 'G3' as system, @PeriodoTipo as periodType, @FechaDD as startDate, @FechaAA as endDate) as ServicioG3 FOR XML AUTO, ELEMENTS)

  SELECT @Json = dbo.XML2JSON(@XML)

  SELECT @Json = REPLACE(LTRIM(@Json), '{"ServicioG3":', '')
  SELECT @Json = REPLACE(@Json, '}}', '}')

  INSERT INTO ServicioJSON (Estacion, Dato)
      SELECT @Estacion, @Json

  ----- Inicio API de G3 -----
  SELECT @TipoNominaG4 = REPLACE(@TipoNominaG4, ' ', '%20'), @Mov = REPLACE(@Mov, ' ', '%20'), @Empresa = REPLACE(@Empresa, ' ', '%20'), @Base = REPLACE(@Base, ' ', '%20'), @PeriodoTipo = REPLACE(@PeriodoTipo, ' ', '%20')  
  --SELECT @Funcion = N'SELECT @resultOUT = dbo.Int2API_beta('''+@API+''', ''/BetaNomina?URL='+isnull(@URL, '')+'&Modulo=Nomina&Estacion='+Convert(varchar(4), @Estacion)+'&action=draft&document_id='+@IDD+'&process_id='+@ProcessID+'&documentType='+@TipoNominaG4+'&documentName='+@Mov+'&company='+@Empresa+'&subCompany='+@SucursalT+'&date='+@FechaEmision+'&tenant_id='+@Base+'&system=G3'+'&periodType='+@PeriodoTipo+'&startDate='+@FechaDD+'&endDate='+@FechaAA+''', ''intelisis'', ''apifirst'')'
  
  SELECT @Funcion = N'SELECT @resultOUT = dbo.Int2API_beta('''+@API+''', ''/BetaNomina?URL='+isnull(@URL, '')+'&Modulo=Nomina&Estacion='+Convert(varchar(4), @Estacion)+'&process_id='+@ProcessID+''', ''intelisis'', ''apifirst'')'

  SELECT @Parmetros = N'@resultOUT varchar(MAX) OUTPUT'
  
  --SELECT @Funcion
  
  EXECUTE sp_executesql @Funcion, @Parmetros, @resultOUT = @result OUTPUT
  
  SELECT @Ok = replace(substring(@result, charindex(upper('OK'), upper(@result)) + 4, charindex(upper('OkRef'), upper(@result))-charindex(upper('OK'), upper(@result))-4-2), '"', '')
  SELECT @OkRef = replace(substring(@result, charindex(upper('OkRef'), upper(@result)) + 7, charindex(upper('}'), upper(@result))-charindex(upper('OkRef'), upper(@result))-7), '"', '')
  ----- Fin API de G3  -----
  
  IF @Ok IN ('200', '205')
  BEGIN
    SELECT @PeriodoTipo = REPLACE(@PeriodoTipo, '%20', ' ')  
    EXEC spNominaG4CargaArchivo @Estacion, @Empresa, @Sucursal, @ID, @Ok, @PeriodoTipo, @FechaD, @FechaA, @ProcessID           
  END
  ELSE
    SELECT @Ok+': '+@OkRef

  DELETE NominaPersonalPropiedadG4 WHERE Estacion = @Estacion
  DELETE PersonalIncidenciaG4      WHERE Estacion = @Estacion
  DELETE NominaIncidenciaG4        WHERE Estacion = @Estacion
  DELETE NominaEmpresaPropiedadG4  WHERE Estacion = @Estacion
  DELETE NominaConceptosG4         WHERE Estacion = @Estacion
  DELETE NominaPersonalG4          WHERE Estacion = @Estacion
  DELETE ServicioJSON              WHERE Estacion = @Estacion

END
GO
--EXEC spNominaG4 1, 'SHMEX', 0, 5852, 'Quincenal Periodo', '12/16/2015 00:00:00', '12/30/2015 00:00:00'


/**************** spNominaG4Validar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaG4Validar') and sysstat & 0xf = 4) drop procedure dbo.spNominaG4Validar
GO             
CREATE PROCEDURE spNominaG4Validar
                 @Estacion      INT,
                 @Empresa       VARCHAR(5),
                 @Sucursal      INT,
                 @ID            INT,
                 @PeriodoTipo   VARCHAR(50),
                 @FechaD        DATETIME,
                 @FechaA        DATETIME,
                 @TipoNominaG4  VARCHAR(50),  
                 @Ok            INT OUTPUT,
                 @OkRef         VARCHAR(255) OUTPUT
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE
    @Mov    VARCHAR(50),
    @IDNomX INT

  SELECT @Mov = Mov FROM Nomina WHERE ID = @ID
  SELECT @IDNomX = ID FROM NomX WHERE NomMov = @Mov
  SELECT @Ok = NULL

  DELETE NominaG4ErroresCFG WHERE Estacion = @Estacion

  IF EXISTS(SELECT Objeto, IDNomX, Concepto, count(*) NumeroVeces FROM NominaConceptoEx GROUP BY Objeto, IDNomX, Concepto HAVING COUNT(*) >= 2 AND IDNomX = 1 AND isnull(Concepto, '') <>'')
  BEGIN
    SELECT @OK = 1, @OkRef = 'Existe Conceptos repetiodos dentro del mismo Objeto de NominaConceptoEx'
    INSERT INTO NominaG4ErroresCFG (Estacion,  Rama, Cuenta, Propiedad, Valor,    Descripcion)
         SELECT                     @Estacion, NULL, Objeto, Concepto,  COUNT(*), @OkRef
           FROM NominaConceptoEx 
          GROUP BY Objeto, IDNomX, Concepto 
         HAVING COUNT(*) >= 2 AND IDNomX = @IDNomX AND isnull(Concepto, '') <>''
  END

  IF @TipoNominaG4 = 'Nomina Normal'
  BEGIN
    IF EXISTS (SELECT * FROM Personal WHERE Personal IN (SELECT Clave FROM ListaSt WHERE Estacion = @Estacion) AND ISNULL(FechaBaja, '') <> '')
    BEGIN
      SELECT @OK = 1, @OkRef = 'En una Nómina Normal no pueden existir empleados con fecha de baja'
      INSERT INTO NominaG4ErroresCFG (Estacion,  Rama, Cuenta,   Propiedad, Valor, Descripcion)
           SELECT                     @Estacion, NULL, Personal, FechaBaja, NULL,  @OkRef
             FROM Personal 
            WHERE Personal IN (SELECT Clave FROM ListaSt WHERE Estacion = @Estacion) AND ISNULL(FechaBaja, '') <> ''
             
    END
  END

  IF Exists (SELECT * FROM PersonalProp WHERE NivelPersonal = 1 AND NivelEmpresa  = 1)
  BEGIN
    SELECT @OK = 1, @OkRef = 'Existen propiedades configuradas a nivel Personal y Empresa al mismo tiempo'
    INSERT INTO NominaG4ErroresCFG (Estacion,  Rama, Cuenta, Propiedad, Valor, Descripcion)
         SELECT                     @Estacion, NULL, NULL,   Propiedad, NULL,  @OkRef    
           FROM PersonalProp 
          WHERE NivelPersonal = 1 AND NivelEmpresa  = 1
  END

  IF Exists (SELECT * FROM PersonalProp WHERE NivelPersonal = 1 AND NivelSucursal = 1)
  BEGIN
    SELECT @OK = 1, @OkRef = 'Existen propiedades configuradas a nivel Personal y Sucursal al mismo tiempo'
    INSERT INTO NominaG4ErroresCFG (Estacion,  Rama, Cuenta, Propiedad, Valor, Descripcion)
         SELECT                     @Estacion, NULL, NULL,   Propiedad, NULL,  @OkRef    
           FROM PersonalProp 
          WHERE NivelPersonal = 1 AND NivelSucursal = 1
  END

  IF Exists (SELECT * FROM PersonalProp WHERE NivelPersonal = 1 AND NivelCategoria = 1)
  BEGIN
    SELECT @OK = 1, @OkRef = 'Existen propiedades configuradas a nivel Personal y Categoria al mismo tiempo'
    INSERT INTO NominaG4ErroresCFG (Estacion,  Rama, Cuenta, Propiedad, Valor, Descripcion)
         SELECT                     @Estacion, NULL, NULL,   Propiedad, NULL,  @OkRef    
           FROM PersonalProp 
          WHERE NivelPersonal = 1 AND NivelCategoria = 1
  END

  IF Exists (SELECT * FROM PersonalProp WHERE NivelPersonal = 1 AND NivelPuesto = 1)
  BEGIN
    SELECT @OK = 1, @OkRef = 'Existen propiedades configuradas a nivel Personal y Puesto al mismo tiempo'
    INSERT INTO NominaG4ErroresCFG (Estacion,  Rama, Cuenta, Propiedad, Valor, Descripcion)
         SELECT                     @Estacion, NULL, NULL,   Propiedad, NULL,  @OkRef    
           FROM PersonalProp 
          WHERE NivelPersonal = 1 AND NivelPuesto = 1
  END

  IF Exists (SELECT * FROM PersonalProp WHERE NivelEmpresa = 1 AND NivelSucursal = 1)
  BEGIN
    SELECT @OK = 1, @OkRef = 'Existen propiedades configuradas a nivel Empresa y Sucursal al mismo tiempo'
    INSERT INTO NominaG4ErroresCFG (Estacion,  Rama, Cuenta, Propiedad, Valor, Descripcion)
         SELECT                     @Estacion, NULL, NULL,   Propiedad, NULL,  @OkRef    
           FROM PersonalProp 
          WHERE NivelEmpresa = 1 AND NivelSucursal = 1
  END

  IF Exists (SELECT * FROM PersonalProp WHERE NivelEmpresa = 1 AND NivelCategoria = 1)
  BEGIN
    SELECT @OK = 1, @OkRef = 'Existen propiedades configuradas a nivel Empresa y Categoria al mismo tiempo'
    INSERT INTO NominaG4ErroresCFG (Estacion,  Rama, Cuenta, Propiedad, Valor, Descripcion)
         SELECT                     @Estacion, NULL, NULL,   Propiedad, NULL,  @OkRef    
           FROM PersonalProp 
          WHERE  NivelEmpresa = 1 AND NivelCategoria = 1
  END

  IF Exists (SELECT * FROM PersonalProp WHERE NivelEmpresa = 1 AND NivelPuesto = 1)
  BEGIN
    SELECT @OK = 1, @OkRef = 'Existen propiedades configuradas a nivel Empresa y Puesto al mismo tiempo'
    INSERT INTO NominaG4ErroresCFG (Estacion,  Rama, Cuenta, Propiedad, Valor, Descripcion)
         SELECT                     @Estacion, NULL, NULL,   Propiedad, NULL,  @OkRef    
           FROM PersonalProp 
          WHERE NivelEmpresa = 1 AND NivelPuesto = 1
  END

  IF Exists (SELECT * FROM PersonalProp WHERE NivelSucursal = 1 AND NivelCategoria = 1)
  BEGIN
    SELECT @OK = 1, @OkRef = 'Existen propiedades configuradas a nivel Sucursal y Categoria al mismo tiempo'
    INSERT INTO NominaG4ErroresCFG (Estacion,  Rama, Cuenta, Propiedad, Valor, Descripcion)
         SELECT                     @Estacion, NULL, NULL,   Propiedad, NULL,  @OkRef    
           FROM PersonalProp 
          WHERE NivelSucursal = 1 AND NivelCategoria = 1
  END

  IF Exists (SELECT * FROM PersonalProp WHERE NivelSucursal = 1 AND NivelPuesto = 1)
  BEGIN
    SELECT @OK = 1, @OkRef = 'Existen propiedades configuradas a nivel Sucursal y Puesto al mismo tiempo'
    INSERT INTO NominaG4ErroresCFG (Estacion,  Rama, Cuenta, Propiedad, Valor, Descripcion)
         SELECT                     @Estacion, NULL, NULL,   Propiedad, NULL,  @OkRef    
           FROM PersonalProp 
          WHERE NivelSucursal = 1 AND NivelPuesto = 1
  END

  IF Exists (SELECT * FROM PersonalProp WHERE NivelCategoria = 1 AND NivelPuesto = 1)
  BEGIN
    SELECT @OK = 1, @OkRef = 'Existen propiedades configuradas a nivel Categoria y Puesto al mismo tiempo'
    INSERT INTO NominaG4ErroresCFG (Estacion,  Rama, Cuenta, Propiedad, Valor, Descripcion)
         SELECT                     @Estacion, NULL, NULL,   Propiedad, NULL,  @OkRef    
           FROM PersonalProp 
          WHERE NivelCategoria = 1 AND NivelPuesto = 1
  END

  IF Exists(SELECT * FROM NominaConceptoEx n LEFT JOIN PersonalPropValor p ON n.Concepto = p.Propiedad WHERE n.Obligatorio = 1 AND n.Objeto = 'Nomina.Empresa.Propiedad' AND p.Rama = 'EMP' AND p.Cuenta = @Empresa AND Valor = NULL)
  BEGIN
    SELECT @OK = 1, @OkRef = 'Existen propiedades de la empresa que estan vacias'
    INSERT INTO NominaG4ErroresCFG (Estacion,  Rama,  Cuenta,   Propiedad,   Valor, Descripcion)
         SELECT                     @Estacion, 'EMP', @Empresa, p.Propiedad, NULL,  @OkRef    
           FROM NominaConceptoEx n
           LEFT JOIN PersonalPropValor p ON n.Concepto = p.Propiedad
          WHERE n.Obligatorio = 1 AND n.Objeto = 'Nomina.Empresa.Propiedad' AND p.Rama = 'EMP' AND p.Cuenta = @Empresa AND Valor = NULL
  END

  IF Exists(SELECT * FROM Personal p JOIN ListaSt l ON l.Clave = p.Personal WHERE Estacion = @Estacion AND ISNULL(FechaAlta, '') = '')
  BEGIN
    SELECT @OK = 1, @OkRef = 'Existen Empleados con el dato Fecha de Alta vacio'
    INSERT INTO NominaG4ErroresCFG (Estacion,  Rama,  Cuenta,     Propiedad,   Valor, Descripcion)
         SELECT                     @Estacion, 'PER', p.Personal, 'FechaAlta', NULL,  @OkRef    
           FROM Personal p JOIN ListaSt l ON l.Clave = p.Personal WHERE Estacion = @Estacion AND ISNULL(FechaAlta, '') = ''
  END

  IF Exists(SELECT * FROM Personal p JOIN ListaSt l ON l.Clave = p.Personal WHERE Estacion = @Estacion AND ISNULL(FechaAntiguedad, '') = '')
  BEGIN
    SELECT @OK = 1, @OkRef = 'Existen Empleados con el dato Fecha Antigüedad vacio'
    INSERT INTO NominaG4ErroresCFG (Estacion,  Rama,  Cuenta,     Propiedad,          Valor, Descripcion)
         SELECT                     @Estacion, 'PER', p.Personal, 'FechaAntiguedad',  NULL,  @OkRef    
           FROM Personal p JOIN ListaSt l ON l.Clave = p.Personal WHERE Estacion = @Estacion AND ISNULL(FechaAntiguedad, '') = ''
  END

  IF Exists(SELECT * FROM Personal p JOIN ListaSt l ON l.Clave = p.Personal WHERE Estacion = @Estacion AND ISNULL(p.SueldoDiario*30, 0.00) = 0.00)
  BEGIN
    SELECT @OK = 1, @OkRef = 'Existen Empleados con el dato Sueldo Diario vacio'
    INSERT INTO NominaG4ErroresCFG (Estacion,  Rama,  Cuenta,     Propiedad, Valor, Descripcion)
         SELECT                     @Estacion, 'PER', p.Personal, 'Sueldo',  NULL,  @OkRef    
           FROM Personal p JOIN ListaSt l ON l.Clave = p.Personal WHERE Estacion = @Estacion AND ISNULL(p.SueldoDiario*30, 0.00) = 0.00
  END

  IF Exists(SELECT * FROM Personal p JOIN ListaSt l ON l.Clave = p.Personal WHERE Estacion = @Estacion AND ISNULL(PeriodoTipo, '') = '')
  BEGIN
    SELECT @OK = 1, @OkRef = 'Existen Empleados con el dato Tipo Periodo vacio'
    INSERT INTO NominaG4ErroresCFG (Estacion,  Rama,  Cuenta,     Propiedad,       Valor, Descripcion)
         SELECT                     @Estacion, 'PER', p.Personal, 'Tipo Periodo',  NULL,  @OkRef    
           FROM Personal p JOIN ListaSt l ON l.Clave = p.Personal WHERE Estacion = @Estacion AND ISNULL(PeriodoTipo, '') = ''
  END

  IF Exists(SELECT * FROM Personal p JOIN ListaSt l ON l.Clave = p.Personal WHERE Estacion = @Estacion AND ISNULL(Sindicato, '') = '')
  BEGIN
    SELECT @OK = 1, @OkRef = 'Existen Empleados con el dato Sindicato vacio'
    INSERT INTO NominaG4ErroresCFG (Estacion,  Rama,  Cuenta,     Propiedad,   Valor, Descripcion)
         SELECT                     @Estacion, 'PER', p.Personal, 'Sindicato', NULL,  @OkRef    
           FROM Personal p JOIN ListaSt l ON l.Clave = p.Personal WHERE Estacion = @Estacion AND ISNULL(Sindicato, '') = ''
  END

  IF @Ok <> NULL
    SELECT @OkRef = 'Existen errores, revisar Log.'

  RETURN
END
GO

/**************** spNominaG4 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaG4') and sysstat & 0xf = 4) drop procedure dbo.spNominaG4
GO             
CREATE PROCEDURE spNominaG4
                 @Estacion    INT,
                 @Empresa     VARCHAR(5),
                 @Sucursal    INT,
                 @ID          INT,
                 @PeriodoTipo VARCHAR(50),
                 @FechaD      DATETIME,
                 @FechaA      DATETIME
--//WITH ENCRYPTION                 
AS 
BEGIN
  DECLARE
    @Mov          VARCHAR(20),
    @TipoNominaG4 VARCHAR(50),
    @Ok          INT,
    @OkRef       VARCHAR(255)


  SELECT @Mov = Mov FROM Nomina WHERE ID = @ID
  SELECT @TipoNominaG4 = TipoNominaG4 FROM NomX WHERE NomMov = @Mov
  EXEC spNominaG4Validar @Estacion, @Empresa, @Sucursal, @ID, @PeriodoTipo, @FechaD, @FechaA, @TipoNominaG4, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok = NULL
  BEGIN
      IF @TipoNominaG4 IN ('Nomina Normal', 'Nomina Finiquito', 'Nomina Liquidacion')
        EXEC spNominaG4Archivos @Estacion, @Empresa, @Sucursal, @ID, @PeriodoTipo, @FechaD, @FechaA, @TipoNominaG4
  END
  ELSE
    SELECT @OkRef

  RETURN
END
GO

/**************** spNominaG4CargaCalendario ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaG4CargaCalendario') and sysstat & 0xf = 4) drop procedure dbo.spNominaG4CargaCalendario
GO             
CREATE PROCEDURE spNominaG4CargaCalendario   
  @Ejercicio INT,
  @Estacion  INT,
  @Empresa   VARCHAR(5),
  @Sucursal  INT
--//WITH ENCRYPTION
AS
BEGIN

  DECLARE
    @UUID         VARCHAR(101),
    @Archivo      VARCHAR(500),
    @Bulk         VARCHAR(400),
    @Renglon	    FLOAT, 
    @Mov          VARCHAR(20),
    @IDNomX       INT,
    @Debug        BIT,
    @Directorio   VARCHAR(255),
    @Ruta         VARCHAR(255),
    @Ruta2        VARCHAR(255),
    @ComandShell  VARCHAR(255),
    @Ok           INT,
    @OkRef        VARCHAR(100),
    @Funcion      nVARCHAR(4000),
    @API          VARCHAR(100),
    @URL          VARCHAR(200),
    @result       VARCHAR(max),
    @Parmetros    nVARCHAR(4000),
    @XML          XML,
    @FechaEmision VARCHAR(10),
    @Base         VARCHAR(100),
    @Json         VARCHAR(MAX)

  DELETE ServicioJSON WHERE Estacion = @Estacion

  --SELECT @UUID = '2A9A01CF-3390-4FA6-97E9-BFF686BBF596', @Ok = 200, @FechaEmision = CONVERT(char(10),GETDATE(), 126), @Base =  DB_NAME() 
  SELECT @UUID = NEWID(), @FechaEmision = CONVERT(char(10),GETDATE(), 126), @Base =  DB_NAME() 

  SET @XML = (SELECT * FROM (SELECT 'Calendario' as action, @UUID as process_id, @Empresa as company, @Sucursal as subCompany, @FechaEmision as date, @Base as tenant_id, 'G3' as system, CONVERT(varchar(4), @Ejercicio) as 'calendarFilter', 'Nomina.Calendario.Exportar' as 'object', '' as 'concept') as ServicioG3 FOR XML AUTO, ELEMENTS)
  --SELECT @XML
  
  SELECT @Json = dbo.XML2JSON(@XML)
  SELECT @Json = REPLACE(LTRIM(@Json), '{"ServicioG3":', '')
  SELECT @Json = REPLACE(@Json, '}}', '}')

  INSERT INTO ServicioJSON (Estacion, Dato)
       SELECT @Estacion, @Json
  
  SELECT TOP 1 @Directorio = DirectorioArchivosZip, @Debug = ISNULL(Debug, 0), @API = API, @URL = URL  FROM ServiciosG3 WHERE Servicio = 'Calendario' AND Estatus = 1
  SELECT @Ruta =    @Directorio+'\'+@UUID, 
         @Ruta2 =   @Directorio+'\'+@UUID+'CSV', 
         @Archivo = @Directorio+'\'+@UUID+'CSV\output.csv'

  --- Inicio API de G3 -----  
  SELECT @Funcion = N'SELECT @resultOUT = dbo.Int2API_beta('''+@API+''', ''/BetaNomina?URL='+isnull(@URL, '')+'&Modulo=Calendario&Estacion='+Convert(varchar(4), @Estacion)+'&process_id='+@UUID+''', ''intelisis'', ''apifirst'')'
  SELECT @Parmetros = N'@resultOUT varchar(MAX) OUTPUT'    
  EXECUTE sp_executesql @Funcion, @Parmetros, @resultOUT = @result OUTPUT
  
  SELECT @Ok = replace(substring(@result, charindex(upper('OK'), upper(@result)) + 4, charindex(upper('OkRef'), upper(@result))-charindex(upper('OK'), upper(@result))-4-2), '"', '')  
  SELECT @OkRef = replace(substring(@result, charindex(upper('OkRef'), upper(@result)) + 7, charindex(upper('}'), upper(@result))-charindex(upper('OkRef'), upper(@result))-7), '"', '')
  
  --- Fin API de G3  -----
  
  IF @Ok IN ('200', '205')
  BEGIN   
    CREATE TABLE #OutputCalendario(
      TipoPeriodo         VARCHAR(50), 
      Tiempo              VARCHAR(50), 
      Primera             VARCHAR(50), 
      Ultima              VARCHAR(50), 
      Clave               VARCHAR(50), 
      Ejercicio           VARCHAR(50), 
      Periodo             VARCHAR(50), 
      Bimestre            VARCHAR(50), 
      Quincena            VARCHAR(50), 
      Inicio              VARCHAR(50), 
      Fin                 VARCHAR(50), 
      Dias                VARCHAR(50), 
      PrimerDia           VARCHAR(50), 
      UltimoDia           VARCHAR(50), 
      SigInicio           VARCHAR(50), 
      SigFin              VARCHAR(50), 
      FinBimestre         VARCHAR(50), 
      FinAno              VARCHAR(50), 
      FechaInicioBimestre VARCHAR(50), 
      FechaFinBimestre    VARCHAR(50),
        )
          
    SELECT @Bulk = 'BULK
      INSERT #OutputCalendario 
      FROM '''+@Archivo+''' 
      WITH
      ( FIELDTERMINATOR = ''|'',
        ROWTERMINATOR = ''0x0a'',
        CODEPAGE = ''ACP'' )'

    EXEC(@Bulk)
--    SELECT * FROM #OutputCalendario
--    select TipoPeriodo, Tiempo, Primera, Ultima, Clave, Ejercicio, Periodo, Quincena, Inicio, Fin, Dias, PrimerDia, UltimoDia, SigInicio, SigFin, FinBimestre, FinAno, FechaInicioBimestre, FechaFinBimestre from NominaG4Calendario

    UPDATE #OutputCalendario SET FechaFinBimestre = REPLACE(FechaFinBimestre,char(13), '')
    DELETE NominaG4Calendario where YEAR(Tiempo) = @Ejercicio  
    INSERT INTO NominaG4Calendario ( TipoPeriodo, Tiempo,                   Primera, Ultima, Clave, Ejercicio, Periodo, Bimestre, Quincena, Inicio,                   Fin,                   Dias, PrimerDia, UltimoDia, SigInicio,                   SigFin,                   FinBimestre, FinAno, FechaInicioBimestre,                   FechaFinBimestre)                                   
         SELECT                      TipoPeriodo, CONVERT(DATETIME,Tiempo), Primera, Ultima, Clave, Ejercicio, Periodo, Bimestre, Quincena, CONVERT(DATETIME,Inicio), CONVERT(DATETIME,Fin), Dias, PrimerDia, UltimoDia, CONVERT(DATETIME,SigInicio), CONVERT(DATETIME,SigFin), FinBimestre, FinAno, CONVERT(DATETIME,FechaInicioBimestre), CONVERT(DATETIME,FechaFinBimestre) 
           FROM #OutputCalendario
          WHERE YEAR(Tiempo) = @Ejercicio

    IF @Debug = 0
    BEGIN
      SELECT @ComandShell = 'rd '+ @Ruta  +' /S /Q;' 
      EXEC xp_cmdshell @ComandShell, NO_OUTPUT  

      SELECT @ComandShell = 'rd '+ @Ruta2  +' /S /Q;' 
      EXEC xp_cmdshell @ComandShell, NO_OUTPUT  
    END

    SELECT 'PROCESO CONCLUIDO'

  END
  ELSE
    SELECT convert(varchar(100),@Ok)+': '+@OkRef

  DELETE ServicioJSON WHERE Estacion = @Estacion

RETURN
END
GO
--EXEC spNominaG4CargaCalendario 2016, 3, 'SHMEX', 0

if exists (select * from sysobjects where id = object_id('dbo.VistaServiciosG3') and type = 'V') drop view dbo.VistaServiciosG3
GO
CREATE VIEW VistaServiciosG3
AS 
SELECT n.ID, s.Servicio as Modulo, n.NombreCSV, n.Qry, Params, s.Estatus
  FROM ServiciosG3 s 
  LEFT JOIN ServiciosG3Detalle sd ON sd.ID = s.ID
  LEFT JOIN NominaG4CFG n on n.ID = sd.IdArchivosCSV
  WHERE s.Estatus = 1 AND ISNULL(sd.Estatus, 1) = 1 
GO
