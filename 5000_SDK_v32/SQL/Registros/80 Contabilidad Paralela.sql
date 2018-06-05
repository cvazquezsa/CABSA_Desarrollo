DELETE ContParalelaXMLPlantilla
GO
if not exists(select * from ContParalelaXMLPlantilla where Modulo = '')
  INSERT INTO ContParalelaXMLPlantilla(Modulo, Consulta) SELECT '', '
      SELECT Cont.ID, Cont.Empresa, Cont.Mov, Cont.MovID, Cont.FechaEmision, Cont.FechaContable, Cont.Concepto, Cont.Proyecto, Cont.UEN, Cont.Contacto, Cont.ContactoTipo, Cont.Moneda, Cont.TipoCambio, Cont.Usuario, Cont.Referencia, Cont.Estatus, Cont.OrigenTipo, Cont.Origen, Cont.OrigenID, Cont.Ejercicio, Cont.Periodo, Cont.Sucursal, Cont.Importe, NULLIF(ContParalelaMovDato.Fecha, NULL) ''RecepcionFecha'', NULLIF(RTRIM(ContParalelaMovDato.Moneda), '''') ''RecepcionMoneda'', NULLIF(ContParalelaMovDato.TipoCambio, 0) ''RecepcionTipoCambio'', Cont.OrigenMoneda, Cont.OrigenTipoCambio,
             ContD.ID, ContD.Renglon, ContD.RenglonSub, ContD.Cuenta, ContD.Debe, ContD.Haber
        FROM Cont
        JOIN ContD ON Cont.ID = ContD.ID
        JOIN ContParalelaD ON Cont.ID = ContParalelaD.ContID
        JOIN MovTipo ON Cont.Mov = MovTipo.Mov AND MovTipo.Modulo = ''CONT''        
        LEFT OUTER JOIN ContParalelaMovDato ON ContParalelaMovDato.Modulo = ''CONT'' AND ContParalelaMovDato.ModuloID = Cont.ID'
        
if not exists(select * from ContParalelaXMLPlantilla where Modulo = 'DIN')
  INSERT INTO ContParalelaXMLPlantilla(Modulo, Consulta) SELECT 'DIN', '
      SELECT Cont.ID, Cont.Empresa, Cont.Mov, Cont.MovID, Cont.FechaEmision, Cont.FechaContable, Cont.Concepto, Cont.Proyecto, Cont.UEN, Cont.Contacto, Cont.ContactoTipo, Cont.Moneda, Cont.TipoCambio, Cont.Usuario, Cont.Referencia, Cont.Estatus, Cont.OrigenTipo, Cont.Origen, Cont.OrigenID, Cont.Ejercicio, Cont.Periodo, Cont.Sucursal, Cont.Importe, Cont.OrigenMoneda, Cont.OrigenTipoCambio, NULLIF(ContParalelaMovDato.Fecha, NULL) ''RecepcionFecha'', NULLIF(RTRIM(ContParalelaMovDato.Moneda), '''') ''RecepcionMoneda'', NULLIF(ContParalelaMovDato.TipoCambio, 0) ''RecepcionTipoCambio'',
             ContD.ID, ContD.Renglon, ContD.RenglonSub, ContD.Cuenta, ContD.Debe, ContD.Haber,
             Origen.ID, Origen.Mov, Origen.MovID, Origen.FechaEmision, Origen.Concepto, Origen.Proyecto, Origen.UEN, Origen.Moneda, Origen.TipoCambio, Origen.Usuario, Origen.Referencia, Origen.Estatus, Origen.Importe, Origen.Impuestos, Origen.Ejercicio, Origen.Periodo, ISNULL(MovTipo.Clave, '''') ''MovTipo'', ISNULL(MovTipo.SubClave, '''') ''SubMovTipo'', ''DIN'' ''Modulo''
        FROM Cont
        JOIN ContD ON Cont.ID = ContD.ID
        JOIN Dinero Origen ON Origen.Mov = Cont.Origen AND Origen.MovID = Cont.OrigenID AND Cont.Empresa = Origen.Empresa    
        JOIN ContParalelaD ON Cont.ID = ContParalelaD.ContID
        JOIN MovTipo ON Origen.Mov = MovTipo.Mov AND MovTipo.Modulo = ''DIN''        
        LEFT OUTER JOIN ContParalelaMovDato ON ContParalelaMovDato.Modulo = ''DIN'' AND ContParalelaMovDato.ModuloID = Origen.ID'
        
if not exists(select * from ContParalelaXMLPlantilla where Modulo = 'EMB')
  INSERT INTO ContParalelaXMLPlantilla(Modulo, Consulta) SELECT 'EMB', '
      SELECT Cont.ID, Cont.Empresa, Cont.Mov, Cont.MovID, Cont.FechaEmision, Cont.FechaContable, Cont.Concepto, Cont.Proyecto, Cont.UEN, Cont.Contacto, Cont.ContactoTipo, Cont.Moneda, Cont.TipoCambio, Cont.Usuario, Cont.Referencia, Cont.Estatus, Cont.OrigenTipo, Cont.Origen, Cont.OrigenID, Cont.Ejercicio, Cont.Periodo, Cont.Sucursal, Cont.Importe, Cont.OrigenMoneda, Cont.OrigenTipoCambio, NULLIF(ContParalelaMovDato.Fecha, NULL) ''RecepcionFecha'', NULLIF(RTRIM(ContParalelaMovDato.Moneda), '''') ''RecepcionMoneda'', NULLIF(ContParalelaMovDato.TipoCambio, 0) ''RecepcionTipoCambio'',
             ContD.ID, ContD.Renglon, ContD.RenglonSub, ContD.Cuenta, ContD.Debe, ContD.Haber,      
             Origen.ID, Origen.Mov, Origen.MovID, Origen.FechaEmision, Origen.Concepto, Origen.Proyecto, Origen.UEN, Origen.Moneda, Origen.TipoCambio, Origen.Usuario, Origen.Referencia, Origen.Estatus, Origen.Importe, Origen.Impuestos, Origen.Ejercicio, Origen.Periodo,  ISNULL(MovTipo.Clave, '''') ''MovTipo'', ISNULL(MovTipo.SubClave, '''') ''SubMovTipo'', ''EMB'' ''Modulo''
        FROM Cont
        JOIN ContD ON Cont.ID = ContD.ID
        JOIN Embarque Origen ON Origen.Mov = Cont.Origen AND Origen.MovID = Cont.OrigenID AND Cont.Empresa = Origen.Empresa    
        JOIN ContParalelaD ON Cont.ID = ContParalelaD.ContID
        JOIN MovTipo ON Origen.Mov = MovTipo.Mov AND MovTipo.Modulo = ''EMB''        
        LEFT OUTER JOIN ContParalelaMovDato ON ContParalelaMovDato.Modulo = ''EMB'' AND ContParalelaMovDato.ModuloID = Origen.ID'

if not exists(select * from ContParalelaXMLPlantilla where Modulo = 'INV')
  INSERT INTO ContParalelaXMLPlantilla(Modulo, Consulta) SELECT 'INV', '
      SELECT Cont.ID, Cont.Empresa, Cont.Mov, Cont.MovID, Cont.FechaEmision, Cont.FechaContable, Cont.Concepto, Cont.Proyecto, Cont.UEN, Cont.Contacto, Cont.ContactoTipo, Cont.Moneda, Cont.TipoCambio, Cont.Usuario, Cont.Referencia, Cont.Estatus, Cont.OrigenTipo, Cont.Origen, Cont.OrigenID, Cont.Ejercicio, Cont.Periodo, Cont.Sucursal, Cont.Importe, Cont.OrigenMoneda, Cont.OrigenTipoCambio, NULLIF(ContParalelaMovDato.Fecha, NULL) ''RecepcionFecha'', NULLIF(RTRIM(ContParalelaMovDato.Moneda), '''') ''RecepcionMoneda'', NULLIF(ContParalelaMovDato.TipoCambio, 0) ''RecepcionTipoCambio'',
             ContD.ID, ContD.Renglon, ContD.RenglonSub, ContD.Cuenta, ContD.Debe, ContD.Haber,      
             Origen.ID, Origen.Mov, Origen.MovID, Origen.FechaEmision, Origen.Concepto, Origen.Proyecto, Origen.UEN, Origen.Moneda, Origen.TipoCambio, Origen.Usuario, Origen.Referencia, Origen.Estatus, Origen.Almacen, Origen.Condicion, Origen.Vencimiento, Origen.Importe, Origen.Ejercicio, Origen.Periodo,  ISNULL(MovTipo.Clave, '''') ''MovTipo'', ISNULL(MovTipo.SubClave, '''') ''SubMovTipo'', ''INV'' ''Modulo''
        FROM Cont
        JOIN ContD ON Cont.ID = ContD.ID
        JOIN Inv Origen ON Origen.Mov = Cont.Origen AND Origen.MovID = Cont.OrigenID AND Cont.Empresa = Origen.Empresa    
        JOIN ContParalelaD ON Cont.ID = ContParalelaD.ContID
        JOIN MovTipo ON Origen.Mov = MovTipo.Mov AND MovTipo.Modulo = ''INV''
        LEFT OUTER JOIN ContParalelaMovDato ON ContParalelaMovDato.Modulo = ''INV'' AND ContParalelaMovDato.ModuloID = Origen.ID'
        
if not exists(select * from ContParalelaXMLPlantilla where Modulo = 'NOM')
  INSERT INTO ContParalelaXMLPlantilla(Modulo, Consulta) SELECT 'NOM', '
      SELECT Cont.ID, Cont.Empresa, Cont.Mov, Cont.MovID, Cont.FechaEmision, Cont.FechaContable, Cont.Concepto, Cont.Proyecto, Cont.UEN, Cont.Contacto, Cont.ContactoTipo, Cont.Moneda, Cont.TipoCambio, Cont.Usuario, Cont.Referencia, Cont.Estatus, Cont.OrigenTipo, Cont.Origen, Cont.OrigenID, Cont.Ejercicio, Cont.Periodo, Cont.Sucursal, Cont.Importe, Cont.OrigenMoneda, Cont.OrigenTipoCambio,NULLIF(ContParalelaMovDato.Fecha, NULL) ''RecepcionFecha'', NULLIF(RTRIM(ContParalelaMovDato.Moneda), '''') ''RecepcionMoneda'', NULLIF(ContParalelaMovDato.TipoCambio, 0) ''RecepcionTipoCambio'',
             ContD.ID, ContD.Renglon, ContD.RenglonSub, ContD.Cuenta, ContD.Debe, ContD.Haber,  
             Origen.ID, Origen.Mov, Origen.MovID, Origen.FechaEmision, Origen.Concepto, Origen.Proyecto, Origen.UEN, Origen.Moneda, Origen.TipoCambio, Origen.Usuario, Origen.Estatus, Origen.Condicion, Origen.Ejercicio, Origen.Periodo,  ISNULL(MovTipo.Clave, '''') ''MovTipo'', ISNULL(MovTipo.SubClave, '''') ''SubMovTipo'', ''NOM'' ''Modulo''
        FROM Cont
        JOIN ContD ON Cont.ID = ContD.ID
        JOIN Nomina Origen ON Origen.Mov = Cont.Origen AND Origen.MovID = Cont.OrigenID AND Cont.Empresa = Origen.Empresa    
        JOIN ContParalelaD ON Cont.ID = ContParalelaD.ContID
        JOIN MovTipo ON Origen.Mov = MovTipo.Mov AND MovTipo.Modulo = ''NOM''
        LEFT OUTER JOIN ContParalelaMovDato ON ContParalelaMovDato.Modulo = ''NOM'' AND ContParalelaMovDato.ModuloID = Origen.ID'

if not exists(select * from ContParalelaXMLPlantilla where Modulo = 'PROD')
  INSERT INTO ContParalelaXMLPlantilla(Modulo, Consulta) SELECT 'PROD', '
      SELECT Cont.ID, Cont.Empresa, Cont.Mov, Cont.MovID, Cont.FechaEmision, Cont.FechaContable, Cont.Concepto, Cont.Proyecto, Cont.UEN, Cont.Contacto, Cont.ContactoTipo, Cont.Moneda, Cont.TipoCambio, Cont.Usuario, Cont.Referencia, Cont.Estatus, Cont.OrigenTipo, Cont.Origen, Cont.OrigenID, Cont.Ejercicio, Cont.Periodo, Cont.Sucursal, Cont.Importe, Cont.OrigenMoneda, Cont.OrigenTipoCambio,NULLIF(ContParalelaMovDato.Fecha, NULL) ''RecepcionFecha'', NULLIF(RTRIM(ContParalelaMovDato.Moneda), '''') ''RecepcionMoneda'', NULLIF(ContParalelaMovDato.TipoCambio, 0) ''RecepcionTipoCambio'',
             ContD.ID, ContD.Renglon, ContD.RenglonSub, ContD.Cuenta, ContD.Debe, ContD.Haber,      
             Origen.ID, Origen.Mov, Origen.MovID, Origen.FechaEmision, Origen.Concepto, Origen.Proyecto, Origen.UEN, Origen.Moneda, Origen.TipoCambio, Origen.Usuario, Origen.Referencia, Origen.Estatus, Origen.Almacen, Origen.Importe, Origen.Ejercicio, Origen.Periodo,  ISNULL(MovTipo.Clave, '''') ''MovTipo'', ISNULL(MovTipo.SubClave, '''') ''SubMovTipo'', ''PROD'' ''Modulo''
        FROM Cont
        JOIN ContD ON Cont.ID = ContD.ID
        JOIN Prod Origen ON Origen.Mov = Cont.Origen AND Origen.MovID = Cont.OrigenID AND Cont.Empresa = Origen.Empresa    
        JOIN ContParalelaD ON Cont.ID = ContParalelaD.ContID
        JOIN MovTipo ON Origen.Mov = MovTipo.Mov AND MovTipo.Modulo = ''PROD''
        LEFT OUTER JOIN ContParalelaMovDato ON ContParalelaMovDato.Modulo = ''PROD'' AND ContParalelaMovDato.ModuloID = Origen.ID'

if not exists(select * from ContParalelaXMLPlantilla where Modulo = 'VTAS')
  INSERT INTO ContParalelaXMLPlantilla(Modulo, Consulta) SELECT 'VTAS', '
      SELECT Cont.ID, Cont.Empresa, Cont.Mov, Cont.MovID, Cont.FechaEmision, Cont.FechaContable, Cont.Concepto, Cont.Proyecto, Cont.UEN, Cont.Contacto, Cont.ContactoTipo, Cont.Moneda, Cont.TipoCambio, Cont.Usuario, Cont.Referencia, Cont.Estatus, Cont.OrigenTipo, Cont.Origen, Cont.OrigenID, Cont.Ejercicio, Cont.Periodo, Cont.Sucursal, Cont.Importe, NULLIF(ContParalelaMovDato.Fecha, NULL) ''RecepcionFecha'', NULLIF(RTRIM(ContParalelaMovDato.Moneda), '''') ''RecepcionMoneda'', NULLIF(ContParalelaMovDato.TipoCambio, 0) ''RecepcionTipoCambio'',
             Cont.OrigenMoneda, Cont.OrigenTipoCambio,
             ContD.ID, ContD.Renglon, ContD.RenglonSub, ContD.Cuenta, ContD.Debe, ContD.Haber,
             Origen.ID, Origen.Mov, Origen.MovID, Origen.FechaEmision, Origen.Concepto, Origen.Proyecto, Origen.UEN, Origen.Moneda, Origen.TipoCambio, Origen.Usuario, Origen.Referencia, Origen.Estatus, Origen.Cliente ''Contacto'', Origen.Almacen, Origen.Condicion, Origen.Vencimiento, Origen.Importe, Origen.Impuestos, Origen.Ejercicio, Origen.Periodo, ISNULL(MovTipo.Clave, '''') ''MovTipo'', ISNULL(MovTipo.SubClave, '''') ''SubMovTipo'', ''VTAS'' ''Modulo'',
             ''Cliente'' ContactoTipo, Contacto.Cliente ''Contacto'', Contacto.Nombre, Contacto.Direccion, Contacto.DireccionNumero, Contacto.DireccionNumeroInt, Contacto.EntreCalles, Contacto.Delegacion, Contacto.Colonia, Contacto.Poblacion, Contacto.Estado, Contacto.Pais, Contacto.CodigoPostal, Contacto.RFC, Contacto.CURP, Contacto.Categoria, Contacto.Grupo, Contacto.Familia
        FROM Cont
        JOIN ContD ON Cont.ID = ContD.ID
        JOIN Venta Origen ON Origen.Mov = Cont.Origen AND Origen.MovID = Cont.OrigenID AND Cont.Empresa = Origen.Empresa    
        JOIN Cte Contacto ON Origen.Cliente = Contacto.Cliente
        JOIN ContParalelaD ON Cont.ID = ContParalelaD.ContID
        JOIN MovTipo ON Origen.Mov = MovTipo.Mov AND MovTipo.Modulo = ''VTAS''
        LEFT OUTER JOIN ContParalelaMovDato ON ContParalelaMovDato.Modulo = ''VTAS'' AND ContParalelaMovDato.ModuloID = Origen.ID'

if not exists(select * from ContParalelaXMLPlantilla where Modulo = 'CXC')
  INSERT INTO ContParalelaXMLPlantilla(Modulo, Consulta) SELECT 'CXC', '
      SELECT Cont.ID, Cont.Empresa, Cont.Mov, Cont.MovID, Cont.FechaEmision, Cont.FechaContable, Cont.Concepto, Cont.Proyecto, Cont.UEN, Cont.Contacto, Cont.ContactoTipo, Cont.Moneda, Cont.TipoCambio, Cont.Usuario, Cont.Referencia, Cont.Estatus, Cont.OrigenTipo, Cont.Origen, Cont.OrigenID, Cont.Ejercicio, Cont.Periodo, Cont.Sucursal, Cont.Importe, Cont.OrigenMoneda, Cont.OrigenTipoCambio,NULLIF(ContParalelaMovDato.Fecha, NULL) ''RecepcionFecha'', NULLIF(RTRIM(ContParalelaMovDato.Moneda), '''') ''RecepcionMoneda'', NULLIF(ContParalelaMovDato.TipoCambio, 0) ''RecepcionTipoCambio'',
             ContD.ID, ContD.Renglon, ContD.RenglonSub, ContD.Cuenta, ContD.Debe, ContD.Haber,      
             Origen.ID, Origen.Mov, Origen.MovID, Origen.FechaEmision, Origen.Concepto, Origen.Proyecto, Origen.UEN, Origen.Moneda, Origen.TipoCambio, Origen.Usuario, Origen.Referencia, Origen.Estatus, Origen.Cliente ''Contacto'', Origen.Condicion, Origen.Vencimiento, Origen.Importe, Origen.Impuestos, Origen.Ejercicio, Origen.Periodo,  ISNULL(MovTipo.Clave, '''') ''MovTipo'', ISNULL(MovTipo.SubClave, '''') ''SubMovTipo'', ''CXC'' ''Modulo'',
             ''Cliente'' ContactoTipo, Contacto.Cliente ''Contacto'', Contacto.Nombre, Contacto.Direccion, Contacto.DireccionNumero, Contacto.DireccionNumeroInt, Contacto.EntreCalles, Contacto.Delegacion, Contacto.Colonia, Contacto.Poblacion, Contacto.Estado, Contacto.Pais, Contacto.CodigoPostal, Contacto.RFC, Contacto.CURP, Contacto.Categoria, Contacto.Grupo, Contacto.Familia
        FROM Cont
        JOIN ContD ON Cont.ID = ContD.ID
        JOIN Cxc Origen ON Origen.Mov = Cont.Origen AND Origen.MovID = Cont.OrigenID AND Cont.Empresa = Origen.Empresa    
        JOIN Cte Contacto ON Origen.Cliente = Contacto.Cliente
        JOIN ContParalelaD ON Cont.ID = ContParalelaD.ContID
        JOIN MovTipo ON Origen.Mov = MovTipo.Mov AND MovTipo.Modulo = ''CXC''        
        LEFT OUTER JOIN ContParalelaMovDato ON ContParalelaMovDato.Modulo = ''CXC'' AND ContParalelaMovDato.ModuloID = Origen.ID'

if not exists(select * from ContParalelaXMLPlantilla where Modulo = 'AF')
  INSERT INTO ContParalelaXMLPlantilla(Modulo, Consulta) SELECT 'AF', '
      SELECT Cont.ID, Cont.Empresa, Cont.Mov, Cont.MovID, Cont.FechaEmision, Cont.FechaContable, Cont.Concepto, Cont.Proyecto, Cont.UEN, Cont.Contacto, Cont.ContactoTipo, Cont.Moneda, Cont.TipoCambio, Cont.Usuario, Cont.Referencia, Cont.Estatus, Cont.OrigenTipo, Cont.Origen, Cont.OrigenID, Cont.Ejercicio, Cont.Periodo, Cont.Sucursal, Cont.Importe, Cont.OrigenMoneda, Cont.OrigenTipoCambio,NULLIF(ContParalelaMovDato.Fecha, NULL) ''RecepcionFecha'', NULLIF(RTRIM(ContParalelaMovDato.Moneda), '''') ''RecepcionMoneda'', NULLIF(ContParalelaMovDato.TipoCambio, 0) ''RecepcionTipoCambio'',
             ContD.ID, ContD.Renglon, ContD.RenglonSub, ContD.Cuenta, ContD.Debe, ContD.Haber,      
             Origen.ID, Origen.Mov, Origen.MovID, Origen.FechaEmision, Origen.Concepto, Origen.Proyecto, Origen.UEN, Origen.Moneda, Origen.TipoCambio, Origen.Usuario, Origen.Referencia, Origen.Estatus, Origen.Proveedor ''Contacto'', Origen.Condicion, Origen.Vencimiento, Origen.Importe, Origen.Impuestos, Origen.Ejercicio, Origen.Periodo,  ISNULL(MovTipo.Clave, '''') ''MovTipo'', ISNULL(MovTipo.SubClave, '''') ''SubMovTipo'', ''AF'' ''Modulo'',
             ''Proveedor'' ContactoTipo, Contacto.Proveedor ''Contacto'', Contacto.Nombre, Contacto.Direccion, Contacto.DireccionNumero, Contacto.DireccionNumeroInt, Contacto.EntreCalles, Contacto.Delegacion, Contacto.Colonia, Contacto.Poblacion, Contacto.Estado, Contacto.Pais, Contacto.CodigoPostal, Contacto.RFC, Contacto.CURP, Contacto.Categoria, Contacto.Familia
        FROM Cont
        JOIN ContD ON Cont.ID = ContD.ID
        JOIN ActivoFijo Origen ON Origen.Mov = Cont.Origen AND Origen.MovID = Cont.OrigenID AND Cont.Empresa = Origen.Empresa    
        JOIN Prov Contacto ON Origen.Proveedor = Contacto.Proveedor
        JOIN ContParalelaD ON Cont.ID = ContParalelaD.ContID
        JOIN MovTipo ON Origen.Mov = MovTipo.Mov AND MovTipo.Modulo = ''AF''        
        LEFT OUTER JOIN ContParalelaMovDato ON ContParalelaMovDato.Modulo = ''AF'' AND ContParalelaMovDato.ModuloID = Origen.ID'

if not exists(select * from ContParalelaXMLPlantilla where Modulo = 'COMS')
  INSERT INTO ContParalelaXMLPlantilla(Modulo, Consulta) SELECT 'COMS', '
      SELECT Cont.ID, Cont.Empresa, Cont.Mov, Cont.MovID, Cont.FechaEmision, Cont.FechaContable, Cont.Concepto, Cont.Proyecto, Cont.UEN, Cont.Contacto, Cont.ContactoTipo, Cont.Moneda, Cont.TipoCambio, Cont.Usuario, Cont.Referencia, Cont.Estatus, Cont.OrigenTipo, Cont.Origen, Cont.OrigenID, Cont.Ejercicio, Cont.Periodo, Cont.Sucursal, Cont.Importe, Cont.OrigenMoneda, Cont.OrigenTipoCambio, NULLIF(ContParalelaMovDato.Fecha, NULL) ''RecepcionFecha'', NULLIF(RTRIM(ContParalelaMovDato.Moneda), '''') ''RecepcionMoneda'', NULLIF(ContParalelaMovDato.TipoCambio, 0) ''RecepcionTipoCambio'',
             ContD.ID, ContD.Renglon, ContD.RenglonSub, ContD.Cuenta, ContD.Debe, ContD.Haber,      
             Origen.ID, Origen.Mov, Origen.MovID, Origen.FechaEmision, Origen.Concepto, Origen.Proyecto, Origen.UEN, Origen.Moneda, Origen.TipoCambio, Origen.Usuario, Origen.Referencia, Origen.Estatus, Origen.Proveedor ''Contacto'', Origen.Almacen, Origen.Condicion, Origen.Vencimiento, Origen.Importe, Origen.Impuestos, Origen.Ejercicio, Origen.Periodo,  ISNULL(MovTipo.Clave, '''') ''MovTipo'', ISNULL(MovTipo.SubClave, '''') ''SubMovTipo'', ''COMS'' ''Modulo'',
             ''Proveedor'' ContactoTipo, Contacto.Proveedor ''Contacto'', Contacto.Nombre, Contacto.Direccion, Contacto.DireccionNumero, Contacto.DireccionNumeroInt, Contacto.EntreCalles, Contacto.Delegacion, Contacto.Colonia, Contacto.Poblacion, Contacto.Estado, Contacto.Pais, Contacto.CodigoPostal, Contacto.RFC, Contacto.CURP, Contacto.Categoria, Contacto.Familia
        FROM Cont
        JOIN ContD ON Cont.ID = ContD.ID
        JOIN Compra Origen ON Origen.Mov = Cont.Origen AND Origen.MovID = Cont.OrigenID AND Cont.Empresa = Origen.Empresa    
        JOIN Prov Contacto ON Origen.Proveedor = Contacto.Proveedor
        JOIN ContParalelaD ON Cont.ID = ContParalelaD.ContID
        JOIN MovTipo ON Origen.Mov = MovTipo.Mov AND MovTipo.Modulo = ''COMS''
        LEFT OUTER JOIN ContParalelaMovDato ON ContParalelaMovDato.Modulo = ''COMS'' AND ContParalelaMovDato.ModuloID = Origen.ID'

if not exists(select * from ContParalelaXMLPlantilla where Modulo = 'CXP')
  INSERT INTO ContParalelaXMLPlantilla(Modulo, Consulta) SELECT 'CXP', '
      SELECT Cont.ID, Cont.Empresa, Cont.Mov, Cont.MovID, Cont.FechaEmision, Cont.FechaContable, Cont.Concepto, Cont.Proyecto, Cont.UEN, Cont.Contacto, Cont.ContactoTipo, Cont.Moneda, Cont.TipoCambio, Cont.Usuario, Cont.Referencia, Cont.Estatus, Cont.OrigenTipo, Cont.Origen, Cont.OrigenID, Cont.Ejercicio, Cont.Periodo, Cont.Sucursal, Cont.Importe, Cont.OrigenMoneda, Cont.OrigenTipoCambio, NULLIF(ContParalelaMovDato.Fecha, NULL) ''RecepcionFecha'', NULLIF(RTRIM(ContParalelaMovDato.Moneda), '''') ''RecepcionMoneda'', NULLIF(ContParalelaMovDato.TipoCambio, 0) ''RecepcionTipoCambio'',
             ContD.ID, ContD.Renglon, ContD.RenglonSub, ContD.Cuenta, ContD.Debe, ContD.Haber,      
             Origen.ID, Origen.Mov, Origen.MovID, Origen.FechaEmision, Origen.Concepto, Origen.Proyecto, Origen.UEN, Origen.Moneda, Origen.TipoCambio, Origen.Usuario, Origen.Referencia, Origen.Estatus, Origen.Proveedor ''Contacto'', Origen.Condicion, Origen.Vencimiento, Origen.Importe, Origen.Impuestos, Origen.Ejercicio, Origen.Periodo,  ISNULL(MovTipo.Clave, '''') ''MovTipo'', ISNULL(MovTipo.SubClave, '''') ''SubMovTipo'', ''CXP'' ''Modulo'',
             ''Proveedor'' ContactoTipo, Contacto.Proveedor ''Contacto'', Contacto.Nombre, Contacto.Direccion, Contacto.DireccionNumero, Contacto.DireccionNumeroInt, Contacto.EntreCalles, Contacto.Delegacion, Contacto.Colonia, Contacto.Poblacion, Contacto.Estado, Contacto.Pais, Contacto.CodigoPostal, Contacto.RFC, Contacto.CURP, Contacto.Categoria, Contacto.Familia
        FROM Cont
        JOIN ContD ON Cont.ID = ContD.ID
        JOIN Cxp Origen ON Origen.Mov = Cont.Origen AND Origen.MovID = Cont.OrigenID AND Cont.Empresa = Origen.Empresa    
        JOIN Prov Contacto ON Origen.Proveedor = Contacto.Proveedor
        JOIN ContParalelaD ON Cont.ID = ContParalelaD.ContID
        JOIN MovTipo ON Origen.Mov = MovTipo.Mov AND MovTipo.Modulo = ''CXP''
        LEFT OUTER JOIN ContParalelaMovDato ON ContParalelaMovDato.Modulo = ''CXP'' AND ContParalelaMovDato.ModuloID = Origen.ID'

if not exists(select * from ContParalelaXMLPlantilla where Modulo = 'GAS')
  INSERT INTO ContParalelaXMLPlantilla(Modulo, Consulta) SELECT 'GAS', '
      SELECT Cont.ID, Cont.Empresa, Cont.Mov, Cont.MovID, Cont.FechaEmision, Cont.FechaContable, Cont.Concepto, Cont.Proyecto, Cont.UEN, Cont.Contacto, Cont.ContactoTipo, Cont.Moneda, Cont.TipoCambio, Cont.Usuario, Cont.Referencia, Cont.Estatus, Cont.OrigenTipo, Cont.Origen, Cont.OrigenID, Cont.Ejercicio, Cont.Periodo, Cont.Sucursal, Cont.Importe, Cont.OrigenMoneda, Cont.OrigenTipoCambio, NULLIF(ContParalelaMovDato.Fecha, NULL) ''RecepcionFecha'', NULLIF(RTRIM(ContParalelaMovDato.Moneda), '''') ''RecepcionMoneda'', NULLIF(ContParalelaMovDato.TipoCambio, 0) ''RecepcionTipoCambio'',
             ContD.ID, ContD.Renglon, ContD.RenglonSub, ContD.Cuenta, ContD.Debe, ContD.Haber,
             Origen.ID, Origen.Mov, Origen.MovID, Origen.FechaEmision, Origen.Proyecto, Origen.UEN, Origen.Moneda, Origen.TipoCambio, Origen.Usuario, Origen.Estatus, Origen.Acreedor ''Contacto'', Origen.Condicion, Origen.Vencimiento, Origen.Importe, Origen.Impuestos, Origen.Ejercicio, Origen.Periodo,  ISNULL(MovTipo.Clave, '''') ''MovTipo'', ISNULL(MovTipo.SubClave, '''') ''SubMovTipo'', ''GAS'' ''Modulo'',
             ''Proveedor'' ContactoTipo, Contacto.Proveedor ''Contacto'', Contacto.Nombre, Contacto.Direccion, Contacto.DireccionNumero, Contacto.DireccionNumeroInt, Contacto.EntreCalles, Contacto.Delegacion, Contacto.Colonia, Contacto.Poblacion, Contacto.Estado, Contacto.Pais, Contacto.CodigoPostal, Contacto.RFC, Contacto.CURP, Contacto.Categoria, Contacto.Familia
        FROM Cont
        JOIN ContD ON Cont.ID = ContD.ID
        JOIN Gasto Origen ON Origen.Mov = Cont.Origen AND Origen.MovID = Cont.OrigenID AND Cont.Empresa = Origen.Empresa    
        JOIN Prov Contacto ON Origen.Acreedor = Contacto.Proveedor
        JOIN ContParalelaD ON Cont.ID = ContParalelaD.ContID
        JOIN MovTipo ON Origen.Mov = MovTipo.Mov AND MovTipo.Modulo = ''GAS''
        LEFT OUTER JOIN ContParalelaMovDato ON ContParalelaMovDato.Modulo = ''GAS'' AND ContParalelaMovDato.ModuloID = Origen.ID'
