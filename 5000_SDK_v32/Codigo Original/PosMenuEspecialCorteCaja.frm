
[Forma]
Clave=PosMenuEspecialCorteCaja
Icono=54
Modulos=(Todos)

ListaCarpetas=(Lista)
CarpetaPrincipal=Codigo
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=238
PosicionInicialArriba=0
PosicionInicialAlturaCliente=695
PosicionInicialAncho=890
PosicionSec1=473
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionCol2=917
PosicionSec2=544
PosicionCol3=917
PosicionCol1=917
Menus=S

Nombre=<T>Movimientos Caja<T>
MenuTouchScreen=S
VentanaExclusiva=S
VentanaExclusivaOpcion=0
VentanaSinIconosMarco=S
ExpresionesAlMostrar=Asigna(Info.Empresa, Empresa)<BR>Asigna(Info.Codigo, Nulo)<BR><BR>Asigna(Info.POSFormaPago2,<T>F2<T>+NuevaLinea+SQL(<T>SELECT ISNULL(f.F2,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F2 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago3,<T>F3<T>+NuevaLinea+SQL(<T>SELECT ISNULL(f.F3,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F3 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago4,<T>F4<T>+NuevaLinea+SQL(<T>SELECT ISNULL(f.F4,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F4 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago5,<T>F5<T>+NuevaLinea+SQL(<T>SELECT ISNULL(f.F5,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F5 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago6,<T>F6<T>+NuevaLinea+SQL(<T>SELECT ISNULL(f.F6,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F6 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago7,<T>F7<T>+NuevaLinea+SQL(<T>SELECT ISNULL(f.F7,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F7 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago8,<T>F8<T>+NuevaLinea+SQL(<T>SELECT ISNULL(f.F8,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))<BR><BR>Asigna(Info.BancoA01,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA01,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoA02,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA02,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoA03,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA03,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoA04,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA04,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoA05,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA05,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoA06,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA06,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoA07,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA07,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoA08,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA08,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR><BR>Asigna(Info.BancoB01,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB01,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoB02,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB02,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoB03,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB03,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoB04,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB04,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoB05,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB05,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoB06,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB06,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoB07,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB07,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoB08,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB08,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR><BR>Asigna(Info.BancoC01,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC01,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoC02,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC02,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoC03,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC03,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoC04,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC04,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoC05,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC05,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoC06,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC06,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoC07,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC07,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))<BR>Asigna(Info.BancoC08,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC08,:tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal))
ExpresionesAlCerrar=Asigna(Info.Torreta,SQL(<T>SELECT TieneTorreta FROM POSCfg WHERE Empresa = :tEmpresa<T>,Empresa))<BR>Si<BR>  Info.Torreta<BR>Entonces<BR>   Torreta.Cerrar<BR>Fin<BR><BR>Asigna(Info.POSFormaPago2,SQL(<T>SELECT ISNULL(c.FormaPago,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F2 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago3,SQL(<T>SELECT ISNULL(c.FormaPago,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F3 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago4,SQL(<T>SELECT ISNULL(c.FormaPago,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F4 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago5,SQL(<T>SELECT ISNULL(c.FormaPago,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F5 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago6,SQL(<T>SELECT ISNULL(c.FormaPago,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F6 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago7,SQL(<T>SELECT ISNULL(c.FormaPago,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F7 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago8,SQL(<T>SELECT ISNULL(c.FormaPago,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))
ExpresionesAlActivar=Asigna(Info.Torreta,SQL(<T>SELECT TieneTorreta FROM POSCfg WHERE Empresa = :tEmpresa<T>,Empresa))<BR>Si<BR>  Info.Torreta<BR>Entonces<BR>  Asigna(Info.TorretaPuerto,SQL(<T>SELECT PuertoTorreta FROM POSCfg WHERE Empresa = :tEmpresa<T>,Empresa))<BR>   Torreta.Abrir(Info.TorretaPuerto)<BR>Asigna(Info.TorretaMensaje1,<T>*** BIENVENIDO ***<T>)<BR>Asigna(Info.TorretaPosicion1,<T>Centrado<T>)<BR>Asigna(Info.TorretaMensaje2,NULO))<BR>Asigna(Info.TorretaPosicion2,<T>Derecha<T>)<BR><BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)   <BR>Fin
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
Fuente={Terminal, 12, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
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
Fuente={Terminal, 14, Negro, []}
FichaEspacioEntreLineas=9
FichaEspacioNombres=0
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Lima
CampoColorFondo=$FFFFFFFF
ListaEnCaptura=(Lista)
CarpetaVisible=S

ConFuenteEspecial=S
AlinearTodaCarpeta=S
CampoAccionAlEnter=Cerrar
[Codigo.Info.Codigo]
Carpeta=Codigo
Clave=Info.Codigo
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
AccionAlEnter=Enter
Tamano=80
ColorFondo=$00FFE8E8












AccionAlEnterBloquearAvance=S
OcultaNombre=N
Pegado=N
ConScroll=N
SinRecapitular=N
[Totales.]
Carpeta=Totales
ColorFondo=Negro
ColorFuente=Lima












































































[Aviso.Ver.Aviso]
Carpeta=Aviso
Clave=Ver.Aviso
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=$FFFFFFFF
ColorFuente=Lima
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
ValidaNombre=S
3D=S
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
Expresion=Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR><BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])                  <BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>/*Asigna(Ver.Saldo, TextoEnLista(Temp.Reg[10]))*/<BR><BR>SI(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR><BR><BR><BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR><BR>Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>Asigna(Info.CtaCaja,Temp.Reg[18])<BR>Asigna(Info.Grupo,Temp.Reg[19])<BR><BR><BR>Si<BR>  ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>Fin<BR><BR><BR><BR><BR>/*Cuando hay una expresion de regreso la ejecuta*/<BR>Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>Si ConDatos(Ver.Expresion)<BR>Entonces Reexpresa( Ver.Expresion )<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR><BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR><BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>SI(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>Fin<BR><BR>Asigna(Ver.Expresion, Nulo)<BR><BR>Si Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T> <BR>Entonces <BR>FormaModal(<T>POSPesar<T>)<BR>EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>Fin
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

















[Acciones.Afectar]
Nombre=Afectar
Boton=0
TeclaFuncion=F12
NombreDesplegar=F12<BR>Afectar Movimiento
TipoAccion=Expresion
Activo=S
Visible=S























































































































































































ConCondicion=S
EjecucionConError=S
Multiple=S
ListaAccionesMultiples=(Lista)

EjecucionCondicion=Asigna(Info.Cerrado,SQL(<T>SELECT dbo.fnPOSEstatusCajaBloqueada(:tCaja)<T>,Info.CtaCaja))<BR>NO(Info.Cerrado)
EjecucionMensaje=<T>Caja Bloqueada<T>
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

Expresion=Asigna(Info.MovClaveAfecta, SQL(<T>SELECT mt.Clave FROM POSL p INNER JOIN MovTipo mt ON p.Mov = mt.Mov AND mt.Modulo = :tPOS WHERE p.ID = :tID<T>, <T>POS<T>, Info.IDTexto))<BR>Asigna(Info.Mensaje,Nulo)<BR>Asigna(Info.IDTextoAnterior, Info.IDTexto)<BR>Asigna(Info.POSMonedero,Nulo)<BR>EjecutarSQL(<T>spPOSOfertaPuntosImporte :tEmpresa,:nEstacion,:tID<T>,Empresa, EstacionTrabajo, Info.IDTexto)<BR>Asigna(Info.POSRedondeo, SQL(<T>EXEC spPOSVentaInsertaRedondeo :tID, :tTipo<T>, Info.IDTexto, <T>SUGERIR<T>))<BR>Asigna(Info.POSRedondeo2,0.0)  <BR>EjecutarSQL(<T>spPOSVentaInsertaRedondeo :tID,:tTipo,:nImporte<T>,Info.IDTexto,<T>ELIMINAR COBRO<T>,Nulo)<BR>Asigna(Info.Acumulativa,SQL(<T>SELECT RedondeoVenta FROM POSCfg WHERE Empresa = :tEmpresa<T>,Empresa))<BR>Asigna(Info.Codigo, SQL(<T>SELECT Codigo FROM CB WHERE Accion = :tAccion<T>, <T>CONCLUIR MOVIMIENTO<T>))<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tFormaCambio, :nCambio, :nCobro, :nLecturaTarjeta, :tCliente, :tMonedero<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto, Info.Importe, Info.FormaPagoCambio, Info.Cambio, 0, Nulo, Nulo, Info.POSMonedero))<BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Info.POSImporteOferta,Nulo)<BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR><BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>/*Si ConDatos(Info.Observaciones)<BR>  Entonces Informacion(Info.Observaciones )<BR>Sino <T><T><BR>  Fin<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])                                                            <BR>Asigna(Info.Importe, Temp.Reg[9])<BR><BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR>Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>Asigna(Ver.Expresion2, TextoEnLista(Temp.Reg[20]))<BR>Si ConDatos(Ver.Expresion)<BR>Entonces Reexpresa( Ver.Expresion )<BR>Fin<BR>SI(ConDatos(Ver.Expresion2),Reexpresa( Ver.Expresion2 ))<BR><BR>Asigna(Ver.Expresion, Nulo)<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tFormaCambio, :nCambio, :nCobro, :nLecturaTarjeta, :tCliente, :tMonedero,:nImporteRef<T>, EstacionTrabajo, NULO, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto,Nulo, Info.FormaPagoCambio, Info.Cambio, 1, Nulo, Nulo, Info.POSMonedero,NULO))<BR><BR> Si(Info.MovClaveAfecta EN(<T>POS.N<T>,<T>POS.F<T>),Si(ConDatos(Info.Mensaje),Asigna(Ver.Aviso,Ver.Aviso+NuevaLinea+Info.Mensaje)))<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>/*Cuando hay una expresion de regreso la ejecuta*/<BR>Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>Asigna(Ver.Expresion2, TextoEnLista(Temp.Reg[20]))<BR>Si ConDatos(Ver.Expresion)<BR>Entonces Reexpresa( Ver.Expresion )<BR>Fin<BR><BR><BR>Asigna(Ver.Expresion, Nulo)<BR>Asigna(Ver.Expresion2, Nulo)
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























































[Codigo.Ver.Aviso]
Carpeta=Codigo
Clave=Ver.Aviso
Editar=N
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=80
ColorFondo=$FFFFFFFF

ColorFuente=Lima






AccionAlEnter=Cerrar
[Codigo.Info.Importe]
Carpeta=Codigo
Clave=Info.Importe
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
AccionAlEnter=Afectar
Tamano=80
ColorFondo=$00FFE8E8















































ColorFuente=Rojo obscuro

[Acciones.Cerrar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Cerrar.expresion]
Nombre=expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=EjecutarSQL( <T>spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto )
[Acciones.Cerrar]
Nombre=Cerrar
Boton=21
NombreEnBoton=S
NombreDesplegar=Cerrar
Multiple=S
TipoAccion=ventana
ClaveAccion=Cerrar
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S









EnMenu=S

ConCondicion=S
EjecucionConError=S
EjecucionCondicion=SQL(<T>SELECT ISNULL(SUM(ISNULL(Importe,0)),0) FROM POSLCObro pc WHERE pc.ID =:tID<T>, Info.IDTexto) = 0
EjecucionMensaje=<T>El Movimiento Tiene Aplicaciones.. Tiene que concluirlo o Reversar el Pago Verifique.....<T>
[Acciones.F2]
Nombre=F2
Boton=-1
NombreDesplegar=Info.POSFormaPago2
TipoAccion=Expresion
Activo=S
Visible=S

















EnMenu=S


























































EnBarraAcciones=S






















































UsaTeclaRapida=S
TeclaRapida=F2
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(F2, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.F3]
Nombre=F3
Boton=0
NombreDesplegar=Info.POSFormaPago3
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S





















UsaTeclaRapida=S
TeclaRapida=F3
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(F3, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.F4]
Nombre=F4
Boton=0
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S



NombreDesplegar=Info.POSFormaPago4
UsaTeclaRapida=S
TeclaRapida=F4
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(F4, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.F5]
Nombre=F5
Boton=0
EnMenu=S
TipoAccion=Expresion
Visible=S



NombreDesplegar=Info.POSFormaPago5
UsaTeclaRapida=S
TeclaRapida=F5
Activo=S
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(F5, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.F6]
Nombre=F6
Boton=0
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S















NombreDesplegar=Info.POSFormaPago6
UsaTeclaRapida=S
TeclaRapida=F6
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(F6, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.F7]
Nombre=F7
Boton=0
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S



NombreDesplegar=Info.POSFormaPago7
UsaTeclaRapida=S
TeclaRapida=F7
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(F7, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.F8]
Nombre=F8
Boton=0
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S

NombreDesplegar=Info.POSFormaPago8









































































UsaTeclaRapida=S
TeclaRapida=F8
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(F8, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin

[Acciones.BancoA01]
Nombre=BancoA01
Boton=0
Menu=Especial 1
NombreDesplegar=Info.BancoA01
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoA01, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.BancoA02]
Nombre=BancoA02
Boton=0
Menu=Especial 1
NombreDesplegar=Info.BancoA02
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoA02, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.BancoA03]
Nombre=BancoA03
Boton=0
Menu=Especial 1
NombreDesplegar=Info.BancoA03
EnMenu=S
Activo=S
Visible=S













TipoAccion=Expresion
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoA03, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.BancoA04]
Nombre=BancoA04
Boton=0
Menu=Especial 1
NombreDesplegar=Info.BancoA04
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoA04, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.BancoA05]
Nombre=BancoA05
Boton=0
Menu=Especial 1
NombreDesplegar=Info.BancoA05
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoA05, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.BancoA06]
Nombre=BancoA06
Boton=0
Menu=Especial 1
NombreDesplegar=Info.BancoA06
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoA06, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.BancoA07]
Nombre=BancoA07
Boton=0
Menu=Especial 1
NombreDesplegar=Info.BancoA07
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoA07, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.BancoA08]
Nombre=BancoA08
Boton=0
Menu=Especial 1
NombreDesplegar=Info.BancoA08
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoA08, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.BancoB01]
Nombre=BancoB01
Boton=0
Menu=Especial 2
NombreDesplegar=Info.BancoB01
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoB01, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.BancoB02]
Nombre=BancoB02
Boton=0
Menu=Especial 2
NombreDesplegar=Info.BancoB02
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoB02, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.BancoB03]
Nombre=BancoB03
Boton=0
Menu=Especial 2
NombreDesplegar=Info.BancoB03
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoB03, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.BancoB04]
Nombre=BancoB04
Boton=0
Menu=Especial 2
NombreDesplegar=Info.BancoB04
EnMenu=S
TipoAccion=expresion
Activo=S
Visible=S




Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoB04, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.BancoB05]
Nombre=BancoB05
Boton=0
Menu=Especial 2
NombreDesplegar=Info.BancoB05
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoB05, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.BancoB06]
Nombre=BancoB06
Boton=0
Menu=Especial 2
NombreDesplegar=Info.BancoB06
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoB06, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.BancoB07]
Nombre=BancoB07
Boton=0
Menu=Especial 2
NombreDesplegar=Info.BancoB07
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoB07, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.BancoB08]
Nombre=BancoB08
Boton=0
Menu=Especial 2
NombreDesplegar=Info.BancoB08
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoB08, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.BancoC01]
Nombre=BancoC01
Boton=0
Menu=Especial 3
NombreDesplegar=Info.BancoC01
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoC01, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.BancoC02]
Nombre=BancoC02
Boton=0
Menu=Especial 3
NombreDesplegar=Info.BancoC02
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoC02, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.BancoC03]
Nombre=BancoC03
Boton=0
Menu=Especial 3
NombreDesplegar=Info.BancoC03
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoC03, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.BancoC04]
Nombre=BancoC04
Boton=0
Menu=Especial 3
NombreDesplegar=Info.BancoC04
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoC04, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.BancoC05]
Nombre=BancoC05
Boton=0
Menu=Especial 3
NombreDesplegar=Info.BancoC05
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoC05, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.BancoC06]
Nombre=BancoC06
Boton=0
Menu=Especial 3
NombreDesplegar=Info.BancoC06
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoC06, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.BancoC07]
Nombre=BancoC07
Boton=0
Menu=Especial 3
NombreDesplegar=Info.BancoC07
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoC07, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.BancoC08]
Nombre=BancoC08
Boton=0
Menu=Especial 3
NombreDesplegar=Info.BancoC08
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




























































































































