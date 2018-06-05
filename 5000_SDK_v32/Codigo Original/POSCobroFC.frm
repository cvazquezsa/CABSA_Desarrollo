
[Forma]
Clave=POSCobroFC
Icono=0
Modulos=(Todos)
Nombre=POS Cobro Creditos

ListaCarpetas=(Lista)
CarpetaPrincipal=Cobro
AccionesTamanoBoton=100x5
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=286
PosicionInicialArriba=147
PosicionInicialAlturaCliente=630
PosicionInicialAncho=1036
PosicionCol1=449




ListaAcciones=(Lista)
PosicionSec1=396
PosicionSec2=486
PosicionCol3=449
AccionesCentro=S
AccionesDivision=S
Menus=S
PosicionCol2=449
EsConsultaExclusiva=S
VentanaExclusiva=S
VentanaExclusivaOpcion=2
MenuTouchScreen=S
VentanaSinIconosMarco=S
MenuTouchScreenMostrarTeclasFuncion=S
ExpresionesAlMostrar=Asigna(Ver.FormasPago, TextoEnLista(SQL(<T>EXEC spPOSMuestraFormasPago<T>)))<BR>Asigna(Info.POSImporteOferta,TextoEnLista(SQL(<T>spPOSMuestraOfertasFormasPago :tID,:tEmpresa,:nSucursal, :tEstacion<T>,Info.IDTexto,Empresa,Sucursal,  EstacionTrabajo )))<BR>Asigna(Ver.Cobro, TextoEnLista(SQL(<T>EXEC spPOSMuestraVentaCobro :tID<T>, Info.IDTexto)))<BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Ver.Aviso,Nulo)<BR>Asigna(Info.Referencia, Nulo)<BR>Asigna(Info.POSImporteRef,Info.Importe)<BR>Asigna(Info.CodigoFormaPago, Nulo)<BR>Asigna(Ver.Cambio, $0.00)<BR>Asigna(Info.Cambio, 0)<BR>Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>Asigna(Info.POSTipoCambioSuc,1)<BR>Asigna(Info.TorretaMensaje1,<T>IMPORTE  <T>+SQL(<T>SELECT dbo.fnFormatoMoneda(:nImporte,:tEmpresa)<T>,Info.Importe,Empresa))<BR>Asigna(Info.TorretaPosicion1,<T>Derecha<T>)<BR>Asigna(Info.TorretaMensaje2,<T>SALDO  <T>+SQL(<T>SELECT dbo.fnFormatoMoneda(:nImporte,:tEmpresa)<T>,Info.Saldo,Empresa))<BR>Asigna(Info.TorretaPosicion2,<T>Derecha<T>)<BR>Asigna(Info.Importe2,Info.Importe)<BR>Asigna(Temp.Flotante,SQL(<T>spPOSVentaInsertaRedondeo :tID,:tTipo,:nImporte<T>,Info.IDTexto,<T>CONSULTAR COBRO<T>,Nulo))<BR>Asigna(Info.Acumulativa,SQL(<T>SELECT RedondeoVenta FROM POSCfg WHERE Empresa = :tEmpresa<T>,Empresa))<BR>Asigna(Info.Titulo, SQLEnLista(<T>SELECT Space(3)+ Moneda, TipoCambio FROM POSLTipoCambioRef WHERE Sucursal =:nS<T>, Sucursal))<BR>Si<BR>  Info.Torreta<BR>Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>Fin<BR><BR>Asigna(Info.Clase1,<T>Alta Monedero<T>)<BR>Asigna(Info.Clase2,<T>Cancelar Partida   (Alt + F1)<T>)<BR>Asigna(Info.Clase3,<T>Cobrar<T>)<BR><BR>/*Asigno la forma de pago Efectivo por Omision JLMR 01 2013*/<BR>Asigna(Info.CodigoFormaPago, SQL(<T>SELECT ISNULL(f.F2,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F2 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Temp.TextoTemp02, Info.CodigoFormaPago)<BR>Asigna(Info.POSFormaPago2,SQL(<T>SELECT ISNULL(NULLIF(f.F2, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F2 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.POSFormaPago3,SQL(<T>SELECT ISNULL(NULLIF(f.F3, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F3 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.POSFormaPago4,SQL(<T>SELECT ISNULL(NULLIF(f.F4, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F4 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.POSFormaPago5,SQL(<T>SELECT ISNULL(NULLIF(f.F5, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F5 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.POSFormaPago6,SQL(<T>SELECT ISNULL(NULLIF(f.F6, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F6 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.POSFormaPago7,SQL(<T>SELECT ISNULL(NULLIF(f.F7, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F7 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.POSFormaPago8,SQL(<T>SELECT ISNULL(NULLIF(f.F8, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR><BR>Asigna(Info.BancoA01,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA01,:tNulo),:tVacio) + :tTecla FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoA01 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>  (CTRL + 1)<T>,<T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoA02,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA02,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoA02 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoA03,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA03,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoA03 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoA04,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA04,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoA04 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoA05,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA05,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoA05 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoA06,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA06,:tNulo),:tVacio) + :tTecla FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoA06 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>  (CTRL + 2)<T>,<T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoA07,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA07,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoA07 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoA08,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA08,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoA01 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR><BR>Asigna(Info.BancoB01,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB01,:tNulo),:tVacio) + :tTecla FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoB01 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>  (CTRL + 3)<T>,<T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoB02,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB02,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoB02 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoB03,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB03,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoB03 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoB04,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB04,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoB04 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoB05,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB05,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoB05 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoB06,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB06,:tNulo),:tVacio) + :tTecla FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoB06 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>  (CTRL + 4)<T>,<T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoB07,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB07,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoB07 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoB08,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB08,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoB08 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR><BR>Asigna(Info.BancoC01,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC01,:tNulo),:tVacio) + :tTecla FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoC01 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>  (CTRL + 5)<T>,<T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoC02,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC02,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoC02 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoC03,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC03,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoC03 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoC04,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC04,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoC04 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoC05,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC05,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoC05 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoC06,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC06,:tNulo),:tVacio) + :tTecla FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoC01 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>  (CTRL + 6)<T>,<T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoC07,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC07,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoC07 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoC08,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC08,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoC08 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))
ExpresionesAlCerrar=//Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tFormaCambio, :nCambio, :nCobro, :nLecturaTarjeta, :tCliente, :tMonedero,:nImporteRef<T>, EstacionTrabajo, Nulo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto, NULO, Info.FormaPagoCambio, Info.Cambio, 1, Nulo, Nulo,Nulo,Nulo))<BR>//EjecutarSQL(<T>EXEC spPOSOfertaAplicar :tid<T>,Info.IDTexto)<BR>Asigna(Info.Importe, nulo)<BR>Asigna(Info.POSRedondeo, nulo)
ExpresionesAlActivar=Asigna(Info.Codigo, Nulo)<BR>Forma.EnfocarVariable( <T>Cobro<T>, <T>Info.CodigoFormaPago<T> )
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
Fuente={Tahoma, 18, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Rojo obscuro
CampoColorFondo=$00FFE8E8
ListaEnCaptura=(Lista)

CarpetaVisible=S


AlinearTodaCarpeta=S

CampoAccionAlEnter=CalculaImporteRef
[Acciones.Enter.VariablesAsignar]
Nombre=VariablesAsignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
Activo=S
Visible=S

[Acciones.Enter]
Nombre=Enter
Boton=0
NombreDesplegar=Info.Clase3
Activo=S
Visible=S

TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar















Multiple=S
ListaAccionesMultiples=(Lista)
NombreEnBoton=S
EnMenu=S
TeclaFuncion=F12
ConfirmarAntes=S
DialogoMensaje=EstaSeguro

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
3D=S
Tamano=14
ColorFondo=$00FFE8E8













AccionAlEnter=












IgnoraFlujo=N
ColorFuente=Rojo obscuro
EditarConBloqueo=S
[Cambio]
Estilo=Ficha
Clave=Cambio
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=(Variables)
Fuente={Tahoma, 22, Negro, []}
CampoColorLetras=Lima
CampoColorFondo=Negro
ListaEnCaptura=(Lista)
CarpetaVisible=S

FichaEspacioEntreLineas=4
FichaEspacioNombres=171
FichaColorFondo=Plata
ConFuenteEspecial=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
AlinearTodaCarpeta=S

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
3D=S
Tamano=28
ColorFondo=Negro
EspacioPrevio=N
ColorFuente=Lima
































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
EjecucionCondicion=Vacio(Info.POSMensajeError)
[Cobro.Info.POSRedondeo]
Carpeta=Cobro
Clave=Info.POSRedondeo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Plata









AccionAlEnter=ActualizaRedondeo
EspacioPrevio=S
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





















Expresion=forma.Accion(<T>CalculaCambio<T>)<BR>forma.Accion(<T>CalculaImporteRef<T>)<BR>Asigna(Info.POSLDIError, Nulo)<BR>Asigna(Info.FormaExtra, Nulo)<BR>Asigna(Info.VFAFormaPago, SQL(<T>EXEC spPOSVFAFormaPago :tCodigo, :tID<T>, Info.CodigoFormaPago, Info.IDTexto))<BR>Asigna(Info.FormaExtra, SQL(<T>EXEC spPOSLDIFormaPagoFormaAnexa :tCodigo, :tID, :tEmpresa<T>, Info.CodigoFormaPago, Info.IDTexto, Empresa))<BR><BR>Si<BR>  SQL(<T>SELECT POSMonedero FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa)=0<BR>Entonces<BR>  Si<BR>    Info.FormaExtra <> Nulo   y    vacio(Info.POSMonedero)<BR>  Entonces<BR>    FormaModal(Info.FormaExtra)<BR>   Fin<BR>Sino<BR>  <T><T><BR>Fin<BR><BR>Si<BR>  Info.FormaExtra = <T>POSCobroMonedero<T> y Vacio(Info.POSMonedero)<BR>Entonces<BR>  Asigna(Info.POSMensajeError,<T>No se ha asignado Monedero<T>)<BR>  Informacion(Info.POSMensajeError)<BR>  AbortarOperacion<BR>Sino<BR>  <T><T><BR>Fin<BR><BR>Si<BR>  SQL(<T>SELECT POSMonedero FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa)=0<BR>Entonces<BR>  Si<BR>    Info.FormaExtra <> Nulo   y     ConDatos(Info.POSMonedero)<BR>  Entonces<BR>    Asigna(Info.POSMensajeError,SQL(<T>EXEC spPOSChecarSaldoMonFC :tID, :tMonedero, :tEmpresa, :tUsuario, :nSucrusal, :nImporte<T>, Info.IDTexto, Info.POSMonedero, Empresa, Usuario, Sucursal, Info.Importe))<BR>   Fin<BR>Sino<BR>  <T><T><BR>Fin<BR><BR>Si<BR>  ConDatos(Info.POSMensajeError)<BR>Entonces<BR>  Informacion(Info.POSMensajeError)<BR>  AbortarOperacion<BR>Fin<BR><BR>Si<BR>  ConDatos(Info.VFAFormaPago)<BR>Entonces<BR><BR>  VFA.Cargo(<T>POS<T>, Info.IDTexto,<T>2048<T>,Info.Referencia,Info.Importe)<BR>  Asigna(Temp.Reg2, SQL(<T>spPOSVFAVerificar :tID<T>,Info.IDTexto))<BR>  Asigna(Info.POSVFAError,Temp.Reg2[1])<BR>  Asigna(Info.POSVFAMensajeError,Temp.Reg2[2])<BR>  Asigna(Info.Importe,Temp.Reg2[3])<BR><BR>Fin<BR><BR><BR><BR>Si<BR>  ConDatos(Info.POSVFAError)<BR>Entonces<BR>  Error(Info.POSVFAMensajeError)<BR>  Asigna(Info.Codigo,Nulo)<BR>Fin<BR><BR>Asigna(Info.FormaExtra, Nulo)<BR>Asigna(Info.Codigo, Info.CodigoFormaPago)<BR><BR>Asigna(Info.CodigoFormaPago, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR><BR>Si Info.POSLDIError <> Nulo Entonces Asigna(Info.Codigo, Nulo) Fin<BR><BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tFormaCambio, :nCambio, :nCobro, :nLecturaTarjeta, :tCliente, :tMonedero<T>, EstacionTrabajo, Nulo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto, 0, Nulo,Nulo, 0, Nulo, Nulo, Info.POSMonedero))<BR>Asigna(Info.FormaExtra,Temp.Reg[13])<BR>Asigna(Info.Servicio,Temp.Reg[12])<BR><BR>Si (Info.FormaExtra <> Nulo)  y (Info.Servicio <> Nulo) Entonces  FormaModal(Info.FormaExtra) Fin<BR><BR><BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tFormaCambio, :nCambio, :nCobro, :nLecturaTarjeta, :tCliente, :tMonedero,:nImporteRef<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto, Info.Importe, Info.FormaPagoCambio, Info.Cambio, 1, Nulo, Nulo, Info.POSMonedero, Info.POSImporteRef))<BR><BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Si<BR>  Info.Saldo = 0<BR>Entonces<BR>  Asigna(Info.POSImporteOferta,Nulo)<BR>Fin<BR><BR>Asigna(Ver.Cobro, TextoEnLista(SQL(<T>EXEC spPOSMuestraVentaCobro :tID<T>, Info.IDTexto)))<BR>Asigna(Info.TorretaMensaje1,<T>IMPORTE  <T>+SQL(<T>SELECT dbo.fnFormatoMoneda(:nImporte,:tEmpresa)<T>,Info.Importe2,Empresa))<BR>Asigna(Info.TorretaPosicion1,<T>Derecha<T>)<BR>Asigna(Info.TorretaMensaje2,<T>SALDO  <T>+SQL(<T>SELECT dbo.fnFormatoMoneda(:nImporte,:tEmpresa)<T>,Info.Saldo,Empresa))<BR>Asigna(Info.TorretaPosicion2,<T>Derecha  <T>)<BR>Si<BR>  Info.Torreta<BR>Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>Fin<BR><BR><BR><BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Info.Mensaje,Nulo)<BR>Asigna(Info.POSMonedero, Nulo)<BR>Asigna(Info.Referencia, Nulo)<BR>Asigna(Info.POSImporteRef, Nulo)<BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR>Si Info.Cambio noen(0, <T>$0.00<T>)<BR>Entonces<BR>Asigna(Info.Mensaje,<T>Cambio: <T> & Ver.Cambio)<BR>Fin
EjecucionCondicion=(Info.Cambio en(0, <T>$0.00<T>))<BR>o (ConDatos(Info.FormaPagoCambio) y (Info.Importe = 0)y (Info.Saldo = 0))<BR>o (ConDatos(Info.FormaPagoCambio) y (Info.Importe > 0)y (Info.Saldo > 0))<BR>y  Dialogo( <T>EstaSeguroCobroCredito<T> )
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
3D=S
AccionAlEnter=
Tamano=14
ColorFondo=$00FFE8E8

IgnoraFlujo=S






EspacioPrevio=S

ColorFuente=Rojo obscuro
[Acciones.Monedero]
Nombre=Monedero
Boton=0
NombreEnBoton=S
NombreDesplegar=Info.Clase1
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S























Menu=&Principal
Expresion=Si<BR>  SQL(<T>SELECT POSMonedero FROM POSCfg WHERE Empresa = :tEmpresa<T>,Empresa)=0<BR>Entonces<BR>  FormaModal(<T>POSMonedero<T>)<BR>  Forma.Accion(<T>CalculaImporteRefPrevio<T>)<BR>Sino<BR>  Informacion(<T>Opción no disponible<T>)<BR>Fin
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
3D=S
EspacioPrevio=S
Tamano=14
ColorFondo=$00F0F0F0














AccionAlEnter=
IgnoraFlujo=N
ColorFuente=Rojo obscuro
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
3D=S
Tamano=14
ColorFondo=$00FFE8E8




AccionAlEnter=CalculaImporteRef









ColorFuente=Rojo obscuro
[Cobro.Info.POSTipoCambioSuc]
Carpeta=Cobro
Clave=Info.POSTipoCambioSuc
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=$00F0F0F0









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
Fuente={Tahoma, 8, Negro, [Negritas]}
CampoColorLetras=Rojo obscuro
CampoColorFondo=$00FFE8E8
ListaEnCaptura=(Lista)

FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaColorFondo=Negro
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
Tamano=70
ColorFondo=$00FFE8E8
ColorFuente=Rojo obscuro









[Acciones.F3]
Nombre=F3
Boton=0
NombreDesplegar=Info.POSFormaPago3
EnMenu=S
Activo=S
Visible=S


Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.F4]
Nombre=F4
Boton=0
NombreDesplegar=Info.POSFormaPago4
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S


Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.F5]
Nombre=F5
Boton=0
NombreDesplegar=Info.POSFormaPago5
EnMenu=S
Activo=S
Visible=S



RefrescarDespues=S
























































































Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.F6]
Nombre=F6
Boton=0
NombreDesplegar=Info.POSFormaPago6
EnMenu=S
Visible=S







Activo=S


Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.F7]
Nombre=F7
Boton=0
NombreDesplegar=Info.POSFormaPago7
EnMenu=S
Visible=S





Activo=S


Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.F8]
Nombre=F8
Boton=0
NombreDesplegar=Info.POSFormaPago8
EnMenu=S
Visible=S





























































Activo=S





Multiple=S
ListaAccionesMultiples=(Lista)
[VentaCobro.Info.POSImporteOferta]
Carpeta=VentaCobro
Clave=Info.POSImporteOferta
Editar=S
LineaNueva=S
3D=S
Tamano=70
ColorFondo=$00FFE8E8


ValidaNombre=N
ColorFuente=Rojo obscuro





















[Acciones.Cancelar]
Nombre=Cancelar
Boton=0
NombreDesplegar=Info.Clase2
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S








Menu=&Principal

UsaTeclaRapida=S
TeclaRapida=Alt+F1
Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.POSRedondeo]
Nombre=POSRedondeo
Boton=0
NombreDesplegar=&Redondeo
TipoAccion=Expresion























































Visible=S
Activo=S
ConCondicion=S


Menu=&Principal
EnMenu=S
Expresion=EjecutarSQL(<T>spPOSVentaInsertaRedondeo :tID,:tTipo,:nImporte<T>,Info.IDTexto,<T>ELIMINAR COBRO<T>,Nulo)) <BR>FormaModal(<T>POSRedondeoCobro<T>)<BR>/* Aqui se ejecuta el SPPOS para cobrar */<BR>  Asigna(Temp.Reg5, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tFormaCambio, :nCambio, :nCobro, :nLecturaTarjeta, :tCliente, :tMonedero,:nImporteRef<T>, EstacionTrabajo, Nulo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto, Nulo, Info.FormaPagoCambio, Info.Cambio, 0, Nulo, Nulo, Info.POSMonedero,Nulo))<BR><BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg5[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg5[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg5[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg5[6]))<BR>  Asigna(Ver.Total, Temp.Reg5[8])<BR>  Asigna(Info.Saldo, Temp.Reg5[9])<BR>  Asigna(Info.Importe, Temp.Reg5[9])<BR>  Asigna(Ver.Saldo, Temp.Reg5[9])<BR>  Asigna(Ver.Imagen,Temp.Reg5[11])<BR>Asigna(Temp.Flotante,SQL(<T>spPOSVentaInsertaRedondeo :tID,:tTipo,:nImporte<T>,Info.IDTexto,<T>CONSULTAR<T>,Nulo))<BR>Forma.Accion(<T>CalculaImporteRefPrevio<T>)
EjecucionCondicion=EsNumerico(Temp.Reg3[2]) y Info.Acumulativas
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
3D=S
Tamano=58
ColorFondo=Negro
ColorFuente=Lima
EspacioPrevio=S

[Detalle.Columnas]
Serie=146

























































































[Acciones.BancoA01]
Nombre=BancoA01
Boton=0
Menu=&Especial
NombreDesplegar=Info.BancoA01
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Multiple=S
ListaAccionesMultiples=(Lista)
UsaTeclaRapida=S
TeclaRapida=Ctrl+1
[Acciones.BancoA02]
Nombre=BancoA02
Boton=0
Menu=&Especial
NombreDesplegar=Info.BancoA02
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA02,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancoA03]
Nombre=BancoA03
Boton=0
Menu=&Especial
NombreDesplegar=Info.BancoA03
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA03,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancoA04]
Nombre=BancoA04
Boton=0
Menu=&Especial
NombreDesplegar=Info.BancoA04
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA04,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancoA05]
Nombre=BancoA05
Boton=0
Menu=&Especial
NombreDesplegar=Info.BancoA05
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA05,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancoA06]
Nombre=BancoA06
Boton=0
Menu=&Especial
NombreDesplegar=Info.BancoA06
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




