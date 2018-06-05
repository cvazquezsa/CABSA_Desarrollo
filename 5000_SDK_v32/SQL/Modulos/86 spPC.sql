/* SP PC   */

-- PC.P  Precios
-- PC.C  Costos

SET NOCOUNT ON

/**************** spPCGetOriginal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPCGetOriginal') and type = 'P') drop procedure dbo.spPCGetOriginal
GO             
CREATE PROCEDURE spPCGetOriginal
			@Empresa	char(5),
			@Articulo	char(20),
			@SubCuenta	varchar(50),
			@Unidad		varchar(50),
			@MovMoneda	char(10),
			@MovTipoCambio	float,
			@Lista		varchar(20),
			@Precio		money	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ArtMoneda		char(10),
    @ArtFactor		float,
    @ArtTipoCambio	float,
    @Ok			int

  SELECT @Precio = NULL
  DECLARE crPrecioOriginal CURSOR FOR
   SELECT Anterior, Moneda, TipoCambio 
     FROM pc, pcd 
    WHERE pc.id = pcd.id AND pc.Empresa = @Empresa AND pc.Estatus = 'VIGENTE' AND pcd.Articulo = @Articulo AND ISNULL(pcd.SubCuenta, '') = ISNULL(@SubCuenta, '') AND ISNULL(pcd.Unidad, '') = ISNULL(@Unidad, '') AND pc.ListaModificar = @Lista
    ORDER BY pc.FechaEmision

  OPEN crPrecioOriginal
  FETCH NEXT FROM crPrecioOriginal INTO @Precio, @ArtMoneda, @ArtTipoCambio
  IF @@FETCH_STATUS = 0
  BEGIN
    IF @ArtMoneda <> @MovMoneda
    BEGIN
      EXEC spMoneda NULL, @MovMoneda, @MovTipoCambio, @ArtMoneda, @ArtFactor OUTPUT, @ArtTipoCambio OUTPUT, @Ok OUTPUT
      SELECT @Precio = @Precio * @ArtFactor
    END
  END
  CLOSE crPrecioOriginal
  DEALLOCATE crPrecioOriginal
  RETURN
END
GO

/**************** spPCGet ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPCGet') and type = 'P') drop procedure dbo.spPCGet
GO             
CREATE PROCEDURE spPCGet
			@Sucursal	int,
			@Empresa	char(5),
			@Articulo	char(20),
			@SubCuenta	varchar(50),
			@Unidad		varchar(50),
			@MovMoneda	char(10),
			@MovTipoCambio	float,
			@Lista		varchar(20),
			@Precio		money	OUTPUT,
			@VerResultado	bit = 0,
			@PrecioOriginal	bit = 0,
			@Proveedor	varchar(10) = NULL,
                        @SucursalEsp	int = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ArtMoneda		char(10),
    @ArtFactor		float,
    @ArtTipoCambio	float,
    @Ok			int

  SELECT @Precio = NULL, @ArtMoneda = NULL, @Ok = NULL, @SubCuenta = NULLIF(RTRIM(NULLIF(@SubCuenta, '0')), ''), @Unidad = NULLIF(RTRIM(@Unidad), '')
  IF @PrecioOriginal = 1  
    EXEC spPCGetOriginal @Empresa, @Articulo, @SubCuenta, @Unidad, @MovMoneda, @MovTipoCambio, @Lista, @Precio OUTPUT

  IF @Lista NOT IN ('(Ultimo Costo)', '(Costo Promedio)', '(Costo Estandar)', '(Costo Reposicion)', '(Costo Proveedor)', '(Ultimo Costo Prov)')
  BEGIN
    IF @Unidad IS NOT NULL
    BEGIN
      IF @SubCuenta IS NOT NULL
        SELECT @Precio = Precio, @ArtMoneda = Moneda FROM ListaPreciosSubUnidad WHERE Lista = @Lista AND Moneda = @MovMoneda AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Unidad = @Unidad
      ELSE
        SELECT @Precio = Precio, @ArtMoneda = Moneda FROM ListaPreciosDUnidad WHERE Lista = @Lista AND Moneda = @MovMoneda AND Articulo = @Articulo AND Unidad = @Unidad
    END 
    IF @Precio IS NULL AND @SubCuenta IS NOT NULL
      SELECT @Precio = Precio, @ArtMoneda = Moneda FROM ListaPreciosSub WHERE Lista = @Lista AND Moneda = @MovMoneda AND Articulo = @Articulo AND SubCuenta = @SubCuenta
  END

  IF @Precio IS NULL
  BEGIN
    IF SUBSTRING (@Lista, 1, 1) = '('
    BEGIN
      IF @Lista = '(Precio Lista)'  SELECT @ArtMoneda = MonedaPrecio, @Precio = PrecioLista  FROM Art WHERE Articulo = @Articulo ELSE
      IF @Lista = '(Precio 2)'      SELECT @ArtMoneda = MonedaPrecio, @Precio = Precio2      FROM Art WHERE Articulo = @Articulo ELSE
      IF @Lista = '(Precio 3)'      SELECT @ArtMoneda = MonedaPrecio, @Precio = Precio3      FROM Art WHERE Articulo = @Articulo ELSE
      IF @Lista = '(Precio 4)'      SELECT @ArtMoneda = MonedaPrecio, @Precio = Precio4      FROM Art WHERE Articulo = @Articulo ELSE
      IF @Lista = '(Precio 5)'      SELECT @ArtMoneda = MonedaPrecio, @Precio = Precio5      FROM Art WHERE Articulo = @Articulo ELSE
      IF @Lista = '(Precio 6)'      SELECT @ArtMoneda = MonedaPrecio, @Precio = Precio6      FROM Art WHERE Articulo = @Articulo ELSE
      IF @Lista = '(Precio 7)'      SELECT @ArtMoneda = MonedaPrecio, @Precio = Precio7      FROM Art WHERE Articulo = @Articulo ELSE
      IF @Lista = '(Precio 8)'      SELECT @ArtMoneda = MonedaPrecio, @Precio = Precio8      FROM Art WHERE Articulo = @Articulo ELSE
      IF @Lista = '(Precio 9)'      SELECT @ArtMoneda = MonedaPrecio, @Precio = Precio9      FROM Art WHERE Articulo = @Articulo ELSE
      IF @Lista = '(Precio 10)'     SELECT @ArtMoneda = MonedaPrecio, @Precio = Precio10     FROM Art WHERE Articulo = @Articulo ELSE
      IF @Lista = '(Precio Minimo)' SELECT @ArtMoneda = MonedaPrecio, @Precio = PrecioMinimo FROM Art WHERE Articulo = @Articulo ELSE
      IF @Lista = '(Incentivo)'     SELECT @ArtMoneda = MonedaPrecio, @Precio = Incentivo    FROM Art WHERE Articulo = @Articulo 
      ELSE
      BEGIN
        SELECT @ArtMoneda = MonedaCosto FROM Art WHERE Articulo = @Articulo
        IF @SubCuenta IS NULL
        BEGIN
          IF @Lista = '(Ultimo Costo)'      SELECT @Precio = UltimoCosto     FROM ArtCosto WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Articulo = @Articulo ELSE
          IF @Lista = '(Costo Promedio)'    SELECT @Precio = CostoPromedio   FROM ArtCosto WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Articulo = @Articulo ELSE
          IF @Lista = '(Costo Estandar)'    SELECT @Precio = CostoEstandar   FROM Art      WHERE Articulo = @Articulo ELSE
          IF @Lista = '(Costo Reposicion)'  SELECT @Precio = CostoReposicion FROM Art      WHERE Articulo = @Articulo ELSE
          IF @Lista IN ('(Costo Proveedor)', '(Ultimo Costo Prov)')
          BEGIN
            IF @SucursalEsp IS NULL
            BEGIN
              IF @Lista = '(Costo Proveedor)'   SELECT @Precio = CostoAutorizado FROM ArtProv  WHERE Articulo = @Articulo AND SubCuenta = '' AND Proveedor = @Proveedor ELSE
              IF @Lista = '(Ultimo Costo Prov)' SELECT @Precio = UltimoCosto     FROM ArtProv  WHERE Articulo = @Articulo AND SubCuenta = '' AND Proveedor = @Proveedor
            END ELSE
            BEGIN
              IF @Lista = '(Costo Proveedor)'   SELECT @Precio = CostoAutorizado FROM ArtProvSucursal  WHERE Articulo = @Articulo AND SubCuenta = '' AND Proveedor = @Proveedor AND Sucursal = @SucursalEsp ELSE
              IF @Lista = '(Ultimo Costo Prov)' SELECT @Precio = UltimoCosto     FROM ArtProvSucursal  WHERE Articulo = @Articulo AND SubCuenta = '' AND Proveedor = @Proveedor AND Sucursal = @SucursalEsp 
            END
          END
        END ELSE
        BEGIN
          IF @Lista = '(Ultimo Costo)'      SELECT @Precio = UltimoCosto     FROM ArtSubCosto WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Articulo = @Articulo AND SubCuenta = @SubCuenta ELSE
          IF @Lista = '(Costo Promedio)'    SELECT @Precio = CostoPromedio   FROM ArtSubCosto WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Articulo = @Articulo AND SubCuenta = @SubCuenta ELSE
          IF @Lista = '(Costo Estandar)'    SELECT @Precio = CostoEstandar   FROM ArtSub      WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta ELSE
          IF @Lista = '(Costo Reposicion)'  SELECT @Precio = CostoReposicion FROM ArtSub      WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta ELSE
          IF @Lista IN ('(Costo Proveedor)', '(Ultimo Costo Prov)')
          BEGIN
            IF @SucursalEsp IS NULL
            BEGIN
              IF @Lista = '(Costo Proveedor)'   SELECT @Precio = CostoAutorizado FROM ArtProv  WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta AND Proveedor = @Proveedor ELSE
              IF @Lista = '(Ultimo Costo Prov)' SELECT @Precio = UltimoCosto     FROM ArtProv  WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta AND Proveedor = @Proveedor
            END ELSE
            BEGIN
              IF @Lista = '(Costo Proveedor)'   SELECT @Precio = CostoAutorizado FROM ArtProvSucursal  WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta AND Proveedor = @Proveedor AND Sucursal = @SucursalEsp ELSE
              IF @Lista = '(Ultimo Costo Prov)' SELECT @Precio = UltimoCosto     FROM ArtProvSucursal  WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta AND Proveedor = @Proveedor AND Sucursal = @SucursalEsp 
            END
          END
        END
      END
    END ELSE
    BEGIN
      SELECT @ArtMoneda = MonedaPrecio, @Precio = PrecioLista  FROM Art WHERE Articulo = @Articulo
      IF @SubCuenta IS NULL
        SELECT @Precio = Precio, @ArtMoneda = Moneda FROM ListaPreciosD WHERE Lista = @Lista AND Moneda = @MovMoneda AND Articulo = @Articulo
      ELSE
        SELECT @Precio = Precio, @ArtMoneda = Moneda FROM ListaPreciosSub WHERE Lista = @Lista AND Moneda = @MovMoneda AND Articulo = @Articulo AND SubCuenta = @SubCuenta
      IF @@ROWCOUNT = 0
      BEGIN 
        SELECT @ArtMoneda = MonedaPrecio FROM Art WHERE Articulo = @Articulo
        IF @SubCuenta IS NULL
          SELECT @Precio = Precio FROM ListaPreciosD WHERE Lista = @Lista AND Moneda = @ArtMoneda AND Articulo = @Articulo
        ELSE
          SELECT @Precio = Precio FROM ListaPreciosSub WHERE Lista = @Lista AND Moneda = @ArtMoneda AND Articulo = @Articulo AND SubCuenta = @SubCuenta
      END
    END
  END
  IF @ArtMoneda <> @MovMoneda AND @ArtMoneda IS NOT NULL
    SELECT @Precio = @Precio * (SELECT ISNULL(TipoCambio, 1.0) FROM Mon WHERE Moneda = @ArtMoneda) / @MovTipoCambio

  IF @VerResultado = 1 SELECT "Importe" = @Precio
  RETURN
END
GO

-- select dbo.fnPCGet ('DEMO', 0, 'Pesos', 1, 'A1', NULL, '(Costo Reposicion)')
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[fnPCGet]'))
DROP FUNCTION [dbo].[fnPCGet]
GO
CREATE FUNCTION fnPCGet (@Empresa char(5), @Sucursal int, @MovMoneda char(10), @MovTipoCambio float, @Articulo char(20), @SubCuenta varchar(20), @Unidad varchar(50), @Lista varchar(20)) 
RETURNS money 
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @ArtMoneda		char(10),
    @ArtFactor		float,
    @ArtTipoCambio	float,
    @Ok			int,
    @Precio		money

  IF @MovTipoCambio IS NULL
    SELECT @MovTipoCambio = TipoCambio FROM Mon WHERE Moneda = @MovMoneda

  SELECT @Precio = NULL, @ArtMoneda = NULL, @Ok = NULL, @SubCuenta = NULLIF(RTRIM(NULLIF(@SubCuenta, '0')), ''), @Unidad = NULLIF(RTRIM(@Unidad), '')

  IF @Lista NOT IN ('(Ultimo Costo)', '(Costo Promedio)', '(Costo Estandar)', '(Costo Reposicion)', '(Costo Proveedor)', '(Ultimo Costo Prov)')
  BEGIN
    IF @Unidad IS NOT NULL
    BEGIN
      IF @SubCuenta IS NOT NULL
        SELECT @Precio = Precio, @ArtMoneda = Moneda FROM ListaPreciosSubUnidad WHERE Lista = @Lista AND Moneda = @MovMoneda AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Unidad = @Unidad
      ELSE
        SELECT @Precio = Precio, @ArtMoneda = Moneda FROM ListaPreciosDUnidad WHERE Lista = @Lista AND Moneda = @MovMoneda AND Articulo = @Articulo AND Unidad = @Unidad
    END 
    IF @Precio IS NULL AND @SubCuenta IS NOT NULL
      SELECT @Precio = Precio, @ArtMoneda = Moneda FROM ListaPreciosSub WHERE Lista = @Lista AND Moneda = @MovMoneda AND Articulo = @Articulo AND SubCuenta = @SubCuenta
  END

  IF @Precio IS NULL
  BEGIN
    IF SUBSTRING (@Lista, 1, 1) = '('
    BEGIN
      IF @Lista = '(Precio Lista)'  SELECT @ArtMoneda = MonedaPrecio, @Precio = PrecioLista  FROM Art WHERE Articulo = @Articulo ELSE
      IF @Lista = '(Precio 2)'      SELECT @ArtMoneda = MonedaPrecio, @Precio = Precio2      FROM Art WHERE Articulo = @Articulo ELSE
      IF @Lista = '(Precio 3)'      SELECT @ArtMoneda = MonedaPrecio, @Precio = Precio3      FROM Art WHERE Articulo = @Articulo ELSE
      IF @Lista = '(Precio 4)'      SELECT @ArtMoneda = MonedaPrecio, @Precio = Precio4      FROM Art WHERE Articulo = @Articulo ELSE
      IF @Lista = '(Precio 5)'      SELECT @ArtMoneda = MonedaPrecio, @Precio = Precio5      FROM Art WHERE Articulo = @Articulo ELSE
      IF @Lista = '(Precio 6)'      SELECT @ArtMoneda = MonedaPrecio, @Precio = Precio6      FROM Art WHERE Articulo = @Articulo ELSE
      IF @Lista = '(Precio 7)'      SELECT @ArtMoneda = MonedaPrecio, @Precio = Precio7      FROM Art WHERE Articulo = @Articulo ELSE
      IF @Lista = '(Precio 8)'      SELECT @ArtMoneda = MonedaPrecio, @Precio = Precio8      FROM Art WHERE Articulo = @Articulo ELSE
      IF @Lista = '(Precio 9)'      SELECT @ArtMoneda = MonedaPrecio, @Precio = Precio9      FROM Art WHERE Articulo = @Articulo ELSE
      IF @Lista = '(Precio 10)'     SELECT @ArtMoneda = MonedaPrecio, @Precio = Precio10     FROM Art WHERE Articulo = @Articulo ELSE
      IF @Lista = '(Precio Minimo)' SELECT @ArtMoneda = MonedaPrecio, @Precio = PrecioMinimo FROM Art WHERE Articulo = @Articulo ELSE
      IF @Lista = '(Incentivo)'     SELECT @ArtMoneda = MonedaPrecio, @Precio = Incentivo    FROM Art WHERE Articulo = @Articulo 
      ELSE
      BEGIN
        SELECT @ArtMoneda = MonedaCosto FROM Art WHERE Articulo = @Articulo
        IF @SubCuenta IS NULL
        BEGIN
          IF @Lista = '(Ultimo Costo)'     SELECT @Precio = UltimoCosto      FROM ArtCosto WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Articulo = @Articulo ELSE
          IF @Lista = '(Costo Promedio)'   SELECT @Precio = CostoPromedio    FROM ArtCosto WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Articulo = @Articulo ELSE
          IF @Lista = '(Costo Estandar)'   SELECT @Precio = CostoEstandar    FROM Art      WHERE Articulo = @Articulo ELSE
          IF @Lista = '(Costo Reposicion)' SELECT @Precio = CostoReposicion  FROM Art      WHERE Articulo = @Articulo /*ELSE
          IF @Lista = '(Costo Proveedor)'   SELECT @Precio = CostoAutorizado FROM ArtProv  WHERE Articulo = @Articulo AND SubCuenta = '' AND Proveedor = @Proveedor ELSE
          IF @Lista = '(Ultimo Costo Prov)' SELECT @Precio = UltimoCosto     FROM ArtProv  WHERE Articulo = @Articulo AND SubCuenta = '' AND Proveedor = @Proveedor*/
        END ELSE
        BEGIN
          IF @Lista = '(Ultimo Costo)'      SELECT @Precio = UltimoCosto     FROM ArtSubCosto WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Articulo = @Articulo AND SubCuenta = @SubCuenta ELSE
          IF @Lista = '(Costo Promedio)'    SELECT @Precio = CostoPromedio   FROM ArtSubCosto WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Articulo = @Articulo AND SubCuenta = @SubCuenta ELSE
          IF @Lista = '(Costo Estandar)'    SELECT @Precio = CostoEstandar   FROM ArtSub      WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta ELSE
          IF @Lista = '(Costo Reposicion)'  SELECT @Precio = CostoReposicion FROM ArtSub      WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta /*ELSE
          IF @Lista = '(Costo Proveedor)'   SELECT @Precio = CostoAutorizado FROM ArtProv     WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta AND Proveedor = @Proveedor ELSE
          IF @Lista = '(Ultimo Costo Prov)' SELECT @Precio = UltimoCosto     FROM ArtProv     WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta AND Proveedor = @Proveedor*/
        END
      END
    END ELSE
    BEGIN
      SELECT @ArtMoneda = MonedaPrecio, @Precio = PrecioLista  FROM Art WHERE Articulo = @Articulo
      IF @SubCuenta IS NULL
        SELECT @Precio = Precio, @ArtMoneda = Moneda FROM ListaPreciosD WHERE Lista = @Lista AND Moneda = @MovMoneda AND Articulo = @Articulo
      ELSE
        SELECT @Precio = Precio, @ArtMoneda = Moneda FROM ListaPreciosSub WHERE Lista = @Lista AND Moneda = @MovMoneda AND Articulo = @Articulo AND SubCuenta = @SubCuenta
      IF @@ROWCOUNT = 0
      BEGIN 
        SELECT @ArtMoneda = MonedaPrecio FROM Art WHERE Articulo = @Articulo
        IF @SubCuenta IS NULL
          SELECT @Precio = Precio FROM ListaPreciosD WHERE Lista = @Lista AND Moneda = @ArtMoneda AND Articulo = @Articulo
        ELSE
          SELECT @Precio = Precio FROM ListaPreciosSub WHERE Lista = @Lista AND Moneda = @ArtMoneda AND Articulo = @Articulo AND SubCuenta = @SubCuenta
      END
    END
  END

  IF @ArtMoneda <> @MovMoneda AND @ArtMoneda IS NOT NULL
    SELECT @Precio = @Precio * (SELECT ISNULL(TipoCambio, 1.0) FROM Mon WHERE Moneda = @ArtMoneda) / @MovTipoCambio

  RETURN (@Precio)
