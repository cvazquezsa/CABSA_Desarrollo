SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

/****** vwEmpresaCfgPNet ******/
IF EXISTS(SELECT * FROM sysobjects where name ='vwEmpresaCfgPNet' and type ='V')
	DROP VIEW dbo.vwEmpresaCfgPNet
GO
CREATE VIEW dbo.vwEmpresaCfgPNet
AS
 SELECT * FROM (
 SELECT	E.*, 'rs_' + S.Descripcion Descripcion, ES.URL
   FROM	(
		 SELECT E.*, 'cfg_' + C.Descripcion Descripcion, EC.Value
		   FROM	(SELECT	E.Empresa, ISNULL(PN.Nombre, E.Nombre) Nombre, ISNULL(PN.Telefonos, E.Telefonos) Telefonos, 
						ISNULL(PN.Direccion, ISNULL(E.Direccion, '') + ISNULL(' ' + E.DireccionNumero, '') + ISNULL(' ' + E.DireccionNumeroInt, '') + ISNULL(E.Colonia, '') + ISNULL(', ' +E.Delegacion, '') + ISNULL(', ' +E.Estado, '') + ISNULL(', CP. ' + E.CodigoPostal, '')) Direccion,
						PN.ImagenPath, PN.Email, PN.MapaLatitud, PN.MapaLongitud, PN.MapaPrecision, PN.Mision,
						PN.Vision, PN.Nosotros, PN.AvisoPrivacidad, PN.URLIntranet, PN.URLExtranet, CASE ISNULL(PN.Nombre, '') WHEN '' THEN 0 ELSE 1 END Configurada
				   FROM	Empresa E
				   LEFT	JOIN EmpresaCfgPNet PN ON E.Empresa = PN.Empresa
				  WHERE	E.Estatus = 'ALTA') AS E
		  CROSS	JOIN pNetOpcionMostrar C
		   LEFT	JOIN pNetEmpresaOpcionMostrar EC ON E.Empresa = EC.Empresa and C.OpcionMostrarID = EC.OpcionMostrarID) p
		  PIVOT	(MAX (Value)FOR Descripcion IN ([cfg_Comunicados],[cfg_Noticias],[cfg_Destacados],[cfg_BolsaTrabajo],[cfg_CaptarContactos],[cfg_RegCV],[cfg_Email Contacto])) AS E
   CROSS JOIN pNetRedSocialCat S
	LEFT JOIN pNetEmpresaRedSocial ES ON E.Empresa = ES.Empresa and S.RedSocialID = ES.RedSocialID) p
   PIVOT (MAX (URL)FOR Descripcion IN ([rs_Facebook],[rs_Twitter],[rs_Google],[rs_Instagram],[rs_LinkedIn],[rs_YouTube],[rs_Vine],[rs_FourSquare],[rs_Pinterest],[rs_Blogger])) AS Vw
GO

/****** vwSucursalPNet ******/
IF EXISTS(SELECT * FROM sysobjects where name ='vwSucursalPNet' and type ='V')
	DROP VIEW dbo.vwSucursalPNet
GO
CREATE VIEW dbo.vwSucursalPNet
AS
 SELECT	E.Empresa, S.Sucursal, ISNULL(PN.Nombre, S.Nombre) Nombre, ISNULL(PN.Telefonos, S.Telefonos) Telefonos, 
		ISNULL(PN.Direccion, ISNULL(S.Direccion, '')) Direccion, PN.ImagenPath, PN.Email, PN.MapaLatitud, 
		PN.MapaLongitud, PN.MapaPrecision, PN.Estatus, CASE WHEN E.Empresa = PN.Empresa THEN 1 ELSE 0 END Asignada
   FROM (SELECT	S.Sucursal, S.Nombre, S.Telefonos, 
				ISNULL(S.Direccion, '') + ISNULL(' ' + S.DireccionNumero, '') + ISNULL(' ' + S.DireccionNumeroInt, '') + ISNULL(S.Colonia, '') + ISNULL(', ' + S.Delegacion, '') + ISNULL(', ' + S.Estado, '') + ISNULL(', CP. ' + S.CodigoPostal, '') Direccion
		  FROM	Sucursal S
		 WHERE	S.Estatus = 'ALTA') AS S
  CROSS	JOIN vwEmpresaCfgPNet E
   LEFT	JOIN pNetSucursal PN ON S.Sucursal = PN.Sucursal AND E.Empresa = PN.Empresa
GO


/****** vwUsuarioPNet_XUsuario ******/
IF EXISTS(SELECT * FROM sysobjects where name ='vwUsuarioPNet_XUsuario' and type ='V')
	DROP VIEW dbo.vwUsuarioPNet_XUsuario
GO
CREATE VIEW dbo.vwUsuarioPNet_XUsuario
AS
 SELECT P.IDUsuario, P.Usuario, P.IDUsuarioTipo, T.Descripcion AS DescripcionTipo, P.eMail, P.Nombre AS Apodo, P.UrlImagen, P.Estatus, P.FechaRegistro, U.Nombre, U.Contrasena, 
        P.IDRole, P.PrimeraVez, P.Empresa, P.Sucursal
   FROM dbo.pNetUsuario AS P INNER JOIN
        dbo.Usuario AS U ON P.Usuario = U.Usuario INNER JOIN  
        dbo.pNetUsuarioTipo AS T ON P.IDUsuarioTipo = T.IDUsuarioTipo
  WHERE U.Estatus = 'ALTA' AND P.IDUsuarioTipo = 1
 UNION
 SELECT P.IDUsuario, P.Usuario, P.IDUsuarioTipo, T.Descripcion AS DescripcionTipo, P.eMail, P.Nombre AS Apodo, P.UrlImagen, P.Estatus, P.FechaRegistro, E.Nombre, E.Contrasena, 
        P.IDRole, P.PrimeraVez, P.Empresa, P.Sucursal
   FROM dbo.pNetUsuario AS P INNER JOIN
        dbo.Personal AS E ON P.Usuario = E.Personal INNER JOIN  
        dbo.pNetUsuarioTipo AS T ON P.IDUsuarioTipo = T.IDUsuarioTipo
  WHERE E.Estatus = 'ALTA' AND P.IDUsuarioTipo = 2
 UNION
 SELECT P.IDUsuario, P.Usuario, P.IDUsuarioTipo, T.Descripcion AS DescripcionTipo, P.eMail, P.Nombre AS Apodo, P.UrlImagen, P.Estatus, P.FechaRegistro, C.Nombre, C.Contrasena, 
        P.IDRole, P.PrimeraVez, P.Empresa, P.Sucursal
   FROM dbo.pNetUsuario AS P INNER JOIN
        dbo.Cte AS C ON P.Usuario = C.Cliente INNER JOIN  
        dbo.pNetUsuarioTipo AS T ON P.IDUsuarioTipo = T.IDUsuarioTipo
  WHERE C.Estatus = 'ALTA' AND P.IDUsuarioTipo = 3
 UNION
 SELECT P.IDUsuario, P.Usuario, P.IDUsuarioTipo, T.Descripcion AS DescripcionTipo, P.eMail, P.Nombre AS Apodo, P.UrlImagen, P.Estatus, P.FechaRegistro, R.Nombre, R.Contrasena, 
        P.IDRole, P.PrimeraVez, P.Empresa, P.Sucursal
   FROM dbo.pNetUsuario AS P INNER JOIN
        dbo.Prov AS R ON P.Usuario = R.Proveedor INNER JOIN  
        dbo.pNetUsuarioTipo AS T ON P.IDUsuarioTipo = T.IDUsuarioTipo
  WHERE R.Estatus = 'ALTA' AND P.IDUsuarioTipo IN (4,5)
  UNION
  SELECT P.IDUsuario, P.Usuario, P.IDUsuarioTipo, T.Descripcion AS DescripcionTipo, P.eMail, P.Nombre AS Apodo, P.UrlImagen, P.Estatus, P.FechaRegistro, U.Nombre, U.Contrasena, 
         P.IDRole, P.PrimeraVez, P.Empresa, P.Sucursal
  FROM   dbo.pNetUsuario AS P INNER JOIN
         dbo.Usuario AS U ON P.Usuario = U.Usuario INNER JOIN  
         dbo.pNetUsuarioTipo AS T ON P.IDUsuarioTipo = T.IDUsuarioTipo
  WHERE  U.Estatus = 'ALTA' AND P.IDUsuarioTipo = 6
GO
GO

/****** vwPermisosXIdRolePNet ******/
IF EXISTS(SELECT * FROM sysobjects where name ='vwPermisosXIdRolePNet' and type ='V')
	DROP VIEW dbo.vwPermisosXIdRolePNet
GO
CREATE VIEW dbo.vwPermisosXIdRolePNet
AS
 SELECT r.IDRole, p.*
   FROM pNetPermiso as p
  INNER JOIN pNetRolePermiso as r
	 ON p.IDPermiso = r.IDPermiso
GO

/****** vwAgenteCtePNET ******/
IF EXISTS(SELECT * FROM sysobjects where name ='vwAgenteCtePNET' and type ='V')
  DROP VIEW dbo.vwAgenteCtePNET