Expresion=Asigna(Info.Codigo,SQL(<T>SELECT NULLIF(BancoC08, :tnulo) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR>Si<BR>  ConDatos(Info.Codigo)<BR>Entonces<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>  Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>  Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>  Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR>  Si<BR>    ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>  Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>  Fin<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Si(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Si<BR>    Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>  Entonces<BR>    FormaModal(<T>POSPesar<T>)<BR>    EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>  Fin<BR>Sino<BR>  Informacion(<T>OPCIÓN VACIA, SELECCIONE OTRA OPCIÓN<T>)<BR>Fin
[Acciones.Afectar.VerTicket]
Nombre=VerTicket
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Ver.Ticket, <T><T>)
Activo=S
Visible=S


[Acciones.Extra1]
Nombre=Extra1
Boton=0
EnMenu=S




NombreDesplegar=Introduce Concepto
EspacioPrevio=S
TipoAccion=Expresion














































Activo=S












Visible=S



















Expresion=Si<BR>  SQL(<T>SELECT 1 FROM POSUsuarioAccion WHERE Usuario = :tUsuario AND Accion = :tAccion<T>, Usuario, <T>INTRODUCIR CONCEPTODIN<T>) = 1<BR>Entonces<BR>  Asigna(Temp.TextoTemp02, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>INTRODUCIR CONCEPTODIN<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp02, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Temp.TextoTemp02, nulo)<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso a la acción<T>)<BR>Fin














[Codigo.ListaEnCaptura]
(Inicio)=Info.Codigo
Info.Codigo=Info.Importe
Info.Importe=Ver.Aviso
Ver.Aviso=(Fin)












































[Acciones.Reversar]
Nombre=Reversar
Boton=0
NombreDesplegar=Reversar Cobro
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
















Expresion=Si<BR>  SQL(<T>SELECT 1 FROM POSUsuarioAccion WHERE Usuario = :tUsuario AND Accion = :tAccion<T>, Usuario, <T>REVERSAR COBRO<T>) = 1<BR>Entonces<BR>  Asigna(Temp.TextoTemp02, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>REVERSAR COBRO<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp02, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  //Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Temp.TextoTemp02, nulo)<BR>  Forma(<T>POSCBFormaPagoLista<T>)<BR>  Forma.Accion(<T>Enter<T>)<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso a la acción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[POSCBFormaPago.Columnas]
Codigo=100








0=-2
FormaPago=172
[Acciones.Cerrar.ListaAccionesMultiples]
(Inicio)=expresion
expresion=Cerrar
Cerrar=(Fin)






















[Acciones.Afectar.ListaAccionesMultiples]
(Inicio)=ValidarSeries
ValidarSeries=Afectar
Afectar=VerTicket
VerTicket=(Fin)




















































[Forma.ListaCarpetas]
(Inicio)=Ticket
Ticket=Codigo
Codigo=(Fin)

[Forma.ListaAcciones]
(Inicio)=F2
F2=F3
F3=F4
F4=F5
F5=F6
F6=F7
F7=F8
F8=Reversar
Reversar=Cerrar
Cerrar=Extra1
Extra1=Enter
Enter=Afectar
Afectar=BancoA01
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
BancoC08=(Fin)

[Forma.MenuPrincipal]
(Inicio)=Principal
Principal=Especial 1
Especial 1=Especial 2
Especial 2=Especial 3
Especial 3=(Fin)