END
GO

-- select dbo.fnPrecioSucursal ('DEMO', 0, 'Pesos', 1, 'A1', NULL)
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[fnPrecioSucursal]'))
DROP FUNCTION [dbo].[fnPrecioSucursal]
GO
CREATE FUNCTION fnPrecioSucursal (@Empresa char(5), @Sucursal int, @MovMoneda char(10), @MovTipoCambio float, @Articulo char(20), @SubCuenta varchar(20), @Unidad varchar(50)) 
RETURNS money 
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Lista		varchar(20)

  SELECT @Lista = ListaPreciosEsp FROM Sucursal WHERE Sucursal = @Sucursal
  RETURN (SELECT dbo.fnPCGet(@Empresa, @Sucursal, @MovMoneda, @MovTipoCambio, @Articulo, @SubCuenta, @Unidad, @Lista))
END
GO

-- borrar la funcion para que no falle, despues de crea.
/**************** fnPCGet ****************/
--IF exists (SELECT name FROM sysobjects WHERE name = 'fnPCGet') DROP FUNCTION dbo.fnPCGet
--GO
--IF exists (SELECT name FROM sysobjects WHERE name = 'fnPrecioSucursal') DROP FUNCTION dbo.fnPrecioSucursal
--GO
/**************** fnPCArtCostoBase ****************/
IF exists (SELECT name FROM sysobjects WHERE name = 'fnPCArtCostoBase') DROP FUNCTION dbo.fnPCArtCostoBase
GO
CREATE FUNCTION fnPCArtCostoBase (@ID int, @Articulo varchar(20), @SubCuenta varchar(50), @Unidad varchar(50), @Sucursal int)
RETURNS money
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @EmpresaBase	varchar(50),
    @Empresa		varchar(5),
    @SucursalBase	varchar(50),
    @Moneda		varchar(10),
    @TipoCambio		float,
    @MovSucursal	int

  SELECT @Empresa = pc.Empresa, @Moneda = pc.Moneda, @TipoCambio = pc.TipoCambio, @EmpresaBase = gral.CostoBase, @MovSucursal = ISNULL(SucursalDestino, Sucursal)
    FROM PC
    JOIN EmpresaGral gral ON gral.Empresa = pc.Empresa
   WHERE pc.ID = @ID

  SELECT @Sucursal = ISNULL(@Sucursal, @MovSucursal)
  SELECT @SucursalBase = NULLIF(RTRIM(CostoBase), '')
    FROM Sucursal
   WHERE Sucursal = @Sucursal

  RETURN(SELECT dbo.fnPCGet(@Empresa, ISNULL(@Sucursal, 0), @Moneda, @TipoCambio, @Articulo, NULLIF(RTRIM(@SubCuenta),''), NULLIF(RTRIM(@Unidad),''), ISNULL(@SucursalBase, @EmpresaBase)))
END
GO


EXEC spALTER_TABLE 'PCD', 'CostoBase', 'AS dbo.fnPCArtCostoBase(ID, Articulo, SubCuenta, Unidad, SucursalEsp)'
go