GO
CREATE VIEW dbo.vwAgenteCtePNET
AS
  SELECT C.Nombre, A.Cliente, U.Usuario
	FROM Cte C WITH(NOLOCK, INDEX(Nombre))
	JOIN AgenteCte A ON A.Cliente = C.Cliente
	JOIN Usuario U ON A.Agente = U.DefAgente
GO

/************** Cliente **************/
/****** vwPNETConsultaCteEdoCta ******/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('vwPNETConsultaCteEdoCta') AND type = 'V') 
	DROP VIEW vwPNETConsultaCteEdoCta
GO
CREATE VIEW dbo.vwPNETConsultaCteEdoCta
AS		
SELECT ROW_NUMBER() OVER (ORDER BY CONVERT(DATETIME, C.Vencimiento) DESC) AS RowIndex, Cte.Cliente, C.Vencimiento, C.Empresa, RTRIM(A.MOV) 
	   + ' ' + RTRIM(ISNULL(A.MOVID, '')) [Movimiento], C.concepto, C.Estatus, A.Moneda, A.tipocambio[Tipocambio], ISNULL(A.Cargo, 0.00) + ISNULL(B.Cargo, 0.00) [Cargo], 
	   ISNULL(B.Abono, 0.00) + ISNULL(A.Abono, 0.00) [Abono], ((ISNULL(A.Cargo, 0.00) + ISNULL(B.Cargo, 0.00)) - (ISNULL(B.Abono, 0.00) + ISNULL(A.Abono, 0.00))) [Saldo], 
	   CONVERT(VARCHAR(10), C.Vencimiento, 105) [VencimientoString], CONVERT(VARCHAR(10), A.Fecha, 105) [FechaString], RTRIM(ISNULL(A.MOVID, '')) [MovID]
  FROM (SELECT DISTINCT MODULOID, MOV, MOVID, Fecha, MONEDA, TipoCambio, SUM(Cargo) Cargo, SUM(Abono) Abono, Modulo, CUENTA, APLICA, APLICAID
          FROM AUXILIAR
         WHERE RAMA = 'CXC'
         GROUP BY MODULOID, MOV, MOVID, Fecha, MONEDA, TipoCambio, Modulo, ModuloId, CUENTA, APLICA, APLICAID) AS A LEFT JOIN
       (SELECT DISTINCT Aplica MOV, AplicaID MOVID, SUM(Cargo) Cargo, SUM(Abono) Abono, 0 Saldo, A.Aplica, A.AplicaID
          FROM AUXILIAR A
         WHERE A.RAMA = 'CXC' AND ((MOV + MOVID) <> APLICA + APLICAID)
         GROUP BY Aplica, AplicaID) AS B ON A.MOV = B.MOV AND A.MOVID = B.MOVID JOIN CXC C ON C.ID = A.MODULOID 
		  JOIN Cte ON A.Cuenta = Cte.Cliente LEFT JOIN MovTipo MT ON MT.Modulo = A.Modulo AND C.Mov = MT.Mov
		 WHERE MT.Clave NOT IN ('CXC.EST', 'CXC.SD', 'CXC.SCH') AND C.Estatus NOT IN ('CANCELADO') /*AND C.Vencimiento BETWEEN @DesdeD AND @HastaD*/ AND 
               A.AplicaID = CASE WHEN A.AplicaID = A.MovID AND A.Aplica = A.Mov THEN A.AplicaID END
GO

/****** vwPNETConsultaCteEdoCtaD ******/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('vwPNETConsultaCteEdoCtaD') AND type = 'V') 
	DROP VIEW vwPNETConsultaCteEdoCtaD
GO
CREATE VIEW dbo.vwPNETConsultaCteEdoCtaD
AS
SELECT C.Cliente, AU.MovID AS Movimiento, CONVERT(VARCHAR(10), AU.Fecha, 105) AS Fecha, CONVERT(varchar(50), ISNULL(CXC.Vencimiento, ''), 105) AS Vencimiento, 
       AU.Cargo, AU.Abono, CXC.Saldo, ISNULL(AU.Moneda, '') AS Moneda, CONVERT(MONEY, ROUND(ISNULL(AU.TipoCambio, 0.00), 2)) AS TipoCambio, 
       ISNULL(CXC.Estatus, '') AS Estatus, ISNULL(CXC.Concepto, '') AS Concepto, AU.AplicaID, AU.Aplica, AU.MovID, AU.Mov, AU.ModuloID
  FROM dbo.EstadoCuenta AS EC INNER JOIN
       dbo.Cte AS C ON EC.Cuenta = C.Cliente LEFT OUTER JOIN
       dbo.Auxiliar AS AU ON EC.AuxiliarID = AU.ID LEFT OUTER JOIN
       dbo.Cxc AS CXC ON CXC.ID = AU.ModuloID LEFT OUTER JOIN
       dbo.MovTipo AS MT ON MT.Modulo = AU.Modulo AND CXC.Mov = MT.Mov
 WHERE (EC.Modulo = 'CXC') AND (MT.Clave NOT IN ('CXC.EST', 'CXC.SD', 'CXC.SCH')) AND (CXC.Estatus NOT IN ('CANCELADO'))
 GROUP BY AU.Fecha, AU.Mov, AU.MovID, CXC.Concepto, CXC.Estatus, AU.Moneda, AU.TipoCambio, AU.Cargo, AU.Abono, CXC.Saldo, CXC.Vencimiento, AU.AplicaID, AU.Aplica, 
          AU.MovID, AU.Mov, AU.ModuloID, C.Cliente
GO

/****** vwPNETcteConsultaFactura ******/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('vwPNETcteConsultaFactura') AND type = 'V') 
	DROP VIEW vwPNETcteConsultaFactura
GO
CREATE VIEW dbo.vwPNETcteConsultaFactura
AS
 SELECT	ROW_NUMBER() OVER ( ORDER BY CASE WHEN v.Estatus = 'PENDIENTE' THEN 1 WHEN v.Estatus = 'CONCLUIDO' THEN 2 WHEN v.Estatus = 'CANCELADO' THEN 3 ELSE 4 END ASC, CONVERT(DATETIME,v.FechaEmision) DESC) AS RowIndex,
		v.ID,
		v.Cliente,
		CONVERT (VARCHAR(21), v.FechaEmision, 103) FechaEmisionFormat,
		v.FechaEmision,
		v.Estatus,
		e.Nombre AS Empresa,
		s.Nombre AS Sucursal,
		RTRIM(v.Mov)+' '+RTRIM(ISNULL(v.MovID,'')) AS Movimiento,
		v.Moneda,
		v.TipoCambio,
		v.Condicion CondicionPago,
		v.Referencia,
		v.Concepto,
		t.importe,
		CASE WHEN t.DescuentosTotales <> 0 THEN (ISNULL(t.DescuentosTotales,0)-ISNULL(t.DescuentoLineal,0)) ELSE 0 END AS Descuento,
		t.SubTotal,
		t.Impuestos,
		t.ImporteTotal,
		(CAST(v.ID AS VARCHAR(25)) + '|' + ISNULL(v.Cliente, '') + '|' + CONVERT (VARCHAR(21), v.FechaEmision, 103) + ' ' + CONVERT (VARCHAR(21), v.FechaEmision, 108) + '|' +
		ISNULL(v.Estatus, '') + '|' + ISNULL(e.Nombre, '') + '|' + ISNULL(s.Nombre, '') + '|' + ISNULL(RTRIM(v.Mov)+' '+RTRIM(ISNULL(v.MovID,'')), '') + '|' + ISNULL(v.Moneda, '') + '|' + 
		CAST(v.TipoCambio AS VARCHAR(25)) + '|' + ISNULL(v.Condicion, '') + '|' + ISNULL(v.Referencia, '') + '|' + ISNULL(v.Concepto, '') + '|' + CAST(t.importe AS VARCHAR(25)) + '|' + 
		ISNULL(CAST(CASE WHEN t.DescuentosTotales <> 0 THEN (ISNULL(t.DescuentosTotales,0)-ISNULL(t.DescuentoLineal,0)) ELSE 0 END AS VARCHAR(25)), '') + '|' + 
		CAST(t.SubTotal AS VARCHAR(25)) + '|' + CAST(t.Impuestos AS VARCHAR(25)) + '|' + CAST(t.ImporteTotal AS VARCHAR(25))) AS Finder
   FROM	Venta v
   JOIN	MovTipo m ON v.Mov = m.Mov AND m.Modulo = 'VTAS'
   JOIN	VentaCalc t ON v.ID = t.ID
   LEFT	JOIN CFD f ON (v.ID = f.ModuloID AND f.Modulo = 'VTAS')
   JOIN	Empresa e ON v.Empresa = e.Empresa
   JOIN	Sucursal s ON v.Sucursal = s.Sucursal
  WHERE	m.Clave IN ('VTAS.P','VTAS.F')
		--AND v.Cliente = '015'
		--AND v.FechaEmision BETWEEN @Desde AND @Hasta
		--AND v.Estatus IN ('CONCLUIDO','PENDIENTE')
  GROUP	BY v.ID, v.Cliente, v.FechaEmision, v.Estatus, V.Mov, v.MovID, v.Moneda, v.TipoCambio, v.Condicion, v.Concepto, v.Referencia, t.importe, t.DescuentosTotales, t.DescuentosTotales, t.DescuentoLineal, t.SubTotal, t.Impuestos, t.ImporteTotal, e.Nombre, s.Nombre,
		(CAST(v.ID AS VARCHAR(25)) + '|' + ISNULL(v.Cliente, '') + '|' + CONVERT (VARCHAR(21), v.FechaEmision, 103) + ' ' + CONVERT (VARCHAR(21), v.FechaEmision, 108) + '|' +
		ISNULL(v.Estatus, '') + '|' + ISNULL(e.Nombre, '') + '|' + ISNULL(s.Nombre, '') + '|' + ISNULL(RTRIM(v.Mov)+' '+RTRIM(ISNULL(v.MovID,'')), '') + '|' + ISNULL(v.Moneda, '') + '|' + 
		CAST(v.TipoCambio AS VARCHAR(25)) + '|' + ISNULL(v.Condicion, '') + '|' + ISNULL(v.Referencia, '') + '|' + ISNULL(v.Concepto, '') + '|' + CAST(t.importe AS VARCHAR(25)) + '|' + 
		ISNULL(CAST(CASE WHEN t.DescuentosTotales <> 0 THEN (ISNULL(t.DescuentosTotales,0)-ISNULL(t.DescuentoLineal,0)) ELSE 0 END AS VARCHAR(25)), '') + '|' + 
		CAST(t.SubTotal AS VARCHAR(25)) + '|' + CAST(t.Impuestos AS VARCHAR(25)) + '|' + CAST(t.ImporteTotal AS VARCHAR(25)))
