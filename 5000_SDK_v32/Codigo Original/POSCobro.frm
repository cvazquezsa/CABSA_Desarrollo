
[Forma]
Clave=POSCobro
Icono=0
Modulos=(Todos)
Nombre=POS Cobro

ListaCarpetas=(Lista)
CarpetaPrincipal=Cobro
AccionesTamanoBoton=100x5
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=249
PosicionInicialArriba=144
PosicionInicialAlturaCliente=506
PosicionInicialAncho=1038
PosicionCol1=430




ListaAcciones=(Lista)
PosicionSec1=280
PosicionSec2=486
PosicionCol3=449
AccionesCentro=S
AccionesDivision=S
Menus=S
PosicionCol2=449
EsConsultaExclusiva=S
VentanaExclusiva=S
VentanaExclusivaOpcion=2
VentanaSinIconosMarco=S

//ExpresionesAlMostrar=Asigna(Ver.FormasPago, TextoEnLista(SQL(<T>EXEC spPOSMuestraFormasPago<T>)))<BR>Asigna(Info.POSImporteOferta,TextoEnLista(SQL(<T>spPOSMuestraOfertasFormasPago :tID,:tEmpresa,:nSucursal,:nEstacion<T>,Info.IDTexto,Empresa,Sucursal,EstacionTrabajo)))<BR>Asigna(Ver.Cobro, TextoEnLista(SQL(<T>EXEC spPOSMuestraVentaCobro :tID<T>, Info.IDTexto)))  <BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Ver.Aviso,Nulo)<BR>Asigna(Info.Referencia, Nulo)<BR>Asigna(Info.POSImporteRef, Info.Importe)<BR>Asigna(Info.CodigoFormaPago, Nulo)<BR>Asigna(Ver.Cambio, $0.00)<BR>Asigna(Info.Cambio, 0)<BR>Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>Asigna(Info.POSTipoCambioSuc,1)<BR>Asigna(Info.TorretaMensaje1,<T>IMPORTE  <T>+SQL(<T>SELECT dbo.fnFormatoMoneda(:nImporte,:tEmpresa)<T>,Info.Importe,Empresa))<BR>Asigna(Info.TorretaPosicion1,<T>Derecha<T>)<BR>Asigna(Info.TorretaMensaje2,<T>SALDO  <T>+SQL(<T>SELECT dbo.fnFormatoMoneda(:nImporte,:tEmpresa)<T>,Info.Saldo,Empresa))<BR>Asigna(Info.TorretaPosicion2,<T>Derecha<T>)<BR>Asigna(Info.Importe2,Info.Importe)<BR>Asigna(Temp.Flotante,SQL(<T>spPOSVentaInsertaRedondeo :tID,:tTipo,:nImporte<T>,Info.IDTexto,<T>CONSULTAR COBRO<T>,Nulo))<BR>Asigna(Info.Acumulativa,SQL(<T>SELECT RedondeoVenta FROM POSCfg WHERE Empresa = :tEmpresa<T>,Empresa))<BR>Si<BR>  Info.Torreta<BR>Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>Fin<BR><BR>Asigna(Info.Clase1,<T>F9<T>+NuevaLinea+<T>Alta Monedero<T>)<BR>Asigna(Info.Clase2,<T>F10<T>+NuevaLinea+<T>Cancelar Partida Forma de Pago<T>)<BR>Asigna(Info.Clase3,<T>F12<T>+NuevaLinea+<T>Cobrar<T>)<BR><BR>Asigna(Info.POSFormaPago2,<T>F2<T>+NuevaLinea+SQL(<T>SELECT ISNULL(c.FormaPago,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F2 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago3,<T>F3<T>+NuevaLinea+SQL(<T>SELECT ISNULL(c.FormaPago,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F3 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago4,<T>F4<T>+NuevaLinea+SQL(<T>SELECT ISNULL(c.FormaPago,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F4 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago5,<T>F5<T>+NuevaLinea+SQL(<T>SELECT ISNULL(c.FormaPago,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F5 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago6,<T>F6<T>+NuevaLinea+SQL(<T>SELECT ISNULL(c.FormaPago,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F6 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago7,<T>F7<T>+NuevaLinea+SQL(<T>SELECT ISNULL(c.FormaPago,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F7 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago8,<T>F8<T>+NuevaLinea+SQL(<T>SELECT ISNULL(c.FormaPago,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))<BR><BR>Si<BR>  Info.Acumulativa<BR>Entonces<BR>  Asigna(Info.Clase4,<T>F11<T>+NuevaLinea+<T>Redondeo<T>)<BR>Sino<BR>    Asigna(Info.Clase4,<T>F11<T>)            <BR>Fin


