SET ANSI_DEFAULTS OFF
GO

/**************** spCompraImportacionEstadoCuenta ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCompraImportacionEstadoCuenta') and type = 'P') drop procedure dbo.spCompraImportacionEstadoCuenta
GO              
CREATE PROCEDURE spCompraImportacionEstadoCuenta
			@Empresa			char(5),
			@Almacen			char(10),
			@ProveedorD			char(10),
			@ProveedorA			char(10),
			@ArticuloD			char(20),
			@ArticuloA			char(20),
			@ArtCat				char(50),
			@ArtGrupo			char(50),
			@ArtFam				char(50),
			@Fabricante			char(50)
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE
  @Mov				char(20),
  @MovID			char(20),
  @Articulo			char(20),
  @SubCuenta		char(50),
  @SerieLote		char(20),

  @IDInv			int,
  @MovInv			char(20),
  @MovIDInv			char(20)

  DECLARE @CompraImportacionEstadoCuenta TABLE(
  Modulo			char(10),
  Mov				char(20),
  MovID				char(20),
  Aplica			char(20),
  AplicaID			char(20),
  FechaEmision		datetime,
  Proveedor			char(10),
  NombreProveedor	char(100),
  GuiaEntrega		char(20),
  FechaGuia			datetime,
  PuertoDestino		char(50),
  FechaDestino		datetime,
  		
  Articulo			char(20),
  SubCuenta			char(50),
  Descripcion		char(100),
  ReferenciaD		char(50),
  SerieLote			char(50),
  Propiedades		char(50),
  Cantidad			float,
  Existencia		float,
  Paquete			int,
  PaqueteCantidad	money,
  Cargo				float,
  Abono				float)
  
  IF RTRIM(@ProveedorD) IN (NULL, '') SELECT @ProveedorD = Min(Proveedor) FROM Prov WHERE Tipo <> 'Estructura'
  IF RTRIM(@ProveedorA) IN (NULL, '') SELECT @ProveedorA = Max(Proveedor) FROM Prov WHERE Tipo <> 'Estructura'
  IF RTRIM(@ArticuloD) IN (NULL, '') SELECT @ArticuloD = Min(Articulo) FROM Art WHERE Tipo <> 'Estructura'
  IF RTRIM(@ArticuloA) IN (NULL, '') SELECT @ArticuloA = Max(Articulo) FROM Art WHERE Tipo <> 'Estructura'
  IF RTRIM(@ArtCat) IN (NULL, 'NULL', '', '(TODOS)', 'TODOS') SELECT @ArtCat = NULL
  IF RTRIM(@ArtGrupo) IN (NULL, 'NULL', '', '(TODOS)', 'TODOS') SELECT @ArtGrupo = NULL
  IF RTRIM(@ArtFam) IN (NULL, 'NULL', '', '(TODOS)', 'TODOS') SELECT @ArtFam = NULL
  IF RTRIM(@Fabricante) IN (NULL, 'NULL', '', '(TODOS)', 'TODOS') SELECT @Fabricante = NULL
  
  INSERT INTO @CompraImportacionEstadoCuenta
       (Modulo, Mov, MovID, Aplica, AplicaID, FechaEmision, Proveedor, NombreProveedor, GuiaEntrega, FechaGuia, PuertoDestino, FechaDestino,
        Articulo, SubCuenta, Descripcion, ReferenciaD, SerieLote, Propiedades, Cantidad, Existencia, Paquete, PaqueteCantidad, Cargo)
  SELECT 'COMS', v.Mov, v.MovID, v.Mov, v.MovID, v.FechaEmision, v.Proveedor, p.Nombre, ci.GuiaEntrega, ci.FechaGuia, ci.PuertoDestino, ci.FechaDestino,
        v.Articulo, v.SubCuenta, a.Descripcion1, v.ImportacionReferencia, v.SerieLote, v.Propiedades, v.Cantidad, v.Existencia, v.Paquete, v.PaqueteCantidad, v.Cantidad
    FROM VerCompraImportacionSerieLote v
    LEFT OUTER JOIN CompraImportacion ci ON v.ID = ci.ID
    JOIN Prov p ON v.Proveedor = p.Proveedor
    JOIN Art a ON v.Articulo = a.Articulo
   WHERE v.Empresa = @Empresa
     AND v.Almacen = @Almacen
     AND v.Proveedor BETWEEN @ProveedorD AND @ProveedorA
     AND v.Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND ISNULL(a.Categoria, '')  = ISNULL(@ArtCat, ISNULL(a.Categoria, ''))
     AND ISNULL(a.Grupo, '')      = ISNULL(@ArtGrupo, ISNULL(a.Grupo, ''))
     AND ISNULL(a.Familia, '')    = ISNULL(@ArtFam, ISNULL(a.Familia, ''))
     AND ISNULL(a.Fabricante, '') = ISNULL(@Fabricante, ISNULL(a.Fabricante, ''))

  DECLARE crCompraImportacionEstadoCuenta CURSOR LOCAL FOR
  SELECT DISTINCT c.Mov, c.MovID, c.Articulo, ISNULL(c.SubCuenta, ''), c.SerieLote
    FROM @CompraImportacionEstadoCuenta c  

  OPEN crCompraImportacionEstadoCuenta
  FETCH NEXT FROM crCompraImportacionEstadoCuenta INTO @Mov, @MovID, @Articulo, @SubCuenta, @SerieLote
  WHILE @@FETCH_STATUS = 0
  BEGIN
  	INSERT INTO @CompraImportacionEstadoCuenta
       (Modulo, Mov, MovID, Aplica, AplicaID, FechaEmision, Articulo, SubCuenta, Abono)
    SELECT 'INV', @Mov, @MovID, i.Mov, i.MovID, i.FechaEmision, id.Articulo, id.SubCuenta, slm.Cantidad
      FROM Inv i
      JOIN InvD id ON i.ID = id.ID
      JOIN MovTipo mt ON i.Mov = mt.Mov AND mt.Modulo = 'INV' AND mt.Clave = 'INV.SI'
      JOIN SerieLoteMov slm ON i.Empresa = slm.Empresa AND slm.Modulo = 'INV' AND i.ID = slm.ID AND id.RenglonID = slm.RenglonID AND id.Articulo = slm.Articulo AND ISNULL(id.SubCuenta,'') = slm.SubCuenta
      JOIN SerieLoteD sld ON i.Empresa = sld.Empresa AND id.Articulo = sld.Articulo AND ISNULL(id.SubCuenta, '') = isnull(sld.SubCuenta, '') AND i.ID = sld.ID AND mt.Modulo = sld.Modulo AND slm.SerieLote = sld.SerieLote
    WHERE i.Estatus = 'CONCLUIDO'
      AND i.Empresa = @Empresa
      AND i.Almacen = @Almacen
      AND sld.Empresa = @Empresa AND sld.Articulo = @Articulo AND ISNULL(sld.SubCuenta, '') = @SubCuenta AND sld.SerieLote = @SerieLote AND sld.Modulo = 'INV'

    FETCH NEXT FROM crCompraImportacionEstadoCuenta INTO @Mov, @MovID, @Articulo, @SubCuenta, @SerieLote
  END

  CLOSE crCompraImportacionEstadoCuenta
  DEALLOCATE crCompraImportacionEstadoCuenta
  
  SELECT * FROM @CompraImportacionEstadoCuenta ciec
  ORDER BY ciec.Mov, ciec.MovID, ciec.Articulo, ciec.SubCuenta, ciec.SerieLote, ciec.Aplica, ciec.AplicaID

  RETURN
END
GO

/************** [spRepGeneralProyecto] *************/
-- BUG 16101
if exists (select * from sysobjects where id = object_id('dbo.spRepGeneralProyecto') and type = 'P') drop procedure dbo.spRepGeneralProyecto
GO
CREATE PROC spRepGeneralProyecto 
		@EstacionTrabajo int
--//WITH ENCRYPTION
AS BEGIN
 DECLARE      
   @rowcount     int, 
   @lvl          int, 
   @delcount     int,
   @Proyecto     varchar(50),
   @ProyectoD    varchar(50),
   @ProyectoA    varchar(50),
   @Empresa      varchar(5),
   @Moneda       varchar(15),
   @ProyectoRama varchar(50),
   @Ventas       money,
   @Compras      money,
   @Gastos       money,
   @Tipo         varchar(15),
   @ID           int, 
 
   @HorasPlaneadas   float,
   @ImportePlaneadas money,
   @HorasReales      float,
   @ImporteReales    money


 SELECT @Empresa		=	InfoEmpresa,	
	    @ProyectoD		=	InfoProyectoD,
	    @ProyectoA		=	InfoProyectoA,
	    @Moneda			=	InfoMoneda		
   FROM RepParam
  WHERE Estacion = @EstacionTrabajo

 
 DECLARE @Informacion TABLE
 (
   ProyectoRama       varchar(50),
   Proyecto           varchar(50),
   Descripcion        varchar(100) null,
   Tipo               varchar(15),
   Ventas             money null,
   Compras            money null,
   Gastos             money null,
   HorasPlaneadas     float null,
   ImportePlaneadas   money null,
   HorasReales        float null,
   ImporteReales      money null
 )

 DECLARE @Jerarquia TABLE
 (
	TreeId           int identity primary key,
	Proyecto         varchar(50)   null,
	lvl              int           null, 
	ParentTreeId     varchar(20)   null,
	Path             varchar(max) null, 
	Proyecto_Id_Path varchar(max) null
 )   
 
 SET @lvl=0

 DECLARE CursorProyecto CURSOR FOR
	SELECT Proyecto, Tipo
	  FROM Proy
	 WHERE Proyecto BETWEEN @ProyectoD AND @ProyectoA

 OPEN CursorProyecto

 FETCH NEXT FROM CursorProyecto INTO @Proyecto, @Tipo 

 WHILE @@FETCH_STATUS = 0 
 BEGIN   
 
   
   IF @Tipo = 'Proyecto'
   BEGIN   	 

	 INSERT INTO @Jerarquia(Proyecto, lvl) 
		  VALUES          (@Proyecto, @lvl)

	 SET @rowcount=@@ROWCOUNT
		 
	 UPDATE @Jerarquia set Path=str(TreeId,10,0) + '.', Proyecto_Id_Path=cast(Proyecto as varchar(50)) + '\'

	 WHILE @rowcount>0
	   BEGIN
	     SET @lvl=@lvl+1	

		 INSERT INTO @Jerarquia(Proyecto, lvl, ParentTreeId)
			  SELECT e.Proyecto, @lvl, t.TreeId
			    FROM Proy e INNER JOIN @Jerarquia t ON e.ProyectoRama=t.Proyecto AND t.lvl=@lvl-1

		  SELECT @rowcount=@@ROWCOUNT, @delcount=@@ROWCOUNT
		  SELECT @rowcount=@rowcount-@delcount
	   END   
  
   END
   ELSE   
   IF @Tipo = 'SubProyecto'
   BEGIN     
	 
	 DELETE FROM @Jerarquia

     INSERT INTO @Jerarquia(Proyecto, lvl) VALUES (@Proyecto, @lvl)   
  
     INSERT INTO @Informacion(ProyectoRama, Proyecto, Descripcion, Tipo)
     SELECT p.ProyectoRama, p.Proyecto, p.Descripcion, p.Tipo
       FROM Proy p JOIN @Jerarquia j
         ON p.Proyecto = j.Proyecto


     UPDATE @Informacion 
        SET ProyectoRama = Proyecto 
      WHERE ISNULL(ProyectoRama,'') = '' 
        AND Tipo = 'Proyecto'
 
     SELECT @Proyecto = MIN(Proyecto) FROM @Informacion

     WHILE @Proyecto IS NOT NULL     
	 BEGIN	   

       -- Ventas
       SELECT @Ventas = SUM(v.Importe /* + v.Impuestos */) 
         FROM Venta v JOIN MovTipo mt 
           ON 'VTAS' = mt.Modulo AND v.Mov = mt.Mov 
        WHERE mt.Clave IN ('VTAS.F')
          AND v.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
          AND v.Empresa = @Empresa
          AND ISNULL(v.Proyecto,'') = @Proyecto   
          AND v.Moneda = @Moneda
     
	   -- Compras
	   SELECT @Compras = SUM(c.Importe /* + c.Impuestos */) 
		 FROM Compra c JOIN MovTipo mt 
		   ON 'COMS' = mt.Modulo AND c.Mov = mt.Mov 
		WHERE mt.Clave IN ('COMS.F')
		  AND c.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
          AND c.Empresa = @Empresa
		  AND ISNULL(c.Proyecto,'') = @Proyecto  
		  AND c.Moneda = @Moneda
          
	   -- Gastos
	   SELECT @Gastos = SUM(g.Importe /* + g.Impuestos*/) 
		 FROM Gasto g JOIN MovTipo mt 
		   ON 'GAS' = mt.Modulo AND g.Mov = mt.Mov 
		WHERE mt.Clave IN ('GAS.G', 'GAS.P', 'GAS.GTC')
		  AND g.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
		  AND g.Empresa = @Empresa 
		  AND ISNULL(g.Proyecto,'') = @Proyecto  
		  AND g.Moneda = @Moneda         
                
	   -- Horas Planeadas
	   SELECT @HorasPlaneadas = SUM(ISNULL(DuracionDias,0) * ISNULL(p.HorasDia, 8)) 
		 FROM Proyecto p JOIN ProyectoD pd
           ON p.ID = pd.ID 
		WHERE p.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
		  AND p.Empresa = @Empresa
		  AND ISNULL(p.Proyecto,'') = @Proyecto
		  AND pd.EsFase = 0      
      
	   -- Importe Planeadas
	   SELECT @ID = ID FROM Proyecto WHERE Empresa = @Empresa AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO') AND Proyecto = @Proyecto
   
	   SELECT @ImportePlaneadas = SUM(ISNULL(pr.CostoHora,0) * ISNULL(pd.DuracionDias,0) * ISNULL(pr.HorasDia, 8))
		 FROM ProyectoRecurso pr JOIN ProyectoDRecurso pdr ON pr.ID = pdr.ID 
		  AND pr.Recurso = pdr.Recurso JOIN ProyectoD pd ON pdr.ID = pd.ID 
		  AND pdr.Actividad = pd.Actividad
		WHERE pr.ID = @ID        
      
	   -- Horas Reales
	   SELECT @HorasReales = SUM(ISNULL(ad.Cantidad,0)) FROM Asiste a JOIN AsisteD ad 
		   ON a.ID = ad.ID JOIN MovTipo mt
           ON 'ASIS' = mt.Modulo AND a.Mov = mt.Mov
		WHERE mt.Clave = 'ASIS.RA'
		  AND a.Estatus NOT IN ('SINAFECTAR', 'CANCELADO') 
		  AND a.Empresa = @Empresa
		  AND ISNULL(ad.Proyecto,'') = @Proyecto
		  AND ISNULL(ad.Actividad,'') <> ''      
      
	   -- Importe Real
	   SELECT @ImporteReales = SUM(ISNULL(ad.Cantidad,0) * ISNULL(ad.Costo,0)) 
		 FROM Asiste a JOIN AsisteD ad 
		   ON a.ID = ad.ID JOIN MovTipo mt
		   ON 'ASIS' = mt.Modulo AND a.Mov = mt.Mov
		WHERE mt.Clave = 'ASIS.RA'
		  AND a.Estatus NOT IN ('SINAFECTAR', 'CANCELADO') 
		  AND a.Empresa = @Empresa
		  AND ISNULL(ad.Proyecto,'') = @Proyecto
		  AND ISNULL(ad.Actividad,'') <> ''
               
		UPDATE @Informacion 
		   SET Ventas = @Ventas, Compras = @Compras, Gastos = @Gastos, HorasPlaneadas = @HorasPlaneadas,
               HorasReales = @HorasReales, ImportePlaneadas = @ImportePlaneadas, ImporteReales = @ImporteReales 
		 WHERE Proyecto = @Proyecto 
 
		SELECT @Proyecto = MIN(Proyecto) FROM @Informacion WHERE Proyecto > @Proyecto 	 
		  
	 END

   END  

  FETCH NEXT FROM CursorProyecto INTO @Proyecto, @Tipo 

 END

 CLOSE CursorProyecto
 DEALLOCATE CursorProyecto		  


