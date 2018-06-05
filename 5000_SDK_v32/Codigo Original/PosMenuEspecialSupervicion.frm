
[Forma]
Clave=PosMenuEspecialSupervicion
Icono=54
Modulos=(Todos)

ListaCarpetas=(Lista)
CarpetaPrincipal=Codigo
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=254
PosicionInicialArriba=42
PosicionInicialAlturaCliente=691
PosicionInicialAncho=1027
PosicionSec1=389
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionCol2=519
PosicionSec2=533
PosicionCol3=581
PosicionCol1=826
Menus=S

Nombre=<T>Movimientos Supervisor<T>
VentanaExclusiva=S
VentanaExclusivaOpcion=0
VentanaSinIconosMarco=S
VentanaColor=$00804000
DeshabilitarAyuda=S
ExpresionesAlMostrar=Asigna(Info.Empresa, Empresa)<BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Ver.Memo, Nulo)<BR>Asigna(Info.POSFormaPago2,SQL(<T>SELECT ISNULL(NULLIF(f.F2,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F2 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>, <T> <T>,<T>Vacio<T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago3,SQL(<T>SELECT ISNULL(NULLIF(f.F3,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F3 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>, <T> <T>,<T>Vacio<T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago4,SQL(<T>SELECT ISNULL(NULLIF(f.F4,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F4 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>, <T> <T>,<T>Vacio<T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago5,SQL(<T>SELECT ISNULL(NULLIF(f.F5,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F5 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>, <T> <T>,<T>Vacio<T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago6,SQL(<T>SELECT ISNULL(NULLIF(f.F6,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F6 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>, <T> <T>,<T>Vacio<T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago7,SQL(<T>SELECT ISNULL(NULLIF(f.F7,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F7 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>, <T> <T>,<T>Vacio<T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago8,SQL(<T>SELECT ISNULL(NULLIF(f.F8,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>, <T> <T>,<T>Vacio<T>, <T>Forma Pago<T> ,Sucursal))<BR><BR>Asigna(Info.BancoA01,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA01,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoA02,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA02,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoA03,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA03,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoA04,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA04,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoA05,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA05,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoA06,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA06,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoA07,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA07,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoA08,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA08,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR><BR>Asigna(Info.BancoB01,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB01,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoB02,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB02,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoB03,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB03,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoB04,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB04,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoB05,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB05,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoB06,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB06,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoB07,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB07,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoB08,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB08,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR><BR>Asigna(Info.BancoC01,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC01,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoC02,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC02,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoC03,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC03,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoC04,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC04,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoC05,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC05,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoC06,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC06,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoC07,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC07,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoC08,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC08,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.MovClaveAfecta, SQL(<T>SELECT mt.Clave FROM POSL p INNER JOIN MovTipo mt ON p.Mov = mt.Mov AND mt.Modulo = :tPOS WHERE p.ID = :tID<T>, <T>POS<T>, Info.IDTexto))<BR>Si<BR>  Info.MovClaveAfecta = <T>POS.ACM<T><BR>Entonces<BR>  Asigna(Ver.Memo, <T>En los Movimientos Mutimoneda recuerde capturar en la Apertura de Caja la Cuenta de Dinero Multimoneda y la Forma de Pago Utilizando la Tecla F2...<T>)<BR>Sino<BR>  <T><T><BR>Fin<BR><BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR><BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen,Temp.Reg[11])
ExpresionesAlCerrar=Asigna(Info.Torreta,SQL(<T>SELECT TieneTorreta FROM POSCfg WHERE Empresa = :tEmpresa<T>,Empresa))<BR>Si<BR>  Info.Torreta<BR>Entonces<BR>   Torreta.Cerrar<BR>Fin<BR>Asigna(Info.IDTexto, SQL(<T>spPOSAbrir :tEmpresa, :tUsuario<T>, Empresa,Usuario))<BR>EjecutarSQL(<T>spPOSInicializar  :tEmpresa, :nSucursal, :tUsuario, :nEstacion, :tID<T>,Empresa, Sucursal, Usuario, EstacionTrabajo, Info.IDTexto)<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
ExpresionesAlActivar=Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, nulo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  nulo, Info.IDTexto))<BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>SI(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR><BR><BR>Asigna(Info.Torreta,SQL(<T>SELECT TieneTorreta FROM POSCfg WHERE Empresa = :tEmpresa<T>,Empresa))<BR>Si<BR>  Info.Torreta<BR>Entonces<BR>  Asigna(Info.TorretaPuerto,SQL(<T>SELECT PuertoTorreta FROM POSCfg WHERE Empresa = :tEmpresa<T>,Empresa))<BR>   Torreta.Abrir(Info.TorretaPuerto)<BR>Asigna(Info.TorretaMensaje1,<T>*** BIENVENIDO ***<T>)<BR>Asigna(Info.TorretaPosicion1,<T>Centrado<T>)<BR>Asigna(Info.TorretaMensaje2,NULO))<BR>Asigna(Info.TorretaPosicion2,<T>Derecha<T>)<BR><BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>Fin<BR>Asigna(Ver.Memo, <T>********** Atencion **********<BR><T>+<T>Al Terminar de capturar la forma de pago y el monto, avance con la tecla F12 para Afectar el Movimiento, Si el Movimiento es MultiMoneda y vas a ingresar algún registro deberas seleccionar la Cuenta de Dinero de la otra Moneda presionando F1(Principal), seguido de F2(MultiMoneda), y elige la Cuenta de la Multimoneda, porteriormente selecciona la Forma Pago que corresponda, así como el Importe.<T>)<BR><BR>
MenuPrincipal=(Lista)
[Lista.Alm.Almacen]
Carpeta=Lista
Clave=Alm.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Alm.Nombre]
Carpeta=Lista
Clave=Alm.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco


[Lista.Columnas]
Almacen=90
Nombre=293








Sucursal=46
Nombre_1=304

Articulo=131
Descripcion1=244
0=127
1=211
Cliente=117
RFC=107
Estado=236
Delegacion=126
Colonia=216
CodigoPostal=71
Ruta=109
Grupo=100
Codigo=184
2=-2
3=-2
SerieLote=153
Unidad=122
[Acciones.Send.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Expresion
Expresion=(Fin)

































































































































































[(Variables).ListaEnCaptura]
(Inicio)=Info.Codigo
Info.Codigo=Ver.Lista
Ver.Lista=(Fin)






[Ticket]
Estilo=Ficha
Clave=Ticket
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Segoe UI, 12, Blanco, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=$00804000
FichaAlineacionDerecha=S
CampoColorLetras=Rojo obscuro
CampoColorFondo=$00FFE8E8
ListaEnCaptura=Ver.Ticket
CarpetaVisible=S
AlinearTodaCarpeta=S

ConFuenteEspecial=S



[Codigo]
Estilo=Ficha
Clave=Codigo
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=(Variables)
Fuente={Segoe UI, 14, Blanco, []}
FichaEspacioEntreLineas=9
FichaEspacioNombres=0
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=$00804000
FichaAlineacionDerecha=S
CampoColorLetras=Rojo obscuro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

ConFuenteEspecial=S
AlinearTodaCarpeta=S
CampoAccionAlEnter=Enter
[Codigo.Info.Codigo]
Carpeta=Codigo
Clave=Info.Codigo
Editar=S
LineaNueva=S
ValidaNombre=N
3D=N
AccionAlEnter=Enter
Tamano=40












AccionAlEnterBloquearAvance=S
OcultaNombre=N
Pegado=N
ConScroll=N
SinRecapitular=N
ColorFuente=Rojo obscuro
ColorFondo=Blanco
[Totales.]
Carpeta=Totales
ColorFondo=Negro
ColorFuente=Lima












































































[Aviso.Ver.Aviso]
Carpeta=Aviso
Clave=Ver.Aviso
Editar=S
LineaNueva=S
3D=N
Tamano=20
ColorFondo=$00FFFF80
ColorFuente=$008080FF


















































ValidaNombre=S
Efectos=[Negritas]
[Alm.ListaEnCaptura]
(Inicio)=Alm.Almacen
Alm.Almacen=Alm.Nombre
Alm.Nombre=(Fin)




[Lista.ListaEnCaptura]
(Inicio)=Alm.Almacen
Alm.Almacen=Alm.Nombre
Alm.Nombre=(Fin)












































[Ticket.Ver.Ticket]
Carpeta=Ticket
Clave=Ver.Ticket
Editar=S
LineaNueva=S
ValidaNombre=N
3D=N
Tamano=20
ColorFondo=$00FFE8E8










































































IgnoraFlujo=S
ColorFuente=Rojo obscuro
[Acciones.Enter]
Nombre=Enter
Boton=-1
NombreDesplegar=&Enter
GuardarAntes=S
TipoAccion=Expresion
Activo=S
Visible=S




















































































































































































































































































































































































































































































































































































































































































EnBarraAcciones=S
Expresion=Asigna(Ver.Memo, <T>********** Atencion **********<T><BR>+<T>Al Terminar de capturar la forma de pago y el monto, avance con la tecla F12 para Afectar el Movimiento, Si el Movimiento es MultiMoneda y vas a ingresar algún registro deberas seleccionar la Cuenta de Dinero de la otra Moneda presionando F1(Principal), seguido de F2(MultiMoneda), y elige la Cuenta de la Multimoneda, porteriormente selecciona la Forma Pago que corresponda, así como el Importe.<T>)<BR><BR>Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR><BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>/*Asigna(Ver.Saldo, TextoEnLista(Temp.Reg[10]))*/<BR><BR>SI(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR><BR><BR><BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR><BR>Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>Asigna(Info.CtaCaja,Temp.Reg[18])<BR>Asigna(Info.Grupo,Temp.Reg[19])<BR><BR><BR>Si<BR>  ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>Fin<BR><BR><BR><BR><BR>/*Cuando hay una expresion de regreso la ejecuta*/<BR>Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>Si ConDatos(Ver.Expresion)<BR>Entonces Reexpresa( Ver.Expresion )<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR><BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR><BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>SI(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>Fin<BR><BR>Asigna(Ver.Expresion, Nulo)<BR><BR>Si Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>Entonces<BR>FormaModal(<T>POSPesar<T>)<BR>EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>Fin<BR><BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[Campos.Columnas]
Articulo=114
SubCuenta=115
Precio=86
DescuentoLinea=96
Cantidad=79













































FormaPago=171
Importe=114
Referencia=177
Opcion=124
ArtSubCuenta=237
Componente=213
[FormaExtraValor.Columnas]
VerCampo=370
VerValor=370

[SituacionCta.Columnas]
0=188
1=148
2=-2
3=-2
4=-2

[(Carpeta Abrir).Columnas]
0=106
1=283



































































































































































[Foto.ListaEnCaptura]
(Inicio)=Ver.FormasPago
Ver.FormasPago=Ver.Imagen
Ver.Imagen=(Fin)












































[DescripcionSaldo.ListaEnCaptura]
(Inicio)=Ver.Memo
Ver.Memo=Ver.Saldo
Ver.Saldo=(Fin)


















[Imagen.Ver.Imagen]
Carpeta=Imagen
Clave=Ver.Imagen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco































































[Hoja.Columnas]
Mov=124
MovID=124
FechaEmision=94
Importe=64



















































































Cliente=64


















[UsoServicio.Columnas]
Servicio=293
Fecha=94
Porcentaje=38
Evaluacion=87
Observaciones=189




















































































































































































































































































































































































[Acciones.Encabezado.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=FormaModal(<T>POSL<T>)<BR><BR>Asigna(Info.Codigo, Nulo)<BR><BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo))<BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>Si ConDatos(Info.Observaciones)<BR>  Entonces Error( Info.Observaciones )<BR>Sino <T><T>                                                                                                             <BR>  Fin<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR><BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen,Temp.Reg[11])
[Acciones.Encabezado.Forma]
Nombre=Forma
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S








































[Acciones.POSMonedero.POSMonedero]
Nombre=POSMonedero
Boton=0
TipoAccion=Formas
ClaveAccion=POSMonedero
Activo=S
Visible=S

[Acciones.POSMonedero.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR><BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR><BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>/*Asigna(Ver.Saldo, TextoEnLista(Temp.Reg[10]))*/<BR><BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Ver.Imagen,Temp.Reg[11])

[POSArtJuegoComponente.Columnas]
Componente=205
ArtSubCuenta=473










































































































































































[Logo.Info.POSLogo]
Carpeta=Logo
Clave=Info.POSLogo
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=10x10
ColorFondo=Blanco



































SinRecapitular=N













[POSOfertaTemp.Columnas]
0=135
1=96
2=103
3=84
4=66
5=78
6=105


[POSLDenominacion.Columnas]
Denominacion=138
Cantidad=70















































TotalDenominacion=97
















Nombre=304






[POSLDenominacionTemp.Columnas]
Cantidad=70
Nombre=207
Denominacion=138
TotalDenominacion=97


















[POSOfertaTempD.Columnas]
Articulo=124
Precio=64
Puntos=83
CantidadO=86
CantidadM=101
PuntosUsar=82
ImporteTotal=69





























[POSOfertaTempCancelacion.Columnas]
0=135
1=96
2=103
3=84
4=66
5=78
6=105










[Acciones.POSMonedero.ListaAccionesMultiples]
(Inicio)=POSMonedero
POSMonedero=Expresion
Expresion=(Fin)































































































































































































































































































































































































































































































































































[Detalle.Columnas]
Articulo=87
Cantidad=48
Precio=77
DescuentoLinea=36
Importe=87



CantidadNeta=47














































Codigo=97
ClaveIdioma=74
SustitutoArticulo=76
SustitutoSubCuenta=71
Espacio=42
PesoTotal=50
VolumenTotal=54
Unidad=41
CantidadInventario=54
CantidadInvNeta=53
Horas=32
DescuentoImporte=54
PrecioMoneda=48
PrecioTipoCambio=64
FechaRequerida=88
TipoImpuesto1=70
Impuesto1=35
SubImpuesto1=74
TipoImpuesto2=72
Impuesto2=42
SubImpuesto2=72
TipoImpuesto3=83
Impuesto3=64
SubImpuesto3=76
ContUso=76
ContUso2=124
ContUso3=124
ProveedorRef=57
Costo=76
CostoTotal=77
Paquete=45
AutoLocalidad=68
DescripcionExtra=245
CantidadReservada=57
CantidadOrdenada=52
CantidadPendiente=53
ServicioNumero=54
Estado=85
CantidadA=47
Establecimiento=124
VigenteA=112




































































































































































SubCuenta=99
































































































































































































































































































[POSVentaPedidoTemp.Columnas]
0=93
1=115
2=-2
3=157



































































[POSCxcAnticipoTemp.Columnas]
FechaEmision=94
Referencia=173
Concepto=210
AnticipoSaldo=71
Moneda=64
AnticipoAplicar=77































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































[Acciones.Afectar.Afectar]
Nombre=Afectar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Ver.Expresion, nulo)<BR>Asigna(Info.POSMensajeError,nulo)<BR>Asigna(Info.MovClaveAfecta, SQL(<T>SELECT mt.Clave FROM POSL p INNER JOIN MovTipo mt ON p.Mov = mt.Mov AND mt.Modulo = :tPOS WHERE p.ID = :tID<T>, <T>POS<T>, Info.IDTexto))<BR>Asigna(Info.Mensaje,Nulo)<BR>Asigna(Info.IDTextoAnterior, Info.IDTexto)<BR>Asigna(Info.POSMonedero,Nulo)<BR>EjecutarSQL(<T>spPOSOfertaPuntosImporte :tEmpresa,:nEstacion,:tID<T>,Empresa, EstacionTrabajo, Info.IDTexto)<BR>Asigna(Info.POSRedondeo, SQL(<T>EXEC spPOSVentaInsertaRedondeo :tID, :tTipo<T>, Info.IDTexto, <T>SUGERIR<T>))<BR>Asigna(Info.POSRedondeo2,0.0)<BR>EjecutarSQL(<T>spPOSVentaInsertaRedondeo :tID,:tTipo,:nImporte<T>,Info.IDTexto,<T>ELIMINAR COBRO<T>,Nulo)<BR>Asigna(Info.Acumulativa,SQL(<T>SELECT RedondeoVenta FROM POSCfg WHERE Empresa = :tEmpresa<T>,Empresa))<BR>Asigna(Info.Codigo, SQL(<T>SELECT Codigo FROM CB WHERE Accion = :tAccion<T>, <T>CONCLUIR MOVIMIENTO<T>))<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tFormaCambio, :nCambio, :nCobro, :nLecturaTarjeta, :tCliente, :tMonedero<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto, Info.Importe, Info.FormaPagoCambio, Info.Cambio, 0, Nulo, Nulo, Info.POSMonedero))<BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Info.POSImporteOferta,Nulo)<BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR>Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR><BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>Si<BR>  ConDatos(Info.Observaciones)<BR>Entonces<BR>  Asigna(Info.POSMensajeError,SQL(<T>spPOSChecarAperturaCorte :tID, :tEmpresa, :nSucursal, :tMensaje<T>, Info.IDTexto, Empresa, Sucursal, Info.Observaciones))<BR>  Si<BR>    ConDatos(Info.POSMensajeError)<BR>  Entonces<BR>      Informacion(Info.POSMensajeError)<BR>      AbortarOperacion<BR>  Sino<BR>    <T><T><BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR><BR>Si<BR>  ConDatos(Ver.Expresion)<BR>Entonces <BR>  Reexpresa(Ver.Expresion)<BR>Fin<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, <T>********** Atencion **********<T><BR>+<T>Al Terminar de capturar la forma de pago y el monto, avance con la tecla F12 para Afectar el Movimiento, Si el Movimiento es MultiMoneda y vas a ingresar algún registro deberas seleccionar la Cuenta de Dinero de la otra Moneda presionando F1(Principal), seguido de F2(MultiMoneda), y elige la Cuenta de la Multimoneda, porteriormente selecciona la Forma Pago que corresponda, así como el Importe..<T>)<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Expresion, nulo)
[Acciones.Afectar.ValidarSeries]
Nombre=ValidarSeries
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

ConCondicion=S



EjecucionConError=S





































EjecucionCondicion=Asigna(Temp.Logico,SQL(<T>SELECT dbo.fnPOSValidaSerieLote(:tID)<T>,Info.IDTexto))<BR>No(Temp.Logico)
EjecucionMensaje=<T>Falta Indicar los Numeros de Serie/Lote<T>


[Acciones.Encabezado.ListaAccionesMultiples]
(Inicio)=Forma
Forma=Expresion
Expresion=(Fin)
























































































































































































































































[MovCaja.Columnas]
0=164





Accion=168












1=199
[Acciones.Expresion]
Nombre=Expresion
Boton=0
NombreDesplegar=Expresion
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
RefrescarDespues=S




















Expresion=Asigna( Info.Codigo,POSMuestraAccionesCaja:Codigo )
[MovCaja.ListaEnCaptura]
(Inicio)=Codigo
Codigo=Accion
Accion=(Fin)












[MovPos.Accion]
Carpeta=MovPos
Clave=Accion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco



[MovPos.Columnas]
0=139
1=143




2=-2

[Saldo.Info.CodigoFormaPago]
Carpeta=Saldo
Clave=Info.CodigoFormaPago
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Saldo.Info.Importe]
Carpeta=Saldo
Clave=Info.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

AccionAlEnter=Afectar
[Saldo.Ver.Cambio]
Carpeta=Saldo
Clave=Ver.Cambio
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco













[MovPos.ListaEnCaptura]
(Inicio)=Codigo
Codigo=Accion
Accion=(Fin)







[Saldo.ListaEnCaptura]
(Inicio)=Info.CodigoFormaPago
Info.CodigoFormaPago=Info.Importe
Info.Importe=Ver.Cambio
Ver.Cambio=(Fin)



















[Saldo.Ver.Saldo]
Carpeta=Saldo
Clave=Ver.Saldo
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=11
ColorFondo=Negro



AccionAlEnter=BuscarArticulo
ColorFuente=Lima






























AccionAlEnterBloquearAvance=N




EditarConBloqueo=S







[Total.Info.Importe]
Carpeta=Total
Clave=Info.Importe
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
AccionAlEnter=Afectar
Tamano=11
ColorFondo=Negro





AccionAlEnterBloquearAvance=N


ColorFuente=Lima































































[MovCaja.Accion]
Carpeta=MovCaja
Clave=Accion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.Expresion1]
Nombre=Expresion1
Boton=0
NombreDesplegar=Expresion
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S







RefrescarDespues=S


Expresion=Asigna( Info.Codigo,POSMuestraAccionesPos:Codigo )
























































[Codigo.Info.Importe]
Carpeta=Codigo
Clave=Info.Importe
Editar=S
LineaNueva=N
ValidaNombre=N
3D=N
AccionAlEnter=Afectar
Tamano=-1
ColorFondo=$00FFE8E8















































ColorFuente=Rojo obscuro

Pegado=S

[Acciones.Cerrar.expresion]
Nombre=expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=EjecutarSQL( <T>spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto )<BR>  Asigna(Info.Codigo, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>ELIMINAR MOVIMIENTO<T>))<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  SI(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR> Forma.Accion( <T>Eliminar<T> )

[Acciones.Afectar.ActualizaTicket]
Nombre=ActualizaTicket
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=Asigna(Ver.Ticket, <T><T>)
ConCondicion=S
EjecucionCondicion=Vacio(Info.POSMensajeError)
[Acciones.Concepto]
Nombre=Concepto
Boton=0
NombreDesplegar=&Introduce Concepto
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S








































Menu=Principal
Expresion=Si<BR>  SQL(<T>SELECT 1 FROM POSUsuarioAccion WHERE Usuario = :tUsuario AND Accion = :tAccion<T>, Usuario, <T>INTRODUCIR CONCEPTODIN<T>) = 1<BR>Entonces<BR>  Asigna(Temp.TextoTemp02, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>INTRODUCIR CONCEPTODIN<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp02, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Temp.TextoTemp02, nulo)<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso a la acción<T>)<BR>Fin
[Ticket.ListaEnCaptura]
(Inicio)=Ver.Ticket
Ver.Ticket=Ver.Aviso
Ver.Aviso=(Fin)







[Aviso]
Estilo=Ficha
Clave=Aviso
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=C1
Vista=(Variables)
Fuente={Tahoma, 10, Negro, []}
CampoColorLetras=$008080FF
CampoColorFondo=$00FFFF80
ListaEnCaptura=Ver.Aviso
CarpetaVisible=S

FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaColorFondo=$00804000
AlinearTodaCarpeta=S





































ConFuenteEspecial=S

BarraBotones=S
BarraBtnFuente={Segoe UI, 10, Blanco, []}
BarraBtnFondo=$00804000
BarraBtnPosicion=Abajo
BarraBtnSize=80
BarraBtnSeparacion=2
BarraBtnBisel=0
BarraBtnPaginas=5
ListaAccionesBB=(Lista)
BarraBtnSinBisel=S
FichaMarco=S

[MensajeMultimoneda]
Estilo=Ficha
Clave=MensajeMultimoneda
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=(Variables)
Fuente={Segoe UI, 10, Rojo obscuro, []}
CampoColorLetras=$008080FF
CampoColorFondo=$00FFFF80
ListaEnCaptura=Ver.Memo
CarpetaVisible=S

FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaColorFondo=$00FFFFD9
AlinearTodaCarpeta=S

FichaNombres=Izquierda
FichaAlineacion=Izquierda
ConFuenteEspecial=S

[MensajeMultimoneda.Ver.Memo]
Carpeta=MensajeMultimoneda
Clave=Ver.Memo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=N
Tamano=20
ColorFondo=$00FFFF80

















ColorFuente=$008080FF


































[Acciones.CtaMutimoneda.expresion]
Nombre=expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, <T>CTADINERO<T>, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR> // Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Ver.Memo, <T>En los Movimientos Mutimoneda recuerde capturar en la Apertura de Caja la Cuenta de Dinero Multimoneda y la Forma de Pago Utilizando la Tecla F2...<T>)<BR><BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[Acciones.CtaMutimoneda.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.CtaMutimoneda.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S


















[POSCBFormaPago.Columnas]
Codigo=274







0=-2

FormaPago=172

[Acciones.Nuevo]
Nombre=Nuevo
Boton=0
NombreDesplegar=Nuevo
TipoAccion=Expresion
Activo=S
Visible=S





Expresion=Asigna(Info.Estatus,SQL(<T>SELECT Estatus FROM POSL WHERE ID = :tID<T>,Info.IDTexto))<BR>Si<BR>  Info.Estatus = Estatuspendiente<BR>Entonces<BR>  Asigna(Ver.Aviso,TextoEnLista(<T>Es Necesario Concluir o Eliminar El Movimiento<T>))<BR>Sino<BR>  Asigna(Info.Codigo, SQL(<T>SELECT MAX(Codigo) FROM CB WHERE Accion = :tAccion<T>, <T>MOVIMIENTO NUEVO<T>))<BR><BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>,<BR>                      EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>  Si ConDatos(Info.Observaciones)<BR>    Entonces Error( Info.Observaciones )<BR>  Sino <T><T><BR>  Fin<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR><BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8]),<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen, Temp.Reg[11] )<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)









[Acciones.Cerrar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S


[Acciones.Eliminar]
Nombre=Eliminar
Boton=0
NombreDesplegar=Eliminar
TipoAccion=Expresion
Activo=S
Visible=S





Expresion=  Asigna(Info.Codigo, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>ELIMINAR MOVIMIENTO<T>))<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  SI(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])








[Acciones.CtaMutimoneda.ListaAccionesMultiples]
(Inicio)=expresion
expresion=Actualizar Vista
Actualizar Vista=Actualizar Forma
Actualizar Forma=(Fin)

































































































































































































[Acciones.Cerrar.ListaAccionesMultiples]
(Inicio)=expresion
expresion=Cerrar
Cerrar=(Fin)










































































































































[Acciones.Afectar.ListaAccionesMultiples]
(Inicio)=ValidarSeries
ValidarSeries=Afectar
Afectar=ActualizaTicket
ActualizaTicket=Cerrar
Cerrar=(Fin)



































[Acciones.Regresar]
Nombre=Regresar
Boton=0
NombreEnBoton=S
TeclaFuncion=ESC
NombreDesplegar=Regresar
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S
BarraBtnAncho=72
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













[Codigo.ListaEnCaptura]
(Inicio)=Info.Codigo
Info.Codigo=Info.Importe
Info.Importe=(Fin)

























[Acciones.Separador1]
Nombre=Separador1
Boton=0
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
Activo=S
Visible=S
BarraBtnAncho=72
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
TipoAccion=Expresion
Expresion=BarraIrPagina(<T>Aviso<T>,2)
[Acciones.MenuEspecial]
Nombre=MenuEspecial
Boton=0
NombreEnBoton=S
TeclaFuncion=F2
NombreDesplegar=<T>Especial<T>
Activo=S
Visible=S
BarraBtnAncho=72
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

TipoAccion=Expresion
Expresion=BarraIrPagina(<T>Aviso<T>,3)
[Acciones.MenuBancos]
Nombre=MenuBancos
Boton=0
NombreEnBoton=S
TeclaFuncion=F3
NombreDesplegar=Bancos
Activo=S
Visible=S
BarraBtnAncho=72
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

TipoAccion=Expresion
Expresion=BarraIrPagina(<T>Aviso<T>,4)
[Acciones.MenuVales]
Nombre=MenuVales
Boton=0
NombreEnBoton=S
TeclaFuncion=F4
NombreDesplegar=<T>Vales<T>
Activo=S
Visible=S
BarraBtnAncho=72
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





















TipoAccion=Expresion
Expresion=BarraIrPagina(<T>Aviso<T>,5)

[Acciones.FormaPago2]
Nombre=FormaPago2
Boton=0
NombreEnBoton=S
TeclaFuncion=F5
NombreDesplegar=Info.POSFormaPago2
Activo=S
Visible=S
BarraBtnAncho=72
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





TipoAccion=Expresion
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(F2, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])   <BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[Acciones.FormaPago3]
Nombre=FormaPago3
Boton=0
NombreEnBoton=S
TeclaFuncion=F6
NombreDesplegar=Info.POSFormaPago3
Activo=S
Visible=S
BarraBtnAncho=72
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

TipoAccion=Expresion
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(F3, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])   <BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[Acciones.FormaPago4]
Nombre=FormaPago4
Boton=0
NombreEnBoton=S
TeclaFuncion=F7
NombreDesplegar=Info.POSFormaPago4
Activo=S
Visible=S
BarraBtnAncho=72
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


TipoAccion=Expresion
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(F4, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])   <BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[Acciones.FormaPago5]
Nombre=FormaPago5
Boton=0
NombreEnBoton=S
TeclaFuncion=F8
NombreDesplegar=Info.POSFormaPago5
Activo=S
Visible=S
BarraBtnAncho=72
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





TipoAccion=Expresion
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(F5, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])   <BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[Acciones.Separador3]
Nombre=Separador3
Boton=0
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=1





[Acciones.Multimoneda]
Nombre=Multimoneda
Boton=0
NombreEnBoton=S
TeclaFuncion=F2
NombreDesplegar=<T>Multi<BR>Moneda<T>
Multiple=S
Activo=S
BarraBtnAncho=72
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













ListaAccionesMultiples=(Lista)
VisibleCondicion=Pos.MultiMoneda
[Acciones.ReversaCobro]
Nombre=ReversaCobro
Boton=0
NombreEnBoton=S
TeclaFuncion=F3
NombreDesplegar=&Reversar Pago
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=72
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





Expresion=Si<BR>  SQL(<T>SELECT 1 FROM POSUsuarioAccion WHERE Usuario = :tUsuario AND Accion = :tAccion<T>, Usuario, <T>REVERSAR COBRO<T>) = 1<BR>Entonces<BR>  Asigna(Temp.TextoTemp02, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>REVERSAR COBRO<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp02, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  //Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Temp.TextoTemp02, nulo)<BR>  Forma(<T>POSCBFormaPagoRC<T>)<BR>  Forma.Accion(<T>Enter<T>)<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso a la acción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)<BR>Asigna(Ver.Memo, <T>Ingrese la Forma de Pago y el Importe o seleccione la el boton Cancelar para regresar al Menu Principal...<T>)
[Acciones.Cancelar]
Nombre=Cancelar
Boton=0
NombreEnBoton=S
TeclaFuncion=F11
NombreDesplegar=<T>Cancelar<T>
Multiple=S
Activo=S
Visible=S
BarraBtnAncho=72
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
ConCondicion=S
EjecucionCondicion=SQL(<T>SELECT ISNULL(SUM(ISNULL(Importe,0)),0) FROM POSLCObro pc WHERE pc.ID =:tID<T>, Info.IDTexto) = 0
EjecucionMensaje=<T>El movimiento tiene aplicaciones. Tiene que concluirlo o reversar el pago, verifique...<T>
EjecucionConError=S
[Acciones.Afecta]
Nombre=Afecta
Boton=0
NombreEnBoton=S
TeclaFuncion=F12
NombreDesplegar=<T>Afectar<BR>Movimiento<T>
Activo=S
Visible=S
BarraBtnAncho=72
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






ConCondicion=S
EjecucionConError=S
Multiple=S
ListaAccionesMultiples=(Lista)
EjecucionCondicion=Asigna(Info.Cerrado,SQL(<T>SELECT dbo.fnPOSEstatusCajaBloqueada(:tCaja)<T>,Info.CtaCaja))<BR>NO(Info.Cerrado)
EjecucionMensaje=<T>Caja bloqueada<T>
[Acciones.IntroduceConcepto]
Nombre=IntroduceConcepto
Boton=0
NombreEnBoton=S
TeclaFuncion=F1
NombreDesplegar=<T>Introduce Concepto<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=72
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














Expresion=Si<BR>  SQL(<T>SELECT 1 FROM POSUsuarioAccion WHERE Usuario = :tUsuario AND Accion = :tAccion<T>, Usuario, <T>INTRODUCIR CONCEPTODIN<T>) = 1<BR>Entonces<BR>  Asigna(Temp.TextoTemp02, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>INTRODUCIR CONCEPTODIN<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp02, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Temp.TextoTemp02, nulo)<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso a la acción<T>)<BR>Fin
[Acciones.BancosA01]
Nombre=BancosA01
Boton=0
NombreEnBoton=S
TeclaFuncion=F1
Activo=S
Visible=S
BarraBtnAncho=72
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

NombreDesplegar=Info.BancoA01
TipoAccion=Expresion
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoA01, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin
[Acciones.Separador1P3]
Nombre=Separador1P3
Boton=0
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=3









[Acciones.BancosA02]
Nombre=BancosA02
Boton=0
NombreEnBoton=S
TeclaFuncion=F2
NombreDesplegar=Info.BancoA02
Activo=S
Visible=S
BarraBtnAncho=72
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
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoA02, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin
[Acciones.BancosA03]
Nombre=BancosA03
Boton=0
NombreEnBoton=S
TeclaFuncion=F3
NombreDesplegar=Info.BancoA03
Activo=S
Visible=S
BarraBtnAncho=72
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
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoA03, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin
[Acciones.BancosA04]
Nombre=BancosA04
Boton=0
NombreEnBoton=S
TeclaFuncion=F4
NombreDesplegar=Info.BancoA04
Activo=S
Visible=S
BarraBtnAncho=72
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
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoA04, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin
[Acciones.Separador2P3]
Nombre=Separador2P3
Boton=0
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=3

[Acciones.BancosA05]
Nombre=BancosA05
Boton=0
NombreEnBoton=S
TeclaFuncion=F5
NombreDesplegar=Info.BancoA05
Activo=S
Visible=S
BarraBtnAncho=72
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
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoA05, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin
[Acciones.BancosA06]
Nombre=BancosA06
Boton=0
NombreEnBoton=S
TeclaFuncion=F6
NombreDesplegar=Info.BancoA06
Activo=S
Visible=S
BarraBtnAncho=72
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
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoA06, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin
[Acciones.BancosA07]
Nombre=BancosA07
Boton=0
NombreEnBoton=S
TeclaFuncion=F7
NombreDesplegar=Info.BancoA07
Activo=S
Visible=S
BarraBtnAncho=72
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
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoA07, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin
[Acciones.BancosA08]
Nombre=BancosA08
Boton=0
NombreEnBoton=S
TeclaFuncion=F8
NombreDesplegar=Info.BancoA08
Activo=S
Visible=S
BarraBtnAncho=72
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
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoA08, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin
[Acciones.BancosB01]
Nombre=BancosB01
Boton=0
NombreEnBoton=S
TeclaFuncion=F1
NombreDesplegar=Info.BancoB01
Activo=S
Visible=S
BarraBtnAncho=72
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F1.png
BarraBtnPagina=4
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado





TipoAccion=Expresion
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoB01, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin
[Acciones.BancosB02]
Nombre=BancosB02
Boton=0
NombreEnBoton=S
TeclaFuncion=F2
NombreDesplegar=Info.BancoB02
Activo=S
Visible=S
BarraBtnAncho=72
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

TipoAccion=Expresion
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoB02, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin
[Acciones.BancosB03]
Nombre=BancosB03
Boton=0
NombreEnBoton=S
TeclaFuncion=F3
NombreDesplegar=Info.BancoB03
Activo=S
Visible=S
BarraBtnAncho=72
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

TipoAccion=Expresion
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoB03, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin
[Acciones.BancosB04]
Nombre=BancosB04
Boton=0
NombreEnBoton=S
TeclaFuncion=F4
NombreDesplegar=Info.BancoB04
Activo=S
Visible=S
BarraBtnAncho=72
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





TipoAccion=Expresion
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoB04, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin
[Acciones.RegresarP5]
Nombre=RegresarP5
Boton=0
NombreEnBoton=S
TeclaFuncion=ESC
NombreDesplegar=<T>Regresar<T>
TipoAccion=Expresion
Expresion=BarraIrPagina(<T>Aviso<T>,1)
Activo=S
Visible=S
BarraBtnAncho=72
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

[Acciones.RegresarP4]
Nombre=RegresarP4
Boton=0
NombreEnBoton=S
TeclaFuncion=ESC
NombreDesplegar=Regresar
TipoAccion=Expresion
Expresion=BarraIrPagina(<T>Aviso<T>,1)
Activo=S
Visible=S
BarraBtnAncho=72
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

[Acciones.RegresarP3]
Nombre=RegresarP3
Boton=0
NombreEnBoton=S
TeclaFuncion=ESC
NombreDesplegar=<T>Regresar<T>
TipoAccion=Expresion
Expresion=BarraIrPagina(<T>Aviso<T>,1)
Activo=S
Visible=S
BarraBtnAncho=72
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

[Acciones.Separador1P2]
Nombre=Separador1P2
Boton=0
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=2

[Acciones.RegresarP2]
Nombre=RegresarP2
Boton=0
NombreEnBoton=S
TeclaFuncion=ESC
NombreDesplegar=<T>Regresar<T>
TipoAccion=Expresion
Expresion=BarraIrPagina(<T>Aviso<T>,1)
Activo=S
Visible=S
BarraBtnAncho=72
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

[Acciones.Separador1P4]
Nombre=Separador1P4
Boton=0
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=4

[Acciones.Separador2P4]
Nombre=Separador2P4
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
BarraBtnAncho=72
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

TipoAccion=Expresion
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoB05, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin
[Acciones.BancosB06]
Nombre=BancosB06
Boton=0
NombreEnBoton=S
TeclaFuncion=F6
NombreDesplegar=Info.BancoB06
Activo=S
Visible=S
BarraBtnAncho=72
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

TipoAccion=Expresion
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoB06, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin
[Acciones.BancosB07]
Nombre=BancosB07
Boton=0
NombreEnBoton=S
TeclaFuncion=F7
NombreDesplegar=Info.BancoB07
Activo=S
Visible=S
BarraBtnAncho=72
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

TipoAccion=Expresion
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoB07, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin
[Acciones.BancosB08]
Nombre=BancosB08
Boton=0
NombreEnBoton=S
TeclaFuncion=F8
NombreDesplegar=Info.BancoB08
Activo=S
Visible=S
BarraBtnAncho=72
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





TipoAccion=Expresion
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoB08, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin
[Acciones.BancosC01]
Nombre=BancosC01
Boton=0
NombreEnBoton=S
TeclaFuncion=F1
NombreDesplegar=Info.BancoC01
Activo=S
Visible=S
BarraBtnAncho=72
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





TipoAccion=Expresion
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoC01, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin
[Acciones.BancosC02]
Nombre=BancosC02
Boton=0
NombreEnBoton=S
TeclaFuncion=F2
NombreDesplegar=Info.BancoC02
Activo=S
Visible=S
BarraBtnAncho=72
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
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoC02, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin
[Acciones.BancosC03]
Nombre=BancosC03
Boton=0
NombreEnBoton=S
TeclaFuncion=F3
NombreDesplegar=Info.BancoC03
Activo=S
Visible=S
BarraBtnAncho=72
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
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoC03, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin
[Acciones.BancosC04]
Nombre=BancosC04
Boton=0
NombreEnBoton=S
TeclaFuncion=F4
NombreDesplegar=Info.BancoC04
Activo=S
Visible=S
BarraBtnAncho=72
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
BarraBtnTxtAlign=Centrado

BarraBtnTxtPos=Abajo
TipoAccion=Expresion
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoC04, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin
[Acciones.Separador1P5]
Nombre=Separador1P5
Boton=0
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=1

[Acciones.Separador2P5]
Nombre=Separador2P5
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
BarraBtnAncho=72
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
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoC05, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin
[Acciones.BancosC06]
Nombre=BancosC06
Boton=0
NombreEnBoton=S
TeclaFuncion=F6
NombreDesplegar=Info.BancoC06
Activo=S
Visible=S
BarraBtnAncho=72
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
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoC06, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin
[Acciones.BancosC07]
Nombre=BancosC07
Boton=0
NombreEnBoton=S
TeclaFuncion=F7
NombreDesplegar=Info.BancoC07
Activo=S
Visible=S
BarraBtnAncho=72
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
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoC07, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin
[Acciones.BancosC08]
Nombre=BancosC08
Boton=0
NombreEnBoton=S
TeclaFuncion=F8
NombreDesplegar=Info.BancoC08
Activo=S
Visible=S
BarraBtnAncho=72
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
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoC08, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin
[Acciones.Multimoneda.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, <T>CTADINERO<T>, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR> // Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Ver.Memo, <T>En los Movimientos Mutimoneda recuerde capturar en la Apertura de Caja la Cuenta de Dinero Multimoneda y la Forma de Pago Utilizando la Tecla F2...<T>)<BR><BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
Activo=S
Visible=S

[Acciones.Multimoneda.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.Multimoneda.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S


[Acciones.Afecta.ValidarSerie]
Nombre=ValidarSerie
Boton=0
TipoAccion=Expresion
Activo=S
ConCondicion=S
EjecucionCondicion=Asigna(Temp.Logico,SQL(<T>SELECT dbo.fnPOSValidaSerieLote(:tID)<T>,Info.IDTexto))<BR>No(Temp.Logico)
EjecucionMensaje=<T>Falta indicar los números de Serie/Lote<T>
EjecucionConError=S
Visible=S

[Acciones.Afecta.Afectar]
Nombre=Afectar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Ver.Expresion, nulo)<BR>Asigna(Info.POSMensajeError,nulo)<BR>Asigna(Info.MovClaveAfecta, SQL(<T>SELECT mt.Clave FROM POSL p INNER JOIN MovTipo mt ON p.Mov = mt.Mov AND mt.Modulo = :tPOS WHERE p.ID = :tID<T>, <T>POS<T>, Info.IDTexto))<BR>Asigna(Info.Mensaje,Nulo)<BR>Asigna(Info.IDTextoAnterior, Info.IDTexto)<BR>Asigna(Info.POSMonedero,Nulo)<BR>EjecutarSQL(<T>spPOSOfertaPuntosImporte :tEmpresa,:nEstacion,:tID<T>,Empresa, EstacionTrabajo, Info.IDTexto)<BR>Asigna(Info.POSRedondeo, SQL(<T>EXEC spPOSVentaInsertaRedondeo :tID, :tTipo<T>, Info.IDTexto, <T>SUGERIR<T>))<BR>Asigna(Info.POSRedondeo2,0.0)<BR>EjecutarSQL(<T>spPOSVentaInsertaRedondeo :tID,:tTipo,:nImporte<T>,Info.IDTexto,<T>ELIMINAR COBRO<T>,Nulo)<BR>Asigna(Info.Acumulativa,SQL(<T>SELECT RedondeoVenta FROM POSCfg WHERE Empresa = :tEmpresa<T>,Empresa))<BR>Asigna(Info.Codigo, SQL(<T>SELECT Codigo FROM CB WHERE Accion = :tAccion<T>, <T>CONCLUIR MOVIMIENTO<T>))<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tFormaCambio, :nCambio, :nCobro, :nLecturaTarjeta, :tCliente, :tMonedero<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto, Info.Importe, Info.FormaPagoCambio, Info.Cambio, 0, Nulo, Nulo, Info.POSMonedero))<BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Info.POSImporteOferta,Nulo)<BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR>Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR><BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>Si<BR>  ConDatos(Info.Observaciones)<BR>Entonces<BR>  Asigna(Info.POSMensajeError,SQL(<T>spPOSChecarAperturaCorte :tID, :tEmpresa, :nSucursal, :tMensaje<T>, Info.IDTexto, Empresa, Sucursal, Info.Observaciones))<BR>  Si<BR>    ConDatos(Info.POSMensajeError)<BR>  Entonces<BR>      Informacion(Info.POSMensajeError)<BR>      AbortarOperacion<BR>  Sino<BR>    <T><T><BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR><BR>Si<BR>  ConDatos(Ver.Expresion)<BR>Entonces<BR>  Reexpresa(Ver.Expresion)<BR>Fin<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, <T>********** Atencion **********<T><BR>+<T>Al Terminar de capturar la forma de pago y el monto, avance con la tecla F12 para Afectar el Movimiento, Si el Movimiento es MultiMoneda y vas a ingresar algún registro deberas seleccionar la Cuenta de Dinero de la otra Moneda presionando F1(Principal), seguido de F2(MultiMoneda), y elige la Cuenta de la Multimoneda, porteriormente selecciona la Forma Pago que corresponda, así como el Importe.<T>)<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Expresion, nulo)
[Acciones.Afecta.ActualizarTicket]
Nombre=ActualizarTicket
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Ver.Ticket, <T><T>)
Activo=S
ConCondicion=S
EjecucionCondicion=Vacio(Info.POSMensajeError)
Visible=S

