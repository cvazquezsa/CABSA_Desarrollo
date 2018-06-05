/* Configuracion MS SQL Server */

SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF

/* DepurarMov */
if not exists (select * from sysobjects where id = object_id('dbo.DepurarMov') and type = 'U') 
  CREATE TABLE DepurarMov(
    Modulo	  char(5)	NOT NULL, 
    ID		  integer	NOT NULL, 

   CONSTRAINT priDepurarMov PRIMARY KEY  CLUSTERED (Modulo, ID)
  )
GO

/* ActualizarEstadisticas */
if exists (select * from sysobjects where id = object_id('dbo.spActualizarEstadisticas') and type = 'P') drop procedure dbo.spActualizarEstadisticas
GO
CREATE PROCEDURE spActualizarEstadisticas
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @tablename 		varchar(30),
    @tablename_header 	varchar(75)

  DECLARE tnames_cursor CURSOR FOR SELECT name FROM sysobjects WHERE type = 'U'
  OPEN tnames_cursor
  FETCH NEXT FROM tnames_cursor INTO @tablename
  WHILE (@@fetch_status <> -1)
  BEGIN
	IF (@@fetch_status <> -2)
	BEGIN
	  SELECT @tablename_header = "Actualizando: " +@tablename
	  PRINT @tablename_header
       	  EXEC ("UPDATE STATISTICS "+@tablename )
	END
	FETCH NEXT FROM tnames_cursor INTO @tablename
  END
  CLOSE tnames_cursor
  DEALLOCATE tnames_cursor
END
go


/* Regenerar Indices */
if exists (select * from sysobjects where id = object_id('dbo.spRegenerarIndices') and type = 'P') drop procedure dbo.spRegenerarIndices
GO
CREATE PROCEDURE spRegenerarIndices
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @tablename 			varchar(256), -- BUG8803
    @tablename_header 	varchar(300)  -- BUG8803

  DECLARE tnames_cursor CURSOR FOR SELECT name FROM sysobjects WHERE type = 'U'
  OPEN tnames_cursor
  FETCH NEXT FROM tnames_cursor INTO @tablename
  WHILE (@@fetch_status <> -1)
  BEGIN
	IF (@@fetch_status <> -2)
	BEGIN
	  SELECT @tablename_header = "Regenerando: " +@tablename
	  PRINT @tablename_header
       	  DBCC DBREINDEX (@tablename )
          PRINT ''
	END
	FETCH NEXT FROM tnames_cursor INTO @tablename
  END
  CLOSE tnames_cursor
  DEALLOCATE tnames_cursor
END
go


/* EliminarIndicesTabla */
if exists (select * from sysobjects where id = object_id('dbo.spEliminarIndicesTabla') and type = 'P') drop procedure dbo.spEliminarIndicesTabla
GO
CREATE PROCEDURE spEliminarIndicesTabla @tablename varchar(30)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
     @a		  int,
     @Indice 	  varchar(100),
     @Eliminando  varchar(255),
     @Nombre	  varchar(255)

  SELECT @a = 0

  DECLARE crIndices CURSOR FOR SELECT i.name FROM sysindexes i , sysobjects o WHERE o.name = @tablename AND o.id = i.id AND i.impid<>-1
  OPEN crIndices
  FETCH NEXT FROM crIndices INTO @Indice
  WHILE (@@fetch_status <> -1)
  BEGIN
        IF (@@fetch_status <> -2) 
	BEGIN  
          SELECT @a = @a +1
          IF @a > 1 AND SUBSTRING(@Indice,1, 1) <> '_'
          BEGIN
            SELECT @Nombre = "dbo." + RTRIM(@tablename) + '.' + RTRIM(@Indice)
            SELECT @Eliminando = "Eliminando Indice: " + @Nombre
	    PRINT @Eliminando
            SELECT @Nombre = "DROP INDEX "+@Nombre
  
            EXEC (@Nombre)
          END
	END
	FETCH NEXT FROM crIndices INTO @Indice
  END
  CLOSE crIndices
  DEALLOCATE crIndices
END
go

/* EliminarIndices */
if exists (select * from sysobjects where id = object_id('dbo.spEliminarIndices') and type = 'P') drop procedure dbo.spEliminarIndices
GO
CREATE PROCEDURE spEliminarIndices
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @tablename 		varchar(30),
    @tablename_header 	varchar(75)

  DECLARE tnames_cursor CURSOR FOR SELECT name FROM sysobjects WHERE type = 'U'
  OPEN tnames_cursor
  FETCH NEXT FROM tnames_cursor INTO @tablename
  WHILE (@@fetch_status <> -1)
  BEGIN
	IF (@@fetch_status <> -2) 
	BEGIN
          EXEC spEliminarIndicesTabla @tablename
	END
	FETCH NEXT FROM tnames_cursor INTO @tablename
  END
  CLOSE tnames_cursor
  DEALLOCATE tnames_cursor
END
go


/* spBorrarTabla */
if exists (select * from sysobjects where id = object_id('dbo.spBorrarTabla') and type = 'P') drop procedure dbo.spBorrarTabla
GO
CREATE PROCEDURE spBorrarTabla
			@Tabla	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  if exists (select * from sysobjects where id = object_id('dbo.'+@Tabla) and type = 'U') 
  BEGIN
	IF RTRIM(LTRIM(@Tabla)) = 'Tarima'
	BEGIN
		EXEC('DELETE T FROM ' + @Tabla + ' T JOIN AlmPos A ON T.Posicion = A.Posicion AND T.Almacen = A.Almacen WHERE A.Tipo <> ''Domicilio'' ')
	END
	---------------------------------
	IF RTRIM(LTRIM(@Tabla)) = 'Inv'
	BEGIN
		ALTER TABLE Inv DISABLE TRIGGER tgInvB
		EXEC("DELETE "+@Tabla)
		ALTER TABLE Inv ENABLE TRIGGER tgInvB
	END
	---------------------------------
	IF RTRIM(LTRIM(@Tabla)) NOT IN ('Tarima','Inv')
	BEGIN
		BEGIN TRAN TR1
			BEGIN
				EXEC("DISABLE TRIGGER ALL ON "+@Tabla)
				EXEC("DELETE "+@Tabla)
				IF (SELECT VERSION FROM VERSION) >= 1140 EXEC("spSincroSemilla "+@Tabla)
				EXEC("ENABLE TRIGGER ALL ON "+@Tabla)
			END
		 COMMIT TRAN TR1
	END
  END
END
GO