IF @Tipo = 'Proyecto'
 SELECT * FROM @Informacion WHERE Tipo = 'SubProyecto'
ELSE
 SELECT * FROM @Informacion
END

RETURN

GO


/************** [spRepProyectosRecursos] *************/
-- BUG 16101
if exists (select * from sysobjects where id = object_id('dbo.spRepProyectosRecursos') and type = 'P') drop procedure dbo.spRepProyectosRecursos
GO
CREATE PROC spRepProyectosRecursos 
		@EstacionTrabajo int
--//WITH ENCRYPTION
AS BEGIN
 DECLARE
   @Proyecto   varchar(50),
   @Empresa    varchar(5),
   @ProyectoD  varchar(50),
   @ProyectoA  varchar(50),   
   @Moneda     varchar(15),      
   @rowcount   int, 
   @lvl        int, 
   @delcount   int,
   @Tipo       varchar(15)
 
  SELECT @Empresa		=	InfoEmpresa,	
         @ProyectoD		=	InfoProyectoD,
	     @ProyectoA		=	InfoProyectoA,
	     @Moneda			=	InfoMoneda		
    FROM RepParam
   WHERE Estacion = @EstacionTrabajo

  DECLARE @Jerarquia TABLE
  (
	TreeId           int identity primary key,
	Proyecto         varchar(50)   null,
	lvl              int           null, 
	ParentTreeId     varchar(20)   null,
	Path             varchar(max) null, 
	Proyecto_Id_Path varchar(max) null
  )
  
  SET NOCOUNT ON
  SET @lvl=0   
   
  DECLARE CursorProyecto CURSOR FOR
   SELECT Proyecto, Tipo
	 FROM Proy
	WHERE Proyecto BETWEEN @ProyectoD AND @ProyectoA

  OPEN CursorProyecto

  FETCH NEXT FROM CursorProyecto INTO @Proyecto, @Tipo 

  WHILE @@FETCH_STATUS = 0 
  BEGIN

    SELECT @Tipo = Tipo FROM Proy WHERE Proyecto = @Proyecto

    IF @Tipo = 'Proyecto'
    BEGIN
    
	  -- Se obtiene la jerarquia para la consulta    

      INSERT INTO @Jerarquia(Proyecto, lvl) VALUES (@Proyecto, @lvl)
      SET @rowcount=@@ROWCOUNT
      UPDATE @Jerarquia set Path=str(TreeId,10,0) + '.', Proyecto_Id_Path=cast(Proyecto as varchar(50)) + '\'

      WHILE @rowcount>0
      BEGIN
	    SET @lvl=@lvl+1	

	    INSERT INTO @Jerarquia(Proyecto, lvl, ParentTreeId)
		SELECT e.Proyecto, @lvl, t.TreeId
		  FROM Proy e INNER JOIN @Jerarquia t 
            ON e.ProyectoRama=t.Proyecto AND t.lvl=@lvl-1

	    SELECT @rowcount=@@ROWCOUNT, @delcount=@@ROWCOUNT
	    SELECT @rowcount=@rowcount-@delcount
       END  
    END
    ELSE 
	  IF @Tipo = 'SubProyecto'
	  BEGIN
      	     
	     INSERT INTO @Jerarquia(Proyecto, lvl) VALUES (@Proyecto, @lvl)
            
      END

    FETCH NEXT FROM CursorProyecto INTO @Proyecto, @Tipo
  END

  CLOSE CursorProyecto
  DEALLOCATE CursorProyecto
  
  SELECT
           ProyectoD.ID,
           ProyectoD.Actividad,
           ProyectoD.Asunto,
           ProyectoD.Tipo,
           ProyectoD.Categoria,
           ProyectoD.Grupo,
           ProyectoD.Familia,
           ProyectoD.Duracion,
           ProyectoD.DuracionUnidad,
           ProyectoD.DuracionDias,
           ProyectoD.Comienzo,
           ProyectoD.Fin,
           ProyectoD.Estado,
           ISNULL(ProyectoD.Avance,0)/100 Avance,
           ProyectoD.Prioridad,
           Proyecto.Empresa,
           Proyecto.Mov,
           Proyecto.MovID,
           Proyecto.FechaEmision,
           Proyecto.UltimoCambio,
           Proyecto.Concepto,
           Proyecto.Usuario,
           Proyecto.Autorizacion,
           Proyecto.Estatus,
           Proyecto.Referencia,
           Proyecto.Moneda,
           Proyecto.TipoCambio,
    
           ProyectoD.RecursosAsignados,
           
		   CASE ProyectoD.EsFase 
             WHEN 0 THEN ISNULL(ProyectoD.DuracionDias,0) * ISNULL(Proyecto.HorasDia, 8)
             ELSE 0 END HorasPlaneadas,
   
           CASE ProyectoD.EsFase 
             WHEN 0 THEN (SELECT SUM(ISNULL(pr.CostoHora,0) * ISNULL(pd.DuracionDias,0) * ISNULL(pr.HorasDia, 8))
                            FROM ProyectoRecurso pr JOIN ProyectoDRecurso pdr ON pr.ID = pdr.ID 
		                     AND pr.Recurso = pdr.Recurso JOIN ProyectoD pd ON pdr.ID = pd.ID 
		                     AND pdr.Actividad = pd.Actividad
                           WHERE pr.ID = Proyecto.ID
                             AND pdr.Actividad = ProyectoD.Actividad)

             ELSE 0 END CostoHorasPlaneadas,
   
             HorasReales = (SELECT SUM(ISNULL(ad.Cantidad,0)) 
                              FROM Asiste a JOIN AsisteD ad ON a.ID = ad.ID 
							                JOIN MovTipo mt ON 'ASIS' = mt.Modulo AND a.Mov = mt.Mov
                             WHERE mt.Clave = 'ASIS.RA'
                               AND a.Estatus NOT IN ('SINAFECTAR', 'CANCELADO') 
                               AND a.Empresa = Proyecto.Empresa
                               AND ISNULL(ad.Proyecto,'') = Proyecto.Proyecto
                               AND ISNULL(ad.Actividad,'') = ProyectoD. Actividad),
      
             ImporteReal = (SELECT SUM(ISNULL(ad.Cantidad,0) * ISNULL(ad.Costo,0)) 
                              FROM Asiste a JOIN AsisteD ad ON a.ID = ad.ID 
							                JOIN MovTipo mt ON 'ASIS' = mt.Modulo AND a.Mov = mt.Mov
                             WHERE mt.Clave = 'ASIS.RA'
                               AND a.Estatus NOT IN ('SINAFECTAR', 'CANCELADO') 
                               AND a.Empresa = Proyecto.Empresa
                               AND ISNULL(ad.Proyecto,'') = Proyecto.Proyecto
                               AND ISNULL(ad.Actividad,'') = ProyectoD. Actividad),
      
             (SELECT ProyectoRama FROM Proy WHERE Proy.Proyecto = Proyecto.Proyecto) ProyectoRama,
             Proyecto.Proyecto,
             ISNULL(Proyecto.Avance,0) / 100 AvanceProyecto,
             ProyectoD.EsFase 
           FROM ProyectoD JOIN Proyecto ON ProyectoD.ID=Proyecto.ID 
          WHERE Proyecto.Empresa = @Empresa
            AND Proyecto.Estatus IN ('PENDIENTE', 'CONCLUIDO') 
            AND EXISTS (SELECT 1 FROM @Jerarquia WHERE Proyecto = Proyecto.Proyecto)
			AND EXISTS (SELECT Proyecto FROM @Jerarquia)
	   ORDER BY Proyecto.ProyectoRama, Proyecto.Proyecto
    
RETURN
END
GO
/**************** spVerSaldoInicialM2 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerSaldoInicialM2') and type = 'P') drop procedure dbo.spVerSaldoInicialM2
GO             
CREATE PROCEDURE spVerSaldoInicialM2
			@Empresa	char(5),
			@Rama		char(5),
			@Moneda		char(10),
			@Cuenta		char(20),
			@FechaInicial	datetime,
			@SubCuenta	varchar(50) = NULL,
			@Resultado      float = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE 
    @Ejercicio	  	int,
    @Periodo	  	int,
    @EsMonetario	bit,
    @EsUnidades		bit,
    @EsResultados	bit,
    @CargoInicial 	money,
    @AbonoInicial 	money,
    @CargoInicialU 	float,
    @AbonoInicialU 	float,
    @Ok		  	money

  SELECT @SubCuenta = NULLIF(RTRIM(@SubCuenta), '')
  SELECT @SubCuenta = NULLIF(@SubCuenta, '0')

  SELECT @EsMonetario  = EsMonetario,
         @EsUnidades   = EsUnidades,
	 @EsResultados = EsResultados
    FROM Rama
   WHERE Rama = @Rama
  EXEC spPeriodoEjercicio @Empresa, @Rama, @FechaInicial, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT
  EXEC spSaldoInicial @Empresa, @Rama, @Moneda, NULL, @Cuenta, @SubCuenta, @FechaInicial, @EsMonetario, @EsUnidades, @EsResultados, 
       		      @CargoInicial OUTPUT, @AbonoInicial OUTPUT, @CargoInicialU OUTPUT, @AbonoInicialU OUTPUT,
     	     	      @Ok OUTPUT 
 SELECT @Resultado =  CONVERT(money, ISNULL(@CargoInicial, 0.0) - ISNULL(@AbonoInicial, 0.0))
END




GO

/**************** spRepDineroAux ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRepDineroAux') and type = 'P') drop procedure dbo.spRepDineroAux
GO
CREATE PROCEDURE spRepDineroAux
                @Empresa        varchar(5),
                @CuentaD        varchar(10),     
                @CuentaA        varchar(10),
                @FechaD         datetime,       
                @FechaA         datetime,
                @Moneda         varchar(10)  
WITH ENCRYPTION
AS
BEGIN
  DECLARE
    @Cuenta     varchar(10),
    @SaldoI     money,
    @Cargo      money,
    @Abono      money
  DECLARE @Tabla table
                (ID             int,
                 Fecha          datetime,
                 Cargo          money,
                 Abono          money,
                 CtaDinero      varchar(10),
                 Descripcion    varchar(100),
                 NumeroCta      varchar(100),
                 Mov            varchar(20),
                 Uso            varchar(20))
 
  INSERT @Tabla (ID, Fecha, Cargo, Abono, CtaDinero, Descripcion, NumeroCta, Mov, Uso)
  SELECT         d.ID , d.Fecha Fecha, ISNULL(d.Cargo,0), ISNULL(d.Abono,0), c.CtaDinero, c.Descripcion, c.NumeroCta , d.Mov, c.Uso
    FROM DineroAux  d JOIN CtaDinero  c ON d.CtaDinero=c.CtaDinero
   WHERE d.Empresa= @Empresa
     AND d.Moneda = ISNULL(@Moneda,d.Moneda)
     AND c.CtaDinero  >= @CuentaD AND c.CtaDinero  <=  @CuentaA
     AND d.Fecha  >=  @FechaD
     AND d.Fecha  <=  @FechaA
  UNION ALL
   SELECT DISTINCT NULL, @FechaA, 0.0, 0.0, CtaDinero, Descripcion, NumeroCta, NULL, Uso
     FROM   CtaDinero
    WHERE CtaDinero  >=  @CuentaD AND CtaDinero  <=  @CuentaA
      AND CtaDinero NOT IN(SELECT DISTINCT CtaDinero FROM DineroAux WHERE Empresa = @Empresa AND Moneda = ISNULL(@Moneda,Moneda)  AND Fecha  >=  @FechaD  AND Fecha  <=  @FechaA)
      AND Empresa = @Empresa
      AND Moneda = ISNULL(@Moneda,Moneda)
  
    DECLARE crCuenta CURSOR FOR
     SELECT  CtaDinero, Cargo, Abono
       FROM @Tabla
    OPEN crCuenta
    FETCH NEXT FROM crCuenta INTO @Cuenta, @Cargo, @Abono
    WHILE @@FETCH_STATUS = 0
    BEGIN
      EXEC spVerSaldoInicialM2 @Empresa, 'DIN', @Moneda, @Cuenta, @FechaD,NULL,@SaldoI output
     
      IF ISNULL(@SaldoI,0) = 0.0 AND ISNULL(@Cargo,0.0) = 0.0 AND ISNULL(@Abono,0.0) = 0.0
        DELETE @Tabla WHERE CtaDinero = @Cuenta
 
      FETCH NEXT FROM crCuenta INTO @Cuenta, @Cargo, @Abono
    END
    CLOSE crCuenta
    DEALLOCATE crCuenta     
   
   
   SELECT ID, Fecha, Cargo, Abono, CtaDinero, Descripcion, NumeroCta, Mov, Uso
     FROM @Tabla
   ORDER BY CtaDinero, Fecha, ID
  RETURN
END
GO
 
 
/**************** spRepDineroAuxDesglosado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRepDineroAuxDesglosado') and type = 'P') drop procedure dbo.spRepDineroAuxDesglosado
GO
CREATE PROCEDURE spRepDineroAuxDesglosado
                @Empresa        varchar(5),
                @CuentaD        varchar(10),     
                @CuentaA        varchar(10),
                @FechaD         datetime,       
                @FechaA         datetime,
                @Moneda         varchar(10),               
                @Mov            varchar(20),
                @Uso            varchar(20)   
WITH ENCRYPTION
AS
BEGIN
  DECLARE
    @Cuenta     varchar(10),
    @SaldoI     money,
    @Cargo      money,
    @Abono      money
 
  DECLARE @Tabla table
                (ID             int,
                 Fecha          datetime,
                 Cargo          money,
                 Abono          money,
                 CtaDinero      varchar(10),
                 Descripcion    varchar(100),
                 NumeroCta      varchar(100),
                 Mov            varchar(20),
                 MovID          varchar(20),
                 Uso            varchar(20),
                 ModuloID       int,
                 EsCancelacion  bit)
                
   IF UPPER(@Mov) IN ('0', 'NULL', '(TODOS)','') SELECT @Mov = NULL                
   IF UPPER(@Uso) IN ('0', 'NULL', '(TODOS)','') SELECT @Uso = NULL                
  
  INSERT @Tabla (ID, Fecha, Cargo, Abono, CtaDinero, Descripcion, NumeroCta, Mov,  MovID,  Uso, ModuloID,EsCancelacion)
  SELECT        d.ID , d.Fecha Fecha, ISNULL(d.Cargo,0), ISNULL(d.Abono,0), c.CtaDinero, c.Descripcion, c.NumeroCta , d.Mov, d.MovID,  c.Uso, d.ModuloID, ISNULL(d.EsCancelacion,0)
    FROM DineroAux  d JOIN CtaDinero  c ON d.CtaDinero=c.CtaDinero
   WHERE d.Empresa= @Empresa
     AND d.Moneda = ISNULL(@Moneda,d.Moneda)
     AND c.CtaDinero  >= @CuentaD AND c.CtaDinero  <=  @CuentaA
     AND d.Fecha  >=  @FechaD
     AND d.Fecha  <=  @FechaA
     AND d.Mov  = ISNULL(@Mov,d.Mov)
     AND ISNULL(c.Uso,'')  = ISNULL(@Uso,ISNULL(c.Uso,''))
  UNION ALL
   SELECT DISTINCT NULL, @FechaA, 0.0, 0.0, CtaDinero, Descripcion, NumeroCta, NULL, NULL, Uso, NULL,0 
     FROM   CtaDinero
    WHERE CtaDinero  >=  @CuentaD AND CtaDinero  <=  @CuentaA
    AND CtaDinero NOT IN(SELECT DISTINCT CtaDinero FROM DineroAux WHERE Empresa = @Empresa AND Moneda = ISNULL(@Moneda,Moneda)  AND Fecha  >=  @FechaD  AND Fecha  <=  @FechaA  AND Mov  = ISNULL(@Mov,Mov))
    AND Empresa = @Empresa 
    AND ISNULL(Uso,'') = ISNULL(@Uso,ISNULL(Uso,''))
    AND Moneda = ISNULL(@Moneda,Moneda)
   
    DECLARE crCuenta CURSOR FOR
     SELECT  CtaDinero, Cargo, Abono
       FROM @Tabla
    OPEN crCuenta
    FETCH NEXT FROM crCuenta INTO @Cuenta, @Cargo, @Abono
    WHILE @@FETCH_STATUS = 0
    BEGIN
      EXEC spVerSaldoInicialM2 @Empresa, 'DIN', @Moneda, @Cuenta, @FechaD,NULL,@SaldoI output
 
      IF ISNULL(@SaldoI,0) = 0.0 AND ISNULL(@Cargo,0.0) = 0.0 AND ISNULL(@Abono,0.0) = 0.0
        DELETE @Tabla WHERE CtaDinero = @Cuenta
 
      FETCH NEXT FROM crCuenta INTO @Cuenta, @Cargo, @Abono
    END
    CLOSE crCuenta
    DEALLOCATE crCuenta    
   
   
   SELECT ID, Fecha, Cargo, Abono, CtaDinero, Descripcion, NumeroCta, Mov,  MovID,  Uso, ModuloID, EsCancelacion
     FROM @Tabla
   ORDER BY CtaDinero, Fecha, ID
  RETURN
END
GO

--EXEC spReporteKardex 0, 'DEMO', 0, 'Promedio', '01/01/2015', '01/06/2015', '1', 'z', '(TODAS)', '(TODOS)', '(TODOS)', '(Todos)', '(Todos)', '(Todos)', '(Todos)', '(Todos)'
/**************** spReporteKardex ****************/
if exists (select * from sysobjects where id = object_id('dbo.spReporteKardex') and type = 'P') drop procedure dbo.spReporteKardex
GO             
CREATE PROCEDURE spReporteKardex
			@Estacion	int,
			@Empresa varchar(10),
			@Sucursal int,
			@Costeo varchar(20),
			@FechaD datetime,
			@FechaA datetime,
			@ArticuloD varchar(20),
			@ArticuloA varchar(20),
			@ArtOpcion varchar(20),
			@ArtSerieLote varchar(50),
			@Almacen  varchar(20),
			@ArtCategoria varchar(50),
			@ArtGrupo varchar(50),
			@ArtFamilia varchar(50),
			@ArtFabricante varchar(50),
			@ArtLinea varchar(20)