[Acciones.Afecta.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
ConCondicion=S
EjecucionCondicion=Vacio(Info.POSMensajeError)
Visible=S







[Acciones.Afecta.ValidarSeries]
Nombre=ValidarSeries
Boton=0
TipoAccion=Expresion
Activo=S
ConCondicion=S
EjecucionCondicion=Asigna(Temp.Logico,SQL(<T>SELECT dbo.fnPOSValidaSerieLote(:tID)<T>,Info.IDTexto))<BR>No(Temp.Logico)
EjecucionMensaje=<T>Falta indicar los números de Serie/Lote<T>
EjecucionConError=S
Visible=S









[Acciones.Afecta.Afecta]
Nombre=Afecta
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S






Expresion=Asigna(Ver.Expresion, nulo)<BR>Asigna(Info.POSMensajeError,nulo)<BR>Asigna(Info.MovClaveAfecta, SQL(<T>SELECT mt.Clave FROM POSL p INNER JOIN MovTipo mt ON p.Mov = mt.Mov AND mt.Modulo = :tPOS WHERE p.ID = :tID<T>, <T>POS<T>, Info.IDTexto))<BR>Asigna(Info.Mensaje,Nulo)<BR>Asigna(Info.IDTextoAnterior, Info.IDTexto)<BR>Asigna(Info.POSMonedero,Nulo)<BR>EjecutarSQL(<T>spPOSOfertaPuntosImporte :tEmpresa,:nEstacion,:tID<T>,Empresa, EstacionTrabajo, Info.IDTexto)<BR>Asigna(Info.POSRedondeo, SQL(<T>EXEC spPOSVentaInsertaRedondeo :tID, :tTipo<T>, Info.IDTexto, <T>SUGERIR<T>))<BR>Asigna(Info.POSRedondeo2,0.0)<BR>EjecutarSQL(<T>spPOSVentaInsertaRedondeo :tID,:tTipo,:nImporte<T>,Info.IDTexto,<T>ELIMINAR COBRO<T>,Nulo)<BR>Asigna(Info.Acumulativa,SQL(<T>SELECT RedondeoVenta FROM POSCfg WHERE Empresa = :tEmpresa<T>,Empresa))<BR>Asigna(Info.Codigo, SQL(<T>SELECT Codigo FROM CB WHERE Accion = :tAccion<T>, <T>CONCLUIR MOVIMIENTO<T>))<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tFormaCambio, :nCambio, :nCobro, :nLecturaTarjeta, :tCliente, :tMonedero<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto, Info.Importe, Info.FormaPagoCambio, Info.Cambio, 0, Nulo, Nulo, Info.POSMonedero))<BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Info.POSImporteOferta,Nulo)<BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR>Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>Si<BR>  ConDatos(Info.Observaciones)<BR>Entonces<BR>  Asigna(Info.POSMensajeError,SQL(<T>spPOSChecarAperturaCorte :tID, :tEmpresa, :nSucursal, :tMensaje<T>, Info.IDTexto, Empresa, Sucursal, Info.Observaciones))<BR>  Si<BR>    ConDatos(Info.POSMensajeError)<BR>  Entonces<BR>      Informacion(Info.POSMensajeError)<BR>      AbortarOperacion<BR>  Sino<BR>    <T><T><BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR><BR>Si<BR>  ConDatos(Ver.Expresion)<BR>Entonces<BR>  Reexpresa(Ver.Expresion)<BR>Fin<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, <T>********** Atencion **********<T><BR>+<T>Al Terminar de capturar la forma de pago y el monto, avance con la tecla F12 para Afectar el Movimiento, Si el Movimiento es MultiMoneda y vas a ingresar algún registro deberas seleccionar la Cuenta de Dinero de la otra Moneda presionando F1(Principal), seguido de F2(MultiMoneda), y elige la Cuenta de la Multimoneda, porteriormente selecciona la Forma Pago que corresponda, así como el Importe.<T>)<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Expresion, nulo)
[Acciones.Afecta.ActualizaTicket]
Nombre=ActualizaTicket
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Ver.Ticket, <T><T>)
Activo=S
ConCondicion=S
EjecucionCondicion=Vacio(Info.POSMensajeError)
Visible=S