GO

/****** vwPNETcteConsultaFacturaD ******/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('vwPNETcteConsultaFacturaD') AND type = 'V') 
	DROP VIEW vwPNETcteConsultaFacturaD
GO
CREATE VIEW dbo.vwPNETcteConsultaFacturaD
AS
 SELECT d.RenglonID,
		CONVERT(INT,RTRIM(ID)) ID,
		CASE WHEN d.RenglonTipo = 'C' THEN '    '+a.Descripcion1 ELSE a.Descripcion1 END [Descripcion],
		ISNULL(d.SubCuenta,'') AS [SubCuenta],
		ISNULL(d.Cantidad,'') AS [Cantidad], 
		ISNULL(d.Unidad,'') AS [Unidad], 
		d.Precio AS [Precio], 
		d.Importe AS [Importe],
		CONVERT(FLOAT,ISNULL(d.DescuentoLinea,'')) AS DescuentoLinea, 
		d.SubTotal AS [SubTotal], 
		d.Impuestos AS [Impuestos], 
		d.ImporteTotal AS [ImporteTotal]
   FROM	VentaTCalc d JOIN Art a ON d.Articulo = a.Articulo
GO


/********* vwPNETcteConsultaFactura *************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('vwPNETcteConsultaFactura') AND type = 'V') 
	DROP VIEW dbo.vwPNETcteConsultaFactura
GO
CREATE VIEW dbo.vwPNETcteConsultaFactura
AS
  SELECT ROW_NUMBER() OVER ( ORDER BY CASE WHEN v.Estatus = 'PENDIENTE' THEN 1 WHEN v.Estatus = 'CONCLUIDO' THEN 2 WHEN v.Estatus = 'CANCELADO' THEN 3 ELSE 4 END ASC, CONVERT(DATETIME,v.FechaEmision) DESC) AS RowIndex,
		 v.ID,
		 v.Cliente,
		 v.FechaEmision,
		 v.Estatus,
		 e.Nombre AS Empresa,
		 s.Nombre AS Sucursal,
		 RTRIM(v.Mov)+' '+RTRIM(ISNULL(v.MovID,'')) AS Movimiento,
		 v.Moneda,
		 v.TipoCambio,
		 v.Condicion CondicionPago,
		 v.Referencia,
		 v.Concepto,
		 t.importe,
		 CASE WHEN t.DescuentosTotales <> 0 THEN (ISNULL(t.DescuentosTotales,0)-ISNULL(t.DescuentoLineal,0)) ELSE 0 END AS Descuento,
		 t.SubTotal,
		 t.Impuestos,
		 t.ImporteTotal,
		 (CAST(v.ID AS VARCHAR(25)) + '|' + ISNULL(v.Cliente, '') + '|' + CONVERT (VARCHAR(21), v.FechaEmision, 103) + ' ' + CONVERT (VARCHAR(21), v.FechaEmision, 108) + '|' +
		 ISNULL(v.Estatus, '') + '|' + ISNULL(e.Nombre, '') + '|' + ISNULL(s.Nombre, '') + '|' + ISNULL(RTRIM(v.Mov)+' '+RTRIM(ISNULL(v.MovID,'')), '') + '|' + ISNULL(v.Moneda, '') + '|' + 
		 CAST(v.TipoCambio AS VARCHAR(25)) + '|' + ISNULL(v.Condicion, '') + '|' + ISNULL(v.Referencia, '') + '|' + ISNULL(v.Concepto, '') + '|' + CAST(t.importe AS VARCHAR(25)) + '|' + 
		 ISNULL(CAST(CASE WHEN t.DescuentosTotales <> 0 THEN (ISNULL(t.DescuentosTotales,0)-ISNULL(t.DescuentoLineal,0)) ELSE 0 END AS VARCHAR(25)), '') + '|' + 
		 CAST(t.SubTotal AS VARCHAR(25)) + '|' + CAST(t.Impuestos AS VARCHAR(25)) + '|' + CAST(t.ImporteTotal AS VARCHAR(25))) AS Finder
	FROM Venta v
	JOIN MovTipo m ON v.Mov = m.Mov AND m.Modulo = 'VTAS'
	JOIN VentaCalc t ON v.ID = t.ID
	LEFT JOIN CFD f ON (v.ID = f.ModuloID AND f.Modulo = 'VTAS')
	JOIN Empresa e ON v.Empresa = e.Empresa
	JOIN Sucursal s ON v.Sucursal = s.Sucursal
   WHERE m.Clave IN ('VTAS.P','VTAS.F')
   --AND v.Cliente = '015'
   --AND v.FechaEmision BETWEEN @Desde AND @Hasta
	 AND v.Estatus IN ('CONCLUIDO','PENDIENTE')
   GROUP BY v.ID, v.Cliente, v.FechaEmision, v.Estatus, V.Mov, v.MovID, v.Moneda, v.TipoCambio, v.Condicion, v.Concepto, v.Referencia, t.importe, t.DescuentosTotales, t.DescuentosTotales, t.DescuentoLineal, t.SubTotal, t.Impuestos, t.ImporteTotal, e.Nombre, s.Nombre,
		 (CAST(v.ID AS VARCHAR(25)) + '|' + ISNULL(v.Cliente, '') + '|' + CONVERT (VARCHAR(21), v.FechaEmision, 103) + ' ' + CONVERT (VARCHAR(21), v.FechaEmision, 108) + '|' +
		 ISNULL(v.Estatus, '') + '|' + ISNULL(e.Nombre, '') + '|' + ISNULL(s.Nombre, '') + '|' + ISNULL(RTRIM(v.Mov)+' '+RTRIM(ISNULL(v.MovID,'')), '') + '|' + ISNULL(v.Moneda, '') + '|' + 
		 CAST(v.TipoCambio AS VARCHAR(25)) + '|' + ISNULL(v.Condicion, '') + '|' + ISNULL(v.Referencia, '') + '|' + ISNULL(v.Concepto, '') + '|' + CAST(t.importe AS VARCHAR(25)) + '|' + 
		 ISNULL(CAST(CASE WHEN t.DescuentosTotales <> 0 THEN (ISNULL(t.DescuentosTotales,0)-ISNULL(t.DescuentoLineal,0)) ELSE 0 END AS VARCHAR(25)), '') + '|' + 
		 CAST(t.SubTotal AS VARCHAR(25)) + '|' + CAST(t.Impuestos AS VARCHAR(25)) + '|' + CAST(t.ImporteTotal AS VARCHAR(25)))
GO


/*********** Proveedor ***************/
/****** vwPNETConsultaProvEdoCta ******/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('vwPNETConsultaProvEdoCta') AND type = 'V') 
	DROP VIEW vwPNETConsultaProvEdoCta
GO
CREATE VIEW dbo.vwPNETConsultaProvEdoCta
AS	
SELECT     
	ROW_NUMBER() OVER (ORDER BY CONVERT(DATETIME, C.Vencimiento) DESC) AS RowIndex, 
	C.Proveedor, 
	C.Vencimiento, 
	C.Empresa, 
	RTRIM(A.MOV) + ' ' + RTRIM(ISNULL(A.MOVID, '')) [Movimiento], 
	C.concepto, 
	C.Estatus, 
	A.Moneda, 
	A.tipocambio, 
	ISNULL(A.Cargo, 0.00) + ISNULL(B.Cargo, 0.00) [Cargo], ISNULL(B.Abono, 0.00) 
	+ ISNULL(A.Abono, 0.00) [Abono], ((ISNULL(A.Cargo, 0.00) + ISNULL(B.Cargo, 0.00)) - (ISNULL(B.Abono, 0.00) + ISNULL(A.Abono, 0.00))) [Saldo], CONVERT(VARCHAR(10), 
	C.Vencimiento, 105) [VencimientoString], 
	CONVERT(VARCHAR(10), A.Fecha, 105) [FechaString], 
	RTRIM(ISNULL(A.MOVID, '')) [MovID]