--//WITH ENCRYPTION
AS BEGIN
DECLARE 
  @ID int, @Mov varchar(20), @Articulo varchar(20),
  @Subcuenta varchar(20), @CargoU float, @AbonoU float, @Cargo money, @Abono money,
  @AnteriorID int,
  @AnteriorSaldoU float, 
  @AnteriorSaldoM money,
  @SaldoU float, 
  @SaldoM money,
  @CostoPromedio float,
  @CosteoOpcion bit,
  @CosteoSeries bit,
  @CosteoLotes bit,
  @SerieLote varchar(50),
  @ArtTipo varchar(20),
  @ArtSubcuenta varchar(20),
  @CostoEstandar float,
  @CostoReposicion float,
  @FormaCosteo varchar(20),
  @TipoCosteo varchar(20),
  @Continuar bit,
  @IDR Int


  SET ANSI_DEFAULTS OFF
  SET ARITHABORT OFF

  SELECT @Continuar = 1

  IF @ArtOpcion = '(TODAS)' SELECT @ArtOpcion  = NULL
  IF @ArtCategoria = '(Todos)' SELECT @ArtCategoria = NULL
  IF @ArtGrupo = '(Todos)' SELECT @ArtGrupo = NULL
  IF @ArtFamilia = '(Todos)' SELECT @ArtFamilia = NULL
  IF @ArtFabricante = '(Todos)' SELECT @ArtFabricante = NULL
  IF @ArtLinea = '(Todos)' SELECT @ArtLinea = NULL
  IF @Almacen = '(TODOS)' SELECT @Almacen = NULL
  IF @ArtSerieLote = '(TODOS)' SELECT @ArtSerieLote  = NULL

  CREATE TABLE #ReporteKardex (
  IDR			    int			Identity(1,1),
  ID				Int			NULL,
  Empresa			varchar(10) COLLATE DATABASE_DEFAULT NULL,
  Sucursal			int			NULL,
  Modulo			varchar(10) COLLATE DATABASE_DEFAULT NULL,
  ModuloID			int			NULL,
  Mov				varchar(20) COLLATE DATABASE_DEFAULT NULL,
  MovID				varchar(20) COLLATE DATABASE_DEFAULT NULL,
  Almacen			varchar(20) COLLATE DATABASE_DEFAULT NULL,
  Subgrupo			varchar(20) COLLATE DATABASE_DEFAULT NULL,
  FechaSistema		datetime	NULL,
  FechaEmision		datetime	NULL,
  Articulo			varchar(20) COLLATE DATABASE_DEFAULT NULL,
  Subcuenta			varchar(20) COLLATE DATABASE_DEFAULT NULL,
  SerieLote			varchar(50) COLLATE DATABASE_DEFAULT NULL,
  ArtTipo			varchar(20) COLLATE DATABASE_DEFAULT NULL,
  CostoUnitario		float		NULL,
  CargoU			float		NULL,
  AbonoU			float		NULL,
  Cargo				money		NULL,
  Abono				money		NULL,
  SaldoU			float		NULL,
  SaldoM			money		NULL,
  CostoPromedio		float		NULL,
  CostoEstandar		float		NULL,
  CostoReposicion	float		NULL
  )

  SELECT @Subcuenta = @ArtOpcion
  TRUNCATE TABLE #ReporteKardex

  SELECT 
  @FormaCosteo = FormaCosteo,
  @TipoCosteo = TipoCosteo,
  @CosteoOpcion = CosteoNivelSubCuenta, 
         @CosteoSeries = CosteoSeries,
          @CosteoLotes = CosteoLotes
  FROM EmpresaCfg WHERE Empresa = @Empresa

   IF @FormaCosteo = 'Empresa' AND @Costeo != @TipoCosteo 
    SELECT @Continuar = 0

  IF @Continuar = 1
  BEGIN
   -- Costeo de Lotes
    IF @CosteoSeries = 1 OR @CosteoLotes = 1
      INSERT #ReporteKardex (ID, Empresa, Sucursal, Modulo, ModuloID, Mov, MovID, Almacen, Subgrupo, FechaSistema, FechaEmision, Articulo, Subcuenta, SerieLote, ArtTipo, CostoUnitario, CargoU, AbonoU, Cargo, Abono, SaldoU, SaldoM, CostoPromedio)
      SELECT 'ID' = MAX(u.ID), 'Empresa' = MAX(u.Empresa), 'Sucursal' = MAX(u.Sucursal), 'Modulo'=NULL, 'ModuloID'=NULL, 'Mov' = 'SALDO INICIAL', 'MOVID'=NULL,  /*Moneda,*/ 'Almacen'=NULL, 'SubGrupo'=NULL, 
      'Fechasistema'= @FechaD,
      'FechaEmision' =@FechaD,
      u.Cuenta, NULLIF(u.Subcuenta,''), s.SerieLote, MAX(a.Tipo),
      'CostoUnitario' = NULL,
      'CargoU'= NULL,--SUM(cargoU),
      'AbonoU'= NULL,--SUM(AbonoU),
      'Cargo'= NULL,--SUM(Cargo),
      'Abono'= NULL,--SUM(Abono),
      'SaldoU'=ISNULL(SUM(CASE WHEN u.CargoU > 0 THEN s.Cantidad ELSE 0 END),0) - ISNULL(SUM(CASE WHEN u.AbonoU > 0 THEN s.Cantidad ELSE 0 END),0), 
      'SaldoM' = ISNULL(SUM(CASE WHEN u.CargoU > 0 THEN s.Cantidad*(u.Cargo/u.CargoU) ELSE 0 END),0) - ISNULL(SUM(CASE WHEN u.AbonoU > 0 THEN s.Cantidad*(u.Abono/u.AbonoU) ELSE 0 END),0),
      'CostoPromedio'= ROUND(( (ISNULL(SUM(CASE WHEN u.CargoU > 0 THEN s.Cantidad*(u.Cargo/u.CargoU) ELSE 0 END),0) - ISNULL(SUM(CASE WHEN u.AbonoU > 0 THEN s.Cantidad*(u.Abono/u.AbonoU) ELSE 0 END),0)) / (ISNULL(SUM(CASE WHEN u.CargoU > 0 THEN s.Cantidad ELSE 0 END),0) - ISNULL(SUM(CASE WHEN u.AbonoU > 0 THEN s.Cantidad ELSE 0 END),0)) ), 2) 
      FROM Art a
       JOIN Auxiliaru u ON a.Articulo = u.Cuenta
       JOIN SerieloteMov s ON u.modulo = s.modulo AND u.ModuloID = s.ID AND u.Cuenta = s.Articulo AND ISNULL(u.SubCuenta, '') = ISNULL(s.SubCuenta, '') AND s.RenglonID = dbo.fnRenglonID(u.modulo, u.ModuloID, u.REnglon, u.RenglonSub)
      WHERE u.Empresa = @Empresa AND u.Sucursal = @Sucursal 
	  	AND u.Rama = 'INV'
        AND u.cuenta >= @ArticuloD AND u.Cuenta <= @ArticuloA 
        AND u.Subcuenta IN (ISNULL(@Subcuenta,u.Subcuenta)) 
        AND s.SerieLote IN (ISNULL(@ArtSerieLote,s.SerieLote)) 
        AND dbo.fnFechaREgistro(u.Modulo, u.ModuloID) < @FechaD
        AND a.Estatus = 'ALTA'
        AND a.Familia IN (ISNULL(@ArtFamilia, a.Familia))
        AND a.Grupo IN (ISNULL(@ArtGrupo, a.Grupo))
        AND a.Categoria IN (ISNULL(@ArtCategoria, a.Categoria))
        AND a.Fabricante IN (ISNULL(@ArtFabricante, a.Fabricante))
        AND a.Linea IN (ISNULL(@ArtLinea, a.Linea)) 
        AND a.Tipo IN (CASE WHEN @CosteoLotes=1 AND a.Tipo = 'LOTE' THEN 'LOTE' ELSE (CASE WHEN @CosteoSeries=1 AND a.Tipo = 'SERIE' THEN 'SERIE' ELSE '' END) END) 
        AND a.TipoCosteo IN (CASE WHEN @FormaCosteo = 'Articulo' THEN @Costeo ELSE a.TipoCosteo END) 
      GROUP BY u.Cuenta, u.Subcuenta, s.SerieLote
    ORDER BY u.Cuenta, CASE WHEN @CosteoOpcion = 1 THEN u.Subcuenta ELSE NULL END, s.SerieLote


  -- Sin costear Series/Lotes (No se despliegan las series lotes)
    INSERT #ReporteKardex (ID, Empresa, Sucursal, Modulo, ModuloID, Mov, MovID, Almacen, Subgrupo, FechaSistema, FechaEmision, Articulo, Subcuenta, SerieLote, ArtTipo, CostoUnitario, CargoU, AbonoU, Cargo, Abono, SaldoU, SaldoM, CostoPromedio)
    SELECT 'ID' = MAX(ID), 'Empresa' = MAX(u.Empresa), 'Sucursal' = MAX(u.Sucursal), 'Modulo'=NULL, 'ModuloID'=NULL, 'Mov' = 'SALDO INICIAL', 'MOVID'=NULL,  /*Moneda,*/ 'Almacen'=NULL, 'SubGrupo'=NULL, 
    'Fechasistema'= @FechaD,
    'FechaEmision' =@FechaD,
    u.Cuenta, NULLIF(u.Subcuenta,''), 'SerieLote'=NULL, MAX(a.Tipo),
    'CostoUnitario' = NULL,
    'CargoU'= NULL,--SUM(cargoU),
    'AbonoU'= NULL,--SUM(AbonoU),
    'Cargo'= NULL,--SUM(Cargo),
    'Abono'= NULL,--SUM(Abono),
    'SaldoU'=ISNULL(SUM(u.CargoU),0) - ISNULL(SUM(u.AbonoU),0), 
    'SaldoM' = ISNULL(SUM(u.Cargo),0) - ISNULL(SUM(u.Abono),0),
    'CostoPromedio'= ROUND( (ISNULL(SUM(u.Cargo),0) - ISNULL(SUM(u.Abono),0))  / ( ISNULL(SUM(u.CargoU),0) - ISNULL(SUM(u.AbonoU),0)) , 2) 
    FROM Art a
     JOIN Auxiliaru u ON a.Articulo = u.Cuenta
    WHERE u.Empresa = @Empresa AND u.Sucursal = @Sucursal 
      AND u.Rama = 'INV'
      AND u.cuenta >= @ArticuloD AND u.Cuenta <= @ArticuloA 
      AND u.Subcuenta IN (ISNULL(@Subcuenta,u.Subcuenta)) 
      AND dbo.fnFechaREgistro(u.Modulo, u.ModuloID) < @FechaD
      AND a.Estatus = 'ALTA'
      AND a.Familia IN (ISNULL(@ArtFamilia, a.Familia))
      AND a.Grupo IN (ISNULL(@ArtGrupo, a.Grupo))
      AND a.Categoria IN (ISNULL(@ArtCategoria, a.Categoria))
      AND a.Fabricante IN (ISNULL(@ArtFabricante, a.Fabricante))
      AND a.Linea IN (ISNULL(@ArtLinea, a.Linea))
      AND a.Tipo NOT IN (CASE WHEN @CosteoLotes=1 THEN 'LOTE'  ELSE '' END) 
      AND a.Tipo NOT IN (CASE WHEN @CosteoSeries=1 THEN 'SERIE' ELSE '' END)
	  AND a.TipoCosteo IN (CASE WHEN @FormaCosteo = 'Articulo' THEN @Costeo ELSE a.TipoCosteo END) 
    GROUP BY u.Cuenta, u.Subcuenta
    ORDER BY u.Cuenta, CASE WHEN @CosteoOpcion = 1 THEN u.Subcuenta ELSE NULL END

  -- Insertar Registros de Auxiliares dentro del periodo consultado
  -- Costeo de SerieLotes 
    IF @CosteoSeries = 1 OR @CosteoLotes = 1
    INSERT #ReporteKardex (ID, Empresa, Sucursal, Modulo, ModuloID, Mov, MovID, Almacen, Subgrupo, FechaSistema, FechaEmision, Articulo, Subcuenta, SerieLote, ArtTipo, CostoUnitario, CargoU, AbonoU, Cargo, Abono, SaldoU, SaldoM, CostoPromedio)
    SELECT u.ID, u.Empresa, u.Sucursal, u.Modulo, u.ModuloID, u.Mov, u.MovID, /*Moneda,*/ u.Grupo, u.SubGrupo, 
    dbo.fnFechaREgistro(u.Modulo, u.ModuloID),
    u.Fecha,
    u.Cuenta, NULLIF(u.Subcuenta,''), s.SerieLote, a.Tipo,
    'CostoUnitario'=ISNULL(u.Cargo/u.CargoU, u.Abono/u.AbonoU) ,
    'CargoU'=ISNULL((CASE WHEN u.CargoU > 0 THEN s.Cantidad ELSE 0 END),0),
    'AbonoU'= ISNULL((CASE WHEN u.AbonoU > 0 THEN s.Cantidad ELSE 0 END),0), 
    'Cargo' = ISNULL((CASE WHEN u.CargoU > 0 THEN s.Cantidad*(u.Cargo/u.CargoU) ELSE 0 END),0),
	'Abono' = ISNULL((CASE WHEN u.AbonoU > 0 THEN s.Cantidad*(u.Abono/u.AbonoU) ELSE 0 END),0),
    'SaldoU' = NULL,
    'SaldoM' = NULL,
    'CostoPromedio' = NULL
    FROM Art a
      JOIN Auxiliaru u ON a.Articulo = u.Cuenta
      JOIN SerieloteMov s ON u.modulo = s.modulo AND u.ModuloID = s.ID AND u.Cuenta = s.Articulo AND ISNULL(u.SubCuenta, '') = ISNULL(s.SubCuenta, '') AND s.RenglonID = dbo.fnRenglonID(u.modulo, u.ModuloID, u.REnglon, u.RenglonSub)
      AND a.TipoCosteo IN (CASE WHEN @FormaCosteo = 'Articulo' THEN @Costeo ELSE a.TipoCosteo END) 
    WHERE 
      u.Empresa = @Empresa AND u.Sucursal = @Sucursal 
      AND u.Rama = 'INV'
      AND u.cuenta >= @ArticuloD AND u.Cuenta <= @ArticuloA
  --	AND NULLIF(u.Subcuenta,'') IN (ISNULL(@Subcuenta,NULLIF(u.Subcuenta,''))) 
      AND u.Subcuenta IN (ISNULL(@Subcuenta,u.Subcuenta)) 
      AND s.SerieLote IN (ISNULL(@ArtSerieLote,s.SerieLote)) 
      AND dbo.fnFechaREgistro(u.Modulo, u.ModuloID) BETWEEN @FechaD AND @FechaA
      AND a.Familia IN (ISNULL(@ArtFamilia, a.Familia))
      AND a.Grupo IN (ISNULL(@ArtGrupo, a.Grupo))
      AND a.Categoria IN (ISNULL(@ArtCategoria, a.Categoria))
      AND a.Fabricante IN (ISNULL(@ArtFabricante, a.Fabricante))
      AND a.Linea IN (ISNULL(@ArtLinea, a.Linea))
      AND a.Estatus = 'ALTA'
	  AND a.Tipo IN (CASE WHEN @CosteoLotes=1 AND a.Tipo = 'LOTE' THEN 'LOTE' ELSE (CASE WHEN @CosteoSeries=1 AND a.Tipo = 'SERIE' THEN 'SERIE' ELSE '' END) END) 
    ORDER BY u.Cuenta, CASE WHEN @CosteoOpcion = 1 THEN u.Subcuenta ELSE NULL END, u.ID