-- spListaPrecios_H1 'Costo Proveedor', 'Pesos'
-- select DescAlterno, * from ListaPreciosD_H1
/**************** spListaPrecios_H1 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spListaPrecios_H1') and type = 'P') drop procedure dbo.spListaPrecios_H1
GO
CREATE PROCEDURE spListaPrecios_H1
    			@Lista		varchar(20),
    			@Moneda		varchar(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @U1		bit,
    @U2		bit,
    @U3		bit,
    @U4		bit,
    @U5		bit,
    @U6		bit,
    @U7		bit,
    @U8		bit,
    @U9		bit,
    @U10	bit,
    @U11	bit,
    @U12	bit,
    @U13	bit,
    @U14	bit,
    @U15	bit,
    @Desc1	float,
    @Desc2	float,
    @Desc3	float,
    @Desc4	float,
    @Desc5	float,
    @Desc6	float,
    @Desc7	float,
    @Desc8	float,
    @Desc9	float,
    @Desc10	float,
    @Desc11	float,
    @Desc12	float,
    @Desc13	float,
    @Desc14	float,
    @Desc15	float

  SELECT @U1  = Desc1,  @U2  = Desc2,  @U3  = Desc3,  @U4  = Desc4,  @U5  = Desc5, 
	 @U6  = Desc6,  @U7  = Desc7,  @U8  = Desc8,  @U9  = Desc9,  @U10 = Desc10, 
	 @U11 = Desc11, @U12 = Desc12, @U13 = Desc13, @U14 = Desc14, @U15 = Desc15
    FROM ListaPrecios_H1
   WHERE Lista = @Lista AND Moneda = @Moneda

  DECLARE crListaPreciosD_H1 CURSOR LOCAL FOR
   SELECT Desc1, Desc2, Desc3, Desc4, Desc5, Desc6, Desc7, Desc8, Desc9, Desc10, Desc11, Desc12, Desc13, Desc14, Desc15
     FROM ListaPreciosD_H1
    WHERE Lista = @Lista AND Moneda = @Moneda

  OPEN crListaPreciosD_H1
  FETCH NEXT FROM crListaPreciosD_H1 INTO @Desc1, @Desc2, @Desc3, @Desc4, @Desc5, @Desc6, @Desc7, @Desc8, @Desc9, @Desc10, @Desc11, @Desc12, @Desc13, @Desc14, @Desc15 
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      UPDATE ListaPreciosD_H1 
         SET DescAlterno = dbo.fnDescCascada_H1(@U1, @U2, @U3, @U4, @U5, @U6, @U7, @U8, @U9, @U10, @U11, @U12, @U13, @U14, @U15, @Desc1, @Desc2, @Desc3, @Desc4, @Desc5, @Desc6, @Desc7, @Desc8, @Desc9, @Desc10, @Desc11, @Desc12, @Desc13, @Desc14, @Desc15)
       WHERE CURRENT OF crListaPreciosD_H1
    END
    FETCH NEXT FROM crListaPreciosD_H1 INTO @Desc1, @Desc2, @Desc3, @Desc4, @Desc5, @Desc6, @Desc7, @Desc8, @Desc9, @Desc10, @Desc11, @Desc12, @Desc13, @Desc14, @Desc15 
  END  -- While	
  CLOSE crListaPreciosD_H1
  DEALLOCATE crListaPreciosD_H1

  RETURN
END
GO

/**************** spGastos_H1 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGastos_H1') and type = 'P') drop procedure dbo.spGastos_H1
GO
CREATE PROCEDURE spGastos_H1
			@Empresa	varchar(5),
    			@Lista		varchar(20),
    			@Moneda		varchar(10),
			@Region		varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Articulo	varchar(20), 
    @SubCuenta	varchar(50), 
    @Unidad	varchar(50), 
    @Minimo	float,
    @Promedio	float,
    @Maximo	float

  DECLARE crListaPreciosD_H1 CURSOR LOCAL FOR
   SELECT Articulo, SubCuenta, Unidad
     FROM ListaPreciosD_H1
    WHERE Lista = @Lista AND Moneda = @Moneda

  OPEN crListaPreciosD_H1
  FETCH NEXT FROM crListaPreciosD_H1 INTO @Articulo, @SubCuenta, @Unidad
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Minimo = Minimo, @Promedio = Promedio, @Maximo = Maximo
        FROM dbo.fnArtOtrosGastosRegion(@Empresa, @Region, @Articulo, @SubCuenta, @Unidad)

      UPDATE ListaPreciosD_H1 
         SET GastosMinimo = @Minimo, GastosPromedio = @Promedio, GastosMaximo = @Maximo
       WHERE CURRENT OF crListaPreciosD_H1
    END
    FETCH NEXT FROM crListaPreciosD_H1 INTO @Articulo, @SubCuenta, @Unidad
  END  -- While	
  CLOSE crListaPreciosD_H1
  DEALLOCATE crListaPreciosD_H1

  RETURN
END
GO


-- spAplicarPrecios_H1 'DEMO', 0, 'Costo Proveedor', 'Pesos'
/**************** spAplicarPrecios_H1 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAplicarPrecios_H1') and type = 'P') drop procedure dbo.spAplicarPrecios_H1
GO
CREATE PROCEDURE spAplicarPrecios_H1
			@Empresa	varchar(5),
			@Sucursal	int,
    			@Lista		varchar(20),
    			@Moneda		varchar(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Articulo		varchar(20), 
    @SubCuenta		varchar(50), 
    @Unidad		varchar(50),
    @PrecioLista	float,
    @Desc1		float,
    @Desc2		float,
    @Gastos		float,
    @Precio1		float,
    @Precio2		float,
    @ListaPrecio1	varchar(20),
    @ListaPrecio2	varchar(20),
    @TipoCambio		float,
    @Conteo		int

   SELECT @Conteo = 0
   SELECT @TipoCambio = TipoCambio
     FROM Mon
    WHERE Moneda = @Moneda

   SELECT @ListaPrecio1 = NULLIF(RTRIM(ListaPrecio1), ''), @ListaPrecio2 = NULLIF(RTRIM(ListaPrecio2), '')
     FROM ListaPrecios_H1
    WHERE Lista = @Lista AND Moneda = @Moneda

  DECLARE crListaPreciosD_H1 CURSOR LOCAL FOR
   SELECT Articulo, SubCuenta, Unidad, PrecioLista, 
          dbo.fnDescCascada_H1(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, Desc1, Desc2, Desc3, Desc4, Desc5, Desc6, Desc7, Desc8, Desc9, Desc10, Desc11, Desc12, Desc13, Desc14, Desc15),
          DescAlterno, Gastos
     FROM ListaPreciosD_H1
    WHERE Lista = @Lista AND Moneda = @Moneda

  OPEN crListaPreciosD_H1
  FETCH NEXT FROM crListaPreciosD_H1 INTO @Articulo, @SubCuenta, @Unidad, @PrecioLista, @Desc1, @Desc2, @Gastos
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Precio1 = dbo.fnDisminuyePorcentaje(@PrecioLista, @Desc1),
             @Precio2 = dbo.fnAumentaPorcentaje(dbo.fnDisminuyePorcentaje(@PrecioLista, @Desc2), @Gastos)

      IF @ListaPrecio1 IS NOT NULL   
      BEGIN
        EXEC spPCSet @Sucursal, @Empresa, @Articulo, @SubCuenta, @Unidad, @Moneda, @TipoCambio, @ListaPrecio1, @Precio1, NULL
        SELECT @Conteo = @Conteo + 1
      END
      IF @ListaPrecio2 IS NOT NULL   
      BEGIN
        EXEC spPCSet @Sucursal, @Empresa, @Articulo, @SubCuenta, @Unidad, @Moneda, @TipoCambio, @ListaPrecio2, @Precio2, NULL
        SELECT @Conteo = @Conteo + 1
      END
    END
    FETCH NEXT FROM crListaPreciosD_H1 INTO @Articulo, @SubCuenta, @Unidad, @PrecioLista, @Desc1, @Desc2, @Gastos
  END  -- While	
  CLOSE crListaPreciosD_H1
  DEALLOCATE crListaPreciosD_H1

  SELECT CONVERT(varchar, @Conteo)+' Precios Modificados'
  RETURN
END
GO

/**************** spPC_H2 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPC_H2') and type = 'P') drop procedure dbo.spPC_H2
GO
CREATE PROCEDURE spPC_H2
                    @Estacion	int,
    		    @ID		int,
		    @Accion	varchar(20)	-- SUGERIR, ACEPTAR
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ahora		datetime,
    @Renglon		float,
    @Articulo		varchar(20), 
    @SubCuenta		varchar(50), 
    @Unidad		varchar(50), 
    @ListaModificar	varchar(20), 
    @CostoBase		float,
    @ArtImpuesto1	float,
    @ArtImpuesto2	float,
    @Nuevo		float,
    @Anterior		float

  SELECT @Accion = UPPER(@Accion), @Ahora = GETDATE()

  IF @Accion = 'SUGERIR'
  BEGIN
    IF NOT EXISTS(SELECT * FROM PC_H2 WHERE Estacion = @Estacion AND ID = @ID)
      DELETE PC_H2 WHERE Estacion = @Estacion
  
    DECLARE crPCD CURSOR LOCAL FOR
     SELECT Renglon, Articulo, SubCuenta, Unidad, ListaModificar, CostoBase, Anterior
       FROM PCD
      WHERE ID = @ID
    OPEN crPCD
    FETCH NEXT FROM crPCD INTO @Renglon, @Articulo, @SubCuenta, @Unidad, @ListaModificar, @CostoBase, @Anterior
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @ArtImpuesto1 = Impuesto1, @ArtImpuesto2 = Impuesto2
          FROM Art
         WHERE Articulo = @Articulo

        UPDATE PC_H2
           SET Articulo = @Articulo, SubCuenta = @SubCuenta, Unidad = @Unidad, ListaModificar = @ListaModificar, CostoBase = @CostoBase, Impuesto1 = @ArtImpuesto1, Impuesto2 = @ArtImpuesto2, Anterior = @Anterior, UltimoCambio = @Ahora
         WHERE Estacion = @Estacion AND ID = @ID AND Renglon = @Renglon
        IF @@ROWCOUNT = 0
          INSERT PC_H2 ( 
                  Estacion,  ID,  Renglon,  Articulo,  SubCuenta,  Unidad,  ListaModificar,  Anterior,  Impuesto1,     Impuesto2,     CostoBase,  UltimoCambio)
          VALUES (@Estacion, @ID, @Renglon, @Articulo, @SubCuenta, @Unidad, @ListaModificar, @Anterior, @ArtImpuesto1, @ArtImpuesto2, @CostoBase, @Ahora)
      END
      FETCH NEXT FROM crPCD INTO @Renglon, @Articulo, @SubCuenta, @Unidad, @ListaModificar, @CostoBase, @Anterior
    END  -- While	
    CLOSE crPCD
    DEALLOCATE crPCD
    DELETE PC_H2 WHERE Estacion = @Estacion AND ID = @ID AND UltimoCambio <> @Ahora
  END ELSE
  IF @Accion = 'ACEPTAR'
  BEGIN
    DECLARE crPC_H2 CURSOR LOCAL FOR
     SELECT Renglon, Nuevo
       FROM PC_H2
      WHERE Estacion = @Estacion AND ID = @ID
    OPEN crPC_H2
    FETCH NEXT FROM crPC_H2 INTO @Renglon, @Nuevo
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        UPDATE PCD 
           SET Nuevo = @Nuevo
         WHERE ID = @ID AND Renglon = @Renglon
      END
      FETCH NEXT FROM crPC_H2 INTO @Renglon, @Nuevo
    END  -- While	
    CLOSE crPC_H2
    DEALLOCATE crPC_H2
  END
  RETURN
END
GO


/**************** spPCVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPCVerificar') and type = 'P') drop procedure dbo.spPCVerificar
GO
CREATE PROCEDURE spPCVerificar
    		    @ID               		int,
		    @Accion			char(20),
    		    @Empresa          		char(5),
		    @Usuario			char(10),
    		    @Modulo	      		char(5),
    		    @Mov              		char(20),
	            @MovID			varchar(20),
    		    @MovTipo	      		char(20),
		    @MovMoneda			char(10),
		    @MovTipoCambio		float,
		    @FechaEmision		datetime,
		    @Estatus			char(15),

		    @ListaModificar		varchar(20),
		    @Proveedor			varchar(10), 	
		    @FechaInicio		datetime,
		    @FechaTermino		datetime,
		    @Hoy			datetime,

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,

		    @CfgListaModificarDetalle	bit,
		    @CfgContX			bit,
		    @CfgContXGenerar		char(20),
		    @GenerarPoliza		bit,

    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN
    
  IF @Accion = 'CANCELAR'
  BEGIN
    -- Checar que se haya capturado el movimiento en este modulo
    IF @Conexion = 0 
      IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo)
	SELECT @Ok = 60070
  END ELSE 
  BEGIN
    IF NOT EXISTS(SELECT * FROM PCD WHERE ID = @ID) AND 
       NOT EXISTS(SELECT * FROM PCBoletin WHERE ID = @ID) SELECT @Ok = 60010
    IF @ListaModificar IS NULL AND @MovTipo <> 'PC.B' SELECT @Ok = 52010
    IF @FechaInicio IS NOT NULL AND @FechaTermino IS NOT NULL AND @FechaTermino < @FechaInicio SELECT @Ok = 60170

    IF @Ok IS NULL AND @CfgListaModificarDetalle = 1 AND @MovTipo <> 'PC.B' 
      IF EXISTS(SELECT * FROM PCD WHERE ID = @ID AND NULLIF(RTRIM(ListaModificar), '') IS NULL)
        SELECT @Ok = 52010, @OkRef = Articulo FROM PCD WHERE ID = @ID AND NULLIF(RTRIM(ListaModificar), '') IS NULL
  END
 
  IF @Ok IS NULL
    EXEC xpPCVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                       @FechaEmision, @Estatus, 
                       @ListaModificar, @Proveedor, @FechaInicio, @FechaTermino, @Hoy,
   		       @Conexion, @SincroFinal, @Sucursal, 
		       @CfgListaModificarDetalle, @CfgContX, @CfgContXGenerar, @GenerarPoliza,
		       @Ok OUTPUT, @OkRef OUTPUT
  RETURN
END
GO

/**************** spPCSet ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPCSet') and type = 'P') drop procedure dbo.spPCSet
GO             
CREATE PROCEDURE spPCSet
			@Sucursal	int,
			@Empresa	char(5),
			@Articulo	char(20),
			@SubCuenta	varchar(50),
			@Unidad		varchar(50),
			@MovMoneda	char(10),
			@MovTipoCambio	float,
			@Lista		varchar(20),
			@Precio		money,
			@EstatusNuevo	varchar(15),
			@Proveedor	varchar(10) = NULL,
                        @SucursalEsp	int = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ArtMoneda			char(10),
    @ArtFactor			float,
    @ArtTipoCambio		float,
    @ArtPrecio			money,
    @ListaMoneda		char(10),
    @ListaFactor		float,
    @ListaTipoCambio	float,
    @ListaPrecio		money,
    @Ok					int,
    @PrecioNivelUnidad	bit

SELECT @PrecioNivelUnidad= PrecioNivelUnidad FROM EmpresaCfg2  WHERE Empresa=@Empresa
  SELECT @SubCuenta = NULLIF(RTRIM(NULLIF(@SubCuenta, '0')), ''), @Unidad = NULLIF(RTRIM(@Unidad), '')
  IF NOT EXISTS(SELECT * FROM ListaPrecios WHERE Lista = @Lista)
    INSERT ListaPrecios (Lista, Moneda) VALUES (@Lista, @MovMoneda)

  SELECT @ArtMoneda = CASE WHEN @Lista IN ('(Ultimo Costo)', '(Costo Promedio)', '(Costo Estandar)', '(Costo Reposicion)', '(Costo Proveedor)', '(Ultimo Costo Prov)') THEN MonedaCosto ELSE MonedaPrecio END
    FROM Art
   WHERE Articulo = @Articulo

  EXEC spMoneda NULL, @MovMoneda, @MovTipoCambio, @ArtMoneda, @ArtFactor OUTPUT, @ArtTipoCambio OUTPUT, @Ok OUTPUT
  SELECT @ArtPrecio = @Precio / @ArtFactor

  IF SUBSTRING (@Lista, 1, 1) = '(' AND @SubCuenta IS NULL
  BEGIN
    IF @Lista = '(Precio Lista)'     UPDATE Art SET UltimoCambio = GETDATE(), PrecioLista     = @ArtPrecio, EstatusPrecio = CASE WHEN @EstatusNuevo IS NULL THEN EstatusPrecio ELSE @EstatusNuevo END, TieneMovimientos = 1 WHERE Articulo = @Articulo ELSE
    IF @Lista = '(Precio 2)'         UPDATE Art SET UltimoCambio = GETDATE(), Precio2         = @ArtPrecio WHERE Articulo = @Articulo ELSE
    IF @Lista = '(Precio 3)'         UPDATE Art SET UltimoCambio = GETDATE(), Precio3         = @ArtPrecio WHERE Articulo = @Articulo ELSE
    IF @Lista = '(Precio 4)'         UPDATE Art SET UltimoCambio = GETDATE(), Precio4         = @ArtPrecio WHERE Articulo = @Articulo ELSE
    IF @Lista = '(Precio 5)'         UPDATE Art SET UltimoCambio = GETDATE(), Precio5         = @ArtPrecio WHERE Articulo = @Articulo ELSE
    IF @Lista = '(Precio 6)'         UPDATE Art SET UltimoCambio = GETDATE(), Precio6         = @ArtPrecio WHERE Articulo = @Articulo ELSE
    IF @Lista = '(Precio 7)'         UPDATE Art SET UltimoCambio = GETDATE(), Precio7         = @ArtPrecio WHERE Articulo = @Articulo ELSE
    IF @Lista = '(Precio 8)'         UPDATE Art SET UltimoCambio = GETDATE(), Precio8         = @ArtPrecio WHERE Articulo = @Articulo ELSE
    IF @Lista = '(Precio 9)'         UPDATE Art SET UltimoCambio = GETDATE(), Precio9         = @ArtPrecio WHERE Articulo = @Articulo ELSE
    IF @Lista = '(Precio 10)'        UPDATE Art SET UltimoCambio = GETDATE(), Precio10        = @ArtPrecio WHERE Articulo = @Articulo ELSE
    IF @Lista = '(Precio Minimo)'    UPDATE Art SET UltimoCambio = GETDATE(), PrecioMinimo    = @ArtPrecio WHERE Articulo = @Articulo ELSE
    IF @Lista = '(Incentivo)'        UPDATE Art SET UltimoCambio = GETDATE(), Incentivo       = @ArtPrecio WHERE Articulo = @Articulo 
  END

  IF @Lista IN ('(Costo Estandar)', '(Costo Reposicion)', '(Ultimo Costo)', '(Costo Promedio)', '(Costo Proveedor)', '(Ultimo Costo Prov)')
  BEGIN
    IF @SubCuenta IS NULL
    BEGIN
      IF @Lista = '(Costo Estandar)'   UPDATE Art SET UltimoCambio = GETDATE(), CostoEstandar   = @ArtPrecio, EstatusCosto = CASE WHEN @EstatusNuevo IS NULL THEN EstatusCosto ELSE @EstatusNuevo END, TieneMovimientos = 1 WHERE Articulo = @Articulo ELSE
      IF @Lista = '(Costo Reposicion)' UPDATE Art SET UltimoCambio = GETDATE(), CostoReposicion = @ArtPrecio, EstatusCosto = CASE WHEN @EstatusNuevo IS NULL THEN EstatusCosto ELSE @EstatusNuevo END, TieneMovimientos = 1 WHERE Articulo = @Articulo 
      ELSE 
      BEGIN
        IF @Lista = '(Ultimo Costo)'
        BEGIN
          UPDATE ArtCosto SET UltimoCosto = @ArtPrecio WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Articulo = @Articulo
          IF @@ROWCOUNT = 0 INSERT ArtCosto (Sucursal, Empresa, Articulo, UltimoCosto) VALUES (@Sucursal, @Empresa, @Articulo, @ArtPrecio)
        END ELSE
        IF @Lista = '(Costo Promedio)'   
        BEGIN
          UPDATE ArtCosto SET CostoPromedio = @ArtPrecio WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Articulo = @Articulo
          IF @@ROWCOUNT = 0 INSERT ArtCosto (Sucursal, Empresa, Articulo, CostoPromedio) VALUES (@Sucursal, @Empresa, @Articulo, @ArtPrecio)
        END ELSE
        IF @Lista IN ('(Costo Proveedor)', '(Ultimo Costo Prov)')
        BEGIN
          IF @SucursalEsp IS NULL
          BEGIN 
            IF @Lista = '(Costo Proveedor)' AND @Proveedor IS NOT NULL   
            BEGIN
              UPDATE ArtProv SET CostoAutorizado = @ArtPrecio WHERE Articulo = @Articulo AND SubCuenta = '' AND Proveedor = @Proveedor
              IF @@ROWCOUNT = 0 INSERT ArtProv (Articulo, SubCuenta, Proveedor, CostoAutorizado) VALUES (@Articulo, '', @Proveedor, @ArtPrecio)
            END ELSE
            IF @Lista = '(Ultimo Costo Prov)' AND @Proveedor IS NOT NULL   
            BEGIN
              UPDATE ArtProv SET UltimoCosto = @ArtPrecio WHERE Articulo = @Articulo AND SubCuenta = '' AND Proveedor = @Proveedor
              IF @@ROWCOUNT = 0 INSERT ArtProv (Articulo, SubCuenta, Proveedor, UltimoCosto) VALUES (@Articulo, '', @Proveedor, @ArtPrecio)
            END
          END ELSE
          BEGIN
            IF @Lista = '(Costo Proveedor)' AND @Proveedor IS NOT NULL   
            BEGIN
              UPDATE ArtProvSucursal SET CostoAutorizado = @ArtPrecio WHERE Articulo = @Articulo AND SubCuenta = '' AND Proveedor = @Proveedor AND Sucursal = @SucursalEsp
              IF @@ROWCOUNT = 0 INSERT ArtProvSucursal (Articulo, SubCuenta, Proveedor, Sucursal, CostoAutorizado) VALUES (@Articulo, '', @Proveedor, @SucursalEsp, @ArtPrecio)
            END ELSE
            IF @Lista = '(Ultimo Costo Prov)' AND @Proveedor IS NOT NULL   
            BEGIN
              UPDATE ArtProvSucursal SET UltimoCosto = @ArtPrecio WHERE Articulo = @Articulo AND SubCuenta = '' AND Proveedor = @Proveedor AND Sucursal = @SucursalEsp
              IF @@ROWCOUNT = 0 INSERT ArtProvSucursal (Articulo, SubCuenta, Proveedor, Sucursal, UltimoCosto) VALUES (@Articulo, '', @Proveedor, @SucursalEsp, @ArtPrecio)
            END
          END
        END
      END
    END ELSE
    BEGIN
      IF @Lista = '(Costo Estandar)'   UPDATE ArtSub SET CostoEstandar   = @ArtPrecio WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta ELSE
      IF @Lista = '(Costo Reposicion)' UPDATE ArtSub SET CostoReposicion = @ArtPrecio WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta 
      ELSE 
      BEGIN
        IF @Lista = '(Ultimo Costo)'
        BEGIN
          UPDATE ArtSubCosto SET UltimoCosto = @ArtPrecio WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Articulo = @Articulo AND SubCuenta = @SubCuenta 
          IF @@ROWCOUNT = 0 INSERT ArtSubCosto (Sucursal, Empresa, Articulo, SubCuenta, UltimoCosto) VALUES (@Sucursal, @Empresa, @Articulo, @SubCuenta, @ArtPrecio)
        END ELSE
        IF @Lista = '(Costo Promedio)'   
        BEGIN
          UPDATE ArtSubCosto SET CostoPromedio = @ArtPrecio WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Articulo = @Articulo AND SubCuenta = @SubCuenta 
          IF @@ROWCOUNT = 0 INSERT ArtSubCosto (Sucursal, Empresa, Articulo, SubCuenta, CostoPromedio) VALUES (@Sucursal, @Empresa, @Articulo, @SubCuenta, @ArtPrecio)
        END ELSE
        IF @Lista IN ('(Costo Proveedor)', '(Ultimo Costo Prov)')
        BEGIN
          IF @SucursalEsp IS NULL
          BEGIN 
            IF @Lista = '(Costo Proveedor)' AND @Proveedor IS NOT NULL   
            BEGIN
              UPDATE ArtProv SET CostoAutorizado = @ArtPrecio WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta AND Proveedor = @Proveedor
              IF @@ROWCOUNT = 0 INSERT ArtProv (Articulo, SubCuenta, Proveedor, CostoAutorizado) VALUES (@Articulo, @SubCuenta, @Proveedor, @ArtPrecio)
            END ELSE
            IF @Lista = '(Ultimo Costo Prov)' AND @Proveedor IS NOT NULL   
            BEGIN
              UPDATE ArtProv SET UltimoCosto = @ArtPrecio WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta AND Proveedor = @Proveedor
              IF @@ROWCOUNT = 0 INSERT ArtProv (Articulo, SubCuenta, Proveedor, UltimoCosto) VALUES (@Articulo, @SubCuenta, @Proveedor, @ArtPrecio)
            END
          END ELSE
          BEGIN
            IF @Lista = '(Costo Proveedor)' AND @Proveedor IS NOT NULL   
            BEGIN
              UPDATE ArtProvSucursal SET CostoAutorizado = @ArtPrecio WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta AND Proveedor = @Proveedor AND Sucursal = @SucursalEsp
              IF @@ROWCOUNT = 0 INSERT ArtProvSucursal (Articulo, SubCuenta, Proveedor, Sucursal, CostoAutorizado) VALUES (@Articulo, @SubCuenta, @Proveedor, @SucursalEsp, @ArtPrecio)
            END ELSE
            IF @Lista = '(Ultimo Costo Prov)' AND @Proveedor IS NOT NULL   
            BEGIN
              UPDATE ArtProvSucursal SET UltimoCosto = @ArtPrecio WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta AND Proveedor = @Proveedor AND Sucursal = @SucursalEsp
              IF @@ROWCOUNT = 0 INSERT ArtProvSucursal (Articulo, SubCuenta, Proveedor, Sucursal, UltimoCosto) VALUES (@Articulo, @SubCuenta, @Proveedor, @SucursalEsp, @ArtPrecio)
            END
          END
        END
      END
    END
  END

  DECLARE crListaPrecios CURSOR
   FOR SELECT Moneda
         FROM ListaPrecios
        WHERE Lista = @Lista

  OPEN crListaPrecios
  FETCH NEXT FROM crListaPrecios INTO @ListaMoneda
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spMoneda NULL, @MovMoneda, @MovTipoCambio, @ListaMoneda, @ListaFactor OUTPUT, @ListaTipoCambio OUTPUT, @Ok OUTPUT
      SELECT @ListaPrecio = @Precio / @ListaFactor

       IF @Unidad IS NULL OR @PrecioNivelUnidad=0
      BEGIN
        IF @SubCuenta IS NULL
        BEGIN
          UPDATE ListaPreciosD SET Precio = @ListaPrecio WHERE Lista = @Lista AND Moneda = @ListaMoneda AND Articulo = @Articulo
          IF @@ROWCOUNT = 0
            INSERT ListaPreciosD (Lista, Moneda, Articulo, Precio) VALUES (@Lista, @ListaMoneda, @Articulo, @ListaPrecio)
        END ELSE
        BEGIN
          UPDATE ListaPreciosSub SET Precio = @ListaPrecio WHERE Lista = @Lista AND Moneda = @ListaMoneda AND Articulo = @Articulo AND SubCuenta = @SubCuenta
          IF @@ROWCOUNT = 0
            INSERT ListaPreciosSub (Lista, Moneda, Articulo, SubCuenta, Precio) VALUES (@Lista, @ListaMoneda, @Articulo, @SubCuenta, @ListaPrecio)
        END
      END ELSE
      BEGIN
      
        IF @SubCuenta IS NULL
        BEGIN
           UPDATE ListaPreciosDUnidad SET Precio = @ListaPrecio WHERE Lista = @Lista AND Moneda = @ListaMoneda AND Articulo = @Articulo AND Unidad = @Unidad
          IF @@ROWCOUNT = 0
          INSERT ListaPreciosDUnidad (Lista, Moneda, Articulo, Unidad, Precio) VALUES (@Lista, @ListaMoneda, @Articulo, @Unidad, @ListaPrecio)
                  
          UPDATE ListaPreciosD SET Precio = NULL WHERE Lista = @Lista AND Moneda = @ListaMoneda AND Articulo = @Articulo
          IF @@ROWCOUNT = 0
            INSERT ListaPreciosD (Lista, Moneda, Articulo) VALUES (@Lista, @ListaMoneda, @Articulo)          
        END ELSE
        BEGIN
        
          UPDATE ListaPreciosSubUnidad SET Precio = @ListaPrecio WHERE Lista = @Lista AND Moneda = @ListaMoneda AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Unidad = @Unidad
          IF @@ROWCOUNT = 0       
            INSERT ListaPreciosSubUnidad (Lista, Moneda, Articulo, SubCuenta, Unidad, Precio) VALUES (@Lista, @ListaMoneda, @Articulo, @SubCuenta, @Unidad, @ListaPrecio)
         
          UPDATE ListaPreciosD SET Precio = NULL WHERE Lista = @Lista AND Moneda = @ListaMoneda AND Articulo = @Articulo
          IF @@ROWCOUNT = 0
            INSERT ListaPreciosD (Lista, Moneda, Articulo) VALUES (@Lista, @ListaMoneda, @Articulo)          
          
          UPDATE ListaPreciosSub SET Precio = null WHERE Lista = @Lista AND Moneda = @ListaMoneda AND Articulo = @Articulo AND SubCuenta = @SubCuenta
          IF @@ROWCOUNT = 0
            INSERT ListaPreciosSub (Lista, Moneda, Articulo, SubCuenta) VALUES (@Lista, @ListaMoneda, @Articulo, @SubCuenta)
        END
      END
    END
    FETCH NEXT FROM crListaPrecios INTO @ListaMoneda
  END  -- While
  CLOSE crListaPrecios
  DEALLOCATE crListaPrecios
END
GO

/**************** spPrecioCalc ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPrecioCalc') and type = 'P') drop procedure dbo.spPrecioCalc
GO             
CREATE PROCEDURE spPrecioCalc
			@Sucursal		int,
			@Empresa		char(5),
			@Articulo		char(20),
			@SubCuenta		varchar(50),
			@Unidad			varchar(50),
			@MovMoneda		char(10),
			@MovTipoCambio		float,
			@ListaPreciosEsp	varchar(20) = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
     @ListaPrecios	varchar(20),
     @Base		varchar(20),
     @Usar		varchar(20),
     @Porcentaje	float,
     @Redondear		money,
     @Precio		money,
     @r			int

  DECLARE crPrecioCalc CURSOR
     FOR SELECT ListaPrecios, Base, UPPER(Usar), ISNULL(Porcentaje, 0.0), ISNULL(Redondear, 0.0)
           FROM PrecioCalc
          WHERE Activa = 1 AND ListaPrecios = ISNULL(@ListaPreciosEsp, ListaPrecios)
          ORDER BY Orden

  OPEN crPrecioCalc
  FETCH NEXT FROM crPrecioCalc INTO @ListaPrecios, @Base, @Usar, @Porcentaje, @Redondear
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spPCGet @Sucursal, @Empresa, @Articulo, @SubCuenta, @Unidad, @MovMoneda, @MovTipoCambio, @Base, @Precio OUTPUT
      IF @Usar = 'XPPRECIOCALC'
        EXEC xpPrecioCalc @Sucursal, @Empresa, @Articulo, @SubCuenta, @Unidad, @MovMoneda, @MovTipoCambio, @ListaPrecios, @Base, @Precio, @Porcentaje, @Precio OUTPUT
      ELSE 
      BEGIN
        IF @Usar IN ('MARGEN ARTICULO', 'MARGEN MINIMO')
        BEGIN
          SELECT @Porcentaje = NULL 
          SELECT @Porcentaje = CASE WHEN @Usar = 'MARGEN ARTICULO' THEN NULLIF(Margen, 0.0) 
     	   		            ELSE NULLIF(MargenMinimo, 0.0) 
			     END 
            FROM Art 
           WHERE Articulo = @Articulo
        END

        IF @Usar = 'MARGEN LISTA'
        BEGIN
          SELECT @Porcentaje = NULL 
          SELECT @Porcentaje = Margen 
            FROM ListaPreciosD
           WHERE Lista = @ListaPrecios AND Moneda = @MovMoneda AND Articulo = @Articulo
        END

        IF @Usar = 'PORCENTAJE' 
          SELECT @Precio = @Precio * (1.0 + (@Porcentaje/100.0)) 
        ELSE
          SELECT @Precio = (@Precio*100.0) / (100.0-@Porcentaje) 
        EXEC @r = spRound @Redondear
        SELECT @Precio = ROUND(@Precio, @r)
      END

      EXEC spPCSet @Sucursal, @Empresa, @Articulo, @SubCuenta, @Unidad, @MovMoneda, @MovTipoCambio, @ListaPrecios, @Precio, NULL
    END
    FETCH NEXT FROM crPrecioCalc INTO @ListaPrecios, @Base, @Usar, @Porcentaje, @Redondear
  END  -- While
  CLOSE crPrecioCalc
  DEALLOCATE crPrecioCalc
END
GO

/**************** spPCAfectarArticulo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPCAfectarArticulo') and type = 'P') drop procedure dbo.spPCAfectarArticulo
GO             
CREATE PROCEDURE spPCAfectarArticulo
			@Accion		char(20),
			@Sucursal	int,
			@Empresa	char(5),
			@Articulo	char(20),
			@SubCuenta	varchar(50),
			@Unidad		varchar(50),
			@MovMoneda	char(10),
			@MovTipoCambio	float,
			@Regresar	bit,
			@ListaModificar	varchar(20),
			@Nuevo		money,
			@Anterior	money,
			@Proveedor	varchar(10) = NULL,
			@SucursalEsp	int = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ImporteAfectar	money,
    @EstatusPrecio	char(15)

  IF @Regresar = 1 SELECT @ImporteAfectar = @Anterior ELSE SELECT @ImporteAfectar = @Nuevo
  IF (@Anterior = @Nuevo) OR (@Accion = 'CANCELAR')
    SELECT @EstatusPrecio = 'SINCAMBIO' 
  ELSE BEGIN
    IF @Nuevo > @Anterior 
      IF @Regresar = 0 SELECT @EstatusPrecio = 'SUBIO' ELSE SELECT @EstatusPrecio = 'BAJO'
    ELSE
      IF @Regresar = 0 SELECT @EstatusPrecio = 'BAJO'  ELSE SELECT @EstatusPrecio = 'SUBIO'
  END
  EXEC spPCSet @Sucursal, @Empresa, @Articulo, @SubCuenta, @Unidad, @MovMoneda, @MovTipoCambio, @ListaModificar, @ImporteAfectar, @EstatusPrecio, @Proveedor = @Proveedor, @SucursalEsp = @SucursalEsp
  RETURN
END
GO


/**************** spPCAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPCAfectar') and type = 'P') drop procedure dbo.spPCAfectar
GO             
CREATE PROCEDURE spPCAfectar
    		   @ID                		int,

		   @Accion			char(20),
    		   @Empresa	      		char(5),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20) OUTPUT,
    		   @MovTipo     		char(20),
		   @MovMoneda			char(10),
		   @MovTipoCambio		float,
    		   @FechaEmision      		datetime,
    		   @FechaAfectacion      	datetime,
    		   @FechaConclusion		datetime,

    	 	   @Proyecto	      		varchar(50),
    		   @Usuario	      		char(10),
    		   @Autorizacion      		char(10),
    		   @DocFuente	      		int,
    		   @Observaciones     		varchar(255),
    		   @Concepto     		varchar(50),
    		   @Estatus           		char(15),
 	    	   @EstatusNuevo	      	char(15),
    		   @FechaRegistro     		datetime,
    		   @Ejercicio	      		int,
    		   @Periodo	      		int,

		   @ListaModificar		varchar(20),
		   @Proveedor			varchar(10),
		   @FechaInicio			datetime,
		   @FechaTermino		datetime,
		   @Recalcular			bit,
		   @Parcial			bit,

		   @Conexion			bit,
		   @SincroFinal			bit,
		   @Sucursal			int,
		   @SucursalDestino		int,
		   @SucursalOrigen		int,

		   @CfgRecalcFinVigencia	bit,
	    	   @CfgListaModificarDetalle	bit,
		   @CfgContX			bit,
		   @CfgContXGenerar		char(20),
		   @GenerarPoliza		bit,

    		   @GenerarMov			char(20),
		   @IDGenerar			int	     OUTPUT,	
    		   @GenerarMovID	  	varchar(20)  OUTPUT,

       		   @Ok                		int          OUTPUT,
    		   @OkRef             		varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Articulo			char(20),
    @SubCuenta			varchar(50),
    @Unidad			varchar(50),
    @Nuevo			money,
    @Anterior			money,
    @PrecioListaN		money,
    @Precio2N			money, 
    @CostoN			money,
    @IncentivoN			money,
    @PrecioVolumenN		money,
    @PrecioListaA		money,
    @Precio2A			money, 
    @CostoA			money,
    @IncentivoA			money,
    @PrecioVolumenA		money,
    @Baja			bit,
    @ImporteAfectar		money,
    @PrecioCalc			bit,
    @Regresar			bit,
    @Brincar			bit,
    @EstatusPrecio		varchar(15),
    @ExistenciaSucursal		float,
    @ListaModificarD		varchar(20),
    @SucursalEsp		int,

    @Generar			bit,
    @GenerarAfectado		bit,
    @GenerarModulo		char(5),
    @GenerarMovTipo		char(20),
    @GenerarEstatus		char(15),
    @GenerarPeriodo 		int, 
    @GenerarEjercicio 		int,
    @FechaCancelacion		datetime,
    @GenerarAccion		char(20)
    
  -- Inicializar Variables
  SELECT @PrecioCalc		= 0,
         @Regresar		= 0, 
         @Generar 		= 0,
         @GenerarAfectado	= 0,
         @IDGenerar		= NULL,
         @GenerarModulo		= NULL,
         @GenerarMovID	        = NULL,
         @GenerarMovTipo        = NULL,
         @GenerarEstatus 	= 'SINAFECTAR'

  -- Asignar el Consecutivo al Movimiento
  EXEC spMovConsecutivo @Sucursal, @SucursalOrigen, @SucursalDestino, @Empresa, @Usuario, @Modulo, @Ejercicio, @Periodo, @ID, @Mov, NULL, @Estatus, @Concepto, @Accion, @Conexion, @SincroFinal, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  IF @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') AND @Accion <> 'CANCELAR' AND @Ok IS NULL
    EXEC spMovChecarConsecutivo	@Empresa, @Modulo, @Mov, @MovID, NULL, @Ejercicio, @Periodo, @Ok OUTPUT, @OkRef OUTPUT

  IF @Accion IN ('CONSECUTIVO', 'SINCRO') AND @Ok IS NULL
  BEGIN
    IF @Accion = 'SINCRO' EXEC spAsignarSucursalEstatus @ID, @Modulo, @SucursalDestino, @Accion
    SELECT @Ok = 80060, @OkRef = @MovID
    RETURN
  END

  IF @OK IS NOT NULL RETURN 

  -- Generar Mov Nuevo
  IF @Accion = 'GENERAR' AND @Ok IS NULL
  BEGIN
    EXEC spMovGenerar @Sucursal, @Empresa, @Modulo, @Ejercicio, @Periodo, @Usuario, @FechaRegistro, @GenerarEstatus, 
		      NULL, NULL, 
                      @Mov, @MovID, 0,
		      @GenerarMov, NULL, @GenerarMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    -- Leer MovTipo, Periodo y Ejercicio	
    EXEC spMovTipo @Modulo, @GenerarMov, @FechaAfectacion, @Empresa, NULL, NULL, @GenerarMovTipo OUTPUT, @GenerarPeriodo OUTPUT, @GenerarEjercicio OUTPUT, @Ok OUTPUT

    IF @@ERROR <> 0 SELECT @Ok = 1
--    IF @Ok IS NULL 
--      EXEC spPCCopiarDetalle @ID, @IDGenerar, @GenerarMovTipo, @Ok OUTPUT
 
    IF @Ok IS NULL SELECT @Ok = 80030
    RETURN
  END

  IF @OK IS NOT NULL RETURN 

  IF @Recalcular = 1 AND EXISTS(SELECT * FROM PrecioCalc WHERE Activa = 1)
    SELECT @PrecioCalc = 1

  IF @Conexion = 0 
    BEGIN TRANSACTION

    -- Poner el Estatus del Movimiento en "AFECTANDO"
    EXEC spMovEstatus @Modulo, 'AFECTANDO', @ID, @Generar, @IDGenerar, @GenerarAfectado, @Ok OUTPUT

    -- Actualizar Sucursal Detalle
    IF @Accion = 'AFECTAR' AND @Estatus = 'SINAFECTAR'
      IF (SELECT Sincro FROM Version) = 1
        EXEC sp_executesql N'UPDATE PCD SET Sucursal = @Sucursal, SincroC = 1 WHERE ID = @ID AND (Sucursal <> @Sucursal OR SincroC <> 1)', N'@Sucursal int, @ID int', @Sucursal, @ID

    IF @Accion <> 'CANCELAR' 
      -- Registrar el Movimiento en "Mov"
      EXEC spRegistrarMovimiento @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @Ejercicio, @Periodo, @FechaRegistro, @FechaEmision,
                       	         NULL, @Proyecto, @MovMoneda, @MovTipoCambio,
                       	         @Usuario, @Autorizacion, NULL, @DocFuente, @Observaciones,
			         @Generar, @GenerarMov, @GenerarMovID, @IDGenerar,
				 @Ok OUTPUT

    IF @EstatusNuevo IN ('CONCLUIDO', 'VIGENTE', 'CANCELADO') 
    BEGIN
      IF @MovTipo = 'PC.B'
      BEGIN
        DECLARE crPC CURSOR
           FOR SELECT NULLIF(RTRIM(Articulo), ''), ISNULL(PrecioListaN, 0.0), ISNULL(Precio2N, 0.0), ISNULL(CostoN, 0.0), ISNULL(IncentivoN, 0.0), ISNULL(PrecioVolumenN, 0.0),
                                                   ISNULL(PrecioListaA, 0.0), ISNULL(Precio2A, 0.0), ISNULL(CostoA, 0.0), ISNULL(IncentivoA, 0.0), ISNULL(PrecioVolumenA, 0.0), ISNULL(Baja, 0)
                 FROM PCBoletin
                WHERE ID = @ID      
        OPEN crPC
        FETCH NEXT FROM crPC INTO @Articulo, @PrecioListaN, @Precio2N, @CostoN, @IncentivoN, @PrecioVolumenN, @PrecioListaA, @Precio2A, @CostoA, @IncentivoA, @PrecioVolumenA, @Baja

        IF @@ERROR <> 0 SELECT @Ok = 1
        WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
        BEGIN
          IF @@FETCH_STATUS <> -2 AND @Ok IS NULL AND @Articulo IS NOT NULL
          BEGIN
            IF @Estatus = 'VIGENTE' AND @EstatusNuevo = 'CONCLUIDO' SELECT @Regresar = 1 ELSE SELECT @Regresar = 0
            IF @Accion = 'CANCELAR' SELECT @Regresar = ~@Regresar

            SELECT @Brincar = 0
            /*IF @Regresar = 1
              IF EXISTS(SELECT * FROM pc, pcd WHERE pc.id <> @ID AND pc.id = pcd.id AND pc.Empresa = @Empresa AND pc.Estatus = 'VIGENTE' AND pcd.Articulo = @Articulo AND pc.ListaModificar = @ListaModificar)
                SELECT @Brincar = 1*/

            IF @Brincar = 0
            BEGIN
              IF @Accion <> 'CANCELAR'
              BEGIN
                SELECT @PrecioListaA = PrecioLista, @Precio2A = Precio2, @CostoA = CostoReposicion, @IncentivoA = Incentivo, @PrecioVolumenA = Precio6
                  FROM Art
                 WHERE Articulo = @Articulo
                UPDATE PCBoletin 
                   SET PrecioListaA = @PrecioListaA, Precio2A = @Precio2A, CostoA = @CostoA, IncentivoA = @IncentivoA, PrecioVolumenA = @PrecioVolumenA
                 WHERE CURRENT OF crPC                      
              END
              EXEC spPCAfectarArticulo @Accion, @Sucursal, @Empresa, @Articulo, NULL, NULL, @MovMoneda, @MovTipoCambio, @Regresar, '(Precio Lista)',     @PrecioListaN,   @PrecioListaA
              EXEC spPCAfectarArticulo @Accion, @Sucursal, @Empresa, @Articulo, NULL, NULL, @MovMoneda, @MovTipoCambio, @Regresar, '(Precio 2)',         @Precio2N,       @Precio2A
              EXEC spPCAfectarArticulo @Accion, @Sucursal, @Empresa, @Articulo, NULL, NULL, @MovMoneda, @MovTipoCambio, @Regresar, '(Costo Reposicion)', @CostoN,         @CostoA
              EXEC spPCAfectarArticulo @Accion, @Sucursal, @Empresa, @Articulo, NULL, NULL, @MovMoneda, @MovTipoCambio, @Regresar, '(Incentivo)',        @IncentivoN,     @IncentivoA
              EXEC spPCAfectarArticulo @Accion, @Sucursal, @Empresa, @Articulo, NULL, NULL, @MovMoneda, @MovTipoCambio, @Regresar, '(Precio 6)',         @PrecioVolumenN, @PrecioVolumenA

              IF @Baja = 1 UPDATE Art SET Estatus = CASE @Accion WHEN 'CANCELAR' THEN 'ALTA' ELSE 'BAJA' END WHERE Articulo = @Articulo
              IF @PrecioCalc = 1 EXEC spPrecioCalc @Sucursal, @Empresa, @Articulo, NULL, NULL, @MovMoneda, @MovTipoCambio
            END
          END
          FETCH NEXT FROM crPC INTO @Articulo, @PrecioListaN, @Precio2N, @CostoN, @IncentivoN, @PrecioVolumenN, @PrecioListaA, @Precio2A, @CostoA, @IncentivoA, @PrecioVolumenA, @Baja
          IF @@ERROR <> 0 SELECT @Ok = 1
        END  -- While
        CLOSE crPC
        DEALLOCATE crPC
        IF @Accion <> 'CANCELAR' AND @Parcial = 0
          UPDATE Art SET EstatusPrecio = 'SINCAMBIO' WHERE Articulo NOT IN (SELECT DISTINCT Articulo FROM PCBoletin WHERE ID = @ID)
      END 
      ELSE BEGIN
        DECLARE crPC CURSOR
           FOR SELECT NULLIF(RTRIM(Articulo), ''), NULLIF(RTRIM(SubCuenta), ''), NULLIF(RTRIM(Unidad), ''), ISNULL(Nuevo, 0.0), ISNULL(Anterior, 0.0), ISNULL(Baja, 0), NULLIF(RTRIM(ListaModificar), ''), SucursalEsp
                 FROM PCD
                WHERE ID = @ID     
  
        OPEN crPC
        FETCH NEXT FROM crPC INTO @Articulo, @SubCuenta, @Unidad, @Nuevo, @Anterior, @Baja, @ListaModificarD, @SucursalEsp
        IF @@ERROR <> 0 SELECT @Ok = 1
        WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
        BEGIN
          IF @@FETCH_STATUS <> -2 AND @Ok IS NULL AND @Articulo IS NOT NULL
          BEGIN
            IF @CfgListaModificarDetalle = 0 OR @ListaModificarD IS NULL SELECT @ListaModificarD = @ListaModificar
            IF @Estatus = 'VIGENTE' AND @EstatusNuevo = 'CONCLUIDO' SELECT @Regresar = 1 ELSE SELECT @Regresar = 0
            IF @Accion = 'CANCELAR' SELECT @Regresar = ~@Regresar

            SELECT @Brincar = 0
            IF @Regresar = 1
              IF EXISTS(SELECT * FROM pc, pcd WHERE pc.id <> @ID AND pc.id = pcd.id AND pc.Empresa = @Empresa AND pc.Estatus = 'VIGENTE' AND pcd.Articulo = @Articulo AND pc.ListaModificar = @ListaModificarD)
                SELECT @Brincar = 1
            IF @Accion = 'CANCELAR' AND @Estatus = 'PENDIENTE' SELECT @Brincar = 1

            IF @Brincar = 0
            BEGIN
              IF @Estatus = 'VIGENTE' AND @EstatusNuevo = 'CONCLUIDO' AND @CfgRecalcFinVigencia = 1 AND EXISTS(SELECT * FROM PrecioCalc WHERE Activa = 1 AND ListaPrecios = @ListaModificarD)
                EXEC spPrecioCalc @Sucursal, @Empresa, @Articulo, @SubCuenta, @Unidad, @MovMoneda, @MovTipoCambio, @ListaModificarD
              ELSE BEGIN
                EXEC spPCAfectarArticulo @Accion, @Sucursal, @Empresa, @Articulo, @SubCuenta, @Unidad, @MovMoneda, @MovTipoCambio, @Regresar, @ListaModificarD, @Nuevo, @Anterior, @Proveedor = @Proveedor, @SucursalEsp = @SucursalEsp
                IF @Baja = 1 UPDATE Art SET Estatus = CASE @Accion WHEN 'CANCELAR' THEN 'ALTA' ELSE 'BAJA' END WHERE Articulo = @Articulo
                IF @PrecioCalc = 1 EXEC spPrecioCalc @Sucursal, @Empresa, @Articulo, @SubCuenta, @Unidad, @MovMoneda, @MovTipoCambio

                SELECT @ExistenciaSucursal = NULL
                SELECT @ExistenciaSucursal = SUM(Inventario)
                  FROM ArtSubExistenciaInv
                 WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '')
                UPDATE PCD SET ExistenciaSucursal = @ExistenciaSucursal WHERE CURRENT OF crPC
              END
            END
          END
          FETCH NEXT FROM crPC INTO @Articulo, @SubCuenta, @Unidad, @Nuevo, @Anterior, @Baja, @ListaModificarD, @SucursalEsp
          IF @@ERROR <> 0 SELECT @Ok = 1
        END  -- While
        CLOSE crPC
        DEALLOCATE crPC
        IF @Accion <> 'CANCELAR' AND @MovTipo = 'PC.P' AND @Parcial = 0
          UPDATE Art SET EstatusPrecio = 'SINCAMBIO' WHERE Articulo NOT IN (SELECT DISTINCT Articulo FROM PCD WHERE ID = @ID)
      END
    END

    -- Actualizar Movimiento
    IF @Ok IS NULL
    BEGIN
      IF @EstatusNuevo = 'CANCELADO' SELECT @FechaCancelacion = @FechaRegistro ELSE SELECT @FechaCancelacion = NULL
      IF @EstatusNuevo = 'CONCLUIDO' SELECT @FechaConclusion  = @FechaEmision  ELSE IF @EstatusNuevo <> 'CANCELADO' SELECT @FechaConclusion  = NULL
      IF @CfgContX = 1 AND @CfgContXGenerar <> 'NO'
      BEGIN
	IF @Estatus =  'SINAFECTAR' AND @EstatusNuevo <> 'CANCELADO' SELECT @GenerarPoliza = 1 ELSE
        IF @Estatus <> 'SINAFECTAR' AND @EstatusNuevo =  'CANCELADO' IF @GenerarPoliza = 1 SELECT @GenerarPoliza = 0 ELSE SELECT @GenerarPoliza = 1
      END  
      EXEC spValidarTareas @Empresa, @Modulo, @ID, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
      UPDATE PC
         SET FechaConclusion  = @FechaConclusion, 
             FechaCancelacion = @FechaCancelacion,
             UltimoCambio     = /*CASE WHEN UltimoCambio IS NULL THEN */@FechaRegistro /*ELSE UltimoCambio END*/,
             Estatus          = @EstatusNuevo,
             Situacion 	      = CASE WHEN @Estatus <> @EstatusNuevo THEN NULL ELSE Situacion END,
             GenerarPoliza    = @GenerarPoliza
       WHERE ID = @ID 
      IF @@ERROR <> 0 SELECT @Ok = 1
    END
 
  -- Agregar a Estatus Log
  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
    EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT

  -- Cancelar el Flujo
  IF @Accion = 'CANCELAR' AND @EstatusNuevo = 'CANCELADO' AND @Ok IS NULL
    EXEC spCancelarFlujo @Empresa, @Modulo, @ID, @Ok OUTPUT 

  IF @Conexion = 0
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      COMMIT TRANSACTION
    ELSE
      ROLLBACK TRANSACTION
    
  RETURN
