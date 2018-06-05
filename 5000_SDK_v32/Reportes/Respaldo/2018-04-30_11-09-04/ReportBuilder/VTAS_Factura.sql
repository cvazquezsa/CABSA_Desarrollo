SELECT
      /*Sección Empresa*/
	  Empresa.Empresa[Empresa_Clave],
      Empresa.RFC [Empresa_RFC],
      UPPER(Empresa.Nombre) [Empresa_Nombre],
      Empresa.Direccion [Empresa_Direcion],
      Empresa.DireccionNumero [Empresa_DirecionNumero],
      Empresa.DireccionNumeroInt [Empresa_NumeroInt],
      Empresa.Colonia [Empresa_Colonia],
      Empresa.Poblacion [Empresa_Poblacion],
      Empresa.Estado [Empresa_Estado],
      Empresa.Pais [Empresa_Pais],
      Empresa.CodigoPostal [Empresa_Codigopostal],
      Empresa.Telefonos [Empresa_Telefonos],
      Empresa.Fax[Empresa_Fax],
      Empresa.Estatus[Empresa_Estatus],
      Empresa.Alta[Empresa_FechaAlta],
      Empresa.RegistroPatronal[Empresa_RegistroPatronal],
      Empresa.ClaveActividad[Empresa_ClaveActividad],
      Empresa.Representante[Empresa_Representante],
      Empresa.RepresentanteRFC[Empresa_RepresentateRFC],
      Empresa.RepresentanteCURP [Empresa_RepresentateCURP],
      ISNULL(EmpresaGral.URL_Logo,'') AS LogoEmpresa,
      /*Sección Sucursal*/
	  Sucursal.Sucursal [Sucursal_Clave],
      Sucursal.Nombre [Sucursal_Nombre],
      Sucursal.Direccion [Sucursal_Direccion],
      Sucursal.DireccionNumero [Sucursal_Numero],
      Sucursal.DireccionNumeroInt [Sucursal_NumeroInt],
      Sucursal.Colonia [Sucursal_Colonia],
      Sucursal.Poblacion [Sucursal_Poblacion],
      Sucursal.Estado [Sucursal_Estado],
      Sucursal.Pais [Sucursal_Pais],
      Sucursal.CodigoPostal [Sucursal_CodigoPostal],
      Sucursal.RFC [Sucursal_RFC],
      Sucursal.RegistroPatronal [Sucursal_RegistroPatronal],
      /*Sección Cliente*/
      Cte.Cliente,
      CASE WHEN ISNULL(Venta.EnviarA,0) > 0 THEN Env.Nombre ELSE Cte.Nombre END [Cliente_Nombre],
      CASE WHEN ISNULL(Venta.EnviarA,0) > 0 THEN Env.Direccion ELSE Cte.Direccion END [Cliente_Direccion],
      CASE WHEN ISNULL(Venta.EnviarA,0) > 0 THEN Env.DireccionNumero ELSE Cte.DireccionNumero END [Cliente_DireccionNumero],
      CASE WHEN ISNULL(Venta.EnviarA,0) > 0 THEN Env.DireccionNumeroInt ELSE Cte.DireccionNumeroInt END [Cliente_DireccionNumeroInt],
      CASE WHEN ISNULL(Venta.EnviarA,0) > 0 THEN Env.EntreCalles ELSE Cte.EntreCalles END [Cliente_EntreCalles],
      CASE WHEN ISNULL(Venta.EnviarA,0) > 0 THEN Env.Plano ELSE Cte.Plano END,
      CASE WHEN ISNULL(Venta.EnviarA,0) > 0 THEN Env.Delegacion ELSE Cte.Delegacion END [Cliente_Delegacion],
      CASE WHEN ISNULL(Venta.EnviarA,0) > 0 THEN Env.Colonia ELSE Cte.Colonia END [Cliente_Colonia],
      CASE WHEN ISNULL(Venta.EnviarA,0) > 0 THEN Env.CodigoPostal ELSE Cte.CodigoPostal END [Cliente_CodigoPostal],
      CASE WHEN ISNULL(Venta.EnviarA,0) > 0 THEN Env.Poblacion ELSE Cte.Poblacion END [Cliente_poblacion],
      CASE WHEN ISNULL(Venta.EnviarA,0) > 0 THEN Env.Estado ELSE Cte.Estado END [Cliente_Estado],
      CASE WHEN ISNULL(Venta.EnviarA,0) > 0 THEN Env.Pais ELSE Cte.Pais END [Cliente_Pais],
      CASE WHEN ISNULL(Venta.EnviarA,0) > 0 THEN Env.Zona ELSE Cte.Zona END [Cliente_Zona],
      Cte.NombreCorto [Cliente_NombreCorto],
      Cte.Observaciones AS ObservacionesCte,
      Cte.RFC [Cliente_RFC],
      Cte.Telefonos,
      Cte.Fax,
      Cte.Contacto1,
      Cte.Contacto2,
      Cte.eMail1 [Cliente_Mail],
      Cte.eMail2,
      Cte.CURP [Cliente_CURP],
      /*Sección Agente*/
      Agente.Agente,
      Agente.Nombre,
      /*Sección Venta*/
      Venta.Empresa,
      Venta.ID,
      Venta.Mov,
      Venta.MovID,
      Venta.FechaEmision,
      Venta.FechaRequerida,
      Venta.FechaRegistro,
      Venta.UltimoCambio,
      Venta.Concepto,
      CASE WHEN Venta.TipoCambio <> 1 AND MovTipo.SAT_MN = 1
      THEN Empresacfg.ContMoneda
      ELSE Venta.Moneda END AS Moneda,
      Venta.TipoCambio,
      Venta.Usuario,
      Venta.Referencia,
      Venta.Observaciones,
      Venta.Estatus,
      Venta.Directo,
      Venta.EnviarA,
      Venta.Almacen,
      Venta.FormaEnvio,
      Venta.Descuento,
      Venta.Condicion,
      Venta.Vencimiento,
      Venta.DescuentoGlobal,
      Venta.DescuentoLineal,
      Venta.Saldo,
      Venta.Importe,
      Venta.AnticiposFacturados,
      ISNULL(Venta.DescuentoLineal,0)+ISNULL(Venta.DescuentoGlobal,0) Venta_Descuento,
      (Venta.Importe - ISNULL(Venta.Retencion,0)) - ISNULL(Venta.AnticiposFacturados,0) [SubTotalNeto],
      (Venta.Importe + Venta.Impuestos - ISNULL(Venta.Retencion,0)) - ISNULL(Venta.AnticiposFacturados,0) [Importe_Total],
      Venta.Sucursal,
      Venta.UEN,	
      Venta.Comentarios,	
      Venta.Retencion, 
      Venta.Agente,
      "ImporteLetra" = 
      CASE 
	    WHEN Venta.TipoCambio <> 1 AND MovTipo.SAT_MN = 1
		    THEN dbo.fnNumeroEnEspanol(ISNULL(cfd.Importe,0.00)+ISNULL(CFD.Impuesto1,0.00)+ISNULL(CFD.Impuesto2,0.00)-(ISNULL(CFD.Retencion1,0.00)+ISNULL(CFD.Retencion2,0.00)),Empresacfg.ContMoneda)+' '+'M.N'
		    ELSE dbo.fnNumeroEnEspanol(ISNULL(cfd.Importe,0.00)+ISNULL(CFD.Impuesto1,0.00)+ISNULL(CFD.Impuesto2,0.00)-(ISNULL(CFD.Retencion1,0.00)+ISNULL(CFD.Retencion2,0.00)),Venta.Moneda)+' '+'M.A'
       END,
      YEAR(Venta.FechaEmision) [Ejercicio],
      MONTH(Venta.FechaEmision) [Periodo],
      "Leyenda CANCELADO" = CASE WHEN Venta.Estatus = 'CANCELADO' THEN Venta.Estatus ELSE '' END,
      dbo.fneDocVentaReferenciaMetodoCobro(Venta.ID, 0) AS FormasDePago,
      dbo.fneDocVentaReferenciaMetodoCobro(Venta.ID, 0) AS MetodoPago,
      dbo.fneDocVentaReferenciaMetodoCobro(Venta.ID, 1) AS NumCtaPago,    
       /*Sección VentaTCalc*/ 
      CASE WHEN Venta.TipoCambio <> 1 AND MovTipo.SAT_MN = 1
      THEN (ISNULL(CFD.Importe,0.00)+((SELECT SUM(ISNULL(VentaTCalc.DescuentosTotales,0)) FROM VentaTCalc WHERE ID =Venta.ID))* Venta.TipoCambio)
      ELSE ISNULL(CFD.Importe,0.00)+(SELECT SUM(ISNULL(VentaTCalc.DescuentosTotales,0)) FROM VentaTCalc WHERE ID =Venta.ID) END  AS SubTotal,
      CASE WHEN Venta.TipoCambio <> 1 AND MovTipo.SAT_MN = 1
      THEN (SELECT SUM(ISNULL(VentaTCalc.DescuentosTotales,0)) FROM VentaTCalc WHERE ID =Venta.ID) * Venta.TipoCambio
      ELSE (SELECT SUM(ISNULL(VentaTCalc.DescuentosTotales,0)) FROM VentaTCalc WHERE ID =Venta.ID) END AS DescuentosTotales,
      CASE WHEN Venta.TipoCambio <> 1 AND MovTipo.SAT_MN = 1
      THEN ISNULL(VentaTCalc.Impuesto1,0.00) 
      ELSE ISNULL(VentaTCalc.Impuesto1,0.00) END AS Iva,
      CFD.Impuesto1 AS TOTALIVA,
      CASE WHEN Venta.TipoCambio <> 1 AND MovTipo.SAT_MN = 1
      THEN ISNULL(VentaTCalc.Impuesto2,0.00) 
      ELSE ISNULL(VentaTCalc.Impuesto2,0.00) END AS IEPS,
      CFD.Impuesto2 AS TotalIEPS,
      ISNULL(CFD.Retencion1,0.00)+ ISNULL(CFD.Retencion2,0.00) AS Retención,
      ISNULL(cfd.Importe,0.00)+ISNULL(CFD.Impuesto1,0.00)+ISNULL(CFD.Impuesto2,0.00)-(ISNULL(CFD.Retencion1,0.00)+ISNULL(CFD.Retencion2,0.00))AS ImporteTotal,
       /*Sección VentaD*/
      VentaD.Renglon,
      VentaD.Codigo,
      VentaD.Articulo,
      VentaD.SubCuenta,
      VentaD.Cantidad,
      CASE WHEN Venta.TipoCambio <> 1 AND MovTipo.SAT_MN = 1
      THEN (ISNULL(VentaD.Importe,0.00)+ISNULL(VentaD.DescuentoLineal,0.00)) * Venta.TipoCambio
      ELSE ISNULL(VentaD.Importe,0.00)+ISNULL(VentaD.DescuentoLineal,0.00) END AS PrecioUnitario,
      VentaD.DescuentoTipo,
      VentaD.DescuentoLinea,
      ISNULL(VentaD.DescuentoLinea,0.00) [DescuentoImporteLinea],
      VentaD.Impuesto1,
      (((VentaD.Precio * VentaD.Cantidad) - ISNULL(VentaD.DescuentoImporte,0))*(VentaD.Impuesto1/100))[Impuesto_Linea],
      VentaD.DescripcionExtra,
      VentaD.Costo,
      VentaD.Aplica,
      VentaD.AplicaID,
      VentaD.CantidadReservada,
      VentaD.Unidad,
      VentaD.PrecioMoneda,
      VentaD.PrecioTipoCambio,
      CASE WHEN Venta.TipoCambio <> 1 AND MovTipo.SAT_MN = 1
      THEN (ISNULL(VentaD.Importe,0.00)+ISNULL(VentaD.DescuentoLineal,0.00)) * Venta.TipoCambio
      ELSE ISNULL(VentaD.Importe,0.00)+ISNULL(VentaD.DescuentoLineal,0.00) END  AS ImporteLineaBruto,
      VentaD.Importe [Importe_Linea],
      ((((VentaD.Precio * VentaD.Cantidad) - ISNULL(VentaD.DescuentoImporte,0))*(VentaD.Impuesto1/100))+((VentaD.Precio * VentaD.Cantidad) - ISNULL(VentaD.DescuentoImporte,0)))[Total_Linea],
      /*Sección Articulo*/
      Art.Descripcion1,
      /*Sección CFD*/
      CFD.Aprobacion,
      CFD.Sello,
      CFD.CadenaOriginal,
      CFD.noCertificado,
      CFD.Documento [ArchivoXML],
      CASE WHEN ISNULL(CAST(CFD.UUID AS VARCHAR(36)),'') <> '' THEN 
      'https'+CHAR(58)+'//verificacfdi.facturaelectronica.sat.gob.mx/default.aspx' 
      +'?id='+CAST(isnull(CFD.UUID,'') AS VARCHAR(36))
      +'&re='+ISNULL(RTRIM(Cte.RFC),'')
      +'&rr='+ISNULL(RTRIM(Empresa.RFC),'')
      +'&tt='+ dbo.fnCFDFlexFormatearImporte(ISNULL(cfd.Importe,0.00)+ISNULL(CFD.Impuesto1,0.00)+ISNULL(CFD.Impuesto2,0.00)-(ISNULL(CFD.Retencion1,0.00)+ISNULL(CFD.Retencion2,0.00)),10,6)
       +'&fe='+RIGHT(ISNULL(CFD.Sello,''),8)
      ELSE '' END AS QR_Cadena,
      CFD_QR_Code.QR_Code,
      CFD.Timbrado, 
      CFD.UUID as FolioFiscal, 
      CFD.FechaTimbrado, 
      CFD.SelloSAT, 
      CFD.TFDVersion, 
      CFD.noCertificadoSAT, 
      CFD.TFDCadenaOriginal,
      /*Sección CFDVenta*/
      ISNULL(CFDVenta.CondicionFormaDePago,' ') AS FormaDePago,
      CFDVenta.EmpresaLocalidad+', '+CFDVenta.EmpresaEstado AS LugarExpedicion,
      /*Sección CFDVentaFiscalRegimen*/
      FR.EmisorRegimenFiscal,
      /*Sección VentaCobro*/
      VentaCobro.Cajero,
      VentaCobro.CtaDinero [Caja],
      /*Sección SerieLote*/
      m.Cantidad AS CantidadSerie,
      m.SerieLote, 
      p.Aduana AS Aduana, 
      p.Fecha1 AS Fecha1, 
      p.PedimentoClave AS PedimentoClave, 
      s.Propiedades AS Propiedades,
      0 AS [CXC_Saldo],
      CFD.Serie AS CFDSerie,
      CFD.Folio AS CFDFolio
  FROM Venta
  JOIN VentaDCalc VentaD ON Venta.ID=VentaD.ID
  JOIN VentaTCalc ON VentaD.ID = VentaTCalc.ID AND VentaD.Renglon = VentaTCalc.Renglon AND VentaD.RenglonSub = VentaTCalc.RenglonSub AND VentaD.RenglonID = VentaTCalc.RenglonID
  JOIN Art ON VentaD.Articulo=Art.Articulo
  JOIN Cte ON Venta.Cliente=Cte.Cliente
  LEFT JOIN Agente ON Venta.Agente=Agente.Agente
  LEFT JOIN CFD ON Venta.ID = CFD.ModuloID AND CFD.Modulo = 'VTAS'
  LEFT JOIN CFD_QR_Code ON CFD.UUID = CFD_QR_Code.UUID  
  JOIN Empresa on Empresa.Empresa = Venta.empresa
  JOIN EmpresaGral ON Empresa.Empresa = EmpresaGral.Empresa
  JOIN EmpresaCfg ON Venta.Empresa = EmpresaCfg.Empresa
  LEFT JOIN EmpresaCFD ON Venta.Empresa = EmpresaCFD.Empresa
  JOIN Sucursal  ON Venta.Sucursal = Sucursal.Sucursal
  LEFT JOIN VentaCobro ON Venta.ID = VentaCobro.ID
  LEFT JOIN SerieLoteMov m ON Venta.Empresa = m.Empresa AND m.Modulo = 'VTAS' AND VentaD.ID = m.ID AND VentaD.Articulo = m.Articulo AND ISNULL(VentaD.SubCuenta, '') = ISNULL(m.SubCuenta, '') AND VentaD.RenglonID = m.RenglonID
  LEFT JOIN SerieLotePropiedades s ON m.Empresa = s.Empresa AND m.Articulo = s.Articulo AND ISNULL(m.SubCuenta, '') = ISNULL(s.SubCuenta, '')  AND m.SerieLote = s.SerieLote 
  LEFT JOIN SerieLoteProp p ON s.Propiedades = p.Propiedades
  LEFT JOIN CteEnviarA Env ON Venta.EnviarA = Env.ID AND Venta.Cliente = Env.Cliente
  LEFT JOIN CFDVenta ON Venta.ID = CFDVenta.ID
  LEFT JOIN CFDVentaFiscalRegimen FR ON Venta.ID = FR.ID
  LEFT JOIN MovTipo MovTipo ON MovTipo.Modulo = 'VTAS' AND MovTipo.Mov = Venta.Mov
WHERE Venta.ID = :ID
 ORDER BY VentaD.Renglon, VentaD.Articulo