-- Insertar Registros de Auxiliares dentro del periodo consultado
-- Sin Costear Lotes (No se despliegan las Series lotes)
    INSERT #ReporteKardex (ID, Empresa, Sucursal, Modulo, ModuloID, Mov, MovID, Almacen, Subgrupo, FechaSistema, FechaEmision, Articulo, Subcuenta, SerieLote, ArtTipo, CostoUnitario, CargoU, AbonoU, Cargo, Abono, SaldoU, SaldoM, CostoPromedio)
    SELECT u.ID, u.Empresa, u.Sucursal, u.Modulo, u.ModuloID, u.Mov, u.MovID, /*Moneda,*/ u.Grupo, u.SubGrupo, 
    dbo.fnFechaREgistro(u.Modulo, u.ModuloID),
    u.Fecha,
    u.Cuenta, NULLIF(u.Subcuenta,''), 'SerieLote'= NULL, a.Tipo, 
    'CostoUnitario'=ISNULL(u.Cargo/u.CargoU, u.Abono/u.AbonoU) ,
    u.CargoU, u.AbonoU, u.Cargo, u.Abono, 
    'SaldoU' = NULL,
    'SaldoM' = NULL,
    'CostoPromedio' = NULL
    FROM Art a
      JOIN Auxiliaru u ON a.Articulo = u.Cuenta
    WHERE 
      u.Empresa = @Empresa AND u.Sucursal = @Sucursal 
      AND u.Rama = 'INV'
      AND u.cuenta >= @ArticuloD AND u.Cuenta <= @ArticuloA
--	AND NULLIF(u.Subcuenta,'') IN (ISNULL(@Subcuenta,NULLIF(u.Subcuenta,''))) 
      AND u.Subcuenta IN (ISNULL(@Subcuenta,u.Subcuenta)) 
      AND dbo.fnFechaREgistro(u.Modulo, u.ModuloID) BETWEEN @FechaD AND @FechaA
      AND a.Familia IN (ISNULL(@ArtFamilia, a.Familia))
      AND a.Grupo IN (ISNULL(@ArtGrupo, a.Grupo))
      AND a.Categoria IN (ISNULL(@ArtCategoria, a.Categoria))
      AND a.Fabricante IN (ISNULL(@ArtFabricante, a.Fabricante))
      AND a.Linea IN (ISNULL(@ArtLinea, a.Linea))
      AND a.Estatus = 'ALTA'
	  AND a.Tipo NOT IN (CASE WHEN @CosteoLotes=1 THEN 'LOTE'  ELSE '' END) 
	  AND a.Tipo NOT IN (CASE WHEN @CosteoSeries=1 THEN 'SERIE' ELSE '' END)
	  AND a.TipoCosteo IN (CASE WHEN @FormaCosteo = 'Articulo' THEN @Costeo ELSE a.TipoCosteo END) 
    ORDER BY u.Cuenta, CASE WHEN @CosteoOpcion = 1 THEN u.Subcuenta ELSE NULL END, u.ID
      
    DECLARE crReporteKardex CURSOR FOR         
     SELECT IDR, ID, Mov, Articulo, Subcuenta, SerieLote, ArtTipo, CargoU, AbonoU, Cargo, Abono
       FROM #ReporteKardex ORDER BY ID
    OPEN crReporteKardex          
    FETCH NEXT FROM crReporteKardex INTO @IDR, @ID, @Mov, @Articulo, @ArtSubcuenta, @SerieLote, @ArtTipo, @CargoU, @AbonoU, @Cargo, @Abono
    WHILE @@FETCH_STATUS = 0        
    BEGIN
      IF @Mov != 'SALDO INICIAL'
      BEGIN
        SELECT @AnteriorID = NULL, @AnteriorSaldoU = 0, @AnteriorSaldoM = 0, @SaldoU = 0, @SaldoM = 0 

        IF ((@ArtTipo = 'SERIE' AND @CosteoSeries=1) OR (@ArtTipo = 'LOTE' AND @CosteoLotes = 1)) AND @CosteoOpcion = 1 
          SELECT @AnteriorID = MAX(IDR) FROM #ReporteKardex WHERE ID < @ID AND Articulo = @Articulo  AND Subcuenta IN (ISNULL(@ArtSubcuenta,Subcuenta)) AND SerieLote = @SerieLote
        ELSE  IF ((@ArtTipo = 'SERIE' AND @CosteoSeries=1) OR (@ArtTipo = 'LOTE' AND @CosteoLotes = 1))
	      SELECT @AnteriorID = MAX(IDR) FROM #ReporteKardex WHERE ID < @ID AND Articulo = @Articulo AND SerieLote = @SerieLote
        ELSE IF @CosteoOpcion = 1  
	      SELECT @AnteriorID = MAX(IDR) FROM #ReporteKardex WHERE ID < @ID AND Articulo = @Articulo  AND Subcuenta IN (ISNULL(@ArtSubcuenta,Subcuenta))  
 	    ELSE 
	      SELECT @AnteriorID = MAX(IDR) FROM #ReporteKardex WHERE ID < @ID AND Articulo = @Articulo 
	   	 
        SELECT @AnteriorSaldoU = SaldoU, @AnteriorSaldoM = SaldoM FROM #ReporteKardex WHERE IDR = @AnteriorID
        SELECT @SaldoU = ISNULL(@AnteriorSaldoU,0.0) + ISNULL(@CargoU,0.0) - ISNULL(@AbonoU, 0.0)  
        SELECT @SaldoM = ISNULL(@AnteriorSaldoM,0.0) + ISNULL(@Cargo,0.0) - ISNULL(@Abono, 0.0)
        SELECT @CostoPromedio = @SaldoM / @SaldoU

        IF @Costeo = 'Promedio'   UPDATE #ReporteKardex SET SaldoU = @SaldoU, SaldoM = @SaldoM, CostoPromedio = @CostoPromedio WHERE IDR = @IDR 
        ELSE
        IF @Costeo = 'Estandar'   UPDATE #ReporteKardex SET SaldoU = @SaldoU, SaldoM = @SaldoM, CostoEstandar = CostoUnitario WHERE IDR = @IDR
        ELSE
        IF @Costeo = 'Reposicion' UPDATE #ReporteKardex SET SaldoU = @SaldoU, SaldoM = @SaldoM, CostoReposicion = CostoUnitario WHERE IDR = @IDR

      END
    FETCH NEXT FROM crReporteKardex INTO @IDR, @ID, @Mov, @Articulo, @ArtSubcuenta, @SerieLote, @ArtTipo, @CargoU, @AbonoU, @Cargo, @Abono
    END        
    CLOSE crReporteKardex  
    DEALLOCATE crReporteKardex       
  END

  SELECT r.*, a.Descripcion1 FROM #REporteKardex r
  JOIN Art a ON r.Articulo = a.Articulo
   WHERE r.Almacen IN (ISNULL(@Almacen,r.Almacen))
   ORDER BY r.Articulo, CASE WHEN @CosteoOpcion = 1 THEN r.Subcuenta ELSE NULL END, r.ID

END
GO

--EXEC spReporteKardexUEPS 5, 'DEMO', 0, '01/01/2015', '30/04/2015','1','TOALLA','(TODAS)','(TODOS)','(Todos)','(Todos)','(Todos)','(Todos)','(Todos)'
/**************** spReporteKardexUEPS ****************/
if exists (select * from sysobjects where id = object_id('dbo.spReporteKardexUEPS') and type = 'P') drop procedure dbo.spReporteKardexUEPS
GO             
CREATE PROCEDURE spReporteKardexUEPS
			@Estacion	int,
			@Empresa varchar(10),
			@Sucursal int,
			@FechaD datetime,
			@FechaA datetime,
			@ArticuloD varchar(20),
			@ArticuloA varchar(20),
			@ArtOpcion varchar(20),
			@Almacen  varchar(20),
			@ArtCategoria varchar(50),
			@ArtGrupo varchar(50),
			@ArtFamilia varchar(50),
			@ArtFabricante varchar(50),
			@ArtLinea varchar(20)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @ID				int, 
  @Mov				varchar(20), 
  @Articulo			varchar(20), 
  @FechaSistema datetime,
  @Subcuenta varchar(20),
  @ArtSubcuenta		varchar(20),
  @IDCapa			int, 
  @CapaModulo		varchar(20), 
  @CapaMov			varchar(20), 
  @CapaMovID		varchar(20), 
  @CapaArticulo		varchar(20), 
  @CapaSubcuenta	varchar(20), 
  @CapaExistencia	float, 
  @CapaCosto		float, 
  @CapaValor		money,
  @CapaSaldoU		float,
  @CapaSaldoM		money,
  @IDSaldoCapa		int,
  @IdReporteK		int,
  @SaldoREgistroU	float,
  @SaldoRegistroM	float, 
  @CostoUEPS		float,
  @CapaExistenciaNueva float, 
  @CapaValorNueva	money,
  @UltimoIdReporteK int,
  @UltimoID			int