VentanaColor=$00804000
ExpresionesAlMostrar=Asigna(Ver.FormasPago, TextoEnLista(SQL(<T>EXEC spPOSMuestraFormasPago<T>)))<BR>Asigna(Info.POSImporteOferta,TextoEnLista(SQL(<T>spPOSMuestraOfertasFormasPago :tID,:tEmpresa,:nSucursal, :tEstacion<T>,Info.IDTexto,Empresa,Sucursal,  EstacionTrabajo )))<BR>Asigna(Ver.Cobro, TextoEnLista(SQL(<T>EXEC spPOSMuestraVentaCobro :tID<T>, Info.IDTexto)))<BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Ver.Aviso,Nulo)<BR>Asigna(Info.Referencia, Nulo)<BR>Asigna(Info.POSImporteRef,Info.Importe)<BR>Asigna(Info.CodigoFormaPago, Nulo)<BR>Asigna(Ver.Cambio, $0.00)<BR>Asigna(Info.Cambio, 0)<BR>Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>Asigna(Info.POSTipoCambioSuc,1)<BR>Asigna(Info.TorretaMensaje1,<T>IMPORTE  <T>+SQL(<T>SELECT dbo.fnFormatoMoneda(:nImporte,:tEmpresa)<T>,Info.Importe,Empresa))<BR>Asigna(Info.TorretaPosicion1,<T>Derecha<T>)<BR>Asigna(Info.TorretaMensaje2,<T>SALDO  <T>+SQL(<T>SELECT dbo.fnFormatoMoneda(:nImporte,:tEmpresa)<T>,Info.Saldo,Empresa))<BR>Asigna(Info.TorretaPosicion2,<T>Derecha<T>)<BR>Asigna(Info.Importe2,Info.Importe)<BR>Asigna(Temp.Flotante,SQL(<T>spPOSVentaInsertaRedondeo :tID,:tTipo,:nImporte<T>,Info.IDTexto,<T>CONSULTAR COBRO<T>,Nulo))<BR>Asigna(Info.Acumulativa,SQL(<T>SELECT RedondeoVenta FROM POSCfg WHERE Empresa = :tEmpresa<T>,Empresa))<BR>Asigna(Info.Titulo, SQLEnLista(<T>SELECT Space(3)+ Moneda, TipoCambio FROM POSLTipoCambioRef WHERE Sucursal =:nS<T>, Sucursal))<BR>Si<BR>  Info.Torreta<BR>Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>Fin<BR><BR>Asigna(Info.Clase1,<T>Alta Monedero<T>)<BR>Asigna(Info.Clase2,<T>Cancelar Partida &.<T>)<BR>Asigna(Info.Clase3,<T>Cobrar<T>)<BR><BR>/*Asigno la forma de pago Efectivo por Omision JLMR 01 2013*/<BR>Asigna(Info.CodigoFormaPago, SQL(<T>SELECT ISNULL(f.F2,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F2 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Temp.TextoTemp02, Info.CodigoFormaPago)<BR>Asigna(Info.POSFormaPago2,SQL(<T>SELECT ISNULL(NULLIF(f.F2, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F2 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.POSFormaPago3,SQL(<T>SELECT ISNULL(NULLIF(f.F3, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F3 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.POSFormaPago4,SQL(<T>SELECT ISNULL(NULLIF(f.F4, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F4 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.POSFormaPago5,SQL(<T>SELECT ISNULL(NULLIF(f.F5, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F5 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.POSFormaPago6,SQL(<T>SELECT ISNULL(NULLIF(f.F6, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F6 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.POSFormaPago7,SQL(<T>SELECT ISNULL(NULLIF(f.F7, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F7 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.POSFormaPago8,SQL(<T>SELECT ISNULL(NULLIF(f.F8, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR><BR>Asigna(Info.BancoA01,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA01,:tNulo),:tVacio) + :tPunto FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoA01 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T> &.<T>,<T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoA02,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA02,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoA02 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoA03,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA03,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoA03 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoA04,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA04,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoA04 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoA05,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA05,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoA05 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoA06,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA06,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoA06 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoA07,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA07,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoA07 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoA08,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA08,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoA01 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR><BR>Asigna(Info.BancoB01,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB01,:tNulo),:tVacio) + :tPunto FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoB01 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T> &.<T>,<T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoB02,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB02,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoB02 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoB03,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB03,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoB03 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoB04,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB04,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoB04 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoB05,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB05,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoB05 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoB06,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB06,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoB06 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoB07,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB07,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoB07 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoB08,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB08,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoB08 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR><BR>Asigna(Info.BancoC01,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC01,:tNulo),:tVacio) + :tPunto FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoC01 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T> &.<T>,<T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoC02,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC02,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoC02 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoC03,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC03,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoC03 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoC04,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC04,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoC04 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoC05,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC05,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoC05 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoC06,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC06,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoC06 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoC07,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC07,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoC07 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoC08,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC08,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoC08 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))
ExpresionesAlCerrar=//Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tFormaCambio, :nCambio, :nCobro, :nLecturaTarjeta, :tCliente, :tMonedero,:nImporteRef<T>, EstacionTrabajo, Nulo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto, NULO, Info.FormaPagoCambio, Info.Cambio, 1, Nulo, Nulo,Nulo,Nulo))
ExpresionesAlActivar=Asigna(Info.Codigo, Nulo)<BR>Forma.EnfocarVariable( <T>Cobro<T>, <T>Info.CodigoFormaPago<T> )
MenuTouchScreenMostrarTeclasFuncion=S
MenuPrincipal=(Lista)
[POSCobro.ListaEnCaptura]
(Inicio)=Ver.Total
Ver.Total=Info.Codigo
Info.Codigo=Info.Saldo
Info.Saldo=(Fin)




[Cobro]
Estilo=Ficha
Clave=Cobro
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
ConFuenteEspecial=S
Fuente={Segoe UI, 18, Blanco, []}
FichaEspacioEntreLineas=3
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=$00804000
FichaAlineacionDerecha=S
CampoColorLetras=Blanco
CampoColorFondo=$00C08000
ListaEnCaptura=(Lista)

CarpetaVisible=S


AlinearTodaCarpeta=S

[Acciones.Enter.VariablesAsignar]
Nombre=VariablesAsignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
Activo=S
Visible=S


[Saldo.Ver.Saldo]
Carpeta=Saldo
Clave=Ver.Saldo
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=11
ColorFondo=$FFFFFFFF





















ColorFuente=$0000FF80
[Cobro.Info.Referencia]
Carpeta=Cobro
Clave=Info.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=N
Tamano=14













AccionAlEnter=












IgnoraFlujo=N
ColorFuente=Rojo obscuro
EditarConBloqueo=S
ColorFondo=Blanco
[Cambio]
Estilo=Ficha
Clave=Cambio
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=(Variables)
Fuente={Segoe UI, 22, Blanco, []}
CampoColorLetras=Blanco
CampoColorFondo=$00804000
ListaEnCaptura=(Lista)
CarpetaVisible=S

FichaEspacioEntreLineas=4
FichaEspacioNombres=171
FichaColorFondo=$00804000
ConFuenteEspecial=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
AlinearTodaCarpeta=S

BarraBotones=S
BarraBtnFuente={Segoe UI, 10, Blanco, []}
BarraBtnFondo=$00804000
BarraBtnPosicion=Abajo
BarraBtnSize=80
BarraBtnSeparacion=2
BarraBtnSinBisel=S
BarraBtnBisel=0
BarraBtnPaginas=5
ListaAccionesBB=(Lista)
[Acciones.CalculaCambio]
Nombre=CalculaCambio
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S













Multiple=S
ListaAccionesMultiples=(Lista)

NombreDesplegar=&Cambio
[Acciones.CalculaCambio.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.CalculaCambio.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S











Expresion=Asigna(Ver.Cambio, SQL(<T>EXEC spPOSCalculaCambio :nSaldo, :tEmpresa, :nImporte, :tFPCodigo, :nSuc<T>, Info.Saldo,Empresa, Info.Importe, Info.FormaPagoCambio, Sucursal))<BR>Asigna(Info.Cambio, SQL(<T>EXEC spPOSCalculaCambioCalc :nSaldo, :tEmpresa, :nImporte, :nMostrar<T>, Info.Saldo, Empresa, Info.Importe, 1))
[Cambio.Ver.Cambio]
Carpeta=Cambio
Clave=Ver.Cambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=N
Tamano=28
ColorFondo=$00804000
EspacioPrevio=N
ColorFuente=Blanco
































Efectos=[Negritas]
[Acciones.Enter.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Enter.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S





ConCondicion=S
EjecucionCondicion=Info.Saldo <= 0
[Cobro.Info.POSRedondeo]
Carpeta=Cobro
Clave=Info.POSRedondeo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=N
Tamano=14
ColorFondo=$00C08000









AccionAlEnter=ActualizaRedondeo
EspacioPrevio=N
ColorFuente=Blanco
[Acciones.ActualizaRedondeo.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.ActualizaRedondeo.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S


[Acciones.Enter.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S








































ConCondicion=S





















Expresion=forma.Accion(<T>CalculaCambio<T>)<BR>forma.Accion(<T>CalculaImporteRef<T>)<BR>Asigna(Info.POSLDIError, Nulo)<BR>Asigna(Info.FormaExtra, Nulo)<BR>Asigna(Info.VFAFormaPago, SQL(<T>EXEC spPOSVFAFormaPago :tCodigo, :tID<T>, Info.CodigoFormaPago, Info.IDTexto))<BR>Asigna(Info.FormaExtra, SQL(<T>EXEC spPOSLDIFormaPagoFormaAnexa :tCodigo, :tID, :tEmpresa<T>, Info.CodigoFormaPago, Info.IDTexto, Empresa))<BR><BR>Si<BR>  SQL(<T>SELECT POSMonedero FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa)=0<BR>Entonces<BR>  Si<BR>    Info.FormaExtra <> Nulo   y    vacio(Info.POSMonedero)<BR>  Entonces<BR>    FormaModal(Info.FormaExtra)<BR>   Fin<BR>Sino<BR>  <T><T><BR>Fin<BR><BR>Si<BR>  ConDatos(Info.VFAFormaPago)<BR>Entonces<BR>  VFA.Cargo(<T>POS<T>, Info.IDTexto,<T>2048<T>,Info.Referencia,Info.Importe)<BR>  Asigna(Temp.Reg2, SQL(<T>spPOSVFAVerificar :tID<T>,Info.IDTexto))<BR>  Asigna(Info.POSVFAError,Temp.Reg2[1])<BR>  Asigna(Info.POSVFAMensajeError,Temp.Reg2[2])<BR>  Asigna(Info.Importe,Temp.Reg2[3])<BR><BR>Fin<BR><BR>Si<BR>  ConDatos(Info.POSVFAError)<BR>Entonces<BR>  Error(Info.POSVFAMensajeError)<BR>  Asigna(Info.Codigo,Nulo)<BR>Fin<BR><BR>Asigna(Info.FormaExtra, Nulo)<BR>Asigna(Info.Codigo, Info.CodigoFormaPago)<BR>// lo modifique para que siempre traiga la forma de pago por Omision<BR>//Asigna(Info.CodigoFormaPago, Nulo)<BR>Asigna(Info.CodigoFormaPago, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR><BR>Si Info.POSLDIError <> Nulo Entonces Asigna(Info.Codigo, Nulo) Fin<BR><BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tFormaCambio, :nCambio, :nCobro, :nLecturaTarjeta, :tCliente, :tMonedero<T>, EstacionTrabajo, Nulo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto, 0, Nulo,Nulo, 0, Nulo, Nulo, Info.POSMonedero))<BR>Asigna(Info.FormaExtra,Temp.Reg[13])<BR>Asigna(Info.Servicio,Temp.Reg[12])<BR><BR>Si (Info.FormaExtra <> Nulo)  y (Info.Servicio <> Nulo) Entonces  FormaModal(Info.FormaExtra) Fin<BR><BR><BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tFormaCambio, :nCambio, :nCobro, :nLecturaTarjeta, :tCliente, :tMonedero,:nImporteRef<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto, Info.Importe, Info.FormaPagoCambio, Info.Cambio, 1, Nulo, Nulo, Info.POSMonedero, Info.POSImporteRef))<BR><BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Si<BR>  Info.Saldo = 0<BR>Entonces<BR>  Asigna(Info.POSImporteOferta,Nulo)<BR>Fin<BR><BR>Asigna(Ver.Cobro, TextoEnLista(SQL(<T>EXEC spPOSMuestraVentaCobro :tID<T>, Info.IDTexto)))<BR>Asigna(Info.TorretaMensaje1,<T>IMPORTE  <T>+SQL(<T>SELECT dbo.fnFormatoMoneda(:nImporte,:tEmpresa)<T>,Info.Importe2,Empresa))<BR>Asigna(Info.TorretaPosicion1,<T>Derecha<T>)<BR>Asigna(Info.TorretaMensaje2,<T>SALDO  <T>+SQL(<T>SELECT dbo.fnFormatoMoneda(:nImporte,:tEmpresa)<T>,Info.Saldo,Empresa))<BR>Asigna(Info.TorretaPosicion2,<T>Derecha  <T>)<BR>Si<BR>  Info.Torreta<BR>Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>Fin<BR><BR><BR>//*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*//<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Info.Mensaje,Nulo)<BR>Asigna(Info.POSMonedero, Nulo)<BR>Asigna(Info.Referencia, Nulo)<BR>Asigna(Info.POSImporteRef, Nulo)<BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR>Si Info.Cambio noen(0, <T>$0.00<T>)<BR>Entonces<BR>Asigna(Info.Mensaje,<T>Cambio: <T> & Ver.Cambio)<BR>Fin
EjecucionCondicion=(Info.Cambio en(0, <T>$0.00<T>))<BR>o (ConDatos(Info.FormaPagoCambio) y (Info.Importe = 0)y (Info.Saldo = 0))<BR>o (ConDatos(Info.FormaPagoCambio) y (Info.Importe > 0)y (Info.Saldo > 0))
[Mensaje.Ver.Aviso]
Carpeta=Mensaje
Clave=Ver.Aviso
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=38x5
ColorFondo=Negro



























ColorFuente=Amarillo
[Cobro.Info.CodigoFormaPago]
Carpeta=Cobro
Clave=Info.CodigoFormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=N
AccionAlEnter=
Tamano=14

IgnoraFlujo=S






EspacioPrevio=N

ColorFuente=Rojo obscuro
ColorFondo=Blanco

[Acciones.FormaAnexa.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S


[Acciones.FormaAnexa.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S







[Acciones.FormaAnexa.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Expresion
Expresion=(Fin)




















































[Cobro.Info.FormaPagoCambio]
Carpeta=Cobro
Clave=Info.FormaPagoCambio
Editar=N
LineaNueva=S
ValidaNombre=S
3D=N
EspacioPrevio=N
Tamano=14














AccionAlEnter=
IgnoraFlujo=N
ColorFuente=Rojo obscuro
ColorFondo=Blanco
[Acciones.CalculaImporteRef]
Nombre=CalculaImporteRef
Boton=0
NombreDesplegar=CalculaImporteRef
TipoAccion=Expresion
Activo=S
Visible=S




Multiple=S
ListaAccionesMultiples=(Lista)

[Acciones.CalculaImporteRef.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.CalculaImporteRef.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S





Expresion=Asigna(Info.Importe, SQL(<T>EXEC spPOSImporteRefCalc :nSuc, :nImporteRef, :tCodigoFP,:tEmpresa<T>, Sucursal, Info.POSImporteRef, Info.CodigoFormaPago,Empresa))<BR><BR>Forma.Accion(<T>CalculaCambio<T>)
[FormasPago.Ver.FormasPago]
Carpeta=FormasPago
Clave=Ver.FormasPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=33
ColorFondo=$00C6FFFF
























































AccionAlEnter=
[Cobro.Info.POSImporteRef]
Carpeta=Cobro
Clave=Info.POSImporteRef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=N
Tamano=14




AccionAlEnter=CalculaImporteRef









ColorFuente=Rojo obscuro
ColorFondo=Blanco
[Cobro.Info.POSTipoCambioSuc]
Carpeta=Cobro
Clave=Info.POSTipoCambioSuc
ValidaNombre=S
3D=N
Tamano=14
ColorFondo=$00C08000









ColorFuente=Blanco
[Acciones.ActualizaRedondeo.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Expresion
Expresion=(Fin)




[Acciones.CalculaImporteRefPrevio]
Nombre=CalculaImporteRefPrevio
Boton=0
Multiple=S
Activo=S
Visible=S



ListaAccionesMultiples=(Lista)

[Acciones.CalculaImporteRefPrevio.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.CalculaImporteRefPrevio.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S









Expresion=Asigna(info.Ano,SQL(<T>SELECT dbo.fnPOSRedondeoMonetarios(:tEmpresa)<T>,Empresa))<BR>Asigna(Temp.Reg2,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta<T>,EstacionTrabajo, Nulo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo))<BR>Asigna(Info.Saldo, Temp.Reg2[9])<BR>Asigna(Ver.Saldo, Temp.Reg2[9])<BR>Asigna(Info.Importe, Temp.Reg2[9])<BR>Asigna(Info.POSImporteRef, Info.Saldo / SQL(<T>EXEC spPOSTipoCambioRefCalc :nSuc, :tCodigoFP, :tEmpresa<T>, Sucursal, Info.CodigoFormaPago,Empresa))<BR>Asigna(Temp.Reg3,SQL(<T>spPOSOfertasFormasPago :tID, :tEmpresa, :nSucursal, :tFormapago, 1<T>,Info.IDTexto,Empresa,Sucursal,Info.CodigoFormaPago))<BR>Asigna(Temp.Flotante,SQL(<T>spPOSVentaInsertaRedondeo :tID,:tTipo,:nImporte<T>,Info.IDTexto,<T>CONSULTAR COBRO<T>,Nulo))<BR>Asigna(Info.POSRedondeo,SQL(<T>spPOSVentaInsertaRedondeo :tID,:tTipo,:nImporte<T>,Info.IDTexto,<T>CONSULTAR<T>,Nulo))<BR><BR>Si<BR>  EsNumerico(Temp.Reg3[1])<BR>Entonces<BR>  Asigna(Info.PosImporteRef, Temp.Reg3[1])<BR>  Asigna(Info.PosImporteRef,Info.PosImporteRef+Temp.Flotante)<BR>Fin<BR><BR>Si<BR>  EsNumerico(Temp.Reg3[2])<BR>Entonces<BR>  Asigna(Temp.Reg5,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta<T>,EstacionTrabajo, Nulo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo))<BR>  Asigna(Info.Saldo, Temp.Reg5[9])<BR>  Asigna(Ver.Saldo, Temp.Reg5[9])<BR><BR>  Asigna(Info.Saldo,((Info.Saldo)-(Info.Saldo*(Temp.Reg3[2]/100))))<BR>  Si (SQL(<T>SELECT Mov FROM POSL WHERE ID=:ID<T>, Info.IDTexto) = <T>COBRO CREDITO<T>) Entonces Asigna(Info.Saldo,((Info.Saldo)-(Info.Saldo*(Temp.Reg3[3]/100)))) Fin<BR>  Asigna(Info.Saldo,Info.Saldo+Temp.Flotante)<BR>  Asigna(Info.POSImporteRef, Redondea(Info.Saldo / SQL(<T>EXEC spPOSTipoCambioRefCalc :nSuc, :tCodigoFP, :tEmpresa<T>, Sucursal, Info.CodigoFormaPago,Empresa),Info.Ano))<BR>  Asigna(Ver.Saldo,SQL(<T>SELECT dbo.fnFormatoMoneda(:nImporte,:tEmpresa)<T>,Info.Saldo,Empresa))<BR>  Asigna(Info.POSRedondeo,Temp.Flotante)<BR>Fin<BR><BR><BR>Si<BR>  (NO(EsNumerico(Temp.Reg3[2])))o(NO(EsNumerico(Temp.Reg3[1])))<BR>Entonces<BR>EjecutarSQL(<T>spPOSVentaInsertaRedondeo :tID,:tTipo,:nImporte<T>,Info.IDTexto,<T>ELIMINAR COBRO<T>,Nulo)<BR>Asigna(Temp.Reg4,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta<T>,EstacionTrabajo, Nulo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg4[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg4[5]))<BR>Asigna(Ver.Total, Temp.Reg4[8])<BR>Asigna(Info.Saldo, Temp.Reg4[9])<BR>Asigna(Info.Importe, Temp.Reg4[9])<BR>Asigna(Ver.Saldo, Temp.Reg4[9])<BR>Asigna(Info.POSImporteRef, Info.Saldo / SQL(<T>EXEC spPOSTipoCambioRefCalc :nSuc, :tCodigoFP, :tEmpresa<T>, Sucursal, Info.CodigoFormaPago,Empresa))<BR>Fin<BR><BR><BR>//Si(NO(EsNumerico(Temp.Reg3[2])),Asigna(Ver.Saldo,SQL(<T>SELECT dbo.fnFormatoMoneda(:nImporte,:tEmpresa)<T>,Temp.Reg3[1],Empresa)))<BR><BR>Asigna(Info.Moneda,SQL(<T>SELECT f.Moneda FROM FormaPago f JOIN CB c ON c.FormaPago=f.FormaPago  WHERE c.Codigo =:tCodigo<T>,Info.CodigoFormaPago))<BR>Asigna(Info.POSTipoCambioSuc, SQL(<T>SELECT TipoCambio FROM POSLTipoCambioRef WHERE Sucursal = :nSuc AND Moneda = :tMoneda<T>, Sucursal,Info.Moneda))<BR>//Asigna(Info.POSTipoCambioSuc,  Redondea( Info.POSTipoCambioSuc,Info.Ano))<BR>SI(Vacio(Info.POSTipoCambioSuc),Asigna(Info.POSTipoCambioSuc,1))<BR><BR>//Asigna(Info.FormaPagoCambio,Info.CodigoFormaPago)<BR>Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>Asigna(Info.Importe, SQL(<T>EXEC spPOSImporteRefCalc :nSuc, :nImporteRef, :tCodigoFP,:tEmpresa<T>, Sucursal, Info.POSImporteRef, Info.CodigoFormaPago,Empresa))<BR>//Asigna(Info.PosImporteRef,  Redondea( Info.PosImporteRef,Info.Ano)) Forma.Accion(<T>CalculaCambio<T>)
[VentaCobro]
Estilo=Ficha
Clave=VentaCobro
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=(Variables)
Fuente={Segoe UI, 14, Blanco, [Negritas]}
CampoColorLetras=Rojo obscuro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaColorFondo=$00804000
AlinearTodaCarpeta=S






PermiteEditar=S
CarpetaVisible=S
ConFuenteEspecial=S
[VentaCobro.Ver.Cobro]
Carpeta=VentaCobro
Clave=Ver.Cobro
Editar=N
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=46
ColorFuente=Rojo obscuro









ColorFondo=Blanco






[VentaCobro.Info.POSImporteOferta]
Carpeta=VentaCobro
Clave=Info.POSImporteOferta
Editar=S
LineaNueva=S
3D=S
Tamano=46


ValidaNombre=N
ColorFuente=Rojo obscuro





















ColorFondo=Blanco

[Acciones.Enter.ValidaReferencia]
Nombre=ValidaReferencia
Boton=0
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
EjecucionConError=S















Expresion=Si<BR>Info.CodigoFormaPago = <T>CERTIFICADO<T><BR>Entonces<BR>Forma.Accion(<T>TarjetaRegalo<T>)<BR>Si(ConDatos(Temp.Texto),ERROR(Temp.Texto))<BR>Si(ConDatos(Temp.Texto), Asigna(Info.POSImporteRef, 0))<BR>Sino<BR>nulo<BR>Fin<BR><BR>Si<BR>  SQL(<T>spPOSLDIMuestraFormaPago :tFormaPago, :nImporte<T>, Info.CodigoFormaPago, Info.POSImporteRef) = <T>Si<T><BR>Entonces<BR>  Forma(<T>POSLDISeleccioFormaPMeses<T>)<BR>Sino<BR>  <T><T><BR>Fin
EjecucionCondicion=Asigna(Temp.Logico,SQL(<T>SELECT dbo.fnPOSFPReferencia(:tCodigo,:tReferencia)<T>,Info.CodigoFormaPago,Info.Referencia))<BR>No(Temp.Logico)
EjecucionMensaje=<T>Es Necesario Asignar La Referencia<T>
[(Carpeta Abrir).Columnas]
0=173
1=90
2=58
3=416





[Cambio.Ver.Aviso]
Carpeta=Cambio
Clave=Ver.Aviso
Editar=S
LineaNueva=S
ValidaNombre=N
3D=N
Tamano=51
ColorFuente=$008080FF
EspacioPrevio=N

ColorFondo=$00FFFF80
[Detalle.Columnas]
Serie=146

















































































































[Acciones.F4.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (F4,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>  Temp.POSMonederoL=Verdadero<BR>Entonces<BR>  Si<BR>    Info.CodigoFormaPago = Temp.POSMonederoFP<BR>  Entonces<BR>    Forma(<T>SerieTarjetaMovRedimir<T>)<BR>    Asigna(Info.POSImporteRef, SQL(<T>SELECT Importe FROM SerieTarjetaMov WHERE ID=:tid<T>,Info.IDTexto))<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.F4.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S




















[Acciones.BancoA03.ListaAccionesMultiples]
(Inicio)=EXp
EXp=TDC
TDC=(Fin)






[Acciones.F2.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S



Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (F2,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>  Temp.POSMonederoL=Verdadero<BR>Entonces<BR>  Si<BR>    Info.CodigoFormaPago = Temp.POSMonederoFP<BR>  Entonces<BR>    Forma(<T>SerieTarjetaMovRedimir<T>)<BR>    Asigna(Info.POSImporteRef, SQL(<T>SELECT Importe FROM SerieTarjetaMov WHERE ID=:tid<T>,Info.IDTexto))<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR>                                      <BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.F2.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S




[Acciones.F3.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (F3,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>  Temp.POSMonederoL=Verdadero<BR>Entonces<BR>  Si<BR>    Info.CodigoFormaPago = Temp.POSMonederoFP<BR>  Entonces<BR>    Forma(<T>SerieTarjetaMovRedimir<T>)<BR>    Asigna(Info.POSImporteRef, SQL(<T>SELECT Importe FROM SerieTarjetaMov WHERE ID=:tid<T>,Info.IDTexto))<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.F3.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S


[Acciones.F5.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (F5,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>  Temp.POSMonederoL=Verdadero<BR>Entonces<BR>  Si<BR>    Info.CodigoFormaPago = Temp.POSMonederoFP<BR>  Entonces<BR>    Forma(<T>SerieTarjetaMovRedimir<T>)<BR>    Asigna(Info.POSImporteRef, SQL(<T>SELECT Importe FROM SerieTarjetaMov WHERE ID=:tid<T>,Info.IDTexto))<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Asigna(Info.POSImporteRef, Info.Saldo / SQL(<T>EXEC spPOSTipoCambioRefCalc :nSuc, :tCodigoFP, :tEmpresa<T>, Sucursal, Info.CodigoFormaPago,Empresa))                                                  <BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.F5.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S






[Acciones.F6.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (F6,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>  Temp.POSMonederoL=Verdadero<BR>Entonces<BR>  Si<BR>    Info.CodigoFormaPago = Temp.POSMonederoFP<BR>  Entonces<BR>    Forma(<T>SerieTarjetaMovRedimir<T>)<BR>    Asigna(Info.POSImporteRef, SQL(<T>SELECT Importe FROM SerieTarjetaMov WHERE ID=:tid<T>,Info.IDTexto))<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.F6.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S






[Acciones.F7.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (F7,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>  Temp.POSMonederoL=Verdadero<BR>Entonces<BR>  Si<BR>    Info.CodigoFormaPago = Temp.POSMonederoFP<BR>  Entonces<BR>    Forma(<T>SerieTarjetaMovRedimir<T>)<BR>    Asigna(Info.POSImporteRef, SQL(<T>SELECT Importe FROM SerieTarjetaMov WHERE ID=:tid<T>,Info.IDTexto))<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
Activo=S
Visible=S

[Acciones.F7.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S


[Acciones.F8.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (F8,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>  Temp.POSMonederoL=Verdadero<BR>Entonces<BR>  Si<BR>    Info.CodigoFormaPago = Temp.POSMonederoFP<BR>  Entonces<BR>    Forma(<T>SerieTarjetaMovRedimir<T>)<BR>    Asigna(Info.POSImporteRef, SQL(<T>SELECT Importe FROM SerieTarjetaMov WHERE ID=:tid<T>,Info.IDTexto))<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.F8.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S











[Acciones.Enter.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.Enter.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S



[Cobro.Ver.Saldo]
Carpeta=Cobro
Clave=Ver.Saldo
LineaNueva=S
ValidaNombre=S
3D=N
AccionAlEnter=CalculaCambio
Tamano=14
ColorFondo=$00C08000












ColorFuente=Blanco
EspacioPrevio=N
[Acciones.F5.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
[Acciones.F2.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
[Acciones.F3.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
[Acciones.F4.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S



Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
[Acciones.F6.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
[Acciones.F7.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
[Acciones.F8.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
[Acciones.CalculaCambio.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S




[VentaCobro.Info.Titulo]
Carpeta=VentaCobro
Clave=Info.Titulo
Editar=N
LineaNueva=S
ValidaNombre=N
3D=N
Tamano=46
ColorFondo=$00804000











ColorFuente=Blanco




Efectos=[Negritas]




[Acciones.CalculaImporteRefPrevio2]
Nombre=CalculaImporteRefPrevio2
Boton=0
NombreDesplegar=CalculaImporteRefPrevio2
Multiple=S
Activo=S
Visible=S




ListaAccionesMultiples=(Lista)



[Acciones.CalculaImporteRefPrevio2.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.CalculaImporteRefPrevio2.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S


















Expresion=Asigna(Info.Ano,SQL(<T>SELECT dbo.fnPOSRedondeoMonetarios(:tEmpresa)<T>,Empresa))<BR>Asigna(Temp.Reg2,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta<T>,EstacionTrabajo, Nulo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo))<BR>Asigna(Info.Saldo, Temp.Reg2[9])<BR>Asigna(Ver.Saldo, Temp.Reg2[9])<BR>Asigna(Info.Importe, Temp.Reg2[9])<BR>Asigna(Info.POSImporteRef, Info.Saldo / SQL(<T>EXEC spPOSTipoCambioRefCalc :nSuc, :tCodigoFP, :tEmpresa<T>, Sucursal, Info.CodigoFormaPago,Empresa))<BR>Asigna(Temp.Reg3,SQL(<T>spPOSOfertasFormasPago :tID, :tEmpresa, :nSucursal, :tFormapago, 1<T>,Info.IDTexto,Empresa,Sucursal,Info.CodigoFormaPago))<BR>Asigna(Temp.Flotante,SQL(<T>spPOSVentaInsertaRedondeo :tID,:tTipo,:nImporte<T>,Info.IDTexto,<T>CONSULTAR COBRO<T>,Nulo))<BR>//Asigna(Info.POSRedondeo,SQL(<T>spPOSVentaInsertaRedondeo :tID,:tTipo,:nImporte<T>,Info.IDTexto,<T>CONSULTAR<T>,Nulo))<BR><BR>Si<BR>  EsNumerico(Temp.Reg3[1])<BR>Entonces<BR>  Asigna(Info.PosImporteRef, Temp.Reg3[1])<BR>  Asigna(Info.PosImporteRef,Info.PosImporteRef+Temp.Flotante)<BR>Fin<BR><BR>Si<BR>  EsNumerico(Temp.Reg3[2])<BR>Entonces<BR>  Asigna(Temp.Reg5,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta<T>,EstacionTrabajo, Nulo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo))<BR>  Asigna(Info.Saldo, Temp.Reg5[9])<BR>  Asigna(Ver.Saldo, Temp.Reg5[9])<BR><BR>  Asigna(Info.Saldo,((Info.Saldo)-(Info.Saldo*(Temp.Reg3[2]/100))))<BR>  Si<BR>    EsNumerico(Temp.Reg3[3])<BR>  Entonces<BR>    Asigna(Info.Saldo,((Info.Saldo)-(Info.Saldo*(Temp.Reg3[3]/100))))<BR>  Fin<BR>  Asigna(Info.Saldo,Info.Saldo+Temp.Flotante)<BR>  Asigna(Info.POSImporteRef, Redondea(Info.Saldo / SQL(<T>EXEC spPOSTipoCambioRefCalc :nSuc, :tCodigoFP, :tEmpresa<T>, Sucursal, Info.CodigoFormaPago,Empresa),Info.Ano))<BR>  Asigna(Ver.Saldo,SQL(<T>SELECT dbo.fnFormatoMoneda(:nImporte,:tEmpresa)<T>,Info.Saldo,Empresa))<BR>  //Asigna(Info.POSRedondeo,Temp.Flotante)<BR><BR>Fin<BR><BR><BR>Si<BR>  (NO(EsNumerico(Temp.Reg3[2])))o(NO(EsNumerico(Temp.Reg3[1])))<BR>Entonces<BR>EjecutarSQL(<T>spPOSVentaInsertaRedondeo :tID,:tTipo,:nImporte<T>,Info.IDTexto,<T>ELIMINAR COBRO<T>,Nulo)<BR>Asigna(Temp.Reg4,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta<T>,EstacionTrabajo, Nulo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg4[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg4[5]))<BR>Asigna(Ver.Total, Temp.Reg4[8])<BR>Asigna(Info.Saldo, Temp.Reg4[9])<BR>Asigna(Info.Importe, Temp.Reg4[9])<BR>Asigna(Ver.Saldo, Temp.Reg4[9])<BR>Asigna(Info.POSImporteRef, Info.Saldo / SQL(<T>EXEC spPOSTipoCambioRefCalc :nSuc, :tCodigoFP, :tEmpresa<T>, Sucursal, Info.CodigoFormaPago,Empresa))<BR>Fin<BR><BR><BR>//Si(NO(EsNumerico(Temp.Reg3[2])),Asigna(Ver.Saldo,SQL(<T>SELECT dbo.fnFormatoMoneda(:nImporte,:tEmpresa)<T>,Temp.Reg3[1],Empresa)))<BR><BR>Asigna(Info.Moneda,SQL(<T>SELECT f.Moneda FROM FormaPago f JOIN CB c ON c.FormaPago=f.FormaPago  WHERE c.Codigo =:tCodigo<T>,Info.CodigoFormaPago))<BR>Asigna(Info.POSTipoCambioSuc, SQL(<T>SELECT TipoCambio FROM POSLTipoCambioRef WHERE Sucursal = :nSuc AND Moneda = :tMoneda<T>, Sucursal,Info.Moneda))<BR>//Asigna(Info.POSTipoCambioSuc,  Redondea( Info.POSTipoCambioSuc,Info.Ano))<BR>SI(Vacio(Info.POSTipoCambioSuc),Asigna(Info.POSTipoCambioSuc,1))<BR><BR>//Asigna(Info.FormaPagoCambio,Info.CodigoFormaPago)<BR>Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>Asigna(Info.Importe, SQL(<T>EXEC spPOSImporteRefCalc :nSuc, :nImporteRef, :tCodigoFP,:tEmpresa<T>, Sucursal, Info.POSImporteRef, Info.CodigoFormaPago,Empresa))<BR>Forma.Accion(<T>CalculaCambio<T>)<BR>//Asigna(Info.PosImporteRef,  Redondea( Info.PosImporteRef,Info.Ano)) Forma.Accion(<T>CalculaCambio<T>)
[Acciones.Regresar.expresion]
Nombre=expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=EjecutarSQL(<T>spPOSVentaInsertaRedondeo :tID,:tTipo,:nImporte<T>,Info.IDTexto,<T>ELIMINAR<T>,Nulo)<BR>Asigna(Info.Importe, nulo)<BR>Asigna(Info.POSRedondeo, nulo)
[Acciones.Regresar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S


[Acciones.BancoB01.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB01,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancoB01.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
[Acciones.BancoB01.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S










[Acciones.BancoA01.expresion]
Nombre=expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA01,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>  Temp.POSMonederoL=Verdadero<BR>Entonces<BR>  Si<BR>    Info.CodigoFormaPago = Temp.POSMonederoFP<BR>  Entonces<BR>    Forma(<T>SerieTarjetaMovRedimir<T>)<BR>    Asigna(Info.POSImporteRef, SQL(<T>SELECT Importe FROM SerieTarjetaMov WHERE ID=:tid<T>,Info.IDTexto))<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR>                                      <BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancoA01.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
Activo=S
Visible=S

[Acciones.BancoA01.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S






[Cobro.Info.Importe2]
Carpeta=Cobro
Clave=Info.Importe2
Editar=S
EditarConBloqueo=S
3D=N
AccionAlEnter=Enter
Pegado=N
Tamano=-1
ColorFondo=$00C08000





ColorFuente=Blanco
[Acciones.F2w.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=ActualizaForma
ActualizaForma=(Fin)














[Forma.MenuPrincipalTeclaFuncion]
(Inicio)=F1
F1=F2
F2=F3
F3=F4
F4=(Fin)


























[Acciones.Regresar.ListaAccionesMultiples]
(Inicio)=expresion
expresion=Cerrar
Cerrar=(Fin)







[Acciones.CalculaCambio.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Expresion
Expresion=Actualizar Forma
Actualizar Forma=(Fin)






[Acciones.F6.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=Actualizar Forma
Actualizar Forma=(Fin)




[Acciones.F7.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=Actualizar Forma
Actualizar Forma=(Fin)
































[Acciones.F4.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=Actualizar Forma
Actualizar Forma=(Fin)








[Acciones.F5.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=Actualizar Forma
Actualizar Forma=(Fin)








[Acciones.F2.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=ActualizaForma
ActualizaForma=(Fin)












[Acciones.F3.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=Actualizar Forma
Actualizar Forma=(Fin)














[Acciones.TarjetaRegalo]
Nombre=TarjetaRegalo
Boton=0
NombreDesplegar=Tarjeta Regalo
TipoAccion=Formas
ClaveAccion=POSTarjetaRegalo
Activo=S
Visible=S





ConCondicion=S


EjecucionCondicion=Info.CodigoFormaPago = <T>CERTIFICADO<T>
[Acciones.ValidaTarjetaRegalo]
Nombre=ValidaTarjetaRegalo
Boton=0
NombreDesplegar=ValidaTarjetaRegalo
TipoAccion=Expresion
Activo=S
Visible=S








Expresion=Si<BR>  Info.CodigoFormaPago = <T>CERTIFICADO<T><BR>Entonces<BR>  Asigna(Temp.Texto,SQL(<T>spPOSAsociarTarjetaRegalo  :tID, :tMonedero,:tUsuario, :nEstacion, :nImporte<T>,Info.IDTexto,Info.POSMonedero,Usuario,EstacionTrabajo, Info.POSImporteRef))<BR><BR>  Si(ConDatos(Temp.Texto),ERROR(Temp.Texto))<BR>  Si(ConDatos(Temp.Texto), Asigna(Info.POSImporteRef, 0))<BR>Sino<BR>  <T><T><BR>Fin
[Acciones.CalculaImporteRef.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Expresion
Expresion=(Fin)





















[Acciones.CalculaImporteRefPrevio.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Expresion
Expresion=(Fin)










[Acciones.BancoB01.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=Actualizar Forma
Actualizar Forma=(Fin)











[Acciones.BancoB02.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
Activo=S
Visible=S

[Acciones.BancoB02.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.BancoB02.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=Actualizar Forma
Actualizar Forma=(Fin)




[Acciones.BancoB03.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB03,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
Activo=S
Visible=S

[Acciones.BancoB03.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
Activo=S
Visible=S

[Acciones.BancoB03.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.BancoB03.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=Actualizar Forma
Actualizar Forma=(Fin)




[Acciones.BancoB04.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB04,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
Activo=S
Visible=S

[Acciones.BancoB04.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
Activo=S
Visible=S

[Acciones.BancoB04.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.BancoB04.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=Actualizar Forma
Actualizar Forma=(Fin)




[Acciones.BancoB05.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB05,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
Activo=S
Visible=S

[Acciones.BancoB05.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
Activo=S
Visible=S

[Acciones.BancoB05.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S





[Acciones.BancoB05.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=Actualizar Forma
Actualizar Forma=(Fin)




[Acciones.BancoB06.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB06,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
Activo=S
Visible=S

[Acciones.BancoB06.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
Activo=S
Visible=S

[Acciones.BancoB06.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.BancoB06.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=Actualizar Forma
Actualizar Forma=(Fin)




[Acciones.BancoB07.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB07,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
Activo=S
Visible=S

[Acciones.BancoB07.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
Activo=S
Visible=S

[Acciones.BancoB07.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.BancoB07.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=Actualizar Forma
Actualizar Forma=(Fin)




[Acciones.BancoB08.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB08,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
Activo=S
Visible=S

[Acciones.BancoB08.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
Activo=S
Visible=S

[Acciones.BancoB08.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.BancoB08.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=Actualizar Forma
Actualizar Forma=(Fin)








[Acciones.Regresa]
Nombre=Regresa
Boton=0
NombreEnBoton=S
TeclaFuncion=ESC
NombreDesplegar=<T>Regresar<T>
Multiple=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=Esc.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

[Acciones.Regresa.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

NombreDesplegar=Expresion
Expresion=EjecutarSQL(<T>spPOSVentaInsertaRedondeo :tID,:tTipo,:nImporte<T>,Info.IDTexto,<T>ELIMINAR<T>,Nulo)<BR>Asigna(Info.Importe, nulo)<BR>Asigna(Info.POSRedondeo, nulo)
[Acciones.Regresa.Cerrar]
Nombre=Cerrar
Boton=0
NombreDesplegar=Cerrar
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S











[Acciones.Separador1]
Nombre=Separador1
Boton=0
NombreDesplegar=<T>Separador1<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=1






[Acciones.MenuPrincipal]
Nombre=MenuPrincipal
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Principal<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F1.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TeclaFuncion=F1
Expresion=BarraIrPagina(<T>Cambio<T>,2)
[Acciones.MenuEspecial]
Nombre=MenuEspecial
Boton=0
NombreEnBoton=S
TeclaFuncion=F2
NombreDesplegar=<T>Especial<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F2.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

Expresion=BarraIrPagina(<T>Cambio<T>,3)
[Acciones.MenuBancos]
Nombre=MenuBancos
Boton=0
NombreEnBoton=S
TeclaFuncion=F3
NombreDesplegar=<T>Bancos<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F3.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado






Expresion=BarraIrPagina(<T>Cambio<T>,4)
[Acciones.MenuVales]
Nombre=MenuVales
Boton=0
NombreEnBoton=S
TeclaFuncion=F4
NombreDesplegar=<T>Vales<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F4.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado


Expresion=BarraIrPagina(<T>Cambio<T>,5)
[Acciones.FormaPago2]
Nombre=FormaPago2
Boton=0
NombreEnBoton=S
TeclaFuncion=F5
NombreDesplegar=Info.POSFormaPago2
Multiple=S
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F5.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado
















ListaAccionesMultiples=(Lista)
[Acciones.FormaPago3]
Nombre=FormaPago3
Boton=0
NombreEnBoton=S
TeclaFuncion=F6
NombreDesplegar=Info.POSFormaPago3
Multiple=S
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F6.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado











ListaAccionesMultiples=(Lista)
[Acciones.FormaPago4]
Nombre=FormaPago4
Boton=0
NombreEnBoton=S
NombreDesplegar=Info.POSFormaPago4
Multiple=S
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F7.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TeclaFuncion=F7
ListaAccionesMultiples=(Lista)
[Acciones.FormaPago5]
Nombre=FormaPago5
Boton=0
NombreEnBoton=S
TeclaFuncion=F8
NombreDesplegar=Info.POSFormaPago5
Multiple=S
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F8.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

ListaAccionesMultiples=(Lista)
[Acciones.Separador3]
Nombre=Separador3
Boton=0
NombreDesplegar=<T>Separador3<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=1

[Acciones.FormaPago6]
Nombre=FormaPago6
Boton=0
NombreEnBoton=S
TeclaFuncion=F9
NombreDesplegar=Info.POSFormaPago6
Multiple=S
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F9.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado






ListaAccionesMultiples=(Lista)
[Acciones.FormaPago7]
Nombre=FormaPago7
Boton=0
NombreEnBoton=S
TeclaFuncion=F10
NombreDesplegar=Info.POSFormaPago7
Multiple=S
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F10.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado






ListaAccionesMultiples=(Lista)
[Acciones.FormaPago8]
Nombre=FormaPago8
Boton=0
NombreEnBoton=S
TeclaFuncion=F11
NombreDesplegar=Info.POSFormaPago8
Multiple=S
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F11.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado






ListaAccionesMultiples=(Lista)
[Acciones.Cobra]
Nombre=Cobra
Boton=0
NombreEnBoton=S
TeclaFuncion=F12
NombreDesplegar=<T>Cobrar<T>
Multiple=S
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F12.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado






ListaAccionesMultiples=(Lista)
Antes=S
AntesExpresiones=Asigna(Info.Cantidad2,0)
[Acciones.RegresarP1]
Nombre=RegresarP1
Boton=0
NombreEnBoton=S
TeclaFuncion=ESC
NombreDesplegar=<T>Regresar<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=Esc.png
BarraBtnPagina=2
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado











Expresion=BarraIrPagina(<T>Cambio<T>,1)
[Acciones.Separador1P1]
Nombre=Separador1P1
Boton=0
NombreDesplegar=<T>Separador1P1<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=2

[Acciones.CancelaPartida]
Nombre=CancelaPartida
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Cancelar<BR>Partida<T>
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F1.png
BarraBtnPagina=2
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado











TeclaFuncion=F1
TipoAccion=Expresion
Expresion=Asigna(Temp.Reg5,SQL(<T>spPOSCancelarPartidaCobro :nEstacion, :tID<T>,EstacionTrabajo,Info.IDTexto))<BR>Asigna(Ver.Cobro, TextoEnLista(SQL(<T>EXEC spPOSMuestraVentaCobro :tID<T>, Info.IDTexto)))<BR>Asigna(Temp.Reg4,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta<T>,EstacionTrabajo, Nulo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg4[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg4[5]))<BR>Asigna(Ver.Total, Temp.Reg4[8])<BR>Asigna(Info.Saldo, Temp.Reg4[9])<BR>Asigna(Info.Importe, Temp.Reg4[9])<BR>Asigna(Ver.Saldo, Temp.Reg4[9])<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg5[2]))<BR>//EjecutarSQL(<T>spPOSVentaInsertaRedondeo :tID,:tTipo,:nImporte<T>,Info.IDTexto,<T>ELIMINAR<T>,Nulo)
[Acciones.AltaMonedero]
Nombre=AltaMonedero
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Alta<BR>Monedero<T>
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F2.png
BarraBtnPagina=2
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TeclaFuncion=F2





TipoAccion=Expresion
Expresion=Si<BR>  SQL(<T>SELECT POSMonedero FROM POSCfg WHERE Empresa = :tEmpresa<T>,Empresa)=0<BR>Entonces<BR>  FormaModal(<T>POSMonedero<T>)<BR>  Forma.Accion(<T>CalculaImporteRefPrevio<T>)<BR>Sino<BR>  Informacion(<T>Opci�n no disponible<T>)<BR>Fin
[Acciones.Redondea]
Nombre=Redondea
Boton=0
NombreEnBoton=S
TeclaFuncion=F3
NombreDesplegar=<T>Redondeo<T>
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F3.png
BarraBtnPagina=2
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado











TipoAccion=Expresion
Expresion=EjecutarSQL(<T>spPOSVentaInsertaRedondeo :tID,:tTipo,:nImporte<T>,Info.IDTexto,<T>ELIMINAR COBRO<T>,Nulo))<BR>FormaModal(<T>POSRedondeoCobro<T>)<BR>/* Aqui se ejecuta el SPPOS para cobrar */<BR>  Asigna(Temp.Reg5, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tFormaCambio, :nCambio, :nCobro, :nLecturaTarjeta, :tCliente, :tMonedero,:nImporteRef<T>, EstacionTrabajo, Nulo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto, Nulo, Info.FormaPagoCambio, Info.Cambio, 0, Nulo, Nulo, Info.POSMonedero,Nulo))<BR><BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg5[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg5[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg5[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg5[6]))<BR>  Asigna(Ver.Total, Temp.Reg5[8])<BR>  Asigna(Info.Saldo, Temp.Reg5[9])<BR>  Asigna(Info.Importe, Temp.Reg5[9])<BR>  Asigna(Ver.Saldo, Temp.Reg5[9])<BR>  Asigna(Ver.Imagen,Temp.Reg5[11])<BR>Asigna(Temp.Flotante,SQL(<T>spPOSVentaInsertaRedondeo :tID,:tTipo,:nImporte<T>,Info.IDTexto,<T>CONSULTAR<T>,Nulo))<BR>Forma.Accion(<T>CalculaImporteRefPrevio<T>)
ConCondicion=S
EjecucionCondicion=EsNumerico(Temp.Reg3[2]) y Info.Acumulativas
[Acciones.RegresarP2]
Nombre=RegresarP2
Boton=0
NombreEnBoton=S
TeclaFuncion=ESC
NombreDesplegar=<T>Regresar<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=Esc.png
BarraBtnPagina=3
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

Expresion=BarraIrPagina(<T>Cambio<T>,1)
[Acciones.Separador1P2]
Nombre=Separador1P2
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Separador<T>
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=Esc.png
BarraBtnPagina=3
EsSeparador=S
















[Acciones.Separador2P2]
Nombre=Separador2P2
Boton=0
NombreDesplegar=<T>Separador2P2<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=3









[Acciones.BancoA01.ListaAccionesMultiples]
(Inicio)=expresion
expresion=Recalcula
Recalcula=Actualizar Forma
Actualizar Forma=(Fin)




[Acciones.BancosA01]
Nombre=BancosA01
Boton=0
NombreEnBoton=S
TeclaFuncion=F1
NombreDesplegar=Info.BancoA01
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F1.png
BarraBtnPagina=3
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado






Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.BancosA02]
Nombre=BancosA02
Boton=0
NombreEnBoton=S
TeclaFuncion=F2
NombreDesplegar=Info.BancoA02
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F2.png
BarraBtnPagina=3
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA02,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancosA03]
Nombre=BancosA03
Boton=0
NombreEnBoton=S
TeclaFuncion=F3
NombreDesplegar=Info.BancoA03
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F3.png
BarraBtnPagina=3
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA03,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancosA04]
Nombre=BancosA04
Boton=0
NombreEnBoton=S
TeclaFuncion=F4
NombreDesplegar=Info.BancoA04
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F4.png
BarraBtnPagina=3
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA04,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancosA05]
Nombre=BancosA05
Boton=0
NombreEnBoton=S
TeclaFuncion=F5
NombreDesplegar=Info.BancoA05
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F5.png
BarraBtnPagina=3
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA05,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancosA06]
Nombre=BancosA06
Boton=0
NombreEnBoton=S
TeclaFuncion=F6
NombreDesplegar=Info.BancoA06
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F6.png
BarraBtnPagina=3
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA06,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancosA07]
Nombre=BancosA07
Boton=0
NombreEnBoton=S
TeclaFuncion=F7
NombreDesplegar=Info.BancoA07
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F7.png
BarraBtnPagina=3
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA07,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancosA08]
Nombre=BancosA08
Boton=0
NombreEnBoton=S
TeclaFuncion=F8
NombreDesplegar=Info.BancoA08
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F8.png
BarraBtnPagina=3
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA08,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancosB01]
Nombre=BancosB01
Boton=0
NombreDesplegar=Info.BancoB01
Activo=S
Visible=S
BarraBtnFondo=$00C08000
NombreEnBoton=S
TeclaFuncion=F1
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F1.png
BarraBtnPagina=4
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.RegresarP3]
Nombre=RegresarP3
Boton=0
NombreEnBoton=S
TeclaFuncion=ESC
NombreDesplegar=<T>Regresar<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=Esc.png
BarraBtnPagina=4
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado
















Expresion=BarraIrPagina(<T>Cambio<T>,1)
[Acciones.Separador1P3]
Nombre=Separador1P3
Boton=0
NombreDesplegar=<T>Separador1P3<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=4











[Acciones.BancosB02]
Nombre=BancosB02
Boton=0
NombreEnBoton=S
TeclaFuncion=F2
NombreDesplegar=Info.BancoB02
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F2.png
BarraBtnPagina=4
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.BancosB03]
Nombre=BancosB03
Boton=0
NombreEnBoton=S
TeclaFuncion=F3
NombreDesplegar=Info.BancoB03
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F3.png
BarraBtnPagina=4
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.BancosB04]
Nombre=BancosB04
Boton=0
NombreEnBoton=S
TeclaFuncion=F4
NombreDesplegar=Info.BancoB04
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F4.png
BarraBtnPagina=4
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.Separador2P3]
Nombre=Separador2P3
Boton=0
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=4

[Acciones.BancosB05]
Nombre=BancosB05
Boton=0
NombreEnBoton=S
TeclaFuncion=F5
NombreDesplegar=Info.BancoB05
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F5.png
BarraBtnPagina=4
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado






Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.BancosB06]
Nombre=BancosB06
Boton=0
NombreEnBoton=S
TeclaFuncion=F6
NombreDesplegar=Info.BancoB06
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F6.png
BarraBtnPagina=4
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.BancosB07]
Nombre=BancosB07
Boton=0
NombreEnBoton=S
TeclaFuncion=F7
NombreDesplegar=Info.BancoB07
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F7.png
BarraBtnPagina=4
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.BancosB08]
Nombre=BancosB08
Boton=0
NombreEnBoton=S
TeclaFuncion=F8
NombreDesplegar=Info.BancoB08
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F8.png
BarraBtnPagina=4
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado










Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.RegresarP4]
Nombre=RegresarP4
Boton=0
NombreEnBoton=S
TeclaFuncion=ESC
NombreDesplegar=<T>RegresarP4<T>
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=Esc.png
BarraBtnPagina=5
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado
TipoAccion=Expresion






Expresion=BarraIrPagina(<T>Cambio<T>,1)
[Acciones.BancosC01]
Nombre=BancosC01
Boton=0
NombreEnBoton=S
TeclaFuncion=F1
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F1.png
BarraBtnPagina=5
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado
NombreDesplegar=Info.BancoC01

TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC01,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancosC02]
Nombre=BancosC02
Boton=0
NombreEnBoton=S
TeclaFuncion=F2
NombreDesplegar=Info.BancoC02
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F2.png
BarraBtnPagina=5
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC02,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancosC03]
Nombre=BancosC03
Boton=0
NombreEnBoton=S
TeclaFuncion=F3
NombreDesplegar=Info.BancoC03
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F3.png
BarraBtnPagina=5
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC03,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancosC04]
Nombre=BancosC04
Boton=0
NombreEnBoton=S
TeclaFuncion=F4
NombreDesplegar=Info.BancoC04
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F4.png
BarraBtnPagina=5
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC04,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.Separador1P4]
Nombre=Separador1P4
Boton=0
NombreDesplegar=<T>Separador1P4<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=1

[Acciones.Separador2P4]
Nombre=Separador2P4
Boton=0
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=5

[Acciones.BancosC05]
Nombre=BancosC05
Boton=0
NombreEnBoton=S
TeclaFuncion=F5
NombreDesplegar=Info.BancoC05
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F5.png
BarraBtnPagina=5
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado






TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC05,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancosC06]
Nombre=BancosC06
Boton=0
NombreEnBoton=S
TeclaFuncion=F6
NombreDesplegar=Info.BancoC06
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F6.png
BarraBtnPagina=5
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC06,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancosC07]
Nombre=BancosC07
Boton=0
NombreEnBoton=S
TeclaFuncion=F7
NombreDesplegar=Info.BancoC07
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F7.png
BarraBtnPagina=5
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC07,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancosC08]
Nombre=BancosC08
Boton=0
NombreEnBoton=S
TeclaFuncion=F8
NombreDesplegar=Info.BancoC08
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F8.png
BarraBtnPagina=5
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado






TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC08,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Cobro.ListaEnCaptura]
(Inicio)=Info.POSTipoCambioSuc
Info.POSTipoCambioSuc=Info.POSRedondeo
Info.POSRedondeo=Info.CodigoFormaPago
Info.CodigoFormaPago=Info.POSImporteRef
Info.POSImporteRef=Ver.Saldo
Ver.Saldo=Info.FormaPagoCambio
Info.FormaPagoCambio=Info.Referencia
Info.Referencia=Info.Importe2
Info.Importe2=(Fin)

[Acciones.Regresa.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Cerrar
Cerrar=(Fin)



[VentaCobro.ListaEnCaptura]
(Inicio)=Ver.Cobro
Ver.Cobro=Info.POSImporteOferta
Info.POSImporteOferta=Info.Titulo
Info.Titulo=(Fin)

























[Acciones.Cobra.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Cobra.ValidarReferencia]
Nombre=ValidarReferencia
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Si<BR>Info.CodigoFormaPago = <T>CERTIFICADO<T><BR>Entonces<BR>Forma.Accion(<T>TarjetaRegalo<T>)<BR>Si(ConDatos(Temp.Texto),ERROR(Temp.Texto))<BR>Si(ConDatos(Temp.Texto), Asigna(Info.POSImporteRef, 0))<BR>Sino<BR>nulo<BR>Fin<BR><BR>Si<BR>  SQL(<T>spPOSLDIMuestraFormaPago :tFormaPago, :nImporte<T>, Info.CodigoFormaPago, Info.POSImporteRef) = <T>Si<T><BR>Entonces<BR>  Forma(<T>POSLDISeleccioFormaPMeses<T>)<BR>Sino<BR>  <T><T><BR>Fin
ConCondicion=S
EjecucionCondicion=Asigna(Temp.Logico,SQL(<T>SELECT dbo.fnPOSFPReferencia(:tCodigo,:tReferencia)<T>,Info.CodigoFormaPago,Info.Referencia))<BR>No(Temp.Logico)
EjecucionMensaje=<T>Es necesario asignar la referencia<T> 
EjecucionConError=S

[Acciones.Cobra.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=forma.Accion(<T>CalculaCambio<T>)<BR>forma.Accion(<T>CalculaImporteRef<T>)<BR>Asigna(Info.POSLDIError, Nulo)<BR>Asigna(Info.FormaExtra, Nulo)<BR>Asigna(Info.POSMonedero,nulo)<BR>Asigna(Info.VFAFormaPago, SQL(<T>EXEC spPOSVFAFormaPago :tCodigo, :tID<T>, Info.CodigoFormaPago, Info.IDTexto))<BR><BR>Si<BR>  Info.MonederoCB<BR>Entonces<BR>  Asigna(Info.FormaExtra, SQL(<T>EXEC spPOSMonederoFormaAnexa :tCodigo, :tID, :tEmpresa<T>, Info.CodigoFormaPago, Info.IDTexto, Empresa))<BR>  Asigna(Info.VFAFormaPago,nulo)<BR>Sino<BR>  Asigna(Info.FormaExtra, SQL(<T>EXEC spPOSLDIFormaPagoFormaAnexa :tCodigo, :tID, :tEmpresa<T>, Info.CodigoFormaPago, Info.IDTexto, Empresa))<BR>Fin<BR><BR>Si<BR>  SQL(<T>SELECT POSMonedero FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa)=0<BR>Entonces<BR>  Si<BR>    Info.FormaExtra <> Nulo   y    vacio(Info.POSMonedero)<BR>  Entonces<BR>    FormaModal(Info.FormaExtra)<BR>   Fin<BR>Fin<BR><BR>Si<BR>  ConDatos(Info.VFAFormaPago)<BR>Entonces<BR>  VFA.Cargo(<T>POS<T>, Info.IDTexto,<T>2048<T>,Info.Referencia,Info.Importe)<BR>  Asigna(Temp.Reg2, SQL(<T>spPOSVFAVerificar :tID<T>,Info.IDTexto))<BR>  Asigna(Info.POSVFAError,Temp.Reg2[1])<BR>  Asigna(Info.POSVFAMensajeError,Temp.Reg2[2])<BR>  Asigna(Info.Importe,Temp.Reg2[3])<BR>Fin<BR><BR>Si<BR>  ConDatos(Info.POSVFAError)<BR>Entonces<BR>  Error(Info.POSVFAMensajeError)<BR>  Asigna(Info.Codigo,Nulo)<BR>Fin<BR><BR>Si<BR>  Info.MonederoCB y ConDatos(Info.POSMonedero)<BR>Entonces<BR>  Asigna(Info.POSMensajeError,nulo)<BR>  Asigna(Info.POSMensajeError,SQL(<T>EXEC spPOSMonederoRedimir :tEmpresa, :tMonedero, :nImporte, :tUsuario, :nEstacion, :nSucursal, :tID<T>, Empresa, Info.POSMonedero, Info.POSImporteRef, Usuario, EstacionTrabajo, Sucursal, Info.IDTexto ))<BR>  Asigna(Info.POSMonedero,nulo)<BR>  Si<BR>    ConDatos(Info.POSMensajeError)<BR>  Entonces<BR>    Asigna(Info.POSImporteRef,0)<BR>    Asigna(Info.Importe,0)<BR>    ERROR(Info.POSMensajeError)<BR>  Sino<BR>    Informacion(<T>CARGO REALIZADO CON �XITO<T>)<BR>  Fin<BR>Fin<BR><BR><BR><BR>Asigna(Info.FormaExtra, Nulo)<BR>Asigna(Info.Codigo, Info.CodigoFormaPago)<BR>Asigna(Info.CodigoFormaPago, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR><BR>Si<BR>  Info.POSLDIError <> Nulo<BR>Entonces<BR>  Asigna(Info.Codigo, Nulo)<BR>Fin<BR><BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tFormaCambio, :nCambio, :nCobro, :nLecturaTarjeta, :tCliente, :tMonedero<T>, EstacionTrabajo, Nulo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto, 0, Nulo,Nulo, 0, Nulo, Nulo, Info.POSMonedero))<BR>Asigna(Info.FormaExtra,Temp.Reg[13])<BR>Asigna(Info.Servicio,Temp.Reg[12])<BR><BR>Si (Info.FormaExtra <> Nulo)  y (Info.Servicio <> Nulo)<BR>Entonces<BR>  FormaModal(Info.FormaExtra)<BR>Fin<BR><BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tFormaCambio, :nCambio, :nCobro, :nLecturaTarjeta, :tCliente, :tMonedero,:nImporteRef<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto, Info.Importe, Info.FormaPagoCambio, Info.Cambio, 1, Nulo, Nulo, Info.POSMonedero, Info.POSImporteRef))<BR><BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Si<BR>  Info.Saldo = 0<BR>Entonces<BR>  Asigna(Info.POSImporteOferta,Nulo)<BR>Fin<BR><BR>Asigna(Ver.Cobro, TextoEnLista(SQL(<T>EXEC spPOSMuestraVentaCobro :tID<T>, Info.IDTexto)))<BR>Asigna(Info.TorretaMensaje1,<T>IMPORTE  <T>+SQL(<T>SELECT dbo.fnFormatoMoneda(:nImporte,:tEmpresa)<T>,Info.Importe2,Empresa))<BR>Asigna(Info.TorretaPosicion1,<T>Derecha<T>)<BR>Asigna(Info.TorretaMensaje2,<T>SALDO  <T>+SQL(<T>SELECT dbo.fnFormatoMoneda(:nImporte,:tEmpresa)<T>,Info.Saldo,Empresa))<BR>Asigna(Info.TorretaPosicion2,<T>Derecha  <T>)<BR>Si<BR>  Info.Torreta<BR>Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>Fin<BR><BR>Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Info.Mensaje,Nulo)<BR>Asigna(Info.POSMonedero, Nulo)<BR>Asigna(Info.Referencia, Nulo)<BR>Asigna(Info.POSImporteRef, Nulo)<BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR>Si<BR>  Info.Cambio noen(0, <T>$0.00<T>)<BR>Entonces<BR>  Asigna(Info.Mensaje,<T>Cambio: <T> & Ver.Cambio)<BR>Fin
Activo=S
ConCondicion=S
EjecucionCondicion=(Info.Cambio en(0, <T>$0.00<T>))<BR>o (ConDatos(Info.FormaPagoCambio) y (Info.Importe = 0)y (Info.Saldo = 0))<BR>o (ConDatos(Info.FormaPagoCambio) y (Info.Importe > 0)y (Info.Saldo > 0))
Visible=S

[Acciones.Cobra.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=controles Captura
Activo=S
Visible=S
ClaveAccion=Actualizar Vista

[Acciones.Cobra.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.Cobra.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
ConCondicion=S
EjecucionCondicion=Info.Saldo <= 0
Visible=S

[Acciones.Cobra.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=ValidarReferencia
ValidarReferencia=Expresion
Expresion=Actualizar Vista
Actualizar Vista=Actualizar Forma
Actualizar Forma=Cerrar
Cerrar=(Fin)



[Acciones.Enter.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=ValidaReferencia
ValidaReferencia=Expresion
Expresion=Actualizar Vista
Actualizar Vista=Actualizar Forma
Actualizar Forma=Cerrar
Cerrar=(Fin)









[Acciones.F8.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualizar Forma
Actualizar Forma=Recalcula
Recalcula=(Fin)










[Acciones.BancosA01.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA01,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancosA01.Recalcular]
Nombre=Recalcular
Boton=0
TipoAccion=Expresion
Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
Activo=S
Visible=S

[Acciones.BancosA01.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S


[Acciones.BancosB01.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB01,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin






[Acciones.BancosB01.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
Activo=S
Visible=S

[Acciones.BancosB01.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.BancosB01.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=Actualizar Forma
Actualizar Forma=(Fin)






[Acciones.BancosB02.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB02,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancosB02.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
Activo=S
Visible=S

[Acciones.BancosB02.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S







[Acciones.BancosB02.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=Actualizar Forma
Actualizar Forma=(Fin)











[Acciones.BancosB03.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB03,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin

[Acciones.BancosB03.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
Activo=S
Visible=S

[Acciones.BancosB03.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.BancosB03.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=Actualizar Forma
Actualizar Forma=(Fin)






[Acciones.BancosA04.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB04,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancosA04.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
[Acciones.BancosA04.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S







[Acciones.BancosA04.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=Actualizar Forma
Actualizar Forma=(Fin)

[Acciones.BancosB04.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB04,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
Activo=S
Visible=S

[Acciones.BancosB04.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
Activo=S
Visible=S

[Acciones.BancosB04.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.BancosB04.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=Actualizar Forma
Actualizar Forma=(Fin)






[Acciones.BancosB05.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB05,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
Activo=S
Visible=S

[Acciones.BancosB05.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
Activo=S
Visible=S

[Acciones.BancosB05.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.BancosB05.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=Actualizar Forma
Actualizar Forma=(Fin)






[Acciones.BancosB06.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB06,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
Activo=S
Visible=S

[Acciones.BancosB06.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
Activo=S
Visible=S

[Acciones.BancosB06.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.BancosB06.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=Actualizar Forma
Actualizar Forma=(Fin)






[Acciones.BancosB07.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB07,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
Activo=S
Visible=S

[Acciones.BancosB07.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
Activo=S
Visible=S

[Acciones.BancosB07.Actualizar Formas]
Nombre=Actualizar Formas
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.BancosB07.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=Actualizar Formas
Actualizar Formas=(Fin)

[Acciones.BancosB08.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB08,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
Activo=S
Visible=S

[Acciones.BancosB08.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
Activo=S
Visible=S

[Acciones.BancosB08.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.BancosB08.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=Actualizar Forma
Actualizar Forma=(Fin)











[Acciones.FormaPago2.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (F2,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>  Temp.POSMonederoL=Verdadero<BR>Entonces<BR>  Si<BR>    Info.CodigoFormaPago = Temp.POSMonederoFP<BR>  Entonces<BR>    Forma(<T>SerieTarjetaMovRedimir<T>)<BR>    Asigna(Info.POSImporteRef, SQL(<T>SELECT Importe FROM SerieTarjetaMov WHERE ID=:tid<T>,Info.IDTexto))<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR>                                      <BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
Activo=S
Visible=S

[Acciones.FormaPago2.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
Activo=S
Visible=S

[Acciones.FormaPago2.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.FormaPago2.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=Actualizar Forma
Actualizar Forma=(Fin)






[Acciones.FormaPago3.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (F3,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>  Temp.POSMonederoL=Verdadero<BR>Entonces<BR>  Si<BR>    Info.CodigoFormaPago = Temp.POSMonederoFP<BR>  Entonces<BR>    Forma(<T>SerieTarjetaMovRedimir<T>)<BR>    Asigna(Info.POSImporteRef, SQL(<T>SELECT Importe FROM SerieTarjetaMov WHERE ID=:tid<T>,Info.IDTexto))<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR>                                      <BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
Activo=S
Visible=S

[Acciones.FormaPago3.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
Activo=S
Visible=S

[Acciones.FormaPago3.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.FormaPago3.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=Actualizar Forma
Actualizar Forma=(Fin)

[Acciones.FormaPago4.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (F4,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>  Temp.POSMonederoL=Verdadero<BR>Entonces<BR>  Si<BR>    Info.CodigoFormaPago = Temp.POSMonederoFP<BR>  Entonces<BR>    Forma(<T>SerieTarjetaMovRedimir<T>)<BR>    Asigna(Info.POSImporteRef, SQL(<T>SELECT Importe FROM SerieTarjetaMov WHERE ID=:tid<T>,Info.IDTexto))<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR>                                      <BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
Activo=S
Visible=S

[Acciones.FormaPago4.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
Activo=S
Visible=S

[Acciones.FormaPago4.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S


[Acciones.FormaPago5.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (F5,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>  Temp.POSMonederoL=Verdadero<BR>Entonces<BR>  Si<BR>    Info.CodigoFormaPago = Temp.POSMonederoFP<BR>  Entonces<BR>    Forma(<T>SerieTarjetaMovRedimir<T>)<BR>    Asigna(Info.POSImporteRef, SQL(<T>SELECT Importe FROM SerieTarjetaMov WHERE ID=:tid<T>,Info.IDTexto))<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR>                                      <BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
Activo=S
Visible=S

[Acciones.FormaPago5.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
Activo=S
Visible=S

[Acciones.FormaPago5.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.FormaPago5.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=Actualizar Forma
Actualizar Forma=(Fin)

[Acciones.FormaPago6.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (F6,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>  Temp.POSMonederoL=Verdadero<BR>Entonces<BR>  Si<BR>    Info.CodigoFormaPago = Temp.POSMonederoFP<BR>  Entonces<BR>    Forma(<T>SerieTarjetaMovRedimir<T>)<BR>    Asigna(Info.POSImporteRef, SQL(<T>SELECT Importe FROM SerieTarjetaMov WHERE ID=:tid<T>,Info.IDTexto))<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR>                                      <BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
Activo=S
Visible=S

[Acciones.FormaPago6.Recalcular]
Nombre=Recalcular
Boton=0
TipoAccion=Expresion
Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
Activo=S
Visible=S

[Acciones.FormaPago6.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S



[Acciones.FormaPago6.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcular
Recalcular=Actualizar Forma
Actualizar Forma=(Fin)

[Acciones.FormaPago7.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (F7,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>  Temp.POSMonederoL=Verdadero<BR>Entonces<BR>  Si<BR>    Info.CodigoFormaPago = Temp.POSMonederoFP<BR>  Entonces<BR>    Forma(<T>SerieTarjetaMovRedimir<T>)<BR>    Asigna(Info.POSImporteRef, SQL(<T>SELECT Importe FROM SerieTarjetaMov WHERE ID=:tid<T>,Info.IDTexto))<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR>                                      <BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
Activo=S
Visible=S

[Acciones.FormaPago7.Recalcula]
Nombre=Recalcula
Boton=0
TipoAccion=Expresion
Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
Activo=S
Visible=S

[Acciones.FormaPago7.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.FormaPago7.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=Actualizar Forma
Actualizar Forma=(Fin)

[Acciones.FormaPago8.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (F8,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>  Temp.POSMonederoL=Verdadero<BR>Entonces<BR>  Si<BR>    Info.CodigoFormaPago = Temp.POSMonederoFP<BR>  Entonces<BR>    Forma(<T>SerieTarjetaMovRedimir<T>)<BR>    Asigna(Info.POSImporteRef, SQL(<T>SELECT Importe FROM SerieTarjetaMov WHERE ID=:tid<T>,Info.IDTexto))<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR>                                      <BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
Activo=S
Visible=S

[Acciones.FormaPago8.Recalcular]
Nombre=Recalcular
Boton=0
TipoAccion=Expresion
Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
Activo=S
Visible=S

[Acciones.FormaPago8.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.FormaPago8.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcular
Recalcular=Actualizar Forma
Actualizar Forma=(Fin)






[Acciones.FormaPago4.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=Actualizar Forma
Actualizar Forma=(Fin)



[Acciones.CalculaImporteRefPrevio2.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Expresion
Expresion=(Fin)




































[Acciones.BancosA01.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcular
Recalcular=Actualizar Forma
Actualizar Forma=(Fin)
















[Cambio.ListaEnCaptura]
(Inicio)=Ver.Cambio
Ver.Cambio=Ver.Aviso
Ver.Aviso=(Fin)

[Cambio.ListaAccionesBB]
(Inicio)=Regresa
Regresa=Separador1
Separador1=MenuPrincipal
MenuPrincipal=RegresarP1
RegresarP1=Separador1P1
Separador1P1=CancelaPartida
CancelaPartida=AltaMonedero
AltaMonedero=Redondea
Redondea=MenuEspecial
MenuEspecial=RegresarP2
RegresarP2=Separador1P2
Separador1P2=BancosA01
BancosA01=BancosA02
BancosA02=BancosA03
BancosA03=BancosA04
BancosA04=Separador2P2
Separador2P2=BancosA05
BancosA05=BancosA06
BancosA06=BancosA07
BancosA07=BancosA08
BancosA08=MenuBancos
MenuBancos=RegresarP3
RegresarP3=Separador1P3
Separador1P3=BancosB01
BancosB01=BancosB02
BancosB02=BancosB03
BancosB03=BancosB04
BancosB04=Separador2P3
Separador2P3=BancosB05
BancosB05=BancosB06
BancosB06=BancosB07
BancosB07=BancosB08
BancosB08=MenuVales
MenuVales=RegresarP4
RegresarP4=Separador1P4
Separador1P4=BancosC01
BancosC01=BancosC02
BancosC02=BancosC03
BancosC03=BancosC04
BancosC04=Separador2P4
Separador2P4=BancosC05
BancosC05=BancosC06
BancosC06=BancosC07
BancosC07=BancosC08
BancosC08=FormaPago2
FormaPago2=FormaPago3
FormaPago3=FormaPago4
FormaPago4=FormaPago5
FormaPago5=Separador3
Separador3=FormaPago6
FormaPago6=FormaPago7
FormaPago7=FormaPago8
FormaPago8=Cobra
Cobra=(Fin)

[Forma.ListaCarpetas]
(Inicio)=Cobro
Cobro=Cambio
Cambio=VentaCobro
VentaCobro=(Fin)

[Forma.ListaAcciones]
(Inicio)=CalculaImporteRefPrevio
CalculaImporteRefPrevio=CalculaImporteRef
CalculaImporteRef=CalculaCambio
CalculaCambio=CalculaImporteRefPrevio2
CalculaImporteRefPrevio2=ValidaTarjetaRegalo
ValidaTarjetaRegalo=TarjetaRegalo
TarjetaRegalo=(Fin)

[Forma.MenuPrincipal]
(Inicio)=Principal &.
Principal &.=&Especial
&Especial=&Bancos
&Bancos=&Vales
&Vales=(Fin)