END
GO

/**************** spPC ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPC') and type = 'P') drop procedure dbo.spPC
GO
CREATE PROCEDURE spPC
                   @ID                  	int,
    		   @Modulo	      		char(5),
		   @Accion			char(20),
		   @Base			char(20),
		   @FechaRegistro		datetime,
		   @GenerarMov			char(20),
		   @Usuario			char(10),
    		   @Conexion			bit,
		   @SincroFinal			bit,
    		   @Mov	      			char(20)	OUTPUT,
    		   @MovID            		varchar(20)	OUTPUT,
		   @IDGenerar			int		OUTPUT,

		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT,
 		   @Hoy				datetime	= NULL
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Sucursal			int,
    @SucursalDestino		int,
    @SucursalOrigen		int,
    @EnLinea			bit,
    @PuedeEditar		bit,
    @Empresa	      		char(5),
    @MovTipo   			char(20),
    @MovMoneda			char(10),
    @MovTipoCambio		float,
    @FechaEmision     		datetime,
    @FechaAfectacion		datetime,
    @FechaConclusion		datetime,
    @Proyecto	      		varchar(50),
    @ListaModificar		varchar(20),
    @Proveedor			varchar(10),
    @FechaInicio		datetime,
    @FechaTermino		datetime,
    @Recalcular			bit,
    @Parcial			bit,
    @MovUsuario	      		char(10),
    @Autorizacion     		char(10),
    @DocFuente	      		int,
    @Observaciones    		varchar(255),
    @Concepto    		varchar(50),
    @Estatus          		char(15),
    @EstatusNuevo		char(15),
    @Ejercicio	      		int,
    @Periodo	      		int,
    @GenerarMovID		varchar(20),
    @GenerarPoliza		bit,
    @CfgContX			bit,
    @CfgContXGenerar		char(20),
    @CfgListaModificarDetalle	bit,
    @CfgRecalcFinVigencia	bit

  -- Inicializar Variables
  SELECT @CfgContX        = 0,
         @CfgContXGenerar = 'NO'

  -- Leer Datos Generales del Movimiento
  SELECT @Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, @Empresa = Empresa, @MovID = MovID, @Mov = Mov, @FechaEmision = FechaEmision, @Proyecto = Proyecto,
         @MovUsuario = Usuario, @Autorizacion = Autorizacion, 
         @MovMoneda = Moneda, @MovTipoCambio = TipoCambio, 
         @DocFuente = DocFuente, @Observaciones = Observaciones, @Estatus = UPPER(Estatus), 
         @ListaModificar = NULLIF(RTRIM(ListaModificar), ''), @Proveedor = NULLIF(RTRIM(Proveedor), ''), @FechaInicio = FechaInicio, @FechaTermino = FechaTermino,
         @Recalcular = ISNULL(Recalcular, 0), @Parcial = ISNULL(Parcial, 1),
         @GenerarPoliza = GenerarPoliza, @FechaConclusion = FechaConclusion,
         @Concepto = Concepto
    FROM PC
   WHERE ID = @ID
  IF @@ERROR <> 0 SELECT @Ok = 1

  IF NULLIF(RTRIM(@Usuario), '') IS NULL SELECT @Usuario = @MovUsuario
  -- Leer MovTipo, Periodo y Ejercicio	
  -- IF @Accion IN ('AFECTAR', 'GENERAR') SELECT @FechaAfectacion = @FechaEmision ELSE SELECT @FechaAfectacion = @FechaRegistro
  EXEC spFechaAfectacion @Empresa, @Modulo, @ID, @Accion, @FechaEmision OUTPUT, @FechaRegistro, @FechaAfectacion OUTPUT
  EXEC spExtraerFecha @FechaAfectacion OUTPUT
  EXEC spMovTipo @Modulo, @Mov, @FechaAfectacion, @Empresa, NULL, NULL, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT
  EXEC spMovOk @SincroFinal, @ID, @Estatus, @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @FechaAfectacion, @FechaRegistro, @Ejercicio, @Periodo, @Proyecto, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
  BEGIN
    IF @SucursalDestino IS NOT NULL AND @SucursalDestino <> @Sucursal AND @Accion = 'AFECTAR'
    BEGIN
      EXEC spSucursalEnLinea @SucursalDestino, @EnLinea OUTPUT
      IF @EnLinea = 1 
      BEGIN
        EXEC spMovConsecutivo @Sucursal, @SucursalOrigen, @SucursalDestino, @Empresa, @Usuario, @Modulo, @Ejercicio, @Periodo, @ID, @Mov, NULL, @Estatus, @Concepto, @Accion, @Conexion, @SincroFinal, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        EXEC spAsignarSucursalEstatus @ID, @Modulo, @SucursalDestino, NULL
        SELECT @Sucursal = @SucursalDestino
      END ELSE
        SELECT @Accion = 'SINCRO'
    END

    IF @Estatus = 'SINCRO' AND @Accion = 'CANCELAR'
    BEGIN
      EXEC spPuedeEditarMovMatrizSucursal @Sucursal, @SucursalOrigen, @ID, @Modulo, @Empresa, @Usuario, @Mov, @Estatus, 1, @PuedeEditar OUTPUT
      IF @PuedeEditar = 0 
        SELECT @Ok = 60300 
      ELSE BEGIN
        SELECT @Estatus = 'SINAFECTAR'/*, @Verificar = 0*/
        EXEC spAsignarSucursalEstatus @ID, @Modulo, @Sucursal, @Estatus
      END
    END
  END

  IF (@Accion <> 'CANCELAR' AND @Estatus IN ('SINAFECTAR', 'PENDIENTE', 'VIGENTE')) OR 
     (@Accion = 'CANCELAR'  AND @Estatus IN ('CONCLUIDO',  'PENDIENTE', 'VIGENTE'))
  BEGIN
    SELECT @CfgListaModificarDetalle = PCListaModificarDetalle,
           @CfgRecalcFinVigencia     = PCRecalcPrecioFinVigencia
      FROM EmpresaCfg2
     WHERE Empresa = @Empresa
    IF @@ERROR <> 0 SELECT @Ok = 1

    SELECT @CfgContX = ContX
      FROM EmpresaGral
     WHERE Empresa = @Empresa
    IF @@ERROR <> 0 SELECT @Ok = 1

    IF @CfgContX = 1 
      SELECT @CfgContXGenerar = ContXGenerar
        FROM EmpresaCfgModulo
       WHERE Empresa = @Empresa
         AND Modulo  = @Modulo
    IF @@ERROR <> 0 SELECT @Ok = 1

    IF @Hoy IS NULL
    BEGIN
      SELECT @Hoy = FechaTrabajo FROM FechaTrabajo WHERE Empresa = @Empresa AND Sucursal = @Sucursal	
      EXEC spExtraerFecha @Hoy OUTPUT
    END
    IF @Hoy IS NULL
    BEGIN
      SELECT @Hoy = GETDATE()
      EXEC spExtraerFecha @Hoy OUTPUT
      INSERT FechaTrabajo (Empresa, Sucursal, FechaTrabajo) VALUES (@Empresa, @Sucursal, @Hoy)
    END
   
    IF @Accion = 'CANCELAR' 
      SELECT @EstatusNuevo = 'CANCELADO' 
    ELSE
    BEGIN 
      SELECT @EstatusNuevo = 'CONCLUIDO'

      IF @FechaInicio  IS NOT NULL AND @Hoy < @FechaInicio   SELECT @EstatusNuevo = 'PENDIENTE' ELSE
      IF @FechaTermino IS NOT NULL AND @Hoy <= @FechaTermino SELECT @EstatusNuevo = 'VIGENTE'
    END

    -- Verificar antes de Afectar
    /*IF @Estatus <> @EstatusNuevo
    BEGIN*/
      IF (@Conexion = 0 OR @Accion = 'CANCELAR') AND @Accion NOT IN ('GENERAR', 'CONSECUTIVO'/*, 'SINCRO'*/) AND @Ok IS NULL
      BEGIN
        EXEC spPCVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                           @FechaEmision, @Estatus, 
                           @ListaModificar, @Proveedor, @FechaInicio, @FechaTermino, @Hoy,
   		           @Conexion, @SincroFinal, @Sucursal, 
		           @CfgListaModificarDetalle, @CfgContX, @CfgContXGenerar, @GenerarPoliza,
		           @Ok OUTPUT, @OkRef OUTPUT
        -- Quitar los mensajes cuando la afectarcion es normal 
        IF @Ok BETWEEN 80000 AND 89999 AND @Accion IN ('AFECTAR', 'CANCELAR') SELECT @Ok = NULL ELSE

        IF @Ok IS NULL
          EXEC xpPCVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                             @FechaEmision, @Estatus, 
                             @ListaModificar, @Proveedor, @FechaInicio, @FechaTermino, @Hoy,
   		             @Conexion, @SincroFinal, @Sucursal, 
		             @CfgListaModificarDetalle, @CfgContX, @CfgContXGenerar, @GenerarPoliza,
		             @Ok OUTPUT, @OkRef OUTPUT

        -- Si Verifico y todo estubo bien
        IF @Accion = 'VERIFICAR' AND @Ok IS NULL
        BEGIN
          SELECT @Ok = 80000
          EXEC xpOk_80000 @Empresa, @Usuario, @Accion, @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
        END
      END
    
      IF @Accion IN ('AFECTAR', 'GENERAR', 'CANCELAR','CONSECUTIVO','SINCRO') AND @Ok IS NULL
        EXEC spPCAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda, @MovTipoCambio, 
                         @FechaEmision, @FechaAfectacion, @FechaConclusion,
	  	         @Proyecto, @Usuario, @Autorizacion, @DocFuente, @Observaciones, @Concepto,
                         @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, 
                         @ListaModificar, @Proveedor, @FechaInicio, @FechaTermino, @Recalcular, @Parcial,
		         @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen,
		         @CfgRecalcFinVigencia, @CfgListaModificarDetalle, @CfgContX, @CfgContXGenerar, @GenerarPoliza,
                         @GenerarMov, @IDGenerar OUTPUT, @GenerarMovID OUTPUT,
                         @Ok OUTPUT, @OkRef OUTPUT

    /*END*/
  END ELSE 
  BEGIN
    IF @Estatus = 'SINAFECTAR' AND @Accion = 'CANCELAR' EXEC spMovCancelarSinAfectar @Modulo, @ID, @Ok OUTPUT ELSE
    IF @Estatus = 'AFECTANDO' SELECT @Ok = 80020 ELSE
    IF @Estatus = 'CONCLUIDO' SELECT @Ok = 80010
    ELSE SELECT @Ok = 60040, @OkRef = 'Estatus: '+@Estatus
  END

  IF @Accion = 'SINCRO' AND @Ok = 80060 
  BEGIN
    SELECT @Ok = NULL, @OkRef = NULL
    EXEC spSucursalEnLinea @SucursalDestino, @EnLinea OUTPUT
    IF @EnLinea = 1 EXEC spSincroFinalModulo @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
  END

  -- Si hay Mensaje pero no tiene referencia
  IF @Ok IS NOT NULL AND @OkRef IS NULL 

    -- Si se Genero un Movimiento, Desplegarlo
    IF @Ok = 80030
      SELECT @OkRef = 'Movimiento: '+RTRIM(@GenerarMov)+' '+LTRIM(Convert(Char, @GenerarMovID))

    -- Si hubo un error poner como referencia el Movimiento
    ELSE
      SELECT @OkRef = 'Movimiento: '+RTRIM(@Mov)+' '+LTRIM(Convert(Char, @MovID)), @IDGenerar = NULL

  RETURN