-- NOTA En UEPS No existe Costeo a nivel Serie Lote

  IF @ArtOpcion = '(TODAS)' SELECT @ArtOpcion  = NULL
  IF @ArtCategoria = '(Todos)' SELECT @ArtCategoria = NULL
  IF @ArtGrupo = '(Todos)' SELECT @ArtGrupo = NULL
  IF @ArtFamilia = '(Todos)' SELECT @ArtFamilia = NULL
  IF @ArtFabricante = '(Todos)' SELECT @ArtFabricante = NULL
  IF @ArtLinea = '(Todos)' SELECT @ArtLinea = NULL
  IF @Almacen = '(TODOS)' SELECT @Almacen = NULL

  SELECT @Subcuenta = @ArtOpcion

  CREATE TABLE #ReporteKardex (
  IDR			int			Identity(1,1),
  ID			Int			NULL,
  Empresa		varchar(10) COLLATE DATABASE_DEFAULT NULL,
  Sucursal		int			NULL,
  Modulo		varchar(10) COLLATE DATABASE_DEFAULT NULL,
  ModuloID		int			NULL,
  Mov			varchar(20) COLLATE DATABASE_DEFAULT NULL,
  MovID			varchar(20) COLLATE DATABASE_DEFAULT NULL,
  Almacen		varchar(20) COLLATE DATABASE_DEFAULT NULL,
  Subgrupo		varchar(20) COLLATE DATABASE_DEFAULT NULL,
  FechaSistema	datetime	NULL,
  FechaEmision	datetime	NULL,
  Articulo		varchar(20) COLLATE DATABASE_DEFAULT NULL,
  Subcuenta		varchar(20) COLLATE DATABASE_DEFAULT NULL,
  CostoUnitario float		NULL,
  CargoU		float		NULL,
  AbonoU		float		NULL,
  Cargo			money		NULL,
  Abono			money		NULL,
  SaldoU		float		NULL,
  SaldoM		money		NULL,
  CostoPromedio float		NULL,
  CostoUEPS		float		NULL,
  CapaModulo	varchar(10) COLLATE DATABASE_DEFAULT NULL,
  CapaMov		varchar(20) COLLATE DATABASE_DEFAULT NULL,
  CapaMovID		varchar(20) COLLATE DATABASE_DEFAULT NULL
  )

  CREATE TABLE #SaldoCapa
  (IDR			int Identity(1,1),
  ID			int NULL,
  modulo		varchar(10) COLLATE DATABASE_DEFAULT NULL,
  Mov			varchar(20) COLLATE DATABASE_DEFAULT NULL,
  MovID			varchar(20) COLLATE DATABASE_DEFAULT NULL,
  Articulo		varchar(20) COLLATE DATABASE_DEFAULT NULL,
  Subcuenta		varchar(20) COLLATE DATABASE_DEFAULT NULL,
  Existencia	float NULL,
  Costo			float NULL,
  Valor			float NULL)

  TRUNCATE TABLE #ReporteKardex

  INSERT #ReporteKardex (ID, Empresa, Sucursal, Modulo, ModuloID, Mov, MovID, Almacen, Subgrupo, 
  FechaSistema, FechaEmision, Articulo, Subcuenta, 
  CostoUnitario, CargoU, AbonoU, --Cargo, Abono, SaldoU, SaldoM, CostoPromedio,
  CapaModulo, CapaMov, CapaMovID, SaldoU, SaldoM, CostoUEPS)
  SELECT MAX(u.ID), u.Empresa, u.Sucursal, NULL, NULL, 'SALDO INICIAL', NULL, /*Moneda,*/ NULL, NULL, 
  @FechaD,
  @FechaD,
  u.Cuenta,  NULLIF(u.Subcuenta,''), MAX(i.costo), NULL, NULL, i.Modulo, i.Mov, i.MovID, ISNULL(SUM(c.CargoU),0) - ISNULL(SUM(c.AbonoU),0),  MAX(i.costo)*(ISNULL(SUM(c.CargoU),0)-ISNULL(SUM(c.AbonoU),0)) , MAX(i.costo)
  FROM Auxiliaru u
  JOIN InvCapaAux c ON u.Modulo = c.Modulo AND u.ModuloID = c.ModuloID
  JOIN InvCapa i ON c.ID = i.ID AND i.Sistema = 'U' AND u.Cuenta = i.Articulo AND u.subcuenta = i.Subcuenta
  JOIN Art a ON a.Articulo = u.Cuenta
  WHERE  u.cuenta BETWEEN @ArticuloD AND @ArticuloA 
    AND u.Rama = 'INV'
    AND u.Subcuenta IN (ISNULL(@Subcuenta,u.Subcuenta)) 
    AND dbo.fnFechaREgistro(u.Modulo, u.ModuloID) < @FechaD
    AND a.Estatus = 'ALTA'
    AND a.Familia IN (ISNULL(@ArtFamilia, a.Familia))
    AND a.Grupo IN (ISNULL(@ArtGrupo, a.Grupo))
    AND a.Categoria IN (ISNULL(@ArtCategoria, a.Categoria))
    AND a.Fabricante IN (ISNULL(@ArtFabricante, a.Fabricante))
    AND a.Linea IN (ISNULL(@ArtLinea, a.Linea))
  GROUP BY u.Empresa, u.Sucursal, u.Cuenta, u.Subcuenta, i.Modulo, i.Mov, i.MovID

 
  INSERT #ReporteKardex (ID, Empresa, Sucursal, Modulo, ModuloID, Mov, MovID, Almacen, Subgrupo, 
  FechaSistema, FechaEmision, Articulo, Subcuenta, 
  CostoUnitario, CargoU, AbonoU, Cargo, Abono,--, SaldoU, SaldoM, CostoPromedio,
  CapaModulo, CapaMov, CapaMovID, CostoUEPS)
  SELECT u.ID, u.Empresa, u.Sucursal, u.Modulo, u.ModuloID, u.Mov, u.MovID, /*Moneda,*/ u.Grupo, u.SubGrupo, 
  dbo.fnFechaREgistro(u.Modulo, u.ModuloID),
  u.Fecha,
  u.Cuenta,  NULLIF(u.Subcuenta,''), 
  i.costo, MAX(c.CargoU), MAX(c.AbonoU), i.Costo*(MAX(ISNULL(c.CargoU,0))), i.Costo*(MAX(ISNULL(c.AbonoU,0))),-- NULL, NULL, 
  --'CostoUnitario'=ISNULL(u.Cargo/u.CargoU, u.Abono/u.AbonoU) ,
  --u.CargoU, u.AbonoU, u.Cargo, u.Abono, 
  --'SaldoU' = NULL,
  --'SaldoM' = NULL,
  --'CostoPromedio' = NULL
  i.Modulo, i.Mov, i.MovID, i.costo
  FROM Auxiliaru u 
  JOIN  InvCapaAux c ON u.Modulo = c.Modulo AND u.ModuloID = c.ModuloID
  JOIN InvCapa i ON c.ID = i.ID AND i.Sistema = 'U' AND u.Cuenta = i.Articulo AND u.subcuenta = i.Subcuenta
  JOIN Art a ON a.Articulo = u.cuenta
  WHERE u.Empresa = @Empresa AND u.Sucursal = @Sucursal 
    AND u.Rama = 'INV'
    AND u.cuenta >= @ArticuloD AND u.Cuenta <= @ArticuloA 
    AND u.Subcuenta IN (ISNULL(@Subcuenta,u.Subcuenta)) 
    AND dbo.fnFechaREgistro(u.Modulo, u.ModuloID) BETWEEN @FechaD AND @FechaA
    AND a.Estatus = 'ALTA'
    AND a.Familia IN (ISNULL(@ArtFamilia, a.Familia))
    AND a.Grupo IN (ISNULL(@ArtGrupo, a.Grupo))
    AND a.Categoria IN (ISNULL(@ArtCategoria, a.Categoria))
    AND a.Fabricante IN (ISNULL(@ArtFabricante, a.Fabricante))
    AND a.Linea IN (ISNULL(@ArtLinea, a.Linea))
  GROUP BY u.ID, u.Empresa, u.Sucursal, u.Modulo, u.ModuloID, u.Mov, u.MovID, /*Moneda,*/ u.Grupo, u.SubGrupo, 
  dbo.fnFechaREgistro(u.Modulo, u.ModuloID),
  u.Fecha,
  u.Cuenta, u.Subcuenta, i.Modulo, i.Mov, i.MovID,
  i.costo
  ORDER BY u.Cuenta, u.Subcuenta, u.ID

  INSERT INTO #SaldoCapa (ID, Modulo, Mov, MovID, Articulo, Subcuenta, Existencia, Costo, Valor) 
  SELECT Id, CapaModulo, CapaMov, CapaMovID, Articulo, Subcuenta, SaldoU, CostoUEPS, SaldoM 
    FROM #ReporteKardex 
  WHERE Mov = 'SALDO INICIAL' AND SaldoU > 0

  DECLARE crReporteKardex CURSOR FOR         
   SELECT IDR, ID, Articulo, Subcuenta, FechaSistema, CapaModulo, CapaMov, CapaMovID, (ISNULL(CargoU,0) - ISNULL(AbonoU,0)), (ISNULL(Cargo,0) - ISNULL(Abono,0)), CostoUEPS
     FROM #ReporteKardex WHERE mov != 'SALDO INICIAL' 
   --	group by ID, Articulo, Subcuenta 
    ORDER BY ID, Articulo, Subcuenta
  OPEN crReporteKardex          
  FETCH NEXT FROM crReporteKardex INTO @IDReporteK, @ID, @Articulo, @ArtSubcuenta, @FEchaSistema, @Capamodulo, @CapaMov, @CapaMovID, @SaldoRegistroU, @SaldoREgistroM, @CostoUEPS
  WHILE @@FETCH_STATUS = 0        
  BEGIN
    IF @Mov != 'SALDO INICIAL'
    BEGIN
      SELECT @IDSaldoCapa = NULL

      IF @UltimoID = @ID 
        DELETE #ReporteKardex WHERE ID = @ultimoID AND Modulo IS NULL
      SELECT @IDSaldoCapa = IDR FROM #SaldoCapa WHERE Modulo = @CapaModulo AND Mov = @CapaMov AND MovID = @CapaMovID AND Articulo = @Articulo AND Subcuenta = @ArtSubcuenta

      INSERT #ReporteKardex (ID, Empresa, Sucursal, Modulo, ModuloID, Mov, MovID, /*Moneda,*/ Almacen, Subgrupo, 
      FechaSistema, FechaEmision, Articulo, Subcuenta, 
      CostoUnitario, CargoU, AbonoU, --Cargo, Abono, SaldoU, SaldoM, CostoPromedio,
      CapaModulo, CapaMov, CapaMovID, SaldoU, CostoUEPS, SaldoM)
      SELECT @ID, @Empresa, @Sucursal, NULL, NULL, NULL, NULL, /*Moneda,*/ NULL, NULL, 
      @Fechasistema, @Fechasistema, Articulo,  Subcuenta, 
      NULL, NULL, NULL, 
      Modulo, Mov, MovID, Existencia, Costo, Valor 
      FROM #SaldoCapa 
      WHERE IDR NOT IN (@IDSaldoCapa) AND Articulo = @Articulo AND Subcuenta = @ArtSubcuenta 
        AND Existencia > 0
        AND IDR NOT IN (SELECT c.IDR 
		                  FROM #ReporteKardex r 
						  JOIN #SaldoCapa c ON r.CapaModulo = c.Modulo AND r.CapaMov = c.Mov AND c.MovID = r.CapaMovID AND c.Articulo = r.Articulo AND c.Subcuenta = r.Subcuenta
                         WHERE r.ID = @ID AND ModuloID IS NOT NULL ) 

      -- Si no existe la capa
      IF @IDSaldoCapa IS NULL 
      BEGIN 
        INSERT INTO #SaldoCapa (ID, Modulo, Mov, MovID, Articulo, Subcuenta, Existencia, Costo, Valor) 
        SELECT @Id, @CapaModulo, @CapaMov, @CapaMovID, @Articulo, @ArtSubcuenta, @SaldoREgistroU, @CostoUEPS, @SaldoRegistroM 

        UPDATE #ReporteKardex SET SaldoU = @SaldoRegistroU, SaldoM = @SaldoREgistroM WHERE IDR = @IDReporteK
      END ELSE 
      BEGIN
        SELECT @CapaExistencia = Existencia, @CapaValor = Valor FROM #SaldoCapa WHERE IDR = @IDSaldoCapa
        UPDATE #ReporteKardex SET @CapaExistenciaNueva = SaldoU = ISNULL(@CapaExistencia,0) + ISNULL(@SaldoRegistroU,0), @CapaValorNueva = SaldoM = ISNULL(@CapaValor,0) + ISNULL(@SaldoREgistroM,0) WHERE IDR = @IDReporteK
        UPDATE #SaldoCapa SET Existencia = @CapaExistenciaNueva, Valor = @CapaValorNueva WHERE IDR = @IDSaldoCapa
      END

      SELECT @UltimoIDReporteK = @IDReporteK, @UltimoID = @ID
    END

  FETCH NEXT FROM crReporteKardex INTO @IDReporteK, @ID, @Articulo, @ArtSubcuenta, @FEchaSistema, @Capamodulo, @CapaMov, @CapaMovID, @SaldoRegistroU, @SaldoREgistroM, @CostoUEPS
  END        
  CLOSE crReporteKardex  
  DEALLOCATE crReporteKardex       

  SELECT r.*, a.Descripcion1 FROM #REporteKardex r
   JOIN Art a ON r.Articulo = a.Articulo
   WHERE r.Almacen IN (ISNULL(@Almacen,r.Almacen), NULL)
   ORDER BY r.Articulo, r.Subcuenta, r.ID, r.IDR

RETURN
END
GO

--EXEC spReporteKardexPEPS 5, 'DEMO', 0, '01/01/2015', '30/04/2015','1','TOALLA','(TODAS)','(TODOS)','(Todos)','(Todos)','(Todos)','(Todos)','(Todos)'
/**************** spReporteKardexPEPS ****************/
if exists (select * from sysobjects where id = object_id('dbo.spReporteKardexPEPS') and type = 'P') drop procedure dbo.spReporteKardexPEPS
GO             
CREATE PROCEDURE spReporteKardexPEPS
			@Estacion	int,
			@Empresa varchar(10),
			@Sucursal int,
			@FechaD datetime,
			@FechaA datetime,
			@ArticuloD varchar(20),
			@ArticuloA varchar(20),
			@ArtOpcion varchar(20),
			@Almacen  varchar(20),
			@ArtCategoria varchar(50),
			@ArtGrupo varchar(50),
			@ArtFamilia varchar(50),
			@ArtFabricante varchar(50),
			@ArtLinea varchar(20)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @ID				int, 
  @Mov				varchar(20), 
  @Articulo			varchar(20), 
  @FechaSistema datetime,
  @Subcuenta varchar(20),
  @ArtSubcuenta		varchar(20),
  @IDCapa			int, 
  @CapaModulo		varchar(20), 
  @CapaMov			varchar(20), 
  @CapaMovID		varchar(20), 
  @CapaArticulo		varchar(20), 
  @CapaSubcuenta	varchar(20), 
  @CapaExistencia	float, 
  @CapaCosto		float, 
  @CapaValor		money,
  @CapaSaldoU		float,
  @CapaSaldoM		money,
  @IDSaldoCapa		int,
  @IdReporteK		int,
  @SaldoREgistroU	float,
  @SaldoRegistroM	float, 
  @CostoPEPS		float,
  @CapaExistenciaNueva float, 
  @CapaValorNueva	money,
  @UltimoIdReporteK int,
  @UltimoID			int