FROM  (SELECT DISTINCT MODULOID, MOV, MOVID, Fecha, MONEDA, TipoCambio, SUM(Cargo) Cargo, SUM(Abono) Abono, Modulo, CUENTA, APLICA, APLICAID
	FROM    AUXILIAR
	WHERE   RAMA = 'CXP'
	GROUP BY MODULOID, MOV, MOVID, Fecha, MONEDA, TipoCambio, Modulo, ModuloId, CUENTA, APLICA, APLICAID) AS A LEFT JOIN
	(SELECT DISTINCT Aplica MOV, AplicaID MOVID, SUM(Cargo) Cargo, SUM(Abono) Abono, 0 Saldo, A.Aplica, A.AplicaID
		FROM	AUXILIAR A
		WHERE   A.RAMA = 'CXP' AND ((MOV + MOVID) <> APLICA + APLICAID)
	GROUP BY Aplica, AplicaID) AS B ON A.MOV = B.MOV AND A.MOVID = B.MOVID JOIN
	CXP C ON C.ID = A.MODULOID JOIN
	prov P ON P.Proveedor = A.Cuenta LEFT JOIN
	MovTipo MT ON MT.Modulo = A.Modulo AND C.Mov = MT.Mov
WHERE     MT.Clave NOT IN ('CXP.EST', 'CXP.SD', 'CXP.SCH') AND C.Estatus NOT IN ('CANCELADO') 
AND A.AplicaID = CASE WHEN A.AplicaID = A.MovID AND A.Aplica = A.Mov THEN A.AplicaID END
GO

/****** vwPNETConsultaProvEdoCtaD ******/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('vwPNETConsultaProvEdoCtaD') AND type = 'V') 
	DROP VIEW vwPNETConsultaProvEdoCtaD
GO
CREATE VIEW dbo.vwPNETConsultaProvEdoCtaD
AS
SELECT  
	AU.MovID AS Movimiento, 
	CONVERT(VARCHAR(10), AU.Fecha, 105) AS Fecha,
	CONVERT(varchar(50), ISNULL(dbo.Cxp.Vencimiento, ''), 105) AS Vencimiento, 
	AU.Cargo, 
	AU.Abono, 
	dbo.Cxp.Saldo, 
	ISNULL(AU.Moneda, '') AS Moneda,
	CONVERT(MONEY, ROUND(ISNULL(AU.TipoCambio, 0.00), 2)) AS TipoCambio, 
	ISNULL(dbo.Cxp.Estatus, '') AS Estatus, 
	ISNULL(dbo.Cxp.Concepto, '') AS Concepto, 
	AU.AplicaID, AU.Aplica, 
	AU.MovID, 
	AU.Mov, 
	AU.ModuloID, 
	P.Proveedor
FROM 
	dbo.EstadoCuenta AS EC INNER JOIN
    dbo.Prov AS P ON P.Proveedor = EC.Cuenta LEFT OUTER JOIN
	dbo.Auxiliar AS AU ON EC.AuxiliarID = AU.ID LEFT OUTER JOIN
    dbo.Cxp ON dbo.Cxp.ID = AU.ModuloID LEFT OUTER JOIN
    dbo.MovTipo AS MT ON MT.Modulo = AU.Modulo AND dbo.Cxp.Mov = MT.Mov
	WHERE (EC.Modulo = 'CXP') AND (MT.Clave NOT IN ('CXP.EST', 'CXP.SD', 'CXP.SCH')) AND (dbo.Cxp.Estatus NOT IN ('CANCELADO'))
	GROUP BY AU.Fecha, AU.Mov, AU.MovID, dbo.Cxp.Concepto, dbo.Cxp.Estatus, AU.Moneda, AU.TipoCambio, AU.Cargo, AU.Abono, dbo.Cxp.Saldo, dbo.Cxp.Vencimiento, 
    AU.AplicaID, AU.Aplica, AU.MovID, AU.Mov, AU.ModuloID, P.Proveedor
GO


/************************************************************************** Viáticos Acreedor *****************************************************************************/
/****** vwPNETConsultaViaticosAcreedor ******/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('vwPNETConsultaViaticosAcreedor') AND type = 'V') 
	DROP VIEW vwPNETConsultaViaticosAcreedor
GO
CREATE VIEW dbo.vwPNETConsultaViaticosAcreedor
AS
SELECT 
	ROW_NUMBER() OVER ( ORDER BY CONVERT(DATETIME,g.ID) DESC) AS RowIndex,
	g.ID, 
	g.Mov, 
	g.FechaEmision, 
	g.Observaciones, 
	g.Moneda, 
	g.Clase, 
	g.SubClase, 
	g.Estatus, 
	g.Comentarios, 
	g.Nota, 
	g.Acreedor,
	g.FormaPago FROM Gasto as g  
GO

/****** vwPNETConsultaViaticosAcreedorD ******/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('vwPNETConsultaViaticosAcreedorD') AND type = 'V') 
	DROP VIEW vwPNETConsultaViaticosAcreedorD
GO
CREATE VIEW dbo.vwPNETConsultaViaticosAcreedorD
AS
SELECT
	C.Cliente [Cliente],
	AU.MovID [Movimiento],
	CONVERT(VARCHAR(10),AU.Fecha,105) [Fecha], 
	CONVERT(varchar(50),ISNULL(CXC.Vencimiento,''),105) AS [Vencimiento],
	AU.Cargo [Cargo], 
	AU.Abono [Abono],
	CXC.Saldo [Saldo],
	ISNULL(AU.Moneda,'') [Moneda],
	CONVERT(MONEY,ROUND(ISNULL(AU.TipoCambio,0.00),2)) AS [TipoCambio],
	ISNULL(CXC.Estatus,'') [Estatus],
	ISNULL(CXC.Concepto,'') [Concepto],
	AU.AplicaID,
	AU.Aplica,
	AU.MovID,
	AU.Mov,
	AU.ModuloID
FROM EstadoCuenta EC
JOIN Cte C ON EC.Cuenta = C.Cliente
LEFT JOIN Auxiliar AU ON EC.AuxiliarID = Au.ID 
LEFT JOIN CXC CXC ON CXC.ID = AU.ModuloID
LEFT JOIN MovTipo MT ON MT.Modulo = AU.Modulo AND CXC.Mov = MT.Mov
WHERE /*C.Cliente = '001'*/
EC.Modulo='CXC'
AND MT.Clave NOT IN ('CXC.EST','CXC.SD','CXC.SCH')
AND CXC.Estatus  NOT IN ('CANCELADO')
/*AND AU.AplicaID = RTRIM(@Origen)*/
GROUP BY AU.Fecha, AU.Mov, AU.MovID, CXC.Concepto, CXC.Estatus, AU.Moneda, AU.TipoCambio, AU.Cargo, AU.Abono,CXC.Saldo,CXC.Vencimiento,AU.AplicaID,AU.Aplica,AU.MovID,AU.Mov,AU.ModuloID,C.Cliente--,MT.Clave
GO


/******************************************************************* Inventarios ******************************************************************************/
/****** vwPNETInventariosDisponible ******/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('vwPNETInventariosDisponible') AND type = 'V') 
	DROP VIEW vwPNETInventariosDisponible
GO
CREATE VIEW dbo.vwPNETInventariosDisponible
AS   
SELECT TOP 5 ROW_NUMBER() OVER (ORDER BY A.Articulo, D.Almacen) AS ID, 
       A.Articulo, A.Descripcion1, A.Categoria,  A.PrecioLista,  A.PrecioMinimo,  A.Precio2, A.Estatus, A.CostoEstandar,  D. Empresa, D.Disponible, D.Almacen
  FROM Art A  
  JOIN ArtDisponible AS D ON A.Articulo = D.Articulo
 WHERE D.Disponible <> 0 AND A.Estatus = 'ALTA'
GO


/******************************************************************** Personal **********************************************************************************/
/********* vwPNETSaldoVacaciones *********/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('vwPNETSaldoVacaciones') AND type = 'V') 
 DROP VIEW vwPNETSaldoVacaciones
GO
CREATE VIEW dbo.vwPNETSaldoVacaciones
AS
SELECT A.Sucursal, A.Empresa, A.Rama, A.Ejercicio, A.Periodo, A.Moneda, A.Cuenta, A.Cargos, A.Abonos, A.CargosU, A.AbonosU, A.UltimoCambio, P.FechaAlta, 
       P.FechaAntiguedad, P.Personal, CONVERT(VARCHAR(10), A.UltimoCambio, 105) AS UltimoCambioString, CONVERT(VARCHAR(10), P.FechaAlta, 105) AS FechaAltaString, 
       CONVERT(VARCHAR(10), P.FechaAntiguedad, 105) AS FechaAntiguedadString
  FROM dbo.AcumU AS A INNER JOIN
       dbo.Personal AS P ON A.Cuenta = P.Personal
 WHERE (A.Rama = 'VAC')	  
GO