/**************** spReEncabezadosCompraVenta ****************/
if exists (select * from sysobjects where id = object_id('dbo.spReEncabezadosCompraVenta') and type = 'P') drop procedure dbo.spReEncabezadosCompraVenta
GO             
CREATE PROCEDURE spReEncabezadosCompraVenta
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
    @ID		  	 int,
    @DescuentoGlobal	 float,
    @CfgImpInc		 bit,
    @CfgMultiUnidades	 bit,
    @Empresa		 char(5),
    @UltEmpresa		 char(5)

  SELECT @UltEmpresa = NULL
  DECLARE crVenta CURSOR FOR SELECT Empresa, ID, DescuentoGlobal FROM Venta ORDER BY Empresa
  OPEN crVenta
  FETCH NEXT FROM crVenta INTO @Empresa, @ID, @DescuentoGlobal
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @Empresa <> @UltEmpresa 
      BEGIN
        SELECT @CfgImpInc = VentaPreciosImpuestoIncluido FROM EmpresaCfg WHERE Empresa = @Empresa
	SELECT @CfgMultiUnidades = MultiUnidades FROM EmpresaCfg2 WHERE Empresa = @Empresa
        SELECT @UltEmpresa = @Empresa
      END
      EXEC spInvReCalcEncabezado @ID, 'VTAS', @CfgImpInc, @CfgMultiUnidades, @DescuentoGlobal
    END
    FETCH NEXT FROM crVenta INTO @Empresa, @ID, @DescuentoGlobal
  END
  CLOSE crVenta
  DEALLOCATE crVenta

  SELECT @UltEmpresa = NULL
  DECLARE crCompra CURSOR FOR SELECT Empresa, ID, DescuentoGlobal FROM Compra 
  OPEN crCompra
  FETCH NEXT FROM crCompra INTO @Empresa, @ID, @DescuentoGlobal
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @Empresa <> @UltEmpresa 
      BEGIN
	SELECT @CfgMultiUnidades = MultiUnidades FROM EmpresaCfg2 WHERE Empresa = @Empresa
        SELECT @UltEmpresa = @Empresa
      END
      EXEC spInvReCalcEncabezado @ID, 'COMS', 0, @CfgMultiUnidades, @DescuentoGlobal
    END
    FETCH NEXT FROM crCompra INTO @Empresa, @ID, @DescuentoGlobal
  END
  CLOSE crCompra
  DEALLOCATE crCompra
  RETURN
END
GO


/**************** spReconstruirRama ****************/
if exists (select * from sysobjects where id = object_id('dbo.spReconstruirRama') and type = 'P') drop procedure dbo.spReconstruirRama
GO             
CREATE PROCEDURE spReconstruirRama @Rama char(5)
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
    @Conciliar		bit,
    @GeneraSaldo	bit, 
    @EsMonetario	bit,
    @EsUnidades		bit,
    @EsResultados	bit,
    @Fecha		datetime

  SELECT @Fecha = GETDATE()
  SELECT @GeneraSaldo       = GeneraSaldo,
         @Conciliar  	    = Conciliar,
         @EsMonetario	    = EsMonetario,
         @EsUnidades        = EsUnidades,
	 @EsResultados	    = EsResultados
    FROM Rama
   WHERE Rama = @Rama

  IF @EsMonetario = 1 AND @EsUnidades  = 0 AND @EsResultados = 0 EXEC spReconstruirAuxiliar   @Rama, @GeneraSaldo, @Conciliar, @Fecha ELSE
  IF @EsMonetario = 1 AND @EsUnidades  = 0 AND @EsResultados = 1 EXEC spReconstruirAuxiliarR  @Rama, @GeneraSaldo, @Conciliar, @Fecha ELSE
  IF @EsMonetario = 1 AND @EsUnidades  = 1 AND @EsResultados = 0 EXEC spReconstruirAuxiliarU  @Rama, @GeneraSaldo, @Conciliar, @Fecha ELSE
  IF @EsMonetario = 1 AND @EsUnidades  = 1 AND @EsResultados = 1 EXEC spReconstruirAuxiliarRU @Rama, @GeneraSaldo, @Conciliar, @Fecha 
  RETURN
END
GO

/**************** spReconstruirRamas ****************/
if exists (select * from sysobjects where id = object_id('dbo.spReconstruirRamas') and type = 'P') drop procedure dbo.spReconstruirRamas
GO             
CREATE PROCEDURE spReconstruirRamas
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
    @Rama char(5)

  DECLARE crRama CURSOR FOR 
   SELECT Rama 
     FROM Rama 
    WHERE Rama NOT IN ('CONT', 'CC')

  OPEN crRama
  FETCH NEXT FROM crRama INTO @Rama
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spReconstruirRama @Rama    
    END
    FETCH NEXT FROM crRama INTO @Rama
  END
  CLOSE crRama
  DEALLOCATE crRama
  RETURN
END
GO


/**************** spReconstruirSaldosIniciales ****************/
if exists (select * from sysobjects where id = object_id('dbo.spReconstruirSaldosIniciales') and type = 'P') drop procedure dbo.spReconstruirSaldosIniciales
GO             
CREATE PROCEDURE spReconstruirSaldosIniciales
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa	char(5),
    @Ejercicio	int

  DECLARE crSI CURSOR FOR 
   SELECT Empresa, Ejercicio
     FROM Acum
    GROUP BY Empresa, Ejercicio
    ORDER BY Empresa, Ejercicio

  OPEN crSI
  FETCH NEXT FROM crSI INTO @Empresa, @Ejercicio
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
      EXEC spTraspasarSaldos @Empresa, @Ejercicio--, 1

    FETCH NEXT FROM crSI INTO @Empresa, @Ejercicio
  END
  CLOSE crSI
  DEALLOCATE crSI
  RETURN
END
GO