-- NOTA En PEPS No existe Costeo a nivel Serie Lote

  IF @ArtOpcion = '(TODAS)'		SELECT @ArtOpcion  = NULL
  IF @ArtCategoria = '(Todos)'	SELECT @ArtCategoria = NULL
  IF @ArtGrupo = '(Todos)'		SELECT @ArtGrupo = NULL
  IF @ArtFamilia = '(Todos)'	SELECT @ArtFamilia = NULL
  IF @ArtFabricante = '(Todos)' SELECT @ArtFabricante = NULL
  IF @ArtLinea = '(Todos)'		SELECT @ArtLinea = NULL
  IF @Almacen = '(TODOS)'		SELECT @Almacen = NULL

  SELECT @Subcuenta = @ArtOpcion

  CREATE TABLE #ReporteKardex (
  IDR			int			Identity(1,1),
  ID			Int			NULL,
  Empresa		varchar(10) COLLATE DATABASE_DEFAULT NULL,
  Sucursal		int			NULL,
  Modulo		varchar(10) COLLATE DATABASE_DEFAULT NULL,
  ModuloID		int			NULL,
  Mov			varchar(20) COLLATE DATABASE_DEFAULT NULL,
  MovID			varchar(20) COLLATE DATABASE_DEFAULT NULL,
  Almacen		varchar(20) COLLATE DATABASE_DEFAULT NULL,
  Subgrupo		varchar(20) COLLATE DATABASE_DEFAULT NULL,
  FechaSistema	datetime	NULL,
  FechaEmision	datetime	NULL,
  Articulo		varchar(20) COLLATE DATABASE_DEFAULT NULL,
  Subcuenta		varchar(20) COLLATE DATABASE_DEFAULT NULL,
  CostoUnitario float		NULL,
  CargoU		float		NULL,
  AbonoU		float		NULL,
  Cargo			money		NULL,
  Abono			money		NULL,
  SaldoU		float		NULL,
  SaldoM		money		NULL,
  CostoPromedio float		NULL,
  CostoPEPS		float		NULL,
  CapaModulo	varchar(10) COLLATE DATABASE_DEFAULT NULL,
  CapaMov		varchar(20) COLLATE DATABASE_DEFAULT NULL,
  CapaMovID		varchar(20) COLLATE DATABASE_DEFAULT NULL
  )

  CREATE TABLE #SaldoCapa
  (IDR			int Identity(1,1),
  ID			int NULL,
  modulo		varchar(10) COLLATE DATABASE_DEFAULT NULL,
  Mov			varchar(20) COLLATE DATABASE_DEFAULT NULL,
  MovID			varchar(20) COLLATE DATABASE_DEFAULT NULL,
  Articulo		varchar(20) COLLATE DATABASE_DEFAULT NULL,
  Subcuenta		varchar(20) COLLATE DATABASE_DEFAULT NULL,
  Existencia	float NULL,
  Costo			float NULL,
  Valor			float NULL)

  TRUNCATE TABLE #ReporteKardex


  CREATE TABLE #TempArt(
  Articulo          varchar(20))

  CREATE TABLE #TempArtSub(
  Articulo          varchar(20),
  SubCuenta         varchar(50)   NULL,)

 
  IF ISNULL(RTRIM(@Almacen), '') in ('', 'NULL', 'NULO', 'TODOS', 'TODAS', '(TODOS)', '(TODAS)') SELECT @Almacen = NULL
  IF ISNULL(RTRIM(@ArtCategoria), '') in ('', 'NULL', 'NULO', 'TODOS', 'TODAS', '(TODOS)', '(TODAS)') SELECT @ArtCategoria = NULL
  IF ISNULL(RTRIM(@ArtGrupo), '') in ('', 'NULL', 'NULO', 'TODOS', 'TODAS', '(TODOS)', '(TODAS)') SELECT @ArtGrupo = NULL
  IF ISNULL(RTRIM(@ArtFamilia), '') in ('', 'NULL', 'NULO', 'TODOS', 'TODAS', '(TODOS)', '(TODAS)') SELECT @ArtFamilia = NULL
  IF ISNULL(RTRIM(@ArtLinea), '') in ('', 'NULL', 'NULO', 'TODOS', 'TODAS', '(TODOS)', '(TODAS)') SELECT @ArtLinea = NULL
  IF ISNULL(RTRIM(@ArtFabricante), '') in ('', 'NULL', 'NULO', 'TODOS', 'TODAS', '(TODOS)', '(TODAS)') SELECT @ArtFabricante = NULL

  INSERT INTO #TempArt(Articulo)
  SELECT Articulo
    FROM Art
   WHERE Estatus = 'ALTA'
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND ISNULL(Categoria, '') = CASE @ArtCategoria WHEN NULL THEN ISNULL(Categoria, '') ELSE @ArtCategoria END
     AND ISNULL(Grupo, '') = CASE @ArtGrupo WHEN NULL THEN ISNULL(Grupo, '') ELSE @ArtGrupo END
     AND ISNULL(Familia, '') = CASE @ArtFamilia WHEN NULL THEN ISNULL(Familia, '') ELSE @ArtFamilia END
     AND ISNULL(Linea, '') = CASE @ArtLinea WHEN NULL THEN ISNULL(Linea, '') ELSE @ArtLinea END
     AND ISNULL(Fabricante, '') = CASE @ArtFabricante WHEN NULL THEN ISNULL(Fabricante, '') ELSE @ArtFabricante END

  INSERT #ReporteKardex (ID, Empresa, Sucursal, Modulo, ModuloID, Mov, MovID, Almacen, Subgrupo, 
							FechaSistema, FechaEmision, Articulo, Subcuenta, 
							CostoUnitario, CargoU, AbonoU, --Cargo, Abono, SaldoU, SaldoM, CostoPromedio,
							CapaModulo, CapaMov, CapaMovID, SaldoU, SaldoM, CostoPEPS)
  SELECT 1/*MAX(u.ID)*/, u.Empresa, u.Sucursal, NULL, NULL, 'REP SALDO INICIAL', NULL, /*Moneda,*/ NULL, NULL, 
  @FechaD,  @FechaD, u.Cuenta,  NULLIF(u.Subcuenta,''), 
  MAX(i.costo), NULL, NULL, i.Modulo, i.Mov, i.MovID, 
  --ISNULL(SUM(c.CargoU),0) - ISNULL(SUM(c.AbonoU),0), 
   convert(decimal(20,4),(SUM(ISNULL(c.CargoU,0)) - SUM(ISNULL(c.AbonoU,0)))),
   (ISNULL(SUM(i.Costo*c.CargoU),0)-ISNULL(SUM(i.costo*c.AbonoU),0)) ,  (ISNULL(SUM(i.Costo*c.CargoU),0)-ISNULL(SUM(i.costo*c.AbonoU),0)) / (SUM(ISNULL(c.CargoU,0)) - SUM(ISNULL(c.AbonoU,0)))
  FROM Auxiliaru u
  JOIN InvCapaAux c ON u.Modulo = c.Modulo AND u.ModuloID = c.ModuloID AND c.Renglon= u.renglon AND c.RenglonSub = u.RenglonSub
  JOIN InvCapa i ON c.ID = i.ID AND i.Sistema = 'G' AND u.Cuenta = i.Articulo AND u.subcuenta = i.Subcuenta
  JOIN #TempArt a ON a.Articulo = u.Cuenta
  WHERE  u.cuenta BETWEEN @ArticuloD AND @ArticuloA 
    AND u.Rama = 'INV'
    AND u.Subcuenta IN (ISNULL(@Subcuenta,u.Subcuenta)) 
   -- AND dbo.fnFechaREgistro(u.Modulo, u.ModuloID) < @FechaD
    AND u.FEcha < @FechaD
    AND u.Grupo IN (ISNULL(@Almacen, u.Grupo))
and u.Escancelacion = 0
  GROUP BY i.Id, u.Empresa, u.Sucursal, u.Cuenta, u.Subcuenta, i.Modulo, i.Mov, i.MovID
  Having  convert(decimal(20,4),(SUM(ISNULL(c.CargoU,0)) - SUM(ISNULL(c.AbonoU,0)))) <> 0


  INSERT #ReporteKardex (ID, Empresa, Sucursal, Modulo, ModuloID, Mov, MovID, Almacen, Subgrupo, 
  FechaSistema, FechaEmision, Articulo, Subcuenta, 
  CostoUnitario, CargoU, AbonoU, Cargo, Abono,--, SaldoU, SaldoM, CostoPromedio,
  CapaModulo, CapaMov, CapaMovID, CostoPEPS)
  SELECT u.ID, u.Empresa, u.Sucursal, u.Modulo, u.ModuloID, u.Mov, u.MovID, /*Moneda,*/ u.Grupo, u.SubGrupo, 
  --dbo.fnFechaREgistro(u.Modulo, u.ModuloID),
  u.Fecha,
  u.Fecha,
  u.Cuenta,  NULLIF(u.Subcuenta,''), 
  i.costo, MAX(c.CargoU), MAX(c.AbonoU), i.Costo*(MAX(ISNULL(c.CargoU,0))), i.Costo*(MAX(ISNULL(c.AbonoU,0))),-- NULL, NULL, 
  --'CostoUnitario'=ISNULL(u.Cargo/u.CargoU, u.Abono/u.AbonoU) ,
  --u.CargoU, u.AbonoU, u.Cargo, u.Abono, 
  --'SaldoU' = NULL,
  --'SaldoM' = NULL,
  --'CostoPromedio' = NULL
  i.Modulo, i.Mov, i.MovID, i.costo
  FROM Auxiliaru u 
  JOIN  InvCapaAux c ON u.Modulo = c.Modulo AND u.ModuloID = c.ModuloID AND c.Renglon= u.renglon AND c.RenglonSub = u.RenglonSub
  JOIN InvCapa i ON c.ID = i.ID AND i.Sistema = 'G' AND u.Cuenta = i.Articulo-- AND u.subcuenta = i.Subcuenta
  JOIN #TempArt a ON a.Articulo = u.Cuenta
  WHERE u.Empresa = @Empresa AND u.Sucursal = @Sucursal 
    AND u.Rama = 'INV'
    AND u.cuenta >= @ArticuloD AND u.Cuenta <= @ArticuloA 
    AND u.Subcuenta IN (ISNULL(@Subcuenta,u.Subcuenta)) 
    --AND dbo.fnFechaREgistro(u.Modulo, u.ModuloID) BETWEEN @FechaD AND @FechaA
    AND u.FEcha BETWEEN @FechaD AND @FechaA
AND u.Grupo IN (ISNULL(@Almacen, u.Grupo))
and u.Escancelacion = 0
  GROUP BY u.ID, u.Empresa, u.Sucursal, u.Modulo, u.ModuloID, u.Mov, u.MovID, /*Moneda,*/ u.Grupo, u.SubGrupo, 
  --dbo.fnFechaREgistro(u.Modulo, u.ModuloID),
  u.Fecha,
  u.Fecha,
  u.Cuenta, u.Subcuenta, i.Modulo, i.Mov, i.MovID,
  i.costo
  ORDER BY u.Cuenta, u.Subcuenta, u.ID

  INSERT INTO #SaldoCapa (ID, Modulo, Mov, MovID, Articulo, Subcuenta, Existencia, Costo, Valor) 
  SELECT 1, CapaModulo, CapaMov, CapaMovID, Articulo, Subcuenta, SaldoU, CostoPEPS, SaldoM 
    FROM #ReporteKardex 
  WHERE Mov = 'REP SALDO INICIAL' AND SaldoU > 0

  
	  
  DECLARE crReporteKardex CURSOR FOR         
   SELECT IDR, ID, Articulo, Subcuenta, FechaSistema, CapaModulo, CapaMov, CapaMovID, (ISNULL(CargoU,0) - ISNULL(AbonoU,0)), (ISNULL(Cargo,0) - ISNULL(Abono,0)), CostoPEPS
     FROM #ReporteKardex WHERE mov != 'REP SALDO INICIAL' 
   --	group by ID, Articulo, Subcuenta 
    ORDER BY ID, Articulo, Subcuenta
  OPEN crReporteKardex          
  FETCH NEXT FROM crReporteKardex INTO @IDReporteK, @ID, @Articulo, @ArtSubcuenta, @FEchaSistema, @Capamodulo, @CapaMov, @CapaMovID, @SaldoRegistroU, @SaldoREgistroM, @CostoPEPS
  WHILE @@FETCH_STATUS = 0        
  BEGIN

--select @IDReporteK, @ID, @Articulo, @ArtSubcuenta, @FEchaSistema, @Capamodulo, @CapaMov, @CapaMovID, @SaldoRegistroU, @SaldoREgistroM, @CostoPEPS

    IF @Mov != 'REP SALDO INICIAL'
    BEGIN
      SELECT @IDSaldoCapa = NULL

      IF @UltimoID = @ID 
        DELETE #ReporteKardex WHERE ID = @ultimoID AND Modulo IS NULL
      SELECT @IDSaldoCapa = IDR FROM #SaldoCapa WHERE Modulo = @CapaModulo AND Mov = @CapaMov AND MovID = @CapaMovID AND Articulo = @Articulo AND ISNULL(Subcuenta,'') = ISNULL(@ArtSubcuenta,'')

      INSERT #ReporteKardex (ID, Empresa, Sucursal, Modulo, ModuloID, Mov, MovID, /*Moneda,*/ Almacen, Subgrupo, 
      FechaSistema, FechaEmision, Articulo, Subcuenta, 
      CostoUnitario, CargoU, AbonoU, --Cargo, Abono, SaldoU, SaldoM, CostoPromedio,
      CapaModulo, CapaMov, CapaMovID, SaldoU, CostoPEPS, SaldoM)
      SELECT @ID, @Empresa, @Sucursal, NULL, NULL, NULL, NULL, /*Moneda,*/ NULL, NULL, 
      @Fechasistema, @Fechasistema, Articulo,  Subcuenta, 
      NULL, NULL, NULL, 
      Modulo, Mov, MovID, Existencia, Costo, Valor 
      FROM #SaldoCapa 
      WHERE IDR NOT IN (@IDSaldoCapa) AND Articulo = @Articulo AND ISNULL(Subcuenta,'') = ISNULL(@ArtSubcuenta,'') 
        AND Existencia > 0
        AND IDR NOT IN (SELECT c.IDR 
		                  FROM #ReporteKardex r 
						  JOIN #SaldoCapa c ON r.CapaModulo = c.Modulo AND r.CapaMov = c.Mov AND c.MovID = r.CapaMovID AND c.Articulo = r.Articulo AND ISNULL(c.Subcuenta,'') = ISNULL(r.Subcuenta,'')
                         WHERE r.ID = @ID AND ModuloID IS NOT NULL ) 

      -- Si no existe la capa
      IF @IDSaldoCapa IS NULL 
      BEGIN 
        INSERT INTO #SaldoCapa (ID, Modulo, Mov, MovID, Articulo, Subcuenta, Existencia, Costo, Valor) 
        SELECT @Id, @CapaModulo, @CapaMov, @CapaMovID, @Articulo, @ArtSubcuenta, @SaldoREgistroU, @CostoPEPS, @SaldoRegistroM 

        UPDATE #ReporteKardex SET SaldoU = convert(decimal(20,4),@SaldoRegistroU), SaldoM = @SaldoREgistroM WHERE IDR = @IDReporteK
      END ELSE 
      BEGIN
        SELECT @CapaExistencia = Existencia, @CapaValor = Valor FROM #SaldoCapa WHERE IDR = @IDSaldoCapa
        UPDATE #ReporteKardex SET @CapaExistenciaNueva = SaldoU = Convert(decimal(20,4),ISNULL(@CapaExistencia,0) + ISNULL(@SaldoRegistroU,0)), @CapaValorNueva = SaldoM = ISNULL(@CapaValor,0) + ISNULL(@SaldoREgistroM,0) WHERE IDR = @IDReporteK
        UPDATE #SaldoCapa SET Existencia = @CapaExistenciaNueva, Valor = @CapaValorNueva WHERE IDR = @IDSaldoCapa
      END

      SELECT @UltimoIDReporteK = @IDReporteK, @UltimoID = @ID
    END

  FETCH NEXT FROM crReporteKardex INTO @IDReporteK, @ID, @Articulo, @ArtSubcuenta, @FEchaSistema, @Capamodulo, @CapaMov, @CapaMovID, @SaldoRegistroU, @SaldoREgistroM, @CostoPEPS
  END        
  CLOSE crReporteKardex  
  DEALLOCATE crReporteKardex       

  SELECT r.*, a.Descripcion1 FROM #REporteKardex r
   JOIN Art a ON r.Articulo = a.Articulo
   WHERE r.Almacen IN (ISNULL(@Almacen,r.Almacen), NULL)
   --AND r.Mov IS NOT NULL
   --AND ID = @UltimoIdReporteK
   ORDER BY r.Articulo, r.Subcuenta, r.ID, r.IDR

RETURN
END
GO