/*************** vwSWPersonal_Info *******************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'vwSWPersonal_Info' AND Type = 'V')
	DROP VIEW vwSWPersonal_Info
GO
CREATE VIEW vwSWPersonal_Info
AS
SELECT 
	RTrim(a.Personal) Personal, 
	Nombre = (RTrim(a.Nombre) + ' ' + RTrim(a.ApellidoPaterno) + ' ' + RTrim(a.ApellidoMaterno)), 
	CURP = RTrim(a.Registro), 
	RFC = RTrim(a.Registro2), 
	Direccion = RTrim(a.Direccion), 
	Delegacion = RTrim(a.Delegacion), 
	Colonia = RTrim(a.Colonia), 
	CodigoPostal = RTrim(a.CodigoPostal), 
	Poblacion = RTrim(a.Poblacion), 
	Estado = RTrim(a.Estado), 
	Pais = RTrim(a.Pais), 
	Telefono = RTrim(a.Telefono), 
	Puesto = RTrim(a.Puesto), 
	Departamento = RTrim(a.Departamento), 
	TipoContrato = RTrim(a.TipoContrato), 
	VencimientoContrato = RTrim(a.VencimientoContrato), 
	PersonalCuenta = RTrim(a.PersonalCuenta), 
	PersonalSucursal = RTrim(a.PersonalSucursal), 
	RegImss = RTrim(a.Registro3), 
	a.SueldoDiario, 
	a.SDI, 
	a.CentroCostos, 
	a.Categoria, 
	a.Empresa, 
	Rol = ISNULL(b.Rol, '') ,
	b.Usuario
FROM Personal a 
LEFT JOIN Recurso b ON b.Personal = a.Personal 
GO


/*************************************************************************** Configuración de Tickets ***************************************************************************/
/******** vwMovTipo **********/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'vwMovTipo' AND Type = 'V')
 DROP VIEW vwMovTipo
GO
CREATE VIEW dbo.vwMovTipo
AS
  SELECT Mov FROM MovTipo 
   WHERE Modulo = 'ST'
GO

/******** vwWebRecursosActuales ********/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'vwWebRecursosActuales' AND Type = 'V')
  DROP VIEW vwWebRecursosActuales
GO
CREATE VIEW vwWebRecursosActuales
AS
  SELECT Recurso, Nombre  
    FROM Recurso   
   WHERE Estatus = 'ALTA' AND isnull(Nombre, '') <> ''
GO