[Acciones.Afecta.Cerrarr]
Nombre=Cerrarr
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
ConCondicion=S
EjecucionCondicion=Vacio(Info.POSMensajeError)
Visible=S


[Acciones.Cancelar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=EjecutarSQL( <T>spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto )<BR>  Asigna(Info.Codigo, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>ELIMINAR MOVIMIENTO<T>))<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  SI(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR> Forma.Accion( <T>Eliminar<T> )
Activo=S
Visible=S

[Acciones.Cancelar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Cancelar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Cerrar
Cerrar=(Fin)






[Acciones.FormaPago6]
Nombre=FormaPago6
Boton=0
Activo=S
Visible=S
BarraBtnFondo=$00C08000
TeclaFuncion=F9
NombreDesplegar=Info.POSFormaPago6
TipoAccion=Expresion
BarraBtnAncho=72
BarraBtnAlto=75
BarraBtnPagina=1
BarraBtnMargen=2
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F9.png
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(F6, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])   <BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)




[Acciones.FormaPago7]
Nombre=FormaPago7
Boton=0
TeclaFuncion=F10
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=$00C08000
edBotonSrc=F10.png
BarraBtnAncho=72
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

NombreDesplegar=Info.POSFormaPago7
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(F7, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])   <BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>Favor introducir el peso<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>Opción vacía, seleccione otra opción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)




