UsaTeclaRapida=S
TeclaRapida=Ctrl+2
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA06,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancoA07]
Nombre=BancoA07
Boton=0
Menu=&Especial
NombreDesplegar=Info.BancoA07
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA07,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancoA08]
Nombre=BancoA08
Boton=0
NombreDesplegar=Info.BancoA08
EnMenu=S
TipoAccion=Expresion
Visible=S










Activo=S
Menu=&Especial
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA08,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancoB01]
Nombre=BancoB01
Boton=0
Menu=&Bancos
NombreDesplegar=Info.BancoB01
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Multiple=S
ListaAccionesMultiples=(Lista)
UsaTeclaRapida=S
TeclaRapida=Ctrl+3
[Acciones.BancoB02]
Nombre=BancoB02
Boton=0
Menu=&Bancos
NombreDesplegar=Info.BancoB02
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S







Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB02,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancoB03]
Nombre=BancoB03
Boton=0
Menu=&Bancos
NombreDesplegar=Info.BancoB03
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB03,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancoB04]
Nombre=BancoB04
Boton=0
Menu=&Bancos
NombreDesplegar=Info.BancoB04
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S







Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB04,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancoB05]
Nombre=BancoB05
Boton=0
Menu=&Bancos
NombreDesplegar=Info.BancoB05
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB05,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancoB06]
Nombre=BancoB06
Boton=0
Menu=&Bancos
NombreDesplegar=Info.BancoB06
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