/*************** vwPNetRecursos *******************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'vwPNetRecursos' AND Type = 'V')
	DROP VIEW vwPNetRecursos
GO
CREATE VIEW vwPNetRecursos 
AS  
  SELECT tiprec.Recurso, rec.Nombre,   tiprec.Descripcion
    FROM Recurso rec  INNER JOIN pNetTipoUserRecurso tiprec ON (rec.Recurso = tiprec.Recurso)
   WHERE rec.Estatus = 'ALTA'  
     AND rec.Nombre IS NOT NULL AND rec.Nombre <> '' 
GO


/*************** vwSWPersonal_ConsultaSol *******************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'vwSWPersonal_ConsultaSol' AND Type = 'V')
  DROP VIEW vwSWPersonal_ConsultaSol
GO
CREATE VIEW vwSWPersonal_ConsultaSol
AS
 SELECT Mov, 
		MovID, 
		(RTrim(Mov) + ' ' + RTrim(MovID)) as Movimiento, 
		Titulo, 
		FechaEmision, 
		Estatus, 
		Prioridad, 
		Personal
   FROM Soporte 
GO


/*************** vwPNet_RecProv *******************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'vwPNet_RecProv' AND Type = 'V')
 DROP VIEW vwPNet_RecProv
GO
CREATE VIEW dbo.vwPNet_RecProv
AS
 SELECT Recurso, Nombre 
   FROM Recurso 
  WHERE Estatus = 'ALTA' 
	AND isnull(Nombre, '') <> ''
GO


/*************** vwSWCte_EdoCuenta *******************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'vwSWCte_EdoCuenta' AND Type = 'V')
	DROP VIEW vwSWCte_EdoCuenta
GO
CREATE VIEW vwSWCte_EdoCuenta
AS
 SELECT 
	CxcAux.ModuloID ID,
	RTrim(CxcAux.Mov) Mov, 
	CxcAux.MovID,
	(RTrim(CxcAux.Mov) + ' ' + RTrim(CxcAux.MovID)) as Movimiento, 
	CxcAux.Fecha, 
	CxcAux.Cargo, 
	CxcAux.Abono, 
	RTrim(Moneda) Moneda, 
	CxcAux.EsCancelacion,
	CxcAux.Cliente,
	CxcAux.Empresa
  FROM CxcAux 
 WHERE CxcAux.ModuloID IS NOT NULL
GO

/*************** vwSWCte_PagosPosfechados *******************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'vwSWCte_PagosPosfechados' AND Type = 'V')
	DROP VIEW vwSWCte_PagosPosfechados
GO
CREATE VIEW vwSWCte_PagosPosfechados
AS
SELECT 
	CxcInfo.ID,
	RTrim(CxcInfo.Mov) Mov, 
	RTrim(CxcInfo.MovID) MovID,
	(RTrim(CxcInfo.Mov) + ' ' + RTrim(CxcInfo.MovID)) as Movimiento, 
	CxcInfo.FechaEmision, 
	CxcInfo.Vencimiento, 
	CxcInfo.Saldo,
	CxcInfo.Cliente,
	CxcInfo.Empresa,
	CxcInfo.Moneda
  FROM CxcInfo 
 WHERE 
	CxcInfo.ID IS NOT NULL AND 
	CxcInfo.Mov IN ('Cobro Posfechado')  
GO

/*************** vwSWCte_ComprasPendientes *******************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'vwSWCte_ComprasPendientes' AND Type = 'V')
	DROP VIEW vwSWCte_ComprasPendientes
GO
CREATE VIEW vwSWCte_ComprasPendientes
AS
 SELECT 
	v.ID,
	(RTrim(v.Mov) + ' ' + RTrim(MovID)) as Movimiento, 
	v.FechaEmision, 
	v.Moneda + ' (' + cast(v.TipoCambio as varchar(10)) + ')' Moneda, 
	CONVERT(money, dbo.fnSubTotal(v.Importe, v.DescuentoGlobal, v.SobrePrecio)) SubTotal, 
	v.Impuestos, 
	((CONVERT(money, dbo.fnSubTotal(v.Importe, v.DescuentoGlobal, v.SobrePrecio))) + v.Impuestos) AS Total, 
	ISNULL(Saldo, 0.00) Saldo, 
	v.Cliente,
	v.Empresa
  FROM
	Venta v JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov
 WHERE 
	v.Estatus = 'PENDIENTE'
GO

/*************** vwSWCte_PagosAplicados *******************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'vwSWCte_PagosAplicados' AND Type = 'V')
	DROP VIEW vwSWCte_PagosAplicados
GO
CREATE VIEW vwSWCte_PagosAplicados
AS
SELECT 
	Cxc.ID,
	Cxc.Mov, 
	Cxc.MovID,
	(RTrim(Cxc.Mov) + ' ' + RTrim(Cxc.MovID)) as Movimiento, 
	Cte.NombreCorto, 
	Cxc.Referencia, 
	Cxc.FechaEmision, 
	CxcD.Aplica, 
	CxcD.AplicaID, 
	CxcD.Importe AS Saldo, 
	CxC.Moneda,
	Cxc.Cliente, 
	Cxc.Empresa
  FROM Cxc JOIN CxcD ON Cxc.ID = CxcD.ID 
  JOIN Cte ON Cte.Cliente = Cxc.Cliente
 WHERE Cxc.Estatus = 'CONCLUIDO' 
GO

/*************** vwSWCte_Embarques *******************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'vwSWCte_Embarques' AND Type = 'V')
	DROP VIEW vwSWCte_Embarques
GO
CREATE VIEW vwSWCte_Embarques
AS
SELECT 
	Embarque.ID,
	ISNULL(Embarque.Mov + ' ' + Embarque.MovID, '') As Movimiento, 
	Embarque.FechaEmision, 
	Embarque.Vehiculo,
	Embarque.Agente,
	Embarque.Ruta, 
	Embarque.Referencia, 
	Embarque.Concepto,
	Embarque.CtaDinero,
	--EmbarqueMov.Mov, 
	--EmbarqueMov.MovID,
	--Embarque. Estatus, 
	--EmbarqueD.Paquetes, 
	--EmbarqueD.Estado, 
	--EmbarqueD.FechaHora 'FechaHoraEntrega', 
	--EmbarqueD.Persona, 
	--EmbarqueD.PersonaID, 
	--EmbarqueMov.Modulo, 
	--EmbarqueMov.ModuloID, 
	EmbarqueMov.Cliente,
	Embarque.Empresa,
	Embarque.Observaciones
  FROM Embarque 
	LEFT JOIN EmbarqueD ON EmbarqueD.ID = Embarque.ID 
	LEFT JOIN EmbarqueMov ON EmbarqueD.EmbarqueMov = EmbarqueMov.ID 
 WHERE
	EmbarqueMov.Modulo = 'VTAS' 
GO

/*************** vwSWCte_ComMov *******************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'vwSWCte_ComMov' AND Type = 'V')
	DROP VIEW vwSWCte_ComMov
GO
CREATE VIEW vwSWCte_ComMov
AS
 SELECT 
	ID, 
	MovID,
	(RTrim(Mov) + ' ' + RTrim(MovID)) as Movimiento, 
	Proyecto, 
	UEN,
	Moneda + ' (' + cast(TipoCambio as varchar(10)) + ')' Moneda, 
	FechaEmision, 
	--Concepto,
	--Referencia,
	--Condición,
	CASE WHEN MovClave = 'VTAS.F' 
		THEN (Importe * ((100 - ISNULL(DescuentoGlobal, 0)) / 100)) 
		ELSE (Importe * ((100 - ISNULL(DescuentoGlobal, 0)) / 100) * -1) END Saldo, 
	CASE WHEN MovClave = 'VTAS.F' 
		THEN ISNULL(Impuestos, 0) ELSE (ISNULL(Impuestos, 0) *-1) END Impuestos, 
	CASE WHEN MovClave = 'VTAS.F' 
		THEN (Importe * ((100 - ISNULL(DescuentoGlobal, 0)) / 100)) 
		ELSE (Importe * ((100 - ISNULL(DescuentoGlobal, 0)) / 100) * -1) END  + 
			CASE WHEN MovClave = 'VTAS.F' THEN ISNULL(Impuestos, 0) 
			ELSE (ISNULL(Impuestos, 0) *-1) END Total,
	--Mov, 
	--MovID, 
	--Periodo, 
	--Ejercicio, 
	--DescuentoGlobal, 
	Cliente,
	Empresa
  FROM VentaUtil 
GO

/*************** vwSWCte_Pedidos *******************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'vwSWCte_Pedidos' AND Type = 'V')
	DROP VIEW vwSWCte_Pedidos
GO
CREATE VIEW vwSWCte_Pedidos
AS
SELECT DISTINCT
	Venta.ID, 
	Venta.Mov, 
	Venta.MovID,
	(RTrim(Venta.Mov) + ' ' + RTrim(Venta.MovID)) as Movimiento, 
	Venta.FechaEmision, 
	Moneda + ' (' + cast(TipoCambio as varchar(10)) + ')' Moneda, 
	Venta.Importe,
	Venta.Observaciones, 
	--VentaD.Almacen, 
	--VentaD.Cantidad, 
	--VentaD.Articulo, 
	--VentaD.CantidadReservada, 
	--VentaD.CantidadPendiente, 
	--VentaD.CantidadOrdenada,
	Venta.Cliente,
	Venta.Empresa
  FROM Venta
	JOIN VentaD ON VentaD.ID = Venta.ID
	JOIN MovTipo ON MovTipo.Mov = Venta.Mov
 WHERE
	MovTipo.Clave = 'VTAS.P' 
	AND Venta.Estatus = 'PENDIENTE' 
	--AND Articulo <> 'Seguro' 
	AND (VentaD.CantidadReservada IS NOT NULL OR VentaD.CantidadPendiente IS NOT NULL OR VentaD.CantidadOrdenada IS NOT NULL)  
GO

/*************** vwSWCte_GuiaEmbarque *******************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'vwSWCte_GuiaEmbarque' AND Type = 'V')
	DROP VIEW vwSWCte_GuiaEmbarque
GO
CREATE VIEW vwSWCte_GuiaEmbarque
AS
SELECT 
	Venta.ID VentaID,
	--Venta.Mov,
	--Venta.MovID,
	(RTrim(Venta.Mov) + ' ' + RTrim(Venta.MovID)) as Movimiento,
	Venta.FechaEmision,
	GuiaEmbarque.Paquetes,
	GuiaEmbarque.FechaEnvio,
	GuiaEmbarque.PersonaRecibio,
	GuiaEmbarque.FechaRecepcion,

	GuiaEmbarque.Modulo, 
	GuiaEmbarque.ID, 
	GuiaEmbarque.ID GuiaEmbarqueID,
	GuiaEmbarqueD.Guia,
	GuiaEmbarqueD.Sucursal,
	GuiaEmbarque.FormaEnvio,
	GuiaEmbarqueD.ID GuiaEmbarqueDID,
	Cte.Cliente,
	Venta.Empresa
  FROM Venta
	JOIN Cte ON Venta.Cliente = Cte.Cliente
	JOIN GuiaEmbarque ON Venta.ID = GuiaEmbarque.ID
	JOIN GuiaEmbarqueD ON GuiaEmbarqueD.Modulo = GuiaEmbarque.Modulo AND GuiaEmbarqueD.ID = GuiaEmbarque.ID
 WHERE 
	GuiaEmbarque.Modulo = 'VTAS'
GO

/*************** vwSWCte_ConAtenRep *******************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'vwSWCte_ConAtenRep' AND Type = 'V')
	DROP VIEW vwSWCte_ConAtenRep
GO
CREATE VIEW vwSWCte_ConAtenRep
AS
SELECT
	S.ID,
	RTrim(S.Mov) + isnull(' ' + RTrim(S.MovID), '') Titulo,
	S.Prioridad,
	S.FechaEmision,
	S.FechaConclusion,
	isnull(R.Nombre, 'Sin Asignar') Nombre,
	S.Estatus,
	S.Cliente,
	S.Empresa
  FROM Soporte S LEFT JOIN Recurso R ON S.UsuarioResponsable = R.Recurso
 WHERE S.Submodulo IN ('ST')
GO

/*************** vwSWCte_ConAtenRepDet *******************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'vwSWCte_ConAtenRepDet' AND Type = 'V')
	DROP VIEW vwSWCte_ConAtenRepDet
GO
CREATE VIEW vwSWCte_ConAtenRepDet
AS
SELECT
	S.ID,
	S.Comentarios,
	RTRIM(S.Mov) + ' ' + RTRIM(ISNULL(MovID,'')) Titulo,
	RTRIM(ISNULL(S.Origen,'')) + ' ' + RTRIM(ISNULL(S.OrigenID,'')) Origen,
	(SELECT RTRIM(Mov)+' '+RTRIM(ISNULL(MovID,'')) 
		FROM Soporte WHERE OrigenTipo = 'ST' AND Empresa = S.Empresa AND Origen=S.Mov AND OrigenID = S.MovID) Destino
  FROM Soporte S LEFT JOIN Recurso R ON S.UsuarioResponsable = R.Recurso
 WHERE S.Submodulo = 'ST'
GO

/*************** vwPNet_RecCte *******************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'vwPNet_RecCte' AND Type = 'V')
  DROP VIEW vwPNet_RecCte
GO
CREATE VIEW dbo.vwPNet_RecCte
AS
 SELECT Recurso, Nombre 
   FROM Recurso 
  WHERE Estatus = 'ALTA' 
	AND ISNULL(Nombre, '') <> ''
GO

/*************** vwSWProv_ComPendientes *******************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'vwSWProv_ComPendientes' AND Type = 'V')
	DROP VIEW vwSWProv_ComPendientes
GO
CREATE VIEW vwSWProv_ComPendientes
AS
SELECT 
	RTRIM(ID) ID,
	RTRIM(Mov) Mov, 
	RTRIM(MovID) MovID, 
	(RTRIM(Mov) + ' ' + RTrim(MovID)) as Movimiento,
	FechaEmision, 
	SubTotal, 
	Impuestos, 
	Saldo, 
	(SubTotal + Impuestos) AS Total, 
	RTRIM(Moneda) Moneda, 
	Referencia,
	Empresa,
	Proveedor, 
	Estatus
  FROM CompraPendiente 
 WHERE Estatus = 'PENDIENTE' 
GO

/*************** vwSWProv_PagosAplicados *******************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'vwSWProv_PagosAplicados' AND Type = 'V')
   DROP VIEW vwSWProv_PagosAplicados
GO
CREATE VIEW vwSWProv_PagosAplicados
AS
 SELECT 
	RTRIM(CxP.Id) ID, 
	RTRIM(CxP.Mov) Mov, 
	RTRIM(CxP.MovID) MovID,
	(RTRIM(CxP.Mov) + ' ' + RTrim(CxP.MovID)) as Movimiento, 
	RTRIM(CxP.Referencia) Referencia, 
	CxP.FechaEmision, 
	RTRIM(CxPD.Aplica) Aplica, 
	RTRIM(CxPD.AplicaID) AplicaID, 
	CxPD.Importe AS Saldo, 
	CxP.Impuestos, 
	Total = (CxPD.Importe + CxP.Impuestos), 
	RTRIM(CxP.Moneda) AS Moneda,
	CxP.Empresa,
	CxP.Proveedor,
	Cxp.Estatus
  FROM CxP 
	   JOIN Prov ON Prov.Proveedor = Cxp.Proveedor 
	   LEFT OUTER JOIN CxPD ON Cxp.ID = CxpD.ID 
  WHERE CxP.Estatus = 'CONCLUIDO'
GO

/*************** vwSWProv_GastosPendientes *******************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'vwSWProv_GastosPendientes' AND Type = 'V')
	DROP VIEW vwSWProv_GastosPendientes
GO
CREATE VIEW vwSWProv_GastosPendientes
AS
 SELECT
	RTRIM(id) ID,  
	RTRIM(Mov) Mov, 
	RTRIM(MovID) MovID,
	(RTRIM(Mov) + ' ' + RTrim(MovID)) as Movimiento, 
	FechaEmision, 
	Saldo, 
	Impuestos, 
	Total = (Saldo + Impuestos), 
	RTRIM(Moneda) Moneda, 
	RTRIM(Situacion) Situacion,
	Empresa, 
	Acreedor Proveedor
  FROM GastoPendiente 
 WHERE Estatus = 'PENDIENTE'
GO

/*************** vwSWProv_PagosAprobados *******************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'vwSWProv_PagosAprobados' AND Type = 'V')
	DROP VIEW vwSWProv_PagosAprobados
GO
CREATE VIEW vwSWProv_PagosAprobados
AS
 SELECT 
	ID,
	Contacto Proveedor, 
	RTRIM(Mov) Mov, 
	RTRIM(MovID) MovID,
	(RTRIM(Mov) + ' ' + RTRIM(MovID)) as Movimiento, 
	FechaProgramada, 
	RTRIM(BeneficiarioNombre) Beneficiario, 
	RTRIM(Concepto) Concepto, 
	RTRIM(Referencia) Referencia, 
	RTRIM(Origen) Origen, 
	RTRIM(OrigenID) OrigenID, 
	Importe, 
	RTRIM(Moneda) Moneda, 
	RTRIM(Estatus) Estatus, 
	RTRIM(Observaciones) Observaciones,
	Empresa
  FROM Dinero 
 WHERE Mov = 'Solicitud Cheque'  
GO

/*************** vwSWProv_VerRep *******************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'vwSWProv_VerRep' AND Type = 'V')
	DROP VIEW vwSWProv_VerRep
GO
CREATE VIEW vwSWProv_VerRep
AS
 SELECT
	S.ID,
	S.Proveedor,
	S.Empresa,
	RTrim(S.Estatus) Estatus, 
	S.Titulo, 
	S.Prioridad, 
	S.Referencia,
	R.Nombre,
	S.FechaEmision,
	S.FechaConclusion
  FROM Soporte S JOIN Recurso R ON S.Referencia = R.Recurso
 WHERE Submodulo = 'STPRO'
GO

/*************** vwSWProv_VerRepDet *******************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'vwSWProv_VerRepDet' AND Type = 'V')
	DROP VIEW vwSWProv_VerRepDet
GO
CREATE VIEW vwSWProv_VerRepDet
AS
SELECT
	S.ID,
	S.Comentarios,
	RTRIM(S.Mov) + ' ' + RTRIM(ISNULL(MovID,'')) Titulo,
	RTRIM(ISNULL(S.Origen,'')) + ' ' + RTRIM(ISNULL(S.OrigenID,'')) Origen,
	(SELECT RTRIM(Mov)+' '+RTRIM(ISNULL(MovID,'')) 
		FROM Soporte WHERE OrigenTipo = 'ST' AND Empresa = S.Empresa AND Origen=S.Mov AND OrigenID = S.MovID) Destino
  FROM Soporte S JOIN Recurso R ON S.Referencia = R.Recurso
 WHERE Submodulo = 'STPRO'
GO


/********************* spWebLevantarSugerenciaProv *********************************/
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[spWebLevantarSugerenciaProv]'))
	DROP PROCEDURE [dbo].[spWebLevantarSugerenciaProv]
