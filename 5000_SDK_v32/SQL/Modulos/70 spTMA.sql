/********* TMA ***********/
SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF

/**************** Funciones ****************/

--REQ12615 WMS
/**************** fnSurtidoTarima ****************/
IF EXISTS (SELECT name FROM SysObjects WHERE name = 'fnSurtidoTarima' AND type IN ('TF','FN')) DROP FUNCTION fnSurtidoTarima
GO
CREATE FUNCTION fnSurtidoTarima (@Empresa varchar(5), @ID int, @Modulo varchar(5))
RETURNS @Primera TABLE (Posicion varchar(10), Tarima varchar(20), CantidadPicking float, ControlArticulo varchar(20) NULL, Orden int NULL, Peso float NULL, Volumen float NULL, Disponible smallint NULL, Almacen varchar(10) NULL)
AS
BEGIN 

  DECLARE 
    @Articulo			varchar(10),
	@Cantidad			float,
	@CantidadTarima		float,
	@Completas			int,
	@Almacen			varchar(10)

  IF @Modulo = 'VTAS'
    DECLARE crCuantos CURSOR FOR
     SELECT d.Articulo, v.Almacen, SUM(d.Cantidad), MAX(a.CantidadTarima), SUM(d.Cantidad) / MAX(a.CantidadTarima)
       FROM Venta v
	   JOIN VentaD d ON v.ID = d.ID
	   JOIN Art a ON d.Articulo = a.Articulo
	  WHERE v.ID = @ID
	  GROUP BY d.Articulo, v.Almacen

  IF @Modulo = 'INV'
    DECLARE crCuantos CURSOR FOR
	 SELECT d.Articulo, v.Almacen, SUM(d.Cantidad), MAX(a.CantidadTarima), SUM(d.Cantidad) / MAX(a.CantidadTarima)
	   FROM Inv v
	   JOIN InvD d ON v.ID = d.ID
	   JOIN Art a ON d.Articulo = a.Articulo
	  WHERE v.ID = @ID
	  GROUP BY d.Articulo, v.Almacen

  IF @Modulo = 'WMS'
    DECLARE crCuantos CURSOR FOR
	 SELECT ad.Articulo, td.Almacen, a.CantidadTarima, 1
	   FROM TMAD td
	   JOIN ArtDisponibleTarima ad ON td.Almacen = ad.Almacen  AND td.Tarima = ad.Tarima
	   JOIN Art a ON ad.Articulo = a.Articulo
	  WHERE td.ID = @ID --AND ad.Articulo = @Articulo

  OPEN crCuantos
  FETCH NEXT FROM crCuantos INTO @Articulo, @Almacen, @Cantidad, @CantidadTarima, @Completas
  WHILE @@FETCH_STATUS = 0
  BEGIN
    WHILE @Completas > 0
	BEGIN
  
      INSERT @Primera (Tarima, Posicion, CantidadPicking)
      SELECT TOP 1 t.Tarima, t.Posicion, @Cantidad 
        FROM AlmPos ap
        JOIN Tarima t ON ap.Almacen = t.Almacen AND ap.Posicion = t.Posicion
       WHERE ap.Almacen = @Almacen AND ap.Tipo = 'Ubicacion' AND ap.ArticuloEsp = @Articulo
	     AND NOT EXISTS (SELECT 1 FROM @Primera WHERE Tarima = t.Tarima)
	   ORDER BY ap.Orden 

      SET @Completas = @Completas - 1
    END  
    FETCH NEXT FROM crCuantos INTO @Articulo, @Almacen, @Cantidad, @CantidadTarima, @Completas
  END

  CLOSE crCuantos
  DEALLOCATE crCuantos
  RETURN
END
GO

--REQ12615 WMS
/**************** fnRegresaSubTarima ****************/
IF EXISTS (SELECT 1 FROM sysobjects where name = 'fnRegresaSubTarima' AND type IN ('TF','FN')) DROP FUNCTION fnRegresaSubTarima
GO
CREATE FUNCTION fnRegresaSubTarima (@Tarima varchar(20), @MovTipo varchar(20))
RETURNS varchar(20)
AS BEGIN
   
 IF @MovTipo = 'TMA.OSUR'
 BEGIN
   IF (SELECT a.Tipo
         FROM Tarima t
         JOIN AlmPos a
		   ON t.Almacen = a.Almacen
		  AND t.Posicion = a.Posicion
		  AND t.Tarima = @Tarima) = 'Domicilio'
   BEGIN
     IF NOT EXISTS(SELECT d.Tarima 
	                 FROM TMAD d
					 JOIN TMA t
					   ON t.ID = d.ID
					WHERE t.Estatus IN('CONCLUIDO', 'PENDIENTE', 'PROCESAR')
					  AND d.Tarima LIKE @Tarima + '-%'
					GROUP BY d.Tarima)
       SELECT @Tarima = @Tarima + '-1'
     ELSE
       SELECT TOP 1 @Tarima = RTRIM(SUBSTRING(d.Tarima,1,LEN(@Tarima)+1)) + CONVERT(varchar(10),CONVERT(int,RTRIM(SUBSTRING(d.Tarima,LEN(@Tarima)+2,LEN(@Tarima))))+1)
         FROM TMAD d 
         JOIN TMA t
           ON t.ID = d.ID
        WHERE t.Estatus IN('CONCLUIDO', 'PENDIENTE', 'PROCESAR')
          AND d.Tarima LIKE @Tarima + '-%'
		ORDER BY D.ID DESC
   END
 END 
 RETURN (@Tarima)
END
GO

--TASK6535
/**************** fnRegresaSubTarimaPCKTarima ****************/
IF EXISTS (SELECT 1 FROM sysobjects where name = 'fnRegresaSubTarimaPCKTarima' AND type IN ('TF','FN')) DROP FUNCTION fnRegresaSubTarimaPCKTarima
GO
CREATE FUNCTION fnRegresaSubTarimaPCKTarima (@Tarima varchar(20), @MovTipo varchar(20))
RETURNS varchar(20)
AS BEGIN
   
 IF @MovTipo = 'TMA.OPCKTarima'
 BEGIN
   IF (SELECT a.Tipo
         FROM Tarima t
         JOIN AlmPos a
		   ON t.Almacen = a.Almacen
		  AND t.Posicion = a.Posicion
		  AND t.Tarima = @Tarima) = 'Ubicacion'
   BEGIN
     IF NOT EXISTS(SELECT d.Tarima 
	                 FROM TMAD d
					 JOIN TMA t
					   ON t.ID = d.ID
					WHERE t.Estatus IN('CONCLUIDO', 'PENDIENTE', 'PROCESAR')
					  AND d.Tarima LIKE @Tarima + '-%'
					GROUP BY d.Tarima)
       SELECT @Tarima = @Tarima + '-1'
     ELSE
       SELECT TOP 1 @Tarima = RTRIM(SUBSTRING(d.Tarima,1,LEN(@Tarima)+1)) + CONVERT(varchar(10),CONVERT(int,RTRIM(SUBSTRING(d.Tarima,LEN(@Tarima)+2,LEN(@Tarima))))+1)
         FROM TMAD d 
         JOIN TMA t
           ON t.ID = d.ID
        WHERE t.Estatus IN('CONCLUIDO', 'PENDIENTE', 'PROCESAR')
          AND d.Tarima LIKE @Tarima + '-%'
		ORDER BY D.ID DESC
   END
 END 
 RETURN (@Tarima)
END
GO

--REQ12615 WMS
--TASK24685
/**************** fnWMSTablaHerramienta ****************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'fnWMSTablaHerramienta' AND type IN ('TF','FN','IF')) DROP FUNCTION fnWMSTablaHerramienta
GO
CREATE FUNCTION fnWMSTablaHerramienta (@Estacion int, @Empresa char(5), @Sucursal int) --UserStory4417    
RETURNS TABLE    
AS    
RETURN (    
SELECT v.ID, 
       v.Mov, 
	   v.MovID, 
	   v.FechaEmision, 
	   v.FechaRequerida, 
	   v.Cliente Contacto,     
       CASE WHEN ISNULL(ca.Direccion,'') = '' AND ISNULL(c.Direccion,'') = '' THEN ''
	        WHEN ISNULL(ca.Direccion,'') <> '' AND ISNULL(c.Direccion,'') = '' THEN ca.Direccion
			WHEN ISNULL(ca.Direccion,'') = '' AND ISNULL(c.Direccion,'') <> '' THEN c.Direccion 
	   ELSE c.Direccion END +	   
	   CASE WHEN ISNULL(ca.DireccionNumero,'') = '' AND ISNULL(c.DireccionNumero,'') = '' THEN ''
	        WHEN ISNULL(ca.DireccionNumero,'') <> '' AND ISNULL(c.DireccionNumero,'') = '' THEN ' - ' + ca.DireccionNumero
			WHEN ISNULL(ca.DireccionNumero,'') = '' AND ISNULL(c.DireccionNumero,'') <> '' THEN ' - ' + c.DireccionNumero 
	   ELSE c.DireccionNumero END +
	   CASE WHEN ISNULL(ca.DireccionNumeroInt,'') = '' AND ISNULL(c.DireccionNumeroInt,'') = '' THEN ''
	        WHEN ISNULL(ca.DireccionNumeroInt,'') <> '' AND ISNULL(c.DireccionNumeroInt,'') = '' THEN ' - ' + ca.DireccionNumeroInt
			WHEN ISNULL(ca.DireccionNumeroInt,'') = '' AND ISNULL(c.DireccionNumeroInt,'') <> '' THEN ' - ' + c.DireccionNumeroInt 
	   ELSE c.DireccionNumeroInt END +
	   CASE WHEN ISNULL(ca.Delegacion,'') = '' AND ISNULL(c.Delegacion,'') = '' THEN ''
	        WHEN ISNULL(ca.Delegacion,'') <> '' AND ISNULL(c.Delegacion,'') = '' THEN ' - ' + ca.Delegacion
			WHEN ISNULL(ca.Delegacion,'') = '' AND ISNULL(c.Delegacion,'') <> '' THEN ' - ' + c.Delegacion 
	   ELSE c.Delegacion END +		
	   CASE WHEN ISNULL(ca.Estado,'') = '' AND ISNULL(c.Estado,'') = '' THEN ''
	        WHEN ISNULL(ca.Estado,'') <> '' AND ISNULL(c.Estado,'') = '' THEN ', ' + ca.Estado
			WHEN ISNULL(ca.Estado,'') = '' AND ISNULL(c.Estado,'') <> '' THEN ', ' + c.Estado 
	   ELSE c.Estado END Direccion, --Bug 4239
       ISNULL(ISNULL(ca.CodigoPostal, c.CodigoPostal),'') CodigoPostal,
	   ISNULL(ISNULL(ca.Ruta , c.Ruta),'') Ruta,    
       CASE ISNULL(e.WMSAndenSurtidoContacto,0) WHEN 1 THEN c.DefPosicionSurtido ELSE ISNULL(v.PosicionWMS, a.DefPosicionSurtido) END AndenSurtido, 
	   c.Nombre,
	   'VTAS' Modulo, 
	   v.Sucursal,  --BUG24685
       s.Sucursal AS SucursalDestino, 
	   s.Nombre AS NomSucursalDestino,  --@Gina 17/04/2014  
       --EWQ. Tuning
       v.Almacen, 
	   WMSSurtidoPosicionTrabajo.Posicion,
	   (SELECT Sucursal FROM Alm WHERE Almacen = v.Almacen) SucursalOrigen --BUG24685
  FROM WMSModuloMovimiento wm    
  JOIN Venta v ON wm.Modulo = 'VTAS' AND wm.Movimiento = v.Mov /*AND v.Sucursal=@Sucursal*/ -- AND v.Estatus IN(SELECT Estatus FROM WMSModuloMovimiento WHERE Movimiento = v.Mov AND Modulo = 'VTAS') --UserStory4417
  JOIN Cte c ON v.Cliente = c.Cliente    
  --BUG24399
  JOIN VentaD vd ON v.ID = vd.ID AND NULLIF(vd.Tarima,'') IS NULL AND vd.CantidadPendiente > 0 /* vd.CantidadReservada > 0 */
  JOIN Alm a ON vd.Almacen = a.Almacen    
  LEFT JOIN CteEnviarA ca ON c.Cliente = ca.Cliente AND v.EnviarA = ca.ID    
  LEFT JOIN WMSModuloTarima wmt ON 'VTAS' = wmt.Modulo AND vd.ID = wmt.IDModulo AND vd.Renglon = wmt.Renglon AND vd.RenglonSub = wmt.RenglonSub AND wmt.Tarima IS NOT NULL    
  JOIN Alm l ON l.Almacen = v.Almacen AND l.WMS = 1 AND l.Sucursal=v.Sucursal --UserStory4417  
  JOIN EmpresaCfg e ON e.Empresa = @Empresa    
  JOIN MovTipo m ON v.Mov = m.Mov AND m.Modulo = 'VTAS'    
  LEFT OUTER JOIN Alm al ON al.Almacen = v.AlmacenDestino  
  LEFT OUTER JOIN Sucursal s ON s.AlmacenPrincipal = al.Almacen  
  LEFT OUTER JOIN EmpresaCfg2 g ON v.Empresa = g.Empresa    
  LEFT OUTER JOIN Unidad u ON vd.Unidad = u.Unidad    
  LEFT OUTER JOIN ArtUnidad au ON vd.Articulo = au.Articulo AND vd.Unidad = au.Unidad    
  LEFT OUTER JOIN RepParam p ON p.Estacion = @Estacion     
  --EWQ.Tuning
  LEFT OUTER JOIN WMSSurtidoPosicionTrabajo ON v.ID = WMSSurtidoPosicionTrabajo.ModuloID AND WMSSurtidoPosicionTrabajo.Modulo = 'VTAS'
 WHERE v.Cliente = CASE ISNULL(NULLIF(p.InfoContacto,''),'(Todos)')    
      WHEN '(Todos)' THEN v.Cliente    
      WHEN 'Cliente' THEN ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoEspecifico)),''), v.Cliente)    
      ELSE ''    
       END       
   AND ISNULL(v.FechaRequerida,'') = CASE WHEN ISNULL(p.InfoFechaRequerida,'') = '' THEN ISNULL(v.FechaRequerida,'') ELSE ISNULL(p.InfoFechaRequerida,'') END    
   AND ISNULL(c.Categoria,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoCat)),''), ISNULL(c.Categoria,''))    
   AND ISNULL(c.Grupo,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoGrupo)),''), ISNULL(c.Grupo,''))    
   AND ISNULL(c.Familia,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoFam)),''), ISNULL(c.Familia,''))       
   AND ISNULL(c.Ruta,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoRuta)),''), ISNULL(c.Ruta,''))    
   AND ISNULL(c.Estado,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoEstado)),''), ISNULL(c.Estado,''))    
   AND ISNULL(c.Zona,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoZona)),''), ISNULL(c.Zona,''))    
   AND ISNULL(c.Pais,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoPais)),''), ISNULL(c.Pais,''))    
   AND ISNULL(c.CodigoPostal,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoCP)),''), ISNULL(c.CodigoPostal,''))    
   AND ISNULL(c.EnviarA,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoClienteEnviarA)),''),ISNULL(c.EnviarA,''))
   AND v.Estatus = 'PENDIENTE'    
 GROUP BY v.ID, v.Mov, v.MovID, v.FechaEmision, v.FechaRequerida, v.Cliente,    
       ca.Direccion, c.Direccion, ca.DireccionNumero, c.DireccionNumero, ca.DireccionNumeroInt, c.DireccionNumeroInt, ca.Delegacion, c.Delegacion, ca.Estado, c.Estado, c.Nombre,--Bug 4239 	   
       ISNULL(ISNULL(ca.CodigoPostal , c.CodigoPostal),''), ISNULL(ISNULL(ca.Ruta , c.Ruta),''),    
       ISNULL(v.PosicionWMS, a.DefPosicionSurtido), v.Sucursal, e.WMSAndenSurtidoContacto, c.DefPosicionSurtido,  --BUG24685
       s.Sucursal, s.Nombre, 
       v.Almacen, WMSSurtidoPosicionTrabajo.Posicion           
UNION ALL    
SELECT v.ID, 
       v.Mov, 
	   v.MovID, 
	   v.FechaEmision, 
	   v.FechaRequerida, 
	   v.Proveedor,     
       ISNULL(c.Direccion,'') + CASE WHEN ISNULL(c.DireccionNumero,'') = '' THEN '' ELSE ' - ' + c.DireccionNumero END +
                                CASE WHEN ISNULL(c.DireccionNumeroInt,'') = '' THEN '' ELSE ' ' + c.DireccionNumeroInt END +
					            CASE WHEN ISNULL(c.Delegacion,'') = '' THEN '' ELSE ' ' + c.Delegacion END + 
					            CASE WHEN ISNULL(c.Estado,'') = '' THEN '' ELSE ', ' + c.Estado END Direccion, --Bug 4239
       c.Nombre,
	   ISNULL(ISNULL(NULL , c.CodigoPostal),'') CodigoPostal,
	   ISNULL(ISNULL(NULL , c.Ruta),'') Ruta,    
       CASE ISNULL(e.WMSAndenSurtidoContacto,0) WHEN 1 THEN c.DefPosicionSurtido ELSE ISNULL(ISNULL(c.DefPosicionSurtido, v.PosicionWMS), a.DefPosicionSurtido) END AndenSurtido,
	   'COMS' Modulo, 
	   v.Sucursal,  --BUG24685
       NULL AS SucursalDestino, 
	   NULL AS NomSucursalDestino,
       v.Almacen, 
	   WMSSurtidoPosicionTrabajo.Posicion,
	   (SELECT Sucursal FROM Alm WHERE Almacen = v.Almacen) SucursalOrigen
  FROM WMSModuloMovimiento wm    
  JOIN Compra v ON wm.Modulo = 'COMS' AND wm.Movimiento = v.Mov AND v.Estatus IN(SELECT Estatus FROM WMSModuloMovimiento WHERE Movimiento = v.Mov AND Modulo = 'COMS') /*AND v.Sucursal=@Sucursal*/ --UserStory4417
  JOIN Prov c ON v.Proveedor = c.Proveedor    
  JOIN CompraD vd ON v.ID = vd.ID AND NULLIF(vd.Tarima,'') IS NULL --AND vd.CantidadReservada > 0    
  JOIN Alm a ON vd.Almacen = a.Almacen    
  JOIN Alm l ON l.Almacen = v.Almacen AND l.WMS = 1 AND l.Sucursal=v.Sucursal --UserStory4417     
  JOIN EmpresaCfg e ON e.Empresa = @Empresa    
  JOIN MovTipo m ON v.Mov = m.Mov AND m.Modulo = 'COMS'    
  LEFT OUTER JOIN EmpresaCfg2 g ON v.Empresa = g.Empresa    
  LEFT OUTER JOIN Unidad u ON vd.Unidad = u.Unidad    
  LEFT OUTER JOIN ArtUnidad au ON vd.Articulo = au.Articulo AND vd.Unidad = au.Unidad    
  LEFT OUTER JOIN RepParam p ON p.Estacion = @Estacion       
  LEFT OUTER JOIN WMSSurtidoPosicionTrabajo ON v.ID = WMSSurtidoPosicionTrabajo.ModuloID AND WMSSurtidoPosicionTrabajo.Modulo = 'COMS'  
 WHERE v.Proveedor = CASE ISNULL(NULLIF(p.InfoContacto,''),'(Todos)')    
      WHEN '(Todos)' THEN v.Proveedor    
      WHEN 'Proveedor' THEN ISNULL(NULLIF(p.InfoContactoEspecifico, ''),v.Proveedor)    
      ELSE ''    
       END    
   AND ISNULL(v.FechaRequerida,'') = CASE WHEN ISNULL(p.InfoFechaRequerida,'') = '' THEN ISNULL(v.FechaRequerida,'') ELSE ISNULL(p.InfoFechaRequerida,'') END    
   AND ISNULL(c.Categoria,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoCat)),''), ISNULL(c.Categoria,''))    
   AND ISNULL(c.Familia,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoFam)),''), ISNULL(c.Familia,''))       
   AND ISNULL(c.Ruta,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoRuta)),''), ISNULL(c.Ruta,''))    
   AND ISNULL(c.Estado,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoEstado)),''), ISNULL(c.Estado,''))    
   AND ISNULL(c.Zona,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoZona)),''), ISNULL(c.Zona,''))    
   AND ISNULL(c.Pais,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoPais)),''), ISNULL(c.Pais,''))    
   AND ISNULL(c.CodigoPostal,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoCP)),''), ISNULL(c.CodigoPostal,''))    
   AND v.Estatus = 'PENDIENTE'    
 GROUP BY v.ID, v.Mov, v.MovID, v.FechaEmision, v.FechaRequerida, v.Proveedor,     
       c.Direccion, c.Nombre, c.DireccionNumero, c.DireccionNumeroInt, c.Delegacion, c.Estado, --Bug 4239
	   ISNULL(ISNULL(NULL , c.CodigoPostal),''), ISNULL(ISNULL(NULL , c.Ruta),''),    
       ISNULL(ISNULL(c.DefPosicionSurtido, v.PosicionWMS), a.DefPosicionSurtido), v.Sucursal, e.WMSAndenSurtidoContacto, c.DefPosicionSurtido, --BUG24685
       v.Almacen, WMSSurtidoPosicionTrabajo.Posicion
UNION ALL    
SELECT v.ID, 
       v.Mov,
	   v.MovID, 
	   v.FechaEmision, 
	   v.FechaRequerida, 
	   v.Almacen,     
       ISNULL(a.Direccion,'') + CASE WHEN ISNULL(a.Delegacion,'') = '' THEN '' ELSE ' ' + a.Delegacion END + CASE WHEN ISNULL(a.Estado,'') = '' THEN '' ELSE ', ' + a.Estado END Direccion, --Bug 4239
       a.Nombre,
	   ISNULL(ISNULL(NULL , a.CodigoPostal),'') CodigoPostal, 
	   ISNULL(ISNULL(NULL , a.Ruta),'') Ruta,    
       ISNULL(v.PosicionWMS, a.DefPosicionSurtido) AndenSurtido, 
	   'INV' Modulo,
	   v.Sucursal,  --BUG24685
       s.Sucursal AS SucursalDestino, 
	   ISNULL(s.Nombre,'') + CASE WHEN ISNULL(v.Observaciones,'') = '' THEN '' ELSE ' (' + v.Observaciones + ')' END AS NomSucursalDestino, --Bug 4239  
       v.Almacen,
	   WMSSurtidoPosicionTrabajo.Posicion,
	   (SELECT Sucursal FROM Alm WHERE Almacen = v.Almacen) SucursalOrigen
  FROM WMSModuloMovimiento wm    
  JOIN Inv v ON wm.Modulo = 'INV' AND wm.Movimiento = v.Mov AND v.Estatus IN(SELECT Estatus FROM WMSModuloMovimiento WHERE Movimiento = v.Mov AND Modulo = 'INV') /*AND v.Sucursal=@Sucursal*/ --UserStory4417     
  --BUG24399
  JOIN InvD vd ON v.ID = vd.ID 
           AND NULLIF(vd.Tarima,'') IS NULL --BUG3867 
		   AND vd.CantidadPendiente > 0 /*AND vd.CantidadReservada > 0 */ 
  JOIN Alm a ON vd.Almacen = a.Almacen    
  JOIN MovTipo m ON v.Mov = m.Mov AND m.Modulo = 'INV'    
  JOIN Alm l ON l.Almacen = v.Almacen AND l.WMS = 1 AND l.Sucursal=v.Sucursal --UserStory4417     
  LEFT OUTER JOIN Alm al ON al.Almacen = v.AlmacenDestino  
  LEFT OUTER JOIN Sucursal s ON s.AlmacenPrincipal = al.Almacen  
  LEFT OUTER JOIN EmpresaCfg2 g ON v.Empresa = g.Empresa    
  LEFT OUTER JOIN Unidad u ON vd.Unidad = u.Unidad    
  LEFT OUTER JOIN ArtUnidad au ON vd.Articulo = au.Articulo AND vd.Unidad = au.Unidad    
  LEFT OUTER JOIN RepParam p ON p.Estacion = @Estacion       
  --EWQ.Tuning
  LEFT OUTER JOIN WMSSurtidoPosicionTrabajo ON v.ID = WMSSurtidoPosicionTrabajo.ModuloID AND WMSSurtidoPosicionTrabajo.Modulo = 'INV'
 WHERE v.Almacen = CASE ISNULL(NULLIF(p.InfoContacto,''),'(Todos)')    
      WHEN '(Todos)' THEN v.Almacen    
      WHEN 'Almacen' THEN ISNULL(NULLIF(p.InfoContactoEspecifico, ''),v.Almacen)    
      ELSE ''    
       END   
   AND ISNULL(v.FechaRequerida,'') = CASE WHEN ISNULL(p.InfoFechaRequerida,'') = '' THEN ISNULL(v.FechaRequerida,'') ELSE ISNULL(p.InfoFechaRequerida,'') END    
   AND ISNULL(a.Grupo,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoGrupo)),''), ISNULL(a.Grupo,''))    
   AND ISNULL(a.Ruta,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoRuta)),''), ISNULL(a.Ruta,''))    
   AND ISNULL(a.Estado,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoEstado)),''), ISNULL(a.Estado,''))    
   AND ISNULL(a.Zona,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoZona)),''), ISNULL(a.Zona,''))    
   AND ISNULL(a.Pais,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoPais)),''), ISNULL(a.Pais,''))    
   AND ISNULL(a.CodigoPostal,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoCP)),''), ISNULL(a.CodigoPostal,''))    
   AND v.Estatus = 'PENDIENTE'   
   AND ISNULL(v.OrigenTipo,'') <> 'EXTVT'
GROUP BY v.Almacen, WMSSurtidoPosicionTrabajo.Posicion, v.ID, v.Mov, v.MovID, v.FechaEmision, v.FechaRequerida, v.Almacen,     
       ISNULL(a.Direccion,''), a.Nombre, a.Delegacion, a.Estado, --Bug 4239       
       ISNULL(ISNULL(NULL , a.CodigoPostal),''), ISNULL(ISNULL(NULL , a.Ruta),''),    
       ISNULL(v.PosicionWMS, a.DefPosicionSurtido), v.Sucursal,s.Sucursal,s.Nombre,v.Observaciones)       --BUG24685
GO

--REQ12615 WMS
/**************** fnWMSPosicionDestinoLista ****************/
IF EXISTS (SELECT name FROM SysObjects WHERE name = 'fnWMSPosicionDestinoLista' AND type IN ('TF','FN')) DROP FUNCTION fnWMSPosicionDestinoLista
GO
CREATE FUNCTION fnWMSPosicionDestinoLista (@Almacen varchar(20), @Articulo varchar(20), @Tipo varchar(20), @Empresa char(5) = NULL, @Tarima varchar(20) = NULL,  @TMAID int = NULL, @ValidarCapacidad bit = 0) 
RETURNS @Resultado TABLE (
                          Almacen      varchar(10), 
						  Posicion     varchar(10), 
						  Tipo         varchar(20), 
						  Descripcion  varchar(100), 
						  Pasillo      int, 
						  Fila         int, 
						  Nivel        int, 
						  Zona         varchar(50), 
						  Capacidad    int, 
						  Estatus	   varchar(15), 
						  ArticuloEsp  varchar(20), 
						  Alto         float, 
						  Largo        float, 
						  Ancho        float, 
						  Volumen      float, 
						  PesoMaximo   float, 
						  Orden        int, 
						  TipoRotacion varchar(10),
                          Subtipo      varchar(20)
						  )
AS BEGIN
	DECLARE
		@MovTipo	varchar(20)


	IF EXISTS (SELECT * FROM ArtZona WHERE Articulo = @Articulo AND NULLIF(NULLIF(Zona, '(Todas)'), '') IS NULL) 
OR NOT EXISTS (SELECT * FROM ArtZona WHERE Articulo = @Articulo)
	INSERT @Resultado
	SELECT Almacen, Posicion, Tipo, Descripcion, Pasillo, Fila, Nivel, ISNULL(NULLIF(Zona, ''), ''), Capacidad, Estatus, ArticuloEsp, Alto, Largo, Ancho, Volumen, PesoMaximo, Orden, TipoRotacion,
           CASE WHEN Tipo = 'Ubicacion' AND ISNULL(Zona,'') = '' AND ISNULL(ArticuloEsp,'') = '' THEN 'Caótica'
                WHEN Tipo = 'Ubicacion' AND ISNULL(Zona,'') <> '' AND ISNULL(ArticuloEsp,'') = '' THEN 'Semi Caótica'
                ELSE 'Específica' END Subtipo
	  FROM AlmPos 
	 WHERE CASE WHEN (@Tipo <> 'Surtido' AND Tipo IN( 'Ubicacion', 'Domicilio', 'Surtido', 'Recibo')) 
				  OR (@Tipo = 'Surtido' AND Tipo IN( 'Ubicacion', 'Domicilio')) 
				THEN 1 
				ELSE 0 
		   END = 1
	   AND ISNULL(NULLIF(ArticuloEsp,''), @Articulo) = @Articulo
	   AND Almacen = @Almacen
	   AND Estatus='ALTA' --BUG7673 USB 07.04.2016 Se filtra el estatus para mostrar solo altas.
	ELSE
	INSERT @Resultado
	SELECT Almacen, Posicion, Tipo, Descripcion, Pasillo, Fila, Nivel, ISNULL(NULLIF(Zona, ''), ''), Capacidad, Estatus, ArticuloEsp, Alto, Largo, Ancho, Volumen, PesoMaximo, Orden, TipoRotacion,
           CASE WHEN Tipo = 'Ubicacion' AND ISNULL(Zona,'') = '' AND ISNULL(ArticuloEsp,'') = '' THEN 'Caótica'
                WHEN Tipo = 'Ubicacion' AND ISNULL(Zona,'') <> '' AND ISNULL(ArticuloEsp,'') = '' THEN 'Semi Caótica'
                ELSE 'Específica' END Subtipo
	  FROM AlmPos
	 WHERE CASE WHEN @Tipo <> 'Surtido' AND Tipo IN('Domicilio') 
				THEN 1 
				ELSE 0 
		   END = 1
	   AND ISNULL(NULLIF(ArticuloEsp,''), @Articulo) = @Articulo
	   AND Almacen = @Almacen
	   AND Estatus='ALTA' --BUG7673 USB 07.04.2016 Se filtra el estatus para mostrar solo altas.
	 UNION ALL
	SELECT Almacen, Posicion, Tipo, Descripcion, Pasillo, Fila, Nivel, ISNULL(NULLIF(Zona, ''), ''), Capacidad, Estatus, ArticuloEsp, Alto, Largo, Ancho, Volumen, PesoMaximo, Orden, TipoRotacion,
           CASE WHEN Tipo = 'Ubicacion' AND ISNULL(Zona,'') = '' AND ISNULL(ArticuloEsp,'') = '' THEN 'Caótica'
                WHEN Tipo = 'Ubicacion' AND ISNULL(Zona,'') <> '' AND ISNULL(ArticuloEsp,'') = '' THEN 'Semi Caótica'
                ELSE 'Específica' END Subtipo
	  FROM AlmPos
	 WHERE CASE WHEN (@Tipo <> 'Surtido' AND Tipo IN( 'Ubicacion', 'Surtido', 'Recibo')) 
				  OR (@Tipo = 'Surtido' AND Tipo IN( 'Ubicacion', 'Domicilio')) 
				THEN 1 
				ELSE 0
		   END = 1
	   AND ISNULL(NULLIF(ArticuloEsp,''), @Articulo) = @Articulo
	   AND ISNULL(NULLIF(NULLIF(Zona, '(Todas)'), ''), '') IN  (SELECT ISNULL(Zona, '') FROM ArtZona WHERE Articulo = @Articulo)
	   AND Almacen = @Almacen
	   AND Estatus='ALTA' --BUG7673 USB 07.04.2016 Se filtra el estatus para mostrar solo altas.
	 UNION ALL
	SELECT Almacen, Posicion, Tipo, Descripcion, Pasillo, Fila, Nivel, ISNULL(NULLIF(Zona, ''), ''), Capacidad, Estatus, ArticuloEsp, Alto, Largo, Ancho, Volumen, PesoMaximo, Orden, TipoRotacion,
           CASE WHEN Tipo = 'Ubicacion' AND ISNULL(Zona,'') = '' AND ISNULL(ArticuloEsp,'') = '' THEN 'Caótica'
                WHEN Tipo = 'Ubicacion' AND ISNULL(Zona,'') <> '' AND ISNULL(ArticuloEsp,'') = '' THEN 'Semi Caótica'
                ELSE 'Específica' END Subtipo
	  FROM AlmPos
	 WHERE 1 = CASE WHEN (@Tipo <> 'Surtido' AND Tipo IN( 'Ubicacion', 'Domicilio', 'Surtido', 'Recibo'))OR (@Tipo = 'Surtido' AND Tipo IN( 'Ubicacion', 'Domicilio')) THEN 1 ELSE 0 END
	   AND ISNULL(NULLIF(ArticuloEsp,''), @Articulo) = @Articulo
	   AND ISNULL(NULLIF(NULLIF(Zona, '(Todas)'), ''), '') = ''
	   AND Almacen = @Almacen
	   AND Estatus='ALTA' --BUG7673 USB 07.04.2016 Se filtra el estatus para mostrar solo altas.

	SELECT @MovTipo = Clave FROM TMA A JOIN MOVTIPO B ON A.Mov = B.Mov AND B.Modulo = 'TMA' WHERE A.ID = @TMAID

	IF @ValidarCapacidad = 1 AND @TMAID IS NOT NULL
	BEGIN 
		IF @MovTipo = 'TMA.SADO'
			DELETE @Resultado
			 WHERE dbo.fnAlmPosTieneCapacidadWMS (@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 0
			   AND Tipo <> 'DOMICILIO'
			   
		IF @MovTipo <> 'TMA.SADO'
			DELETE @Resultado
			 WHERE dbo.fnAlmPosTieneCapacidadWMS (@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 0
	 END
	INSERT @Resultado
	SELECT Almacen, Posicion, Tipo, Descripcion, Pasillo, Fila, Nivel, ISNULL(NULLIF(Zona, ''), ''), Capacidad, Estatus, ArticuloEsp, Alto, Largo, Ancho, Volumen, PesoMaximo, Orden, TipoRotacion,
           CASE WHEN Tipo = 'Ubicacion' AND ISNULL(Zona,'') = '' AND ISNULL(ArticuloEsp,'') = '' THEN 'Caótica'
                WHEN Tipo = 'Ubicacion' AND ISNULL(Zona,'') <> '' AND ISNULL(ArticuloEsp,'') = '' THEN 'Semi Caótica'
                ELSE 'Específica' END Subtipo
	  FROM AlmPos
	 WHERE Tipo = 'Cross Docking'
       AND Almacen = @Almacen  
	   AND Estatus='ALTA' --BUG7673 USB 07.04.2016 Se filtra el estatus para mostrar solo altas.
	 
	RETURN
END
GO

--REQ12615 WMS
/**************** fnWMSTarimaPCK ****************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'fnWMSTarimaPCK' AND type IN ('TF','FN','IF')) DROP FUNCTION fnWMSTarimaPCK
GO
CREATE FUNCTION fnWMSTarimaPCK (@TarimaPCK varchar(20))
RETURNS VARCHAR (20)
AS BEGIN
  DECLARE 
    @Tarima		varchar(20)
  
  IF CHARINDEX('-', @TarimaPCK, 1) > 0
    SELECT @Tarima = SUBSTRING(@TarimaPCK, 1, CHARINDEX('-', @TarimaPCK, 1)-1)
  ELSE
    SELECT @Tarima = @TarimaPCK
    
  RETURN (@Tarima)       
END
GO

--REQ12615 WMS
/**************** fnWMSOrdenSurtidoPendiente ****************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'fnWMSOrdenSurtidoPendiente' AND type IN ('TF','FN','IF')) DROP FUNCTION fnWMSOrdenSurtidoPendiente
GO
CREATE FUNCTION fnWMSOrdenSurtidoPendiente (@Tarima varchar(20), @Articulo varchar(20))
RETURNS TABLE
AS
RETURN (
  SELECT ID, Mov, MovID, Articulo, SUM(Cantidad) Cantidad, Almacen, Tipo, Tarima, PCK, Renglon  
    FROM
    (  
    SELECT v.ID, v.Mov, v.MovID, a.Articulo, ISNULL(d.CantidadPendiente, d.CantidadPicking) Cantidad, d.Almacen, 1 Tipo, d.Tarima, CASE WHEN m.SubClave = 'TMA.OSURP' THEN 1 ELSE 0 END PCK, d.Renglon
      FROM TMAD d
      JOIN TMA v ON v.ID = d.ID
      JOIN MovTipo m ON m.Modulo = 'TMA' AND m.Mov = v.Mov
      JOIN ArtDisponibleTarima a ON a.Tarima = d.Tarima
     WHERE v.TarimaSurtido = @Tarima
       AND a.Articulo = ISNULL(@Articulo, a.Articulo)
       AND v.Estatus IN('PENDIENTE')
       AND m.Clave = 'TMA.OSUR'
     UNION ALL
    SELECT o.ID, o.Mov, o.MovID, a.Articulo, -ISNULL(NULLIF(d.CantidadPendiente,0), a.Disponible) Cantidad, d.Almacen, 1 Tipo, od.Tarima, CASE WHEN m.SubClave = 'TMA.TSURP' THEN 1 ELSE 0 END PCK, d.Renglon
      FROM TMAD d
      JOIN TMA v ON v.ID = d.ID
      JOIN TMA o ON o.Mov = v.Origen and o.MovID = v.OrigenID
      JOIN TMAD od ON o.ID = od.ID
      JOIN MovTipo m ON m.Modulo = 'TMA' AND m.Mov = v.Mov
      JOIN ArtDisponibleTarima a ON a.Tarima = d.Tarima and od.Tarima = dbo.fnWMSTarimaPCK(d.Tarima)
   WHERE v.TarimaSurtido = @Tarima
     AND a.Articulo = ISNULL(@Articulo, a.Articulo)
     AND v.Estatus IN('PROCESAR')
     AND m.Clave = 'TMA.TSUR'
     ) x
     GROUP BY ID, Mov, MovID, Articulo, Almacen, Tipo, Tarima, PCK, Renglon
     HAVING SUM(Cantidad) > 0
       )
GO

--REQ12615 WMS
/**************** fnWMSSurtidoTransitoProcesar ****************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'fnWMSSurtidoTransitoProcesar' AND type IN ('TF','FN','IF')) DROP FUNCTION fnWMSSurtidoTransitoProcesar
GO
CREATE FUNCTION fnWMSSurtidoTransitoProcesar (@Tarima varchar(20), @Articulo varchar(20))
RETURNS TABLE
AS
RETURN (
  SELECT v.ID, v.Mov, v.MovID, a.Articulo, ISNULL(NULLIF(d.CantidadPendiente,0), a.Disponible) Cantidad, d.Almacen, 3 Tipo, d.Tarima, CASE WHEN m.SubClave = 'TMA.TSURP' THEN 1 ELSE 0 END PCK, d.Renglon
    FROM TMAD d
    JOIN TMA v ON v.ID = d.ID
    JOIN MovTipo m ON m.Modulo = 'TMA' AND m.Mov = v.Mov
    JOIN ArtDisponibleTarima a ON a.Tarima = d.Tarima
   WHERE v.TarimaSurtido = @Tarima
     AND a.Articulo = ISNULL(@Articulo, a.Articulo)
     AND v.Estatus IN('PROCESAR')
     AND m.Clave = 'TMA.TSUR'
       )
GO

--REQ12615 WMS
/**************** fnWMSSurtidoConcluido ****************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'fnWMSSurtidoConcluido' AND type IN ('TF','FN','IF')) DROP FUNCTION fnWMSSurtidoConcluido
GO
CREATE FUNCTION fnWMSSurtidoConcluido (@Tarima varchar(20), @Articulo varchar(20))
RETURNS TABLE
AS
RETURN (
  SELECT v.ID, v.Mov, v.MovID, a.Articulo, d.CantidadPicking Cantidad, d.Almacen, 2 Tipo, dbo.fnWMSTarimaPCK(d.Tarima) Tarima, CASE WHEN mt.SubClave = 'TMA.TSURP' THEN 1 ELSE 0 END PCK, d.Renglon
    FROM TMAD d
    JOIN TMA v ON v.ID = d.ID
    JOIN MovTipo m ON m.Modulo = 'TMA' AND m.Mov = v.Mov
    JOIN ArtDisponibleTarima a ON a.Tarima = d.Tarima
    JOIN TMA tm ON tm.Mov = v.Origen AND tm.MovID = v.OrigenID AND tm.OrigenTipo = 'TMA' and tm.Empresa = v.Empresa
    JOIN TMAD td ON tm.ID = td.ID AND td.Renglon = d.Renglon
    JOIN MovTipo mt ON mt.Modulo = 'TMA' AND mt.Mov = tm.Mov
    JOIN ArtDisponibleTarima at ON at.Tarima = td.Tarima AND at.Articulo = a.Articulo
   WHERE d.Tarima = @Tarima
     AND a.Articulo = ISNULL(@Articulo, a.Articulo)
     AND v.Estatus IN('CONCLUIDO')
     AND m.Clave = 'TMA.SUR'
     AND mt.Clave = 'TMA.TSUR'
     AND at.Tarima = ISNULL(d.TarimaPCK, at.Tarima)
   UNION ALL
  SELECT v.ID, v.Mov, v.MovID, a.Articulo, d.CantidadPicking Cantidad, d.Almacen, 2 Tipo, dbo.fnWMSTarimaPCK(d.Tarima) Tarima, CASE WHEN mt.SubClave = 'TMA.TSURP' THEN 1 ELSE 0 END PCK, d.Renglon
    FROM TMAD d
    JOIN TMA v ON v.ID = d.ID
    JOIN MovTipo m ON m.Modulo = 'TMA' AND m.Mov = v.Mov
    JOIN ArtDisponibleTarima a ON a.Tarima = d.Tarima
    JOIN TMA tm ON tm.Mov = d.Aplica AND tm.MovID = d.AplicaID AND tm.Empresa = v.Empresa
    JOIN TMAD td ON td.ID = tm.ID AND d.AplicaRenglon = td.Renglon
    JOIN MovTipo mt ON mt.Modulo = 'TMA' AND mt.Mov = tm.Mov
    JOIN ArtDisponibleTarima at ON at.Tarima = dbo.fnWMSTarimaPCK(td.Tarima)
   WHERE d.Tarima = @Tarima
     AND a.Articulo = ISNULL(@Articulo, a.Articulo)
     AND at.Articulo = ISNULL(@Articulo, at.Articulo)
     AND v.Estatus IN('CONCLUIDO')
     AND m.Clave = 'TMA.SUR'
     AND mt.Clave = 'TMA.TSUR'
     AND mt.SubClave = 'TMA.TSURP'     
       )
GO

--REQ12615 WMS
/**************** fnWMSEnSurtido ****************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'fnWMSEnSurtido' AND type IN ('TF','FN','IF')) DROP FUNCTION fnWMSEnSurtido
GO
CREATE FUNCTION fnWMSEnSurtido (@Tarima varchar(20), @Articulo varchar(20))
RETURNS TABLE
AS
RETURN (
  SELECT * FROM dbo.fnWMSOrdenSurtidoPendiente(@Tarima, @Articulo)
   UNION ALL
  SELECT * FROM dbo.fnWMSSurtidoTransitoProcesar(@Tarima, @Articulo)
   UNION ALL
  SELECT * FROM dbo.fnWMSSurtidoConcluido(@Tarima, @Articulo)   
       )
GO

--REQ12615 WMS
/**************** fnWMSEnSurtidoACancelar ****************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'fnWMSEnSurtidoACancelar' AND type IN ('TF','FN','IF')) DROP FUNCTION fnWMSEnSurtidoACancelar
GO
CREATE FUNCTION fnWMSEnSurtidoACancelar (@Tarima varchar(20), @Articulo varchar(20), @CantidadACancelar float)
RETURNS @Tabla TABLE (
		ID					int,
		Mov					varchar(20),
		MovID				varchar(20),
		Articulo			varchar(20),
		Cantidad			float,
		Almacen				varchar(10),
		Tipo				varchar(20),
		Tarima				varchar(20),
		PCK					float,
		CantidadAfectar		float,
		Renglon				int
		)

AS BEGIN   
  DECLARE  
    @WMSID					int,
    @WMSMov					varchar(20),
    @WMSMovID				varchar(20),
    @WMSArticulo			varchar(20),
    @WMSCantidad			float,
    @WMSAlmacen				varchar(10),
    @WMSTipo				varchar(20),
    @WMSTarima				varchar(20),
    @IDGenerar				int,
    @MovGenerar				varchar(20),
    @PCK					float,
    @WMSRenglon				int

  DECLARE crResurtido CURSOR LOCAL FOR
   SELECT ID, Mov, MovID, Articulo, Cantidad, Almacen, Tipo, Tarima, PCK, Renglon
     FROM dbo.fnWMSEnSurtido(@Tarima, @Articulo)
    ORDER BY Tipo, Cantidad

  OPEN crResurtido
  FETCH NEXT FROM crResurtido INTO @WMSID, @WMSMov, @WMSMovID, @WMSArticulo, @WMSCantidad, @WMSAlmacen, @WMSTipo, @WMSTarima, @PCK, @WMSRenglon
  WHILE @@FETCH_STATUS = 0 AND @CantidadACancelar > 0
  BEGIN  
        
    INSERT INTO @Tabla
    SELECT @WMSID, @WMSMov, @WMSMovID, @WMSArticulo, @WMSCantidad, @WMSAlmacen, @WMSTipo, @WMSTarima, @PCK, CASE WHEN @CantidadACancelar > @WMSCantidad THEN @WMSCantidad ELSE @CantidadACancelar END, @WMSRenglon

    SELECT @CantidadACancelar = @CantidadACancelar - @WMSCantidad

    FETCH NEXT FROM crResurtido INTO @WMSID, @WMSMov, @WMSMovID, @WMSArticulo, @WMSCantidad, @WMSAlmacen, @WMSTipo, @WMSTarima, @PCK, @WMSRenglon
  END  
  CLOSE crResurtido
  DEALLOCATE crResurtido
  
  DELETE @Tabla WHERE CantidadAfectar <= 0

  RETURN 
END
GO

--REQ12615 WMS
/**************** fnWMSPorSurtir ****************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'fnWMSPorSurtir' AND type IN ('TF','FN','IF')) DROP FUNCTION fnWMSPorSurtir
GO
CREATE FUNCTION fnWMSPorSurtir (@Tarima varchar(20))
RETURNS TABLE
AS
RETURN (
  SELECT x.Articulo, SUM(x.Cantidad) Cantidad 
    FROM(
         SELECT d.Articulo, SUM(ISNULL(NULLIF(ISNULL(d.CantidadPendiente, 0.00) + ISNULL(d.CantidadReservada, 0.00),0.00),d.Cantidad - ISNULL(d.CantidadCancelada, 0.00) * CASE	WHEN v.Estatus = 'CANCELADO' THEN 0 ELSE 1 END)) Cantidad
           FROM VentaD d
           JOIN Venta v ON v.ID = d.ID
           JOIN WMSModuloMovimiento w ON w.Modulo = 'VTAS' AND w.Movimiento = v.Mov-- AND w.Estatus = v.Estatus
          WHERE d.Tarima = @Tarima
            AND v.Estatus <> 'SINAFECTAR'
          GROUP BY d.Articulo
          UNION ALL
         SELECT d.Articulo, SUM(ISNULL(NULLIF(ISNULL(d.CantidadPendiente, 0.00) + ISNULL(d.CantidadReservada, 0.00),0.00),d.Cantidad - ISNULL(d.CantidadCancelada, 0.00) * CASE	WHEN v.Estatus = 'CANCELADO' THEN 0 ELSE 1 END)) Cantidad
           FROM InvD d
           JOIN Inv v ON v.ID = d.ID
           JOIN WMSModuloMovimiento w ON w.Modulo = 'INV' AND w.Movimiento = v.Mov-- AND w.Estatus = v.Estatus
          WHERE d.Tarima = @Tarima
            AND v.Estatus <> 'SINAFECTAR'
          GROUP BY d.Articulo
          UNION ALL
         SELECT d.Articulo, SUM(ISNULL(NULLIF(ISNULL(d.CantidadPendiente, 0.00),0.00),d.Cantidad - ISNULL(d.CantidadCancelada, 0.00) * CASE	WHEN v.Estatus = 'CANCELADO' THEN 0 ELSE 1 END)) Cantidad
           FROM CompraD d
           JOIN Compra v ON v.ID = d.ID
           JOIN WMSModuloMovimiento w ON w.Modulo = 'COMS' AND w.Movimiento = v.Mov-- AND w.Estatus = v.Estatus
          WHERE d.Tarima = @Tarima
            AND v.Estatus <> 'SINAFECTAR'
          GROUP BY d.Articulo
         ) x
    GROUP BY x.Articulo
       )
GO

--REQ12615 WMS
/**************** fnWMSEnSurtidoPorArticulo ****************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'fnWMSEnSurtidoPorArticulo' AND type IN ('TF','FN','IF')) DROP FUNCTION fnWMSEnSurtidoPorArticulo
GO
CREATE FUNCTION fnWMSEnSurtidoPorArticulo (@Tarima varchar(20))
RETURNS @Tabla TABLE 
       (
		Articulo			varchar(20),
		Cantidad			float
	   )
AS BEGIN   
  DECLARE  
    @Articulo		varchar(20)

  DECLARE crSurtidoPorArticulo CURSOR LOCAL FOR
   SELECT Articulo
     FROM dbo.fnWMSEnSurtido(@Tarima, NULL)
    GROUP BY Articulo

  OPEN crSurtidoPorArticulo
  FETCH NEXT FROM crSurtidoPorArticulo INTO @Articulo
  WHILE @@FETCH_STATUS = 0
  BEGIN  
        
    INSERT INTO @Tabla
    SELECT x.Articulo, SUM(x.Cantidad) Cantidad 
      FROM(
           SELECT Articulo, Cantidad 
             FROM dbo.fnWMSEnSurtido(@Tarima, @Articulo)
           ) x
      GROUP BY x.Articulo

    FETCH NEXT FROM crSurtidoPorArticulo INTO @Articulo
  END  
  CLOSE crSurtidoPorArticulo
  DEALLOCATE crSurtidoPorArticulo

  RETURN
END       
GO

--REQ12615 WMS
/**************** fnWMSPorSurtirEnSurtidoPerdido ****************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'fnWMSPorSurtirEnSurtidoPerdido' AND type IN ('TF','FN','IF')) DROP FUNCTION fnWMSPorSurtirEnSurtidoPerdido
GO
CREATE FUNCTION fnWMSPorSurtirEnSurtidoPerdido (@Tarima varchar(20))
RETURNS bit
AS BEGIN
  DECLARE @Resultado bit
  SELECT @Resultado = 0
  
  IF (SELECT SUM(Cantidad) from dbo.fnWMSPorSurtir(@Tarima))- (SELECT SUM(Cantidad) from dbo.fnWMSEnSurtidoPorArticulo(@Tarima)) = 0
  BEGIN
    IF NOT EXISTS(SELECT 1 FROM TMA t JOIN TMAD d ON t.ID = d.ID WHERE Mov IN(SELECT Mov FROM MovTipo WHERE Modulo = 'TMA' AND Clave = 'TMA.SURPER' AND d.Tarima = @Tarima) AND t.Estatus = 'CONCLUIDO') OR
    NOT EXISTS(SELECT 1 FROM TMA t JOIN TMAD d ON t.ID = d.ID WHERE Mov IN(SELECT Mov FROM MovTipo WHERE Modulo = 'TMA' AND Clave = 'TMA.SUR' AND d.Tarima = @Tarima) AND t.Estatus = 'CONCLUIDO')
      SELECT @Resultado = 1
  END
        
  RETURN (@Resultado)
END
GO

--REQ12615 WMS
/**************** fnWMSEnSurtidoACancelarPorArticulo ****************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'fnWMSEnSurtidoACancelarPorArticulo' AND type IN ('TF','FN','IF')) DROP FUNCTION fnWMSEnSurtidoACancelarPorArticulo
GO
CREATE FUNCTION fnWMSEnSurtidoACancelarPorArticulo (@Tarima varchar(20))
RETURNS TABLE
AS
RETURN (
  SELECT x.Articulo, SUM(x.Cantidad) Cantidad 
    FROM(
         SELECT Articulo, -CASE WHEN dbo.fnWMSPorSurtirEnSurtidoPerdido(@Tarima) = 1 THEN Cantidad - Cantidad ELSE Cantidad END Cantidad FROM dbo.fnWMSPorSurtir(@Tarima)
          UNION ALL
         SELECT Articulo,  Cantidad Cantidad FROM dbo.fnWMSEnSurtidoPorArticulo(@Tarima)
          UNION ALL
         SELECT a.Articulo, -d.CantidadPicking Cantidad
           FROM TMA t JOIN TMAD d
             ON t.ID = d.ID JOIN ArtDisponibleTarima a
             ON d.Tarima = a.Tarima JOIN MovTipo m
             ON m.Modulo = 'TMA' AND m.Mov = t.Mov
          WHERE m.Clave = 'TMA.SURPER' AND TarimaSurtido = @Tarima
          UNION ALL
         SELECT d.Articulo, -d.Cantidad
           FROM Inv i JOIN InvD d 
             ON i.ID = d.ID JOIN MovTipo m
             ON i.Mov = m.Mov AND m.Modulo = 'INV'
          WHERE d.Tarima = @Tarima AND m.Clave = 'INV.T' AND m.SubClave = 'INV.TMA'
         ) x
    GROUP BY x.Articulo
    HAVING(SUM(x.Cantidad)) > 0
       )
GO

--REQ12615 WMS
/**************** fnWMSListaResurtirTarima ****************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'fnWMSListaResurtirTarima' AND type IN ('TF','FN','IF')) DROP FUNCTION fnWMSListaResurtirTarima
GO
CREATE FUNCTION fnWMSListaResurtirTarima (@ID int, @Modulo char(5))
RETURNS bit
AS
BEGIN
  DECLARE @Resultado bit,
          @Tarima varchar(20)
  
  IF @Modulo = 'VTAS'
    DECLARE crTarima CURSOR FOR
     SELECT vd.Tarima
       FROM Venta v
       JOIN VentaD vd ON v.ID = vd.ID AND NULLIF(vd.Tarima,'') IS NOT NULL
      WHERE v.ID = @ID
  ELSE
  IF @Modulo = 'COMS'
    DECLARE crTarima CURSOR FOR
     SELECT vd.Tarima
       FROM Compra v
       JOIN CompraD vd ON v.ID = vd.ID AND NULLIF(vd.Tarima,'') IS NOT NULL
      WHERE v.ID = @ID
  ELSE
  IF @Modulo = 'INV'
    DECLARE crTarima CURSOR FOR
     SELECT vd.Tarima
       FROM Inv v
       JOIN InvD vd ON v.ID = vd.ID AND NULLIF(vd.Tarima,'') IS NOT NULL
      WHERE v.ID = @ID
  
  OPEN crTarima  
  FETCH NEXT FROM crTarima INTO @Tarima
  WHILE @@FETCH_STATUS <> -1   
  BEGIN  
    IF @@FETCH_STATUS <> -2   
    BEGIN  
              
      IF EXISTS(SELECT * FROM dbo.fnWMSEnSurtidoACancelarPorArticulo(@Tarima))
        SELECT @Resultado = 0
      ELSE
        SELECT @Resultado = 1
    END  
    FETCH NEXT FROM crTarima INTO @Tarima
  END -- While  
  CLOSE crTarima  
  DEALLOCATE crTarima  

  RETURN(@Resultado)
END
GO

--REQ12615 WMS
/**************** fnWMSListaResurtir ****************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'fnWMSListaResurtir' AND type IN ('TF','FN','IF')) DROP FUNCTION fnWMSListaResurtir
GO
CREATE FUNCTION fnWMSListaResurtir (@Estacion int, @Empresa char(5))
RETURNS TABLE
AS
RETURN (
SELECT v.ID, v.Mov, v.MovID, v.FechaEmision, v.FechaRequerida, v.Cliente Contacto, 
       ISNULL(ISNULL(ca.Direccion, c.Direccion),'') + ' - ' + ISNULL(ISNULL(ca.DireccionNumero , c.DireccionNumero),'') + ' ' + ISNULL(ISNULL(ca.DireccionNumeroInt , c.DireccionNumeroInt),'') +
       ISNULL(ISNULL(ca.Delegacion, c.Delegacion),'') + ', ' + ISNULL(ISNULL(ca.Estado, c.Estado),'') Direccion,
       ISNULL(ISNULL(ca.CodigoPostal , c.CodigoPostal),'') CodigoPostal, ISNULL(ISNULL(ca.Ruta , c.Ruta),'') Ruta,
       CASE ISNULL(e.WMSAndenSurtidoContacto,0) WHEN 1 THEN c.DefPosicionSurtido ELSE ISNULL(v.PosicionWMS, a.DefPosicionSurtido) END AndenSurtido, 'VTAS' Modulo, v.Sucursal
  FROM WMSModuloMovimiento wm
  JOIN Venta v ON wm.Modulo = 'VTAS' AND wm.Movimiento = v.Mov
  JOIN Cte c ON v.Cliente = c.Cliente
  JOIN VentaD vd ON v.ID = vd.ID AND NULLIF(vd.Tarima,'') IS NOT NULL AND ISNULL(NULLIF(ISNULL(vd.CantidadReservada,0.00) + ISNULL(vd.CantidadPendiente,0.00),0.00),vd.Cantidad) > 0
  JOIN Alm a ON vd.Almacen = a.Almacen
  LEFT JOIN CteEnviarA ca ON c.Cliente = ca.Cliente AND vd.EnviarA = ca.ID
  LEFT JOIN WMSModuloTarima wmt ON 'VTAS' = wmt.Modulo AND vd.ID = wmt.IDModulo AND vd.Renglon = wmt.Renglon AND vd.RenglonSub = wmt.RenglonSub AND wmt.Tarima IS NOT NULL
  JOIN Alm l ON l.Almacen = v.Almacen AND l.WMS = 1
  JOIN EmpresaCfg e ON e.Empresa = @Empresa
  JOIN MovTipo m ON v.Mov = m.Mov AND m.Modulo = 'VTAS'
  LEFT OUTER JOIN EmpresaCfg2 g ON v.Empresa = g.Empresa
  LEFT OUTER JOIN Unidad u ON vd.Unidad = u.Unidad
  LEFT OUTER JOIN ArtUnidad au ON vd.Articulo = au.Articulo AND vd.Unidad = au.Unidad
  LEFT OUTER JOIN RepParam p ON p.Estacion = @Estacion
  LEFT OUTER JOIN Venta va ON va.Origen = v.Mov AND va.OrigenID = v.MovID AND va.Empresa = v.Empresa AND va.Estatus <> 'CANCELADO'
  LEFT OUTER JOIN MovTipo ma ON va.Mov = ma.Mov AND ma.Modulo = 'VTAS'
 WHERE v.Cliente = CASE ISNULL(NULLIF(p.InfoContacto,''),'(Todos)')
					 WHEN '(Todos)' THEN v.Cliente
					 WHEN 'Cliente' THEN ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoEspecifico)),''), v.Cliente)
					 ELSE ''
				   END
   AND ISNULL(v.FechaEmision,'') = CASE WHEN ISNULL(p.InfoFechaEmision,'') = '' THEN ISNULL(v.FechaEmision,'') ELSE ISNULL(p.infoFechaEmision,'') END
   AND ISNULL(v.FechaRequerida,'') = CASE WHEN ISNULL(p.InfoFechaRequerida,'') = '' THEN ISNULL(v.FechaRequerida,'') ELSE ISNULL(p.InfoFechaRequerida,'') END
   AND ISNULL(c.Categoria,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoCat)),''), ISNULL(c.Categoria,''))
   AND ISNULL(c.Grupo,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoGrupo)),''), ISNULL(c.Grupo,''))
   AND ISNULL(c.Familia,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoFam)),''), ISNULL(c.Familia,''))   
   AND ISNULL(c.Ruta,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoRuta)),''), ISNULL(c.Ruta,''))
   AND ISNULL(c.Estado,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoEstado)),''), ISNULL(c.Estado,''))
   AND ISNULL(c.Zona,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoZona)),''), ISNULL(c.Zona,''))
   AND ISNULL(c.Pais,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoPais)),''), ISNULL(c.Pais,''))
   AND ISNULL(c.CodigoPostal,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoCP)),''), ISNULL(c.CodigoPostal,''))
   AND dbo.fnWMSListaResurtirTarima(v.id, 'VTAS') = 0
   AND ma.Clave NOT IN('VTAS.F')
 GROUP BY v.ID, v.Mov, v.MovID, v.FechaEmision, v.FechaRequerida, v.Cliente,
       ISNULL(ISNULL(ca.Direccion, c.Direccion),'') + ' - ' + ISNULL(ISNULL(ca.DireccionNumero , c.DireccionNumero),'') + ' ' + ISNULL(ISNULL(ca.DireccionNumeroInt , c.DireccionNumeroInt),'') +
       ISNULL(ISNULL(ca.Delegacion, c.Delegacion),'') + ', ' + ISNULL(ISNULL(ca.Estado, c.Estado),''),
       ISNULL(ISNULL(ca.CodigoPostal , c.CodigoPostal),''), ISNULL(ISNULL(ca.Ruta , c.Ruta),''),
       ISNULL(v.PosicionWMS, a.DefPosicionSurtido), v.Sucursal, e.WMSAndenSurtidoContacto, c.DefPosicionSurtido
       
UNION ALL
SELECT v.ID, v.Mov, v.MovID, v.FechaEmision, v.FechaRequerida, v.Proveedor, 
       ISNULL(ISNULL(NULL, c.Direccion),'') + ' - ' + ISNULL(ISNULL(NULL , c.DireccionNumero),'') + ' ' + ISNULL(ISNULL(NULL , c.DireccionNumeroInt),'') +
       ISNULL(ISNULL(NULL, c.Delegacion),'') + ', ' + ISNULL(ISNULL(NULL, c.Estado),'') Direccion,
       ISNULL(ISNULL(NULL , c.CodigoPostal),'') CodigoPostal, ISNULL(ISNULL(NULL , c.Ruta),'') Ruta,
       CASE ISNULL(e.WMSAndenSurtidoContacto,0) WHEN 1 THEN c.DefPosicionSurtido ELSE ISNULL(ISNULL(c.DefPosicionSurtido, v.PosicionWMS), a.DefPosicionSurtido) END AndenSurtido,'COMS' Modulo, v.Sucursal
  FROM WMSModuloMovimiento wm
  JOIN Compra v ON wm.Modulo = 'COMS' AND wm.Movimiento = v.Mov
  JOIN Prov c ON v.Proveedor = c.Proveedor
  JOIN CompraD vd ON v.ID = vd.ID AND NULLIF(vd.Tarima,'') IS NOT NULL
  JOIN Alm a ON vd.Almacen = a.Almacen
  JOIN Alm l ON l.Almacen = v.Almacen AND l.WMS = 1
  JOIN EmpresaCfg e ON e.Empresa = @Empresa
  JOIN MovTipo m ON v.Mov = m.Mov AND m.Modulo = 'COMS'
  LEFT OUTER JOIN EmpresaCfg2 g ON v.Empresa = g.Empresa
  LEFT OUTER JOIN Unidad u ON vd.Unidad = u.Unidad
  LEFT OUTER JOIN ArtUnidad au ON vd.Articulo = au.Articulo AND vd.Unidad = au.Unidad
  LEFT OUTER JOIN RepParam p ON p.Estacion = @Estacion   
  LEFT OUTER JOIN Compra va ON va.Origen = v.Mov AND va.OrigenID = v.MovID AND va.Empresa = v.Empresa AND va.Estatus <> 'CANCELADO'
  LEFT OUTER JOIN MovTipo ma ON va.Mov = ma.Mov AND ma.Modulo = 'COMS'
 WHERE v.Proveedor = CASE ISNULL(NULLIF(p.InfoContacto,''),'(Todos)')
					 WHEN '(Todos)' THEN v.Proveedor
					 WHEN 'Proveedor' THEN ISNULL(NULLIF(p.InfoContactoEspecifico, ''),v.Proveedor)
					 ELSE ''
				   END
   AND ISNULL(v.FechaEmision,'') = CASE WHEN ISNULL(p.InfoFechaEmision,'') = '' THEN ISNULL(v.FechaEmision,'') ELSE ISNULL(p.infoFechaEmision,'') END
   AND ISNULL(v.FechaRequerida,'') = CASE WHEN ISNULL(p.InfoFechaRequerida,'') = '' THEN ISNULL(v.FechaRequerida,'') ELSE ISNULL(p.InfoFechaRequerida,'') END
   AND ISNULL(c.Categoria,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoCat)),''), ISNULL(c.Categoria,''))
   AND ISNULL(c.Familia,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoFam)),''), ISNULL(c.Familia,''))   
   AND ISNULL(c.Ruta,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoRuta)),''), ISNULL(c.Ruta,''))
   AND ISNULL(c.Estado,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoEstado)),''), ISNULL(c.Estado,''))
   AND ISNULL(c.Zona,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoZona)),''), ISNULL(c.Zona,''))
   AND ISNULL(c.Pais,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoPais)),''), ISNULL(c.Pais,''))
   AND ISNULL(c.CodigoPostal,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoCP)),''), ISNULL(c.CodigoPostal,''))
   AND dbo.fnWMSListaResurtirTarima(v.id, 'COMS') = 0
   AND ma.Clave NOT IN( 'COMS.F')
 GROUP BY v.ID, v.Mov, v.MovID, v.FechaEmision, v.FechaRequerida, v.Proveedor, 
       ISNULL(ISNULL(NULL, c.Direccion),'') + ' - ' + ISNULL(ISNULL(NULL , c.DireccionNumero),'') + ' ' + ISNULL(ISNULL(NULL , c.DireccionNumeroInt),'') +
       ISNULL(ISNULL(NULL, c.Delegacion),'') + ', ' + ISNULL(ISNULL(NULL, c.Estado),''),
       ISNULL(ISNULL(NULL , c.CodigoPostal),''), ISNULL(ISNULL(NULL , c.Ruta),''),
       ISNULL(ISNULL(c.DefPosicionSurtido, v.PosicionWMS), a.DefPosicionSurtido), v.Sucursal, e.WMSAndenSurtidoContacto, c.DefPosicionSurtido

UNION ALL
SELECT v.ID, v.Mov, v.MovID, v.FechaEmision, v.FechaRequerida, v.Almacen, 
       ISNULL(ISNULL(NULL, a.Direccion),'') + ' - ' + ISNULL(ISNULL(NULL , a.DireccionNumero),'') + ' ' + ISNULL(ISNULL(NULL , a.DireccionNumeroInt),'') +
       ISNULL(ISNULL(NULL, a.Delegacion),'') + ', ' + ISNULL(ISNULL(NULL, a.Estado),'') Direccion,
       ISNULL(ISNULL(NULL , a.CodigoPostal),'') CodigoPostal, ISNULL(ISNULL(NULL , a.Ruta),'') Ruta,
       ISNULL(v.PosicionWMS, a.DefPosicionSurtido) AndenSurtido, 'INV' Modulo, v.Sucursal
  FROM WMSModuloMovimiento wm
  JOIN Inv v ON wm.Modulo = 'INV' AND wm.Movimiento = v.Mov
  JOIN InvD vd ON v.ID = vd.ID AND NULLIF(vd.Tarima,'') IS NOT NULL AND ISNULL(NULLIF(ISNULL(vd.CantidadReservada,0.00) + ISNULL(vd.CantidadPendiente,0.00),0.00),vd.Cantidad) > 0
  JOIN Alm a ON vd.Almacen = a.Almacen
  JOIN MovTipo m ON v.Mov = m.Mov AND m.Modulo = 'INV'
  JOIN Alm l ON l.Almacen = v.Almacen AND l.WMS = 1
  LEFT OUTER JOIN EmpresaCfg2 g ON v.Empresa = g.Empresa
  LEFT OUTER JOIN Unidad u ON vd.Unidad = u.Unidad
  LEFT OUTER JOIN ArtUnidad au ON vd.Articulo = au.Articulo AND vd.Unidad = au.Unidad
  LEFT OUTER JOIN RepParam p ON p.Estacion = @Estacion   
  LEFT OUTER JOIN Inv va ON va.Origen = v.Mov AND va.OrigenID = v.MovID AND va.Empresa = v.Empresa AND va.Estatus <> 'CANCELADO'
  LEFT OUTER JOIN MovTipo ma ON va.Mov = ma.Mov AND ma.Modulo = 'INV'  
 WHERE v.Almacen = CASE ISNULL(NULLIF(p.InfoContacto,''),'(Todos)')
					 WHEN '(Todos)' THEN v.Almacen
					 WHEN 'Almacen' THEN ISNULL(NULLIF(p.InfoContactoEspecifico, ''),v.Almacen)
					 ELSE ''
				   END
   AND ISNULL(v.FechaEmision,'') = CASE WHEN ISNULL(p.InfoFechaEmision,'') = '' THEN ISNULL(v.FechaEmision,'') ELSE ISNULL(p.infoFechaEmision,'') END
   AND ISNULL(v.FechaRequerida,'') = CASE WHEN ISNULL(p.InfoFechaRequerida,'') = '' THEN ISNULL(v.FechaRequerida,'') ELSE ISNULL(p.InfoFechaRequerida,'') END
   AND ISNULL(a.Grupo,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoGrupo)),''), ISNULL(a.Grupo,''))
   AND ISNULL(a.Ruta,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoRuta)),''), ISNULL(a.Ruta,''))
   AND ISNULL(a.Estado,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoEstado)),''), ISNULL(a.Estado,''))
   AND ISNULL(a.Zona,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoZona)),''), ISNULL(a.Zona,''))
   AND ISNULL(a.Pais,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoPais)),''), ISNULL(a.Pais,''))
   AND ISNULL(a.CodigoPostal,'') = ISNULL(NULLIF(RTRIM(LTRIM(p.InfoContactoCP)),''), ISNULL(a.CodigoPostal,''))
   AND dbo.fnWMSListaResurtirTarima(v.id, 'INV') = 0
   AND ma.Clave NOT IN('INV.T', 'INV.EI')
 GROUP BY v.ID, v.Mov, v.MovID, v.FechaEmision, v.FechaRequerida, v.Almacen, 
       ISNULL(ISNULL(NULL, a.Direccion),'') + ' - ' + ISNULL(ISNULL(NULL , a.DireccionNumero),'') + ' ' + ISNULL(ISNULL(NULL , a.DireccionNumeroInt),'') +
       ISNULL(ISNULL(NULL, a.Delegacion),'') + ', ' + ISNULL(ISNULL(NULL, a.Estado),''),
       ISNULL(ISNULL(NULL , a.CodigoPostal),''), ISNULL(ISNULL(NULL , a.Ruta),''),
       ISNULL(v.PosicionWMS, a.DefPosicionSurtido), v.Sucursal
      )
GO

--REQ12615 WMS
/**************** fnWMSReferenciaHerramienta ****************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'fnWMSReferenciaHerramienta' AND type IN ('TF','FN','IF')) DROP FUNCTION fnWMSReferenciaHerramienta
GO
CREATE FUNCTION fnWMSReferenciaHerramienta (@ID int)
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Referencia			varchar(50),
    @Modulo				varchar(5),
    @IDModulo			int,
    @Almacen			varchar(20),
    @AlmacenDestino		varchar(20),
    @Sucursal			int,
    @SucursalDestino	int
  
  IF @Referencia IS NOT NULL
    RETURN (@Referencia)
  
  SELECT @Modulo = Modulo, @IDModulo = IDModulo, @Almacen = Almacen, @AlmacenDestino = AlmacenDestino
    FROM WMSModuloTarima
   WHERE ID = @ID
   
  SELECT @Sucursal = Sucursal FROM Alm WHERE Almacen = @Almacen
  SELECT @SucursalDestino = Sucursal FROM Alm WHERE Almacen = @AlmacenDestino
  
  IF @Modulo = 'VTAS'
    SELECT @Referencia = RTRIM(LTRIM(Mov)) + ' ' + RTRIM(LTRIM(MovID)) FROM Venta WHERE ID = @IDModulo
  ELSE
  IF @Modulo = 'COMS'
    SELECT @Referencia = RTRIM(LTRIM(Mov)) + ' ' + RTRIM(LTRIM(MovID)) FROM Compra WHERE ID = @IDModulo
  ELSE
  IF @Modulo = 'INV'
  BEGIN
    IF @Sucursal <> ISNULL(@SucursalDestino, @Sucursal)
      SELECT @Referencia = 'Sucursal Destino ' + CONVERT(varchar,@SucursalDestino) FROM Inv WHERE ID = @IDModulo
    ELSE
      SELECT @Referencia = RTRIM(LTRIM(Mov)) + ' ' + RTRIM(LTRIM(MovID)) FROM Inv WHERE ID = @IDModulo
  END
  ELSE
  IF @Modulo = 'PROD'
    SELECT @Referencia = RTRIM(LTRIM(Mov)) + ' ' + RTRIM(LTRIM(MovID)) FROM Prod WHERE ID = @IDModulo
    
  RETURN (@Referencia)
END
GO

--REQ12615 WMS
/**************** fnDesentarimadoSubGrupo ****************/
IF EXISTS (SELECT name FROM SysObjects WHERE name = 'fnDesentarimadoSubGrupo' AND type IN ('TF','FN')) DROP FUNCTION fnDesentarimadoSubGrupo
GO
CREATE FUNCTION fnDesentarimadoSubGrupo (@Aplica varchar(20), @AplicaID varchar(20), @Empresa char(5), @Mov varchar(20), @Grupo varchar(20), @SubGrupo varchar(20))
RETURNS varchar(20)
AS
BEGIN
  DECLARE
    @WMS			bit,
    @MovTipo		varchar(20),
    @IDAplica		varchar(20),
    @Aplica2		varchar(20),
    @AplicaID2		varchar(20),
    @IDAplica2		varchar(20)

  SELECT @WMS = WMS FROM Alm WHERE Almacen = @Grupo
  SELECT @MovTipo = Clave FROM MovTipo WHERE Modulo = 'INV' AND Mov = @Mov
  IF @WMS = 1 AND @MovTipo = 'INV.TMA' AND ISNULL(@SubGrupo,'') = ''
  BEGIN     
    SELECT @IDAplica = ID FROM Inv WHERE Mov = @Aplica AND MovID = @AplicaID AND Empresa = @Empresa
    SELECT @Aplica2 = Origen, @AplicaID2 = OrigenID FROM Inv WHERE ID = @IDAplica
    SELECT @IDAplica2 = ID FROM Inv WHERE Mov = @Aplica2 AND MovID = @AplicaID2 AND Empresa = @Empresa
    SELECT @SubGrupo = ISNULL(Tarima,@SubGrupo) FROM InvD WHERE ID = @IDAplica2 AND NULLIF(Tarima,'') IS NOT NULL  
  END
         
  RETURN (@SubGrupo)
END
GO

--BUG24589
--EWQ. Tuning
/**************** fnArtUnidadCantidadTarima ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnArtUnidadCantidadTarima') DROP FUNCTION fnArtUnidadCantidadTarima
GO
CREATE FUNCTION fnArtUnidadCantidadTarima(@Empresa varchar(5), @Articulo varchar(20), @Unidad varchar(50))
RETURNS float
AS BEGIN
  DECLARE
    @Resultado				float,
    @CfgMultiUnidadesNivel	varchar(20),
    @MultiUnidades          int --BUG6556

  SELECT @CfgMultiUnidadesNivel = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD'), 
         @MultiUnidades         = ISNULL(MultiUnidades,0) --BUG6556
    FROM EmpresaCfg2 WHERE Empresa = @Empresa

  SELECT @Resultado = NULL

  IF @MultiUnidades = 1 --BUG6556
  BEGIN
    IF @CfgMultiUnidadesNivel = 'ARTICULO'
	  SELECT @Resultado = NULLIF(CantidadCamaTarima, 0.0) --BUG3430
        FROM ArtUnidad WHERE Articulo = @Articulo AND Unidad = @Unidad
     --BUG6556
    ELSE
     IF @CfgMultiUnidadesNivel = 'UNIDAD'
	   SELECT @Resultado = NULLIF(CantidadTarima, 0.0) FROM Art WHERE Articulo = @Articulo
  END
  ELSE
    SELECT @Resultado = NULLIF(CantidadTarima, 0.0) FROM Art WHERE Articulo = @Articulo
	  
  RETURN(@Resultado)
END
GO

--BUG24589
--EWQ. Tuning
/**************** fnTMADomicilioDisponible50 ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTMADomicilioDisponible50') DROP FUNCTION fnTMADomicilioDisponible50
GO
CREATE FUNCTION fnTMADomicilioDisponible50 (@Empresa varchar(5), @Almacen varchar(10), @Articulo varchar(20), @TMAID int, @Tarima varchar(20))
RETURNS varchar(20)
AS BEGIN
  DECLARE
    @Resultado		varchar(20)

  SELECT @Resultado = NULL
-- --Domicilio con Capacidad
--  SELECT @Resultado = MIN(ap.Posicion)
--    FROM AlmPos ap
--   WHERE ap.Almacen = @Almacen AND ap.ArticuloEsp = @Articulo AND UPPER(ap.Tipo) = 'DOMICILIO' AND ap.Estatus = 'ALTA'
--     AND ap.Posicion NOT IN (SELECT PosicionDestino FROM TMAD WHERE ID = @TMAID)

  SELECT @Resultado = MIN(p.Posicion)
    FROM ArtDisponibleTarima a 
    JOIN Tarima t ON t.Tarima = a.Tarima 
    JOIN AlmPos p ON p.Posicion = t.Posicion  AND p.Almacen = @Almacen
   WHERE a.Articulo = @Articulo 
     AND p.Tipo = 'Domicilio' 
     AND a.Disponible > 0
     AND t.Estatus = 'ALTA' AND t.Tarima NOT LIKE '%-%'
     AND p.ArticuloEsp = @Articulo

  IF @Resultado IS NULL
    SELECT @Resultado = MIN(t.Posicion)
      FROM ArtDisponibleTarima a 
      JOIN Tarima t ON t.Tarima = a.Tarima 
      JOIN AlmPos p ON p.Posicion = t.Posicion  AND p.Almacen = @Almacen
     WHERE a.Articulo = @Articulo 
       AND p.Tipo = 'Domicilio' 
       AND t.Estatus = 'ALTA' AND t.Tarima NOT LIKE '%-%'
       AND p.ArticuloEsp = @Articulo

  IF @Resultado IS NULL
    SELECT @Resultado = MIN(t.Posicion)
      FROM ArtDisponibleTarima a 
      JOIN Tarima t ON t.Tarima = a.Tarima 
      JOIN AlmPos p ON p.Posicion = t.Posicion  AND p.Almacen = @Almacen
     WHERE a.Articulo = @Articulo 
       AND p.Tipo = 'Domicilio' 
       AND t.Estatus = 'BAJA' AND t.Tarima NOT LIKE '%-%'
       AND p.ArticuloEsp = @Articulo

  RETURN(@Resultado)
END
GO

--UserStory3623
/**************** fnTarimaPesoMovimiento ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTarimaPesoMovimiento') DROP FUNCTION fnTarimaPesoMovimiento
GO
CREATE FUNCTION fnTarimaPesoMovimiento(
		@ID			int,
	    @Tarima		varchar(20)
)
RETURNS float
AS
BEGIN
  DECLARE @Peso		float
   
    SELECT @Peso = SUM(td.CantidadUnidad*ISNULL(a.Peso,1))
     FROM ArtDisponibleTarima adt JOIN TMAD td ON adt.Almacen = td.Almacen AND adt.Tarima = td.Tarima    
     JOIN TMA t ON td.ID = t.ID JOIN Art a ON adt.Articulo = a.Articulo    
    WHERE adt.Empresa = t.Empresa AND td.Tarima = @Tarima AND t.Estatus <> 'CANCELADO' AND t.ID = @ID

  RETURN ISNULL(@Peso, 0)
END
GO

/**************** sp ****************/

--REQ12615 WMS
--BUG 14866
/**************** spWMSMovTransito ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWMSMovTransito')  AND type = 'P') drop procedure dbo.spWMSMovTransito
GO             
CREATE PROCEDURE spWMSMovTransito
		@Modulo				varchar(5),
		@Mov				varchar(20)

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE 
  		@Clave				varchar(20),
  		@SubClave			varchar(20)

  SELECT @Clave = Clave, @SubClave = SubClave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov

  IF @Modulo = 'TMA'
  BEGIN
    IF @Clave = 'TMA.SADO'
      SELECT Mov FROM MovTipo WHERE Modulo = @Modulo AND Clave = 'TMA.OADO'
    ELSE
    IF @Clave = 'TMA.SRADO'
      SELECT Mov FROM MovTipo WHERE Modulo = @Modulo AND Clave = 'TMA.ORADO'
    ELSE
    IF @Clave = 'TMA.OSUR' AND @SubClave IS NULL
      SELECT Mov FROM MovTipo WHERE Modulo = @Modulo AND Clave = 'TMA.TSUR' AND SubClave IS NULL
    ELSE
    IF @Clave = 'TMA.OSUR' AND @SubClave = 'TMA.OSURP'
      SELECT Mov FROM MovTipo WHERE Modulo = @Modulo AND Clave = 'TMA.TSUR' AND SubClave = 'TMA.TSURP'
	ELSE 
    IF @Clave = 'TMA.OPCKTARIMA' AND @SubClave IS NULL
		SELECT Mov FROM MovTipo WHERE Modulo = @Modulo AND Clave = 'TMA.PCKTARIMATRAN' AND SubClave IS NULL
	ELSE SELECT ''
  END
  ELSE SELECT ''
  
END
GO
--EXEC spWMSMovTransito 'TMA', 'Solicitud Acomodo'

--REQ12615 WMS
--BUG 14866
/**************** spWMSMovFinal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWMSMovFinal')  AND type = 'P') drop procedure dbo.spWMSMovFinal
GO             
CREATE PROCEDURE spWMSMovFinal
		@Modulo				varchar(5),
		@Mov				varchar(20)

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE 
  		@Clave				varchar(20),
  		@SubClave			varchar(20)

  SELECT @Clave = Clave, @SubClave = SubClave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov

  IF @Modulo = 'TMA'
  BEGIN
    IF @Clave = 'TMA.OADO'
      SELECT Mov FROM MovTipo WHERE Modulo = @Modulo AND Clave = 'TMA.ADO'
    ELSE
    IF @Clave = 'TMA.ORADO'
      SELECT Mov FROM MovTipo WHERE Modulo = @Modulo AND Clave = 'TMA.RADO'
    ELSE
    IF @Clave = 'TMA.TSUR' 
      SELECT Mov FROM MovTipo WHERE Modulo = @Modulo AND Clave = 'TMA.SUR'
    ELSE
    IF @Clave = 'TMA.TSUR' AND @SubClave = 'TMA.OSURP'
      SELECT Mov FROM MovTipo WHERE Modulo = @Modulo AND Clave = 'TMA.SUR'
	ELSE
    IF @Clave = 'TMA.PCKTARIMATRAN' AND @SubClave IS NULL
    	SELECT Mov FROM MovTipo WHERE Modulo = @Modulo AND Clave = 'TMA.PCKTARIMA' AND SubClave IS NULL 
    ELSE SELECT ''
  END
  ELSE
  IF @Modulo = 'COMS'
  BEGIN
    IF @Clave = 'COMS.O'
      SELECT Mov FROM MovTipo WHERE Modulo = @Modulo AND Clave IN ('COMS.F','COMS.EI')
    ELSE SELECT ''
  END
  ELSE SELECT ''
END
GO
--EXEC spWMSMovFinal 'TMA', 'Solicitud Acomodo'

--REQ12615 WMS
/************************************* spWMSRepCaducidad ****************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spWMSRepCaducidad') AND Type = 'P') 
DROP PROCEDURE dbo.spWMSRepCaducidad
GO             
CREATE PROCEDURE spWMSRepCaducidad
		@Estacion		int
--//WITH ENCRYPTION
AS BEGIN

DECLARE
  @Tipo			varchar(50),
  @Articulo		varchar(50),
  @Almacen		varchar(50),
  @Grupo		varchar(50),
  @Familia		varchar(50),
  @Categoria	varchar(50),
  @FechaD		datetime,
  @FechaA		datetime,
  @DiaD			int,
  @DiaA			int,
  @TipoPos		varchar(50)


  SELECT @FechaD = InfoCaducidadD,
		 @FechaA = InfoCaducidadA,
		 @DiaD = InfoCaducidadDiaD,
		 @DiaA = InfoCaducidadDiaA,
		 @TipoPos = InfoTipo,
		 @Tipo = InfoTipoCaducidad,
		 @Articulo = InfoArticuloCaducidad,
		 @Almacen = InfoAlmacenWMS,
		 @Grupo = InfoArtGrupo,
		 @Categoria = InfoArtCat,
		 @Familia = InfoArtFam
    FROM RepParam
   WHERE Estacion = @Estacion


  IF RTRIM(LTRIM(@Articulo)) IN ('', '(Todos)','(Todas)') set @Articulo = NULL
  IF RTRIM(LTRIM(@Almacen)) IN ('', '(Todos)','(Todas)') set @Almacen = NULL
  IF RTRIM(LTRIM(ISNULL(@Grupo,''))) IN ('', '(Todos)','(Todas)') set @Grupo = NULL
  IF RTRIM(LTRIM(ISNULL(@Familia,''))) IN ('', '(Todos)','(Todas)') set @Familia = NULL  
  IF RTRIM(LTRIM(ISNULL(@Categoria,''))) IN ('', '(Todos)','(Todas)') set @Categoria = NULL
  IF RTRIM(LTRIM(ISNULL(@TipoPos,''))) IN ('', '(Todos)','(Todas)') set @TipoPos = NULL

  
  IF @Tipo IN('Caducados', 'Por Día')
    SELECT @FechaD = NULL


  IF @Tipo = 'Caducados'
	SELECT a.Articulo, a.Descripcion1, d.Tarima, d.Disponible, t.Posicion, p.Descripcion, p.Fila, p.Pasillo, p.Nivel, t.FechaCaducidad, DATEDIFF(DAY, GETDATE(), t.FechaCaducidad) as DiasCaducidad, @Tipo as Tipo, d.Almacen, ISNULL(a.Grupo,'') as Grupo, ISNULL(a.Familia,'') as Familia, ISNULL(a.Categoria,'') as Categoria, p.Tipo as TipoPosicion, @FechaD as FechaDesde, @FechaA as FechaHasta, @DiaD as DiaDesde, @DiaA as DiaHasta
	  FROM Art a
	  JOIN ArtDisponibleTarima d 
	    ON a.Articulo = d.Articulo
	  JOIN Tarima t
	    ON d.Tarima = t.Tarima
	  JOIN AlmPos p
	    ON t.Posicion = p.Posicion
	 WHERE a.ControlArticulo = 'Caducidad'
	   AND d.Disponible > 0
	   AND d.Articulo = ISNULL(@Articulo, d.Articulo)
	   AND d.Almacen = ISNULL(@Almacen, d.Almacen)
 	   AND ISNULL(a.Grupo,'') = ISNULL(@Grupo, ISNULL(a.Grupo,''))
	   AND ISNULL(a.Familia,'') = ISNULL(@Familia, ISNULL(a.Familia,''))
	   AND ISNULL(a.Categoria,'') = ISNULL(@Categoria, ISNULL(a.Categoria,''))
	   AND p.Tipo = ISNULL(@TipoPos, p.Tipo)
	   AND DATEDIFF(DAY, GETDATE(), t.FechaCaducidad) < 1
	 ORDER BY DATEDIFF(DAY, GETDATE(), t.FechaCaducidad)
  ELSE
  IF @Tipo = 'Por Fecha'
	SELECT a.Articulo, a.Descripcion1, d.Tarima, d.Disponible, t.Posicion, p.Descripcion, p.Fila, p.Pasillo, p.Nivel, t.FechaCaducidad, DATEDIFF(DAY, GETDATE(), t.FechaCaducidad) as DiasCaducidad, @Tipo as Tipo, d.Almacen, ISNULL(a.Grupo,'') as Grupo, ISNULL(a.Familia,'') as Familia, ISNULL(a.Categoria,'') as Categoria, p.Tipo as TipoPosicion, @FechaD as FechaDesde, @FechaA as FechaHasta, @DiaD as DiaDesde, @DiaA as DiaHasta
	  FROM Art a
	  JOIN ArtDisponibleTarima d 
	    ON a.Articulo = d.Articulo
	  JOIN Tarima t
		ON d.Tarima = t.Tarima
	  JOIN AlmPos p
		ON t.Posicion = p.Posicion
	 WHERE a.ControlArticulo = 'Caducidad'
	   AND d.Disponible > 0
	   AND t.FechaCaducidad BETWEEN @FechaD AND @FechaA
	   AND d.Articulo = ISNULL(@Articulo, d.Articulo)
	   AND d.Almacen = ISNULL(@Almacen, d.Almacen)
	   AND ISNULL(a.Grupo,'') = ISNULL(@Grupo, ISNULL(a.Grupo,''))
	   AND ISNULL(a.Familia,'') = ISNULL(@Familia, ISNULL(a.Familia,''))
	   AND ISNULL(a.Categoria,'') = ISNULL(@Categoria, ISNULL(a.Categoria,''))
	   AND p.Tipo = ISNULL(@TipoPos, p.Tipo)
	 ORDER BY DATEDIFF(DAY, GETDATE(), t.FechaCaducidad)
  ELSE
  IF @Tipo = 'Por Día'
	SELECT a.Articulo, a.Descripcion1, d.Tarima, d.Disponible, t.Posicion, p.Descripcion, p.Fila, p.Pasillo, p.Nivel, t.FechaCaducidad, DATEDIFF(DAY, GETDATE(), t.FechaCaducidad) as DiasCaducidad, @Tipo as Tipo, d.Almacen, ISNULL(a.Grupo,'') as Grupo, ISNULL(a.Familia,'') as Familia, ISNULL(a.Categoria,'') as Categoria, p.Tipo as TipoPosicion, @FechaD as FechaDesde, @FechaA as FechaHasta, @DiaD as DiaDesde, @DiaA as DiaHasta
	  FROM Art a
	  JOIN ArtDisponibleTarima d 
		ON a.Articulo = d.Articulo
	  JOIN Tarima t
		ON d.Tarima = t.Tarima
	  JOIN AlmPos p
		ON t.Posicion = p.Posicion
	 WHERE a.ControlArticulo = 'Caducidad'
	   AND d.Disponible > 0
	   AND DATEDIFF(DAY,GETDATE(), t.FechaCaducidad) BETWEEN @DiaD AND @DiaA
	   AND d.Articulo = ISNULL(@Articulo, d.Articulo)
	   AND d.Almacen = ISNULL(@Almacen, d.Almacen)
 	   AND ISNULL(a.Grupo,'') = ISNULL(@Grupo, ISNULL(a.Grupo,''))
	   AND ISNULL(a.Familia,'') = ISNULL(@Familia, ISNULL(a.Familia,''))
	   AND ISNULL(a.Categoria,'') = ISNULL(@Categoria, ISNULL(a.Categoria,''))
	   AND p.Tipo = ISNULL(@TipoPos, p.Tipo)
	 ORDER BY DATEDIFF(DAY, GETDATE(), t.FechaCaducidad)
  ELSE
  BEGIN
    DECLARE @Float float, @Int int, @Fecha datetime 
    SELECT '' Articulo, '' Descripcion1, '' Tarima, @Float Disponible, '' Posicion, '' Descripcion, @Int Fila, @Int Pasillo, @Int Nivel, @Fecha FechaCaducidad, @Int DiasCaducidad, '' Tipo, '' Almacen, '' Grupo, '' Familia, '' Categoria, '' TipoPosicion, @Fecha FechaDesde, @Fecha FechaHasta, @Int DiaDesde, @Int DiaHasta
  END
END
GO

--BUG7778
/**************** spTMAVerificarSerieLote ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTMAVerificarSerieLote')  AND type = 'P') drop procedure dbo.spTMAVerificarSerieLote
GO
CREATE PROC spTMAVerificarSerieLote
		    @Empresa		varchar(5),
			@Sucursal		int,
			@ID				int,
			@Ok				int				OUTPUT,
			@OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Renglon			float,
		  @RenglonAnt		float,
		  @Articulo			varchar(20),
		  @SubCuenta		varchar(50),
		  @Tarima			varchar(20),
		  @CantidadPck		float,
		  @CantidadPckSerie	float,
		  @CantidadSerieMov	float,
		  @CantidadSerie	float,
		  @Almacen			varchar(10),
		  @SerieLote		varchar(50),
		  @SerieLoteAnt		varchar(50),
		  @MovTipo		    varchar(20)

  SELECT @MovTipo = Clave FROM MovTipo JOIN TMA ON MovTipo.Mov = TMA.Mov AND MovTipo.Modulo = 'TMA' WHERE ID = @ID

  SELECT @RenglonAnt = ''
  WHILE(1=1)
  BEGIN
    SELECT @Renglon = MIN(Renglon)
	  FROM TMAD
	  JOIN Art ON TMAD.Articulo = Art.Articulo AND Art.Tipo IN('SERIE','LOTE','VIN','PARTIDA')
	 WHERE Renglon > @RenglonAnt
	   AND ID = @ID

    IF @Renglon IS NULL BREAK

	SELECT @RenglonAnt = @Renglon, @Articulo = NULL, @SubCuenta = NULL, @Tarima = NULL, @CantidadPck = NULL, @CantidadSerieMov = NULL, @Almacen = NULL

	SELECT @Articulo = Articulo, 
	       @SubCuenta = ISNULL(SubCuenta, ''), 
		   @CantidadPck = CantidadPicking, 
		   @Tarima =CASE CHARINDEX('-', Tarima) WHEN 0 THEN ISNULL(Tarima, '') ELSE SUBSTRING(Tarima, 1, CHARINDEX('-', Tarima)-1) END,
		   @Almacen = Almacen
	  FROM TMAD 
	 WHERE ID = @ID 
	   AND Renglon = @Renglon

    SELECT @CantidadSerieMov = SUM(Cantidad)
	  FROM SerieLoteMov
	 WHERE Modulo = 'TMA'
	   AND ID = @ID
	   AND RenglonID = @Renglon
	   AND Articulo = @Articulo
	   AND ISNULL(SubCuenta, '') = @SubCuenta

    IF ISNULL(@CantidadPck, 0) <> ISNULL(@CantidadSerieMov, 0)
	BEGIN
	  SELECT @Ok = 20330, @OkRef = @Articulo

	  RETURN
	END

    SELECT @SerieLoteAnt = ''
	WHILE(1=1)
	BEGIN
	  SELECT @SerieLote = MIN(SerieLote)
	    FROM SerieLoteMov
	   WHERE Modulo = 'TMA'
	     AND ID = @ID
	     AND RenglonID = @Renglon
	     AND Articulo = @Articulo
	     AND ISNULL(SubCuenta, '') = @SubCuenta
		 AND SerieLote > @SerieLoteAnt

      IF @SerieLote IS NULL BREAK

	  SELECT @SerieLoteAnt = @SerieLote, @CantidadPckSerie = NULL, @CantidadSerie = NULL
	  
	  SELECT @CantidadPckSerie = SUM(Cantidad)
	    FROM SerieLoteMov
	   WHERE Modulo = 'TMA'
	     AND ID = @ID
	     AND RenglonID = @Renglon
	     AND Articulo = @Articulo
	     AND ISNULL(SubCuenta, '') = @SubCuenta
		 AND SerieLote = @SerieLote

	  SELECT @CantidadSerie = SUM(Existencia)
	    FROM SerieLote
	   WHERE Articulo = @Articulo
	     AND ISNULL(SubCuenta, '') = @SubCuenta
		 AND SerieLote = @SerieLote
		 AND Almacen = @Almacen
		 AND Tarima = @Tarima
		 AND Sucursal = @Sucursal
		 AND Empresa = @Empresa

      IF ISNULL(@CantidadPckSerie, 0) > ISNULL(@CantidadSerie, 0)
	  BEGIN
	    SELECT @Ok = 20510, @OkRef = @Articulo + ' - ' + @SerieLote

	    RETURN
	  END
	END
  END
  RETURN
END
GO

--REQ12615 WMS
/************** spWMSRepParamSurtido *************/
if exists (select * from sysobjects where id = object_id('dbo.spWMSRepParamSurtido') and type = 'P') drop procedure dbo.spWMSRepParamSurtido
GO
CREATE PROCEDURE spWMSRepParamSurtido
		   @Estacion		int
--//WITH ENCRYPTION
AS BEGIN
  
  UPDATE RepParam SET InfoAlmacenWMS = '(Todos)', InfoPosicion = '(Todas)', InfoContacto = ('(Todos)') WHERE Estacion = @Estacion

  RETURN
END
GO


--REQ12615 WMS
/**************** spWMSAsignaAcomodador ****************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'spWMSAsignaAcomodador' AND type = 'P') DROP PROCEDURE spWMSAsignaAcomodador
GO
CREATE PROCEDURE spWMSAsignaAcomodador
					@Acomodador		varchar(10),
					@Estacion		int,
					@Tipo			varchar(50),
					@Montacarga		varchar(50)
--//WITH ENCRYPTION
AS
BEGIN

  IF @Tipo = 'WMSSurtidoProcesarD'
    UPDATE WMSSurtidoProcesarD SET Acomodador = @Acomodador
      FROM ListaSt
     WHERE ListaSt.Clave = WMSSurtidoProcesarD.Articulo AND ListaSt.Estacion = WMSSurtidoProcesarD.Estacion AND WMSSurtidoProcesarD.Procesado = 0 AND
           ListaSt.Estacion = @Estacion
  ELSE
  IF @Tipo = 'WMSLoteMovimiento'
	BEGIN
		UPDATE WMSLoteMovimiento 
		   SET Acomodador = @Acomodador,
			   Montacarga = @Montacarga
		  FROM ListaSt
		 WHERE ListaSt.Clave = WMSLoteMovimiento.IDLista
		   AND ListaSt.Estacion = WMSLoteMovimiento.Estacion
		   AND ListaSt.Estacion = @Estacion

		UPDATE B
		   SET B.Montacarga = NULLIF(@Montacarga,''),
			   B.Agente = NULLIF(@Acomodador,'')
		  FROM WMSLoteMovimiento A
		  JOIN TMA B 
		    ON A.ID = B.ID
		  JOIN ListaSt C
		    ON A.IDLista = C.Clave
		   AND A.Estacion = C.Estacion
		 WHERE C.Estacion = @Estacion

		UPDATE D
		   SET D.Montacarga = NULLIF(@Acomodador,'')
		  FROM WMSLoteMovimiento A
		  JOIN TMA B 
		    ON A.ID = B.ID
		  JOIN TMAD D
			ON B.ID = D.ID
		   AND A.Tarima = D.Tarima
		  JOIN ListaSt C
		    ON A.IDLista = C.Clave
		   AND A.Estacion = C.Estacion
		 WHERE C.Estacion = @Estacion
		 
	END  
END
GO

--REQ12615 WMS
/************************************* spWMSActualizarPrioridad ****************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spWMSActualizarPrioridad') AND Type = 'P') 
DROP PROCEDURE dbo.spWMSActualizarPrioridad
GO             
CREATE PROCEDURE spWMSActualizarPrioridad
		@Estacion		int,
		@Prioridad		varchar(20)
--//WITH ENCRYPTION	

AS BEGIN

  UPDATE WMSMontacargaTarea SET Prioridad = @Prioridad WHERE Estacion = @Estacion AND IDLista IN(SELECT ID FROM ListaID WHERE Estacion = @Estacion)
  
END
GO

--REQ12615 WMS
/**************** spWMSAsignaPosicion ****************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'spWMSAsignaPosicion' AND type = 'P') DROP PROCEDURE spWMSAsignaPosicion
GO
CREATE PROCEDURE spWMSAsignaPosicion @Posicion	varchar(20), @Estacion	int
--//WITH ENCRYPTION
AS BEGIN
  UPDATE WMSSurtidoProcesarD SET PosicionDestino = @Posicion WHERE WMSSurtidoProcesarD.Procesado = 0 AND WMSSurtidoProcesarD.Estacion = @Estacion

  RETURN
END
GO

--REQ12615 WMS
/**************** spWMSReferenciaHerramienta ****************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'spWMSReferenciaHerramienta' AND type = 'P') DROP PROCEDURE spWMSReferenciaHerramienta
GO
CREATE PROCEDURE spWMSReferenciaHerramienta
    @Referencia		varchar(50) OUTPUT

--//WITH ENCRYPTION
AS BEGIN     
DECLARE @Modulo				varchar(5),
        @ID					int,
        @IDModulo			int,
        @SucursalDestino	int,
        @AlmacenDestino		varchar(10)

  DECLARE @Tabla TABLE (IDModulo int, Modulo char(5), SucursalDestino int)			

  IF (SELECT COUNT(Modulo) FROM (SELECT DISTINCT w.Modulo FROM #CualesID i JOIN WMSModuloTarima w ON i.ID = w.ID) x) = 1
  BEGIN
    DECLARE crCualesID CURSOR FOR  
     SELECT w.IDModulo, w.Modulo
       FROM #CualesID i
       JOIN WMSModuloTarima w
         ON i.ID = w.ID
      WHERE w.Modulo = 'INV'

    OPEN crCualesID  
    FETCH NEXT FROM crCualesID INTO @IDModulo, @Modulo
    WHILE @@FETCH_STATUS = 0  
    BEGIN      
      SELECT @AlmacenDestino	= AlmacenDestino,
             @SucursalDestino	= NULL
        FROM Inv
       WHERE ID = @IDModulo
       
      IF @AlmacenDestino IS NOT NULL
        SELECT @SucursalDestino = (SELECT Sucursal FROM  Alm WHERE Almacen = @AlmacenDestino)
      
      INSERT @Tabla
      SELECT @IDModulo, @Modulo, @SucursalDestino
       
      FETCH NEXT FROM crCualesID INTO @IDModulo, @Modulo
    END  
    CLOSE crCualesID  
    DEALLOCATE crCualesID  

    IF (SELECT COUNT(*) FROM @Tabla WHERE SucursalDestino <> @SucursalDestino) = 0
      SELECT @Referencia = 'Sucursal Destino ' + CONVERT(varchar,@SucursalDestino)
  END
  RETURN
END
GO

/**************** TARIMAS EN MOVIMIENTOS PENDIENTES ****************/
IF EXISTS (select * from sysobjects where id = object_id('dbo.WMSTarimaMovPendiente') and type = 'V') drop view dbo.WMSTarimaMovPendiente
GO
CREATE VIEW dbo.WMSTarimaMovPendiente
AS
	SELECT d.Tarima
	  FROM TMAD d 
	  JOIN TMA a
	    ON a.ID = d.ID
	  JOIN MovTipo m
	    ON m.Mov = a.Mov 
	   AND m.Modulo = 'TMA' 
	 WHERE a.Estatus IN ('PENDIENTE', 'SINAFECTAR')
	   AND m.Clave IN ('TMA.OSUR', 'TMA.TSUR','TMA.OPCKTARIMA','TMA.PCKTARIMATRAN','TMA.OPCKTARIMA')
	 UNION
	SELECT d.Tarima
	  FROM TMAD d
	  JOIN TMA a
	    ON a.ID = d.ID
	  JOIN MovTipo m
	    ON m.Mov = a.Mov
	   AND m.Modulo = 'TMA'
	 WHERE a.Estatus IN ('PENDIENTE', 'SINAFECTAR')
	   AND m.Clave IN ('TMA.SRADO', 'TMA.SADO', 'TMA.ORADO', 'TMA.OADO','TMA.PCKTARIMATRAN','TMA.OPCKTARIMA')
	   AND d.Procesado = 0
GO

--REQ12615 WMS
--TASK24685
/**************** spTMAExplocionTarima ****************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'spTMAExplocionTarima' AND type = 'P') DROP PROCEDURE spTMAExplocionTarima
GO
CREATE PROCEDURE spTMAExplocionTarima
					@Almacen		 varchar(10), 
					@Articulo		 varchar(20), 
					@Cantidad		 float = NULL, 
					@ControlArticulo varchar(20) = NULL, 
					@Tipo			 varchar(20) = NULL,
					@Estacion        int         = NULL,
					@Tarima			 varchar(20) OUTPUT,
					@Disponible		 float		 OUTPUT,
					@Posicion		 varchar(10) OUTPUT
--//WITH ENCRYPTION					
AS BEGIN
  SELECT @Tarima = NULL, @Disponible = NULL
  
  IF (OBJECT_ID('Tempdb..#TarimaAux')) IS NULL
    CREATE TABLE #TarimaAux (Tarima varchar(20) COLLATE Database_Default NOT NULL,  SubTarima varchar(20) COLLATE Database_Default NOT NULL, Cantidad float  NULL, CantidadA float  NULL, ) 

  IF @Tipo = 'Cross Docking'
  BEGIN
	SELECT TOP 1 
				@Tarima		= adt.Tarima,
				@Disponible	= adt.Disponible - ISNULL(at.Apartado,0) - ISNULL(ta.CantidadA,0)
		FROM ArtDisponibleTarima adt  
   LEFT JOIN ArtApartadoTarima at ON adt.Empresa = at.Empresa AND adt.Articulo = at.Articulo AND adt.Almacen = at.Almacen AND adt.Tarima = at.Tarima
		JOIN Tarima t ON adt.Almacen =t.Almacen AND adt.Tarima = t.Tarima  
		JOIN AlmPos ap ON t.Almacen = ap.Almacen AND t.Posicion = ap.Posicion 
   LEFT JOIN #TarimaAux ta ON adt.Tarima = ta.Tarima 
		WHERE adt.Almacen = @Almacen
		AND adt.Articulo = @Articulo
		AND ap.Tipo = 'Cross Docking'		
		AND @Cantidad <= adt.Disponible	- ISNULL(at.Apartado,0)	- ISNULL(ta.CantidadA,0)
		AND adt.Tarima NOT IN (SELECT Tarima FROM WMSSurtidoProcesarD WHERE Tipo <> 'Ubicacion' AND Estacion = @Estacion)
        AND adt.Disponible - ISNULL(at.Apartado,0) - ISNULL(ta.CantidadA,0) > 0
        AND t.Estatus = 'ALTA'
		ORDER BY t.FechaCaducidad, CASE @ControlArticulo 
				WHEN 'Caducidad'		THEN CONVERT(varchar, t.FechaCaducidad)
				WHEN 'Fecha Entrada'	THEN CONVERT(varchar, t.Alta)
				ELSE t.Posicion
		  		END, adt.Tarima ASC
  END

  IF @Tipo = 'Ubicacion'
  BEGIN

    SELECT TOP 1 
	  @Tarima		= adt.Tarima,
	  @Disponible	= adt.Disponible - ISNULL(at.Apartado,0) - ISNULL(ta.CantidadA,0),
      @Posicion     = t.Posicion
      FROM ArtDisponibleTarima adt  
 LEFT JOIN ArtApartadoTarima at ON adt.Empresa = at.Empresa AND adt.Articulo = at.Articulo AND adt.Almacen = at.Almacen AND adt.Tarima = at.Tarima
      JOIN Tarima t ON adt.Almacen =t.Almacen AND adt.Tarima = t.Tarima  
      JOIN AlmPos ap ON t.Almacen = ap.Almacen AND t.Posicion = ap.Posicion  
 LEFT JOIN #TarimaAux ta ON adt.Tarima = ta.Tarima        
     WHERE adt.Almacen = @Almacen
       AND adt.Articulo = @Articulo
       AND ap.Tipo = 'Ubicacion'
       --AND adt.Tarima NOT IN (SELECT ISNULL(Tarima,'') FROM #TarimaAux)
       AND @Cantidad >= adt.Disponible - ISNULL(at.Apartado,0) - ISNULL(ta.CantidadA,0)
       AND adt.Tarima NOT IN (SELECT Tarima FROM WMSSurtidoProcesarD WHERE Tipo <> 'Ubicacion' AND Estacion = @Estacion)
       AND adt.Disponible - ISNULL(at.Apartado,0) - ISNULL(ta.CantidadA,0) > 0
       AND t.Estatus = 'ALTA'
     --BUG24515
     ORDER BY t.FechaCaducidad, CASE @ControlArticulo 
                WHEN 'Caducidad'		THEN CONVERT(varchar, t.FechaCaducidad)
                WHEN 'Fecha Entrada'	THEN CONVERT(varchar, t.Alta)
                ELSE t.Posicion
		  	  END, adt.Tarima ASC 

   
--BUG24392
  END
  --TASK6535
  ELSE
  IF @Tipo = 'PCKUbicacion'
  BEGIN

    SELECT TOP 1 
	  @Tarima		= adt.Tarima,
	  @Disponible	= adt.Disponible  - ISNULL(at.Apartado,0) - ISNULL(ta.CantidadA,0)
      FROM ArtDisponibleTarima adt  
 LEFT JOIN ArtApartadoTarima at ON adt.Empresa = at.Empresa AND adt.Articulo = at.Articulo AND adt.Almacen = at.Almacen AND adt.Tarima = at.Tarima
      JOIN Tarima t ON adt.Almacen =t.Almacen AND adt.Tarima = t.Tarima  
      JOIN AlmPos ap ON t.Almacen = ap.Almacen AND t.Posicion = ap.Posicion
 LEFT JOIN #TarimaAux ta ON adt.Tarima = ta.Tarima        
     WHERE adt.Almacen = @Almacen
       AND adt.Articulo = @Articulo
       AND ap.Tipo = 'Ubicacion'
       --AND adt.Tarima NOT IN (SELECT ISNULL(Tarima,'') FROM #TarimaAux)
       AND @Cantidad < (adt.Disponible - ISNULL(at.Apartado,0) - ISNULL(ta.CantidadA,0))
	   AND adt.Tarima NOT IN (SELECT Tarima FROM WMSSurtidoProcesarD WHERE Tipo <> 'Ubicacion' AND Estacion = @Estacion)
       AND adt.Disponible - ISNULL(at.Apartado,0) - ISNULL(ta.Cantidad,0) > 0
       AND t.Estatus = 'ALTA'
     --BUG24515
     ORDER BY t.FechaCaducidad, CASE @ControlArticulo 
                WHEN 'Caducidad'		THEN CONVERT(varchar, t.FechaCaducidad)
                WHEN 'Fecha Entrada'	THEN CONVERT(varchar, t.Alta)
                ELSE t.Posicion
		  	  END, adt.Tarima ASC 
  
  END
  ELSE
  IF @Tipo = 'Domicilio'
  BEGIN
    SELECT TOP 1
	  @Tarima		= adt.Tarima,
	  @Disponible	= adt.Disponible - ISNULL(at.Apartado,0) - ISNULL(ta.CantidadA,0)
      FROM ArtDisponibleTarima adt  
 LEFT JOIN ArtApartadoTarima at ON adt.Empresa = at.Empresa AND adt.Articulo = at.Articulo AND adt.Almacen = at.Almacen AND adt.Tarima = at.Tarima
      JOIN Tarima t ON adt.Almacen = t.Almacen AND adt.Tarima = t.Tarima  
      JOIN AlmPos ap ON t.Almacen = ap.Almacen AND t.Posicion = ap.Posicion 
 LEFT JOIN #TarimaAux ta ON adt.Tarima = ta.Tarima       
     WHERE adt.Almacen = @Almacen AND adt.Articulo = @Articulo       
       AND ap.ArticuloEsp = @Articulo AND ap.Tipo = @Tipo
       --AND adt.Tarima NOT IN (SELECT ISNULL(Tarima,'') FROM #TarimaAux GROUP BY ISNULL(Tarima,''), CantidadA HAVING (SUM(Cantidad)+@Cantidad > CantidadA)) --REQ 14684
       AND t.Tarima NOT LIKE '%-%'
       AND adt.Disponible - ISNULL(at.Apartado,0) - ISNULL(ta.CantidadA,0) > 0
       AND t.Estatus = 'ALTA'

   
    --EWQ. Tuning2
    END

 --   IF @Tarima IS NULL
 --   BEGIN
 --     SELECT TOP 1
 -- 	    @Tarima		= adt.Tarima,
	--    @Disponible	= adt.Disponible - ISNULL(at.Apartado,0) 
 --       FROM ArtDisponibleTarima adt  
 --  LEFT JOIN ArtApartadoTarima at ON adt.Empresa = at.Empresa AND adt.Articulo = at.Articulo AND adt.Almacen = at.Almacen AND adt.Tarima = at.Tarima
 --       JOIN Tarima t ON adt.Almacen = t.Almacen AND adt.Tarima = t.Tarima  
 --       JOIN AlmPos ap ON t.Almacen = ap.Almacen AND t.Posicion = ap.Posicion  
 --      WHERE adt.Almacen = @Almacen 
 --        AND adt.Articulo = @Articulo 
 --        AND ap.ArticuloEsp = @Articulo 
 --        AND ap.Tipo = @Tipo 
 --        AND t.Tarima NOT LIKE '%-%'
 --        AND adt.Disponible - ISNULL(at.Apartado,0) > 0
 --     --SELECT @Disponible = @Disponible - ISNULL(SUM(Cantidad),0) FROM #TarimaAux WHERE Tarima = @Tarima
 --    -- IF ISNULL(@Disponible, 0) <= 0 SELECT @Tarima = NULL, @Disponible = 0
 --   END

 --   SELECT @Disponible = @Disponible - ISNULL(SUM(ISNULL(d.CantidadPendiente,0) /*+ ISNULL(d.CantidadPicking,0)*/),0)
 --     FROM TMAD d 
 --     JOIN TMA a ON a.ID = d.ID 
 --     JOIN MovTipo m ON m.Mov = a.Mov AND m.Modulo = 'TMA' 
 --    WHERE a.Estatus IN ('PENDIENTE', 'PROCESAR') 
 --      --BUG24665
 --      AND m.Clave IN ('TMA.OSUR', 'TMA.TSUR', 'TMA.SRADO', 'TMA.SADO', 'TMA.ORADO', 'TMA.OADO')
 --      AND Tarima = @Tarima
 --      AND d.Procesado = CASE m.Clave
	--					   WHEN 'TMA.OSUR'  THEN d.Procesado
	--			           WHEN 'TMA.TSUR'  THEN d.Procesado
	--					   WHEN 'TMA.SRADO' THEN 0
	--			           WHEN 'TMA.SADO'  THEN 0
	--					   --BUG24665
	--					   WHEN 'TMA.ORADO' THEN 0
	--			           WHEN 'TMA.OADO'  THEN 0
	--			         END

 --   SELECT @Disponible = @Disponible + ISNULL(SUM(ISNULL(d.CantidadPendiente,0) + ISNULL(d.CantidadPicking,0)),0)
 --     FROM TMAD d 
 --     JOIN TMA a ON a.ID = d.ID 
 --     JOIN MovTipo m ON m.Mov = a.Mov AND m.Modulo = 'TMA' 
 --    WHERE a.Estatus IN ('PENDIENTE') 
 --      AND m.Clave IN ('TMA.SRADO', 'TMA.ORADO')
 --      AND PosicionDestino IN(SELECT Posicion FROM AlmPos WHERE Almacen = @Almacen AND ArticuloEsp = @Articulo AND Tipo = @Tipo)
  
 --   --EWQ. Tuning2
 --   IF ISNULL(@Disponible, 0) <= 0 SELECT @Tarima = NULL, @Disponible = 0
 -- END
 -- ELSE
 --	SELECT TOP 1
	--  @Tarima		= t.Tarima,
	--  @Disponible	= d.Disponible - ISNULL(at.Apartado,0),
	--  @Posicion		= t.Posicion
 --     FROM ArtDisponibleTarima d 
 --LEFT JOIN ArtApartadoTarima at ON d.Empresa = at.Empresa AND d.Articulo = at.Articulo AND d.Almacen = at.Almacen AND d.Tarima = at.Tarima
 --     JOIN Tarima t ON d.Tarima = t.Tarima
 --     JOIN AlmPos p ON t.Almacen = p.Almacen AND p.Posicion = t.Posicion
 --     JOIN Art a ON d.Articulo = a.Articulo         
 --    WHERE d.Almacen = @Almacen
 --      AND p.Tipo = 'Ubicacion'
 --      AND d.Articulo = @Articulo
 --      AND t.Estatus = 'ALTA'
 --      AND p.Estatus = 'ALTA'
 --      AND t.Tarima NOT LIKE '%-%'
 --      ----AND d.Tarima NOT IN (SELECT d.tarima FROM TMA t JOIN TMAD d ON t.ID = d.ID JOIN  MovTipo m ON t.Mov = m.Mov AND m.Modulo = 'TMA' WHERE m.Clave = 'TMA.SRADO' AND t.Estatus = 'PENDIENTE')
 --      ----AND d.Tarima NOT IN (SELECT Tarima FROM WMSSurtidoProcesarD WHERE Estacion = @Estacion AND Articulo = @Articulo AND Procesado = 0)
 --      ----AND d.Tarima NOT IN (SELECT wP.Tarima FROM WMSSurtidoProcesarD wp WHERE wp.Estacion = @Estacion AND wp.Procesado = 1 AND wp.Tipo = 'Ubicacion' AND Articulo IN(SELECT DISTINCT Clave FROM ListaSt WHERE Estacion = @Estacion))
	--   --BUG24665       
	--   AND d.Tarima NOT IN (SELECT Tarima FROM WMSSurtidoProcesarD WHERE Tipo <> 'Ubicacion')
 --      AND d.Disponible - ISNULL(at.Apartado,0) > 0
	--   --BUG25367
	--   AND Disponible > 0
 --    --BUG24515
 --    ORDER BY t.FechaCaducidad, CASE @ControlArticulo        
 --               WHEN 'Caducidad'		THEN CONVERT(varchar, t.FechaCaducidad)
 --               WHEN 'Fecha Entrada'	THEN CONVERT(varchar, t.Alta)
 --               ELSE t.Posicion
	--	  	  END , d.Tarima ASC  

  RETURN
END
GO

--TASK24685
/**************** spTMAArtDomicilioInicializar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTMAArtDomicilioInicializar') and type = 'P') drop procedure dbo.spTMAArtDomicilioInicializar
GO
CREATE PROC spTMAArtDomicilioInicializar
			@Empresa		varchar(5),
			@Almacen		varchar(10),
			@Articulo		varchar(20),
			@SubCuenta		varchar(20)
--//WITH ENCRYPTION	
AS
BEGIN
  DECLARE @Posicion		varchar(10),
		  @PosicionAnt	varchar(10),
		  @Tarima		varchar(20),
		  @TarimaAnt	varchar(20),
		  @Moneda		varchar(10),
		  @Sucursal		int,
		  --BUG24105
          @FechaEmision	datetime,
          @Ok			int,
          @OkRef		varchar(255),

		  @WMSAuxiliar	bit -- TASK1964

  SELECT @FechaEmision = GETDATE()

  EXEC spExtraerFecha @FechaEmision OUTPUT

  SELECT @Sucursal = Sucursal FROM Alm WHERE Almacen = @Almacen
  SELECT @SubCuenta = ISNULL(@SubCuenta, '')
  SELECT @Moneda = MonedaCosto FROM Art WHERE Articulo = @Articulo
  SELECT @PosicionAnt = ''

  SELECT @WMSAuxiliar = WMSAuxiliar FROM Version -- TASK1964

  WHILE(1=1)
  BEGIN
    SELECT @Posicion = MIN(Posicion)
      FROM AlmPos
     WHERE Almacen = @Almacen 
       AND Posicion > @PosicionAnt
       AND ArticuloEsp = @Articulo
       AND Tipo = 'Domicilio'

    IF @Posicion IS NULL BREAK
    
    SELECT @PosicionAnt = @Posicion

    --BUG24105
    IF NOT EXISTS(SELECT * FROM Tarima WHERE Posicion = @Posicion)
    BEGIN
      SELECT @Ok = NULL, @OkRef = NULL, @Tarima = NULL
      EXEC spConsecutivo 'Tarima', @Sucursal, @Tarima OUTPUT      
      EXEC spTarimaAlta @Empresa, @Sucursal, '', @Almacen, @FechaEmision, @FechaEmision, @Tarima, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT      
      UPDATE Tarima SET Posicion = @Posicion WHERE Tarima = @Tarima
    END

    SELECT @TarimaAnt = ''
    WHILE(1=1)
    BEGIN
      SELECT @Tarima = MIN(Tarima)
        FROM Tarima
       WHERE Almacen = @Almacen 
         AND Posicion = @Posicion
         AND Tarima > @TarimaAnt
         AND Estatus = 'ALTA'

      IF @Tarima IS NULL BREAK
    
      SELECT @TarimaAnt = @Tarima

	  --TASK24685
      IF NOT EXISTS(SELECT * FROM ArtDisponibleTarima WHERE Tarima = @Tarima AND Almacen = @Almacen AND Empresa = @Empresa AND Articulo <> @Articulo)
        IF NOT EXISTS(SELECT Grupo FROM SaldoUGral WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Grupo = @Almacen AND Cuenta = @Articulo AND SubCuenta = @SubCuenta AND Rama IN('WMS','INV') AND Moneda = @Moneda AND SubGrupo = @Tarima)
        BEGIN
          IF @WMSAuxiliar = 1 -- TASK1964
          BEGIN -- TASK1964
		    INSERT INTO SaldoUWMS(
                   Sucursal,  Empresa, Rama,   Moneda,  Grupo,    SubGrupo,  Cuenta,    SubCuenta, Saldo, SaldoU, PorConciliar, PorConciliarU, UltimoCambio)
		    SELECT @Sucursal, @Empresa, 'WMS', @Moneda, @Almacen, @Tarima,   @Articulo, @SubCuenta, 0,     0,      0,            0,             @FechaEmision		    
          END ELSE BEGIN -- TASK1964
            EXEC dbo.sp_executesql N'INSERT INTO SaldoU(
                   Sucursal,  Empresa, Rama,   Moneda,  Grupo,    SubGrupo,  Cuenta,    SubCuenta, Saldo, SaldoU, PorConciliar, PorConciliarU, UltimoCambio)
                   SELECT @Sucursal, @Empresa, ''WMS'', @Moneda, @Almacen, @Tarima,  @Articulo, @SubCuenta, 0,     0,      0,            0,             @FechaEmision datetime',
                   N'@Sucursal int, @Empresa varchar(5), @Moneda varchar(20), @Almacen varchar(20), @Tarima varchar(20), @Articulo varchar(20), @SubCuenta varchar(50)',
                   @Sucursal, @Empresa, @Moneda, @Almacen, @Tarima, @Articulo, @SubCuenta
		  END -- TASK1964
		END
    END
  END
  RETURN
END
GO

/**************** spTMAExplocionTarimaOpcion ****************/
--TASK2429PGC
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'spTMAExplocionTarimaOpcion' AND type = 'P') DROP PROCEDURE spTMAExplocionTarimaOpcion
GO
CREATE PROCEDURE spTMAExplocionTarimaOpcion
					@Almacen		 varchar(10), 
					@Articulo		 varchar(20), 
                    @SubCuenta       varchar(50), --TASK2429PGC
					@Cantidad		 float = NULL, 
					@ControlArticulo varchar(20) = NULL, 
					@Tipo			 varchar(20) = NULL,
					@Estacion        int         = NULL,
					@Tarima			 varchar(20) OUTPUT,
					@Disponible		 float		 OUTPUT,
					@Posicion		 varchar(10) OUTPUT

--//WITH ENCRYPTION					
AS BEGIN
  
  SELECT @Tarima = NULL, @Disponible = NULL

  IF @Tipo = 'Ubicacion'
  BEGIN
    SELECT TOP 1 
	  @Tarima		= adt.Tarima,
	  @Disponible	= adt.Disponible - ISNULL(at.Apartado,0)
      FROM ArtDisponibleTarima adt  
 LEFT JOIN ArtApartadoTarima at ON adt.Empresa = at.Empresa AND adt.Articulo = at.Articulo AND adt.Almacen = at.Almacen AND adt.Tarima = at.Tarima
      JOIN Tarima t ON adt.Almacen =t.Almacen AND adt.Tarima = t.Tarima  
      JOIN AlmPos ap ON t.Almacen = ap.Almacen AND t.Posicion = ap.Posicion  
     WHERE adt.Almacen = @Almacen
       AND adt.Articulo = @Articulo
       AND ap.Tipo = 'Ubicacion'
       AND adt.Tarima NOT IN (SELECT ISNULL(Tarima,'') FROM #TarimaAux)       
       AND @Cantidad >= adt.Disponible - ISNULL(at.Apartado,0)
       AND adt.Disponible - ISNULL(at.Apartado,0) > 0
       AND t.SubCuenta=@SubCuenta --TASK2429PGC
       AND t.Estatus = 'ALTA'
     --BUG24515
     ORDER BY t.FechaCaducidad, CASE @ControlArticulo 
                WHEN 'Caducidad'		THEN CONVERT(varchar, t.FechaCaducidad)
                WHEN 'Fecha Entrada'	THEN CONVERT(varchar, t.Alta)
                ELSE t.Posicion
		  	  END
		  	  
--BUG24392
  END
  --TASK6535
  ELSE
  IF @Tipo = 'PCKUbicacion'
  BEGIN
    SELECT TOP 1 
	  @Tarima		= adt.Tarima,
	  @Disponible	= adt.Disponible - ISNULL(at.Apartado,0)
      FROM ArtDisponibleTarima adt  
      LEFT JOIN ArtApartadoTarima at ON adt.Empresa = at.Empresa AND adt.Articulo = at.Articulo AND adt.Almacen = at.Almacen AND adt.Tarima = at.Tarima
      JOIN Tarima t ON adt.Almacen =t.Almacen AND adt.Tarima = t.Tarima  
      JOIN AlmPos ap ON t.Almacen = ap.Almacen AND t.Posicion = ap.Posicion  
     WHERE adt.Almacen = @Almacen
       AND adt.Articulo = @Articulo
       AND ap.Tipo = 'Ubicacion'
       AND adt.Tarima NOT IN (SELECT ISNULL(Tarima,'') FROM #TarimaAux)       
       AND @Cantidad < adt.Disponible - ISNULL(at.Apartado,0)
       AND adt.Disponible - ISNULL(at.Apartado,0) > 0
       AND t.SubCuenta=@SubCuenta --TASK2429PGC
       AND t.Estatus = 'ALTA'
     ORDER BY t.FechaCaducidad, CASE @ControlArticulo 
                WHEN 'Caducidad'		THEN CONVERT(varchar, t.FechaCaducidad)
                WHEN 'Fecha Entrada'	THEN CONVERT(varchar, t.Alta)
                ELSE t.Posicion
		  	  END
  END
  ELSE
  IF @Tipo = 'Domicilio'
  BEGIN
    SELECT TOP 1
	  @Tarima		= adt.Tarima,
	  @Disponible	= adt.Disponible - ISNULL(at.Apartado,0)
      FROM ArtSubDisponibleTarima adt  --BUG3817
      LEFT JOIN ArtApartadoTarima at ON adt.Empresa = at.Empresa AND adt.Articulo = at.Articulo AND adt.Almacen = at.Almacen AND adt.Tarima = at.Tarima
      JOIN Tarima t ON adt.Almacen = t.Almacen AND adt.Tarima = t.Tarima  
      JOIN AlmPos ap ON t.Almacen = ap.Almacen AND t.Posicion = ap.Posicion  
     WHERE adt.Almacen = @Almacen AND adt.Articulo = @Articulo
       AND adt.Tarima NOT IN (SELECT Tarima FROM WMSTarimaMovPendiente)
       AND ap.ArticuloEsp = @Articulo AND ap.Tipo = @Tipo
       AND t.Estatus = 'ALTA'
       --EWQ. Tuning
       AND adt.Disponible - ISNULL(at.Apartado,0) > 0 AND t.Tarima NOT LIKE '%-%' AND adt.SubCuenta=@SubCuenta --TASK2429PGC --BUG3328 --BUG3817

    --EWQ. Tuning2
    IF @Tarima IS NULL
    BEGIN
      SELECT TOP 1
  	    @Tarima		= adt.Tarima,
	    @Disponible	= adt.Disponible - ISNULL(at.Apartado,0)
        FROM ArtSubDisponibleTarima adt  --BUG3817
        LEFT JOIN ArtApartadoTarima at ON adt.Empresa = at.Empresa AND adt.Articulo = at.Articulo AND adt.Almacen = at.Almacen AND adt.Tarima = at.Tarima
        JOIN Tarima t ON adt.Almacen = t.Almacen AND adt.Tarima = t.Tarima  
        JOIN AlmPos ap ON t.Almacen = ap.Almacen AND t.Posicion = ap.Posicion  
       WHERE adt.Tarima NOT IN (SELECT Tarima FROM WMSTarimaMovPendiente) AND adt.Almacen = @Almacen AND adt.Articulo = @Articulo AND ap.ArticuloEsp = @Articulo AND ap.Tipo = @Tipo
         --EWQ. Tuning
         AND adt.Disponible - ISNULL(at.Apartado,0) > 0 AND t.Tarima NOT LIKE '%-%' AND adt.SubCuenta=@SubCuenta --TASK2429PGC --BUG3328 --BUG3817
         AND t.Estatus = 'ALTA'

      SELECT @Disponible = @Disponible - ISNULL(SUM(Cantidad),0) FROM #TarimaAux WHERE Tarima = @Tarima

      IF ISNULL(@Disponible, 0) <= 0 SELECT @Tarima = NULL, @Disponible = 0
    END

    SELECT @Disponible = @Disponible - ISNULL(SUM(ISNULL(d.CantidadPendiente,0) /*+ ISNULL(d.CantidadPicking,0)*/),0)
      FROM TMAD d 
      JOIN TMA a ON a.ID = d.ID 
      JOIN MovTipo m ON m.Mov = a.Mov AND m.Modulo = 'TMA' 
     WHERE a.Estatus IN ('PENDIENTE', 'PROCESAR') 
       --BUG24665
       AND m.Clave IN ('TMA.OSUR', 'TMA.TSUR', 'TMA.SRADO', 'TMA.SADO', 'TMA.ORADO', 'TMA.OADO')
       AND Tarima = @Tarima
       AND d.Procesado = CASE m.Clave
						   WHEN 'TMA.OSUR'  THEN d.Procesado
				           WHEN 'TMA.TSUR'  THEN d.Procesado
						   WHEN 'TMA.SRADO' THEN 0
				           WHEN 'TMA.SADO'  THEN 0
						   --BUG24665
						   WHEN 'TMA.ORADO' THEN 0
				           WHEN 'TMA.OADO'  THEN 0
				         END

    SELECT @Disponible = @Disponible + ISNULL(SUM(ISNULL(d.CantidadPendiente,0) + ISNULL(d.CantidadPicking,0)),0)
      FROM TMAD d 
      JOIN TMA a ON a.ID = d.ID 
      JOIN MovTipo m ON m.Mov = a.Mov AND m.Modulo = 'TMA' 
     WHERE a.Estatus IN ('PENDIENTE') AND m.Clave IN ('TMA.SRADO', 'TMA.ORADO') AND PosicionDestino IN(SELECT Posicion FROM AlmPos WHERE Almacen = @Almacen AND ArticuloEsp = @Articulo AND Tipo = @Tipo)
  
    --EWQ. Tuning2
    IF ISNULL(@Disponible, 0) <= 0 SELECT @Tarima = NULL, @Disponible = 0
  END
  ELSE
 	SELECT TOP 1
	  @Tarima		= t.Tarima,
	  @Disponible	= d.Disponible - ISNULL(at.Apartado,0),
	  @Posicion		= t.Posicion
      FROM ArtDisponibleTarima d 
      LEFT JOIN ArtApartadoTarima at ON d.Empresa = at.Empresa AND d.Articulo = at.Articulo AND d.Almacen = at.Almacen AND d.Tarima = at.Tarima
      JOIN Tarima t ON d.Tarima = t.Tarima
      JOIN AlmPos p ON t.Almacen = p.Almacen AND p.Posicion = t.Posicion
      JOIN Art a ON d.Articulo = a.Articulo         
     WHERE d.Almacen = @Almacen
       AND p.Tipo = 'Ubicacion'
       AND d.Articulo = @Articulo
       AND t.Estatus = 'ALTA'
       AND p.Estatus = 'ALTA'
       AND t.Tarima NOT LIKE '%-%'       
       AND d.Tarima NOT IN (SELECT Tarima FROM WMSSurtidoProcesarD WHERE Estacion = @Estacion AND Articulo = @Articulo AND Procesado = 0)
       AND d.Tarima NOT IN (SELECT wP.Tarima FROM WMSSurtidoProcesarD wp WHERE wp.Estacion = @Estacion AND wp.Procesado = 1 AND wp.Tipo = 'Ubicacion' AND Articulo IN(SELECT DISTINCT Clave FROM ListaSt WHERE Estacion = @Estacion))
	   --BUG24665       
	   --BUG25367
	   AND d.Disponible - ISNULL(at.Apartado,0) > 0
	   AND t.SubCuenta=@SubCuenta --TASK2429PGC --BUG3328
     --BUG24515
     ORDER BY t.FechaCaducidad, CASE @ControlArticulo        
                WHEN 'Caducidad'		THEN CONVERT(varchar, t.FechaCaducidad)
                WHEN 'Fecha Entrada'	THEN CONVERT(varchar, t.Alta)
                ELSE t.Posicion
		  	  END
  RETURN
END 
GO

--BUG2983
/**************** spTMAExplocionTarimaSerieLote ****************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'spTMAExplocionTarimaSerieLote' AND type = 'P') DROP PROCEDURE spTMAExplocionTarimaSerieLote
GO
CREATE PROCEDURE spTMAExplocionTarimaSerieLote 
                    @Modulo          varchar(5), --BUG4007
                    @ID              int, --BUG2983
					@Almacen		 varchar(10), 
					@Articulo		 varchar(20), 
					@Cantidad		 float = NULL, 
					@ControlArticulo varchar(20) = NULL, 
					@Tipo			 varchar(20) = NULL,
					@Estacion        int         = NULL,
					@Tarima			 varchar(20) OUTPUT,
					@Disponible		 float		 OUTPUT,
					@Posicion		 varchar(10) OUTPUT,
                    @RenglonID       int, 
                    @SerieLote       varchar(50)

--//WITH ENCRYPTION					
AS BEGIN
  --IF @Tipo IN ('PCKUbicacion','Domicilio')
  --BEGIN
  --  SELECT @Disponible = slmv.Cantidad
  --    FROM ArtDisponibleTarima adt
  --    JOIN SerieLoteMov slmv ON slmv.ID = @ID 
  --     AND slmv.SerieLote = @SerieLote 
  --     AND slmv.Modulo    = @Modulo
  --     AND slmv.RenglonID = @RenglonID 
  --     AND adt.Empresa    = slmv.Empresa
  --     AND adt.Tarima     = slmv.Tarima
  --   WHERE adt.Tarima     = @Tarima
  --     AND adt.Almacen    = @Almacen
  --     AND adt.Articulo   = @Articulo
  --END
	--IF @Tipo IN ('Cross Docking','Ubicacion')
	--BEGIN
	--	SELECT @Tarima = NULL, @Disponible = NULL
 --   END
  IF @Tipo IN ('Cross Docking','Ubicacion','PCKUbicacion','Domicilio')
  BEGIN
      IF @Tipo = 'Cross Docking'
      BEGIN
        SELECT TOP 1
	      @Tarima		= adt.Tarima,
	      @Disponible	= slmv.Cantidad 
          FROM ArtDisponibleTarima adt 
     LEFT JOIN ArtApartadoTarima at ON adt.Empresa = at.Empresa AND adt.Articulo = at.Articulo AND adt.Almacen = at.Almacen AND adt.Tarima = at.Tarima
          JOIN Tarima t ON adt.Almacen =t.Almacen AND adt.Tarima = t.Tarima  
          JOIN AlmPos ap ON t.Almacen = ap.Almacen AND t.Posicion = ap.Posicion  
	      JOIN SerieLoteMov slmv ON slmv.Modulo=@Modulo AND slmv.ID=@ID AND slmv.RenglonID = @RenglonID AND slmv.SerieLote = @SerieLote AND adt.Tarima = slmv.Tarima
     LEFT JOIN ArtApartadoSerieTarima a ON adt.Empresa = a.Empresa AND adt.Articulo = a.Articulo AND adt.Almacen = a.Almacen AND adt.Tarima = a.Tarima AND a.Serielote = @SerieLote
         WHERE adt.Almacen = @Almacen
           AND adt.Articulo = @Articulo
           AND slmv.SerieLote = @SerieLote
           AND adt.Tarima = @Tarima
           AND ap.Tipo = 'Cross Docking'
           AND t.Estatus = 'ALTA'
         ORDER BY t.FechaCaducidad, CASE @ControlArticulo 
                    WHEN 'Caducidad'		THEN CONVERT(varchar, t.FechaCaducidad)
                    WHEN 'Fecha Entrada'	THEN CONVERT(varchar, t.Alta)
                    ELSE t.Posicion
		  	      END, adt.Tarima ASC 
      END
			   
      IF @Tipo = 'Ubicacion'
      BEGIN
        

        SELECT TOP 1 
	      @Tarima		= adt.Tarima,
	      @Disponible	= adt.Disponible - ISNULL(a.Apartado,0) - ISNULL(ta.CantidadA,0) 
          FROM ArtDisponibleTarima adt  
     LEFT JOIN ArtApartadoTarima at ON adt.Empresa = at.Empresa AND adt.Articulo = at.Articulo AND adt.Almacen = at.Almacen AND adt.Tarima = at.Tarima
          JOIN Tarima t ON adt.Almacen = t.Almacen AND adt.Tarima = t.Tarima  
          JOIN AlmPos ap ON t.Almacen = ap.Almacen AND t.Posicion = ap.Posicion  
	      --BUG2983
	      JOIN SerieLoteMov slmv ON slmv.Modulo=@Modulo AND slmv.ID=@ID AND slmv.RenglonID = @RenglonID AND slmv.SerieLote = @SerieLote AND adt.Tarima = slmv.Tarima --BUG4007
     LEFT JOIN ArtApartadoSerieTarima a ON adt.Empresa = a.Empresa AND adt.Articulo = a.Articulo AND adt.Almacen = a.Almacen AND adt.Tarima = a.Tarima AND a.Serielote = @SerieLote
     LEFT JOIN #TarimaAux ta ON adt.Tarima = ta.Tarima
         WHERE adt.Almacen = @Almacen
           AND adt.Articulo = @Articulo
           AND ap.Tipo = 'Ubicacion'
           --AND adt.Tarima NOT IN (SELECT ISNULL(Tarima,'') FROM #TarimaAux)
           AND adt.Disponible - ISNULL(a.Apartado,0) - ISNULL(ta.CantidadA,0) > 0
           AND @Cantidad >= adt.Disponible - ISNULL(at.Apartado,0) - ISNULL(ta.CantidadA,0)      
           AND adt.Tarima NOT IN (SELECT Tarima FROM WMSSurtidoProcesarD WHERE Tipo <> 'Ubicacion' AND Estacion = @Estacion)
           AND adt.Tarima = @Tarima
         ORDER BY t.FechaCaducidad, CASE @ControlArticulo 
                    WHEN 'Caducidad'		THEN CONVERT(varchar, t.FechaCaducidad)
                    WHEN 'Fecha Entrada'	THEN CONVERT(varchar, t.Alta)
                    ELSE t.Posicion
		  	      END, adt.Tarima ASC  

      END
      --TASK6535

      IF @Tipo = 'Domicilio'
      BEGIN
        SELECT TOP 1
	      @Tarima		= adt.Tarima,
	      @Disponible	= slmv.Cantidad
          FROM ArtDisponibleTarima adt  
     LEFT JOIN ArtApartadoTarima at ON adt.Empresa = at.Empresa AND adt.Articulo = at.Articulo AND adt.Almacen = at.Almacen AND adt.Tarima = at.Tarima
          JOIN Tarima t ON adt.Almacen = t.Almacen AND adt.Tarima = t.Tarima  
          JOIN AlmPos ap ON t.Almacen = ap.Almacen AND t.Posicion = ap.Posicion  
	      --BUG2983
	      JOIN SerieLoteMov slmv ON slmv.Modulo=@Modulo AND slmv.ID=@ID AND slmv.SerieLote = @SerieLote AND adt.Tarima = slmv.Tarima--BUG4007
     LEFT JOIN ArtApartadoSerieTarima a ON adt.Empresa = a.Empresa AND adt.Articulo = a.Articulo AND adt.Almacen = a.Almacen AND adt.Tarima = a.Tarima AND a.Serielote = @SerieLote
         WHERE adt.Almacen = @Almacen 
           AND adt.Articulo = @Articulo 
           AND ap.ArticuloEsp = @Articulo 
           AND ap.Tipo = @Tipo
           --AND adt.Tarima NOT IN (SELECT ISNULL(Tarima,'') FROM #TarimaAux GROUP BY ISNULL(Tarima,''), CantidadA HAVING (SUM(Cantidad)+@Cantidad > CantidadA)) --REQ 14684
           AND adt.Disponible - ISNULL(a.Apartado,0) > 0 AND t.Tarima NOT LIKE '%-%'
           AND slmv.SerieLote = @SerieLote
           AND adt.Tarima = @Tarima
           AND t.Estatus = 'ALTA'

      END

      IF @Tipo = 'PCKUbicacion'
      BEGIN

        SELECT TOP 1 
	      @Tarima		= adt.Tarima,
	      @Disponible	= slmv.Cantidad - ISNULL(ta.CantidadA,0)
          FROM ArtDisponibleTarima adt  
     LEFT JOIN ArtApartadoTarima at ON adt.Empresa = at.Empresa AND adt.Articulo = at.Articulo AND adt.Almacen = at.Almacen AND adt.Tarima = at.Tarima
          JOIN Tarima t ON adt.Almacen =t.Almacen AND adt.Tarima = t.Tarima  
          JOIN AlmPos ap ON t.Almacen = ap.Almacen AND t.Posicion = ap.Posicion  
	      --BUG2983
	      JOIN SerieLoteMov slmv ON slmv.Modulo=@Modulo AND slmv.ID=@ID AND slmv.RenglonID = @RenglonID AND slmv.SerieLote = @SerieLote AND adt.Tarima = slmv.Tarima --BUG4007
     LEFT JOIN ArtApartadoSerieTarima a ON adt.Empresa = a.Empresa AND adt.Articulo = a.Articulo AND adt.Almacen = a.Almacen AND adt.Tarima = a.Tarima AND a.Serielote = @SerieLote
     LEFT JOIN #TarimaAux ta ON adt.Tarima = ta.Tarima        
         WHERE adt.Almacen = @Almacen
           AND adt.Articulo = @Articulo
           AND ap.Tipo = 'Ubicacion'
           --AND adt.Tarima NOT IN (SELECT ISNULL(Tarima,'') FROM #TarimaAux WHERE (ISNULL(adt.Disponible,0)-ISNULL(a.Apartado,0)) - ISNULL(Cantidad,0) <= 0)
           AND adt.Disponible - ISNULL(a.Apartado,0) - ISNULL(ta.CantidadA,0) > 0
           AND @Cantidad < (adt.Disponible - ISNULL(a.Apartado,0)  - ISNULL(ta.CantidadA,0))  
           AND adt.Tarima NOT IN (SELECT Tarima FROM WMSSurtidoProcesarD WHERE Tipo <> 'Ubicacion' AND Estacion = @Estacion)
           AND slmv.SerieLote = @SerieLote
           AND adt.Tarima = @Tarima
           AND t.Estatus = 'ALTA'
         --BUG24515
         ORDER BY t.FechaCaducidad, CASE @ControlArticulo 
                    WHEN 'Caducidad'		THEN CONVERT(varchar, t.FechaCaducidad)
                    WHEN 'Fecha Entrada'	THEN CONVERT(varchar, t.Alta)
                    ELSE t.Posicion
		  	      END, adt.Tarima ASC
          END	 
  END
   RETURN
END
GO

--BUG2983
/**************** spTMAExplocionTarimaOpcionSerieLote ****************/
--TASK2429PGC
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'spTMAExplocionTarimaOpcionSerieLote' AND type = 'P') DROP PROCEDURE spTMAExplocionTarimaOpcionSerieLote
GO
CREATE PROCEDURE spTMAExplocionTarimaOpcionSerieLote
                    @Modulo          varchar(5), --BUG4007
                    @ID              int, --BUG2983
					@Almacen		 varchar(10), 
					@Articulo		 varchar(20), 
                    @SubCuenta       varchar(50), --TASK2429PGC
					@Cantidad		 float = NULL, 
					@ControlArticulo varchar(20) = NULL, 
					@Tipo			 varchar(20) = NULL,
					@Estacion        int         = NULL,
					@Tarima			 varchar(20) OUTPUT,
					@Disponible		 float		 OUTPUT,
					@Posicion		 varchar(10) OUTPUT,
                    @RenglonID       int, 
                    @SerieLote       varchar(50)

--//WITH ENCRYPTION					
AS BEGIN

  SELECT @Tarima = NULL, @Disponible = NULL

  IF @Tipo = 'Ubicacion'
  BEGIN
    SELECT TOP 1 
	  @Tarima		= adt.Tarima,
	  @Disponible	= adt.Disponible - ISNULL(a.Apartado,0)
      FROM ArtDisponibleTarima adt  
 LEFT JOIN ArtApartadoTarima at ON adt.Empresa = at.Empresa AND adt.Articulo = at.Articulo AND adt.Almacen = at.Almacen AND adt.Tarima = at.Tarima
      JOIN Tarima t ON adt.Almacen =t.Almacen AND adt.Tarima = t.Tarima  
      JOIN AlmPos ap ON t.Almacen = ap.Almacen AND t.Posicion = ap.Posicion 
	  --BUG2983
	  JOIN SerieLoteMov slmv ON slmv.Modulo=@Modulo AND slmv.ID=@ID --BUG4007
 LEFT JOIN ArtApartadoSerieTarima a ON adt.Empresa = a.Empresa AND adt.Articulo = a.Articulo AND adt.Almacen = a.Almacen AND adt.Tarima = a.Tarima AND a.Serielote = @SerieLote
     WHERE adt.Almacen = @Almacen
       AND adt.Articulo = @Articulo
       AND ap.Tipo = 'Ubicacion'
       AND adt.Tarima NOT IN (SELECT ISNULL(Tarima,'') FROM #TarimaAux)
       AND adt.Disponible - ISNULL(a.Apartado,0) > 0
       AND @Cantidad >= adt.Disponible - ISNULL(at.Apartado,0)      
       AND t.SubCuenta=@SubCuenta --TASK2429PGC
       AND t.Estatus = 'ALTA'
     --BUG24515
     ORDER BY t.FechaCaducidad, CASE @ControlArticulo 
                WHEN 'Caducidad'		THEN CONVERT(varchar, t.FechaCaducidad)
                WHEN 'Fecha Entrada'	THEN CONVERT(varchar, t.Alta)
                ELSE t.Posicion
		  	  END
  END
  ELSE
  IF @Tipo = 'Ubicacion'
  BEGIN
    SELECT TOP 1 
	  @Tarima		= adt.Tarima,
	  @Disponible	= adt.Disponible - ISNULL(a.Apartado,0) 
      FROM ArtDisponibleTarima adt  
 LEFT JOIN ArtApartadoTarima at ON adt.Empresa = at.Empresa AND adt.Articulo = at.Articulo AND adt.Almacen = at.Almacen AND adt.Tarima = at.Tarima
      JOIN Tarima t ON adt.Almacen =t.Almacen AND adt.Tarima = t.Tarima  
      JOIN AlmPos ap ON t.Almacen = ap.Almacen AND t.Posicion = ap.Posicion 
	  --BUG2983
	  JOIN SerieLoteMov slmv ON slmv.Modulo=@Modulo AND slmv.ID=@ID --BUG4007
 LEFT JOIN ArtApartadoSerieTarima a ON adt.Empresa = a.Empresa AND adt.Articulo = a.Articulo AND adt.Almacen = a.Almacen AND adt.Tarima = a.Tarima AND a.Serielote = @SerieLote
     WHERE adt.Almacen = @Almacen
       AND adt.Articulo = @Articulo
       AND ap.Tipo = 'Ubicacion'
       AND adt.Tarima NOT IN (SELECT ISNULL(Tarima,'') FROM #TarimaAux)
       AND adt.Disponible - ISNULL(a.Apartado,0) > 0 
       AND @Cantidad < adt.Disponible       
       AND t.SubCuenta=@SubCuenta --TASK2429PGC
       AND t.Estatus = 'ALTA'
       --AND ap.SubCuenta=t.SubCuenta --TASK2429PGC 07082015
     --BUG24515
     ORDER BY t.FechaCaducidad, CASE @ControlArticulo 
                WHEN 'Caducidad'		THEN CONVERT(varchar, t.FechaCaducidad)
                WHEN 'Fecha Entrada'	THEN CONVERT(varchar, t.Alta)
                ELSE t.Posicion
		  	  END
  END
  ELSE
  IF @Tipo = 'Domicilio'
  BEGIN
    SELECT TOP 1
	  @Tarima		= adt.Tarima,
	  @Disponible	= adt.Disponible - ISNULL(a.Apartado,0) 
      --FROM ArtDisponibleTarima adt  
      FROM ArtSubDisponibleTarima adt  --BUG3817
 LEFT JOIN ArtApartadoTarima at ON adt.Empresa = at.Empresa AND adt.Articulo = at.Articulo AND adt.Almacen = at.Almacen AND adt.Tarima = at.Tarima
      JOIN Tarima t ON adt.Almacen = t.Almacen AND adt.Tarima = t.Tarima  
      JOIN AlmPos ap ON t.Almacen = ap.Almacen AND t.Posicion = ap.Posicion  
	  --BUG2983
	  JOIN SerieLoteMov slmv ON slmv.Modulo=@Modulo AND slmv.ID=@ID --BUG4007
 LEFT JOIN ArtApartadoSerieTarima a ON adt.Empresa = a.Empresa AND adt.Articulo = a.Articulo AND adt.Almacen = a.Almacen AND adt.Tarima = a.Tarima AND a.Serielote = @SerieLote
     WHERE adt.Almacen = @Almacen
       AND adt.Articulo = @Articulo
       AND ap.ArticuloEsp = @Articulo
       AND ap.Tipo = @Tipo
       --EWQ. Tuning
       AND adt.Disponible - ISNULL(a.Apartado,0) > 0
       AND t.Tarima NOT LIKE '%-%'
       AND adt.SubCuenta=@SubCuenta --TASK2429PGC --BUG3328 --BUG3817
       AND t.Estatus = 'ALTA'

    --EWQ. Tuning2
    IF @Tarima IS NULL
    BEGIN
      SELECT TOP 1
  	    @Tarima		= adt.Tarima,
	    @Disponible	= adt.Disponible - ISNULL(a.Apartado,0) 
        --FROM ArtDisponibleTarima adt  
        FROM ArtSubDisponibleTarima adt  --BUG3817
   LEFT JOIN ArtApartadoTarima at ON adt.Empresa = at.Empresa AND adt.Articulo = at.Articulo AND adt.Almacen = at.Almacen AND adt.Tarima = at.Tarima
        JOIN Tarima t ON adt.Almacen = t.Almacen AND adt.Tarima = t.Tarima  
        JOIN AlmPos ap ON t.Almacen = ap.Almacen AND t.Posicion = ap.Posicion
		--BUG2983
	    JOIN SerieLoteMov slmv ON slmv.Modulo=@Modulo AND slmv.ID=@ID --BUG4007
   LEFT JOIN ArtApartadoSerieTarima a ON adt.Empresa = a.Empresa AND adt.Articulo = a.Articulo AND adt.Almacen = a.Almacen AND adt.Tarima = a.Tarima AND a.Serielote = @SerieLote
       WHERE adt.Almacen = @Almacen
         AND adt.Articulo = @Articulo
         AND ap.ArticuloEsp = @Articulo
         AND ap.Tipo = @Tipo
         AND adt.Disponible - ISNULL(a.Apartado,0) > 0
         AND t.Tarima NOT LIKE '%-%'
         AND adt.SubCuenta=@SubCuenta --TASK2429PGC --BUG3328 --BUG3817
         AND t.Estatus = 'ALTA'

      SELECT @Disponible = @Disponible - ISNULL(SUM(Cantidad),0) FROM #TarimaAux WHERE Tarima = @Tarima

      IF ISNULL(@Disponible, 0) <= 0 SELECT @Tarima = NULL, @Disponible = 0
    END

    SELECT @Disponible = @Disponible - ISNULL(SUM(ISNULL(d.CantidadPendiente,0) /*+ ISNULL(d.CantidadPicking,0)*/),0)
      FROM TMAD d 
      JOIN TMA a ON a.ID = d.ID 
      JOIN MovTipo m ON m.Mov = a.Mov AND m.Modulo = 'TMA' 
     WHERE a.Estatus IN ('PENDIENTE', 'PROCESAR') 
       --BUG24665
       AND m.Clave IN ('TMA.OSUR', 'TMA.TSUR', 'TMA.SRADO', 'TMA.SADO', 'TMA.ORADO', 'TMA.OADO')
       AND Tarima = @Tarima
       AND d.Procesado = CASE m.Clave
						   WHEN 'TMA.OSUR'  THEN d.Procesado
				           WHEN 'TMA.TSUR'  THEN d.Procesado
						   WHEN 'TMA.SRADO' THEN 0
				           WHEN 'TMA.SADO'  THEN 0
						   --BUG24665
						   WHEN 'TMA.ORADO' THEN 0
				           WHEN 'TMA.OADO'  THEN 0
				         END

    SELECT @Disponible = @Disponible + ISNULL(SUM(ISNULL(d.CantidadPendiente,0) + ISNULL(d.CantidadPicking,0)),0)
      FROM TMAD d 
      JOIN TMA a ON a.ID = d.ID 
      JOIN MovTipo m ON m.Mov = a.Mov AND m.Modulo = 'TMA' 
     WHERE a.Estatus IN ('PENDIENTE') 
       AND m.Clave IN ('TMA.SRADO', 'TMA.ORADO')
       AND PosicionDestino IN(SELECT Posicion FROM AlmPos WHERE Almacen = @Almacen AND ArticuloEsp = @Articulo AND Tipo = @Tipo)
  
    --EWQ. Tuning2
    IF ISNULL(@Disponible, 0) <= 0 SELECT @Tarima = NULL, @Disponible = 0
  END
  ELSE
 	SELECT TOP 1
	  @Tarima		= t.Tarima,
	  @Disponible	= d.Disponible - ISNULL(ast.Apartado,0),
	  @Posicion		= t.Posicion
      FROM ArtDisponibleTarima d 
 LEFT JOIN ArtApartadoTarima at ON d.Empresa = at.Empresa AND d.Articulo = at.Articulo AND d.Almacen = at.Almacen AND d.Tarima = at.Tarima
      JOIN Tarima t ON d.Tarima = t.Tarima
      JOIN AlmPos p ON t.Almacen = p.Almacen AND p.Posicion = t.Posicion
      JOIN Art a ON d.Articulo = a.Articulo         
	  --BUG2983
	  JOIN SerieLoteMov slmv ON slmv.Modulo=@Modulo AND slmv.ID=@ID --BUG4007
 LEFT JOIN ArtApartadoSerieTarima ast ON d.Empresa = ast.Empresa AND d.Articulo = ast.Articulo AND d.Almacen = ast.Almacen AND d.Tarima = ast.Tarima AND ast.Serielote = @SerieLote
     WHERE d.Almacen = @Almacen
       AND p.Tipo = 'Ubicacion'
       AND d.Articulo = @Articulo
       AND t.Estatus = 'ALTA'
       AND p.Estatus = 'ALTA'
       AND t.Tarima NOT LIKE '%-%'
       AND d.Tarima NOT IN (SELECT Tarima FROM WMSSurtidoProcesarD WHERE Estacion = @Estacion AND Articulo = @Articulo AND Procesado = 0)
       AND d.Tarima NOT IN (SELECT wP.Tarima FROM WMSSurtidoProcesarD wp WHERE wp.Estacion = @Estacion AND wp.Procesado = 1 AND wp.Tipo = 'Ubicacion' AND Articulo IN(SELECT DISTINCT Clave FROM ListaSt WHERE Estacion = @Estacion))
	   AND Disponible - ISNULL(ast.Apartado,0) > 0
	   AND ISNULL(t.SubCuenta,'') = ISNULL(@SubCuenta,'') --TASK2429PGC --BUG3328
	   AND t.Estatus = 'ALTA'
     --BUG24515
     ORDER BY t.FechaCaducidad, CASE @ControlArticulo        
                WHEN 'Caducidad'		THEN CONVERT(varchar, t.FechaCaducidad)
                WHEN 'Fecha Entrada'	THEN CONVERT(varchar, t.Alta)
                ELSE t.Posicion
		  	  END
  RETURN
END
GO

--TASK2429PGC
/**************** spTMAArtDomicilioInicializarOpcion ****************/
--TASK2429PGC
if exists (select * from sysobjects where id = object_id('dbo.spTMAArtDomicilioInicializarOpcion') and type = 'P') drop procedure dbo.spTMAArtDomicilioInicializarOpcion
GO
CREATE PROC spTMAArtDomicilioInicializarOpcion
			@Empresa		varchar(5),
			@Almacen		varchar(10),
			@Articulo		varchar(20),
			@SubCuenta		varchar(20)
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Posicion		varchar(10),
		  @PosicionAnt	varchar(10),
		  @Tarima		varchar(20),
		  @TarimaAnt	varchar(20),
		  @Moneda		varchar(10),
		  @Sucursal		int,
		  --BUG24105
          @FechaEmision	datetime,
          @Ok			int,
          @OkRef		varchar(255),

		  @WMSAuxiliar	bit -- TASK1964

  SELECT @FechaEmision = GETDATE()

  EXEC spExtraerFecha @FechaEmision OUTPUT

  SELECT @Sucursal = Sucursal FROM Alm WHERE Almacen = @Almacen
  SELECT @SubCuenta = ISNULL(@SubCuenta, '')
  SELECT @Moneda = MonedaCosto FROM Art WHERE Articulo = @Articulo
  SELECT @PosicionAnt = ''

  SELECT @WMSAuxiliar = WMSAuxiliar FROM Version -- TASK1964

  WHILE(1=1)
  BEGIN
--SELECT * FROM AlmPos WHERE SubCuenta=@SubCuenta
    SELECT @Posicion = MIN(Posicion)
      FROM AlmPos
     WHERE Almacen = @Almacen 
       AND Posicion > @PosicionAnt
       AND ArticuloEsp = @Articulo
       AND Tipo = 'Domicilio'
       AND SubCuenta=@SubCuenta

    IF @Posicion IS NULL BREAK
    
    SELECT @PosicionAnt = @Posicion

    --BUG24105
    IF NOT EXISTS(SELECT * FROM Tarima WHERE Posicion = @Posicion)
    BEGIN
      SELECT @Ok = NULL, @OkRef = NULL, @Tarima = NULL

      EXEC spConsecutivo 'Tarima', @Sucursal, @Tarima OUTPUT      

      EXEC spTarimaAlta @Empresa, @Sucursal, '', @Almacen, @FechaEmision, @FechaEmision, @Tarima, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT      

      UPDATE Tarima SET Posicion = @Posicion, SubCuenta=@SubCuenta WHERE Tarima = @Tarima --TASK2429PGC
    END

    SELECT @TarimaAnt = ''
    WHILE(1=1)
    BEGIN
      SELECT @Tarima = MIN(Tarima)
        FROM Tarima
       WHERE Almacen = @Almacen 
         AND Posicion = @Posicion
         AND Tarima > @TarimaAnt
         AND Estatus = 'ALTA'

      IF @Tarima IS NULL BREAK
    
      SELECT @TarimaAnt = @Tarima

	  --TASK24685
      IF NOT EXISTS(SELECT * FROM ArtDisponibleTarima WHERE Tarima = @Tarima AND Almacen = @Almacen AND Empresa = @Empresa AND Articulo <> @Articulo)
        IF NOT EXISTS(SELECT Grupo FROM SaldoUGral WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Grupo = @Almacen AND Cuenta = @Articulo AND SubCuenta = @SubCuenta AND Rama IN('INV','WMS') AND Moneda = @Moneda AND SubGrupo = @Tarima)
        BEGIN
          IF @WMSAuxiliar = 1 -- TASK1964
          BEGIN -- TASK1964
		    INSERT INTO SaldoUWMS(
                   Sucursal,  Empresa, Rama,   Moneda,  Grupo,    SubGrupo,  Cuenta,    SubCuenta, Saldo, SaldoU, PorConciliar, PorConciliarU, UltimoCambio)
		    SELECT @Sucursal, @Empresa, 'WMS', @Moneda, @Almacen, @Tarima,   @Articulo, @SubCuenta, 0,     0,      0,            0,             GETDATE()		    
          END ELSE BEGIN -- TASK1964
            EXEC dbo.sp_executesql N'INSERT INTO SaldoU(
                   Sucursal,  Empresa, Rama,   Moneda,  Grupo,    SubGrupo,  Cuenta,    SubCuenta, Saldo, SaldoU, PorConciliar, PorConciliarU, UltimoCambio)
                   SELECT @Sucursal, @Empresa, ''INV'', @Moneda, @Almacen, @Tarima,  @Articulo, @SubCuenta, 0,     0,      0,            0,             GETDATE()',
                   N'@Sucursal int, @Empresa varchar(5), @Moneda varchar(20), @Almacen varchar(20), @Tarima varchar(20), @Articulo varchar(20), @SubCuenta varchar(50)',
                   @Sucursal, @Empresa, @Moneda, @Almacen, @Tarima, @Articulo, @SubCuenta
		  END -- TASK1964
		END
    END
  END
  RETURN
END
GO

/***************************************     spPreparaDatosSurtir     *************************************************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'spPreparaDatosSurtir' AND type = 'P') DROP PROCEDURE spPreparaDatosSurtir
GO
CREATE PROCEDURE spPreparaDatosSurtir  
    @Modulo       varchar(5),
    @Id           int,
    @Articulo     varchar(20), 
    @Renglon      float, 
    @RenglonID    int,
    @Empresa      varchar(5),
    @Tarima		  varchar(20),
    @SerieLote	  varchar(50)
--//WITH ENCRYPTION
AS  
BEGIN

      IF @Modulo = 'VTAS' 
      BEGIN
        SELECT Modulo, 
               Mov, 
               ID, 
               SUM(Cantidad),
               Posicion, 
               Articulo, 
               SubCuenta, 
               Almacen, 
               Unidad, 
               CantidadUnidad, 
               Factor,                
               RenglonID, 
               SerieLote, 
               Tarima
          FROM
          (
              SELECT  'VTAS' Modulo, 
                      v.Mov, 
                      v.ID, 
                      SUM(ISNULL(slm.Cantidad, ISNULL(vd.CantidadInventario,vd.Cantidad))) AS Cantidad,
                      CASE ISNULL(e.WMSAndenSurtidoContacto,0) WHEN 1 THEN ISNULL(NULLIF(c.DefPosicionSurtido,''), ISNULL(v.PosicionWMS, a.DefPosicionSurtido)) ELSE ISNULL(v.PosicionWMS, a.DefPosicionSurtido) END as Posicion, 
                      vd.Articulo, 
                      vd.SubCuenta, 
                      vd.Almacen, 
                      vd.Unidad, 
                      vd.Cantidad CantidadUnidad, 
                      CASE g.NivelFactorMultiUnidad WHEN 'Unidad' THEN ISNULL( u.Factor, 1) ELSE ISNULL( au.Factor, 1) END Factor,
                     vd.RenglonID, 
                     slm.SerieLote, 
                     ISNULL(slm.Tarima,@Tarima) Tarima
                FROM Venta v  
                JOIN VentaD vd ON v.ID = vd.ID  
           LEFT JOIN SerieLoteMov slm ON vd.ID = slm.ID AND vd.RenglonID = slm.RenglonID AND vd.Articulo = slm.Articulo AND ISNULL(vd.SubCuenta,'') = ISNULL(slm.SubCuenta,ISNULL(vd.SubCuenta,'')) AND slm.Modulo = @Modulo AND v.Empresa = slm.Empresa
                JOIN Cte c ON v.Cliente = c.Cliente  
           LEFT JOIN CteEnviarA ca ON c.Cliente = ca.Cliente AND vd.EnviarA = ca.ID  
                JOIN Alm a ON vd.Almacen = a.Almacen
                JOIN EmpresaCfg e ON e.Empresa = @Empresa
           LEFT JOIN WMSModuloTarima w ON w.IDModulo = v.ID AND w.Modulo = 'VTAS' AND w.IDTMA IS NOT NULL AND Utilizar = 1
           LEFT JOIN TMA t ON t.ID = w.IDTMA AND t.Estatus <> 'CANCELADO'
	       LEFT JOIN EmpresaCfg2 g ON v.Empresa = g.Empresa
           LEFT JOIN Unidad u ON vd.Unidad = u.Unidad
	       LEFT JOIN ArtUnidad au ON vd.Articulo = au.Articulo AND vd.Unidad = au.Unidad
                WHERE v.ID = @Id
                  AND vd.Articulo = @Articulo
				  AND vd.Renglon  = @Renglon
                  AND vd.RenglonID = @RenglonID
                  AND ISNULL(slm.Tarima,@Tarima) = ISNULL(@Tarima,'')
                  AND ISNULL(slm.SerieLote,'') = ISNULL(@SerieLote,'')
                  AND v.Estatus = (SELECT Estatus FROM WMSModuloMovimiento WHERE Modulo = 'VTAS' AND Movimiento = v.Mov)
                  AND NULLIF(vd.Tarima,'') IS NULL        
                  AND Isnull(vd.CantidadPendiente, '') > 0     
                GROUP BY v.Mov, v.ID, CASE ISNULL(e.WMSAndenSurtidoContacto,0) WHEN 1 THEN ISNULL(NULLIF(c.DefPosicionSurtido,''),ISNULL(v.PosicionWMS, a.DefPosicionSurtido)) ELSE ISNULL(v.PosicionWMS, a.DefPosicionSurtido) END, vd.Articulo, vd.SubCuenta, vd.Almacen, g.NivelFactorMultiUnidad, ISNULL( u.Factor, 1), ISNULL( au.Factor, 1), vd.Unidad, vd.Cantidad, ISNULL( u.Factor, 1),vd.RenglonID, slm.SerieLote, slm.Tarima
          ) AS x
          GROUP BY Modulo, Mov, ID, Posicion, Articulo, SubCuenta, Almacen, Unidad, CantidadUnidad, Factor, RenglonID, SerieLote, Tarima 
          ORDER BY Posicion, Tarima, Articulo, SubCuenta, Almacen, Unidad, CantidadUnidad, Factor
      END 
      ELSE
        IF @Modulo = 'COMS' 
        BEGIN
            SELECT Modulo, 
                   Mov, 
                   ID, 
                   SUM(Cantidad), 
                   Posicion, 
                   Articulo, 
                   SubCuenta, 
                   Almacen, 
                   Unidad, 
                   CantidadUnidad, 
                   Factor,                    
                   RenglonID, 
                   SerieLote, 
                   Tarima
              FROM
              (
                  SELECT 'COMS' Modulo, 
                         v.Mov, 
                         v.ID,
                         SUM(ISNULL(slm.Cantidad, ISNULL(vd.CantidadInventario,vd.Cantidad))) AS Cantidad,
                         CASE ISNULL(e.WMSAndenSurtidoContacto,0) WHEN 1 THEN ISNULL(NULLIF(c.DefPosicionSurtido,''),ISNULL(v.PosicionWMS, a.DefPosicionSurtido)) ELSE ISNULL(v.PosicionWMS, a.DefPosicionSurtido) END as Posicion, 
                         vd.Articulo, 
                         vd.SubCuenta, 
                         vd.Almacen, 
                         vd.Unidad, 
                         vd.Cantidad CantidadUnidad, 
                         CASE g.NivelFactorMultiUnidad WHEN 'Unidad' THEN ISNULL( u.Factor, 1) ELSE ISNULL( au.Factor, 1) END Factor,
                         vd.RenglonID, 
                         slm.SerieLote, 
                         ISNULL(slm.Tarima,@Tarima) Tarima
                    FROM Compra v  
                    JOIN CompraD vd ON v.ID = vd.ID
               LEFT JOIN SerieLoteMov slm ON vd.ID = slm.ID AND vd.RenglonID = slm.RenglonID AND vd.Articulo = slm.Articulo AND ISNULL(vd.SubCuenta,'') = ISNULL(slm.SubCuenta,ISNULL(vd.SubCuenta,'')) AND slm.Modulo = @Modulo AND v.Empresa = slm.Empresa
                    JOIN Prov c ON v.Proveedor = c.Proveedor  
                    JOIN Alm a ON vd.Almacen = a.Almacen  
                    JOIN EmpresaCfg e ON e.Empresa = @Empresa
               LEFT JOIN WMSModuloTarima w ON w.IDModulo = v.ID AND w.Modulo = 'COMS' AND w.IDTMA IS NOT NULL AND Utilizar = 1
               LEFT JOIN TMA t ON t.ID = w.IDTMA AND t.Estatus <> 'CANCELADO'                    
	           LEFT JOIN EmpresaCfg2 g ON v.Empresa = g.Empresa
               LEFT JOIN Unidad u ON vd.Unidad = u.Unidad
	           LEFT JOIN ArtUnidad au ON vd.Articulo = au.Articulo AND vd.Unidad = au.Unidad
                   WHERE v.ID = @Id
                     AND vd.Articulo = @Articulo
					 AND vd.Renglon  = @Renglon
					 AND vd.RenglonID = @RenglonID
					 AND ISNULL(slm.Tarima,@Tarima) = ISNULL(@Tarima,'')
					 AND ISNULL(slm.SerieLote,'') = ISNULL(@SerieLote,'')
                     AND v.Estatus = (SELECT Estatus FROM WMSModuloMovimiento WHERE Modulo = 'COMS' AND Movimiento = v.Mov)
                     AND NULLIF(vd.Tarima,'') IS NULL
                   GROUP BY v.Mov, v.ID, CASE ISNULL(e.WMSAndenSurtidoContacto,0) WHEN 1 THEN ISNULL(NULLIF(c.DefPosicionSurtido,''),ISNULL(v.PosicionWMS, a.DefPosicionSurtido)) ELSE ISNULL(v.PosicionWMS, a.DefPosicionSurtido) END, vd.Articulo, vd.Almacen, e.WMSAndenSurtidoContacto, c.DefPosicionSurtido, g.NivelFactorMultiUnidad, ISNULL( u.Factor, 1), ISNULL( au.Factor, 1), vd.Unidad, vd.Cantidad, ISNULL( u.Factor, 1), vd.SubCuenta, vd.RenglonID, slm.SerieLote, slm.Tarima
              ) AS x  
              GROUP BY Modulo, Mov, ID, Posicion, Articulo, Almacen, Unidad, CantidadUnidad, Factor, SubCuenta, RenglonID, SerieLote, Tarima
              ORDER BY Posicion, Tarima, Articulo, Almacen, Unidad, CantidadUnidad, Factor, SubCuenta 
      END 
      ELSE
        IF @Modulo = 'INV' 
        BEGIN
            SELECT Modulo, 
                   Mov, 
                   ID, 
                   SUM(Cantidad), 
                   Posicion, 
                   Articulo, 
                   SubCuenta, 
                   Almacen, 
                   Unidad, 
                   CantidadUnidad, 
                   Factor,                    
                   RenglonID, 
                   SerieLote, 
                   Tarima
              FROM
              (
                    SELECT 'INV' Modulo, 
                            v.Mov, 
                            v.ID, 
                            SUM(ISNULL(slm.Cantidad, ISNULL(vd.CantidadInventario,vd.Cantidad))) AS Cantidad,            
                            ISNULL(v.PosicionWMS, a.DefPosicionSurtido) as Posicion, 
                            vd.Articulo, 
                            vd.SubCuenta, 
                            vd.Almacen, 
                            vd.Unidad, 
                            vd.Cantidad CantidadUnidad, 
                            CASE g.NivelFactorMultiUnidad WHEN 'Unidad' THEN ISNULL( u.Factor, 1) ELSE ISNULL( au.Factor, 1) END Factor, 
                            vd.RenglonID, slm.SerieLote, ISNULL(slm.Tarima,@Tarima) Tarima
                       FROM Inv v  
                       JOIN InvD vd ON v.ID = vd.ID  
                  LEFT JOIN SerieLoteMov slm ON vd.ID = slm.ID 
                        AND vd.RenglonID = slm.RenglonID 
                        AND vd.Articulo = slm.Articulo 
                        AND ISNULL(vd.SubCuenta,'') = ISNULL(slm.SubCuenta,ISNULL(vd.SubCuenta,'')) 
                        AND slm.Modulo = @Modulo 
                        AND v.Empresa = slm.Empresa
                       JOIN Alm a ON vd.Almacen = a.Almacen
                       JOIN EmpresaCfg e ON e.Empresa = @Empresa
                  LEFT JOIN WMSModuloTarima w ON w.IDModulo = v.ID AND w.Modulo = @Modulo AND w.IDTMA IS NOT NULL AND Utilizar = 1
                  LEFT JOIN TMA t ON t.ID = w.IDTMA AND t.Estatus <> 'CANCELADO'
	              LEFT JOIN EmpresaCfg2 g ON v.Empresa = g.Empresa
                  LEFT JOIN Unidad u ON vd.Unidad = u.Unidad
	              LEFT JOIN ArtUnidad au ON vd.Articulo = au.Articulo AND vd.Unidad = au.Unidad
                      WHERE v.ID = @Id
                        AND vd.Articulo = @Articulo
						AND vd.Renglon  = @Renglon
						AND vd.RenglonID = @RenglonID
						AND ISNULL(slm.Tarima,@Tarima) = ISNULL(@Tarima,'')
						AND ISNULL(slm.SerieLote,'') = ISNULL(@SerieLote,'')
                        AND v.Estatus = (SELECT Estatus FROM WMSModuloMovimiento WHERE Modulo = @Modulo AND Movimiento = v.Mov)
                        AND NULLIF(vd.Tarima,'') IS NULL
                        AND ISNULL(vd.CantidadPendiente,'') > 0 
                      GROUP BY v.Mov, v.ID, ISNULL(v.PosicionWMS, a.DefPosicionSurtido), vd.Articulo, vd.Almacen, g.NivelFactorMultiUnidad, ISNULL( u.Factor, 1), ISNULL( au.Factor, 1), vd.Unidad, vd.Cantidad, ISNULL( u.Factor, 1), vd.SubCuenta, vd.RenglonID, slm.SerieLote, slm.Tarima
              ) AS x
              GROUP BY Modulo, Mov, ID, Posicion, Articulo, SubCuenta, Almacen, Unidad, CantidadUnidad, Factor, RenglonID, SerieLote, Tarima 
              ORDER BY Posicion, Tarima, Articulo, SubCuenta, Almacen, Unidad, CantidadUnidad, Factor
      END
END
GO

--REQ12615 WMS
--TASK24685
/***************************************     spPreparaSurtido      *************************************************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'spPreparaSurtido' AND type = 'P') DROP PROCEDURE spPreparaSurtido
GO
CREATE PROCEDURE [dbo].[spPreparaSurtido]
    @Estacion       int,
    @Empresa        char(5),
    @EnSilencio     bit = 0
--//WITH ENCRYPTION
AS  
BEGIN
SET NOCOUNT ON       
DECLARE @Modulo				    varchar(5),												
        @ID					    int,													
        @Articulo			    varchar(20),
        @Almacen			    varchar(10),
        @Cantidad		        float,
        @Tarima				    varchar(20),
        @FechaCaducidad			datetime,
        @Disponible			    float,
        @Posicion			    varchar(10),
        @PosicionTipo           varchar(20),
        @Zona				    varchar(50),        
	    @Ok					    int,
	    @OkRef				    varchar(255),
	    @Desde				    int,
	    @Hasta				    int,	    
	    @ControlArticulo	    varchar(20),
	    @Referencia			    varchar(50),
	    @Unidad				    varchar(50), 
	    @CantidadUnidad		    float, 
	    @Factor				    float, 
        @SucursalDestino	    int,
        @IDAux				    int,  	    
        @CantidadFaltante	    float,
        @Renglon				float,
        @RenglonID              int,
        @SerieLote              varchar(50),                
        @SubCuenta              varchar(50),         
		@ArtSerieLoteInfo       bit,		
        @MovTipo                varchar(20),
        @Sucursal               int,				
		@WMSPCKUbicacion        int, 
        @TipoArt                varchar(20),        		
        @Tipo                   varchar(20),
		@IDPrepDatosSur			int,
        @MovID	                varchar(20),
        @Mov                    varchar(20)
		

		CREATE TABLE #CualesID (ID int NULL)

		CREATE TABLE #Anden (Anden int NULL)  

		DECLARE @Asignado AS TABLE(Empresa		varchar(20) NULL,
								   Articulo		varchar(20) NULL,
								   Subcuenta	varchar(50) NULL,
								   Almacen		varchar(10) NULL,
								   Sucursal		int NULL,
								   SerieLote	varchar(50) NULL,
								   Tarima		varchar(20) NULL,
								   Asignado		float NULL)
                                   
		DECLARE @PreparaDatosSurtir AS TABLE(
								 ID					int identity(1,1) NOT NULL,
                                 Modulo             varchar(5)   NULL, 
								 Mov                varchar(20)  NULL,
								 Moduloid           int          NULL,
								 Cantidad			float	     NULL,  
								 Pocicion			varchar(10)  NULL,  
								 Articulo			varchar(20)  NULL,
								 SubCuenta          varchar(20)  NULL,
                                 Almacen			varchar(10)  NULL,
								 Unidad				varchar(50)  NULL,
								 CantidadUnidad		float	     NULL,
                                 Factor				float	     NULL,
                                 RenglonID          int          NULL, 
								 SerieLote          varchar(50)  NULL,
                                 Tarima				varchar(20)  NULL
								 ) 									 

	SELECT @WMSPCKUbicacion = ISNULL(WMSPCKUbicacion, 0) FROM EmpresaCfg WHERE Empresa = @Empresa
	SELECT @Ok = NULL  
	DELETE WMSLista WHERE Estacion = @Estacion  
	DELETE WMSSurtidoProcesarD WHERE Estacion = @Estacion AND Procesado = 0
	DELETE WMSSurtidoPendiente WHERE Estacion = @Estacion  
	SELECT TOP 1 @Desde = ID FROM WMSModuloTarima ORDER BY ID DESC

	DECLARE crInicial CURSOR LOCAL STATIC FOR
		SELECT Modulo, ID 
		  FROM ListaModuloID 
		 WHERE Estacion = @Estacion 
	  ORDER BY Modulo, ID
	
	OPEN crInicial
	FETCH NEXT FROM crInicial INTO @Modulo, @ID 
	
	WHILE @@FETCH_STATUS = 0
		BEGIN
			DELETE WMSModuloTarima WHERE Modulo = @Modulo AND IDModulo = @ID
			/*************************     VENTAS     *****************************/
			IF @Modulo = 'VTAS'
				INSERT WMSModuloTarima (IDModulo, Modulo,  Renglon,    RenglonSub,
										Cantidad, PosicionDestino, Articulo, Almacen,Utilizar, AlmacenDestino, Unidad, 
										CantidadUnidad, SubCuenta)
								 SELECT v.ID,     @Modulo, vd.Renglon, vd.RenglonSub,  
										CASE g.NivelFactorMultiUnidad WHEN 'Unidad' 
																	 THEN CASE WHEN (ISNULL( u.Factor, 1) * ISNULL(vd.CantidadPendiente,0)) - SUM(ISNULL(w.Cantidad,0)) <0  
																			   THEN (ISNULL( u.Factor, 1) * ISNULL(vd.CantidadPendiente,0)) - SUM(ISNULL(w.Cantidad,0)) + SUM(ISNULL(w.Cantidad,0)) 
																			   WHEN (ISNULL( u.Factor, 1) * ISNULL(vd.CantidadPendiente,0)) - SUM(ISNULL(w.Cantidad,0)) = 0 
																			   THEN ISNULL(vd.Cantidad,0)
																			   ELSE (ISNULL( u.Factor, 1) * ISNULL(vd.CantidadPendiente,0)) - SUM(ISNULL(w.Cantidad,0)) 
																		   END 
																	 ELSE CASE WHEN (ISNULL( au.Factor, 1) * ISNULL(vd.CantidadPendiente,0)) - SUM(ISNULL(w.Cantidad,0)) < 0  
																			   THEN (ISNULL( au.Factor, 1) * ISNULL(vd.CantidadPendiente,0)) - SUM(ISNULL(w.Cantidad,0)) + SUM(ISNULL(w.Cantidad,0)) 
																			   WHEN (ISNULL( au.Factor, 1) * ISNULL(vd.CantidadPendiente,0)) - SUM(ISNULL(w.Cantidad,0)) = 0 
																			   THEN (ISNULL( au.Factor, 1) * ISNULL(vd.Cantidad,0)) 
																			   ELSE (ISNULL( au.Factor, 1) * ISNULL(vd.CantidadPendiente,0)) - SUM(ISNULL(w.Cantidad,0)) 
																		   END 
																	 END, 
										ISNULL(v.PosicionWMS, a.DefPosicionSurtido), vd.Articulo, vd.Almacen, 1, vd.Almacen, vd.Unidad, 
										vd.Cantidad,
										vd.SubCuenta
								   FROM Venta v  
								   JOIN VentaD vd ON v.ID = vd.ID  
								   JOIN Cte c ON v.Cliente = c.Cliente  
							  LEFT JOIN CteEnviarA ca ON c.Cliente = ca.Cliente AND vd.EnviarA = ca.ID  
								   JOIN Alm a ON vd.Almacen = a.Almacen
					    LEFT OUTER JOIN WMSModuloTarima w ON w.IDModulo = v.ID AND w.Modulo = @Modulo AND w.IDTMA IS NOT NULL AND Utilizar = 1
					    LEFT OUTER JOIN TMA t ON t.ID = w.IDTMA AND t.Estatus <> 'CANCELADO'
					    LEFT OUTER JOIN EmpresaCfg2 g ON v.Empresa = g.Empresa
					    LEFT OUTER JOIN Unidad u ON vd.Unidad = u.Unidad
					    LEFT OUTER JOIN ArtUnidad au ON vd.Articulo = au.Articulo AND vd.Unidad = au.Unidad
								  WHERE v.ID = @ID
								    AND v.Mov IN(SELECT Movimiento FROM WMSModuloMovimiento WHERE Modulo = @Modulo)
								    AND v.Estatus = (SELECT Estatus FROM WMSModuloMovimiento WHERE Modulo = @Modulo AND Movimiento = v.Mov)
								    AND NULLIF(vd.Tarima,'') IS NULL
								    AND Isnull(vd.CantidadPendiente, '') > 0
							   GROUP BY v.ID, vd.Renglon, vd.RenglonSub, 
									    ISNULL(vd.CantidadPendiente,0), 
									    ISNULL(v.PosicionWMS, a.DefPosicionSurtido),
									    vd.Articulo, vd.Almacen, vd.Cantidad, g.NivelFactorMultiUnidad, 
									    ISNULL( u.Factor, 1), ISNULL( au.Factor, 1), vd.Unidad, vd.SubCuenta

			-----------------------------------------------------------------------
			/*************************     COMPRAS     *****************************/
			IF @Modulo = 'COMS'  
				INSERT WMSModuloTarima (IDModulo, Modulo,  Renglon,    RenglonSub,    Cantidad,
										PosicionDestino, Articulo, Almacen, Utilizar, AlmacenDestino, 
										Unidad, CantidadUnidad, SubCuenta)
								 SELECT v.ID,     @Modulo, vd.Renglon, vd.RenglonSub, 
										CASE g.NivelFactorMultiUnidad WHEN 'Unidad' 
																	  THEN CASE WHEN (ISNULL( u.Factor, 1) * ISNULL(vd.Cantidad, 0)) - SUM(ISNULL(w.Cantidad,0)) < 0 
																				THEN (ISNULL( u.Factor, 1) * ISNULL(vd.Cantidad, 0)) - SUM(ISNULL(w.Cantidad,0)) + SUM(ISNULL(w.Cantidad,0)) 
																				ELSE (ISNULL( u.Factor, 1) * ISNULL(vd.Cantidad, 0)) - SUM(ISNULL(w.Cantidad,0)) 
																			END 
																	  ELSE 
																	  CASE WHEN (ISNULL( au.Factor, 1) * ISNULL(vd.Cantidad, 0)) - SUM(ISNULL(w.Cantidad,0)) < 0 
																		   THEN (ISNULL( au.Factor, 1) * ISNULL(vd.Cantidad, 0)) - SUM(ISNULL(w.Cantidad,0)) + SUM(ISNULL(w.Cantidad,0)) 
																		   ELSE (ISNULL( au.Factor, 1) * ISNULL(vd.Cantidad, 0)) - SUM(ISNULL(w.Cantidad,0)) 
																	  END 
										END, 
										ISNULL(ISNULL(c.DefPosicionSurtido, v.PosicionWMS), a.DefPosicionSurtido), 
										vd.Articulo, vd.Almacen, 1, vd.Almacen, vd.Unidad, vd.Cantidad, vd.SubCuenta
								   FROM Compra v
								   JOIN CompraD vd ON v.ID = vd.ID
								   JOIN Prov c ON v.Proveedor = c.Proveedor
								   JOIN Alm a ON vd.Almacen = a.Almacen
						LEFT OUTER JOIN WMSModuloTarima w ON w.IDModulo = v.ID AND w.Modulo = @Modulo AND w.IDTMA IS NOT NULL AND Utilizar = 1
						LEFT OUTER JOIN TMA t ON t.ID = w.IDTMA AND t.Estatus <> 'CANCELADO'                
						LEFT OUTER JOIN EmpresaCfg2 g ON v.Empresa = g.Empresa
						LEFT OUTER JOIN Unidad u ON vd.Unidad = u.Unidad
						LEFT OUTER JOIN ArtUnidad au ON vd.Articulo = au.Articulo AND vd.Unidad = au.Unidad
								  WHERE v.ID = @ID
									AND v.Mov IN(SELECT Movimiento FROM WMSModuloMovimiento WHERE Modulo = @Modulo)
									AND v.Estatus = (SELECT Estatus FROM WMSModuloMovimiento WHERE Modulo = @Modulo AND Movimiento = v.Mov)
									AND NULLIF(vd.Tarima,'') IS NULL
							   GROUP BY v.ID, vd.Renglon, vd.RenglonSub, ISNULL(vd.Cantidad, 0), ISNULL(ISNULL(c.DefPosicionSurtido, v.PosicionWMS), a.DefPosicionSurtido), vd.Articulo, vd.Almacen, g.NivelFactorMultiUnidad, ISNULL( u.Factor, 1), ISNULL( au.Factor, 1), vd.Cantidad, vd.Unidad, vd.SubCuenta
			-----------------------------------------------------------------------
			/*************************     INVENTARIOS     *****************************/    			
			IF @Modulo = 'INV'
				INSERT WMSModuloTarima (IDModulo, Modulo,  Renglon,    RenglonSub,    Cantidad,
										PosicionDestino, Articulo, Almacen, Utilizar, AlmacenDestino, Unidad, CantidadUnidad, SubCuenta)
								 SELECT v.ID,     @Modulo, vd.Renglon, vd.RenglonSub,
										CASE g.NivelFactorMultiUnidad WHEN 'Unidad' 
																	  THEN CASE WHEN (ISNULL( u.Factor, 1) * ISNULL(vd.CantidadPendiente,0)) - SUM(ISNULL(w.Cantidad,0)) <0  
																				THEN (ISNULL( u.Factor, 1) * ISNULL(vd.CantidadPendiente,0)) - SUM(ISNULL(w.Cantidad,0)) + SUM(ISNULL(w.Cantidad,0)) 
																				WHEN (ISNULL( u.Factor, 1) * ISNULL(vd.CantidadPendiente,0)) - SUM(ISNULL(w.Cantidad,0)) = 0 
																				THEN ISNULL(vd.Cantidad,0) 
																				ELSE (ISNULL( u.Factor, 1) * ISNULL(vd.CantidadPendiente,0)) - SUM(ISNULL(w.Cantidad,0)) 
																			END 
																	   ELSE 
																	   CASE WHEN (ISNULL( au.Factor, 1) * ISNULL(vd.CantidadPendiente,0)) - SUM(ISNULL(w.Cantidad,0)) < 0  
																			THEN (ISNULL( au.Factor, 1) * ISNULL(vd.CantidadPendiente,0)) - SUM(ISNULL(w.Cantidad,0)) + SUM(ISNULL(w.Cantidad,0))
																			WHEN (ISNULL( au.Factor, 1) * ISNULL(vd.CantidadPendiente,0)) - SUM(ISNULL(w.Cantidad,0)) = 0 
																			THEN (ISNULL( au.Factor, 1) * ISNULL(vd.Cantidad,0)) 
																			ELSE (ISNULL( au.Factor, 1) * ISNULL(vd.CantidadPendiente,0)) - SUM(ISNULL(w.Cantidad,0)) 
																	   END 
										END, 
										ISNULL(v.PosicionWMS, a.DefPosicionSurtido), vd.Articulo, vd.Almacen, 1, v.AlmacenDestino, vd.Unidad, 
										vd.Cantidad, vd.SubCuenta
								   FROM Inv v
								   JOIN InvD vd ON v.ID = vd.ID
								   JOIN Alm a ON vd.Almacen = a.Almacen
						LEFT OUTER JOIN WMSModuloTarima w ON w.IDModulo = v.ID AND w.Modulo = @Modulo AND w.IDTMA IS NOT NULL AND Utilizar = 1
						LEFT OUTER JOIN TMA t ON t.ID = w.IDTMA AND t.Estatus <> 'CANCELADO'
						LEFT OUTER JOIN EmpresaCfg2 g ON v.Empresa = g.Empresa
						LEFT OUTER JOIN Unidad u ON vd.Unidad = u.Unidad
						LEFT OUTER JOIN ArtUnidad au ON vd.Articulo = au.Articulo AND vd.Unidad = au.Unidad
								  WHERE v.ID = @ID
									AND v.Mov IN(SELECT Movimiento FROM WMSModuloMovimiento WHERE Modulo = @Modulo)
									AND v.Estatus = (SELECT Estatus FROM WMSModuloMovimiento WHERE Modulo = @Modulo AND Movimiento = v.Mov)
									AND NULLIF(vd.Tarima,'') IS NULL
									AND Isnull(vd.CantidadPendiente, '') > 0
									AND ISNULL(v.OrigenTipo,'') <> 'EXTVT'
							   GROUP BY v.ID, vd.Renglon, vd.RenglonSub, ISNULL(vd.CantidadPendiente,0) , ISNULL(v.PosicionWMS, a.DefPosicionSurtido), vd.Articulo, vd.Almacen, vd.Cantidad, g.NivelFactorMultiUnidad, ISNULL( u.Factor, 1), ISNULL( au.Factor, 1), v.AlmacenDestino, vd.Unidad, vd.SubCuenta 
			    			
			INSERT #CualesID VALUES (@@IDENTITY)
			
			DELETE WMSModuloTarima 
			 WHERE ID IN((SELECT s.ID 
							FROM WMSModuloTarima w
							JOIN WMSModuloTarima s 
							  ON w.IDModulo = s.IDModulo
							 AND w.Modulo = s.Modulo
							 AND w.Articulo = s.Articulo
							 AND w.Renglon = s.Renglon
							 AND s.TarimaSurtido = NULL
							 AND s.IDTMA = NULL
							 AND w.RenglonSub = s.RenglonSub
						   WHERE w.ID IN (SELECT ID FROM #CualesID) 
						     AND s.ID NOT IN (SELECT ID FROM #CualesID)))
			
			/*************************     VENTAS     *****************************/			
			IF @Modulo = 'VTAS'                
				INSERT WMSLista  (Estacion, Modulo, IDModulo, Articulo, Cantidad, Unidad, CantidadUnidad, SubCuenta) 
						   SELECT @Estacion, @Modulo, @ID, vd.Articulo, CASE g.NivelFactorMultiUnidad WHEN 'Unidad' THEN ISNULL( u.Factor, 1) * vd.CantidadPendiente ELSE ISNULL( au.Factor, 1) * vd.CantidadPendiente END, vd.unidad, vd.Cantidad, vd.SubCuenta 
							 FROM VentaD vd
							 JOIN Venta v 
							   ON vd.ID = v.ID
				  LEFT OUTER JOIN EmpresaCfg2 g
							   ON v.Empresa = g.Empresa
				  LEFT OUTER JOIN Unidad u
							   ON vd.Unidad = u.Unidad
				  LEFT OUTER JOIN ArtUnidad au
							   ON vd.Articulo = au.Articulo AND vd.Unidad = au.Unidad
							WHERE vd.ID = @ID
							  AND NULLIF(vd.Tarima,'') IS NULL
							  AND Isnull(vd.CantidadPendiente, '') > 0
			-------------------------------------------------------------------------							  
			/*************************     COMPRAS     *****************************/
			IF @Modulo = 'COMS'           
				INSERT WMSLista(Estacion, Modulo, IDModulo, Articulo, Cantidad, Unidad, CantidadUnidad, SubCuenta) 
						 SELECT @Estacion, @Modulo, @ID, vd.Articulo, CASE g.NivelFactorMultiUnidad WHEN 'Unidad' THEN ISNULL( u.Factor, 1) * ISNULL(vd.CantidadPendiente, vd.Cantidad) ELSE ISNULL( au.Factor, 1) * ISNULL(vd.CantidadPendiente, vd.Cantidad) END, vd.unidad, vd.Cantidad, vd.SubCuenta 
						   FROM CompraD vd
						   JOIN Compra v
						     ON vd.ID = v.ID
				LEFT OUTER JOIN EmpresaCfg2 g
							 ON v.Empresa = g.Empresa
				LEFT OUTER JOIN Unidad u 
							 ON vd.Unidad = u.Unidad
				LEFT OUTER JOIN ArtUnidad au
							 ON vd.Articulo = au.Articulo AND vd.Unidad = au.Unidad
						  WHERE vd.ID = @ID
							AND NULLIF(vd.Tarima,'') IS NULL

			-----------------------------------------------------------------------------
			/*************************     INVENTARIOS     *****************************/
			IF @Modulo = 'INV'           
				INSERT WMSLista(Estacion, Modulo, IDModulo, Articulo, Cantidad, Unidad, CantidadUnidad, SubCuenta) 
						 SELECT @Estacion, @Modulo, @ID, vd.Articulo, CASE g.NivelFactorMultiUnidad WHEN 'Unidad' THEN ISNULL( u.Factor, 1) * vd.CantidadPendiente ELSE ISNULL( au.Factor, 1) * vd.CantidadPendiente END, vd.unidad, vd.Cantidad, vd.SubCuenta
						   FROM InvD  vd
						   JOIN INV v ON vd.ID = v.ID
				LEFT OUTER JOIN EmpresaCfg2 g ON v.Empresa = g.Empresa
				LEFT OUTER JOIN Unidad u ON vd.Unidad = u.Unidad
				LEFT OUTER JOIN ArtUnidad au ON vd.Articulo = au.Articulo AND vd.Unidad = au.Unidad
						  WHERE vd.ID = @ID
							AND NULLIF(vd.Tarima,'') IS NULL   
							AND Isnull(vd.CantidadPendiente, '') > 0  	
							AND ISNULL(v.OrigenTipo,'') <> 'EXTVT'
			
			FETCH NEXT FROM crInicial INTO @Modulo, @ID 
		END
		
	CLOSE crInicial
	DEALLOCATE crInicial

	SELECT TOP 1 @Hasta = ID 
	  FROM #CualesID 
  ORDER BY ID DESC
  
	TRUNCATE TABLE #CualesID
	SELECT @Desde = @Desde + 1
	
	 WHILE @Desde <= @Hasta
	 BEGIN
		INSERT #CualesID SELECT @Desde
		SELECT @Desde = @Desde + 1
	   END		  
	 
	INSERT #Anden SELECT COUNT(DISTINCT PosicionDestino) FROM WMSModuloTarima WHERE ID IN(SELECT ID FROM #CualesID) GROUP BY PosicionDestino

	----------------------------------------------------------------------------------------------------------------------------------------
	IF @Modulo IS NULL
		BEGIN
			IF @EnSilencio = 0 
				SELECT 'Favor de Seleccionar un Movimiento'
			RETURN
		END
	----------------------------------------------------------------------------------------------------------------------------------------	
	DECLARE crSugerir CURSOR LOCAL STATIC FOR 
		SELECT Modulo, IDModulo
		  FROM WMSLista 
		 WHERE Estacion = @Estacion 
	  GROUP BY Modulo, IDModulo
	  ORDER BY Modulo,IDModulo
  
	OPEN crSugerir
	FETCH NEXT FROM crSugerir INTO @Modulo, @IDAux
	WHILE @@FETCH_STATUS = 0
		BEGIN	
	--------------------------------------------------------------------------------------------------------------------------------------------------		
			IF @Modulo = 'VTAS' 
			BEGIN
				DELETE SerieLoteMov WHERE Modulo = @Modulo AND ID = @IDAux AND Tarima NOT IN(SELECT Tarima FROM VentaD WHERE ID = @IDAux)
				DECLARE crubicacion CURSOR LOCAL STATIC FOR 
				 SELECT SUM(vd.CantidadPendiente) AS Cantidad,
						vd.Articulo, 
						vd.SubCuenta, 
						vd.Almacen,
						vd.Renglon,
						vd.RenglonID,
						mt.Clave,
						v.Sucursal,
						ar.ControlArticulo,
						ar.Tipo,
                        v.MovID
				   FROM Venta v
				   JOIN MovTipo mt ON v.Mov = mt.Mov AND mt.Modulo = @Modulo
				   JOIN VentaD vd ON v.ID = vd.ID
				   JOIN Art ar ON vd.Articulo = ar.Articulo
			  LEFT JOIN SerieLoteMov slm ON vd.ID = slm.ID
					AND vd.RenglonID = slm.RenglonID
					AND vd.Articulo = slm.Articulo
					AND ISNULL(vd.SubCuenta,'') = ISNULL(slm.SubCuenta,ISNULL(vd.SubCuenta,''))
					AND slm.Modulo = @Modulo AND v.Empresa = slm.Empresa
			  LEFT JOIN WMSModuloTarima w ON w.IDModulo = v.ID
					AND w.Modulo = @Modulo
					AND w.IDTMA IS NOT NULL
					AND Utilizar = 1
				  WHERE v.ID = @IDAux
					AND NULLIF(vd.Tarima,'') IS NULL
					AND Isnull(vd.CantidadPendiente, '') > 0 
					AND slm.SerieLote IS NULL					
			   GROUP BY v.ID, vd.Articulo, vd.SubCuenta, vd.Almacen, vd.Renglon, vd.RenglonID,
						mt.Clave, mt.Clave, v.Sucursal, w.Tarima, ar.ControlArticulo, ar.Tipo, v.MovID
			END 
		ELSE
			IF @Modulo = 'COMS' 
			BEGIN
				DELETE SerieLoteMov WHERE Modulo = @Modulo AND ID = @IDAux AND Tarima NOT IN(SELECT Tarima FROM CompraD WHERE ID = @IDAux)
				DECLARE crubicacion CURSOR local static FOR 
				SELECT SUM(vd.CantidadPendiente) AS Cantidad,
					   vd.Articulo,
					   vd.SubCuenta,
					   vd.Almacen,
					   vd.Renglon,
					   vd.RenglonID,
					   mt.Clave,
					   v.Sucursal,
					   ar.ControlArticulo,
					   ar.Tipo,
                       v.MovID
				  FROM Compra v
				  JOIN MovTipo mt ON v.Mov = mt.Mov AND mt.Modulo = @Modulo
				  JOIN CompraD vd ON v.ID = vd.ID  
				  JOIN Art ar ON vd.Articulo = ar.Articulo
			 LEFT JOIN SerieLoteMov slm ON vd.ID = slm.ID AND vd.RenglonID = slm.RenglonID AND vd.Articulo = slm.Articulo AND ISNULL(vd.SubCuenta,'') = ISNULL(slm.SubCuenta,ISNULL(vd.SubCuenta,'')) AND slm.Modulo = @Modulo AND v.Empresa = slm.Empresa
			 LEFT JOIN WMSModuloTarima w ON w.IDModulo = v.ID AND w.Modulo = @Modulo AND w.IDTMA IS NOT NULL AND Utilizar = 1
				 WHERE v.ID = @IDAux
				   AND NULLIF(vd.Tarima,'') IS NULL
				   AND Isnull(vd.CantidadPendiente, '') > 0 
				   AND slm.SerieLote IS NULL				   
			  GROUP BY v.ID, vd.Articulo, vd.SubCuenta, vd.Almacen, vd.Renglon, vd.RenglonID,
					   mt.Clave, mt.Clave, v.Sucursal, w.Tarima, ar.ControlArticulo, ar.Tipo, v.MovID
			END
		ELSE
			IF @Modulo = 'INV' 
			BEGIN
				DELETE SerieLoteMov WHERE Modulo = @Modulo AND ID = @IDAux AND Tarima NOT IN(SELECT Tarima FROM InvD WHERE ID = @IDAux)
				DECLARE crUbicacion CURSOR LOCAL STATIC FOR          
				 SELECT SUM(vd.CantidadPendiente) AS Cantidad,
						vd.Articulo,
						vd.SubCuenta,
						vd.Almacen,
						vd.Renglon,
						vd.RenglonID,
						mt.Clave,
						v.Sucursal,
						ar.ControlArticulo,
						ar.Tipo,
                        v.MovID
				   FROM Inv v
				   JOIN MovTipo mt ON v.Mov = mt.Mov AND mt.Modulo = @Modulo
				   JOIN InvD vd ON v.ID = vd.ID
				   JOIN Art ar ON vd.Articulo = ar.Articulo
			  LEFT JOIN SerieLoteMov slm ON vd.ID = slm.ID AND vd.RenglonID = slm.RenglonID AND vd.Articulo = slm.Articulo AND ISNULL(vd.SubCuenta,'') = ISNULL(slm.SubCuenta,ISNULL(vd.SubCuenta,'')) AND slm.Modulo = @Modulo AND v.Empresa = slm.Empresa
			  LEFT JOIN WMSModuloTarima w ON w.IDModulo = v.ID AND w.Modulo = @Modulo AND w.IDTMA IS NOT NULL AND Utilizar = 1
				  WHERE v.ID = @IDAux
					AND NULLIF(vd.Tarima,'') IS NULL
					AND Isnull(vd.CantidadPendiente, '') > 0 
					AND slm.SerieLote IS NULL
					AND ISNULL(v.OrigenTipo,'') <> 'EXTVT'				
			   GROUP BY v.ID, vd.Articulo, vd.SubCuenta, vd.Almacen, vd.Renglon, vd.RenglonID,
						mt.Clave, mt.Clave, v.Sucursal, w.Tarima, ar.ControlArticulo, ar.Tipo, v.MovID
			END	
	-------------------------------------------------------------------------------------------------------------------------------------------------	
			OPEN crUbicacion
			FETCH NEXT FROM crUbicacion INTO @Cantidad, @Articulo, @SubCuenta, @Almacen, @Renglon, @RenglonID, @MovTipo, @Sucursal, @ControlArticulo, @Tipo, @MovID
			
			WHILE @@FETCH_STATUS = 0
				BEGIN
	------------------------------------------------          ARTÍCULOS ( SERIE/LOTE - NORMALES)          -------------------------------------------
					SET @CantidadFaltante = @Cantidad
					DECLARE crSerieLoteU CURSOR LOCAL STATIC FOR
						SELECT t.Tarima,
							   '',
							   ISNULL(adt.Disponible,0) - ISNULL(adt.Apartado,0) - ISNULL(asg.Asignado,0) AS Disponible,
							   ap.Posicion,
							   ap.Tipo,
							   t.FechaCaducidad
						  FROM ArtDisponibleTarima adt
						  JOIN Tarima t ON adt.Almacen = t.Almacen AND adt.Tarima = t.Tarima AND t.tarima NOT LIKE '%CC%'
						  JOIN AlmPos ap ON t.Almacen=ap.Almacen AND t.Posicion=ap.Posicion
					 LEFT JOIN @Asignado asg ON adt.Empresa = asg.Empresa AND adt.Articulo = asg.Articulo AND adt.Almacen = asg.Almacen AND adt.Tarima = asg.Tarima 
					 	 WHERE adt.Empresa = @Empresa
						   AND adt.Articulo = @Articulo
						   AND adt.Almacen = @Almacen                                          
						   AND ISNULL(adt.Disponible,0) - ISNULL(adt.Apartado,0) - ISNULL(asg.Asignado,0) > 0
						   AND t.Estatus = 'ALTA'
                           AND ap.Tipo <> 'Surtido'
					  ORDER BY  
								CASE @ControlArticulo WHEN 'Fecha Entrada' THEN T.Alta
													 WHEN 'Caducidad'     THEN T.FechaCaducidad
													 WHEN 'Posición'
														THEN CASE WHEN ap.Tipo = 'Cross Docking' THEN 0
																  WHEN ap.Tipo = 'Ubicacion' AND (adt.Disponible - ISNULL(adt.Apartado,0) - ISNULL(asg.Asignado,0)) <= @Cantidad THEN 1
																  WHEN ap.Tipo = 'Domicilio' THEN 2
																  WHEN ap.Tipo = 'Ubicacion' AND (adt.Disponible - ISNULL(adt.Apartado,0) - ISNULL(asg.Asignado,0)) > @Cantidad AND @WMSPCKUbicacion = 1 THEN 3
															 END
								END,
								CASE WHEN ap.Tipo = 'Cross Docking' THEN 0
									 WHEN ap.Tipo = 'Ubicacion' AND (ISNULL(adt.Apartado,0) - ISNULL(asg.Asignado,0)) <= @Cantidad THEN 1
									 WHEN ap.Tipo = 'Domicilio' THEN 2
									 WHEN ap.Tipo = 'Ubicacion' AND (ISNULL(adt.Apartado,0) - ISNULL(asg.Asignado,0)) > @Cantidad THEN 3
								END
				------------------------------------------------------------------------------------------------------------------------------------					
						OPEN crSerieLoteU
						FETCH NEXT FROM crSerieLoteU INTO @Tarima, @SerieLote, @Disponible, @Posicion, @PosicionTipo, @FechaCaducidad
						
                       	WHILE @@FETCH_STATUS = 0 AND @Cantidad > 0
							BEGIN
                                EXEC spTMAArtDomicilioInicializar @Empresa, @Almacen, @Articulo, NULL
                                
                                SELECT @SucursalDestino = Sucursal,
		                               @Referencia = 'Sucursal Destino ' + CONVERT(varchar(max), Sucursal)
                                  FROM Alm 
                                  JOIN WMSModuloTarima ON Alm.Almacen = ISNULL(WMSModuloTarima.AlmacenDestino,WMSModuloTarima.Almacen) 
                                 WHERE WMSModuloTarima.Modulo = @Modulo
                                   AND WMSModuloTarima.IDModulo = @IDAux

                                SELECT @ControlArticulo = ControlArticulo, 
                                       @ArtSerieLoteInfo = SerieLoteInfo, 
                                       @TipoArt = Tipo 
                                  FROM Art 
                                 WHERE Articulo  = @Articulo

                                 SELECT TOP 1 @Zona = Zona FROM ArtZona WHERE Articulo = @Articulo ORDER BY Orden

                                IF @ControlArticulo IS NULL OR @ControlArticulo = ''
									BEGIN
										SELECT @OK = 10036, @OkRef = @Articulo
										
										IF @OK IS NOT NULL
											BREAK
									END
								
								SET @CantidadFaltante = @Cantidad
								
								/********     CROSS DOCKING     ********/
								IF @PosicionTipo = 'Cross Docking' AND @Cantidad > 0
									BEGIN
										IF @Disponible >= @CantidadFaltante AND @Disponible > 0 AND @CantidadFaltante > 0
										BEGIN
											---------------------------------------------------------------------------------------------------------
											IF EXISTS(SELECT * 
														FROM @Asignado 
													   WHERE Empresa = @Empresa 
													     AND Articulo = @Articulo
													     AND ISNULL(Subcuenta,'') = ISNULL(@SubCuenta,'')
													     AND Almacen = @Almacen
													     AND Sucursal = @Sucursal
													     AND ISNULL(SerieLote,'') =  ISNULL(@SerieLote,'')
													     AND Tarima = @Tarima)
												UPDATE @Asignado SET Asignado = ISNULL(Asignado,0) + @Cantidad
												 WHERE Empresa = @Empresa
												   AND Articulo = @Articulo
												   AND ISNULL(Subcuenta,'') = ISNULL(@SubCuenta,'')
												   AND Almacen = @Almacen
												   AND Sucursal = @Sucursal
												   AND ISNULL(SerieLote,'') =  ISNULL(@SerieLote,'')
												   AND Tarima = @Tarima												
											ELSE
												INSERT @Asignado(Empresa, Articulo, Subcuenta, Almacen, Sucursal, SerieLote, Tarima, Asignado)
  														  SELECT @Empresa, @Articulo, ISNULL(@SubCuenta,''), @Almacen, @Sucursal, @SerieLote, @Tarima, @Cantidad
											---------------------------------------------------------------------------------------------------------
											IF @SerieLote <> ''
											BEGIN
												IF EXISTS (SELECT * 
															 FROM SerieLoteMov 
															WHERE ID = @IDAux 
															  AND RenglonID = @RenglonID
															  AND Articulo = @Articulo 
															  AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'') 
															  AND SerieLote = @SerieLote 
															  AND Modulo = @Modulo 
															  AND Empresa = @Empresa 
															  AND Tarima = @Tarima)
													UPDATE SerieLoteMov SET Cantidad = Cantidad + @Cantidad
													 WHERE ID = @IDAux 
													   AND RenglonID = @RenglonID
													   AND Articulo = @Articulo
													   AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'')
													   AND SerieLote = @SerieLote
													   AND Modulo = @Modulo
													   AND Empresa = @Empresa
													   AND Tarima = @Tarima
												 ELSE
													INSERT SerieLoteMov (Empresa,  Sucursal,  Modulo,  ID,  RenglonID,  Articulo,  
																		 SubCuenta,  SerieLote, Cantidad, Tarima)
																 VALUES (@Empresa, @Sucursal, @Modulo, @IDAux, @RenglonID, @Articulo, 
																		 ISNULL(@SubCuenta,''), @SerieLote, @Cantidad, @Tarima)
											END																		    
											---------------------------------------------------------------------------------------------------------
                                            INSERT @PreparaDatosSurtir (Modulo, Mov, Moduloid, Cantidad, Pocicion, Articulo, SubCuenta, Almacen, Unidad, CantidadUnidad, Factor, RenglonID, SerieLote, Tarima) 	
                                              EXEC spPreparaDatosSurtir @Modulo, @IDAux, @Articulo, @Renglon, @RenglonID, @Empresa, @Tarima, @SerieLote
											
											SET @IDPrepDatosSur = @@IDENTITY
											
											INSERT WMSSurtidoProcesarD (Estacion, Modulo, Mov, ModuloID, Procesado, Articulo, Tarima, PosicionDestino, 
																		CantidadTarima, PosicionOrigen, Tipo, Zona, Almacen, Referencia, Unidad, CantidadUnidad, 
																		SucursalFiltro, SubCuenta, TarimaFechaCaducidad, SerieLote, PCKUbicacion, MovID)                                              
														         SELECT @Estacion, Modulo, Mov, Moduloid, 0, Articulo, Tarima, Pocicion, 
																		CASE WHEN ISNULL(SerieLote,'') <> '' THEN Cantidad ELSE @Cantidad END,
																		@Posicion, @PosicionTipo, @Zona, Almacen, @Referencia, Unidad, 
                                                                        CASE WHEN ISNULL(SerieLote,'') <> '' THEN Cantidad ELSE @Cantidad END,
																		0, SubCuenta, @FechaCaducidad, SerieLote, 0, @MovID  
														           FROM @PreparaDatosSurtir
														          WHERE ID = @IDPrepDatosSur
											---------------------------------------------------------------------------------------------------------
											/***     NO CAMBIAR EL ORDEN DE LAS RESTAS     ***/
											SET @CantidadFaltante = @CantidadFaltante - @Cantidad
											SET @Disponible = @Disponible - @Cantidad
											SET @Cantidad = @Cantidad - @Cantidad
											/*************************************************/
  										END
  										
  										IF @Disponible < @Cantidad AND @Disponible > 0 AND @CantidadFaltante > 0
  										BEGIN
  											---------------------------------------------------------------------------------------------------------
											IF EXISTS(SELECT * 
														FROM @Asignado 
													   WHERE Empresa = @Empresa 
													     AND Articulo = @Articulo
													     AND ISNULL(Subcuenta,'') = ISNULL(@SubCuenta,'')
													     AND Almacen = @Almacen
													     AND Sucursal = @Sucursal
													     AND ISNULL(SerieLote,'') =  ISNULL(@SerieLote,'')
													     AND Tarima = @Tarima)
												UPDATE @Asignado SET Asignado = ISNULL(Asignado,0) + @Disponible
												 WHERE Empresa = @Empresa
												   AND Articulo = @Articulo
												   AND ISNULL(Subcuenta,'') = ISNULL(@SubCuenta,'')
												   AND Almacen = @Almacen
												   AND Sucursal = @Sucursal
												   AND ISNULL(SerieLote,'') =  ISNULL(@SerieLote,'')
												   AND Tarima = @Tarima												
											ELSE
												INSERT @Asignado(Empresa, Articulo, Subcuenta, Almacen, Sucursal, SerieLote, Tarima, Asignado)
  														  SELECT @Empresa, @Articulo, ISNULL(@SubCuenta,''), @Almacen, @Sucursal, @SerieLote, @Tarima, @Disponible
											---------------------------------------------------------------------------------------------------------
                                            INSERT @PreparaDatosSurtir (Modulo, Mov, Moduloid, Cantidad, Pocicion, Articulo, SubCuenta, Almacen, Unidad, CantidadUnidad, Factor, RenglonID, SerieLote, Tarima) 	
                                              EXEC spPreparaDatosSurtir @Modulo, @IDAux, @Articulo, @Renglon, @RenglonID, @Empresa, @Tarima, @SerieLote
											
											SET @IDPrepDatosSur = @@IDENTITY
											
											INSERT WMSSurtidoProcesarD (Estacion, Modulo, Mov, ModuloID, Procesado, Articulo, Tarima, PosicionDestino, 
																		CantidadTarima, PosicionOrigen, Tipo, Zona, Almacen, Referencia, Unidad, CantidadUnidad, 
																		SucursalFiltro, SubCuenta, TarimaFechaCaducidad, SerieLote, PCKUbicacion, MovID)                                              
														         SELECT @Estacion, Modulo, Mov, Moduloid, 0, Articulo, Tarima, Pocicion, 
																		CASE WHEN ISNULL(SerieLote,'') <> '' THEN Cantidad ELSE @Disponible END,
																		@Posicion, @PosicionTipo, @Zona, Almacen, @Referencia, Unidad, 
                                                                        CASE WHEN ISNULL(SerieLote,'') <> '' THEN Cantidad ELSE @Disponible END,
																		0, SubCuenta, @FechaCaducidad, SerieLote, 0, @MovID
														           FROM @PreparaDatosSurtir
														          WHERE ID = @IDPrepDatosSur
											---------------------------------------------------------------------------------------------------------
											/***     NO CAMBIAR EL ORDEN DE LAS RESTAS     ***/
											SET @Cantidad = @Cantidad - @Disponible
											SET @CantidadFaltante = @CantidadFaltante - @Disponible
											SET @Disponible = @Disponible - @Disponible
											/*************************************************/
  										END	  
										
									END
							
								/********     UBICACION (Tarima Completa)     ********/
								IF @PosicionTipo = 'Ubicacion' AND @Disponible <= @CantidadFaltante AND @CantidadFaltante > 0
									BEGIN
                                                                                                            
                                        IF @Disponible >= @Cantidad AND @Disponible > 0 AND @CantidadFaltante > 0
										BEGIN
                                            --SELECT @Articulo, @Tarima, @SerieLote, @PosicionTipo
											---------------------------------------------------------------------------------------------------------
											IF EXISTS(SELECT * 
														FROM @Asignado 
													   WHERE Empresa = @Empresa 
													     AND Articulo = @Articulo
													     AND ISNULL(Subcuenta,'') = ISNULL(@SubCuenta,'')
													     AND Almacen = @Almacen
													     AND Sucursal = @Sucursal
													     AND ISNULL(SerieLote,'') =  ISNULL(@SerieLote,'')
													     AND Tarima = @Tarima)
												UPDATE @Asignado SET Asignado = ISNULL(Asignado,0) + @Cantidad
												 WHERE Empresa = @Empresa
												   AND Articulo = @Articulo
												   AND ISNULL(Subcuenta,'') = ISNULL(@SubCuenta,'')
												   AND Almacen = @Almacen
												   AND Sucursal = @Sucursal
												   AND ISNULL(SerieLote,'') =  ISNULL(@SerieLote,'')
												   AND Tarima = @Tarima												
											ELSE
												INSERT @Asignado(Empresa, Articulo, Subcuenta, Almacen, Sucursal, SerieLote, Tarima, Asignado)
  														  SELECT @Empresa, @Articulo, ISNULL(@SubCuenta,''), @Almacen, @Sucursal, @SerieLote, @Tarima, @Cantidad

											---------------------------------------------------------------------------------------------------------
                                            INSERT @PreparaDatosSurtir (Modulo, Mov, Moduloid, Cantidad, Pocicion, Articulo, SubCuenta, Almacen, Unidad, CantidadUnidad, Factor, RenglonID, SerieLote, Tarima) 	
                                              EXEC spPreparaDatosSurtir @Modulo, @IDAux, @Articulo, @Renglon, @RenglonID, @Empresa, @Tarima, @SerieLote
											
											SET @IDPrepDatosSur = @@IDENTITY
											
											INSERT WMSSurtidoProcesarD (Estacion, Modulo, Mov, ModuloID, Procesado, Articulo, Tarima, PosicionDestino, 
																		CantidadTarima, PosicionOrigen, Tipo, Zona, Almacen, Referencia, Unidad, CantidadUnidad, 
																		SucursalFiltro, SubCuenta, TarimaFechaCaducidad, SerieLote, PCKUbicacion, MovID)                                              
														         SELECT @Estacion, Modulo, Mov, Moduloid, 0, Articulo, Tarima, Pocicion, 
																		CASE WHEN ISNULL(SerieLote,'') <> '' THEN Cantidad ELSE @Cantidad END,
																		@Posicion, @PosicionTipo, @Zona, Almacen, @Referencia, Unidad, 
                                                                        CASE WHEN ISNULL(SerieLote,'') <> '' THEN Cantidad ELSE @Cantidad END,
																		0, SubCuenta, @FechaCaducidad, SerieLote, 0, @MovID  
														           FROM @PreparaDatosSurtir
														          WHERE ID = @IDPrepDatosSur
											---------------------------------------------------------------------------------------------------------
											/***     NO CAMBIAR EL ORDEN DE LAS RESTAS     ***/
											SET @CantidadFaltante = @CantidadFaltante - @Cantidad
											SET @Disponible = @Disponible - @Cantidad
											SET @Cantidad = @Cantidad - @Cantidad
											/*************************************************/
  										END
  										
  										IF @Disponible < @Cantidad AND @Disponible > 0 AND @CantidadFaltante > 0
  										BEGIN
  											---------------------------------------------------------------------------------------------------------
											IF EXISTS(SELECT * 
														FROM @Asignado 
													   WHERE Empresa = @Empresa 
													     AND Articulo = @Articulo
													     AND ISNULL(Subcuenta,'') = ISNULL(@SubCuenta,'')
													     AND Almacen = @Almacen
													     AND Sucursal = @Sucursal
													     AND ISNULL(SerieLote,'') =  ISNULL(@SerieLote,'')
													     AND Tarima = @Tarima)
												UPDATE @Asignado SET Asignado = ISNULL(Asignado,0) + @Disponible
												 WHERE Empresa = @Empresa
												   AND Articulo = @Articulo
												   AND ISNULL(Subcuenta,'') = ISNULL(@SubCuenta,'')
												   AND Almacen = @Almacen
												   AND Sucursal = @Sucursal
												   AND ISNULL(SerieLote,'') =  ISNULL(@SerieLote,'')
												   AND Tarima = @Tarima												
											ELSE
												INSERT @Asignado(Empresa, Articulo, Subcuenta, Almacen, Sucursal, SerieLote, Tarima, Asignado)
  														  SELECT @Empresa, @Articulo, ISNULL(@SubCuenta,''), @Almacen, @Sucursal, @SerieLote, @Tarima, @Disponible
                                           
											---------------------------------------------------------------------------------------------------------
                                            INSERT @PreparaDatosSurtir (Modulo, Mov, Moduloid, Cantidad, Pocicion, Articulo, SubCuenta, Almacen, Unidad, CantidadUnidad, Factor, RenglonID, SerieLote, Tarima) 	
                                              EXEC spPreparaDatosSurtir @Modulo, @IDAux, @Articulo, @Renglon, @RenglonID, @Empresa, @Tarima, @SerieLote
											
											SET @IDPrepDatosSur = @@IDENTITY
											
											INSERT WMSSurtidoProcesarD (Estacion, Modulo, Mov, ModuloID, Procesado, Articulo, Tarima, PosicionDestino, 
																		CantidadTarima, PosicionOrigen, Tipo, Zona, Almacen, Referencia, Unidad, CantidadUnidad, 
																		SucursalFiltro, SubCuenta, TarimaFechaCaducidad, SerieLote, PCKUbicacion, MovID)                                              
														         SELECT @Estacion, Modulo, Mov, Moduloid, 0, Articulo, Tarima, Pocicion, 
																		CASE WHEN ISNULL(SerieLote,'') <> '' THEN Cantidad ELSE @Disponible END,
																		@Posicion, @PosicionTipo, @Zona, Almacen, @Referencia, Unidad,
                                                                        CASE WHEN ISNULL(SerieLote,'') <> '' THEN Cantidad ELSE @Disponible END,
																		0, SubCuenta, @FechaCaducidad, SerieLote, 0, @MovID  
														           FROM @PreparaDatosSurtir
														          WHERE ID = @IDPrepDatosSur
											---------------------------------------------------------------------------------------------------------
											/***     NO CAMBIAR EL ORDEN DE LAS RESTAS     ***/
											SET @Cantidad = @Cantidad - @Disponible
											SET @CantidadFaltante = @CantidadFaltante - @Disponible
											SET @Disponible = @Disponible - @Disponible
											/*************************************************/
  										END	
									END
								
								/********     DOMICILIO     ********/
								IF @PosicionTipo = 'Domicilio'
									BEGIN
										IF @Disponible >= @Cantidad AND @Disponible > 0 AND @CantidadFaltante > 0
										BEGIN
											--SELECT @Articulo, @Tarima, @SerieLote, @PosicionTipo
											---------------------------------------------------------------------------------------------------------
											IF EXISTS(SELECT * 
														FROM @Asignado 
													   WHERE Empresa = @Empresa 
													     AND Articulo = @Articulo
													     AND ISNULL(Subcuenta,'') = ISNULL(@SubCuenta,'')
													     AND Almacen = @Almacen
													     AND Sucursal = @Sucursal
													     AND ISNULL(SerieLote,'') =  ISNULL(@SerieLote,'')
													     AND Tarima = @Tarima)
												UPDATE @Asignado SET Asignado = ISNULL(Asignado,0) + @Cantidad
												 WHERE Empresa = @Empresa
												   AND Articulo = @Articulo
												   AND ISNULL(Subcuenta,'') = ISNULL(@SubCuenta,'')
												   AND Almacen = @Almacen
												   AND Sucursal = @Sucursal
												   AND ISNULL(SerieLote,'') =  ISNULL(@SerieLote,'')
												   AND Tarima = @Tarima												
											ELSE
												INSERT @Asignado(Empresa, Articulo, Subcuenta, Almacen, Sucursal, SerieLote, Tarima, Asignado)
  														  SELECT @Empresa, @Articulo, ISNULL(@SubCuenta,''), @Almacen, @Sucursal, @SerieLote, @Tarima, @Cantidad
  														  
											---------------------------------------------------------------------------------------------------------
                                            INSERT @PreparaDatosSurtir (Modulo, Mov, Moduloid, Cantidad, Pocicion, Articulo, SubCuenta, Almacen, Unidad, CantidadUnidad, Factor, RenglonID, SerieLote, Tarima) 	
                                              EXEC spPreparaDatosSurtir @Modulo, @IDAux, @Articulo, @Renglon, @RenglonID, @Empresa, @Tarima, @SerieLote
											
											SET @IDPrepDatosSur = @@IDENTITY
											
											INSERT WMSSurtidoProcesarD (Estacion, Modulo, Mov, ModuloID, Procesado, Articulo, Tarima, PosicionDestino, 
																		CantidadTarima, PosicionOrigen, Tipo, Zona, Almacen, Referencia, Unidad, CantidadUnidad, 
																		SucursalFiltro, SubCuenta, TarimaFechaCaducidad, SerieLote, PCKUbicacion, MovID)                                              
														         SELECT @Estacion, Modulo, Mov, Moduloid, 0, Articulo, Tarima, Pocicion, 
																		CASE WHEN ISNULL(SerieLote,'') <> '' THEN Cantidad ELSE @Cantidad END,
																		@Posicion, @PosicionTipo, @Zona, Almacen, @Referencia, Unidad, 
                                                                        CASE WHEN ISNULL(SerieLote,'') <> '' THEN Cantidad ELSE @Cantidad END,
																		0, SubCuenta, @FechaCaducidad, SerieLote, 0, @MovID  
														           FROM @PreparaDatosSurtir
														          WHERE ID = @IDPrepDatosSur
											---------------------------------------------------------------------------------------------------------
											/***     NO CAMBIAR EL ORDEN DE LAS RESTAS     ***/
											SET @CantidadFaltante = @CantidadFaltante - @Cantidad
											SET @Disponible = @Disponible - @Cantidad
											SET @Cantidad = @Cantidad - @Cantidad
											/*************************************************/
  										END
  										
  										IF @Disponible < @Cantidad AND @Disponible > 0 AND @CantidadFaltante > 0
  										BEGIN
  											---------------------------------------------------------------------------------------------------------
											IF EXISTS(SELECT * 
														FROM @Asignado 
													   WHERE Empresa = @Empresa 
													     AND Articulo = @Articulo
													     AND ISNULL(Subcuenta,'') = ISNULL(@SubCuenta,'')
													     AND Almacen = @Almacen
													     AND Sucursal = @Sucursal
													     AND ISNULL(SerieLote,'') =  ISNULL(@SerieLote,'')
													     AND Tarima = @Tarima)
												UPDATE @Asignado SET Asignado = ISNULL(Asignado,0) + @Disponible
												 WHERE Empresa = @Empresa
												   AND Articulo = @Articulo
												   AND ISNULL(Subcuenta,'') = ISNULL(@SubCuenta,'')
												   AND Almacen = @Almacen
												   AND Sucursal = @Sucursal
												   AND ISNULL(SerieLote,'') =  ISNULL(@SerieLote,'')
												   AND Tarima = @Tarima												
											ELSE
												INSERT @Asignado(Empresa, Articulo, Subcuenta, Almacen, Sucursal, SerieLote, Tarima, Asignado)
  														  SELECT @Empresa, @Articulo, ISNULL(@SubCuenta,''), @Almacen, @Sucursal, @SerieLote, @Tarima, @Disponible
  														  
											---------------------------------------------------------------------------------------------------------
                                            INSERT @PreparaDatosSurtir (Modulo, Mov, Moduloid, Cantidad, Pocicion, Articulo, SubCuenta, Almacen, Unidad, CantidadUnidad, Factor, RenglonID, SerieLote, Tarima) 	
                                              EXEC spPreparaDatosSurtir @Modulo, @IDAux, @Articulo, @Renglon, @RenglonID, @Empresa, @Tarima, @SerieLote
											
											SET @IDPrepDatosSur = @@IDENTITY
											
											INSERT WMSSurtidoProcesarD (Estacion, Modulo, Mov, ModuloID, Procesado, Articulo, Tarima, PosicionDestino, 
																		CantidadTarima, PosicionOrigen, Tipo, Zona, Almacen, Referencia, Unidad, CantidadUnidad, 
																		SucursalFiltro, SubCuenta, TarimaFechaCaducidad, SerieLote, PCKUbicacion, MovID)                                              
														         SELECT @Estacion, Modulo, Mov, Moduloid, 0, Articulo, Tarima, Pocicion, 
																		CASE WHEN ISNULL(SerieLote,'') <> '' THEN Cantidad ELSE @Disponible END, 
																		@Posicion, @PosicionTipo, @Zona, Almacen, @Referencia, Unidad, 
                                                                        CASE WHEN ISNULL(SerieLote,'') <> '' THEN Cantidad ELSE @Disponible END,
																		0, SubCuenta, @FechaCaducidad, SerieLote, 0, @MovID
														           FROM @PreparaDatosSurtir
														          WHERE ID = @IDPrepDatosSur
											---------------------------------------------------------------------------------------------------------
											/***     NO CAMBIAR EL ORDEN DE LAS RESTAS     ***/
											SET @Cantidad = @Cantidad - @Disponible
											SET @CantidadFaltante = @CantidadFaltante - @Disponible
											SET @Disponible = @Disponible - @Disponible
											/*************************************************/
  										END
									END
									
								--/********     UBICACION (Picking Tarima Completa)     ********/
								IF @PosicionTipo = 'Ubicacion' AND @Disponible > @Cantidad AND @CantidadFaltante > 0 AND @WMSPCKUbicacion = 1
									BEGIN
                                        IF @Disponible >= @Cantidad AND @Disponible > 0 AND @CantidadFaltante > 0
										BEGIN
                                        
											---------------------------------------------------------------------------------------------------------
											IF EXISTS(SELECT * 
														FROM @Asignado 
													   WHERE Empresa = @Empresa 
													     AND Articulo = @Articulo
													     AND ISNULL(Subcuenta,'') = ISNULL(@SubCuenta,'')
													     AND Almacen = @Almacen
													     AND Sucursal = @Sucursal
													     AND ISNULL(SerieLote,'') =  ISNULL(@SerieLote,'')
													     AND Tarima = @Tarima)
												UPDATE @Asignado SET Asignado = ISNULL(Asignado,0) + @Cantidad
                                                 WHERE Empresa = @Empresa 
												   AND Articulo = @Articulo
												   AND ISNULL(Subcuenta,'') = ISNULL(@SubCuenta,'')
												   AND Almacen = @Almacen
												   AND Sucursal = @Sucursal
												   AND ISNULL(SerieLote,'') =  ISNULL(@SerieLote,'')
												   AND Tarima = @Tarima
											ELSE
												INSERT @Asignado(Empresa, Articulo, Subcuenta, Almacen, Sucursal, SerieLote, Tarima, Asignado)
  														  SELECT @Empresa, @Articulo, ISNULL(@SubCuenta,''), @Almacen, @Sucursal, @SerieLote, @Tarima, @Cantidad

											---------------------------------------------------------------------------------------------------------
                                            INSERT @PreparaDatosSurtir (Modulo, Mov, Moduloid, Cantidad, Pocicion, Articulo, SubCuenta, Almacen, Unidad, CantidadUnidad, Factor, RenglonID, SerieLote, Tarima) 	
                                              EXEC spPreparaDatosSurtir @Modulo, @IDAux, @Articulo, @Renglon, @RenglonID, @Empresa, @Tarima, @SerieLote
											
											SET @IDPrepDatosSur = @@IDENTITY
											
											INSERT WMSSurtidoProcesarD (Estacion, Modulo, Mov, ModuloID, Procesado, Articulo, Tarima, PosicionDestino, 
																		CantidadTarima, PosicionOrigen, Tipo, Zona, Almacen, Referencia, Unidad, CantidadUnidad, 
																		SucursalFiltro, SubCuenta, TarimaFechaCaducidad, SerieLote, PCKUbicacion, MovID)                                              
														         SELECT @Estacion, Modulo, Mov, Moduloid, 0, Articulo, Tarima, Pocicion,
																		CASE WHEN ISNULL(SerieLote,'') <> '' THEN Cantidad ELSE @Cantidad END,
																		@Posicion, @PosicionTipo, @Zona, Almacen, @Referencia, Unidad, 
                                                                        CASE WHEN ISNULL(SerieLote,'') <> '' THEN Cantidad ELSE @Cantidad END,
																		0, SubCuenta, @FechaCaducidad, SerieLote, 1, @MovID
														           FROM @PreparaDatosSurtir
														          WHERE ID = @IDPrepDatosSur
											---------------------------------------------------------------------------------------------------------
											/***     NO CAMBIAR EL ORDEN DE LAS RESTAS     ***/
											SET @CantidadFaltante = @CantidadFaltante - @Cantidad
											SET @Disponible = @Disponible - @Cantidad
											SET @Cantidad = @Cantidad - @Cantidad
											/*************************************************/
  										END
  										
  										IF @Disponible < @Cantidad AND @Disponible > 0 AND @CantidadFaltante > 0
  										BEGIN
  											---------------------------------------------------------------------------------------------------------
											IF EXISTS(SELECT * 
														FROM @Asignado 
													   WHERE Empresa = @Empresa 
													     AND Articulo = @Articulo
													     AND ISNULL(Subcuenta,'') = ISNULL(@SubCuenta,'')
													     AND Almacen = @Almacen
													     AND Sucursal = @Sucursal
													     AND ISNULL(SerieLote,'') =  ISNULL(@SerieLote,'')
													     AND Tarima = @Tarima)
												UPDATE @Asignado SET Asignado = ISNULL(Asignado,0) + @Disponible
                                                 WHERE Empresa = @Empresa 
												   AND Articulo = @Articulo
												   AND ISNULL(Subcuenta,'') = ISNULL(@SubCuenta,'')
												   AND Almacen = @Almacen
												   AND Sucursal = @Sucursal
												   AND ISNULL(SerieLote,'') =  ISNULL(@SerieLote,'')
												   AND Tarima = @Tarima
											ELSE
												INSERT @Asignado(Empresa, Articulo, Subcuenta, Almacen, Sucursal, SerieLote, Tarima, Asignado)
  														  SELECT @Empresa, @Articulo, ISNULL(@SubCuenta,''), @Almacen, @Sucursal, @SerieLote, @Tarima, @Disponible
											
											---------------------------------------------------------------------------------------------------------
                                            INSERT @PreparaDatosSurtir (Modulo, Mov, Moduloid, Cantidad, Pocicion, Articulo, SubCuenta, Almacen, Unidad, CantidadUnidad, Factor, RenglonID, SerieLote, Tarima) 	
                                              EXEC spPreparaDatosSurtir @Modulo, @IDAux, @Articulo, @Renglon, @RenglonID, @Empresa, @Tarima, @SerieLote
											
											SET @IDPrepDatosSur = @@IDENTITY
											
											INSERT WMSSurtidoProcesarD (Estacion, Modulo, Mov, ModuloID, Procesado, Articulo, Tarima, PosicionDestino, 
																		CantidadTarima, PosicionOrigen, Tipo, Zona, Almacen, Referencia, Unidad, CantidadUnidad, 
																		SucursalFiltro, SubCuenta, TarimaFechaCaducidad, SerieLote, PCKUbicacion, MovID)                                              
														         SELECT @Estacion, Modulo, Mov, Moduloid, 0, Articulo, Tarima, Pocicion, 
																		CASE WHEN ISNULL(SerieLote,'') <> '' THEN Cantidad ELSE @Disponible END,
																		@Posicion, @PosicionTipo, @Zona, Almacen, @Referencia, Unidad, 
                                                                        CASE WHEN ISNULL(SerieLote,'') <> '' THEN Cantidad ELSE @Disponible END,
																		0, SubCuenta, @FechaCaducidad, SerieLote, 1, @MovID
														           FROM @PreparaDatosSurtir
														          WHERE ID = @IDPrepDatosSur
											---------------------------------------------------------------------------------------------------------
											/***     NO CAMBIAR EL ORDEN DE LAS RESTAS     ***/
											SET @Cantidad = @Cantidad - @Disponible
											SET @CantidadFaltante = @CantidadFaltante - @Disponible
											SET @Disponible = @Disponible - @Disponible
											/*************************************************/
  										END	
									END
									
							FETCH NEXT FROM crSerieLoteU INTO @Tarima, @SerieLote, @Disponible, @Posicion, @PosicionTipo, @FechaCaducidad
							END
						
						CLOSE crSerieLoteU
						DEALLOCATE crSerieLoteU		

						IF @CantidadFaltante > 0  
							BEGIN
								IF NOT EXISTS(SELECT * 
												FROM WMSSurtidoPendiente 
											   WHERE Estacion = @Estacion
											     AND Articulo = @Articulo
											     AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'')
											     AND Almacen = @Almacen)
									INSERT WMSSurtidoPendiente (Estacion, Articulo, Almacen, Cantidad, SubCuenta, ID, Modulo, MovID)  
													    SELECT  @Estacion, @Articulo, @Almacen, @CantidadFaltante, @SubCuenta, @IDAux, @Modulo, @MovID
                         ELSE
							UPDATE WMSSurtidoPendiente 
							   SET Cantidad = ISNULL(Cantidad,0) + @CantidadFaltante
							 WHERE Estacion = @Estacion 
							   AND Articulo = @Articulo
							   AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'')
							   AND Almacen = @Almacen
                        END

				------------------------------------------------------------------------------------------------------------------------------------	
					FETCH NEXT FROM crUbicacion INTO @Cantidad, @Articulo, @SubCuenta, @Almacen, @Renglon, @RenglonID, @MovTipo, @Sucursal, @ControlArticulo, @Tipo, @MovID
				END
			
			CLOSE crUbicacion
			DEALLOCATE crUbicacion
			
			IF @Ok IS NOT NULL
				BREAK
				
	--------------------------------------------------------------------------------------------------------------------------------------------------	
		FETCH NEXT FROM crSugerir INTO @Modulo, @IDAux
	END

	CLOSE crSugerir
	DEALLOCATE crSugerir

    UPDATE WMSModuloTarima SET Utilizar = 0 WHERE ID IN(SELECT ID FROM #CualesID)

    DECLARE crSurtidoPendiente CURSOR FOR	
        SELECT ID, Modulo 
		  FROM WMSSurtidoPendiente
		 WHERE Estacion = @Estacion
         GROUP BY ID, Modulo

	OPEN crSurtidoPendiente
	FETCH NEXT FROM crSurtidoPendiente INTO @ID, @Modulo
	WHILE @@FETCH_STATUS = 0 
	BEGIN	
        IF @Modulo = 'VTAS' 
            SELECT @Mov = Mov FROM Venta WHERE ID = @ID

        IF @Modulo = 'COMS' 
            SELECT @Mov = Mov FROM Compra WHERE ID = @ID

        IF @Modulo = 'INV' 
            SELECT @Mov = Mov FROM Inv WHERE ID = @ID
        
        UPDATE WMSSurtidoPendiente 
           SET Mov = @Mov 
         WHERE ID     = @ID
           AND Modulo = @Modulo

		FETCH NEXT FROM crSurtidoPendiente INTO @ID, @Modulo
	END
	CLOSE crSurtidoPendiente
	DEALLOCATE crSurtidoPendiente


	IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000 OR @Ok = 80010  
		BEGIN
			IF EXISTS (SELECT * FROM WMSSurtidoPendiente WHERE Estacion = @Estacion)
				BEGIN
					IF @EnSilencio = 0
						SELECT 'Los movimientos seleccionados no podrán ser surtidos en su Totalidad.'  
				END
			ELSE
				BEGIN 
					IF @EnSilencio = 0    
						SELECT 'Procesadas Con Exito'    
			END
		END
	ELSE  
		BEGIN
			IF @OK = 10036
				IF @EnSilencio = 0    
					SELECT Descripcion + ' ' + ISNULL(@OkRef,'')  FROM MensajeLista WHERE Mensaje = @Ok  
			ELSE
				IF @EnSilencio = 0  
					SELECT Descripcion + ' Articulo ' + ISNULL(@OkRef,'')  FROM MensajeLista WHERE Mensaje = @Ok  
					DELETE WMSSurtidoProcesarD WHERE Estacion = @Estacion AND Procesado = 0  
		END	

END
GO

--REQ12615 WMS
/**************** spProcesarTMASurtidoTransito ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProcesarTMASurtidoTransito') and type = 'P') drop procedure dbo.spProcesarTMASurtidoTransito
GO             
CREATE PROCEDURE spProcesarTMASurtidoTransito
            @Estacion		int,
		    @Empresa		char(5),
		    @FechaEmision	datetime,
		    @Usuario		char(10),
		    @CteCNO			char(10) 	= NULL,
		    @EnSilencio		bit	 	= 0,
		    @Ok				int	 	= NULL	OUTPUT,
		    @OkRef			varchar(255)	= NULL	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @NotaID				int,  
	@Mov				varchar(20),
	@Estatus			varchar(20),    
	@Agente				varchar(10),
	@TarimaSurtido		varchar(20),
    @Sucursal			int,
    @SurtidoID			int,
    @Renglon			float,    
    @Almacen			char(10),	    
    @Posicion			char(10),	
	@PosicionDestino	char(10),
    @Cantidad			float,
	@Aplica				varchar(20),
	@AplicaID			varchar(20),
    @AplicaRenglon		float,
    @Zona				varchar(50),
	@Tarima				varchar(20),
    @CuantasNotas		int,
    @Cuantas			int,
    @IDAplica			int,
    @MovDestino			varchar(20),
    @MovDestinoID		varchar(20),
    @Origen				varchar(20),
    @OrigenID			varchar(20),
    @IDOrigen			int,
    @Montacarga			varchar(10),
    @IdO                int,
    @IdMovO             int,
    @OrigenO            varchar(20),
    @OrigenIDO          varchar(20),
    @OrigenMov          varchar(20),
    @OrigenIDMov        varchar(20),
    @Modulo             varchar(5),
	--TASK2429PGC
	@Articulo        varchar(20),
    @SubCuenta       varchar(50),
    @Transaccion     varchar(10),
    @ArtCambioClave  varchar(50)

  SELECT @CuantasNotas = 0
  SET @Transaccion = CONVERT(VARCHAR,@@SPID)
   
  IF NOT EXISTS(SELECT * FROM ListaID WHERE Estacion = @Estacion)
  BEGIN
    SELECT @OkRef = 'No se seleccinó ningún Movimiento'
    SELECT @OkRef
    RETURN
  END
  ELSE
    SELECT @Cuantas = COUNT(*) FROM ListaID WHERE Estacion = @Estacion  
  
  BEGIN TRANSACTION @Transaccion

  DECLARE crLista CURSOR 
      FOR SELECT ID FROM ListaID WHERE Estacion = @Estacion
  OPEN crLista
  FETCH NEXT FROM crLista INTO @NotaID
  CLOSE crLista
  DEALLOCATE crLista
  IF @NotaID IS NULL 
  BEGIN
    SELECT @Ok = 10160
    IF @EnSilencio = 1 RETURN
  END

  SELECT TOP 1 
         @Mov = Mov, 
		 @Estatus = 'SINAFECTAR' 
    FROM MovTipo 
   WHERE Clave = 'TMA.SUR' 
     AND Modulo = 'TMA'  

  CREATE TABLE #Surtido (ID int NULL, FechaEmision datetime NULL)

    DECLARE crEncabezado CURSOR LOCAL FOR
     SELECT DISTINCT Agente, TarimaSurtido, Sucursal, Almacen, Mov, MovID, Montacarga, Origen, OrigenID, t.ID, t.OrigenTipo
       FROM TMA t, ListaID l
      WHERE l.Estacion = @Estacion AND t.ID = l.ID

    OPEN crEncabezado
    FETCH NEXT FROM crEncabezado INTO @Agente, @TarimaSurtido, @Sucursal, @Almacen, @Origen, @OrigenID, @Montacarga, @OrigenO, @OrigenIDO, @IDO, @Modulo
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL                                                                         
    BEGIN                                                                                          
      
      INSERT TMA (Empresa,   Usuario,  Mov,	 FechaEmision,	Estatus,  Sucursal,  Almacen,  Agente, Origen, OrigenID, Prioridad, TarimaSurtido, Montacarga)
      VALUES     (@Empresa, @Usuario, @Mov, @FechaEmision, @Estatus, @Sucursal, @Almacen, @Agente, @Origen, @OrigenID, 'Normal', @TarimaSurtido, @Montacarga)    
      SELECT @SurtidoID = @@IDENTITY
      SELECT @Renglon = 0

      EXEC spMovCopiarSerielote @Sucursal, @Modulo, @IDO, @SurtidoID --3

      DECLARE crDetalle CURSOR LOCAL FOR 
       SELECT d.Almacen, d.Posicion, d.PosicionDestino, d.CantidadPicking, t.Mov, t.MovID, d.Renglon, d.Zona, d.Tarima, o.ID, d.Articulo, d.SubCuenta, d.ArtCambioClave --TASK2429PGC
         FROM TMA t
         JOIN TMAD d
           ON t.ID = d.ID
         JOIN TMA o ON o.Mov = t.Origen
          AND o.MovID = t.OrigenID
          AND o.Empresa = t.Empresa
         JOIN ListaID l
           ON l.ID = t.ID AND Estacion = @Estacion
        WHERE t.Agente = @Agente 
          AND t.TarimaSurtido = @TarimaSurtido 
          AND t.Sucursal = @Sucursal 
          AND t.Almacen = @Almacen
		  --BUG7778
		  AND t.Mov = @Origen
		  AND t.MovID = @OrigenID

      OPEN crDetalle
      FETCH NEXT FROM crDetalle INTO @Almacen, @Posicion, @PosicionDestino, @Cantidad, @Aplica, @AplicaID, @AplicaRenglon, @Zona, @Tarima, @IDOrigen, @Articulo, @SubCuenta, @ArtCambioClave --TASK2429PGC
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          SELECT @Renglon = @Renglon + 2048
          INSERT TMAD (ID,          Sucursal,  Renglon, Tarima,          Almacen,  Posicion,   PosicionDestino, CantidadPicking,  Aplica,  AplicaID,  AplicaRenglon,  Zona, TarimaPCK, Prioridad, EstaPendiente, Articulo, SubCuenta, ArtCambioClave) --TASK2429PGC
          SELECT       @SurtidoID, @Sucursal, @Renglon, @TarimaSurtido, @Almacen, @Posicion,  @PosicionDestino, @Cantidad,       @Aplica, @AplicaID, @AplicaRenglon, @Zona, @Tarima, 'Normal', 1, @Articulo, @SubCuenta, @ArtCambioClave --TASK2429PGC
          
		  --BUG7778
          --UPDATE TMAD SET CantidadA  = 0, CantidadPendiente = ISNULL(CantidadPendiente, CantidadPicking) - @Cantidad WHERE ID = @IDOrigen AND Tarima = CASE WHEN CHARINDEX('-', @Tarima, 1) >0 THEN SUBSTRING(@Tarima, 1, CHARINDEX('-', @Tarima, 1)-1) ELSE @Tarima END
		  UPDATE TMAD SET CantidadA  = 0 WHERE ID = @IDOrigen AND Tarima = CASE WHEN CHARINDEX('-', @Tarima, 1) >0 THEN SUBSTRING(@Tarima, 1, CHARINDEX('-', @Tarima, 1)-1) ELSE @Tarima END

		  /* Se actualiza el RenglonID por que el movimiento anterior tiene otro RenglonID y por ende este no se visualiza en el surtido TMA */
		  IF EXISTS (SELECT * FROM SerieloteMov WHERE Modulo = 'TMA' AND ID = @SurtidoID)
			UPDATE SerieLoteMov SET RenglonID = @Renglon WHERE Modulo = 'TMA' AND ID = @SurtidoID

        END
        FETCH NEXT FROM crDetalle INTO @Almacen, @Posicion, @PosicionDestino, @Cantidad, @Aplica, @AplicaID, @AplicaRenglon, @Zona, @Tarima, @IDOrigen, @Articulo, @SubCuenta, @ArtCambioClave --TASK2429PGC
      END -- While
      CLOSE crDetalle
      DEALLOCATE crDetalle

      INSERT VentaOrigen (ID, OrigenID, Sucursal, SucursalOrigen)
      SELECT @SurtidoID, v.ID, @Sucursal, @Sucursal 
        FROM Venta v, ListaID l
       WHERE l.Estacion = @Estacion AND v.ID = l.ID

      INSERT #Surtido (ID) VALUES (@SurtidoID)
      SELECT @CuantasNotas = @CuantasNotas + 1

      FETCH NEXT FROM crEncabezado INTO @Agente, @TarimaSurtido, @Sucursal, @Almacen, @Origen, @OrigenID, @Montacarga, @OrigenO, @OrigenIDO, @IdO, @Modulo 
    END -- While
    CLOSE crEncabezado
    DEALLOCATE crEncabezado

    DECLARE crSurtido CURSOR LOCAL FOR
     SELECT ID
       FROM #Surtido
    OPEN crSurtido
    FETCH NEXT FROM crSurtido INTO @SurtidoID
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN
        
      EXEC spAfectar 'TMA', @SurtidoID, 'Afectar', @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT    

      IF @Ok IN (80030, 80060) SELECT @Ok = NULL, @OkRef = NULL

      DECLARE crAplica CURSOR LOCAL FOR
       SELECT DISTINCT d.Aplica, d.AplicaID, t.ID
         FROM TMAD d
         JOIN TMA t ON d.Aplica = t.Mov AND d.AplicaID = t.MovID AND t.Empresa = @Empresa
        WHERE d.ID = @SurtidoID
      OPEN crAplica
      FETCH NEXT FROM crAplica INTO @Aplica, @AplicaID, @IDAplica
      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
      BEGIN
    
        UPDATE TMA SET Estatus = 'CONCLUIDO' WHERE Mov = @Aplica AND MovID = @AplicaID AND Empresa = @Empresa AND Estatus = 'PROCESAR'
        SELECT @MovDestino = Mov, @MovDestinoID = MovID FROM TMA WHERE ID = @SurtidoID
        EXEC spMovFlujo @Sucursal, Afectar, @Empresa, 'TMA', @IDAplica, @Aplica, @AplicaID, 'TMA', @SurtidoID, @MovDestino, @MovDestinoID, @Ok OUTPUT

        FETCH NEXT FROM crAplica INTO @Aplica, @AplicaID, @IDAplica
      END
      CLOSE crAplica
      DEALLOCATE crAplica

      FETCH NEXT FROM crSurtido INTO @SurtidoID
    END
    CLOSE crSurtido
    DEALLOCATE crSurtido

  IF @Ok IS NULL
  BEGIN    
    IF @EnSilencio = 0
    BEGIN
      SELECT @OkRef = RTRIM(Convert(char, @Cuantas))+' Surtidos(s) Transito procesados.'
      IF @SurtidoID IS NOT NULL
      BEGIN
        IF @CuantasNotas = 1 
          SELECT @OkRef = RTRIM(ISNULL(@OkRef,'')) + '<BR>Se Procesaron: '+RTRIM(@Mov)
        ELSE
          SELECT @OkRef = RTRIM(ISNULL(@OkRef,'')) + '<BR>Se Procesaron: '+CONVERT(varchar, @CuantasNotas)+' '+RTRIM(@Mov)+'(s)'
      END
      SELECT @OkRef
    END
    COMMIT TRANSACTION @Transaccion
  END ELSE
  BEGIN
    IF @EnSilencio = 0
      SELECT  'Error: - ' + CONVERT(varchar, Mensaje) + '<BR><BR>' + Descripcion + '<BR><BR>' + RTRIM(ISNULL(@OkRef,''))
        FROM MensajeLista
       WHERE Mensaje = @Ok  
     
     ROLLBACK TRANSACTION @Transaccion
  END
  RETURN
END
GO

--REQ12615 WMS
/************************************* spWMSMontacargaTarea ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWMSMontacargaTarea') and type = 'P') drop procedure dbo.spWMSMontacargaTarea
GO
CREATE PROCEDURE spWMSMontacargaTarea
  @Estacion        int,
  @Todos           bit
--//WITH ENCRYPTION
AS BEGIN

  DELETE WMSMontacargaTarea WHERE Estacion = @Estacion

  INSERT WMSMontacargaTarea (
         Estacion, Empresa, ID, Renglon, Mov, MovID, FechaEmision, Tarima,
         Sucursal,
         NomSucursal,
         Zona,
         Pasillo,
         PosicionOrigen, PosicionDestino, Articulo, Montacarga, Prioridad, Almacen, Modificar, Clave, Movimiento, NoCajas)
  SELECT @Estacion, t.Empresa, t.ID, d.Renglon, t.Mov, t.MovID, t.FechaEmision, d.Tarima,
         CASE WHEN IsNumeric(Replace(t.Referencia,'Sucursal Destino','')) = 1 THEN Replace(t.Referencia,'Sucursal Destino','') ELSE t.Sucursal END,
         ISNULL(sc.Nombre,'') + CASE WHEN t.OrigenObservaciones IS NULL THEN '' ELSE ' (' + ISNULL(t.OrigenObservaciones,'') + ')' END,
         ald.Zona,
         CASE WHEN mt.Clave IN('TMA.SADO','TMA.SRADO') THEN ald.Pasillo ELSE al.Pasillo END,
         d.Posicion, d.PosicionDestino, a.Articulo, d.Montacarga, d.Prioridad, d.Almacen, 0, mt.Clave, t.Mov + ' ' + ISNULL(t.MovID, ''), SUM(CantidadUnidad)
    FROM TMA t WITH(NOLOCK)
    JOIN TMAD d WITH(NOLOCK) ON (t.ID = d.ID)
    JOIN ArtDisponibleTarima a WITH(NOLOCK) ON (d.Tarima = a.Tarima AND a.Empresa = t.Empresa AND a.Almacen = d.Almacen AND a.Articulo = d.Articulo)
    JOIN MovTipo mt WITH(NOLOCK) ON (t.Mov = mt.Mov AND Modulo = 'TMA')
    LEFT OUTER JOIN Sucursal sc WITH(NOLOCK) ON (ISNULL(t.SucursalFiltro,t.Sucursal) = sc.Sucursal)
    LEFT OUTER JOIN AlmPos al WITH(NOLOCK) ON (al.Almacen = t.Almacen AND al.Posicion = d.Posicion)
    LEFT OUTER JOIN AlmPos ald WITH(NOLOCK) ON (ald.Almacen = t.Almacen AND ald.Posicion = CASE WHEN mt.Clave = 'TMA.OSUR' THEN d.Posicion ELSE d.PosicionDestino END)
   WHERE t.Estatus IN('PENDIENTE')
     AND mt.Clave IN('TMA.SADO','TMA.SRADO','TMA.OADO','TMA.ORADO','TMA.OSUR','TMA.OPCKTARIMA')
     AND mt.SubClave NOT IN('TMA.OSURP')
     AND ISNULL(d.Montacarga,'') = CASE WHEN @Todos = 0 THEN '' ELSE ISNULL(d.Montacarga,'') END
     AND d.Procesado = 0
   GROUP BY t.Empresa, t.ID, d.Renglon, t.Mov, t.MovID, t.FechaEmision, d.Tarima,
            t.Referencia, t.Sucursal, sc.Nombre, t.OrigenObservaciones, mt.Clave, ald.Pasillo, al.Pasillo, d.Posicion, d.PosicionDestino,
            a.Articulo, d.Montacarga, d.Prioridad, d.Almacen, ald.Zona

  INSERT WMSMontacargaTarea (Estacion, Empresa, ID, Renglon, Mov, MovID, FechaEmision, Tarima,Sucursal,NomSucursal,Zona, Pasillo,PosicionOrigen, PosicionDestino, Articulo, Montacarga, Prioridad, Almacen, Modificar, Clave, Movimiento, NoCajas) --BUG3276
  SELECT @Estacion, t.Empresa, t.ID, 0, t.Mov, t.MovID, t.FechaEmision, 'Picking',CASE WHEN IsNumeric(Replace(t.Referencia,'Sucursal Destino',''))=1 THEN Replace(t.Referencia,'Sucursal Destino','') ELSE t.Sucursal END,
         --sc.Nombre +  ' (' + ISNULL(t.OrigenObservaciones,'') + ')', --BUG3302
       ISNULL(sc.Nombre,'') +  CASE WHEN t.OrigenObservaciones IS NULL THEN '' ELSE ' (' + ISNULL(t.OrigenObservaciones,'') + ')' END, --BUG3302
         ald.Zona, --BUG3276 --UserStory3623
         CASE WHEN mt.Clave IN('TMA.SADO','TMA.SRADO') THEN ald.Pasillo ELSE al.Pasillo END,
         --BUG24539
         d.Posicion, d.PosicionDestino, a.Articulo, d.Montacarga, d.Prioridad, d.Almacen, 0, mt.Clave, t.Mov + ' ' + ISNULL(t.MovID, ''), SUM(CantidadUnidad)
    FROM TMA t WITH(NOLOCK)
    JOIN TMAD d  WITH(NOLOCK) ON t.ID = d.ID
    --EWQ. Tuning
    JOIN ArtDisponibleTarima a  WITH(NOLOCK) ON d.Tarima = a.Tarima AND a.Empresa = t.Empresa AND a.Almacen = d.Almacen AND a.Articulo=d.Articulo --BUG7824 Se agrega el artículo como filtro de la consulta
    JOIN MovTipo mt  WITH(NOLOCK) ON t.Mov = mt.Mov AND Modulo = 'TMA'
  LEFT OUTER JOIN Sucursal sc  WITH(NOLOCK) ON ISNULL(t.SucursalFiltro,t.Sucursal) = sc.Sucursal --BUG3302
    LEFT OUTER JOIN AlmPos al  WITH(NOLOCK) ON al.Almacen = t.Almacen AND al.Posicion = d.Posicion
    LEFT OUTER JOIN AlmPos ald  WITH(NOLOCK) ON ald.Almacen = t.Almacen AND ald.Posicion =
  CASE WHEN mt.Clave = 'TMA.OSUR' THEN d.Posicion ELSE d.PosicionDestino END
   WHERE t.Estatus IN('PENDIENTE')--, 'CONCLUIDO', 'SINAFECTAR')
     AND mt.Clave IN('TMA.SRADO', 'TMA.SADO', 'TMA.OSUR')
     AND mt.SubClave IN('TMA.OSURP')
     AND ISNULL(d.Montacarga,'') = CASE WHEN @Todos = 0 THEN '' ELSE ISNULL(d.Montacarga,'') END
   AND d.Procesado = 0 --TASK4416
   GROUP BY t.Empresa, t.ID, t.Mov, t.MovID, t.FechaEmision, t.Referencia, t.Sucursal, sc.Nombre, t.OrigenObservaciones,mt.Clave, ald.Pasillo, al.Pasillo, d.Posicion, d.PosicionDestino,
            a.Articulo,d.Montacarga, d.Prioridad, d.Almacen, mt.Clave, t.Mov, t.MovID, ald.Zona --BUG3276 --UserStory3623

END
GO

--UserStory3623
/************************************* spTareaAcomodadorValidaMovimiento ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTareaAcomodadorValidaMovimiento') and type = 'P') drop procedure dbo.spTareaAcomodadorValidaMovimiento
GO   
CREATE PROCEDURE spTareaAcomodadorValidaMovimiento
        @Empresa    char(5),
		@ID			int,
	    @Tarima		varchar(20),
		@Zona       varchar(50),		
		@Montacarga	varchar(20),
		@MovTipo    varchar(20),
		@Error      int=NULL OUTPUT,
		@ErrorRef   varchar(255)=NULL OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Agente			varchar(20),
    @Pendientes		int,
	@WMSValidarZona    int,
	@ZonaAgente     varchar(30),
	@PesoMaximoMontaCarga	float,
	@PesoTarimaMovimiento float, 
	@ValidaPeso     int,	
	@Mov		    varchar(20),
	@TipoMov	    varchar(20),
	@Tipo			varchar(50)

	SELECT @Tipo = WMSTipoAcomodador, @WMSValidarZona=ISNULL(WMSValidarZona,0) FROM EmpresaCfg WHERE Empresa = @Empresa --UserStory3623

		SELECT @Mov = Mov FROM MovTipo WHERE Clave = @MovTipo AND Modulo = 'TMA' 
		IF @MovTipo IN ('TMA.OADO', 'TMA.SADO', 'TMA.ADO')
          SELECT @TipoMov = Mov FROM MovTipo WHERE Clave = 'TMA.ADO' AND Modulo = 'TMA'
        ELSE
        IF @MovTipo IN ('TMA.ORADO', 'TMA.SRADO', 'TMA.RADO')
          SELECT @TipoMov = Mov FROM MovTipo WHERE Clave = 'TMA.RADO' AND Modulo = 'TMA'
        ELSE   
        IF @MovTipo IN ('TMA.OSUR', 'TMA.TSUR', 'TMA.SUR')
          SELECT @TipoMov = Mov FROM MovTipo WHERE Clave = 'TMA.SUR' AND Modulo = 'TMA' 

        IF NOT EXISTS(SELECT * 
                         FROM AgenteZona 
                        WHERE Agente = ISNULL(@Montacarga,Agente) 				        
                          AND ISNULL(NULLIF(Tipo,''),@TipoMov) IN (@TipoMov,'(Todos)') 
                          AND Zona IN(ISNULL(@Zona,Zona),'(TODAS)','(TODOS)'))
                AND @Zona IS NOT NULL
                 AND @WMSValidarZona=1
				    AND EXISTS(SELECT * FROM AgenteZona WHERE Agente = ISNULL(@Montacarga,Agente))
                          --SELECT @Ok = 20934, @OkRef='Tarima: '+ @Tarima + '<BR><BR>' +'Agente : '+@ZonaAgente
        BEGIN
          SELECT @Error = 20934
          SELECT @ErrorRef = ISNULL(Descripcion,'') + '. Agente: ' + RTRIM(LTRIM(@Montacarga))FROM MensajeLista WHERE Mensaje = @Error          
        END

  RETURN
END
GO

/************************************* spWMSValidaPCKLista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWMSValidaPCKLista') and type = 'P') drop procedure dbo.spWMSValidaPCKLista
GO   
CREATE PROCEDURE spWMSValidaPCKLista      
  @Tarima         varchar(100)
--//WITH ENCRYPTION
AS BEGIN   
DECLARE 
@TarimaW      varchar(100),
@MovW         varchar(100),
@MovIDW       varchar(100),
@ClaveW       varchar(100)
        
			  SELECT a.ID, a.Mov, a.MovID, b.Tarima, c.Clave, a.Estatus			
				FROM TMA a
					LEFT OUTER JOIN TMAD b ON b.ID=a.ID
					JOIN MovTipo c ON c.Modulo='TMA' AND c.Mov=a.Mov AND c.Clave='TMA.OPCKTARIMA'
				WHERE a.Estatus='PENDIENTE'
						AND Tarima=@Tarima
			
RETURN
END
GO

/************************************* spWMSValidaPCK ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWMSValidaPCK') and type = 'P') drop procedure dbo.spWMSValidaPCK
GO   
CREATE PROCEDURE spWMSValidaPCK      
  @Estacion         int,
  @Error				int	 	= NULL	OUTPUT,
  @ErrorRef			varchar(255)	= NULL	OUTPUT
--//WITH ENCRYPTION
AS BEGIN   
DECLARE 
@TarimaW      varchar(100),
@MovW         varchar(100),
@MovIDW       varchar(100),
@ClaveW       varchar(100)
        
			  SELECT a.ID, a.Mov, a.MovID, b.Tarima, c.Clave, a.Estatus
			    INTO #TMAEx
				FROM TMA a
					LEFT OUTER JOIN TMAD b ON b.ID=a.ID
					JOIN MovTipo c ON c.Modulo='TMA' AND c.Mov=a.Mov AND c.Clave='TMA.OPCKTARIMA'
				WHERE a.Estatus='PENDIENTE'
			
	         DECLARE crListaValidaPCK CURSOR FOR
			  SELECT Tarima, Mov, MovID, Clave FROM  #WMSMontacargaTreaPCK
			  OPEN crListaValidaPCK
			  FETCH NEXT FROM crListaValidaPCK INTO @TarimaW, @MovW, @MovIDW, @ClaveW
			  WHILE @@FETCH_STATUS = 0
			  BEGIN
			  
				   IF EXISTS(SELECT * FROM #TMAEx WHERE Tarima=@TarimaW) AND @ClaveW = 'TMA.OSUR'
				   BEGIN				 
				    SELECT @Error = 20024, @ErrorRef='No es posible asignar acomodador al movimiento ' + @MovW + ' '+ @MovIDW + '. Existen ordenes previas pendientes.' 
				   END
			  FETCH NEXT FROM crListaValidaPCK INTO @TarimaW, @MovW, @MovIDW, @ClaveW
			  END
			  CLOSE crListaValidaPCK
			  DEALLOCATE crListaValidaPCK 
			 
RETURN
END
GO

/************************************* spWMSActualizarMontacargista ****************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spWMSActualizarMontacargista') AND Type = 'P') DROP PROCEDURE dbo.spWMSActualizarMontacargista
GO             
CREATE PROCEDURE spWMSActualizarMontacargista
		@Estacion		int,
		@Montacargista	varchar(20),
		@Empresa		char(5)		
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @Tipo		varchar(50),

    @ID				int,
    @IDLista		int,

	--UserStory3623
	@Agente			varchar(20),
    @Pendientes		int,
	@WMSValidarZona    int,
	@ZonaAgente     varchar(30),
	@PesoMaximoMontaCarga	float,
	@PesoTarimaMovimiento float, 
	@ValidaPeso     int,
	@Tarima			varchar(20),
	@ZonaDetalle    varchar(50),
	@Mov		    varchar(20),
    @MovID		    varchar(20),
	@MovTipo        varchar(20),
    @Error          int=NULL,
	@TipoMov	    varchar(20),
	@ErrorRef       varchar(255),
	@PosicionDestino	char(10), --BUG5522

	@TarimaValida	varchar(20),
	@MovValida	    varchar(20),
    @MovIDValida	varchar(20),
	@MovTipoValida  varchar(20),
	@RenglonValida  float
	
   --UserStory3623
   --SELECT @ID = ID, @Tarima = Tarima, @ZonaDetalle = Zona, @MovTipo = Clave, @PosicionDestino=PosicionDestino FROM WMSMontacargaTarea WHERE IDLista IN(SELECT ID FROM ListaID WHERE Estacion = @Estacion)
   
   /***************************************Validación Asignación Acomodador***************************************************************************************************/
   /* Validación cuando se seleccionan dos o mas movimientos con la misma tarima y diferente clave de afectación */
   /*   
	SELECT t.Tarima, t.Clave, t.Mov, t.MovID
	    INTO #WMSMontacargaTreaPCK
        FROM WMSMontacargaTarea t
        JOIN ListaID l ON t.IDLista = l.ID AND t.Estacion = l.Estacion
       WHERE t.Estacion = @Estacion

	EXEC spWMSValidaPCK @Estacion, @Error=@Error OUTPUT , @ErrorRef=@ErrorRef OUTPUT

    IF @Error IS NULL
	BEGIN

	SELECT t.Tarima, t.Clave
	  INTO #WMSMontacargaTrea
      FROM WMSMontacargaTarea t
           JOIN ListaID l ON t.IDLista = l.ID AND t.Estacion = l.Estacion
     WHERE t.Estacion = @Estacion
	       AND t.Clave IN ('TMA.OPCKTARIMA', 'TMA.OSUR')
	 GROUP BY t.Tarima, t.Clave

	SELECT Tarima, COUNT(Tarima) Cantidad INTO #WMSMontacargaTreaCant FROM #WMSMontacargaTrea GROUP BY Tarima

		SELECT TOP 1 @Mov=Mov, @MovID=MovID  
		  FROM #WMSMontacargaTreaCant a
				JOIN #WMSMontacargaTrea b ON b.Tarima=a.Tarima
				JOIN WMSMontacargaTarea c ON c.Tarima=b.Tarima AND c.Clave=b.Clave AND c.Estacion=@Estacion
		 WHERE Cantidad>1
	  ORDER BY b.Tarima, b.Clave DESC
	 
		 IF NULLIF(@Mov, '') IS NOT NULL AND NULLIF(@MovID, '') IS NOT NULL
		 BEGIN
			SELECT @Error = 20024, @ErrorRef='No es posible asignar acomodador al movimiento '  + @Mov + ' '+ @MovID + '. Existen ordenes previas pendientes.'
		 END

   /* Validación cuando no se seleccionan dos o mas movimientos con la misma tarima y diferente clave de afectación pero si existen en WMSMontacargaTarea */  
	 IF @Error IS NULL
	 BEGIN
		 SELECT t.Renglon, t.Tarima, t.Clave, t.Mov, t.MovID
			INTO #WMSMontacargaTarValida
			FROM WMSMontacargaTarea t
			JOIN ListaID l ON t.IDLista = l.ID AND t.Estacion = l.Estacion
		   WHERE t.Estacion = @Estacion

		     DECLARE crListaValida CURSOR FOR
			  SELECT t.Renglon, t.Tarima, t.Clave, t.Mov, t.MovID
				FROM #WMSMontacargaTarValida t				
			ORDER BY t.Tarima
			  OPEN crListaValida
			  FETCH NEXT FROM crListaValida INTO @RenglonValida, @TarimaValida, @MovTipoValida, @MovValida, @MovIDValida
			  WHILE @@FETCH_STATUS = 0
			  BEGIN
			       IF EXISTS(SELECT * FROM WMSMontacargaTarea WHERE Estacion=@Estacion AND Tarima=@TarimaValida AND Clave <> @MovTipoValida AND @MovTipoValida <> 'TMA.OPCKTARIMA')
				   BEGIN
					SELECT @Error = 20024, @ErrorRef='No es posible asignar acomodador al movimiento '  + @MovValida + ' '+ @MovIDValida + '. Existen ordenes previas pendientes.'
				   END
			  FETCH NEXT FROM crListaValida INTO @RenglonValida, @TarimaValida, @MovTipoValida, @MovValida, @MovIDValida
			  END
			  CLOSE crListaValida
			  DEALLOCATE crListaValida 
	END 
 */
 IF @Error IS NULL
 BEGIN
   /***************************************Validación Asignación Acomodador***************************************************************************************************/
	
	  DECLARE crLista CURSOR FOR
      SELECT t.ID, t.Tarima, t.Zona, t.Clave, t.PosicionDestino, t.Mov, t.MovID
        FROM WMSMontacargaTarea t
        JOIN ListaID l ON t.IDLista = l.ID AND t.Estacion = l.Estacion
       WHERE t.Estacion = @Estacion
    ORDER BY t.Tarima
      OPEN crLista
      FETCH NEXT FROM crLista INTO @ID, @Tarima, @ZonaDetalle, @MovTipo, @PosicionDestino, @Mov, @MovID
      WHILE @@FETCH_STATUS = 0
      BEGIN
           --BUG5522
		   IF NULLIF(@PosicionDestino,'') IS NULL
             SELECT @Error = 20024, @ErrorRef='Es Necesario asignar la posicion destino, ' + @Mov + ' '+ @MovID
           
           IF @Error IS NULL
             EXEC spTareaAcomodadorValidaMovimiento @Empresa, @ID, @Tarima, @ZonaDetalle, @Montacargista, @MovTipo, @Error OUTPUT, @ErrorRef OUTPUT

      FETCH NEXT FROM crLista INTO @ID, @Tarima, @ZonaDetalle, @MovTipo, @PosicionDestino, @Mov, @MovID
      END
      CLOSE crLista
      DEALLOCATE crLista

   SELECT @Tipo = WMSTipoAcomodador FROM EmpresaCfg WHERE Empresa = @Empresa
   IF EXISTS(SELECT * FROM Agente WHERE Agente = @Montacargista AND Tipo = @Tipo) AND @Error IS NULL  --UserStory3623    
    UPDATE WMSMontacargaTarea SET Montacarga = @Montacargista WHERE Estacion = @Estacion AND IDLista IN(SELECT ID FROM ListaID WHERE Estacion = @Estacion)
  
  END
 --END
   --UserStory3623
   IF @Error IS NULL
     --SELECT 'Actualizadas Con Exito'    
     EXEC spWMSActualizarMontacargaTarea @Estacion
   
   SELECT ISNULL(@ErrorRef,'')

   RETURN 
END
GO

--REQ12615 WMS
--REQ12615 WMS
/************************************* spWMSSugerirMontacargaTarea ****************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spWMSSugerirMontacargaTarea') AND Type = 'P') DROP PROCEDURE dbo.spWMSSugerirMontacargaTarea
GO             
CREATE PROCEDURE spWMSSugerirMontacargaTarea
	@Estacion			int,
	@Empresa			char(5),
	@PorZona			bit,
	@AsignarPrioridad	char(5) --UserStory3623
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
	@Movimientos	int,
	@Agentes		int,
	@Numero			int,
	@Agente			varchar(20),
	@Pendientes		int,
	@Tipo			varchar(50),
	@Zona			varchar(50),
	@ID				int,
	@IDLista		int,

	--UserStory3623
	@WMSValidarZona			int,
	@ZonaAgente				varchar(30),
	@PesoMaximoMontaCarga	float,
	@PesoTarimaMovimiento	float, 
	@ValidaPeso				int,
	@Tarima					varchar(20),
	@ZonaDetalle			varchar(50),
	@Mov					varchar(20),
	@MovTipo				varchar(20),
    @Error					int=NULL,
	@ErrorRef				varchar(255)=NULL,
	@TipoMov				varchar(20),
	@Renglon				float,
	@Montacargista			varchar(20),
	@Sucursal				int,
	@Articulo				varchar(20)

	DECLARE @AgenteCantidad TABLE (Agente varchar(20), Cantidad int)
	DECLARE @ZonaCantidadAgentes TABLE (Zona varchar(30), Cantidad int)
	DECLARE @ZonaMovimientos TABLE (Zona varchar(30), Movimientos int)
	DECLARE @AgenteAsignado TABLE (Agente varchar(20), Zona varchar(30), Clave varchar(20),Orden int IDENTITY(1,1))
	
	DECLARE @AgentesZona TABLE (Agente varchar(20), Zona varchar(30), Orden int IDENTITY(1,1))
	
	IF NOT EXISTS(SELECT * FROM ListaID WHERE Estacion=@Estacion)
		BEGIN
			SELECT 'Favor de Seleccionar un Movimiento'
			RETURN
		END
  
	SELECT @Tipo = WMSTipoAcomodador, 
		   @WMSValidarZona=ISNULL(WMSValidarZona,0) 
	  FROM EmpresaCfg
	 WHERE Empresa = @Empresa


	--Por Zona
	IF @PorZona = 0
		BEGIN
			--IF @WMSValidarZona=1
				--BEGIN 
					--SELECT @Movimientos = ISNULL(COUNT(*),0) FROM WMSMontacargaTarea WHERE Estacion = @Estacion AND NULLIF(Zona,'')<>''
					--SELECT @Agentes = ISNULL(COUNT(*),0) FROM Agente WHERE Tipo = @Tipo AND Estatus = 'ALTA'
	  
			DECLARE crLista CURSOR FOR
			 SELECT ID
			   FROM ListaID
			  WHERE Estacion = @Estacion

			OPEN crLista
			FETCH NEXT FROM crLista INTO @IDLista
			WHILE @@FETCH_STATUS = 0
			
			BEGIN
				SET @Error=NULL
				SET @Montacargista = NULL
				
				SELECT @ID	    = ID,
					   @Renglon	= Renglon,
					   @Tarima  = Tarima,
					   @ZonaDetalle = Zona,
					   @MovTipo = Clave,
					   @Sucursal = Sucursal
				  FROM WMSMontacargaTarea 
				 WHERE IDLista = @IDLista 
				 
				 SELECT @Mov = Mov FROM MovTipo WHERE Clave = @MovTipo AND Modulo = 'TMA' 
					IF @MovTipo IN ('TMA.OADO', 'TMA.SADO', 'TMA.ADO')
						SELECT @TipoMov = Mov FROM MovTipo WHERE Clave = 'TMA.ADO' AND Modulo = 'TMA'
					ELSE
						IF @MovTipo IN ('TMA.ORADO', 'TMA.SRADO', 'TMA.RADO')
							SELECT @TipoMov = Mov FROM MovTipo WHERE Clave = 'TMA.RADO' AND Modulo = 'TMA'
						ELSE   
							IF @MovTipo IN ('TMA.OSUR', 'TMA.TSUR', 'TMA.SUR')
								SELECT @TipoMov = Mov FROM MovTipo WHERE Clave = 'TMA.SUR' AND Modulo = 'TMA' 
					
					
					DELETE FROM @AgentesZona
			
					INSERT @AgentesZona(Agente, Zona)
					SELECT A.Agente, B.Zona 
					  FROM Agente A
				 LEFT JOIN AgenteZona B
						ON A.Agente = B.Agente
					 WHERE A.SucursalEmpresa= @Sucursal
					   AND B.Zona = @ZonaDetalle
					   AND B.Tipo IN ('Acomodo','(Todos)')
					   AND A.Estatus = 'ALTA'
					   AND A.Tipo = @Tipo
				  ORDER BY B.Zona DESC, A.Agente ASC
				
				IF @Montacargista IS NULL
					BEGIN
						SELECT TOP 1 @Montacargista = Montacarga
						  FROM WMSMontacargaTarea A
						  JOIN @AgentesZona B
						    ON A.Montacarga = B.Agente
						 WHERE Sucursal = @Sucursal
						   AND A.Zona = @ZonaDetalle
						   AND A.IDLista < @IDLista
						   AND A.IDlISTA IN (SELECT ID FROM ListaID)
					  ORDER BY A.IDLista DESC
					END
				
				IF @Montacargista IS NOT NULL
					BEGIN
						IF EXISTS(SELECT TOP 1 A.Agente
									FROM @AgentesZona A
									JOIN @AgentesZona B
									  ON B.Agente = @Montacargista
									 AND A.Orden > B.Orden)
							BEGIN
								SELECT TOP 1 @Montacargista = A.Agente
								  FROM @AgentesZona A
								  JOIN @AgentesZona B
								    ON B.Agente = @Montacargista
								   AND A.Orden > B.Orden
							  ORDER BY A.Orden ASC
							END
						ELSE 
							SET @Montacargista = NULL
					END
					
				IF @Montacargista IS NULL
					BEGIN
						SELECT TOP 1 @Montacargista = Agente
						  FROM @AgentesZona 
					  ORDER BY Orden ASC
					END					
				
		IF @WMSValidarZona=1
			EXEC spTareaAcomodadorValidaMovimiento @Empresa, @ID, @Tarima, @ZonaDetalle, @Montacargista, @MovTipo, @Error OUTPUT, @ErrorRef OUTPUT

		IF @Error IS NULL
			BEGIN 
				UPDATE WMSMontacargaTarea SET Montacarga = @Montacargista, Modificar = 1 
				 WHERE IDLista=@IDLista 
			END
	   
			FETCH NEXT FROM crLista INTO @IDLista
		END
      
		CLOSE crLista
		DEALLOCATE crLista
	END --FinPorZona

	--Por Agente
	IF @PorZona = 1
	BEGIN 
		
		UPDATE WMSMontacargaTarea SET Montacarga = NULL
		 WHERE IDLista IN (SELECT ID FROM ListaID)
			
		DECLARE crLista CURSOR FOR
			SELECT t.ID,t.Renglon,t.Tarima,t.Zona,t.Clave,t.Sucursal, t.Articulo
			  FROM WMSMontacargaTarea t
			  JOIN ListaID l ON t.IDLista = l.ID AND t.Estacion = l.Estacion
			 WHERE t.Estacion = @Estacion
		  ORDER BY t.Tarima
		
		OPEN crLista
		FETCH NEXT FROM crLista INTO @ID, @Renglon, @Tarima, @ZonaDetalle, @MovTipo, @Sucursal, @Articulo
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @Error = NULL
			SET @Montacargista = NULL
			SET @IDLista = NULL
			
			DELETE FROM @AgentesZona
			
			INSERT @AgentesZona(Agente, Zona)
			SELECT A.Agente, B.Zona
			  FROM Agente A
			  JOIN AgenteZona B 
				ON A.Agente = B.Agente
			  JOIN ArtZona C 
				ON B.Zona = C.Zona 
			   AND C.Articulo = @Articulo
			 WHERE A.Estatus = 'ALTA'
			   AND B.Tipo IN ('Acomodo','(Todos)')
			   AND A.Tipo = @Tipo
			   AND A.SucursalEmpresa = @Sucursal
			   AND C.Zona = ISNULL(@ZonaDetalle,C.Zona)
		  ORDER BY C.Orden ASC
			
			INSERT @AgentesZona(Agente, Zona)
			SELECT A.Agente, B.Zona
			  FROM Agente A
		 LEFT JOIN AgenteZona B 
				ON A.Agente = B.Agente
			 WHERE A.Estatus = 'ALTA'
			   AND A.Tipo = @Tipo
			   AND A.SucursalEmpresa = @Sucursal
			   AND B.Zona IS NULL
			EXCEPT
			SELECT Agente, Zona
			  FROM @AgentesZona
			  
			SELECT TOP 1 @IDLista = A.IDLista , @Montacargista = Montacarga
			  FROM WMSMontacargaTarea A
			  JOIN @AgentesZona B
				ON A.Montacarga = B.Agente
			 WHERE Sucursal = @Sucursal
			   AND A.Zona = @ZonaDetalle
			   AND A.IDLista NOT IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion)
		  ORDER BY IDLista DESC
		  
		  	SELECT TOP 1 @IDLista = A.IDLista , @Montacargista = Montacarga
			  FROM WMSMontacargaTarea A
			  JOIN @AgentesZona B
				ON A.Montacarga = B.Agente
			 WHERE Sucursal = @Sucursal
			   AND A.Zona = @ZonaDetalle
			   AND A.IDLista IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion)
			   AND A.IDLista < (SELECT IDLista
								  FROM WMSMontacargaTarea 
								 WHERE ID       = @ID 
								   AND Renglon  = @Renglon
								   AND Tarima   = @Tarima
								   AND Estacion = @Estacion)
		  ORDER BY IDLista DESC
		  
		  
			IF @Montacargista IS NULL
				BEGIN
					SELECT TOP 1 @IDLista = A.IDLista , @Montacargista = Montacarga
					  FROM WMSMontacargaTarea A
					  JOIN @AgentesZona B
						ON A.Montacarga = B.Agente
					 WHERE Sucursal = @Sucursal
					   AND A.Zona <> @ZonaDetalle
					   AND B.Zona IS NOT NULL
                       AND A.Estacion = @Estacion
					   AND A.IDLista NOT IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion)
				  ORDER BY IDLista DESC
				END
			
			IF @Montacargista IS NULL
				BEGIN
					SELECT TOP 1 @Montacargista = Agente
					  FROM @AgentesZona 
				  ORDER BY Orden ASC
				END
			
			IF @IDLista	IS NOT NULL
				BEGIN
					IF EXISTS(SELECT TOP 1 A.Agente
								FROM @AgentesZona A
								JOIN @AgentesZona B
								  ON B.Agente = @Montacargista
								 AND A.Orden > B.Orden)
						BEGIN
							SELECT TOP 1 @Montacargista = NULLIF(A.Agente,'')
							  FROM @AgentesZona A
							  JOIN @AgentesZona B
								ON B.Agente = @Montacargista
							   AND A.Orden > B.Orden
						  ORDER BY A.Orden ASC
						END
					ELSE 
						SET @Montacargista = NULL
				END
					
			IF @Montacargista IS NULL
				BEGIN
					SELECT TOP 1 @Montacargista = Agente
					  FROM @AgentesZona 
				  ORDER BY Orden ASC
				END					

			IF @WMSValidarZona=1
				EXEC spTareaAcomodadorValidaMovimiento @Empresa, @ID, @Tarima, @ZonaDetalle, @Montacargista, @MovTipo, @Error OUTPUT, @ErrorRef OUTPUT
				--select @Montacargista, @Error

			IF @Error IS NULL
				UPDATE WMSMontacargaTarea SET Montacarga = @Montacargista, Modificar = 1 
				 WHERE ID=@ID AND Renglon = @Renglon AND ISNULL(PosicionDestino,'') <> ''
	         --SELECT 'xxx', * FROM WMSMontacargaTarea WHERE IDLista=@IDLista AND Zona = @ZonaAgente

			FETCH NEXT FROM crLista INTO @ID, @Renglon, @Tarima, @ZonaDetalle, @MovTipo, @Sucursal, @Articulo
		END
		
		CLOSE crLista
		DEALLOCATE crLista
	
	END--FinPorAgente
 
  IF @AsignarPrioridad='Si'
  BEGIN
      UPDATE WMSMontacargaTarea
         SET Prioridad = 'Normal'
       WHERE Estacion = @Estacion

      UPDATE WMSMontacargaTarea
         SET Prioridad = 'Alta'
        FROM WMSMontacargaTarea t
        JOIN ListaID l ON t.IDLista = l.ID AND t.Estacion = l.Estacion
       WHERE t.Estacion = @Estacion

  END
  
  IF @AsignarPrioridad='No'
  BEGIN
      UPDATE WMSMontacargaTarea
         SET Prioridad = 'Normal'
        FROM WMSMontacargaTarea t
        JOIN ListaID l ON t.IDLista = l.ID AND t.Estacion = l.Estacion
       WHERE t.Estacion = @Estacion

  END

  EXEC spWMSActualizarMontacargaTarea @Estacion --UserStory3623  

  RETURN
END
GO

--REQ12615 WMS
/************************************* spWMSActualizarMontacargaTarea ****************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spWMSActualizarMontacargaTarea') AND Type = 'P') 
DROP PROCEDURE dbo.spWMSActualizarMontacargaTarea
GO             
CREATE PROCEDURE spWMSActualizarMontacargaTarea
		@Estacion		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @IDLista		int,
    @ID				int,
    @Renglon		float,
    @Montacarga		varchar(20),
    @Prioridad		varchar(20),
    @SubClave		varchar(20),
	@PosicionDestino	varchar(10)
       
  DECLARE crLista CURSOR FOR
   SELECT ID
     FROM ListaID
    WHERE Estacion = @Estacion

  OPEN crLista
  FETCH NEXT FROM crLista INTO @IDLista
  WHILE @@FETCH_STATUS = 0
  BEGIN
    SELECT @ID			= ID, 
           @Renglon		= Renglon,
           @Montacarga	= Montacarga,
           @Prioridad	= Prioridad,
		   @PosicionDestino = PosicionDestino
      FROM WMSMontacargaTarea 
     WHERE IDLista = @IDLista

    UPDATE TMAD
       SET Montacarga	= @Montacarga,
           Prioridad	= @Prioridad,
		   PosicionDestino = @PosicionDestino
     WHERE ID = @ID
	   AND 1 = CASE WHEN (@Renglon = 0) OR (@Renglon <> 0 AND Renglon = @Renglon) THEN 1 ELSE 0 END

	--BUG2915 PGC24082015
	UPDATE TMA
	   SET Agente	= @Montacarga
	 WHERE ID = @ID
            
    FETCH NEXT FROM crLista INTO @IDLista
  END
  CLOSE crLista
  DEALLOCATE crLista

  --EXEC spWMSMontacargaTarea @Estacion, 0 --UserStory3623

  RETURN
END
GO

/************************************* spWMSActualizarMontacargaDetalle ****************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spWMSActualizarMontacargaDetalle') AND Type = 'P') 
DROP PROCEDURE dbo.spWMSActualizarMontacargaDetalle
GO             
CREATE PROCEDURE spWMSActualizarMontacargaDetalle
		@ID				int,
        @Montacarga		varchar(20)
--//WITH ENCRYPTION
AS BEGIN

    UPDATE TMAD SET Montacarga = @Montacarga 
     WHERE ID = @ID

  RETURN
END
GO

--REQ12615 WMS
/**************** spWMSPreparaLoteMovimiento ****************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'spWMSPreparaLoteMovimiento' AND type = 'P') DROP PROCEDURE spWMSPreparaLoteMovimiento
GO
CREATE PROCEDURE spWMSPreparaLoteMovimiento
    @Estacion	int,
    @Empresa	char(5)
--//WITH ENCRYPTION
AS BEGIN     
DECLARE 
	@Zona		varchar(50),
	@Fila		int,
	@Nivel		int,
	@Pasillo	int,
	@Articulo	varchar(20)

  SELECT @Zona		= CASE WHEN InfoZona = '(Todas)' THEN NULL ELSE InfoZona END,
         @Fila		= InfoFila,
         @Nivel		= InfoNivelWMS,
         @Pasillo	= InfoPasillo,
         @Articulo	= CASE WHEN RTRIM(LTRIM(InfoArticuloEsp)) = '' THEN NULL ELSE InfoArticuloEsp END
    FROM RepParam
   WHERE Estacion = @Estacion

  DELETE WMSLoteMovimiento WHERE Estacion = @Estacion        
  INSERT WMSLoteMovimiento (Estacion, ID, Empresa, Movimiento, FechaEmision, 
							Almacen, Tarima, Cantidad, PosicionOrigen, PosicionDestino, 
							Articulo, Descripcion, CantidadA, Zona, Pasillo, 
							Fila, Nivel, Mov, Clave, SubClave, 
							Renglon, SubCuenta, Montacarga, Acomodador)
  SELECT DISTINCT			@Estacion as Estacion, t.ID, t.Empresa, t.Mov + ' ' + ISNULL(t.MovID,'') as Movimiento, t.FechaEmision, 
							t.Almacen, d.Tarima, CASE WHEN m.SubClave IN('TMA.OSURP', 'TMA.TSURP') THEN ISNULL(NULLIF(d.CantidadPendiente,0),d.CantidadPicking) ELSE CASE WHEN ISNULL(d.Subcuenta,'') <> '' THEN o.Disponible ELSE a.Disponible END END as Cantidad, d.Posicion, d.PosicionDestino, 
							a.Articulo, art.Descripcion1, CASE WHEN m.SubClave IN('TMA.OSURP', 'TMA.TSURP') THEN ISNULL(NULLIF(d.CantidadPendiente,0),d.CantidadPicking) ELSE 1 END as CantidadA, d.Zona, p.Pasillo, 
							p.Fila, p.Nivel, t.Mov, m.Clave, m.SubClave, 
							d.Renglon, d.SubCuenta, t.Montacarga, t.Agente
    FROM TMA t
    JOIN TMAD d ON t.ID = d.ID
    JOIN ArtDisponibleTarima a ON d.Tarima = a.Tarima AND d.Articulo=a.Articulo
	LEFT JOIN ArtSubDisponibleTarima o ON d.Tarima = o.Tarima AND d.Articulo = o.Articulo AND ISNULL(d.SubCuenta,'') = ISNULL(o.SubCuenta,'') --BUG3799 --BUG3001
    JOIN Art art ON a.Articulo = art.Articulo
    JOIN MovTipo m ON t.Mov = m.Mov AND m.Modulo = 'TMA'
    JOIN AlmPos p ON d.Posicion = p.Posicion
   WHERE t.Estatus IN('PENDIENTE')
     AND d.EstaPendiente  = 1
     AND ISNULL(p.Zona,'') = ISNULL(@Zona, ISNULL(p.Zona,''))
     AND ISNULL(p.Fila,'') = ISNULL(@Fila, ISNULL(p.Fila,''))
     AND ISNULL(p.Nivel,'') = ISNULL(@Nivel, ISNULL(p.Nivel,''))
     AND ISNULL(p.Pasillo,'') = ISNULL(@Pasillo, ISNULL(p.Pasillo,''))
     AND ISNULL(art.Articulo,'') = ISNULL(@Articulo, ISNULL(art.Articulo,''))
END  
GO

--REQ12615 WMS
/**************** spWMSGeneraLoteMovimiento ****************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'spWMSGeneraLoteMovimiento' AND type = 'P') DROP PROCEDURE spWMSGeneraLoteMovimiento
GO
CREATE PROCEDURE spWMSGeneraLoteMovimiento
    @Estacion	int,
    @Empresa	char(5)
--//WITH ENCRYPTION
AS BEGIN
DECLARE
	    @IDLista			int,
	    @ID					int,
	    @Clave				varchar(20),
	    @SubClave			varchar(20),
	    @Tarima				varchar(20),
	    @CantidadA			float,
	    @Renglon			float,
	    @Ok					int,
	    @OkRef				varchar(255),
	    @Mov				varchar(20),
	    @IDGenerar			int,
	    @Usuario			varchar(20),
	    @Agente				varchar(20),
	    @Montacarga			varchar(20),
	    @IDGenerar2			int,
        @Articulo           varchar(20), 
        @Almacen            varchar(10), 
        @SubCuenta          varchar(50),
        @PosicionDestino	varchar(20),
        @PosicionDestinoO   varchar(20)
  
  BEGIN TRANSACTION  
    DECLARE crListaSt CURSOR FOR
     SELECT DISTINCT IDLista, ID, Clave, SubClave, Tarima, CantidadA, Renglon, Acomodador, Montacarga, Articulo, Almacen, SubCuenta
       FROM WMSLoteMovimiento 
      WHERE IDLista IN(SELECT Clave FROM ListaSt WHERE Estacion = @Estacion)
    
    OPEN crListaSt
    FETCH NEXT FROM crListaSt INTO @IDLista, @ID, @Clave, @SubClave, @Tarima, @CantidadA, @Renglon, @Agente, @Montacarga, @Articulo, @Almacen, @SubCuenta
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN
                 
      IF @Clave = 'TMA.SADO'
        SELECT @Mov = TMAOrdenAcomodo FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa
                
      IF @Clave = 'TMA.OADO'
        SELECT @Mov = TMAAcomodo FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa
      
      IF @Clave = 'TMA.SRADO'
        SELECT @Mov = TMAOrdenReacomodo FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa
      
      IF @Clave = 'TMA.ORADO'
        SELECT @Mov = TMAReacomodo FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa
      
      IF @Clave = 'TMA.OSUR'
        IF @SubClave = 'TMA.OSURP'
          SELECT @Mov = TMASurtidoTransitoPCK FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa
        ELSE
          SELECT @Mov = TMASurtidoTransito FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa
      
      IF @Clave = 'TMA.TSUR'
        SELECT @Mov = TMASurtido FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa
	  
	  IF @Clave = 'TMA.OPCKTARIMA'
        SELECT @Mov = TMAPCKTarimaTransito FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa
        
      IF NULLIF(@Agente,'') IS NULL AND @Ok IS NULL
        SELECT @Ok = 20930

      IF NULLIF(@Montacarga,'') IS NULL AND @Ok IS NULL
        SELECT @Ok = 20919

      IF NULLIF(@Mov,'') IS NULL AND @Ok IS NULL
        SELECT @Ok = 55130

      IF NOT EXISTS(SELECT * FROM Agente WHERE Agente = @Agente) AND @Ok IS NULL SET @Ok = 26090

      IF NOT EXISTS(SELECT * FROM Montacarga WHERE Montacarga = @Montacarga) AND @Ok IS NULL SELECT @Ok = 20936
      
      IF @Ok IS NULL
      BEGIN
        UPDATE TMAD SET CantidadA = @CantidadA WHERE ID = @ID AND Tarima = @Tarima AND Renglon = @Renglon
        
        UPDATE TMA 
           SET Agente		= @Agente,
               Montacarga	= @Montacarga 
         WHERE ID = @ID
        
	    UPDATE TMAD
		   SET CantidadA = @CantidadA 
	     WHERE ID		= @ID
		   AND Renglon	= @Renglon
		   AND Tarima	= @Tarima

	    UPDATE TMAD
		   SET CantidadA = NULL
	     WHERE ID		= @ID
		   AND Renglon	<> @Renglon
		   AND Tarima	<> @Tarima
      END
      
      IF @Clave IN('TMA.SADO', 'TMA.SRADO', 'TMA.OADO', 'TMA.ORADO', 'TMA.ADO', 'TMA.RADO') AND @Ok IS NULL
      BEGIN

        IF @Clave IN('TMA.SADO', 'TMA.SRADO') AND @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
		BEGIN
          EXEC @IDGenerar =  spAfectar 'TMA', @ID, 'GENERAR', 'Seleccion', @Mov, @Usuario, @Estacion,@EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT , @OkRef = @OkRef OUTPUT

				SELECT @PosicionDestinoO = ISNULL(PosicionDestino,'') 
				  FROM TMAD 
				 WHERE ID = @IDGenerar 
				   AND Renglon = @Renglon
                
				IF @PosicionDestinoO = ''
                BEGIN
                   SELECT @PosicionDestino = dbo.fnTMAUbicacionDisponible(@Empresa, @Almacen, @Articulo, @IDGenerar, @Tarima, ISNULL(@SubCuenta,'')) 

                   UPDATE TMAD 
                      SET PosicionDestino = ISNULL(@PosicionDestino,'')
                    WHERE ID = @IDGenerar 
					  AND Renglon = @Renglon
                END
		END
        ELSE 
          SELECT @IDGenerar = @ID

        IF @Clave IN('TMA.SADO', 'TMA.SRADO') AND @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
          EXEC spAfectar 'TMA', @IDGenerar, 'AFECTAR', 'TODO', NULL, @Usuario, @Estacion,@EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT , @OkRef = @OkRef OUTPUT

        IF @Clave = 'TMA.SADO'
          SELECT @Mov = TMAAcomodo FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa
        ELSE
        IF @Clave = 'TMA.SRADO'
          SELECT @Mov = TMAReacomodo FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa

	    UPDATE TMAD
		   SET CantidadA = @CantidadA 
	     WHERE ID		= @IDGenerar
		   AND Renglon	= @Renglon
		   AND Tarima	= @Tarima

        IF @Clave IN('TMA.SADO', 'TMA.SRADO', 'TMA.OADO', 'TMA.ORADO') AND @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
          EXEC @IDGenerar2 =  spAfectar 'TMA', @IDGenerar, 'GENERAR', 'Seleccion', @Mov, @Usuario, @Estacion,@EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT , @OkRef = @OkRef OUTPUT
          
        IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
          EXEC spAfectar 'TMA', @IDGenerar2, 'AFECTAR', 'TODO', NULL, @Usuario, @Estacion,@EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT , @OkRef = @OkRef OUTPUT          
      END
	  ELSE
      IF @Clave IN('TMA.OSUR', 'TMA.TSUR') AND @Ok IS NULL
      BEGIN
	          
        IF @Clave IN('TMA.OSUR') AND @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
          EXEC @IDGenerar =  spAfectar 'TMA', @ID, 'GENERAR', 'Seleccion', @Mov, @Usuario, @Estacion,@EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT , @OkRef = @OkRef OUTPUT
        ELSE 
          SELECT @IDGenerar = @ID
                    
        IF @Clave IN('TMA.OSUR') AND @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000  AND @SubClave NOT IN('TMA.OSURP')
          EXEC spAfectar 'TMA', @IDGenerar, 'AFECTAR', 'TODO', NULL, @Usuario, @Estacion,@EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT , @OkRef = @OkRef OUTPUT

        IF @Clave = 'TMA.OSUR'
          SELECT @Mov = TMASurtido FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa

	    UPDATE TMAD
		   SET CantidadA = @CantidadA 
	     WHERE ID		= @IDGenerar
		   AND Renglon	= @Renglon
		   AND Tarima	= @Tarima
                  
        IF @Clave IN('TMA.OSUR', 'TMA.TSUR') AND @SubClave NOT IN('TMA.OSURP') AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
          EXEC @IDGenerar2 =  spAfectar 'TMA', @IDGenerar, 'GENERAR', 'Seleccion', @Mov, @Usuario, @Estacion,@EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT , @OkRef = @OkRef OUTPUT
 
        IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000) AND @SubClave NOT IN('TMA.OSURP') 
          EXEC spAfectar 'TMA', @IDGenerar2, 'AFECTAR', 'TODO', NULL, @Usuario, @Estacion,@EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT , @OkRef = @OkRef OUTPUT          
      END
    
	  IF @Clave IN ('TMA.OPCKTARIMA')
		BEGIN
			EXEC @IDGenerar2 = spAfectar 'TMA', @ID, 'GENERAR', 'Seleccion', @Mov, @Usuario, @Estacion, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT , @OkRef = @OkRef OUTPUT
			IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
				EXEC spAfectar 'TMA', @IDGenerar2, 'AFECTAR', 'TODO', NULL, @Usuario, @Estacion, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT , @OkRef = @OkRef OUTPUT
				IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
					BEGIN
						SELECT @Clave = Clave FROM MovTipo A JOIN TMA B ON A.Modulo = 'TMA' AND A.Mov = B.Mov WHERE B.ID = @IDGenerar2
						IF @Clave = 'TMA.PCKTARIMATRAN'
						BEGIN
							SELECT @Mov = TmaPCKTarima FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa
							EXEC @IDGenerar2 = spAfectar 'TMA', @IDGenerar2, 'GENERAR', 'Pendiente', @Mov, @Usuario, @Estacion, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT , @OkRef = @OkRef OUTPUT
							IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
								EXEC spAfectar 'TMA', @IDGenerar2, 'AFECTAR', 'TODO', NULL, @Usuario, @Estacion, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT , @OkRef = @OkRef OUTPUT
						END
					END
		END
    
      IF @Ok BETWEEN 80030 AND 81000
        SELECT @Ok = NULL
              
      FETCH NEXT FROM crListaSt INTO @IDLista, @ID, @Clave, @SubClave, @Tarima, @CantidadA, @Renglon, @Agente, @Montacarga, @Articulo, @Almacen, @SubCuenta
    END
    CLOSE crListaSt
    DEALLOCATE crListaSt

  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
  BEGIN
    SELECT 'Proceso Terminado'
    SELECT @OkRef = NULL
    EXEC spWMSPreparaLoteMovimiento @Estacion, @Empresa
    COMMIT TRANSACTION
  END
  ELSE
  BEGIN
    EXEC spEliminarMov 'TMA', @IDGenerar
    SELECT @OkRef = LTRIM(RTRIM(ISNULL(@OkRef, '')))+ ' ' + Descripcion FROM MensajeLista WHERE Mensaje = @Ok
    IF @Ok = 20934 
      SELECT @OkRef + ' ' + @Agente
    ELSE
      SELECT 'Error - ' + CONVERT(varchar, @Ok) + '<BR><BR>' + @OkRef
    ROLLBACK TRANSACTION
  END    
  RETURN
END  
GO

--REQ12615 WMS
/**************** spWMSDesentarimadoAfectar *****************/
if exists (select * from sysobjects where id = object_id('dbo.spWMSDesentarimadoAfectar') and type = 'P') drop procedure dbo.spWMSDesentarimadoAfectar
GO
CREATE PROCEDURE spWMSDesentarimadoAfectar  
		@IDGenerar			int,
		@Ok					int          OUTPUT,
		@OkRef				varchar(255) OUTPUT
					
--//WITH ENCRYPTION  
AS BEGIN   
  DECLARE
	@Empresa			char(5),
	@Usuario			varchar(20),
	@Almacen			varchar(20),
    @Sucursal			int,
    @MovOrigen			varchar(20),
    @MovIDOrigen		varchar(20),
    @IDOrdenEntarimado	int,
    @MovEntarimado		varchar(20),
    @IDEntarimado		int,
    @IDSolAcomodo		int
      
  SELECT @Empresa  =  Empresa,
         @Usuario  =  Usuario,
         @Almacen  =  Almacen,
         @Sucursal =  Sucursal
    FROM Inv
   WHERE ID = @IDGenerar

  IF @Ok IS NULL AND @IDGenerar IS NOT NULL
    EXEC spAfectar 'INV', @IDGenerar, 'AFECTAR', 'Todo', @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
  
  SELECT @MovOrigen		= Mov,
         @MovIDOrigen	= MovID
    FROM Inv 
   WHERE ID = @IDGenerar

  SELECT @IDOrdenEntarimado = ID FROM  Inv WHERE Origen = @MovOrigen AND OrigenID = @MovIDOrigen AND Empresa = @Empresa  
  SELECT @MovEntarimado = InvEntarimado FROM EmpresaCfgMov WHERE Empresa = @Empresa
  
  IF @Ok IS NULL AND @IDOrdenEntarimado IS NOT NULL AND @MovEntarimado IS NOT NULL
    EXEC @IDEntarimado = spAfectar 'INV', @IDOrdenEntarimado, 'GENERAR', 'Pendiente', @MovEntarimado, @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    
  UPDATE SerieLoteMov SET RenglonID = RenglonID + 1 WHERE Modulo = 'INV' AND ID = @IDEntarimado AND Empresa = @Empresa

  IF @Ok IN(NULL, 80030) AND @IDEntarimado IS NOT NULL
    EXEC spAfectar 'INV', @IDEntarimado, 'AFECTAR', 'Todo', @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

  SELECT @MovOrigen		= Mov,
         @MovIDOrigen	= MovID
    FROM Inv 
   WHERE ID = @IDEntarimado

  SELECT @IDSolAcomodo = ID FROM TMA WHERE Origen = @MovOrigen AND OrigenID = @MovIDOrigen AND Empresa = @Empresa
  
  RETURN  
END  
GO

--REQ12615 WMS
/**************** spWMSDesentarimadoGenerar *****************/
if exists (select * from sysobjects where id = object_id('dbo.spWMSDesentarimadoGenerar') and type = 'P') drop procedure dbo.spWMSDesentarimadoGenerar
GO
CREATE PROCEDURE spWMSDesentarimadoGenerar  
		@ID					int,
		@Tarima				varchar(20),
		@PCK				float,
		@Articulo			varchar(20),
		@CantidadAfectar	float,
		@RenglonWMS			int,
		@TarimaWMS			varchar(20),
		@IDGenerar			int				OUTPUT,
		@Ok					int				OUTPUT,
		@OkRef				varchar(255)	OUTPUT
					
--//WITH ENCRYPTION  
AS BEGIN   
  DECLARE  
	@Empresa			char(5),
	@Usuario			varchar(20),
    @MovGenerar			varchar(20),
	@Almacen			varchar(20),
    @Sucursal			int,
    @Renglon			int,
    @RenglonSub			int,
    @RenglonID			int,
    @Moneda				varchar(20),
    @Unidad				varchar(50),
    @Posicion			varchar(10)
    
  SELECT @Empresa  =  Empresa,
         @Usuario  =  Usuario,
         @Almacen  =  Almacen,
         @Sucursal =  Sucursal
    FROM TMA
   WHERE ID = @ID
   
   SELECT @Posicion = DefPosicionRecibo FROM Alm WHERE Almacen = @Almacen   
   SELECT @Moneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa
   SELECT @Unidad = Unidad FROM Art WHERE Articulo = @Articulo
   SELECT @MovGenerar = InvDesentarimado FROM EmpresaCfgMov WHERE Empresa = @Empresa

   IF @IDGenerar IS NULL
   BEGIN
     INSERT Inv (
               Empresa,  Sucursal,  Mov,         Almacen,  FechaEmision,                  Usuario,  Estatus,      AlmacenDestino, Moneda,  TipoCambio, PosicionWMS)
      SELECT   @Empresa, @Sucursal, @MovGenerar, @Almacen, dbo.fnFechaSinHora(GETDATE()), @Usuario, 'SINAFECTAR', @Almacen,       @Moneda, 1, @Posicion
      IF @@ERROR <> 0 SET @Ok = 1
      SELECT @IDGenerar = @@IDENTITY
    END

    IF @IDGenerar IS NOT NULL
    BEGIN
      SELECT @Renglon    = ISNULL(MAX(Renglon),0) + 2048,
             @RenglonSub = ISNULL(MAX(RenglonSub),0) + 1,
             @RenglonID  = ISNULL(MAX(RenglonID),0) + 1
        FROM InvD 
       WHERE ID = @IDGenerar
       
      INSERT InvD (
               ID,         Renglon,  RenglonSub,  RenglonID,  Sucursal,  Almacen,    Articulo,  Cantidad,         CantidadInventario, Tarima,  Unidad)
      SELECT   @IDGenerar, @Renglon, @RenglonSub, @RenglonID, @Sucursal, @Almacen,   @Articulo, @CantidadAfectar, @CantidadAfectar,	 @Tarima, @Unidad
	  IF @@ERROR <> 0 SET @Ok = 1
      
      UPDATE TMAD 
         SET CantidadPicking	= ISNULL(NULLIF(CantidadPicking - @CantidadAfectar,0),@CantidadAfectar),
             CantidadPendiente	= NULLIF(CantidadPendiente,0) - @CantidadAfectar
       WHERE ID = @ID 
         AND Tarima = @TarimaWMS
         AND Renglon = @RenglonWMS
    END
  RETURN
END
GO

--REQ12615 WMS
/**************** spWMSSurtidoPerdidoGenerar *****************/
if exists (select * from sysobjects where id = object_id('dbo.spWMSSurtidoPerdidoGenerar') and type = 'P') drop procedure dbo.spWMSSurtidoPerdidoGenerar
GO
CREATE PROCEDURE spWMSSurtidoPerdidoGenerar  
		@ID					int,
		@Tarima				varchar(20),
		@PCK				float,
		@Cantidad			float,
		@Renglon			int,
		@Ok					int            OUTPUT,
		@OkRef				varchar(255)   OUTPUT
					
--//WITH ENCRYPTION  
AS BEGIN   
  DECLARE  
	@Empresa				char(5),
	@Usuario				varchar(20),
	@Sucursal				int,
    @IDGenerar				int,
    @MovGenerar				varchar(20),
    @CantidadAnterior		float,
    @CantidadResurtir		float,
    @IDGenerarResurtido		int,
    @FechaRegistro			datetime

  SELECT @Empresa			= Empresa,
         @Usuario			= Usuario,
         @Sucursal			= Sucursal,
         @FechaRegistro		= dbo.fnFechaSinHora(GETDATE()),
         @CantidadResurtir	= 0
    FROM TMA
   WHERE ID = @ID
    
  IF @PCK = 0
  BEGIN
    SELECT @CantidadAnterior = ISNULL(NULLIF(CantidadPendiente,0), CantidadPicking) FROM TMAD WHERE ID = @ID AND Tarima = @Tarima AND Renglon = @Renglon
    SELECT @CantidadResurtir = @CantidadAnterior - @Cantidad
    UPDATE TMAD SET CantidadA = 1 WHERE ID = @ID AND Tarima = @Tarima AND Renglon = @Renglon
  END
  ELSE
  IF @PCK = 1
    UPDATE TMAD SET CantidadA = @Cantidad WHERE ID = @ID AND Tarima = @Tarima AND Renglon = @Renglon

  SELECT @MovGenerar = TMASurtidoPerdido FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa

  IF @OK IS NULL
    EXEC @IDGenerar = spAfectar 'TMA', @ID, 'GENERAR', 'Seleccion', @MovGenerar, @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
          
  IF @Ok = 80030
    SELECT @OK = NULL
          
  IF @OK IS NULL
    EXEC spAfectar 'TMA', @IDGenerar, 'AFECTAR', 'Todo', @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

  IF @OK IS NULL AND @CantidadResurtir > 0
  BEGIN
    EXEC @IDGenerarResurtido = spMovCopiar @Sucursal, 'TMA', @ID, @Usuario, @FechaRegistro, 1
    UPDATE TMAD SET Tarima = @Tarima, CantidadPicking = @CantidadResurtir WHERE ID = @IDGenerarResurtido AND Renglon = @Renglon
    EXEC spAfectar 'TMA', @IDGenerarResurtido, 'AFECTAR', 'Todo', @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
  END
  RETURN  
END  
GO

--REQ12615 WMS
/**************** spWMSResurtidoArticulo *****************/
if exists (select * from sysobjects where id = object_id('dbo.spWMSResurtidoArticulo') and type = 'P') drop procedure dbo.spWMSResurtidoArticulo
GO
CREATE PROCEDURE spWMSResurtidoArticulo
		@Tarima					varchar(20),
		@Articulo				varchar(20),
		@CantidadACancelar		int,
		@Ok						int				OUTPUT,
		@OkRef					varchar(255)	OUTPUT
						
--//WITH ENCRYPTION  
AS BEGIN   
  DECLARE  
    @ID					int,
    @Tipo				int,
    @PCK				float,
    @WMSTarima			varchar(20),
    @CantidadAfectar	float,
    @IDGenerar			int,
    @MovGenerar			varchar(20),
    @WMSRenglon			int
        
  DECLARE crResurtidoArticulo CURSOR LOCAL FOR
   SELECT ID, Articulo, Tipo, Tarima, PCK, CantidadAfectar, Renglon
     FROM dbo.fnWMSEnSurtidoACancelar(@Tarima, @Articulo, @CantidadACancelar)
    ORDER BY Tipo, Cantidad

  OPEN crResurtidoArticulo
  FETCH NEXT FROM crResurtidoArticulo INTO @ID, @Articulo, @Tipo, @WMSTarima, @PCK, @CantidadAfectar, @WMSRenglon
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
    IF @Tipo = 1
      EXEC spWMSSurtidoPerdidoGenerar @ID, @WMSTarima, @PCK, @CantidadAfectar, @WMSRenglon, @Ok OUTPUT, @OkRef OUTPUT          
    ELSE
    IF @Tipo = 2
      EXEC spWMSDesentarimadoGenerar @ID, @Tarima, @PCK, @Articulo, @CantidadAfectar, @WMSRenglon, @WMSTarima, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    ELSE
    IF @Tipo = 3
      SELECT @Ok = 20939

    FETCH NEXT FROM crResurtidoArticulo INTO @ID, @Articulo, @Tipo, @WMSTarima, @PCK, @CantidadAfectar, @WMSRenglon
  END  
  CLOSE crResurtidoArticulo
  DEALLOCATE crResurtidoArticulo

  IF @IDGenerar IS NOT NULL AND @Ok IS NULL
    EXEC spWMSDesentarimadoAfectar @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT

  RETURN  
END  
GO

--REQ12615 WMS
/**************** spWMSResurtirTarima *****************/
if exists (select * from sysobjects where id = object_id('dbo.spWMSResurtirTarima') and type = 'P') drop procedure dbo.spWMSResurtirTarima
GO
CREATE PROCEDURE spWMSResurtirTarima
		@Tarima				varchar(20),
		@Ok					int	= NULL	OUTPUT,
		@OkRef				varchar(255) = NULL	OUTPUT
				
--//WITH ENCRYPTION  
AS BEGIN   
  DECLARE  
	@Articulo				varchar(20),
	@CantidadACancelar		int
    
  DECLARE crResurtirTarima CURSOR LOCAL FOR
   SELECT Articulo, Cantidad
     FROM dbo.fnWMSEnSurtidoACancelarPorArticulo(@Tarima)

  OPEN crResurtirTarima
  FETCH NEXT FROM crResurtirTarima INTO @Articulo, @CantidadACancelar
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
  
    EXEC spWMSResurtidoArticulo @Tarima, @Articulo, @CantidadACancelar, @Ok OUTPUT, @OkRef OUTPUT

    FETCH NEXT FROM crResurtirTarima INTO @Articulo, @CantidadACancelar
  END  
  CLOSE crResurtirTarima
  DEALLOCATE crResurtirTarima
    
  RETURN  
END  
GO

--REQ12615 WMS
/**************** spWMSResurtir *****************/
if exists (select * from sysobjects where id = object_id('dbo.spWMSResurtir') and type = 'P') drop procedure dbo.spWMSResurtir
GO
CREATE PROCEDURE spWMSResurtir
		@Estacion		int,
		@Empresa		char(5)
				
--//WITH ENCRYPTION  
AS BEGIN   
  DECLARE  
	@Ok			int,
	@OkRef		varchar(255),
	@Tarima		varchar(20)

  SET @Ok = NULL
  SET @OkRef = NULL
  SET @Tarima = NULL

  BEGIN TRANSACTION

  DECLARE crTarima CURSOR FOR  
   SELECT DISTINCT Tarima 
     FROM (
     SELECT d.Tarima FROM Venta v  JOIN VentaD d  ON v.ID = d.ID WHERE v.Mov + ' ' + v.MovID IN(SELECT Clave FROM ListaSt WHERE Estacion = @Estacion) AND v.Empresa = @Empresa AND NULLIF(d.Tarima,'') IS NOT NULL UNION
     SELECT d.Tarima FROM Compra v JOIN CompraD d ON v.ID = d.ID WHERE v.Mov + ' ' + v.MovID IN(SELECT Clave FROM ListaSt WHERE Estacion = @Estacion) AND v.Empresa = @Empresa AND NULLIF(d.Tarima,'') IS NOT NULL UNION
     SELECT d.Tarima FROM Inv v    JOIN InvD d    ON v.ID = d.ID WHERE v.Mov + ' ' + v.MovID IN(SELECT Clave FROM ListaSt WHERE Estacion = @Estacion) AND v.Empresa = @Empresa AND NULLIF(d.Tarima,'') IS NOT NULL UNION
     SELECT d.Tarima FROM Prod v   JOIN ProdD d   ON v.ID = d.ID WHERE v.Mov + ' ' + v.MovID IN(SELECT Clave FROM ListaSt WHERE Estacion = @Estacion) AND v.Empresa = @Empresa AND NULLIF(d.Tarima,'') IS NOT NULL
          ) X
  OPEN crTarima  
  FETCH NEXT FROM crTarima INTO @Tarima
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN      
    EXEC spWMSResurtirTarima @Tarima, @Ok OUTPUT, @OkRef OUTPUT

    FETCH NEXT FROM crTarima INTO @Tarima
  END  
  CLOSE crTarima  
  DEALLOCATE crTarima

  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
  BEGIN
    COMMIT TRANSACTION
    SELECT 'Proceso terminado'
  END
  ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT @OkRef = 'Error ' + CONVERT(varchar,@Ok) + '<BR><BR>' + Descripcion + '<BR><BR>' + 'Tarima ' + @Tarima FROM MensajeLista WHERE Mensaje = @Ok
    SELECT @OkRef
  END    
  RETURN  
END  
GO

--REQ12615 WMS
/************** spWMSDividirPorReservado ***************/
if exists (select * from sysobjects where id = object_id('dbo.spWMSDividirPorReservado') and type = 'P') drop procedure dbo.spWMSDividirPorReservado
GO
CREATE PROCEDURE spWMSDividirPorReservado  
                        @ModuloID       int,  
                        @Modulo         char(5),  
						@Empresa        char(5),   
						@Articulo       char(20),  
						@SubCuenta      varchar(50),  
						@Almacen        char(10),  
						@Cantidad       float,  
						@Tarima         varchar(20),  
						@Usuario        varchar(10),  
						@Estacion       int,  
						@Ok             int OUTPUT,  
						@OkRef          varchar(255)OUTPUT  
  
--//WITH ENCRYPTION  
AS BEGIN  
  -- SET nocount ON  
  DECLARE  
    @ID                 int,  
    @Renglon            float,  
    @RenglonSub			int,  
    @Requiere			float,  
    @Obtenido           float,  
    @Pendiente          float,  
    @Procesado          bit,
    @Unidad				varchar(50),
    @Factor				float
  
  SELECT @Requiere = @Cantidad, @SubCuenta = NULLIF(RTRIM(@SubCuenta), ''), @Procesado = 0
  IF @Modulo = 'VTAS'
    DECLARE crDividirPorReservado CURSOR FOR
     SELECT Venta.ID, VentaD.Renglon, VentaD.RenglonSub, ISNULL(VentaD.CantidadPendiente, 0.0), VentaD.Unidad, VentaD.Factor
       FROM VentaD, Venta
      WHERE Venta.Estatus = 'PENDIENTE'
        AND Venta.ID = @ModuloID
        AND VentaD.ID = Venta.ID  
        AND VentaD.Almacen = @Almacen
        AND VentaD.Articulo = @Articulo
        AND VentaD.SubCuenta = @SubCuenta
        AND NULLIF(VentaD.Tarima,'') IS NULL
        AND ISNULL(VentaD.CantidadPendiente, 0.0) > 0 --REQ 14684
      ORDER BY Venta.ID, VentaD.Renglon, VentaD.RenglonSub
  ELSE
  IF @Modulo = 'INV'
    DECLARE crDividirPorReservado CURSOR FOR
     SELECT Inv.ID, InvD.Renglon, InvD.RenglonSub, ISNULL(InvD.CantidadPendiente, 0.0), InvD.Unidad, InvD.Factor
       FROM InvD, Inv
      WHERE Inv.Estatus = 'PENDIENTE'
        AND Inv.ID = @ModuloID
        AND InvD.ID = Inv.ID
        AND InvD.Almacen = @Almacen
        AND InvD.Articulo = @Articulo
        AND InvD.SubCuenta = @SubCuenta
        AND NULLIF(InvD.Tarima,'') IS NULL
        AND ISNULL(InvD.CantidadPendiente, 0.0) > 0 --REQ 14684
      ORDER BY Inv.ID, InvD.Renglon, InvD.RenglonSub
  ELSE
  IF @Modulo = 'COMS'
    DECLARE crDividirPorReservado CURSOR FOR
     SELECT Compra.ID, CompraD.Renglon, CompraD.RenglonSub, ISNULL(CompraD.CantidadPendiente, 0.0), CompraD.Unidad, CompraD.Factor
       FROM CompraD, Compra
      WHERE Compra.Estatus = 'PENDIENTE'
        AND Compra.ID = @ModuloID
        AND CompraD.ID = Compra.ID
        AND CompraD.Almacen = @Almacen
        AND CompraD.Articulo = @Articulo
        AND CompraD.SubCuenta = @SubCuenta
        AND NULLIF(CompraD.Tarima,'') IS NULL
        AND ISNULL(CompraD.CantidadPendiente, 0.0) > 0 --REQ 14684
      ORDER BY Compra.ID, CompraD.Renglon, CompraD.RenglonSub
      
  OPEN crDividirPorReservado
  FETCH NEXT FROM crDividirPorReservado INTO @ID, @Renglon, @RenglonSub, @Pendiente, @Unidad, @Factor
  IF @@ERROR <> 0 SELECT @Ok = 1
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2
    BEGIN
      SELECT @Obtenido = @Requiere/ @Factor
      IF @Modulo = 'VTAS'  
      BEGIN  
        IF (OBJECT_ID('Tempdb..#VentaDetalle')) IS NOT NULL
          DROP TABLE #VentaDetalle

        UPDATE VentaD SET Cantidad = Cantidad - @Obtenido, CantidadPendiente = CantidadPendiente - @Obtenido, CantidadInventario = CantidadInventario - @Requiere WHERE CURRENT OF crDividirPorReservado  
        IF @@ERROR <> 0 SELECT @Ok = 1  
  
        SELECT * INTO #VentaDetalle FROM cVentaDWMS WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub   
        IF @@ERROR <> 0 SELECT @Ok = 1  
  		  
		SET @RenglonSub = ISNULL(@RenglonSub, 0)
        SELECT @RenglonSub = @RenglonSub + MAX(RenglonSub)+1 FROM VentaD WHERE ID = @ID AND Renglon = @Renglon  
        IF @@ERROR <> 0 SELECT @Ok = 1  

        UPDATE #VentaDetalle SET Cantidad = @Obtenido, CantidadInventario = @Requiere, CantidadPendiente = @Obtenido, Almacen = @Almacen, RenglonSub = @RenglonSub, CantidadReservada = 0
        IF @@ERROR <> 0 SELECT @Ok = 1  
  
        UPDATE #VentaDetalle SET DescuentoImporte = (Cantidad*Costo)*(DescuentoLinea/100.0)  
        IF @@ERROR <> 0 SELECT @Ok = 1  
  
        UPDATE #VentaDetalle SET CantidadPendiente = Cantidad, CantidadA = 0  
        IF @@ERROR <> 0 SELECT @Ok = 1  
  
        UPDATE VentaD SET CantidadPendiente = ISNULL(Cantidad,0), CantidadReservada = 0, CantidadA = 0 WHERE CURRENT OF crDividirPorReservado  
        IF @@ERROR <> 0 SELECT @Ok = 1  

        INSERT INTO #WMSVentaDR
        SELECT * FROM #VentaDetalle
        IF @@ERROR <> 0 SELECT @Ok = 1

        DELETE VentaD WHERE Cantidad = 0 AND ID = @ModuloID
        IF @@ERROR <> 0 SELECT @Ok = 1

        UPDATE VentaD SET CantidadA = @Obtenido, CantidadReservada = 0 WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
        IF @@ERROR <> 0 SELECT @Ok = 1
  
        SELECT @Procesado = 1
      END  
      ELSE  
      IF @Modulo = 'INV'  
      BEGIN  
        IF (OBJECT_ID('Tempdb..#InvDetalle')) IS NOT NULL
          DROP TABLE #InvDetalle

        UPDATE InvD SET Cantidad = Cantidad - @Obtenido, CantidadPendiente = CantidadPendiente - @Obtenido, CantidadInventario = CantidadInventario - @Requiere WHERE CURRENT OF crDividirPorReservado  
        IF @@ERROR <> 0 SELECT @Ok = 1  

        SELECT * INTO #InvDetalle FROM cInvDWMS WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
        IF @@ERROR <> 0 SELECT @Ok = 1  
  
        SELECT @RenglonSub = MAX(RenglonSub)+1 FROM InvD WHERE ID = @ID AND Renglon = @Renglon  
        IF @@ERROR <> 0 SELECT @Ok = 1  
    
        UPDATE #InvDetalle SET Cantidad = @Obtenido, CantidadInventario = @Requiere, CantidadPendiente = @Obtenido, Almacen = @Almacen, RenglonSub = @RenglonSub, CantidadReservada = 0
        IF @@ERROR <> 0 SELECT @Ok = 1  
              
        UPDATE #InvDetalle SET CantidadPendiente = Cantidad, CantidadA = 0  
        IF @@ERROR <> 0 SELECT @Ok = 1  
  
        UPDATE InvD SET CantidadPendiente = ISNULL(Cantidad,0), CantidadReservada = 0, CantidadA = 0 WHERE CURRENT OF crDividirPorReservado  
        IF @@ERROR <> 0 SELECT @Ok = 1  
  
        INSERT INTO #WMSInvDR
        SELECT * FROM #InvDetalle
        IF @@ERROR <> 0 SELECT @Ok = 1

        DELETE InvD WHERE Cantidad = 0 AND ID = @ModuloID
        IF @@ERROR <> 0 SELECT @Ok = 1
            
        UPDATE InvD SET CantidadA = CantidadPendiente, CantidadReservada = 0 WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
        IF @@ERROR <> 0 SELECT @Ok = 1
                              
        SELECT @Procesado = 1
      END
      ELSE  
      IF @Modulo = 'COMS'  
      BEGIN  
        IF (OBJECT_ID('Tempdb..#ComsDetalle')) IS NOT NULL
          DROP TABLE #ComsDetalle

        UPDATE CompraD SET Cantidad = Cantidad - @Obtenido, CantidadPendiente = CantidadPendiente - @Obtenido, CantidadInventario = CantidadInventario - @Requiere WHERE CURRENT OF crDividirPorReservado  
        IF @@ERROR <> 0 SELECT @Ok = 1  

        SELECT * INTO #ComsDetalle FROM cCompraD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
        IF @@ERROR <> 0 SELECT @Ok = 1  
  
        SELECT @RenglonSub = MAX(RenglonSub)+1 FROM CompraD WHERE ID = @ID AND Renglon = @Renglon  
        IF @@ERROR <> 0 SELECT @Ok = 1  
    
        UPDATE #ComsDetalle SET Cantidad = @Obtenido, CantidadInventario = @Requiere, CantidadPendiente = @Obtenido, Almacen = @Almacen, RenglonSub = @RenglonSub
        IF @@ERROR <> 0 SELECT @Ok = 1  
              
        UPDATE #ComsDetalle SET CantidadPendiente = Cantidad, CantidadA = 0  
        IF @@ERROR <> 0 SELECT @Ok = 1  
  
        UPDATE CompraD SET CantidadPendiente = ISNULL(Cantidad,0), CantidadA = 0 WHERE CURRENT OF crDividirPorReservado  
        IF @@ERROR <> 0 SELECT @Ok = 1  
  
        INSERT INTO #WMSComsDR
        SELECT * FROM #ComsDetalle
        IF @@ERROR <> 0 SELECT @Ok = 1

        DELETE CompraD WHERE Cantidad = 0 AND ID = @ModuloID
        IF @@ERROR <> 0 SELECT @Ok = 1
            
        UPDATE CompraD SET CantidadA = CantidadPendiente WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
        IF @@ERROR <> 0 SELECT @Ok = 1
                              
        SELECT @Procesado = 1
      END

      SELECT @Requiere = @Requiere - @Obtenido  
    END  
  
    FETCH NEXT FROM crDividirPorReservado INTO @ID, @Renglon, @RenglonSub, @Pendiente, @Unidad, @Factor
    IF @@ERROR <> 0 SELECT @Ok = 1  
  END  
  CLOSE crDividirPorReservado  
  DEALLOCATE crDividirPorReservado  
  
  IF @Procesado = 0  
  BEGIN  
    IF @Modulo = 'VTAS'  
      UPDATE VentaD SET Tarima = @Tarima WHERE ID = @ModuloID AND NULLIF(Tarima,'') IS NULL AND ISNULL(CantidadReservada,0) > 0
    ELSE  
    IF @Modulo = 'INV'  
      UPDATE InvD SET Tarima = @Tarima WHERE ID = @ModuloID AND NULLIF(Tarima,'') IS NULL AND ISNULL(CantidadReservada,0) > 0
  END  
--  IF @Modulo = 'COMS'  
--    UPDATE CompraD SET Tarima = @Tarima WHERE ID = @ModuloID AND NULLIF(Tarima,'') IS NULL
  RETURN
END
GO

--REQ12615 WMS
/************** spWMSInsertarPorReservado ***************/
if exists (select * from sysobjects where id = object_id('dbo.spWMSInsertarPorReservado') and type = 'P') drop procedure dbo.spWMSInsertarPorReservado
GO
CREATE PROCEDURE spWMSInsertarPorReservado  
                        @Estacion       int,						
						@TarimaSurtido	varchar(20),
						@Usuario        varchar(10),
						@Ok             int OUTPUT,
						@OkRef          varchar(255)OUTPUT
                          
--//WITH ENCRYPTION  
AS BEGIN  
  -- SET nocount ON  
  DECLARE  
    @ID						int,
    @Articulo				varchar(20),
    @Cantidad				float,
    @Renglon				float,
    @RenglonSub				int,
    @Modulo					char(5),
    @Unidad					varchar(50),
    @Factor					float,
    @CantidadInventario		float

  DECLARE crInsertarPorReservado CURSOR FOR  
   SELECT 'VTAS', ID, Articulo, SUM(Cantidad), Renglon, RenglonSub, Unidad, Factor
     FROM #WMSVentaDR
    GROUP BY ID, Articulo, Renglon, RenglonSub, Unidad, Factor
    UNION
   SELECT 'INV', ID, Articulo, SUM(Cantidad), Renglon, RenglonSub, Unidad, Factor
     FROM #WMSInvDR
    GROUP BY ID, Articulo, Renglon, RenglonSub, Unidad, Factor
    UNION
   SELECT 'COMS', ID, Articulo, SUM(Cantidad), Renglon, RenglonSub, Unidad, Factor
     FROM #WMSComsDR
    GROUP BY ID, Articulo, Renglon, RenglonSub, Unidad, Factor

  OPEN crInsertarPorReservado  
  FETCH NEXT FROM crInsertarPorReservado INTO @Modulo, @ID, @Articulo, @Cantidad, @Renglon, @RenglonSub, @Unidad, @Factor
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN      
    SELECT @CantidadInventario = @Cantidad*@Factor

    IF @Modulo = 'VTAS'
    BEGIN
      UPDATE #WMSVentaDR SET Cantidad = @Cantidad, CantidadA = @Cantidad, CantidadPendiente = @Cantidad, CantidadInventario = @CantidadInventario WHERE ID = @ID AND Articulo = @Articulo AND Renglon = @Renglon AND RenglonSub = @RenglonSub
      INSERT INTO cVentaDWMS(ID,Renglon,RenglonSub,RenglonID,RenglonTipo,Cantidad,Almacen,EnviarA,Codigo,Articulo,SubCuenta,Precio,PrecioSugerido,DescuentoTipo,DescuentoLinea,DescuentoImporte,Impuesto1,Impuesto2,Impuesto3,DescripcionExtra,Costo,CostoActividad,Paquete,ContUso,ContUso2,ContUso3,Aplica,AplicaID,CantidadPendiente,CantidadReservada,CantidadCancelada,CantidadOrdenada,CantidadObsequio,CantidadA,Unidad,Factor,CantidadInventario,SustitutoArticulo,SustitutoSubCuenta,FechaRequerida,HoraRequerida,Instruccion,UltimoReservadoCantidad,UltimoReservadoFecha,Agente,Departamento,Sucursal,SucursalOrigen,AutoLocalidad,UEN,Espacio,CantidadAlterna,PoliticaPrecios,PrecioMoneda,PrecioTipoCambio,AFArticulo,AFSerie,ExcluirPlaneacion,Anexo,Estado,ExcluirISAN,Posicion,PresupuestoEsp,ProveedorRef,TransferirA,Tarima,ABC,TipoImpuesto1,TipoImpuesto2,TipoImpuesto3,OrdenCompra,AnticipoFacturado,AnticipoMoneda,AnticipoTipoCambio,AnticipoRetencion)
      SELECT TOP 1 ID,Renglon,RenglonSub,RenglonID,RenglonTipo,Cantidad,Almacen,EnviarA,Codigo,Articulo,SubCuenta,Precio,PrecioSugerido,DescuentoTipo,DescuentoLinea,DescuentoImporte,Impuesto1,Impuesto2,Impuesto3,DescripcionExtra,Costo,CostoActividad,Paquete,ContUso,ContUso2,ContUso3,Aplica,AplicaID,CantidadPendiente,CantidadReservada,CantidadCancelada,CantidadOrdenada,CantidadObsequio,CantidadA,Unidad,Factor,CantidadInventario,SustitutoArticulo,SustitutoSubCuenta,FechaRequerida,HoraRequerida,Instruccion,UltimoReservadoCantidad,UltimoReservadoFecha,Agente,Departamento,Sucursal,SucursalOrigen,AutoLocalidad,UEN,Espacio,CantidadAlterna,PoliticaPrecios,PrecioMoneda,PrecioTipoCambio,AFArticulo,AFSerie,ExcluirPlaneacion,Anexo,Estado,ExcluirISAN,Posicion,PresupuestoEsp,ProveedorRef,TransferirA,Tarima,ABC,TipoImpuesto1,TipoImpuesto2,TipoImpuesto3,OrdenCompra,AnticipoFacturado,AnticipoMoneda,AnticipoTipoCambio,AnticipoRetencion 
        FROM #WMSVentaDR 
       WHERE ID = @ID AND Articulo = @Articulo AND Renglon = @Renglon AND Renglon = @Renglon AND RenglonSub = @RenglonSub
      DELETE #WMSVentaDR WHERE ID = @ID AND Articulo = @Articulo AND Renglon = @Renglon AND Renglon = @Renglon AND RenglonSub = @RenglonSub
    END
    ELSE    
    IF @Modulo = 'INV'
    BEGIN
      SELECT TOP 1 @Renglon = Renglon, @RenglonSub = RenglonSub FROM #WMSInvDR WHERE ID = @ID AND Articulo = @Articulo AND Renglon = @Renglon AND RenglonSub = @RenglonSub ORDER BY Renglon, RenglonSub
      UPDATE #WMSInvDR SET Cantidad = @Cantidad, CantidadA = @Cantidad, CantidadPendiente = @Cantidad, CantidadInventario = @CantidadInventario WHERE ID = @ID AND Articulo = @Articulo AND Renglon = @Renglon AND RenglonSub = @RenglonSub
      INSERT INTO cInvDWMS (ID,Renglon,RenglonSub,RenglonID,RenglonTipo,Cantidad,Almacen,Codigo,Articulo,SubCuenta,ArticuloDestino,SubCuentaDestino,Costo,CostoInv,ContUso,Espacio,CantidadReservada,CantidadCancelada,CantidadOrdenada,CantidadPendiente,CantidadA,Paquete,FechaRequerida,Aplica,AplicaID,DestinoTipo,Destino,DestinoID,Cliente,Unidad,Factor,CantidadInventario,UltimoReservadoCantidad,UltimoReservadoFecha,ProdSerieLote,Merma,Desperdicio,Producto,SubProducto,Tipo,Sucursal,SucursalOrigen,Precio,DescripcionExtra,Posicion,Tarima,Seccion,FechaCaducidad) 
      SELECT TOP 1 ID,Renglon,RenglonSub,RenglonID,RenglonTipo,Cantidad,Almacen,Codigo,Articulo,SubCuenta,ArticuloDestino,SubCuentaDestino,Costo,CostoInv,ContUso,Espacio,CantidadReservada,CantidadCancelada,CantidadOrdenada,CantidadPendiente,CantidadA,Paquete,FechaRequerida,Aplica,AplicaID,DestinoTipo,Destino,DestinoID,Cliente,Unidad,Factor,CantidadInventario,UltimoReservadoCantidad,UltimoReservadoFecha,ProdSerieLote,Merma,Desperdicio,Producto,SubProducto,Tipo,Sucursal,SucursalOrigen,Precio,DescripcionExtra,Posicion,Tarima,Seccion,FechaCaducidad
        FROM #WMSInvDR 
       WHERE ID = @ID AND Articulo = @Articulo AND Renglon = @Renglon AND Renglon = @Renglon AND RenglonSub = @RenglonSub
      DELETE #WMSInvDR WHERE ID = @ID AND Articulo = @Articulo AND Renglon = @Renglon AND Renglon = @Renglon AND RenglonSub = @RenglonSub
    END
    ELSE    
    IF @Modulo = 'COMS'
    BEGIN
      SELECT TOP 1 @Renglon = Renglon, @RenglonSub = RenglonSub FROM #WMSComsDR WHERE ID = @ID AND Articulo = @Articulo AND Renglon = @Renglon AND RenglonSub = @RenglonSub ORDER BY Renglon, RenglonSub
      UPDATE #WMSComsDR SET Cantidad = @Cantidad, CantidadA = @Cantidad, CantidadPendiente = @Cantidad, CantidadInventario = @CantidadInventario WHERE ID = @ID AND Articulo = @Articulo AND Renglon = @Renglon AND RenglonSub = @RenglonSub
      --Bug 22628
      INSERT INTO cCompraD(ID,Renglon,RenglonSub,RenglonID,RenglonTipo,Cantidad,Almacen,Codigo,Articulo,SubCuenta,FechaRequerida,FechaOrdenar,FechaEntrega,CostoConImpuesto,Costo,Impuesto1,Impuesto2,Impuesto3,Impuesto5,Retencion1,Retencion2,Retencion3,Descuento,DescuentoTipo,DescuentoLinea,DescuentoImporte,DescripcionExtra,ReferenciaExtra,ContUso,ContUso2,ContUso3,ClavePresupuestal,DestinoTipo,Destino,DestinoID,Aplica,AplicaID,CantidadPendiente,CantidadCancelada,CantidadA,CostoInv,Unidad,Factor,CantidadInventario,Cliente,ServicioArticulo,ServicioSerie,Paquete,Sucursal,SucursalOrigen,ImportacionProveedor,ImportacionReferencia,ProveedorRef,AgenteRef,FechaCaducidad,Posicion,Pais,TratadoComercial,ProgramaSectorial,ValorAduana,ImportacionImpuesto1,ImportacionImpuesto2,ID1,ID2,FormaPago,EsEstadistica,PresupuestoEsp,Tarima,EmpresaRef,Categoria,ABC,TipoImpuesto1,TipoImpuesto2,TipoImpuesto3,TipoImpuesto4,TipoImpuesto5,TipoRetencion1,TipoRetencion2,TipoRetencion3) 
      SELECT TOP 1 ID,Renglon,RenglonSub,RenglonID,RenglonTipo,Cantidad,Almacen,Codigo,Articulo,SubCuenta,FechaRequerida,FechaOrdenar,FechaEntrega,CostoConImpuesto,Costo,Impuesto1,Impuesto2,Impuesto3,Impuesto5,Retencion1,Retencion2,Retencion3,Descuento,DescuentoTipo,DescuentoLinea,DescuentoImporte,DescripcionExtra,ReferenciaExtra,ContUso,ContUso2,ContUso3,ClavePresupuestal,DestinoTipo,Destino,DestinoID,Aplica,AplicaID,CantidadPendiente,CantidadCancelada,CantidadA,CostoInv,Unidad,Factor,CantidadInventario,Cliente,ServicioArticulo,ServicioSerie,Paquete,Sucursal,SucursalOrigen,ImportacionProveedor,ImportacionReferencia,ProveedorRef,AgenteRef,FechaCaducidad,Posicion,Pais,TratadoComercial,ProgramaSectorial,ValorAduana,ImportacionImpuesto1,ImportacionImpuesto2,ID1,ID2,FormaPago,EsEstadistica,PresupuestoEsp,Tarima,EmpresaRef,Categoria,ABC,TipoImpuesto1,TipoImpuesto2,TipoImpuesto3,TipoImpuesto4,TipoImpuesto5,TipoRetencion1,TipoRetencion2,TipoRetencion3 
        FROM #WMSComsDR 
       WHERE ID = @ID AND Articulo = @Articulo AND Renglon = @Renglon AND Renglon = @Renglon AND RenglonSub = @RenglonSub
      DELETE #WMSComsDR WHERE ID = @ID AND Articulo = @Articulo AND Renglon = @Renglon AND Renglon = @Renglon AND RenglonSub = @RenglonSub
    END

    IF @Ok IS NULL AND @Modulo IN ('INV', 'VTAS')  
      EXEC spAfectar @Modulo, @ID, 'RESERVAR', 'Seleccion', NULL, @Usuario, @Estacion, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT , @OkRef = @OkRef OUTPUT  
    
    IF @Modulo = 'VTAS'
      UPDATE VentaD SET Tarima = @TarimaSurtido WHERE ID = @ID AND Articulo = @Articulo AND CantidadReservada > 0 AND Renglon = ISNULL(@Renglon,Renglon) AND NULLIF(Tarima,'') IS NULL
    ELSE
    IF @Modulo = 'INV'
      UPDATE InvD SET Tarima = @TarimaSurtido WHERE ID = @ID AND Articulo = @Articulo AND CantidadReservada > 0 AND Renglon = ISNULL(@Renglon,Renglon) AND NULLIF(Tarima,'') IS NULL
    ELSE
    IF @Modulo = 'COMS'
      UPDATE CompraD SET Tarima = @TarimaSurtido WHERE ID = @ID AND Articulo = @Articulo AND Renglon = ISNULL(@Renglon,Renglon) AND NULLIF(Tarima,'') IS NULL

    FETCH NEXT FROM crInsertarPorReservado INTO @Modulo, @ID, @Articulo, @Cantidad, @Renglon, @RenglonSub, @Unidad, @Factor
  END  
  CLOSE crInsertarPorReservado  
  DEALLOCATE crInsertarPorReservado  
  RETURN
END  
GO

--TASK24685
--BUG24562
/**************** spTMAArtListaSt ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTMAArtListaSt') and type = 'P') drop procedure dbo.spTMAArtListaSt
GO
CREATE PROC spTMAArtListaSt
			@EstacionTrabajo		int
--//WITH ENCRYPTION
AS
BEGIN
  DELETE ListaSt WHERE Estacion = @EstacionTrabajo
  
  INSERT INTO ListaSt(Estacion, Clave) SELECT DISTINCT @EstacionTrabajo, Articulo FROM WMSSurtidoProcesarD WHERE Estacion = @EstacionTrabajo AND Procesado = 0
END
GO

--TASK24685
/**************** spWMSDividirPorReservadoPck ****************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'spWMSDividirPorReservadoPck' AND type = 'P') DROP PROCEDURE spWMSDividirPorReservadoPck
GO
CREATE PROCEDURE spWMSDividirPorReservadoPck
                        @ModuloID       int,  
                        @Modulo         char(5),  
						@Empresa        char(5),   
						@Articulo       char(20),  
						@SubCuenta      varchar(50),  
						@Almacen        char(10),  
						@Cantidad       float,  
						@Tarima         varchar(20),  
						@Usuario        varchar(10),  
						@Estacion       int,
                        @RenglonWMS		float,
				        @RenglonSubWMS	int,
						@Ok             int OUTPUT,  
						@OkRef          varchar(255)OUTPUT  
--//WITH ENCRYPTION  
AS BEGIN  
  -- SET nocount ON  
  DECLARE  
    @ID                 int,  
    @Renglon            float,  
    @RenglonID          int, 
    @cRenglonID          int, 
    @RenglonSub			int,  
    @Requiere			float,  
    @Obtenido           float,  
    @Pendiente          float,  
    @Procesado          bit,
    @Unidad				varchar(50),
    @Factor				float,
	@CantidadTotal		float,
    @Estatus			varchar(15),
    @cRenglon           float

  SELECT @Requiere = @Cantidad, @SubCuenta = NULLIF(RTRIM(@SubCuenta), ''), @Procesado = 0  
	
  IF @Modulo = 'VTAS'  
  BEGIN
    SELECT @CantidadTotal = SUM(CantidadPendiente*Factor)
      FROM VentaD, Venta  
     WHERE Venta.Estatus = 'PENDIENTE'  
       AND Venta.ID = @ModuloID  
       AND VentaD.ID = Venta.ID  
       AND VentaD.Almacen = @Almacen  
       AND VentaD.Articulo = @Articulo  
       AND VentaD.SubCuenta = @SubCuenta  
       AND ISNULL(VentaD.CantidadPendiente, 0.0) > 0 --REQ 14684
       AND NULLIF(VentaD.Tarima,'') IS NULL
 
    IF @CantidadTotal <= @Cantidad
    BEGIN
      UPDATE VentaD
         SET Tarima = @Tarima
        FROM VentaD, Venta  
       WHERE Venta.Estatus = 'PENDIENTE'  
         AND Venta.ID = @ModuloID  
         AND VentaD.ID = Venta.ID  
         AND VentaD.Almacen = @Almacen  
         AND VentaD.Articulo = @Articulo  
         AND VentaD.SubCuenta = @SubCuenta  
         AND ISNULL(VentaD.CantidadPendiente, 0.0) > 0 --REQ 14684
         AND NULLIF(VentaD.Tarima,'') IS NULL

	IF NOT EXISTS (SELECT * FROM SerieLoteMov WHERE ID = @ModuloID AND Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'') AND Modulo = @Modulo AND Empresa = @Empresa AND Tarima = @Tarima)
	  INSERT SerieLoteMov(Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, CantidadAlterna, Propiedades,
						  Ubicacion, Cliente, Localizacion, Sucursal, ArtCostoInv, Tarima, AsignacionUbicacion)
				   SELECT slm.Empresa, slm.Modulo, slm.ID, slm.RenglonID, slm.Articulo, slm.SubCuenta, slm.SerieLote, SUM(slm.Cantidad), NULLIF(SUM(ISNULL(slm.CantidadAlterna,0)),0), slm.Propiedades, 
						  slm.Ubicacion, slm.Cliente, slm.Localizacion, slm.Sucursal, slm.ArtCostoInv, VentaD.Tarima, slm.AsignacionUbicacion
					 FROM SerieLoteMov slm, VentaD, Venta
				    WHERE Venta.Estatus = 'PENDIENTE'  
					  AND Venta.ID = @ModuloID  
					  AND VentaD.ID = Venta.ID  
					  AND VentaD.Almacen = @Almacen  
					  AND VentaD.Articulo = @Articulo  
					  AND VentaD.SubCuenta = @SubCuenta  
					  AND ISNULL(VentaD.CantidadPendiente, 0.0) > 0
					  AND slm.Empresa = @Empresa
					  AND slm.Modulo = @Modulo
					  AND slm.ID = Venta.ID
					  AND VentaD.Articulo = slm.Articulo
					  AND ISNULL(VentaD.SubCuenta,'') = ISNULL(slm.SubCuenta,'')
					  AND VentaD.RenglonID = slm.RenglonID
					  AND VentaD.Tarima = @Tarima
				 GROUP BY slm.Empresa, slm.Modulo, slm.ID, slm.RenglonID, slm.Articulo, slm.SubCuenta, slm.SerieLote, slm.Propiedades, 
						  slm.Ubicacion, slm.Cliente, slm.Localizacion, slm.Sucursal, slm.ArtCostoInv, VentaD.Tarima, slm.AsignacionUbicacion    
		
		IF @@ROWCOUNT <> 0
			DELETE SerieLoteMov 
			 WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ModuloID AND Tarima <> @Tarima AND Articulo = @Articulo							  
			   AND Tarima NOT IN(SELECT Tarima FROM VentaD WHERE ID = @ModuloID AND Articulo = @Articulo AND Renglon = @RenglonWMS)
         
	END
    DECLARE crDividirPorReservado CURSOR FOR  
     SELECT Venta.ID, VentaD.Renglon, VentaD.RenglonSub, ISNULL(VentaD.CantidadPendiente, 0.0), VentaD.Unidad, VentaD.Factor, VentaD.RenglonID
       FROM VentaD, Venta  
      WHERE Venta.Estatus = 'PENDIENTE'  
        AND Venta.ID = @ModuloID  
        AND VentaD.ID = Venta.ID  
        AND VentaD.Almacen = @Almacen  
        AND VentaD.Articulo = @Articulo  
        AND VentaD.SubCuenta = @SubCuenta  
		AND ISNULL(VentaD.CantidadPendiente, 0.0) > 0 --REQ 14684
        AND NULLIF(VentaD.Tarima,'') IS NULL
      ORDER BY Venta.ID, VentaD.Renglon, VentaD.RenglonSub  
  END
  ELSE  
  IF @Modulo = 'INV'  
  BEGIN
    SELECT @CantidadTotal = SUM(CantidadPendiente*Factor)
      FROM InvD, Inv  
     WHERE Inv.Estatus = 'PENDIENTE'  
       AND Inv.ID = @ModuloID  
       AND InvD.ID = Inv.ID  
       AND InvD.Almacen = @Almacen  
       AND InvD.Articulo = @Articulo  
       AND InvD.SubCuenta = @SubCuenta  
       AND ISNULL(InvD.CantidadPendiente, 0.0) > 0 --REQ 14684
       AND NULLIF(InvD.Tarima,'') IS NULL
    IF @CantidadTotal <= @Cantidad
    BEGIN
      UPDATE InvD
         SET Tarima = @Tarima
        FROM InvD, Inv  
       WHERE Inv.Estatus = 'PENDIENTE'  
         AND Inv.ID = @ModuloID  
         AND InvD.ID = Inv.ID  
         AND InvD.Almacen = @Almacen  
         AND InvD.Articulo = @Articulo  
         AND InvD.SubCuenta = @SubCuenta  
         AND ISNULL(InvD.CantidadPendiente, 0.0) > 0 --REQ 14684
         AND NULLIF(InvD.Tarima,'') IS NULL

	IF NOT EXISTS (SELECT * FROM SerieLoteMov WHERE ID = @ModuloID AND Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'') AND Modulo = @Modulo AND Empresa = @Empresa AND Tarima = @Tarima)
	  INSERT SerieLoteMov(Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, CantidadAlterna, Propiedades,
						  Ubicacion, Cliente, Localizacion, Sucursal, ArtCostoInv, Tarima, AsignacionUbicacion)
				   SELECT slm.Empresa, slm.Modulo, slm.ID, slm.RenglonID, slm.Articulo, slm.SubCuenta, slm.SerieLote, SUM(slm.Cantidad), NULLIF(SUM(ISNULL(slm.CantidadAlterna,0)),0), slm.Propiedades, 
						  slm.Ubicacion, slm.Cliente, slm.Localizacion, slm.Sucursal, slm.ArtCostoInv, InvD.Tarima, slm.AsignacionUbicacion
					 FROM SerieLoteMov slm, InvD, Inv
				    WHERE Inv.Estatus = 'PENDIENTE'  
					  AND Inv.ID = @ModuloID  
					  AND InvD.ID = Inv.ID  
					  AND InvD.Almacen = @Almacen  
					  AND InvD.Articulo = @Articulo  
					  AND InvD.SubCuenta = @SubCuenta  
					  AND ISNULL(InvD.CantidadPendiente, 0.0) > 0
					  AND slm.Empresa = @Empresa
					  AND slm.Modulo = @Modulo
					  AND slm.ID = Inv.ID
					  AND InvD.Articulo = slm.Articulo
					  AND ISNULL(InvD.SubCuenta,'') = ISNULL(slm.SubCuenta,'')
					  AND InvD.RenglonID = slm.RenglonID
					  AND InvD.Tarima = @Tarima
				 GROUP BY slm.Empresa, slm.Modulo, slm.ID, slm.RenglonID, slm.Articulo, slm.SubCuenta, slm.SerieLote, slm.Propiedades, 
						  slm.Ubicacion, slm.Cliente, slm.Localizacion, slm.Sucursal, slm.ArtCostoInv, InvD.Tarima, slm.AsignacionUbicacion
	IF @@ROWCOUNT <> 0
	  DELETE SerieLoteMov 
	   WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ModuloID AND Tarima <> @Tarima AND Articulo = @Articulo
		 AND Tarima NOT IN(SELECT Tarima FROM InvD WHERE ID = @ModuloID AND Articulo = @Articulo AND Renglon = @RenglonWMS)

	END
    DECLARE crDividirPorReservado CURSOR FOR  
     SELECT Inv.ID, InvD.Renglon, InvD.RenglonSub, ISNULL(InvD.CantidadPendiente, 0.0), InvD.Unidad, InvD.Factor, InvD.RenglonID
       FROM InvD, Inv  
      WHERE Inv.Estatus = 'PENDIENTE'  
        AND Inv.ID = @ModuloID  
        AND InvD.ID = Inv.ID  
        AND InvD.Almacen = @Almacen  
        AND InvD.Articulo = @Articulo  
        AND InvD.SubCuenta = @SubCuenta  
		AND ISNULL(InvD.CantidadPendiente, 0.0) > 0 --REQ 14684
        AND NULLIF(InvD.Tarima,'') IS NULL
      ORDER BY Inv.ID, InvD.Renglon, InvD.RenglonSub  
  END
  ELSE  
  IF @Modulo = 'COMS'  
  BEGIN
    SELECT @CantidadTotal = SUM(CantidadPendiente*Factor)
      FROM CompraD, Compra  
     WHERE Compra.Estatus = 'PENDIENTE'  
       AND Compra.ID = @ModuloID  
       AND CompraD.ID = Compra.ID  
       AND CompraD.Almacen = @Almacen  
       AND CompraD.Articulo = @Articulo  
       AND CompraD.SubCuenta = @SubCuenta  
       AND ISNULL(CompraD.CantidadPendiente, 0.0) > 0 --REQ 14684
       AND NULLIF(CompraD.Tarima,'') IS NULL
 
    IF @CantidadTotal <= @Cantidad
    BEGIN
      UPDATE CompraD
         SET Tarima = @Tarima
        FROM CompraD, Compra  
       WHERE Compra.Estatus = 'PENDIENTE'  
         AND Compra.ID = @ModuloID  
         AND CompraD.ID = Compra.ID  
         AND CompraD.Almacen = @Almacen  
         AND CompraD.Articulo = @Articulo  
         AND CompraD.SubCuenta = @SubCuenta  
         AND ISNULL(CompraD.CantidadPendiente, 0.0) > 0 --REQ 14684
         AND NULLIF(CompraD.Tarima,'') IS NULL

	IF NOT EXISTS (SELECT * FROM SerieLoteMov WHERE ID = @ModuloID AND Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'') AND Modulo = @Modulo AND Empresa = @Empresa AND Tarima = @Tarima)
	  INSERT SerieLoteMov(Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, CantidadAlterna, Propiedades,
						  Ubicacion, Cliente, Localizacion, Sucursal, ArtCostoInv, Tarima, AsignacionUbicacion)
				   SELECT slm.Empresa, slm.Modulo, slm.ID, slm.RenglonID, slm.Articulo, slm.SubCuenta, slm.SerieLote, SUM(slm.Cantidad), NULLIF(SUM(ISNULL(slm.CantidadAlterna,0)),0), slm.Propiedades, 
						  slm.Ubicacion, slm.Cliente, slm.Localizacion, slm.Sucursal, slm.ArtCostoInv, CompraD.Tarima, slm.AsignacionUbicacion
					 FROM SerieLoteMov slm, CompraD, Compra
				    WHERE Compra.Estatus = 'PENDIENTE'  
					  AND Compra.ID = @ModuloID  
					  AND CompraD.ID = Compra.ID  
					  AND CompraD.Almacen = @Almacen  
					  AND CompraD.Articulo = @Articulo  
					  AND CompraD.SubCuenta = @SubCuenta  
					  AND ISNULL(CompraD.CantidadPendiente, 0.0) > 0
					  AND slm.Empresa = @Empresa
					  AND slm.Modulo = @Modulo
					  AND slm.ID = Compra.ID
					  AND CompraD.Articulo = slm.Articulo
					  AND ISNULL(CompraD.SubCuenta,'') = ISNULL(slm.SubCuenta,'')
					  AND CompraD.RenglonID = slm.RenglonID
					  AND CompraD.Tarima = @Tarima
				 GROUP BY slm.Empresa, slm.Modulo, slm.ID, slm.RenglonID, slm.Articulo, slm.SubCuenta, slm.SerieLote, slm.Propiedades, 
						  slm.Ubicacion, slm.Cliente, slm.Localizacion, slm.Sucursal, slm.ArtCostoInv, CompraD.Tarima, slm.AsignacionUbicacion
	IF @@ROWCOUNT <> 0
	  DELETE SerieLoteMov 
	   WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ModuloID AND Tarima <> @Tarima AND Articulo = @Articulo
	     AND Tarima NOT IN(SELECT Tarima FROM CompraD WHERE ID = @ModuloID AND Articulo = @Articulo AND Renglon = @RenglonWMS)
         
	END
    DECLARE crDividirPorReservado CURSOR FOR  
     SELECT Compra.ID, CompraD.Renglon, CompraD.RenglonSub, ISNULL(CompraD.CantidadPendiente, 0.0), CompraD.Unidad, CompraD.Factor, CompraD.RenglonID
       FROM CompraD, Compra
      WHERE Compra.Estatus = 'PENDIENTE'  
        AND Compra.ID = @ModuloID  
        AND CompraD.ID = Compra.ID  
        AND CompraD.Almacen = @Almacen  
        AND CompraD.Articulo = @Articulo  
        AND CompraD.SubCuenta = @SubCuenta  
		AND ISNULL(CompraD.CantidadPendiente, 0.0) > 0 --REQ 14684
        AND NULLIF(CompraD.Tarima,'') IS NULL
      ORDER BY Compra.ID, CompraD.Renglon, CompraD.RenglonSub  

  END
  OPEN crDividirPorReservado  
  FETCH NEXT FROM crDividirPorReservado INTO @ID, @Renglon, @RenglonSub, @Pendiente, @Unidad, @Factor, @RenglonID
  IF @@ERROR <> 0 SELECT @Ok = 1  
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2   
    BEGIN  
      IF 1=1
      BEGIN
        IF @Modulo = 'VTAS'  
        BEGIN  
          IF (OBJECT_ID('Tempdb..#VentaDetalle')) IS NOT NULL
            DROP TABLE #VentaDetalle

            IF @Cantidad IS NOT NULL AND (@Cantidad) >= (@Pendiente*@Factor)
            BEGIN
              UPDATE VentaD SET Tarima = @Tarima WHERE CURRENT OF crDividirPorReservado
		
              SELECT @Cantidad = @Cantidad - (@Pendiente*@Factor)
            END
            ELSE IF @Cantidad IS NOT NULL AND (@Cantidad) < (@Pendiente*@Factor)
            BEGIN
              UPDATE VentaD 
                 SET Tarima = @Tarima,
					 Cantidad = @Cantidad / @Factor,
                     CantidadPendiente = @Cantidad / @Factor,
					 CantidadInventario = @Cantidad
               WHERE CURRENT OF crDividirPorReservado  

              SELECT * INTO #VentaDetalle 
                FROM cVentaDWMS
			   WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub AND RenglonID = @RenglonID 
			
              IF @@ERROR <> 0 SELECT @Ok = 1  
  
              SELECT @RenglonSub = MAX(RenglonSub)+1, @cRenglonID = MAX(RenglonID)+1 FROM VentaD WHERE ID = @ID AND Renglon = @Renglon AND RenglonID = @RenglonID 
              SELECT @cRenglon = MAX(Renglon) + 2048 FROM VentaD WHERE ID = @ID

              IF @@ERROR <> 0 SELECT @Ok = 1  
    
              UPDATE #VentaDetalle 
                 SET Cantidad = (@Pendiente*@Factor - @Cantidad)/@Factor, 
                     CantidadInventario = (@Pendiente*@Factor - @Cantidad), 
                     CantidadPendiente = (@Pendiente*@Factor - @Cantidad)/@Factor, 
                     Almacen = @Almacen, 
                     Renglon = @cRenglon,
                     --RenglonSub = @RenglonSub,
                     RenglonID = @cRenglonID,
                     CantidadReservada = 0,
				     Tarima = NULL
              IF @@ERROR <> 0 SELECT @Ok = 1  
              
              UPDATE #VentaDetalle SET CantidadPendiente = Cantidad, CantidadA = 0  
              IF @@ERROR <> 0 SELECT @Ok = 1  
				
			  INSERT INTO cVentaDWMS SELECT * FROM #VentaDetalle
			  
              DELETE VentaD WHERE Cantidad = 0 AND ID = @ID

              SELECT @Cantidad = NULL

				IF NOT EXISTS (SELECT * FROM SerieLoteMov WHERE ID = @ModuloID AND Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'') AND Modulo = @Modulo AND Empresa = @Empresa AND Tarima = @Tarima)
	               INSERT SerieLoteMov(Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, CantidadAlterna, Propiedades,
						  Ubicacion, Cliente, Localizacion, Sucursal, ArtCostoInv, Tarima, AsignacionUbicacion)
				   SELECT slm.Empresa, slm.Modulo, slm.ID, slm.RenglonID, slm.Articulo, slm.SubCuenta, slm.SerieLote, SUM(slm.Cantidad), NULLIF(SUM(ISNULL(slm.CantidadAlterna,0)),0), slm.Propiedades, 
						  slm.Ubicacion, slm.Cliente, slm.Localizacion, slm.Sucursal, slm.ArtCostoInv, VentaD.Tarima, slm.AsignacionUbicacion
					 FROM SerieLoteMov slm, VentaD, Venta
				    WHERE Venta.Estatus = 'PENDIENTE'  
					  AND Venta.ID = @ModuloID  
					  AND VentaD.ID = Venta.ID  
					  AND VentaD.Almacen = @Almacen  
					  AND VentaD.Articulo = @Articulo  
					  AND VentaD.SubCuenta = @SubCuenta  
					  AND ISNULL(VentaD.CantidadPendiente, 0.0) > 0
					  AND slm.Empresa = @Empresa
					  AND slm.Modulo = @Modulo
					  AND slm.ID = Venta.ID
					  AND VentaD.Articulo = slm.Articulo
					  AND ISNULL(VentaD.SubCuenta,'') = ISNULL(slm.SubCuenta,'')
					  AND VentaD.RenglonID = slm.RenglonID
					  AND VentaD.Tarima IS NOT NULL
				 GROUP BY slm.Empresa, slm.Modulo, slm.ID, slm.RenglonID, slm.Articulo, slm.SubCuenta, slm.SerieLote, slm.Propiedades, 
						  slm.Ubicacion, slm.Cliente, slm.Localizacion, slm.Sucursal, slm.ArtCostoInv, VentaD.Tarima, slm.AsignacionUbicacion    

				IF @@ROWCOUNT <> 0
					DELETE SerieLoteMov 
					 WHERE Empresa = @Empresa
					   AND Modulo = @Modulo
					   AND ID = @ModuloID
					   AND Tarima <> @Tarima
					   AND Articulo = @Articulo
					   AND RenglonID = @RenglonID
            END
            
        END  
        ELSE  
        IF @Modulo = 'INV'  
        BEGIN
          IF (OBJECT_ID('Tempdb..#InvDetalle')) IS NOT NULL
            DROP TABLE #InvDetalle

            IF @Cantidad IS NOT NULL AND (@Cantidad) >= (@Pendiente*@Factor)
            BEGIN
              UPDATE InvD SET Tarima = @Tarima WHERE CURRENT OF crDividirPorReservado  

              SELECT @Cantidad = @Cantidad - (@Pendiente*@Factor)
            END
            ELSE IF @Cantidad IS NOT NULL AND (@Cantidad) < (@Pendiente*@Factor)
            BEGIN
              UPDATE InvD 
                 SET Tarima = @Tarima,
					 Cantidad = @Cantidad / @Factor,
                     CantidadPendiente = @Cantidad / @Factor,
					 CantidadInventario = @Cantidad,
                     CantidadReservada = 0
               WHERE CURRENT OF crDividirPorReservado  

              SELECT * INTO #InvDetalle FROM cInvDWMS WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub

              IF @@ERROR <> 0 SELECT @Ok = 1  
  
              SELECT @RenglonSub = MAX(RenglonSub)+1, @cRenglonID = MAX(RenglonID)+1 FROM InvD WHERE ID = @ID AND Renglon = @Renglon AND RenglonID = @RenglonID 
              SELECT @cRenglon = MAX(Renglon) + 2048 FROM InvD WHERE ID = @ID

              IF @@ERROR <> 0 SELECT @Ok = 1  
    
              UPDATE #InvDetalle 
                 SET Cantidad = (@Pendiente*@Factor - @Cantidad)/@Factor, 
                     CantidadInventario = (@Pendiente*@Factor - @Cantidad), 
                     CantidadPendiente = (@Pendiente*@Factor - @Cantidad)/@Factor, 
                     Almacen = @Almacen, 
                     Renglon = @cRenglon,
                     --RenglonSub = @RenglonSub,
                     RenglonID =  @cRenglonID,
                     CantidadReservada = 0,
				     Tarima = NULL
              IF @@ERROR <> 0 SELECT @Ok = 1  
              
              UPDATE #InvDetalle SET CantidadPendiente = Cantidad, CantidadA = 0  
              IF @@ERROR <> 0 SELECT @Ok = 1  

			  INSERT INTO cInvDWMS SELECT * FROM #InvDetalle
              DELETE InvD WHERE Cantidad = 0 AND ID = @ID
              SELECT @Cantidad = NULL

				IF NOT EXISTS (SELECT * FROM SerieLoteMov WHERE ID = @ModuloID AND Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'') AND Modulo = @Modulo AND Empresa = @Empresa AND Tarima = @Tarima)              
				   INSERT SerieLoteMov(Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, CantidadAlterna, Propiedades,
						  Ubicacion, Cliente, Localizacion, Sucursal, ArtCostoInv, Tarima, AsignacionUbicacion)
				   SELECT slm.Empresa, slm.Modulo, slm.ID, slm.RenglonID, slm.Articulo, slm.SubCuenta, slm.SerieLote, SUM(slm.Cantidad), NULLIF(SUM(ISNULL(slm.CantidadAlterna,0)),0), slm.Propiedades, 
						  slm.Ubicacion, slm.Cliente, slm.Localizacion, slm.Sucursal, slm.ArtCostoInv, InvD.Tarima, slm.AsignacionUbicacion
					 FROM SerieLoteMov slm, InvD, Inv
				    WHERE Inv.Estatus = 'PENDIENTE'  
					  AND Inv.ID = @ModuloID  
					  AND InvD.ID = Inv.ID  
					  AND InvD.Almacen = @Almacen  
					  AND InvD.Articulo = @Articulo  
					  AND InvD.SubCuenta = @SubCuenta  
					  AND ISNULL(InvD.CantidadPendiente, 0.0) > 0
					  AND slm.Empresa = @Empresa
					  AND slm.Modulo = @Modulo
					  AND slm.ID = Inv.ID
					  AND InvD.Articulo = slm.Articulo
					  AND ISNULL(InvD.SubCuenta,'') = ISNULL(slm.SubCuenta,'')
					  AND InvD.RenglonID = slm.RenglonID
					  AND InvD.Tarima IS NOT NULL
				 GROUP BY slm.Empresa, slm.Modulo, slm.ID, slm.RenglonID, slm.Articulo, slm.SubCuenta, slm.SerieLote, slm.Propiedades, 
						  slm.Ubicacion, slm.Cliente, slm.Localizacion, slm.Sucursal, slm.ArtCostoInv, InvD.Tarima, slm.AsignacionUbicacion
				 IF @@ROWCOUNT <> 0
					DELETE SerieLoteMov
					 WHERE Empresa = @Empresa
					   AND Modulo = @Modulo
					   AND ID = @ModuloID
					   AND Tarima <> @Tarima
					   AND Articulo = @Articulo
					   AND RenglonID = @RenglonID
            END
            
        END
        ELSE  
        IF @Modulo = 'COMS'  
        BEGIN 
          IF (OBJECT_ID('Tempdb..#CompraDetalle')) IS NOT NULL
            DROP TABLE #CompraDetalle

            IF @Cantidad IS NOT NULL AND (@Cantidad) >= (@Pendiente*@Factor)
            BEGIN
              UPDATE CompraD SET Tarima = @Tarima WHERE CURRENT OF crDividirPorReservado

              SELECT @Cantidad = @Cantidad - (@Pendiente*@Factor)
            END
            ELSE IF @Cantidad IS NOT NULL AND (@Cantidad) < (@Pendiente*@Factor)
            BEGIN
              UPDATE CompraD 
                 SET Tarima = @Tarima,
					 Cantidad = @Cantidad / @Factor,
                     CantidadPendiente = @Cantidad / @Factor,
					 CantidadInventario = @Cantidad
               WHERE CURRENT OF crDividirPorReservado  

              SELECT * INTO #CompraDetalle FROM cCompraD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub

              IF @@ERROR <> 0 SELECT @Ok = 1  
  
              SELECT @RenglonSub = MAX(RenglonSub)+1, @cRenglonID = MAX(RenglonID)+1 FROM CompraD WHERE ID = @ID AND Renglon = @Renglon  
              SELECT @cRenglon = MAX(Renglon) + 2048 FROM CompraD WHERE ID = @ID
              IF @@ERROR <> 0 SELECT @Ok = 1  
    
              UPDATE #CompraDetalle
                 SET Cantidad = (@Pendiente*@Factor - @Cantidad)/@Factor, 
                     CantidadInventario = (@Pendiente*@Factor - @Cantidad), 
                     CantidadPendiente = (@Pendiente*@Factor - @Cantidad)/@Factor, 
                     Almacen = @Almacen, 
                     Renglon = @cRenglon,
                     --RenglonSub = @RenglonSub,
                     RenglonID = @cRenglonID, 
                     CantidadReservada = 0,
				     Tarima = NULL
              IF @@ERROR <> 0 SELECT @Ok = 1  
              
              UPDATE #CompraDetalle SET CantidadPendiente = Cantidad, CantidadA = 0  
              IF @@ERROR <> 0 SELECT @Ok = 1  

			  INSERT INTO cCompraD SELECT * FROM #CompraDetalle
              DELETE CompraD WHERE Cantidad = 0 AND ID = @ID
              SELECT @Cantidad = NULL
              
				IF NOT EXISTS (SELECT * FROM SerieLoteMov WHERE ID = @ModuloID AND Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'') AND Modulo = @Modulo AND Empresa = @Empresa AND Tarima = @Tarima)
				   INSERT SerieLoteMov(Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, CantidadAlterna, Propiedades,
						  Ubicacion, Cliente, Localizacion, Sucursal, ArtCostoInv, Tarima, AsignacionUbicacion)
				   SELECT slm.Empresa, slm.Modulo, slm.ID, slm.RenglonID, slm.Articulo, slm.SubCuenta, slm.SerieLote, SUM(slm.Cantidad), NULLIF(SUM(ISNULL(slm.CantidadAlterna,0)),0), slm.Propiedades, 
						  slm.Ubicacion, slm.Cliente, slm.Localizacion, slm.Sucursal, slm.ArtCostoInv, CompraD.Tarima, slm.AsignacionUbicacion
					 FROM SerieLoteMov slm, CompraD, Compra
				    WHERE Compra.Estatus = 'PENDIENTE'  
					  AND Compra.ID = @ModuloID  
					  AND CompraD.ID = Compra.ID  
					  AND CompraD.Almacen = @Almacen  
					  AND CompraD.Articulo = @Articulo  
					  AND CompraD.SubCuenta = @SubCuenta  
					  AND ISNULL(CompraD.CantidadPendiente, 0.0) > 0
					  AND slm.Empresa = @Empresa
					  AND slm.Modulo = @Modulo
					  AND slm.ID = Compra.ID
					  AND CompraD.Articulo = slm.Articulo
					  AND ISNULL(CompraD.SubCuenta,'') = ISNULL(slm.SubCuenta,'')
					  AND CompraD.RenglonID = slm.RenglonID
					  
				 GROUP BY slm.Empresa, slm.Modulo, slm.ID, slm.RenglonID, slm.Articulo, slm.SubCuenta, slm.SerieLote, slm.Propiedades, 
						  slm.Ubicacion, slm.Cliente, slm.Localizacion, slm.Sucursal, slm.ArtCostoInv, CompraD.Tarima, slm.AsignacionUbicacion
				 IF @@ROWCOUNT <> 0
					DELETE SerieLoteMov 
					 WHERE Empresa = @Empresa
					   AND Modulo = @Modulo
					   AND ID = @ModuloID
					   AND Tarima <> @Tarima
					   AND Articulo = @Articulo
					   AND RenglonID = @RenglonID
            END
           
        END
      END
    END  
    FETCH NEXT FROM crDividirPorReservado INTO @ID, @Renglon, @RenglonSub, @Pendiente, @Unidad, @Factor, @RenglonID
    IF @@ERROR <> 0 SELECT @Ok = 1  
  END  
  CLOSE crDividirPorReservado  
  DEALLOCATE crDividirPorReservado
END
GO

--TASK24685
--REQ12615 WMS
/**************** spWMSGeneraSurtido ****************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'spWMSGeneraSurtido' AND type = 'P') DROP PROCEDURE spWMSGeneraSurtido
GO
CREATE PROCEDURE spWMSGeneraSurtido
                             @Estacion   int,  
                             @Usuario    varchar(10)  
--//WITH ENCRYPTION
AS  
BEGIN  
  --EWQ. Tuning
  SET NOCOUNT ON  
    DECLARE @Articulo                     varchar(20),      
              @ID                       int,      
              @Empresa                  varchar(5),       
              @Sucursal                 int,      
              @Mov                      varchar(20),       
              @FechaEmision             datetime,       
              @Estatus                  varchar(15),       
              @Almacen                  varchar(10),       
              @Agente                   varchar(10),       
              @Zona                     varchar(50),       
              @Observaciones   varchar(100),       
              @PosicionOrigen			varchar(10),       
              @PosicionDestino          varchar(10),       
              @CantidadTarima			float,       
              @Tarima                   varchar(20),      
              @Renglon                  float,      
              @Ok                       int,      
              @OkRef                    varchar(255),      
              @TarimaSurtido			varchar(20),      
              @MinimoTarima             float,      
              @IDDestino                int,      
              @Disponible               float,      
              @MovA                     char(20),      
              @MovDestino               varchar(20),      
              @MovDestinoID             varchar(20),      
              @MovID                    varchar(20),      
              @Tipo                     varchar(20),      
              @Resultado                float,      
              @DisponibleTarima         float,      
              @Ordenes                  float,      
              @Contador                 bit,      
              @ControlArticulo          varchar(20),      
              @IDModuloD                int,      
              @ModuloD                  char(5),      
              @CantidadD                float,      
              @ArticuloD                varchar(20),      
              @AlmacenD                 varchar(10),      
              @ArticuloPediente         varchar(20),      
              @AlmacenPediente          varchar(20),      
              @CantidadPediente         float,      
              @IDPendiente              int,      
              @ArticuloWMS              varchar(20),      
              @AlmacenWMS               varchar(20),      
              @CantidadWMS              float,      
              @ModuloWMS                char(5),      
              @IDModuloWMS              int,      
              @RenglonWMS               float,      
              @RenglonSubWMS   int,      
              @CantidadTarimaTotal  float,      
              @CantidadTarimaSub  float,    
              @CantidadTotal   float,    
              @Procesado    bit,    
              @Referencia    varchar(50),    
              @Unidad     varchar(50), --REQ 14684     
              @CantidadUnidad   float, --REQ 14684    
      
              --EWQ. Tuning
              @SucursalDestino			int,
              @SucursalDestinoAnt		int,
			  @Pasillo					varchar(20),
			  @PasilloAnt				varchar(20),
              @TarimasReacomodar		int,
              @Reacomodar				int, 
			  @TarimaN					varchar(20),
		      @ModuloAux				varchar(5),
		      @IDAux					int,
              @RenglonID                int,
              @SerieLote                varchar(50),
			  @Origen					varchar(20),
			  @OrigenID					varchar(20),
              @WMSReacomodoSurtido		bit,
              @ModuloAuxAnt				varchar(5),
			  @IDAuxAnt					int,
              @TarimaAnt				varchar(20),
			  @IDTarima					int,
			  @IDTarimaAnt				int,
			  --BUG24180
			  @OrigenObservaciones		varchar(100),

			  --TASK2429PGC
			  @ArticuloAux        varchar(20),
              @SubCuentaAux       varchar(50),
              @SubCuentaWMS       varchar(50),
			  @TarimaFechaCaducidad datetime, --BUG3786
			  @TarimaFechaCaducidadAux datetime, --BUG3786
              
              --BUG3817
              @SubCuentaAct       varchar(20),
              @SubCuentaAnt       varchar(20),
			  @ArtTipoOpcion      varchar(20),

			  @ArticuloTipo      varchar(20), --TASK2429PGC
              @ArtSerieLoteInfo  bit, --TASK3288             
			  @PCKUbicacion      int, --TASK6535
              @CantidadSerieLote float,
              @Propiedades       varchar(20),
              @ArtCambioClave    varchar(50)

BEGIN TRAN HMp      

    --EWQ. Tuning
    DECLARE @TarimaDisp TABLE(
            Tarima varchar(20))      
    
  CREATE TABLE #WMSVentaDR (      
     ID      int          NOT NULL,    
     Renglon    float      NOT NULL,    
     RenglonSub   int    NOT NULL DEFAULT 0,    
    
     RenglonID   int     NULL,    
     RenglonTipo   char(1)    NULL DEFAULT 'N',    
    
     Cantidad            float         NULL,    
     Almacen    varchar(10) COLLATE Database_Default NULL,    
     EnviarA    int        NULL,    
     Codigo    varchar(30) COLLATE Database_Default NULL,    
     Articulo   varchar(20) COLLATE Database_Default NOT NULL,    
     SubCuenta   varchar(50) COLLATE Database_Default NULL,    
     --nSubCuenta   varchar(20) COLLATE Database_Default NULL DEFAULT '',    
     Precio           float         NULL,    
     PrecioSugerido      float         NULL,    
     DescuentoTipo  char(1)       NULL DEFAULT '%',    
     DescuentoLinea  money    NULL,    
     DescuentoImporte money    NULL,    
     Impuesto1   float    NULL,    
     Impuesto2   float    NULL,    
     Impuesto3   float    NULL,    
     DescripcionExtra varchar(100) COLLATE Database_Default NULL,    
     Costo    money    NULL,    
     CostoActividad  money    NULL,    
     Paquete    int     NULL,    
     ContUso    varchar(20) COLLATE Database_Default NULL,    
    Aplica    varchar(20) COLLATE Database_Default NULL,    
     AplicaID   varchar(20) COLLATE Database_Default NULL,    
     CantidadPendiente float       NULL,    
     CantidadReservada float       NULL,    
     CantidadCancelada float    NULL,    
     CantidadOrdenada float    NULL,    
     CantidadA   float       NULL,    
     Unidad    varchar(50) COLLATE Database_Default NULL,    
     Factor    float       NULL DEFAULT 1.0,    
     CantidadInventario  float        NULL,    
 SustitutoArticulo   varchar(20) COLLATE Database_Default NULL,    
 SustitutoSubCuenta varchar(50) COLLATE Database_Default NULL,    
 FechaRequerida  datetime   NULL,    
 HoraRequerida  varchar(5) COLLATE Database_Default NULL,    
 Instruccion   varchar(50) COLLATE Database_Default NULL,    
 UltimoReservadoCantidad float   NULL,    
 UltimoReservadoFecha datetime  NULL,    
 Agente     varchar(10) COLLATE Database_Default NULL,    
 Departamento  int     NULL,    
 Sucursal   int    NOT NULL DEFAULT 0,    
 SucursalOrigen  int     NULL DEFAULT 0,    
 AutoLocalidad  varchar(5) COLLATE Database_Default NULL,    
 UEN     int     NULL,    
 Espacio    varchar(10) COLLATE Database_Default NULL,    
 CantidadAlterna  float    NULL,    
 PoliticaPrecios  varchar(255) COLLATE Database_Default NULL,    
 PrecioMoneda  varchar(10) COLLATE Database_Default NULL,    
 PrecioTipoCambio float    NULL,    
 AFArticulo   varchar(20) COLLATE Database_Default NULL,    
 AFSerie    varchar(20) COLLATE Database_Default NULL,    
 ExcluirPlaneacion bit     NULL DEFAULT 0,    
 Anexo    bit     NULL DEFAULT 0,    
 Estado    varchar(30) COLLATE Database_Default NULL,    
    ExcluirISAN   bit     NULL DEFAULT 0,    
    Posicion   varchar(10) COLLATE Database_Default NULL,    
 PresupuestoEsp  bit     NULL DEFAULT 0,       
 Tarima    varchar(20) COLLATE Database_Default NULL,    
    
  )    
    
  CREATE TABLE #WMSInvDR (    
 ID      int        NOT NULL,    
  Renglon    float    NOT NULL,    
 RenglonSub   int   NOT NULL DEFAULT 0,    
     
 RenglonID   int    NULL,    
 RenglonTipo   char(1)         NULL DEFAULT 'N',    
     
    Cantidad   float       NULL,    
 Almacen    varchar(10) COLLATE Database_Default NULL,    
 Codigo    varchar(30) COLLATE Database_Default NULL,    
 Articulo   varchar(20) COLLATE Database_Default NOT NULL,    
 SubCuenta   varchar(50) COLLATE Database_Default NULL,    
 ArticuloDestino  varchar(20) COLLATE Database_Default NULL,    
 SubCuentaDestino varchar(50) COLLATE Database_Default NULL,    
    Costo               money       NULL,    
 CostoInv   money       NULL,    
 ContUso    varchar(20) COLLATE Database_Default NULL,    
 Espacio    varchar(10) COLLATE Database_Default NULL,    
     
 CantidadReservada float      NULL,    
 CantidadCancelada float   NULL,    
 CantidadOrdenada float   NULL,    
 CantidadPendiente float       NULL,    
 CantidadA   float       NULL,    
 Paquete    int    NULL,    
 FechaRequerida  datetime  NULL,    
    
 Aplica            varchar(20) COLLATE Database_Default NULL,    
    AplicaID         varchar(20) COLLATE Database_Default NULL,    
    
 DestinoTipo   varchar(10) COLLATE Database_Default NULL,    
 Destino    varchar(20) COLLATE Database_Default NULL,    
 DestinoID   varchar(20) COLLATE Database_Default NULL,    
 Cliente    varchar(10) COLLATE Database_Default NULL,    
    
 Unidad    varchar(50) COLLATE Database_Default NULL,    
 Factor    float      NULL DEFAULT 1.0,    
    CantidadInventario  float       NULL,    
    
 UltimoReservadoCantidad float  NULL,    
 UltimoReservadoFecha datetime NULL,    
    
 ProdSerieLote  varchar(50) COLLATE Database_Default NULL,    
    Merma             float       NULL,    
    Desperdicio         float       NULL,    
    
 Producto   varchar(20) COLLATE Database_Default NULL,    
 SubProducto   varchar(20) COLLATE Database_Default NULL,    
 Tipo    varchar(20) COLLATE Database_Default NULL,    
    
 Sucursal   int   NOT NULL DEFAULT 0,    
 SucursalOrigen  int    NULL DEFAULT 0,    
 Precio    money   NULL,    
 DescripcionExtra varchar(100) COLLATE Database_Default NULL,    
 Posicion   varchar(10) COLLATE Database_Default NULL,    
 ExistenciaAntes       float NULL,    
 TieneOferta           varchar(2) NULL,    
 Tarima    varchar(20) COLLATE Database_Default NULL,    
 Seccion    smallint  NULL,    
  ASFactor      float       NULL,    
  ASProveedor       varchar(10) NULL,    
    
 FechaCaducidad  datetime  NULL    
  )    
    
  CREATE TABLE #WMSComsDR (    
 ID       int         NOT NULL,    
  Renglon     float     NOT NULL,    
 RenglonSub    int   NOT NULL DEFAULT 0,    
    
 RenglonID    int    NULL,    
 RenglonTipo    char(1)     COLLATE Database_Default NULL,    
    
    Cantidad    float        NULL,    
 Almacen     varchar(10) COLLATE Database_Default NULL,    
 Codigo     varchar(30) COLLATE Database_Default NULL,    
 Articulo    varchar(20) COLLATE Database_Default NULL,    
 SubCuenta    varchar(50) COLLATE Database_Default NULL,    
 FechaRequerida   datetime     NULL,    
 FechaOrdenar   datetime     NULL,    
 FechaEntrega   datetime     NULL,    
-- CostoConImpuesto  float        NULL,    
    Costo             float        NULL,    
 Impuesto1    float   NULL,    
 Impuesto2    float   NULL,    
 Impuesto3    float   NULL,    
-- Impuesto5    float   NULL,    
 Retencion1    float   NULL,    
 Retencion2    float   NULL,    
 Retencion3    float   NULL,    
 Descuento    varchar(30) COLLATE Database_Default NULL,    
 DescuentoTipo   char(1)     COLLATE Database_Default NULL,    
    DescuentoLinea   money   NULL,    
 DescuentoImporte  money   NULL,    
 DescripcionExtra  varchar(100)COLLATE Database_Default NULL,    
 ReferenciaExtra   varchar(50) COLLATE Database_Default NULL,    
 ContUso     varchar(20) COLLATE Database_Default NULL,    
    
 DestinoTipo    varchar(10) COLLATE Database_Default NULL,    
 Destino     varchar(20) COLLATE Database_Default NULL,    
 DestinoID    varchar(20) COLLATE Database_Default NULL,    
    
 Aplica     varchar(20) COLLATE Database_Default NULL,    
 AplicaID    varchar(20) COLLATE Database_Default NULL,    
    
 CantidadPendiente  float      NULL,    
 CantidadCancelada  float   NULL,    
 CantidadA    float      NULL,    
    
 CostoInv    float   NULL,    
    
 Unidad     varchar(50) COLLATE Database_Default NULL,    
 Factor     float      NULL DEFAULT 1.0,    
    CantidadInventario  float       NULL,    
 Cliente     varchar(10) COLLATE Database_Default NULL,    
    
 ServicioArticulo  varchar(20) COLLATE Database_Default NULL,    
 ServicioSerie   varchar(20) COLLATE Database_Default NULL,    
 Paquete     int    NULL,    
    
 Sucursal    int   NOT NULL DEFAULT 0,    
    SucursalOrigen   int   NOT NULL DEFAULT 0,    
 ImportacionProveedor varchar(10) COLLATE Database_Default NULL,    
 ImportacionReferencia varchar(50) COLLATE Database_Default NULL,    
 ProveedorRef   varchar(10) COLLATE Database_Default NULL,    
 AgenteRef    varchar(10) COLLATE Database_Default NULL,    
 FechaCaducidad   datetime  NULL,    
    
 Posicion    varchar(10) COLLATE Database_Default NULL,    
    
 Pais     varchar(50) COLLATE Database_Default NULL,    
 TratadoComercial  varchar(50) COLLATE Database_Default NULL,    
 ProgramaSectorial  varchar(50) COLLATE Database_Default NULL,    
 ValorAduana    money  NULL,    
 ImportacionImpuesto1 float  NULL,    
 ImportacionImpuesto2 float  NULL,    
 ID1      char(2)  COLLATE Database_Default NULL,    
 ID2      char(2)  COLLATE Database_Default NULL,    
 FormaPago    varchar(50) COLLATE Database_Default NULL,    
 ASDescuentoCascada      float,    
 ASDescuentoLinea        float,    
 ASCantidadConCargo      float,    
 ASCantidadSinCargo      float,    
 ASDescuentoLinea2       float,    
 ASTipoCosto             varchar(10),    
 EsEstadistica           bit,    
 Sugerido                bit,    
 PresupuestoEsp          bit,    
 ASSugerido              bit,    
 UEN                     int,    
 Departamento            varchar(50),    
 Familia                 varchar(50),    
 SubFamilia              varchar(50),    
 ASCantidadSugerida      float,    
 ContUso2                varchar(20),    
 ContUso3                varchar(20),    
 Tarima                  varchar(20),    
 ExistenciaEsperada      float,    
 ASFactor                float
         )    

	DECLARE @WMSSurtidoCD TABLE  
	( 
		Modulo			varchar(5)	NULL,        
		ModuloID		int			NULL,        
		Articulo		varchar(20) NULL,        
		Almacen         varchar(20) NULL  
	)
      
  DECLARE @WMSSurtidoProcesarD TABLE  ( 
            --EWQ. Tuning
			Modulo			varchar(5)	COLLATE Database_Default NOT NULL,        
            ModuloID		int			NOT NULL,        
            Articulo		varchar(20) COLLATE Database_Default NULL,        
            Almacen         varchar(20) COLLATE Database_Default NULL,        
            Pasillo         varchar(20) COLLATE Database_Default NULL,   --@Gina 16/04/2014
            CantidadTarima  float		NULL,
			SubCuenta       varchar(50) COLLATE Database_Default NULL, --TASK2429PGC      
            SerieLote       varchar(50) COLLATE Database_Default NULL,
			PCKUbicacion    int --TASK6535
    )
    
  DECLARE @WMSSurtidoProcesarDTotal TABLE  (  
            --EWQ. Tuning
			Modulo			varchar(5)	COLLATE Database_Default NOT NULL,        
            ModuloID		int			NOT NULL,              
            Articulo        varchar(20) COLLATE Database_Default NULL,        
            Almacen         varchar(20) COLLATE Database_Default NULL,        
            CantidadTarima  float NULL,
			SubCuenta       varchar(50) COLLATE Database_Default NULL, --TASK2429PGC            
            SerieLote       varchar(50) COLLATE Database_Default NULL
    )
    
      
  SELECT TOP 1 @Empresa = v.Empresa,      
                 @Sucursal = v.Sucursal,     
                 @FechaEmision = dbo.fnFechaSinHora(GETDATE()),      
                 @Estatus = 'SINAFECTAR'      
    FROM WMSLista w JOIN Venta v ON v.ID = w.IDModulo AND w.Modulo = 'VTAS'    
    WHERE w.Estacion=@Estacion    
      
  SELECT TOP 1 @Empresa = v.Empresa,      
                 @Sucursal = v.Sucursal,      
                 @FechaEmision = dbo.fnFechaSinHora(GETDATE())      
    FROM WMSLista w JOIN Compra v ON v.ID = w.IDModulo AND w.Modulo = 'COMS'     
    WHERE w.Estacion=@Estacion   
      
  SELECT TOP 1 @Empresa = v.Empresa,      
                 @Sucursal = v.Sucursal,      
                 @FechaEmision = dbo.fnFechaSinHora(GETDATE())      
    FROM WMSLista w JOIN Inv v ON v.ID = w.IDModulo AND w.Modulo = 'INV'  
   WHERE w.Estacion=@Estacion
   
   --BUG2820
   --IF EXISTS(SELECT * FROM AlmPos WHERE Tipo IN ('Domicilio','Ubicacion') AND Pasillo IS NULL) --BUG2839
   --SELECT TOP 1 @Ok=13038, @OkRef=Posicion FROM AlmPos WHERE Tipo IN ('Domicilio','Ubicacion') AND Pasillo IS NULL --BUG28390 0382015

  --EWQ. Tuning
  SELECT @WMSReacomodoSurtido = ISNULL(WMSReacomodoSurtido, 0) FROM EmpresaCfg WHERE Empresa = @Empresa

  DELETE WMSSurtidoProcesarD WHERE Procesado = 1 AND Estacion = @Estacion      

  SELECT @ArticuloTipo=Tipo, @ArtSerieLoteInfo=SerieLoteInfo FROM Art WHERE Articulo  = @Articulo --TASK2429PGC --TASK3288 --BUG2983
  --EWQ. Tuning

  IF @WMSReacomodoSurtido = 1
  BEGIN
     DECLARE crDisponible CURSOR LOCAL STATIC FOR      
     SELECT Articulo, Almacen, Tipo, /*SUM(CantidadTarima)*/ 0 Cantidad, Unidad, CantidadUnidad, Articulo, SubCuenta, --REQ 14684 --TASK2429PGC    --BUG 6786
	        TarimaFechaCaducidad --BUG3786
       FROM WMSSurtidoProcesarD       
      WHERE Estacion = @Estacion AND Procesado = 0       
        AND Articulo IN(SELECT DISTINCT Clave FROM ListaSt WHERE Estacion = @Estacion)      
        AND Tipo = 'Domicilio' 
        AND (PosicionDestino IS NOT NULL AND PosicionDestino <> '' ) --@Gina 18/04/2014
		AND NULLIF(SubCuenta,'') IS NULL --TASK2429PGC
      GROUP BY Articulo, Almacen, Tipo, Unidad, CantidadUnidad, Articulo, SubCuenta, TarimaFechaCaducidad --REQ 14684 --TASK2429PGC --BUG3786
              
    OPEN crDisponible      
    FETCH NEXT FROM crDisponible INTO @Articulo, @Almacen, @Tipo, @CantidadTarima, @Unidad, @CantidadUnidad, @ArticuloAux, @SubCuentaAux, @TarimaFechaCaducidad --REQ 14684 --TASK2429PGC --BUG3786
    WHILE @@FETCH_STATUS = 0      
    BEGIN    
      SELECT @Ordenes = 0      
          
      UPDATE WMSSurtidoProcesarD SET Procesado = 1 WHERE Estacion = @Estacion AND Articulo = @Articulo AND Procesado = 0 AND (PosicionDestino IS NOT NULL AND   PosicionDestino <> '') AND Tipo <> 'Cross Docking'--@Gina 18/04/2014
   
      --EWQ. Inicio Tuning. Solo SSFA
      DECLARE crMinimo CURSOR LOCAL FOR      
       SELECT SUM(d.Disponible) Disponible, a.MinimoTarima, SUM(d.Disponible) - @CantidadTarima - @Ordenes Resultado  
         FROM ArtDisponibleTarima d   
         JOIN Tarima t ON d.Tarima = t.Tarima  
         JOIN AlmPos p ON t.Almacen = p.Almacen AND p.Posicion = t.Posicion AND p.ArticuloEsp = d.Articulo  
         JOIN Art a ON d.Articulo = a.Articulo           
        WHERE p.Tipo = @Tipo  
          AND d.Articulo = @Articulo  
          AND t.Estatus = 'ALTA'  
          AND p.Estatus = 'ALTA'  
        GROUP BY d.Articulo, a.MinimoTarima 
  
      OPEN crMinimo  
      FETCH NEXT FROM crMinimo INTO @Disponible, @MinimoTarima, @Resultado  
      WHILE @@FETCH_STATUS = 0  
      BEGIN                  
        SELECT @Contador = 0

        IF @Resultado < @MinimoTarima  
        BEGIN
          SELECT @Tarima = NULL, @DisponibleTarima = NULL, @PosicionOrigen = NULL  
          SELECT @ControlArticulo = ControlArticulo FROM Art WHERE Articulo = @Articulo  
          
          SELECT TOP 1 @PosicionDestino = Posicion FROM AlmPos WHERE ArticuloEsp = @Articulo AND Tipo = @Tipo AND Almacen = @Almacen  
          
          IF @Contador = 0  
            SELECT @Resultado = @Resultado + ISNULL(SUM(ISNULL(a.Disponible,0)),0)  
              FROM TMA t   
              JOIN TMAD d on t.id = d.id   
              JOIN ArtDisponibleTarima a ON d.Tarima = a.Tarima AND a.Articulo = @Articulo AND a.Almacen = @Almacen
              JOIN MovTipo m ON m.Mov = t.Mov AND m.Modulo = 'TMA'  
             WHERE m.Clave = 'TMA.SRADO'
               AND t.Estatus = 'PENDIENTE'
               AND d.PosicionDestino = @PosicionDestino    
               AND a.Empresa = @Empresa 

          IF @Resultado < @MinimoTarima
          BEGIN    
            SELECT @Mov = TMASolicitudReacomodo FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa
            SELECT @TarimasReacomodar = ISNULL(TarimasReacomodar,0) FROM Art WHERE Articulo = @Articulo

            IF ISNULL(@TarimasReacomodar,0) = 0
              SET @TarimasReacomodar = 1

            --EWQ. Tuning
            INSERT TMA (Empresa, Sucursal,   Usuario,  Mov,  FechaEmision,  Estatus,       Almacen,  TarimaSurtido,  Prioridad, Referencia)  
            VALUES     (@Empresa, @Sucursal, @Usuario, @Mov, @FechaEmision, 'SINAFECTAR', @Almacen, @TarimaSurtido, 'Media',  'Herramienta de Surtido')
            
            SET @IDDestino = @@IDENTITY  
            SET @Renglon = 2048 
            SET @Reacomodar = 1

            IF @Reacomodar <= @TarimasReacomodar --REQ 19255
            BEGIN
                SELECT TOP 1 
                       @Tarima		   = A.Tarima,
	                   @Disponible	   = A.Disponible - ISNULL(D.Apartado,0),
                       @PosicionOrigen = B.Posicion
                  FROM ArtDisponibleTarima A
                  JOIN Tarima B ON A.Tarima = B.Tarima  
                  JOIN AlmPos C ON B.Almacen = C.Almacen AND ISNULL(B.Posicion,C.Posicion) = C.Posicion AND C.Tipo <> 'Surtido'
             LEFT JOIN ArtApartadoTarima D ON A.Empresa = D.Empresa AND A.Articulo = D.Articulo AND A.Almacen = D.Almacen AND A.Tarima = D.Tarima
                 WHERE A.Articulo = @Articulo
                   AND A.Tarima NOT IN (SELECT Tarima
                                         FROM WMSSurtidoProcesarD       
                                        WHERE Estacion = @Estacion 
                                          AND Procesado = 1   
                                          AND Articulo IN (SELECT DISTINCT Clave FROM ListaSt WHERE Estacion = @Estacion)      
                                          AND (PosicionDestino IS NOT NULL AND PosicionDestino <> '') 
                                          AND NULLIF(SubCuenta,'') IS NULL
                                          AND Tarima NOT IN (SELECT Tarima FROM @TarimaDisp)                           
                                     )                 
                   AND C.Tipo = 'Ubicacion'
                   AND A.Almacen = @Almacen
                   AND A.Disponible - ISNULL(D.Apartado,0) > 0
                   AND B.Estatus = 'ALTA'
				   AND A.Empresa = @Empresa
              ORDER BY B.FechaCaducidad, CASE @ControlArticulo 
                                         WHEN 'Caducidad'		THEN CONVERT(varchar, B.FechaCaducidad)
                                         WHEN 'Fecha Entrada'	THEN CONVERT(varchar, B.Alta)
                                         ELSE B.Posicion
		  	                             END, A.Tarima ASC

                 INSERT @TarimaDisp (Tarima) VALUES (@Tarima) 
              
              IF @Tarima IS NOT NULL AND @Ok IS NULL
              BEGIN
                    INSERT TMAD (ID,         Sucursal,  Renglon,  Tarima,                   Almacen,  Posicion,        PosicionDestino,  CantidadPicking, Prioridad, EstaPendiente, Procesado, Unidad,  CantidadUnidad, Articulo, SubCuenta, FechaCaducidad) --REQ 14684 --TASK2429PGC
                    SELECT       @IDDestino, @Sucursal, @Renglon, @Tarima, @Almacen, @PosicionOrigen, @PosicionDestino, @Disponible,     'Media',   1,             0,         @Unidad, @Disponible, @ArticuloAux, @SubCuentaAux, @TarimaFechaCaducidad --REQ 14684 --TASK2429PGC --BUG3786
                    SET @Renglon = @Renglon +2048                      
              END
              SET @Reacomodar = ISNULL(@Reacomodar,0) + 1
            END
            ---
            IF @Ok IS NULL AND @IDDestino IS NOT NULL AND EXISTS (SELECT * FROM TMAD WHERE ID = @IDDestino) AND @Tarima IS NOT NULL  
            BEGIN  
              EXEC spAfectar 'TMA', @IDDestino, 'Afectar', @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT      
			  
              SELECT @MovDestino = Mov, @MovDestinoID = MovID FROM TMA WHERE ID = @IDDestino  
              EXEC spMovFlujo @Sucursal, Afectar, @Empresa, 'TMA', @ID, @Mov, @MovID, 'TMA', @IDDestino, @MovDestino, @MovDestinoID, @Ok OUTPUT  
            END          
            ELSE  
              DELETE TMA WHERE ID = @IDDestino  
                    
            SELECT @Resultado = @Resultado + ISNULL(@DisponibleTarima,0)
            SELECT @Contador = 1                
          END  
                        
          IF @Tarima IS NULL  
            SELECT @Resultado = @MinimoTarima  
        END  
        ---   
        FETCH NEXT FROM crMinimo INTO @Disponible, @MinimoTarima, @Resultado  
      END  
      CLOSE crMinimo  
      DEALLOCATE crMinimo       
      --EWQ. Fin Tuning. Solo SSFA                          
      
      FETCH NEXT FROM crDisponible INTO @Articulo, @Almacen, @Tipo, @CantidadTarima, @Unidad, @CantidadUnidad, @ArticuloAux, @SubCuentaAux, @TarimaFechaCaducidad --REQ 14684 --TASK2429PGC --BUG3786    
    END      
    CLOSE crDisponible      
    DEALLOCATE crDisponible
  END

  --EWQ. Tuning
  SELECT @ModuloAuxAnt = ''
  WHILE(1=1)
  BEGIN
    SELECT @ModuloAux = MIN(Modulo)
      FROM WMSSurtidoProcesarD 
     WHERE Estacion = @Estacion
       AND Modulo > @ModuloAuxAnt
       AND NULLIF(RTRIM(TarimaSurtido), '') IS NULL

    IF @ModuloAux IS NULL BREAK

    SELECT @ModuloAuxAnt = @ModuloAux

    SELECT @IDAuxAnt = 0
    WHILE(1=1)
    BEGIN
      SELECT @IDAux = MIN(ModuloID)
        FROM WMSSurtidoProcesarD 
       WHERE NULLIF(RTRIM(TarimaSurtido), '') IS NULL
         AND Estacion = @Estacion
         AND Modulo = @ModuloAux
         AND ModuloID > @IDAuxAnt

      IF @IDAux IS NULL BREAK

      SELECT @IDAuxAnt = @IDAux

      SELECT @TarimaSurtido = NULL
      EXEC spConsecutivo 'Tarima', @Sucursal, @TarimaSurtido OUTPUT      

      EXEC spTarimaAlta @Empresa, @Sucursal, @Usuario, @Almacen, @FechaEmision, @FechaEmision, @TarimaSurtido, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT      

      UPDATE WMSSurtidoProcesarD 
         SET TarimaSurtido = @TarimaSurtido
       --BUG24306
       WHERE /*Estacion = @Estacion
         AND */Modulo = @ModuloAux
         AND ModuloID = @IDAux
    END
  END
  SELECT @TarimaSurtido = NULL

  SELECT @Procesado = 0    
  UPDATE WMSSurtidoProcesarD SET Procesado = 1 WHERE Estacion = @Estacion AND Articulo IN(SELECT DISTINCT Clave FROM ListaSt WHERE Estacion = @Estacion) AND Procesado = 0 AND Tipo <> 'Cross Docking'
  AND (PosicionDestino IS NOT NULL AND PosicionDestino <> '') --@gina 18/04/2014
  DELETE @WMSSurtidoProcesarD    

  INSERT @WMSSurtidoProcesarD    
  --EWQ. Tuning
  SELECT wp.Modulo, wp.ModuloID, Articulo, wp.Almacen,'',SUM(wp.CantidadTarima), wp.SubCuenta, wp.SerieLote, ISNULL(wp.PCKUbicacion,0) --TASK2429PGC --TASK6535
    FROM WMSSurtidoProcesarD wp      
   WHERE wp.Estacion = @Estacion AND wp.Procesado = 1 AND wp.Tipo = 'Ubicacion' AND Articulo IN(SELECT DISTINCT Clave FROM ListaSt WHERE Estacion = @Estacion)      
   AND (wp.PosicionDestino IS NOT NULL AND wp.PosicionDestino <> '') --@gina 18/04/2014
   GROUP BY Modulo, ModuloID, Articulo,wp.Almacen, SubCuenta, wp.SerieLote, wp.PCKUbicacion --TASK2429PGC --TASK6535
    
  DELETE @WMSSurtidoProcesarDTotal    
  INSERT @WMSSurtidoProcesarDTotal    
  --EWQ. Tuning
  SELECT Modulo, ModuloID, Articulo, wp.Almacen,SUM(wp.CantidadTarima), wp.SubCuenta, wp.SerieLote --TASK2429PGC     
      FROM WMSSurtidoProcesarD wp      
   WHERE wp.Estacion = @Estacion AND wp.Procesado = 1 AND Articulo IN(SELECT DISTINCT Clave FROM ListaSt WHERE Estacion = @Estacion)      
   AND (wp.PosicionDestino IS NOT NULL AND wp.PosicionDestino <> '') --@gina 18/04/2014
   --EWQ. Tuning
   AND wp.Tipo = 'Ubicacion'
   GROUP BY Modulo, ModuloID, Articulo,wp.Almacen, SubCuenta, wp.SerieLote --TASK2429PGC       

  SELECT @CantidadTarima = NULL, @CantidadWMS = NULL, @CantidadTarimaTotal = NULL, @CantidadTarimaSub = NULL      
        
  -- Primero Genero las tarimas completas  
  --SELECT TOP 1 @Mov = Mov FROM MovTipo WHERE Clave = 'TMA.OSUR' AND Modulo = 'TMA'   --TASK6535

  DECLARE crUbicacion CURSOR LOCAL STATIC FOR      
  --EWQ Tuning      
  SELECT wp.Modulo, wp.ModuloID, 
         @Empresa, @Sucursal,      
         @Usuario, dbo.fnFechaSinHora(GETDATE()), 'SINAFECTAR',      
         wp.Almacen,      
         wp.Acomodador, wp.Zona, 'Herramienta', 
         wp.PosicionOrigen, wp.PosicionDestino, wp.CantidadTarima, wP.Tarima, wp.Referencia, wp.Unidad, wp.CantidadUnidad, --REQ 14684    
         --EWQ. Tuning
         wp.SucursalFiltro,
         wp.TarimaSurtido,
		 wp.Articulo, --TASK2429PGC
		 wp.SubCuenta, --TASK2429PGC
		 WP.TarimaFechaCaducidad, --BUG3786
		 WP.PCKUbicacion,
         WP.SerieLote --TASK6535
    FROM WMSSurtidoProcesarD wp inner join almpos ap on wp.Almacen = ap.Almacen AND wp. PosicionOrigen = ap.Posicion          
  WHERE wp.Estacion = @Estacion AND wp.Procesado = 1 AND wp.Tipo = 'Ubicacion' AND Articulo IN(SELECT DISTINCT Clave FROM ListaSt WHERE Estacion = @Estacion)      
  AND (wp.PosicionDestino IS NOT NULL AND wp.PosicionDestino <> '') --@Gina 18/04/2014
  OPEN crUbicacion    
  --EWQ. Tuning  
  FETCH NEXT FROM crUbicacion INTO @ModuloAux, @IDAux, @Empresa, @Sucursal, @Usuario, @FechaEmision, @Estatus, @Almacen, @Agente, @Zona, @Observaciones, @PosicionOrigen, @PosicionDestino, @CantidadTarima, @Tarima, @Referencia, @Unidad, @CantidadUnidad, @SucursalDestino, @TarimaSurtido, @ArticuloAux, @SubCuentaAux, @TarimaFechaCaducidadAux, @PCKUbicacion, @SerieLote --REQ 14684 --TASK2429PGC --BUG3786 --TASK6535
  WHILE @@FETCH_STATUS = 0      
  BEGIN  
-- SELECT 1
    --TASK6535
	IF @PCKUbicacion=1
	  SELECT TOP 1 @Mov = Mov FROM MovTipo WHERE Clave = 'TMA.OPCKTarima' AND Modulo = 'TMA'  
	ELSE
	  SELECT TOP 1 @Mov = Mov FROM MovTipo WHERE Clave = 'TMA.OSUR' AND Modulo = 'TMA'     

    --EWQ Tuning
    --BUG24180
    EXEC spMovInfo  @IDAux, @ModuloAux, @Mov = @Origen OUTPUT, @MovID = @OrigenID OUTPUT, @Observaciones = @OrigenObservaciones OUTPUT

    --EWQ. Tuning
    --BUG24180
    IF @ModuloAux = 'VTAS'
        SELECT @ArtCambioClave = VD.ArtCambioClave
          FROM VentaD VD
          JOIN Venta V ON VD.ID = V.ID
         WHERE V.Mov = @Origen
           AND V.MovId = @OrigenID
           AND VD.Articulo = @ArticuloAux
           AND v.ID = @IDAux

    INSERT TMA (Empresa, Sucursal, Usuario, Mov, FechaEmision, Estatus, Almacen, Agente, Zona, Observaciones, TarimaSurtido, Prioridad, Referencia, SucursalFiltro, OrigenTipo, Origen, OrigenID, OrigenObservaciones)      
    VALUES     (@Empresa, @Sucursal, @Usuario, @Mov, @FechaEmision, @Estatus, @Almacen, @Agente, @Zona, @Observaciones, @TarimaSurtido, 'Normal', @Referencia, @SucursalDestino, @ModuloAux, @Origen, @OrigenID, @OrigenObservaciones)      
                
     SET @ID = @@IDENTITY      
 
    UPDATE Tarima SET Posicion = @PosicionOrigen WHERE Tarima = @Tarima               
    INSERT TMAD (ID, Sucursal, Renglon, Tarima, Almacen, Posicion, PosicionDestino, CantidadPicking, Zona, Prioridad, Montacarga, EstaPendiente, Procesado, Unidad,  CantidadUnidad, Articulo, SubCuenta, FechaCaducidad, ArtCambioClave) --REQ 14684 --TASK2429PGC --BUG3786   
    VALUES      (@ID, @Sucursal, 2048, @Tarima, @Almacen, @PosicionOrigen, @PosicionDestino, @CantidadTarima, @Zona, 'Normal', @Agente, 1,  0,         @Unidad, @CantidadUnidad, @ArticuloAux, @SubCuentaAux, @TarimaFechaCaducidadAux, @ArtCambioClave) --REQ 14684 --TASK2429PGC --BUG3786
    
    DECLARE crSerieLote CURSOR LOCAL STATIC FOR      
     SELECT SUM(slm.Cantidad),
            MAX(slm.Propiedades),
			slm.SerieLote
       FROM SerieLoteMov slm
      WHERE slm.ID = @IDAux
        AND slm.Modulo = @ModuloAux
        AND slm.Articulo = @ArticuloAux
        AND ISNULL(slm.SubCuenta,'') = ISNULL(@SubCuentaAux,'')
        AND slm.SerieLote = @SerieLote
        AND slm.Tarima = @Tarima
   GROUP BY slm.SerieLote

    OPEN crSerieLote    
    FETCH NEXT FROM crSerieLote INTO @CantidadSerieLote, @Propiedades, @SerieLote
    WHILE @@FETCH_STATUS = 0      
    BEGIN  
        IF @CantidadSerieLote > @CantidadTarima
			SET @CantidadSerieLote = @CantidadTarima
        INSERT SerieLoteMov
               (Empresa,  Sucursal,  Modulo,  ID,  RenglonID,  Articulo,  SubCuenta, SerieLote, Cantidad, Propiedades, Tarima, AsignacionUbicacion)
        VALUES (@Empresa, @Sucursal, 'TMA', @ID, 2048, @ArticuloAux, ISNULL(@SubCuentaAux,''), @SerieLote, @CantidadSerieLote, @Propiedades, @Tarima, 0)

        FETCH NEXT FROM crSerieLote INTO @CantidadSerieLote, @Propiedades, @SerieLote
    END      
    CLOSE crSerieLote      
    DEALLOCATE crSerieLote 

    IF @OK IS NULL      
      EXEC spAfectar 'TMA', @ID, 'AFECTAR', @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT      

    IF @OK IS NULL      
    BEGIN
      SELECT @MovDestino = Mov, @MovDestinoID = MovID FROM TMA WHERE ID = @ID

      EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @ModuloAux, @IDAux, @Origen, @OrigenID, 'TMA', @ID, @MovDestino, @MovDestinoID, @Ok OUTPUT      
    END
    --EWQ. Tuning        
    FETCH NEXT FROM crUbicacion INTO @ModuloAux, @IDAux, @Empresa, @Sucursal, @Usuario, @FechaEmision, @Estatus, @Almacen, @Agente, @Zona, @Observaciones, @PosicionOrigen, @PosicionDestino, @CantidadTarima, @Tarima, @Referencia, @Unidad, @CantidadUnidad, @SucursalDestino, @TarimaSurtido, @ArticuloAux, @SubCuentaAux, @TarimaFechaCaducidadAux, @PCKUbicacion, @SerieLote --REQ 14684 --TASK2429PGC --BUG3786 --TASK6535
  END      
  CLOSE crUbicacion      
  DEALLOCATE crUbicacion      

  SELECT @Procesado = 0    
  DELETE @WMSSurtidoProcesarD      
  INSERT @WMSSurtidoProcesarD
  --EWQ. Tuning
  SELECT wp.Modulo, wp.ModuloID, Articulo, wp.Almacen, ap.Pasillo, SUM(wp.CantidadTarima), wp.SubCuenta, wp.SerieLote, wp.PCKUbicacion --TASK2429PGC --TASK6535
      FROM WMSSurtidoProcesarD wp  inner join almpos ap on wp.Almacen = ap.Almacen AND wp. PosicionOrigen = ap.Posicion     
   WHERE wp.Estacion = @Estacion AND wp.Procesado = 1 AND wp.Tipo = 'Domicilio' AND Articulo IN(SELECT DISTINCT Clave FROM ListaSt WHERE Estacion = @Estacion)      
   AND (wp.PosicionDestino IS NOT NULL AND wp.PosicionDestino <> '') --@Gina 18/04/2014
   GROUP BY Modulo, ModuloID, Articulo,wp.Almacen, ap.Pasillo, wp.SubCuenta, wp.SerieLote, wp.PCKUbicacion --TASK2429PGC --TASK6535          
        
  SELECT @CantidadTarima = NULL, @CantidadWMS = NULL, @CantidadTarimaTotal = NULL, @CantidadTarimaSub = NULL      

  IF (OBJECT_ID('Tempdb..#WMSSurtidoProcesarD')) IS NOT NULL
    DROP TABLE #WMSSurtidoProcesarD

   IF (OBJECT_ID('Tempdb..#WMSSurtidoProcesarDModulo')) IS NOT NULL
    DROP TABLE #WMSSurtidoProcesarDModulo

  --SELECT wp.*, ISNULL(ap.Pasillo,1) Pasillo --BUG5592		
  SELECT wp.*, 1 Pasillo --BUG5592 --UserStory4417
    INTO #WMSSurtidoProcesarD
    FROM WMSSurtidoProcesarD wp
    JOIN Almpos ap on wp.Almacen = ap.Almacen AND wp. PosicionOrigen = ap.Posicion        
   WHERE wp.Estacion = @Estacion 
     AND wp.Procesado = 1
     AND wp.Tipo = 'Domicilio' 
     AND Articulo IN(SELECT DISTINCT Clave FROM ListaSt WHERE Estacion = @Estacion)      
     AND (wp.PosicionDestino IS NOT NULL AND wp.PosicionDestino <> '') --@Gina 18/04/2014
  
  CREATE INDEX Ciclo ON #WMSSurtidoProcesarD(SucursalFiltro, Pasillo, Modulo, ModuloID, Tarima)

  --UserStory4417
  SELECT DISTINCT SucursalFiltro, Pasillo, Modulo, ModuloID INTO #WMSSurtidoProcesarDModulo FROM #WMSSurtidoProcesarD
  CREATE INDEX CicloModulo ON #WMSSurtidoProcesarDModulo(SucursalFiltro, Pasillo, Modulo, ModuloID)

  --SELECT * FROM ListaSt
  --select * from WMSSurtidoProcesarD WHERE Procesado = 0
  --select * from #WMSSurtidoProcesarD
  --select * from #WMSSurtidoProcesarDModulo
 
  --EWQ Tuning
  --DECLARE @Pasillo VARCHAR(20)
  --SELECT @SucursalDestinoAnt = 0
  SELECT @SucursalDestinoAnt = -1 --BUG2605
  WHILE(1=1)
  BEGIN
--    SELECT @SucursalDestino = MIN(SucursalFiltro)
--      FROM WMSSurtidoProcesarD wp
--      JOIN Almpos ap on wp.Almacen = ap.Almacen AND wp. PosicionOrigen = ap.Posicion        
--     WHERE wp.Estacion = @Estacion 
--       AND wp.Procesado = 1 
--       AND wp.Tipo = 'Domicilio' 
--       AND Articulo IN(SELECT DISTINCT Clave FROM ListaSt WHERE Estacion = @Estacion)      
--       AND (wp.PosicionDestino IS NOT NULL AND wp.PosicionDestino <> '') --@Gina 18/04/2014
--       AND wp.SucursalFiltro > @SucursalDestinoAnt

    SELECT @SucursalDestino = MIN(SucursalFiltro)
      FROM #WMSSurtidoProcesarD wp
     WHERE wp.SucursalFiltro > @SucursalDestinoAnt

    IF @SucursalDestino IS NULL BREAK

    SELECT @SucursalDestinoAnt = @SucursalDestino

    SELECT @PasilloAnt = ''
    WHILE(1=1)
    BEGIN
--      SELECT @Pasillo = MIN(ap.Pasillo)
--        FROM WMSSurtidoProcesarD wp 
--        JOIN Almpos ap on wp.Almacen = ap.Almacen AND wp. PosicionOrigen = ap.Posicion        
--       WHERE wp.Estacion = @Estacion 
--         AND wp.Procesado = 1 
--         AND wp.Tipo = 'Domicilio' 
--         AND Articulo IN(SELECT DISTINCT Clave FROM ListaSt WHERE Estacion = @Estacion)      
--         AND (wp.PosicionDestino IS NOT NULL AND wp.PosicionDestino <> '') --@Gina 18/04/2014
--         AND wp.SucursalFiltro = @SucursalDestino
--         AND ap.Pasillo > @PasilloAnt

   --   IF EXISTS(SELECT * FROM #WMSSurtidoProcesarD WHERE Pasillo IS NULL) 
	  --BEGIN
   --    SELECT TOP 1 @Ok=13038, @OkRef=PosicionOrigen FROM #WMSSurtidoProcesarD WHERE Pasillo IS NULL
	  -- BREAK
	  --END
	  
      SELECT @Pasillo = MIN(Pasillo)
        FROM #WMSSurtidoProcesarD wp 
       WHERE wp.SucursalFiltro = @SucursalDestino
         AND Pasillo > @PasilloAnt

      IF @Pasillo IS NULL BREAK

      SELECT @PasilloAnt = @Pasillo

      SELECT @ModuloAuxAnt = ''
      WHILE(1=1)
      BEGIN
        SELECT @ModuloAux = MIN(wp.Modulo)
          FROM #WMSSurtidoProcesarD wp 
         WHERE wp.SucursalFiltro = @SucursalDestino
           AND wp.Pasillo = @Pasillo
           AND wp.Modulo > @ModuloAuxAnt
 
        IF @ModuloAux IS NULL BREAK

        SELECT @ModuloAuxAnt = @ModuloAux

        SELECT @IDAuxAnt = 0
        WHILE(1=1)
        BEGIN
   
 
          SELECT @IDAux = MIN(wp.ModuloID)
            FROM #WMSSurtidoProcesarDModulo wp 
           WHERE wp.SucursalFiltro = @SucursalDestino
             AND wp.Pasillo = @Pasillo
             AND wp.Modulo = @ModuloAux
             AND wp.ModuloID > @IDAuxAnt

          IF @IDAux IS NULL BREAK

          SELECT @IDAuxAnt = @IDAux

          SELECT @TarimaSurtido = NULL
          SELECT @TarimaSurtido = TarimaSurtido
            FROM WMSSurtidoProcesarD
           WHERE Modulo = @ModuloAux
             AND ModuloID = @IDAux

          SELECT @Agente = wp.Acomodador,
				 @PosicionDestino = wp.PosicionDestino,
                 @Almacen = wp.Almacen,
                 @Referencia = wp.Referencia
            FROM #WMSSurtidoProcesarD wp 
           WHERE wp.SucursalFiltro = @SucursalDestino
             AND wp.Pasillo = @Pasillo
             AND wp.Modulo = @ModuloAux
             AND wp.ModuloID = @IDAux

          --EWQ Tuning
          --BUG24180
          EXEC spMovInfo  @IDAux, @ModuloAux, @Mov = @Origen OUTPUT, @MovID = @OrigenID OUTPUT, @Observaciones = @OrigenObservaciones OUTPUT

          SELECT DISTINCT @Zona =  wp.Zona      
            FROM #WMSSurtidoProcesarD wp      
           WHERE wp.Estacion = @Estacion AND wp.Procesado = 1 AND wp.Tipo = 'Domicilio' AND wp.Acomodador = @Agente AND wp.PosicionDestino = @PosicionDestino      
             AND Articulo IN(SELECT DISTINCT Clave FROM ListaSt WHERE Estacion = @Estacion)  
             AND (wp.PosicionDestino IS NOT NULL AND wp.PosicionDestino <> '') --@Gina 18/04/2014      


          SELECT TOP 1 @Mov = Mov FROM MovTipo WHERE Clave = 'TMA.OSUR' AND SubClave = 'TMA.OSURP' AND Modulo = 'TMA'        
          SELECT @Observaciones =  'Herramienta',
                 @Estatus = 'SINAFECTAR',       
                 @FechaEmision =  dbo.fnFechaSinHora(GETDATE())        

          --EWQ Tuning
          --BUG24180
          INSERT TMA (Empresa, Sucursal, Usuario, Mov, FechaEmision, Estatus, Almacen, Agente, Zona, Observaciones, TarimaSurtido, Prioridad, Referencia, SucursalFiltro, OrigenTipo, Origen, OrigenID, OrigenObservaciones)
          VALUES     (@Empresa, @Sucursal, @Usuario, @Mov, @FechaEmision, @Estatus, @Almacen, @Agente, @Zona, @Observaciones, @TarimaSurtido, 'Normal', @Referencia, @SucursalDestino, @ModuloAux, @Origen, @OrigenID, @OrigenObservaciones)      

          SET @ID = @@IDENTITY      

          SET @Renglon = 2048

          SELECT @TarimaAnt = ''
          WHILE(1=1)
          BEGIN

            SELECT @Tarima = MIN(wp.Tarima)
              FROM #WMSSurtidoProcesarD wp 
             WHERE wp.SucursalFiltro = @SucursalDestino
               AND wp.Pasillo = @Pasillo
               AND wp.Modulo = @ModuloAux
               AND wp.ModuloID = @IDAux
               AND wp.Tarima > @TarimaAnt
 
            IF @Tarima IS NULL BREAK

            SELECT @TarimaAnt = @Tarima            


			SELECT @ArtTipoOpcion = a.TipoOpcion
              FROM #WMSSurtidoProcesarD wp
			  JOIN Art a ON a.Articulo=wp.Articulo
             WHERE wp.SucursalFiltro = @SucursalDestino
               AND wp.Pasillo = @Pasillo
               AND wp.Modulo = @ModuloAux
               AND wp.ModuloID = @IDAux
               AND wp.Tarima = @TarimaAnt

   --AQUIVOY        
   
		   IF @ArtTipoOpcion='Si'
		   BEGIN
            --BUG3817
            SELECT @SubCuentaAnt = ''
            WHILE(1=1)
            BEGIN

              SELECT @SubCuentaAct = MIN(wp.SubCuenta)
              FROM #WMSSurtidoProcesarD wp 
             WHERE wp.SucursalFiltro = @SucursalDestino
               AND wp.Pasillo = @Pasillo
               AND wp.Modulo = @ModuloAux
               AND wp.ModuloID = @IDAux
               AND wp.Tarima = @TarimaAnt
               AND wp.SubCuenta > @SubCuentaAnt

               IF @SubCuentaAct IS NULL BREAK
			   
               SELECT @SubCuentaAnt = @SubCuentaAct

               SELECT @Renglon = @Renglon + 2048

			SELECT @PosicionOrigen = PosicionOrigen, 
				   @PosicionDestino = PosicionDestino, 
		           @CantidadTarima = SUM(CantidadTarima), 
				   @Zona = wp.Zona, 
				   @Unidad = Unidad,
				   @CantidadUnidad = SUM(CantidadUnidad),
				   --TASK2429PGC
				   @ArticuloAux=Articulo,
				   @SubCuentaAux=SubCuenta, 
				   @TarimaFechaCaducidadAux=TarimaFechaCaducidad --BUG3786
              FROM #WMSSurtidoProcesarD wp 
             WHERE wp.SucursalFiltro = @SucursalDestino
               AND wp.Pasillo = @Pasillo
               AND wp.Modulo = @ModuloAux
               AND wp.ModuloID = @IDAux
               AND wp.Tarima = @Tarima
			   AND wp.SubCuenta=@SubCuentaAct --BUG3817
             GROUP BY PosicionOrigen, PosicionDestino, wp.Zona, Unidad, Articulo, SubCuenta, TarimaFechaCaducidad --TASLK2429PGC --BUG3687 29092015

			UPDATE Tarima SET Posicion = @PosicionOrigen WHERE Tarima = @Tarima 

            IF @ModuloAux = 'VTAS'
                SELECT @ArtCambioClave = VD.ArtCambioClave
                    FROM VentaD VD
                    JOIN Venta V ON VD.ID = V.ID
                    WHERE V.Mov = @Origen
                      AND V.MovId = @OrigenID
                      AND VD.Articulo = @ArticuloAux
                      AND v.ID = @IDAux
            
    		INSERT TMAD (ID, Sucursal, Renglon, Tarima, Almacen, Posicion, PosicionDestino, CantidadPicking, Zona, Prioridad, Montacarga, EstaPendiente, Procesado, Unidad,  CantidadUnidad, Articulo, SubCuenta, FechaCaducidad, ArtCambioClave) --REQ 14684 --TASK2429PGC --BUG3786
    		VALUES      (@ID, @Sucursal, @Renglon, @Tarima, @Almacen, @PosicionOrigen, @PosicionDestino, @CantidadTarima, @Zona, 'Normal', @Agente, 1,   0,         @Unidad, @CantidadUnidad, @ArticuloAux, @SubCuentaAux, @TarimaFechaCaducidadAux, @ArtCambioClave) --REQ 14684 --TASK2429PGC --BUG3786

            DECLARE crSerieLote CURSOR LOCAL STATIC FOR      
             SELECT SUM(slm.Cantidad),
                    MAX(slm.Propiedades),
                    slm.SerieLote
               FROM SerieLoteMov slm
              WHERE slm.ID = @IDAux
                AND slm.Modulo = @ModuloAux
                AND slm.Articulo = @ArticuloAux
                AND ISNULL(slm.SubCuenta,'') = ISNULL(@SubCuentaAux,'')
                AND slm.SerieLote = @SerieLote
                AND slm.Tarima = @Tarima
		   GROUP BY slm.SerieLote

            OPEN crSerieLote    
            FETCH NEXT FROM crSerieLote INTO @CantidadSerieLote, @Propiedades, @SerieLote
            WHILE @@FETCH_STATUS = 0      
            BEGIN  
				IF @CantidadSerieLote > @CantidadTarima
					SET @CantidadSerieLote = @CantidadTarima
                INSERT SerieLoteMov
                       (Empresa,  Sucursal,  Modulo,  ID,  RenglonID,  Articulo,  SubCuenta, SerieLote, Cantidad, Propiedades, Tarima, AsignacionUbicacion)
                VALUES (@Empresa, @Sucursal, 'TMA', @ID, @Renglon, @ArticuloAux, ISNULL(@SubCuentaAux,''), @SerieLote, @CantidadSerieLote, @Propiedades, @Tarima, 0)

                FETCH NEXT FROM crSerieLote INTO @CantidadSerieLote, @Propiedades, @SerieLote
            END      
            CLOSE crSerieLote      
            DEALLOCATE crSerieLote
           END
		   END  /*** OPCIONES **/
           ELSE
		   BEGIN
		    --BUG3817
		    SELECT @Renglon = @Renglon + 2048 --BUG3817

			SELECT @PosicionOrigen = PosicionOrigen, 
				   @PosicionDestino = PosicionDestino, 
		           @CantidadTarima = SUM(CantidadTarima), 
				   @Zona = wp.Zona, 
				   @Unidad = Unidad,
				   @CantidadUnidad = SUM(CantidadUnidad),
				   --TASK2429PGC
				   @ArticuloAux=Articulo,
				   @SubCuentaAux=SubCuenta,
				   @TarimaFechaCaducidadAux=TarimaFechaCaducidad --BUG3786
              FROM #WMSSurtidoProcesarD wp 
             WHERE wp.SucursalFiltro = @SucursalDestino
               AND wp.Pasillo = @Pasillo
               AND wp.Modulo = @ModuloAux
               AND wp.ModuloID = @IDAux
               AND wp.Tarima = @Tarima
             GROUP BY PosicionOrigen, PosicionDestino, wp.Zona, Unidad, Articulo, SubCuenta, TarimaFechaCaducidad --TASLK2429PGC --BUG3687 29092015

			UPDATE Tarima SET Posicion = @PosicionOrigen WHERE Tarima = @Tarima                
            
            
            IF @ModuloAux = 'VTAS'
                SELECT @ArtCambioClave = VD.ArtCambioClave
                    FROM VentaD VD
                    JOIN Venta V ON VD.ID = V.ID
                    WHERE V.Mov = @Origen
                        AND V.MovId = @OrigenID
                        AND VD.Articulo = @ArticuloAux
                        AND v.ID = @IDAux                        

    		INSERT TMAD (ID, Sucursal, Renglon, Tarima, Almacen, Posicion, PosicionDestino, CantidadPicking, Zona, Prioridad, Montacarga, EstaPendiente, Procesado, Unidad,  CantidadUnidad, Articulo, SubCuenta, FechaCaducidad, ArtCambioClave) --REQ 14684 --TASK2429PGC --BUG3786
    		VALUES      (@ID, @Sucursal, @Renglon, @Tarima, @Almacen, @PosicionOrigen, @PosicionDestino, @CantidadTarima, @Zona, 'Normal', @Agente, 1,   0,         @Unidad, @CantidadUnidad, @ArticuloAux, @SubCuentaAux, @TarimaFechaCaducidadAux, @ArtCambioClave) --REQ 14684 --TASK2429PGC --BUG3786

            DECLARE crSerieLote CURSOR LOCAL STATIC FOR      
             SELECT SUM(slm.Cantidad),
                    MAX(slm.Propiedades),
                    slm.SerieLote
               FROM SerieLoteMov slm
              WHERE slm.ID = @IDAux
                AND slm.Modulo = @ModuloAux
                AND slm.Articulo = @ArticuloAux
                AND ISNULL(slm.SubCuenta,'') = ISNULL(@SubCuentaAux,'')
                --AND slm.SerieLote = @SerieLote
                AND slm.Tarima = @Tarima
		   GROUP BY slm.SerieLote

            OPEN crSerieLote    
            FETCH NEXT FROM crSerieLote INTO @CantidadSerieLote, @Propiedades, @SerieLote
            WHILE @@FETCH_STATUS = 0      
            BEGIN  
				IF @CantidadSerieLote > @CantidadTarima
					SET @CantidadSerieLote = @CantidadTarima
                INSERT SerieLoteMov
                       (Empresa,  Sucursal,  Modulo,  ID,  RenglonID,  Articulo,  SubCuenta, SerieLote, Cantidad, Propiedades, Tarima, AsignacionUbicacion)
                VALUES (@Empresa, @Sucursal, 'TMA', @ID, @Renglon, @ArticuloAux, ISNULL(@SubCuentaAux,''), @SerieLote, @CantidadSerieLote, @Propiedades, @Tarima, 0)

                FETCH NEXT FROM crSerieLote INTO @CantidadSerieLote, @Propiedades, @SerieLote
            END      
            CLOSE crSerieLote      
            DEALLOCATE crSerieLote

		   END  /*** nORMAL **/

		  END

          IF @Ok IS NULL      
            EXEC spAfectar 'TMA', @ID, 'AFECTAR', @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT        

          IF @Ok IS NULL
          BEGIN
            SELECT @TarimaSurtido = NULL
            
            SELECT @TarimaSurtido = TarimaSurtido FROM TMA WHERE ID = @ID

            UPDATE WMSModuloTarima SET IDTMA = @ID, TarimaSurtido = @TarimaSurtido       
             WHERE IDModulo = @IDAux
               AND Modulo  = @ModuloAux

            --EWQ Tuning
            DECLARE crMovFlujo CURSOR LOCAL STATIC FOR
             SELECT DISTINCT t.Modulo, t.IDModulo
               FROM WMSModuloTarima t
               JOIN WMSLista l ON t.IDModulo = l.IDModulo AND t.Modulo = l.Modulo
              WHERE l.Estacion = @Estacion
              --EWQ Tuning
                AND t.Modulo = @ModuloAux AND t.IDModulo = @IDAux         

	        OPEN crMovFlujo
	        FETCH NEXT FROM crMovFlujo INTO @ModuloD, @IDModuloD
	        WHILE @@FETCH_STATUS = 0 AND @OK = NULL
	        BEGIN
		      SELECT @Mov = NULL, @MovID = NULL
		      IF @ModuloD = 'VTAS' SELECT @Mov = Mov, @MovID = MovID FROM Venta WHERE ID = @IDModuloD ELSE
		      IF @ModuloD = 'COMS' SELECT @Mov = Mov, @MovID = MovID FROM Compra WHERE ID = @IDModuloD ELSE
		      IF @ModuloD = 'INV'  SELECT @Mov = Mov, @MovID = MovID FROM Inv WHERE ID = @IDModuloD ELSE
		      IF @ModuloD = 'PROD' SELECT @Mov = Mov, @MovID = MovID FROM Prod WHERE ID = @IDModuloD


              SELECT @MovDestino = Mov, @MovDestinoID = MovID FROM TMA WHERE ID = @ID

		      IF @Mov IS NOT NULL AND @MovID IS NOT NULL AND @MovDestino IS NOT NULL AND @MovDestinoID IS NOT NULL
		        EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @ModuloD, @IDModuloD, @Mov, @MovID, 'TMA', @ID, @MovDestino, @MovDestinoID, @Ok OUTPUT

              FETCH NEXT FROM crMovFlujo INTO @ModuloD, @IDModuloD
	        END

	        CLOSE crMovFlujo
	        DEALLOCATE crMovFlujo
          END

        END
      END
    END
  END

  DELETE @WMSSurtidoProcesarDTotal    
  INSERT @WMSSurtidoProcesarDTotal    
  SELECT Modulo, ModuloID, Articulo, wp.Almacen,SUM(wp.CantidadTarima), wp.SubCuenta, wp.SerieLote --TASK2429PGC      
      FROM WMSSurtidoProcesarD wp      
   WHERE wp.Estacion = @Estacion AND wp.Procesado = 1 AND Articulo IN(SELECT DISTINCT Clave FROM ListaSt WHERE Estacion = @Estacion)      
   AND (wp.PosicionDestino IS NOT NULL AND wp.PosicionDestino <> '') --@gina 18/04/2014
   --AND wp.Tipo = 'Domicilio'
   GROUP BY Modulo, ModuloID, Articulo,wp.Almacen, wp.SubCuenta, wp.SerieLote --TASK2429PGC       

  SELECT @ModuloAuxAnt = ''
  WHILE(1=1)
  BEGIN
    SELECT @ModuloAux = MIN(wp.Modulo)
      FROM WMSSurtidoProcesarD wp 
      --JOIN Almpos ap on wp.Almacen = ap.Almacen AND wp. PosicionOrigen = ap.Posicion        
     WHERE wp.Estacion = @Estacion 
       AND wp.Procesado = 1 
       --AND wp.Tipo = 'Domicilio' 
       AND Articulo IN(SELECT DISTINCT Clave FROM ListaSt WHERE Estacion = @Estacion)      
       AND (wp.PosicionDestino IS NOT NULL AND wp.PosicionDestino <> '') --@Gina 18/04/2014
       AND wp.Modulo > @ModuloAuxAnt

    IF @ModuloAux IS NULL BREAK

    SELECT @ModuloAuxAnt = @ModuloAux

    SELECT @IDAuxAnt = 0
    WHILE(1=1)
    BEGIN
      SELECT @IDAux = MIN(wp.ModuloID)
        FROM WMSSurtidoProcesarD wp 
        --JOIN Almpos ap on wp.Almacen = ap.Almacen AND wp. PosicionOrigen = ap.Posicion        
       WHERE wp.Estacion = @Estacion 
         AND wp.Procesado = 1 
         --AND wp.Tipo = 'Domicilio' 
         AND Articulo IN(SELECT DISTINCT Clave FROM ListaSt WHERE Estacion = @Estacion)      
         AND (wp.PosicionDestino IS NOT NULL AND wp.PosicionDestino <> '') --@Gina 18/04/2014
         AND wp.Modulo = @ModuloAux
         AND wp.ModuloID > @IDAuxAnt

      IF @IDAux IS NULL BREAK

      SELECT @IDAuxAnt = @IDAux

      SELECT @TarimaSurtido =  NULL
      
      SELECT @TarimaSurtido = TarimaSurtido 
        FROM WMSSurtidoProcesarD 
       --BUG24306
       WHERE /*Estacion = @Estacion
         AND Procesado = 1
         AND */Modulo = @ModuloAux
         AND ModuloID = @IDAux

      SELECT @IDTarimaAnt = 0
      WHILE(1=1)
      BEGIN
        SELECT @IDTarima = MIN(ID)
          FROM WMSModuloTarima
         WHERE Modulo = @ModuloAux
           AND IDModulo = @IDAux
           AND ID > @IDTarimaAnt

        IF @IDTarima IS NULL BREAK

        SELECT @IDTarimaAnt = @IDTarima

        SELECT @ArticuloWMS = Articulo, 
               @AlmacenWMS = Almacen, 
               @ModuloWMS = @ModuloAux, 
               @IDModuloWMS = @IDAux, 
               @RenglonWMS = Renglon, 
               @RenglonSubWMS = RenglonSub,
               @SubCuentaWMS = SubCuenta --TASK2429PGC
          FROM WMSModuloTarima
         WHERE Modulo = @ModuloAux
           AND IDModulo = @IDAux
           AND ID = @IDTarima

        SELECT @CantidadWMS = (SELECT SUM(CantidadTarima) FROM @WMSSurtidoProcesarDTotal WHERE Articulo = @ArticuloWMS AND Almacen = @AlmacenWMS AND Modulo = @ModuloWMS AND ModuloID = @IDModuloWMS AND SubCuenta=@SubCuentaWMS) --TASK2429PGC

        EXEC spWMSDividirPorReservadoPck @IDModuloWMS, @ModuloWMS, @Empresa, @ArticuloWMS, @SubCuentaWMS, @AlmacenWMS, @CantidadWMS, @TarimaSurtido, @Usuario, @Estacion, @RenglonWMS, @RenglonSubWMS, @Ok OUTPUT, @OkRef OUTPUT --TASK2429PGC

        UPDATE WMSModuloTarima       
           SET IDTMA = 0,      
               Cantidad = Cantidad - ISNULL(CASE WHEN @CantidadTarima >= @CantidadWMS THEN @CantidadWMS ELSE @CantidadTarima END, 0)
         WHERE ID = @IDTarima
           --EWQ. Tuning
           AND Modulo = @ModuloWMS AND IDModulo = @IDModuloWMS
      END

      IF @ModuloWMS = 'VTAS' UPDATE VentaD  SET Tarima = NULL WHERE ID = @IDModuloWMS AND Tarima = 'tmpTarimaDividir'
      IF @ModuloWMS = 'COMS' UPDATE CompraD SET Tarima = NULL WHERE ID = @IDModuloWMS AND Tarima = 'tmpTarimaDividir'
      IF @ModuloWMS = 'INV'  UPDATE InvD    SET Tarima = NULL WHERE ID = @IDModuloWMS AND Tarima = 'tmpTarimaDividir'

     END
  END

  /* Al Explosionar con Cross Docking Genera Surtido */
  BEGIN
    DECLARE crDisponible CURSOR LOCAL STATIC FOR      
     SELECT Articulo, Almacen, Tipo, 0 Cantidad, Unidad, SUM(CantidadUnidad), Articulo, SubCuenta,
	        TarimaFechaCaducidad
       FROM WMSSurtidoProcesarD       
      WHERE Estacion = @Estacion AND Procesado = 0      
        AND Articulo IN(SELECT DISTINCT Clave FROM ListaSt WHERE Estacion = @Estacion)      
         AND Tipo = 'Cross Docking' 
        AND (PosicionDestino IS NOT NULL AND PosicionDestino <> '' )
		AND NULLIF(SubCuenta,'') IS NULL 
      GROUP BY Articulo, Almacen, Tipo, Unidad, Articulo, SubCuenta, TarimaFechaCaducidad 

    OPEN crDisponible      
    FETCH NEXT FROM crDisponible INTO @Articulo, @Almacen, @Tipo, @CantidadTarima, @Unidad, @CantidadUnidad, @ArticuloAux, @SubCuentaAux, @TarimaFechaCaducidad --REQ 14684 --TASK2429PGC --BUG3786
    WHILE @@FETCH_STATUS = 0      
    BEGIN    
      SELECT @Ordenes = 0   

      UPDATE WMSSurtidoProcesarD SET Procesado = 1 WHERE Estacion = @Estacion AND Articulo = @Articulo AND Procesado = 0 AND (PosicionDestino IS NOT NULL AND PosicionDestino <> '') AND Tipo = 'Cross Docking'   
      
	  /* Se crea la Solicitud Reacomodo si se llega al minimo en domicilio */
      DECLARE crMinimo CURSOR LOCAL FOR  
        SELECT SUM(d.Disponible) Disponible, a.MinimoTarima, SUM(d.Disponible) - @CantidadTarima - @Ordenes Resultado          
         FROM ArtDisponibleTarima d   
         JOIN Tarima t ON d.Tarima = t.Tarima AND d.Almacen = t.Almacen
         JOIN AlmPos p ON t.Almacen = p.Almacen AND p.Posicion = t.Posicion 
         JOIN Art a ON d.Articulo = a.Articulo           
        WHERE p.Tipo = 'Cross Docking'   
          AND d.Articulo = @Articulo  
          AND t.Estatus = 'ALTA'  
          AND p.Estatus = 'ALTA'  
        GROUP BY d.Articulo, a.MinimoTarima 
  
      OPEN crMinimo  
      FETCH NEXT FROM crMinimo INTO @Disponible, @MinimoTarima, @Resultado  
      WHILE @@FETCH_STATUS = 0  
      BEGIN                  
        SELECT @Contador = 0

        WHILE @Resultado < @MinimoTarima  
        BEGIN  
          SELECT @Tarima = NULL, @DisponibleTarima = NULL, @PosicionOrigen = NULL  
          SELECT @ControlArticulo = ControlArticulo FROM Art WHERE Articulo = @Articulo  

		  IF NOT EXISTS(SELECT * FROM SerieLoteMov WHERE Modulo=@ModuloWMS AND ID=@IDModuloWMS) 
            EXEC spTMAExplocionTarima @Almacen, @Articulo, NULL, @ControlArticulo, 'Cross Docking', @Estacion, @Tarima OUTPUT, @Disponible OUTPUT, @PosicionOrigen OUTPUT  
		  ELSE
            EXEC spTMAExplocionTarimaSerieLote @ModuloWMS, @IDAux, @Almacen, @Articulo, NULL, @ControlArticulo, 'Cross Docking', NULL, @Tarima OUTPUT, @Disponible OUTPUT, NULL, @RenglonID, @SerieLote
  
          SELECT TOP 1 @PosicionDestino = Posicion FROM AlmPos WHERE ArticuloEsp = @Articulo AND Tipo = @Tipo AND Almacen = @Almacen  
          IF @Contador = 0  
            SELECT @Resultado = @Resultado + ISNULL(SUM(ISNULL(a.Disponible,0)),0)  
              FROM TMA t   
              JOIN TMAD d on t.id = d.id   
              JOIN ArtDisponibleTarima a ON d.Tarima = a.Tarima AND a.Articulo = @Articulo AND a.Almacen = d.Almacen 
              JOIN MovTipo m ON m.Mov = t.Mov AND m.Modulo = 'TMA'  
             WHERE m.Clave = 'TMA.SRADO'
               AND t.Estatus = 'PENDIENTE'
               AND d.PosicionDestino = @PosicionDestino            
              
          IF @Resultado < @MinimoTarima AND @Tarima IS NOT NULL  
          BEGIN         
            SELECT @Mov = TMASolicitudReacomodo FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa
            SELECT @TarimasReacomodar = ISNULL(TarimasReacomodar,0) FROM Art WHERE Articulo = @Articulo
            IF ISNULL(@TarimasReacomodar,0) = 0
              SET @TarimasReacomodar = 1

            INSERT TMA (Empresa, Sucursal,   Usuario,  Mov,  FechaEmision,  Estatus,       Almacen,  TarimaSurtido,  Prioridad, Referencia)  
            VALUES     (@Empresa, @Sucursal, @Usuario, @Mov, @FechaEmision, 'SINAFECTAR', @Almacen, @TarimaSurtido, 'Media',  'Herramienta de Surtido')
            SET @IDDestino = @@IDENTITY  
            SET @Renglon = 0  
            SET @Reacomodar = 1

            WHILE @Reacomodar < = @TarimasReacomodar 
            BEGIN
              SELECT @TarimaN = MIN(Tarima)
                FROM ArtDisponibleTarima 
               WHERE Articulo = @Articulo 
                 AND Almacen = @Almacen 
                 AND Disponible >= @Disponible
                 AND Tarima NOT IN (SELECT Tarima FROM @TarimaDisp)
                 AND Tarima >= @Tarima
              INSERT @TarimaDisp(Tarima)VALUES(@TarimaN)
              
              INSERT TMAD (ID,         Sucursal,  Renglon,  Tarima,                   Almacen,  Posicion,        PosicionDestino,  CantidadPicking, Prioridad, EstaPendiente, Procesado, Unidad,  CantidadUnidad, Articulo, SubCuenta, FechaCaducidad) --REQ 14684 --TASK2429PGC
              SELECT       @IDDestino, @Sucursal, @Renglon, ISNULL(@TarimaN,@Tarima), @Almacen, @PosicionOrigen, @PosicionDestino, @Disponible,     'Media',   1,             0,         @Unidad, @CantidadUnidad, @ArticuloAux, @SubCuentaAux, @TarimaFechaCaducidad --REQ 14684 --TASK2429PGC --BUG3786
              SET @Renglon = @Renglon +2048  
              SET @Reacomodar = @Reacomodar +1
            END

            IF @Ok IS NULL AND @IDDestino IS NOT NULL AND EXISTS (SELECT * FROM TMAD WHERE ID = @IDDestino) AND @Tarima IS NOT NULL  
            BEGIN  
              EXEC spAfectar 'TMA', @IDDestino, 'Afectar', @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT      

              SELECT @MovDestino = Mov, @MovDestinoID = MovID FROM TMA WHERE ID = @IDDestino  
              EXEC spMovFlujo @Sucursal, Afectar, @Empresa, 'TMA', @ID, @Mov, @MovID, 'TMA', @IDDestino, @MovDestino, @MovDestinoID, @Ok OUTPUT  
            END          
            ELSE  
              DELETE TMA where ID = @IDDestino  
                    
            SELECT @Resultado = @Resultado + @DisponibleTarima  
            SELECT @Contador = 1                
          END  
                        
          IF @Tarima IS NULL  
            SELECT @Resultado = @MinimoTarima  
        END     
        FETCH NEXT FROM crMinimo INTO @Disponible, @MinimoTarima, @Resultado  
      END  
      CLOSE crMinimo  
      DEALLOCATE crMinimo  
			
			/* Se crea el movimiento Surtido en TMA(WMS) Cuando es Cross Docking */
            DECLARE crUbicacion CURSOR LOCAL STATIC FOR     
                SELECT wp.Modulo, wp.ModuloID,   
                        @Empresa, @Sucursal,        
                        @Usuario, dbo.fnFechaSinHora(GETDATE()), 'SINAFECTAR',        
                        wp.Almacen,        
                        wp.Acomodador, wp.Zona, 'Herramienta',   
                        wp.PosicionOrigen, wp.PosicionDestino, SUM(wp.CantidadTarima), wP.Tarima, wp.Referencia, wp.Unidad, SUM(wp.CantidadUnidad),     
                        wp.SucursalFiltro,  
                        wp.TarimaSurtido,  
                  wp.Articulo,  
                  wp.SubCuenta,  
                  WP.TarimaFechaCaducidad,  
                  WP.PCKUbicacion,  
                        WP.SerieLote   
                FROM WMSSurtidoProcesarD wp inner join almpos ap on wp.Almacen = ap.Almacen AND wp. PosicionOrigen = ap.Posicion            
                WHERE wp.Estacion = @Estacion AND wp.Procesado = 1 AND wp.Tipo = 'Cross Docking'  AND Articulo IN (SELECT DISTINCT Clave FROM ListaSt WHERE Estacion = @Estacion)        
                AND (wp.PosicionDestino IS NOT NULL AND wp.PosicionDestino <> '')   
                AND wp.Articulo = @Articulo AND wp.Almacen = @Almacen AND wp.Unidad = ISNULL(@Unidad,wp.Unidad) AND ISNULL(wp.TarimaFechaCaducidad,1) = ISNULL(ISNULL(@TarimaFechaCaducidad, wp.TarimaFechaCaducidad),1)  
                GROUP BY wp.Modulo, wp.ModuloID, wp.Almacen, wp.Acomodador, wp.Zona, wp.PosicionOrigen,  
                         wp.PosicionDestino, wp.CantidadTarima, wP.Tarima, wp.Referencia, wp.Unidad, wp.SucursalFiltro, wp.TarimaSurtido, wp.Articulo, wp.SubCuenta,  
                         WP.TarimaFechaCaducidad, WP.PCKUbicacion,WP.SerieLote

            OPEN crUbicacion    
            FETCH NEXT FROM crUbicacion INTO @ModuloAux, @IDAux, @Empresa, @Sucursal, @Usuario, @FechaEmision, @Estatus, @Almacen, @Agente, @Zona, @Observaciones, @PosicionOrigen, @PosicionDestino, @CantidadTarima, @Tarima, @Referencia, @Unidad, @CantidadUnidad, @SucursalDestino, @TarimaSurtido, @ArticuloAux, @SubCuentaAux, @TarimaFechaCaducidadAux, @PCKUbicacion, @SerieLote --REQ 14684 --TASK2429PGC --BUG3786 --TASK6535
            WHILE @@FETCH_STATUS = 0      
            BEGIN  
	            SELECT @Mov = Mov FROM MovTipo WHERE Clave = 'TMA.OSUR' AND Modulo = 'TMA' AND SubClave IS NULL   

            EXEC spMovInfo  @IDAux, @ModuloAux, @Mov = @Origen OUTPUT, @MovID = @OrigenID OUTPUT, @Observaciones = @OrigenObservaciones OUTPUT

            IF @ModuloAux = 'VTAS'
                SELECT @ArtCambioClave = VD.ArtCambioClave
                    FROM VentaD VD
                    JOIN Venta V ON VD.ID = V.ID
                    WHERE V.Mov = @Origen
                      AND V.MovId = @OrigenID
                      AND VD.Articulo = @ArticuloAux
                      AND v.ID = @IDAux

            INSERT TMA (Empresa, Sucursal, Usuario, Mov, FechaEmision, Estatus, Almacen, Agente, Zona, Observaciones, TarimaSurtido, Prioridad, Referencia, SucursalFiltro, OrigenTipo, Origen, OrigenID, OrigenObservaciones)      
            VALUES     (@Empresa, @Sucursal, @Usuario, @Mov, @FechaEmision, @Estatus, @Almacen, @Agente, @Zona, @Observaciones, @TarimaSurtido, 'Normal', @Referencia, @SucursalDestino, @ModuloAux, @Origen, @OrigenID, @OrigenObservaciones)      
                
                SET @ID = @@IDENTITY      
 
            UPDATE Tarima SET Posicion = @PosicionOrigen WHERE Tarima = @Tarima               
            INSERT TMAD (ID, Sucursal, Renglon, Tarima, Almacen, Posicion, PosicionDestino, CantidadPicking, Zona, Prioridad, Montacarga, EstaPendiente, Procesado, Unidad,  CantidadUnidad, Articulo, SubCuenta, FechaCaducidad, ArtCambioClave) 
            VALUES      (@ID, @Sucursal, 2048, @Tarima, @Almacen, @PosicionOrigen, @PosicionDestino, @CantidadTarima, @Zona, 'Normal', @Agente, 1,  0,         @Unidad, @CantidadUnidad, @ArticuloAux, @SubCuentaAux, @TarimaFechaCaducidadAux, @ArtCambioClave)

            DECLARE crSerieLote CURSOR LOCAL STATIC FOR      
             SELECT slm.SerieLote,
					SUM(slm.Cantidad),
					MAX(slm.Propiedades)
               FROM SerieLoteMov slm
              WHERE slm.ID = @IDAux
                AND slm.Modulo = @ModuloAux
                AND slm.Articulo = @ArticuloAux
                AND ISNULL(slm.SubCuenta,'') = ISNULL(@SubCuentaAux,'')
                AND slm.SerieLote = @SerieLote
		   GROUP BY slm.SerieLote

            OPEN crSerieLote    
            FETCH NEXT FROM crSerieLote INTO @SerieLote, @CantidadSerieLote, @Propiedades
            WHILE @@FETCH_STATUS = 0      
            BEGIN  
				IF @CantidadSerieLote > @CantidadTarima
					SET @CantidadSerieLote = @CantidadTarima
                INSERT SerieLoteMov
                       (Empresa,  Sucursal,  Modulo,  ID,  RenglonID,  Articulo,  SubCuenta, SerieLote, Cantidad, Propiedades, Tarima, AsignacionUbicacion)
                VALUES (@Empresa, @Sucursal, 'TMA', @ID, 2048, @ArticuloAux, ISNULL(@SubCuentaAux,''), @SerieLote, @CantidadSerieLote, @Propiedades, @Tarima, 0)

                FETCH NEXT FROM crSerieLote INTO @SerieLote, @CantidadSerieLote, @Propiedades
            END      
            CLOSE crSerieLote      
            DEALLOCATE crSerieLote 

            IF @OK IS NULL      
                EXEC spAfectar 'TMA', @ID, 'AFECTAR', @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT      

            IF @OK IS NULL      
            BEGIN
                SELECT @MovDestino = Mov, @MovDestinoID = MovID FROM TMA WHERE ID = @ID

                EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @ModuloAux, @IDAux, @Origen, @OrigenID, 'TMA', @ID, @MovDestino, @MovDestinoID, @Ok OUTPUT      
            END
     
	        /* Este codigo es para que actualice a la Tarima de Surtido el pedido, etc ... */
			SELECT  @ArticuloWMS = Articulo, 
                    @AlmacenWMS = Almacen, 
                    @ModuloWMS = @ModuloAux, 
                    @IDModuloWMS = @IDAux, 
                    @RenglonWMS = Renglon, 
                    @RenglonSubWMS = RenglonSub,
                    @SubCuentaWMS = SubCuenta
              FROM WMSModuloTarima
             WHERE Modulo = @ModuloAux
               AND IDModulo = @IDAux

            DELETE @WMSSurtidoProcesarDTotal 
             
            INSERT @WMSSurtidoProcesarDTotal    
            SELECT Modulo, ModuloID, Articulo, wp.Almacen,SUM(wp.CantidadTarima), wp.SubCuenta, wp.SerieLote     
              FROM WMSSurtidoProcesarD wp      
             WHERE wp.Estacion = @Estacion AND wp.Procesado = 1 AND Articulo IN(SELECT DISTINCT Clave FROM ListaSt WHERE Estacion = @Estacion)      
               AND (wp.PosicionDestino IS NOT NULL AND wp.PosicionDestino <> '') 
               AND wp.Tipo = 'Cross Docking'
             GROUP BY Modulo, ModuloID, Articulo,wp.Almacen, SubCuenta, wp.SerieLote 

            SELECT @CantidadWMS = (SELECT SUM(CantidadTarima) FROM @WMSSurtidoProcesarDTotal WHERE Articulo = @Articulo AND Almacen = @Almacen AND Modulo = @ModuloAux AND ModuloID = @IDModuloWMS AND SubCuenta=@SubCuentaWMS)        
                        
            IF NOT EXISTS (SELECT * FROM @WMSSurtidoCD WHERE ModuloID = @IDModuloWMS AND Modulo = @ModuloAux AND Articulo = @Articulo AND Almacen = @Almacen)
                EXEC spWMSDividirPorReservadoPck @IDModuloWMS, @ModuloAux, @Empresa, @Articulo, @SubCuentaWMS, @Almacen, @CantidadWMS, @TarimaSurtido, @Usuario, @Estacion, @RenglonWMS, @RenglonSubWMS, @Ok OUTPUT, @OkRef OUTPUT            

                
            INSERT @WMSSurtidoCD (Modulo,     ModuloID,     Articulo,  Almacen)  
                           SELECT @ModuloAux, @IDModuloWMS, @Articulo, @Almacen


            FETCH NEXT FROM crUbicacion INTO @ModuloAux, @IDAux, @Empresa, @Sucursal, @Usuario, @FechaEmision, @Estatus, @Almacen, @Agente, @Zona, @Observaciones, @PosicionOrigen, @PosicionDestino, @CantidadTarima, @Tarima, @Referencia, @Unidad, @CantidadUnidad, @SucursalDestino, @TarimaSurtido, @ArticuloAux, @SubCuentaAux, @TarimaFechaCaducidadAux, @PCKUbicacion, @SerieLote --REQ 14684 --TASK2429PGC --BUG3786 --TASK6535
            END      
            CLOSE crUbicacion      
            DEALLOCATE crUbicacion    
      
      FETCH NEXT FROM crDisponible INTO @Articulo, @Almacen, @Tipo, @CantidadTarima, @Unidad, @CantidadUnidad, @ArticuloAux, @SubCuentaAux, @TarimaFechaCaducidad --REQ 14684 --TASK2429PGC --BUG3786    
    END      
    CLOSE crDisponible      
    DEALLOCATE crDisponible
  END

  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000 OR @Ok = 80010      
  BEGIN     
    COMMIT TRAN HMp
	SELECT 'Procesadas Con Éxito'
  END      
  ELSE      
  BEGIN      
    ROLLBACK TRAN HMp      
    SELECT @OkRef =  ISNULL(Descripcion,'') + '. Posición: ' + RTRIM(LTRIM(@OkRef))FROM MensajeLista WHERE Mensaje = @Ok        
    SELECT 'Error ' + CONVERT(varchar,@Ok) + ' ' + ISNULL(@OkRef,'')      
  END      
  RETURN
END 
GO

--REQ12615 WMS
/**************** spWMSModuloMovimiento ****************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'spWMSModuloMovimiento' AND type = 'P') DROP PROCEDURE spWMSModuloMovimiento
GO
CREATE PROCEDURE spWMSModuloMovimiento  
    @Modulo		varchar(5),
    @Mov		varchar(20),
    @Tipo		varchar(10)
--//WITH ENCRYPTION
AS BEGIN     
  IF @Modulo = 'WMS' SELECT @Modulo = 'TMA'
  
  IF @Mov = ''
  BEGIN
    IF @Modulo = 'INV'
    BEGIN    
      IF @Tipo = 'Acomodo'
        SELECT Mov FROM MovTipo WHERE Modulo = @Modulo AND Clave IN ('INV.DTI' ,'INV.TMA' ,'INV.E', 'INV.EI', 'INV.T', 'INV.TIS') ORDER BY Orden --BUG25093
      IF @Tipo = 'Surtido'      
        SELECT Mov FROM MovTipo WHERE Modulo = @Modulo AND Clave IN ('INV.OT', 'INV.OI')
        UNION
        SELECT Mov FROM MovTipo WHERE Modulo = @Modulo AND Clave = 'INV.SOL' AND ISNULL(SubClave,'') <> 'INV.ENT'
      IF @Tipo = 'Destino'       
        SELECT Mov FROM MovTipo WHERE Modulo = @Modulo AND Clave = 'INV.S' AND Subclave = 'INV.SCHEP' OR Modulo = @Modulo ORDER BY Orden
    END
    ELSE
    IF @Modulo = 'COMS'
    BEGIN    
      IF @Tipo = 'Acomodo'
        SELECT Mov FROM MovTipo WHERE Modulo = @Modulo AND Clave IN ('COMS.B', 'COMS.FL', 'COMS.F', 'COMS.EG', 'COMS.EI') ORDER BY Orden
      IF @Tipo = 'Surtido'
        SELECT Mov FROM MovTipo WHERE Modulo = @Modulo AND Clave IN ('COMS.OD') ORDER BY Orden
    END
    ELSE
    IF @Modulo = 'VTAS'
    BEGIN
      IF @Tipo = 'Acomodo'
        SELECT Mov FROM MovTipo WHERE Modulo = @Modulo AND Clave IN ('VTAS.D') ORDER BY Orden
      IF @Tipo = 'Surtido'
        SELECT Mov FROM MovTipo WHERE Modulo = @Modulo AND Clave IN ('VTAS.P') ORDER BY Orden
    END    
    ELSE
    IF @Modulo = 'TMA'
    BEGIN
      IF @Tipo = 'Acomodo'
        SELECT Mov FROM MovTipo WHERE Modulo = @Modulo AND Clave IN ('TMA.SADO', 'TMA.SRADO') ORDER BY Orden
      IF @Tipo = 'Surtido'
        SELECT Mov FROM MovTipo WHERE Modulo = @Modulo AND Clave IN ('TMA.SADO', 'TMA.SRADO') ORDER BY Orden      
    END
	--BUG2563
	IF @Modulo = 'PROD'
    BEGIN
      IF @Tipo = 'Surtido'
        SELECT Mov FROM MovTipo WHERE Modulo = @Modulo AND Clave IN ('PROD.CO') ORDER BY Orden      
    END
  END
  ELSE
    IF @Mov IS NOT NULL
      IF (SELECT Clave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov) IN('COMS.O', 'COMS.OD', 'INV.OT', 'INV.OI', 'VTAS.P' ,'INV.SOL')
        SELECT 'PENDIENTE' ELSE SELECT 'CONCLUIDO'
    ELSE
      SELECT ''
  RETURN
END
GO

--REQ12615 WMS
/**************** spRepWMSPorCorte *****************/
if exists (select * from sysobjects where id = object_id('dbo.spRepWMSPorCorte') and type = 'P') drop procedure dbo.spRepWMSPorCorte
GO
CREATE PROCEDURE spRepWMSPorCorte
		    @Estacion		int

--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
	@FechaDesde		datetime,
	@FechaHasta		datetime,
	@ArticuloDesde	varchar(20),
	@ArticuloHasta	varchar(20),
	@Categoria		varchar(50),
	@Familia		varchar(50),
	@Grupo			varchar(50),
    @Fabricante		varchar(50),
    @Linea			varchar(50),
    @Movimiento		varchar(25),
    @Nivel			varchar(50),
	@Almacen		varchar(20),
    @Titulo			varchar(100)
      
  SELECT @FechaDesde	= InfoFechaD,
		 @FechaHasta	= InfoFechaA,
		 @ArticuloDesde	= InfoArticuloD,
		 @ArticuloHasta	= InfoArticuloA,
		 @Categoria		= InfoArtCat,
		 @Familia		= InfoArtFam,
		 @Grupo			= InfoArtGrupo,
		 @Fabricante	= InfoArtFabricante,
		 @Linea			= InfoArtLinea,
		 @Movimiento	= InfoMovimientoEsp,
		 @Nivel			= InfoNivel,
		 @Almacen		= InfoAlmacenWMS,
		 @Titulo		= RepTitulo
    FROM RepParam
   WHERE Estacion = @Estacion

  IF LEN(@ArticuloDesde) = 0 OR @ArticuloDesde = '(Todos)' OR @ArticuloDesde = 'Todos' SET @ArticuloDesde = NULL
  IF LEN(@ArticuloHasta) = 0 OR @ArticuloHasta = '(Todos)' OR @ArticuloHasta = 'Todos' SET @ArticuloHasta = NULL
  IF LEN(@Categoria) = 0 OR @Categoria = '(Todos)' OR @Categoria = 'Todos' SET @Categoria = NULL
  IF LEN(@Familia) = 0 OR @Familia = '(Todos)' OR @Familia = 'Todos' SET @Familia = NULL
  IF LEN(@Grupo) = 0 OR @Grupo = '(Todos)' OR @Grupo = 'Todos' SET @Grupo = NULL
  IF LEN(@Fabricante) = 0 OR @Fabricante = '(Todos)' OR @Fabricante = 'Todos' SET @Fabricante = NULL
  IF LEN(@Linea) = 0 OR @Linea = '(Todos)' OR @Linea = 'Todos' SET @Linea = NULL  
  IF LEN(@Almacen) = 0 OR @Almacen = '(Todos)' OR @Almacen = 'Todos' SET @Almacen = NULL
  IF LEN(@Movimiento) = 0 OR @Movimiento = '(Todos)' OR @Movimiento = 'Todos' SET @Movimiento = NULL  
  
  SELECT a.Fecha, c.Articulo, c.Descripcion1, c.Categoria, c.Familia, c.Grupo, c.Fabricante, c.Linea, a.Grupo as Almacen, 
         a.Mov, a.MovID, a.SubCuenta, a.SubGrupo as Tarima, a.CargoU, a.AbonoU, a.EsCancelacion, a.ID, a.Rama, a.Moneda, 
         a.Cargo, a.Abono, r.CostoPromedio, r.UltimoCosto, c.CostoEstandar, c.CostoReposicion, c.PrecioLista, 
         c.Precio2, c.Precio3, c.Precio4, c.Precio5, c.Precio6, c.Precio7, c.Precio8, c.Precio9, c.Precio10,        
         @FechaDesde as FechaDesde, @FechaHasta as FechaHasta, @Movimiento as MovimientoEsp, @Titulo as Titulo--,a.* 
    FROM Art c
    LEFT OUTER JOIN AuxiliarU a   
      ON c.Articulo = a.Cuenta AND (CargoU IS NOT NULL OR AbonoU IS NOT NULL)
    LEFT OUTER JOIN ArtConCosto r
      ON c.Articulo = r.Articulo 
    JOIN Alm l ON a.Grupo = l.Almacen AND l.WMS = 1      
   WHERE ISNULL(c.Categoria, '(Todos)') = ISNULL(@Categoria, ISNULL(c.Categoria, '(Todos)'))
     AND ISNULL(c.Familia, '(Todos)') = ISNULL(@Familia, ISNULL(c.Familia, '(Todos)'))
     AND ISNULL(c.Grupo, '(Todos)') = ISNULL(@Grupo, ISNULL(c.Grupo, '(Todos)'))
     AND ISNULL(c.Fabricante, '(Todos)') = ISNULL(@Fabricante, ISNULL(c.Fabricante, '(Todos)'))
     AND ISNULL(c.Linea, '(Todos)') = ISNULL(@Linea, ISNULL(c.Linea, '(Todos)'))
     AND ISNULL(a.Grupo, '(Todos)') = ISNULL(@Almacen, ISNULL(a.Grupo, '(Todos)'))
     AND ISNULL(a.Mov, '(Todos)') = ISNULL(@Movimiento, ISNULL(a.Mov, '(Todos)'))
     AND dbo.fnFechaSinHora(a.Fecha) BETWEEN ISNULL(dbo.fnFechaSinHora(@FechaDesde), dbo.fnFechaSinHora(a.Fecha)) AND ISNULL(dbo.fnFechaSinHora(@FechaHasta), dbo.fnFechaSinHora(a.Fecha))
     AND c.Articulo BETWEEN ISNULL(@ArticuloDesde, c.Articulo) AND ISNULL(@ArticuloHasta, c.Articulo)     
   ORDER BY c.Articulo, a.Fecha, a.ID
  RETURN
END
GO

--REQ12615 WMS
/**************** spRepWMSPosicion *****************/
if exists (select * from sysobjects where id = object_id('dbo.spRepWMSPosicion') and type = 'P') drop procedure dbo.spRepWMSPosicion
GO
CREATE PROCEDURE spRepWMSPosicion
		    @Estacion		int

--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
	@Orden			varchar(20),
	@Zona			varchar(50),
	@Tipo			varchar(20),
    @Estatus		varchar(15),
	@Almacen		varchar(20),
	@Articulo		varchar(20),
    @Titulo			varchar(100)
      
  SELECT @Orden		= InfoOrdenWMS,
         @Zona		= InfoZona,
         @Tipo		= InfoTipo,
         @Estatus	= InfoEstatusTarima,
         @Almacen	= InfoAlmacenWMS,
         @Articulo	= InfoArticuloEsp,
	     @Titulo	= RepTitulo
    FROM RepParam 
   WHERE Estacion = @Estacion

  IF LEN(@Zona) = 0 OR @Zona = '(Todas)' OR @Zona = 'Todas' SET @Zona = NULL
  IF LEN(@Tipo) = 0 OR @Tipo = '(Todos)' OR @Tipo = 'Todos' SET @Tipo = NULL
  IF LEN(@Estatus) = 0 OR @Estatus = '(Todos)' OR @Estatus = 'Todos' SET @Estatus = NULL
  IF LEN(@Almacen) = 0 OR @Almacen = '(Todos)' OR @Almacen = 'Todos' SET @Almacen = NULL  
  IF LEN(@Articulo) = 0 OR @Articulo = '(Todos)' OR @Articulo = 'Todos' SET @Articulo = NULL  
   
  SELECT ISNULL(p.Zona, '') as Zona, p.Tipo, t.Tarima, t.Posicion, p.Descripcion, p.Estatus, p.Pasillo, p.Fila, p.Nivel, a.Articulo, a.Descripcion1, p.Capacidad, p.Alto, p.Largo, p.Ancho, p.PesoMaximo, @Titulo as Titulo, p.Estatus
    FROM Artdisponibletarima d
    JOIN Art a ON a.Articulo = d.Articulo
    JOIN Tarima t ON t.Tarima = d.Tarima AND t.Estatus = 'ALTA'--ISNULL(@Estatus, t.Estatus)
    JOIN AlmPos p ON p.Posicion = t.Posicion
    JOIN Alm l ON p.Almacen = l.Almacen AND l.WMS = 1    
   WHERE ISNULL(a.Articulo, '(Todos)') = ISNULL(@Articulo, ISNULL(a.Articulo, '(Todos)'))     
     AND ISNULL(p.Zona, '(Todos)') = ISNULL(@Zona, ISNULL(p.Zona, '(Todos)'))     
     AND ISNULL(p.Tipo, '(Todos)') = ISNULL(@Tipo, ISNULL(p.Tipo, '(Todos)'))     
     AND p.Estatus = ISNULL(@Estatus, p.Estatus)
     AND ISNULL(p.Almacen, '(Todas)') = ISNULL(@Almacen, ISNULL(p.Almacen, '(Todas)'))     
   ORDER BY p.Zona, CASE @Orden WHEN 'Tarima' THEN d.Tarima WHEN 'Articulo' THEN d.Articulo WHEN 'Posición' THEN t.Posicion WHEN 'Fecha de Entrada' THEN CONVERT(varchar,t.Alta) WHEN 'Fecha de Caducidad' THEN CONVERT(varchar,t.FechaCaducidad) END
  RETURN
END
GO

--REQ12615 WMS
/**************** spRepWMSPosicion *****************/
if exists (select * from sysobjects where id = object_id('dbo.spRepWMSPosicion') and type = 'P') drop procedure dbo.spRepWMSPosicion
GO
CREATE PROCEDURE spRepWMSPosicion
		    @Estacion		int

--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
	@Orden			varchar(20),
	@Zona			varchar(50),
	@Tipo			varchar(20),
    @Estatus		varchar(15),
	@Almacen		varchar(20),
	@Articulo		varchar(20),
    @Titulo			varchar(100)
      
  SELECT @Orden		= InfoOrdenWMS,
         @Zona		= InfoZona,
         @Tipo		= InfoTipo,
         @Estatus	= InfoEstatusTarima,
         @Almacen	= InfoAlmacenWMS,
         @Articulo	= InfoArticuloEsp,
	     @Titulo	= RepTitulo
    FROM RepParam 
   WHERE Estacion = @Estacion

  IF LEN(@Zona) = 0 OR @Zona = '(Todas)' OR @Zona = 'Todas' SET @Zona = NULL
  IF LEN(@Tipo) = 0 OR @Tipo = '(Todos)' OR @Tipo = 'Todos' SET @Tipo = NULL
  IF LEN(@Estatus) = 0 OR @Estatus = '(Todos)' OR @Estatus = 'Todos' SET @Estatus = NULL
  IF LEN(@Almacen) = 0 OR @Almacen = '(Todos)' OR @Almacen = 'Todos' SET @Almacen = NULL  
  IF LEN(@Articulo) = 0 OR @Articulo = '(Todos)' OR @Articulo = 'Todos' SET @Articulo = NULL  
   
  SELECT ISNULL(p.Zona, '') as Zona, p.Tipo, t.Tarima, t.Posicion, p.Descripcion, p.Estatus, p.Pasillo, p.Fila, p.Nivel, a.Articulo, a.Descripcion1, p.Capacidad, p.Alto, p.Largo, p.Ancho, p.PesoMaximo, @Titulo as Titulo, p.Estatus
    FROM Artdisponibletarima d
    JOIN Art a ON a.Articulo = d.Articulo
    JOIN Tarima t ON t.Tarima = d.Tarima AND t.Estatus = 'ALTA'--ISNULL(@Estatus, t.Estatus)
    JOIN AlmPos p ON p.Posicion = t.Posicion
    JOIN Alm l ON p.Almacen = l.Almacen AND l.WMS = 1    
   WHERE ISNULL(a.Articulo, '(Todos)') = ISNULL(@Articulo, ISNULL(a.Articulo, '(Todos)'))     
     AND ISNULL(p.Zona, '(Todos)') = ISNULL(@Zona, ISNULL(p.Zona, '(Todos)'))     
     AND ISNULL(p.Tipo, '(Todos)') = ISNULL(@Tipo, ISNULL(p.Tipo, '(Todos)'))     
     AND p.Estatus = ISNULL(@Estatus, p.Estatus)
     AND ISNULL(p.Almacen, '(Todas)') = ISNULL(@Almacen, ISNULL(p.Almacen, '(Todas)'))     
   ORDER BY p.Zona, CASE @Orden WHEN 'Tarima' THEN d.Tarima WHEN 'Articulo' THEN d.Articulo WHEN 'Posición' THEN t.Posicion WHEN 'Fecha de Entrada' THEN CONVERT(varchar,t.Alta) WHEN 'Fecha de Caducidad' THEN CONVERT(varchar,t.FechaCaducidad) END
  RETURN
END
GO

--REQ12615 WMS
/**************** spRepWMSProducto *****************/
if exists (select * from sysobjects where id = object_id('dbo.spRepWMSProducto') and type = 'P') drop procedure dbo.spRepWMSProducto
GO
CREATE PROCEDURE spRepWMSProducto
		    @Estacion		int

--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
	@ArticuloD 		varchar(20),
	@ArticuloA		varchar(20),
	@Categoria		varchar(50),
	@Familia		varchar(50),
	@Grupo			varchar(50),
	@Fabricante		varchar(50),
	@Linea			varchar(50),
    @Estatus		varchar(15),
	@Almacen		varchar(20),	
    @Orden			varchar(20),
	@FechaD			datetime,
	@FechaA			datetime,
    @CaducidadD		datetime,
    @CaducidadA 	datetime,
	@Titulo			varchar(100)
  
  SELECT 
	     @ArticuloD		= InfoArticuloD,
	     @ArticuloA		= InfoArticuloA,
		 @Categoria		= InfoArtCat,
		 @Familia		= InfoArtFam,
		 @Grupo			= InfoArtGrupo,
		 @Fabricante	= InfoArtFabricante,
		 @Linea			= InfoArtLinea,  
         @Estatus		= InfoEstatusTarima,
         @Almacen		= InfoAlmacenWMS,
         @Orden			= InfoOrdenWMS,	         	 
		 @FechaD		= InfoFechaD,
		 @FechaA		= InfoFechaA,
         @CaducidadD	= InfoCaducidadD,
         @CaducidadA	= InfoCaducidadA,	    
	     @Titulo		= RepTitulo
    FROM RepParam 
   WHERE Estacion = @Estacion

  IF LEN(@ArticuloD) = 0 OR @ArticuloD = '(Todos)' OR @ArticuloD = 'Todos' SET @ArticuloD = NULL
  IF LEN(@ArticuloA) = 0 OR @ArticuloA = '(Todos)' OR @ArticuloA = 'Todos' SET @ArticuloA = NULL
  IF LEN(@Categoria) = 0 OR @Categoria = '(Todos)' OR @Categoria = 'Todos' SET @Categoria = NULL  
  IF LEN(@Familia) = 0 OR @Familia = '(Todos)' OR @Familia = 'Todos' SET @Familia = NULL
  IF LEN(@Grupo) = 0 OR @Grupo = '(Todos)' OR @Grupo = 'Todos' SET @Grupo = NULL
  IF LEN(@Fabricante) = 0 OR @Fabricante = '(Todos)' OR @Fabricante = 'Todos' SET @Fabricante = NULL
  IF LEN(@Linea) = 0 OR @Linea = '(Todos)' OR @Linea = 'Todos' SET @Linea = NULL
  IF LEN(@Estatus) = 0 OR @Estatus = '(Todos)' OR @Estatus = 'Todos' SET @Estatus = NULL
  IF LEN(@Almacen) = 0 OR @Almacen = '(Todos)' OR @Almacen = 'Todos' SET @Almacen = NULL  
  IF LEN(@Orden) = 0 OR @Orden = '(Todos)' OR @Orden = 'Todos' SET @Orden = NULL
  IF LEN(@FechaD) = 0 SET @FechaD = NULL
  IF LEN(@FechaA) = 0 SET @FechaA = NULL
  IF LEN(@CaducidadD) = 0 SET @CaducidadD = NULL
  IF LEN(@CaducidadA) = 0 SET @CaducidadA = NULL
  
  IF @Orden <> 'Fecha de Caducidad'
    SELECT @CaducidadD = NULL, @CaducidadA = NULL 
  
  SELECT a.Articulo, a.Descripcion1, d.Tarima, t.Estatus, d.Almacen, t.Posicion, d.Disponible, t.Alta, t.FechaCaducidad, @Titulo as Titulo
    FROM Artdisponibletarima d
    JOIN Art a ON a.Articulo = d.Articulo
    JOIN Tarima t ON t.Tarima = d.Tarima
    JOIN AlmPos p ON p.Posicion = t.Posicion
    JOIN Alm l ON p.Almacen = l.Almacen AND l.WMS = 1
   WHERE d.Articulo BETWEEN ISNULL(@ArticuloD, d.Articulo) AND ISNULL(@ArticuloA, d.Articulo)
     AND ISNULL(a.Categoria, '(Todos)') = ISNULL(@Categoria, ISNULL(a.Categoria, '(Todos)'))     
     AND ISNULL(a.Categoria, '(Todos)') = ISNULL(@Categoria, ISNULL(a.Categoria, '(Todos)'))
     AND ISNULL(a.Familia, '(Todos)') = ISNULL(@Familia, ISNULL(a.Familia, '(Todos)'))
     AND ISNULL(a.Grupo, '(Todos)') = ISNULL(@Grupo, ISNULL(a.Grupo, '(Todos)'))
     AND ISNULL(a.Fabricante, '(Todos)') = ISNULL(@Fabricante, ISNULL(a.Fabricante, '(Todos)'))
     AND ISNULL(a.Linea, '(Todos)') = ISNULL(@Linea, ISNULL(a.Linea, '(Todos)'))     
     AND t.Estatus = ISNULL(@Estatus, t.Estatus)
     AND ISNULL(p.Almacen, '(Todas)') = ISNULL(@Almacen, ISNULL(p.Almacen, '(Todas)'))
     AND dbo.fnFechaSinHora(t.Alta) BETWEEN ISNULL(dbo.fnFechaSinHora(@FechaD), dbo.fnFechaSinHora(t.Alta)) AND ISNULL(dbo.fnFechaSinHora(@FechaA), dbo.fnFechaSinHora(t.Alta))
     AND ISNULL(dbo.fnFechaSinHora(t.FechaCaducidad), '') BETWEEN ISNULL(dbo.fnFechaSinHora(@CaducidadD), ISNULL(dbo.fnFechaSinHora(t.FechaCaducidad), '')) AND ISNULL(dbo.fnFechaSinHora(@CaducidadA), ISNULL(dbo.fnFechaSinHora(t.FechaCaducidad), ''))
   ORDER BY a.Articulo, CASE @Orden WHEN 'Tarima' THEN d.Tarima WHEN 'Articulo' THEN d.Articulo WHEN 'Posición' THEN t.Posicion WHEN 'Fecha de Entrada' THEN CONVERT(varchar,t.Alta) WHEN 'Fecha de Caducidad' THEN CONVERT(varchar,t.FechaCaducidad) END
  RETURN
END
GO

--REQ12615 WMS
/************************************* spReporteProductividad ****************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spReporteProductividad') AND Type = 'P') 
DROP PROCEDURE dbo.spReporteProductividad
GO             
CREATE PROCEDURE spReporteProductividad
		@Estacion		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Flujo			varchar(10),
    @Acomodador		varchar(10),
    @Acomodo		varchar(10),
	@Reacomodo		varchar(10),
	@Surtido		varchar(10),
	@Desde			datetime,
	@Hasta			datetime


  SELECT @Flujo			= ISNULL(InfoFlujo, '(Todos)'),
         @Acomodador	= ISNULL(InfoAcomodador, '(Todos)'),
         @Desde			= InfoFechaD,
         @Hasta			= InfoFechaA 
    FROM RepParam 
   WHERE Estacion = @Estacion

  IF @Flujo = '(Todos)'
    SELECT @Acomodo		= 'TMA.OADO',
           @Reacomodo	= 'TMA.ORADO',
           @Surtido		= 'TMA.OSUR'
  ELSE  
  IF @Flujo = 'Acomodo'
    SELECT @Acomodo		= 'TMA.OADO',
           @Reacomodo	= 'TMA.OADO',
           @Surtido		= 'TMA.OADO'         
  ELSE  
  IF @Flujo = 'Reacomodo'
    SELECT @Acomodo		= 'TMA.ORADO',
           @Reacomodo	= 'TMA.ORADO',
           @Surtido		= 'TMA.ORADO'
  ELSE  
  IF @Flujo = 'Surtido'
    SELECT @Acomodo		= 'TMA.OSUR',
           @Reacomodo	= 'TMA.OSUR',
           @Surtido		= 'TMA.OSUR'

  DECLARE @Resultado		TABLE
		(
		 Acomodador			varchar(20),
		 Nombre				varchar(100),
		 Movimientos		int,
		 Mov				varchar(20),
		 MovID				varchar(20),
		 Tarima				varchar(20),
		 Inicio				datetime,
		 Fin				datetime,
		 Productividad		float
		 )

  IF @Acomodador = '(Todos)'
  BEGIN
    DECLARE crProductividad CURSOR FOR
     SELECT Agente
       FROM Agente

    OPEN crProductividad
    FETCH NEXT FROM crProductividad INTO @Acomodador
    WHILE @@FETCH_STATUS = 0 --AND @Ok IS NULL
    BEGIN
      INSERT INTO @Resultado
      SELECT t.Agente Acomodador, a.Nombre, 1 Movimientos, t.Mov, t.MovID, d.Tarima, ISNULL(t.FechaInicio, 0) Inicio, ISNULL(t.FechaFin, 0) Fin, ISNULL((((CONVERT(FLOAT, DATEDIFF(SECOND, t.FechaInicio, t.FechaFin)))/60)/60), 0) Productividad
        FROM TMA t
        JOIN TMAD d
          ON t.ID = d.ID
        JOIN MovTipo m
          ON m.Mov = t.Mov AND m.Modulo = 'TMA'
        JOIN Agente a
          ON a.Agente = @Acomodador
       WHERE t.Estatus = 'CONCLUIDO'
         AND t.Agente = @Acomodador
         AND m.Clave IN( @Acomodo, @Reacomodo, @Surtido)
         AND dbo.fnFechaSinHora(@Desde) < = dbo.fnFechaSinHora(t.FechaInicio)
         AND dbo.fnFechaSinHora(@Hasta) > = dbo.fnFechaSinHora(t.FechaFin)
         AND dbo.fnFechaSinHora(t.FechaInicio) BETWEEN dbo.fnFechaSinHora(@Desde) AND dbo.fnFechaSinHora(@Hasta)
       ORDER BY dbo.fnFechaSinHora(t.FechaInicio), dbo.fnFechaSinHora(t.FechaFin)

      FETCH NEXT FROM crProductividad INTO @Acomodador
    END
    CLOSE crProductividad
    DEALLOCATE crProductividad
  END
  ELSE
      INSERT INTO @Resultado
      SELECT t.Agente Acomodador, a.Nombre, 1 Movimientos, t.Mov, t.MovID, d.Tarima, ISNULL(t.FechaInicio, 0) Inicio, ISNULL(t.FechaFin, 0) Fin, ISNULL((((CONVERT(FLOAT, DATEDIFF(SECOND, t.FechaInicio, t.FechaFin)))/60)/60), 0) Productividad
        FROM TMA t
        JOIN TMAD d
          ON t.ID = d.ID
        JOIN MovTipo m
          ON m.Mov = t.Mov AND m.Modulo = 'TMA'
        JOIN Agente a
          ON a.Agente = @Acomodador
       WHERE t.Estatus = 'CONCLUIDO'
         AND t.Agente = @Acomodador
         AND m.Clave IN( @Acomodo, @Reacomodo, @Surtido)
         AND dbo.fnFechaSinHora(@Desde) < = dbo.fnFechaSinHora(t.FechaInicio)
         AND dbo.fnFechaSinHora(@Hasta) > = dbo.fnFechaSinHora(t.FechaFin)
         AND dbo.fnFechaSinHora(t.FechaInicio) BETWEEN dbo.fnFechaSinHora(@Desde) AND dbo.fnFechaSinHora(@Hasta)
       ORDER BY dbo.fnFechaSinHora(t.FechaInicio), dbo.fnFechaSinHora(t.FechaFin)
  
  SELECT * FROM @Resultado   
END
GO
--EXEC spReporteProductividad 0

---REQ12615 WMS
/**************** spImprimirEtiquetaWMS *****************/
if exists (select * from sysobjects where id = object_id('dbo.spImprimirEtiquetaWMS') and type = 'P') drop procedure dbo.spImprimirEtiquetaWMS
GO
CREATE PROCEDURE spImprimirEtiquetaWMS
@Estacion		int

--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
	@FechaD			datetime,
	@FechaA			datetime,
	@TarimaD		varchar(20),
	@TarimaA		varchar(20),
	@ArticuloD 		varchar(20),
	@ArticuloA		varchar(20),
	@Empresa		varchar(5)
  
  SELECT @FechaD	= InfoFechaD,
		 @FechaA	= InfoFechaA,
	     @TarimaD	= InfoTarimaD,
	     @TarimaA	= InfoTarimaA,
	     @ArticuloD	= InfoArticuloD,
	     @ArticuloA	= InfoArticuloA,
		 @Empresa   = InfoEmpresa
    FROM RepParam 
   WHERE Estacion = @Estacion

  IF LEN(@FechaD) = 0 SET @FechaD = NULL
  IF LEN(@FechaA) = 0 SET @FechaA = NULL  
  IF LEN(@TarimaD) = 0 SET @TarimaD = NULL
  IF LEN(@TarimaA) = 0 SET @TarimaA = NULL  
  IF LEN(@ArticuloD) = 0 SET @ArticuloD = NULL
  IF LEN(@ArticuloA) = 0 SET @ArticuloA = NULL
  
--  SELECT @TarimaD, @TarimaA
  
  SELECT 
  d.Articulo, 
  a.Descripcion1, 
  d.Almacen, 
  d.Tarima, 
  d.Disponible, 
  t.Alta, 
  t.FechaCaducidad,
  a.Unidad,
  cb.Codigo,
  sl.SerieLote
  FROM Artdisponibletarima d
    JOIN Art a ON a.Articulo = d.Articulo
    JOIN Tarima t ON t.Tarima = d.Tarima
	LEFT JOIN CB cb ON TipoCuenta='Articulos' AND cb.Cuenta=a.Articulo
	LEFT JOIN SerieLote sl ON d.Tarima=sl.Tarima AND d.Almacen=sl.Almacen AND d.Articulo=sl.Articulo AND sl.Empresa=@Empresa
   WHERE ISNULL(@TarimaD, d.Tarima) < = ISNULL(d.Tarima, @TarimaD) AND ISNULL(@TarimaD, d.Tarima) < = ISNULL(d.Tarima, @TarimaA) 
     AND ISNULL(@TarimaA, d.Tarima) > = ISNULL(d.Tarima, @TarimaA) --AND ISNULL(@TarimaA, d.Tarima) < = ISNULL(d.Tarima, @TarimaD)
     AND d.Articulo BETWEEN ISNULL(@ArticuloD, d.Articulo) AND ISNULL(@ArticuloA, d.Articulo)
     AND dbo.fnFechaSinHora(ISNULL(@FechaD, t.Alta)) < = dbo.fnFechaSinHora(ISNULL(t.Alta, @FechaD))
     AND dbo.fnFechaSinHora(ISNULL(@FechaA, t.Alta)) > = dbo.fnFechaSinHora(ISNULL(t.Alta, @FechaA))
     AND t.Estatus = 'ALTA'
     AND DISPONIBLE > 0
  RETURN	  
END
GO--exec spImprimirEtiquetaWMS 0

--REQ12615 WMS
/**************** spBorrarRepWMSTarima *****************/
if exists (select * from sysobjects where id = object_id('dbo.spBorrarRepWMSTarima') and type = 'P') drop procedure dbo.spBorrarRepWMSTarima
GO
CREATE PROCEDURE spBorrarRepWMSTarima
		    @Estacion		int

--//WITH ENCRYPTION
AS BEGIN 
  IF NOT EXISTS(SELECT * FROM RepParam WHERE Estacion = @Estacion)
  INSERT RepParam (Estacion) VALUES (@Estacion)
  UPDATE RepParam 
     SET InfoEstatusTarima	= 'Alta',
		 InfoOrdenWMS		= 'Tarima',
		 InfoAlmacenWMS		= '(Todos)',
		 InfoTipo			= '(Todos)',
		 RepTitulo			= 'Existencia por Tarima'
   WHERE Estacion = @Estacion
  RETURN
END
GO

--REQ12615 WMS
/**************** spBorrarWMSTablaHerramienta *****************/
if exists (select * from sysobjects where id = object_id('dbo.spBorrarWMSTablaHerramienta') and type = 'P') drop procedure dbo.spBorrarWMSTablaHerramienta
GO
CREATE PROCEDURE spBorrarWMSTablaHerramienta
		    @Estacion		int
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @InfoContacto		varchar(50)
  
  SELECT @InfoContacto = InfoContacto FROM RepParam WHERE Estacion = @Estacion
  IF @InfoContacto = '(Todos)'
    UPDATE RepParam 
       SET InfoContactoRuta		= NULL,
		   InfoContactoEstado	= NULL,
		   InfoContactoZona		= NULL,
		   InfoContactoPais		= NULL,
		   InfoContactoCP		= NULL,
		   InfoClienteEnviarA   = NULL,
		   InfoContactoEspecifico = NULL,
		   InfoArticuloEsp		= NULL
     WHERE Estacion = @Estacion
  ELSE
  IF @InfoContacto = 'Almacen'
    UPDATE RepParam 
       SET InfoContactoGrupo	= NULL,
		   InfoContactoFam		= NULL,
		   InfoContactoCat		= NULL,
		   InfoContactoRuta		= NULL,
		   InfoContactoEstado	= NULL,
		   InfoContactoZona		= NULL,
		   InfoContactoPais		= NULL,
		   InfoContactoCP		= NULL,
		   InfoClienteEnviarA   = NULL,
		   InfoContactoEspecifico = NULL,
		   InfoArticuloEsp		= NULL
     WHERE Estacion = @Estacion
  ELSE      
  IF @InfoContacto = 'Proveedor'
    UPDATE RepParam 
       SET InfoContactoGrupo	= NULL,
		   InfoContactoRuta		= NULL,
		   InfoContactoEstado	= NULL,
		   InfoContactoZona		= NULL,
		   InfoContactoPais		= NULL,
		   InfoContactoCP		= NULL,
		   InfoClienteEnviarA   = NULL,
		   InfoContactoEspecifico = NULL,
		   InfoArticuloEsp		= NULL
     WHERE Estacion = @Estacion
    
  RETURN
END
GO

--REQ12615 WMS
/**************** spBorrarRepWMSProducto *****************/
if exists (select * from sysobjects where id = object_id('dbo.spBorrarRepWMSProducto') and type = 'P') drop procedure dbo.spBorrarRepWMSProducto
GO
CREATE PROCEDURE spBorrarRepWMSProducto
		    @Estacion		int

--//WITH ENCRYPTION
AS BEGIN 
  IF NOT EXISTS(SELECT * FROM RepParam WHERE Estacion = @Estacion)
  INSERT RepParam (Estacion) VALUES (@Estacion)
  UPDATE RepParam 
     SET InfoEstatusTarima		= 'Alta',
		 InfoOrdenWMS			= 'Tarima',
		 InfoAlmacenWMS			= '(Todos)',
		 RepTitulo				= 'Existencia por Producto',
		 InfoArtCat				= '(Todos)',
		 InfoArtFam				= '(Todos)',
		 InfoArtGrupo			= '(Todos)',
		 InfoArtFabricante		= '(Todos)',
		 InfoArtLinea			= '(Todos)'
   WHERE Estacion = @Estacion
  RETURN
END
GO

--REQ12615 WMS
/**************** spBorrarRepWMSPosicion *****************/
if exists (select * from sysobjects where id = object_id('dbo.spBorrarRepWMSPosicion') and type = 'P') drop procedure dbo.spBorrarRepWMSPosicion
GO
CREATE PROCEDURE spBorrarRepWMSPosicion
		    @Estacion		int

--//WITH ENCRYPTION
AS BEGIN 
  IF NOT EXISTS(SELECT * FROM RepParam WHERE Estacion = @Estacion)
  INSERT RepParam (Estacion) VALUES (@Estacion)
  UPDATE RepParam 
     SET InfoEstatusTarima	= 'Alta',
		 InfoTipo			= '(Todos)',
		 InfoAlmacenWMS		= '(Todos)',
		 InfoOrdenWMS		= 'Tarima',
		 RepTitulo			= 'Layout de las posiciones del Almacén'
   WHERE Estacion = @Estacion
  RETURN
END
GO

--REQ12615 WMS
/**************** spBorrarRepWMSPorCorte *****************/
if exists (select * from sysobjects where id = object_id('dbo.spBorrarRepWMSPorCorte') and type = 'P') drop procedure dbo.spBorrarRepWMSPorCorte
GO
CREATE PROCEDURE spBorrarRepWMSPorCorte
		    @Estacion		int

--//WITH ENCRYPTION
AS BEGIN 
  IF NOT EXISTS(SELECT * FROM RepParam WHERE Estacion = @Estacion)
  INSERT RepParam (Estacion) VALUES (@Estacion)
  UPDATE RepParam 
     SET InfoArtCat			= '(Todos)',
		 InfoArtFam			= '(Todos)',
		 InfoArtGrupo		= '(Todos)',		 
		 InfoArtFabricante	= '(Todos)',
		 InfoArtLinea		= '(Todos)',
		 InfoMovimientoEsp	= '',
		 InfoNivel			= 'Desglosado',
		 InfoValuacion		= 'Costo Promedio',		 
		 InfoAlmacenWMS		= '(Todos)',
		 RepTitulo			= 'Existencia por producto y Tarima a una fecha de corte'
   WHERE Estacion = @Estacion
  RETURN
END
GO

--REQ12615 WMS
/**************** spRepWMSTarima *****************/
if exists (select * from sysobjects where id = object_id('dbo.spRepWMSTarima') and type = 'P') drop procedure dbo.spRepWMSTarima
GO
CREATE PROCEDURE spRepWMSTarima
		    @Estacion		int
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
	@TarimaD		varchar(20),
	@TarimaA		varchar(20),
    @Estatus		varchar(15),
    @Orden			varchar(20),
	@Tipo			varchar(20),
	@FechaD			datetime,
	@FechaA			datetime,
    @CaducidadD		datetime,
    @CaducidadA 	datetime,
	@ArticuloD 		varchar(20),
	@ArticuloA		varchar(20),
	@Almacen		varchar(20),
	@Titulo			varchar(100)
  
	DECLARE @Reporte AS TABLE(Tarima			varchar(20) null,
							  Estatus			varchar(15) null,
							  Articulo			varchar(20) null,
							  Descripcion1		varchar(100) null,
							  Almacen			varchar(10) null,
							  Posicion			varchar(10) null,
							  Descripcion		varchar(100) null,
							  Tipo				varchar(20) null,
							  Disponible		float null,
							  Alta				datetime null,
							  FechaCaducidad	datetime null,
							  Titulo			varchar(100) null
							  )


  SELECT @TarimaD		= InfoTarimaDRep,
	     @TarimaA		= InfoTarimaARep,
         @Estatus		= InfoEstatusTarima,
         @Orden			= InfoOrdenWMS,
		 @Tipo			= InfoTipo,
		 @FechaD		= InfoFechaD,
		 @FechaA		= InfoFechaA,
         @CaducidadD	= InfoCaducidadD,
         @CaducidadA	= InfoCaducidadA,
	     @ArticuloD		= InfoArticuloD,
	     @ArticuloA		= InfoArticuloA,
	     @Almacen		= InfoAlmacenWMS,
	     @Titulo		= RepTitulo
    FROM RepParam 
   WHERE Estacion = @Estacion

  IF LEN(@TarimaD) = 0 OR @TarimaD = '(Todos)' OR @TarimaD = 'Todos' SET @TarimaD = NULL
  IF LEN(@TarimaA) = 0 OR @TarimaA = '(Todos)' OR @TarimaA = 'Todos' SET @TarimaA = NULL  
  IF LEN(@Estatus) = 0 OR @Estatus = '(Todos)' OR @Estatus = 'Todos' SET @Estatus = NULL
  IF LEN(@Orden) = 0 OR @Orden = '(Todos)' OR @Orden = 'Todos' SET @Orden = NULL  
  IF LEN(@Tipo) = 0 OR @Tipo = '(Todos)' OR @Tipo = 'Todos' SET @Tipo = NULL
  IF LEN(@FechaD) = 0 SET @FechaD = NULL
  IF LEN(@FechaA) = 0 SET @FechaA = NULL
  IF LEN(@CaducidadD) = 0 SET @CaducidadD = NULL  
  IF LEN(@CaducidadA) = 0 SET @CaducidadA = NULL
  IF LEN(@ArticuloD) = 0 OR @ArticuloD = '(Todos)' OR @ArticuloD = 'Todos' SET @ArticuloD = NULL  
  IF LEN(@ArticuloA) = 0 OR @ArticuloA = '(Todos)' OR @ArticuloA = 'Todos' SET @ArticuloA = NULL
  IF LEN(@Almacen) = 0 OR @Almacen = '(Todos)' OR @Almacen = 'Todos' SET @Almacen = NULL  

  IF @Orden <> 'Fecha de Caducidad'
	SELECT @CaducidadD = NULL, @CaducidadA = NULL 
	
	INSERT @Reporte(Tarima, Estatus, Articulo, Descripcion1, Almacen, Posicion, Descripcion, Tipo, Disponible, Alta, FechaCaducidad, Titulo)  
	SELECT d.Tarima, t.Estatus, d.Articulo, a.Descripcion1, d.Almacen, t.Posicion, p.Descripcion, p.Tipo, d.Disponible, t.Alta, t.FechaCaducidad, @Titulo as Titulo
	  FROM Artdisponibletarima d
	  JOIN Art a ON a.Articulo = d.Articulo
	  JOIN Tarima t ON t.Tarima = d.Tarima
	  JOIN AlmPos p ON p.Posicion = t.Posicion
	  JOIN Alm l ON p.Almacen = l.Almacen AND l.WMS = 1
     WHERE d.Tarima BETWEEN ISNULL(@TarimaD, d.Tarima) AND ISNULL(@TarimaA, d.Tarima)
	   AND t.Estatus = ISNULL(@Estatus, t.Estatus)
	   AND ISNULL(p.Almacen, '(Todas)') = ISNULL(@Almacen, ISNULL(p.Almacen, '(Todas)'))
	   AND p.Tipo = ISNULL(@Tipo, p.Tipo)
	   AND dbo.fnFechaSinHora(t.Alta) BETWEEN ISNULL(dbo.fnFechaSinHora(@FechaD), dbo.fnFechaSinHora(t.Alta)) AND ISNULL(dbo.fnFechaSinHora(@FechaA), dbo.fnFechaSinHora(t.Alta))
	   AND ISNULL(dbo.fnFechaSinHora(t.FechaCaducidad), '') BETWEEN ISNULL(dbo.fnFechaSinHora(@CaducidadD), ISNULL(dbo.fnFechaSinHora(t.FechaCaducidad), '')) AND ISNULL(dbo.fnFechaSinHora(@CaducidadA), ISNULL(dbo.fnFechaSinHora(t.FechaCaducidad), ''))
	   AND d.Articulo BETWEEN ISNULL(@ArticuloD, d.Articulo) AND ISNULL(@ArticuloA, d.Articulo)
	ORDER BY CASE @Orden WHEN 'Tarima' THEN d.Tarima WHEN 'Articulo' THEN d.Articulo WHEN 'Posición' THEN t.Posicion WHEN 'Fecha de Entrada' THEN CONVERT(varchar,t.Alta) WHEN 'Fecha de Caducidad' THEN CONVERT(varchar,t.FechaCaducidad) END
  
  	DELETE FROM @Reporte WHERE Estatus = 'BAJA' AND Disponible <= 0
  
	SELECT Tarima, Estatus, Articulo, Descripcion1, Almacen, Posicion, Descripcion, Tipo, Disponible, Alta, FechaCaducidad, Titulo
	  FROM @Reporte
  ORDER BY FechaCaducidad, Posicion
  RETURN   
END
GO

--REQ12615 WMS
/**************** spWMSModificarAlmPos *****************/
if exists (select * from sysobjects where id = object_id('dbo.spWMSModificarAlmPos') and type = 'P') drop procedure dbo.spWMSModificarAlmPos
GO
CREATE PROCEDURE spWMSModificarAlmPos
 		    @Almacen			varchar(20),
 		    @Posicion			varchar(20),
 		    @Articulo			varchar(20),
		    @Resultado			bit  = 0

--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @ArticuloOriginal		varchar(20),
    @Tipo					varchar(20)
    
  SELECT @ArticuloOriginal	= ArticuloEsp,
		 @Tipo				= Tipo
    FROM AlmPos 
   WHERE Almacen = @Almacen
     AND Posicion = @Posicion
  
  IF EXISTS( SELECT *
			   FROM TMA w JOIN TMAD d
			     ON w.ID = d.ID JOIN ArtDisponibleTarima t
			     ON d.Tarima = t.Tarima JOIN MovTipo m
			     ON w.Mov = m.Modulo AND m.Modulo = 'TMA'
			  WHERE w.Estatus IN('PENDIENTE', 'PROCESAR')
			    AND 1 = CASE WHEN (@Tipo = 'Domicilio' AND t.Articulo = @Articulo) OR (@Tipo <> 'Domicilio' AND t.Articulo = @ArticuloOriginal) THEN 1 ELSE 0 END
			    AND m.Clave IN ('TMA.ADO', 'TMA.RADO', 'TMA.SUR', 'TMA.TSUR')
			)
      SELECT @Resultado = 1

  SELECT @Resultado
END
GO

--REQ12615 WMS
/************************************* spRegresaPosicion ****************/
IF EXISTS(SELECT 1 FROM SysObjects WHERE name = 'spRegresaPosicion' AND type = 'P') DROP PROCEDURE spRegresaPosicion
GO
CREATE PROCEDURE spRegresaPosicion
            @Modulo varchar(5),
            @Tipo   varchar(10),
            @Sujeto varchar(10),
            @Almacen    varchar(10),
			@Mov varchar(20) =NULL
--//WITH ENCRYPTION
AS
BEGIN            
        DECLARE @Posicion   varchar(10),
                @Clave      varchar(20),
                @SubClave   varchar(20)

  IF @Modulo = 'VTAS'
  BEGIN
    IF @Tipo = 'ENTRADA'
      SELECT @Posicion = DefPosicionRecibo FROM Cte WHERE Cliente = @Sujeto
    IF @Tipo = 'SALIDA'
      SELECT @Posicion = DefPosicionSurtido FROM Cte WHERE Cliente = @Sujeto
  END

  IF @Modulo = 'COMS'
  BEGIN
    IF @Tipo = 'ENTRADA'
      SELECT @Posicion = DefPosicionRecibo FROM Prov WHERE Proveedor = @Sujeto
    IF @Tipo = 'SALIDA'
      SELECT @Posicion = DefPosicionSurtido FROM Prov WHERE Proveedor = @Sujeto
  END
  
  IF @Mov IS NOT NULL AND @Modulo = 'INV'  
  BEGIN
    SELECT @Clave = Clave,@SubClave = SubClave
      FROM MovTipo
     WHERE Modulo = @Modulo AND Mov = @Mov
     
     IF ISNULL(@SubClave,'') = 'INV.ENT' AND @Tipo = 'SALIDA'
       SET @Tipo = 'ENTRADA'

     IF ISNULL(@Clave,'') = 'INV.EI' AND @Tipo = 'ENTRADA'
       SET @Tipo = 'SALIDA'
     
	 IF ISNULL(@Clave,'') = 'INV.SOL' AND ISNULL(@SubClave,'') = '' AND @Tipo = 'ENTRADA'
       SET @Tipo = 'SALIDA'
  END
  
  IF @Modulo IN('PROD','INV')
  BEGIN
    
      IF @Tipo = 'ENTRADA' AND @Posicion IS NULL
        SELECT @Posicion = DefPosicionRecibo FROM Alm WHERE Almacen = @Almacen

      IF @Tipo = 'SALIDA' AND @Posicion IS NULL
        SELECT @Posicion = DefPosicionSurtido FROM Alm WHERE Almacen = @Almacen
  END
  IF @Tipo = 'ENTRADA' AND @Posicion IS NULL
    SELECT @Posicion = DefPosicionRecibo FROM Alm WHERE Almacen = @Almacen

  IF @Tipo = 'SALIDA' AND @Posicion IS NULL
    SELECT @Posicion = DefPosicionSurtido FROM Alm WHERE Almacen = @Almacen

SELECT @Posicion
END
GO

--REQ12615 WMS
/************************************* spRegresaPosiciones ****************/
IF EXISTS(SELECT 1 FROM SysObjects WHERE name = 'spRegresaPosiciones' AND type = 'P') DROP PROCEDURE spRegresaPosiciones
GO
CREATE PROCEDURE spRegresaPosiciones
            @Modulo     varchar(5),
            @Tipo       varchar(10),
            @Sujeto     varchar(10),
            @Almacen    varchar(10),
			@Mov        varchar(20)=NULL
--//WITH ENCRYPTION
AS
BEGIN            
        DECLARE @Almacen1   varchar(10),
                @Clave      varchar(20),
                @SubClave   varchar(20)

  IF @Modulo = 'VTAS'
    SELECT @Almacen1 = AlmacenDef FROM Cte WHERE Cliente = @Sujeto

  IF @Modulo = 'COMS'
    SELECT @Almacen1 = Almacen FROM Prov WHERE Proveedor = @Sujeto
  
  IF @Modulo IN ('PROD','INV')
    SELECT @Almacen1 = @Almacen
  
  IF @Mov IS NOT NULL AND @Modulo = 'INV'  
  BEGIN
    SELECT @Clave = Clave, @SubClave = SubClave
      FROM MovTipo
     WHERE Modulo = @Modulo AND Mov = @Mov
     
     --IF ISNULL(@SubClave,'') = '' AND @Tipo = 'ENTRADA'
     --  SET @Tipo = 'SALIDA'

     IF ISNULL(@SubClave,'') = 'INV.ENT' AND @Tipo = 'SALIDA'
       SET @Tipo = 'ENTRADA'

     IF ISNULL(@Clave,'') = 'INV.EI' AND @Tipo = 'ENTRADA'
       SET @Tipo = 'SALIDA'

     IF ISNULL(@Clave,'') = 'INV.SOL' AND ISNULL(@SubClave,'') = '' AND @Tipo = 'ENTRADA'
       SET @Tipo = 'SALIDA'

  END
  
  IF @Tipo = 'ENTRADA' SET @Tipo = 'Recibo'
  IF @Tipo = 'SALIDA' SET @Tipo = 'Surtido'
  
  SELECT Posicion
    FROM AlmPos
   WHERE Almacen = ISNULL(@Almacen,@Almacen1) AND Tipo = @Tipo

END
GO

--BUG24180
--REQ12615 WMS
/**************** spEmpresaCfgMovWMS ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEmpresaCfgMovWMS') and type = 'P') drop procedure dbo.spEmpresaCfgMovWMS
GO       
CREATE PROCEDURE spEmpresaCfgMovWMS
			@Campo			varchar(50),
			@Empresa		char(5)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
     @Resultado	varchar(50),
     @SQL		nvarchar(max)

  SELECT @Resultado = NULL
  SELECT @sql = 'SELECT '+ @Campo + ' FROM EmpresaCfgMovWMS WHERE Empresa ='''+@Empresa+''''
  EXEC sp_executesql @sql
  RETURN
END
GO

/**************** spTMAPendienteSeleccionar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTMAPendienteSeleccionar') and type = 'P') drop procedure dbo.spTMAPendienteSeleccionar
GO
CREATE PROCEDURE spTMAPendienteSeleccionar
			@Estacion		int,
			@Sucursal		int,
			@ID			int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Tarima		varchar(20), 
    @Almacen		varchar(10), 
    @Posicion		varchar(10), 
    @PosicionDestino  	varchar(10),
    @Renglon		float
    
  SELECT @Renglon = MAX(Renglon) FROM TMAD WHERE ID = @ID
  DECLARE crTMAPendiente CURSOR LOCAL FOR 
   SELECT d.Tarima, d.Almacen, d.Posicion, d.PosicionDestino
     FROM TMAD d
     JOIN ListaIDRenglon l ON l.Estacion = @Estacion AND l.Modulo = 'TMA' AND l.ID = d.ID AND l.Renglon = d.Renglon   
  OPEN crTMAPendiente
  FETCH NEXT FROM crTMAPendiente INTO @Tarima, @Almacen, @Posicion, @PosicionDestino
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF NOT EXISTS(SELECT * FROM TMAD WHERE ID = @ID AND Tarima = @Tarima)
      BEGIN
      	SELECT @Renglon = ISNULL(@Renglon, 0.0) + 2048.0
        INSERT TMAD 
               (ID,  Sucursal,  Renglon,  Tarima,  Almacen,  Posicion,  PosicionDestino)
        VALUES (@ID, @Sucursal, @Renglon, @Tarima, @Almacen, @Posicion, @PosicionDestino)
      END
    END
    FETCH NEXT FROM crTMAPendiente INTO @Tarima, @Almacen, @Posicion, @PosicionDestino
  END
  CLOSE crTMAPendiente
  DEALLOCATE crTMAPendiente
  RETURN
END
GO

/**************** spTMAVerificarContenidoTarima ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTMAVerificarContenidoTarima') and type = 'P') drop procedure dbo.spTMAVerificarContenidoTarima
GO
CREATE PROCEDURE spTMAVerificarContenidoTarima		   
    		@ID             int,
		    @Empresa		varchar(5),
		    @Tarima			varchar(20),
		    @Almacen		varchar(10),
		    @Posicion		varchar(20),
    		@Ok             int          OUTPUT,
    		@OkRef          varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Articulo		varchar(20),
    @Categoria		varchar(50),
    @Grupo			varchar(50),
    @Familia		varchar(50),
	--8. Desarrollo de proceso Cross Docking
	@Tipo           varchar(20)

  DECLARE @Contenido TABLE (Articulo varchar(20) NULL, Categoria varchar(50) NULL, Grupo varchar(50) NULL, Familia varchar(50) NULL)

   --8. Desarrollo de proceso Cross Docking
  SELECT @Tipo = a.Tipo
    FROM AlmPos a 
    LEFT OUTER JOIN Tarima t ON a.Posicion = t.Posicion AND a.Almacen = @Almacen
   WHERE a.Posicion = @Posicion

  INSERT @Contenido (Articulo, Categoria, Grupo, Familia)
  SELECT a.Articulo, a.Categoria, a.Grupo, a.Familia
    FROM ArtExistenciaTarima e
    JOIN Art a ON a.Articulo = e.Articulo
   WHERE e.Empresa = @Empresa AND e.Almacen = @Almacen AND e.Tarima = @Tarima AND NULLIF(e.Existencia, 0) IS NOT NULL
   GROUP BY a.Articulo, a.Categoria, a.Grupo, a.Familia

  IF EXISTS(SELECT * FROM @Contenido)
  BEGIN
    SELECT 
	  @Articulo		= NULLIF(RTRIM(ArticuloEsp), '')
      FROM AlmPos
     WHERE Almacen = @Almacen
	   AND Posicion = @Posicion

    IF @Articulo <> 'NULL' AND @Articulo  IS NOT NULL AND EXISTS(SELECT * FROM @Contenido WHERE Articulo  <> @Articulo) AND @Tipo <> 'Cross Docking' SELECT @Ok = 13230, @OkRef = @Tarima+' - '+@Articulo --8. Desarrollo de proceso Cross Docking
  END
  RETURN
END
GO

/**************** spTMAVerificarPosicion *****************/
if exists (select * from sysobjects where id = object_id('dbo.spTMAVerificarPosicion') and type = 'P') drop procedure dbo.spTMAVerificarPosicion
GO
CREATE PROCEDURE spTMAVerificarPosicion
    		    @ID						int,
				@Accion					char(20),
    		    @Empresa				char(5),
				@Usuario				char(10),
    		    @Modulo	      			char(5),
    		    @Mov              		char(20),
	            @MovID					varchar(20),
    		    @MovTipo				char(20),
				@Almacen				char(10),
				@Posicion				varchar(20),
				@PosicionDestino		varchar(20),
				@Tipo					varchar(20),
				@TipoDestino			varchar(20),
				@Articulo				varchar(20),			
    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @ArtZona							varchar(50),
    @AlmPosZona							varchar(50),
    @WMSPermitirReacomodosDomicilio		bit
     
  SELECT @WMSPermitirReacomodosDomicilio = ISNULL(WMSPermitirReacomodosDomicilio,0) FROM EmpresaCfg WHERE Empresa = @Empresa
  
  IF @Tipo = 'Domicilio' AND @TipoDestino <> 'Domicilio'
    SELECT @Ok = 10038
  ELSE
  IF @Tipo = 'Domicilio' AND @TipoDestino = 'Domicilio'
  BEGIN
    IF @WMSPermitirReacomodosDomicilio = 0
      SELECT @OK = 20926
    ELSE
    IF(SELECT ISNULL(ArticuloEsp,'') FROM AlmPos WHERE Almacen = @Almacen AND Posicion = @PosicionDestino) <> '' AND @WMSPermitirReacomodosDomicilio = 1
      SELECT @Ok = 20927, @OkRef = 'Posición  ' + @PosicionDestino
    ELSE
    IF EXISTS(SELECT * FROM TMA w JOIN TMAD d ON w.ID = d.ID JOIN MovTipo m ON w.mov = m.Mov AND m.Modulo = 'TMA' WHERE m.Clave IN('TMA.ADO', 'TMA.RADO', 'TMA.SUR', 'TMA.TSUR', 'TMA.TSUR') AND w.Estatus IN('PENDIENTE', 'PROCESAR') AND d.PosicionDestino = @PosicionDestino)
      SELECT @Ok = 20929, @OkRef = 'Posición  ' + @PosicionDestino
    ELSE
    BEGIN
      SELECT @ArtZona = NULL, @AlmPosZona = NULL
      SELECT @ArtZona = NULLIF(Zona,'') FROM  ArtZona WHERE Articulo = @Articulo AND Zona = '(Todas)'
      SELECT @AlmPosZona = NULLIF(Zona,'') FROM AlmPos WHERE Posicion = @PosicionDestino AND Zona = '(Todas)'

      IF @ArtZona <> @AlmPosZona
      BEGIN
        IF ISNULL(@ArtZona,'') <> '(Todas)' AND ISNULL(@AlmPosZona,'') <> '(Todas)'
		  IF NOT EXISTS(SELECT * FROM ArtZona WHERE Articulo = @Articulo AND Zona IN (SELECT Zona FROM AlmPos WHERE Posicion = @PosicionDestino))
		    SELECT @Ok = 20928, @OkRef = 'Posición  ' + @PosicionDestino
      END
    END    
  END
END
GO

/**************** spTMAVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTMAVerificar') and type = 'P') drop procedure dbo.spTMAVerificar
GO
CREATE PROCEDURE spTMAVerificar
    		@ID               	int,
		    @Accion				char(20),
    		@Empresa          	char(5),
		    @Usuario			char(10),
    		@Modulo	      		char(5),
    		@Mov              	char(20),
	        @MovID				varchar(20),
    		@MovTipo	      	char(20),
		    @MovMoneda			char(10),
		    @MovTipoCambio		float,
		    @FechaEmision		datetime,
		    @Estatus			char(15),
		    @EstatusNuevo		char(15),

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,

		    @Almacen			char(10),
		    @Agente				varchar(10),

    		@Ok               	int          OUTPUT,
    		@OkRef            	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Tarima					varchar(20), 
    @TarimaEstatus			varchar(15),
    @TarimaPosicion			varchar(10),
    @Posicion				varchar(10), 
    @PosicionDestino		varchar(10),
    @EstaPendiente			bit,
    
    --REQ12615 WMS
    @WMS					bit,
    @WMSValidarZona			bit,
    @SubClave				char(20),
    @TipoMov				varchar(20),
    @Renglon				float,
    @Articulo				varchar(20),
    @Montacarga				varchar(10),
    @MontacargaD			varchar(10),
    @WMSTipoAcomodador		varchar(50),
    @ZonaAgente				varchar(50),
    @ZonaDetalle    		varchar(50),
    @PesoMaximoMontaCarga	float,
    @PesoMovimiento			float,
    @Tipo					varchar(20),
    @TipoDestino			varchar(20),
    @WMSPermitirReacoDom	bit,
    @ArtZona				varchar(50),
    @AlmPosZona				varchar(50),
    @VolumenMovimiento		float,    
    @VolumenMaximoPosicion	float,
    @PosicionDestinoArt		varchar(10),
    @PesoMaximoPosicion		float,
    @AlmacenArt				varchar(10),
    @CantidadAfectar		float,
    @CantidadPendiente		float

  --REQ12615 WMS
  SELECT @WMS = ISNULL(WMS,0) FROM Alm WHERE Almacen = @Almacen
  SELECT @WMSValidarZona		= ISNULL(WMSValidarZona,0),
         @WMSTipoAcomodador		= ISNULL(WMSTipoAcomodador,''),
         @WMSPermitirReacoDom	= ISNULL(WMSPermitirReacomodosDomicilio,0)
    FROM EmpresaCfg
   WHERE Empresa = @Empresa
  SELECT TOP 1 @SubClave = SubClave FROM MovTipo WHERE Mov = @Mov AND Modulo = @Modulo

  --BUG7778
  IF @Accion = 'AFECTAR' AND @MovTipo NOT IN ('TMA.SUR', 'TMA.SURPER', 'TMA.SRADO', 'TMA.ORADO', 'TMA.RADO', 'TMA.OPCKTARIMA', 'TMA.OSUR', 'TMA.PCKTARIMA', 'TMA.PCKTARIMATRAN', 'TMA.SURPER', 'TMA.TSUR')--BUG 7655 USB Se quita validación para esos movimientos directos.
    EXEC spTMAVerificarSerieLote @Empresa, @Sucursal, @ID, @Ok OUTPUT, @OkRef OUTPUT
  --Task 8036
    
  IF @Accion = 'CANCELAR'
  BEGIN
    -- Checar que se haya capturado el movimiento en este modulo
    IF @Conexion = 0 
      IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo)
	SELECT @Ok = 60070

    IF @MovTipo IN ('TMA.OSUR', 'TMA.OPCKTARIMA') AND @Estatus IN('PENDIENTE', 'CONCLUIDO') AND EXISTS(SELECT * FROM TMA WHERE Origen = @Mov AND OrigenID = @MovID AND OrigenTipo = 'TMA' AND Estatus IN('CONCLUIDO', 'PROCESAR')) --TASK6535
      SELECT @Ok = 60060
	
  END 

  --REQ12615 WMS
  IF @Almacen IS NULL AND @OK IS NULL SELECT @Ok = 20390 ELSE
  IF @WMS = 0 AND @OK IS NULL SELECT @Ok = 20937, @OkRef = @Almacen
     
  IF @MovTipo IN ('TMA.TSUR', 'TMA.ORADO', 'TMA.OADO', 'TMA.ADO', 'TMA.RADO', 'TMA.ORENT', 'TMA.SURPER', 'TMA.SUR', 'TMA.PCKTARIMATRAN', 'TMA.PCKTARIMA') AND @Accion <> 'CANCELAR' AND @OK IS NULL --TASK6535
  BEGIN  
     IF ISNULL(@Agente,'') = '' 
       SELECT @Ok = 20931, @OkRef = '' + CHAR(13) + @Mov + ' - ' + @MovID
     IF (SELECT COUNT(0) FROM TMA WHERE ID = @ID AND ISNULL(Montacarga,'') = '') >0
       SELECT @Ok = 20919, @OkRef = '' + CHAR(13) + @Mov + ' - ' + @MovID
  END     
    
  IF @Accion NOT IN('CANCELAR', 'GENERAR') AND @MovTipo IN ('TMA.OADO', 'TMA.SADO', 'TMA.ADO', 'TMA.ORADO', 'TMA.SRADO', 'TMA.RADO', 'TMA.OSUR', 'TMA.TSUR', 'TMA.SUR', 'TMA.OSUR', 'TMA.OPCKTARIMA', 'TMA.PCKTARIMATRAN', 'TMA.PCKTARIMA') AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000) --TASK6535
  BEGIN
    IF @MovTipo IN ('TMA.OADO', 'TMA.SADO', 'TMA.ADO')
      SELECT @TipoMov = Mov FROM MovTipo WHERE Clave = 'TMA.ADO' AND Modulo = @Modulo
    ELSE
    IF @MovTipo IN ('TMA.ORADO', 'TMA.SRADO', 'TMA.RADO')
      SELECT @TipoMov = Mov FROM MovTipo WHERE Clave = 'TMA.RADO' AND Modulo = @Modulo
    ELSE   
    IF @MovTipo IN ('TMA.OSUR', 'TMA.TSUR', 'TMA.SUR', 'TMA.OPCKTARIMA', 'TMA.PCKTARIMATRAN', 'TMA.PCKTARIMA') --TASK6535
      SELECT @TipoMov = Mov FROM MovTipo WHERE Clave = 'TMA.SUR' AND Modulo = @Modulo          
  END

  IF @Ok IS NULL
    IF(SELECT COUNT(*) FROM TMAD d LEFT OUTER JOIN Tarima t ON t.Tarima = d.Tarima LEFT OUTER JOIN ArtDisponibleTarima a ON d.Tarima = a.Tarima WHERE d.ID = @ID) < 1
      SELECT @Ok = 60010
  --REQ12615 WMS
  IF @MovTipo IN('TMA.OADO','TMA.ORADO',/*'TMA.OSUR',*/'TMA.SURPER') AND @Agente IS NULL AND @Ok IS NULL
    SELECT @Ok = 20931
    
  IF @Ok IS NULL
  BEGIN
    DECLARE crVerificarTMAD CURSOR LOCAL FOR 
     SELECT NULLIF(RTRIM(d.Tarima), ''), NULLIF(RTRIM(d.Almacen), ''), NULLIF(RTRIM(d.Posicion), ''), NULLIF(RTRIM(d.PosicionDestino), ''), d.EstaPendiente, t.Estatus, t.Posicion, d.Renglon, a.Articulo, NULLIF(RTRIM(d.Montacarga), '') --REQ12615 WMS
       FROM TMAD d
       LEFT OUTER JOIN Tarima t ON t.Tarima = d.Tarima
       LEFT OUTER JOIN ArtDisponibleTarima a ON d.Tarima = a.Tarima AND d.Articulo=a.Articulo --REQ12615 WMS --CAMBIOS USB
      WHERE d.ID = @ID
    OPEN crVerificarTMAD
    FETCH NEXT FROM crVerificarTMAD INTO @Tarima, @Almacen, @Posicion, @PosicionDestino, @EstaPendiente, @TarimaEstatus, @TarimaPosicion, @Renglon, @Articulo, @Montacarga --REQ12615 WMS
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      --REQ12615 WMS
      IF @@FETCH_STATUS <> -2 
      BEGIN            
        IF EXISTS(SELECT * FROM Agente WHERE Agente = @Montacarga AND Tipo =  @WMSTipoAcomodador)
          SELECT @ZonaAgente = NULLIF(@Montacarga,'') ELSE SELECT @ZonaAgente = Agente FROM TMA WHERE ID = @ID

		  --BUG 7548 Se valida que no este pendiente (Inicio)
		  IF @Ok IS NULL AND @Accion<>'CANCELAR' AND @MovTipo IN('TMA.ORADO', 'TMA.SRADO', 'TMA.RADO') 
		  BEGIN
				IF EXISTS(SELECT * FROM WMSTarimasSurtidoPendientes WHERE Empresa=@Empresa AND Articulo=@Articulo AND Tarima=@Tarima AND CantidadPendiente IS NOT NULL)
				SELECT @Ok=13040, @OkRef='('+LTRIM(RTRIM(@Articulo))+' - '+LTRIM(RTRIM(@Tarima))+')'
		  END 
		  --BUG 7548 Se valida que no este pendiente (Fin)
    
        --IF @MovTipo IN('TMA.ORADO', 'TMA.RADO', 'TMA.SRADO', 'TMA.OSUR', 'TMA.SUR', 'TMA.SURPER', 'TMA.TSUR')
		IF @MovTipo IN('TMA.OSUR', 'TMA.SUR', 'TMA.SURPER', 'TMA.TSUR','TMA.OPCKTARIMA', 'TMA.PCKTARIMATRAN', 'TMA.PCKTARIMA') --BUG3752 --TASK6535
          SELECT @ZonaDetalle = Zona FROM AlmPos WHERE Posicion = @Posicion AND Almacen = @Almacen AND Tipo NOT IN('RECIBO', 'SURTIDO')  
        ELSE  
          SELECT @ZonaDetalle = Zona FROM AlmPos WHERE Posicion = @PosicionDestino AND Almacen = @Almacen AND Tipo NOT IN('RECIBO', 'SURTIDO')  



        --BUG3724
		IF @WMSValidarZona = 1 AND @Accion <> 'CANCELAR' AND NULLIF(@ZonaDetalle,'') IS NULL AND NULLIF(@ZonaAgente,'')<>'' 
		        AND EXISTS(SELECT * FROM AgenteZona WHERE Agente = ISNULL(@ZonaAgente,Agente) AND ISNULL(NULLIF(Tipo,''),@TipoMov) NOT IN (@TipoMov,'(Todos)'))
				  AND @Ok IS NULL
           SELECT @Ok = 20946, @OkRef='Flujo: ' + @TipoMov +'<BR><BR>'+ 'Tarima: '+ @Tarima + '<BR><BR>' +'Agente : '+@ZonaAgente

		IF @WMSValidarZona = 1 AND @Accion <> 'CANCELAR' AND NULLIF(@ZonaDetalle,'')<>'' AND NULLIF(@ZonaAgente,'')<>'' --BUG3692
                AND EXISTS(SELECT * FROM AgenteZona WHERE Agente = ISNULL(@ZonaAgente,Agente)) --BUG3714
                  AND @Ok IS NULL
        BEGIN
		  --BUG3693
		  IF @TipoMov NOT IN (SELECT Tipo
                          FROM AgenteZona 
                         --WHERE Agente = ISNULL(@Agente,Agente) 
						 WHERE Agente = ISNULL(@ZonaAgente,Agente) --BUG3691
                           AND ISNULL(NULLIF(Tipo,''),@TipoMov) <>'(Todos)') 
						   AND NOT EXISTS (SELECT Tipo
                                           FROM AgenteZona 
                                           --WHERE Agente = ISNULL(@Agente,Agente) 
						                   WHERE Agente = ISNULL(@ZonaAgente,Agente) --BUG3691
                                             AND ISNULL(NULLIF(Tipo,''),@TipoMov)='(Todos)') AND @Ok IS NULL						    
            SELECT @Ok = 20945, @OkRef='Tarima: '+ @Tarima + '<BR><BR>' +'Agente : '+@ZonaAgente

          IF NOT EXISTS(SELECT * 
                          FROM AgenteZona 
                         --WHERE Agente = ISNULL(@Agente,Agente) 
						 WHERE Agente = ISNULL(@ZonaAgente,Agente) --BUG3691
                           AND ISNULL(NULLIF(Tipo,''),@TipoMov) IN (@TipoMov,'(Todos)') 
                           AND Zona IN(ISNULL(@ZonaDetalle,Zona),'(TODAS)','(TODOS)')) AND @Ok IS NULL
            SELECT @Ok = 20934, @OkRef='Tarima: '+ @Tarima + '<BR><BR>' +'Agente : '+@ZonaAgente
		END
      
	    IF @Accion <> 'CANCELAR' AND @Ok IS NULL
	    BEGIN

	      SELECT @Montacarga = Montacarga FROM TMA WHERE ID = @ID
		  SELECT @PesoMaximoMontaCarga = ISNULL(PesoMaximo,0.0) FROM Montacarga WHERE Montacarga = @Montacarga
		  
		  DECLARE crVerificaPesoMontaCarga CURSOR FOR
		  SELECT a.PesoTarima, a.VolumenTarima
		    FROM ArtDisponibleTarima adt
		    JOIN TMAD td ON adt.Almacen = td.Almacen AND adt.Tarima = td.Tarima
		    JOIN Art a ON adt.Articulo = a.Articulo
		   WHERE adt.Empresa = @Empresa
		     AND td.ID = @ID
		     AND td.Tarima = @Tarima
		  OPEN crVerificaPesoMontaCarga
		  FETCH NEXT FROM crVerificaPesoMontaCarga INTO @PesoMovimiento, @VolumenMovimiento
		  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
		  BEGIN
	        IF @PesoMovimiento > @PesoMaximoMontaCarga SET @Ok = 20932
		    FETCH NEXT FROM crVerificaPesoMontaCarga INTO @PesoMovimiento, @VolumenMovimiento
		  END
		  CLOSE crVerificaPesoMontaCarga
		  DEALLOCATE crVerificaPesoMontaCarga
	    END
	  END

      IF(SELECT Estatus FROM AlmPos WHERE Posicion = @Posicion AND Almacen = @Almacen) <> 'ALTA' AND @Ok IS NULL
        SELECT @Ok = 13037, @OkRef = ' Posición Origen - ' + RTRIM(@Posicion)
	  
	  --BUG24871
      IF NULLIF(RTRIM(@PosicionDestino), '') IS NOT NULL AND (SELECT Estatus FROM AlmPos WHERE Posicion = @PosicionDestino AND Almacen = @Almacen) <> 'ALTA' AND @Ok IS NULL    
        SELECT @Ok = 13037, @OkRef = ' Posición Destino - ' + RTRIM(@PosicionDestino)  

      IF(SELECT Estatus FROM AlmPos WHERE Posicion = @PosicionDestino AND Almacen = @Almacen) <> 'ALTA' AND @Ok IS NULL
        SELECT @Ok = 13037, @OkRef = ' Posición Destino - ' + RTRIM(@PosicionDestino)
   
      --IF @Ok IS NULL AND @MovTipo IN ('TMA.ORADO', 'TMA.SRADO', 'TMA.RADO', 'TMA.ADO', 'TMA.OADO', 'TMA.SADO') AND @Accion <> 'CANCELAR'
      IF @Ok IS NULL AND @MovTipo IN ('TMA.ORADO', 'TMA.SRADO', 'TMA.RADO', 'TMA.ADO', 'TMA.OADO') AND @Accion <> 'CANCELAR' --BUG2970 11092015
      BEGIN
        SELECT @Tipo = ISNULL(Tipo,'') FROM AlmPos WHERE Posicion = @Posicion AND Almacen = @Almacen
        SELECT @TipoDestino = ISNULL(Tipo,'') FROM AlmPos WHERE Posicion = @PosicionDestino AND Almacen = @Almacen

        IF @Tipo NOT IN ('Ubicacion', 'Domicilio', 'Surtido', 'Cross Docking') AND @MovTipo NOT IN ('TMA.ADO', 'TMA.OADO', 'TMA.SADO')
          SELECT @Ok = 20924
        ELSE
		IF @Tipo IN ('Surtido') AND @TipoDestino <> 'Domicilio' AND @MovTipo NOT IN ('TMA.ADO', 'TMA.OADO', 'TMA.SADO')--CAMBIOS USB
			SELECT @Ok = 20949, @OkRef=@Tarima+' - '+@Articulo
		ELSE
        IF ISNULL(@Tipo,'') NOT IN ('Recibo', '') AND @MovTipo IN ('TMA.ADO', 'TMA.OADO', 'TMA.SADO')
          SELECT @Ok = 20922
        ELSE
        IF @TipoDestino NOT IN ('Ubicacion', 'Domicilio', 'Cross Docking') AND ISNULL(@PosicionDestino,'') <> '' --8. Desarrollo de proceso Cross Docking
          SELECT @Ok = 20925
          
        --IF @OK IS NULL AND @MovTipo NOT IN('TMA.ADO', 'TMA.OADO', 'TMA.SADO')
        IF @OK IS NULL AND @MovTipo NOT IN('TMA.ADO', 'TMA.OADO') --BUG2970 11092015
        BEGIN
          IF @Tipo = 'Domicilio' AND @TipoDestino <> 'Domicilio'
            SELECT @Ok = 10038
          ELSE
          IF @Tipo = 'Domicilio' AND @TipoDestino = 'Domicilio'
          BEGIN
            IF @WMSPermitirReacoDom = 0
              SELECT @OK = 20926
            ELSE
            IF(SELECT ISNULL(ArticuloEsp,'') FROM AlmPos WHERE Almacen = @Almacen AND Posicion = @PosicionDestino) <> '' AND @WMSPermitirReacoDom = 1
              SELECT @Ok = 20927, @OkRef = 'Posición  ' + @PosicionDestino
            ELSE
            IF EXISTS(SELECT * FROM TMA w JOIN TMAD d ON w.ID = d.ID JOIN MovTipo m ON w.mov = m.Mov AND m.Modulo = 'TMA' WHERE m.Clave IN('TMA.ADO', 'TMA.RADO', 'TMA.SUR', 'TMA.TSUR', 'TMA.TSUR') AND w.Estatus IN('PENDIENTE', 'PROCESAR') AND d.PosicionDestino = @PosicionDestino)
              SELECT @Ok = 20929, @OkRef = 'Posición  ' + @PosicionDestino
            ELSE
            BEGIN
              SELECT @ArtZona = NULL, @AlmPosZona = NULL
              SELECT @ArtZona = NULLIF(Zona,'') FROM  ArtZona WHERE Articulo = @Articulo AND Zona = '(Todas)'
              SELECT @AlmPosZona = NULLIF(Zona,'') FROM AlmPos WHERE Posicion = @PosicionDestino AND Zona = '(Todas)'
                
              IF @ArtZona <> @AlmPosZona
              BEGIN
                IF ISNULL(@ArtZona,'') <> '(Todas)' AND ISNULL(@AlmPosZona,'') <> '(Todas)'
                  IF NOT EXISTS(SELECT * FROM ArtZona WHERE Articulo = @Articulo AND Zona IN (SELECT Zona FROM AlmPos WHERE Posicion = @PosicionDestino))
                    SELECT @Ok = 20928, @OkRef = 'Posición  ' + @PosicionDestino
              END
            END
          END                    
          --EXEC spTMAVerificarPosicion @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @Almacen, @Posicion, @PosicionDestino, @Tipo, @TipoDestino, @Articulo, @Ok OUTPUT, @OkRef OUTPUT
        END
      END      
      
      IF @MovTipo IN('TMA.SRADO','TMA.RADO') AND @Ok IS NULL
      BEGIN
        IF @Tipo = 'Domicilio' AND @TipoDestino = 'Domicilio'
        BEGIN        
          IF EXISTS(SELECT * FROM TMA t
                      JOIN TMAD d ON t.ID = d.ID
                      JOIN MovTipo m ON t.Mov = m.Mov AND m.Modulo = 'TMA'
                     WHERE t.Estatus IN ('PENDIENTE', 'PROCESAR')
                       AND d.PosicionDestino = @Posicion
                       AND m.Clave IN ('TMA.OADO', 'TMA.ORADO', 'TMA.OSUR'))
            SELECT @Ok = 20938
        END
        ELSE
        BEGIN
          IF EXISTS(SELECT * FROM TMA t
                      JOIN TMAD d ON t.ID = d.ID
                      JOIN MovTipo m ON t.Mov = m.Mov AND m.Modulo = 'TMA'
                     WHERE t.Estatus IN ('PENDIENTE', 'PROCESAR') --EMG
                       AND d.Tarima = @Tarima 
                       AND m.Clave NOT IN ('TMA.OADO', 'TMA.ORADO', 'TMA.SADO', 'TMA.SRADO', 'TMA.ADO', 'TMA.RADO'))
             SELECT @Ok = 20938
        END
      END
          
      --IF @Ok IS NULL AND @Accion <> 'CANCELAR' AND @MovTipo NOT IN ('TMA.SURPER')
	  IF @Ok IS NULL AND @Accion <> 'CANCELAR' AND @MovTipo NOT IN ('TMA.SURPER', 'TMA.SADO') --BUG2970 11092015
      BEGIN
        IF EXISTS(SELECT * FROM ArtUnidad WHERE Articulo = @Articulo)
          DECLARE crVerificaPesoUbicacion CURSOR FOR
           SELECT SUM(u.Peso), SUM(u.Volumen), td.PosicionDestino, td.Almacen
             FROM ArtDisponibleTarima adt
             JOIN TMAD td ON adt.Almacen = td.Almacen AND adt.Tarima = td.Tarima
             JOIN Art a ON adt.Articulo = a.Articulo
             JOIN ArtUnidad u ON a.Articulo = u.Articulo AND a.Unidad = u.Unidad
            WHERE adt.Empresa = @Empresa AND td.ID = @ID
            GROUP BY td.PosicionDestino, td.Almacen
	    ELSE
          DECLARE crVerificaPesoUbicacion CURSOR FOR
           SELECT SUM(a.PesoTarima), SUM(a.VolumenTarima), td.PosicionDestino, td.Almacen
             FROM ArtDisponibleTarima adt
             JOIN TMAD td ON adt.Almacen = td.Almacen AND adt.Tarima = td.Tarima
             JOIN Art a ON adt.Articulo = a.Articulo
            WHERE adt.Empresa = @Empresa AND td.ID = @ID
            GROUP BY td.PosicionDestino, td.Almacen

        OPEN crVerificaPesoUbicacion
        FETCH NEXT FROM crVerificaPesoUbicacion INTO @PesoMovimiento, @VolumenMovimiento, @PosicionDestinoArt, @AlmacenArt
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN
          SELECT @Tipo = Tipo,
                 @VolumenMaximoPosicion = Volumen,
                 @PesoMaximoPosicion = PesoMaximo
            FROM AlmPos
           WHERE Almacen = @AlmacenArt AND Posicion = @PosicionDestinoArt
           
          IF @PesoMovimiento > @PesoMaximoPosicion AND @Tipo = 'Ubicacion'
            --SET @Ok = 20941
            --BUG3628
			SELECT @Ok = 20943, @OkRef= 'Posición: ' + @PosicionDestinoArt + '<BR><BR>' + 'Peso Movimiento: '+ CONVERT(varchar(20), CONVERT(numeric(12,2),@PesoMovimiento)) + '<BR><BR>' + 'Peso Máximo: '  + CONVERT(varchar(20), @PesoMaximoPosicion)			

          --BUG3628		  
		  IF @Ok IS NULL AND @VolumenMovimiento > @VolumenMaximoPosicion AND @Tipo = 'Ubicacion'
			SELECT @Ok = 20944, @OkRef= 'Posición: ' + @PosicionDestinoArt + '<BR><BR>' + 'Volumen Movimiento: '+ CONVERT(varchar(20), CONVERT(numeric(12,2), @VolumenMovimiento)) + '<BR><BR>' + 'Volumen Máximo: '  + CONVERT(varchar(20), @VolumenMaximoPosicion)			

          FETCH NEXT FROM crVerificaPesoUbicacion INTO @PesoMovimiento, @VolumenMovimiento, @PosicionDestinoArt, @AlmacenArt
        END
        CLOSE crVerificaPesoUbicacion
        DEALLOCATE crVerificaPesoUbicacion
      END
      --REQ12615 WMS
      
      IF @Ok IS NULL AND @Accion <> 'CANCELAR'
      BEGIN
        --REQ12615 WMS
        IF @MovTipo NOT IN ('TMA.OSUR', 'TMA.SUR', 'TMA.PCKTARIMATRAN', 'TMA.PCKTARIMA') AND @SubClave NOT IN ('TMA.OSURP', 'TMA.SURP') --TASK6535
        BEGIN
          SELECT @CantidadAfectar =  ISNULL(CantidadPicking,0) FROM TMAD WHERE ID = @ID AND Renglon = @Renglon
          
		  --BUG7778
		  --SELECT @CantidadPendiente = ISNULL(ISNULL(NULLIF(CantidadA,0),CantidadPendiente), CantidadPicking) FROM TMAD WHERE ID = (SELECT TOP 1 t.ID FROM TMA t JOIN TMAD d ON t.mov = d.Aplica AND t.MovID = D.AplicaID AND d.Tarima = @Tarima AND d.ID = @ID) AND Renglon = @Renglon
		  SELECT @CantidadPendiente = ISNULL((CantidadPendiente), CantidadPicking) FROM TMAD WHERE ID = (SELECT TOP 1 t.ID FROM TMA t JOIN TMAD d ON t.mov = d.Aplica AND t.MovID = D.AplicaID AND d.Tarima = @Tarima AND d.ID = @ID) AND Renglon = @Renglon

		  --BUG24108
          IF @MovTipo = 'TMA.SURPER'
            SELECT @CantidadPendiente = ISNULL(ISNULL(CantidadPendiente,CantidadPicking), 0) FROM TMAD WHERE ID = (SELECT TOP 1 t.ID FROM TMA t JOIN TMAD d ON t.mov = d.Aplica AND t.MovID = D.AplicaID AND d.ID = @ID) AND Renglon = @Renglon			

          IF @SubClave IS NULL AND @CantidadPendiente = 1
            SELECT @CantidadPendiente = Disponible FROM ArtDisponibleTarima WHERE Tarima = @Tarima AND Almacen = @Almacen AND Articulo = @Articulo

          IF @CantidadAfectar > @CantidadPendiente SELECT @Ok = 20160
		END
		ELSE
        IF @Tarima IS NULL AND @MovTipo IN ('TMA.SUR', 'TMA.PCKTARIMA') --TASK6535
        BEGIN
            EXEC spConsecutivo 'Tarima', @Sucursal, @Tarima OUTPUT
            EXEC spTarimaAlta @Empresa, @Sucursal, '', @Almacen, @FechaEmision, @FechaEmision, @Tarima, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT  
        END
        IF @Tarima IS NULL SELECT @Ok = 13130 ELSE
        IF @Almacen IS NULL SELECT @Ok = 20390 ELSE
        IF @Posicion IS NULL SELECT @Ok = 13050
        --REQ12615 WMS
        IF @MovTipo IN ('TMA.SADO', 'TMA.OADO', 'TMA.ADO', 'TMA.RADO', 'TMA.SRADO', 'TMA.ORADO')
        BEGIN
          IF @Accion <> 'CANCELAR' 
          BEGIN            
            --BUG2970
            IF NULLIF(@PosicionDestino, '') IS NULL AND @MovTipo NOT IN ('TMA.SADO', 'TMA.OADO', 'TMA.ADO') 
                   SELECT @Ok = 13055 ELSE
            IF @Posicion = @PosicionDestino SELECT @Ok = 13035 ELSE
            IF @MovTipo IN ('TMA.SADO', 'TMA.OADO', 'TMA.RADO', 'TMA.SRADO', 'TMA.ORADO')
            BEGIN
              IF EXISTS(SELECT * 
                          FROM TMAD d 
                          JOIN TMA e ON e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus = 'PENDIENTE' 
                          JOIN MovTipo mt ON mt.Modulo = @Modulo AND mt.Mov = e.Mov AND mt.Clave = @MovTipo
                         WHERE d.Tarima = @Tarima AND d.EstaPendiente = 1)
                SELECT @Ok = 13200
              
              IF @Ok IS NULL
              BEGIN
                IF @MovTipo IN ('TMA.RADO')
                  IF dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, @PosicionDestino, @Articulo, @ID, 1) = 0 SELECT @Ok = 13220
                
				--IF @MovTipo NOT IN ('TMA.RADO')
                IF @MovTipo NOT IN ('TMA.RADO', 'TMA.SADO') --BUG2970 11092015
                  --IF dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, @PosicionDestino, @Articulo, @ID, 0) = 0 SELECT @Ok = 13220
				  IF dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, @PosicionDestino, @Articulo, @ID, 1) = 0 SELECT @Ok = 13220 --BUG2970                     
                                
				--BUG2970  
                IF @Ok = 13220 AND(SELECT Tipo FROM AlmPos WHERE Almacen = @Almacen AND Posicion = @PosicionDestino) = 'Domicilio' AND @MovTipo IN('TMA.ADO', 'TMA.OADO', 'TMA.SADO') SELECT @Ok = NULL
                IF @Ok = 13220 AND @PosicionDestino IS NULL AND @MovTipo IN('TMA.ADO', 'TMA.OADO', 'TMA.SADO') SELECT @Ok = NULL --BUG2970 25082015
				--BUG3628
				IF @Ok = 13220
                BEGIN
                  SELECT @Ok = NULL
				            IF @MovTipo <> 'TMA.OADO'
				            EXEC spAlmPosTieneCapacidadWMS @Empresa, @Almacen, @PosicionDestino, @Articulo, @Tarima, @Renglon, @ID, 1, @Ok OUTPUT, @OkRef OUTPUT
                 
                END
                                      
              END
            
            END
            ELSE
            IF @MovTipo = 'TMA.ADO' 
            BEGIN
              IF EXISTS(SELECT * 
                          FROM TMAD d 
                          JOIN TMA e ON e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus = 'PENDIENTE' 
                          JOIN MovTipo mt ON mt.Modulo = @Modulo AND mt.Mov = e.Mov AND mt.Clave = 'TMA.OADO'
                         WHERE e.id = @ID AND d.Tarima = @Tarima AND d.EstaPendiente = 1 AND (d.Almacen <> @Almacen OR d.Posicion <> @Posicion OR d.PosicionDestino <> @PosicionDestino))
                 SELECT @Ok = 13210
         
              --SELECT @Articulo = Articulo FROM ArtDisponibleTarima WHERE Tarima = @Tarima --BUG2429PGC
              SELECT @Articulo = Articulo FROM Tarima WHERE Tarima = @Tarima --BUG2429PGC

              -- Validar la Capacidad de la Posicion
              IF @Ok IS NULL AND @MovTipo <> 'TMA.RADO'
                IF dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, @PosicionDestino, @Articulo, @ID, 1) = 0 SELECT @Ok = 13220

			  --BUG2970  
		      --EWQ. Tuning2
              IF @Ok = 13220 AND (SELECT Tipo FROM AlmPos WHERE Almacen = @Almacen AND Posicion = @PosicionDestino) = 'Domicilio' AND @MovTipo IN('TMA.ADO', 'TMA.OADO', 'TMA.SADO') 
                SELECT @Ok = NULL --BUG3340 --BUG2970 26082015
              IF @Ok = 13220 AND @PosicionDestino IS NULL AND @MovTipo IN('TMA.ADO', 'TMA.OADO', 'TMA.SADO') 
                SELECT @Ok = NULL --BUG2970 25082015
              --BUG3628
		      IF @Ok = 13220
              BEGIN
                SELECT @Ok = NULL
                IF @MovTipo <> 'TMA.OADO'
			          EXEC spAlmPosTieneCapacidadWMS @Empresa, @Almacen, @PosicionDestino, @Articulo, @Tarima, @Renglon, @ID, 1, @Ok OUTPUT, @OkRef OUTPUT                  
              END

            END
          ----------------------------------------------------------------------------------
          -- Quitar validacion temporalmente para VOIT 2016-03-30 jolmosh
          --IF @Ok = 13220 SET @Ok = NULL
          IF @MovTipo = 'TMA.OADO' AND @Ok IS NOT NULL
            SET @Ok = NULL
          
          ----------------------------------------------------------------------------------
            
            IF @Ok IS NULL AND (SELECT Tipo FROM AlmPos WHERE Almacen = @Almacen AND Posicion = @Posicion)<>'Surtido' --CAMBIO USB
              EXEC spTMAVerificarContenidoTarima @ID, @Empresa, @Tarima, @Almacen, @PosicionDestino, @Ok OUTPUT, @OkRef OUTPUT

          END
          ELSE
          BEGIN
            IF @MovTipo = 'TMA.ADO' AND @PosicionDestino <> @TarimaPosicion SELECT @Ok = 13190 
            IF @MovTipo IN ('TMA.SADO', 'TMA.OADO') AND @EstaPendiente = 0 SELECT @Ok = 13020
          END
        END
      END

      IF @Ok IS NOT NULL AND @OkRef IS NULL SELECT @OkRef = @Tarima
      FETCH NEXT FROM crVerificarTMAD INTO @Tarima, @Almacen, @Posicion, @PosicionDestino, @EstaPendiente, @TarimaEstatus, @TarimaPosicion, @Renglon, @Articulo, @Montacarga --REQ12615 WMS
    END
    CLOSE crVerificarTMAD
    DEALLOCATE crVerificarTMAD

  END
  RETURN
END
GO

/**************** spTMAAplicar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTMAAplicar') and type = 'P') drop procedure dbo.spTMAAplicar
GO
CREATE PROCEDURE spTMAAplicar
    		    @ID			int,
		    @Accion		char(20),
    		    @Empresa		char(5),
		    @Tarima		varchar(20),
		    @Almacen		varchar(10),

		    @PosicionAnterior	varchar(10),
		    @PosicionNueva	varchar(10),
		    @AplicaMovTipo	varchar(20),

		    @Ok			int		OUTPUT,
		    @OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
DECLARE
  @IDAplica int

 IF @Accion <> 'CANCELAR'
 BEGIN
   -- Buscar Orden Acomodo
   SELECT @IDAplica = NULL
   SELECT @IDAplica = MIN(e.ID) 
     FROM TMA e 
     JOIN MovTipo mt ON mt.Modulo = 'TMA' AND mt.Mov = e.Mov AND mt.Clave = @AplicaMovTipo
     JOIN TMAD d ON d.ID = e.ID
    WHERE e.Empresa = @Empresa AND e.Estatus = 'PENDIENTE' 
      AND d.Tarima = @Tarima AND d.Almacen = @Almacen AND d.Posicion = @PosicionAnterior AND d.PosicionDestino = @PosicionNueva AND d.EstaPendiente = 1
   IF @IDAplica IS NOT NULL
   BEGIN
     UPDATE TMAD 
        SET EstaPendiente = 0
      WHERE ID = @IDAplica AND Tarima = @Tarima AND Almacen = @Almacen AND Posicion = @PosicionAnterior AND PosicionDestino = @PosicionNueva AND EstaPendiente = 1
     IF NOT EXISTS(SELECT * FROM TMAD WHERE ID = @IDAplica AND EstaPendiente = 1)
       UPDATE TMA SET Estatus = 'CONCLUIDO' WHERE ID = @IDAplica
    END
  END ELSE
  BEGIN
   -- Buscar Orden Acomodo
   SELECT @IDAplica = NULL
   SELECT @IDAplica = MAX(e.ID) 
     FROM TMA e 
     JOIN MovTipo mt ON mt.Modulo = 'TMA' AND mt.Mov = e.Mov AND mt.Clave = @AplicaMovTipo
     JOIN TMAD d ON d.ID = e.ID
    WHERE e.Empresa = @Empresa AND e.Estatus IN ('PENDIENTE', 'CONCLUIDO')
      AND d.Tarima = @Tarima AND d.Almacen = @Almacen AND d.Posicion = @PosicionAnterior AND d.PosicionDestino = @PosicionNueva AND d.EstaPendiente = 0
   IF @IDAplica IS NOT NULL
   BEGIN
     UPDATE TMAD 
        SET EstaPendiente = 1
      WHERE ID = @IDAplica AND Tarima = @Tarima AND Almacen = @Almacen AND Posicion = @PosicionAnterior AND PosicionDestino = @PosicionNueva AND EstaPendiente = 0
     IF EXISTS(SELECT * FROM TMAD WHERE ID = @IDAplica AND EstaPendiente = 1)
       UPDATE TMA SET Estatus = 'PENDIENTE' WHERE ID = @IDAplica
    END
  END
  RETURN
END
GO

/**************** spTMAAcomodar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTMAAcomodar') and type = 'P') drop procedure dbo.spTMAAcomodar
GO
CREATE PROCEDURE spTMAAcomodar
    		    @ID			int,
		    @Accion		varchar(20),
    		    @Empresa		varchar(5),
		    @Usuario		varchar(10),
    		    @Modulo	      	varchar(5),
    		    @Mov	  	varchar(20),
    		    @MovID             	varchar(20),
    		    @MovTipo     	varchar(20),
    		    @FechaEmision      	datetime,
    		    @FechaRegistro    	datetime,

		    @TarimaNueva	varchar(20),
		    @Almacen		varchar(10),
		    @PosicionAnterior	varchar(10),
		    @PosicionNueva	varchar(10),                    

		    @Ok			int		OUTPUT,
		    @OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
DECLARE
  @Brincar			bit,
  @TarimaAnterior		varchar(20),
  @TarimaAnteriorEstatus	varchar(20)

  
  DECLARE crTMAAcomodar CURSOR LOCAL FOR 
   SELECT Tarima, Estatus
     FROM Tarima
    WHERE Posicion = @PosicionNueva AND Almacen = @Almacen AND Estatus <> 'BAJA'
  OPEN crTMAAcomodar
  FETCH NEXT FROM crTMAAcomodar INTO @TarimaAnterior, @TarimaAnteriorEstatus
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND dbo.fnTarimaEstaVacia(@Empresa, @TarimaAnterior) = 0
    BEGIN
      SELECT @Brincar = 0
      IF @Accion <> 'CANCELAR' 
      BEGIN
        IF dbo.fnTarimaEstaVacia(@Empresa, @TarimaAnterior) = 1 
          SELECT @Brincar = 1 
        ELSE
        IF dbo.fnTarimaEnPuntoReorden (@Empresa, @Almacen, @TarimaAnterior, dbo.fnArticuloEnTarima(@Empresa, @TarimaAnterior)) = 0
          SELECT @Brincar = 1
      END
      IF @Brincar = 0
        EXEC spTraspasarTarima 'TMA', @ID, @Accion, @Empresa, @Usuario, @Mov, @MovID, @MovTipo, @FechaEmision, @TarimaNueva, @TarimaAnterior, @Ok OUTPUT, @OkRef OUTPUT

      IF @Accion = 'CANCELAR'
        UPDATE Tarima SET Estatus = 'ALTA', Alta = @FechaRegistro WHERE Tarima = @TarimaAnterior
      --REQ12615 WMS ELSE
        --REQ12615 WMS UPDATE Tarima SET Estatus = 'BAJA', Baja = @FechaRegistro WHERE Tarima = @TarimaAnterior
    END
    FETCH NEXT FROM crTMAAcomodar INTO @TarimaAnterior, @TarimaAnteriorEstatus
  END
  CLOSE crTMAAcomodar
  DEALLOCATE crTMAAcomodar

  IF @Accion = 'CANCELAR'
    UPDATE Tarima SET Posicion = @PosicionAnterior WHERE Tarima = @TarimaNueva
  ELSE
    UPDATE Tarima SET Posicion = @PosicionNueva WHERE Tarima = @TarimaNueva

  RETURN
END
GO

--REQ12615 WMS
/**************** fnTMATarimaOriginal ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTMATarimaOriginal') DROP FUNCTION fnTMATarimaOriginal
GO
CREATE FUNCTION fnTMATarimaOriginal (@Tarima varchar(20))
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @LEN	int

  IF @Tarima LIKE '%-%'
  BEGIN
    SELECT @LEN = LEN(@Tarima)
    WHILE SUBSTRING(@Tarima,@LEN,1) <> '-'
      SELECT @LEN = @LEN -1
    SELECT @Tarima = SUBSTRING(@Tarima,1, @LEN-1)
  END
  
  RETURN(@Tarima)
END
GO

--REQ12615 WMS
/**************** fnTMACantidadGenerar ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTMACantidadGenerar') DROP FUNCTION fnTMACantidadGenerar
GO
CREATE FUNCTION fnTMACantidadGenerar (@Empresa varchar(5), @ID int, @Renglon float, @Origen varchar(20), @OrigenID varchar(20), @Base varchar(20), @MovTipo varchar(20), @SubClave varchar(20)) --BUG 14146
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CantidadGenerar	float

  IF @Base = 'PENDIENTE'
  BEGIN
    IF @MovTipo IN ('TMA.OSUR', 'TMA.OPCKTARIMA') --TASK6535
      SELECT @CantidadGenerar = d.CantidadPicking - (SELECT ISNULL(SUM(ISNULL(CantidadPicking,0)),0) FROM TMA t JOIN TMAD d1 ON d1.ID = t.ID WHERE t.Origen = @Origen AND t.OrigenID = @OrigenID AND t.Empresa = @Empresa AND t.Estatus NOT IN ('SINAFECTAR', 'CANCELADO') AND d.Renglon = d1.Renglon)
        FROM TMAD d
       WHERE ID = @ID
         AND EstaPendiente = 1
		 AND Renglon = @Renglon --BUG 14146
    ELSE
      SELECT @CantidadGenerar = d.CantidadPicking
        FROM TMAD d
       WHERE ID = @ID
         AND EstaPendiente = 1
		 AND Renglon = @Renglon --BUG 14146
  END
  ELSE
  IF @SubClave NOT IN ('TMA.OSURP', 'TMA.SURP') AND @MovTipo NOT IN ('TMA.OPCKTARIMA') --TASK6535
    SELECT @CantidadGenerar = d.CantidadPicking
      FROM TMAD d
     WHERE ID = @ID
       AND EstaPendiente = 1
	   AND Renglon = @Renglon --BUG 14146
  ELSE
    SELECT @CantidadGenerar = d.CantidadA
      FROM TMAD d
     WHERE ID = @ID
       AND EstaPendiente = 1
	   AND Renglon = @Renglon --BUG 14146

  RETURN(@CantidadGenerar)
END
GO

--REQ12615 WMS
/**************** spTMAAfectarPosicion *****************/
if exists (select * from sysobjects where id = object_id('dbo.spTMAAfectarPosicion') and type = 'P') drop procedure dbo.spTMAAfectarPosicion
GO
CREATE PROCEDURE spTMAAfectarPosicion
				@ID                	int,

				@Accion				char(20),
				@Base				char(20),
				@Empresa	      	char(5),
				@Modulo	      		char(5),
				@Mov	  	      	char(20),
				@MovID             	varchar(20)	OUTPUT,
				@MovTipo     		char(20),

				@Usuario	      	char(10),
				@Estatus           	char(15),
				@EstatusNuevo	    char(15),

				@Almacen			char(10), 
				@Agente				varchar(10),
				@Tarima				varchar(20),
				@Posicion			varchar(10), 
				@PosicionDestino	varchar(10),
				@Articiulo			varchar(20),

				@Ok                	int          OUTPUT,
				@OkRef             	varchar(255) OUTPUT
		    

--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
	@Tipo								varchar(20),
	@TipoDestino						varchar(20),
    @WMSPermitirReacomodosDomicilio		bit
        
  SELECT @WMSPermitirReacomodosDomicilio = ISNULL(WMSPermitirReacomodosDomicilio,0) FROM EmpresaCfg WHERE Empresa = @Empresa
  SELECT @Tipo = Tipo FROM AlmPos WHERE Posicion = @Posicion AND Almacen = @Almacen
  SELECT @TipoDestino = Tipo FROM AlmPos WHERE Posicion = @PosicionDestino AND Almacen = @Almacen

  IF @Tipo = 'Domicilio' AND @TipoDestino = 'Domicilio' AND @WMSPermitirReacomodosDomicilio = 1
  BEGIN

    UPDATE AlmPos SET ArticuloEsp = '' WHERE Posicion = @Posicion AND Almacen = @Almacen
    UPDATE AlmPos SET ArticuloEsp = @Articiulo WHERE Posicion = @PosicionDestino AND Almacen = @Almacen
    
    UPDATE TMAD SET TMAD.PosicionDestino = @PosicionDestino
      FROM TMAD JOIN TMA ON TMAD.ID = TMA.ID
        JOIN MovTipo
        ON TMA.Mov = MovTipo.Mov AND MovTipo.Modulo = 'TMA'
     WHERE TMA.Estatus = 'PENDIENTE'
       AND TMAD.PosicionDestino = @Posicion
       AND MovTipo.Clave IN('TMA.SADO', 'TMA.SRADO')

    UPDATE TMAD SET TMAD.Posicion = @PosicionDestino
      FROM TMAD JOIN TMA ON TMAD.ID = TMA.ID
        JOIN MovTipo
        ON TMA.Mov = MovTipo.Mov AND MovTipo.Modulo = 'TMA'
     WHERE TMA.Estatus = 'PENDIENTE'
       AND TMAD.Posicion = @Posicion
       AND MovTipo.Clave = 'TMA.OSUR'
       AND MovTipo.SubClave = 'TMA.OSURP'    
  END
  RETURN
END
GO
--BUG24697
/**************** spTMAReacomodoSolicitar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTMAReacomodoSolicitar') and type = 'P') drop procedure dbo.spTMAReacomodoSolicitar
GO
CREATE PROCEDURE spTMAReacomodoSolicitar
    		   @ID                	int,
			   @Estacion			int,
			   @IDOrigen			int,
		       @Accion				char(20),
    		   @Empresa	      		char(5),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             	varchar(20)	OUTPUT,
    		   @MovTipo     		char(20),
		       @MovMoneda			char(10),
		       @MovTipoCambio		float,
    		   @FechaEmision      	datetime,
    		   @FechaAfectacion     datetime,
    		   @FechaConclusion		datetime,
    	 	   @Proyecto	      	varchar(50),
    		   @Usuario	      		char(10),
    		   @Autorizacion      	char(10),
    		   @DocFuente	      	int,
    		   @Observaciones     	varchar(255),
    		   @Concepto     		varchar(50),
		       @Referencia			varchar(50),
    		   @Estatus           	char(15),
 	    	   @EstatusNuevo	    char(15),
    		   @FechaRegistro     	datetime,
    		   @Ejercicio	      	int,
    		   @Periodo	      		int,
		       @MovUsuario			char(10),
               @Sucursal			int,
               @SucursalDestino		int,
               @SucursalOrigen		int,
       		   @Ok                	int				OUTPUT,
    		   @OkRef             	varchar(255)	OUTPUT,
			   @TarimaEsp			varchar(20)		= NULL,
			   @PosicionEsp			varchar(10)		= NULL,
               @ArticuloEsp			varchar(20)		= NULL,
               @IDDestino		    int             = NULL OUTPUT,
               @SucursalFiltro		int             = NULL
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE @Articulo			varchar(20),
		  @Almacen			varchar(10),
		  @Ordenes			float,
		  @CantidadTarima	float,
		  @Disponible		float,
		  @Contador			bit,
		  @Tipo             varchar(20),
		  @Resultado        float,
		  @Unidad			varchar(50),
		  @MinimoTarima     float,
		  @Tarima           varchar(20),
		  @CantidadUnidad   float,
          @DisponibleTarima	float,
          @PosicionOrigen   varchar(10),       
	      @PosicionDestino  varchar(10),
		  @ControlArticulo  varchar(20),
		  @TarimasReacomodar int,
		  @TarimaSurtido	varchar(20),  
		  @Renglon          float,          --@IDDestino		int,
		  @Reacomodar		int, 
		  @TarimaN			varchar(20),
          @MovDestino       varchar(20),
          @MovDestinoID     varchar(20),
          @AlmacenCursor	varchar(10),    
          @Prioridad		varchar(10),    --BUG24261
          @SubCuenta        varchar(50)     --BUG3319 --TASK2429PGC

  DECLARE @TarimaDisp TABLE(Tarima varchar(20))      

  IF @Accion = 'AFECTAR'
  BEGIN
    SELECT @AlmacenCursor = Almacen FROM TMA WHERE ID = @ID
    
    --BUG24261
    IF @ArticuloEsp IS NULL
      SELECT @Prioridad = 'Media'
    ELSE
      SELECT @Prioridad = 'Alta'
    
    DECLARE crDisponible CURSOR LOCAL STATIC FOR      
     SELECT a.Articulo, d.Almacen, ap.Tipo, /*SUM(d.CantidadPicking)*/0 Cantidad, d.Unidad, d.CantidadUnidad, d.SubCuenta --REQ 14684 --BUG3319 --TASK2429PGC
       FROM TMAD d
       JOIN TMA t ON d.ID = t.ID
       JOIN ArtDisponibleTarima a ON d.Tarima = a.Tarima AND d.Almacen = a.Almacen AND t.Empresa = a.Empresa
       JOIN Tarima ta ON ta.Tarima = a.Tarima
       JOIN AlmPos ap ON ta.Almacen = ap.Almacen AND ta.Posicion = ap.Posicion AND a.Articulo = ap.ArticuloEsp   
      WHERE d.ID = @IDOrigen
        AND Tipo = 'Domicilio' 
        AND a.Articulo = ISNULL(@ArticuloEsp, a.Articulo)
        AND a.Tarima = ISNULL(@TarimaEsp, a.Tarima)
        AND ap.Posicion = ISNULL(@PosicionEsp, ap.Posicion)
        AND a.Empresa = @Empresa
        AND ap.Almacen = @AlmacenCursor
      GROUP BY a.Articulo, d.Almacen, ap.Tipo, d.Unidad, d.CantidadUnidad, d.SubCuenta --BUG3319 --TASK2429PGC 
              
    OPEN crDisponible      
    FETCH NEXT FROM crDisponible INTO @Articulo, @Almacen, @Tipo, @CantidadTarima, @Unidad, @CantidadUnidad, @SubCuenta --REQ 14684 --BUG3319 --TASK2429PGC
    WHILE @@FETCH_STATUS = 0      
    BEGIN    
      SELECT @Ordenes = 0
      --EWQ. Inicio Tuning. Solo SSFA
      DECLARE crMinimo CURSOR LOCAL FOR
	  --BUG24913
       SELECT SUM(d.Disponible) Disponible, ISNULL(a.MinimoTarima, 0),          
              CASE @ArticuloEsp WHEN NULL THEN SUM(d.Disponible) - @CantidadTarima - @Ordenes ELSE 0 END Resultado  
         FROM ArtDisponibleTarima d   
         JOIN Tarima t ON d.Tarima = t.Tarima  
         JOIN AlmPos p ON t.Almacen = p.Almacen AND p.Posicion = t.Posicion AND p.ArticuloEsp = d.Articulo  
         JOIN Art a ON d.Articulo = a.Articulo           
        WHERE p.Tipo = @Tipo  
          AND d.Articulo = @Articulo  
          AND t.Estatus = 'ALTA'  
          AND p.Estatus = 'ALTA'
          --AND a.Articulo = ISNULL(@ArticuloEsp, a.Articulo)
          --AND t.Tarima = ISNULL(@TarimaEsp, t.Tarima)
          --AND p.Posicion = ISNULL(@PosicionEsp, p.Posicion)
		--BUG24913
        GROUP BY d.Articulo, ISNULL(a.MinimoTarima, 0)         
      OPEN crMinimo  
      FETCH NEXT FROM crMinimo INTO @Disponible, @MinimoTarima, @Resultado  
      WHILE @@FETCH_STATUS = 0  
      BEGIN
        SELECT @Contador = 0

        IF @Resultado < @MinimoTarima  
        BEGIN  
          SELECT @Tarima = NULL, @DisponibleTarima = NULL, @PosicionOrigen = NULL  
          SELECT @ControlArticulo = ControlArticulo FROM Art WHERE Articulo = @Articulo  

		  --IF @SubCuenta IS NULL --TASK2429PGC
    --       EXEC spTMAExplocionTarima @Almacen, @Articulo, NULL, @ControlArticulo, NULL, @Estacion, @Tarima OUTPUT, @Disponible OUTPUT, @PosicionOrigen OUTPUT  
    --      ELSE
    --       EXEC spTMAExplocionTarimaOpcion @Almacen, @Articulo, @SubCuenta, NULL, @ControlArticulo, NULL, @Estacion, @Tarima OUTPUT, @Disponible OUTPUT, NULL --TASK2429PGC         

          SELECT TOP 1 @PosicionDestino = Posicion FROM AlmPos WHERE ArticuloEsp = @Articulo AND Tipo = @Tipo AND Almacen = @Almacen  

          IF @Contador = 0  
            SELECT @Resultado = @Resultado + ISNULL(SUM(ISNULL(a.Disponible,0)),0)  
              FROM TMA t   
              JOIN TMAD d on t.id = d.id   
              JOIN ArtDisponibleTarima a ON d.Tarima = a.Tarima AND a.Articulo = @Articulo AND a.Almacen = @Almacen 
              JOIN MovTipo m ON m.Mov = t.Mov AND m.Modulo = 'TMA'  
             WHERE m.Clave = 'TMA.SRADO'
               AND t.Estatus = 'PENDIENTE'
               AND d.PosicionDestino = @PosicionDestino 
               AND a.Empresa = @Empresa   
         
          IF @Resultado < @MinimoTarima
          BEGIN
            SELECT @Mov = TMASolicitudReacomodo FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa
            SELECT @TarimasReacomodar = ISNULL(TarimasReacomodar,0) FROM Art WHERE Articulo = @Articulo

            IF ISNULL(@TarimasReacomodar,0) = 0
              SET @TarimasReacomodar = 1

            --EWQ. Tuning
            --BUG24261 BUG24305
            INSERT TMA (Empresa,  Sucursal,  Usuario,  Mov,  FechaEmision,  Estatus,      Almacen,  TarimaSurtido,  Prioridad, Referencia,               Observaciones,                                                                                    SucursalFiltro,  SucursalDestino)  
            VALUES     (@Empresa, @Sucursal, @Usuario, @Mov, @FechaEmision, 'SINAFECTAR', @Almacen, @TarimaSurtido, @Prioridad, 'Herramienta de Surtido', CASE @ArticuloEsp WHEN NULL THEN NULL ELSE 'Patinero - Domicilio con Existencia Incorrecta' END, @SucursalFiltro, @SucursalDestino)

            SET @IDDestino = @@IDENTITY  
            SET @Renglon = 2048  
            SET @Reacomodar = 1

            IF @Reacomodar <= @TarimasReacomodar --REQ 19255
            BEGIN
                SELECT TOP 1 
                       @Tarima		   = A.Tarima,
	                   @Disponible	   = A.Disponible - ISNULL(D.Apartado,0),
                       @PosicionOrigen = B.Posicion
                  FROM ArtDisponibleTarima A
                  JOIN Tarima B ON A.Tarima = B.Tarima  
                  JOIN AlmPos C ON B.Almacen = C.Almacen AND ISNULL(B.Posicion,C.Posicion) = C.Posicion AND C.Tipo <> 'Surtido'
             LEFT JOIN ArtApartadoTarima D ON A.Empresa = D.Empresa AND A.Articulo = D.Articulo AND A.Almacen = D.Almacen AND A.Tarima = D.Tarima
                 WHERE A.Articulo = @Articulo
                   AND A.Tarima NOT IN (SELECT Tarima
                                         FROM WMSSurtidoProcesarD       
                                        WHERE Estacion = @Estacion 
                                          AND Procesado = 1   
                                          AND Articulo IN (SELECT DISTINCT Clave FROM ListaSt WHERE Estacion = @Estacion)      
                                          AND (PosicionDestino IS NOT NULL AND PosicionDestino <> '') 
                                          AND NULLIF(SubCuenta,'') IS NULL
                                          AND Tarima NOT IN (SELECT Tarima FROM @TarimaDisp)                           
                                     )
				   AND A.Tarima NOT IN (SELECT DISTINCT d.Tarima FROM TMA t
												   JOIN TMAD d ON t.ID = d.ID
												   JOIN MovTipo m ON t.Mov = m.Mov AND m.Modulo = 'TMA'
												  WHERE t.Estatus IN ('PENDIENTE', 'PROCESAR')
												    AND m.Clave NOT IN ('TMA.OADO', 'TMA.ORADO', 'TMA.SADO', 'TMA.SRADO', 'TMA.ADO', 'TMA.RADO')
                                        )                 
                   AND C.Tipo = 'Ubicacion'
                   AND A.Almacen = @Almacen
                   AND A.Disponible - ISNULL(D.Apartado,0) > 0
                   AND B.Estatus = 'ALTA'
				   AND A.Empresa = @Empresa
              ORDER BY B.FechaCaducidad, CASE @ControlArticulo 
                                         WHEN 'Caducidad'		THEN CONVERT(varchar, B.FechaCaducidad)
                                         WHEN 'Fecha Entrada'	THEN CONVERT(varchar, B.Alta)
                                         ELSE B.Posicion
		  	                             END, A.Tarima ASC  

                 INSERT @TarimaDisp (Tarima) VALUES (@Tarima)

              IF @Tarima IS NOT NULL AND @Ok IS NULL
              BEGIN
                  INSERT TMAD (ID,         Sucursal,  Renglon,  Tarima,                   Almacen,  Posicion,        PosicionDestino,  CantidadPicking,  Prioridad,  EstaPendiente, Procesado, Unidad,  CantidadUnidad, Articulo, SubCuenta) --REQ 14684 --BUG3319 --TASK2429PGC
                  SELECT       @IDDestino, @Sucursal, @Renglon, ISNULL(@TarimaN,@Tarima), @Almacen, @PosicionOrigen, @PosicionDestino, @Disponible,     @Prioridad,  1,             0,         @Unidad, @Disponible,    @Articulo, @SubCuenta --REQ 14684 --BUG3319 --TASK2429PGC
                  SET @Renglon = @Renglon + 2048                      
              END
              SET @Reacomodar = ISNULL(@Reacomodar,0) + 1
            END
            --END

            IF @Ok IS NULL AND @IDDestino IS NOT NULL AND EXISTS (SELECT * FROM TMAD WHERE ID = @IDDestino) AND @Tarima IS NOT NULL  
            BEGIN 
              EXEC spAfectar 'TMA', @IDDestino, 'Afectar', @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT      

              SELECT @MovDestino = Mov, @MovDestinoID = MovID FROM TMA WHERE ID = @IDDestino  
              EXEC spMovFlujo @Sucursal, Afectar, @Empresa, 'TMA', @ID, @Mov, @MovID, 'TMA', @IDDestino, @MovDestino, @MovDestinoID, @Ok OUTPUT  
            END          
            ELSE                      
              DELETE TMA WHERE ID = @IDDestino  

            SELECT @Resultado = @Resultado + ISNULL(@DisponibleTarima,0)  
            SELECT @Contador = 1                
          END  
                        
          IF @Tarima IS NULL  
            SELECT @Resultado = @MinimoTarima  
        END    
         
        FETCH NEXT FROM crMinimo INTO @Disponible, @MinimoTarima, @Resultado  
      END  
      CLOSE crMinimo  
      DEALLOCATE crMinimo       
      --EWQ. Fin Tuning. Solo SSFA                          
      
      FETCH NEXT FROM crDisponible INTO @Articulo, @Almacen, @Tipo, @CantidadTarima, @Unidad, @CantidadUnidad, @SubCuenta --REQ 14684 --BUG3319 --TASK2429PGC
    END      
    CLOSE crDisponible      
    DEALLOCATE crDisponible
  END
  RETURN
END
GO

--TASK25168
/**************** spTMAReEntarimar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTMAReEntarimar') and type = 'P') drop procedure dbo.spTMAReEntarimar
GO             
CREATE PROC spTMAReEntarimar
    		@ID					int,
            @Mov				varchar(20),
            @MovID				varchar(20),
            @Usuario			varchar(10),
		    @Accion				char(20),
    		@Empresa			char(5),
            @Sucursal			int,
		    @Tarima				varchar(20),
		    @Almacen			varchar(10),
		    @PosicionAnterior	varchar(10),
		    @PosicionNueva		varchar(10),
            @Cantidad			float,
		    @Unidad				varchar(20),
		    @CantidadPicking	float,
		    @Ok					int				OUTPUT,
		    @OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @FechaEmision		datetime,
		  @MovAjuste		varchar(20),
          @InvID			int,
          @OrdenID			int,
          @InvMov			varchar(20),
          @OrdenMov			varchar(20),
          @InvMovID			varchar(20),
          @Moneda			varchar(10),
		  @Articulo			varchar(20),
          @RenglonTipo		varchar(1),
          @Factor			float,
          @Costo			float,
		  @DefPosicionRecibo varchar(10),
		  @ArticuloCaducidad  varchar(20),
		  @FechaCaducidad     datetime --BUG24989

  SELECT @DefPosicionRecibo = DefPosicionRecibo FROM Alm WHERE Almacen = @Almacen

  SELECT @MovAjuste = Mov FROM MovTipo WHERE Modulo = 'INV' AND Clave = 'INV.A' AND SubClave = 'INV.ATMAORENT'
  SELECT @OrdenMov = InvOrdenEntarimado FROM EmpresaCfgMov WHERE Empresa = @Empresa
  
  IF @Accion = 'AFECTAR'
  BEGIN
    SELECT @FechaEmision = GETDATE()

    EXEC spExtraerFecha @FechaEmision OUTPUT

    SELECT @Moneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa

    EXEC spRenglonTipo @Articulo, '', @RenglonTipo OUTPUT

    SELECT @Articulo = Articulo FROM ArtDisponibleTarima WHERE Tarima = @Tarima AND Almacen = @Almacen

    SELECT @Factor = dbo.fnArtUnidadFactor(@Empresa, @Articulo, @Unidad)

    SELECT @Costo = ISNULL(CostoPromedio,0.0) FROM ArtCosto WHERE Articulo = @Articulo AND Sucursal = @Sucursal AND Empresa = @Empresa

	--BUG24989
	SELECT @FechaCaducidad=FechaCaducidad 
	 FROM TMAD
    WHERE ID = @ID


    INSERT INTO Inv(
			Empresa,  Mov,        FechaEmision,  Moneda, TipoCambio,  Usuario, Estatus,      Almacen, OrigenTipo,  Origen,  OrigenID, Sucursal,  PosicionWMS) --TASK25168
	 SELECT Empresa, @MovAjuste, @FechaEmision, @Moneda, 1,          @Usuario, 'SINAFECTAR', Almacen, 'TMA',      @Mov,    @MovID,    Sucursal, @DefPosicionRecibo
       FROM TMA
     WHERE ID = @ID


    SELECT @InvID = SCOPE_IDENTITY()
	

    INSERT INTO InvD(
			 ID,    Renglon, RenglonSub,  RenglonTipo,   Cantidad,  Almacen,  Articulo,  Costo,          Unidad,  Factor,   CantidadInventario,  Tarima)
	 SELECT @InvID, 2048,    0,          @RenglonTipo, -@Cantidad, @Almacen, @Articulo, @Costo*@Factor, @Unidad, @Factor, -@CantidadPicking,    @Tarima

    INSERT INTO InvD(
			 ID,    Renglon, RenglonSub,  RenglonTipo,  Cantidad,  Almacen,  Articulo,  Costo,          Unidad,  Factor,  CantidadInventario, Tarima, FechaCaducidad)  --BUG24989
	 SELECT @InvID, 2048,    1,          @RenglonTipo, @Cantidad, @Almacen, @Articulo, @Costo*@Factor, @Unidad, @Factor, @CantidadPicking,    '', @FechaCaducidad

    EXEC spAfectar 'INV', @InvID, @Accion, @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

    IF @Ok IS NULL
    BEGIN
      SELECT @InvMov = Mov, @InvMovID = MovID FROM Inv WHERE ID = @InvID

      EXEC spMovFlujo @Sucursal, @Accion, @Empresa, 'TMA', @ID, @Mov, @MovID, 'INV', @InvID, @InvMov, @InvMovID, @Ok OUTPUT

      IF @Ok IS NULL
	    --TASK25168 
        EXEC spGenerarOrdenEntarimado 'INV', @InvID, @Accion, @Empresa, @Sucursal, @Usuario, @InvMov, @InvMovID, 'INV.A', @Almacen, @Ok OUTPUT, @OkRef OUTPUT
    END
  END
  ELSE IF @Accion = 'CANCELAR'
  BEGIN
    SELECT @InvID = ID,
           @InvMov = Mov,
           @InvMovID = MovID
      FROM Inv
     WHERE Mov = @MovAjuste
       AND OrigenTipo = 'TMA'
       AND Origen = @Mov
       AND OrigenID = @MovID

    SELECT @OrdenID = ID
      FROM Inv
     WHERE Mov = @OrdenMov
       AND OrigenTipo = 'INV'
       AND Origen = @InvMov
       AND OrigenID = @InvMovID
       AND Estatus NOT IN('CANCELADO')

    IF @OrdenID IS NOT NULL
      EXEC spAfectar 'INV', @OrdenID, @Accion, @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

    IF @Ok IS NULL AND @InvID IS NOT NULL
      EXEC spAfectar 'INV', @InvID, @Accion, @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

    IF @Ok IS NULL 
      EXEC spMovFlujo @Sucursal, @Accion, @Empresa, 'TMA', @ID, @Mov, @MovID, 'INV', @InvID, @InvMov, @InvMovID, @Ok OUTPUT
  END
  RETURN
END
GO
/**************** spTMAAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTMAAfectar') and type = 'P') drop procedure dbo.spTMAAfectar
GO
CREATE PROCEDURE spTMAAfectar
    		   @ID                	int, 
               @Accion				char(20), 
               @Base				char(20),
    		   @Empresa	      		char(5), 
               @Modulo              char(5), 
               @Mov	  	      		char(20),
    		   @MovID             	varchar(20)	OUTPUT, 
               @MovTipo     		char(20),
               @MovMoneda			char(10),
		       @MovTipoCambio		float, 
               @FechaEmision      	datetime, 
               @FechaAfectacion     datetime,
    		   @FechaConclusion		datetime, 
               @Proyecto	      	varchar(50),
               @Usuario	      		char(10),
    		   @Autorizacion      	char(10), 
               @DocFuente	      	int, 
               @Observaciones     	varchar(255),
    		   @Concepto     		varchar(50), 
               @Referencia			varchar(50), 
               @Estatus           	char(15),
 	    	   @EstatusNuevo	    char(15), 
               @FechaRegistro     	datetime, 
               @Ejercicio	      	int,
    		   @Periodo	      		int, 
               @MovUsuario			char(10), 
               @Conexion			bit,
               @SincroFinal			bit, 
               @Sucursal			int, 
               @SucursalDestino		int,
               @SucursalOrigen		int, 
               @CfgContX			bit, 
               @CfgContXGenerar		char(20), 
               @GenerarPoliza		bit,
		       @Generar				bit, 
               @GenerarMov			char(20), 
               @GenerarAfectado		bit,
		       @IDGenerar			int	     	OUTPUT, 
               @GenerarMovID	  	varchar(20)	OUTPUT, 
               @Almacen				char(10), 
		       @Agente				varchar(10), 
               @Ok                	int          OUTPUT, 
               @OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CancelarID			        int,  
    @FechaCancelacion	        datetime,  
    @GenerarMovTipo		        char(20),  
    @GenerarPeriodo		        int,  
    @GenerarEjercicio	        int,   
    @Tarima				        varchar(20), 
    @TarimaEstatus		        char(15),  
    @Posicion			        varchar(10),  
    @PosicionDestino	        varchar(10),  
    @AlmacenDetalle		        varchar(10), 
    @SubClave     		        varchar(20),
    @WMSDispararReaco	        bit,  
    @TarimaSurtido		        varchar(20),  
    @Articulo			        varchar(20),   
    @MovOrigen			        varchar(20), 
    @MovIDOrigen		        varchar(20),
    @IDOrigen			        int, 
    @OrigenTipo			        varchar(5), 
    @OrigenEstatus		        varchar(20),	  
    @CantidadPicking	        float,    
    @TarimaPCK			        varchar(20),  
    @LEN				        int,   
    @TipoPos			        varchar(20),    
    @SucursalAlmacen	        int,    
    @Disponible			        float,   
    @Costo				        money,   
    @ArtMoneda			        char(10),  
	@Artipo				        varchar(50),  
    @Renglon			        int,   
    @TarimaM			        varchar(20),    
    @TarimaOrigen		        varchar(20) ,  
    @SerieLote			        varchar(50),  
    @RenglonID			        int,  
    @CantidadExistencia         float,   
    @Existencia			        float,   
    @CantidadSurtido	        float,  
    @CantidadTransito	        float,   
    @SubTarima			        varchar(20),
    @Tipo                       varchar(20),	
    @CantidadUnidad		        float,  
    @Unidad				        varchar(50), 
    @SubCuenta                  varchar(50),   
    @ArticuloAux                varchar(20), 	--TASK2429PGC
    @SubCuentaAux               varchar(50), 
    @WMSDispararReacomodos	    bit, 
    @WMSReacomodoSurtido        bit, 
    @TarimaReacomodo	        varchar(20), 
    @OTarima			        varchar(20),	--BUG3340
    @Es50				        bit,  
    @Es50TarimaDom		        varchar(20),  
    @Es50Cantidad		        float,  
    @PosicionDomicilio	        varchar(10), 
    @PosicionDestinoAux         varchar(10), --BUG2970
    @TipoPosc                   varchar(30), 
    @Sucursalc				    int, 
    @Almacenc                   varchar(10), 
    @Existe                     float, 
    @Movimiento			        char(20), --TASK6535
	@ModuloOrigen		        varchar(10), 	
    @CantidadOrigenPendiente    float,	 --TASK6535
    @IdO                        int,
	@Disponible2		        float, --CAMBIOS USB
    @Cantidad                   float,
    @CostoPromedio              float,
	@TipoOrigen                 varchar(20),
    @TotalSerie                 float,
    @Necesito                   float,
    @DisponibleA                float,
    @Apartado                   float,
    @CantidadA                  float,
    @CantidadPendiente          float

        DECLARE crArtInvs CURSOR FOR	
          SELECT Articulo, Renglon, CantidadA, CantidadPicking, CantidadPendiente, Tarima, Almacen
            FROM TMAD 
           WHERE ID = @ID
           GROUP BY Articulo, Renglon, CantidadA, CantidadPicking, CantidadPendiente, Tarima, Almacen

	    OPEN crArtInvs
	    FETCH NEXT FROM crArtInvs INTO @Articulo, @Renglon, @CantidadA, @CantidadPicking, @CantidadPendiente, @Tarima, @Almacen
	    WHILE @@FETCH_STATUS = 0 
	    BEGIN	

             SELECT @DisponibleA = Disponible 
               FROM ArtDisponibleTarima 
              WHERE TARIMA   = @Tarima
                AND Articulo = @Articulo
                AND Empresa  = @Empresa
                AND Almacen  = @Almacen

                IF ISNULL(@CantidadA,0) > ISNULL(@DisponibleA,0)
                BEGIN
                   SELECT @Ok = 20020, @OkRef = 'Artículo: ' + @Articulo
                END
                
                IF @MovTipo = 'TMA.OPCKTARIMA'
                    IF ISNULL(@CantidadA,0) > @CantidadPicking
                    BEGIN
                        SELECT @Ok = 20020, @OkRef = 'Artículo: ' + @Articulo
                    END

                IF ISNULL(@CantidadA,0) < 0
                BEGIN
                   SELECT @Ok = 20011, @OkRef = 'Artículo: ' + @Articulo
                END

		    FETCH NEXT FROM crArtInvs INTO @Articulo, @Renglon, @CantidadA, @CantidadPicking, @CantidadPendiente, @Tarima, @Almacen
	    END
	    CLOSE crArtInvs
	    DEALLOCATE crArtInvs

  IF (OBJECT_ID('Tempdb..#TarimaAux')) IS NOT NULL
    DROP TABLE #TarimaAux        
  CREATE TABLE #TarimaAux (Tarima varchar(20) COLLATE Database_Default NOT NULL,  SubTarima varchar(20) COLLATE Database_Default NOT NULL, Cantidad float  NULL, CantidadA float  NULL, )  
  SELECT @SubClave = SubClave FROM MovTipo WHERE Mov = @Mov AND Modulo = @Modulo AND Clave = @MovTipo  
  SELECT @WMSDispararReacomodos = ISNULL(WMSDispararReacomodos,0), @WMSReacomodoSurtido = ISNULL(WMSReacomodoSurtido, 0) FROM EmpresaCfg WHERE Empresa = @Empresa  
  SELECT @TarimaSurtido = TarimaSurtido, @Sucursalc = Sucursal, @Almacenc = Almacen FROM TMA WHERE ID = @ID
  IF @MovTipo IN('TMA.SADO', 'TMA.SRADO', 'TMA.OADO', 'TMA.ORADO', 'TMA.OSUR', 'TMA.OPCKTarima')  AND @Estatus = 'SINAFECTAR' --TASK6535
    SET @EstatusNuevo = 'PENDIENTE'
  ELSE
  IF @MovTipo IN ('TMA.TSUR','TMA.PCKTarimaTran') AND @Estatus = 'SINAFECTAR' AND @SubClave <> 'TMA.TSURP' --TASK6535
    SET @EstatusNuevo = 'PENDIENTE'
  ELSE
  IF @MovTipo = 'TMA.TSUR' AND @Estatus = 'SINAFECTAR' AND @SubClave = 'TMA.TSURP' SET @EstatusNuevo = 'PROCESAR'
  ELSE
  IF @MovTipo IN('TMA.SADO', 'TMA.SRADO', 'TMA.OADO', 'TMA.ORADO', 'TMA.OSUR', 'TMA.TSUR', 'TMA.OPCKTarima', 'TMA.PCKTarimaTran') AND @Estatus = 'PENDIENTE' AND @Accion <> 'CANCELAR' --TASK6535
  BEGIN SET @EstatusNuevo = 'CONCLUIDO' END
  ELSE
  IF @MovTipo IN('TMA.SURPER') AND @Estatus = 'SINAFECTAR' AND @Accion <> 'CANCELAR' SET @EstatusNuevo = 'CONCLUIDO'
  IF @MovTipo IN ('TMA.OSUR','TMA.TSUR','TMA.SRADO','TMA.ORADO','TMA.SADO','TMA.OADO', 'TMA.OPCKTarima', 'TMA.PCKTarimaTran') AND @Estatus <> 'CANCELAR' AND @Accion = 'GENERAR' AND @Base = 'Seleccion'  --TASK6535
    UPDATE TMAD SET EstaPendiente = 1 WHERE ID = @ID AND ISNULL(CantidadA,0) > 0 AND ISNULL(Procesado,0) = 0
  IF @MovTipo IN ('TMA.OSUR','TMA.TSUR','TMA.SRADO','TMA.ORADO','TMA.SADO','TMA.OADO', 'TMA.OPCKTarima', 'TMA.PCKTarimaTran') AND @Estatus <> 'CANCELAR' AND @Accion = 'GENERAR' AND @Base = 'Pendiente'  --TASK6535
    UPDATE TMAD SET EstaPendiente = 1 WHERE ID = @ID AND ISNULL(Procesado,0) = 0
  EXEC spMovConsecutivo @Sucursal, @SucursalOrigen, @SucursalDestino, @Empresa, @Usuario, @Modulo, @Ejercicio, @Periodo, @ID, @Mov, NULL, @Estatus, @Concepto, @Accion, @Conexion, @SincroFinal, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  IF @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') AND @Accion <> 'CANCELAR' AND @Ok IS NULL
    EXEC spMovChecarConsecutivo	@Empresa, @Modulo, @Mov, @MovID, NULL, @Ejercicio, @Periodo, @Ok OUTPUT, @OkRef OUTPUT
  IF @Accion IN ('CONSECUTIVO', 'SINCRO') AND @Ok IS NULL
  BEGIN IF @Accion = 'SINCRO' EXEC spAsignarSucursalEstatus @ID, @Modulo, @SucursalDestino, @Accion  SELECT @Ok = 80060, @OkRef = @MovID  RETURN END
  IF @OK IS NOT NULL RETURN 
  IF @Accion = 'GENERAR' AND @Ok IS NULL
  BEGIN
    EXEC spMovGenerar @Sucursal, @Empresa, @Modulo, @Ejercicio, @Periodo, @Usuario, @FechaRegistro, 'SINAFECTAR', NULL, NULL, @Mov, @MovID, 0, @GenerarMov, NULL, @GenerarMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT	
    EXEC spMovTipo @Modulo, @GenerarMov, @FechaAfectacion, @Empresa, NULL, NULL, @GenerarMovTipo OUTPUT, @GenerarPeriodo OUTPUT, @GenerarEjercicio OUTPUT, @Ok OUTPUT
   --IF @Ok IS NULL AND @MovTipo NOT IN ('TMA.OSUR', 'TMA.SUR',  'TMA.OPCKTarima', 'TMA.PCKTarima') AND @SubClave NOT IN ('TMA.OSURP', 'TMA.SURP') AND (SELECT COUNT(0) FROM TMAD WHERE ID = @ID AND ISNULL(CantidadA,0) > 1)>0 --TASK6535
   --  SELECT @Ok = 20160
    IF @Base = 'PENDIENTE'
      DECLARE crSubTarima CURSOR LOCAL FOR SELECT Renglon, Tarima, PosicionDestino FROM TMAD d WHERE ID = @ID AND EstaPendiente = 1
    ELSE
      DECLARE crSubTarima CURSOR LOCAL FOR SELECT Renglon, Tarima, PosicionDestino FROM TMAD WHERE ID = @ID AND ISNULL(CantidadA,0) > 0              
    OPEN crSubTarima
    FETCH NEXT FROM crSubTarima INTO @Renglon, @Tarima, @PosicionDestinoAux --BUG2970
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN  
      SELECT @SubTarima = CASE WHEN @GenerarMovTipo <> 'TMA.SURPER' THEN dbo.fnRegresaSubTarima(@Tarima, @MovTipo) ELSE @Tarima END
	  --IF @GenerarMovTipo='TMA.PCKTARIMATRAN' SELECT @SubTarima = dbo.fnRegresaSubTarimaPCKTarima(@Tarima, @MovTipo) --TASK6535
	  IF @MovTipo NOT IN ('TMA.SRADO', 'TMA.ORADO', 'TMA.RADO')-- CAMBIOS USB
	  BEGIN
		  IF NOT EXISTS(SELECT * FROM #TarimaAux WHERE Tarima = @Tarima)
			INSERT #TarimaAux SELECT @Tarima, @SubTarima, NULL, NULL --BUG3340 24082015
		  ELSE
		  BEGIN
			SET @Len = LEN(@SubTarima)    
			SELECT @SubTarima = SUBSTRING(@SubTarima, 1, CHARINDEX('-',@SubTarima)) + CONVERT(varchar(10),SUBSTRING(@SubTarima, @Len, @Len - CHARINDEX('-',@SubTarima)) + 1)
			UPDATE #TarimaAux SET SubTarima = @SubTarima WHERE Tarima = @Tarima 
		  END
	  END
      IF @Base = 'PENDIENTE'
      BEGIN
       IF @PosicionDestinoAux IS NOT NULL --AND @MovTipo='TMA.SADO' --BUG2970 08092015
       BEGIN
        INSERT TMAD (ID,         Renglon,   Tarima,     Almacen,   Posicion,   PosicionDestino,   EstaPendiente,   Sucursal,   SucursalOrigen,   Zona,   CantidadPicking,                                                                            CantidadA, Aplica, AplicaID, AplicaRenglon, Prioridad,   Montacarga,   Procesado, Unidad,   CantidadUnidad, Articulo, SubCuenta, FechaCaducidad, ArtCambioClave) --REQ 14684 --TASK2429PGC --BUG3786
        SELECT       @IDGenerar, d.Renglon, @SubTarima, d.Almacen, d.Posicion, d.PosicionDestino, d.EstaPendiente, d.Sucursal, d.SucursalOrigen, d.Zona, dbo.fnTMACantidadGenerar(@Empresa, @ID, Renglon, @Mov, @MovID, @Base, @MovTipo, @SubClave), 0,         @Mov,   @MovID,   d.Renglon,     d.Prioridad, d.Montacarga, 0,         d.Unidad, d.CantidadUnidad, d.Articulo, d.SubCuenta, d.FechaCaducidad, d.ArtCambioClave  --BUG 14146 --REQ 14684 --TASK2429PGC --BUG3786
          FROM TMAD d
         WHERE ID = @ID AND EstaPendiente = 1 AND d.Renglon = @Renglon
         
		 IF NOT EXISTS(SELECT * FROM SerieLoteMov WHERE Modulo = @Modulo AND ID = @IDGenerar)       
			EXEC spMovCopiarSerielote @Sucursal, @Modulo, @ID, @IDGenerar --1
       END
		 IF @PosicionDestinoAux IS NULL AND @MovTipo<>'TMA.SADO' --BUG2970 08092015
         BEGIN
           INSERT TMAD (ID,         Renglon,   Tarima,     Almacen,   Posicion,   PosicionDestino,   EstaPendiente,   Sucursal,   SucursalOrigen,   Zona,   CantidadPicking,                                                                            CantidadA, Aplica, AplicaID, AplicaRenglon, Prioridad,   Montacarga,   Procesado, Unidad,   CantidadUnidad, Articulo, SubCuenta, FechaCaducidad, ArtCambioClave ) --REQ 14684 --TASK2429PGC --BUG3786
           SELECT       @IDGenerar, d.Renglon, @SubTarima, d.Almacen, d.Posicion, d.PosicionDestino, d.EstaPendiente, d.Sucursal, d.SucursalOrigen, d.Zona, dbo.fnTMACantidadGenerar(@Empresa, @ID, Renglon, @Mov, @MovID, @Base, @MovTipo, @SubClave), 0,         @Mov,   @MovID,   d.Renglon,     d.Prioridad, d.Montacarga, 0,         d.Unidad, d.CantidadUnidad, d.Articulo, d.SubCuenta, d.FechaCaducidad, d.ArtCambioClave  --BUG 14146 --REQ 14684 --TASK2429PGC --BUG3786
            FROM TMAD d WHERE ID = @ID AND EstaPendiente = 1 AND d.Renglon = @Renglon
			IF NOT EXISTS(SELECT * FROM SerieLoteMov WHERE Modulo = @Modulo AND ID = @IDGenerar)       
				EXEC spMovCopiarSerielote @Sucursal, @Modulo, @ID, @IDGenerar  --2
         END
        DELETE TMAD WHERE ID = @IDGenerar AND CantidadPicking = 0 AND Renglon = @Renglon
        UPDATE TMAD SET CantidadA = 0 WHERE ID = @ID AND EstaPendiente = 1 AND Renglon = @Renglon
      END ELSE
      BEGIN
	   IF @PosicionDestinoAux IS NOT NULL --AND @MovTipo='TMA.SADO' --BUG2970 08092015
       BEGIN
        INSERT TMAD (Sucursal,  ID,         Renglon, Tarima,	    Almacen, Posicion, PosicionDestino, Zona, CantidadPicking,                                                                      Procesado, Aplica, AplicaID, AplicaRenglon, AplicaRenglonID, Prioridad, Montacarga, EstaPendiente, Unidad, CantidadUnidad, Articulo, SubCuenta, FechaCaducidad, ArtCambioClave ) --REQ 14684 --TASK2429PGC --BUG3786
        SELECT       @Sucursal, @IDGenerar, Renglon, @SubTarima, Almacen, Posicion, PosicionDestino, Zona, dbo.fnTMACantidadGenerar(@Empresa, @ID, Renglon, '', '', @Base, @MovTipo, @SubClave), 0,         @Mov,   @MovID,   Renglon,       1,			   Prioridad, Montacarga, 1,             Unidad, NULL, Articulo, SubCuenta, FechaCaducidad, ArtCambioClave  --BUG 14146 --REQ 14684 --TASK2429PGC --BUG3786
          FROM TMAD  WHERE ID = @ID AND ISNULL(CantidadA,0) > 0 AND Renglon = @Renglon
		
		IF NOT EXISTS(SELECT * FROM SerieLoteMov WHERE Modulo = @Modulo AND ID = @IDGenerar)              
			EXEC spMovCopiarSerielote @Sucursal, @Modulo, @ID, @IDGenerar
       END
          IF @PosicionDestinoAux IS NULL AND @MovTipo<>'TMA.SADO' --BUG2970
          BEGIN
            INSERT TMAD (Sucursal,  ID,         Renglon, Tarima,	    Almacen, Posicion, PosicionDestino, Zona, CantidadPicking,                                                                      Procesado, Aplica, AplicaID, AplicaRenglon, AplicaRenglonID, Prioridad, Montacarga, EstaPendiente, Unidad, CantidadUnidad, Articulo, SubCuenta, FechaCaducidad, ArtCambioClave ) --REQ 14684 --TASK2429PGC --BUG3786
            SELECT       @Sucursal, @IDGenerar, Renglon, @SubTarima, Almacen, Posicion, PosicionDestino, Zona, dbo.fnTMACantidadGenerar(@Empresa, @ID, Renglon, '', '', @Base, @MovTipo, @SubClave), 0,         @Mov,   @MovID,   Renglon,       1,			   Prioridad, Montacarga, 1,             Unidad, NULL, Articulo, SubCuenta, FechaCaducidad, ArtCambioClave --BUG 14146 --REQ 14684 --TASK2429PGC --BUG3786
             FROM TMAD WHERE ID = @ID AND ISNULL(CantidadA,0) > 0 AND Renglon = @Renglon   
			
			IF NOT EXISTS(SELECT * FROM SerieLoteMov WHERE Modulo = @Modulo AND ID = @IDGenerar)                    
				EXEC spMovCopiarSerielote @Sucursal, @Modulo, @ID, @IDGenerar          
          END
        IF @MovTipo IN('TMA.ORADO','TMA.SRADO')
          UPDATE TMAD SET Procesado = 1, CantidadA = 0 WHERE ID = @ID AND ISNULL(CantidadA,0) = (CASE @Base WHEN 'PENDIENTE' THEN ISNULL(CantidadA,0) ELSE 1 END) AND ISNULL(Procesado,0) = 0
      END
      FETCH NEXT FROM crSubTarima INTO @Renglon, @Tarima, @PosicionDestinoAux --BUG2970
    END
    CLOSE crSubTarima
    DEALLOCATE crSubTarima
    DECLARE crTarimaAlta CURSOR LOCAL FOR
     SELECT Tarima, Almacen, Posicion, Articulo, SubCuenta --TASK2429PGC
       FROM TMAD WHERE ID = @IDGenerar AND @GenerarMovTipo = 'TMA.SURPER'
    OPEN crTarimaAlta
    FETCH NEXT FROM crTarimaAlta INTO @Tarima, @Almacen, @Posicion, @ArticuloAux, @SubCuentaAux --TASK2429PGC
    WHILE @@FETCH_STATUS = 0
    BEGIN      
	  IF @Tarima IS NOT NULL AND NOT EXISTS(SELECT * FROM Tarima WHERE Tarima = @Tarima) AND NOT EXISTS(SELECT * FROM SaldoUWMS WHERE SubGrupo = @Tarima) --TASK2429PGC
      BEGIN
        INSERT Tarima (Tarima,   Almacen,   Posicion,   Estatus, Alta,            Articulo, SubCuenta) --TASK2429PGC
        VALUES (       @Tarima, @Almacen, @Posicion, 'ALTA',  @FechaRegistro, @ArticuloAux, @SubCuentaAux)  --TASK2429PGC
		INSERT SaldoUWMS (Sucursal,  Empresa,  Rama,  Moneda, Grupo,     SubGrupo, Cuenta,     SubCuenta, Saldo, SaldoU, PorConciliar, PorConciliarU, UltimoCambio) --BUG2513         
		  VALUES (       @Sucursal, @Empresa, 'INV',     '',   @Almacen,   @Tarima, @ArticuloAux, @SubCuentaAux,	      0,	  0,      0,            0,       @FechaRegistro) --TASK2429PGC
      END
      FETCH NEXT FROM crTarimaAlta INTO @Tarima, @Almacen, @Posicion, @ArticuloAux, @SubCuentaAux --TASK2429PGC
    END
    CLOSE crTarimaAlta
    DEALLOCATE crTarimaAlta    
    IF @Ok IS NULL SELECT @Ok = 80030
    IF @MovTipo IN ('TMA.TSUR', 'TMA.ORADO', 'TMA.OADO', 'TMA.PCKTarimaTran') AND @Ok BETWEEN 80000 AND 81000 --TASK6535
    BEGIN
      SELECT @MovOrigen = Origen, @MovIDOrigen = OrigenID FROM TMA WHERE ID = @ID AND OrigenTipo = 'TMA'
      SELECT @IDOrigen = ID FROM TMA WHERE Mov = @MovOrigen AND MovID = @MovIDOrigen AND Empresa = @Empresa
      SELECT @FechaConclusion  = @FechaEmision  	  
      IF @MovTipo<>'TMA.OADO' AND (SELECT COUNT(0) FROM TMAD WHERE ID = @IDOrigen AND ISNULL(Procesado,0) = 0) = 0 --BUG2970
	    AND NOT EXISTS (SELECT * FROM TMAD WHERE ID = @IDOrigen AND ISNULL(CantidadPendiente, 0) > 0)  --TASK6535
        UPDATE TMA SET FechaConclusion  = @FechaConclusion, FechaCancelacion = @FechaCancelacion, UltimoCambio     = CASE WHEN UltimoCambio IS NULL THEN GETDATE() ELSE UltimoCambio END, Estatus          = @EstatusNuevo, Situacion 		  = CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END WHERE ID = @IDOrigen
      ELSE        
        IF @MovTipo='TMA.OADO' AND (SELECT COUNT(0) FROM TMAD WHERE ID = @IDOrigen AND ISNULL(Procesado,0) = 0 AND EstaPendiente = 1) = 0 --BUG2970 v2
          UPDATE TMA SET FechaConclusion  = @FechaConclusion, FechaCancelacion = @FechaCancelacion, UltimoCambio     = CASE WHEN UltimoCambio IS NULL THEN GETDATE() ELSE UltimoCambio END, Estatus          = @EstatusNuevo, Situacion 		  = CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END WHERE ID = @IDOrigen
      END    
    RETURN
  END
  IF @Conexion = 0   
    BEGIN TRANSACTION  
    EXEC spMovEstatus @Modulo, 'AFECTANDO', @ID, @Generar, @IDGenerar, @GenerarAfectado, @Ok OUTPUT  
    IF @Accion = 'CANCELAR'    
    BEGIN  
	  IF (SELECT COUNT(0) FROM TMA WHERE OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus IN ('PENDIENTE', 'CONCLUIDO')) > 0  
      BEGIN  
        SELECT @CancelarID = ID FROM TMA WHERE OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus IN ('PENDIENTE', 'CONCLUIDO')    
        EXEC spAfectar @Modulo, @CancelarID, 'CANCELAR', @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT  
      END  
      IF (SELECT COUNT(0) FROM TMA WHERE ISNULL(OrigenTipo, @Modulo) <> @Modulo AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID = @ID) > 0  
      BEGIN  
        SELECT @OrigenTipo = OrigenTipo, @MovOrigen = Origen, @MovIDOrigen = OrigenID FROM TMA WHERE ID = @ID    
		IF @OrigenTipo = 'INV'  
		BEGIN  
		  SELECT @CancelarID = ID, @OrigenEstatus = Estatus FROM Inv WHERE Mov = @MovOrigen AND MovID = @MovIDOrigen AND Empresa = @Empresa            
		  IF @OrigenEstatus <> 'CANCELADO'  
            EXEC spAfectar @OrigenTipo, @CancelarID, 'CANCELAR', @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT  
        END  
      END
    END
    IF @Accion <> 'CANCELAR'
      EXEC spRegistrarMovimiento @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @Ejercicio, @Periodo, @FechaRegistro, @FechaEmision, NULL, @Proyecto, @MovMoneda, @MovTipoCambio, @Usuario, @Autorizacion, NULL, @DocFuente, @Observaciones, @Generar, @GenerarMov, @GenerarMovID, @IDGenerar, @Ok OUTPUT
    IF @Accion IN ('AFECTAR', 'CANCELAR')
    BEGIN
      SELECT @MovOrigen = Origen, @MovIDOrigen = OrigenID FROM TMA WHERE ID = @ID AND OrigenTipo = 'TMA'
      SELECT @IDOrigen = ID FROM TMA WHERE Mov = @MovOrigen AND MovID = @MovIDOrigen AND Empresa = @Empresa
	   DECLARE crAfectarTMAD CURSOR LOCAL FOR
        SELECT NULLIF(RTRIM(d.Tarima), ''), NULLIF(RTRIM(d.Almacen), ''), NULLIF(RTRIM(d.Posicion), ''), NULLIF(RTRIM(d.PosicionDestino), ''), t.Estatus, ISNULL(CantidadPicking,0), NULLIF(RTRIM(d.TarimaPCK), ''), --REQ12615 WMS
	           CantidadUnidad, d.Unidad, d.Articulo, d.SubCuenta, ISNULL(Es50, 0), Es50TarimaDom, ISNULL(Es50Cantidad, 0) 
          FROM TMAD d LEFT OUTER JOIN Tarima t ON t.Tarima = d.Tarima WHERE d.ID = @ID 
      OPEN crAfectarTMAD
      FETCH NEXT FROM crAfectarTMAD INTO @Tarima, @AlmacenDetalle, @Posicion, @PosicionDestino, @TarimaEstatus, @CantidadPicking, @TarimaPCK, @CantidadUnidad, @Unidad, @ArticuloAux, @SubCuentaAux, @Es50, @Es50TarimaDom, @Es50Cantidad --BUG3340
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL  
      BEGIN  
        IF @@FETCH_STATUS <> -2   
        BEGIN

         IF @Accion = 'AFECTAR'
          BEGIN
			IF @ArticuloAux IS NOT NULL IF @SubCuentaAux IS NULL 
			  EXEC spTMAArtDomicilioInicializar @Empresa, @AlmacenDetalle, @ArticuloAux, '' --TASK2429PGC
          END

          IF @Accion = 'AFECTAR' AND @Movtipo IN('TMA.SADO', 'TMA.OADO', 'TMA.ADO')
          BEGIN
            IF(SELECT Tipo FROM AlmPos WHERE Almacen = @Almacen AND Posicion = @PosicionDestino) = 'Domicilio'
            BEGIN              
              UPDATE TMAD SET Es50 = 1 WHERE CURRENT OF crAfectarTMAD
              IF @Movtipo  = 'TMA.ADO' SELECT @Es50 = 1
            END
          END

		  IF @MovTipo = 'TMA.ORENT' 
            EXEC spTMAReEntarimar @ID, @Mov, @MovID, @Usuario, @Accion, @Empresa, @Sucursal, @Tarima, @AlmacenDetalle, @Posicion, @PosicionDestino, @CantidadUnidad, @Unidad, @CantidadPicking, @Ok OUTPUT, @OkRef OUTPUT		
          IF @MovTipo = 'TMA.OADO'  
            EXEC spTMAAplicar @ID, @Accion, @Empresa, @Tarima, @AlmacenDetalle, @Posicion, @PosicionDestino, 'TMA.SADO', @Ok OUTPUT, @OkRef OUTPUT                

          IF @MovTipo = 'TMA.ADO'  
          BEGIN 
            EXEC spTMAAplicar @ID, @Accion, @Empresa, @Tarima, @AlmacenDetalle, @Posicion, @PosicionDestino, 'TMA.OADO', @Ok OUTPUT, @OkRef OUTPUT  
			IF @Es50 = 0 EXEC spTMAAcomodar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @FechaEmision, @FechaRegistro, @Tarima, @AlmacenDetalle, @Posicion, @PosicionDestino, @Ok OUTPUT, @OkRef OUTPUT  
          END  

          IF @MovTipo = 'TMA.ORADO' AND @EstatusNuevo = 'PENDIENTE'
          BEGIN  
            SELECT @Tarima = dbo.fnTMATarimaOriginal(@Tarima)
            IF @Base = 'Seleccion'
              UPDATE TMAD SET CantidadA = 0, Procesado = 1 WHERE ID = @IDOrigen AND Tarima = @Tarima AND CantidadA > 0     --BUG7898
            IF @Base IN ('Pendiente','TODO')
              UPDATE TMAD SET CantidadA = 0, Procesado = 1 WHERE ID = @IDOrigen AND Tarima = @Tarima AND EstaPendiente > 0 --BUG7898
          END  

          IF @Es50 = 1 AND @Accion ='AFECTAR' AND @MovTipo = 'TMA.SADO'
          BEGIN
            SELECT @PosicionDomicilio = NULL            
            SELECT @PosicionDomicilio = Posicion FROM AlmPos WHERE Almacen = @Almacen AND ArticuloEsp = @ArticuloAux AND Tipo = 'Domicilio' --TASK2429PGC 
            UPDATE TMAD SET PosicionDestino = @PosicionDomicilio WHERE CURRENT OF crAfectarTMAD
          END

          IF @MovTipo IN ('TMA.SUR','TMA.RADO','TMA.ADO', 'TMA.PCKTarima') AND @EstatusNuevo = 'CONCLUIDO' OR @MovTipo IN ('TMA.TSUR','TMA.PCKTarimaTran') AND @EstatusNuevo = 'PENDIENTE'  --TASK6535
          BEGIN
            IF @MovTipo NOT IN ('TMA.PCKTarima') SELECT @Tarima = dbo.fnTMATarimaOriginal(@Tarima) --TASK6535

			--IF @MovTipo IN ('TMA.PCKTarima') 
			--	BEGIN
			--		SELECT @TarimaSurtido = TarimaSurtido FROM TMA WHERE ID = @ID
			--		SELECT @Existencia = CantidadPicking FROM TMAD WHERE ID = @ID AND Tarima = @Tarima
            --       IF NOT EXISTS(SELECT A.Sucursal, A.Empresa, A.Articulo, A.SubCuenta, A.SerieLote, A.Almacen, B.Tarima, B.CantidadPicking, A.ExistenciaAlterna, A.ExistenciaActivoFijo, A.Propiedades, A.UltimaEntrada, A.UltimaSalida, A.Cliente, A.Localizacion, A.Costo, A.CostoInv, A.CostoPromedio					
			--		  FROM SerieLote A JOIN TMAD B ON A.Tarima = CASE WHEN  CHARINDEX('-',B.Tarima,1) > 0 THEN SUBSTRING(B.Tarima,1,CHARINDEX('-',B.Tarima,1)-1) ELSE B.Tarima END
			--		 WHERE A.Tarima = CASE WHEN CHARINDEX('-',@Tarima,1) > 0 THEN SUBSTRING(@Tarima,1,CHARINDEX('-',@Tarima,1)-1) ELSE @Tarima END
			--		   AND B.ID = @ID AND A.Empresa = @Empresa AND A.Almacen = @Almacen AND A.Sucursal = @Sucursal)
			--		INSERT SerieLote(Sucursal, Empresa, Articulo, SubCuenta, SerieLote, Almacen, Tarima, Existencia, ExistenciaAlterna, ExistenciaActivoFijo, Propiedades, UltimaEntrada, UltimaSalida, Cliente, Localizacion, Costo, CostoInv, CostoPromedio)
			--		SELECT A.Sucursal, A.Empresa, A.Articulo, A.SubCuenta, A.SerieLote, A.Almacen, B.Tarima, B.CantidadPicking, A.ExistenciaAlterna, A.ExistenciaActivoFijo, A.Propiedades, A.UltimaEntrada, A.UltimaSalida, A.Cliente, A.Localizacion, A.Costo, A.CostoInv, A.CostoPromedio					
			--		  FROM SerieLote A JOIN TMAD B ON A.Tarima = CASE WHEN  CHARINDEX('-',B.Tarima,1) > 0 THEN SUBSTRING(B.Tarima,1,CHARINDEX('-',B.Tarima,1)-1) ELSE B.Tarima END
			--		 WHERE A.Tarima = CASE WHEN CHARINDEX('-',@Tarima,1) > 0 THEN SUBSTRING(@Tarima,1,CHARINDEX('-',@Tarima,1)-1) ELSE @Tarima END
			--		   AND B.ID = @ID AND A.Empresa = @Empresa AND A.Almacen = @Almacen AND A.Sucursal = @Sucursal
			--		UPDATE SerieLote SET Existencia = Existencia - @Existencia WHERE Tarima = CASE WHEN CHARINDEX('-',@Tarima,1) > 0 THEN SUBSTRING(@Tarima,1,CHARINDEX('-',@Tarima,1)-1) ELSE @Tarima END AND Empresa = @Empresa AND Almacen = @Almacen AND Sucursal = @Sucursal
			--	END

            UPDATE TMAD SET CantidadA = 0, Procesado = 1 WHERE ID = @IDOrigen AND Tarima = @Tarima  

			IF @MovTipo = 'TMA.ADO' AND @Es50 = 1
            BEGIN
			  SELECT @ArtMoneda = MonedaCosto FROM Art WHERE Articulo = @ArticuloAux --TASK2429PGC
              SELECT @SucursalAlmacen = Sucursal FROM Alm WHERE Almacen = @AlmacenDetalle          
		      SELECT @Disponible = Disponible FROM ArtDisponibleTarima WHERE Tarima = @Tarima AND Empresa = @Empresa AND Almacen = @AlmacenDetalle
              SELECT @Costo = ISNULL(CostoPromedio,0.0) * ISNULL(@Disponible,0) FROM ArtCosto WHERE Articulo = @Articulo AND Sucursal = @Sucursal AND Empresa = @Empresa

              IF  @Accion = 'AFECTAR'
              BEGIN
                SELECT @TarimaSurtido = NULL                

 		        SELECT @TarimaSurtido = MIN(t.Tarima)
                  FROM ArtDisponibleTarima a 
                  JOIN Tarima t ON t.Tarima = a.Tarima 
                  JOIN AlmPos p ON p.Posicion = t.Posicion AND p.Almacen = @AlmacenDetalle 
                 WHERE a.Articulo =  @ArticuloAux --TASK2429PGC  
                   AND p.ArticuloEsp =  @ArticuloAux --TASK2429PGC
				   AND t.SubCuenta = @SubCuentaAux --TASK2429PGC
                   AND p.Tipo = 'Domicilio' 
                   AND t.Estatus = 'ALTA' 
                   AND t.Tarima NOT LIKE '%-%'

                IF @TarimaSurtido IS NULL
 		        SELECT @TarimaSurtido = MIN(t.Tarima)
                  FROM Tarima t 
                  JOIN AlmPos p ON p.Posicion = t.Posicion  AND p.Almacen = @AlmacenDetalle 
                 WHERE t.Articulo =  @ArticuloAux --TASK2429PGC  
                   AND p.ArticuloEsp =  @ArticuloAux --TASK2429PGC
				   AND t.SubCuenta = @SubCuentaAux --TASK2429PGC
                   AND p.Tipo = 'Domicilio' 
                   AND t.Estatus = 'ALTA' 
                   AND t.Tarima NOT LIKE '%-%'

 		        IF @TarimaSurtido IS NULL
 		          SELECT @TarimaSurtido = MIN(t.Tarima)
                    FROM ArtDisponibleTarima a JOIN Tarima t ON t.Tarima = a.Tarima JOIN AlmPos p ON p.Posicion = t.Posicion  AND p.Almacen = @AlmacenDetalle 
                   WHERE a.Articulo =  @ArticuloAux AND p.ArticuloEsp =  @ArticuloAux AND t.SubCuenta = @SubCuentaAux AND p.Tipo = 'Domicilio' AND t.Estatus = 'ALTA' AND t.Tarima NOT LIKE '%-%'

 		        IF @TarimaSurtido IS NULL
 		          SELECT @TarimaSurtido = MIN(t.Tarima)
                    FROM ArtDisponibleTarima a JOIN Tarima t ON t.Tarima = a.Tarima JOIN AlmPos p ON p.Posicion = t.Posicion  AND p.Almacen = @AlmacenDetalle 
                   WHERE a.Articulo =  @ArticuloAux AND p.ArticuloEsp =  @ArticuloAux AND t.SubCuenta = @SubCuentaAux AND p.Tipo = 'Domicilio' AND t.Estatus = 'BAJA' AND t.Tarima NOT LIKE '%-%'

                
                IF @TarimaSurtido IS NULL BEGIN SELECT @Ok = 13016, @OkRef = @Articulo END                
                UPDATE TMAD SET Es50TarimaDom = @TarimaSurtido, Es50Cantidad = @Disponible WHERE CURRENT OF crAfectarTMAD

			   SELECT @Costo = Saldo 
				 FROM SaldoUWMS --BUG5383 PGC27112015
				WHERE Cuenta = @ArticuloAux AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,ISNULL(SubCuenta,'')) AND Grupo = @Almacen AND SubGrupo = @Tarima
               
                IF @Ok IS NULL AND @Tarima IS NOT NULL AND @TarimaSurtido IS NOT NULL
                BEGIN
                  EXEC spSaldo @SucursalAlmacen, @Accion, @Empresa, @Usuario, 'WMS', @ArtMoneda, 1,  @ArticuloAux, @SubCuentaAux, @AlmacenDetalle,NULL, @Modulo, @ID, @Mov, @MovID, 0, 0, @Disponible, 1, @FechaAfectacion, @Ejercicio, @Periodo, @Mov, @MovID, 0, 0, 0, @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @SubGrupo = @Tarima
                  EXEC spSaldo @SucursalAlmacen, @Accion, @Empresa, @Usuario, 'WMS', @ArtMoneda, 1,  @ArticuloAux, @SubCuentaAux, @AlmacenDetalle, NULL, @Modulo, @ID, @Mov, @MovID, 1, 0, @Disponible, 1, @FechaAfectacion, @Ejercicio, @Periodo, @Mov, @MovID, 0, 0, 0, @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @SubGrupo = @TarimaSurtido

                  EXEC spMoverSeriesLotesWMS @Accion, @Tarima, @TarimaSurtido, @Disponible, @Ok OUTPUT, @OkRef OUTPUT
                END

                IF (SELECT ISNULL(a.Disponible,0) FROM ArtDisponibleTarima a JOIN Tarima t ON a.Tarima = t.Tarima WHERE a.Tarima = @Tarima AND t.Estatus = 'ALTA' AND a.Articulo = @ArticuloAux AND a.Empresa=@Empresa) <= 0
                    UPDATE Tarima SET Estatus = 'BAJA', Baja = @FechaRegistro, Alta = NULL WHERE Tarima = @Tarima

				SELECT @TipoPosc = Tipo FROM AlmPos WHERE Posicion = @PosicionDestino

                IF (SELECT Estatus FROM Tarima	WHERE Tarima = @TarimaSurtido) <> 'ALTA' 
                  UPDATE Tarima SET Estatus = 'ALTA', Baja = NULL, Alta = @FechaRegistro WHERE Tarima = @TarimaSurtido
              END
            END

			SELECT @TipoPos = ISNULL(Tipo,'') FROM AlmPos WHERE Posicion = @Posicion AND Almacen = @Almacen

            IF (SELECT Estatus FROM Tarima WHERE Tarima = @Tarima) <> 'ALTA' AND @Es50 = 0 --BUG3340  
              UPDATE Tarima SET Estatus = 'ALTA', Baja = NULL, Alta = @FechaRegistro WHERE Tarima = @Tarima  
            IF @MovTipo NOT IN('TMA.RADO', 'TMA.TSUR', 'TMA.PCKTarimaTran', 'TMA.PCKTARIMA')  AND @Es50 = 0  AND @TipoPos <> 'Cross Docking'--BUG3340   --TASK6535
              UPDATE Tarima SET Posicion = @PosicionDestino, Alta = GETDATE() WHERE Tarima = @Tarima AND Posicion = @Posicion  
            IF @MovTipo IN ('TMA.SUR') AND @SubClave IS NULL AND @Es50 = 0  AND @TipoPos <> 'Cross Docking' --BUG3340  --TASK6535
              UPDATE Tarima SET Posicion = @PosicionDestino, Alta = GETDATE() WHERE Tarima = @Tarima  

          END  
          IF @MovTipo IN ('TMA.SADO', 'TMA.OADO')  
            UPDATE TMAD SET EstaPendiente = 1 WHERE CURRENT OF crAfectarTMAD  
        END 
        IF @MovTipo IN('TMA.OADO', 'TMA.TSUR', 'TMA.PCKTarimaTran') AND @EstatusNuevo <> 'SINAFECTAR'  --TASK6535
        BEGIN  
          SELECT @MovOrigen = Origen, @MovIDOrigen = OrigenID FROM TMA WHERE ID = @ID AND OrigenTipo = 'TMA'  
          SELECT @IDOrigen = ID FROM TMA WHERE Mov = @MovOrigen AND MovID = @MovIDOrigen AND Empresa = @Empresa  
          IF @MovTipo NOT IN ('TMA.TSUR', 'TMA.PCKTarimaTran') --TASK6535
          BEGIN  
            IF CHARINDEX('-',@Tarima) = 0 UPDATE TMAD SET CantidadA = 0, Procesado = 1 WHERE ID = @IDOrigen AND Tarima = @Tarima  
            ELSE  
              UPDATE TMAD SET CantidadA = 0, Procesado = 1 WHERE ID = @IDOrigen AND Tarima = SUBSTRING(@Tarima, 1, CHARINDEX('-', @Tarima)-1)  
            IF (SELECT COUNT(0) FROM TMAD WHERE ID = @IDOrigen AND ISNULL(Procesado,0) = 0) = 0 UPDATE TMA SET Estatus = 'CONCLUIDO' WHERE ID = @IDOrigen  
            EXEC spMovFlujo @Sucursal, @Accion, @Empresa, 'TMA', @IDOrigen, @MovOrigen, @MovIDOrigen, 'TMA', @ID, @Mov, @MovID, @Ok OUTPUT  
          END  
          ELSE  BEGIN  
            IF CHARINDEX('-',@Tarima) = 0  
            BEGIN  
              UPDATE TMAD SET  CantidadA = 0, CantidadPendiente = ISNULL(CantidadPendiente, CantidadPicking) - CantidadA WHERE ID = @IDOrigen AND Tarima = @Tarima  
              UPDATE TMAD SET  Procesado = 1 WHERE ID = @IDOrigen AND Tarima = @Tarima --AND ISNULL(CantidadPendiente,1) = 0  
            END    
            ELSE  BEGIN  
              IF @MovTipo IN ('TMA.TSUR','TMA.PCKTarimaTran') AND @SubClave <> 'TMA.TSURP' OR @MovTipo <> 'TMA.TSUR'   --TASK6535
              BEGIN  
                UPDATE TMAD SET  CantidadA = 0, CantidadPendiente = ISNULL(CantidadPendiente, CantidadPicking) - CantidadA WHERE ID = @IDOrigen AND Tarima = SUBSTRING(@Tarima, 1, CHARINDEX('-', @Tarima)-1)  
                UPDATE TMAD SET  Procesado = 1 WHERE ID = @IDOrigen AND Tarima = SUBSTRING(@Tarima, 1, CHARINDEX('-', @Tarima)-1)-- AND ISNULL(CantidadPendiente,1) = 0  
              END  
            END
            IF (SELECT COUNT(0) FROM TMAD WHERE ID = @IDOrigen AND ISNULL(Procesado,0) = 0) = 0 AND @MovTipo NOT IN ('TMA.TSUR', 'TMA.PCKTarimaTran') OR (SELECT COUNT(0) FROM TMAD WHERE ID = @IDOrigen AND ISNULL(Procesado,0) = 0) = 0 AND @MovTipo IN ('TMA.TSUR', 'TMA.PCKTarimaTran') AND @SubClave <> 'TMA.TSURP'  --TASK6535			  
				UPDATE A SET A.CantidadPendiente = A.CantidadPendiente + B.CantidadPendiente
				  FROM TMAD A
				  JOIN TMAD B ON A.ID = @IDOrigen AND A.Renglon = B.Renglon  AND A.Tarima = B.Tarima AND A.Almacen = B.Almacen AND A.Posicion = B.Posicion AND A.PosicionDestino = B.PosicionDestino AND B.ID = @ID		
			   UPDATE TMA SET Estatus = 'PENDIENTE' WHERE ID = @IDOrigen  --BUG3045
            EXEC spMovFlujo @Sucursal, @Accion, @Empresa, 'TMA', @IDOrigen, @MovOrigen, @MovIDOrigen, 'TMA', @ID, @Mov, @MovID, @Ok OUTPUT            
          END  
        END
        IF @MovTipo = 'TMA.RADO' AND @EstatusNuevo = 'CONCLUIDO'
        BEGIN
		  SET @Disponible=NULL --CAMBIOS USB
          SELECT @SucursalAlmacen = Sucursal FROM Alm WHERE Almacen = @Almacen
          SELECT @TarimaSurtido = TarimaSurtido FROM TMA WHERE ID = @ID		  
		  SELECT @Disponible = Disponible FROM ArtDisponibleTarima WHERE Tarima = @TarimaSurtido AND Almacen = @Almacen
          --- BUG 7891 Pedidos con más de un Artículo en el Detalle
          SELECT @Articulo = @ArticuloAux
		  --SELECT @Articulo=ISNULL(Articulo,@ArticuloAux), @SubCuenta=ISNULL(SubCuenta, @SubCuentaAux) FROM Tarima WHERE Almacen = @AlmacenDetalle AND Tarima = @Tarima --TASK2429PGC 05082015          
		  SELECT @Costo = ISNULL(CostoPromedio,0.0) * ISNULL(@CantidadPicking,0) FROM ArtCosto WHERE Articulo = @Articulo AND Sucursal = @Sucursal AND Empresa = @Empresa
          SELECT @CantidadPicking = @CantidadPicking + @Disponible - (SELECT Disponible FROM ArtDisponibleTarima WHERE Tarima = @Tarima AND Almacen = @Almacen AND Articulo = @Articulo)
          SELECT @ArtMoneda = MonedaCosto FROM Art WHERE Articulo = @Articulo
          SELECT @TipoPos = ISNULL(Tipo,'') FROM AlmPos WHERE Posicion = @PosicionDestino AND Almacen = @Almacen --BUG 14127          
          IF @TarimaSurtido IS NULL AND @TipoPos = 'Domicilio'
          BEGIN
		    SELECT @TarimaSurtido = MIN(t.Tarima) FROM Tarima t JOIN AlmPos p ON p.Posicion = t.Posicion AND p.Almacen = @Almacen LEFT JOIN ArtDisponibleTarima a ON t.Tarima = a.Tarima WHERE p.ArticuloEsp = @Articulo AND p.Tipo = 'Domicilio' AND t.Estatus = 'ALTA' AND t.Tarima NOT LIKE '%-%'  --BUG8301 Cuando el articulo no tiene domicilio y se tiene como primra tabla ArtDisponibleTarima no logra hacer el JOIN
            --SELECT @TarimaSurtido = MIN(t.Tarima) FROM ArtDisponibleTarima a JOIN Tarima t ON t.Tarima = a.Tarima JOIN AlmPos p ON p.Posicion = t.Posicion  AND p.Almacen = @Almacen WHERE a.Articulo = @Articulo AND p.Tipo = 'Domicilio' AND t.Estatus = 'ALTA' AND t.Tarima NOT LIKE '%-%'
            SELECT @Disponible = Disponible FROM ArtDisponibleTarima WHERE Tarima = @Tarima AND Almacen = @Almacen AND Articulo=@Articulo AND Empresa=@Empresa--CAMBIOS USB
            SELECT @CantidadPicking = (SELECT SUM(Disponible) FROM ArtDisponibleTarima WHERE Tarima = @TarimaSurtido AND Empresa=@Empresa AND Almacen = @Almacen) --BUG2822
          END 
          ELSE
          IF @TarimaSurtido IS NULL AND @TipoPos = 'Ubicacion'
          BEGIN
		    SELECT @TarimaSurtido = t.Tarima FROM ArtDisponibleTarima a JOIN Tarima t ON t.Tarima = a.Tarima JOIN AlmPos p ON p.Posicion = t.Posicion AND p.Almacen = @Almacen WHERE a.Articulo = @Articulo AND p.Tipo = 'Ubicacion' AND a.Disponible > 0 AND t.Estatus = 'ALTA' AND t.Tarima NOT LIKE '%-%' AND t.Posicion = @PosicionDestino
		    SELECT @Disponible = Disponible FROM ArtDisponibleTarima WHERE Tarima = @Tarima AND Almacen = @Almacen AND Articulo=@Articulo AND Empresa=@Empresa --CAMBIOS USB
		    SELECT @CantidadPicking = (SELECT SUM(Disponible) FROM ArtDisponibleTarima WHERE Tarima = @TarimaSurtido AND Empresa=@Empresa AND Almacen = @Almacen) --BUG2822
          END          
          SELECT @Artipo = Tipo FROM Art WHERE Articulo = @Articulo

		  /* Es importante que no se actualice la Tabla Tarima si la posición Origen es de Surtido y solo se tiene actualizarse si la posición destino es Ubicación */
		  SELECT @TipoOrigen = RTRIM(LTRIM(Tipo)) FROM AlmPos WHERE Posicion = @Posicion AND Almacen = @Almacen 

          IF @TipoOrigen <> 'Surtido'
            IF @TipoPos = 'Ubicacion'
                UPDATE Tarima SET Posicion = @PosicionDestino WHERE Posicion = @Posicion AND Almacen = @Almacen AND Tarima = @Tarima  
		 /* Es importante que no se actualice la Tabla Tarima si la posición Origen es de Surtido y solo se tiene actualizarse si la posición destino es Ubicación */

          IF @Artipo <> 'SERIE' AND @TipoPos = 'Domicilio'  
          BEGIN  
            --UPDATE Tarima SET Posicion = @PosicionDestino WHERE Tarima = @Tarima  --CAMBIOS USB            
            SELECT @Costo = Saldo FROM SaldoUWMS  WHERE Cuenta = @ArticuloAux AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,ISNULL(SubCuenta,'')) AND SubGrupo = @Tarima
            IF @Tarima IS NOT NULL AND @TarimaSurtido IS NOT NULL                
			  EXEC spSaldo @SucursalAlmacen, @Accion, @Empresa, @Usuario, 'WMS', @ArtMoneda, 1, @Articulo, @SubCuenta, @Almacen, NULL, @Modulo, @ID, @Mov, @MovID, 0, 0, @Disponible, 1, @FechaAfectacion, @Ejercicio, @Periodo, @Mov, @MovID, 0, 0, 0, @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @SubGrupo = @Tarima  
            IF @Tarima IS NOT NULL AND @TarimaSurtido IS NOT NULL                
			  EXEC spSaldo @SucursalAlmacen, @Accion, @Empresa, @Usuario, 'WMS', @ArtMoneda, 1, @Articulo, @SubCuenta, @Almacen, NULL, @Modulo, @ID, @Mov, @MovID, 1, 0, @Disponible, 1, @FechaAfectacion, @Ejercicio, @Periodo, @Mov, @MovID, 0, 0, 0, @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @SubGrupo = @TarimaSurtido  
			   SELECT @TipoPosc = Tipo FROM AlmPos WHERE Posicion = @PosicionDestino

				IF @TipoPosc = 'Domicilio' AND @MovTipo = 'TMA.RADO'
				BEGIN
					--IF NOT EXISTS (SELECT * FROM SerieLote WHERE Articulo = @ArticuloAux AND Almacen  = @Almacenc AND Tarima   = @TarimaSurtido AND Empresa  = @Empresa AND Sucursal = @Sucursalc AND SerieLote = (SELECT TOP 1 ISNULL(SerieLote,'') FROM SerieLote WHERE Tarima = @Tarima)) --CAMBIOS USB
					--INSERT SerieLote (Sucursal, Empresa, Articulo, SubCuenta, SerieLote, Almacen, Tarima, Propiedades, Cliente, Localizacion, ExistenciaActivoFijo, UltimaEntrada, UltimaSalida, Existencia, ExistenciaAlterna, CostoPromedio)
					--SELECT TOP 1  Sucursal, Empresa, Articulo, SubCuenta, (SELECT TOP 1 ISNULL(SerieLote,'') FROM SerieLote WHERE Tarima = @Tarima), Almacen, @TarimaSurtido, Propiedades, Cliente, Localizacion, ExistenciaActivoFijo, GETDATE(),     NULL,         isnull(@CantidadUnidad,0), ExistenciaAlterna, CostoPromedio
					--  FROM SerieLote WHERE Tarima = @Tarima AND Articulo = @ArticuloAux AND Almacen = @Almacenc AND Empresa = @Empresa AND Sucursal = @Sucursalc AND SerieLote = (SELECT TOP 1 ISNULL(SerieLote,'') FROM SerieLote WHERE Tarima = @Tarima)
					IF EXISTS (SELECT * FROM SerieLote WHERE tarima = @TarimaSurtido AND Articulo = @ArticuloAux AND Almacen = @Almacenc AND empresa = @Empresa AND Sucursal = @Sucursalc) --AND SerieLote IN (SELECT TOP 1 ISNULL(SerieLote,'') FROM SerieLote WHERE Tarima = @Tarima))
					BEGIN
						DECLARE crAfectaSerieLote CURSOR LOCAL STATIC FOR
						SELECT s.SerieLote, b.Disponible
						FROM SerieLote s JOIN WMSEstatusTarima b ON s.SerieLote=b.SerieLote AND s.Articulo=b.Articulo AND s.Almacen=b.Almacen AND s.Empresa=b.Empresa AND s.Tarima=b.Tarima
						WHERE b.SerieLote IS NOT NULL AND s.Tarima=@Tarima AND s.Empresa=@Empresa AND s.Articulo=@Articulo
						OPEN crAfectaSerieLote
						FETCH NEXT FROM crAfectaSerieLote INTO @SerieLote, @Disponible2
						WHILE @@FETCH_STATUS=0
						BEGIN
							IF EXISTS(SELECT SerieLote FROM SerieLote WHERE Empresa=@Empresa AND Articulo=@Articulo AND Almacen=@Almacen AND Tarima=@TarimaSurtido AND SerieLote=@SerieLote)
							BEGIN
								UPDATE SerieLote SET Existencia=ISNULL(Existencia,0)+@Disponible2 WHERE Empresa=@Empresa AND Articulo=@Articulo AND Almacen=@Almacen AND Tarima=@TarimaSurtido AND SerieLote=@SerieLote 
								UPDATE SerieLote SET Existencia=ISNULL(Existencia,0)-@Disponible2 WHERE Empresa=@Empresa AND Articulo=@Articulo AND Almacen=@Almacen AND Tarima=@Tarima AND SerieLote=@SerieLote	
							END
							ELSE
							BEGIN
								UPDATE SerieLote SET Tarima=@TarimaSurtido WHERE Empresa=@Empresa AND Articulo=@Articulo AND Almacen=@Almacen AND Tarima=@Tarima AND SerieLote=@SerieLote
							END
						FETCH NEXT FROM crAfectaSerieLote INTO @SerieLote, @Disponible2
						END CLOSE crAfectaSerieLote DEALLOCATE crAfectaSerieLote
					END
				END  
			--BUG 7655 Error al hacer un reacomodo da de baja la tarima. (Inicio)
			IF @TipoOrigen='Surtido' 
			BEGIN
				IF (SELECT SUM(ISNULL(a.Disponible,0)) FROM ArtDisponibleTarima a JOIN Tarima t ON a.Tarima = t.Tarima WHERE a.Tarima = @Tarima AND t.Estatus = 'ALTA' /*AND a.Articulo = @Articulo */AND a.Empresa=@Empresa AND a.Almacen = @Almacen) <= 0  --TASK2429 --BUG2822 --BUG3002
				UPDATE Tarima SET Estatus = 'BAJA', Baja = @FechaRegistro WHERE Tarima = @Tarima   
			END
			ELSE
			BEGIN
				IF (SELECT ISNULL(a.Disponible,0) FROM ArtDisponibleTarima a JOIN Tarima t ON a.Tarima = t.Tarima WHERE a.Tarima = @Tarima AND t.Estatus = 'ALTA' AND a.Articulo = @Articulo AND a.Empresa=@Empresa AND a.Almacen = @Almacen) <= 0  --TASK2429 --BUG2822 --BUG3002
				UPDATE Tarima SET Estatus = 'BAJA', Baja = @FechaRegistro WHERE Tarima = @Tarima   
			END
            IF (SELECT ISNULL(a.Disponible,0) FROM ArtDisponibleTarima a JOIN Tarima t ON a.Tarima = t.Tarima WHERE a.Tarima = @TarimaSurtido AND t.Estatus = 'ALTA' AND a.Articulo = @Articulo AND a.Empresa=@Empresa AND a.Almacen = @Almacen) <= 0  --TASK2429 --BUG2822 --BUG3002
              UPDATE Tarima SET Estatus = 'BAJA', Baja = @FechaRegistro WHERE Tarima = @TarimaSurtido  
			  --BUG 7655 Error al hacer un reacomodo da de baja la tarima. (Fin) Se comenta el bloque de abajo ya que se remplaza por este.
			/*--BUG 7655
            IF (SELECT ISNULL(a.Disponible,0) FROM ArtDisponibleTarima a JOIN Tarima t ON a.Tarima = t.Tarima WHERE a.Tarima = @Tarima AND t.Estatus = 'ALTA' AND a.Articulo = @Articulo AND a.Empresa=@Empresa AND a.Almacen = @Almacen) <= 0  --TASK2429 --BUG2822 --BUG3002
              UPDATE Tarima SET Estatus = 'BAJA', Baja = @FechaRegistro WHERE Tarima = @Tarima   
            IF (SELECT ISNULL(a.Disponible,0) FROM ArtDisponibleTarima a JOIN Tarima t ON a.Tarima = t.Tarima WHERE a.Tarima = @TarimaSurtido AND t.Estatus = 'ALTA' AND a.Articulo = @Articulo AND a.Empresa=@Empresa AND a.Almacen = @Almacen) <= 0  --TASK2429 --BUG2822 --BUG3002
              UPDATE Tarima SET Estatus = 'BAJA', Baja = @FechaRegistro WHERE Tarima = @TarimaSurtido  
			*/--BUG 7655
          END          
          IF @Artipo IN ('LOTE') AND @Tarima IS NOT NULL AND @TarimaSurtido IS NOT NULL AND @TipoPos = 'Domicilio' AND @Tarima <> @TarimaSurtido AND @MovTipo <> 'TMA.RADO'
          BEGIN  
            IF EXISTS (SELECT * FROM SerieLote WHERE Tarima = @TarimaSurtido) AND @Tarima IS NOT NULL AND @TarimaSurtido IS NOT NULL  
            BEGIN 
              IF (SELECT ISNULL(SerieLote,'') FROM SerieLote WHERE Tarima = @Tarima) IN (SELECT TOP 1 ISNULL(SerieLote,'') FROM SerieLote WHERE Tarima = @TarimaSurtido)  
                UPDATE SerieLote  SET Existencia = ISNULL(Existencia,0) + (SELECT ISNULL(Existencia,0) FROM SerieLote WHERE Tarima = @Tarima AND Articulo = @Articulo AND Almacen = @Almacen AND Empresa = @Empresa) --TASK2429PGC				   
                 WHERE Tarima = @TarimaSurtido AND Articulo = @Articulo AND Almacen = @Almacen  AND Empresa = @Empresa AND Sucursal = @Sucursal				    
              ELSE
                INSERT SerieLote (Sucursal, Empresa, Articulo, SubCuenta, SerieLote,                                                                 Almacen, Tarima,         Propiedades, Cliente, Localizacion, ExistenciaActivoFijo, UltimaEntrada, UltimaSalida, Existencia, CostoPromedio)
                SELECT TOP 1      Sucursal, Empresa, Articulo, SubCuenta, (SELECT TOP 1 ISNULL(SerieLote,'') FROM SerieLote WHERE Tarima = @Tarima), Almacen, @TarimaSurtido, Propiedades, Cliente, Localizacion, ExistenciaActivoFijo, GETDATE(),     NULL,         @Disponible, CostoPromedio
                  FROM SerieLote WHERE Tarima = @TarimaSurtido AND Articulo = @Articulo AND SerieLote = (SELECT TOP 1 ISNULL(SerieLote,'') FROM SerieLote WHERE Tarima = @TarimaSurtido) AND Almacen = @Almacen AND Empresa = @Empresa AND Sucursal = @Sucursal	
              UPDATE SerieLote SET Existencia = 0 WHERE Tarima = @Tarima AND Articulo = @Articulo AND Almacen = @Almacen AND Empresa = @Empresa AND Sucursal = @Sucursal	
            END
            ELSE
              UPDATE SerieLote SET Tarima = @TarimaSurtido WHERE Tarima = @Tarima AND Articulo = @Articulo AND Almacen = @Almacen AND Empresa = @Empresa AND Sucursal = @Sucursal				   
          END      
          --UPDATE Tarima SET Posicion = @PosicionDestino WHERE Tarima = @Tarima --CAMBIOS USB        
          IF @Ok IS NULL EXEC spTMAAfectarPosicion @ID, @Accion, @Base, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @Usuario, @Estatus, @EstatusNuevo, @Almacen, @Agente, @Tarima, @Posicion, @PosicionDestino, @Articulo, @Ok OUTPUT, @OkRef OUTPUT  			
        END
        SELECT @TipoPos = ISNULL(Tipo,'') FROM AlmPos WHERE Posicion = @Posicion AND Almacen = @Almacen
        IF @MovTipo IN ('TMA.SUR','TMA.PCKTarima') AND @EstatusNuevo = 'CONCLUIDO' AND @TipoPos IN ('Ubicacion', 'Cross Docking')--TASK6535
        BEGIN
          SELECT @SucursalAlmacen = Sucursal FROM Alm WHERE Almacen = @Almacen
          SELECT @TarimaM = dbo.fnTMATarimaOriginal(@Tarima)
          SELECT @TarimaOrigen = d.Tarima, @TarimaSurtido = t.TarimaSurtido
            FROM TMA o JOIN TMA t ON o.Mov = t.Origen AND o.MovID = t.OrigenID JOIN TMAD d ON o.ID = d.ID WHERE t.ID = @ID AND d.Posicion= @Posicion AND d.PosicionDestino = @PosicionDestino AND d.Almacen = @Almacen AND o.Empresa = @Empresa
          IF @TarimaOrigen IS NOT NULL
            SELECT @TarimaM = @TarimaOrigen
		  IF @MovTipo='TMA.PCKTarima' SELECT @TarimaM = CASE WHEN CHARINDEX('-', @TarimaOrigen) > 0  THEN SUBSTRING(@TarimaOrigen, 1, CHARINDEX('-', @TarimaOrigen)-1) ELSE @TarimaOrigen END --TASK6535
          SELECT @Articulo=ISNULL(Articulo,@ArticuloAux), @SubCuenta=ISNULL(SubCuenta, @SubCuentaAux) FROM Tarima WHERE Almacen = @AlmacenDetalle AND Tarima = @TarimaM --TASK2429PGC 05082015
          SELECT @Articulo = ISNULL(@Articulo,@ArticuloAux)
          SELECT @ArtMoneda = MonedaCosto FROM Art WHERE Articulo = @Articulo  
          SELECT @Costo = ISNULL(CostoPromedio,0.0) * ISNULL(@CantidadPicking,0) FROM ArtCosto WHERE Articulo = @Articulo AND Sucursal = @Sucursal AND Empresa = @Empresa        
          IF @TarimaSurtido IS NOT NULL AND NOT EXISTS(SELECT * FROM Tarima WHERE Tarima = @TarimaSurtido)
          BEGIN
            EXEC spTarimaAlta @Empresa, @Sucursal, @Usuario, @Almacen, @FechaRegistro, @FechaEmision, @TarimaSurtido, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT            
			UPDATE Tarima SET Posicion = @PosicionDestino, FechaCaducidad = (SELECT FechaCaducidad FROM Tarima WHERE Tarima = @TarimaM), Articulo=@Articulo, SubCuenta=@SubCuenta WHERE Tarima = @TarimaSurtido --TASK2429PGC            
          END
          IF(SELECT Posicion FROM Tarima WHERE Tarima = @TarimaSurtido) <> @PosicionDestino
            UPDATE Tarima SET Posicion = @PosicionDestino WHERE Tarima = @TarimaSurtido
          IF @TarimaM IS NOT NULL EXEC spSaldo @SucursalAlmacen, @Accion, @Empresa, @Usuario, 'WMS', @ArtMoneda, 1, @Articulo, @SubCuenta, @Almacen, NULL, @Modulo, @ID, @Mov, @MovID, 0, 0, @CantidadPicking, 1, @FechaAfectacion, @Ejercicio, @Periodo, @Mov, @MovID, 0, 0, 0, @Ok OUTPUT, @OkRef OUTPUT,@Renglon = @Renglon, @SubGrupo = @TarimaM
          
          IF @TarimaSurtido IS NOT NULL  EXEC spSaldo @SucursalAlmacen, @Accion, @Empresa, @Usuario, 'WMS', @ArtMoneda, 1, @Articulo, @SubCuenta, @Almacen, NULL, @Modulo, @ID, @Mov, @MovID, 1, 0, @CantidadPicking, 1, @FechaAfectacion, @Ejercicio, @Periodo, @Mov, @MovID, 0, 0, 0, @Ok OUTPUT, @OkRef OUTPUT,@Renglon = @Renglon, @SubGrupo = @TarimaSurtido

        IF (SELECT ISNULL(a.Disponible,0) FROM ArtDisponibleTarima a JOIN Tarima t ON a.Tarima = t.Tarima WHERE a.Empresa = @Empresa AND a.Tarima = @TarimaM AND t.Estatus = 'ALTA' AND a.Articulo = @Articulo AND a.Almacen = @Almacen) <= 0 --TASK2429 --BUG3002
        BEGIN
            SELECT @Tipo = AlmPos.Tipo FROM Tarima JOIN AlmPos ON AlmPos.Almacen = @Almacen AND Tarima.Posicion = AlmPos.Posicion WHERE Tarima = @TarimaM             
          IF @Tipo <> 'Domicilio' 
            UPDATE Tarima SET Estatus = 'BAJA', Baja = @FechaRegistro WHERE Tarima = @TarimaM
        END
        IF (SELECT ISNULL(a.Disponible,0) FROM ArtDisponibleTarima a JOIN Tarima t ON a.Tarima = t.Tarima WHERE a.Empresa = @Empresa AND a.Tarima = @Tarima AND t.Estatus = 'ALTA' AND a.Articulo = @Articulo AND a.Almacen = @Almacen) <= 0 --TASK2429 --BUG3002
        BEGIN
            SELECT @Tipo = AlmPos.Tipo
              FROM Tarima JOIN AlmPos ON AlmPos.Almacen = @Almacen AND Tarima.Posicion = AlmPos.Posicion WHERE Tarima = @Tarima
          IF @Tipo <> 'Domicilio' 
            UPDATE Tarima SET Estatus = 'BAJA', Baja = @FechaRegistro WHERE Tarima = @Tarima
        END            
          UPDATE TMAD SET Tarima = @TarimaSurtido WHERE Tarima = @TarimaM AND ID = @ID  
          SELECT @Artipo = Tipo FROM Art WHERE Articulo = @Articulo  

          IF @Artipo IN ('SERIE', 'LOTE') AND @Tarima IS NOT NULL AND @TarimaSurtido IS NOT NULL  
          BEGIN  

          SET @CantidadExistencia = 0

      --Task 8036
      --      DECLARE crSerieLote CURSOR FOR  
				  --SELECT slm.RenglonID, slm.SerieLote, slm.Tarima, slm.Cantidad, a.Sucursal
      --              FROM SerieloteMov slm
      --              JOIN Alm a ON slm.Sucursal = a.Sucursal
      --              WHERE Id = @ID
      --                AND Modulo = @Modulo
      --                AND slm.Tarima = @TarimaM 
      --                AND slm.Articulo = @Articulo
      --                AND ISNULL(slm.SubCuenta,'') = ISNULL(@SubCuenta,'')
					 -- AND a.Almacen = @Almacen 
      --                AND slm.Empresa = @Empresa 
      --                AND slm.Sucursal = @Sucursal 
      --      OPEN crSerieLote  
      --      FETCH NEXT FROM crSerieLote INTO @RenglonID, @SerieLote, @TarimaOrigen, @Cantidad, @SucursalAlmacen  
      --      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
      --      BEGIN                
      --        SET @CantidadExistencia = @CantidadExistencia + @Cantidad

      --        IF @CantidadPicking >= @CantidadExistencia
      --        BEGIN  --@TarimaM ACTUAL  


      --          SELECT @CostoPromedio = ISNULL(CostoPromedio,0.0) FROM ArtCosto WHERE Articulo = @Articulo AND Sucursal = @SucursalAlmacen AND Empresa = @Empresa
      --          IF NOT EXISTS (SELECT * FROM SerieLote WHERE SerieLote = @SerieLote AND Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'') AND Almacen = @Almacen AND Tarima = @TarimaM AND Sucursal = @Sucursal AND Empresa = @Empresa )
      --              INSERT SerieLote (Sucursal, Empresa, Articulo, SubCuenta, SerieLote, Almacen, Tarima, UltimaEntrada, Existencia, CostoPromedio)
      --              VALUES(@SucursalAlmacen, @Empresa, @Articulo, ISNULL(@SubCuenta,''), @SerieLote, @Almacen, @TarimaM, GETDATE(), @Cantidad, @CostoPromedio)
      --          ELSE
      --              UPDATE Serielote
      --                  SET Existencia    = ISNULL(Existencia,0) - @Cantidad,
      --                      UltimaEntrada = GETDATE()
      --              WHERE SerieLote = @SerieLote AND Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'') AND Almacen = @Almacen AND Tarima = @TarimaM AND Sucursal = @Sucursal AND Empresa = @Empresa              

      --          --@Tarima Tarima Surtido
      --          IF NOT EXISTS (SELECT * FROM SerieLote WHERE SerieLote = @SerieLote AND Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'') AND Almacen = @Almacen AND Tarima = @TarimaSurtido AND Sucursal = @Sucursal AND Empresa = @Empresa )
      --              INSERT SerieLote (Sucursal, Empresa, Articulo, SubCuenta, SerieLote, Almacen, Tarima, UltimaEntrada, Existencia, CostoPromedio)
      --              VALUES(@SucursalAlmacen, @Empresa, @Articulo, ISNULL(@SubCuenta,''), @SerieLote, @Almacen, @TarimaSurtido, GETDATE(), @Cantidad, @CostoPromedio)
      --          ELSE
      --              UPDATE Serielote
      --                  SET Existencia    = ISNULL(Existencia,0) + ISNULL(@Cantidad,0),
      --                      UltimaEntrada = GETDATE()
      --              WHERE SerieLote = @SerieLote AND Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'') AND Almacen = @Almacen AND Tarima = @TarimaSurtido AND Sucursal = @Sucursal AND Empresa = @Empresa              
      --        END  
  
      --        FETCH NEXT FROM crSerieLote INTO @RenglonID, @SerieLote, @TarimaOrigen, @Cantidad, @SucursalAlmacen
      --      END  
      --      CLOSE crSerieLote  
      --      DEALLOCATE crSerieLote 
      --Task 8036
 
          END  
        END--

        SELECT @TipoPos = ISNULL(Tipo,'') FROM AlmPos WHERE Posicion = @Posicion AND Almacen = @Almacen

        IF @MovTipo = 'TMA.SUR' AND @EstatusNuevo = 'CONCLUIDO' AND @TipoPos = 'Domicilio'
        BEGIN  
          SELECT @SucursalAlmacen = Sucursal FROM Alm WHERE Almacen = @Almacen    
          IF CHARINDEX('-', @TarimaPCK) > 0              
            SELECT @Articulo=ISNULL(Articulo,@ArticuloAux), @SubCuenta=ISNULL(SubCuenta, @SubCuentaAux) FROM Tarima WHERE Almacen = @AlmacenDetalle AND Tarima = SUBSTRING(@TarimaPCK, 1, CHARINDEX('-', @TarimaPCK)-1)--TASK2429PGC 05082015
          ELSE              
            SELECT @Articulo=ISNULL(Articulo,@ArticuloAux), @SubCuenta=ISNULL(SubCuenta, @SubCuentaAux) FROM Tarima WHERE Almacen = @AlmacenDetalle AND Tarima = @TarimaPCK --TASK2429PGC 05082015
			
          SELECT @ArtMoneda = MonedaCosto FROM Art WHERE Articulo = @Articulo  
          SELECT @Costo = ISNULL(CostoPromedio,0.0) * ISNULL(@CantidadPicking,0) FROM ArtCosto WHERE Articulo = @Articulo AND Sucursal = @Sucursal AND Empresa = @Empresa   
          IF @Tarima IS NOT NULL AND NOT EXISTS(SELECT * FROM Tarima WHERE Tarima = @Tarima)  
          BEGIN  
            EXEC spTarimaAlta @Empresa, @Sucursal, @Usuario, @Almacen, @FechaRegistro, @FechaEmision, @Tarima, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT              
              UPDATE Tarima SET Posicion = @PosicionDestino, FechaCaducidad = (SELECT FechaCaducidad FROM Tarima WHERE Tarima = @TarimaPCK), Articulo=@ArticuloAux, SubCuenta=@SubCuentaAux WHERE Tarima = @Tarima  --TASK2429PGC --BUG3817
          END
          IF @ArticuloAux IS NULL --BUG3817
            SELECT @Articulo=ISNULL(Articulo,@ArticuloAux), @SubCuenta=ISNULL(SubCuenta, @SubCuentaAux) FROM Tarima WHERE Tarima = @Tarima --TASK2429PGC05082015                        

            --IF CHARINDEX('-', @TarimaPCK, 1) > 0
            --    SELECT @TarimaM = SUBSTRING(@TarimaPCK, 1, CHARINDEX('-', @TarimaPCK, 1)-1) 
            --ELSE 
            --    SELECT @TarimaM = @TarimaPCK

          IF @Ok IS NULL AND @TarimaPCK IS NOT NULL  
            EXEC spSaldo @SucursalAlmacen, @Accion, @Empresa, @Usuario, 'WMS', @ArtMoneda, 1, @ArticuloAux, @SubCuentaAux, @Almacen, --TASK2429PGC --BUG3817
                         NULL, @Modulo, @ID, @Mov, @MovID, 0, 0, @CantidadPicking, 1, @FechaAfectacion, @Ejercicio, @Periodo, @Mov, @MovID, 0, 0, 0, @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @SubGrupo = @TarimaPCK  
          IF @Ok IS NULL AND @Tarima IS NOT NULL  
            EXEC spSaldo @SucursalAlmacen, @Accion, @Empresa, @Usuario, 'WMS', @ArtMoneda, 1, @ArticuloAux, @SubCuentaAux, @Almacen, --TASK2429PGC --BUG3817
                         NULL, @Modulo, @ID, @Mov, @MovID, 1, 0, @CantidadPicking, 1, @FechaAfectacion, @Ejercicio, @Periodo, @Mov, @MovID, 0, 0, 0, @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @SubGrupo = @Tarima  
          IF (SELECT ISNULL(a.Disponible,0) FROM ArtDisponibleTarima a JOIN Tarima t ON a.Tarima = t.Tarima WHERE a.Empresa = @Empresa AND a.Tarima = @TarimaM AND t.Estatus = 'ALTA' AND a.Articulo = @Articulo AND a.Almacen = @Almacen) <= 0 --TASK2429 --BUG3002
            UPDATE Tarima SET Estatus = 'BAJA', Baja = @FechaRegistro WHERE Tarima = @TarimaM    
          IF (SELECT ISNULL(a.Disponible,0) FROM ArtDisponibleTarima a JOIN Tarima t ON a.Tarima = t.Tarima WHERE a.Empresa = @Empresa AND a.Tarima = @Tarima AND t.Estatus = 'ALTA' AND a.Articulo = @Articulo AND a.Almacen = @Almacen) <= 1 --TASK2429 --BUG3002
            UPDATE Tarima SET Estatus = 'BAJA', Baja = @FechaRegistro WHERE Tarima = @Tarima               
          SELECT @Artipo = Tipo FROM Art WHERE Articulo = @Articulo  

          IF @Ok IS NULL AND @Artipo IN ('SERIE', 'LOTE') AND @TarimaPCK IS NOT NULL AND @Tarima IS NOT NULL
          BEGIN   
            IF CHARINDEX('-', @TarimaPCK, 1) > 0
                SELECT @TarimaM = SUBSTRING(@TarimaPCK, 1, CHARINDEX('-', @TarimaPCK, 1)-1) 
            ELSE 
                SELECT @TarimaM = @TarimaPCK
  
            SET @CantidadExistencia = 0  

--Task 8036
      --      DECLARE crSerieLote CURSOR FOR  
				  --SELECT slm.RenglonID, slm.SerieLote, slm.Tarima, slm.Cantidad, a.Sucursal
      --              FROM SerieloteMov slm
      --              JOIN Alm a ON slm.Sucursal = a.Sucursal
      --              WHERE Id = @ID
      --                AND Modulo = @Modulo
      --                AND slm.Tarima = @TarimaM 
      --                AND slm.Articulo = @Articulo
      --                AND ISNULL(slm.SubCuenta,'') = ISNULL(@SubCuenta,'')
					 -- AND a.Almacen = @Almacen 
      --                AND slm.Empresa = @Empresa 
      --                AND slm.Sucursal = @Sucursal 
      --      OPEN crSerieLote  
      --      FETCH NEXT FROM crSerieLote INTO @RenglonID, @SerieLote, @TarimaOrigen, @Cantidad, @SucursalAlmacen  
      --      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
      --      BEGIN                
      --        SET @CantidadExistencia = @CantidadExistencia + @Cantidad

      --        IF @CantidadPicking >= @CantidadExistencia
      --        BEGIN  --@TarimaM ACTUAL  
      --        SELECT @CostoPromedio = ISNULL(CostoPromedio,0.0) FROM ArtCosto WHERE Articulo = @Articulo AND Sucursal = @SucursalAlmacen AND Empresa = @Empresa
      --          IF NOT EXISTS (SELECT * FROM SerieLote WHERE SerieLote = @SerieLote AND Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'') AND Almacen = @Almacen AND Tarima = @TarimaPCK AND Sucursal = @Sucursal AND Empresa = @Empresa )
      --              INSERT SerieLote (Sucursal, Empresa, Articulo, SubCuenta, SerieLote, Almacen, Tarima, UltimaEntrada, Existencia, CostoPromedio)
      --              VALUES(@SucursalAlmacen, @Empresa, @Articulo, ISNULL(@SubCuenta,''), @SerieLote, @Almacen, @TarimaPCK, GETDATE(), @Cantidad, @CostoPromedio)
      --          ELSE
      --              UPDATE Serielote
      --                  SET Existencia    = ISNULL(Existencia,0) - @Cantidad,
      --                      UltimaEntrada = GETDATE()
      --              WHERE SerieLote = @SerieLote AND Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'') AND Almacen = @Almacen AND Tarima = @TarimaPCK AND Sucursal = @Sucursal AND Empresa = @Empresa              

      --          --@Tarima Tarima Surtido
      --          IF NOT EXISTS (SELECT * FROM SerieLote WHERE SerieLote = @SerieLote AND Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'') AND Almacen = @Almacen AND Tarima = @Tarima AND Sucursal = @Sucursal AND Empresa = @Empresa )
      --              INSERT SerieLote (Sucursal, Empresa, Articulo, SubCuenta, SerieLote, Almacen, Tarima, UltimaEntrada, Existencia, CostoPromedio)
      --              VALUES(@SucursalAlmacen, @Empresa, @Articulo, ISNULL(@SubCuenta,''), @SerieLote, @Almacen, @Tarima, GETDATE(), @Cantidad, @CostoPromedio)
      --          ELSE
      --              UPDATE Serielote
      --                  SET Existencia    = ISNULL(Existencia,0) + ISNULL(@Cantidad,0),
      --                      UltimaEntrada = GETDATE()
      --              WHERE SerieLote = @SerieLote AND Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'') AND Almacen = @Almacen AND Tarima = @Tarima AND Sucursal = @Sucursal AND Empresa = @Empresa              
      --        END  
  
      --        FETCH NEXT FROM crSerieLote INTO @RenglonID, @SerieLote, @TarimaOrigen, @Cantidad, @SucursalAlmacen
      --      END  
      --      CLOSE crSerieLote  
      --      DEALLOCATE crSerieLote    
--Task 8036
          END
        END  

        SELECT @TipoPos = ISNULL(Tipo,'') FROM AlmPos WHERE Posicion = @Posicion AND Almacen = @Almacen
        IF @MovTipo = 'TMA.TSUR' AND @SubClave = 'TMA.TSURP' AND @EstatusNuevo = 'PROCESAR' AND @TipoPos IN ('Domicilio','Cross Docking')  -- TASK2429PGC AND (SELECT Tipo FROM AlmPos WHERE Almacen = @AlmacenDetalle AND Posicion = @PosicionDestino) = 'Domicilio'  
        BEGIN  
          SELECT @SucursalAlmacen = Sucursal FROM Alm WHERE Almacen = @Almacen  
          SELECT @TarimaM = dbo.fnTMATarimaOriginal(@Tarima)
          UPDATE TMAD SET CantidadA = 0, Procesado = 1 WHERE ID = @IDOrigen AND Tarima = @Tarima  
          UPDATE Tarima SET /*Posicion = @PosicionDestino,*/ Alta = GETDATE() WHERE Tarima = @Tarima /*AND Almacen = @AlmacenDetalle*/ AND Posicion = @Posicion    
		  SELECT @Articulo=ISNULL(Articulo,@ArticuloAux), @SubCuenta=ISNULL(SubCuenta, @SubCuentaAux) FROM Tarima WHERE Almacen = @AlmacenDetalle AND Tarima = @TarimaM --TASK2429PGC 05082015
          SELECT @ArtMoneda = MonedaCosto FROM Art WHERE Articulo = @Articulo  
          SELECT @Costo = ISNULL(CostoPromedio,0.0) * ISNULL(@CantidadPicking,0) FROM ArtCosto WHERE Articulo = @Articulo AND Sucursal = @Sucursal AND Empresa = @Empresa    
          SELECT @TotalSerie = SUM(Cantidad) FROM SerieLoteMov WHERE ID = @ID AND Modulo = @Modulo AND Articulo = @ArticuloAux
          --IF @TotalSerie > @CantidadPicking
          --  SET @Ok = 20330

          IF @Ok IS NULL AND @TarimaM IS NOT NULL 
            EXEC spSaldo @SucursalAlmacen, @Accion, @Empresa, @Usuario, 'WMS', @ArtMoneda, 1, @ArticuloAux, @SubCuentaAux, @Almacen,  --BUG3817
                         NULL, @Modulo, @ID, @Mov, @MovID, 0, 0, @CantidadPicking, 1, @FechaAfectacion, @Ejercicio, @Periodo, @Mov, @MovID, 0, 0, 0, @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @SubGrupo = @TarimaM            
          IF @Ok IS NULL AND @Tarima IS NOT NULL  
              EXEC spSaldo @SucursalAlmacen, @Accion, @Empresa, @Usuario, 'WMS', @ArtMoneda, 1, @ArticuloAux, @SubCuentaAux, @Almacen, --TASK2429PGC --BUG3817
                         NULL, @Modulo, @ID, @Mov, @MovID, 1, 0, @CantidadPicking, 1, @FechaAfectacion, @Ejercicio, @Periodo, @Mov, @MovID, 0, 0, 0, @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @SubGrupo = @Tarima    
--Task 8036
          --    IF @Ok IS NULL
          --    BEGIN
          --      DECLARE crSerieLote CURSOR FOR  
				      --SELECT slm.RenglonID, slm.SerieLote, slm.Tarima, slm.Cantidad, a.Sucursal
          --              FROM SerieloteMov slm
          --              JOIN Alm a ON slm.Sucursal = a.Sucursal
          --              WHERE Id = @ID
          --                AND Modulo = @Modulo
          --                AND slm.Tarima = @TarimaM 
          --                AND slm.Articulo = @Articulo
          --                AND ISNULL(slm.SubCuenta,'') = ISNULL(@SubCuenta,'')
					     -- AND a.Almacen = @Almacen 
          --                AND slm.Empresa = @Empresa 
          --                AND slm.Sucursal = @Sucursal 
          --      OPEN crSerieLote  
          --      FETCH NEXT FROM crSerieLote INTO @RenglonID, @SerieLote, @TarimaOrigen, @Cantidad, @SucursalAlmacen  
          --      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
          --      BEGIN                
          --        IF @Cantidad <= @CantidadPicking --<= @CantidadExistencia
          --        BEGIN  --@TarimaM ACTUAL  
          --          SELECT @CostoPromedio = ISNULL(CostoPromedio,0.0) FROM ArtCosto WHERE Articulo = @Articulo AND Sucursal = @SucursalAlmacen AND Empresa = @Empresa
          --          IF NOT EXISTS (SELECT * FROM SerieLote WHERE SerieLote = @SerieLote AND Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'') AND Almacen = @Almacen AND Tarima = @TarimaM AND Sucursal = @Sucursal AND Empresa = @Empresa )
          --              INSERT SerieLote (Sucursal, Empresa, Articulo, SubCuenta, SerieLote, Almacen, Tarima, UltimaEntrada, Existencia, CostoPromedio)
          --              VALUES(@SucursalAlmacen, @Empresa, @Articulo, ISNULL(@SubCuenta,''), @SerieLote, @Almacen, @TarimaM, GETDATE(), @Cantidad, @CostoPromedio)
          --          ELSE
          --              UPDATE Serielote
          --                  SET Existencia    = ISNULL(Existencia,0) - @Cantidad,
          --                      UltimaEntrada = GETDATE()
          --              WHERE SerieLote = @SerieLote AND Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'') AND Almacen = @Almacen AND Tarima = @TarimaM AND Sucursal = @Sucursal AND Empresa = @Empresa              

          --          --@Tarima Tarima Surtido
          --          IF NOT EXISTS (SELECT * FROM SerieLote WHERE SerieLote = @SerieLote AND Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'') AND Almacen = @Almacen AND Tarima = @Tarima AND Sucursal = @Sucursal AND Empresa = @Empresa )
          --              INSERT SerieLote (Sucursal, Empresa, Articulo, SubCuenta, SerieLote, Almacen, Tarima, UltimaEntrada, Existencia, CostoPromedio)
          --              VALUES(@SucursalAlmacen, @Empresa, @Articulo, ISNULL(@SubCuenta,''), @SerieLote, @Almacen, @Tarima, GETDATE(), @Cantidad, @CostoPromedio)
          --          ELSE
          --              UPDATE Serielote
          --                  SET Existencia    = ISNULL(Existencia,0) + ISNULL(@Cantidad,0),
          --                      UltimaEntrada = GETDATE()
          --              WHERE SerieLote = @SerieLote AND Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'') AND Almacen = @Almacen AND Tarima = @Tarima AND Sucursal = @Sucursal AND Empresa = @Empresa              
          --        END  
  
          --        FETCH NEXT FROM crSerieLote INTO @RenglonID, @SerieLote, @TarimaOrigen, @Cantidad, @SucursalAlmacen
          --      END  
          --      CLOSE crSerieLote  
          --      DEALLOCATE crSerieLote 
          --  END
--Task 8036
        END            
        IF @MovTipo = 'TMA.RADO' AND @EstatusNuevo = 'CANCELADO' AND @Accion = 'CANCELAR'  
          UPDATE Tarima SET Posicion = @Posicion WHERE Tarima = @Tarima    
        IF (SELECT ISNULL(a.Disponible,0) FROM ArtDisponibleTarima a JOIN Tarima t ON a.Tarima = t.Tarima WHERE a.Empresa = @Empresa AND a.Tarima = @TarimaM AND t.Estatus = 'ALTA' AND a.Articulo = @Articulo AND a.Almacen = @Almacen) <= 0 --TASK2429 --BUG3002
        BEGIN
            SELECT @Tipo = AlmPos.Tipo FROM Tarima  JOIN AlmPos ON AlmPos.Almacen = @Almacen AND Tarima.Posicion = AlmPos.Posicion WHERE Tarima = @TarimaM             
          IF @Tipo <> 'Domicilio' 
            UPDATE Tarima SET Estatus = 'BAJA', Baja = @FechaRegistro WHERE Tarima = @TarimaM
        END
		---BUG 7655 Error al hacer un reacomodo da de baja la tarima. (Inicio)
		IF @TipoOrigen='Surtido' 
		BEGIN
			IF (SELECT SUM(ISNULL(a.Disponible,0)) FROM ArtDisponibleTarima a JOIN Tarima t ON a.Tarima = t.Tarima WHERE a.Empresa = @Empresa AND a.Tarima = @Tarima AND t.Estatus = 'ALTA' /*AND a.Articulo = @Articulo */AND a.Almacen = @Almacen) <= 0 --TASK2429 --BUG3002
			BEGIN
				SELECT @Tipo = AlmPos.Tipo
				  FROM Tarima JOIN AlmPos ON AlmPos.Almacen = @Almacen AND Tarima.Posicion = AlmPos.Posicion WHERE Tarima = @Tarima
			  IF @Tipo <> 'Domicilio' 
				UPDATE Tarima SET Estatus = 'BAJA', Baja = @FechaRegistro WHERE Tarima = @Tarima
			END   
		END
		ELSE
		BEGIN
			IF (SELECT ISNULL(a.Disponible,0) FROM ArtDisponibleTarima a JOIN Tarima t ON a.Tarima = t.Tarima WHERE a.Empresa = @Empresa AND a.Tarima = @Tarima AND t.Estatus = 'ALTA' AND a.Articulo = @Articulo AND a.Almacen = @Almacen) <= 0 --TASK2429 --BUG3002
			BEGIN
				SELECT @Tipo = AlmPos.Tipo
				  FROM Tarima JOIN AlmPos ON AlmPos.Almacen = @Almacen AND Tarima.Posicion = AlmPos.Posicion WHERE Tarima = @Tarima
			  IF @Tipo <> 'Domicilio' 
				UPDATE Tarima SET Estatus = 'BAJA', Baja = @FechaRegistro WHERE Tarima = @Tarima
			END   
		END   
		--BUG 7655 Error al hacer un reacomodo da de baja la tarima. (Fin) Se comenta bloque de abajo y se remplaza por este.
		/* --BUG 7655
		IF (SELECT ISNULL(a.Disponible,0) FROM ArtDisponibleTarima a JOIN Tarima t ON a.Tarima = t.Tarima WHERE a.Empresa = @Empresa AND a.Tarima = @Tarima AND t.Estatus = 'ALTA' AND a.Articulo = @Articulo AND a.Almacen = @Almacen) <= 0 --TASK2429 --BUG3002
        BEGIN
            SELECT @Tipo = AlmPos.Tipo
              FROM Tarima JOIN AlmPos ON AlmPos.Almacen = @Almacen AND Tarima.Posicion = AlmPos.Posicion WHERE Tarima = @Tarima
          IF @Tipo <> 'Domicilio' 
            UPDATE Tarima SET Estatus = 'BAJA', Baja = @FechaRegistro WHERE Tarima = @Tarima
        END     
	  */ --BUG 7655
	  
      IF @WMSDispararReacomodos = 1 AND @MovTipo = 'TMA.TSUR' AND @SubClave = 'TMA.TSURP' AND @EstatusNuevo IN('PROCESAR', 'CANCELADO')
      BEGIN
          SELECT @Articulo=ISNULL(Articulo,@ArticuloAux), @SubCuenta=ISNULL(SubCuenta, @SubCuentaAux) FROM Tarima WHERE Almacen = @AlmacenDetalle AND Tarima = @Tarima --TASK2429PGC 05082015 
          IF @Tarima LIKE '%-%'       
	      BEGIN
            SELECT @LEN = LEN(@Tarima)
	        WHILE SUBSTRING(@Tarima,@LEN,1) <> '-'
	          SELECT @LEN = @LEN -1
	        SELECT @TarimaReacomodo = SUBSTRING(@Tarima,1, @LEN)
	        SELECT @TarimaReacomodo = SUBSTRING(@TarimaReacomodo,1, @LEN-1)
	      END 

		  IF @SubCuenta IS NULL --TASK2429PGC
           EXEC spTMAReacomodoSolicitar @ID, @@SPID, @IDOrigen, @Accion, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaAfectacion, 
								        @FechaConclusion, @Proyecto, @Usuario, @Autorizacion, @DocFuente, @Observaciones, @Concepto, @Referencia, @Estatus, 
								        @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario, @Sucursal, @SucursalDestino, @SucursalOrigen, 
								        @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @TarimaEsp = @TarimaReacomodo, @PosicionEsp = @Posicion, @ArticuloEsp = NULL
        END  
      IF @Ok IS NOT NULL AND @OkRef IS NULL SELECT @OkRef = @Tarima  
      FETCH NEXT FROM crAfectarTMAD INTO @Tarima, @AlmacenDetalle, @Posicion, @PosicionDestino, @TarimaEstatus, @CantidadPicking, @TarimaPCK, 
                                         @CantidadUnidad, @Unidad, --REQ12615 WMS  --BUG2513
                                         @ArticuloAux, @SubCuentaAux, --TASK2429PGC
										 @Es50, @Es50TarimaDom, @Es50Cantidad --BUG3340
      END  
      CLOSE crAfectarTMAD  
      DEALLOCATE crAfectarTMAD   
      IF @Ok IN (NULL, 80030)  
      BEGIN  
        IF @EstatusNuevo = 'CANCELADO' SELECT @FechaCancelacion = @FechaRegistro ELSE SELECT @FechaCancelacion = NULL  
        IF @EstatusNuevo = 'CONCLUIDO' SELECT @FechaConclusion  = @FechaEmision  ELSE IF @EstatusNuevo <> 'CANCELADO' SELECT @FechaConclusion  = NULL  
        IF @CfgContX = 1 AND @CfgContXGenerar <> 'NO'  
        BEGIN  
          IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @EstatusNuevo <> 'CANCELADO' SELECT @GenerarPoliza = 1 ELSE  
          IF @Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @EstatusNuevo =  'CANCELADO' IF @GenerarPoliza = 1 SELECT @GenerarPoliza = 0 ELSE SELECT @GenerarPoliza = 1  
        END  
        EXEC spValidarTareas @Empresa, @Modulo, @ID, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT  
        UPDATE TMA  
           SET FechaConclusion  = @FechaConclusion,   
               FechaCancelacion = @FechaCancelacion,   
               UltimoCambio     = CASE WHEN UltimoCambio IS NULL THEN @FechaRegistro ELSE UltimoCambio END,  
               Estatus          = @EstatusNuevo,  
               Situacion  = CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END
         WHERE ID = @ID 
        IF @@ERROR <> 0 SELECT @Ok = 1 
        IF @MovTipo NOT IN ('TMA.OADO','TMA.SRADO', 'TMA.SADO', 'TMA.ORADO')  AND @EstatusNuevo = 'CONCLUIDO' --BUG 13802
          UPDATE TMAD SET Procesado = 1, CantidadA = 0 WHERE ID = @ID AND EstaPendiente = 1 
        IF @MovTipo IN ('TMA.SUR','TMA.RADO','TMA.ADO', 'TMA.SURPER', 'TMA.PCKTARIMA', 'TMA.PCKTARIMATRAN') AND @Ok IS NULL OR @MovTipo = 'TMA.TSUR' AND @SubClave = 'TMA.TSURP' AND @EstatusNuevo = 'PROCESAR' AND @Ok IS NULL--AND (SELECT COUNT(0) FROM TMAD WHERE ID = @ID AND ISNULL(Procesado,0) = 0) = 0  --TASK6535 --TASK6535
        BEGIN  
          SELECT @MovOrigen = Origen, @MovIDOrigen = OrigenID FROM TMA WHERE ID = @ID AND OrigenTipo = 'TMA'  
          SELECT @IDOrigen = ID FROM TMA WHERE Mov = @MovOrigen AND MovID = @MovIDOrigen AND Empresa = @Empresa  
          SELECT @FechaConclusion  = @FechaEmision  
          IF (SELECT COUNT(0) FROM TMAD WHERE ID = @IDOrigen AND ISNULL(Procesado,0) = 0) = 0 AND @SubClave <> 'TMA.TSURP' AND @MovTipo <> 'TMA.SURPER'  
          BEGIN  
            UPDATE TMA SET FechaConclusion  = @FechaConclusion, FechaCancelacion = @FechaCancelacion,  UltimoCambio     = CASE WHEN UltimoCambio IS NULL THEN GETDATE() ELSE UltimoCambio END,  
                           Estatus          = CASE WHEN @EstatusNuevo = 'CANCELADO' THEN 'PENDIENTE' ELSE @EstatusNuevo END,   Situacion  = CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END
             WHERE ID = @IDOrigen                            
             IF @MovTipo = 'TMA.TSUR' AND @SubClave = 'TMA.TSURP' AND @EstatusNuevo = 'PROCESAR'  
               UPDATE TMA SET Estatus = 'CONCLUIDO' WHERE ID = @IDOrigen    
          END  
          IF @MovTipo = 'TMA.TSUR' AND @SubClave = 'TMA.TSURP' OR @MovTipo = 'TMA.SURPER' OR @MovTipo = 'TMA.PCKTARIMATRAN'  --TASK6535
          BEGIN 
            DECLARE crTarimaD CURSOR LOCAL FOR  
             SELECT CASE WHEN (CHARINDEX('-', Tarima)-1)  < 0 THEN  Tarima ELSE SUBSTRING(Tarima, 1, (CHARINDEX('-', Tarima)-1) )END, SUM(ISNULL(CantidadPicking,0)), Renglon  
               FROM TMAD WHERE ID = @IDOrigen  AND CASE WHEN (CHARINDEX('-', Tarima)-1)  < 0 THEN  Tarima ELSE SUBSTRING(Tarima, 1, (CHARINDEX('-', Tarima)-1) )END IN(SELECT  CASE WHEN (CHARINDEX('-', Tarima)-1)  < 0 THEN Tarima ELSE SUBSTRING(Tarima, 1, (CHARINDEX('-', Tarima)-1) )END FROM TMAD WHERE ID = @ID)  
              GROUP BY CASE WHEN (CHARINDEX('-', Tarima)-1)  < 0 THEN  Tarima ELSE SUBSTRING(Tarima, 1, (CHARINDEX('-', Tarima)-1) )END, Renglon              
            OPEN crTarimaD  
            FETCH NEXT FROM crTarimaD INTO @TarimaOrigen, @CantidadSurtido, @Renglon  
            WHILE @@FETCH_STATUS = 0  
            BEGIN  
              SELECT @CantidadTransito = SUM(ISNULL(CantidadPicking,0))
                FROM TMA t JOIN TMAD d ON t.ID = d.ID JOIN MovTipo m ON m.Modulo = 'TMA' AND m.Mov = t.Mov
               WHERE t.Origen = @MovOrigen
                 AND t.OrigenID = @MovIDOrigen AND t.Empresa = @Empresa AND t.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
                 AND CASE WHEN (CHARINDEX('-', d.Tarima)-1)  < 0 THEN  d.Tarima ELSE SUBSTRING(d.Tarima, 1, (CHARINDEX('-', d.Tarima)-1) )END = @TarimaOrigen
                 AND m.Clave <> 'TMA.SURPER' AND d.Renglon = @Renglon --BUG 14859
                UPDATE TMAD SET Procesado = 0 WHERE ID = @IDOrigen AND Tarima = @TarimaOrigen AND Renglon = @Renglon

				IF @Accion = 'AFECTAR'
				BEGIN
				  --BUG7778
				  --IF @MovTipo IN ('TMA.PCKTARIMATRAN')
                    UPDATE TMAD SET CantidadPendiente = ISNULL(CantidadPicking, 0) - ISNULL(@CantidadTransito, 0) WHERE ID = @IDOrigen AND Tarima = @TarimaOrigen AND Renglon = @Renglon  --BUG18816
			      --ELSE
				  --  UPDATE TMAD SET CantidadPendiente = ISNULL(CantidadPendiente, 0) - ISNULL(@CantidadTransito, 0) WHERE ID = @IDOrigen AND Tarima = @TarimaOrigen AND Renglon = @Renglon  --BUG18816 
				END
                ELSE 
				IF @Accion = 'CANCELAR'
				BEGIN
				  --BUG7778
				  --IF @MovTipo IN ('TMA.PCKTARIMATRAN')
				    UPDATE TMAD SET CantidadPendiente = ISNULL(CantidadPicking, 0) + ISNULL(@CantidadTransito, 0) WHERE ID = @IDOrigen AND Tarima = @TarimaOrigen AND Renglon = @Renglon  --BUG18816
				  --ELSE
                  --  UPDATE TMAD SET CantidadPendiente = ISNULL(CantidadPendiente, 0) + ISNULL(@CantidadTransito, 0) WHERE ID = @IDOrigen AND Tarima = @TarimaOrigen AND Renglon = @Renglon  --BUG18816
				END

                IF NOT EXISTS (SELECT * FROM TMAD WHERE ID = @IDOrigen AND ISNULL(CantidadPendiente, 0) > 0)  
                  UPDATE TMA SET Estatus = 'CONCLUIDO' WHERE ID = @IDOrigen 
              IF @CantidadSurtido < @CantidadTransito AND @MovTipo <> 'TMA.SURPER'  
                SELECT @Ok = 20020  
              UPDATE TMAD SET CantidadA = 0 WHERE ID = @IDOrigen AND Tarima = @TarimaOrigen AND Renglon = @Renglon  
              IF @MovTipo = 'TMA.SURPER'  
              BEGIN  
                SELECT @CantidadPicking = CantidadPicking FROM TMAD WHERE ID = @ID AND Tarima = @TarimaOrigen AND Renglon = @Renglon             
                IF @Accion <> 'CANCELAR'  
                BEGIN  
                  UPDATE TMAD SET CantidadPendiente = ISNULL(CantidadPendiente,CantidadPicking) - @CantidadPicking WHERE ID = @IDOrigen AND Tarima = @TarimaOrigen AND Renglon = @Renglon                                 
                  IF NOT EXISTS (SELECT * FROM TMAD WHERE ID = @IDOrigen AND ISNULL(CantidadPendiente, CantidadPicking) <> 0)  
                    UPDATE TMA SET Estatus = 'CONCLUIDO' WHERE ID = @IDOrigen                           
                END  
                ELSE  
                BEGIN  
                  UPDATE TMAD SET CantidadPendiente =  CantidadPendiente + @CantidadPicking WHERE ID = @IDOrigen AND Tarima = @TarimaOrigen AND Renglon = @Renglon  
                  IF EXISTS (SELECT * FROM TMAD WHERE ID = @IDOrigen AND CantidadPendiente <> 0) AND (SELECT Estatus FROM TMA WHERE ID = @IDOrigen) IN ('CONCLUIDO')  
                    UPDATE TMA SET Estatus = 'PENDIENTE' WHERE ID = @IDOrigen AND Estatus <> 'CANCELADO'  
                END
              END           
              FETCH NEXT FROM crTarimaD INTO @TarimaOrigen, @CantidadSurtido, @Renglon
            END
            CLOSE crTarimaD
            DEALLOCATE crTarimaD
          END
          EXEC spMovFlujo @Sucursal, @Accion, @Empresa, 'TMA', @IDOrigen, @MovOrigen, @MovIDOrigen, 'TMA', @ID, @Mov, @MovID, @Ok OUTPUT
        END  
        IF @MovTipo IN ('TMA.ORADO') AND @Ok IS NULL AND @EstatusNuevo <> 'CANCELADO'--AND (SELECT COUNT(0) FROM TMAD WHERE ID = @ID AND ISNULL(Procesado,0) = 0) = 0--EMG  
        BEGIN  
          SELECT @MovOrigen = Origen, @MovIDOrigen = OrigenID FROM TMA WHERE ID = @ID AND OrigenTipo = 'TMA'  
          SELECT @IDOrigen = ID FROM TMA WHERE Mov = @MovOrigen AND MovID = @MovIDOrigen AND Empresa = @Empresa  
          SELECT @FechaConclusion  = @FechaEmision    
          IF (SELECT COUNT(0) FROM TMAD WHERE ID = @IDOrigen AND ISNULL(Procesado,0) = 0) = 0  
          BEGIN  
            UPDATE TMA SET FechaConclusion  = @FechaConclusion, FechaCancelacion = @FechaCancelacion, UltimoCambio     = CASE WHEN UltimoCambio IS NULL THEN GETDATE() ELSE UltimoCambio END,  
                   Estatus          = 'CONCLUIDO', Situacion  = CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END WHERE ID = @IDOrigen  
          END  
          EXEC spMovFlujo @Sucursal, @Accion, @Empresa, 'TMA', @IDOrigen, @MovOrigen, @MovIDOrigen, 'TMA', @ID, @Mov, @MovID, @Ok OUTPUT  
        END  
  
        IF @MovTipo IN ('TMA.ORADO', 'TMA.OADO') AND @Ok IS NULL AND @EstatusNuevo = 'CANCELADO'--AND (SELECT COUNT(0) FROM TMAD WHERE ID = @ID AND ISNULL(Procesado,0) = 0) = 0  
        BEGIN  
          SELECT @MovOrigen = Origen, @MovIDOrigen = OrigenID FROM TMA WHERE ID = @ID AND OrigenTipo = 'TMA'  
          SELECT @IDOrigen = ID FROM TMA WHERE Mov = @MovOrigen AND MovID = @MovIDOrigen AND Empresa = @Empresa  

          IF (SELECT Estatus FROM TMA WHERE ID = @IDOrigen) = 'CONCLUIDO' 
			UPDATE TMA SET Estatus = 'PENDIENTE' WHERE ID = @IDOrigen  
		  
		    DECLARE crCancelar CURSOR FOR	
              SELECT CASE WHEN (CHARINDEX('-', Tarima)-1) < 0 THEN Tarima ELSE SUBSTRING(Tarima, 1, (CHARINDEX('-', Tarima)-1) ) END,
                     Renglon 
                FROM TMAD 
               WHERE ID = @ID            
                 AND Procesado = 0
               GROUP BY CASE WHEN (CHARINDEX('-', Tarima)-1)  < 0 THEN  Tarima ELSE SUBSTRING(Tarima, 1, (CHARINDEX('-', Tarima)-1) ) END, Renglon 

 	        OPEN crCancelar
	        FETCH NEXT FROM crCancelar INTO @TarimaOrigen, @Renglon
	        WHILE @@FETCH_STATUS = 0 
	        BEGIN	

                  IF (SELECT COUNT(0) FROM TMAD WHERE ID = @IDOrigen AND Tarima = @TarimaOrigen AND Renglon = @Renglon AND ISNULL(Procesado,0) = 1) = 1
                    UPDATE TMAD SET Procesado = 0 WHERE ID = @IDOrigen AND Tarima = @TarimaOrigen AND Renglon = @Renglon 

		        FETCH NEXT FROM crCancelar INTO @TarimaOrigen, @Renglon
	        END
	        CLOSE crCancelar
	        DEALLOCATE crCancelar        
           
        END  
      END  
    END    
    IF @Ok IS NULL AND @Accion = 'AFECTAR' OR @Ok BETWEEN 80030 AND 81000 AND @Accion = 'AFECTAR'  
    BEGIN  
      IF (SELECT Estatus FROM TMA WHERE ID = @ID) IN ('PENDIENTE') AND @MovTipo IN ('TMA.OADO', 'TMA.ORADO', 'TMA.OSUR',  'TMA.OPCKTARIMA')   --TASK6535
        UPDATE TMA SET FechaInicio = GETDATE() WHERE ID = @ID  
        UPDATE TMAD SET CantidadPendiente = CantidadUnidad WHERE ID = @ID
		IF @MovTipo IN ('TMA.TSUR') AND (@Ok IS NULL OR @Ok BETWEEN 80000 AND 81000) 
			BEGIN
				SELECT @MovOrigen = Origen, @MovIDOrigen = OrigenID FROM TMA WHERE ID = @ID AND OrigenTipo = 'TMA'
				SELECT @IDOrigen = ID FROM TMA WHERE Mov = @MovOrigen AND MovID = @MovIDOrigen AND Empresa = @Empresa
				SELECT @FechaConclusion  = @FechaEmision 				
				IF (SELECT ESTATUS FROM TMA WHERE ID = @IDOrigen) = 'PENDIENTE'
				BEGIN
					UPDATE A SET A.CantidadPendiente = CASE WHEN (A.CantidadPendiente - B.CantidadPendiente) >= 0 THEN (A.CantidadPendiente - B.CantidadPendiente) ELSE A.CantidadPendiente END
					  FROM TMAD A JOIN TMAD B ON A.ID = @IDOrigen AND A.Renglon = B.Renglon AND A.Tarima = B.Tarima AND A.Almacen = B.Almacen  AND A.Posicion = B.Posicion AND A.PosicionDestino = B.PosicionDestino AND B.ID = @ID
				END				
				IF @MovTipo<>'TMA.OADO' AND (SELECT COUNT(0) FROM TMAD WHERE ID = @IDOrigen AND ISNULL(Procesado,0) = 0) = 0 AND NOT EXISTS (SELECT * FROM TMAD WHERE ID = @IDOrigen AND ISNULL(CantidadPendiente, 0) > 0)
				BEGIN
					UPDATE TMA SET Estatus = 'CONCLUIDO' WHERE ID = @IDOrigen
				END
			END
      IF (SELECT Estatus FROM TMA WHERE ID = @ID) IN ('CONCLUIDO', 'PROCESAR') AND @MovTipo IN ('TMA.ADO', 'TMA.RADO', 'TMA.SUR', 'TMA.TSUR', 'TMA.PCKTarima', 'TMA.PCKTarimaTran')  --TASK6535
      BEGIN  
        SELECT @IDOrigen = ID FROM TMA WHERE Origen = @Mov AND OrigenID = @MovID AND Empresa = @Empresa  
        UPDATE TMA SET FechaFin = GETDATE() WHERE ID = @IDOrigen                    
        UPDATE TMA SET FechaFin = GETDATE(), FechaInicio = (SELECT FechaFin FROM TMA WHERE ID = @IDOrigen) WHERE ID = @ID  
      END  
    END   
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000  
      EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT  
    IF @Accion = 'CANCELAR' AND @EstatusNuevo = 'CANCELADO' AND @Ok IS NULL  
	begin
      EXEC spCancelarFlujo @Empresa, @Modulo, @ID, @Ok OUTPUT   
	end

  IF @Conexion = 0  
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000  
      COMMIT TRANSACTION  
    ELSE  
      ROLLBACK TRANSACTION        
  RETURN  

END
GO

/**************** spTMA ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTMA') and type = 'P') drop procedure dbo.spTMA
GO
CREATE PROCEDURE spTMA
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
		   @OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Generar		bit,
    @GenerarAfectado	bit,
    @Sucursal		int,
    @SucursalDestino	int,
    @SucursalOrigen	int,
    @EnLinea		bit,
    @PuedeEditar	bit,
    @Empresa	      	char(5),
    @MovTipo   		char(20),
    @MovMoneda		char(10),
    @MovTipoCambio	float,
    @FechaEmision     	datetime,
    @FechaAfectacion	datetime,
    @FechaConclusion	datetime,
    @Proyecto	      	varchar(50),
    @MovUsuario	      	char(10),
    @Autorizacion     	char(10),
    @DocFuente	      	int,
    @Concepto    	varchar(50),
    @Referencia 	varchar(50),
    @Observaciones    	varchar(255),
    @Estatus          	char(15),
    @EstatusNuevo	char(15),
    @Ejercicio	      	int,
    @Periodo	      	int,
    @Almacen		char(10),
    @Agente		varchar(10),
    @GenerarMovID	varchar(20),
    @GenerarPoliza	bit,
    @CfgContX		bit,
    @CfgContXGenerar	char(20),
    @OrigenTipo			varchar(10),
    @Origen				varchar(20),
    @OrigenID			varchar(20)
	/*@Verificar		bit*/

  -- Inicializar Variables
  SELECT @Generar	   = 0,
	 @GenerarAfectado  = 0,
         @CfgContX         = 0,
         @CfgContXGenerar  = 'NO'/*,
	 @Verificar        = 1*/

  -- Leer Datos Generales del Movimiento
  SELECT @Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, @Empresa = Empresa, @MovID = MovID, @Mov = Mov, @FechaEmision = FechaEmision, @Proyecto = NULLIF(RTRIM(Proyecto), ''),
         @MovUsuario = Usuario, @Autorizacion = Autorizacion, 
         /*@MovMoneda = Moneda, @MovTipoCambio = TipoCambio,*/
         @DocFuente = DocFuente, @Observaciones = Observaciones, @Estatus = UPPER(Estatus), 
         /*@GenerarPoliza = GenerarPoliza, */@FechaConclusion = FechaConclusion,
         @Concepto = Concepto, @Referencia = Referencia,
         @Almacen = NULLIF(RTRIM(Almacen), ''), @Agente = NULLIF(RTRIM(Agente), ''),
		 @OrigenTipo = OrigenTipo, @Origen = Origen, @OrigenID = OrigenID
    FROM TMA
   WHERE ID = @ID
  IF @@ERROR <> 0 SELECT @Ok = 1

  IF NULLIF(RTRIM(@Usuario), '') IS NULL SELECT @Usuario = @MovUsuario
  -- Leer MovTipo, Periodo y Ejercicio	
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

  IF (@Accion <> 'CANCELAR' AND @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'PENDIENTE')) OR 
     (@Accion = 'CANCELAR'  AND @Estatus IN ('CONCLUIDO', 'PENDIENTE'))
  BEGIN
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
  
    IF @Accion = 'CANCELAR' 
      SELECT @EstatusNuevo = 'CANCELADO' 
    ELSE BEGIN
      IF @MovTipo IN ('TMA.SADO', 'TMA.OADO')
        SELECT @EstatusNuevo = 'PENDIENTE' 
      ELSE
        SELECT @EstatusNuevo = 'CONCLUIDO' 
    END

    -- Verificar antes de Afectar
    IF ((@Conexion = 0 OR @Accion = 'CANCELAR') OR (@Conexion = 1 AND @Accion = 'AFECTAR')) AND @Accion NOT IN ('GENERAR', 'CONSECUTIVO'/*, 'SINCRO'*/) AND @Ok IS NULL
    BEGIN
      EXEC spTMAVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @Estatus, @EstatusNuevo, 
          	          @Conexion, @SincroFinal, @Sucursal, 
                          @Almacen, @Agente, 
     		          @Ok OUTPUT, @OkRef OUTPUT

      -- Quitar los mensajes cuando la afectarcion es normal 
      IF @Ok BETWEEN 80000 AND 89999 AND @Accion IN ('AFECTAR', 'CANCELAR') SELECT @Ok = NULL ELSE

      -- Si Verifico y todo estubo bien
      IF @Accion = 'VERIFICAR' AND @Ok IS NULL
      BEGIN
        SELECT @Ok = 80000
        EXEC xpOk_80000 @Empresa, @Usuario, @Accion, @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
      END
    END
   
    IF @Accion IN ('AFECTAR', 'GENERAR', 'CANCELAR','CONSECUTIVO','SINCRO') AND @Ok IS NULL
      EXEC spTMAAfectar @ID, @Accion, @Base, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaAfectacion, @FechaConclusion,
		        @Proyecto, @Usuario, @Autorizacion, @DocFuente, @Observaciones, @Concepto, @Referencia, 
                        @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario,
		        @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @CfgContX, @CfgContXGenerar, @GenerarPoliza,
                        @Generar, @GenerarMov, @GenerarAfectado, @IDGenerar OUTPUT, @GenerarMovID OUTPUT,
                        @Almacen, @Agente, 
                        @Ok OUTPUT, @OkRef OUTPUT

  END ELSE 
  BEGIN
    IF ((@Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR')) OR (@MovTipo = 'TMA.TSUR' AND @Estatus = 'PROCESAR'))  
		AND @Accion = 'CANCELAR' 
		BEGIN
		EXEC spMovCancelarSinAfectar @Modulo, @ID, @Ok OUTPUT 
		IF @Ok IS NULL AND @OrigenTipo = 'TMA' AND @MovTipo = 'TMA.TSUR'
			BEGIN
				UPDATE TMA SET ESTATUS = 'PENDIENTE' WHERE Mov = @Origen AND MovID = @OrigenID
			END
		END
	ELSE
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


--TASK24685
/*****Herramienta Job Surtido ******************/
/**************** spWMSSurtidoProgramarTrabajo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWMSSurtidoProgramarTrabajo') and type = 'P') drop procedure dbo.spWMSSurtidoProgramarTrabajo
GO
CREATE PROC spWMSSurtidoProgramarTrabajo
			@Estacion		int
--//WITH ENCRYPTION
AS
BEGIN
  DELETE WMSSurtidoProcesarTrabajo

  INSERT INTO WMSSurtidoProcesarTrabajo(
             Modulo,   ModuloID) 
    SELECT l.Modulo, l.ID 
      FROM ListaModuloID l
      JOIN WMSSurtidoPosicionTrabajo ON l.Modulo = WMSSurtidoPosicionTrabajo.Modulo AND l.ID = WMSSurtidoPosicionTrabajo.ModuloID
     WHERE l.Estacion = @Estacion

  SELECT 'Proceso Concluido.'
END
GO

/**************** spWMSAsignaPosicionTrabajo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWMSAsignaPosicionTrabajo') and type = 'P') drop procedure dbo.spWMSAsignaPosicionTrabajo
GO
CREATE PROC spWMSAsignaPosicionTrabajo
			@Posicion		varchar(20),
			@Estacion		int
--//WITH ENCRYPTION
AS
BEGIN
  DELETE WMSSurtidoPosicionTrabajo 
    FROM WMSSurtidoPosicionTrabajo 
    JOIN ListaModuloID ON WMSSurtidoPosicionTrabajo.Modulo = ListaModuloID.Modulo AND WMSSurtidoPosicionTrabajo.ModuloID = ListaModuloID.ID
   WHERE Estacion = @Estacion
  
  INSERT INTO WMSSurtidoPosicionTrabajo SELECT Modulo, ID, @Posicion FROM ListaModuloID WHERE Estacion = @Estacion
END
GO

/**************** spWMSSurtidoProcesarTrabajo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWMSSurtidoProcesarTrabajo') and type = 'P') drop procedure dbo.spWMSSurtidoProcesarTrabajo
GO
CREATE PROC spWMSSurtidoProcesarTrabajo
			@Empresa		varchar(5),
			@Usuario		varchar(10)
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Modulo		varchar(5),
		  @ModuloAnt	varchar(5),
          @ModuloID		int,
          @ModuloIDAnt	int,
		  @Posicion		varchar(20),
		  @Estacion		int

  SELECT @Estacion = @@SPID

  SELECT @ModuloAnt = ''
  WHILE(1=1)
  BEGIN
    SELECT @Modulo = MIN(Modulo)
      FROM WMSSurtidoProcesarTrabajo
     WHERE Modulo > @ModuloAnt

    IF @Modulo IS NULL BREAK

    SELECT @ModuloAnt = @Modulo

    SELECT @ModuloIDAnt = 0
    WHILE(1=1)
    BEGIN
      SELECT @ModuloID = MIN(ModuloID)
        FROM WMSSurtidoProcesarTrabajo
       WHERE Modulo = @Modulo
         AND ModuloID > @ModuloIDAnt

      IF @ModuloID IS NULL BREAK

      SELECT @ModuloIDAnt = @ModuloID

      DELETE ListaModuloID WHERE Estacion = @Estacion 
      DELETE ListaSt WHERE Estacion = @Estacion 

      INSERT INTO ListaModuloID(Estacion, Modulo, ID) SELECT @Estacion, @Modulo, @ModuloID

      EXEC spPreparaSurtido @Estacion, @Empresa, @EnSilencio = 1

      SELECT @Posicion = Posicion FROM WMSSurtidoPosicionTrabajo WHERE Modulo = @Modulo AND ModuloID = @ModuloID

      INSERT INTO ListaSt(Estacion, Clave) SELECT @Estacion, Articulo FROM WMSSurtidoProcesarD WHERE Estacion = @Estacion AND Procesado = 0

      EXEC spWMSAsignaPosicion @Posicion, @Estacion

      EXEC spWMSGeneraSurtido @Estacion, @Usuario
    END
  END
END
GO

/**************** spWMSSurtidoCrearJobs ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWMSSurtidoCrearJobs') and type = 'P') drop procedure dbo.spWMSSurtidoCrearJobs
GO             
CREATE PROCEDURE spWMSSurtidoCrearJobs
  @Nombre			varchar(100),
  @BaseDatos        varchar(30),
  @UsuarioI         varchar(30) 
--//WITH ENCRYPTION
AS
  DECLARE
  @TrabajoID        binary (16),
  @ReturnCode       int,
  @Usuario                 varchar(30),
  @Contrasena       varchar(30),
  @Activo                  bit,
  @Trabajo                 char(20),
  @Cadena                  varchar(100),
  @Servidor                varchar(30),   
  @HoraInicial             int,
  @HoraFinal        int,
  @Frecuencia       tinyint,
  @Valor                   tinyint,
  @Recurrencia             tinyint, 
  @FrecuenciaD             tinyint,
  @ValorD                  tinyint,
 
  @Domingo                 bit,
  @Lunes                   bit,
  @Martes                  bit,
  @Miercoles        bit,
  @Jueves                  bit,
  @Viernes                 bit,
  @Sabado                  bit,
  @Valor2                  tinyint,
  @Tipo                           tinyint,
  @Dia                     tinyint,
  @Fecha2                  int,
 
  @Estatus                 bit,
 
  @spSucursal       int,
  @spEmpresa        varchar(5),
  @spUsuario        varchar(30),
  @spFecha                 datetime,
  @NombreOriginal   varchar(100),
  @Procesar                varchar(30)
 
  BEGIN TRANSACTION
    DECLARE @SQLServerAgent TABLE
    (
    Estatus                       varchar(50)
    )
 
    SELECT @NombreOriginal = ISNULL(@Nombre,'')
    SELECT @Nombre = ISNULL(@Nombre,'') + '.' + @@SERVERNAME + '.' + @BaseDatos
    SELECT @ReturnCode = 0    
    IF (SELECT COUNT(*) FROM msdb.dbo.syscategories WHERE name = '[Uncategorized (Local)]') < 1
      EXECUTE msdb.dbo.sp_add_category @name = '[Uncategorized (Local)]'
   
    SELECT @TrabajoID = job_id FROM   msdb.dbo.sysjobs WHERE (name = @Nombre)
    IF (@TrabajoID IS NOT NULL)   
    BEGIN 
       IF (EXISTS (SELECT  * FROM    msdb.dbo.sysjobservers WHERE   (job_id = @TrabajoID) AND (server_id <> 0)))
         BEGIN
            RAISERROR ('Unable to import job ''Procesar Explosiones'' since there is already a multi-server job with this name.', 16, 1)
            SELECT @ReturnCode = 1    
         END
       ELSE
         EXECUTE msdb.dbo.sp_delete_job @job_name = @Nombre
      SELECT @TrabajoID = NULL
    END
 
 
  IF (@@ERROR = 0 AND @ReturnCode = 0) AND EXISTS(SELECT * FROM WMSSurtidoTrabajo WHERE Trabajo = @NombreOriginal)
  BEGIN
    IF @ReturnCode = 0
      EXECUTE @ReturnCode = msdb.dbo.sp_add_job @job_id = @TrabajoID OUTPUT , @job_name = @Nombre, @owner_login_name = @Usuario, @description =  @Nombre, @category_name = '[Uncategorized (Local)]', @enabled = 1, @notify_level_email = 0, @notify_level_page = 0, @notify_level_netsend = 0, @notify_level_eventlog = 2, @delete_level= 0
 
       DECLARE crTrabajo SCROLL CURSOR FOR
       SELECT Trabajo, Usuario, Contrasena, CONVERT(int, SUBSTRING(HoraInicial,1,2) + SUBSTRING(HoraInicial,4,2) + '00'), CONVERT(int, SUBSTRING(HoraFinal,1,2) + SUBSTRING(HoraFinal,4,2) + '00'), CASE Frecuencia WHEN 'Diaria' THEN 4 WHEN 'Semanal' THEN 8 WHEN 'Mensual' THEN 16 WHEN 'Mensual 2' THEN 32 END, Valor, Recurrencia, CASE FrecuenciaD WHEN 'Minutos' THEN 4 WHEN 'Horas' THEN 8 END , ValorD, Activo, Domingo, Lunes, Martes, Miercoles, Jueves, Viernes, Sabado, CASE Tipo WHEN 'Primer' THEN 1 WHEN 'Segundo' THEN 2 WHEN 'Tercer' THEN 4 WHEN 'Cuarto' THEN 8 WHEN 'Ultimo' THEN 16 END, CASE Dia WHEN 'Domingo' THEN 1 WHEN 'Lunes' THEN 2 WHEN 'Martes' THEN 3 WHEN 'Miercoles' THEN 4 WHEN 'Jueves' THEN 5 WHEN 'Viernes' THEN 6 WHEN 'Sabado' THEN 7 WHEN 'Día' THEN 8 WHEN 'Día de la semana' THEN 9 WHEN 'Día del fin de semana' THEN 10 END, CONVERT(int, CONVERT(varchar,DATEPART(YEAR,FechaInicial)) + dbo.fnRellenarCerosIzquierda(CONVERT(varchar,DATEPART(MONTH,FechaInicial)),2) + dbo.fnRellenarCerosIzquierda(CONVERT(varchar,DATEPART(DAY,FechaInicial)),2)), spSucursal, spEmpresa, spUsuario, GETDATE(), ISNULL(Procesar,'')
         FROM WMSSurtidoTrabajo
       WHERE Trabajo = @NombreOriginal
      
       IF ISNULL(@Contrasena,'') = ''
             SELECT @Contrasena = 'NULL'
 
       OPEN crTrabajo
 
       FETCH NEXT FROM crTrabajo INTO @Trabajo, @Usuario, @Contrasena, @HoraInicial, @HoraFinal, @Frecuencia, @Valor, @Recurrencia, @FrecuenciaD, @ValorD, @Activo, @Domingo, @Lunes, @Martes, @Miercoles, @Jueves, @Viernes, @Sabado, @Tipo, @Dia, @Fecha2, @spSucursal, @spEmpresa, @spUsuario, @spFecha, @Procesar
 
       WHILE @@FETCH_STATUS = 0 AND @ReturnCode = 0
       BEGIN
--select @Frecuencia = 32
         SELECT @Valor2 = 0
      IF @Frecuencia = 8
      BEGIN
        IF @Domingo = 1
          SELECT @Valor2 = @Valor2 + 1
       
        IF @Lunes = 1
          SELECT @Valor2 = @Valor2 + 2
       
        IF @Martes = 1
          SELECT @Valor2 = @Valor2 + 4
       
        IF @Miercoles = 1
          SELECT @Valor2 = @Valor2 + 8
        
        IF @Jueves = 1
          SELECT @Valor2 = @Valor2 + 16
       
        IF @Viernes = 1
          SELECT @Valor2 = @Valor2 + 32
       
        IF @Sabado = 1
          SELECT @Valor2 = @Valor2 + 64
     
        SELECT @Valor = @Valor2
      END
 
      ELSE
      IF @Frecuencia = 32
        SELECT @Valor = @Dia
 
         IF @Procesar = 'Procesar Explosiones'
           SET @cadena     = 'EXEC spWMSSurtidoProcesarTrabajo ' + '''' + RTRIM(@spEmpresa) + '''' + ', ' + '''' + RTRIM(@spUsuario) + ''''
 
--       select @Cadena
 
         EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @TrabajoID, @step_id = 1, @step_name = @Trabajo, @command = @cadena, @database_name = @BaseDatos, @server = '', @database_user_name = '', @subsystem = 'TSQL', @cmdexec_success_code = 0, @flags = 0, @retry_attempts = 0, @retry_interval = 1, @output_file_name = '', @on_success_step_id = 0, @on_success_action = 1, @on_fail_step_id = 0, @on_fail_action = 2
 
         UPDATE WMSSurtidoTrabajo SET UltimaActualizacion = GETDATE() WHERE Trabajo = @Trabajo
        
         FETCH NEXT FROM crTrabajo INTO  @Trabajo, @Usuario, @Contrasena, @HoraInicial, @HoraFinal, @Frecuencia, @Valor, @Recurrencia, @FrecuenciaD, @ValorD, @Activo, @Domingo, @Lunes, @Martes, @Miercoles, @Jueves, @Viernes, @Sabado, @Tipo, @Dia, @Fecha2, @spSucursal, @spEmpresa, @spUsuario, @spFecha, @Procesar
       END
 
    IF @ReturnCode = 0 EXECUTE @ReturnCode = msdb.dbo.sp_update_job @job_id = @TrabajoID, @start_step_id = 1, @enabled  = @Activo
 
    IF @ReturnCode = 0 EXECUTE @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @TrabajoID, @name = @Nombre, @enabled = @Activo, @freq_type = @Frecuencia, @active_start_date = @Fecha2, @active_start_time = @HoraInicial, @freq_interval = @Valor, @freq_subday_type = @FrecuenciaD , @freq_subday_interval = @ValorD, @freq_relative_interval = @Tipo, @freq_recurrence_factor = @Recurrencia, @active_end_date = 99991231, @active_end_time = @HoraFinal
 
    IF @ReturnCode = 0 EXECUTE @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @TrabajoID, @server_name = @@SERVERNAME
 
  CLOSE crTrabajo
  DEALLOCATE crTrabajo
--select @ReturnCode = 1
  END 
  INSERT @SQLServerAgent (Estatus)
  EXEC master.dbo.xp_ServiceControl 'QUERYSTATE', 'SQLServerAgent'
 
  IF (SELECT TOP 1 Estatus FROM @SQLServerAgent) = 'Running.' SELECT @Estatus = 1 ELSE SELECT @Estatus = 0
 
  IF @ReturnCode = 0
  BEGIN
    IF @Estatus = 1 SELECT 'Proceso terminado.' ELSE SELECT 'Favor de verificar el servicio del Agente SQL Server para la ejecución del trabajo.'
    COMMIT TRANSACTION
  END
  ELSE
  BEGIN
    IF @Estatus = 1 SELECT 'Proceso terminado.' ELSE SELECT 'Favor de verificar el servicio del Agente SQL Server para la ejecución del trabajo.'
    ROLLBACK TRANSACTION
  END
GO
--TASK25106
/**************** spGenerarCompraLoteLista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarCompraLoteLista') and type = 'P') drop procedure dbo.spGenerarCompraLoteLista
GO
CREATE PROCEDURE spGenerarCompraLoteLista
		   @Estacion		int,
		   @Empresa			char(5),
		   @Modulo			char(5),
           @Accion			char(20),
		   @Base			char(20),
           @GenerarMov		char(20),
		   @Usuario			char(10),		  
		   @FacturarLote	varchar(20) 	= 'Movimiento',
		   @Conexion		bit				= 0,
		   @Afectar			bit				= 0,
            --BUG24764
           @IDConsecutivo   int             = NULL	OUTPUT,
		   @Ok				int	 	        = NULL	OUTPUT,
		   @OkRef			varchar(255)	= NULL	OUTPUT

--//WITH ENCRYPTION
AS BEGIN
DECLARE 
  @Elimino			int,
  @ID				int,
  @IDGenerar		int,
--  @Ok				int,
--  @OkRef			varchar(255),
  @Mensaje			varchar(255),
  @MovTipo			varchar(20),
  @GenerarMovTipo	varchar(20),
  @Continuar		bit,
  @Sucursal			int,
  @Proveedor		char(10),
  @Condicion		varchar(50),
  @Vencimiento		datetime,
  @DescuentoGlobal	float,
  @Renglon			float,
  @OrigenTipo		varchar(5),
  @Origen			varchar(20),
  @OrigenID			varchar(20),

  @StrSQL             nvarchar(max)

  SELECT @GenerarMovTipo = Clave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @GenerarMov
  DELETE ListaIDOk WHERE Estacion = @Estacion

  SELECT v.OrigenTipo, v.Origen, v.OrigenID
    INTO #Origen
    FROM ListaID l, Compra v, MovTipo mt
   WHERE l.Estacion = @Estacion AND v.ID = l.ID AND v.Empresa = @Empresa AND mt.Modulo = @Modulo AND mt.Mov = v.Mov
   GROUP BY v.OrigenTipo, v.Origen, v.OrigenID

  IF(SELECT COUNT(*) FROM #Origen) > 1
  BEGIN
    SELECT 'Los Movimientos seleccionados provienen de distintas Ordenes de Compra'
    RETURN
  END

  SELECT @OrigenTipo = OrigenTipo, @Origen = Origen, @OrigenID = OrigenID FROM #Origen

  IF @FacturarLote = 'Proveedor'
  BEGIN  
    DECLARE crListaProv CURSOR FOR
     SELECT mt.Clave, v.Sucursal, v.Proveedor, v.Condicion, v.DescuentoGlobal, MIN(l.ID)
       FROM ListaID l, Compra v, MovTipo mt
      WHERE l.Estacion = @Estacion AND v.ID = l.ID AND v.Empresa = @Empresa AND mt.Modulo = @Modulo AND mt.Mov = v.Mov
      GROUP BY mt.Clave, v.Sucursal, v.Proveedor, v.Condicion, v.DescuentoGlobal
      ORDER BY mt.Clave, v.Sucursal, v.Proveedor, v.Condicion, v.DescuentoGlobal
    OPEN crListaProv
    FETCH NEXT FROM crListaProv INTO @MovTipo, @Sucursal, @Proveedor, @Condicion, @DescuentoGlobal, @ID
    WHILE @@FETCH_STATUS <> -1 
      BEGIN
      IF @@FETCH_STATUS <> -2
      BEGIN
        SELECT @Continuar = 1
        IF @GenerarMovTipo = 'COMS.F'
          IF (SELECT mt.Clave FROM Compra v, MovTipo mt WHERE v.ID = @ID AND mt.Modulo = 'COMS' AND mt.Mov = v.Mov) NOT IN ('COMS.O')
            SELECT @Continuar = 0

        IF @Continuar = 1
        BEGIN

          SELECT @IDGenerar = NULL
          EXEC @IDGenerar = spAfectar @Modulo, @ID, @Accion, @Base, @GenerarMov, @Usuario, 0, 1, @Ok OUTPUT, @OkRef OUTPUT

          UPDATE Compra SET OrigenTipo = @OrigenTipo, Origen = @Origen, OrigenID = @OrigenID WHERE ID = @IDGenerar
          
          IF @Ok = 80030 
          BEGIN
            SELECT @Renglon = ISNULL(MAX(Renglon), 0) FROM CompraD WHERE ID = @IDGenerar
            SELECT * INTO #CompraDetalleLote FROM cCompraD WHERE ID IN (SELECT l.ID FROM ListaID l, Compra v WHERE l.Estacion = @Estacion AND v.ID <> @ID AND v.ID = l.ID AND v.Empresa = @Empresa AND v.Sucursal = @Sucursal AND v.Proveedor = @Proveedor AND v.Condicion = @Condicion AND v.DescuentoGlobal = @DescuentoGlobal)

            IF EXISTS(SELECT * FROM #CompraDetalleLote)
            BEGIN
              UPDATE #CompraDetalleLote SET @Renglon = Renglon = @Renglon + 2048.0, Aplica = v.Mov, AplicaID = v.MovID FROM #CompraDetalleLote d, Compra v WHERE v.ID = d.ID

              IF @Base = 'TODO'      UPDATE #CompraDetalleLote SET ID = @IDGenerar, CantidadPendiente = NULL, CantidadCancelada = NULL, CantidadA = NULL ELSE
              IF @Base = 'SELECCION' UPDATE #CompraDetalleLote SET ID = @IDGenerar, Cantidad = CantidadA, CantidadInventario = CantidadA * CantidadInventario / Cantidad, CantidadPendiente = NULL, CantidadCancelada = NULL, CantidadA = NULL ELSE
              IF @Base = 'PENDIENTE' UPDATE #CompraDetalleLote SET ID = @IDGenerar, Cantidad = NULLIF(ISNULL(CantidadPendiente,0.0), 0.0), CantidadInventario = (NULLIF(ISNULL(CantidadPendiente,0.0), 0.0)) * CantidadInventario / Cantidad, CantidadPendiente = NULL, CantidadCancelada = NULL, CantidadA = NULL
              IF @@ERROR <> 0 SELECT @Ok = 1
              UPDATE #CompraDetalleLote SET Sucursal = @Sucursal, SucursalOrigen = @Sucursal
              IF @@ERROR <> 0 SELECT @Ok = 1
              DELETE #CompraDetalleLote WHERE Cantidad IS NULL OR Cantidad = 0.0
              IF @@ERROR <> 0 SELECT @Ok = 1
              INSERT INTO cCompraD SELECT * FROM #CompraDetalleLote
              IF @@ERROR <> 0 SELECT @Ok = 1
            END
            DROP TABLE #CompraDetalleLote
            IF @@ERROR <> 0 SELECT @Ok = 1

            IF @Ok IN (NULL, 80030) --AND @Afectar = 1 --BUG24764
              EXEC spAfectar @Modulo, @IDGenerar, 'CONSECUTIVO', 'TODO', NULL, @Usuario, @Conexion, 1, @Ok OUTPUT, @OkRef OUTPUT
            
			  
            SELECT @Elimino = 0

            IF @Ok NOT IN (NULL, 80030, 80060)
              EXEC @Elimino = spEliminarMov @Modulo, @IDGenerar
            IF @Elimino = 0 SELECT @ID = @IDGenerar
          END
          INSERT ListaIDOK (Estacion, ID, Empresa, Modulo, Ok, OkRef) VALUES (@Estacion, @ID, @Empresa, @Modulo, @Ok, @OkRef)
        END    
      END
      FETCH NEXT FROM crListaProv INTO @MovTipo, @Sucursal, @Proveedor, @Condicion, @DescuentoGlobal, @ID
    END
    CLOSE crListaProv
    DEALLOCATE crListaProv
  END 

  IF @Ok IN (NULL, 80030, 80060) --BUG24764
   BEGIN
    SELECT @Mensaje = CONVERT(varchar(max), @IDGenerar) 
    SET @IDConsecutivo=@IDGenerar
   END
  ELSE
    SELECT @Mensaje = Descripcion+' '+RTRIM(@OkRef) 
      FROM MensajeLista
     WHERE Mensaje = @Ok  

  --BUG24764
  IF @Afectar=0
    SELECT @Mensaje 
  RETURN
END
GO
--TASK25160
--BUG25090
/**************** spWMSCambioDomicilio ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWMSCambioDomicilio') and type = 'P') drop procedure dbo.spWMSCambioDomicilio
GO             
CREATE PROC spWMSCambioDomicilio
			@Almacen			varchar(10),
			@PosicionActual		varchar(10),
			@PosicionNueva		varchar(10)
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Articulo			varchar(20),
          @ArticuloEsp		varchar(20),
		  @Ok				int,
		  @OkRef			varchar(255),
		  @Tarima			varchar(20),
		  @TipoActual		varchar(20),
		  @TipoDestino		varchar(20)

  BEGIN TRANSACTION
  
  SELECT @ArticuloEsp = ISNULL(ArticuloEsp, ''), @TipoDestino = Tipo FROM AlmPos WHERE Almacen = @Almacen AND Posicion = @PosicionNueva
  SELECT @Articulo = ISNULL(ArticuloEsp, ''), @TipoActual = Tipo  FROM AlmPos WHERE Almacen = @Almacen AND Posicion = @PosicionActual  

  IF @Ok IS NULL AND ISNULL(RTRIM(@PosicionActual), '') = ''
    SELECT @Ok = 1, @OkRef = 'Favor de Especificar el Domicilio Origen'
  
  IF @Ok IS NULL AND ISNULL(RTRIM(@PosicionNueva), '') = ''
    SELECT @Ok = 1, @OkRef = 'Favor de Especificar el Domicilio Destino' 
  
  IF @Ok IS NULL AND @ArticuloEsp <> '' AND @ArticuloEsp <> @Articulo
    SELECT @Ok = 1, @OkRef = 'El Domicilio Destino(' + ISNULL(@PosicionNueva, '')+') esta reservado para el Artículo ' + @ArticuloEsp 

  IF @Ok IS NULL AND @TipoActual <> 'Domicilio'
    SELECT @Ok = 1, @OkRef = 'La Posición Origen no es Domicilio'

  IF @Ok IS NULL AND @TipoDestino <> 'Domicilio'
    SELECT @Ok = 1, @OkRef = 'La Posición Destino no es Domicilio'    
    
  IF @Ok IS NULL AND @PosicionActual = @PosicionNueva
    SELECT @Ok = 1, @OkRef = 'La Posición Destino es igual a la Posición Origen'        
    
  IF @Ok IS NULL
  BEGIN
    UPDATE AlmPos SET CambioDomicilios = 1 WHERE Almacen = @Almacen AND Posicion IN(@PosicionActual, @PosicionNueva)
    
    UPDATE Tarima SET Posicion = @PosicionNueva WHERE Almacen = @Almacen AND Posicion = @PosicionActual

    UPDATE AlmPos SET ArticuloEsp = @Articulo WHERE Almacen = @Almacen AND Posicion = @PosicionNueva
    
    UPDATE AlmPos SET ArticuloEsp = NULL WHERE Almacen = @Almacen AND Posicion = @PosicionActual    
    
    UPDATE AlmPos SET CambioDomicilios = NULL WHERE Almacen = @Almacen AND Posicion IN(@PosicionActual, @PosicionNueva)
  END

  IF @Ok IS NULL
  BEGIN
    SELECT 'Proceso Concluido'
    
    COMMIT TRANSACTION
  END
  ELSE
  BEGIN
    SELECT @OkRef
    
    ROLLBACK TRANSACTION
  END
  RETURN
END
GO

--BUG24180
/**************** spTarimaTransitoC ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTarimaTransitoC') and type = 'P') drop procedure dbo.spTarimaTransitoC
GO       
CREATE PROC spTarimaTransitoC
			@Tarima				varchar(20),
			@TarimaTransito		varchar(20) OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  IF NOT EXISTS(SELECT ID FROM TarimaTransitoC WITH(ROWLOCK) WHERE Tarima = @Tarima)
  BEGIN
    SELECT @TarimaTransito = RTRIM(@Tarima) + '-1'
    
    INSERT INTO TarimaTransitoC(Tarima, Consecutivo) SELECT @Tarima, 2
  END
  ELSE
  BEGIN
    SELECT @TarimaTransito = RTRIM(@Tarima) + '-' + CONVERT(varchar(max), ISNULL(Consecutivo, 1)) FROM TarimaTransitoC WITH(ROWLOCK) WHERE Tarima = @Tarima
    
    UPDATE TarimaTransitoC WITH(ROWLOCK) SET Consecutivo = Consecutivo + 1 FROM TarimaTransitoC WHERE Tarima = @Tarima
  END
  
  RETURN
END
GO
--BUG24180
/**************** spTMAActualizarTarimaTransito ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTMAActualizarTarimaTransito') and type = 'P') drop procedure dbo.spTMAActualizarTarimaTransito
GO       
CREATE PROC spTMAActualizarTarimaTransito 
			@ID				int, 
			@MovTipo		varchar(20)
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Tarima			varchar(20),
		  @TarimaAnt		varchar(20),
		  @TarimaSurtido	varchar(20)
		  
  IF @MovTipo <> 'TMA.OSUR' RETURN
  
  SELECT @TarimaAnt = ''
  WHILE(1=1)
  BEGIN
    SELECT @Tarima = MIN(Tarima)
      FROM TMAD
     WHERE ID = @ID
       AND Tarima > @TarimaAnt

    IF @Tarima IS NULL BREAK
    
    SELECT @TarimaAnt = @Tarima, @TarimaSurtido = NULL
    
    IF (SELECT a.Tipo
          FROM Tarima t
          JOIN AlmPos a
		    ON t.Almacen = a.Almacen
		   AND t.Posicion = a.Posicion
		   AND t.Tarima = @Tarima) = 'Domicilio'
    BEGIN
      EXEC spTarimaTransitoC @Tarima, @TarimaSurtido OUTPUT
    
      UPDATE TMAD SET Tarima = @TarimaSurtido WHERE ID = @ID AND Tarima = @Tarima
    END
  END
END
GO

/************************************* spWMSActualizarTarima ****************/
--TASK2429PGC
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spWMSActualizarTarima') AND Type = 'P') 
DROP PROCEDURE dbo.spWMSActualizarTarima
GO             
CREATE PROCEDURE spWMSActualizarTarima
		@Estacion		int,
        @Almacen        varchar(20),
        @Articulo       varchar(20),
        @SubCuenta      varchar(50),
        @PosicionOrigen varchar(20),
		@Tipo           varchar(20),
		@CantidadTarima float,
        @Tarima         varchar(20)

--//WITH ENCRYPTION
AS BEGIN

 DECLARE @Disponible float

  SELECT Disponible=NULL

  SELECT TOP 1 
     @Disponible	= ISNULL(adt.Disponible  ,0)
   FROM ArtDisponibleTarima adt  
   JOIN Tarima t ON adt.Almacen =t.Almacen AND adt.Tarima = t.Tarima  
   JOIN AlmPos ap ON t.Almacen = ap.Almacen AND t.Posicion = ap.Posicion  
  WHERE adt.Almacen = @Almacen
    AND adt.Articulo = @Articulo
    AND ap.Tipo = @Tipo
    AND adt.Tarima = @Tarima
    AND t.SubCuenta=@SubCuenta --TASK2429PGC
    AND ap.SubCuenta=t.SubCuenta --TASK2429PGC
	  
  IF @Disponible=@CantidadTarima
    UPDATE WMSSurtidoProcesarD
     SET Tarima = @Tarima --, CantidadTarima=@Disponible, CantidadUnidad=@Disponible
   WHERE Estacion = @Estacion
     AND Articulo = @Articulo
	 AND ISNULL(SubCuenta, '') = ISNULL(ISNULL(@SubCuenta, SubCuenta), '') 
     AND PosicionOrigen = @PosicionOrigen
	 AND Tipo     = @Tipo
	 AND CantidadTarima = @CantidadTarima
  ELSE
    SELECT 'Favor de Seleccionar una Tarima Válida!' 

  RETURN
END
GO
--UserStory4417
/************************************* spWMSActualizarPosicionSurtido ****************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spWMSHerramientaActualizarPosicionSurtido') AND Type = 'P') DROP PROCEDURE dbo.spWMSHerramientaActualizarPosicionSurtido
GO             
CREATE PROCEDURE spWMSHerramientaActualizarPosicionSurtido
		@Posicion       varchar(20),
		@Estacion		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID				int,
    @Modulo			varchar(5)
    
   
  DECLARE crListaModuloID CURSOR FOR
   SELECT Modulo, ID
     FROM ListaModuloID
    WHERE Estacion = @Estacion

  OPEN crListaModuloID
  FETCH NEXT FROM crListaModuloID INTO @Modulo, @ID
  WHILE @@FETCH_STATUS = 0 --AND @Ok IS NULL
  BEGIN
   
    IF @Modulo='VTAS'
	    UPDATE Venta SET PosicionWMS=@Posicion WHERE ID=@ID
	ELSE
	  IF @Modulo='COMS'
	    UPDATE Compra SET PosicionWMS=@Posicion WHERE ID=@ID
	  ELSE
	     IF @Modulo='INV'
	       UPDATE Inv SET PosicionWMS=@Posicion WHERE ID=@ID
            
    FETCH NEXT FROM crListaModuloID INTO @Modulo, @ID
  END
  CLOSE crListaModuloID
  DEALLOCATE crListaModuloID  
END
GO
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE TYPE='P' AND ID=OBJECT_ID('dbo.spWMSTarimaCambioEstatus'))
DROP PROCEDURE dbo.spWMSTarimaCambioEstatus
GO
CREATE PROCEDURE dbo.spWMSTarimaCambioEstatus
@Empresa CHAR(5),
@Sucursal INT,
@Usuario CHAR(10),
@Almacen VARCHAR(10),
@Tarima VARCHAR(20),
@Tipo VARCHAR(20),
@EstatusNuevo VARCHAR(15)
--//WITH ENCRYPTION
AS
BEGIN

DECLARE 
@Estatus VARCHAR(15),
@EstatusActual VARCHAR(15),
@EstatusControlCalidad VARCHAR(15),
@FechaRegistro DATETIME

SELECT @FechaRegistro=GETDATE()

SELECT @Estatus=Estatus 
	FROM WMSEstatusControlCalidad 
	WHERE EstatusControlCalidad=@EstatusNuevo

SELECT @EstatusActual=Estatus, @EstatusControlCalidad=EstatusControlCalidad 
	FROM Tarima 
	WHERE Tarima=@Tarima AND Almacen=@Almacen

IF @Estatus NOT IN ('ALTA', 'BAJA')
RETURN

IF @EstatusNuevo NOT IN (SELECT EstatusControlCalidad FROM WMSEstatusControlCalidad WHERE NULLIF(LTRIM(RTRIM(EstatusControlCalidad)),'') IS NOT NULL)
RETURN

IF @Tipo<>'Ubicacion'
	RETURN
ELSE
IF @EstatusControlCalidad=@EstatusNuevo
	RETURN
ELSE
	BEGIN
		UPDATE Tarima SET Estatus=@Estatus, EstatusControlCalidad=@EstatusNuevo 
		WHERE Almacen=@Almacen 
		AND Tarima=@Tarima 
		
		INSERT INTO WMSTarmiaCambioHist(Empresa, Sucursal, Ejercicio, Periodo, FechaRegistro, Usuario, Tarima, Almacen, Estatus, EstatusNuevo, EstatusControlCalidad)
		SELECT @Empresa, @Sucursal, YEAR(@FechaRegistro), MONTH(@FechaRegistro), @FechaRegistro, @Usuario, @Tarima, @Almacen, @EstatusActual, @EstatusNuevo, @Estatus
	END
END
GO
/**************** spSurtidoPendienteDetalle ****************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'spSurtidoPendienteDetalle' AND type = 'P') DROP PROCEDURE spSurtidoPendienteDetalle
GO
CREATE PROCEDURE spSurtidoPendienteDetalle
	@Estacion			int,
	@Empresa			varchar(5),
	@Artículo			varchar(20)
--//WITH ENCRYPTION
AS
BEGIN
	DECLARE
		@crModulo	varchar(5)	,
		@crClave	varchar(20)	,
		@crSubClave	varchar(20)
	
	DECLARE @SurtidoPendienteD as Table(Mov			varchar(20),
										MovID		varchar(20),
										Estatus		varchar(15),
										Almacen		varchar(10),
										Articulo	varchar(20),
										Tarima		varchar(20),
										Cantidad	float)
	
	DECLARE CrModuloMov CURSOR FOR
		SELECT Modulo, Clave, Subclave FROM WMSModuloMovimiento
		
	OPEN CrModuloMov
	FETCH NEXT FROM CrModuloMov INTO @crModulo, @crClave, @crSubClave
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @crModulo = 'COMS'
			INSERT @SurtidoPendienteD(Mov, MovID, Estatus, Almacen, 
									  Articulo, Tarima, Cantidad)
			SELECT ISNULL(D.Mov,A.Mov) Mov, ISNULL(D.MovID,A.MovID) MovID, ISNULL(D.Estatus,A.Estatus) Estatus, ISNULL(C.Almacen, E.Almacen) Almacen, 
				   ISNULL(E.Articulo, C.Articulo) Articulo, ISNULL(E.Tarima, C.Tarima) Tarima, ISNULL(E.CantidadPendiente, C.CantidadTarima) Cantidad
			  FROM Compra A
			  JOIN MovTipo B
				ON B.Modulo = @crModulo
			   AND A.Mov = B.Mov
			   AND B.Clave = @crClave
			   AND ISNULL(B.SubClave,'') = ISNULL(@crSubClave,'')
		 LEFT JOIN WMSSurtidoProcesarD C
				ON C.Modulo = B.Modulo
			   AND C.ModuloID = A.ID
			   AND C.Procesado = 0
		 LEFT JOIN TMA D
				ON D.OrigenTipo = B.Modulo
			   AND D.Origen = A.Mov
			   AND D.OrigenID = A.MovID 
			   AND D.Estatus IN ('PENDIENTE')
		 LEFT JOIN TMAD E
				ON E.ID = D.ID
			 WHERE ISNULL(C.Articulo, E.Articulo) = @Artículo
			   AND A.Empresa = @Empresa
	
		IF @crModulo = 'INV'
			INSERT @SurtidoPendienteD(Mov, MovID, Estatus, Almacen, 
									  Articulo, Tarima, Cantidad)
			SELECT ISNULL(D.Mov,A.Mov) Mov, ISNULL(D.MovID,A.MovID) MovID, ISNULL(D.Estatus,A.Estatus) Estatus, ISNULL(C.Almacen, E.Almacen) Almacen, 
				   ISNULL(C.Articulo, E.Articulo) Articulo, ISNULL(C.Tarima, E.Tarima) Tarima, ISNULL(C.CantidadTarima, E.CantidadPendiente) Cantidad
			  FROM INV A
			  JOIN MovTipo B
				ON B.Modulo = @crModulo
			   AND A.Mov = B.Mov
			   AND B.Clave = @crClave
			   AND ISNULL(B.SubClave,'') = ISNULL(@crSubClave,'')
		 LEFT JOIN WMSSurtidoProcesarD C
				ON C.Modulo = B.Modulo
			   AND C.ModuloID = A.ID
			   AND C.Estacion = @Estacion
			   AND C.Procesado = 0
		 LEFT JOIN TMA D
				ON D.OrigenTipo = B.Modulo
			   AND D.Origen = A.Mov
			   AND D.OrigenID = A.MovID 
			   AND D.Estatus IN ('PENDIENTE')
		 LEFT JOIN TMAD E
				ON E.ID = D.ID
			 WHERE ISNULL(C.Articulo, E.Articulo) = @Artículo	
			   AND A.Empresa = @Empresa

		IF @crModulo = 'VTAS'
			INSERT @SurtidoPendienteD(Mov, MovID, Estatus, Almacen, 
									  Articulo, Tarima, Cantidad)
			SELECT ISNULL(D.Mov,A.Mov) Mov, ISNULL(D.MovID,A.MovID) MovID, ISNULL(D.Estatus,A.Estatus) Estatus, ISNULL(C.Almacen, E.Almacen) Almacen, 
				   ISNULL(C.Articulo, E.Articulo) Articulo, ISNULL(C.Tarima, E.Tarima) Tarima, ISNULL(C.CantidadTarima, E.CantidadPendiente) Cantidad
			  FROM Venta A
			  JOIN MovTipo B
				ON B.Modulo = @crModulo
			   AND A.Mov = B.Mov
			   AND B.Clave = @crClave
			   AND ISNULL(B.SubClave,'') = ISNULL(@crSubClave,'')
		 LEFT JOIN WMSSurtidoProcesarD C
				ON C.Modulo = B.Modulo
			   AND C.ModuloID = A.ID
			   AND C.Estacion = @Estacion
			   AND C.Procesado = 0
		 LEFT JOIN TMA D
				ON D.OrigenTipo = B.Modulo
			   AND D.Origen = A.Mov
			   AND D.OrigenID = A.MovID 
			   AND D.Estatus IN ('PENDIENTE')
		 LEFT JOIN TMAD E
				ON E.ID = D.ID
			 WHERE ISNULL(C.Articulo, E.Articulo) = @Artículo
			   AND A.Empresa = @Empresa		
		FETCH NEXT FROM CrModuloMov INTO @crModulo, @crClave, @crSubClave
	END
	
	CLOSE CrModuloMov
	DEALLOCATE CrModuloMov
	
	SELECT * FROM @SurtidoPendienteD

END
GO

/****************************************   spWMSPedidosPendientes   *************************************************/
IF EXISTS(SELECT * FROM SysObjects WHERE name = 'spWMSPedidosPendientes' AND type = 'P') DROP PROCEDURE spWMSPedidosPendientes
GO
CREATE PROCEDURE spWMSPedidosPendientes
		@Estacion	int,
		@Empresa	varchar(5)

--//WITH ENCRYPTION
AS 
BEGIN
	DECLARE
		@CrID			int,
		@CrModulo		varchar(5),
		@CrMov			varchar(20),
		@CrMovID		varchar(20),
		@CrArticulo		varchar(20),
		@CrRenglonID	int
		
	DECLARE @Pedidos AS TABLE(Estacion			int				NOT NULL,
							  Empresa			varchar(5)		NOT NULL,
							  Modulo			varchar(5)		NOT NULL,
							  ID				int				NOT NULL,
							  Mov				varchar(20)		NOT NULL,
							  MovID				varchar(20)		NOT NULL,
							  RenglonID			int				NOT NULL,
							  Sucursal			int				NOT NULL,
							  Almacen			varchar(10)		NOT NULL,
							  Articulo			varchar(20)		NOT NULL,
							  SubCuenta			varchar(50)		NOT NULL,
							  CantidadPicking	float			NOT NULL,
							  Tarima			varchar(20)		NOT NULL)
	
	INSERT @Pedidos(Estacion, Empresa, Modulo, ID, Mov, MovID, RenglonID, Sucursal,
					Almacen, Articulo, SubCuenta, CantidadPicking, Tarima)
			 SELECT @Estacion, A.Empresa, 'VTAS' Modulo, A.ID, A.Mov, A.MovID, B.RenglonID, A.Sucursal,
					A.Almacen, B.Articulo, ISNULL(B.Subcuenta,''), B.CantidadPendiente, B.Tarima
			   FROM Venta A
			   JOIN VentaD B
				 ON A.ID = B.ID
			   JOIN Alm C
				 ON A.Almacen = C.Almacen
				AND C.WMS = 1
			   JOIN Art D
				 ON B.Articulo = D.Articulo	
			   JOIN MovTipo E
			     ON E.Modulo = 'VTAS'
				AND A.Mov = E.Mov
			  WHERE A.Estatus = 'PENDIENTE'
				AND A.Empresa = @Empresa
				AND B.Tarima IS NOT NULL
				AND E.Clave NOT IN ('VTAS.VCR')

	INSERT @Pedidos(Estacion, Modulo, ID,  Mov, MovID, RenglonID, Empresa, Sucursal,
					Almacen, Articulo, SubCuenta, CantidadPicking, Tarima)
			 SELECT @Estacion, 'COMS' Modulo, A.ID, A.Mov, A.MovID, B.RenglonID, A.Empresa, A.Sucursal,
					A.Almacen, B.Articulo, ISNULL(B.Subcuenta,''), B.CantidadPendiente, B.Tarima
			   FROM Compra A
			   JOIN CompraD B
				 ON A.ID = B.ID
			   JOIN Alm C
				 ON A.Almacen = C.Almacen
				AND C.WMS = 1
			   JOIN Art D
				 ON B.Articulo = D.Articulo				
			  WHERE A.Estatus = 'PENDIENTE'
				AND A.Empresa = @Empresa
				AND B.Tarima IS NOT NULL

	INSERT @Pedidos(Estacion, Modulo, ID,  Mov, MovID, RenglonID, Empresa, Sucursal,
					Almacen, Articulo, SubCuenta, CantidadPicking, Tarima)
			 SELECT @Estacion, 'INV' Modulo, A.ID, A.Mov, A.MovID, B.RenglonID, A.Empresa, A.Sucursal,
					A.Almacen, B.Articulo, ISNULL(B.Subcuenta,''), B.CantidadPendiente, B.Tarima
			   FROM Inv A
			   JOIN InvD B
				 ON A.ID = B.ID
			   JOIN Alm C
				 ON A.Almacen = C.Almacen
				AND C.WMS = 1
			   JOIN Art D
				 ON B.Articulo = D.Articulo
			   JOIN MovTipo E
			     ON E.Modulo = 'INV'
				AND A.Mov = E.Mov			
			  WHERE A.Estatus = 'PENDIENTE'
				AND A.Empresa = @Empresa
				AND B.Tarima IS NOT NULL
				AND E.Clave NOT IN ('INV.TI')

	DECLARE CrPedidos CURSOR FOR
		SELECT ID, Modulo, Mov, MovID, Articulo, RenglonID 
		  FROM @Pedidos
	
	OPEN CrPedidos
	FETCH NEXT FROM CrPedidos INTO @CrID, @CrModulo, @CrMov, @CrMovID, @CrArticulo, @CrRenglonID
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF EXISTS(SELECT * 
					FROM TMA A
					JOIN TMAD B ON A.ID = B.ID 
				   WHERE A.OrigenTipo = @CrModulo 
				     AND A.Origen = @CrMov 
				     AND A.OrigenID = @CrMovID 
				     AND B.Articulo = @CrArticulo 
				     AND A.Estatus <> 'CANCELADO')
			 DELETE FROM @Pedidos WHERE ID = @CrID AND Articulo = @CrArticulo 
		
		FETCH NEXT FROM CrPedidos INTO @CrID, @CrModulo, @CrMov, @CrMovID, @CrArticulo, @CrRenglonID
	END
	
	CLOSE CrPedidos
	DEALLOCATE CrPedidos
	
	DELETE FROM WMSPedidosSinSurtir WHERE Estacion = @Estacion
	
	INSERT WMSPedidosSinSurtir(Estacion, Empresa, Modulo, ModuloID, Mov, MovID, RenglonID, Sucursal, 
							   Almacen, Articulo, SubCuenta, Tarima, Cantidad)
						SELECT Estacion, Empresa, Modulo, ID, Mov, MovID, RenglonID,  Sucursal,
							   Almacen, Articulo, SubCuenta, Tarima, CantidadPicking
						  FROM @Pedidos

END
GO

/************************************   spWMSMostrarTarimas   ******************************************/
IF EXISTS (SELECT * FROM SysObjects WHERE name = 'spWMSMostrarTarimas' AND type = 'P') DROP PROCEDURE spWMSMostrarTarimas
GO
CREATE PROCEDURE spWMSMostrarTarimas
	@Estacion	int

--//WITH ENCRYPTION
AS BEGIN     
	DECLARE
		@Empresa		varchar(5),
		@ID				int,
		@Modulo			varchar(10),
		@ModuloID		int,
		@Movimiento		varchar(50),
		@RenglonID		int,
		@Articulo		varchar(20),
		@SubCuenta		varchar(50)

	DELETE FROM WMSTarimaDisponible WHERE Estacion = @Estacion AND ID IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion)
	
	DECLARE CrTarima CURSOR FOR
		SELECT B.Empresa, B.ID, B.Modulo, B.ModuloID, B.Mov+' '+ISNULL(B.MovID,''), B.RenglonID, B.Articulo, B.SubCuenta
		  FROM ListaID A
		  JOIN WMSPedidosSinSurtir B
		    ON A.ID = B.ID
		   AND A.Estacion = B.Estacion
		 WHERE A.Estacion = @Estacion
		   
	OPEN CrTarima
	FETCH NEXT FROM CrTarima INTO @Empresa, @ID, @Modulo, @ModuloID, @Movimiento, @RenglonID, @Articulo, @SubCuenta

	WHILE @@FETCH_STATUS = 0
		BEGIN
			INSERT WMSTarimaDisponible(Estacion, Empresa, ID, Modulo, ModuloID, Movimiento, Almacen,
									   Articulo, SubCuenta, Tarima, SerieLote, Disponible)
								SELECT @Estacion, @Empresa, @ID, @Modulo, @ModuloID, @Movimiento, A.Almacen,
									   A.Articulo, ISNULL(B.SubCuenta,''), A.Tarima, ISNULL(B.SerieLote,''), 
									   SUM(CASE WHEN ISNULL(B.Tarima,'') <> ''
										   THEN ISNULL(B.Existencia,0)-ISNULL(C.Apartado,0) 
										   ELSE ISNULL(A.Disponible,0)-ISNULL(A.Apartado,0)
										   END)
								  FROM ArtDisponibleTarima A
								  JOIN Tarima T
								    ON A.Tarima = T.Tarima
								  JOIN AlmPos AP
								    ON T.Almacen = AP.Almacen
								   AND T.Posicion = AP.Posicion
							 LEFT JOIN SerieLote B
									ON A.Tarima = B.Tarima							 
								   AND A.Articulo = B.Articulo
							 LEFT JOIN ArtApartadoTarimaSL C
									ON A.Tarima = C.Tarima
								   AND A.Articulo = C.Articulo
								   AND B.SerieLote = C.SerieLote
								 WHERE A.Articulo = @Articulo
								   AND (CHARINDEX('-', A.Tarima)-1) < 0
								   AND AP.Tipo IN ('Domicilio','Ubicacion','Cross Docking')
							  GROUP BY A.Almacen, A.Articulo, ISNULL(B.SubCuenta,''), A.Tarima, B.SerieLote
							    HAVING SUM(CASE WHEN ISNULL(B.Tarima,'') <> ''
												THEN ISNULL(B.Existencia,0)-ISNULL(C.Apartado,0) 
												ELSE ISNULL(A.Disponible,0)-ISNULL(A.Apartado,0)
												END) > 0
			                 
			FETCH NEXT FROM CrTarima INTO @Empresa, @ID, @Modulo, @ModuloID, @Movimiento, @RenglonID, @Articulo, @SubCuenta
		END		
		
	CLOSE CrTarima
	DEALLOCATE CrTarima

END
GO

/***************************************   spWMSValidaTarimaSurtido   ***************************************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'spWMSValidaTarimaSurtido' AND type = 'P') DROP PROCEDURE spWMSValidaTarimaSurtido
GO
CREATE PROCEDURE spWMSValidaTarimaSurtido
		@Estacion	int,
		@Borrar		int

--//WITH ENCRYPTION
AS 
BEGIN     
	DECLARE
		@CrEmpresa			varchar(5),
		@CrID				int,
		@CrModulo			varchar(20),
		@CrModuloID			int,
		@CrArticulo			varchar(20),
		@CrSubcuenta		varchar(50),
		@CrTarima			varchar(20),
		@CrSerieLote		varchar(50),
		@CrDiponible		float,
		@CrCantidadA		float,
		@CrCantidad			float,
		@CrMovimiento		varchar(50),
		-----------------------------------
		@SumaCantidadA		float,
		@Ok					int,
		@OkRef				varchar(255)
	
	IF @Borrar = 1
		BEGIN
			DELETE FROM WMSTarimaDisponible WHERE Estacion = @Estacion
			RETURN
		END
	
	IF @Borrar = 0
	BEGIN
	DECLARE CrTarimas CURSOR FOR
		SELECT A.Empresa, A.ID, A.Modulo, A.ModuloID, A.Articulo, A.SubCuenta, 
			   A.Tarima, A.SerieLote, A.Disponible, A.CantidadA, B.Cantidad, B.Mov+' '+ISNULL(B.MovID,'')
		  FROM WMSTarimaDisponible A
		  JOIN WMSPedidosSinSurtir B
			ON A.ID = B.ID
		   AND A.Estacion = B.Estacion
		 WHERE A.Estacion = @Estacion
		   AND A.CantidadA > 0
	
	OPEN CrTarimas
	FETCH NEXT FROM CrTarimas INTO @CrEmpresa, @CrID, @CrModulo, @CrModuloID, @CrArticulo, @CrSubcuenta,
								   @CrTarima, @CrSerieLote, @CrDiponible, @CrCantidadA, @CrCantidad, @CrMovimiento
	
	WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
	BEGIN
		IF NOT EXISTS(SELECT * FROM Art WHERE Articulo = @CrArticulo AND Tipo IN ('Serie','Lote') )
			SELECT @CrSerieLote = ''
		
		IF @CrDiponible < @CrCantidadA
			BEGIN
				SELECT @Ok = Mensaje, @OkRef = Descripcion+'<BR>Mov: '+@CrMovimiento+'<BR>Tarima: '+@CrTarima 
				  FROM MensajeLista 
				 WHERE MENSAJE = 20020
			END
	
		SELECT @SumaCantidadA = SUM(CantidadA)
		  FROM WMSTarimaDisponible
		 WHERE Tarima = @CrTarima
		   AND ISNULL(SerieLote,'') = ISNULL(@CrSerieLote,'')
		   AND ISNULL(Subcuenta,'') = ISNULL(@CrSubcuenta,'')
		   AND Estacion = @Estacion
		   AND CantidadA > 0
			
		IF @CrDiponible < @SumaCantidadA
			BEGIN
				SELECT @Ok = Mensaje, @OkRef = Descripcion+'<BR>Tarima: '+@CrTarima 
				  FROM MensajeLista 
				 WHERE MENSAJE = 20020
			END	

		SELECT @SumaCantidadA = SUM(CantidadA)
		  FROM WMSTarimaDisponible
		 WHERE ID = @CrID 
		   AND Estacion = @Estacion
		   AND CantidadA > 0
			
		IF @CrCantidad < @SumaCantidadA
			BEGIN
				SELECT @Ok = Mensaje, @OkRef = Descripcion+'<BR>Mov: '+@CrMovimiento 
				  FROM MensajeLista 
				 WHERE Mensaje = 13240
			END	

		FETCH NEXT FROM CrTarimas INTO @CrEmpresa, @CrID, @CrModulo, @CrModuloID, @CrArticulo, @CrSubcuenta,
									   @CrTarima, @CrSerieLote, @CrDiponible, @CrCantidadA, @CrCantidad, @CrMovimiento
	END
	
	CLOSE CrTarimas
	DEALLOCATE CrTarimas
	
	IF @Ok IS NOT NULL
		SELECT @OkRef
	ELSE		
		SELECT ''
	END		
END
GO

/******************************************   spWMSRegeneraSurtidos   ***************************************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'spWMSRegeneraSurtidos' AND type = 'P') DROP PROCEDURE spWMSRegeneraSurtidos
GO
CREATE PROCEDURE spWMSRegeneraSurtidos
		@Estacion	int,
		@Usuario	varchar(10)
--//WITH ENCRYPTION
AS 
BEGIN
	DECLARE
		@CrID				int,
		@CrEmpresa			varchar(5),
		@CrModulo			varchar(20),
		@CrModuloID			int,
		@CrArticulo			varchar(20),
		@CrAlmacen			varchar(10),
		@CrSubCuenta		varchar(20),
		@CrTarima			varchar(20),
		@CrSerieLote		varchar(50),
		@CrDisponible		float,
		@CrCantidadA		float,
		----------------------------------------
		@PCKUbicacion	 			bit,
		@Mov						varchar(20),
		@TipoPosicion	 			varchar(20),
		@TarimaSurtido   			varchar(20),
		@Sucursal        			int,
		@FechaEmision    			datetime,
		@Estatus         			varchar(15),
		@Observaciones   			varchar(100),
		@Referencia					varchar(50),
		@SucursalDestino 			int,
		@ModuloAux       			varchar(10),
		@ModuloIDAux       			int, 
		@Origen          			varchar(20),	 	 
		@OrigenID        			varchar(20),
		@GenerarID					int,
		@PosicionOrigen				varchar(10),
		@PosicionDestino			varchar(10),
		@TarimaFechaCaducidadAux	datetime,
		@Zona                   	varchar(50),
		@OrigenObservaciones		varchar(100),
		@SubCuentaAux				varchar(50),
		@RenglonID					int,
		
		@Unidad						varchar(20),
				
		@ModuloD          			varchar(20),
		@MovIDD          			varchar(20),
		----------------------------------------
		@Ok							int,
		@OkRef						varchar(255)

	DECLARE @SerieLoteMov AS TABLE (Empresa				varchar(5),
									Modulo				varchar(5),
									Sucursal			int,
									ID					int, 
									RenglonID			int,
									Articulo			varchar(20),
									SubCuenta			varchar(50),
									SerieLote			varchar(50),
									Tarima				varchar(20),
									Cantidad			float,
									AsignacionUbicacion	bit default 0
								   )
	BEGIN TRAN
		
		DECLARE CrTarimas CURSOR FOR
			SELECT ID, Empresa, Modulo, ModuloID, Articulo, Almacen, 
				   SubCuenta, Tarima, SerieLote, Disponible, CantidadA
			  FROM WMSTarimaDisponible
			 WHERE Estacion = @Estacion
			   AND CantidadA > 0
		  ORDER BY ID, Tarima, SerieLote
		
		OPEN CrTarimas
		FETCH NEXT FROM CrTarimas INTO @CrID, @CrEmpresa, @CrModulo, @CrModuloID, @CrArticulo, @CrAlmacen,
									   @CrSubCuenta, @CrTarima, @CrSerieLote, @CrDisponible, @CrCantidadA

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @Mov = NULL
			IF NOT EXISTS(SELECT * FROM Art WHERE Articulo = @CrArticulo AND Tipo IN ('Serie','Lote') )
				SELECT @CrSerieLote = ''

			SELECT @PCKUbicacion = WMSPCKUbicacion FROM EmpresaCfg WHERE Empresa = @CrEmpresa
			SELECT @TarimaFechaCaducidadAux = FechaCaducidad FROM Tarima WHERE Tarima = @CrTarima
			
			SELECT @TipoPosicion	= A.Tipo,
				   @Zona			= A.Zona,
				   @PosicionOrigen	= A.Posicion
			  FROM AlmPos A
			  JOIN Tarima B
			    ON A.Posicion = B.Posicion
			   AND A.Almacen = B.Almacen
			 WHERE A.Almacen = @CrAlmacen 
			   AND B.Tarima = @CrTarima
			   
			SELECT @TarimaSurtido = Tarima,
				   @ModuloAux = Modulo,
				   @Origen = Mov,
				   @OrigenID = MovID,
				   @RenglonID = RenglonID,
				   @ModuloIDAux = ModuloID
			  FROM WMSPedidosSinSurtir
			 WHERE ID = @CrID
			   AND Articulo = @CrArticulo
			
			IF @CrModulo = 'VTAS'
			SELECT @Sucursal = A.Sucursal,
				   @FechaEmision = dbo.fnFechaSinHora(GETDATE()),
				   @Estatus = 'SINAFECTAR',
				   @Observaciones = 'Herramienta',
				   @Referencia = 'Sucursal Destino '+CAST(ISNULL(E.Sucursal,A.Sucursal) AS VARCHAR(5)),
				   @SucursalDestino = ISNULL(E.Sucursal,A.Sucursal),
				   @OrigenObservaciones = A.Observaciones,
				   @PosicionDestino = CASE ISNULL(C.WMSAndenSurtidoContacto,0) 
										WHEN 1 
										THEN ISNULL(NULLIF(D.DefPosicionSurtido,''),ISNULL(A.PosicionWMS, B.DefPosicionSurtido)) 
										ELSE ISNULL(A.PosicionWMS, B.DefPosicionSurtido) 
									  END 
			  FROM Venta A
			  JOIN Alm B
				ON A.Almacen = B.Almacen				  
			  JOIN EmpresaCfg C 
			    ON A.Empresa = C.Empresa
		 LEFT JOIN Cte D 
			    ON A.Cliente = D.Cliente 
		 LEFT JOIN Alm E
				ON A.AlmacenDestino = E.Almacen			    
			 WHERE ID = @CrModuloID


			IF @CrModulo = 'COMS'
			SELECT @Sucursal = A.Sucursal,
				   @FechaEmision = dbo.fnFechaSinHora(GETDATE()),
				   @Estatus = 'SINAFECTAR',
				   @Observaciones = 'Herramienta',
				   @Referencia = 'Sucursal Destino '+CAST(ISNULL(E.Sucursal, A.Sucursal) AS VARCHAR(5)),
				   @SucursalDestino = ISNULL(E.Sucursal,A.Sucursal),
				   @OrigenObservaciones = A.Observaciones,
				   @PosicionDestino = CASE ISNULL(C.WMSAndenSurtidoContacto,0)
										WHEN 1 
										THEN ISNULL(NULLIF(D.DefPosicionSurtido,''),ISNULL(A.PosicionWMS, B.DefPosicionSurtido)) 
										ELSE ISNULL(A.PosicionWMS, B.DefPosicionSurtido) 
									  END
			  FROM Compra A
			  JOIN Alm B
				ON A.Almacen = B.Almacen				  
			  JOIN EmpresaCfg C 
			    ON A.Empresa = C.Empresa
		 LEFT JOIN Cte D 
			    ON A.Cliente = D.Cliente			  
		 LEFT JOIN Alm E
				ON A.Almacen = E.Almacen
			 WHERE A.ID = @CrModuloID
			 
			IF @CrModulo = 'INV'
			SELECT @Sucursal = A.Sucursal,
				   @FechaEmision = dbo.fnFechaSinHora(GETDATE()),
				   @Estatus = 'SINAFECTAR',
				   @Observaciones = 'Herramienta de Resurtido',
				   @Referencia = 'Sucursal Destino '+CAST(ISNULL(C.Sucursal,A.Sucursal) AS VARCHAR(5)),
				   @SucursalDestino = ISNULL(C.Sucursal,A.Sucursal),
				   @OrigenObservaciones = A.Observaciones,
				   @PosicionDestino = ISNULL(A.PosicionWMS, B.DefPosicionSurtido)
			  FROM Inv A
			  JOIN Alm B
				ON A.AlmacenDestino = B.Almacen			  
		 LEFT JOIN Alm C
				ON A.AlmacenDestino = C.Almacen
			 WHERE A.ID = @CrModuloID			 				   
			   
			/*****     PCK NORMAL     *****/
			IF @TipoPosicion = 'Domicilio'
			BEGIN
			   SELECT @Mov = Mov
				 FROM MovTipo 
				WHERE Modulo = 'TMA'
				  AND RTRIM(LTRIM(Clave)) = 'TMA.OSUR' 
				  AND SubClave = 'TMA.OSURP' 
			END
			--------------------------------------------------------------------------------------------------------------------------
			/*****     SURTIDO NORMAL     *****/
			IF (@TipoPosicion = 'Ubicacion' AND @CrDisponible = @CrCantidadA) OR (@TipoPosicion = 'Cross Docking')
			BEGIN
			   SELECT @Mov = Mov 
				 FROM MovTipo 
				WHERE Modulo = 'TMA'
				  AND RTRIM(LTRIM(Clave)) = 'TMA.OSUR' 
				  AND ISNULL(SubClave,'') = ''
			END
			--------------------------------------------------------------------------------------------------------------------------
			/*****     PCK TARIMA COMPLETA     *****/
			IF @TipoPosicion = 'Ubicacion' AND @CrDisponible > @CrCantidadA AND @PCKUbicacion = 1
			BEGIN
			   SELECT @Mov = Mov 
				 FROM MovTipo 
				WHERE Modulo = 'TMA'
				  AND RTRIM(LTRIM(Clave)) = 'TMA.OPCKTARIMA' 
				  AND ISNULL(SubClave,'') = ''
			END
			--------------------------------------------------------------------------------------------------------------------------
		
		IF @Mov IS NOT NULL
			BEGIN
				INSERT TMA (Empresa, Sucursal, Usuario, Mov, FechaEmision, Estatus, Almacen, Zona, Observaciones,
							TarimaSurtido, Prioridad, Referencia, SucursalFiltro, OrigenTipo, Origen, OrigenID, OrigenObservaciones)
				VALUES     (@CrEmpresa, @Sucursal, @Usuario, @Mov, @FechaEmision, @Estatus, @CrAlmacen, @Zona, @Observaciones,
							@TarimaSurtido, 'Normal', @Referencia, @SucursalDestino, @ModuloAux, @Origen, @OrigenID, @OrigenObservaciones)
				
				   SET @GenerarID = @@IDENTITY
				   
				INSERT TMAD (ID, Sucursal, Renglon, Tarima, Almacen, Posicion, PosicionDestino, CantidadPicking, Zona, 
							 Prioridad, EstaPendiente, Procesado, Unidad,  CantidadUnidad, Articulo, SubCuenta, FechaCaducidad)
				VALUES      (@GenerarID, @Sucursal, 2048, @CrTarima, @CrAlmacen, @PosicionOrigen, @PosicionDestino, @CrCantidadA, @Zona,
							'Normal', 1,  0,         @Unidad, @CrCantidadA, @CrArticulo, @CrSubCuenta, @TarimaFechaCaducidadAux)
				
				/**********************     SERIE / LOTE     **************************/
				IF @Ok IS NULL AND @CrSerieLote <> ''
					BEGIN
						INSERT SerieLoteMov(Empresa,  Sucursal,  Modulo,  ID,  RenglonID,  Articulo, SubCuenta, 
											SerieLote, Cantidad, Tarima, AsignacionUbicacion)
									VALUES (@CrEmpresa, @Sucursal, 'TMA', @GenerarID, 2048, @CrArticulo, ISNULL(@CrSubCuenta,''),
											@CrSerieLote, @CrCantidadA, @CrTarima, 0)
						
						IF NOT EXISTS(SELECT * 
										FROM @SerieLoteMov
									   WHERE Empresa = @CrEmpresa
									     AND Modulo = @ModuloAux
									     AND ID = @CrID
									     AND RenglonID = @RenglonID
									     AND Articulo = @CrArticulo
									     AND SubCuenta = @CrSubCuenta
									     AND SerieLote = @CrSerieLote
									     AND Tarima = @TarimaSurtido)
						INSERT @SerieLoteMov(Empresa,  Sucursal,  Modulo,  ID,  RenglonID,  Articulo, SubCuenta, 
											 SerieLote, Cantidad, Tarima, AsignacionUbicacion)
									 VALUES (@CrEmpresa, @Sucursal, @ModuloAux, @ModuloIDAux, @RenglonID, @CrArticulo, ISNULL(@CrSubCuenta,''),
											 @CrSerieLote, @CrCantidadA, @TarimaSurtido, 0)						
						
						IF EXISTS (SELECT * 
									 FROM @SerieLoteMov
									WHERE Empresa = @CrEmpresa
									  AND Modulo = @ModuloAux
									  AND ID = @CrID
									  AND RenglonID = @RenglonID
									  AND Articulo = @CrArticulo
									  AND SubCuenta = @CrSubCuenta
									  AND SerieLote = @CrSerieLote
									  AND Tarima = @TarimaSurtido)
								   UPDATE @SerieLoteMov SET Cantidad = Cantidad + @CrCantidadA
									WHERE Empresa = @CrEmpresa
									  AND Modulo = @ModuloAux
									  AND ID = @ModuloIDAux
									  AND RenglonID = @RenglonID
									  AND Articulo = @CrArticulo
									  AND SubCuenta = @CrSubCuenta
									  AND SerieLote = @CrSerieLote
									  AND Tarima = @TarimaSurtido
						
						DELETE FROM SerieLoteMov WHERE Modulo = @ModuloAux AND ID = @ModuloIDAux																	
					END					
				/***********************************************************************/				
				
				EXEC spAfectar 'TMA', @GenerarID, 'AFECTAR', @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
				
				IF @Ok IS NULL
					BEGIN
						SELECT @ModuloD = 'TMA', @MovIDD = MovID FROM TMA WHERE ID = @GenerarID
						EXEC spMovFlujo @Sucursal, 'AFECTAR', @CrEmpresa, @ModuloAux, @CrModuloID, @Origen, @OrigenID, @ModuloD, @GenerarID, @Mov, @MovIDD, @Ok OUTPUT
					END
				
			END				
			-----------------------------------------------------------------------------------------------------------------------------------------
			FETCH NEXT FROM CrTarimas INTO @CrID, @CrEmpresa, @CrModulo, @CrModuloID, @CrArticulo, @CrAlmacen,
										   @CrSubCuenta, @CrTarima, @CrSerieLote, @CrDisponible, @CrCantidadA
		END
		
		CLOSE CrTarimas
		DEALLOCATE CrTarimas

	INSERT SerieLoteMov(Empresa,  Sucursal,  Modulo,  ID,  RenglonID,  Articulo, SubCuenta, 
						SerieLote, Cantidad, Tarima, AsignacionUbicacion)
				 SELECT Empresa,  Sucursal,  Modulo,  ID,  RenglonID,  Articulo, SubCuenta, 
						SerieLote, Cantidad, Tarima, AsignacionUbicacion
				   FROM @SerieLoteMov

	IF @Ok IS NULL
		COMMIT TRAN	
	ELSE
		ROLLBACK TRAN			
END
GO

/************************************   spWMSSurtidosPendientes   ******************************************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'spWMSSurtidosPendientes' AND type = 'P') DROP PROCEDURE spWMSSurtidosPendientes
GO
CREATE PROCEDURE spWMSSurtidosPendientes
	@Empresa	varchar(5),
	@Estacion	int

--//WITH ENCRYPTION
AS BEGIN     
	DECLARE
		@ID				int,
		@Tarima			varchar(20),
		@Articulo		varchar(20),
		@Almacen		varchar(10),		
		@Posicion		varchar(10),
		@Disponible		float,
		@Apartado		float,
		@Movimiento		varchar(50),
		@OrigenTipo		varchar(10),
		@CantidadPedido float,
		@SerieLote		varchar(50)

	DELETE FROM WMSTarimaSurtido WHERE Estacion = @Estacion AND ID IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion)
		
		DECLARE CrTarima CURSOR FOR
			SELECT DISTINCT ListaID.ID,
							Tarima.Tarima,
							SerieLote.SerieLote,
							ArtDisponibleTarima.Articulo,
							Tarima.Almacen,
							Tarima.Posicion,
							CASE WHEN ISNULL(SerieLote.Tarima,'') <> ''
								 THEN SerieLote.Existencia
								 ELSE ArtDisponibleTarima.Disponible
							END,
							CASE WHEN ISNULL(ArtApartadoTarimaSL.Tarima,'') <> ''
								 THEN ArtApartadoTarimaSL.Apartado
								 ELSE ArtDisponibleTarima.Apartado
							END,
							RTRIM(LTRIM(TMA.Mov))+' '+ISNULL(TMA.MovID,''),
							CASE WHEN Tarima.Tarima = TMAD.Tarima AND ISNULL(SerieLote.SerieLote,'') = ISNULL(SerieLoteMov.SerieLote,'')
								 THEN TMAD.CantidadPicking 
								 ELSE 0 
							END,
							TMA.OrigenTipo
					   FROM Tarima
				  LEFT JOIN AlmPos
						 ON Tarima.Almacen = AlmPos.Almacen 
						AND Tarima.Posicion = AlmPos.Posicion
					   JOIN ArtDisponibleTarima 
						 ON Tarima.Tarima = ArtDisponibleTarima.Tarima
					   JOIN TMA
						 ON ArtDisponibleTarima.Empresa = TMA.Empresa
						AND Tarima.Almacen = TMA.Almacen
					   JOIN TMAD
						 ON TMA.ID = TMAD.ID
						AND ArtDisponibleTarima.Articulo = TMAD.Articulo		
						AND Tarima.Almacen = TMAD.Almacen		
					   JOIN ListaID
						 ON ListaID.ID = TMA.ID             
				  LEFT JOIN SerieLote
						 ON SerieLote.Tarima = Tarima.Tarima
						AND	SerieLote.Empresa = TMA.Empresa
						AND SerieLote.Almacen = TMA.Almacen
						AND TMAD.Articulo = SerieLote.Articulo
				  LEFT JOIN SerieLoteMov			
  						 ON SerieLote.SerieLote = SerieLoteMov.SerieLote
  						AND SerieLote.Tarima = SerieLoteMov.Tarima
  						AND SerieLoteMov.Modulo = 'TMA'
  						AND TMA.ID = SerieLoteMov.ID
  						AND TMAD.Articulo = SerieLoteMov.Articulo
				  LEFT JOIN ArtApartadoTarimaSL
						 ON Tarima.Tarima = ArtApartadoTarimaSL.Tarima
						AND SerieLote.SerieLote = ArtApartadoTarimaSL.SerieLote	
					  WHERE ListaID.Estacion = @Estacion
						AND ArtDisponibleTarima.Empresa = @Empresa
						AND ArtDisponibleTarima.Disponible > 0
						AND Tarima.Estatus = 'ALTA'
						AND (CHARINDEX('-', Tarima.Tarima)-1) < 0
						AND AlmPos.Tipo IN ('Domicilio','Ubicacion','Cross Docking')
		    
	OPEN CrTarima
	FETCH NEXT FROM CrTarima INTO @ID, @Tarima, @SerieLote, @Articulo, @Almacen, @Posicion, @Disponible, @Apartado, @Movimiento, @CantidadPedido, @OrigenTipo

	WHILE @@FETCH_STATUS = 0
		BEGIN
			INSERT WMSTarimaSurtido(Estacion, ID, Empresa, Tarima, SerieLote, Articulo, Almacen, Posicion,	Disponible, Apartado, CantidadA, Movimiento, OrigenTipo)
			                 VALUES(@Estacion, @ID, @Empresa, @Tarima,ISNULL(@SerieLote,''), @Articulo, @Almacen, @Posicion, @Disponible, @Apartado, @CantidadPedido, @Movimiento, @OrigenTipo)
			                 
			FETCH NEXT FROM CrTarima INTO @ID, @Tarima, @SerieLote, @Articulo, @Almacen, @Posicion, @Disponible, @Apartado, @Movimiento, @CantidadPedido, @OrigenTipo
		END		
		
	CLOSE CrTarima
	DEALLOCATE CrTarima

END
GO
/***************************************   spWMSValidaTarimaMovSurtido   ***************************************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'spWMSValidaTarimaMovSurtido' AND type = 'P') DROP PROCEDURE spWMSValidaTarimaMovSurtido
GO
CREATE PROCEDURE spWMSValidaTarimaMovSurtido
		@Estacion	int,
		@Borrar		int

--//WITH ENCRYPTION
AS 
BEGIN     
	DECLARE
		@ID					int,
		@Movimiento			varchar(50),
		@Tarima				varchar(20),
		@CantidadDiponible	float,
		@CantidadA			float,
		@CantidadPedido		float,
		@CantidadApartada	float,
		@Ok					int,
		@OkRef				varchar(255)
	
	IF @Borrar = 1
		BEGIN
			DELETE FROM WMSTarimaSurtido WHERE Estacion = @Estacion
			RETURN
		END
	
	IF @Borrar = 0
	BEGIN
	DECLARE CrTarimas CURSOR FOR
		SELECT A.ID, C.Movimiento, C.Tarima, C.Disponible, C.CantidadA, B.CantidadPicking
		  FROM TMA A
		  JOIN TMAD B
			ON A.ID = B.ID
		  JOIN WMSTarimaSurtido C
			ON A.ID = C.ID
		 WHERE C.Estacion = @Estacion
		   AND C.CantidadA > 0
	
	OPEN CrTarimas
	FETCH NEXT FROM CrTarimas INTO @ID, @Movimiento, @Tarima, @CantidadDiponible, @CantidadA, @CantidadPedido
	
	WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
	BEGIN
		SELECT @CantidadApartada = SUM(CantidadA)
		  FROM WMSTarimaSurtido
		 WHERE Estacion = @Estacion
		   AND Tarima = @Tarima
		
		IF @CantidadApartada > @CantidadDiponible
			BEGIN
				SELECT @Ok = Mensaje, @OkRef = Descripcion+'<BR>Tarima: '+@Tarima 
				  FROM MensajeLista 
				 WHERE MENSAJE = 20020
			END		
		IF @CantidadDiponible < @CantidadA
			SELECT @Ok = Mensaje, @OkRef = Descripcion+'<BR>Mov: '+@Movimiento+'<BR>Tarima: '+@Tarima 
			  FROM MensajeLista 
			 WHERE MENSAJE = 20020
		
		IF @Ok IS NULL
			BEGIN
				SELECT @CantidadA = SUM(CantidadA) FROM WMSTarimaSurtido WHERE Estacion = @Estacion AND ID = @ID
			END
		
		IF @CantidadA > @CantidadPedido AND @Ok IS NULL
			SELECT @Ok = Mensaje, @OkRef = Descripcion+'<BR>Mov: '+@Movimiento
			  FROM MensajeLista 
			 WHERE MENSAJE = 13240
		
		FETCH NEXT FROM CrTarimas INTO @ID, @Movimiento, @Tarima, @CantidadDiponible, @CantidadA, @CantidadPedido
	END
	
	CLOSE CrTarimas
	DEALLOCATE CrTarimas
	
	IF @Ok IS NOT NULL
		SELECT @OkRef
	ELSE		
		SELECT ''
	END		
END
GO
/******************************************   spWMSRegeneraMovSurtido   ***************************************/
IF EXISTS (SELECT 1 FROM SysObjects WHERE name = 'spWMSRegeneraMovSurtido' AND type = 'P') DROP PROCEDURE spWMSRegeneraMovSurtido
GO
CREATE PROCEDURE spWMSRegeneraMovSurtido
		@Estacion	int,
		@Usuario	varchar(10)
--//WITH ENCRYPTION
AS 
BEGIN
	DECLARE
		@ID			int,
		@Empresa	varchar(5),
		@Tarima		varchar(20),
		@SerieLote	varchar(50),
		@Articulo	varchar(20),
		@Almacen	varchar(10),
		@Posicion	varchar(10),
		@Disponible float,
		@CantidadA	float,
		@OrigenTipo varchar(10),
		----------------------------------------
		@IDOrigen					int,
		@MovOrigen					varchar(20),
		@MovIDOrigen				varchar(20),
		@SLRenglonID				float, 
		@SLSubCuenta				varchar(50), 
		@SLSerieLote				varchar(50), 
		@SLTarima					varchar(20),
		----------------------------------------
		@GenerarID					int,
		@Renglon					float,
		@Mov						varchar(20),
		@TipoPosicion	 			varchar(20),
		@PCKUbicacion	 			bit,
		@Sucursal        			int,     	 
		@FechaEmision    			datetime, 	 
		@Observaciones   			varchar(100), 	 
		@Estatus         			varchar(15), 	 
		@Agente          			varchar(10), 	 
		@TarimaSurtido   			varchar(20),
		@Zona                   	varchar(50),
		@Referencia					varchar(50),
		@SucursalDestino 			int,	 
		@ModuloAux       			varchar(10),	 
		@Origen          			varchar(20),	 	 
		@OrigenID        			varchar(20),	 	 
		@OrigenObservaciones		varchar(100),
		@TarimaFechaCaducidadAux	datetime,
		@PosicionOrigen				varchar(10),
		@PosicionDestino			varchar(10),
		@Unidad						varchar(20),
		@SubCuentaAux				varchar(50),
		@ModuloD					varchar(20),
		@MovIDD						varchar(20),
		@Ok							int,
		@OkRef						varchar(255)

		DECLARE @TMASurtido	AS TABLE(ID int, Articulo varchar(20), CantidadPicking float, CantidadPendiente float, CantidadUnidad float)

	BEGIN TRAN		
		INSERT INTO @TMASurtido(ID, Articulo, CantidadPicking, CantidadPendiente, CantidadUnidad)
						 SELECT A.ID, C.Articulo, C.CantidadPicking, C.CantidadPendiente, C.CantidadUnidad
						   FROM WMSTarimaSurtido A
						   JOIN TMA B
							 ON A.ID = B.ID
						   JOIN TMAD C
							 ON A.ID = C.ID
						  WHERE A.Estacion = @Estacion
							AND A.CantidadA > 0
					   GROUP BY A.ID, C.Articulo, C.CantidadPicking, C.CantidadPendiente, C.CantidadUnidad
					   
		DECLARE CrTarimas CURSOR FOR
			SELECT ID, Empresa, Tarima, SerieLote, Articulo, Almacen, Posicion, Disponible, CantidadA, OrigenTipo
			  FROM WMSTarimaSurtido
			 WHERE Estacion = @Estacion
			   AND CantidadA > 0
		  ORDER BY ID, Tarima, SerieLote
		
		OPEN CrTarimas
		FETCH NEXT FROM CrTarimas INTO @ID, @Empresa, @Tarima, @SerieLote, @Articulo, @Almacen, @Posicion, @Disponible, @CantidadA, @OrigenTipo

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @Mov = NULL
			IF NOT EXISTS(SELECT * FROM Art WHERE Articulo = @Articulo AND Tipo IN ('Serie','Lote') )
				SELECT @SerieLote = ''

			IF @OrigenTipo = 'VTAS' 
				SELECT @IDOrigen = B.ID,
					   @MovOrigen = B.Mov,
					   @MovIDOrigen = B.MovID 
				  FROM TMA A
				  JOIN Venta B
				    ON LTRIM(RTRIM(A.Origen))   = LTRIM(RTRIM(B.Mov))
				   AND LTRIM(RTRIM(A.OrigenID)) = LTRIM(RTRIM(B.MovID))
				   AND A.Empresa = B.Empresa
				   AND A.Sucursal = B.Sucursal
				 WHERE A.ID = @ID

			IF @OrigenTipo = 'COMS' 
				SELECT @IDOrigen = B.ID,
					   @MovOrigen = B.Mov,
					   @MovIDOrigen = B.MovID
				  FROM TMA A
				  JOIN Compra B
				    ON LTRIM(RTRIM(A.Origen))   = LTRIM(RTRIM(B.Mov))
				   AND LTRIM(RTRIM(A.OrigenID)) = LTRIM(RTRIM(B.MovID))
				   AND A.Empresa = B.Empresa
				   AND A.Sucursal = B.Sucursal
				 WHERE A.ID = @ID
				 				 
			IF @OrigenTipo = 'INV' 
				SELECT @IDOrigen = B.ID,
					   @MovOrigen = B.Mov,
					   @MovIDOrigen = B.MovID 
				  FROM TMA A
				  JOIN Inv B
				    ON LTRIM(RTRIM(A.Origen))   = LTRIM(RTRIM(B.Mov))
				   AND LTRIM(RTRIM(A.OrigenID)) = LTRIM(RTRIM(B.MovID))
				   AND A.Empresa = B.Empresa
				   AND A.Sucursal = B.Sucursal
				 WHERE A.ID = @ID				 
				 
			
			SELECT @PCKUbicacion = WMSPCKUbicacion FROM EmpresaCfg WHERE Empresa = @Empresa
			SELECT @TarimaFechaCaducidadAux = FechaCaducidad FROM Tarima WHERE Tarima = @Tarima
			SELECT @TipoPosicion = Tipo,
				   @Zona		 = Zona
			  FROM AlmPos 
			 WHERE Almacen = @Almacen 
			   AND Posicion = @Posicion
				
			/*****     PCK NORMAL     *****/
			IF @TipoPosicion = 'Domicilio'
			BEGIN
			   SELECT @Mov = Mov 
				 FROM MovTipo 
				WHERE Modulo = 'TMA'
				  AND RTRIM(LTRIM(Clave)) = 'TMA.OSUR' 
				  AND SubClave = 'TMA.OSURP' 
			END
			--------------------------------------------------------------------------------------------------------------------------
			/*****     SURTIDO NORMAL     *****/
			IF (@TipoPosicion = 'Ubicacion' AND @Disponible = @CantidadA) OR (@TipoPosicion = 'Cross Docking')
			BEGIN
			   SELECT @Mov = Mov 
				 FROM MovTipo 
				WHERE Modulo = 'TMA'
				  AND RTRIM(LTRIM(Clave)) = 'TMA.OSUR' 
				  AND ISNULL(SubClave,'') = ''
			END
			--------------------------------------------------------------------------------------------------------------------------
			/*****     PCK TARIMA COMPLETA     *****/
			IF @TipoPosicion = 'Ubicacion' AND @Disponible > @CantidadA AND @PCKUbicacion = 1
			BEGIN
			   SELECT @Mov = Mov 
				 FROM MovTipo 
				WHERE Modulo = 'TMA'
				  AND RTRIM(LTRIM(Clave)) = 'TMA.OPCKTARIMA' 
				  AND ISNULL(SubClave,'') = ''
			END
			--------------------------------------------------------------------------------------------------------------------------
		IF @Mov IS NOT NULL
			BEGIN				
				SELECT @Sucursal        	  = T.Sucursal,
					   @FechaEmision    	  = dbo.fnFechaSinHora(GETDATE()),
					   @Observaciones   	  = 'Herramienta',
					   @Estatus         	  = 'SINAFECTAR',
					   @Agente          	  = T.Agente,
					   @TarimaSurtido   	  = T.TarimaSurtido,
					   @Referencia			  = T.Referencia,
					   @SucursalDestino 	  = T.SucursalFiltro,
					   @ModuloAux       	  = T.OrigenTipo,
					   @Origen          	  = T.Origen,
					   @OrigenID        	  = T.OrigenID,
					   @OrigenObservaciones	  = T.OrigenObservaciones,
					   @PosicionOrigen		  = TD.Posicion,
					   @PosicionDestino  	  = TD.PosicionDestino,
					   @Unidad   			  = TD.Unidad,
					   @SubCuentaAux		  = TD.SubCuenta
				  FROM TMA T
				  JOIN TMAD TD ON T.ID = TD.ID
				 WHERE T.ID = @ID
			-----------------------------------------------------------------------------------------------------------------------------------------					   		   
				INSERT TMA (Empresa, Sucursal, Usuario, Mov, FechaEmision, Estatus, Almacen, Agente, Zona, Observaciones, TarimaSurtido, Prioridad, Referencia, SucursalFiltro, OrigenTipo, Origen, OrigenID, OrigenObservaciones)
				VALUES     (@Empresa, @Sucursal, @Usuario, @Mov, @FechaEmision, @Estatus, @Almacen, @Agente, @Zona, @Observaciones, @TarimaSurtido, 'Normal', @Referencia, @SucursalDestino, @ModuloAux, @Origen, @OrigenID, @OrigenObservaciones)
			  
				SET @GenerarID = @@IDENTITY 
				SET @Renglon = 2048
	          
				INSERT TMAD (ID,         Sucursal, Renglon, Tarima, Almacen, Posicion, PosicionDestino, CantidadPicking, 
							 Zona,       Prioridad, Montacarga, EstaPendiente, Procesado, Unidad,  CantidadUnidad, Articulo,     
							 SubCuenta,  FechaCaducidad) 
				VALUES      (@GenerarID, @Sucursal, @Renglon, @Tarima, @Almacen, @PosicionOrigen, @PosicionDestino, @CantidadA, 
							 @Zona,     'Normal', @Agente, 1,   0,  @Unidad, @CantidadA, @Articulo, 
							 @SubCuentaAux, @TarimaFechaCaducidadAux)		
		
				---------------------------------     ACTUALIZACION SERIELOTE     --------------------------------------
				IF @SerieLote <> ''
				BEGIN
					----------------------------------------------------------------
					SELECT @SLSubCuenta = ISNULL(SubCuenta,''), 
						   @SLSerieLote = SerieLote,
						   @SLTarima    = Tarima
					  FROM SerieLoteMov 
					 WHERE ID = @ID
					   AND Articulo = @Articulo
					   
					------  Actualizacion SerieLote Orden Surtido Origen     -------
					UPDATE SerieLoteMov SET Cantidad = Cantidad - @CantidadA
					 WHERE Modulo = 'TMA'
					   AND ID = @ID
					   AND Articulo = @Articulo
					   AND ISNULL(SubCuenta,'') = @SLSubCuenta
					   AND SerieLote = @SLSerieLote
					   AND Empresa = @Empresa
					   AND Tarima = @SLTarima					
					----------  Actualizacion SerieLote Pedido Origen     ----------
					UPDATE SerieLoteMov SET Cantidad = Cantidad - @CantidadA
					 WHERE Modulo = @OrigenTipo
					   AND ID = @IDOrigen
					   AND Articulo = @Articulo
					   AND ISNULL(SubCuenta,'') = @SLSubCuenta
					   AND SerieLote = @SLSerieLote
					   AND Empresa = @Empresa
					   AND Tarima = @TarimaSurtido
					----------------------------------------------------------------
					DELETE FROM SerieLoteMov
					 WHERE Modulo = @OrigenTipo
					   AND ID = @IDOrigen
					   AND Articulo = @Articulo
					   AND ISNULL(SubCuenta,'') = @SLSubCuenta
					   AND SerieLote = @SLSerieLote
					   AND Empresa = @Empresa
					   AND Tarima = @SLTarima
					   AND Cantidad = 0
					----------------------------------------------------------------
					INSERT SerieLoteMov (Empresa,  Sucursal,  Modulo,  ID,  RenglonID,  Articulo,  SubCuenta, SerieLote, 
										 Cantidad, Tarima, AsignacionUbicacion)
					VALUES              (@Empresa, @Sucursal, 'TMA', @GenerarID, @Renglon, @Articulo, ISNULL(@SubCuentaAux,''), @SerieLote,
										 @CantidadA, @Tarima, 0)
					
					IF EXISTS(SELECT * 
								FROM SerieLoteMov 
							   WHERE Modulo = @OrigenTipo
								 AND ID = @IDOrigen
								 AND Articulo = @Articulo
								 AND ISNULL(SubCuenta,'') = ISNULL(@SubCuentaAux,'')
								 AND SerieLote = @SerieLote
								 AND Empresa = @Empresa
								 AND Tarima = @TarimaSurtido)
						UPDATE SerieLoteMov SET Cantidad = Cantidad + @CantidadA
						 WHERE Modulo = @OrigenTipo
						   AND ID = @IDOrigen
						   AND Articulo = @Articulo
						   AND ISNULL(SubCuenta,'') = ISNULL(@SubCuentaAux,'')
						   AND SerieLote = @SerieLote
						   AND Empresa = @Empresa
						   AND Tarima = @TarimaSurtido
								
					IF NOT EXISTS(SELECT * 
									FROM SerieLoteMov 
								   WHERE Modulo = @OrigenTipo
								     AND ID = @IDOrigen
								     AND Articulo = @Articulo
								     AND ISNULL(SubCuenta,'') = ISNULL(@SubCuentaAux,'')
								     AND SerieLote = @SerieLote
								     AND Empresa = @Empresa
								     AND Tarima = @TarimaSurtido)			
					BEGIN
						IF @OrigenTipo = 'VTAS'
							SELECT @SLRenglonID = RenglonID 
							  FROM VentaD
							 WHERE ID = @IDOrigen
							   AND Articulo = @Articulo
							   AND ISNULL(SubCuenta,'') = ISNULL(@SubCuentaAux,'')
						
						IF @OrigenTipo = 'INV'
							SELECT @SLRenglonID = RenglonID 
							  FROM InvD
							 WHERE ID = @IDOrigen
							   AND Articulo = @Articulo
							   AND ISNULL(SubCuenta,'') = ISNULL(@SubCuentaAux,'')
						
						IF @OrigenTipo = 'COMS'
							SELECT @SLRenglonID = RenglonID 
							  FROM CompraD
							 WHERE ID = @IDOrigen
							   AND Articulo = @Articulo
							   AND ISNULL(SubCuenta,'') = ISNULL(@SubCuentaAux,'')

						INSERT SerieLoteMov (Empresa,  Sucursal,  Modulo,  ID,  RenglonID,  Articulo,  SubCuenta, SerieLote, 
											 Cantidad, Tarima, AsignacionUbicacion)								 
								     VALUES (@Empresa, @Sucursal, @OrigenTipo, @IDOrigen, @SLRenglonID, @Articulo, ISNULL(@SubCuentaAux,''), @SerieLote,
											 @CantidadA, @TarimaSurtido, 0)
					END								 
					----------------------------------------------------														
				END
				--------------------------------------------------------------------------------------------------------
								
				UPDATE @TMASurtido 
				   SET CantidadPicking = CantidadPicking - @CantidadA,
					   CantidadPendiente = CantidadPendiente - @CantidadA,
					   CantidadUnidad = CantidadUnidad - @CantidadA
				 WHERE ID = @ID 
				   AND Articulo = @Articulo 
				   AND CantidadPicking > 0
				   
				   
				IF EXISTS(SELECT * 
							FROM @TMASurtido A 
							JOIN TMA B ON A.ID = B.ID 
							JOIN TMAD C ON A.ID = C.ID 
							 AND A.Articulo = C.Articulo
						   WHERE A.ID = @ID
							 AND A.CantidadPicking = 0)
					BEGIN
						UPDATE C SET C.CantidadPicking	 = A.CantidadPicking,
									 C.CantidadPendiente = A.CantidadPendiente,
									 C.CantidadUnidad    = A.CantidadUnidad
								FROM @TMASurtido A
								JOIN TMA B
								  ON A.ID = B.ID
								JOIN TMAD C
								  ON A.ID = C.ID
								 AND A.Articulo = C.Articulo
							   WHERE A.ID = @ID								
							   
						EXEC spAfectar 'TMA', @ID, 'CANCELAR', @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
					END
				
				IF EXISTS(SELECT * FROM @TMASurtido A WHERE A.ID = @ID AND Articulo = @Articulo AND A.CantidadPicking > 0)
					UPDATE C
					   SET C.CantidadPicking	= A.CantidadPicking,
						   C.CantidadPendiente	= A.CantidadPendiente,
						   C.CantidadUnidad		= A.CantidadUnidad
					  FROM @TMASurtido A
					  JOIN TMA B
						ON A.ID = B.ID
					  JOIN TMAD C
						ON A.ID = C.ID
					   AND A.Articulo = C.Articulo
					 WHERE A.ID = @ID
					   AND A.CantidadPicking > 0						   

				EXEC spAfectar 'TMA', @GenerarID, 'AFECTAR', @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
				
				IF @Ok IS NULL
					BEGIN
						SELECT @ModuloD = 'TMA', @MovIDD = MovID FROM TMA WHERE ID = @ID
						EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @OrigenTipo, @IDOrigen, @MovOrigen, @MovIDOrigen, @ModuloD, @GenerarID, @Mov, @MovIDD, @Ok OUTPUT
					END
			END	
			-----------------------------------------------------------------------------------------------------------------------------------------
			FETCH NEXT FROM CrTarimas INTO @ID, @Empresa, @Tarima, @SerieLote, @Articulo, @Almacen, @Posicion, @Disponible, @CantidadA, @OrigenTipo 
		END
		
		CLOSE CrTarimas
		DEALLOCATE CrTarimas

	IF @Ok IS NULL
		COMMIT TRAN	
	ELSE
		ROLLBACK TRAN			
END
GO
/****************************************   spWMSSurtidosXProcesar   *************************************************/
IF EXISTS(SELECT * FROM SysObjects WHERE name = 'spWMSSurtidosXProcesar' AND type = 'P') DROP PROCEDURE spWMSSurtidosXProcesar
GO
CREATE PROCEDURE spWMSSurtidosXProcesar
		@Estacion	int
		--@Borrar		int

--//WITH ENCRYPTION
AS 
BEGIN
	DECLARE
		@CrID			int,
		@CrModulo		varchar(5),
		@CrMov			varchar(20),
		@CrMovID		varchar(20),
		@CrMFID			int,
		@CrMFModulo		varchar(5),
		@CrMFSalir		bit
	
	DECLARE @SurtidosXProcesar AS TABLE(Estacion			int			NOT NULL,
									    ID					int			NOT NULL,
									    Modulo				varchar(5)	NOT NULL,
									    Mov					varchar(20)	NOT NULL,
									    MovID				varchar(20)	NOT NULL,
									    Empresa				varchar(5)	NOT NULL,
									    Sucursal			int			NOT NULL,
									    Almacen				varchar(10) NOT NULL,
									    Articulo			varchar(20) NOT NULL,
									    SubCuenta			varchar(50) NULL,
									    Zona				varchar(50) NULL,
									    CantidadPicking		float		NOT NULL,
									    Tarima				varchar(20)	NULL,
									    Posicion			varchar(10) NULL,
									    OrigenTipo			varchar(10) NOT NULL,
									    Origen				varchar(20) NOT NULL,
									    OrigenID			varchar(20) NOT NULL,
									    OrigenMovID			int			NULL
									    )
	
	--DELETE FROM WMSTarimaSurtido WHERE Estacion = @Estacion
	DELETE FROM @SurtidosXProcesar WHERE Estacion = @Estacion

	/*****     VENTAS     *****/
	INSERT INTO @SurtidosXProcesar(Estacion, ID, Modulo, Mov, MovID, Empresa, Sucursal, Almacen, Articulo,
								   SubCuenta, Zona, CantidadPicking, Tarima, Posicion, OrigenTipo, Origen, OrigenID, OrigenMovID)
				   SELECT DISTINCT @Estacion, A.ID, 'TMA', A.Mov, A.MovID, A.Empresa, A.Sucursal, A.Almacen, B.Articulo,
								   ISNULL(B.Subcuenta,''), B.Zona, B.CantidadPicking, B.Tarima, B.Posicion, A.OrigenTipo, A.Origen, E.ID, A.OrigenID
							  FROM TMA A 
							  JOIN TMAD B
							    ON A.ID = B.ID
							  JOIN MovTipo C
							    ON C.Modulo = 'TMA'
							   AND A.Mov = C.Mov 
							  JOIN Venta E 
							    ON A.Origen = E.Mov
							   AND A.OrigenID = E.MovID 
							  JOIN VentaD F 
							    ON E.ID = F.ID 
							   AND B.Articulo = F.Articulo
							   AND ISNULL(B.SubCuenta,'')=ISNULL(F.SubCuenta,'')
							 WHERE C.Clave IN ('TMA.OSUR','TMA.OPCKTARIMA') 
							   AND A.Estatus = 'PENDIENTE'
							   AND F.Tarima IS NOT NULL
							   AND F.CantidadPendiente > 0
						
	/*****     COMPRAS     *****/
	INSERT INTO @SurtidosXProcesar(Estacion, ID, Modulo, Mov, MovID, Empresa, Sucursal, Almacen, Articulo,
								   SubCuenta, Zona, CantidadPicking, Tarima, Posicion, OrigenTipo, Origen, OrigenID, OrigenMovID)
				   SELECT DISTINCT @Estacion, A.ID, 'TMA', A.Mov, A.MovID, A.Empresa, A.Sucursal, A.Almacen, B.Articulo,
								   ISNULL(B.Subcuenta,''), B.Zona, B.CantidadPicking, B.Tarima, B.Posicion, A.OrigenTipo, A.Origen, E.ID, A.OrigenID
							  FROM TMA A 
							  JOIN TMAD B
							    ON A.ID = B.ID
							  JOIN MovTipo C
							    ON C.Modulo = 'TMA'
							   AND A.Mov = C.Mov 
							  JOIN Compra E 
							    ON A.Origen = E.Mov
							   AND A.OrigenID = E.MovID 
							  JOIN CompraD F 
							    ON E.ID = F.ID 
							   AND B.Articulo = F.Articulo
							   AND ISNULL(B.SubCuenta,'')=ISNULL(F.SubCuenta,'')							    
							 WHERE C.Clave IN ('TMA.OSUR','TMA.OPCKTARIMA') 
							   AND A.Estatus = 'PENDIENTE'
							   AND F.Tarima IS NOT NULL
							   AND F.CantidadPendiente > 0									   
	
	/*****     INVENTARIOS     *****/
	INSERT INTO @SurtidosXProcesar(Estacion, ID, Modulo, Mov, MovID, Empresa, Sucursal, Almacen, Articulo,
								   SubCuenta, Zona, CantidadPicking, Tarima, Posicion, OrigenTipo, Origen, OrigenID, OrigenMovID)
				   SELECT DISTINCT @Estacion, A.ID, 'TMA', A.Mov, A.MovID, A.Empresa, A.Sucursal, A.Almacen, B.Articulo,
								   ISNULL(B.Subcuenta,''), B.Zona, B.CantidadPicking, B.Tarima, B.Posicion, A.OrigenTipo, A.Origen, E.ID, A.OrigenID
							  FROM TMA A 
							  JOIN TMAD B
							    ON A.ID = B.ID
							  JOIN MovTipo C
							    ON C.Modulo = 'TMA'
							   AND A.Mov = C.Mov 
							  JOIN Inv E 
							    ON A.Origen = E.Mov
							   AND A.OrigenID = E.MovID 
							  JOIN InvD F 
							    ON E.ID = F.ID
							   AND B.Articulo = F.Articulo
							   AND ISNULL(B.SubCuenta,'')=ISNULL(F.SubCuenta,'')							    
							 WHERE C.Clave IN ('TMA.OSUR','TMA.OPCKTARIMA') 
							   AND A.Estatus = 'PENDIENTE'
							   AND F.Tarima IS NOT NULL
							   AND F.CantidadPendiente > 0
							   
	DECLARE CrOrdenSurtido CURSOR FOR
		SELECT ID, Modulo, Mov, MovID
		  FROM @SurtidosXProcesar
	
	OPEN CrOrdenSurtido
	FETCH NEXT FROM CrOrdenSurtido INTO @CrID, @CrModulo, @CrMov, @CrMovID
	
	WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @CrMFSalir = 0
			DECLARE CrMovFlujo CURSOR FOR
				SELECT DID, DModulo FROM MovFlujo WHERE OID = @CrID AND OModulo = @CrModulo
			
			OPEN CrMovFlujo
			FETCH NEXT FROM CrMovFlujo INTO @CrMFID, @CrMFModulo
			WHILE @@FETCH_STATUS = 0 AND @CrMFSalir = 0
				BEGIN
					IF @CrMFModulo = 'TMA'
						BEGIN
							IF EXISTS(SELECT * FROM TMA WHERE ID = @CrMFID AND Estatus <> 'CANCELADO')
								BEGIN
									SET @CrMFSalir = 1
									DELETE FROM @SurtidosXProcesar WHERE ID = @CrID
								END
						END
					FETCH NEXT FROM CrMovFlujo INTO @CrMFID, @CrMFModulo
				END
			CLOSE CrMovFlujo
			DEALLOCATE CrMovFlujo
		
			FETCH NEXT FROM CrOrdenSurtido INTO @CrID, @CrModulo, @CrMov, @CrMovID
		END
		
	CLOSE CrOrdenSurtido
	DEALLOCATE CrOrdenSurtido

	SELECT * FROM @SurtidosXProcesar ORDER BY Articulo, ID
	
END
GO

/**************** SPDesentarimarSurtidoPedido ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.SPDesentarimarSurtidoPedido') AND TYPE = 'P') DROP PROCEDURE dbo.SPDesentarimarSurtidoPedido
GO             
CREATE PROCEDURE SPDesentarimarSurtidoPedido
    		   @ID            int,
    		   @Empresa	      varchar(5),
               @Estacion      int,
               @Usuario       varchar(10) 
--//WITH ENCRYPTION
AS BEGIN
    DECLARE @IDGenerar      int,
            @FechaEmision   datetime,
            @Mov            varchar(20),
            @MovID          varchar(20),
            @MovGenerar     varchar(20),
            @Modulo         varchar(5),
            @ModuloGenerar  varchar(5),
            @Clave          varchar(20),
            @Subclave       varchar(20),
            @Moneda         varchar(10),
            @TipoCambio     float,
            @Estatus        varchar(15),
            @Almacen        varchar(10),
            @Agente	        varchar(10),
            @PosocionRec    varchar(10),
            @PosocionSur    varchar(10),
            @PosocionCD     varchar(10),
            @CrossDocking   bit,
            @Directo        bit,
            @Sucursal       int,
            @Articulo       varchar(20),
            @Cantidad       float,
            @Renglon        float,
            @RenglonSub     int,
            @RenglonIDD     int,
            @RenglonID      int,
            @RenglonTipo    varchar(1),
            @Unidad	        varchar(50),
            @Factor	        float,
            @Tarima	        varchar(20),
            @Disponible	    float,
            @Apartado       float,
            @Posicion       varchar(10),
            @Accion         varchar(20),
            @Base           varchar(20),
            @EnSilencio     bit,
            @OK             int

    SELECT @FechaEmision  = GETDATE(),
           @Modulo        = 'VTAS',
           @ModuloGenerar = 'INV',  
           @Clave         = 'INV.T', 
           @Subclave      = 'INV.TMA', 
           @Estatus       = 'SINAFECTAR',
           @CrossDocking  = 0,
           @Directo       = 1,
           @RenglonSub    = 0,
           @RenglonTipo   = 'L',
           @RenglonID     = 1,
           @Accion        = 'AFECTAR',
           @Base          = 'Todo',
           @EnSilencio    = 1

    SELECT @MovGenerar = Mov FROM MovTipo WHERE Modulo = @ModuloGenerar AND Clave = @Clave AND Subclave = @Subclave

    SELECT @Mov        = Mov,
           @MovID      = MovID,
           @Moneda     = Moneda,
           @TipoCambio = TipoCambio,
           @Almacen    = Almacen,
           @Agente     = Agente,
           @Sucursal   = Sucursal
      FROM Venta 
     WHERE ID = @ID

    SELECT @PosocionRec = DefPosicionRecibo, 
           @PosocionSur = DefPosicionSurtido, 
           @PosocionCD  = Defposicioncrossdocking 
      FROM Alm 
     WHERE Almacen = @Almacen

    INSERT Inv
              (Empresa, 
               Mov, 
               FechaEmision, 
               Moneda, 
               TipoCambio, 
               Estatus, 
               Directo, 
               RenglonID, 
               Almacen, 
               AlmacenDestino, 
               Vencimiento, 
               Usuario, 
               UltimoCambio, 
               OrigenTipo, 
               Origen, 
               OrigenID, 
               FechaRequerida, 
               Sucursal, 
               SucursalOrigen, 
               Agente, 
               SubModulo, 
               PosicionWMS, 
               PosicionDWMS, 
               CrossDocking
              )
        VALUES
              (@Empresa, 
               @MovGenerar, 
               @FechaEmision, 
               @Moneda, 
               @TipoCambio, 
               @Estatus, 
               @Directo,
               @RenglonID, 
               @Almacen, 
               @Almacen, 
               @FechaEmision, 
               @Empresa, 
               @FechaEmision, 
               @Modulo, 
               @Mov, 
               @MovID,  
               @FechaEmision, 
               @Sucursal, 
               @Sucursal, 
               @Agente, 
               @ModuloGenerar, 
               @PosocionSur, 
               @PosocionRec, 
               @CrossDocking
              )

    SELECT @IDGenerar = @@IDENTITY

    DECLARE crArtVtas CURSOR FOR
        SELECT Articulo, SUM(Cantidad)
          FROM VentaD 
         WHERE ID = @ID 
         GROUP BY Articulo

	OPEN crArtVtas
	FETCH NEXT FROM crArtVtas INTO @Articulo, @Cantidad
	WHILE @@FETCH_STATUS = 0 
	BEGIN
        SELECT @Renglon    =  ISNULL(@Renglon,0) + 2048
        SELECT @RenglonIDD =  ISNULL(@RenglonIDD,0) + 1 
                        
        SELECT @Unidad     = Unidad,
               @Factor     = Factor,
               @Tarima     = ISNULL(Tarima,'')
          FROM VentaD 
         WHERE ID = @ID 
          AND Articulo = @Articulo

        SELECT @Disponible = Disponible,
               @Apartado   = Apartado
          FROM ArtDisponibleTarima 
         WHERE Empresa  = @Empresa 
           AND Articulo = @Articulo 
           AND Almacen  = @Almacen
           AND Tarima   = @Tarima
           AND Disponible > 0

        SELECT @Posicion = Posicion FROM Tarima WHERE Tarima = @Tarima

        IF @Tarima = ''
            SELECT @OK = 1

        IF @Tarima <> '' AND ROUND(ISNULL(@Disponible,0),3) = ROUND(@Cantidad,3)
		BEGIN
            INSERT InvD
                       (ID,         
                        Renglon,  
                        RenglonSub,  
                        RenglonID,   
                        RenglonTipo, 
                        Almacen,   
                        Articulo,  
                        Cantidad,  
                        Unidad,  
                        Factor, 
                        CantidadInventario, 
                        FechaRequerida, 
                        Sucursal,  
                        SucursalOrigen, 
                        Tarima,  
                        PosicionActual,
                        PosicionReal
                       )
                    VALUES
                       (@IDGenerar, 
                        @Renglon, 
                        @RenglonSub, 
                        @RenglonIDD, 
                        @RenglonTipo, 
                        @Almacen, 
                        @Articulo, 
                        @Cantidad, 
                        @Unidad, 
                        @Factor, 
                        @Cantidad,         
                        @FechaEmision,  
                        @Sucursal, 
                        @Sucursal,      
                        @Tarima, 
                        @Posicion,      
                        @Posicion
                       )
        END
		FETCH NEXT FROM crArtVtas INTO @Articulo, @Cantidad
	END
	CLOSE crArtVtas
	DEALLOCATE crArtVtas
    
    /* Se elimina el movimiento por que no encontro Tarima */
    IF @OK = 1
    BEGIN       
        DELETE Inv WHERE ID = @IDGenerar
        DELETE InvD WHERE ID = @IDGenerar
    END
    ELSE
    BEGIN
        IF NOT EXISTS (SELECT * FROM InvD WHERE ID = @IDGenerar)
            DELETE Inv WHERE ID = @IDGenerar
        ELSE
            EXEC spAfectar @ModuloGenerar, @IDGenerar, @Accion, @Base, NULL, @Usuario, @EnSilencio = @EnSilencio, @Estacion = @Estacion
    END
END
GO

PRINT "******************* SP TMA ******************"
GO
