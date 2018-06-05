
[Forma]
Clave=POSVerificador
Icono=0
Modulos=(Todos)
Nombre=Verificado

ListaCarpetas=(Lista)
CarpetaPrincipal=Verificador
PosicionInicialAlturaCliente=681
PosicionInicialAncho=850
AccionesTamanoBoton=15x5
ListaAcciones=(Lista)
PosicionInicialIzquierda=535
PosicionInicialArriba=160
PosicionSec1=410
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
AccionesDivision=S
AccionesCentro=S
Menus=S
PosicionCol2=494
VentanaSinIconosMarco=S
VentanaColor=$00804000
ExpresionesAlMostrar=Asigna(Info.Codigo, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>VERIFICAR PRECIOS<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.Codigo, nulo)<BR>  Asigna(Info.Dato, <T>SI<T>)<BR><BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
ExpresionesAlCerrar=Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Nulo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR><BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])                  <BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>/*Asigna(Ver.Saldo, TextoEnLista(Temp.Reg[10]))*/<BR><BR>SI(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR><BR><BR><BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR><BR>Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>Asigna(Info.CtaCaja,Temp.Reg[18])<BR>Asigna(Info.Grupo,Temp.Reg[19])<BR>Asigna(Info.Dato, nulo)<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
ExpresionesAlActivar=Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[Verificador]
Estilo=Ficha
Clave=Verificador
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Segoe UI, 12, Blanco, [Negritas]}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaColorFondo=Negro
ListaEnCaptura=Ver.Ticket

AlinearTodaCarpeta=S
ConFuenteEspecial=S
[Verificador.Ver.Ticket]
Carpeta=Verificador
Clave=Ver.Ticket
Editar=S
LineaNueva=S
ValidaNombre=N
3D=N
Tamano=20
ColorFondo=Blanco

[Acciones.expresion]
Nombre=expresion
Boton=0
NombreDesplegar=expresion
TipoAccion=Expresion
Activo=S
Visible=S



Multiple=S
ListaAccionesMultiples=(Lista)
[Verificador.ListaEnCaptura]
(Inicio)=Ver.Ticket
Ver.Ticket=Info.Codigo
Info.Codigo=(Fin)

[Codigo]
Estilo=Ficha
Clave=Codigo
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=(Variables)
Fuente={Segoe UI, 18, Blanco, []}
CampoColorLetras=Rojo obscuro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

PermiteEditar=S
ConFuenteEspecial=S
FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaColorFondo=$00804000
BarraBotones=S
ListaAccionesBB=(Lista)
BarraBtnFuente={Segoe UI, 12, Blanco, []}
BarraBtnFondo=$00804000
BarraBtnPosicion=Abajo
BarraBtnSize=80
BarraBtnSeparacion=2
BarraBtnSinBisel=S
BarraBtnBisel=0
BarraBtnPaginas=1
CampoAccionAlEnter=expresion
[Codigo.Info.Codigo]
Carpeta=Codigo
Clave=Info.Codigo
Editar=S
LineaNueva=S
ValidaNombre=N
3D=N
AccionAlEnter=expresion
Tamano=30
ColorFuente=Rojo obscuro


























ColorFondo=Blanco
AccionAlEnterBloquearAvance=S
[Codigo.Ver.Aviso]
Carpeta=Codigo
Clave=Ver.Aviso
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=$00FFFF80




ColorFuente=$008080FF
[Acciones.Expresion2]
Nombre=Expresion2
Boton=0
NombreDesplegar=Expresion2
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=Asigna(Info.Codigo, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>VERIFICAR PRECIOS<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.Codigo, nulo)<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[Codigo.Info.Importe]
Carpeta=Codigo
Clave=Info.Importe
Editar=S
LineaNueva=N
ValidaNombre=N
3D=N
AccionAlEnter=Expresion2
Tamano=-1
ColorFondo=Blanco







Pegado=S






[Acciones.expresion.expresion1]
Nombre=expresion1
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=EjecutarSQL(<T>EXEC spPOSVerificadorPreciosInsertaAccion :tID, :tCodigo<T>, Info.IDTexto, Info.Codigo)<BR><BR>Asigna(Temp.Logico,SQL(<T>SELECT dbo.fnPOSValidarBloquearCaja(:tCodigo)<T>,Info.Codigo))<BR>Si(Temp.Logico,FormaModal(<T>POSMovAutorizar<T>))<BR><BR>Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR>Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR><BR>Si Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T><BR>Entonces<BR>FormaModal(<T>POSPesar<T>)<BR>EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>Fin<BR><BR><BR>SI(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR><BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR><BR>Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>Asigna(Info.CtaCaja,Temp.Reg[18])<BR>Asigna(Info.Grupo,Temp.Reg[19])<BR><BR><BR>Si<BR>  ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>Fin<BR><BR><BR><BR>Asigna(Info.Cliente,Nulo)  <BR>/*Cuando hay una expresion de regreso la ejecuta*/<BR>Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>Si ConDatos(Ver.Expresion)<BR>Entonces<BR>  Reexpresa( Ver.Expresion )<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta, :tCliente<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo, Info.Cliente))<BR>  Asigna(Info.Cliente,Nulo)<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  SI(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>Fin<BR><BR>Si ConDatos(Ver.Expresion)<BR>Entonces<BR>  Reexpresa( Ver.Expresion )<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta, :tCliente<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo, Info.Cliente))<BR>  Asigna(Info.Cliente,Nulo)<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  SI(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>Fin<BR>Asigna(Ver.Expresion, Nulo)
[Acciones.expresion.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S


[Acciones.Salir]
Nombre=Salir
Boton=63
NombreDesplegar=&Salir
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S







































































































Multiple=S
ListaAccionesMultiples=Cerrar

Visible=S
[Imagen]
Estilo=Ficha
Clave=Imagen
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S

FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaColorFondo=Negro
ListaEnCaptura=Info.POSLogo


AlinearTodaCarpeta=S


[Imagen.Info.POSLogo]
Carpeta=Imagen
Clave=Info.POSLogo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=N
Tamano=20
ColorFondo=Blanco








































[Acciones.Salir.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S






[Acciones.Salir.ListaAccionesMultiples]
(Inicio)=expresion
expresion=Cerrar
Cerrar=(Fin)











[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Salir<T>
TipoAccion=Ventana
ClaveAccion=Cerrar
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
TeclaFuncion=ESC




[Acciones.Espacio]
Nombre=Espacio
Boton=0
NombreDesplegar=<T>Espacio<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=15
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=1













































[Codigo.ListaEnCaptura]
(Inicio)=Info.Codigo
Info.Codigo=Info.Importe
Info.Importe=Ver.Aviso
Ver.Aviso=(Fin)

[Codigo.ListaAccionesBB]
(Inicio)=Espacio
Espacio=Cerrar
Cerrar=(Fin)
















[Acciones.expresion.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=expresion1
expresion1=(Fin)









[Forma.ListaCarpetas]
(Inicio)=Verificador
Verificador=Imagen
Imagen=Codigo
Codigo=(Fin)

[Forma.ListaAcciones]
(Inicio)=expresion
expresion=Expresion2
Expresion2=Salir
Salir=(Fin)