GO

CREATE PROCEDURE spWebLevantarSugerenciaProv
	@Empresa		char(5),
	@Usuario		char(10),
	@FechaHoy		DATETIME,
	@User			CHAR(10),
	@Proyecto		VARCHAR(50),
	@Contacto		VARCHAR(50),
	@Telefono		VARCHAR(30),
	@Extencion		VARCHAR(10),
	@Fax			VARCHAR(30),
	@eMail			VARCHAR(30),
	@Agente			CHAR(10),
	@Comentarios 	VARCHAR(4192)

AS BEGIN
	SET NOCOUNT ON 

	INSERT INTO Soporte (Empresa, Usuario, UsuarioResponsable, FechaEmision, UltimoCambio, Vencimiento, Proveedor, Proyecto, 
	Contacto, Telefono, Extencion, Fax, eMail, Agente, Comentarios, Titulo, Problema, Solucion, 
	Mov, SubModulo, Estatus, Estado, Sucursal, SucursalOrigen, TieneContrato, PuedeDevolver, GenerarPoliza) 

	VALUES(@Empresa, @Usuario, @Usuario, @FechaHoy, @FechaHoy, @FechaHoy, @User, @Proyecto, 
	@Contacto, @Telefono, @Extencion, @Fax, @Email, @Agente, @Comentarios, 
	'Sugerencia', '', '', 'Sugerencia', 'STPRO', 'SINAFECTAR', 'No comenzado', 0, 0, 0, 0, 0) 

	SELECT @@IDENTITY AS NewID 
END
GO

/********************* spWebLevantarQuejaProv *********************************/
IF EXISTS(SELECT * FROM SysObjects WHERE Name = 'spWebLevantarQuejaProv' AND TYPE = 'P')
	DROP PROCEDURE spWebLevantarQuejaProv
GO

CREATE PROCEDURE spWebLevantarQuejaProv 
	@Empresa		char(5),
	@Usuario		char(10),
	@FechaHoy		DATETIME,
	@User			CHAR(10),
	@Proyecto		VARCHAR(50),
	@Contacto		VARCHAR(50),
	@Telefono		VARCHAR(30),
	@Extencion		VARCHAR(10),
	@Fax			VARCHAR(30),
	@eMail			VARCHAR(30),
	@Agente			CHAR(10),
	@Titulo 		VARCHAR(100),
	@Comentarios 		VARCHAR(4192),	
	@Observaciones 		VARCHAR(100),
	@Referencia 		VARCHAR(50),
	@Prioridad 		CHAR(10)

AS BEGIN
	SET NOCOUNT ON
	 
	INSERT INTO Soporte 
	(Empresa, Usuario, UsuarioResponsable, FechaEmision, UltimoCambio, Vencimiento, Proveedor, Proyecto, Contacto, 
	Telefono, Extencion, Fax, eMail, Agente, Titulo, Comentarios, Observaciones, Referencia, Prioridad, Problema, Solucion, 
	Mov, SubModulo, Estatus, Estado, Sucursal, SucursalOrigen, TieneContrato, PuedeDevolver, GenerarPoliza) 
	VALUES(@Empresa, @Usuario, @Usuario, @FechaHoy, @FechaHoy, @FechaHoy, @User, @Proyecto, 
	@Contacto, @Telefono, @Extencion, @Fax, @Email, @Agente, @Titulo, @Comentarios, 
	@Observaciones, @Referencia, @Prioridad, '', '',
	'Queja', 'STPRO', 'SINAFECTAR', 'No comenzado', 0, 0, 0, 0, 0) 

	SELECT @@IDENTITY AS NewID 

END
GO

/*************** vwPNet_RecPersonal *******************/
IF EXISTS(SELECT * FROM Sysobjects WHERE Name = 'vwPNet_RecPersonal' AND Type = 'V')
	DROP VIEW vwPNet_RecPersonal
GO
CREATE VIEW dbo.vwPNet_RecPersonal
AS
 SELECT Recurso, Nombre 
   FROM Recurso 
  WHERE Estatus = 'ALTA' 
	AND isnull(Nombre, '') <> ''
GO

/****** pNetAgente ******/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('pNetAgente') and type = 'V') 
	DROP VIEW pNetAgente
GO
CREATE VIEW pNetAgente
AS
SELECT LTRIM(RTRIM(Agente)) Agente, LTRIM(RTRIM(Nombre)) Nombre
  FROM Agente WHERE Estatus = 'ALTA'
GO


/****** pNetCampana ******/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('pNetCampana') and type = 'V') 
	DROP VIEW pNetCampana
GO
CREATE VIEW pNetCampana
AS
SELECT 
 -- Para el panel de control
 c.ID, 
 LTRIM(RTRIM(ISNULL(c.Mov,''))) + ' ' + LTRIM(RTRIM(ISNULL(c.MovID,''))) Movimiento, 
 c.Asunto, 
 c.CampanaTipo, 
 c.FechaEmision, 
 c.Estatus,
 c.Usuario,
 -- Para el detalle
 c.Empresa,
 c.Mov,
 c.MovID, 
 c.UltimoCambio,
 c.Concepto,
 c.Proyecto,
 c.Observaciones,
 c.FechaRegistro,
 c.Sucursal,
 c.Agente,
 a.Nombre AgenteNombre,
 (SELECT COUNT(RID) FROM CampanaD cd WHERE cd.ID = c.ID) TotalContactos
 FROM Campana c 
 LEFT JOIN Agente a ON c.Agente = a.Agente
 LEFT JOIN MovTipo mt ON 'CMP' = mt.Modulo AND c.Mov = mt.Mov
 WHERE mt.Clave = 'CMP.C'
GROUP BY c.ID, c.Mov, c.MovID, c.Asunto, c.CampanaTipo, c.FechaEmision, c.Estatus, c.Usuario, c.Empresa, c.Mov, c.MovID, 
          c.UltimoCambio, c.Concepto, c.Proyecto, c.Observaciones, c.FechaRegistro, c.Sucursal, c.Agente, a.Nombre
GO


/****** pNetCampanaRep ******/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('pNetCampanaRep') and type = 'V') 
	DROP VIEW pNetCampanaRep
GO
CREATE VIEW pNetCampanaRep
AS
SELECT * FROM pNetCampana
 WHERE Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
GO

/****** pNetCampanaD ******/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('pNetCampanaD') and type = 'V') 
	DROP VIEW pNetCampanaD