[Acciones.Afecta.ListaAccionesMultiples]
(Inicio)=ValidarSeries
ValidarSeries=Afecta
Afecta=ActualizaTicket
ActualizaTicket=Cerrarr
Cerrarr=(Fin)





[Acciones.Multimoneda.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualizar Vista
Actualizar Vista=Actualizar Forma
Actualizar Forma=(Fin)

[Aviso.ListaAccionesBB]
(Inicio)=Regresar
Regresar=Separador1
Separador1=MenuPrincipal
MenuPrincipal=RegresarP2
RegresarP2=Separador1P2
Separador1P2=IntroduceConcepto
IntroduceConcepto=Multimoneda
Multimoneda=ReversaCobro
ReversaCobro=MenuEspecial
MenuEspecial=RegresarP3
RegresarP3=Separador1P3
Separador1P3=BancosA01
BancosA01=BancosA02
BancosA02=BancosA03
BancosA03=BancosA04
BancosA04=Separador2P3
Separador2P3=BancosA05
BancosA05=BancosA06
BancosA06=BancosA07
BancosA07=BancosA08
BancosA08=MenuBancos
MenuBancos=RegresarP4
RegresarP4=Separador1P4
Separador1P4=BancosB01
BancosB01=BancosB02
BancosB02=BancosB03
BancosB03=BancosB04
BancosB04=Separador2P4
Separador2P4=BancosB05
BancosB05=BancosB06
BancosB06=BancosB07
BancosB07=BancosB08
BancosB08=MenuVales
MenuVales=RegresarP5
RegresarP5=Separador1P5
Separador1P5=BancosC01
BancosC01=BancosC02
BancosC02=BancosC03
BancosC03=BancosC04
BancosC04=Separador2P5
Separador2P5=BancosC05
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
FormaPago7=Cancelar
Cancelar=Afecta
Afecta=(Fin)










[Forma.ListaCarpetas]
(Inicio)=Ticket
Ticket=Codigo
Codigo=MensajeMultimoneda
MensajeMultimoneda=Aviso
Aviso=(Fin)

[Forma.ListaAcciones]
(Inicio)=Concepto
Concepto=Eliminar
Eliminar=Enter
Enter=Nuevo
Nuevo=(Fin)

[Forma.MenuPrincipal]
(Inicio)=Principal
Principal=Especial
Especial=Bancos
Bancos=Vales
Vales=(Fin)