END
GO

-- spPCHoy @Empresa = 'VIANA'
/**************** spPCHoy ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPCHoy') and type = 'P') drop procedure dbo.spPCHoy
GO
CREATE PROCEDURE spPCHoy
		     @Empresa	char(5),
		     @Sucursal	int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID		int,
    @EnLinea	bit

  DECLARE crPCHoy CURSOR FOR
    SELECT ID, Sucursal
      FROM PC 
     WHERE Estatus IN ('PENDIENTE', 'VIGENTE') AND Sucursal = ISNULL(NULLIF(@Sucursal, 0), Sucursal)

  OPEN crPCHoy
  FETCH NEXT FROM crPCHoy INTO @ID, @Sucursal
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spSucursalEnLinea @Sucursal, @EnLinea OUTPUT
      IF @EnLinea = 1
        EXEC spAfectar 'PC', @ID, @EnSilencio = 1
    END

    FETCH NEXT FROM crPCHoy INTO @ID, @Sucursal
  END  -- While	
  CLOSE crPCHoy
  DEALLOCATE crPCHoy
  RETURN
END
GO

/**************** spPCCerrarDia ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPCCerrarDia') and type = 'P') drop procedure dbo.spPCCerrarDia
GO
CREATE PROCEDURE spPCCerrarDia
			@Fecha	datetime,
			@Ok	int		OUTPUT,
			@OkRef	varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID		int

  DECLARE crPCCerrarDia CURSOR FOR
    SELECT ID
      FROM PC 
     WHERE Estatus IN ('PENDIENTE', 'VIGENTE')

  OPEN crPCCerrarDia
  FETCH NEXT FROM crPCCerrarDia INTO @ID
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spAfectar 'PC', @ID, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    END
    FETCH NEXT FROM crPCCerrarDia INTO @ID
  END  -- While	
  CLOSE crPCCerrarDia
  DEALLOCATE crPCCerrarDia
  RETURN
END
GO


/**************** spPCCancelarPrecios ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPCCancelarPrecios') and type = 'P') drop procedure dbo.spPCCancelarPrecios
GO
CREATE PROCEDURE spPCCancelarPrecios
		     @Empresa		char(5),
		     @Sucursal		int,
		     @Usuario		char(10),
		     @FechaTrabajo	datetime,
		     @CancelarMov	char(20),
		     @ID		int,
		     @Mov		char(20),
                     @MovID		varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CancelarID	int,
    @Ok		int,
    @OkRef	varchar(255)

  SELECT @Ok = NULL, @OkRef = NULL
  BEGIN TRANSACTION 
    EXEC @CancelarID = spMovCopiar @Sucursal, 'PC', @ID, @Usuario, @FechaTrabajo, @EnSilencio = 1, @GenerarMov = @CancelarMov, @Conexion = 1, @SinDetalle = 1
    UPDATE PC SET Mov = @CancelarMov, OrigenTipo = 'PC', Origen = @Mov, OrigenID = @MovID WHERE ID = @CancelarID
    DELETE PCD WHERE ID = @CancelarID
    INSERT PCD (ID, Sucursal, Renglon, Articulo, SubCuenta, Unidad, Nuevo, Anterior)
    SELECT @CancelarID, @Sucursal, Renglon, Articulo, SubCuenta, Unidad, Anterior, Nuevo
      FROM PCD
     WHERE ID = @ID   
    EXEC spAfectar 'PC', @CancelarID, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION
    SELECT 'Se Genero con Exito '+RTRIM(Mov)+' '+RTRIM(MovID) FROM PC WHERE ID = @CancelarID
  END ELSE 
  BEGIN
    ROLLBACK TRANSACTION
    SELECT Descripcion+' '+ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok  
  END
  RETURN
END
GO

/**************** spMetodoUsar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMetodoUsar') and type = 'P') drop procedure dbo.spMetodoUsar
GO
CREATE PROCEDURE spMetodoUsar
			@Articulo	varchar(20),
			@Usar		varchar(20),
			@Base		varchar(20),
			@Moneda		varchar(10),
			@Monto		float,
			@MontoFijo	float,
    			@Porcentaje	float	OUTPUT,
    			@Margen		float	OUTPUT,
    			@Importe	float	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Porcentaje = NULL, @Margen = NULL, @Importe = NULL, @Usar = UPPER(@Usar)
  IF @Usar = 'PORCENTAJE'
    SELECT @Porcentaje = ISNULL(@MontoFijo, @Monto)
  ELSE
  IF @Usar = 'MARGEN'
    SELECT @Margen = ISNULL(@MontoFijo, @Monto)
  ELSE
  IF @Usar IN ('MARGEN ARTICULO', 'MARGEN MINIMO')
  BEGIN
    SELECT @Margen = CASE WHEN @Usar = 'MARGEN ARTICULO' THEN NULLIF(Margen, 0.0) ELSE NULLIF(MargenMinimo, 0.0) END 
      FROM Art 
     WHERE Articulo = @Articulo
  END ELSE
  IF @Usar = 'MARGEN LISTA'
  BEGIN
    SELECT @Margen = Margen 
      FROM ListaPreciosD
     WHERE Lista = @Base AND Moneda = @Moneda AND Articulo = @Articulo
  END ELSE
  IF @Usar = 'IMPORTE'
    SELECT @Importe = ISNULL(@MontoFijo, @Monto)

  SELECT @Porcentaje = NULLIF(@Porcentaje, 0.0), @Margen = NULLIF(@Margen, 0.0), @Importe = NULLIF(@Importe, 0.0)
  RETURN
END
GO

/**************** spMetodoAplicar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMetodoAplicar') and type = 'P') drop procedure dbo.spMetodoAplicar
GO
CREATE PROCEDURE spMetodoAplicar
    			@Porcentaje	float,
    			@Margen		float,
    			@Importe	float,
     			@Valor		float	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  IF NULLIF(@Porcentaje, 0.0) IS NOT NULL
    SELECT @Valor = @Valor * (1.0 + (@Porcentaje/100.0)) 
  ELSE
  IF NULLIF(@Margen, 0.0) IS NOT NULL
    SELECT @Valor = (@Valor*100.0) / (100.0-@Margen) 
  ELSE
  IF NULLIF(@Importe, 0.0) IS NOT NULL
    SELECT @Valor = @Valor + @Importe

  RETURN
END
GO

/**************** spMetodoObtener ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMetodoObtener') and type = 'P') drop procedure dbo.spMetodoObtener
GO
CREATE PROCEDURE spMetodoObtener
    			@Porcentaje	float,
    			@Margen		float,
    			@Importe	float,
     			@Valor		float	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  IF NULLIF(@Porcentaje, 0.0) IS NOT NULL
    SELECT @Valor = @Valor * (@Porcentaje/100.0)
  ELSE
  IF NULLIF(@Margen, 0.0) IS NOT NULL
    SELECT @Valor = ((@Valor*100.0) / (100.0-@Margen)) - @Valor
  ELSE
  IF NULLIF(@Importe, 0.0) IS NOT NULL
    SELECT @Valor = @Importe

  RETURN
END
GO

/**************** spMetodoRedondear ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMetodoRedondear') and type = 'P') drop procedure dbo.spMetodoRedondear
GO
CREATE PROCEDURE spMetodoRedondear
    			@Redondear	bit,
    			@Redondeo	float,
     			@Valor		float	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @r		int

  IF @Redondear = 1
  BEGIN
    EXEC @r = spRound @Redondeo
    SELECT @Valor = ROUND(@Valor, @r)
  END
  RETURN
END
GO


/**************** spPrecioMetodoCalc ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPrecioMetodoCalc') and type = 'P') drop procedure dbo.spPrecioMetodoCalc
GO
CREATE PROCEDURE spPrecioMetodoCalc
			@Modulo			char(5),
		     	@ID			int,
			@Empresa		varchar(5),
			@Sucursal		int,
			@Usuario		varchar(10),
			@Moneda			varchar(10),
			@TipoCambio		float,
			@Proveedor		varchar(10),

			@OfertaTipo		varchar(20),
			@Forma			varchar(20),
			@Metodo			varchar(50),
			@Base			varchar(20),
			@Usar			varchar(20),
			@MontoFijo		float,
			@Redondear		bit,
			@Redondeo		money,

			@Renglon		float,
			@RenglonSub		int,
			@Articulo		varchar(20), 
			@SubCuenta		varchar(50), 
			@Unidad			varchar(50), 
			@PrecioAnterior		money,
			@SucursalEsp		int, 
			@ListaModificarD	varchar(50),

			@Monto			float	OUTPUT, 
			@PrecioNuevo		money	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Porcentaje	float,
    @Margen	float,
    @Importe	float

  IF @Base = '(n/a)'
    SELECT @PrecioNuevo = 0.0
  ELSE
  IF @Base = '(Precio Actual)' 
    SELECT @PrecioNuevo = @PrecioAnterior
  ELSE
    EXEC spPCGet @Sucursal, @Empresa, @Articulo, @SubCuenta, @Unidad, @Moneda, @TipoCambio, @Base, @PrecioNuevo OUTPUT, @Proveedor = @Proveedor, @SucursalEsp = @SucursalEsp

  EXEC spMetodoUsar @Articulo, @Usar, @Base, @Moneda, @Monto, @MontoFijo, @Porcentaje OUTPUT, @Margen OUTPUT, @Importe OUTPUT

  IF UPPER(@Forma) IN (NULL, 'PRECIO')
    EXEC spMetodoAplicar @Porcentaje, @Margen, @Importe, @PrecioNuevo OUTPUT
  ELSE 
    EXEC spMetodoObtener @Porcentaje, @Margen, @Importe, @PrecioNuevo OUTPUT

  EXEC spMetodoRedondear @Redondear, @Redondeo, @PrecioNuevo OUTPUT

  EXEC xpPrecioMetodoCalc @Modulo, @ID, @Empresa, @Sucursal, @Usuario, @Moneda, @TipoCambio, @Proveedor,
                          @OfertaTipo, @Forma, @Metodo, @Base, @Usar, @MontoFijo, @Redondear, @Redondeo, 
                          @Renglon, @RenglonSub, @Articulo, @SubCuenta, @Unidad, @PrecioAnterior, @SucursalEsp, @ListaModificarD, 
                          @Monto OUTPUT, @PrecioNuevo OUTPUT

  RETURN
END
GO

/**************** spPCRecalc ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPCRecalc') and type = 'P') drop procedure dbo.spPCRecalc
GO
CREATE PROCEDURE spPCRecalc
		     @ID		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CfgListaModificarDetalle	bit,
    @Empresa			varchar(5),
    @Sucursal			int,
    @Usuario			varchar(10),
    @Moneda			varchar(10),
    @TipoCambio			float,
    @Proveedor			varchar(10),
    @Metodo			varchar(50),
    @MetodoBase			varchar(20),
    @MetodoUsar			varchar(20),
    @MetodoMontoFijo		float,
    @MetodoRedondear		bit,
    @MetodoRedondeo		money,
    @ListaModificar		varchar(20),
    @ListaModificarD		varchar(20),
    @Renglon			float,
    @Articulo			varchar(20), 
    @SubCuenta			varchar(50), 
    @Unidad			varchar(50), 
    @PrecioAnterior		money, 
    @PrecioNuevo		money, 
    @Monto			float, 
    @SucursalEsp		int 

  SELECT @Empresa = Empresa,
	 @Sucursal = Sucursal,
	 @Usuario = Usuario,
	 @Moneda = Moneda,
         @TipoCambio = TipoCambio,
	 @Proveedor = Proveedor,
         @Metodo = Metodo,
         @ListaModificar = NULLIF(RTRIM(ListaModificar), '')
    FROM PC
   WHERE ID = @ID

  SELECT @CfgListaModificarDetalle = PCListaModificarDetalle
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  SELECT @MetodoBase = Base, @MetodoUsar = UPPER(Usar), @MetodoMontoFijo = CASE WHEN MontoFijo = 1 THEN Monto ELSE NULL END, @MetodoRedondear = Redondear, @MetodoRedondeo = Redondeo
    FROM PrecioMetodo
   WHERE Metodo = @Metodo

  DECLARE crPCD CURSOR FOR
    SELECT Renglon, Articulo, SubCuenta, Unidad, ISNULL(Anterior, 0.0), SucursalEsp, NULLIF(RTRIM(ListaModificar), ''), ISNULL(Monto, 0.0), Nuevo
      FROM PCD
     WHERE ID = @ID
  OPEN crPCD
  FETCH NEXT FROM crPCD INTO @Renglon, @Articulo, @SubCuenta, @Unidad, @PrecioAnterior, @SucursalEsp, @ListaModificarD, @Monto, @PrecioNuevo
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @CfgListaModificarDetalle = 0 OR @ListaModificarD IS NULL SELECT @ListaModificarD = @ListaModificar
      EXEC spPrecioMetodoCalc 'PC', @ID, @Empresa, @Sucursal, @Usuario, @Moneda, @TipoCambio, @Proveedor,
                              NULL, NULL, @Metodo, @MetodoBase, @MetodoUsar, @MetodoMontoFijo, @MetodoRedondear, @MetodoRedondeo, 
                              @Renglon, NULL, @Articulo, @SubCuenta, @Unidad, @PrecioAnterior, @SucursalEsp, @ListaModificarD, 
                              @Monto OUTPUT, @PrecioNuevo OUTPUT
      UPDATE PCD SET Monto = NULLIF(@Monto, 0.0), Nuevo = @PrecioNuevo WHERE CURRENT OF crPCD
    END
    FETCH NEXT FROM crPCD INTO @Renglon, @Articulo, @SubCuenta, @Unidad, @PrecioAnterior, @SucursalEsp, @ListaModificarD, @Monto, @PrecioNuevo
  END  -- While	
  CLOSE crPCD
  DEALLOCATE crPCD
  RETURN
END
GO



PRINT "******************* SP PC ******************"