GO
CREATE VIEW pNetCampanaD
AS
SELECT 
 -- Para el detalle del movimiento
 cd.ID,
 cd.RID,
 cd.Contacto,
 cd.ContactoTipo,
 cd.Situacion,
 dbo.fnFechaSinHora(cd.SituacionFecha) SituacionFecha,
 cd.Observaciones,
 cd.Usuario,
 cd.Sucursal,
 cd.SucursalOrigen,
 p.Nombre,
 p.Tipo,
 LTRIM(RTRIM(c.Mov)) + ' ' + LTRIM(RTRIM(c.MovID)) Movimiento,
 p.Origen,
 p.Categoria,
 c.CampanaTipo,
 c.FechaEmision,
 p.Agente,
 a.Nombre AgenteNombre,
 c.Estatus
 FROM CampanaD cd JOIN Prospecto p ON cd.ContactoTipo = 'Prospecto' AND cd.Contacto = p.Prospecto
 LEFT JOIN Agente a ON p.Agente = a.Agente
 JOIN Campana c ON cd.ID = c.ID
 
GO

/****** pNetCampanaDGrafica ******/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('pNetCampanaDGrafica') and type = 'V') 
	DROP VIEW pNetCampanaDGrafica
GO
CREATE VIEW pNetCampanaDGrafica
AS
SELECT *
  FROM pNetCampanaD
 WHERE ISNULL(Situacion,'') <> ''
GO


/****** pNetCampanaDRep ******/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('pNetCampanaDRep') and type = 'V') 
	DROP VIEW pNetCampanaDRep
GO
CREATE VIEW pNetCampanaDRep
AS
SELECT *
  FROM pNetCampanaD
 WHERE ISNULL(Situacion,'') <> '' AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
GO

/****** pNetCampanaDet ******/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('pNetCampanaDet') and type = 'V') 
	DROP VIEW dbo.pNetCampanaDet
GO
CREATE VIEW pNetCampanaDet
AS
SELECT DISTINCT c.ID, c.Mov, c.MovID, 
  LTRIM(RTRIM(ISNULL(c.Mov,''))) + ' ' + LTRIM(RTRIM(ISNULL(c.MovID,''))) Movimiento, 
  c.FechaEmision, c.Asunto, c.CampanaTipo, cd.ContactoTipo, cd.Contacto, c.Estatus
  FROM Campana c JOIN CampanaD cd ON c.ID = cd.ID
GO

/****** pNetCampanaEvento ******/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('pNetCampanaEvento') and type = 'V') 
	DROP VIEW pNetCampanaEvento
GO
CREATE VIEW pNetCampanaEvento
AS
SELECT c.ID, cd.RID, ce.EventoID, ce.FechaHora, ce.Tipo, ce.Situacion, ce.SituacionFecha, ce.Observaciones, ce.Sucursal, cd.Contacto, p.Nombre,
       c.CampanaTipo, cd.Usuario, u.Nombre UsuarioNombre, LTRIM(RTRIM(c.Mov))+' '+LTRIM(RTRIM(c.MovID)) Movimiento, c.Estatus
  FROM Campana c JOIN CampanaD cd ON c.ID = cd.ID
  JOIN CampanaEvento ce ON cd.ID = ce.ID AND cd.RID = ce.RID
  LEFT JOIN Usuario u ON cd.Usuario =  u.Usuario
  LEFT JOIN Prospecto p ON cd.ContactoTipo = 'Prospecto' AND cd.Contacto = p.Prospecto
GO

/****** pNetCampanaEventoRep ******/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('pNetCampanaEventoRep') and type = 'V') 
	DROP VIEW pNetCampanaEventoRep
GO
CREATE VIEW pNetCampanaEventoRep
AS
SELECT * FROM pNetCampanaEvento
 WHERE Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
GO


/****** pNetCampanaSituacion ******/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('pNetCampanaSituacion') and type = 'V') 
	DROP VIEW pNetCampanaSituacion
GO
CREATE VIEW pNetCampanaSituacion
AS
SELECT 
  c.ID, cs.CampanaTipo, cs.Situacion, cs.Orden
  FROM CampanaTipoSituacion cs
  JOIN Campana c ON cs.CampanaTipo = c.CampanaTipo
GO

/****** pNetCmpProspecto ******/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('pNetCmpProspecto') and type = 'V') 
	DROP VIEW pNetCmpProspecto
GO
CREATE VIEW pNetCmpProspecto
AS
SELECT cd.ID, cd.RID, cd.Contacto, p.Nombre, p.Tipo, cd.Situacion, cd.SituacionFecha, cd.Observaciones, p.Agente, u.Nombre Usuario 
  FROM CampanaD cd JOIN Prospecto p 
    ON cd.Contacto = p.Prospecto AND cd.ContactoTipo = 'Prospecto' LEFT JOIN Usuario u
	ON cd.Usuario = u.Usuario
GO

/****** pNetProspecto ******/
if exists (select * from sysobjects where id = object_id('dbo.pNetProspecto') and type = 'V') drop view dbo.pNetProspecto
GO
CREATE VIEW dbo.pNetProspecto
AS
SELECT 
 p.Prospecto, p.Nombre, p.Direccion, p.DireccionNumero, p.DireccionNumeroInt, p.EntreCalles, p.Plano, p.Observaciones, 
 p.Delegacion, p.Colonia, p.Poblacion, p.Estado, p.Pais, p.Zona, p.CodigoPostal, p.RFC, p.CURP, p.Telefonos, p.TelefonosLada, p.Fax,
 p.PedirTono, p.Categoria, p.Grupo, p.Familia, p.Tipo, p.Estatus, p.UltimoCambio, p.Agente, a.Nombre AgenteNombre,
 p.eMail, p.NombreComercial, p.ReferidoNombre, p.ReferidoMail, p.ReferidoTelefono, p.ReferidoRFC, p.RelacionReferencia,
 p.Alta, p.Origen
 FROM Prospecto p LEFT JOIN Agente a ON p.Agente = a.Agente
 GO

 /********************************************************************** pNetRepLogRecibosNomina *************************************************************/

 /************** pNetRepLogRecibosNomina *************/
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('dbo.pNetRepLogRecibosNomina'))  DROP VIEW pNetRepLogRecibosNomina
GO
CREATE VIEW pNetRepLogRecibosNomina
AS 
SELECT l.*, dbo.fnFechaSinHora(FechaRegistro) FechaRegistroSinHora, LTRIM(RTRIM(p.NombreCompleto)) Nombre
  FROM LogRecibosNomina l JOIN PersonalA p ON l.Usuario = p.Personal
GO

 /********************************************************************** Eventualidades **********************************************************************/

 /****************vwPNETEventualidades*****************************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('vwPNETEventualidades') AND type = 'V') 
	DROP VIEW vwPNETEventualidades
GO
CREATE VIEW dbo.vwPNETEventualidades
AS
 SELECT ce.ID, ce.Fecha, ce.Identificacion, ce.Acomp, ce.Apartamento, ce.Cliente, c.Nombre, ce.Torre, ce.Matricula, ce.Cajon, ce.Comentarios
   FROM pNetEventualidades ce LEFT JOIN Cte c
     ON ce.Cliente = c.Cliente

GO
/********************************************************************** Amenidades **********************************************************************/

/************************vwPNETAmenidades*****************************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('vwPNETAmenidades') AND type = 'V') 
	DROP VIEW vwPNETAmenidades
GO
CREATE VIEW dbo.vwPNETAmenidades
AS
	SELECT 
		A.ID as ID,
		A.Espacio as Espacio,
		A.DiaCompletoHora as DiaCompletoHora,
		E.Nombre as Nombre,
		CONVERT(VARCHAR(24),A.FechaDesde,121) as FechaDesde,
		CONVERT(VARCHAR(24),A.FechaHasta,121) as FechaHasta,
		A.NumPersonas as NumPersonas,
		A.Vivienda as Vivienda,
		A.Telefono as Telefono,
		A.eMail as eMail,
		A.Observaciones as Observaciones,
		A.Cliente as Cliente,
		C.Nombre as NombreCliente
		from Amenidades as A
		INNER JOIN Espacio as E ON A.Espacio = E.Espacio
		INNER JOIN Cte as C ON C.Cliente = A.Cliente
GO
/*************************************************************** Comunicados ***************************************************************/
/************************vwPNETComunicados*****************************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('vwPNETComunicados') AND type = 'V') 
	DROP VIEW vwpNetComunicados
GO
CREATE VIEW dbo.vwPNETComunicados
AS
	SELECT
		 c.IDComunicado AS ID,
		 c.Titulo AS Titulo,
		 c.DirigidoA AS Dirigido,
		 (CONVERT(VARCHAR(24),c.FechaPublicado,113)) AS Publicado,  
		 (CONVERT(VARCHAR(24),c.FechaVigencia,113)) AS Vigencia,
		 c.FechaPublicado AS FechaPublicadoDate,
		 c.FechaVigencia AS FechaVigenciaDate,
		 c.Descripcion AS Descripcion,
		 c.Prioridad AS Prioridad,
		 a.Descripcion AS Tipo,
		 c.Estatus As Estatus
		FROM pNetComunicado AS c
		INNER JOIN pNetCatComunicado AS a ON c.Tipo = a.IDCatCom
GO