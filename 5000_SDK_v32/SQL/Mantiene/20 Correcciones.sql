/******** Correcciones ************/

IF (SELECT Version FROM Version)<=235
  EXEC ("spReEncabezadosCompraVenta")
GO

/* Reparar Auxiliares */
/*IF (SELECT Version FROM Version)<=301
BEGIN
  EXEC("update Auxiliar
     SET Fecha = m.FechaEmision,
         Ejercicio = m.Ejercicio,
         Periodo = m.Periodo
    from Auxiliar a, Mov m
   where a.Empresa = m.Empresa AND a.Modulo = m.Modulo AND m.ID = a.ModuloID 
     and a.EsCancelacion = 1 and a.Fecha<>m.FechaEmision")

  EXEC("update AuxiliarU
     SET Fecha = m.FechaEmision,
         Ejercicio = m.Ejercicio,
         Periodo = m.Periodo
    from AuxiliarU a, Mov m
   where a.Empresa = m.Empresa AND a.Modulo = m.Modulo AND m.ID = a.ModuloID 
     and a.EsCancelacion = 1 and a.Fecha<>m.FechaEmision") 

  EXEC("update AuxiliarRU
     SET Fecha = m.FechaEmision,
         Ejercicio = m.Ejercicio,
         Periodo = m.Periodo
    from AuxiliarRU a, Mov m
   where a.Empresa = m.Empresa AND a.Modulo = m.Modulo AND m.ID = a.ModuloID 
     and a.EsCancelacion = 1 and a.Fecha<>m.FechaEmision")

  EXEC("update AuxiliarR
     SET Fecha = m.FechaEmision,
         Ejercicio = m.Ejercicio,
         Periodo = m.Periodo
    from AuxiliarR a, Mov m
   where a.Empresa = m.Empresa AND a.Modulo = m.Modulo AND m.ID = a.ModuloID 
     and a.EsCancelacion = 1 and a.Fecha<>m.FechaEmision")
END*/
GO

/* Reconstruir Ramas */
--IF (SELECT Version FROM Version)<=301
--  EXEC spReconstruirRamas
GO

/* Reconstruir Saldos Iniciales */
--IF (SELECT Version FROM Version)<=301
--  EXEC spReconstruirSaldosIniciales
GO

/* Resumen del Articulo */
IF (SELECT Version FROM Version)<=302
BEGIN
  EXEC("ALTER TABLE VentaD DISABLE TRIGGER ALL")
  EXEC("UPDATE VentaD SET Almacen = e.Almacen FROM Venta e, VentaD d WHERE e.ID = d.ID AND d.Almacen IS NULL")
  EXEC("ALTER TABLE VentaD ENABLE TRIGGER ALL")
END
GO
IF (SELECT Version FROM Version)<=302
BEGIN
  EXEC("ALTER TABLE InvD DISABLE TRIGGER ALL")
  EXEC("UPDATE InvD   SET Almacen = e.Almacen FROM Inv e,   InvD d   WHERE e.ID = d.ID AND d.Almacen IS NULL")
  EXEC("ALTER TABLE InvD ENABLE TRIGGER ALL")
END
GO
IF (SELECT Version FROM Version)<=302
BEGIN
  EXEC("ALTER TABLE InvD DISABLE TRIGGER ALL")
  EXEC("UPDATE InvD   SET Almacen = e.AlmacenDestino FROM Inv e, InvD d, MovTipo mt WHERE e.ID = d.ID AND mt.Modulo = 'INV' AND mt.Mov = e.Mov AND mt.Clave = 'INV.EI' AND d.Almacen IS NULL")
  EXEC("ALTER TABLE InvD ENABLE TRIGGER ALL")
END
GO

/* Verificar Anticipos Repetidos
  ** CXC **
select e.ID, e.Mov, e.MovID, "Encabezado" = round(e.Importe,0), "Detalle" = round(sum(d.Importe), 0)
  from cxc e, cxcd d, MovTipo mt
 where e.id = d.id and e.mov = mt.mov and mt.modulo = 'CXC' and mt.Clave = 'CXC.A'
 group by e.ID, e.Mov, e.MovID, e.Importe
having round(e.Importe,0) <>round(sum(d.Importe), 0)

  ** CXP **
select e.ID, e.Mov, e.MovID, "Encabezado" = round(e.Importe,0), "Detalle" = round(sum(d.Importe), 0)
  from cxp e, cxpd d, MovTipo mt
 where e.id = d.id and e.mov = mt.mov and mt.modulo = 'CXP' and mt.Clave = 'CXP.A'
 group by e.ID, e.Mov, e.MovID, e.Importe
having round(e.Importe,0) <>round(sum(d.Importe), 0)

*/
/* Corregir Anticipos Cxc */
IF (SELECT Version FROM Version)<=303
  EXEC spAutoFixAnticipos 'CXC'
GO

/* Corregir Anticipos Cxp */
IF (SELECT Version FROM Version)<=303
  EXEC spAutoFixAnticipos 'CXP'
GO