UsaTeclaRapida=S
TeclaRapida=Ctrl+4
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB06,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancoB07]
Nombre=BancoB07
Boton=0
Menu=&Bancos
NombreDesplegar=Info.BancoB07
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB07,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancoB08]
Nombre=BancoB08
Boton=0
Menu=&Bancos
NombreDesplegar=Info.BancoB08
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S










Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB08,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancoC01]
Nombre=BancoC01
Boton=0
Menu=&Vales
NombreDesplegar=Info.BancoC01
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




UsaTeclaRapida=S
TeclaRapida=Ctrl+5
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC01,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancoC02]
Nombre=BancoC02
Boton=0
Menu=&Vales
NombreDesplegar=Info.BancoC02
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC02,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancoC03]
Nombre=BancoC03
Boton=0
Menu=&Vales
NombreDesplegar=Info.BancoC03
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC03,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancoC04]
Nombre=BancoC04
Boton=0
Menu=&Vales
NombreDesplegar=Info.BancoC04
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S










Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC04,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancoC05]
Nombre=BancoC05
Boton=0
Menu=&Vales
NombreDesplegar=Info.BancoC05
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
































































Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC05,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancoC06]
Nombre=BancoC06
Boton=0
Menu=&Vales
NombreDesplegar=Info.BancoC06
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