/* spDepurarMov */
if exists (select * from sysobjects where id = object_id('dbo.spDepurarMov') and type = 'P') drop procedure dbo.spDepurarMov
GO
CREATE PROCEDURE spDepurarMov
			@Modulo	char(5),
			@Tabla	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  if exists (select * from sysobjects where id = object_id('dbo.'+@Tabla) and type = 'U') 
  EXEC("
    ALTER TABLE "+@Tabla+" DISABLE TRIGGER ALL
    DELETE "+@Tabla+" FROM "+@Tabla+" m, DepurarMov t WHERE t.Modulo = '"+@Modulo+"' AND t.ID = m.ID 
    ALTER TABLE "+@Tabla+" ENABLE TRIGGER ALL
   ")
END
go


/* spDepurarModulo */
if exists (select * from sysobjects where id = object_id('dbo.spDepurarModulo') and type = 'P') drop procedure dbo.spDepurarModulo
GO
CREATE PROCEDURE spDepurarModulo
			@Tabla	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  if exists (select * from sysobjects where id = object_id('dbo.'+@Tabla) and type = 'U') 
  EXEC("
    ALTER TABLE "+@Tabla+" DISABLE TRIGGER ALL
    DELETE "+@Tabla+" FROM "+@Tabla+" m, DepurarMov t WHERE t.Modulo = m.Modulo AND t.ID = m.ID 
    ALTER TABLE "+@Tabla+" ENABLE TRIGGER ALL
   ")
END
go

/* spDepurarRama */
if exists (select * from sysobjects where id = object_id('dbo.spDepurarRama') and type = 'P') drop procedure dbo.spDepurarRama
GO
CREATE PROCEDURE spDepurarRama
			@Tabla	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  if exists (select * from sysobjects where id = object_id('dbo.'+@Tabla) and type = 'U') 
  EXEC("
    ALTER TABLE "+@Tabla+" DISABLE TRIGGER ALL
    DELETE "+@Tabla+" FROM "+@Tabla+" m, DepurarMov t WHERE t.Modulo = m.Rama AND t.ID = m.ID 
    ALTER TABLE "+@Tabla+" ENABLE TRIGGER ALL
   ")
END
go

/* spDepurarModuloID */
if exists (select * from sysobjects where id = object_id('dbo.spDepurarModuloID') and type = 'P') drop procedure dbo.spDepurarModuloID
GO
CREATE PROCEDURE spDepurarModuloID
			@Tabla	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  if exists (select * from sysobjects where id = object_id('dbo.'+@Tabla) and type = 'U') 
  EXEC("
    ALTER TABLE "+@Tabla+" DISABLE TRIGGER ALL
    DELETE "+@Tabla+" FROM "+@Tabla+" m, DepurarMov t WHERE t.Modulo = m.Modulo AND t.ID = m.ModuloID 
    ALTER TABLE "+@Tabla+" ENABLE TRIGGER ALL
   ")
END
go


/* DepurarHistoricos */
if exists (select * from sysobjects where id = object_id('dbo.spDepurarHistoricos') and type = 'P') drop procedure dbo.spDepurarHistoricos
GO
CREATE PROCEDURE spDepurarHistoricos
			@MesDepurar		int,
			@AnoDepurar		int,
			@ConservarEstadistica	bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FechaDepurar	datetime

  DELETE DepurarMov

  SELECT @FechaDepurar =  CONVERT(datetime, RTRIM(CONVERT(char, @AnoDepurar)+'.'+RTRIM(CONVERT(char, @MesDepurar))+'.1'), 102)

  if exists (select * from sysobjects where id = object_id('dbo.Cont')    	and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'CONT', ID FROM Cont  		WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 
  if exists (select * from sysobjects where id = object_id('dbo.Venta') 	and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'VTAS', ID FROM Venta 		WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 
  if exists (select * from sysobjects where id = object_id('dbo.Prod') 		and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'PROD', ID FROM Prod		WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 
  if exists (select * from sysobjects where id = object_id('dbo.Compra') 	and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'COMS', ID FROM Compra 		WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 
  if exists (select * from sysobjects where id = object_id('dbo.Inv') 		and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'INV',  ID FROM Inv 		WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 
  if exists (select * from sysobjects where id = object_id('dbo.Cxc') 		and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'CXC',  ID FROM Cxc 		WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 
  if exists (select * from sysobjects where id = object_id('dbo.Cxp') 		and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'CXP',  ID FROM Cxp 		WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 
  if exists (select * from sysobjects where id = object_id('dbo.Agent') 	and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'AGENT',ID FROM Agent		WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 
  if exists (select * from sysobjects where id = object_id('dbo.Gasto') 	and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'GAS',  ID FROM Gasto		WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 
  if exists (select * from sysobjects where id = object_id('dbo.Dinero') 	and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'DIN',  ID FROM Dinero		WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 
  if exists (select * from sysobjects where id = object_id('dbo.Embarque') 	and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'EMB',  ID FROM Embarque	WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 
  if exists (select * from sysobjects where id = object_id('dbo.Nomina') 	and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'NOM',  ID FROM Nomina		WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 
  if exists (select * from sysobjects where id = object_id('dbo.RH') 		and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'RH',   ID FROM RH     		WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 
  if exists (select * from sysobjects where id = object_id('dbo.Asiste') 	and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'ASIS', ID FROM Asiste   	WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 
  if exists (select * from sysobjects where id = object_id('dbo.ActivoFijo') 	and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'AF',   ID FROM ActivoFijo 	WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 
  if exists (select * from sysobjects where id = object_id('dbo.Cambio') 	and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'CAM',  ID FROM Cambio		WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 
  if exists (select * from sysobjects where id = object_id('dbo.Capital') 	and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'CAP',  ID FROM Capital		WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 
  if exists (select * from sysobjects where id = object_id('dbo.Incidencia') 	and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'INC',  ID FROM Incidencia	WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 
  if exists (select * from sysobjects where id = object_id('dbo.Conciliacion') 	and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'CONC', ID FROM Conciliacion	WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 
  if exists (select * from sysobjects where id = object_id('dbo.Presup') 	and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'PPTO', ID FROM Presup		WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 
  if exists (select * from sysobjects where id = object_id('dbo.Credito') 	and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'CREDI',ID FROM Credito		WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 
  if exists (select * from sysobjects where id = object_id('dbo.TMA') 		and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'TMA',  ID FROM TMA		WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 
  if exists (select * from sysobjects where id = object_id('dbo.CRM') 		and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'CRM',  ID FROM CRM		WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 
  --REQ16092
  if exists (select * from sysobjects where id = object_id('dbo.Oportunidad')and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'OPORT', ID FROM Oportunidad		WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 
  if exists (select * from sysobjects where id = object_id('dbo.PC') 		and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'PC',   ID FROM PC     		WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 
  if exists (select * from sysobjects where id = object_id('dbo.Oferta') 	and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'OFER', ID FROM Oferta 		WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 
  if exists (select * from sysobjects where id = object_id('dbo.CR') 		and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'CR',   ID FROM CR     		WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 
  if exists (select * from sysobjects where id = object_id('dbo.Vale') 		and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'VALE', ID FROM Vale   		WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 
  if exists (select * from sysobjects where id = object_id('dbo.Soporte') 	and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'ST',   ID FROM Soporte		WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 
  if exists (select * from sysobjects where id = object_id('dbo.SAUX') 		and type = 'U')   INSERT DepurarMov (Modulo, ID) SELECT 'SAUX', ID FROM SAUX		WHERE Estatus IN ('CONCLUIDO', 'CANCELADO') AND FechaEmision < @FechaDepurar 

  /* Presupuesto (tg)*/
  if exists (select * from sysobjects where id = object_id('dbo.Presupuesto') and type = 'U') 
  BEGIN
    ALTER TABLE Presupuesto DISABLE TRIGGER ALL
    DELETE Presupuesto WHERE (Ejercicio < @AnoDepurar) OR (Ejercicio = @AnoDepurar AND Periodo < @MesDepurar)
    ALTER TABLE Presupuesto ENABLE TRIGGER ALL
  END

  /* Acceso */
  if exists (select * from sysobjects where id = object_id('dbo.Acceso') and type = 'U') 
  BEGIN
    ALTER TABLE Acceso DISABLE TRIGGER ALL
    DELETE Acceso WHERE FechaTrabajo < @FechaDepurar
    ALTER TABLE Acceso ENABLE TRIGGER ALL
  END

  /* DocAuto */
  if exists (select * from sysobjects where id = object_id('dbo.DocAuto') and type = 'U') 
  BEGIN
    ALTER TABLE DocAuto DISABLE TRIGGER ALL
    DELETE DocAuto WHERE FechaEmision < @FechaDepurar
    ALTER TABLE DocAuto ENABLE TRIGGER ALL
  END

  /* ArtPrecioHist */
  if exists (select * from sysobjects where id = object_id('dbo.ArtPrecioHist') and type = 'U') 
  BEGIN
    ALTER TABLE ArtPrecioHist DISABLE TRIGGER ALL
    DELETE ArtPrecioHist WHERE Fecha < @FechaDepurar
    ALTER TABLE ArtPrecioHist ENABLE TRIGGER ALL
  END

  /* ArtCostoHist */
  if exists (select * from sysobjects where id = object_id('dbo.ArtCostoHist') and type = 'U') 
  BEGIN
    ALTER TABLE ArtCostoHist DISABLE TRIGGER ALL
    DELETE ArtCostoHist WHERE Fecha < @FechaDepurar
    ALTER TABLE ArtCostoHist ENABLE TRIGGER ALL
  END

  /* ArtSubCostoHist */
  if exists (select * from sysobjects where id = object_id('dbo.ArtSubCostoHist') and type = 'U') 
  BEGIN
    ALTER TABLE ArtSubCostoHist DISABLE TRIGGER ALL
    DELETE ArtSubCostoHist WHERE Fecha < @FechaDepurar
    ALTER TABLE ArtSubCostoHist ENABLE TRIGGER ALL
  END

  /* MovFlujo */
  if exists (select * from sysobjects where id = object_id('dbo.MovFlujo') and type = 'U')
  BEGIN
    ALTER TABLE MovFlujo DISABLE TRIGGER ALL
    DELETE MovFlujo FROM MovFlujo m, DepurarMov t WHERE m.OModulo = t.Modulo AND m.OID = t.ID
    DELETE MovFlujo FROM MovFlujo m, DepurarMov t WHERE m.DModulo = t.Modulo AND m.DID = t.ID
    ALTER TABLE MovFlujo ENABLE TRIGGER ALL
  END

  EXEC spDepurarModulo 'Mov'
  EXEC spDepurarModulo 'MovTiempo'
  EXEC spDepurarModulo 'MovUsuario'
  EXEC spDepurarModulo 'MovBitacora'
  EXEC spDepurarModuloID 'MovEstatusLog'
  EXEC spDepurarModulo 'GuiaEmbarque'
  EXEC spDepurarModulo 'GuiaEmbarqueD'
  EXEC spDepurarModulo 'SerieLoteMov'
  
  EXEC spDepurarRama 'AnexoMov'
  EXEC spDepurarRama 'AnexoMovD'
  EXEC spDepurarAuxiliar @FechaDepurar
  EXEC spDepurarAuxiliarU @FechaDepurar

  IF @ConservarEstadistica = 0
  BEGIN
    EXEC spDepurarAuxiliarR @FechaDepurar
    EXEC spDepurarAuxiliarRU @FechaDepurar
  END

  EXEC spDepurarMov 'CXC', 'CxcAplicaDif'
  EXEC spDepurarMov 'CXC', 'CxcD'
  EXEC spDepurarMov 'CXC', 'Cxc'

  EXEC spDepurarMov 'CXP', 'CxpAplicaDif'
  EXEC spDepurarMov 'CXP', 'CxpD'
  EXEC spDepurarMov 'CXP', 'Cxp'

  EXEC spDepurarMov 'VTAS', 'VentaD'
  EXEC spDepurarMov 'VTAS', 'VentaCobro'
  EXEC spDepurarMov 'VTAS', 'VentaOtros'
  EXEC spDepurarMov 'VTAS', 'VentaOrigen'
  EXEC spDepurarMov 'VTAS', 'ServicioTarea'
  EXEC spDepurarMov 'VTAS', 'Venta'

  EXEC spDepurarMov 'COMS', 'CompraD'
  EXEC spDepurarMov 'COMS', 'CompraGastoDiverso'
  EXEC spDepurarMov 'COMS', 'Compra'

  EXEC spDepurarMov 'INV', 'InvD'
  EXEC spDepurarMov 'INV', 'Inv'

  EXEC spDepurarMov 'DIN', 'DineroD'
  EXEC spDepurarMov 'DIN', 'Dinero'

  EXEC spDepurarMov 'CONT', 'ContD'
  EXEC spDepurarMov 'CONT', 'Cont'

  EXEC spDepurarMov 'CAM', 'CambioD'
  EXEC spDepurarMov 'CAM', 'Cambio'

  EXEC spDepurarMov 'CAP', 'CapitalD'
  EXEC spDepurarMov 'CAP', 'Capital'

  EXEC spDepurarMov 'INC', 'IncidenciaD'
  EXEC spDepurarMov 'INC', 'Incidencia'

  EXEC spDepurarMov 'CONC', 'ConciliacionD'
  EXEC spDepurarMov 'CONC', 'Conciliacion'

  EXEC spDepurarMov 'CREDI', 'Credito'

  EXEC spDepurarMov 'TMA', 'TMAD'
  EXEC spDepurarMov 'TMA', 'TMA'

  EXEC spDepurarMov 'CRM', 'CRMD'
  EXEC spDepurarMov 'CRM', 'CRM'
  --REQ16092
  EXEC spDepurarMov 'OPORT', 'OportunidadD'
  EXEC spDepurarMov 'OPORT', 'Oportunidad'

  EXEC spDepurarMov 'SAUX', 'SAUXD'
  EXEC spDepurarMov 'SAUX', 'SAUX'

  /* CambioAcum */
  if exists (select * from sysobjects where id = object_id('dbo.CambioAcum') and type = 'U') 
    DELETE CambioAcum WHERE Fecha < @FechaDepurar


  EXEC spDepurarMov 'GAS', 'GastoD'
  EXEC spDepurarMov 'GAS', 'GastoAplica'
  EXEC spDepurarMov 'GAS', 'Gasto'

  EXEC spDepurarMov 'EMB', 'EmbarqueD'
  EXEC spDepurarMov 'EMB', 'Embarque'
  EXEC spDepurarModuloID 'EmbarqueMov'

  EXEC spDepurarMov 'AF', 'ActivoFijoD'
  EXEC spDepurarMov 'AF', 'ActivoFijo'

  EXEC spDepurarMov 'NOM', 'NominaD'
  EXEC spDepurarMov 'NOM', 'NominaLog'
  EXEC spDepurarMov 'NOM', 'Nomina'

  EXEC spDepurarMov 'INC', 'IncidenciaH'
  EXEC spDepurarMov 'INC', 'IncidenciaD'
  EXEC spDepurarMov 'INC', 'Incidencia'

  EXEC spDepurarMov 'CONC', 'ConciliacionD'
  EXEC spDepurarMov 'CONC', 'Conciliacion'

  EXEC spDepurarMov 'PPTO', 'PresupD'
  EXEC spDepurarMov 'PPTO', 'Presup'

  EXEC spDepurarMov 'CREDI', 'Credito'

  EXEC spDepurarMov 'RH', 'RHD'
  EXEC spDepurarMov 'RH', 'RH'

  EXEC spDepurarMov 'ASIS', 'AsisteD'
  EXEC spDepurarMov 'ASIS', 'Asiste'

  EXEC spDepurarMov 'PC', 'PCD'
  EXEC spDepurarMov 'PC', 'PC'

  EXEC spDepurarMov 'OFER', 'OfertaD'
  EXEC spDepurarMov 'OFER', 'Oferta'

  EXEC spDepurarMov 'VALE', 'ValeD'
  EXEC spDepurarMov 'VALE', 'Vale'

  /* PersonalAsiste */
  if exists (select * from sysobjects where id = object_id('dbo.PersonalAsiste') and type = 'U') 
    DELETE PersonalAsiste WHERE Fecha < @FechaDepurar

  /* PersonalAsisteDifDia */
  if exists (select * from sysobjects where id = object_id('dbo.PersonalAsisteDifDia') and type = 'U') 
    DELETE PersonalAsisteDifDia WHERE Fecha < @FechaDepurar

  /* PersonalAsisteDifMin */
  if exists (select * from sysobjects where id = object_id('dbo.PersonalAsisteDifMin') and type = 'U') 
    DELETE PersonalAsisteDifMin WHERE Fecha < @FechaDepurar

  /* PersonalAsisteDif */
  if exists (select * from sysobjects where id = object_id('dbo.PersonalAsisteDif') and type = 'U') 
    DELETE PersonalAsisteDif WHERE Fecha < @FechaDepurar

  EXEC spDepurarMov 'AGENT', 'AgentD'
  EXEC spDepurarMov 'AGENT', 'Agent'

  EXEC spDepurarMov 'ST', 'Soporte'

  EXEC spDepurarMov 'PROD', 'ProdD'
  EXEC spDepurarMov 'PROD', 'Prod'
  EXEC spDepurarModuloID 'ProdSerieLoteCosto'

  EXEC spDepurarModulo 'AutoBoletoMov'
  EXEC spDepurarModulo 'AuxiliarAlterno'
  EXEC spDepurarModulo 'MovForma'
  EXEC spDepurarModulo 'MovTarea'
  EXEC spDepurarModulo 'SerieLoteD'
  EXEC spDepurarModulo 'ValeSerieMov'

  EXEC spDepurarMov 'CR', 'CR'
  EXEC spDepurarMov 'CR', 'CRAgente'
  EXEC spDepurarMov 'CR', 'CRCaja'
  EXEC spDepurarMov 'CR', 'CRCobro'
  EXEC spDepurarMov 'CR', 'CRInvFisico'
  EXEC spDepurarMov 'CR', 'CRSoporte'
  EXEC spDepurarMov 'CR', 'CRTrans'
  EXEC spDepurarMov 'CR', 'CRVenta'

  EXEC spDepurarMov 'COMS', 'CompraCB'
  EXEC spDepurarMov 'COMS', 'CompraDProrrateo'
  EXEC spDepurarMov 'COMS', 'CompraGastoDiversoD'

  EXEC spDepurarMov 'CXC', 'CxcFacturaAnticipo'
  EXEC spDepurarMov 'CXC', 'CxcVoucher'

  EXEC spDepurarModuloID 'EmbarqueDArt'

  EXEC spDepurarMov 'GAS', 'GastoDProrrateo'

  EXEC spDepurarMov 'INV', 'InvGastoDiverso'
  EXEC spDepurarMov 'INV', 'InvGastoDiversoD'

  EXEC spDepurarMov 'NOM', 'NominaPersonal'
  EXEC spDepurarMov 'NOM', 'NominaPersonalFecha'
  EXEC spDepurarMov 'NOM', 'NominaPersonalProy'

  EXEC spDepurarMov 'PROD', 'ProdProgramaMaterial'
  EXEC spDepurarMov 'PROD', 'ProdProgramaRuta'

  EXEC spDepurarMov 'ST', 'SoporteCambio'
  EXEC spDepurarMov 'ST', 'SoporteD'

  EXEC spDepurarMov 'VTAS', 'VentaCB'
  EXEC spDepurarMov 'VTAS', 'VentaCobroD'
  EXEC spDepurarMov 'VTAS', 'VentaDAgente'
  EXEC spDepurarMov 'VTAS', 'VentaDLogPicos'
  EXEC spDepurarMov 'VTAS', 'VentaFacturaAnticipo'
  EXEC spDepurarMov 'VTAS', 'VentaParticipacion'
  EXEC spDepurarMov 'VTAS', 'VentaResumen'
  EXEC spDepurarMov 'VTAS', 'ServicioAccesorios'

  DELETE PVRegistroCaptura WHERE Fecha < @FechaDepurar 

  /* SincroPaquete */
  if exists (select * from sysobjects where id = object_id('dbo.SincroPaquete') and type = 'U') 
    DELETE SincroPaquete WHERE Fecha < @FechaDepurar

  /* SincroLog */
  if exists (select * from sysobjects where id = object_id('dbo.SincroLog') and type = 'U') 
    DELETE SincroLog WHERE Fecha < @FechaDepurar

  /* SincroLogAdvertencia */
  if exists (select * from sysobjects where id = object_id('dbo.SincroLogAdvertencia') and type = 'U') 
    DELETE SincroLogAdvertencia WHERE Fecha < @FechaDepurar

  /* SincroLogError */
  if exists (select * from sysobjects where id = object_id('dbo.SincroLogError') and type = 'U') 
    DELETE SincroLogError WHERE Fecha < @FechaDepurar

  EXEC spDepurarModulo 'SincroMovRegistro'

  DELETE DepurarMov
  
  EXEC spReconstruirRamas
  EXEC spReconstruirSaldosIniciales

  CHECKPOINT
  RETURN
END
go

/*** SysCampo ***/
if exists (select * from sysobjects where id = object_id('dbo.SysCampo') and type = 'V') drop view dbo.SysCampo
GO
CREATE VIEW SysCampo
--//WITH ENCRYPTION
AS
SELECT "Tabla" = t.name, "Campo" = c.name , "ColID" = c.ColID, "EsCalculado" = c.IsComputed
  FROM sysobjects t, syscolumns c
 WHERE t.id = c.id AND t.type = 'U'
GO

/* xpBorrarMovimientos */
if exists (select * from sysobjects where id = object_id('dbo.xpBorrarMovimientos') and type = 'P') drop procedure dbo.xpBorrarMovimientos
GO
CREATE PROCEDURE xpBorrarMovimientos
AS BEGIN
 RETURN
END
GO

/* spBorrarMovimientos */
if exists (select * from sysobjects where id = object_id('dbo.spBorrarMovimientos') and type = 'P') drop procedure dbo.spBorrarMovimientos
GO
CREATE PROCEDURE spBorrarMovimientos
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @WMSAuxiliar	bit -- TASK1964

  SELECT @WMSAuxiliar = WMSAuxiliar FROM Version -- TASK1964

  IF (SELECT COUNT(*) FROM Auxiliar) > 300
  BEGIN
    RAISERROR ('Tiene mas de 300 Registros (Auxiliar), no se puede utilizar esta rutina.',16,-1) 
    RETURN
  END

  EXEC spBorrarTabla 'FechaTrabajo'
  EXEC spBorrarTabla 'Acceso'
  EXEC spBorrarTabla 'Saldo'
  EXEC spBorrarTabla 'SaldoC'
  IF @WMSAuxiliar = 1 -- TASK1964
  BEGIN
    EXEC spBorrarTabla 'SaldoUWMS'
    EXEC spBorrarTabla 'SaldoU'
  END ELSE-- TASK1964
    EXEC spBorrarTabla 'SaldoU'
  EXEC spBorrarTabla 'SaldoR'
  EXEC spBorrarTabla 'SaldoRU'
  EXEC spBorrarTabla 'ArtR'
  EXEC spBorrarTabla 'Acum'
  EXEC spBorrarTabla 'AcumC'
  IF @WMSAuxiliar = 1 -- TASK1964
  BEGIN
    EXEC spBorrarTabla 'AcumUWMS'
    EXEC spBorrarTabla 'AcumU'
  END ELSE-- TASK1964
    EXEC spBorrarTabla 'AcumU'
  EXEC spBorrarTabla 'AcumR'
  EXEC spBorrarTabla 'AcumRU'
  EXEC spBorrarTabla 'Auxiliar'
  IF @WMSAuxiliar = 1 -- TASK1964
  BEGIN
    EXEC spBorrarTabla 'AuxiliarUWMS'
    EXEC spBorrarTabla 'AuxiliarU'
  END ELSE-- TASK1964
    EXEC spBorrarTabla 'AuxiliarU'
  EXEC spBorrarTabla 'AuxiliarR'
  EXEC spBorrarTabla 'AuxiliarRU'
  EXEC spBorrarTabla 'InvCapa'
  EXEC spBorrarTabla 'InvCapaAux'
  EXEC spBorrarTabla 'Mov'
  EXEC spBorrarTabla 'MovFlujo'
  EXEC spBorrarTabla 'MovTiempo'
  EXEC spBorrarTabla 'MovUsuario'
  EXEC spBorrarTabla 'MovBitacora'
  EXEC spBorrarTabla 'MovEstatusLog'
  EXEC spBorrarTabla 'MovRef'
  EXEC spBorrarTabla 'MovImpuesto'
  EXEC spBorrarTabla 'MovPresupuesto'
  EXEC spBorrarTabla 'MovInfoPath'
  EXEC spBorrarTabla 'MovReg'
  EXEC spBorrarTabla 'MovDReg'
  EXEC spBorrarTabla 'Presupuesto'
  EXEC spBorrarTabla 'ArtPrecioHist '
  EXEC spBorrarTabla 'ArtCosto'
  EXEC spBorrarTabla 'ArtCostoHist'
  EXEC spBorrarTabla 'ArtSubCostoHist'
  EXEC spBorrarTabla 'SerieLote'
  EXEC spBorrarTabla 'TarimaSerieLote'
  EXEC spBorrarTabla 'SerieLoteD'
  EXEC spBorrarTabla 'Cxc'
  EXEC spBorrarTabla 'CxcD'
  EXEC spBorrarTabla 'CxcVoucher'
  EXEC spBorrarTabla 'CxcC'
  EXEC spBorrarTabla 'CxcAplicaDif'
  EXEC spBorrarTabla 'CxcFacturaAnticipo'
  EXEC spBorrarTabla 'Cxp'
  EXEC spBorrarTabla 'CxpD'
  EXEC spBorrarTabla 'CxpC'
  EXEC spBorrarTabla 'CxpAplicaDif'
  EXEC spBorrarTabla 'CxReevaluacionLog'
  EXEC spBorrarTabla 'CxTasaDiariaLog'
  EXEC spBorrarTabla 'DocAuto'
  EXEC spBorrarTabla 'Venta'
  EXEC spBorrarTabla 'VentaD'
  EXEC spBorrarTabla 'VentaDPresupuestoEsp'
  EXEC spBorrarTabla 'VentaDAgente'
  EXEC spBorrarTabla 'VentaC'
  EXEC spBorrarTabla 'VentaCB'
  EXEC spBorrarTabla 'VentaResumen'
  EXEC spBorrarTabla 'VentaFacturaAnticipo'
  EXEC spBorrarTabla 'VentaParticipacion'
  EXEC spBorrarTabla 'GuiaEmbarque'
  EXEC spBorrarTabla 'GuiaEmbarqueD'
  EXEC spBorrarTabla 'VentaCobro'
  EXEC spBorrarTabla 'VentaOrigen'
  EXEC spBorrarTabla 'ServicioTarea'
  EXEC spBorrarTabla 'VentaOtros'

--REQ 15448
  EXEC spBorrarTabla 'VentaProcesarNotas'
  EXEC spBorrarTabla 'Compra'
  EXEC spBorrarTabla 'CompraD'
  EXEC spBorrarTabla 'CompraDProrrateo'
  EXEC spBorrarTabla 'CompraDPresupuestoEsp'
  EXEC spBorrarTabla 'CompraC'
  EXEC spBorrarTabla 'CompraGastoDiverso'
  EXEC spBorrarTabla 'CompraGastoDiversoD'
  EXEC spBorrarTabla 'Inv'
  EXEC spBorrarTabla 'InvD'
  EXEC spBorrarTabla 'InvC'
  EXEC spBorrarTabla 'InvGastoDiverso'
  EXEC spBorrarTabla 'InvGastoDiversoD'
  EXEC spBorrarTabla 'SerieLoteMov'
  EXEC spBorrarTabla 'SerieLoteProp'
  EXEC spBorrarTabla 'Dinero'
  EXEC spBorrarTabla 'DineroD'
  EXEC spBorrarTabla 'DineroC'
  EXEC spBorrarTabla 'Cont'
  EXEC spBorrarTabla 'ContD'
  EXEC spBorrarTabla 'ContReg'
  EXEC spBorrarTabla 'ContC'
  EXEC spBorrarTabla 'Cambio'
  EXEC spBorrarTabla 'CambioD'
  EXEC spBorrarTabla 'CambioC'
  EXEC spBorrarTabla 'CambioAcum'
  EXEC spBorrarTabla 'Gasto'
  EXEC spBorrarTabla 'GastoD'
  EXEC spBorrarTabla 'GastoDProrrateo'
  EXEC spBorrarTabla 'GastoDPresupuestoEsp'
  EXEC spBorrarTabla 'GastoAplica'
  EXEC spBorrarTabla 'GastoC'
  EXEC spBorrarTabla 'EmbarqueMov'
  EXEC spBorrarTabla 'Embarque'
  EXEC spBorrarTabla 'EmbarqueD'
  EXEC spBorrarTabla 'EmbarqueDArt'
  EXEC spBorrarTabla 'EmbarqueC'
  EXEC spBorrarTabla 'EmbarqueAsistenteCobro'
  EXEC spBorrarTabla 'EmbarqueAsistenteGeneral'
  EXEC spBorrarTabla 'ActivoF'
  EXEC spBorrarTabla 'ActivoFijo'
  EXEC spBorrarTabla 'ActivoFijoD'
  EXEC spBorrarTabla 'ActivoFijoC'
  EXEC spBorrarTabla 'Nomina'
  EXEC spBorrarTabla 'NominaD'
  EXEC spBorrarTabla 'NominaC'
  EXEC spBorrarTabla 'NominaLog'
  EXEC spBorrarTabla 'NominaPersonal'
  EXEC spBorrarTabla 'NominaCorrespondeLote'
  EXEC spBorrarTabla 'Incidencia'
  EXEC spBorrarTabla 'IncidenciaD'
  EXEC spBorrarTabla 'IncidenciaH'
  EXEC spBorrarTabla 'RH'
  EXEC spBorrarTabla 'RHD'
  EXEC spBorrarTabla 'RHC'
  EXEC spBorrarTabla 'Asiste'
  EXEC spBorrarTabla 'AsisteD'
  EXEC spBorrarTabla 'AsisteC'
  EXEC spBorrarTabla 'PersonalAsiste'
  EXEC spBorrarTabla 'PersonalAsisteDifDia'
  EXEC spBorrarTabla 'PersonalAsisteDifMin'
  EXEC spBorrarTabla 'PersonalAsisteDif'
  EXEC spBorrarTabla 'Agent'
  EXEC spBorrarTabla 'AgentD'
  EXEC spBorrarTabla 'AgentC'
  EXEC spBorrarTabla 'Soporte'
  EXEC spBorrarTabla 'SoporteD'
  EXEC spBorrarTabla 'SoporteC'
  EXEC spBorrarTabla 'AnexoMov'
  EXEC spBorrarTabla 'AnexoMovD'
  EXEC spBorrarTabla 'Prod'
  EXEC spBorrarTabla 'ProdD'
  EXEC spBorrarTabla 'ProdProgramaMaterial'
  EXEC spBorrarTabla 'ProdProgramaRuta'
  EXEC spBorrarTabla 'ProdC'
  EXEC spBorrarTabla 'ProdSerieLote'
  EXEC spBorrarTabla 'ProdSerieLoteCosto'
  EXEC spBorrarTabla 'PlanArt'
  EXEC spBorrarTabla 'PlanArtOP'
  EXEC spBorrarTabla 'PlanBitacora'
  EXEC spBorrarTabla 'PlanMensaje'
  EXEC spBorrarTabla 'ArtSubCosto'
  EXEC spBorrarTabla 'SincroPaquete'
  EXEC spBorrarTabla 'SincroLog'
  EXEC spBorrarTabla 'SincroLogAdvertencia'
  EXEC spBorrarTabla 'SincroLogError'
  EXEC spBorrarTabla 'SincroMovRegistro'
  EXEC spBorrarTabla 'PC'
  EXEC spBorrarTabla 'PCD'
  EXEC spBorrarTabla 'PCBoletin'
  EXEC spBorrarTabla 'PCC'
  EXEC spBorrarTabla 'Vale'
  EXEC spBorrarTabla 'ValeD'
  EXEC spBorrarTabla 'ValeC'
  EXEC spBorrarTabla 'ValeSerie'
  EXEC spBorrarTabla 'ValeSerieMov'
  EXEC spBorrarTabla 'Anticipo'
  EXEC spBorrarTabla 'ConciliacionLog'
  EXEC spBorrarTabla 'EspacioResultado'
  EXEC spBorrarTabla 'AfectarBitacora'
  EXEC spBorrarTabla 'ResumenMov'
  EXEC spBorrarTabla 'ResumenMovProyecto'
  EXEC spBorrarTabla 'ResumenSaldo'
  EXEC spBorrarTabla 'PagadoAux'
  EXEC spBorrarTabla 'PersonalUltimoPago'
  EXEC spBorrarTabla 'CtePresupuesto'

  EXEC spBorrarTabla 'CR'
  EXEC spBorrarTabla 'CRVenta'
  EXEC spBorrarTabla 'CRAgente'
  EXEC spBorrarTabla 'CRCobro'
  EXEC spBorrarTabla 'CRCaja'
  EXEC spBorrarTabla 'CRInvFisico'
  EXEC spBorrarTabla 'CRSoporte'
  EXEC spBorrarTabla 'CRTrans'
  EXEC spBorrarTabla 'CRC'
  EXEC spBorrarTabla 'CRMov'
  EXEC spBorrarTabla 'CRMovD'
  EXEC spBorrarTabla 'CRMovSoporte'
  EXEC spBorrarTabla 'CRBitacora'

  EXEC spBorrarTabla 'MovRecibo'
  EXEC spBorrarTabla 'Tarea'
  EXEC spBorrarTabla 'CtaDineroHist'
  EXEC spBorrarTabla 'CteHist'
  EXEC spBorrarTabla 'ArtComisionHist'
  EXEC spBorrarTabla 'ArtSituacionHist'
  EXEC spBorrarTabla 'ArtSubCostoHist'
  EXEC spBorrarTabla 'ArtProvHist'
  EXEC spBorrarTabla 'VINHist'
  EXEC spBorrarTabla 'EvaluacionCtoHist'
  EXEC spBorrarTabla 'TablaImpuestoHist'
  EXEC spBorrarTabla 'ZonaEconomicaHist'
  EXEC spBorrarTabla 'ArtAlmABCHist'
  EXEC spBorrarTabla 'MonHist'
  EXEC spBorrarTabla 'TablaAmortizacion'
  EXEC spBorrarTabla 'TablaAmortizacionGuia'
  EXEC spBorrarTabla 'TablaAmortizacionMigracion'
  EXEC spBorrarTabla 'Registro'

  EXEC spBorrarTabla 'Capital'
  EXEC spBorrarTabla 'CapitalD'
  EXEC spBorrarTabla 'CapitalC'

  EXEC spBorrarTabla 'TMA'
  EXEC spBorrarTabla 'TMAD'
  EXEC spBorrarTabla 'TMAC'
  EXEC spBorrarTabla 'Tarima'
  EXEC spBorrarTabla 'AuxiliarAlterno'
  EXEC spBorrarTabla 'MovCampoExtra'
  EXEC spBorrarTabla 'MovForma'
  EXEC spBorrarTabla 'MovTarea'
  EXEC spBorrarTabla 'NotaMov'

  EXEC spBorrarTabla 'CRM'
  EXEC spBorrarTabla 'CRMD'
  EXEC spBorrarTabla 'CRMC'

  --REQ16092
  EXEC spBorrarTabla 'Oportunidad'
  EXEC spBorrarTabla 'OportunidadD'
  EXEC spBorrarTabla 'OportunidadC'

  EXEC spBorrarTabla 'AutoBoletoMov'
  EXEC spBorrarTabla 'AuxiliarAlterno'

  EXEC spBorrarTabla 'CompraCB'
  EXEC spBorrarTabla 'InvGastoDiverso'
  EXEC spBorrarTabla 'InvGastoDiversoD'

  EXEC spBorrarTabla 'NominaPersonal'
  EXEC spBorrarTabla 'NominaPersonalFecha'
  EXEC spBorrarTabla 'NominaPersonalProy'

  EXEC spBorrarTabla 'SoporteCambio'

  EXEC spBorrarTabla 'VentaCobroD'
  EXEC spBorrarTabla 'VentaDLogPicos'
  EXEC spBorrarTabla 'ServicioAccesorios'

  EXEC spBorrarTabla 'Gestion'
  EXEC spBorrarTabla 'GestionD'
  EXEC spBorrarTabla 'GestionPara'
  EXEC spBorrarTabla 'GestionC'
  EXEC spBorrarTabla 'GestionTarea'
  EXEC spBorrarTabla 'GestionPlan'
  EXEC spBorrarTabla 'GestionActividad'

  EXEC spBorrarTabla 'Act'
  EXEC spBorrarTabla 'ActD'
  EXEC spBorrarTabla 'ActC'

  EXEC spBorrarTabla 'SincroLogLista'

  EXEC spBorrarTabla 'RSS'
  EXEC spBorrarTabla 'RSSC'

  EXEC spBorrarTabla 'Concilicion'
  EXEC spBorrarTabla 'ConcilicionD'

--JGD 31Mayo2011. Ticket 4760
  EXEC spBorrarTabla 'Fiscal'
  EXEC spBorrarTabla 'FiscalD'
  EXEC spBorrarTabla 'FiscalC'
  
  EXEC spBorrarTabla 'Oferta'
  EXEC spBorrarTabla 'OfertaD'
  EXEC spBorrarTabla 'OfertaC'
  EXEC spBorrarTabla 'OfertaFiltro'
  EXEC spBorrarTabla 'OfertaSucursalEsp'
  EXEC spBorrarTabla 'OfertaDVol'
  EXEC spBorrarTabla 'OfertaH'
  EXEC spBorrarTabla 'OfertaHVol'  

--Vertical Inmobiliaria
  EXEC spBorrarTabla 'Contrato'
  /*EXEC spBorrarTabla 'vic_Contrato'
  EXEC spBorrarTabla 'vic_Condicion'
  EXEC spBorrarTabla 'vic_CondicionListado'
  EXEC spBorrarTabla 'vic_HistLocal'
  EXEC spBorrarTabla 'vic_ContMinuta'*/ 

  EXEC spBorrarTabla 'AuxiliarValeSerie'
  EXEC spBorrarTabla 'PeriodoTipoMov'
  EXEC spBorrarTabla 'CFD'
  EXEC spBorrarTabla 'CFDENviar'
  EXEC spBorrarTabla 'Organiza'
  EXEC spBorrarTabla 'OrganizaD'
  EXEC spBorrarTabla 'Campana'
  EXEC spBorrarTabla 'CampanaD'
  EXEC spBorrarTabla 'PersonalEntrada'
  EXEC spBorrarTabla 'PersonalEntradaH'
  EXEC spBorrarTabla 'ReclutaPlaza'
  EXEC spBorrarTabla 'Recluta'
  EXEC spBorrarTabla 'ReclutaD'

--SAUX
  EXEC spBorrarTabla 'SAUX'
  EXEC spBorrarTabla 'SAUXD'
  EXEC spBorrarTabla 'SAUXC'
  EXEC spBorrarTabla 'SAUXDIndicador'
  
  EXEC spBorrarTabla 'Credito' --BUG13570

  --- Bug 23588 
  EXEC spBorrarTabla 'Conciliacion' 
  EXEC spBorrarTabla 'ConciliacionD'
  EXEC spBorrarTabla 'ConciliacionCompensacion'
  --- Bug 23588 Extra
  EXEC spBorrarTabla 'TarjetaSerieMov'

  if exists(select * from syscampo where tabla = 'Vehiculo' 	and campo = 'Estatus') 		EXEC("UPDATE Vehiculo 		SET Estatus = 'DISPONIBLE'")
  if exists(select * from syscampo where tabla = 'RHPlaza' 	and campo = 'EnUso')    	EXEC("UPDATE RHPlaza 		SET EnUso = NULL")
  if exists(select * from syscampo where tabla = 'Cta' 		and campo = 'TieneMovimientos') EXEC("UPDATE Cta 		SET TieneMovimientos = 0")
  if exists(select * from syscampo where tabla = 'ArtAlm' 	and campo = 'TieneMovimientos') EXEC("UPDATE ArtAlm		SET TieneMovimientos = 0")
  if exists(select * from syscampo where tabla = 'CtaDinero' 	and campo = 'TieneMovimientos') EXEC("UPDATE CtaDinero 		SET TieneMovimientos = 0")
  if exists(select * from syscampo where tabla = 'CtaDinero' 	and campo = 'Cajero')           EXEC("UPDATE CtaDinero 		SET Cajero = NULL")
  if exists(select * from syscampo where tabla = 'Cte' 		and campo = 'TieneMovimientos') EXEC("UPDATE Cte 		SET TieneMovimientos = 0")
  if exists(select * from syscampo where tabla = 'CteEnviarA' 	and campo = 'TieneMovimientos') EXEC("UPDATE CteEnviarA 	SET TieneMovimientos = 0")
  if exists(select * from syscampo where tabla = 'Alm' 		and campo = 'TieneMovimientos') EXEC("UPDATE Alm 		SET TieneMovimientos = 0")
  if exists(select * from syscampo where tabla = 'Art' 		and campo = 'TieneMovimientos') EXEC("UPDATE Art 		SET TieneMovimientos = 0")
  if exists(select * from syscampo where tabla = 'Prov' 	and campo = 'TieneMovimientos') EXEC("UPDATE Prov 		SET TieneMovimientos = 0")
  if exists(select * from syscampo where tabla = 'Agente' 	and campo = 'TieneMovimientos') EXEC("UPDATE Agente 		SET TieneMovimientos = 0")
  if exists(select * from syscampo where tabla = 'Usuario' 	and campo = 'TieneMovimientos') EXEC("UPDATE Usuario 		SET TieneMovimientos = 0")
  if exists(select * from syscampo where tabla = 'Personal' 	and campo = 'TieneMovimientos') EXEC("UPDATE Personal 		SET TieneMovimientos = 0")
  if exists(select * from syscampo where tabla = 'Personal' 	and campo = 'Estatus') 	        EXEC("UPDATE Personal 		SET Estatus = 'ASPIRANTE'")
  if exists(select * from syscampo where tabla = 'Personal' 	and campo = 'UltimoPago')       EXEC("UPDATE Personal 		SET UltimoPago = NULL")
  if exists(select * from syscampo where tabla = 'VIN' 		and campo = 'TieneMovimientos') EXEC("UPDATE VIN 		SET TieneMovimientos = 0")
  if exists(select * from syscampo where tabla = 'CentroCostos' and campo = 'TieneMovimientos') EXEC("UPDATE CentroCostos 	SET TieneMovimientos = 0")
  if exists(select * from syscampo where tabla = 'Vehiculo' 	and campo = 'TieneMovimientos') EXEC("UPDATE Vehiculo 		SET TieneMovimientos = 0")
  if exists(select * from syscampo where tabla = 'ActivoF' 	and campo = 'TieneMovimientos') EXEC("UPDATE ActivoF		SET TieneMovimientos = 0")
  if exists(select * from syscampo where tabla = 'ProdRuta' 	and campo = 'TieneMovimientos') EXEC("UPDATE ProdRuta		SET TieneMovimientos = 0")
  if exists(select * from syscampo where tabla = 'EstacionT' 	and campo = 'TieneMovimientos') EXEC("UPDATE EstacionT		SET TieneMovimientos = 0")
  if exists(select * from syscampo where tabla = 'Centro' 	and campo = 'TieneMovimientos') EXEC("UPDATE Centro		SET TieneMovimientos = 0")
  if exists(select * from syscampo where tabla = 'CtaDineroCajero' and campo = 'Cajero')    	EXEC("UPDATE CtaDineroCajero	SET Cajero = NULL")
  if exists(select * from syscampo where tabla = 'CB' 		and campo = 'ModuloID')    	EXEC("UPDATE CB			SET Modulo = NULL, ModuloID = NULL")
  if exists(select * from syscampo where tabla = 'OpcionD' 	and campo = 'TieneMovimientos') EXEC("UPDATE OpcionD		SET TieneMovimientos = 0")
  if exists(select * from syscampo where tabla = 'ArtOpcion' 	and campo = 'TieneMovimientos') EXEC("UPDATE ArtOpcion		SET TieneMovimientos = 0")
  if exists(select * from syscampo where tabla = 'ArtOpcionD' 	and campo = 'TieneMovimientos') EXEC("UPDATE ArtOpcionD		SET TieneMovimientos = 0")
  if exists(select * from syscampo where tabla = 'AlmPos' 	and campo = 'Tarima') 		EXEC("UPDATE AlmPos		SET Tarima = NULL")
  /*Vertical Inmobiliaria
  if exists(select * from syscampo where tabla = 'vic_local' and campo = 'Estatus') 		EXEC("UPDATE vic_local SET Estatus = 'DESOCUPADO'")
  if exists(select * from syscampo where tabla = 'vic_local' and campo = 'Contrato') 		EXEC("UPDATE vic_local SET Contrato = NULL")*/

  EXEC xpBorrarMovimientos
  
END
GO