/* REORGANIZAR */

/**************** spLimpiarArtR ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLimpiarArtR') and type = 'P') drop procedure dbo.spLimpiarArtR
GO             
CREATE PROCEDURE spLimpiarArtR
--//WITH ENCRYPTION
AS BEGIN
  TRUNCATE TABLE ArtR
  UPDATE Version SET ArtR = NULL
  INSERT ArtR (Empresa, Articulo, SubCuenta, Almacen, Localizacion, Minimo, Maximo, PuntoOrden, PuntoOrdenOrdenar) 
        SELECT Empresa, Articulo, SubCuenta, Almacen, Localizacion, Minimo, Maximo, PuntoOrden, PuntoOrdenOrdenar FROM ArtAlm
END
GO


/**************** spReconstruirArtR ****************/
if exists (select * from sysobjects where id = object_id('dbo.spReconstruirArtR') and type = 'P') drop procedure dbo.spReconstruirArtR
GO             
CREATE PROCEDURE spReconstruirArtR
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
    @Empresa	 char(5),
    @Articulo	 char(20),
    @SubCuenta	 varchar(50),
    @Almacen	 char(10),
    @Rama	 char(5),
    @CantidadU	 float,
    @EnTransito	 float,
    @Pendiente	 float,
    @Ordenado	 float,
    @Remisionado float,
    @RequsicionesPendientes float,
    @MovTipo	 char(20),
    @INV	 float,
    @RESV	 float,
    @VMOS	 float,
    @GAR	 float,
    @CSG	 float,
    @AF		 float,
    @PZA	 float

  BEGIN TRANSACTION

  EXEC spLimpiarArtR

  DECLARE crSaldoU CURSOR FOR
   SELECT Empresa, Rama, Cuenta, ISNULL(SubCuenta, ''), Grupo, SaldoU
    FROM SaldoU
   WHERE NULLIF(RTRIM(Grupo), '') IS NOT NULL AND Rama IN ('INV', 'RESV', 'VMOS', 'CSG', 'GAR', 'AF', 'PZA')

  OPEN crSaldoU
  FETCH NEXT FROM crSaldoU INTO @Empresa, @Rama, @Articulo, @SubCuenta, @Almacen, @CantidadU
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @INV = 0.0, @RESV = 0.0, @VMOS = 0.0, @GAR = 0.0, @CSG = 0.0, @AF = 0.0, @PZA = 0.0
      IF @Rama = 'INV'  SELECT @INV  = @CantidadU ELSE
      IF @Rama = 'RESV' SELECT @RESV = @CantidadU ELSE
      IF @Rama = 'VMOS' SELECT @VMOS = @CantidadU ELSE
      IF @Rama = 'CSG'  SELECT @CSG  = @CantidadU ELSE
      IF @Rama = 'GAR'  SELECT @GAR  = @CantidadU ELSE
      IF @Rama = 'AF'   SELECT @AF   = @CantidadU ELSE
      IF @Rama = 'PZA'  SELECT @PZA  = @CantidadU
      UPDATE ArtR
         SET INV  = ISNULL(INV,  0.0) + @INV,
             RESV = ISNULL(RESV, 0.0) + @RESV,
             VMOS = ISNULL(VMOS, 0.0) + @VMOS,
             CSG  = ISNULL(CSG,  0.0) + @CSG,
             GAR  = ISNULL(GAR,  0.0) + @GAR,
             AF   = ISNULL(AF,   0.0) + @AF,
             PZA  = ISNULL(PZA,  0.0) + @PZA,
             TieneMovimientos = 1
       WHERE Empresa = @Empresa
         AND Articulo = @Articulo
         AND SubCuenta = ISNULL(@SubCuenta, '')
         AND Almacen = @Almacen
      IF @@ROWCOUNT = 0
        INSERT ArtR ( Empresa,  Articulo,  SubCuenta,              Almacen,  INV,  RESV,  VMOS,  GAR,  CSG,  AF,  PZA,  TieneMovimientos)
             VALUES (@Empresa, @Articulo, ISNULL(@SubCuenta, ''), @Almacen,  @INV, @RESV, @VMOS, @GAR, @CSG, @AF, @PZA, 1)
    END
    FETCH NEXT FROM crSaldoU INTO @Empresa, @Rama, @Articulo, @SubCuenta, @Almacen, @CantidadU
  END
  CLOSE crSaldoU
  DEALLOCATE crSaldoU
  
  DECLARE crVenta CURSOR FOR
   SELECT v.Empresa, d.Almacen, d.Articulo, d.SubCuenta, ISNULL(d.CantidadPendiente, 0.0), ISNULL(d.CantidadOrdenada, 0.0), mt.Clave
     FROM Venta v, VentaD d, MovTipo mt
    WHERE v.ID = d.ID AND mt.Mov = v.Mov AND mt.Clave IN ('VTAS.R', 'VTAS.P', 'VTAS.S', 'VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX', 'VTAS.FB') AND v.Estatus = 'PENDIENTE' AND nullif(rtrim(d.almacen), '') IS NOT NULL
  OPEN crVenta
  FETCH NEXT FROM crVenta INTO @Empresa, @Almacen, @Articulo, @SubCuenta, @Pendiente, @Ordenado, @MovTipo
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @MovTipo = 'VTAS.R' SELECT @Remisionado = @Pendiente, @Pendiente = 0.0, @Ordenado = 0.0
      UPDATE ArtR
         SET VentaPendiente   = ISNULL(VentaPendiente, 0.0) + @Pendiente,
	     CantidadOrdenada = ISNULL(CantidadOrdenada, 0.0) + @Ordenado,
	     VentaRemisionada = ISNULL(VentaRemisionada, 0.0) + @Remisionado,
             TieneMovimientos = 1
       WHERE Empresa   = @Empresa
         AND Articulo  = @Articulo
         AND SubCuenta = ISNULL(@SubCuenta, '')
         AND Almacen   = @Almacen
      IF @@ROWCOUNT = 0
        INSERT ArtR (Empresa,  Articulo,  SubCuenta,               Almacen,  VentaPendiente,  CantidadOrdenada,  VentaRemisionada, TieneMovimientos)
             VALUES (@Empresa, @Articulo, ISNULL(@SubCuenta, ''), @Almacen, @Pendiente,       @Ordenado,         @Remisionado,     1)
    END
    FETCH NEXT FROM crVenta INTO @Empresa, @Almacen, @Articulo, @SubCuenta, @Pendiente, @Ordenado, @MovTipo
  END
  CLOSE crVenta
  DEALLOCATE crVenta

  DECLARE crInv CURSOR FOR
   SELECT i.Empresa, d.Almacen, d.Articulo, d.SubCuenta, ISNULL(d.CantidadPendiente, 0.0), ISNULL(d.CantidadOrdenada, 0.0)
     FROM Inv i, InvD d, MovTipo mt
    WHERE i.ID = d.ID AND mt.Mov = i.Mov AND mt.Clave IN ('INV.SOL', 'INV.OT', 'INV.OI', 'INV.TI', 'INV.SM') AND i.Estatus = 'PENDIENTE' AND nullif(rtrim(d.almacen), '') IS NOT NULL
  OPEN crInv
  FETCH NEXT FROM crInv INTO @Empresa, @Almacen, @Articulo, @SubCuenta, @Pendiente, @Ordenado
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @MovTipo = 'INV.TI' SELECT @EnTransito = @Pendiente, @Pendiente = 0.0
      UPDATE ArtR
         SET InvPendiente     = ISNULL(InvPendiente, 0.0) + @Pendiente,
	     EnTransito	      = ISNULL(EnTransito, 0.0) + @EnTransito,
	     CantidadOrdenada = ISNULL(CantidadOrdenada, 0.0) + @Ordenado,
             TieneMovimientos = 1
       WHERE Empresa   = @Empresa
         AND Articulo  = @Articulo
         AND SubCuenta = ISNULL(@SubCuenta, '')
         AND Almacen   = @Almacen
      IF @@ROWCOUNT = 0
        INSERT ArtR (Empresa,  Articulo,  SubCuenta,               Almacen,  InvPendiente, CantidadOrdenada, TieneMovimientos)
             VALUES (@Empresa, @Articulo, ISNULL(@SubCuenta, ''), @Almacen, @Pendiente,    @Ordenado,        1)
    END
    FETCH NEXT FROM crInv INTO @Empresa, @Almacen, @Articulo, @SubCuenta, @Pendiente, @Ordenado
  END
  CLOSE crInv
  DEALLOCATE crInv

  DECLARE crCompra CURSOR FOR
   SELECT c.Empresa, d.Almacen, d.Articulo, d.SubCuenta, ISNULL(d.CantidadPendiente, 0.0), mt.Clave
     FROM Compra c, CompraD d, MovTipo mt
    WHERE c.ID = d.ID AND mt.Mov = c.Mov AND mt.Clave IN ('COMS.R', 'COMS.O', 'COMS.OG', 'COMS.OI') AND c.Estatus = 'PENDIENTE' AND nullif(rtrim(d.almacen), '') IS NOT NULL

  OPEN crCompra
  FETCH NEXT FROM crCompra INTO @Empresa, @Almacen, @Articulo, @SubCuenta, @Pendiente, @MovTipo
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @MovTipo = 'COMS.R' 
        SELECT @RequsicionesPendientes = @Pendiente, @Ordenado = 0.0 
      ELSE SELECT @RequsicionesPendientes = 0.0, @Ordenado = @Pendiente 

      UPDATE ArtR
         SET CompraPendiente   = ISNULL(CompraPendiente, 0.0) + @Ordenado,
             RequsicionesPendientes = ISNULL(RequsicionesPendientes, 0.0) + @RequsicionesPendientes,
             TieneMovimientos = 1
       WHERE Empresa   = @Empresa
         AND Articulo  = @Articulo
         AND SubCuenta = ISNULL(@SubCuenta, '')
         AND Almacen   = @Almacen
      IF @@ROWCOUNT = 0
        INSERT ArtR (Empresa,  Articulo,  SubCuenta,               Almacen, CompraPendiente, RequsicionesPendientes,  TieneMovimientos)
             VALUES (@Empresa, @Articulo, ISNULL(@SubCuenta, ''), @Almacen, @Ordenado,       @RequsicionesPendientes, 1)
    END
    FETCH NEXT FROM crCompra INTO @Empresa, @Almacen, @Articulo, @SubCuenta, @Pendiente, @MovTipo
  END
  CLOSE crCompra
  DEALLOCATE crCompra


  DECLARE crProd CURSOR FOR
   SELECT c.Empresa, d.Almacen, d.Articulo, d.SubCuenta, ISNULL(d.CantidadPendiente, 0.0)
     FROM Prod c, ProdD d, MovTipo mt
    WHERE c.ID = d.ID AND mt.Mov = c.Mov AND mt.Clave = 'PROD.O' AND c.Estatus = 'PENDIENTE' AND nullif(rtrim(d.almacen), '') IS NOT NULL 

  OPEN crProd
  FETCH NEXT FROM crProd INTO @Empresa, @Almacen, @Articulo, @SubCuenta, @Pendiente
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      UPDATE ArtR
         SET ProdPendiente   = ISNULL(ProdPendiente, 0.0) + @Pendiente,
             TieneMovimientos = 1
       WHERE Empresa   = @Empresa
         AND Articulo  = @Articulo
         AND SubCuenta = ISNULL(@SubCuenta, '')
         AND Almacen   = @Almacen
      IF @@ROWCOUNT = 0
        INSERT ArtR (Empresa,  Articulo,  SubCuenta,               Almacen,  ProdPendiente, TieneMovimientos)
             VALUES (@Empresa, @Articulo, ISNULL(@SubCuenta, ''), @Almacen, @Pendiente,     1)
    END
    FETCH NEXT FROM crProd INTO @Empresa, @Almacen, @Articulo, @SubCuenta, @Pendiente
  END
  CLOSE crProd
  DEALLOCATE crProd

  UPDATE Version SET ArtR = GETDATE()

  COMMIT TRANSACTION

  SELECT "Se Recalculo con Exito el Resumen de los Articulos"
END
GO