UsaTeclaRapida=S
TeclaRapida=Ctrl+6
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC06,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancoC07]
Nombre=BancoC07
Boton=0
Menu=&Vales
NombreDesplegar=Info.BancoC07
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC07,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
[Acciones.BancoC08]
Nombre=BancoC08
Boton=0
Menu=&Vales
NombreDesplegar=Info.BancoC08
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S



























































































































































































































































Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC08,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>  Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Si<BR>    SQL(<T>SELECT POSValidaPromocion FROM FormaPago WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = Verdadero<BR>  Entonces<BR>    Si<BR>      SQL(<T>SELECT 1 FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago) = 1<BR>    Entonces<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Asigna(Info.POSImporteRef,SQL(<T>SELECT SUM (PrecioTotal) FROM POSCobroCondicionTemp WHERE FormaPago = :tFormaPago<T>, Info.CodigoFormaPago))<BR>      Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>      Asigna(Info.Descripcion, Nulo)<BR>      Asigna(Temp.TDC, Nulo)<BR>      Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>      Si<BR>        Temp.TDC[1]=<T>SI<T><BR>      Entonces<BR>        Asigna(Info.Descripcion, Temp.TDC[2])<BR>        Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>        Ejecutar(Info.Descripcion, Verdadero)<BR>      Fin<BR>    Sino<BR>      Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>      Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>      Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR>      Precaucion(<T>Forma de Pago No Válida<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>    Asigna(Info.FormaPagoCambio,SQL(<T>SELECT dbo.fnPOSRegresaFormaPagoCambio (:tFormaPago, :tEmpresa)<T>, Info.CodigoFormaPago, Empresa))<BR><BR>    Asigna(Temp.Numerico1, SQL(<T>SELECT Orden FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>    Asigna(Info.Descripcion, Nulo)<BR>    Asigna(Temp.TDC, Nulo)<BR>    Asigna(Temp.TDC, SQL(<T>spHHTDC :nEst, :tEmp, :nSuc, :tUsu, :tMod, :nModID, :nImporte, :tPosicion<T>, 1, Empresa, Sucursal, Usuario, <T>POS<T>, Temp.Numerico1, info.Importe, <T>BancoA01<T>))<BR>    Si<BR>      Temp.TDC[1]=<T>SI<T><BR>    Entonces<BR>      Asigna(Info.Descripcion, Temp.TDC[2])<BR>      Asigna(Info.Descripcion, Temp.TDC[2] + <T> <T>+Temp.TDC[3] + <T>, <T> + Temp.TDC[4] + <T>, <T> + Temp.TDC[5] + <T>, <T> + Temp.TDC[6] + <T>, <T> + Temp.TDC[7] + <T>, <T> + Temp.TDC[8] + <T>, <T> + Temp.TDC[9] + <T>, <T> + Temp.TDC[10] + <T>, <T> + Temp.TDC[11] + <T>, <T> + Temp.TDC[12] + <T>, <T> + Temp.TDC[13] + <T>, <T> + Temp.TDC[14] + <T>, <T> + Temp.TDC[15] + <T>, <T> + Temp.TDC[16] + <T>, <T> + Temp.TDC[17] + <T>, <T> + Temp.TDC[18])<BR>      Ejecutar(Info.Descripcion, Verdadero)<BR>    Fin<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.CodigoFormaPago<T>)<BR>Fin
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
3D=S
AccionAlEnter=CalculaCambio
Tamano=14
ColorFondo=$00F0F0F0












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
3D=S
Tamano=70
ColorFondo=$FFFFFFFF











ColorFuente=Lima




Efectos=[Negritas]




[Acciones.CalculaImporteRefPrevio2]
Nombre=CalculaImporteRefPrevio2
Boton=0
NombreDesplegar=CalculaImporteRefPrevio2
Multiple=S
EnMenu=S
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
Expresion=Forma.Accion( <T>CalculaImporteRefPrevio2<T> )
Activo=S
Visible=S

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
3D=S
AccionAlEnter=Enter
Pegado=N
Tamano=-1
ColorFondo=Blanco





[Acciones.F2w.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=ActualizaForma
ActualizaForma=(Fin)













[Acciones.F2]
Nombre=F2
Boton=0
NombreDesplegar=Info.POSFormaPago2
Multiple=S
EnMenu=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S

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





[Acciones.BancoA01.ListaAccionesMultiples]
(Inicio)=expresion
expresion=Recalcula
Recalcula=Actualizar Forma
Actualizar Forma=(Fin)

























[Acciones.BancoB01.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Recalcula
Recalcula=Actualizar Forma
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







[Acciones.F8.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualizar Forma
Actualizar Forma=Recalcula
Recalcula=(Fin)














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












[Cambio.ListaEnCaptura]
(Inicio)=Ver.Cambio
Ver.Cambio=Ver.Aviso
Ver.Aviso=(Fin)

















[VentaCobro.ListaEnCaptura]
(Inicio)=Ver.Cobro
Ver.Cobro=Info.POSImporteOferta
Info.POSImporteOferta=Info.Titulo
Info.Titulo=(Fin)



















[Acciones.CalculaImporteRefPrevio2.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Expresion
Expresion=(Fin)





















[Acciones.TarjetaRegalo]
Nombre=TarjetaRegalo
Boton=0
NombreDesplegar=Tarjeta Regalo
EnMenu=S
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
EnMenu=S
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






















[Acciones.CancelarCobro]
Nombre=CancelarCobro
Boton=0
NombreDesplegar=Cancelar Cobro
Multiple=S
EnMenu=S
ListaAccionesMultiples=Cerrar

Activo=S
Visible=S




ConfirmarAntes=S
DialogoMensaje=EstaSeguro
[Acciones.CancelarCobro.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar






























ConCondicion=S
EjecucionCondicion=Dialogo( <T>EstaSeguroCancelaCobroCredito<T> )
[Acciones.CancelarCobro.ListaAccionesMultiples]
(Inicio)=expresion
expresion=Cerrar
Cerrar=(Fin)



























































[Acciones.Cancelar.expresion]
Nombre=expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S






Expresion=Si<BR>  SQL(<T>SELECT 1 FROM POSUsuarioAccion WHERE Usuario = :tUsuario AND Accion = :tAccion<T>, Usuario, <T>CANCELAR PARTIDA<T>) = 1<BR>Entonces<BR>  Si      <BR>  Confirmacion( <T>¿Desea Eliminar Todo el Renglon?<T>, BotonSi, BotonNo ) = BotonSi    <BR>    Entonces      EjecutarSQL(<T>spPOSCancelarPartida :tID, :nEliminaRenglon<T>, Info.IDTexto, 1)     <BR>    Sino      EjecutarSQL(<T>spPOSCancelarPartida :tID, :nEliminaRenglon<T>, Info.IDTexto, 0)    <BR>  Fin    <BR>  Asigna(Temp.TextoTemp02, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>CANCELAR PARTIDA<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp02, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Temp.TextoTemp02, nulo)<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso a la acción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[Acciones.Cancelar.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.Cancelar.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S









[Acciones.Cancelar.ListaAccionesMultiples]
(Inicio)=expresion
expresion=Actualizar Vista
Actualizar Vista=Actualizar Forma
Actualizar Forma=(Fin)






























[Acciones.Enter.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=ValidaReferencia
ValidaReferencia=Expresion
Expresion=Actualizar Vista
Actualizar Vista=Actualizar Forma
Actualizar Forma=Cerrar
Cerrar=(Fin)







[Forma.ListaCarpetas]
(Inicio)=Cobro
Cobro=Cambio
Cambio=VentaCobro
VentaCobro=(Fin)

[Forma.ListaAcciones]
(Inicio)=F2
F2=F3
F3=F4
F4=F5
F5=F6
F6=F7
F7=Cancelar
Cancelar=Monedero
Monedero=POSRedondeo
POSRedondeo=CancelarCobro
CancelarCobro=Enter
Enter=CalculaImporteRefPrevio
CalculaImporteRefPrevio=CalculaImporteRef
CalculaImporteRef=CalculaCambio
CalculaCambio=CalculaImporteRefPrevio2
CalculaImporteRefPrevio2=F8
F8=BancoA01
BancoA01=BancoA02
BancoA02=BancoA03
BancoA03=BancoA04
BancoA04=BancoA05
BancoA05=BancoA06
BancoA06=BancoA07
BancoA07=BancoA08
BancoA08=BancoB01
BancoB01=BancoB02
BancoB02=BancoB03
BancoB03=BancoB04
BancoB04=BancoB05
BancoB05=BancoB06
BancoB06=BancoB07
BancoB07=BancoB08
BancoB08=BancoC01
BancoC01=BancoC02
BancoC02=BancoC03
BancoC03=BancoC04
BancoC04=BancoC05
BancoC05=BancoC06
BancoC06=BancoC07
BancoC07=BancoC08
BancoC08=ValidaTarjetaRegalo
ValidaTarjetaRegalo=TarjetaRegalo
TarjetaRegalo=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Principal
&Principal=&Especial
&Especial=&Bancos
&Bancos=&Vales
&Vales=(Fin)