/**************** spRepTabNomProv ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID('dbo.spRepTabNomProv') AND type = 'P') DROP PROCEDURE Dbo.spRepTabNomProv
GO   
CREATE PROCEDURE spRepTabNomProv
	@ID                		INT,
	@Estacion               INT,
	@Opcion                 INT
AS
BEGIN
	DECLARE 
 		@SQL varchar(8000),
		@SQL2 varchar(8000),
		@Columna int,
		@Concepto varchar(100), 
		@Tipo varchar(20),
		@Personal varchar(20),
		@Total money,
		@Mov varchar(20), 
		@MovID varchar(20), 
		@FechaD datetime, 
		@FechaA datetime, 
		@ApellidoPaterno varchar(50), 
		@ApellidoMaterno varchar(50), 
		@Nombre varchar(50), 
		@Registro varchar(50), 
		@Registro2 varchar(50), 
		@SDI money, 
		@Puesto varchar(50), 
		@Departamento varchar(50),
		@Empresa varchar(50),
		@NombreEmpresa varchar(100),
		@NombreCompleto  varchar(100),

		@TotalPercepciones money,
		@TotalDeducciones money,
		@TotalNeto money,

		@ElaNombre varchar(100), 
		@ElaPuesto varchar(50),
		@AutNombre varchar(100),
		@AutPuest  varchar(50),

		@RutaArchivo    VARCHAR(255),
		@RutaRespaldo   VARCHAR(255),
		@NombreArchivo  VARCHAR(50),
		@BaseDatos      VARCHAR(100),
		@TotalProvision  money
 
	DELETE NomTabPipe WHERE Estacion = @Estacion
	
	SELECT @Empresa = Empresa 
	FROM Nomina 
	WHERE ID = @ID
	
	SELECT @RutaArchivo = RutaArchivo, @RutaRespaldo = RutaRespaldo, @NombreArchivo = NombreArchivo, @BaseDatos = BaseDatos 
	FROM NomTabArchivo
	WHERE Empresa = @Empresa


	CREATE TABLE #PasoTotales(
		Personal	VARCHAR(20)  COLLATE database_DEFAULT NULL,
		Columna		VARCHAR(100) COLLATE database_DEFAULT,
		Total		MONEY NULL, 
		Tipo		VARCHAR(30)  COLLATE database_DEFAULT NULL, 
		Orden		INT NULL
	)  

	SET @SQL2= ''

    SELECT @Mov =  n.Mov, @MovID = n.MovID, @FechaD = n.FechaD, @FechaA = n.FechaA, @Empresa = n.Empresa 
	FROM NOMINA n 				               
	WHERE n.ESTATUS = 'CONCLUIDO' AND n.MOV = 'NOMINA' AND n.ID = @ID 

    SELECT @NombreEmpresa = Nombre FROM empresa WHERE Empresa = @Empresa
	SET @SQL2= @NombreEmpresa + ', ' + @Mov + ', ' + @MovID + ', '+ convert(varchar(12),@FechaD) + ', ' + convert(varchar(12),@FechaA)

	INSERT INTO NomTabPipe(Estacion, Cadena01)
	SELECT @Estacion, @SQL2

	SELECT @SQL2 = ''
	SELECT @SQL2 = 'Empleado, Nombre, RFC, No Afiliacion, SDI, Departamento, Puesto,'

	DECLARE	Crpipe CURSOR LOCAL FAST_FORWARD  FOR  
	SELECT	Columna, Tipo, Concepto 
	FROM NomTabCfg 
	WHERE Tipo IN ('Percepciones') AND Concepto IN ('Sueldo','Prima Vacacional Exenta','Prima Antiguedad Gravable')

	OPEN	Crpipe  
	FETCH	NEXT FROM Crpipe
	INTO	@Columna, @Tipo, @Concepto  

	WHILE	@@FETCH_STATUS <> -1  
	BEGIN  
		IF	@@FETCH_STATUS <> -2  
		BEGIN  				
			SET @SQL2= @SQL2 +  @Concepto+  ', '                             
			SELECT @Total = 0
		END
				
		FETCH	NEXT FROM Crpipe INTO @Columna, @Tipo, @Concepto  
	END
					
	CLOSE	Crpipe  
	DEALLOCATE	Crpipe  

	SET @SQL2= @SQL2 +  'Total Percepciones' +  ', '     

	DECLARE	Crpipe CURSOR LOCAL FAST_FORWARD  FOR  
	SELECT	Columna, Tipo, Concepto 
	FROM NomTabCfg 
	WHERE Tipo in ('Deducciones') AND Concepto IN ('IMSS','ISR Aguinaldo','ISR Liquidacion')

	OPEN	Crpipe  
	FETCH	NEXT FROM Crpipe
	INTO	@Columna, @Tipo, @Concepto  

	WHILE	@@FETCH_STATUS <> -1  
	BEGIN  
		IF	@@FETCH_STATUS <> -2  
		BEGIN  				
			SET @SQL2= @SQL2 +  @Concepto+  ', '      
		END
				
		FETCH	NEXT FROM Crpipe INTO @Columna, @Tipo, @Concepto  
	END
					
	CLOSE	Crpipe  
	DEALLOCATE	Crpipe  

	SET @SQL2= @SQL2 +  'Total Deducciones' +  ', ' 
	  
	DECLARE	Crpipe CURSOR LOCAL FAST_FORWARD  FOR  
	SELECT	Columna, Tipo, Concepto FROM NomTabCfg WHERE Tipo IN ('Provision') 

	OPEN	Crpipe  
	FETCH	NEXT FROM Crpipe
	INTO	@Columna, @Tipo, @Concepto  

	WHILE	@@FETCH_STATUS <> -1  
	BEGIN  
		IF	@@FETCH_STATUS <> -2  
		BEGIN  				
            SET @SQL2= @SQL2 +  @Concepto+  ', '                             
			SELECT @Total = 0
		END
				
		FETCH	NEXT FROM Crpipe INTO @Columna, @Tipo, @Concepto  
	END
					
	CLOSE	Crpipe  
	DEALLOCATE	Crpipe  

	SET @SQL2= @SQL2 +  'Total Provisiones' +  ', Total Neto '     

	INSERT INTO NomTabPipe(Estacion, Cadena01)
	SELECT @Estacion, @SQL2

	SET @SQL2= ''

    DECLARE	CrpipePersonal CURSOR LOCAL FAST_FORWARD  FOR  
	SELECT DISTINCT n.Mov, n.MovID, n.FechaD, n.FechaA, nd.Personal, p.ApellidoPaterno, p.ApellidoMaterno, p.Nombre, p.Registro, p.Registro2, p.SDI, p.Puesto, p.Departamento, p.Empresa 
	FROM NOMINA n 
		JOIN NOMINAD nd ON n.ID = nd.ID
		JOIN Personal p On nd.Personal = p.Personal  
    WHERE n.ESTATUS = 'CONCLUIDO' AND n.MOV = 'NOMINA' AND n.ID = @ID AND nd.Personal IS NOT NULL
    
	OPEN	CrpipePersonal  
	FETCH	NEXT FROM CrpipePersonal INTO @Mov, @MovID, @FechaD, @FechaA, @Personal, @ApellidoPaterno, @ApellidoMaterno, @Nombre, @Registro, @Registro2, @SDI, @Puesto, @Departamento, @Empresa
	
	WHILE	@@FETCH_STATUS <> -1  
	BEGIN  
		IF	@@FETCH_STATUS <> -2  
		BEGIN  		
			         
			SELECT @NombreCompleto = @Personal + ', ' +@Nombre + ' ' +  @ApellidoPaterno + ' ' + @ApellidoMaterno + ', ' 

			DECLARE	Crpipe CURSOR LOCAL FAST_FORWARD  FOR  
			SELECT	Columna, Tipo, Concepto 
			FROM NomTabCfg 
			WHERE Tipo IN ('Percepciones') AND Concepto IN ('Sueldo','Prima Vacacional Exenta','Prima Antiguedad Gravable')

			OPEN	Crpipe  
			FETCH	NEXT FROM Crpipe
			INTO	@Columna, @Tipo, @Concepto  

			WHILE	@@FETCH_STATUS <> -1  
			BEGIN  
				IF	@@FETCH_STATUS <> -2  
				BEGIN  				

					SELECT @Total = Importe 
					FROM NOMINA n JOIN NOMINAD nd ON n.ID = nd.ID										  										
					WHERE ESTATUS = 'CONCLUIDO' AND MOV = 'NOMINA' AND n.ID = @ID AND nd.Movimiento IN ('Percepcion') AND ND.Personal = @Personal AND ND.Concepto = @Concepto
							   
                    SET @SQL2= @SQL2 +  CONVERT(VARCHAR,ISNULL(@Total,0)) + ', '                              
							   

					SELECT @TotalPercepciones = ISNULL(@TotalPercepciones,0) + ISNULL(@Total,0)
	                SELECT @Total = 0

				END
				
				FETCH	NEXT FROM Crpipe INTO @Columna, @Tipo, @Concepto  
			END
					
			CLOSE	Crpipe  
			DEALLOCATE	Crpipe  
				    
			SET @SQL2= @SQL2 +  CONVERT(VARCHAR,ISNULL(@TotalPercepciones,0)) + ', ' 

			DECLARE	Crpipe CURSOR LOCAL FAST_FORWARD  FOR  
			SELECT	Columna, Tipo, Concepto 
			FROM NomTabCfg 
			WHERE Tipo IN ('Deducciones') AND Concepto IN ('IMSS','ISR Aguinaldo','ISR Liquidacion')
 
			OPEN	Crpipe  
			FETCH	NEXT FROM Crpipe
			INTO	@Columna, @Tipo, @Concepto  

			WHILE	@@FETCH_STATUS <> -1  
			BEGIN  
				IF	@@FETCH_STATUS <> -2  
				BEGIN  											   							   									
					SELECT @Total = Importe 
					FROM NOMINA n JOIN NOMINAD nd ON n.ID = nd.ID										  										
					WHERE ESTATUS = 'CONCLUIDO' AND MOV = 'NOMINA' AND n.ID = @ID AND nd.Movimiento IN ('Deduccion') AND ND.Personal = @Personal AND ND.Concepto = @Concepto
										  
                    SET @SQL2= @SQL2 +  CONVERT(VARCHAR,ISNULL(@Total,0)) + ', '            
					SELECT @TotalDeducciones = ISNULL(@TotalDeducciones,0) + ISNULL(@Total,0)
	                SELECT @Total = 0
				END
				
				FETCH	NEXT FROM Crpipe INTO @Columna, @Tipo, @Concepto  
			END
					
			CLOSE	Crpipe  
			DEALLOCATE	Crpipe  
					  
			SELECT @TotalPercepciones = ISNULL(@TotalDeducciones,0) + ISNULL(@Total,0)
			
			DECLARE	Crpipe CURSOR LOCAL FAST_FORWARD  FOR  
			SELECT	Columna, Tipo, Concepto 
			FROM NomTabCfg 
			WHERE Tipo IN ('Provision') 

			OPEN	Crpipe  
			FETCH	NEXT FROM Crpipe
			INTO	@Columna, @Tipo, @Concepto  

			WHILE	@@FETCH_STATUS <> -1  
			BEGIN  
				IF	@@FETCH_STATUS <> -2  
				BEGIN  											   							   		
							
					SELECT @Total = Importe 
					FROM NOMINA n JOIN NOMINAD nd ON n.ID = nd.ID										  										
					WHERE ESTATUS = 'CONCLUIDO' AND MOV = 'NOMINA' AND n.ID = @ID AND nd.Movimiento in ('Provision') AND ND.Personal = @Personal AND ND.Concepto = @Concepto

                    SET @SQL2= @SQL2 +  CONVERT(VARCHAR,ISNULL(@Total,0)) + ', '            							     
					SELECT @TotalProvision = ISNULL(@TotalProvision,0) + ISNULL(@Total,0)
	                SELECT @Total = 0
				END
				
			FETCH	NEXT FROM Crpipe INTO @Columna, @Tipo, @Concepto  
			ENd
					
			CLOSE	Crpipe  
			DEALLOCATE	Crpipe  
			
			SET @SQL2= @SQL2 +  CONVERT(VARCHAR,ISNULL(@TotalProvision,0)) + ', '   		  
					  
			SELECT @TotalNeto = ISNULL(@TotalPercepciones,0) + ISNULL(@TotalDeducciones,0) + isnull(@TotalProvision,0)

			SET @SQL2= @SQL2 +  CONVERT(VARCHAR,ISNULL(@TotalNeto,0)) + ', '   

			SET @SQL= @NombreCompleto+', ' +  isnull(@Registro,'')+  ', '+  isnull(@Registro2,'')+  ', '+  convert(varchar,@SDI)+  ', '+ @Departamento +  ', ' + @Puesto + ','+ @SQL2                            

		END           
				 
		INSERT INTO NomTabPipe(Estacion, Cadena01)
		SELECT @Estacion, @SQL

		FETCH	NEXT FROM CrpipePersonal INTO @Mov, @MovID, @FechaD, @FechaA, @Personal, @ApellidoPaterno, @ApellidoMaterno, @Nombre, @Registro, @Registro2, @SDI, @Puesto, @Departamento, @Empresa
	END
		
	CLOSE	CrpipePersonal  
	DEALLOCATE	CrpipePersonal  
		
	SELECT @TotalPercepciones = 0
	SELECT @TotalDeducciones = 0

	DELETE #PasoTotales WHERE ISNULL(TOTAL,0)<=0
			         
					
	SELECT @SQL2 = ''

	DECLARE	Crpipe CURSOR LOCAL FAST_FORWARD  FOR  
	SELECT	Columna, Tipo, Concepto 
	FROM NomTabCfg 
	WHERE Tipo IN ('Percepciones') AND Concepto IN ('Sueldo','Prima Vacacional Exenta','Prima Antiguedad Gravable')

	OPEN	Crpipe  
	FETCH	NEXT FROM Crpipe
	INTO	@Columna, @Tipo, @Concepto  

	WHILE	@@FETCH_STATUS <> -1  
	BEGIN  
		IF	@@FETCH_STATUS <> -2  
		BEGIN  				
			SELECT @Total = 0
			SELECT @Total = isnull(nd.Importe,0) 
			FROM NOMINA n JOIN NOMINAD nd ON n.ID = nd.ID										  										
			WHERE ESTATUS = 'CONCLUIDO' AND MOV = 'NOMINA' AND n.ID = @ID AND nd.Movimiento in ('Percepcion') AND  ND.Concepto = @Concepto
							                                 
			SELECT @TotalPercepciones = ISNULL(@TotalPercepciones,0) + ISNULL(@Total,0)
	
	        SET @SQL2= @SQL2 +  CONVERT(VARCHAR,ISNULL(@Total,0)) + ', ' 

		END
				
		FETCH	NEXT FROM Crpipe INTO @Columna, @Tipo, @Concepto  
	END
					
	CLOSE	Crpipe  
	DEALLOCATE	Crpipe  

	DECLARE	Crpipe CURSOR LOCAL FAST_FORWARD  FOR  
	SELECT	Columna, Tipo, Concepto 
	FROM NomTabCfg 
	WHERE Tipo IN ('Deducciones') AND Concepto IN ('IMSS','ISR Aguinaldo','ISR Liquidacion')
			 
	OPEN	Crpipe  
	FETCH	NEXT FROM Crpipe
	INTO	@Columna, @Tipo, @Concepto  

	WHILE	@@FETCH_STATUS <> -1  
	BEGIN  
		IF	@@FETCH_STATUS <> -2  
		BEGIN  											   							   		
							
			SELECT @Total = 0
			SELECT @Total = isnull(Importe,0) 
			FROM NOMINA n JOIN NOMINAD nd ON n.ID = nd.ID										  										
			WHERE ESTATUS = 'CONCLUIDO' AND MOV = 'NOMINA' AND n.ID = @ID AND nd.Movimiento in ('Deduccion') AND ND.Concepto = @Concepto

			SELECT @TotalDeducciones = ISNULL(@TotalDeducciones,0) + ISNULL(@Total,0)

                             
			SET @SQL2= @SQL2 +  CONVERT(VARCHAR,ISNULL(@TotalDeducciones,0)) + ', '  

		END
				
		FETCH	NEXT FROM Crpipe INTO @Columna, @Tipo, @Concepto  
	END
					
	CLOSE	Crpipe  
	DEALLOCATE	Crpipe  
					  					  
    DECLARE	Crpipe CURSOR LOCAL FAST_FORWARD  FOR  
	SELECT	Columna, Tipo, Concepto 
	FROM NomTabCfg 
	WHERE Tipo IN ('Provision') 
 
	OPEN	Crpipe  
	FETCH	NEXT FROM Crpipe
	INTO	@Columna, @Tipo, @Concepto  

	WHILE	@@FETCH_STATUS <> -1  
	BEGIN  
		IF	@@FETCH_STATUS <> -2  
		BEGIN  											   							   									
			SELECT @Total = 0
			SELECT @Total = isnull(Importe,0) 
			FROM NOMINA n JOIN NOMINAD nd ON n.ID = nd.ID										  										
			WHERE ESTATUS = 'CONCLUIDO' AND MOV = 'NOMINA' AND n.ID = @ID AND nd.Movimiento IN ('Provision') AND ND.Concepto = @Concepto

			SELECT @TotalProvision = ISNULL(@TotalProvision,0) + ISNULL(@Total,0)
                             
			SET @SQL2= @SQL2 +  CONVERT(VARCHAR,ISNULL(@TotalProvision,0)) + ', '  

		END
				
		FETCH	NEXT FROM Crpipe INTO @Columna, @Tipo, @Concepto  
	END
					
	CLOSE	Crpipe  
	DEALLOCATE	Crpipe  
										  				      		
	INSERT INTO NomTabPipe(Estacion, Cadena01)
	SELECT @Estacion, @SQL2	

	SELECT @ElaNombre = ElaNombre, @ElaPuesto = ElaPuesto, @AutNombre = AutNombre, @AutPuest = AutPuesto 
	FROM NomTabFirmas

	INSERT INTO NomTabPipe(Estacion, Cadena01)
	SELECT @Estacion, 'Elaboro:' + ', , , , , , Autorizo: '
		
	INSERT INTO NomTabPipe(Estacion, Cadena01)
	SELECT @Estacion, @ElaNombre +  + ', , , , , , ' + @AutNombre
				
	INSERT INTO NomTabPipe(Estacion, Cadena01)
	SELECT @Estacion, @ElaPuesto + ', , , , , ,  ' + @AutPuest

	IF @Opcion = 1
		SELECT Cadena01 FROM NomTabPipe WHERE Estacion = @Estacion

	IF @Opcion = 2
	BEGIN
		SET @SQL2='Exec Master..xp_Cmdshell ''bcp "SELECT Cadena01 FROM ' + @BaseDatos + '.dbo.NomTabPipe where Estacion = ' + CONVERT(VARCHAR,@Estacion) + '" queryout "' + @RutaArchivo + '\' + @NombreArchivo + @Mov+ @MovID + '.txt" -c -T''' 
        EXEC(@SQL2)
    END

	RETURN
END
GO

/**************** spRepTabNominas ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID('dbo.spRepTabNominas') AND type = 'P') DROP PROCEDURE Dbo.spRepTabNominas
GO   
CREATE PROCEDURE spRepTabNominas
	@ID                		INT,
	@Estacion               INT,
	@Opcion                 INT
AS
BEGIN
	DECLARE 
 		@SQL varchar(8000),
		@SQL2 varchar(8000),
		@Columna int,
		@Concepto varchar(100), 
		@Tipo varchar(20),
		@Personal varchar(20),
		@Total money,
		@Mov varchar(20), 
		@MovID varchar(20), 
		@FechaD datetime, 
		@FechaA datetime, 
		@ApellidoPaterno varchar(50), 
		@ApellidoMaterno varchar(50), 
		@Nombre varchar(50), 
		@Registro varchar(50), 
		@Registro2 varchar(50), 
		@SDI money, 
		@Puesto varchar(50), 
		@Departamento varchar(50),
		@Empresa varchar(50),
		@NombreEmpresa varchar(100),
		@NombreCompleto  varchar(100),

		@TotalPercepciones money,
		@TotalDeducciones money,
		@TotalNeto money,

		@ElaNombre varchar(100), 
		@ElaPuesto varchar(50),
		@AutNombre varchar(100),
		@AutPuest  varchar(50),

		@RutaArchivo    VARCHAR(255),
		@RutaRespaldo   VARCHAR(255),
		@NombreArchivo  VARCHAR(50),
		@BaseDatos      VARCHAR(100)
 
	DELETE NomTabPipe WHERE Estacion = @Estacion
	SELECT @Empresa = Empresa FROM Nomina WHERE ID = @ID
	
	SELECT @RutaArchivo = RutaArchivo, @RutaRespaldo = RutaRespaldo, @NombreArchivo = NombreArchivo, @BaseDatos = BaseDatos 
	FROM NomTabArchivo
	WHERE Empresa = @Empresa


	CREATE TABLE #PasoTotales(
		Personal VARCHAR(20) COLLATE database_DEFAULT NULL,
		Columna  VARCHAR(100)COLLATE database_DEFAULT,
		Total    money NULL, 
		Tipo VARCHAR(30) COLLATE database_DEFAULT NULL, 
		Orden INT NULL
	)  


	SET @SQL2= ''

	SELECT @Mov =  n.Mov, @MovID = n.MovID, @FechaD = n.FechaD, @FechaA = n.FechaA, @Empresa = n.Empresa 
	FROM NOMINA n 				               
	WHERE n.ESTATUS = 'CONCLUIDO' AND n.MOV = 'NOMINA' AND n.ID = @ID 

	SELECT @NombreEmpresa = Nombre FROM empresa WHERE Empresa = @Empresa
	SET @SQL2= @NombreEmpresa + ', ' + @Mov + ', ' + @MovID + ', '+ CONVERT(VARCHAR(12),@FechaD) + ', ' + CONVERT(VARCHAR(12),@FechaA)

	INSERT INTO NomTabPipe(Estacion, Cadena01)
	SELECT @Estacion, @SQL2

	SELECT @SQL2 = ''
	SELECT @SQL2 = 'Empleado, Nombre, RFC, No Afiliacion, SDI, Departamento, Puesto,'

	DECLARE	Crpipe CURSOR LOCAL FAST_FORWARD  FOR  
	SELECT	Columna, Tipo, Concepto 
	FROM NomTabCfg 
	WHERE Tipo IN ('Percepciones')

	OPEN	Crpipe  
	FETCH	NEXT FROM Crpipe
	INTO	@Columna, @Tipo, @Concepto  

	WHILE	@@FETCH_STATUS <> -1  
	BEGIN  
		IF	@@FETCH_STATUS <> -2  
		BEGIN  				

            SET @SQL2= @SQL2 +  @Concepto+  ', '                             
			SELECT @Total = 0
		END
				
	FETCH	NEXT FROM Crpipe INTO @Columna, @Tipo, @Concepto  
	END
					
	CLOSE	Crpipe  
	DEALLOCATE	Crpipe  

	SET @SQL2= @SQL2 +  'Total Percepciones' +  ', '     

	DECLARE	Crpipe CURSOR LOCAL FAST_FORWARD  FOR  
	SELECT	Columna, Tipo, Concepto FROM NomTabCfg WHERE Tipo IN ('Deducciones')

	OPEN	Crpipe  
	FETCH	NEXT FROM Crpipe
	INTO	@Columna, @Tipo, @Concepto  

	WHILE	@@FETCH_STATUS <> -1  
	BEGIN  
		IF	@@FETCH_STATUS <> -2  
		BEGIN  				
				SET @SQL2 = @SQL2 +  @Concepto +  ', '      
		END
				
		FETCH	NEXT FROM Crpipe INTO @Columna, @Tipo, @Concepto  
	END
					
	CLOSE	Crpipe  
	DEALLOCATE	Crpipe  

	SET @SQL2= @SQL2 +  'Total Deducciones' +  ', Total Neto '     
	
	INSERT INTO NomTabPipe(Estacion, Cadena01)
	SELECT @Estacion, @SQL2

	SET @SQL2= ''

	DECLARE	CrpipePersonal CURSOR LOCAL FAST_FORWARD  FOR  
	SELECT distinct n.Mov, n.MovID, n.FechaD, n.FechaA, nd.Personal, p.ApellidoPaterno, p.ApellidoMaterno, p.Nombre, p.Registro, p.Registro2, p.SDI, p.Puesto, p.Departamento, p.Empresa 
	FROM NOMINA n JOIN NOMINAD nd ON n.ID = nd.ID
		JOIN Personal p On nd.Personal = p.Personal  
	WHERE n.ESTATUS = 'CONCLUIDO' AND n.MOV = 'NOMINA' AND n.ID = @ID AND nd.Personal IS NOT NULL
	
	OPEN	CrpipePersonal  
	FETCH	NEXT FROM CrpipePersonal INTO @Mov, @MovID, @FechaD, @FechaA, @Personal, @ApellidoPaterno, @ApellidoMaterno, @Nombre, @Registro, @Registro2, @SDI, @Puesto, @Departamento, @Empresa
	WHILE	@@FETCH_STATUS <> -1  
	BEGIN  
		IF	@@FETCH_STATUS <> -2  
		BEGIN  		
			         
			SELECT @NombreCompleto = @Personal + ', ' +@Nombre + ' ' +  @ApellidoPaterno + ' ' + @ApellidoMaterno + ', ' 

			DECLARE	Crpipe CURSOR LOCAL FAST_FORWARD  FOR  
			SELECT	Columna, Tipo, Concepto 
			FROM NomTabCfg 
			WHERE Tipo IN ('Percepciones')

			OPEN	Crpipe  
			FETCH	NEXT FROM Crpipe
			INTO	@Columna, @Tipo, @Concepto  

			WHILE	@@FETCH_STATUS <> -1  
			BEGIN  
				IF	@@FETCH_STATUS <> -2  
				BEGIN  				

					SELECT @Total = Importe 
					FROM NOMINA n JOIN NOMINAD nd ON n.ID = nd.ID										  										
					WHERE ESTATUS = 'CONCLUIDO' AND MOV = 'NOMINA' AND n.ID = @ID AND nd.Movimiento in ('Percepcion') AND ND.Personal = @Personal AND ND.Concepto = @Concepto
							   
					SET @SQL2= @SQL2 +  CONVERT(VARCHAR,ISNULL(@Total,0)) + ', '                              
							   
					SELECT @TotalPercepciones = ISNULL(@TotalPercepciones,0) + ISNULL(@Total,0)
					SELECT @Total = 0

				END
				
			FETCH	NEXT FROM Crpipe INTO @Columna, @Tipo, @Concepto  
			END
					
			CLOSE	Crpipe  
			DEALLOCATE	Crpipe  
				    
			SET @SQL2= @SQL2 +  CONVERT(VARCHAR,ISNULL(@TotalPercepciones,0)) + ', ' 

			DECLARE	Crpipe CURSOR LOCAL FAST_FORWARD  FOR  
			SELECT	Columna, Tipo, Concepto FROM NomTabCfg WHERE Tipo IN ('Deducciones')

			OPEN	Crpipe  
			FETCH	NEXT FROM Crpipe
			INTO	@Columna, @Tipo, @Concepto  

			WHILE	@@FETCH_STATUS <> -1  
			BEGIN  
				IF	@@FETCH_STATUS <> -2  
				BEGIN  											   							   		
							
					SELECT @Total = Importe 
					FROM NOMINA n JOIN NOMINAD nd ON n.ID = nd.ID										  										
					WHERE ESTATUS = 'CONCLUIDO' AND MOV = 'NOMINA' AND n.ID = @ID AND nd.Movimiento IN ('Deduccion') AND ND.Personal = @Personal AND ND.Concepto = @Concepto

                    SET @SQL2= @SQL2 +  CONVERT(VARCHAR,ISNULL(@Total,0)) + ', '            
					SELECT @Total = 0
				END
				
				FETCH	NEXT FROM Crpipe INTO @Columna, @Tipo, @Concepto  
			END
					
			CLOSE	Crpipe  
			DEALLOCATE	Crpipe  
					  
			SELECT @TotalPercepciones = ISNULL(@TotalDeducciones,0) + ISNULL(@Total,0)
					  
			SELECT @TotalNeto = ISNULL(@TotalPercepciones,0) + ISNULL(@TotalDeducciones,0)

			SET @SQL2= @SQL2 +  CONVERT(VARCHAR,ISNULL(@TotalNeto,0)) + ', '   

			SET @SQL= @NombreCompleto+', ' +  ISNULL(@Registro,'')+  ', '+  ISNULL(@Registro2,'')+  ', '+  CONVERT(VARCHAR,@SDI)+  ', '+ @Departamento +  ', ' + @Puesto + ','+ @SQL2                            


		END  
		         
				 
		INSERT INTO NomTabPipe(Estacion, Cadena01)
		SELECT @Estacion, @SQL

		FETCH	NEXT FROM CrpipePersonal INTO @Mov, @MovID, @FechaD, @FechaA, @Personal, @ApellidoPaterno, @ApellidoMaterno, @Nombre, @Registro, @Registro2, @SDI, @Puesto, @Departamento, @Empresa
	END
		
	CLOSE	CrpipePersonal  
	DEALLOCATE	CrpipePersonal  
		
	SELECT @TotalPercepciones = 0
	SELECT @TotalDeducciones = 0

	DELETE #PasoTotales WHERE ISNULL(TOTAL,0)<=0


	SELECT @SQL2 = ''

	DECLARE	Crpipe CURSOR LOCAL FAST_FORWARD  FOR  
	SELECT	Columna, Tipo, Concepto 
	FROM NomTabCfg 
	WHERE Tipo IN ('Percepciones')

	OPEN	Crpipe  
	FETCH	NEXT FROM Crpipe
	INTO	@Columna, @Tipo, @Concepto  

	WHILE	@@FETCH_STATUS <> -1  
	BEGIN  
		IF	@@FETCH_STATUS <> -2  
		BEGIN  				
			SELECT @Total = 0
			SELECT @Total = isnull(nd.Importe,0) 
			FROM NOMINA n JOIN NOMINAD nd ON n.ID = nd.ID										  										
			WHERE ESTATUS = 'CONCLUIDO' AND MOV = 'NOMINA' AND n.ID = @ID AND nd.Movimiento IN ('Percepcion') AND  ND.Concepto = @Concepto
							                                 
			SELECT @TotalPercepciones = ISNULL(@TotalPercepciones,0) + ISNULL(@Total,0)
	
			SET @SQL2= @SQL2 +  CONVERT(VARCHAR,ISNULL(@Total,0)) + ', ' 

		END
				
	FETCH	NEXT FROM Crpipe INTO @Columna, @Tipo, @Concepto  
	END
					
	CLOSE	Crpipe  
	DEALLOCATE	Crpipe  
				    
	DECLARE	Crpipe CURSOR LOCAL FAST_FORWARD  FOR  
	SELECT	Columna, Tipo, Concepto 
	FROM NomTabCfg 
	WHERE Tipo IN ('Deducciones')
					
	OPEN	Crpipe  
	FETCH	NEXT FROM Crpipe
	INTO	@Columna, @Tipo, @Concepto  

	WHILE	@@FETCH_STATUS <> -1  
	BEGIN  
		IF	@@FETCH_STATUS <> -2  
		BEGIN  											   							   		
							
			SELECT @Total = 0
			SELECT @Total = isnull(Importe,0) 
			FROM NOMINA n JOIN NOMINAD nd ON n.ID = nd.ID										  										
			WHERE ESTATUS = 'CONCLUIDO' AND MOV = 'NOMINA' AND n.ID = @ID AND nd.Movimiento IN ('Deduccion') AND ND.Concepto = @Concepto					  

			SELECT @TotalDeducciones = ISNULL(@TotalDeducciones,0) + ISNULL(@Total,0)
                             
			SET @SQL2= @SQL2 +  CONVERT(VARCHAR,ISNULL(@TotalDeducciones,0)) + ', '  

		END
				
		FETCH	NEXT FROM Crpipe INTO @Columna, @Tipo, @Concepto  
	END
					
	CLOSE	Crpipe  
	DEALLOCATE	Crpipe  
					  					  
					  				      		
	INSERT INTO NomTabPipe(Estacion, Cadena01)
	SELECT @Estacion, @SQL2	

	SELECT @ElaNombre = ElaNombre, @ElaPuesto = ElaPuesto, @AutNombre = AutNombre, @AutPuest = AutPuesto FROM NomTabFirmas

	INSERT INTO NomTabPipe(Estacion, Cadena01)
	SELECT @Estacion, 'Elaboro:' + ', , , , , , Autorizo: '
		
	INSERT INTO NomTabPipe(Estacion, Cadena01)
	SELECT @Estacion, @ElaNombre +  + ', , , , , , ' + @AutNombre
				
	INSERT INTO NomTabPipe(Estacion, Cadena01)
	SELECT @Estacion, @ElaPuesto + ', , , , , ,  ' + @AutPuest
				
	IF @Opcion = 1
		SELECT Cadena01 FROM NomTabPipe WHERE Estacion = @Estacion

	IF @Opcion = 2
		BEGIN
			SET @SQL2='Exec Master..xp_Cmdshell ''bcp "SELECT Cadena01 FROM ' + @BaseDatos + '.dbo.NomTabPipe where Estacion = ' + CONVERT(VARCHAR,@Estacion) + '" queryout "' + @RutaArchivo + '\' + @NombreArchivo + @Mov+ @MovID + '.txt" -c -T''' 
			EXEC(@SQL2)
		END

	RETURN
 END
 GO
