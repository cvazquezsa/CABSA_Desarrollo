SELECT cxc.id,
      /*Sección Empresa*/
      UPPER(Empresa.Empresa) [Empresa_Clave],
      UPPER(Empresa.Nombre) [Empresa_Nombre],
      'Calle'+':'+isnull(Empresa.Direccion,'')+' '+'Número'+':'+isnull(Empresa.DireccionNumero,'s/n')+' '+'Numero Int.'+':'+isnull(Empresa.DireccionNumeroInt,'s/n')+' '+
      'Colonia'+':'+isnull(Empresa.Colonia,'')+' '+'Delegacion'+':'+isnull(Empresa.Poblacion,'')+' '+'Estado'+':'+isnull(Empresa.Estado,'')+' '+'Pais'+':'+isnull(Empresa.Pais,'')+' '+
      'CP'+':'+isnull(Empresa.CodigoPostal,'') [Empresa_DirecionCompleta],
      Empresa.Direccion [Empresa_Direcion],
      Empresa.DireccionNumero [Empresa_DirecionNumero],
      Empresa.DireccionNumeroInt [Empresa_NumeroInt],
      Empresa.Colonia [Empresa_Colonia],
      Empresa.Poblacion [Empresa_Poblacion],
      Empresa.Estado [Empresa_Estado],
      Empresa.Pais [Empresa_Pais],
      Empresa.RFC [Empresa_RFC],
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
      ISNULL(Empresa.FiscalRegimen,'')+' '+ isnull(FiscalRegimen.Descripcion,'') [Empresa_FiscalRegimen],-- FISCAL
      ISNULL(EmpresaGral.URL_Logo,'') AS LogoEmpresa,
      EmpresaCFD.noCertificado AS CertificadoPAC,
      /*Sección Sucursal*/
      Sucursal.Sucursal [Sucursal_clave],
      Sucursal.Nombre [Sucursal_Nombre],
      isnull(Sucursal.Direccion,'')+', '+'No.'+''+isnull(Sucursal.DireccionNumero,'s/n')+' '+'No.Int.'+''+isnull(Sucursal.DireccionNumeroInt,'s/n')+' '+
      'Colonia'+':'+isnull(Sucursal.Colonia,'')+' '+'Delegacion'+':'+isnull(Sucursal.Poblacion,'')+' '+'Estado'+':'+isnull(Sucursal.Estado,'')+' '+'Pais'+':'+isnull(Sucursal.Pais,'')+' '+
      'CP'+':'+isnull(Sucursal.CodigoPostal,'') [Sucursal_DirecionCompleta],
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
      CASE WHEN ISNULL(Cxc.ClienteEnviarA,0) > 0 THEN Env.Nombre ELSE Cte.Nombre END [Cliente_Nombre],
      CASE WHEN ISNULL(Cxc.ClienteEnviarA,0) > 0 THEN Env.Direccion ELSE Cte.Direccion END [Cliente_Direccion],
      CASE WHEN ISNULL(Cxc.ClienteEnviarA,0) > 0 THEN Env.DireccionNumero ELSE Cte.DireccionNumero END [Cliente_DireccionNumero],
      CASE WHEN ISNULL(Cxc.ClienteEnviarA,0) > 0 THEN Env.DireccionNumeroInt ELSE Cte.DireccionNumeroInt END [Cliente_DireccionNumeroInt],
      CASE WHEN ISNULL(Cxc.ClienteEnviarA,0) > 0 THEN Env.EntreCalles ELSE Cte.EntreCalles END [Cliente_EntreCalles],
      CASE WHEN ISNULL(Cxc.ClienteEnviarA,0) > 0 THEN Env.Plano ELSE Cte.Plano END [Plano],
      CASE WHEN ISNULL(Cxc.ClienteEnviarA,0) > 0 THEN Env.Delegacion ELSE Cte.Delegacion END [Cliente_Delegacion],
      CASE WHEN ISNULL(Cxc.ClienteEnviarA,0) > 0 THEN Env.Colonia ELSE Cte.Colonia END [Cliente_Colonia],
      CASE WHEN ISNULL(Cxc.ClienteEnviarA,0) > 0 THEN Env.CodigoPostal ELSE Cte.CodigoPostal END [Cliente_CodigoPostal],
      CASE WHEN ISNULL(Cxc.ClienteEnviarA,0) > 0 THEN Env.Poblacion ELSE Cte.Poblacion END [Cliente_poblacion],
      CASE WHEN ISNULL(Cxc.ClienteEnviarA,0) > 0 THEN Env.Estado ELSE Cte.Estado END [Cliente_Estado],
      CASE WHEN ISNULL(Cxc.ClienteEnviarA,0) > 0 THEN Env.Pais ELSE Cte.Pais END [Cliente_Pais],
      CASE WHEN ISNULL(Cxc.ClienteEnviarA,0) > 0 THEN Env.Zona ELSE Cte.Zona END [Cliente_Zona],
      Cte.NombreCorto [Cliente_NombreCorto],
      Cte.Observaciones AS ObservacionesCte,
      Cte.ZonaImpuesto,
      Cte.RFC [Cliente_RFC],
      Cte.Telefonos,
      Cte.Fax,
      Cte.Contacto1,
      Cte.Contacto2,
      Cte.eMail1 [Cliente_Mail],
      Cte.eMail2,
      Cte.CURP [Cliente_CURP],
      cte1.ClaveUsoCFDI+' '+sat.Descripcion 'UsoCFDI',
      /*Sección Agente*/
      Agente.Agente,
      Agente.Nombre,
      /*Sección Cxc*/
      Cxc.Empresa,
      Cxc.ID,
      Cxc.Mov,
      Cxc.MovID,
      Cxc.FechaEmision,
      NULL AS FechaRequerida,
      Cxc.FechaRegistro,
      Cxc.UltimoCambio,
      Cxc.Concepto,
      CASE WHEN Cxc.TipoCambio <> 1 AND MovTipo.SAT_MN = 1
      THEN Empresacfg.ContMoneda
      ELSE Cxc.Moneda END AS Moneda,
      Cxc.TipoCambio,
      Cxc.Usuario,
      Cxc.Referencia,
      Cxc.Observaciones,
      Cxc.Estatus,
      NULL AS Directo,
      Cxc.ClienteEnviarA,
      NULL AS Almacen,
      NULL AS FormaEnvio, 
      NULL AS Descuento,
      Cxc.Condicion,
      Condicion.CFD_metodoDePago,
      Cxc.Vencimiento,      
      NULL AS DescuentoGlobal, 
      NULL AS DescuentoLineal,
      Cxc.Saldo, 
      CASE WHEN Cxc.TipoCambio <> 1 AND MovTipo.SAT_MN = 1
      THEN ISNULL(Cxc.Importe,0) * Cxc.TipoCambio
      ELSE ISNULL(Cxc.Importe,0) END AS Importe,
      CASE WHEN Cxc.TipoCambio <> 1 AND MovTipo.SAT_MN = 1
      THEN ISNULL(Cxc.Impuestos,0) * Cxc.TipoCambio
      ELSE ISNULL(Cxc.Impuestos,0) END AS Impuestos,
      CASE WHEN Cxc.TipoCambio <> 1 AND MovTipo.SAT_MN = 1
      THEN (Cxc.Importe + Cxc.Impuestos - ISNULL(Cxc.Retencion,0)) * Cxc.TipoCambio
      ELSE Cxc.Importe + Cxc.Impuestos - ISNULL(Cxc.Retencion,0) END [Importe_Total],
      Cxc.Sucursal,
      Cxc.UEN,
      Cxc.Comentarios,
      CASE WHEN Cxc.TipoCambio <> 1 AND MovTipo.SAT_MN = 1
      THEN ISNULL(Cxc.Retencion,0) * Cxc.TipoCambio
      ELSE ISNULL(Cxc.Retencion,0) END AS RETENCION,
      Cxc.Agente,
      (ISNULL(Cxc.Impuestos,0)/ISNULL(Cxc.Importe,0))*100 AS IVAFISCAL,
      "ImporteLetra" = 
      CASE WHEN Cxc.TipoCambio <> 1 AND MovTipo.SAT_MN = 1
      THEN dbo.fnNumeroEnEspanol(((Cxc.Importe + Cxc.Impuestos - ISNULL(Cxc.Retencion,0)) * Cxc.TipoCambio),EmpresaCfg.ContMoneda)+' '+'M.N'
      ELSE dbo.fnNumeroEnEspanol((Cxc.Importe + Cxc.Impuestos - ISNULL(Cxc.Retencion,0)),Cxc.Moneda)+' '+'M.N' END,
      YEAR(Cxc.FechaEmision) [Ejercicio],
      MONTH(Cxc.FechaEmision) [Periodo],
      "%Impuesto" = ISNULL(zi.Porcentaje,0.00),
      /*Sección CxcD*/
      NULL AS Renglon,
      NULL AS Codigo,
      NULL AS SubCuenta,
      NULL AS Cantidad,
      NULL AS Precio,
      NULL AS DescuentoTipo,
      NULL AS DescuentoLinea,
      NULL AS Impuesto1,
      NULL AS Impuesto_Linea,
      NULL AS DescripcionExtra,
      NULL AS Costo,
      NULL AS Aplica,
      NULL AS AplicaID,
      NULL AS CantidadReservada,
      NULL AS unidad,
      NULL AS PrecioMoneda,
      NULL AS PrecioTipoCambio,
      NULL AS PrecioLista,
      NULL AS Importe_Linea,
      NULL AS Total_Linea,
      NULL AS Cajero, NULL AS Caja,
      NULL AS Cantidad,
      NULL AS SerieLote,
      NULL AS Aduana, 
      NULL AS Fecha1,  
      NULL AS RegimenFiscal,
      NULL AS FormasDePago,
      NULL AS LugarExpedicion,
      /*Sección Articulo*/
      NULL AS Articulo,
      NULL AS Descripcion1,
      /*Sección CFD*/ 
      CFDFolio.noAprobacion [Folio_noAprobacion],
      CFDFolio.fechaAprobacion [Folio_fechaAprobacion],
      isnull(CFD.Ejercicio,CFD1.Ejercicio) AS Ejercicio,
      CASE WHEN ISNULL(CFD.Sello,'') = '' THEN ISNULL(CFD.SelloSAT,CFD1.SelloSAT) ELSE ISNULL(CFD.Sello,CFD1.Sello) END AS Sello,
      CASE WHEN ISNULL(CFD.Sello,'') = '' THEN ISNULL(CFD.TFDCadenaOriginal,CFD1.TFDCadenaOriginal) ELSE ISNULL(CFD.CadenaOriginal,CFD1.CadenaOriginal) END AS CadenaOriginal,
      CASE WHEN ISNULL(CFD.Sello,'') = '' THEN isnull(CFD.noCertificadoSAT,CFD1.noCertificadoSAT) ELSE isnull(CFD.noCertificado,CFD1.noCertificado) END AS noCertificado,
      isnull(CFD.Documento,CFD1.Documento) [ArchivoXML],
      CASE WHEN ISNULL(CAST(ISNULL(CFD.UUID,CFD1.UUID) AS VARCHAR(36)),'') <> '' THEN 
      'https'+CHAR(58)+'//prodretencionverificacion.clouda.sat.gob.mx/'
      +'?id='+CAST(isnull(CFD.UUID,CFD1.UUID) AS VARCHAR(36))
      +'&re='+ISNULL(RTRIM(Cte.RFC),'')
      +'&rr='+ISNULL(RTRIM(Empresa.RFC),'')
      +'&tt='+ISNULL(CONVERT(VARCHAR(25),dbo.fnCFDFlexFormatearImporte(Cxc.Importe+ISNULL(Cxc.Impuestos,0)-ISNULL(Cxc.Retencion,0),10,6)),'0.00')
      +'&fe='+RIGHT(ISNULL(CFD.Sello,CFD1.Sello),8)
      ELSE '' END AS QR_Cadena,
      CFD_QR_Code.QR_Code,
      ISNULL(CFD.Timbrado,CFD1.Timbrado) AS Timbrado,
      isnull(CFD.UUID,CFD1.UUID) AS FolioFiscal,
      isnull(CFD.FechaTimbrado,CFD1.FechaTimbrado) AS FechaTimbrado,
      isnull(CFD.SelloSAT,CFD1.SelloSAT) AS SelloSAT,
      ISNULL(CFD.TFDVersion,CFD1.TFDVersion) AS TFDVersion,
      isnull(CFD.noCertificadoSAT,CFD1.noCertificadoSAT) AS noCertificadoSAT,
      ISNULL(CFD.TFDCadenaOriginal,CFD1.TFDCadenaOriginal) AS TFDCadenaOriginal,
      ISNULL(CFD.Serie,CFD1.Serie) AS CFDSerie,
      ISNULL(CFD.Folio,CFD1.Folio) AS CFDFolio,
      'Versión: CFDI 3.3' as 'Versión'
  FROM Cxc
  JOIN Cte ON Cxc.Cliente=Cte.Cliente
  JOIN CteCFD cte1 ON Cxc.Cliente=cte.Cliente
  JOIN SATCatUsoCFDI sat on cte1.ClaveUsoCFDI=sat.ClaveUsoCFDI 
  LEFT JOIN ZonaImp zi ON Cte.ZonaImpuesto = zi.Zona
  LEFT JOIN CteEnviarA Env ON Cxc.ClienteEnviarA = Env.ID
  LEFT OUTER JOIN Agente ON Cxc.Agente=Agente.Agente
  LEFT OUTER JOIN CFDICobroParcialTimbrado CFD ON CFD.Modulo = 'CXC' AND CFD.IDModulo = Cxc.ID
  left join  CFD CFD1 on Cxc.ID=CFD1.ModuloID 
  LEFT JOIN CFDFolio CFDFolio ON  ISNULL(CFD.Modulo,CFD1.Modulo) = CFDFolio.Modulo AND ISNULL(CFD.Empresa,CFD1.Empresa)=CFDFolio.Empresa AND Cxc.Mov=CFDFolio.Mov
  JOIN Empresa on Empresa.Empresa = Cxc.empresa
  JOIN FiscalRegimen ON empresa.FiscalRegimen = FiscalRegimen.FiscalRegimen
  JOIN EmpresaCfg ON Cxc.Empresa = EmpresaCfg.Empresa
  LEFT JOIN EmpresaCFD ON Cxc.Empresa = EmpresaCFD.Empresa
  JOIN Sucursal  on Sucursal.Sucursal = Cxc.Sucursal
  LEFT OUTER JOIN VentaCobro ON VentaCobro.ID = Cxc.ID
  JOIN EmpresaGral ON EmpresaGral.Empresa = Empresa.Empresa
  LEFT JOIN CFD_QR_Code ON CFD_QR_Code.UUID = CFD.UUID  
  LEFT JOIN Prop ON Prop.Rama = 'EMP' AND Prop.Cuenta = Cxc.Empresa AND Prop.Tipo = 'LogoEmpresaCFDI'
  LEFT JOIN MovTipo MovTipo ON MovTipo.Modulo = 'CXC' AND MovTipo.Mov = Cxc.Mov
  LEFT JOIN Condicion Condicion ON Cxc.Condicion =Condicion.Condicion 
 WHERE Cxc.ID = :ID


